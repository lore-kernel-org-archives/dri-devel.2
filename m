Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5145CC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B0310F915;
	Fri, 25 Sep 2026 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AtlCP5Xp";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p5Nt1Hi3";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC79310E586;
 Fri, 25 Sep 2026 06:57:30 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68P4ac0g1382243;
 Fri, 25 Sep 2026 01:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=BvZW+U+XdOfBs
 rS/WWP9QwqovFjaa4eWmq3hosy744Q=; b=AtlCP5Xpckohzr6Kdr74MfDL3oI4C
 wTgsBdSFfWo5+sjEbfRCCDkSMo8B6YXzIgrH0MIqIbQZY5VDUvgSNe8hEhB2X6ca
 r/OsdDdImwDxDLV/6jOCPeu2HAHvhbqJcOLdb3qzLkRyweiBsXyPAfxieRLMjleo
 3mWhWpKnlWmwKI/ab0/IpLmRTe8HYIW+QfREwZWcglkgbwpfaHID8YMAY8Y6mITK
 gKm8aILEMFtSWqQ4YBFR1fUe/cnlqhU2EVRazF42T1PcT8RYqy7/n1hw1Yf0X90W
 sLnO4Tb3CxUZjh4F2RlXbWZ5FKczWHpuonc5eZgXmgOvoh9C00isso2qQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gw13rf09k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:57:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrYaZs5gDH8WyuE4mAexykGW4RNkixdN37Ve+1DifXh3dmWXXxXioAerAWFmrNrGS119zVhFmSlm4q9SETIKfRUucjh5cu4PzpCnDQyETncCnVrOYYxLmROBbu8ITATMwg/F9Bdyf6+RmnWtZUBPdJQUeHCC1XL/LQNCDm/ln9rnBdjMFohiLX17qgV2Rb7kumF76P7xH4x+HPObRmkFB7gmnRDxuCpp1EatDOC8ocPYAP8sgrzeStl+vGTwozdS6Xf3RdZFsjKlFl8qIUAMRM1w4LeF2/k9mU55nR7UTZ7USd8KiMe89O1j2QZvZhigS9+tYFvcSIgkx1Ivfh+VPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvZW+U+XdOfBsrS/WWP9QwqovFjaa4eWmq3hosy744Q=;
 b=cSbRPI0yFHMe9UjHkhd1N2+BkYxXRXur3UpRG11j2BlUN7mhPspbOJDjCvnG5dN1bY2SO2ovVtvjdYHQLR61eZGHoLK/bnqi48zedrWXuwTipA8+RV/kwAvOGCXrj5BrptU8e/Rw5tELJKCYGZHOHxw5N7rdNJjMddaHvvOSFGfiHP4Ar5u0N4gKfwHzKA5bI1tzfhWwpqvmG29LwzG2GUFT5OR3w4abtf3uWtcLi1oC3OHCEcX5wPwNgrSWXCmbzDt5g9sKO1y5CN3+mocdWWO6VzPo90fF6MKtKHf5pLu1fLNKaQ0CskaOv5HQygZQf8ZpPA/vSaEsDQOBtKn4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvZW+U+XdOfBsrS/WWP9QwqovFjaa4eWmq3hosy744Q=;
 b=p5Nt1Hi3WtVaPvPIxJ/nOwThoUdC5dAVqCAnUjvdvv1MOEPcj+revfgGPag6K/pC4LTOg3ak1PeYWs/DEDPe0ZXsm70wtweT3y3uDVsCg6zGNvBuYnTuPCZ4z5rSBNwxqoR2WIdWXO9r8Pu8faxIyNhKRmmBzDrpA3COmong7ew=
