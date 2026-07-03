Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D603C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEBC10E5B0;
	Fri,  3 Jul 2026 08:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WHm0rKWL";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3021A10E5B0
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:42:21 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493ba701891so2109225e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783068139; x=1783672939; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXc3pK0ovFKB9bMMvTE9IPUZKu6aZsXVUk3VK3ezvc8=;
 b=WHm0rKWLGv2Zrogk2ldp0JyELRM9W3phDZEQt0AX38vrswMgGIDvoO9fOW3atPmHRh
 pWv68eDQ9BM3jw7dWIIar/kwdw7L6oMt0/6ujO8yoy1Fw/bi9CsEWnU6X+GQbTgFSWTK
 POJ03tCTe2dgkb/PCh5KnMMu7welbnwFybjXPB8xFnc8FKLNYcsFpGsySS4ZoXtIjDSs
 EMzlqzBXuiQHDEhy2Xc5KkbJJeQFgYVUuSNxfbETDmBDFycj0DmsoPVQJvG0SwQTqbYx
 /9Ly5osnT3WbnOpXI3TElnlyObYEzliFl4Qnb3FiBDHo9GJDjN1FIH1bOuWcOzoUCVC5
 J6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068139; x=1783672939;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RXc3pK0ovFKB9bMMvTE9IPUZKu6aZsXVUk3VK3ezvc8=;
 b=Y3zaHa7cA47LVwSGIicwiN0vZ14DziqK14Txz9j6CXfxNGDlpoebyjgiHkz6+A40DE
 lQJxWlUWuTCq6wtXcPxS1eWZp3cCVjLXsqthMwll8J386Vioom2t5uvirO4Rzb5FUjjL
 XeIxHd3QFqHznOsajwlQ9Bg85ovpRX9wceqy+c51ZWt6kmzDWg3ef8/unNvYmXwpihsi
 8/B7JSbMQu0RL750C6XNnW/8Um7Ci/QGxIvJlJ0KKFDDIx39LeQLRlYfLtKYTMUMrsDl
 jW1RNtuxE3byKvOz7ARx9ZIoh7CNgckV9H/FwtvtXUkTM3OKxGwroYxWqbTAmaiorC2U
 A4Bg==
X-Gm-Message-State: AOJu0YxGalwy6xgwE7zE1JeM++3uJk5KqYrMgg4sgN5crJi4zCnkjAOP
 Sv0He8VB7Q3Ihg0M3K3vhrQmCmF0xaEJ0xgTDDbQ86BJwNeYnSmipq98ipbsP0RM4l5e0ZFDDZB
 RrvTR
X-Gm-Gg: AfdE7cnZmYHltI9zlaWPYxinuTUyBG4sMOHrE1sGrHG3o9CtTUgHNc4EkfZ/m4Ln7Nz
 YeQUP4VCirx856KCmpUN27pF/auCo26uI4ZtzNTzpBVsO2KoBG7vi3pKUiuwlacdBm9W0ospi9F
 Q1BOPr/wRRu+Z2GRnTB3raUSh3Mun8IBuM985hotc3ibqsLzzuVrEbkdhLipUsZir8ZcUpGsM8r
 zqlZlpxla1sNY6CmkETzPXJVxi8xI+ne7wZN7f8j7fFcQUc2v26NHLhY8X2vGGQsdcG+APXWwUg
 tCMy1zPHuF6BlY+vmsBIRJIJnPATlmCQ1fGkMs3+peb4tGOGo2FuAAAvDnLyeT1yReZj2Mkfb3m
 dElCe142R4uRqSvwpxMzDrJuXBzx36XmacbAr0iHtgIySAdrPvKZ/jSG+uz+UGRMD+cHqxPIEbz
 ZwvdU+Z2CeLJ5685epv90DMmIT3/rFqEvEtg==
X-Received: by 2002:a05:600c:35d2:b0:493:c3f9:65a2 with SMTP id
 5b1f17b1804b1-493c3f9664bmr142706275e9.5.1783068139403; 
 Fri, 03 Jul 2026 01:42:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm30001575e9.4.2026.07.03.01.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:42:18 -0700 (PDT)
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
In-Reply-To: <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-0-9f61cf24aebf@linaro.org>
References: <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-0-9f61cf24aebf@linaro.org>
Subject: Re: [PATCH v3 0/2] drm: panel: support the R63419 based dual-DSI
 video mode Display Panels
Message-Id: <178306813821.3165305.8418071797826961279.b4-ty@b4>
Date: Fri, 03 Jul 2026 10:42:18 +0200
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

On Mon, 04 May 2026 10:02:04 +0200, Neil Armstrong wrote:
> Add support for the Renesas 63419 based dual-DSI video mode
> Display Panels found in the Ayaneo gaming handled devices.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9c04ecc893f07d001e484e6c420af19a970f755c
[2/2] drm: panel: add support for the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1190fc8d7b8a9cebea8dcbd2e544e43990ae81d0

-- 
Neil

