Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF4ACD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 08:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C5A10E51F;
	Wed,  6 May 2026 08:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FOeXm3NT";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F105610E51F
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 08:01:41 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D446F55;
 Wed,  6 May 2026 10:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778054497;
 bh=sBiF8tqyySOo/DmrZC8WqhP3evQV2sfTKn6yuUj/Qko=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FOeXm3NTkbxnKYWblklYWP1FOnQ4yLHGJJd3bgtBiNbu89/FzD/UYn9ZKoL/IuF71
 YoxCHWoKif6jp8hPE6TbDxEj8O0YV9TRxCRmKC0otWumWoPKiVbeYLeXUVIcVGZdaN
 c747oAAstiTWLpYU8L9tuHbRqZDGXSTStRg+hIiU=
Message-ID: <d9c5fd5f-f910-45c9-82cc-9284bcedc162@ideasonboard.com>
Date: Wed, 6 May 2026 11:01:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
To: Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 stable@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260505134705.188661-2-ivitro@gmail.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260505134705.188661-2-ivitro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 05/05/2026 16:47, Vitor Soares wrote:
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
> RUNTIME_PM_OPS(). Bridge and panel drivers should only deal with runtime
> PM, as the DRM framework manages system-wide power transitions through
> the bridge enable() and disable() hooks.
> 
> Link: https://lore.kernel.org/all/fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com/
> Cc: stable@vger.kernel.org # 6.1.x
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
Thanks, pushed to drm-misc.

  Tomi

