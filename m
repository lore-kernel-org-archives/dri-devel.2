Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8DF606A331
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qiKPyzWr;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NgU32XRT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795EF10E683;
	Mon, 19 Oct 2026 21:39:04 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A7210E68C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:32 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLc3mC780618; Mon, 19 Oct 2026 16:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xFuhxS3mmVtQpfdYNVFMvW4qHBo/W2/2cDEroY0Aa
 YY=; b=qiKPyzWr6uswkK791XAB2G/HdA7E84kgffKvk95Fk0M63doU6ibOIH4rD
 Ca5mKDnyGOu4fEXX9BtVJqFf5K8RcrnTKBD88sp22inkUqcuz7UYBXhj+c7CPh4h
 8BOtf/jr6a91I8Y2cG+EcbSvanLQ0196dnbGpJ2Qa+7NE46rUvFFMv5/LOeM4fBv
 VmSCMexz6YxDe9U+14/ruD6mxt2Hj49PlvIo3gXVIKadwx98p+7AepSz17FaCot2
 PgjHZIZ61oqz7SpZB7IRM+400Lcl/22zQ51Fv6mg8FOpKQl16VJ0jq1SzWLULncS
 PH6/lukAASGmxVTp1t1aRoa4luFRg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hdjbkuqcf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmL2mz84Ol1u3Zq7ZP672gtffOXb0Wd8lEh+1yEv8+2XLxnQ0itBD4pnt6ffI42QFlvQ5wkHtsZSO+TbZZLKaTOnfX5tpHNQq4Jb470E+YsNDE07GWZN5ZU4RlUbyvxRvh5PydzW8n2NTfVdrIt1/PIAKsEu4ACu6VIT8XJwyIPYf2nVvDgsSaONq0+gOs5OKkeO4/sWEPArnsMRq6QWmeFJRvyhcoFyBmcQv2yaOkcWIoQGXxUjc6gFA8beXDD9lu95XkndxVMMx+h4dQ0L+QAQCJW9MkPvYefmLfryArOVrl8AbyZAIHSilDyvcZDaH12xomw1ATRvHGHpruG1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFuhxS3mmVtQpfdYNVFMvW4qHBo/W2/2cDEroY0AaYY=;
 b=ikrgi2QCRuoLsMJzVrs7DSBgaovZ8BIfD4ZdE2G5wxI1wYtSyDcCVgEngOfc4TVRkOCVpgQ1Hy2EiktI+Y+DJ2cRdkoD3TOD74rEN3Tm3hgFxBlta/EFsE9sTcaGQAWzKdMPOFvAHY3oNzg0+5M8hM65RmB4N77mlh2JR3iyqF44YJvoolW4hlrzLnzSmW/zcHckxT/aEgvwaAWF0OZKzLQpV9qDCQDSl12vxRNskoB/0CFXY3/+iUKJ7Ty2+8n68ZFUS6gxBj5rwu3cYLVkD3tS2fQAw0H13bQVPcvdgKUBHSzUIDejUsiT1qpQMQJUX1cSdCTfIgSE4o7H05gaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFuhxS3mmVtQpfdYNVFMvW4qHBo/W2/2cDEroY0AaYY=;
 b=NgU32XRTf7glIhVtKUyUb+/pQpqpAzXGJa8q9Ih6qvWPvhk9P7xTcsOIf/QLnY08uwJ6DDucY/GylRxwjHgUfzzxRXlx7aqMQlaQRyiGJze4JxJQRp7d/OZM+/su1ZiEtUb9vvZMboOGjWFhcsv2CczXvchTPMyFj0dL7AukF4U=
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by DS4PPF194C7D93E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:38:19 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::87) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 21:38:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:17 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:43 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:43 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbfuV325899;
 Mon, 19 Oct 2026 16:37:42 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devarsht@ti.com>, LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH v3 08/14] drm/solomon: ssd16xx: Expose refresh mode as plane
 property
