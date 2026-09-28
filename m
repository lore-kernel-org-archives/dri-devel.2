Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2E4CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D4C10E67E;
	Mon, 28 Sep 2026 11:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ylic3vqp";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t5iXGnUz";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C4110E67E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:59:14 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68SBAgpv1608470;
 Mon, 28 Sep 2026 06:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XhQmSMwK/wcXyrpDCX0vM4dlJxeQaxDAT5MvL+01a
 l4=; b=Ylic3vqpL3IL2W4vycC2HkltNxtWRKh5C9wqK0sq8t0ncPGrak/ao4mc5
 3GA7mtGFTr02n0fwdcVpwlguM44n8onBwXcWSqqPe2Va5J+7gpY8koee7sx9bpFm
 cuX2M1LJJdc7pEujdRxUCpVFiFdS8ASh7aSGcQxwsJIz7em34VkWk9TE0oBao72O
 6sh84iZaLUnr+tpDaPIlHQe6f3LMiqCjB6qIf36NG0If0XpjSO8qBqk0uduZYwrV
 wjjRP3/0lOsbQctSTf69EOnwfh/ZBKSAEhmo02QkcQiFus/Mw0kgL83ELunJH/Sg
 E3/MnZjrX2vySFyUx3dx8VVhHFI8A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gxy2nnh3d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 06:58:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmhIM9dBSsJkSGLPucjVwdjBJYj96sjMzdK8hUhFsuRUZApY9u9keTSypx+kMuPF63ZvKEHrGCmI/SY9O9jB5qH2uXl7tfn3zz9fjyt9gvM8hvA6oEv/3s8/GBjKdFWbH5FQCSR2ECBTzFgxRDtLY5t6HmCAIadlru7iB9VeRgro5BMgs2qu30e3MVxK203V5t1FsS78e4tfuNILNg0IabztG9I/m6+bTDasc8NiDaNYeMntDkmeUdyznum+1EHM6PLtwKa3iZ5Sgya0JcZ9C4iMBLo8fOZzL+ipmkwPY7ADAGfw/hDPicHEaVOy1Ed+ry2eA8A3UCtoqgmCAvKIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhQmSMwK/wcXyrpDCX0vM4dlJxeQaxDAT5MvL+01al4=;
 b=OWjZZAOY5NmN2tW9shu1T9WSVjczct12ClV9oOija4UXH25HpQ5FDr4qwRsqFxCw8S1RD3p8kt1fIjfTZQwZzG7AlKzhuCeGvd0TSIuA1UNPnQT25U4pv3oBKuxwtHh2Hz5DODuNVek3gaa9jv9JxgRM5rDhO8PDurq1xDxS6CGXsMVbP7ZddVAyrqrX9xKb+dP1Y1wt8yIPuG9+cX0RlQ9OURwdAXllOz3asUyRA2XyXLWXMVpPyQTSD1HbrskbfhAtHAPYt/HEPxEuFl6hzKI4q2H4V4DgDJMLQquInxZvgL471CiX1XttmQGI5Gh0lSVphwjj1d4Uyk/rayWGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhQmSMwK/wcXyrpDCX0vM4dlJxeQaxDAT5MvL+01al4=;
 b=t5iXGnUzgSjs3j31rMlbP4UhMnILyLAQVtlSqCfMpdKexiGZa4XxwBXew1xtKYkg70ESSacxAxTsWJPiu4mK7xr1vW6jOwOo+eJ23D20jvokyUkriQyQZy3Phu8RTWcqkhjAEgrTm1ovJYFrkpBygaktKd220GvL/Q7l7/kO6cg=
