Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80405C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBE610E851;
	Mon, 28 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZPqMyC2H";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WSiERyBc";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3EC10E9EB;
 Fri, 25 Sep 2026 09:59:56 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P6G7MN1848414; Fri, 25 Sep 2026 04:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=q7n5/Y+xHu3Dyle
 0Ne0R0j4l8/qMHV+oSU4qFdTEb4Y=; b=ZPqMyC2Hor4Phh3/QFZTNlQ37HZfQPf
 19HmAG0PQ4Ufbc7LKFgL4RQlZgLMNlrb0Usz/+hDwm7/m3l/WvtgByDc8p51niR3
 A9SCCFGjn1fFBLwY5C6cLW30KEhUAhJFofl6eYoQ/bFkLPtrQDzcxf1PZ0hbry91
 w3i4mUe2h96GcoQn3snL1RdGeocgR5MbuKrIcIYdgUFYzcU3Ytu3xZ1s+TsezmXr
 52oqZn01Q9pIgxEdBah6WzEvs0mRk2XAVZlJk+EnX/jGUCjBF6KsdcIqOJc8EAnV
 BIbb6OOgvgC2VSC7x6LUeZUea4ZeMkOgPYWrK7K2dm7KObyVVRImzGA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gwkhr9088-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 04:59:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daGNMu7iVsaf6PewrQOL1ceGbYSOSSaevcbGiyrdZGJDXiI7+WnHSFvMX69JbIxRfocA3qTRuOb8b+JPFNcTuHb40+PHoL4P0WwjideVsClRpkgKMGZ9zYDlgPMh9aOhzNdTZW8UynQspksA6KyJ14S+jTohBj63XYOXwELDC2vJ3f6noEyGWAltJtXkXhbziMrh5Y2pwoMWuKTALc8TA441U+DK36MJOEbzpWfkewFxyVFlF0JTt7FN4S7jcTCcVuXJEEZpUqeeH/A7ds+XmhLd1J/RK6I/obVvDqkmLEqej3SJYZ80BhxJYKbNimBW15Be1rpTlaw/VY/eLYfwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7n5/Y+xHu3Dyle0Ne0R0j4l8/qMHV+oSU4qFdTEb4Y=;
 b=ne7WTevnICK6SBMEldejgrV2PxPtJsERPMXLk+o6mmnqVW9EQuVKZD5vkQWxJ2Sr/Bjn3+NSZSgffIY+1GCZPsOyCClJo/3HC7VEpfWDV7wbIvpswj3eCK5BseObVgddpspeZec02o/2E8D7tl0NV/3rurULROq8qnIvPkZ7I89udwSIPT8YeAQq5EWwiYkUapRiX8cX00sJ5qV/7xbfUTSY1vq5QFl/VrUMAtlMQVfosE1cHqd2TvlU/0e+uJMCGUe51O/cZ+8PWi3RxUHwaEr/ZvxZZKFt8wg8JwOvTob6Eu7ZLt8QCQ/TOif02j8UPOF4zwR8i8RfVi0VPPlXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7n5/Y+xHu3Dyle0Ne0R0j4l8/qMHV+oSU4qFdTEb4Y=;
 b=WSiERyBc5WybOMbvxjfDDi5VeoXEYxRr0DNPZg6Mr6FI5IfhhAmm7vTfNfBHHLsx/JwgswY9f4gfqfEmxahb1yrxkromI+OdQT9Rk5I3Vg73lktHAGIMdQ3BmGB5dfFEk0iWJiroHmwBAmm3/34z1ll+LYwXjOYmyBPs/flSR1g=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by MW5PR10MB5689.namprd10.prod.outlook.com (2603:10b6:303:19a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:59:37 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::16) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 09:59:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 09:59:37 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 04:59:34 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 04:59:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 04:59:34 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68P9xRh11629888;
 Fri, 25 Sep 2026 04:59:28 -0500
Content-Type: multipart/alternative;
 boundary="------------2AUOaLQOmXxkyOVMUXAco3yO"
