Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC48FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9B410ECE4;
	Tue, 28 Apr 2026 14:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="qjuDmTxN";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D957910ECE4
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 14:46:08 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso100055935e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777387567; x=1777992367;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qG2xEq+suvSHE4naeOi+PCYc+DbypH2YZR0qtvrl750=;
 b=qjuDmTxN6Nj/AU3VLC86DzBBAvLhfMMIFe5UfFG/Cu+AuM/Ogzv62HeGy069/zSi94
 ScauJze76Spd1+1jEizGjBs0ynhaRPeu4HtYzV1P1GxQqEV5Dse3vU1Zxg37JTLK+tSc
 ckIfGHABvjo8ID1i8ukmfM3uN2rI0H/Of5xBKEIIb7fJX8I8A6fb5xQTWnjPCorNTjJn
 RJPjI7+mqnipUvemvNyp107xb9Xh5b/gdanojHcUIKEU/FHVyvp5IaWxQzsSMDIm4Fly
 +1VcqSFza58AiG7TG8o0xcH0DqGp2U6nMPcpwu7B9k+8b4WMS8Bp/07aYOKn4BBMaOuK
 3+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387567; x=1777992367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qG2xEq+suvSHE4naeOi+PCYc+DbypH2YZR0qtvrl750=;
 b=k+zsLazwE2coPUyf2w31TL50ATYWvbh4ZT0c25EEXuGLZUFXNVXs6oYpcnGBan1z0z
 KiFaAE4yp9NEPYhsYZVbS/zK7hKTmsx50C1XpC8DQhy8xZlWZeD6E/wV7AjPhVSr0Dja
 L672F/T69kK+jCVoMw9heeD+aGjXEFC1PM0Pti5OaiLDJ4fugnkUzPVlYQUNHPpH1bsn
 rVbS3OvUR3tOLWPlQd5ZjC5PGtLVUR9FA47gyaFBqjPRYBZT9gO5twBb0LBypty1Hhe9
 kGDIcmunVrz5vcFgX6sOyyn3fTmN9QP0t7lJdYfTW76sW+TzrK403pMJbwz6EL+7WKLW
 z0yA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OxWOHMCT/a6NmDPW0UykOz4J0CaH53WTTqRfDiKJeLedWvOV3HMWiMFIJi/72XzYx+patS0bGpQY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwX0GbK7KjnNz8vBY5zRkjNfXc7rZEszC4AJ6vpCkre7a9ooeww
 vutP5IU+YCv54cf2VIZnIPDeGIVX6GxbSr6KI6kf1EhW8pYhU8aU60UcA8z2CISVNPY=
X-Gm-Gg: AeBDieu7aEiVihxGHgyrczQ9Ufq/p1dUJNSfB8arogr0Lz1SjwImfWqocDNjUAVibN+
 RRfp2JiiokWZr/a9dBlR2cZKZgBNuh0pZ4iDfjNJ2fQVaXd7gakSY5fMYFRYYu6WVkq1azKhfVw
 dUWlARysPuNGanazqmbL7zpjn4dnJq+IpAfZiXCnRycA2r40Nw1ulNYJMEpfxm9CnXjgbqa0xxa
 EAvWhl6D9FYupjpDlTc5O1XZs33GjgE6H/0sV0V5hm+/hw2RwrQ4bUTGha8tb1K5hqtLsd+Km3h
 BAS4m0apgV+mqKExeSg/3AiyF7alvm4T8fQ0cXyvZpKJIfvmxhG8KtWD63JCYYJCiwgjZqiWEEH
 I8bdW0HAu8Ex2XLmUMNFuFcFBI0V4efcouNFrPvPw8MXLguDMADh+L7T9zJ+yErm5A1LTXUMW0a
 nIHKB8j2OJ3ooEMhCkzyAR0/peT+jqh5Yr4kZSauwaKWAfGpKe4iH56ITNyg2VgmhH1vdu7gBRQ
 UWzCOPTLIiK793UwtsAjf6Nrg==
