Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B577606A336
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=NeQg5WF0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EBC10EF2D;
	Tue, 10 Nov 2026 09:59:48 +0000 (UTC)
Received: from mail-m6040.netease.com (mail-m6040.netease.com [210.79.60.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCCC210EF2E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:59:41 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54272b12f;
 Tue, 10 Nov 2026 17:59:39 +0800 (GMT+08:00)
Message-ID: <4fe3809c-1243-4290-abb7-c2025cfffe55@rock-chips.com>
Date: Tue, 10 Nov 2026 17:59:34 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/rockchip: vop2: Keep the other LUT_PORT_SEL
 fields on gamma LUT updates
To: aiyengar1990@gmail.com
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
 <20261110-vop2-fixes-v1-7-d336e9dd90d3@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261110-vop2-fixes-v1-7-d336e9dd90d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1c4e6230803a7kunm170f4cac71683e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0lCVkhJGkIdGhlJTxgeH1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=NeQg5WF05QqwqNMEh/5PIv4tY08ihs/bAA0gQ9ZQ9b1HtYcrxvSNNVB3aFRXVWkgFWLUlRSbzJk7ESzhua4juivde+DQaRtroOjXb/jvRpla2nlxTgnra5jAFeTcGXusnSQgmxtQzSlyHpsjWe71Ev9+NUEjy1OWL/wPm1sNVco=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=B5FetUpkGwGLsikqm7LuzqYKP4h6EEv4RA9Kg5VS7Q4=;
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

On 11/10/2026 3:18 PM, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> On RK3588 the gamma LUT of a video port is written through a window that
> GAMMA_AHB_WRITE_SEL in SYS_CTRL_LUT_PORT_SEL selects. The register also
> holds the dclk source selection of video ports 0 and 2 and the enable of
> the video port 0/1 merge for modes wider than 4096 pixels, which writing
> the whole register clears.
> 
> Only update the write select field.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 3323e50224c5..9ad138457204 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1774,8 +1774,9 @@ static void vop2_crtc_atomic_set_gamma_seamless(struct vop2 *vop2,
>  						struct vop2_video_port *vp,
>  						struct drm_crtc *crtc)
>  {
> -	vop2_writel(vop2, RK3568_LUT_PORT_SEL,
> -		    FIELD_PREP(RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL, vp->id));
> +	regmap_update_bits(vop2->map, RK3568_LUT_PORT_SEL,
> +			   RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL,
> +			   FIELD_PREP(RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL, vp->id));
>  	vop2_vp_dsp_lut_enable(vp);
>  	vop2_crtc_write_gamma_lut(vop2, crtc);
>  	vop2_vp_dsp_lut_update_enable(vp);
> 

-- 
Best, 
Chaoyi

