Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC37C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405FF10E51D;
	Mon, 28 Sep 2026 11:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DcBxv8VZ";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EtBb/jwJ";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB5F10E51D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:58:11 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68SBAmgP1608615;
 Mon, 28 Sep 2026 06:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ScdbwFvfxVzGvAmgdDRdN3al6apXxCvU/s4zokQBN
 ag=; b=DcBxv8VZAW7vpD7xBpRmgy5LkB+8B4v/zLVx19vqyz5VPXcB+fm5ptfQS
 LLjrA4m64i5qjeuZKX/UVJMfISPykIwmcmMLl9c0R+09s2zFuAuFOcFCOSHG9yw3
 FjwbB4jw27U24E1J8tMDQBPNOnW2Tqu5NTyN48WYxa5cgZmFdDFVi0zf+fSrwlFs
 R9VnnoTaaOAyOuGxO+LYpNbzdy4BqftY3xp0/YN36VDXgUGGjbw6Nxd8lRtA+KIG
 AJ054WqwzYs9D6htN1VMWiTr40exjnTH/YGxJYbxZXxmh6BHWMtnGfWWKaNSmXuh
 jD85KVREZ4wfl8JCvlC+KsYJNGjQA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gxy2nnh01-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 06:57:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXCfeV9it5c1KfPd1g4E+0uN5PryBUqhBqgz7MRvpFNyjbx/mLqeH1j+3mQXBQ76PuNfuvf6ea+c7EPc+y2vGYK17g1/H9C9oWxzLrhAsdEMd5YM2OSui+KevZktcjFw2tS+F8IZhV6Ko75gq526iDUV2w4FHvAP1uppyoNceAE0++aBBGTV9eb3opF/80rtQF0Qj+5WN7xJxm0T2AOalL+DtreBQA3jlRRmq009Xz8ggKOfY7AKx2Duv3z5t5yW/mBVlq6kpFD5h9EhJlNEgnx6JEssU84mLHeDgee8QPZul2QZpdK3gN9Lh5Buu6cSB2VLq+K/CJ6kEJqcZmFJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScdbwFvfxVzGvAmgdDRdN3al6apXxCvU/s4zokQBNag=;
 b=s6Zi60tGIA/+cUnnTZmZW/gmUKqejnygxTagTfyD65agHMzz9ulak8cpiuSV9fqF4r1Z4T9h9kgXVfWTm7rs6iA8tIiaTGCSC+APxbU1MkijQP5alXxLZfHY3nHM+QtInbIOAlVNPpOBcR1h12U3In2Sv8SoUh7F6nJGT/XgpZi65VhRo7QjllMJv/OzYAUDQwW7+eOp/sdpdri8d53Pb0grYrl+poF+dqDmIw1G8+WNAvz1u+sUTJmRxYpps5Q0jLccJhDd6oUrd/2GV0m+26WpeZRNlGxysiA5o33LYeRyyROe47euOFT9dytcQqfePbce0uIyA5484hXKtizwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScdbwFvfxVzGvAmgdDRdN3al6apXxCvU/s4zokQBNag=;
 b=EtBb/jwJJ2bL3wP9GxWC/JUW6nU+DJ9zMxiIZyuMzF7BSrMG20dbb8KszTzsNajPajvbQ5eSxNTHr9A995dtRxAAJnVsKh8J/Qneldkyo+seFiIXYtRcJO9GGyHXVlNIyLHpfcnJVrjORiDT5omkaDw2S0jJverGrzT9QFeNFQU=
