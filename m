Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0937BCD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F7210E665;
	Thu, 11 Jun 2026 19:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ddjh61dx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF46B10E665
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 19:01:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 834F844304;
 Thu, 11 Jun 2026 19:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208C31F000E9;
 Thu, 11 Jun 2026 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781204482;
 bh=B1gGSq4M+Oo4WefRsKZvJ4V4X6Qi/uXLlI1VstV5e8o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ddjh61dxqq0ldnrSnyKYT1c9cHp49mneFMhx5IFNcLXVWQ/g8P1FHTVmyMhZEi/mG
 /ibXF/Q+3FljS6usUc3lX4ppjKX1e6o/FULhdKVy6PeMwZ3p6/sNLghaRS/WER4bRg
 DEP0zsKDVY/jCJJ8dh3qKmq3xnuGomiB32BQNnwYmrf/FIVrhGMCAeMwF2ISLjfw6S
 yxZAxRf/TcdK8Zj0KV2oJUA9likuANCMbi9/zg8l0nDnJuLc7nkSWWWGUGKkot481G
 yhjXqqcfnpTWmtvFGRTGNnzFYeKYfoe1RAAGB9zyOrxi5cEsCEnJXJy5eyk5jR/esY
 8Od5cK2OIlVxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/20] rust: dma: drop `dma_read!` and `dma_write!` API
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260611-io_projection-v4-18-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-18-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 19:01:21 +0000
Message-Id: <20260611190122.208C31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removal of `dma_read!` and `dma_write!` breaks compilation for `dri=
vers/gpu/nova-core`.
--

commit 144cedc7de039fdec7f07bf6a514886b83913697
Author: Gary Guo <gary@garyguo.net>

rust: dma: remove dma_read! and dma_write!

The primitive read/write use case is covered by the io_read! and
io_write! macro. The non-primitive use case was finicky; they should
either be achieved using CoherentBox or as_ref()/as_mut() to assert the
lack of concurrent access, or should be using memcpy-like APIs to express
the non-atomic and tearable nature.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index ab6504910e4f..0ff4cce8e809 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs

[ ... ]

> @@ -1265,85 +1219,3 @@ fn as_view(self) -> CoherentView<'a, Self::Target>=
 {
>          }
>      }
>  }
> -
> -/// Reads a field of an item from an allocated region of structs.

[Severity: Low]
Does removing these macros break the build for drivers/gpu/nova-core?

Looking at drivers/gpu/nova-core/gsp/cmdq.rs:DmaGspMem::new(), it appears to
still rely on dma_write!:

    dma_write!(gsp_mem, .ptes.0[build: i], PteArray::<0>::entry(start, i)?);

Similarly, in drivers/gpu/nova-core/gsp/fw.rs:gsp_write_ptr():

    dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES

Could these users in nova-core be migrated to io_read! and io_write! in this
patch to prevent bisect breakage?

> -///
> -/// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma`=
 is an expression evaluating
> -/// to a [`Coherent`] and `proj` is a [projection specification](kernel:=
:ptr::project!).
> -///
> -/// # Examples
> -///

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D18
