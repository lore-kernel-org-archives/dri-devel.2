Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4491EC5AC7A
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D5110E124;
	Thu,  6 Aug 2026 20:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IYjViqI4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F8810E0D8;
 Thu,  6 Aug 2026 20:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1BXClwGCupo2Vh4tLUXaHqSpShspje44NCivjBe7OYgTsL4HRh5bgxjYAtoHIZYz0BMgDlLXjTj4I0ZQjQu593Mq24f0qcPQMPKqteRLuxwvVwD/lrQUoJOQi2oYAA4u4jooF5jZk0xJdELQdmO+N5bb3A/AgKscMRENPZVEBp6fuNI+zFL4d59KiihzOrwoV3Yj/EJPwP2sIZI4X3QhRMVB0XQRdrR1Pz0NQW2X0Ku/L97kcX/yLjQnTqDbS5dDuQ7S+rWzQRShlQ48do0f7gdGDva1SPQfvU3fwsGXD+rTIWzlbwpl3OWUHTeV0SY/xwWVFWLAmNeLqF4kr/qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMzV+z2nV4X5fsESH5KV4CYqBbZxa+EgyQ/UaauF/4M=;
 b=EKXazUGWZqZhMHvKxKzUJNSUaOPK7vB1I7rFcqKR8yLguxbybZG0744ct8dM+LA4dIxV7PBKgz9IJhjysFMPFch5Kuzxk/1IT4dACMBN963+C3+kXxWxEhlfIHV599rY/9fYq8FtcpXG8U9UKPv12jJxwi5/O/GsddRZwwYxPH3SIZ95an8GuKviUwjNCj6HyvZVyZkFYuHEMceXxD1wdTsDCz/fNIXGNDcnhMJgxgldoxTE+i/iLxWueJqMcy5MH8mXsRlHYBYViPAETO3LOcqnBleQ0v6r0ekg3PTrrfo8ACdfNcFqhCFtTrR6SM+nGzEOYt5VOMi0z1uajbLN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMzV+z2nV4X5fsESH5KV4CYqBbZxa+EgyQ/UaauF/4M=;
 b=IYjViqI4d7MKSm2GZguppiRK8x/byP1wAWAgfA8p9LjQXXEVP+rrf7UtECHfmDpkpowMO1eoOADGg+WMqbzt73ppIFjW8PQEF1VnVdesWnnJuZcCPd7n1cqrxEBpuhUFq8MSFJKAabT3C79K7iZ0KtWXDxP+ebXSWj6zQDAwQSM=
