Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C66CCD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D75810F958;
	Fri, 29 May 2026 06:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ArBG4CSd";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D8910F958
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:26:27 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490686877a1so36991135e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780035986; x=1780640786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J6w0+5mCVlOlxvbGiaPZUip+G9h6j0Uqf+tR53uTjHI=;
 b=ArBG4CSdoMf/1ab7NLo6EceiFoEmuHAA+D2q08VvMX9P0etPvLcfBh8eHK6dzIVYsh
 9H670awYvjtHQF9+3iUe7xX8zaOgxeOfBZqxxzSSkNAs0sirwS5YgZzeHu6LsiD2LrPF
 bgsx5MWJ4NIcvai5vxeUjZLz5TLWz0AmyGsEEefS4Nh1R3zciDTTziPzlhLSbmBYMUnr
 xcH3GG6KEBrHHCPfiBlFAkitBe2Kc7CIyjxdqrY1KZKAyfAMZf6UpB4UgRL6GQvrKRzp
 Xx35J1RdDPR3oS1gsH3W+HZidgw8SmLIdhklzq3vHizYJIPmX5VRqlodzUB8t4fnPdcd
 EmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780035986; x=1780640786;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J6w0+5mCVlOlxvbGiaPZUip+G9h6j0Uqf+tR53uTjHI=;
 b=mnvbrvz+EpsMP6gZ0WR1qQHqzkj+ZKU516cFBk/ntz7oBe8CRspvJC4ZsLYTwE4g/s
 kMUsTNDs+0EFi2drfRmh4kIw/AEYlTGzwFYzkdcdS2Qp01iPGFNKP6PodzQ2p8pYwiVE
 vN7gmMn4W8EPfMtsFEfabkuP7lMpWkHBjLu0Oqf1wAJE9aNqT65h4tKc4C8H868JyFNb
 uNYshTp/rC1wEL7fV2W7OG57wuRPzCCLSdJZNIOeX7LQQGmCiKJ35c9WjIgXg1mRrVOW
 E4zZB53TpQQFUFwvk6jX+hxl6sZGqtJoF4Y3XYNTWzP4Ysm10qAywIIfRJ2QkrOoYs5h
 Prcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zwsSAtmuGjlYGAohLP6B/7YU6Gaeli1zTd4pRj8hE7eYxE6KsWDkqmPQOU+wMqUv9gxrCC4csnfc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHaQkitoORNMnjpJHgCFOQ9aVloXvfwA+uks/cV/7LQc+wp+4R
 d8w4ozPlWFOk88YkDbtoJGoMfxi/e/y6aNeZgfzPXRMJtY27LAv/eSlq
X-Gm-Gg: Acq92OE9VSjJXsGj9j0I3owjK8E2cex0zVtuWdbbWkoJkuz8xTC7re/tDf2kz7zc5zt
 3O5AP4uuIwgG7VerlrE5NzNa9mspY0eBCpIW601G+RWMoeZtRCS5y7Nfb8Oa0b7zwm3kfzqIsyG
 DO6SADtxYmA7jkydAiDEUSMYNEZWqYTgAJJ1EdjXD+f74Q+lvSF3oQ0q/lsrkQyKAZsX0c8uBBR
 MaU+9q/cM/KM6T0OL0llTkVYF9Aysl0LkseogboPal+To2BD4rxZBfxVVBjqR0oeYvacSRMvzT+
 EEKF1XuMsWwzHlLOrtGx2/Gi0rTMPfd/TTYkUAOmHoOtlAlv6IIUsTP6LNUrI82/0gvhapiKEwn
 vEz7DW9h5fa46oMIKI4YxvE3eFBn773D6H+28i/ISLBwWoKdWUmIusdp8nMMAGTOSBbqH6WYDWU
 7krTedo29R3ePuVnFZP44X7bq/P9opwci0eBHPLvcWF1q9nrs5ThvPJnFk
X-Received: by 2002:a05:600c:3545:b0:490:50ff:d394 with SMTP id
 5b1f17b1804b1-4909c1670a5mr24522085e9.16.1780035985401; 
 Thu, 28 May 2026 23:26:25 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm1319191f8f.9.2026.05.28.23.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 23:26:25 -0700 (PDT)
Message-ID: <4cb8a90b-6345-47a8-b15a-a977a33af8b3@gmail.com>
Date: Fri, 29 May 2026 09:26:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Marek Vasut <marex@denx.de>, "H. Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
 <ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
 <20260528190234.4c00b740@kernel.org>
 <37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
 <20260528220603.6600d45b@kemnade.info> <20260528221912.1771daa4@kemnade.info>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260528221912.1771daa4@kemnade.info>
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

with the following changes:

user@devuan:/media/user/7b76ddc8-44f5-47b5-af5b-e5e9b5ab39c3/user/linux_openpvrsgx$ 
git diff drivers/gpu/drm/omapdrm/dss/dsi.c
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c 
b/drivers/gpu/drm/omapdrm/dss/dsi.c
index af27339c79f9..8ffcd95c3bc3 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2199,7 +2199,7 @@ static int dsi_vc_write_common(struct 
omap_dss_device *dssdev, int vc,
         int r;

         if (mipi_dsi_packet_format_is_short(msg->type))
-               r = dsi_vc_send_short(dsi, vc, msg);
+               return dsi_vc_send_short(dsi, vc, msg);
         else
                 r = dsi_vc_send_long(dsi, vc, msg);

@@ -3247,21 +3247,6 @@ static int _dsi_update(struct dsi_data *dsi)
         return 0;
  }

