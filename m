Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B771C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CF810E4D8;
	Tue,  7 Jul 2026 13:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IldvRVzT";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V6hPmaG4";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8D210E4D8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:45:35 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C6NCm3571497; Tue, 7 Jul 2026 08:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=AWGkVsmxvXXQ5qDC0F4GRiT9cvH1RfsPXwNyqxeIP
 eg=; b=IldvRVzTEjVKH6fowmJ7s1Ii5zD9WILAVde/Wmklz6R1IRg4B+7p53oY9
 gKMHrafGV+rWNKEBHp9K94zuYGnq0Xmlsz3a9bi8Ik+2xjgBYx+wf3X8qh0GgRTN
 u7aKI2aNfL7tz4o+1oOgc12gDdYTMsp1keA7xXPSwi3mROJRJdYItxrlMPioBcnr
 oZf6PZ9RCp2CRMvP1QCSSSrkFbISYsq4rcNOA+XX6XPw8wrGs5ePMOZHLdylpdZq
 qiLs8l6WIDRT2h6AAVEZzM94RgehnadccwHlIFUF7gPBapalAMtQg0nibjTnP3s/
 1T/4lMEpj9UDiFeLP87POD4dIi4qw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f90cb0skj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 08:45:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jw04Yg7AR8CIQfZJqsb6tIPnifOXk1F2TMKYbpQEcq5kZpfmNPZ12RE3GzyLopVY2d6fAI6s/xtut+X9r8WSNznsaECLlc5mc/vdNdFXGRhyv4g8S/ZFxJDK3AYA4X6NPMapl2eay4Wz4ez/j2DLeOVomkKhJwk8SC8xwg1DpU9FgROhpI4cNjLtPVhNwUhFUFWDX8mFBSBARKnFLeAPWwUI57xWnoP2ziqs1n4BaiQTsZ6hGcJotxnD/GBC/v1WWSqTMa51BZdxwF/48aQXwRonE7aU00uFUFY/hdlzIqxd/qYjlTo37d8YkhQXB21Zu3Uf7FHSyw9IpDquv8cAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWGkVsmxvXXQ5qDC0F4GRiT9cvH1RfsPXwNyqxeIPeg=;
 b=YyPyNP5+nnANEqHVr72kTK/v0Vc1TfYtNtLA9NAsj4ci3RCZhjdNEi0ICdOVYH6D/S75qjkkXnZLofLZyTUfQmysfv42qt2U9i1fkXlaWLO5oRGpWidXfGQeNH6rcbvj+r0eus0xN6pF+FIa4NZk9XseReWpWSdTtqbchJF140QaRz3p0VOEcFuNOo/Xp9TEhUwUxtkgpWayd/lK4c7tE4A2lm79tzBdCSnBkrWKAmrUYB2tO7U/BeE5M2JzTvaPEHqALfjgHpT0rceTy5sL+9xMYv4knsocFVSYl5MM8N+221QYkq93CPQAwJWMvU1OATqX7iyFw7KnVX0RVIEDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWGkVsmxvXXQ5qDC0F4GRiT9cvH1RfsPXwNyqxeIPeg=;
 b=V6hPmaG4bzao0C5i3bDrbrKWtNLre8aJLT6q8QgsVfFlOpiUIw2A5LBtfoxVLVkTuDBUkphX5pcoP2lfqiXWvqsBuzN1M6r7N/q8CTpslbLa5txM/VlkZgYgKyMni4vK79YxZP0q+OjXYdaFawC3Aa8ktpnUuSaisngCe25WniM=
