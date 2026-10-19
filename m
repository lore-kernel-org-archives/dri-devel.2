Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25F606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XNJWeinK;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=sSyE0nA+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B1B10E682;
	Mon, 19 Oct 2026 21:38:53 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AA310E674
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:26 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLboVA1358350; Mon, 19 Oct 2026 16:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=maZc9N0MU00VoIOO0mtaYAySEtGRpSxsOt1Xwut2S
 PI=; b=XNJWeinKPRCM+qw8wqXBjWyFB08xj1v93tg9/obFeUymuEJekoWn1gkaq
 4SfupszlqLCBD3XSMCoc2YNKLxwHnApqYANsROO4pOJ+YKaRM5H8L7txMhOhbeQz
 5kr886GkXGrV23+d0r8NBFbrP0TW6XeTjs/cRuALlN5mjZh7FE+/yB+KVMKcoCkb
 nK0SMpdop4/yCrOhiv3SxN4CKTEjfLjTWG1VoiQfsTx6oIJNG5j7CaTT7fNlxesv
 5IvnoriD6VW3uR/mcII9Bmw2f/Jo+pu6aaLzVHjxnvbLQbeArfvjS8TLf+j8MJ1s
 8X80p7Bc+Inu2SmNL/9x+zJAZEpiA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd61588-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnEkw4VvsfyXDvvx88tmOSlk5m127fE7YMMNGtXMeALHSnwp3fcbMRqDowkEAWSyYA7HDbcTzLmDUWzYywtgj13VjmRa0wvlX6v2Jz9+zGm3FtkbBMyMeqW8fvyyjGoWocjq18k/k8pgsrsXmotWGfBy1b2ZCnUaYlpSLuOT2n9CIU3ssgvvUecjeET80aeofJKSIc7cdjKgg0XlM+xHv/fvPCMF2pEpPX2To3ysW2pcuhqDWw+Sh8rbehfC5oZNTThFlz86DUWJd4oWAn8OJsv/jkrcSQQtLnSTQS9As628s3vOpYomeHi4pjBuaGLJDSMerxsMZ8ezyEsVVU4Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maZc9N0MU00VoIOO0mtaYAySEtGRpSxsOt1Xwut2SPI=;
 b=y/Y3dx1bhRvXgvJ+bmXaEPQy+40CU5cZ1nIgdBwLDEW4+71Wifn2zzEzqqD+GoiHHM69KdQNRNg8nX5TZjbQB7k0YnVQkGr7AkuTozuHdD6NULLC+moCiDtFKtN+A17gEnmWfzj4Aq+dmWMBZLrG+Nxql+ccsjmHabfoTMYEzHdrcNY7+/QeCIEaPsdXg/4kfD02E+ZRm8b3CN+rVkXEGd6kybx+NCQD/JDN0WpiM9klwe8gVlQrUkYNGfBJGaklc1ASOvX13oAhkHwPIE1/qyhp8Y7cFvHvLR0A8nIoXByqOutIFIDqOyaGqFd9a6Nk+PhIUP3dclrQs+VpfK9mvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maZc9N0MU00VoIOO0mtaYAySEtGRpSxsOt1Xwut2SPI=;
 b=sSyE0nA+bqPmgIiKBiNxGp1GQbXsW1vZfq0OPgIit7qsHseGHgvR0Gsud9iU7+wkFZJTq7c984hhhg7yj0aQToxuWBuiFF89M27roCUWUMr2a/NmFy+8OqigUnH4lX8hUeaDd0hP+eT4frX3TRsUPWYv/CCPf7QmOLNP3ruv910=
