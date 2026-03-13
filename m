Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7488B106FD9B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CFD10EB2C;
	Fri, 13 Mar 2026 08:25:43 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022116.outbound.protection.outlook.com [40.107.75.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1BF10E08C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyZPIPTmdTVXGQIMkI8QcnVc11OhuOK5dkAs6/pOIjneQCxnd3oLiQ81X8aRVsA8ezYaOF65iyTk71whEMydCrLw5VovT/JoNhTlzQdiSBek6MUXvQqaLyp+TUO7wsXKxDxuAsz58uSdnHJ7zBZrzl5bBJbe5sz/UiUeSG82Q8b7pMCuqRG4tZhtAZqWLfs+4HcduezuuLm7l/vca/L13eyNtH0GyUimni0HlcxyXdbFfCDTAOSzgRz3u6kfqKN2QLvJW2jaWDCudDX0pQq3UmuAjI+0FzQWeF1uT1TKcmEWRY8Nfhpyfzb6nnJbtWkhMtHsd9tiq0xwGLXxsssZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ1K1UxMosZqX5+dKpsnYWXy9DkY3/gOQ6O7dLzkX58=;
 b=tl0AtcslYDIeYlG6yY+L7SmkSz5Ciy2NTqorgQkiLiFtM5mJiTZKoCFeC7ZxeEtZtMlTi/dx2t0szjkqdEYEvn1ZTnLDd9JVISHzA9RTQYI0CNA6liM5Uow+0NpIXo0fy9U+ZzGiS4uMU3TqX/HA54P+VR3k/gjGE1sapLQonAEnbMcFTOmsO64WSObXB/wxzE/q0Ze05FTn5R61omCis5qmBGMf2DbJT52MDzbuo1f5daksrWxwzZn/f3eAMA3+wYwQFyfHkqFEQtCSjR+lXrUtImHSG26O8aN9nbQQObSLOdYGi0Do1Dh0byyT2A1ud0L83ltzVxQswXOZAJMEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:1f6::16)
 by PUZPR06MB6187.apcprd06.prod.outlook.com (2603:1096:301:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 03:31:24 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:4:1f6:cafe::8) by SI1PR02CA0045.outlook.office365.com
 (2603:1096:4:1f6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 03:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 03:31:21 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0D8F840A5BD8;
 Fri, 13 Mar 2026 11:31:20 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: neil.armstrong@linaro.org, heiko@sntech.de, marex@nabladev.com,
 dev@kael-k.io, prabhakar.mahadev-lad.rj@bp.renesas.com,
 andre.przywara@arm.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, Cunyuan Liu <cunyuan.liu@cixtech.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Arm Technology
 (China) Co., Ltd.
Date: Fri, 13 Mar 2026 11:31:17 +0800
Message-ID: <20260313033119.33686-2-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
References: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|PUZPR06MB6187:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e0fc6e11-24c9-4321-3d67-08de80b0fefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: FMX0c4zIouAIHqxE7s8CeTs8owhl4lB6XMomCzh10qlyU1N+HoZW9olyqMJOPtAmgMnEMMy9EjOFWWnFXJbFYupqMAVTi8d7AtjlTavFqXTzxf3s4tKgNXSSo/u7QBcugKAxgIqSsty6lBGK80HVXcttIP2jkURiomhrVzVr52Gq7S8uO/ddvJCi+xLiQl/n3p/bvyhrjxCh5Rje5+rwo7Mq1XmlWCFnxNRCiZZTSGXyhFGF2+Zx2eqZLBZUbJ0LSX1U7yymalDA7sQIwvbR0zE8zkMfMHhVHdL03ouh8VBfM6f5LFBpYgW0jPn+znL2JGxU3qN0JY5XuL60EIIYqbI5dAWYRXTf9kLvPE45q3p4kiI6ECGxw1cdJHcU8AplVkcBvk4/GgknUHdLVD9rH1rcjDNsjzXhwTv7UNuu5nTvWBMljKaZp6sib0mvWckkUJZCJAhJF9LExcA06H4pEzWLuWSLKxLcAWPjqK7KkEW7htDgZnsZ1On6HRS2s9WuMQR9wWu/AlYF2lqNRLVvwc24RkUghy/RTSKLTTf7Tv+kTzA8bfDo3K4pouvLu3LwzmbsOCY5ptPSa8BEcwsYNRI6hsBL9dWKjMz4Mi43JBuOHgy9nPhzm5X3jc5J5rFTUpqVW1+W+TUxN4vXll6JSqqM1Kp/ygBVJ3dkFh/YC0w9DU0wcN0P9dT9PoL0vhS65EDCvl4RMgIQIyPJdzg+oA==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TdFlgh8MHRvO8MfcjPyQpiDE96MnYDsCPUO/JLhQpiWEkb3ocl4fM7/GQhgKMxbg1dJ11qBxwNkD5NjeP0C+klN1rxI00Dw7JjZuTMpw51beYLDr8sfe8rkFFZrRT0lLJ2HyFE4ytUlsmFOaV85rdoBK+hcAI69JwEB+ThEPnAkhC+yBmsNphSL80TCNqVE4hXt3tg4WbNOYpocwSIAWfEE/qxD4m9Mw86JZcfYJaoYATkqgSiVHBDsfL/0vQc+BSf7kgs4HCBltIBjR2GgPFa3gUCB6PMwwLtcFdJ3sWSb1IV5fdymnbOMwt2tm7x5EPKgD0X1pC3Nbuu3VcbFkEwXIqTFkUUxwIRemK+tBqPbR2DhFAjaLdGu5SrzqsV4oPoTwAitdHnPh1GwfdAzWdZ2hWnlppz3biPNexYa098x0XRoXasXXTX9/imiKTr9s
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 03:31:21.1438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fc6e11-24c9-4321-3d67-08de80b0fefb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6187
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

Add "armchina" vendor prefix for Arm Technology (China) Co., Ltd.

Link: https://www.armchina.com/

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe203..c7ca7f43925b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -172,6 +172,8 @@ patternProperties:
     description: ARM Ltd.
   "^armadeus,.*":
     description: ARMadeus Systems SARL
+  "^armchina,.*":
+    description: Arm Technology (China) Co., Ltd.
   "^armsom,.*":
     description: ArmSoM Technology Co., Ltd.
   "^arrow,.*":
-- 
2.53.0

