Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A4ECA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E50410E182;
	Mon,  5 Oct 2026 16:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SSImOPGI";
	dkim=pass (1024-bit key; unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="kao2qf2v";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3148510E250
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 16:37:52 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695ERnSL3886157; Mon, 5 Oct 2026 11:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=SJCtg7NzCxOnALVtnc1a1Pq++YK312Mb/FI+BLBcd
 jI=; b=SSImOPGI4PNeTq2eCapszMNOxkzpPUAgUt3efY0zLgUi4+GqqgdwgSiHv
 DDfZS9CVX4KLYKrjOUV3o0nW6E4nSgQ0ADaD3ZQTNRpLUdydz9O4asO4wzo7gZfq
 F4Bna4H1YKb6g+ehWiqPR81j0zB/em7LWt9ajN6T99fF3CkY9rxEug90EkJv6ZyC
 9JThAu48CcOj68oUlLkoWQ5F6s5Y9V/QzCQdLBuRz4I+ComP9NAYdcf7EAJga2AJ
 5OCfCel+6Ol3jzpj9LVyCOopEny4MksynWsW52nytqEEDvMW01H5Tndtq012wlwj
 zhDTKImElsOKbLNq4CtM8qZ73z3pg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h3gup6xvk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 11:37:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnSANzKCqIh72L0A+y/t/ScreYS/oVbBL91g1mMxJwRACvUtgbuAH8B/FEjyzGL52Pdy8qTRgrfKGL81UVHL4MHhWrfwB/WApqm0j/fAWGedWfgH+fvGOhXyNlKT8Pr6pglJQv2QhokRzw/F09nT00JmKrQosNOXoLlrymz/auGKCcz2Mf9Hp4abNJR9D+FbpbVC7N6cXfBOwATtRboCGyoS+50WRfEghZC/Ax43ru2y4rpO8P2JNOL//BAKv/rZrl+B196g+h5dqnlJqJUvMBxkaKrY89V/Nbqs7pX84PTTR26VmeXnhS59ZDDziDBzvTs3IQlxhDmM2p3hZEgPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJCtg7NzCxOnALVtnc1a1Pq++YK312Mb/FI+BLBcdjI=;
 b=niIk1/mDk4Z2D/3bC/sd/IrN7gaRbc79G/Iy3Vkm7xGoml8spY58jK6c6hUUe6CoIL3NdvvKGaNaDQBw0QLup4k3hiKkn7LreNskYtf0eVXS/jNJwhacH9NCZvTEx6Wud0H9zZFe6wY68BlntOgBsj0TK/c2lGLzhDjftv1jDTwq9pxZxUv4V0O/yCM77QZ7MUbATFZwbc0R3s3/HpupWG1TUEdazATF7IdDvNcl3AJHpobhjY2DvBCccUlXuVZu3ohILS+YkA95YXZcWOBEajXPl8cZFt5uixYfpxM21y3pVvCfEOY4++z0Y6QLn1qzChVixOKH/mwCqXtW5ea68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJCtg7NzCxOnALVtnc1a1Pq++YK312Mb/FI+BLBcdjI=;
 b=kao2qf2vkKfhB/tZEsPxYdBtmvSCiTz+UyuCZa2+XhdgPTAgCmIaiNfEBB2OLdAmkH80krnlCSd0CWOwt6b7C5keApVdVfq5eVcEfoVY26xajcpRBOmfK1V986vA3jan44NjlbckS1iR+/VSoa3kJrOZYR2iTQvVdH+AifAUass=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 16:37:38 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::38) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Mon, 5
 Oct 2026 16:37:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 16:37:36 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 11:36:47 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 11:36:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 5 Oct 2026 11:36:47 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 695GagTV540693;
 Mon, 5 Oct 2026 11:36:43 -0500
