Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFAECDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B525310EECB;
	Wed, 24 Jun 2026 11:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CXsbhgpx";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tQefWRoI";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6B510EEAD
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:32:06 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65OAO11i4121130;
 Wed, 24 Jun 2026 05:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=H0C8Qwh4Znjr8u8tji4EUpZqLthdUX8QSKReFqw+q
 8Y=; b=CXsbhgpxHx3sjOUp/WPds0IEHFo54Lzqm7pDXwqgIQ74AeXXGm5Su1c1P
 knOaSfWMbaG+mNeqc5BuYbciOTBqB8WYEHfUMuCfrM47byxaSrc26/q/ZN068JDQ
 GSdpj4wNtiF9op8+mXFx0vEvN/z0WM3MAD/dvSZ1Tjv5aW9hxO+oXNBpMY3Ky3kN
 EMIHZMUr2M8KxaUbKZHGHusclpTJm0YATBuckDan2Y8X7cD8IlsUWdsrt3ID6yl9
 iFvUChnoa1VdjBKHt5UC8jZU06FFCcbinmI61ATbDZdJONf3GTAgp0CRNij0I3m8
 YGU8FNYwBbrdPHncvSrWQgK3HSwWw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f0bqq0mb9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 05:49:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy2OymjooBxptqJ/qxEwbBwYru6SHjBCDCB36Us5zsjOeOeuFwEO/UY0n/8XCMbQZjDOP3066J6/3pAW4GwF7scnFrYLjU+TG5+Je73w2mvjmusMnGzLVBGp08jpniUgLMTA/HbT4mVwnh0UVevuUU+/taRY+u2GO93DMxQ2e9OFlEeq/Pn3ZyM5ShyuSoclMssCoYoiRIt4xlC5KSLfynErBtPooVl19iCHNGml5zIwphIM6uK8jyHeruHsesOg9ghGyX0dLKI5QgvZX60gQYhYOSuNg9meQ6LxvwqGNBLvHrndiAO7mcwXMwyyOT75cN3qaHaOYSy1kdAzPs+Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0C8Qwh4Znjr8u8tji4EUpZqLthdUX8QSKReFqw+q8Y=;
 b=FKSoC++Xolizy8AxYN7l31b+qbSNPMSt5lHSRCzw38uCdQiH8VIQS6RLWCIf8tsaG8mnOAeW19rDCkE1I36UcueNQNabrAwmyWttZK0BrB5nvoxsEkCmo6zkAHH7kV5hLzQkhY7tKJSrAGrDtGEeRMOpw9lCP2qYMzxeoi0I8OhlevgBOgOoxxHKtAYF5kdQVBefYgC3PJHSwOkZXznrpZLF7neoJKUDv7GjzdsqykOzjQEeDQjcywiPqbWcbmkneT+fs19YJ+W5Onjv5wv1k7hn+pcfOOofCgea39byLszg2ALQGvzsl/3YSWRl+PzehzZOM601jzveABuLAuWseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0C8Qwh4Znjr8u8tji4EUpZqLthdUX8QSKReFqw+q8Y=;
 b=tQefWRoIPdf0StpQ1ISmjTj6fVppNfsDb1+3g6iq3hlaZqeO4CGuLR0c93UVEoqlbg22VtPK2IJnrJXO42vmtTvTt+DeA3SZcoGWmxeQQqdx0sbtEQtVe55d6gRzXqgc3gVZ4b7jnGWG03FIpUQ/gvSED0A8N2LBpW+xwHXnPoE=
