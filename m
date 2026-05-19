Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFA3CD5BA3
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7EC410EBC9;
	Tue, 19 May 2026 09:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tG8gyHPd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3115810EBC1;
 Tue, 19 May 2026 09:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fABJPAAupS9BRNhMzXCKy+pGjXR4DpDaPe0Ij1hRIyF0M9Q4YgGBaVgK4Mgw9jGFYYSREC3YsFPsnddImua/Z3vDxFKXmirYTaccHS/6vWmAx8PQAwlXtlQRrstJa3oGAc0eXbkJxbDu8m3kR1jXfI1qsZnAvMh68gcS3V76Bxj8kg5stit0fVVEtyDKOUJopj/LNuQD+cUOjHw8Gov8zluq9kWeWZn5xDPSVKufh5O2e4hjVB1Vnyd3w1dRknS9PpuA7ui8y6t5nyKviI59UtpLGNk9lwGLCOZyGaHMKpaVbhe75QTaHNLOALoZ6PqvRRgGgtGMz0ZulkJ6iiNvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO9dTXujU7wWmcGl2qN52/DejqRq06km0Yqo78LirwQ=;
 b=oZqx2zFR8V8p2xyIaw5yLS+n7QQGsoLyJYQ0nv6+sEl0AIlFETGTkxECb0S8Q3bRXuQnJDuzz0d/keSZW/tTIdf9NUzRC4320woSyd48Gwbo5oKmdgMuEMm7vXUcLJiSkzf+xMMCZj0B6922MvYTEQ5uxaswTgu0nJEyA5VAi0t2DKTaPSJgrMa04wGV9MdOYieMcT6HAAZS5pZ/zjkUD9Thm6d3zCE6SLbIpOVRjrQd71VIToDUqJKOu3MiS7flYQ94SC3SYuw6onhn/0F1Wqc5HxOe4Xlx5gg6h1g22zKqHcVE1SJgsDxgISKYmExEw1cSqqetlVXCyng0l0fafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO9dTXujU7wWmcGl2qN52/DejqRq06km0Yqo78LirwQ=;
 b=tG8gyHPdRo2jaHqe+YJgML+SDZdmDrpxxA+I6XFL2HpfR8gZaNV6aU6WgLRAYyuol/x7lt0OjFzNUyBlh68hVnowIwHiJZvPei0N5Cfebi62XZC3/NvVQQshtpuK+t79WEnmgqzp5kiEFcdICc35B05UZcsfrvUMYY4dRLR9l/E=
Received: from DSZP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::11) by
 PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:23:50 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::4d) by DSZP220CA0010.outlook.office365.com
 (2603:10b6:5:280::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:23:50 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:23:45 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 4/8] drm/amdgpu: implement xnack-off restore worker