Message-ID: <235c4824-f6b9-4009-a18c-065a536e45f5@ti.com>
Date: Mon, 5 Oct 2026 22:06:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] dt-bindings: display: Add Solomon SSD16xx
 e-paper controller binding
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-3-devarsht@ti.com>
 <20261001-neon-dazzling-urchin-46b103@quoll>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20261001-neon-dazzling-urchin-46b103@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA1PR10MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7f7679-2cd7-4a40-2f11-08df22fef6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|23010399003|13003099007|6133799003|22082099003|18002099003|3023799007|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: M515LFx2cHfFCvEjkM5AS/W1ZuBvGR+VfY9mp2GKMm5YREF/mVVV2Ya1P0S3MDxTRTomhohonVmRP1fcVC1rPEh8/i2Vl1KiapD7znoaQyihGddGJTB0zsGXO8dDLWvzeUHpuvL16bP1GRd8yp+hkQUi9RnhLdqTFfloibAjiezHhopQOgTuNlk59QpGDbKtZ+i8iJ8ccGtvSJbf5rR5E4BV1ddTdBD4yL1rJdow3PrQC2j2uemLo/UzJW8fDBgvw1urvaZxC0TDIHQ4IFATysLgCapVNriHl6OmUgWe9TGpe+XMmT52UyTRhn+Eicmh3T6H6gLWz+dxc5dS1O7raB8niWGuSK+F0HXGq9huaePIUsqU3gBZyCsGvHmCVrrTOe/nAAWcijND0WnTcQ9U5Gr0y70i0tuproU65FRRFUezOoatOmgSe+djQEqWX12KbtuoKLyPJXzbmcEWRX0+Cmdqm2yqTvWVq0Ik0/RH1icOfTxSDMBqWP7GABMBYt1wwEh5FKWa/nwDIMvs0fSUEsup2+Feg+IeZKXFx0A09YyO7yRt0c84lcsmWpBIfUkxl828LwtACjqr5SYQvHgIvXFbpHrfHTXCZJ9G62qmS0dOO9wd5+AbxthG58NW3JWkwN8Owh/4yf7yW2hIBIEDYw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(23010399003)(13003099007)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hdc07bCej3F+GLdNrCoXpTZ9ZrymwVQmJNqkKpj/ZBn1Y0huGuFNJuq/eZlMjd/xXJAQpQ7JHm4yDhO4Pz/Ehg0gg6hb+6JtdixQjyAWNo0j4lw6i3Um+bdyFg0IN/Be8ho79hwpveg601WeLqlj3bbi1s1JpDALdFQu3vhWZk1GdIV13WE7CmS95wSJZLbq5eLxz+rCbRRv01thtkwbxCHGb1b3rCj1hFeapZxlxiogqbQPiVUBMoAis9pfxSPsESmcJgfz/IxxyJhsZ5MmfIzOzyEM/ICOt8FLPwr8Qw9fJloxr65wTeiSXysKDN5irnlF61EekJJchpN7CYJpBMQ8HYb1a8wJnx9TfGwv1XUwfkLAKG98MZM7JRVnXbQ2v+WfmG1Bp0cVUxiECLDLTw0fP6RSToBiM580Z+buIajTnImnW3Ed9Fm8L7uTYLSi
X-Exchange-RoutingPolicyChecked: TLM7rBNo93QtGIz2fzvtOfqr3dtYGfM3Kq4iQK63KwHH1M3Kc1hh3ND/SES+F7LSwGVssrbi7EUXNefZCvUBolZwoq1jylwKB1qkhADDq7eoDruGU9RrYeVTQnSZJGXzaAYxQC7Q8qjrE94wzQOtSP1+W35Ds5DUJ63pqzG6QGipFgpk9+XJ40mI9Jl/ktTQ2EXq8uoIB5ErrINPfB41vUNF3RPJeMrz7lo/N+K4qDGoE62pv7TxJ83Jl9N2RAmeXiXdcP1y4R228lZDayg/3IWJZ/l1TQwUVmwlnEioaUqh2X7vs9jmW1OkCcTlGxkz2lHu8CoITrc4GrUm8F6mow==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 16:37:36.9674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7f7679-2cd7-4a40-2f11-08df22fef6f8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-Authority-Analysis: v=2.4 cv=KqjYSmWN c=1 sm=1 tr=0 ts=6ac3d259 cx=c_pps
 a=J0RhwYao4za//xiv/28V8w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=YmX860EEAAAA:8 a=LBxWy3usAAAA:8
 a=gEfo2CItAAAA:8 a=sozttTNsAAAA:8 a=FfqjdZCJBnLWlJNvkFwA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=BeCehlkWaqzeQ17686bl:22 a=4jSGKt0uXjqk0CpsFuVH:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: YK1XS7bHJ-RNZc15ikdo9UhLwB16IDOk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2NSBTYWx0ZWRfX3rki2tckU/Vg
 V49E8Fb4wBmXVJF8eIvg5pxrrC446oxnx3eFdue0zurSYqirwumwr9lEMm1YrnrxoYncuVPhB89
 61Q5sqpZGWVmxYYIt8BCyf7f13wYQmo=
