Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BE8CDB471
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E3610E067;
	Wed, 24 Jun 2026 11:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XJGabpLA";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AImmGUrt";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EA210E067
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:23:08 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65OANvlr4120987;
 Wed, 24 Jun 2026 05:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=mIykOJn1l5oMaj3y+LGmpEi30nkb1bCICplYDge+n
 Ww=; b=XJGabpLAhKaaY+B0UBp/+hVMVAEe9lFDnR1vQhJNKa+onkI0ersR/sdCB
 1tiAHmCYS5ZESxO+kWMbfBpQBtVwfsBvGkE09X8kb8K/cPaSGzMSjuTu5aqET1tr
 Wh4AO4AcKEls/gE9aKAlXxIuWwIbCS0FjSSMJ2McmqbtAAM7sci0SUYbF1pGk7Iu
 fAHP3hnatuRULl3EVvCm8FkHBOROeTvU8ue3VZoN2yI2yWqS6WBSZbNRJOYIDaLO
 IogL/i4eHj1DgnErzOSnpFPrjAqJLsLyjpIDA7mW5yYioj1LlTSjGlSGMzaomhLg
 GNx33+rh1rBETfSsmgwLaxv5HsNJA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f0bqq0ku5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 05:44:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yniht2aa7jtnAjo3CKqaX7aENpr82WuXQrvCcguR1WTTNPhIHQCJOj3W77n0Lhs25hQyKGa5ePgQCHtEmkRkOinu61ln7XzEaopPRgYoV5ZOozcjXttBcmlzwDhFM9UlUxwdwUT0sg23nmJLJ/yhIIBPxjrTbR3HOd568T8WqQCyJIQc2smoxt3QPyKDiyrC3Iw9Q12xNjJAv9lvDGo/avfShXJOKlhlR7C+QsY1iOHOHCAme5PFiZahex8t+lrpofeYzeJP4mxFYE+ATt3UpZD5ToH0J2OF7gPBEtwpR8vc/o8r2+pWPqPHEtV51Nt2mJNB3mPUmzvN6lYOkwZLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIykOJn1l5oMaj3y+LGmpEi30nkb1bCICplYDge+nWw=;
 b=BI+NnLnrIgxfdHZ3XTEOm3qTfo5CaSPnS7KqD/g1tJOmfWeL0O7IhdV/aBWKxOz5cDPK0p3dg7Sw7l+3yUeipsTAKi74IgMIziswg/GExJjVMjEsRp9yWNN/7vTaCvrEHqDxbi01FjcRip+F964J5yWA05VXajspMMeJqsRuC2tHuVm+eGFlXRNf3MrYPVX82v0kLEAY6j7t/EABx0uU/a1vyyrxVemF2e6N6TeSyVbntd5oCNwdGiTLJZFPUdrafI1KDhqx3TJxlb0+3k4u+BuueFgE7S+bSM69pzvV4tXM01cZ2AFeNR2HztJCzk1u9h9p3pgXvHaeTpOyfLf2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIykOJn1l5oMaj3y+LGmpEi30nkb1bCICplYDge+nWw=;
 b=AImmGUrtqo7hIwle/VLDS4JtKHpV51u1bS2M7ggCcMwvo4whcXvW1P05WQn2RjPD7QYgl/aABFDe97nVjzXLFlgk/NaORdck0dmPr8nJgIC6EAdyKa21Cd+/rbWeRKp2bDbbbR2Err4EO+XHUgzp4s3kBiuVW5+jRClXfQ19oqA=
