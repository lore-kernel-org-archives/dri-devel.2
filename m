Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB4BCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98AE510E643;
	Tue, 26 May 2026 14:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZeeYAURH";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678B510E511
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:41 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4903974854dso44996615e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779807220; x=1780412020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnpiXknNkhLeE/syhQsNaKy4MnCjaQkTR7qdsr3AATE=;
 b=ZeeYAURHWzD11uBVHKXTMk1At+6otpnb045K+vGEvHC+jnsmhXSToP1ZxF7tRSUDyR
 ZqBlo/Ue16z0fWf98I6Em4heDBowm3ju7UvERraZDw9sy4dVPlQZM9UaksI2xIfDa8m3
 NFf9Jux95Ke1vtnXlhHYnbA3cQN8tinw+mBdTNyDO2RmuOAAadrA2VSyNnxvAqFDw2uG
 VApCGXcJYYu321GT9mHDIVYd0Cwtf47EdI0BLZo+BDqwlTVwfIZ1wCk/J3ddZoVsgnnn
 vCRJ2MVE98yoel6SUtQf1yXC1k6T82+2rgwRrWvCAKtTOvz0Yd6aF4JS/KPn7Q0FCRey
 dt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807220; x=1780412020;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CnpiXknNkhLeE/syhQsNaKy4MnCjaQkTR7qdsr3AATE=;
 b=bYwtKosVj1K0bXakAqmBXBHACObO7tDXWPMLu0iEcA5qHAMSPqJfA0z5nbsDI4B7mo
 6MUSSMPllMQeqQVmYbFPSI78Q0KYImNEejnmQ+EQmpM9IGLMH+5uBYPclw5mBsA7YNJf
 iGcq8Sw3jA6w1U0ohgwIvo22Fy4npVl2yDPv+Y8CtOjafyXbhU6ZKM2y5Eu94AfZnvq7
 qxApqteKsMHYvcX6HHFhSFnQTwCHcyGPUYAd+NJow5T6gOPtWJghqkZIjAR1+q5gzA/K
 nBdoRwWUYi86HPMZ41x+vd75HBlyd3rSPUvOs60AChn/g19MVvJM/lgS8WWWkOUn8cS2
 0Idw==
X-Gm-Message-State: AOJu0YyqC+8bUFkOGWNaj0kYOnSPdoKTVL30Ccm8LuzMCTy38eMMCWwF
 Ae6a1ERFbeNVYkTKXfmhNDNcjfPxU95McKUyJHGFpPa7/vFwptKwJQbsy4MuS0bCLo8=
X-Gm-Gg: Acq92OFlcAXRX1YjzQfg7ZpXNscdEw6nl/C1viefj0XZj2M9//bNGmuLrrsp+6Q+0Wy
 CIWY1K9ZOL+Azb1+feHI7Kl2GvJGL5J5Y9JD28Q1geW3ZenEvuQ6WxBzscdKqBo+zz7CAj1whcn
 fWwcQ//ssrmeXzlfCIQFHNpGyDJDht1+o7bMaXjfHhEPU/HnUfjH19h7pMtDECLAXflEOnOjNii
 sqyWBVDjUhaTMiI/jfIc0GTHa1LdCqFSVznNmOhH4Stv5RHwdsfKR6U81/0dyEwcmNF6dglnSaC
 iOQ24O+CAPLTw+Q2HPBDcTC2mFpYkRPfnUiQg/1TJmA5r6cmz6ygkcrqEEWGoN5K+SQaXp4lsrs
 2D5gXW/zZvasaTWABrwMzjFOx3n1APOQwtkQnakA2SMvWFa2VpW2apUm13OavGe311hqWPDMLm8
 NDoP5XrkNS0UBMsWXJVAQqaRzbdj4G8NjA3P0Gvc9QAnwq8wI7tJ7c2YU=
X-Received: by 2002:a05:600c:a0c:b0:490:6e12:542d with SMTP id
 5b1f17b1804b1-4906e12555amr101150975e9.19.1779807219742; 
 Tue, 26 May 2026 07:53:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm36278884f8f.24.2026.05.26.07.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:53:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Dongyang Jin <jindongyang@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20260521094545.3039207-1-jindongyang@kylinos.cn>
References: <20260521094545.3039207-1-jindongyang@kylinos.cn>
Subject: Re: [PATCH] drm/panel: fix kernel-doc warning for devm_drm_panel_add()
Message-Id: <177980721906.3070642.15137989652518665747.b4-ty@b4>
Date: Tue, 26 May 2026 16:53:39 +0200
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

On Thu, 21 May 2026 17:45:45 +0800, Dongyang Jin wrote:
> Use the correct kernel-doc notation for struct members to eliminate
> kernel-doc warnings:
> 
> Warning: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev'
>  not described in 'devm_drm_panel_add'
> Warning: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev'
>  not described in 'devm_drm_panel_add'
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: fix kernel-doc warning for devm_drm_panel_add()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/aeb119dbff2466b8cc9fefa37d4691049ac27e04

-- 
Neil

