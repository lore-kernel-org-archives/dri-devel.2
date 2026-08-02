Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADB9C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00EFD10E478;
	Sun,  2 Aug 2026 22:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J1U1W9Di";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IKw1oM1x";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090F010E110
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 15:45:08 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672EZXrI1521802; Sun, 2 Aug 2026 10:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=dgbSGxBQw388MhxMoV59ylPCDN1l0YwEqNrerbey4
 Js=; b=J1U1W9DicQzqtbwso1fE02+85XJT0LXR85LIQEbQP0GcJAGh3MmuWIK00
 E2PLKyZau849pV/gXblqctFu9t3mJMitSFHgGKsrK0Zz5wSQsuz9AF3cR1VAbBhQ
 A6z/0Zj6bndWTIxCwGxjootLRN9TO/3i05+G4P0AcOUAa3FxZ3l4UU1S77EorPIC
 9X4HqI8/vRyoCCMkticuJVcS7RHeI6xAbyz6O7XvolDR4cl60E0CGl/XbRyFnhjN
 VpLArVmxPbDaBz53NnnGSqLsbISa+9NWRsf/s5QA8U0wnUgE82GPnV/H80vNNovI
 DCsJxPc1Fb7LpFFrPrlr3msvuuZ1Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ft063h8r0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 02 Aug 2026 10:45:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xvr05cuA6RPW5zifrp5iPd3YBWuVEmaOo6Ou86cCdZgkpnl6JdXCzX+aF2LEuTV7ZQnrkgIPM8H/PqeXol/mcBTN2HhFY79VOJLB0EJAB4gOQpqBnR0PFsbmk12x9wbWYTMqkMhiotmnuWJrqduyazOsS5pxaQyCIuOS/FHJTR+mM02BKBK7Rg9A9+LbSBf+b+aaUAgSYg3Le07Vpn9qC3LGwvoHoglVPcg6cJDa1HLJXLU6nDjJs0joosOj510q4EoyC5kE/2D5RyEIp1BnMrVycnEQiOl1rmGZpu3QQFE3pFjumcV/Wnu/3bBLzjnpSthGviIzlnJHW9yjpqy+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgbSGxBQw388MhxMoV59ylPCDN1l0YwEqNrerbey4Js=;
 b=tF23vnvSWzqJR3rEUaDCSuolkD6TYNaK1NAL+CljqFxtb7koO9S62foM70Y/+kq/qv8Mbzhw0SuncZIF2XUuKSFz9f7SqIFrx81d+rmEKhPjgNnWyGc1ycfCyyh0dTfDpfDsk/fHXyX1W0S+ClsNF1nhehMq3WUmpyrct6OCDea97ichJmWvzUTWnLl97uWrAIc4B4XzUBdcfBmeV84Q4XTI29dlCYNPLEFSkUzS7JAk5idXcOaZPU5G9JFf2074/znvwSiEFUo0S+Fpyze4pOa0OUzQj8Z+0gKuPNCjQbsiKQNdtQs/WS6Sw2eO7/CCP6dlYDTlmVGJdFUgZO8SCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgbSGxBQw388MhxMoV59ylPCDN1l0YwEqNrerbey4Js=;
 b=IKw1oM1xot+cFRwIRepMuZrYYZAVyYTuyp9BOaYYbKuBgKYCGqDiMQ2fro+3pAt3ruUXXD0vXzpCJyzHDJjkd2/SVT6zyKs8IITMEhxaQWgEnWr4zcDQ2QLoca6cGbSdnLx9kPL4y9Y6hYg6p2jwa+Vfc+qFH/qnBmajCLh5bZ0=
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by DS4PPFD91C619EF.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 15:45:02 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::e) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Sun, 2
 Aug 2026 15:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sun, 2 Aug 2026 15:45:02 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 10:45:01 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 10:45:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 2 Aug 2026 10:45:01 -0500
