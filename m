Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF18CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 04:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475FE10F87E;
	Fri, 29 May 2026 04:43:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DB710F87A;
 Fri, 29 May 2026 04:43:43 +0000 (UTC)
X-UUID: f4b46b205b1811f1aa26b74ffac11d73-20260529
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:b145bf94-5b2a-4fa2-bebc-6556a60e8fbe, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:76aae8069c6d673d2c1e12c0709a837c,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
 0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f4b46b205b1811f1aa26b74ffac11d73-20260529
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zenghongling@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 118597435; Fri, 29 May 2026 12:43:36 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, airlied@redhat.com, ttabi@nvidia.com, bskeggs@nvidia.com,
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH 0/7] nouveau/gsp: Fix NULL pointer dereference and cleanup
 IS_ERR_OR_NULL
Date: Fri, 29 May 2026 12:43:23 +0800
Message-Id: <20260529044330.96832-1-zenghongling@kylinos.cn>
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

This patch series fixes NULL pointer dereference bugs introduced in the
previous IS_ERR_OR_NULL cleanup series and adds documentation as requested
by Danilo Krummrich.

Background

The previous IS_ERR_OR_NULL cleanup series introduced serious bugs that
caused actual kernel crashes:

  BUG: kernel NULL pointer dereference, address: 000000000000002c
  RIP: 0010:r535_gsp_rpc_rm_ctrl_push+0x60/0x110 [nouveau]

The root cause was that underlying functions (r535_gsp_msgq_recv() and
r535_gsp_msg_recv()) could return NULL, but the upper layers only checked
with IS_ERR(), missing the NULL cases.

Changes in V2

Compared to the previous series, this version:

1. **Fixes underlying functions first** (Patch 1)
   - r535_gsp_msgq_recv(): Return ERR_PTR(-EINVAL) instead of NULL
   - r535_gsp_msg_recv(): Return ERR_PTR(-EIO) instead of NULL
   
2. **Adds documentation** (Patch 2, per Danilo's request)
   - Kernel-doc comments for all affected functions
   - Clear return value contracts: "never NULL"
   
3. **Safe cleanup** (Patches 3-7)
   - IS_ERR_OR_NULL() -> IS_ERR() now safe
   - No NULL pointer dereference risks

Hongling Zeng (7):
  nouveau/gsp/rm: Fix NULL return values in message receive  functions
  nouveau/gsp: Add documentation for RPC functions return  values
  nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd
  nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions
  nouveau/gsp: cleanup IS_ERR_OR_NULL in core  implementation
  nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)
  nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage

 .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  8 +--
 .../nouveau/nvkm/subdev/gsp/rm/r535/alloc.c   |  4 +-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c |  2 +-
 .../nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c    |  2 +-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c | 55 ++++++++++++++++---
 5 files changed, 55 insertions(+), 16 deletions(-)

-- 
2.25.1
