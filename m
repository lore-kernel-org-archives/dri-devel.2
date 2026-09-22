Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A433C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A293310EE6D;
	Tue, 22 Sep 2026 20:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cdw5UoUB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C5710EE6D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:57:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A436D600D4;
 Tue, 22 Sep 2026 20:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4F21F000FF;
 Tue, 22 Sep 2026 20:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110619;
 bh=HAh9LZv8xo70XHeQk0X4i3/eqGqVF063Y7O8uqnuLkE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cdw5UoUBInuskJ2N8QawyP9QnzP5CIfhxLZ0p2Vrl/q0k7XSoUroxyIdQP0c2jFEa
 lKoNjMhaCtPaU88qyTskQaK+DjRAqj5ZYC6fi9sE38nMFS0g9GConfBEu3zhb6Aw3E
 Scphpn9BXPsg0k08jLP7YJSHPQQWZQxqhd0Fu4KmDNhxZw4G3sEwzzQZpXFouMF/bw
 naCWukx5kJiS0pXIxHuE2DwLeQqU72hACyMqWo+NfGf7fetRHP3qGNyKbk73DU9lCD
 W4kqfrdo3B6paCx8IYrKdWd8pR7QT5EoH01JYwxSkCmbW6cV7CxKnBAUGyF9xk3CzP
 EJpzwbaAD+SMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/27] drm/panthor: Parse and store GPU_ID fields
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-4-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-4-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:56:58 +0000
Message-Id: <20260922205659.3C4F21F000FF@smtp.kernel.org>
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
- [Low] drm/panthor: diagnostic info loss in GPU ID log
--

commit 18159d0a7677f6cb80f96ffd38fefa04603df0e5
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Parse and store GPU_ID fields
   =20
Prepare for Mali v15 by expanding GPU_ID to 64 bits and caching fields
during initialization.

> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panth=
or/panthor_hw.c
> index 4c96573b649a1..2143e57d48106 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -245,13 +245,13 @@ static int panthor_hw_info_init(struct panthor_devi=
ce *ptdev)
>  	if (ret)
>  		return ret;
> =20
> -	major =3D GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> -	minor =3D GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> -	status =3D GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +	major =3D ptdev->gpu_id.ver_major;
> +	minor =3D ptdev->gpu_id.ver_minor;
> +	status =3D ptdev->gpu_id.ver_status;
> =20
>  	drm_info(&ptdev->base,
>  		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> -		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
> +		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
>  		 major, minor, status);

[Severity: Low]
Does this unintentionally drop the architecture major, minor, and revision
values from the printed GPU ID?

Since ptdev->gpu_info.gpu_id >> 16 contains more than just the product majo=
r,
replacing it with only ptdev->gpu_id.prod_major causes an information loss =
in
the boot logs.=20

For unknown GPUs, this makes it harder to identify the unsupported hardware
because it will log as id 0x2 instead of id 0xa002 (if arch=3D10, prod=3D2).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D3