Received: from BN9P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::20)
 by DS4PR10MB997550.namprd10.prod.outlook.com (2603:10b6:8:31d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.6; Mon, 28 Sep
 2026 11:57:54 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::79) by BN9P220CA0015.outlook.office365.com
 (2603:10b6:408:13e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 11:57:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Mon, 28 Sep 2026 11:57:52 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 06:57:21 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 06:57:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 28 Sep 2026 06:57:21 -0500
Received: from [10.24.52.205] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68SBvH6A3069609;
 Mon, 28 Sep 2026 06:57:17 -0500
Message-ID: <ef825818-87b3-41f8-8f7a-372076ecd656@ti.com>
Date: Mon, 28 Sep 2026 17:27:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/tidss: Add mechanism to detect DPI output
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Devarsh Thakkar
 <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>, <dri-devel@lists.freedesktop.org>, 
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
 <20260903-tidss-pre-beagley-v1-6-93928baa8b12@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-6-93928baa8b12@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS4PR10MB997550:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fcb986-7845-458b-2e62-08df1d57b99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|921020|3023799007|10067099003|5023799004|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3IIh5UxwVZO4aAWQ9w7kLqdnKT2xMhNiSLHtaDREbRBrD6B3GRkImNJRHU7DlR2ln1BGWK1vZu0pcaQ28AScubsUPi0jL6vZxgRBH28Qu3gwqr4zZBSDr6yuvz1b3lEv45gmy5NSWDnFEgHySU39NtBmAztZvCwDhLoA1hYAEDE3//jy6og+RylEii2+ZguDguUC53s70mG7phng9+CA3PWeyToa2F753prjlH0ZR8dcwAkgKKpc4Jr+NhvpmPfx7AbNDxBavP+ngai+0qeRGE9POvH1uTMLHW44JCM81/GtNKm9cDShuME4WeX0JAmd6SZz9kDFGHhFsWuxRtFB46JM2WvcSpJEdUMzlFzGDIlQZe2yJ6JG9NgWqRStJ5OrjGLtLLRHR1xrHtLCVLRlmqkumdZJ9jNbAU2jMSagK+vOiNXUAUBMFQQwz9aAsU6LRTH4LzzSxTOThPwbGT91m1WihuWcLdrQx+yQbtXg0oAMlhQunvKxT0vY0+cZzGnfuPRd2fXW8rkCIlQ5WU2mhHAqmlu+dO+0DTeFNN2YPbGOcoa2ud+Si4DDZpETlH7hXkdoDj7ustLhijB+LCgTgxbsgadqSTWBrcU9y/+5BFghh2Cx6gcFDQmc6oUoSZWOVFGSm+p1/MBFRJb/eDiXC25L8Z7md0/WqqbQPTAWHDb895RHTDYPs/v2ySfBhb75HZ+kPvIdfqo20tj18ylLmVateFomX2uaHEsT09Qq/tyAo1sju2sYTaIkqk+ekSfj
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(3023799007)(10067099003)(5023799004)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dauGhoyXngmsJf4VhVoGszVq1zKoaiidvYzByJ41Xss5YYB9gQnaoIUoQlDz+Hj86gn9Pw3qI/fThnoxzocFO0rTiYfG7oG38gbO5Jlr8wtAX1HqeHdUdjo41RXrK90joEQLrvCUbg/2LjOWsyFn+bMBq5IC85scXC2uRNj5kPJpJVZ8etP/qZvSocrZnzjJswyR9bkSE+19zyygFcmVi4SeuA+nWJEqiqJIgBPTpt/3oSRZF+f8oi7FJfy4Q3U9tWReVfb5+bYx48g9K6aJF+g0CHcickJOpZ8PIzRNb3P3VlUI+Z3C6+vURtbVCj59xDXJBjpsMzJaO/L6sgSkg9ttT4UNORAXijXuaaqz5vO1LJVFGUU8/BZCzR+GCabnwr6SV9wUnucUPP6KbRzXyP2vwfTPwMEpBbT4y+FfjVIbA/bms+c+AZwAnmMZ1bQW
X-Exchange-RoutingPolicyChecked: HmShPBCcqQcTv82aonPBxJ4GPUHsTOR6EMLecHEZCqYEzK3ob3CSclPDWsQrXYq6UMe0rCzv9OgUGg2actOZPICZtbeCvZO1IL/EljnnLaF0xyFSA/vt9frgOHb9vji6Wswyx0ShANdC/8C8MS5JK25XrU8DJ4uCs1b4172AmBE2pL8OQqjKdIQFtCL6iOqwoRE72NKS5z1VEu7nVXBrtUBK9O1O/d7olBQ8TLhrnTZ0gmnjCbc6k7RRS2ioWDWBFgkFyq0XLOI9PUEsa6RczQStT2t45MUJoPmIRuSFyU7zLQN6Pf63wEw12nGgrAHGlnEa3dFhL5jOvzIgacKH2g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:57:52.1895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fcb986-7845-458b-2e62-08df1d57b99a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997550
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX9RyXxDMGJiza
 e9ql06KbsIw0ly5Q1UVdN42KojK747s1bS8NFt4caE+TlfLXtGCaUm6U17Nsj9QPxgS0o/BBL6w
 uHWsLBmM5iY6mBA1YaFam3P5hH3p9wQ=
X-Proofpoint-ORIG-GUID: 0MsJUxE9y9m2guTY37UJr_5PXxBajl6O
X-Authority-Analysis: v=2.4 cv=RLgmjIi+ c=1 sm=1 tr=0 ts=6aba5644 cx=c_pps
 a=B83JijZ7EzXLHUDiN273XA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=P1BnusSwAAAA:8 a=sozttTNsAAAA:8
 a=QNTgMZfpnKhU915D8GMA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: 0MsJUxE9y9m2guTY37UJr_5PXxBajl6O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX/VhBZVr3DKMg
 NJtdfV0n6rgPbShh4XxHxyf5IodSRXOxU2D4mB6nalrICD1fumI8fhFiFBN/BH7vQGV2CUhK2K6
 w6y4xHN+K824qflbNTkVk2v7eUrE3HhuNXSAhGyL+I6w/oNhR8cYL8sRX3kzN1e44QnEOn7GsyZ
 cW99iSCtlGLc6uB23nZ1AzkRfSP1SJqfJH3eK15Bx+ZRQjbq4YbPjQqndfWfddRbgZAs/QMXJNW
 XiCJA6KAyrtRRAsHw60oGH6RyXJRTXRLYJKu1rMcSjKhIkRtIjBDy2VFlPgQ461n40c7EQrsc9P
 u5wS51t8MpTUlyMvgd+Y8Ok0RDFR3R65GWlyjSnsy2t9QMNOhJjGYgiY1Ceuq5f01NtDZ/GOHKY
 o/wL7qOwcy9wg6n2eQxtPDnC7GgbInXB8TMZDUmgo/jmpffWbODXUzi+1CUKxcfHmrTEk5/VeNX
 f+qtTBjL2Vgav+lnzpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280047
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
> There are situations where the driver needs to know if the output is
> going to the DPI output or not. There is no trivial way to get this
> information, as there is no "DPI bridge". We can only find this out in
> reverse: check if the output is NOT DPI, and if that is negative, then
> it must be DPI.
> 
> At the moment we have two non-DPI outputs: DSI and OLDI. DSI always has
> "ti,j721e-dsi" DSI bridge connected to the DSI, so we can use that for
> checking. OLDI doesn't have a compatible property, but we can check if
> the DT node has "oldi-transmitters" node as a parent, and the dss node
> itself as a grand-parent. There's also a special case for OLDI, the
> AM62x OLDI, which uses an older design that requires a special case in
> the detection.
> 
> If the output is not connected to either of the above, it must be DPI.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_crtc.c  | 10 ++++--
>   drivers/gpu/drm/tidss/tidss_crtc.h  |  4 ++-
>   drivers/gpu/drm/tidss/tidss_dispc.c |  5 ++-
>   drivers/gpu/drm/tidss/tidss_dispc.h |  3 +-
>   drivers/gpu/drm/tidss/tidss_kms.c   | 70 ++++++++++++++++++++++++++++++++++++-
>   5 files changed, 85 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index 400329aa2200..ae9c66831b6c 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -192,7 +192,8 @@ static void tidss_crtc_atomic_flush(struct drm_crtc *crtc,
>   		return;
>   
>   	/* Write vp properties to HW if needed. */
> -	dispc_vp_setup(tidss->dispc, tcrtc->hw_videoport, crtc->state, false);
> +	dispc_vp_setup(tidss->dispc, tcrtc->hw_videoport, crtc->state, false,
> +		       tcrtc->dpi_output);
>   
>   	/* Update plane positions if needed. */
>   	tidss_crtc_position_planes(tidss, crtc, old_crtc_state, false);
> @@ -235,7 +236,8 @@ static void tidss_crtc_atomic_enable(struct drm_crtc *crtc,
>   	if (r != 0)
>   		return;
>   
> -	dispc_vp_setup(tidss->dispc, tcrtc->hw_videoport, crtc->state, true);
> +	dispc_vp_setup(tidss->dispc, tcrtc->hw_videoport, crtc->state, true,
> +		       tcrtc->dpi_output);
>   	tidss_crtc_position_planes(tidss, crtc, old_state, true);
>   
>   	/* Turn vertical blanking interrupt reporting on. */
> @@ -414,7 +416,8 @@ static const struct drm_crtc_funcs tidss_crtc_funcs = {
>   
>   struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,
>   				     u32 hw_videoport,
> -				     struct drm_plane *primary)
> +				     struct drm_plane *primary,
> +				     bool dpi_output)
>   {
>   	struct tidss_crtc *tcrtc;
>   	struct drm_crtc *crtc;
> @@ -427,6 +430,7 @@ struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,
>   		return ERR_PTR(-ENOMEM);
>   
>   	tcrtc->hw_videoport = hw_videoport;
> +	tcrtc->dpi_output = dpi_output;
>   	init_completion(&tcrtc->framedone_completion);
>   
>   	crtc =  &tcrtc->crtc;
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.h b/drivers/gpu/drm/tidss/tidss_crtc.h
> index 040d1205496b..65df220698f6 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.h
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.h
> @@ -20,6 +20,7 @@ struct tidss_crtc {
>   	struct drm_crtc crtc;
>   
>   	u32 hw_videoport;
> +	bool dpi_output;
>   
>   	struct drm_pending_vblank_event *event;
>   
> @@ -44,5 +45,6 @@ void tidss_crtc_error_irq(struct drm_crtc *crtc, u64 irqstatus);
>   
>   struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,
>   				     u32 hw_videoport,
> -				     struct drm_plane *primary);
> +				     struct drm_plane *primary,
> +				     bool dpi_output);
>   #endif
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 58d5eb033bdb..c21ac3f51720 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -448,6 +448,7 @@ static const u16 *dispc_common_regmap;
>   
>   struct dss_vp_data {
>   	u32 *gamma_table;
> +	bool dpi_output;
>   };
>   
>   struct dispc_device {
> @@ -2770,8 +2771,10 @@ static void dispc_vp_set_color_mgmt(struct dispc_device *dispc,
>   }
>   
>   void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
> -		    const struct drm_crtc_state *state, bool newmodeset)
> +		    const struct drm_crtc_state *state, bool newmodeset,
> +		    bool dpi_output)
>   {
> +	dispc->vp_data[hw_videoport].dpi_output = dpi_output;
>   	dispc_vp_set_default_color(dispc, hw_videoport, 0);
>   	dispc_vp_set_color_mgmt(dispc, hw_videoport, state, newmodeset);
>   }
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
> index 739d211d0018..6f53d554259c 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -131,7 +131,8 @@ void dispc_vp_disable_clk(struct dispc_device *dispc, u32 hw_videoport);
>   int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
>   			  unsigned long rate);
>   void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
> -		    const struct drm_crtc_state *state, bool newmodeset);
> +		    const struct drm_crtc_state *state, bool newmodeset,
> +		    bool dpi_output);
>   
>   int dispc_runtime_suspend(struct dispc_device *dispc);
>   int dispc_runtime_resume(struct dispc_device *dispc);
> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
> index 70c14c3be10d..eefe2221bdde 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
> @@ -122,6 +122,68 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
>   	.atomic_commit = drm_atomic_helper_commit,
>   };
>   
> +static const char * const tidss_internal_bridge_compatibles[] = {
> +	"ti,j721e-dsi",
> +};
> +
> +/*
> + * Detect whether the bridge is internal to the SoC or not.
> + * We detect this via two means:
> + * - If the bridge's of_node has a compatible, compare to known internal values.
> + * - If the bridge is a grand-child of DSS, and has "oldi-transmitters" parent.
> + */
> +static bool tidss_is_bridge_internal(struct tidss_device *tidss,
> +				     struct drm_bridge *bridge)
> +{
> +	struct device_node *parent, *grand_parent;
> +	bool is_internal;
> +
> +	if (WARN_ON(!bridge->of_node))
> +		return false;
> +
> +	for (unsigned int i = 0;
> +	     i < ARRAY_SIZE(tidss_internal_bridge_compatibles); ++i) {
> +		if (of_device_is_compatible(bridge->of_node,
> +					    tidss_internal_bridge_compatibles[i]))
> +			return true;
> +	}
> +
> +	parent = of_get_parent(bridge->of_node);
> +	grand_parent = of_get_parent(parent);
> +
> +	is_internal = parent && grand_parent &&
> +		      tidss->dev->of_node == grand_parent &&
> +		      of_node_name_eq(parent, "oldi-transmitters");
> +
> +	of_node_put(grand_parent);
> +	of_node_put(parent);
> +
> +	return is_internal;
> +}
> +
> +/*
> + * Detect whether the videoport's output goes to the DPI output or not. There is
> + * no "DPI bridge", so we have to find this out in reverse: check if the output
> + * is NOT DPI, and if that is negative, then it must be DPI.
> + */
> +static bool tidss_is_dpi_output(struct tidss_device *tidss, u32 hw_videoport,
> +				struct drm_bridge *bridge)
> +{
> +	/*
> +	 * On AM65x the OLDI TX is modeled as a part of the DSS itself, on VP0.
> +	 * On other SoCs OLDI TX is a separate bridge. As there is no DT node
> +	 * for the OLDI TX on AM65x, we cannot detect this from the DT data, and
> +	 * have to special-case it here.
> +	 */
> +	if (tidss->feat->subrev == DISPC_AM65X && hw_videoport == 0)
> +		return false;
> +
> +	if (!bridge)
> +		return true;
> +
> +	return !tidss_is_bridge_internal(tidss, bridge);
> +}
> +
>   static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   {
>   	struct device *dev = tidss->dev;
> @@ -133,6 +195,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   		u32 hw_videoport;
>   		struct drm_bridge *bridge;
>   		u32 enc_type;
> +		bool dpi_output;
>   	};
>   
>   	const struct dispc_features *feat = tidss->feat;
> @@ -149,6 +212,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   		struct drm_panel *panel;
>   		struct drm_bridge *bridge;
>   		u32 enc_type = DRM_MODE_ENCODER_NONE;
> +		bool dpi_output;
>   		int ret;
>   
>   		ret = drm_of_find_panel_or_bridge(dev->of_node, i, 0,
> @@ -160,6 +224,8 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   			return dev_err_probe(dev, ret, "port %d probe failed\n", i);
>   		}
>   
> +		dpi_output = tidss_is_dpi_output(tidss, i, bridge);
> +
>   		if (panel) {
>   			u32 conn_type;
>   			int ret;
> @@ -205,6 +271,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   		pipes[num_pipes].hw_videoport = i;
>   		pipes[num_pipes].bridge = bridge;
>   		pipes[num_pipes].enc_type = enc_type;
> +		pipes[num_pipes].dpi_output = dpi_output;
>   		num_pipes++;
>   	}
>   
> @@ -230,7 +297,8 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   		tidss->planes[tidss->num_planes++] = &tplane->plane;
>   
>   		tcrtc = tidss_crtc_create(tidss, pipes[i].hw_videoport,
> -					  &tplane->plane);
> +					  &tplane->plane,
> +					  pipes[i].dpi_output);
>   		if (IS_ERR(tcrtc)) {
>   			dev_err(tidss->dev, "crtc create failed\n");
>   			return PTR_ERR(tcrtc);
> 