Date: Tue, 19 May 2026 17:23:09 +0800
Message-ID: <20260519092313.3115848-5-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519092313.3115848-1-honglei1.huang@amd.com>
References: <20260519092313.3115848-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8eebce-c211-4693-6c7f-08deb5885675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|921020|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: OyaZWgIO0zzo59Wl/CRIPLcZGIS3wXelbs1zO+6+BEvPG5HV+YUnAYBdYN3TctAUTx1Uc/CEhmb0RblDTK6mV6kINah6qV/MykqQE5ahmqAK5ibnzLm04KzMAWnNdewYqXIEDjIJ32xmDtPRpWdr9X44OylXL4Ae2Um1PgLzao4+cer9KSBQobmmxjZ7dbUn1LhuRWBRY9oD+02ceqlnMul478KXTqy1UuUL7Hjzsd0vyyte4A7bP1cYF3FtPeBbBAWq+Img5pYVM+uGg05D7N1HhFfIhI7Vxh2n6pz+PbKGTFDn93AByBX/NU9IG5NrbszrOog7ZFGLOV30uWejmsAKiNNgD2S9eRCUUSwn18LmeMZpWRbt81XRbrQqaBixX66StXP3eViZRlxb0btog+1l6RR2QgFZURDrwFQsEh6fQGR2xU1mFvW/VqTMwaX/2ne+1Hu6rivBj3KwHS1td2Jx0RAVdykiUkdWvmhRjKHjrMibb5ROT3uLA0MNePfDcu9oTYV57/eBoU41cZKyt6su2z0OoDYnYhuUcvVQGHJrlHi8RRnCVOUZM6Wq3/Ua9OS4yzVlGlFu6Ule/orlAb45DIufTiY2UjW/NmHm4wMloDLGsamlBT3WvcszKvrCC0Ot7a2MBBGOmZLvQWvN0juSVcLoJOCBhICcQAdMSSbE+J4CbQs4KkMTe7t/unzF7EvtvWvwiIV6OLyEavxBYvaXNd6mWcf3YUNDM6u6FyLmvBDssnSQpRGBzThqMaZ0GYj9I1dYdHo1AEAP2l27QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(921020)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rOAE/8edi6Hlhk+LOCMV/JNXoGiFu0yxk3qNzDWBtlARaBU0MuCDM1PYpOa/Wo77TdfT0aslKkg2wrmgXlKSB/ay11kOpRn8vsHqcfMcEW7xzdOFyBkrDYButCeqCLBe9Mx7DBfS9ftF9IW5BIBP5K8+VwVCaWgFh8G+DVOOhrR4hTbtSh1HDNGBgF2m/7Rl3GnW+Kuf04dZ7AT8fkbjyAXRTFpMgy1vTXVH/8cO6ZV4vR63hnsQsKfSmPnJgG85DVAApeqF3DbsHrRBNUSX/r500a2RR51ktL7iUFVxVeXCiYnm8lW1m3N7aDofDdRbLZnjD6g0dpO669X79DWde64GrYj6JK3y+VIqBrSGMN5MEDUBYTrXkrcUnoPWavNm8Vt+drnKgv63XkYOvbbN2HpuPW+OPOQcuHmgcwfUi60y738QIGil7xqaH53zxDQc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:23:50.3421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8eebce-c211-4693-6c7f-08deb5885675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
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

From: Honglei Huang <honghuan@amd.com>

Add delayed restore worker for xnack-off range restoration:
- svm_restore_range: restore single range by looking up attributes
  and updating GPU mappings.  Uses the per-segment PTE-flag pipeline:
  amdgpu_svm_range_is_valid() and amdgpu_svm_range_update_mapping()
  consume the attribute set plus the read_only flag directly, so no
  pte_flags is pre-computed here.
- amdgpu_svm_restore_worker: main delayed work loop that dequeues
  ranges from restore list, attempts restoration, handles retries
  with re-enqueue on failure, checks for completion to invoke end
  callback when all evictions are resolved

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c | 147 ++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index b231c7d44..89e8b687b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -222,6 +222,153 @@ svm_restore_enqueue_work(struct amdgpu_svm *svm,
 				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 }
 
