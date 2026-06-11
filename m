Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD24CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 00:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275A210EC5D;
	Thu, 11 Jun 2026 00:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ffEGRsDp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7E710EC2A
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:12:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E648B40B6F;
 Thu, 11 Jun 2026 00:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16811F00893;
 Thu, 11 Jun 2026 00:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781136760;
 bh=DGDcO9L1jWeup9XssCflu/SK2Wkx8UJhMiw40oSLxuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ffEGRsDpF1qIfnQcyM3ek4Mm5kHaD5hPlvvwpzjAnwyODqxKiD2g+Aur7Ua+BfUw9
 +hj8kiLzp7n1r2Tz9PQcdaU1MFiMvva7nV6/srofZiLmm4z4jd0hAzfZbdKNzCevkn
 aFKjOEcyMQ4XQOX/w41i6ebGaxtO3/NhYCgVs6cRiRcYIq7/rOswyYWCwsX11B2szB
 5XuIfIKgiXuaiq8Q9EniNHQ2zb+IstdTXa39tgHC7ox1stER65rFJr0AOEQu7K6pwL
 KpOcpeYvE+leh4C7LH3VihlJYQz7U5weh5ymYOdHfoNJJMC3pTNQVyygQhwzl4i6uq
 xBSY6cElX0pCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: drm: gpuvm: add SmContext lifetime bound
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260610-gpuvm_smcontext_lifetime_bound_v1-v1-1-531e7d2ee7b4@collabora.com>
References: <20260610-gpuvm_smcontext_lifetime_bound_v1-v1-1-531e7d2ee7b4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 00:12:40 +0000
Message-Id: <20260611001240.A16811F00893@smtp.kernel.org>
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
- [Low] The `SmMapData` struct fails to compile because it lacks the `T: 'c=
tx` bound required by its `sm_data` field.
--

commit 79bf9106553be7b558ccc116bf8b7922eb388043
Author: Boris Brezillon <boris.brezillon@collabora.com>

rust: drm: gpuvm: add SmContext lifetime bound

This commit adds a Self: 'ctx bound to DriverGpuVm::SmContext<'ctx> and
propagates it as T: 'ctx to the GPUVM state machine helper types. This allo=
ws
drivers to provide lifetime-parameterized implementations of DriverGpuVm.

> diff --git a/rust/kernel/drm/gpuvm/sm_ops.rs b/rust/kernel/drm/gpuvm/sm_o=
ps.rs
> index 69a8e5ab2821f..742c151b2540e 100644
> --- a/rust/kernel/drm/gpuvm/sm_ops.rs
> +++ b/rust/kernel/drm/gpuvm/sm_ops.rs
> @@ -3,7 +3,7 @@
>  use super::*;
> =20
>  /// The actual data that gets threaded through the callbacks.
> -struct SmData<'a, 'ctx, T: DriverGpuVm> {
> +struct SmData<'a, 'ctx, T: DriverGpuVm + 'ctx> {
>      gpuvm: &'a mut UniqueRefGpuVm<T>,
>      user_context: &'a mut T::SmContext<'ctx>,
>  }

[ ... ]

> @@ -20,7 +20,7 @@ struct SmMapData<'a, 'ctx, T: DriverGpuVm> {

[Severity: Low]
Will this fail to compile because SmMapData lacks the T: 'ctx bound?

Since SmMapData embeds SmData<'a, 'ctx, T>, which now requires
T: DriverGpuVm + 'ctx, doesn't SmMapData also need the same lifetime bound =
to
satisfy the requirements of its sm_data field?

>  }
> =20
>  /// The argument for [`UniqueRefGpuVm::sm_map`].
> -pub struct OpMapRequest<'a, 'ctx, T: DriverGpuVm> {
> +pub struct OpMapRequest<'a, 'ctx, T: DriverGpuVm + 'ctx> {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-gpuvm_smco=
ntext_lifetime_bound_v1-v1-1-531e7d2ee7b4@collabora.com?part=3D1
