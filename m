Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0D606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pXH9LeH4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB531112C4E;
	Fri,  6 Nov 2026 09:18:53 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853B210E9B5
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 22:59:51 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5be4c78e8caso42400e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 14:59:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793919589; cv=none;
 d=google.com; s=arc-20260327;
 b=aHl+n83IK287w43yUhAxXQva9wMmuRcbBuDqKxkxErW+q8t3qswhX5n0m7DZkJoMM+
 NgC3kewtiGv3Uq+8C1RDNawHa9dD06V55YoZKFhbnyFDKVzgEhBMUm7NrVpxkVCxzfPU
 rnxLPGWF403IQkrY06Sx6TkR51lNKKY7eGx9tbXqzbJI0WHuM1D8Kab51bT51Hv3uXzv
 YECpYvJGCz7xHnmTAS8ktk283kfez+KgFRBxLCqHYUZhPT61GdzVcMvpW+dKhveK4jiQ
 6X8eNsmIKRIW/VcXBdnzGDsmijEd8xrAhn1m1b3XBQ2jwyWMUxATu8ZdDEWwKsPdrSpf
 dl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RrHtlwl+AEhIC5xfPPlTatk3kWQjUPqvdwoLzmNPK+8=;
 fh=h04SB424eAFQ35+PpqkMYYEa7TP6TFcbAeQaq4ZZ0iE=;
 b=SC8fUc1A0yHn1zHonjQIWAMKOIxEi6f0JggxVv3KpR9U09ksS+oBwk3eIcRkecsihL
 5dWthDLju8J9bMm+UbnZ+esszxSsjOmgsSfYiBx8Dboo3/9bWWidnQMtis/1kWs/u5Aa
 tGNGVW/wfDxMkbCgnGz8E09ulguqHzqGcywetpvVW8U5wJNNGgfHefkpz6Zccc8PEkU7
 r+600yrNn8oG63aMpgj6tfjQ0iWdWMP4cCXuekkUshAtayEkCLLyJRJHokZXwoQb6Q8F
 LYmigyI+vaAQpTuWATcue7DX9hFLDY7xzDm8j5jJ/5WkXZEDMy8ZbqkxeHTIfHEWapgA
 GZnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793919589; x=1794524389; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RrHtlwl+AEhIC5xfPPlTatk3kWQjUPqvdwoLzmNPK+8=;
 b=pXH9LeH4e6lBSJb7wYQG7+ErrtNmGtE5mx+6tBQ5KnPgyOWRv5xTYkI2ZvQDUuqJ15
 Kcmpq3OZBM94rf2YjuXMlLrW8LAt1cCg7NWwu5a7flDiilnk0/mDmdZWcH3mXLkMCIhQ
 fj0gFTkMMe6+5fOKgLVpr2fbgFNWYaXiAoWkee8yMSvU8PPU+AHKcowNFxtNtE0s2kBC
 Yqn6rJ17t8VYMmnTgZS1N6La0LmA5v63QWlub4R9uQ7O6G8xlxZYy11cDeoEIxh2AHAM
 JCfy1Q4nYfZo9HMsBHUfGnJQx4CjWTpJzZpjaafgXTZCXKgv+uo9hcJgxq5NxfYAQo7t
 SGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793919589; x=1794524389;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RrHtlwl+AEhIC5xfPPlTatk3kWQjUPqvdwoLzmNPK+8=;
 b=YUmIb6z25op6VdjzPkhyzP6JXFZB8Dfm/HXTg9lz8IthJL4YaX5z188kWHb0KsPkl6
 BbGEpfg+fpzFrZR521SpWFZCa4snswjtCIt2oE4qejT8482TbIDo2pcNVYf00jq4kOhh
 yx+viLLhrzN4jPHLASUf7p0/EzwdDAajUmmbY6rMBJSTwNdKNNjrQRteZLAG30d9Wq/l
 4u8WfeJZBq2wiQMnqHZy6uQWHsSsobbXGjVWPuoEgHIIwACtf/3zEhfYv9GuTGK62SSg
 CpbweWEw8SpBIQ3hi+VT88zWoE4jXGQNA/C8MnbNyzgAwg9VpfsUM5y4gZ1Z5DXs3tgQ
 zgpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywUnfGPYguTf5SobGEdq7fIN+5dQmLouF/J6RvvGdkaXsuSnjVwoNpNCpySdtmxlSxJjkUMVu0IXc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90bY9kB61Ey6V0uA2F3/yY4HlXUQvItXlyuwGgRnw39Uq40tj0
 a5+Jc+gvp4Nd4jjPL0nXSVfBSEeqO40npXMK/Ikeqxejp/hF49sjuV3jzNnYAbtf9EFJQ46UhhP
 X5yC+26nOUrq7+rcH87Qhe7iEDHViiSg=
