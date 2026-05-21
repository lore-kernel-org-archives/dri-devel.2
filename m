Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68568CD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 17:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA13310E54D;
	Thu, 21 May 2026 17:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sb2N5EO8";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89AB10E54D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 17:59:33 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so4792436f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386372; x=1779991172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CByRJY1ZmIfy6w9D1VtZFOKx1JNNuMZVWudWcvdfISQ=;
 b=sb2N5EO8ngnBwh9eckuYmDkTuj7fSV63KWOxmyl63d3K3ryKvv/qd8s9ffX77u5H3L
 8sXNPxfqnHhpG2g+xKN7wR+BqhYafqI/XLWZin4PrElvsi3ZA943wr9UxCVp7PCzfXdi
 dhy0RaACUjlT0LihfFRbpxabUb+tvgfOAoz1RgmshD2K6C+A/PdMdTvvmZstEkc1tJcf
 d4mvpPkELppnazCqxkhhMKyBwDXJo0ih5cLwBklIOCQLy67PRKACeqFntP7Usa3ME1Jk
 ii70d5pwieq0JfwBaEIBjOGDEkkz1IAldAO5wh3L22Ph5NumOBKWlRlklXzzeQw3RIaP
 3VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386372; x=1779991172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CByRJY1ZmIfy6w9D1VtZFOKx1JNNuMZVWudWcvdfISQ=;
 b=tPTbqQwIv8jRK7bhrWiIAAdbBx50tdLGO5pEP29frNy/0gm///NE0+5tbiTB5T9v0x
 ABTmvrDgcy7eTlBhppZ1s0y0QZfxK4tiIyUwjethVq9YrWOskLbjM0nwsLgmRrF2UaQL
 rmd7U0c3Pb4kNJ78aPAHbs4svL3lREnEavo1i2zBWlTfWrconMddbDbqlaQwTu9/w7gO
 jtA1PdWvX8UnzLErrgzKipbtfAxuKvTOmwEsU1DWLaKgiOUunJ8Mos8p7KdgVHzV6mDM
 XKatlyuc7UoWeT9NUXy02l9p99js0UExgmAA7P5UqTRiVfcBnvh/3IF6IFmBcDn03DRR
 lFYA==
X-Gm-Message-State: AOJu0Yye3ceOb6fvftmFENihCIKsxxw7ul+sh24C58//BXDVlFM0GqWD
 nYC4wFz9DAoFKj1FKArwkZ1+S/hBWo194kzEeGj882vctmZ4qvqBJFs=
X-Gm-Gg: Acq92OGiSFeczEt9i+jMC+S4E7Xl5LVyhV0rmd43/vCHUuj60/lMhTpusCvdvD/KIOM
 3wEZnP4asXT2IuLjeqqxh6ZdWvddKbIEnerOw36TXrVb5p/9sHLo8Mvr1UpCjgBbQ9LssndBuxZ
 nrDnC8043Zg4sxwyDdL0ISgn6h1H9pRKHBj9fYgXEm7GFUGGfj88Te8gjsB7OIbJblMB6IJXl8Q
 zXZzlGU6pv1hoNT9PfDf/fdF7U5YUhI1oYPynx57WD5AqOUYI4+jmcXJS5wh0oFnCQ6/7AYpNCe
 mrdVjfAswm6bfcnoekbKYcO8oU58gyTsXjA7kdNtjPyYhHQM60ws39gsVJhfXyFMj9Ehfb2Ofdp
 mcj4Ed+OeJkj0lQW8xQxY62S5DJMF7qQtZ1ajFmNZOoEq8P41xeyArWdT2ljuH8DWD8jkrs0dS7
 gEnUK3c8/3JLyE8Xfvz2ImXIKeLDDs4gOBDwCsXhsQGqNniLzep7sjG+QGRsa/3rtH6a04PvVt5
 taK/I2qvHX4fm3w9W9X7eDQE8mI5qIvadzQ2TLGpbvIRXQn94poR9LIzm7MLkuLZmKQmA==
X-Received: by 2002:a05:6000:402b:b0:45e:73eb:2a75 with SMTP id
 ffacd0b85a97d-45ea3ae7658mr6591102f8f.16.1779386371837; 
 Thu, 21 May 2026 10:59:31 -0700 (PDT)
Received: from ?IPV6:2a01:cb08:52d:7400:bbd7:ca83:de4a:f625?
 (2a01cb08052d7400bbd7ca83de4af625.ipv6.abo.wanadoo.fr.
 [2a01:cb08:52d:7400:bbd7:ca83:de4a:f625])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92f622sm4635686f8f.24.2026.05.21.10.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 10:59:31 -0700 (PDT)
Message-ID: <ec040a0f-9ee9-4a26-8dcf-3ae5c5aa72cb@gmail.com>
Date: Thu, 21 May 2026 19:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] arm64: dts: qcom: sc8280xp-arcata: Fix top USB-C DP
 alt mode
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-5-9df52552bf87@gmail.com>
 <990a0d6b-ef5c-4d7b-ab63-e75c37825397@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
In-Reply-To: <990a0d6b-ef5c-4d7b-ab63-e75c37825397@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/21/26 10:53, Konrad Dybcio wrote:
> On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>
>> The top USB-C port (usb0) didn't switch to DP alt mode, as reusing the
>> same GPIO 101 as on the SC8280XP CRD or Lenovo ThinkPad X13s was not
>> working on the Surface Pro 9 5G.
>>
>> Investigation [1] by Jens on the Windows Dev Kit (WDK2023), the other
>> sc8280xp-based "blackrock" model from Microsoft, found a reference
>> to GPIO 100 in the DSDT in addition to 101. Switching to GPIO 100
>> fixed the issue on blackrock, as it does on arcata to enable
>> external screen when using the left-side top USB-C port.
>>
>> [1] https://lore.kernel.org/all/20250609-blackrock-usb0-mux-v1-1-7903c3b071e4@oldschoolsolutions.biz/
>>
>> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>> Fixes: f6231a2eefd4 ("arm64: dts: qcom: sc8280xp: Add Microsoft Surface Pro 9 5G")
> 
> Fixes should go before your sign-off

Sure, I will change this in v2.

> otherwise
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

Thank you,
Jérôme
