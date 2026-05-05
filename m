Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ACCCD342F
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553B810EA33;
	Tue,  5 May 2026 10:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hOY6QZ3u";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4785E10EA38
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:05:13 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso26220475e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777975512; x=1778580312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5OO0966EsEvo3fVE74M/tu/i8lqlenm6UmjL55zrQY=;
 b=hOY6QZ3unOl0rJMHq4E5DZ4csO2ASaEAJbY4XTlWT+8j6y7zHFTfd5+yDWDkvf3kBj
 D2uR9yaopmmfrPhGXHA/1YNssIO82MiybwvnGYc0h2pIQPYKuV2TFHP//Kqc3c43nwuh
 TE+ZaqneraHz8JQDwsRd0pOkU2SVPyQp+w5HTP5L1EHJHFcYCBPP4ifNMdPlsGs6aduN
 JbHfPqRB6oukwfcgbxx1Gyj2gvUGmtkzRUuaOmitZ/IWy4qkuWhlpnGccWnA9nHtj9QQ
 DU6Z7z3BbY+kCyGnvIYJMdlkd5yrlonrX39VE+TqepMomlsX+pGicsbi+kjFtmqsbPtD
 RQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975512; x=1778580312;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5OO0966EsEvo3fVE74M/tu/i8lqlenm6UmjL55zrQY=;
 b=fEtghiaOfhecP2QbBg3hdCyxbLH9wQNlct3HxboncwHPMJadNG7rVFTBqO94ibd5+U
 FmMDoG3V4wwCoRNeQsR3NEG+Jetu52bT58zddy2SEOFaMMLMfgEt0uTvelGrtQuDTscu
 0rybeSY5AKns49/J8eHGOu6piz5UD4VVbg2Q9VPcHC/8REevADQcCQEBZrKmaxp3pNiO
 ieTturRkBE6iuF7y7HJeJa84ZVoJy0imvzm1L9SYejsZBQfflxjaqylx8hY427DzQS89
 ay+MFU+WOTufIGRCsMwqzv6x86zEqovzffh6ZXHHnbJv2cCDsEr/qTnJHPh43CECNJAx
 98cg==
X-Gm-Message-State: AOJu0Yw5o3W8qhlLQ+tt+7Z9RyigcLynMrz3vPkjKh2yDCE867xFQ2uC
 YG8n6yTWOMYPxQ9xWQ9gJwvMN/D/LSE0AfCawNTwVnZuFWfydcXm3kAbwyPfshM8sSY=
X-Gm-Gg: AeBDieuyZiOZDdgj+q/NHf2OwRC54Zbfm0JQG0ITWh/a4X1vfvdEVfiM2UqQBLFXlOC
 xB4V8bMlU8GXRQ9v4wKLSV6jPaqAggLwJIprjHLfc6RtGMy/o6Bhzwaaj61NcrtezJdQPMmSi/0
 MzmRGFVyeXzOiU/3ILMqYP0TSe9mfYHgBouev4VKJxb5J5AWHZ8aD9zqK+iuz4n6TSAbKYWdXgp
 La8j7RJYv4gQ4o999fhLaMOob3QaQKu2qp/+GomiAiR5pwCUs1Q3MXavzgS7jp3gbdGVzY9vUoP
 ZpCKabnJjVGSh6JSyxAsVs3mVDTttqknPVo42q3uQafAfydIl9UyuPjcVxOJnkDWrgGgrHAUiWc
 ryEEkNcTmg1tv93S16rPUAeoYlLWIilmAP00O1tlfoY0qPK3xEbaK8zg9CLV6VdL98wvRJxr0U7
 QTd/U2dtsQT0mrray5R4RW5JmId0lFdIQZ/Eny/tzk62ZiS9Kq7q7bp+Q=
X-Received: by 2002:a05:600c:5290:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-48a988c0fd9mr243284795e9.24.1777975511458; 
 Tue, 05 May 2026 03:05:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c8556sm381856295e9.4.2026.05.05.03.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:05:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331-rimob-new-features-v5-0-5fcf42a29c12@protonmail.com>
References: <20260331-rimob-new-features-v5-0-5fcf42a29c12@protonmail.com>
Subject: Re: (subset) [PATCH v5 0/6] Enable new features for flipkart-rimob
Message-Id: <177797550956.290023.16418895983264394741.b4-ty@b4>
Date: Tue, 05 May 2026 12:05:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Tue, 31 Mar 2026 11:47:08 +0200, Cristian Cozzolino wrote:
> This series enables a set of miscellaneous features for Billion Capture+
> (a handset using the MSM8953 SoC released in 2017):
> - Panel and GPU
> - Touchscreen
> - WiFi + Bluetooth
> - Hall sensor
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/6] dt-bindings: display: panel: Add Novatek NT35532 LCD DSI
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4b494c72555f6249331b16add879c40e920d3f1e
[2/6] drm/panel: Add driver for Novatek NT35532
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7a0dd1b5c55f73b962dfa807e726f7214def6065

-- 
Neil

