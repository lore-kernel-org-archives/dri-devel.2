Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77277C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF40B10E57B;
	Wed,  8 Jul 2026 06:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Epar5Dtr";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wqpa5YCP";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476B310E57B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:50:49 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6685PHxm627157; Wed, 8 Jul 2026 01:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=E2JCzuw0jLu5DC/5b/BgwwoC8ni+vR7qcSY9ap3xQ
 q0=; b=Epar5Dtrip9ESECrpUP+XNlIBsV7CjW/gRQGu1LeznRo4Le+E64goQsmh
 vKXLQdCkiSHUr6f1KGqfRbNCAMp8axDI7Fwad2Ynvl+PzyMZQwpeAOn39AEvonok
 iLhLac+O8FSXygQygL8tdkBaUhpdrXuLChpF90MdGXCzW1fdwp3LAgzCOZW/qQyJ
 zX7GXFzpb2vNAeqk/UAI6mXooABeV/wSLDcEiU7d2jBKSuOhCwe/C3nYKWawBNS4
 7Q2cNkDSBxeqR0pyozZFSm6vrnh/xv8dEDMEUUeSZKp5s0hDFsLhduYl9DNvqaXe
 MnrFW32jBXCMpQBBShfR9SySR0HOQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f94m7d4vy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 01:50:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqIPIVk+njfh8lEP4Wn+daoRZcHemJpx98CQ9xSqKvsRGl5ytp3PpIvo2ev1bRQR/nb7T27R38z4caGJ2jRaXOtzmcK90CgHxOswFhSABs+kMTyCWt1xbOgUgLsKiLg/ihw+/6MqWSxX/9nH3tSWOCqYPH2dx3VaB7Weg5uEr+Kycl0rr2WK0SGYC53iQ/dUpV92T/pidApj4utP65wclt1EJhajaqDGklNss32TSvY+OsMG0OHZDAfOZr/LoM0bZxrR3RkbyeMjWj+Q+E/W8+U7keBvwK7VAYcCAZLErwVRWQOqxKDAyuEubZWpHxsS63JKW7Qzzf/+M749Ktn2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2JCzuw0jLu5DC/5b/BgwwoC8ni+vR7qcSY9ap3xQq0=;
 b=Ty4tjqfraFhP31B+zViQshFzZ7oiw/vr9ZH3iiAHKsv6hVKC5eGDkx1qrqikOglLlD296yW8wzGz5JAme119Kn/msqe8ORZx30mY1OqMAgnm6Apuf/Uab6W/0wTrGGqCArfRD3CSBLJzYsuiZvL0NfgX3sgtCbHg7LSr3PXouNXYtAjzc7MyL1STBo/J4tWOpasUhyXcNsgmL0ufdoWdH3XmM8vKk0WRO8ZWYkGlX0NQ1iyJyhGUcTwjbNHZRIAz/dbqTgM2QWZMRBazDPfiELN2bqLExctUAqS4GjhnZl3nWE8EaNW7T+DpmeuFoP5A5gC5ACUvrURXRhpKw+vgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2JCzuw0jLu5DC/5b/BgwwoC8ni+vR7qcSY9ap3xQq0=;
 b=wqpa5YCPH6e6j0SkuEUAhQbWEzEU/EoAPerE30st2dFVFU8R/MTtUjpJH2yIHjYaJBj4uDfdUEtPDWl4NVCilI4K7mqQGkuV0r7IfD6rfZoU3VV3GPl4jVjeg3UIBQAvMIq8UZFIBfA3P0b1pbLJXu5YOTvBgZFv9CATz1c4V9Y=