Received: from DS7PR03CA0293.namprd03.prod.outlook.com (2603:10b6:5:3ad::28)
 by IA4PR10MB8610.namprd10.prod.outlook.com (2603:10b6:208:55f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:38:19 +0000
Received: from CY5PEPF00000E76.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::b) by DS7PR03CA0293.outlook.office365.com
 (2603:10b6:5:3ad::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:38:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY5PEPF00000E76.mail.protection.outlook.com (10.167.247.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:17 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:29 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:29 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbSj4325728;
 Mon, 19 Oct 2026 16:37:29 -0500
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
Subject: [PATCH v3 01/14] dt-bindings: vendor-prefixes: Add Dalian Good
 Display Co., Ltd.
Date: Tue, 20 Oct 2026 03:07:13 +0530
Message-ID: <20261019213726.4145532-2-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E76:EE_|IA4PR10MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7c9bdc-4027-4964-8479-08df2e2949a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|7416014|36860700016|1800799024|22082099003|10067099003|18002099003|260925022911599003|260925021311599003|260925021911599003|261009223027099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info: YQEgDhdnAK+fh8yN+fmi5W4bLt2MSXl4T/TDOGeUKhOS4c3xqLIDyql1KFGIWgSZ+TaOAC6fUgKdULfoSMvY44oCgwq9prUn4h3DthvlcwfNEBsyXabZvdZXuISybhYcYTTPovqDchkrtqNW5KkT8yn9xld8ECOkT/iBH7S5VECfQ4dlzsuGqzbbIaeYHLhTd9XjcwS3qvnXG7slJE1pWYbfEM2bejBqqmwbpjzGWpFmvTEcGrWxdZ+XC9IPgb374PhyFDNZls1cJdYvVBcOxxa8gsZgi89JGJ8m5H6qPQkCN/G8uUdcG8uGe8XcYxC+GzXc0mZmD093LjOHk4o0ggH0hDTMbWFNhhVWEyZFiht3kiW3z5QH+/BOvoHwtVD0X3VwKWuTMxb0QvHlZosmfS8ezGtKcDc4Xks971wYe3FwFbg+aNdvYjE56OY58/tM8fVigbwAUZ7MUMco/gNd7Uv2MGAb/HIDZaI4NBHxdpX0WByn5Sv73xtf/uhcGJRISssRU2KoEX0qLeos/6rgHeqh/lhRdXADjgUQtVuRCCjOm8+xCQukuOXAM61xYP/j4vzR6qP6Y5RINwBn3QuUNqYzEb4V3jsWO8bA9vcZcDXG55+amhiygkJy8Tx5x/bVff2G3lERdC7xsQo9aLycq6GWisRpDLHEtnW1472DmU9TWGAZUoCbIiN7NfKQWWQJkWhSVqlNHU1FOa05b7e4uzIPqqXmIn3hJDVhmvj7VZujZ2JviAfJVob5GIvlbuaq
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(7416014)(36860700016)(1800799024)(22082099003)(10067099003)(18002099003)(260925022911599003)(260925021311599003)(260925021911599003)(261009223027099003)(921020)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BtYqdD1U1/mfGZ0At7qg8PEqUEXcgsstCUm6nWJqJiH3ChHgCHBebZWQRQn4BU+3zt96faNBCveElGqrtMDNqAloOiIM7BBQryfHPhRKWj2bm3UuAjrs0heDkxUD1Y+eeawyXLgrewz9oGWEg81s+93ssmu372Rlbh34Q4AvzIrYNrn+foaT4XCLg7jzVbz71I93MUOm0ra0COf2FMjSQc51PxGxxSNdLednYzM0eu9XbfnLyaKRMDJW88b8yJu9U219jyvrfaotl2ji2lEhCFiX1yhOTJqgZaA7Voi/1Cs2WvY0d7QbkdkDBOnhlxd4jcNfxEGhHJNlhe+7ezUgqEGW4yJkNf+mYdueWoQCvAifs1mHBo9c7X2PZ9RXdX5p17g2hfuTzAOJ8OkHpHbVmxtK1966A9d/e0kK698+GTuapgIYWWMLmKwfjdrLP590
X-Exchange-RoutingPolicyChecked: kdZ5i6pp5mjHNR1IiTTz17TbGXVNN0qUdI8EIepSvRMOgq7+fZAS1grmr/CnbxoHWpPW3Ugo+/pYjvxzal+IQhNEHCHvVoibugNMR+hwCD5U8+7jbnsxRj2A7fiSngnShqX07w35WMbFhBeZB1CzKfFKIvbArmyS90/glLeKLhx6CqU25mqsqHAKxqCOiSqvpH4Oc6oAiy3U/jMCTgbU42QBboEFRSNgknHbcS5ml0rIcaS21E6Uo7EUfOBV7CJfaHN+UjrnxRCkfmEHUXqAo6LDyT1QVyCNgA5HiqEzzQY56tF7aCXsIK7dVKg0H9GmDtn/nD7+6Pk0ezD7J+eK0g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:17.3318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7c9bdc-4027-4964-8479-08df2e2949a7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8610
X-Proofpoint-ORIG-GUID: m6X4Taaf_U6PcYafXSMsjW2uKTt8iayD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX49REq28TwVaw
 U3VXXPnBG6LQN8m5tb151z3aq+HUUkn8UvMsZzP4IMwzCLQKp+268+QGI33DEv1cWc3gaqUnh1e
 lHtBBr1J/4WlsZWqffLofAiGmROVQv5VE3BDW1M3lzS6YeAWvfmm+Uihz/+hUqHxrZetFgMe6GH
 Gb6WLSIO6OffKSVXBpVg7/GqpXbpHlNiyNxkZTeGGjQGIKkMIiV46gOn3839bRfMYeenRVJ7Fhb
 tIoLHSRCInHN0WZYSNkj2QfYx9pLK/7oJtIiXlTZAwwlHUVRRr//92JP7solncP0cXvLlH8ljT/
 H+jrmjNoHzmyY+iuA6rlnl6PWBVbcmZEtaljGdxz5GoKsUwVVcNGVQx/NT2XgeYhTJvbzF1Rvth
 5PzlxVo4BPkDwE4Y6h+BYWCvRB+WAGy8hp9tXGhoSbz8rPNZKu4ailMHbECdSLPMwGmo2hoZapU
 EOBeoJyi4XpIMCshC6w==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad68dce cx=c_pps
 a=3vo4EN8bzuoLd/SmvO3peg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=6SX0sZSdmN_HxNRVgkQA:9
X-Proofpoint-GUID: m6X4Taaf_U6PcYafXSMsjW2uKTt8iayD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX/QUysdg+Vlj4
 IFl7wbjws7t36s3mI/Hufp8JPqTPo/tXMTVjYhQjEh8vFuFzmq2aXOOITGBUVtceDwnEaMys/Fd
 l7ajMriJZQVvqKpcXembA3Pl6JQosUs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 suspectscore=0
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

Add vendor prefix 'gooddisplay' for Dalian Good Display Co., Ltd., a
manufacturer of e-paper display panels and modules.

This prefix will be used for the GDEY042T81 e-paper display panel in
the solomon,ssd16xx binding.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
V3: No change
V2: No change
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..3e8062aa92f7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -686,6 +686,8 @@ patternProperties:
     description: GOcontroll Modular Embedded Electronics B.V.
   "^goldelico,.*":
     description: Golden Delicious Computers GmbH & Co. KG
+  "^gooddisplay,.*":
+    description: Dalian Good Display Co., Ltd.
   "^goodix,.*":
     description: Shenzhen Huiding Technology Co., Ltd.
   "^google,.*":
-- 
2.39.1

