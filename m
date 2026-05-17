Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3782CD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 13:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0318310E174;
	Sun, 17 May 2026 13:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y6UY5Lbm";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5813110E263
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:53:55 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso8403045e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779026034; x=1779630834; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ay6bnjdiJykakdEpJojMy3BsnRfLjHl5B+Mr2CQ/Omw=;
 b=Y6UY5LbmRLlDfhUT6XrVuOvHxDWHGGLUE0xVr8hiR76fyg2JtZpYCivy/xfSzRI2eE
 kl0mNnZfNa/OUR1FG1XnqQotH3YtnzWyVDORk4QT3Ws/DSae+DS/Z/28DRMb5t6LrqB6
 a+hf6Iaol26pI6Ql5xCs3/jGqs1p87ULV4heZypYvCUPEdkQgqSgtRFDMQITJ66XPVOP
 4NHG6mwSgtx4Sd8bM42vGLAI7jUzegsWxnhxyDFv3Ov+CQAaEYB550yI/nbZzLeFs6oJ
 CydqJ4qibX9O+PkIjiAsff16n8GxPBLuVQNQ1fDnNvcNCkJMyCRMG9b3xKdgF88grvl7
 jPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779026034; x=1779630834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ay6bnjdiJykakdEpJojMy3BsnRfLjHl5B+Mr2CQ/Omw=;
 b=sQbR3ifAC9aKhgF63m3BqvMgr61z5ugVF4mMLFWWyRswTQ+mDd8pIF0YQtlE2USwI3
 0A3mULEmdWEj8wSBTkix4N40epLzhWAK8CGsmmE9PrZzTzkePpFh49wUhR0LP9R+ytek
 jaUyB3YuVQjn8GfjCm+gTxXghVZYGNrrUV0XwY784vzwNfIVwLphQkKw71ZcwECSA8bn
 fXgKCGX5gm5Plt1NtSUu7rGPJNOtOaWyyjxholPRutTCOOHeWD99Fxs5S3XUiRoX2P4R
 OmeZ6HnhDYjHD6PGDf6KJfGj3dNi7xN3pZzP+/rq8YgyTpOTbke17wgl9CG+M5Fvjnph
 HaKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ91cuLAjHNKcVZ5syi3k4C09nx8GX+jg3hgpvjLHiEodZex6qOxQPfRcijCIeohJVC4hKMGADMda2I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+fEhn3jJUdvreGuzLraboOY3pJ5xExbMIlCmVA/EqAMzUj37Z
 2qFkRT5UqE2fVSRTHF84FFaItUIrHcNJnlO5YqEqO3iJQTN7ABCnB2OSekAIyg==
X-Gm-Gg: Acq92OGa4VR7AqpF9LPBFZonoFni4KD5hJFH5e3nW3GEB3R11YfGaVNfzGvZNopOW+R
 qGvg2nDWEVvR54eDDQRWeR636WmXhh88mTJlYExqcqtTcuOXFcSrLFxFYE9geaiOZcgve3vQCiG
 Eeo1z1h+UK0wXH7XXqOqaacJRe8CeFpPCdG74M5cIYKdksBtNwuTXEYUQg5d89oWEim41uW+STr
 0AcG3rAmhAJMfBALmM2Ift91vyi1wOp3896E9/LEXOTUDaSBhG4X9vXW2uebOXn6RHWCABsNUfZ
 42KiCc0i0hhBY3tbhnYKCPZoESfPHxqQbFf1IXMQDnvlODzdXaotcrtUnjy8R3PNUN9XRknichv
 p8iuWM2V5LoCQtN28W08GZCUnh6pDcqyVBqLmZInZU57CLlJhMrT1F45wwpfSCsd237vKLOtca+
 DM/YGB7JVB+1YRqS9ECBnBtJ4y5zhSGXCz+h6j8tji+iZXZseci8xrcWmgATjok5stGNao65uE/
 4UzyeKoNccLEcyd
X-Received: by 2002:a05:600c:8189:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48fe6323addmr174059765e9.21.1779026033650; 
 Sun, 17 May 2026 06:53:53 -0700 (PDT)
Received: from ?IPV6:2a06:4944:10fb:f400:509b:3e86:dfb4:f404?
 ([2a06:4944:10fb:f400:509b:3e86:dfb4:f404])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48febf8305dsm81575455e9.9.2026.05.17.06.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 06:53:53 -0700 (PDT)
Message-ID: <d5262f65-22b5-4ff3-b905-12bb2a4b587d@gmail.com>
Date: Sun, 17 May 2026 15:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/radeon: fix internal display on iMac11, 1
 (RV770/DCE3.1)
To: Lukas Wunner <lukas@wunner.de>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260510185426.4264-1-gilles.risch@gmail.com>
 <20260516092420.3579-2-gilles.risch@gmail.com> <agiy9II5jkHEgPAq@wunner.de>
Content-Language: en-US
From: Gilles Risch <gilles.risch@gmail.com>
In-Reply-To: <agiy9II5jkHEgPAq@wunner.de>
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

Good afternoon Lukas,

thanks for the review.

The initial launch date can either be verified in the TeraScale 
architecture comparison table on Wikipedia [1] or directly in the kernel 
source at drivers/gpu/drm/radeon/radeon_family.h where CHIP_RV770 (line 
74) precedes CHIP_RV730 (line 75).

The test robot mentions that it cannot find ASIC_IS_DCE31(); this is 
because both patches build on one another. Should I submit both patches 
as a series?

Kind regards,
Gilles

On 16.05.26 20:09, Lukas Wunner wrote:
> On Sat, May 16, 2026 at 11:24:21AM +0200, Gilles Risch wrote:
>> The Apple iMac11,1 (late 2009) has an integrated ATI Mobility Radeon
>> HD 4850 (RV770/M98L) with a 2560x1440 internal panel connected via an
>> internal DisplayPort path. This machine suffers from a similar problem
>> as the iMac10,1 (late 2009) and the iMac11,2 (mid 2010). Without this
>> fix the display stays dark under KMS. Two issues are addressed:
>>
>> 1. The RV770 implements DCE3.1 and not DCE3.2. ASIC_IS_DCE32() starts at
>>     CHIP_RV730 which is newer than RV770, so the RV770 never matched the
>>     DCE3.2 PLL and encoder logic. Introduce ASIC_IS_DCE31() starting at
>>     CHIP_RV770 to fix this.
>>
>> 2. Apple routed the internal display through Link B of the DIG encoder
>>     instead of Link A, as observed in the kernel display connector log.
>>     The same quirk already exists for iMac10,1 and iMac11,2 - iMac11,1
>>     was simply missing from the list.
> Not an expert in the radeon driver or AMD chip revisions, but if it
> helps improve support for older Macs I'll be happy to offer my:
>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>
> It's not immediately obvious that CHIP_RV770 precedes CHIP_RV730
> in the enum and that hence ASIC_IS_DCE31() subsumes ASIC_IS_DCE32().
>
> Thanks,
>
> Lukas


