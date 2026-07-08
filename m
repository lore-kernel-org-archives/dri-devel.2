Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E457C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767AE10E5B9;
	Wed,  8 Jul 2026 12:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gC/UTGyG";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P6sYAUf8";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C3110E5B9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:16:19 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C4Z0O2255269; Wed, 8 Jul 2026 07:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=IlRB0Bb5scN8qJiFO8r/F7BsFMGfmxNxuIMkXg4lV
 u0=; b=gC/UTGyG4yKJsX5aEYXX5uWnpKJUhlW48+2g6SYiVGKYMob7Gp7+o76b5
 tfJVQu5UMREshbsLFxiZCSju0pgVW9xwcC39v8r4EjZ5FQWDIMG9c34Lhs0fRmKf
 TO5/AxPUo40V41amzk/7//eJOiepryeidkfG3i2EJONWFpwPBs3PcWhlxQbDwBn4
 oec7CgWJeynq9lUgE1QpLne/p7m7TuwpRTO4JCNJ3uP9U/XSF8w0qB1OsLZ+x/+d
 LvlatRZFOnLCc/wiQ2URwGJZqhG4GDAAwuGYCKzzxbDRJgkTlP5tKY/PMmjatg8T
 XkrQwJMm/XgSR+xKmOXRrY6cMQljg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f9kxk8qys-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 07:15:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SluhlH9256nV9PKH9yGyOfmQVCKD9tnkr7zBvzybnCcSBLOJgCSgJ2/s6JMIUyDO+5/HxHJYFYHHSg7Cm2oBz1TeiFlj3KJD3FmCQLJIwGtlb7VVxhSZov91vdMHHcnO9VwGTMIwXsMdGRHYOfYIRizq0WmzjkryrcSipZUxT8pUdXctH3NicSGXlZAEf5IXGuZJsSN4SgOcziwoEZ2nHUF8I5x2p8jz2w2w8IkDIxG/fsLYK+EqJSWiSze/29JweZZZg12FsIHZsiYx543CIMuKgkmAYs5+klVkK1F6afelBJEp0pB9T9QujB3wBeYbFM8Qu718lOi8CZrpmk/uLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlRB0Bb5scN8qJiFO8r/F7BsFMGfmxNxuIMkXg4lVu0=;
 b=Njt+I+i4nFQR6cx8rwYT1TCZK6rkfUPxR5viyeySPboDxcBQmTAn9s4aL3qgxkc50tfzoJJNR/XF6qfx0fTqC5M6kGovOchwqj9VByU+cxurpynBUnDnR5pY7yLqHQSLMMX93NRb+Jduoy+qt+ds8oj1G7JlTkxNSrKq6NYE+IfG7IXR+8Uelluf6Ma6KIuOwBY8O4O8+HwvA4Fg+pcSJPisOOT4Z6rm00LQwmOb2OoM9MVEjVJmGY14uhHu8e4eLVIH2BOokPQnqXGxqXB5Scc2YQAuJnynTB7iVERGxtYJpXkP8pv1UEwP1aJJa0sqYDJF+yrJ2TkVkstln4pzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlRB0Bb5scN8qJiFO8r/F7BsFMGfmxNxuIMkXg4lVu0=;
 b=P6sYAUf8lKjBJhUGn/Wj33ExwNBi91DbOFoLwFwlcfVCz4eNHYm/A+rhB76379zuHBZZTF6mFwk8DwbgSWOJfdGU0eqAQ20GOMGTE+7wD082gheZ28EB+Kto4eIxMvirRtHXymlK1SqCdy9tpA7x5u2BlS8kwEP3AjFD9Z13Nbg=
Received: from DS7PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:3b7::15)
 by CH0PR10MB5162.namprd10.prod.outlook.com (2603:10b6:610:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 12:15:39 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::2c) by DS7PR03CA0100.outlook.office365.com
 (2603:10b6:5:3b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 12:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 12:15:38 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 07:15:33 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 07:15:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 8 Jul 2026 07:15:33 -0500
Received: from [10.24.52.205] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 668CFJJj2721368;
 Wed, 8 Jul 2026 07:15:20 -0500
Message-ID: <a8e245b5-e9d5-4b5b-b53f-6aa69f2daed0@ti.com>
Date: Wed, 8 Jul 2026 17:45:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 5/5] drm/tidss: Fix sampling edge configuration
To: Leonardo Costa <leoreis.costa@gmail.com>
CC: <airlied@gmail.com>, <aradhya.bhatia@linux.dev>, <conor+dt@kernel.org>,
 <devarsht@ti.com>, <devicetree@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <h-shenoy@ti.com>,
 <jyri.sarha@iki.fi>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
 <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <louis.chauvet@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <nm@ti.com>,
 <praneeth@ti.com>, <robh@kernel.org>, <simona@ffwll.ch>,
 <tomi.valkeinen@ideasonboard.com>, <tzimmermann@suse.de>,
 <vigneshr@ti.com>, <leonardo.costa@toradex.com>
