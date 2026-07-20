Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22EAC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A83410E172;
	Mon, 20 Jul 2026 11:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NhMnBEge";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CE410E172
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:32:23 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso19083995e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784547142; x=1785151942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dqbsg26ABj7eOdNonxG5QwFjKanK0ihJjv+Ud/fidP8=;
 b=NhMnBEgeK62IywLkevw0dJhpm17xYAuhi6seprDhxdJdLaecg08bunmZvd7haaTHv6
 Rag+khQ/07V+7MPnXNy2fOiV1J0Okgw0ihs8fJPDN9Vzxtldrz1yOr1P/yQb454yBynm
 zhielhJU8WYciKBqs3nnWAI7SSjFOw8Xn6nPla/3/anqouXFksQBLTJ0aBJMe9QAWT1F
 ks77d2Dfchbgn+7sx+JkFQk0HEPVX1UkQ3GyYmtU9BNd6nJApa64zWpy04rWKhYIN1kR
 yTb9S9sccQX51yWdRlSmbxGSnowZ6Km9VKE3agcN3WhZ+z4fBWcBNp1VqTWZtJxlxOYt
 nkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784547142; x=1785151942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dqbsg26ABj7eOdNonxG5QwFjKanK0ihJjv+Ud/fidP8=;
 b=lOTunC2gZgptOax+yF1NqLP6zsOtmvOipWP/sk2YQqOjKPu4nUylX72v6LBwgN9CBu
 pNNYydP2TDtk9YKBC2yys0HEPMiE+61NQ40+qzl1tOnLRJErkz3st+UTQRLHlrvFlS0V
 8otIHUQlj6HQ7DlKLutkzNH+q9s2URd2fsjhYHFAudqsvM2mAR1jOAetEY8bTQj+/QI6
 M0J9KQrtyP8N9VscyohE06JZpVDIKL6seEjxHvJn+VWrpqbpOw2aGn8SGxwbaG41tS8Q
 DJn9YtDgsnXEATURX6cJWKxjkqQQ2PB3Top86EW8MV1+PxzaOjlxGnkvJykh4MxtXFj5
 Z7jw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpoOKQfwDroKfyXW8YOaSkvNQoLmxFYCKcPKB9cBN8rFD9ZNiqiOd6Zh9oqCT0yV/x784356DrSVc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGVesbY6Z1uE+/Pm91u3P3sGMU1A6Y/3E1Mwt/NthOVRIcAxtE
 P16xjBYWX9JpNNg6mO4+VSmTnrwbch3ZyD/uzQ5S4lKl0hdU1zDLBcMb
X-Gm-Gg: AfdE7cl6g0gzkeFWiBDpm8L/OdOoOExo0JrMZgtfP2oHG8Nn231I23hXhc1694lC4Pz
 6rQBQHZbrWAlm0pmTglFitUBXiGI8mRT+3s4E5eEAdLrpkUjU0VtdsujbSpn0RP5zWBI1bqCxvW
 SXTPikhStnvylgPjJu3cThTdYEGbmryr4z7BadBAT8DDDHvLl0pL2iF2+urImisQdQQ1QkJ6yAi
 Wqz+kD1dD7j/eCuJC1fwK+gtDB553+5uIIyHnUYIbz4n6q2lqtnHs74nbCvGNz3PvO/oIMbPzcq
 yhbDJ/5B1RXa6gG8irAc5w88izteipX44EbboKU4CH+FOTutLdMwm7lQVhVZLsaiLkoR4YAdYpc
 EtN26iwR4nK1Yzor4u7vvGAETW0zvoA2VzqpvcAYyvaasMHW/CsZIyqIPaWFOSJCwEMCUclKvdk
 /YxMhMvXubXlipW/SQH/L7iTbWLpeYRx/Nsjf61Q==
X-Received: by 2002:a05:600c:630e:b0:495:4856:2659 with SMTP id
 5b1f17b1804b1-4954a3db6b0mr153568145e9.9.1784547141812; 
 Mon, 20 Jul 2026 04:32:21 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:a26b:a888:7408:fac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6980582csm21957014f8f.13.2026.07.20.04.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:32:21 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: harden firmware build-info bounds checks
Date: Mon, 20 Jul 2026 13:32:11 +0200
Message-ID: <20260720113212.11981-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

panthor_fw_read_build_info() checks whether the metadata range fits in the
firmware image with hdr.meta_start + hdr.meta_size. Both fields are u32, so
the addition can wrap and let an out-of-bounds range pass validation.

The function also reads the "git_sha: " prefix without first checking that
the metadata is long enough, and meta_size == 0 can underflow the NULL
terminator index.

Use subtraction-based bounds checking and reject metadata that is too short
to contain the expected prefix and trailing NULL byte.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 6335893d3f16..9d0e1fafdce2 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -709,7 +709,8 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
 		return ret;
 
 	if (hdr.meta_start > fw->size ||
-	    hdr.meta_start + hdr.meta_size > fw->size) {
+	    hdr.meta_size > fw->size - hdr.meta_start ||
+	    hdr.meta_size <= header_len) {
 		drm_err(&ptdev->base, "Firmware build info corrupt\n");
 		/* We don't need the build info, so continue */
 		return 0;
-- 
2.43.0

