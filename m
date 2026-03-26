Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ED3106F30C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6537F10EA36;
	Thu, 26 Mar 2026 09:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O3O/HCQ6";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BC010EA21
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:40 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-487035181a7so4290795e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515758; x=1775120558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hREPPe0C3+Lmwx2tkDyEQDqCZUnz8ZDMuws56ODjtSM=;
 b=O3O/HCQ69oJF/JA52EtVsjJG1C2tmQwP+eMOdsNp10X93oB3ngY85WI2NXp2V672Yw
 EPObYpVGllxBa59nMtH6QAlJoKmvafLGcnE2tgC/vyGTC5/NeiMmZYAb3DlhunAYgegg
 3FNfaWsB3vyEm8VHiCezilmW42cXEh30YONworaAy1WoXpJLwUru0waDPIOQgCSpr0A/
 4tQ1NT1nw93XPys6iXlBxeQdmbRV5NVQ6eBLW7CykBruKYlnIJuRnwfbJ9JaYJQVVzz1
 NVHuf+AYyr/QTzXxJ9MuNTm3UFt2WdwfCNnk8/cgpWhSwxTCjYoI5iAgfGfm6LwXeYhx
 751w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515758; x=1775120558;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hREPPe0C3+Lmwx2tkDyEQDqCZUnz8ZDMuws56ODjtSM=;
 b=ZdfxIP+ONYYtlEEG1Y2RZGlwxqmhIWs+VsRNWJ+Vg3Zwc0cVMW1rZFkxSTgoZ4KYEg
 XMUmMwCfrBKRxh4sNwFOQKI/atsb/jynbzjwf18rE0KVsraFuz5I7J+UFjUHH4gB05Xk
 P54zhaqedVAbGLQEdkeRJcgtwdEW+nxidbvWg0Cc1UVnCPtkhTJQaPQsXjcyn9l92aEH
 7JLd9Bf5lyGklx7E/BunSHdpQHoGAlT0Cax9MJ/hQ50za1XRkLl+Bkrr/QLc7foiapkQ
 sXw5vfYQOUsMPuAXANhZRJOwS8NVzOXe+uHHgDCwKegr/k9rcEdi4lz8PqtnZLLAeAwd
 EW6g==
X-Gm-Message-State: AOJu0YxfJJbRdJ1+LM026nL6JRYFmpK354Ol4vbCRPDTXLzBiwDou4N5
 Z3nZIeoAAqTsgtByiH7yjE8cWar3e75gnKUoWyPJ6IdYktAIwW6DXQsV3KDzcZNs1Y4=
X-Gm-Gg: ATEYQzwt5ZDvYSQyLrYsfseABDFBcB0LiewXqEPw6fCk6NS0tIRnuPO5GxHY3ViGoiO
 h7p2/tjqphssugUu00oxhhrRwjpueNdG8pYwIwWA3v2+/y//bECPvIydW9jjDYBHUugO0NCZx7I
 oRVAFdB1mqoYFL3DcePGKXJYfEnc9UHC2sc4umXjBCwojTWtaI3R1CJwndPeO1zuPE/Fqno/+p7
 I6r2KkRUM2XKd7RngHMr/pTFfqRHK2oAUdhZr0hJzPi2FgVIR5CmSe9Hc323RGb2kgZXwPkaIrs
 80ptrvi0ZH5R//qIYcqeFFspgcKS5lRiRiB4oq/b0Vf/ZSuWIsXpFSLnR/NbvEW0WGMQnjP3/gk
 bOlcnRn15rGixLMkCqOIW3qIvrmtYgvVeUaFa3LSise/tJXbL5z9pHUuKafpGsqEAH7lPkl6OU4
 4In7OaUziWHwPM6MRY7m5HgSILQTsQzdRwfy/QiG/wVNbD
X-Received: by 2002:a05:600c:630d:b0:485:3586:1e28 with SMTP id
 5b1f17b1804b1-48716034eb4mr98838765e9.18.1774515758363; 
 Thu, 26 Mar 2026 02:02:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Artur Weber <aweber.kernel@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260313-dt-bindings-display-panel-clean-v2-1-d49615218f92@oss.qualcomm.com>
References: <20260313-dt-bindings-display-panel-clean-v2-1-d49615218f92@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: display: panel: Align style of "true"
 properties
Message-Id: <177451575750.103892.1923752988731034667.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 13 Mar 2026 09:20:54 +0100, Krzysztof Kozlowski wrote:
> For code readability, several bindings which list allowed properties
> with ": true" syntax group them in one place, without line breaks
> between each.  Align a few bindings to match this style.  No functional
> impact.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] dt-bindings: display: panel: Align style of "true" properties
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a00e773b4a5ce23dd831044283e134466e3f337a

-- 
Neil

