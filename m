Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C21CCD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B2FF10E1F2;
	Wed, 20 May 2026 18:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="slfeOfpd";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D9810E1F2;
 Wed, 20 May 2026 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=RyWxtH1/ym5Scs6j6R6+ja3HRW1+Sc5PWwhd8Jygnnk=; b=slfeOfpdtRIWL98VSRTUS/YESW
 N7ML2I0DQ6Rw3UQPxS+ccTemYvxn2/Q4AmOWfm/Y2dOXKfz/IbcrlJnTcDp0zvGtrdoiu85TxTtcg
 aPa9YOFkAGmDbPFDStEQVd/zHqmKaQKMNoBydMmzdMFLm6QLImpRJxftJMwTBLC7a3OKsXWAm1hZ2
 qw3Om4P7VRKmZ8O/ggnvKV5H4gPEdLqZN4A8naII0Ypcf4kqKlV64OopQJeaDktsXFZd/sho+6W0z
 7vUqG2Jibte+wxwuew4aqMPh8pO/uMlSnYooOH0gt75bByOFsF39AkET1RRrDpOWEb3seNZySz1C2
 hkNpbo4g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wPlnH-00000005SbS-0gZO; Wed, 20 May 2026 18:37:23 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Tom Chung <chiahsuan.chung@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>, Ray Wu <ray.wu@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix kernel-doc warnings
Date: Wed, 20 May 2026 11:37:19 -0700
Message-ID: <20260520183721.279669-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a kernel-doc comment for @power_module and use the correct name
for @boot_time_crc_info to eliminate kernel-doc warnings:

WARNING: ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 struct
 member 'power_module' not described in 'amdgpu_display_manager'
WARNING: ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 struct
 member 'boot_time_crc_info' not described in 'amdgpu_display_manager'
WARNING: ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 Excess
 struct member 'dm_boot_time_crc_info' description in 'amdgpu_display_manager'

Fixes: b034c5b0d831 ("drm/amd/display: Add a buffer for boot time crc")
Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Chuanyu Tseng <chuanyu.tseng@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20260520.orig/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ linux-next-20260520/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -330,6 +330,7 @@ struct hpd_rx_irq_offload_work {
  * @backlight_link: Link on which to control backlight
  * @backlight_caps: Capabilities of the backlight device
  * @freesync_module: Module handling freesync calculations
+ * @power_module: Manages replay, PSR, and backlight control functionality
  * @hdcp_workqueue: AMDGPU content protection queue
  * @fw_dmcu: Reference to DMCU firmware
  * @dmcu_fw_version: Version of the DMCU firmware
@@ -708,7 +709,7 @@ struct amdgpu_display_manager {
 	} fused_io[8];
 
 	/**
-	 * @dm_boot_time_crc_info:
+	 * @boot_time_crc_info:
 	 *
 	 * Buffer info for the boot time crc.
 	 */
