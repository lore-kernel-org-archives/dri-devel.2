Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF9606A334
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T5yn8F/n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502B910E287;
	Thu, 19 Nov 2026 03:27:18 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F84B10E287;
 Thu, 19 Nov 2026 03:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI+32xSBJbJks+/s5ddOcQ5ECDvRY/gNd7djW/LtuO2g7it9edE9pEiW0sW1kfQ9LpxVX6VJiF1R622nTWWGwYcJ/PtDjqUY1YKzb4ewNTJWGPFtejoGAh4hQXn2y0r2Dq1CH2WFEDCOzmoQgC6/4GRFfZee/lcQdgaN/uVfi1Sc6JrUNfBYlKhAR/4k/nC9RE//xL/cAKDv+xk3oN2I5QINORpO5ePQq6S77TJrVCovGQoY/NxQBbBJWbNzOhm9Q6/WPFJQpLd3yelDrWpJaQ4OEaog4qy37v6cIQ/zuLSRs3RERwo5FeQ/38dP8WLyi3iiM0Jo89+w/lx+BreHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVUjtOkeUvityBPp6U6aSLNSUXzbSvdtQyUoNWpU0Ig=;
 b=xork/wHLCZ2T4tvQA93cUrHitVa5BKAceEwBzIH9RhDkNn5phMpRRq6Ullc1LU6bDHd+n0kcAiX76nW1PrTPF4N3xw5vK/Qd7NHfNEk1WP3r7/NhlxSW7T7hWhbPF/MtBjPaXcG2MOynnwBplub3m8rvZFD82kWs/Aim0SRNJAB0zwPDwVmuWXQ35c33Q5OcbydEqpnNU8wmbhXJSOhrpHd+XfXkjxO9JVi7Pl6RmikZYlhL68m92VXW7ZSpbBeJx5hzZNOt4JOQmV7cYH+SgIr3Dr1cnMYMO7PsqxepHN6Tud9aoHg8T9w5Jp3meFD/6JXTNgdINCqdlIJ3gYcCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVUjtOkeUvityBPp6U6aSLNSUXzbSvdtQyUoNWpU0Ig=;
 b=T5yn8F/nRoPdadCEm+/9hZts9r4VmuN7GHdpcIzVSGHstLN86jCUze/J89bwYHfpfQbKRXkJF1FkCYnrb3h6ObjN35FunMJdc9OusoKWIypeOnDp/L2JSlG9gIjoupmaQXoCpj+RtVhe90QU2WcSklOp42c4SSHAb7vbHcXYxZI=
Received: from PH8P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::8)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 03:27:06 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::99) by PH8P220CA0027.outlook.office365.com
 (2603:10b6:510:348::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 03:27:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 19 Nov 2026 03:27:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 21:27:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 21:27:04 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 21:27:01 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Cooper Morgan <ext-github@cwooper.dev>, =?UTF-8?q?Eren=20=C3=96zen?=
 <erenozen@protonmail.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, oystersuki <oss@oysterdaisuki.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Store the AMD VSDB version for DP sinks
 without Replay
Date: Thu, 19 Nov 2026 11:27:58 +0800
Message-ID: <20261119032758.3857304-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf9a3b3-8e25-413c-3d21-08df45ecfc45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009223027099003|13003099007|11063799006|56012099006|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: ijiaBeRvl9DXjqJQY6KCJctPvDVugWYJl3QWpeBNA2nmFZKQliiDLg3m479FZjsgzPrVUq1T+5F6zUdzN/4c8rwVHT2l5Po8cQ1yZXXd/LdrndINzSuThEdZ91RFRoqExIxETbHUQ6fRDW1WYvOhspj1BoRrCE7zKtEey49NOYKalMIYSJTaPH0M6UnB5nyFoNXtBoaVnEPDiZb2uFKg0tARV4kN1oF6PYaVSJx3/14Oa68/orSw2hQYX/NDLYJR0kAL/ncE8ymXpMwWhwjznrrjL6o5H2WW6w6QzT8/L2p+Cs32q+VihE4oy6c/kCCsM+vpiODNMPmOYR6K7BIkgohbPGCISsvKqzOdLZJNerXkcEwfwmL/IngdnnFhlXDuG4vxDXBcMpu+ZjZrn2Ddeqr4+Xq/WsI26nBQqXTpiqkq9fs7Mso6K4kssK558OahIYuHOKRQXmXHHBo++wgCAzWlYa2hFDAz2aIgdOG/zB9wTO1BojOUPbpTxgExe8aWK4jMwK81PZv5OAm8ue60ESpO5LXWn0j2V8xyB99fIPDn548FdTAicDQQ1FzkWn+CadObOTgyuvm528KoG+Ll70/gYdAZmwCR6zjYPK60yqP863svtfJXBT6Nargi9i7B5BSAKrHi2RDkw6drjzpGy0UEU3+LUPaTYYnXjPFDOz8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: btc4kfMFUQFDSR/R+stuVya0SRQtDWTBgSn+GrF7OjHFNrjT2VQk+WHPY/654446IyQD/Bbs3QuGYX5h6nQ1s32zzJwS4aSawRUB8yPkXBazLHReHrCtShhfGZ43j0wZYjU5thhQkOW3vvuyAJ9NbSOWc54XVyv6R9h0gnI6p29Af4rb+8W3sfH2Cswxxi7I+RA6l/VEi5aISzKozpGCGwRK7suXFr4i+KTy/h0P7dhVoEHac1TRNBQwywRe8zo6E00O+KNn3d5z78+2HRAKPlUu+y+HCuJ83ag/5T1ioswd40Qrs6+NbEhg/JnX+69Mzn3OZ4UsNf0pYGCfDCMtcB2w0hk4jOYrQH+8FhFyULm6hPBTgftWgoo1lrtNxZhNg1Gmys9PYiFY4+71L7zpAUCwhhvjDSCfK/PmxzWfTNWxZauxd90sx6TEo3zUWRTZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:27:05.5618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf9a3b3-8e25-413c-3d21-08df45ecfc45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

Store amd_vsdb_version for every DP and eDP sink after get_amd_vsdb(),
not only when Replay is advertised. Without this, a native DP sink
above 255 Hz with AMD VSDB v3 and no Replay keeps version 0.
amdgpu_dm_update_freesync_state_on_stream() then sends the v1
infopacket and truncates the rate to eight bits. A later EDID without
the VSDB still writes 0. Replay still sets replay_mode and the eDP
adaptive-sync type.

Cooper Morgan's patch already contained this hunk in
amdgpu_dm_connector.c. The hunk was left out when the patch was
applied. This follow-up puts that hunk back.

Fixes: ae60ec4dcfc4 ("drm/amd/display: Use FreeSync v3 infopacket for sinks above 255 Hz")
Reported-by: Eren Özen <erenozen@protonmail.com>
Link: https://lore.kernel.org/amd-gfx/20261113010529.11514-3-ext-github@cwooper.dev/
Cc: Cooper Morgan <ext-github@cwooper.dev>
Cc: Eren Özen <erenozen@protonmail.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 1bc8547d5777..41fc641b1b60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3928,10 +3928,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 
 		get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+		amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
 
 		if (vsdb_info.replay_mode) {
 			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
-			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
-- 
2.43.0

