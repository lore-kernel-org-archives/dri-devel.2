Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749C3C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25BF89954;
	Tue,  7 Jul 2026 15:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHkTT6lw";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BE489854
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:04:50 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so458785f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783436689; x=1784041489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yjaKNQDIB8x3lV2bAr2D5lvHBXFHHvfoE6oAh2cW/Bg=;
 b=mHkTT6lwvfpQMHvQ92QLG08u2uluef7kYigkO71IB11REpCiuM4dFpehG9OtK8ExBS
 xL9R9C+HEG9iq91KXpIx6ANeVjbarTEsBL1QwUCwVToGVZoi5MJQHpgPuI7ZrQDLzi5x
 biQeqhr4ArgsVTxIn/OhF5MOC7sBca4fV50IN3arZyHkLsWIv7pTJC8Bmel2/o6fSbFP
 9Y7K2poh8IQcp2qYdzWwra+4jTfvg3gm54nrVT8BuRqtTCvseck//D0xjjY+8vRELC9x
 4djDZRLGprR2jOuNMzZkDrb5cGlHPrdOHN86Oh7eRz55UzVolphzxN2jhv1RUFWpwfST
 OeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436689; x=1784041489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yjaKNQDIB8x3lV2bAr2D5lvHBXFHHvfoE6oAh2cW/Bg=;
 b=BRkJEJ0CdvPX+V3umx+jWpHmXGRNKEW1+DFeIBEHX/mVJl3204aymQPcc+U0dYmyPd
 1+ApJSMLUwfO8yS4AGDRJB281eOHFt7WiHWF3NwMqoBPUymAOIo7VoEKd3vGLP04Cc32
 ZYqyDYF3uNEz6MuBZvO0l6Dsv/o9Mf2Y7rGhj6nIevgRXWwQVB1ZvI8dwxPRD6fOSbwi
 Ys3//P/l4Q6g29R75xJDc0S2Q5E2QzgkNQMYWGM/7DNnJcwx7ckR4iAuWthKwQ7BPFxd
 zXwBTog/SL+C27L8Es//9t2CuCXEUg3MGIM04Zr5pefwdYKYK+1M3/sItMZNcWfhbq+5
 VjTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsGndMhIZs8BdlEovsmBkD0FxgLX4cPaOiR5BgD3PmjVi70gOnHkxUbuSC3Fq+tyBhSZslyih23gQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGxepUef50qr4QmPvMLwp15PQitINH6tAyKQ1Hb98ajdOIVHfa
 5r9tbYrB0dVb9uD5hz8xuJn6aEnkAoDxQ29tgfICryy9q4wbdhecdaM=
X-Gm-Gg: AfdE7ckrg+d7yx6+5bk2vt8DotZq0QlnT6VOrw45YG3NyXSF6RcByd5zwimSsA3Va9f
 yCimXgL1q6poJLN1rUQ/8Vjd65ukewD2w+ESmrrLuKzOdd7JcEYHmTnvyoHfZuHdsmao/oyQwrS
 0GsFqPCeT8CGy9/WoIzxcc7mkjdtxwD2UCKBkMtHz7yMGW2gUoa6djSGcS2Nvzvm81bLHfuhnmv
 h83f2C2VK4s5mtvbB40Birh7YnQGSsblmof0tGWlsYnpwXHcG+M07UktVF7hdE53H7nzHZeJfJD
 h7wy/cyct+CIXxgsQRaFrMOIGx6ykfKmrh8WtlcjTnGxKeHKG+UBknkzIj7BcFXM0e3TnTaBJs/
 VATBSkCVU+BhtzHeKSjuTQ+8mydUNFHtJnebXdUZpAuJF+Qukkdv4RSYXA+NSoCaHGOyk2LS4Uj
 Pxv2u+o2fRfxHnOu3Ok4+A6vgFDG2m3fRJb4B/ohGSiGIJPF/olp2wO3ALNw1iDcIcNfxhHQ==
X-Received: by 2002:a05:6000:2584:b0:473:6590:c42a with SMTP id
 ffacd0b85a97d-47de97ea689mr3990217f8f.9.1783436688978; 
 Tue, 07 Jul 2026 08:04:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21328sm35142014f8f.32.2026.07.07.08.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 08:04:48 -0700 (PDT)
Message-ID: <6acf86dc-0df0-492a-b3dc-224a666214b9@gmail.com>
Date: Tue, 7 Jul 2026 17:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/13] iommu: arm-smmu-qcom: Configure lpac device
 with split address space
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
 <20260705-descriptive-name-lpac-upstream-v1-1-01d50c3e0c99@gmail.com>
 <5vfdbrk4bu77e7wgutp4h3ilbpjhcxxnwemqiufmtiwoffp4sl@oaonwwouw4qm>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <5vfdbrk4bu77e7wgutp4h3ilbpjhcxxnwemqiufmtiwoffp4sl@oaonwwouw4qm>
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

On 7/6/26 5:00 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 05, 2026 at 09:13:35PM +0200, Anna Maniscalco wrote:
>> We want the context bank used by LPAC to use split address space just
>> like GFX.
> Why?

I'll update the commit message in the next revision.

The reason is the same as GFX, we want split kernel and user address 
spaces so we can use per context page tables for userspace submissions.

>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

