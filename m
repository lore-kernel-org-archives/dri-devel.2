Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09279C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CF510EDED;
	Wed,  1 Jul 2026 07:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qVc5S4w8";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eoDINymA";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC66910EC18
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:03:41 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65U9lIdT235867;
 Tue, 30 Jun 2026 05:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=QOvN4MaKm9qYc
 WOmSYrgoCuQJ5a7GAfSVtNykHypN58=; b=qVc5S4w8QUCAm1kuL/r3mnP7aRfBj
 Un7T+yvsco7WjVNISYPcViBzB6Fjj7Oe5B1oD4m3tw8VexZaLniWQpxYkNyjBFyn
 h4aiv1DzJjVP7+bZbYyx9gSOFhtTV6aOKluL/yA1oQ1F25L8kLhnabPAHcMgL204
 FzJlP4V3dgMgAk/wKAdlGn8iyhUaDzDpZePxDPC0KfzjYn3+t/tjzPX4LnhbnSBF
 JnWvoOmaqYl9cVytu6zplJDv3MJRh3R4PgrgiUV+gkM7ktdP6RiU6iVD0jTnQfox
 7jjPOzEQBHqX6sBxYDAweIvQRS4L0WfpqBqhIcsucRdMtS+Eii1a7qs3g==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f3yhsx258-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 05:26:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ1KuJmjAOdJc+PtB7+Qh4anoSJz+06B2Q41kljFv4/O6pOPjyi8UwuGet1Q7CrlFb5kBduVryihKIjJuj4a2V+2hCAOifX8fmGdvY1aql6HZwX0LQSal69IKRVKeI9uL+sw+bSwgBDclDpatXyva+OqloJGOyt3dg5aJcTIUKmf9ANdk1XyxysdKihHXWdWNgdDS1O2LPIHdMa2vZijGwQUm65SBb/31LqdN0HXhonBKgt3ivNUaX5CpzJ7cRQQwniPDsKqhed6AngJ64bmqL+5QQNoCVrf73qYl3U8kSqllUscbtu+xUVgiaWCtBSEJuuEgbBeZ0hRHml0ibpRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOvN4MaKm9qYcWOmSYrgoCuQJ5a7GAfSVtNykHypN58=;
 b=OomEGueGRWcGxyPTQ3JNb75m9U7KArxrWYeRik45DbCtRxbbDGbk01zr306gOZcQb8zrzuZKYSUdI+7lii1A+zXEmZBSP22IsabadqzW1UYbxf5RF2y7PAlXNrff2G3C2M+kIMtDOLeG4Vx/avcpmqYJyB5l6cYyhZc5LiBZmwZRKK1TjwcbHAeg54ZkY9VqbOr8NKTP10TXLQC067dwdMKJqc4nxRXptoTWRDs2DNkuehIeXeyXfiZNsPVVTJmsRWwjG+xAHhN/rIxj1wkIdReYV5xutO/gYCRcuFtaDnCT3uP9Yg2AgzhjSwOBDk29jjKc9Gbvf6Ba2EAhvBXebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOvN4MaKm9qYcWOmSYrgoCuQJ5a7GAfSVtNykHypN58=;
 b=eoDINymA4dojKl8ADmV6s+TUWzlRxU1mNny7fp5NHStg9W7a5HYtF9iqQkDXS/9pOIw1lTLcHbtNVBOyIRtgSEGFrxm8oZE3sVMyyAPYFof258pPepppoLNLpMhSCb3LI9q2oRYC6R/17G7G3GS+wKUQEtRuQohW6ble8KyQ+XQ=
