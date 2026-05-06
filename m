Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E81ECD3427
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 02:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506E510E1BB;
	Wed,  6 May 2026 02:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hox6Sfk1";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Wed, 06 May 2026 02:17:55 UTC
Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com
 [220.197.31.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB1110E1BB
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 02:17:55 +0000 (UTC)
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3d3be398c;
 Wed, 6 May 2026 10:02:44 +0800 (GMT+08:00)
Message-ID: <f91f1ebe-c41e-42ae-a860-5e4c99c34784@rock-chips.com>
Date: Wed, 6 May 2026 10:02:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] MAINTAINERS: Track dw-hdmi-qp under Rockchip DRM
 drivers
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20260506-maintainers-rk-drm-upd-v1-1-f67537b4bb29@collabora.com>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20260506-maintainers-rk-drm-upd-v1-1-f67537b4bb29@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dfb05f30309d6kunmab154c12257ce3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGh1PGlZCGE1IT0NKHx
 gdT0xWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSEpKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=hox6Sfk13RUdtTP3RnPnUTOekDVp54uGomPSD1YHgkTMK5CVz0VJC/BBVQoZGV3Vdynk+HuhiAAqhmY+s0+kCY1dBY4ffmhguQqqw84+EPEylKc9GsfraPyVHI/OggExK4sm1F8bYjqG2zgM+YfrAun2tnj4GNo0BVtf/qwAAoY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=nruCB6ibq9+1PRX77kFEv5gkcVE1RGi6EA4xSfKhv1w=;
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

Hello,

On 5/6/26 06:31, Cristian Ciocaltea wrote:
> The DW HDMI QP TX library was developed for and is currently only used
> by Rockchip platforms.  Add it to the Rockchip DRM drivers section to
> ensure all relevant parties are kept in the loop on any changes.
> 
> As its file paths fall outside the generic wildcard patterns defined in
> the ARM/Rockchip SoC support section, also add the
> linux-rockchip@lists.infradead.org mailing list to avoid any
> notification gaps.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dfad67f66c0..cb3c8e5fcb21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8754,11 +8754,14 @@ M:	Sandy Huang <hjc@rock-chips.com>
>   M:	Heiko Stübner <heiko@sntech.de>
>   M:	Andy Yan <andy.yan@rock-chips.com>
>   L:	dri-devel@lists.freedesktop.org
> +L:	linux-rockchip@lists.infradead.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	Documentation/devicetree/bindings/display/rockchip/
> +F:	drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.*
>   F:	drivers/gpu/drm/ci/xfails/rockchip*
>   F:	drivers/gpu/drm/rockchip/
> +F:	include/drm/bridge/dw_hdmi_qp.h



Acked-by: Andy Yan <andy.yan@rock-chips.com>

>   
>   DRM DRIVERS FOR STI
>   M:	Alain Volmat <alain.volmat@foss.st.com>
> 
> ---
> base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
> change-id: 20260506-maintainers-rk-drm-upd-c463f6b04769
> 
> 

