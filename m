Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C139DC98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1611010E682;
	Sun, 27 Sep 2026 18:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KHs8po4D";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QaF0f37c";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8796D10E682
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:27:44 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R5u8XU2806506; Sun, 27 Sep 2026 13:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=EbYKy05ou2Ez6NpcXJxfb0unII2AN7oD09ZZpwZp3
 4Y=; b=KHs8po4D9oXxMm2us7qwfvr/Q+mf66watx8s7LEYABe8sC64wphqTRGxg
 mGfUAjwlMVAtsiigVHK0deywqQuZGMdWMmtBW7cMiCKZi/UCYqvw1z4OEitjJbsb
 LOJycDlMhqf4AZGQYEMnvHNuJljo8k4QnXuvm2TB879aXO8Eg6C2Qp16IYohBxNr
 OOPKO0IwBSDWJO6rpQDt/On4e+IM1JmoNYh7+UtVsXLZYcTstQBF+CCFZtPSD8mA
 0aRZA8kQ/uosdY8/dahuNcOn1rd6HEb77W3uWEYpkK3Qe6f0abAnZLiM2ETyzQvQ
 QqY02GKUna6tP/l1im4lswSaL5JKg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gxwe5hxnq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:27:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4Ecq4rP6OopHaCXAIrndHyGtBxM+1G0OTbwiHJ4OVvr0idzP/oM7X+QygMRKfzS0DPNletkhNvn/fxci5R01ANpS240ffzUzEQPgFfLYTDrwIRqgZwtl4tOmZkvKagTfcqg+fMrqK/Td6KDHTS2P1UL8cYzPmcHKeRtUdjv19pZMp8elH4NhMmPUCi0HJtY50liDiCQyW6JZ35DQfL/sGhWLtBwWkeuJcWBZMy/+KtqnglLXj4BHD/1KYS48TCeEDPUzvZrEiPjzoK64mm5+dqSzcEYwwZHQbvCwDzB8oYK5BRLptKPV+OaOv+a302MIWghErWlJvYHuDD/WF/guA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbYKy05ou2Ez6NpcXJxfb0unII2AN7oD09ZZpwZp34Y=;
 b=QsWrOTVVggPuaxZKcFpgL2GQ/uE/DC0eQo/ETxlr90dMqK/RcGWg5/+1xKpVssB9nFkj0me513/6r3bUB9+b+dOrUlTWkFZPWhgMev2HJq9lvqaw9bavfMLnlz21PtZa+z66itup7A5jbihR8J6STsvEczFlbez/0G7pTwiw4BhwXv5xatz2sKfiQXoNCRzYPIL1NSPjD208+AEZDvL6u10V57m5HoBZau6CFA5YjPGY/AOrsAfJiCwRrsT3TUgqW+O/jYaLBCWP0fq9Shtcf2asjuMQ7rVHya/aczpJarkHgcZXpLwV36ahgNvYsVG0dzdNVYWIL5dI8Qs7XQFtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbYKy05ou2Ez6NpcXJxfb0unII2AN7oD09ZZpwZp34Y=;
 b=QaF0f37cZ5k+eSA3HUb2/ymJsF5Z7VlxgvNINHkHUMnM5l6Zs3QY55c/zRST5rpe67xv6NQQ6DaQ4OTnpXF2E89WVpWkrUP0/VhcUWBxR5QQp1oRjDGoMIudyMeeQANEncQWR+RH75XXVk6+DXVry2w1Qck3uemWQ1CWkEwb/So=
Received: from MN0P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::23)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 18:25:33 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::7c) by MN0P222CA0020.outlook.office365.com
 (2603:10b6:208:531::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:25:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:25:33 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:31 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:31 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIPTOe1629678;
 Sun, 27 Sep 2026 13:25:30 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 08/14] drm/solomon: ssd16xx: Expose refresh mode as plane
 property