References: <20251106141227.899054-6-s-jain1@ti.com>
 <20260702130010.1238089-1-leoreis.costa@gmail.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260702130010.1238089-1-leoreis.costa@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH0PR10MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b20705-61a0-4f29-39be-08dedcea9f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|5023799004|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: kNN/WQaXdD418qIylKHEt5zl1K3nGU/3kSNkde34wLvUdcn1BkhCNoCkscjQQ9NnuMVX1X3HqK8+4/LiN5BIhEvcCyCjVBCdyrEYTjY2R4I3O8GM91MgtnUa+GOMJLuFnX/fNeLTJHc74uSkP0dO2pLAyINxSsrC7sTyD54jP/DjTo73PXH74pcurf3SwYeg8R1n/8h5F9HVJ46kU6MW/pGdVI904yQgLCLYQ0m+7AtFzZ50kUi4mUfDvfQohRVpukd7BT7WcEcSIycaFZkPTUkkyYTzVrdZo2kwcJ5jrR1DGf+j9iBcNkOWD83y9wzItNFB/PxpNYBJvwNDWV/1mZgvu4UtxwIeeiqT7Bq8zfdbO/AfwheNqMpdzuX7SQY7FEkBuLQpZ1a5fljvNnMucK5g23kwOOM3sMIXd5HxscEbN1wlgWlMNsAnycoMmGQqSFVEXalfPKlGtu6Yol4dCxIvwAfBS+xiJ9ahKZYYMoPCLoV8XvIZTI0kDq1RGtOIis7IAF/6aEJwoFmOmkGQKDHknK3wRPQtaO/o5iwpM9EXDdxva9qArE6eojq2l6AbR3uVoiAwspxZitNqc7CnRaq8FqdFkqdzauyVsyhqL9LqgMaQ8OL1HNZ9eL5klm2X2+dXcOAhLqjnbZFIqT4Bng==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vP8o4zI2fSyGXOyFifTVC+tpQXuSCRl0K87fUKzRUDUpiobgV0CVYiLS6Z1OEUfD+AjJUw2tNMdtb5J+132ipGUEwJV/QURn1r8VlTZwEuJUVilctlp2FPnH0QxpvymgDtMk5n5Mqv2+Z9WeP6muB9T+BJp1WON0xdhXGt88K0cnWB2gzc3YWdvQUfDCV8xVNBgmU8rS/YIHyp5tkxqMCortxVHyGMYljjykV9w+Kt5Sm/egWSV1vY3a3PkFh5CSiAXryNNPO29NmhGVeMOTm3O4AVVQrlpr7VOMaUrpm4+TX73K+65YEzjLkwEob6VGLidR5VC9zUJqbA+3cSfY9dHcHZTulhMeHj9MN5luHb+QL/RT8rs3KcViDeIYneDzVH0XNTNqLOvV7NpennmlWLgj/jV7I3N8IXetRi80PsOpDnMFBy1eoL9s8R+2HZrk
X-Exchange-RoutingPolicyChecked: ODQ1QOojSUgAxdRR69fyBkGmaMqyLrqUwP0Jps7ZqupHnfoyVgaZB9hNea3XNwFeGADu4R72xhFDWH1SzXQROyr7z92h5XvmZlaKiMkERYBtl/Nmw9VRf3hWLCnfv1ppCMDJZ0aN90TJQ+xDfbCTbrmkBktGz1FnwYmrnmHNuF5SiO5K0bC5Qydg4EB1EkamdMRl371FKmPC/vhIQF6aMPcqbqiP7PFHQ3gbhAU23k7tCQ3Y4ZXDKfjLcSZtbqBSb50hTFwYib82QFJfKmRu9TYFeVyeCioDY05OrX90wwfO3Wx4xTpNfAWm+qOmh/DL4CoUoiikvgTEZp+sk76upQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:15:38.7630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b20705-61a0-4f29-39be-08dedcea9f6e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5162
X-Proofpoint-ORIG-GUID: xXbIojYK7EZXrttbzYSRAevBeEFqaTXN
X-Authority-Analysis: v=2.4 cv=aYxRWxot c=1 sm=1 tr=0 ts=6a4e3f6e cx=c_pps
 a=z/rjtr9/JqYX5j7IdmSYkQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=vWJXAa7WGB6vcjIfOGsA:9
 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExOSBTYWx0ZWRfXw0BAkybcyi10
 lAD1znU/SujgZDCfB/foCVHekjODASpdusfrc3X/BnxTu3renGhYl/yP8rTknuagZHJ/2fZzAWU
 GJ0P7rlm1npECyPWG1yU8VOdYVaPMffl0OfSOalbIMCgBeyWDutv38QPpano2TBHwhz+wLTUbtW
 TRqWjVMu5qFJ+krV9FHbGMY/NYzQFYPzGiQynsEaSDHIFf76aK97eJZ9VkUGGpaisAmUmL8PTMo
 cfrLEQIEoOlJWdoonGOTDiawbCyH/h1y4TtH9T/W+tahm2bVTnpDebmrlJKfw+/QxCJ3YTLXS8a
 SwdbTlAYvb+ElLH0WNfl75vxrPg/H+V1LgXYkonPVQpF67/3dy6OyUg+lf3wKv0nM2ZmCJVSV2J
 9g71nYWI2i7MZdJFCuNxd1zBaRrZjp31D2GFrhWAbqQNaphkx608zOeQd27Pwy2PVIXIjaHX6L0
 qr9Pb2bW2t66UBweCdQ==