Received: from BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::8)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 20:53:55 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::5) by BN9P221CA0017.outlook.office365.com
 (2603:10b6:408:10a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 20:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:53:55 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 15:53:54 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Fangzhi Zuo <jerry.zuo@amd.com>
Subject: [PATCH v2 0/4] HDMI 2.1 VRR and ALLM support
Date: Thu, 6 Aug 2026 16:54:44 -0400
Message-ID: <20260806205449.16806-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730171754.704049-1-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa9b59c-8927-4067-9405-08def3fcd473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gQy0yZ9B3mCCpGf8CqMUrn/F3wxHakGFYVlG1he/5h3SlG+fM3bGGGdQkRBbpsWOiByrMxzbmDOWKoHcXGUEk8UFc+uGBwuJ8ssnt5Pe/dlTuERfRUkQvzaaZapvaVRvOj0dWalLFQmIEEyoXCXBj7RVLh/9D+nmWk1lA3sgWXU7p33JXEGKdkaTmGA81RxBuY/+1TckVWMa9bb/tYz5CBv5GbbiqSPhoU7FNDC1wYzMQrDYRyXk4RR9lkIhwoWhQMq/8bBK59OoHEuw2O4m2oyq4/MCke0tZunI/ekhM2Y/6+VHi0oOi5JKJ+SUrnltiHyF5B9QFOd5SqWbGlELBCV18PYRbbg2Ei8px5/O5UmIuR+8AH6tsGf1cJZewMN4xwVaWXnWz/qbhGsNujLj6lFdkvrjmftJ6uMVfYbXLXmcrQfyvAlXRJBNgiwbHuz9KDz+ukbwTB6D5klOLq/LkU9mvysoz0EeCT2z7NqMqV8Hj6gETGl/L0xHoe5WipumGXycyiQDgb5RoqjorOI99RRxPJwFHunGxUquwBI6OGA5msxoJ2MLDhw7F5r7cO2E4LctrRKB4cNisIpfEWdErxxxn4DFGaiVS5/2+4/6UwOBsKxCjLOxjwx4/ENA9kQKwheJ5hzMO7A3tJA04XZ93j4lZmQSpMZA46Vjz/ujKmXiixA4Edkkv4wBE2TNCR8LPqeaeMAK/rX8kgnXHJlMow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1kLstpd65VVExmhkz2qPvAOVPuNah7Btu4w+olBztZPqGMHG+bvGCWBvMF3FBFO+OxssRHma6jxSfaqUBufivUKL+SEY50f50pQspR64Da4YCsRcSe6SlbHB/qSZ6J928KaTUez8Z+Cr6UpX4lG0ZwQKaoqph8qsp4C0NVMcqIDpMsv/fivx0TvfUEwpi5B7h/jg9nu4cpPB0iTErOQF0a8QxfN1nQC53p1CSqmxgJw69ZnQdvfSIv9ev1oWfRIRq7OpuI9/8QGf4p9iCtZ2JoUpMWJzBgQFyAJm/AWbZ1JWrJ8023ORiwh1L5seCUqwXPHMxS1xsglJywKfVszHmAGIFp6XJXMMbT2pCWp7bK0zofg7vfn2IKoiGyDy+RVm/74GiwDtIUY4DWHz5Ve+D/RE+71m24OnkHY9+Ys+eWOb4Fcj+0AB0QTPg9pLpiLR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:53:55.4402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa9b59c-8927-4067-9405-08def3fcd473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
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

This series adds HDMI 2.1 gaming support to amdgpu: Variable Refresh Rate
(VRR) derived from the HDMI Forum VSDB (HF-VSDB), and Auto Low-Latency
Mode (ALLM). It builds on a drm/edid patch that parses the HF-VSDB gaming
capabilities into struct drm_hdmi_info.

  - Patch 1 reports FreeSync from the AMD VSDB (existing mechanism).
  - Patch 2 (drm/edid) parses the HF-VSDB VRR range and ALLM bit.
  - Patch 3 enables VRR from the HF-VSDB when the AMD VSDB has no range.
  - Patch 4 signals ALLM_Mode in the HF-VSIF for Game content / active VRR.

v1: https://lore.kernel.org/amd-gfx/20260730171754.704049-1-jerry.zuo@amd.com/

Changes in v2:
  - Read HF-VSDB caps directly from connector->display_info.hdmi.vrr_cap
    and .allm instead of mirroring redundant fva/hdmi_vrr/allm flags into
    struct dc_edid_caps.
  - VRRMAX=0 now falls back to the Base Refresh Rate (highest refresh-rate
    mode of the preferred timing) instead of a hardcoded 240 Hz.
  - Rebased onto amd-staging-drm-next; the FreeSync code now lives in
    amdgpu_dm_freesync.c.
  - Reordered Signed-off-by on the drm/edid patch (author first).
  - Reworded commit messages.

Fangzhi Zuo (3):
  drm/amd/display: Add 2.1 FreeSync support for AMD VSDB EDID Block
  drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
  drm/amd/display: Add HDMI ALLM support

Tomasz Pakuła (1):
  drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  89 +++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  43 +++++++
 .../amd/display/modules/inc/mod_info_packet.h |   4 +
 .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
 drivers/gpu/drm/drm_edid.c                    |  42 +++++++
 include/drm/drm_connector.h                   |  47 ++++++++
 7 files changed, 335 insertions(+), 4 deletions(-)


base-commit: c4f76bf5e107bcda6e496f1c4060c55af091fa79
-- 
2.53.0

