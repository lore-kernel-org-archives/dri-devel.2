Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2091DC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5109F10E86C;
	Mon, 21 Sep 2026 15:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GmTP9FK7";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="srjIvMUX";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92A510E86C
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:39:23 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8Z8b3932523; Mon, 21 Sep 2026 10:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=vUgQoNltn9KdHkZgzshNia3+DADynVdIxxjqDQdqI
 A8=; b=GmTP9FK7Kb9iU6JwWf6RNxdxvTd9QUIZwFrUKVc8AISSZQZ0G8qvifKl6
 Xc4Tdg1yFB0+XPETPdbuqe0EdDzikTBYcC9Cuj0Hnr7Yi8AOcTcDO4RnKobFJgtr
 cQOWww+7CesmLjHH2fPXaLXkmRqppPLFrlLAIrYe/PX8iLyA6BjzvCWkRKNz3yjL
 RibUzMnriFrPo20U/YjLrEGluQZqx0MF14A9RYyJ3F2WAJE6iBTABpE43kOPRQ6+
 UYcbpTGswZ/li82Jiqkfud/G63QMRq4scUF8u1Yw8CjmWCWueTJmjdLdyC7lNwoT
 1yjzI0UVik4cqls1TdI3lRBPiXTQA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gtx9fbe1s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 10:39:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4nCqPwTXlchjtwk/18aJ3FiaveKCZp+78VRq0S6du+2mrPHjsXc5Ka00yGZPG6mDKI4ti/pRUf/s00BPWoXtUOyl9oejMNIt/2Z6FinXnhBJAeVPQYi7Offb9yQ+PXtFcqu/EAnEw1tdlRUa3yHeWS58TSEMY7kdO5yx7Zco+ueICfpCK/KQBTPzBKB0ibkdUPH3oHTZ+va7mEMDVHwGLQGnnYH5qmgX0gEyNlEdJW0hn9vnd/kIIQbFvIT+w3pgb/BKkQKhMJxpiTlcGqLe3nDZWcbl6QGcBlCclLjjpnRkp+7Tvrl11pZJaVn9B+QKj3c23t9Hi1d17k/XouqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUgQoNltn9KdHkZgzshNia3+DADynVdIxxjqDQdqIA8=;
 b=R3p1C1iEebFruKTM7nPcyuflvOQxhHpTVpe953kqMKcCbn8ZZeFx9qCwgw8CP/LkBm0Y/ArogXp5qkLlfYtk721dFaV4ErZBJ1Oe/iOVAWmOm3eIF0lLMG2UvDlFTyMG7VLRz0y+lxBEtCU4Vbrw27hzcFU9jRLvV24POjX0FvGOcV/3Ruzp5BoQn7keD8pyAOmdEopgkE9VLAkdRThfgpu1vQJKnd71fTY5CSlfUO3pmHY7+8iWpClYnNMx9k07TXypxhjnh72D3/eCqu7t1CyH36FHZsGmGg27aUjsQ9Z1f0RuPcoQ3X6WcvaG87CfXKOPk0i+MhWS5VY8CI0hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUgQoNltn9KdHkZgzshNia3+DADynVdIxxjqDQdqIA8=;
 b=srjIvMUXlZPKJD7mSrE36mZZ10dCA/H7S1cL9BG2w1YNIJc1VdDT0sKmq7OftCJVdH5SYioUMOM/bps3hGkh6Q5xYYzcTWAEXW7l7Wki9ke6kHW9rlMftr+eV6timptqyjUZiwhFitJe8QUPZhniV41NPxTwk6GEXROhoSh+Jvo=
