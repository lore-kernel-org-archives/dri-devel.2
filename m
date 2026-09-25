Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1441C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B9D10F8DE;
	Fri, 25 Sep 2026 07:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="faRXIzJk";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kipR1Mjk";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B85510E586;
 Fri, 25 Sep 2026 06:57:22 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68P5JLqW2451660;
 Fri, 25 Sep 2026 01:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4MAm5ZamgXFOBTWQI2rupzb3J/eyzWsPiVMyzOdtg
 Vk=; b=faRXIzJkU3DI+8fuiqSqmWPaakJcXzJ/Y9uIbOD59F7U7qNGMtPhXzS/k
 NC0W9+317enzxCo7r671n1MAC2TYQagXJ1mi5JIkPO6mGUWvjmwMWodOszhU5gxs
 7NiwCGG+cgy6wnRg1runwoWV0cnO79Eg4M3mz9F0qc3Q7S7aeG/RjgIGsSNFFW7m
 VajXIoWbSVhrbARfreMKrQeCf1H67AqiQsVQRxE6AOYjHJ3yRk/23HoqdRSoj257
 eRjOtD+dpEOHLB0M4oVph65PvGY9n5JI2LdryO3HldlxzjDH6KN1fyZ2YgZ8sEJ7
 iiypmwINv+0gx8lSAT7f15CW6fTjQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010020.outbound.protection.outlook.com
 [52.101.193.20])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gwjq48fnr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:57:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyLry/JzFMvAz7178dS7IDTp+QgSqyQ1XXdFDR8zdWSOvGkfoXwt7xtLVPFlRaumYLGqpdOdC+eXfnFtNZVG1RerQBJUjdlKMLhcyGAp0/Rj+PiK3cb2QkHhCGGX+LhpyX47lS4pEsArpQ1PvrdOQL7sbnneOUGy/oxyPnYUAOdx8XZSulCsZ5k3VJJEsMYyzrWhZq111v/Ka5vsqGPPLP/XZNEfMtBljPwExTWpn4HMMNp/gOHvUwyk7Reb97FSx2gdOuZRLKt2/+Iutsp8MWiMVQU7oim6TVHTNbzfvti26pPs8NoGG2h/PKO6DYrXZ9VvH9dBDe6XM/um01V0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MAm5ZamgXFOBTWQI2rupzb3J/eyzWsPiVMyzOdtgVk=;
 b=xp0EWPIjOhRY2tivOaII4+bsbBEHjwClLmUYP0LeunTAZwry11IpxzHcjg2babY9MgP3ZblgWo/H1DScA4m8VWnFfnwUMjYec3ik2Te2BMlGgr0khy1zrbjSMN3jFHtBHzb7oFauLcvMD03eRclQBwRP7HGpRqyqZFxsOIX79QCjQ01k6gqQfwm9KmNmr9/BO5+1Mj4FBLe9AnwK+NwRmHSl9sU6UHRdCLpVtwp3xIvb2imTNt1Ip0Bqps1noH7SdgXUsCLgz99OdGqSSZzF6DFH489gYNP8OA6xOCdevMCP+x7PMTPSrKkmftBMm23myUX1g//dQNjcThiePgCyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MAm5ZamgXFOBTWQI2rupzb3J/eyzWsPiVMyzOdtgVk=;
 b=kipR1Mjk+j8UjVooGnTCDcooeGLk95YyI1M7suTcLQ/mdbw0iaSJirjNEqU6WGOkBBvXI+2ufsnGBbQbk17YBgVWRbCwZVCfk+m9EHybrn70WxON4AK+mP4gSI8zSi75ijtSzdcMZ+6mwl4CXSGw4FbT6+J7HEb8BjRA1oY7uqc=
