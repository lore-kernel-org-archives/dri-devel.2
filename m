Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76B1C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E8D10E17F;
	Fri, 18 Sep 2026 20:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="G2uHRqVI";
	dkim-atps=neutral
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D7E10E17F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 20:56:59 +0000 (UTC)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-cc1d57602e8so256355a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789765018; x=1790369818;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/Is2lUlBqSGMkpOZkUx2pau6e4D6+5AaH4X9SJHq0Dc=;
 b=10btaLSZceA0YNf5BPMrSMLa2RB+v/J9V1zvzlXoTct0LdUwAtoROZSF0z9LimfUSI
 aJwHkVxJEsppsdgUIGVz+zYTIlA7gCK3DK+AKcBk6e5zgBEPWHXkzuNwfDmBKc/GaIZB
 Oq8GDU2mRVf0E+lZussVw8OV2JRsG2TRlEBpoPv7h+qJd5JDTUkCQHXLkEHO2dlmThyr
 HyJepehEcFoaPse1L2acEVsGRde6S0UuMe4UgiC5Zpb+ZRGR1DnLGhulI6kolQp2GoTb
 88KkscZfdm+9rwCdvD5Ta2eAtj1vXSPlyZZFQmrmKdTXpc1P5LLtWYm7PIiHFmoZtIcY
 ftLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4aecpfbqpYFMs13CZzoJAGqCd8qgfVL1hXOgdnKJaqI3FWqjDdnvvQXiE5LorSZtyeR/Q2OjeT08=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n30Q8sM61JL0ABq7iH/uA6kN//lPnrKWTCaTmH7L18mP788VyS
 555D0PkgSIB9fmvJyZxQeGDtQXqhnbAMh20ZWSvgCgfqQoiXVNAtDwYryNQ83+3dEicMnarTmHf
 Q+Z2e9DbnHzhLnTdRgM1bHmF3LvrKidUhgrYbLBolXJey3PS0257vEwNW39My37QjKLI3r5AQEL
 dvDiNx2eNQmGYg0CH4g5wrbWAOzHqnlpARBuhBpIMH1LDwvwuTGdNBXR+N1xtA0Nt1eABcT2z5T
 BNY+8JVJHxPdKxbqr5qf2DnrAcz
X-Gm-Gg: AYBFou0H44Uk7yLhMlOfu/XY8BururCy8jKprUNtBUjXzaRgn6aGhbW96baoHCujdWk
 vOmVBTXHPO+Bo6cMCNRlX7mFFyLTKqa8DHx1HdDFdxUCYpforjs6FvhaYmWeIskC4YapKilrwUJ
 7wZX0BmvpHfDWF0iaRG7g903ANtxAcAUWF1OJRqycOS+AE8MeaaxWF5SDlilKPYj+C6RnvX3chx
 1sb4d7yw8UZ0RpFHASX9zVDXCkHPc+p6xVGunZDCY4IxAjGkvhHW3rH0fR9Bt8HfBOyjlhRbbth
 tQ8UIc8Mn1QqbeKNnAl6UmDoncblg7OyHg9Rmq99YQZIpvNnebDNX9tozBqIK4SO48MbFVBUi98
 uTxvTXQRSL92o3wUCgqjPP4kxnJCgO5iMUXE9lIltO2ORPJGab6wYpdRYYbAfv6Kt7anZZXxYLZ
 eSybz5HOjuwJgo09u31sVzPs5OEIcaM0OJ3/AgJ91Y
X-Received: by 2002:a05:6a20:5491:b0:3dd:85a9:55b3 with SMTP id
 adf61e73a8af0-3dd8c59039emr8483141637.30.1789765018311; 
 Fri, 18 Sep 2026 13:56:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc72aea959dsm182729a12.3.2026.09.18.13.56.57
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Sep 2026 13:56:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2db87f759c5so23120845ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789765016; x=1790369816;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Is2lUlBqSGMkpOZkUx2pau6e4D6+5AaH4X9SJHq0Dc=;
 b=G2uHRqVImSn6G5WwRhnHHsgGllVITs8p70Gg77oHWwQh+FLdwY2wu7t4107KmVTuAV
 NNRI3uOSPOV983DQxtFDrjyNdX4ppBntxbRxkGZVFf0hBRy3kWLVF0FZN1jKr0GKveDh
 gPRyHY8C74z5CzfG0M0CB4cBLVPOmlV7pIO6k=
X-Forwarded-Encrypted: i=1;
 AKwUvBylmCh7pBwxZPY9FKbOUiYm1noB53oTltYnWoXNnO7TpC2LMJWkrt2zW2mAWuEfUU1rdIdH0yZZJMs=@lists.freedesktop.org
X-Received: by 2002:a17:90a:da8d:b0:39e:6a81:5a92 with SMTP id
 98e67ed59e1d1-39e6a815df2mr1513934a91.38.1789765016275; 
 Fri, 18 Sep 2026 13:56:56 -0700 (PDT)
X-Received: by 2002:a17:90a:da8d:b0:39e:6a81:5a92 with SMTP id
 98e67ed59e1d1-39e6a815df2mr1513914a91.38.1789765015849; 
 Fri, 18 Sep 2026 13:56:55 -0700 (PDT)
Received: from [10.211.247.235] ([216.221.25.44])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d54b248dsm1235932c88.1.2026.09.18.13.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 13:56:55 -0700 (PDT)
Message-ID: <ac19e380-e93d-470d-841c-7bd3f2b0b86a@broadcom.com>
Date: Fri, 18 Sep 2026 13:56:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for
 PRIME-imported surfaces
To: Claire DuSoleil <claire.m.dusoleil@gmail.com>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
This looks llm generated, can you disclose the llm that you have used?

As for the patch itself, it is too overly verbose for human review.
Could you just describe the issue you were facing and what is the fix you have done?
Describing the current behaviour and the overly narrative style is not necessary.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