Received: from PH7P220CA0107.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::13)
 by CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 15:39:01 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:510:32d:cafe::45) by PH7P220CA0107.outlook.office365.com
 (2603:10b6:510:32d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 15:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 15:39:01 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 10:38:42 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 10:38:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 21 Sep 2026 10:38:42 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68LFcabY3254021;
 Mon, 21 Sep 2026 10:38:36 -0500
Message-ID: <29e041a2-7c60-44c3-8735-de110dbc2e62@ti.com>
Date: Mon, 21 Sep 2026 21:08:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: drm/bridge: Update reg-name and reg
To: Harikrishna Shenoy <h-shenoy@ti.com>, <robh@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <airlied@gmail.com>,
 <andrzej.hajda@intel.com>, <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <jernej.skrabec@gmail.com>, <jonas@kwiboo.se>, <krzk+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <s-jain1@ti.com>, <simona@ffwll.ch>, <sjakhade@cadence.com>,
 <tzimmermann@suse.de>, <u-kumar1@ti.com>, <yamonkar@cadence.com>,
 <pthombar@cadence.com>, <nm@ti.com>
References: <20251126092949.298530-1-h-shenoy@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20251126092949.298530-1-h-shenoy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CH3PR10MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5667f06d-7c5e-4577-bbad-08df17f675ca
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|921020|13003099007|6133799003|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8Jhd3GivVjjyWlbLGWye9CLUPYKTiNSpQ5s0tSIu3+UrKpXlCQ6JOtce8s9J88hqYXx40BzC/NGv9p13oKyvu6GwBEfO9b/PXW5SgtDM5saCZ6WyhcBLKyPk2+eDWCsYkffiA4wU3TsEVmVCU+naURihhFLGTOTBy1NxKKF9J95JGGYghSjkxVq/M9WrFxiK/kYccRocCjfarzIEnUXvKTYkWJzEjOPvGeiV/RKKM6og6d4v0GAcao/trnJ2nahCCCgBmHqZe2chQB6tvq76GMsIbdhwTPvzqV0yLnNP5p1p1NAgUiZnJ0/Pnj9VkGgxliSjECHuIXNanbEPnGC90xRlXwV5UBvEKGp8xVgSG5iT18x7AwX/Hdkq1z9SJdxntuPRGfOP3RxHuK0k3wDP6+y2vGO20WlCmk3WAOKLlYHBAOvVc5y8xCnf98RCa9vEQQId4DF02it0AYHVzVpBXwTbIqABcuFn2IKW8471phFWST6PxU0D+RB9FzJuf6DsVeKfzl8I7bPJNIuIaoJQWi9xNYVLXy9Wn1KBed7huPUIfbOFHl8lpseiweM+bx/+esAfJgEvbSxk5ikIYoi0f5eFvINfBGU/2kjfFiWysIOtDhEPtCQPTgHMCP1Rcv3MDmu7NnpTEtUD2U/CpMF1185frrgACDl6cDefaRT8+TOoxp2p7cpKogS59/TaCk6QqTKJ2smaR3ztnbMJIbYPZg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(13003099007)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DZkqQUckagPnnenbxdilLkO6wkDKkL2nATIZDp4aeXq/4aE4EWE7VeSY5zFbUDsi1jXdVXo8nYrWBBSEK75hnfc10squBCrYcDExO+2lGC87BxmITl/aA2hhuKzWscKy01Wm+aRytHzu9b7YHeo65e56u0LPhrPgqlZPvML60O0KzJkjUzHKBq4Px9zD1HvjV0xknQnvgwRl8d9T2TRRGJGi3d2zGk7Sp8eT4/rT8A4+ygcgv18o7UDRcaaBQExAOQgbHjl4TU6qbRC0jczpRObqzIh5YbFdwamBmqSI/ElAKDY9Tp6wVwXoF8weOaIZQteytfpcsZWlBOd9QZ8uvtl3r1a08um0NzUzWeJ50ETwTnXPAsTV3UagjNU1Gt/F9sUplGvjLjywcrPt5+KZtrSkozgshpIub9/1uUDUJuqRly3PzzT5qs9gqTpi4f+Y
X-Exchange-RoutingPolicyChecked: 5CN7BJHqlKIeqgBifcN9HYERgvuTZXWOWNFmN7mc51b5qwRIa6i/C+ql4ZX4KHjCrBSCGeYbljuhaZo3NGzXkCA0xe257GCuzyCh8U4FE5+4GXlhDSGnH2wVoMiKGEiUdsSoetxnaiMGkeODT4CZC3jcJ7IgUwN8cTjg3eUsPb5f04ak9gteduPPbMHUsl1b03zxXyt1DUvbsGM20QmHRF6GcWkiYb3Q2ciMR/BN4+snew9I5dFdceDM7Vo9XsRd/yCB6OuY5FkIKuvKtHlLiA9qMG5A++IYUodbUkm9Iuxf7TpHbFZA2BixQruZoIr4bsv13sbjS+D6IhBoTSwY6g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:39:01.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5667f06d-7c5e-4577-bbad-08df17f675ca
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6810
X-Authority-Analysis: v=2.4 cv=Vou2kO2n c=1 sm=1 tr=0 ts=6ab14f9a cx=c_pps
 a=9D7zFwNo98o+tMWDMQIn6w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=jytzg7UV7PX_-fJ671gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX42rvncmvX2qE
 EyLwCHIu2Cxhl72hXf0JZE+v+FfDembwYxKxkNyCyrl7DKb3X3atQw7z3JPbVI+RaGd7DXUg+Dn
 1Ioco5ktXHbrn7OXyTf5m6g2kBKzFbHb+ljQKp32b5BrsIkyKRYmOGhx0U/IP6BBkRKZjzMz8jD
 IMBM4EJkY+9/LR5F8KzkaQbR0wRt3G8qFz17bR5zgcgoCk+ulNNyU8q9F99TCDFVKYbZrkJBcrP
 YFaaxEFNGlfvmXOyzaT2sgYKz5CxmxJIUnE2U9lcEAUmA1/b5AsxKG6n0Kh7B8YdfspsaoItm3g
 cp3E1rSjAbfOszTq9FK/qV7c3symM0xHflzGSXtcYiIfNAF6TCh2DWmDDFPG7+MTfJZrt+SXCmo
 VLcYTcUKYFwtRa3knTrpyXL6E9J385i0aAh7i3RI3CiQs8WArW6AUC2ZqMWv1JKTtcp5eDMoVsW
 gIWyMWx7CzOS1wQknmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXx3Tf726dXbCS
 QMopTPsGVrGsKFciKZpcNPhDOrPCF5RHXIJnpr9EMsLIIZ4nCVSUCy37POE75xQ45FxiaFxNtqG
 ePadM1MBo7me1skr7nn6b9IwdloAfY8=
X-Proofpoint-ORIG-GUID: L0OsAVv24MlzrBJNfliKPIqkuyg2moqH
X-Proofpoint-GUID: L0OsAVv24MlzrBJNfliKPIqkuyg2moqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210227
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

On 26/11/25 14:59, Harikrishna Shenoy wrote:
> Move register name constraints and reg description lists to appropriate
> compatibility sections to ensure correct register names are used with each
> compatible value. The j721e-integ registers are specific to TI SoCs and not
> required for other compatibles.
> 
> Add DSC register descriptions to align bindings with hardware capabilities.
> Structure the reg and reg-names constraints as lists according to
> compatibles using oneOf schema construct.
> 
> Fixes: 7169d082e7e6 ("dt-bindings: drm/bridge: MHDP8546 bridge binding changes for HDCP")
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> ---
> 
> Links to some discussions pointing to need for a fixes patch:
> https://lore.kernel.org/all/20250903220312.GA2903503-robh@kernel.org/
> https://lore.kernel.org/all/d2367789-6b54-4fc2-bb7c-609c0fe084d3@ti.com/
> 
> Link to v3:
> <https://lore.kernel.org/all/20251121123437.860390-1-h-shenoy@ti.com/>
> 
> Changelog v3 --> v4:
> - Update top level constraints and commit message.
> - Update logs with processed schema- https://gist.github.com/h-shenoy/a422f7278859cd95447e674963caabd9
> 
> Link to v2:
> <https://lore.kernel.org/all/20251119122447.514729-1-h-shenoy@ti.com/>
> 
> Changelog v2 --> v3:
> -Add the reg description list and reg-name list in top level constraints
> using oneOf for either of compatible.
> Logs after testing some cases: https://gist.github.com/h-shenoy/a422f7278859cd95447e674963caabd9
> 
> Link to v1:
> <https://lore.kernel.org/all/20251107131535.1841393-1-h-shenoy@ti.com/>
> 
> Changelog v1 --> v2:
> -Update the reg description list for each compatible and add register space
> for dsc to make the bindings reflect what hardware supports although
> the driver doesn't support dsc yet.
> 
> Note: j721e-integ are not optional registers for ti-compatible.
> 
>   .../display/bridge/cdns,mhdp8546.yaml         | 85 ++++++++++++++-----
>   1 file changed, 66 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index c2b369456e4e2..4cec0f4c22a2b 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> @@ -17,23 +17,45 @@ properties:
>         - ti,j721e-mhdp8546
>   
>     reg:
> -    minItems: 1
> -    items:
> -      - description:
> -          Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> -          The AUX and PMA registers are not part of this range, they are instead
> -          included in the associated PHY.
> -      - description:
> -          Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> -      - description:
> -          Register block of mhdptx sapb registers.
> +    oneOf:
> +      - items:
> +          - description:
> +              Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> +              The AUX and PMA registers are not part of this range, they are instead
> +              included in the associated PHY.
> +          - description:
> +              Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +          - description:
> +              Register block of mhdptx sapb registers.
> +          - description:
> +              Register block for mhdptx DSC encoder registers.
> +        minItems: 2
> +
> +      - items:
> +          - description:
> +              Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> +              The AUX and PMA registers are not part of this range, they are instead
> +              included in the associated PHY.
> +          - description:
> +              Register block of mhdptx sapb registers.
> +          - description:
> +              Register block for mhdptx DSC encoder registers.
> +        minItems: 1
>   
>     reg-names:
> -    minItems: 1
> -    items:
> -      - const: mhdptx
> -      - const: j721e-intg
> -      - const: mhdptx-sapb
> +    oneOf:
> +      - items:
> +          - const: mhdptx
> +          - const: j721e-intg
> +          - const: mhdptx-sapb
> +          - const: dsc
> +        minItems: 2
> +
> +      - items:
> +          - const: mhdptx
> +          - const: mhdptx-sapb
> +          - const: dsc
> +        minItems: 1
>   
>     clocks:
>       maxItems: 1
> @@ -100,18 +122,43 @@ allOf:
>         properties:
>           reg:
>             minItems: 2
> -          maxItems: 3
> +          items:
> +            - description:
> +                Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> +                The AUX and PMA registers are not part of this range, they are instead
> +                included in the associated PHY.
> +            - description:
> +                Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +            - description:
> +                Register block of mhdptx sapb registers.
> +            - description:
> +                Register block for mhdptx DSC encoder registers.
>           reg-names:
>             minItems: 2
> -          maxItems: 3
> +          items:
> +            - const: mhdptx
> +            - const: j721e-intg
> +            - const: mhdptx-sapb
> +            - const: dsc
>       else:
>         properties:
>           reg:
>             minItems: 1
> -          maxItems: 2
> +          items:
> +            - description:
> +                Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> +                The AUX and PMA registers are not part of this range, they are instead
> +                included in the associated PHY.
> +            - description:
> +                Register block of mhdptx sapb registers.
> +            - description:
> +                Register block for mhdptx DSC encoder registers.
>           reg-names:
>             minItems: 1
> -          maxItems: 2
> +          items:
> +            - const: mhdptx
> +            - const: mhdptx-sapb
> +            - const: dsc
>   
>   required:
>     - compatible

