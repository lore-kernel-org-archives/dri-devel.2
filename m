Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937A606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Mjbu5DqC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7038710E8C7;
	Wed, 25 Nov 2026 01:58:27 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B3B10E8C7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 01:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795571899;
 bh=RCwXdv4tItxKQe6YiWspccVkhW7JD4JZcpfpSEyn4tc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Mjbu5DqCZbhkGyqBolZeWH8RzEGyzS6Gv37b+Roq6+qV3mqjtjIQ7KM2nxVRNCxQj
 AloSyowdAROpG8C99PjqVwwE9YxKZADD6vuSvi9ixy0vcpIovKc9I9Oo44IK703rk5
 PGBb8OQXO3/tLulRqXxZAcoo+g/7R+pg7gTkQZdqn1o1nPjff/01696W3CRKOzUD5U
 eZqJilK/AiQDKdtbMwVW1gsK0DqvLzn5dEMtLXqU+ct99XGCGlaUjbBDn0ZTca0C/n
 NqehYBHGWCpGfiYmpmr6vFSF89pr77q88uI9v4n9cXbCe5eoAPssSHaeCa5pW5UIXw
 9UcIjsUCwoZJg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4363F17E00C4;
 Wed, 25 Nov 2026 02:58:19 +0100 (CET)
Message-ID: <3c203ba7-6a0b-45bf-ac88-9928ad0b4a11@collabora.com>
Date: Wed, 25 Nov 2026 03:58:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] drm/rockchip: vop2: Reset AXI and DCLK to
 improve robustness
To: Tim Surber <me@timsurber.de>, Heiko Stuebner <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Igor Paunovic <royalnet026@gmail.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-7-1bb63ef5766e@collabora.com>
 <20261121023139.3515640-1-me@timsurber.de>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20261121023139.3515640-1-me@timsurber.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tim,

On 11/21/26 4:31 AM, Tim Surber wrote:
> Hi Cristian,
> 
> On Thu, 05 Nov 2026 03:00:41 +0200, Cristian Ciocaltea wrote:
>> @@ -953,6 +974,8 @@ static int vop2_enable(struct vop2 *vop2)
>>
>>  static void vop2_disable(struct vop2 *vop2)
>>  {
>> +	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
>> +
>>  	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);
> 
> with this patch my RK3588 board (FriendlyElec
> CM3588) hangs hard sometimes when the last CRTC is switched off. Without the series
> or with the AXI reset in vop2_disable() removed it does not happen.
> 
> Here is a minimal reproducer, run as root, with a display on HDMI and fbcon on it:
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
> This hangs the board within a few blank cycles. In
> practice I hit it when a KMS application exits: it frees its buffers
> while fbcon takes the display back with a full modeset.

Thanks for reporting this - with your reproducer I could also trigger the hang
on my Rock5B board, after ~15 cycles.

> This issue can be fixed for me by moving vop2_reset_assert_deassert(vop2, vop2->axi_rst) from vop2_disable to vop2_enable.
> 
> --8<--
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
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
>  	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
> -->8--
> 
> Does that work for the cases the reset was added for (the RGB <-> YUV420
> switch glitches and the DSI panel on the EVB1)? I can't test those here.

I briefly tested the RGB <-> YUV420 mode switches and didn't notice any obvious
regressions. For the EVB1 we need Sebastian's help, as I don't have that board.

Would you like to send a proper patch in the meantime? 

Regards,
Cristian
