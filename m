Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143BEC982E1
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 12:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C7110E062;
	Sun, 20 Sep 2026 12:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="wizT+3S3";
	dkim-atps=neutral
Received: from ixit.cz (ixit.cz [84.42.129.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77E010E062
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:34:21 +0000 (UTC)
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown
 [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 06C9B5340831;
 Sun, 20 Sep 2026 14:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1789907659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tNwFaUCVbxc5+iuTaZgaMk6iXmkv32xubCeformm7Pg=;
 b=wizT+3S3gWBylHN2uqpdi8Hnl7YG6LORBYPBTorxdUjwYoPYtVONkxAj2hC0Yg/U/DLEFJ
 UbWu5KvFIWSpw5k+TDhqPCHN7waggrshNo//2ywKUSLIjQ+SuK4zK2Gxq0udSkbWLLONLP
 Z85qy3UxMAswg8+Ehtbcl0DjAvOi5hs=
Message-ID: <c89f5128-5657-426a-87c7-55d12e9ea610@ixit.cz>
Date: Sun, 20 Sep 2026 14:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/panel: lg-sw43408: do not assert reset across
 unprepare
From: David Heidelberg <david@ixit.cz>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz>
 <20260810-fix-blueline-panel-v2-1-9344dfdbc3f9@ixit.cz>
 <cd90572c-e1f3-47a0-829e-9b3d8097a62f@ixit.cz>
Content-Language: en-US, cs-CZ
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <cd90572c-e1f3-47a0-829e-9b3d8097a62f@ixit.cz>
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

On 14/09/2026 23:04, David Heidelberg wrote:
> On 10/08/2026 11:55, David Heidelberg via B4 Relay wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> Asserting the reset GPIO in unprepare() and leaving it asserted puts
>> the DDIC into a state it never recovers from: after the following
>> prepare() the panel answers all DCS commands, reports display-on with
>> clean self-diagnostics, and its configuration registers read back
>> identical to a working panel, but it never lights up again.
>>
>> On the Pixel 3, vddi is shared with the touchscreen controller and
>> remains powered while the panel is off, so with this driver the DDIC
>> sits in reset with its logic rail up for the whole blank period - a
>> state the vendor stack never creates: the vendor firmware only toggles
>> reset as part of a full power-on sequence, and the vendor OS never
>> power-cycles the panel at all (LP mode is used instead).
>>
>> Leave reset alone in unprepare(); prepare() performs the regular reset
>> sequence anyway.
>>
>> Without this, the Pixel 3 display never comes back after the first
>> blank/unblank cycle.
>>
>> Since there isn't any other panel or device using this DDIC, this
>> approach seems resoanble to address the issue.
>>
>> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
> 
> Good news is, that this patch really doesn't make panel power-off fatal for the 
> phone, but recent testing got me into state where I observed:
> 
> 10 hours, display on, phone operating normally.
> 
> display on (various time), display off, display on OK, but sometimes
> 
> display on, display off (for longer time), after pressing power button (to wake 
> up) the phone reboot into bootloader.
> 
> Nothing printed into dmesg (I'll try enable drm-debug, but not having high hopes.
> 
> So far, this is still heavy improvement comparing to instant crash, but not the 
> perfect solution either.

Please ignore this email, I debugged the issue and the phone never returned from 
the suspend due to serial geni bugs. This fixes are good to go.

David

> 
> David
> 
>> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/ 
>> panel-lg-sw43408.c
>> index 293826c5006b9..0bf8e08f10b9c 100644
>> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
>> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
>> @@ -50,18 +50,24 @@ static int sw43408_unprepare(struct drm_panel *panel)
>>       int ret;
>>       mipi_dsi_dcs_set_display_off_multi(&ctx);
>>       mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
>>       mipi_dsi_msleep(&ctx, 100);
>> -    gpiod_set_value(sw43408->reset_gpio, 1);
>> -
>> +    /*
>> +     * Keep reset deasserted: vddi may stay powered (it is shared with
>> +     * the touchscreen on Pixel 3) and holding the DDIC in reset while
>> +     * its logic rail is up puts it into a state that no init sequence
>> +     * recovers from - the panel keeps answering DCS commands and
>> +     * reports display-on, but never lights up again. The vendor stack
>> +     * only ever toggles reset as part of a powered-up init sequence.
>> +     */
>>       ret = regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies), sw43408- 
>> >supplies);
>>       return ret ? : ctx.accum_err;
>>   }
>>   static int sw43408_program(struct drm_panel *panel)
>>   {
>>       struct sw43408_panel *sw43408 = to_panel_info(panel);
>>
> 

