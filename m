Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190560A2615
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ITT1jOz5;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=GIDoNcFJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616A610E681;
	Mon, 19 Oct 2026 21:38:41 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FE210E681
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:29 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69JLbi1L023270;
 Mon, 19 Oct 2026 16:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=tfzyr62Net6ThX2E9ATUK8ijtFyRyHNdmRfvGQ6Wo
 Hk=; b=ITT1jOz5wKfWG7KPHo+318XYYTJ8MLuV3n/rWlkIeTG/0ZMjw+TOAQu7f
 dxTNOnxyhFHu9MEN43PZSxkNGy9pmlbKLH8IQXoE2AzpCt+LkApoFBuMZ/Qw6dFg
 MLKsijTFewRVRsyyr6IY1CTfDcS3q/iQECj4oQ7x/GzZVo1KW1sq9kcpHkePKspg
 UZVD+g4yw070wjQ97ft41So0vh2UEd2sPZxlKApaLikatCjtAJrdE6Eyrq+v4rzW
 TlaHiNtCRvqOBYV78iJ5c+tZjlk5iHgj+D+fzTIEe8c5flA00fkObK6DvRX8D49D
 ZaThi5tdI5oepd8Rr/lhCoKS11Rvw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hdjdabmve-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1eoX8uQWawSbH29GxBB3i0V13qOoP6R07eRaiFVxepiJFJFY/shJSLyDFyuV8Unp3+EPcj5WWhNQUeIoKdrjROTdY1QbTQJ3yj97cYpDVqs6+vhpBZBD0QFnqVwTXn2FdB9sFNeX08gMRAC13qOjuH6AJo6fjghqNxbj01fCrK41850e3Zn3kxJohheJfEIFCE/qgRvDtr5WJeViLY5qvkuVNYLx+/i76m7JuXkI7IVUrRYTHnvasNLgLReBfmR1/C9TqH2cdV/+EAFrD+wOphm6LjpRRZ2hdJ12haTbDrixAXE3XTNiy78PHLAfnk7kCj5gygWGbSMk2iKHAYszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfzyr62Net6ThX2E9ATUK8ijtFyRyHNdmRfvGQ6WoHk=;
 b=WXFDelASToB2KPIBjTVYHcbxjAID9wxSJhJ5eo2hJI8BYy3K3ksFhf4tDXQPHplOya7LdRR8cQ9yQm22tvoSoQjfYcoscR1UZUsdeEVRiGspUdPSobDHpL1HZHW1EXQ0VHgG3pLnPWYlKbYQZ6oMfx9Wh8nIWceJ0ichtYYzmzGRrc5IGBCXfj1a40uolxcnoj0fHiNGfvCgwmf/BEje2X5+sX9Ir0e57EgutPq/DpORNaJqz+/+xM+7yaEyqVaq8WJdPVC2xpGEBGKHAXnXu2QZ/j9pwDP1+uERCXdqQUW48yRsD5gkvLw4X2ZYkhSPW/qQGAtpne8TVFtEJCTJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfzyr62Net6ThX2E9ATUK8ijtFyRyHNdmRfvGQ6WoHk=;
 b=GIDoNcFJmNOIPRm0ZuAZs2zm++whUHFBhqyyk/Ifn4giHvfLrx9NL5shZgKPNjep+WMpRdRxokEX+yKfl0Uy/NeQix1ZAjQbUV3MeSDsSFxDYsK3Lj6YVVKRiVCb7bdw98VGpU7BZ9rJyq2Byv9qtzrSF1EoQ1KpakKHZ33SUJ0=
