Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA091FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 06:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B2F10E92B;
	Tue,  5 May 2026 06:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iiaEsIEY";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A3D10E92B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 06:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQZBCzMPCf+psQpQABBzRkuIy761bzfFyBFdP9cw1PNj3lV1McvqBy2UVsdGC/3N6MpcEyBqWqNObXDmDhXAHjB6zCWvs+dmaSJVqqlidu/wMeutkL4HLfma9Fy5o5xwYJhLNnfEcJVY21lAyzIgwuaEiOE5lvkmPrYQglzrYSHxf6BKj6A/F9segmbZ3Ou0zhu3IrGOH3nSOE6goZs2ADU0i/y1G0I5EUrHCygcwjbBMtxWQZVfKOnO3XnbpmdeihtJyRuLlib0RG0e8mYbGzs5vibx2ZE7edsmJr7u6IJctq1ewE2AToEBws6yyN7AynqF1GPU+G1yupPoaDGWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnZVujZDP0WbsJZVkLUt0bSLsKfikaNUmRORvJR+O5Y=;
 b=ugw2NAUqj+4UZmDyeEmlB+zd2Ez2OFWaz3CUr/+vpeN5hXIE/UXX6sXpiolc/nMieoirRr/4DRdGKGFT8jgrIKqfd2MLpiqinRgbrq7ywADTR7z/M0J7HjWFVluiiTxSls6bNuViX1yWtqM+gIxJ5YUajVy6NjJJgA0IQLBXHYVceYAM9amlvKiOWSd96QqZK3duqvB5o3NkMMJOQ0n00aabH8G2Zhp145EIXH5Our9o84PZ0TMz4fT46SpKz7oPR67Y9FjEE4Yb2F6vnLwphco1GwL1MKPBI38ZzbqUikEOc31zRzz+BM4r46eQ94zW7q4ncYMXcCOX4denzcTVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnZVujZDP0WbsJZVkLUt0bSLsKfikaNUmRORvJR+O5Y=;
 b=iiaEsIEYce1L4e4BqD53eYXl3/BfiJtdhmQfedxxVA+eT+NiAc7wsMuROnHfooKHoUo9MeJqt0lfQLPBc5pPIlZN4a7/mUeWqmAUNt2Eh+kk3bH5lf6YFuRmJsbU3eTQvqljgZM7ii7ZlKO35bxRad40lMFZgrgNNh1t0RPzIso=
Received: from BN1PR14CA0003.namprd14.prod.outlook.com (2603:10b6:408:e3::8)
 by SJ0PR10MB5718.namprd10.prod.outlook.com (2603:10b6:a03:3ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:25:10 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::68) by BN1PR14CA0003.outlook.office365.com
 (2603:10b6:408:e3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 06:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Tue, 5 May 2026 06:25:09 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:25:09 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:25:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 01:25:06 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com
 [172.24.233.62])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6456P1pv2369282;
 Tue, 5 May 2026 01:25:01 -0500
Message-ID: <9eb58fea-23e9-43a6-90f1-f8567f0dfbf9@ti.com>
Date: Tue, 5 May 2026 11:55:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: defconfig: Enable DRM_PANEL_SSD16XX
To: Krzysztof Kozlowski <krzk@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson
 <bjorn.andersson@oss.qualcomm.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <s-jain1@ti.com>, <s-wang12@ti.com>, 
 <r-donadkar@ti.com>, <r-sharma3@ti.com>, <afd@ti.com>
References: <20260430183311.2978142-1-devarsht@ti.com>
 <20260430183311.2978142-7-devarsht@ti.com>
 <faed4992-3f9d-4729-bdb6-e60e6bc8ee05@kernel.org>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <faed4992-3f9d-4729-bdb6-e60e6bc8ee05@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ0PR10MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd86ede-ae36-4451-a608-08deaa6f0ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RFAi2noSAmq4G2MBVdRuGk0Osdw18J9Aa9WOAx2HWUWVI13D4C/ZAeF3XYsDZPdkeyeghHOSVZuCy6X0nCObakVzlTz+lKz/OKRNFWSwhyngpFxwKZ2zFQ08p3IMwPRrf5zFpXUcyMecSXCggX0FlfvQsXlg1Cg7Elj5R10vKsyUCnjQXrmtt8SfmzuzJqLViTXh1SGG8JcSOfBYBlIrr2vUFTHwjovZ1UmMF5nmV5h0aGTSExR6DSHNMHMvN/X+c59cJPorDy4MiMePbrDIHt8ttkFXZh4YqYoy438TzNsNCRgJTbdUWgm/xSg2VTLzAIspqW6k1GWlCVEhJJsMLwr4VaDqrVysB40bd38sLGy2SG9o+KbbeE5SgVsHeXx7YqsZXV8qFsr7/dpxcooP5fQDdVgxuuhpzLOaaQk05hwJwoq3AQXpBFiyEjcOMUbKLxgDVYneIyYs8WAUdzVYQsS6yjDMlmhZQ/SdhqofdANh8NxrPPMORv34Avvdj8uzcBTkBWsEsFSRD5Bmj3j2AxuhcDVO6A9AfbRo2ceSTAHN07SYg6FZ/3pAx7AfqP4tc0K7hpODLivaNaQFp/y/DovuZms8UwIRGkCxss1XVvlsbWV9/UOQmzwzia24iN4KKFeiDPuM8/ORds4NTi1TFzE98ZSfqAYOSX7WwAJZsmov+WF/9iFAous0WQ5erLuk+UGaYbRPauHNYVul4bh2VnGpQjV+sbUOcJsVG1YBbpW9VBBEsw2Vcv884G87gig8y69hQXFzQt+u+q5bi+R+lA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(7416014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7qIfMRgo/1nOoR3t95KxUg4OEbXLueWWOsH/YvrExp5GX9duK/tsG7Re/2xrgjsb/eGv2Nw1K3ENPHeZ4qC/LSgD8XbfDM5uZIWVAGv3Cjz9V+wKuP99UDvhNrvord7QSn61ezTcBWRilJrN6zvUVV4PGltAXCoO2oMsSFnwRWEBwykD0aUQcXWRFVJWr5oofJjhhHdMol72+6YqElKpA01hn9EQrFFgevRUKjzojk8P95xw+XbgqR4256uowZphCbpIDuu2AteiVclBNlqKPVL6IkT6tkf2nEK+1dFZlRyM++NeWV6vSBrDZb2dczwln4oV6W14cUdKYpRDnH9ukhRE29CXT2WCRfHaqd45rfRLMNQc+BnJp6gUJBcma5EdF4PrEB05vtb5th7f0ZqcF6FWQCnDo856aONuOTy57upACC4K8m7hdukmIHkTPCYJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 06:25:09.8851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd86ede-ae36-4451-a608-08deaa6f0ed4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5718
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

Hi Krzysztof,

Thanks for the review.
On 01/05/26 15:00, Krzysztof Kozlowski wrote:
> On 30/04/2026 20:33, Devarsh Thakkar wrote:
>> Enable the Solomon SSD16xx e-ink display controller driver as a module
>> in the arm64 defconfig, making it available by default on TI AM6x SoC
>> platforms that use this driver.
> 
> You need to name here the actual platforms (boards) having this device.
> 

Noted, will update the commit message in v2 to make it more clearer. 
Just to clarify: while tested with AM62L3 EVM, this is not specific to 
any particular platform. The SSD16xx family are SPI-based e-paper 
display controllers and display panels using these controllers can work 
with any platform supporting a SPI interface.

Regards
Devarsh