Received: from BN9PR03CA0947.namprd03.prod.outlook.com (2603:10b6:408:108::22)
 by CH0PR10MB5132.namprd10.prod.outlook.com (2603:10b6:610:c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Fri, 25 Sep
 2026 06:57:04 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::76) by BN9PR03CA0947.outlook.office365.com
 (2603:10b6:408:108::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:57:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 06:57:04 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 01:57:01 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 01:57:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 01:57:01 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68P6uZ1L1371804;
 Fri, 25 Sep 2026 01:56:55 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Fri, 25 Sep 2026 12:26:30 +0530
Subject: [PATCH v3 3/3] i2c: designware: Add ti,tda54-i2c support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260925-tda54-upstream-i2c-v3-3-544d74e992ff@ti.com>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
In-Reply-To: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|CH0PR10MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: e12e37c7-b7b3-444a-e63c-08df1ad2352f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: dUBTMTDuhT1jXehcrlVyF67MiSv3JmKHoFdcsDzjw3FLh0YBiU0mhmncRdKoqqUPBW6DTYF3nRuk4HW3+OkHLejWs4V9RwE+xUXfMqfn2Lj41DLZOIOplXAllKT0N+L4IlI1RJcH9aVjFLhRa2IfQBLGm4KDF1mh4fvgGpD43BTcipAipgYdx4tyvXVxuJws58L5oG1wzmUFt/z6eOUD4x20BkVRcpg8RWSiFPFBvgE+W5O1p4vw/ndhb8bAUf4f7bz5vnbUKss+r3gi6kwYZzUCXWNDI55dsuYVdnG2svD+wD27HU/C7d9zF0sIQ/DNDhN1r1hPePc71tIoAhq/cGt6y04Hj0K4xwwFXRe3rttQFXhthAU4UtRSFHOQ/M+UoLJneK7KqPiR/N638bM6jW7qeXJA0+AuGLMjclbVqX48tj0aTUcWcU9mV3CJWu+66gO3jnV6D/zpRiY90IgnM2enViUY5RC1DEuoBXjpvljYeTznKXcHTsk2ZwcqTSthpiw7sxJH6CKD/B96bYu4q+OhTP2A/3/Eb++W0LGT1HIW5woY0job1XJv25cL9DNQlGQUN6ajXGV3dmkTPBTsTd3yxCmqJjHD61gN1X5clfXRr7iMpGMdo0DaEGFVjRyko0qyv57x/o9q5rD8ns+Kx/qohFmFwY8LVw9tuiFx9r/RE1SG/RR27cKxMm10pdxG
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ic+J3yEYc9IbSh729NV46x0Imoh0fiSlAD50tnaIFz2fnNuFCUr0DIag4xY2sUWz1kdGJvYWFMOkJg8RmCxpmWp1is2beOxaU4l+jkONLcg8Junc/GFmrvFhcP3cAOIHU7EnkWIy1yIvEgMEzbhsX+r0gtquyZ/rjby+tS6vLlLt+r52pr7GxgPT6XvmvFTGM4+9wkh2TA6GbtgjnVmEurXOlE46t6H5kR/fq5ZfGm++MNVV+kBRmyOAs6Pz2sygeHUf0w0Cjddg8Ohtt6QO1nNtcW03CTpYAgTwsQSvBcYphegXyM4vpUq1m2zl2rkJ64fyquUhLeju4b1Bi+TvYHvqc+cIApQM2UUqo98m1lNgU2yuLAZp5uiVt9e4ZKRLvbMHf4r3zKEtdDNXXCELNXyyvNz8FfLC4JmAHWpwpYQlFxucgz0kRyZ1vSdBHqk7
X-Exchange-RoutingPolicyChecked: u54h282EKJ1LbdZaSGVHjox/fOfn4dbaMEGesU06ZSumFEuaj25ejmlb96SrCHfpahpTdDZHyK90OK1DZ+D9jLM4SmUuZ7oD1CBdTa9BVH6LKluTa/0J0akuMWnWQpjceIbVChDjiAFuu+zF0kbi6sKTjP3MSjZTJhwOm4Lo4rYy2iyqhp/DXkaPrwZGLY0KLmx1fLuRsaraIWafyhMtwPry447nNKDUrI3COBVYO4PnzoXnQ/oXJQDUpCY2pKGI0QF50Wyolrt6stiHFD6X4PSEUfHCDaIYLaEYI6skvVlw/E94ZrWgmpPAel1+knjoIpPvTQASe6GsoIgxPsK3Pw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:57:04.6486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12e37c7-b7b3-444a-e63c-08df1ad2352f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5132
X-Authority-Analysis: v=2.4 cv=H+pOUOYi c=1 sm=1 tr=0 ts=6ab61b47 cx=c_pps
 a=Qq37X6yQjtlUzqIQK1H1Rg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=SFMlj2LtjsmYIoXMqcoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HB3hE37HvbtMPQMdYVT9yfqXvba5Gkvh
X-Proofpoint-ORIG-GUID: HB3hE37HvbtMPQMdYVT9yfqXvba5Gkvh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX3JSbFOiF0TjE
 ESoVF709EbjVXvgW8jFTY4CXDnNCL3+PldekMe01uyLokWQDRJfrd8TV607z+uTINy5EW6AwYE2
 syh6yje3hIaxJ9KUTNqOkv2GELcZKHg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX9wtLFDoT1h0Z
 RBMOcI/MCdBCg9d3YnT57PsU5G3mpUzparY1FChZhkyrHM2f3C5f6GNiKLGpDTVUj7AatYekIf4
 PzEJgiUC70Kqok89Fu5FRyslg3Az3LAVGeLy9WDdYTEPHSmr4b1tOuahZOilRLRWvT27JK7FXmq
 4mWBEC8id7hAT9+NvJAtLjcqBC1Dc9MwYeHPi2Ip/sa9FmoZuRmkEbwCnHvCEvVNfU98rj6KVXV
 5RW9J+r7hYdNX8VSzqR5j2//HO4DWaAm2gUQjemwFiLs7HnFgPqW7Kk6eru1QJYu361xqQjnwE7
 wp9U0k0JweNMaQ3w28JuK8DYiupFejLdWUDoMoGzFoXclak72xB4irprQXJFau592xX+FY6Lflf
 lGYcrmCqoXmbHFgDiSCmKKrVw1UG7wiHa0Csd/lpurWOqC9rgHooHckGbYXWHavFEUm6PqgbhAL
 3e8USS4+qETeoDjmFHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
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

Compared to the existing DW_apb_i2c layout [1], DWC_i2c present in TDA54
SoC [0] differs enough to need MODEL_TI_TDA54-gated special-casing in a
few places:

- Add new register offsets table for TI TDA54 SoC.
- The DW_IC_CON register bitfields are also updated.
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
- No defined CON.RESTART_EN bit; treated as always set.
- TDA54 SoC does not have SMBus block, skip accesses to those registers.

[0]: DWC_i2c_reference.pdf
[1]: DW_apb_i2c_databook.pdf

Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---

Changes in v2:
- Rename compatible/flag: snps,dwc-i2c -> ti,tda54-i2c,
  MODEL_DWC_I2C -> MODEL_TI_TDA54.
- Remove i2c_dwc_has_smbus(); just skip the SMBUS_INTR_MASK write under
  MODEL_TI_TDA54.
- Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-3-b0b9f77be18b@ti.com/
---
 drivers/i2c/busses/i2c-designware-common.c  | 128 +++++++++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h    |  22 ++++-
 drivers/i2c/busses/i2c-designware-master.c  |  26 +++---
 drivers/i2c/busses/i2c-designware-platdrv.c |   1 +
 4 files changed, 153 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index bd25b9c582c1..8cb162a6aed8 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -72,6 +72,40 @@ static const char *const abort_sources[] = {
 		"incorrect slave-transmitter mode configuration",
 };
 
+/* "ti,tda54-i2c" block-based register layout */
+#define DWC_ADV_OPERATION_BLK_OFFSET		0x00
+#define DWC_ADV_I2C_BLK_OFFSET			0x28
+#define DWC_ADV_FIFO_INTR_BLK_OFFSET		0xbc
+#define DWC_ADV_DEBUG_BLK_OFFSET		0xf8
+
+static const u32 tda54_i2c_reg_offsets[DW_IC_REG_MAX] = {
+	[DW_IC_ENABLE]			= DWC_ADV_OPERATION_BLK_OFFSET + 0x04,
+	[DW_IC_CON]			= DWC_ADV_I2C_BLK_OFFSET + 0x04,
+	[DW_IC_TAR]			= DWC_ADV_I2C_BLK_OFFSET + 0x08,
+	[DW_IC_SAR]			= DWC_ADV_I2C_BLK_OFFSET + 0x0c,
+	[DW_IC_DATA_CMD]		= DWC_ADV_I2C_BLK_OFFSET + 0x58,
+	[DW_IC_SS_SCL_HCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x24, /* shared SS/FS pair */
+	[DW_IC_SS_SCL_LCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x28,
+	[DW_IC_FS_SCL_HCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x24,
+	[DW_IC_FS_SCL_LCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x28,
+	[DW_IC_HS_SCL_HCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x2c,
+	[DW_IC_HS_SCL_LCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x30,
+	[DW_IC_SDA_HOLD]		= DWC_ADV_I2C_BLK_OFFSET + 0x34,
+	[DW_IC_RX_TL]			= DWC_ADV_I2C_BLK_OFFSET + 0x5c,
+	[DW_IC_TX_TL]			= DWC_ADV_I2C_BLK_OFFSET + 0x60,
+	[DW_IC_INTR_STAT]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x04,
+	[DW_IC_INTR_MASK]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x08,
+	[DW_IC_RAW_INTR_STAT]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x0c,
+	[DW_IC_CLR_INTR]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x10,
+	[DW_IC_STATUS]			= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x1c,
+	[DW_IC_TXFLR]			= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x20,
+	[DW_IC_RXFLR]			= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x24,
+	[DW_IC_TX_ABRT_SOURCE]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x18,
+	[DW_IC_ENABLE_STATUS]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x14,
+	[DW_IC_COMP_VERSION]		= DWC_ADV_DEBUG_BLK_OFFSET + 0x08,
+	[DW_IC_COMP_TYPE]		= DWC_ADV_DEBUG_BLK_OFFSET + 0x0c,
+};
+
 static const struct dw_i2c_con_bits dw_i2c_con_bits = {
 	.master			= DW_IC_CON_MASTER,
 	.speed_std		= DW_IC_CON_SPEED_STD,
@@ -88,6 +122,26 @@ static const struct dw_i2c_con_bits dw_i2c_con_bits = {
 	.bus_clear_ctrl		= DW_IC_CON_BUS_CLEAR_CTRL,
 };
 
+/*
+ * DWC_IC_CTRL bit layout for "ti,tda54-i2c".
+ * There is no defined bit for RESTART_EN or SLAVE_DISABLE on this IP.
+ */
+static const struct dw_i2c_con_bits dwc_adv_i2c_con_bits = {
+	.master			= BIT(0),
+	.speed_std		= (1 << 4),
+	.speed_fast		= (2 << 4),
+	.speed_high		= (3 << 4),
+	.speed_mask		= GENMASK(5, 4),
+	.bit10_slave		= BIT(8),
+	.bit10_master		= BIT(9),
+	.restart_en		= 0,
+	.slave_disable		= 0,
+	.stop_det_ifaddressed	= BIT(10),
+	.tx_empty_ctrl		= BIT(11),
+	.rx_fifo_full_hld_ctrl	= BIT(12),
+	.bus_clear_ctrl		= 0,
+};
+
 /* "snps,designware-i2c": dedicated read-to-clear register ID per logical interrupt */
 static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
 	[DW_INTR_IDX_INTR]      = DW_IC_CLR_INTR,
@@ -103,6 +157,21 @@ static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
 	[DW_INTR_IDX_GEN_CALL]  = DW_IC_CLR_GEN_CALL,
 };
 
+/* "ti,tda54-i2c" CLR_INTR bit to write per logical interrupt */
+static const u32 dwc_adv_i2c_intr_clr[DW_INTR_IDX_MAX] = {
+	[DW_INTR_IDX_INTR]      = DWC_ADV_IC_INTR_CLR_INTR,
+	[DW_INTR_IDX_RX_UNDER]  = DWC_ADV_IC_INTR_CLR_RX_UNDER,
+	[DW_INTR_IDX_RX_OVER]   = DWC_ADV_IC_INTR_CLR_RX_OVER,
+	[DW_INTR_IDX_TX_OVER]   = DWC_ADV_IC_INTR_CLR_TX_OVER,
+	[DW_INTR_IDX_RD_REQ]    = DWC_ADV_IC_INTR_CLR_RD_REQ,
+	[DW_INTR_IDX_TX_ABRT]   = DWC_ADV_IC_INTR_CLR_TX_ABRT,
+	[DW_INTR_IDX_RX_DONE]   = DWC_ADV_IC_INTR_CLR_RX_DONE,
+	[DW_INTR_IDX_ACTIVITY]  = DWC_ADV_IC_INTR_CLR_ACTIVITY,
+	[DW_INTR_IDX_STOP_DET]  = DWC_ADV_IC_INTR_CLR_STOP_DET,
+	[DW_INTR_IDX_START_DET] = DWC_ADV_IC_INTR_CLR_START_DET,
+	[DW_INTR_IDX_GEN_CALL]  = DWC_ADV_IC_INTR_CLR_GEN_CALL,
+};
+
 /**
  * i2c_dw_select_variant() - Pick the register offset table, CON-register bit
  * layout and interrupt-ack mapping matching this device's IP variant
@@ -110,9 +179,15 @@ static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
  */
 void i2c_dw_select_variant(struct dw_i2c_dev *dev)
 {
-	dev->regs = dw_i2c_reg_offsets;
-	dev->con_bits = &dw_i2c_con_bits;
-	dev->intr_clr = dw_i2c_intr_clr;
+	if (dev->flags & MODEL_TI_TDA54) {
+		dev->regs = tda54_i2c_reg_offsets;
+		dev->con_bits = &dwc_adv_i2c_con_bits;
+		dev->intr_clr = dwc_adv_i2c_intr_clr;
+	} else {
+		dev->regs = dw_i2c_reg_offsets;
+		dev->con_bits = &dw_i2c_con_bits;
+		dev->intr_clr = dw_i2c_intr_clr;
+	}
 }
 EXPORT_SYMBOL_GPL(i2c_dw_select_variant);
 
@@ -432,13 +507,27 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 
 static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
 {
-	/* Write standard speed timing parameters */
-	regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
-	regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
-
-	/* Write fast mode/fast mode plus timing parameters */
-	regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
-	regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
+	if (dev->flags & MODEL_TI_TDA54) {
+		/*
+		 * Only one HCNT/LCNT register pair backs both speeds on
+		 * this IP -- write whichever value set matches master_cfg.
+		 */
+		if ((dev->master_cfg & dev->con_bits->speed_mask) == dev->con_bits->speed_std) {
+			regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
+			regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
+		} else {
+			regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
+			regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
+		}
+	} else {
+		/* Write standard speed timing parameters */
+		regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
+		regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
+
+		/* Write fast mode/fast mode plus timing parameters */
+		regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
+		regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
+	}
 
 	/* Write high speed timing parameters */
 	regmap_write(dev->map, DW_IC_HS_SCL_HCNT, dev->hs_hcnt);
@@ -493,8 +582,10 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	 * Mask SMBus interrupts to block storms from broken
 	 * firmware that leaves IC_SMBUS=1; the handler never
 	 * services them.
+	 * TDA54 SoC has no SMBus block, so skip it.
 	 */
-	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
+	if (!(dev->flags & MODEL_TI_TDA54))
+		regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
 
 	i2c_dw_write_timings(dev);
 
@@ -538,6 +629,14 @@ int i2c_dw_fw_parse_and_configure(struct dw_i2c_dev *dev)
 	if (device_property_read_u32(device, "snps,bus-capacitance-pf", &dev->bus_capacitance_pF))
 		dev->bus_capacitance_pF = DW_IC_DEFAULT_BUS_CAPACITANCE_pF;
 
+	if (dev->flags & MODEL_TI_TDA54) {
+		device_property_read_u32(device, "snps,tx-fifo-depth", &dev->tx_fifo_depth);
+		device_property_read_u32(device, "snps,rx-fifo-depth", &dev->rx_fifo_depth);
+
+		if (!dev->tx_fifo_depth || !dev->rx_fifo_depth)
+			return -EINVAL;
+	}
+
 	dev->clk_freq_optimized = device_property_read_bool(device, "snps,clk-freq-optimized");
 
 	/* Mobileye controllers do not hold the clock on empty FIFO */
@@ -854,6 +953,13 @@ static int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 		return 0;
 	}
 
+	/*
+	 * DW_IC_COMP_PARAM_1 not implemented on this IP;
+	 * fifo depth set in i2c_dw_fw_parse_and_configure().
+	 */
+	if (dev->flags & MODEL_TI_TDA54)
+		return 0;
+
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
 	 * the depth could be from 2 to 256 from HW spec.
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 4c782594ab4e..bd96abf63c39 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -79,6 +79,18 @@ enum dw_i2c_intr_idx {
 	DW_INTR_IDX_MAX,
 };
 
+#define DWC_ADV_IC_INTR_CLR_INTR		BIT(0)
+#define DWC_ADV_IC_INTR_CLR_RX_UNDER		BIT(1)
+#define DWC_ADV_IC_INTR_CLR_RX_OVER		BIT(2)
+#define DWC_ADV_IC_INTR_CLR_TX_OVER		BIT(3)
+#define DWC_ADV_IC_INTR_CLR_RD_REQ		BIT(4)
+#define DWC_ADV_IC_INTR_CLR_TX_ABRT		BIT(5)
+#define DWC_ADV_IC_INTR_CLR_RX_DONE		BIT(6)
+#define DWC_ADV_IC_INTR_CLR_ACTIVITY		BIT(7)
+#define DWC_ADV_IC_INTR_CLR_STOP_DET		BIT(8)
+#define DWC_ADV_IC_INTR_CLR_START_DET		BIT(9)
+#define DWC_ADV_IC_INTR_CLR_GEN_CALL		BIT(10)
+
 #define DW_IC_INTR_DEFAULT_MASK			(DW_IC_INTR_RX_FULL | \
 						 DW_IC_INTR_TX_ABRT | \
 						 DW_IC_INTR_STOP_DET)
@@ -291,7 +303,8 @@ struct dw_i2c_dev {
 
 #define MODEL_AMD_NAVI_GPU			BIT(10)
 #define MODEL_WANGXUN_SP			BIT(11)
-#define MODEL_MASK				GENMASK(11, 8)
+#define MODEL_TI_TDA54				BIT(12)
+#define MODEL_MASK				GENMASK(12, 8)
 
 /*
  * Enable UCSI interrupt by writing 0xd at register
@@ -352,12 +365,15 @@ static inline void __i2c_dw_read_intr_mask(struct dw_i2c_dev *dev,
 		*intr_mask = dev->sw_mask;
 }
 
-/* Acknowledge a logical interrupt via dev->intr_clr[]: reg ID */
+/* Acknowledge a logical interrupt via dev->intr_clr[]: reg ID or bit value */
 static inline void i2c_dw_ack_intr(struct dw_i2c_dev *dev, enum dw_i2c_intr_idx intr)
 {
 	unsigned int dummy;
 
-	regmap_read(dev->map, dev->intr_clr[intr], &dummy);
+	if (dev->flags & MODEL_TI_TDA54)
+		regmap_write(dev->map, DW_IC_CLR_INTR, dev->intr_clr[intr]);
+	else
+		regmap_read(dev->map, dev->intr_clr[intr], &dummy);
 }
 
 void __i2c_dw_disable(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 329f958ded3e..94594f6349d4 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -42,14 +42,16 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	u32 ic_clk;
 	int ret;
 
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		return ret;
-
-	ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &comp_param1);
-	i2c_dw_release_lock(dev);
-	if (ret)
-		return ret;
+	if (!(dev->flags & MODEL_TI_TDA54)) {
+		ret = i2c_dw_acquire_lock(dev);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &comp_param1);
+		i2c_dw_release_lock(dev);
+		if (ret)
+			return ret;
+	}
 
 	/* Set standard and fast speed dividers for high/low periods */
 	sda_falling_time = t->sda_fall_ns ?: 300; /* ns */
@@ -135,7 +137,8 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	/* Check is high speed possible and fall back to fast mode if not */
 	if ((dev->master_cfg & dev->con_bits->speed_mask) ==
 		dev->con_bits->speed_high) {
-		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
+		if (!(dev->flags & MODEL_TI_TDA54) &&
+		    (comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
 			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
 			dev_err(dev->dev, "High Speed not supported!\n");
 			t->bus_freq_hz = I2C_MAX_FAST_MODE_FREQ;
@@ -398,8 +401,11 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			 * If both IC_EMPTYFIFO_HOLD_MASTER_EN and
 			 * IC_RESTART_EN are set, we must manually
 			 * set restart bit between messages.
+			 * ti,tda54-i2c does not define a CON.RESTART_EN
+			 * bit, and behaves like it is set to 1.
 			 */
-			if (dev->master_cfg & dev->con_bits->restart_en &&
+			if (((dev->master_cfg & dev->con_bits->restart_en) ||
+			     (dev->flags & MODEL_TI_TDA54)) &&
 			    dev->msg_write_idx > 0)
 				need_restart = true;
 		}
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 42b34c678146..069c3dc0da10 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -257,6 +257,7 @@ static const struct of_device_id dw_i2c_of_match[] = {
 	{ .compatible = "mobileye,eyeq6lplus-i2c" },
 	{ .compatible = "mscc,ocelot-i2c" },
 	{ .compatible = "snps,designware-i2c" },
+	{ .compatible = "ti,tda54-i2c", .data = (void *)MODEL_TI_TDA54 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);

-- 
2.53.0

