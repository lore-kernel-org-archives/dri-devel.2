Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C1BC982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 06:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FD010E11B;
	Sat, 19 Sep 2026 06:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IYvLOT+Z";
	dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Sat, 19 Sep 2026 06:57:49 UTC
Received: from mail-m822136233.xmail.ntesmail.com
 (mail-m822136233.xmail.ntesmail.com [8.221.36.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D0710E11B
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 06:57:49 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4e5c81ff9;
 Sat, 19 Sep 2026 14:52:38 +0800 (GMT+08:00)
Message-ID: <94451cc1-5dcc-4017-9b17-19fc20245ca8@rock-chips.com>
Date: Sat, 19 Sep 2026 14:52:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/13] drm/mediatek: Implement Display Stream
 Compression support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com
References: <20260916110825.102631-1-angelogioacchino.delregno@collabora.com>
 <20260916110825.102631-3-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260916110825.102631-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa0b8703e5003a7kunmb39cf7f3fb4f3e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx4fVk5JGk5CSk9JGBoeSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=IYvLOT+ZLuL17rn47b2fIRKpsfV3Djch3gDimo9Pbn3EhzAdXn+34mKd9GylNsvfzySPs0QIMnHV0WM952ngEQInR2LgNciceaA4c5mn+0TqE6KLXQw4EIIuKoOnuPzINBtI4+nXvALj8t/uyy6tuGhRnHz+zjY0RhIfWYT0Eqc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=yCvKOOZJlmWGLHZyrsJtjvW3q4jXCw/cfJrFwwwwJvQ=;
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

Hi,

On 9/16/2026 7:08 PM, AngeloGioacchino Del Regno wrote:
> Add a real driver for the Display Stream Compression (DSC) Display
> Controller IP, implementing support for DSC v1.1 to v1.2.
> 
> In order to do this, it was necessary to remove the basic DSC IP
> bypass setup from mtk_ddp_comp: this functionality is retained in
> the new mtk_disp_dsc driver, which checks if DSC was actually
> requested by other components (with the only one that currently
> supports this being DSI) and, if not, it will set BYPASS mode in
> the DSC IP.
> 
> Like before, the BYPASS mode is set before starting the DSC IP,
> but unlike before, this is being done in the component start
> callback instead of the config one.
> Notably, the config callback is called by mtk_crtc always
> immediately before the calling start callback, so the order of
> register writes is retained.
> The only real difference is that now this is being done through
> CPU writes instead of CMDQ, but since that's called only once
> and since it's just three registers, the performance impact will
> not be minimal and not even measurable.
> 
> As anticipated, DSC handling was also introduced in the mtk_dsi
> driver: when performing dsi_host_attach, the driver now checks
> if the DSI panel adds the DSC configuration structure to the
> mipi_dsi_device structure and, if it does, it will store a
> pointer in the driver-local mtk_dsi structure's `dsc` member.
> 
> The DSI driver will then check whether the DSC configuration
> that comes from the panel is valid (in regard to MediaTek DSI)
> and will call the DRM API's DSC helpers to calculate and set
> all of the const and RC parameters for the actual DSC setup.
> 
> For the time being, even though the latest MediaTek SoCs do
> support DSC v1.2, only DSC v1.1 pre-scr support is implemented
> as an initial contribution (which is rather big, and 1.2 would
> make it even bigger - but that can anyway be implemented later).
> 
> As a last step for validation of DSC parameters in DSI, a check
> for the hdisplay against DSC slice sidth and one for vdisplay
> against DSC slice height was added to the mode_valid callback,
> making sure that H/V are, as expected, multiples of slice W/H.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile       |   1 +
>  drivers/gpu/drm/mediatek/mtk_crtc.c     |  21 ++
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c |  43 +--
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h |   9 +
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h |   8 +
>  drivers/gpu/drm/mediatek/mtk_disp_dsc.c | 449 ++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |   2 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   1 +
>  drivers/gpu/drm/mediatek/mtk_dsi.c      | 151 +++++++-
>  9 files changed, 635 insertions(+), 50 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_dsc.c
> 

[...]

> +
> +	dsc->simple_422 = false;
> +	dsc->convert_rgb = true;
> +	dsc->vbr_enable = false;
> +
> +	drm_dsc_set_const_params(dsc);
> +	drm_dsc_set_rc_buf_thresh(dsc);
> +
> +	ret = drm_dsc_setup_rc_params(dsc, DRM_DSC_1_2_444);
> +	if (ret) {
> +		dev_err(dev, "Cannot find DSC RC params\n");
> +		return ret;
> +	}
> +

Just out of curiosity, is there a reason the DSC v1.1 rc parameters 
aren't used here?

-- 
Best, 
Chaoyi
