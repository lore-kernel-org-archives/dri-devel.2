Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D090C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAFF10E283;
	Thu,  6 Aug 2026 20:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XjXytPr";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E35A10E24D;
 Thu,  6 Aug 2026 20:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnUipzvg2XXUumFGBqQSZxcWMG42LZ+VGTb/WPS6A6m4PZwcVyajSc0hMK/MWuEYSLQ6Lvyaeunpf2TZ2icoAkasGkvg8JxWV8cvpLCgi5NUJxqxKt7ygjoqBs6UcZwG1MkA1X+ln42EofRf48J4OyKY1DT3aJ7CP8sjioybC7vIxsUDn2uiAOLCydJ2weIlsmIN1jRPC5QmKii6iPtfIzXZ6YfgEDUEBJMk0b2q/aoyWwC3ArXxKjlA8/A02LKmhJphyEEOf/66XWxE2TG/B9rPmZ/a6ZGWAkT66hFwaXg17Ct/MXYgpWzE+PWFbgIprWViaFYjbRlFdrSIoU0VcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFlclDdqBRngTyYajK20gI/vKZFJApspNo974SslIHU=;
 b=Pbmz1KLI2Pj6B3TxPDcyDbxkx7j3ZBi+afhbLF6Y/b2Tg9Y97qAfj8aatYO+g2jQW71fEpGvNG9JfVV6RhIdvNfduR1ACvsgT5Zlbc/Kqsc5sZfM04d8DOoKZ2uIeuD9cBSmUEhc/ZpnqE9t1k0IOsihDDqdrSorpoacIaE1Njtc0eQ4+gL0akMGBPw6SDubwPcvf0xTWIxUQWYxuRdw5zoeXrSG7VuXV6yEkJa8MztgyPHMORBMuuA9FioR2xprB5ksvDnA01UB4NwrVcwF4ZeoS345J5JyIScb4bQhQidFbY5Mx+wLYBAxN+QyWe9uP1Xywkx8WIId+N3MQbeBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFlclDdqBRngTyYajK20gI/vKZFJApspNo974SslIHU=;
 b=2XjXytPrjbrvLsKJILdoEitwnUquuzeFHQvWJHlrS9e6iqv9Fl7belNZ6j2TaA83iydUf4q1MrrlkzhBZxE9yjr3hXRoXyOfIdpwrHVGCQzB1gTU5/RO16GuzwLiXOY6T686tdiYcKj+Kxw62n7Z+dY9pZXpCDQU5x41qyqaGBo=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by DS5PPF18A985A10.namprd12.prod.outlook.com (2603:10b6:f:fc00::645)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 20:54:01 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::1a) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 20:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:54:01 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 15:53:56 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 "Leo Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Alex
 Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
