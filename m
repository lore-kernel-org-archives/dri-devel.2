Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F25CFF8864
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D7C10E9FB;
	Tue, 28 Apr 2026 02:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="unioIHw9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AE910E9FB;
 Tue, 28 Apr 2026 02:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSM7YELtnh+W3/V1GBXekz228fGIKi5OlvMsKQPaUwngHy7RfIuvG+LeL7NDxQbHa+E/d560zaXd+dhxphMIXFtCzBfFaP3Ll5RXHLat2ETSmoXZCh+Te7H20nB6cWM2a5pZwMtuUHYmiHrkAWChvj1FpuUHubbL0OX0KipjHTYkOhqVoWBnLK949xvHdJbJtTN6k6ccGesTN/K7HBLBNs0orD8twUV9ggWl93fKqnNQvStNMoCuwMf/xCu8DbOpP+J1sVranHvtc/6u5GWiem2tvETJaBIBf02rr7zr0CZqJrOS4+PsL9senxpMQ59oPHEBOZZg7alJesRgwhPEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDyUNoctDMfwm+g2l5JMBDbLiL5Q6jDUdV3kLUHo9hU=;
 b=sGLJJZZNk5Xq1A6GjYcRSEp1CoMQ5W0HsrckOjj5kxMPqKhdoxTrcA2gYjRqazViPRvW2uRA15gdb1s+6aPyNXD26dO5wZVUqIhmE0rrR/6cZDJIROeHiHy3baPJeW0lURzNmiBaug0MSZzpYi2cupC0/skzzuBdVH1n8GwsIms/oIWclxDf6S9QBmsmBVAlunVIMzDm5YHYiBM7vTOd2RPUZFgGeMFJ7Z4/KC/ivJEP0bGztGrEKbRkjR5nQysuCl9kb7SskegaRX3cSAxSKVf5aJBLnIVSBW7VKS7I/4RowOtpv2E2uzkdWhnSeDA3EnbPIKhv1Smxl2e8xHjltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDyUNoctDMfwm+g2l5JMBDbLiL5Q6jDUdV3kLUHo9hU=;
 b=unioIHw9S2L35SAAkqPP8IkKrN8CbDnXjTZjWrO+FfdEM80U3jzgjhbOMBWP8I1wT/dhU+5fwAbmn2LEOKRUove9sSzsnHArlsyoV/IzliR0eQC/HGevtiIzSeEvl2Amw+yxg14GikO3yfWtEHu384YYti9HQaYiPo0fy/D0Lyw/iUFm5nO24xJe3XcYWeQD3fMVqytocGtNKWB20QH7DRx2s+lF1p4qqo5qnDjXBV2kxD2eiKOvkoyGEwfDQ2P0COsYAeMl3xjfSDmR9aGPsngVPEsTom1lOYaTQZ/4iBm7LnHEr9H9xi2b/58qwVk0Dw5ry2Mv29/WO+QjDvtaRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 02:26:08 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 02:26:08 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH] drm/amdkfd: simplify kgd_gfx_v9_get_cu_occupancy()
