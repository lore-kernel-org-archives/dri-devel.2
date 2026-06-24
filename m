Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C83CDE000
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE41D10E09B;
	Wed, 24 Jun 2026 10:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fCOdlSWM";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TPWjcWOR";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FB910E09B
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:43:30 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAOsqO149164; Wed, 24 Jun 2026 05:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=+ibMf058Ei5L9mcNI6/e4IFIvJla+rVjlIyPnUxfT
 zE=; b=fCOdlSWMWuCg1bPKUk18DzWQWWb5VnrIcaenRPpzkXEH1Nwdov9g858Iw
 WynCx1XQCcvSB+XLIewDHwfY31gQzn33DbxTt0zU6KzniSpKA4AU6cqBeBK5DYnd
 Iw6fW2/2awAl4/4mZKBKbbNWm0y91cMk08k5IceIBoCGanPtQuyhlr1jVb+q8ZmR
 JSHI0a3HZ0tEsyBdoXw+ws63GZ/KOHnYWQLKrEESMF7gzWuun+nIrVafqcPx2ORg
 eV1VTplK7YdeLfNlcRcDE3isxJ3rx8GZ9UB/tsZY1PvZ31bH49NhmUT8U2z9HQeu
 KwjxerIpOHSi4a7xC425BUKIbHyWA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4eyten75jp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 05:43:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXrynRrSRLd+dXM7mXQAApsjqdREFlqa2qPonMKjtTQXOaJlfAn43Tnq/2ya9v3xc4+iRwvB4LsHgeykToqbtTI0DfbCJ0d54sCzED3s/CylQ86Z8e1Ry/JZccYm6HwBXtneT2JnxMNiMnNt9LxHNSyOohjJS24N3w6ySDTSpfIDuGQY6xw1QF2hzjMHSfnFcQlI0Z2RO9Xe2o3Ihh6ozkIidO+17JaWtgUI4nv9McKQgy47n+jS4qxCImv/XgCTRbLoEGAdji02DFmFfw+kMGHx1m95O3NoHbsBRRpWrMBqv02MeYJF8c6sJSa6Q701UGf7gu6t1IgUN6CCfMZ57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ibMf058Ei5L9mcNI6/e4IFIvJla+rVjlIyPnUxfTzE=;
 b=tf7XAX7gtg0GoWz3+5QUfc74j71AEEbgVbPROSsYRifx3B5IHA+Jn4RYzPHZUZ/SnOOlsipmZY22djx3ZF3VUQgc3hL0F4YroYFASTXHAioWw+3RN5J8FnPaJ2zWdGu8B7NLQ5OeYNjR4yhaxAzsPF7wRYFHTWvhERE/3WnZi0+N8j+blYlaVInICFN+4hdD6rkXz4PV77fjj6vCojTvnC4xMZexsi1VcUMduEu9co6DSlV1qFSITiForViZp8rq9kXy/7S8IrO+z5bREfolQBg02o9IAhzVVf8CvEBYgsc0N5G5qegzbQIdpKRpAZ/doiIKWd27bnPiWK/W4HDnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ibMf058Ei5L9mcNI6/e4IFIvJla+rVjlIyPnUxfTzE=;
 b=TPWjcWORQ731ZTQOv1ifI/3xhLpzW+JsNmY1nHUr2U3eUlicJZUrFuvYuI9ml8tiHHe4Rq2f+rlkDiytjP73ls2alLx/WrS+3btONxyzml56qn1ADk4E37eksnD3ZPEtlUVW912KDfK/gnVCeM6TLesxW9w8HkLcqqfdWcaCTqw=
