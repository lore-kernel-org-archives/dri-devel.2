Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE5CDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD66710EE9B;
	Wed, 24 Jun 2026 11:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KjZAutcz";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GbfHPCDB";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7099110EE9B
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:10:56 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65OAOPVw2534384;
 Wed, 24 Jun 2026 05:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=DG8lm0uaDNsOR8nLc3OMkpjgGGVvWSl6oV34vqncZ
 mo=; b=KjZAutczDcNz8KHQJMmXxFG7gorjHHnzV60Jxcy4acWIibYYw6y4zoz6A
 otNko5KE7HFveOjhMgdWqv+1vYeoWBZvhhcryN0yOtDV6FLF7JLVeDOI1L4Ktn03
 aKFcOdtWDuA4UccFbnv/AMCQrT964ITt+HB7RJZ7WWQW/IQPM7FVVX5N+5EXBBnM
 jA3rWbWiVWfZOmTy0TMEyLdj4TqrUx48mIAS/aIt5k1wNj8CXQNYm81/ObLOs1KM
 EVOWmSlUlki+fYHRYxDt3I1MgSaScl6CTjHFomkQN9QhqJ40QIeQvQk2XVo51tuj
 5E8e9KTYs8RRAodio03VjeiiEMw/w==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
 by m0384305.ppops.net (PPS) with ESMTPS id 4eypttgb3m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 05:46:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8r6wlVhAN04simQC4aR+sEePx3zQYGR0aqHD7eIpCUEVeqWRbEs9TJaXaKrRrpcd10DtWA184uZnoPAYJwr22sTM3u7pBjPvkQ24+siCZ0n+LcLK3uCP65lNybu/QY7tXCi1tXXBTD7gyGMr+OLSb823sb2+TD4f/xGW4OFSG4gHCMZ95WCEKrzpeL2bsQuDESKCZ3Mt4KkBm2CFdeAd4fqX4mvONasgrUy2lXfRj1OhxYD6OzYHqMlNPVBNVohK0mPksGZIa2/0pfGkIyXh6YpC8XjaKzAVvTM40dHveyqp1ZsdpGdLxS5e0V47C/UfiXDpNQpLw/GPacqh73x0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG8lm0uaDNsOR8nLc3OMkpjgGGVvWSl6oV34vqncZmo=;
 b=MsHBcuUraQREXCBvk4A2HO8yf1NpZwOeXo7G1TZmxbsCel3aZUYqEH8LWLV5sU+aiLVCCHg+SKEqEca709PcvjTVeSsGQWxCYuJAt7sE4tIg7+Wc95E9iuPxB+eqhNC7qbO1FV1QU6FLZnf6Ze1918RB0kqtc8KPUD0fA1JFdfKPZimgv5LTBiRKEoWYzFYphpKkXnYHO8NIRKM5eIQ/hfEr3Zf+Faf9RnnifclsDuPDnjCwbokG+ASfw7k+fF39RpJb4mgYkquQPMT/8ZnN1+S66T8Gtoz2J44OT5G09dW06sEBnbkBGpH4ddwp7keJwp+nP1Zr/b4G0vw7eaNvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG8lm0uaDNsOR8nLc3OMkpjgGGVvWSl6oV34vqncZmo=;
 b=GbfHPCDBoDScHTkvGR2rLmBWpcyazwiAwWPxYxb4s0L08QfPq+b+WVxDZdKrhz/hYZDnvJVAuOX0B4Lo5fCoQyNJwC+LCyLR/5PxmalwZEnKY9piNNq66W5ADIISmKDEJJ67l6J2yirNWt2E0zeHWIgPz+H0wNm+juJUAuoyYyQ=
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by CH3PR10MB7139.namprd10.prod.outlook.com (2603:10b6:610:127::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 10:46:44 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 10:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 10:46:42 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:46:38 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:46:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 05:46:38 -0500
Received: from [172.24.20.59] (ltpw0bk3xf.dhcp.ti.com [172.24.20.59])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OAkWET249706;
 Wed, 24 Jun 2026 05:46:33 -0500
Message-ID: <cccbb9f7-3903-4a3d-bf53-72752b7561bb@ti.com>
Date: Wed, 24 Jun 2026 16:16:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] drm/tidss: Add support for DPIENABLE bit
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
CC: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260529-beagley-ai-display-v3-10-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-10-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH3PR10MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: cf517f4c-801e-41da-952c-08ded1dde125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|22082099003|18002099003|4143699003|56012099006|921020|3023799007;
X-Microsoft-Antispam-Message-Info: nZmQvog0p4/38HufqpyQP2QEZ6/ovFPW2I0UhTHKZRDA0+fcB4PZK+MePtXO0eNdxnR1t92nLYpL7K+asJ9lAT1qn+Dmr3mEHSXo5hx65nbtyYJqktiPabzzCzC7MSnN+ZCDwfmH2hmocs0waHJZsqsZ8RQ1dImeahNKiPe/kk2XaM0YLzn8MQHO9tPRoLIIT57zmKIbgX1ZX46A40/THhAtdhkfFYtCZTr8nACsACvsW1A2tL7KqJjvW7bQnk1FutKEI2EtN9a5RoPuPzloz9rsrbix/wa8V/Xh6DubNm27iORs2evSlPbmpyxF6APWDr8CloAB1zDI7cGY3OBx0s1noGTPY8W5ReuocTTgI7UKHOdN6nK96vTFAdqslJNbOXMH71wHK5suRxgkZM7KOvhW/iPCrNJZZDiqg9wV17rurIZ4VxStxufGtkcSfLp9vnq0kGTMmgjnSuwUc8Qx8yDSCzyNPQDH6Zqo8BMSOdg+xEs8NrWvV24COXBNCGSqtL9PHKBz7RLbou9bxbPrewu6sDFuxT6JtrKttiVihlSYV/IdM6dL9dE5LzWhpJluCoeMLkggEiXfAA0XhzA14n+rnpSB/elk0TfcnQw7LL8hhw8Kdah63oaUfuRW86/TYx7MSbVLSea63FcZ7pq0mt/iv7npzLymL8gaa29h2g1N21i+BiZWt7oSxod5wpFWUQzIvd5Y3FR+cJ3AohznsC75qnr6Qs+TbdY8z5ADafTRwLmIewT1gbqKOm4gRwxG
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(921020)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mu4F38U1bIDiEdVFNvpPlhd0vf0PsuDBn5rH/WiMULSTRA7CDSWVj8a/Uua/yLFzzCKKbBvVCbgpwa4vjj67JwbH/88GQUGdylODuIWbBrtx8wU9Xy+GYVkSexpDk9r1NZ6mi6QCCfAV2Ar39YmziU3cAeuQt5t0WxOy/kFaCtKRkJInlWhHMkloPqCmrUZ1TG8x/LepOAuN9tclnQfcJCqezaGl1bJz3DWP24FdhMq7Kue88Tn9ZPURXKkVy5hRkQhWJKoAXWeQ6Psby0NDhf3LPGx2iGl3zPWniluUmdqJZiiv8DojbZNo7qqUdngJj6DsuRUAfKS3m3usHK2F1NcEiXtTulvGJTV0XQGZfQ9Q1JTb56oVTNgpeBQP5xBqwReb+7jwK6FeFowDxx8RzQYyu4eAR+EOk4IBKnmcHQVqVMGmiYU8u/48xRyggwLA
X-Exchange-RoutingPolicyChecked: TQgBWDqTeO596ZlANXXofJ1f81R8+4LYe2BF3hixWEd6lbCIsh1ZUyU67y/KxBs6r0L1gTMDBhHasfgcIaRYgZ3Vw9+sKoRB1pxqNYZUTNUi5Z9qtL2T19Gg2YCNOBC0s9VzS+qLXcGD8RumNwpx3ZII3J4BMDg4CelpKFaTfVTpueW027L1NJg6thjzjgUPmiql7iwu4sDWEPyOpQ9BJdERPMs0J5TyJDrSnlbGI3OJfx978xBavvSSeZ9U0mdrY3vc/Z/Pla831KSAPX/zYYpiEXwAIi5FA1a7IGwOg2i8HKxl1gu/YMldF1F1ILv2Swq20Ss7vJo4k1EiOjBWiQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 10:46:42.7109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf517f4c-801e-41da-952c-08ded1dde125
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7139
X-Proofpoint-GUID: isP4fprQ3AB5PbNA5758M5lH78s7cuDB
X-Proofpoint-ORIG-GUID: isP4fprQ3AB5PbNA5758M5lH78s7cuDB
X-Authority-Analysis: v=2.4 cv=EPo2FVZC c=1 sm=1 tr=0 ts=6a3bb599 cx=c_pps
 a=0vJwjWeN+wUybMchBBml3A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8
 a=vqHznLqP4jQ7SChzMA0A:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfX6MzaILediFoR
 BLjzOw3MItLwfogSuylt1Fyo2kvvhFjTojZ9stvDIRAdZROC5DSReeVvRHyb0foTFb+uk9AGXeV
 WpBsn+OPInxL41A+rn5Fz+15Lx+WIzA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfXz2PEs9V0whXk
 YBLF5netB5z3QFR4IuwqGruMTrlvb9mrMGbBmwMQq6FeqETs8kyIMA18ldNQcMp/OAnagWy+Z3o
 96sxXLvVe6nH1vNoXv/Ww7lkrUc7J32hCWRUxVFtt78JhsWw9AHW5euEvppowHeANuHcwTyrLZr
 cnZF/CoHihGRIOVIM8CJDHQcYVV3wT7T/JEspbtzKMARVFkAT96UV1YIn5HorSLvUPWsvgd1Acq
 kzIIwOQuadL++J0McFTmrZ1yvAYst15EOIIYHvRya9Z0wbvnCvCeE81Bsp79kRVHfE7IH1h78Xq
 OXvAFIzZd6SuZDnTnzzodxWF8W10YE0qVmK13Gfhioahznb8tVH1lfgPeFxeOuetCDEa9m+cn4S
 7z/moeHw1RfguvgmXRTGglJmuPvN3JiTrLy2RqWnkdAzUv9Zu1MtwOKk4oUGgWse7So8fO+csgs
 AQ4OomVh89PY9QgMI0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240089
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



