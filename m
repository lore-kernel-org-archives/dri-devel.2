Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899EEC624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C3289CF6;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FP0Xkh6y";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4304310E186
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:03:34 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4b28db31b89so564319b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523413; x=1789128213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0mmbVoRzhegDeL5+uzJksOxQmVqqe3qpVwymM+HUwZg=;
 b=FP0Xkh6yDogXRj9QeYvSJOkUbyulADM27UzuRqF+8fcRyYdPIboHWXf1nYcQ4CNYl4
 U+NDOJQ3jbdvmog6A+kIChlGAKIcA3QghLfKcDwDMByXQeI1roDhY0LNgWQdQBmf8Vaf
 CZm1Naxx3IX065O4xOjsATA1Dcu8aKHoLeegJ9QgxnISkUjEt6w4Iv3TRVtReBvCJL/D
 lDhETYQEIaIzz0V1Ss0zYyH7VSRB83iN3KyXtAH1srqL3co0S5LoZ25B1y5O96BSoF6y
 6X0kVWm9EV+QsC3YIemilYYzki+AeNx7ndYNi5zAkOZK8A13dcz03LWi9FYWDfkuzARw
 J9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523413; x=1789128213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0mmbVoRzhegDeL5+uzJksOxQmVqqe3qpVwymM+HUwZg=;
 b=hjn2Bt/PE73oHBNfipSbKZraxFAUNZou/HUC0cNs3bxQAe6PYuD1JxarsV7ibjB/1q
 +jBE8JSrk2QYWfzVUe5FNG5lfa4fUC9+fCQ/R+c3bXQovPgPfTrHxLVP2YCZy+4s1yyi
 8wGP5oGO7sB7pPz8+k4XcCjabEI4MukLVBlNT1F7KHZzjOAVkxF+9fg1kIOW8GbCo31e
 +P16cDCq3W69YJdPxiK6Lbdz+IP3YweNJp0Kuao11kzIa3I9+pfefuEiqg0jMehXaU+O
 sLSTI9xEtBfH0akHGue5HE6TknKKmGBsv/iRVAqLhTZ3BTGOVVaSPC7a4CaZJEE9eKCL
 od+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbTvEKFGY3ZVvASWwMOh+ZzNZRbXAhxHAKXPDNm7SRZTswKTETQhZVWrNEmFUSRU8uhWz3bqElnb4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntG244wb55wthcQIsLFGGpOZ6vsLfxtv7etUdxd5KY8wCnuy27
 4UVvkilAx/WdkkFSxnQviISQ/xakDGkVhgQKccAXhFCqc+piUzbxrPnU
X-Gm-Gg: AYBFou16vlOEGwGUOY16MsEtUC5eoTG+XfdKCEKi6JagZoY0z7+UZp5KXiB2udkiycs
 TnDC4IoTKZzl4WJ2xAo2+w+dLehtOasUmGSZ96s+I+oDMTWPcZUrTiVEGQJL4LI/nmvB3cPyjZf
 Sy/x5ZrWBHz/iQL7rcwEpnzBIdsOt2GuY8cM3pKinDLQY/WIpg/PM5hYo44W6MZHT8a3OdLEP4U
 K3XAFLnI02urFA2V6YjyL+/Q1BDbBWz3YFgFIBT+5zo1Fg9eJvt0v3GF3DZLQANCH6cKXbIDb2U
 wWtFQO0QQRRySRdZbXDMPqLq6Lj/QWv1eTdKfOb8DIocYwWnIXjwP+7uv+7+PjxHnQS9bpZRCZu
 N4744LFytp+rWt/qgZbBYiHQR9Xr5bwKyIZQG2bKZrlzPsTzlJ6yBn4Ew9e8JDuXvrfDjqFctzF
 icc0kRUhydBSR2kNVsiV1C4VBLCJEo8DVWCyiJqU3+3vIeeuLKNeAJ2Af+t6RQhdQxMgGjXiTLi
 YuDfl8fSaFl1bg=
X-Received: by 2002:a05:6820:211:b0:6b7:83d6:2926 with SMTP id
 006d021491bc7-6b783d62ecamr1256097eaf.41.1788523413265; 
 Fri, 04 Sep 2026 05:03:33 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b9f68e4sm6597952eec.24.2026.09.04.05.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:03:32 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: fix typos in comments
Date: Fri,  4 Sep 2026 17:33:25 +0530
Message-ID: <20260904120327.16622-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 include/drm/display/drm_dp_helper.h   | 2 +-
 include/drm/display/drm_dsc.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 5c23182f4d33..2aef96fdbd10 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1971,7 +1971,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 
 	/*
 	 * We treat the device as initially suspended.  The runtime PM
-	 * autosuspend delay is rather arbitary: no measurements have
+	 * autosuspend delay is rather arbitrary: no measurements have
 	 * yet been performed to determine an appropriate value.
 	 */
 	pm_runtime_use_autosuspend(dev);
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ab16c1be3900..34bdd599383f 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -816,7 +816,7 @@ enum drm_dp_quirk {
 	 * @DP_DPCD_QUIRK_CONSTANT_N:
 	 *
 	 * The device requires main link attributes Mvid and Nvid to be limited
-	 * to 16 bits. So will give a constant value (0x8000) for compatability.
+	 * to 16 bits. So will give a constant value (0x8000) for compatibility.
 	 */
 	DP_DPCD_QUIRK_CONSTANT_N,
 	/**
diff --git a/include/drm/display/drm_dsc.h b/include/drm/display/drm_dsc.h
index bbbe7438473d..0682071d881d 100644
--- a/include/drm/display/drm_dsc.h
+++ b/include/drm/display/drm_dsc.h
@@ -322,7 +322,7 @@ struct drm_dsc_picture_parameter_set {
 	 * active.
 	 * PPS4[5] - blobk_pred_enable: Indicates if BP is used to code any
 	 * groups in picture
-	 * PPS4[7:6] - Reseved bits
+	 * PPS4[7:6] - Reserved bits
 	 */
 	u8 pps_4;
 	/**
-- 
2.48.1

