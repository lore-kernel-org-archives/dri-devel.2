Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAFC60A2608
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=WJqzxV86;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=CAQaVhwN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212DD10E673;
	Mon, 19 Oct 2026 21:38:37 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D0C10E673
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:25 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLboAu1358348; Mon, 19 Oct 2026 16:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Ir2UFyEM4M1XslXiI7EDfElxyNLGs3oW9GMsNDS91
 2I=; b=WJqzxV86yQKoCGX9AMcZXZ/oJ5g33wlQBAuvYZfCpAQGW/XMyJPbH9bx5
 AOwWnYQyUiE6Pf82UVnBqnex0ClBF7Cjmrj1vkr+0i29kvmczg+3BoUOCJ40IShu
 eHnFYBx2OuzYjIW0WS/EdovJkqTTGPrU+fjHC0SCVYORsUrtluAn0bIkjZlVleAq
 nAmgkQIoWv5h5xCGp1gaE4a+LDehIRfW2EnOrAjFGyccpIxka15ZLycNASrr88b6
 KDScLZUrzu9pCMXKMq8LzfjllZdloLQ59oVvZ91edIx8w3v1fvs+vkMOdlnGlGSI
 87Z3xEa5MlpsVluN6Rba2i/mw7xIQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd6157t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGD6PXH1nU4fsRr7tmze2nYNIiG/gMkOWnt4aMOcEtGey0lMtRh0vwvog/TKRaGrCLocGct+HNpxgIgaU+KPZ6mPOxr7Tmsqr7hb4pwIgDOWkx6B2U5N4FvPjF4f5q0BNUw9mj7JZHDFVm7Ba2YzGo83DXlBGq7ZC3A/DtwD+QfVu7k9stGrl/Hr2JczrUxAiOIdmAaXNJT4D3b7i0fEip/oAQ/e8MejlcM2D2EQFF4gKDp1hikZqPb6Z0lg5GKzwGkR+k1Bb7yPa4chb7y8BsGR8kI3VIJqLI8IwQcqclkNyIVs2/5sJknH56gjCVbF0R/0KL7D6TuHvFQcV0WU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir2UFyEM4M1XslXiI7EDfElxyNLGs3oW9GMsNDS912I=;
 b=FB6W5l7HxqrxbA3nN6Xpz0VCiemAlYG1Y2SrRA75HVs+MywiJrKt7ZfudkNj4L5u2DIpR0TvYoYQq4e2QfO/rG0SG7Fiu/BeILIf+CGsmwoBVV5mt7+Xzq206v2QtekZheqWmhuZB3y2WqnXnD8AA6MYNvKn+emoPvtanjKmfFVrWCooe8vZGVnDdpDUWvj+Z/iJUZPKGNupEOABEZtoQGySWtp8GzLFhglHhT2/WESG0YeJBwOFHyPJYeSTBMMrgU5rOn+OLy8pjamzh+mt6/9DLbhqybGN4Cfj3fea1r7IXYiTEaZ7SkbH9bNFZC+MTpSHHlGnH4EGNS8A5SayqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir2UFyEM4M1XslXiI7EDfElxyNLGs3oW9GMsNDS912I=;
 b=CAQaVhwNLMioXDjxhUEmn79hR9jxeb+mvtX9qW/1HzAlJ8W8AAgz8pDRaxTT8Be6VSipZIdXsa7XPCZocFLXT5opad0oKgbGRX3bOBhr6JdBdLnQrNzgznE6EuKqA6/IJKNeRzmmKww0IytQ+38vBEC40Z/cukVFCF/PHpjcGNQ=
Received: from BN9PR03CA0388.namprd03.prod.outlook.com (2603:10b6:408:f7::33)
 by DS6PR10MB397930.namprd10.prod.outlook.com (2603:10b6:8:4c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:38:12 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::98) by BN9PR03CA0388.outlook.office365.com
 (2603:10b6:408:f7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 21:38:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:10 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:35 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:35 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbYwh3576935;
 Mon, 19 Oct 2026 16:37:34 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devarsht@ti.com>, LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH v3 04/14] drm/solomon: Add DRM driver for Solomon SSD16xx
 e-paper display controllers
Date: Tue, 20 Oct 2026 03:07:16 +0530
Message-ID: <20261019213726.4145532-5-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|DS6PR10MB397930:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd1a0ad-eb61-4bae-4430-08df2e2945bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|56012099006|261009220027099003|261009223027099003|921020|261009221227099003|261009223327099003|261009221727099003|10067099003|18092099006|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: K/i7YzRb5JNSuYYmqhaNOkRDotHRPUozn3cn4iWf/cPJUjlhVuimLOuyApSyS2asJHIGQ0gnVrIiTUvS99O3zrrMbVAvLJZ+9daEvetI9cNQEaqynsSSMWAnYuXWoiSoCyOh2PpSnCfE6lO6v+RJaRJPQB1ITAFy6KJ2C7HyGZ6EHxK2D8ltYbg48ukotVqk5l0Cfn+SAP8w7wpBa6KaDYbMPqckVoaS1tbzeHdgI1zVZJZmXHLbSvLJVQSsLIM35PRS3MAGu7q5Zl9yzB7e1veD7MLDqMrOTfepfnZgWAo2QjtdhHMlFxVfEFpHS432/5gYHP9QwKqsYBpmJDuZuaVqUx1sQsH71L8MsDQ4zUw2EeragRoS24ck6Qv3xjtdS5A/ojDd9mG+OOW+nGbIq1CP+CoiV8PfBiGsLV2RlVT96529wW82ctxe6xqyT4njTPciX40r4lmXGC1WiaQHWxEV5+H7XL4BPZ5OI2Z5lEgUoxddnIMfHnk2uqR5urHjC9fV2s9ThRj3MgbUCLTIDx3/2vkNnALNM8sdxX6waVqayXy4wWV4TZuT99da9W2HPmiOYwtva1lOObSXx4YJX8asqOSLJ3ZkEybXMHmpfSKIC8z9eHDbGhXyccgbk1jAYcsZc4jv30ghhMHVIwdL+0QHQVaZQ0bsp9W/iB/YGpUBYHrU5vfP5kBRPN0yy0UM
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(56012099006)(261009220027099003)(261009223027099003)(921020)(261009221227099003)(261009223327099003)(261009221727099003)(10067099003)(18092099006)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zypi0uAQRnZB6lu1DiCIKsybEY3VGy8ynqbdf0kD8PdzlgEhWJ4CTWNM2NTlBNEmjopNqF9pyi6WWzBViukB+Urj88EFEVnTFgJW8dNeFlWW3v0kXflEdwKQrksV00Dha5MDTq3yyhghFESIFM3/kohlnl8ICsg3b3S3r8iMM9/0myOif6Bw+g+HUVrVUpziuX2jR0xiImrjveT34F3FucilBApI/pJW2hEoP4wIJ6iRyKX4Cp/qgouAM3vlDuDAHEjOWhczzScMgtftbKJ5zYI9BSbGIDkD22XqryKVU27R+BDatCHkAcdnZB/hqKrsf9GiJbh3QGot1P7ZF/9FeqnioD+LCK9NcNNHYcnN0DFWrFjSfMM8Paig8lrfsLKurfwoHf31J7gdVE/Rlc/EyAm+BUiDp3jT6DDxxBa09t5+kLLWMrK7uJbyU1U/uF0l
X-Exchange-RoutingPolicyChecked: HfMr+7hPJ6hNTDrux5+E/apJSiM3a7F/Q0xN0DlB2Y26lUvslzxCKBRWWk+ttY5dAwRCK67eVeEfxMxzQIuadz6xyWSOhxiWxjrO/8ydVwCpzutbAQzR20Sel4h1K/P36oL5D3Qm7H6LgoE6SyIfDZIZ3DymjwmUyp22RuPjimhFivDw5m+v4kW4PO9nGHIxLhXIiITLkeGDNjm3xhASLq1mxZBlpp4j0HNkrEcf9LiSLKoQSDeSwii4fqHYjBM6eoEfuZXospkCg5m9YXgKqe0wKbmXVkB5AlZsz5XrpAnUszNWXhvOSL7B1xi5/P6irLN4pKh8UdjLRvc6LJH2vw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:10.7353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd1a0ad-eb61-4bae-4430-08df2e2945bf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR10MB397930
X-Proofpoint-ORIG-GUID: tyUn-kYT4JbFjMovmBDIzgvaYzntuG2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX4a2qfW2HDmBG
 X+4kowJa839uT7uII1uN242PFPX2vi9jIYDHhdyAFlV+LEHSWwzb1++8BQ3OXjcDacuNHoevm01
 NuWW2cDz//O+2JgIXXXY3qWFilCfTHZogALzlt+YIQaw1ohQErFIcUnD2WraJUOKEPQXaQ51FB5
 y/V0fyqus83xEDfwFOU9pzHSWkS3LFwQEPU2tQor77fMcb+q/QpVbo3DOUxJiWHrJoyjeqMbAE4
 sSvaBbqa0dywNFkv5bU4ZJ1yNDfHYSJFL7H4Q1rjs0Dl/ZCrttETrGhyHiK/xNFy8tpDN7217Dy
 vEE8uKQc7hNrYMWcxTU3CYwqA5GXqFRIb/sgu1jxQuF3hD68Y68jDsQ4scuE9tuUwKUHXIkUdSY
 GsN4Y10QSIJQxqV1c/1kCoC+aixgjSmXjRNszoiOb58WFqgWH8byS81QAbMezG3AhKCHBuslTdW
 2Jui6a3AaZneNkYQh0Q==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad68dc9 cx=c_pps
 a=Getn/9gNXKMn2yU3BA3TiQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=YmX860EEAAAA:8 a=LBxWy3usAAAA:8 a=sozttTNsAAAA:8
 a=NEAV23lmAAAA:8 a=4SE-V1R2cGdzk9XFqJMA:9 a=IHlJSM1uQZwyV-gw:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=BeCehlkWaqzeQ17686bl:22
 a=4jSGKt0uXjqk0CpsFuVH:22
X-Proofpoint-GUID: tyUn-kYT4JbFjMovmBDIzgvaYzntuG2Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX8pO0a6O6LSw5
 qZsSH60hPIccwuiRGGhMEn1lvIEekDgOCN1wuwHIsv/ra/IQeij/0LqtrYaS5gxAUhamKViWezz
 /4hWj15J6RJqxVl2k5GCWDmzEnvbXJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a DRM driver for the Solomon Systech SSD16xx family of e-paper display
controllers (SSD1680 [4], SSD1673 [3], SSD1681 [5], SSD1683 [1]) based
e-paper display panels, starting with support for the Gooddisplay
GDEY042T81 which is 4.2", 400x300 resolution black/white e-paper display
using SSD1683 controller.

Hardware features supported:
  - SPI communication with optional D/C GPIO (4-wire mode) or 9-bit SPI
    with embedded D/C# bit (3-wire mode) command/data signaling
  - BUSY GPIO polling with configurable timeout
  - Hardware reset via dedicated reset GPIO
  - Internal temperature sensor readout
  - Border waveform control with 10 configurable modes:
    LUT0-3 (GS transition waveforms), fixed voltage levels (VSS/VSH1/VSL/
    VSH2), VCOM follow, and HiZ (floating, default)
  - Deep sleep modes: Mode 1 (RAM retained) and Mode 2 (RAM lost)
  - Data entry modes for all four orientations
  - Dual display RAM planes: BW RAM (primary image) and RED RAM
    (partial refresh baseline / 3-color BWR red pixels)

