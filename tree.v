Require Import Coq.Numbers.Natural.Peano.NPeano.

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

Theorem tree_size_min : forall {X : Type} (t : tree X),
  depth t <= size t.
Proof.
  intros. induction t.
    simpl. reflexivity.
    simpl. apply Le.le_n_S. apply Nat.max_lub.
      apply Plus.le_plus_trans. auto.
      rewrite Plus.plus_comm.
      apply Plus.le_plus_trans. auto.
Qed.

SearchAbout mult.

Theorem tree_size_max : forall {X : Type} (t : tree X),
  size t + 1 <= 2 ^ (depth t).
Proof.
  intros. induction t.
    simpl. reflexivity.
    simpl. rewrite <- plus_n_O. apply Nat.max_lub.


Inductive non_empty {X : Type} : tree X -> Prop :=
  non_empty_node : forall x l r, non_empty (node x l r).

Inductive full {X : Type} : tree X -> Prop :=
  | full_empty : full empty
  | full_leaf : forall x, full (leaf x)
  | full_node : forall x l r,
      non_empty l -> full l ->
      non_empty r -> full r -> full (node x l r).

Inductive perfect {X : Type} : tree X -> Prop :=
  | perfect_empty : perfect empty
  | perfect_node : forall x l r,
      non_empty l -> perfect l ->
      non_empty r -> perfect r -> size l = size r -> perfect (node x l r).

Theorem perfect_implies_full : forall {X : Type} (t : tree X),
  perfect t -> full t.
Proof.
  intros. induction H.
    constructor. constructor.
    auto. auto. auto. auto.
Qed.

Theorem size_of_perfect : forall {X : Type} (t : tree X),
  perfect t -> size t = 2 ^ (depth t) - 1.
Proof.
  intros. induction H.
    simpl. reflexivity.
    
    simpl. rewrite IHt1. rewrite IHt2. simpl. rewrite IHperfect2.
    simpl.
    
      simpl. reflexivity.


    unfold size. simpl.
    destruct H.
      simpl. reflexivity.
      simpl. reflexivity.
Admitted.

(** Tests **)

Theorem test_full1 : forall {X : Type}, full (empty : tree X).
Proof. intros. apply full_empty. Qed.

Theorem test_full2 : full (leaf 1).
Proof. intros. apply full_leaf. Qed.

Theorem test_full3 : full (node 1 (leaf 2) (leaf 3)).
Proof. intros. apply full_node.
 apply non_empty_node. apply full_leaf.
 apply non_empty_node. apply full_leaf.
Qed.

Example test_size1 : size (node 0 empty (leaf 1)) = 2.
Proof. reflexivity. Qed.

Example test_depth1 : depth (node 0 (node 2 empty empty) (node 1 empty empty)) = 2.
Proof. reflexivity. Qed.
