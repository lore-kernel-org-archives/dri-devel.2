Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512C8C44501
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3386E10E7B8;
	Mon,  6 Jul 2026 07:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ARq3/pFG";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993B310E184
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 11:02:48 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-385b78b44a0so108183a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783249368; x=1783854168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Oquh24DvrkOPCF2fJclrR7ZjjQ1IhHgVpf5JxW1uNE=;
 b=ARq3/pFGBrn4w2bTu1BGzPhyi8sv2OIcYn3dpIGDfeG7AGsqJB7LhTdPXTbXAaBjoD
 jBH5unNtXdcRacmt44DBnkPhprJp+N1WgXkOIQYccEQ9+/hxryeICF3yL+3PGqgv4Xet
 x6JeAyGIFp1fxYiYfjdnmBzMO2Wxlg9uoGpd2QVTlEAbPlfsMhjR3iAvgUvkm4MiTObY
 ITHJW9YlNPJEbwrWSZ6HNp2REZOpGD4e7mpV0gwZZ3OICnxBXO8aU1onKG0bwvIvvfLU
 iNDo55tI+ipgXlyO7xt6FR7vXEM+oMGyS6vkKmbMWSqAP+83/egapn0PZUJ+Ydv9+4uq
 IDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783249368; x=1783854168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Oquh24DvrkOPCF2fJclrR7ZjjQ1IhHgVpf5JxW1uNE=;
 b=X+MEXrNkbaE0a8inbrxWXoyho8tkgr5atnzB0b6MDgkHJe/so/hET0xC2v/LMeZhsm
 HkzCvuROdwuyCnbUDVfnXZpdC5EKzuMNDsvRrNlj5LaUm8kkqZqNitUOuQWh9RZ4mCxx
 PBoluw+s1THL22wiCzvFUYKYG633N62pJh358IIUkeF7DjlegvmLzSqc9D8YR/FX0ScC
 wU7KU/Vzfy+bKnG2bQ5YbjUWaEg1j5jloUGnJq/5YrmLzgYHLR/1fvNVpRwdL2n8bMZo
 gk7Y03/Rh/gc4i7NZS3al/y6N2aheCaIlrmDsITM9YvcL641B1h2NawSRNuq7a6AExSI
 sOkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbMrO2xKbvk5xEPQAc1vZf5x8um9edBLrVox2uTC34A1agQ27aKg3TnNWoxR55JHo6Om4l6GNJATs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygkVtVKxICpiw4QRvUy833qTyCX6kvrnnOvhqoGyMFIZ+SC85d
 dKzgarCcb55T7FqO55aOS30mi0k7Bwt3CAdbFwFd2qbdxm1oYWZvbjfX
X-Gm-Gg: AfdE7ckPKw/fg1boqIIJgEddU7M6gMkK4NbdbdgD2km+ifvt34vtlhVkwPOWWEKTwAH
 cs2hjzQbFAUXQw33B4uCE4iY39LWfPr9Yr50czSJieGwwxr0E1myWIqCRoIBBiZSvv8ee+YhDBS
 ZzNTzBSor0vsMQmh9lvYRjL/mnZE8XG364U1RrKubtAMK2dhprbFyn2Z18iIqHiWzIUC2oGNSpI
 3cQg9VX4+Xsbhm7/+qhKrmlXynxZ4i2ISaynLahe6rl3yjVIJl56EfMDALbu4ZI8vG4NCtCCf6t
 5AsfowV+B7ZIlsMLU3YyvJ7FlYLjwWYg3ON1iFTiQfqOzsjiqWr4iYwngyiZ+/AIzm0JmXON/27
 O3lk+AOEJE+eQlQd2rv86xGTTwfkHg+aBo//mVN23REkNwTpeht6dIJdBF8sILDCpq6xct4OzVk
 4iy7GRzTMqs3k=
X-Received: by 2002:a17:90b:2886:b0:368:d839:28d5 with SMTP id
 98e67ed59e1d1-3829f0074b6mr6040067a91.18.1783249367936; 
 Sun, 05 Jul 2026 04:02:47 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:8312:822e:57c6:3816])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm25067156eec.24.2026.07.05.04.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 04:02:47 -0700 (PDT)
From: mdshahid03@gmail.com
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] drm/exynos: vidi: use memdup_user() instead of kmalloc() and
 copy_from_user()
Date: Sun,  5 Jul 2026 16:32:21 +0530
Message-ID: <20260705110221.153481-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:13:14 +0000
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

From: Mohammad Shahid <mdshahid03@gmail.com>

Use memdup_user() to replace the open-coded kmalloc() and
copy_from_user() sequence.

This simplifies the code while preserving the existing behavior.

This issue was reported by memdup_user.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 67bbf9b8bc0e..183671de711e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -273,14 +273,9 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 		size = (hdr.extensions + 1) * EDID_LENGTH;
 
-		edid_buf = kmalloc(size, GFP_KERNEL);
-		if (!edid_buf)
-			return -ENOMEM;
-
-		if (copy_from_user(edid_buf, edid_userptr, size)) {
-			kfree(edid_buf);
-			return -EFAULT;
-		}
+		edid_buf = memdup_user(edid_userptr, size);
+		if (IS_ERR(edid_buf))
+			return PTR_ERR(edid_buf);
 
 		drm_edid = drm_edid_alloc(edid_buf, size);
 		kfree(edid_buf);
-- 
2.43.0

