Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AB6C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6AE10F67E;
	Fri,  3 Jul 2026 07:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZGpSIUzi";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PkCaXc8f";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8E310F651
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:25:16 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635tlHi292838; Fri, 3 Jul 2026 01:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=J4L6JHvYCSiubCAWVj62c7+C1+W/vF0FZaQTPMpuc
 xc=; b=ZGpSIUziQ6GrtVG8NaQNGLV5ZjcPSDFKfIv/ElcIXnPGJ2nAiuBCrrZzz
 3QkmDWQ5M2CL+DknNKePUpeE5gY2wZ0fIFShUXPUK57sFC7rhoh9TxNCo+Q8N0PE
 mv6KskNa+4ro18jtc+uqR8fDODdDOvb35n+ll9ZYP1hRMu4Z/sN2NEqeIrNLo7VR
 gFVErb/Q4+fbfBJi3/ZVMwcVBBpG9dyngbWQrJmTxYr05Dg9nlzodc+/jrqXjw9U
 g/eowo0lQ0G28Y70xS8XjDyn3I3w+UNeJaesiG95AG+am8U/h7LdRpkD5xgQaMcy
 PoDo4SHy0A0mqUfIoOZ5I24HCFs4w==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f63a71gp1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 01:24:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFFiGD55r7YWwCCn0rwsmJrXy5CfErENAXGcJDlblDsQ9DwSkJHCvOsPbR0p017nkce1W8TsDDLKTvzsr1tlz5pt6+IPVk6sBiN1HPAi7EW70dgjGR2cisVhu6/1vQafgoDaSc8Mxe/2iBCb9BSPYJcX2W6HAJqofCLC+GgYvYOrAVFc6dG/1qP/AcrB8OCM3pkAP07V6gBH8CxDw4X6Zv4yvwWuukXTkhTj2dSDbCmCLj9/Dkc8YobIHXeDOkPX4NKtBbwWs8Vv/9Nskro782tdqmCwOgKKz8Rht4QQMZ/cqpboxixo4mRfDGGYk6ePeopZ1fn7NkdcaOiz+HKO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4L6JHvYCSiubCAWVj62c7+C1+W/vF0FZaQTPMpucxc=;
 b=FrTMwgicrhcT1O+9WeuQyged2YgNyV0JfD6qt8AZR7RXTlIy+Ign3VytEqVe2K7Npgx8FlnkGhdOldo3kWrhuOK1h6feROo2gvedcRM55Itp2CtQ5/xd64v2uYSYchuB9zbGKFUdhjDSSDnXefLc8loRmruM9cswPhrmtFLR/gwTQo2DcnnL15CCbsSmQXWoGBS1SXe9nmY0440xp+PXl3DNOljBEYJzgbl6BsSj/3Vyg9i91ikRX6ORHzq+AGTAcgtjaEebmvCDMrf0dsMFbt2T00EExAAD7UX7NbIWZrEQ7w3NgqxGwYa4YXdXiaY8v/w77wNapwj+/4swiJgIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4L6JHvYCSiubCAWVj62c7+C1+W/vF0FZaQTPMpucxc=;
 b=PkCaXc8fbjoOTVvznqMtIvr1dSrR62jAm13/vaq1NLe07G4V9hxVMpebZnpYCrOLtOPVMvlPGKV0K2xap/31PdBijNyRrZxRsAi5BQ/+y9m3wdYabKB23B3Mjp+pE8BOqy6e0xM6hmxwQNsAk0o3QZLt9B+9JlV3+NwVGthTxhE=
