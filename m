Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66460A2610
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Dre6jvL2;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=h7vq/T0W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E0C10E67A;
	Mon, 19 Oct 2026 21:38:40 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FF610E67A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:27 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLc1Np1358521; Mon, 19 Oct 2026 16:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=8sYimcajn8LG2
 n2Hgm0miOOdJcDxJzLEwb3jDwf9ml8=; b=Dre6jvL2hLgrjhFSvtBhmyfFTZtiP
 fj+5QtpXUbw2fWcIoJWaZClxqzC4mfp0M6T12dI6R324pdotW2WOxHbiwVf6UKCt
 ieadCIbEQCj6KpJP5c0/xPNF2Qdeaf6E21/fDeEyBqj6oab30ZBLO+de2et3ese1
 FCMg4pK7F2zzEixusv7IcuVTQ/tqfw6iLKviusRvINji83d+qiTyUoZ1sxi2Go0z
 aj3PTE8ZUo2VYrYh0ygxVbXk7PWZcc0NfUwyeZ7vatjC/Pf9FVgJMckXOH6dREyQ
 lbgM5PYIsyS2/xFlBlET+3tJDtSbbaX7BhiATnkGBv6ErAMlioA+TPRiw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd61584-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+b9Z4Ectasdu5q6SsQKy7HknRYw6b1KrrByC2Vw7iAvjkjhCz/uSmdk9qPu7ZUeDhk7Q7R5tsQ/ALcZw7mPncND4mTng8JW0WNFkWFHUncGbAGl7m9E48cz9xTKlY8TsmSQYx9ruhP92e7zWmQt3YRRJ/XzjUDAUJhoXaVV2VitekBMVSVBajsa8ZLk2/t1S9+ef2A7RuiD48ywLtjaU7TZlKBFWOoqcIZMqNylTm+gtbl7Ta/55TZGeoeOP3BdNzJI6scLNuobwLfIcjIjSb81yYav61zDJukxdkngiHrdr4Avqz9Dcu5ipr6HyHhDcKUggsIL6qj651fHijMGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sYimcajn8LG2n2Hgm0miOOdJcDxJzLEwb3jDwf9ml8=;
 b=Yt9QqZ7PkH/IKpmoLUWO+1mquAsnuEG8TAUNEXwYMdCt39LB/AJS3Mn65pHfJ0IjQLk/JzKcaQo3aIiIAZEyWMgmH9NRMToKtBKj01g0Kffmx/VzEoi51uVKRZmJ4IeT7AArwEzmTGy84+WDEzcvpEb8WbsCL4EURuUh0epNqvJLNhJe0wgAFevo+Lf6gXiYeVAHP41RE58ALUhYcunAHVGmk7R+NGW/fDZ8jCUuepw9dv8M2WeZ1DpFM/a8HHaeSpuzYiIBmOB7c/tpUjee2z6/KxkKxoZYEm2Nf3RCZChV3GkylOwLCDfyZm112PgosbgxG//CNROuC3+kcPRFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sYimcajn8LG2n2Hgm0miOOdJcDxJzLEwb3jDwf9ml8=;
 b=h7vq/T0WpMmOrNVnwj5cXI4CxQhG2yjIXyhqmiiCDUP97Loi8sqt+WIwGLmq8rIzY4gUvPq+Yuz/1ZEkSpbna1z1DErH2k5JeJgYZmkB8p9LGD1FzPQp07CZP3H2vB8i2s3KRXEgoP2Z6gbzkXrhin4LnBDNH0UgQEDqueoD2yY=
