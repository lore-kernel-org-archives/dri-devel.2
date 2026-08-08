Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F711C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D51E10E14B;
	Sat,  8 Aug 2026 12:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FlxBCaiM";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3567210E14B
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:18:04 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so296238a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786191484; x=1786796284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zCtw9XLhyYld5CLOFuXhhaanDpjQ78I0gCn1Zksv45A=;
 b=FlxBCaiMZkUGNKR8D1aU6tR1a5f2W05ZNLs6lJG3L0Bu0EscKUQnMvFtb6mIPja0Wp
 og+As984BZzNya3+SFMkZFry/kWaB/8pHXxh8gRU+R8VNNqcK8bDvutDsdbSvm+izWoX
 J4GmEUv2cZ+LVgjfifpL6N5FvTvvsZDGF8KEV6E7OsGLtOhdjBzjHwt5bA6jALrQoGFf
 5QP39L0yK+dBK7OxPfelN1tqu+2WPVebCvFfSQ7Tn26h5TcexFSvcLCyNDDcqHBX9EgV
 lUptHWBuAJIu+caJ1SrtTsnTNF5jpZFt+NEF79Hl5E9eE0QQcq2hD2wD87Zdt2oXbSge
 ap6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786191484; x=1786796284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zCtw9XLhyYld5CLOFuXhhaanDpjQ78I0gCn1Zksv45A=;
 b=S70U1Ii69rqnagUfPJKbNsXW+x0iAxbs8Hn3ETMubj+umI4WCVHIaNrb7ZJS5GEajw
 GuAzKFR0XBxPN8TGbNMpyb5yKiNWQ/3I62+YqjHSWItiEGm+o299CQEetINA2LZBPGC9
 JJeFSqL2O6HQcUicoezOieDkhWto2cIzlT4lj5CAMC4A53N6x9e9S05NnQk/du4zT9eS
 I7aKa652IGxiMPqr8x1zy8SiS4qpTxcL+pImpt4gLZ9NrUQvQoC1DkGuXKZlbqBujucq
 oZI/X2ElcdqEs8lTl755anB5b6tFIxaULeAjpnV4xBmOX5EYYfOfUWROJHCvv+K/pkSO
 rNgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9WCTd4m62AIG4jj6pOD3lC/NgTxcGnOQoPtH8V1XOqse1uT67PyEWJmm0ELv5nodfZwbJQr9j+RM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfiCHPNYgKu1A39dLQtSjO1ZNM0++V5H1br5DW0GnaD93dEULy
 IhOo2I+lCV0qtWSyVIBvBH7R6RcymhJt9z6MAlfyjJ45RVBymRThc8ac
X-Gm-Gg: AR+sD11jttpINzEz6Q6ZhFnYX/2zbIaxjrfIbf5UGgPYOhflo9T4/A+Hbw3QHKVjlY3
 P6foqUPqfYny/dRXsmQBcyImigjicB6lAxub8KRtoBN+lObAulBW4G5BHjWeV6EKYD/BQkzULEs
 NCCFZXeNp1NLR5bGLQqE6iGQLSsvikkaw8u2mj9Qa0/Y+SoTav7V+OGbDHS6fF588khSWkX0lb0
 vjUHk0DL0CU26ieE2Q8oxFc8Pm8dwGAeEj1lIIER9BkWUvM3y4H/VkXBGOzDc57ecByfqlB8YE3
 ALwxYrmAtvQ3xyImcf1btHNHD+xc7910CPZ+Vn1OXywvmnuceTg3DwjuGsI+dDLgB/HiA5iXPMn
 PokbFGoSUigpPuUGSgrEPPQUvBYvpXXDmWgYn70Kw0Qoovlrn8GcTeUdgzI+hzjcMyLVxaE5AcS
 u1FAycd1p3E/RxzIENy3hzNUFGyJpIgbRXELrWub5eRuxN3T+ip5nSXRPjCMMmAawObHId
X-Received: by 2002:a05:6a20:914b:b0:3c3:bbe6:95b1 with SMTP id
 adf61e73a8af0-3cb85eef9d6mr29740341637.24.1786191483645; 
 Sat, 08 Aug 2026 05:18:03 -0700 (PDT)
Received: from lgs.. ([101.76.249.46]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f1b04e9sm1781742a12.12.2026.08.08.05.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:18:03 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/exynos: g2d: fix autosuspend cleanup on probe failure
Date: Sat,  8 Aug 2026 20:17:52 +0800
Message-ID: <20260808121752.2819486-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

g2d_probe() calls pm_runtime_use_autosuspend(), but its failure path
does not call the matching pm_runtime_dont_use_autosuspend() before
disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during cleanup, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the probe
failure path before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: d7f1642c90ab ("drm/exynos: add G2D driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index e92a4d872c41..98a5679258e2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1523,6 +1523,7 @@ static int g2d_probe(struct platform_device *pdev)
 	return 0;
 
 err_put_clk:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 err_destroy_workqueue:
 	destroy_workqueue(g2d->g2d_workq);
-- 
2.43.0