Received: from SJ0PR13CA0174.namprd13.prod.outlook.com (2603:10b6:a03:2c7::29)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Mon, 28 Sep
 2026 11:58:52 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::3) by SJ0PR13CA0174.outlook.office365.com
 (2603:10b6:a03:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Mon,
 28 Sep 2026 11:58:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 11:58:52 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 06:58:36 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 06:58:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 28 Sep 2026 06:58:36 -0500
Received: from [10.24.52.205] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68SBwVj53071038;
 Mon, 28 Sep 2026 06:58:32 -0500
Message-ID: <a8e73216-8c65-496c-af62-497ac2108b30@ti.com>
Date: Mon, 28 Sep 2026 17:28:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] drm/tidss: Drop WARN_ON() from tidss_runtime_put()
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
 <20260903-tidss-pre-beagley-v1-9-93928baa8b12@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-9-93928baa8b12@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1566956e-eaa2-40d5-486d-08df1d57dd50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|23010399003|36860700016|1800799024|56012099006|10067099003|6133799003|4143699003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: yUIjl5j7NKC81xQv5tJL+BFe7d7IWeqA6N3ABxocNNi2rQ6YChm3jJdrvJWo2YJgLIb/GDPoy3Q6f31oube9I4k9ChKiGtD4OeOPbCgLZGgwR76ab2kdUCt9DkLUCoKcPuqh5TwfhG3HI6R3TGCYJonv6rkQrLJoBgLhzbwnOqkl6AwwpJska5uVLYyp6fFCsMwjb06Eh9E5xnCsMq9kDmpdLWq4pQaMe4VoPOf+c+dVm2R2ggxGgf7vuaE88pnNDszxKr/P47e23L2Fg8ENrl86LSGM9l+6oPoVNt5eFPsSQlZJCYgctPMveAMbH983uKxlcobB8SljA6Q0IGWiazjvPi6cKQR4HyX+mKy4Cxk8Zp3DcVOYtQCLJjJ20QyzTUSIodCZ6VVK69GIJV8vmFvi6peykY/LsglES4dm3Rj+W1eP0Ly5Bn38vLXwmpzUFCLLOnXCxOilGQr3ocjsr5ovOPPGdbvZDXqnX8obr8wjjLSOgCyZAgsuY1MZ/TK5SZ8BpiYVAROVJh8q0epDT5Rp6bSj6Wx1Rf1BqdfOOCo6HhJfSvzSE6ElY2eW0VKVxWqJhRcC9oHBCCznDbADoLS1EVpq555eWYLsb/dHp7Ik32I0KvKyAcHc5c8xJqMKAUSi75TY4QnZ5dQ7JpRfuNIC7TlGcXuFlSTVIeYgG1CbfaLoV6Dfeo9TajWlCmUQDR2LIleFYrE+dakjIe37m1ay4vVVidbOGEJ9tcahYjH2nUup249VvY98VkrwOXME
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(36860700016)(1800799024)(56012099006)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: soXx6k1UB5xVMfz5kkWGI1PDck46W45u8xm4LUyAkQG4VMrrxM0dbhzXP8fjnR2VctGYShjdVmayn3Mz2vRpNoC6YsdF44oONQxscC6lp85pRcpE2CqjnaxCWrzqkmPlDXGIgvKd3MX0XrHfW3+A+bXM5L31dYo362vi/mV2xqa15ax2Q3v2Pte7pgBw/RQy9PsC2ERpGQxuKp2Jxv/EOu39rhD9cWddP0zIHhUrE7391KeErBxWScbnhGAZ81oL0iU8mD51G2e0iyEMZCjemY7Q29198G8+W/mIQVhW3yAqoQl521jqFU4olM8giEtf++UMzQ3g9kYfRzEMN2nibY+EOEwUJ4HdO/D1k9VOfG7F965oi5tvWYAoEF+qkQDu95GEyBG3BdUw7vqqsJBXvqhi2Wo6N5vOqwBTwULL+efMfVEk0pJu4SKiDizemV/m
X-Exchange-RoutingPolicyChecked: xYzimEWU/X/C1TeIMWlhsUp34+03p5dyXVCliVfvOQ3O5zHtLtbpPMjoIP4CKsMQT5lApKvECvhQnOdIv/iNJli8/R2iz4ZYJfDZL3atGu+GZ0KcO3gbGF7LUkJdisNjquRRXQWYt+hBG/fQocYDrZm1IKybVsr1zI/fiSMfvgDMIhUKMkis/eZddr2vMkU6ADpf32PPfKaTYiy8sRrWt0c8u4+dpeSmwllOaMOqjz7aNaKog8hq9hwprMmPwr5fq13Ky5LloRww0U0Bc68GF2KIKo+TKON7Z7C3daHuGy4zX/f2TMnJhH64VnI6PIUaI7HeOw/fS5VOopp4mm5UhA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:58:52.0966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1566956e-eaa2-40d5-486d-08df1d57dd50
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfXxBq22HaGj8VJ
 btSmTux6P2EAJIYXV96bmkiid1kMPkfSQQhpI76pWHwnQtfE3t5Lo+GWWCAzyGmMz9MzAsv4c9b
 d0KGBac1brQz1qLnO4RUj8HhZErrtPU=
