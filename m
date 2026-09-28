Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E29CA5FA6
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E6610E044;
	Mon, 28 Sep 2026 12:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O9SKavIA";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RgQgWiXl";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFE910E044
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:01:45 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68SBAao81608445;
 Mon, 28 Sep 2026 07:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=C9621SMqAeo3wUB5AYjRk4Z4hil8582xDb0r1CJgc
 iA=; b=O9SKavIAJfPO0fGNtsZ2ftXFY3ak83PY1FL4H7Wf/IxLDJxtMfV57u7ct
 bSo2CF0Rdctk68jH4Ad0OqsI/nsc7XfOOQN4+xlqcL4IghZUIG2MFPvEDOxMW17B
 ODchNN1qrGw6+mQSsETFB5Pp24rauXm0rO1QNSVgtHlDNHOLdOzNd3SkNlI12WTP
 36XrXH7rk/KRNNs90FzKc0fIEz3sTAjqTZ92uurfLCCSvjBhliZrZtCUj9BscA5G
 dBklO/dpYpl0d3oHViO9LlXdZSeyyOU7juGqeim3UXwCzJLBbXbQrsHQhgkUG8v5
 bf7+tX+ThA+LSlwfwvFild4taM0Iw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gxy2nnhnp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 07:01:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuxB+BQeTkscHs7AmgYOdpIeB9PzD0EWKHJxblVjaeqc2VVQmf4a0mTkVnA/HSG3vTd7ZgBbjz0XyrmLdKkpESMfp/AlAq2a0x8NE7XjNDp+eiiKtgL0GhCGKeQZtRYLIiIjPkHubmpbNA6w7W8U1usNe7bUXRSq4oG4wg3KmLlUblDn/oGxMmzws8fgRadUAMGyo2x4C2RfoTBqfOoaMHwrExttzV8rO6RpGAc0kpO3eSL4NAlefIcUJbcdPWsttj0pZG4GQVk4x51cHKRr5lEDOudu4hJTMQkHNiF4YQWYgOL8Eg7ag4VjfqL3LxYV67NnHzjOJHBvzIAkAOp8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9621SMqAeo3wUB5AYjRk4Z4hil8582xDb0r1CJgciA=;
 b=cFWBl6Ud5UF7NgS9LF4ojLE86AloAYlz9udBXtyz74B8VBv02dHkq1o5Rvotvz6kJRClMZmD7bsNayNDtMHDDJ2EmirltewiWAzu99/zDrSX+Z/ZIks6FZGdnxm0CArpMiEhVj+5IwcIGj9mdeMF1Rqx5UxORrSFeiUnMeZftGGjL0BIen37yuFgrTW1XSCQtnMt0ulSQuGhs97Ecrcnre0NK3uSvnf9dg/lOHNmpDdfE2dcnzAHKP7pG6O9biwkXWQCYg7pXSL88mxohrRAM9dEbIFNqW4PK80NTbZMyffP43MEYBPYqmnggG7SN/6w47v4AqXGNuKvzbtZ0c119w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9621SMqAeo3wUB5AYjRk4Z4hil8582xDb0r1CJgciA=;
 b=RgQgWiXl03qusCu8yyk9XOLH8Y25TPDw6m6DnXI9hIT0XCA8Aq7ppPTYIHTIatCbKoZsufqDQIhthhiYamVLkn92ad/OYqGwbNRl+tfW7+jEIJmgHpjM0lJYuAke9P6YzZuincvdnT9EqM077OvgE7EmZS6DWt3TyVlfId9NBYU=
