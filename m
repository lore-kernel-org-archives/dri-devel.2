Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32437606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jmFMPC7R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327A010E1C6;
	Tue,  3 Nov 2026 21:38:32 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF61610F88B;
 Tue,  3 Nov 2026 21:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dw0gKol8YkC//4CF4fguJGSRHW90ZGSU8pwjCZiPncK3+056CP2vfcvbtkyx8UpgvcFHHswOz/hM6sJCn4HWcnA1GRC/of5MXOiJebX64KscLAPxRcEt9IimBWlMg8tTP2ex4OTLs/e9oKDjDlIxaGmLi9HEVPlxjl9E3JgtWZ61dKB4W7c72lWdd2q5VJFaf7yZJuT6eRcpmhPy0M6PGfNQ2vx03yDRi2lagkwekHUK5kyiJ40xdzo8VTg/cZWLGVcsLekwVEUGlyk3PAsBulSHgl58CbLFTIS3mFlFh3eIPAPGkW/8KuoIQWlwHbQG/oxetDT9rx9cWlT95TMK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJqsvTXP/p9jhsMIUu5wsiKwswh3oFGpHiOMoctyxBs=;
 b=Qv20j8CsQ4Z/EeUjR/4f6QKgX5PpIij5xAWoiRNBhu/ZM5g0AQWBEtldu+3KTEvg48Rqr/23iDns7uEFj7thg0aiJkekNb/erUt+EGkLpeZTG/+7D/+wOFGGQx4UW6cAzhjazwgG6eh9J0Il2j4nflPwvBc0cIbq+vaTXcLrsICt2y/pYJ3YN+2nFGwpqY9aOoXwPxNL0C4cM2T+JYFVG36RLAkN9oy1Qfv7KRp3TgN9bzSqRp/9W971VISZDbBMX1Zp4TVdOMrnNjY27VhWf4nJ/bzCt6IywVzgSsBypzGEzKeF9/g2FEcgzPRMP9YEfnARBeD9/1i9UfznnmnSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJqsvTXP/p9jhsMIUu5wsiKwswh3oFGpHiOMoctyxBs=;
 b=jmFMPC7Rod8ZSyrjpHHvbndzK/urU/ySO4rQr0aWvr35sYRwUWvvGN4KTToTCMOD8mWraf64c1n7NsU+csyLETvXu+v9cwzDiE9gerz0HNCaT2nhn5wQsGzkgh5k8cM6CTsPfK14GiWJdHdifsG01hZntPACfULSrcfvcl1jDhQ=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:38:11 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::9b) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:08 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:07 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 12/13] drm/amd/display: reject direct 3D LUT loading mode
 changes
