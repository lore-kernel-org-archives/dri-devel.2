Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC5606A337
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8561123A3;
	Thu, 19 Nov 2026 12:39:18 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023134.outbound.protection.outlook.com
 [40.107.44.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B82E112381
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnZeHTObwHcuLzu8WQJwTSL5erFA4emZVIYhwsKx8RjPZ3Zu9QLoiMObh08kCD0ajo25cON8wcH0HUYD9T/VS2EskgQxYPaC7Y7+7RwGl09F2HDN23DTGPNCEH/3Cz7onDztva296Nvcrz0Uj+BPlP9G8wLaN7gV9ovR/zDMUhfqXqzEZvK1DvH15dLm8h6BPqw6T9DoaNnOYoWOLcVkExWFYmbuxoBYvbTEtRjtzHwnTadtvwfBF0eO5a+f8rfIPwJlAmt00TmVZDsnKGrCPjb65YDih05V7tzxr4N/0g9hzxmdFfqOuXvAH3/DLcxKQda0gX0DQ1rxUcVGzZ4Nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQZV6hp5eZ+mxLb24Ck8TMe0z4xOG/vfA/O3fiA/aWQ=;
 b=PSIm0ECSQa6AusJgrFrJM0bMbDhnrsv7boalzxpDUjz7hvC5VPC31SQM+qIgsZAlV7/7o7KtDLXSfn0EQBfkm27WP3KCaHx9hKpxcPdDWNKEzJO0AqttBE0IeW0Al0y0xKEs2eAmj41VUGjCv+PlwFAVRwiEe7WmVdVWvxYXoO1cLxJJp5FB1bPzyIWDwkEeuHReFMAu5TZUWg9D9KnUXr566Pmb1D93jtQAe77lx59uL8pLHSInbfzOmevkvt9PvF1OhuPqDbAaCdt8emn6FtQxfN7xLhvouOYYO6oDoElwj5Jcl1sGr6AN2abTgzcPbJ4wlPNKlPBi/doMWYJzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:4:186::6) by
 SE3PR06MB8108.apcprd06.prod.outlook.com (2603:1096:101:2e7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.2; Thu, 19 Nov 2026 12:38:54 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:186:cafe::1b) by SI2PR06CA0010.outlook.office365.com
 (2603:1096:4:186::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 12:38:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 12:38:52 +0000
Received: from cix (unknown [172.16.66.176])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3C727427EFD0;
 Thu, 19 Nov 2026 20:38:51 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 daniel@fooishbar.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH v3 1/7] drm/panthor: Add optional external reset support