X-Proofpoint-GUID: xXbIojYK7EZXrttbzYSRAevBeEFqaTXN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExOSBTYWx0ZWRfX7u5UYX8IpZ7c
 PgAQ38HrUGL0Sai5Gubj7WRgNlYwjF0PPOnqS2ntLmUIMQWte1hmlW/tacM7TxrICcUOfhDqLEY
 HaoMMnkmOuxgydRFdgfXusPgBa/7D6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080119
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

Hi Leonardo,

On 7/2/26 18:29, Leonardo Costa wrote:
> Hello,
> 
> We tested this patch and it introduces a regression on our panel.
> 
> On our board, a Toshiba TC358768 DPI-to-DSI bridge is connected to the parallel
> RGB output. The bridge requires data to be driven on the negative edge, and
> this is also reflected by the `ipc` variable in `dispc_vp_enable()`, which is
> set to `1`.
> 
> With this patch applied, however, data is driven on the positive edge instead.
> 
> According to SPRUIV7C, both `MAIN_CTRL_MMR_CFG0_DPI0_CLK_CTRL[8]` and
> `DSS_VP1_POL_FREQ[14] IPC` should be programmed consistently. However, if we
> follow the actual bit descriptions, and ignore the sentence saying that the two
> programmed values should be the same, the data is driven on the requested edge.
> 
>>From SPRUIV7C (https://www.ti.com/lit/ug/spruiv7b/spruiv7c.pdf):
> 
> MAIN_CTRL_MMR_CFG0_DPI0_CLK_CTRL[8] (DPI0_CLK_CTRL_DATA_CLK_INVDIS):
> 
>          Clock edge select for DPI0 data outputs
> 
>          Note that this value should be the same as the programmed value of
>          DSS_POL_FREQ[14] IPC.
> 
>          Reset Source: mod_por_rst_n
> 
>          0 DATA and DE are driven on the falling edge of clk
>          1 DATA and DE are driven on the rising edge of clk
> 
> 
>      DSS_VP1_POL_FREQ[14] (IPC)
> 
>          Invert pixel clock
> 
>          To set data to pixel clock relationship, CTRL_MMR_DPI0_CLK_CTRL[8]
>          DPI0_CLK_CTRL_DATA_CLK_INVDIS setting should be the same as the [14]
>          IPC setting.
> 
>          0 Data is driven on the LCD data lines on the rising-edge of the pixel clock
>          1 Data is driven on the LCD data lines on the falling-edge of the pixel clock
> 
> So, the proposed fix to this patch is:
> 
> ```diff
> - regmap_update_bits(dispc->clk_ctrl, 0, 0x100, ipc ? 0x100 : 0x000);
> + regmap_update_bits(dispc->clk_ctrl, 0, 0x100, ipc ? 0x000 : 0x100);
> ```
> 

Thanks for the suggestion, Tomi is trying to fix this issue, please have
a look: 
https://lore.kernel.org/all/20260529-beagley-ai-display-v3-9-7fefdc5d1adf@ideasonboard.com/

Regards,
Swamil.

> Reverting the patch also makes the Toshiba bridge work correctly again.
> However, we can confirm that the patch is needed, otherwise only the
> positive-edge case (our case) works correctly.
> 
> In other words, the two registers need to match semantically, not numerically.
> 
> Please ignore the previous email I sent:
> https://lore.kernel.org/all/20260702104817.1219078-1-leoreis.costa@gmail.com/
> I hadn't seen this more recent thread at the time.
> 

