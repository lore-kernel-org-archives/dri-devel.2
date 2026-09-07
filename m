Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F04C79FA7
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76F110E66B;
	Mon,  7 Sep 2026 07:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F1w1B0yE";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDF210E076
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 01:11:39 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso2003334f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 18:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788743497; x=1789348297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vr8PmeVhyI3ZYfvfVlrbRbCnB619Pqu+cER6pTinMdw=;
 b=F1w1B0yETqDemwtAsYgNxSLfCZiawW1w3yT62CxW0BbmSrD1YWz3l5u0UJCLsZTgVl
 XdYl69Edw05nwrxq8gyvZvHc2EVIKrTLqIN2e82T+52359V3dlNUT4ownfOGVtKaKIMe
 7g3L+NbfI2gXdgn/nP9S60CKuwyIWyfx88YUxU63/NZrB29TYqBRfbJu02f4nXZAag+5
 ndQWo8ZtsShcXJYxZIlhul6yBi9ePocBPMyX9SnPn6rX+2p0lXJXsj+2ZlFFBRo4cF9A
 KS/xZmdzRic1esJfFjR40CFEyzvDFWgffJw8RDkTuVqR99QlclH5mA0JONnzEZKcT4ZI
 st3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788743497; x=1789348297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vr8PmeVhyI3ZYfvfVlrbRbCnB619Pqu+cER6pTinMdw=;
 b=RQehEKhocrCE8HOzjRElLp3QCsNIAX7RWB9SRENMGIckyz3PFywpHAW/a9M7rgdk8Z
 6jBs+WOJ7bFJiGuJEBWvP3/auC/57H2/lao72F7BIUtCxMn9FpM37mu/AboYlm47Sp+g
 zvftLrvfDJsvv4oWfhEirQNwVP4WMQj06maomsKy7UuCrCgA7P2pv46ye9G1S32hx9fp
 EUvtYQflpoAxv0sMfK3Yaq+jVehaG+ivAkCbJD0z+IFLtcNCFPdhM/ABElT7jKSCtDLw
 GEVdlxjhjWKbS4Ly8a/ZVnMmEpQS+3dqyP50Loq6y011eFOl+P8+XpHtjgbts+Tqp7hU
 Schw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlTwnKXDlphgWJyROJxgV787bP8EhrbixDTGBWqWhDZWvf0Nh//6mRzkBhSPAsNmOln7PLeI171RY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mw/cZTtU8xGr9C6r6h9w7wjzuXHgpXRXkeaKo6MrVST9wiu+5g
 NrpEJFxvf/riXpnK/RkAK/FYTgA188F6n1Pk2Z8eh86MH25cFElthZAI
X-Gm-Gg: AYBFou39RlBXAvjiEKbQEiQ3Wlx0xMXDIi5Ges7yx0Jaw7WJzK9/VeGQwNj02yDFcEG
 j13no5MelCc4R2/Im0uYBwXXU+v6RZ4qBbv8VfYckLOTFf5zJDeV10DY8o9zdX6bW5RR2xLnfsR
 o7tAWbbH21wjga+0H6+YK9zZIjIfgEWEc75bxU4oOSxxtqwoCqvI8B2rVp2ej18X+/Y8dBNKTcI
 tdaiihIuQ2jKqzSRv5Zz5zvN2exSkfufqa/znEkzO/M/lCWiocwtGlahEsy3Ky4StgMaD5kWwAT
 dsUBbKmZLW5rRlTF78Uz9yUOSlcJzFB9qYIFDpI/On4eAkOX7wSDS6rhN8SkiNEssXDoWFq5u4q
 3sF75Ob1CsZXyJldqD8NalgTST9Lh2csEVkX6zIKbSnXRJVR+EEs7QuLuyoN/AS8cbscsllJCpH
 2IdYgj7LwCM0sugeqr6nFAWorFAFLdmqtQQ23EkMdWrLiLoZI5+Yrw3KxN2BVFboQqRNBftFabw
 1/JlrFh7s57mI+DQzLQCUHilYO5dClv1d0y7PBm0z+aIRLKfb2cyIVmFSmODGyb5/mcyQgzihhy
 R/O7+0gFHzPls1wvF4SPCIEQAfp0S9t4CmQ9KeDw1tL0o8ovoViqbmVCbqY7y7lCVi0=
X-Received: by 2002:a05:6000:1845:b0:485:8a46:b3ca with SMTP id
 ffacd0b85a97d-4858a46b614mr19737250f8f.50.1788743497432; 
 Sun, 06 Sep 2026 18:11:37 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de.
 [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm25071771f8f.1.2026.09.06.18.11.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 06 Sep 2026 18:11:35 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH] drm/exec: Match the drm_exec_retry() kernel-doc to its
 parameter name
Date: Mon,  7 Sep 2026 03:11:27 +0200
Message-Id: <20260907011127.19653-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

Commit bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec
retry pointer") added drm_exec_retry() as a macro whose parameter is
_exec, with a kernel-doc that says @exec, so kernel-doc reports both an
excess and a missing parameter on every docs build.

Say @_exec.

Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/drm/drm_exec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index cc2937185a9f..ae1d074ade5a 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -150,7 +150,7 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
 
 /**
  * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
- * @exec: drm_exec object
+ * @_exec: drm_exec object
  *
  * Unconditionally retry the loop to lock all objects. For consistency,
  * the exec object needs to be newly initialized.
-- 
2.53.0

