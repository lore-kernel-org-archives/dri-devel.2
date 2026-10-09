Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F876CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C757D10FEBC;
	Fri,  9 Oct 2026 06:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BL9VCJVJ";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="DrqK9lI8";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE7510FEBC
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:42:55 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6993Hsn11185476;
 Fri, 9 Oct 2026 01:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=PQQ2f6BIZI4YG+7uqnRqIUTbl5T6rPreftYVzVCHL
 2o=; b=BL9VCJVJ/+HNkcj3sjbD8zldinwzp6CWnmEAO9HDqC6wJMkt4W8X6FhX/
 /TD2XahfmY2ao7hKm6k2r1mutH4dxA8VqW8feTNohzOKKNutpo85b+cxhBIFuW/5
 YbNjW9Pk53cxxCZ74r6U1ncuWrboFCHJxI+ZrxVm50X5DIIUne6dHsG1X6lgbSu5
 QzqOLghlANkiwoQfdYhtP5/8R37EfBL3atLanF1PWf+mJL3Cehnk1K287c1l9i4a
 BvMhxeVISmo7Q+m/RwKSpldfwz6D4jnY8nO5rqZZfMQksz8/2BfNnjCNuDPGijID
 3GAA1WrShHr04LtHOe5pdUvfoX74A==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by m0384305.ppops.net (PPS) with ESMTPS id 4h6nq1hwnn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 01:42:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPJYi2lrK3n0Jyg9VFlFvYyUcVJKxDvslYUM3MRPseg6pIibSBWaLIGUtMcEN5zBTuS45vWe7kcf8VMD8DVtzkt+PZ4Unq23nnr0itDCrGiGbVRpkohZ9iALKduNky7Lm4jMp6phrua0NcXwA7efC4Rmup8dNfn8cMdO3BMNRw6P5QvkouIQoPXBBRY7qiHw0nqUKY47w6H5YjLmzwUnqFH9a+HsaFNPxU1RhHjv6nJ6R0cXlXsNNO9Gf++6ufDOVAJI+iP/HUb23DEc8+OhEN9fIJIZSXO8j8/KQqRNNzhD18ojGnSwzqEl0/2qpza++3x+PTtUey4fN/EmUy4DWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQQ2f6BIZI4YG+7uqnRqIUTbl5T6rPreftYVzVCHL2o=;
 b=MjTjF9Eo3W/vqKa0yyyy1dHqvasTyOOzRq8OsBswDx6EIjNCD2aKpOD0WoLm3poS57AaUwsQ1SH+RbEzWkLqEUa/J1IkUh8ZKpfGl569O9gFdQyUnWzAeXFsoe2/BFtQofWF/k/swbq+Xmo5Dv6Yl64epjyMdJEAow4/6vLKeERU7YGkfvMrOo9+0Y6UXvKh7JHvnJUJqrz2KyYPUbmHDQn3OXr4oPkbBgLBzwOybwfsXOVMloaqqx8znPlY64SEcgE10jlpe616D/5Nn2XJj77Zral+70yRFsbR4TUmoJAWwrfbxlUBiUFyFmcFKftkDMj0sciPYEwPWMsRYePhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQQ2f6BIZI4YG+7uqnRqIUTbl5T6rPreftYVzVCHL2o=;
 b=DrqK9lI81WgG1Mnm9XKmPmXcbjHEPLSrO4wlKEqKnsJSld5y8yChNH6GC42eTOoktmQDMnYqknHr0rDLcpy4MZIxNv6wEg8jlUNyrXj8qMi4YRvdpRbbC0lvF86EmrrswXNPUUBxBQJK0BJwn3gKPW1/BbuQ+xqtfLAHUAWk1u8=
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 9 Oct 2026
 06:42:29 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::a6) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 06:42:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 06:42:26 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 9 Oct
 2026 01:41:52 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 9 Oct
 2026 01:41:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 9 Oct 2026 01:41:52 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6996fXfv666824;
 Fri, 9 Oct 2026 01:41:45 -0500
