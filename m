Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B01606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5ft3908
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946C810F6AF;
	Tue,  3 Nov 2026 15:46:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D3310F6A4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:46:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 603A660A7F;
 Tue,  3 Nov 2026 15:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A581F000C1;
 Tue,  3 Nov 2026 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793720759;
 bh=r9uNT7Sabpf/JpfrG0XT1JzcNU1x+Ccuei2+9s7QWgc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H5ft3908ku5pT0zvbCfiIaGSoWItjZ0ZVBaRTDqxRzPxYsAom94H+ENuGGTQwKkpP
 HltXBPFoq5HbPr2pCIlvV6BrSznW8WwXfP0ZlYnLZa4/QlhH8E8YybbBByllKw6q6P
 c1h3arWTXqB8cEsKWrbT6iFN6LgqN1tNotVwwX1TnZjc5q0km964MabM73LxkX8zdM
 SGpk67t3H/+/LItbqjyirF5kZxnmcd0DXKiGEzcSR3jPLT0j/vRXLEZEh9GI/GHUO/
 VN0xj3m/NSLZfEGrkIrtbOAzGxOfAMkCE2GbGyiJkZkwL8R8KkY93Eu+0qD3+0UslU
 vwXUTVAoweVSw==
Message-ID: <sashiko-outbox-195649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 5/8] rust: DmaFence: Replace is_signaled() with
 status()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261103153138.1087330-7-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
 <20261103153138.1087330-7-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:45:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: dma_fence: unstable assert_matches in doctest breaks KUnit bu=
ild
--

commit 1a1a7bd301271b4681c7504f6e6f60ca7abd6bb7
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Replace is_signaled() with status()

This commit replaces Fence::is_signaled() with Fence::status() returning a
FenceStatus enum so callers must check whether a signaled fence completed w=
ith
an error while holding the fence lock.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index fbbc6ab202eca..9cef604f17ea9 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> @@ -650,11 +658,15 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCo=
ntextOps> {
>  ///         FenceContextOps,
>  ///         FenceCallback,
>  ///         FenceCallbackRegistration,
> +///         FenceStatus, //
>  ///     },
>  ///     str::CString,
>  ///     sync::aref::ARef, //
>  /// };
> -/// use core::fmt::Display;
> +/// use core::{
> +///     assert_matches,
> +///     fmt::Display, //
> +/// };
>  ///
>  /// struct CallbackData { }
>  ///
> @@ -700,9 +712,9 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCont=
extOps> {
>  /// let cb_reg =3D KBox::pin_init(cb_reg, GFP_KERNEL)?;
>  ///
>  /// // TODO signalling guards
> -/// assert_eq!(waiting_fence.is_signaled(), false);
> +/// assert_matches!(waiting_fence.status(), FenceStatus::Unsignaled);
>  /// fence.signal(Ok(()));
> -/// assert_eq!(waiting_fence.is_signaled(), true);
> +/// assert_matches!(waiting_fence.status(), FenceStatus::Signaled(Ok(())=
));

[Severity: Low]
Does using core::assert_matches in the DriverFence doctest break the build =
when
CONFIG_RUST_KERNEL_DOCTESTS=3Dy and CONFIG_DMA_SHARED_BUFFER=3Dy are enable=
d?

When CONFIG_RUST_KERNEL_DOCTESTS=3Dy is set, scripts/rustdoc_test_gen extra=
cts
this doctest into rust/doctests_kernel_generated.rs, which is compiled using
rust_common_cmd in scripts/Makefile.build:

    rust_allowed_features :=3D arbitrary_self_types,asm_goto,generic_arg_in=
fer,used_with_arg

Because assert_matches is an unstable library feature in core that is not in
rust_allowed_features and feature(assert_matches) is not enabled for the
doctest crate, compiling rust/doctests_kernel_generated.o fails with
error[E0658].

Would it work to use assert!(matches!(...)) instead, or derive PartialEq an=
d Eq
on FenceStatus so assert_eq! can be used with the KUnit doctest assertion
macros?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103153138.1087=
330-2-phasta@kernel.org?part=3D5
