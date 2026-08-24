Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A179C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E08E10E558;
	Mon, 24 Aug 2026 15:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hopO231H";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n+y5783L";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C140010E140
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:39:53 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67OCsrgF2511940;
 Mon, 24 Aug 2026 10:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ZeqAOJeoGWuHVC/M+aPUOO7f+IpoZWbOAq15RcmlP
 Vs=; b=hopO231HmpaOVIGbL6sfmdrsWjm2MaWLiZtbUki9UaDci/GRgtvn8C3DQ
 iTximWM5EBnXmiU4QcmkXYIvSzc24uTuDXJ4OrAz+c/2TTaZEP5ksVU0uUrZl3g3
 B/T4SpO8jOvNVUX9qyp3wjRNWHxDmqMP+PIH41HiY1NoS5gxuFRNUsk4ogxc1SGM
 myu/Sn0k2Yi5IwDyeZlhB0THJp5mJJsiIe0KyzRNucS37NYTjVhxHxXBxoXYgW9m
 9fP7V+zx+c4TTzOJzgs+WbSsqr+lje3fBX8ZkXGtU53SnawmezkgSuf48sOEpEGz
 VLDB6OaIPFCHFsaVPMUgxojiXtpDg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g7wqnq2h8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 10:39:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgoZxK7ppLo9d5lLD2qJ7us4B9ADw95LqjojkBABmGidvVrufBy0cN9UvpiwIttqbYFrhtzj51ujcpSf702jodc8bba/rIEoNb2Q6FnLQf25B9RUEKhiuK9NIa9UmP8kz5eaxHl6ryALb4wKqqDFgJXystdDOlxB5rrF7Igf2bB09vy1/WvR2bBkc46WcZwrsYHVjy2aYP/vzORTCaO98KvvrieU0ZJ6YXGb6DFNAl8HYQ7ISA3efjJ43F9+iT/YKSFRVK+4Gd5mfd0q/+msBb3J9DBaMy6+Fn3fnSNMvdUG5+kvzLpQP4SLCDgCV1j4CbzAVY0m/8IpdPuxXlKDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeqAOJeoGWuHVC/M+aPUOO7f+IpoZWbOAq15RcmlPVs=;
 b=Z+jemqj6Mhr6e2qZvl/+eWdD5s1garD2inoMYGRwx6aHq1oM6RNYLB6gFLXXFYeJaW3yXJv+6labvLZsKVVgq08DNgwZ1AXc0oPbBreqBth5hUunmUc4wD/0ibf2d0MZp/bTOJQH1uviOZ33prX/JZxVduD0L+iLiK5LjuH5lNVUeafeNn24GUYZRKanrhnX/uIjMGodCdFASXnpmh0mEqGC1Zm16kaPXZwPcvlxD9ag2IhzJQE11sDBfY4mRhHmKmz/aWySg3gFccSzg5rS5TN8ryCUwHxQXVCc6tEDq0YyKct8KsDj3JESNw842uOYqq48fra3K5yqnm2XDHxxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeqAOJeoGWuHVC/M+aPUOO7f+IpoZWbOAq15RcmlPVs=;
 b=n+y5783LlizRTvuKQ0SV36bl8kHYW3+qTEFOZUkOqrmO4wpcP3nf2qkQ5TmhUdgW6mBYokfDwqVTW+7F+DmucxyeniOetnk0SQAOYPP9Vk7Q1jYXCeGfgZNqjpaqL5wGjdtGOF/MPzzot70u0oJAdfLPF6SusVcNrPgb3R4gqJU=
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:39:38 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::53) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 15:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 15:39:38 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 10:39:20 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 10:39:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 10:39:20 -0500
Received: from [10.249.35.44] ([10.249.35.44])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67OFdJ0s3364955;
 Mon, 24 Aug 2026 10:39:19 -0500
