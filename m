Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02390CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 14:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B76D10F2CD;
	Thu, 28 May 2026 14:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjISREKI";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E962410F2CD
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:44:18 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso7584908f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779979457; x=1780584257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+B00isbVBFjhd0ersE38u3Z7GxR7KNbXX2WyPtNeCI4=;
 b=XjISREKIju/QlveM/FRdgRtYzxirH9GnciNhYP+5sT0ozplhsUsGIt7Oncjoqbw29A
 zXupg3Il29/pmDioANUYB5lWJqv6rC7XKjOfVC7EHkTObESQi+pBFnnXkTdOwR+N6B5h
 61GJp1cZ5pLW3w6yd2dvG2B/X29132YR6KkOCBUujQksRT5jx0p7PqVRiNw4huhIYrAh
 86GM7facQTzjP2048kg0qEKGNE33kfA4WVJW9AfrmDWg8uF9sKxYR7VaLqV63DWVMOAA
 sP6Hj9QXSEf2JTTow1k/0oaDo7XFBrOOdDsyOw5gXCRqiIORA3cWH/VmSxfYV1/eKY6B
 cqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779979457; x=1780584257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+B00isbVBFjhd0ersE38u3Z7GxR7KNbXX2WyPtNeCI4=;
 b=JfqIj+V3nU53lVxA3Zxe86e+jPWPz62daQq3X5jBJFsC/s/9483bh4QA1FMl/8dUn6
 aU2JvJKrv3tD7Lw6Mn0d1ITj8ceLSPDpRc5LsyCtu67D1WTorwOZNqbeXAMReYtNsNbL
 z/0YUh0x1RPO7qc44ELJOWaeWI5tc9jDFRUhGFjKc4nucpZfMQ1DMbgHDMvq5GHIJGKe
 E2ECVM5PkOHA4Yd2LKRI5o0keVu0qrL//pCROg9mCz7jE7ZWK8/eh+rCRtGGYioW/5cH
 cZTyD3kIlxLQ0hM7mnEKnBwerBS+GXabdw56myyP9GvMLPF1epn1Sgb8KIeSRF+ETTef
 GxhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Qri1Qp2D4E9FnMEIhf+TugKcpe4a8Pn8A4b3omstuKkvt5GXLJqq5XymetfSkCvWoW2z8FHZdHBU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUjs06Ur07ZbamDik91lA/g2j3shKCU9GlmIrSh27ASFnWhXUR
 8vjYN6Wi9w2rc1RAe96TdysDGlAQ98iYiJV1U2QW4hkXxRq1wPVhsHBb
X-Gm-Gg: Acq92OEhM+7n4D+KpgoIs9x1sLl5k9uaUkuqjEJZQIu4XZti4534kGaOWaraVk2Mj+d
 9KpSF90O3B8GPlEDpqghSfxkV+qlcLV7h+RCZ3yJ84egw0nyXvRk76I1ZRBXaLWC6gheJ1uOkTe
 E+A2WjhAB+Cv228WW1BO+42YBURY3SIOlHF86Zo3zij8TnNC0nfLr1bIf43zP1zyIgoq4pj3i8h
 syyTD2xyjicaS11ifSZKNhqX+19Fzxa1+NAe6RulJ3zQEicYdtgnMdHM9Sys20866U6QwDmcPE1
 mT+bqJ7pnlq2ugL/rJlBuGKNqnsOiN/Wo2QbtswMx80C4I2y9l+PYLjoV+wi99c1r/aBnPpw4U6
 26xhX8zAJ/WgEz2ySsSpN6wZc7q/gNPnGuTtmqo/20/cAlLSVbCyE77ez1KmyrOAzqn4GATrTAG
 NHerIfh9ENS45VN8V+51X/+hLjKaVSsFs1NxC0+TYrPN3oxw==
X-Received: by 2002:a05:600c:8a0d:20b0:490:32da:30d with SMTP id
 5b1f17b1804b1-4904249742cmr336725155e9.9.1779979456942; 
 Thu, 28 May 2026 07:44:16 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-49092654befsm44027825e9.6.2026.05.28.07.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 07:44:16 -0700 (PDT)
