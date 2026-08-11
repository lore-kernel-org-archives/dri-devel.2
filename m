Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAB9C5AD7B
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 00:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0797910EA1B;
	Tue, 11 Aug 2026 00:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WSlpFKJE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBAB10E267;
 Tue, 11 Aug 2026 00:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3nSDfnXiPJZdy/saYFBFDl9F/G1DHD01I/Qdg9GXo70qvNLyc2pA3ca5erZnmrTW7ox1qCIuyoXTJWdSbaWK4PTlf2DyjZsMk4nYrHDgPF+CkD4OKLSpNZwjMjxjJ9LhCb5i1mNyYjUqE2DBTTTIbNb6INA32L2cTEBvAQ7sAhIqn8fG07CYk1//XZoWNq/3vDSzRdeENINORojZl0l3bY05JGArkubkt7gKbiiBnImjxQzjNhcBUJ2eTfIF7HFhGSrVriH3/L/gJtUyvhCxjnxbF7ePh8rt+Jltp6AhX2Ed/jK7vkqGm0/LcXmts936Rb6IFo82hf5GVqI7X1uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqu0YDvpg+UJQ5gI74MQG+zlDjG+gRFq1nGjCdSDOhA=;
 b=HV8uzaRV2OsIUprAAEiUVqwzpyCuYwagwgyzn0U0IddNEmO67GNDPbAYzqVqa0biz1I3vYRWHTp0J8tR1KklVDUeYefU0j9xZC37n0sxyLIYaShdmC+cAMm3V0N+Z6lXhj9W4CawGSzNa9pvlJpBIEOpLGrj1eVHhDOHxfdIRpmJPDnTAQxervQqh2GFIE4YrX8xSh+pulgYJBpA5ld64LDghg45WkWQG4GjcE8VS7C8viEAKH/t+g6eVVcxI5AaMXSDYMUMZgmKrHx9Qd2X75EgLzl/Wq2WBbHP7idYEZ0Kv4mOG3iHaYfRqNdzo793obmG+BIwrG77Y/Yqsf0vbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqu0YDvpg+UJQ5gI74MQG+zlDjG+gRFq1nGjCdSDOhA=;
 b=WSlpFKJErjZMg7c4as+CPd7yyq+BxhgDuywk5JFeXyyO0eo8U7zVLMC9XwoBej6wNJ/PwUeUrPrPDqWXntnJHVKoAqexeuc6BsEmpMssq5xT9g9StnVZzo/GV1t/ks3RuBqZogvAYNflz4VTDxn9BCP6D1LJn7YggN0EtOE3Zxw=
Received: from MW4PR04CA0382.namprd04.prod.outlook.com (2603:10b6:303:81::27)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 00:38:43 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::54) by MW4PR04CA0382.outlook.office365.com
 (2603:10b6:303:81::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 00:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 00:38:42 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 19:38:42 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Fangzhi Zuo" <Jerry.Zuo@amd.com>
Subject: [PATCH v3 3/4] drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
Date: Mon, 10 Aug 2026 20:39:20 -0400
Message-ID: <20260811003921.1398292-4-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811003921.1398292-1-jerry.zuo@amd.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6487ad-e192-4e93-b2ce-08def740e54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|11063799006|5023799004|6133799003|10067099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: HrjqrE3lgVQZImtQiL2lIGy8Wp9YLJXakLbIDFVi6IHfDE/k885rV7EL4kPLWIriEY/Sxnyr+9Bhv12nQFNj1d2HKUUsacEKhoU+jUVjl12pU3bIXrKgIKRBnLOF09hHXcKVZUUAF0bKyAgX1RtUZ0UNfA+P8IjdplqEV/vcwssr91S7GjW7Y+/E3xgSWjqZnAghVO8PCBEtMop4qnONXjQrjA5ZocdtI3H1PTS34sCjhYnr9xkpTe1C+/aIWDu0SLRwGtcGJXoU3F5nHmZNps4OQgFZSYCNuivpvQ79Zxrx634GzwQwbL2LgApjCEjJAqnA3eCOUH0X8hpR0Y1Yf1B4eLDgb6fuc3kRz+HsyfRPJC55H75rJUqP3OX5c3jTldhIn618z/rb1JyVox648541fWDxrKucpmjWQ0QXJjpADcx97ofr3AuCGe4WpQTm7IucVcua3K6KgukwzSBcUu4qfkbujCGMPVf0B/1SNm6CYvGrddUY6O6pKOQPf+XHFYOAzsISdX9cwKg7qXAX/rxNvbbNMcLZ5r+yNI4kowNscFGG/aMZ2EXU8yFY5lIBIc5jlwjMdJrwDDMjwjO/dcFrMbFZ+ACqXTOps66Q/IF8w9uUsMIBdIYxGH9LNaagghNsv6d+8cLY7x7MTtGfzEqdGvTMaWTIJ0R4wQadFPyohHF6ndCPXwmeHUpnRHaN6Zzw8D1GJ1f1dhJaSHQtuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(5023799004)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K7AOtxylV3DWbmQ4lmYmXrzPFO1Ck16+WoGEpLpdwvCj8EzLAc0TYEVcBfpAV5z+lpc63k4wnpvfH16qZ2JBKbv29bn9ZLfHCUFOYd+i+Ew+ezGQ8LMj3bbrQV6+RONpcMhLkdYVxDBURHVo+ZoIfSxwUvU86FpVyi0pTS7FUQhRhk/PMYjGTwabM5w1tBO7KW130uI2y8TdBqcBgYcoaMfDR78KXZE2IwX3/D+qG+5daDb/uf1sl9EnCicgMjHayxuTve49Pv2EwMMKE59h38RlacDCOJJfcRiCHK8PYSgnjD41t3uXiy3fhM5xxGL8A8xffFh3Zdxp7c+nxv0jNWOq/nFtEoRU3y7BNTCOeBbtRaTuAQ/q3jUhaK77mQqVovXAa8kCZUxZt6ioehMANV9ZU7EChldWSZAti+FAMonNFAOE/7JCVFJRwAFXKOEA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 00:38:42.9271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6487ad-e192-4e93-b2ce-08def740e54b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 67 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  8 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 9eaa20ec528e..2fe7bfb1e88f 100644
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
@@ -3911,6 +3973,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
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
index 035d7e88c3ed..382c339b67b1 100644
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

