Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7B2CA9EC5
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF618911F;
	Tue, 13 Oct 2026 00:16:39 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33828911F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 00:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791850592;
 bh=F/SEf/BuwTeqba34gC8pPzyRzy4PFwO2wuNaq6RUTaA=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=OvQCtLjT7XqwHrLWr+t14JiBApJLhq1/jtSbxhp7TjiaH74kGNlPh9pyAeJxSGiL2
 PCHaQd77ysO9idI6FVK4YttNcLrkSNsbsvKZlfXdY65Ba+Eh2vLMHPR29H2wi0mdfG
 YUuip+AKJa7CxXSu2JD6ShDVZLJUHxae+Ic1DbdkN46wiOD4FUsCRh91/CdIcVz/YF
 AkVKje4l6I0uY73lmcAhGFR3obP+HAfnCzX8RE4BVb+7CxQOhLgCPs8bgWCCqArhLv
 /AMLsCizCv/vq/vREJU4XgcqT2iWE2Y45b4rLfoSM7370Ko/X0s9AN1MX6wWTYL5B+
 kfZcj5WDQkrhA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 946E217E011B;
 Tue, 13 Oct 2026 02:16:31 +0200 (CEST)
Message-ID: <682b6dc0-0b9f-4b2c-afd5-459e3f669130@collabora.com>
Date: Tue, 13 Oct 2026 03:16:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165
 MHz
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com>
 <20261013-vc4-common-scramb-v2-2-a41d15e131ad@collabora.com>
Content-Language: en-US
In-Reply-To: <20261013-vc4-common-scramb-v2-2-a41d15e131ad@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Dave,

On 10/13/26 1:37 AM, Cristian Ciocaltea wrote:
> Historically, the HSM clock for BCM2835 was fixed at 163.7 MHz.  Since
> the pixel clock had to be at least 1% below the HSM clock, it was capped
> at 162 MHz.
> 
> Since commit cd4cb49dc5bb ("drm/vc4: hdmi: Adjust HSM clock rate
> depending on pixel rate"), the HSM clock rate is set to pixel clock *
> 101 / 100.  For a 165 MHz pixel clock, this gives an HSM rate of 166.65
> MHz, which, per Dave Stevenson, the hardware can handle without issues.
> 
> Increase the max pixel clock to 165 MHz, which matches the maximum TMDS
> character rate of HDMI 1.0 through 1.2.

It seems this will cause CEC register corruption:

https://sashiko.dev/#/patchset/20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com?part=2

We can easily address this by clamping the CEC clock divider to its register
field width:

-       clk_cnt = cec_rate / CEC_CLOCK_FREQ;
+       clk_cnt = min_t(unsigned long, cec_rate / CEC_CLOCK_FREQ,
+                       VC4_HDMI_CEC_DIV_CLK_CNT_MASK >>
+                       VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);

The consequence is that the CEC clock would run slightly faster than the nominal
40 kHz, i.e. (165000 × 101/100) / (2^12 - 1) = 40.6959 kHz.

I think this is still within the CEC bit-timing tolerances and shouldn't cause
any issues.  Could you please confirm?

Regards,
Cristian

> 
> Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 8e4623ccc4f8..e61f1b694dbe 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1507,7 +1507,7 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>  	 * users are able to use pixel clocks closer to HSM's, namely for
>  	 * 1920x1200@60Hz. So it was decided to have leave a 1% margin between
>  	 * both clocks. Which, for RPi0-3 implies a maximum pixel clock of
> -	 * 162MHz.
> +	 * 165MHz.
>  	 *
>  	 * Additionally, the AXI clock needs to be at least 25% of
>  	 * pixel clock, but HSM ends up being the limiting factor.
> @@ -3363,7 +3363,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>  	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
>  	.debugfs_name		= "hdmi_regs",
>  	.card_name		= "vc4-hdmi",
> -	.max_pixel_clock	= 162000000,
> +	.max_pixel_clock	= HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
>  	.registers		= vc4_hdmi_fields,
>  	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
>  
> 
