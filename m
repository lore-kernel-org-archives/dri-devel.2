Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32756C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227F18912D;
	Wed, 19 Aug 2026 17:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WtaA7g2O";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBE410E11F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:15:48 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so12233765e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787159747; x=1787764547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RIZaPbOB6HKBdZ78dGgTPxABNHg6yS/skomGOo3KKQA=;
 b=WtaA7g2OE1zfFnNOXrNeUJuW/r1T4tBChcgCWVw5H+/tEPU7udv+n+ALkUXJM5K9Nj
 oMgsqRib50rbSTNx0hMovvhFP/t3J1gJxxT9UXgdSGzmB3ucp28R9Uft+PAHaBeMqw7u
 JX5fPM8m4CFhn6k/aZd8zQNGgrTk+43dB583h2LpDHjdRblmW29S/u4rgTqbq58OXxnp
 NQR6SgEdRhS+I9QBXbxs+i95AgWLF0hQc2A0RnaUrdumMu9/52RWeINMyQSQa11AbAtB
 7RODe35IlCwBaRGr23bFcEdcFX3PixocPmS/vDmAyecW+nLFzbIuFXTQ4STfiVY68vPS
 SrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787159747; x=1787764547;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RIZaPbOB6HKBdZ78dGgTPxABNHg6yS/skomGOo3KKQA=;
 b=oB/uveUXgJxFIFzl5LECQlJrJrQCOJ/+uSWMozuYForu4djhTYoukjYUFZbXXmvETi
 u72LTRJZD8Awt+Ms+zJdo5Y0kYRPxrIeVe2RTbGu4usSGHGgFuf5axhzOwSMkhjAEKfJ
 ZVoUnTRtQJAV/KhtiNw2XNR3S8Mo5InHGZAxA4gcnFbOl53h8mw1lyYSL9ymgiEN8VZR
 Oo47iRwB6R6Cvt42m1ISiuoTzbCszWDxIxDBMyfo1FJtGObkgd2f4TErpgfYOWwe7ZYg
 elkJel0XeDowjfi6IT7SVnRSxlEN4h7kVCIU//rz7O0h4dlAE+ISRVTUQKnYLOvfvugG
 PT1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHRnL0zB03VmWUPpLebOTMWEQTwKwhlFENt7Z/spigY9yNyCO89UnQRzTnvh6qIybtgB/8S/E8RMU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSdG5/HgFJTE2E5Ze/2oB4tsDdyRrjQHmyjiERePlHHwDr1uc9
 KZPCyxn8WTKcdrMdOy37XyOg21GOC4J4vFcAQMngtH+c5sQzldAi/R7A
X-Gm-Gg: AR+sD10jVL8W7T3WC3QwZUK7HChBuzHpqHxMq4DWfG+y5RtUjhpfBEOB04LscxX2MbE
 5tuJMyflikN2BiBhLAnunwUlUey4GkFqfb824jJutnSjGMqF5ivy3h7Cui+X2LnW66+9QS12y8O
 YP2EQdkJLzMZBqbaCzuJ05cs9hKBK2Kco3Jh8/RZqeQ5jkwtzGUAw4rr6AZ9Dx59x423FkklEMR
 JmWwNbUWOt2dB1XOZavVFxW5Bl090r5e2Z2RelyknuIRkqKiQh7alu3Ohzhga+znpgEX0zm5yH8
 so4CGFRkoCFW15yRWFwUIJ7JE/hiD63zsyMCa4bkMgWvfIVhqH/m6n1bWHuTtjTVeClZPx4uT2U
 vnLRA+Zd7/vmsFH5+hXI02IDGUWG/wvkivhUOl7u/YMgZB65sKsDfAN0T4/gxQSIH317TFtiCjD
 zQbepfa94iuQ4qJYM0SXJ78i0W9p1cwSBx9nV7soaVQ+sar6DzLe/1mie+/sC9C87Qwq7oOt7B
X-Received: by 2002:a05:600c:468c:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-499aa180578mr102639775e9.1.1787159747195; 
 Wed, 19 Aug 2026 10:15:47 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm6634033f8f.4.2026.08.19.10.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 10:15:46 -0700 (PDT)
Message-ID: <d542433b-c1e5-4759-980d-0ac54dd1fa0c@gmail.com>
Date: Wed, 19 Aug 2026 20:15:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
To: Mark Brown <broonie@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20260819152755.231754-1-ivo.g.dimitrov.75@gmail.com>
 <5681ef2c-b839-40c0-8e6b-65fff0f45af1@sirena.org.uk>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <5681ef2c-b839-40c0-8e6b-65fff0f45af1@sirena.org.uk>
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



On 19.08.26 г. 19:02 ч., Mark Brown wrote:
> On Wed, Aug 19, 2026 at 06:27:55PM +0300, Ivaylo Dimitrov wrote:
>> The OMAP HDMI audio driver currently has no way of reporting HDMI cable
>> hotplug events to ASoC. As a result, user space cannot detect HDMI audio
>> availability through the standard jack mechanism and audio policy managers
>> cannot automatically route audio to or from the HDMI output.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Ugh, somehow managed to send the patch with wrong 
hdmi5_bridge_hpd_notify() signature, sashiko noticed that, will send v3.
