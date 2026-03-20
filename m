Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106211093172
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 03:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A1810E89E;
	Fri, 20 Mar 2026 03:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="FqwzNt3W";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BC810E89E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 03:59:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5243A10C4E3; Fri, 20 Mar 2026 04:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773979146;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8/Vm0DnGx4oYEEoZEmyuXoKoZ7F37xeqJ9VudjPDGo0=;
 b=FqwzNt3WJelauIUpjoIb5Io76RQxmP3gbujxlEI5wPPGYNDZjhComzSW9WDmcFK9CTCZ3P
 UTg6RCJu7rluVHNYpneCqupUNd2g8TATNuY6ySh/1w0F+2dsj3R/zhU0nDXaKoZc3YiFdJ
 ++pssdBQn2vK8+pW1F1NafQYiAGiOitRiYFINXPqTBketa7KH7cc0HVMrcaoyUsT7EQcb4
 dWmV6fjPIRXNBSucr15HTcMK6wSpf8RKAS/XF+Qv+Yjp8Ev8RKzcJix08PJD4OoIcxiYS+
 qttTU7NYYIYV1cIk5J6aQEY4TmOukFQm/SazavAReyzOjM7m5fj/q/8OxPyt0Q==
Message-ID: <32317022-3c44-4ead-9e2d-04caa12b28cb@nabladev.com>
Date: Fri, 20 Mar 2026 03:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@nabladev.com>
Subject: Re: i.MX8MP: Fix HDMI LCDIF FIFO underruns
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Stefan Agner <stefan@agner.ch>, Liu Ying <victor.liu@nxp.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <m3ms04caaj.fsf@t19.piap.pl>
Content-Language: en-US
In-Reply-To: <m3ms04caaj.fsf@t19.piap.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/19/26 12:45 PM, Krzysztof Hałasa wrote:
> Running (and terminating) Weston on i.MX8MP sometimes produced black
> or grey screens. The LCDIF3 INT_STATUS_D0 register showed a FIFO underrun:
> 
> 32FC6024: 1000002
> 
> The PANIC0_THRES register was set to:
> 
> 32FC6238:  AA0154
> 
> which apparently meant low = 2736 bytes (0xAA * 16 + 16), high = 5456 bytes
> (0x154 * 16 + 16).
> 
> With this patch (based on NXP's driver) the watermarks are only 16 bytes
> higher (register values increased by 1) and the underruns are gone.
> 
> Tested on Solidrun Hummingboard Mate with a 1080p60 HDMI display.
> 
> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
> 
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> @@ -353,8 +353,8 @@ static void lcdif_enable_controller(struct lcdif_drm_private *lcdif)
>   	u32 reg;
>   
>   	/* Set FIFO Panic watermarks, low 1/3, high 2/3 . */
> -	writel(FIELD_PREP(PANIC0_THRES_LOW_MASK, 1 * PANIC0_THRES_MAX / 3) |
> -	       FIELD_PREP(PANIC0_THRES_HIGH_MASK, 2 * PANIC0_THRES_MAX / 3),
> +	writel(FIELD_PREP(PANIC0_THRES_LOW_MASK, DIV_ROUND_UP(1 * PANIC0_THRES_MAX, 3)) |
> +	       FIELD_PREP(PANIC0_THRES_HIGH_MASK, DIV_ROUND_UP(2 * PANIC0_THRES_MAX, 3)),

I am starting to wonder, whether this should be configurable in DT, 
because it seems there might be users that need to tweak the watermarks 
one way or the other for different video outputs ?

+CC Liu
