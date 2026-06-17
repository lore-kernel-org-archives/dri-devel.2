Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59E0CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C6F10F1B8;
	Thu, 18 Jun 2026 07:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkGlXgW4";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D88410EF9B
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:37:38 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84532e3dbf7so45234b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781692657; x=1782297457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AhUWEjlecPu7hlJvyuwWPRxl2TYmG2bGNVOKZVs0d90=;
 b=DkGlXgW4tJpnrXXaEjSzXbV6YXTY12DQZce6aS6b/vJUG66ExdoWZReKCYcs0XA0cy
 jDNJ+PTvz2P0ugqxNyDkSBtL0y9QjacsoEpgq2dQhFWxfZAIhFOu0h8Whg2bBMze0mXs
 RkxwEDAJ7lI99DdiP7ZepjtLMQCScYlIBrnFW6rKDozsMQ5y9rpn2V+MHDu1ciYpHmxX
 WjSn7zl0ost6p//9wvmaTwJyTBGWXcBT6LCHyTeXV+rJPfrCkDgwFWxtc38q/mjRweqJ
 XjPKtoPDtLklLftA/27oGwgl9a24dXlVqJN4JL7Yff/ok0s+UlZvxqHEoe2z6y/GjqtN
 GNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781692657; x=1782297457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AhUWEjlecPu7hlJvyuwWPRxl2TYmG2bGNVOKZVs0d90=;
 b=UdIOQCZiq1ykaQ6kIMGpuPaGKxlkUt9bR+tjzWPJu9uA7uzI0dNqRHez4oIoe5w86N
 No2DW3vNcJVTJiFMPOkm1fWaquE1sF0eJHaiz6YwoOTVyCjWgtjpAPIr+lSuHgpJpUdX
 gNihoIai0uiqsCIlnc6ATYsuyJtDp28p6TP1/utHdZ2+BwNtiJTvANM7KO+MAh4IwQrp
 vZj/j7GxsWQIjKQtdnoVTAeNRuKdhS7vkWyN1OmRvp/URrq0zqIft9aLrgjanxfbtSMv
 eEPBRIO0chUiAWoXjcIWEz/Wl+1WdAB387/LORTwjPTqxppg/ukiSucyipKUVgd46aoo
 YOHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ97/87/lWxI9u7KWdgJNmY56bUYddkp1y+PHoOfiUPQL8yB1fElh4kBaPjTIepGgXLRZD+FBZcd6Wk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmSgg2dwZojcoulG+3T3ZcbWxx/MdMNMD77UxS7uGle1C43UzW
 uyvrFKObPyW4l8qUP6KU93QU30aVUzzTjj/y6GKr+uFz/MfuaK/Vl4uG
X-Gm-Gg: Acq92OH9AbOZQOkVoFP72WvXa8yeISWTl91uSV8xMoLLEwcMWtO43CkoVgXZSxCFNFz
 ElPJvo2Cjmbxgw1dqtj6EQ6W10Mwv+cypZKhJd7Pa5k7qtW06khfYGL8ZzPPt52hSECuFv8++bB
 zb9TctBEkSaqnKhlkG9acHjiTJL08WrlgrfWR5fc0DeiIA4/W7hb87IQIqkZKW+cCCcp7127vNI
 Twf40Olaw4WPOEM2htTznG0iZI5b+e4WFy3szW7RAzEk/ruwXErX4ECG2R5kF+EOjjWmZUutAJQ
 3vuwPr+oogz7oXRx0xS1YQO1a0kys0PWr9vIOleLxGgSykh7j0RLbKG/y7+iTiAVF+Pw1Xg4L5Z
 413UIaM3XdW459ajWZSBjXd7Tl2Eyr4RKKxwidBc+Ed7+4NkjQNOEx5PXH1jdq9wKbyk82LPK3V
 MH5yJid9COC+QiLqczS65vB1pbeTRsPNV29TA2DDqD32zqV9qg762k64dpdXh1QDs4nJTOzkWBx
 nUD
X-Received: by 2002:a05:6a00:10d5:b0:842:4a39:6047 with SMTP id
 d2e1a72fcca58-84524550f44mr3301789b3a.29.1781692657527; 
 Wed, 17 Jun 2026 03:37:37 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ad03fdcsm15269159b3a.24.2026.06.17.03.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 03:37:37 -0700 (PDT)
Message-ID: <bd90109d-5c1c-47d6-ac1a-c9b81de5cf7b@gmail.com>
Date: Wed, 17 Jun 2026 18:37:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/verisilicon: add DCUltraLite chip identity to
 HWDB
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260615065003.76661-1-a0987203069@gmail.com>
 <20260615065003.76661-6-a0987203069@gmail.com>
 <62c0b8ab9b6d9f994daa8bb60b3b626688af7d5e.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <62c0b8ab9b6d9f994daa8bb60b3b626688af7d5e.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:12:07 +0000
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


On 6/15/2026 4:57 PM, Icenowy Zheng wrote:
> 在 2026-06-15一的 14:50 +0800，Joey Lu写道：
>> Register the Nuvoton MA35D1 DCUltraLite chip identity in
>> vs_chip_identities[]:
>>    model       = 0x0   (DCUltraLite; Verisilicon uses 0 for this IP)
>>    revision    = 0x5560
>>    customer_id = 0x305
>>    generation  = VSDC_GEN_DC8000
>>    display_count = 1
>>    max_cursor_size = 32
> I suggest make this more human-readable instead of replicating the
> machine-readable data of HWDB.
>
> My proposal here:
>
> ```
> The Nuvoton MA35D1 chip contains a DCUltraLite display controller with
> model number 0x0 (sic, the model name contains no number either),
> revision 0x5560 and customer ID 0x305. It has a similar register map
> with DC8000, only one display output and only 32x32 cursor supported.
> ```
Thanks. I will use your proposed wording for the commit message in v5
>> Placing this entry last makes it the gate that enables MA35D1
>> hardware
>> recognition only after all the supporting ops and DT binding changes
>> are
>> in place.
> It's a little ambiguous that "last" here means whether the last in the
> patchset or the last in the HWDB array, although I think it's not so
> needed to explain the reason of the place in the patchset.
>
> I propose just say `Adding it to the HWDB to enable it to be usable
> with the verisilicon driver.` .
I will simplify the placement sentence to "Adding it to the HWDB to 
enable it to be usable with the verisilicon driver." in v5.
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   drivers/gpu/drm/verisilicon/vs_hwdb.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> b/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> index 91524d16f778..7d630a667a3f 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> @@ -129,6 +129,16 @@ static struct vs_chip_identity
>> vs_chip_identities[] = {
>>   		.max_cursor_size = 64,
>>   		.formats = &vs_formats_no_yuv444,
>>   	},
>> +	{
>> +		.model = 0x0,		/* DCUltraLite */
>> +		.revision = 0x5560,
>> +		.customer_id = 0x305,
>> +
>> +		.generation = VSDC_GEN_DC8000,
>> +		.display_count = 1,
>> +		.max_cursor_size = 32,
>> +		.formats = &vs_formats_no_yuv444,
>> +	},
>>   };
>>   
>>   int vs_fill_chip_identity(struct regmap *regs,
