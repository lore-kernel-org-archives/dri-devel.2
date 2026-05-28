Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1089CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 17:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EE510F4D5;
	Thu, 28 May 2026 17:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCr4OLQB";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A4310F4D5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 17:43:16 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so53651875e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779990195; x=1780594995; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W3amWZObV5I3DzXB5gq3TI2uVawFzEbcyJa+h0g3Fi8=;
 b=LCr4OLQBRZflx5K3Njmx9yL80NTsveJs9hrSrJQ95A8Veb3RRQYptR/4qe3nfPDjO/
 N6NRKAzwm71xM1Ax2G/eZRYyN+P/fJ3yF2voW6+lsE67ijT7q6iMpUiSBHmeSrlCAYhz
 +LvmV7N6f/fR9Ad9A3ekt22T1JPFSwUp4b2HVe2HxAO437QwJotrbg0PYzN0ynxsShVb
 75OGhvXz1ydJ2xnOis73jQONt6vOpfkKfj/Gz6+HDr+uT1DR+juEtKRptajYaMoA3XXK
 LnOIre1Dm4pUF0EQRJBdAyYbVhtLmN8pQJL4i+vQ4kFABxPQUSRHYV97DrJJHy1Zb+5O
 H0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779990195; x=1780594995;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W3amWZObV5I3DzXB5gq3TI2uVawFzEbcyJa+h0g3Fi8=;
 b=kuqCjgwTHUD4uutxEpetGWrWwsv0wIjwGgdrf3RRu/EVuAguv+McKMfGDrRBNdxvz8
 Rgg4EgZCh171YrsdHqT9y/PwGpF3SCRO7iVrWUwFa5eZsoK0cw8oLKy/gQFt35Gs0BOI
 dED935Wcp7342YOzxqP3rrO5AwqdFM4rVsVA2eJTwUT4d7o/ADPXSnaLdP6rjkTzNb2n
 bLxTmmsXUKEDxNYdb6C1gjsbszKRmT1imbjzq9VEgH1YiqQFoDx0AgQxcco3qX/N0ioO
 hnoq2UsqrZDyGqSK9byEvqjg7sEDJZPd8mv/525W3nN4yYOOhq+bmoQKg5zn6UUsvM4M
 S+sA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+zaqcXK58xxAsnRqtMydfSxDXp/G73xrz6xAgZj5HEXBpHBeMwWQtXQpmXA8QnpC6RPzdltLaVNE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUx/BISc86Z7yUdxqS/vmovwuy9hHje9Qcwc6gNoPSM0UXQzvK
 8bWAi5TI/kpzRdG2IiwFxNy9dWZHgCkeYlwAShAZ7klPJ/i8NexwcMO6
X-Gm-Gg: Acq92OEehjBNcfvXXYkM0Llv5RTPG4notaaYIgkH3cxR6qJqBcbNjKKbIsmTnK//ObW
 cLYd7HEKH/Kx07EBXyTf3pRYiBd9aUyAqWB8WZdmcolFoCz32HSHYcyDP5GwaSHX930WPl3Ukwt
 r9p3TO7GPacDR9VJpmp9VovZzs83DgbrP6+zFbUbSzLmNjax4ZSInwICKx1dJcW1Z66fouSx9gr
 0C8/FSNXupTdYrDW2bHiVEB0pRC71mPNfTHCdpZPxpGX4LkiKIyIyFAupsCCh/HSKize3S/Hqrv
 ROedMjuikyNBn+hFPfu5LDG0hVOm/oM1kt9ZKz5C76JK7QjzGXCBAIjwhweV3LdoHWmlJaBkLRd
 dIqMfSvxcetNvbOa0Vh9fAe7p24ZMxzOcuMoFc/dQTeOYxc5h9Q/y3Cvhry2f7Ii4jKOI/9CDO3
 FK72kcJ6W3CJhhemIVWnvwONDsliLoH6jgYOpr5g3XMG8LFw==
X-Received: by 2002:a05:600c:4591:b0:490:6869:46c6 with SMTP id
 5b1f17b1804b1-490686947a8mr269136535e9.31.1779990194506; 
 Thu, 28 May 2026 10:43:14 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909235d43esm87284155e9.1.2026.05.28.10.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 10:43:14 -0700 (PDT)
Message-ID: <37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
Date: Thu, 28 May 2026 20:43:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <akemnade@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Marek Vasut <marex@denx.de>, "H. Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Andreas Kemnade <andreas@kemnade.info>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
 <ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
 <20260528190234.4c00b740@kernel.org>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260528190234.4c00b740@kernel.org>
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

On 28.05.26 г. 20:02 ч., Andreas Kemnade wrote:
> Hi,
> 
> so this droid4? Or which device is it?
> 

Oh, sorry, yes, this is droid4.

