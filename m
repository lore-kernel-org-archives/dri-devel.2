Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321D3CDB47C
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE0110E063;
	Wed, 24 Jun 2026 10:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yuj97gqw";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Gm6g7yyR";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3C110E063
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:39:48 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAOaF7204133; Wed, 24 Jun 2026 05:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Cfc6UyH+sMFO9ZMeOjseYBPDzyxIOVtQLc5yMuHN6
 qk=; b=Yuj97gqwEqxa4wrgwCZvw0PgZZykBfSnXNGq1Q2SUNWYnp4sDA9i+4Sl0
 1Ptyx7/94JxcNAX3Av4fFPblOUVkhnHyt9CnC/LaFmdR1XqYoZ7R/rATDCKKjMmZ
 Brny1Wc2yCae7ZxwBItxf6UlSAyI+5f3kS6cBqum02wNQv2EcbCpJYEE4+fCmjln
 U/KFe/jBVtCFvuSu1TiekE7HqCkHk9aCnx2EHkXE8D7qAMbw2EyWzn2xMRFriBBo
 qXICYWI+L1vk/9dR6FbV6ZqMo43d9e1XN16Fe3lB+0fSmBNX8e6yaO/NmNNJ9gxG
 kdaSbil9FDjG7P/ic/l+44qS8PsUQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f0asp8vwj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 05:39:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLBHxYxs4gyiWEiQGde5hHV6Xoda2N/FiAzHCnA8WDPYWAx45WAtiJE04rGH+du6tJjbA5/xvga67GpGTzi9PhJx23yYWbH5S6UalyqjeF6AYQhqrkXHQ/UUTU2KbBTV1pASVnwL2O6JHBmGHz0qlYXX7j0xsAmrSxYU+yYBE4LT165i+MlmqgUs5G4zS61TAXU7L9+O4aXoGEyqW+eSXQaMnj01uARawh1J9SWGuLbPJlGPQu2MGVSq+j+N2D8WGKN/vWRMQOnl81cNqa5TEi7zoDUkFvbn6+TCUtskc2Mua1eZjWZnXFYC0PX0sf5eazUifDaYJh3mRQxJOKBPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfc6UyH+sMFO9ZMeOjseYBPDzyxIOVtQLc5yMuHN6qk=;
 b=xTNK3sLArgi/nNVjrk1G4v6f4tGtGO143pjV9/CFxncMQ5Irgifcx8nsPaLGibf/BlJ1WxNOIsvKruEhBSQRDPVqXfDgVdOrwklMWQJADsy/hBMv/E6FTWpTNFtcDmBwuukE3w1DzoPUZas+lI22KJbUdcL8T7L4ilcinIhkhX+ojBYHXP02DqakcpYpuKThMATJBbk6hSMqAm+6GKQrpuYbDvTVZCfx3YxKCccBQOv75q5z3EOAzL42fjybUAEiZTVuGM7puT8WuOaUtxJKYyzoOG4ConJSEeRQ4fUS2xzjMkTREV2+Y+mJGkxRUl4eU5gfMeLg+dDkDVwY2OtbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfc6UyH+sMFO9ZMeOjseYBPDzyxIOVtQLc5yMuHN6qk=;
 b=Gm6g7yyR6YW8BiOHdIgwBjyZg+SN4XW3BQP+UmkZ3PDD7wFUihXXNUuRKwobBErXnzJ5ELuvfovKqIOH69cvnxjlzV8cF7xfw0xISp8MYs6vtGX5nKmV1u9tOAQ8ve0fEV4HYNG6TDbuyOhe2k/BTuUdW1WhoZuWkHwX/qYD/c0=
