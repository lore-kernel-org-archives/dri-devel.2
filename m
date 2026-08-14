Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42CEC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110C810E12F;
	Fri, 14 Aug 2026 12:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="op0UovrQ";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IVvxXlmE";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7039C10E12F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:04:04 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67EAe9Qd1504062;
 Fri, 14 Aug 2026 07:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=PDKol98qsP1d2nOpzi7pz1ogPnsB8mOIRsTlUQaJW
 ws=; b=op0UovrQhMTlTOdfBdH3NYmvzDaOYp8P98c4ldSYA6oUe8LTlOjOdJwU4
 Gpe+iE7oWarMrUtTBuQ8vceTMu7d6E67s6vWmUZS/eWhWGRiRjVw1UR3GO1Y3r7a
 XGf3SzWDA5RDtBAvMAOzy6LwGe9ZipIrUvxpHSi513DAF5uvhuz1Q/sxQjMQ+SWq
 Wml56vJ9NVyz5I24ZQoKqbDtFEJosZlDZbP3cfXWXVsMRoTGwAfTmtcHa62LjV3I
 1UDGc3QNcDbgB+UBOMhs7/Lip71H4j5tTiAxARfoGH8vfXU4pWIyLdVriW7XmeGN
 ZjEL5N8JI7SXvOuu+ziwF6qj+RI5Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g1tryj7g8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 07:03:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhyMOkJYSwot0IJ8KtzMVTanKgu8bGRq5+403V7DRMRdgF0y/rkaIUncmExd4vEQBgZ3HpBZPndUxRYmN7Q/r3PVm42JeXKJvSRDB3wZGMifDgRXzzN56/GaMNYexX/EPfeDNbZJksEHuf5/I3f2qDDmPBoBF2/NoFA+1+J6nD053/YMBmNX1AJPCdhvlEAMMPSmkDOE6k7dDRqaBjEd6vypJ2r443mp6mGFie2FZZ5sUGGLlzhncMp3nRKRbNMzDKACVUt4BuhVlolcIVt4GQrcO1WsVx/AgN1uF2D/3JF6BWqOKsE3o4RjMaA37SnLYkXSHXPPive3YgJRZqn/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDKol98qsP1d2nOpzi7pz1ogPnsB8mOIRsTlUQaJWws=;
 b=wdSfGFKMhC8+AbDFizfdc0e1yJSRsusoEYs3nY+uonRDnCfZ8zS0hMobb4vG0JP9ebhw0NLVWAjs/RfLqAAyT4RGlNMzXljpuKuZlGdyLyDyrteotEpqRzbSFQ7o6fSL5NmFjzgB3l3LQwluaDBjZ/NQkuqN/LhG9Q6I8sOXzBI9ZnLPmFlUU+a1Rl7QvuwV30asyL19qWgzNpSQbhadKmyoCzmpHRPr3ArHLcWooMo9jOkAaBgi/EQTTYzLEyPbVGNptJqCo4T850OAZtDUUCx6tJ/gooukhN5wBffbyiRmgl8K0aqCsQy2Cl9/ktkv5pnrbcw/oIEU27ddLCwIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDKol98qsP1d2nOpzi7pz1ogPnsB8mOIRsTlUQaJWws=;
 b=IVvxXlmE1AYU8rNRhrRmthYLQGHhgDo6fHcAhyIwEyxzdAFu9A8mBgSm5+yfO6U4NuCQFL+g+rf0lVSEUvRMT9S2isn+sON+OjSPoooDif20OFPFEHmfOXAGOHkC/bQ2Prl6oNuWy0SrHuwS96Ln64yMsJnwrG8McyNBP5/R+WI=
