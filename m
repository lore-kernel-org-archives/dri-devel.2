Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADB8C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8BD10E4F0;
	Tue,  7 Jul 2026 15:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g1naV5Sf";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFDC10E4F0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:02:48 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso42518025e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783436566; x=1784041366; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d8YHwGJCeEFKefM96NEtoTmLf7gsLMxJ2f5daJOJFZk=;
 b=g1naV5SfpK5c0Y6AtQrSEvTRr6Ae7D4jexxdNM9IzysJXca5nrnG72cMqgnA/Gq8Vr
 z42aR6U+nHpgyg9uIv+WGaGjGbcVd38H491V3HQArXmRDAKPhDuvKuN9WT8unA2zz7Yw
 Obk+RJOLb0oTkcpz46AOyMy9Qmpt0qCc7760xYDjS2Jo/zXn7aTeKgk64JU5lDRPHQuS
 4Oei5fn3UNxgtfJhgqqJuCuS6dc0gobqz6Zw/3Yism1Q9jYtipSea6vYYEzB8rD87uIt
 tNuhqI/KafZP7d3xq978nuIYBNNcsGsa6BfXgeMbQZ7CuUHD1gNIsecqLQNSHkN/ReDT
 lQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436566; x=1784041366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d8YHwGJCeEFKefM96NEtoTmLf7gsLMxJ2f5daJOJFZk=;
 b=ZZuy8Kb3Prd+XLW4xQQRU5qiwo3oWnREN3yvVD/Hpu+CLNW5KOB6Xo3SQ6RVZXjC4R
 LZXYBHouOvM5HK/7RPeLmpph51YP7D0sq0pY9hpoBmepv8mE/Xo+h0ddlinz2C4doDgC
 ymF/zmmF49BBsmSewMr/3C/uE6e42hK6E4LPlWOTTExjKvcM3TFlBkFVIL3ZQKQk7Swi
 SgklijQFvGoOEyYRULPqTg0Mjxu6oW6m73gY5PEeVd/TGVxYz1TDaB8/bOovSWiT2OaT
 67ycvjl0tofMdccQrWSn1si3r3cK1pEzelnQdQV/yMq8QjS4sYzgdpTtD6ShtzdpKEU9
 ipxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0bGyLZPRCj59E8y9phtif0nrFyHf7xJYC4Kk5kpjRygdfkfiFpV0L2kD9b8qeWdo1e3u/QYomiJ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydKJSl/mHUPpKWL72CVkZg6XMU7943Ic22xmn50Tmo4lvNLnbU
 UZnwWNFXHu65VpC1Kb0PVsUbSl6m0B0tbgJOYNChIdWToiVKneEQeOM=
X-Gm-Gg: AfdE7clxtQzpNEj5745y1qEz2rz9zNGMFg5ecR0t6WiadezzrIZLVUp6FKcqnLn/3jf
 acLuAWPm0N1353518jniQeg+wsUIQktBmmy4OzUeTIwICYpB/Kcuz6SyjOaFYvaoW0bngQl0wOM
 EU2nGOxze6u2d8dBHjIhfEkhkld8ZAGVhJ9i6fWWA5sN8FZY+LgrBW1UxED30JuWhEoPgO1MF/+
 nVJ/dpQHG5kYLk09VmO4kLBkHM/T2jXWRo6FZzm/k/u8GxVGts6A1o4+uhX7SeMjb6aOluTOTI0
 toQYGDHYgBOlt+eo22rhuaLWusJJsfZ0NZyICawpYBEMB18ejmljeS/nOefsuwdop/ZXVOP49q+
 GLJh3qH4Ev3QZbdg2to/fNVsTJr0xLlHCW81quAOsqW8i9dFoFGNcomx/jHBIzehFlz3knh6ONJ
 pv/wI1ypBgT8zOx2zBai9S7F7n/1IjEOEUPmtsft+eDimHBthfYSh+2xSueq4xpzONQCiFSw==
X-Received: by 2002:a05:600c:4747:b0:493:be3e:cc3 with SMTP id
 5b1f17b1804b1-493df093146mr65333955e9.21.1783436566150; 
 Tue, 07 Jul 2026 08:02:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e10af392sm62069495e9.2.2026.07.07.08.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 08:02:45 -0700 (PDT)
Message-ID: <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
Date: Tue, 7 Jul 2026 17:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
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
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
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

On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>> In order to associate the SID used by LPAC to it's own domain and
>> context bank we need a separate node on the DTS.
> Can we use iommu-map instead of adding a new device using the same
> addresses? You provide zero explanations, but it seems like you are
> trying to separate a part of the GPU into a separate device, but it's
> unnecessary.

What I was trying to say is that we need to map sid0 and sid1 to 
different context banks.

 From what I recall, so long as we use the same dt node, the iommu 
drivert provides no way of doing this.

What kgsl does is having a node for the iommu and then subnodes for gfx 
lpac and secure.

The address on the lpac device doesn't really matter. I have very limted 
knowledge of DTSs but I think we could just leave it out altogether?

>
>> Add the code to look up that node on initialization.
>>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
>>   drivers/gpu/drm/msm/msm_gpu.h           |  1 +
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

