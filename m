Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C3606A329
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=S/HsVM5Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EBC10E939;
	Thu, 26 Nov 2026 02:15:42 +0000 (UTC)
Received: from mail-m128123.netease.com (mail-m128123.netease.com
 [103.209.128.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6950C10E939
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:15:36 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5609a9a43;
 Thu, 26 Nov 2026 10:15:32 +0800 (GMT+08:00)
Message-ID: <4476d230-aad2-4514-88cc-77535b2e04b2@rock-chips.com>
Date: Thu, 26 Nov 2026 10:15:25 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: vop2: Reset the AXI master in vop2_enable()
To: Tim Surber <me@timsurber.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261125204511.2867433-1-me@timsurber.de>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261125204511.2867433-1-me@timsurber.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa215a2fa2103a7kunmf50d3293eda2db
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTh1NVhhJHRlMGEJPShhDGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=S/HsVM5YLJ6VgxeQtTKKUrnj3ObtubRSAM/G+sEkeIUaLPNApiI8CrdE7spd+UWDEmRDOvu2yOwCofOyhxTRTVwZhsgtlQN7sf0X1QOV61OpGIowEEF/H8ABvmuvPFPfpnmURH3RhoKo5F8jGiGmLwPuL+/0+DBYwUYZnE7wkxM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=e+L8DXa2pMmItKQ77PKVtwOFGhGZJEc9cY2y3OfdnN8=;
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

Hi Tim,

On 11/26/2026 4:45 AM, Tim Surber wrote:
> Asserting the AXI reset in vop2_disable(), while the IOMMU is still
> attached, can hang RK3588 hard when buffers are mapped into or unmapped
> from the VOP's IOMMU domain at the same time, e.g. when a KMS client
> exits and fbcon takes the display back.
> 
> Do the reset in vop2_enable() instead, before the IOMMU is attached,
> where the AXI master is idle.
> 
> Fixes: 67a391e50271 ("drm/rockchip: vop2: Reset AXI and DCLK to improve robustness")
> Signed-off-by: Tim Surber <me@timsurber.de>
> ---
> 
> On my RK3588 board (FriendlyElec CM3588) the AXI reset in vop2_disable()
> sometimes hangs the SoC hard when the last CRTC is switched off. Without
> the reset there, it does not happen.
> 
> Here is a minimal reproducer. Run it as root, with a display on HDMI and
> fbcon on it:
> 
>   python3 - <<'EOF' &
>   import fcntl, os, struct
>   fd = os.open("/dev/dri/by-path/platform-display-subsystem-card", os.O_RDWR)
>   try:
>       fcntl.ioctl(fd, 0x641F)        # DRM_IOCTL_DROP_MASTER: leave KMS to fbcon
>   except OSError:
>       pass
>   while True:
>       b = bytearray(struct.pack("6IQ", 2160, 3840, 32, 0, 0, 0, 0))
>       fcntl.ioctl(fd, 0xC02064B2, b)                         # DRM_IOCTL_MODE_CREATE_DUMB
>       handle = struct.unpack("6IQ", b)[4]
>       fcntl.ioctl(fd, 0xC00464B4, struct.pack("I", handle))  # DRM_IOCTL_MODE_DESTROY_DUMB
>   EOF
>   while :; do
>   	echo 4 > /sys/class/graphics/fb0/blank; sleep 0.3
>   	echo 0 > /sys/class/graphics/fb0/blank; sleep 0.7
>   done
> 
> Without this patch the board hangs within a few blank cycles. With it,
> 300 cycles ran without a hang.
> 
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 76d151b8bc52..a86ac9173aac 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -913,6 +913,9 @@ static int vop2_enable(struct vop2 *vop2)
>  	if (ret)
>  		goto err_put_pm;
>  
> +	/* Reset while idle; doing it in vop2_disable() can hang the SoC */
> +	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
> +
>  	ret = rockchip_drm_dma_attach_device(vop2->drm, vop2->dev);
>  	if (ret) {
>  		drm_err(vop2->drm, "failed to attach dma mapping: %d\n", ret);
> @@ -973,8 +976,6 @@ static int vop2_enable(struct vop2 *vop2)
>  
>  static void vop2_disable(struct vop2 *vop2)
>  {
> -	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
> -
>  	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);
> 

This looks great. But what happens if you place 
vop2_reset_assert_deassert() after rockchip_drm_dma_detach_device()?

>  	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
> 
> base-commit: 479e381e77dcde0dfcc9d51e89ff3273da199804

-- 
Best, 
Chaoyi