X-Gm-Gg: AYBFou1L/Q25dMtQH0dYALNYBReWyC3OiK4EkhHAZ3S5i9WJFpqqSAwHSQopcPcWFIr
 i15KBLMoQ+4gfZjcR0XKiYfUBsU2yJI9XzboAclwfV2Gw1I6FhcUOyUFKb0xoP0VgWN9V5tl19s
 2N5czrXE71eMy/4SSjlDOjx9R0o2Q6UQ/mcE77AJOGbrpckf7giSaWtbIl9LTguxkGN4C79WiV2
 PueAtSyg+V7qzjAYlXfK9OaihTb+xIQJBzYRxRqkUYP49oCVxF+U41dbTYqv5iwBkOeYa45e+Yu
 ++rNtS3cruKTR/BcM65msQXcZ5gAjnBnu8jPBpG+swAixhAjppB8B2i0OyckC2prQjSv+yndgDm
 xG8FySD+SNyzgnFubOnpgT/AxD2VYRhqXXs9cQEj4hdlTcebR7bBMSWGilH9y
X-Received: by 2002:a05:6512:1192:b0:5be:4a09:cda5 with SMTP id
 2adb3069b0e04-5c003af7714mr125332e87.58.1793919589269; Thu, 05 Nov 2026
 14:59:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
 <bd3b073b-cae5-4ea8-8ed4-063db0aa5e64@oss.qualcomm.com>
In-Reply-To: <bd3b073b-cae5-4ea8-8ed4-063db0aa5e64@oss.qualcomm.com>
From: Fabricio Akio <fabricioakio@gmail.com>
Date: Thu, 5 Nov 2026 19:59:10 -0300
X-Gm-Features: AclHuK-50e5PrDAf3J21VAWq1T9hcSqfrAmJp671654qb1dhNNUctHumFE4UGmM
Message-ID: <CANxzQdFZL0_KbNHfQ3DWyMfp-SuEyomRCdYi9tAFMkGkcoTatQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/msm/a5xx: Reset the GPU when resuming it
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Paul Sajna <sajattack@postmarketos.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 3:29 AM, Akhil P Oommen wrote:
> On 10/20/2026 7:35 AM, Fabricio Akio via B4 Relay wrote:
>> On SDM630, SDM660 and MSM8998 the GPU's GX power domain belongs to its
>> SMMU, not to the GPU, so GX switches off only once the SMMU suspends as
>
> This is incorrect. There is no Adreno GPU where SMMU is powered by GX. I looked
> at the DT of SDM630 and I don't understand it. Seems like a creative workaround
> to vote different power domains.
>
> Please reword GX -> CX here. Adreno SMMU is powered by CX GDSC in every chipset.
> In some chipsets, the core GPU blocks are also powered via CX GDSC. So it
> makes sense to do a SW RESET in case CX didn't collapse due to a vote from the
> SMMU driver or something.

Ok, the SMMU is on CX. It is the DT that gives it GX, as Konrad also
pointed out, and v3 will say so.

The message keeps GX, though: with a test DT putting the SMMU on CX
alone and the GPU on GX, the CP lost its ring state on all 4 resumes
with the SMMU held awake; with the current DT it kept it on all 3.

So v3's first sentence becomes:

  On SDM630, SDM660 and MSM8998 the device tree attaches the GPU's GX
  power domain to its SMMU, whose own domain is CX, so GX switches off
  only once the SMMU suspends as well.

> Instead of a new API, we can just move msm_devfreq_resume() here. That will align
> with the A6xx sequence.

I take that to mean removing the call from msm_gpu_pm_resume(). That
reaches A3xx and A4xx as well, so v3 does it in a patch of its own
before this one: a4xx_pm_resume() and a new a3xx_pm_resume() wrapper
call it right after msm_gpu_pm_resume(), where it ran before, and
a5xx_pm_resume() then moves it after the reset. A2xx has no gpu_busy
callback, so it has no devfreq. I can only test on A508, so A3xx and
A4xx are untested.
