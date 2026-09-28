Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C583CC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D05E10EA31;
	Mon, 28 Sep 2026 11:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XOIPMFaG";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eKbVtTCA";
	dkim-atps=neutral
X-Greylist: delayed 2360 seconds by postgrey-1.36 at gabe;
 Mon, 28 Sep 2026 11:48:39 UTC
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C53C10EA31
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:48:39 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9Kc5A1131888; Mon, 28 Sep 2026 06:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=0hS9Wztf0zHLIHXI8FAVpAGINXt34rvbRVblpIEIs
 QE=; b=XOIPMFaGqLhFEDGDHZqUwmYjGL0j82YJPmT1RVFjnleBchTDI0v/+/KNn
 41iiHEO7Q/9gaxqGPyvnGZpz8vOmH2A3Iu87psPeFCjsu7Z/yoFpEgHbWgzf+FI2
 MMvsWFaZ6DhFF0oB6jBwHiGLDWB9NoJ0KPYSR69LiHszFRY5db7orHornApFywU2
 xMwCujornn+3BdaVrswBFhgclX6FCjz4YW12uIFpP69FFyR/tPn5EQBzgxGespLs
 SXB8lqzpxMPWPhSgpS6NJFnixGrHk2TRU3iziwdLah6jJeQbZ2J4HMHXMbl8snLL
 7rTeptxTIhwdyBsfIsIMr0rDs/FCA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gxw6nwjy1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 06:09:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruJ+TH2qnpun/Iw82z5iVknAeqjwkeP7ImqvmipxxHO/ibh6xyzpLAeORMQS8g1lX9ooLu9jN5lwIRbtjjpMlw4aOOdFKuZXl9UN2AjOiC8BfZ+d82GJlbynrEL9yLFF2dwa+sRL+65MRj4dKxwOSSi2GM6lsoyq5eo//vxogJgBtjWrMHmYjuF0pU05p5yrtr2HYFpaVa9EiMlj+bXAfxCrE+1Zg0hZhv0lqqLieu8C6rM6H6GcpaUKTN8Mv7keFtonLzCOmwR7DUN6gUtrl2n9kzckbj+mtlMuyiGejsOitvzPyMseZXTvztGlfKsJh23xtFCIfbnQAtx5aDkt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hS9Wztf0zHLIHXI8FAVpAGINXt34rvbRVblpIEIsQE=;
 b=nNoqTxCxyHnQPf/8XgjgkgJiToJnK/5K8tngGhcrzArJn9Sm7CBNQkth+nx0xFBtfneIZ4d9ulKb/G77F96LUNfeu/KYSNud6Q2FpcJcM2SrM2YMUGGzUBzdkZVHEmJEaCcal3qQDsXISZs4tCrhu7aiRi5wOi6peNfHbQAjRDrfJGbbp2lGvcHGkbl5j9NTdIorxKiPeEVU9VtmWtfH8RT86eYxCXE4sNArAZQIcD3WK9a5Y9/VuUdSQvLoJZ+kWXEZODLqmByGccoUvVUD5+SbkOpFDs/g1ADf4bSDHNjYDnQd/uB+ArGXBmwmupIqVgjfAp/wBxRAWgt/3wl4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hS9Wztf0zHLIHXI8FAVpAGINXt34rvbRVblpIEIsQE=;
 b=eKbVtTCA5oKPJe96TvXqJurBQZ3puIsL85Yyr9AJ4FopzjRHkEyYYrDB7zD2qKR7WG6scKkNIdHNWaGvo+k5QH0JfpmwG9OGNnbqjywzzLQRwkLKJXXKnKwfrFOt88WswVdZJ2FVvkcSd7yN3Q25ucLHBsD/ZozPFhvTAmKyiig=
Received: from MW4PR02CA0029.namprd02.prod.outlook.com (2603:10b6:303:16d::34)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Mon, 28 Sep
 2026 11:08:58 +0000