Date: Mon, 27 Apr 2026 22:26:04 -0400
Message-ID: <20260428022605.447901-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:408:143::12) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b13a83-8e95-4300-f1b4-08dea4cd816d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: rrjMYlU5UhptM2V1qj9cMGRO6F7V84+l5emyb/R8HckBmznxk2G6lq8PFTIrY228UlronmoonwVbiSoy3y/1LTyAO+trEPTwe4QkRjcWszp6Ubv0m6Yj3S6QVbQk3HNMDyqgSn5sfbx41iBCemHTLfcpIvjqpXDJWqIrgz2ioTabSaeE4FKJh3pQvs8SjFByAw3Ob1qYRRWwi4GEjfuvwwlCzelQ6nvjN7XePy8qiVyGLKqh4mF4qzIZIA6vYE/023LxCiAgLDzBKnYS0hWXdjnYQcENyUodssLU7U4hDpFSHtajKP8iWxyV8rUNe5c+32LsS3Iy3uJVoeRPdPGLPpC2rzvo+mUQoFdaq74UBfyBy3Dfz1//M0cxcTPD/eFbwOHohnEtXEB0uNnIKebs6szOeS/ce3WtPwoSm/6Yw1vTQunZ2PKoj4rQnbhoIcziGL5WGpG0i1/aT3YZL0Ce3w/NgAM29g4q8BTaoKtxYCnrxgXCd79ImrMQ+oHuMme4jCtqo9ucItUfQ45O7BwUxV+y0uQ3i6FaX/5pSh+DaCyNd6YEpCG9Esm0kdhDKPHRUly8xClLH5ulv7/97AjMQVqvQ0uZJrxkehRVKB80nQED0zgWYGxkfPjoDVAPES/R27mVlJRCMFmeI+3mruT1L0OOOkl/s4RJCBbRyqwzZy8L8fCaP3m47mpEy/zvJ4A1or3RAAFvqsMhUiRMqfdKvv0vDBcw24ivxAjc3sjsOn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0BZQAeZugx2o51ZjCMZJASQF0/T2BfzV52MVo+a4H9gaHSeXP/Y87poeYeP?=
 =?us-ascii?Q?eUtKWjV+f5BIbxqN+Jr9GhpNQenijIwxZItSZ9PaULbSYmvUQMu2MDCmZMvB?=
 =?us-ascii?Q?yZhXMX5aEh+ZoW8bhimLtgJjL3HWH+IraWaucvZsD6ow8+Bzn/uLqlXig/C4?=
 =?us-ascii?Q?pR7Q+mXchhS7oqMFjGTYIddeg7F8M6wtjXCelGJaSeEMcnKcjWACrmEkPl2o?=
 =?us-ascii?Q?76e1IEI28NhHOhKgSkbMsGTsyFRabzhThBAAjFAQt6jQaxyig+LpcxTXeJh2?=
 =?us-ascii?Q?Yk8JpH4X6ean1/pC5s18PKB2k7420+neBpz57fcDebvcKaScMCUKqr5EeQ1u?=
 =?us-ascii?Q?SwjvACI50E50sRCErS9dmgslKP4FKQEBwRwEYZs2JIggr/sveE2jPGDFam+t?=
 =?us-ascii?Q?gZjOUvncVtSZibhg0cBEA87Duh/x/h0s446N0ddbHDEcFH2yEk/KjE1cW3Db?=
 =?us-ascii?Q?ExuYbq7shAsdKUd83DW8x4Kx9WXrAjiRXxmUBK/9Zk9toDgOUVhHkm68af2K?=
 =?us-ascii?Q?TN/sGdjxP/zbjot1IQ6sYlEZOa/rrJ8F885nunYGHKN9HX2elLs74KXQ3aO8?=
 =?us-ascii?Q?b398R0rV4JuK90aJ5hREloZhTOG2hReH5AdGTBnseBALGL46fjgWihcKtQfg?=
 =?us-ascii?Q?GQ/ud5p84bKCqsNwXrH7ZYE/9tezL2cwxoyKn6nKfnAJyZKSU0DeA/plWJIU?=
 =?us-ascii?Q?WxTQtvlF2gfxQxlPAW2++WSgREBR99CTbtSxtS0KzA3+GEgNJMtCGWgAVQ4r?=
 =?us-ascii?Q?JEpfcMM+ctDfRhhhgPy8JgW7d0X1IDzM05SCB0UcZYPfKSzbelbUOzrHNXCk?=
 =?us-ascii?Q?anqRfgk+YUpSoXy+Uu+AHUXfIEXLRxfpBQ4FA6eK5J112yz/okc1SwC16444?=
 =?us-ascii?Q?sXYgPSfdzcS91r8uHFwoyZ8mlJe4crTzY/yeRhw1cxDZiWge8ocgt6wSOeI8?=
 =?us-ascii?Q?2uclyF8v0NR/AhefmJQTd5ZxLKHvdkHi5wTS/WEzTYYCw0jivZbXzKZ12PfK?=
 =?us-ascii?Q?O1CY+EN/1OUngE4pDmOZbv/wOMlW8KoM61xDCU7KaVmurbUO9E2pkufEXXFI?=
 =?us-ascii?Q?BjBmWRsWdKGPoOPXLaeNT4NYN+Ksqe265xuLc57sARErrASq9Z+IvARS1PD3?=
 =?us-ascii?Q?AP4+zTddQHkIssoyGFhmoyqfJ69j6ldQC+pTlt8fCaXm9v1M34hf0Vk9ZyD3?=
 =?us-ascii?Q?ouerozH8hpRWGam/1z5kxLjdSZiIa3OIfx4C5yn14olzzOojQKhrxTrWI+Wi?=
 =?us-ascii?Q?SCGwK6Ru6tEJKFRG3m3/cr0noyU6t2EAsCjCJMWJ+fC7ZFovFF4/6QVHqJJz?=
 =?us-ascii?Q?SCjG3OAcAnwR0GgN90Y+FgLHQJHqlkj1oiFp4OnMYxmNyCFdVvGhu/seQsgz?=
 =?us-ascii?Q?pLJIjgqCflSReVt5DZpTVxAD84M+dCKJd5ksa6VJj4mBz4+YR9ZwH64zcSQd?=
 =?us-ascii?Q?RO7zhaVsZDfwonKJiBM3JhDUU2PvMnE6YluWFmjxRFwbENbFi1wxCklm4fS4?=
 =?us-ascii?Q?EquekwEnSfsoAHHr0+Ve+G36eJbGKUmxJkwHj3ZLhBuRSkMS3t5mEpwzj/qH?=
 =?us-ascii?Q?QAVTxDiuMefTKCyJz+BvZDFELS9qv7xbdfu6TycFMHwVnfShahqTJMC0jpUo?=
 =?us-ascii?Q?QQ2Crgx4vfaOpO8ok9KEmvLHqRIQrzAactv/hRlYIo673DN+LkjiwocSuHux?=
 =?us-ascii?Q?NYHC/M0jxHpgzTSngw2CNwl5Xl00wE5XJqYhys+6vvBSHaI4+HQ3mMWuB9lP?=
 =?us-ascii?Q?2TUPPNN+X9C8Az5OTRCzhABn1noe3R/g6dO13M6PyLTQZpJBQ8XT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b13a83-8e95-4300-f1b4-08dea4cd816d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:26:08.1570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBk1MVGITPv87UCMBXa9/Af3cyONbB5q3YqvZCWaSF/9BSYE+oKuBtMvp2oJDnjtMk3we3kLiM1Ob+z4j0D89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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

