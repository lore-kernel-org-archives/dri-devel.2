Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8260A2608
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=nfeS9+dc;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Fotbh2/n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F04F10E668;
	Mon, 19 Oct 2026 21:38:24 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F1B10E668
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:13 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69JLbluO023385;
 Mon, 19 Oct 2026 16:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=EzwN2rbfZ2R7REnY7f3yeTWB3sEh/gqfbAIxejk6l
 WQ=; b=nfeS9+dcb0IM/r93G11c2uddz20EOYLD9AqQxrgc9gzvzPn3uVap41F7K
 idACesbfRispyCqKxGhEd2GO1o64dGxMH1W4FgkfrAviImG2Msz+pK7Zxu2SoWgN
 ue/BDvl62cO92LqIwi2JCbDvX6nTKAVTg7afD6OzmAgJY0fvb5e7OAVGphPgtOPf
 IVRcxm1muePhI9y99v9CXyBFyKoKE90QPB0TDwEdRpbrv0zZcmwlHuR1pHE3rzmf
 qsBIM69b+p3l95r71kRFxXFCG7szP5pb5W1R4hYOfW9DGW47y1iCaIsSX9MXUzxf
 Gcz5AQOow4V80plSHjupWNPpvof+g==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hdjdabmun-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GG2ubBNtO7hObGOsWu6Oyq69tvPmgBCvB3EFWwr+1xc6MSxnaZxxJaGxPF+A5GgY/DOUFg2TyeozdGguNsWtfCcV+5FxeONJrfYPU2Egu08ppQQs9DQw7FvhOSIi2XD5OfjxcwOPxoXbPAQp0eHwZeTDW3Gq2cFNfNb06YweGtJgcwx73+4UNzlCW21WFelxp7vZIohwBvz3tlrM9Fwuqn+37myxUUjTfxr9t+uAJoX/6naeitcnJRiYsIHIO5v1WuSxPFY9uXbfIvk3iaceoGcy8tx3OJcldV+B2/Rx7yM2cwNAkWsBhCqgPFG5WtSNA5l0SIQlu7W9/kM+XlAp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzwN2rbfZ2R7REnY7f3yeTWB3sEh/gqfbAIxejk6lWQ=;
 b=TSoyitAITBea/XBWhTzIiDMXALylEIgkdqVLf1LzIaPU4i9WMRQNnhrSjGF6KmA0hjs7NXZFd5R97UxAr7euCA6rmzEm9uuV+hEmyUfsULnvPwgzqCAxra/59mSs5pskacaBdzHxDn5R6UwrnZaXZzOw+vaA5U54avBCbv7wpfC8Q3yX5f2GOF3/rokOK0JRaaKmIX760YHo+LolNGOiE2n/NQdujjIWr6aJmab2x7DhBp1lFsGzmPMLKwFsl9w+0oVIX5Es/V9tWNrKPeiy3IIeoMVDv80sPK1M9RxPDW2UVV13byKfrOlU7VfoyaNq82mhAV66IeBwf5pa3A5OBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzwN2rbfZ2R7REnY7f3yeTWB3sEh/gqfbAIxejk6lWQ=;
 b=Fotbh2/nDKjvuaeGGOYEJtZOhyiypLfHifevUNz/wCMdqtWN4C7VxVRRuIGglZwUGrgMfXdiWc47V17z/YUOd8Yo8INfgwAJLidc9jV3Wm18dgqw4VyRi3QVlhs9s20LFq8ognwL/GF+lqKulzpgbnocDBdBZExgNuCD8FxGE/k=
