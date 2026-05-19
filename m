Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A7FCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A5310E3A6;
	Tue, 19 May 2026 09:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WZo9Xvhj";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BFBA10E3A6
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:37:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9A230C2B9DB;
 Tue, 19 May 2026 09:38:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 578AB606E9;
 Tue, 19 May 2026 09:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C0770107E89DF; 
 Tue, 19 May 2026 11:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779183448; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SjpGKGMwhhYWC4bhK9Q7/5ATQeU5Nc+8MUNjg9tvLOo=;
 b=WZo9Xvhj0ZgMzYD4mB+BuQSkBsZboG5CVc1aJewjda3gQ2ii7Qv/qmKWcm8OTtOvvcLKDh
 9HYKHw8bqquvHKQuPjdUD2TGHjZzoGSz8hsGjMNH9Bq71S/Tcm+U7jeDkb7cXtMwb0dANL
 WyDgwgC49G/+EINQgjeE8bPxifoZUjz5rhA++q/kJufzQtv0LJz0kRBXXEED1iSttNKGjj
 JUjhBbbivPxFAmuAT2ZZ3zxH2F1iqAmysvw66T7zFBItivUWxEJIMaxI34B8sDcAwQRH0H
 +6+cFqaQzJckGhn0U86wdZtkKrMRsHvGAfugiEU1QEb4tFDyY5HCTrfzyTnsLA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>
In-Reply-To: <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-0-f61c9e498b3f@bootlin.com>
References: <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-0-f61c9e498b3f@bootlin.com>
Subject: Re: [PATCH v6 00/11] drm/bridge: handle refcounting for
 bridge-only callers of drm_of_find_panel_or_bridge()
Message-Id: <177918343743.380323.7834378536206184727.b4-ty@b4>
Date: Tue, 19 May 2026 11:37:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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


On Mon, 11 May 2026 18:40:04 +0200, Luca Ceresoli wrote:
> This series converts all the bridge-only callers of the deprecated
> drm_of_find_panel_or_bridge() API to a new, simpler API that handles bridge
> refcounting.
> 
> All patches acked/reviewed except patches 3 and 4.
> 
> == Series description
> 
> [...]

Applied, thanks!

[01/11] drm/bridge: drm_bridge_put(): ignore ERR_PTR
        commit: 55bb2b137b6d72b3281f70045d9ee5a087df0aa4
[02/11] drm/bridge: add of_drm_get_bridge_by_endpoint()
        commit: 03d1078112fddd706b2c1e4a7d98cf18700eb5df
[03/11] drm/msm/hdmi: switch to of_drm_get_bridge_by_endpoint()
        commit: 5e6016294c16f8975391497037b207ad5d2a71eb
[04/11] drm/hisilicon/kirin: switch to of_drm_get_bridge_by_endpoint()
        commit: f85a3590e31ac7d78dbb62ed617d50954f5ffde6
[05/11] drm/bridge: chrontel-ch7033: switch to of_drm_get_bridge_by_endpoint()
        commit: 7783fc059457c41f641b490e6d0d23c33c8fa89b
[06/11] drm/bridge: lontium-lt9611uxc: switch to of_drm_get_bridge_by_endpoint()
        commit: 91b42aa55c7777545e528bbd991fadea5c561d46
[07/11] drm/bridge: lt9611: switch to of_drm_get_bridge_by_endpoint()
        commit: cd9517f6e2093a4579f8a37ca66214eb34e9cd04
[08/11] drm/bridge: adv7511: switch to of_drm_get_bridge_by_endpoint()
        commit: f08eff4ad2873960d03a3834c04b86bfa4cfcdcb
[09/11] drm/bridge: lt8713sx: switch to of_drm_get_bridge_by_endpoint()
        commit: 898a5e07f7e39d771910fcd9ba73ba6e533f9283
[10/11] drm: zynqmp_dp: switch to of_drm_get_bridge_by_endpoint()
        commit: 62f1a79e1b004b250e68e10c32a29fd954fc9725
[11/11] drm: of: forbid bridge-only calls to drm_of_find_panel_or_bridge()
        commit: 0d5da248ea2d7802a5055ab6762340ac870bd0ee

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