Received: from DS1PR05CA0011.namprd05.prod.outlook.com (2603:10b6:8:457::12)
 by PH7PR10MB6651.namprd10.prod.outlook.com (2603:10b6:510:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:26:47 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:457:cafe::94) by DS1PR05CA0011.outlook.office365.com
 (2603:10b6:8:457::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 10:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 10:26:45 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 05:26:44 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 05:26:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 05:26:44 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65UAQaCM2273511;
 Tue, 30 Jun 2026 05:26:36 -0500
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
Subject: [PATCH v4 0/2] drm: bridge: cdns-mhdp8546: Add support for no-hpd
Date: Tue, 30 Jun 2026 15:56:08 +0530
Message-ID: <20260630102610.1849902-1-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|PH7PR10MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 291e6464-1e45-4b99-8f13-08ded692163e
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|7416014|36860700016|23010399003|6133799003|18002099003|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info: 7URlDBzfk5WfsEtoc45R/Gv8YOYOw8I9DYSnabaGAR+MvdNBhD64EKzBq/7XJ89P3k/fKuk98NaYTYzzXtKUo1I6sSV4yJcTs/lcgHmWUUA0o9uDGQy4Fozs/eNjxfO+UmDFbiU2qD2CMnpYi106PW0xYkzYQJ/q7nnYZpFMQTXRfLYjS0FXeupFLJcMsS3OkIUkjhsSc9l9uKPw4xGIJrX5FNyf/NxSXeSuvz/Ky4KfRzcQE0G//SsSyDv7xZglXPUt4PivW4LKH563R/3p9fw+OKvDTrTybjDAKNjIOChGPhqbvjvwv3MyrHbsRNtPScUI9ahQMnjd3aDNbLD3y4i5BXuOl1OD3S21kPwh6UNpA8N6yrid9RHOqqJapZMhamTDRYTuMaOSVjGDn8ZxUxUOKVVf1pxPzW2Sy/MPvrE8LJKlXcoV1oDVpIRxSJIOoDylShljSbfFxcQhX1Z7H1IgiGqxuFWkrj3rdPCDqFJgbCPOW4gVjDhg3RvyUp+NKD7KXz0IrHalYh4X5WWE8SZFJFziqdk3GVe4IYdNF2unv1c4J/Xr9XV1eN7lTAF5FIcJIf66t3hfSyzY34qNPknFClkxYSCMYi28LdFKdMU4q/Fkq9KBuCO5XuGaAPGeh0fjxS08Y1/cDN2PjcqYVcKwS+H3BcS8GZOjkkbtFLI0JjXqQEudaXclH/pMBo3lhzzST+SDuV82D8EI6Hx+keMMqP5977NVFKqXBgJ4C239fjFPXAt2hnjZgl0leBnS
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700016)(23010399003)(6133799003)(18002099003)(56012099006)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sy4wnAqyx7S2bGSBloOKbcnlFlZrXC/qcY3JanZ2u79EQAIZIyQyNyIieyYGu7qYhVEsClP4MKU1K9I6Qs1VxBpfFXEEXoe8yNSlVlUF/qduV9V260pSknEiqnDFjHZVrAy86JJavDnMjI2TAedhePrbhvLCvBCgcH0k59TKJHuSxuvXmHC9atsAcpcwEE+ZcemP7/GvTwrL0tgy5ezU1iZ3WLDjIuOLU/hedRxauXGfFkeyM/KyrTllul9kmomU6Wd8z4i/sn/8S5lgHPgjq8wmvk9g15lvdjRYbVR2ZDFKpooHR7RGZ6kZ99xFYS9B/kmLxXvRu10eiUdcQerl/EoUn0SYSQ2ZB9Sv3ONCO6Y3Z4v4CnrtLr3v0+Eq4CTiXrWBLvHDl2wrkV9qvnW5iC128D2BZllREnbvENdhG00UzVSv45alWS11n4dABhl2
X-Exchange-RoutingPolicyChecked: VitDMAnyHqGYvPrJ+Mn2o7BwV+UoFg08+msK5nr3uPMzObd3IMQcrjzx9jfM44dY6ZIM9jcQpuTGIHgk1nrOxNG2I7fZzQsuKZKWIpNAYDgiE7vfoz4kQGEVLVByBa9rfaGrKDsda52uHtCD78Oz/vDVca+xNFCaC0mWTcec4I6Kmfeej4KkQlywFm2+Ym7oVQDucjVhISyb5bOJpOMjuFa+h9P2QI60Hq6xQNUk/yZPofz1PjVXa5JesjWuWHFq5IkiR7VhP0Bnv19IFq4BIYQXnn4pT6gI6/DxDO7H55YyedSxTndZLSeO6GIR1Pz4Az9Wg9irrUZPzlYkw+T0qA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:26:45.8911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291e6464-1e45-4b99-8f13-08ded692163e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6651
X-Authority-Analysis: v=2.4 cv=Q+viJY2a c=1 sm=1 tr=0 ts=6a4399eb cx=c_pps
 a=M0SbpEVZuc+hi5PQWquR3w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=XmebuRCEXRnHvRW6EeIA:9
