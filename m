Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F2F43841
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F2E10E82E;
	Thu, 16 Apr 2026 07:39:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVbBPgRm";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E291710E82E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:39:20 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-35d94f4ee36so4503246a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776325160; x=1776929960; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=50kd5zV30kobk33oIbkkpmq/GcCA5PpN/ngeH7jNk1s=;
 b=jVbBPgRmP+J5DqvFAkq7L2OwlK4zdC15p5vv8qjJR9HOg95KE1CymTRRCx11/ZdD7X
 BzbuudS0qvkTEw/6rpfD0QW4r1+PQbIpBOO22DnFMkK5ekNWoeGKA1hYTINPOIK73TFv
 heBNlK7NJ7GfVd8gsC8a8YVSanLlitm78dd+edFCNinH2ggjUAEZFDMU4Ui5kCWf/0qp
 sz4wGJv2PUVcnKTMmsojm5VvuaHJZeYv3MatZqPitPg7eWU3SqiNpqRgcacmVaErCrV6
 QCpsd5zSZGAVN957u5JJhikeFaw+SxFqlFK8Aqw3MoRZop2aoBKY+sRg2frc4Y2ObVKv
 ol5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776325160; x=1776929960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50kd5zV30kobk33oIbkkpmq/GcCA5PpN/ngeH7jNk1s=;
 b=AFBJ5xfYVxDVgE6YcEY1aeg5Kc3QvFwxcueefzC3J5lo1ewI3c8kEFdj6GBTJYjyKf
 vyrPhUmn7PMIsTgeparOhV+UOka0XcMVVmjOKQn8ChnGqRuSBakkOX9eFuEiNQgC+0r0
 9JWPiFNHXG9whkHDi0tq1MZ6TxJdNqefW5yLRMa7dyguE9gzFv0pnEpR5nTdzeaoKN74
 TvKcTKy7zQ0awcMSgQUyN2rW0UzucKf2rFclKBLW9WDue9SsIgRDU2Gfg0X0r2J2xflp
 umtToGM5OF/34Li6DW9xU3bBf8B+nLfmhLW9gOtc/7Zh7/CezdyTST1mjYWUWabvf/GL
 YzOw==
X-Gm-Message-State: AOJu0YwrWMjhZ2PZS35yek7659Ihkp8AI7XzycuZ0zuzzxTXnyOXmS2v
 iyzOW0AmfIxOvMDmlbGi8gOJqXYhNe9gBU437aEfDYp30O6nEfuEDQCVh1DJVwqX
X-Gm-Gg: AeBDieu94D/joy4KZoXVxJRTZurKHjFZDCYvJAa6ZnZUg2iifo1a3102XE/yEdX40Oy
 PowXqicGNvOH0/mgUMuHH2o02ZgMaec9eS0FmuRvDNIZQUz6tLUntsVklI5xi75udGe9LNySnW8
 scqTEzNaBz4rjUciuqgvLu+HoFhoZdSKcCOzzbEIvmTFv9pKeS3I5AANv6Q1WYfgndBPAUu0NCb
 lYFOhJ7jiCMtFvSg4HS/lGMow2Wz0dGU29JcyY35F4jk8ESvTuv283h5n9PhLuj+1HESVRGLAGX
 VSYbjwV24eknlteHadPH+f2eJhm7Xjw7p+gRmgYoIAdfLkFALweKf2gqoD0IxwZZYkVfjSx3miZ
 pztoMILKbLAfJoPH1t+oFrNe1zffdeX7TsjritWR3SD/mM9GZOn63gQtkwdMBlW3BP3PVycflQh
 x6vtBtwHr82pLsJdEaejIKmeUrhsnPquNcfPxpj1A/vj5agYh2wMmJJlSq1iVqvfFeYg==
X-Received: by 2002:a17:90a:e70c:b0:35d:9f7c:142c with SMTP id
 98e67ed59e1d1-35e4282731emr21208111a91.26.1776325159965; 
 Thu, 16 Apr 2026 00:39:19 -0700 (PDT)
Received: from fedoraemon.neon-universe.ts.net
 ([2406:7400:11d:a9dc:9a14:72eb:1a60:868a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36132d9d228sm1735245a91.10.2026.04.16.00.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:39:19 -0700 (PDT)
From: Avinal Kumar <avinal.xlvii@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org, dianders@chromium.org
Cc: lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: [PATCH v4 0/2] drm/panel: drm/panel: panasonic-vvx10f034n00:
 transition to mipi_dsi wrapped functions
Date: Thu, 16 Apr 2026 13:07:20 +0530
Message-ID: <20260416073722.719036-1-avinal.xlvii@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes from v3:
  - fixed code style issues
  - removed redundant error printout

Avinal Kumar (2):
  drm/mipi-dsi: add mipi_dsi_shutdown_peripheral_multi
  drm/panel: panasonic-vvx10f034n00: transition to mipi_dsi wrapped
    functions

 drivers/gpu/drm/drm_mipi_dsi.c                | 28 +++++++++++++++++++
 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 14 ++++++++--
 include/drm/drm_mipi_dsi.h                    |  1 +
 3 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.53.0

