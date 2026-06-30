Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CD4C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491D510EDFB;
	Wed,  1 Jul 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A0lXubmR";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YMABGubg";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5BA10EC33
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:47:24 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9lGer504311; Tue, 30 Jun 2026 05:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=C52qNjj2SUvlVrZOeYyt09dchcMeUnBdp7EThteod
 m0=; b=A0lXubmRN84FNBqqJBqI1LiMKrnCDaQ3MBN7oyS/B7MgmGO4d40iXq0YQ
 FZFCS9oCw1OCY+hjkp1gjjXBSUmb7BliBXEUkwTG1t756Lh39gnk8Y+IAAH/nw1L
 kw/cc8AbCh2WzGzrdX4dKLMKqyJWIvUZDI3wKsls+9tfBtYNV4FPrDpgOusKgxWx
 rOTUbg5SVJMTmwfc4Di0Xx+IHc7dz4oZPho7tPmJa2ndVKEdaa1EBSy72sk8LLaJ
 3DDzarHBVgH+viSZQKaBm5KZLA/r2xzvlgzVz/GawdXhaC3TFth/RlEOxm5ZgohO
 HDGeR5XRUM7SV9ljMavk5Pdvb9nvA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f47k79h82-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 05:27:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXeEoV5emeD7WTWBttED9op7ejyQfFj8G1VIg6x4vu/i5HWYfmryArTyaWXeokvDuDgvTgvh9cgD1Br1XV/DZLhgivdq2KrbA+6LuK1f+UzDGLxYI5d/kqQgbtTk3OAwvMXdrJYNhoHi8uQ45j1rZYqMB/Jm/cVfbNtdEGM+geonXJq646Db5MBpW+fTP3Gsu5N3mL8TwZeh45qX5K4gSF/yVjIb0zT6duBe3LojrYErLVH24M2o4lcynU/fyEU/SzxmYevEJOtHrIajwKLrTT4+iPJa/J9kNmMIZpfBNySDA6Ave47cF4sQn7DXKQr4rPR2+5QFm1+MooxIVAGtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C52qNjj2SUvlVrZOeYyt09dchcMeUnBdp7EThteodm0=;
 b=eTUxVkqF7xJ8YmRPuaRvE8seLskBQgIjI4Q59i4M4ogyXKVgxI28vP6yPAcq3h0Gm61hb0s43JLYOVrrAq/X56Z8mx4uxqEAGKbkLqsCXS8GAQM46EZLjfuz/QlQeCuStjc9C692M288KaBtzUtF+e4dcTYgM5ZohHcGcwjBdM619oKq9Vs0uOlfwtFeUw2exkShN+53aI8hcVM8ZiliuS8zIdWfutOWM3b0L/Db3ZiVOv8WhwiJBQcie8CNuSCV+NJVYZt3z63N+fStm0OevqUrziKiKzywd5MmmUxRpyOXqJNbQSYbhwtBcMzjphULj8lysjtkWW8njVbCilzkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C52qNjj2SUvlVrZOeYyt09dchcMeUnBdp7EThteodm0=;
 b=YMABGubgq3DOPl3gWfsCGq25zdP1q0nLoeRTk83bfyD6KNn7CWly0gBgclZ39lzZlbHXu8B4BI5sybNC9MQ7vpj3/3kryfr1Bu8HdII0UYMwNPGlm9w0iLhi91TtWGeIjkZdQMVbpMiN+JShLsOTY86mwS23Rd52Y7GxgFTsFwU=