Received: from CH0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:610:77::31)
 by DSWPR10MB997801.namprd10.prod.outlook.com (2603:10b6:8:36c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:38:23 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::1a) by CH0PR04CA0056.outlook.office365.com
 (2603:10b6:610:77::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:38:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:22 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:50 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:50 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbn7n325968;
 Mon, 19 Oct 2026 16:37:50 -0500
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
Subject: [PATCH v3 12/14] MAINTAINERS: Add entry for Solomon SSD16xx DRM driver
Date: Tue, 20 Oct 2026 03:07:24 +0530
Message-ID: <20261019213726.4145532-13-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|DSWPR10MB997801:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e770108-16e7-40eb-8088-08df2e294c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|7416014|82310400026|921020|56012099006|261009223027099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 84SfVLrTusaHBGM4UByRup9DZvFH7E6mz1NgL99yeIGc4xaccG/Ckn97Eiu/NFw0OOOvTIrjSG65N+u2qIHO8CdTT8Vjk57EkSDDAvicni9R54n6uTo3XY+fd2q/bzrrFXPgTfUNAhVId6oLuIS6ujGk/4yTvw1hFMsb5mdGauscxAd/n4Ek0hQ1Mv77ltohRU8wUP4xzUnq6GungohWNqK3paJeK/+2BhP7kkADdHD68tyPg088NS55G558gdyKd0pfBhcUABhslxFt6S7vM7Op2ZdiZ0ZMgaJsxdFbFUyYT3YNKtsPnETqduodRGcEtXGhGYFBC7y443fsBgD8JC2ktXmxt/lcmynUwFjxnmZnyxpJZuMyfHkX1qoAhY584Rhuhi9GEsGOdls7ge4oUShCqYgMQPBR2ZIKGji72L+FgXDBucx1y9Kr2SrC2O1z4yAAGfaaSYbnaYJzRPNx6HfmcZByf3P89t4UwqUVAZflUgTAw48DtfvwWdbUWD4pA0bEjvc3zQq7p7rAUewMGaaID06RXBZU3GUMNysClpQmDmIjZLjc91lRlLjxhfyCfEd1AECc7KdOCR/CkDlGav0H+LuGe52qLLgClExxGJ3TGQ1LmzjStEP4GUEJDY+7x3YxFcjRhhrNaAe5KcLIv3+XN0OyhcEv3qpl8TrVvnbr6RLBzRWrNHOt5+lSWkPnYgYqX5mTjnbdsOe8GeIVCQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(7416014)(82310400026)(921020)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tlPionCsISwiEqwcfPuwgdqhS85gyJKwMj0+M4e85uvIxwp6WFXR4fVAEMX6Dba6vhqRLPLJAqmkagHSB3aYpdfgJLLrC2WVxd85Hhj5vyKvID7g7WSWbOXfqQz0lHaum3VDXSMgok8Wy5uLKpTpD50i1vF6BtWWYNEWXNx4/PsJ4Iv+Bp3Jk4OtQ7bpkmEW1lgGOc+ft6xdWcYA1Dg5vGpbTWJb8xrUMf3p8AEnR04yVVCcpWnUc4/0Q+me/hMvR+DLOZUP7rlW4P2UhKhdaekKMllavJBtOKXiOr5CnQs35qny8QaJfo3FLMQlK3L8LSzet4G8ahz619sxMW34Lc1wjKfRulW1/ISVvTtbx2Hl4hU/wxIdOQmYKUPUZ3idk1NV4riUPYunEW24meiScW2ddwQSNyn82S/s17LLFF84YfLR6TjHr+MMoPLdw87t
X-Exchange-RoutingPolicyChecked: n+omqQOZIb65du2gFMg3BrTqJwHBJp9MpXYhO+q7eoMGXu22xWEBCpTb++ZcX8dajBT33ZInX7yi3o/8TMK+mao+xwr/EtRbFzkMHaQMap5HWMu4AqGx8bKxJ0eSJvbaKZNLhdbyGJiZEiGbUuwev3BnmLVy9decoHvlngL2jF3M39psjcbygkvuUpOj9udPpZXoQQk1mXWC3AfE0GlUtZomAugmmlDK11NR0L1ISOOHoecmLyyng2kTRpzG+8Juh4sWtrg3KQFG+x9ttLUvS1DKJ8auc3w8RQJ7Xo00QqgFlHj1WzEkAHyNXgvrz9uXVeYFl4TH6F48CyiqBMLafw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:22.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e770108-16e7-40eb-8088-08df2e294c96
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997801
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX7x70QIYarCzr
 TrJ0WN5+RjPYj3HXBnGQJP4YFJcL0WFpuli0u4zn+4Ea2vjaplu1vtCD8XrljmuxSDvvEYW7Y3z
 9t456y/PAOJwSWG0PMKXJA7sQxtm13TIQDWqs1UECmnnK7Y1AVXPAHhvcrtQ0h07X0mJYCOPxGH
 vNVLGC9JT8rQPVqtB2DlPkHTb/Jty+B+1PwWIcoDiE/2kuOJlKIJ5tD1qUMQx+Pn+Jac2eXCjZQ
 HzgFqJYJkP69v42AvXpEAkUAqf6kvop8unjvSDsjhJSXRFCxYHpmxo47JwoF/NiDXsJPdyvOlW9
 8VuA5LRUAtOSdZuR5TkqlUht5VhysjH+BDBdd6a8CgoJUb3ObMYi5i0yAijvSi7/6OywfwPTFa2
 a1VVVPdTILX8AqlzNksGrtLgiqbXWqnyV1RPUp2TieWTbly5J+orfHzLBuARlM+iXcQk+9/auee
 y+5D/xA/bv/ROro5nCg==
X-Proofpoint-GUID: P9XjTf2_IU43xyH5AYCvLpYAka8Yn_3L
X-Authority-Analysis: v=2.4 cv=HPNWhYtv c=1 sm=1 tr=0 ts=6ad68dd1 cx=c_pps
 a=6NHOJSrb2DrgGhcKreW8mw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=e5mUnYsNAAAA:8 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=ASyY1yBFEw4Rclvw43UA:9 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX5cZae6/shqL0
 qnY4mgEmT2+V3cb0aYnhFQo8ycWi8jV3Omw4DBeBOH/MIA8DFx+GLp/lClTWzGNSnGYULrSN6nB
 hik0lzYEqPLNCMRidimLn290ynvv+Rg=
X-Proofpoint-ORIG-GUID: P9XjTf2_IU43xyH5AYCvLpYAka8Yn_3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
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

Add maintainer entry for the ssd16xx DRM driver covering the SSD16xx
e-paper controller family (SSD1673/SSD1680/SSD1681/SSD1683/SSD1677).

Also list LiangCheng Wang as reviewer for the SSD1677 variant.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Follow the rename of the binding file to solomon,ssd1683.yaml
- Add the GDEY042T81 EVM overlay to the file list
- Drop PixPaper reference from the commit message (not in v3)
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d108339f44e..1b17fba57307 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8566,6 +8566,15 @@ F:	Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
 F:	Documentation/devicetree/bindings/display/solomon,ssd13*.yaml
 F:	drivers/gpu/drm/solomon/ssd130x*
 
+DRM DRIVER FOR SOLOMON SSD16XX E-PAPER DISPLAY CONTROLLERS
+M:	Devarsh Thakkar <devarsht@ti.com>
+R:	LiangCheng Wang <zaq14760@gmail.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
+F:	arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso
+F:	drivers/gpu/drm/solomon/ssd16xx.c
+
 DRM DRIVER FOR ST-ERICSSON MCDE
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
-- 
2.39.1

