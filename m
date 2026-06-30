Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6754C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A154B10EDDF;
	Wed,  1 Jul 2026 07:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gc/7lO7P";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MJARFnA1";
	dkim-atps=neutral
X-Greylist: delayed 1147 seconds by postgrey-1.36 at gabe;
 Tue, 30 Jun 2026 10:46:33 UTC
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7416710E1C3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:46:33 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65U9lL0R235970;
 Tue, 30 Jun 2026 05:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4XVg4Qb4q9LFFNzW10VQGD/1g8WEMJ5ihE4Wfn9w1
 hc=; b=gc/7lO7PcBnN5nLu80S3jU8LLj90PGWDsQYSm9e4GCrW0Pqxc9g4gak8l
 MnodyFG5JdQuAfA59pGgG1b/AknxVFojUIYPQqbzq1sctS0YWLgYHUz7doWgSyF7
 Hcwc7hu+OBD7KM63t6N470sLWicMHF1LxCxcN6qlI19zt3ekHSOedA+DJ/gRfnlw
 1BRNLb7rjt3xLvlejUdtyGrlNKUQwDxlQ+9kU0vc6KVJr+Qjads8bJaoZggeQcT/
 wqdjoGDEfLk80jnsss+1P4W6ukMW0SSRKW5I4emX8Hl5bK0kZRiBEDcT5VQezZ1h
 uRbJtSXJARfEYY+MTcq/BY9DZ/sRA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f3yhsx25x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 05:26:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHmir1tQ4QevArmeRwlz1tI2gbqPnKyTkqszoAdBPguyZkBjeL0z+pObkjKNa25yxxdgeIfpPXW/8hhJzxF3fLRKQ5WVtTDtPuzRHd48klfh09HOY60Dt4pVcOlbe02Kz7N/cIjlT6nf9psNZf1KoRjPL8tYmxIWFHbhZt112wrhNzwZlsmWGBTXkT49nyY943Ga2IkoDY2O9fLHxYzlr6LUqXUYq30ql6CyIbErYOW+TdGSZRwXZ8n2zyTDLavlwAbVu6uN98dsdFHepENIEHMW/cE2PNsAE/C2w8umoIbR17pL6Xbe4v9SY4tRIafCqiKxMONEn1Ry5LgnADaucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XVg4Qb4q9LFFNzW10VQGD/1g8WEMJ5ihE4Wfn9w1hc=;
 b=k71z+lnmVu8Jh54Sfi8C4EX0iTQEKFUfFEzwBN6L9blM+TBLvi8sQ5s2AHGH2rlXfbzx4ygE1vvhZWG8fJPEXyV8iyUs/WJL4Gr/7E6//RW0jR4eAuxWx+d5PwxWyXIiPLEh94JPfq7rHkeWXUYONWh3r85EhBXkP6K3DAxVIybuiW1db/8BdGAkGm9kSQKvJLXQQONj/jSE10TppSaAqZGfOS8Nwq+1+dk3UJYR56TswkLqkQtppXhRtojNn21PnhpXr2r/UUThZH5miZA6QURxK928xYOZCtNNi6HmqYhhWNqq7HsKhZ7BNuFb6rV5ioPk0kNhwIZd8qqJNPa6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XVg4Qb4q9LFFNzW10VQGD/1g8WEMJ5ihE4Wfn9w1hc=;
 b=MJARFnA1alotSVJpjgiVe+MnOlAx6GdEnhp/yX5ToPYZcyTHH/OytUAzZsAWQJA2/4XRU9ozNppmOgD9fapg3qn9gI+zn4X/zzpQUsoHu6G7Wn0bjURS8f1IvPjS57qK5g0a9V0qD68c4XvgW2dI9qqBYIZaIXkFHPnHMBUL5Xo=