Received: from CYZPR05CA0006.namprd05.prod.outlook.com (2603:10b6:930:89::10)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 10:27:01 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::2) by CYZPR05CA0006.outlook.office365.com
 (2603:10b6:930:89::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 10:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 10:27:01 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 05:27:00 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 05:27:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 05:27:00 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65UAQaCO2273511;
 Tue, 30 Jun 2026 05:26:52 -0500
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
Subject: [PATCH v4 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
Date: Tue, 30 Jun 2026 15:56:10 +0530
Message-ID: <20260630102610.1849902-3-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630102610.1849902-1-y-d@ti.com>
References: <20260630102610.1849902-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5c3297-17f8-449a-2599-08ded6921f44
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|18002099003|22082099003|3023799007|56012099006|921020;
X-Microsoft-Antispam-Message-Info: OLPQfbOtINlDo+/eziWkyuR5yj1S2tvNKwguKXHuABW3Sn4+5K2OasCBQ7xWuE+XbdeVyFbp6zE3HmBGzdJYMPVqANSfEYsUz6peyJ08tIGexsOih15ROtpgA0Eu4QVfQCRnjtlyDEW8kaQirgvd0Z7lozCP/W06eCoQlj+/QAA0XMsB6KvPxPSYQaq1lrRnCT8Fc0FNubJoGD0NIrslD87C9k9oZVHQ0/cOFrIWaMm8MbsVKHzQuhhkZkuD+ZWsszDvjzCrHtHPtai2hEx27QSkixq3eolqI6dBUolIGfyN/Z2fKjTyVt0cTh7d10LHzDJ4/22ps0L1F9B0SrGdZOhwQLVTj7BgHbJ1zQPt3JqSmqEpM4Z8MP6Xf/TzK/+brNuTSfc+cru8+MV6wADJWkSO6LWJLDh2g8WSzfVUX9FucRfD7gMCvBthWN7Blbvcp7TFfciBT0KVl+H6yXGfHxcYl5FlU5X4rWx1kCBADh4/GJzmSzHsd6JbN4hezVkjJHUjmxfDpyP/amY/eLIngvQ8NvH7lm0pZ54lSLa7IOWXsQ5sb3j5tfR/F+YpAj0oQT0AymLW2zTHbug7GLvdNhmmHhueOQP04JGTVm8+zVrdbzq755TM9ozE9U6uQaLLhD7i1vTf6/ztWiKw1S4KLQtZAr+M1FJFLqkFfq/Ne3SXVvO+H1kfar5e5llUABfvOgEj1PDmDeaKDeBrOxsiDhnry6BpvzepS+Pw0YpKMug=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 81HpQXThhMcl1l0UVMx+UA4Yme7Xri6bI0/FvgtuYGeYPni9IAD25YBWAm9+7qmoOruoBkiiepfnculCFRHwBs1AGpnvc3HPJibLLs3s3j4fC4uHfM2BX4mF/6a1aWwOIPvvDt/9HvAaI4C8HELAcRgf4ZERrLujr8fQ6zdY694JnLMEqINPxKxvnxdK3YbB9ZzNieTNTEmWyqrGGrp0Tf+lFvYRPyjquZ/SdJDCbSE+nHJyISCRLjRonjSixeZTeaOANRu+Bs3vPBd5W7St/n8zlqDUIajjn+LTMP+Ifow4mblzTLAU+czhG+RkDT4mwesoK7YZVIncLKrqTCDNHhJAfMSTsLodkqAb7jhjnRan4PpsyOtVZ60ZTJk3LziqM/rLWWnaH4Dp7tgY/FnlSCU8wjJPcs4RI3vJbn2rKjG1PSct63xRU77zsnmEYsjj
X-Exchange-RoutingPolicyChecked: dH1+vg+kyXp5KDwBMAvuMsUeX89830V0hT1yDWvXRHHNCS/2cP8rDAUD323nX22Pa6+mXvpyT3K2zo5Wfct1AABFYv61YBBgPeu0+XOACdFb9ZyoobPszycY1JQUl74xso1B6AixrJBgWl4fvh61tmousNOllreniTug23Qka0CMKAcc+Jrw2ObApCiNYYzG0OKxODi+JJ+xbTIdqcER3n7zzZDGkwHyXtaGnAt5r6EeaGxsChkjRL3iQST439T9lHjtQZhaOxOnw+P9vJ9HQtNALwbg0J80UASidBBgYiJe+SAaf6GMN193wD0R3vbZ6pN+JYPkZlzMDk6LOxQ7Jg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:27:01.0532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5c3297-17f8-449a-2599-08ded6921f44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-GUID: pm1LQhZzae8lt4NOlRQXMlV25ARCtLX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX7qTcuQUEw5Jp
 wq+ffJzuwg4+D0A85XCSpK4MpMFJe8a8z1XCY9xmdQ10WcawnWoX77NpuTFGXYymLc2l7pgmRo+
 cICQJG9sFwxRGx15XR1sBseIvdHgQqyJvdQGSmHVibIebidm3GRBgo2oh6RxNQEqjXYbaCqNRBY
 sUA6Pc+F1z4v/lePSyVERF/GjwMjIhHxeTPtNKzg+TmMwl2egZM+uLLCY4RgQX8PGwrvs69VtiF
 BE6c7ax5rFfeofMFrFJBDB4jYUjWLLfvlsYC+Jwfy2QhAk4/gJakMaaSqNMSmMlUNrO4nK3YQzW
 Yb6D2WfASa9TP3QNtCl+fAydyLXJtBfSYuf3RI+eW18GDZboA+RgzM6+U9GVLYZYkdpKhhmZQUM
 4Rvhg+udxPGjgIDO3G6FW8FNjs4tOcn0kh+Y10vquGqevooEn+j2+b0W4XT9R7jq2fgMONcxKqh
 9S81s12EHK8pE2fUpsg==
X-Authority-Analysis: v=2.4 cv=UshT8ewB c=1 sm=1 tr=0 ts=6a4399f8 cx=c_pps
 a=1s4lD5itHyb3CJ4oxNoLhg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=Wp13WBNl3t4apYASe7MA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX5PKArICAz1QJ
 0eov4m4+UBunSl8NNcuy6xtsSa9u+xqNPGAmjkuHIs2W1+i7Ia/VOiXbj4D6T2rS164has9dMZx
 vZEzDBj2cWR2B1P79ujABwQzBfFvAHQ=
X-Proofpoint-ORIG-GUID: pm1LQhZzae8lt4NOlRQXMlV25ARCtLX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 bulkscore=0 malwarescore=0
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

Add a 'no-hpd' boolean property to support boards where the HPD line
cannot be used for hotplug detection due to hardware limitations.

On TI J721S2 EVMs, the DP0 HPD signal has a MUX conflict with audio
functionality. While the HPD pin is physically connected to GPIO0_18,
routing it to the SoC requires sacrificing audio capability due to pin
muxing constraints. This board-level hardware limitation necessitates
an alternative detection mechanism.

When this property is set, the driver uses auxiliary channel (AUX) DPCD
reads to detect monitor presence instead of hardware HPD signals. The
DRM framework polls the connection status via the .detect() callback,
providing hotplug detection without requiring the HPD pin.

Valid use cases:
- HPD pin not routed to connector on PCB
- HPD signal muxed with another function (e.g., audio) on SoC
- Hardware designs where HPD cannot reliably detect monitor presence

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
Signed-off-by: Yashas D <y-d@ti.com>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 58 ++++++++++++++++---
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 36c07b71fe04..5e1bad8fc73e 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -53,6 +53,8 @@
 #include "cdns-mhdp8546-hdcp.h"
 #include "cdns-mhdp8546-j721e.h"
 
+static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp);
+
 static void cdns_mhdp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
@@ -698,7 +700,9 @@ static int cdns_mhdp_fw_activate(const struct firmware *fw,
 	 * MHDP_HW_STOPPED happens only due to driver removal when
 	 * bridge should already be detached.
 	 */
-	cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
+
+	if (!mhdp->no_hpd)
+		cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
 
 	spin_unlock(&mhdp->start_lock);
 
@@ -788,9 +792,14 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
 					  msg->buffer, msg->size);
 		if (ret) {
-			dev_dbg(mhdp->dev,
-				"Failed to read DPCD addr %u\n",
-				msg->address);
+			if (mhdp->no_hpd)
+				dev_dbg(mhdp->dev,
+					"Failed to read DPCD addr %u\n",
+					msg->address);
+			else
+				dev_err(mhdp->dev,
+					"Failed to read DPCD addr %u\n",
+					msg->address);
 
 			return ret;
 		}
@@ -1523,6 +1532,26 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 
 	spin_unlock(&mhdp->start_lock);
 
+	if (mhdp->no_hpd) {
+		/*
+		 * In no-hpd mode there is no interrupt to signal firmware
+		 * readiness. The firmware loads asynchronously after probe(),
+		 * so we must wait here until the uCPU is running before
+		 * attempting the first AUX channel poll for monitor presence.
+		 */
+		ret = wait_event_timeout(mhdp->fw_load_wq,
+					 mhdp->hw_state == MHDP_HW_READY,
+					 msecs_to_jiffies(100));
+		if (ret == 0) {
+			dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
+				__func__);
+			return -ETIMEDOUT;
+		}
+
+		cdns_mhdp_update_link_status(mhdp);
+		return 0;
+	}
+
 	/* Enable SW event interrupts */
 	if (hw_ready)
 		cdns_mhdp_bridge_hpd_enable(bridge);
