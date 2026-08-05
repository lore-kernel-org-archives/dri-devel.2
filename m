Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF72C55182
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A16E10ED4A;
	Wed,  5 Aug 2026 07:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kbSZQ5H8";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2E710ED4A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:33:56 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso3800705e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785915235; x=1786520035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=maje+uHgFgcFdWCfN1jxwTGwT5C9iQGlKEpupK5PaMY=;
 b=kbSZQ5H8o4gLMXsjnSVnTJJ7Di4CBkkf/WLL62A6AwV6yktr4vTMi+O68yFx1EHMKk
 5N5z0czN8518AA2tMgdesibu3tC09taq8b785gLTS0cSX4Ow/ItSRWlYZcH/uBk6qKu4
 I5p70gFJIKfBH0LmTGf4cEXcDPBVflB8FM61ueLCaUY1lt1zYbXT0DzrIIcXXPh66k6f
 q22NoY97MO55+YYW8i5Af2jnnf2G8iiRTFzFVRwJTWqS84dqFw+AkqNEMRXqJpqqi2Ys
 nMuoxgFKDDbRGQbJJaaZkKv1u5lUFaBNrzD8uABDmCXjrc89fNfiIU9TRM7XI/P56PrF
 iYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785915235; x=1786520035;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=maje+uHgFgcFdWCfN1jxwTGwT5C9iQGlKEpupK5PaMY=;
 b=eYc1KxSyoofyQii2YxvBw2htTdhXmPzDoUeqbAfmLKufdKTMIelkfo+yEAdVsQV8pQ
 2d1nim22OGx7sNeRqBHGBt+6TlZB37RpFIMF+2dyCpBJBhVpNtBx2Hddvird1oFaS87C
 i+6n6YeQrs7Srhzw21+XAxom1n3nYZJNVuD3ZqcAGwtyhGTiAWyWu8iSJIAyXMIkpfw9
 NBiXsmUulqbOTdAXcs8G7dEoeM0RMvZvTx5XkkajT2d1QkONH3GbFjvYT1tYz3d2+izr
 uJ3NxTM69Fk5rQ1h/4esy6QDzjgj9o0zH2lz0kXJ7Koxn/zzt7yE4wLxezc7Lnwx9NMf
 XRwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVNTg4zt6qk/WsmDGDBwrsO5P+I41R7yAM9KCZgD60SQDwCNz+7RnZtkocXZxcoSnmwqdqHrc+wxI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxI/bhHygD7YK1yFDLb0wohp9/P6tDyPbw2H/Co9KdCiaqIv70
 OKd+l6qvcI7vPUVUM6Nu6YuHXam/uz8P6SKMiqj9KPLhD8hpKeET8dLk
X-Gm-Gg: AR+sD11bj8rfxxpy0CBTVyFTGlU5zDGyr4vLiLQtYj27k7ZYLjG/zToqFIXNcbiaQyp
 PnJYEjdHIEG0jgHbdVfSB3+NrrkCpDQLfHQm/awL+gKiRYg8mMf8oCg7iFSBO22XaW/ccrVhjCA
 4w4mfxd0Y7rVlZmBA2haCktyL6R9g5Wi5cQsqxudY04Cz7F6AnPogp6zwJzV5qNVFjGj4qz2m9f
 cP2ZVxAiitFnjAI1RoZXJas8LZlK+AHpO2uUJ4eUYGYMAyKfSTuP7L5JPwX9Pp7HIXvG/67m5Rf
 yI063iAW0YOHwowYx5H4omWuzm58pwuGSon0nuAEpiWHutFTTMXH+423fqNVKFRuaGzrzwWoJU7
 DW2JTt6770cW9A7w091jfhPJ4VkPPTTkOd6edfJeXNqH5XUMc12H2DtmVFXS0Vkqhw6Os3D7S0s
 sZWaPJlARdMDtRehQMLuq50LfbZAf6G1mRjycL/7FSFiD70ZoqQc+02yGIFRVx9+QEsO9IwXUq
X-Received: by 2002:a05:600c:1f96:b0:496:c249:dd9a with SMTP id
 5b1f17b1804b1-4994e71364fmr50492655e9.3.1785915234885; 
 Wed, 05 Aug 2026 00:33:54 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4994e04269bsm67880905e9.13.2026.08.05.00.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 00:33:54 -0700 (PDT)
Message-ID: <3e9d4534-fea8-412b-a059-32d5906c0463@gmail.com>
Date: Wed, 5 Aug 2026 10:33:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/omap: dsi: avoid sending bta sync all the time in
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
References: <20260804-vm-upstr-v6-1-1bf3748b2fa3@kemnade.info>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260804-vm-upstr-v6-1-1bf3748b2fa3@kemnade.info>
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

On 4.08.26 г. 11:37 ч., Andreas Kemnade wrote:
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


Tested on motorolla droid4 (command mode), no visible issues so far.

> ---
> Changes in v6:
> - clear errors on every write
> - remove unneeded forward declaration
> 
> Changes in v5:
> - send bta sync on VC_CMD again
> - Link to v4: https://patch.msgid.link/20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info
> 
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
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 63 +++++++++++++++++++--------------------
>   1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27fe7bca9e2c..27bf9bbe0697 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -58,9 +58,6 @@ static void dsi_uninit_dispc(struct dsi_data *dsi);
>   
>   static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel);
>   
> -static ssize_t _omap_dsi_host_transfer(struct dsi_data *dsi, int vc,
> -				       const struct mipi_dsi_msg *msg);
> -
>   #ifdef DSI_PERF_MEASURE
>   static bool dsi_perf;
>   module_param(dsi_perf, bool, 0644);
> @@ -2194,28 +2191,45 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
>   static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>   			       const struct mipi_dsi_msg *msg)
>   {
> +	DECLARE_COMPLETION_ONSTACK(completion);
>   	struct dsi_data *dsi = to_dsi_data(dssdev);
> +	u32 err;
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
> +	} else {
> +		err = dsi_get_errors(dsi);
> +		if (err) {
> +			DSSERR("Error while sending: %x\n", err);
> +			return -EIO;
> +		}
>   	}
>   
>   	/* RX_FIFO_NOT_EMPTY */
> @@ -3233,21 +3247,6 @@ static int _dsi_update(struct dsi_data *dsi)
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
> @@ -3268,13 +3267,13 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>   	DSSDBG("dsi_update_channel: %d", vc);
>   
>   	/*
> -	 * Send NOP between the frames. If we don't send something here, the
> +	 * Transition to LP here. If we don't send something here, the
>   	 * updates stop working. This is probably related to DSI spec stating
>   	 * that the DSI host should transition to LP at least once per frame.
>   	 */
> -	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
> +	r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
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