Date: Thu, 19 Nov 2026 20:38:44 +0800
Message-ID: <20261119123850.2994625-2-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SE3PR06MB8108:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f90ed638-31cf-47d3-80c0-08df463a11c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|23010399003|921020|10067099003|56012099006|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sxyj8eLadWFDMgVwDXPtm49tSwrfxGPl1RNtPZD65L0FmXpWbFOnk2RPJAHdx4WuWQ/FaXiF2GF1sWdSQp/dpp8zRDdwKVuykKLfblDXy/vn4UVdc6XVd6QWRw6dj9IjRRDTHWq0xGidi0/lDNLup7V0qfBEIYSZPNwveR6V0SlFY5V6D67Fbj3XJCxpBXUke2xIk7c0jvHNvyFwv6h6X1XIPV4Axt/gpoWy7+xOdz3fi+iEuvRivec6C0WEy12WsJUDkx7FLAUNsN+Un7sONqG/+evrHav1wUiBRM/GdAx6S0hyvDIpK1gMsCIjDgH823CVUpy1RAlMOaHgxNkQwREySOa7vIvJefZRTT0kxiN9v2dVDxeOhvPTAppSCeJjo8tqDg8KjKN+8FfZfGOtvrSzaIEt09Iyy053eacP3UCorG+b2PG21EAFTXY5ZN5KWB5HUGSY6QYn7gQeAGRBApOQVrMjTcYtsehrkvx0R+TmX0hh3AucxWVXihvAQMV4RXS2wXY/NSy6mCVLie4VlRug/e1ZbJD51t94KVFfzNhJgx5XQfxy5rJ6o1+HRpqJQLxuBzw8YvMfd+G7vFpl9dZDvD0IZiYt51MceREjCbrrcLqXJmVztrwcR/aH0JlGMfTZkdZtyd3gFODKDoDIrWRPrELt3ehPiSXoVN0XRmQihY/FCcu5iTWTPNBvA9/5ETw5gu9MWaSbeAdysaAu1nX0Gt7MPV1gMO5zyYKKZTKZU3GGHHJLFIJKpwWAIRlN
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(921020)(10067099003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3/PNcXr3Z72+mcHkGlWJEAjTGL/RlAiT0xU4Pn7QN2DYKkafZS4+o9sBR18HF2UsMRqzZ9qc9AEy63IRA2Q7+8HOUXPa6wBX0U42TPly5+/Ujrtns/1d7uyfPebiy+TMultq/0fYsu6xg/YRWjFbwih5kkoQU+q7BktrsW4p4p8wlrIIK0nv7jWWG3YRIXLcXp3OFUbTWdR1DijcC9Qm0M9a1SIG/Rtn/eIMSB9f8UpePsiK6btnT3YnXIpJITa4IscIrkCxlSomZQgdfbUmVyNHuk4wHaytok1VuJHq7nZS6ESCpifCVivtc04WDAkyOL5WExg7We6dAA7yzGPie+HQAmsnTpXIaZIzsjqHZJyCnrd2+5fKw0jfU6bmWr7CfSDPOlDUY6qzT41vckHvdwOFFsUxjw1abCkI36FpoZtmO9KzdMETnPMXHFYy7ccS
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:38:52.6237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90ed638-31cf-47d3-80c0-08df463a11c4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8108
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GPU on CIX Sky1 needs an external reset before the driver first
accesses the hardware. Without this reset, the GPU hardware cannot be
accessed correctly.

Acquire an optional exclusive reset for all platforms and apply it after
enabling the clocks during initial probe. Platforms without a reset keep
working through the reset framework NULL handling.

Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 13 +++++++++++++
 drivers/gpu/drm/panthor/panthor_device.h |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 9687c59de350..a3a32abec5f7 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -229,6 +229,11 @@ int panthor_device_init(struct panthor_device *ptdev)
 		return ret;
 	}
 
+	ptdev->reset_control = devm_reset_control_get_optional_exclusive(ptdev->base.dev, NULL);
+	if (IS_ERR(ptdev->reset_control))
+		return dev_err_probe(ptdev->base.dev, PTR_ERR(ptdev->reset_control),
+				     "Failed to get GPU reset\n");
+
 	ret = panthor_devfreq_init(ptdev);
 	if (ret)
 		return ret;
@@ -511,6 +516,12 @@ int panthor_device_resume(struct device *dev)
 	if (ret)
 		goto err_disable_stacks_clk;
 
+	if (!panthor_device_is_initialized(ptdev)) {
+		ret = reset_control_reset(ptdev->reset_control);
+		if (ret)
+			goto err_disable_coregroup_clk;
+	}
+
 	panthor_devfreq_resume(ptdev);
 
 	if (panthor_device_is_initialized(ptdev) &&
@@ -553,6 +564,8 @@ int panthor_device_resume(struct device *dev)
 
 err_suspend_devfreq:
 	panthor_devfreq_suspend(ptdev);
+
+err_disable_coregroup_clk:
 	clk_disable_unprepare(ptdev->clks.coregroup);
 
 err_disable_stacks_clk:
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd41..adbc2e2f03be 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -19,6 +19,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+struct reset_control;
+
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -138,6 +140,9 @@ struct panthor_device {
 	/** @soc_data: Optional SoC data. */
 	const struct panthor_soc_data *soc_data;
 
+	/** @reset_control: Optional external GPU reset. */
+	struct reset_control *reset_control;
+
 	/** @phys_addr: Physical address of the iomem region. */
 	phys_addr_t phys_addr;
 
-- 
2.53.0