@@ -2013,6 +2042,9 @@ cdns_mhdp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connect
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 
+	if (mhdp->no_hpd)
+		cdns_mhdp_update_link_status(mhdp);
+
 	return cdns_mhdp_detect(mhdp);
 }
 
@@ -2100,7 +2132,16 @@ static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp)
 
 	mutex_lock(&mhdp->link_mutex);
 
-	mhdp->plugged = cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
+	if (mhdp->no_hpd) {
+		ret = drm_dp_dpcd_read_link_status(&mhdp->aux, status);
+		hpd_pulse = false;
+		if (ret < 0)
+			mhdp->plugged = false;
+		else
+			mhdp->plugged = true;
+	} else {
+		mhdp->plugged = cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
+	}
 
 	if (!mhdp->plugged) {
 		cdns_mhdp_link_down(mhdp);
@@ -2288,6 +2329,8 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	mhdp->aux.dev = dev;
 	mhdp->aux.transfer = cdns_mhdp_transfer;
 
+	mhdp->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
+
 	mhdp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mhdp->regs)) {
 		dev_err(dev, "Failed to get memory resource\n");
@@ -2360,8 +2403,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	mhdp->display_fmt.bpc = 8;
 
 	mhdp->bridge.of_node = pdev->dev.of_node;
-	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
-			   DRM_BRIDGE_OP_HPD;
+	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	if (!mhdp->no_hpd)
+		mhdp->bridge.ops |= DRM_BRIDGE_OP_HPD;
 	mhdp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
 	ret = phy_init(mhdp->phy);
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
index b53335b0d22c..24ffb732a207 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
@@ -388,6 +388,7 @@ struct cdns_mhdp_device {
 
 	bool link_up;
 	bool plugged;
+	bool no_hpd;
 
 	/*
 	 * "start_lock" protects the access to bridge_attached and
-- 
2.34.1

