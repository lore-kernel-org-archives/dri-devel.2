Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB89CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35E1895C1;
	Fri, 26 Jun 2026 11:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qb47BMg3";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3E410E34E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 11:29:05 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c1226a0971bso77358466b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782473344; x=1783078144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LhgdMS5TXgKcR8QoNKupqhHAfY6bdNKf0RyWHL3p3Ao=;
 b=Qb47BMg3DB7B/NeVHbovaa62uSwfiDLSx9hhVR7T9NRKnzHuL9Sbfob9/LELiHntO1
 sX172AfmV+kpbECuyUpIiwHE7W1Y/9YL8KuqnFBrE95snsE3wsLl30nBtP65fVrvKbdK
 1QPClWtKRDUE8ljXAEkC2CFhRj/8zkFa7MwDyZzh0Fi98y4CY8lppnkZZ1b2f1xkO/AM
 PjxOBSzdCuIB+6Dboy5FYAK8eRNo+hLqqZ4upFCTfYGDNKPoA9NWeh6bM4B3q82U1iDq
 T08S4/S5e+u0hto0nm4c+QcCB9zzx3OwFMkAWH5eho6jZHkdzPFmXPYHQjWp6euDk8qO
 y2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782473344; x=1783078144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhgdMS5TXgKcR8QoNKupqhHAfY6bdNKf0RyWHL3p3Ao=;
 b=VCgMHodPGOz8ZOjFaBx6M0jWIYJZXHs2DcGurMpU05mNKMCCsLHeFrAzpzvf9hNv00
 pq1KNQMAwxQ5fRgqYIUG2/BbT0rHPoJnGrdtwHDWlfQKIF+n89RXm7MNAsRa5dVowE0J
 Rxc/mtZNsAHtUt70jHmEh2m/zebhaqr6my8T5aerQiGKqyT/ht1lld6ef4SISH5ipZuJ
 +0U32kbyP8iHdoQFUvJqRoj/U0MnSIPgFT9lJzVHnqmEd+NgCABpAvqub8P0ztbmC8va
 a7Aa3AlGRkRsMvhti3Pk8VNpEiOArxsuIEfpFZ559Cwmndc9fvaSAhFO+YH5webhLP+I
 aUTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roz56bG4nmwn1yl3kSZbD7kKMjb5B2Qdj0CPrekgnzUTcOT28FaRvE0Z/qOh2ZygWuHIgQ84wBIllU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVJM6maWqKQQu/9fWCNYaEli+CpDbHQyiEMbVOfnL47aeQZPUR
 OkEGPy7gSN/FlLwwX63+8YJrqj/QniD2t11gL/YF41RQQXEHvkYo+nsL
X-Gm-Gg: AfdE7cmtmy7TnpOK//1/lKxrlIUHU6f/gYLb3+ytMf5fQ5EKtYvQyucBmhQTamVityC
 kK7wCJYnrcemRfZtppI4zRNTRhbuhFTaCyp33ARwPHqK9NXKYisJYwVbJr1QlkyLZdldhwrM20/
 El4lxL43P6O7OfaxzaUeMR2M6imXZAPp04BtYQkpGQY2oIS2SgnJwF8ib8DX0cqHs52yHPwtkEe
 ugkQGm5eZE898CXjl3RRnfDxlgcj4zKBJMa7AZaPS9Vp4xw4ah/M6gSbiSg2WdRqHkIxdf+iAai
 CKyf5p27ryWTSCKIxlpfYMztsyQSPzRk/dwYzmd6jgT2CIZq4OoSkaI7P4c6/qzGbsX3y0wKmRc
 NcmJvOk1Njw8zae95mmQPs9GW+NCSY6i6GYoKmvtRJVMDrkEO6jEYaQKdtCzv1FSh9acF//+ZbI
 +LwH+7xou3gPSZgjIUhF9aacLb0hz88hWh1oizlFNg4XUcSrVO5deR2NMT4wtNDmZACiJD+d5Lu
 SEgPOwDV3tj4sIaOHJlxAw6KOynhjg14REmQtliRMBC
X-Received: by 2002:a17:907:3c8b:b0:c12:f85:bea4 with SMTP id
 a640c23a62f3a-c120f85cbb7mr361613666b.47.1782473343510; 
 Fri, 26 Jun 2026 04:29:03 -0700 (PDT)
Received: from fedora ([154.66.167.183]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c122176f39csm88811566b.21.2026.06.26.04.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 04:29:03 -0700 (PDT)
From: aquiles <achillezongo07@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 aquiles <achillezongo07@gmail.com>
Subject: [PATCH 1/2] drm/xe: count UMA shrinkable BOs as reclaimable without
 swap
Date: Fri, 26 Jun 2026 11:26:37 +0000
Message-ID: <20260626112638.2042298-1-achillezongo07@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 11:59:24 +0000
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

On integrated (UMA) devices all GPU buffer objects reside in system RAM.
xe_shrinker_count() previously gated shrinkable (non-purgeable) page
counts on ttm_backup_bytes_avail(), so those pages were invisible to
the kernel's memory reclaim on systems without swap configured.

On UMA, shrinkable system-memory BOs can be reclaimed independently of
swap availability. Report them unconditionally so the shrinker can
always request their eviction under memory pressure.

Signed-off-by: aquiles <achillezongo07@gmail.com>
---
 drivers/gpu/drm/xe/xe_shrinker.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 83374cd57..3ca2de342 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -140,16 +140,22 @@ xe_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct xe_shrinker *shrinker = to_xe_shrinker(shrink);
 	unsigned long num_pages;
+	long uma_reclaimable_pages;
 	bool can_backup = !!(sc->gfp_mask & __GFP_FS);
+	bool is_uma = !IS_DGFX(shrinker->xe);
 
 	num_pages = ttm_backup_bytes_avail() >> PAGE_SHIFT;
 	read_lock(&shrinker->lock);
 
+	uma_reclaimable_pages = is_uma ? shrinker->shrinkable_pages : 0;
+
 	if (can_backup)
-		num_pages = min_t(unsigned long, num_pages, shrinker->shrinkable_pages);
+		num_pages = min_t(unsigned long, num_pages,
+				  shrinker->shrinkable_pages - uma_reclaimable_pages);
 	else
 		num_pages = 0;
 
+	num_pages += uma_reclaimable_pages;
 	num_pages += shrinker->purgeable_pages;
 	read_unlock(&shrinker->lock);
 
-- 
2.54.0

