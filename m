Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6AFFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EAA10E1CB;
	Tue,  5 May 2026 22:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ZqkB51Gx";
	dkim-atps=neutral
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A678110E1CB
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:27:49 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-c7ffe8eeaf2so1640602a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020069; x=1778624869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RkYkweVqiLjHd6nDA8uZMmZt+cHr4cYV5wff2Vr4jcU=;
 b=lDc4KUF8hv0AWKcOzon6av3veBqfu+OqN7FkNyGck3s6KXX8LxHN7aXPcYZ/8BYKMZ
 gIriFLZYipvAI9EAXHMCG/B/OlJjTDkMxau/fofPsmbO/WERQLdq2UUMMMDOxkxAPvms
 UOjCQ57DUklJPQ5rBkFOAkWsyFcWOeaAbw5I+s2l0rF+Qb6J4XHbC8btKZyj3Pe+LR96
 RpuzlvBJ1h7DRp2sMiB9kYNNX5HIBGMaXjL3kqjMD7EZasq8mrWTiF2nlRiCnCSWCQsZ
 amN5OpWYZkyy/wXKK0g1rE5pRRYw6QqQ3klbHUanDHZVVzGvc1rG6255eJJjFs4sokI7
 mAlg==
X-Gm-Message-State: AOJu0YwE4l4yWERtUKkCYdPK1fNi2vIIO6Ub1waD+d8A2zerTZtV1mm+
 KeJWsbc7DqhLzDCLKO5v89+ZZpehrwUWGQPHw6PFYYtiPcCgQawDJWCpgiqPJn2oXXJZvP1l5M3
 3jYgeV3geHZzYdEQe6qHDy7J4PQVTs8CK11vKybdDHmoeZWv5PJCBP3hrk8miQKyeSyibeWGoaL
 UhqhEV1yGbzsci18tVtX4PhozLPo3P3yWdYW8Ng6t/HltwQIBxHMtaZw4IqGxrKdstcXw7D5pD7
 UdNCB3GiW8+RyZBqiEH
X-Gm-Gg: AeBDievbU9axcXiiY3KS385BHIPSsjH114KIVeNbZzjEnXSEZEQuAO/DNekEcH8UjM/
 AXDsfp4kFgvyHol03/4MzkUXBcO5ZyfhWq8HiTsQ50BzWYcXej0MNMGzyuKgY9UGyoQ3RC2E99K
 +XikbrMVgfMaQSPL44UlodPlEoUjAd9CddZUUlP18ThThYcrkQC8Hdfpqunx3iFnXl94Ip/rqpQ
 Qry50HcfSlTZ/LoSBc7iBqsz9FazYXe9CdNKG+4xthwokWYdiEERSYMz/nG9ss6duYTWKg7/zsl
 DFdTnPRTWVPjeOiJxm8ldXpNKRsFk6lRbImmocvG36u6xxq4HV2gggtjvpnk2QMZR44xrlvUlO1
 62dxmi7z7tbLuktHsRmI/9K7okehFtnzNxqTq4/RoXEzBcI+kwAvKFpjZ38sGYeXsmOxJ8XtFKg
 yH9QUu2llOzyVqh2t8llZHV1bTEyy3FCUtTyHX0H8BxNlsxisyKuV55bfY3mHhKxH/JfU=
X-Received: by 2002:a05:6a21:33a7:b0:39b:edcd:d92f with SMTP id
 adf61e73a8af0-3aa5a9056dfmr713415637.11.1778020069026; 
 Tue, 05 May 2026 15:27:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-c82429b4224sm33777a12.0.2026.05.05.15.27.48
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b513f57611so136883466d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020067; x=1778624867;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkYkweVqiLjHd6nDA8uZMmZt+cHr4cYV5wff2Vr4jcU=;
 b=ZqkB51Gx7pAz0bdueuDeHaor+O0nvVgQ4d5ZMX2L6fI5tXqgxNvZfxyT1vgp7Eo39w
 dQY2Sa9bUwk0EH3DhWhxjY8vvif8FNBJurIEg/Y/jU0UPYnJh7mDosN7udgQv1ZWv5Uh
 2DfmJQ8S8wm3XMHufZqnlrtR//e2r7YWMA6Sg=
X-Received: by 2002:a0c:e01a:0:b0:89c:6bc6:e4fd with SMTP id
 6a1803df08f44-8bc43cfdc0fmr10093176d6.19.1778020066917; 
 Tue, 05 May 2026 15:27:46 -0700 (PDT)
X-Received: by 2002:a0c:e01a:0:b0:89c:6bc6:e4fd with SMTP id
 6a1803df08f44-8bc43cfdc0fmr10092836d6.19.1778020066420; 
 Tue, 05 May 2026 15:27:46 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:44 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 02/12] drm/vmwgfx: reject DX_BIND_QUERY without a DX context
Date: Tue,  5 May 2026 18:22:23 -0400
Message-ID: <20260505222728.519626-3-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

vmw_cmd_dx_bind_query() unconditionally dereferences
sw_context->dx_ctx_node->ctx.  Userspace can trigger a NULL pointer
dereference from any render-node fd by submitting an execbuf with
dx_context_handle == SVGA3D_INVALID_ID and a SVGA_3D_CMD_DX_BIND_QUERY
opcode in the command stream: dx_ctx_node is left NULL and the kernel
oopses on the assignment.  The same NULL is then re-read in
vmw_resources_reserve() via vmw_context_get_dx_query_mob().

All sibling DX handlers fail-close on a missing dx_ctx_node using
VMW_GET_CTX_NODE().  Use the same pattern here, returning -EINVAL up
front before any relocation state is published.

Fixes: 9c079b8ce8bf ("drm/vmwgfx: Adapt execbuf to the new validation api")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index e1f18020170a..b07f052474d0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1272,9 +1272,13 @@ static int vmw_cmd_dx_bind_query(struct vmw_private *dev_priv,
 				 SVGA3dCmdHeader *header)
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXBindQuery);
+	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
 	struct vmw_bo *vmw_bo;
 	int ret;
 
+	if (!ctx_node)
+		return -EINVAL;
+
 	cmd = container_of(header, typeof(*cmd), header);
 
 	/*
@@ -1288,7 +1292,7 @@ static int vmw_cmd_dx_bind_query(struct vmw_private *dev_priv,
 		return ret;
 
 	sw_context->dx_query_mob = vmw_bo;
-	sw_context->dx_query_ctx = sw_context->dx_ctx_node->ctx;
+	sw_context->dx_query_ctx = ctx_node->ctx;
 	return 0;
 }
 
-- 
2.51.0

