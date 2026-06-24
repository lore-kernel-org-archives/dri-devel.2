Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9686DCDB470
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E51D10EDDD;
	Wed, 24 Jun 2026 07:48:00 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2690410E002
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 03:11:54 +0000 (UTC)
X-UUID: 70cad3f06f7a11f1aa26b74ffac11d73-20260624
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
 DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:40cce9cb-9cbd-4073-bc3d-8fa85a66feb8, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:40cce9cb-9cbd-4073-bc3d-8fa85a66feb8, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:c8cbf633666dd95c95bf9c332716aa7e,
 BulkI
 D:260624111150J8X2XGI2,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
 850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
 :nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
 BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 70cad3f06f7a11f1aa26b74ffac11d73-20260624
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <lihongfu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 900636280; Wed, 24 Jun 2026 11:11:49 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
 skhan@linuxfoundation.org, dev@lankhorst.se, mripard@kernel.org,
 natalie.vock@gmx.de
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH 0/2] cgroup/dmem: add per-region event counters
Date: Wed, 24 Jun 2026 11:11:05 +0800
Message-Id: <20260624031107.667253-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

This patch series adds event counters to the device memory (dmem) cgroup
controller.

The dmem controller exposes per-region limits and current usage, but
not how often those limits are hit.  It is hard to tell whether failures
come from this cgroup, a parent limit, or pressure elsewhere in the
hierarchy.

To provide that visibility, this series introduces:
  - dmem.events:       reports hierarchical low/max counts per region.
  - dmem.events.local: reports per-region low/max counts for this cgroup only.

Patch overview:

Patch 1/2:
  - Add dmem.events with hierarchical low/max counters per region.
  - Record dmem.max allocation failures and dmem.low protection events.
  - Document the interface in cgroup-v2.rst.

Patch 2/2:
  - Add dmem.events.local for local-only per-region counts.
  - Share the events show logic between both files.
  - Update cgroup-v2.rst accordingly.

Example output (dmem.events):

  drm/0000:03:00.0/vram0 low 0 max 3
  drm/0000:03:00.0/stolen low 0 max 0

  low  - reclaim/eviction considered the cgroup below its effective
         dmem.low protection
  max  - allocation failed because the cgroup or an ancestor hit dmem.max

Both files exist for all non-root cgroups, like dmem.max and dmem.current.

These patches have been tested locally.

Hongfu Li (2):
  cgroup/dmem: add per-region event counters
  cgroup/dmem: introduce dmem.events.local for local counts

 Documentation/admin-guide/cgroup-v2.rst | 17 +++++
 kernel/cgroup/dmem.c                    | 85 ++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

-- 
2.25.1

