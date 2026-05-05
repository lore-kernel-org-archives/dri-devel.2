Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A2AFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C1B10E416;
	Tue,  5 May 2026 12:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ws4d9dX4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8FA10E416
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFw+bYFvS03UCiK610uDxCSMdT4w661OX7nndxf2URy5witFtkjAHxy23E1D5GkGNHrzMk7v9j+VbbMINHxNUsGiEt/YNGO59yLRIH1zlTA99yYC0KWYLQuO5BiWJm5Y2mlGUKoHnuFvifIwCp5m100kXWIDyu0H6O5rZOaHO7pQRn3b0Imz3Xz3QXgKPyRSc4Al/uux9c48FZOZU4rfKpA8x5mfHfg28W2upDuqvtVkef1armskaFTrjPIhe5tXd+zmzlFWjl8kNUaFJsh6wKarfqr/FAe5P1AnmiVTce/bYqV5FhNUL2WfFZ0GbG8g9jUfJTxyayUJ/vFaMhPG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyquEwQFbAeqNZC+xVAj+dHfkZpBcy3xQ0tdiPIeJ5o=;
 b=QNEepXXKX7ieccUvkwiJPFxwJYgvniYg9TYwiorey/tnR4PgSZ1HCbBCGbbTRBw1FMGJXoPfbpcBsLK3tRREW9njo7184722+o9YnAuI4Q/2q87gfc1TYHnAt3flkVdBaH/fX4TrXjOsfG0Hj9mn5q7os2N851DqQtgRc2QEZITEhF0znOFIMDsu6gl9LUXWSdHne+wgFpWVhtq2mFsofNmjGbM/wZyW84DHVJwIw6oH3H3gCJ5zgmWehY/UWSrJDWYtNGIo8E2krVULb33MM29lvtK4XMtTOlrn0DY6ocZp/THAaIg2/nb0QqzUNqa1Qcwj2f9SVy3LAPTRvm4HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyquEwQFbAeqNZC+xVAj+dHfkZpBcy3xQ0tdiPIeJ5o=;
 b=Ws4d9dX4T5vaBRJ/2GVGgZnaJEWET80Va8MUa2KSQxN75Q47OLCSXRvgvfEK7LMo6qn516d3HkGcw8iiefdRKw0iMluy198JXYk3TNRadmRdNefEbGg8h1fiJPdvnpy3uLEvmP7rxMB6T9Bv4XPn2quI2l7+lTzzu/65sfMKCSs=