Received: from CYXPR03CA0082.namprd03.prod.outlook.com (2603:10b6:930:d3::10)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 13:45:16 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::2f) by CYXPR03CA0082.outlook.office365.com
 (2603:10b6:930:d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:45:14 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 08:44:44 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 08:44:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 08:44:44 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 667DieHD352758;
 Tue, 7 Jul 2026 08:44:40 -0500
Message-ID: <40380dbc-b81d-479f-b032-f1868d251f21@ti.com>
Date: Tue, 7 Jul 2026 19:14:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/tidss: Fix synclost issue while disabling layer
 due to erratum i2097
To: Yashas D <y-d@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>,
 <d-mittal@ti.com>, <b-padhi@ti.com>, <jyri.sarha@iki.fi>,
 <tomi.valkeinen@ideasonboard.com>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260701063337.2165966-1-y-d@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260701063337.2165966-1-y-d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MN2PR10MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: ada6efe6-11c0-4c6d-a7d2-08dedc2df90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: WTZwK+cLSTq8YdwEE01CEZre9uBdNXC+YP9LpYodoAvZuFQ4sRhzzbaWp3e4CSOA6iVrJzegAZdbrszNkLukLxkx0ltdtaLdrgFXHsRV6cR7K8+CDMNwCUtlkW+Dj+ThxRAb0lwfGrneCit1VTb/SeweLSXShZt2i6lIy+oXtniyDNEyNPX0sDOFKl8HlmGuLFaJwu8xIRfAmQvGrtk9nSLyoI5ryVeEX8dv0NqYUod2VMDl+uYyAcWyTdqUCmQElgd9uALIL+6PG9P5d2BlkoTw1U9Gsrs7Q4OnO1S7XH+Q7vxtOtB7ZM+VX6+L/dSJrKA6F6Ni2w31LHw8m3LdO8xApqKIWmgvxUD/6FHzPp1oXLMd68GYrTAQ7tbTEEgsWWjhJfwb94DU57wK0djkuLCNbsRuOohOWyHbFkr+OWyOzgVgkoFGc6W7LOQL0eiOyoiiPJcM9Y9mPC8e5ysvydFK/v/gkO2jG3OEi/tvdeuMX7IrSyB1wpq6/b4gba4u8v513iMXPoJe2Zi9xuYg/DMBCAl8EPp3MClTv2tm2fIOx2J6h+U+xYS67OrX1gGW+8rSrBKOa2QIXaUPILIrpudUnl+IozzqAQYQEYO4yZHQXLlUL2YdJoHfuSDl09iG1RV5kjiO9/5Bbg29Awb8hWzpecvOzU5lVVRmrGO5KNTCIIZlFTAG9aIEEPLFaYrtNvriGDju2NhZZHsNbWKiYQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZncekSha/ndNZe78kKT4Mw23HsdKchlVCv3wAaOjYvwMwe60L/OGBS99oIhwLTy/RPbMYqAZWUrYUDBSQjdYM0QrsijgJHFSUZCpgKzil7rgTcVgmHFwhGM1MMjgXkMeoXHWYtLMdd8o3Ss82yZtW6cwSb9m84wKQaPK5/7NnxGIgL6T24am6L/pklPd6Y3194QSnWwHybWmVAd6kKhO8RgjtJFu/4YsDsmWpg9t42+l1cVuulgD/y6Up0Lh6KA8ltNYNRGqOLS3/p85DcR/15Dr7/5YjpI5mHKKqy9z7msbisWCDKE1OydbwyTc0p19xKCQZmWvdjLokzuhbyg5v0wLwe7lH5B0DqN5IOTN04MyoQNFrSQUplWeZuMenpi4oCZbIPx72pN22JxDn4lpI1lLv9xOJOn2VOToR+p7z2Ju/XyPD+iOzDKnWPIUzzYo
X-Exchange-RoutingPolicyChecked: H4TrNA/GQHBZi35bBGJvUvAVyop5LmXtMPBGr3RH6ZZrbz3SK3zG36QGlcYZh+IduG2A9XpqxKYuGz7dU4+zb9nB0Ng9PCpF0z1ASseOi+LSkZw6g/UqEi3o/zQyCjRae+BOwNi6Qc7Ij82yEAJn+nFZGTX/1VYK13PgijkTLjLE8v3atM3auykabrBuylRb0SQjq+ERo2YL5Gduj1NIS8V75bkS8vb9KmpwvFTI/Wkja9gz79Bm40Oz+dQ/AakFOmF92e3a0zSzexE24ADSRWxuKwb0AYuSL21h8u3+emd3ZDT0hKeFzUZDy05eAe36iTgE5Un4c+diThXw7iULOQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:45:14.2498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada6efe6-11c0-4c6d-a7d2-08dedc2df90f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a4d02f2 cx=c_pps
 a=t5Pm7pJ6jXSUtateXttj1A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
 a=VxvBEfCKk0RvzJNsqAsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L8x0TP_LpjlWVZyze7ktMSTpobwvFfUG
X-Proofpoint-GUID: L8x0TP_LpjlWVZyze7ktMSTpobwvFfUG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNCBTYWx0ZWRfX1Hw5MWZ4Y05W
 PVCpyxaqioYGy9OJkUaENE12iKRpsv/gCHPsFxJ+YUSEdOp3LGmMJ0dIGl6+8WW8fIQiZCXx2S2
 wwuthUmJtersGl3lAuM8sQVgp5GLLfXzy7aBZ3SkWHIK/4Z5nHjBcqXgo9gOcZR1O2Cx9xPV8RS
 5DvDbKbzkRL5vOqUXbsDAmpQPUlpe6RUrgRVc4qeVDEzdh3BXbwhMINjqJFK1xQMQl0U6GUd1iw
 NafCKZQuDapwqrKXLnaDQ36747TG6d6RXhYYEoS0mNOZ9veay8gyExyGXyOZjx8zv1aGhPx8y0e
 qBemAQPVzqSbt2EBSEgNxeADk48ldYYg2zIXJV1r6miG+EZ6fVVsCd5MIDUFyFEEGQ61BTxBm4S
 YNlnsUL1UVtTo3gFXJpnBLwwE9GJI60jQxj+D4D1bFU3UDQV/wmcIV7IqccZPTrG436jKX6YHUh
 jfow4WE333sMeLqGTFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNCBTYWx0ZWRfX2Kfj31e4yfkd
 LzeFbKheoTGitu0zZypE4YCzGmD2KKprcl3ygey626hcU4yRJrxq7iIMoilnIO46oLtx9KIHCi9
 VfU0Ir83HVJQWnuarwi4XhYz3OqGC28=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070134
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

On 01/07/26 12:03, Yashas D wrote:
> A gap beyond a frame duration for disabling the layer in overlay manager
> and go bit setting on the corresponding video port may lead to SYNC_LOST.
> Fix by moving the layer to the non-visible area and deferring the ENABLE=0
> write, immediately before the GO bit, guaranteeing both occur within the
> same frame window.
> 
> Link: https://www.ti.com/lit/pdf/sprz530 # i2097
> 
> Signed-off-by: Yashas D <y-d@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> ---
> 
> changelog v1->v2:
> - Flushed the pending layers in dispc_vp_disable to prevent hanging layers in hardware
>    when dispc_vp_go is not called in CRTC teardown and modeset paths.
> - Removed the AM62L switch case as its the same as the default case.
> 
> Link to v1: https://lore.kernel.org/all/20260630103802.1853564-1-y-d@ti.com/
> 
>   drivers/gpu/drm/tidss/tidss_dispc.c | 118 +++++++++++++++++++++++++++-
>   drivers/gpu/drm/tidss/tidss_dispc.h |   1 +
>   2 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 58d5eb033bdb..02a3cf50e0ce 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -38,6 +38,8 @@
>   #include "tidss_dispc_regs.h"
>   #include "tidss_scale_coefs.h"
>   
> +#define OVR_LAYER_MAX_POS(mask)		FIELD_MAX(mask)
> +
>   static const u16 tidss_k2g_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
>   	[DSS_REVISION_OFF] =                    0x00,
>   	[DSS_SYSCONFIG_OFF] =                   0x04,
> @@ -467,6 +469,8 @@ struct dispc_device {
>   
>   	struct clk *fclk;
>   
> +	unsigned long fclk_rate;
> +
>   	bool is_enabled;
>   
>   	struct dss_vp_data vp_data[TIDSS_MAX_PORTS];
> @@ -477,6 +481,9 @@ struct dispc_device {
>   	u32 memory_bandwidth_limit;
>   
>   	struct dispc_errata errata;
> +
> +	/* WA for erratum i2097: OVR Layer Disable May Cause Sync Lost. */
> +	u32 pending_disable_layers[TIDSS_MAX_PORTS];
>   };
>   
>   static void dispc_write(struct dispc_device *dispc, u16 reg, u32 val)
> @@ -1134,6 +1141,12 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
>   	bool align, onoff, rf, ieo, ipc, ihs, ivs;
>   	u32 hsw, hfp, hbp, vsw, vfp, vbp;
>   
> +	/*
> +	 * WA for erratum i2097: clear any stale layer disable tracking
> +	 * state left over from the previous VP enable/disable cycle.
> +	 */
> +	dispc->pending_disable_layers[hw_videoport] = 0;
> +
>   	fmt = dispc_vp_find_bus_fmt(dispc, hw_videoport, tstate->bus_format,
>   				    tstate->bus_flags);
>   
> @@ -1210,6 +1223,23 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
>   
>   void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
>   {
> +	u32 layer;
> +
> +	/*
> +	 * WA for erratum i2097: flush any pending layer disables directly.
> +	 * dispc_vp_go() is not called in the CRTC teardown and modeset paths
> +	 * so pending_disable_layers would otherwise never be consumed, leaving
> +	 * layers enabled in hardware. Sync lost does not matter here since the
> +	 * VP is being disabled.
> +	 */
> +	for (layer = 0; layer < dispc->feat->num_vids; layer++) {
> +		if (dispc->pending_disable_layers[hw_videoport] & BIT(layer))
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					0, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
> +	}
> +	dispc->pending_disable_layers[hw_videoport] = 0;
> +
>   	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
>   		       DISPC_VP_CONTROL_ENABLE_MASK);
>   }
> @@ -1233,6 +1263,38 @@ void dispc_vp_go(struct dispc_device *dispc, u32 hw_videoport)
>   {
>   	WARN_ON(VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL,
>   			   DISPC_VP_CONTROL_GOBIT_MASK));
> +
> +	if (dispc->errata.i2097 &&
> +	    dispc->pending_disable_layers[hw_videoport]) {
> +		u32 layer;
> +		u32 delay_ns;
> +
> +		/* WA for erratum i2097: set GO bit #1 to latch position
> +		 * changes into the DSS pipeline, wait 10 DSS functional clock
> +		 * cycles, then write ENABLE=0.
> +		 */
> +		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
> +			       DISPC_VP_CONTROL_GOBIT_MASK);
> +
> +		if (dispc->fclk_rate)
> +			delay_ns = DIV_ROUND_UP_ULL((u64)10 * NSEC_PER_SEC,
> +						    dispc->fclk_rate);
> +		else
> +			delay_ns = 500;
> +
> +		ndelay(delay_ns);
> +
> +		for (layer = 0; layer < dispc->feat->num_vids; layer++) {
> +			if (dispc->pending_disable_layers[hw_videoport] &
> +			    BIT(layer))
> +				OVR_REG_FLD_MOD(dispc, hw_videoport,
> +						DISPC_OVR_ATTRIBUTES(layer),
> +						0,
> +						DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
> +		}
> +		dispc->pending_disable_layers[hw_videoport] = 0;
> +	}
> +
>   	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
>   		       DISPC_VP_CONTROL_GOBIT_MASK);
>   }
> @@ -1503,6 +1565,53 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
>   	if (dispc->feat->subrev == DISPC_K2G)
>   		return;
>   
> +	if (dispc->errata.i2097 && !enable) {
> +		/*
> +		 * WA for erratum i2097:
> +		 *
> +		 * Do not write ENABLE=0 directly. Instead move the layer to
> +		 * the non-visible area so it contributes no pixels.
> +		 *
> +		 * Position register layout differs per SoC:
> +		 *   J721E : DISPC_OVR_ATTRIBUTES2, X[13:0],  Y[29:16] (14-bit)
> +		 *   Others: DISPC_OVR_ATTRIBUTES,  X[17:6],  Y[30:19] (12-bit)
> +		 */
> +		switch (dispc->feat->subrev) {
> +		case DISPC_J721E:
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES2(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES2_POSX_MASK);
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES2(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES2_POSY_MASK);
> +			break;
> +		default:
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSX_MASK);
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSY_MASK);
> +			break;
> +		}
> +
> +		dispc->pending_disable_layers[hw_videoport] |= BIT(layer);
> +		return;
> +	}
> +
> +	if (dispc->errata.i2097 && enable) {
> +		/*
> +		 * Layer being re-enabled: cancel any pending disable so
> +		 * dispc_vp_go() does not write ENABLE=0 after we have
> +		 * just written ENABLE=1 here.
> +		 */
> +		dispc->pending_disable_layers[hw_videoport] &= ~BIT(layer);
> +	}
> +
>   	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
>   			!!enable, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
>   }
> @@ -2871,6 +2980,12 @@ static void dispc_init_errata(struct dispc_device *dispc)
>   		dispc->errata.i2000 = true;
>   		dev_info(dispc->dev, "WA for erratum i2000: YUV formats disabled\n");
>   	}
> +
> +	if (dispc->feat->subrev != DISPC_K2G) {
> +		dispc->errata.i2097 = true;
> +		dev_info(dispc->dev,
> +			 "WA for erratum i2097: OVR layer disable uses non-visible area\n");
> +	}
>   }
>   
>   /*
> @@ -3059,7 +3174,8 @@ int dispc_init(struct tidss_device *tidss)
>   			__func__, PTR_ERR(dispc->fclk));
>   		return PTR_ERR(dispc->fclk);
>   	}
> -	dev_dbg(dev, "DSS fclk %lu Hz\n", clk_get_rate(dispc->fclk));
> +	dispc->fclk_rate = clk_get_rate(dispc->fclk);
> +	dev_dbg(dev, "DSS fclk %lu Hz\n", dispc->fclk_rate);
>   
>   	of_property_read_u32(dispc->dev->of_node, "max-memory-bandwidth",
>   			     &dispc->memory_bandwidth_limit);
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
> index 739d211d0018..e2ce9fdf1279 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -57,6 +57,7 @@ struct dispc_vid_info {
>   
>   struct dispc_errata {
>   	bool i2000; /* DSS Does Not Support YUV Pixel Data Formats */
> +	bool i2097; /* OVR Layer Disable May Cause Sync Lost */
>   };
>   
>   enum dispc_vp_bus_type {

