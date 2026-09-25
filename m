Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D08C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8252110F937;
	Fri, 25 Sep 2026 07:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QUu3fQ/q";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qZ1sW0i4";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CAEE10EA01;
 Fri, 25 Sep 2026 06:57:17 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68P4a0JY1381423;
 Fri, 25 Sep 2026 01:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=D6LnuUx1gmDSDZBp57639BYXzWxMieDrVVcjwc0dx
 84=; b=QUu3fQ/qcdCppnBZaCEZSJbyPkBHe7MCCYphKezdVuYbE5Q+RkItjdrWH
 kg3wl3KI6lJmJDCPc/HnyZtpGxyyCxkXe8oaZAY5/E/ar71NFxBJD9AKI6CRun/V
 1aluZSDzS7cM4MtTIMYgaIVE1YNoolIlHT91Dj6z6Qr8azaKBAhMSbemA1qQkKVn
 ZB7N/AtTff6bNTTbs0yjp7O2GcTc+2aabU2vweQrA8ab+Joe7YMTlXTSlxOP4gMw
 MQCSN1WFFgdfTxS9Nj3Nh7EVOydRXXfYrRorsBCY0aLch3wzhYl3DqHAw68WNKKe
 8BFPbvknC9dBpq4dJTojIgplD2qgg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gw13rf08r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:57:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASe9sTq+lV2mkh01tfRhHmKzZv34OniOUjYTwn5ISHz0Rx546eLEdtNY8LABGs8PI/UHR7W0nnHooVtmjcBYjXLPY0rQ32B1/DimhV3//FGHRzcDCy5HYK3A/aawzRHlRG0t40/ugOz02+U+0+Z+iJblFfa+X1tuZ6MqQcN48idZ1OXSdnKSpJF2+taQmRYptgAUXQ7QSLEs842JfYJQB0FuptfuExqQQIagLj4/QpvSiqh7Bo/4Xk9lJCYa8cbPqolls8gvNHkOP90fjqpj1IdsBa6G4CmfA0Sif+4gDKeshOTFeX074P8tx6KvnKYh0pAr7K6pm+Fi5c85uQXNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6LnuUx1gmDSDZBp57639BYXzWxMieDrVVcjwc0dx84=;
 b=OlgXjdQM9s/IVkGAebGcEQCmv/708NxfUgdoXel7oSBmmkep5VEPQRMbffENib6JnhNZOMs4Vl9Ovqdi3wzFRlpYU+/oDVaS2HAv9M9qovCxwatQPMVmMReNa+gQNsFZU0mBzEerHNNS4l/tmAHKAXgz5AQ99MFNgsmqN08jSdBPzdcpkaq4uUryMK/8NZLupDYpp3PxJwgroWT/rDFPUYMy+mF3wzYqBBV3bH3b+xQVNe538aJKagOW5/nZM0mvG0p951BdGO9fQck0gotaL4QBDSiIYKLTNZENkPSHfB68ucStjzyC+zM0jXjzVmqqpMmPzbDGTtj3Sh4Fn/0+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6LnuUx1gmDSDZBp57639BYXzWxMieDrVVcjwc0dx84=;
 b=qZ1sW0i4cHSvHM13PUNrKeuHLzkQX5R4uOlZpKlcEI5FKyS1YQyxAAcMvp1mUPqLgRabrhuYTQ7AjDBF98HHnb5aKk3KBtNjkIJCmrtW5VWys9ygHq/nGe8hrp3xsL8TnugNFIk3XdqaJb7TZcAhepBV3uKQNMwBGInyew3YZ0c=
