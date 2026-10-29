Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB934606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IBkvroz8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC9E1123B8;
	Thu, 29 Oct 2026 15:20:59 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290371123AC;
 Thu, 29 Oct 2026 15:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUhGKXgIZv8C/A9DmxGBY/xm+CKPyREvO7qZitILwbVo0kl0WXvc9bhS/XyL/QPsoxAL39qttV812gMPBsHfJqO8eY+ZnTkY3tYRNG+/9qBrgoKYD2kRtEfLS3DK0K9vu/Jv6usS7dXfD/Zxa0ViHrC4X3MoTKOarYFwcr3f2gr3KGWiJPa6FJNqw7THZCuhqXUkVNECZZSrc17l5udhOvKJNelDB7wpRn9GAaKwaZEJMgP55fxyXyY0W96igO80GG0LriYd3kNmMBzLMQqCxBYldlLe9PBn4xXUmxhX0maHXH4lBLe/OkcoljdIMuilzvtMnmhX6IesmpatDQS/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHRbE7ItIBkQovWEVou3Lt/A2H1i5Z/uZE2k7Z2f4PY=;
 b=iqpAKNelWKLTp4am0Y9xsMFIMHOZDzcai8JUbcGOdWjp3gVzYxSVbI+aVX20mF3U3ybNK7zDLGxR/ivxJfw60nQHikDeacdFa96nD5slQHu37QowhkGYb2/rRW9cLkYqY4wjKKG30+9To/dT5mBymZx2NI8Ur4WKYkKJS99qBVrTVYTLZ8tDhvf0oNIocytR/NzpQla/IwDjWB1nvDkuJgW1fys/D/Jo9rp3mCTr3c5uaXoKbRFJ3SsiDAFDLDloXSdfczbqW/OIoNZGn6FHGPYTJQATn64M7KgkmeM1scii0TWXp+fctglSuSp/sYOmfEqN0+Lxje/6BvVB7AeHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHRbE7ItIBkQovWEVou3Lt/A2H1i5Z/uZE2k7Z2f4PY=;
 b=IBkvroz8lBynWp7cH6u1vgN9xP29SC7f0QuFY/WfGULsV5iAC6f493z1kuG6VUzse1q+b6umuQaSIjeUpth4i9AY9m6GN+zZ6BgSiOPLz276uIgyZOD3djzUr3gt8q2J6xKNxI7NS6sfnSkDUYTv06PWO28g2j8zWAebqeKNSwA=
Received: from CH0PR03CA0446.namprd03.prod.outlook.com (2603:10b6:610:10e::35)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 15:20:41 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::98) by CH0PR03CA0446.outlook.office365.com
 (2603:10b6:610:10e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 15:20:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 15:20:39 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 10:20:36 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/5] drm/amdgpu: fix NULL deref in error path
Date: Thu, 29 Oct 2026 16:19:48 +0100
Message-ID: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: efc5d708-5466-456b-c338-08df35d030b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|260925022911599003|260925021311599003|10067099003|260925021911599003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Uh0XYkbVbIq9zd65r5tL5U2XUecOfDyyPrB/Y0xh4MPi055rwa1I9QdVZc13H4DH8eEU4hNNQhbUFBOItEXJWWauBNCku4ZDpO4YrX5bhBGavHUAXR7098pZmMhhKn/aAO/vtILUSlTDe8qnk/59D2wQ75vMXeJc+2qJ1gWIDk6kP5Kpt3iCrAsQ4Kji6LIesTsM5CToqHumBW17zoKYxWOWdLYdvf83h4S3xscLwkP6Ir97YTsf7Iq/MLAvZNGX15bLGQAyAntIxv63X11u3KpVyFYA51jj3o0nPzU1j7nwXZpqiEseXuKSFxZk7LUSmQUfMcEXmrvlnXHVtBk3r1TfnNF7of63kXh2pCzS54n1GYQRehjZ09NgmtvGa/7sNoTLY31avlKY+5llGWvJ0I8f3iQ00/3pzj3zARA6YlNtfSysH78kItCkjqBio/WAq5u8I7fhh0V9n/xpYUKJsw+autBn9Hcb70n/YpOZiepBF+DoqSTypCUSR8rVLfiRrK+Be0CT5Zvk3Y7dTipY+N2ec99nsrMtepaR9g2+qVUokdU01cDi2T3f8Q97RkiB5YAfXipBPq0DLbsNGBnc0a4tFv5DDdtzvTRUwIdpcyFn50GFEnq1ApR+cjDxaiOfGhgQpOIg4ZWYJyEBbp+23vurAv0hzZx8TVUvfUU7yy8eewPQxLJlzlkaXOY6R9R+8jadecNIsOGjL42b7Fe5xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(260925022911599003)(260925021311599003)(10067099003)(260925021911599003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DA6hvJ2nt6o+cMzi7DjRS//ZZkXINFGSDno04pO843VsZm/n5CLSsdki20nkTcood+K1vyLTAchXOsMTQ4OcXuOdqLQ/UAtzxlz2UycY1ztXzunIUMyxGqTI1M7fw5yjhp4FJXqBcqAcg0a03N5ocdH7Oj0/MiMZZ2/NMSPqqwNjJ5J7nZmeOxHvSGbj+tVN9CgK6yaN6a/FwkLYCAwwZ0/nODets4XD25RLbzVqbHQHwgS4TNp4ax2n8lPXSkkfDD9QP0X+O5tAAsnOhnri3NmtmQ1di92wOtk+aFH3OnGnm6FAXEEveItwCmhNOL3w9dDH4+0C5wotwcRbauXMxRjE2J6jvQ9B/UoGnIq65VC+9I4WiErk7dXSAP5r/kV9bKjv7Jb7Y30xdeX+Er/Ur2Lka9R1e8C+gZER6AM5mQsHkQFD+wX2spWHPefnoV1L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:20:39.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc5d708-5466-456b-c338-08df35d030b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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

IF we hit the "error_free_root" error path, amdgpu_vm_pt_free_root
is called which will clear vm->root.bo so calling amdgpu_bo_unreserve
will crash.
Since root_bo is a reference to the BO previously installed as
vm->root.bo, use it.

Fixes: 8473bfdcb5b1 ("drm/amdgpu: fix error handling in amdgpu_vm_init")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 000c982816a7..ea8688061237 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2716,7 +2716,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free_root:
 	amdgpu_vm_pt_free_root(adev, vm);
-	amdgpu_bo_unreserve(vm->root.bo);
+	amdgpu_bo_unreserve(root_bo);
 	amdgpu_bo_unref(&root_bo);
 
 error_free_delayed:
-- 
2.43.0