Received: from MW4PR03CA0158.namprd03.prod.outlook.com (2603:10b6:303:8d::13)
 by DS0PR10MB6773.namprd10.prod.outlook.com (2603:10b6:8:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 10:44:53 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::8d) by MW4PR03CA0158.outlook.office365.com
 (2603:10b6:303:8d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Wed,
 24 Jun 2026 10:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 10:44:53 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:44:52 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:44:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 05:44:52 -0500
Received: from [172.24.20.59] (ltpw0bk3xf.dhcp.ti.com [172.24.20.59])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OAikdC246302;
 Wed, 24 Jun 2026 05:44:47 -0500
Message-ID: <158beee7-4f74-4a2f-ab74-454712d3c42b@ti.com>
Date: Wed, 24 Jun 2026 16:14:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] drm/tidss: Add mechanism to detect DPI output
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
 <20260529-beagley-ai-display-v3-8-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-8-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DS0PR10MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0b238d-506b-4796-5600-08ded1dd9fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|23010399003|82310400026|36860700016|921020|56012099006|3023799007|18002099003|22082099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: QzoZHydZ3YuKSqaK/3AqwHURXd5ayPFqG/QxhX1gozs7i8jxxuBzzPhXuQNSrGm5PHL15onYAs8kbe/tZuoWwKwnLkt/mnMzNXLmnDsrCZgvPwaZPbwJA5llQbPGxs+mXZpOOQjD+AQUUYO1Xdx82yC24zwMzP232UnBdKuu1aIBAvYyAcqBIAUtRwCBBXD1RTZYmvm1ZNssPC2m8LboQb5eAg1LHgJKOgpBttyKRdkIQyAuNLCc0CBtOxYYCdXmO/G5/pm/0oHsLzw6sm/Fu0uRAbMX2xwfPHuiLlhcsjDULGvuMEuwHvytYZdpUA6vzJd76waIZEFkD1lvgjeXPkxxxZ84wKaoo/h5TGjUrtRYVjjrNDYXtSqbtxqpQ/adm/u4RwgDH+LN/XBb708dr0uoEOBwlddn4BE5jmpL2HozZ0c1nwqlVPZN/AYpVBfcY3sdlZ7UVGM9yVXe12njumQtWvyo+ITwX5O9iSt4DAK2D+wx32xYrP2XXcwbHQZVcev+a+jVP2ysB9+Xr3Jy17c+hQCI8mWMitBRvY5z40LfjSebvblWVIhFgsMlYLwv3nb9isklkq6zoEwC8L0Jrtp3u6X9QiP+3to/S6vkEFPBOIaVcbubK7WpgvHoBRcjes8V8tTiRsoXqqjA6GZLjyrOLcVH+XyjodCDtkL+PSSHZ831rAzIgYEJOIQBtERffqAVViMgkZXVf1AXB5CmgVkH4t2j1rzDo9T718LKGrFm3WzlyxsSgncQPB2S+FQa
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(921020)(56012099006)(3023799007)(18002099003)(22082099003)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xpen0f6eqsmgr9dYUw2xJKm2vJ4Xligq72AdTzCJlp58jh+mTGEIjKfr/F/Ik7IRblCQt7Do3R4cAYAmC/n6WUqIVG45jdetibdwYPDZg2MfYRnrWKd2LX3xJ+FTNACDcI+9EVyDEXEHGtVrPNEcmQm6hN+vxmFQ1uofv4xMwDuvreOJH70iJC15/rfXQ3qnSzUUg1aFul6X5LkT04csX4K4uJHQn6L2U9dSehGxBRGpl98DTiiCswRawEbFu8GICUEP6BxwIf55yvwr9yrIO35/HCtqFViINmY/Wdrc3mgvHjTQ7qgdbcCUgQNpS428AW9QD2i3ibJUix25RJQQQXKCyZNhEjsGlKG0Gx2uUgbY/is8BCoyToCdpYMVCDsovfg/UlnN2Shvzys9Vo6DMPtuPvJW6wzrPoCdaY+Oo/014DCIyneOrteIAQ2H915T
X-Exchange-RoutingPolicyChecked: QvBjJ6jNH2BpVHyBByo+6//bzw+b/thOytD49zhu2u0ZoAmvbEatiHwF/uPYTpSTLAB4qqkWXgaIfgwXgdMzWLq5hlYcOfkmuHV+zBTwSC7qtXpiBUG/494guzCmGgKL95AeTB7aVYVxnTxhO/tQjQPQsAN5pgZyulXd/YWwMsVy6FIiP/fhuk2e42voSgjAD3MI1QaQ/2fqiOdObM5S4v9aSjNlw0iJO4l/nnVuOXXp4E0RqgD0zkD6+8fvBz0wbNaacXgEc4CJHmvQriYyjTcPJrFHK608jM1c4ew7U/RvRu7vwe0VWSIGUpH9QBID7UIXdTxENT8aGoypEg/jrg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 10:44:53.1927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0b238d-506b-4796-5600-08ded1dd9fde
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6773
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfX+a2y6Zp6TGsP
 Qr+UuKUBR342fcnz6CH71e6V9ORoAEMPUh1IYIB8GORpHD016tZpZHg7/TV+dmfItbCBoGF9QLs
 LvYccUCkMhinTZGMzU66eBvXYQ+6/NpUdOurIV/Nr+PW+AAWm2JvAt51y59cytjmPJYKKJmaake
 gTdBfLN5WGXECT5mFuZmQF7r1HejTrLTk1wMa/XX4XQtdDQdc/IjdQbXIYOBX06R3JQ6RZR7sm5
 sbuhsBb1GMDF3zLJDJPhBOm5LZ/LbEUr5EmTYHQRWn8A417JCeLZTMT2SP6kt4B1rYXBMP8PhB7
 tTDiokk2gZ7WOLfuWXs8csJWhUJr1Qmf2cZecSzIufQSQhSozOh4mdZRTGSOsIB9yxz9fClo+XO
 4Hir2CREamAr9OYsmGHeMpZifTNvYPfmDo/SeYCb8r+AXPQSnW+L0VA2UytiGFxDZSI6M5ZZfpR
 7xlpcn9XqpI+8zMEJ/g==