Received: from DS7PR03CA0299.namprd03.prod.outlook.com (2603:10b6:5:3ad::34)
 by CH4PR10MB8226.namprd10.prod.outlook.com (2603:10b6:610:1f6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:38:17 +0000
Received: from CY5PEPF00000E76.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::c) by DS7PR03CA0299.outlook.office365.com
 (2603:10b6:5:3ad::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:38:16 +0000
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
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:15 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:27 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:27 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbQT3325701;
 Mon, 19 Oct 2026 16:37:27 -0500
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
Subject: [PATCH v3 00/14] Add DRM driver for Solomon SSD16xx e-paper display
 controllers
Date: Tue, 20 Oct 2026 03:07:12 +0530
Message-ID: <20261019213726.4145532-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E76:EE_|CH4PR10MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c04303-e451-4255-3e63-08df2e29488b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|56012099006|5023799004|261009223027099003|10067099003|18002099003|6133799003|921020|13003099007;
X-Microsoft-Antispam-Message-Info: egeTwCI1vzPVex498yjGk/OgefuD5wwJhFNqeB/8MWLzYl05e0Isl0snO5SAzuW9zD8c9CrNiSvT7GMCqTg5+32Ok84j9O4f6PeOVoMswvJ8taPwTrPIonOkSEaR8Fodoadx4Lfmrz/soR1fvgI+x+OeXrZqvLwYv2gEXjoSOexDuuqnW0UB2z9B9aHTG2Gd17iBlUhFAFreIiNs7R4eLC3YIGBCE6caGaiO3favywn3qdzreZB7BzToHqdM4OL/pxI/TLWI8Dz6Iomh09c45A0Fz+GB4sO3vvAM0TwWBXINzwMa3MT3IbdvGFqw9Ra/uiANBhX4H0SauO33RZT0wugVawmzWp7JWwgxOquNBjubnD7DQkrRbgUW3rDCRdXKA1yblXjC4zvD3dEVOxlv26EMfa+fsIQoVV04/p0CPpIF3HAp277y/JJchwQQ8ZRgGzmxYYpTIH7QJsfirtvuhJT9vQAnmkiuox/lbHG3Z27PZCf9NZBE2pEfLSDAonM2+1hCSyH37HPX9xPPCTc4UC/sxGDsa860NxIp7q5uofpptxKRHLiPt+tVkfYbVDadryyGaGWCCWp7bRQSrouUD01IDMrCWdB8x91Rlw3UfbSQpenMEygcRal6gSQZGRSdnXwNEyqis1epcf2xV3DDIcN4Xu8QUETA8Q/698TEMyDTVuVRm/YZaj6OnePbwWO09iyYRYRPWUuAV5I2Y42Djw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nWQ8NwbIAdEWn8xqsI1U01DoHM/kDbMEaammRQskUAfi8rSG7oUVdYwEAENjCpEe8PeWuinWzjbJ9meYU+2/eoAsumBwVDFobXo3/iVrtHAOohZxa087AsGaNiaM5xnp/DTyS7y38afrwxHBeTJ9sx8PqqU1Ub1SfqzMKFuvgSrJI8VkxbjUZaqSrA4D4raGcKL+9Qv7WSlmYN0tz44d0OQpYt4rqWTmKjM4Ai1643/dWBxIpr0NZmuVcfZwcrZCMa7KMgN8gUP4rtbykFMScGlYge5OX+fhwWE4Pi/s43WzB72r8R6Obaaln9GPSzQwAS1ON8obg7MyBmnn5dgG6rfp3NRE2X6Z8FMuLLAtstIwazJQxtG1Xkvvv+ZvCEHb1bg48EBlK6FPcrrzJ4wdY55uMVABjakDFcuIKQG2poJI8MQBi7v0SNneHpZ4/NDA
X-Exchange-RoutingPolicyChecked: pYuT2ZAs/dbhDmRNPrl6kA+R8xFQrYf0S2QB4ka2wgNj2la/PcOHkCUgJd+B6WBJVmG3Gm/vQpn/AC22EbtDJV2BnXugsa11nLYVeVmPAP3D2ZBZThJobxovNKEU5Px+0IBgUZleBdyBBdQV/ffgs9agrZ4O6h2f3YkR8aVd+UeID70KQoKCrJXMeOiclpXh/KPT3eLIQj8RN7ospoxstWZl4z+9vKEk+XJbrYs0zRyToJuRJolw+AlombZBCjqqXI9QdG7lt5aVwzMR+oN9pYrG4JfXgSGN9BNL8wncYqL7buq2S9pmpxM13Jx0rI9jIoheZZ2ME3qFI3XuNNXPkg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:15.4662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c04303-e451-4255-3e63-08df2e29488b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8226
X-Proofpoint-ORIG-GUID: DQHVkQdXq8kBlznBgP7puKGAcRl3aGyN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX81ZUryz3ENBA
 UupzmkowV487RY7ucD61JgUSj7WgRolUWoltytCxmX8aQ/B1h+7htkwYD08PSsp5G+SYgzKofjv
 vP8W9jIWMfOGTx2vwXgoOwRDqicsRqZWF+doX3dRrKCEZ7pCKZyvTmKvlRPQ+4kqOUr98ccKaKs
 PiyFez805ioulgslp1AdHRZUUUZBj7Xia5L0OwLw4y3h4xTQ4XeXKqugKp5DP+PFUCMTDyvdNpH
 B+U2ADbIWaoqFN7eSbVpK794y+Tw8NsAjUXoSc0y+gkTIZcK3iPPPNbslIbs3d2mw0Hmqcd9/fT
 0d68V1iQSjdIWB0wzw8KTkj+Gl++IiaMxq+yace9JHZ7DfheFmLHdJFvoOQutPmE0ks4vw70UgT
 itsoPVq4MSWb+WQI3CwBdIPI3A2LfQTti8traPcnq75hqOoe/5s1ulJxgNc0ySf5WH4c4toHqX1
 UXHjhdRYrGLMnyPearQ==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad68dcd cx=c_pps
 a=A+iiJIZ7q7LOtbDGyL1ITQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=Ep_Mk7Q0AAAA:20 a=wtlya_pM6xCrRJ69qO0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: DQHVkQdXq8kBlznBgP7puKGAcRl3aGyN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX9RmPZ7rqs7P7
 7QfSNJ5KPJZ7wOLORf9MZ+3YqmscT2TpLbSeeVQ9wyoepdkvDWrG8NZuwPdDnkSgJXuqV/B3jJ7
 zj8AqAi6MYPHsRY5eVafWIOdC9hDzjk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a DRM driver for the Solomon Systech SSD16xx family of
e-paper display controllers (SSD1673, SSD1680, SSD1681, SSD1683), starting
with support for the Gooddisplay GDEY042T81, a 4.2" 400×300 black-and-white
e-paper panel driven by the SSD1683 controller.

The driver is designed and architected keeping the bi-stable nature
and low-power requirements of epaper display based systems in mind
along with having adequate flexibility to support varying use-case
requirements for the e-paper display use-cases.

The driver integrates with the DRM atomic modesetting framework and
supports:

  - SPI communication in both 4-wire mode (separate D/C GPIO) and
    3-wire mode (9-bit SPI with embedded D/C# bit)
  - Full 4-way rotation via the Data Entry Mode register, with no GPU
    or memory-copy overhead
  - Three independently selectable refresh waveforms: partial (~300–500 ms),
    full (~1.5–2 s), and fast (~1.0–1.5 s)
  - 3-colour BWR pixel classification for panels with a red RAM plane
  - Pixel format support: XRGB8888 (color path) and R1 (native 1bpp,
    zero-copy path)
  - Runtime PM with configurable autosuspend: the controller enters
    Mode 1 deep sleep (RAM retained) after an idle timeout, waking
    transparently on the next frame update
  - System suspend/resume: switches to Mode 2 deep sleep (maximum
    power savings) on system suspend and rebuilds the pipeline on resume
  - Runtime-configurable DRM plane properties for refresh mode, colour
    mode, and session control (clear-on-init/close/disable, init-refresh
    waveform); rotation is set at probe time from a device tree property,
    and border waveform uses a fixed per-panel default

Changes from v2 [6]:

Bindings:
  - Rename the binding file to solomon,ssd1683.yaml to match an actual
    compatible, and shape the compatible as oneOf so the SSD1677 patch
    only adds a branch
  - Reference panel-common.yaml and use the common 'rotation' property
    instead of a local one that said "clockwise"
  - Add spi-3wire and document that omitting dc-gpios selects 3-wire mode

Driver core (base patch):
  - Keep lazy hardware initialization: ssd16xx_hw_init() is deferred to
    crtc_atomic_enable(); probe() performs only a GPIO reset. Follows
    the precedent of repaper.c and ssd130x.c
  - Add drm_dev_enter()/drm_dev_exit() to plane_atomic_update
  - Wrap the framebuffer read in drm_gem_fb_begin/end_cpu_access()
  - Skip the update when drm_atomic_helper_damage_merged() reports no
    damage instead of making up a full-screen rectangle
  - Remove ssd16xx_crtc_atomic_flush() and last_fb; the orientation is
    static so flush did a full hardware re-init and a second redraw on
    every commit, and last_fb had no remaining users
  - Use drm_crtc_cleanup() directly as the CRTC .destroy callback
  - Call drm_atomic_helper_check_crtc_primary_plane() from CRTC
    atomic_check
  - Send SPI data from a DMA-safe buffer in struct ssd16xx_device
    instead of the stack
  - Read XRGB8888 pixels with le32_to_cpup()
  - Size the transfer buffers per row, as the packing code does
  - Make Kconfig depend on MMU
  - GDEY042T81: use the HIZ border waveform for updates and do not
    refresh the border on every update, to avoid border flicker

Session management (clear_on_init/close/disable):
  - Split display_cleared_on_deinit into cleared_on_disable and
    cleared_on_close. A single flag made a clear on disable suppress
    the clear on close and was never re-armed on re-enable
  - Reset the RAM window before clearing and size the clear buffer per
    row
  - In 3-colour mode clear the red RAM to 0x00 (no red) instead of
    writing the all-white buffer to it, which would paint the panel red

Power management:
  - Check for damage before taking the runtime PM reference, so the
    panel is not woken up when there is nothing to draw
  - Put the panel to sleep in remove() with pm_runtime_force_suspend(),
    independent of clear_on_disable
  - Return the error from pm_runtime_force_suspend() in system suspend
  - Do not clear ->initialized again in system resume; force_resume()
    already re-initializes the hardware
  - Do not fail runtime suspend if the deep sleep command fails, as
    that would block all later resumes

Plane properties:
  - Reject 3-color mode together with partial refresh in the plane
    atomic_check, as partial refresh does not update the red channel
  - Only create the color_mode property on panels with a red plane
    instead of exposing a property with a single possible value
  - Add a mutex serializing the session state and panel access between
    atomic commits and master_set()/master_drop(); master_drop() can
    run concurrently with a nonblocking commit (e.g. on DROP_MASTER)
    and both drive the SPI bus with the same transfer buffers
  - Sync the session properties from the new plane state in
    atomic_enable as well, since it runs before plane_atomic_update
    and used the values of the previous commit

MAINTAINERS / platform integration:
  - Follow the rename of the binding file to solomon,ssd1683.yaml
  - Add the GDEY042T81 EVM overlay to the MAINTAINERS file list
  - Drop PixPaper reference from the MAINTAINERS commit message (not
    in v3)
  - DTS overlay: fix the BUSY pin name in the comments (pad 0x00b8 is
    GPMC0_CLK, not GPMC0_AD0), use GPIO_ACTIVE_HIGH for the fet-sel
    gpio-hog, fix SPDX separator to uppercase OR per SPDX-2.1, mark
    [DO_NOT_MERGE] (for driver review context only)

Changes from v1[0]:
  - Restructured into 14 modular patches covering bindings, driver core,
    features, and platform integration (was 6 patches in v1)
  - Added comprehensive device-tree bindings support for vendor prefixes
    and SSD16xx controller configurations
  - Refactored driver architecture from drm/tiny panel driver to drm/solomon
    bridge driver
  - Switch to using GEM_SHMEM helpers
  - Refactored data entry mode implementation
  - Removed runtime-configurable rotation/border-waveform DRM properties and
    their module params; rotation is now set via device tree, and border
    waveform now uses an enhanced fixed per-panel default
  - Added support for Solomon SSD1677 controller variant
  - Improved session management with plane properties
  - Added comprehensive power management support
  - Support for panels with reversed RAM X order
  - Dropped RGB888, RGB565, R8, NV12, NV16, YUYV, and UYVY format support;
    driver now only exposes XRGB8888 and R1

[0]: [V1 patch series]
https://lore.kernel.org/all/20260430183311.2978142-1-devarsht@ti.com/

[1]: [Development Branch]
https://github.com/devarsht/linux-next/tree/epaper_v3_final_4

[2]: [Test Suite]
https://github.com/devarsht/linux-next/tree/epaper_v3_final_4/tests_27sept_new8

[3]: [Test Logs]
https://github.com/devarsht/linux-next/tree/epaper_v3_final_4/tests_27sept_new8/logs

[4]: [Test Results]
https://github.com/devarsht/linux-next/tree/epaper_v3_final_4/tests_27sept_new8/results

[5]: [Result Summary]
https://github.com/devarsht/linux-next/blob/epaper_v3_final_4/tests_27sept_new8/results/run_all*.summary

[6]: [V2 Patch]
https://lore.kernel.org/all/20260927182329.4193961-1-devarsht@ti.com/

Devarsh Thakkar (13):
  dt-bindings: vendor-prefixes: Add Dalian Good Display Co., Ltd.
  dt-bindings: display: Add Solomon SSD16xx e-paper controller
  dt-bindings: display: solomon,ssd16xx: Add Solomon SSD1677 controller
  drm/solomon: Add DRM driver for Solomon SSD16xx e-paper display
    controllers
  drm/solomon: ssd16xx: Add clear_on_init/close/disable session
    management
  drm/solomon: ssd16xx: Add support for Solomon SSD1677 controller
  drm/solomon: ssd16xx: Add power management support
  drm/solomon: ssd16xx: Expose refresh mode as plane property
  drm/solomon: ssd16xx: Expose color mode as plane property
  drm/solomon: ssd16xx: Expose session management as plane properties
  MAINTAINERS: Add entry for Solomon SSD16xx DRM driver
  arm64: defconfig: Enable DRM_SSD16XX for AM62L3 EVM
  arm64: dts: ti: [DO_NOT_MERGE] Add AM62L3 EVM overlay for GDEY042T81
    e-paper display

LiangCheng Wang (1):
  drm/solomon: ssd16xx: support panels whose RAM X order is reversed

 .../bindings/display/solomon,ssd1683.yaml     |   86 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/ti/Makefile               |    6 +
 .../ti/k3-am62l3-evm-epaper-gdey042t81.dtso   |   96 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/gpu/drm/solomon/Kconfig               |   13 +
 drivers/gpu/drm/solomon/Makefile              |    1 +
 drivers/gpu/drm/solomon/ssd16xx.c             | 2659 +++++++++++++++++
 9 files changed, 2873 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso
 create mode 100644 drivers/gpu/drm/solomon/ssd16xx.c

-- 
2.39.1