Received: from SJ1PEPF000037A5.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::76) by MW4PR02CA0029.outlook.office365.com
 (2603:10b6:303:16d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 11:08:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000037A5.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 11:08:56 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 06:08:11 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 06:08:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 28 Sep 2026 06:08:11 -0500
Received: from [10.24.52.205] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68SB86hE3008926;
 Mon, 28 Sep 2026 06:08:07 -0500
Message-ID: <40d65442-d290-4a71-b680-bec42a771586@ti.com>
Date: Mon, 28 Sep 2026 16:38:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] drm/tidss: Preparation for AM62P and BeagleY-AI
 display support
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Devarsh Thakkar
 <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>, <dri-devel@lists.freedesktop.org>, 
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A5:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: e6661600-778a-4bcb-c72d-08df1d50e3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|56012099006|22082099003|18002099003|10067099003|3023799007|13003099007|921020;
X-Microsoft-Antispam-Message-Info: fBgi9oGvygwbFxsi/ESCcf1Dj8JiSAFJvEudENobXkYfhRkO3LUS91cARWVUXtgT9lHa//IV7YG2r5V1SN0rmDjF7EqslLUnvwsUGF66ktLxshWBJDJU6RmB5DnxdQJOYc+vTywODkXcQKhN/2Ssi1pElNzY5Rj2P0b+z4SPjbcWm6smqtQwBMS7oCdTGR/DWfsSQYYit2tILWQxRPZLHQxovdfryIyD1bxfRohGrbPSatY+vtC6jSBYCnGg+kLDZQvpb91JN+Wjn54dtWLQkFuKXXxOUb3AMrme6s8IhbIWaeUjp8zV3h0H/Fh2weHah9JIHGs/9HcwNT5J3atmSyK4xrbfUMKpa7hGOsBvVmuGUSdN4TuqV7mLXab78ndul96sRPCYw8aLPyADujRk9S0d1aNZR8DjdhCQ5z8FoEPcpPGMjGLPH6X6jloPAYMHctpJhyZifLVTyDWbXsAqZtGsZj329Zib2nYL0qC33gSgKtlIk0m/tYXffTa1ahlaUycfFsa00F+YreF+3jwLGqMCo5A35JNwjx6igYK//9HXgCzHAzppRG0pyw4L61LhiMzDdJSTUYP9rEzEDFHN14giKxZZ6WFmabwTUEjegWGbaq4MTGQnH4/pKDx0b/96OpfnU8ehsfUtx3vMA7wqAtXPf1hZ/ud/gDJeC0UpjpVvOYuCmxgp4wegl1KhMT5YQFmysxWJrH7NDnLBiZwTZu0zW88F9fzNNGxyMTbtzStIA+dnR15TMlekr8V8VcTY
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(56012099006)(22082099003)(18002099003)(10067099003)(3023799007)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EnbEVkymFj2aiETkm1u+nTCrlSTMEzP7F2M0Ke8ya71W2hZAHP+E7oJR2+E/YYHG4YdaEu7RI4NeFf8QyRsqyMHtaKMzYh1iv0KeObD6FS7ucUtLems34ZCpOq5XReMDll2iJNvjupT3aGfB4QTq66WsDEubCrpj89LGbryZPZvt+M2gXeVPS05VPL3O87qzHBR66U0mhIcJ3TaJuoNIEUiL1+5UBbsvdiQ1RlbdmMQdvT5OcapII5cICSyTZWE+lICbBlyU2SG3OXqjecqOcysu7gwzt2bJtdBVvC+tyLX1fGDa7yaIgQ+LTcTVnWduOqYCr+AZ6IsVVX9nHu4DkYdpzEmG8qhLGZCQp2K8EDDJkewEfZwSoDE0uocw+yi8exKKQ4NxKlEfPVjdSLnaBWXZ4hzbTuYEdkggUE+4QDTT08nDaTyImT0LZ1B9V7RQ
X-Exchange-RoutingPolicyChecked: K//J19gc7DkUwdtXn7Q+9slr6ZkSgn8OX3B+eTW4rhsPZd8lVlgEZlwstqUZis52CM2MRQ13uIhXLlolxDL03AiXwHJuiChX5vjTQG+QWpgPF+QxxQCG98R4VxbCUWD6NAUtb7FrbqIimgpeBY7MBQARmdwe6YlTm64SA9VR7Htk6QT9g7bdJ1xGE78N4J85tSLcjENFmyxSeQqQ/ZLAa/rngzba8QJSqulnMDIy1Uxsj65NdmjVkbiFjIFAjTcLSVMOe9erFj7Fy7zmAul6PSVxi1+Mhnws0RIgwzRO3N1y5aGD9kHg3VEpAngTF4MVtdHAib9SmKa9c11rVhsnfw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:08:56.7339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6661600-778a-4bcb-c72d-08df1d50e3ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NCBTYWx0ZWRfXyIrDByeRK1he
 HcE7iUuTyottWAGpBBLeTkcvrE0Q/a4ngtrqjNuhfX4p8unNotJQpwyLnLeVxE3g8HAdUxWARH2
 tpSiaLCgdrzlvF5iG6BMyC452W5zwRw=
