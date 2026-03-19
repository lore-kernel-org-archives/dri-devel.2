Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5819109024C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD9810E974;
	Thu, 19 Mar 2026 16:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m/5PznFP";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A1510EA19
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:12:12 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-673ee2a98b1so697753eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773936731; x=1774541531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3c0/WUM3lqcj72j9Vu/khlvCspZNHbv2J0Y1IrCBba4=;
 b=m/5PznFPHv+0XffXK8UVWkwknt/zIVoOCM9Kk0S+ZR43VLXpPGw2cUecPXn7M4XbLh
 2BR401nFv/G8rzQi7afF2MnwaylYMkKSrpxPwYmedkL5Ggxp2kAnlWHPAzjBCd+eu2W8
 GDiFVXvR8tO71HW5GOVRfvv2jAF/dfgyaU1N4/zv99T/csIkuBfGZsnBEaLPbRN5uNQB
 RB2TFRuJ0SEm6l+7yvA7CAMHR2VrxCa454cNo7ku0nr3H0YhaiVqOQr7U82wi54BF1rf
 GURUosxfoIxUEbFpAK2yC3dvulj/bAn9A9IvYvgLsEWHIrtasB4bI/LGv6vWeIg0HYKY
 f5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773936731; x=1774541531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3c0/WUM3lqcj72j9Vu/khlvCspZNHbv2J0Y1IrCBba4=;
 b=OGpkahwaHUSncc2LMpfPqprgEQ+TuYNZKdQRzPJtKGnrbamTN3T8MshC9RDhOnKgam
 o6HBJ/FaRwioMn0tPvXxuwEm/WWHsRheEsrx08i8t3EHdygOTmpvUzdgxz13PPZ1VOiN
 JTAte7Dv07wxsd1SmWJzKTB09FpgqysygnJQcFFGTLATYFvd5hwQWgk4pNjF8BXUVcFW
 0zU+JkJ3z1f5LabI7V5B6IV8FdtDPzMggTpmBrdpPUgbMrLpm/wK3e4Y45eG6J0BCoGv
 mc7bZdccElRUPlkIuTRqrwnM9trbhF5L/Y2aCyrSuedNnCvm9w5UGmfTINjvgwrfj+9w
 oSng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4VoigY43icZCeOF+ulR7eWUxcRw23S84yeYrIvkGl7Rf0EwNAj3clXeIzRN226p6XQOfOhtXW2kQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgMUeZ2Aw22/siPMCk24BBsX4DIn54DPGlLM9m+CyUiwd6gG3Y
 NRM9oSUjnqjxBU9t6x1d5mP0Sjh/23esKAPqhiLf21U6ub4/ebZercDP
X-Gm-Gg: ATEYQzyCp1KbrLd7elHmmc9JcqBFy+fHfjsq0KHmeEHkC7Kcom+eLZ/p8H819GeBH8E
 OD3fW+09yRBZeafGN+5x0mg9iyRTdeniVs31h24nvU7LMILJ2OLL4Bw0/rNtzpYc+Gwo7Ww2Lq+
 ozBaQRSENndK61gAgRvtAlZK95I4TxkNRbJ5aMFF1eOnc1wthEUKYJ1zMC7/SjcIJ8VSd2Wm8Dn
 O8FSZ3PWoFyN98iiJYoXKGBEBhl3fj7bSljYhDjeOUmgKohlEsROc2V5g7qYgP9Din9NCzvVxyP
 wmSmlYI4kuRcmllfHXGB+Rr5kywlYwNGeD47rqzng5skpdP6UuITMDiJcwpWItDhaptrzCqi5pa
 EmlnJjMoW6vZnDhfyJGw9PnftOhO8foAbsQYPMUeFIirMuam/9l/2Tz7mV4eaLrTjlLgms9RC/m
 lQ8ooVuvr6MDriRpBXdLMXkik04VQyo5FEsDBbfBQ8VVrJyYrH
X-Received: by 2002:a05:6820:4de9:b0:67b:e4a1:9e5a with SMTP id
 006d021491bc7-67c22ef420bmr32984eaf.19.1773936731022; 
 Thu, 19 Mar 2026 09:12:11 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 006d021491bc7-67c0d89c99bsm3608538eaf.14.2026.03.19.09.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:12:10 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: helen.fornazier@gmail.com, vignesh.raman@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/1] drm/ci: bump IGT version to v2.3
Date: Thu, 19 Mar 2026 10:11:59 -0600
Message-ID: <20260319161159.1149822-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
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

IGT_VERSION is currently pinned to a sha thats ~1100 behind HEAD

Lets bump it to the latest milestone/tag at v2.3
Thats now only ~630 behind.
Can we haz a v2.4 ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 56638814bb28..d546bd123a63 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -5,7 +5,7 @@ variables:
   UPSTREAM_REPO: https://gitlab.freedesktop.org/drm/kernel.git
   TARGET_BRANCH: drm-next
 
-  IGT_VERSION: 129d5b10baaadea1d6cd6377341c4cb42e7ee6fd
+  IGT_VERSION: v2.3
 
   DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/mesa/deqp-runner.git
   DEQP_RUNNER_GIT_TAG: v0.20.0
-- 
2.53.0

