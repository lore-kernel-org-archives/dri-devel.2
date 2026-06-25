Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4809DCDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C03210F474;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="e21l9zR2";
	dkim-atps=neutral
Received: from SY5PR01CU010.outbound.protection.outlook.com
 (mail-australiaeastazolkn19012067.outbound.protection.outlook.com
 [52.103.72.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104EA10E1D2;
 Thu, 25 Jun 2026 11:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfhMZW85VptMRaXlP77injUK4TrgMj/JMN48vfoNlqOI8aj1/zmQimUC2JfrQx/Ol6uO9jHGQXQwSyJzbV0HkSg6rMj2D4Xwy8xi3PkYOJ/VxjQC/qKnULHAQW2jlqkT1IPHKQqv8z05leFWUtYSP+3gobzmBjA8QtzQOsLus/8xjY2egSkZmlaUEnn3s3b6ORY5GB5R+AL5lSnOmjUE9mzu1p0cUmHkFrxwQ2EW9I1pZ1r1K12OpEavdbPpjUrAfl7ewHea0wuYZN4EJAJ2+8gVfWei6Lo+7WalaUrbiZRtM+iK5Kz0bhq+L2VVM/IQLGRUWcSHo/Sbs4zxaqzTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTczvt0gPSfN1SkRS2gBttZyynqdIzQ0CvBkdRrStTc=;
 b=cKL6QqUfeHOcoDy3OTiiCCsxTog1zuWt5UaJKcsiLOZTOqS1z+xgge2NkW2FlegU7wuiOdVxwCgU7+LomEaaKaZHCuXXvjJn64HVZNt4SsM3jMqpkutv9Q1inF6j4WkHnC8mTXUx3y2fTi4ozwKJIOa0tBsdVe9h0d3P8q/gj80qyoDnCDwuztsTrfcXgm//TpGc8W4IZMlwXKNhvPcKpg56p1lUpmvjjp4z3BvBbHFr73OkPc2ix3Kyt7FWsWZeOrU3Eegr7YHSxbR1GLGj/DIJLCgv+ZImFQiU4FJq6TbPYH8TOqn3J0dTvHMoPV2LubpwD0oQvYdSEsnx/KkS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTczvt0gPSfN1SkRS2gBttZyynqdIzQ0CvBkdRrStTc=;
 b=e21l9zR2V28BdzNQzICu2oIPwBuFvcnvIBXi2AM27nqDELG7Q5NGC4hCwqWj4i2jppUI/nu8NA9ovBOB2w8asLl0SvHMsPbvV4JDNNt63xhGANKP3oPjZlfFkRHL0Y8dI7IRWpSc51Y5onevErrarnNzfxEsu+IjML1m8Nd2640kNa27UKwn9tFboUfEbOvPQ2+hkXx5YYNT+MFpV2XwnFal47OiyQPP0xDoUfgDreRq1Sevb5WMgRVaoOeJDYwEetp0OxrWny2r/hQHxcDapgpyZkyq0q7PblLNBN9+u1p7BXi+59/G1iApbKqQrV/sz6FyFBCfmvfr/ANbgJEicA==
Received: from SY1PR01MB10596.ausprd01.prod.outlook.com (2603:10c6:10:31a::15)
 by ME5PR01MB10091.ausprd01.prod.outlook.com (2603:10c6:220:24c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 11:00:29 +0000
Received: from SY1PR01MB10596.ausprd01.prod.outlook.com
 ([fe80::7ab4:1f80:a8a0:7d3f]) by SY1PR01MB10596.ausprd01.prod.outlook.com
 ([fe80::7ab4:1f80:a8a0:7d3f%6]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 11:00:29 +0000
From: Yitao Jiang <jytscientist@hotmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Yitao Jiang <jytscientist@hotmail.com>
Subject: [PATCH 3/3] drm/amdkfd: block THP for non-replayable SVM ranges
Date: Thu, 25 Jun 2026 18:59:53 +0800
Message-ID: <SY1PR01MB10596F9476BAA5333F02F5A6BC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY1PR01MB10596EB75463208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
References: <SY1PR01MB10596EB75463208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0028.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::8)
 To SY1PR01MB10596.ausprd01.prod.outlook.com
 (2603:10c6:10:31a::15)
X-Microsoft-Original-Message-ID: <20260625105953.70647-4-jytscientist@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY1PR01MB10596:EE_|ME5PR01MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d8599f-808b-4277-0763-08ded2a8f82e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|51005399006|23021999003|24021099003|16051099003|19110799012|41001999006|25010399006|5072599009|15080799012|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8uS0tXjATlovJwRmlYiRe1hijqWvf9h7aEyKjdY94TXaN7GvWFlBnmO5Bwu2?=
 =?us-ascii?Q?8tjW/sg6YXOBWkYax/Q3pHhr4GzyQbhRKJx4wwBq5JFqewEMqzslLxWHYmRG?=
 =?us-ascii?Q?dkFLcvK2eJlzry+Hv+fuBJZfJ78/0r9IT6yPZAOUtMRFtXuTepQwnHFVa6BL?=
 =?us-ascii?Q?IU1wgX8uaTKOB7sxtpILxVy7C2ZSjTIWrfg6bsSZq89dzC7bpcRR4saFoNB6?=
 =?us-ascii?Q?6h69Z/1BOixgk96ieDhXzMHY7QXi6W4QT7jpxVtnsWEhtRg9lfGpJ7QhIFiL?=
 =?us-ascii?Q?xaySSxjDxrlmwgS3zpEsVBmO2PtoGosos9kKv772HpHZk2yx2nneGqn6Z+JK?=
 =?us-ascii?Q?dFzrCzZZrO4sYT+Q4hbqKK66j16QY2cAJvRMd/r3vyi0CzViBh04GsUdyMDB?=
 =?us-ascii?Q?77wH9QGXFLUmPfsSVmuOSb3OlFMFrxIhFVtryUp2JFhUHePdgPhDGMTs6jHC?=
 =?us-ascii?Q?hp7qJC6bQyhNgiFDrrxqoaXhx5ZGmLTv8RFx8hYzqhML6zij3AFCnHOcFgZa?=
 =?us-ascii?Q?x+Ol6Ra9TNX1oCkZjsAyQfTuTC0Y6ZRvUaWbS8NegTn5oU96Un6+BVt6kBdP?=
 =?us-ascii?Q?BvrbaDpx76UTHx46ALTWv7lkb0ZXsEj1eTSW4IgsDPBi1U6CTu4QP/qTj9fM?=
 =?us-ascii?Q?JG64hl/W9mSra4q8J2Og6A8FWnjX/uRPqPpfrDQDpxsMiNHcDoKg6EsFTpTy?=
 =?us-ascii?Q?Qtfvv0kZqingbXPzzYIHcRJHNgnarhlOW8RQUbGDj0AU94Gkot/E4XJOqhR8?=
 =?us-ascii?Q?WKcarTactzEGFA0qq/Pr4a3pYT4TaGQ8tVhOjMzICzmMgO1wMAfGUDJM7apm?=
 =?us-ascii?Q?j6WShZWPmAezVXBDcgdYwB34LRpwbOWLVeCLUaBI1UTsk2nvpwHh0l1/sH7E?=
 =?us-ascii?Q?g4+hgaVa2RcE5B6uhiSB05FlwIi4Zpn/+xA9GVLpMXUfWd7UinPAnUjIeBIU?=
 =?us-ascii?Q?Dr093MkvD2l7uUBjOzHpDrrLNQ9QHMEu/ec96rcK1M8SWWjK4tClSteDPGrC?=
 =?us-ascii?Q?J86Ws/UcPy75SCcsTNIDSMjjhQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rd4kRz/7raU9XZfYF32Ji5qwecWw2rqvSzuAvIR3HC9vmd+V0Kst8F15KiDT?=
 =?us-ascii?Q?PpWWVH5wTI1TfRmekI0V2E4A439XHzBbz1+SNu2VPMhBDzOkrEyhUP46h4x1?=
 =?us-ascii?Q?kII5IzaEapnJrD9Ee9JYD9nMAIgjbbY1Zdr/CnYeSz6VJsbUC2VpdNKrGoJs?=
 =?us-ascii?Q?otVCg/z1Uq98HB55R2rd8+6/0RuEEPoLCroR+FteSi4wCjtIrJkmoWY8t6fx?=
 =?us-ascii?Q?PSBe3ip3CdaT66ZHrZc5ujmqwYGl5CwYhgLM6uCRvfaOgqsw1n/zPxhyUC81?=
 =?us-ascii?Q?ejkZnCCKrfvWxDoFoGFNOqVsrRdqplhtIqgc7AlqutZbExAJ1xsGsaiBP92f?=
 =?us-ascii?Q?E89JSWZOrgb/8msv7+66tUFRyZfF7guFxCe2O36jNZDxQoitDosZRWMs6zgb?=
 =?us-ascii?Q?6++z59pTC7BgnXbpaTwpcgR4bM1ROBrrFCB56EkRv2fVVCo4ygYCE7ENDSZf?=
 =?us-ascii?Q?1vNKUobubPR6nhyX6yyZHh4ccNBm1xpjCrm2gavX4rxU+pp1dJ2TKIyCO3LU?=
 =?us-ascii?Q?4U9SbbMv/lKR5wK5GOq54uXWpgV88YSrameVeDHYPaiT+L5WaUmkBbvQ5MYh?=
 =?us-ascii?Q?Eif7rfUvCF8lldIcFNrXRgGuJk7manwDKaRFhL91+ofh/TBV0q6MxQlEZ6d2?=
 =?us-ascii?Q?XlCE+5NKGtydUVSE4oXqkQvAuyYPl9WDHKxQv3Ez6RHzeyF+qiphE7jD7c7z?=
 =?us-ascii?Q?cT8FU6V6mvb5Q1qmooQ30nlDt+cFE2f92zxI+pqP8v+aXJlmH9jr8WJmpSNE?=
 =?us-ascii?Q?cidYnK4KXOeNhochPhZigdAijh/MR0s7xv/fiCv+xMLFR4nkinm9UJVa4MYl?=
 =?us-ascii?Q?p1nzINQI/YFcQO6mPHYRsKlVpMSH9FKhA7UrlH/8KXlood4bkMfhwrRnTMu5?=
 =?us-ascii?Q?bXYkCbuIXZavlF3AFySyez/y/F3vc8/Rbdjz9bjglmx77D36paVTbcPJRgaT?=
 =?us-ascii?Q?g0pMZm+0Xav8k/dWVWuRe+VA7JHeuvdZgVcwyNK/2z8w6IJgF1oYR7yqQUsO?=
 =?us-ascii?Q?jr+6HAHCsPGElLDUcKWJVPAZow4l6nQycv5ov+lAJtiI+g+336A/r50qcbOc?=
 =?us-ascii?Q?q39rXCShkY6Mklq9Bj6g9ruLtfvStYnDWVX1B437vmk5eQTmzqCArj4eW5X7?=
 =?us-ascii?Q?1Zolk75iFJ/1lxO1OxGk5Nb9X5dBEQMUjO6IpCJED/ZQQeYPiVwgXeLueCl0?=
 =?us-ascii?Q?+sp+pYz4+axSqcTEx4prA6Zi3MDW8SLWqgRcDTfOvnyg6Jzglh7AbD1teaXA?=
 =?us-ascii?Q?PGjuozpZQ/chvz+2oyzH2inpHKeyCpLN3DRwwNOGYbfUICR1uPXuznFKb/85?=
 =?us-ascii?Q?o+xHzDNZUlpP2MPBKE/x+P+XvxPz+yYs00uencd/yfnnfe85f33KoGfnkFFY?=
 =?us-ascii?Q?AEui9VBQez2tEqfw4kHQyqUxGfWB047Ac8o/vD48crtoBD6XCyBYMdQd3aLs?=
 =?us-ascii?Q?WWmVB8RiTYcLsAllJpCY4wz84FiI+QUnfh8Tg4f0OQNaYg+kPRXXoQ=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d8599f-808b-4277-0763-08ded2a8f82e
X-MS-Exchange-CrossTenant-AuthSource: SY1PR01MB10596.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:00:29.5020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME5PR01MB10091
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

KFD SVM ranges on processes without XNACK, and ranges requested as
GPU_ALWAYS_MAPPED, cannot rely on replayable GPU faults after a CPU THP
remap of the registered VA range. Keep those ranges backed by base
pages while their interval notifier is active.

Opt those SVM interval notifiers into MMU_INTERVAL_NOTIFIER_BLOCK_THP
and update the flag when SVM attributes change. XNACK-enabled ranges
that can handle remaps through replayable faults remain eligible for
THP unless GPU_ALWAYS_MAPPED is requested.

Assisted-by: OpenAI-Codex:GPT-5.5
Signed-off-by: Yitao Jiang <jytscientist@hotmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 36 ++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3841943da..0d0feba7b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/mm.h>
 #include <linux/sched/task.h>
 #include <linux/dynamic_debug.h>
 #include <drm/ttm/ttm_tt.h>
@@ -81,6 +82,26 @@ static const struct mmu_interval_notifier_ops svm_range_mn_ops = {
 	.invalidate = svm_range_cpu_invalidate_pagetables,
 };
 
+static unsigned int
+svm_range_mn_flags(struct svm_range *prange)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process,
+					     svms);
+
+	if (!p->xnack_enabled ||
+	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED))
+		return MMU_INTERVAL_NOTIFIER_BLOCK_THP;
+
+	return 0;
+}
+
+static int
+svm_range_update_mn_flags_locked(struct svm_range *prange)
+{
+	return mmu_interval_notifier_set_flags_locked(&prange->notifier,
+						      svm_range_mn_flags(prange));
+}
+
 /**
  * svm_range_unlink - unlink svm_range from lists and interval tree
  * @prange: svm range structure to be removed
@@ -112,10 +133,11 @@ svm_range_add_notifier_locked(struct mm_struct *mm, struct svm_range *prange)
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms,
 		 prange, prange->start, prange->last);
 
-	mmu_interval_notifier_insert_locked(&prange->notifier, mm,
-				     prange->start << PAGE_SHIFT,
-				     prange->npages << PAGE_SHIFT,
-				     &svm_range_mn_ops);
+	mmu_interval_notifier_insert_locked_flags(&prange->notifier, mm,
+						  prange->start << PAGE_SHIFT,
+						  prange->npages << PAGE_SHIFT,
+						  &svm_range_mn_ops,
+						  svm_range_mn_flags(prange));
 }
 
 /**
@@ -3763,6 +3785,12 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 	list_for_each_entry(prange, &update_list, update_list) {
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
+		r = svm_range_update_mn_flags_locked(prange);
+		if (r) {
+			mutex_unlock(&svms->lock);
+			mmap_write_unlock(mm);
+			goto out;
+		}
 		/* TODO: unmap ranges from GPU that lost access */
 	}
 	update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
-- 
2.53.0

