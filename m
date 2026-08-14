Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F320C5DF6E
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5F610F75E;
	Fri, 14 Aug 2026 21:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dz2Jl/Z3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3E410F71A;
 Fri, 14 Aug 2026 21:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bY+j8aQGrclNIFaDdO+BKpBv49Vdhe96wFXiUtTYlbjKebEZT56lWUtpXpEvO2uZ0zlmTY40q3u7RefAHw4XeeNvE2YpcKOFjo3iNE7/8ADfWfcjroRSI38LO4D4vW20pnKxmvFG3SbCIWzRIFi6RU923KnMSHMKm10U3SrSfYXOg6G817oSL2u1AZd7UBFXhTEOibTbDHfzrWYhqA9rdoizPCif+ma4Jj8yOz6lYsTxdp1ACbBxcJ0JgIXr94PUJT14Zw0jj1Sh1uyHmuCxy4+lYrLnDCMNDZPLtk+D1TWwLYc0Necku8UQC71wKDXnmQRf6QgEP3/01YOgZuE1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aSp7BmYfKOqo2sKpO+hiUGRibOw9yNr+04opeqC8a8=;
 b=QL2b6+iufLhjEzgZo5s/a33hoQR4FmdoYlAxD4sj22Da70M5mim4AJirfjXVER/wTehBOYlKHoLD7xqoJWOt3XTIoZPQBQIuDIXZM6EnSOF71RJcti6FHpcBP7Ou+OplEp2EuBBuqIhCEynp6n8ka5kpaNJKaKB/lFjM7BGGkvjiPzPVLjPwbPmAQFgZQeEqKalJLOlWXYeDcuXmBxPYa8JvlIMFtgvs7dnRDvBE5tJPMb30k0CgHYTdS8Jho4B1+iXHBY+dDl5ToGvZXlrl0wALAoTZzqlTEQtmcbt7BzPHnqq+cfKyUVzyKuOivIuqFPJoKcDJzrdD0U/fzkqy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aSp7BmYfKOqo2sKpO+hiUGRibOw9yNr+04opeqC8a8=;
 b=Dz2Jl/Z3u6hIyIVy1Cm0P+dSPY7oB7AavwsjaBtbJ8gyx1+qQHrBtpmBymCVWXtov+Urwiy2sie/8icFRSlProombBFvKsTjgr0FThCVH/pf3sk8abrvAjHJQBTYuG1IBc4Zl9DKMAEp7dFiQXbPIMmrzABgfK6/7MTPi9rPCnA=
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:18:21 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::a2) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:20 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:20 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 05/10] drm/amd/display: Add fixed matrix colorop to color
 pipeline
