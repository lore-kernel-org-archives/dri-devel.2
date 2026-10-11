Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD35CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D96510E516;
	Mon, 12 Oct 2026 07:32:08 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634D910E076
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 07:45:21 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c6f764f82so214286f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791704719; x=1792309519; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BqM+9SRRezlqj4MjJGtTvfOzuMvNp9lIqAkwlEew1kk=;
 b=KojSEPFIsZYjxEWczTnI1oIXl9Ch7FLK8+pFJHBzgFss3g0ndEkq/a9NQzxgMCB+Xj
 gtsED/bpah0eQtPcU5WOT+JiuhMqxqqW8HqHGM3MM8ZAyejQVraJgGQc4s2jTyu+qVby
 aeU2eSyQT5dJQZiTdqwMtZwsM41f19MKceqvubG36pUzQ0h2LX5wsQ8H5jaEAXdP1S3/
 +/XenbZQjF6xX27LDwQwqqlARPIdjtSj6wOOMAMZuvD/J3ib2z5gK9l+erdiKgH3LY/F
 lFTWdosjWUISZDEv5b+25VSbafXEW/y2FxRpZJ7LWE6T2YZzHOycXmPvsEdyyRcKcveK
 y2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791704719; x=1792309519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BqM+9SRRezlqj4MjJGtTvfOzuMvNp9lIqAkwlEew1kk=;
 b=ruN8AUJTnOybszWt+38wT0jhP7WQT0wkxiX2xPHypGVLhD/TbXEKCVJC0aZ2uxbHy1
 YXO5koSkGouapVHDnE/XT0c9EOdNEJq9Enfjp0PpucQ2CDgcmbB2WJsePLWp6FsubwzM
 RfeeWdf12NYQ6JtcGFopyHGKn0cu8rfOf3lGWlZCNJqw398F2T9ofDtL4bmEC09h3jew
 1dcthCZaE9NhsslLh4aBpEM1JEucMHPv8dWlQPOvBJk8sJPCx08HSHO2/Y8sWZsyPbUl
 y6tkklPmS0kcEOjG6f0JOfaI4FixHZNO07zrI2jhu0of1hQ2cqoX+hPS5NNybY60tJa9
 c2RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoUawdKoNMyJeuNwZv5byfW0CRpZ/cGj7PCITsy3oDilAmz/tUzd5jooxx5aHpGUU5Kgi+qUTzEIs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKZY6PgLsB7Gf8Mo82+DRnZjvz9rsdh1EYZQIGzJk8UqcKrOB+4
 nepf1uPJyfLEhRbSTpWi+1I8wbwjZcEBTiZjjUPSRy7n7nPQN2qLWu9I
X-Gm-Gg: AYBFou3QmHhM+XMx5qZNCHVkcvDvebzi1AJcnMkRzkT01pR4ngP59O0OR+HNrQ5pGSw
 SXBjktaB/SoMKUkCmwA73kGM6MFIr97+S59vzhKXPIX4gQK6eYI2sCgvVc4WYVs+z/Kn/lsxlzf
 d6RI6baoGDFsiDpOyhOZM7LuMRGvmYOExjWGdsfSRmrmSERNRQHnyQLgQ97ioPSBw4oJQmaqFJK
 2hJf/7+rF3ElYNYG4WRpfAaagroZi4QYQcq7+ESuRV5En77mDMjkNXNCq4qUTGZ1qwDhscdw2tw
 w5ILAFWiR4IAoff0x4PnqxqvAxJX8qgF694K8ZKFo4ioyeZI/gII7yL9CoKThuLaifoWeK/ZKpv
 eWZd0jK8jyOuKcXeGjtrHN8RonujYMN2Yxku1FnpyaYlXgeLPSy57DtEcL4PRv/eAANg09eiW7k
 jmADoRNsEnCZTkDN77d0lJKNDfV7Pwj4XmYaRya6jc0RN/MsjA4KUURmO3JkgI/yN49DU5Ot1/I
 1Vre/PHCro0x5z6U8iv4yc=
X-Received: by 2002:a05:600c:620b:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-4a18e4d12e7mr102284445e9.31.1791704719496; 
 Sun, 11 Oct 2026 00:45:19 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net
 ([2a06:c701:4778:c500:e952:dc8f:95c1:823c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e48db03sm271020005e9.3.2026.10.11.00.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 00:45:19 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Initialize missing TD-LUT programming inputs
Date: Sun, 11 Oct 2026 10:45:10 +0300
Message-ID: <20261011074510.2495683-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

dml_core_mode_programming() memsets (clears) its scratch structure
before calculating TD-LUT settings, but does not initialize
tdlut_mpc_width_flag or is_gfx11.

Both inputs therefore remain false regardless of the plane
configuration which can result in incorrect calculations.

Initialize both fields using the same sources as the mode
support path (now both paths are aligned).

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 72acf12e9251..0ee385e8ba5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -11074,6 +11074,8 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 		calculate_tdlut_setting_params->cursor_buffer_size = mode_lib->ip.cursor_buffer_size;
 		calculate_tdlut_setting_params->gpuvm_enable = display_cfg->gpuvm_enable;
 		calculate_tdlut_setting_params->gpuvm_page_size_kbytes = display_cfg->plane_descriptors[k].overrides.gpuvm_min_page_size_kbytes;
+		calculate_tdlut_setting_params->tdlut_mpc_width_flag = display_cfg->plane_descriptors[k].tdlut.tdlut_mpc_width_flag;
+		calculate_tdlut_setting_params->is_gfx11 = dml_get_gfx_version(display_cfg->plane_descriptors[k].surface.tiling);
 
 		// output
 		calculate_tdlut_setting_params->tdlut_pte_bytes_per_frame = &s->tdlut_pte_bytes_per_frame[k];
-- 
2.43.0

