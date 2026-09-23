Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB8AC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B60610E095;
	Wed, 23 Sep 2026 14:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="juJW0Oca";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E626410E095
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:50:18 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469a34907so899252b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175018; x=1790779818; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+9dAfw6j+gd4CFGZQW7IESgJBRKBFJ7eBXdntcdN5b4=;
 b=juJW0OcapCbSTx5/oG3wuzIi+/r7VUoETlij5NGpeFl9GKGwPUplYM6dw2FdZNqcR7
 wtxxhMcPu7XjRMtGL2NRgUudNq414hmZJcBSkUHsDGfx+ESIDCKQPlr31n/KfzQHjX9C
 I7IUyqlZ57vMnavspPF5Wmb/sPMT4ZZEsUxl44ANWBwdELhEp4qEK+AM2bUejzCxCoGe
 bCktjW9KVbAjYspJizs5lJ1tblT4XTR5kY7dcZrZmkuhihxCl6YH//DpogTGPvsA+Oka
 6wkQSHzkhA3Uez4lHS85dLRxITIZ9JXu0OQSxe9TtS5eIs/aKpJwcqj++WWnpH3Js71U
 MSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175018; x=1790779818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+9dAfw6j+gd4CFGZQW7IESgJBRKBFJ7eBXdntcdN5b4=;
 b=zqW4Z1qkibQTo5u4eC7VEnvkjTOcya6XybKMKFQLfYqKtkZ/tn/eZgwR5vU7YpZ8/D
 /pEOGf/zc4Xa9WGUNsSnuc9VbQYE3xF0yotlb2XCf4LAzEjbFufduS98CuKMi7yQokxg
 ZrQ9KA4kd34yFw4lmwPCL0Zg4W/YTf/gWIFzcfpOOKfj1AjFv9SaYBJhPrL/kxYb2Kh4
 UuWvF/9YpcY4fJf/m8gM6Pn/I8et47L9pLTyPY/lOZSGs5mzA5X/KHDGCsQVklZSZiIV
 K2zxmWldVb9j0xZ1BYeOp8Og+R4BoBsUoqhA6LoQ5z7Fepjymhd+wxCOGC3JHsO11Za7
 Ps3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPQWsgWSar0Zr+lKui04XGYbFxy2CphqMGYt+nWjLFw8pt+Qz0JAuPRuUXoFfnWbK/UqwDcQh6wxY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRcTuK0nEQfJH+VA0cBYbU/guEFTP4tXREWwKIHsZ7cYSStphn
 ByxIUg0mDTIpYG9P0aZ0qnA8oIhOnXQdc6qdZIDDF3blrc4whOceBF+2
X-Gm-Gg: AYBFou0gAh6f2i7EyvAhiP9QOQiUrmOpJWb4r3+EswNA5td6kVRUS46jcvxHkm25u9h
 XRzAgli5Tu0Jb2khoMnizlMxDTbJty8kZBImCba4G7Bi9kUpNyIzc3RsGwm01ktYnF655mV/Np2
 trjh87tU3lTC4C7Q/UOun81n4PocwtJ4Lsux2GONzBudP0hUJZr0Ati/22Pc0zDXVeymQfjamS/
 XFsjjKyeYcQtCFnipeHTTZEB0Wyk6fWEyQotWCgA/fMUQxheCvHbyImEWENeGAR9glwdwa2XplY
 s13+f9j6Pkf4gQmjzLvidm7mJnPTdgLd0553UcbFlRDshpNvnZan+m3qPhzqlLKLef7nrsX/dry
 dtndKCY6auoFd4PgSPg+CtpW2peqhY2y+MoJuotJ7S1SQg+wahUUbKRHChkEQCEoQ4DrwnJQBdC
 WiOpeXJ/Q3Noy/L6ZeDmO5w8ZvkvcU50BRByFBubzLzRrHl7MfN/STQyKr84PR4PgX
X-Received: by 2002:a05:6a00:13a6:b0:878:34d7:6987 with SMTP id
 d2e1a72fcca58-87d1c9c6e01mr2838923b3a.53.1790175018176; 
 Wed, 23 Sep 2026 07:50:18 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1d4c483asm1453655b3a.21.2026.09.23.07.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:50:17 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/amdgpu: prevent parameter-space underflow in nested ATOM
 table calls
Date: Wed, 23 Sep 2026 11:50:01 -0300
Message-ID: <20260923145001.1244517-1-qwe.aldo@gmail.com>
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

atom_op_calltable() invokes a child ATOM table, forwarding the
parent's parameter space with an offset:

    amdgpu_atom_execute_table_locked(ctx->ctx, idx,
        ctx->ps + ctx->ps_shift,
        ctx->ps_size - ctx->ps_shift);

ctx->ps_shift is derived from the child table's PS byte count
(ps / 4) in amdgpu_atom_execute_table_locked(), while ctx->ps_size
carries the remaining capacity from the parent. A malformed ATOM
table chain in the VBIOS (or a GPU that reports corrupted table
headers) can produce ps_shift > ps_size, underflowing the
subtraction to a huge positive value passed as params_size to the
recursive call. The child table then reads and writes far beyond
the stack-allocated parameter buffer.

Reject the call when the shift exceeds the available size.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..638bd18 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context *ctx, int *ptr, int arg)
 		SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx]);
 	else
 		SDEBUG("   table: %d\n", idx);
-	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
+	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
+		if (ctx->ps_shift > ctx->ps_size) {
+			ctx->abort = true;
+			return;
+		}
 		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
+	}
 	if (r) {
 		ctx->abort = true;
 	}
-- 
2.43.0
