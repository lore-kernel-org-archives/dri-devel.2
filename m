Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95162CD5BA6
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 02:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059E910EEBB;
	Wed, 20 May 2026 02:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oNv/5z/a";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DD310EEC4;
 Wed, 20 May 2026 02:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWKC662uHooFr8UU1a6f6ValqsI8y9DBDlZIQGJAQRPAZnO8/s2jCjgHBMZyp4fr2Iads8krlr/qc0odfr3LgRGotFjf9nkS77Ek7q2gySnq362FjsaKLsYiJdcFrFPc3dgMdaHbqvQi0fr+Iq7MD7nEonI7GEi1IJjybOCER/NQJC3f1ePpVA45CCC7wQ6XPd4V+rVkP9+PfjCS7iHvDmqBZywEiYqITazJzzDBaypbT5cyLWS+WY69L1032vav8pJxiXpCPNLNLpyXxFDpyIsXDMbiWm5viFT1xhTmplV4atAqIcxrMewQNFEs8Y5biMZGdX5ZqYIHwAiNOrjASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIz/bXTlTPvuGXKeM3Aqhpg0dvDDQVGLg5ZI+AWyGhc=;
 b=oAtQmep+rAQXUzIuYaeK6iPyz0WnsVFRqlJ04ajN0NRNQmcSmjsP2sF0hyOY7RG5fVq+OAMBcKo2MhF+JkhlYuPDh/Qv4N+DPORv+zN9sHzKiIL7MVE1cqK0sKeNMLFe7MhLLur3jQZGmL2a4GRlcyynzXS0W5X087WHyMeqqmOngbM3yaTkxtPZ7PyJr0OTE1hghn4CXILfoqniBPGBcjB8DgKtj7iiGzmq5frDzwHlNQ1Kyw9UyGWhINutN2/nAxXsNkxs0FcxTn55ifLy45wUG6ilririJ2f8bCQB5S18/4B6f6yKiZLUmMsm05Lo6H8uV3ntKhXnPJ7PSjCQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIz/bXTlTPvuGXKeM3Aqhpg0dvDDQVGLg5ZI+AWyGhc=;
 b=oNv/5z/assSXQROwLE9OD9bB7AawkMvpsSbwCxK+7O0QypTRXvxjAd631q8B8qQUpPkMhUKf4ikmuXYq6iqfo0mWEIrOOy57oFLdyDdj0emnCV15o2ov31v1zpebkKwm76+aFmMkQOOdI1fYwjSkegiOLFQCmi3+Xmt2Tmg48jg=
Received: from DS7P220CA0054.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::28) by
 DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Wed, 20 May 2026 02:14:46 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::74) by DS7P220CA0054.outlook.office365.com
 (2603:10b6:8:224::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 02:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 02:14:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 21:14:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 21:14:45 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 21:14:42 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v2 3/3] drm/amd/display: use DisplayID panel type in
 dm_set_panel_type
Date: Wed, 20 May 2026 10:13:53 +0800
Message-ID: <20260520021432.1301326-4-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520021432.1301326-1-chen-yu.chen@amd.com>
References: <20260520021432.1301326-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 491e17a5-13e0-46a1-2602-08deb6159045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PdzSV9xJfuNclfIzE/UzKtj/BJyNZsaFTgYcMYByyBdhENqb1aqMyMRGPS7E5PxFm0hOHq2pnyCVxSluQY0Pclj5cPEPuIFLVb3uR46N0sWYNLHRYY4wfBRnjq+E8GFoHiIieO0CodhcNeQ9KUq23gKIgEgwSEyhw9NW9g37CKulD+H4sqCn9D6Knkdi4BLgTb52IZE3BKfZV0mG2WSJ2LjlW/EV3YiXclgnLR/jo+6Wp0JX13iN/bGfWCJOmwSJPugka35QGlyQ+0sLVASQQprddVy3GJ56pQRW8Nw3Utj0XIFwnK2IXfgxB9qs9tlhXr/F1uSxqMN+JAqKzJn8fSFVEA4N8sbIex+Nmdr/cYMIYVvcYsza5417cv+IjNOVSUszc+omwF8sj+2FoALn7UEj99P3uPhHLHpOe6AssfThMYqib4P83VGbvEmiK2Gb7HekXe4X9klbdHKVURzkR5bPa0WimEJsMz8fffz/a4OeotHW6tY0ock9B3SDkWbj29IJM5WcncrcziYEoopF0nY3FZEvRZf8u6QTkDROwaX51SfrGqxnWdHVwhtf4GJYK9462mX2X3iKIb3v23lGjw7aftDso8ZOGU/B162re8ObMbSu40aBwfnF7EoqCykrjEyR2atc2qKgxx5p89sBLf1FZ0vv0WXlNpSNYsR4WZuV3vGOvflsDk9I1/IZNb5ttQfQuSsItBrIwmbSasm6OagVMtuDK7SAn+WwuJSWQ3w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m1GnDzAH4VttdrkGJOlVAa/3abk5rMlDh8cLFPIWrp9i+jAX0qTs3OKSUhgRDA5FPYW0rnFp5BDq5wZmbLCZHdVM2zDuKRREjUZeKdYHdx3pumtfvT1wmcK5HiT3sdeE4Vmk2ioJdmeN39MeMQREhyy7/57+H1uglue1opnlCWmGwoeijz3nLBwVPPCK+eF1joX3//7zBw7Nr1RYqge777aT+jL8ralOzD0Y81vrFplaz6CuEBEBmgDHC1wcVMtPVSOkEZVz7CAoK59ps/MruZhr5XHUTiWJUXA7gVVvJfhZm+rNotlA3qii+gvO6FYD3Jj6DurfeKtHzfMgt/fRzIuNr3VLHNzSNrAbp+TgyQ+mLktfxT2BIbllwQ3yMuWcHsbA0ShOJhCvV4tjoHHHBjcCsmcCaHE7zrYnxC/ROe6DKLEcaD5MkGCb3a8sQlo7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:14:46.3517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491e17a5-13e0-46a1-2602-08deb6159045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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

Wire up the newly parsed did_panel_type from drm_display_info into
amdgpu_dm's panel type detection path. When neither the AMD VSDB
nor DPCD determines the panel type, fall back to the DisplayID
Display Device Technology field to set PANEL_TYPE_LCD or
PANEL_TYPE_OLED accordingly.

Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e42a5eecdf46..353a4982333d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3944,11 +3944,13 @@ static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 			link->panel_type = PANEL_TYPE_OLED;
 	}
 
-	/*
-	 * TODO: get panel type from DID2 that has device technology field
-	 * to specify if it's OLED or not. But we need to wait for DID2
-	 * support in DC and EDID parser to be able to use it here.
-	 */
+	/* If VSDB and DPCD didn't determine panel type, check DID */
+	if (link->panel_type == PANEL_TYPE_NONE) {
+		if (display_info->did_panel_type == DRM_MODE_PANEL_TYPE_LCD)
+			link->panel_type = PANEL_TYPE_LCD;
+		else if (display_info->did_panel_type == DRM_MODE_PANEL_TYPE_OLED)
+			link->panel_type = PANEL_TYPE_OLED;
+	}
 
 	if (link->panel_type == PANEL_TYPE_NONE) {
 		struct drm_amd_vsdb_info *vsdb = &display_info->amd_vsdb;
-- 
2.43.0