Message-ID: <e0f113ea-92cc-4e82-85ae-f61814c230c7@ti.com>
Date: Fri, 25 Sep 2026 15:29:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Nirujogi Pratap
 <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>, Matthew Brost
 <matthew.brost@intel.com>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
 <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
 <Ritwick.Sharma@arm.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <arZB2s3HOBgSRuE4@ashevche-desk.local>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <arZB2s3HOBgSRuE4@ashevche-desk.local>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: e9905245-8545-46de-6a68-08df1aebb580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|23010399003|36860700016|56012099006|3023799007|10067099003|8096899003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: tjdJEG0b9h+pw9jJVWf+le94qrm2DWeBWKuq4VCbyPspuiWBBBJaIkBAoNIY7ifTb6m0jNaPayCQgdqVsdrqYEZg8JLdSl1nzhPckWPnaDAuFflpe+rac8Fz2y51YTCNl2nt+mK1ahjwfbrPvnY9mAosK4QXKn8OBLSF43uYjrBaexBypIMAbG1EuKjeeuwPWvIHvaTiB7yW94oImbdxqxBMKkut/01XFCZhRN1pqG6Hf0jQ66leqkiLPGIlrqYhyn6S9711+Dh/mwxmTsLIhtmdroaGhWHdcMcA5LrbQbqBsgzoklhk29f/FuUwVmUVLiddoHmGIGNN+XqdlOqqqAdleCL2N3ur97UDnTSb4buT7rYWEn5iAcJr+BPZd3X83VhsSRZQPTzoj9PG3Bdr8cSDsX8h+q8MmtOFZ/jKN1G/ZT87ogLluibmPWUnkBKstsjlGoq97ZWyBwL3eIuzR0XRgs/AT8J4aPblQp8z0yN/A6u7FmrfvuE/gCLI+MuR9uQVoBjE2oQO+KswowU1BN4rrC7Nt8vM2E+X8GSaLn90vPsMnJNHCUqyZzdFOHu5/mNS+xIkrpzb2xwv7x8/mntepiUH9pcKBr59xhaqej0HQ7Q2RXWlE9SIE0wrH5QFBAkjSntyI9RekxX7jj0uoyw4HwpwVgwItKuByk57V1nlobdPcSynJRhYbwGfGlrb
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(23010399003)(36860700016)(56012099006)(3023799007)(10067099003)(8096899003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AWpHr81D+OB7K14SkANfTWCp5rhDUtN5l/REP1ttEqCh1iyc1L1r+AlYxiFgtx1O82WnApx6ZylueP4CoUQ+rPRjq8hqvlsZ6YqIQQdKfxFhKh5sSjZOz8dKovXmPJPj/TokHx9OvO1yxmXWvH8gD0sNVONaAoEYASdP1MEkr5LAfIO1SjdaKFGdssnSXxaAaGgkZNXbkKj1gqYF12lV7yoWTie5W6Ca9yQpVVMNv0elZQIvyc5swE0NteAwW0/g0hdPb9bAu0U/17oNV4ZnhokghAzhCzpkMPFDlAxl1Zs7BRfYOePmKnRFrunnYbR+eMYpyg5X+HfuQJr7ecjl8QYk+QiQVEfxzz+qSTaMnxUagfqzGdy48SSsT9DURpqySfwzKTEu7BgDKQqN+M03LDDP1UIW1XJ7u7cF75aICqEYq9UFbb/PD3uwUdhFj4/u
X-Exchange-RoutingPolicyChecked: zc98VKdOw62rpoWTDxnPGJLATXqab7lViTRPFdmoBlkKtmvKmHzl1KPy9Jh9Aj/mNBPE47K1PfrvoVJVBBh8Wut8Y+0KYVhTsQz6GnJsx4KuPcYL8TwzJjoPYc35wFISljJXOOXDiMEcrdAd41p+SwvvAUN1yzMaQOTABMQjr0Uz13QbhWEI9peW6+G2qEhUSp1LelVxAnqniDz10yqGtUNRcQBrMBK6b+mzOiU3YhAst5wwc3eet3exDaGXicF2bhzYFzUfLuBWRXfke+pzI6E5OCWBt7E62mOcQlw5pzTcneVq+WDUfQ4h0RlMcCHzfLfEinuT0al+tL4ge820+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:59:37.3321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9905245-8545-46de-6a68-08df1aebb580
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Authority-Analysis: v=2.4 cv=Fv+QbGrq c=1 sm=1 tr=0 ts=6ab6460e cx=c_pps
 a=alg3xCnYRXnG81SgvFS1VQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=k9paMNw42BVuk8tBsZQA:9 a=QEXdDO2ut3YA:10
 a=2OdB9YBxmakm3wh7e6cA:9 a=XTdIm-p6KCFRSHIR:21 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: cI-41opsYnVi76Z4avl_jEX5l65lkooz
X-Proofpoint-ORIG-GUID: cI-41opsYnVi76Z4avl_jEX5l65lkooz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfXxPb7NRpJ0UXx
 OR62GU9cGNg1uLRB/rowvE4BEPSK55m/5wja+XaljoboNlp9iqnzYr66b3k+i7Men75Fpcl5XO+
 iGuy+lNwDLy/lcwiCOYkdbuZGmlwtkV9ddz01shimS8qDFSniBuOoqmFf1yOhKE8Lp4xRatyOmQ
 ktNzWwOk1Y2mcC/vAUzPLAAuyRsZW8gmbW7CQOQtrUhM/aU1hTf0elYDt6GoBQaZcGkNni6gxYC
 4b6S0P0zdJvsvaCUK4WhV5zcuteipp+8vd0Nw+M4EnFWEV4Cq28a2MWFdmEJYVY9E3S2V+JxhS1
 X4JusTW+KbWdyI33fAAplk/QUeeaivM1bWxxzpRMe8nbpGZqyiOEbwUe6SaKl9pziUNVs7b5xd9
 zKbB60TJ9jD+lV6sxEpPjkdomF/eYyYXbSgXyoLN7UJXU8ixl68vU53Mxwhsabbfyp2Ha2u/IF3
 ot+3adGAgNxn4hiL2nA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfXxq1wmDy8ZUcd
 /59LCuS47/UU1eRQGH5vj4IwYblt7we0t76SyXQYJ7vBIgzwTF2RUp64TJbJXYnWFhFts6QdUTC
 xW7I/RFv1gRLFMVOjO8hVAlLAPhTUnw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250039
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

--------------2AUOaLQOmXxkyOVMUXAco3yO
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 25/09/26 15:11, Andy Shevchenko wrote:
> On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:
>> Add new compatible and update driver to support Synopsys Advanced I2C
>> Controller (DWC_i2c [0]) present on TI TDA54 SoC. This is needed since
>> this controller differs from the existing designware i2c (DW_apb_i2c
>> [1]) in its register offsets and some register definitions.
>>
>> The new compatible updates driver logic due to changes in register
>> definitions:
>>
>> - The new register offsets are handled by first refactoring the driver
>>    to use a map of register IDs to their offsets.
>> - Similarly, also update the driver to use an updated CON-register
>>    bitfield definition.
>> - Interrupts are acknowledged by writing a bitmask to a single CLR_INTR
>>    register instead of reading N dedicated CLR_* registers;
>>    i2c_dw_ack_intr() picks the right method based on dev->flags.
>> - One HCNT/LCNT register pair is shared between standard and fast speed
>>    instead of having one pair each; i2c_dw_write_timings() writes
>>    whichever value set matches the configured speed.
>> - No COMP_PARAM_1 register, so FIFO depth and high-speed-mode support
>>    can't be autodetected: FIFO depth now comes from the required
>>    snps,tx-fifo-depth/snps,rx-fifo-depth DT properties, and the
>>    high-speed capability check is skipped.
>> - No defined CON.RESTART_EN bit; treat it as always set.
>> - TDA54 SoC does not support SMBus, so skip accesses to those registers.
>>
>> [0]: DWC_i2c_reference.pdf
>> [1]: DW_apb_i2c_databook.pdf
> Still doesn't look good. The current register layout may be left as is. What
> you need is translate it in the respective regmap callbacks in case we are
> enumerated on the different IP. Also possible to have a different regmap
> config for the different HW where you translate them only in one place.

Is it confusing to keep using existing offsets in regmap_read/write() 
call sites for TDA54, and let the regmap silently handle the translation?

Given that we do *not* have any new registers in use on the tda54 
version that were not there in the original one, I guess it works... 
will send a v4 as per your suggestion.

Thanks,
Aniket

--------------2AUOaLQOmXxkyOVMUXAco3yO
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 25/09/26 15:11, Andy Shevchenko
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:arZB2s3HOBgSRuE4@ashevche-desk.local">
      <pre wrap="" class="moz-quote-pre">On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Add new compatible and update driver to support Synopsys Advanced I2C
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
  i2c_dw_ack_intr() picks the right method based on dev-&gt;flags.
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
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Still doesn't look good. The current register layout may be left as is. What
you need is translate it in the respective regmap callbacks in case we are
enumerated on the different IP. Also possible to have a different regmap
config for the different HW where you translate them only in one place.
<span style="white-space: pre-wrap">
</span></pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">Is it confusing to keep using existing offsets in regmap_read/write() call sites for TDA54, and let the regmap silently handle the translation?</span></p>
    <p>Given that we do *not* have any new registers in use on the tda54
      version that were not there in the original one, I guess it
      works... will send a v4 as per your suggestion.</p>
    <p>Thanks,<br>
      Aniket</p>
  </body>
</html>

--------------2AUOaLQOmXxkyOVMUXAco3yO--