Received: from PH7P220CA0075.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::11)
 by IA1PR10MB115880.namprd10.prod.outlook.com (2603:10b6:208:5a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 25 Sep
 2026 06:57:17 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::7c) by PH7P220CA0075.outlook.office365.com
 (2603:10b6:510:32c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:57:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.5 via Frontend Transport; Fri, 25 Sep 2026 06:57:15 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 01:56:42 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 01:56:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 01:56:42 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68P6uZ1I1371804;
 Fri, 25 Sep 2026 01:56:36 -0500
From: Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
Date: Fri, 25 Sep 2026 12:26:27 +0530
Message-ID: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABsbtmoC/32NsQ7CIBRFf6VhFgO0QHHyP4xDoQ/7htoGkGia/
 ru0g3Ewjucm59yFRAgIkZyqhQTIGHG6F6gPFXFDd78Bxb4wEUwoZrihqe9kQx9zTAG6kaJwtGd
 Oac+VbbwjRZwDeHzu0cu18IAxTeG1f2S+rX9zmVNGLbPGa22Bt/ac8OimkWytLL58IX/6ovhCc
 d1KkG1j6o+/rusb7ZxiLPEAAAA=
X-Change-ID: 20260919-tda54-upstream-i2c-d0c67f16b4fc
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Nirujogi Pratap
 <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
 <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
 <Ritwick.Sharma@arm.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Aniket Limaye <a-limaye@ti.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|IA1PR10MB115880:EE_
X-MS-Office365-Filtering-Correlation-Id: 826841c8-473a-4a1d-2e35-08df1ad23ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|10067099003|6133799003|56012099006|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info: 3uQBAudgS6qalflhghWJSDuxpBpMRcVibYwraRQthw9Hqu6Wff1FoP8paP385He67zPNVaA/JZRuyz8D/5HLUq5adJTDV4QS66nv3cG5qTYkKSIuoSGWZmqzvIwSfZthTN2178HP46C4slzCfb2Y0PdBBUzsZCa4oCrNeR5urVJB+XgZ2MWThc/NHTSPTNujjOFYxJwUCGBKCdEhoHiRoHlIC75S7GGiud+VOK1XL/aG6JC1fdfZJXk1bq8sm71Pul3pIsg7iUh5rnHYPV7/yxbTfAInPnI29AW3MHgsEarDt0HRRZI2Drpp5nls3DW3+jg/LmU0+QS8Y7jzvLJRs1xgFi1cdNq8ojB2HuIWnQtdeqTK61bFHR96kEgMArkH0Knt+Uj+BNavbJ7OKFgzrT1OLYEHIwzgBMN6RjK/pGycoX95PdCPuBhyu/kW8E/S2m8sFeTvj9qtO8MgFln1N5WNDLogOx+FeQe3zsdPvaifmCMeyfYZe7EMs49HRVZMekh0oTkQc+OXqqFIFsh0LgtNnFvUx3pV7qMcbEkYhhG/eZI+o7xNw5ekTtLUk608Js6ajybGd9oTg0nP0aDTKWglKDy5N3ArvNtjlpxhYLsQyE5TxzLI6NRbycXjUXA1HOj4jGIN0jlh4cY1yCD7stPRbXbJI9NC4CTqNm7XMvLDhjZRLCiE0YQXSlcZXQdVZVwzFgzDeRD7yqXwTeT/d7043vOv5CQFEwybYwwL799E0mb21R/7A4adMoHJCfBy
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(6133799003)(56012099006)(18002099003)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KQ1nKn7Oo4o/qPz6a9FJEGcj6+pATdBLTBz3KZKUrAkVKqFWGwR3Do3YFjPD6TMIjcC3DOubyinzM65H+Mu+pqcSO1+4IXMSzKzjwLPZ8f9TiB5Mz8MtCEQTNIWvyBFq/7f2nGtI9WncNuSOvZqs1wfRZurEkQzQLHy+dkJTK/2bDuyBnilj0BFaIqr/EAseqPbGMn8qtJ0ZLOkJ5L0XI8ZdNXlgZVefGM9+Xw6bP/kDErjTdOlxsE7G9taBz+DicnuQUDEgTyB72f9TP6htAcSetlmtWlIHXbNFApiWPtxZySTGe9wm2ktKJXJ2Z7qi3Yh+io4Y+kFGDo0z657SY0glMLWY8T4eZ4j6DyqpfN6WWDoUQYcbpsUmMen10bbZFnKJfAoLJ+5fG9cgMMtcs9Oz+e0x9+DZGMWCGiIlE9FUWOiruNmaCaOEi4mKMjnq
X-Exchange-RoutingPolicyChecked: JF/9ASFl0pYntrdPVjrKbrYi02StW1du4aBaWBbC2LG3YThv0eByQ/WgK7/n+DQ8DZr57LeUw+XI20VvNfm09BV5jPQkXA3op4CW3senV6qyZi0MT70+G+OdTi1MMmelsrE9HZWkqPHjIAk5j9pMRBY20/mJOxTajcEcsipx00kSSuEBW6l4cmXDuyxD3f8eE5PqIyNp39yF7mRSN5INMucpX824AKrgyaaHKclgoHx2FGsrGDPUeri5GEiwI8W04CijjbCsrm1VCecen6VsYAiimAJrET15avQVPaCzFJoaeL36LCLAP2vj2qcUmXhzLwV78+DFxOFvn80dm3+A8g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:57:15.4622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826841c8-473a-4a1d-2e35-08df1ad23ba4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB115880
X-Proofpoint-ORIG-GUID: JeRQIfILRJZQKSN3hUBLw-hHT5sZs_lv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX+JQ3Mm0wyVio
 hcYa+1QNK218Szsv5AapRoXt8KFZMOxjKa6TeyVwpmzwvb6Ye31BiFdahoxXRleRRz0FkAQRYWx
 WXgLLTOu/g2OcYvUCtTfzA3fRGJ10PPZBxDfnDrqi8itP8YQeoCL2oz08ZHx9ex9WIpl0D+i/gd
 R3yovHtogQRg/Y+GKcJv+BYsLDkhfDTdPvk8STGikmpmikgwnRKFqV5OS5PX6gRGDhrV7FFI6sK
 y/LsbNXuEmI4TzJz5papFBxUSybUSsdkZo387Vy2RVPPZiquU3VEFtzRMvjGbsht5QjpWPHlFjo
 9IjTtORLF0FPlq55T6rKNj7HjcPVZY8y1rBDSELbIbSoJrmy/Ev2H5SG3bF/fdQ2nP0k0kn9ch9
 K56eQ3MJh86G1dEA72kSvhVm1XKM9DrW3Tjx6OXZGmTnAyJ/fH++lyMqzOJLoqyjjwRDgkPgY1D
 53SWq6I0PaKQwyZymVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfXy2vn34CKK03C
 taxzG6B4jX4bjxUjXiu5H9iiMp7Gm75VOhM5oUNH3JI6aKN/lVibDYqzxzoWip2MMD5xOHWgYLr
 UyiPWQEtlJpsFn9uxbOJ47uzIjCLWMY=
X-Authority-Analysis: v=2.4 cv=OICyTiaB c=1 sm=1 tr=0 ts=6ab61b50 cx=c_pps
 a=KTjCFeyF3Vp3atYHcTGfzw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=di3ura9MPRWK6PFUWBwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JeRQIfILRJZQKSN3hUBLw-hHT5sZs_lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250027
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

Add new compatible and update driver to support Synopsys Advanced I2C
Controller (DWC_i2c [0]) present on TI TDA54 SoC. This is needed since
this controller differs from the existing designware i2c (DW_apb_i2c
[1]) in its register offsets and some register definitions.

The new compatible updates driver logic due to changes in register
definitions:

- The new register offsets are handled by first refactoring the driver
  to use a map of register IDs to their offsets.
- Similarly, also update the driver to use an updated CON-register
  bitfield definition.
- Interrupts are acknowledged by writing a bitmask to a single CLR_INTR
  register instead of reading N dedicated CLR_* registers;
  i2c_dw_ack_intr() picks the right method based on dev->flags.
- One HCNT/LCNT register pair is shared between standard and fast speed
  instead of having one pair each; i2c_dw_write_timings() writes
  whichever value set matches the configured speed.
- No COMP_PARAM_1 register, so FIFO depth and high-speed-mode support
  can't be autodetected: FIFO depth now comes from the required
  snps,tx-fifo-depth/snps,rx-fifo-depth DT properties, and the
  high-speed capability check is skipped.
- No defined CON.RESTART_EN bit; treat it as always set.
- TDA54 SoC does not support SMBus, so skip accesses to those registers.

[0]: DWC_i2c_reference.pdf
[1]: DW_apb_i2c_databook.pdf

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
Changes in v3:
- [PATCH 2/3] Revert to special handling for the max_register in regmap
  for MODEL_AMD_NAVI_GPU instead of unconditionally including
  AMD_UCSI_INTR_REG in the legal regmap range. (sashiko)
- Link to v2: https://lore.kernel.org/r/20260925-tda54-upstream-i2c-v2-0-261785e58493@ti.com

Changes in v2:
- Rename compatible/flag: snps,dwc-i2c -> ti,tda54-i2c,
  MODEL_DWC_I2C -> MODEL_TI_TDA54.
- Move the Reg ID -> Offset mapping inside the regmap functions such
  that existing calls to reg_read/write are unaltered. This does change
  the reg_read()/reg_write() functions to take reg IDs as input rather
  than their physical offsets, which also requires updates to the
  xe_i2c.c driver to handle the same mapping.
- Remove i2c_dwc_has_smbus(); just skip the SMBUS_INTR_MASK write under
  MODEL_TI_TDA54.
- Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com

---
Aniket Limaye (3):
      dt-bindings: i2c: dw: Add ti,tda54-i2c compatible
      i2c: designware: Support per-variant reg/bit offsets and intr handling
      i2c: designware: Add ti,tda54-i2c support

 .../bindings/i2c/snps,designware-i2c.yaml          |  33 ++++
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h              |   3 +-
 drivers/i2c/busses/i2c-designware-amdisp.c         |   1 +
 drivers/i2c/busses/i2c-designware-common.c         | 193 ++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h           |  70 +++++++-
 drivers/i2c/busses/i2c-designware-master.c         |  78 +++++----
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   2 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |   3 +
 drivers/i2c/busses/i2c-designware-slave.c          |  26 +--
 include/linux/designware_i2c.h                     | 137 ++++++++++-----
 10 files changed, 432 insertions(+), 114 deletions(-)
---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260919-tda54-upstream-i2c-d0c67f16b4fc

Best regards,
-- 
Aniket Limaye <a-limaye@ti.com>

