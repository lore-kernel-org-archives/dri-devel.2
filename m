Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99B606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=UXu7PoZ1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E9D11273E;
	Thu, 22 Oct 2026 15:31:34 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E1F11275B
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSzoj9nGaH/8mX+3QVDGX4x6iarfX6XYPpWU97+fkSbyl8DFLEsSYXG9ddkVnDkUHWyfvsCqytJkOuzP1y1HW52l9BVU+phW9BFJ4U80c8W9rtq3FY2xiPVmvE/oQhX6P3K0iiut1Xib5QOsjbj9PgKS+jgZEvvKiSQTnAGKed+MVF0FyLx2PNYQdBFkbABnzebEy0TBc1ZuldKL8ARBZX295hkKH4lYeSH2EliOidnrwPKZ4KU/tvfoHXWuTBqcUijw6gZTKOhMax3gyTUzbUBw5oovD4watL1rpNvU/AhJTIcHYLPSd9nXQ8L83pR0KdyNCVGd5AE+9Itr3nMDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezO/54UVd0xBO1JHlch5FfXYqGy1qHhzF7sJ2hKa36E=;
 b=m4AvepkZlgxc1UZx8X3u1Y+gTX0pceTsRMKtb1iEF6PSzEvFW59nQAM+RdMJeJFLf8dugz/HEgbrLgRg5e2eFzL6TwASLVcHE6i0fJCj2Q5KxK+atpIqYuZZQdaPiFmr46MuCwyhAV1dumNpM3rGXOFT84MrlJdKUzhRxDyZZEGSmbXjLZ38eHMMmVx7THQYJSBgAxeVoDKDVwmQFv0fKg85RARkf/yH5P/XfJjDB0FMwtUN7S6JNVjlivPki1g4eLUw/jhL0o39kJ/9KZMmvRsRTrXuoAs6eIEg39oitJKM3bkd/07YUNnLwBJSQjuVt+eEtTLq0BpEMOU9rC8QSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezO/54UVd0xBO1JHlch5FfXYqGy1qHhzF7sJ2hKa36E=;
 b=UXu7PoZ1PdB24TfUrgDnb7gj4tiwDAkOqgA9cWNDR/J4tczOd43RXvv91MS2V5bXJdHrefjGZgyaf+xwQlPsusGBRvU0QR29pFBkQwcXnK8NRZRnmhh5IrSgJpvRbaeslHlFeXKt/5M3z/nol8WAl7I3iejPgh0FxxlVQd72gh0=