Received: from MW4PR02CA0029.namprd02.prod.outlook.com (2603:10b6:303:16d::34)
 by PH0PR10MB5546.namprd10.prod.outlook.com (2603:10b6:510:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 10:49:47 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::9) by MW4PR02CA0029.outlook.office365.com
 (2603:10b6:303:16d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 10:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 10:49:46 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:49:43 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:49:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 05:49:43 -0500
Received: from [172.24.20.59] (ltpw0bk3xf.dhcp.ti.com [172.24.20.59])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OAnb8B254572;
 Wed, 24 Jun 2026 05:49:37 -0500
Message-ID: <69059b1e-5ad2-48c0-8ead-8d377ef68c0c@ti.com>
Date: Wed, 24 Jun 2026 16:19:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] drm/tidss: oldi: Convert OLDI to an aux driver
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
 <20260529-beagley-ai-display-v3-12-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-12-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|PH0PR10MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 156e575b-7858-4af4-ca9e-08ded1de4e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|7416014|56012099006|4143699003|6133799003|22082099003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info: 1Bq35NZNe/DJlqPQu6v1Y8JSC7i7bfhHi1QLe1TUIblrHRCO0EfZcBj/ea0Vm7Uy6BxU9OgMWS30XmeuygIOk3t4VSZiUK48qeqx7ftQBbwUp1h8E+TCS1RuLitiq0w+EX9WaqRz/a/v2kAwO/GhhdjhPCoepqKabwgHLs2j0JTBzuEb66DjkLhR9O9KV17llY59joeT6VjZkzwa+erDB/ym559zWV0TiXNskHX/ItS5yAQNsVygXohfu5BiRHLLqf9PmoAeBw4Tvnob+m6jWeajQ3Q4gFXSCKcKfIjNtUIzV2zm+8mJnksjEUcZzzm+hxeC1r6DmWLUUFFlK1Tvf7gRu+Z+Nkf7F2zWDT1P3k6dOk0UC4DlBuTe8EFqxysb6vyhnn2gzkW29WLcHjbfaMIcsC+5Q57RmcgZG2xyinHxP6sSK0P4M7m5SHJLPerbTAkh5NdMPXPo7hTAHm280en+X87PDA8YXJKAQ7297+AS61vTvXVnubmIHy4fFqkaZAt0Blify65Z0akVohLEyjEtp9u1psb2R22Gp/SfFOKtUavFaddUo0PF3z66tTgTpzrgwQLb+YNTaOYRIY5Urkr65Wwnne6LQCtABfTeEO1NrwwB+OFzPS60bfuMnWagek+ZjsJ1usrWrk0UNI34WkY5w3zTGmyhm1Qr4UTZUMK7wYC/49gus3/Are+YNdElp/C5OScGBc2QkQhvQEe44q/vQ/Gvoj1SEOQ5x14PeOJ5GytckwhXK4gWjfdLtCoM
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(7416014)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003)(3023799007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AzVo0M+L8qsSUCFpGI9pZMqEXMl5KPZG7bftoTGkVe+5PIeLX/ELgQShqHDsW3pa9M+LAfDljYdORQw41cXgcUITYgH3CVu8562Tex0O4YS8GDoO8A3lYjBIx/51//AI0l0J3B05eF6U0YIq/h0pq8lV8KjY1YQkvhgmqZKwNP5Es8MFxuTPH2dm+wUeDYNPfv7jvoZb/52/eBm/4muDnTwUFUb08pIjCqzWec3SURlHxOy1ZnrbJh1W15ZHD9x819UiKKhE5hHFXLoTnAW9Xb8hPdk+vFdjF65fElJHbXOcoTiobBY881DOwsqlXG3m361O9+UXQUFcCNg8nnJUmCIeikcz6XquAlqh35bwhnwyEW4YWMPiybuybWGgYzbdFHQwbGMxzChECQ08f0b02prjjk1ALAt05EWx7qVMwESOFp/FJL+4TwakJlZ1QewR
X-Exchange-RoutingPolicyChecked: czqQjUYmgcia91kL48YsrDajzu3t2Fe3H3dtwWrd0DYc+3ZRPmFj1X9B+az7BclSxnC1p+MI42z6toBSif8ZmLoWGt8XX2cavTsAygUlZpkXuQI7pwnawpgaQYj4FBB6Ycr7m5Xr3t/6k4frS71UmzdMVFm9IuLFYjvh2AAH8WS/+tua2Y5cJYL6qNClUV4iT0mYV2m1eI0+0MoCrdkiHDU0pwim58tlTmbSNUY2QpJFwBVyJwjrBzmBjWYNXwFXp0WhVMBCsCtYM+3sejgTz1pPaIdEj4u6AvlOOwslOcaT2hBEhL8jUY7PB7FaUZJome3PkHW7jQuNGA1pMphs1g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 10:49:46.1234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156e575b-7858-4af4-ca9e-08ded1de4e77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5546
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5MCBTYWx0ZWRfXwxmCogksCq2A
 sFPQJ6wj422uGoTmgNiCC+W8pyjJJmBV3XCgho67yUXMJjoC+xDGX4pdxyqHz9XA4sGDCPuK5Q0
 1corJw00LAQMHpiZAF/VUWfqG2a3jK3amgOlKbTFcg/xbBd7/Ka5BKdElqkikBtiLMzyiYZKJM/
 w5v0H8tQx8xpyUCCOp0sY7bAZiVJC99O58gTiMJlhmAabymZ9VlX/I5bpHLXXbm4MxWIwAsec/S
 EdKI8bCokZC746tY3fTMFBnDDkzSd8ltlXNXvfvGX5i0A60x8YOu7gnBE5u/x25bPsVZ5CoF1nO
 gB4rLvCt0YJ/2biRCsY/IRvgz+GBkG2s4nRDoFvz4fNYnwCIToM0qe3wkExbSuV3ztk+5V8MU+0
 kzj8O5w+xQPAG4+XhDSRbwlZjoPnfr0ucBtQKsloYkZ/DqaJZj0E+MfS/06xswS3PZNCpAQm9or
 X10DKmYf0NMRWnnvcUQ==
X-Proofpoint-GUID: yeOSeA7lrzPm2FXRu2XK4RSYFlyxdyWj
X-Proofpoint-ORIG-GUID: yeOSeA7lrzPm2FXRu2XK4RSYFlyxdyWj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5MCBTYWx0ZWRfXwO++BTIBniFq
 I/hOiPmiZGp8s2mMK1dvz+xaXR5vkWeOyU/NI0/PT6eKIAAmZJbRwOeM5kYzia64duVuwt9bFtb
 2eCS3MeYRrlZsH3iphTpZsu+34zVZHk=
X-Authority-Analysis: v=2.4 cv=G80s1dk5 c=1 sm=1 tr=0 ts=6a3bb651 cx=c_pps
 a=gLG24qzvm7739X6cdimX+Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8
 a=pT3OAXfgWG0yIu-NFKkA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240090
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
> Currently in the DT, OLDI is defined in child nodes under the DSS node.
> The tidss driver will parse the DT, and create DRM bridges for the
> OLDIs, and there are no Linux devices for the OLDIs.
> 
> On new SoCs the OLDIs have their own power-domains which we need to
> control. The cleanest way to do this in DT is to add the PDs to the OLDI
> nodes. But this means the OLDI bridge code would somehow have to
> manually manage the PDs, the PDs not being under a Linux device, and
> there isn't much support for that kind of setup in the PD framework.
> 
> A solution to this is to convert the OLDI to an auxiliary device/driver,
> created by tidss:
> 
> - At module load time the tidss module will, in addition to registering
>    the tidss DRM driver, register an oldi auxiliary driver.
> - At probe time tidss will parse the DT, and create an auxiliary device
>    for each OLDI.
> 
> The aux driver will probe, and as its of_node points to the OLDI node
> containing the PD, the driver framework will take care of enabling and
> disabling the PD when OLDI is used ("used" as in pm_runtime context).
> 
> Tested-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_drv.c  |  51 +++-
>   drivers/gpu/drm/tidss/tidss_drv.h  |   5 +-
>   drivers/gpu/drm/tidss/tidss_oldi.c | 502 ++++++++++++++++++++++++++-----------
>   drivers/gpu/drm/tidss/tidss_oldi.h |   7 +-
>   4 files changed, 405 insertions(+), 160 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index 5cb3e746aeb3..aef945101be4 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -133,10 +133,6 @@ static int tidss_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = tidss_oldi_init(tidss);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to init OLDI\n");
> -
>   	pm_runtime_enable(dev);
>   
>   	pm_runtime_set_autosuspend_delay(dev, 1000);
> @@ -147,24 +143,30 @@ static int tidss_probe(struct platform_device *pdev)
>   	dispc_runtime_resume(tidss->dispc);
>   #endif
>   
> +	ret = tidss_oldi_create_devices(tidss);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to create OLDI devices\n");
> +		goto err_runtime_suspend;
> +	}
> +
>   	ret = tidss_modeset_init(tidss);
>   	if (ret < 0) {
>   		if (ret != -EPROBE_DEFER)
>   			dev_err(dev, "failed to init DRM/KMS (%d)\n", ret);
> -		goto err_runtime_suspend;
> +		goto err_destroy_oldis;
>   	}
>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0) {
>   		ret = irq;
> -		goto err_runtime_suspend;
> +		goto err_destroy_oldis;
>   	}
>   	tidss->irq = irq;
>   
>   	ret = tidss_irq_install(ddev, irq);
>   	if (ret) {
>   		dev_err(dev, "tidss_irq_install failed: %d\n", ret);
> -		goto err_runtime_suspend;
> +		goto err_destroy_oldis;
>   	}
>   
>   	drm_kms_helper_poll_init(ddev);
> @@ -194,6 +196,9 @@ static int tidss_probe(struct platform_device *pdev)
>   err_irq_uninstall:
>   	tidss_irq_uninstall(ddev);
>   
> +err_destroy_oldis:
> +	tidss_oldi_destroy_devices(tidss);
> +
>   err_runtime_suspend:
>   #ifndef CONFIG_PM
>   	dispc_runtime_suspend(tidss->dispc);
> @@ -201,8 +206,6 @@ static int tidss_probe(struct platform_device *pdev)
>   	pm_runtime_dont_use_autosuspend(dev);
>   	pm_runtime_disable(dev);
>   
> -	tidss_oldi_deinit(tidss);
> -
>   	return ret;
>   }
>   
> @@ -218,6 +221,8 @@ static void tidss_remove(struct platform_device *pdev)
>   
>   	tidss_irq_uninstall(ddev);
>   
> +	tidss_oldi_destroy_devices(tidss);
> +
>   #ifndef CONFIG_PM
>   	/* If we don't have PM, we need to call suspend manually */
>   	dispc_runtime_suspend(tidss->dispc);
> @@ -225,8 +230,6 @@ static void tidss_remove(struct platform_device *pdev)
>   	pm_runtime_dont_use_autosuspend(dev);
>   	pm_runtime_disable(dev);
>   
> -	tidss_oldi_deinit(tidss);
> -
>   	/* devm allocated dispc goes away with the dev so mark it NULL */
>   	dispc_remove(tidss);
>   
> @@ -262,7 +265,31 @@ static struct platform_driver tidss_platform_driver = {
>   	},
>   };
>   
> -drm_module_platform_driver(tidss_platform_driver);
> +static int __init tidss_platform_driver_init(void)
> +{
> +	int ret;
> +
> +	ret = tidss_oldi_register_driver();
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_platform_driver_register(&tidss_platform_driver);
> +	if (ret) {
> +		tidss_oldi_unregister_driver();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +module_init(tidss_platform_driver_init);
> +
> +static void __exit tidss_platform_driver_exit(void)
> +{
> +	platform_driver_unregister(&tidss_platform_driver);
> +	tidss_oldi_unregister_driver();
> +}
> +module_exit(tidss_platform_driver_exit);
> +
>   
>   MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
>   MODULE_DESCRIPTION("TI Keystone DSS Driver");
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
> index e1c1f41d8b4b..d3dba639b278 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.h
> +++ b/drivers/gpu/drm/tidss/tidss_drv.h
> @@ -16,7 +16,8 @@
>   #define TIDSS_MAX_OLDI_TXES 2
>   
>   typedef u32 dispc_irq_t;
> -struct tidss_oldi;
> +
> +struct auxiliary_device;
>   
>   struct tidss_device {
>   	struct drm_device ddev;		/* DRM device for DSS */
> @@ -34,7 +35,7 @@ struct tidss_device {
>   	struct drm_plane *planes[TIDSS_MAX_PLANES];
>   
>   	unsigned int num_oldis;
> -	struct tidss_oldi *oldis[TIDSS_MAX_OLDI_TXES];
> +	struct auxiliary_device *oldis[TIDSS_MAX_OLDI_TXES];
>   
>   	unsigned int irq;
>   
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index e925ddaa4fd6..188f31b57c6a 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -5,11 +5,13 @@
>    * Aradhya Bhatia <a-bhatia1@ti.com>
>    */
>   
> +#include <linux/auxiliary_bus.h>
>   #include <linux/clk.h>
>   #include <linux/of.h>
>   #include <linux/of_graph.h>
>   #include <linux/mfd/syscon.h>
>   #include <linux/media-bus-format.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/regmap.h>
>   
>   #include <drm/drm_atomic_helper.h>
> @@ -20,6 +22,12 @@
>   #include "tidss_dispc_regs.h"
>   #include "tidss_oldi.h"
>   
> +static DEFINE_IDA(tidss_oldi_ida);
> +
> +struct tidss_oldi_platform_data {
> +	struct tidss_device *tidss;
> +};
> +
>   struct tidss_oldi {
>   	struct tidss_device	*tidss;
>   	struct device		*dev;
> @@ -251,6 +259,8 @@ static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
>   	if (oldi->link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK)
>   		return;
>   
> +	WARN_ON(pm_runtime_get_sync(oldi->dev) < 0);
> +
>   	connector = drm_atomic_get_new_connector_for_encoder(state,
>   							     bridge->encoder);
>   	if (WARN_ON(!connector))
> @@ -296,6 +306,8 @@ static void tidss_oldi_atomic_post_disable(struct drm_bridge *bridge,
>   
>   	/* Clear OLDI Config */
>   	tidss_disable_oldi(oldi->tidss, oldi->parent_vp);
> +
> +	pm_runtime_put_autosuspend(oldi->dev);
>   }
>   
>   #define MAX_INPUT_SEL_FORMATS	1
> @@ -383,12 +395,16 @@ static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)
>   		 */
>   		return OLDI_MODE_SINGLE_LINK;
>   
> -	if (of_property_read_u32(companion, "reg", &companion_reg))
> +	if (of_property_read_u32(companion, "reg", &companion_reg)) {
> +		of_node_put(companion);
>   		return OLDI_MODE_UNSUPPORTED;
> +	}
>   
> -	if (companion_reg > (TIDSS_MAX_OLDI_TXES - 1))
> +	if (companion_reg > (TIDSS_MAX_OLDI_TXES - 1)) {
>   		/* Invalid companion OLDI reg value. */
> +		of_node_put(companion);
>   		return OLDI_MODE_UNSUPPORTED;
> +	}
>   
>   	*companion_instance = (int)companion_reg;
>   
> @@ -464,174 +480,372 @@ static int get_parent_dss_vp(struct device_node *oldi_tx, u32 *parent_vp)
>   	return -ENODEV;
>   }
>   
> -void tidss_oldi_deinit(struct tidss_device *tidss)
> +static int tidss_oldi_probe(struct auxiliary_device *auxdev,
> +			    const struct auxiliary_device_id *id)
>   {
> -	for (int i = 0; i < tidss->num_oldis; i++) {
> -		if (tidss->oldis[i]) {
> -			drm_bridge_remove(&tidss->oldis[i]->bridge);
> -			tidss->is_ext_vp_clk[tidss->oldis[i]->parent_vp] = false;
> -			tidss->oldis[i] = NULL;
> +	struct device *dev = &auxdev->dev;
> +	struct tidss_oldi_platform_data *oldi_pdata = dev_get_platdata(dev);
> +	struct tidss_device *tidss = oldi_pdata->tidss;
> +	struct device_node *node = auxdev->dev.of_node;
> +	enum tidss_oldi_link_type link_type = OLDI_MODE_UNSUPPORTED;
> +	int companion_instance = -1;
> +	struct drm_bridge *bridge;
> +	struct device_link *link;
> +	struct tidss_oldi *oldi;
> +	u32 oldi_instance;
> +	u32 parent_vp;
> +	int ret;
> +
> +	ret = of_property_read_u32(node, "reg", &oldi_instance);
> +	if (ret)
> +		return ret;
> +
> +	ret = get_parent_dss_vp(node, &parent_vp);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Now that it's confirmed that OLDI is connected with DSS,
> +	 * let's continue getting the OLDI sinks ahead and other OLDI
> +	 * properties.
> +	 */
> +	bridge = devm_drm_of_get_bridge(dev, node, OLDI_OUTPUT_PORT, 0);
> +	if (IS_ERR(bridge)) {
> +		/*
> +		 * Either there was no OLDI sink in the devicetree, or the OLDI
> +		 * sink has not been added yet. In any case, return.
> +		 */
> +		return dev_err_probe(dev, PTR_ERR(bridge),
> +				     "no panel/bridge for OLDI%u.\n",
> +				     oldi_instance);
> +	}
> +
> +	link_type = get_oldi_mode(node, &companion_instance);
> +	if (link_type == OLDI_MODE_UNSUPPORTED) {
> +		return dev_err_probe(dev, -EINVAL,
> +				     "OLDI%u: Unsupported OLDI connection.\n",
> +				     oldi_instance);
> +	} else if ((link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) ||
> +		   (link_type == OLDI_MODE_CLONE_SINGLE_LINK)) {
> +		/*
> +		 * The OLDI driver cannot support OLDI clone mode properly at
> +		 * present. The clone mode requires 2 working encoder-bridge
> +		 * pipelines, generating from the same crtc. The DRM framework
> +		 * does not support this at present. If there were to be, say, 2
> +		 * OLDI sink bridges each connected to an OLDI TXes, they
> +		 * couldn't both be supported simultaneously. This driver still
> +		 * has some code pertaining to OLDI clone mode configuration in
> +		 * DSS hardware for future, when there is a better
> +		 * infrastructure in the DRM framework to support 2
> +		 * encoder-bridge pipelines simultaneously. Till that time, this
> +		 * driver shall error out if it detects a clone mode
> +		 * configuration.
> +		 */
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "The OLDI driver does not support Clone Mode at present.\n");
> +	}
> +
> +	oldi = devm_drm_bridge_alloc(dev, struct tidss_oldi, bridge,
> +				     &tidss_oldi_bridge_funcs);
> +	if (IS_ERR(oldi))
> +		return PTR_ERR(oldi);
> +
> +	oldi->parent_vp = parent_vp;
> +	oldi->oldi_instance = oldi_instance;
> +	oldi->companion_instance = companion_instance;
> +	oldi->link_type = link_type;
> +	oldi->dev = dev;
> +	oldi->next_bridge = bridge;
> +	oldi->tidss = tidss;
> +
> +	auxiliary_set_drvdata(auxdev, oldi);
> +
> +	/*
> +	 * Only the primary OLDI needs to reference the io-ctrl system
> +	 * registers, and the serial clock.
> +	 * We don't require a check for secondary OLDI in dual-link mode
> +	 * because the driver will not create a drm_bridge instance.
> +	 * But the driver will need to create a drm_bridge instance,
> +	 * for secondary OLDI in clone mode (once it is supported).
> +	 */
> +	if (link_type != OLDI_MODE_SECONDARY_DUAL_LINK &&
> +	    link_type != OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) {
> +		oldi->io_ctrl = syscon_regmap_lookup_by_phandle(node,
> +								"ti,oldi-io-ctrl");
> +		if (IS_ERR(oldi->io_ctrl)) {
> +			return dev_err_probe(oldi->dev, PTR_ERR(oldi->io_ctrl),
> +					     "OLDI%u: syscon_regmap_lookup_by_phandle failed.\n",
> +					     oldi_instance);
> +		}
> +
> +		oldi->serial = of_clk_get_by_name(node, "serial");
> +		if (IS_ERR(oldi->serial)) {
> +			return dev_err_probe(oldi->dev, PTR_ERR(oldi->serial),
> +					     "OLDI%u: Failed to get serial clock.\n",
> +					     oldi_instance);
>   		}
>   	}
> +
> +	if (link_type != OLDI_MODE_SECONDARY_DUAL_LINK) {
> +		/* Register the bridge. */
> +		oldi->bridge.of_node = node;
> +		oldi->bridge.driver_private = oldi;
> +
> +		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
> +
> +		drm_bridge_add(&oldi->bridge);
> +	}
> +
> +	link = device_link_add(&auxdev->dev, tidss->dev,
> +			       DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER);
> +	if (!link) {
> +		ret = -EINVAL;
> +		goto err_bridge_remove;
> +	}
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	return 0;
> +
> +err_bridge_remove:
> +	if (link_type != OLDI_MODE_SECONDARY_DUAL_LINK) {
> +		drm_bridge_remove(&oldi->bridge);
> +		tidss->is_ext_vp_clk[oldi->parent_vp] = false;
> +	}
> +
> +	clk_put(oldi->serial);
> +
> +	return ret;
>   }
>   
> -int tidss_oldi_init(struct tidss_device *tidss)
> +static void tidss_oldi_remove(struct auxiliary_device *auxdev)
>   {
> -	struct tidss_oldi *oldi;
> -	struct device_node *child;
> -	struct drm_bridge *bridge;
> -	u32 parent_vp, oldi_instance;
> -	int companion_instance = -1;
> -	enum tidss_oldi_link_type link_type = OLDI_MODE_UNSUPPORTED;
> -	struct device_node *oldi_parent;
> -	int ret = 0;
> +	struct tidss_oldi *oldi = auxiliary_get_drvdata(auxdev);
> +	struct tidss_device *tidss = oldi->tidss;
> +	struct device *dev = &auxdev->dev;
>   
> -	tidss->num_oldis = 0;
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
>   
> -	oldi_parent = of_get_child_by_name(tidss->dev->of_node, "oldi-transmitters");
> -	if (!oldi_parent)
> -		/* Return gracefully */
> -		return 0;
> +	if (oldi->link_type != OLDI_MODE_SECONDARY_DUAL_LINK) {
> +		drm_bridge_remove(&oldi->bridge);
> +
> +		tidss->is_ext_vp_clk[oldi->parent_vp] = false;
> +	}
> +
> +	clk_put(oldi->serial);
> +}
> +
> +static const struct auxiliary_device_id tidss_oldi_aux_id_table[] = {
> +	{ .name = "tidss.oldi" },
> +	{}
> +};
> +
> +static struct auxiliary_driver oldi_aux_driver = {
> +	.name = "oldi",
> +	.probe = tidss_oldi_probe,
> +	.remove = tidss_oldi_remove,
> +	.id_table = tidss_oldi_aux_id_table,
> +};
> +
> +static void tidss_oldi_aux_device_release(struct device *dev)
> +{
> +	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
> +
> +	ida_free(&tidss_oldi_ida, auxdev->id);
> +
> +	of_node_put(auxdev->dev.of_node);
>   
> -	for_each_available_child_of_node(oldi_parent, child) {
> -		ret = get_parent_dss_vp(child, &parent_vp);
> -		if (ret) {
> -			if (ret == -ENODEV) {
> -				/*
> -				 * ENODEV means that this particular OLDI node
> -				 * is not connected with the DSS, which is not
> -				 * a harmful case. There could be another OLDI
> -				 * which may still be connected.
> -				 * Continue to search for that.
> -				 */
> -				continue;
> +	kfree(auxdev->dev.platform_data);
> +	kfree(auxdev);
> +}
> +
> +static struct auxiliary_device *
> +tidss_oldi_create_device(struct tidss_device *tidss,
> +			 struct device_node *oldi_tx)
> +{
> +	struct tidss_oldi_platform_data *oldi_pdata;
> +	struct auxiliary_device *companion_auxdev;
> +	struct auxiliary_device *auxdev;
> +	struct device_link *link = NULL;
> +	u32 oldi_aux_id;
> +	int ret;
> +
> +	/*
> +	 * Allocate the ID first, so that we get a lower ID for the primary
> +	 * OLDI, instead of the companion grabbing it in the call below. Note
> +	 * that the ID allocated here often matches the OLDI hardware index,
> +	 * but not always.
> +	 * The OLDI hardware index cannot be used as an ID, as, say, OLDI 1 on
> +	 * two DSS instances would produce the exact same device name
> +	 * ("tidss.oldi.1").
> +	 */
> +	ret = ida_alloc(&tidss_oldi_ida, GFP_KERNEL);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	oldi_aux_id = ret;
> +
> +	companion_auxdev = NULL;
> +
> +	/*
> +	 * If this is the primary OLDI and there is a companion, create the
> +	 * auxdev for the secondary OLDI first, as the secondary will act as
> +	 * a supplier for the primary OLDI.
> +	 */
> +	if (!of_property_read_bool(oldi_tx, "ti,secondary-oldi")) {
> +		struct device_node *companion_node;
> +
> +		companion_node = of_parse_phandle(oldi_tx, "ti,companion-oldi", 0);
> +		if (companion_node) {
> +			companion_auxdev =
> +				tidss_oldi_create_device(tidss, companion_node);
> +
> +			of_node_put(companion_node);
> +
> +			if (IS_ERR(companion_auxdev)) {
> +				dev_err(tidss->dev,
> +					"Failed to create secondary oldi device\n");
> +				ret = PTR_ERR(companion_auxdev);
> +				goto err_free_ida;
>   			}
> -			goto err_put_node;
>   		}
> +	}
>   
> -		ret = of_property_read_u32(child, "reg", &oldi_instance);
> -		if (ret)
> -			goto err_put_node;
> +	oldi_pdata = kzalloc_obj(*oldi_pdata);
> +	if (!oldi_pdata) {
> +		ret = -ENOMEM;
> +		goto err_free_ida;
> +	}
>   
> -		/*
> -		 * Now that it's confirmed that OLDI is connected with DSS,
> -		 * let's continue getting the OLDI sinks ahead and other OLDI
> -		 * properties.
> -		 */
> -		bridge = devm_drm_of_get_bridge(tidss->dev, child,
> -						OLDI_OUTPUT_PORT, 0);
> -		if (IS_ERR(bridge)) {
> -			/*
> -			 * Either there was no OLDI sink in the devicetree, or
> -			 * the OLDI sink has not been added yet. In any case,
> -			 * return.
> -			 * We don't want to have an OLDI node connected to DSS
> -			 * but not to any sink.
> -			 */
> -			ret = dev_err_probe(tidss->dev, PTR_ERR(bridge),
> -					    "no panel/bridge for OLDI%u.\n",
> -					    oldi_instance);
> -			goto err_put_node;
> -		}
> +	oldi_pdata->tidss = tidss;
>   
> -		link_type = get_oldi_mode(child, &companion_instance);
> -		if (link_type == OLDI_MODE_UNSUPPORTED) {
> -			ret = dev_err_probe(tidss->dev, -EINVAL,
> -					    "OLDI%u: Unsupported OLDI connection.\n",
> -					    oldi_instance);
> -			goto err_put_node;
> -		} else if ((link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) ||
> -			   (link_type == OLDI_MODE_CLONE_SINGLE_LINK)) {
> -			/*
> -			 * The OLDI driver cannot support OLDI clone mode
> -			 * properly at present.
> -			 * The clone mode requires 2 working encoder-bridge
> -			 * pipelines, generating from the same crtc. The DRM
> -			 * framework does not support this at present. If
> -			 * there were to be, say, 2 OLDI sink bridges each
> -			 * connected to an OLDI TXes, they couldn't both be
> -			 * supported simultaneously.
> -			 * This driver still has some code pertaining to OLDI
> -			 * clone mode configuration in DSS hardware for future,
> -			 * when there is a better infrastructure in the DRM
> -			 * framework to support 2 encoder-bridge pipelines
> -			 * simultaneously.
> -			 * Till that time, this driver shall error out if it
> -			 * detects a clone mode configuration.
> -			 */
> -			ret = dev_err_probe(tidss->dev, -EOPNOTSUPP,
> -					    "The OLDI driver does not support Clone Mode at present.\n");
> -			goto err_put_node;
> -		} else if (link_type == OLDI_MODE_SECONDARY_DUAL_LINK) {
> -			/*
> -			 * This is the secondary OLDI node, which serves as a
> -			 * companion to the primary OLDI, when it is configured
> -			 * for the dual-link mode. Since the primary OLDI will
> -			 * be a part of bridge chain, no need to put this one
> -			 * too. Continue onto the next OLDI node.
> -			 */
> -			continue;
> -		}
> +	auxdev = kzalloc_obj(*auxdev);
> +	if (!auxdev) {
> +		ret = -ENOMEM;
> +		goto err_free_pdata;
> +	}
> +
> +	*auxdev = (struct auxiliary_device) {
> +		.name = "oldi",
> +		.id = oldi_aux_id,
> +		.dev = {
> +			.parent = tidss->dev,
> +			.of_node = of_node_get(oldi_tx),
> +			.release = tidss_oldi_aux_device_release,
> +			.platform_data = oldi_pdata,
> +		},
> +	};
> +
> +	ret = auxiliary_device_init(auxdev);
> +	if (ret) {
> +		dev_err(tidss->dev, "OLDI auxiliary_device_init failed: %d\n",
> +			ret);
> +		goto err_free_auxdev;
> +	}
>   
> -		oldi = devm_drm_bridge_alloc(tidss->dev, struct tidss_oldi, bridge,
> -					     &tidss_oldi_bridge_funcs);
> -		if (IS_ERR(oldi)) {
> -			ret = PTR_ERR(oldi);
> -			goto err_put_node;
> +	/*
> +	 * Create a device-link between the primary and the secondary, so that
> +	 * the secondary will be powered on when the primary is used.
> +	 */
> +	if (companion_auxdev) {
> +		link = device_link_add(&auxdev->dev, &companion_auxdev->dev,
> +				       DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_AUTOREMOVE_CONSUMER |
> +					       DL_FLAG_AUTOREMOVE_SUPPLIER);
> +		if (!link) {
> +			dev_err(tidss->dev,
> +				"device_link_add failed between primary and secondary OLDI\n");
> +			ret = -EINVAL;
> +			goto err_uninit_auxdev;
>   		}
> +	}
>   
> -		oldi->parent_vp = parent_vp;
> -		oldi->oldi_instance = oldi_instance;
> -		oldi->companion_instance = companion_instance;
> -		oldi->link_type = link_type;
> -		oldi->dev = tidss->dev;
> -		oldi->next_bridge = bridge;
> +	ret = auxiliary_device_add(auxdev);
> +	if (ret) {
> +		dev_err(tidss->dev, "OLDI auxiliary_device_add failed: %d\n",
> +			ret);
> +		goto err_link_del;
> +	}
>   
> -		/*
> -		 * Only the primary OLDI needs to reference the io-ctrl system
> -		 * registers, and the serial clock.
> -		 * We don't require a check for secondary OLDI in dual-link mode
> -		 * because the driver will not create a drm_bridge instance.
> -		 * But the driver will need to create a drm_bridge instance,
> -		 * for secondary OLDI in clone mode (once it is supported).
> -		 */
> -		if (link_type != OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) {
> -			oldi->io_ctrl = syscon_regmap_lookup_by_phandle(child,
> -									"ti,oldi-io-ctrl");
> -			if (IS_ERR(oldi->io_ctrl)) {
> -				ret = dev_err_probe(oldi->dev, PTR_ERR(oldi->io_ctrl),
> -						    "OLDI%u: syscon_regmap_lookup_by_phandle failed.\n",
> -						    oldi_instance);
> -				goto err_put_node;
> -			}
> +	tidss->oldis[tidss->num_oldis++] = auxdev;
>   
> -			oldi->serial = of_clk_get_by_name(child, "serial");
> -			if (IS_ERR(oldi->serial)) {
> -				ret = dev_err_probe(oldi->dev, PTR_ERR(oldi->serial),
> -						    "OLDI%u: Failed to get serial clock.\n",
> -						    oldi_instance);
> -				goto err_put_node;
> -			}
> -		}
> +	return auxdev;
>   
> -		/* Register the bridge. */
> -		oldi->bridge.of_node = child;
> -		oldi->bridge.driver_private = oldi;
> +err_link_del:
> +	if (link)
> +		device_link_del(link);
> +err_uninit_auxdev:
> +	auxiliary_device_uninit(auxdev);
> +	/* return here, as the rest are done in auxdev's release */
> +	return ERR_PTR(ret);
>   
> -		tidss->oldis[tidss->num_oldis++] = oldi;
> -		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
> -		oldi->tidss = tidss;
> +err_free_auxdev:
> +	kfree(auxdev);
> +err_free_pdata:
> +	kfree(oldi_pdata);
> +err_free_ida:
> +	ida_free(&tidss_oldi_ida, oldi_aux_id);
>   
> -		drm_bridge_add(&oldi->bridge);
> +	return ERR_PTR(ret);
> +}
> +
> +int tidss_oldi_create_devices(struct tidss_device *tidss)
> +{
> +	struct device_node *oldi_txes;
> +	struct device_node *oldi_tx;
> +	int ret;
> +
> +	oldi_txes = of_get_child_by_name(tidss->dev->of_node,
> +					 "oldi-transmitters");
> +	if (!oldi_txes)
> +		return 0;
> +
> +	/*
> +	 * Look for primary OLDIs and create devices for them. For dual-link
> +	 * cases, the primary's create_device call will also create the
> +	 * secondary device.
> +	 */
> +	for_each_available_child_of_node(oldi_txes, oldi_tx) {
> +		struct auxiliary_device *auxdev;
> +
> +		if (of_property_read_bool(oldi_tx, "ti,secondary-oldi"))
> +			continue;
> +
> +		auxdev = tidss_oldi_create_device(tidss, oldi_tx);
> +		if (IS_ERR(auxdev)) {
> +			ret = PTR_ERR(auxdev);
> +			goto err_destroy_oldis;
> +		}
>   	}
>   
> -	of_node_put(child);
> -	of_node_put(oldi_parent);
> +	of_node_put(oldi_txes);
>   
>   	return 0;
>   
> -err_put_node:
> -	of_node_put(child);
> -	of_node_put(oldi_parent);
> +err_destroy_oldis:
> +	tidss_oldi_destroy_devices(tidss);
> +
> +	of_node_put(oldi_tx);
> +	of_node_put(oldi_txes);
> +
>   	return ret;
>   }
> +
> +void tidss_oldi_destroy_devices(struct tidss_device *tidss)
> +{
> +	for (unsigned int i = 0; i < tidss->num_oldis; ++i)
> +		auxiliary_device_destroy(tidss->oldis[i]);
> +}
> +
> +int tidss_oldi_register_driver(void)
> +{
> +	return auxiliary_driver_register(&oldi_aux_driver);
> +}
> +
> +void tidss_oldi_unregister_driver(void)
> +{
> +	auxiliary_driver_unregister(&oldi_aux_driver);
> +}
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.h b/drivers/gpu/drm/tidss/tidss_oldi.h
> index a361e6dbfce3..2069bd46aaae 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.h
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.h
> @@ -36,7 +36,10 @@ enum tidss_oldi_link_type {
>   	OLDI_MODE_SECONDARY_DUAL_LINK,
>   };
>   
> -int tidss_oldi_init(struct tidss_device *tidss);
> -void tidss_oldi_deinit(struct tidss_device *tidss);
> +int tidss_oldi_create_devices(struct tidss_device *tidss);
> +void tidss_oldi_destroy_devices(struct tidss_device *tidss);
> +
> +int tidss_oldi_register_driver(void);
> +void tidss_oldi_unregister_driver(void);
>   
>   #endif /* __TIDSS_OLDI_H__ */
> 