Received: from BN9PR03CA0743.namprd03.prod.outlook.com (2603:10b6:408:110::28)
 by MW4PR10MB5775.namprd10.prod.outlook.com (2603:10b6:303:18f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 12:01:16 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::1c) by BN9PR03CA0743.outlook.office365.com
 (2603:10b6:408:110::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Mon,
 28 Sep 2026 12:01:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 12:01:14 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 07:00:44 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 07:00:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 28 Sep 2026 07:00:44 -0500
Received: from [10.24.52.205] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68SC0d973989099;
 Mon, 28 Sep 2026 07:00:40 -0500
Message-ID: <ae149b60-2e57-4048-9264-b31463abe2ad@ti.com>
Date: Mon, 28 Sep 2026 17:30:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] drm/tidss: oldi: Fix missing of_node_put()s in
 error paths
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
 <20260903-tidss-pre-beagley-v1-10-93928baa8b12@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-10-93928baa8b12@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MW4PR10MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: ab92bdd6-d5d8-4abe-ad46-08df1d583235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|10067099003|18002099003|22082099003|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: dQtt7ArKR8MLEC54ogybDdrqZiEf6o2VzVlZj8IXTuZnEkl9i8BEb0dMgnqYq7fyGUto7zknDUwe8fuKzqXp6EbVf3+xgv1Vq/HRGvrXRAgGE2xkw/cpbIZdWCBz2r2sV40XFfTIStSjFySukbZszLXZn5XXszCNo5d99QAW5JIi8wA2jy6Yl0uq6/JMs0XAXvhIODL0oPzu/SKR5SxpW4UDlWUHzW2R5V4QFvCJcxO2jLj+1ZwLk4Qjn9ubuyXD7QBOec3M7kcsOiyWZezH4uleae/ZtaymfUhzbx0cZM5XkjG/GNKrLjavo/dCVkkHbqrGdOmAFjF8v3MNDhhbpGStb9c5osobFV3vEESLTgtMBlIVKHQaeAvVbsEEdtNGlzaCl3mS8QuIoLYvNbP4ui3EVSCNnFp/PopxOiVq9sCAFTSp4Nc7Vkk84RrC5yCmUl2uurvu2V4OEsYj1fAnGgGp7jcwb5s7cQb5LTZCPJY3KRQrxSMXvxdtMBncU2flL0fnnmWE0C5ckuVhAgwcY+RIkY52GBbPrNFFBwQEHoWoxnMc4FtEdm3ajedbJaXOifLOwxlreGCQNEeJCX7xwfEnUz5QHRBlqU/2oQ2mry8MpLVhn2ogG7wUN56aAqsuxPuJu+G28PXmcm9Xz4TVb/peYCkE2gs6sh3wui+wCMvxEspkI95xHLSQXGmmDnOgM11wLqWwdM1ILp4GHCIFpynSjC/5RFx0Sv3lQJ6NGkx2lRcb8Bbzbp/jf4Iynap0
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NlWIUa0M7EuXrje9I00rAy/Ze3W6/Nvk5kou8MyKdWGymYrN76iFip7pA6ZDFU6nbVSu4TGb/LwvrXYmY5sgd42TVMAcG8TieQuvVlFWS7vnajBxIsUACwsn/XFpgKGLrgNZdaKYBlVfjD1z/L9gazRW5Uny7oNwDg0vgZ8Cg6lxQv8zKH7a7A8H3oqTC0ZUIPI63HsJJk62dXy8sQqNNYSawWyDXi5/QCdBinK8BEiAm6MtYB7cARIIjgLV5ArYcKrTmA95P/PdH57bDL5LqCK10EsuIKEpSLCoe64gyQR2I6xrwH8XDzI9x7L2mdzGHXxEy6h8AStk3fdRolfkCyUiXXdtTKY7Vi9Cyvgk0Wm1k8vepeIB9hak1udwqnDUghGUycJSNhvPYeeqPQVpqWEI2qlSZiJlfPzC89c9aKq6GwqpoQFtAbCumGaAxpBz
X-Exchange-RoutingPolicyChecked: 17yYEZk4fSB1lfz2mlwGDHkqKNR95kubfU+LTAu5nRrzyKQRz2XjeGntsEKBxdIGr74BDXg1kcwbfSI92TV1zArM7CFwtKhiOtG6ZPADe+m/z9nCrUAtJshe0IBoVGM9iJeyKzv6hzcIBSHLeVHfwJKLb8tD4YwVSXQC6kM4r6gM/0GlF9nebHlKhqHIdRE6q73su/7cFed/kyLHZC0c233Yxk1qhPH49k4YtKhsCCSWnPrIzImjerWVFm/nBuWkd/F9nwLqKAjkU1e1vTDmibS9UPfz6335zFz6eu4FmU63uEplcDFfZXEbN0lDrebiOL6NxekaRfV9pkRRTY/cig==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:01:14.5357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab92bdd6-d5d8-4abe-ad46-08df1d583235
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5775
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX2Fom5LvSM5BJ
 2ko7iAu+GMNt1zjr+YX6Fwplz6GRg48yFTFEVivv791qP4PvaUUQS7AqT/OuwjYCeKsRhnZu75y
 32P1qGIuOK+uqMQ6mZbEr876sgndws8=
X-Proofpoint-ORIG-GUID: q6O6GXFjElRPdv_gj0pSKDKxal3manAt
X-Authority-Analysis: v=2.4 cv=RLgmjIi+ c=1 sm=1 tr=0 ts=6aba5719 cx=c_pps
 a=klJJBKWT8dzIbr5yswcz1A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=P1BnusSwAAAA:8
 a=sozttTNsAAAA:8 a=LeylCpjmjEuS6KFD2QcA:9 a=QEXdDO2ut3YA:10
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: q6O6GXFjElRPdv_gj0pSKDKxal3manAt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX6lUL2kYRqFD8
 dQuOPBy3HknJmD5lrHDOznbBN9Ncs8vgITwKlZGjaJEINWJLhW9SUB50tfUpac25ogGfmLe1Wx5
 jnQDxKEi4q7KFvv7i0oNfqpuxEbKRyOs6X3lXz2yfy/B4ic+9yDbjSGQ92Zhw9KssyIKs08ZkQH
 Rhstp7FDuLnWixJbPO7xQgIT03H0ljvsa0ZVAiF43Hdf4IM56W7vBTb4q1bHKEMYb8H+F6uw9tG
 H4NMyvydZenzBNtn8I/ciXIHyYQDeGMYjskrwAK/wBhrOqp+W2WvOz2k5JYmYcc/0Wa6gEsQj2n
 Tq4sikNQ4NQ5GvSNjgIu+o6WSY4tlOPBcyIqgnElCIhg7FGZEuHvqLR3JaYM87mfVXArJSvoP5P
 ySiGlex7Bt9BWI3SnfCdlz5TKXAU0mzzKaKm6ShxSH+ITM5WR2wrHQKnS7Ayb2oLeSJfxtZKGdk
 qz7YhenRqPWnUOj8Tog==
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



On 9/3/26 17:40, Tomi Valkeinen wrote:
> If get_oldi_mode() errors early in the function, we don't put the
> 'companion' device_node. Add the of_node_put() calls.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_oldi.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 624f1646fb07..82b059f85244 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -383,12 +383,16 @@ static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)
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
> 

