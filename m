Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC36C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A60510F910;
	Fri, 25 Sep 2026 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lDQLOTDw";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XjX6FGaI";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3757610E558;
 Thu, 24 Sep 2026 23:41:24 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68OMPvpJ1704200;
 Thu, 24 Sep 2026 18:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=AV/a21k6DC7qu
 YieiaKOUlDCdw1Rr4B1UR3Xd/z2dqo=; b=lDQLOTDw1EZPCr3OuuUdE86kR+V++
 iwogBUDdUCM16/QCND2sAK1qBt16cerX1VGzVnolJv5/XZhrV6/jWRoKvWcIxyQq
 ejap+St1ICr4XOz4/NV8qBqKadY2mConuT+IIXUt5h416/AJitnVfYTumYgpKFaj
 STmeejc0SbCwgdpgEnexB5x4bASIZtgoSOTX50PdFTNifgadmCa28DGafXI5ct9T
 glrGyk0OTpnLe+hzPFgTGJQsry6nkB4iz2cXQI7s/M6rSEzjJkPTl8bK6Cl2S9Ws
 zuUDXdYDeiBHJVm4QoG/cnSCxB110hieNF2d2dzEBbK0urYz8n5R2uNNw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gw13tn1c2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 18:41:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyHSIpdfH9N8WkZ0B/ykh/GyO5DNluQeZhXui2ixSkW53farx9V/2Jv0m5NM0S9aUt76US8ujgOwXKx/o57oYPP6p/o09og1VzPpTtQqkR5dd4vfmAvxhHjSk6+1t5qh/ouC/FVNul4I720OGdCHK+4tw7HeCZg5fqB7H48eJe+JxFdivvJaHnW0pCiCuC7AysfgxuNOhm1mY/QektFjZQoiF8WD1/1Z1/Z7MgCILMhOg6ZkQaw5XnevbMnz/qNb5Gws87X/GKeQ9gLRgsiJt4qdNkXLntWwM8auvLa2gT+9h9qnB1UBTGEpFdnlTOZCl7ft7H3Ej+Pq/UeuimXyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV/a21k6DC7quYieiaKOUlDCdw1Rr4B1UR3Xd/z2dqo=;
 b=pTasoY9ycBSLhtgLVaXxhmpKJkz0VmFU/pYuAEdTspHF9GrUFjD+j8aRPVhxXQ9T/RSu8JoQRkEggC7aUYMcfZt17X9qe0SFAPom7UR1cCDvfm2S1Vgy2gt79ufAOMAuAog7ad4DfRfwbtAOlmXDdEOlPDbpLPz6mmsGBhfICWxp/mYkKcur3uNmOcenZEFDFxi8T4e49pzIT/DbwiU1mJGTC9LwZ3JqxuTHsFUb4nU1aY2oAhyrIvHnMwuBJU+04tArntwUOtfCZknjl5hu3ns/TKJRPt/r9U6c/nSWG89ptx5PihhNjvEMi2l9Jk+uOSbh+eGp6A5psFCCRRE7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV/a21k6DC7quYieiaKOUlDCdw1Rr4B1UR3Xd/z2dqo=;
 b=XjX6FGaIG72H+/sKvj1A/WvRxJmDr9dQMYv0IeJxyWDdSBFysET9ea4kKzzcNiEwt98BmKySbb0Xhy37j9GCejK4uQV8JFIElVbWwIjt/Rw7i/vXOx+mVxYBKU4tcUSunYUa/cg2yOM/KQKNRhQ9zleuGWP01DKJCYTegk3xZkc=
