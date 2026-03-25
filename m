Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F182FFEA810
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 06:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5108010E473;
	Wed, 25 Mar 2026 06:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IUcXR7VE";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A8F10E473
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 06:35:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7BFC31A2FDB;
 Wed, 25 Mar 2026 06:35:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2E561601A1;
 Wed, 25 Mar 2026 06:35:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6AB151045133A; Wed, 25 Mar 2026 07:35:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774420523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=enRmiZzFY7ZSDKwHVRqjzzPEJ2fLjJuj2O8TfjEEIN0=;
 b=IUcXR7VEkEcm7Khc99r2rl8qYegHD8WP0AJ31dIcYkW44hN3J3AhLRoSBN89yleiyFRWgs
 BHYlXW4JU+mqZz3soF8hw6Khux+XB4Lg1xu9kzBRMzN8tNLHQtxTbx8+Bds1O2R2J29/T8
 IbdVlXc59Slydk7ZgA1nvi6sDGAkOjF4VpbqaLh2KmLIWivWQK/+mn1xDrnHDAZ7djMrBw
 snNbNAEytUpzdGPnN8v8rhSCFLG5u4M6rsBhXsJssLVcyETq0KgsNgiPJZ6LEuv00t3H9G
 iBwAESRtx9mptz074bN1hZQYKK9g0CEkeJOUNk6uXvOYHUHsiVY/51fWerzvlA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 07:35:12 +0100
Message-Id: <DHBNKQ0P26BR.3FW24D4XYQ2NA@bootlin.com>
Subject: Re: [RESEND v3] drm/bridge: analogix_dp: Reuse
 &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <dmitry.baryshkov@oss.qualcomm.com>,
 <dianders@chromium.org>, <m.szyprowski@samsung.com>,
 <andy.yan@rock-chips.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Damon Ding" <damon.ding@rock-chips.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20251111022103.1350183-1-damon.ding@rock-chips.com>
In-Reply-To: <20251111022103.1350183-1-damon.ding@rock-chips.com>
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue Nov 11, 2025 at 3:21 AM CET, Damon Ding wrote:
> In analogix_dp_link_start(), &link_train.training_lane[] is used to
> set phy PE/VS configurations, and buf[] is initialized with the same
> values to set DPCD DP_TRAINING_LANEx_SET.
>
> It makes sense to reuse &link_train.training_lane[] to set DPCD
> DP_TRAINING_LANEx_SET, which can remove the redundant assignments
> and make codes more concise.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
