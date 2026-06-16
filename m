Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34ADCD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D0010E85F;
	Tue, 16 Jun 2026 21:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRFnbyQ/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011062.outbound.protection.outlook.com
 [40.93.194.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBF210E85F
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 21:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYpNz+pGlEUgG97Dv4VksWgoytGhw9aGT1tpnx8voeu0PkUcM1FsMO7qjR3hVjxbrK7NSY8HclUxaUmB8V2JShv4aDKzJx1glDLiL2D6cvPIwdePZY6wxjuIzx97Suc4igTABXMkf8cVKFhCqISeljO2hlds7gSjQpkEAXkY9UbA3VaAy2Y6fEDCLvH4UIM5SALLvmH6X3qao2vmpdrOMXDGULYcHEUxYTqpz5TlI9n1T31rT3AUwfof6Zd0P9LHG/nFN58ie487+2Tf+8iaLsSOL+N+28pEoxutwVr4yv6vxuj4JB1/7rc0U57Mscb3jR9PY1Z4FY8Z5w2IywQK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD0R2oEn9YoQ5aeUv6kpQHj1in3HoOT0C1YDBDh40+U=;
 b=wxAaIMF6hhljmLGPp3Ht4xtu7cMm/8lT0Pxvo33IkZUKdUpWOHNaO/xruR7ZDltLGvmFqjljd9jAzEDZUAa2PZRAZO/QjFt3XXra4LzSWslY4FDcvfHNPOII1/JXf+x+s2B5lWfyXs1DWS3/Kd2teZuFHYKW6UtBsCio0uzTKLJ52/19ny2gwIZcd4loVXNofwYTwRjjKu+ls+bZraVnBTNA77nSV1SsEi0pVmWVWrVstJQFj2Y5ENvNSDohJGvy9PCMN8mERFhGGrBSz2lRSP5FE5h4XIL/dJcKy5HW+F+bmiynIoLJ+sbOOT9d3r5qodry92Oe/KfRC8JMmpW0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD0R2oEn9YoQ5aeUv6kpQHj1in3HoOT0C1YDBDh40+U=;
 b=CRFnbyQ/U3o0k0+EOAh9Vm2o3YXAhoHhyCn9zNQ9CSsbQTpUVwA38UsY6I7ouelGnoT/S+0dQma5metraFuSDZ8XlJBun2YEwx0v9CliYkSprvyOVrH4k++ZMsqPdl8zwh5iMjakar8yulcjwj0YzJZgWKtCkcGWaCnSC0aKq5w=
Received: from CH0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:b0::22)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 21:24:32 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::1c) by CH0PR03CA0017.outlook.office365.com
 (2603:10b6:610:b0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 21:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 21:24:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 16:24:32 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 16:24:31 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <shuvampandey1@gmail.com>, <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V3] accel/amdxdna: Prevent PM resume deadlock in
 hwctx_sync_debug_bo()
