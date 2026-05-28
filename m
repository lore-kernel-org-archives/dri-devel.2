Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF7CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 06:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B22410EC84;
	Thu, 28 May 2026 06:25:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0CA10EC83;
 Thu, 28 May 2026 06:25:02 +0000 (UTC)
X-UUID: f1a1e8245a5d11f1aa26b74ffac11d73-20260528
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:47b85aec-c703-45a6-a6ea-707a68fd1a54, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:dfea1ffa914e6bb19f8e86e475370c8b,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1a1e8245a5d11f1aa26b74ffac11d73-20260528
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zenghongling@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1834466798; Thu, 28 May 2026 14:24:55 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, airlied@redhat.com, ttabi@nvidia.com, bskeggs@nvidia.com,
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
Date: Thu, 28 May 2026 14:24:46 +0800
Message-Id: <20260528062451.54107-1-zenghongling@kylinos.cn>
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

This patch series cleans up redundant IS_ERR_OR_NULL() checks in the
nouveau GSP-RM code.

The core GSP-RM functions already return error pointers via IS_ERR()
checks. Using IS_ERR_OR_NULL() is redundant and adds unnecessary NULL
checks.

This series is organized as follows:
- Patch 1: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rm_alloc_get/alloc
- Patch 2: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd
- Patch 3: Cleanup IS_ERR_OR_NULL in core implementation
- Patch 4: Cleanup WARN_ON(IS_ERR_OR_NULL) across multiple files
- Patch 5: Cleanup remaining IS_ERR_OR_NULL usage

After this cleanup:
- Error handling is consistent with the rest of the kernel
- Code is simpler and more maintainable
- The intent is clearer (checking for error pointers, not NULL)

Hongling Zeng (5):
  nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions
  nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd
  nouveau/gsp/rm: cleanup IS_ERR_OR_NULL in core implementation
  nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)
  nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage

 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h    | 4 ++--
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c  | 4 ++--
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c   | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c  | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvenc.c | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ofa.c   | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c   | 8 ++++----
 7 files changed, 14 insertions(+), 14 deletions(-)

--
2.25.1