X-Proofpoint-GUID: YK1XS7bHJ-RNZc15ikdo9UhLwB16IDOk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2NSBTYWx0ZWRfXxpaaKfijGrR3
 bBGqh8PYcpaR7UT3oiduKc8aeRQT3Tqg7I3S5E26/SvRRaP/DSHhtgDW3Vd18ik7U6/LOUTKptR
 0qSFaoDw/yPFceu511b9NOe13srs0uZqhFtv8Tnrr6h8sNK48SdyCuwF7GN9H3yYo9+o4+hTvu3
 cnH35e2+JqWTaYepOoTBKvtYXJkGGO+qaKMEBrr4WzbyLo25tIGG5Ukb6kF7MhuHStxVxb/mexE
 Xmw0g3nvdEDTTzp8ZvQEgjJOfiJ3ZOuh9KkvCKVdYeYN/td+gkybqI5ExgIb0t3/Y3crMBsjQA2
 zygqTcP1MiKsf4+b4Td1FsbZke2jPDFaeD/s2dEXJQFlrPzKTnpyA8RXPq88DvXzZi8voJfYWgC
 cwmLNelMVeIyYVNMFRw0dL4RM8ldoWJuB1tJfihGHN8lNx/oeFPhxVQSqK8P9NTLdr0zFWv1rbJ
 au/chsRbW15J5UyDZwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050065
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

On 01/10/26 11:58, Krzysztof Kozlowski wrote:
> On Sun, Sep 27, 2026 at 11:53:17PM +0530, Devarsh Thakkar wrote:
>> Add device tree binding for the Solomon Systech SSD16xx family of e-Paper
>> display controllers (SSD1683 [1], SSD1673 [3], SSD1680 [4], SSD1681 [5]).
>>
> 
> A nit, subject: drop second/last, redundant "binding". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
> 

Agreed.

>> The binding covers the 4-wire SPI interface with required GPIO pins for
>> reset (active-low), busy status (active-high), and data/command selection.
>> The spi-max-frequency is capped at 20 MHz per the SSD1683 datasheet [1]
>> which is also the maximum supported frequency amongst the family.
>>
>> An optional rotation property allows static display orientation to be
>> configured from device tree.
>>
>> The data/command selection GPIO pin is also kept as optional since various
>> SSD16XX controllers such as SSD1683 [1] support 3-wire mode too with
>> data/command selection bit transmitted as first bit before sending the data
>> sequence.
>>
>> The first supported compatible is for Gooddisplay GDEY042T81 which is 4.2",
>> 400x300 resolution black/white e-paper display using SSD1683 controller.
>>
>> Links:
>> [1] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
>> [2] : https://files.seeedstudio.com/wiki/Other_Display/42-epaper/GDEY042T81.pdf
>> [3] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1673
>> [4] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1680
>> [5] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1681
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> Changes from v1:
>>    - Added fallback compatible for the controller
>>    - Wrap lines to 80
>>
>>   .../bindings/display/solomon,ssd16xx.yaml     | 87 +++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
>> new file mode 100644
>> index 000000000000..b31fb862de04
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> 
> Filename must match compatible.
> 

Sure, will fix.

>> @@ -0,0 +1,87 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/solomon,ssd16xx.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Solomon Systech SSD16xx controller based e-paper display panels
>> +
>> +maintainers:
>> +  - Devarsh Thakkar <devarsht@ti.com>
>> +
>> +description:
>> +  The SSD16xx family includes e-paper display controllers (SSD1673,
>> +  SSD1680, SSD1681, SSD1683, SSD1677) with integrated gate driver,
>> +  source driver and timing controller. Different panels use these
>> +  controllers in monochrome or 3-color (black/white/red) configurations.
>> +  The controller uses a 4-wire SPI interface and requires GPIO pins for
>> +  reset, busy status, and data/command control. A 3-wire mode is also
>> +  available where the D/C bit is transmitted along the SPI data line
>> +  before each byte.
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          # Good Display 4.2" 400x300 monochrome e-ink panel
>> +          - gooddisplay,gdey042t81
>> +      - enum:
> 
> No, fallback cannot be enumeration.
> 
>> +          - solomon,ssd1683

Agreed, will fix in this patch itself.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency:
>> +    maximum: 20000000
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the RSTB (reset) pin. Active low.
>> +
>> +  busy-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the BUSY pin. Active high when the controller
>> +      is busy updating the display.
>> +
>> +  dc-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the D/C (Data/Command) pin. Low for command,
>> +      high for data.
>> +
>> +  rotation:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 90, 180, 270]
>> +    description:
>> +      Display rotation in degrees clockwise.
>> +
> 
> Is this display controller or panel? If panel, then missing ref to
> panel-common. If display controller, then description is misleading.
> 

Yes, I think it should be possible to ref panel-common, Thanks for pointing.

Regards
Devarsh

> Best regards,
> Krzysztof
> 