Date: Thu, 6 Aug 2026 16:54:47 -0400
Message-ID: <20260806205449.16806-4-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806205449.16806-1-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260806205449.16806-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS5PPF18A985A10:EE_
X-MS-Office365-Filtering-Correlation-Id: cacc028d-89d5-47c4-7475-08def3fcd81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|4143699003|10067099003|5023799004|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SCGmcVg3cYi0qzvFWTiPj92/n97d5HR9EhrEpMWsNPKVyqvSJ7Pa99mRhXCd86yUXamiZ0h7u6tbGmOSPqmVzQwhxnj0Waw2ClpdQVlx6GwvdC8W8A1wboQnqzbDCFscMpiLNkfZCCLscE1F9lB+QgEZcRQ+TAoL/7EMKyJaavG7Hm4Q83HTUegxI/uLUnzCOJ6AYKyFJ9+GeZxw1LSVYfxglihHjZXR0URko4c1ExJ2LxYMedszK0VotdXSnJ5Eg9fAScGNrFMrFr0xT+pAMIDHqY5pvPluE052ButZnc7px8MydWyl9Etb8DuOoukgV7dCuIbfiwQ7kInHgkAD/ZIy0lH9y9BBdt45bDnMJU8iJO5WX464NhSmErWTm55Z0CSj4Ezmf7ckhgsL9YxQy+uTtUFGUYgTl4dhktMl03AXTsLExJsN0g+ACaLlA3jUE8FcU9IyI2QzJViJC5PZgxn2xUyNRBYkdGKcAqw0YC53JxzryqeJovFQKAbVCQmc70OICFgkaNLhjUQ9dN4bW++FJUNDlsaAxc9ULffN1pVCyD6oLwDRo+N+NBJTHUoOFJ1DeGIil5aO4ojiV0TejPlKEjXsPydZwQO23b0fwv2KjzVluS7GLy/1A1rPtcpJaoYyObrDOPnTXGvtEtHoI1lxugF31OtoZACR4kwmS1u+YJNtwue+d8/Y4Yr3eFKcIEd4UtOah7ZLRgnfDa7Azg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yhAfJEblEPuTHAsYEkk9yQIxWT2kNIA5lp4zK++abr5MspneK4a4mS/+KbkRn62xosquugcRt/UGWCT4cj++OwblHDd8x9F33tfjmu8zRRZQ5M1qYudnlsSp3Ly1ol7GS0eqEqWKQs5u9SB4jLwhQ53XcXwoRCI9B2HXUuQ8NPmat+wfCSJqPesCuBAuaRr+sTlSLazf3AcQTgchiyRvucCv8avyr2nJ9tGxyP8BKthk66yLQjuaxffxyU0KUAHHO5uX6paNWFdI3cTWANRoiS9pJQZ0lncPb6WaCs39tZt8L/J+990AJcOz1TSazEmLh9evlEekQmfJSbAidHYPC7b7Fl6g++3xCUS8rdVYAOZ/mBSbQglJdyomjung3Mp2juTotxAd9b5Eplyhnw08E4EXrwbTIVWhsQgeCLEhDZWUteDdyahhhO/9u4Et2qmF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:54:01.6017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc028d-89d5-47c4-7475-08def3fcd81f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF18A985A10
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

why:
HDMI 2.1 sinks advertise their VRR range in the HDMI Forum VSDB
(HF-VSDB), but amdgpu derived FreeSync capability only from the AMD
VSDB. Sinks that expose just the HDMI Forum VRR capability (e.g. HDMI
compliance EDIDs) were therefore reported as not VRR capable.

how:
- In amdgpu_dm_update_freesync_caps(), when the AMD VSDB does not
  provide a valid FreeSync range, fall back to the HDMI 2.1 VRR range
  parsed by DRM core from the HF-VSDB
  (connector->display_info.hdmi.vrr_cap). VRRMAX = 0 means "up to the
  Base Refresh Rate"; when the EDID provides no monitor range maximum
  either, fall back to the Base Refresh Rate (the highest refresh-rate
  mode of the preferred timing) so a valid VRR range is still reported
  to userspace.
- Add VRR debug logging along the FreeSync capability and config paths.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 67 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  8 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 5e7ab9158995..df39bc70ec6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3812,6 +3812,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
+	drm_dbg_driver(adev_to_drm(adev),
+		       "VRR: enter signal=%d hdmi_vrr=%d mrange[%d-%d] hdmi.vrr_cap[sup=%d min=%d max=%d]\n",
+		       sink->sink_signal, connector->display_info.hdmi.vrr_cap.supported,
+		       connector->display_info.monitor_range.min_vfreq,
+		       connector->display_info.monitor_range.max_vfreq,
+		       connector->display_info.hdmi.vrr_cap.supported,
+		       connector->display_info.hdmi.vrr_cap.vrr_min,
+		       connector->display_info.hdmi.vrr_cap.vrr_max);
+
 	/* FIXME: Get rid of drm_edid_raw() */
 	edid = drm_edid_raw(drm_edid);
 
@@ -3856,6 +3865,59 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
 			}
 		}
