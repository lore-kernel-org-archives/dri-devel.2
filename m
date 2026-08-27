Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31211C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34AE610EEA6;
	Thu, 27 Aug 2026 07:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V+q5UJaU";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8D110EEBA;
 Thu, 27 Aug 2026 07:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byLWoOmJXYCfkn2FZoGr74dNBy5ErF2MlFyXeGkro0SPRDJDTVqrEutrbn2crRiblTin+mbZgDGblNAAYZPs8SCvIj5rTN5BdxxxRDDlnDCLi7gpa4hUhRPMlmz6vBgOoQarybb4t0iVuyOdszlDMMs6jdrUWNZiX/376h4C/aFRk4E4MM9HcqnhDVjfy4o7i1yTjHfEBOCheCId1QsTNba/Lvc7DokWg79p639FnIcS9m1RNjIwGTuzogw++QbaCzJYR35wgvGf8jmpk+Stke0hqs52Na/R6ofYRBareUdNVHqYdVWm8ksnB5eGfis8LRDQVGrsh70XeWiJKSkpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYmem2r3jFr0jTjosHO2N4cFl2VhZZWFU4KUXIKesm4=;
 b=dLAYUYe6VMsofPdypK+6cJBJPSx1rv++b3lxGtICKymnw8pebgynY3zAudJJjedLT302Gu+x6EDRcqE7BzYxzGiv8rWvhQdpx2Rxs4vpw9b1KWwVq1tbpCiMdWUqLZZIzleKIhty0Pe7ha9BfdfSBzPhlHtCmJn6eAEP9Dtqnoc9CjDiCRnAEnDpIYfzTeccyouggftFbgfhbvAkNBRLLLtrh20iNdjuw9m+nK1cVpBxD8pyWpMJVQUWv6gG2iqdhkPx2CCawQArOrPsefbY5x0vV69ptNtbAAAdWcFfTKPu6RnwzfK7g3Th6CgkRrpOXCUf3Ts3kJlJJg8nZJSZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYmem2r3jFr0jTjosHO2N4cFl2VhZZWFU4KUXIKesm4=;
 b=V+q5UJaUrlZLrLulipFR+/s/a0DzqXZEt0tBYFQq3x3SuhqBIny4sqI7j+s50INDlt/GsslYJ+eCnSp9hWzUll+l/z/6hVrHOgEf6KgjPjmwZpkZFT89CF+R8DWl9Yw7IN8DJsKujpzBQX5UrJZPHdZp/p91slMIFtdWcBVKqK8=
Received: from BLAPR03CA0081.namprd03.prod.outlook.com (2603:10b6:208:329::26)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Thu, 27 Aug
 2026 07:15:13 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::7d) by BLAPR03CA0081.outlook.office365.com
 (2603:10b6:208:329::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Thu,
 27 Aug 2026 07:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 07:15:13 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 02:15:04 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC PATCH v1 1/5] drm/gpusvm: extract drm_gpusvm_hmm_fault() helper
