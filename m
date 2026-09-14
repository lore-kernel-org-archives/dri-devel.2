Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD31C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AD010F9FB;
	Tue, 15 Sep 2026 07:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cyberprotect.ru header.i=@cyberprotect.ru header.b="jQgUtWJm";
	dkim=permerror (0-bit key) header.d=cyberprotect.ru header.i=@cyberprotect.ru header.b="iH+0PQWr";
	dkim-atps=neutral
Received: from mx2.cyberprotect.ru (mx2.cyberprotect.ru [176.10.93.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD6310EF66;
 Mon, 14 Sep 2026 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim-r; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=RdvBOVnEKQdDMFBx5aH72LXneDiwa7iML9qml3N/n84=; b=jQgUtWJmwNKw1hsXIaa+KnSSfo
 fZGI8a9YpV01Tor+l0gK6kmC5kSEiZL4xsR6a0+FWXhcela7Cx7abQISYIrNiVgCAzUppfOyskxd9
 ZOJDz7QfoQB6dvhPhoEu0jBwJjXx+loDO6o49dbk8l15nuJJF0XfqbUvvUpLzA6N+oUN+BIROlYmF
 5mRS07PG62zUh8YNKOuT2ARVjmJ/8Fng+eeeoaGIpTEjA5eBAbJY8KwwoFr/m3T5NgA/qcyAZYAp+
 RKLrdAskaorCHc722Iimdr/FQXaDsq7MU77PA0f6LOHLkgx0zvrIVE2RdkxUhiIPODESF2Z7ndneJ
 5TkY2/RQ==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=RdvBOVnEKQdDMFBx5aH72LXneDiwa7iML9qml3N/n84=; b=iH+0PQWr4FzqmqQctLMfFKUiaq
 G+UVxyqir2zVBRTA5K0Q5xjWLJiAlGG0/zpjxhckkuCfNiOZn9GTdsZYh4Cw==;
From: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
To: Austin Zheng <austin.zheng@amd.com>
CC: Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Dillon Varone <dillon.varone@amd.com>, Nicholas Carbones
 <Nicholas.Carbones@amd.com>, Wayne Lin <wayne.lin@amd.com>, Ray Wu
 <ray.wu@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Dmitriy
 Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
Subject: [PATCH] drm/amd/display: guard NULL secondary pipe in
 dcn_validate_bandwidth()
Date: Mon, 14 Sep 2026 18:14:46 +0300
Message-ID: <20260914151446.94380-1-Dmitry.Chumachenko@cyberprotect.ru>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.0.30]
X-ClientProxiedBy: AIP-EXCH-1.aip.ooo (10.77.28.101) To AIP-EXCH-1.aip.ooo
 (10.77.28.101)
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:27:57 +0000
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

resource_find_free_secondary_pipe_legacy() returns NULL when no free
pipe is available, but the result is only passed to ASSERT() (a
WARN_ON_ONCE() that does not stop execution) and then dereferenced in
split_stream_across_pipes() and dcn_bw_calc_rq_dlg_ttu().

The sibling resource callers (dcn10/dcn20/dcn201) already NULL-check
this function's result. Do the same here and skip the split when no
free pipe is available.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 74c49c7ac14f ("drm/amdgpu/display: Add calcs code for DCN")
Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
---
 drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 61553e24d53e..de54807ade43 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -1261,10 +1261,12 @@ bool dcn_validate_bandwidth(
 						/* pipe not split previously needs split */
 						hsplit_pipe = resource_find_free_secondary_pipe_legacy(&context->res_ctx, pool, pipe);
 						ASSERT(hsplit_pipe);
-						split_stream_across_pipes(&context->res_ctx, pool, pipe, hsplit_pipe);
+						if (hsplit_pipe)
+							split_stream_across_pipes(&context->res_ctx, pool, pipe, hsplit_pipe);
 					}
 
-					dcn_bw_calc_rq_dlg_ttu(dc, v, hsplit_pipe, input_idx);
+					if (hsplit_pipe)
+						dcn_bw_calc_rq_dlg_ttu(dc, v, hsplit_pipe, input_idx);
 				} else if (hsplit_pipe && hsplit_pipe->plane_state == pipe->plane_state) {
 					/* merge previously split pipe */
 					pipe->bottom_pipe = hsplit_pipe->bottom_pipe;
-- 
2.49.0

