Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BFEC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54FC010E15A;
	Wed, 23 Sep 2026 15:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="khXR540s";
	dkim-atps=neutral
Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com
 [74.125.229.164])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB33C10E944
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:29:24 +0000 (UTC)
Received: by mail-dl2-f36.google.com with SMTP id
 a92af1059eb24-14373bcc010so1217510c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790177364; x=1790782164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4RwhN3nTYO2NwTsY9NysVRh+VFHI1OHGWLQy/WkOav4=;
 b=khXR540s8WpeZf2Ue7rN2oiKw0wHCtcuhyZWU8vQiq2ZP7s+faPVvPFVgmjTByIsFx
 JiuXGZQ2e4D5v9Sxs/kW1MHnWkvA+YMbU+idilhl4rkDu2ApEhoz8XTyLuE+JX0B3BzU
 b1Xx2LJZox7LTU8cmEeq8n7ltUp5e8UcGX6DaOm4h6foSlMabBq0b5zxMU4LgwrBZf4F
 ZKgw8E9Ym3G4cW1jx1uOxK5uDw6NIlznxEGyExEl/zYxePJyQ4WG8ferqiyCzspg8uMq
 3yg/4V5I6rtc17IQQyB2wv25KScZ4Zxv6GIBOOfjF3IqDdTlmZMRJJ/lIKYyEYiho/dS
 qtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177364; x=1790782164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4RwhN3nTYO2NwTsY9NysVRh+VFHI1OHGWLQy/WkOav4=;
 b=ODZ+RuDKC5zQUYYtyYs4tyhduv8NYnOQC/qM8hwJ+sT0C099sHcX8rRU/hZaJEQHWS
 W4Zj/yPrwzuZW6+TgqEPDBzn0H9jVDnL4tf0CeH+PE95vcsZdu8pmES250UoNAdI32VA
 ItKLVK3LIiFgwb7IMC+eoYYyr5Uk0a3jQfAdieXJ0oR7HCBPXWLOjaVNqKo0CxCQDDkr
 JMXNHHH7kpsBu7D7Nj5gR79jLKE1ZeF1XZJDoHGWmKywT0ydV607jyxSNu7j94NjlaGb
 BpAO9zuDrc+4vUlhgYJtWrUs7ldy8AWfGzezjrRWxQKAIuJ2oAmUYbED/0cdyzl5KWaw
 ByyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8dmHKP8NF6+2feiUT5IfghWTmGO4yjh9bpsZQ4bJ7jYh/RNBOJjgJazQiwOVOPrfApXbpP+tFiqc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXYCJ5oBdk40gAYDVqeWkN3VqYe639X3rzzHZYPBykRL37Kflz
 /QpuoyBzIg1tcMHk39ad1r/+1hO6DwKlWI1WEvdHH5FO4OtrP+E2Xl8T
X-Gm-Gg: AYBFou0U7nPX9yM2ZqDT/YC7Qw4qJ6O81OmN6r9lolD/RExT5qMpRIo0aL77T7pfacG
 znz8e6jrh1Qw+E6tIPr1QB8u7hsGgTk4RcfFY3YR39SY96QdXdQWzRz39qrBGhfi4z2RbXprWXK
 p4VDjCOZHpcP2BLZhGLjUngTfFeQesGVaJF7P650VFltRlDpDp/oczunRqjIPN0cfGSM4Y6OZJR
 BhqohUtahilSoUeEhLav3bmtpMMn34aZyDOXo1HY0M3MZ6C52dziCu95TOJ2etcY7D/4jGfj6MP
 SA3NelpziFduoW819EPfOkme+XEqIsi2bXYyHePvygMlNT1eZj3MXDaegQlVHfBzlVNF/UDT+01
 ylTPbpamDNAxijwVhHDY4hSMWNk4C5ZT/2FjDOarsQ7ryHfqlkRyGFwWjoByuOaQJokDpwO4R+r
 4gDKOmmu/J0LyB9iAtg6z/A1ZbtLsGq7Yo4yss9CzzTct5EfBK
X-Received: by 2002:a05:7022:ea4c:b0:145:15d:5313 with SMTP id
 a92af1059eb24-145015d5351mr741463c88.25.1790177363784; 
 Wed, 23 Sep 2026 08:29:23 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98bf501sm7232627c88.14.2026.09.23.08.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:29:23 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] drm/amdgpu: prevent parameter-space underflow in nested
 ATOM table calls
Date: Wed, 23 Sep 2026 12:29:12 -0300
Message-ID: <20260923152912.1296884-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923145001.1244517-1-qwe.aldo@gmail.com>
References: <20260923145001.1244517-1-qwe.aldo@gmail.com>
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

atom_op_calltable() invokes a child ATOM table, forwarding the
parent's parameter space with an offset:

    amdgpu_atom_execute_table_locked(ctx->ctx, idx,
        ctx->ps + ctx->ps_shift,
        ctx->ps_size - ctx->ps_shift);

ctx->ps_shift is in dwords (set to ps / 4 in
amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
remaining capacity in bytes. The subtraction therefore mixes units:
a child table requesting 60 bytes (ps_shift = 15 dwords) with only
16 bytes remaining would compute 16 - 15 = 1 instead of the correct
16 - 60 = underflow.

Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
subtraction so the units are consistent and oversized requests are
correctly rejected.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
    ps_size, fixing the unit mismatch found by Sashiko AI review.

 drivers/gpu/drm/amd/amdgpu/atom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..0940bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -646,8 +646,8 @@ static void atom_op_calltable(atom_exec_context *ctx, int *ptr, int arg)
 		SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx]);
 	else
 		SDEBUG("   table: %d\n", idx);
-	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
-		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
+	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx) && ctx->ps_shift * 4 <= ctx->ps_size)
+		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
 	if (r) {
 		ctx->abort = true;
 	}
-- 
2.43.0
