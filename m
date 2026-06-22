Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D7ECDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9720A10E51B;
	Mon, 22 Jun 2026 08:11:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE92110E518;
 Mon, 22 Jun 2026 08:11:47 +0000 (UTC)
X-UUID: fff8b6d86e1111f1aa26b74ffac11d73-20260622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:5bd37a21-658a-4cde-99c4-f31a6adefd33, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:5f5000d66a81ab37ee1d7ad362603bfd,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fff8b6d86e1111f1aa26b74ffac11d73-20260622
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zenghongling@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 979842419; Mon, 22 Jun 2026 16:11:41 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, airlied@redhat.com, ttabi@nvidia.com, bskeggs@nvidia.com,
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH v5 0/5] nouveau/gsp: Clean up IS_ERR vs IS_ERR_OR_NULL usage
Date: Mon, 22 Jun 2026 16:11:31 +0800
Message-Id: <20260622081136.61695-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

This series addresses feedback from Danilo Krummrich and Timur Tabi
regarding the use of IS_ERR() vs IS_ERR_OR_NULL() in the nouveau
GSP RPC code.

The key insight is that we should align error checking with the actual
return value contracts of each function:
- Functions that never return NULL should use IS_ERR()
- Functions that can return NULL should use IS_ERR_OR_NULL()

This version adds documentation to clarify the return value contracts,
making it easier for maintainers to validate future changes.

Return Value Analysis

After thorough code analysis, the RPC functions are categorized as:

Never return NULL (use IS_ERR):**
- r535_gsp_msgq_peek()
- r535_gsp_msgq_recv_one_elem()
- r535_gsp_rpc_get()

CAN return NULL (use IS_ERR_OR_NULL):**
- r535_gsp_msgq_recv() - returns NULL when RPC length is invalid
- r535_gsp_msg_recv() - returns NULL when queue drained
- r535_gsp_rpc_handle_reply() - returns NULL for NOWAIT/NOSEQ policies
- r535_gsp_rpc_send() - can return NULL via handle_reply
- r535_gsp_rpc_push() - can return NULL via handle_reply

Changes in v2

- Added kernel-doc comments documenting return value contracts for all
  RPC functions
- Cleaned up incorrect IS_ERR_OR_NULL() usage for functions that never
  return NULL
- Kept IS_ERR_OR_NULL() in places where NULL is actually possible
- Added Fixes tags to all patches

Testing

This fixes the NULL pointer dereference oops that occurs during
nouveau initialization on some systems.

Patches

Hongling Zeng (5):
  nouveau/gsp/rpc: Document RPC function return value contracts
  nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c
  nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
  nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage
  nouveau/gsp: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd()

 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h   | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c  | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c  | 81 ++++++++++++++++++-
 4 files changed, 81 insertions(+), 6 deletions(-)