X-Received: by 2002:a05:600c:8590:b0:489:a4:e555 with SMTP id
 5b1f17b1804b1-48a77b19b5emr38612635e9.21.1777387567055; 
 Tue, 28 Apr 2026 07:46:07 -0700 (PDT)
Received: from localhost
 (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a775f56fcsm22197915e9.25.2026.04.28.07.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:46:06 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Don't use UTS_RELEASE directly
Date: Tue, 28 Apr 2026 16:45:53 +0200
Message-ID: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=f/dYGP07OBg9DiHyqQLx/Tm6yf1j3LG8UrwHVCI8ms0=;
 b=owGbwMvMwMXY3/A7olbonx/jabUkhswPJ5Q+HL7Ty3Ps4TXJJ/8TctzLpjKnzthXfTTkh8fMG
 fdelVRKdTIaszAwcjHIiimy2DeuybSqkovsXPvvMswgViaQKQxcnAIwET5+9v+eXXtzPpbev5dm
 yy1691LNyRrFyaWioi+Lty3141+e/i7PpWTqppVnuM/3P0u9fzKpoNktwkqy4/6BkznPUuae4XI
 QfXj09r75oY17gl8dujCv2u2X0LKXenLlhmKWGkfdFwsvPPDjyeSjf7Rjtxzrb4jm1M+YqJ292v
 PzkpPvBbx1v6dWZAaXKIb+Epl3UiDXQFtovcLnbVrVwdlxObIOETOKGyZWayked8jQ0Dj8b/bbs
 kOfLqSxVxbLKGb2uMoqZsnphsj0lEYK5NxzY9+uKhjBdfzggTrFrqqvJf2mLUFZKuvf//LLDVVs
 ktL5ppndl+2aGNzb49hb0GPWV9Orw/o59th/ro3Tz94DAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
uncommitted changes in the source tree or new commits). So when checking
if a patch introduces changes to the resulting binary each usage of
UTS_RELEASE is source of annoyance.

Instead of using UTS_RELEASE directly use init_utsname()->release which
evaluates to the same string but with that a change of UTS_RELEASE
doesn't affect msm_disp_snapshot_util.o or msm_gpu.o.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 4 ++--
 drivers/gpu/drm/msm/msm_gpu.c                     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 427d3ee2b833..c6eda3cf2e62 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -5,7 +5,7 @@
 
 #define pr_fmt(fmt)	"[drm:%s:%d] " fmt, __func__, __LINE__
 
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 
 #include "msm_disp_snapshot.h"
 
@@ -79,7 +79,7 @@ void msm_disp_state_print(struct msm_disp_state *state, struct drm_printer *p)
 	}
 
 	drm_printf(p, "---\n");
-	drm_printf(p, "kernel: " UTS_RELEASE "\n");
+	drm_printf(p, "kernel: %s\n", init_utsname()->release);
 	drm_printf(p, "module: " KBUILD_MODNAME "\n");
 	drm_printf(p, "dpu devcoredump\n");
 	drm_printf(p, "time: %ptSp\n", &state->time);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 930e54d1b0a7..3f3925b11eea 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -13,11 +13,11 @@
 #include "msm_gpu_trace.h"
 //#include "adreno/adreno_gpu.h"
 
-#include <generated/utsrelease.h>
 #include <linux/string_helpers.h>
 #include <linux/devcoredump.h>
 #include <linux/sched/task.h>
 #include <linux/sched/mm.h>
+#include <linux/utsname.h>
 
 /*
  * Power Management:
@@ -196,7 +196,7 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 	p = drm_coredump_printer(&iter);
 
 	drm_printf(&p, "---\n");
-	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
+	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
 	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
 	drm_printf(&p, "time: %ptSp\n", &state->time);
 	if (state->comm)

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