Date: Tue, 16 Jun 2026 14:24:29 -0700
Message-ID: <20260616212429.3620645-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f420cd-ff3d-49e3-5dea-08decbeda85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|11063799006|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: bOhRkZs55D3kMdmhrYeP5YyP5sKz3uZ6crICArOYuIc3KLICP5JawedWpl1jEzQ+0FHqegexOvxr/iFywb+HL6CKbl6zMijk2riePtGPxvyb/PkYMP/j7j4iboXkLlRA9uskQQlQY1fHvBLWt7KYe6/sLS7OzWJbtDTGQ3SWi5GsRiRhYrWc2uUjyTMxDGNRcKK2jfx3vj1Gud2r8GTPUMMdGWLx/ffTMsRreU9zHwK+exy7HZIkiIqMC2IUY9758gGyvR1i3nB4mhZ59yg+4K3ftMU56OMT+cAy1jzM3+mFZZz7Ck9YU0vIqF9u/+jqhQHPmN/9Ysl6sh5rFnaGE6Ypc164MmzORPnTbyre18+goUk+xy9GafzM5aU6coIOCFZl5WkegvRSQYcCn/Onsa6d/h3kbaq2FlIQ0SyyrOTFUK7jOYmzIpW+O/TPuR/mojTWPDQinFiCpu/8mSYArwOAQOtho0iZaDStiVsc7t5OjHJmy8OKkUgT3PPz6Vr62l20YedK3fVeKYC7WtsvfHuKgy09fhtWfdSSwNoOuoBp9SDo0YAHsK+hgHndiEWADZVyNilp4BRnj2n3neCYpjPwNAtNMVnRFz2wrtd18mxhef7kBSRz8cmvzhUwFqtZLQ9fnL4tfXH9UDuiCEYl7V6gVrnImZVMB2E/Iyw//m6eTa9ws6nr8K3zseRfovrxZGkP/E24oGmDs8a+DhUnOxeuXFi6E+C7W9opWIP+UqY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(11063799006)(56012099006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nOWHx81srYTJfhuF0YbwHkvkcnCFasrbPoG5IPXkmwc91wzcBkXVC5ajv7VZpAH39dEhV0F5s/Rp2UN9d7ZPo1Z41V4xEyhYILld4UdWdwZctieJc1yq7BxxNQVSy+Fy1iL2tAP8pAgVSHxuuaZeH2f6bLwtEK02v0vWQISPpaYyrV+pm8AxxuNXdiHZ+U59iSBbrhG60s5xH+bWqtr5RG64tVPTcSrDgvUCA7d5wz1klXV2dps6lhdV4OGPoPqB4n573mYOsUYEbSZpvRhGY8flOAAMly/zcsbp9aT7hMHMQ0EP320m6DXFL0LOEq1fB5SoJKnBwBl8OiT4F7W9A4svGPeo5lfXrGxyMdP3y+49sDUBVbGErdjrUPnxeUX1mtYtPqdJuLlsrvXXNdqd+yZWJ+R45wvmxpI0doFeiepXcN/xBhqOFIDBd2vl+yko
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 21:24:32.5172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f420cd-ff3d-49e3-5dea-08decbeda85c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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

amdxdna_hwctx_sync_debug_bo() invokes the hardware hwctx_sync_debug_bo()
callback while holding xdna->dev_lock.

The callback may call amdxdna_cmd_submit(), which in turn calls
amdxdna_pm_resume_get(). If the device is suspended,
amdxdna_pm_resume_get() may synchronously execute amdxdna_pm_resume(),
which also acquires xdna->dev_lock, resulting in a deadlock.

Avoid the deadlock by calling amdxdna_pm_resume_get() before holding
xdna->dev_lock in both amdxdna_hwctx_sync_debug_bo() and
amdxdna_drm_config_hwctx_ioctl()

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
V2:
  Fix jumping forward over the guard(mutex) declaration.
V3:
  Fix the same in amdxdna_drm_config_hwctx_ioctl().

 drivers/accel/amdxdna/amdxdna_ctx.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index ff6c3e8e5a15..2ab4443e7094 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -356,16 +356,25 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 		return -EINVAL;
 	}
 
-	guard(mutex)(&xdna->dev_lock);
+	ret = amdxdna_pm_resume_get(xdna);
+	if (ret) {
+		XDNA_ERR(xdna, "Resume failed, ret %d", ret);
+		goto free_buf;
+	}
+
+	mutex_lock(&xdna->dev_lock);
 	hwctx = xa_load(&client->hwctx_xa, args->handle);
 	if (!hwctx) {
 		XDNA_DBG(xdna, "PID %d failed to get hwctx %d", client->pid, args->handle);
 		ret = -EINVAL;
-		goto free_buf;
+		goto unlock;
 	}
 
 	ret = xdna->dev_info->ops->hwctx_config(hwctx, args->param_type, val, buf, buf_size);
 
+unlock:
+	mutex_unlock(&xdna->dev_lock);
+	amdxdna_pm_suspend_put(xdna);
 free_buf:
 	kfree(buf);
 	return ret;
@@ -386,16 +395,25 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
 	if (!gobj)
 		return -EINVAL;
 
+	ret = amdxdna_pm_resume_get(xdna);
+	if (ret) {
+		XDNA_ERR(xdna, "Resume failed, ret %d", ret);
+		goto put_obj;
+	}
+
 	abo = to_xdna_obj(gobj);
-	guard(mutex)(&xdna->dev_lock);
+	mutex_lock(&xdna->dev_lock);
 	hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
 	if (!hwctx) {
 		ret = -EINVAL;
-		goto put_obj;
+		goto unlock;
 	}
 
 	ret = xdna->dev_info->ops->hwctx_sync_debug_bo(hwctx, debug_bo_hdl);
 
+unlock:
+	mutex_unlock(&xdna->dev_lock);
+	amdxdna_pm_suspend_put(xdna);
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
-- 
2.34.1