Received: from BN9PR03CA0937.namprd03.prod.outlook.com (2603:10b6:408:108::12)
 by DS0PR10MB7521.namprd10.prod.outlook.com (2603:10b6:8:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 25 Sep
 2026 06:56:56 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::43) by BN9PR03CA0937.outlook.office365.com
 (2603:10b6:408:108::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Fri,
 25 Sep 2026 06:56:55 +0000
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
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 06:56:55 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 01:56:48 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 01:56:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 01:56:48 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68P6uZ1J1371804;
 Fri, 25 Sep 2026 01:56:42 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Fri, 25 Sep 2026 12:26:28 +0530
Subject: [PATCH v3 1/3] dt-bindings: i2c: dw: Add ti,tda54-i2c compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260925-tda54-upstream-i2c-v3-1-544d74e992ff@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|DS0PR10MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2a2520-e128-498e-0693-08df1ad22fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|82310400026|1800799024|36860700016|13003099007|921020|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nBpm73OR3jWO4hSzMdI6mGzmCnYuB5HibIGWf6AXMMly9/eNIadVgxjbZnd87P2lPZQuYZA7QNk1+lRpmAH6mD9BdNabyHM5MM6riyjYeUAldXvrHWMvRzDu0lK7TJBlpkwpsO7y3kpd0WYlq1vFIbmlAqV/lDKrWKwnx3UF1M/2IyRuUYIn+Xytfu7IrjfEmiinRJES6CcynwcOVXrKXIo5Jr7V2tsSx279EbA5AEEe6EqptlmnAXJjblzMMNILF60JVIf45DOpRSbzrLNuQYC3V7Unt6/U85RPVwbYOpvGqRq0uXeIM7uQY/efo45DwLuWap2eS0Y2zdzgMXcG1zeYpEfStkEnn6hwhKig+sPUN/rFrSJcl7tNoxbqPShRkNNtKkmSuahcJmipO94Zt9ZuScvpYRh4D1jrhxOKIQUl26dqDEkYU/o2VhUfXsoa3HnjABEqMpey2QVxHaM1lk9T5s91esKUY/Hsj/izXooHbhC/Zigon+EwVZuYG8e9kLGEIChQzqj5GhrHGJMwUuhJIOK06SeQKG6cbjJPFq5L26BamKI46iQpdwYYfUn1V1IswGdVN3KBE3KkEHAVJWGY++HHKcjkrcqzVxO9O1BwGjHV8Jh9NQ2vZ0n31wa+PINdNfgLycuSZL/Q7de0+B2elGYvXBawilROcTSJI5JAhiB3cT55Ru0Lw14hyvCHWs35SgTnyy0qDmm3Nb5Y3g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(1800799024)(36860700016)(13003099007)(921020)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jt+pcq3rHaD3lQM0u9SD2tQYbhkDj/VE0NrWC/1I8qPm6SpFVbnGtR2aqokKBDnFKaLp9Jq/nnB0qbKiGwey+s83VBbvWv+wCCKgPuRMzHWTicrtCp7TNpesaJZ2IHwDVh2yn72oQC/8t+kiTofc5mo73IdYRBECFDOvRyrpGqI1n5YvMmCz8NkmLDhcznSsPGHPatbMHndaMOJl0i9dg2zZq0cGsL6SGgOqpe9Lvwz0IXWxxx4/rx2zD638jLf9Sr7bXIYA+5iWhe+n81wE/bRhRLo8c2px4jrZDQ4eMT+f7P++k4Aeynkfy99waykd65cC3XWP7IbkG8wPfAejKgSOKvfc0nvPufOBqJbgcIJCEp3Jpmv/XBtGrPorr9qfxjJb1Bi+EFpVWroa2WaJF+SS1pVV3PzcqhrE2Kt4xreY7dNv9tFs2pbmDkEHLiJB
X-Exchange-RoutingPolicyChecked: lyVv32UMZSREUjRnq5rQcHh9XZ3o7IABFIWTLCW2PhMpGP8T+Dh+r8K5IHTf2DPv+iipQBFeF9y6Rmlksb00mYgHIme0mfEpTez2XudlEhYrnkLppLQo0n+GORiyE52C4kc5lrXy44OKnNxS83GRbfC3pD75L9ReX1meybiUvw7AbEs6/2nlKPNdGfWRYYx4qTT76NX+IjvLUNtmBjId7WtQsBrDO+m33VPuKDAIXV0dUO8O1SHD/v3QJT2CQP/4f+nUYDl7iKYv2eRQXlBzfmJVKCHcOw+1brxYqNFVOlzQhPzsooKncy1eeA5JnAnSxW3I3kMWi4oSkxFDO1V7kw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:56:55.6442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2a2520-e128-498e-0693-08df1ad22fd3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7521
X-Proofpoint-ORIG-GUID: 4Q3GxcZGYnyaSJcVc0TOYvlKXV2ekhv4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX4dlAB6BBa38G
 kf/Tj7dZmpQ0e88tu7aI9uuRBQKnXA3yRaRZF2KC8kWNIPGrRIhpdO7SOD8fHQWzVVCS9qFvHHa
 z7p8KcXH+534y3dIc/A68H7sqc5Wbb74v7JtpbP/ipMl5Dis72+T3XJgJva8/GmYJZmJCaIvCZh
 dwe9zzG3N1lyyJLQhQe3xNJqfiNaujP0V/03pQeyWmbgmxZUeapBmrwqL9iIVvKSDUPuBVHaFv7
 w0aTHnD5xCjecdHufDHVs9ndigagLvRSlWjLrGkH12RWjI+UHivJZ7rRczDIRL3D9by9rGl5Skk
 cCp7VdvAkHO48HXVNfcTcr8XU9vzEYOv5q+D7MVrFJQvBN36Dmxu8vf2KekmrBd6BjNL/tDo/3N
 A7Ak/M6y8PpDh3v3qacVSnTiPhuBVk3OR49n50tw6nX14kse/CgH0EXnO3kGS0SQrGR0BGbDBfv
 haP8OaILaOlvskjw5Ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX9kfTNeCkOM/4
 dtPuoTPcB5bfqkSw2Kh7Nk6VdoPPP3i8YNOuEaXvIpp0ZB2osM91eEPqd0c5LoJKIbVCg4D7cBY
 sTKEWYUzmZSL4OWmQ/3XMY3e2H6ojDg=
X-Authority-Analysis: v=2.4 cv=OICyTiaB c=1 sm=1 tr=0 ts=6ab61b43 cx=c_pps
 a=p2I1UVXXVW7tbHwl5ZyrfQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=sXrg0fSgDYXE2HFaoGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4Q3GxcZGYnyaSJcVc0TOYvlKXV2ekhv4
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

