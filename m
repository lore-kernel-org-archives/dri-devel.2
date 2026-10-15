Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7D4CC6B1C
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7612F10E9E8;
	Thu, 15 Oct 2026 03:49:03 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E9F10EB4F
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:48:57 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-35ef6b49813so878843eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792036136; x=1792640936; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bHwaGza7cuC1DwPWlcczvb1/bCiut7wJK6RNVUwiwMw=;
 b=rkgI7kPAacGdXH7S9wGFlPdln+AZE0o4vfNfMuudSSHRerH4D9W7eot88WiKFmLzGK
 E3Wr7pRbViKy1H465IZ3T4B/iqqu9fL1Pyap1BEuUDGehSv6vTNgQ/fUN6CjCfMnniNQ
 h/baqz2M5HPQQ47NzsootWGAE8bUDu6+r9xBFUT6L5yonKb/9Hev34Rlk7PyAa9mLqxu
 mGM6FnhPqULcr6+ckusXAiui7so+7PESI8xfvw0iN4KejTRBMCISsZ5HX9FezafiY58H
 tJ++tDJ0+9B2jxmlLsvzm1PZX/VrRk0GtLk8R0+Cqk6v6qDXpf0kn3CmMqn1j+PNjrOd
 jCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792036136; x=1792640936;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bHwaGza7cuC1DwPWlcczvb1/bCiut7wJK6RNVUwiwMw=;
 b=2snjqQmpVIZTU5pNJh4DFBSOfvO7CJGgc30vaYMozouA0kbU3f0FVA8k9yQXfe+Q0l
 GP/OHtZx7tPolY0BRqXVtIuUxFr/2cf3tB58KMDMMp3DyhGwVKIC6fvCvaOT5x5pfRET
 E+cO9DJ1sEfLQNoj/AV1GNbw3kZkfFSO3q3nMLIFLZoKwdqr0S/CcY4Bfgteykd/OCRw
 MEhicRZxWHKNus16sjCKhkw6gkHySA89Et+ts6sD1T7EGeqfhEYNcbbGgq3oBG8tRfeg
 L8+CPZqeAoXVjcR2eCSJ2ww0e1WKRIh8CyHbcADRc12bJuLFYBPXtreusEH7qjQkiA7P
 uFDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXn8XU32pzzGziohlYhP9XvPT1fOkPZbbqW1Qyc2AqH83HsWcRXrRHBMn+OO6eVt5yIcLr8UrvwoM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLVs/XZz5/uM+mo1zJ8huMXrU1kyelsiWVROYO0tVPEZwBhdT4T
 Bj0RUWXjN3YkK/xb08bBP0fHsYLfqFAbMEo3HPQCnHrwAo1gJNkKaExv
X-Gm-Gg: AYBFou0OiGFw4V/dC8xPdr8lGmPrqyHUHpfC6kyesEHg351RzEihkBUNg2PN3CQpctD
 LtpbRu6hm36NPDSdqulCv9MpmG2C3iiHHWGBIzzo2ye6ml7INM723ceqUYsNW/OoayVLE33URwD
 1tP52jo28WfhTG1lRXu9kj9HrAcyMgMG+g8yqSS5Zk0MmerXcffpCSONZKqkED9qkGqVFFJ79Pz
 yFGMK3TmWKbi3FwDx0HqZTAHMXJ/YXI5UGVe2JB0ywQLwRy208yhlgiSqE7P33qhjMCPZx2TX4Z
 M6tDvnirB3tzTd42nv0pbq438ZxIkVg4UWlTQ9XYybyc2DfY7rJVCavvi6WyyiiO7MQ2vGq4MwF
 Xv8cP/Iu+qwbO93ZrrXXxZeGML9P/6MecGZGCZ2khJTC1ScI3T7jPTfCKSYuYF4Zyz85Qc/KMxH
 bJmh4168+MRsulKt714k3Io9ChY+vKd9AbzfT1mYLSdPDUuT8HPvCH3cZvxTkpVyPo9LM=
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-3537df95584mr31174866eec.16.1792036135797; 
 Wed, 14 Oct 2026 20:48:55 -0700 (PDT)
Received: from [127.0.1.1] ([115.88.114.131]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm64703088eec.3.2026.10.14.20.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:48:54 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 15 Oct 2026 12:48:27 +0900
Subject: [PATCH] drm/imagination: Update sgt_offset kerneldoc in
 pvr_mmu_op_context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pvr-mmu-sgt-offset-doc-v1-1-aab9ba54b5a4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAApN0GoC/x3MPQqAMAxA4atIZgOpaBWvIg7+pJpBK40WQby7x
 fEb3ntAOQgrtNkDgaOo+D3B5BlM67AvjDInQ0GFNWQqPGLAbbtQlxO9c8onzn5C09A42JKYags
 pPgI7uf9x17/vB/JuInZoAAAA
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.13.0
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

Update the @sgt_offset struct member description missed by
commit 789f290b2e81 ("drm/imagination: Size page table preallocation by
device address").

Suggested-by: Alessio Belle <alessio.belle@imgtec.com>
Link: https://lore.kernel.org/r/64b915fe3c794567a04c955fa89184204e3b9552.camel@imgtec.com/
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 3cac482e1034..6b43ea4c7f63 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -1412,7 +1412,7 @@ struct pvr_mmu_op_context {
 		 */
 		struct sg_table *sgt;
 
-		/** @sgt_offset: Start address of the device-virtual mapping. */
+		/** @sgt_offset: Offset into @sgt of the start of the mapping. */
 		u64 sgt_offset;
 
 		/**

---
base-commit: 489a8539ca6f347102c1334c2f08198abacc86c8
change-id: 20261015-pvr-mmu-sgt-offset-doc-180ba640e076

Best regards,
-- 
Gyeyoung Baek <gye976@gmail.com>