X-Proofpoint-ORIG-GUID: k8DINqpRMhu0zIZw52nMWnc5UZ571f3p
X-Authority-Analysis: v=2.4 cv=RLgmjIi+ c=1 sm=1 tr=0 ts=6aba5682 cx=c_pps
 a=bXbGeLyqALV9C4BWsqKi7Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=P1BnusSwAAAA:8
 a=sozttTNsAAAA:8 a=a2bONkngdcLKCgN6WFIA:9 a=QEXdDO2ut3YA:10
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: k8DINqpRMhu0zIZw52nMWnc5UZ571f3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX6j2mcSQrxZQH
 X1Z6Cc8KBJo+t6joi5m2ux18BNVFyDKcgDpkLV809t8WeVUpfSp8J8w9P6MjFemPxUCmj1WcWwb
 F/GOfwTsegVq329zVcvb52evpURDTrmR6y1l4WOh69K4fBvOLtndJ70G/0pd34Y7xIb03RfQ5fF
 tvhCAdXSLbynEG8GFc2nQQXElQYHcTIn3M+6JCSrYBNtcD6cr2S5X+5UX0SBu4TpZ6M5VHalGXU
 eWGjxswoJdMQrc4aPSJfelx89f7LCf1t9yqOf+GesEUUfnV46M5p+2VsmyoxQQvEc6L/6/vlC8r
 BHrGYRmnDpVZs0MlXtsS4FuiaDG1OSReuDhKB4eeobAAHIZ8ls+Y/RSIFJIaRc87w/F8eg4JHZp
 iiSsqz5IyAlncPhupBDy1HohOo8EZpg2p6Fhh+Q0pG936GoPefKeX7Nu8r4B7sFazOb2dfIyQSV
 J1/mKNBdHKTwmOYobPw==
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
> At the moment tidss driver has a WARN_ON(r < 0) for the
> pm_runtime_put_autosuspend() return value, to catch unexpected
> situations, and at the moment we never hit that warn. However, with the
> upcoming change in tidss_oldi.c to change the OLDI to an auxiliary
> device, we will get a child-parent relationship between tidss and OLDI.
> 
> The OLDI aux devices are children of the DSS device, so when an OLDI is
> active, the DSS's child_count is non-zero, and
> pm_runtime_put_autosuspend() on the DSS device returns -EBUSY. Which
> then triggers the WARN_ON().
> 
> To avoid that, drop the WARN_ON. The -EBUSY is not an error, and it's a
> normal situation with parent-child devices. Also, with a quick grep, it
> looks like almost no driver in the kernel checks
> pm_runtime_put_autosuspend()'s return value.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_drv.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index 5cb3e746aeb3..44b0b009c29a 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -40,10 +40,7 @@ int tidss_runtime_get(struct tidss_device *tidss)
>   
>   void tidss_runtime_put(struct tidss_device *tidss)
>   {
> -	int r;
> -
> -	r = pm_runtime_put_autosuspend(tidss->dev);
> -	WARN_ON(r < 0);
> +	pm_runtime_put_autosuspend(tidss->dev);
>   }
>   
>   static int __maybe_unused tidss_pm_runtime_suspend(struct device *dev)
> 

