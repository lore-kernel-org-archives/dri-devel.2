Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF64CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 11:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4D110E0F8;
	Sun, 21 Jun 2026 11:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.b="ZYLfMU1y";
	dkim-atps=neutral
X-Greylist: delayed 583 seconds by postgrey-1.36 at gabe;
 Sat, 20 Jun 2026 18:43:18 UTC
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD6B10E241;
 Sat, 20 Jun 2026 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [92.101.187.100])
 by mail.ispras.ru (Postfix) with ESMTPSA id 4009845F8512;
 Sat, 20 Jun 2026 18:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4009845F8512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1781980412;
 bh=qXy+NLcJzRFPRD8Y5EvNnkvkyS1foFBp4Z16GCRLFuA=;
 h=From:To:Cc:Subject:Date:From;
 b=ZYLfMU1yxgXtz6UdSasH6n/VwtMZ5zR7ykToYOv56mWONIWqCd4ejZH8MrgiY4fi8
 aY4rROaUx1xr44qif5pantaqAU4zuRHPOOJyVEU+fJvS5yJxPNqziR7rUyX7JhaQAr
 KgUIn93OpxUPrvePaDpVcnaXNH3fjm7VnRyX7GlA=
From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH] drm/radeon: Add NULL pointer check for enc_priv in
 atombios_set_encoder_crtc_source()
Date: Sat, 20 Jun 2026 21:31:45 +0300
Message-ID: <20260620183150.1248791-1-a.velichayshiy@ispras.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jun 2026 11:39:32 +0000
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

The dig pointer for radeon_encoder->enc_priv is initialized in
radeon_add_atom_encoder(). An error during initialization may
leave radeon_encoder->enc_priv as NULL, leading to a NULL
pointer dereference in atombios_set_encoder_crtc_source().
Add a NULL pointer check for dig before dereferencing it,
returning early if it is NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f28cf33945cc ("drm/kms/radeon: pick digitial encoders smarter. (v3)")
Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
---
 drivers/gpu/drm/radeon/atombios_encoders.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 5cfd8fcfa5e8..8b15c1e0d41f 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -1931,6 +1931,8 @@ atombios_set_encoder_crtc_source(struct drm_encoder *encoder)
 			case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
 			case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_LVTMA:
 				dig = radeon_encoder->enc_priv;
+				if (!dig)
+					return;
 				switch (dig->dig_encoder) {
 				case 0:
 					args.v2.ucEncoderID = ASIC_INT_DIG1_ENCODER_ID;
-- 
2.43.0

