Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FB1CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD6210EF1F;
	Wed, 20 May 2026 07:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.b="fPq9HNtE";
	dkim-atps=neutral
X-Greylist: delayed 448 seconds by postgrey-1.36 at gabe;
 Tue, 19 May 2026 14:53:19 UTC
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E4510ED56;
 Tue, 19 May 2026 14:53:19 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gKct30mMpzDvNT;
 Tue, 19 May 2026 16:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779201947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YQU4ivIdjjL1ZhRZIDFlRUv7sSpl+HPITDd5i1bcM8I=;
 b=fPq9HNtET3CT0gfeEqQrESL6ndpCzyO0uwlTGcpSIGiWmwCWN0wvLiHPZoyM3DSyRgubwG
 4v6eJuGJFXpVwnUh47VGTu+y4RXWMJVOvYYUEkh5GC+ZBdZg6pdguBUFblpko+F0xCdw49
 ebc98bKMD/oETsf7fKpd40UzM4KnGwieKRSUllFZvXIUX6yQy1OC5j+RBCXe2jZrN/iUyl
 675m9z6Bz2WDkbG4A+WVmIP57cVVcdsbFLS/5FI2oPeswJvcFCHHZZuxfTg1Is8F4TPOEW
 i6RyCa48y51FTlqKw1wG0Hl6t6u/92dSoNlInjfP3PHD/gR1ByZ43OfrBZpu6A==
From: Antonio Quartulli <antonio@mandelbit.com>
To: amd-gfx@lists.freedesktop.org
Cc: antonio@mandelbit.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, martin.leung@amd.com, bpinnint@amd.com,
 aurabindo.pillai@amd.com, Muhammad.Ahmed@amd.com, Karen.Chen@amd.com,
 leo.chen@amd.com, gaghik.khachatrian@amd.com, roman.li@amd.com,
 wayne.lin@amd.com, nicholas.kazlauskas@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, siqueira@igalia.com, simona@ffwll.ch,
 airlied@gmail.com, sunpeng.li@amd.com, harry.wentland@amd.com
Subject: [RFC] amdgpu: fix compressed buffer config routine waiting time
Date: Tue, 19 May 2026 16:45:09 +0200
Message-ID: <20260519144509.2646680-1-antonio@mandelbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

Starting with commit 592c5b80110d5 ("drm/amd/display: Migrate HUBBUB register access from hwseq to hubbub component.")
the amdgpu driver is reporting the following WARNING in the kernel log
during boot time:

[   15.464476] amdgpu 0000:0c:00.0: [drm] REG_WAIT timeout 1us * 100 tries - dcn31_program_compbuf_size line:141
[   15.464522] ------------[ cut here ]------------
[   15.464523] !(generic_reg_get(hubbub2->base.ctx, hubbub2->regs->DCHUBBUB_COMPBUF_CTRL, hubbub2->shifts->CONFIG_ERROR, hubbub2->masks->CONFIG_ERROR, &compbuf_size_segments) && !compbuf_size_segments)
[   15.464524] WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/hubbub/dcn31/dcn31_hubbub.c:151 at dcn31_program_compbuf_size+0x20e/0x220 [amdgpu], CPU#2: kworker/2:2/184
[   15.464906] Workqueue: events drm_mode_rmfb_work_fn
[   15.464910] RIP: 0010:dcn31_program_compbuf_size+0x20e/0x220 [amdgpu]
[   15.465200]  <TASK>
[   15.465202]  dcn20_optimize_bandwidth+0x110/0x210 [amdgpu]
[   15.465556]  dc_commit_state_no_check+0x14ff/0x18a0 [amdgpu]
[   15.465925]  dc_commit_streams+0x471/0x640 [amdgpu]
[   15.466252]  amdgpu_dm_atomic_commit_tail+0x903/0x4430 [amdgpu]
[   15.467401]  commit_tail+0x242/0x2e0
[   15.467405]  drm_atomic_helper_commit+0x28b/0x2a0
[   15.467407]  drm_atomic_commit+0xc3/0xf0
[   15.467416]  drm_mode_rmfb_work_fn+0x85/0xb0
[   15.467436]  ret_from_fork_asm+0x1a/0x30
[   15.467441]  </TASK>

After boot this results in unstable video output, specifically after
resuming from screen sleep. The video may not come back at all
or may come up partly messed up.

This problem seems to affect various people on AMD iGPU, as discussed
on the related GitHub issue.

Giuseppe Ranieri digged up the issue and suggested the proposed code
change.

There was also a previous report on the amd-gfx ml (see related link below)
but it got nowhere.

By looking at the offending commit I am not truly able to understand why
it is breaking. Hence I am posting this patch as RFC only.

What I can say is that this fix has been solid on my platform running
7.1.0-rc3 with this patch.

I am on:
Gigabyte Technology Co., Ltd. B850M DS3H/B850M DS3H + AMD Ryzen 9 9950X

Fixes: 592c5b80110d5 ("drm/amd/display: Migrate HUBBUB register access from hwseq to hubbub component.")
Link: https://github.com/CachyOS/linux-cachyos/issues/810
Link: https://lore.kernel.org/amd-gfx/20260316094232.6bb6f0bf@schienar/
Suggested-by: Giuseppe Ranieri
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 .../gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 3c298192f3596..9dc1db4524500 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -138,10 +138,10 @@ static void dcn31_program_compbuf_size(struct hubbub *hubbub, unsigned int compb
 
 	if (safe_to_increase || compbuf_size_segments <= hubbub2->compbuf_size_segments) {
 		if (compbuf_size_segments > hubbub2->compbuf_size_segments) {
-			REG_WAIT(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, hubbub2->det0_size, 1, 100);
-			REG_WAIT(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, hubbub2->det1_size, 1, 100);
-			REG_WAIT(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, hubbub2->det2_size, 1, 100);
-			REG_WAIT(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, hubbub2->det3_size, 1, 100);
+			dcn31_wait_for_det_apply(hubbub, 0);
+			dcn31_wait_for_det_apply(hubbub, 1);
+			dcn31_wait_for_det_apply(hubbub, 2);
+			dcn31_wait_for_det_apply(hubbub, 3);
 		}
 		/* Should never be hit, if it is we have an erroneous hw config*/
 		ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
-- 
2.53.0