Date: Tue, 20 Oct 2026 03:07:20 +0530
Message-ID: <20261019213726.4145532-9-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|DS4PPF194C7D93E:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dd91ed-217f-4d61-61a6-08df2e2949b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|23010399003|6133799003|18002099003|22082099003|921020|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: GJ0tCJ5Sx7mNSFx6CzVKQipa06BGG5YuOr53Wh7EsVoRS7doN//Af37yiWM0KL39X7CA5PRGoSQnTM6dXLuLW2qeKMx078+uh/Vxj0TN5+H+bhrAteWaPLOrhCRL0DPyI/SouXwLH2dprh0F5jHjz9UYfvJSp/I+ko5LIZ/QFm+Ce2X2G9vkovej5H53RbVZR2H0DiwQNO42yOdfPPI0RaVKTOwxWcYvLJT12CZKfIftj3CBmeD99It7j27Yw34slUU0eIW60OWPk7Q+6Hg0zmS9RboQUh2BvRRDuFBzliefMBDohG8CKjH/3C7+QDI2JcXpY7DFsPAEHhzf3InwnI7411eNlz0AIxABtaWVzBz28y1Napa2wm0aVcL+lolrqXySFz2i0y+sQTdoUGCuKPraNbiPDswm7UeiXRrC2Lf6VYvvT1NFcGoQda2+3WNGryxgCV6ZFO8K0qUGY5yviMQupxe6GhplznBNHPe6+FcJtWDfFQKBf3GpoclmhAuuCYFkTdE+pG30VGIiHFnMaYvHSYv5z6soNDJz0XKIl9GosY9hEe+fFq9fizxSUKJZ2E+yum+xq3+DleyiQ4PJO32X+pAEKPoSWTj1K+efv+A0WOOJvSfaDmew64pCMFg0zGrHdUbvgF4lwmRWHOLCCmbYDFxv5M5LHky0dnO60ela/3qjS6EEEFNlNosm0xuaJn9M0zQX0WAm9mkgVjUQxySauqJaVt1Qdsxg5uDc35PXV+wzZzTHY2jp7JmeIifJ
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(921020)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ku1LeEw4Nd5+QFZePBJJGtdlysie5tSh1DwvXDZrQ6m74buv2YWvbAPN/RF5xf+UxNLxbDXUnO35myFE4l3/brYASvuG8uO9S72bVED6MOKmGUD0NHTe6IMc43037W4KLADJKvvOp7NMGUg4HcrVH8IZruYXNB8jFGyfTFYPk7HZeRs6X2R61Gb+EJKp1I0E0WqMhqGz2y1Ldzr8uKie9/YD1DQbOA4Z/PTBWg+2IHWRkL7luTPpy8xvpYdH/IV4l+OZztjZqpBf4liWqDmBU7JFrBArFIMYpGUcjAAjmcU568xV+BQG3nzfZJufI27fdm6/pQBRRYyLS6LFnjTD/pAVHszJF0JtjaOvFvBS4dPvNfMfo/EwkEGbGnE84wC2ktgbywtaFErm96md2xvLi3QA05O+FoIopf4X1lUWQXIUlWJ4Ekr667RSiobI5/ea
X-Exchange-RoutingPolicyChecked: abJp7FiV95rAM7qSqq/rCokMSI8K7nQMp0WebwyYXJyT+tM6YEHOH3msTmWoqEgsHTOVksHKW8UamI6w6ChVIc0uU6c9QYAz/ipVrwPt7NYDNUNMz1dZof1ynPXnQyecXk9NDOeczffkNAOM3wp/Y5aitHlSBqXYaZ7obAOwRC0/SRD8HaZxlQSSpzor3OrLozVkh6A1P60culn5eG9bcnxA6co/QXzFaW+qBRXrujc61nL8vIiFBHlhJ15XROBNUvVWZrLOoEIzJ9OjIXMaT4JuWT/rcLmHdp/uO6BbiMO501jQENqICJzAyFb61ItDkfJDezzb9CcR66XYUcGsKg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:17.3559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dd91ed-217f-4d61-61a6-08df2e2949b0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF194C7D93E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX002f+2hSLmp0
 eqWLqsdUTdMBz2wXI3MIEXwswNTbemyDGRTXygC2pjw1yG9g9u3fgViOoMLNm3TH5zgoafjXqcp
 bzVbn0oLnnZEEzUFYma3bxbLWyIqLJABh1wHeU1kZQG76YANlpQFzPKZlsQIqKm8e5C+oM7WbfP
 LIXjQtpPVFkTR45108WERBPUCzOskMtcbdeA2K1MhlnYnK/c1r0wUy+BprubxFRDlJ2YP/I+1S6
 PQ+XyXZzQPjAG76nlDpRnXyfzMAwhQetRq5hDtuhzpOqKpSU2Y5TMG4LOwIr4Av+PLyYXf+gSuC
 DPIivm8X1+MewCigMF8OAAdSFa+/+QVmyHmZRdxehi1CwfZ2MHWwW6cZSh+UB6G+8ZMLrlg77MT
 ldeHjhO4Jne1dpNtGzpQOtBhn9jOmrhDGNBPlNRvAc6i6xPYacYTSTt56q6rBnHuBZ9oatzNPN+
 3XzGkzPmW+ZGPk0rXHw==
