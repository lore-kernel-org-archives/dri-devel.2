Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE1FC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C6210EEA7;
	Tue,  1 Sep 2026 19:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LjdvFN64";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D3B10EEA7;
 Tue,  1 Sep 2026 19:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfogpQrNmidkXfGA/cKs7E6gQ+ADhYJzmVdspxP7GeceqWHg0ZATybzApzFVIAtP5W9qK+kLgR2B1obPCsHZ1WPdyA1HmzRzRmSWh6Uwp+Hl/GvVh2s15FGvzVu2LMsirrjsSzRdOg1SS6irZ9zY8uasc/doHVVBJqsYVxn/JoGkSJWo9msClcArIJA+aFtTIOs84gvL17tCTDw+lUMbTv2t7IRLNlC/hAd1+buPvlSLUCp6Ztba4NXYnXvEx//UU6a8PUdP1B5ZUg1J2Q1SohA3eBaILOyCyR5G35Nci1Aj+4Y75gbxuEZRKQeXTT7XvEsVejCrALfIRRp+CvMmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L615wXFWFEXq+aTMVdPVvJFYrakDsws4+w60yCBeX84=;
 b=gT0w7EEBdPdwmYYWg4sqmQa3aW/ZQ01BSWLN7E4JW/0Sn5nX/K+fCot3SLarxsgnAMYFxmKnJUEnT+CJJeFXho3PIr/HomT4p57a6UaHZf8NG64eSxHXgmmpQXgIZnvuPWFFJeFTML/IuWDSsn75WitjR7RM+et8LTQdcsPPQ1uaQjYi5zIXWPyRArEEB/gR8CKNawxeWcBOKaLpmtKaguD3+Z8yDNlWArWQMkMfZ+QmKgESOfcfWwT8DogEUB38pV3J6R7J1YLijPd5w2jmhv1U+M8dsqNZzns95ICYv2vI9FMcEZHH65aTtcXiloJ228QcIBxBukjbcxF33oS15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L615wXFWFEXq+aTMVdPVvJFYrakDsws4+w60yCBeX84=;
 b=LjdvFN64cVgNXm7sG2HuUWYFmqUYyyQkxdsR0LLGKjkzxZ8iaQj/JNj7SE4Io7tk0Oggtwpo2uLJIQkfGh5B9hxwnYxPjs3IQZ3nikCHWV8D6rs1CuY3NbSKH+mxtFkPcag8skKed5DVoYmMFYxMJVxRYlPuDaDvtnrSJ54JODU=
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:13:52 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::a5) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:13:48 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 14:13:45 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <adolfotregosa@gmail.com>, <harry.wentland@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v1 3/3] drm/amd/display: Keep FreeSync for HF-VSDB VRR sinks
 in MCCS fallback
Date: Tue, 1 Sep 2026 15:12:51 -0400
Message-ID: <20260901191251.2653684-4-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901191251.2653684-1-jerry.zuo@amd.com>
References: <20260901191251.2653684-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c81518e-610b-4089-e2ed-08df085d270e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: anofQdJFSWLo68lUvD6BnFhLMeNGEG7igTFT5kIUZTl4qjwDEQI2czfnXS2F4GYRUrVE8NkEib/yfLzlttPCCO5vpQxUwVaOYDgU9oWED9eAuqZBOHA1NWNJtIb7cp9y90/j9Tho/NqLxYWKe5mz9qXAZwxW98JpvHlKJ66uAPCx4KwFxcHlpnZ20zUxbeH2cxkBYRjq97yPZaGoGMFdm7T2mGu8ZGpoyXk9W1POgDhexjUlywR4aLkyv+xvBrm0s5yVlKT8NRnfLovoJzPzTPUdwXLx5EP4G39pj5NFL218mDuwB3H0+0tVvQj6eEysVV6neFw5YywNAkfIm1v3WTKsf07UCSj8Vg/Hw56zOGUpDn8hoOilO+jO9AjBYJ0ZOKWhSykpGGxB9zPwS151lMFIRD2bXkS3o49k/nuewSAZTUl8yAWsCv8F+bcEaIug7jZHOnQO3qUZH5CuLfre1PREhyk6r97TFCIPdV1GsSIxEgPw0H/dNSp+d3z+7cbMMhpdQ85KKX+a7zQppJlZ++EreSpa85qgZ5UR5O1G6Kblddk8c9+3FQcMKkreiMujjGHemkSo/Ik4cUeM0qvMgn7yH/MJG5vqzy4C5sRqZPw/K3NPa+D9Fsi2EtFNbrMWxcwm5H1jfPucOhZ5IgOs8bqAsI4xLBI/h3MYsyWO+XFkfDRvKIw5f30OQ1OldMcMaJxOGcUqSHf59yGlqvPANw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KevzSC4bqyFt3EAaAgI/XdkZg8bZfe3D0TAtDL8sFGmZZk7GqsSjDnw0+3EceSV4NCTsIrKPnGfFVzmPhg54vtp2YC/mvtlusVMipYh/BTTh2AJfszRwC4JURODHFypyw+qAj/UZhslMj/Y9A7NK1oUcN2e808TAcr7/7wjRNKjsZiswxJVqDnVERVvdqR8GBOzmbP5UnX+XcpoHK60Rng1e5twfEH6GPe9ap4tQMyhc/CyO5P+yMNcO+qlDNvBh3QVMRD84yzGSEylLdowDjTrfEirQ5oqGaCsKSUslFVPnx4tXUNTCOJExXfUtl2WyaAXPLj4ClFvYth85ewOnlsmay8heMW//CVDtL48ESO2/oNG4Ov93yxXdIojhCWHh12rCxGyeQ7yEe2kynB6ibUAfVdZOqVZHBE0GWTY8Qghxs4r0b61E8O6A7L1sZBS4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:13:48.9390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c81518e-610b-4089-e2ed-08df085d270e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

amdgpu_dm_update_freesync_caps() clears freesync_capable for any
SIGNAL_TYPE_HDMI_TYPE_A sink that lacks an AMD FreeSync MCCS VCP code.
HDMI-Forum VRR (HF-VSDB) sinks advertise VRR without such a VCP code, so
the HF-VSDB fallback that set freesync_capable was immediately undone,
leaving VRR and passive VRR disabled on those sinks.

Skip the MCCS clear when the sink reports HF-VSDB VRR capability, so
freesync_capable survives for HDMI-Forum VRR sinks.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 8b2eec1a683d..e4b53086f312 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3973,6 +3973,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
 		as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
+		!connector->display_info.hdmi.vrr_cap.supported &&
 		(!sink->edid_caps.freesync_vcp_code ||
 		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
 		freesync_capable = false;
-- 
2.53.0

