Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF04606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NKzUvxui
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC55310FF7A;
	Wed,  4 Nov 2026 22:43:25 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3C610FF90
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmNc7OObTkbzpMrC9IJayZoLcBW8A3075630zfSonxmDdlXOzC/3TrpZFEKOuKXlgdyiSVqwsX+fTCwYAlihfRTafN/n6Xm55YbGZtZDUJb6/oPche2CwFFCltP8ciAMhf9OMB11BO3NXku4p5soCjWPXLQXx79tjjszH/DUNQ42BZp3pDJ/8sjJQkECRTxqnM7730Ygi23ILwWNIjVPO8NGntEeacHSy53DgSgDgApi2kTCzUdIwaKIv0X3yrtFnkazEggX9sx5zrvv2CAU0tLoCwqWDCcLaqcBcTm4dQtUGIAeqX1NcTSH7tnm9rNK8lU9QGe9zFgFNESly1u2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtuEnitAViyPZZvLuUFsPd+dGyroG/JRi4ghERTiCAY=;
 b=pktVmayO0j6dd3d0IAg4b2YLxQWLxyHWlEqT0KY1xvoXPxq1V/11SUILZIuzTeENd7TaiYcG2VT1RrxfMy63sTtzfTK3oJdR7pTmLAgGILX6EAcAkNzJmMPE/tQm1/unmZYFtmLTp50KqmH4Fv7koGn4qum1LftMyT3r1NeCOlCW5053KoJEryZs4c3snxTFzQfF6NHTEhqBP/pA91p1z6UTEkPvjqwhfk2IRCpbC/KZY96e6MX0m7417nfobtEVHSgdlXFAu06+Fp7NVg6snUTBVi7NvToG1ZbDxSXe2KWae0TcEU+sMws6BqvYQ/LnGcqI2bnTfKwyLtgB7FDWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtuEnitAViyPZZvLuUFsPd+dGyroG/JRi4ghERTiCAY=;
 b=NKzUvxuiJ2NX0r5do0k4afIQvZ6BDtsjVbe3iIh0VjoSIxhjt/xy5JqkRZ/UNRbcMweOr2Qmj6cveRE9XBt7gJeafmTXreDv4o0YgIynDNjdX08/sKjUQ4/1yMw/UxBFGc+RcM4ORGKYkB1CogY1SKCObKLENG8dLvirNWEV/EI=
Received: from SJ0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:a03:3a0::12)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 22:43:15 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::e) by SJ0PR03CA0247.outlook.office365.com
 (2603:10b6:a03:3a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 22:43:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:43:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:43:13 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:43:12 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH RESEND V1 4/4] accel/amdxdna: Add AIE4 CERT firmware version
 query
Date: Wed, 4 Nov 2026 14:43:02 -0800
Message-ID: <20261104224302.643329-5-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104224302.643329-1-yidong.zhang@amd.com>
References: <20261104224302.643329-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: b21a7328-4e6d-46e6-b2a1-08df3ac502d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|7416014|36860700016|56012099006|11063799006|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: VW2qawQgVrj2NQWvQTcIj6/wsoo4YAQVCBhyq8IX2PGMlNqPAvjhGBaHMM3YSkVmviqGyGiMWsKbvvm/qJuMZjdPIv1LEkqCrHq+FFSxNufJ+n6w/vt+plEDjZ1ttNlczoL9aY2wphKdSpe11gjtC+XY3tbSk89XJ2nFuxIuTXu0gEUVwTEPyNDwTYgxzigFhQqSjwGOUnKW++Y/IdXRm5InquH0LFEtwYqqtshq+UcKDha5uYTNB2dTED1zEfdRxaaDi8EdM8QZCB7N7DTWJ3nnWbk+sjRJGs8IHhSIGDxsmM4YRYkn5yvfDdxPuS2qYJjpelQ9xKXoa4/L3I0b5VbPN9tYsYolgIn+NFDLsoTcM3ehs6ofsT/cParq57UKIEuMFhOK1LVG/hlNl6YmpsvzqDw7EwijUiB9f/ryXD10Vw6jvuPV9jhRq7WQCuVTVFfbLga+facXvFCAQTlFE5wZo131kAEJYgMEaflKUbFb4hN7iBzrkjPI06nLB3kxuFIE9Z4FVmxmrM6/lr/UKVpdax+HqARDd7NR6I/b9y85r8/wl7KvJdcrvmtjQUGIxX1RFIS9h2l1ubSV31//fstKyGDEQ/f4gLVdWvXpe7V1RR+UDcjMdPv1R8a+hCamgFf92L8NPBJaHA0QCCxwuHlm/RphXIHsPL517pEDefyJKh2Dj1mCSAuMzJczz8wGd+uIrx/Du49JuYin8mmreA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(7416014)(36860700016)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UFEapdAg8sAoIpXHpRszauKmwCJedcCgQXXWDL882ZLkrBmLA+b4+q1J6nW2hdQH3Qe/MKoJZHtR0Q5f+qxTVe7LetpbRKBCgP+NLxo9tfH19qjG9tFPi09KKqW1X0NgLIMXuhw/wCaecQGW448E+8uKCNgp0kCYlxPY3tUG1RolkR8vjzPDiYsNyRF05DaBJjkK/rr6zHiulmiecFa6xka0RnOlbfowBWK9YDbQu4jXQy/RLXd/kemMGdyMticvkUymlF2myTgjzc0hc2TdXdzgCuoY5czrLQ1MJUUkNgeXvqwWsMUCZARWPrrYok2jo7X8nxKav1YmI3YP9FJurYds58KsxIdIsSvY6ncGrRWbbG/DDdgywVcfL/QPef8T/59VtwonRrIN/RJ6OZV9n/qEonPUBX2ORZcPCi+KrPDRilKT8IHADYfcG4HUI9OV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:43:13.8924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21a7328-4e6d-46e6-b2a1-08df3ac502d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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

Enable the CERT firmware version query ioctl on AIE4.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c | 3 +++
 include/uapi/drm/amdxdna_accel.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 101f0f27b466..5b1d61dd0d8a 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -835,6 +835,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
 		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
 		break;
+	case DRM_AMDXDNA_QUERY_CERT_FIRMWARE_VERSION:
+		ret = amdxdna_get_firmware_version(client, args, &ndev->cert_version);
+		break;
 	case DRM_AMDXDNA_GET_POWER_MODE:
 		ret = aie4_get_power_mode(client, args);
 		break;
diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index 0e41c45ba720..6369d82e5067 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -525,6 +525,7 @@ enum amdxdna_drm_get_param {
 	DRM_AMDXDNA_GET_FORCE_PREEMPT_STATE,
 	DRM_AMDXDNA_QUERY_RESOURCE_INFO,
 	DRM_AMDXDNA_GET_FRAME_BOUNDARY_PREEMPT_STATE,
+	DRM_AMDXDNA_QUERY_CERT_FIRMWARE_VERSION = 14,
 };
 
 /**
-- 
2.34.1

