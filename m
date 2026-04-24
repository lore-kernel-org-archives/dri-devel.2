Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C55FED3F5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EF010F661;
	Fri, 24 Apr 2026 17:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QLKQgynX";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8192B10F437
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:23:58 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-362e30526f8so580924a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777033438; x=1777638238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C71odJl+wa8fdrMSB/JV4uI6qaWBDJ3Egjrlc4m0udU=;
 b=QLKQgynX5/2Qm+4dTuHkyUvN/hwP3mP4wBHPFndlpO4miCmN9k5aiRbtGrfl3odp5A
 VbE0FpxhYrnWIrj7yFc0JubMtjtFoinycr5p40f/CWS7ZcpWsAqDsrvehklAOnxPAqHA
 nTjfN07c5j05C0xFZimR/MVNxN3bML2ym+9oUBp40h5dHr4E3+f6VsZgFB8uEEMetpte
 esbyOAayJXQBSuX0EuPH+1WkMD1Dz8/ZubbL23WVmvofYsFvgUsy2iexKl4P963I4r1T
 n8X+tvsEZokX6wd7B94BQ2PK5hVlqeyLlq2IA1yhIRtcNQPg1OSZ0VQwF1B8AadvGeku
 nrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777033438; x=1777638238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C71odJl+wa8fdrMSB/JV4uI6qaWBDJ3Egjrlc4m0udU=;
 b=BzH0DVJz9MrgK6+x9NJeYd/Fe5rlWbR6yVIU76oWmTh9P5eok7hV44UPPkGSRRQQq+
 Dyya72QXmSlhU+PyfvMDwZQW3XhiRL+r4E+u8pNeGPK9B4pzEAFRzdwhckbQA3mv20CY
 3DPkRB192Edga0WAX1KqIAo3Ym24lTu3lYHny1M8S094d4RdQvJcHvBymqdmh96p0xmr
 UWSGiK5jadE4wwDaSw1cj+o9k3cvXlqpfNdDIbdxLzhdr9cHLvaluLx4dWL9PEmKKpz3
 A325/MN/6FE1EB6/3UMV118u0COJtZnPCvA5Vpjbj9zJaL1cYPAjtIc/JlQBbA56zp88
 kHoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97m6nEJOf1TJEjCHiIykEdQSzi+uYPhV8aQhwLcIXAonJ8bYFp3Ui+E83WH945NVETXeWf7oJmBN4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzr3D0eLEiqYCyt5hKDK91uxxpJU7jKP6pXlDTvtqkAKxip7vVN
 QHLRjBtVrFyudFstqRIt5tPieBKE2pO/hEUi+Owxl5lPt8yb5BHpd4Q=
X-Gm-Gg: AeBDieuSmIYpquAk2nQgl8medf91kg+IZW6R1bwxYrJl9X8vZ/GqJB6lyXCgHpoqiot
 A7lxq8jNv6gKbwDFqeVBM6f0LNNFAAvrQzGswaUr5p24T1xkqEA1FEZTD99IjDAJQU0gCaP32HA
 HBnlKtk82RoQZ9swsGr92lLraROv3LmlMHFgB0YicYbwFxq+S3BR+emwPvAjXxIHbUOX9X89QQC
 w04Z0uwCJ5QpqOJXD7SjKr8US8T3MrFadkS5lbgaLkxuhZkfmFZUbw0MV3gWp9wAkwwu2nEOVOi
 MDgYlQAUzalFYZZzvPZCAXRXjGc7Yq8MTTTtHtZ7q/dmNX7zvv35UiXcZPuRjyMowhmbRJky6OE
 CRTZCL8WWz8z5IzqzPAkCuqfnd0KZDj/a6QUJXDRsox3sfYMUH7O6fpw49mclA4TdY6HLGKxNc+
 P4xSE7xCt8Kv9KfFVkFDyMDbw3cLDXe822V5yvC6Othtobeno+Bp+cK3hJP+QMaGSRx9T2Z+O7y
 O08rwVZLw==
X-Received: by 2002:a17:902:cec6:b0:2b0:917c:bc4 with SMTP id
 d9443c01a7336-2b5f9e8e3c0mr355839025ad.4.1777033437987; 
 Fri, 24 Apr 2026 05:23:57 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa30134sm230574895ad.30.2026.04.24.05.23.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 05:23:57 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] drm/sti: hdmi: Fix bridge leak on component_add() failure
Date: Fri, 24 Apr 2026 21:23:39 +0900
Message-ID: <20260424122352.20930-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

sti_hdmi_probe() registers its bridge before adding the component. If
component_add() fails, probe returns the error and leaves the bridge
registered.

The remove callback unregisters the bridge, but remove is only called
after a successful probe. Remove the bridge locally when component_add()
fails, then continue through the existing adapter unwind path.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f8222e60b1..d7b61b5b35 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1460,9 +1460,15 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, hdmi);
 
 	drm_bridge_add(&hdmi->bridge);
-	return component_add(&pdev->dev, &sti_hdmi_ops);
+	ret = component_add(&pdev->dev, &sti_hdmi_ops);
+	if (ret)
+		goto bridge_remove;
 
- release_adapter:
+	return 0;
+
+bridge_remove:
+	drm_bridge_remove(&hdmi->bridge);
+release_adapter:
 	i2c_put_adapter(hdmi->ddc_adapt);
 
 	return ret;
-- 
2.50.1