Received: from MW4PR03CA0152.namprd03.prod.outlook.com (2603:10b6:303:8d::7)
 by CH0PR10MB5097.namprd10.prod.outlook.com (2603:10b6:610:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 24 Sep
 2026 23:41:10 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::20) by MW4PR03CA0152.outlook.office365.com
 (2603:10b6:303:8d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 23:41:09 +0000
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
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 23:41:08 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 18:40:40 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 18:40:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 24 Sep 2026 18:40:40 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68ONeXku785172;
 Thu, 24 Sep 2026 18:40:34 -0500
From: Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2 0/3] i2c: designware: Add TI TDA54 I2C support
Date: Fri, 25 Sep 2026 05:10:19 +0530
Message-ID: <20260925-tda54-upstream-i2c-v2-0-261785e58493@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOO0tWoC/32NTQ7CIBBGr9LM2jFAarGuvIfposBgZ9GfABJNw
 93FHsDle8n3vh0iBaYIt2aHQJkjr0sFdWrATuPyJGRXGZRQnehlj8mNlxZfW0yBxhlZWXTCdtr
 LzrTeQh1ugTy/j+hjqDxxTGv4HB9Z/uzfXJYo0AjTe60Nyau5Jz7bdYahlPIFudKiFrEAAAA=
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|CH0PR10MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2097c348-66bc-47a1-efa8-08df1a954ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|7416014|36860700016|13003099007|921020|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: kHHfwBsCt5nsvPZEbYoHrGounq/MGtW7Y5Nt39+Di5C8KgY/M7czAU3aMZ4FubeeNYVxZAK5BlK8BhRoqkOiadGe5QYswWYEN1lIf1442QcHXoWS8uZp/ATXwniAj29zY3CYDil0MOFR9qVrcEJdTbVkpj/Uez4LfNgKEUWvmENgCd5BDCzUhsiyolL5hvpaZR8ocVAxWuf8w2Sr16X48bWGPwpYmxQ/jI08pLC90+lQE6jAhdS6/0THyYr1pjC2HojG4bZwlhcqXZGkFej1pLXK5QTDF4ain2ceYhK3d5iIRah8ejLMNRE7sqdl0DlbRE3Nbxu1ZXUnLrj8nlDeqlTvysC/6DfYI+bz8qqKNNhxyNB5ROC2Ma5SwES+WBK7mbNYuRk4hzKy4ySTCHy6kZL/A5niQktTfvv3pvi6jR7SaXTfbLKrv2txAroj0wMYrZo41vM8AplulLDIeSmcrNbv92DIZlE2Wns4TcjCnsF4MY2JqfctUTq5x3KkfdNwd5xnnspmJj3gfpcUa1FwvN8V+jiilN6RAvdTA70EWT2H8Botei891QFBUb+aycZ+QunZg6epcrNfWhuaIWMuO1ydblL0UoEcwc9TFhCgLKhktneFO6SChHZ1JtvZC5TLG4F8tMOU+7zkohsIp0buGTy3GWbZ/iysiU9PsSHz70XOvcLwwnsRYw7GRfZYvXKeLp/LfSbi3ociEIegII1kBopGVa/iE1kgifmALW+s9ZzJuj72pS8f7qYWd3LPXqpz
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(13003099007)(921020)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XlLMzdEPwH/nIMvPWk//Y3vP6EHFvvc4Vyhgz6w73JfiaJjJnf+v/IfkLYijETiF1KMlKAA91D+Zmc3ng+gPSUt4Wp3t3ShJyp4BivWK8GxaOoPLuplJ3vHcQD7v+eTRB6REzx+KRsWdE17M/NDW3mSdNqtxT94nL99B0XUKAWKhfr/+EG7foF4R5YFVcQutUMuJOkPyUwduWUaJwDkRMb5JbKhMEf/B/p2Bvq483q3yKcANyxQ6eOCB3yuKqYBv5MgvCpJ8K/e1oLQ0VRGXHZR1U6q8vqU8Z8HVomUPzZeUGWfsDPJhdu5i1dVvkjn7JdlhVW7uRwelSCHip6N49LQrPBPIPG4tImga+k8uEIBIHY9nyaq19L6xhdmGws2ZK+YeGzQWacNyIiiofH1MmqjWmBCaCK+JTvDJ1F/WBj8gTT+tlulwTm7PI+go781H
X-Exchange-RoutingPolicyChecked: y0ndLAf0w2By5xNslR830B4VGwOhNxsyRWJ3IHHz3Zj9dhHG8dgTZwVziIw1kJigJsGkwhwNzszNhAV7ASkSO8COzJXoStHKESYEdByhlyJ2utfzNAYJUVBj2gypSvF3tXjIeJibcqU98pkLL95ew+K43RuaRMS/KaPW+VLv/aBJdEq6UnMsD1EK+3RpNLN0RqA9tHG83HvdaDp/BoLhfQyS32LMrwAZM1aPhZrH8SD6HrBuo8nObDL0wYpLaxxq+1WELVQY/vlqLhLxswGV96odvIiym17ObzODUeB1JWjr/QdjZEHXiNXCN2i9kzcn+90jRxCzEzKwM69Hwu0rHQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 23:41:08.4668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2097c348-66bc-47a1-efa8-08df1a954ee5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5097
X-Proofpoint-GUID: P6hTgkd1_UaQkXxXZEfeuQsO6z_ZeyNo
X-Authority-Analysis: v=2.4 cv=YKUKWhGx c=1 sm=1 tr=0 ts=6ab5b519 cx=c_pps
 a=NooIwpZNnZK4GOBrdp331w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=di3ura9MPRWK6PFUWBwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX/BKZXs2LPOGW
 OwFZsBGz3vKhlc7EoJB4oa7pErHaNTTwTGQcz32ybWUYN0/DV+mAKnsjWWJvt4/xLQPDGVS0SOe
 +8BBMH9lRG2vO74v2NICXPh4zhtajro=
X-Proofpoint-ORIG-GUID: P6hTgkd1_UaQkXxXZEfeuQsO6z_ZeyNo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX0l/xR9104QPC
 g1lshDJMlDYnerWPZC1DqlunJZM8mTlkwRsaH24WpCZii65oxZ8P4HTJGR+tzuQyh6VLJmQNaOl
 074rGvB1khLjEghmWOOsDZMRkldV1aVgWPRz93y6jD4UomBFTqAkJSt5P+YuYps56FneAKwKrkJ
 pEUTag9fGU8xyldUf19BGy2UnJrizP1thy7xRCNmr0nlGfqOuWIVi5RfY38uv0qStyBOzfcHw52
 FxgQcx+fMvyv0uBSWKuLM8m63nH44TH7P29270UR/5iVi3iMVtonG5uMEt4QbjkUzQMU/24oZrj
 GUNNkUaJTDM2c7YXJt6Ozv8ooBlwNLCP/Fi30zRR/CMVkRWSLq1jqzUFAfuwFaWDy5DS4/uO7n9
 CyPSv8y7NM8Z3ZRZx0ReMp8j8nswCevpzOAqz+jMIxQAPiA7XixVCDYNDXlh4TW+W+y9baw7ClN
 F5kwDApPJbiJnbelDbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240096
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
 drivers/i2c/busses/i2c-designware-common.c         | 198 ++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h           |  70 +++++++-
 drivers/i2c/busses/i2c-designware-master.c         |  78 ++++----
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   2 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |   3 +
 drivers/i2c/busses/i2c-designware-slave.c          |  26 +--
 include/linux/designware_i2c.h                     | 137 +++++++++-----
 10 files changed, 433 insertions(+), 118 deletions(-)
---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260919-tda54-upstream-i2c-d0c67f16b4fc

Best regards,
-- 
Aniket Limaye <a-limaye@ti.com>

