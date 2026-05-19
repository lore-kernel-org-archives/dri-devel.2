Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92E9CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F35A10EB5B;
	Tue, 19 May 2026 08:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QV5eyBmw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A108710EB5D;
 Tue, 19 May 2026 08:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fccsHR+9LFpGurPEqJ35ApxhlvBRDIvNhK9wccvTP+qZTuSVgyT8LLHSVUyehjbpN4g1KTiVJt2hITydzdMc4WYH1i3nycB+f72G0sgKwY56CH+ACCba7grwC9WbgJbABz0RGAFpYcrk0cUy4dam9SKPp1l2g+pkHp0VBZOtC4WBk5QaKGUVOgoPgBQ+GwKS+iXswDVqSb/BN0H/lJ2ARSiTVY2bA0CGQSW8gUBNILcu7aqwRy8tuTf+yIIf/omZ8daWxDW+LQSmdDgpYWDq5rtEaagGB+TEsG8EqY0QXcezN7+zN7w+sMSOZz9mmODlB2cKpziN+l9NLM/3XZ5iIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K5SqBBqiN6Cs6u0wGcoUqd7RaSFcWh+8RSR0ezg0g0=;
 b=BX5VbvfW8q4nY/qLAym1t6gu12KDtJu99uKd0DMiT3iZ9oofJen+WmZLZVajvgPehpXZoF33BYEtBZsu3fC1il5urI5DiuckQq8hxd46nwykqaUXK0GaCLtD5VTy/i+j+ynnd0Rf6YC+vG2teOYeUJ45NRHS0MYVrXWIPLoCTNcRZiV22OgMwZgtA5HgNa1ez/hsIwLB2gcbPLOP7SA6vO5gt2iocFa0R6d3dR6pBZfcz5VmQOpCGUM6tiHdS3ABv+YweJmQni3jATNIihY4hAZNLXxXbRJOhXOZZRuQ7c2Tq7ik6n3Z2ZTwojf5jNvJrA8voRZSXVpHiIzUxcdR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K5SqBBqiN6Cs6u0wGcoUqd7RaSFcWh+8RSR0ezg0g0=;
 b=QV5eyBmw0jVt2VjDunqkvXKesaXepIRx3pPhmCbrDsaNr+3r9J7eeMNBmy+9w+O3wexrkNz78SkudZdvqA5HO2joEMbhXA3X1pS51RpqEfjjskqlKUj2Dnr5xzi7gU7uOexvFoTKKmdvTx0dWijSsvvgtEEbX6CBV6axBg9npmE=
Received: from DS7PR03CA0177.namprd03.prod.outlook.com (2603:10b6:5:3b2::32)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 08:32:25 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::25) by DS7PR03CA0177.outlook.office365.com
 (2603:10b6:5:3b2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 08:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:32:25 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 03:32:20 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V6 09/12] drm/amdgpu: add SVM notifier invalidate callback and
 checkpoint