+
+		drm_dbg_driver(adev_to_drm(adev),
+			       "VRR: amd_vsdb i=%d fs_sup=%d min=%d max=%d fs_capable=%d\n",
+			       i, vsdb_info.freesync_supported,
+			       vsdb_info.min_refresh_rate_hz,
+			       vsdb_info.max_refresh_rate_hz, freesync_capable);
+
+		/*
+		 * If AMD VSDB didn't provide a valid FreeSync range, fall back to
+		 * the HDMI 2.1 VRR capability parsed from the HF-VSDB.
+		 */
+		if (!freesync_capable && connector->display_info.hdmi.vrr_cap.supported) {
+			struct drm_hdmi_vrr_cap *vrr_cap =
+				&connector->display_info.hdmi.vrr_cap;
+
+			drm_dbg_driver(adev_to_drm(adev),
+				       "VRR: HF-VSDB fallback: hdmi_vrr=1 vrr_cap[sup=%d min=%d max=%d] mrange_max=%d\n",
+				       vrr_cap->supported, vrr_cap->vrr_min, vrr_cap->vrr_max,
+				       connector->display_info.monitor_range.max_vfreq);
+
+			if (vrr_cap->supported && vrr_cap->vrr_min > 0) {
+				amdgpu_dm_connector->min_vfreq = vrr_cap->vrr_min;
+				amdgpu_dm_connector->max_vfreq = vrr_cap->vrr_max ?
+					vrr_cap->vrr_max :
+					connector->display_info.monitor_range.max_vfreq;
+
+				/*
+				 * VRRMAX = 0 in the HF-VSDB means "up to the Base
+				 * Refresh Rate". If the EDID also did not provide a
+				 * monitor range max, fall back to the Base Refresh
+				 * Rate (the highest refresh rate of the preferred
+				 * timing) so a valid VRR range is still reported to
+				 * userspace.
+				 */
+				if (!amdgpu_dm_connector->max_vfreq) {
+					struct drm_display_mode *brr_mode =
+						amdgpu_dm_get_highest_refresh_rate_mode(amdgpu_dm_connector, true);
+
+					if (brr_mode)
+						amdgpu_dm_connector->max_vfreq =
+							drm_mode_vrefresh(brr_mode);
+				}
+
+				if (amdgpu_dm_connector->max_vfreq -
+				    amdgpu_dm_connector->min_vfreq > 10)
+					freesync_capable = true;
+
+				connector->display_info.monitor_range.min_vfreq =
+					amdgpu_dm_connector->min_vfreq;
+				connector->display_info.monitor_range.max_vfreq =
+					amdgpu_dm_connector->max_vfreq;
+			}
+		}
 	}
 
 	if (amdgpu_dm_connector->dc_link)
@@ -3899,6 +3961,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (dm_con_state)
 		dm_con_state->freesync_capable = freesync_capable;
 
+	drm_dbg_driver(adev_to_drm(adev),
+		       "VRR: caps result: freesync_capable=%d min_vfreq=%d max_vfreq=%d\n",
+		       freesync_capable, amdgpu_dm_connector->min_vfreq,
+		       amdgpu_dm_connector->max_vfreq);
+
 	if (connector->state && amdgpu_dm_connector->dc_link && !freesync_capable &&
 	    amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported) {
 		amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported = false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 1fa078cdba52..cb49184813de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -152,6 +152,14 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 	}
 out:
 	new_crtc_state->freesync_config = config;
+
+	drm_dbg_driver(new_con_state->base.connector->dev,
+		       "VRR: cfg vrr_enabled=%d vrr_supported=%d fs_capable=%d vrefresh=%d min=%d max=%d state=%d\n",
+		       new_crtc_state->base.vrr_enabled,
+		       new_crtc_state->vrr_supported,
+		       new_con_state->freesync_capable, vrefresh,
+		       aconnector->min_vfreq, aconnector->max_vfreq,
+		       config.state);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_get_freesync_config_for_crtc);
 
-- 
2.53.0

