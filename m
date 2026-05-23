Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAC4CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 01:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABEE10E060;
	Sat, 23 May 2026 01:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KzpHlvTH";
	dkim-atps=neutral
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com
 [74.125.224.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286A510E060
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 01:28:48 +0000 (UTC)
Received: by mail-yx1-f65.google.com with SMTP id
 956f58d0204a3-65c396d3b36so7986056d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 18:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779499727; x=1780104527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ELJsuqJw2+MUMy5nRR3yUJhv+8XiKjY5EbNN+zpf1Y=;
 b=KzpHlvTHhl0IoTQY+ThXNaBb8fqQpOf59xylHEo+3Y6D9dXzfJ2Ju/Aegnfi/+by0q
 p42eyFRfBkQFwPSZvvvoD27LLZjm537w6uOV15FG5U+ngYQVeZPcuHHSxb7upaCvLvum
 lFwNVeWISTbNvqkNyCDIUPmbRAP0emE/y89j4gAI1okqqZ0vgmfqLN22TqFDr4ph4U/1
 KwvqaasjLWW68YtzIgXLoaRVducmxQvZySjgOcZof0c6T8bs7YOi6a7eIp+3HjsqlQqT
 PZqfdZG5LWsp1JFWsSrLL8u9OV2xx+M+rOwwyVbFGGqSqtA0LBPBVqwqB3hUTZui2/Jj
 kEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779499727; x=1780104527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ELJsuqJw2+MUMy5nRR3yUJhv+8XiKjY5EbNN+zpf1Y=;
 b=W+N5z3eL3QQjtRvcskqxFCd4PaYP4o7dRcImv1YIy8v7rX0URfr+RCEX6qQw7cjw7s
 ajFkmRfCASZ2eyEiQn0bltFYtK0Ic2hM5Bw0cG4NURCNdkU/uEBLIj85zoMBvULoTEJ+
 QF44TlRLcp4wnzUyfW5LYpNoP2fRgqGco71t51GOEgz5JSDN/BRZSATZrKhbraBzpe1v
 YulniUdSjQIhvsZJQ+hN43w1g5mW3hPPlSPa5W+qnhhGby1VIcOK2qiz4tocA6I9XcLO
 JB/h2A7/7gsbGcOc/JSXFmhohC7dBCMTRY/2Tms+Zv0Q3bPAONg2SsPZByED/QnifYkk
 31Hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3MEn8iRLf2a4CyTacYFSLnGeROOd1zd/qSNUnkdtn75LlJH2q7hMr4IaXuBvid/8Fbh2rRa/TkNQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhwckQlcj2CMw+H1SoGwfe1e2fHGquSIoFTY/ZbhzETgBnlQjz
 E3lk/fgoD29Q+d6qKslHP7tDq6jFoYeVGXVgSa+we7sQIBddye/KZEqb
X-Gm-Gg: Acq92OERtgIH7fOXMLxpea+j8Wk7ZAy+bMuxzpC/EhBAlTimXtNe/eDAaH/M9Jx7OhZ
 FW4Zlp50PqfezN4/o95d/1bMev6j9q+UKUjQtsUyio4x0kS0zzeIuaESiUuGaOvqhnnRVSGVKyn
 TVhABAuFMjjuWAn0TWmhq3EKteEO4zfV90G/Emhji6J43JP8afpoUDua3dQY9CX8CVuEGvj/QYe
 B1QmLFRbRwjluG0smJRdo/fk4HBSPobuwxB7NMVRHk53rhTSbyeaFGPl/7d4UCQINfY9YSWcAJa
 C9lqMZheGYY4QCN9UCj26iCW2qCDUpS8kGlCtQXFkdFnjFsYVaSQ9m77ObSVSiKv/NvBgb23f7N
 KezfS1fbYJ91+6kS9SpGQ0PmvKcz9KHyWN2IFCfV+C0zxMg3/jpaMnS14NHqSFrqxX9M+46h8J/
 CaStwT7NzIyKLkyj5BMXFBzbJDJjYB
X-Received: by 2002:a05:690e:440b:b0:651:c29e:f0b0 with SMTP id
 956f58d0204a3-65ec963a356mr4605847d50.4.1779499727046; 
 Fri, 22 May 2026 18:28:47 -0700 (PDT)
Received: from flagship.lan ([136.58.14.109]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65ecfda36bdsm1446622d50.16.2026.05.22.18.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 18:28:46 -0700 (PDT)
From: Jacob McLemore <jmclemore.lkml@gmail.com>
To: jmclemore.lkml@gmail.com
Cc: tzimmermann@suse.de, Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: sor: Remove usage of drm_simple_encoder_init()
Date: Fri, 22 May 2026 20:26:24 -0500
Message-ID: <20260523012824.81043-1-jmclemore.lkml@gmail.com>
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

Remove the deprecated trivial helper drm_simple_encoder_init(). Inline
the call to drm_encoder_init and add instance of
drm_encoder_funcs.

Signed-off-by: Jacob McLemore <jmclemore.lkml@gmail.com>
---
Saw this was a good first task in Documentation/gpu/todo.rst.
This is my first patch, so apologies if I've set up anything wrong
in either my email client or gitconfig and the patch ends up invalid.
---
 drivers/gpu/drm/tegra/sor.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index de8b2dfc4984..4ac23aedb682 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -25,7 +25,6 @@
 #include <drm/drm_file.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "dc.h"
 #include "dp.h"
@@ -3038,6 +3037,10 @@ static const struct tegra_sor_ops tegra_sor_dp_ops = {
 	.probe = tegra_sor_dp_probe,
 };
 
+static const struct drm_encoder_funcs tegra_sor_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int tegra_sor_init(struct host1x_client *client)
 {
 	struct drm_device *drm = dev_get_drvdata(client->host);
@@ -3081,7 +3084,7 @@ static int tegra_sor_init(struct host1x_client *client)
 				 &tegra_sor_connector_helper_funcs);
 	sor->output.connector.dpms = DRM_MODE_DPMS_OFF;
 
-	drm_simple_encoder_init(drm, &sor->output.encoder, encoder);
+	drm_encoder_init(drm, &sor->output.encoder, &tegra_sor_encoder_funcs_cleanup, encoder, NULL);
 	drm_encoder_helper_add(&sor->output.encoder, helpers);
 
 	drm_connector_attach_encoder(&sor->output.connector,

base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
-- 
2.43.0

