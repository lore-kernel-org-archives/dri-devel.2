Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9864C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A7F10F2C9;
	Fri, 24 Jul 2026 06:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j8ozTS0j";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H6RLLtMJ";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7380410E02C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:26:54 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66O4l51S2134598;
 Fri, 24 Jul 2026 01:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=8ljLEy7/NVspyL0hMV0pTQYvooqbN5FNKj8Cc8tlC
 HY=; b=j8ozTS0jiYEUuk+dBhosRMG0V0GgPeDCRvtXil047q/NiRof/6Aajrl56
 sCLMXqEuMlSHHbuPlxxjzs6JoJvIMHXgCIkyHuxG91rgl8SW3ZbgjEPd55hHxkGE
 rrPy5t7MFQ1mxUMIuVXchjowyttPz0u7tpaqsRJhrS/CTfsVjWPjNcZYH8edBSWI
 DsmODoabjeV+5S/yuZ/KJ04L7a2iJY4eSEullX+HCK+tyB0QKIe7Wpft7/dOCfGL
 iZCyKJdfn20Fc2cH14BbEPPIzwju2stNDB3VRj9i+ZSNMeQJuTXkmTSYz/oS2yha
 GJOgofG6W9JD/ppF0J2drKjRS05ig==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fkhvuwqqe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 01:26:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/pMZ5MCViS8qqJlHR8sUOUt9uf9EKIqw3v0GGxOwZ9LtUMJCCFp08G9R/wlck/OJc+bcXSQ04+OKtj4YG0mBQPDR+RUxto207iTMuNK/evXy87loYqh/0pDkxfQygARNDtGIuEnlJEkHJnH4WrJx5kDMLHWS0NUDlCkXgiGLSkRzbZH+bqR9v86q60/68onhrvLd1hhlMqIFJEOc46ncbGWNSlIvLtLCDqGWd57x9tIdF5b2NQ99VmwUjLaspJLgdDPPaOGLTQwflnfaPmtz5PYDsYNSjD8GjoEz0kwZz6QvU7SF2gOt9fVskiCzSbGKHU7XAYGDIDc/zYgvW4I3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ljLEy7/NVspyL0hMV0pTQYvooqbN5FNKj8Cc8tlCHY=;
 b=nquRk1HP4enPQuzxWCQ5NM90fiWNj09BzWWyqwg4CnUi3uA31uOUKfwwMPPWYPhAbMt+N4QmAa7p0+nCRCxMi2twtAaSDCITforz4wZRxEsD4l+UDNDZyAxjy0q5nToQu3nzN1iYuar7otMYGHwR+WlZxTS2/xZbZOu2AndQ9UpmBh+kMK8EwCq8EzMLECL5rEV2IpS1VhffqGjfHQYZSnyLBeIe2PSxGdiEnpThruXCuQXHcq9OinYGT40gc2nn8owiV49y5s1xt4lyXLe4OsP2MOB6MWBOAYRSvf7IKcQy3AhHnXBq1x6zY6o8VGgUtbI4zePrP7ie1GCnvdyL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ljLEy7/NVspyL0hMV0pTQYvooqbN5FNKj8Cc8tlCHY=;
 b=H6RLLtMJ43KH4U31VRCiqAkU9iZkl960M1vw1SCa/QQqgLII9j1+qR8VKzuypQW6D8PkWUYp2yyBqm5V7BmAiHl+gyU+UwcEtCLi5Lc29tYDC7SSWwNIdZPDlTz6dwI434nsCU3ezaxQmQHSLtmbxLB7XEX3S1XzDmCg4rUPMtg=