Message-ID: <fcdc4b46-dab7-40fe-9b1e-c5c2e2ef8dd7@ti.com>
Date: Mon, 24 Aug 2026 10:39:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] leds: lp8864: Register a backlight device
To: Daniel Thompson <daniel@riscstar.com>, "A. Sverdlin"
 <alexander.sverdlin@siemens.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>, "Lee
 Jones" <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Daniel Thompson
 <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller
 <deller@gmx.de>,
 <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
 <aowP3K7sgXKnsonS@aspen.lan>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <aowP3K7sgXKnsonS@aspen.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9911a2-f5c0-46b4-17a1-08df01f5e810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 2RNC/3B56uZARp7XcVynR3TDIJ2lkWwc7rrGa0RDgP+O+4mkElQDpOh5qBaK2a1FJRktgP58GXJKykrweEIju9d25VRSAqI5pq77rbx2x4/3aE4Y5Wnd6Sws4NCTj7qoZc5heXMpaiFYmYxoEqwHRpAGlgsmCIyWygcG119hsL3YxX6b2H91aRv3Pq9DBiV7TXcngjSU+JvBrQchQWj3snn8Ydj/MoOYraBaEha6MxnJQMUK14Z01EtV62bbf7nJrAXV9u+d6g/OsKFCFkELF3ApdQGeq4ZIaY3YPda9Y3DU+iPkqN9vfGt03Va7XQ4F6lhoj27YHwfCEvJq8+dTjR83R8rbGx3TlJKcPk6823v9poQd1co0tDrNCoe86rp56VM+i9Ww4g6OiG8yaVpbRCMqEpg/yNSBA8vBNfD+wJnByMI22g4myeokjxCzlKZoGWR3smnq+Qpphz4RsSR7rPxZuvQm1dm5sHhQ3Q90Yz13pnnAUfmlxmeZXPJkpXB9b38n1TcW5/SvTCjUysnj6sz0Y4CV2TfJT41dNhh/PP9EfzMg0dqfRBeayFRr0IywFNmbjjU+TWaVh8IaUM+sO7V7I1WydC+8iC5yasAs3oW4Xh5xvY5Y/vmilD7eZ3gI3skCzlQlw0wBORTgsJjvB2SRynbOP5L7hpPJFO4iEa3o2pmgPqrnPeVjZ4vVfv9YDTG53pJPPqhHRdVN9EOJHg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ie1OAGVL/7jnZG3A1h+VietCaPIfe8iPWBBw1tk5oQk/Pj5kkR3J1tphzvOq5rinfVjfeKtROs2qfES6frxUnl4cmWlI8b2A+0ZyuJoFryCwZWfqenJcqBkpviSGa8/zMhuLHHGMRm1yA4p0V82MJH7pPiOoQnYi5ZOX/njgk3W6mr8+cdfxqT5DtoLGvQZ14LAgbGZ23pIS4IcUWPrGlM8/DEOuuzKkSAyO9rGYyK7xd7qFyYOO11Z428w2IRylMic+hwqdeEphPt6tJIKkUfMbOvDKtwqv8Olp3IJCXxsjDCnsBjNjtRQGoz2pi2wKRVK9NAsDJx9p0aknc/NQI/Uzr28aNV1BIr0/gvscYGy6TXf7Z7WyAehlqZKd5XMgeP2G8NiDl3oXIDSjx1CTR9bgIviWP0j8vyLhXvY9/oRWIrCEdoV8az6UX9cH27is
X-Exchange-RoutingPolicyChecked: Tr4NZnMvVIhICBWMMHWRz8wHNwyheri5KJgpSvE7pGLgBdXllXdsPWDYnbK/o0PRF1tuWWfdcPSDtJQsfjjRUnUf36EWTQPh+Gf1PuBT70asNrmVdz1gSfqxYKXGxaq/TJFu2eikBGo3CtuE55CovdwaBh21lMZbvi6mNTJqAMwZxOQ0YmsUHsSzr5BES+D5xXwjZHwmh1BehMZPLC5g8QaRrtdc8pxHe6PhA1DpdXYqsAUm0TTktCT8bT9ey5MLRMNXEfzCQASxLkan1OovNlSjZEKbDQfSI3HFMVq/L+Bk1qWTvGb/55BFa+OW98TT1/nPEFSs7M9LvIxJ6hgxrg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:39:38.0633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9911a2-f5c0-46b4-17a1-08df01f5e810
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Authority-Analysis: v=2.4 cv=Ss+gLvO0 c=1 sm=1 tr=0 ts=6a8c65c3 cx=c_pps
 a=BmBYDrMhH73hh332m6kGpQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=a_U1oVfrAAAA:8
 a=FCxMmQSoAVXafh-q42EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WFGXH_EtditRJjn1h9Oz7yv52oXklV7C
