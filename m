Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98BAC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEDE10E44D;
	Mon, 21 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mek15BLo";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D365010E0B4
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:43:33 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so1061900a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789958613; x=1790563413; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XjC/UZqLFtMb5vJyxy966HHDm1SdiObcPJD69fIKS4Q=;
 b=Mek15BLoXgTzOC/Kw9hH4d/rBrynqFP71HKv901lBXbjLc5JjaWnyrUCZ9SNUMcAfa
 eztLOmNkDM+7Xr9yzL3Fs/nzjIG9gDpheROWT9Ah7pNHxCdlj6vyHzqWGJLzHDZRkSNN
 N6GZxjZSLBxa5e38O9jPDfKcUkjV5SxM8zpTtZpRRSxBr9cwQiHnpURugkY4BkkRYsVB
 ADw5y7mK60+s1RfF9JUk3nCk0+yp2f0SY2RiIcE8/CCyjbo+VSfhwS41z2jHYALVQtE8
 si1fOuMLfW7OLTQCf/wj5bsIikf0g4Uu29anrlP5LM9Hp7alghzZqwxBa2HV1xZgjeeY
 by4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789958613; x=1790563413;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XjC/UZqLFtMb5vJyxy966HHDm1SdiObcPJD69fIKS4Q=;
 b=JvgI2deVzfZWqzo129pDeTws+l7ghe5xg3sxZTC2pHCSB4rsR1g+tyUf/jRLa04ToQ
 FaSwHkcRjwjK/+fJ/dATtlzfAiqIs7HoHwdEQawsfs8HVxZ8JKlDLR1KAQ6Leg5OjyV8
 +gKgN1o1DFjYKeH0wL1tf13/yABD6saR1zkM3BB/3aKjY0ws0il0PSWvHujZGO8hB+e2
 D/DCZiEUSw8ONWlc5dLusFPPKe1FuW5ugHiytSps1rwoZeGLyFwXX5Ov/6uusqhLbTxP
 jTachJp31Z0odR874C8QBWrSf/eUjPO/FLASi4zgy72bbkDGhPR9bjPG9aiHe8uQQfGp
 029w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1bCk0Bx7igz7QGs244MAQDRAP+CjY8yUDAtkdFBikbRrH1FfWIasYz5vEjVGjCasN3HxkN2Ob8Ng=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nRlwjPlgBfVp5XikDAitg6sA8ecvzjnSgK93lzTEdjNF7dx9vy
 41nx6y1USZadqiiiNLXkZRO5btBvctbxsheqxgFXKqUBM0Jii8T7tBxW
X-Gm-Gg: AYBFou3TIbzchs9fj9TWbX8vnwHxweZHxJ90HTyEc/8ttsmHmkqRbPLfbGBtqXoLXlM
 NjFTnqTQ3uEVRRYj6VXlVlZD0FvQ0VX4BMN4u3rH8rgRIev0XPeEFzhH/v/FH+3gcYQXQ+J4jJz
 uqQH2oDBlr2hL54v2+XJYskXMfD+6KcMt58YNvQi61oqO5A+EHwxlIpeVeVdSq/Zq5Oq3n/vfFK
 nSwJHMK420PMGZIvprUuUKp2Lg7Yl0PxCqMQYI6kp5DfpEc7EE8Z05qrNTX/3/mb32pVgUcqZX1
 iBRzlss7BFEykI1syyM0yAEF1AH5niFzAor/xWfhk4EibNpQAwk7u/jPNbrWixCFxZkBDl4XjBY
 Vc0t8/ee7uQRLd8ET31EinDoEsoBJcXrefFRXq1VeJfwlHW6DrlG40ZeSOnNWXGR02UUCZeSXjx
 xeeNBDSk/fmUel27RrecYGdHpDh6motV2/lA6MoXNc/nByQ6YJ7aVoMrNrAuPX0QFgRHvXyappV
 MDOoEMMVOVvtX+8UNwG8VQcxp7vSBKN6fFnq27y+UGnLJhPLpI7dig=
X-Received: by 2002:a17:90b:55c4:b0:3a0:34a4:187e with SMTP id
 98e67ed59e1d1-3a034a41dc3mr3254394a91.15.1789958613234; 
 Sun, 20 Sep 2026 19:43:33 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a02900f84fsm10384623a91.2.2026.09.20.19.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:43:32 -0700 (PDT)
Message-ID: <1d988dfb-c930-4c17-ae77-47b93ff9f159@gmail.com>
Date: Mon, 21 Sep 2026 10:43:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] drm/verisilicon: fix DC8200 primary plane disable
 clearing FB_EN
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260918030125.315978-1-a0987203069@gmail.com>
 <20260918030125.315978-8-a0987203069@gmail.com>
 <4a7b271d2a90eff94c27dec3bf24114ce44df1fd.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <4a7b271d2a90eff94c27dec3bf24114ce44df1fd.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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


Icenowy Zheng 於 2026/9/18 下午 01:52 寫道:
> 在 2026-09-18五的 11:01 +0800，Joey Lu写道：
>> vs_dc8200_primary_plane_disable_ex() calls regmap_set_bits() on
>> VSDC_FB_CONFIG_EX_FB_EN instead of regmap_clear_bits(), so disabling
>> the primary plane on DC8200-family hardware actually leaves the
>> framebuffer enable bit instead of clearing it.
>>
>> This bug predates this series: it was carried over unchanged from
>> vs_primary_plane_atomic_disable() when patch "drm/verisilicon:
>> introduce per-variant hardware ops table" split the DC8200-specific
>> implementation out into vs_dc8200.c.
>>
>> Fixes: dbf21777caa8 ("drm: verisilicon: add a driver for Verisilicon
>> display controllers")
> Maybe it'd be better to fix this before adding DC variant abstraction,
> for easier backporting.
>
> Thanks,
> Icenowy
Makes sense. Should I send it as a standalone patch targeting
drm-misc-fixes (separate from this series), or do you have a
different preference for how to split it?
>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   drivers/gpu/drm/verisilicon/vs_dc8200.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc8200.c
>> b/drivers/gpu/drm/verisilicon/vs_dc8200.c
>> index f72da10295e1b..25b5906a1c5fc 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc8200.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc8200.c
>> @@ -70,8 +70,8 @@ static void
>> vs_dc8200_primary_plane_enable_ex(struct vs_dc *dc, unsigned int out
>>   
>>   static void vs_dc8200_primary_plane_disable_ex(struct vs_dc *dc,
>> unsigned int output)
>>   {
>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			VSDC_FB_CONFIG_EX_FB_EN);
>> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> +			  VSDC_FB_CONFIG_EX_FB_EN);
>>   
>>   	vs_dc8200_plane_commit(dc, output);
>>   }
