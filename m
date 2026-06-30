Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF188C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 05:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A64610E175;
	Tue, 30 Jun 2026 05:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bG2yM5HQ";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD16010E17A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:43:01 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so28575465e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 22:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782798180; x=1783402980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l60qb829+b056CbQNBxrBvUbd99a3Y5SxJc1xaAoFIk=;
 b=bG2yM5HQudHAd6yQG2fwdbXy1JgU4bB6rftQLvHtvKa93UiF29sKxCl9j/7mHvo0OF
 OHCIobel7mdNwBBvz803eQdYqNJdyCHBfEFDoEFWwk0r1cfnajg0hl6/ibUjRVJF4NxF
 KYYqCD1YMex/p24mmYYXdT5nJZepB2GDZL/4ZL/Lv7FwN+KAdGeyNE+rQkXLs/SeJXik
 6UN2LqUwhZdpugpQvrURJCL07kCIMnqUgOCgEWQePIGK0Pxt6VFJq/8H63z2ouhdgngh
 KhuCUx1Gk56eMUIQOmwVdt0cCwp9+KpR7hQPJzHCsBLre3aEbV3NqaD8X8TbvvrPMN6o
 7JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782798180; x=1783402980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l60qb829+b056CbQNBxrBvUbd99a3Y5SxJc1xaAoFIk=;
 b=StoXiCSS3pGFpmJkHTQC0cL33Kx/dZw1CjwuLlrbw5IIy0uFZOOzHe4mcMhlcIQ0QK
 dPTjEOzs9S5CmPqXIRJGwiSYm4IGyWrnjDJAbPR6FY2SNMNf1rcWbHWrEhYV7SP/nRtl
 vmmBIZQ5e6wq1usOIv1bGJJ8bpBHz7DIxypnvnVKY7qOvKdsZzgDYeUzT1syC5uUfEhs
 wGc7NQQNoDmjbW/T41coDHW48NPGzp/tTlGJK/KIWi8RqFiGGEfdJB6krmbL0VoUxJ4T
 apwFb3A6nmfIgH9np6/D5HK0rm8aa1hDPvZtd0TIBVwOaHMAt6Hq4vf6umE8LIQtnsUL
 cIjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/R7ze1IuPSTtK8xfsRIqdtV0C/DSpKdYOgCb0v81BQev6nnGlNMKY1phAuAMh3mQ1Gqcyhavk2QXE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxePF0vAJHpbb5Q/KnBbSZ57d3Ir0q6dz3J4MQkXVqNocovxGhf
 +5KM1j7wlnuoUiIof0AtU3yZy2JE7cudNi9ovQKynD2ItVCWcf6tlM7e
X-Gm-Gg: AfdE7cn17LsISIzIuCJA/KIdhfhUSdzZfL5V0KrRaO/uJltm8D1qEVmwVqEv5kT5PKn
 cfdNOBYXqNH4bSj9bQtbAPI3S8FW0OhhQdACt8oE6A648hiRZzMhTAVTozeYbS/I9CNc7z+MITa
 IPs39shcSJCvt2nvW7JV5KZPwKp3WfTjhlfgmCe6faRyZVslY6MXuDBmkKELRu0SyJdl/RMk2//
 fCykbj4cn3RRJyZzLzPWLzXxW2GDST1qEVoBaYxZ+Zw372iuHvd8HSNKimZIf0X77K7t6iasAdx
 NDrljS1+xPrRhkLBlxq9x21Ol6Wk+eRA15Vup23uSLclfz9xZMom+2ZBPRCdJeFZlVwh+jSdQ2T
 7Bf6m/RbQYL06EBel+0ttzgSLWo4jGOSMx4PXDFNrVInc9N7Xs2+RSnA1116RDWLA37vJ5Sj2zn
 6gM0+p0UT179dJ9vpQ13/h+N8KRAyLN0Hnz6Q=
X-Received: by 2002:a05:600c:1f8f:b0:493:a5d4:3798 with SMTP id
 5b1f17b1804b1-493b827f5ffmr33416535e9.1.1782798180072; 
 Mon, 29 Jun 2026 22:43:00 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47563d194bbsm4025453f8f.3.2026.06.29.22.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 22:42:59 -0700 (PDT)
Message-ID: <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
Date: Tue, 30 Jun 2026 08:42:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <andreas@kemnade.info>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
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

Hi,
With this version of the patch I see:

[  102.760894] DSI: omapdss DSI error: Framedone not received for 250ms!
[  303.860321] DSI: omapdss DSI error: Framedone not received for 250ms!
[  307.071624] DSI: omapdss DSI error: Framedone not received for 250ms!
[  307.360626] DSI: omapdss DSI error: Framedone not received for 250ms!
[  307.671142] DSI: omapdss DSI error: Framedone not received for 250ms!
[  308.660339] DSI: omapdss DSI error: Framedone not received for 250ms!
[  308.961059] DSI: omapdss DSI error: Framedone not received for 250ms!
[  313.191314] DSI: omapdss DSI error: Framedone not received for 250ms!
[  313.700378] DSI: omapdss DSI error: Failed to set dsi_if_enable to 0
[  313.980346] DSI: omapdss DSI error: Framedone not received for 250ms!
[  314.791564] DSI: omapdss DSI error: Framedone not received for 250ms!
[  315.090362] DSI: omapdss DSI error: Framedone not received for 250ms!
[  322.850952] DSI: omapdss DSI error: Framedone not received for 250ms!
[  323.111175] DSI: omapdss DSI error: Framedone not received for 250ms!

