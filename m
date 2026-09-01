Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A68CC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E646F10EBB8;
	Tue,  1 Sep 2026 07:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qnlJIsdp";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEDB10E149
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 05:02:49 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cc1cb472b76so3973914a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788238969; x=1788843769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9yUuR/WSkjmDZYldjCLyDwNxnmnt2IjU3AxaHKK9h1A=;
 b=qnlJIsdpEVmJhI+OmNasyOxhH/JSsHxvclJbqdMc7e8iJ4d6iNhXZ+dIcYJtn0XZew
 ye+0pjLpXzOVsg9DJ2gDOoupfXzV1xnODVi64Xq5Z4Cr/+7jQjeVXoI2W0uX1GvQcJjq
 vV6h1c0lpwAdLXDtRxlz308Ff34CIqTwNzkrnRwoxPiESarECC8yY9HPXLZVcHgtrN7x
 dEHNbGzCQfypcozx4XvfMVL4Q7wEOpCPGd6NbLcOs1CYdDtqH91SSuOKu6mKa7D18edz
 Rms3OEDT7Tzp4i8cI1KmmJYmJGBBxtHfCVqA1SqQqTz8cNEMfeUk+onSyzIQQJliUL3m
 hliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788238969; x=1788843769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9yUuR/WSkjmDZYldjCLyDwNxnmnt2IjU3AxaHKK9h1A=;
 b=oViGLFbZHEo5OMxoGdvhDREXTv6xQlhL5LgQU4/znAfTrGFuIb0OeEB9gkaOMI8LEL
 JFmy7mYcQrzQbxvRhnHDGoRktNrR1vILcSPr6mq7T5f9S2VlJR7qwgmkgtv4+cBzCVDL
 oH0XzlSrESJBMx5ZEiV3ozJmxRcBSvrZ1/tpagWn+7WRdipDJbgDCJFbl0FBn6EiLxPQ
 sFCLJ0n/qkhkU5zjYHiZ0RyLe925qw8LlfZwC3J5NR1u36nL039pD5xeb5KsLupoxJBa
 uYLqDvac/BTrjyEvjZ4Izca0pxhoujKPiPtaVJ57Fm5l2Y4KzLxWHl17w7LH/A12qkyo
 LwIg==
X-Forwarded-Encrypted: i=1;
 AKwUvByko7et5NTWYzPjA6l9zU38CDdu35w/1uvbPHweqrAquWWuOe6BDh+qyMdvls3KbgayNBnpcZZySSs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mo7sT/erog9TnSf8jGitXGaJxNo+bCREKm14ErmqQVxJA22+Df
 7jvzGZwsG5/zatNgxQgo3FPcQ8uz/toAPHLyJ1UtYjTh5g2PUZj1GQWq
X-Gm-Gg: AYBFou0/fhqguM7qfvGnOvzT7/5zTMpSG7ENOPx1JI7hZ0hbL/Igwr7AWJtsMABtPB/
 NSQx1lXem+iJ73wfBsQjSdrUs95Stxth1BnB9LFNtkAwCnf/IV1nYs3/f800GmHJPTDfwbT5rvA
 /1NZYa9Co9prlz19U0qE4yKNsLg26A1PhswqcAAWF7pldjRs+yN1AJzFzT0ZNdeAJ69bXbrORcf
 WW1XUy2dIXRsvo+CjxA/S7dUiQp9ywSSAQ5smcOUMHUhK7v9a3snjwBq6fYb9VZKGsEMzk27AG1
 chaD+1CkZ3LcyPt7RiBHa6zXecmxdO+Dt0RYfR/TBHBCEXTtTVabGGRUrla8YVSzGHNg96PgatH
 gENfSSAv0EPvh/1IC9Bqj8dzEILge/RCKqA+2i35T8XR5gMnhCmYmvONRhJwFdJ4qzBphNVjlFo
 ht2n+3SScwyCb6mOR/qb/PN7xzrtnJlEWPwByYFCUQMfh6RGKXa9+54NjwdAbWDvkjIyA0
X-Received: by 2002:a17:90b:3c83:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-3989bd54c84mr34387219a91.18.1788238969089; 
 Mon, 31 Aug 2026 22:02:49 -0700 (PDT)
Received: from i386.168.1.127 ([2402:a00:163:2ce9:6882:91b7:8e79:7958])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0bf8a13sm49404128c88.0.2026.08.31.22.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 22:02:48 -0700 (PDT)
From: Hrushiraj Gandhi <hrushirajg23@gmail.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Hrushiraj Gandhi <hrushirajg23@gmail.com>
Subject: [PATCH] drm/i915/gvt: use strscpy() instead of strcpy() in
 virt_vbt_generation()
Date: Tue,  1 Sep 2026 10:32:41 +0530
Message-ID: <20260901050241.359490-1-hrushirajg23@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

strcpy() has no bound on the destination buffer, so convert this to
the bounded, always-NUL-terminating strscpy() instead. The literal
"BIOS_DATA_BLOCK" (15 chars + NUL) fits the 16-byte signature field
exactly, so this is a no-op change in behaviour.

No functional change.

Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
---
 drivers/gpu/drm/i915/gvt/opregion.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index d6e76ba31d60..f2527e26cd1e 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -151,7 +151,8 @@ static void virt_vbt_generation(struct vbt *v)
 	v->header.vbt_size = sizeof(struct vbt);
 	v->header.bdb_offset = offsetof(struct vbt, bdb_header);
 
-	strcpy(&v->bdb_header.signature[0], "BIOS_DATA_BLOCK");
+	strscpy(v->bdb_header.signature, "BIOS_DATA_BLOCK",
+		sizeof(v->bdb_header.signature));
 	v->bdb_header.version = 186; /* child_dev_size = 33 */
 	v->bdb_header.header_size = sizeof(v->bdb_header);
 