X-Proofpoint-ORIG-GUID: WFGXH_EtditRJjn1h9Oz7yv52oXklV7C
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzMiBTYWx0ZWRfX9SIiiE3Kjr+V
 E+Aykk0Wnb2JVJpzOXG+ft2neU9C271aBMF3GDT/c8/jFUPsLNa2l0HsD0wv/xIw70mReJ6BBYv
 9xqaJgRVhpEjaG1yCESJGlZfvjOQvG0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzMiBTYWx0ZWRfXwImXA9eCzYTA
 3xgtpIbWOvM7bzHF2obP60SAszMqHVUSy3DnLyfxGW+3ALjHe/GQ1EzbCp1w+VFDv4nQZ/0VF/g
 Xa19dfiARj+PcAtPVE+DSgpc8d0XoV/YEvydjOHI1JpSdwnq8lMOTcDnAFP6K0jvn7ylGsFyeEe
 jX9cJNuvvxwa4z2DnVJHaJCAgDtUuBPAvq6v9YIV44m4ZRDRxC3UCTLAyY0ohZzB9Iy8Z5Yelya
 lC1+VUtdIwH3w9NTjdxAuSvKkNck9nGmPi3pe3N+bHoEph4M4ijI3DWvInpFdj+FhLMvvclimll
 EI35TsZoDf3Dg7hwaRP4mlNDw3dCOdLjOjHzchcv26gaqF40p4OKh1lywQU7hlkecTREGk2u8uq
 bTs37Q74uSBxxW8VfbP2iOluvEvPI9gpwGJr4nLijPfmpV+u2N421DskA5uh7GIc6l1biVb+t2o
 V0wqlOarjydzGAFYujA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240132
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

On 8/24/26 4:33 AM, Daniel Thompson wrote:
> On Mon, Aug 17, 2026 at 07:08:15PM +0200, A. Sverdlin wrote:
>> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>>
>> The LP8864/LP8866 is a display-cluster LED backlight driver. Expose a
>> standard backlight class interface in addition to the LED class device,
>> so it can be used by display/panel stacks that expect a backlight.
>>
>> Use the new devm_led_backlight_register() helper, which spawns a
>> led-backlight device driven by our LED and tied to the I2C device
>> lifetime. This keeps the driver a plain LED driver, requires no
>> device-tree changes and remains backwards compatible with existing DTs.
>> It is a no-op when the led-backlight support is not enabled.
> 
> ... but when led-backlight support is enabled it will prohibit the use
> of the LED sysfs interface.
> 

The commit message states "in addition to" so both are registered still.
The issue would be in the [1/2] patch if it disables the LED sysfs interface
as this might be unexpected behavior to not keep both interfaces active.

> Having zero DT changes is a nice property but it seems rather fragile to
> change the ABI the userspace must use to manipulate the LED based on
> CONFIG_LED_BL.
> 

If this was done in DT then it would also change the API userspace must
use in a non-flexible way (DT is also considered a fixed ABI for a board).

> Is there no way to explictly configure which ABI should be used?
> 

I wonder if there is a good way to have the actual use of one API cause
the other to be disabled at runtime? So the first one used disables the
other, but that does sound like a race.

Maybe a mod config to disable the LED-BL path and keep the simple LED
sysfs interface would be enough. Or maybe a sysfw entry so it could
be set per-device if needed.

Andrew

> 
> Daniel.