Received: from CH3P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::11)
 by IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 10:39:34 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::20) by CH3P221CA0001.outlook.office365.com
 (2603:10b6:610:1e7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 10:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 10:39:33 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:39:33 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:39:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 05:39:33 -0500
Received: from [172.24.20.59] (ltpw0bk3xf.dhcp.ti.com [172.24.20.59])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OAdRDT820059;
 Wed, 24 Jun 2026 05:39:28 -0500
Message-ID: <496a2a43-3897-4c32-96de-f7a5dce5a9ce@ti.com>
Date: Wed, 24 Jun 2026 16:09:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] drm/tidss: Remove extra pm_runtime_mark_last_busy
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
CC: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260529-beagley-ai-display-v3-6-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-6-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|IA4PR10MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2ce5f0-2ede-433d-30bd-08ded1dce195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|56012099006|4143699003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uqiHUSA5isxaxBDx7/3OKPYWgyZ+PILvc/LnKhXPKEo4hwpUt/guiL3W42MS0ErObJS94w0RiKGm6fX/tEh53EpaVrZ13ABZcHbcc72VePz5hOvOmz3Jg7oyd9r2ZGPXhmI/XiCwFgD/aVq1xNrURc6M8rbzuWx6e5Ygn77rHrnqPdcp5z/hYfyEZ64QqVoQCsp9QDZND5/3OyuJqHSJkgIP8F7ECW9Ka3nGwn6caV503YhqW+MORD4GH2rAqken6aVrQR+37yDwx49s11Ok0iCoGGlc1jjjhyNC8RaKSrFGGRwtyZSgFysKDMEtkInCxR3QT+TeK2Ami+8vyAt8Lae1WE295upcGE1PK2yDS0KIsad1fXg4AUhmbF5z9ppxMiZc1ZCttNvIBhPCZIJyIdm9Zml7YtXQtlnXCTvmMHEQqHBwJl1T97E6q/Fu0T/3UGztSKbtqGD8bBTMZ1sdoiB+qzIa7U8PahEUV4I1Z1UFsMLUBYiF/Kd854YaZEeZIqyzpFPRxMfkkvsPHrwnPqPuL9oyttX76ypW36Qyez5wRwdt5FP2fuaje0X2l+GKTjY35SInJQGwRMbdhtiHhubcuq0SOy3bVmJOcf69znUZw+esLyCj7jLFaF6ItCLSIfv4oAPBw5qV2T/yUxc1zApJxHg/WkEC2rphTN2oRU3Egw4keAd77jpLXK2X3k8PcmG8E+Fyu4lPMzPlQXWNA3nzi73syLh2czvViPMBtyR6OqckYsO3UikYq10+2VYF
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(56012099006)(4143699003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NC/3+WsMnsbSrpyuvBrHCbCubFh/3iJNRCDN/DPNRO8NVKOEcYIAhSQ2CEhGKhC71RuBS/B4m6xDNAxCm6strnfQxGeUsNfwr3DFAsRD3y6R5eTsYorAqYjmrHog924CZGeDakxzvJfsvzDs6dqryahrT6gwxVmIA5Pa+EI7eACfi2uwem5qNfqma/WNImAm6rPS6ic8qB2f7i1J9fFj2kYLAM4lEOxCmVc5rhP58zU0AGwxJLwZqe3F8Jj+wvxxtiwF1qXnma/gGHNoXmoFloyoTGPVHgKG44RTualsZgn8pcQqwBpOjRQ+TcCGSK2sGGpPIIj5RVJLS8431KM3KgaTaDzIPgTl6OaK2fLYTd5cGD+Mgy2oPRS5HICQwnYpXrpRyTPuGZ6FVRIaQQR9W+NmdCacZBOiqmDCbIOdaFaztucRdWOUghG33tywoiq/
X-Exchange-RoutingPolicyChecked: ks/5Oz6CemECtZaVx4bD8AS5nK83iLrFHlXKlkrq4Mk43bVIOO75G4qU0Yc7af44h5KsRG+yNpdndx9pUymdbByJOpw5Vfgd2q+8DtT6y7blj1BvulxS044zrLw8/3hVpmz/MteYJjNacO/2nMgKzLfJe6T95GLNwu5qi84+j/+pzt6hTf8LKcvPKM7hcCSbVCmGjApPfx1TKH68gA0gCIIbWRI9ujhKKx/vAMTFDpKkue4TeHiAtFUY+17DvcjZ21NBU8oyUidxHIJHe/KPQ/jkL40AjqJEdnwX0nI2XzZ//QeqljvWbLANvs3w6P6uSoOtoLYGt9B9Z88vOR7tFg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 10:39:33.9824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2ce5f0-2ede-433d-30bd-08ded1dce195
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8421
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfX3WymNPup6Zmz
 u0NkJSWL7qS9ra8Gc8HJlNnjtYEurl8cgMRJ8vc0wXZdse6uzHMSCCWtM57PDOFPWP0ymGY8rWA
 U4wWsMdzRxcNJ+c2zHYsYA4kD8XUeUED/6NuL6vj4fp7UR1aSwW2gmIdBBV+cnkQk/MSwosAUar
 IBLqfPBVqcSEsvsjshbPBEPnNGQnFXGXr3zUZsQqXq9kSzrdLPPmNbtsi6PXnMhwzcLEYZ6UXlR
 kU7qrIXLKFwIX5Ht5cGfOKMZW3iFXxsyZXEZ0blFRR5DZedxTpFMsA8Q0ILaBrWvYUbMntw8xbX
 xyjQh1aZZLVNoaHh6XcBsHONK3Oz0TIysQN5EOx9RO1u9iXI1QLmO8uhcsTX6KfXvKYKJgtOX/g
 s2AC1cS3cGrbufkWLxnZO97TRCCwM0FJJkCq9O2yG8OZfPJOGj6fVMcMs/I+pJn2HIwKMaaC7Mv
 1cHPdf4w5TMNBlOnGHQ==
X-Proofpoint-ORIG-GUID: gGN50LUee6dJ6wHRyIp-f_xUWW1aVTiO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfXzVtDgRCJiTMT
 WBbkZD8tqrInk87J7pTJNuLw4tk+wJ6UAvMOl61OmxRC2OZVVqQR4q1NFQQD6EIyrUhnSyIqEwn
 oOhZLpi4fhgaAtBXrBror3OPJVidY0U=
X-Authority-Analysis: v=2.4 cv=RMCD2Yi+ c=1 sm=1 tr=0 ts=6a3bb3e9 cx=c_pps
 a=26rO91Bbw6QoawbNyte6AQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=P1BnusSwAAAA:8 a=K6z539DFdsIhlQz4N-oA:9 a=QEXdDO2ut3YA:10
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: gGN50LUee6dJ6wHRyIp-f_xUWW1aVTiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240089
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



On 29-05-2026 14:15, Tomi Valkeinen wrote:
> pm_runtime_put_autosuspend() calls pm_runtime_mark_last_busy(), so no
> need to call pm_runtime_mark_last_busy() explicitly in the driver.
> 
> Tested-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_drv.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index 1c8cc18bc53c..5cb3e746aeb3 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -42,8 +42,6 @@ void tidss_runtime_put(struct tidss_device *tidss)
>   {
>   	int r;
>   
> -	pm_runtime_mark_last_busy(tidss->dev);
> -
>   	r = pm_runtime_put_autosuspend(tidss->dev);
>   	WARN_ON(r < 0);
>   }
> 