Date: Tue, 19 May 2026 16:30:54 +0800
Message-ID: <20260519083057.3108087-10-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519083057.3108087-1-honglei1.huang@amd.com>
References: <20260519083057.3108087-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: eb22e2e3-5c52-4550-4365-08deb5812785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|56012099003|18002099003|11063799005|921020;
X-Microsoft-Antispam-Message-Info: SH2XP0e4JknLoIBXZ441uFVrcmAy6dQa8pmNo2JNDNhDs+dEMiK3f6KN3eWTRSuZ+W7oGN+KSCHXDmXBNbPNThPsdUU11KExZiUskbPQt/sC1+ossVaeEeXjQ0EjBdhTNXQ2Cw6q2vQyyfupWux6rrKrC9d79AeNAVDv2fI7nZ50rWuEipexNLJwACrxCt4N0gm6R/jTlUnfLtw8WP5IjZ5viE4nb6WDWwGMtkY9k7u/3Xk2wYzABcCgzjdpjeb04C1nMIAtJ4rYAB11iPep8XCeL2+VeEpO3XXWabenCjPgDhQ992GYVkYTPJocg0f/Ug/MjcuqTuiXHIm8mJO9ekerlrogofIsv67zjghhw81CZQ3dg7z18sVBsP8U19uKDaFUuFO0kh0gu5xEFf97VvvoMgLyuJCSdapTTzKLnzkSecrHAZWXAtNF+1mlI4gulc5eeysBC34x8tyMIMCDaFxhxGb6LyORHlDuPaeA8LariLrsrxOr4bc3Sc1uIeup4FNKCqhnOmTyrI9VCNfCC1rZh0i0BOYl8okIiVJcKg3FUufbtgHVd34Ep++2NlBf7u74mywHawCOGwWHTiNKa5ggJN7XxOQrOIbfLRHlIE4E3K1zGSpqO3sbshxxllVjxWz5h3mhnYYbzn4ynXceniCI9T+VD3XSamJz7lWxaI09axmduDCpI14fxn16Ndx3SUpbR3nxdv0P4skcmzEDkzKfaQBRChVrGW5Imuwu03t5B/tTf6SLyvIhWNKrTwKkmIKr9a0hrMDJY78iG5wcwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003)(11063799005)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YJUM0oT200gM/ngQMyoweC6ASzoBSexiDy1WHGc2Z7irV/zKp1oSClPewXO0qgWcm1kg1s5JspjSKbRqbAjUfpu1L3EoZhs3N9m0j7W5PAHRtgXqQZoOT0K38aitmLWUQj+rC1rg/ABDQ9AKIf7wVYU6xbzONJse0RIzNzp6lgKh7Czj6Cfss1eljnTH8gKtF8dEqTQnWrKQ/7bmEcfCdExOeDlCtu6uxORUnKLrDqJ6f+bX+jMereQKamo2QyNqXim1ZVuquGBJz5MMrI5pX3iCT1APWtqIdd8CypQeNnRryDUowFztHLSUgjS+UdIYab3X31/0Zv3xeuD1fms8M+tmi55tCluwJF3RCv+o0w3M965ToptI4Zc3DsyQvAvIu5At+iPnFmbtqiN6FChGxiN9PgsstTtSUT24qpoGQjIlHLf0C6NhXLn6UG2/9O8e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:32:25.1071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb22e2e3-5c52-4550-4365-08deb5812785
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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

Add invalidate_ranges callback and checkpoint timestamp:
- amdgpu_svm_capture_checkpoint_ts: capture interrupt handler write
  pointer timestamp for stale retry fault filtering
- amdgpu_svm_range_invalidate: invalidate_ranges callback dispatching
  per-range notifier begin/end with TLB flush batching, checkpoint
  timestamp capture on MMU_NOTIFY_UNMAP events

These complete the invalidation path: attribute changes trigger
invalidate_interval, while MMU notifier events flow through
amdgpu_svm_invalidate (in amdgpu_svm.c) which dispatches to this
callback via svm->invalidate_ranges() to perform PTE zap, TLB flush,
and GC queueing.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index a5ce4c488..98e66a301 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -698,3 +698,52 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
 	if (release_kref)
 		drm_gpusvm_range_put(&range->base);
 }
+
+void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm)
+{
+	struct amdgpu_device *adev = svm->adev;
+	struct amdgpu_ih_ring *ih;
+	uint32_t checkpoint_wptr;
+
+	if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
+		ih = &adev->irq.ih1;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			WRITE_ONCE(svm->checkpoint_ts,
+				   amdgpu_ih_decode_iv_ts(adev, ih,
+							  checkpoint_wptr, -1));
+			return;
+		}
+	}
+
+	ih = &adev->irq.ih_soft;
+	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+	if (ih->rptr != checkpoint_wptr)
+		WRITE_ONCE(svm->checkpoint_ts,
+			   amdgpu_ih_decode_iv_ts(adev, ih,
+						  checkpoint_wptr, -1));
+}
+
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range,
+				 struct drm_gpusvm_range *first,
+				 uint64_t adj_start, uint64_t adj_end)
+{
+	struct drm_gpusvm_range *r;
+	bool needs_flush = false;
+
+	if (mmu_range->event == MMU_NOTIFY_UNMAP)
+		amdgpu_svm_capture_checkpoint_ts(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r,
+								     mmu_range);
+	if (needs_flush)
+		svm->flush_tlb(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		amdgpu_svm_range_notifier_event_end(svm, r, mmu_range);
+}
-- 
2.34.1

