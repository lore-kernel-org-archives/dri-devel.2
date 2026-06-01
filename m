Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40C8CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605E91131D2;
	Mon,  1 Jun 2026 10:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AH7EC9Ux";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Mon, 01 Jun 2026 10:59:31 UTC
Received: from mail-m158195.netease.com (mail-m158195.netease.com
 [47.251.158.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A231131D2
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:59:31 +0000 (UTC)
Received: from [172.16.12.77] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4097ac413;
 Mon, 1 Jun 2026 18:54:25 +0800 (GMT+08:00)
Message-ID: <2d2b6308-ae46-46fd-b1ce-e4f199b6eb27@rock-chips.com>
Date: Mon, 1 Jun 2026 18:54:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/rockchip: vop2: Fix layer cfg done timeout on
 multi-output setups
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e82d20feb09d8kunmd8c5247738e1b1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGRgZVh0aH05NTxoaSRlDS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=AH7EC9UxGBcgm/HY6FSXgbL+vmU1rG73HwI+2in9EM4d1KmBz3MCI0Lvcr8fTfIbF3+4DsiJd/N/f3rVwvxvq4dmDLaQ3xLM56AzMJgsqrVnOtQF31VVxXnJdc7spp+mgHqfXFP8VLgXCcgyoKRjZTSP+APE8DT+CyswWQg+9/I=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=0FP/SMdxTBNjb7CmLP/yRXS7a+fzZXcGFTKpDYjQ04I=;
 h=date:mime-version:subject:message-id:from;
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

Hello Cristian,

On 5/5/26 02:23, Cristian Ciocaltea wrote:
> On RK3588/RK3568 boards with multiple active display outputs, start/stop
> transitions may trigger a timeout during overlay layer configuration:
> 
>    rockchip-drm display-subsystem: [drm] *ERROR* wait layer cfg done timeout
> 
> The shared OVL_LAYER_SEL and OVL_PORT_SEL shadow registers are committed
> to the active configuration at the vsync of whichever Video Port is
> selected by LAYERSEL_REGDONE_SEL.  When two Video Ports race through
> atomic commits, rk3568_vop2_setup_layer_mixer() has two issues that
> cause the wait to poll for a value the hardware might not be able to
> produce.
> 
> Patch 1 fixes passing the wrong target to the wait function, since the
> expected value was already overwritten with the current VP's new
> layer_sel before reaching the wait.
> 
> Patch 2 moves the wait before the LAYERSEL_REGDONE_SEL switch, so the
> previous VP's vsync can still latch the pending configuration.
> 
> Patches 3 through 5 contain only minor follow-up cleanup.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>


Thank you very much for your work, these fixes all look sensible.
However, I haven't been able to construct a scenario via weston that
reproduce these issues. Could you please tell me how you triggered them?

> ---
> Cristian Ciocaltea (5):
>        drm/rockchip: vop2: Fix wrong wait target in layer cfg done check
>        drm/rockchip: vop2: Wait for layer cfg done before switching LAYERSEL_REGDONE_SEL
>        drm/rockchip: vop2: Delay old_{layer|port}_sel updates in setup_layer_mixer()
>        drm/rockchip: vop2: Drop redundant zero-init in setup_layer_mixer()
>        drm/rockchip: vop2: Use vop2->old_layer_sel directly in wait_for_layer_cfg_done()
> 
>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 46 +++++++++++++---------------
>   1 file changed, 22 insertions(+), 24 deletions(-)
> ---
> base-commit: d4c14903bf5e28e740516c4fbb7db01e0dedf3af
> change-id: 20260504-vop2-layer-cfg-tmout-73617a0a103c
> 
> 