Received: from LV3P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::9)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 12:03:42 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::6f) by LV3P220CA0006.outlook.office365.com
 (2603:10b6:408:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 12:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 12:03:40 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:03:40 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:03:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 07:03:39 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EC3Oba1679011;
 Fri, 14 Aug 2026 07:03:34 -0500
From: Yashas D <y-d@ti.com>
To: Douglas Anderson <dianders@chromium.org>
CC: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <d-mittal@ti.com>, <b-padhi@ti.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] drm/bridge: ti-sn65dsi86: improve HPD interrupt handling
Date: Fri, 14 Aug 2026 17:33:03 +0530
Message-ID: <20260814120304.887993-2-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814120304.887993-1-y-d@ti.com>
References: <20260814120304.887993-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS0PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: d62d66f3-6e79-45d7-bb7d-08def9fc1494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|82310400026|23010399003|376014|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qBLIl2RW8DJGbrwMwHp9plqBwQOt/4oaAU0npGLobC53/kfkpJOhfaFzKkej3mac3gLL4etagJExNFDK+2medelgiX5+pq0ruwxdu0i1JoOx5ieyQ+PfQ/myu0lUbmJ+gfqBLc6foEQlIW0Dw//K1OmkKaNxc3QtHC+nLdX9bUWXM9TJplCRrHUWhUJQWkK7k4ndk7cvXiuntORSHBf5zBdyyQ2YNv/XILZLSy1/MmSatfWw7JdqxDP34aYXoZFPyEJ6NlUIluhKDwAj7d3E8bSR3hfMWsgebkM8S12+5DB8Gj1yI7H2eIsFy/NvHvMdXnS+kFh/y3l27fIRTiK1C4i5qbm3qbuKCOsv18RYdJNmkHLa0eZ9MCQ9NpK7rUndjc/qM2Jxfx99N5Dqmf8TGShzdmd3wX+Jespb0YOjGwlJFJnihrEK0CAMqicjzmY9c1u0rBCu9R/f5SWUTZlmI5I147N8P6/8jY4gCvZe7RAxWreuh1YZCHB1+ww6zMh95henzVUJQ3NphdjZmh11e0oGN6fJALToNq+NdftAuaaRj7deWqCm0dkWlA01h+X9aACbnCxoAlVMHTOWY6LCpRnJKU7A06QRPxRRuevrDyIFYuiMqqzEiubECXAWUs7SV5otaCvWysfWGanHSqfHs8oag4KTjINQVCcnHsu53rwxW4oto04kIKuA5y+/OVlnE9DsyIXk82mNlGOjIfWsFQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pjCgUejpWWM0rcORQjlXyIwA/AZAQ1DEy3flspVUER2YBcTznWPrv9ODucPW4Lop0akbGgCWYYGXWGnTCFOHCP7jJvUCTBxUCL9DJwsiQNSzTUUSEzpUZsghfEkxLQ2AbrTuikSX7S0gIPUf6RGiWTxl37MdU9z8G2WhMLVLIiEHJwO/KvqzJ0CfXa3wHQmk1cnMxL3F7tU+RTI52tVNGMwDIsY/OUhYw2ew46tEL8PLm51xzw3IE5UPhQgayPkzp+ioRk9Y1c2tYiKh6AOv3ZtycFuJdbOIyi7RdkIKSzKMQQm4YkX2w6AhSSDB6J3mjl9qeNNNdsB23QnSz/SLyRdXcbHlQzQLY0Yh8b+ZPEMhIa/9VCc/0dp0puPRJ0nPd0Q1PaUwFRoIl5ewJSiDcsGOM1a/JMGlodLEGrufILNYKf7e6q6OnKkrcvls6C2w
X-Exchange-RoutingPolicyChecked: lZmyDJcmFzEhmZKVk/WUNls/vqAUnehNXNM4rlafeC6ED+HqRiAaME1id3EEl/bVWEvESzOJVuunseTlQN0bqOHPsT0IbQjgRRez8OROS+IjpVuEaWZzaAHJ2740GmFpo1WeNNKQpHodbJlmaNgQrPhjXc2WVjlol5//WLPe24baXrKsNXrrylfooAmvhkZQdHjbNzRC95SBKz2by/2VldykLhlADoe57csjFugYW3lh0Ii8AmpuKdeV7D5doVacXPjIqTvIoWjl8099MYhhHrmBw6fncW0W74Xdh2HU+6+Tus4kUjpKOCHUuHyCGXxLIW+GmgN7I7HiPISQLcoUWQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:03:40.4294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d62d66f3-6e79-45d7-bb7d-08def9fc1494
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX1XeFhYmoe/J1
 NtZHjaCPeMnUFtH3YPoucrbIbhudhwWSHjFskNxcRNnK74CZT0ZjCRjj9xZJGiAPZYTVYevqxIj
 M+02Wwy61GQvqiflouGgIKhS91oAe+ajAXQCg5R0UmF5y31C+8bI+ENB5bCSS89tHDi7//YX6zB
 2nadOC3GHJCpRDX/FnAN1ZBMsLObTW0Z/2ipuVM85OrXGL67JazTe93h3VUNG8tItdBg1yAAxZV
 ZNwor6L3veEUMignodsPX65QoCVM6amkFfRe47RyU8SG/vdItRbu5xNwqnmjxOarlm6KpiaAWdz
 3prT7+1YngxJu4dR00CzJEXJMvnNBjrfj5AKzqnXpKcSN+wsYNejPMzj8/EFTTvq658ly/cK5LY
 zZqxjReJuN8lgena8oXsQtXrrstqH2BO39ON9r7ply+bnLbi5zRfoDggXCtDPwewS14dZsllwGj
 2bPDPozunHr+e39eH6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX0MCfwid12qjc
 Kb+JkibEI4BCwVETNi7jfCamHvArxG9CjVR+ZcCiy1Y5deqSk4Pjqh3nNxQOeEqi565lsvGdKY7
 4PP8XTxMORmeECQkB7i1J39LRkIqhwo=
X-Proofpoint-GUID: sqWLaU5ohI_OL9NBf7yrgxohVcxDjY09
X-Authority-Analysis: v=2.4 cv=H87rBeYi c=1 sm=1 tr=0 ts=6a7f0425 cx=c_pps
 a=2KosHvP3s5kmPOqSYQ0Nog==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=s8YmhFUlCT5EURy-xugA:9
