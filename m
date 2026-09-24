Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF9EC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5F410F8EE;
	Fri, 25 Sep 2026 07:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AEOweyJi";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e8qfpOVR";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE63010E16F;
 Fri, 25 Sep 2026 00:28:06 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMQ4Hp486013; Thu, 24 Sep 2026 18:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=D6LnuUx1gmDSDZBp57639BYXzWxMieDrVVcjwc0dx
 84=; b=AEOweyJiUIrfaSrFebZ17/Zhmnj9TJsG0vWLLagHrIzEe/PX0bA+jlp5s
 BAiKr7Su2iasgFXMmiFtRg7Hxzn7cmAU22WgzH+bGsI4AYXyKZQTZ/oh5bb/S2Dg
 6k7zTSku4nN1VXeb3uKkCpFAmSvO0j51d8gYHaGLdDnMxZ1AnelFAbwAkIWfJCHG
 hdp06C8A8ap6GmqhFBuIOZebAYhptieCp9rLNCsvifdpk8z5mzSWCBc8qaIMGQ21
 0gC41bSkmIBJvgS1TdFcjpYknP7Xo4O4N0qYsexqqUyTVK8qsHSRnCGl18iDQdzt
 1QkKUqtfvOVQBHwiUmYAoeZiL4bRA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gvwm363ce-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 18:42:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ7/dxbVZ4YwJ0DRnE/99mvzJjqoZrNeJf+m2jhg1LMv9de8sB9HRhDU+Tbmhkaj5FFlNZiPM2dYGbVfQGj+Tv1Fz7zOGMYMVqx5VlC8YtZYWD4d9T7AKLr0X+Ox7p4yvw8xIFzAAavNJUeX+4MBdzjWGSRmTiaa4tQcLchukClM7+ZWVTC/SNcYMMYLfHE/hzACLB7fuB2YBeB65oCarfVj4VLK+twfHl85YkontMWIsSwmHylgIGimvmdTOAKXPrA847d6w2qwhA7OiSv1xLE0pp+n/6wDewWpHZ6nxWti0dLajyQct9X5xPFxja2fitYFrSga3rjJfgMI+dZYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6LnuUx1gmDSDZBp57639BYXzWxMieDrVVcjwc0dx84=;
 b=qJKcZSoeZDREH5T/6X0VADUQPKObD25RZqvEk9KeTT6ccOhaCoyIweGDUuC9DDhIVCA3xEI3EzjsxZP1qtlAxoUMfcRKiUJn3fLF8f3Q4HofSPuRjSrBmnV8IgpTT/8xjPpydJSYg3wjNJA8xFkqLmC3mzoDS7s9VVT4DGB5ERU+O7PAoe8ylVYH2x/MbiTRxdhBJGZWJ0K23vgbflnJ2WIIDkJlhs3LbnL/snWGPPKu2dG6nHqGi/GofFb9LU3d7LWkUf/oFfmpgwy14/CpgUlfTvBh+jWuF6hr2M1+t+qJIEvUzRzKiBS8L7HD2yl5s/ZDialMr3we5d85VLO5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6LnuUx1gmDSDZBp57639BYXzWxMieDrVVcjwc0dx84=;
 b=e8qfpOVRtldTn16VNxsljJvFKgqLJlrEODItHfixBI3zR5xbA0VFNCOu+Jc5HAxExQaeKgXI+YlB4Aoji9AhedhaliAk1H/jwV8LsV6RG+sqwAMKKwKhSHJm1AO1pVFaaGHfP0TQnne243QDgwRo9yJR0ptXWigbdQO3lj3rY6E=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 23:41:12 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::60) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 23:41:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 23:41:10 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 18:40:47 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 18:40:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 24 Sep 2026 18:40:46 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68ONeXkv785172;
 Thu, 24 Sep 2026 18:40:41 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Fri, 25 Sep 2026 05:10:20 +0530
