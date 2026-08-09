Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00901C5B56F
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B6C10E64A;
	Mon, 10 Aug 2026 06:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VwWtPsYh";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1814210E0CB
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:00 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d0407aedd6so9064625ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252379; x=1786857179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7uC67/V7nwNWq+dWDB8FGNBrrM/47Cbt+1oF506R3e8=;
 b=VwWtPsYhFAnzKWIsFEAN2NzuewdhImtqvE1yIwuvyUdmGqU0vRjzpUwnqSHBr96Y8L
 EYvL56YsOVqip6lDnb+OBf26D3+tvVRQ5lD1qsCfZQ+cDJahhPh9baw99vtyNT4qqKro
 Bo8PiU/si8rd4P+e8CsTIU0kE03LdfrCcVWpt0XYX3xuFqAkjEXGcfQe1woQEWc2YetB
 FW920oeyH1eSBJmLqRSGA3SOJ1kakqrv7PfvPr9hA5IpG1Ps3SHqQm429XNKAGmXWMnc
 gKYjprfvHuwpFBZFuRWzSrEdhb9SpeV+GtqmTMu8oAa7gBWt7X8QsLNefCJc1/brhqW/
 NzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252379; x=1786857179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7uC67/V7nwNWq+dWDB8FGNBrrM/47Cbt+1oF506R3e8=;
 b=koPDSGGBI28lzthMsPwXLdqIgan7K0iPBtz5qQq4vk2teN19u2x2cF2m65ZKx9IIZH
 p7Us64szwXEtk2OVLOCUHrXnrthrsDsqvos9FxkJDsRFa/cRxHVh6OwGG2WqJHx2c0Mw
 v1T6frdwh4cJ/SV4LQAkG93eUrGhHaHrlMlWlZ9xlwJZIksQGVNzUo8sqdpjGN1yv36J
 cnp8gQskM4Z6nb7ZApk9XfNMBYPy3SQKMNLtJFNd4ZoUGOtBPzfgfytwrhsi+jxLsgq9
 piy4Rzy8pyvTyhPpneB6FmmdxuymTe9HSloiYKmCYukXEJY6k4jOtf7m1C7yGyIclsLr
 C5gA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYzujFr5ZPXxbSrBa9vg68wVZWffh92syDPoW6JH1ABDV15jV5pIW/iho+Fkse0XQxa2VRYFTMaI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxowZWlkMFvJqQ3Mq+BDtpU50zpGFro/Nyk0rIDEBFEqiZXd/O7
 lFs1Zw9CdMQqZxCb+Yi3Q9ToKw0CLyAqpBjS2DrKV6OpvwRp6DcFDS3j
X-Gm-Gg: AR+sD11EYwvGBnFEXYxn8gq1Veon2M/BnjNpqd0dGn/Uv4mjrxGf8+pCf9l0X6c8iEx
 4D5X3dH3QKIU6CLuGZLhgjkdnD6S6PQlDnqusig4gDRtkTkQ942+vU3qTV/yX8y8mUu/edLCoBY
 Bi2GX8uaiI5mEHnr4BqMPmuQHNmWz0blYvDREHhhmn63vNFluioCGlhbfrxoRef8EvbmRxO9i51
 ktnVWmhY/QlDhAFXUtE/qYrK0GSz8CzeOWuG0z5ChhnjTgjDxdDaO72xvOcS93978IhLRKhKNCC
 4girYTM+fuNUwmvmCGdIsfts1STGbxZojgrIX8RpAomNwRlRlG0/whxH4bYT42iA2VmmmysDm3p
 ttHonqKgRk10V+wqfIbGqv4KABzK+s1Z5c86w0QkucXS9G6Yuh72aCBdF0R46phBn9CfTI3dBxh
 flE3wKFEsXJ5FZJDunkOjqKzZ4UlVY+80emlr9hbBxanMuA9MBDCL2ICXiueSdSHwHjkticq/IO
 segYntDeLqUuVqLw6awu+zh
X-Received: by 2002:a17:903:3848:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2d0ca70da11mr418477765ad.8.1786252379391; 
 Sat, 08 Aug 2026 22:12:59 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:12:58 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 0/6] drm/amdgpu: Robustness and safety fixes for ACA and
 RAS drivers
Date: Sun,  9 Aug 2026 05:11:54 +0000
Message-ID: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

This patch series addresses several race conditions, boundary check bugs,
logic inversions, NULL pointer checks, and buffer size parameters across
the AMDGPU ACA (Accelerated Compute Architecture) and RAS driver
subsystems.

v2 -> v3:
  - Patch 3: Updated amdgpu_aca_get_error_data() to return 0 instead of
    -EOPNOTSUPP for invalid handles, ensuring global RAS error queries
    safely pass through non-ACA blocks without breaking telemetry.
  - Patch 6: Moved cancel_delayed_work_sync() in amdgpu_ras_fini() prior to
    ACA subsystem and lock cleanup to avoid teardown races and UAF.

v1 -> v2:
  - Patch 3: Updated remove_aca_handle() to use list_del_init() instead
    of list_del(), ensuring list_empty() properly evaluates removed
    handles and avoiding potential UAF during device teardown.

Sreeraj S Kurup (6):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic and list cleanup
  drm/amdgpu/aca: Add missing NULL check for banks parameter in
    aca_banks_add_bank
  drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs
  drm/amdgpu/ras: Cancel delayed work before ACA teardown in
    amdgpu_ras_fini

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 35 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  3 +--
 2 files changed, 15 insertions(+), 23 deletions(-)

-- 
2.54.0

