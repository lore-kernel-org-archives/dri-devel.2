Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A631099B32
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD91610EB46;
	Fri, 20 Mar 2026 19:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S5PVh/3q";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01A310EB46
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 19:12:28 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2b04b4974abso21442855ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774033948; x=1774638748; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ux+DVa2N+/JaIwDNhsnggYM4bsW17uE79GBmRoiXmjI=;
 b=S5PVh/3qoag7w3MJhM+/v/NkM21rUiVdRwQ4tWu7Dj3H5S12OSVDn/NCYAIrr4ZEGz
 fO/Z1sQYpKS0YHYXiMubJH+qeX/TNS6rtR+5q3qcxxVYmlbB/VdKCqIDWehxr5Nkkv2/
 eCsK2yOdtHEnVcP/bWJ6Szs0yWyaqYKLlCtOnMCiaWtA7oOhtAt3w8QhoKJGdMAdLrlZ
 KJdsoPdjSQQzDdOp0QbhEHTDb5hYCghtog85NJh00bR81D9P3ohk7/IHktw4isCgeyKJ
 eITHhOLpxVUg6HAexuvD7X6NIWcFjJYJ7iib7IuubZLpbv6ITcw5hRd00G2Bdvk58XWS
 KMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774033948; x=1774638748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ux+DVa2N+/JaIwDNhsnggYM4bsW17uE79GBmRoiXmjI=;
 b=hn4KSaxjRyhD4xlZY8vSszP0l5gng4foH5j54wgXGKKoREzq9q7b5qN3eLzgU8Iqur
 DwqweCSlQe7ONuaRRRhn205R+hMzb5+5I/r4thzDmZUCzz3nS4hSe09cDVVwSaflr/H+
 0T21Qn0gw3NGuLjV+8iTJh/MgGqhLsrJKdloJFcX5untKQhw/IKvcSrdyVMFfhRYYMel
 44BJMA+7M5us05k5mpN1YbFfJzNoEksP5s/mi3oAkC6SOcnS01b9IJASmNXtS8JuFoS9
 7XsLzFSKRkCgI6jDuFR96pQHpNM9+Wyd/pFxb3l1nbFa9w+32V93/znj/aZ4gq7LiU9z
 Ga7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6hUnlGoM0YUlfGdbJL5Bk8N5Hu4UBNSO9OReQWlz3Y2s/VFk2ocm4Me62aCWv+mI+rs6qzNSExNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysCGUAV59ckdvPknl55M1D34ZCt3mX4RnQG0VjgkyqqsMu7658
 54RjQYi5UgIhMNM/EObCJ9w2VpYRMIoxPY6MOoMzfHDqpASl2Lsg1SGE5E6Se7Z4Mu6rEw==
X-Gm-Gg: ATEYQzzlf4iaqL+5uuMEdwlWJmXd4cQlaNxeADswNdYsANL1UGuajIFTCetQtXaVmXH
 1nkxZMDR794j9KlpAFEqmMFrAG5ueuBySoOzJICMU2vrUVthXaBGekdJVoeMiR2k1RYCXMv+VFp
 awDYXTk70JZ+2sJvMF+LzjTfqSc43cd8u22xT2szO2543O9TVVxEKhA4/eDfZ5tiouohZpZobHC
 izHpAjDNiilbtF5GliUXOT9vrJ1Yq2zg3OjVGWa5WVIK79xABRQSjQKhwVCZtmYMx1LL5/jHf/4
 mD+ChOPGAM8dSDojD1cwCF4x/3PdMOnP4Wh1V9EdIvafyhUQ697CSHtMUOkYsMRLZOjenQY1KSe
 YTsoAHi3jFH+fcEtGRdFk+vyU7hqf1+CYJyJHwyV60qvUaBxHyA/cmLVHM9ZNfjA8fbR06ZQStq
 tqOCQDU4YdUOhGd7ozl+AhPYRO7M0t6ANaIZ9E
X-Received: by 2002:a17:902:ef52:b0:2b0:663f:6b4b with SMTP id
 d9443c01a7336-2b0827054d4mr34682875ad.18.1774033948205; 
 Fri, 20 Mar 2026 12:12:28 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083688ca4sm39599915ad.67.2026.03.20.12.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 12:12:27 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 21 Mar 2026 03:12:11 +0800
Subject: [PATCH 2/2] drm/bridge: th1520-dw-hdmi: Fix remove() callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-th1520-v1-2-ec877197770d@gmail.com>
References: <20260321-th1520-v1-0-ec877197770d@gmail.com>
In-Reply-To: <20260321-th1520-v1-0-ec877197770d@gmail.com>
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Icenowy Zheng <uwu@icenowy.me>
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774033935; l=1195;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Iq/IF6LUudYr57iCsECUorrqheDDpz1NtopP1SQaLhI=;
 b=GX+DTp9uRhkW8/vmyR0grrfU+rSZbqh4XWzlbmadXi2TWUSN0llN144L4kkBfk70i1b317S+3
 2XHAcJkfyuMDz9PgvWt7KQzxoWiCgZ+TY3AUqycUY7w+DTZGVesfOAQ
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
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

This driver stores struct th1520_hdmi * in platform drvdata, but
th1520_dw_hdmi_remove() was reading it back as struct dw_hdmi *
and passing it to dw_hdmi_remove(), so teardown runs on the wrong
pointer.

Retrieve struct th1520_hdmi * from platform drvdata and pass
hdmi->dw_hdmi to dw_hdmi_remove().

Fixes: 96f30ee0fb9d ("drm/bridge: add a driver for T-Head TH1520 HDMI controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
index c9968ec1823c..6ec9003a8f3f 100644
--- a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
@@ -146,9 +146,9 @@ static int th1520_dw_hdmi_probe(struct platform_device *pdev)
 
 static void th1520_dw_hdmi_remove(struct platform_device *pdev)
 {
-	struct dw_hdmi *hdmi = platform_get_drvdata(pdev);
+	struct th1520_hdmi *hdmi = platform_get_drvdata(pdev);
 
-	dw_hdmi_remove(hdmi);
+	dw_hdmi_remove(hdmi->dw_hdmi);
 }
 
 static const struct of_device_id th1520_dw_hdmi_of_table[] = {

-- 
2.43.0

