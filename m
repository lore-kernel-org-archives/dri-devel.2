Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14563C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E18E10E13D;
	Wed,  9 Sep 2026 13:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QYNZO/Av";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E5510F0FE
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:07:44 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-485850cf499so4036783f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788959262; x=1789564062; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sf3kDe6vLMOFTu1A3Jzs1A3L0YjE2Jrq1HnW9/y61N0=;
 b=QYNZO/AvHyCQZHgRgAkPECpW+f0c7IAj2vR3DnyiTPBMe2jTH/c593F1fyceZ/alg8
 GkISrB8kM0WgMDK0FU6xs+tnCMCYhvFJboQn1NF1Wh3FRRBW6DAAqElMHOXp4wskfLSS
 5Nb+0pUH0Ol3hPqyH8wVBVY7ZUMFt44QBasHDQuYUtIZTQCp4vqdvZxHq+mO28XOo/Pf
 f3bmNf1t0ueMWGOdXyO+d3jA++3zTRmqEWpgK9Xizrd599locn06jHL+hqrPKZ7ycjGI
 8fmOWAvN16k9Q/ja/M6JZYv6cKJ/AdIHzW2xQuceZCcp25jmwrHDiBhnGLC0hva2xhkN
 q3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788959262; x=1789564062;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sf3kDe6vLMOFTu1A3Jzs1A3L0YjE2Jrq1HnW9/y61N0=;
 b=PTj8EqsEdStZP3Cd56/BJfefWS0UH2Kt3j4HZP1c9lsdkPv5cDuE8WhNKg8OeZxpJQ
 Mvgy6ApgLe+D0CjsAKcpecK7luiEvGTK2lXR3sWjWI3W6msZHj3qrsl7EnliYzZBiGwP
 bcs26J5h3VMioG5bJbRk/rjvK2jkLVkGrLvFDLKKY9p4fn9/4z7nxud7W2wLAR2IY5tJ
 t7rQGqXvKnkJ5bOW5gL3jRoV1rF4nPqOoSse5mujuuhErOTIOc92hu1ygJ6P5RNkIDWh
 EhmZnQEbXYfGTF5SBv4n+B+rQMXFVxZR9yqfhHr0cvljkk+oNTQNTx84U8th7zOZOm7t
 MzOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+LfvR0JcOJTSVP0XIuV8AVc0f7JoPp/lFO66jjN1OiD+X2jr8i8JYZp7fmdvZa3bU9S4Mtu1Ii60=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kZWkjEADn1/zUnKWNwxPtkn4thc1gIjeldE5yCmmWTT2QGp+kr
 MvbVIOQfyCotgy4ogLlBCatn25q5lgYquvoHTGV2SAypmKoT3yrdAFoenbiRUf4QXzI=
X-Gm-Gg: AYBFou2Xn2Uv21nIiWyDJcRMNC/VH6ElE9KbobRIREgzzxnUzKXsSsT6kcxldG5T3Yx
 joTw4D9gYjPAumPJku/24KoMTT0Nuw60aS38Cl1P3IYieQKBNoYQ72bfKGSK8Bqx59wB3Osf19n
 Po74r3mW7DFdxIF44UoT4RkBDFLECgSsi0k3uAEVrlCYxJRIb23EL5EybTrp9ioIrac9Q9//y7M
 xoYPxez1lvXKHUyEtEZbwXFW46P0HwL5/aVVnyuMvlz2yru4h9eR5iNuctgZSj9ZVEW3xUBfCfK
 tyeM5SS/YA7O4lnQHJDd/AB918N2/hglwMi4JfLa9jxJNKuf7hVw/VALf1s5MBrRRGtRBn1Vh1V
 lgEgRQ5SmQvleT8UXoYAAZCVdSuggnenUjkr62aj6YoyurC3cMFlMy3oo1uxtKLuQuxWu31JcIU
 DQPK6DUh9y7h3BSDUCKQ34lQpxho8XVWI/1IVF1H43EvRAo+krZIFG93zEIqN8DWHZ/cxg49gLp
 bFd/kXrrNJ4cQFaGH8=
X-Received: by 2002:a05:6000:40c9:b0:485:b0a2:6e0e with SMTP id
 ffacd0b85a97d-485b0a26ffcmr3240438f8f.24.1788959262300; 
 Wed, 09 Sep 2026 06:07:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm34031175f8f.11.2026.09.09.06.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:07:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Sep 2026 15:07:37 +0200
Subject: [PATCH v2 1/2] drm/msm/a6xx: Add CX AO Counter registers used for
 a750 GPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-1-091d74958951@linaro.org>
References: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
In-Reply-To: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=F9UtKl4B6t8wbkHKbIW9J3bu7weHA8+ItYSrU6pYN94=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqoVobyq26GnIpkdy6FzKAuEhbx9QR7aKpHnSmPRKH
 ZinVqHaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaqFaGwAKCRB33NvayMhJ0V5nD/
 0eM0YwQTU29l+Cb7wkg9KONqEkXNSerFYyomOk1Ei/FYnvg0Sg25LM96S6UX0iOADZ+xQ5jjEevn3b
 Bn5ZHvWwKTNA2BS0GiLZvkrihtzql2KaKpekViV6IV6cjb9CU+f+AL1q7ho1TuwX1ZvGnB5p4sGfWM
 unzFyHyEoCD4o+xwLkKfB0Y6xsRnwHtg3ulEodDFOTXPy0+fIotoLLo0c2nOXjtuY4Yh5ppI+aV7yX
 NKqge6DZEg6dTyELZXchyy23uqYpVzz1rZ0/POkgTCMCUmFZgsYcgX/nquHJuvrfVtvyWdAEmo9PSl
 qE/tL9CCOqpNrD12B02e5mvVWuz708IBVV5stqr9ERhI/iDMxT5Vw6HNUCAqkreWhTaF/qVcUcn6l6
 fgBLreutoP1mQk7eUgXJxVttd4jSCvp+Q68C610TsV5fUTG8n4ynwmzcjQ+ZdmhbY1GFkD3UqVulii
 1CCqIZbErl64jwcrrgph6bR13NtiEEGRicy75zWFahqxifo3rE2d3bMVY/107zTqfqAljKyklBi0XI
 8JoC9ZON7ESbaQ6DfoRT166ze9U3OOdDsLpJDi7H8Y21cmtLZrRfLnydVJFAl3F/PTbdSw8DjlE+WI
 k/hbukm+4jSYwmJXCuSh7tAR9T2F8xoJ45FsfsAkbNAyvcJY14AODjrNhMrw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
register on A6xx and other A7xx GPUs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index 33404eb18fd0..b3082738c99d 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -141,6 +141,8 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x1f9f0" name="GMU_BOOT_KMD_LM_HANDSHAKE"/>
 	<reg32 offset="0x1f957" name="GMU_LLM_GLM_SLEEP_CTRL"/>
 	<reg32 offset="0x1f958" name="GMU_LLM_GLM_SLEEP_STATUS"/>
+	<reg32 offset="0x1f880" name="GMU_CX_AO_COUNTER_L" variants="A7XX"/>
+	<reg32 offset="0x1f881" name="GMU_CX_AO_COUNTER_H" variants="A7XX"/>
 	<reg32 offset="0x1f888" name="GMU_ALWAYS_ON_COUNTER_L" variants="A6XX-A7XX"/>
 	<reg32 offset="0x1f840" name="GMU_ALWAYS_ON_COUNTER_L" variants="A8XX-"/>
 	<reg32 offset="0x1f889" name="GMU_ALWAYS_ON_COUNTER_H" variants="A6XX-A7XX"/>

-- 
2.34.1

