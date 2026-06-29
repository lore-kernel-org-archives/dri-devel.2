Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3663AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821DF10E82B;
	Mon, 29 Jun 2026 11:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Nw5Dng1f";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ppEhFpCr";
	dkim-atps=neutral
X-Greylist: delayed 2148 seconds by postgrey-1.36 at gabe;
 Mon, 29 Jun 2026 11:12:07 UTC
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2799910E82B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:12:07 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65TASqUF1833887;
 Mon, 29 Jun 2026 05:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=u/yv4dGtSHSg79v4Aki70UvTaNHASAGpATHRlYA9p
 Gc=; b=Nw5Dng1fdxfED5hGJ3spkbBPiHzgBYpsgMQmVlZm4vLtapxKF5zP7v83a
 qrAstyJwwO16VpzcRGT4jGBNiRlQLk1t3dtiVBT0RWcXLqne9K6mJlCAja5Vdfkv
 d+iD07yY+ukHBp4EQG+nvQYCjzqbHbjXYW73bMikyy/TTaQFgPrXoqsSLTY2UoCm
 GNhgd5FblrNVcItwoD3OWgIccB7vuOuvbegFjxHrcXDzT2a7uMtTUEgokoaHvDYo
 40HVL/M+bP5jxOfRU+Q2TxABZ5AJmQQRZ2nmwCtxC84CTdhSyeR8zQvCxxjy9K77
 k2girZYQworHv4ZCZ4ZQspiksIaWA==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f3p9ur9f9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 05:33:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuRZa32KVyJ5rBYP71k59ZxA+WsoxSSN0OAr5JeE2gKktVAGAZ8dL/5nXyPJCcj1EKdQS7qawV7PJAKc01387vDsz8eeigpS36EUqn5w1BD1uZQpptiUih28ZSzaLnl04RU4GMB3fPF8aarIVKRnYdinW4ohzkR7Ttwn27eOJLhrmvqwMgg+y1U3fEbnbC5rOmOAUFg5xIMLocEjNHW4T3Brg3yutTGkpnrObmGCi9AP7Rix8IZJYf8KY2jd38sbVNAHiJ0qPvXRfWam5Onvg00S0hyWa8ufwjEqgGdLlPEg62/+WIlkDaSzSsSVTjGPi8Oheg63Q00UUnrHLHHwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/yv4dGtSHSg79v4Aki70UvTaNHASAGpATHRlYA9pGc=;
 b=LVFvm3n82q5cCeItA2Z36q6RghexBueSBkig1wSSKUEq8bFftcVJ/LoLizhY5yUkntyCc3HgHwllbT04UwyJ1fMjJaJuKHQ/fSDtt7lU2s/EvJJ2uom02x9KW8Jgw3vW0lIc7Ch3qalO1wmARaQfkyHNICRT2HT41T+WkzlA1J0nsrmkWC7yludlkH45uVB6JDOtsRbnVvfhARLB1f/r/tFP7Rf1l7C9b2i/lUHAKp4Oqkc/xb/Lr3ya+TuchVSCYvc2qI4yEnpqvnTKukWt10dZ1plmyiOjvGWVN7lMxOM4btk9J9nAxveSw4IY3jofwgqANXMKhU3NGaGsKnhKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/yv4dGtSHSg79v4Aki70UvTaNHASAGpATHRlYA9pGc=;
 b=ppEhFpCrO1U2VqjdXVAShE4CHV8V+gW86Y65nI0DZLzGDO2KBh3Mv4whiYVeL/6JSCg0Tg3Pd5CYg0kLeMU/HGQBko0kdHJyitmiQOKzAOJhRW9GgNU8XmMlVk22nnCkZrcLzxRARJBZfzKgIdxyy8JbjUiI8mJVtMksn85grl8=
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by SJ2PR10MB7060.namprd10.prod.outlook.com (2603:10b6:a03:4d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:33:04 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::2b) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 10:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 10:33:04 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 05:33:02 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 05:33:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 29 Jun 2026 05:33:02 -0500
Received: from [10.24.50.243] (uda0543015.dhcp.ti.com [10.24.50.243])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65TAWvD03874775;
 Mon, 29 Jun 2026 05:32:58 -0500
