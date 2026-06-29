Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ED1C43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE08C10E708;
	Mon, 29 Jun 2026 07:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dtAsjfKh";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3762A10E002
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:48:54 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8478cc93299so90990b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782704934; x=1783309734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zYaJLO7rVJIlOh5//OZ2QMbg6ndszMv9dZxRzh/XAcg=;
 b=dtAsjfKhB2B5wPPmETzN01VbPuly8DK2uHCTkUJ2t2W2BoICmMdKlo35RS+imNmIuj
 QfFm/HyOCFrH4d87Iush160lP3f+2kO1yOmDWM31fd44EOdjUZUYivkbDBbJzuvOBYcm
 EEpq/lqxU1eiItSIPMILyNUOnpK+mp58xGy6HmzOwiL3KjBIGH0qDBX+mZaKZ0XwzPkd
 9k1065rZF9oJm0lA8/poTPYh8vTHSPXsX5wO5WtZn+vCkITDdEuzvaf9KDcNI3XeUlAn
 g3ySbC99LVkWra4lC3fOgLblb7tl6u+fhuxPBEeIF0Iy808sRb6xVlYVr8CLztKd54EX
 7bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782704934; x=1783309734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYaJLO7rVJIlOh5//OZ2QMbg6ndszMv9dZxRzh/XAcg=;
 b=AdS5b966bKS1Ba/bpgl2tY786AUbwGFHwaJvjGGKqL2V3EMeYqu3CPHVcJWjfq3Yd6
 wuUuZRP/9UWdMBfbsFox9i66ubS5EBqo9QzIuYJ5kSdej7P1ECVAgmIDJBHwK9CJ6fY/
 a1ChYpgzBss9qNMkPzo0r5AdcWv+el+55pP439k0IAHsMwMu4D5n3EyOFV+FSkmL7hUo
 RUE0zlu+qjQ9ns1787QKhEBU4j901nKseiX8csaYaJ0TN5clkirvbPhRdblIEQC7NBZu
 RGyVhSg/31LTDG3lGKBtCLgNcd4QdADteoOMxhXCWtcMleMj8iJPJZnrOwVnlOgegP4f
 hl1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyAQaSbtpsaarhfGw/mqGiQ7ebJ70rtRRP9+DR7YXRCI4fwBLmzgNVcoo0xQ3r6Zv/aI2X3rAXW2U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwodfMBSrz/gdzN2MgjGBLUmYnjT6Z918lsmKxiRFmD1bYjUaFk
 cDbqVh5glX8HGFxYQIloybOssVQ84/69pMsBkg14Ifw7rEgovFNj3Oem
X-Gm-Gg: AfdE7cnykeUGF3b+GaKY3RFXqTmoSCgKEy15QbHqquGfGmGNSh+a06Xf8Lj1K53KqIW
 4l3VR6jPL93T2tVUe5poewnq37aHSZtEKMH9b1+wIMtnKDW1gtMr6HgPbk5C+jmUduyuAZF2tJ7
 vlrIXT7ZuQph1nMd1nELhfy0FiqWk23LxBq3pd83UYTXICXMrOBRxYGtIeDYO+CI8UjpqElAVwo
 cEVehsbjHy6ZWCD9+FASbiyvLlHsDPNWNP9Ss83fx0qB0XV51nWWAAKgo1ysIzhrLAV8TMPzlBU
 lHLQpGu/45jy0s0BsUdTwswufmGOrViJJw1WynD/XDpK+UYinty2QujbJpV+11pPZLmdQGwI5//
 dmE4OTwkmbaQuVbclN7AeAMWye6C10J5ePwngjPUMNy2uYQtBcB/+wCIdxuw/GIz1PQFpDxdGGx
 xdIT5GOpOEeal6fxyfnoMFtSDo8vKz/saBwUR4PaJvEXBSVoVsqLCIGFVOH/LT3pkVUDLBnPcH8
 YTh
X-Received: by 2002:a05:6a00:238b:b0:845:e19a:1188 with SMTP id
 d2e1a72fcca58-845e19a1487mr4616768b3a.52.1782704933611; 
 Sun, 28 Jun 2026 20:48:53 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3fedaefsm11603061b3a.23.2026.06.28.20.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 20:48:53 -0700 (PDT)
Message-ID: <e44b9d64-95dd-4b1e-bcd3-05bd5a9963eb@gmail.com>
Date: Mon, 29 Jun 2026 11:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/verisilicon: make axi and ahb clocks optional
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-5-a0987203069@gmail.com>
 <cf9af38dfe52548649b9010f298341d4064aaa21.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <cf9af38dfe52548649b9010f298341d4064aaa21.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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


On 6/26/2026 4:03 PM, Icenowy Zheng wrote:
> 在 2026-06-25四的 17:44 +0800，Joey Lu写道：
>> The Nuvoton MA35D1 SoC integrates a DCUltraLite display controller
>> whose
>> AXI and AHB bus clocks share a single gate enable bit with the
>> display
>> core clock, so the clock driver does not expose them separately. This
>> patch makes the axi and ahb clocks optional in the probe.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ```
> Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ```
>
> Thanks,
> Icenowy
Thank you for the review. I will revert this patch entirely. As discussed
in the binding review, axi and ahb clocks will now always be supplied in
the devicetree using the same phandle as the core clock gate, so making
them optional in the driver is no longer needed.
>> ---
>>   drivers/gpu/drm/verisilicon/vs_dc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
>> b/drivers/gpu/drm/verisilicon/vs_dc.c
>> index 9729b693d360..fd1f5fe67a68 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
>> @@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   		return PTR_ERR(dc->core_clk);
>>   	}
>>   
>> -	dc->axi_clk = devm_clk_get_enabled(dev, "axi");
>> +	dc->axi_clk = devm_clk_get_optional_enabled(dev, "axi");
>>   	if (IS_ERR(dc->axi_clk)) {
>>   		dev_err(dev, "can't get axi clock\n");
>>   		return PTR_ERR(dc->axi_clk);
>>   	}
>>   
>> -	dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
>> +	dc->ahb_clk = devm_clk_get_optional_enabled(dev, "ahb");
>>   	if (IS_ERR(dc->ahb_clk)) {
>>   		dev_err(dev, "can't get ahb clock\n");
>>   		return PTR_ERR(dc->ahb_clk);
