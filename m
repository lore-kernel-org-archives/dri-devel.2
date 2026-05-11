Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A3CCD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD7610ED11;
	Wed, 13 May 2026 07:54:09 +0000 (UTC)
X-Greylist: delayed 310 seconds by postgrey-1.36 at gabe;
 Mon, 11 May 2026 01:37:43 UTC
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A71010E1CC
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 01:37:42 +0000 (UTC)
X-UUID: 3ee7ca8c4cd911f1aa26b74ffac11d73-20260511
X-CTIC-Tags: HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT,
 HR_CC_NAME
 HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
 HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
 HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
 HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED
 SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
 SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:0dadb1d9-fc00-46eb-9c24-6964d252f479, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:5
X-CID-INFO: VERSION:1.3.12, REQID:0dadb1d9-fc00-46eb-9c24-6964d252f479, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:5
X-CID-META: VersionHash:e7bac3a, CLOUDID:2a158005b00c5f2b5b8174380fdfa6ca,
 BulkI
 D:260511093220H3SA01AH,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
 898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3ee7ca8c4cd911f1aa26b74ffac11d73-20260511
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <zhangguopeng@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1407271403; Mon, 11 May 2026 09:32:17 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] cgroup/dmem: return -ENOMEM on failed pool preallocation
Date: Mon, 11 May 2026 09:31:50 +0800
Message-ID: <20260511013150.7235-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

get_cg_pool_unlocked() handles allocation failures under dmemcg_lock by
dropping the lock, preallocating a pool with GFP_KERNEL, and retrying the
locked lookup and creation path.

If the fallback allocation fails too, pool remains NULL. Since the loop
condition is while (!pool), the function can keep retrying instead of
propagating the allocation failure to the caller.

Set pool to ERR_PTR(-ENOMEM) when the fallback allocation fails so the
loop exits through the existing common return path. The callers already
handle ERR_PTR() from get_cg_pool_unlocked(), so this restores the
expected error path.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 kernel/cgroup/dmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f271..4753a67d0f0f 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -602,6 +602,7 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 				pool = NULL;
 				continue;
 			}
+			pool = ERR_PTR(-ENOMEM);
 		}
 	}
 
-- 
2.43.0

