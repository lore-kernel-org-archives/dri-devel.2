Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF407C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D2E10E370;
	Mon,  6 Jul 2026 11:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQe3nvdK";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F2010E330
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:07:42 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so29223955e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783336060; x=1783940860; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hwdEJkuxK+8pOC6TCcezbBHIneZ4lflSArjit6m0NnA=;
 b=jQe3nvdKG6pIvRUm1+dnHnte6/GA27gnA0VpRU9Pi5OhoedoJjD598iLfa+/8dzxdV
 nWwplXWrfhQ/m/5ymV3HxHYqxP64qwhHdDUlBnPlvAN1K0wsK1hmnONYftcQrr/S0Rt5
 sa7rvBlAp7g8XrjMNrpy3cobiIWIT6KqbjbvOOcKowrcxT8eAkc9yNpEcKvT8DIew0tI
 ApcIF/B6/IddjOSaKyXNMJLd40hqngoGB3eMPd8ONIRb1MzDRrzdmb4hzCpVIbzj0b8e
 +d3F5RFgb2b91EnVrozuIqngmAgabrvcUMviORZPlT3Fno2LdECHr7hoa6Udm7w3STJ1
 zoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783336060; x=1783940860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hwdEJkuxK+8pOC6TCcezbBHIneZ4lflSArjit6m0NnA=;
 b=Z1Aetim/7Drk+giklY4uiionulzLb8P3HQJbaXw3Jtu75+bhZ5bqJrFx46rIDY4WTd
 AmXsLoYKJ5eKUeE7IfNUrzRLxV6FLZl+ZI5QwHoFHGbr0OleS/KM3w6KXSx+Wu+VzFz7
 Nkauw5jiL7mqBy+YNQoM2eyE8I7OlwMGSteF0VcwM61KaeDlnkbDzw5gsIejDTpdCRED
 O4Jio1wq4ur80a86S8uY8EahFvWBNdIZpwjKsif33wzozv6Cx+brLQwSVUE/8wrkSS0A
 XtNqh2POnX/AV1c9jTTHDdBSNhcvx6qtsZ4hC+53bn+oRxz7ElUgy+EF5aF2lnopPtL6
 EXZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTEaNquTBLIktl1kJy3RYfNhgEvDC3Y/hvDcCj/6ry2uY7NKYOO7F7foWS0X8Bdb0S9eq3L/wBNqs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxebl74aMSXXIHPd5xkaGJv0BwgAXBfiecHBEV6jKNLYh590Fso
 USPwZrWQd7Nv6qoCqKdObgD4gDz4dwi8lSvNG4J8Yijobxj7CwD9gsI=
X-Gm-Gg: AfdE7clsV0l0qrAbC8jrfHOvdtn6MRcTnX7eg6PBpHN/5B9yVK9UOlJuihVpvmMAmEJ
 7JeerzEV8n634dD0A0avd9TJ1qy2XlCIpmvfvWvSevg0LKAVj0ThSd+xWnfgbLZr4qzcpyOsXWP
 Zfqk1IkiOSW+MyYzYEv4C6zgGzyRkScAlQdshv01d5YjonCpOko8f+i7yoloCTSs+lKa0sNBjTO
 bzyFLojQcDgaWSV+pw9Z6XByW6bNAVM83C+8HLcpx5KATlY8XeA4SPm3WvTalXERb6IYUt5kcau
 g6IeDke9dt79nRgt+3S2loyV8Lt5NC/fv08zQYvDJA+X8Q5kUYAEFlRuGmdlSqDrEea87v126k5
 gaWyJjM9mJ8w8LpPAfoYydowpLMydpZHqYi4p0yMLj01XP+a5VvheUFJNLP17YPEjp6RPEfP7Hq
 JE00xu+iLG2JCyxgwYBDcMsTXy1Dngk54okDAv//wq7t8S/K8XEUKPO+RgY4Y3AN+4+rfPLw==
X-Received: by 2002:a05:600c:c16f:b0:492:523f:a3df with SMTP id
 5b1f17b1804b1-493d52ac417mr90419125e9.5.1783336060307; 
 Mon, 06 Jul 2026 04:07:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce12c40sm463102745e9.13.2026.07.06.04.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:07:39 -0700 (PDT)
Message-ID: <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
Date: Mon, 6 Jul 2026 13:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
 <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/6/26 10:44 AM, Konrad Dybcio wrote:
> On 7/5/26 9:13 PM, Anna Maniscalco wrote:
>> Program all the register needed to start up LPAC and send initialization
>> sequence.
>>
>> Additionally, now that the LPAC ring is live, make the code aware of it.
>>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
> I believe some/all of these writes need to be guarded by if (has_lpac),
> as many GPUs lack these registers and there may be side effects on
> others

That's correct yeah. I'm not sure what has_lpac should be though.

Something we add to catalog? Or checking if it is a gen that has LPAC?

>
>
> [...]
>
>>   		a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
>> -						      sizeof(u32) * gpu->nr_rings,
>> +						      sizeof(u32) * (gpu->nr_rings + !!gpu->lpac_rb),
> Should we rename nr_rings to something like nr_XXX_rings
> where XXX is some uarch-generic (i.e. not SQE because we also
> support pre-a6xx) name for the main number cruncher?
Qualcom calls it GC so nr_gc_rings perhaps?
>
> Konrad


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

