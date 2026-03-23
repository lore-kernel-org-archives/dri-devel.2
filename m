Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286D1EC01A2
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75F810E420;
	Mon, 23 Mar 2026 08:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bI1oAxzL";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C054110E40C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 08:11:38 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so2711266f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774253497; x=1774858297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=R+RcLIqxzcPo2XQ6hMPPxrLdxL36I/8Iq9farKGO7eg=;
 b=bI1oAxzLS70jlqGm1N+Wz/hZJKVCOsiO57+qNNha+uBxbclY3IbrBcE7elp9LgwQTv
 JyHXR1hSYXvlk2tvpan26AS0KrLUKY3aJo6GBNZMu1WPHdgPYG219H5qcln3DdjYRJMS
 AFxOzBqhqOYP5T/KCpWvx7wc3MrnRra8BsaGcJzTFoLYH8f5Nt5b3CIa682PyvcjQRDa
 6N6Ty7iv+wUNZXtEWKcYL9WYvrfXdyMvxhpEoN5UehsFo3G7qWM22jECsRv2VTVovoP/
 OtpBt166JVTmoEFqXzoJlMCGxrXwLvlNh8xba/fm/PDj9gMTQGPSz52gk2yMIDuzGCgD
 3t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774253497; x=1774858297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+RcLIqxzcPo2XQ6hMPPxrLdxL36I/8Iq9farKGO7eg=;
 b=neyvTmGdTagKZtuVkwpdGHnOXOUdDzqklSzjN7O3GyRD6mtPaLOWTQk4W9SYGfDqcE
 xzDUp9vVNuElBLODH44bZzhUAFJwQ9SvJOH9NfLlrrlWgOPgQTQ21aortmkCavtfNijy
 boTZESlSdciszm8ijari7kSUmEbE4Evpgo9/jmGU4Jb6WB82X9I+CF3D37G4zh0Wi4Iv
 zk2SLg0VR/Vz7fEO0E9IW0j/E7odBLaZ0mUPPrTZkVxHccFZiBDmy+fYlwUNlbkEqKAU
 sLPEQUmn5gIGx8kpBIRSCRA+BzewRfBZB2KrcUA951w4aQJiJVevDS7zb3J/ru5MrZx7
 jh/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdRfD5BGTHgFVrABIlot5qN0oYSGRbrOnko6LB+dY7S4N9V4vvm9U8VQ+ts8yfuynOO8E6dPUb/nc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/tD+lAOl6zJImezRuRZCk4geGcx/02UD9u5zLxH97+RVx+HiA
 iyuA8xYQtNxoiErXRoYxCykLCvj2Xv1RLhhHqp3HC/zYHlAQiJHNu0H2
X-Gm-Gg: ATEYQzxwI+A+x4HMiqZELtEFQybhYFBK1CXcu0suugZZDNC+YC5l+ev31g1BjKzSabA
 KeNEw3acdcyENj41uEUKEx28pgJ+1KyYdGjOdow8f/Da4qeyfu08wu85OwrAU/eZi71Sq5KzQby
 lxj7D9NLyNIiA6aj0jQ1Dlixp2Pn46ZAhPdhxWw5ssthW427aY8vPaW3sICevhMzmAHg6Pagt5D
 V9G/4UzvkyqG/Hli5Km6Ebstxwk93ND/JOeXrbUQNKwV45MzikQHxTdCWaapSLPa2CMq6m4L7GV
 bVSEiui7PimctYcO2WhZJ7teuICZox/ZtiI7JwvCau0zGZw8oIBgYxMRREw9PevDzJE05jG+RBq
 HFaAAg5fiQujPVN3kcdkoauMNOy0Cqs5n7Zt2ZeUfNYHIFA0v15sFG9tMcf6YvaU0PVUbOFDuxg
 B8zsA6s2D2WiEaeF3LYsOTmDjrTkg=
X-Received: by 2002:a05:6000:4203:b0:439:d750:42e3 with SMTP id
 ffacd0b85a97d-43b6427576fmr17384853f8f.25.1774253496992; 
 Mon, 23 Mar 2026 01:11:36 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae016sm26355039f8f.4.2026.03.23.01.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 01:11:36 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: correct firmware related messages
Date: Mon, 23 Mar 2026 08:11:32 +0000
Message-ID: <20260323081132.3217646-1-christianshewitt@gmail.com>
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

Some English language corrections to firmware messages. No
functional changes.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index a64ec8756bed..349bb6b0e7bf 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -580,7 +580,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 
 	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
 		drm_warn(&ptdev->base,
-			 "Firmware protected mode entry not be supported, ignoring");
+			 "Firmware protected mode entry is not supported, ignoring");
 		return 0;
 	}
 
@@ -749,7 +749,7 @@ static int panthor_fw_load_entry(struct panthor_device *ptdev,
 
 	if ((iter->offset % sizeof(u32)) ||
 	    (CSF_FW_BINARY_ENTRY_SIZE(ehdr) % sizeof(u32))) {
-		drm_err(&ptdev->base, "Firmware entry isn't 32 bit aligned, offset=0x%x size=0x%x\n",
+		drm_err(&ptdev->base, "Firmware entry is not 32-bit aligned, offset=0x%x size=0x%x\n",
 			(u32)(iter->offset - sizeof(u32)), CSF_FW_BINARY_ENTRY_SIZE(ehdr));
 		return -EINVAL;
 	}
-- 
2.43.0