Date: Sun, 27 Sep 2026 23:53:23 +0530
Message-ID: <20260927182329.4193961-9-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ce373c-e673-4dcf-80b0-08df1cc4b81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FxVURM77xU7cExu5ODEb8DrqeuELZI9GY6Nr6Bg85108pM4BGPFWpHoGyxodwAj5F6g/Jlev3q5I4oC3TLVe3G1O6SvCPxag/oDg0/xZPQcum0C1lo3Yp93pjLuFxAfTZXpyG5BDThCCKPSuqlZOuWXjgD0I9Cb7NiiIP/IviL8Nz8CAvablprphnflRecqjKj1p2svoqBFS6mD+NNKzYCGMMY1cH/LWaoaR7fgZjMkqcvd0BGoZBlW6WWe2Vw0fyheySaUBZDgKOnkTsScZSZwidXXowTH9IUZT3pis6UTogpgnISdsWrlRQXDttLzJPhgbw7eYdOZoSv/jC11bHveSFQVEpx0LXjRV7R9tIHrKNLE0cVdBFv2sWkmbfvznUFwfdfyYDjrfn8aLFGnHAOtjUOfYNUkMOX6EsSM4GKzJxJiDJr0iq1OoWtos7L3mrC1hWNmM8KonrguRvt/YPO+xoQLiRyozamxfIbv7PWzuhDUx7CVw0RVA+o+oWHzyDGtsAazraz5S9xTsxA8t592UPxu4SnFW4Rlr8NlKaL2puGU+iLXAyoXY0hYNzMC3bk4cxHOVlK8SgP3qg1Eeb6nZlLpOzG8GQDSDvzhOt7/kY64pFqx3OOR9r1UCqMJLivcN1hWCU5S3yIYyUC790RaEiE8eVj+xBXmjTf4gFJKvjqRERyxI45CusTOUIGzERJSxUHTtfQthYBtHCxgKoCZvc/sFHpno+k+hU1zK+FXOWYXuFyt6YZEfMuPDyJYC
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ltCFkPvYW2NuGqVGvXgm8/f7ppqLYrOe+HPGAf4eWDJMvy4veggu2U1XyvvfGvA/O8Y96eO1GyAjAw8ep7jKpsYqfue+Q5IdgFzR6nBKc6PGb7crSFxK+wH7FzvDZxLz/ntvIfNkFGpk0BqRAIrLtgmMA+nl8ISKFHi4J+GJEXg6dr9f9/4spG8bWWq7yD8CiHvu790meaa9IYfU8kjdcbs81FkOaduGpqncPKOY3r/vZdMG2CJeLHCu1ng0WuPgSc6cIlpmcISz16YVWBjxrHmtMVEvXaeYRjrNRAdeo6adBNtVxSyx6pWjXcYmQZQUqOH6EWZX1NQ01GpxrBqkdFDT+OWTC+v44dQqmERHWY6eyyG/o1cDo2Rc42ys8CQhWV+D8tm/FuknQPt9Rwi0zgPESog0P1phxs07zK3tYY4S93Otr6IE6RL2M49EYWGF
X-Exchange-RoutingPolicyChecked: yV0bXGGGNDMqQkoDZp/nByvSNHJB+eh+AoBZ26n24lhJhB6iRTsA7/Qwq0zYrKDN4Z3YnqeEPwPQ4Nih1BUU2xVWy0g4JTlMeaz1HnVqn7Pp+DyOwcViT5rZa1hntPGq9DwOXn/EdxuKwEcK5cMaaYJjiD/YhZTAP/hJDeKXNBrMvyN0Bz3awA6jgW/+g4id9I0CIIp+OU6aakHlpVdmUhdCVq1IqF8G2sBGFQEZjhKcYJ2YAXRPOCp6VcwByLcVtXVq4tVshVYLlC2KucDcQFRSQwr9EJvdk2xW4hd2nIETB56L6Yezy6N16ihLhALOPeRtEKgMSTMdrFLD3Fl5Bg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:25:33.6734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ce373c-e673-4dcf-80b0-08df1cc4b81b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Authority-Analysis: v=2.4 cv=aeP0Dhot c=1 sm=1 tr=0 ts=6ab9601b cx=c_pps
 a=7LdyZ4/2TJtu80KvlWUjDA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=ZefhO2H21uGiRyTyvdgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX9Eucq/fjERF8
 UA+VgK9zEjUli5f6iYp2O6RbBzEwtuOVHbIy82WhHx4/22Ct+AQASw5fKulD0PZYxZbj6ula/Yq
 UvgWt0lR1guvadRUcdn8mKdXvAwnWU4tXPqy0FxkYAY+MiULFpqBWzWHRTZ2FUzQ6VhdPYJpDEF
 VNOVFs57L/kRm1hpg/Wt/pN8G+yP9hyuKlBh79FxLVasrJVhlnOb+BdzMtJ0qgyHiYMPJkB9/Ce
 HunT+sdU1IMPTUj/wisacOE4ybgrh4jBxkmZGy7Ny5Svvx5JuXn9v/8oodPvfhMF+edLdWGAzQR
 Mw95oMcMjkM0Df8JZT5DcKWa9V/6PDM08owbQJics+gRU46taLY6cAmDjwm4TlqRPNs+WEKXChg
 cMduUuytwIQbi0xiFjZsMxaZYevJpPRdaxGTYEeY7Lnnnjon7akKVdE/JArl10rUj6cF1Hrjupo
 VKE4+KqOuAMoixcZ+TQ==
