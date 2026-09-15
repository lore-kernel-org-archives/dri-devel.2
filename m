Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49E0C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF7B610F993;
	Tue, 15 Sep 2026 07:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXRIKr0/";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F83E10F7F7
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 00:54:34 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c25085f2426so47224666b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789433673; x=1790038473; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hWZ4Y4zJql57aJqzMLFBZaa2Td+FuNKRPfVlv/bP7Sk=;
 b=CXRIKr0/ZmMDrS73QRqW4KiweIpOB79NuQakt8Xw2/Mc1qoym3pK1rd1W61GFrN4LV
 JHk0eA2GLD8O4KmVCHA1Nw9o5Xmatsr6lMODE+P9kjbILQDKcECPZ9bX/bQFnTRXQIYb
 e/3hB+90wZ0D99D81uVpXwjrsNfvuYb7JD6GsDuJeeud/h3l7YnSrhfaQ2hDW9TocA/A
 JfZwQNvQX922M76nyqM02hwHL2WRsgTugiWBUbfjfHtPj75hzo1N8XHMqK+W0ra99giw
 cUUTdVPchPLxh3aiJj89cO5n6H/Q2B1bMmrJCiYV6NjJKKxYoIp/krSE1TMsnr7jjhKs
 WYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433673; x=1790038473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWZ4Y4zJql57aJqzMLFBZaa2Td+FuNKRPfVlv/bP7Sk=;
 b=zL3IOQ27Oie70FuOOyIGDMOnSDFzn1dsvl1szVzUjaq0VvI0dw3Inm4hutBfFNmKn8
 OG+gTonKTb/dFjrbBvUoLrfmEGuVe1zuSe76r+OyiBnkST9rm1xtNKLDMAMimZD0ft54
 575AnksVHLQA4w4+vE3xc7iCRS6HxgXEVXXD0flt0sfIebfrkn5+ZLmOMcUMXQ8MBW/Y
 v6mXXma++ymxZExKEe9HiJQIZaIKUTPZC492Y0+rJI9arQkF3ceWL5T3NUNIBFEf8WOF
 1N61UoJ5B/O1Ky7BqPfZJzAE7nyAVg5gP7k/zrLOsQlp2Ce1YBOVvfGnPCj/bYr7A+H3
 Qc5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7OPJnqma1qEa87z+NJrQf2volWXDC/7p7DpDZv8U3Ocjyqz/rRuZfRjLpHRIcgxmlHVrUdLN6Me8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5EU/ytp1MmYQmI2mWvTq20Q/WufbZYjBXC/bZGq8D6B7v1koo
 AFhUvNMCLjtC5IaJ3BCVaqnP4+VJBvSAr14ooFWN0r4+GffzY5irPOJf
X-Gm-Gg: AYBFou1mFGf9xPUtq7hZogxduvgjgT65JK0cN7Sm6o4i4ed1WNt9Tl3WyNS65sFxdzb
 4Gd5009L7TpKsIztYr7c0Zc9MPUEc1L+LNn85GQuHe5eFKGaFurIjo07T8p0brDiuSf/2hasifw
 7eaDAozCpFHbhaYLC2cC7uBLaemGeDIN9AQHSNSzkp5yLBmwwdtRuCtRz4sMGusLHGivDgkERSM
 shY2nqGG4yDm9NnNFRAvz/pw8rJ9I+3Sn004b3cufmKBCtt1Cch1rEOL40onz5Npqd90rS8F9oY
 7QZuV5xu1Oo6URwGBOxV1PzwAnQd5e0a0i8sLBs8E5g2tdmWg8CqELPbKnFfKFmx8StqVlA6rOV
 mMLKwkJyu1Y8nSC8tMfcKJaLMtADeVSSDOy809ckoQg6m1ifej6/LQPz3FB1rMgqeYYmCRCzYOv
 Ae//CKThWBbrEpGRvsJTrOFntSG0KqRPQzZwFVCDxIQmluoX0lGrXCBMzCE8RwOhCLrf5aNlhm4
 mVQk7AGSTGISrHwHao=
X-Received: by 2002:a17:907:9491:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c29b881e271mr346326166b.4.1789433672479; 
 Mon, 14 Sep 2026 17:54:32 -0700 (PDT)
Received: from Nuel20.localdomain ([105.113.65.85])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29660ead67sm501097966b.51.2026.09.14.17.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:54:32 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, bhawanpreet.lakha@amd.com,
 Wayne.Lin@amd.com, ivan.lipski@amd.com, matthew.schwartz@linux.dev,
 Jerry.Zuo@amd.com, chiahsuan.chung@amd.com, emmaonana18@gmail.com,
 chen-yu.chen@amd.com, skhan@linuxfoundation.org, me@brighamcampbell.com
Subject: [PATCH] drm/amd/display: fix kernel-doc warnings for
 amdgpu_display_manager
Date: Tue, 15 Sep 2026 01:54:21 +0100
Message-ID: <20260915005421.20570-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:27:57 +0000
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

scripts/kernel-doc reports missing and excess member descriptions
for struct amdgpu_display_manager:

  struct member 'power_module' not described
  struct member 'hdmi_frl_status_polling_wq' not described
  struct member 'hdmi_frl_status_polling_delay_ms' not described
  struct member 'boot_time_crc_info' not described
  Excess struct member 'dm_boot_time_crc_info' description

Add @power_module to the main struct doc, document
hdmi_frl_status_polling_wq/work/delay_ms with separate inline
comments, and rename @dm_boot_time_crc_info to @boot_time_crc_info
to match the actual member name.

Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3524931451c8..61756c089fcc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -330,6 +330,7 @@ struct hpd_rx_irq_offload_work {
  * @backlight_link: Link on which to control backlight
  * @backlight_caps: Capabilities of the backlight device
  * @freesync_module: Module handling freesync calculations
+ * @power_module: Module handling power calculations
  * @hdcp_workqueue: AMDGPU content protection queue
  * @fw_dmcu: Reference to DMCU firmware
  * @dmcu_fw_version: Version of the DMCU firmware
@@ -716,16 +717,26 @@ struct amdgpu_display_manager {
 		char reply_data[0x40];  // Cannot include dmub_cmd here
 	} fused_io[8];
 	/**
-	 * @hdmi_frl_status_polling_work:
+	 * @hdmi_frl_status_polling_wq:
 	 *
 	 * workqueue for 200ms frl status polling
 	 */
 	struct workqueue_struct *hdmi_frl_status_polling_wq;
+	/**
+	 * @hdmi_frl_status_polling_work:
+	 *
+	 * Delayed work for 200ms HDMI FRL status polling.
+	 */
 	struct delayed_work hdmi_frl_status_polling_work;
+	/**
+	 * @hdmi_frl_status_polling_delay_ms:
+	 *
+	 * Delay, in milliseconds, between HDMI FRL status polls.
+	 */
 	unsigned int hdmi_frl_status_polling_delay_ms;
 
 	/**
-	 * @dm_boot_time_crc_info:
+	 * @boot_time_crc_info:
 	 *
 	 * Buffer info for the boot time crc.
 	 */
-- 
2.43.0