Date: Fri, 14 Aug 2026 17:18:11 -0400
Message-ID: <20260814211816.1219597-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: fd603a2a-1b4b-417f-4570-08defa4991bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5cmp/pP1+iLWzoZL5sK9fcJrwa+L919lhXN15tQmfya1mC/w/MOH6uxVuTXlcNzOSkMKAs5kKtm5w8hCYTxsFayaw1ohSA/nYSwPxx3E8I069eD3QB/lWPfK+eLBUSuzAZsicQWH91mlzQ2d9uEaPu0nwI5pfvKUoZDf+OsYgIw6Vz1EtONTQViTnQp3KxtEV7MxgE2Vj+QOSEzidWk8OwwAg43NQghH4CsYAmp+FiFnyxgpmS2YXCTRFvOJ9afMsTpNZKieoeRzhCTAsXFvKRnH14g73jcBXiJXJWHtflAt6lGPpmZuIr36b+2wWc8ksPND4LArAUpmU4cHmcTQT+/zshj2XXRyhPC7UEZwiuLhbcbzelE30n5szFc4qQGURJm30mfnTXiSNMS4J7HzhwmqpoKfsn4UN7IMvwtAyMiDXlJhyKVM9mmn9+E/6HCxiEe3fex/P08Puk2z42Rb65YnRhKEmQ6Oe6R6JmV1qXFDikZwgFiheqFcq5bK3V4qZCsMNdzOL4PWtHiJt3NSFgM+lm+v1gmxw9uwtdW6e6DKDRQKQl+CorPwtrNyOVZ6agdq9pstHV7jZllnBcI2dwmwdMmSEAVdAXR18op+999GI1N+RO8CWQKeNv/ZNZnjPbHBLuFhUCYd1SMvJbZYrHdzOos+3Trvpnkme1JTwDWMXqrFaCtSJrYLVK35m3k7N8AiLjTovC5mo/72I/3zdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6WZNSXO0MMEfHdNiZwY4YtlZGdFrJY3Lqis0zJ8/kKRWhRJesR8OVsGE4FdPuQL/W7NcRNTB5JFUDrerbag467gW/dxbNNV2ejIbNTgUvWM0JRJRfvDLn1UlZGlfa3nN3PsG9jjXpNrwO9sqSFECH1ioPlUKqE/PHFb6i5qdgFIeD8+0cux/tRZrKZ35NnpEoblE9ZGVwBvAT465fkCnLbzDqCxAwfFKmJc7IPegBaN7ncQon81enJOBzfIbrXOvAvDTDzT+rrQ0i/ogkWprDuULZq7P7O4a8ZUHAFyZnlne0FygHz310laQ6JFfVPs49+s6BQXSjsL5NF0W/S9k4PcxiJ3OpOVPmtj7zYBfEeA+oODDVhV4bGX5/tTJj20gdmYATAdBzdxV/yuN66Lx+oTshudlHyty54W34dJr65IpK6Ly46EKUZ1q7AYuGWA/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:21.7169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd603a2a-1b4b-417f-4570-08defa4991bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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

Insert a fixed matrix colorop as the first operation in the
amdgpu color pipeline, before the existing DEGAM 1D curve. This
allows userspace to select YUV-to-RGB conversion via the color
pipeline for YCbCr framebuffers.

The fixed matrix colorop advertises support for all six YUV-to-RGB
conversion presets:
  - YUV601/709/2020 full-range to RGB
  - YUV601/709/2020 limited-range to RGB

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 27 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 056a76b88f43..1ed12cdce317 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -55,6 +55,14 @@ const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
 EXPORT_IF_KUNIT(amdgpu_dm_supported_blnd_tfs);
 
+const u64 amdgpu_dm_supported_fm =
+	BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR601_LIMITED_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR709_LIMITED_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB);
+
 #define MAX_COLOR_PIPELINE_OPS 10
 
 #define LUT3D_SIZE		17
@@ -73,6 +81,23 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 
 	memset(ops, 0, sizeof(ops));
 
+	/* Fixed Matrix (YUV to RGB) */
+	ops[i] = kzalloc_obj(*ops[0]);
+	if (!ops[i]) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_plane_colorop_fixed_matrix_init(dev, ops[i], plane, &dm_colorop_funcs,
+						  amdgpu_dm_supported_fm,
+						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	if (ret)
+		goto cleanup;
+
+	list->type = ops[i]->base.id;
+
+	i++;
+
 	/* 1D curve - DEGAM TF */
 	ops[i] = kzalloc_obj(*ops[0]);
 	if (!ops[i]) {
@@ -86,7 +111,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	if (ret)
 		goto cleanup;
 
-	list->type = ops[i]->base.id;
+	drm_colorop_set_next_property(ops[i - 1], ops[i]);
 
 	i++;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 77364d954d3b..7802efa5312d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -30,6 +30,7 @@
 extern const u64 amdgpu_dm_supported_degam_tfs;
 extern const u64 amdgpu_dm_supported_shaper_tfs;
 extern const u64 amdgpu_dm_supported_blnd_tfs;
+extern const u64 amdgpu_dm_supported_fm;
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
-- 
2.55.0

