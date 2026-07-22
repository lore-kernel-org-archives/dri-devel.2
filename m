Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F78C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF4810EDD5;
	Wed, 22 Jul 2026 14:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yIwigZ97";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF2B10EDD5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:23:12 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495590ba856so32395295e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784730191; x=1785334991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LIJsdUeD5+Jjva16C9sc8daq8nS2QPwgblMc0qoogbA=;
 b=yIwigZ97ekyR+i8j2wLjLuj9Z0GzfQvCKppFTms87j2G5YoHPwpLpNcN5xCllrcOe9
 Nobz4gvlpsXOJFt/vqsIcJSUslOO3dfG3Dk5jVRyLL6E8UgnpO5BxPPjfanRyYggIKix
 hgCpHQipwk0qXsxL+q/9GUJalSfb/qagWhqnXKFoFUwC0wcqVWExxrLS3QfDQe81Ktp4
 8DH+50SsLK43m0S56+FpBlb7cbrajY/Wa1F/RYmGcfDQJR+R6I0spslmqvDP6YWpbUBQ
 JiaFc5jLRfySZeSSmEPHdg4oQ1JxoJ38G+1OzFdk96ER0MGx0uMIqrNZnh5u8EmKtxZL
 R0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730191; x=1785334991;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LIJsdUeD5+Jjva16C9sc8daq8nS2QPwgblMc0qoogbA=;
 b=TKCyTQgd2x2fVEk5bG8koSKElvCqYQUlQVtqoLyeA9uQze/Wmng1GdhQmtXgvz5/YS
 /bGkAXTXsy33wjOCs46oPMFGnSKfoQwbLFymiPr9X4pkIfdSMA0dHGFE0h2+/zN+36VB
 K8l6+NSRr5YwdklUcL7bO1gU6cmceKnveEjVi2NanHAelQQZsx87J495JdWVa4bMP3Nr
 gCM1OEVx0e8Fu25Yw74asiig8C1UdG0bQuNkDBTB4IGEhA2j3ObGdsPWeapHAMOy8UQd
 F1TMnhidQzuCsED4LbENq91T6TwVWZ32o+xx2fFj64n8tqVm2smNLUQvTHm31NSD8ZUi
 A7jA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEy7+7/lJKRNQ8jesIUySrCj3YkfM7Bi3ywy2DDbE6K960rKNcVWBglpRE8FCSG49GmLzy6tbPNFY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIS2YfsnmC5mYynT0vj1eGtFLhLjlFm0tSZWBLshOX6oP2eqRx
 4CuK8mlIlpsyLoo5qbpZxZHDsxr5RKfM6gV+SpaNj7dKiISfWLGAKyXMOr7qlUBcl8P1V1wIdDO
 fq5/K
X-Gm-Gg: AR+sD11VuE3LgQ6oMynmU+j2vNeTqhVz+EWSccLVISz2nQ4BjKhT7D3SDKcozyqMSjs
 qTxWEDGe9tg4NaxDavEAMZAr589u10z8jLkU4P2BJjws7ePA0uLg1boduL5rnzoud+JYSfmyxrC
 4BS6DFD33UVuOnz8n7A5ZgBR9KhVN1ns5aJXbcnIeBofAzlFnExARHq9ax3aQKwBM1vMdWuCvPZ
 4OsF61I9SK+I0F/VgRFc4yrONVhYgSLzQOHykY7gCxqVVqUFnhywxa/ybnH4QUJf6S3BqZ1kNhh
 rdvof4uZNhihv7MUbHulCfgVaP2nVRd9I+yPmJ7GSURyqu0fA8k5aHb/3AXmkmPT/6XFLfO12zM
 xnQNbU6WAeQN2iVbo7cARXaWr3Ui4tykTBNt7+BmWyROH/0RDYj2FZqgX3ImhDwXR6U0oW35NS7
 TEPrTdAYi9+PrAfgj3jtdrips=
X-Received: by 2002:a05:600c:1551:b0:495:5858:e163 with SMTP id
 5b1f17b1804b1-4955858e1damr189393785e9.27.1784730190604; 
 Wed, 22 Jul 2026 07:23:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm138527875e9.14.2026.07.22.07.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:23:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Julian Braha <julianbraha@gmail.com>
Cc: david@ixit.cz, arnd@arndb.de, jesszhan0024@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260711234230.2236041-1-julianbraha@gmail.com>
References: <20260711234230.2236041-1-julianbraha@gmail.com>
Subject: Re: [PATCH] drm/panel: fix unmet dependency bug for
 DRM_PANEL_HIMAX_HX83121A
Message-Id: <178473018996.1921106.159802975224648442.b4-ty@b4>
Date: Wed, 22 Jul 2026 16:23:09 +0200
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

On Sun, 12 Jul 2026 00:42:30 +0100, Julian Braha wrote:
> Currently, DRM_PANEL_HIMAX_HX83121A selects DRM_DISPLAY_DSC_HELPER
> without also ensuring DRM_DISPLAY_HELPER is enabled, causing an unmet
> dependency:
> 
> WARNING: unmet direct dependencies detected for DRM_DISPLAY_DSC_HELPER
>   Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && DRM_DISPLAY_HELPER [=n]
>   Selected by [m]:
>   - DRM_PANEL_HIMAX_HX83121A [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_PANEL [=y] && OF [=y] && DRM_MIPI_DSI [=y] && BACKLIGHT_CLASS_DEVICE [=m]
>   - DRM_PANEL_ILITEK_ILI9882T [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_PANEL [=y] && OF [=y] && DRM_MIPI_DSI [=y] && BACKLIGHT_CLASS_DEVICE [=m]
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: fix unmet dependency bug for DRM_PANEL_HIMAX_HX83121A
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/aaa5be0258db1709e254b4150af5c2fa5518c548

-- 
Neil

