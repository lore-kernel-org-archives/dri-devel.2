Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A42607264E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XjpJWT54
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC56310FF35;
	Wed,  4 Nov 2026 22:16:12 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D5E10FF35
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bu+3lHCO5lSMF5emjZOOCGbP2cDOKTsyxb5bAcCsppzshFq9neGTXSoaRqnoy8odOhhzAQf2okZpNtCexEMrICpmh3zFkO5KWrFQVr1eErvfONSxz+1q+emQ0Rb2CQIAM5YkVJG/wcbE9XMObO5ophddIYaCJwQb6mby1WoRZjGiN78WDMyueRNvD9namZsG1/TcRUBRTm2VDgZdQTcm59SxSeZwhLce+QOW3xm+fJF5gFk0zWTidsXJ0eUIADpHA//q0460N0KhPjdON3MDMRT7SLBOmnzbP3yt0uII5Qe0pLGhhxp96o+qcf0pIzUg2OLMv09xjCl+tQ517mqRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtuEnitAViyPZZvLuUFsPd+dGyroG/JRi4ghERTiCAY=;
 b=EgTVp42UhDRnIfLhlHcoXZKt2DVdJrmNWyD/BKS57GtNrEnrZPfouslb2JeHI/WejcgeF69mLChXAbHXr/pOWU1kRo5XRe5HJKy1CRmieLIgbtigqLUVDzndfpGG2yr59rmPURqiGHeblW0iH5wBh6p9ScAqsefTqugf39dqfxGxlrbbiHREBNDULKzr11VETJ8g1rehmFEWq3YNZCGsGAndJGQ4dzisvw+TGtELgks7C5KEpIBgNkdTIQR5yaw8kMnm4XmJb85piok8nF+L9ZI3D3Ctt2Eh3i8/4y/JK/hBsCI+cZOx3XNOv78sYSoQgtK8Pz/14ml2CzHwVXa6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtuEnitAViyPZZvLuUFsPd+dGyroG/JRi4ghERTiCAY=;
 b=XjpJWT54Lamp3UX9WOpSk1sURCbLfj05R3WVrC4hhf+CiKDuKFnYTNrZxawkG8Ceu6jJuOU2OclCjdSSGXX9qMs8rSwyybwLK+Z5XF8/TzfT9U2iIwJQRzfjVUIHoNoFt+wF6DbyPkTnzW6Y2wSZRnwzsD7LhtPCaPz+MGcVlPk=
Received: from CH2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:610:54::20)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 22:15:56 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::6f) by CH2PR11CA0010.outlook.office365.com
 (2603:10b6:610:54::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 22:15:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:15:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:52 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:15:51 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH V1 4/4] accel/amdxdna: Add AIE4 CERT firmware version query
Date: Wed, 4 Nov 2026 14:15:40 -0800
Message-ID: <20261104221540.631182-5-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104221540.631182-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261104221540.631182-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ec213e-12a0-4dfe-5bef-08df3ac132bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|56012099006|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: kvPCDsuqPF960tkfdzBxddAfZ+lkE7u21f7iiu6h6UBNmy7L91qhdz2CAvZmKCd3kn2kZa8Mvhwc2K+WEk1Gwg0AVSFjzPa0l1mODxa3k6A3dhoK/jcWQn5r4MJT2ECxoYdWmke8Gn/LvroZLp1HeyI9Xo607D+E1ULHFbuJ3FMzSYRBYd4WbaNp+PmeFsskDvbKshtq7PpXXt+mUtMx/X+gv5fsFovx+K3o5NwT/RozHlBCXSTJVGGXqK3Yke1q+bhTttgiQVWSPuoSssrk2Y0MspvJR9d2EBA4dGBlze61vuZ4nRJwhYYVyrP8hlBvEKDQJUYkDDFp3FPwz6o1B+KfgzidCzqERrJNQUjC/UUZCH48AagWKBTTDlvc5Zhw10MajtplcjRbAoQ3UYnrXz5UXeGBgsUA12fnCf5micLDgQLzOUbqG1B8hb3bseheGmSOfJfwgPL8IsRKwylWQ6e6yTXDk08JaNlJaiZLHQkUT5DQxI5slDf9asQTMwntp3DM9z3azI+E8i4hslcELbZ+flAlBZ6pn8DMIqJrmz8Z6M3QQRXMEmIlv/+I1kQJiOFPVvlEj1V1g4TjHQhu0g7ZGBVtO1NBh96HtbfMZsjOVNJVzNYB8vxyIZKTCKbnEj4DXmRKalKW3vOq6bJa+6L4F6lueZ0CZid2dfivmyLotP59cDK11bJaWMoA9O/JJ2MOdqH4Me567rYvXPPqLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(56012099006)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vKMNvc0iBqDKfvB8hkM+0QNDbWY0qKFRe4Qs/M39eFRduPz6cvSTgYZs9lOSqhmYiYrDEeL7w8oDo+sFQ6FE/tsvUm5HHJ8cwesPc+Nc2o30HEXMOuHQPc9rt0IteEP1ARMwwlde4aT5hAwLRZEqoo0KAJ+y1hyN/H1HRKvesoKz4M9w+LAp1xCj6e9YGSlOOiR6N2kv8AE1pzzhgKzRvD+QBKn+Celrd4tDiKWJD29IoJZi+xdEbmjjaeKl8LqgwAPrugVUDhZpTcj0lkBN41wPanI2ewsbGQgp9UqZN0eibAANPcO0nHV+C7jfvPx5H3aApqhMAMS3TKgnGs2Tk2jW+M7wwcwOd4Y2RmbVSTa3RE80th09zEyDPGeCLeLc0DebAbNk6EdgeLxFEONEA7PCOC/Uj3CAXDeUi1NiKUsXW0URa3+DUC+p9cgJ2r/a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:15:56.3558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ec213e-12a0-4dfe-5bef-08df3ac132bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523
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

