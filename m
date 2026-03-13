Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7497106FD9B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD5610E444;
	Fri, 13 Mar 2026 08:25:03 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176E210E08C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp3khjtRQBFiq5VAQZSRK+xlxWW9SKAIEtBfebc3pa0HZBMThhIz4Mf21JM9MpCdcRKNwaceE0KQ3KifCIPUHkyPQIygBBdpT+01QTGBEVKlPwEi4IXxdacwjIQiiRXEEYXSyJpZKAE2tTWRq/LzpfNbElUPAj0lbSUA/UxvBeDssdSPMCPwUOXtPtQtQaHmrB9RIDwYEt+6tyHe5TAU4pTNBpQF47BooMNpwDKFsoO67D4Y3vhWPd5EO2LqFolGmbD14KRzb1/Z0Gliw3KQtqPqo4SOGW40Jw/X0vkhfl27FSXZgyUdn43tPErROvFPXK5kwIlWGa3t8SCqab+4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3oV+Payb5zlD21BUNuMll4vCDj89JktYo7g7ofEA0c=;
 b=YnRd79fXBnbgVGs2j7QErQQyMM79lddEying4f7dF/wXK3CO+VtkY0glxcu4jZEUsGS/d7p0trkJKVN72zDWY1wFfDEvSP/q7AiJ8uuL4mhunxzgU/682eHwRzrkSLXqL2KVFR8dQj/TFbY4jvMJ6cw0+iPMfeEkh6OWsbJZQ3xbtvjj5d2rYqV/oJtoXsQStbaO3N+13Bn84OvdbzT+5r/+bQMAIb1SI3HCE1v8mzB8QrtIKFtbHX1OVqAs4s0HmkJ/NNXQ0CKL6UtLA4Y/OxyL/urTydTzCb3Nx3vhNEfDpHEpiJbhW+Nu1N0Qmfq98hDUNyBt/s3D8qDZFlh2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS3P286CA0073.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:201::16)
 by TYZPR06MB7334.apcprd06.prod.outlook.com (2603:1096:405:a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 03:31:21 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:604:201:cafe::bb) by OS3P286CA0073.outlook.office365.com
 (2603:1096:604:201::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 03:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 03:31:21 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1DE0140A5BE6;
 Fri, 13 Mar 2026 11:31:20 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: neil.armstrong@linaro.org, heiko@sntech.de, marex@nabladev.com,
 dev@kael-k.io, prabhakar.mahadev-lad.rj@bp.renesas.com,
 andre.przywara@arm.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, Cunyuan Liu <cunyuan.liu@cixtech.com>
Subject: [PATCH v2 2/3] dt-bindings: display: arm,
 komeda: add Arm China Linlon D6 compatible
Date: Fri, 13 Mar 2026 11:31:18 +0800
Message-ID: <20260313033119.33686-3-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
References: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|TYZPR06MB7334:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ec260a80-e2a7-4dc9-4084-08de80b0fef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: faeyjBOZoEXFD1eJT5nbvrZT5+Du7mO2A3u/tr5XUyvh+L0Y6clihxYlQhlC843mT7W9jL0bnln0vRYWfAOF0qcjgVrYCTlrUj6DC1t9YkKCk6vfl/TCIz71i59/PVQicbNC9L8bohLhX/di5TmvtQ8z1wwuRr+rn/LfWnzZrziW4uJXCRuEFN1VZSc9zciWkTfzyPDqG0KYbFmX+7sDaQOTU5+w8N75oPzAmttq1ENaHltLuOs2ZMbtidzNZgMRfJPD9QeDcKfISDNh0yHZJFYa5Z+Q4w2AVuv8nuNXI8APO83fhOqGYEfCnHK7LOBHruKBOsD4CXpJ74GbCT7yL0P32w16sam8Gi1C3TM7zzeh5tvvcQfnpB0yfQYO58+D/T70dGjIfvYge7civptjZcuYoeNV663moFMgzbe2e2bFJLSRlVy0z4VujNDvt7oA1qrZNHJXqAwxe8VKd5d8suY9BOY9ftI+I6rtrWAmedwPxdlH+bKYFnHV6/ugGDLGXEhfOrLu3qQgOcRCFT1ZH6F5fsXdWRsNvLV5melXliL7vg6mNr3WbRrOs7lh+nwF4I0k6Fs+KPVP4OJTd1DVH5jj8Z7RkOPiMrY6VM3YeFCttglo+rqTG8Y1e+GXyPg2SUvXlaGYJv8+7WlT2i6IfiGRQImppGT4mW/XbEf8y672Zl45WLBKfqF/156ReyIeaAi7+mLIUfFUa1pFid8zfa2uYxt2jdD9+AxehUEbsbLIXOq6iuSY9vhwOIykTkxWY+y9Pas1m2Uc1CPohhRTxw==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8voEyaDfsC+Pt1uei3mzWW1BS358BUMSKkAzwkVbsHvtcOvnF/WgbKJpjzw/ad6EGTfSVLHAhZI/WmFJtjJDgKvO8PubWnwjdlfYMoOKirOdNJHWF26z8VAaNrAPVcbQecEeFLq87yPzNHIienKcBo4vDSxBEeO4kkZZpP90hWtaICbpnrNctaD9hr0ZG0aN7kotSSLbqs+4IcodrlCSc2fOxw8nWRIbSmyRo46H9S+zuxC+FEHGhNmhOn9250bMYR4xRl2D1uEl4XOnUr0tQvRYNZUnDTYsfAX/MWGXZKGfYzMeAl5iYACkdzVA9hcyT69xVfkg8e6CznVyKWz7iYiriqjutrNa3IXUXpkQ4r/qG7YOZGJ43luY3Is5Kwr77u2MWgk6tYt0bo31nIg5OM1WOcsVAgO2KrgqBNNofOxL+RyE+gxO4gKG7ywxknuU
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 03:31:21.0588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec260a80-e2a7-4dc9-4084-08de80b0fef7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7334
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

Add the Arm China Linlon D6 display controller compatible string.

Linlon D6 is register-compatible with Mali-D71, so describe it as a
vendor-specific compatible with a fallback to "arm,mali-d71".

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 Documentation/devicetree/bindings/display/arm,komeda.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/arm,komeda.yaml b/Documentation/devicetree/bindings/display/arm,komeda.yaml
index 3ad3eef89ca8..1afd254b6c2f 100644
--- a/Documentation/devicetree/bindings/display/arm,komeda.yaml
+++ b/Documentation/devicetree/bindings/display/arm,komeda.yaml
@@ -19,7 +19,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: arm,mali-d32
+          - enum:
+              - arm,mali-d32
+              - armchina,linlon-d6
           - const: arm,mali-d71
       - const: arm,mali-d71
 
-- 
2.53.0

