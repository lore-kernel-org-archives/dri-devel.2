Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E24CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F9B10E0BE;
	Tue,  6 Oct 2026 09:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yx5+jvOq";
	dkim=pass (1024-bit key; unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="kCtgNH1f";
	dkim-atps=neutral
X-Greylist: delayed 610 seconds by postgrey-1.36 at gabe;
 Tue, 06 Oct 2026 09:00:32 UTC
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E975F10E0BE
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:00:32 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69685qcv2222995; Tue, 6 Oct 2026 03:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=40r6pv02Z6VgWo6IPTJKaSMJvSBMoh8+WGsq6gGH7
 Vw=; b=Yx5+jvOqV3E+acbjr9mjqdKNPFJiYBoH34AjVX8pydoo6r+ch3nsyJptg
 1e7StEw0Q5HTR5WetaRNk1RhbTr+2qZy7fGhEag2MtiF0yYu4Gc9GKqdIypIMAOC
 i/aaXejiVrXAATY19IlyE0/6ueLhCykefjLaoowB//XoFmOuCpUm/WQadMgUSF5c
 xCIVXgL2/7JyuwoK8U2XZkuAhy0LjkRMMAPRHJxKgDrrpF7xxgxR7Jx3uvzb6XNV
 ZS4O3xfLDhzVuya8J7XBM3BIhE+y75K0KRtGWy9eVw7pXaDuU8LLCLOuCUHYjyIU
 8z/odxupVl86p0ga1wdYCOJ1xGjDA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h4w6786v4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 03:50:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMpHWUHLKxRMfS3OvJv6QS8/qHWTGUhdlPQTyLWWlzOwiv5MCd4MMNUmyNqb0Jkl9wChhjGsrBpEWc9JDUKkLCTmoFB9VkwupixBlqBJdG48+iADkzafa2ro+c+HmkVfYu/8XFJsckcipMIEksx6DiILmKJ6Fq3gtBldw4Hgu2dnwRFTTown+ngfeUPtnR036YhY6BLBd/JAlDfqcE5ZUNgNZOtzn9bUOuWmbNDVrbL/C0pT5i/Oto7eJ1eOwi9kpdX+BuXvUDNGwGK9qmMtljxZ1WhAnyLtHTDlBqT+cYTOiE5dm7g5AXkVgdPJbCtIcm9VV55pbGaEW1mmTi/ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40r6pv02Z6VgWo6IPTJKaSMJvSBMoh8+WGsq6gGH7Vw=;
 b=IyIF3B/KjkGZ9b463F2hQSRu7s+tlEg00/WoMCYOFEC7pMRg57nohYiDfn593Qn7w9JYtYVtgHmomP70ia7LncqXREwqlcaZRuK4ipq4zV6iVpYrGRmyXppGHP9NKpFWJEpB5Y9HuR1wYhM9TFZgY1oS2fX4ccIRP6dYgBseQP5epG2WLnsSnPHDRSZLY0TlHsEEtu14HK+OBHtNXMefrCQEguZx8dwPZatWdYcTaCB/rSVxy/Ao46FS7I/bU7dQcXSr2o5yo2lEHjqO9t4hoRf42fZhQKDAn1fDbhfyvV3xtiha5TcG3AkEpU529P2coUEzcwJr44t2MLfb1wwOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40r6pv02Z6VgWo6IPTJKaSMJvSBMoh8+WGsq6gGH7Vw=;
 b=kCtgNH1fw3MO1SWoGCVGlrkq7gwTBPli7qC8a8+xWjLIPwrqSlV0P0XmoqywLgRO8NoZUmEkaMETc/AeMah501j4eTQOazLJTjKOBdrebz1Pzq8T2OD7EWvf5n1pyzsP/9N9xEmBEC4vUG7Ci6rRmzRPxld08PxcOd4ZhGG6eiE=
Received: from CY5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ed::10)
 by PH0PR10MB4406.namprd10.prod.outlook.com (2603:10b6:510:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 08:50:02 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:930:ed:cafe::5e) by CY5P220CA0003.outlook.office365.com
 (2603:10b6:930:ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 08:50:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 08:50:00 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 6 Oct
 2026 03:49:26 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 6 Oct
 2026 03:49:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 6 Oct 2026 03:49:26 -0500
Received: from [172.24.19.94] (ltpw0ewr2k.dhcp.ti.com [172.24.19.94])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6968nKNf1927510;
 Tue, 6 Oct 2026 03:49:21 -0500
Message-ID: <f1089720-2a8e-4f0f-b995-fc7ef0836da0@ti.com>
Date: Tue, 6 Oct 2026 14:19:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <1c8dfc23-c03c-4c98-ae52-c66ffea244e6@ti.com>
 <982ffabf-4709-427a-b2b6-481eb074f2d0@ideasonboard.com>
Content-Language: en-US
From: "Kumar, Abhash" <a-kumar2@ti.com>
In-Reply-To: <982ffabf-4709-427a-b2b6-481eb074f2d0@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|PH0PR10MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fbe623-d687-4639-24cf-08df2386ce9e
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|23010399003|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5Wha6Tx/62YyBl0RAsG+DTJCvc853ECHxzz5X/wEBturHk7HItX6QUHrieHl1v2dZfoOzNACSprJ/ZqPfVX/+IyHnMhaRxPldd/KwNhbwYmMoXMhajKwFbtZFTf2oGRxAr64sCCIpruTWUmsCAiT9mX0moiCm1qu4FRMavBxNWsJ8Ui8bLJ07TbXmD21m/037SIIV1MMIwoBX+3ainTWDV4HNrOyUmdWrUqvDAgYWY9U3AghkfTtWIHjD+utOHpBLpnyaTPthp8SliBn3CmKaxZd54q/ePmkPbCIERfdZPD4pAAm4k6MHRJv1zm9Wa13n8T1JuxhcRWz8frzVJSvLGPPTl/PP66FSK7WnxA4tb5U/IA1R1iiifWJ5TRK/LjL1bnFKoqAJtfYKgGQNTWMK1TINwGfJ/3xP+5xzwmdAHT+38imNYiLN/nyFbtMSbli7SiWvhQn/bBiG6nlxqM9gG0TC/p1YaUd0xY/kYewuerElJgvwR6gyeQYf9uTha84078Ap1B36bKSm36uGK5lJYomj41GwH3uXYx++XA1VbohuSOt/mU4T7p0zyWBlFOeqI6aXpx4YCoyaEHTvRxp7Qm7rD9yWp6ZJ9xn9WluV8h7GxOUHjHw55HJADG8M0VdhiCv99vpcr7hIaUhDJ7HiQALtjwlzmGZB5VUvoCzhUOTXGAEHKIYlZ0maS6XlTl8gBpLOio/NAFApeiTGWJziA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(23010399003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EVd2PFRq7LdkapldAu4CP9PzdTfbj796fKKSIGtP90idQtCeV2hqSLFNCXua1YnpWHvr5bjM9fk5ajzBt+pZ1PTAIyvuCSIQ7LtzMiDrBx5l4KLVzimWDRnQXKNGyPfX55rBlnMaV8G1z+qDopIDfhAHufFF/gMTjtZAb9Vbx4fQc8CiBDPUsZM5I71mPzPYTX9k7H8d/5W8QZwjLxeddkiL3oTR6ldeAbapTMku9VZYX8mPhaMylX64qLYxVXcpjcsvlUzw9Tfw6SjEQyZH2eHjlWJRxo3FNFxDgzwd2f2iTctl68YRdu3Gv8UcypkeDLr0qbXWqJ87Zgm03obbXz0RO8MCYtGpUREAH9qijkV2g4erxYhyZeaer9X8uYo3kwFRRelzIF5TxSMYp33Hn66tGrBvutByY+L/iX8N1INwU5g22nNAsVe5Ii7zIldP
X-Exchange-RoutingPolicyChecked: SLnbexNkMkmMenqfZ4vT2WsyXyU0QhbfeSL7GGG2j5lDtHNh+WXRjnvwFc5K2NkoNLK9OnJmQz9Sg0flhXzoLrLUFj47kpFhFJWM9wAIDPR7Qyhf2OwqcoO8UgYyz30gffTXqVGmj8I2+kN2S/7tgNRM4xxpCiVK1mckCJTtYqpIxhW9NZYy7RxSLse7CaCXVLynT86oVhuYguW8qshRR6+w1Lmf4NkyASvrcXm72T3QRSi5C5VdCBGXXd0+dWB+Hopw24E81IsUeHAalOVYclU/zSoc1LFWxdH41jKsqZoAUR7p/FMbNqL5kvqPt14oQ8nZc+k8r9vz/BRHVPCzcw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:50:00.8222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fbe623-d687-4639-24cf-08df2386ce9e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4406
X-Proofpoint-ORIG-GUID: xP7iC-udUbb0beCl9q4_ZS4mkNHg66hi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNCBTYWx0ZWRfX6tLDSRX1cIjF
 GeKdg0zDIC1juspmIL5iq8a30nDweRHP1ymRJnSPoHsrKGXUs1Tjg9NEiqcNFqNYFxJ12GCtAN8
 Hx6xWvX7d3zNRmvucM05gUc4P1iQxZSLkbDbNAYislDwvLwlS/RajYWGmJKrGQmLhmhK600ZRa6
 TdwnmDysD+atGFqce2MmvK00n7KjUgerZvPsOJ0nx0vUNkUw9ePmg1wt5dtJUzcO6piPmRkMzAV
 ojVkFy18lFOTx5jqs3uERbvN+P0MPNnWlzVhph8V5nc/GgxqWajgJLHD8K1296te46ZF4eNEC+E
 epm/u9Fmv6BiHY4sDBoPfqhEgZpjYyYWS5PGNY1Ye5nfPtqT6PD0lGD/+IUoC6hW50iAJQjgZqy
 GZWugLKae2H2O1i3WGDy/NTI08fI3kuqnku3hEulXUfCKwfK8cctjV3vD0OLRY2mHOs+EhlOuEe
 6ltkm/kFp8IpyYoTkWg==
X-Authority-Analysis: v=2.4 cv=GP6dgeNK c=1 sm=1 tr=0 ts=6ac4b63d cx=c_pps
 a=xx7W88v/Jz1hHwbI4fXbew==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=96uSKnNO3C851FKM0vEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xP7iC-udUbb0beCl9q4_ZS4mkNHg66hi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNCBTYWx0ZWRfXz8a4ecpHBoyl
 DpD2uoeWVMYGX9CQkWYSYxxwX7vRe5O7V01UPrk/DWub22p7IFfqudFX6HOIqSrqDeh6D7KvovU
 4oGhr90Bvi+/gi8LTRnu/YoO0AbeEkQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060034
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

Hi,

On 10/1/2026 1:10 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 29/06/2026 13:32, abhash wrote:
>>
>> Hi Tomi,
>>
>> Thanks for the review.
>>
>> On 18/06/26 14:19, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 01/06/2026 12:50, Abhash Kumar Jha wrote:
>>>> Add system suspend and resume hooks to the cdns-mhdp8546 bridge 
>>>> driver.
>>>>
>>>> While resuming we either load the firmware or activate it. Firmware
>>>> is loaded only when resuming from a successful suspend-resume cycle.
>>>
>>> It's not clear from the patch if this is a fix or improvement. It 
>>> sounds a bit like a fix, but it doesn't mention any kind of issue in 
>>> the driver. So, why is this patch needed?
>>
>> The driver lacked support for suspend-resume as stated in the todo on 
>> the driver, So the patch adds this improvement.
>
> The patch doesn't remove any todo lines. Was that just a miss, or is 
> there more to add wrt. PM?
Yeah, i will remove the TODO in the next revision.
>
> What does it mean it didn't support PM? Does the driver not work after 
> suspend-resume cycle? Or does the driver prevent a proper suspend? 

When we resume, the cdns_mhdp_link_up function fails.

Failure log at resume:

[  55.329452] tidss 4a00000.dss: PM: calling tidss_resume [tidss] @ 
1053, parent: bus@100000

[ 183.381228] cdns-mhdp8546 a000000.bridge: Failed to read receiver 
capabilities

[ 191.391548] cdns-mhdp8546 a000000.bridge: get block[0] edid failed: -110

[ 193.392713] cdns-mhdp8546 a000000.bridge: Failed to read register

[ 261.415544] cdns-mhdp8546 a000000.bridge: Failed to read register

[ 263.946153] tidss 4a00000.dss: Timeout waiting for framedone on crtc 0

[ 391.991358] cdns-mhdp8546 a000000.bridge: Failed to read receiver 
capabilities

[ 392.026847] tidss 4a00000.dss: PM: tidss_resume [tidss] returned 0 
after 336689133 usecs

I guess it is fair to say that the driver does not work after 
suspend-resume cycle.

>>>> If resuming due to an aborted suspend, loading the firmware is not
>>>> possible because the uCPU's IMEM is only accessible after a reset 
>>>> and the
>>>> bridge has not gone through a reset in this case. Hence, Activate the
>>>> firmware that is already loaded.
>>>>
>>>> Use genpd_notifier to get the power domain status of the bridge and
>>>> accordingly load the firmware.
>>>>
>>>> Additionally, introduce phy_power_off/on to control the power to 
>>>> the phy.
>>>
>>> If you write "also" or "additionally" or such in a commit desc, you 
>>> should stop and think if that part should actually be a separate 
>>> patch. Also, why is that change needed? 
>>
>> The phy device could be powered off while resuming. So we are 
>> explicitly powering it on.
>>
>> The phy driver api also recommends to always call phy_init() first 
>> followed by a phy_power_on().
>>
>> "Some PHY drivers may not implement `phy_init` or `phy_power_on`, but 
>> controllers should always call these functions to be compatible with 
>> other PHYs"
>
> It still sounds like a separate patch to me: the current driver is 
> missing phy_power_on/off from the probe/remove functions.
>
I will add that as a separate patch
>>> Overall, this sounds fragile/hacky to me.
>>>
>>> The first thing is that usually you shouldn't use system suspend/ 
>>> resume in a bridge driver. When a system suspend happend, the 
>>> display pipeline will be disabled, so this driver will get an 
>>> atomic_disable() call, and enable when resuming. You can use runtime 
>>> PM hooks if you need resume/suspend hooks.
>>>
>> Thanks for the suggestion, I will use the runtime PM instead.
>>
>>> The second thing is the PD notifier. Is there really no way we can 
>>> see the state from the MDHP IP registers? 
>>
>> The other way that i found was to read the MHDP KEEP_ALIVE_p register 
>> twice to know if the firmware is incrementing the counter.
>>
>> Based on that we can decide if the bridge is active or not. Do you 
>> think this approach would be okay over the PD notifier?
> I think it would be best to be able somehow to ask this from the HW to 
> find the true state, instead of guessing it second hand from the PD 
> notifier (which also doesn't tell us the initial HW state at probe).
>
> KEEP_ALIVE_p sounds fine. Or what does the mdhp IP do if you send a 
> message to the firmware when it's not up? Say, if you always do 
> cdns_mhdp_set_firmware_active, what happens if the FW has not been 
> loaded? I would guess that there's a timeout, and that could be used 
> to find out the FW is not up.
>
Yes, there is a 2 second timeout if we send a message and the firmware 
is not up. I would prefer the KEEP_ALIVE_p method, as that is a better 
indication of the

firmware being active.

> Also, if the IMEM is not accessible and you load the FW, what happens?

If IMEM is not accessible and we load the FW, the kernel crashes due to 
S-error.


Thanks,

Abhash

