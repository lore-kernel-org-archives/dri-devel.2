Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9F0CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFEC10E763;
	Wed,  7 Oct 2026 13:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hcE7D5d5";
	dkim-atps=neutral
Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD8810EAE2
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:13:42 +0000 (UTC)
Received: by mail-lr2-f3.google.com with SMTP id
 38308e7fff4ca-3a77df9781eso23053081fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791378820; x=1791983620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7raFCL+DaDHQ/Xzt3dKVl/XyqPmVrA37jhza1G8kvFU=;
 b=hcE7D5d5rY3mdBlpPcR8hqimcoL4wxmxXaYjcEkpOw+NOEVKtoex3bHIQoWba1Hlwn
 zDnLoCvAuEJaxhfYhcIQ+4Wgig/m96Hx61QBGRhQPF82hgRZJZrCMaslMJ490txTst7C
 zNCmw0DIDv5DoRXrX4RGqMJ3xyLVHjVBQeb3u8nauqydYw9MGtYmOyWyedeDWGsq0y6I
 5bsjSIkxUGb7pghWwo2FuBWZ4stQDT+S5oFB9TV+xqmPHhg0OTk/D7+HaSWEPBQqHX+O
 0WSTLVnKZZvVw4zuof5Wd69Q71Wd9RmjYMOvoz4GaB3Pzg2CujBIsaMcIJPU5JdTkVi+
 z60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791378820; x=1791983620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7raFCL+DaDHQ/Xzt3dKVl/XyqPmVrA37jhza1G8kvFU=;
 b=bI5kxQrMp7gu16Zlyld7kF9EvmjwSfRi/nxx2PDqZZQXv7ly8dYQCQkV9k8wu6Tvkh
 Lmibj718xqI556QJUN1PqF/QPd/oj7e2QAMBA8HUwAJrSzgF0vkAmXKF/TYE7xuCqcfO
 HKSU++msfPC0Tva6MtlZX+PpDl/QNtwolKRPi7X8rmGKDPZRLV3TBkhX5JI4Lim9JMQ4
 fI+W/4Uzcl3Zhv7uGGkG6RPD0DogJ3Esdor7QtdYeH13VbiXSfmWC2bDIP8oymAW+Xzl
 xAdEkjfcS35OKhJVSp8tkIWGtK/idhArCHoSaKzeY2TSMmOhhzTAPkDUJu9kf14QNttb
 n5Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvByRzCQd2TfBSWNGFu+JPba920JLRZGLkiusM6yMmQEEaOlRnnn5lWX3UdQGuNd0QIxECU31n4Xq5W4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLURcploFBdtxDKcPFUl69T53JN6DTWn43ZHULqOIkXn+gHCTcx
 u82QVWXw5+yKZrFSrtWwgVKLhw6jJYCLOe+tkPXSOhFK8sv1vRxT63da
X-Gm-Gg: AYBFou1LatO0rFInepZfhfbC38YxvYKQ5GTokhKkaf+lTVfV4Qsvy9+T4/ZkXgOmC1L
 ekrD8ozu5Bb7K90M5Hwk1ju5rWfmLJBxnk//hCLVCqBybuUYDgzxnG9B9GH6Il6k2CslEC7Mhqv
 hkkvOz+IY6eBHme+yMw2RaEkQRVmV8yyevVwPML19tUHiQk9FQoVoCl1lmTEwONxK6K0S5chu/y
 XkX30JZNB+aFP+XV2PgL6nkrtJm7Mn/95ju8b8N9sBgzXemDQMV4KW7vd/ZzmLQ8WrxKD/vYmgt
 enJl5Hvdn8TonD9v8PDYb327aYrN0FoujIg2d7dxliqRIKMlOosDcoHw+xFizDwEjT7Kxrqpaes
 sLCJePZ+2V3otwLqp4VWocwa7Dt2rAFC+6aEnUZCZsnnl3SsQ7bj7oT3xijYsGrBcAEc9gu3PdW
 ft2OEb5h7v6ayy7XnO+olfM7ljswk9MJyzPFa2i8V5zxze01bxIlERd49j7QwHCb9AWrzsUevmP
 dhWktidpA11i7JP
X-Received: by 2002:a05:6512:4027:b0:5bc:c63f:7004 with SMTP id
 2adb3069b0e04-5bcd072ddc7mr896476e87.48.1791378820139; 
 Wed, 07 Oct 2026 06:13:40 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd309149asm21640e87.53.2026.10.07.06.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:13:39 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Ray Wu <ray.wu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1] drm/amd/display: Fix out-of-bounds read in
 dp_get_eq_aux_rd_interval()
Date: Wed,  7 Oct 2026 16:13:33 +0300
Message-ID: <20261007131333.120389-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Harry Wentland <harry.wentland@amd.com>

commit e8b4d37eba05141ee01794fc6b7f2da808cee83b upstream.

[Why & How]
The aux_rd_interval array in struct dc_lttpr_caps is declared with
MAX_REPEATER_CNT - 1 (7) elements, indexed 0..6. However, the offset
parameter passed to dp_get_eq_aux_rd_interval() can be as large as
MAX_REPEATER_CNT (8) when a sink reports 8 LTTPR repeaters via DPCD.
This leads to an out-of-bounds read of aux_rd_interval[7] when offset
is 8.

Fix this by growing aux_rd_interval to MAX_REPEATER_CNT elements to
accommodate the full range of valid repeater counts defined by the DP
spec.

Assisted-by: GitHub Copilot:Claude claude-4-opus
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a55a458a8df37a65ffda5cf721d554a8f74f6b04)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53330

 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 6050a3469a57..579a38478d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -403,7 +403,7 @@ struct dc_lttpr_caps {
 	uint8_t max_ext_timeout;
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT];
 };
 
 struct dc_dongle_dfp_cap_ext {
-- 
2.53.0

