Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1D2CD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 11:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C0DB10EA00;
	Sun,  7 Jun 2026 11:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mTXTRyPe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ECE110EA00
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 11:36:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B8F3600AE;
 Sun,  7 Jun 2026 11:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387461F00893;
 Sun,  7 Jun 2026 11:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780832183;
 bh=vlv25Mf7HySP4xDRzemquJ8ge8ABQjhxapOJbR46NW8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mTXTRyPeH/BuSw8V2jMsdMea70S4yv45zWWjUBy3yKZ73CosIvRlW0RLFaKg56roJ
 EzJApt+DBbTqM7xrBEGcrHHSjadOn215HSWTzTTgKilbfUBqUjz1V77TNtrr5e2aKc
 746DUPTqxqa2wpFq98i8wSACtwjPGyY2bVgtyojJVDeLhL/qz55xRhOQzk3wG152aE
 hJXBudgkLZqN7/7q0XhBcrKKiTfyLbIwtxeooIomMJJUGZp5EzDAvdY6cgHUEwN7i8
 SdKqpqkPjvHidk7MmYxjRja7ob0j/CTFW6XabPO3J8Ff2iMncG4CkGjB8TE6QaFkUL
 RMeyFjglBuLAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add HUION Kamvas Studio 16
To: "Tyron Govender" <dev@tyrongovender.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260607113147.55507-1-dev@tyrongovender.com>
References: <20260607113147.55507-1-dev@tyrongovender.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 11:36:22 +0000
Message-Id: <20260607113623.387461F00893@smtp.kernel.org>
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
- [Low] Undeclared identifier `lcd2560x1440_bottom_up` causing a build fail=
ure.
--

commit 532668bae9bf64a960a61fb91c8692d35f08f8e0
Author: Tyron Govender <dev@tyrongovender.com>

drm: panel-orientation-quirks: Add HUION Kamvas Studio 16

This commit adds a panel orientation quirk for the HUION Kamvas Studio 16.
It intentionally matches a spelling error in the DMI product name and
maps it to a bottom-up orientation for its 2560x1440 display.

> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu=
/drm/drm_panel_orientation_quirks.c
> index 3a218fb592cef..85203b1400095 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
[ ... ]
> @@ -364,6 +364,15 @@ static const struct dmi_system_id orientation_data[]=
 =3D {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
>  		},
>  		.driver_data =3D (void *)&lcd1080x1920_rightside_up,
> +	}, {	/*
> +	 * HUION Kamvas Studio 16
> +	 * DMI has "Kavmas" spelling error, matched intentionally here
> +	 */
> +		.matches =3D {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "HUION"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Kavmas Studio 16"),
> +		},
> +		.driver_data =3D (void *)&lcd2560x1440_bottom_up,

[Severity: Low]
Does this cause a build failure? The patch references lcd2560x1440_bottom_up
here, but it appears the struct was never defined or declared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607113147.5550=
7-1-dev@tyrongovender.com?part=3D1