Refresh modes:
  Three independently selectable refresh waveforms:
  - Partial (~300-500 ms): low-latency BW update using RED RAM as
    waveform transition baseline
  - Full (~1.5-2 s): complete pixel-cycle reset with temperature-
    compensated LUT reload
  - Fast (~1.0-1.5 s): abbreviated waveform using a pre-loaded LUT

Pixel format conversions:
  The driver accepts all common DRM formats and converts to 1bpp:
  - R1 (native 1bpp), color formats (XRGB8888),
  - 3-color BWR: classifies pixels as black, white, or red by dominant
    channel; writes separate 1bpp BW and RED buffers

Orientation / rotation:
  - Full 4-way rotation: 0° (landscape), 90° (portrait CW),
    180° (landscape inverted), 270° (portrait CCW)
  - Implemented via the Data Entry Mode register — no GPU or memory
    rotation overhead
  - Configurable via device tree 'rotation' property

DRM framework integration:
  - drm_atomic_helper-based modesetting with damage tracking
  - Single primary plane, CRTC, simple encoder, SPI connector
  - drm_gem_shmem backend for display buffers
  - fbdev fallback via drm_fbdev_shmem_setup

Links:
[1] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
[2] : https://files.seeedstudio.com/wiki/Other_Display/42-epaper/GDEY042T81.pdf
[3] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1673
[4] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1680
[5] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1681

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Keep lazy hardware initialization: ssd16xx_hw_init() is deferred to
  crtc_atomic_enable(), not probe(). probe() performs only a GPIO reset
(ssd16xx_hw_reset()). This avoids unnecessary hw_init in case no app
  using the epaper display yet.
- Add drm_dev_enter()/drm_dev_exit() to plane_atomic_update (Thomas,
  sashiko-bot)
- Wrap the framebuffer read in drm_gem_fb_begin_cpu_access() and
  drm_gem_fb_end_cpu_access() (Thomas)
- Skip the update when drm_atomic_helper_damage_merged() reports no damage
  instead of making up a full-screen rectangle (Thomas)
- Remove ssd16xx_crtc_atomic_flush() and last_fb. The orientation is
  static, so flush did a full hardware re-init and a second redraw on
  every commit, and last_fb had no remaining users (Thomas, sashiko-bot)
- Remove the empty atomic_disable helper; it is re-added with real
  content in the clear_on_init/close/disable patch (Thomas)
- Use drm_crtc_cleanup() directly as the CRTC .destroy callback (Thomas)
- Call drm_atomic_helper_check_crtc_primary_plane() from the CRTC
  atomic_check (Thomas)
- Send SPI data from a DMA-safe buffer in struct ssd16xx_device instead of
  the stack (sashiko-bot)
- Read XRGB8888 pixels with le32_to_cpup()
- Size the transfer buffers per row, as the packing code does
  (sashiko-bot)
- Make Kconfig depend on MMU
- GDEY042T81: use the HIZ border waveform for updates and do not refresh
  the border on every update, to avoid border flicker
---
 drivers/gpu/drm/solomon/Kconfig   |   13 +
 drivers/gpu/drm/solomon/Makefile  |    1 +
 drivers/gpu/drm/solomon/ssd16xx.c | 1801 +++++++++++++++++++++++++++++
 3 files changed, 1815 insertions(+)
 create mode 100644 drivers/gpu/drm/solomon/ssd16xx.c

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 400a6cab3a67..53120ea6296e 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -30,3 +30,16 @@ config DRM_SSD130X_SPI
 	  Say Y here if the SSD13xx OLED display is connected via SPI bus.
 
 	  If M is selected the module will be called ssd130x-spi.
+
+config DRM_SSD16XX
+	tristate "DRM support for Solomon SSD16xx e-ink display controllers"
+	depends on DRM && SPI && MMU
+	select DRM_CLIENT_SELECTION
+	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	help
+	  DRM driver for Solomon SSD16xx family e-ink display controllers
+	  (SSD1673, SSD1680, SSD1681, SSD1683, SSD1677). Supports panels
+	  such as the GDEY042T81 4.2" 400x300.
+
+	  If M is selected the module will be called ssd16xx.
diff --git a/drivers/gpu/drm/solomon/Makefile b/drivers/gpu/drm/solomon/Makefile
index b5fc792257d7..72384620785b 100644
--- a/drivers/gpu/drm/solomon/Makefile
+++ b/drivers/gpu/drm/solomon/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_DRM_SSD130X)	+= ssd130x.o
 obj-$(CONFIG_DRM_SSD130X_I2C)	+= ssd130x-i2c.o
 obj-$(CONFIG_DRM_SSD130X_SPI)	+= ssd130x-spi.o
