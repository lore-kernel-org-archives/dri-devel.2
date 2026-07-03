Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075D7C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5442B10F6F1;
	Fri,  3 Jul 2026 08:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YPD863De";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F16D10F6F1
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:42:22 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493c2b3dc8bso1874415e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783068141; x=1783672941; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUXYNloFl5fvS4Rg2TDnJjQxrpMnsYaeEPEFyyaGAnY=;
 b=YPD863De3Xfy7hRPhTgJW8nTAmdx1MFmLS2cUVpg3Yd1TCt0oJAnjTnK1YAHekuDvF
 DP7oZg3Oo07NTV2d/nwOkT69uQuD/OyGXLNAvFhbWnaOuD05EyurJ7ZECuzemc6xDUsV
 qtu0KISmuK7s0vNDeL+OZ494T9FxY0PjlFCB+iCc+pmxEonLwPq7mvwQ+HYW0mzvLgSl
 nXqzJydnOcgxgCc+bDCwK86IBhSLqSM/B5iidXYc7cokEHy6fMshoFJDrVAYNd/6qgBz
 rj9KG/9nz/G1dz7nSRv5torq9NMhhuESOA2gepGzrkLUwJKz5M+R/CrRg5i3gu1OTpso
 /VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068141; x=1783672941;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RUXYNloFl5fvS4Rg2TDnJjQxrpMnsYaeEPEFyyaGAnY=;
 b=nKxLsCyLVBVZMCeN59Jr+gDLeVUb9ZlyZME70L3CavsdwzytuGvTzpOI4OSAXvBxpu
 R0CYAiKCVo1K9e5HBrY/h1K3iwFlHrEHkBsvQNDVjrtyKgjG4gGNdiVn55RRgzOtcD5m
 TYDfxV7x66bBFx/bLc6zb4uYBg9/rAAl7jh99Pl8efcJGW19WClcke1XYSBEdptUPyoP
 5FqY5biHkIoSW6zeM6OYOUOs4DUGlhG6k33J2XI4kLHXjzZhhSpEycWtblTdY+zJIrpi
 SB/x8uET0BBClodIK5VCLAt+KJBnu9zzFnNJqh3DmjRt2dUP4acIt2UgZzKS7mU9vyAT
 G6mA==
X-Gm-Message-State: AOJu0YxoFDIY/Rpp7hSTE+KFJJLAYRay3NlOJlOAK3VaJMcB/JdJWVNs
 NKHXtDQk6n9IvnFlptACcM26UWfhTFx4iujlwMZmEfgG6y99ybPFv7EWZCZMKiKZLLU=
X-Gm-Gg: AfdE7clEBPkjcM4YrjpJjXTx79qepkz1viFcLWlSBSlxMolHZ+LVBa9Db291SGdvbwe
 8uhsrurHg5pdlPk67glcVVJJ1iHXHo5QDQO1lCbs8sWv5jw6YIpeNYsiRf/tM3Avep7HlRnjJT5
 4mcO41ZC3ERoDTbnPENIMFhvnvidIt2nNr/p8pkBhld4YIC6KSodiwqpBpb4LPWvNFcsw97Me5h
 5pOVxED+f6aKFj0NXM0kEnKEZgr+T7uNlVfmdRtHv3Qx3JdChHu0HY/tp8bwfmn3j5vbH92WDNs
 C7MnwzKSkfvariehbIIGVL7xeaKj49Cr4ETW+dGA8mRCV7eZylhRAr8hhWIdPDZBphsNMEcCFgp
 8bQbdZRSI6XuxKioKnbuGzhGUb0BlzlrE9a5aaO/OcVlOqbjL+Y+fjEB9PsC5Ss9ncLYCepzjV3
 4qEJVa8TGhONWhrMMhyZaa3iywE8bnZWqptQ==
X-Received: by 2002:a05:600d:c:b0:493:8391:919a with SMTP id
 5b1f17b1804b1-493c2b433dbmr119940725e9.16.1783068140862; 
 Fri, 03 Jul 2026 01:42:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm30001575e9.4.2026.07.03.01.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:42:20 -0700 (PDT)
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 KancyJoe <kancy2333@outlook.com>
In-Reply-To: <20260519-topic-sm8650-ayaneo-pocket-s2-r63419-v4-0-b8929af5e951@linaro.org>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-r63419-v4-0-b8929af5e951@linaro.org>
Subject: Re: [PATCH v4 0/2] drm: panel: support the R63419 based dual-DSI
 video mode Display Panels
Message-Id: <178306813951.3165305.5039889497151829172.b4-ty@b4>
Date: Fri, 03 Jul 2026 10:42:19 +0200
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

On Tue, 19 May 2026 10:09:02 +0200, Neil Armstrong wrote:
> Add support for the Renesas 63419 based dual-DSI video mode
> Display Panels found in the Ayaneo gaming handled devices.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9c04ecc893f07d001e484e6c420af19a970f755c
[2/2] drm: panel: add support for the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1190fc8d7b8a9cebea8dcbd2e544e43990ae81d0

-- 
Neil

