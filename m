Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C5DC5DF74
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B5510E2FB;
	Sun, 16 Aug 2026 14:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iE70PVO6";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11B410E0F8
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 16:44:03 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cc891373e0so26978765ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786812243; x=1787417043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3VN4xZ3Op1b1omL9ErnQwlmSHW9OrraRQaNnvp6WcmE=;
 b=iE70PVO69RVDi1sGDrc2hXWMYVRD7QMocl/TS2mz7CIF2mmXrzQJLADpOFk4pQgOLJ
 OLqaoXDVtSfM7ytnQxfJTMCtICUNclRH6TiRpCNAA0Ljfr94PhvpiI5uGE+utosYVoqy
 17goZ2Fi6Lb0smSdgV5cvQnPe66Ykq5Ex7KE5xzeYDaFu7rkfn8xulQBuU3lFZSV4dTE
 9F8K3otLKYWfXzO6cKMNRfbDYSUKW3KzbHCinw/XsDPVmMBCxU8QR4Tl9O7WufP0QEAy
 56A9kCGR3ZoblrNb1skYkKor+KlfLrsQmCUL8Q6jYK92Jx+ZJhOns/2MajcFRw1pWSby
 hwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786812243; x=1787417043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VN4xZ3Op1b1omL9ErnQwlmSHW9OrraRQaNnvp6WcmE=;
 b=CRaxaQB+eoO/3IbAdjO8b3H0IgkiSGVOm7UTbc5fvdcyBlsFQY22WawKuYyTqCLA4+
 TULbnASuH9DETeY/mJ5zSD6jm9tDk+Re3Tm9LQPsLlg9FnvPIDybUS1CPmifhCZ76xHm
 4ryBVrVZG8CL+4lhI1pRDOIxwWPd051MzgyIssLWY/tirbvTV3hL3Cu8UuJfs5R3ufG0
 Bti0LrosLHByq/QMTF2pV4/FOVgKXO6gIVmy/APJIygcStqxZVCeHgrnWyGJK79WrXhD
 QV2zx1tXk8GPhoRCm5peYHR2+hSeFDlYFfQsZ4xZZ07UoWIki3XM5EwnF9Dm5FmQZC2G
 6eHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoY9UDq7zKkns1oqSzfOOLT1r3BgwQwnmu2oX6zKsEiq6vXFEw/QF181NdkpqhIXVuKgzj5f+BKKfA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGF1YovmE6XRHCKM9jwVWdxzpTALJHGrk41PtqB3kVzZIt72os
 evSaeXRdRXrU1rW1tehkB3pciBZ4a3gUqEGUZeCHtE65dSaRCBuUggYtzXUtTBuL
X-Gm-Gg: AR+sD12DNXjUWiB6ShR/kzeKGAXpKaeyDFIn0jyN3UOoF0zAX1UZFwumoyPrpJO4qrM
 bVOj1mqh71B0GfaxUKgo7gGGaMagBG/vYSxCMiBm69JIWol2QwsCEnm3y4U7JKW2b2PHVJNhIeo
 iE2rgXIAlG9131q4Psr3EJ+68hCE4yffzzOQ2Q5fL42NlgseC18YaXFiLCgOM3ZR3bZDHYvzCKI
 7HobC1cUV6FBV7ZyD+UM0ABZc6B/yjhS932N3l+dgbB/9OHYXccMVTIX4BrFAkumjrLAilFq+gx
 PL9g9b+qikeelp71MVGRpuL4loAPV6ACgoTW+ULpAh1ygRs7s8HzLTz0uQDLAF4T+NQbBQ/3E3d
 Xbhh7J66EJPEyVmPQLmO35KimlfxhBuaTQDwKu78cJwOreVI5tSYC59UY3DO7di01DXCSMpBUWD
 LWjM1pCBDpECIQdX/cPvStFK4louqk7G6KmR/ChicHZhcG9ENLIQ5klMnp6bDKMdrkjFEOPCivn
 mf9j/2NXgDOP+Y4TapT/N27
X-Received: by 2002:a05:6a20:9143:b0:3bf:6856:d8fb with SMTP id
 adf61e73a8af0-3cc7203428cmr13172808637.29.1786812243271; 
 Sat, 15 Aug 2026 09:44:03 -0700 (PDT)
Received: from OMEN ([103.148.21.25]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387c56aesm20406417c88.4.2026.08.15.09.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 09:44:02 -0700 (PDT)
From: George Emmanuel Thomas <georgeemmanuelthomas@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 George Emmanuel Thomas <georgeemmanuelthomas@gmail.com>
Subject: [PATCH] drm/msm: remove stale perf counter XML TODO
Date: Sat, 15 Aug 2026 22:13:35 +0530
Message-ID: <20260815164335.158958-1-georgeemmanuelthomas@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

The adreno_perfcntrs macro already takes the XML file stem as its second
argument, allowing each perf counter JSON file to select the appropriate
register XML. The a2xx and a5xx entries already pass their respective
XML file stems.

Remove the stale TODO comment.

Signed-off-by: George Emmanuel Thomas <georgeemmanuelthomas@gmail.com>
---
 drivers/gpu/drm/msm/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index d0c3a4c6703b..0b8f2cafed19 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -177,7 +177,6 @@ quiet_cmd_headergen = GENHDR  $@
       cmd_headergen = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
 		      $(headergen-opts) --rnn $(src)/registers --xml $< c-defines > $@
 
-# TODO how to do this for a2xx/a5xx which have different .xml arg?
 quiet_cmd_headergen_json = GENHDRJSN  $@
       cmd_headergen_json = mkdir -p $(obj)/generated && $(PYTHON3) $(src)/registers/gen_header.py \
 		      $(headergen-opts) --rnn $(src)/registers --xml $(filter %.xml,$^) perfcntrs --json $< > $@
-- 
2.53.0