X-Proofpoint-GUID: s2b2YCu_7z34el3ChSAC0SioHJ0UERgW
X-Proofpoint-ORIG-GUID: s2b2YCu_7z34el3ChSAC0SioHJ0UERgW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX0Xz8XBSQHH4W
 SQqRAtLrKGEdFOo2QFUCP4n8Fxq8YPb0wyZMhz5X81YB9EkbAqRVoFrGwamiHDVTcQJeRd90zBO
 9npOvAsZVuJv4wkPpA+yK2NWooq+smEqgUael1hVqMcZ8bZTbTCPOVVsO+ocRdKle4Jlj8Isk/n
 9yfmYmyCjc/1ip6GSUsvt+pITSaSg525VKofgi9Jec6V/e4h3z+RAtfeEcLobt4l0RyHBKgt1qe
 VaahlLq2MKjn8N22cbjDWXmQYX/9Etnpl1fEYqGRsqSvZszr3zJ4tS44Mxbga2d0u8crnMPZ2gx
 rLxz/jpOeHUmMCLQIl1WN8Mv+b8t3QU7clypROMs1oKbiXt8ZM0FdoXixddZMdiAQvrZNVL6FB/
 L1GMh0TukhUcTwiICQmn8dkwZiwSN5ur/RtLBQxX0gM7po/TAOFw+6f6jUZA8doy1IpY5EsVWmR
 c1BSB6U7FDv0dYFH0/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX0j9ZN+Zi6fPj
 MQ0aUqVcLMn6HkFIicRSJFjhPORTUovB/xoI+eEPfm+OH7oUsrFGtKq4Y5gfA0dj48zYDzL04Nq
 vT1jbxaMLB353yQQeEZJLuuuyS77m90=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0 adultscore=0
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

This series adds 'no-hpd' device tree property support to the Cadence
MHDP8546 bridge driver for boards where the HPD line cannot be used for
hotplug detection.

On TI J721S2 EVMs, the HPD signal is routed to SoC pin AA24
(MCASP1_ACLKX/DP0_HPD). This pin is muxed with the McASP1 audio bit
clock; selecting DP0_HPD breaks audio. There is no alternative pin
carrying the HPD signal which makes it impossible to use HPD
without loosing the audio capabilities.

When 'no-hpd' is set, DRM_BRIDGE_OP_HPD is omitted so the framework
falls back to polling .detect() every ~10 seconds. Monitor presence is
determined via AUX DPCD reads instead of firmware HPD status registers.
The .detect() callback drives cdns_mhdp_update_link_status() on each
poll to keep mhdp->plugged current. At attach time, the driver waits
for firmware to be ready before performing the initial AUX poll since
no interrupt will trigger it.

Changes since v3:
  - DPCD read log level is now dev_dbg only in no-hpd path; HPD path
    keeps dev_err 
  - Added blank line and code comment in cdns_mhdp_attach()
  - Property name changed to 'no-hpd' without vendor prefix
  - Cleaned up the manual polling in detect since the framework
    already does it when OP_HPD is disabled
  - HPD detection and notification to userspace and drm clients 
    now happen through the framework callbacks

Link to v3: https://lore.kernel.org/all/20250205115025.3133487-1-h-shenoy@ti.com/

Rahul T R (2):
  dt-bindings: display/bridge: cdns-mhdp8546: Add no-hpd property to the
    cadence bridge
  drm: bridge: cdns-mhdp8546: Add no-hpd property

 .../display/bridge/cdns,mhdp8546.yaml         | 11 ++++
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 58 ++++++++++++++++---
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 3 files changed, 63 insertions(+), 7 deletions(-)

-- 
2.34.1