> On Thu, 28 May 2026 17:44:14 +0300
> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
> 
>> Applied against 6.18.31, no dice :)
>>
>> [   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on
>> minor 0
>> [   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>> dispc_component_ops [omapdrm])
>> [   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops
>> dsi_vc_flush_receive_data [omapdrm])
>> [   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on minor 1
>> [   12.311981] [drm] Enabling DMM ywrap scrolling
> 
> I would expect some
> output from  the panel-dsi-cm driver:
> dev_info(&ddata->dsi->dev, "panel revision %02x.%02x.%02x\n",
>                          id1, id2, id3);
> 
> or some error:
>          dev_err(&ddata->dsi->dev, "error while enabling panel, issuing HW reset\n");
> 
> Any explanation why it is missing?
> 

It is there, I grep-ed for omapdrm only, didn't want to flood the ML:

2026-05-28T17:34:45.761932+03:00 devuan-droid4 kernel: [   12.502105] 
panel-dsi-cm 58004000.encoder.0: panel revision 70.01.02

Here is the (almost)full boot log: https://paste.debian.net/hidden/e6ca55a7

> 
> 
>> [   12.770385] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [   22.901306] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   22.901306] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit
>> wait timed out
> looks like dsi is not involed here, so something else is producing problems?
> 
>> [   33.131256] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   33.131378] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]
>> commit wait timed out
> 
> This might have something to do with the patch.
> 
>> [   43.371307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   43.371398] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]
>> commit wait timed out
>> [   43.631408] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [   43.692504] omapdrm omapdrm.0: [drm] fb0: omapdrmdrmfb frame buffer
>> device
>> [   54.251342] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   54.251464] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit
>> wait timed out
>> [   64.491302] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   64.491424] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]
>> commit wait timed out
>> [   74.731323] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   74.731445] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]
>> commit wait timed out
>> [   74.991363] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [   85.621307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   85.621398] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit
>> wait timed out
>> [   95.851287] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [   95.851379] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]
>> commit wait timed out
>> [  106.101257] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [  106.101440] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]
>> commit wait timed out
>> [  106.371459] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [  106.961334] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
>> [  141.301269] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [  141.301269] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit
>> wait timed out
>> [  151.531280] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
>> [  151.531402] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]
>> commit wait timed out
>>
>>
> Thanks for testing.
> 

You're welcome, I can do more testing as needed, ATM I am trying to 
upgrade leste to 6.18 anyways so have all tools in place. Feel free to 
ping me on leste IRC channel if you think I can be of any help here.

Regards,
Ivo

> Regards,
> Andreas
> 
>> On 28.05.26 г. 13:16 ч., akemnade@kernel.org wrote:
>>> From: Andreas Kemnade <andreas@kemnade.info>
>>>
>>> Some chips need configuration commands to be sent first, before they can
>>> send data. TC358762 for example needs PPI_LPTXTIMECNT configured
>>> and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
>>> configure such chips, do not send bta sync during writes if no acks are
>>> requested. Instead just wait for the packet to be sent to avoid FIFO
>>> overflows. There might be more to do about acks, but there seem to be
>>> virtually no users of that flag.
>>>
>>> This came to light when fiddling with the Epson Moverio BT-200 display
>>> which consists of 2 TC358762 bridges with SPI funneled through
>>> to the unknown display chip. With that patch the bridge can be accessed,
>>> Reading back registers works, when the above-mentioned registers are set.
>>>
>>> Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
>>>
>>> Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>> This was not tested on any command mode display, which IMHO should be
>>> done.  So droid4 folks: please give it a try
>>> ---
>>>    drivers/gpu/drm/omapdrm/dss/dsi.c | 32 +++++++++++++++++++++++---------
>>>    1 file changed, 23 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
>>> index 27fe7bca9e2cf..98362b0157023 100644
>>> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
>>> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
>>> @@ -2194,6 +2194,7 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
>>>    static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>>>    			       const struct mipi_dsi_msg *msg)
>>>    {
>>> +	DECLARE_COMPLETION_ONSTACK(completion);
>>>    	struct dsi_data *dsi = to_dsi_data(dssdev);
>>>    	int r;
>>>    
>>> @@ -2205,17 +2206,30 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>>>    	if (r < 0)
>>>    		return r;
>>>    
>>> -	/*
>>> -	 * TODO: we do not always have to do the BTA sync, for example
>>> -	 * we can improve performance by setting the update window
>>> -	 * information without sending BTA sync between the commands.
>>> -	 * In that case we can return early.
>>> -	 */
>>> +	/* wait for IRQ for long packet transmission confirmation */
>>> +	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
>>> +			&completion, DSI_VC_IRQ_PACKET_SENT);
>>> +	if (r)
>>> +		return r;
>>>    
>>> -	r = dsi_vc_send_bta_sync(dssdev, vc);
>>> -	if (r) {
>>> -		DSSERR("bta sync failed\n");
>>> +	if (wait_for_completion_timeout(&completion,
>>> +			msecs_to_jiffies(500)) == 0)
>>> +		r = -EIO;
>>> +
>>> +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
>>> +			      &completion, DSI_VC_IRQ_PACKET_SENT);
>>> +
>>> +	if (r)
>>>    		return r;
>>> +
>>> +	/* TODO: find out if more needs to be done for MIPI_DIS_MSG_REQ_ACK */
>>> +
>>> +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
>>> +		r = dsi_vc_send_bta_sync(dssdev, vc);
>>> +		if (r) {
>>> +			DSSERR("bta sync failed\n");
>>> +			return r;
>>> +		}
>>>    	}
>>>    
>>>    	/* RX_FIFO_NOT_EMPTY */
>>>
>>> ---
>>> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
>>> change-id: 20260528-vm-upstr-c8e7634ebf56
>>>
>>> Best regards,
>>> --
>>> Andreas Kemnade <akemnade@kernel.org>
>>>
>>>    
>>
>>
> 