Message-ID: <1c8dfc23-c03c-4c98-ae52-c66ffea244e6@ti.com>
Date: Mon, 29 Jun 2026 16:02:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: abhash <a-kumar2@ti.com>
Subject: Re: [PATCH v3] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <s-jain1@ti.com>, <y-d@ti.com>,
 <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <mripard@kernel.org>, <tzimmermann@suse.de>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <devarsht@ti.com>,
 <u-kumar1@ti.com>, <sjakhade@cadence.com>
References: <20260601095041.3042950-1-a-kumar2@ti.com>
 <3dbf5a77-c314-4511-ab63-1b1ecd2e16c1@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <3dbf5a77-c314-4511-ab63-1b1ecd2e16c1@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SJ2PR10MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf7a17d-ad5e-4600-4bd5-08ded5c9cd73
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|18002099003|22082099003|13003099007|6133799003|56012099006|4143699003|43062017;
X-Microsoft-Antispam-Message-Info: 4Une3d6QRKVx+Fz09Quiz9+e6MCCRlaTy0WCemRAs5/uEFzkdWNQRVVoS8QbV7/hefYwmroLcY9s0PHAHyP9kVAtkdu4kzQ73UKXEpIKM7XKLBMhQgoB7wIOXPWmDlRQg4eefZUO4aHQhr5M7vjKm7J3saYx24fxc3Zalj+eHhViZ3hKef1x993lq1BHUoMyG50+AjvV+oJQsCLVTsPfkUOeB4hB0zMmrkPFsU9j5Kjd42DUvmsASpSQaG9AgDwfh+MvhCMEKRUW64SQjmpibqwCq9JENoh+cV42Oqt5Iw/wq86vWoLAZ5lQbHf+mAmj0KE7hJXacQnNEEZkL1Vz5mWcyb3NkL8xtsz2Dw5fPJ/HaqiAwg3ek8DH8mowrbHwyqFNLtKibQsxRyMZtW1xzDsnALldz2mYKJq8ZOaD+QSvIE1vvGCbPJQYPWMpKqrOMobtzP3QMJjUbMOlBjDw5YNR8AcwRKNYRnxdfyxMei/nkIHlsWSIo/hZS6cYYsEI72045o7K9hVHg02bOGJY3n/sgQIEmvAYxaGYqtYGjaD0evDQnE5AsBIcCUBGXZgN80oRptEX2YZ/K58v7Q2sTR5gUHu82I7X9JOnlEDde9exDka2UYH5zN3B0CJ1mgHeThv+bhFvsdxiHKITIDxSmM80Rx+R++bJknhwQWcAw4gf8bcpEva7NmPDbXEcAZ0yD14Q7o6g0IABcL77qYb1Qdr1/NuiqjmcoOCmq6dFF9dzFvwjcCP9Wi43701DUoyV
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(13003099007)(6133799003)(56012099006)(4143699003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7x+qsGsH/Ku2GWLACkFglPIBdqDsur2uh/N4adJomDyshsi5afHB9sduEWzhJHD2aqphsQet6ASV/ntSU9AQyAS/klrHJb6i89DXSwXwbANZY9729nI907ksK9eIoHIbhwAnVklx8MaWvS6Wf/7W1Lt5LpGiQDvouh8pusibgNiSn3/0t4k+5dsq6jKwwvv/vScKba/WM+IXEyc2eCv/0XuwBIka1u4gOvn3ew8/0YysHdO8Ww7aYZBLwHsdhgH7r6TabfWOlVPt0s+jDIfR0yfIqFG2GvAYgIus+ZhIb+gDXD1aU5cRWRs5VdDadf45Aj45ZXkbNt2lcT6/pc29HuhPoDUusi0kHfHrDgkNZo2K5meRRbfMZsvqI2lQOPxtf2mFaWkoYywK2fajkc3IoBFaO3p+GWS5WoqQS3ErmgOyaEH8vrNJ1ZEFU2ViuYYD
X-Exchange-RoutingPolicyChecked: n5cPIs/s8Qn54FSCqCr7UT8puXYqe4miphNbmC2kcXc33mPsC/TGvDJmfzJCznu4FzOi2cO48IBYVinoeasxwwfdAwxKnK154l6E/MS8Ioqsfsu2vpIYwwT9on8IPzzWzo78kgR/oT+JkQ3GWE/Pn9y6Z/e4T8hvgQr6W4V0EmmQDE+JyB9IF1DVyrfiJtlxAwok8x8GUHvndH9h61Pqwq3i7eO0+wd4/r3uKlLYcXQgj+9d5hObyh6sFSTQrz5S9Iwei7NsniNOT4GLnD9svfvq3MHGXmC/nlxw9rWvbq2hjncpJWT4992YSuyHaPOFQDgaCJxWsaCu/ZI2iG86DQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:33:04.4058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf7a17d-ad5e-4600-4bd5-08ded5c9cd73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7060
X-Authority-Analysis: v=2.4 cv=L7ktheT8 c=1 sm=1 tr=0 ts=6a4249e3 cx=c_pps
 a=5B7wOmkMoK/13lwMvlsh9w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=uTs37zGd9_EOgT8WlOkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UpCTwEH83rII1m25yZ2HebsMGTBmzKj_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4NCBTYWx0ZWRfX0nW2M+aMa0TI
 9+EGN6DhHlG28XnPlhNevNQ9t+igEuQ3UeHZrADfUdMeFo+OrDhb11PeCcRBpLYzS9vy1USm7Ty
 5HbIe90O9aPZiHtSzrvQJnkVDVwR8mOp6yUVYivE0cBf0qrfZNbCvliQHof0x6MPGSBIlE/dOtS
 TXJtWqsoLo9xQqewOyfLnAPEvabo/G+voWvhODCu5/+v5XuyIBTyCK0iJy82tl5FEKfvkXqGBAA
 B/LEN2qUV+XjT4xKthvQXdbC+6Pd1AV4s/cpp5SZVp2r9u6eJVoU/rzW/21HQYY1hFKumg0Wclc
 VYSC/IeKNkvfQgNaLvVMs6jrQKP1ExlTlUAJU8Srar/xwaRSjrkSYF7cfyaxKULjwHL+ZKJ2wi4
 VqeRWqYkzpz6hV+P6dFdJwU3AcOlbaa7YB/q3DwzSU3cq7IHi9NmKwKqVvrnyQRITGuLRJ/c6W2
 MEHups9fixnbuSCVepg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4NCBTYWx0ZWRfX57DNxhtcLiIB
 +H+VCvMW/7dhmnpJcoTliQYx/38MLhpC1GZQsFCclNhcDYPv3+ng3Z74ug2REI0+WbKFppn8Cku
 FTHhpta6T0vCCIS4ubriTZyhD1Lgav0=
X-Proofpoint-ORIG-GUID: UpCTwEH83rII1m25yZ2HebsMGTBmzKj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290084
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


Hi Tomi,

Thanks for the review.

On 18/06/26 14:19, Tomi Valkeinen wrote:
> Hi,
>
> On 01/06/2026 12:50, Abhash Kumar Jha wrote:
>> Add system suspend and resume hooks to the cdns-mhdp8546 bridge driver.
>>
>> While resuming we either load the firmware or activate it. Firmware
>> is loaded only when resuming from a successful suspend-resume cycle.
>
> It's not clear from the patch if this is a fix or improvement. It 
> sounds a bit like a fix, but it doesn't mention any kind of issue in 
> the driver. So, why is this patch needed?

The driver lacked support for suspend-resume as stated in the todo on 
the driver, So the patch adds this improvement.

>
>> If resuming due to an aborted suspend, loading the firmware is not
>> possible because the uCPU's IMEM is only accessible after a reset and 
>> the
>> bridge has not gone through a reset in this case. Hence, Activate the
>> firmware that is already loaded.
>>
>> Use genpd_notifier to get the power domain status of the bridge and
>> accordingly load the firmware.
>>
>> Additionally, introduce phy_power_off/on to control the power to the 
>> phy.
>
> If you write "also" or "additionally" or such in a commit desc, you 
> should stop and think if that part should actually be a separate 
> patch. Also, why is that change needed? 

The phy device could be powered off while resuming. So we are explicitly 
powering it on.

The phy driver api also recommends to always call phy_init() first 
followed by a phy_power_on().

"Some PHY drivers may not implement `phy_init` or `phy_power_on`, but 
controllers should always call these functions to be compatible with 
other PHYs"

> Overall, this sounds fragile/hacky to me.
>
> The first thing is that usually you shouldn't use system 
> suspend/resume in a bridge driver. When a system suspend happend, the 
> display pipeline will be disabled, so this driver will get an 
> atomic_disable() call, and enable when resuming. You can use runtime 
> PM hooks if you need resume/suspend hooks.
>
Thanks for the suggestion, I will use the runtime PM instead.

> The second thing is the PD notifier. Is there really no way we can see 
> the state from the MDHP IP registers? 

The other way that i found was to read the MHDP KEEP_ALIVE_p register 
twice to know if the firmware is incrementing the counter.

Based on that we can decide if the bridge is active or not. Do you think 
this approach would be okay over the PD notifier?


Thanks,

Abhash

>
>  Tomi
>
>> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
>> ---
>> Hi,
>>
>> Changes in v3:
>> - Register genpd_notifier callback only when genpd is available.
>> - Mark mhdp->powered_off = false after resume is successful.
>> - Use SIMPLE_DEV_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS.
>> - Set mhdp->hw_state appropriately in error paths.
>> - Link to v2: 
>> https://lore.kernel.org/all/20260205085233.81678-1-a-kumar2@ti.com/
>>
>> Changes in v2:
>> - Fixed defined but not used [-Wunused-function] warning for suspend 
>> and resume calls.
>> - Link to v1: 
>> https://lore.kernel.org/all/20260129112016.2448037-1-a-kumar2@ti.com/
>>
>> Thanks and Regards,
>> Abhash
>>
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 138 +++++++++++++++++-
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   4 +
>>   2 files changed, 140 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c 
>> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> index 99888f8d55736..90d8c037a2220 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/phy/phy.h>
>>   #include <linux/phy/phy-dp.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>>   #include <linux/slab.h>
>>   #include <linux/wait.h>
>>   @@ -2287,6 +2288,121 @@ static void cdns_mhdp_hpd_work(struct 
>> work_struct *work)
>>       drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
>>   }
>>   +static int cdns_mhdp_resume(struct device *dev)
>> +{
>> +    struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
>> +    unsigned long rate;
>> +    int ret;
>> +
>> +    ret = clk_prepare_enable(mhdp->clk);
>> +    if (ret)
>> +        return ret;
>> +
>> +    rate = clk_get_rate(mhdp->clk);
>> +    writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
>> +    writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
>> +    writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
>> +
>> +    ret = phy_init(mhdp->phy);
>> +    if (ret) {
>> +        dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
>> +        goto disable_clk;
>> +    }
>> +    ret = phy_power_on(mhdp->phy);
>> +    if (ret < 0) {
>> +        dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
>> +        goto error;
>> +    }
>> +
>> +    if (mhdp->powered_off) {
>> +        ret = cdns_mhdp_load_firmware(mhdp);
>> +        if (ret)
>> +            goto phy_off;
>> +
>> +        ret = wait_event_timeout(mhdp->fw_load_wq,
>> +                    mhdp->hw_state == MHDP_HW_READY,
>> +                    msecs_to_jiffies(1000));
>> +        if (ret == 0) {
>> +            dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
>> +                __func__);
>> +            ret = -ETIMEDOUT;
>> +            goto phy_off;
>> +        }
>> +    } else {
>> +        ret = cdns_mhdp_set_firmware_active(mhdp, true);
>> +        if (ret) {
>> +            dev_err(mhdp->dev, "Failed to activate firmware 
>> (%pe)\n", ERR_PTR(ret));
>> +            goto phy_off;
>> +        }
>> +    }
>> +
>> +    mhdp->powered_off = false;
>> +    return 0;
>> +
>> +phy_off:
>> +    phy_power_off(mhdp->phy);
>> +error:
>> +    phy_exit(mhdp->phy);
>> +disable_clk:
>> +    clk_disable_unprepare(mhdp->clk);
>> +
>> +    return ret;
>> +}
>> +
>> +static int cdns_mhdp_suspend(struct device *dev)
>> +{
>> +    struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
>> +    unsigned long timeout = msecs_to_jiffies(100);
>> +    int ret = 0;
>> +
>> +    cancel_work_sync(&mhdp->hpd_work);
>> +    ret = wait_event_timeout(mhdp->fw_load_wq,
>> +                 mhdp->hw_state == MHDP_HW_READY,
>> +                 timeout);
>> +
>> +    spin_lock(&mhdp->start_lock);
>> +    if (mhdp->hw_state != MHDP_HW_READY) {
>> +        spin_unlock(&mhdp->start_lock);
>> +        dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n", 
>> __func__);
>> +        return -ETIMEDOUT;
>> +    }
>> +    mhdp->hw_state = MHDP_HW_STOPPED;
>> +    spin_unlock(&mhdp->start_lock);
>> +
>> +    ret = cdns_mhdp_set_firmware_active(mhdp, false);
>> +    if (ret) {
>> +        dev_err(mhdp->dev, "Failed to stop firmware (%pe)\n", 
>> ERR_PTR(ret));
>> +        spin_lock(&mhdp->start_lock);
>> +        mhdp->hw_state = MHDP_HW_READY;
>> +        spin_unlock(&mhdp->start_lock);
>> +        goto error;
>> +    }
>> +
>> +    phy_power_off(mhdp->phy);
>> +    phy_exit(mhdp->phy);
>> +    clk_disable_unprepare(mhdp->clk);
>> +
>> +    /* if no power domain available, always reload firmware on 
>> resume */
>> +    if (!mhdp->dev->pm_domain)
>> +        mhdp->powered_off = true;
>> +
>> +error:
>> +    return ret;
>> +}
>> +
>> +static int mhdp_pd_notifier_cb(struct notifier_block *nb,
>> +            unsigned long action, void *data)
>> +{
>> +    struct cdns_mhdp_device *mhdp = container_of(nb, struct 
>> cdns_mhdp_device, pd_nb);
>> +
>> +    if (action == GENPD_NOTIFY_OFF)
>> +        mhdp->powered_off = true;
>> +
>> +    return 0;
>> +}
>> +
>> +static DEFINE_SIMPLE_DEV_PM_OPS(cdns_mhdp_pm_ops, cdns_mhdp_suspend, 
>> cdns_mhdp_resume);
>> +
>>   static int cdns_mhdp_probe(struct platform_device *pdev)
>>   {
>>       struct device *dev = &pdev->dev;
>> @@ -2401,6 +2517,11 @@ static int cdns_mhdp_probe(struct 
>> platform_device *pdev)
>>           dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
>>           goto plat_fini;
>>       }
>> +    ret = phy_power_on(mhdp->phy);
>> +    if (ret < 0) {
>> +        dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
>> +        goto phy_exit;
>> +    }
>>         /* Initialize the work for modeset in case of link train 
>> failure */
>>       INIT_WORK(&mhdp->modeset_retry_work, cdns_mhdp_modeset_retry_fn);
>> @@ -2411,15 +2532,26 @@ static int cdns_mhdp_probe(struct 
>> platform_device *pdev)
>>         ret = cdns_mhdp_load_firmware(mhdp);
>>       if (ret)
>> -        goto phy_exit;
>> +        goto power_off;
>>         if (mhdp->hdcp_supported)
>>           cdns_mhdp_hdcp_init(mhdp);
>>   -    drm_bridge_add(&mhdp->bridge);
>> +    mhdp->powered_off = false;
>> +    if (mhdp->dev->pm_domain) {
>> +        mhdp->pd_nb.notifier_call = mhdp_pd_notifier_cb;
>> +        ret = dev_pm_genpd_add_notifier(mhdp->dev, &mhdp->pd_nb);
>> +        if (ret) {
>> +            dev_err_probe(dev, ret, "failed to add power domain 
>> notifier\n");
>> +            goto power_off;
>> +        }
>> +    }
>>   +    drm_bridge_add(&mhdp->bridge);
>>       return 0;
>>   +power_off:
>> +    phy_power_off(mhdp->phy);
>>   phy_exit:
>>       phy_exit(mhdp->phy);
>>   plat_fini:
>> @@ -2457,6 +2589,7 @@ static void cdns_mhdp_remove(struct 
>> platform_device *pdev)
>>                   ERR_PTR(ret));
>>       }
>>   +    phy_power_off(mhdp->phy);
>>       phy_exit(mhdp->phy);
>>         if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)
>> @@ -2488,6 +2621,7 @@ static struct platform_driver mhdp_driver = {
>>       .driver    = {
>>           .name        = "cdns-mhdp8546",
>>           .of_match_table    = mhdp_ids,
>> +        .pm = pm_sleep_ptr(&cdns_mhdp_pm_ops),
>>       },
>>       .probe    = cdns_mhdp_probe,
>>       .remove = cdns_mhdp_remove,
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h 
>> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>> index 2041ffbc019a5..31dbeaf33ccb6 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>> @@ -413,6 +413,10 @@ struct cdns_mhdp_device {
>>         struct cdns_mhdp_hdcp hdcp;
>>       bool hdcp_supported;
>> +
>> +    /* Power domain status notifier */
>> +    struct notifier_block pd_nb;
>> +    bool powered_off;
>>   };
>>     #define connector_to_mhdp(x) container_of(x, struct 
>> cdns_mhdp_device, connector)
>
