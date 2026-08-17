Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC82C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4131810E76D;
	Mon, 17 Aug 2026 11:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l8RXhOZ4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF8610E76D
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:49:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E66542DCB;
 Mon, 17 Aug 2026 11:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073AB1F000E9;
 Mon, 17 Aug 2026 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786967398;
 bh=guW2WBDboj42EK2iN0ZP3oPlaBQsI+4oj5DNVjnNpGE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l8RXhOZ4c6I+ymq+OcGpuw4BPMvWUAg2ST0/ZHO9PyRi4ZlroO+kzGbTMZd/4g22O
 Be3hfoCu6SwmejcBtSpIzDnDjnrxbFZ9YQZvYEm40s45cOsKytNirDK7NUC0sTt+0X
 yBE5qgTPW/ccdyKv/XE9AuvBi/drlh4l+s1s+tv1Ys0Ex4SHgfQDkSNHJBMMpUTbwo
 y0WT5LPvj4e5XOhvxlMiA7nqM0qtZ/E8J6TYQ44H3zbKAB1RdOGmoE0kk57is2LZqC
 OmBjuQxk9lY29nmCd13c0Hl+wEp8OEcKvmzLUoOsd9mJx0zQqwtX0tl6LsuDEJKTyU
 vNcApIOsfQ4dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] rust: of: add Node type
To: "Albert Esteve" <aesteve@redhat.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260817-drm_panel_bindings-v1-1-1f974508a31c@redhat.com>
References: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
 <20260817-drm_panel_bindings-v1-1-1f974508a31c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 11:49:57 +0000
Message-Id: <20260817114958.073AB1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] The `# Safety` section of `Node::from_raw` fails to enforce a po=
sitive reference count, and the function is missing the mandatory `// INVAR=
IANT:` comment.
- [Medium] The `Node` type lacks explicit `Send` and `Sync` trait implement=
ations.
- [Low] Missing `#[inline]` annotations on small forwarding abstraction fun=
ctions.
- [Low] Violation of the kernel vertical import style.
- [Low] `Node` is incorrectly documented as wrapping a pointer.
--

--- Patch [1]: [PATCH 1/5] rust: of: add Node type ---
commit 61d64a4023f5c5b35bf62557893fca7718f72090
Author: Albert Esteve <aesteve@redhat.com>

rust: of: add Node type

This commit introduces a Rust abstraction for the device tree node type. It
wraps the device_node struct and implements the AlwaysRefCounted trait,
allowing safe ownership and reference counting of device tree nodes in Rust.
It also adds C helpers to access the reference counting functions.

> Node wraps device_node type pointer and implements
> AlwaysRefCounted, allowing owned references to device
> tree nodes to be held.

[Severity: Low]
This isn't a bug, but could this description cause confusion?=20

The commit message and the invariants section state that Node wraps a=20
pointer, but the struct actually wraps Opaque<bindings::device_node>. This=
=20
represents the struct itself rather than a pointer to it, which might confu=
se=20
whether it is meant to be passed by value or strictly by reference.

> diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> index 58b20c367f993..e75ab81cfe1f7 100644
> --- a/rust/kernel/of.rs
> +++ b/rust/kernel/of.rs
> @@ -6,7 +6,10 @@
>      bindings,
>      device_id::{RawDeviceId, RawDeviceIdIndex},
>      prelude::*,
> +    sync::aref::AlwaysRefCounted,
> +    types::Opaque,
>  };
> +use core::ptr::NonNull;

[Severity: Low]
This isn't a bug, but does this import ordering follow the kernel vertical=
=20
import style?=20

Standard library imports like core::ptr::NonNull are typically placed befor=
e=20
the crate imports and separated by a blank line.

> +
> +/// A device tree node (struct device_node).
> +///
> +/// # Invariants
> +///
> +/// The inner pointer is always a valid, non-null pointer to a struct de=
vice_node
> +/// with a positive reference count.
> +#[repr(transparent)]
> +pub struct Node(Opaque<bindings::device_node>);

[Severity: Medium]
Are we missing explicit Send and Sync trait implementations for Node?

Since Node wraps Opaque<bindings::device_node>, it defaults to not=20
implementing Send and Sync. Device Tree nodes use thread-safe atomic refere=
nce=20
counting and are safe to share across threads. Without explicit Send and Sy=
nc=20
implementations, ARef<Node> cannot be passed across thread boundaries or us=
ed=20
in concurrent driver structures.

> +impl Node {
> +    /// Creates a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// ptr must be a valid, non-null struct device_node pointer that re=
mains
> +    /// valid for the lifetime 'a.
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::device_node) -> &'a=
 Self {

[Severity: Medium]
Should the safety documentation for from_raw require that the pointer has a
positive reference count?

The type invariant for Node strictly requires a positive reference count, b=
ut=20
the safety preconditions here omit this requirement. A caller could pass a=
=20
valid but zero-refcount pointer, complying with the safety contract but=20
violating the type invariant. If this is later converted to an owned ARef,=
=20
inc_ref will call of_node_get on a node with a zero refcount.

[Severity: Low]
This isn't a bug, but are we missing the #[inline] annotation on this small=
=20
forwarding abstraction function?

> +        // SAFETY: Caller guarantees ptr is valid and lives for 'a.
> +        unsafe { &*ptr.cast() }
> +    }

[Severity: Medium]
Are we missing the mandatory // INVARIANT: comment here when casting to the=
=20
struct, as required by the Rust subsystem guidelines?

> +
> +    /// Returns the raw pointer to the underlying struct device_node.
> +    pub fn as_raw(&self) -> *const bindings::device_node {
> +        self.0.get() as _
> +    }
> +}

[Severity: Low]
This isn't a bug, but should this small getter function be annotated with=20
#[inline]?

> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for Node {
> +    fn inc_ref(&self) {

[Severity: Low]
This isn't a bug, but should this forwarding abstraction method be annotate=
d=20
with #[inline]?

> +        // SAFETY: The type invariant guarantees the pointer is valid.
> +        unsafe { bindings::of_node_get(self.as_raw().cast_mut()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {

[Severity: Low]
This isn't a bug, but should this forwarding abstraction method be annotate=
d=20
with #[inline]?

> +        // SAFETY: The safety requirements guarantee that the refcount i=
s non-zero.
> +        unsafe { bindings::of_node_put(obj.cast().as_ptr()) };
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-drm_panel_=
bindings-v1-0-1f974508a31c@redhat.com?part=3D1