Received: from SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::9)
 by MN2PR10MB4127.namprd10.prod.outlook.com (2603:10b6:208:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 10:43:14 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::61) by SA1P222CA0044.outlook.office365.com
 (2603:10b6:806:2d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Wed,
 24 Jun 2026 10:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 10:43:13 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:43:13 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:43:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 05:43:13 -0500
Received: from [172.24.20.59] (ltpw0bk3xf.dhcp.ti.com [172.24.20.59])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OAh7Ti243895;
 Wed, 24 Jun 2026 05:43:08 -0500
Message-ID: <111ebeb0-d72b-4628-b502-9b4c621de663@ti.com>
Date: Wed, 24 Jun 2026 16:13:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] drm/tidss: oldi: Remove define for unused
 register OLDI_LB_CTRL
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
 <20260529-beagley-ai-display-v3-7-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-7-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|MN2PR10MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 118854f5-5896-4665-7b12-08ded1dd6479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|36860700016|82310400026|1800799024|56012099006|4143699003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: uCJoPtYnhlZ6MxkHhkUuriE08UH1BKGrMM+Ihv84pbh3pI2LitDi0lhb4WjJ/2m5GAwXFHSg/1anCvpKgrtjF+5E+qs8LjYFQTQgL1U12VraHwgc1juG9ig4EUvf23sego5TQKDx4T7CeMEfpVdNED/L5Xzv3C6eUabkaN+P2Z2rHGymcvhSFAkPv4SCUxrkrxWZqjcuYgxtuOqPuXg550ps5BMN7FgbjWFtN38ZCENahpO8Bd9TbvcGV4B48K30zOaKvLxQrWVWz8Td0htJmhb2MOqy2vitlX/O4BGq6tOMf5ZdZud+xe4hqoJShWd/nlHL1mtMrvfrYXRFT4A71+QMT688j1llB9zsXh/kdNy7Z/9n7mdTKd3gZ222JgPqBiC7ILrylzuBNEzxRX2jX9ZRLvO9ttNZH05jIO9we1tLScGGqKQyi/Emvogfm7psY97CFT2i7UP5SdhxYa9X9LLOGmR1FQTFyJsdExDjyRa7ADra+HxAOUyJEKFwhB60ZLKSOZQux9ArBp2TkFlzkdl/alPiSuV1F7l2tLQv+tjUegD9A1RWU66ep7MSabcwdNsxrrN89DkiMfVfHzvnbs5NOPAaRwJgeVRUP92jp7j/XWvlcw6QDvZNPlebDi2SUxhRsumDsbWl+UpiXotmZzYOmqgn4harOPZ4PCl6HmaIAufrPdbWlXby68vbAF9A3oP1DxX0F6sEEnEDzHQFGNjXyxpTkLakiHSk9H66Oa/WhleU8HM67QZr6/RUYhUd
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(82310400026)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XfA1IYOOMFe+mHQhC4oqkFHN2cdX5rYXkiEfdVIzYz9po0kwnUcENrHyxipmc+2bdwC8lCw7CrgV/6In00D7W9GDa73mXz242+2HC/C6GlAksdDWAqc3obhdYxaza5f1LFoZRR1XGrC09pzIG9WByX4ajP5T/SEAvNKNAYbZRSEQ0tE5Bbo8lVKOiSRChYiKvoeeot6qCdh2qs49o3L0qUqHoymotkjeu0RX7ibDdKsh9oqRn0Hbg/CWPVSrhfQOoiYg6ooTPlFGT/Z2arDZNfJsjggExgIhybk6l/oXNOCCuQsu8g4zrj+99E04esgl9fO778++/HV/cWs8Y/CIhv9o8BqqAn0dJOkCbIavH+oeeW/f9HVpTv4a4yh2/YQWsom3xBsJJmVVgFOIqUR1nQR01EJRccYLdhnkJHiIjokjdwjASAVGyIU8jECx5RpR
X-Exchange-RoutingPolicyChecked: A7FbmbqMeuTwCNC/191KLxulUE0nqP3gMA5qPl26DcYG5E/Ts/Ix4jVdRsG4KPJTbZ1SiKWBDDB15pW759Ym9tpKN16gfgMWE+fhJigp6uRBRRHnke+mNTQmJrrXtWIS6ZaR9YCDc1qpVaLUR8IUTEq9O70NMcTTariuuAsg7C9odR2N0OeFhEoZoTiqyAqwVQ0HlvXVprPjXDKkHfD7tnP9Sly31lm5erOYMDVOa4reSF2K9RM9GKma9CFS61dMedND4aLqAzqP3AsdC9nmIwOFCmJSOlshsQYXn9yBVKqj5PGtfYP8mkspiyLRA5lKSWA0mzqpJZqm5ij86FO3Ow==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 10:43:13.6083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 118854f5-5896-4665-7b12-08ded1dd6479
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4127
X-Authority-Analysis: v=2.4 cv=eO4jSnp1 c=1 sm=1 tr=0 ts=6a3bb4c5 cx=c_pps
 a=+KlkUUL6BOGgxGViHu3/Fg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8
 a=mNI_SQqZokdIuhQb0EsA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: rygCDqD32HFjIWR5MQQGnFwzftvUsvKl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfXx+Xk8Fef6Hq8
 9cSOCT+c7d5WLv44yTuq/xST+rcnOhhhrGtnKo+Ep9ZfYPy0UAXEdzvcavSB8YMtLhqH9+TV6Fe
 7xfQkQCtzhOHDPfG+Nn3ftmbVj4rgQoxCN1xHryjp2vhDy/2+zwqMI5Q2ZhJru17JFkcdf6bo/i
 UNnW6ZhWwXqCYa8AAROu5sDjpyeRT3cznavGpjq03ST/vaOelFImEPLjWAa90V/n1tZLH/QAG1n
 RJ9KXVLrFb/fNA09x7kNl3X3JuLCiIxpudTTjuvUdWEm8jkorCPTmbWPMzMi8iUIfkINla+RRbg
 5RaK3oCpr3BKoY082Ae4EffjeXH9mPZ9Sze0m/KdIsDFHJr7l03J6kWykRSFpALFqmSH803gNj4
 JDHIjCVdBirYbNliqwRJXsvmaCm3NA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfX0RoZFttXiEFQ
 CcFYUfFngCU1NTspa8zuJzwUuvuq2H8vp/QQVRVK617OIjRRvQst3bJk7ASBDvVdjJHzr+LBhpX
 MvE7iYIQCIPtLTwq7/7t4BEU1oJlwsM=
X-Proofpoint-ORIG-GUID: rygCDqD32HFjIWR5MQQGnFwzftvUsvKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240089
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
> OLDI_LB_CTRL define is not used, and doesn't seem to exist at least on
> some SoCs. Let's remove the define.
> 
> Tested-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_oldi.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.h b/drivers/gpu/drm/tidss/tidss_oldi.h
> index 8cd535c5ee65..a361e6dbfce3 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.h
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.h
> @@ -20,7 +20,6 @@ struct tidss_oldi;
>   
>   /* Register offsets */
>   #define OLDI_PD_CTRL            0x100
> -#define OLDI_LB_CTRL            0x104
>   
>   /* Power control bits */
>   #define OLDI_PWRDOWN_TX(n)	BIT(n)
> 

