Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6995106FD9E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC9B10EB27;
	Fri, 13 Mar 2026 08:25:05 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022099.outbound.protection.outlook.com [40.107.75.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C97610E08C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVXkWnJYpB0f3KetmfsuTngPLzgv/l0SjXusg66XxNmmp7GJCw1PGkXyGLjwfpPk0yI43xD9rl9JM7Agl2X6fHC7mUkxomuIuOAeuI0qoYLg6yVOSrteYfP8G61jhq+0p6qFw9idjP1IAWLhlppETM3TTqnkksHK6ARdiCK/i8WYjVkXVkNOXvpPeIzEhP0fiuspr6qJJxBWcT0YcsYKMrMpM/InoZbQxEmvBP2I53ckFPSzPTA6wUgV7mF890JWl75K7C9UF8X2INX7xX+IiKkYDHzsfjBQcAHtOzB0HMs+VUdaSUN9FbI+Qcg7rEkgqINuE68PdwYhvvbItyS1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0IRboASkZu/bMACbgNhlDBXKJ3ArEKo0n5mulo+uWo=;
 b=lv4KYTc8/rgMzlNUfsu8PwUWyAWNFj2dq2Cql3gJ5QYjzSg7e5i3l24wcKXjpRLEkDr84SsuP6Upipi8qf9vziKTbO8V4keNWbg/LWdvj7oZ0NINbMkfBghESfvPicSr7vxhZABMYx9lrQ+vkP7PT/VOp3cnB1WUIWlLCYzAwxdiI3ktTDGzi+d0JweAJbdPnRf3rlMuUobZllY/PGRYHUApVplQ3GEiKKkWCHsqa8yAi57Sf483JWW8r8mZ+fhAs3m0lsXKGz1HKBvxY04FgjXeoQZKBRpw/7Zb9YirkXEMGCdz4adgWodXQUYBrsjC+LTtL/Ur/HYgONVDXOj3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:300:59::33)
 by TY2PPF5EE8C6F8A.apcprd06.prod.outlook.com (2603:1096:408::792)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 13 Mar
 2026 03:31:22 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:300:59:cafe::7d) by PS2PR02CA0045.outlook.office365.com
 (2603:1096:300:59::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.30 via Frontend Transport; Fri,
 13 Mar 2026 03:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 03:31:21 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id F108C40A5BD7;
 Fri, 13 Mar 2026 11:31:19 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: neil.armstrong@linaro.org, heiko@sntech.de, marex@nabladev.com,
 dev@kael-k.io, prabhakar.mahadev-lad.rj@bp.renesas.com,
 andre.przywara@arm.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, Cunyuan Liu <cunyuan.liu@cixtech.com>
Subject: [PATCH v2 0/3] Arm China Linlon-D6 display controller support
Date: Fri, 13 Mar 2026 11:31:16 +0800
Message-ID: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|TY2PPF5EE8C6F8A:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 01b4d406-ff12-4f87-022c-08de80b0ff22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: sab4KzK2mySXxiJ+auz68yddyMaBO31Bh2PjaLCrYoeH1UAya9dw9RqQAo/SDXRIbOGPlMPzqvf1FiczJyTgN0TVslbCkC1vELvuIgLfi/22QubjSpq77/ZHBai4ZFTo1ufAbaJvsDCvPxp6FTJ9qiAR7T0Dkx5RNUl4eVrhCfrqS8HsYj8/qPAaXGKLmRe1lBka8SDIwrkWdqgeEyxbXyQViXIoow2FQ6nrpHw7qlSRTem5TDL+aI60cQNfs90QvBy1GVc4xyaOcX9fHLf6gGAB74PFDj3h3NH+l8EvvQDQ3ahiKuENgCrJyQYToXJ2+TImTsP/w/6E194iwitMjf+c9z+/JEQcGFSjarufDCuUyRPr6kuR2OFCpu9YRYfOXBa1A+b+f22arYYajkA/w54k26zZm1zgydIqP+2OalOGkQ6YM48ztGHXZVrttO83Soz0fUHUNyvRlBUS7bdCcAT8DSmrI0P0gg8z+I6/KNKALfUHv4bvHNCV3e6FCYOaR8IEA4S+fq7tVJuBT2tt2IdHkvnPGCj6LFXutCsoYiQPBfjCIytpu3NNYC6mczUOh9qpPWVZjQ9qIw1DF4iVJowNEum8TCv+pr83+flvAisgMscLPNPKvsf+Clyvp7vN3YEi7TP4MWeTP3b8L8qQvMMPP7fqdpGHOn/9ZPOhd3GRPviCmeuwTK/fBQSQNGu0oXFS0C6kJBSwBhasmv/H+iyQhI7TAHnOPoBpClWeao7HonEhDDlvVLBvtlpKnGjqifxrjs+tI30aviv9SIY/wA==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wXOGuKLdf9Vykxrr1iHPjicImHnQOZCt4P164PlTWKPG7tT1LZD0Q9cecTOY3LlHzI+CvL8l0n1Kl9tkAgf1B+nVgzCp6msHSYCp4hos2eCXKtc0wgtl8e2sLaMjpdzeertHfT12b8AgPy2KTd7JiFx16Lox3jlQ47Y2MVtnYSXDZFb+SaU0hc6MtVW46tZaH0dtpULZpto6Dq69pyOr1FvgTqTgS1oz2HRDjRe6GtpSB+JitcFm6XYM44ulZCboLUpuLd4RMu5j71ek3kxW/dVcE4Iwpj2nHdDDjhgwQw7+6Xuigh0c4d5CM2aqPtxTFL+gnDGrcDcqdfzjFpXYgdc7ceY0L7j6B0T9zwz53ZQvFpFSOyaTAHZruUL3E+NMQ5mlJwx5qjaMzJf0fK1UueJtZVB2kkmXvZMEu2nve3+5w6ovTsKx6wEV9BIOBNAM
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 03:31:21.3630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b4d406-ff12-4f87-022c-08de80b0ff22
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF5EE8C6F8A
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

Adds Komeda DRM support for Arm China Linlon-D6. The IP is register-compatible
with Mali-D71, so we reuse the D71 code path.

  [1/3] dt-bindings: vendor-prefixes: add Arm Technology (China) "armchina"
  [2/3] dt-bindings: add armchina,linlon-d6 compatible (fallback to arm,mali-d71)
  [3/3] drm/komeda: add Linlon-D6 product ID and of_device_id, use D71 funcs

Changes in v2:
- PATCH [2/3]: rework compatible schema using enum as suggested by Krzysztof.

v1: https://lore.kernel.org/dri-devel/20260311055506.12023-1-cunyuan.liu@cixtech.com/

Tested on Radxa Orion O6 with Linlon-D6, basic display bring-up works as expected.

Thanks,
Cunyuan

Cunyuan Liu (3):
  dt-bindings: vendor-prefixes: Add Arm Technology (China) Co., Ltd.
  dt-bindings: display: arm,komeda: add Arm China Linlon D6 compatible
  drm/komeda: Add support for Arm China Linlon-D6

 Documentation/devicetree/bindings/display/arm,komeda.yaml | 4 +++-
 Documentation/devicetree/bindings/vendor-prefixes.yaml    | 2 ++
 drivers/gpu/drm/arm/display/include/malidp_product.h      | 1 +
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c          | 1 +
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c           | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.53.0

