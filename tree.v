Inductive tree (X : Type) : Type :=
  | empty : tree X
  | node : X -> tree X -> tree X -> tree X.

Arguments empty {X}.
Arguments node {X} _ _ _.

Definition leaf {X : Type} (n: X) : tree X :=
  node n empty empty.

Fixpoint size {X : Type} (t : tree X) : nat :=
  match t with
  | empty      => 0
  | node _ l r => 1 + (size l) + (size r)
  end.

Fixpoint depth {X : Type} (t : tree X) : nat :=
  match t with
  | empty      => 0
  | node _ l r => 1 + max (depth l) (depth r)
  end.

Inductive non_empty {X : Type} : tree X -> Prop :=
  non_empty_node : forall x l r, non_empty (node x l r).

Inductive full {X : Type} : tree X -> Prop :=
  | full_empty : full empty
  | full_leaf : forall x, full (node x empty empty)
  | full_node : forall x l r,
      non_empty l -> full l ->
      non_empty r -> full r -> full (node x l r).

(** Tests **)

Theorem test_full1: forall {X : Type}, full (empty : tree X).
Proof. intros. apply full_empty. Qed.

Theorem test_full2: full (leaf 1).
Proof. intros. apply full_leaf. Qed.

Theorem test_full3: full (node 1 (leaf 2) (leaf 3)).
Proof. intros. apply full_node.
 apply non_empty_node. apply full_leaf.
 apply non_empty_node. apply full_leaf.
Qed.

Example test_size1: size (node 0 empty (leaf 1)) = 2.
Proof. reflexivity. Qed.

Example test_depth1: depth (node 0 (node 2 empty empty) (node 1 empty empty)) = 2.
Proof. reflexivity. Qed.