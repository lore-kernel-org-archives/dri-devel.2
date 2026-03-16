Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98844FB5E84
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B6010E3FD;
	Mon, 16 Mar 2026 22:44:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uTf5DBwZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44E010E3F7;
 Mon, 16 Mar 2026 22:44:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DBD2B60018;
 Mon, 16 Mar 2026 22:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6BEC19421;
 Mon, 16 Mar 2026 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773701044;
 bh=PemC648X76G2DJ8fhELK1LHng9M+AjeFzFwCebBzdn4=;
 h=From:To:Cc:Subject:Date:From;
 b=uTf5DBwZNlu8OGYNKo3KEgY97VX0dVkt0MZs0ls0glFBDWbEmjRw7IHQ2bbUCgEfV
 sUlloYUiLzdV06rDP/W+cfK3/IvUYIAGyNaAmbK5wAZ5WjYiz4IRZXTXRNs1U6ibct
 bK5LcHQG6tclhMUZzzypfa6kPz/yvsEA9VrKxfys476NaKltB5m8mL90bu0NiAxb98
 RBBVfJuutHLMgDUfO8uXMRCOUFQHockdNgT+L9rd2nn3tIfciKfm0JE/FCAa21yXBd
 RfLB2PhRUfG/T5i25f45jiwiL/ohclH55bq7PAD7iWiIpD6iE9zqw6xuwLEZv7RxIB
 ivZXFah+bhKkg==
From: Arnd Bergmann <arnd@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lucas De Marchi <demarchi@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
 Raag Jadav <raag.jadav@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe: use %z format string for ptrdiff_t
Date: Mon, 16 Mar 2026 23:43:46 +0100
Message-Id: <20260316224357.658520-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

ptrdiff_t, size_t and long are the same size on all supported architectures,
but gcc requires the use of the %zx modifier instead of %lx. On 32-bit
targets, the wrong one produces this warning:

drivers/gpu/drm/xe/xe_lrc.c:1913:7: error: format specifies type 'unsigned long' but the argument has type '__ptrdiff_t' (aka 'int') [-Werror,-Wformat]
 1912 |                 drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_NOOP (%d dwords)\n",
      |                                    ~~~~~
      |                                    %#5tx
 1913 |                            dw - num_noop - start, inst_header, num_noop);
      |                            ^~~~~~~~~~~~~~~~~~~~~

Fixes: 65fcf19cb36b ("drm/xe: Include running dword offset in default_lrc dumps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/xe_lrc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 5ab088e5e13d..c528818e8853 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1909,17 +1909,17 @@ static int dump_mi_command(struct drm_printer *p,
 		while (num_noop < remaining_dw &&
 		       (*(++dw) & REG_GENMASK(31, 23)) == MI_NOOP)
 			num_noop++;
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_NOOP (%d dwords)\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_NOOP (%d dwords)\n",
 			   dw - num_noop - start, inst_header, num_noop);
 		return num_noop;
 
 	case MI_TOPOLOGY_FILTER:
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_TOPOLOGY_FILTER\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_TOPOLOGY_FILTER\n",
 			   dw - start, inst_header);
 		return 1;
 
 	case MI_BATCH_BUFFER_END:
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_BATCH_BUFFER_END\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_BATCH_BUFFER_END\n",
 			   dw - start, inst_header);
 		/* Return 'remaining_dw' to consume the rest of the LRC */
 		return remaining_dw;