Received: from MN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:52f::15)
 by SN7PR10MB6956.namprd10.prod.outlook.com (2603:10b6:806:34a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 06:50:30 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::7d) by MN0PR03CA0008.outlook.office365.com
 (2603:10b6:208:52f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 06:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 06:50:29 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 01:50:28 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 01:50:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 8 Jul 2026 01:50:28 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6686oMNh1568707;
 Wed, 8 Jul 2026 01:50:23 -0500
Message-ID: <2e709e26-742a-4a6a-a76f-31e188fa6332@ti.com>
Date: Wed, 8 Jul 2026 12:20:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] drm/tidss: Add external data and sync signal
 edge configuration
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
CC: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260529-beagley-ai-display-v3-9-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-9-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SN7PR10MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: dac88f14-d284-4560-a1a6-08dedcbd3334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|18002099003|22082099003|3023799007|921020|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: ALtl+R3wrTHvs77jNKRPiF45/lPsW6l+T5qnfrqyi7Ywadf6FC9dNEAxmvYyvtLL1zDX0jqvEKBO3/nUSGfmxB8+v2RnyaG09W8Zqz/coj4cM18j/K3TRKPf8iIHzs/y/T5Ucuvu7Uhoh9oa7R0/a9C8iNCF5CgzFuUbn49aIQf7iJsdct3bSu3ccbpWZuSUrnxmeZzvGPEspoaJmjjmoruW2FPy6bxJ43SH37ILbXtVknNH+sUWVU6i+JcR3YP0kyvywM3zXjz4u5TJDWjaSYCigOR9OBQN/kTuVU90MN7Jtm7i8X1EEe/NSkWttbJCjlFdQHtZonW8CIxzpasgExS4oqP/rCIsMUMP6hSVnHle8nf4+ZMDhqZnQtqhsGVdIUheZS82mEYi7mj7UoCPGY7s8oBdqTn/K3XCqmy+aw6btnmgj22MS2q8ssqzHbj6OR+3DQf3Ti5sZ1QPRODv1FmVf6ylVZ2tXUcMH6xAnaL5bZbK2JRwEA66vXWxBZzmsb1+1dJIBlavtHA4TonuzlVu8/7j/b3KFt8cDebHP8POQSYV88w/EmoVfQg+ivcgLnJ1cazOWcY5SV/Q7rFl16q+Njr7cESmPsZDBCPLGQhQ9EJzcEro7n0vxk3O6s+15yZN4HGhpe3Hz57cU9eiD/BOjFARTXzCE2UmPE02a+cJfBuRXlDqIJC15VLr2ngcjCgFBk2hyzkGJDLgC6XOBFKE+xqfkBoUXisSgxE/u4TZWk+3faKlj6kRph5M9BD1
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(3023799007)(921020)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eCVNDiUsHFh3BFVjbMYzs0KhJXeKNiayRl/hBWrh4UzMHCEQOZxEPjhVOueKC8BWl+KrRpNVzycKrEXuunCc5HWMi7amIASPH8r20nlMPgNl0G7qNKf6ubh7CAQqunNYu9CclwqsHD8Kw8QkwIU+PiGMTGTbk8rTvPLeFbjY1vAcUetDJswVzPEbUNssDPiAWfzGg4yw3peiZJRvpiECpXytS0i+DixVuSNaSH5cq9mKMVmC9LZ7q1ahWigfOVaTWadD73rj1BMNTV+Kdnm3RlcmeiqnIUqn9F/lMF1rPcSV8KbGSbE25tu7SuApgOJmEf6DL2mEGKTWlJnDreA8fiG33Psynw7rcGqSwnWUWnCWFf8+08qECZPpJLa8r0MZbIm21+d4P+MV19bpTI56TVZq0Q1Jp8ogQywv2Nos5rB2RJvOuBV7SrgahvOymgi/
X-Exchange-RoutingPolicyChecked: XNukcn3K+AS76mo39OAis8FM2dMZw7OliEj8NgriwwHnv6EY6a0yjCgB2vpv+2ex+U7fuZvWlHkNlTy3c4w6q7jNplBJQFuM5WjmPxrA6d2UAxQOnBIioApxYtXFglAZwZaRbkWycjAPHXyH41KaEkqe816O20kjrLQR2fGI6soYvA94/vwVk8b0tewb3KbcGTvlbMzGmv39EnYxMzSjUuRE+3aR+wwxvM4OBBOsz8suK8T6N4O5/S79RAX46sRLO+H0V862weHF2DJmBQclh5bXR/OMx48CJTc8HpauMwb3YA0G4pzKRWyNBwr0MuKcaBdyAg9LZKMBt3q7wMRKjQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:50:29.8071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac88f14-d284-4560-a1a6-08dedcbd3334
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6956
X-Authority-Analysis: v=2.4 cv=f594wuyM c=1 sm=1 tr=0 ts=6a4df33b cx=c_pps
 a=zj1Wid/uFNkmIHgSYpofMA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8
 a=P1BnusSwAAAA:8 a=sozttTNsAAAA:8 a=O-ZhL8Sfkyz-3yfFfmIA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: xfBSU5f_tOIxtJVSW0KW5XXyPz60NU86