Received: from BL1PR13CA0171.namprd13.prod.outlook.com (2603:10b6:208:2bd::26)
 by DS0PR10MB8031.namprd10.prod.outlook.com (2603:10b6:8:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:24:27 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::11) by BL1PR13CA0171.outlook.office365.com
 (2603:10b6:208:2bd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 06:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Fri, 3 Jul 2026 06:24:26 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 01:23:52 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 01:23:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 3 Jul 2026 01:23:52 -0500
Received: from [10.24.53.80] (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6636NhCj1368320;
 Fri, 3 Jul 2026 01:23:44 -0500
Message-ID: <4851c6a5-f056-4a73-969c-51985ced637e@ti.com>
Date: Fri, 3 Jul 2026 11:53:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: display/bridge: cdns-mhdp8546: Add
 no-hpd property to the cadence bridge
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <tomi.valkeinen@ideasonboard.com>, <dmitry.baryshkov@oss.qualcomm.com>,
 <kees@kernel.org>, <xiqi2@huawei.com>, <r-ravikumar@ti.com>,
 <sjakhade@cadence.com>, <yamonkar@cadence.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <devarsht@ti.com>,
 <s-jain1@ti.com>, <d-mittal@ti.com>, <b-padhi@ti.com>
References: <20260630102610.1849902-1-y-d@ti.com>
 <20260630102610.1849902-2-y-d@ti.com>
 <20260701-red-nautilus-of-masquerade-8fea13@quoll>
Content-Language: en-US
From: Yashas D <y-d@ti.com>
In-Reply-To: <20260701-red-nautilus-of-masquerade-8fea13@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS0PR10MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 42072d50-0e33-442b-988c-08ded8cbbb3b
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|23010399003|1800799024|376014|13003099007|18002099003|56012099006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: s5pYVIKosldhjkvPh9JVjHBszd4NQ/dpDPla8cs6lmQtjgtHwOWIzhG+bnEkWnmdhi9GH2mAMRi1Md6EwEecquQ+Dx0sWnf5Do8V2InOndWLzU2pZTqstebGsP/UK7Yh3KE51OJGUEA+UNFexdi+ExPmZyu3sHow8o7jKt+ogFKXSY8WFihzhH/Heil3reTknXvezKp2RUiAtUBZdAIYi0X9cl0NNJoK80kbdGUTIQHxCm5I7EI+uHbunK3djSe92/F2b5BDRowsDqenptuXD+NFOPUzZm5RAg0MQ8+LSuhXg3OxFynM7i6Hfiassj2y5sEJfjDwPsKWVBhYRIe4R9gR5jLyIcCqM2tkli+8a82/gwxRZ6GrGQbjVHMICbCJQU40D/P6utfzQgHGYI5Z9pKXy+5ci95F1tth6AZZSab4BEOQ1FhKEec5R1qb7k/ZDtQOyCIIV3LA1Jh1ab504CBcMwXw0y9junXmvcmuARk9ka48+20XMFv/1nMITYYuYRBo8IkyeprmWxTuwuyETV/JGgm/b7QlsJHC/Est812e6XWyHQ36T/bS3GzuzS+luKXgnN1H68hPAq4Tg+HkO9O8cOEC0e6VH6rlWDjCmmsKDdhIp2yEOhb0Tsn+Yo1DdGD+VnmdK2otXsU6whRkm5ydt+QszLeKdnqk8XrHvkV/cQIZgXNU7OpS0v5HG1zXedae/HBvHk9u/LTdg5md2A==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(1800799024)(376014)(13003099007)(18002099003)(56012099006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XQGwipVxlabHaGVSbDMpPD+XtdtGoL6LOwag6z7JOKVSyj/eX6zfYA9Cv/00wQawbg+4IzWgTs/AGgwytIaeQtVt6LoqMaz8dQ1mzjw+JOJRq1N6KF0+aunvUGKXliX/winOyR6CgZrjDQMlk3zOMy5pght/9SidPk98uBPHEgqwoJgI6XHZsYXWH7UCprKZCn/GuhFD/YF19U8A3XnX1c0EtmOG6pe3oAEOPUL6OdKeU+AgCW6FGPez/TC+MUebYEFZ+rvWCZoVYKLZAWwAJaqy9jb2gzNcw21uVQCqr6bZc3rFJr5cu0tjKFXLuRy9TLVxwqxhz5vqDXB3q6YJeEytarPObd3fxVr+lsKWC2iAPteeHQOohFKuWDuhQDPlj+hNYAj+h7DNwI2Ur8OF2QcY1eG8VQeXyDGxNc0UHy9A6nEhFmUsTU6BdL5s5vfP
X-Exchange-RoutingPolicyChecked: mMEnCsWyWnynbo5Z+8XPOrgPcM13ffh1dxxoUH5tqB45TVwRhsNmMn7EQlYWdaV83YyX2wO+ykZaSOPYry5xtxHqcgf4botkJx9N4fbOXOLVWjP0RtP5bXJIq7qN+aoIeN5cXGrTfs2WEZRXaQPsorePMhYO9JNaHMQSIBywR9oD/tZ44wkarG21V6ITOnbkp6k4PjWe43dwcYf7KqTZhSf+q7xou/hO0IL4Hb2CahRIDzpLJV7iFVl6TK/9Pew/8QjHPCa0Dw23TlgGP5kVjMvHSe+Z9bJYMf76SjdRJvW101rywzyUMrKC1TkY5VkPhPVH72J8BkGocANQR9voQQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:24:26.3118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42072d50-0e33-442b-988c-08ded8cbbb3b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8031
X-Authority-Analysis: v=2.4 cv=BMGDalQG c=1 sm=1 tr=0 ts=6a4755a2 cx=c_pps
 a=cgmL7KMsZDthlzKGM6UXqw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=5Ea2T7kVNC1aPIGrf7cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ndv3VA9SsfS5m3Yud1QBxC6UKUK6Dz9P
X-Proofpoint-ORIG-GUID: ndv3VA9SsfS5m3Yud1QBxC6UKUK6Dz9P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX9mSYnPkCqcEZ
 Y2BS8dnOz5hdm0DAcss2vtpy1oNh2y3gNaJBNINUDCGHrgtGXnC/onqbPNdruoUpDpskZskXtZx
 JtO20lWDgevZdBu/S2u1XEkePT/+nFI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfXzMEAcnqn1sHF
 Z0AE5t/6nZC7ucK++NqwbpGl1Gl83idQptZE7CAsGvm9QQyWX5CJqaFurxZMVsh0qcwt3emw0k9
 bqC4vEOhsF5R4dCRyxedlUznuoI+4FK4fRBAuPfqq4PJ68/B2eoyf/wexaWW6Ik432ysKCvXw09
 Xu7trv8Hgy9BapEcfjByfDh8liWUhqDEgPAOAeuD2/30aonNm+lv1Gq3twvueTQfvvxy0x5N04g
 TLJl3vvvvYqrLJRQ51/LNQts2dJ5JJoUyRrR2hbNi3I2JoQfgjYDrTymC+JQKAZ1vn8mOwV52JT
 S9zdQq/HDFAI7+uIXoZz+iije4jboiemWijGCx/evThwKNeI0Toh2E92OmrlYEQlySzjic3dLNU
 Wpc9Laacve/3GC1047cWcNh2k/hv2zImzgB1jaIH6EUL25k5zxYGuaLvxynm8ao3iVRFa13JIPB
 loWgamRdLi/0p4cgBrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030058
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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



On 01/07/26 12:23, Krzysztof Kozlowski wrote:
> On Tue, Jun 30, 2026 at 03:56:09PM +0530, Yashas D wrote:
>> From: Rahul T R <r-ravikumar@ti.com>
>>
>> The mhdp bridge can work without its HPD pin hooked up to the connector,
>> but the current bridge driver throws an error when hpd line is not
>> connected to the connector. For such cases, we need an indication for
>> no-hpd, using which we can bypass the hpd detection and instead use the
>> auxiliary channels connected to the DP connector to confirm the
>> connection.
>> So add no-hpd property to the bindings, to disable hpd when not
>> connected or cannot be used for hotplug detection.
> 
> Subject prefixes: There is no such file cdns-mhdp8546. I already pointed
> this out at v2. This is a nit, but I do not understand why the same
> feedback has to be repeated third time (v3 also ignored it).
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
Hi Krzysztof,
Will correct it in the next version.
Please let me know if anything else has to be changed.

Regards,
Yashas D

> Best regards,
> Krzysztof
> 