Subject: [PATCH v2 1/3] dt-bindings: i2c: dw: Add ti,tda54-i2c compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260925-tda54-upstream-i2c-v2-1-261785e58493@ti.com>
References: <20260925-tda54-upstream-i2c-v2-0-261785e58493@ti.com>
In-Reply-To: <20260925-tda54-upstream-i2c-v2-0-261785e58493@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab64bd5-6bda-4d07-4fd6-08df1a955051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|921020|13003099007|18002099003|22082099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: /k4cB+ewoJy0sptJC7HvkEBbLhiA89qVO3GtO6mDCe8AHpbF5DgdbqK1hQ03XsfmX9n7LUY5eAyq/QLTOhowgdfPZeawAlnrK0PzkCCSA6oKxPtWPBHnahqAR+z4gbjcKUkRaa7292h79I+f37hRUw6gpHq9SJdpHOPQcmt3VrX89vsZSAgZSLi2bmYo/mb/HCCmpdgou29xUsarIH7GJEHdiWr4Yg78tznMBjz3W/gA0xMczRjhTpFSganhAWUxJ8FYNY4PNlafwJCdqsDNudK4Dl+GxLW2avKiy0rhabddYYD31Wb2hldRR9j80rX91bROtTcYafrVoeNs6xg2EJDqiW0lqPaJg1yZS25OwE+EXudzeoodrIWisLHcGLyCKUq6ML+aaOqowOymM1bWfDzX6GSjBSgPBy0QSwixzVohWHdtnxh5zJmalURO+QNB4Cb3rPUjPTpxiksoukVs+u0bCM/iuZyGjJ9aFkuk7Cf1jhIMojvTJWT+zkuvd/GhgyZg5pzPP3NP6SJcpgOKtDN/DZoj9rmDyt2+0nGJOVxb8JwfhY67w8kVwDyAB5otGYim1njlifFn9gFJm8j6gOT19un0KGvTsxghDoraWm8rbjvVYUDfFc5sc7jaTvHgJuK29SqLpOl3J0cdr0cJzbpWgKtErpYFdUcihDuqhu31Otn5Gco90LC5P7vWuBLdVDWhGjWK7GjMWu1USkl2fQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(921020)(13003099007)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D7SsqagKwGcRFCPEtK3VSQQ82yTxuEBbD8cBkRGInFdD3NTOHPaqfgoPSOJmQN5yWIW9JE99SAXenTwWPbJGYTCbmXu3Rvg34D2dbIZUhsLrDHBCgwCQx49BMunZwOfEgkuNRSH/omb6jaU/FT9WxcR/teYz2hTkOB1QQCAcWOPeJE8AkIdmZ17wC7WbzeIUwFh/Feh5pWbgtfmfOSiwyxmw+p7DSyPgMwjf1qUzYGAhbhx8T42/32caMPpqqNJi108PzfL8wp5iCSuqSWkOMwCzpjwrGzucC4z/iFm8R2SkGS9vwsEPH5aJ96qC6qe8uWX5YV3pCGGSK5yrUCuO8e70JsLpXD8AvNWPgj/UZ+2/V8KoxIey/ak1jkQCt3GPwXwd5dcmckcDSKvhagrbirk4egLuuNs2UazBeMByqIsy22zGxBmPkJrbdtuqO9dG
X-Exchange-RoutingPolicyChecked: cSI2OO/iTgXQ0PyaWWMzu8qOi3lvuzQBgCrbJPafkA0V24UqDV0smGKV5NTp62JAPyGbAoZyN3jQtdHvqGv0ZUmgo4ljgNemU532Pd1iCVdAV2umh4aC2qiNyh5uKXb6tIa7+Zjbnp+E+EZZlN+eIQPDGW0G3aiXnbq+fb5j1GwbYqT9pxE/peiojNtnp5Dcsn4a+v87lTVqTZZ+VC52etWGJ64GDLVQhNRUvqdjYetc9swuJ0K35RvCVIIl8mEnLatoGJacwDu9g7Mo7+6/aEe1TmIb2ZgaKw3xUTOyxahpO82xZly2ij93hz1tSV7WQcZv65tBoAhk6FGk/E6lAQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 23:41:10.8463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab64bd5-6bda-4d07-4fd6-08df1a955051
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-GUID: tuRzgsi5EwB8un4AMYBpLTvUTrXrECzf
X-Authority-Analysis: v=2.4 cv=EvdHPicA c=1 sm=1 tr=0 ts=6ab5b578 cx=c_pps
 a=0pMqp0B7/3h4ah4p3fuJNw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=sXrg0fSgDYXE2HFaoGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfXwTrqlIKh56uE
 1fSh25vykpIR6prLAXyHAjE9R6PfcN/IuZSBmlfT3SyXDjLG77HPJsqq4Bd6WcjY1zjnHOVf3GE
 XQ0EPuKwg7UzQ5wXrKxY8DBHzaMC2scsUGrS6hJ2S9a4aRwHtdrFtY3jkhVI6hQeAeW8wa8iL8r
 H6s0eR3s6fd0191Of+PNoCCg20pvbA24dNSkHfCfTzZXtk0yJKyn73h/N93AqviMIOzfSslsn5/
 SwSN4QqbbnyPYp9G4tqvBdxOGncxov28zqY3UrIQ8m6L5YHd2Ua1tZsBMl1XqtOzYZhG4Bl94nI
 emUPUegVd5jyvxi1+K8dnwvwc7wSnAkS9KWnTjPB4EPFBXk7WqPKDAJd4bDdp7SdmOws2G0Qtmy
 J2YGh6w3DUqb2ImYVWTUgsOBFGmgDHt2FIBa921HeGZhjns49cC12a7EqxXGarr6D66T39KT2FL
 oAvPKfrCDJZU8LDXfkA==
