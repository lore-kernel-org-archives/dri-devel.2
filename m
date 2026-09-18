Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6074C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16EB910E888;
	Fri, 18 Sep 2026 08:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POVzRpsb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB9B10E87D
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exnfkKgfbE0jIiR2HgKjblPWB6kR+Wq3l3Tzc8MuSbfLLEpO+zYLmp4lYSDj4LhJKE2B5JR1W3uxAGwFb0CXgb72o1EsNqXyPjoTT5S4wwwoC5V0QvGaQAaDw9oBYPz0RtZtNbpa+VHuBdAcqldkOPhmh6i1IOod1BtqBUSADh+Oxv/Ej6l+/nQ7i28NJ717DOftsLvyANdcKLnQwntzseATMCvAxVCNAORwaXMV5UN3r9zoV9Qzy1AYcMTmbFsLFHA1tA8S9945sHNKaLNTlqhVIfoU0LkOMDLIdUIBZRC5eMp91oSAara435F8pKcKUUw2xF8ErWEk7/4o/mKRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=cYtV4zt9jBF7JT6ToIv29MWbYb/DIa5l+ifCLk4fiHSU8+jCeZkpWXfx4wLpmwLSr4N4TbVmZN3veY4CS3Yppc+1uSfi0KnM+MAWC/Bsj5CX1puUcEY7XUz7yDG5XPt0FBTgjEgZEvl0RCGhtnUTvm5T4NVzdB1KTnx1UiDrvEEFLbuYznTy/hiuqBTlZ7kpMazqdrEdL2uWcFGq+EXSO+RvP4yfWQ1SMjWM7tgIKUTVsQXGU2xs4CV1rSQL3kH4tgh7Z49MD4ouFawY9PXMIo+tlVV7FAOhbu72PVGdLWhgdz5AUN2mv8ET1TLk3+JcfIYT0Y/1HlmKzY0ocVi4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=POVzRpsbiA3nDsfs5cjJAMjPyp+QSYQlBNqbxl4XzP/kuO+RZJ74lDBrjD9POf5tYUNJSQvPQPrrz0ffBVtFjDiaeleMN94LyVEL9ZzFUSDZJrN9J3SFYSitnEsNuuDU0EgX+MN5g0G9TRL7kQSDHnOUaARoWOAFqypgB/TAyVQ=
Received: from BN1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:408:e2::25)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 08:23:25 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::45) by BN1PR13CA0020.outlook.office365.com
 (2603:10b6:408:e2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.9 via Frontend Transport; Fri, 18
 Sep 2026 08:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 08:23:25 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 03:23:22 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
Date: Fri, 18 Sep 2026 16:23:08 +0800
Message-ID: <20260918082311.2213619-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918082311.2213619-1-honghuan@amd.com>
References: <20260918082311.2213619-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d01f90b-6680-4c15-ee7f-08df155e1c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rYeqZcqX0NNWfXFA2rNMUxfoNOxVGUISKP5rxaf/r21sQrvLA68lXR7steiLsqnetyv8TUHeIFoYE9NRx6rkcc6w+xAP8s3H9/2FQxVz4ByDW+CAfjeGXqak2eKpjoSauCMMpaMWSQm6rKudlAptQ1SBdKbVBFXRSEPg+OoL3mwvun/Q55o9n2A2TbDc/AzE+C6vJORyMEcZNhXf+vFld1GlRMtL+uLoz2TiXfIaCILyCJOOYjtVFO60lYxcs/8+AFOZVnbRc77lFCX40/duZ/tM9pIUDT79WD5iu1DnaQnZhCjEff4hOT637ZTiFYvElflass6xw20mo688/Pv2boJrS2KnlfijzRT/Ij2IYX/IqUClw5lv57V/MQMtz5Bd9pBSoUyM9xmk2S0km9Mg7AF9b9RiIci6uDAeoiipp5h9oFdIsok5pOndhrRST2tO510sNXjugi8D/hhFAqkT6CQZWu/W2ba/npYTJXpiMbRM0N1jNAYD2uakOdVRABnULJ/TfeYPFpibQiBvZ8HpkbarhmCCFLdWt1IGMFQuFkGR3WzKZmhahEzShouw1sbtgaDb3t51wXm4MLerAlYfbdI5lxHXgyz3Xb0UTdubve3nHZrRnWV5dQ1qe64z1IDiY1q5ZXpOThxyiHlrf7w4XlGKxMulFj9M9AtUj+P7F3uxn4ZlBHflK2qN46hhOlZ4PzrEGU9zH0XZO/Easd5d+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: prqGvrzmV7g7RpsBs+hOHm3yrDmEcQuGwkUf9uuXsb1ZezkYFCoyN28kW4g9I0XNRdzRVAFdv2BplwfJ03HVMl8Dyk48RcwPYI6Kj3mNYZWt21xaKtx9ZOXaDw1vXQvLg9XUpxirhuSAvJUMSlGi7+V4B0iv0GEB1oPzIn3NbSLnoLN8Woc1Z0tu3Xm2nCl7O/N+LXK6+lk2jYQkH73kpSagbPybEfzGImOzGGGp9HqS9s8DjFLSjcwFrGghVtYyOtyW0JKNyCpjSWMjndYv4rnRyQ5t6WjwUGCdPnwQATtluvScupD8TvtoPX8it66RJIW9HrOvlU1ClT6vub3e4yd6f0x8Vx+nk5+YpRmlSjESj6pYGoX/AU1ElXrxJVmZRS1vNZwSBLu5vuN0HmShffbcx8IsX6kSTZdlTiPKzNmj1FqtcMVr0j4Q8wLIxujQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:23:25.2560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d01f90b-6680-4c15-ee7f-08df155e1c21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
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

Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments.

ROCm (Radeon Open Compute) is AMD's open-source software platform
for GPU compute and HPC workloads.

ID 7 is already used by VIRCL in the virgl/virtio-gpu stack, so
ROCm uses ID 8. A matching virtio-gpu specification change is in
progress to register this assignment.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 4f530d9005..3d4dfadc9d 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1

