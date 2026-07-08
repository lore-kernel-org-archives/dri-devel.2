Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B827C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9214810E4B5;
	Wed,  8 Jul 2026 17:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c2c+Gk7u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237E110E4B5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:40:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A1A75403B8;
 Wed,  8 Jul 2026 17:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8B61F000E9;
 Wed,  8 Jul 2026 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783532426;
 bh=81viAmBDnQ7ZudzZGglukLBhDGkZ37rMYGKzDkSbZmA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c2c+Gk7ujpkz3ulweaYwiVntB7hFZselAw77w1+VQx4N4cU2bwAadlFJOPknY9OTi
 onBupxfsYpn6bBGZhqZgn8MdBmnQEPFoH28Fw1e2L1k9SeMMl5ATMu9x9+1uDfXd23
 OJSg0I7N2XD3p8Cfybg/76crQXLKOkCu7ZjAVyrGWlkQJdFYchwQUk5wz/ldVZcSIj
 5k85Lj8xRsXRh1hX9HWBg95T7OixdXpuLJnqw6eU6fIPXwX60DLUIjkRuV7sNhNVIc
 Wf1rtXnZot1TEk12ywRT1siaqfs6C8/rIIaqXVK2MY07gNfFkyR10CSipxQwEl54DN
 qenClFL55BbPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] drm/msm: Remove invalid overflow check
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708173356.578713-7-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
 <20260708173356.578713-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:40:25 +0000
Message-Id: <20260708174026.5A8B61F000E9@smtp.kernel.org>
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
- [Critical] Integer Truncation leading to Heap Buffer Overflow on 32-bit a=
rchitectures.
--

--- Patch [6]: [PATCH v4 6/6] drm/msm: Remove invalid overflow check ---
commit b6fd344e5aae554bc6124eb5aa28a19da1bb53c5
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Remove invalid overflow check

This commit changes the size variable for the msm_gem_submit allocation
from uint64_t to size_t and removes the explicit check against SIZE_MAX,
relying on kzalloc to handle struct_size overflows natively.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 0dc983d155cd2..744af6389ac62 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -36,15 +36,11 @@ static struct msm_gem_submit *submit_create(struct dr=
m_device *dev,
>  {
>  	static atomic_t ident =3D ATOMIC_INIT(0);
>  	struct msm_gem_submit *submit;
> -	uint64_t sz;
> +	size_t sz;
>  	int ret;
> =20
>  	sz =3D struct_size(submit, bos, nr_bos) +
>  			((u64)nr_cmds * sizeof(submit->cmd[0]));
> -
> -	if (sz > SIZE_MAX)
> -		return ERR_PTR(-ENOMEM);
> -

[Severity: Critical]
Does changing sz to size_t introduce an integer truncation vulnerability on
32-bit architectures?

The right side of this assignment evaluates to a 64-bit value because
nr_cmds is cast to u64. If struct_size() overflows and returns SIZE_MAX, or=
 if
nr_cmds is extremely large, the addition results in a value exceeding 4GB.

When this 64-bit value is assigned to a 32-bit size_t variable on 32-bit
architectures, it will implicitly truncate and wrap around to a small value.
Since kzalloc() is now passed this truncated size, it will successfully
allocate a small buffer instead of failing.

Could this allow user-controlled nr_cmds and nr_bos values to trigger a heap
buffer overflow when subsequent loops write past the allocated bounds?

>  	submit =3D kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
>  	if (!submit)
>  		return ERR_PTR(-ENOMEM);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708173356.5787=
13-1-robin.clark@oss.qualcomm.com?part=3D6