Received: from DS7PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:54::31) by
 PH7PR10MB6579.namprd10.prod.outlook.com (2603:10b6:510:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Mon, 19 Oct
 2026 21:38:03 +0000
Received: from DM3PEPF000265AD.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::15) by DS7PR06CA0025.outlook.office365.com
 (2603:10b6:8:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:38:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DM3PEPF000265AD.mail.protection.outlook.com (10.167.23.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:00 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:52 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:52 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbp75325980;
 Mon, 19 Oct 2026 16:37:52 -0500
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
Subject: [PATCH v3 13/14] arm64: defconfig: Enable DRM_SSD16XX for AM62L3 EVM
Date: Tue, 20 Oct 2026 03:07:25 +0530
Message-ID: <20261019213726.4145532-14-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AD:EE_|PH7PR10MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 129b8ee2-48b6-4d85-067b-08df2e293fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|376014|36860700016|82310400026|56012099006|921020|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uTHeCUjxRLtjHQdBrxF//Nf+DfUbZETqcBbrNY7cKNJuEMTXuhf8bTzpLROgcv4wiO0X5HnVcKioxG4t7YYNIcmcKqkLyTSeotL8fEIEc0jl2XC4+r8V3WP+gVKcb4icaEMcYCZb4veYIkgc1cZj1b9hHN92Sada3QSPTuyINLnlbINu1C58stUI1G3WhLiSbsrroTM8ZKjGlnXbDzKboyXuVhdLtLKKSKC3BSEyM+boMs6saOS8b2cMayrzVRa6HsPLUEeasoiukCc3hI1pltzNMXvMfXFwcrW9tWjVI28IDIFZfVds98JvVnmt9NtZZG1xgZPexAZXK3K/01GLr7Cic5Uxpnz2tYlD9VXRNV8LNehcR9AtwNJIQtRRl0PSJBvuwRvI6fsBRPRZ9CHTjwFOQCEi8D06l4KPfgI/YIPFMsyREbtWRFGzY2dOQZNKAMT+SGU9Z2QO0Wuz+EyVMBZU9dsThK3HQ3Fp+Axa5lBWwN4FIBqGgJoCwBB4jh2/VRvCXQz/c7x9bPuW70N3OJtVcFcHEtzOA1X0VKMMEIJij2ev0BhVDJK2tpkyp4wnnqJxPmBdBRSX6NlmfS+uZ29+JIYXgz9IEkWoBZ0tBVPvCsqQHjsjgRk0XYFti0WCqh4GDkd3SXBv8lbQTtVXDE87varrt6dung0Og8V58U5KAsHNBG9dK9AGPCdOK/ggRiWSrA7edj6q1jz4g5MIsYJIYDWZJwxjM/l6u3O0vc4QHtER6STsvumOlGPgDkAQ
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(921020)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gFJwKf4whCLLMNVQkeohgEgfS2wSFGh6HSkUKEAL136jDiki1GgPhy18dSp0UYAKyzcDaJLPB+B4m093ecv9gK+ZswV2t7gmNZRDvvm5a9JX2L+rUT0cQjDFyvv6/1xDbgPwyMrpG+wi+04h96fOi9znU577PrVoADiVwkGmmc1D30UmT3Z81OSXRnu5zhOOeZrRhPCk/2pVp13QyeUYedfmRw6cB86FqBmXLd3LGfCQeNMZAhXvx44vf36ap5PtSr5kRsWnRW3KDGlSY1XtPDhtW0OjRRPIMMo0cszsSUa65CTB/2NJPqZGjV9qK0eNJM+MmKfLP+oBGqpb0Y9nKc7aIrnyiyjnts12lsr04Fmft3gJapy5O5MyOi0Nw6xhwMfqV7g6Ybb4Dnt/khKfe01rD7M1K8MkYdCdScsdccaBDSpmG8jSOfV4msSyByy+
X-Exchange-RoutingPolicyChecked: HzhyRW9LuhqfPzSkU+791sHftUp/CxaU/ZOpP/+MUKIkxuTfzR6VyYmDi5+savUY8FSQRPpNpCwd+0jKhrHe2aSbKuUgCi21HSkaqAjEOENTA7RCSsr1VvJ3ODm3sPRLeLxyUbn5cy6hvtEh8gV0q4aRyKaNADGtBFim3h4gqOlFsu/OoPOLx+z2mVeVzJahzTpZ0f9C1C9BYMs3Lvxmg/MrPb5BJkD//gCWdPr0OqGPeONFrchXqNRjJtGyMz4ipqcz7tWe5ECLexth1o453eWeidyh/8VOar4AYW7UHn15gPlrc2S2bSOFyfVLzIo41qjg3Gpo2gOl/dLC6mHcCA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:00.8016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129b8ee2-48b6-4d85-067b-08df2e293fd0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265AD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6579
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX1KkgR6FURYhh
 9C+8ilVskg5VerYJQqynYkADbFT5jsA5cEs220YDZC0/wHohflG814b/zD/D82uDMPf20rdCzBE
 JUAipR9eI8qdyf3NHqrXIzgCV1bHKh6JFVWGX8pNJPfphqinyAfYhct5WJVNmBNZKQ5UHGgA3/V
 oiDEAqDm+Q60adQflIcBfj8ClEU5yxXbhuzzGFqfv9h0ZVsWcqRwv3AW27YFf5t17Bqzr5LjcvL
 qa8XkF9roumnkOoje2ZwUIcFarwN87xVQsogrpO93HR2QT5XA+iQAuYbklJEIed2KCcTvblpA21
 j3bWyH0mZDdf5ShXXY8rmYDxkhRjmdXriJE3exGFEz5Z4LUldAMvUgVfGF/atqnAp6HkPs4PXMQ
 F8JFswAkN1VSPx1oxlSNar0fITrJelCLLfNube2qA9Wf64heXns5XjZzMrGkMqVPhl4jA7tixGW
 lpGfOWwOzGnNqIPifpg==
X-Proofpoint-GUID: 7b0EEAJdt1usaP7Xj3Y6Y2Txq2KlJSaK
X-Authority-Analysis: v=2.4 cv=HPNWhYtv c=1 sm=1 tr=0 ts=6ad68dc0 cx=c_pps
 a=fq9WP/vNXoxpaIAZvvUcmQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=i3uwbpqASX43i4ARessA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX12wa1lV+vu48
 /nEXl6+7q3BG8s6W0DuPcxyXT7gjJHq3sxwfuAdyEero3ZUgexbL+P7XYL4vIwje5yHqER9ePF/
 NKq2NaExW8QIuOEreAoN6q82AP+XQL4=
X-Proofpoint-ORIG-GUID: 7b0EEAJdt1usaP7Xj3Y6Y2Txq2KlJSaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
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

Enable the SSD16xx e-paper DRM driver as a module in the arm64
defconfig for use with the AM62L3 EVM and BeagleBadge-EPD boards.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- No changes since v2.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6858b75a05f4..f10e295d5aae 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1050,6 +1050,7 @@ CONFIG_ROCKCHIP_DW_HDMI_QP=y
 CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_ROCKCHIP_LVDS=y
+CONFIG_DRM_SSD16XX=m
 CONFIG_DRM_STM=m
 CONFIG_DRM_STM_LVDS=m
 CONFIG_DRM_SUN4I=m
-- 
2.39.1