-static int _dsi_send_nop(struct dsi_data *dsi, int vc, int channel)
-{
-       const u8 payload[] = { MIPI_DCS_NOP };
-       const struct mipi_dsi_msg msg = {
-               .channel = channel,
-               .type = MIPI_DSI_DCS_SHORT_WRITE,
-               .tx_len = 1,
-               .tx_buf = payload,
-       };
-
-       WARN_ON(!dsi_bus_is_locked(dsi));
-
-       return _omap_dsi_host_transfer(dsi, vc, &msg);
-}
-
  static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
  {
         struct dsi_data *dsi = to_dsi_data(dssdev);
@@ -3282,11 +3267,11 @@ static int dsi_update_channel(struct 
omap_dss_device *dssdev, int vc)
         DSSDBG("dsi_update_channel: %d", vc);

         /*
-        * Send NOP between the frames. If we don't send something here, the
+        * Transition to LP here. If we don't send something here, the
          * updates stop working. This is probably related to DSI spec 
stating
          * that the DSI host should transition to LP at least once per 
frame.
          */
-       r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
+       r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
         if (r < 0) {
                 DSSWARN("failed to send nop between frames: %d\n", r);
                 goto err;


Leste boots properly on droid4. No visible side effects in hildon so 
far, chromium runs as slow as usual, glmark2 score is 85, which looks 
normal, so with the above changes you may add my Tested-by, unless you 
want me to test more things.

Thanks and regards,
Ivo

On 28.05.26 г. 23:19 ч., Andreas Kemnade wrote:
> On Thu, 28 May 2026 22:06:03 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
>> On Thu, 28 May 2026 20:43:12 +0300
>> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
>>
>>> Hi,
>>>
>>> On 28.05.26 г. 20:02 ч., Andreas Kemnade wrote:
>>>> Hi,
>>>>
>>>> so this droid4? Or which device is it?
>>>>      
>>>
>>> Oh, sorry, yes, this is droid4.
>>>    
>>>> On Thu, 28 May 2026 17:44:14 +0300
>>>> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
>>>>      
>>>>> Applied against 6.18.31, no dice :)
>>>>>
>>>>> [   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on
>>>>> minor 0
>>>>> [   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>>>>> dispc_component_ops [omapdrm])
>>>>> [   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops
>>>>> dsi_vc_flush_receive_data [omapdrm])
>>>>> [   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on minor 1
>>>>> [   12.311981] [drm] Enabling DMM ywrap scrolling
>>>>
>>>> I would expect some
>>>> output from  the panel-dsi-cm driver:
>>>> dev_info(&ddata->dsi->dev, "panel revision %02x.%02x.%02x\n",
>>>>                           id1, id2, id3);
>>>>
>>>> or some error:
>>>>           dev_err(&ddata->dsi->dev, "error while enabling panel, issuing HW reset\n");
>>>>
>>>> Any explanation why it is missing?
>>>>      
>>>
>>> It is there, I grep-ed for omapdrm only, didn't want to flood the ML:
>>>
>>> 2026-05-28T17:34:45.761932+03:00 devuan-droid4 kernel: [   12.502105]
>>> panel-dsi-cm 58004000.encoder.0: panel revision 70.01.02
>>>
>>> Here is the (almost)full boot log: https://paste.debian.net/hidden/e6ca55a7
>>>    
>> 2026-05-28T17:34:45.763732+03:00 devuan-droid4 kernel: [  112.820404] DSI: omapdss DSI: failed to send nop between frames: -5
>> 2026-05-28T17:34:45.763732+03:00 devuan-droid4 kernel: [  113.331726] DSI: omapdss DSI: failed to send nop between frames: -5
>>
>> and that is interesting. Apparently no PACKET_SENT_IRQ and the wait
>> completion times out. Maybe it is not used with short packets.
>> But..
>>         /*
>>           * Send NOP between the frames. If we don't send something here, the
>>           * updates stop working. This is probably related to DSI spec stating
>>           * that the DSI host should transition to LP at least once per frame.
>>           */
>>          r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
>>
>> I do not see a reason why something should go into LP mode here. the
>> message will probably be sent in HS mode but the BTA sync (not done anymore)
>> is probably the only thing turning something to LP mode.
>>
>> So to avoid PACKET_SENT_IRQ trouble, do:
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> index dcfcfc0efcdc..37323c9b08a8 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> @@ -2200,7 +2200,7 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
>>   	int r;
>>   
>>   	if (mipi_dsi_packet_format_is_short(msg->type))
>> -		r = dsi_vc_send_short(dsi, vc, msg);
>> +		return dsi_vc_send_short(dsi, vc, msg);
>>   	else
>>   		r = dsi_vc_send_long(dsi, vc, msg);
>>   
>>
>> Also try:
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> index dcfcfc0efcdc..37323c9b08a8 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> @@ -3283,11 +3283,11 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
>>   	DSSDBG("dsi_update_channel: %d", vc);
>>   
>>   	/*
>> -	 * Send NOP between the frames. If we don't send something here, the
>> +	 * Transition to LP here. If we don't send something here, the
>>   	 * updates stop working. This is probably related to DSI spec stating
>>   	 * that the DSI host should transition to LP at least once per frame.
>>   	 */
>> -	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
>> +	r = dsi_vc_send_bta_sync(dssdev, vc);
> 
> probably rather VC_CMD
>>   	if (r < 0) {
>>   		DSSWARN("failed to send nop between frames: %d\n", r);
>>   		goto err;
>>
>>
>>
>> Regards,
>> Andreas
>>
> 