X-Proofpoint-ORIG-GUID: irTBPyqV2oqv_9qk3js5m1NSXUICrmz0
X-Proofpoint-GUID: irTBPyqV2oqv_9qk3js5m1NSXUICrmz0
X-Authority-Analysis: v=2.4 cv=Vsa2kO2n c=1 sm=1 tr=0 ts=6ad68dd3 cx=c_pps
 a=lV9semjb6HF4qJ8WeHToSQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=ZefhO2H21uGiRyTyvdgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfXwZBXwxndSyIW
 3nC9R9r7/UhVeEzY/76AlBMoqmyjwGlssdzJ7+Bk+/CvWFPoJWPPWPxkDr991Syt0IWKFTbaKDA
 fZnIvALZ7YGKCN/uQ6wTQsUcDfU21Ow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a DRM plane property "refresh_mode" allowing userspace to
select between partial, full and fast display update modes at runtime.

E-paper displays support multiple refresh strategies with different
tradeoffs:
  - partial: fastest updates (~300-500ms), minimal flicker, ghosting
    accumulates over time
  - full: cleanest image (~1.5-2s), full black-white cycle eliminates
    ghosting, most flicker
  - fast: intermediate (~1s), skips LUT reload per frame (loaded once
    at init)

The property uses an enum with values matching the internal
ssd16xx_refresh_mode enum. The default is set from the panel
configuration (typically "partial" for interactive use).

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Use kzalloc_obj() and fix formatting, no functional changes
---
 drivers/gpu/drm/solomon/ssd16xx.c | 142 +++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index 99f11b7ec03e..f53c67ae7d31 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -397,8 +397,21 @@ struct ssd16xx_device {
 	u8  *tx_red_buf; /* 1bpp red-channel buffer (3-color panels only) */
 	u16 *tx_buf9;    /* 9-bit SPI expansion buffer (3-wire mode only) */
 	u8  spi_buf[64] ____cacheline_aligned; /* DMA-safe buffer for SPI transfers */
+
+	struct drm_property *refresh_mode_property;
+};
+
+/* Plane state subclass: refresh_mode lives on the plane, not the connector,
+ * so plane_atomic_update() can diff against its own old/new state.
+ */
+struct ssd16xx_plane_state {
+	struct drm_shadow_plane_state base;
+	enum ssd16xx_refresh_mode refresh_mode; /* Pending refresh mode */
 };
 
+#define to_ssd16xx_plane_state(s) \
+	container_of((s), struct ssd16xx_plane_state, base.base)
+
 static inline struct ssd16xx_device *to_ssd16xx_device(struct drm_device *drm)
 {
 	return container_of(drm, struct ssd16xx_device, drm);
@@ -1430,11 +1443,91 @@ static void ssd16xx_plane_destroy(struct drm_plane *plane)
 	drm_plane_cleanup(plane);
 }
 
