Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF2ACA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA1910EAE2;
	Wed,  7 Oct 2026 13:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tEn2dD1P";
	dkim-atps=neutral
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com
 [74.125.230.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 787E210F589
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:13:55 +0000 (UTC)
Received: by mail-lr2-f10.google.com with SMTP id
 38308e7fff4ca-3a88780168dso2453841fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791378834; x=1791983634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/eJt26JNJaGGd2UXwu5+cQQ5n63otBhQmpzqf8cor98=;
 b=tEn2dD1Pl1ShclV3r/g9JXWqcaDUYo3n7OXnJTcRZyjbMe5PgbncS3TRoKJaZS1z6/
 0p1OmfRQ9/9G1U8ABHpp7stJkF0NJ/Sk3fY/D5uGRK003VGL5EbowrXEfIClMltdDnJZ
 3yfsi/2jI8d6lUAL79niaaUbKemWMNLiW/K9hlKLuhY7VOS7Yr4DNZ4myzho+YsE5MYW
 5Y2vYerEfd38M8BpDuE664qqvVztjGfcxq6iuMC4haQypilG172LR2t4dxgJC/2GHpUQ
 vHJLWAHzx5cHDtQ/7WXpYvHASq+QP2skYwlG+O7cq5uWHjKQq+u2/WTKD55VPbiCDbqm
 gk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791378834; x=1791983634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/eJt26JNJaGGd2UXwu5+cQQ5n63otBhQmpzqf8cor98=;
 b=ti2ZUGq/z+IBlq+WXGArrXxWMom/VgFJmnGuXf6VgJxo9ig2zC+4wqlTVZjusdxSoE
 OQIlaPWqPraVtjuQFF3pwitT52bNQ9mJ2x+y2l8PDI/kO32GkIMeiIhBxiTFeQ3R6Z44
 fn7BnFiEXxWVG561PfXqpuqgg+c5owThceqM7Uz+HifCF5qawIR4xOW+7YyGKOwQE3iv
 Ykasiq6iRKD0R6dpINLv0I0GChz2sLUAsNvUN2mgLAAlHMadOyV/mMHVboN6vhunQ3oM
 i0zMJF6VvP2tiJTrfsZNcCJdqI5cE/VGm60WDGO8L++DJxfT13K204bnDSMV7AwNj1l+
 fzdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBycmU9vqOuB3jhqH1qnJgdnJihOocQ6lJYIUDQe+VBr8Vg7U/6HOSWtDm0tkyxY+hB4iGKBwqF88YQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIHC8vlb1TfP16GXqyRgeVQvh2Xhy0Lsk/GU2p9tfzLFoVp1Qpv
 2hR6aKA+JZwIb7IIqQgK9P+e3Y34zqzxXyZDIfYkDINMVSLYLUPuVNw1pfOZ6D92
X-Gm-Gg: AYBFou19sLa2/F7dYuVDtLzvLf96OVXUdRg4KnwpmuG/rPTudV1dVnyHA9+jI2mrR1r
 1iZtiyx8byHp2siyySOOUrhq+rBerfI/DCurKqKtYpeBzPgIJhsUQH1+AGg5rsKLvzIYWVuO6IG
 1cGTCbzabQittKW4LXExbzP3Bo9rsMDyTKoAlu3xAJiLNKPkXamWBsTcCQ1W37u9aqnEke5LXC/
 zVPYaNuiNngr571EiiKerb5HFj9OWMoAjA3j7Q2deOjJ9yBqp9YgUfvn2TLiPw1zxyz23/zOAhY
 Yzh+ov3Q9GsvrS/qnW8iJlTcqXdKWJr7bEXD9mzAqPTLvIisQUfspjGbXUTZpVv18VHIJ1ImGoB
 UZkuqHnDEJCUekf2QjQzAzqi2BtR8NvbCJStQYgUVO9eDOzuDzhe1nVUDi7GHGLN6qZIVg8rZoN
 02YM4M808tW8iJ6Rf58KiOn/bCq7HdqnTrhaePTuBy8ST1O39lv2zSvbb6dIn+wcEtLu9F5kk8+
 VAhKM6YoGvS7aXW
X-Received: by 2002:a05:6512:3d02:b0:5bc:b84a:9c1c with SMTP id
 2adb3069b0e04-5bcd072c698mr891760e87.48.1791378833512; 
 Wed, 07 Oct 2026 06:13:53 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd30a8494sm15055e87.81.2026.10.07.06.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:13:52 -0700 (PDT)
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
Subject: [PATCH 6.12] drm/amd/display: Fix out-of-bounds read in
 dp_get_eq_aux_rd_interval()
Date: Wed,  7 Oct 2026 16:13:47 +0300
Message-ID: <20261007131348.120412-1-roman.demidov.nn@gmail.com>
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

 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 223c3d55544b..b128f1da98c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1112,7 +1112,7 @@ struct dc_lttpr_caps {
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
 	union dp_alpm_lttpr_cap alpm;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT];
 };
 
 struct dc_dongle_dfp_cap_ext {
-- 
2.53.0