X-Authority-Analysis: v=2.4 cv=dbkVTnXe c=1 sm=1 tr=0 ts=6aba4acd cx=c_pps
 a=98eAHdF884nMI2WayFaxAg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=NEAV23lmAAAA:8 a=P1BnusSwAAAA:8 a=sozttTNsAAAA:8
 a=Yilb6PzjgOhoUNh-V8YA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-ORIG-GUID: VOu4l58fe14S-0wm9Ay8S0Sy3b7IU_uj
X-Proofpoint-GUID: VOu4l58fe14S-0wm9Ay8S0Sy3b7IU_uj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NCBTYWx0ZWRfXww3Kms3/Vpif
 KEm25etm7Qa2hwy5BfOvoU6oCHhOhzZ2sbzSrzzjquI0Y2R5ldIhqFwUaI9yc49OAFJ870RyvzC
 TyMap2H9zk4s54dvpw5IKuJXIjbplDWgNE+LqygVuF3laWdDDV3xtQeBrk6LidRVpgeKtr+6v9k
 xdUpPfniqaeoZJm44p9d1jYML83vLjk7KDYz3TQBmYd02/eUdAMmGV2GeqsXbf6MTIFXsVPQKCI
 J5+R7B1wu6kdKHbxTjriGpHbcBGaU6WE9VpbHnRSxX62ixwwciIOOWWsCK0f2gV2YiLD/BOd0u2
 VYdzL6ms3zaLAXPOkGWNGbIWVfUyJK0f65Bh+86uCumEUfsY1aCPeV6AL1UjahNYSkhbTQ+eFRS
 PX48g9xKi8RdUP0ywQbASedchuOSu6eemlmuLAtrNWq1TAMKQBeV879knQATTSpYbhjTMx8+cYL
 ioU7yVUKV/q9OpJ5odA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280044
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



On 9/3/26 17:39, Tomi Valkeinen wrote:
> This is a reduced set from the original "[PATCH v3 00/15] drm/tidss: Add
> BeagleY-AI display support (and some more)" series, with a few new ones
> on top. I have dropped the patches that still have unresolved issues.
> Essentially that means AM62P and BeagleY-AI support is not added in this
> series, but all these patches stand on their own and are needed for the
> future AM62P support.
> 
> Most of these have already been reviewed.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Tested-by: Swamil Jain <s-jain1@ti.com>

Tested on AM62L3 EVM.

- Link to test-logs: 
https://gist.github.com/swamiljain/d37a2170d9c252522ac62967c23e6af0

- Link to test branch: 
https://github.com/jainswamil/linux-next/tree/sept_AM62P_J722S_patches

> Tomi Valkeinen (10):
>        dt-bindings: display: ti: Move ti,am62l-dss binding to a new binding file
>        dt-bindings: display: ti,am65x-dss: Simplify binding
>        dt-bindings: display: ti,am625-oldi: Add optional power-domain for OLDI
>        drm/tidss: Remove extra pm_runtime_mark_last_busy
>        drm/tidss: oldi: Remove define for unused register OLDI_LB_CTRL
>        drm/tidss: Add mechanism to detect DPI output
>        drm/tidss: Add support for DPIENABLE bit
>        drm/tidss: oldi: Fix OLDI signal polarities
>        drm/tidss: Drop WARN_ON() from tidss_runtime_put()
>        drm/tidss: oldi: Fix missing of_node_put()s in error paths
> 
>   .../bindings/display/ti/ti,am625-oldi.yaml         |   3 +
>   .../bindings/display/ti/ti,am62l-dss.yaml          | 136 +++++++++++++++++++
>   .../bindings/display/ti/ti,am65x-dss.yaml          | 149 ++++++---------------
>   MAINTAINERS                                        |   1 +
>   drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
>   drivers/gpu/drm/tidss/tidss_crtc.h                 |   4 +-
>   drivers/gpu/drm/tidss/tidss_dispc.c                |  28 +++-
>   drivers/gpu/drm/tidss/tidss_dispc.h                |   5 +-
>   drivers/gpu/drm/tidss/tidss_dispc_regs.h           |   1 +
>   drivers/gpu/drm/tidss/tidss_drv.c                  |   7 +-
>   drivers/gpu/drm/tidss/tidss_kms.c                  |  70 +++++++++-
>   drivers/gpu/drm/tidss/tidss_oldi.c                 |  46 +++++--
>   drivers/gpu/drm/tidss/tidss_oldi.h                 |   1 -
>   13 files changed, 323 insertions(+), 138 deletions(-)
> ---
> base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
> change-id: 20260903-tidss-pre-beagley-5d22a69b2269
> 
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 

