Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B09DCD6E4A
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 11:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF3810E0E1;
	Sat, 30 May 2026 11:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="nlm0SqO6";
	dkim-atps=neutral
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [91.218.175.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0547C10E0E1
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 11:29:39 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1780140576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koc182XcypwgblVKdeSIgVWifpWgkzVIW/22VPMmUuU=;
 b=nlm0SqO6Ux6TBklBXdGkKJEhTao7Z3+0nn5LH1tPMJo2DQt4I9eDda93iXQAfl233TfX/d
 hVWX2IQs35puA2gA1D+ARI8hH3MFSvJTWxuDWIkzPNoXRwC2WQSFA0n4560+X/4h85nI18
 PlFueIwyicAQ9W0RcsNaMC6iOjqa4B+R8xq53ok9zyh3YSzgMjjXRPKVkcIj/YlOMnMCNk
 62MqCCklM3TifYLU/NQNTnxIEcqgHhtzw/q31/dqWjLUwmYgf+atmPv3EPhVgK7+S69xsl
 NzFuQRGJsPSyKkWOCtQMPioQOMJSLywovGfbdL+Kzuoe7gEWjhsuC3VKh31DOg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 13:29:18 +0200
Message-Id: <DIVZ5UVI8BNH.2KC7WUNECAMZS@cknow-tech.com>
Cc: <kernel@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Rockchip DRM use-after-free & null-ptr-deref fixes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>, "Sandy Huang"
 <hjc@rock-chips.com>, =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>
References: <20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com>
In-Reply-To: <20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com>
X-Migadu-Flow: FLOW_OUT
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

On Sat May 30, 2026 at 1:26 PM CEST, Cristian Ciocaltea wrote:
> The first three patches in the series are fixes for use-after-free &
> null-ptr-deref related issues found in dw_dp and inno-hdmi Rockchip DRM
> drivers.
>
> The following three patches provide a few minor improvements to dw_dp
> and dw_hdmi_qp, while the remaining two address use-after-free and
> memory allocation in DW DP core library.

What's the status of this patch set?

Cheers,
  Diederik

> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v3:
> - Dropped patches 1..6,8 already applied by Heiko
> - Reworked remaining patch "drm/bridge: synopsys: dw-dp: Unregister AUX
>   channel on bridge detach" into:
>   * drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
>   * drm/rockchip: dw_dp: Release core resources
> - Link to v2: https://lore.kernel.org/r/20260310-drm-rk-fixes-v2-0-645ecf=
b43f49@collabora.com
>
> Changes in v2:
> - Fixed conflicts while rebasing onto latest drm-misc-next
> - Added two more patches:
>   * drm/bridge: synopsys: dw-dp: Unregister AUX channel on bridge detach
>   * drm/bridge: synopsys: dw-dp: Drop useless memory allocation
> - Link to v1: https://lore.kernel.org/r/20260122-drm-rk-fixes-v1-0-3942f1=
85750e@collabora.com
>
> ---
> Cristian Ciocaltea (2):
>       drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
>       drm/rockchip: dw_dp: Release core resources
>
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c   |  6 ++++++
>  drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 20 +++++++++++++++++---
>  include/drm/bridge/dw_dp.h                |  1 +
>  3 files changed, 24 insertions(+), 3 deletions(-)
> ---
> base-commit: 46c31e1604d121221167cb09380de8c7d53290b9
> change-id: 20260122-drm-rk-fixes-a7622c71553e

