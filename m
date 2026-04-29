Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A4FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19C110F022;
	Wed, 29 Apr 2026 13:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="FH+21a+v";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DE510F01E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:43:22 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C70971FB70;
 Wed, 29 Apr 2026 15:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777470201;
 bh=WoLY0VfrRS2QQCo2S5G6Qe5l+XRLfteiRAzVDZloMAY=; h=From:To:Subject;
 b=FH+21a+vlYMYyfVlq8SHvfYJSWJZ0Sez8wvlGLqzHnrQIDQ8m70j5dKq+E1Pq0s2F
 nPCU3N3/xsgOD8KVY63eDKR+TTAH6eW9V1J5tK8fTFn0x4chH3pJL4XzxHJVhVBdzs
 37K7PDY8G06OC7grV45QghiBnqDH/ORMfGa0GJfqQ2wDYjU5NRgFeWinVfApqnlk0m
 iXZVWi4eXWGqSuIeeScNXW98rF+rESdiHHB6N2DT98Z8gO9z1YOXGEJif72aARhtAF
 oeTBJUAmPwrTpLunwKyptIj78GUEYXXcUo59xQK6xnMO4IMwQPAItFvd5nzVtDaoE1
 nZGX0wAZO1Q0Q==
Date: Wed, 29 Apr 2026 15:43:17 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Message-ID: <20260429134317.GA74339@francesco-nb>
References: <20260407144142.1420354-2-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407144142.1420354-2-ivitro@gmail.com>
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

+Dmitry, Luca

Hello,

On Tue, Apr 07, 2026 at 03:41:41PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
> for both runtime PM and system sleep. This causes the DSI clocks to be
> disabled twice: once during runtime suspend and again during system
> suspend, resulting in a WARN message from the clock framework when
> attempting to disable already-disabled clocks.
> 
> [   84.384540] clk:231:5 already disabled
> [   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_core_disable+0xa4/0xac
> ...
> [   84.579183] Call trace:
> [   84.581624]  clk_core_disable+0xa4/0xac
> [   84.585457]  clk_disable+0x30/0x4c
> [   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
> [   84.593651]  pm_generic_suspend+0x2c/0x44
> [   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
> [   84.601670]  dpm_run_callback+0x8c/0x14c
> [   84.605588]  __device_suspend+0x1a0/0x56c
> [   84.609594]  dpm_suspend+0x17c/0x21c
> [   84.613165]  dpm_suspend_start+0xa0/0xa8
> [   84.617083]  suspend_devices_and_enter+0x12c/0x634
> [   84.621872]  pm_suspend+0x1fc/0x368
> 
> To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the
> _enable()/_disable() hooks managed by the DRM framework for both
> runtime and system-wide PM.
> 
> Cc: stable@vger.kernel.org # 6.1.x
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Luca, Dmitry: any chance you can help with this patch?

Thanks,
Francesco

