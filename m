Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336B8C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F24710F179;
	Thu, 27 Aug 2026 19:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V8J7JM0R";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC3310F0BA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:47:54 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d58efc7356so26324665ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787842074; x=1788446874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qbEkvagZ9qeyC6jVzXtKZoIKK94uFwUXLSPjBHZM3eg=;
 b=V8J7JM0Rj15bm24auYSHftMMRQ4ETDou08h2eVJPgpjLJ0UnP72o7TVweVywCA3QW+
 TquoAMFAijwJkMkYZj1aJbEFWNKkVL1Z9RosMItnwwpBHmnbAsLlCrgdsBJvpSAAEhwN
 dNvJxDWAXbEq4UnR4D9GisyJmBnF3+5oVqKuWQHqoh+JPryOPL6G3Jl98uzOcZtBjFXp
 IRccuO9HOyxx6V06Y9+ItpFb0z4Ud0HSO3PdUdr6D+zahD7kT6maLrBrRyOO1L8KPtAM
 N+RGePH+2Bv7wcEW3EfsVKhnkfl+0Zmasb5LmcxzXqpEbFzbWO495VO2IXCHsoyAnhYC
 beqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787842074; x=1788446874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qbEkvagZ9qeyC6jVzXtKZoIKK94uFwUXLSPjBHZM3eg=;
 b=Oa8IUo8PUL67H0yEuQlBQ+ktwqa3ItgwCbgxOsGwH1Up9GFW8NS5cdG2dy0f47Y8jQ
 CQOZJzEI0uoVIr1mUzsoXQR1T0tullY9cr5b3MdGjPQTbDZi6n5au6ZMFbaUjuLYDJeH
 r9OjyQsv87A0Z/VTyOHc2JSAuYOm1lgHSV6DIZbQoY2isvA5z4pfaYW05z7FqS1rsDwz
 kHLkovWPb84mDon2rI24r1gyooVNy21o+Gy5P1ygErl6XK6eylIdfP9pNLkno8+7pNfJ
 6ih3EHh4LwEEpWCkjOiu2KXRmr2uBEngXHlpBxfr6I52+oHuSc26A9RgS4vIGlX20zMX
 rEQA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0704GKyh5kGSAlTypm2mEN7pABoJ7tNhLh4mXsqtrRf05ADV+MDQJKGpt1midNS6Q0oHNbUgRAiI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpBzBE4sHgjDDu+DW4BxsNYl5ZM3yOqb1Ru5gtvUVZlmI6q0F8
 qMvnRXXzXxtO7kGCgumYUQtPvq2tc3LVgWfuVWTS6aKb116SN7jeZ6g4
X-Gm-Gg: AR+sD11MLECSeBMSBSC/wfbgo8FLBqZzvs2Q7G+FE8XM+mE8jz2RzMDeOqe0+dYgy0F
 oCejwiQHmkoGYsf3fwoglxfVA5BW7Ay20VafqmkzX1qG/hvxkQbJAxnwhEaDfc5s2NCzuFE4UtA
 n7j+d0KF/IFrOx3SY/v4DIl5AwyDAX6987CSLgHg4x9eDJp8q8kMcqjFt+YKhcmCMnY26jxT1RN
 Nk0pBPNUWsVy0QlX7Zf63l2iifP3EZri6GLvhKD3V6VBLe+mwKlvQMFn4RYfNqlQK2tEAAp8hZX
 fGL8wzbBcOV0z69NasiZr8XNIGfO/pjGymFWi7AytF1ocdY4VMxDO0BBVUsTyh+MScyBabQlkRG
 AJU1MTSDLnUIaemAhWu/OFQ1/5g0ql9ayLxy1I7B8VwHTKXHG/xFjKq/obKcnGK1UT+XUvpKZkY
 m/MC+PfjXx16zE7Uirx5CVnr7o2+FbUVOfYHTUPO3bb/lAwBWQdMLVwpM=
X-Received: by 2002:a17:903:2383:b0:2d7:71e:575d with SMTP id
 d9443c01a7336-2d707af8a58mr304661165ad.9.1787842073561; 
 Thu, 27 Aug 2026 07:47:53 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d704c2bb7dsm17953815ad.71.2026.08.27.07.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:47:52 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/ras: drop redundant memset in
 amdgpu_virt_ras_get_cper_records()
Date: Thu, 27 Aug 2026 23:46:13 +0900
Message-ID: <20260827144614.487229-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:08:24 +0000
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

kzalloc() returns zeroed memory, so the memset after the allocation is
redundant.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 1e83cb5064ff..f021719ff0a8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -298,8 +298,6 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		return RAS_CMD__ERROR_GENERIC;
 	}
 
-	memset(out_buf, 0, req->buf_size);
-
 	for (i = 0; i < req->cper_num; i++) {
 		batch_id = req->cper_start_id + i;
 		if (batch_id >= overview->last_batch_id)
-- 
2.43.0