Received: from [10.24.53.80] (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 672FixiH212590;
 Sun, 2 Aug 2026 10:45:00 -0500
Message-ID: <d5c4c139-76e1-425b-959e-10c2e959cda9@ti.com>
Date: Sun, 2 Aug 2026 21:14:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Add no-hpd property to the cadence bridge
To: Dominik Haller <d.haller@phytec.de>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
References: <20260728125336.776116-1-y-d@ti.com>
 <074a97451488f0e6d41afe968e9248399dffa88e.camel@phytec.de>
 <ce9bb75b-bba9-49c4-87d9-28b499aa6fb0@ti.com>
 <932da41ee77340b54c7a02d0318698b9e201fafd.camel@phytec.de>
Content-Language: en-US
From: Yashas D <y-d@ti.com>
In-Reply-To: <932da41ee77340b54c7a02d0318698b9e201fafd.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DS4PPFD91C619EF:EE_
X-MS-Office365-Filtering-Correlation-Id: ad988af1-cb3b-427f-8da9-08def0ad0425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|56012099006|4143699003|10067099003|4133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DfBSeHFn/iaAHSTGg7C6jMos20wgcDD3QebNqR+t3VkaT475flk9fIQep4leN96Tzdb9aQwG1vtlWRvtsVkUjhiWBhJLMf+ofQeRjSmCqUGILN1j1lVVoQiu8Ep5cHqpm/isAtUfTGU/cMn6+V5Dx0BJWShePkz85iayfttHZ8PKVfKLXSWC7258w+4JaogXgbghIU5aB/+PrSohQhC//rsgYn6gXsBmMPUKyE8Uys1rt9UIUBJOIes1X1WHY65HwC/yjGPcklArljjdgxFP8yWc85KQw82WVTqKJnUbsnS2H9l0twDlniPQHgRRRBJA2fv3apx7NIE/5yEfPlk/GfdVRQR2n+SgJ0AxBbwZTFwsxU1eaK6TW3PMjZSxhz0MsK7dRp2a4MKdCtnIj6hrxfJgKA+JdSFL3ym5JbiuQamuqfZ9M36Uafhx7aoh5Txv9XA5ScHv37OP+/dEMHSapYL5KdihxfuRLQ8yKSwyppoXSZbiMKZH4MOv9GT4duOmKw0rCKXDqPU5my8UzmadeES2nwAatd28+tljjWrwkEEFzxWlWs5MYbJiWh2CgM57hTNKRE8z0+FNaQPBBqG2ALg6IJrcK1v+U5X5tPMOwXrKdduPZABPsE+5i1hPdgLUvX+N4KY83W2Z0JrbWy8RxA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(56012099006)(4143699003)(10067099003)(4133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6SwE3OA4afDg8MGONXUikzwIUoThiG8iT9qys2aIHGsZYQOUwKgomk2DKF5CRNRS5D8ibRO2B0cfqEAV5tmpKBXX0FdycU6Wo9D0t9JT0XrtJp7nuYrpblFV0lqFk36b7SAD+lkAB8Ce0E7RkD8fcGki5mrfs4YpSI8qVpW5Dn59ikMkbNptXUjUHbQvOa8Y3hqcxwSqrxsfd+jt2BNRw9otpX5nur1H0b5IO8+MvetxNvIaShABeqamdXEEkqMEq1HVc+/eKwOMO0gvWRFcpYvYFqS11MaF8YBitCZI5tCRszqew2oUDl5SzIDtoi2W5HQNvfJpUk71vhKdYb2cRk5Nk8HZIKvThmGtod93sBLvbapWzTwkUsYYyu6FsX0WIvTgQBm6IwnM7Ih8EV/oJKR/5gwqPQ4xDfo/04hhUqh03hSJkNiTV3MFHOTaqsAP
X-Exchange-RoutingPolicyChecked: jcP+qfofgYBQ9aRg5EMBS3y/ot/GSbqPNC+QxSM8S1kc5/3JNL1Wkgb/W1I6yN+R9uHs5eo36+8ry2qKtabgzrWnUXWFaAmfzzOH5Lh/UbSRM6J/mFR3nNRbOLLvdCyxdAgF+FfLKfDr1zY055lhcMW396wMCGTIfQdroVzxFLxDbhPyv108m+lmok7Jbuu3QOqUZ/4Cnqvfapau17B1jHl4m8rdvKT66wFl6SPPlJZ+gaxk+I4ZkRMdZCNUbNZINrI1RIRsTIoILoPlh1EoBcqXw1QdyGdDplvB+TbT1GUo2qno1PDNYHMb2362427zdneEi4moVhkLYQ35dXZn0Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 15:45:02.1441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad988af1-cb3b-427f-8da9-08def0ad0425
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD91C619EF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE0MiBTYWx0ZWRfX38u68vVfPrRr
 qRgHH3QJjAwbhnr2iWO0A+n6s7vdgHRjUvgSd4uX3028GIWoJ6gEZi0c77bHLQLCvLeyESMc3pe
 mviK+uILt1r5ZJMAMSOAPRrbp6hZsRg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE0MiBTYWx0ZWRfX087daeU26unx
 Tqb8dXTvfcK8G0eRqBWHkOeZB7GKiHk7UTY1PMED7iYwdqBMXf7M9sX7kzyjRtrEm23CzZKBVsL
 1vCN1z0vOZTQVmZ5y4H83VWl8hjDjV+oFBK4c5btxdYRL/vHMP0Phiz5guBCQDBgFf9x4zoKOP+
 Hyhbhxv5L30vG9+rC9SUgE1FyMFZTrCIggbUGvpLOw8GEX43lvIlM6c0mXz4oWqwmxvcUXaMZVQ
 Td/dIalajAnhlBoq/hKrQ+Fhos6ZFOVnaZhwIR2gfDJX9eKhVhB7UAfzihT5g/zlQGF2n2rThw+
 vZT0Tg6GppCozZUzAf8Mm2pAoShMVjjBZdY4qxm45h3pFkixpnTv5kAriBSmNLj5iyU5p6+jAcL
 Lim9CUzn6i81KlZJM9YKxcap8psEgAhA3lSNbVQ09zPU8J6UUU3a5hd2sELShYZnj4+VCA8kECM
 XnhgmSwVkeP9FPf6mjQ==
X-Proofpoint-GUID: jS1Ud2oyx_J2xkRvk1x-4p2E6FoyTyA6
X-Proofpoint-ORIG-GUID: jS1Ud2oyx_J2xkRvk1x-4p2E6FoyTyA6
X-Authority-Analysis: v=2.4 cv=VcDH+lp9 c=1 sm=1 tr=0 ts=6a6f6603 cx=c_pps
 a=WxwGY4H08PlrDVivH1wjUg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=uherdBYGAAAA:8
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=sozttTNsAAAA:8 a=MrIBS5R4-85uGimQxe4A:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=z2U-W3hJrleVIN9YIjzO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020142
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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



On 30/07/26 21:28, Dominik Haller wrote:
> On Mi, 2026-07-29 at 13:54 +0530, Yashas D wrote:
>>
>>
>> On 29/07/26 04:07, Dominik Haller wrote:
>>> On Di, 2026-07-28 at 18: 23 +0530, Yashas D wrote: > This series
>>> adds
>>> 'no-hpd' device tree property support to the Cadence > MHDP8546
>>> bridge
>>> driver for boards where the HPD line cannot be used > for > hotplug
>>> detection. > >
>>>
>>>
>>> On Di, 2026-07-28 at 18:23 +0530, Yashas D wrote:
>>>> This series adds 'no-hpd' device tree property support to the
>>>> Cadence
>>>> MHDP8546 bridge driver for boards where the HPD line cannot be
>>>> used
>>>> for
>>>> hotplug detection.
>>>>
>>>> On TI J721S2 EVMs, the HPD signal is routed to SoC pin AA24
>>>> (MCASP1_ACLKX/DP0_HPD). This pin is muxed with the McASP1 audio
>>>> bit
>>>> clock; selecting DP0_HPD breaks audio. There is no alternative
>>>> pin
>>>> carrying the HPD signal which makes it impossible to use HPD
>>>> without loosing the audio capabilities.
>>> Hi Yashas,
>>>
>>> this description is not correct. On the J721S2 EVM the pin AA24
>>> MCASP1_ACLKX is not used for audio.
>>> The pin is just floating unless this "GESI"-board with an
>>> additional
>>> ethernet interface is connect. AA24 is used as as
>>> MCASP1_ACLKX.RGMII1_RD0 in this case.
>>> See arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
>>>
>>> Also the AA24 pin needs to be configured as HPD pin (muxmode 3)
>>> otherwise the mhdp firmware will not turn on the bridge.
>>>
>>> Dominik
>>>
>>>
>>
>> Hi Dominik,
>>
>> You are correct, I apologise for the error. The SoC PAD mux conflict
>> on AA24 is with RGMII1_RD0 (GESI ethernet expansion board), not
>> MCASP1
>> audio. I will fix the commit message.
>>
>> The full picture on J721S2X-PM1-SOM rev E2:
>>
>> - The HPD resistor is DNI from factory, so AA24 is not physically
>>     connected to the DP connector HPD line by default. However AA24
>> must
>>     still be configured in DP0_HPD mux mode (mode 3) for the MHDP
>> firmware
>>     to operate at all — configuring it in any other mode prevents the
>> bridge from loading.
>>
>> - When we physically connected HPD by populating the resistor, the E2
>>     board failed to boot with a monitor attached. The HPD line leaks
>> voltage
>>     from the monitor into the SoC while powered off, causing a PMIC
>> error.
>>     This was fixed in rev E3+ with an HPD buffer. Our boards are rev
>> E2.
>>
>> The audio conflict in earlier message versions was our mistake. It
>> came from investigating whether an alternative routing path through a
>> board-level signal MUX chip (MUX1/MUX2) on the SOM could expose a
>> GPIO
>> for HPD — changing that MUX's port selection would have affected
>> audio.
>> That is unrelated to the SoC PAD mux and should not have been
>> mentioned.
>>
>> I will fix the message and send a new version.
> Hi Yashas,
> 
> please also update the commit description of the actual patch 2/2 as it
> implies at the moment that you can use the AA24 pin for other functions
> while using the display port.
> 
> Thanks
> 
> Dominik
>>
>> Thanks,
>> Yashas D
>>

Hi Dominik,
Have updated it in v6.

Thanks,
Yashas D
>>>> When 'no-hpd' is set, DRM_BRIDGE_OP_HPD is omitted so the
>>>> framework
>>>> falls back to polling .detect() every ~10 seconds. Monitor
>>>> presence
>>>> is
>>>> determined via AUX DPCD reads instead of firmware HPD status
>>>> registers.
>>>> The .detect() callback drives cdns_mhdp_update_link_status() on
>>>> each
>>>> poll to keep mhdp->plugged current. At attach time, the driver
>>>> waits
>>>> for firmware to be ready before performing the initial AUX poll
>>>> since
>>>> no interrupt will trigger it.
>>>>
>>>> Changes since v4:
>>>> - Corrected the dt-binding Subject
>>>>
>>>> Link to v4:
>>>> https://urldefense.com/v3/__https://lore.kernel.org/
>>>>
>>> all/20260630102610.1849902-1-y-d@ti.com/__;!!G3vK!
>>> XKetSJhTJzSznMTBeoww63bvXSPD3xrWstRrf4H6AhnrM5IjIvNFa9uHVVWEYPEoe0G
>>> NrZXGb8IF$
>>> <https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>>> urldefense.com%2Fv3%2F__https%3A%2F%2Flore.kernel.org%2Fall%2F20260
>>> 630102610.1849902-1-y-
>>> d%40ti.com%2F__%3B!!G3vK!XKetSJhTJzSznMTBeoww63bvXSPD3xrWstRrf4H6Ah
>>> nrM5IjIvNFa9uHVVWEYPEoe0GNrZXGb8IF%24&data=05%7C02%7Cd.haller%40phy
>>> tec.de%7Ce1e53182268a4df81d1908deed4ada4b%7Ce609157c80e2446d9be39c9
>>> 9c2399d29%7C0%7C0%7C639209102909756678%7CUnknown%7CTWFpbGZsb3d8eyJF
>>> bXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF
>>> pbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=2TH3dx%2FirnEKUcHFu9vOz%2F
>>> ZT9JSyfcyMp%2BDjQPDUC%2F0%3D&reserved=0>
>>>>
>>>> Rahul T R (2):
>>>>    dt-bindings: display: bridge: cdns,mhdp8546: Add no-hpd
>>>> property to
>>>>      the cadence bridge
>>>>    drm: bridge: cdns-mhdp8546: Add no-hpd property
>>>>
>>>>   .../display/bridge/cdns,mhdp8546.yaml         | 17 ++++++
>>>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 58
>>>> ++++++++++++++++-
>>>> --
>>>>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
>>>>   3 files changed, 69 insertions(+), 7 deletions(-)
>>>>
>>>
>>
> 