From: Yashas D <y-d@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <h-shenoy@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <panchuang@vivo.com>,
 <kees@kernel.org>, <r-ravikumar@ti.com>, <y-d@ti.com>,
 <sjakhade@cadence.com>, <yamonkar@cadence.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/2] dt-bindings: display: bridge: cdns,
 mhdp8546: Add no-hpd property to the cadence bridge
Date: Fri, 9 Oct 2026 12:10:23 +0530
Message-ID: <20261009064024.985688-2-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009064024.985688-1-y-d@ti.com>
References: <20261009064024.985688-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|IA1PR10MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d08d72-77d6-4cd5-0bf0-08df25d07bb2
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|23010399003|1800799024|82310400026|376014|56012099006|921020|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2D963je6xCXfrdDgNZ6YuA9Du+xqc1jP8gXsWUwvM7ARDZKxPU+1/bXzS+rqXieWAqEj/RFZwEN+M5vvcKv0g5RtQEliwmpQzOvGTrEh6AIEDxkYz/xJpVjpkW+QZzQ9+OfiYqJ9TNwBbhs5CW4DE12EDkuvwLgfScpD9M1wCMgDtOzkSWAs3uLBPNPyCDUvIYa/TxZwAWviyZ0khX4t6Buw5n8nN//IOyoDll+aYKkkNyi4WtYxbWfPQjhfUcIHLbuWOQbvZCfXUkGYe3tV/h9qOWa2wP4VEY37Qujdt5Tzo6qWEg8RHOmErfAwyEzvh4JIDvxwdYX8ZXlnyi+3qpzpEk74ZkHq4s59BUOC1bEVSgUz+JlhiXOIq8ZVRyZ8dZAm31KHYUn0+eiJGTXodBF92+4oO73NK0orZ3EP9HKrOI4WOD8D/2uBkU1Ve/L+WtRNJd5vn/00fO7kE1Fe94JLRu5pgKbypadxDR3PmUHgiu1qt9mbBQgQQoj86JVLx28wdCDXABLuPKiSWHbwXu5i4/m608blM4XvrNR3wr4+qabZoVhh94i4JaX2EzszZF/yA5h1Xptwnfj+2BVOGeDZaf2mDZIyp83fi7G23jxINupeQ7mB8cD/r4pBdmMEdHPmaWi+ouoWqohWCo/xPjQxg6wOeil5J9GW8juHOi2DaygUMKzoPXQ5vTN5Lq+dAQcoM9/iPvXCVVXs1HrL0qO3kd1flobZK8qqpwFcmHvpZC/Ol379eG9aO4yoNiAL
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(921020)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9tTP8t3sHoAiFFWJXMxEeTlEl9FN60DKj+Xk5e4ZyJPmOHD587KSS59gSJhBELyBPt5ZhUSzx7esEw+thRS+A/2HfEJEdbtKWpduwBukSd3pNKrEClJsJ9hpWws3nwpWWI0F3ivVGCWRvN1roH/qYLvXYoeGoxf/7mfTUK0Y5434sRQbQ9LNCwRKVKO6R4+ZGuZUCzHUjOjb9foXFG2RgmbcSQjyG3uz1IgtmH+iM10IrWsWkU14x7oJNEXjwFSgbzk9wZZ4VVetZ0LANjOmK9X3J3sVCnHn08EbaxOqQyvaaM5C+TzgYIndymsqMhvTVPrnVrSkTY2CFnT9SRzgPQ81Dg6e/Tcg5tDg6JxJrZW+5sQ8VAd7GPQOkiC6N67G+XBUSLmVBBkndKaTXxDJQyXr/FNdyzkz4K0+vqYxkbikoFu0Zqktaj+jPLlrLt6H
X-Exchange-RoutingPolicyChecked: ojzr9GLquIjTY3vflPFgtgdt+RxhXXr0EgrrwfxHmJZrsr0YRNozPpK1ErCyx93by9Yb0uUEJZKsd7damCZgrRWKDDJ+8jJCYkBqWaLUWlv5k/t8mIZh85C2sxprFgQBH93f1+1MQEXHAkqsRPmjbIgUp6l1LnqqqWDxEbPbtqByfq17k4HU7T1JTJ/Hmkb7O8MRYXz/kXQu8Y+moEeWOXSXHRcaRNOrfzIHpFVPuq7Pc3uu1lnyvpZULqIqONYIlngL5CGRHVvOKKgOStbV7Xu8tzg41yv2RmmPKL4FfBZHiiWqNPtsItlJoBFS/nk1lMNc97N/eHSj0Lg9/3XcmA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:42:26.7168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d08d72-77d6-4cd5-0bf0-08df25d07bb2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7240
X-Proofpoint-ORIG-GUID: Wwdy15w9Vrfj7CPpXwbYY9t_EBoP-EX4
X-Authority-Analysis: v=2.4 cv=BNAmP1QG c=1 sm=1 tr=0 ts=6ac88cda cx=c_pps
 a=0xEX3eBh0rLUWVDLTvkg2g==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=EzX1xrUl6JEdRszeJO8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNiBTYWx0ZWRfXylEoVGFUnjIh
 SXqBpJ9nCOZTkGJSWwdfG4D3DmIXhsV15gacX57aIAu3B1gjUK4TCT6Lz1hdN2CkocmWwQAA+a8
 RVRZs/VglR1Y0dh6/E25TrSvkaIx8WzLBclxBzTK2u9AWs0iK6wT5vAl14zHIgbRhadb7ngY9TZ
 4BWbJJA/GWdS1t9DPG/50GhWE/P0fpjMB2xKmtzEfLBiLvaH8DwWyy8RjMFOABhbnV5jFC8LfTB
 MHsRPXBG4xi4ytUoMknaGnl6/frc0iln0ww56sba10FJuRfInmmzOwzhhHvb6lom1lH7R5ZGDBq
 eem+IhlDF0lTRqNPWiB8hLqG7Ky/zleW0V2my6w9Hp6Zhqi69KvwbqcmthTRL+ekco3ljzjuGMQ
 FRWFpLjnGE6M/B0LmKxLZGFTMMOyYPmWWpTAuCCDcc3Pkcg3qcg2hLQSTsdItlPNlXj8Cq6tx/g
 UzQVm10KN7ujoOHOqrw==