X-Proofpoint-ORIG-GUID: xfBSU5f_tOIxtJVSW0KW5XXyPz60NU86
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2NCBTYWx0ZWRfX9Co3mH94Ec7S
 1tUB++t6dPA961AwOGUpSNETDRt9n/SjkWCB3eLNh/PdKH6smw+zrvmbFnHXYA9LE52fZkYjVBS
 8Xh3l8yj+H3J+A+qBQ/l8XC5YS/yHuUE0tUXxE/EcOGrSl1uG4LBa9yyU6PCWiYCQAz1pkSMMCD
 fJQJK/c3oCfkDsZMnJY5Lkfui1sekF6kXfdd3JF6+pxBFnXA2XFY2DUrX+U6n+i/NEHrL8gLtIU
 9SwZtxbB/H9kzoAa1eIqPuaLyaKuddqRL8oaZkZlk9eUjo/r3kBwA9AppGsGZO1RqWh+t9liiZ/
 8zBPL0gJiiW6bzAeTN7bjLnxjGQJrfRgokBn/l4Nox1NAYi55YxAAcZiJKn+X+XSYqZIIelQwXd
 6Jjrke+PeeY936UEsN3UWP0ZpMtnbJcsLjWjH3VbZGB/cWDevIaEJVnAiykvzyGRgMwKO+uCbrH
 iydjetSyMKnO+ov2/Zw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2NCBTYWx0ZWRfXxv21/OmH5pHy
 PP3ZzHAHSNG3gQtzvYrFUr8GLeDOeNb/one/ZA/EC4HL4d+5HS4uklNRMlI/Lf13Oy8Xofy4R1n
 tGMJoODl6qN1sQUmPPgmVySfjEvNj4k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080064
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

On 29/05/26 14:15, Tomi Valkeinen wrote:
> The DPI output pipeline in K3 SoCs contains the display subsystem (DSS)
> which produces the in-SoC parallel video signal, and a DPI block which
> adjusts the signal to the external MIPI DPI output.
> 
> The DSS IP has registers to configure whether the data and sync signals
> are driven on rising or falling clock edge, and on some SoCs these are
> automatically conveyed to the DPI block which needs that configuration
> to properly output the MIPI DPI signal.
> 
> However, on some SoCs the DPI block configuration has to be done
> manually, using an extra register outside the DSS, DPI0_CLK_CTRL from
> MAIN_CTRL_MMR_CFG0 block, which controls the DPI block's behavior.
> 
> Add the support to get the regmap to the register via syscon, and
> configure the bits before enabling the video output.
> 
> Original patch from Louis Chauvet <louis.chauvet@bootlin.com>
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c      | 25 +++++++++++++++++++++++++
>   drivers/gpu/drm/tidss/tidss_dispc_regs.h |  4 ++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index c21ac3f51720..08342a9a5e8c 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -467,6 +467,8 @@ struct dispc_device {
>   	const struct dispc_features *feat;
>   
>   	struct clk *fclk;
> +	struct regmap *syscon_dpi_io_ctrl;
> +	unsigned int syscon_dpi_io_ctrl_offset;
>   
>   	bool is_enabled;
>   
> @@ -1201,6 +1203,13 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
>   				  mode->crtc_hdisplay - 1) |
>   		       FIELD_PREP(DISPC_VP_SIZE_SCREEN_VDISPLAY_MASK,
>   				  mode->crtc_vdisplay - 1));
> +
> +	if (dispc->vp_data[hw_videoport].dpi_output && dispc->syscon_dpi_io_ctrl) {
> +		regmap_write(dispc->syscon_dpi_io_ctrl,
> +			     dispc->syscon_dpi_io_ctrl_offset + 0x0,
> +			     (!ipc ? DPI0_CLK_CTRL_DATA_CLK_INVDIS : 0) |
> +			     (rf ? DPI0_CLK_CTRL_SYNC_CLK_INVDIS : 0));
> +	}
>   }
>   
>   void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
> @@ -2989,6 +2998,22 @@ int dispc_init(struct tidss_device *tidss)
>   
>   	dispc_init_errata(dispc);
>   
> +	dispc->syscon_dpi_io_ctrl =
> +		syscon_regmap_lookup_by_phandle_args(tidss->dev->of_node,
> +						     "ti,dpi-io-ctrl", 1,
> +						     &dispc->syscon_dpi_io_ctrl_offset);
> +
> +	if (IS_ERR(dispc->syscon_dpi_io_ctrl)) {
> +		r = PTR_ERR(dispc->syscon_dpi_io_ctrl);
> +
> +		if (r == -ENOENT) {
> +			dispc->syscon_dpi_io_ctrl = NULL;
> +		} else {
> +			return dev_err_probe(dispc->dev, r,
> +					     "failed to get 'ti,dpi-io-ctrl'\n");
> +		}
> +	}
> +
>   	dispc->fourccs = devm_kcalloc(dev, ARRAY_SIZE(dispc_color_formats),
>   				      sizeof(*dispc->fourccs), GFP_KERNEL);
>   	if (!dispc->fourccs)
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> index 382027dddce8..4cdde24d8372 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> @@ -333,4 +333,8 @@ enum oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
>   
>   #define AM65X_OLDI_PWRDN_TX		BIT(8)
>   
> +/* Bits in the MAIN_CTRL_MMR_CFG0_DPI0_CLK_CTRL register */
> +#define DPI0_CLK_CTRL_DATA_CLK_INVDIS BIT(8)
> +#define DPI0_CLK_CTRL_SYNC_CLK_INVDIS BIT(9)
> +
>   #endif /* __TIDSS_DISPC_REGS_H */
> 

