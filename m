Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2E0C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7933A10EB30;
	Wed, 26 Aug 2026 21:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eoNvyEUh";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CBD10EB30
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:23:47 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so12575685e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787779426; x=1788384226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GugmGFT4gxJePnq6fq8TaqfnYFAnfQs0nJJZcVwl//4=;
 b=eoNvyEUh6jiX44xZGgFyAsKoOVanobZ64rKorWD3NPVzHj9a03ji7aEDuC9pIxIXQi
 tmC1MAoXOYKCK5ovl6Auk1AKpubgAumgRozhDXzalZ4SREqC/x1QcchUveTzD2yd42tx
 m5A8rhM8C/KNtSvMlsGa8ApE3SapR/B2qlwZu7zlVXWxRtC5BvQUKAkT5B1drBrd/axD
 1DIqpySPbImQMe8haXaeYrkwRo+QLWhoFuR4sCi1mCw36yAX/s3qmn/n87d/4SFe1bMB
 CnIMTaeZT1NU0YXGKl/D5ZTDoPIt5AbY4/N3opN1uD3qdrT9QYRcfJ+L1Lheb4A2WEFu
 VhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787779426; x=1788384226;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GugmGFT4gxJePnq6fq8TaqfnYFAnfQs0nJJZcVwl//4=;
 b=OPUPNCs9XZEicYok3gxJVI4O3Q55szHUOzlxw40yKB+Ts7qskiQX73kRqe0r/brtxC
 3OtYrCLoNw/JyCcBCsrcbLmGieUIhmZbBcbcOYO1kMDRxq8XMrLqhHbqoK8lBUf7Jgl+
 vwjZKX+pzBhth1BQECT/C/InGPzzJfHy+Q/en/Stz3Ve7Zb6dOI1c+Zra6hZnwrTPSlB
 /nStxVaRscvd/FLfkyspcM++BD0KRD5unL3ssm0NzGOs2o/UYljRaUk7W+RHJ0922C2V
 eLEB3Z1B19LJZUp/g62ZytTeYwWEoOL0U2/Yh4d8OMOrL7xLBxWEeOXnWsklpfmSH8aM
 BTzA==
X-Gm-Message-State: AFuF++l7YC34CkK5yI8I0P9hfVCCxRNMp5488P7vr95/cOlBhGljHrd2
 2l3alJaD46/qDT3hae5l1mtS68OUOKuV4FPSotGMnwz7AUOOkNZ84rD8
X-Gm-Gg: AR+sD13XeyIWtpwpTD/FEYPI6bEMLyN9kM44E73nxalu4MWrt1T4qF0h8LkStaa/KjC
 FkV4/0HI0PCFP1SWNW53fOOnwDpvfgLa9LiMt4WQxvKjRikACV4GWb7LOJGCdmCUdIEaRIyST7y
 jbgiJJZrJkRoCisL8MmDo8RZqjxwwRmt7tXmycFy5fhIj3Oi7rCAtVzHUzgJ6loSrSqLkrWNLkk
 rcsHO3TpQ7NUa8rbdDElowlCxxrcqHT8Ww29XUhSPxscukMrZViYqGuQlp+vbOFukYuM5nryQ07
 +SAqAl9p/7z4eZaBDdDZsDhoy7G34nZrD4aThQKwMP4z0YmQ+UoADlBJrkmU6N7QKc6svzriuU6
 QcdYAe9zMgjxlfaDgy+iVokwnWHxeMYjrgBGIQ2Y4j3ZUpWOKVmYFwDvNxKuT6CGPd+eOAEUl6h
 Ugqmm2uoEt0DUyO1gbP7nVoTpLmiXxAagV5NaqR8mi1WkoWdL317iXIkhXny844naIoJ82NbeWi
 SpqiTTvafFq70GUyqVDpPrRVhhq2m2HSrI=
X-Received: by 2002:a05:600c:c4ab:b0:499:a8bd:1930 with SMTP id
 5b1f17b1804b1-499dc6ef59dmr91098105e9.5.1787779425938; 
 Wed, 26 Aug 2026 14:23:45 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5721a0sm29439705e9.4.2026.08.26.14.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 14:23:45 -0700 (PDT)
Message-ID: <290b2648-29fa-4ec7-998e-74e1696922ce@gmail.com>
Date: Wed, 26 Aug 2026 23:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/70] drm/stm: Switch to
 drm_atomic_helper_crtc_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-26-fb793475c05a@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-26-fb793475c05a@kernel.org>
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



Le 21/08/2026 à 16:39, Maxime Ripard a écrit :
> The stm crtc implementation uses the deprecated
> drm_atomic_helper_crtc_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_crtc_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Philippe Cornu <philippe.cornu@foss.st.com>
> Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Cc: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


Acked-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thank you,
Best regards,
Raphaël