+obj-$(CONFIG_DRM_SSD16XX)	+= ssd16xx.o
diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
new file mode 100644
index 000000000000..ca6550b5dd5b
--- /dev/null
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -0,0 +1,1801 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DRM driver for e-paper display panels using Solomon SSD16xx family controllers
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Author: Devarsh Thakkar <devarsht@ti.com>
+ *
+ * References: https://github.com/Lesords/epaper
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_print.h>
+
+/* -----------------------------------------------------------------------
+ * SSD16xx family common: commands, data values, and bit definitions.
+ * These apply equally to SSD1673, SSD1680, and SSD1683.
+ * -----------------------------------------------------------------------
+ */
+
+/* SPI command codes (common) */
+#define SSD16XX_CMD_DRIVER_OUTPUT_CONTROL		0x01
+#define SSD16XX_CMD_DATA_ENTRY_MODE			0x11
+#define SSD16XX_CMD_SW_RESET				0x12
+#define SSD16XX_CMD_MASTER_ACTIVATION			0x20
+#define SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1		0x21
+#define SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2		0x22
+#define SSD16XX_CMD_WRITE_RAM_BW			0x24
+#define SSD16XX_CMD_BORDER_WAVEFORM_CONTROL		0x3C
+#define SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END		0x44
+#define SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END		0x45
+#define SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER		0x4E
+#define SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER		0x4F
+
+/*
+ * Data Entry Mode (command 0x11) AM/IDY/IDX bit encoding (common).
+ *
+ * Bit 2 (AM): Address update direction: 0 = X direction, 1 = Y direction
+ * ID[1:0] when AM=0 (X-direction modes, address counter advances in X):
+ *   00 = X decrement, Y decrement   01 = X increment, Y decrement
+ *   10 = X decrement, Y increment   11 = X increment, Y increment (default)
+ *
+ * Rotation to data entry mode mapping (actual implementation uses two modes,
+ * with scan direction controlled via RAM cursor positioning and manual tweaking):
+ *   0°/270° → 0x03 (X++, Y++)   Landscape/Portrait-CW: cursor at (0, 0)
+ *   90°/180° → 0x00 (X--, Y--)  Portrait-CCW/Upside-down: cursor at (max, max)
+ *
+ * The pixel packing in convert_fb_to_1bpp is grouped by physical layout:
+ *   - Portrait (90°/270°): column-major packing, rightmost column first
+ *   - Landscape (0°/180°): row-major packing, top to bottom, left to right
+ * Hardware cursor position and scan mode handle the final orientation.
+ */
+#define SSD16XX_DATA_ENTRY_XDEC_YDEC		0x00  /* X--, Y-- (X-mode) */
+#define SSD16XX_DATA_ENTRY_XINC_YINC		0x03  /* X++, Y++ (X-mode, default) */
+
+/* POR reset value: GD=0 (G0 first), SM=0 (interlaced), TB=0 (G0->G299) */
+#define SSD16XX_DRIVER_OUTPUT_CTRL_DEFAULT	0x00
+
+/* Display Update Control 1 (0x21) byte 2 default (common) */
+#define SSD16XX_CTRL1_BYTE2_DEFAULT		0x00
+
+/*
+ * Display Update Control 2 (0x22) individual bit definitions (common).
+ * NOTE: BIT(3) is NOT common — see SSD1683_CTRL2_MODE2 in the SSD1683
+ * section below; it has a completely different meaning in SSD1673.
+ */
+#define SSD16XX_CTRL2_ENABLE_CLK		BIT(7)
+#define SSD16XX_CTRL2_ENABLE_ANALOG		BIT(6)
+#define SSD16XX_CTRL2_LOAD_TEMPERATURE		BIT(5)
+#define SSD16XX_CTRL2_LOAD_LUT			BIT(4)
+#define SSD16XX_CTRL2_DISPLAY			BIT(2)
+#define SSD16XX_CTRL2_DISABLE_ANALOG		BIT(1)
+#define SSD16XX_CTRL2_DISABLE_CLK		BIT(0)
+
+#define SSD16XX_SPI_BITS_PER_WORD		8
+#define SSD16XX_SPI_SPEED_DEFAULT		1000000
+
+/* Maximum time to wait for the BUSY pin to deassert after a display update */
+#define SSD16XX_BUSY_WAIT_TIMEOUT_MS		6000
+
+/* -----------------------------------------------------------------------
+ * SSD1683 / SSD1680 specific: commands, data values, and bit definitions.
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Deep Sleep Mode values (command 0x10).
+ */
+#define SSD1683_DEEP_SLEEP_MODE_1			0x01  /* RAM retained */
+#define SSD1683_DEEP_SLEEP_MODE_2			0x03  /* RAM lost (max power) */
+
+/*
+ * Temperature Sensor Selection (command 0x18).
+ */
+#define SSD1683_CMD_TEMPERATURE_SENSOR_CONTROL		0x18
+#define SSD1683_TEMP_SENSOR_INTERNAL			0x80  /* Bit 7: use internal sensor */
+
+/*
+ * Write RED RAM (command 0x26).
+ */
+#define SSD1683_CMD_WRITE_RAM_RED			0x26
+
+/*
+ * Border Waveform Control (command 0x3C) byte values.
+ */
+#define SSD1683_BORDER_WAVEFORM_LUT0		0x00  /* GS Transition LUT0 (black) */
+#define SSD1683_BORDER_WAVEFORM_LUT1		0x01  /* GS Transition LUT1 (white) */
+#define SSD1683_BORDER_WAVEFORM_LUT2		0x02  /* GS Transition LUT2 (black) */
+#define SSD1683_BORDER_WAVEFORM_LUT3		0x03  /* GS Transition LUT3 (gray) */
+#define SSD1683_BORDER_WAVEFORM_FIXLVL_VSS	0x40  /* Fix Level VSS (0V, black) */
+#define SSD1683_BORDER_WAVEFORM_FIXLVL_VSH1	0x50  /* Fix Level VSH1 (+15V, black) */
+#define SSD1683_BORDER_WAVEFORM_FIXLVL_VSL	0x60  /* Fix Level VSL (-15V, white) */
+#define SSD1683_BORDER_WAVEFORM_FIXLVL_VSH2	0x70  /* Fix Level VSH2 (+15V alt, black) */
+#define SSD1683_BORDER_WAVEFORM_VCOM		0x80  /* Follow VCOM (-2V~-3V, preserve) */
+#define SSD1683_BORDER_WAVEFORM_HIZ		0xC0  /* HiZ (floating, default) */
+
+/*
+ * Display Update Control 1 (0x21) byte 1 — RED RAM control.
+ */
+#define SSD1683_CTRL1_NORMAL			0x00  /* Both BW and RED RAMs enabled */
+#define SSD1683_CTRL1_BYPASS_RED_RAM		0x40  /* Bypass RED RAM (force RED=0) */
+
+/*
+ * Display Update Control 2 (0x22) BIT(3) — "Display Mode 2" (partial/BW).
+ */
+#define SSD1683_CTRL2_MODE2			BIT(3)
+
+/* Composite CTRL2 sequences for each refresh mode */
+#define SSD1683_CTRL2_FULL_REFRESH (SSD16XX_CTRL2_ENABLE_CLK | \
+				    SSD16XX_CTRL2_ENABLE_ANALOG | \
+				    SSD16XX_CTRL2_LOAD_TEMPERATURE | \
+				    SSD16XX_CTRL2_LOAD_LUT | \
+				    SSD16XX_CTRL2_DISPLAY | \
+				    SSD16XX_CTRL2_DISABLE_ANALOG | \
+				    SSD16XX_CTRL2_DISABLE_CLK)  /* 0xF7, ~1.5-2s */
+
+#define SSD1683_CTRL2_FAST_REFRESH (SSD16XX_CTRL2_ENABLE_CLK | \
+				    SSD16XX_CTRL2_ENABLE_ANALOG | \
+				    SSD16XX_CTRL2_DISPLAY | \
+				    SSD16XX_CTRL2_DISABLE_ANALOG | \
+				    SSD16XX_CTRL2_DISABLE_CLK)  /* 0xC7, ~1.0-1.5s */
+
+#define SSD1683_CTRL2_PARTIAL_REFRESH (SSD16XX_CTRL2_ENABLE_CLK | \
+				       SSD16XX_CTRL2_ENABLE_ANALOG | \
+				       SSD16XX_CTRL2_LOAD_TEMPERATURE | \
+				       SSD16XX_CTRL2_LOAD_LUT | \
+				       SSD1683_CTRL2_MODE2 | \
+				       SSD16XX_CTRL2_DISPLAY | \
+				       SSD16XX_CTRL2_DISABLE_ANALOG | \
+				       SSD16XX_CTRL2_DISABLE_CLK)  /* 0xFF, ~300-500ms */
+
+/*
+ * Standalone LUT pre-load sequence (0x91 = ENABLE_CLK | LOAD_LUT | LOAD_TEMPERATURE |
+ *                                          DISABLE_CLK).
+ * Pre-loads the OTP LUT without triggering a display update. Required for
+ * FAST refresh mode (0xC7) which omits LOAD_LUT from each update cycle.
+ */
+#define SSD1683_CTRL2_LOAD_TEMP_LUT		(SSD16XX_CTRL2_ENABLE_CLK | \
+						 SSD16XX_CTRL2_LOAD_LUT | \
+						 SSD16XX_CTRL2_LOAD_TEMPERATURE | \
+						 SSD16XX_CTRL2_DISABLE_CLK)  /* 0xB1 */
+
+enum ssd16xx_controller {
+	SSD1683 = 1,
+};
+
+enum ssd16xx_model {
+	GDEY042T81 = 1,
+};
+
+enum ssd16xx_refresh_mode {
+	SSD16XX_REFRESH_PARTIAL = 0,  /* Partial refresh (~300-500ms) */
+	SSD16XX_REFRESH_FULL,         /* Full refresh (~1.5-2s) */
+	SSD16XX_REFRESH_FAST,         /* Fast refresh, skip temp load (~1.0-1.5s) */
+};
+
+enum ssd16xx_color_mode {
+	SSD16XX_COLOR_MODE_BW = 0,     /* Black/white only; RED RAM always bypassed */
+	SSD16XX_COLOR_MODE_3COLOR = 1, /* 3-colour BWR; RED RAM used for red pixels */
+};
+
+/* Border waveform enum indices (0-9); mapped to HW bytes via
+ * controller_cfg->border_waveform_table[]
+ */
+enum ssd16xx_border_waveform {
+	SSD16XX_BORDER_LUT0 = 0,  /* GS Transition LUT0 (black) */
+	SSD16XX_BORDER_LUT1,      /* GS Transition LUT1 (white) */
+	SSD16XX_BORDER_LUT2,      /* GS Transition LUT2 (black) */
+	SSD16XX_BORDER_LUT3,      /* GS Transition LUT3 (gray) */
+	SSD16XX_BORDER_VSS,       /* Fix Level VSS (black) */
+	SSD16XX_BORDER_VSH1,      /* Fix Level VSH1 (black) */
+	SSD16XX_BORDER_VSL,       /* Fix Level VSL (white) */
+	SSD16XX_BORDER_VSH2,      /* Fix Level VSH2 (black) */
+	SSD16XX_BORDER_VCOM,      /* Follow VCOM (preserve) */
+	SSD16XX_BORDER_HIZ,       /* HiZ (floating, default) */
+};
+
+/* SSD1683/SSD1680 border waveform byte encoding for command 0x3C */
+static const u8 ssd1683_border_waveform_table[] = {
+	[SSD16XX_BORDER_LUT0] = SSD1683_BORDER_WAVEFORM_LUT0,
+	[SSD16XX_BORDER_LUT1] = SSD1683_BORDER_WAVEFORM_LUT1,
+	[SSD16XX_BORDER_LUT2] = SSD1683_BORDER_WAVEFORM_LUT2,
+	[SSD16XX_BORDER_LUT3] = SSD1683_BORDER_WAVEFORM_LUT3,
+	[SSD16XX_BORDER_VSS]  = SSD1683_BORDER_WAVEFORM_FIXLVL_VSS,
+	[SSD16XX_BORDER_VSH1] = SSD1683_BORDER_WAVEFORM_FIXLVL_VSH1,
+	[SSD16XX_BORDER_VSL]  = SSD1683_BORDER_WAVEFORM_FIXLVL_VSL,
+	[SSD16XX_BORDER_VSH2] = SSD1683_BORDER_WAVEFORM_FIXLVL_VSH2,
+	[SSD16XX_BORDER_VCOM] = SSD1683_BORDER_WAVEFORM_VCOM,
+	[SSD16XX_BORDER_HIZ]  = SSD1683_BORDER_WAVEFORM_HIZ,
+};
+
+struct ssd16xx_controller_config {
+	u16 max_width;
+	u16 max_height;
+	u8 ram_x_address_bits;
+	u8 ram_y_address_bits;
+
+	/*
+	 * has_temp_sensor_ctrl: controller supports command 0x18 (Temperature
+	 * Sensor Selection).  Present in SSD1683/SSD1680; absent in SSD1673
+	 * which uses command 0x1A (direct temperature write) instead.
+	 */
+	bool has_temp_sensor_ctrl;
+
+	/*
+	 * Deep sleep mode byte values for command 0x10.
+	 *   deep_sleep_mode_level1: lower-power sleep, RAM content retained
+	 *     (MODE_1 on SSD1683/SSD1680; used for runtime idle / app-close).
+	 *   deep_sleep_mode_level2: maximum power savings, RAM may be lost
+	 *     (MODE_2 on SSD1683/SSD1680; used for system suspend).
+	 * Chips with a single sleep mode set both fields to the same value.
+	 */
+	u8 deep_sleep_mode_level1;
+	u8 deep_sleep_mode_level2;
+
+	/*
+	 * border_waveform_table: chip-specific byte values for the 10 logical
+	 * border waveform modes (indexed by enum ssd16xx_border_waveform).
+	 * The encoding of command 0x3C differs between SSD1683/SSD1680 and
+	 * SSD1673, so each controller provides its own translation table.
+	 */
+	const u8 *border_waveform_table;
+
+	/*
+	 * Display Update Control 1 (cmd 0x21) byte 1 values.
+	 * ctrl1_normal:         both BW and RED RAMs participate in the waveform.
+	 * ctrl1_bypass_red_ram: RED RAM bypassed; waveform driven from BW RAM only.
+	 * SSD1673 has no RED RAM so both fields carry the same value.
+	 */
+	u8 ctrl1_normal;
+	u8 ctrl1_bypass_red_ram;
+
+	/*
+	 * Display Update Control 2 (cmd 0x22) composite sequences for each
+	 * refresh mode (indexed by enum ssd16xx_refresh_mode) and the
+	 * standalone LUT pre-load sequence used before fast refresh.
+	 * Values differ between SSD1683/SSD1680 and SSD1673 (MODE2 bit, etc.).
+	 */
+	u8 ctrl2_refresh[3];     /* indexed by SSD16XX_REFRESH_PARTIAL/FULL/FAST */
+	u8 ctrl2_load_temp_lut;  /* standalone LUT pre-load (no display update) */
+};
+
+struct ssd16xx_device_config {
+	/* Data Entry Mode - controls X/Y increment direction for landscape (0°) */
+	u8 data_entry_mode;
+
+	/* Driver Output Control - third byte (scan direction) */
+	u8 driver_output_ctrl_byte3;
+
+	/* Default refresh mode for this panel */
+	enum ssd16xx_refresh_mode default_refresh_mode;
+
+	/* Default border waveform during clear/init (enum index 0-9) */
+	enum ssd16xx_border_waveform default_border_waveform_init;
+
+	/* Default border waveform during display updates (enum index 0-9) */
+	enum ssd16xx_border_waveform default_border_waveform_update;
+
+	/* Whether to re-send border waveform command before each display update */
+	bool default_border_refresh_on_every_update;
+
+	/*
+	 * Default refresh-mode-init: -1=disabled, else skip baseline establishment
+	 * and start directly in this refresh mode.
+	 */
+	int default_refresh_mode_init;
+
+	/*
+	 * Whether this panel has a physical red colour plane (3-colour BWR).
+	 * false: 2-colour black/white only; the RED RAM is always bypassed.
+	 * true:  3-colour panel; full-refresh writes to the RED RAM so that
+	 *        red pixels are driven through the red waveform.
+	 */
+	bool red_supported;
+
+	/*
+	 * Default colour mode for this panel.
+	 * For BW-only panels this must be SSD16XX_COLOR_MODE_BW.
+	 * For BWR panels this can be set to SSD16XX_COLOR_MODE_3COLOR to
+	 * enable red ink by default;
+	 */
+	enum ssd16xx_color_mode default_color_mode;
+
+	/* Panel-specific display mode (resolution and physical dimensions) */
+	const struct drm_display_mode *mode;
+};
+
+struct ssd16xx_device {
+	struct drm_device drm;
+
+	struct drm_plane primary_plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+
+	struct spi_device *spi;
+	struct gpio_desc *reset;
+	struct gpio_desc *busy;
+	struct gpio_desc *dc;
+
+	enum ssd16xx_model model;
+	enum ssd16xx_controller controller;
+	const struct ssd16xx_controller_config *controller_cfg;
+	const struct ssd16xx_device_config *device_cfg;
+	struct drm_display_mode *mode;
+	u32 width;
+	u32 height;
+
+	bool initialized;
+	bool init_refresh_pending; /* First frame after refresh_mode_init enable */
+
+	int orientation; /* Display orientation in degrees: 0/90/180/270 */
+	enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
+	enum ssd16xx_color_mode color_mode;     /* Active color mode (BW or 3-color) */
+	bool fast_lut_pending; /* LUT pre-load needed before next fast refresh */
+
+	/* Border waveform (as enum indices) */
+	int border_waveform_init_idx;   /* Border waveform during clear/init */
+	int border_waveform_update_idx; /* Border waveform during display updates */
+	bool border_refresh_on_every_update; /* Re-send border cmd each display update */
+	bool border_waveform_pending;   /* One-shot: send border cmd on next update */
+
+	/* Display control */
+	int refresh_mode_init; /* -1=disabled, else use this mode for the first frame */
+
+	u8  *tx_buf;     /* 1bpp frame buffer (mono + white) */
+	u8  *tx_red_buf; /* 1bpp red-channel buffer (3-color panels only) */
+	u16 *tx_buf9;    /* 9-bit SPI expansion buffer (3-wire mode only) */
+	u8  spi_buf[64] ____cacheline_aligned; /* DMA-safe buffer for SPI transfers */
+};
+
+static inline struct ssd16xx_device *to_ssd16xx_device(struct drm_device *drm)
+{
+	return container_of(drm, struct ssd16xx_device, drm);
+}
+
+static inline struct ssd16xx_device *crtc_to_ssd16xx_device(struct drm_crtc *crtc)
+{
+	return container_of(crtc, struct ssd16xx_device, crtc);
+}
+
+static inline struct ssd16xx_device *plane_to_ssd16xx_device(struct drm_plane *plane)
+{
+	return container_of(plane, struct ssd16xx_device, primary_plane);
+}
+
+static const struct ssd16xx_controller_config ssd16xx_controller_configs[] = {
+	[SSD1683] = {
+		.max_width = 400,
+		.max_height = 300,
+		.ram_x_address_bits = 8,
+		.ram_y_address_bits = 16,
+		.has_temp_sensor_ctrl    = true,
+		.deep_sleep_mode_level1  = SSD1683_DEEP_SLEEP_MODE_1,
+		.deep_sleep_mode_level2  = SSD1683_DEEP_SLEEP_MODE_2,
+		.border_waveform_table   = ssd1683_border_waveform_table,
+		.ctrl1_normal            = SSD1683_CTRL1_NORMAL,
+		.ctrl1_bypass_red_ram    = SSD1683_CTRL1_BYPASS_RED_RAM,
+		.ctrl2_refresh = {
+			[SSD16XX_REFRESH_PARTIAL] = SSD1683_CTRL2_PARTIAL_REFRESH,
+			[SSD16XX_REFRESH_FULL]    = SSD1683_CTRL2_FULL_REFRESH,
+			[SSD16XX_REFRESH_FAST]    = SSD1683_CTRL2_FAST_REFRESH,
+		},
+		.ctrl2_load_temp_lut     = SSD1683_CTRL2_LOAD_TEMP_LUT,
+	},
+};
+
+/* GDEY042T81: 4.2" 400x300 panel, 84.8x63.6mm active area */
+static const struct drm_display_mode gdey042t81_mode = {
+	DRM_SIMPLE_MODE(400, 300, 85, 64),
+};
+
+static const struct ssd16xx_device_config ssd16xx_device_configs[] = {
+	[GDEY042T81] = {
+		.data_entry_mode = SSD16XX_DATA_ENTRY_XINC_YINC,
+		.driver_output_ctrl_byte3 = SSD16XX_DRIVER_OUTPUT_CTRL_DEFAULT,
+		.default_refresh_mode = SSD16XX_REFRESH_PARTIAL,
+		.default_border_waveform_init   = SSD16XX_BORDER_LUT1,  /* white, clean clear */
+		.default_border_waveform_update = SSD16XX_BORDER_HIZ,   /* floating, preserve */
+		.default_border_refresh_on_every_update = false,
+		.default_refresh_mode_init = SSD16XX_REFRESH_FULL,
+		.red_supported = false,  /* 2-colour black/white panel */
+		.default_color_mode = SSD16XX_COLOR_MODE_BW,
+		.mode = &gdey042t81_mode,
+	},
+};
+
+static void ssd16xx_wait_for_device(struct ssd16xx_device *device,
+				    int *err)
+{
+	unsigned long timeout_jiffies = jiffies +
+		msecs_to_jiffies(SSD16XX_BUSY_WAIT_TIMEOUT_MS);
+	unsigned long start_ms = jiffies_to_msecs(jiffies);
+	int busy_val;
+
+	if (*err)
+		return;
+
+	busy_val = gpiod_get_value_cansleep(device->busy);
+	drm_dbg(&device->drm, "BUSY initial value: %d\n", busy_val);
+
+	while (gpiod_get_value_cansleep(device->busy) == 1) {
+		if (time_after(jiffies, timeout_jiffies)) {
+			drm_err(&device->drm, "Busy wait timed out after %lums\n",
+				jiffies_to_msecs(jiffies) - start_ms);
+			*err = -ETIMEDOUT;
+			return;
+		}
+		usleep_range(1000, 2000);
+	}
+
+	drm_dbg(&device->drm, "BUSY became ready after %lums\n",
+		jiffies_to_msecs(jiffies) - start_ms);
+}
+
+static void ssd16xx_spi_sync(struct spi_device *spi, struct spi_message *msg,
+			     int *err)
+{
+	int ret;
+
+	if (*err)
+		return;
+
+	ret = spi_sync(spi, msg);
+	if (ret < 0)
+		*err = ret;
+}
+
+static void ssd16xx_send_cmd(struct ssd16xx_device *device, u8 cmd,
+			     int *err)
+{
+	struct spi_transfer xfer = {};
+	struct spi_message msg;
+
+	if (*err)
+		return;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	if (device->dc) {
+		/* 4-wire SPI: D/C# GPIO low selects command mode */
+		device->spi_buf[0] = cmd;
+		xfer.tx_buf = device->spi_buf;
+		xfer.len = 1;
+		gpiod_set_value_cansleep(device->dc, 0);
+	} else {
+		/*
+		 * 3-wire SPI (9-bit): bit 8 is the D/C# bit.
+		 * D/C# = 0 means the following 8 bits are a command.
+		 */
+		u16 *word = (u16 *)device->spi_buf;
+
+		*word = cmd; /* bit 8 = 0 for command */
+		xfer.tx_buf = device->spi_buf;
+		xfer.len = sizeof(u16);
+		xfer.bits_per_word = 9;
+	}
+
+	ssd16xx_spi_sync(device->spi, &msg, err);
+}
+
+static void ssd16xx_send_data(struct ssd16xx_device *device, u8 data,
+			      int *err)
+{
+	struct spi_transfer xfer = {};
+	struct spi_message msg;
+
+	if (*err)
+		return;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	if (device->dc) {
+		/* 4-wire SPI: D/C# GPIO high selects data mode */
+		device->spi_buf[0] = data;
+		xfer.tx_buf = device->spi_buf;
+		xfer.len = 1;
+		gpiod_set_value_cansleep(device->dc, 1);
+	} else {
+		/*
+		 * 3-wire SPI (9-bit): bit 8 is the D/C# bit.
+		 * D/C# = 1 means the following 8 bits are data.
+		 */
+		u16 *word = (u16 *)device->spi_buf;
+
+		*word = 0x100 | data;
+		xfer.tx_buf = device->spi_buf;
+		xfer.len = sizeof(u16);
+		xfer.bits_per_word = 9;
+	}
+
+	ssd16xx_spi_sync(device->spi, &msg, err);
+}
+
+static void ssd16xx_send_x_param(struct ssd16xx_device *device, u16 x,
+				 int *err)
+{
+	if (*err)
+		return;
+
+	if (device->controller_cfg->ram_x_address_bits == 8) {
+		ssd16xx_send_data(device, (u8)x, err);
+	} else {
+		ssd16xx_send_data(device, x & 0xFF, err);
+		ssd16xx_send_data(device, (x >> 8) & 0xFF, err);
+	}
+}
+
+static void ssd16xx_send_y_param(struct ssd16xx_device *device, u16 y,
+				 int *err)
+{
+	if (*err)
+		return;
+
+	if (device->controller_cfg->ram_y_address_bits == 8) {
+		ssd16xx_send_data(device, (u8)y, err);
+	} else {
+		ssd16xx_send_data(device, y & 0xFF, err);
+		ssd16xx_send_data(device, (y >> 8) & 0xFF, err);
+	}
+}
+
+static void ssd16xx_send_data_bulk(struct ssd16xx_device *device,
+				   const u8 *data, size_t len,
+				   int *err)
+{
+	struct spi_transfer xfer = {};
+	struct spi_message msg;
+
+	if (*err)
+		return;
+
+	if (!data || !len)
+		return;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	if (device->dc) {
+		/* 4-wire SPI: D/C# GPIO high selects data mode */
+		if (len <= sizeof(device->spi_buf)) {
+			memcpy(device->spi_buf, data, len);
+			xfer.tx_buf = device->spi_buf;
+		} else {
+			xfer.tx_buf = data;
+		}
+		xfer.len = len;
+		gpiod_set_value_cansleep(device->dc, 1);
+		ssd16xx_spi_sync(device->spi, &msg, err);
+	} else {
+		/* 3-wire (9-bit): expand u8 → u16 with D/C#=1 in bit 8. */
+		size_t i;
+		u16 *buf = device->tx_buf9;
+
+		for (i = 0; i < len; i++)
+			buf[i] = 0x100 | data[i];
+
+		xfer.tx_buf = buf;
+		xfer.len = len * sizeof(u16);
+		xfer.bits_per_word = 9;
+		ssd16xx_spi_sync(device->spi, &msg, err);
+	}
+}
+
+static void ssd16xx_display_update(struct ssd16xx_device *device,
+				   u8 ctrl1_byte1, u8 ctrl1_byte2, u8 ctrl2_mode,
+				   int *err)
+{
+	if (*err)
+		return;
+
+	drm_dbg(&device->drm,
+		"display_update: Setting ctrl1=0x%02x,0x%02x mode=0x%02x\n",
+		ctrl1_byte1, ctrl1_byte2, ctrl2_mode);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1, err);
+	ssd16xx_send_data(device, ctrl1_byte1, err);
+	ssd16xx_send_data(device, ctrl1_byte2, err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2, err);
+	ssd16xx_send_data(device, ctrl2_mode, err);
+	ssd16xx_send_cmd(device, SSD16XX_CMD_MASTER_ACTIVATION, err);
+
+	drm_dbg(&device->drm,
+		"display_update: Master activation sent, waiting...\n");
+
+	ssd16xx_wait_for_device(device, err);
+}
+
+static void ssd16xx_hw_reset(struct ssd16xx_device *device)
+{
+	gpiod_set_value_cansleep(device->reset, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(device->reset, 0);
+	usleep_range(10000, 11000);
+}
+
+/*
+ * ssd16xx_preload_fast_lut() - pre-load the OTP LUT for fast refresh mode.
+ *
+ * Fast refresh (CTRL2 = 0xC7) omits the LOAD_LUT step on every update to save
+ * time.  It relies on the LUT being loaded upfront via this standalone sequence
+ * (CTRL2 = 0xB1: ENABLE_CLK | LOAD_LUT | SSD16XX_CTRL2_LOAD_TEMPERATURE | DISABLE_CLK,
+ *  no display update).
+ *
+ * Must be called when:
+ *   a) hw_init runs with refresh_mode == FAST, and
+ *   b) switching to fast refresh from a mode that did not leave a valid Mode1
+ *      LUT in the controller (i.e. previous mode was not FULL refresh, which
+ *      carries LOAD_LUT in its own CTRL2 sequence).
+ */
+static int ssd16xx_preload_fast_lut(struct ssd16xx_device *device)
+{
+	int err = 0;
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1, &err);
+	ssd16xx_send_data(device, device->controller_cfg->ctrl1_bypass_red_ram, &err);
+	ssd16xx_send_data(device, SSD16XX_CTRL1_BYTE2_DEFAULT, &err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2, &err);
+	ssd16xx_send_data(device, device->controller_cfg->ctrl2_load_temp_lut, &err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_MASTER_ACTIVATION, &err);
+	ssd16xx_wait_for_device(device, &err);
+
+	return err;
+}
+
+static int ssd16xx_hw_init(struct ssd16xx_device *device)
+{
+	int err = 0;
+	u8 data_entry_mode;
+	/*
+	 * Driver Output Control MUX ratio = (gate lines - 1).
+	 * Use the actual device height, not the controller maximum —
+	 * a smaller device must only drive its own gate lines.
+	 */
+
+	ssd16xx_hw_reset(device);
+
+	/* Software reset */
+	ssd16xx_send_cmd(device, SSD16XX_CMD_SW_RESET, &err);
+	ssd16xx_wait_for_device(device, &err);
+
+	/* Driver output control (0x01): MUX ratio and scan direction. */
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DRIVER_OUTPUT_CONTROL, &err);
+	ssd16xx_send_y_param(device, device->height - 1, &err);
+	ssd16xx_send_data(device, device->device_cfg->driver_output_ctrl_byte3, &err);
+
+	/* Internal temperature sensor (SSD1683/SSD1680 only; not present in SSD1673) */
+	if (device->controller_cfg->has_temp_sensor_ctrl) {
+		ssd16xx_send_cmd(device, SSD1683_CMD_TEMPERATURE_SENSOR_CONTROL, &err);
+		ssd16xx_send_data(device, SSD1683_TEMP_SENSOR_INTERNAL, &err);
+	}
+
+	/*
+	 * For FAST refresh mode, pre-load the LUT once here during initialization.
+	 * FAST mode ctrl2 (0xC7) omits LOAD_LUT on every update for speed, so the
+	 * LUT must be loaded upfront. FULL (0xF7) and PARTIAL (0xFF) load LUT on
+	 * every update, so no preload is needed for those modes.
+	 */
+	if (device->refresh_mode == SSD16XX_REFRESH_FAST) {
+		ssd16xx_send_cmd(device, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1, &err);
+		ssd16xx_send_data(device, device->controller_cfg->ctrl1_bypass_red_ram, &err);
+		ssd16xx_send_data(device, SSD16XX_CTRL1_BYTE2_DEFAULT, &err);
+
+		ssd16xx_send_cmd(device, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2, &err);
+		ssd16xx_send_data(device, device->controller_cfg->ctrl2_load_temp_lut, &err);
+
+		ssd16xx_send_cmd(device, SSD16XX_CMD_MASTER_ACTIVATION, &err);
+		ssd16xx_wait_for_device(device, &err);
+	}
+
+	/*
+	 * Set Data Entry Mode (0x11) based on orientation.  This controls
+	 * how the RAM address counter auto-advances after each byte write.
+	 *
+	 * Implementation uses two data entry modes:
+	 *   - 90°/180° use XDEC_YDEC (0x00): X--, Y-- with cursor at (max, max)
+	 *   - 0°/270° use XINC_YINC (0x03): X++, Y++ with cursor at (0, 0)
+	 *
+	 * The convert_fb_to_1bpp packing is grouped by physical layout:
+	 *   - Portrait orientations (90°/270°): column-major packing
+	 *   - Landscape orientations (0°/180°): row-major packing
+	 *
+	 * Final scan direction and image orientation are controlled by the
+	 * combination of data entry mode and RAM cursor position set in fb_dirty.
+	 *
+	 * The RAM address window and cursor are NOT set here; fb_dirty
+	 * always programmes them (with the correct end-before-start order
+	 * for decrement modes) immediately before writing frame data.
+	 */
+	switch (device->orientation) {
+	case 90:
+	case 180:
+		data_entry_mode = SSD16XX_DATA_ENTRY_XDEC_YDEC;
+		break;
+	default: /* 0°/270° */
+		data_entry_mode = SSD16XX_DATA_ENTRY_XINC_YINC;
+		break;
+	}
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DATA_ENTRY_MODE, &err);
+	ssd16xx_send_data(device, data_entry_mode, &err);
+	drm_dbg(&device->drm, "hw_init: orientation=%u° data_entry=0x%02x\n",
+		device->orientation, data_entry_mode);
+
+	ssd16xx_wait_for_device(device, &err);
+
+	if (err)
+		drm_err(&device->drm, "Hardware initialization failed: %d\n", err);
+
+	return err;
+}
+
+/*
+ * ssd16xx_pixel_luma() - return ITU-R BT.601 luminance (0-255) for one pixel.
+ *
+ * Currently only XRGB8888 is supported.  The function is retained as a named
+ * helper to make it straightforward to add further formats in the future.
+ * R1 is never passed here — it is already 1bpp and handled directly by callers.
+ */
+static u8 ssd16xx_pixel_luma(struct iosys_map *src,
+			     struct drm_framebuffer *fb,
+			     unsigned int x, unsigned int y)
+{
+	u32 *line = (u32 *)(src->vaddr + y * fb->pitches[0]);
+	u32 px = le32_to_cpup(&line[x]);
+	u8 r = (px >> 16) & 0xFF, g = (px >> 8) & 0xFF, b = px & 0xFF;
+
+	return (u8)((299u * r + 587u * g + 114u * b) / 1000u);
+}
+
+/*
+ * ssd16xx_pixel_is_white() - test whether an XRGB8888 or R1 pixel is white.
+ *
+ * For XRGB8888: ITU-R BT.601 luminance > 127 maps to white.
+ * For R1: the pixel's bit value directly encodes white (1) or black (0).
+ */
+static bool ssd16xx_pixel_is_white(struct iosys_map *src,
+				   struct drm_framebuffer *fb,
+				   unsigned int x, unsigned int y)
+{
+	if (fb->format->format == DRM_FORMAT_R1) {
+		u8 *line = (u8 *)(src->vaddr + y * fb->pitches[0]);
+
+		return !!(line[x / 8] & (1 << (7 - (x % 8))));
+	}
+	return ssd16xx_pixel_luma(src, fb, x, y) > 127;
+}
+
+/*
+ * ssd16xx_pixel_is_red() - test whether an XRGB8888 pixel is dominated by red.
+ *
+ * Returns true when red exceeds 50% intensity and is strictly greater than
+ * both green and blue (dominant red hue). R1 carries no colour information
+ * and always returns false.
+ */
+static bool ssd16xx_pixel_is_red(struct iosys_map *src,
+				 struct drm_framebuffer *fb,
+				 unsigned int x, unsigned int y)
+{
+	u32 *line;
+	u32 px;
+	u8 r, g, b;
+
+	if (fb->format->format != DRM_FORMAT_XRGB8888)
+		return false;
+
+	line = (u32 *)(src->vaddr + y * fb->pitches[0]);
+	px = le32_to_cpup(&line[x]);
+	r = (px >> 16) & 0xFF;
+	g = (px >> 8) & 0xFF;
+	b = px & 0xFF;
+
+	return r > 127 && r > g && r > b;
+}
+
+/*
+ * ssd16xx_convert_fb_to_3color() - split a framebuffer into BW and RED planes.
+ * @bw_dst:  output buffer for the black/white RAM plane (1=white, 0=black)
+ * @red_dst: output buffer for the red RAM plane        (1=red,   0=not red)
+ *
+ * Supports XRGB8888 and R1 formats.
+ *
+ * XRGB8888: pixels with a dominant red channel (r > 127 && r > g && r > b)
+ * map to red ink; remaining pixels threshold to white/black via BT.601 luma.
+ *
+ * R1 on a 3-color panel: the 1-bits are interpreted as red ink on a white
+ * background.  BW RAM is set to all-white and RED RAM receives the R1 data
+ * directly (1=red, 0=no red).  This matches the behaviour of a user who
+ * explicitly selects color_mode=3-color and submits a 1-bit mask to place
+ * red ink.
+ */
+static void ssd16xx_convert_fb_to_3color(u8 *bw_dst, u8 *red_dst,
+					 struct iosys_map *src,
+					 struct drm_framebuffer *fb,
+					 struct drm_rect *rect)
+{
+	unsigned int x, y;
+	u8 bw_byte = 0, red_byte = 0;
+	unsigned int bit_pos = 0;
+	unsigned int dst_idx = 0;
+
+	if (fb->format->format == DRM_FORMAT_R1) {
+		unsigned int src_pitch = fb->pitches[0];
+		unsigned int width_bytes = drm_rect_width(rect) / 8;
+		unsigned int data_size = width_bytes * drm_rect_height(rect);
+
+		/* White background — no black pixels, only red ink shows */
+		memset(bw_dst, 0xFF, data_size);
+		/* RED RAM: copy R1 data directly (1=red ink, 0=no red) */
+		for (y = rect->y1; y < rect->y2; y++) {
+			u8 *line = src->vaddr + y * src_pitch + (rect->x1 / 8);
+
+			memcpy(red_dst + dst_idx, line, width_bytes);
+			dst_idx += width_bytes;
+		}
+		return;
+	}
+
+	/* XRGB8888 */
+	for (y = rect->y1; y < rect->y2; y++) {
+		for (x = rect->x1; x < rect->x2; x++) {
+			bool is_red = ssd16xx_pixel_is_red(src, fb, x, y);
+
+			if (is_red)
+				red_byte |= (1 << (7 - bit_pos));
+			else if (ssd16xx_pixel_is_white(src, fb, x, y))
+				bw_byte |= (1 << (7 - bit_pos));
+			if (++bit_pos == 8) {
+				bw_dst[dst_idx] = bw_byte;
+				red_dst[dst_idx] = red_byte;
+				dst_idx++;
+				bw_byte = 0;
+				red_byte = 0;
+				bit_pos = 0;
+			}
+		}
+		if (bit_pos > 0) {
+			bw_dst[dst_idx] = bw_byte;
+			red_dst[dst_idx] = red_byte;
+			dst_idx++;
+			bw_byte = 0;
+			red_byte = 0;
+			bit_pos = 0;
+		}
+	}
+}
+
+/*
+ * Convert framebuffer to 1-bit monochrome for e-paper display.
+ *
+ * Supports XRGB8888 (thresholded via ITU-R BT.601 luma at 127) and R1
+ * (native 1bpp, zero-copy fast path for aligned landscape frames).
+ *
+ * Output layout:
+ *   0°/180°  landscape: row-major, left-to-right, top-to-bottom
+ *   90°/270° CW portrait: column-major, rightmost column first
+ */
+static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
+				       struct drm_framebuffer *fb,
+				       struct drm_rect *rect,
+				       unsigned int orientation)
+{
+	u32 format = fb->format->format;
+	int x, y;
+	u8 byte = 0;
+	unsigned int bit_pos = 0;
+	unsigned int dst_idx = 0;
+
+	/* Use fixed threshold of 127 for grayscale to monochrome conversion. */
+	drm_dbg(fb->dev,
+		"convert_1bpp: fmt=%p4cc rect=(%d,%d)-(%d,%d) orient=%u° path=%s\n",
+		&fb->format->format,
+		rect->x1, rect->y1, rect->x2, rect->y2,
+		orientation,
+		(format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 == 0) ? "R1-fast" :
+		(orientation == 90 || orientation == 270) ? "portrait" : "landscape");
+
+	/*
+	 * R1 fast path: 0° landscape with byte-aligned rect.
+	 * R1 is already 1bpp so landscape rows map directly to output bytes via
+	 * memcpy — no per-pixel computation needed.  rect->x1 must be a
+	 * multiple of 8 so that (rect->x1 / 8) gives the correct byte offset;
+	 * if not, the generic pixel-by-pixel loop below handles non-aligned
+	 * rects safely.
+	 */
+	if (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 == 0) {
+		unsigned int src_pitch = fb->pitches[0];
+		unsigned int width_bytes = drm_rect_width(rect) / 8;
+
+		for (y = rect->y1; y < rect->y2; y++) {
+			u8 *src_line = src->vaddr + y * src_pitch + (rect->x1 / 8);
+
+			memcpy(dst + dst_idx, src_line, width_bytes);
+			dst_idx += width_bytes;
+		}
+		return;
+	}
+
+	switch (orientation) {
+	case 90:
+	case 270:
+		/*
+		 * Portrait (90° or 270°): column-major packing.
+		 * Each portrait source column becomes one physical RAM row.
+		 * The data entry mode and cursor position control scan direction.
+		 */
+		for (x = rect->x2 - 1; x >= (int)rect->x1; x--) {
+			for (y = rect->y1; y < rect->y2; y++) {
+				if (ssd16xx_pixel_is_white(src, fb, x, y))
+					byte |= (1 << (7 - bit_pos));
+				if (++bit_pos == 8) {
+					dst[dst_idx++] = byte;
+					byte = 0;
+					bit_pos = 0;
+				}
+			}
+			if (bit_pos > 0) {
+				dst[dst_idx++] = byte;
+				byte = 0;
+				bit_pos = 0;
+			}
+		}
+		break;
+
+	case 0:
+	case 180:
+	default:
+		/*
+		 * Landscape (0° or 180°): row-major packing.
+		 * Each landscape source row becomes one physical RAM row.
+		 * The data entry mode and cursor position control scan direction.
+		 */
+		for (y = rect->y1; y < rect->y2; y++) {
+			for (x = rect->x1; x < rect->x2; x++) {
+				if (ssd16xx_pixel_is_white(src, fb, x, y))
+					byte |= (1 << (7 - bit_pos));
+				if (++bit_pos == 8) {
+					dst[dst_idx++] = byte;
+					byte = 0;
+					bit_pos = 0;
+				}
+			}
+			if (bit_pos > 0) {
+				dst[dst_idx++] = byte;
+				byte = 0;
+				bit_pos = 0;
+			}
+		}
+		break;
+	}
+}
+
+static int ssd16xx_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect,
+			    struct ssd16xx_device *device,
+			    const struct iosys_map *src_map)
+{
+	const u8 *ctrl2_tbl = device->controller_cfg->ctrl2_refresh;
+	struct iosys_map map = *src_map;
+	int err = 0;
+	unsigned int data_size = (device->width * device->height) / 8;
+	u8 *mono_buffer = NULL;
+	u8 *red_buffer = NULL;
+	u16 ram_x_start, ram_x_end, ram_y_start, ram_y_end;
+
+	/*
+	 * Process full display area.  The rect for convert_fb_to_1bpp uses
+	 * the framebuffer (logical) dimensions - the pixel iteration walks
+	 * the source fb coordinate space. RAM window registers below use
+	 * the physical panel dimensions (device->width/height).
+	 */
+	rect->x1 = 0;
+	rect->y1 = 0;
+	rect->x2 = fb->width;
+	rect->y2 = fb->height;
+
+	drm_dbg(&device->drm,
+		"fb_dirty: fb=%dx%d, refresh_mode=%d, orientation=%d\n",
+		fb->width, fb->height, device->refresh_mode, device->orientation);
+
+	mono_buffer = device->tx_buf;
+	memset(mono_buffer, 0, data_size);
+
+	/* 3-colour FULL/FAST: populate red channel. */
+	if (device->color_mode == SSD16XX_COLOR_MODE_3COLOR &&
+	    (device->refresh_mode == SSD16XX_REFRESH_FULL ||
+	     device->refresh_mode == SSD16XX_REFRESH_FAST)) {
+		red_buffer = device->tx_red_buf;
+		memset(red_buffer, 0, data_size);
+	}
+
+	/*
+	 * R1 format interpretation depends on color_mode:
+	 *
+	 *   color_mode = 3-color (red_buffer != NULL):
+	 *     R1 bits are treated as red ink — 1 = red pixel on a white
+	 *     background, 0 = no red.  This allows applications to submit a
+	 *     1-bit mask to place red ink on a BWR panel.
+	 *     Handled by the R1 path in ssd16xx_convert_fb_to_3color().
+	 *
+	 *   color_mode = BW (red_buffer == NULL):
+	 *     R1 bits are treated as luma — 1 = white, 0 = black.
+	 *     Handled by the native fast path in ssd16xx_convert_fb_to_1bpp().
+	 */
+	if (red_buffer)
+		ssd16xx_convert_fb_to_3color(mono_buffer, red_buffer, &map, fb, rect);
+	else
+		ssd16xx_convert_fb_to_1bpp(mono_buffer, &map, fb, rect, device->orientation);
+
+	drm_dbg(&device->drm,
+		"fb_dirty: mono[0..3]=0x%02x 0x%02x 0x%02x 0x%02x (data_size=%u)\n",
+		mono_buffer[0], mono_buffer[1], mono_buffer[2], mono_buffer[3],
+		data_size);
+
+	/* Set RAM window and cursor for current orientation. */
+	ram_x_start = 0;
+	/*
+	 * X end depends on the controller's addressing model:
+	 *   Byte-addressed (ram_x_address_bits == 8, e.g. SSD1683):
+	 *     XEnd = device_width/8 - 1  (byte offset into RAM row)
+	 *   Pixel-addressed (ram_x_address_bits != 8, e.g. SSD1677):
+	 *     XEnd = device_width - 1    (direct pixel index)
+	 * The model is controller-specific; the value is device-specific.
+	 */
+	if (device->controller_cfg->ram_x_address_bits == 8)
+		ram_x_end = (device->width / 8) - 1;
+	else
+		ram_x_end = device->width - 1;
+	ram_y_start = 0;
+	ram_y_end = device->height - 1;
+
+	switch (device->orientation) {
+	case 90:
+	case 180:
+		/* 90°/180°: XDEC_YDEC mode, send end-before-start; cursor at (max, max). */
+		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END, &err);
+		ssd16xx_send_x_param(device, ram_x_end, &err);
+		ssd16xx_send_x_param(device, ram_x_start, &err);
+
+		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END, &err);
+		ssd16xx_send_y_param(device, ram_y_end, &err);
+		ssd16xx_send_y_param(device, ram_y_start, &err);
+
+		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
+		ssd16xx_send_x_param(device, ram_x_end, &err);
+
+		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
+		ssd16xx_send_y_param(device, ram_y_end, &err);
+		break;
+
+	default: /* 0°/270° */
+		/* 0°/270°: XINC_YINC mode, cursor at (0, 0). */
+		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END, &err);
+		ssd16xx_send_x_param(device, ram_x_start, &err);
+		ssd16xx_send_x_param(device, ram_x_end, &err);
+
+		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END, &err);
+		ssd16xx_send_y_param(device, ram_y_start, &err);
+		ssd16xx_send_y_param(device, ram_y_end, &err);
+
+		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
+		ssd16xx_send_x_param(device, ram_x_start, &err);
+
+		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
+		ssd16xx_send_y_param(device, ram_y_start, &err);
+		break;
+	}
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_WRITE_RAM_BW, &err);
+	ssd16xx_send_data_bulk(device, mono_buffer, data_size, &err);
+
+	/* Re-send border waveform when: every-update mode, init frame
+	 */
+	drm_dbg(&device->drm,
+		"fb_dirty: border check: every_update=%d init_pending=%d border_pending=%d idx=%d hw=0x%02x\n",
+		device->border_refresh_on_every_update, device->init_refresh_pending,
+		device->border_waveform_pending, device->border_waveform_update_idx,
+		device->controller_cfg->border_waveform_table[device->border_waveform_update_idx]);
+	if (device->border_refresh_on_every_update || device->init_refresh_pending ||
+	    device->border_waveform_pending) {
+		u8 idx = device->border_waveform_update_idx;
+		u8 border = device->controller_cfg->border_waveform_table[idx];
+
+		drm_dbg(&device->drm, "fb_dirty: Sending border waveform: 0x%02x\n",
+			border);
+		ssd16xx_send_cmd(device, SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, &err);
+		ssd16xx_send_data(device, border, &err);
+		device->border_waveform_pending = false;
+	}
+
+	switch (device->refresh_mode) {
+	case SSD16XX_REFRESH_FULL:
+		/*
+		 * BW full refresh: write RED RAM BEFORE display_update
+		 * to avoid a post-BUSY write timing issue on some
+		 * controller revisions that silently corrupts RED RAM.
+		 * RED RAM is then bypassed (CTRL1_BYPASS_RED_RAM) so
+		 * stale RED RAM content does not affect the output.
+		 */
+		ssd16xx_send_cmd(device, SSD1683_CMD_WRITE_RAM_RED, &err);
+		if (red_buffer) {
+			/* 3-colour: write red channel before activating */
+			ssd16xx_send_data_bulk(device, red_buffer, data_size, &err);
+			ssd16xx_display_update(device, device->controller_cfg->ctrl1_normal,
+					       SSD16XX_CTRL1_BYTE2_DEFAULT,
+					       ctrl2_tbl[SSD16XX_REFRESH_FULL], &err);
+		} else {
+			ssd16xx_send_data_bulk(device, mono_buffer, data_size, &err);
+			ssd16xx_display_update(device, device->controller_cfg->ctrl1_bypass_red_ram,
+					       SSD16XX_CTRL1_BYTE2_DEFAULT,
+					       ctrl2_tbl[SSD16XX_REFRESH_FULL], &err);
+		}
+		break;
+	case SSD16XX_REFRESH_FAST:
+		/*
+		 * Fast refresh: LUT pre-loaded during hw_init; BYPASS_RED_RAM
+		 * so RED RAM does not affect the current output.
+		 * Write RED RAM BEFORE display_update (same reasoning as FULL)
+		 * so it holds the just-displayed frame as a valid reference for
+		 * any subsequent PARTIAL refresh.
+		 */
+
+		ssd16xx_send_cmd(device, SSD1683_CMD_WRITE_RAM_RED, &err);
+		if (red_buffer) {
+			/* 3-colour: write red channel before activating */
+			ssd16xx_send_data_bulk(device, red_buffer, data_size, &err);
+			ssd16xx_display_update(device, device->controller_cfg->ctrl1_normal,
+					       SSD16XX_CTRL1_BYTE2_DEFAULT,
+					       ctrl2_tbl[SSD16XX_REFRESH_FAST], &err);
+		} else {
+			ssd16xx_send_data_bulk(device, mono_buffer, data_size, &err);
+			ssd16xx_display_update(device, device->controller_cfg->ctrl1_bypass_red_ram,
+					       SSD16XX_CTRL1_BYTE2_DEFAULT,
+					       ctrl2_tbl[SSD16XX_REFRESH_FAST], &err);
+		}
+		break;
+	case SSD16XX_REFRESH_PARTIAL:
+	default:
+		/*
+		 * Partial refresh: both RAMs used for transition waveforms.
+		 * RED RAM must hold the PREVIOUS frame (= current display
+		 * content) so the controller can compute pixel transitions.
+		 * Write RED RAM AFTER display_update so it captures the
+		 * just-displayed frame as the reference for the next partial.
+		 */
+		drm_dbg(&device->drm,
+			"fb_dirty: partial pre-update: mono[0]=0x%02x (BW=new, RED=prev)\n",
+			mono_buffer[0]);
+		ssd16xx_display_update(device, device->controller_cfg->ctrl1_normal,
+				       SSD16XX_CTRL1_BYTE2_DEFAULT,
+				       ctrl2_tbl[SSD16XX_REFRESH_PARTIAL], &err);
+		ssd16xx_send_cmd(device, SSD1683_CMD_WRITE_RAM_RED, &err);
+		ssd16xx_send_data_bulk(device, mono_buffer, data_size, &err);
+		drm_dbg(&device->drm,
+			"fb_dirty: partial post-update: wrote RED baseline mono[0]=0x%02x\n",
+			mono_buffer[0]);
+		break;
+	}
+
+	return err;
+}
+
+/* -----------------------------------------------------------------------------
+ * Plane Functions
+ */
+
+static void ssd16xx_plane_destroy(struct drm_plane *plane)
+{
+	drm_plane_cleanup(plane);
+}
+
+static const struct drm_plane_funcs ssd16xx_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = ssd16xx_plane_destroy,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int ssd16xx_plane_atomic_check(struct drm_plane *plane,
+				      struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *crtc_state;
+
+	if (!new_plane_state->crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+
+	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+
+static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
+					struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_state = to_drm_shadow_plane_state(new_state);
+	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	enum ssd16xx_refresh_mode saved_mode;
+	u8 saved_border_waveform_idx;
+	struct drm_framebuffer *fb = new_state->fb;
+	struct drm_rect rect;
+	int ret, idx;
+
+	if (!drm_dev_enter(&device->drm, &idx))
+		return;
+
+	drm_dbg(&device->drm, "plane_atomic_update: fb=%p\n", fb);
+
+	if (!fb || !device->initialized)
+		goto out_exit;
+
+	if (!drm_atomic_helper_damage_merged(old_state, new_state, &rect))
+		goto out_exit;
+
+	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=(%d,%d)-(%d,%d)\n",
+		rect.x1, rect.y1, rect.x2, rect.y2);
+	/*
+	 * When refresh_mode_init was set, use the specified mode for this first
+	 * frame only, then restore the user-configured refresh_mode so
+	 * subsequent updates continue with the configured mode.
+	 */
+	saved_mode = device->refresh_mode;
+	saved_border_waveform_idx = device->border_waveform_update_idx;
+	if (device->init_refresh_pending) {
+		device->refresh_mode = device->refresh_mode_init;
+		device->border_waveform_update_idx = device->border_waveform_init_idx;
+	}
+
+	/*
+	 * Fast refresh (0xC7) omits LOAD_LUT on every update cycle and relies
+	 * on the LUT being pre-loaded upfront.  The property setter arms
+	 * fast_lut_pending whenever the user switches into fast mode.  Consume
+	 * the flag here (once) before the first fast-refresh frame so the
+	 * controller's LUT is in the correct state.
+	 */
+	if (device->fast_lut_pending) {
+		ret = ssd16xx_preload_fast_lut(device);
+		if (ret) {
+			drm_err(&device->drm,
+				"plane_atomic_update: fast LUT preload failed: %d\n", ret);
+		}
+
+		device->fast_lut_pending = false;
+	}
+
+	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
+	if (ret) {
+		drm_err(&device->drm, "plane_atomic_update: begin_cpu_access failed: %d\n", ret);
+		goto out_restore;
+	}
+
+	ret = ssd16xx_fb_dirty(fb, &rect, device, &shadow_state->data[0]);
+	if (ret)
+		drm_err(&device->drm, "plane_atomic_update: display update failed: %d\n", ret);
+
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
+out_restore:
+	device->refresh_mode = saved_mode;
+	device->border_waveform_update_idx = saved_border_waveform_idx;
+
+	/*
+	 * If this was the init frame (which used border_waveform_init_idx
+	 * inside fb_dirty), arm border_waveform_pending so the normal
+	 * (non-init) border value is sent at the start of the next update.
+	 */
+	if (device->init_refresh_pending) {
+		device->init_refresh_pending = false;
+		device->border_waveform_pending = true;
+	}
+
+out_exit:
+	drm_dev_exit(idx);
+}
+
+static const struct drm_plane_helper_funcs ssd16xx_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = ssd16xx_plane_atomic_check,
+	.atomic_update = ssd16xx_plane_atomic_update,
+};
+
+/* -----------------------------------------------------------------------------
+ * CRTC Functions
+ */
+
+static const struct drm_crtc_funcs ssd16xx_crtc_funcs = {
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static enum drm_mode_status ssd16xx_crtc_mode_valid(struct drm_crtc *crtc,
+						    const struct drm_display_mode *mode)
+{
+	struct ssd16xx_device *device = crtc_to_ssd16xx_device(crtc);
+
+	/* Accept only our device's native mode (landscape or portrait) */
+	if ((mode->hdisplay == device->mode->hdisplay &&
+	     mode->vdisplay == device->mode->vdisplay) ||
+	    (mode->hdisplay == device->mode->vdisplay &&
+	     mode->vdisplay == device->mode->hdisplay))
+		return MODE_OK;
+
+	return MODE_BAD;
+}
+
+static int ssd16xx_crtc_atomic_check(struct drm_crtc *crtc,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	if (!new_crtc_state->enable)
+		return 0;
+
+	return drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
+}
+
+static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
+				       struct drm_atomic_commit *state)
+{
+	struct ssd16xx_device *device = crtc_to_ssd16xx_device(crtc);
+	int ret, idx;
+
+	if (!drm_dev_enter(&device->drm, &idx))
+		return;
+
+	drm_dbg(&device->drm, "atomic_enable: %dx%d orientation=%u°\n",
+		device->width, device->height, device->orientation);
+
+	if (!device->initialized) {
+		ret = ssd16xx_hw_init(device);
+		if (ret) {
+			drm_err(&device->drm, "atomic_enable: hw_init failed: %d\n", ret);
+			drm_dev_exit(idx);
+			return;
+		}
+		device->initialized = true;
+	}
+
+	/*
+	 * If refresh_mode_init is set, arm init_refresh_pending so
+	 * plane_atomic_update uses the specified mode for the first frame
+	 * then restores the user-configured or device default refresh_mode.
+	 */
+	if (device->refresh_mode_init >= 0) {
+		drm_dbg(&device->drm,
+			"atomic_enable: refresh_mode_init=%d, using for first frame\n",
+			device->refresh_mode_init);
+		device->init_refresh_pending = true;
+	}
+
+	drm_dev_exit(idx);
+}
+
+static const struct drm_crtc_helper_funcs ssd16xx_crtc_helper_funcs = {
+	.mode_valid     = ssd16xx_crtc_mode_valid,
+	.atomic_check   = ssd16xx_crtc_atomic_check,
+	.atomic_enable  = ssd16xx_crtc_atomic_enable,
+};
+
+/* -----------------------------------------------------------------------------
+ * Connector Functions
+ */
+
+static int ssd16xx_connector_get_modes(struct drm_connector *connector)
+{
+	struct ssd16xx_device *device = to_ssd16xx_device(connector->dev);
+	bool mode_is_portrait = (device->mode->hdisplay < device->mode->vdisplay);
+	bool orient_is_portrait = (device->orientation == 90 || device->orientation == 270);
+
+	drm_dbg(&device->drm,
+		"connector_get_modes: orientation=%u° mode=%ux%u mode_portrait=%d orient_portrait=%d\n",
+		device->orientation, device->mode->hdisplay, device->mode->vdisplay,
+		mode_is_portrait, orient_is_portrait);
+
+	/* For portrait, swap dimensions so clients see logical size. */
+	if (mode_is_portrait != orient_is_portrait) {
+		struct drm_display_mode *mode;
+
+		mode = drm_mode_duplicate(&device->drm, device->mode);
+		if (!mode)
+			return 0;
+		swap(mode->hdisplay, mode->vdisplay);
+		swap(mode->hsync_start, mode->vsync_start);
+		swap(mode->hsync_end, mode->vsync_end);
+		swap(mode->htotal, mode->vtotal);
+		swap(mode->width_mm, mode->height_mm);
+		mode->type |= DRM_MODE_TYPE_PREFERRED;
+		drm_mode_set_name(mode);
+		drm_mode_probed_add(connector, mode);
+		return 1;
+	}
+
+	return drm_connector_helper_get_modes_fixed(connector, device->mode);
+}
+
+static const struct drm_connector_helper_funcs ssd16xx_connector_helper_funcs = {
+	.get_modes = ssd16xx_connector_get_modes,
+};
+
+static const struct drm_connector_funcs ssd16xx_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const u32 ssd16xx_formats[] = {
+	DRM_FORMAT_XRGB8888,  /* 32-bit RGB with padding (preferred) */
+	DRM_FORMAT_R1,        /* 1-bit monochrome (native, zero-copy path) */
+};
+
+DEFINE_DRM_GEM_FOPS(ssd16xx_fops);
+
+/*
+ * ssd16xx_drm_master_set - arm init refresh when a new master takes control.
+ */
+static void ssd16xx_drm_master_set(struct drm_device *drm,
+				   struct drm_file *file, bool from_open)
+{
+	struct ssd16xx_device *device = to_ssd16xx_device(drm);
+
+	if (device->refresh_mode_init >= 0)
+		device->init_refresh_pending = true;
+}
+
+/*
+ * ssd16xx_drm_master_drop - clear display and disarm init refresh when the
+ * master client exits.
+ */
+static void ssd16xx_drm_master_drop(struct drm_device *drm,
+				    struct drm_file *file)
+{
+	struct ssd16xx_device *device = to_ssd16xx_device(drm);
+
+	device->init_refresh_pending = false;
+}
+
+static struct drm_driver ssd16xx_drm_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops = &ssd16xx_fops,
+	.name = "ssd16xx",
+	.desc = "DRM driver for SSD16xx e-paper controller family",
+	.major = 1,
+	.minor = 0,
+	.master_set  = ssd16xx_drm_master_set,
+	.master_drop = ssd16xx_drm_master_drop,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+};
+
+static const struct drm_mode_config_funcs ssd16xx_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+/*
+ * Use the RPM commit-tail variant so that drm_atomic_helper_commit_modeset_enables
+ * (which calls crtc_atomic_enable) runs before drm_atomic_helper_commit_planes.
+ * Without this, the standard commit_tail calls commit_planes before
+ * modeset_enables, so plane_atomic_update would see initialized == false on the
+ * first commit and silently drop the frame.
+ */
+static const struct drm_mode_config_helper_funcs ssd16xx_mode_config_helper_funcs = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
+static int ssd16xx_alloc_tx_bufs(struct ssd16xx_device *device)
+{
+	/*
+	 * Allocate for the maximum buffer needed across orientations: each row
+	 * is padded to a byte boundary (DIV_ROUND_UP(dimension, 8)), so
+	 * take the maximum of row-major landscape and column-major portrait.
+	 */
+	size_t frame_size = max(DIV_ROUND_UP(device->width, 8) * device->height,
+				DIV_ROUND_UP(device->height, 8) * device->width);
+
+	device->tx_buf = drmm_kmalloc(&device->drm, frame_size, GFP_KERNEL);
+	if (!device->tx_buf)
+		return -ENOMEM;
+
+	if (device->device_cfg->red_supported) {
+		device->tx_red_buf = drmm_kmalloc(&device->drm, frame_size, GFP_KERNEL);
+		if (!device->tx_red_buf)
+			return -ENOMEM;
+	}
+
+	if (!device->dc) {
+		device->tx_buf9 = drmm_kmalloc_array(&device->drm, frame_size,
+						     sizeof(u16), GFP_KERNEL);
+		if (!device->tx_buf9)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int ssd16xx_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct ssd16xx_device *device;
+	struct drm_device *drm;
+	const struct spi_device_id *spi_id;
+	struct drm_display_mode *mode;
+	const void *match;
+	enum ssd16xx_model model;
+	u32 dt_rotation = 0;
+	int ret;
+
+	match = device_get_match_data(dev);
+	if (match) {
+		model = (enum ssd16xx_model)(uintptr_t)match;
+	} else {
+		spi_id = spi_get_device_id(spi);
+		model = (enum ssd16xx_model)spi_id->driver_data;
+	}
+
+	device = devm_drm_dev_alloc(dev, &ssd16xx_drm_driver,
+				    struct ssd16xx_device, drm);
+	if (IS_ERR(device))
+		return PTR_ERR(device);
+
+	drm = &device->drm;
+	device->spi = spi;
+	device->model = model;
+	spi_set_drvdata(spi, device);
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = SSD16XX_SPI_BITS_PER_WORD;
+
+	if (!spi->max_speed_hz) {
+		drm_warn(drm, "spi-max-frequency not specified, using %u Hz\n",
+			 SSD16XX_SPI_SPEED_DEFAULT);
+		spi->max_speed_hz = SSD16XX_SPI_SPEED_DEFAULT;
+	}
+
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		drm_err(drm, "SPI setup failed: %d\n", ret);
+		return ret;
+	}
+
+	switch (model) {
+	case GDEY042T81:
+		device->controller = SSD1683;
+		break;
+	default:
+		drm_err(drm, "Unknown panel model: %d\n", model);
+		return -EINVAL;
+	}
+
+	if (device->controller >= ARRAY_SIZE(ssd16xx_controller_configs) ||
+	    !ssd16xx_controller_configs[device->controller].max_width)
+		return -EINVAL;
+	device->controller_cfg = &ssd16xx_controller_configs[device->controller];
+
+	if (model >= ARRAY_SIZE(ssd16xx_device_configs))
+		return -EINVAL;
+	device->device_cfg = &ssd16xx_device_configs[model];
+
+	mode = devm_kmemdup(dev, device->device_cfg->mode,
+			    sizeof(*device->device_cfg->mode), GFP_KERNEL);
+	if (!mode)
+		return -ENOMEM;
+
+	device->refresh_mode = device->device_cfg->default_refresh_mode;
+	device->color_mode   = device->device_cfg->default_color_mode;
+	device->border_waveform_init_idx   = device->device_cfg->default_border_waveform_init;
+	device->border_waveform_update_idx = device->device_cfg->default_border_waveform_update;
+	device->border_refresh_on_every_update =
+		device->device_cfg->default_border_refresh_on_every_update;
+	device->refresh_mode_init = device->device_cfg->default_refresh_mode_init;
+
+	/* Parse "rotation" DT property; swap mode dimensions for portrait. */
+	device_property_read_u32(dev, "rotation", &dt_rotation);
+	if (dt_rotation != 0 && dt_rotation != 90 && dt_rotation != 180 && dt_rotation != 270) {
+		drm_warn(drm, "Invalid DT rotation %u, defaulting to 0°\n", dt_rotation);
+		dt_rotation = 0;
+	}
+	device->orientation = dt_rotation;
+
+	device->width = mode->hdisplay;
+	device->height = mode->vdisplay;
+
+	drm_dbg(drm, "Using %s orientation (%u°, physical %ux%u)\n",
+		(device->orientation == 90 || device->orientation == 270) ?
+		 "portrait" : "landscape", device->orientation, device->width, device->height);
+
+	/* Swap mode dimensions for portrait so clients see logical size. */
+	if (device->orientation == 90 || device->orientation == 270) {
+		swap(mode->hdisplay, mode->vdisplay);
+		swap(mode->hsync_start, mode->vsync_start);
+		swap(mode->hsync_end, mode->vsync_end);
+		swap(mode->htotal, mode->vtotal);
+		swap(mode->width_mm, mode->height_mm);
+		drm_dbg(drm, "Mode dimensions swapped for portrait: %ux%u\n",
+			mode->hdisplay, mode->vdisplay);
+	} else {
+		drm_dbg(drm, "Mode dimensions unchanged: %ux%u\n",
+			mode->hdisplay, mode->vdisplay);
+	}
+	device->mode = mode;
+
+	/* Validate panel dimensions against controller hardware limits. */
+	if (device->width > device->controller_cfg->max_width ||
+	    device->height > device->controller_cfg->max_height) {
+		drm_err(drm, "panel %ux%u exceeds controller max %ux%u\n",
+			device->width, device->height,
+			device->controller_cfg->max_width,
+			device->controller_cfg->max_height);
+		return -EINVAL;
+	}
+
+	/*
+	 * For byte-addressed X (SSD1683, ram_x_address_bits == 8), each X
+	 * address covers 8 pixels.  The panel width must be a multiple of 8
+	 * so that (width/8 - 1) gives the correct byte-aligned window end.
+	 */
+	if (device->controller_cfg->ram_x_address_bits == 8 &&
+	    device->width % 8 != 0) {
+		drm_err(drm, "panel width %u not a multiple of 8 required for byte-addressed X controller)\n",
+			device->width);
+		return -EINVAL;
+	}
+
+	/* Acquire GPIOs. */
+	device->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(device->reset))
+		return dev_err_probe(dev, PTR_ERR(device->reset), "Failed to get RESET GPIO\n");
+
+	device->busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
+	if (IS_ERR(device->busy))
+		return dev_err_probe(dev, PTR_ERR(device->busy), "Failed to get BUSY GPIO\n");
+
+	device->dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(device->dc))
+		return dev_err_probe(dev, PTR_ERR(device->dc), "Failed to get DC GPIO\n");
+	if (!device->dc) {
+		if (!spi_is_bpw_supported(spi, 9))
+			return dev_err_probe(dev, -EINVAL,
+					     "3-wire SPI mode requires 9-bit word support\n");
+		drm_dbg(drm, "dc-gpios not specified, using 3-wire (9-bit) SPI mode\n");
+	}
+
+	ret = ssd16xx_alloc_tx_bufs(device);
+	if (ret)
+		return ret;
+
+	ssd16xx_hw_reset(device);
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	drm->mode_config.funcs = &ssd16xx_mode_config_funcs;
+	drm->mode_config.helper_private = &ssd16xx_mode_config_helper_funcs;
+	drm->mode_config.min_width = min(device->width, device->height);
+	drm->mode_config.max_width = max(device->width, device->height);
+	drm->mode_config.min_height = min(device->width, device->height);
+	drm->mode_config.max_height = max(device->width, device->height);
+
+	drm_connector_helper_add(&device->connector, &ssd16xx_connector_helper_funcs);
+	ret = drm_connector_init(drm, &device->connector, &ssd16xx_connector_funcs,
+				 DRM_MODE_CONNECTOR_SPI);
+	if (ret)
+		return ret;
+
+	ret = drm_universal_plane_init(drm, &device->primary_plane, 0,
+				       &ssd16xx_plane_funcs,
+				       ssd16xx_formats, ARRAY_SIZE(ssd16xx_formats),
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&device->primary_plane, &ssd16xx_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(&device->primary_plane);
+
+	ret = drm_crtc_init_with_planes(drm, &device->crtc, &device->primary_plane,
+					NULL, &ssd16xx_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&device->crtc, &ssd16xx_crtc_helper_funcs);
+
+	ret = drmm_encoder_init(drm, &device->encoder, NULL, DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	device->encoder.possible_crtcs = drm_crtc_mask(&device->crtc);
+
+	ret = drm_connector_attach_encoder(&device->connector, &device->encoder);
+	if (ret)
+		return ret;
+
+	drm_mode_config_reset(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		return ret;
+
+	drm_dbg(drm, "SSD16xx e-paper display initialized (%dx%d, %d° rotation)\n",
+		device->width, device->height, device->orientation);
+
+	drm_client_setup(drm, NULL);
+
+	return 0;
+}
+
+static void ssd16xx_remove(struct spi_device *spi)
+{
+	struct ssd16xx_device *device = spi_get_drvdata(spi);
+
+	drm_dev_unplug(&device->drm);
+	drm_atomic_helper_shutdown(&device->drm);
+}
+
+static void ssd16xx_shutdown(struct spi_device *spi)
+{
+	struct ssd16xx_device *device = spi_get_drvdata(spi);
+
+	drm_atomic_helper_shutdown(&device->drm);
+}
+
+static const struct of_device_id ssd16xx_of_match[] = {
+	{ .compatible = "gooddisplay,gdey042t81", .data = (void *)GDEY042T81 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssd16xx_of_match);
+
+static const struct spi_device_id ssd16xx_id[] = {
+	{ "gdey042t81", GDEY042T81 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ssd16xx_id);
+
+static struct spi_driver ssd16xx_spi_driver = {
+	.driver = {
+		.name = "ssd16xx",
+		.of_match_table = ssd16xx_of_match,
+	},
+	.probe = ssd16xx_probe,
+	.remove = ssd16xx_remove,
+	.shutdown = ssd16xx_shutdown,
+	.id_table = ssd16xx_id,
+};
+module_spi_driver(ssd16xx_spi_driver);
+
+MODULE_AUTHOR("Devarsh Thakkar <devarsht@ti.com>");
+MODULE_DESCRIPTION("DRM driver for Solomon SSD16xx e-paper display controller family");
+MODULE_LICENSE("GPL");
-- 
2.39.1

