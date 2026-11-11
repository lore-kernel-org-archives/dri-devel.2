Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477ED606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=bmsQEOzU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4900510FA3F;
	Wed, 11 Nov 2026 09:37:18 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Wed, 11 Nov 2026 09:11:27 UTC
Received: from mail-m1028.netease.com (mail-m1028.netease.com [154.81.10.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9163710F9F4
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:11:27 +0000 (UTC)
Received: from [172.16.12.11] (gyproxy-mailtls2-entmail-virt217.gy.ntes
 [61.154.14.86]) by smtp.qiye.163.com (Hmail) with ESMTP id 544afe262;
 Wed, 11 Nov 2026 17:06:11 +0800 (GMT+08:00)
Message-ID: <20e74412-e4d5-40bb-9565-249f029324a3@rock-chips.com>
Date: Wed, 11 Nov 2026 17:06:10 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 14/16] arm64: dts: rockchip: add NPU core domain
 clocks and resets to rk3576
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261108065917.135194-1-gahing@gahingwoo.com>
 <20261108065917.135194-15-gahing@gahingwoo.com>
From: Finley Xiao <finley.xiao@rock-chips.com>
In-Reply-To: <20261108065917.135194-15-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c9db8bbe03a8kunm0e16dd9f3b1c8b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEIfVkIfTUtNGUMaSE0aS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=bmsQEOzUtCVRFu14odnqTs+fbRAN150MTPhXy26iN1vXi9lISKGIld9fP4bwih8bhnZXxhlw2jJ/5ikLqqUDLJ13t7MhEsYXsBxUc/UqdChMjyufdvzqRPn7EVrtcZBoUO8Twfo0YLGib0/0uTkv8pnEenLBwOO+hEL6oFopsTE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=tMdgjX8bYijLnolxyoTC/q9AKx2reNTEQu7tjnwBrUk=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 11 Nov 2026 09:37:13 +0000
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


在 2026/11/8 14:59, Jiaxing Hu 写道:
> The two NPU cores of the RK3576 share the CBUF and the DSU, so PD_NPU0
> and PD_NPU1 also need the three clocks that PD_NPUTOP already lists.
>
> Also add a BIU reset to each NPU power domain. The pmdomain driver cycles
> it when the domain powers on, so the bus interface works.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3576.dtsi | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> index 7828736bf9ac..508ed48b7bee 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1159,14 +1159,22 @@ power-domain@RK3576_PD_NPUTOP {
>   						power-domain@RK3576_PD_NPU0 {
>   							reg = <RK3576_PD_NPU0>;
>   							clocks = <&cru HCLK_RKNN_ROOT>,
> -								 <&cru ACLK_RKNN0>;
> +								 <&cru ACLK_RKNN0>,
> +								 <&cru CLK_RKNN_DSU0>,
> +								 <&cru ACLK_RKNN_CBUF>,
> +								 <&cru HCLK_RKNN_CBUF>;
   1. CLK_RKNN_DSU0 is the parent of ACLK_RKNN0/1 (see clk-rk3576.c).
   The common clock framework enables a clock's parents
   automatically, so DSU0 is already held during the switch window
   through the ACLK_RKNN0/1 entries the nodes already list; adding
   it explicitly is redundant.

   2. Per the design, a power domain switch only performs the idle
   request handshake and the QoS save/restore accesses, and those
   paths only require ACLK_RKNN0/1 and HCLK_RKNN_ROOT - exactly what
   the nodes already list. The CBUF clocks are not on the switch
   flow's access path, and the clk_ungate_mask support in the driver
   (0x1a/0x1c on PMU_CRU_GATEDIS_CON0 for npu0/npu1) keeps the shared
   paths alive during the switch window anyway - that is what the
   g_mask support was added for.
> +							resets = <&cru SRST_A_RKNN0_BIU>;
>   							pm_qos = <&qos_npu_m0>;
>   							#power-domain-cells = <0>;
>   						};
>   						power-domain@RK3576_PD_NPU1 {
>   							reg = <RK3576_PD_NPU1>;
>   							clocks = <&cru HCLK_RKNN_ROOT>,
> -								 <&cru ACLK_RKNN1>;
> +								 <&cru ACLK_RKNN1>,
> +								 <&cru CLK_RKNN_DSU0>,
> +								 <&cru ACLK_RKNN_CBUF>,
> +								 <&cru HCLK_RKNN_CBUF>;
> +							resets = <&cru SRST_A_RKNN1_BIU>;
>   							pm_qos = <&qos_npu_m1>;
>   							#power-domain-cells = <0>;
>   						};

-- 
Best regards,

底层平台中心 肖锋（Finley Xiao）
************************************************************************************
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.
福建省福州市铜盘路软件大道89号软件园A区21号楼 350003
No.21 Building, A District, Fuzhou Software Park, Fuzhou, Fujian 350003, P.R. China
Tel: 0591-83991906-8602 Mobile: 18506057603
************************************************************************************

