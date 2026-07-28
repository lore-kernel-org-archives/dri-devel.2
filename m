Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D042C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBF810E5C6;
	Tue, 28 Jul 2026 16:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sJGA21GP";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C876C10E5C6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 16:56:21 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so1805265ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785257781; x=1785862581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j+4klrRFig0PGwHGsDr8CnTLSp9SLq5VsHOMKnbKx9s=;
 b=sJGA21GPFHmGRHv//cn3I0CUL8oRFIz/r5EFxwRXAsbDRE9K974HXFbjYKXr3pzgal
 7eDTqouE1ksqVF78WflDzuwQ/Uhez8H+4IU84/7O+bpmIIUoq00BI1LecNhWOgPtTCGV
 Ie4tB+SRSs/dyt55rS8ODwenLKeU94LjZ417UXfR3kzAT5b3mV04jwIWcBrPqaX0kWc8
 h6EBDGuG0zbU7Wi5v8C77yNHvSs0zlBYNsLMft5PuaR3d/79PLOXiPr3neslavJxJKf2
 3V/RmZuj3Pb6hHz4Keo5HeNQOaIrYZPLhw+5hPW8RFsyJIr4Nyt8AyKtvvH9KcBCg+7e
 Vd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785257781; x=1785862581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j+4klrRFig0PGwHGsDr8CnTLSp9SLq5VsHOMKnbKx9s=;
 b=eCyFTxBTxlgv9LLDC1+74BlJ0CCHzI250MuA84vbAUhnvpqaBYNy7uxhVUYijIUq2h
 ZtpN48Dx/+4iZOJaDpLo13Zj6lsRp+eenTWu9xjStJTKKtsi+7cSMPofwUaSTdnZnVPz
 96WA6wYaEZ3DCvHwU29hcg+zOQ5LotyBUPquI0Q4JFgkVv3xzj6ZtE8yA1m7ZDStPuRy
 YqligxE0US4etGpZM2gHStmgutIP5uCEMazIn6VUS6k4o9IlyyMBqkabi1Mqi8QMqqkr
 vKjqBNjZ/439fpF6ZxnVCVh64ysr0lx6md3dc6W6VRgFhzVNDsIGaQBxlZFT8A5yv6oC
 RI/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RorbwLuGs6lXx0i+T9mIZxJ9xl+i6IhYfxjwWKgqhfWiGFEezUKivBwysQicCpe9+hjUWWqcg7jtGY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygnJBErkPOvElpVCHAnXfKs3e2UAFGt6MmkNsNVZpg0elSmqaC
 RhIk6d0eRMYhHzwzPrRc3YwB3Y5n4DvV38YoPQjkMnllRMh0Lx4I+VM=
X-Gm-Gg: AR+sD100ICHrfxEo9J9SrXgkagR2IQLwEhyCVXjAtnpuXbsstNDkcaY+jTrk193HvD5
 fFBp8GtbLPJNzoZe2o44r8OEvFxy5iWgaD9SABogltDepW4s9yKo7hIAo6OZ4lNHZ5fPImyLmtR
 eqtgsrNsO34164EfyWD76On/z6ftiJWtp+3sm2j8ruO/jkoQX26pxBcNdvcOa96GlhWpIetAGFK
 Z3i1A1CPa7kLkBtu+wS84YkA1ixG+WNbRPgyfwSKLoI1rrt+Ui2Why56KCHJvFaR3UvEuJ5rf+u
 sBLBYA5fo1Sn82M4WdYzazjhNgQl3+NUNMwvlZD2kyLtJ37R05gjiI9hnqT30nYbYL7hPeYuQLh
 TLbAPfpNDI7uLUZjooq5yzg3y8hqSsqVv/jUerho2JrldT1NgbY1llQpNbq5tQHKI0D2aVxXd+O
 y9wOhzRD9eijbUg5uKLS9SuwyILoew230akKvHxlogQ/XyDFsBY4xVP6L7wmtc8GcuKhbgcvihT
 CWaBlAsH9vpyZNF0PvyB4/sWchv0gsTPakhOPCZ
X-Received: by 2002:a17:903:390d:b0:2c9:ff83:41fa with SMTP id
 d9443c01a7336-2d015ee24d7mr36695345ad.24.1785257781202; 
 Tue, 28 Jul 2026 09:56:21 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfe1ab9c71sm51112215ad.73.2026.07.28.09.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 09:56:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thierry Reding <treding@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/sti: dvo: Remove bridge on attach failure
Date: Wed, 29 Jul 2026 01:55:59 +0900
Message-ID: <20260728165614.25847-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
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

drm_bridge_add() registers the bridge globally and takes a reference.
If the subsequent drm_bridge_attach() call fails, the component bind
callback returns without being considered bound, so its unbind callback is
not called. This leaves the bridge registered and its reference held.

Remove the bridge before returning the attach error.

Fixes: 384764c36116 ("drm/sti: fixup for bridge interface")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/sti/sti_dvo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index 7484d3c3f4..4978e0acbf 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -459,8 +459,10 @@ static int sti_dvo_bind(struct device *dev, struct device *master, void *data)
 	drm_bridge_add(&dvo->bridge);
 
 	err = drm_bridge_attach(encoder, &dvo->bridge, NULL, 0);
-	if (err)
+	if (err) {
+		drm_bridge_remove(&dvo->bridge);
 		return err;
+	}
 
 	connector->encoder = encoder;
 	dvo->encoder = encoder;
-- 
2.47.1