+static int
+svm_restore_range(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
+{
+	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
+	struct amdgpu_svm_attr_range *attr_range;
+	struct amdgpu_svm_attrs attrs;
+	unsigned long range_start_page;
+	int ret;
+	struct drm_gpusvm_ctx map_ctx;
+	bool devmem_possible, need_vram_migration;
+
+	amdgpu_svm_assert_locked(svm);
+
+	range_start_page = drm_gpusvm_range_start(&range->base) >> PAGE_SHIFT;
+
+	mutex_lock(&attr_tree->lock);
+	attr_range = amdgpu_svm_attr_find_locked(attr_tree, range_start_page);
+	if (attr_range)
+		attrs = attr_range->attrs;
+	mutex_unlock(&attr_tree->lock);
+
+	if (!attr_range || !amdgpu_svm_attr_has_access(attrs.access))
+		return 0;
+
+	devmem_possible = amdgpu_svm_attr_devmem_possible(svm, &attrs);
+	need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, &attrs);
+	devmem_possible = false; /* TODO: add migration */
+	map_ctx = (struct drm_gpusvm_ctx){
+		.read_only = !!(attrs.flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.devmem_only = need_vram_migration,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+	};
+
+	if (amdgpu_svm_range_is_valid(svm, range, &attrs))
+		return 0;
+
+	AMDGPU_SVM_RANGE_DEBUG(range, "RESTORE - GET PAGES");
+
+	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
+	if (ret)
+		return ret;
+
+	AMDGPU_SVM_RANGE_DEBUG(range, "RESTORE - UPDATE MAPPING");
+
+	ret = amdgpu_svm_range_update_mapping(svm, range, &attrs,
+					      map_ctx.read_only,
+					      true, true, true);
+	return ret;
+}
+
+static void amdgpu_svm_restore_worker(struct work_struct *w)
+{
+	struct delayed_work *dwork = to_delayed_work(w);
+	struct amdgpu_svm_restore *rst = container_of(dwork, struct amdgpu_svm_restore, work);
+	struct amdgpu_svm *svm = container_of(rst, struct amdgpu_svm, restore);
+	unsigned long resched_delay =
+		max_t(unsigned long, 1,
+		      msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+	struct amdgpu_svm_range_op_ctx op_ctx;
+	int evicted_record;
+	bool need_resched = false;
+	bool has_pending;
+	int ret;
+
+	if (atomic_read(&svm->exiting))
+		return;
+
+	evicted_record = atomic_read(&svm->restore.evicted_ranges);
+	if (!evicted_record)
+		return;
+
+	if (!svm->gpusvm.mm) {
+		atomic_set(&svm->restore.evicted_ranges, 0);
+		svm->restore.end(svm);
+		return;
+	}
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, &svm->restore.list,
+					       &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+
+		down_write(&svm->svm_lock);
+		if (UNMAP_WORK(op_ctx.pending_ops))
+			ret = 0;
+		else
+			ret = svm_restore_range(svm, op_ctx.range);
+		up_write(&svm->svm_lock);
+
+		if (ret) {
+			AMDGPU_SVM_TRACE("restore work retry ret=%d start=0x%lx last=0x%lx\n",
+					 ret, op_ctx.start_page, op_ctx.last_page);
+			spin_lock(&svm->work_lock);
+			if (!UNMAP_WORK(op_ctx.range->pending_ops))
+				op_ctx.range->pending_ops |=
+					AMDGPU_SVM_RANGE_OP_RESTORE;
+			op_ctx.range->pending_start_page =
+				min(op_ctx.range->pending_start_page,
+				    op_ctx.start_page);
+			op_ctx.range->pending_last_page =
+				max(op_ctx.range->pending_last_page,
+				    op_ctx.last_page);
+			spin_unlock(&svm->work_lock);
+			need_resched = true;
+		}
+
+		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+
+	spin_lock(&svm->work_lock);
+	has_pending = !list_empty(&svm->restore.list) ||
+		      !list_empty(&svm->gc.list);
+	spin_unlock(&svm->work_lock);
+
+	if (!need_resched && !has_pending) {
+		flush_work(&svm->gc.work);
+
+		spin_lock(&svm->work_lock);
+		has_pending = !list_empty(&svm->restore.list) ||
+			      !list_empty(&svm->gc.list);
+		spin_unlock(&svm->work_lock);
+	}
+
+	if (!need_resched && !has_pending) {
+		drm_gpusvm_notifier_lock(&svm->gpusvm);
+		spin_lock(&svm->work_lock);
+
+		has_pending = !list_empty(&svm->restore.list) ||
+			      !list_empty(&svm->gc.list);
+
+		spin_unlock(&svm->work_lock);
+
+		if (!has_pending &&
+		    atomic_cmpxchg(&svm->restore.evicted_ranges, evicted_record, 0) ==
+		    evicted_record) {
+			drm_gpusvm_notifier_unlock(&svm->gpusvm);
+			svm->restore.end(svm);
+			return;
+		}
+		drm_gpusvm_notifier_unlock(&svm->gpusvm);
+	}
+
+	queue_delayed_work(svm->restore.wq, &svm->restore.work, resched_delay);
+}
 int amdgpu_svm_restore_init(struct amdgpu_svm *svm,
 			    void (*begin)(struct amdgpu_svm *),
 			    void (*end)(struct amdgpu_svm *))
-- 
2.34.1