X-Proofpoint-ORIG-GUID: sqWLaU5ohI_OL9NBf7yrgxohVcxDjY09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091
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

Fix the interrupt handler to clear all three IRQ status registers
to fully de-assert the IRQ pin, enable replug event detection, and
use per-connector hotplug notification instead of polling all
connectors on every DP HPD event.

Signed-off-by: Yashas D <y-d@ti.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 34 ++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 48b83df9aed6..d9bd4ef8f0e2 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -113,14 +113,19 @@
 #define SN_IRQ_EVENTS_EN_REG			0xE6
 #define  HPD_INSERTION_EN			BIT(1)
 #define  HPD_REMOVAL_EN				BIT(2)
+#define  HPD_REPLUG_EN				BIT(3)
 
 #define SN_AUX_CMD_STATUS_REG			0xF4
 #define  AUX_IRQ_STATUS_AUX_RPLY_TOUT		BIT(3)
 #define  AUX_IRQ_STATUS_AUX_SHORT		BIT(5)
 #define  AUX_IRQ_STATUS_NAT_I2C_FAIL		BIT(6)
 #define SN_IRQ_STATUS_REG			0xF5
+#define  HPD_REPLUG_STATUS			BIT(3)
 #define  HPD_REMOVAL_STATUS			BIT(2)
 #define  HPD_INSERTION_STATUS			BIT(1)
+/* General IRQ status registers, write-1-to-clear */
+#define SN_IRQ_STATUS2_REG			0xF0
+#define SN_IRQ_STATUS3_REG			0xF2
 
 #define MIN_DSI_CLK_FREQ_MHZ	40
 
@@ -1266,7 +1271,7 @@ static void ti_sn_bridge_hpd_enable(struct drm_bridge *bridge)
 
 	if (client->irq) {
 		ret = regmap_set_bits(pdata->regmap, SN_IRQ_EVENTS_EN_REG,
-				      HPD_REMOVAL_EN | HPD_INSERTION_EN);
+				      HPD_REMOVAL_EN | HPD_INSERTION_EN | HPD_REPLUG_EN);
 		if (ret)
 			dev_err(pdata->dev, "Failed to enable HPD events: %d\n", ret);
 	}
@@ -1280,7 +1285,7 @@ static void ti_sn_bridge_hpd_disable(struct drm_bridge *bridge)
 
 	if (client->irq) {
 		ret = regmap_clear_bits(pdata->regmap, SN_IRQ_EVENTS_EN_REG,
-					HPD_REMOVAL_EN | HPD_INSERTION_EN);
+					HPD_REMOVAL_EN | HPD_INSERTION_EN | HPD_REPLUG_EN);
 		if (ret)
 			dev_err(pdata->dev, "Failed to disable HPD events: %d\n", ret);
 	}
@@ -1376,7 +1381,6 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_sn65dsi86 *pdata)
 static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
 {
 	struct ti_sn65dsi86 *pdata = private;
-	struct drm_device *dev = pdata->bridge.dev;
 	u8 status;
 	int ret;
 	bool hpd_event;
@@ -1387,23 +1391,35 @@ static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
 		return IRQ_NONE;
 	}
 
-	hpd_event = status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS);
+	hpd_event = status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS |
+			      HPD_REPLUG_STATUS);
 
 	dev_dbg(pdata->dev, "(SN_IRQ_STATUS_REG = %#x)\n", status);
 	if (!status)
 		return IRQ_NONE;
 
-	ret = regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, status);
+	/*
+	 * Clear all three IRQ status registers to fully de-assert
+	 * the IRQ pin
+	 */
+	ret  = regmap_write(pdata->regmap, SN_IRQ_STATUS2_REG, 0xFF);
+	ret |= regmap_write(pdata->regmap, SN_IRQ_STATUS3_REG, 0xFF);
+	ret |= regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, status);
 	if (ret) {
 		dev_err(pdata->dev, "Failed to clear IRQ status: %d\n", ret);
 		return IRQ_NONE;
 	}
 
-	/* Only send the HPD event if we are bound with a device. */
+	/* Notify only the DP connector, not all connectors on the device. */
 	mutex_lock(&pdata->hpd_mutex);
-	if (pdata->hpd_enabled && hpd_event)
-		drm_kms_helper_hotplug_event(dev);
-	mutex_unlock(&pdata->hpd_mutex);
+	if (pdata->hpd_enabled && hpd_event && pdata->bridge.hpd_data) {
+		struct drm_connector *connector =
+			(struct drm_connector *)pdata->bridge.hpd_data;
+		mutex_unlock(&pdata->hpd_mutex);
+		drm_connector_helper_hpd_irq_event(connector);
+	} else {
+		mutex_unlock(&pdata->hpd_mutex);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.34.1

