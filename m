Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E615C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEA810EA93;
	Fri, 18 Sep 2026 08:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oI3CDckq";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YqnhXavO";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD2C10E95F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:25:59 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68I6cwu3885069;
 Fri, 18 Sep 2026 03:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=i6KpoCZDsJHlQmS3FUdWbDMco8Bfq5Ss5n4uqfQku
 vk=; b=oI3CDckqGIaFn854BqfZbV6ruVaNBWjkerpGdjFuexNeh4MyOMGXW/T43
 xlffOG62al2LP8QbtNm9+B8cOfBcMT1iKzmHH/qsye7PpQ0/cKj9Vj6lbj3VczY0
 GVudTWCDRefgZwFQZry51AlUHBskTQu29UmbBudGFsiv0KNNxmIKzasa4dW7HMFq
 0zU9CqQZthiZeLGMFEoXHzAh44KIxqDe65DLDMMH3iAI+N5kDCesW1zzoptiG38Y
 8mYvU+I/72deort2coXRQrjxRHBnkwlXeA5GCXHG9Oa9Yj6P9DehRuj1KIBqUjbY
 soQN9v0MZeQ8yEr4R/ZZjIQCskOyQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by m0384305.ppops.net (PPS) with ESMTPS id 4grr9hbj0n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 03:25:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxaRbNN/q2ogy6JytlPD4K2TjrnnEWyRa3Ri47P7yufxeNcFSoWIhtgsqX6i9WnTdQqK6rrmeyUTOcN4ZQOGdOjO5yiOf9HErcyKc9NFQAmjRLpdMqCagvzs2oiRSb0EOgJgrohwcsg2KRubVa+d3qIcVIeDww4OUbt8GU4yGFoJhyDMzDsAQnXvd4aKbTuj0voy2K9CxBuY4Ff+jaHRv8MB0jDkyuDpGyiI4fl8K9X05oIYs/Ac9mIOWiyxnWaUpdYfNXPDTBakCvb/oyOS/UCK/VhdomkOQ4uBU0AGhUgL+YInkdUiyoYDrcXcM7xxQd1rbrvRNt7c+SfNNtuKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6KpoCZDsJHlQmS3FUdWbDMco8Bfq5Ss5n4uqfQkuvk=;
 b=xUWgy4q2unItZ4+zS5pnsxt3faNku3dOgfGa3DjNFqAwjQZjV6JlR0L5Fe8fZ4edCxNd4dSpWaIIgBWRm6zZgjQYU1/nSqF/fwBLevXmpvtGgQgSxO2JvNfblUfj88W0896NzI37DEZi+NgwjNws1GRgTUzUigcFmotjIrbU5bFEtz1dLuIyV2FVPqs36smY/CI1O1lG78NsihNJ9VGkRwCYpgJEFmsb6/AGPOSJ9NNhM6/31U9i+fPAYTX4TQRUOBS7fYfyQDXTK6P/aiBn5bsWIO2NoniiSz5GDeTpvZccTFb7rooe8my4T/luh2v4x192qgdfPw3W7b2RRz9DPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6KpoCZDsJHlQmS3FUdWbDMco8Bfq5Ss5n4uqfQkuvk=;
 b=YqnhXavOXNlpfo2K5PaVbiuizLkc6BmpGuV+XEDysTAkHmMdjZPqF6h2Uumc85HuRG4RTkWoiWQX2CAWO84xYxDbCGNBraxmcWrZR2BrkiBTA7i28Mo57/BWIxXknH4zLRlV903Ssynlac3yc3290CD9UcccXrFjLPfE+sRolq4=
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by DS0PR10MB997625.namprd10.prod.outlook.com (2603:10b6:8:312::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 08:24:51 +0000
Received: from BN7PEPF0000009D.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::68) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 08:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN7PEPF0000009D.mail.protection.outlook.com (10.167.248.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 08:24:50 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 03:24:41 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 03:24:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 03:24:41 -0500
Received: from [10.24.53.80] (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68I8ObRI433302;
 Fri, 18 Sep 2026 03:24:37 -0500
Message-ID: <253130b2-4a3a-47b3-b377-1d391bd5b70e@ti.com>
Date: Fri, 18 Sep 2026 13:54:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/tidss: Fix synclost issue while disabling layer
 due to erratum i2097
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <s-jain1@ti.com>, <d-mittal@ti.com>,
 <b-padhi@ti.com>, <jyri.sarha@iki.fi>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260701063337.2165966-1-y-d@ti.com>
 <dc4f1e73-caff-4371-9463-9d4d4c4af442@ideasonboard.com>
Content-Language: en-US
From: Yashas D <y-d@ti.com>
In-Reply-To: <dc4f1e73-caff-4371-9463-9d4d4c4af442@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009D:EE_|DS0PR10MB997625:EE_
X-MS-Office365-Filtering-Correlation-Id: eccd6098-e5a9-4e74-c626-08df155e4f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|30052699003|23010399003|1800799024|82310400026|13003099007|6133799003|5023799004|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +h6pOImhnJq9xyMnrHG22uHSQ/beWHi1zOz+2vHhuO//LZ5pzK12SSFCkRTgYlfCVobSJCjuWWglK2hI4+Lmxk3Phg5Uvo/pyWd/ncTrEYFOk5QdCUV45uTHsQUlLxaUvMQ4kN/wRvoR1d93L3w//wGMjqd1A6e31zjRNtyMtDcGpzUVkY9KHaMWcpA3UGuM6ZUExb0x7yM2+M1NURZhI1sq7VDhDtT+Hz0O0ZFO9ijquUmfSd7N9v3aIiWx9pokkFNBi5NBCxH+EMJ32AfoFZ2uo///Ylf8uP5e80ZWDc/vIiElOMmXf6G9FvtnJMAmm1gPXALdav0BGRklhyH+P7xEcQwK1Qd3pk565R3nGkawIlbWEVLFjQfdNMSYiwL2YSj+tmg2fcQU+HcYtGxZC4aU2KbrbXokMS4saouoPzKVZPQhCatRyjZ5Ivek0buzKfv3UBOYjZS+/mOsRXkKR8aCIk84c2jl3a4fe5ChshNKvYlHoRiNX79pNAD1zuSE41oMkUP9ywCc2Lnllevx8frOz4mP6gBYLD4LNECX74fID7HDAD8vQ04C25pncg3KBytwOwcpwU/Aeaf7lJslqQwS4W4WqaQAX1X2z+vQ7nVN1M4zDyI8ic77pBinlxFvCYEXWH3T4rgComFD3ykSL+ZDtKaMoEoEzLE/Y50H9XvTh6eHOH3k48AkLjRc1ib1V/KbyGvTmCszIaGZhzODig==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(30052699003)(23010399003)(1800799024)(82310400026)(13003099007)(6133799003)(5023799004)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T4GEGdgxGkLVfVuRrzcEdj1U4kqBScA78meF4x9lqUosDTcAtJxuhy33ktz7XkoAV8dGe41m/LGvoPu7SNXRFiCHraU2snL2Q74TVXTK1UpPBhuZeYkmOQSsZeqUVTY+StQx+ZEx2Mt71Ufif5ajRVCp5bGQiShhy7r2zddv6s6lTzQDqODhYIaV6wJRNnLOYdtur5KV4i+5tpe1AsEkRGjQqM8MPDr62/1t4xf6J3zBMP7PTuqTZm7IDE5X36zV+ZeQ8DDIcKZQBiECGcRduyxx9LmToTKWsjE8luYNVIyFEsWwbHyN9P+mt/rrntZ1db0K7APvxRlzM5EGGotfyjGpH4eUlm4m5Y72ZIIgcGhtXhLwiIlidwqFBvE3FkY22VkQZOBRKWBTPL9i95o+FB+9GAf3uo33lepvui8J1t2w0TS2P+HtD3R3/Wqf7HxP
X-Exchange-RoutingPolicyChecked: 2r9BLOGb43LAlEQC/kYDfIpM+8ZV8XyxX/fxLyFweYm0IK5G7A+SKosNNJ9u4XgEihziTKx902UW8qWhlSaspcHdYssrvpaa42jKRIAize1v1TBKMQXxQRnVVN/0oT8fZ1oCOFbNCPm1LzeVkCZE7djql9bSXuOmJNbZzNVAX7FgFOZsbQOYdR6NQ+V8ygjGDjUt9e52ZsDsOXn1F7BRUBIKeChHtt8xeswCaTFuj7PB3HtxAV4AJw8enMqYW1RCHIWkWat5tYs0uXOoOjhDaCAoFtW8GbeHpVVNVCUtGs93pufdqLK1BOLh/wYnCAPmLO6XJSzaOBANDLstTQEdjQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:24:50.6897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccd6098-e5a9-4e74-c626-08df155e4f1a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997625
X-Proofpoint-ORIG-GUID: Aj-Kc4ctopIV6AIQr4agTLy78mK8XNJL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNSBTYWx0ZWRfX0JqBvpxDiSwk
 gZQLkTxVli77hyzMEoNm13ulOtJUKdqlhw40Nb7Zoy0EasPbFe3tgG/+/+L9JovVyt6qO2/bzzM
 oZBffSmGGdKbTIuaTofXsp75oQUBsOhzBWoJvE5tFhn0S/FGqxkpRIPSJIlND3iuuAmuCJh3uTd
 61nwSlgE8rOJS9JwJavfAz4ZI+IALFyqPaT3pQhzrQEUdqBWZD7N0XX4QA433XEc7an3UN0cD88
 RyXW+mXxaePJCGrNmBOCQKdaEwNqmm+WY2nheupOV+RRiUqTDdAQn6GDfMzSxE28sE2qJ1ksOST
 AJ1VhiexPWmlr1ci30zwln66A1TwWYMcb/nc34WBHAVQHyNv+dAUugvLXVG/YC+Tq5qKtUe35ku
 ZjkDfO6ExSjIYCKePU9vbSayEDytO5CVbB++qqiJxtBapKsAXeR9Qtvg5Q2wGtoovEJQ6BOrdQJ
 hXxJAMIbguqT+MFNZjQ==
X-Proofpoint-GUID: Aj-Kc4ctopIV6AIQr4agTLy78mK8XNJL
X-Authority-Analysis: v=2.4 cv=eeCo7LEH c=1 sm=1 tr=0 ts=6aacf580 cx=c_pps
 a=h5F5dVrtafxD4HcxutFXpg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=IyquqQ9fsgQ_C7scwZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNSBTYWx0ZWRfX/S201iR45Vug
 gVFBELGpZXucAp+M42wXWBmfp0mgRtmEK9THjZAfiQBLpgcf5qkRWNnQxLFu2NlgEFiUAHoPIx6
 FgC9XJlLuNCaFABdkWUh3Aesh/5rTJA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180115
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



On 07/09/26 18:45, Tomi Valkeinen wrote:
> Hi,
> 
Hi Tomi,
Thanks for the comments.

> On 01/07/2026 09:33, Yashas D wrote:
>> A gap beyond a frame duration for disabling the layer in overlay manager
> 
> I don't think that's right. The key is that the layer is disabled on 
> frame N, and the GO bit is set on frame N+1. So the duration can be less 
> than a frame, if the frame boundary is between disable and GO.
> 

Will reword it.

>> and go bit setting on the corresponding video port may lead to SYNC_LOST.
> 
> I think it's quite guaranteed, not "may" =).
> 

The errata documentation that I have attached says it "may" lead to 
SYNC_LOST. I had tried to force it and it doesnt give SYNC_LOST all the 
time.

>> Fix by moving the layer to the non-visible area and deferring the 
>> ENABLE=0
>> write, immediately before the GO bit, guaranteeing both occur within the
>> same frame window.
> 
> Maybe: "Fix by moving the layer outside the visible area, and deferring 
> the ENABLE=0 write to happen just before the GO bit write, ..."
> 

Will fix the wording.

>> Link: https://www.ti.com/lit/pdf/sprz530 # i2097
>>
>> Signed-off-by: Yashas D <y-d@ti.com>
>> ---
>>
>> changelog v1->v2:
>> - Flushed the pending layers in dispc_vp_disable to prevent hanging 
>> layers in hardware
>>    when dispc_vp_go is not called in CRTC teardown and modeset paths.
>> - Removed the AM62L switch case as its the same as the default case.
>>
>> Link to v1: https://lore.kernel.org/all/20260630103802.1853564-1-y- 
>> d@ti.com/
>>
>>   drivers/gpu/drm/tidss/tidss_dispc.c | 118 +++++++++++++++++++++++++++-
>>   drivers/gpu/drm/tidss/tidss_dispc.h |   1 +
>>   2 files changed, 118 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/ 
>> tidss/tidss_dispc.c
>> index 58d5eb033bdb..02a3cf50e0ce 100644
>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>> @@ -38,6 +38,8 @@
>>   #include "tidss_dispc_regs.h"
>>   #include "tidss_scale_coefs.h"
>> +#define OVR_LAYER_MAX_POS(mask)        FIELD_MAX(mask)
> 
> Maybe just use FIELD_MAX() in the code below.
> 

Will use FIELD_MAX() in the next version.

>> +
>>   static const u16 tidss_k2g_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
>>       [DSS_REVISION_OFF] =                    0x00,
>>       [DSS_SYSCONFIG_OFF] =                   0x04,
>> @@ -467,6 +469,8 @@ struct dispc_device {
>>       struct clk *fclk;
>> +    unsigned long fclk_rate;
>> +
>>       bool is_enabled;
>>       struct dss_vp_data vp_data[TIDSS_MAX_PORTS];
>> @@ -477,6 +481,9 @@ struct dispc_device {
>>       u32 memory_bandwidth_limit;
>>       struct dispc_errata errata;
>> +
>> +    /* WA for erratum i2097: OVR Layer Disable May Cause Sync Lost. */
>> +    u32 pending_disable_layers[TIDSS_MAX_PORTS];
>>   };
>>   static void dispc_write(struct dispc_device *dispc, u16 reg, u32 val)
>> @@ -1134,6 +1141,12 @@ void dispc_vp_prepare(struct dispc_device 
>> *dispc, u32 hw_videoport,
>>       bool align, onoff, rf, ieo, ipc, ihs, ivs;
>>       u32 hsw, hfp, hbp, vsw, vfp, vbp;
>> +    /*
>> +     * WA for erratum i2097: clear any stale layer disable tracking
>> +     * state left over from the previous VP enable/disable cycle.
>> +     */
>> +    dispc->pending_disable_layers[hw_videoport] = 0;
> 
> When is such stale state left over?
> 

It was used defensively if by chance any stale state is left. But since 
we are also doing it in dispc_vp_disable, it might not be required here. 
Will remove it.

>> +
>>       fmt = dispc_vp_find_bus_fmt(dispc, hw_videoport, tstate- 
>> >bus_format,
>>                       tstate->bus_flags);
>> @@ -1210,6 +1223,23 @@ void dispc_vp_enable(struct dispc_device 
>> *dispc, u32 hw_videoport)
>>   void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
>>   {
>> +    u32 layer;
>> +
>> +    /*
>> +     * WA for erratum i2097: flush any pending layer disables directly.
>> +     * dispc_vp_go() is not called in the CRTC teardown and modeset 
>> paths
> 
> I think "teardown" is what happens when e.g. one unloads the module. I 
> assume you mean crtc disable here? Or what's "crtc teardown" and 
> "modeset", exactly?
> 

Yes, I meant tidss_crtc_atomic_disable and tidss_crtc_atomic_enable. 
Will fix the wording.

>> +     * so pending_disable_layers would otherwise never be consumed, 
>> leaving
>> +     * layers enabled in hardware. Sync lost does not matter here 
>> since the
> 
> What do you mean does not matter? If it causes sync lost error prints, 
> it matters.
> 

No GO bit write follows a raw ENABLE=0 in dispc_vp_disable(), so no 
frame-boundary event that DSS could flag as SYNC_LOST is generated on 
this path. Will fix the wording.

>> +     * VP is being disabled.
>> +     */
>> +    for (layer = 0; layer < dispc->feat->num_vids; layer++) {
>> +        if (dispc->pending_disable_layers[hw_videoport] & BIT(layer))
>> +            OVR_REG_FLD_MOD(dispc, hw_videoport,
>> +                    DISPC_OVR_ATTRIBUTES(layer),
>> +                    0, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
>> +    }
>> +    dispc->pending_disable_layers[hw_videoport] = 0;
>> +
>>       VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
>>                  DISPC_VP_CONTROL_ENABLE_MASK);
>>   }
>> @@ -1233,6 +1263,38 @@ void dispc_vp_go(struct dispc_device *dispc, 
>> u32 hw_videoport)
>>   {
>>       WARN_ON(VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL,
>>                  DISPC_VP_CONTROL_GOBIT_MASK));
>> +
>> +    if (dispc->errata.i2097 &&
>> +        dispc->pending_disable_layers[hw_videoport]) {
>> +        u32 layer;
>> +        u32 delay_ns;
>> +
>> +        /* WA for erratum i2097: set GO bit #1 to latch position
> 
> Start a comment block with "/*" line.
> 

Will fix it.

> What do you mean with "set GO bit #1"? Do you just mean writing 1 to GO 
> bit? If so, just "set GO bit to latch..." is enough.
> 
> 

Yes I meant writing 1 to bit. Will use "set GO bit to latch...".

>> +         * changes into the DSS pipeline, wait 10 DSS functional clock
>> +         * cycles, then write ENABLE=0.
>> +         */
>> +        VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
>> +                   DISPC_VP_CONTROL_GOBIT_MASK);
>> +
>> +        if (dispc->fclk_rate)
>> +            delay_ns = DIV_ROUND_UP_ULL((u64)10 * NSEC_PER_SEC,
>> +                            dispc->fclk_rate);
>> +        else
>> +            delay_ns = 500;
> 
> When do we not have fclk_rate? Shouldn't we always have it?
> 

Added it as a defensive check. Will remove it.


>> +
>> +        ndelay(delay_ns);
>> +
>> +        for (layer = 0; layer < dispc->feat->num_vids; layer++) {
>> +            if (dispc->pending_disable_layers[hw_videoport] &
>> +                BIT(layer))
>> +                OVR_REG_FLD_MOD(dispc, hw_videoport,
>> +                        DISPC_OVR_ATTRIBUTES(layer),
>> +                        0,
>> +                        DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
>> +        }
>> +        dispc->pending_disable_layers[hw_videoport] = 0;
> 
> My first thought was if this causes problems if vsync happens somewhere 
> in the middle here, and tidss_crtc does pageflip handling. But I think 
> that can't happen, as this is only called from tidss_crtc, inside a spin 
> lock. If that's the case, I think a comment here somewhere would still 
> be a good thing.

Will add the comment.

> 
>> +    }
>> +
>>       VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
>>                  DISPC_VP_CONTROL_GOBIT_MASK);
>>   }
>> @@ -1503,6 +1565,53 @@ void dispc_ovr_enable_layer(struct dispc_device 
>> *dispc,
>>       if (dispc->feat->subrev == DISPC_K2G)
>>           return;
>> +    if (dispc->errata.i2097 && !enable) {
>> +        /*
>> +         * WA for erratum i2097:
>> +         *
>> +         * Do not write ENABLE=0 directly. Instead move the layer to
>> +         * the non-visible area so it contributes no pixels.
>> +         *
>> +         * Position register layout differs per SoC:
>> +         *   J721E : DISPC_OVR_ATTRIBUTES2, X[13:0],  Y[29:16] (14-bit)
>> +         *   Others: DISPC_OVR_ATTRIBUTES,  X[17:6],  Y[30:19] (12-bit)
>> +         */
>> +        switch (dispc->feat->subrev) {
>> +        case DISPC_J721E:
>> +            OVR_REG_FLD_MOD(dispc, hw_videoport,
>> +                    DISPC_OVR_ATTRIBUTES2(layer),
>> +                    OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSX_MASK),
>> +                    DISPC_OVR_ATTRIBUTES2_POSX_MASK);
>> +            OVR_REG_FLD_MOD(dispc, hw_videoport,
>> +                    DISPC_OVR_ATTRIBUTES2(layer),
>> +                    OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSY_MASK),
>> +                    DISPC_OVR_ATTRIBUTES2_POSY_MASK);
>> +            break;
>> +        default:
>> +            OVR_REG_FLD_MOD(dispc, hw_videoport,
>> +                    DISPC_OVR_ATTRIBUTES(layer),
>> +                    OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSX_MASK),
>> +                    DISPC_OVR_ATTRIBUTES_POSX_MASK);
>> +            OVR_REG_FLD_MOD(dispc, hw_videoport,
>> +                    DISPC_OVR_ATTRIBUTES(layer),
>> +                    OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSY_MASK),
>> +                    DISPC_OVR_ATTRIBUTES_POSY_MASK);
>> +            break;
>> +        }
> 
> You could probably use dispc_ovr_set_plane() here. It writes one extra 
> register, but I don't see much harm in that, and gets rid of this 
> duplication.
> 

