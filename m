Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B40606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsiBkKHe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2F010EB06;
	Thu, 12 Nov 2026 01:43:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E990F10EAF3;
 Thu, 12 Nov 2026 01:43:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D519260E11;
 Thu, 12 Nov 2026 01:43:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794447830;
 b=Vb2vhPwaiXQfad51oVJm3xZP88SIT90wm+1TnChgyMVXKBZ7N4Pqy5AsuzH2Wv9bBk90
 9n5fptQNP8L33IrehcONHRAN3x3DoZXeLA+HmXQBBHnj0ucyxH1ZVcbc6jU66pqOB6swC
 ES6slhApJbSDTt40iWtCaZFbCYEbWxGjAp0v/ue0inkueTLLOJmUiUs6x66GdSKRKpOTg
 pjBcqWrXKbx3Nom9V7CvtGNoIbTmNMVG6ejQe7kxQpcjD/7mebpqEPxT6BfhhGIpUl0MS
 tiTRwPYD0Up9Ph6uIoTQehABLjuyC6DhzKKLR1W14+U2ecz7g9K1QWYdUPOh0UOtfig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794447830;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=t5cVW0rhfAotGp4Q8CCKFijB6BUX0sXZ8z47WhflrBU=;
 b=HDRkmJJ1EjJiXAE17qWZfBgNE46eDiPus7FTt0N2HV0+1eQU2MsURiTlIMQn8x3Jj7tv
 Sk67vO6/uX31w2EI7E5gyrJHY5sbCPioHw2fsvaPw8gTN3WGObntdq6XH1zzil/J8U0Vg
 j5iKgGAx5AJgXe5T0RI8ZKyUFH2a5YbVjb7qD0nzBGXqXyGadNzDwDUnPDpvLvjFRSo5E
 0pOxBHqna792LjbJmx1ARPKmbvGq7yGgyPGlguPhFiXf9P/DgOvqmvCa2KWaCLFYq7noY
 1nfv9ZRGrTPSwUNYuA3BHS3WUOzu+0HRo0VS7HtpQu+d8jNNDF57uB9l7eZbQ1Ym9kQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 97C771F00A0B;
 Thu, 12 Nov 2026 01:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447830;
 bh=t5cVW0rhfAotGp4Q8CCKFijB6BUX0sXZ8z47WhflrBU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=YsiBkKHeZK6tNT6lFAkywQZCucKnKyzTkRJ/AGSSpIe9eiWOLRNX3HI3NKTkcF5mY
 wSCqKmx2sGzt/mg1n3oGoigxo8yQx3zGqc2Iz4fL2sAveE5MxZLkYV8jaTBmykGhVj
 vx2iZId4dZbPWbV6Vd1lX0ZU/5d8Oy0jd//XimbUKrDLwUHrzJsOZQoK1xhjSkms8Q
 CHgEd9wblP5vwBHkYzVbR57LAQajn9xAYWgvCFd5yyZOI//QyVT8osQTm22kPXaZy3
 jlvyr51UJJL23tk/Wt2Bi0Y0p1I/87eXaPNMZuBXoppHyBhRtKRuxfkYToDYmifJKu
 vJ+xNPN26jqug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 0A11A491C7;
 Thu, 12 Nov 2026 01:43:49 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 12 Nov 2026 11:43:36 +1000
Subject: [PATCH 01/19] drm/amd/display: Drop the dead vmid module
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-amdgpu-dc-cleanup-v1-1-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Austin Zheng <austin.zheng@amd.com>, 
 Jun Lei <jun.lei@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10509;
 i=airlied@redhat.com; h=from:subject:message-id;
 bh=Z77uIEbPQQ+PkqyBmNyns6HBPtpxtwV5U1KNXIgj/gE=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq9RnODLIeTXgwyWE26dO3007EzASOhPJoR8Jsd
 BSlp46BPMGJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavUZzgAKCRAMdPNZecSG
 vlbBD/9d0yLki0kqOZ4Q8oc8BphoCz6ObrFdVU+ecDdczmFx7wgupYFV5vN7P6938WU89xiOwHT
 l+f6wUgnf+5jTMW5vvPhb5INaQ4GoOV8811z9ebIkPGHrjMMWj+6vif+1tHnTEqm1wXSDAcBlyp
 R9ON6L+SJy8mBDnnRYJqJ0LPEP/uAZYTCL8wL5UNeMhWaxya/ymkj5pH4wGE2ye5JXWJmh0gpxV
 F/zVdQ+q7mR6V9zxs2Oq4y+TTyF85G+Iunh9bdebEs4ZkeM+/H4kfXpPXap6jAmPIOuO50UsOF8
 VrLAIKe4mvo0a/rcBvmzItnZbfn0/ekaxw2K8kDH/wiNQveQyhcHt+mMJWvFnW9LKUZdw5JhsM/
 KgaAVnp0gaXvGSAB/KJT8TZYIh4yT9ewiybfekD1MRfo6thWAJ4YnI7K+URdeL/M6XNfM7NREGI
 6eoGHn+E5CzF9jxA10arOrcXjJ1S3CsTPcUXx0TCkCmBZXWExsXJDrbLhgJY9xrgeWqv2ZkHrUS
 kp/IFglzZmvMg1ktIfJwI/Phk5OXceNsFP0bFxaLz0z0pCaZyWP1jUUKBcLYCubNFfIlISBRWqw
 yrECfuVxwxfPNHwgRBVHlRrxQ3sVRxcsvg+73YlAyVnIvdgr3he6zoc2JTJCb9Lmt4eAUz0mHVw
 F28gXjMNKa4Fm4A==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

