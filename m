Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B4AC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32EA410F6FE;
	Fri,  3 Jul 2026 08:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q+FLbK4d";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB5210F6F8
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:42:27 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493b7612475so2611125e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783068146; x=1783672946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DffKEV6vQ8mAoyXkZSJ6mKbXeNlTvFhkZAKtA4bEZ4s=;
 b=Q+FLbK4dGsyGxyciVPsQJADluznT70sYKeNa9b1MfpIcyJtGhYuuMrmst7ED6N8WOP
 OPHmV6M2+aSjMLrFjiAVGjQALPITy5zpgUoAY4DNUWTtMWZFE++HYTOIex4vz658NBL3
 p8Y+LXHnCsiK647fwcSGjBojieU3tPfqKr6k0XD/UyaY06y8427dk+Dtx8+bkayBUAtj
 n9dboeSTQsppoc0YEmzf8JNP1yyDGv+1RY+IXnDJKQOGuiYrB24EPlr6lROzIdShx4Ds
 syvsRQPDJuGLtRW581K4jOSr6uOr28+AcF5dk2LnHpYTsvkBigMgYD4U4QsKScvKgViK
 4k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068146; x=1783672946;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DffKEV6vQ8mAoyXkZSJ6mKbXeNlTvFhkZAKtA4bEZ4s=;
 b=oYYisE8Vk8baXo0JQVU259k2AzV5pLHCLvtezSTyDJO5HJ2P13b5mom7xzt/QKyFBV
 KeN5BfjyOOUEjNaMYU0YTm/7YfsNph+VKvMawLnJbRzSRyq+9lbu9wl5yh8LNj9dds0l
 nKrDXWfF14yNslmftT3WxoO/xjzB3pPUDI+UaMWYJahV46RuJLSxSRJr6HAC4yGdUC54
 X7O/Qt2vqhewfn/SgpwR71mExXoImf1OTnD7YqknKwH1imFVhD5m8yAvYq3g1j2RqB22
 Q3DatFt0fX9V3VU1Xj2XXXk2stSEYo9YzQAMendtqZPlS+vJAhpMnSmB3Po1AOwr2tw0
 MRxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/22zu/WLE1NoiBHyJcDe3WhxA5Vf8nXXiXKeLyaMvdoL7IW8T5a+DS1SiorNHoR+9eqstPZ3Ocuz8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymzkCljGOYrxigH+PdHP31sLlP/dsVzvX7mblFUdgn1HUZYAR/
 6spSDfhkCjgk17VEo60LzfeoNz8+b65Ke30C9D1+fc7CnSSOWD/aLz84oB9+DJ/aJD4=
X-Gm-Gg: AfdE7ckup98VLlXEXXYDEr11PJeRECjq1O5lZGOo+mAMz1mxm59lUhWMD8DZI2Zq7Z/
 KrLU8Hj3qM6i/R/XQuJ0rbMiqMTvgh3hQwOdPJH7cBRKqmfMWt1bMIIz/Z9a83vrYh0WslMi1e8
 nBOAbae5REHdUeNhLeZNHUzrQr4SKpvcZ0QyUSmKsZeVc5V8wS0u/tGk4zYwacfmk9JtQA75yEW
 qwPVmkYqsgC+R7noyXbvCBR15kuQfTLYWNIoEWyr+55ZCN2SNKgt0/uT8gYsqsSsr/AhP8FdJ5V
 z+yPUJPLwrLbBAGApikH2N0Pvj9gxxhOe1sjYGYdvGbsHOpMnsCjirCvDXg79NYi62yB1G5OOjs
 94luBmQkuJ1cX5EaygDAwndgIV8yfh8JB+2TU22/SlTmLRssagSycew2IXNhWyWiensAi0Zvip9
 I12ADzEZ+bhmIORJY+coJ5kUYjoxDqfKQjVg==
X-Received: by 2002:a05:600c:3b05:b0:493:bd67:316 with SMTP id
 5b1f17b1804b1-493c2b584bfmr118405935e9.16.1783068145730; 
 Fri, 03 Jul 2026 01:42:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm30001575e9.4.2026.07.03.01.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:42:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jun Nie <jun.nie@linaro.org>
In-Reply-To: <20260703-topic-sm8x50-vtdr6130-dsc-v4-0-9eff51ec717a@linaro.org>
References: <20260703-topic-sm8x50-vtdr6130-dsc-v4-0-9eff51ec717a@linaro.org>
Subject: Re: [PATCH v4 0/2] drm/panel: couple of visionox vtdr6140 driver
 enhancements
Message-Id: <178306814480.3165305.11420224362782009879.b4-ty@b4>
Date: Fri, 03 Jul 2026 10:42:24 +0200
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

On Fri, 03 Jul 2026 10:10:18 +0200, Neil Armstrong wrote:
> Enable DSC and switch to devm_calls in probe.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dd336686fa2c3cbe1b017fb1c653cc5fec79215a
[2/2] drm/panel: visionox-vtdr6130: switch to devm panel calls and drop remove
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/903f8773ee96c5dc5fb9aec65227f39fd3e7a1dc

-- 
Neil

