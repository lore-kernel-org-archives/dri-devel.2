Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5D5C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BFCE10F657;
	Thu,  3 Sep 2026 15:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SVNqPCzt";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B24B010E12F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 15:36:52 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-484362f5c4aso2594537f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788449811; x=1789054611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5PeuCRA06Huqx9DiMfiD4Wn1YaBSJ5Fbp/l63yenG8w=;
 b=SVNqPCzt01IxF81srCBtDrPjjoEsriBrHhqq9vU7NLLmTkVOewzPbzoMiNkA4daK97
 VdlQ8S2bkjYNY4YIyAl8c5I94xcO9DoXX4LvuK15ybe0xNmRQI1fvO5E4ba8NjyAfgYB
 XyAakSEOy71hIclrqa6A56RVR1NpFUal8Ra+iqP34Yig8+4uY7NVZIrbzCK5QQkpROIo
 pZgs4690xuU/GXHNTijhe7YNbAB/ZqUzQOYl1IkYYyp1NMHZrMhahIdzEQbyuMdgF3Hh
 m8iQS1tsZjLtcI3shkEeqYxC2Kq745qHKJJ9Ggk441QKTwNGgXMz9mB8nSTlyLWQk7kD
 pA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788449811; x=1789054611;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5PeuCRA06Huqx9DiMfiD4Wn1YaBSJ5Fbp/l63yenG8w=;
 b=Zied2XTQR0TXG/tR21jdTe/sXJymyFFk7iyfdpBUbBevsRjMtSk6WSjZNaYQfK0P2P
 fWnS010jr/dbOPrttLntXk0kDUJP61DzLJ0H9H72s/KLFJ2StARo1qvSgCTqhUAO3xpI
 BBWg+T0vMBe8/e5O9ByHgQvbkvWhC/Hy/tXod4JGsoBFJhTEYeO69Ch7Cmi+rCwPm/rk
 uN6Kq0TDX+le/rXxIue2aJj+qzH0mk3UZHlRXFcNUk/gFD++NHMrVSixdp5QaIdWoIOX
 HAk9f7RsLWddnVFue7hpzy8aupO4d0xLaBi6cuj+7MV8Ls0kI3Ig1DYjBasytxzLqnGD
 412w==
X-Forwarded-Encrypted: i=1;
 AKwUvByI/OAEmIpuCvaVx03VVZPaCdtH4tiKYhSQB4+89wh/2RjDSNzuBMgiJ+oFmeGQiuoj01fQzXHM/bU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mZJ1ra2BvctYiK0VtD9I2TkkjfWZIw8x6niOVfSfoIL/C/eYR0
 ALo7lls4Vg/HV6e95hiH0dSgGw61HGBN8m5ET519Qn5XP0lKbohxIuh2
X-Gm-Gg: AYBFou0ZI4YnmLjl0HKGhbOp4VB+jExzqIbovFmdxKdjRdpG1GRhDt0JnSxMLoO1iEf
 Mqkus7X8Gx0S8nR0FanQhePBYVrRvQKUtlp2tdgIGVEewsXBUHVBwiZfapPGfXlXFMxeJXgDd/Y
 wJrE6ydKTSvLC84SKwa9GHvTHSJrS+Mw3EFCqqPjnUqxegorfJWFTWcnE+H9c61wxCOtI/p8tgC
 dthn4zgsF/+vjN8iGLRXC8paMo/zCtMv2dUgVNkENAwdHxphhdqU0KPRN5i7WazFoDpa8/xU0Ql
 1IgLd0VeGap1iGp+6mAmr5mbvrDAMdDKGXJclURRY5aGxoS/4EDwmEIO4kuoLBFnnyzby5MWpKX
 558j7HBXpXuqR4pAOmsjO62Bh1qTcYqsy0JqtIsSACicq+fm2i6wxUU//buHn2r+TmKPAIjfNma
 vo8EXrFNh0KBay6NbFHoTX29nx6lCQjB1qwq4XFwBQGv+47SQAKDFZb1bp3U0=
X-Received: by 2002:a5d:5e88:0:b0:482:d900:6558 with SMTP id
 ffacd0b85a97d-48488e039d8mr26000819f8f.7.1788449810845; 
 Thu, 03 Sep 2026 08:36:50 -0700 (PDT)
Received: from localhost ([5.83.201.220]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80745sm14747772f8f.15.2026.09.03.08.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:36:50 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/connector: Fix spelling mistake "provded" ->
 "provided"
Date: Thu,  3 Sep 2026 16:34:47 +0100
Message-ID: <20260903153447.19371-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are two spelling mistakes in drm_err error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 8b4baed060f3..00b2eae89b4d 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2619,13 +2619,13 @@ static int drm_mode_create_colorspace_property(struct drm_connector *connector,
 		return 0;
 
 	if (!supported_colorspaces) {
-		drm_err(dev, "No supported colorspaces provded on [CONNECTOR:%d:%s]\n",
+		drm_err(dev, "No supported colorspaces provided on [CONNECTOR:%d:%s]\n",
 			    connector->base.id, connector->name);
 		return -EINVAL;
 	}
 
 	if ((supported_colorspaces & -BIT(DRM_MODE_COLORIMETRY_COUNT)) != 0) {
-		drm_err(dev, "Unknown colorspace provded on [CONNECTOR:%d:%s]\n",
+		drm_err(dev, "Unknown colorspace provided on [CONNECTOR:%d:%s]\n",
 			    connector->base.id, connector->name);
 		return -EINVAL;
 	}
-- 
2.55.0