Yes, will use that instead of duplicating again.

>> +
>> +        dispc->pending_disable_layers[hw_videoport] |= BIT(layer);
>> +        return;
>> +    }
>> +
>> +    if (dispc->errata.i2097 && enable) {
>> +        /*
>> +         * Layer being re-enabled: cancel any pending disable so
>> +         * dispc_vp_go() does not write ENABLE=0 after we have
>> +         * just written ENABLE=1 here.
>> +         */
>> +        dispc->pending_disable_layers[hw_videoport] &= ~BIT(layer);
>> +    }
>> +
>>       OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
>>               !!enable, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
>>   }
>> @@ -2871,6 +2980,12 @@ static void dispc_init_errata(struct 
>> dispc_device *dispc)
>>           dispc->errata.i2000 = true;
>>           dev_info(dispc->dev, "WA for erratum i2000: YUV formats 
>> disabled\n");
>>       }
>> +
>> +    if (dispc->feat->subrev != DISPC_K2G) {
>> +        dispc->errata.i2097 = true;
>> +        dev_info(dispc->dev,
>> +             "WA for erratum i2097: OVR layer disable uses non- 
>> visible area\n");
> 
> I don't think an dev_info print is required. The other WA info print is 
> there as it's a rather big one, disabling YUV formats.
> 

Will remove it.

>> +    }
>>   }
>>   /*
>> @@ -3059,7 +3174,8 @@ int dispc_init(struct tidss_device *tidss)
>>               __func__, PTR_ERR(dispc->fclk));
>>           return PTR_ERR(dispc->fclk);
>>       }
>> -    dev_dbg(dev, "DSS fclk %lu Hz\n", clk_get_rate(dispc->fclk));
>> +    dispc->fclk_rate = clk_get_rate(dispc->fclk);
>> +    dev_dbg(dev, "DSS fclk %lu Hz\n", dispc->fclk_rate);
>>       of_property_read_u32(dispc->dev->of_node, "max-memory-bandwidth",
>>                    &dispc->memory_bandwidth_limit);
>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/ 
>> tidss/tidss_dispc.h
>> index 739d211d0018..e2ce9fdf1279 100644
>> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
>> @@ -57,6 +57,7 @@ struct dispc_vid_info {
>>   struct dispc_errata {
>>       bool i2000; /* DSS Does Not Support YUV Pixel Data Formats */
>> +    bool i2097; /* OVR Layer Disable May Cause Sync Lost */
>>   };
>>   enum dispc_vp_bus_type {
> 

Let me know if any more changes are required, will send a v3 after that.
Thanks,
Yashas D
