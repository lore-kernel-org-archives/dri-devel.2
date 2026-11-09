Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBDA606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F7810E87F;
	Mon,  9 Nov 2026 09:31:15 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023130.outbound.protection.outlook.com [52.101.127.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AAE10E3D6
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 09:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0yIwxpWV/EerGS3ek4qT+Hs9K844spEUEyBgIod6MVYsqIAQSYJxlosV9+PH8BO31idbfZwCFmTrEim00MdfDXGZtU37Tard6HWEbgi7tGwf1my9iVG2JKWerFU24Npykv8Gu0MllfS/dNBhwQCGaATpj69OHWIhLyS6++iizBO5sJ4NYs+Dw2WaOCsf6hIX+CKLu/Ae26gVQXKE2IMd3Wbs22Fl/E3L8VLzRG6yBeh4k68VcYQNGwvjlbET3ENyNBAsl/VrtOIiADiwJXMeCThjSy9oc741e3rDknnapmZy+NKo4fk3A8pmAKF/zb+9NGLzQDggPlpXGlCfQmw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP0Z8TA/eZkuzNwDEz9YUF9pu7NoYEjCfCEun5no4/4=;
 b=DvN/Wq8Hhdy5E7CzRVX3l+DRP8gHWmYjiBZj9KOmu4CSWQMD1ESPiqbB01RnnWxlsZ40YvGE8ry4sVmR6P/A8FOBF2VfP9jkSI57I+KKNZHtBVp4Ihyp87A/tWg/E4diXVBbuq8eZicqNBiSyl9em6Rfd705n+p+ucGs2Vza8SzdEOfZk6Jf1IuKQ6HvL/aOaIaH57sQjg+zlPZmmmM4oT+xrqPb4MRnmVTdfhsw91UkPjMxXpW53ts7kfmTLCnXcYB2Bn2EMTZkHE//wWpnrnUYK/cvypZef7FlOJuBPkiV7nMERTAb502mfKHxlnuiatkoWT/9KEfZd1y5bFbGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8) by
 TYPPR06MB8049.apcprd06.prod.outlook.com (2603:1096:405:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 09:26:26 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:4:c6:cafe::34) by SG2P153CA0039.outlook.office365.com
 (2603:1096:4:c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Mon, 9
 Nov 2026 09:26:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 09:26:24 +0000
Received: from localhost.localdomain (unknown [172.16.64.56])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D8A734102E61;
 Mon,  9 Nov 2026 17:26:23 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: Luo.Liu@cixtech.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com, gary.yang@cixtech.com,
 fugang.duan@cixtech.com
Subject: [PATCH 0/2] drm/cix: add Sky1 DisplayPort transmitter
Date: Mon,  9 Nov 2026 17:26:21 +0800
Message-Id: <20261109092623.102291-1-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|TYPPR06MB8049:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 65a5ddc5-a32a-4b41-8fdd-08df3e438682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|42112799006|23010399003|18002099003|56012099006|261009223027099003|261102123227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: Q9RNPSAbSubCO2j3YsCcK7xbE6MncQbZUXmWj7Hhw33HAEJm9lwFZo60FWBZOEGk7yHnsQR2PpdZ2EzJLB00oXKrfrQ+3/8Y+BCeY1HfTDuWXUr/p46eqRrsCnWxqU9UiIn9FALKDjzcgb9f7dy9CbSV45OAOUjQRSgl1cwannQfm8J72HHE+qHi0EaNpMKj0PbmHU7HXVV3S4RN5DidkLQF5RFVWrpevoVxCS8NKslaRAXUt07vS9ju/uOrkuldgzNGW4kJmqJxcrvE2PEgEHK4STsn9JEqbevCChYyKZbDdAe011uQOCjOYhoppRy5y68AIYjBoxrZpks78gXDFG9e6E00FBXuWKhGxMDD2EUBuJQSakGtTFNWFLjVpgH7Sf6eGaecsV0TLwGZHIXoKdUrL2wngCdCmw4KcWzYym39YWbs9KFRQGOzqqykjJq04nc/AUjjnQ77ERSZgys7vkb5vJMWefbQv83zs6ewmfrFYmPlHN97/i7z4eFfY0+wPhC3n2jRhsVWSzev7By+vC6llVQBb2B6OAdR7/DweAZ+VXF9R1LSIqSpwcmndL/RvIELfzczS9FFbcHdLBoHbQDM0EzrtpzOjIMQtYv9iZaliiBkjRWEzHD3Wz3Die+Vnr2n+uRLCM1amOjfVNS6ndW1ws37Z+MxwqrBloOdiMMTLCxJ8IEA39OM+pTUU0Df
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(42112799006)(23010399003)(18002099003)(56012099006)(261009223027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2B6i8gJM5w8hyanE86NjP3RRp09w/DMH0SQ5pTbud8dy7miiRbQMCJg6ZzSPBe4V2/k4dNsVUU0jlKKDL59Uv0PGtmnurifPu1CTrmQvwm71YCA11rEa/AUcg05lAQG45dBqW5ke/3eWn/EiZmFJ3F+eipNNW2t2zbnD6k4DQd0uVoY7Q5wFJKpWXTbA/qAkOsSvUA+VLZRvW76/hK+n/tkTQbzAkIEIy6YHgPsjAtz/EB78GaFaF5tswxYg4TK2fsyzyuMsbLE04DbEQLSB+HNI1RwMZSJmUMcx766eokj9h+wNbPaZd29u/LDnkyOMECJFSBlC+98UkjAnnenDtZC97kyaIHVt4+F/Jn0WbuIKzGz+cssPC0SrCKENkXSX3ilWQa8fZ0eml6OswWTyUitPQ6UPG2OP7wSQgzWKy3YC0fuLOIr+EOlvatkXaDr5
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:26:24.7830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a5ddc5-a32a-4b41-8fdd-08df3e438682
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8049
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the binding and the DRM bridge driver for the CIX Sky1
DisplayPort transmitter.

The devicetree nodes are left out of this series. They depend on the
DisplayPort PHY binding and driver, which are not yet upstream. The
SoC and board nodes will be sent once that PHY series is accepted.

Luo Liu (2):
  dt-bindings: display: add CIX Sky1 DisplayPort transmitter
  drm/cix: add Sky1 DisplayPort transmitter driver

 .../bindings/display/cix,sky1-dptx.yaml       |  108 +
 MAINTAINERS                                   |    9 +
 drivers/gpu/drm/Kconfig                       |    1 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/cix/Kconfig                   |    3 +
 drivers/gpu/drm/cix/Makefile                  |    3 +
 drivers/gpu/drm/cix/dptx/Kconfig              |   16 +
 drivers/gpu/drm/cix/dptx/Makefile             |    4 +
 drivers/gpu/drm/cix/dptx/cix_dptx.c           | 2086 +++++++++++++++++
 drivers/gpu/drm/cix/dptx/cix_dptx.h           |  370 +++
 drivers/gpu/drm/cix/dptx/cix_dptx_drm.c       |  653 ++++++
 drivers/gpu/drm/cix/dptx/cix_dptx_drm.h       |   16 +
 12 files changed, 3270 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
 create mode 100644 drivers/gpu/drm/cix/Kconfig
 create mode 100644 drivers/gpu/drm/cix/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/Kconfig
 create mode 100644 drivers/gpu/drm/cix/dptx/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx.c
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx.h
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx_drm.c
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx_drm.h


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.25.1