Received: from MM0P280CA0118.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::8) by
 GV2PR02MB9568.eurprd02.prod.outlook.com (2603:10a6:150:df::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 15:31:22 +0000
Received: from CPH1EPF00000530.eurprd05.prod.outlook.com
 (2603:10a6:190:9:cafe::40) by MM0P280CA0118.outlook.office365.com
 (2603:10a6:190:9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 15:31:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000530.mail.protection.outlook.com (10.167.241.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 15:31:21 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 22 Oct
 2026 17:31:21 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 22 Oct 2026 17:31:20 +0200
Received: from pc51726-2243.se.axis.com (pc51726-2243.se.axis.com
 [10.88.125.62])
 by se-intmail01x.se.axis.com (Postfix) with ESMTP id EB9B03586;
 Thu, 22 Oct 2026 17:31:20 +0200 (CEST)
Received: by pc51726-2243.se.axis.com (Postfix, from userid 15273)
 id E3D786026026; Thu, 22 Oct 2026 17:31:20 +0200 (CEST)
From: Lars Rask <lars.rask@axis.com>
Subject: [PATCH 0/2] Add support for st75156 in st7571 display driver
Date: Thu, 22 Oct 2026 17:31:04 +0200
Message-ID: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgs2moC/x3MQQqAIBBA0avErBPUUKGrRIToVLMxcSoC6e5Jy
 7f4vwJjIWQYuwoFb2I6UoPqOwi7TxsKis2gpbZKKiN8jAufzihjF75yPsoppMSgg1vt4C20Mhd
 c6fmv0/y+H5+cJ0tlAAAA
X-Change-ID: 20261015-add_st75156_support-00ec2c7f63a6
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>, Lars Rask
 <lars.rask@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000530:EE_|GV2PR02MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 96853b2a-64f6-4185-a350-08df305186a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|261021121427099003|261009223027099003|261021123027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: J/VmzA2IrwU/kQfzIdcuRLGWbkvuxP7a/G1fBqcDYtdPk516l+z5qBSa9weKZCZgCOZRzuIp77zzhy2nRIa0zVGNT1+PYSUbkbUSS1tfAJipkh51dOlDxaXCitKy3JdrZ6g2mgkaYN8eAXcfMLKYLwNPib6uSdfGAeEdI3+Z+GO9kZ3XXx0LA+RUzxj6IwELXnmfHC+BDlTEL2dNCn/QpFc7tsx2l2aSFAZiVuui4dhGCE8FbW7XtUrbIaVo5MHb+EzbJsdXgXL13h0LLf3g9bofBmjQPBQEgU+qGKRSHih+Zi/QLyM556HU0HOBq1IQU9fatbXTcOgouM9FboliQQM968WGDavueH/pAoIlQm3OMSf57vfiFJvWh5GmumPJtG/RLgBGQFW9a/gCvqJ+gS44qlV3Y9fMvdzOSxoglljP+6rSuzEdorinvUbsMBHAJaWk97gPhgZAEd3TWKMiNwMHc6Uh2pQmnmvHXJOkKw4q77/v8H3ISwYo1q1mewhmMKmuQUpDCMaAnp66cTl9v8hoepVoxtIDFVdptil0gIlFMcJd12Sr/ymJXMjOiFFxpV7Lbty8dnxWRKwCoSmSD1rzfVVAEv3mBr7ZlPD7IqgTeTR/KO1cqhqWhc3GVB+/RYZisWAlwa4FGMZb0t/b05UWcnxxQpCu4KggDsOEidetY4CDAdj50vlheoIV17x2oYwkDJBatl3dCan0rw3Q4g==
X-Forefront-Antispam-Report: CIP:195.60.68.100; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.axis.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261021123027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 81psQLW/9rC0OIxU1QFVchcwev1o5V+Fl9eg22wyFtUGffd0Ay+Mi4l1gqhaRzJKM1wvuC4ifQ2MDlW9b5hnvavGoBjVNqbUKulJi7xdqM9sOWYFVkwxlgcKaSgj2MHyHOPWO4s+LWhzp09g/QwdUMVaF4J2Wp0rl6sn2+H5D9R/fUIN+56Ce1Iwh4Pgm2pZco7kVLhKoFyvZaxCzCJCU/468jav1gN/dB0IGwduW81R0qX7yrPfiVFyX2N+l+ga480C5k5tc6Mx/rgY/Q+KTYFWNzq4WNPFHm0UBnJ4/HYUEhtWK2LLxt6NdwUFKajXDd+gAJYcc1EdeKtEOoIR8PXG8ed84GZai6/EKdR/+Gih/Q9eRF3h53QSmxi/qDHVsjI0gu/Y9mZIzsO44a1gRvDnkk3JbkXHv9YdOIbAyo6dRpY8ZrSijpTfAvR7jA9R
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:31:21.9380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96853b2a-64f6-4185-a350-08df305186a8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af; Ip=[195.60.68.100];
 Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000530.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9568
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

To: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: kernel@axis.com

The Sitronix st7571 driver previously supported the st7567 and st7571
chips. This commit adds support for the st75156 chip used in SPI 4 wire mode.
In order to use the st75156 chip, you need to specify
CONFIG_DRM_ST7571=m and CONFIG_DRM_ST7571_SPI=m in the .config file, and
also use the compatible string "sitronix,st75156" in the device tree.

Signed-off-by: Lars Rask <lars.rask@axis.com>
---
Lars Rask (2):
      drm/sitronix/st7571-spi: Add support for ST75156 controller
      dt-bindings: display: sitronix,st75156: add example for SPI

 .../bindings/display/sitronix,st75156.yaml         |  67 ++++
 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/sitronix/st7571-spi.c              | 118 +++++-
 drivers/gpu/drm/sitronix/st7571.c                  | 420 ++++++++++++++++++++-
 drivers/gpu/drm/sitronix/st7571.h                  |  20 +
 5 files changed, 617 insertions(+), 9 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20261015-add_st75156_support-00ec2c7f63a6

Best regards,
-- 
Lars Rask <lars.rask@axis.com>

