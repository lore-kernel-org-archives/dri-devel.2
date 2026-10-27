Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F4606A322
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Tiw3W/jZ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=KA48lq5p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48793112040;
	Thu, 29 Oct 2026 07:58:58 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1005510F4C7;
 Tue, 27 Oct 2026 13:16:03 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69RBCxdS3385585;
 Tue, 27 Oct 2026 08:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4QpxqvOximLZ2nALPoSuAYx/SSuI12rZw9hrif0qD
 TM=; b=Tiw3W/jZvVUUJd1CWfJVZs0xtoL7VzFhPiFC5iFSaWNy1Xoyhx6pGvf1m
 6OZ82C0S7k8eTt4kcMrJy388P9ElvaYbeclqa5ZB77Lw6UUgHKPBJGLaCcz/ql4y
 pV5jwyXl+LaqcMOkhnOHPBsN6w2x9N1SZ1Y6J3ci6ifIBADf8N0HXE53Pg3RpFBJ
 mozarXPvvLhw34THy9F9lLlhP7RtVW0tR0FEphCxHQOWHbvtFZZyaJIna5mUUZHA
 Vc8WURaLpiaWZiH2se0I/Ridj3sUhvDHqym1TrNFi+y+IHdOt08FqB1uMLQ9M7Wp
 H8ufjIYrolvHrDC6GET27rBIQDVNw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hjtvxgk9n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 08:15:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG/wSpbH6W9mq3DWt4bO8mb2iG61ZoJmeuOB3gE3ACufd3BiGjCAzCCJ82RXcbiZmXSNy8SAUl2+41aZq2qOTt05ZGS+vO5gRwijSdaU3UMT0dLVrL7iwUOfrQrT00rWrq7lDLxlqp/HiXN134fVzX1Pm/xb80KiYgE0PDv/M2ITbGHJFHlUchuVeeJSK6JqQyfeeceIyaL5GadI0Ful2iodcYH4i6Nwtewb5VTX07P1xEQdtC4oQRieQ7UbClfoURgkWl0YRo+EqDN2Ab6yBllBjkG59YAHwJpWmhUcHaiu58vVNhFevb5lq7Gm1ydOa3kFBfYPbRp0doAUMmBY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QpxqvOximLZ2nALPoSuAYx/SSuI12rZw9hrif0qDTM=;
 b=g+Xm5z9W7K+0UusJrYsqDZvZqtJ5PGRZ+fkH2Kqxwo3Jabuoyz5zUwvS1fIIXNwlg3WB1WGA2l1l8xTt3kpPM4EBP5K4SY4UKPdwpmKFGqJB4au8Q2iMRhh2Syx7dVfOaJpokEEZdcoBzPw1C/vzVMiplgl3UW5K8uxTIMsbYkvPXJytmPMiruvmgvgg/C2e+cv6JdAgTJBD1lPF1s1zTH4YX5I9vHZYgTLrHtF3Gm6j18HlvloRcs7D0sWETN777BjRb5wj99GSvt2Osm/HNYD1/Paxm9YGkjZoXE1QUM8+CvIDQaS14BCv2lnQV0u0iLomgHGhVvQ2nq22JXDtPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=debian.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QpxqvOximLZ2nALPoSuAYx/SSuI12rZw9hrif0qDTM=;
 b=KA48lq5pgNeCfQ1fZDQ6U85y5qU0hGL2qp8xZF87JKrR1FZsBwdZ5IRWFRLLWf1VUGg6j/q8kc3laGC15/ByP2cvTwbXHOKHSWzK8lGD5hD2fhHcK3QyrxYi8YjrZSY6XmWUjVNXruyjqWkIcFYCjLtEDYx85b04SbKYOzwS0l8=