Date: Tue, 3 Nov 2026 16:37:55 -0500
Message-ID: <20261103213756.618024-13-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0e132f-7424-44c0-cfc1-08df39f2c1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261102123227099003|261021135927099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f0s+R8SUmjs9oFYdRfc7vfovdI3t5Pso4lFT0nikx9kMYEV5YWrycUb+jPydE1EIptJ2Tp+ZiuSXyTYPD/v9qsyTUBuJEsOvBTSzhj5yTnauuew2qq163oKOGjUHxAzMFYGecyXsRsgJf/sfR6Eq4Ms/tnRXaVeB/Dlmoqu6j3JvNpi9EH9oG3xsCSVvE4PSpAclDB9q+fV/RTgcx7quJaeWFh1/3MYt8X3X+sF/PRE63R2ubWiPwBxWsTU8jalFzjDrKciImZ4cUXqDMfcBgDQusQ3jzW6nY36G9WoM8s8xwaCbHu39meOIWP5tuttdb2IZDmFyHmmQ4IRzatGNiF58pAM7vK0N21AargFsy6yfttSz2Na4514Mh8VFsrcJ0EENq4CRwwqITsRZpKP2/V43vfY4nIpvAX8naN7Pxt3MekgkOtT4O0+k3V4o+1BFqjgPU3LQTPEQjiLKt3j4ntLdqgACir+1fgIa/MHfEPqLsHr+8d9Rpfe6rZ6ATFzK7efHjvMQ6IuxW+f5L+hLbJZOWyB6gq/2z4qXx7FGxaJBPZjez1STOMjESe7PvzUXJhXIwP+MqXOEIONxe06EAQ/UI780TUsc0oRbPHl2duYgEaRk0CKFWuceuiheOgdX2NKQVeCoMzoHVZsm9G3AOfED5yui1pU1SbdSosV0Ulhc1OX11OMmf84wHK4Gf00JwS8k6btdudumPBv0Tkgn7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021135927099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GMRl1zv53t8lKzLBagIpaSCGeO0fjDK1Djl0G6/DFMdeIe8+TWZ4z7QZwDA/OIIxMD450K/VgIBw/28XANbNpmZaUG3y9gPeXeHOUsf2SWx5gRpnJ0NZGzMCh/UoH1ADejZ6lS9Okn2oByunoJu5dZJw6gyvNQi63y5PEVpAHnQgqD9ZI0FpmjlsFGiuqvFyrawLpBRqxicU0J9a2HGoTzyycNvUDP+PcPBFVe70m/tcf+nqjFvFMrde6DYyZ/GUzxAG/d2h7AILds3IrwhaiUl5Kpa929nU2ATKPw/rDX7tws/WamwEAVjIM6y7u9UtLsBq0OICl6qDBoE+93FX99LkAyfzfV8cPsjfQyMrIxKKJASdpk4V1uAtvmfnN/kiMtCzN4AkTfTjcDvxhi0CACSNztbDXtxF9QEujVtTaKB/i5AkaCX6D/QS+KgWP9WG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:10.6162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0e132f-7424-44c0-cfc1-08df39f2c1d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hardware cannot switch directly between a fast-loaded and a host-loaded
3D LUT in a single commit. Require userspace to disable or bypass the
LUT in an intermediate commit before enabling the other loading mode.

Compare the old and new DC plane color state in the atomic plane check
and reject a loading mode change when both states have the LUT enabled.
Using the derived DC flags covers both colorop pipelines and the legacy
host-loaded LUT properties, without rejecting pipeline changes that
leave the LUT disabled or keep the same loading mode.

Add parameterized KUnit coverage for disabled, host-loaded and DMA LUT
transitions, including disabled LUTs with the DMA flag still set.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 14 ++++
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 65 +++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index aad146d9c6a7..e04e9a0cef73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1550,9 +1550,11 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	struct dc *dc = adev->dm.dc;
 	struct dm_plane_state *dm_plane_state;
+	const struct dc_plane_state *old_dc_state;
 	struct dc_scaling_info scaling_info;
 	struct drm_crtc_state *new_crtc_state;
 	int ret;
@@ -1574,6 +1576,18 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 	if (!dm_plane_state->dc_state)
 		return 0;
 
+	old_dc_state = old_plane_state ? to_dm_plane_state(old_plane_state)->dc_state : NULL;
+	/* Switching loading modes requires an intermediate commit with the LUT disabled. */
+	if (old_dc_state && old_dc_state->cm.flags.bits.lut3d_enable &&
+	    dm_plane_state->dc_state->cm.flags.bits.lut3d_enable &&
+	    old_dc_state->cm.flags.bits.lut3d_dma_enable !=
+	    dm_plane_state->dc_state->cm.flags.bits.lut3d_dma_enable) {
+		drm_dbg_atomic(plane->dev,
+			       "[PLANE:%d:%s] Cannot switch between host-loaded and DMA 3D LUTs in one commit\n",
+			       plane->base.id, plane->name);
+		return -EINVAL;
+	}
+
 	new_crtc_state =
 		drm_atomic_get_new_crtc_state(state,
 					      new_plane_state->crtc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 7422e8ba9564..2925b2803a38 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3019,6 +3019,69 @@ static void dm_test_atomic_check_success(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), 0);
 }
 