Switch inner loop in kgd_gfx_v9_get_cu_occupancy() to the dedicated
for_each(), and drop most of housekeeping code.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 32 +++++++------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 2e116c06d5be..08f4c4bf20c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1026,9 +1026,8 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 	int qidx;
 	int se_idx;
 	int se_cnt;
-	int queue_map;
-	int max_queue_cnt;
-	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
+	DECLARE_BITMAP(queue_map, 32);
+	int max_queue_cnt, queue_reg;
 
 	lock_spi_csq_mutexes(adev);
 	soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));
@@ -1037,35 +1036,26 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 	 * Iterate through the shader engines and arrays of the device
 	 * to get number of waves in flight
 	 */
-	bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bitmap,
-			  AMDGPU_MAX_QUEUES);
 	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
 			adev->gfx.mec.num_queue_per_pipe;
 	se_cnt = adev->gfx.config.max_shader_engines;
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
 		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
-		queue_map = RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CSQ_WF_ACTIVE_STATUS);
+		queue_reg = RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CSQ_WF_ACTIVE_STATUS);
+		bitmap_from_arr32(queue_map, &queue_reg, 32);
 
 		/*
 		 * Assumption: queue map encodes following schema: four
 		 * pipes per each micro-engine, with each pipe mapping
 		 * eight queues. This schema is true for GFX9 devices
-		 * and must be verified for newer device families
+		 * and must be verified for newer device families.
+		 *
+		 * Get number of waves in flight and aggregate them, and skip
+		 * queues that are not associated with compute functions.
 		 */
-		for (qidx = 0; qidx < max_queue_cnt; qidx++) {
-			/* Skip qeueus that are not associated with
-			 * compute functions
-			 */
-			if (!test_bit(qidx, cp_queue_bitmap))
-				continue;
-
-			if (!(queue_map & (1 << qidx)))
-				continue;
-
-			/* Get number of waves in flight and aggregate them */
-			get_wave_count(adev, qidx, &cu_occupancy[qidx],
-					inst);
-		}
+		for_each_andnot_bit(qidx, adev->gfx.mec_bitmap[0].queue_bitmap,
+					queue_map, max_queue_cnt)
+			get_wave_count(adev, qidx, &cu_occupancy[qidx], inst);
 	}
 
 	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
-- 
2.51.0