Date: Thu, 27 Aug 2026 15:14:45 +0800
Message-ID: <20260827071449.520398-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827071449.520398-1-honghuan@amd.com>
References: <20260827071449.520398-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 52854ed7-7c68-45b7-89be-08df040aeff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8Roq2Z/hBua34ajLRrt9PV+uVxSGigJ1PeNizYJUt/sUdBvHmTCbzW3c2z6q0FGh5M9BrP6zocwN29G5CjoK5zhYBGH6vo5UvhY0j3b5L5cCFfSY6yvgREgVTOExoy2IV4p+NJjPcCfSvipKx1TrkxxPayb103V+XolR5JZpKEF9+LvpxVvRPRUELNR/DJuhj+cDYhFlm3hPBcpycBob+wikt5HGgskqWJBLeA3muFK5xli9qLCIYPFjofg92is0yS4YFuMu7VF2xXnweEhYHqcSt9PNoe4T5wCqzFmVSLv2iG7OPR+lLCfyOAhwZUkOQRiUk8tjcN5dkVs7hb3n3hcc16YpKMH4VjKsCQoHB1a0NJJ9m2/IAb9QqNTmC4+jrTMRgmfSrESyYBdG4+2huGwRNhgLAwrA2izS8450P4cZoAjhgH2A37CM9tPQBvooJYn6KGrqWV0pmv6gDO7+kJVtnNQte2KLqG9Y3+6T9xxTvq7uTUjAZ6SATqzuUr3tJ/Cob1OqSwcxbXxG6tP56RsPXv9Z342SsvzPeFL67veJKdmQO20hL59VUILloyU/aiV0RMhyh84IJdCJ4wEXhcUNxJCT/64aBaoI3cz+yQ3Qs2PBWhcbsZcJbXoDSpisCCcrHyNIy7z8ZS2IvPL/6IQozQknuIf0G8it6mR1qla4SGAl9hDRKWbtbO48y9NNAPcalKYqhtR3/r233DSxOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dk0kj1XRu7ZlX765ISWjWUZpXoPzVPGPMev8DgDoWw3lkwrPwPdbpQfN/4MZoyVlBGLs2XORrwZt3ozovaAsrs3dYuP35AV92eoUZ6wyxHZ+EKd2xJAoL1BM9oik8ucTLwYE8X03wJeqWIK/K1jOk59YrMfW925eSmU3NbSa0bD3EVSXj+tUBSjTbisrOEWC2rImld3WUBgKEituqtTnRhgrvy9x5FgiTB6XfmANLzqsjWK+RNSJl3acQIeP+j28aiyuqLpFmwBoaPEr1I5xWn8dXLKKQUBOvczvz/BgBbnzy49jZTbyPAyaK2ASs4CtwSA2DYss3YOJhkP/5EVYskBZsk4cTGkGXvZ4ZAbvmbujsEIoJ01J314M2HizT4a3o0Iz7cXyuQDi9THgk3tYetS+2CYObhncNmWG4RQI2f2cWMHXlG15xhxO5z330zg/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:15:13.1361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52854ed7-7c68-45b7-89be-08df040aeff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286
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

Make the HMM fault step of drm_gpusvm_get_pages(), including its -EBUSY
retry loop, into a helper drm_gpusvm_hmm_fault(). The existing logic of
the public drm_gpusvm_get_pages() is not changed, only relocated, so
there is no functional change. Keeping the retry loop in common code
also means drivers never have to open-code their own fault/retry loop.

A single fault can later be shared by several drm_gpusvm_pages instances
that mirror the same CPU range. This prepares get_pages() to split the
shared MM-level fault from the per-device DMA mapping. No functional
change intended.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 67 ++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index fcfe635bc195..507ef6f0a60e 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1442,6 +1442,50 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
 	return pages_valid;
 }
 
+/**
+ * drm_gpusvm_hmm_fault() - Run the shared HMM fault for a CPU range
+ * @gpusvm: Pointer to the GPU SVM structure
+ * @mm: The mm corresponding to the CPU range
+ * @hmm_range: The hmm_range to fault.
+ * @pfns: The pfn array to populate (size @npages)
+ * @timeout: jiffies deadline for the -EBUSY retry loop
+ *
+ * Fault the CPU pages of the range into @pfns. This is the MM level step.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int drm_gpusvm_hmm_fault(struct drm_gpusvm *gpusvm,
+				struct mm_struct *mm,
+				struct hmm_range *hmm_range,
+				unsigned long *pfns,
+				unsigned long timeout)
+{
+	int err;
+
+	if (!mmget_not_zero(mm))
+		return -EFAULT;
+
+	hmm_range->hmm_pfns = pfns;
+	while (true) {
+		mmap_read_lock(mm);
+		err = hmm_range_fault(hmm_range);
+		mmap_read_unlock(mm);
+
+		if (err == -EBUSY) {
+			if (time_after(jiffies, timeout))
+				break;
+
+			hmm_range->notifier_seq =
+				mmu_interval_read_begin(hmm_range->notifier);
+			continue;
+		}
+		break;
+	}
+	mmput(mm);
+
+	return err;
+}
+
 /**
  * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
  * @gpusvm: Pointer to the GPU SVM structure
@@ -1503,28 +1547,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (!pfns)
 		return -ENOMEM;
 
-	if (!mmget_not_zero(mm)) {
-		err = -EFAULT;
-		goto err_free;
-	}
-
-	hmm_range.hmm_pfns = pfns;
-	while (true) {
-		mmap_read_lock(mm);
-		err = hmm_range_fault(&hmm_range);
-		mmap_read_unlock(mm);
-
-		if (err == -EBUSY) {
-			if (time_after(jiffies, timeout))
-				break;
-
-			hmm_range.notifier_seq =
-				mmu_interval_read_begin(notifier);
-			continue;
-		}
-		break;
-	}
-	mmput(mm);
+	err = drm_gpusvm_hmm_fault(gpusvm, mm, &hmm_range, pfns, timeout);
 	if (err)
 		goto err_free;
 
-- 
2.34.1