@@ -1934,35 +1934,35 @@ static int dump_mi_command(struct drm_printer *p,
 
 	switch (inst_header & MI_OPCODE) {
 	case MI_LOAD_REGISTER_IMM:
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_LOAD_REGISTER_IMM: %d regs\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_LOAD_REGISTER_IMM: %d regs\n",
 			   dw - start, inst_header, (numdw - 1) / 2);
 		for (int i = 1; i < numdw; i += 2)
-			drm_printf(p, "LRC[%#5lx]  =  - %#6x = %#010x\n",
+			drm_printf(p, "LRC[%#5zx]  =  - %#6x = %#010x\n",
 				   &dw[i] - start, dw[i], dw[i + 1]);
 		return numdw;
 
 	case MI_LOAD_REGISTER_MEM & MI_OPCODE:
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_LOAD_REGISTER_MEM: %s%s\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_LOAD_REGISTER_MEM: %s%s\n",
 			   dw - start, inst_header,
 			   dw[0] & MI_LRI_LRM_CS_MMIO ? "CS_MMIO " : "",
 			   dw[0] & MI_LRM_USE_GGTT ? "USE_GGTT " : "");
 		if (numdw == 4)
-			drm_printf(p, "LRC[%#5lx]  =  - %#6x = %#010llx\n",
+			drm_printf(p, "LRC[%#5zx]  =  - %#6x = %#010llx\n",
 				   dw - start,
 				   dw[1], ((u64)(dw[3]) << 32 | (u64)(dw[2])));
 		else
-			drm_printf(p, "LRC[%#5lx]  =  - %*ph (%s)\n",
+			drm_printf(p, "LRC[%#5zx]  =  - %*ph (%s)\n",
 				   dw - start, (int)sizeof(u32) * (numdw - 1),
 				   dw + 1, numdw < 4 ? "truncated" : "malformed");
 		return numdw;
 
 	case MI_FORCE_WAKEUP:
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_FORCE_WAKEUP\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_FORCE_WAKEUP\n",
 			   dw - start, inst_header);
 		return numdw;
 
 	default:
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown MI opcode %#x, likely %d dwords\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] unknown MI opcode %#x, likely %d dwords\n",
 			   dw - start, inst_header, opcode, numdw);
 		return numdw;
 	}
@@ -1989,12 +1989,12 @@ static int dump_gfxpipe_command(struct drm_printer *p,
 	switch (*dw & GFXPIPE_MATCH_MASK) {
 #define MATCH(cmd) \
 	case cmd: \
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] " #cmd " (%d dwords)\n", \
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] " #cmd " (%d dwords)\n", \
 			   dw - start, *dw, numdw); \
 		return numdw
 #define MATCH3D(cmd) \
 	case CMD_##cmd: \
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] " #cmd " (%d dwords)\n", \
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] " #cmd " (%d dwords)\n", \
 			   dw - start, *dw, numdw); \
 		return numdw
 
@@ -2127,7 +2127,7 @@ static int dump_gfxpipe_command(struct drm_printer *p,
 	MATCH3D(3DSTATE_SLICE_TABLE_STATE_POINTER_2);
 
 	default:
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown GFXPIPE command (pipeline=%#x, opcode=%#x, subopcode=%#x), likely %d dwords\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] unknown GFXPIPE command (pipeline=%#x, opcode=%#x, subopcode=%#x), likely %d dwords\n",
 			   dw - start, *dw, pipeline, opcode, subopcode, numdw);
 		return numdw;
 	}
@@ -2153,7 +2153,7 @@ static int dump_gfx_state_command(struct drm_printer *p,
 	MATCH(STATE_WRITE_INLINE);
 
 	default:
-		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown GFX_STATE command (opcode=%#x), likely %d dwords\n",
+		drm_printf(p, "LRC[%#5zx]  =  [%#010x] unknown GFX_STATE command (opcode=%#x), likely %d dwords\n",
 			   dw - start, *dw, opcode, numdw);
 		return numdw;
 	}
@@ -2188,7 +2188,7 @@ void xe_lrc_dump_default(struct drm_printer *p,
 			num_dw = dump_gfx_state_command(p, gt, start, dw, remaining_dw);
 		} else {
 			num_dw = min(instr_dw(*dw), remaining_dw);
-			drm_printf(p, "LRC[%#5lx]  =  [%#10x] Unknown instruction of type %#x, likely %d dwords\n",
+			drm_printf(p, "LRC[%#5zx]  =  [%#10x] Unknown instruction of type %#x, likely %d dwords\n",
 				   dw - start,
 				   *dw, REG_FIELD_GET(XE_INSTR_CMD_TYPE, *dw),
 				   num_dw);
-- 
2.39.5