X-Proofpoint-ORIG-GUID: tuRzgsi5EwB8un4AMYBpLTvUTrXrECzf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX7GDiTe4o+GXJ
 hPAuy4RXuRgoAqW10j6UTfHHlhQR6wYouM0OGkOI4ocszw99SfJcjE+TQz9Un7TaXJrtmrWzE6X
 /2M/nCC9eU0VH8jlM/QqDwAEyu0s4HI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240096
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

Add the "ti,tda54-i2c" compatible for Synopsys Advanced I2C Controller
(DWC_i2c) present on TDA54 SoC. Compared to the existing
"snps,designware-i2c" (DW_apb_i2c), it broadly differs in its register
offsets and some bit fields, requiring changes to interrupt handling,
timing handling, etc.

Unlike DW_apb_i2c, this IP has no COMP_PARAM_1 register to autodetect
the FIFO depth from, so add snps,tx-fifo-depth and
snps,rx-fifo-depth as required properties.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---

Changes in v2:
- Rename snps,dwc-i2c to ti,tda54-i2c
- Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com/
---
 .../bindings/i2c/snps,designware-i2c.yaml          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 467bdcbb8538..80a9376d6de7 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -21,12 +21,23 @@ allOf:
       properties:
         reg:
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,tda54-i2c
+    then:
+      required:
+        - snps,tx-fifo-depth
+        - snps,rx-fifo-depth
 
 properties:
   compatible:
     oneOf:
       - description: Generic Synopsys DesignWare I2C controller
         const: snps,designware-i2c
+      - description: TI TDA54 SoC I2C controller (Synopsys DWC_i2c IP)
+        const: ti,tda54-i2c
       - description: Renesas RZ/N1D I2C controller
         items:
           - const: renesas,r9a06g032-i2c  # RZ/N1D
@@ -121,6 +132,18 @@ properties:
       low period of SCL line.
     type: boolean
 
+  snps,tx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The depth of the hardware TX FIFO. Required on the ti,tda54-i2c
+      variant, where fifo depth cannot be autodetected.
+
+  snps,rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The depth of the hardware RX FIFO. Required on the ti,tda54-i2c
+      variant, where fifo depth cannot be autodetected.
+
 unevaluatedProperties: false
 
 required:
@@ -172,4 +195,14 @@ examples:
       interrupts = <8>;
       clocks = <&ahb_clk>;
     };
+  - |
+    i2c@53b00000 {
+      compatible = "ti,tda54-i2c";
+      reg = <0x53b00000 0x1000>;
+      interrupts = <166>;
+      clocks = <&sysclk>;
+      clock-frequency = <100000>;
+      snps,tx-fifo-depth = <32>;
+      snps,rx-fifo-depth = <32>;
+    };
 ...

-- 
2.53.0

