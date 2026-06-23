Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B877CDE003
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687B310EDC8;
	Wed, 24 Jun 2026 07:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pqyw8jz5";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5689910EB11
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:50:21 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso1133005a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782219020; x=1782823820; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wuxR7/cwC5PXnlH9Ywf/Xu94uq2eGxYSfkkCZirEJFQ=;
 b=Pqyw8jz5ub9Lo1GkBNoSysvWzqjshBBtnhL9sR1duEQaeSlytCxvOcvxIsQ+LQohhs
 9wBFU9oJaU0sGvUFni4V3ya+VRlPHJQZCu08bvBWXDoIeR/CwtAQwnfhrfomEPH4+wHF
 NVDKXGNe8O3lY4LpQ/Az49N+4KoRI4lFeshqv1MmaXBkajCtik/JsBKNLJYg+/RTORG7
 WXorMTc1N7XNsosu9vaUN3Pw+sOmwQ41FeV3BN4Bjy/2v1WSizw79aCVHyJB6jK7NuPm
 WImmMUxO7b6F9zIEr3Tu9ZD/1SY8nWU/mUc+GQxb/WvoS/qVk4LzcT7vaY0WvuKJOCvm
 RE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782219020; x=1782823820;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuxR7/cwC5PXnlH9Ywf/Xu94uq2eGxYSfkkCZirEJFQ=;
 b=DKXGQ4tO19ZCxjheOs4tE38q7WZGRfVseO2Vo3ZgjyHt3SsaSxR126iPexNHCsjibm
 bsTlF6rVZfFm5Lafwg/7Gj9CnWsuBP6vtd1CuVrZitCzJDalHJUD7nrMGSoNySUPwjDF
 WT0R/5m0a301RwVoGX2bv0pgejZP8IS4QSFnYjwVV+oppMGHhBWM6zvTC7m2ljsbloUM
 TMvz/1cV+OQ7AsKi/JHipeg/vtfglxjrIygwfdu9FLwlWFvj+nqQudrDgZXgCZa4xody
 SUHP5Jo3XhrSnnNUGmgaZdtZKvYfhEucMmvdhcIpH6e4tv08G5+LQGg9FQyACnhJ+TF1
 Ly0Q==
X-Gm-Message-State: AOJu0YzQqfv8cRAu95V8dSlU0MIVXaSr208ghBWShFXDMOu8oaSB1Q/d
 d5/rx6DIeXD8Xcl5oxHDhBajcpdgz0j5aVAbsVQ1JBNGB1hONxX3roRe
X-Gm-Gg: AfdE7cm3LkSKYTO0ZbIo3I9P5Y1H5r+cNqXFH/8HFwCNKHtteaulIWMPmB98Ualkgg7
 cdYZ6oIfO1JpNJYh7Iy/H2BRmGQZdvppJeaKph7Tv6qEBnF4Fs3AeagLzQxd7au4Hb4Ubi7d5PI
 j9lX3Kdxq3wZ0P4qOH6j6EMGDk7bk+b96X/70JWKUoh0uufXzjXT3sZpuMPB3kodPiqiyPGU/gf
 q+Q7iVHx7eZS4QVAEPH8meYU2QfecrkTox9CaX35dbfDdKxL42GuSFkXpPYe7fiUTNrccLZSpYD
 JPZ/f+4mkfSPnX6KUraazPty3KOrqSCyDyKgT1dp8xhd+ZCRG4459R9wfxUNi4os48/dfqqtYYm
 5yB74BBacqCPVbM2YUD92qXpybl40OA2HQYY/Cv8i6VoEHXfDfPDV14xeoRKoF2larQZQsyRsyb
 2UU3gyfYxGJm7BlXXS6xcH
X-Received: by 2002:a05:6402:52d4:b0:695:defe:bad with SMTP id
 4fb4d7f45d1cf-697d4315842mr2072027a12.9.1782219019350; 
 Tue, 23 Jun 2026 05:50:19 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b82fd6fsm5153967a12.2.2026.06.23.05.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:50:18 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH 0/2] drm/exynos: DRM encoder improvements for Exynos
 devices
Date: Tue, 23 Jun 2026 14:49:42 +0200
Message-Id: <20260623-exynos-drm-simple-v1-0-bb52f098b1ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOaAOmoC/x3MTQ5AMBBA4avIrE1SRf1cRSzQwSSUdBIhjbtrL
 L/FewGEPJNAmwTwdLHw4SKyNIFpHdxCyDYatNJGGZ0j3Y87BK3fUXg/N8JxLPPaWFOUTQWxOz3
 NfP/Prn/fD3HAptRjAAAA
X-Change-ID: 20260623-exynos-drm-simple-bb5386d64597
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

This series does two things:
	- Open-code drm_simple_encoder_init() since it is deprecated
	- Handle the error code from drm_encoder_init (previously
	  drm_simple_encoder_init) to prevent silent failures and
	  cleanup of uninitialized encoders

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
Diogo Silva (2):
      drm/exynos: Remove dependency on DRM simple helpers
      drm/exynos: Add error handling to drm_encoder_init()

 drivers/gpu/drm/exynos/exynos_dp.c       | 13 +++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 14 ++++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 11 +++++++++--
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 14 ++++++++++++--
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 15 +++++++++++++--
 5 files changed, 57 insertions(+), 10 deletions(-)
---
base-commit: 60326b17f877e12846167bf8ef83680b9875218a
change-id: 20260623-exynos-drm-simple-bb5386d64597

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

