Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30275106F30A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A15710EA1B;
	Thu, 26 Mar 2026 09:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V89d+Edi";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E4F10E973
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:38 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so471966f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515755; x=1775120555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/Ix3s+Tgcoiyysg+QDxh6RK5P6qQb9s+C3grnl5iwo=;
 b=V89d+EdiJA2/6QWateE6JvGyA98IQXDR4uQNly5suUL7PBkGDbsru/ldh7amsDcSHV
 xONP+glUM72cmBbhh/TxGB1Zwgr45SQMcnzHKb+awMHPZu6WlwsZ88Y9vDDKlFEd2Mod
 xN46EGUdc+MmmZhZslqEbikaFq7p9wywSLWmWwUdr26Mg1qDFdgG3Sf1s+2+USkQAcdW
 oK+Q8Kmgubknn15fpOvl612pApW4r2zqW0oUQByPlju7KMzacRi1OpysWYa8jCrTIDpj
 lgTTONk27+3Y4tpjvMIncR3QDwKLhuLSCg6NeETs7QAariiT6qZN1RF3/Tsgfa6EhWZo
 tthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515755; x=1775120555;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T/Ix3s+Tgcoiyysg+QDxh6RK5P6qQb9s+C3grnl5iwo=;
 b=JkqDNa68MEcqxQa55YgoWQP6MLRaDloLj0Fm4WJwxLR1AJLiD6VwLKK2goFRrGDDRz
 47H6hv/a+ShZBAh8LEaw4H09dlVpcG0cjKhz59ZSrA23ihqM7rwg2zp1hYnmf7FL3XhG
 Hv1UPbepF2N0XJOOZpmF5l1vqyaHoNOlkKMfQ7NXO03WRmqw6QiWw0Dl3XGeKWvDg9ax
 BtZ2q5zEswoGDqlxuv7ch2I9KdIFM4ZQ2GD8DVMOyrqg+TQNUb3nZ8I2kiwwVerisy1Q
 lQgc+SLsrGgnezBP2eoDaMHXQCgs5wK8m8z46md3aCKuRAeXpwC7CFMeK3Jy4HYamGbw
 l5Sw==
X-Gm-Message-State: AOJu0Yy98Yke5+ZLj/5QT+/UgoFfAgcJ7NdloQjHZvUZYFBP0g9gMMUm
 3baBNCNu0lE9ZNaVjAmF2VFZSpWirMfJBSaQYqiHwjrFukqHlxnT7h7bhGGeVGA7rmU=
X-Gm-Gg: ATEYQzwVAr9O8D76kLaTs3d8IhcJfrRpdZKJOiuEI9iup2AXyMwQpoMpQa4xuWcbk0u
 OG/3fuHS+g9v8P92Dw9V7VXzpSgKBxrtvCTOZpegBJFPqo/Y5TOK3tKpLIBHQcoPER9rISctg6c
 QUbTJonfRGTMkNioY1kk3Rh2Tbjspo8mRdBV820qnsXR7/pjzz2y+Ho56kqx0YXgoeqyy0fXHy9
 sR0aEGGK9c1fXbFKnDdLriflii71SLJC8aPYyVuRGsNeykpJV4RZCb6spNaq6crahrrhxN7knKA
 0qcSF2K7TOXgtfVrnZWhgypTljJRTOv3IeuXPRRf2ql9Gqjk9uzM90rIehptuQVf8Y7hlwfsodB
 kTwjzD1AfZ6Pa70m+RJqHFNBmVaauAQd4GXioE6Ru1rplQuqKolVblNThZmflXwrTL0dmvqCinj
 IGjAb1ifUSPpRqwynX/2PLYW0mHfEr+mxmD56goJ93Fwiz
X-Received: by 2002:a05:6000:18a5:b0:43b:5095:d101 with SMTP id
 ffacd0b85a97d-43b889f58d5mr10149259f8f.27.1774515754445; 
 Thu, 26 Mar 2026 02:02:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260325-v7-0-topic-imx8mp-skov-dts-jutouch-7inch-v1-0-10255d236439@pengutronix.de>
References: <20260325-v7-0-topic-imx8mp-skov-dts-jutouch-7inch-v1-0-10255d236439@pengutronix.de>
Subject: Re: (subset) [PATCH 0/4] arm64: dts: imx8mp-skov: add new 7" variant
Message-Id: <177451575363.103892.5315410631400617574.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:33 +0100
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

On Wed, 25 Mar 2026 12:31:58 +0100, Steffen Trumtrar wrote:
> Add a new board variant for the Skov i.MX8MP based family of boards.
> 
> This variant uses a different 7" panel than the existing ones.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: display: simple: Add JuTouch JT070TM041 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/87535f27061f3443e813a64f59fb1b0fcb916e08
[2/4] drm/panel: simple: add JuTouch JT070TM041
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7a5b966952c0232d7083a496261880fc11cc8c4a

-- 
Neil

