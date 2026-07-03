Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F53C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED7110F6F0;
	Fri,  3 Jul 2026 08:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G/BQmS/O";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3DA10E5B0
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:42:19 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47488efcf30so193616f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783068138; x=1783672938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzE4az3Z2WN02We+LgBV5AAaD12sTfY4548Cc+lL6Cg=;
 b=G/BQmS/OK7rEoah8/xkreMmbDocN1DZS0Ulmke1Zvp6Smisg91M8UG4nSCV380rg8v
 N279wFdPEg1QfuJKo/4EaiOYPIQOVI5PL4ma3KwQ9EjvQ5FU/vH9Z2hZ8UQHSgyt8xYi
 0o7BQbFs6wFkQ+7Hoav+XFP0ynKguB6xYTVcU/Lx7KZO+f8bnVZgioyBewl752qctjo1
 etHX0RAfAFeT4u8llb74rY0gnTIk4FLovYbZOaCyuR+2yolnlrAn+TEDMDHJu49MRpEL
 SuaVtGGYj7cTGpTPB1Z9Wx/ZPdsJ6g7LJkux4oueqzb0WPh6NHRQIBc0jnumAllzVB/D
 aV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068138; x=1783672938;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qzE4az3Z2WN02We+LgBV5AAaD12sTfY4548Cc+lL6Cg=;
 b=oVbG5hhunm0jYvCnDVfmJf3sddUoDSU91mqRf/UL2jIddaFfecvseDPrF6VJD0hULT
 d1TGwUq1sxpRQVGEg/4pA3CrteocLDI7m5n18utu9hAAR6kST4CocKeRctGvShSoC6NP
 HtZyl70BmeW58SuOQn9u1yGKD8+FRg8vrzCkjAUEA26951zWM9U6yxZm9+VICAA1pHcv
 Mb88ZjMMYd1FqTeb726cZzWP5bVl4PdORN9295sr4FJPQTsuQufYgCraeVFoMITVrD0s
 0Kdy+SY/OHYpVNIRAdlsSoy8t5sq3ZT2Itz0Lg2lKFifzWgGmdAcDesXXst53ZVtrELK
 LB2Q==
X-Gm-Message-State: AOJu0Yw2CcV4xoFcTremQfFMjM+4lNuWvYyFT8jKPLFLohoJn7LV6Wum
 7mEfc5wp4HaaCOom0nFGKY3z+zITYUnpagKK/ZxcwaaesaIpaSRL5WLpOS4KYZyyso1PXB2HI54
 091Mr
X-Gm-Gg: AfdE7cndgrFSpq1RcE3lhRbNjjqCVOG0h/JHyhL8jRf/+l6JYFwjWK/7ndEuYKZMJ7s
 wfnSeDG24BLMOtrwyTlWs3gAkQDtLssYvMv8MT2+wvQLVF0ZdzmIP/5eopV+qKY7h57Mxfr/FAH
 7KaFhHEyX67jAKr2I4gQ9aeGfFIKkqMth66PpnMEwTRWDsV8O/GVIB+EhtzICKxDICu1/sC/mHn
 57VsiaCPWjdJuxhgAgpImKHSa29CWEas/ZTPcmq33bdgKToi0MBpQNHpJhfEdD025+aBiVJY9rL
 k9ne+ILvcWdX2CThY+2IV2ted0T6lAGvnHp0R2cYr7+E+IMuEWwYqE1AF9MtokCjrUcDdNzYlgv
 NYu07sldmSJepleROyr8NFFtJaGhM45k7yDX+8w2Eww14KeId4Ci5QIDaobZWbJFcX6bSf/h2vP
 lJVWaq9/X4N2eDK2AEvsazRFALjYlHOiaUTDbD6NrZKECB
X-Received: by 2002:a05:600c:574b:b0:493:bc4a:9547 with SMTP id
 5b1f17b1804b1-493c2ba70e2mr88243805e9.39.1783068138062; 
 Fri, 03 Jul 2026 01:42:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm30001575e9.4.2026.07.03.01.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:42:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 KancyJoe <kancy2333@outlook.com>
In-Reply-To: <20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-0-91ac10453d0c@linaro.org>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-0-91ac10453d0c@linaro.org>
Subject: Re: [PATCH v2 0/2] drm: panel: support the R63419 based dual-DSI
 video mode Display Panels
Message-Id: <178306813662.3165305.810596884490699694.b4-ty@b4>
Date: Fri, 03 Jul 2026 10:42:16 +0200
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

On Thu, 30 Apr 2026 14:22:16 +0200, Neil Armstrong wrote:
> Add support for the Renesas 63419 based dual-DSI video mode
> Display Panels found in the Ayaneo gaming handled devices.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: regulator: document the Renesas R63419 based dual-DSI video mode Display Panels
      (no commit info)
[2/2] drm: panel: add support for the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1190fc8d7b8a9cebea8dcbd2e544e43990ae81d0

-- 
Neil