Received: from CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::12)
 by SN4PR10MB5542.namprd10.prod.outlook.com (2603:10b6:806:1e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:15:33 +0000
Received: from MN1PEPF000793FA.namprd05.prod.outlook.com
 (2603:10b6:610:1ef:cafe::86) by CH5P220CA0008.outlook.office365.com
 (2603:10b6:610:1ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Tue,
 27 Oct 2026 13:15:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF000793FA.mail.protection.outlook.com (10.167.249.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 13:15:31 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 08:15:01 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 08:15:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 08:15:01 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RDEsWk1966258;
 Tue, 27 Oct 2026 08:14:55 -0500
Message-ID: <f308e372-255b-41d8-9225-959750950780@ti.com>
Date: Tue, 27 Oct 2026 18:44:54 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
To: Mark Brown <broonie@debian.org>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Nirujogi Pratap
 <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
 <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
 <Ritwick.Sharma@arm.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, "Breno Leitao" <leitao@debian.org>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk>
 <40844e94-c9d8-430b-90b0-66032e66060f@ti.com> <atc5KhqlzczEhQ-z@sirena.co.uk>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <atc5KhqlzczEhQ-z@sirena.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FA:EE_|SN4PR10MB5542:EE_
X-MS-Office365-Filtering-Correlation-Id: 1209d3cf-2068-4afe-2780-08df342c60d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|22082099003|18002099003|56012099006|4143699003|10067099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: wKY1h52GaFxQy6JTEws6Ry9+zBr6QlgyP/k1ixQ1wed9xpZOWup01hxojTUjox9DSwOsn0lOOHqWIz6EwKrbIOM2BI6zFfjCsIHvojLq4JRjMF+b5EAlUVQ5qv/XIA1NNXhh4LIv9RjZzsfaDdgPdPsBJUHKITSBm9BZH6SwPOWLNGQCgV5S9xPSuz0FcZAW4vgoYvJoYSAsQciI2v4PKtIe/ENzQ9Bg48CP1/MucRZHD4kGR/KSpP8wADaTLitMSHGqvR9axil1QTJnOeQsjtbyMUajKScUobgsgRmMFTWLd/p2wDbXywClMn+N5GVewF+Nxk2FehoQw0zVFMNhfA21L5vsYUsltRGvq3UWHd0RE9JX1KL5zSt8FwD7JseHpP1o7LhRRGLm5U6464ndsj3UORLL++l8OzPHEEuTRwGD+oAEG3c1AIgsUNE+c2fiwXnca+8th0L9SwLeLbqUANQxYMZLwIvpn0V+FcTPkI2Zk7DoadbRE/+Paysd+oIFOBz7nt+DxYJqqTj1/cSurKu0aHxcaqYlY3ni6pGp84ItTbrCXy/2hu9/+sSEhsA6CO5qsOTx+GilS4YzwEQy8i/WvY6vRpVrs6bOstYAC+aqz14ilzD0q39a4YuCOSiFcq1cxN9/jKobTFGjUeoicA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yqkeJT7XUFdwyIzBuLC311fdsCRFJPIYUB3aDi1g4SEDAD7UbALR2c+23EEj5gpOISC9g9l0wtmKbrh2Fg52PIfF+UYdENflUneKNrAxSaWtL4ryrVPyA4FTXimzTATMk+kRi4OCdTw4uxCNFBm/4qwiETJKDjnOmYDqpF3kQIU1CQvbYMREtFalu/t6EUXc+jcmSephNQyON+TfIcVgvhiCChcj9VIkjmCr2RpV4qyHQ8czYlBn9jyFAs6Psd8OKdySDi2t6lwk+Lu94SDlv/VkWfeL467aUGxEw1bYbPcHgMx8GNMwr6auIZNm3XSa9rGywrKeOVLojUITFmCb7T/IrZbYXKEAadbSC97DjWrSTMta8L89Stn3263bAgPm3zkTYGBIikHmg2WXF4vRmTLfpg1WnDyVviWyI/uDFkrVCojvioOXNoX7/y5s262H
X-Exchange-RoutingPolicyChecked: NG/IT8mFyTwH5m9k1Eh+LeBQMJ2Km6mFIy0c9lXDtQwvyfiQvXO1GfNRMa0WnpW7/X1v6KsiRrF1fkDsXj8UnnSvaYeR4p8tvWDLVTMxTiAQ+68djcuYCVLUO9qiOI2vOlx+dVAOezAo95XRe1Khc77vDvDKAY5/5vTbqyHvGjPL08EzEcRrBvkvHgJ2/BncxPxNn0iCEjhuIVuK1YupInnJzA6TdjQomGjPV+FEkGtOrVa/uXm51qKs0AtnK9mligNq1eotKhLbmT7VLUtdETFY34l+xBXQCP3hiFaxDGVQSLCuE5LEDCZcjyIvvbwFOrKsj2hAsPhRMimfCaQuLQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:15:31.6682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1209d3cf-2068-4afe-2780-08df342c60d8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5542
X-Proofpoint-ORIG-GUID: KuULCDGDRS_y1lfY0_B4ezHz-IbC7TzT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1MiBTYWx0ZWRfX+ozeNoyNZJC4
 xzFSeuXFx3e/VeAH5olJ6o0HaRUgmwVp9+/3TnHFqGHOqfingqMCmLkLW47XJ42N/bkLKPjrNCA
 MGmixhwA76hTxNQHOhGFmwye9izjIl8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1MiBTYWx0ZWRfXz3HJbryiK1TB
 31WgqnCOvmWAOGCwsnr9V+t28EAdl5eW5p0lrbzIj9I3sLg24gIB82bE3Ybxkn/L3FkhOAn45tS
 b8BgJ2s0LRhgV+9ZPEJwvWquN48wt82qlX13dkv+gaHIVFfVDlOl4GCGDumhRkqXWxhuxFBrilM
 waCjVwMXk++vzCK8kokCTtBG3Pf9MV0ekBJHHj8fYHRypBlQGnk5pJSOpbXPSVMkpURBUg/VDX9
 AaLe4Z56T8zY531n4iSlHA1s+2uyxLNSYLt2ef//F4FGmChbJigXKOToH6t0HmYNGkRacG3e2Ge
 pX6wizpET4chfA6heiETcxuyufb7g3B0Nv8x18e3NEupCcSKUu8WkDfxBCWgzE/KHysgyQE/7XT
 NBgT8j8M2PpXUxipExfeJ4ifbtnNlB4Jq7bM3VWwdagADzK+RTwTJ9Bd4Ax4cJoHsI/kIi12CN5
 eRidWx4yOlDB00tbpnw==
X-Proofpoint-GUID: KuULCDGDRS_y1lfY0_B4ezHz-IbC7TzT
X-Authority-Analysis: v=2.4 cv=dOwzC+Zb c=1 sm=1 tr=0 ts=6ae0a3f9 cx=c_pps
 a=xAd66yR1laZozgwquCAwlw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=0_J5SqPAhB7wamf-v7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270052
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 20/10/26 15:19, Mark Brown wrote:
> On Thu, Oct 15, 2026 at 12:21:20PM +0530, Aniket Limaye wrote:
> 
>> I am planning to send next version in a few days... aligned with Andy's
>> suggestion for a separate driver. Would like to get your reviews once I do?
>> Let me know if you had something else in mind.
> 
> That sounds great - I'll look out for your patches.

Andy, Mark,

I have sent a v4 as a separate driver [0].

[0]: 
https://lore.kernel.org/all/20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com/

Thanks,
Aniket
