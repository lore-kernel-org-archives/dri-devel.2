Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292BFCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 05:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA2A10E2E1;
	Fri,  8 May 2026 05:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m02Zt4Wz";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B6B10E2E1
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 05:21:14 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3664abf20f5so365902a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 22:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778217674; x=1778822474; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xCkIDeOyP4KM5t1o/lKb0daBHuqvkylgQbtw6G+k/MU=;
 b=m02Zt4WzgX+b5w1r5IkNROtGs9Z191uZOPTGfybLTRRRMeJ0TYVU7SMNpG8lejiwCd
 a/MYvBmPK1zsepHsZGV+TbcR9WNWthrgZ8IF89YncqZKVwqbFeBOt17rfVdiaWdqew+Y
 dbI8tYFQ+gao49J/gG8A+tw7CWbCn0cdqxVW1Xd6tlVtIEgdblF9j5s4242ZlZ5VDj6e
 3GrC4AvjRHWJF3BqA75AkZ2mPOeny1G9/s30rxve0GLTzSahzCDGAQ+O/dY53J5cEgiB
 qXNYjXamrPm25RtT8nHIdcpu4qoJH21o+tUkn1gXb0xtPLBywBp2SmuVB4d5ywOn0GRW
 spiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778217674; x=1778822474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCkIDeOyP4KM5t1o/lKb0daBHuqvkylgQbtw6G+k/MU=;
 b=ZFc3KviIEI33cm/fH0sb9yV5jvFXAQ4ZMPaMmclMLDphu+2Od514naRuyxrz54ccwB
 LdFVWVUHM152FlS8IUcan3qyCM0xJTUdULr5MQvLsZpwk6HUvNHRLOW6yc6OwJ93jXG0
 rfJcHjY/EJVyU1y3y997utlZlZOuVIplB5nENDt58E2KA34pE4zJZJlDeF/CPwSgWYFt
 1rglSKFdYTqcyayyf7iD9/gS7Slhq9+QhZBMX8ygNaOX9TsNESYXYe+IPG7Bi+cX9C/n
 9SzmAjWBFNBiwS6iGCOfMq0bKmGNVZjfVAAXfKf4rF2c1uE036TWrY711zm2EniTZTNO
 PtoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dtHKfTv/eGd8XF8zfMMDJjtOCvWh24/vQP+Cvw4Dy61kZvpMJ8k6F805xgfGNXwyo/cDLjJjRiog=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOxvKBSpXhbAPkP8OTp61Z4bDGdB7YL1DtJW/eCMrLKZ7yaUKi
 dK0WP46qNOgwvGXAsaLN5MzZpYsmz1DRJnU/cseTyA1HoaaDZi8rza5s
X-Gm-Gg: Acq92OGVY78aQvxB8s7IdHO0DKTDfnLkqz8nJU1ywfVAtMyKllwf8GU5bTL5dcET9nH
 opgzDuJQTXrTV7Fs1iSSjXdrIf92RrfzeF1+TmjW5lOVS6qO6RIJCq2oG/ufp5Jdw/jpyRnjl3P
 x/kxa5zYf58g2DmfhWL9Wdir8UQaOTspvw1mLWnt38RAixujWv8UtMjk2ndUmYXsapO0J/8jieS
 Z9fRhx9DvhaXBg8K5++vliFMo2o/ikC/u+mGPFaj31Qaq7vFD9ViJgqUzxZd2lIAgKbE8JR3HMp
 mKWD+AtLJAn5smmM8yE3xVBVuXlLEPl4gKLJkgNLL172u8KUmJ0cxgxJZqaaJwXCJxZbJhqJa6j
 txlVFN/hv7bcCvvsOwIftMU6tm0+CHycbsNEiFQDSXO/QSMd1QnotRcbLVcMNLjtjEFs6x/M9I+
 +kF7B4Pu4Q1Bnez/szuLc19idtE4IfMzdOrls/V+7Vqv7RVh1e7bRS7lFcFk1yLHVS/NU9C/oAx
 z/MyiWumOkOPiSjTAJI9aG382nocqZ45b0=
X-Received: by 2002:a17:90b:2248:b0:35f:b348:63e with SMTP id
 98e67ed59e1d1-365abbe373cmr11193012a91.9.1778217674186; 
 Thu, 07 May 2026 22:21:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3664db05828sm714910a91.12.2026.05.07.22.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 22:21:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
 GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/gsp: Use kzalloc_flex() for r535 display funcs
Date: Thu,  7 May 2026 22:20:56 -0700
Message-ID: <20260508052056.1744665-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

struct nvkm_disp_func ends with the user flexible array member. Allocate the
r535 display function table with kzalloc_flex() instead of open-coding the
size calculation with sizeof().

This makes the allocation describe the object being allocated directly and
keeps the fixed six user entries unchanged.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 6e63df816d85..1155f079b0c3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1734,7 +1734,8 @@ r535_disp_new(const struct nvkm_disp_func *hw, struct nvkm_device *device,
 	struct nvkm_disp_func *rm;
 	int ret;
 
-	if (!(rm = kzalloc(sizeof(*rm) + 6 * sizeof(rm->user[0]), GFP_KERNEL)))
+	rm = kzalloc_flex(*rm, user, 6);
+	if (!rm)
 		return -ENOMEM;
 
 	rm->dtor = r535_disp_dtor;
-- 
2.54.0

