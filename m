Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272D9C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD5A10E923;
	Mon, 20 Jul 2026 13:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VA8BKzG3";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97DA310E19A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:09:51 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so70834215e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784552990; x=1785157790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iQHFbRe4vzGzrlDp1GieQYkAkV6Y+udMHh7RxbcHehI=;
 b=VA8BKzG38fNdpuMR3hFv4WhT6lbPxLP6TBttCsNGbg6ycQCeDQXK1jjTg9SGzU0viI
 I5JW0yVbf+b/quV9jsId0/ToqEbu1w/vReleZKHK75AtsEfmMEnuLMgpvIyPx+4V2RiC
 FqVADa7T+nivP+ImaOXpYeLTYYpGjiELzCiFqi7s2huokm7Fm+JoBo0FRp3MU/HnLUE1
 47qdqYAsuSOhaoKGYBZQL9QwlpuQZDtfk9ofD9jIg9AkfmTMQU6tYD/cEbv3vzjX9r9i
 dUOGpviGWzgRrgxt4vm/wT6hRI4qYgfJ5xBoPvBCGBPQvrdBD6tZgRTwuz2N2eeibew1
 LzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784552990; x=1785157790;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iQHFbRe4vzGzrlDp1GieQYkAkV6Y+udMHh7RxbcHehI=;
 b=PSw6GNaow0+vxSy67NTcOB5PQg38kF7cgQlAF6BphvL2SOMiHcUYvrDBTabNVy2kMU
 Diby+LcmvuJpUh0f10eZNeP2erw0/HZ+FlI66dlNweMnSHQagH70H96dH1U4DUC62S8h
 EYTyFbXz677sXv73wJJztfMRNVnZqJ/XSVkVh0AmkcSKc9x7q4zKt5wpZ5C5Ax+94vfe
 CDdMhOf4j7z5Kk69LbbajtdT96VpiKuMCfk3HBhwHU7lqvozHCbl086aKIUTlq78jE28
 3Iq09wjltIw9sNatwm78s9OccTbgoYVA6cKBOPj2uZp0odjRp3APycVJ/il/XSCqq/CF
 AY6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaTbACBqJrkRuvPOsRR/Ah2UQwWZSRt1DTJMJAPD05x9N8Bw8Q6lbXVrf7qYCJmuY7Yhuezg7X1iA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZOzFJvvXFwE63ZbnGwDMYGErJN1qBoEjKdoHBJl2SHW6amrLT
 lAR3yuDhvmEdYjUlkNfYT/Wrer2XTq5PAGFumoyph53nBRP67k59v5IUs0akb0EGe4k=
X-Gm-Gg: AfdE7clYK5icpBlF0GCniQNO+f0l3tnw2ymxiR/NmziIeU1TZG2sku/Z74METd0nm5A
 6pw8K4EBSg5P0dEiYRmCr0Y01Amcp1WOSqS2tPqAnqfuqhlLISrwdFmKheuCYJCh5Y561aDl1a+
 KJ86lr8g3sSALV5FjZPt5Ya7QxnLgVTVHzM/YaUYGkO+VfIexq0tpyqGzRTPB3RH4kqZHNirYNj
 G9GwBIhLZz7C6y4T2BbZ1+fP6UWruSPtYeC0N390JZ65HtK2TFFA5V1DLK76sonRO1mCtLGrn3u
 L07pnBu2WYtVTnPdKXmbEUvG44VqRdBPUg/B7jPM80uYHVzV1nDbsJA2mXQmog/rJqiZAUUsk47
 hebiWvp65XjSuYWPTVl3Vw2EWn64Cf4oSs6nC4iPSc9InodZkgre66vOjPDw3YShKOYvGEtVG/5
 Y7zWXdeEKIyzs5chFFZtZCpXY=
X-Received: by 2002:a05:600c:c178:b0:493:e46e:157d with SMTP id
 5b1f17b1804b1-4954a40481dmr125744815e9.19.1784552989874; 
 Mon, 20 Jul 2026 06:09:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm30767434f8f.24.2026.07.20.06.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:09:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drm/panel: Add Novatek NT36536 panel driver
Date: Mon, 20 Jul 2026 15:09:40 +0200
Message-Id: <178455228139.789946.10539410573007438922.b4-ty@b4>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709142846.12463-1-mitltlatltl@gmail.com>
References: <20260709142846.12463-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Hi,

On Thu, 09 Jul 2026 22:28:44 +0800, Pengyu Luo wrote:
> Add a driver for panels using the Novatek NT36536 Display Driver IC,
> including support for the CSOT PP8807HB1-1, a dual-link 10-bit panel
> found in LENOVO Legion Y700 Gen4.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Novatek NT36536
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/bebb0bac0b0fd0ca39c640462a6334b07bd093b5
[2/2] drm/panel: Add Novatek NT36536 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0355a14085b93260a2211d7da9a79ddb2fd85556

-- 
Neil
