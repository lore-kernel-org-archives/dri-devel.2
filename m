Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263D7C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8DE10E9EA;
	Sun, 13 Sep 2026 20:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AD0xn0QZ";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF0410E5A9
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 06:30:26 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e65b1cc29so6848425e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789194624; x=1789799424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jFix9ue4kazbG44bcHfnwQtuSA55kubKr06mMHl278s=;
 b=AD0xn0QZYFe0dokDkiSo6D15lGC2snlQnV6/USU/84GJyK8Ab5BDtLBAZ3QqNlbSXD
 doh5G1bIodgkEaeSqtMJcNrweCNTTbcHKOhwVsYJpQhXwU48ZM8J5P0v6PMYijEZ+jRK
 rQxh/jEckLc6tKQ0HnTCGHQuC6+tjdci0jmvRTrFa8RvEXKnvD7iuAZ37gM9Zc/QA8hE
 ICaKmtkOKTguIWHm3X+xMDL+azhapFPookCAl9Zh8zI5sj2j1erJ24WQOiOEzUdMGXRZ
 /dnj4c9uub6hBxLkHV4OB23wVdsSU2qh32RFZmvqFf01D8dJ8pKByqnnrwQW3vE8BIMr
 LjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194624; x=1789799424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jFix9ue4kazbG44bcHfnwQtuSA55kubKr06mMHl278s=;
 b=ar3DSHV6HUEeZFIVMCCEitgFl1KcMxT4YfYzSfxZajYDGPA0nyP4AtpXImwIvqqHf+
 RsIVs1dqJkYOHte6tgdiiQMp9V2R/SDODSfm1cjiN+b9aMMMd4WIaqxOLlzWn4Noo3z+
 BdnzZyD4t7FtO7S9ns2B2EiA6tO5ytZsYe2soFCvVGsjRxV34rqswDVd6+oEIISS9jGQ
 YFhK3Y8V5NSK6oiPzVw5FMS747ChAM6CvGS9SzF/pmbe7ES6Wlune/DyLb4/22BCbkQW
 pa4ybtmjpHAwXIzdYM+RNlyzC9t5vZo27jOdA7B8jzbUHxyWGWmWxPzbJr/mjXe4orJH
 jSHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVC5k4vWtHFwDv+yPQuJ3EN0l7BSq5q/OhxLi7jWYBXRjCGw3vrcGcEFcEp78tE4wUzHxZS5BfyyM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mmccJx80RhPitNcrEFWx54mCoVlyabZtwCOTFIJ++jU32EVlTE
 JDXnScxsWtaA1zb5htelTeNkFoVf60QolDmeh++lqsMczrmtnYQf7woD
X-Gm-Gg: AYBFou3iRxlvljf0099f4/kwULFMH8CDCzy7yJYaqX7VnQnIxiKsBX5bCMPVlu4is8P
 vPuV7v3ulnPXDLH0GbUcwU4+aHIDzaVhpIQXuJEawDOv12stUzhWeWbrBnONx3rDMupNVy01/U+
 AT1j/pmYGCRlbLidXThfem/prR86uPcn9Pmb2MFbrDzx3FaGxqcWCAkEqgDE0GGDmYOLdKvsv8h
 e6i1yuabUih0FmcNoGP2KpyFCMzu5XIDiKLj0z5pTaxyUD9s/CGKB1NNCscaN8s4JKCrO4y4jiL
 Xn6Lf3Ooyqi8w7UCpL7L+IiuB2wDtCN+K8ugMNW8HB/HJBQeEA2WqKmHoNox8BSvyxNhZgXPo7O
 lqxBvYFuqDk5m1PxvVhrs/h2UFJjQ/RPiUuhPWRL7qHZfDHU85h1H+3o5It6DjySjriMncCehZn
 XMm1h+4dPGAwS6yQVTA8z7zi5n5cOj9YjA+kp8ZS45k109mVVK5Uu+u8wJ2q+aEbURo9hC7yghe
 Okkvkz330HVN13KS2p9NlC1N5zUmiyFANmynmJjphaLBk5wO63zmwsTdCP6vV5f2QJ1Uo+Rn4Ff
 V1tsVxnF8nK39foJ0h53C+ZfX9QQjwmIgC8o/wyKHCRPeD71nrCx7stJBZdRBO7FHSBYaorAC0x
 aBQ==
X-Received: by 2002:a05:600c:19c8:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49e619f3ae1mr160612545e9.10.1789194624288; 
 Fri, 11 Sep 2026 23:30:24 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de.
 [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm187527915e9.13.2026.09.11.23.30.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Sep 2026 23:30:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 Sarah Walker <sarah.walker@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imagination: Fix PowerVR UAPI constant references in
 kernel-doc
Date: Sat, 12 Sep 2026 08:30:21 +0200
Message-Id: <20260912063021.43076-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The PowerVR UAPI comments contain misspellings of the enhancement query
selector, two buffer object flags, and the job submission ioctl. The
correct names were already present in the UAPI definitions when these
comments were introduced.

Use DRM_PVR_DEV_QUERY_ENHANCEMENTS_GET, DRM_PVR_BO_PM_FW_PROTECT,
DRM_PVR_BO_ALLOW_CPU_USERSPACE_ACCESS, and DRM_IOCTL_PVR_SUBMIT_JOBS in
the corresponding comments.

Fixes: 1088d89e5515 ("drm/imagination/uapi: Add PowerVR driver UAPI")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/uapi/drm/pvr_drm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index ccf6c2112468f3f53b093bc298dac2bbbfd35e6e..d97a69b83cc59338b7aae306e4dfa1320f071a2d 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -231,7 +231,7 @@ struct drm_pvr_dev_query_quirks {
  * the user mode driver.
  *
  * When fetching this type &struct drm_pvr_ioctl_dev_query_args.type must be set
- * to %DRM_PVR_DEV_ENHANCEMENTS_GET.
+ * to %DRM_PVR_DEV_QUERY_ENHANCEMENTS_GET.
  */
 struct drm_pvr_dev_query_enhancements {
 	/**
@@ -848,8 +848,8 @@ struct drm_pvr_ioctl_create_free_list_args {
 	 * @max_num_pages * ``sizeof(__u32)``.
 	 *
 	 * The buffer object must have been created with
-	 * %DRM_PVR_BO_DEVICE_PM_FW_PROTECT set and
-	 * %DRM_PVR_BO_CPU_ALLOW_USERSPACE_ACCESS not set.
+	 * %DRM_PVR_BO_PM_FW_PROTECT set and
+	 * %DRM_PVR_BO_ALLOW_CPU_USERSPACE_ACCESS not set.
 	 */
 	__u64 free_list_gpu_addr;
 
@@ -1277,7 +1277,7 @@ struct drm_pvr_job {
 };
 
 /**
- * struct drm_pvr_ioctl_submit_jobs_args - Arguments for %DRM_IOCTL_PVR_SUBMIT_JOB
+ * struct drm_pvr_ioctl_submit_jobs_args - Arguments for %DRM_IOCTL_PVR_SUBMIT_JOBS
  *
  * If the syscall returns an error it is important to check the value of
  * @jobs.count. This indicates the index into @jobs.array where the
-- 
2.39.5 (Apple Git-154)

