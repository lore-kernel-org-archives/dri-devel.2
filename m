Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C6606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=UURWRjVw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB3E10E53F;
	Tue, 24 Nov 2026 08:24:27 +0000 (UTC)
Received: from mail-m93219.xmail.ntesmail.com (mail-m93219.xmail.ntesmail.com
 [103.126.93.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE96710E53F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:24:20 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55cb96efc;
 Tue, 24 Nov 2026 16:24:16 +0800 (GMT+08:00)
Message-ID: <c89271be-85f9-41ba-9c19-c78743d212c8@rock-chips.com>
Date: Tue, 24 Nov 2026 16:24:12 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] drm/bridge: add glue driver for T-Head TH1520 DW
 MIPI DSI
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andyshrk@163.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, Icneowy Zheng <uwu@icenowy.me>,
 Han Gao <gaohan@iscas.ac.cn>
References: <20261124-th1520-dw-mipi-dsi-v3-0-ffcf2d87971b@iscas.ac.cn>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261124-th1520-dw-mipi-dsi-v3-0-ffcf2d87971b@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa20ca7d7d303a7kunmc11de194cd4c3b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkpOVkgdHx1PSkseQkpJTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=UURWRjVwdo+3l2AULyocD6fSNflb4NLvemODSt3E0BkJ4SDNYTRbIrvF97HUU4K2rtd/SDBnXtHZ+9biRxmmr2VYZUHyx1vjJo4sQNiVBRKlCiF1JgNn+It/uQ2dEKWkUHaT+/LN1vLB/a+9UefWRH0gS3pOe07esi2EjWKgg4A=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=CIIxCHmaf4fxrIyFS/BRlR2dhrRZVanUxs4tziQTo54=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Icenowy,

On 11/24/2026 3:56 PM, Icenowy Zheng wrote:
> T-Head TH1520 contains a DesignWare MIPI DSI host controller paired with
> an internal DesignWare PHY, as a similar design (but with a different
> PHY) with the Rockchip DW MIPI DSI.
> 
> The functionality to write to the PHY is shared between these two
> implementations of DW MIPI DSI, so it's extracted from the Rockchip
> driver to the common code. (The same sequence could be seen in the
> HiSilicon Kirin DRM driver, but that one hasn't been converted to common
> DW MIPI DSI.)
> 
> Tested on a Lichee Console 4A (with a Mingjun MJ070BI30IA2 panel) with
> further pending DT patches.
> 
> One question remains: I have to copy the extra lane bandwidth headroom
> from the Rockchip driver, otherwise the Mingjun panel cannot keep sync
> to the display signal; from my testing, changing the hardcoded
> PHY_STOP_WAIT_TIME from 0x20 to 0x2 (which is written by the vendor
> driver) can also make this panel to work w/o the extra headroom. I want
> some advice on whether to keep the extra headroom or changing the common
> code to make the PHY_STOP_WAIT_TIME parameter adjustable.
> 

Does the DesignWare PHY databook describe about PHY_STOP_WAIT_TIME?
  
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
> Changes in v3:
> - Fixed a remaining `syscon` in the DT binding.
> - Link to v2: https://patch.msgid.link/20261119-th1520-dw-mipi-dsi-v2-0-9ab5f9808f87@iscas.ac.cn
> 
> Changes in v2:
> - Changed `syscon` to `thead,vo-syscon` in the DT binding.
> - Dropped the patch moving common PHY write routine to dw-mipi-dsi
>   common code.
> - Fixed a few problems pointed out by Sashiko in v1.
> - Link to v1: https://patch.msgid.link/20261030-th1520-dw-mipi-dsi-v1-0-753f34fd304f@iscas.ac.cn
> 
> ---
> Icenowy Zheng (2):
>       dt-bindings: display: bridge: document TH1520 MIPI DSI controller
>       drm/bridge: add TH1520 DesignWare MIPI DSI host controller
> 
>  .../display/bridge/thead,th1520-dw-mipi-dsi.yaml   | 103 ++++
>  drivers/gpu/drm/bridge/Kconfig                     |  12 +
>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>  drivers/gpu/drm/bridge/th1520-dw-mipi-dsi.c        | 570 +++++++++++++++++++++
>  4 files changed, 686 insertions(+)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261030-th1520-dw-mipi-dsi-580d5b2792f9
> 
> Best regards,
> --  
> Icenowy Zheng <zhengxingda@iscas.ac.cn>

-- 
Best, 
Chaoyi
