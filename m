Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F78C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A6D10E54E;
	Wed,  8 Jul 2026 07:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EYXn8/r1";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF88610E54E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 07:34:33 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cac59f8b64so4602205ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783496073; x=1784100873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QYyfRzVZfVK7y35yaNbampPDVaTcx8NzqBZy7M6l9p8=;
 b=EYXn8/r1+KQC1rjJO2n4W3J1RwJyuR8ejCDSgTf+JHfkPABXktnVFqE18r4s6MMG5M
 nkY7MoxNejyC7eYvvo0LN89ZsSb08ELgXlScYUzSVs1XYQlP+zXBrtgGeGR5TW001Rtd
 bqFuGtnnTlslyZPd2HWK0pSp6LSk1GMPPyQ03yiDdTMs59UgDPktr5Xj5iydY+eneXEf
 LDGBmh3HdHlPnLT2tEMAwHlnkZzcCRILIJzQKpawmq30Y4HRRBEzK3bPtNGLOVjijqPF
 UqeHqGFW3r/wNQOPkdiUAJMZK8I8AoFllQQZznrEeFLVuLpEibL7N91JegC49i+gtLHf
 jrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783496073; x=1784100873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QYyfRzVZfVK7y35yaNbampPDVaTcx8NzqBZy7M6l9p8=;
 b=LCjCOwoKrMFi8WSS9zU9k4rTBr9MUrMj6MQIpwL++vIrxNRBGQamM/PDJA+biblsgq
 ZuyXl9GhB0dAw0pzEYbE7ybJJOE7pH7YOtlp2pinL9WXXi6ii/nmdcl1Alh0J2iFb7jZ
 uHN6Stp10cpF24D5QT+Dwz/DSsAzhFpZzVKH1leYG0PkbOF79kvUVPbEdQBlvhdXa6p7
 yxJU4AmwcnMMRfq7PRTNL5odUiG7jW1rDd5fyeDbw5RvapxBqcvyhj53Q/pGOLFFg93P
 Efn1Nq/iYgqIBBMRlB+etswAHXCd8mSNoL34ToOQTlyzO6TF9gqbwVK2a1yDuePVLFlc
 hXaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCYZ19Ib46GqHyAMQ3kpus9ObnIk3exCG4RoaJMReprBGsQ+4BlXW5pGPatmbJtsyUVaTzw+I2ZeQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7zbG0uYxLGgOvZw55k8am3CUV24ZDVhSEig+ka0fFfcNKBcvN
 XLsnIA26kRygRvLKsM3TUM3CWL0JPYhmY+CvG1X2o2Lh/YpcEfmZdCnB
X-Gm-Gg: AfdE7ck20aKxxuig0Erm6i5rN7Y+82tNK28A+4qoosxcOWUZE/0K+lObfa6ZiblPHo5
 7PoqqOP1cofcN3t0QfJd2L52DQPf8Sd9oweF5WFOKx4W1Y2kVnbUs7NY0Kapb7HqpQUaENRcPqJ
 prvC0czc8ZpATqCzzoIeCt6AhMtTxfVrMrig0pag8W2bmDdiJSU6vDzwUrdDwdKvl2T9HKSVByu
 c7QqkSl5D2W31ijlSA1PT8CzT3yk2PdM2iHbtkQ9hEnqgo6adKwVAUbJT36EQEca1KGj4co+h/h
 PDusYe4avyBGMZ5QdbtIrLNh2nLfKdS3BgiUmyu+LKYgzNDNFKTFe72nIdpjeqWWjIL2hLOvLB4
 eM6ejgoTQue97aLNZToBG7NCe5qMnLUnm7Ufq5HP18To+dYc6ZCNttqYdf3miAw/PuYDvuAjikq
 taXk8/KRiRGA==
X-Received: by 2002:a17:902:d4cf:b0:2c8:2808:3ec4 with SMTP id
 d9443c01a7336-2ccea37bd07mr14929815ad.24.1783496073389; 
 Wed, 08 Jul 2026 00:34:33 -0700 (PDT)
Received: from lgs.. ([101.76.249.46]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d952sm23359955ad.61.2026.07.08.00.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 00:34:32 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/xe: free madvise VMA array on L2 flush failure
Date: Wed,  8 Jul 2026 15:34:22 +0800
Message-ID: <20260708073422.725186-1-lgs201920130244@gmail.com>
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

xe_vm_madvise_ioctl() allocates madvise_range.vmas in get_vmas().
After get_vmas() succeeds with at least one VMA, error paths must go
through free_vmas so the array is released before the madvise details are
destroyed.

The L2 flush validation path added for PAT madvise rejects some
SVM/userptr ranges after get_vmas() has succeeded, but jumps directly to
madv_fini. This skips kfree(madvise_range.vmas), leaking the VMA array on
each failed ioctl.

Jump to free_vmas instead, matching the other validation failure paths
after get_vmas() has succeeded.

Fixes: 4f39a194d41e ("drm/xe/xe3p_lpg: Restrict UAPI to enable L2 flush optimization")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/xe/xe_vm_madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index c4fb29004195..246fe1843142 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -643,7 +643,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 				 xe_device_is_l2_flush_optimized(xe) &&
 				 (pat_index != 19 && coh_mode != XE_COH_2WAY))) {
 			err = -EINVAL;
-			goto madv_fini;
+			goto free_vmas;
 		}
 	}
 
-- 
2.43.0