+static void ssd16xx_plane_atomic_destroy_state(struct drm_plane *plane,
+					       struct drm_plane_state *state);
+
+static struct drm_plane_state *ssd16xx_plane_atomic_create_state(struct drm_plane *plane)
+{
+	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	struct ssd16xx_plane_state *ssd_state;
+
+	ssd_state = kzalloc_obj(*ssd_state, GFP_KERNEL);
+	if (!ssd_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_gem_shadow_plane_state_init(plane, &ssd_state->base);
+	ssd_state->refresh_mode = device->refresh_mode;
+
+	return &ssd_state->base.base;
+}
+
+static struct drm_plane_state *
+ssd16xx_plane_atomic_duplicate_state(struct drm_plane *plane)
+{
+	struct ssd16xx_plane_state *old_ssd_state, *ssd_state;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	old_ssd_state = to_ssd16xx_plane_state(plane->state);
+	ssd_state = kmemdup(old_ssd_state, sizeof(*ssd_state), GFP_KERNEL);
+	if (!ssd_state)
+		return NULL;
+
+	__drm_gem_duplicate_shadow_plane_state(plane, &ssd_state->base);
+	return &ssd_state->base.base;
+}
+
+static void ssd16xx_plane_atomic_destroy_state(struct drm_plane *plane,
+					       struct drm_plane_state *state)
+{
+	struct ssd16xx_plane_state *ssd_state = to_ssd16xx_plane_state(state);
+
+	__drm_gem_destroy_shadow_plane_state(&ssd_state->base);
+	kfree(ssd_state);
+}
+
+static int ssd16xx_plane_atomic_get_property(struct drm_plane *plane,
+					     const struct drm_plane_state *state,
+					     struct drm_property *property,
+					     uint64_t *val)
+{
+	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	const struct ssd16xx_plane_state *ssd_state = to_ssd16xx_plane_state(state);
+
+	if (property == device->refresh_mode_property) {
+		*val = ssd_state->refresh_mode;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int ssd16xx_plane_atomic_set_property(struct drm_plane *plane,
+					     struct drm_plane_state *state,
+					     struct drm_property *property,
+					     uint64_t val)
+{
+	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	struct ssd16xx_plane_state *ssd_state = to_ssd16xx_plane_state(state);
+
+	if (property == device->refresh_mode_property) {
+		if (val > SSD16XX_REFRESH_FAST)
+			return -EINVAL;
+		ssd_state->refresh_mode = val;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static const struct drm_plane_funcs ssd16xx_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = ssd16xx_plane_destroy,
-	DRM_GEM_SHADOW_PLANE_FUNCS,
+	.atomic_create_state = ssd16xx_plane_atomic_create_state,
+	.atomic_duplicate_state = ssd16xx_plane_atomic_duplicate_state,
+	.atomic_destroy_state = ssd16xx_plane_atomic_destroy_state,
+	.atomic_get_property = ssd16xx_plane_atomic_get_property,
+	.atomic_set_property = ssd16xx_plane_atomic_set_property,
 };
 
 static int ssd16xx_plane_atomic_check(struct drm_plane *plane,
@@ -1462,6 +1555,8 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_state = to_drm_shadow_plane_state(new_state);
 	struct ssd16xx_device *device = plane_to_ssd16xx_device(plane);
+	struct ssd16xx_plane_state *new_ssd = to_ssd16xx_plane_state(new_state);
+	struct ssd16xx_plane_state *old_ssd = to_ssd16xx_plane_state(old_state);
 	enum ssd16xx_refresh_mode saved_mode;
 	u8 saved_border_waveform_idx;
 	struct drm_framebuffer *fb = new_state->fb;
@@ -1495,6 +1590,25 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 
 	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=(%d,%d)-(%d,%d)\n",
 		rect.x1, rect.y1, rect.x2, rect.y2);
+
+	/* Diff refresh_mode against the plane's own previous state to see
+	 * whether fast LUT preload is needed.
+	 */
+	if (old_ssd->refresh_mode != new_ssd->refresh_mode) {
+		/*
+		 * Fast refresh omits LOAD_LUT each update; arm the
+		 * one-shot flag so LUT is pre-loaded before the first
+		 * fast frame.
+		 */
+		if (new_ssd->refresh_mode == SSD16XX_REFRESH_FAST &&
+		    old_ssd->refresh_mode != SSD16XX_REFRESH_FULL)
+			device->fast_lut_pending = true;
+		else
+			device->fast_lut_pending = false;
+	}
+
+	device->refresh_mode = new_ssd->refresh_mode;
+
 	/*
 	 * When refresh_mode_init was set, use the specified mode for this first
 	 * frame only, then restore the user-configured refresh_mode so
@@ -1735,6 +1849,29 @@ static const struct drm_connector_helper_funcs ssd16xx_connector_helper_funcs =
 	.get_modes = ssd16xx_connector_get_modes,
 };
 
+static const struct drm_prop_enum_list ssd16xx_refresh_mode_enum[] = {
+	{ SSD16XX_REFRESH_PARTIAL, "partial" },
+	{ SSD16XX_REFRESH_FULL,    "full"    },
+	{ SSD16XX_REFRESH_FAST,    "fast"    },
+};
+
+static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
+{
+	struct drm_device *drm = &device->drm;
+	struct drm_mode_object *plane_obj = &device->primary_plane.base;
+
+	device->refresh_mode_property =
+		drm_property_create_enum(drm, 0, "refresh_mode",
+					 ssd16xx_refresh_mode_enum,
+					 ARRAY_SIZE(ssd16xx_refresh_mode_enum));
+	if (!device->refresh_mode_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->refresh_mode_property,
+				   device->refresh_mode);
+	return 0;
+}
+
 static const struct drm_connector_funcs ssd16xx_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
@@ -2057,6 +2194,9 @@ static int ssd16xx_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ssd16xx_plane_create_properties(device);
+	if (ret)
+		return ret;
 	drm_mode_config_reset(drm);
 
 	/*
-- 
2.39.1