Received: from CY5PR18CA0039.namprd18.prod.outlook.com (2603:10b6:930:13::28)
 by SJ5PPFC802EB2B9.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:26:53 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::2f) by CY5PR18CA0039.outlook.office365.com
 (2603:10b6:930:13::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 10:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 10:26:53 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 05:26:52 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 05:26:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 05:26:52 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65UAQaCN2273511;
 Tue, 30 Jun 2026 05:26:44 -0500
From: Yashas D <y-d@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <tomi.valkeinen@ideasonboard.com>, <dmitry.baryshkov@oss.qualcomm.com>,
 <kees@kernel.org>, <xiqi2@huawei.com>, <r-ravikumar@ti.com>,
 <sjakhade@cadence.com>, <yamonkar@cadence.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <y-d@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <s-jain1@ti.com>, <d-mittal@ti.com>, <b-padhi@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: display/bridge: cdns-mhdp8546: Add no-hpd
 property to the cadence bridge
Date: Tue, 30 Jun 2026 15:56:09 +0530
Message-ID: <20260630102610.1849902-2-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630102610.1849902-1-y-d@ti.com>
References: <20260630102610.1849902-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ5PPFC802EB2B9:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1ce754-1641-4ffa-acbd-08ded6921a7f
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|7416014|921020|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: AiVSJfBxjN6UehyyXpufefNVDgm4+liSPyAqKu3dby9b34zAHx2mfm/EWgVGvRlmAihX/m99pliuZA5iak6cUHpmffOBWHQ4Bjuo8DYxYxGaURYDuy/eYBSS+5IvRYk/MtWqurHrYyu08tZO6e9+Yz8FKnYJNgtlm5uvEPyWS4BYFD7YDmBWW+XIC8Cw9Pa3AnSa5U23dj9e1GiUeUWrtNjWjaQX2TFFjMLF+qw5fQlBJBNLC53AvkmPRB98BrqanEjT/tyVDtnecHv/iGBz/c8bt0oSDYsd/Pk36hqw81H+n5lFG8b4yd3Grlc7n80lPTOFFVxpB0kIyX5f7iB4zRnh8pYCyXml0kzlfA0js4c3fc2NwFcIzzZL/nEF9ctZ/B1mLwyTD5sXuD+ZZSb4WC7hT4Iqk82WDhjJAaJJopgKAhhQWiwlGkEW9rIlpdtik/rcC4tcvHKjOwfx3HmhtwBGfIaVQqGrgBWlUecvafd7lWEkOl6PJxMi7hZj1LRndL3/qDeQVnLz6Xoq0CBCyqfeJ5P5ll+BMRiKWZ4iueob8JF/Qb8BtCELxzL5htmURWYHg2ahgeo9QiLBb76KkQrn7BupKu3T8Z4Ff8ImIGWyabxigsGwjl3NV6Y4I5JWV9o07jeVPxwKZ/3oth7UDrywBZ6jUBDa+Zba3sVPxAFdBQcKdOwbGep67OVjKM3fz1n/qFqgcA2/rCm/SBt9GvoavDwO2FIP6iM4ZA1bmruiEJBH7/fYfDRyOrdWV+bN
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(7416014)(921020)(18002099003)(22082099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+qoCPsUx/2cyJUfFB5Fs/wl6ZIiR/9/YgTPM1JCBmC+Cnm6x/f+lYd834ZtOFehCoJwjV+JJyDo6M+rb8XI/ErYrpsKIYW/Ch8FatvQxfGtV5ug4Hy4UjCEQ1o3HCHfWo6YnSvlB0sDTzwpgUFWDIQXA8p5Z2ZmdwXxdAH5HXED8IlzhPLEBqZYigZBUdcVGeanm8RJjPiEHsa9k+y5Y/3v3jdAaqXBKckcBAKccfEAPSAg+1IF5ckmvO9iomMQA0wecddIQ2Ib7V8YjC5CKQJkrEIFm1W4oT3oYh9dSJ5vIW+Ir3FgYNsCU+KWoe9OR1Gf2Jvaq+iN/ohf2y/YdTkYmBlZoiwCL1z4DkBFSD/ASUeNpgYM9B7D7qTesDUeT72hQ1EKOcGvkwl4I6zLIW1CUlK2y93c6ee9qksjB4GiI8bLMjURsGZt2TwB9TMp
X-Exchange-RoutingPolicyChecked: RdqV+pNPTa7cMEJDnqhv8RnFCt7IJCe0apyMY+SjIGKWle/YI6V2n95FrxzVlbP5JX9erYlEphV8U+cPcHZH2IeBNJQAZVDQLXbE3CWwf+F3B1jLlLpQLSioSypJXLXBjsFPiTK+M22Ebm4HnP5FC4OVzifMvIBdzXEiYOY4yH+GG2sZIzxZOelDexyTv6IqtP4Lwaxw5FLsb/jws6boidVXEuqn3cPfplCf33+X61C1uONWz/M+qYFZFU7vlDhlPOP5rW6mWIls9++8aUHI5dC1GZWHnetYhA/6EJLIcMV3Nb+KfNQEf1wtJ/SOaNqMSNSaxizFMQfKRl4yVujQWQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:26:53.0499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1ce754-1641-4ffa-acbd-08ded6921a7f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC802EB2B9
X-Authority-Analysis: v=2.4 cv=Q+viJY2a c=1 sm=1 tr=0 ts=6a4399f2 cx=c_pps
 a=VYnc1ZjkwFV8r4Zgssgzxg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=EzX1xrUl6JEdRszeJO8A:9
X-Proofpoint-GUID: lG6Pf95Km0CcXSZUTEnxggjMTQgRsU5U
X-Proofpoint-ORIG-GUID: lG6Pf95Km0CcXSZUTEnxggjMTQgRsU5U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfXy8eqRq0t8QBF
 bBhyiF2w8IZvQ9LkSuEu5mjXpm01VZVpoMmty30o84TcDKYT5XsOpCIRnBj5sesE+cSIS8eW9IY
 7BXwCMy1vTdUT1aBD+IXtCzki6Wa8X2prHKv+zMJ9/vu3/T/AOYmXmPeUnjxx5cBWb6/vl/XwZ2
 af2WxBMEz0Zvb7bvrEzvSB1/XJGQqFH8O9jGfkLcHqdgXnMo61SbvLt+mH0rl/0m0cRDhw0jY4f
 0qZX4J7fY59rBw+gq40bJUStFqZ59DeMx+YRvyZN4Dg992oLff5U9MvyhCxoIzwtByj8DcPRKCl
 mgBYObojLs/jhih9OjqEu4hasK7q6e7hfuktpWOqJYOC+k3IltwdXpqXlzelKooVDgJJaasAeOZ
 gvnds/hUWWo3dGjUlShHy35ROQ4qX/J2Cka5Z1lkXnqOXzE2pBk/hKibV2bzOYA+w3PGQ0B8wVt
 6UnnMfXrLwdLzmvpRrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX+3bX2zBWFTzK
 0BHja2bltEyR2X2CeHh7bocA7Ogq1kwpw1HZHA92CSRd0exUIXtn9cWfdL2xBp4DV90uQwGjpjv
 Y+AWm5n+6fkSf/pIvt78shBldKAAgfA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300094
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Yashas D <y-d@ti.com>
---
 .../bindings/display/bridge/cdns,mhdp8546.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
index c2b369456e4e..56ce3f65ff49 100644
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