modules/vmid, mod_vmid.h and mod_stats.h are not referenced by any
Makefile; remove the dead code.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 .../gpu/drm/amd/display/modules/inc/mod_stats.h    |  75 ---------
 drivers/gpu/drm/amd/display/modules/inc/mod_vmid.h |  46 ------
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c    | 178 ---------------------
 3 files changed, 299 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
deleted file mode 100644
index 8ce6c22e5d04..000000000000
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef MODULES_INC_MOD_STATS_H_
-#define MODULES_INC_MOD_STATS_H_
-
-#include "dm_services.h"
-
-struct mod_stats {
-	int dummy;
-};
-
-struct mod_stats_caps {
-	bool dummy;
-};
-
-struct mod_stats_init_params {
-	unsigned int stats_enable;
-	unsigned int stats_entries;
-};
-
-struct mod_stats *mod_stats_create(struct dc *dc,
-		struct mod_stats_init_params *init_params);
-
-void mod_stats_destroy(struct mod_stats *mod_stats);
-
-bool mod_stats_init(struct mod_stats *mod_stats);
-
-void mod_stats_dump(struct mod_stats *mod_stats);
-
-void mod_stats_reset_data(struct mod_stats *mod_stats);
-
-void mod_stats_update_event(struct mod_stats *mod_stats,
-		const char *event_string,
-		unsigned int length);
-
-void mod_stats_update_flip(struct mod_stats *mod_stats,
-		unsigned long long timestamp_in_ns);
-
-void mod_stats_update_vupdate(struct mod_stats *mod_stats,
-		unsigned long long timestamp_in_ns);
-
-void mod_stats_update_freesync(struct mod_stats *mod_stats,
-		unsigned int v_total_min,
-		unsigned int v_total_max,
-		unsigned int event_triggers,
-		unsigned int window_min,
-		unsigned int window_max,
-		unsigned int lfc_mid_point_in_us,
-		unsigned int inserted_frames,
-		unsigned int inserted_frame_duration_in_us);
-
-#endif /* MODULES_INC_MOD_STATS_H_ */
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_vmid.h b/drivers/gpu/drm/amd/display/modules/inc/mod_vmid.h
deleted file mode 100644
index a3787fdf0c08..000000000000
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_vmid.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef MOD_VMID_H_
-#define MOD_VMID_H_
-
-#define MAX_VMID 16
-
-#include "dc.h"
-
-struct mod_vmid {
-	int dummy;
-};
-
-uint8_t mod_vmid_get_for_ptb(struct mod_vmid *mod_vmid, uint64_t ptb);
-void mod_vmid_reset(struct mod_vmid *mod_vmid);
-struct mod_vmid *mod_vmid_create(
-		struct dc *dc,
-		unsigned int num_vmid,
-		struct dc_virtual_addr_space_config *va_config);
-
-void mod_vmid_destroy(struct mod_vmid *mod_vmid);
-
-#endif /* MOD_VMID_H_ */
diff --git a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
deleted file mode 100644
index 32617893ffb2..000000000000
--- a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
+++ /dev/null
@@ -1,178 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#include "mod_vmid.h"
-
-struct core_vmid {
-	struct mod_vmid public;
-	struct dc *dc;
-
-	unsigned int num_vmid;
-	unsigned int num_vmids_available;
-	uint64_t ptb_assigned_to_vmid[MAX_VMID];
-	struct dc_virtual_addr_space_config base_config;
-};
-
-#define MOD_VMID_TO_CORE(mod_vmid)\
-		container_of(mod_vmid, struct core_vmid, public)
-
-static void add_ptb_to_table(struct core_vmid *core_vmid, unsigned int vmid, uint64_t ptb)
-{
-	if (vmid < MAX_VMID) {
-		core_vmid->ptb_assigned_to_vmid[vmid] = ptb;
-		core_vmid->num_vmids_available--;
-	}
-}
-
-static void clear_entry_from_vmid_table(struct core_vmid *core_vmid, unsigned int vmid)
-{
-	if (vmid < MAX_VMID) {
-		core_vmid->ptb_assigned_to_vmid[vmid] = 0;
-		core_vmid->num_vmids_available++;
-	}
-}
-
-static void evict_vmids(struct core_vmid *core_vmid)
-{
-	unsigned int i;
-	int ord_int = dc_get_vmid_use_vector(core_vmid->dc);
-
-	ASSERT(ord_int >= 0 && ord_int <= 0xFFFF);
-	uint16_t ord = (uint16_t)ord_int;
-
-	// At this point any positions with value 0 are unused vmids, evict them
-	for (i = 1; i < core_vmid->num_vmid; i++) {
-		if (!(ord & (1u << i)))
-			clear_entry_from_vmid_table(core_vmid, i);
-	}
-}
-
-// Return value of -1 indicates vmid table uninitialized or ptb dne in the table
-static int get_existing_vmid_for_ptb(struct core_vmid *core_vmid, uint64_t ptb)
-{
-	unsigned int i;
-
-	for (i = 0; i < core_vmid->num_vmid; i++) {
-		if (core_vmid->ptb_assigned_to_vmid[i] == ptb)
-			return i;
-	}
-
-	return -1;
-}
-
-// Expected to be called only when there's an available vmid
-static int get_next_available_vmid(struct core_vmid *core_vmid)
-{
-	unsigned int i;
-
-	for (i = 1; i < core_vmid->num_vmid; i++) {
-		if (core_vmid->ptb_assigned_to_vmid[i] == 0)
-			return i;
-	}
-
-	return -1;
-}
-
-uint8_t mod_vmid_get_for_ptb(struct mod_vmid *mod_vmid, uint64_t ptb)
-{
-	struct core_vmid *core_vmid = MOD_VMID_TO_CORE(mod_vmid);
-	int vmid = 0;
-
-	// Physical address gets vmid 0
-	if (ptb == 0)
-		return 0;
-
-	vmid = get_existing_vmid_for_ptb(core_vmid, ptb);
-
-	if (vmid == -1) {
-		struct dc_virtual_addr_space_config va_config = core_vmid->base_config;
-
-		va_config.page_table_base_addr = ptb;
-
-		if (core_vmid->num_vmids_available == 0)
-			evict_vmids(core_vmid);
-
-		vmid = get_next_available_vmid(core_vmid);
-		if (vmid != -1) {
-			add_ptb_to_table(core_vmid, vmid, ptb);
-
-			dc_setup_vm_context(core_vmid->dc, &va_config, vmid);
-		} else
-			ASSERT(0);
-	}
-
-	ASSERT(vmid >= 0 && vmid <= 0xFF);
-	return (uint8_t)vmid;
-}
-
-void mod_vmid_reset(struct mod_vmid *mod_vmid)
-{
-	struct core_vmid *core_vmid = MOD_VMID_TO_CORE(mod_vmid);
-
-	core_vmid->num_vmids_available = core_vmid->num_vmid - 1;
-	memset(core_vmid->ptb_assigned_to_vmid, 0, sizeof(core_vmid->ptb_assigned_to_vmid[0]) * MAX_VMID);
-}
-
-struct mod_vmid *mod_vmid_create(
-		struct dc *dc,
-		unsigned int num_vmid,
-		struct dc_virtual_addr_space_config *va_config)
-{
-	struct core_vmid *core_vmid;
-
-	if (num_vmid <= 1)
-		goto fail_no_vm_ctx;
-
-	if (dc == NULL)
-		goto fail_dc_null;
-
-	core_vmid = kzalloc_obj(struct core_vmid);
-
-	if (core_vmid == NULL)
-		goto fail_alloc_context;
-
-	core_vmid->dc = dc;
-	core_vmid->num_vmid = num_vmid;
-	core_vmid->num_vmids_available = num_vmid - 1;
-	core_vmid->base_config = *va_config;
-
-	memset(core_vmid->ptb_assigned_to_vmid, 0, sizeof(core_vmid->ptb_assigned_to_vmid[0]) * MAX_VMID);
-
-	return &core_vmid->public;
-
-fail_no_vm_ctx:
-fail_alloc_context:
-fail_dc_null:
-	return NULL;
-}
-
-void mod_vmid_destroy(struct mod_vmid *mod_vmid)
-{
-	if (mod_vmid != NULL) {
-		struct core_vmid *core_vmid = MOD_VMID_TO_CORE(mod_vmid);
-
-		kfree(core_vmid);
-	}
-}

-- 
2.56.0


