Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38D8C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 23:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36FD10E942;
	Tue, 22 Sep 2026 23:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MO5IcUTb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC94B10E942
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 23:26:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C988433DB;
 Tue, 22 Sep 2026 23:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2676E1F000FF;
 Tue, 22 Sep 2026 23:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790119601;
 bh=CXyMVrBwkGWn1Pxr2TCkNNpHB7Zf/QHwEhlisVWvGRw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MO5IcUTbXCTP4zz5oZpVqvZIDG/TaDhxKeQBsne8qdfe5MJUhSh/WLow3or/rgFoU
 9vEZPcdC4cpyAkIJBtFWbYxF9dVoU0iRaJ9vjtQZa2l/9S3KTplaAIkmim+7rX4ZjQ
 nMz+COFP6TnQ32XdbRAXkTwS3e+z4+TwYBvehEfP+BMgeSMUz/ySwyK6XQIPpTjIk/
 Zkp9mevCxUPJ9xOgviuMxzROrPAsB6958BIJVSXzFEyvIyzBi67rE/TD9yGZdGDEmO
 XdtjiCNPdENcFx7McIl6teqZMzLIAAeIA7RNvrPGJ0xniOTQ59J0zLbeP+cqfmdK6S
 LCNgkgaBmveGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tyr: gpu_info: zero out new/unused fields
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260922-b4-gpu_info_zero-v1-1-7259840069c6@collabora.com>
References: <20260922-b4-gpu_info_zero-v1-1-7259840069c6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 23:26:40 +0000
Message-Id: <20260922232641.2676E1F000FF@smtp.kernel.org>
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
- [Medium] tyr: potential info leak via struct update syntax on AsBytes type
--

commit d7b094df57d808ec86e2a433719f13280d288430
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: gpu_info: zero out new/unused fields

This commit updates the initialization of the UAPI struct drm_panthor_gpu_i=
nfo
to use ..pin_init::zeroed(). This is intended to pre-emptively avoid compile
errors when new fields are added to the UAPI definition.

> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index 592b8bb16eba1..e1b04a0c5159b 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -74,10 +74,8 @@ pub(crate) fn new(io: &IoMem<'_>) -> Self {
>                  io.read(TILER_PRESENT_HI).into_raw(),
>              ),
>              core_features: io.read(CORE_FEATURES).into_raw(),
> -            // Padding must be zero.
> -            pad: 0,
> -            //GPU_FEATURES register is not available; it was introduced =
in arch 11.x.
> -            gpu_features: 0,
> +            // Zero unsupported and newly added UAPI fields.
> +            ..pin_init::zeroed()

[Severity: Medium]
Could this struct update syntax accidentally leak kernel stack memory to
userspace if padding is introduced in a future UAPI update?

While pin_init::zeroed() produces a fully zeroed struct, the struct update
syntax (..base) creates a new instance by copying explicit fields from the
base and leaves any implicit padding bytes uninitialized.

Since GpuInfo manually implements AsBytes to allow byte-for-byte copies to
userspace, and this patch suppresses missing-field compile errors, any
future UAPI change that introduces implicit padding might be silently
accepted by the compiler. That padding would remain uninitialized on the
stack and be leaked to userspace.

Would it be safer to fully zero the struct before mutation, like this?

let mut info: uapi::drm_panthor_gpu_info =3D pin_init::zeroed();
info.gpu_id =3D ...;
Self(info)

>          })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-b4-gpu_inf=
o_zero-v1-1-7259840069c6@collabora.com?part=3D1