Received: from BL1P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::16)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 06:26:25 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::83) by BL1P221CA0044.outlook.office365.com
 (2603:10b6:208:5b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 06:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 06:26:24 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Jul
 2026 01:26:22 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Jul
 2026 01:26:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 24 Jul 2026 01:26:21 -0500
Received: from [10.24.50.130] (uda0132425.dhcp.ti.com [10.24.50.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66O6QENL2665797;
 Fri, 24 Jul 2026 01:26:15 -0500
Message-ID: <dc5ca21d-cf42-45af-9069-5faf6a82745e@ti.com>
Date: Fri, 24 Jul 2026 11:56:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 0/5] arm64: dts: ti: k3-am62-verdin: Add Toradex
 Capacitive Touch Display 10.1" LVDS
To: Neil Armstrong <neil.armstrong@linaro.org>,
 <laurent.pinchart@ideasonboard.com>, <jesszhan0024@gmail.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <nm@ti.com>, <kristo@kernel.org>,
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, <thierry.reding@gmail.com>,
 <sam@ravnborg.org>, Leonardo Costa <leoreis.costa@gmail.com>
CC: <leonardo.costa@toradex.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
 <178473052640.1949706.11360946998734187321.b4-ty@b4>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <178473052640.1949706.11360946998734187321.b4-ty@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4044f6-9840-49a9-0a50-08dee94c7c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|13003099007|921020|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2MCt34RX6E8whKlMJRNKrcSJVuZj3EQwqdZCJcJM081ZSjFCG3oFNuRoIHLEfvejQchW6LTfze+K3/R/Go+LuGwZKtUpYfebKnRHApkVAO6idmy7eUhlwwsPJbnZvOQKBC/v76wgNbttuQqJnw3wRvLNdHImULoiuj7y0jRmtQK04FQKu1W/hFYM9bbz9YGFlfMOCEd8lDhXnmJuRlf8e93e4kkF1qJKHC873lxIDyGfzYBf80gip94foxUZAMpvvd5TLfqssgPB39eebCnd5H8DdMTcS1JcMwVgH3/iEGlZKJHNoeJ7uXUV/0HJs1QTTOwvAO7n9zq3FiI2kUYzt6f36lNdXitoCgctk23zPd/TQNbFx6el+T2sSEYfyj6b/Oam8lOFJi/kLyT5t0P1qRU7j4l1ty0yVybPW/8qxLs2ud50OoMkTMRtqDSVrBVgNpTLgebg33GIVP2i1M2XpG4YMskHQJUVRQ6JvEduqTmltPCZNs6vVJVW6R4QOTOzblHf/Xl9dVNWkXqydbYIF9kED/qkY6nEUcwOIH1NK8QJlrGxXsNf7oPk7ElIBHkrJITLWXJlKmx93L0QoEw8ZP6H2oTh6WlKMMIzb71zglYcjqcgkufJ5k8Cn06bbX5GelfQsveaDHfQHdW5EfyBZl9G1cu7PdMkEPztTmdo5Hd1P8sJcaf3bCFkkwWItHqV
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(13003099007)(921020)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6zlHNPgINDMchTWrg6YDCmz6Ne7BwbshPgv2wBU/q0paOQTEfJmVWWRyxpS49yUo9M8PQ9snjDafipRMT4T8u6UGsgykQ7Ea4+pq/XH9KusHg8EFMNAbNgE2q9jrS4RopnN6kbAONXcYCkLc9U1FjmkoClKdUgaCtLtf+m37OktYOAMfze87pezN1reuLkBKAD3MogS5Ke/WAS45LzZ1IFueXXBHxZraaTRSkavBDB+WS1IWL4umJkZ2T51N/rrCllbnEyADQAVV44cHnYhl3Y7drVpJM8Km9rf06yd/l768EoZeGH7iV3g3tt4ZYDL8D3LGzarC90bRs7fAi+gYEFeKaNfFV3WtZIKVO8F0/Zb4EbtfkDEYtJyepS4X+plpAmf3PfwI3t9zh3pN0mkCnmPMR+NS65rZNIZorXyBulbaYedSTeUM4qbVilTkGsro
X-Exchange-RoutingPolicyChecked: JHckG2/kSC/Etq0WGkGUIm5R0uXsdRlHgg2BZ7IhbCe4Otj4vfgz+69xbZ9EjbhplAVUcsgtbpUa+8/YEfL/tGklOQIIHRC9mb66fcoPfTjYhPXIbhC0JT7ap/UaTYBw6fkzPQdE4HLHchBr+Cmsson88TppyPrMUKnZwwcn2DnHSfieG96Aahs6AfXeLE+ZOEOw9GDOVp+Ct55jMZR6te7TWpNwIbzlj7nbE8ThDZIrpAv1HGBQgdgm+1Dq2THxMo3mJpF3LuH9yg3vVCfm87Vbc4E3hStp1a9A0F1qxi4OX5A+iihulrxSQWKzSfHIrvniOzGCSKC41NW5M2zy4w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:26:24.2234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4044f6-9840-49a9-0a50-08dee94c7c2e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Authority-Analysis: v=2.4 cv=I6VVgtgg c=1 sm=1 tr=0 ts=6a630594 cx=c_pps
 a=R5REeynT8B2cGAMauuPKTw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=e5mUnYsNAAAA:8 a=sozttTNsAAAA:8 a=m8ToADvmAAAA:8
 a=36ToB7h48dUqzmaKGeEA:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1NiBTYWx0ZWRfXw88zq0owYSQh
 GBoCE3h/up1CbDXFkRYS7g703zqlJD2fnaBsm5YWl1yhbp217n55ws8hFAdxLuSuyLhRdN/e34P
 GcIo4Mcw9dQ3b4sERPpgNh6S+jAjIeY=
X-Proofpoint-GUID: 7rd6srIshBHaGga9D7gX4QEoqtgY7i3z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1NiBTYWx0ZWRfX0KVhpjLxzvm/
 fKg0CwlLeYSMaBGAsEsuOTYIFZ4SW9okukBdC78/fP+IIntQTUJA7KLGHIM6+X2aG3jo2DGp2Bq
 b3jrlKEeDSzYxoFMnpVk7ixuQk9SNygxTvANBVXP0XPKLdE3jiPX99ek/PJANe9nSCNyHrwLGKi
 MzrVBLIYi2G0pz/9bX9USZG/QnCaeWEUlEFzjgH5fdvVB1Wsic7vMyf1eA7ZSg1FzbZalsIY9uX
 DVx/6Si9z+OnQ17xrfDPt9ARxlLMbd27lZk6baf1mFNVztipWo7vQLXg8nH5J7ytNpJqNmrbQKM
 ammrOFaOo95DHwV5ZkmF1umEBATLBi/b/TLcWImxYAPGGrGisPDfTRDm1mcnREbfsViuoL6S5qm
 EpfoUtehuNJtdLUyTal6EDyXxJ06mdxU7ddN031XMZSFPaLqQ/N88s0HBS2DgUZ6Km/sYmNkQeS
 rnFIk/lGP8whT86V1Fg==
X-Proofpoint-ORIG-GUID: 7rd6srIshBHaGga9D7gX4QEoqtgY7i3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240056
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

Hi Neil

On 22/07/26 19:58, Neil Armstrong wrote:
> Hi,
> 
> On Tue, 23 Jun 2026 16:57:36 -0300, Leonardo Costa wrote:
>> From: Leonardo Costa <leonardo.costa@toradex.com>
>>
>> This series adds device tree overlays for Toradex Capacitive
>> Touch Display 10.1" LVDS V2 on Verdin AM62.
>>
>> The display addition covers two interface types:
>>
>> [...]
> 
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
> 
> [2/5] dt-bindings: display: panel-lvds: Add compatible for Opto Logic SCX1001511GGC49
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6ce748682f746a0c1ae311191fb820b08151ddb6
> 

Could you also pick up 1/5 which adds the optologic vendor prefix needed
by 2/5. Thanks!

-- 
Regards
Vignesh
https://ti.com/opensource

