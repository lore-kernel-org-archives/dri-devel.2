Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEF9C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4254E10EF9E;
	Thu, 20 Aug 2026 10:07:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEFA110EF76
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:57:44 +0000 (UTC)
X-UUID: 330729609c7511f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:f7d8f018-9880-40a7-ba2a-6f4d5abd966c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:7db8b62, CLOUDID:06338d0709258e0a4999645e9bf6f310,
 BulkI
 D:nil,BulkQuantity:0,SF:102|136|865|898|915,TC:nil,Content:0|15|50,EDM:5|-
 100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 330729609c7511f19a56ed5b684f684d-20260820
X-User: liupeng01@kylinos.cn
Received: from t14 [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <liupeng01@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 536093222; Thu, 20 Aug 2026 16:57:40 +0800
From: liupeng <liupeng01@kylinos.cn>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, zack.rusin@broadcom.com, christian.koenig@amd.com,
 bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, matthew.auld@intel.com,
 matthew.brost@intel.com, liupeng <liupeng01@kylinos.cn>
Subject: [PATCH 0/2] drm/ttm, vmwgfx: Fix typos in comments
Date: Thu, 20 Aug 2026 16:57:35 +0800
Message-ID: <20260820085737.52124-1-liupeng01@kylinos.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 10:07:27 +0000
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

Fix spelling mistakes in comments within the ttm and vmwgfx DRM
drivers. There are no functional changes.

liupeng (2):
  drm/ttm: Fix typo in comment
  drm/vmwgfx: Fix typos in comments

 drivers/gpu/drm/ttm/ttm_tt.c                           | 2 +-
 drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h | 2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c                    | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.53.0