X-Proofpoint-GUID: Wwdy15w9Vrfj7CPpXwbYY9t_EBoP-EX4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNiBTYWx0ZWRfX3iXmOPHbLhLV
 U6cvOBJRBdTpBUQs43cJIlIiIohBOiV8TXgsauPF9EXcuFoXDoZnugHeWzgjMfdgJjbGjISfvMC
 S4w92uqKwUgIlsDo0xaYq0YRkB0qsEA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090026
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

From: Rahul T R <r-ravikumar@ti.com>

The mhdp bridge can work without its HPD pin hooked up to the connector,
but the current bridge driver throws an error when hpd line is not
connected to the connector. For such cases, we need an indication for
no-hpd, using which we can bypass the hpd detection and instead use the
auxiliary channels connected to the DP connector to confirm the
connection.
So add no-hpd property to the bindings, to disable hpd when not
connected or cannot be used for hotplug detection.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Yashas D <y-d@ti.com>
---
 .../bindings/display/bridge/cdns,mhdp8546.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
index c2b369456e4e2..56ce3f65ff495 100644
--- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
@@ -57,6 +57,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  no-hpd:
+    type: boolean
+    description:
+      Set if the HPD line on the bridge isn't physically connected to the
+      DisplayPort connector or cannot be used for hotplug detection.
+
+      Valid use cases include HPD pin not routed to the connector on the PCB,
+      HPD signal muxed with another function on the SoC making it unavailable
+      for hotplug detection, or hardware design where HPD cannot reliably
+      detect monitor presence.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-- 
2.34.1