Message-ID: <ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
Date: Thu, 28 May 2026 17:44:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: akemnade@kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Andreas Kemnade <andreas@kemnade.info>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Applied against 6.18.31, no dice :)

[   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on 
minor 0
[   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops 
dispc_component_ops [omapdrm])
[   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops 
dsi_vc_flush_receive_data [omapdrm])
[   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on minor 1
[   12.311981] [drm] Enabling DMM ywrap scrolling
[   12.770385] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[   22.901306] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   22.901306] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit 
wait timed out
[   33.131256] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   33.131378] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1] 
commit wait timed out
[   43.371307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   43.371398] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0] 
commit wait timed out
[   43.631408] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[   43.692504] omapdrm omapdrm.0: [drm] fb0: omapdrmdrmfb frame buffer 
device
[   54.251342] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   54.251464] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit 
wait timed out
[   64.491302] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   64.491424] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1] 
commit wait timed out
[   74.731323] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   74.731445] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0] 
commit wait timed out
[   74.991363] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[   85.621307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   85.621398] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit 
wait timed out
[   95.851287] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[   95.851379] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1] 
commit wait timed out
[  106.101257] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[  106.101440] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0] 
commit wait timed out
[  106.371459] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[  106.961334] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
[  141.301269] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[  141.301269] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit 
wait timed out
[  151.531280] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
[  151.531402] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1] 
commit wait timed out


On 28.05.26 г. 13:16 ч., akemnade@kernel.org wrote:
> From: Andreas Kemnade <andreas@kemnade.info>
> 
> Some chips need configuration commands to be sent first, before they can
> send data. TC358762 for example needs PPI_LPTXTIMECNT configured
> and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
> configure such chips, do not send bta sync during writes if no acks are
> requested. Instead just wait for the packet to be sent to avoid FIFO
> overflows. There might be more to do about acks, but there seem to be
> virtually no users of that flag.
> 
> This came to light when fiddling with the Epson Moverio BT-200 display
> which consists of 2 TC358762 bridges with SPI funneled through
> to the unknown display chip. With that patch the bridge can be accessed,
> Reading back registers works, when the above-mentioned registers are set.
> 
> Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
> 
> Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> This was not tested on any command mode display, which IMHO should be
> done.  So droid4 folks: please give it a try
> ---
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27fe7bca9e2cf..98362b0157023 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2194,6 +2194,7 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
>   static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>   			       const struct mipi_dsi_msg *msg)
>   {
> +	DECLARE_COMPLETION_ONSTACK(completion);
>   	struct dsi_data *dsi = to_dsi_data(dssdev);
>   	int r;
>   
> @@ -2205,17 +2206,30 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>   	if (r < 0)
>   		return r;
>   
> -	/*
> -	 * TODO: we do not always have to do the BTA sync, for example
> -	 * we can improve performance by setting the update window
> -	 * information without sending BTA sync between the commands.
> -	 * In that case we can return early.
> -	 */
> +	/* wait for IRQ for long packet transmission confirmation */
> +	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> +			&completion, DSI_VC_IRQ_PACKET_SENT);
> +	if (r)
> +		return r;
>   
> -	r = dsi_vc_send_bta_sync(dssdev, vc);
> -	if (r) {
> -		DSSERR("bta sync failed\n");
> +	if (wait_for_completion_timeout(&completion,
> +			msecs_to_jiffies(500)) == 0)
> +		r = -EIO;
> +
> +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> +			      &completion, DSI_VC_IRQ_PACKET_SENT);
> +
> +	if (r)
>   		return r;
> +
> +	/* TODO: find out if more needs to be done for MIPI_DIS_MSG_REQ_ACK */
> +
> +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
> +		r = dsi_vc_send_bta_sync(dssdev, vc);
> +		if (r) {
> +			DSSERR("bta sync failed\n");
> +			return r;
> +		}
>   	}
>   
>   	/* RX_FIFO_NOT_EMPTY */
> 
> ---
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> change-id: 20260528-vm-upstr-c8e7634ebf56
> 
> Best regards,
> --
> Andreas Kemnade <akemnade@kernel.org>
> 
> 