X-Proofpoint-ORIG-GUID: io7_ChaDte4zFkMoL3gsf4zRi2vitKN6
X-Proofpoint-GUID: io7_ChaDte4zFkMoL3gsf4zRi2vitKN6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX+XgJ8yNBceDI
 frNAJKQOu/FKqEd6CHnvcFnuEwEXc//kRd+mPGpU+Wlwp2ZyElvfCGDh1b/1NQ1LzMo2XMqwBaP
 0wRT0Hf12HouUazG3lIgrRYJ2NQw0pQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270073
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

Add a DRM plane property "refresh_mode" allowing userspace to
select between partial, full and fast display update modes at runtime.

E-paper displays support multiple refresh strategies with different
tradeoffs:
  - partial: fastest updates (~300-500ms), minimal flicker, ghosting
    accumulates over time
  - full: cleanest image (~1.5-2s), full black-white cycle eliminates
    ghosting, most flicker
  - fast: intermediate (~1s), skips LUT reload per frame (loaded once
    at init)

The property uses an enum with values matching the internal
ssd16xx_refresh_mode enum. The default is set from the panel
configuration (typically "partial" for interactive use).

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - New patch: Extracted refresh mode plane into dedicated patch as
    plane property

 drivers/gpu/drm/solomon/ssd16xx.c | 140 +++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index 6255f434248a..dc2b8fe536af 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -400,8 +400,20 @@ struct ssd16xx_device {
 	u16 *tx_buf9;    /* 9-bit SPI expansion buffer (3-wire mode only) */
 
 	struct drm_framebuffer *last_fb;        /* Last drawn FB for reinit redraws */
+	struct drm_property *refresh_mode_property;
 };
 
+/* Plane state subclass: refresh_mode lives on the plane, not the connector,
+ * so plane_atomic_update() can diff against its own old/new state.
+ */
+struct ssd16xx_plane_state {
+	struct drm_shadow_plane_state base;
+	enum ssd16xx_refresh_mode refresh_mode; /* Pending refresh mode */
+};
+
+#define to_ssd16xx_plane_state(s) \
+	container_of((s), struct ssd16xx_plane_state, base.base)
+
 static inline struct ssd16xx_device *to_ssd16xx_device(struct drm_device *drm)
 {
 	return container_of(drm, struct ssd16xx_device, drm);
@@ -1397,11 +1409,91 @@ static void ssd16xx_plane_destroy(struct drm_plane *plane)
 	drm_plane_cleanup(plane);
 }
 
