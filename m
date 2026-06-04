Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C45CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A51FD10E3C5;
	Thu,  4 Jun 2026 20:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FB7U+PMn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC9810E3C5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:21:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E21E460145;
 Thu,  4 Jun 2026 20:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2F31F00893;
 Thu,  4 Jun 2026 20:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604494;
 bh=8ZV72bHAiyVVhbZ2By3p1AkD4Osmp4IjAS2SClpsMuc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FB7U+PMnKa/HR2BVPK2/S9LbPF2pZCcqpORDKLBKaos0enegGWrIzCwa2KZ6E1tWx
 vYE4UqdlsnFXtzunCPGzcff0MApqRgm9QBNSzKgUZ+70eB25Ahgko3NpeslPHoqYRa
 yexNDtpqMAQwJ3BgWQzAwwT+wcI9aQaf1IOR8xA6/M4NkXdjTlaDXTegBrF9lf5FD/
 rBJBZj3N2V9TEIs6GpkgYoOs0es/maf7JVy690zLiPYEVedGXb5Q1p79r68+QXlg3Y
 QRUeWwXKAv2/WWjPMPP+qTpPmwCf8RxBMNh7pCCV9Zrjgp9W6MpjFbckrNv8N7SUyY
 7Ja0fuv9IV45Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Fix stale rpmh votes after suspend
To: "Akhil P Oommen" <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:21:34 +0000
Message-Id: <20260604202134.7C2F31F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] PDC sleep sequence is triggered even when GMU firmware initializat=
ion fails due to unconditional status flag setting.
--

commit 82656c1e5d01b9521acaeb8de8ad4bf1a538f52b
Author: Shivam Rawat <shivrawa@qti.qualcomm.com>

drm/msm/a6xx: Fix stale rpmh votes after suspend

This commit addresses stale RPMH (BCM) votes observed after GMU suspend by
ensuring RPMH stop sequences are not skipped. It also puts the GMU into a
reset state to prevent further activity.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 2e5d7b53a0c38..a2f6918c4f7f2 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -642,7 +642,7 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>  	int ret;
>  	u32 val;
> =20
> -	if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
> +	if (!test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but this logic change appears to
expose a pre-existing issue in a6xx_gmu_start().

If a6xx_gmu_start() times out waiting for the firmware, it logs an error but
still sets the status bit unconditionally:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_start() {
	...
	if (ret)
		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");

	set_bit(GMU_STATUS_FW_START, &gmu->status);
	...
}

When a6xx_gmu_start() returns this error, the caller jumps to its error
handling path and calls a6xx_rpmh_stop() to clean up.

Now that a6xx_rpmh_stop() correctly proceeds when the bit is set, won't it
issue the RSCC sleep request even though the firmware failed to initialize?

Could this risk hanging the PDC subsystem, since the sleep sequence requires
the GMU firmware to have successfully initialized certain registers?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-assorted-f=
ixes-june-v1-0-2caa04f7287c@oss.qualcomm.com?part=3D1
