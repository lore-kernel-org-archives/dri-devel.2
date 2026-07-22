Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C449AC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B33F10EDFE;
	Wed, 22 Jul 2026 14:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uT3SIkY7";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA88210EDD5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:23:10 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so35611895e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784730189; x=1785334989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QjfBHCdus/5docP5ejkzcB0WaR+YJxwgesCu4xebiJk=;
 b=uT3SIkY7hxR/joWzFV2a2lmIPBQRjsN8luQHUMBod3sjhiLBfx4CXwrHfZS26NVbCv
 pwhZ3DhBJhGAMLMDeVEjScLDBkRkpcRbxNBxG9aylmqPrbk/MwJbz1xYpDekaW0ghWVR
 N1CASyU3ItJF1Xu9Rsnhzok3xygOpYIIYLn54fQVwkDsY97uc2SfoakPzhujSGkcbuZn
 ywDiP4pFXjyessIQAflRl/FfmM/H6iltb+P2rJWc6m63NN8Ry/uAuZlPU8+gy+8rlBfP
 aPxKlZ+w+UJ/QADCUY9d58l2eVLHBliYv5nd+StPTcWx2N2NoVQw0tm+9A/wre1PEaTD
 x5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730189; x=1785334989;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QjfBHCdus/5docP5ejkzcB0WaR+YJxwgesCu4xebiJk=;
 b=PZ30GTNPszdyThvZUe+iWXjiYuir6Rab+VTInlSW9Sk91Kuxl1zKLoafgkANKYmanp
 l1vcViGjZP2cZQFyUXIeHNa61DNSKwVTb6f+indrUULcpYtBGeqn3mOEY1OnuvA5fddo
 TpQDrpdsM5/CyiGYzbZBRIDecfc3cv+M28r1WQohlBxvDlsYNCJEwCz81wPD9p6uHrQf
 UpbEFC+7KYLUJgsMtIUwuIZeq1IdEMeRtUuIitMoifrx96WY2lVBVMsJU5EL87Yqyh0X
 i0KsMbIAyi6wpCkwQKmVzucdL4+AmaXmbSUipdE2Qs/UyxRjdfC3aEYBFfioohuiaF/Z
 2pYg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rofxh/r3QHr1SO6G6lbcltQ4hmoPjUefXwVHJ6q+zHIcfDRGQUMX5ikDYoXiCwEE4NtuRQKcS921KE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIfPkJ72szymM+6S3tz4Vj6GlTvBvK5d4iK5mHvWa3mlfC4rsG
 GdwUJ/fP1HWa+YLNk5ZH1oOdFvp8C86GnTIjD9rr+XHtP3eOcSFqhZv04nusBsp5aQs=
X-Gm-Gg: AR+sD11ESZHGORXCJI42A3H0mk9nzvu0P+PcVHvLiTd4tPrBImgagiBFinPWLdgR9Vq
 2mDFPCLIUNuG7bXl0+hd3cDZSOzfkj9DUW8cY9Ih4HOowVtVbzTMq1dW4FRnG6n5oKCbZDMaVtB
 zXvSSP7hCBRyzfgrbW5ArKpm4ihW3bAduJPFXfuTMak6QHKvXK15haJglE3zdpbXhOjFDqg9FPa
 wG0n9FqMdDNAqs6oSKVmZ0Y7ei96uqh11o1UBQ4GWpuJxMLYLsgrLQoClynn2l+uQvZ91eZAAy8
 6MAAyDIXCil+80s34Fa69pYaQC6SaL5dCs5phee3iraTV0+VDQGuCAGcRjcvtU1z0994xMFXhnu
 5FC88QDylTteu2H70mymshPcXposUBPrBY3aqnhP63vuAST/8lmPZPsQiH5SHNKvwku/RS5wFVv
 D1YpGpFyu44mTXeDDHJKM3yEo=
X-Received: by 2002:a05:600c:b96:b0:493:f6f0:d66b with SMTP id
 5b1f17b1804b1-4954a3ec771mr260177645e9.1.1784730189169; 
 Wed, 22 Jul 2026 07:23:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm138527875e9.14.2026.07.22.07.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:23:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Julian Braha <julianbraha@gmail.com>
Cc: jesszhan0024@gmail.com, mcanal@igalia.com, arnd@arndb.de, 
 nicolas.frattaroli@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260712002632.2323484-1-julianbraha@gmail.com>
References: <20260712002632.2323484-1-julianbraha@gmail.com>
Subject: Re: [PATCH v2] drm/panel: ilitek-ili9882t: fix unmet dependency
 for DRM_PANEL_ILITEK_ILI9882T
Message-Id: <178473018854.1921106.7024862692566225020.b4-ty@b4>
Date: Wed, 22 Jul 2026 16:23:08 +0200
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

On Sun, 12 Jul 2026 01:26:32 +0100, Julian Braha wrote:
> Currently, DRM_PANEL_ILITEK_ILI9882T selects DRM_DISPLAY_DSC_HELPER
> without ensuring DRM_DISPLAY_HELPER is also enabled, causing an unmet
> dependency and build failure.
> 
> Other similar options select DRM_DISPLAY_HELPER, let's do the same here.
> 
> This unmet dependency bug was found by kconfirm, a static analysis tool
> for Kconfig.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: ilitek-ili9882t: fix unmet dependency for DRM_PANEL_ILITEK_ILI9882T
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fc03f930bd9fd7c09617e41b1743e50ba659707c

-- 
Neil