while scrolling the (hildon)desktop on droid4, so I would say the change 
broke command mode.

Regards,
Ivo

On 29.06.26 г. 18:50 ч., Andreas Kemnade wrote:
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
> In Command-Mode update, there was a nop sent, apparently the most
> relevant part was the bta sync to actually force low power mode.
> 
> Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
> 
> Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v4:
> - wait on completition on all packets (was limited to long packets only,
>    because I had the wrong impression that there is no confirmation on
>    these)
> - Link to v3: https://patch.msgid.link/20260628-vm-upstr-v3-1-9e9add93378b@kemnade.info
> 
> Changes in v3:
> 
> - Link to v2: https://patch.msgid.link/20260529-vm-upstr-v2-1-24c30671719f@kernel.org
> - fix things mentioned by claude here:
>    https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch1-20260529-vm-upstr-v2-1-24c30671719f@kernel.org/
>    - fix typos
>    - register ISR before sending packet
>    - check for RX_FIFO_NOT_EMPTY also in for short packets
> 
> Changes in v2:
> - fix commandmode update, need bta sync there
> - do not wait on short packets
> - Link to v1: https://patch.msgid.link/20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org
> 
> To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 53 ++++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27fe7bca9e2c..3f22929c36e2 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2194,28 +2194,38 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
>   static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>   			       const struct mipi_dsi_msg *msg)
>   {
> +	DECLARE_COMPLETION_ONSTACK(completion);
>   	struct dsi_data *dsi = to_dsi_data(dssdev);
>   	int r;
>   
> +	/* wait for IRQ for packet transmission confirmation */
> +	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> +				&completion, DSI_VC_IRQ_PACKET_SENT);
> +	if (r)
> +		return r;
> +
>   	if (mipi_dsi_packet_format_is_short(msg->type))
>   		r = dsi_vc_send_short(dsi, vc, msg);
>   	else
>   		r = dsi_vc_send_long(dsi, vc, msg);
>   
> -	if (r < 0)
> +	if ((!r) && wait_for_completion_timeout(&completion,
> +				msecs_to_jiffies(500)) == 0)
> +		r = -EIO;
> +
> +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> +			      &completion, DSI_VC_IRQ_PACKET_SENT);
> +	if (r)
>   		return r;
>   
> -	/*
> -	 * TODO: we do not always have to do the BTA sync, for example
> -	 * we can improve performance by setting the update window
> -	 * information without sending BTA sync between the commands.
> -	 * In that case we can return early.
> -	 */
> +	/* TODO: find out if more needs to be done for MIPI_DSI_MSG_REQ_ACK */
>   
> -	r = dsi_vc_send_bta_sync(dssdev, vc);
> -	if (r) {
> -		DSSERR("bta sync failed\n");
> -		return r;
> +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
> +		r = dsi_vc_send_bta_sync(dssdev, vc);
> +		if (r) {
> +			DSSERR("bta sync failed\n");
> +			return r;
> +		}
>   	}
>   
>   	/* RX_FIFO_NOT_EMPTY */
> @@ -3233,21 +3243,6 @@ static int _dsi_update(struct dsi_data *dsi)
>   	return 0;
>   }
>   
> -static int _dsi_send_nop(struct dsi_data *dsi, int vc, int channel)
> -{
> -	const u8 payload[] = { MIPI_DCS_NOP };
> -	const struct mipi_dsi_msg msg = {
> -		.channel = channel,
> -		.type = MIPI_DSI_DCS_SHORT_WRITE,
> -		.tx_len = 1,
> -		.tx_buf = payload,
> -	};
> -
> -	WARN_ON(!dsi_bus_is_locked(dsi));
> -
> -	return _omap_dsi_host_transfer(dsi, vc, &msg);
> -}
> -
>   static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>   {
>   	struct dsi_data *dsi = to_dsi_data(dssdev);
> @@ -3268,13 +3263,13 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>   	DSSDBG("dsi_update_channel: %d", vc);
>   
>   	/*
> -	 * Send NOP between the frames. If we don't send something here, the
> +	 * Transition to LP here. If we don't send something here, the
>   	 * updates stop working. This is probably related to DSI spec stating
>   	 * that the DSI host should transition to LP at least once per frame.
>   	 */
> -	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
> +	r = dsi_vc_send_bta_sync(dssdev, vc);
>   	if (r < 0) {
> -		DSSWARN("failed to send nop between frames: %d\n", r);
> +		DSSWARN("failed to send bta sync between frames: %d\n", r);
>   		goto err;
>   	}
>   
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260528-vm-upstr-c8e7634ebf56
> 
> Best regards,
> --
> Andreas Kemnade <andreas@kemnade.info>
> 