+static void ssd16xx_plane_atomic_destroy_state(struct drm_plane *plane,
+					       struct drm_plane_state *state);
+
+static struct drm_plane_state *ssd16xx_plane_atomic_create_state(struct drm_plane *plane)
+{
+	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	struct ssd16xx_plane_state *ssd_state;
+
+	ssd_state = kzalloc(sizeof(*ssd_state), GFP_KERNEL);
+	if (!ssd_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_gem_shadow_plane_state_init(plane, &ssd_state->base);
+	ssd_state->refresh_mode = device->refresh_mode;
+
+	return &ssd_state->base.base;
+}
+
+static struct drm_plane_state *
+ssd16xx_plane_atomic_duplicate_state(struct drm_plane *plane)
+{
+	struct ssd16xx_plane_state *old_ssd_state, *ssd_state;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	old_ssd_state = to_ssd16xx_plane_state(plane->state);
+	ssd_state = kmemdup(old_ssd_state, sizeof(*ssd_state), GFP_KERNEL);
+	if (!ssd_state)
+		return NULL;
+
+	__drm_gem_duplicate_shadow_plane_state(plane, &ssd_state->base);
+	return &ssd_state->base.base;
+}
+
+static void ssd16xx_plane_atomic_destroy_state(struct drm_plane *plane,
+					       struct drm_plane_state *state)
+{
+	struct ssd16xx_plane_state *ssd_state = to_ssd16xx_plane_state(state);
+
+	__drm_gem_destroy_shadow_plane_state(&ssd_state->base);
+	kfree(ssd_state);
+}
+
+static int ssd16xx_plane_atomic_get_property(struct drm_plane *plane,
+					     const struct drm_plane_state *state,
+					     struct drm_property *property,
+					     uint64_t *val)
+{
+	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	const struct ssd16xx_plane_state *ssd_state = to_ssd16xx_plane_state(state);
+
+	if (property == device->refresh_mode_property) {
+		*val = ssd_state->refresh_mode;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int ssd16xx_plane_atomic_set_property(struct drm_plane *plane,
+					     struct drm_plane_state *state,
+					     struct drm_property *property,
+					     uint64_t val)
+{
+	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	struct ssd16xx_plane_state *ssd_state = to_ssd16xx_plane_state(state);
+
+	if (property == device->refresh_mode_property) {
+		if (val > SSD16XX_REFRESH_FAST)
+			return -EINVAL;
+		ssd_state->refresh_mode = val;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static const struct drm_plane_funcs ssd16xx_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = ssd16xx_plane_destroy,
-	DRM_GEM_SHADOW_PLANE_FUNCS,
+	.atomic_create_state = ssd16xx_plane_atomic_create_state,
+	.atomic_duplicate_state = ssd16xx_plane_atomic_duplicate_state,
+	.atomic_destroy_state = ssd16xx_plane_atomic_destroy_state,
+	.atomic_get_property = ssd16xx_plane_atomic_get_property,
+	.atomic_set_property = ssd16xx_plane_atomic_set_property,
 };
 
 static int ssd16xx_plane_atomic_check(struct drm_plane *plane,
@@ -1429,6 +1521,8 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_state = to_drm_shadow_plane_state(new_state);
 	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	struct ssd16xx_plane_state *new_ssd = to_ssd16xx_plane_state(new_state);
+	struct ssd16xx_plane_state *old_ssd = to_ssd16xx_plane_state(old_state);
 	enum ssd16xx_refresh_mode saved_mode;
 	u8 saved_border_waveform_idx;
 	struct drm_framebuffer *fb = new_state->fb;
@@ -1456,6 +1550,25 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 
 	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=(%d,%d)-(%d,%d)\n",
 		rect.x1, rect.y1, rect.x2, rect.y2);
+
+	/* Diff refresh_mode against the plane's own previous state to see
+	 * whether fast LUT preload is needed.
+	 */
+	if (old_ssd->refresh_mode != new_ssd->refresh_mode) {
+		/*
+		 * Fast refresh omits LOAD_LUT each update; arm the
+		 * one-shot flag so LUT is pre-loaded before the first
+		 * fast frame.
+		 */
+		if (new_ssd->refresh_mode == SSD16XX_REFRESH_FAST &&
+		    old_ssd->refresh_mode != SSD16XX_REFRESH_FULL)
+			device->fast_lut_pending = true;
+		else
+			device->fast_lut_pending = false;
+	}
+
+	device->refresh_mode = new_ssd->refresh_mode;
+
 	/*
 	 * When refresh_mode_init was set, use the specified mode for this first
 	 * frame only, then restore the user-configured refresh_mode so
@@ -1753,6 +1866,28 @@ static const struct drm_connector_helper_funcs ssd16xx_connector_helper_funcs =
 	.get_modes = ssd16xx_connector_get_modes,
 };
 
+static const struct drm_prop_enum_list ssd16xx_refresh_mode_enum[] = {
+	{ SSD16XX_REFRESH_PARTIAL, "partial" },
+	{ SSD16XX_REFRESH_FULL,    "full"    },
+	{ SSD16XX_REFRESH_FAST,    "fast"    },
+};
+
+static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
+{
+	struct drm_device *drm = &device->drm;
+	struct drm_mode_object *plane_obj = &device->primary_plane.base;
+
+	device->refresh_mode_property =
+		drm_property_create_enum(drm, 0, "refresh_mode",
+					 ssd16xx_refresh_mode_enum,
+					 ARRAY_SIZE(ssd16xx_refresh_mode_enum));
+	if (!device->refresh_mode_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->refresh_mode_property,
+				   device->refresh_mode);
+	return 0;
+}
 static const struct drm_connector_funcs ssd16xx_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
@@ -2073,6 +2208,9 @@ static int ssd16xx_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ssd16xx_plane_create_properties(device);
+	if (ret)
+		return ret;
 	drm_mode_config_reset(drm);
 
 	/*
-- 
2.39.1