On 29-05-2026 14:15, Tomi Valkeinen wrote:
> Many (or even all?) K3 SoCs have DSS VP_CONTROL.DPIENABLE bit described
> in their documentation. This bit controls whether the DPI block is
> enabled, and is set to 1 by default (i.e. DPI is enabled at HW reset).
> 
> However, in almost all SoCs the setting does not actually do anything,
> and at the moment the bit is not managed by the driver.
> 
> The exception is AM62L, which does have DPIENABLE connected, and
> disabling the DPI block when it is not in use provides power savings.
> 
> Let's add a new feature flag for this, 'has_vp_control_dpienable', and
> implement the support.  Disable DPIENABLE for all videoports at resume
> time, so that it is 0 by default. Specifically enable and disable it in
> dispc_vp_enable() and dispc_vp_disable() for DPI output.
> 
> Tested-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_dispc.c      | 23 +++++++++++++++++++++--
>   drivers/gpu/drm/tidss/tidss_dispc.h      |  2 ++
>   drivers/gpu/drm/tidss/tidss_dispc_regs.h |  1 +
>   3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 08342a9a5e8c..1b8d52f10673 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -442,6 +442,8 @@ const struct dispc_features dispc_am62l_feats = {
>   	},
>   
>   	.vid_order = {0},
> +
> +	.has_vp_control_dpienable = true,
>   };
>   
>   static const u16 *dispc_common_regmap;
> @@ -1210,6 +1212,11 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
>   			     (!ipc ? DPI0_CLK_CTRL_DATA_CLK_INVDIS : 0) |
>   			     (rf ? DPI0_CLK_CTRL_SYNC_CLK_INVDIS : 0));
>   	}
> +
> +	if (dispc->feat->has_vp_control_dpienable &&
> +	    dispc->vp_data[hw_videoport].dpi_output)
> +		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
> +			       DISPC_VP_CONTROL_DPIENABLE_MASK);
>   }
>   
>   void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
> @@ -1226,6 +1233,11 @@ void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
>   
>   void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
>   {
> +	if (dispc->feat->has_vp_control_dpienable &&
> +	    dispc->vp_data[hw_videoport].dpi_output)
> +		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
> +			       DISPC_VP_CONTROL_DPIENABLE_MASK);
> +
>   	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X) {
>   		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 0);
>   
> @@ -2445,10 +2457,17 @@ static void dispc_vp_init(struct dispc_device *dispc)
>   
>   	dev_dbg(dispc->dev, "%s()\n", __func__);
>   
> -	/* Enable the gamma Shadow bit-field for all VPs*/
> -	for (i = 0; i < dispc->feat->num_vps; i++)
> +	for (i = 0; i < dispc->feat->num_vps; i++) {
> +		/* Enable the gamma Shadow bit-field for all VPs*/
>   		VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONFIG, 1,
>   			       DISPC_VP_CONFIG_GAMMAENABLE_MASK);
> +
> +		if (dispc->feat->has_vp_control_dpienable) {
> +			/* Disable DPIENABLE for all VPs */
> +			VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONTROL, 0,
> +				       DISPC_VP_CONTROL_DPIENABLE_MASK);
> +		}
> +	}
>   }
>   
>   static void dispc_initial_config(struct dispc_device *dispc)
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
> index 6f53d554259c..0fbfb86adfbf 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -92,6 +92,8 @@ struct dispc_features {
>   	u32 num_vids;
>   	struct dispc_vid_info vid_info[TIDSS_MAX_PLANES];
>   	u32 vid_order[TIDSS_MAX_PLANES];
> +	/* The DSS has VP_CONTROL.DPIENABLE bit */
> +	bool has_vp_control_dpienable;
>   };
>   
>   extern const struct dispc_features dispc_k2g_feats;
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> index 4cdde24d8372..4246c72efdd5 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> @@ -230,6 +230,7 @@ enum dispc_common_regs {
>   
>   #define DISPC_VP_CONTROL			0x4
>   #define DISPC_VP_CONTROL_DATALINES_MASK			GENMASK(10, 8)
> +#define DISPC_VP_CONTROL_DPIENABLE_MASK			GENMASK(6, 6)
>   #define DISPC_VP_CONTROL_GOBIT_MASK			GENMASK(5, 5)
>   #define DISPC_VP_CONTROL_ENABLE_MASK			GENMASK(0, 0)
>   
> 