+struct dm_test_lut3d_transition {
+	const char *name;
+	bool old_enable;
+	bool old_dma;
+	bool new_enable;
+	bool new_dma;
+	int expected;
+};
+
+static const struct dm_test_lut3d_transition dm_test_lut3d_transitions[] = {
+	{ "disabled_to_disabled", false, false, false, false, 0 },
+	{ "disabled_to_host", false, false, true, false, 0 },
+	{ "disabled_to_dma", false, false, true, true, 0 },
+	{ "host_to_disabled", true, false, false, false, 0 },
+	{ "host_to_host", true, false, true, false, 0 },
+	{ "host_to_dma", true, false, true, true, -EINVAL },
+	{ "dma_to_disabled", true, true, false, false, 0 },
+	{ "dma_to_host", true, true, true, false, -EINVAL },
+	{ "dma_to_dma", true, true, true, true, 0 },
+	{ "disabled_dma_to_host", false, true, true, false, 0 },
+	{ "host_to_disabled_dma", true, false, false, true, 0 },
+};
+
+KUNIT_ARRAY_PARAM_DESC(dm_test_lut3d_transition, dm_test_lut3d_transitions, name);
+
+static void dm_test_atomic_check_lut3d_transition(struct kunit *test)
+{
+	const struct dm_test_lut3d_transition *param = test->param_value;
+	struct dm_plane_state *dm_plane_state, *old_plane_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_atomic_commit *state;
+	struct resource_pool *res_pool;
+	struct amdgpu_device *adev;
+	struct drm_framebuffer *fb;
+	struct drm_plane *plane;
+
+	adev = dm_test_init_atomic_check_state(test, &state, &plane, &dm_plane_state,
+					       &new_crtc_state, &fb);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
+	res_pool->funcs = kunit_kzalloc(test, sizeof(*res_pool->funcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool->funcs);
+	adev->dm.dc->res_pool = res_pool;
+
+	old_plane_state = kunit_kzalloc(test, sizeof(*old_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_plane_state);
+	old_plane_state->dc_state = kunit_kzalloc(test, sizeof(*old_plane_state->dc_state),
+						 GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_plane_state->dc_state);
+	state->planes[0].old_state = &old_plane_state->base;
+
+	old_plane_state->dc_state->cm.flags.bits.lut3d_enable = param->old_enable;
+	old_plane_state->dc_state->cm.flags.bits.lut3d_dma_enable = param->old_dma;
+	dm_plane_state->dc_state->cm.flags.bits.lut3d_enable = param->new_enable;
+	dm_plane_state->dc_state->cm.flags.bits.lut3d_dma_enable = param->new_dma;
+	dm_plane_state->dc_state->src_rect.width = 100;
+	dm_plane_state->dc_state->src_rect.height = 100;
+	dm_plane_state->dc_state->dst_rect.width = 100;
+	dm_plane_state->dc_state->dst_rect.height = 100;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), param->expected);
+}
+
 struct dm_test_cursor_ctx {
 	struct amdgpu_device *adev;
 	struct amdgpu_crtc *acrtc;
@@ -3304,6 +3367,8 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_atomic_check_missing_crtc_state),
 	KUNIT_CASE(dm_test_atomic_check_rejects),
 	KUNIT_CASE(dm_test_atomic_check_success),
+	KUNIT_CASE_PARAM(dm_test_atomic_check_lut3d_transition,
+			 dm_test_lut3d_transition_gen_params),
 	/* amdgpu_dm_plane_panic_flush() */
 	KUNIT_CASE(dm_test_panic_flush_no_dc_state),
 	KUNIT_CASE(dm_test_panic_flush_disables_dcc),
-- 
2.56.0