X-Proofpoint-GUID: vUf_VKbM7RaBOeVh2i8wn5n2jMJeoVOO
X-Proofpoint-ORIG-GUID: vUf_VKbM7RaBOeVh2i8wn5n2jMJeoVOO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfXxWQMfly7qz1E
 eGb3XEWDg7lVRy25WskUGlpwRXy9JOJxValNXTcXRoT9PXwKXU7TiOr4MGxpHYk5yOyiWQ5kpFS
 eEhLAPv0sfkhVvSYlJj207Vwho/6tc4=
X-Authority-Analysis: v=2.4 cv=G80s1dk5 c=1 sm=1 tr=0 ts=6a3bb527 cx=c_pps
 a=bGC7MwCPNpf+Sn14ocfQJQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=P1BnusSwAAAA:8 a=sY7h3xnWd-4rBP0BaJsA:9 a=QEXdDO2ut3YA:10
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240089
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
> itself as a grand-parent.
> 
> If the output is not connected to either of the above, it must be DPI.
> 
> Tested-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_crtc.c  | 10 +++++--
>   drivers/gpu/drm/tidss/tidss_crtc.h  |  4 ++-
>   drivers/gpu/drm/tidss/tidss_dispc.c |  5 +++-
>   drivers/gpu/drm/tidss/tidss_dispc.h |  3 +-
>   drivers/gpu/drm/tidss/tidss_kms.c   | 55 ++++++++++++++++++++++++++++++++++++-
>   5 files changed, 70 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index a31c21c5f855..dfdf61b01dcd 100644
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
> @@ -417,7 +419,8 @@ static const struct drm_crtc_funcs tidss_crtc_funcs = {
>   
>   struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,
>   				     u32 hw_videoport,
> -				     struct drm_plane *primary)
> +				     struct drm_plane *primary,
> +				     bool dpi_output)
>   {
>   	struct tidss_crtc *tcrtc;
>   	struct drm_crtc *crtc;
> @@ -430,6 +433,7 @@ struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,
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
> index 8bb93194e5ac..bc8b10af9a48 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
> @@ -122,6 +122,50 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
>   	.atomic_commit = drm_atomic_helper_commit,
>   };
>   
> +static const char * const tidss_internal_bridge_compatibles[] = {
> +	"ti,j721e-dsi",
> +};
> +
> +/*
> + * Detect whether the bridge is internal to the SoC or not. This is needed
> + * to find out whether we are using DPI output (thus no internal bridge).
> + * We detect this via two means:
> + * - If the bridge's of_node has a compatible, compare to known internal values.
> + * - If the bridge is a grand-child of DSS, and has "oldi-transmitters" parent.
> + */
> +static bool tidss_is_bridge_internal(struct tidss_device *tidss,
> +				     struct drm_bridge *bridge)
> +{
> +	struct device_node *parent, *grand_parent;
> +	struct property *prop;
> +	bool is_internal;
> +
> +	if (WARN_ON(!bridge->of_node))
> +		return false;
> +
> +	prop = of_find_property(bridge->of_node, "compatible", NULL);
> +	for (const char *cp = of_prop_next_string(prop, NULL); cp;
> +	     cp = of_prop_next_string(prop, cp)) {
> +		for (unsigned int i = 0;
> +		     i < ARRAY_SIZE(tidss_internal_bridge_compatibles); ++i) {
> +			if (strcmp(cp, tidss_internal_bridge_compatibles[i]) == 0)
> +				return true;
> +		}
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
>   static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   {
>   	struct device *dev = tidss->dev;
> @@ -133,6 +177,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   		u32 hw_videoport;
>   		struct drm_bridge *bridge;
>   		u32 enc_type;
> +		bool dpi_output;
>   	};
>   
>   	const struct dispc_features *feat = tidss->feat;
> @@ -149,6 +194,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   		struct drm_panel *panel;
>   		struct drm_bridge *bridge;
>   		u32 enc_type = DRM_MODE_ENCODER_NONE;
> +		bool dpi_output;
>   		int ret;
>   
>   		ret = drm_of_find_panel_or_bridge(dev->of_node, i, 0,
> @@ -160,6 +206,11 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   			return dev_err_probe(dev, ret, "port %d probe failed\n", i);
>   		}
>   
> +		if (bridge)
> +			dpi_output = !tidss_is_bridge_internal(tidss, bridge);
> +		else
> +			dpi_output = true;
> +
>   		if (panel) {
>   			u32 conn_type;
>   
> @@ -199,6 +250,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
>   		pipes[num_pipes].hw_videoport = i;
>   		pipes[num_pipes].bridge = bridge;
>   		pipes[num_pipes].enc_type = enc_type;
> +		pipes[num_pipes].dpi_output = dpi_output;
>   		num_pipes++;
>   	}
>   
> @@ -224,7 +276,8 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
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

