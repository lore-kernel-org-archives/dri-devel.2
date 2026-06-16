Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC80BCD8CA8
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B89210E230;
	Tue, 16 Jun 2026 06:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iYNJBmzY";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358B910E230
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 06:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2HlZYQWOECw/Lf2biXpomV8WeO/guv9W45SlfDK4JcLUyO72rrggXzOn/4vKTAKeoY4pDp77yb3IsYTjS6lMQZcMbpeMIlzcgIINPZVPaCwBkA5uYwH7Eu39cVQCGo3Izx46XjkbkJuqPaJK3N8aER4nBSpx+1rS/6vVd5+7QG5bmlWeWuipovexl+dPrl5DlXl7gb5SM3DzkMFAGBjjow0P/VdcufLb8YEiolVJ3zL5y4RLsNkrCTGL6tdMzkdT8/NI7YnvVKWVTlNVRjvviGgLkQ8PNN9ERq9wRl34pmahWxH992IjKYw6l1vX3mSF1dez19XEoYcQMaX0fYXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReYgv1Dd5o0nl75nAVmEbikvZAh46//5RA7QmMJOLu4=;
 b=ftIcChptyrXro2JZE0fHXxkr+mxTUmj0lE0smoN3Ru4DV5cwdPJFYVSUVCsZjE2C9JJL5v3bwIhgNZhFh0wpNV2j/BNyfPzgtMU5vrG4hhUq3JA3RU5qXhiTnMeqo7P98+dUYmo5voS/aKq0/FxcoJKUGGTtBKnsQdrZwmqfsG0sv1d4LwlX9LVpwu92gvUEaa9qkifUGvXIIFcnBFqDlOjfCLya7gPnn73FS1ltGcySUZjIb3H37fFLmtwmohDXQ5vKEd+NtIooFh3S14I78w8a5R/DkG/y/BJ3m2E9LWxEZH/TJSgNMLQGsb2oSR48ML+hL2s1sGva5o6isNdHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReYgv1Dd5o0nl75nAVmEbikvZAh46//5RA7QmMJOLu4=;
 b=iYNJBmzYGG2N04ymm8tabB6SHQmMjwQVwSzsGgvqrS4zFQTefZGignSGSjtEeZoWSM3+dxUbcORdbmb1hT8yj4drHlnAQB8dPCLL7HV/GTMAejGHe9GuG6O/WU3wcOhYVDAQkIL2BQBcySsKd+a5UvtxfCREd0vCgwjhTMsN21M=
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:20:29 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::27) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 06:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 06:20:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 01:20:16 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 01:20:15 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <shuvampandey1@gmail.com>, <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Prevent PM resume deadlock in
 hwctx_sync_debug_bo()
Date: Mon, 15 Jun 2026 23:20:08 -0700
Message-ID: <20260616062008.3533989-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee5ec8f-8cc8-42d7-8fbd-08decb6f5c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|6133799003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: n52SIUS1kldsXj1wYqff61Xw0kmoHM7taGKT9XIE7+GpEIbR1FywlHOOp0fWOQVpZ7K6WZzMYvcehwVV6CP/4SHdf22tdiMwO4kXzW17qdi8WpsoA5qX39D28j1IEneHS/w85EU7LGqC+IZ4clKtj/EZuxcM9pDrfJRCRkX4NyQRDRSEO8xCigP3oWrThgqlB4cEbjSra9keGpkrP6KyJR/ecmoIqThbtld+Xt0oSr5+VCCcYgQI0+NtZGLMRaioVRnFjxduetSHSfQZXbBMpWxIsACY4Ebhwhx7u4WSyeYhFXYxtGyP6nz2hVYyFI/qyB9P82jwio8Rcfr3ydFVSLF0nFhfRaXPXADGWzN6SBz+Xts9QbbWfbqjoVfxhgtZBYFIGlNEFz/Im/ik+9v7/96rLz07iIZj0k8BmfB+dmxCzMpsvbnDbABid0qIX9FpWr6Yn+7pI6UeCy01bcUa7PtxCM/wx6T7eS2RWJhyuxakhB9Ck9E37lxi7Yoz74bb2uIDWIzfYNX1uQZ4v/mspWIHqDUUVmQJkO2LBhYQLL2cyOjCKEhveIgI9tsGPjuFV/eEGMUJIE46clLukR4nRn4GooI0a+PcazHJmbpPTZ8tqAtkpYl1TvnPF6+TEiTjQdTnHset6Irz8apcJBzk97cqLa/TMEJktiImB2OK05GiGPCWBNUcZ4ykJbX/08u3cuQMClashOJjjAhFC1krM3DnA47ElN4IaRUzJIng3zA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(6133799003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: be6riaLnrVDtxkYFmCc4KOIXymerKUgcd1O8QwzO1O/vFE5ATxZMQJOBZ3HhaV7OjvCTyC55wVy3HaHErf1wD8HJkwjbx3I/2M6cv2Lamn6JLXTGGnpTRMuKFC6mHCCz7OhFnpzlI64nWIBHKsrc67N40Z2drlI8L2EC2rSWPb53G88A0ninae9LpvZGQS3jcZ4LC4xxn41Ozc4nOCTkVwzP+ayoEkWtQR6qTO+2TDWIAIt8yZarQWAz7THSDkYUAYYfy5QbG3EncRY4A3gZrfUkjp47BCxU+c88t3RJS5hHYH8NMOE1WqGJJuMlynPKVnUlsxIiT4RcKq9b5KL4iPmDep54xp7yZWiO7JWas7l2nU5SKYyF/xY564xud7x8Vvpu0TzBlXyywJogTfOEB3stYDq62E/6YN3gsa0qn8pAAMJhIc6YV/608oT/v4Rp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:20:28.8311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee5ec8f-8cc8-42d7-8fbd-08decb6f5c9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
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

amdxdna_hwctx_sync_debug_bo() invokes the hardware
hwctx_sync_debug_bo() callback while holding xdna->dev_lock.

The callback may call amdxdna_cmd_submit(), which in turn calls
amdxdna_pm_resume_get(). If the device is suspended,
amdxdna_pm_resume_get() may synchronously execute
amdxdna_pm_resume(), which also acquires xdna->dev_lock, resulting
in a deadlock.

Avoid the deadlock by calling amdxdna_pm_resume_get() before holding
xdna->dev_lock.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index ff6c3e8e5a15..539daca1b42c 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -386,16 +386,25 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
 	if (!gobj)
 		return -EINVAL;
 
+	ret = amdxdna_pm_resume_get(xdna);
+	if (ret) {
+		XDNA_ERR(xdna, "Resume failed, ret %d", ret);
+		goto put_obj;
+	}
+
 	abo = to_xdna_obj(gobj);
 	guard(mutex)(&xdna->dev_lock);
 	hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
 	if (!hwctx) {
 		ret = -EINVAL;
-		goto put_obj;
+		goto suspend_put;
 	}
 
 	ret = xdna->dev_info->ops->hwctx_sync_debug_bo(hwctx, debug_bo_hdl);
 
+suspend_put:
+	amdxdna_pm_suspend_put(xdna);
+
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
-- 
2.34.1

