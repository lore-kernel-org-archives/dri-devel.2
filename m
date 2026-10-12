Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895E3CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9251010E641;
	Mon, 12 Oct 2026 18:27:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2590210E02B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:27:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF6D040436;
 Mon, 12 Oct 2026 18:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A081F0089B;
 Mon, 12 Oct 2026 18:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791829624;
 bh=q3m9304DTpEG3D5waXAZP9TyDPNruCiYIiHy5u1U4yk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QbRXCFmoQie+0G3z0XvAZhZvGrkk4gGxIhonPaNLlxUwQXQmPWSEhaAN6UsXccBQj
 mIokM8ah0dPX406dTnGn7gykGDjUJwgz5naYbgQsNHfCSSapV4umpUqsNAvaxWIuCm
 Ka96J58LAbSyFw22bOEc6P5i+hVDPbllyuUhX9EGjllFj2P4Kd7247V3/HgN5aBf0Z
 5UpmYGzy/QZBXcmL8BD9If9EMWTygf3Ih0uKHGoAjiBQcYaMlcn614ScAI/7YnChq/
 XsWyW6VX2cKixgN2Ga4KOI6q4CPZieaJ4LTb4SKKslZCG5vQkDC1CQx+Sb40niFyZ2
 hRns6bkAFT24Q==
Message-ID: <sashiko-outbox-168537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-2-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-2-e12939d229a1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:27:04 +0000
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
- [Medium] accel/qaic: Kconfig dependency silently disables DRM_ACCEL_QAIC
--

commit f5cb67a206ffebb3609b6a5fffcfe4b3a821d420
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Move Sahara protocol driver under MHI host client drivers

This commit moves the Sahara protocol driver out of the QAIC subsystem and
into drivers/bus/mhi as an independent host client driver. It also creates a
dedicated Kconfig hierarchy and updates the driver initialization to use
module_mhi_driver().

> diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
> index 116e42d152ca8..af90fdfcf77ee 100644
> --- a/drivers/accel/qaic/Kconfig
> +++ b/drivers/accel/qaic/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ACCEL_QAIC
>  	depends on DRM_ACCEL
>  	depends on PCI && HAS_IOMEM
>  	depends on MHI_BUS
> +	depends on MHI_SAHARA

[Severity: Medium]
Does adding this dependency silently disable the DRM_ACCEL_QAIC driver for
users upgrading their kernels?

Since the newly introduced MHI_SAHARA symbol defaults to N, existing
configurations running make oldconfig will have DRM_ACCEL_QAIC silently
dropped because its new dependency is unmet.

To prevent breaking existing configurations, should DRM_ACCEL_QAIC use
select MHI_SAHARA instead, or should MHI_SAHARA default to DRM_ACCEL_QAIC?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-sahara_pro=
tocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com?part=3D2
