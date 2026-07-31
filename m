Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4B0C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 01:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4725010F0E8;
	Fri, 31 Jul 2026 01:19:45 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB4910E1A0;
 Fri, 31 Jul 2026 01:19:43 +0000 (UTC)
X-UUID: e561e40e8c7d11f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:e48fef93-5770-4747-a7aa-a744f4e1f998, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:e7bac3a, CLOUDID:415c5db3cb79a246ce949e9484b88b80,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
 :0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e561e40e8c7d11f1aa26b74ffac11d73-20260731
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <lilinmao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 625510942; Fri, 31 Jul 2026 09:19:37 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
 Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v2] drm/xe/oa: Fix sync entry leak on OA config emit failure
Date: Fri, 31 Jul 2026 09:19:32 +0800
Message-Id: <20260731011932.3426219-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260715023332.391298-1-lilinmao@kylinos.cn>
References: <20260715023332.391298-1-lilinmao@kylinos.cn>
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

xe_oa_emit_oa_config() releases the sync entries and the syncs array
only on its success path. When it fails before the point of no return
(fence allocation, config buffer allocation or batch submission), it
returns without touching stream->syncs.

The stream open path handles such failures in the caller, but
xe_oa_config_locked() propagates the error without any cleanup, so the
syncs array and the fence references held by the parsed entries are
leaked. The next config ioctl overwrites stream->syncs, making the
memory unreachable for good.

Clean up the parsed syncs when xe_oa_emit_oa_config() fails, matching
the cleanup done by the stream open error path.

Fixes: 9920c8b88c5c ("drm/xe/oa: Add syncs support to OA config ioctl")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
v2:
- drop the stream->syncs/num_syncs reset; nothing dereferences them
  before they are overwritten or the stream is destroyed (Ashutosh Dixit)

 drivers/gpu/drm/xe/xe_oa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index b3acbcd678b7c..d334ce8fed1c2 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1594,6 +1594,10 @@ static long xe_oa_config_locked(struct xe_oa_stream *stream, u64 arg)
 		config = xchg(&stream->oa_config, config);
 		drm_dbg(&stream->oa->xe->drm, "changed to oa config uuid=%s\n",
 			stream->oa_config->uuid);
+	} else {
+		while (param.num_syncs--)
+			xe_sync_entry_cleanup(&param.syncs[param.num_syncs]);
+		kfree(param.syncs);
 	}
 
 err_config_put:
-- 
2.25.1

