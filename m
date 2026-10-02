Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03C1CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E72610F80C;
	Fri,  2 Oct 2026 09:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BmwgBFBo";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2984010F80A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:16:28 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a09e2d0f7dso2367915e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932586; x=1791537386; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nr7I0+vQOmc6Ij+iLFlXS1o57hbrTzBsvp6FilJQ4Ns=;
 b=BmwgBFBoqpXShTkfDcQYVm5WTOHG50WEbB3JJKsMQQS7VbU6k8iK0Aonh1qWG8u6bd
 c4qmVcKryCLFmZY/KeokdhDoE6HrhTMytXM1V7CKVLxphZElMjo9r+u9X/kfM21BJ+1I
 mwrBGbmbd6ZdFzzqsWWJPfMQ/N8BIRBSV+uxOrSAhQznmvLUqm06lk8K3sXBldqeIiet
 9PPLVCjS+uLl2L7cQAZaOJSNggdMkHfrYZ3vm+k047P3Jc8mBY4EX5x+gaw+c5jNvI7D
 ofWXPbhEHBM6Fuzl4gDvFQH1SzbBcUaIy0L/ubljo8c6p311j/ZySHcQevmSOqF0Y9/w
 jiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932586; x=1791537386;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nr7I0+vQOmc6Ij+iLFlXS1o57hbrTzBsvp6FilJQ4Ns=;
 b=vMhSS6n8/2G2XlTUr2dPB/2XR5Av5BzauvCwA43/3Zkh3TnQmxUb3bDFuUjl2i36+G
 Xfzd+OsmZCPw/IQ6cBzGGN4DHc6D9yKoj3t4TRvAaXnQyo6m/aU+UxxueLWs9mgBWNM4
 dzDZr0bdByJzfx3a1YwpnU3IO6xMX2C61uUzQK/kvib1OV1Rfs9UxN7JV0+XLu6udq7H
 l4fm7vWoDnoeHFpBwChRT+uXv4kwiBi7RmTxYMq+1CtbGm4KlaUhTd7PTOPELdpkr9O7
 snez0N7C8S8sJdl3kKDHvqCykA2dILna+kKNcqFdYrge9ZJCX3NzfzuBwtcJIgc+0UcX
 EdPw==
X-Forwarded-Encrypted: i=1;
 AKwUvByLALVDDVYMdyPRweqT85JDWzqyt1M/ZXAVaNwILW5fHKkjz4TqeWxyTLAr3XR+1DzzIrvG6oLwrnE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kctfLQU1lp0fy7IGq4GAkUs2Bxr30zADaqjHPW21sEPNTwHcAl
 VQDvGL4X+R0/ayczKFf+gvm4hrS07tQ/DxjAYfhXbt0fEXBmChBnTldu/uv1ED/pIHA=
X-Gm-Gg: AYBFou2dZBuLOdzkj7np5stbj6DciHXQ1J31V3FQ8R39GL1WulqKAjHStZ6eJVdQxGX
 GtWnIrbhnmKW4Lz98TcyvpXN4a8pDavi+gGnkEPhZVicCuV68p3VXOt2q6CQGAKpoVj3Lju1N2N
 Nvylm/dclNW/nYAnOMEWbgpDch74rSJoi5izR+kv+tQzU3NUVDnaVOUoyv37WnXmcEyTu5CetvN
 VactmZFau9Dl46d6tVFHxlpT9MNkAjaqKwJInqIPFTK8trHAYoPgSE2l+BDf51r052aWkRBZTei
 ERLQQVjDidyu6TwzVcNgM/17QYqCuUsOK2S5L4BCtCQRid6LZa3YixFRfZNC0YsLO7tgb6l3Wgm
 ADOc7hlAuTccbqmjlGVA6KR5592Qfr+47Ri1lc/Tj1/hmCu8yAYY6S9sQMGiLbxgzaAm6/Mqjjw
 pBhl1bGNUooWnmV3c0iOIrdqRghGhJzorRw1OSSzNdQ/WZflZ+ENMK5l6hLgRVthozbL7zqLg3Z
 Q/1SAM+RHOsSvipGnKuTb335u357g==
X-Received: by 2002:a05:600c:1908:b0:4a0:1b21:2628 with SMTP id
 5b1f17b1804b1-4a0275681d2mr34221915e9.23.1790932586191; 
 Fri, 02 Oct 2026 02:16:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:16:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Pengyu Luo <mitltlatltl@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 David Heidelberg <david@ixit.cz>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Julian Braha <julianbraha@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Teguh Sobirin <teguh@sobir.in>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260925130125.3897046-1-arnd@kernel.org>
References: <20260925130125.3897046-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/panel: fix novatek-nt36536 dependencies
Message-Id: <179093258520.2282096.8889396128849638818.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:25 +0200
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

On Fri, 25 Sep 2026 15:01:00 +0200, Arnd Bergmann wrote:
> The recently added driver requires access to DSC helper code
> and fails to link without that:
> 
> ld.lld: error: undefined symbol: drm_dsc_pps_payload_pack
> >>> referenced by panel-novatek-nt36536.c:109 (/home/arnd/arm-soc/drivers/gpu/drm/panel/panel-novatek-nt36536.c:109)
> >>>               drivers/gpu/drm/panel/panel-novatek-nt36536.o:(novatek_prepare) in archive vmlinux.a
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: fix novatek-nt36536 dependencies
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f11277810402d0e2f3f8e64618cdb5af2ade8d3f

-- 
Neil

