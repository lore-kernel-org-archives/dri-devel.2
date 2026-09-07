Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4430EC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7637010E6A4;
	Mon,  7 Sep 2026 08:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SHzGC5ET";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tg3b49s6";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3EE10E6A4
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:05:29 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68775rQf2615426;
 Mon, 7 Sep 2026 03:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=/ULPVWEk20ZWYHFXrmYfd4R6N73UY9R58iHF0vSoC
 OE=; b=SHzGC5ETVyLh8Lrzq6yXyLU2NVZz7p9DW0LpUSU7tVLg/0VQL8KmLH7UU
 M0OzTTQNpRelSDnMykADQsBWMOTCUcEWBc/H3317CymcQOmO0zqYw+MX9YvlUMnh
 uNWND4EtydOJuXEg/rHbsWPxyZVJJdyQe0KjBgYbBiFVZ9UX/SmLykkTFQtMoMZP
 XdgihrK6BZ+jpfKD/5Cixj0Fxssi/oAGSDaDHkWK6ZPWpyF6BF9bw0pHK4x5v/b/
 Y9mDlu8HrTyrbyDsbPsraCcT7nmBYFMyR7Q0k6i3olqk5m4NjxpebMpjkJ5/ak/W
 fe5Ez9KpUuUa02CDnkOn6MDbbDTZg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gh43n4fjs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:05:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLU97EfqrpwafIoicRHL3Iwjlm/RWb4lFcKT8nBlz0KH2FVdXdgDPc83y5GMJgn6LzEHJ7Y/As0LrOQUPmpmeDFjPLBlUxfmfRI8yvNmPQyqR3qPRUqLdChPyQfoGLuqP4wedeJlRGfMXyV6Fufc6boJQ9Kdso9f2pOt/a2tnjBBSiRxU3flNgfabyuJ+YOHheXMfcRgtPJPMNpYVe9gMztZsodbQLrqhEzbDrarebOxoTClXZSyWEP9o8NUwUFUNiWq8d22aGcAuVJ8EVdUygvp+BIOzH2/PQ2UFGHp1TbBP3v3bLCz8EZ/a4L+3Nu+4LSMEFxX8wmXqJMiX1jqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ULPVWEk20ZWYHFXrmYfd4R6N73UY9R58iHF0vSoCOE=;
 b=JX+4s8EgTuOKtZOm9Nit5Rqt7B/vp/1CU7eABvD5EDL+t3ZidOwHvKZ4AndZiVEcyZtUM+vlB/2+f27T5UqgJhbJi1sp74kqQf9VwQ63OXl7wrEXtgjyPm+UBRxz1D4Kr2Rm5XSVNFVeeCuvTuPJJBLCtKZMKuaCNXdoMytTKTfBom9wmubwYedm0brahwBGwRpfHmSvwBWyi4WTXSMiNRPBkfHagzY0EEDGMXR4hWIYTrssePQrNaq4a5g9Bhfr0zG/vwP6TDs6n1cNsbVTewgdJMVSnYBBbhLsNFXziHu8T4mYFnDffYINYRvpPDyHIU+34W/ktwzVa1Q6Jjeb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ULPVWEk20ZWYHFXrmYfd4R6N73UY9R58iHF0vSoCOE=;
 b=tg3b49s607rkIiDvr2WmH9igjzVKSdJRX1fVdpg+pZ6XdoWTkS1JNi0Ua/XMnKKr0xA4aS0o3sgyv06VJRah/zooCfMwG49cPSUeW1FuQuwzbXH6exIY64P92ycYdxqAtFd/qIOIOpQRrCmkoUnknkofGP3JxmEVuMza4xxSCsQ=