Received: from SA1P222CA0174.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::23)
 by LV3PR10MB8106.namprd10.prod.outlook.com (2603:10b6:408:27f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:42:51 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::8a) by SA1P222CA0174.outlook.office365.com
 (2603:10b6:806:3c3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 12:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 12:42:49 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 07:42:16 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 07:42:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 07:42:14 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645CgDFj3263870;
 Tue, 5 May 2026 07:42:13 -0500
Message-ID: <87f9d1b9-045e-4db8-9176-e81391288dd6@ti.com>
Date: Tue, 5 May 2026 07:42:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: defconfig: Enable DRM_PANEL_SSD16XX
To: Devarsh Thakkar <devarsht@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Bjorn
 Andersson" <bjorn.andersson@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <s-jain1@ti.com>, <s-wang12@ti.com>, 
 <r-donadkar@ti.com>, <r-sharma3@ti.com>
References: <20260430183311.2978142-1-devarsht@ti.com>
 <20260430183311.2978142-7-devarsht@ti.com>
 <faed4992-3f9d-4729-bdb6-e60e6bc8ee05@kernel.org>
 <9eb58fea-23e9-43a6-90f1-f8567f0dfbf9@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <9eb58fea-23e9-43a6-90f1-f8567f0dfbf9@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|LV3PR10MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c87e8a1-7152-4aaa-7936-08deaaa3d0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6JJCJp7aRbV6duRv/cUT1qRUCJhPia8WQfBB+qmcy4B3bfWvnKrPwiaG1G5XSzEFL195sj0v8zKUJURHyWTVex6VspIdKoYjaTb3sXDwdhBVIjxdNwAmr7fj/g1t5sta3ocsztRD/WCBpmakY0NLMFV67JEp30QBswK6hvt8r8BeVKBA/xrlrrauVK12ATOD98h7IAnOG51DOQGuJs6pKd1jyzn2LvXiy4qgfDBjvCW45HFylmUTFppPowJQoKVGVLfLRd0QzV0ewvhbkMxTFd/uHz4jmOffSW6zxSNVvPWJ4Ck95fFtsEvqK/NAhsnOIR3kIMDPUzUQVdhWdabv9Gi5aBvR9zcyxC/2jbfsoqmxvCE1pl1N5GQkRgOG2mGV2JdkkEjBLpFEhyQBAphmLcM1GS/hS5zaMTqEL6KNCXJZXB9tOPVUyPNsnzOAwK9C6/TpQGVwy8sehGXU6q5RnDBu+5bCUchQMFLMrJe1wGrcUbLh++6Z4xd0bhomgmWraAy1VQ9peyH+AO59MKedDex6VuaQpXpY4ncVSBVq0skYiPPoHK3WzsOJ2l0Y9eLIRp8XmxQUcF9rm8UKn/feL1bVB94WoXMHIYg6k5BlmnhtB0QApkbbFwiCZJuEJOZuNd+G2Iq5OnZKjuV9fZCuTZ53xHYsGdB34kDtTJtDGpEihmRXmqqWrUgndWhzWuxKUsx3EmUhwMwedKFycg30ElezcZoozm/ce1cIhcL9sh8=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vw1VdOF49YUlVWGFZOWIdlyYPlPjxXO1izkENphOwdW3YXftFc3ixTFvuFKJrf6MMWrP9oDOir113NgdKYaeLccHUqkdG7/EQgGrTqrMvMKqgdowhDhzy6+erWFKuz3Ys/QNWo8JYAjZG9tq3OIi+aMWbkIjjPRgvZl5a6ethAKAyTFqoE2y+7oCouMTdXEYYBFxY+6LZ1SGSHrlrNZ2UMXRU0T4si1u6wXWIiQELhqX40CxUIa5c7IsI5/6iKpxE9JrYb6K7o5TEZogg+RRGXGMFuzsMsAJcOEsEH4VWNonO+O+nqiFcyURFcvI+kEZs6wuH96F/FKFu9nVMYAeSF9o4szlSS7ByxqjFx/lopSx2GJX1YdUmuh8rLwum3EU14/yFElBAgzG1kFRU4Dl2qq2cQ67ZLFZ6ldRBrYRy0PdLK6WFD+uSrJBY+GXRuga
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:42:49.2969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c87e8a1-7152-4aaa-7936-08deaaa3d0dc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8106
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

On 5/5/26 1:25 AM, Devarsh Thakkar wrote:
> Hi Krzysztof,
> 
> Thanks for the review.
> On 01/05/26 15:00, Krzysztof Kozlowski wrote:
>> On 30/04/2026 20:33, Devarsh Thakkar wrote:
>>> Enable the Solomon SSD16xx e-ink display controller driver as a module
>>> in the arm64 defconfig, making it available by default on TI AM6x SoC
>>> platforms that use this driver.
>>
>> You need to name here the actual platforms (boards) having this device.
>>
> 
> Noted, will update the commit message in v2 to make it more clearer. Just to clarify: while tested with AM62L3 EVM, this is not specific to any particular platform. The SSD16xx family are SPI-based e-paper display controllers and display panels using these controllers can work with any platform supporting a SPI interface.
> 

If it is not on any supported board then it doesn't need enabled in the
defconfig. But in this case it *is* needed for a board we are working
to get upstream: https://www.beagleboard.org/boards/beaglebadge

You should name that platform in the commit message.

Andrew

> Regards
> Devarsh

