Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A60CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87F110E5D8;
	Wed,  7 Oct 2026 13:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i1KEddqY";
	dkim-atps=neutral
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066C210E763
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:13:28 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id
 38308e7fff4ca-3a771ad2a9aso16414321fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791378806; x=1791983606; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YHXWb/yE7fhA7aF15l/F01Ze1XYkmrkzVKkvR/gzDUc=;
 b=i1KEddqYPfaCeVRDCnm3T7dPPg+iwWyMM07HLERnP5wlUJibnI9YNsP5OC3G4XNpA3
 NzRyOcbcGwAqfmYVyu8RNpUTTmWdrdKhKNqPcpT4sGk5tnGkocFQq52CKWb4PpFIlL0S
 H6hymAXYrd8GmaCnLsl08ofhwuLUyUwRN/Q+p/lKSeJtVwg4jI9v0rytAuvzZXOYEw1M
 8z01m8vVRVdZTeafUX0VmPEQBaZP9lPA7Q0oEIQ6Af8JOARvhG5NEps9lNhTCP5Lt6yX
 pSkB1+PnHDYlbZ8JZFAchhWykkgYwrbns01oTEalTJZi3WMhIbySuUsYQtXMSJm1Zcht
 mM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791378806; x=1791983606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YHXWb/yE7fhA7aF15l/F01Ze1XYkmrkzVKkvR/gzDUc=;
 b=vWcnz3bW2VwzBjF7P1KqckzGcl+ePxrlXHeeZLYzzRRXxkW+TYUVxLrPE6arx8E3oc
 ZnEW7cXX6+YdN6T/ClY0jZDbVvEpkxS8U4iw3KluIr78W7KBCyTIgGGcFsx25Y15hSNg
 eQEYgaaWoSorNNKw7L/1nV0OeZ1ybPUFv+hMSBt3CbZ65DIz0YOZK71sYDMZtxHxuzeR
 JxXikmzKuYfGq6LYidcTwKiCEa7JV7wjIYUy0IcGesoMz5o6shmeJMjud3a3nfhfvFae
 wmLL+KJqZn9pQJQZMQBdOruHe1tZ5aI4qyEfDkm5Phmr47EtRxxTpc/fHE5ptgezt7hU
 0P7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw077PKT7IB1RaXMEF/dJli5lp5sipxhEA6prRmhLN3JvxMKZlEFTS/Wp4L/xumMnOdlnyEU2ZxZkE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJlF/ILFvPziYUVOFTwofSJxazaWl1e8S5av85xr0sBWKXJiWT1
 IsmoUcoRBo4c9/Eg1Mi5P0AmqvwUG+/cXCQ7JE8ArHHT8xB48JwkGBXV
X-Gm-Gg: AYBFou0LRKPGe/1ZnPQWxfRnw4Mfv826+22ulLjn7rgijtLMRpKrPyHmvcgZGZ7fLAa
 oH5g6Yjt8ANbNK8zPCICR6WrKJsyvbEyDGEBHfEt2iZ45OHK89nFrRFuOv/spMzDLqYhCk5g+a6
 rdFWX4BPP69twHJh9TR9XCbVQ8gAZq2DK2ZNTF3KKG6njv2b03qd7cCBTW6T+tUrggUxUAjdtre
 z4iNAqKivxffOhRITX/4folc7wTyk/zsqH2xJur4fcjh2C/+clrwAC7E0eF0JmnKld4xqGjOlDJ
 zK5fBnsGQ3JLixxQIwrWMLAVRKPwkMQWFV1SVkh3W/q0deK+UTBYrn2L5KKKerWvpmxY7Y5K0Si
 5i6N4VLPDDT0HM3wNxQXhmp0XGBbt2/RU4dWAnjaBiFWS3VyUO/42LD176ekz9lZwMXaUUvFver
 2LUsDtH8wH6O72wkLPYIWXsyqhMDykh1ZqdvFw91AHirIhIP7j7Ll84IboAQlQY8UDoOy3OGm/a
 3+w3UxC3UhI8PQI
X-Received: by 2002:a05:651c:1547:b0:3a7:7cb7:6fc1 with SMTP id
 38308e7fff4ca-3a99432d1c2mr14198961fa.18.1791378805693; 
 Wed, 07 Oct 2026 06:13:25 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9a1d32eb1sm6158821fa.8.2026.10.07.06.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:13:25 -0700 (PDT)
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
Subject: [PATCH 5.10/5.15] drm/amd/display: Fix out-of-bounds read in
 dp_get_eq_aux_rd_interval()
Date: Wed,  7 Oct 2026 16:13:12 +0300
Message-ID: <20261007131314.120362-1-roman.demidov.nn@gmail.com>
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
index c8c2ba7e7b05..6cce8dd64bff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -433,7 +433,7 @@ struct dc_lttpr_caps {
 	uint8_t max_link_rate;
 	uint8_t phy_repeater_cnt;
 	uint8_t max_ext_timeout;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT];
 };
 
 struct dc_dongle_caps {
-- 
2.53.0