Received: from SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::17)
 by CY5PR10MB5987.namprd10.prod.outlook.com (2603:10b6:930:29::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:04:55 +0000
Received: from BY1PEPF00026969.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::65) by SJ0P220CA0008.outlook.office365.com
 (2603:10b6:a03:41b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF00026969.mail.protection.outlook.com (10.167.244.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:04:53 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:04:11 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:04:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:04:11 -0500
Received: from [10.24.53.80] (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 687843F41118540;
 Mon, 7 Sep 2026 03:04:04 -0500
Message-ID: <74b6c764-b100-42a1-b013-fb47c7cc09a1@ti.com>
Date: Mon, 7 Sep 2026 13:34:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <r-ravikumar@ti.com>, <sjakhade@cadence.com>,
 <yamonkar@cadence.com>, <u-kumar1@ti.com>, <devarsht@ti.com>,
 <s-jain1@ti.com>, <d-mittal@ti.com>, <b-padhi@ti.com>,
 <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260802153825.1570435-1-y-d@ti.com>
 <20260802153825.1570435-3-y-d@ti.com>
 <9e5bae91-b72f-4c71-9bea-ccafdf9747a3@ideasonboard.com>
Content-Language: en-US
From: Yashas D <y-d@ti.com>
In-Reply-To: <9e5bae91-b72f-4c71-9bea-ccafdf9747a3@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026969:EE_|CY5PR10MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 41db9e13-66f2-41b2-b613-08df0cb6b2ec
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|10067099003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: dUVOSM4XeS2qdzEV13FkBp8M0JgNYCQblHDF0ok1XzM6Ek7jtvN770daA/xsYFmvVpWUUsW2qnZhmVJ3VjVYxACpMNMg4kP22CoKDyILz+cOD9su9/rqsGgdsty6n6Vjc1SCYoN+v7wy3erdhwHHva3S/kmTrFV6Cu5DQCHGxtnJuQ3JK66O32fZPjpddXOVNxrufnrVFtEk1K48K6sOhfDjE2EDxFDcnGdeirp3ovMXjGTAKqWme95bfdERS6tRTTD2TEm9DTLNgD+ugtyvCsKJ+6p8wC/4QtyF/h9xe4ohXQaqAp9BLalPSSQZFTjBcervRP7E+Xe+OWpw0KaWO3QG6UY6WBcvOyPaB7EIWaSn92Nf/mWGqvo059yfPYVYsg34GyMd+WBmZpZkfhNMxIRFXmQOnqu9+1PDJ1YqUBPtnUwl16umemmgqLR5+0SHERAplR2o/020x4/1jygBSdlP5FhNc6We34y9rm+dbx6fQuJpkBomCAHc38fdCNhYdSyaTVXcIiYbcWd77jlaYRbgER93df7cjRNWoD96aviN0fuumxk8u0EMigrcp9hPzml5g3ybSuZYbnTb7T230ASXfpQ8/+Kl+4lhQMZ3UXCqnLBMeFRsgWu9V059LKTlnKSjkP1FDD9Ml4FdEoEyAhFWV6tDx2PVgmYdShhj2pXFJjJwp9jSfXPl1PKRRywm
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 738/OKVMzAYfWDsLGrjy1O0aXFZXvWrA0fcM0ZIvGiAhszBIFSIbNuPFVvkP/oPpTEskpVBoEOgNnNIdqaaeX8Wol5agatzk4+tuIHcZpFmp6xiIAqzjbWwWyaiL7KWDQI68E4GbUTwFpNOncfrWdeMWp8yTEAtRj0AY7SWTNDRYHbZ0e8HtlMoWcEqphaFCApLh+nSAd2PCT8pfcxfwgeFZ6T+o0qGCTUq4jZ4R7rG8A1iv4S3RY3p0yQabbGgg2ajuGlJePHMQO/5De+NOr7LdYigVFByTfpJ6WyatPtkVBKfSBvl1J2HTpcAOVx64Gt0BtXcEuvlbolW2ewPLFQbf0TalgcQ6mCdhPrDPyV9efXBDWaPMgy3/ynk2JvZ2uZNz/57W2VnQ93lW/9KNjQ3H7BlxZf87tMrdoxp/EZCPyPAWABUFD5+RKHniqZUt
X-Exchange-RoutingPolicyChecked: RFKLiPpj2daXVlzfuJJzzZGGwppdZLvt7lg4Gs0Ez7o5/xniOGqEoNmTaOgxKJFeBoE+8B3OzL6lMUCYfz+cPRC8ravcVqoSo1w+F2VpFIVc4GDxHEGN4O9TYp2az9Ob0Z2k03E1J7RiNtYdqYCMy55/7OeU8PfjtEOER4TafhTqNJxH5myxmYUsHcs6a6+xm6eg4Wb9FNVkQ84ftQZQgn2lVsVe8doLNJTT98CtQljVD+DUBligPldhj1Nc0lIufQid9ZK1kzSvoeaf3NXfb+uHsXcQjIo2rzoOuRAaT2AbjN2K4asLVik3RSjK+zLx1XOxzErORS3gFxVOK2EMtg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:04:53.4097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41db9e13-66f2-41b2-b613-08df0cb6b2ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026969.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5987
X-Proofpoint-GUID: 2X1KqdPywutIPcZRvMrq8STbkXJBFqqo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4NiBTYWx0ZWRfX8qwop0B4f/yn
 RgULC9oOP/OJ2gKY2/Wb52XbXGQlTPstZ3OA52LtL21iHJiOqH5V68VfgYmucOpnfNwW6FP79QL
 pizXTf2x/kyYkFDBsdeCLLScpH0WkiPUdayc07d3s1z0moUuijH/dpvt1mvFKybnFU6tTN9emGd
 3COm+uSIzqtPLpwQE/gevDOR7pCE+xLPVVHleXGsARR7LO/b58RuqC7+kivmQLoN17dReLRfH9V
 6NQlTDc2Vh5+y5/vf6oYlpWbEt0gpgx8DaqrOZYKZAB0PFWilj0+EKtX5ens72/OEFomzWuJp+4
 Ux9AzEdvwzYKt9tkTlXr/52h8gh68dTWSCNQqTUeSaSVY5qiz66d0Xuh1wrm5OBMxPQ+ArLxw2z
 93RMRZsCfAIUAVWzFaxgqSgxU/FtpDLrwL5VKQsl366cmtODUrfjQ/foIZ5fUCOLgEMmxX8xLbf
 VX86mpfwdj0CC9mneLQ==
X-Proofpoint-ORIG-GUID: 2X1KqdPywutIPcZRvMrq8STbkXJBFqqo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4NiBTYWx0ZWRfX2Y2KtkCK8Dvy
 PQyxKSxoZCWokxESOZmbmFHmzEeN4r2jPXRgA5qELh5idPJdMfiW0szTyRiXCdqIx/wyMfzBGPG
 9X1XLwuBj7+ZO9Ei/spbMRUl0Fa3Yxw=
X-Authority-Analysis: v=2.4 cv=JdSMa0KV c=1 sm=1 tr=0 ts=6a9e702e cx=c_pps
 a=uCbPN9sl+YgD9yJogSPUSw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=qJkczq80FH4NXtR3uzYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070086
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



On 21/08/26 16:00, Tomi Valkeinen wrote:
> Hi,
> 
> On 02/08/2026 18:38, Yashas D wrote:
>> From: Rahul T R <r-ravikumar@ti.com>
>>
>> Add a 'no-hpd' boolean property to support boards where the HPD line
>> cannot be used for hotplug detection due to hardware limitations.
>>
>> On TI J721S2 EVMs, the DP0 HPD resistor is not populated from factory
>> (DNI), so the HPD signal is not physically connected to SoC pin AA24
>> by default which makes HPD unavailable but AA24 must be in DP0_HPD
>> mux mode for the MHDP firmware to operate.
>>
>> When this property is set, the driver uses auxiliary channel (AUX) DPCD
>> reads to detect monitor presence instead of hardware HPD signals. The
>> DRM framework polls the connection status via the .detect() callback,
>> providing hotplug detection without requiring the HPD pin.
>>
>> Valid use cases:
>> - HPD pin not routed to connector on PCB
>> - HPD signal muxed with another function on SoC
>> - Hardware designs where HPD cannot reliably detect monitor presence
>>
>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
>> Signed-off-by: Yashas D <y-d@ti.com>
>> ---
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 79 +++++++++++++++++--
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
>>   2 files changed, 72 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/ 
>> drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> index 504a3186ebb3..ae9bbec855f3 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> @@ -53,6 +53,8 @@
>>   #include "cdns-mhdp8546-hdcp.h"
>>   #include "cdns-mhdp8546-j721e.h"
>> +static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp);
>> +
>>   static void cdns_mhdp_bridge_hpd_enable(struct drm_bridge *bridge)
>>   {
>>       struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>> @@ -698,7 +700,9 @@ static int cdns_mhdp_fw_activate(const struct 
>> firmware *fw,
>>        * MHDP_HW_STOPPED happens only due to driver removal when
>>        * bridge should already be detached.
>>        */
>> -    cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
>> +
>> +    if (!mhdp->no_hpd)
>> +        cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
>>       spin_unlock(&mhdp->start_lock);
>> @@ -739,7 +743,13 @@ static void cdns_mhdp_fw_cb(const struct firmware 
>> *fw, void *context)
>>       spin_lock(&mhdp->start_lock);
>>       bridge_attached = mhdp->bridge_attached;
>>       spin_unlock(&mhdp->start_lock);
>> -    if (bridge_attached)
>> +
>> +    if (!bridge_attached)
>> +        return;
>> +
>> +    if (mhdp->no_hpd)
>> +        cdns_mhdp_update_link_status(mhdp);
>> +    else
>>           drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
>>   }
>> @@ -788,9 +798,14 @@ static ssize_t cdns_mhdp_transfer(struct 
>> drm_dp_aux *aux,
>>           ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
>>                         msg->buffer, msg->size);
>>           if (ret) {
>> -            dev_dbg(mhdp->dev,
>> -                "Failed to read DPCD addr %u\n",
>> -                msg->address);
>> +            if (mhdp->no_hpd)
>> +                dev_dbg(mhdp->dev,
>> +                    "Failed to read DPCD addr %u\n",
>> +                    msg->address);
>> +            else
>> +                dev_err(mhdp->dev,
>> +                    "Failed to read DPCD addr %u\n",
>> +                    msg->address);
> 
> Is this intentional? Earlier dev_dbg was used. Now the "normal" case is 
> dev_err. I think we can keep it as dev_dbg.
> 
>   Tomi
> 

Hi Tomi,
Earlier there was a discussion in v2 regarding the log level in 
cdns_mhdp_mailbox_read for the normal case and our case. I was trying to 
derive from that but keeping it dev_dbg for both the cases seems to be 
the best choice over here. Will send a next version and fix this.
Also please let me know if any more changes are required so that I can 
plan the next version.

Thanks,
Yashas D

