Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A42606A9B0
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GWySwH3x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A4710F72F;
	Tue, 10 Nov 2026 14:28:36 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F6010ED0F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd47m2xVF/7GPrUU2cqZrE+VbSThCNYqw0Avl1KeO77lB9EZI3vOz80k/tqPF1MfLnlr1sY9QUHGk6CcKpK+skfrAz6lyUYT4DZ/WZHbvaPSAcVyP+lXxoYcyFBEpw5QdnjjjLkwyfUuGCtfEhZc3EkrlqIDGMUHb+rPByCDmapKt0Br7PXTETx+8AATejfpEG+B+BY3wSp5SWd//hjxFMcOjOrfIB518edkMzniNd5GozB4fcSKmfR/oOhZFt+3v7+WtcZia2E0U07EzbmxUEQVzDB4Dzo6fd99lKCxJNqCViIlQgPiTJ5SFbbglIBWOtTt78w9Zm2NHuA1qyUlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LMtX/R9LROQZAHZzKnmeuIyca21pOkAN2nRXImb9vk=;
 b=ZgBYfPx4MKYmasKjTZl1JknS7p0Mu5986kRcdwMGepqKqE+2aVRyygUghssEpjr3d7SqBkKuqNB6J8czOxBlkXvk3BTC78FyHGJh1x4pcvKHAmt5emKky+V1xWgOV3Q/hW9h25wAajPr2Dyq6/FynEd6IoRfikkcb34A+wVgI0FNotfYleiDoNmQtFDYPNiUzjHo3seB9Kkb+i6/AW4BFKNY3GWNZukAOJWKS24FRWTQT6UNLRRAXA0lqagW/lCzSKknqbMdhjGd/dUwS/zVyfbWv954yFPoTS5LzJTMrcK4XQrtENDMB674fxbOi8Wk8ktDPhhSoR7gF2Hl1YQd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LMtX/R9LROQZAHZzKnmeuIyca21pOkAN2nRXImb9vk=;
 b=GWySwH3x1s3l7tJ4jRG4fIDGjI87FcXLaLKt/mLutWIUolPXs9n1w+2cSDbLb73B/NNKM0kXHPlI7SYgJLjSx3BDAz6556QaIG84UO4bPUMS8Ge3N55LHld0AIez4sokg51TfCJWponUO39p9zfyA2V2XyYdN1rXGb2z1yggYg/p+Ry15nm/t8I+kxDFRgON5U2NJTOLvvLrMCPNDTvXFtjkd+ykoxRQhlKb567ABLc1hwmfW6j0TUba/T820k4C0APqGZdfpwZZ8FNv40I2rKwdY6zQsQa7mZVPSzf6jWi0Yvtfbg8c8auqeknIkHWU/fidIALOPQeDXBBuko29Ow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI2PR04MB11196.eurprd04.prod.outlook.com
 (2603:10a6:800:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:28:15 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:28:15 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v11 4/7] drm/imx: Add support for i.MX94 DCIF
Date: Tue, 10 Nov 2026 14:27:44 +0000
Message-ID: <20261110-dcif-upstreaming-v11-4-9e13c85ae0d8@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::6) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI2PR04MB11196:EE_
X-MS-Office365-Filtering-Correlation-Id: d57a44fd-ee45-4b34-f02e-08df3f36db72
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|10067099003|11063799006|56012099006|261021135927099003|261021121427099003|261009223027099003|261009221227099003|261009223327099003|261009220027099003|261009221727099003|261102123227099003|261026140227099003|261022075727099003|261026121527099003|261022113327099003|261022105027099003|261028144727099003|22082099003|18092099006|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: fU6Tu36+xtwL6VFe+lXr6TXhMiUo+ODNOmg/C9B5L6PqYWxQY1mAVw/L247+DqW9EzZBPNVIViSOL3o7OG+CgEcVUGZcDYyZgRjQ2gVgx5IKtEVpYevTBZcelBOpislw5e6NqBRZFCL7pczAxx8HYom+QP53RhMEMwZg/R4eYog4sg7mGhWZZmPx7RBk6/RCX5x4bE1aTID759kOOu3ovi8B1LsYduhCO8bIcpVzEuKomJ5AUZfH5hsgcdegP6xm8C8mcky4MO9I+pRWWCliZqqP3vs4ES4rrtF0V22VbQNVUSLXgAr4ZO+RI4b7JIEQhjc2Cr2/+K1gtNIu5e0JmgsBuUUEUmhn+X18WQsvvIPyHLsuxdZn+SWCceWt4y9j9DlaVjkAZRnY5jOBZm08ha0e9HJqQF9g83kUFn3HpqH2Ohf72WgvjBjKz95bwC2m/Qj6EPVn+0PJs7afjsRxssh1XPXPnwJPTrbuFJAwlncvdvEekBX5psHqnMASzkJwoQa3wkG4w9otSJ+Hl/U+foFTORaUzdBIRKDzBRyBhHdhfQI3VaV3izwbNo9EP+1BZzxv3noi69bFJ88TY32/fVBkfrYV1Mi0022qNXiD4rzC1zJtdBNejMY1yEfAYoVf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(10067099003)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261009223027099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009221727099003)(261102123227099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022113327099003)(261022105027099003)(261028144727099003)(22082099003)(18092099006)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWpJQ0FiSVJZbTAzelVPYWYzTXloZkd3bkpoU0VmQlI3czZaR2tVakRmajNw?=
 =?utf-8?B?YkI5dWhISVFHK1lsTy9HdWNBS1ZNbHJEN1dIWk5OOFN0ZUtUOFAzMmR4Z0ZJ?=
 =?utf-8?B?VC9kSkNWVVN1ZzdydkJBTEltaW4wTzN2aFpMK3BDcEwreDFnbHBmRnNYSDBB?=
 =?utf-8?B?bXN5LzdTNWxrUXhLNHZvai9WRDErMmwzVCtGNGVrNS9aM29kem9XOVlSVWMv?=
 =?utf-8?B?R3V6RmJKbWUrZUdWVGlQZzNkbnFLa1B4MkNLa0JVZnk3c1JWVER3aHpiSW1i?=
 =?utf-8?B?S1dMQUJpVUtpVHRjRjJzQ3Jsd1hjL1RxYlRnVEVYWVhCZ1dzR2J3UUJrdTF3?=
 =?utf-8?B?WU1ibVM4d1NQV0FvVDJxdVBqYVY4WEFSV29STmYzZ21LUVhWV213d1NNME1K?=
 =?utf-8?B?clpsZGtLcDJoMG1ONE9QWlpjbFlyaEdRYnNlVHMrNUx6eVozeWRLZno1blc2?=
 =?utf-8?B?elp4WHEzWjY5ZHdnYU5EWnJ4ckxKdlhGV2Fpa3diODF2eVAvRGxoZzVRNzRY?=
 =?utf-8?B?MjIvejl1TTd0b2xYRkJzRExCTGtobGFlMkNrNDNEa2QzdW9KRFVjci9NeWph?=
 =?utf-8?B?ZUtScWlnVmxBckdFVEZLRlpYd2FHRHltWXBjTHhSUXpSa2ZvWTBnNldwYlUr?=
 =?utf-8?B?UE9zU3FRcWcwMkZKUmVKYnhxeDZ1L3ovdlhJb1lvQVdOamZlOHlIVzd5aUJx?=
 =?utf-8?B?VCs0SEh1V0tZcjdEZ2ZvemZsN3pyYzZ6N2dGbGpRcmQ2SHJmanBkN0NKQ1FR?=
 =?utf-8?B?dG90R2lMa3F5RW1RNEJSaldFUFMrSTFCcG0wbUR0YXN5b1lpWWVYV2t2WTRi?=
 =?utf-8?B?bG5RZHNlKzJsdEUvWHkxbkRVNDNIWFE4ZHBDdHMrZHNyMHNycE80ZU9KWEhV?=
 =?utf-8?B?M3lIQk41aGNlbzUzdm9UV01td24vK01taSt0VTR4R2tLUWVUK2JvUGdqYjFG?=
 =?utf-8?B?eHoyU0FxdWxocFZCMjBGaHNMMGZLQmtwQVpYdW9Tdld3c2dyeDlhSjdaYmZr?=
 =?utf-8?B?K05mc1NYWWJ0Z3luQmtzL042SGNoVUVHYkRDbFhnTFRCL1NtcDNVc09hOWtp?=
 =?utf-8?B?ZTdES29ML1M2cWZuNWZMWCsxeDNwU3IyZkM3bHNKalhPNHlkb281dlJaR2t2?=
 =?utf-8?B?cUhxWFdlZDV2RnZOU0dqVHduUXZLOGVFK2wzKzdOMTAzZW5aKzRtSjlvalRC?=
 =?utf-8?B?bEJqOXNycUtlLzJHZWE2cS9MaWRFRDVpLy8xbG91UEpZc0RFbHluUlU1UkQr?=
 =?utf-8?B?NXQ2OS85dlJpWVNQSWNhbHJWcW5NV0FDZVE1SWxaSHVJM0RzbmNRRGlGOHBK?=
 =?utf-8?B?OHA4RG1Kd1ErTDk3N21PS1dPaVNMb1NMcUFkK2orSm9GdFdaZnRnbUJycXF4?=
 =?utf-8?B?Z1pSS2hjc0ZlYzlTclJ4MjhlUWJIcXZ1L2VsdHJsQXVCYWVFbTVDVzZ3Vmty?=
 =?utf-8?B?WDljK2ZrbFdJRWV6L1l0V3BHYVllZkxXNE8zSGZhQmZ3VjUwVDRmTTJPNTMz?=
 =?utf-8?B?SytVNVZVdkZ4dnhzZDZHeFVWbjlzblcvb0t5c0l4blE1TW1zdCt5MVVraTRu?=
 =?utf-8?B?UzJoTUF5SXc2YWJSc2xJemxFWmpSWjFGR2hOYXMraVpsR0dkeDZ4a2d2bHE3?=
 =?utf-8?B?VHBhb2lmZkxBcGxKN0x2NUVnTFZzU0hpV3VTa2JuV0V1S3FoZk9xVzhCNHJN?=
 =?utf-8?B?OGsxcThLRzRQcWVpZE5DNUJuRk85R1FUcmJjd3pVN0VrbGVSc2s4Z01lYTFK?=
 =?utf-8?B?eEpBQUNmdGN4WjEzY0lmcEF4NzNFNFc0aGRXcUphN0NXMWNwektNYmJIOHZN?=
 =?utf-8?B?MUcwNnMralpwa093SzQvNFBmZVR2S0RyWFlJWjBuZFNWbGRZMXVqL0xENmox?=
 =?utf-8?B?UjNYSm8vVHZkMG5UZlNjNnllNlBaQmF1STRsWTNDbG5YWkFJTFdkZCsrTFBI?=
 =?utf-8?B?V0E0MUNNdUt4a01jakRsVk8zNlo5OWxwR0U1M2RQZ1NyLytjUTJDYmRPL0k2?=
 =?utf-8?B?NkdBMHVjWlFzV0VKSjdwcmpyYWFoWmNvaVBzVzg4Z3cySWQ1aG4vUGhnRnMx?=
 =?utf-8?B?eWdNNE5VVCtDVnNkd1Y2UjhZV3pVcHZ5U3VGOTdsbHBJTitOeENWWTB5SmE1?=
 =?utf-8?B?QzcyUzJ1a1QzWTg4NldrTXBpbUFXSTV3YTlzVG1sb3ppOGpzbm1hYUV0Z25R?=
 =?utf-8?B?K0wrZi9YOTdscndSZXhSS1dFMmNWaEllNmR1K2FydXFXQTQ1a1VlZnBIc29o?=
 =?utf-8?B?YVV3VGZIaDh2N3FXdkV1SWhORkhZWmVobDRHT0l4TGRlS3FYYlMvVW1ZL2FQ?=
 =?utf-8?B?YmlFV2RReTd2NGM5c1dxQUhmaXlCNzUrUWVvRHFQR0JvS0lKRzZ4MmlBVUVJ?=
 =?utf-8?Q?7M1NNgsqK5MgKe/o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57a44fd-ee45-4b34-f02e-08df3f36db72
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:28:15.5466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JBPOUFC8n9ougYh7pXgQfEkRFTh7BfIL0thWdrZNOBA3IMa6/lXMZToUk82SiCe4FfvSPCACRD87TNd4MN0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11196
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sandor Yu <sandor.yu@nxp.com>

The i.MX94 Display Control Interface features:
 * Up to maximum 3 layers of alpha blending:
    - 1 background layer(Layer 0);
    - 1 foreground layer(Layer 1);
    - A programmable constant color behind the background layer;
 * Each layer supports:
    - programmable plane size;
    - programmable background color;
    - embedded alpha and global alpha;
 * Data output with CRC checksum for 4 programmable regions;

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # bridge refcounting
Signed-off-by: Sandor Yu <sandor.yu@nxp.com>
Co-developed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 MAINTAINERS                           |   1 +
 drivers/gpu/drm/imx/Kconfig           |   1 +
 drivers/gpu/drm/imx/Makefile          |   1 +
 drivers/gpu/drm/imx/dcif/Kconfig      |  16 +
 drivers/gpu/drm/imx/dcif/Makefile     |   5 +
 drivers/gpu/drm/imx/dcif/dcif-crc.c   | 221 +++++++++++
 drivers/gpu/drm/imx/dcif/dcif-crc.h   |  54 +++
 drivers/gpu/drm/imx/dcif/dcif-crtc.c  | 708 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.c   | 248 ++++++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.h   |  90 +++++
 drivers/gpu/drm/imx/dcif/dcif-kms.c   | 168 ++++++++
 drivers/gpu/drm/imx/dcif/dcif-plane.c | 300 ++++++++++++++
 drivers/gpu/drm/imx/dcif/dcif-reg.h   | 268 +++++++++++++
 13 files changed, 2081 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f87d0b02ccfe..19e50098e67a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20320,6 +20320,7 @@ L:	imx@lists.linux.dev
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
+F:	drivers/gpu/drm/imx/dcif/
 
 NXP i.MX 95 CSI PIXEL FORMATTER V4L2 DRIVER
 M:	Guoniu Zhou <guoniu.zhou@nxp.com>
diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
index 3e8c6edbc17c2..1b6ced5c60b51 100644
--- a/drivers/gpu/drm/imx/Kconfig
+++ b/drivers/gpu/drm/imx/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 source "drivers/gpu/drm/imx/dc/Kconfig"
+source "drivers/gpu/drm/imx/dcif/Kconfig"
 source "drivers/gpu/drm/imx/dcss/Kconfig"
 source "drivers/gpu/drm/imx/ipuv3/Kconfig"
 source "drivers/gpu/drm/imx/lcdc/Kconfig"
diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
index c7b317640d71d..2b9fd85eefaa3 100644
--- a/drivers/gpu/drm/imx/Makefile
+++ b/drivers/gpu/drm/imx/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DRM_IMX8_DC) += dc/
+obj-$(CONFIG_DRM_IMX_DCIF) += dcif/
 obj-$(CONFIG_DRM_IMX_DCSS) += dcss/
 obj-$(CONFIG_DRM_IMX) += ipuv3/
 obj-$(CONFIG_DRM_IMX_LCDC) += lcdc/
diff --git a/drivers/gpu/drm/imx/dcif/Kconfig b/drivers/gpu/drm/imx/dcif/Kconfig
new file mode 100644
index 0000000000000..a0eb088905507
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/Kconfig
@@ -0,0 +1,16 @@
+config DRM_IMX_DCIF
+	tristate "DRM support for NXP i.MX94 DCIF"
+	select DRM_KMS_HELPER
+	select DRM_GEM_DMA_HELPER
+	select DRM_DISPLAY_HELPER
+	select DRM_PANEL_BRIDGE
+	select DRM_BRIDGE_CONNECTOR
+	select DRM_CLIENT_SELECTION
+	select REGMAP_MMIO
+	depends on DRM && OF && ARCH_MXC
+	depends on COMMON_CLK
+	help
+	  Enable NXP i.MX94 Display Control Interface(DCIF) support. The DCIF is
+	  a system master that fetches graphics stored in memory and displays
+	  them on a TFT LCD panel or connects to a display interface depending
+	  on the chip configuration.
diff --git a/drivers/gpu/drm/imx/dcif/Makefile b/drivers/gpu/drm/imx/dcif/Makefile
new file mode 100644
index 0000000000000..b429572040f0e
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+imx-dcif-drm-objs := dcif-crc.o dcif-crtc.o dcif-drv.o dcif-kms.o dcif-plane.o
+
+obj-$(CONFIG_DRM_IMX_DCIF) += imx-dcif-drm.o
diff --git a/drivers/gpu/drm/imx/dcif/dcif-crc.c b/drivers/gpu/drm/imx/dcif/dcif-crc.c
new file mode 100644
index 0000000000000..132e40d3f3d45
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/dcif-crc.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_rect.h>
+
+#include "dcif-crc.h"
+#include "dcif-reg.h"
+
+#define MAX_DCIF_CRC_NUM       4
+
+static int dcif_crc_config(struct dcif_dev *dcif, struct drm_rect *roi, int ncrc)
+{
+	int pos, size;
+
+	if (ncrc >= MAX_DCIF_CRC_NUM)
+		return -EINVAL;
+
+	pos = DCIF_CRC_POS_CRC_HOR_POS(roi->x1) |
+	      DCIF_CRC_POS_CRC_VER_POS(roi->y1);
+	size = DCIF_CRC_SIZE_CRC_HOR_SIZE(roi->x2 - roi->x1) |
+	       DCIF_CRC_SIZE_CRC_VER_SIZE(roi->y2 - roi->y1);
+
+	regmap_write(dcif->regmap, DCIF_CRC_POS_R(ncrc), pos);
+	regmap_write(dcif->regmap, DCIF_CRC_SIZE_R(ncrc), size);
+
+	regmap_set_bits(dcif->regmap, DCIF_CRC_CTRL,
+			DCIF_CRC_CTRL_CRC_EN(ncrc) | DCIF_CRC_CTRL_CRC_ERR_CNT_RST);
+
+	return 0;
+}
+
+void dcif_crc_source_enable(struct dcif_dev *dcif, enum dcif_crc_source source,
+			    struct drm_rect *roi, int ncrc)
+{
+	if (ncrc >= MAX_DCIF_CRC_NUM)
+		return;
+
+	if (source == DCIF_CRC_SRC_NONE)
+		return;
+
+	if (dcif->crc_is_enabled)
+		return;
+
+	dcif_crc_config(dcif, roi, ncrc);
+
+	regmap_set_bits(dcif->regmap, DCIF_CRC_CTRL,
+			DCIF_CRC_CTRL_CRC_MODE | DCIF_CRC_CTRL_CRC_SHADOW_LOAD_EN |
+			DCIF_CRC_CTRL_CRC_TRIG);
+
+	scoped_guard(spinlock_irqsave, &dcif->drm.event_lock)
+		dcif->crc_is_enabled = true;
+}
+
+void dcif_crc_source_disable(struct dcif_dev *dcif, int ncrc)
+{
+	if (!dcif->crc_is_enabled)
+		return;
+
+	if (ncrc >= MAX_DCIF_CRC_NUM)
+		return;
+
+	regmap_clear_bits(dcif->regmap, DCIF_CRC_CTRL, DCIF_CRC_CTRL_CRC_EN(ncrc));
+
+	scoped_guard(spinlock_irqsave, &dcif->drm.event_lock)
+		dcif->crc_is_enabled = false;
+}
+
+/*
+ * Supported modes and source names:
+ * 1) auto mode:
+ *    "auto" should be selected as the source name.
+ *    The evaluation window is the same to the display region as
+ *    indicated by drm_crtc_state->adjusted_mode. The region of interest
+ *    is left zeroed here and derived from the CRTC mode every time the CRC
+ *    is programmed, so it follows mode changes.
+ *
+ * 2) region of interest(ROI) mode:
+ *    "roi:x1,y1,x2,y2" should be selected as the source name.
+ *    The region of interest is defined by the inclusive upper left
+ *    position at (x1, y1) and the exclusive lower right position
+ *    at (x2, y2), see struct drm_rect for the same idea.
+ *    The evaluation window is the region of interest.
+ */
+static int dcif_crc_source_parse(const char *source_name,
+				 enum dcif_crc_source *s, struct drm_rect *roi)
+{
+	static const char roi_prefix[] = "roi:";
+
+	if (!source_name) {
+		*s = DCIF_CRC_SRC_NONE;
+	} else if (!strcmp(source_name, "auto")) {
+		roi->x1 = 0;
+		roi->y1 = 0;
+		roi->x2 = 0;
+		roi->y2 = 0;
+
+		*s = DCIF_CRC_SRC_FRAME;
+	} else if (strstarts(source_name, roi_prefix)) {
+		int len = strlen(roi_prefix);
+		unsigned int params[4];
+		char *options, *opt;
+		int i = 0, ret;
+
+		char *buf __free(kfree) = kstrdup(source_name + len, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		options = buf;
+
+		while ((opt = strsep(&options, ",")) != NULL) {
+			if (i > 3)
+				return -EINVAL;
+
+			ret = kstrtouint(opt, 10, &params[i]);
+			if (ret < 0)
+				return ret;
+
+			i++;
+		}
+
+		if (i != 4)
+			return -EINVAL;
+
+		roi->x1 = params[0];
+		roi->y1 = params[1];
+		roi->x2 = params[2];
+		roi->y2 = params[3];
+
+		if (!drm_rect_visible(roi))
+			return -EINVAL;
+
+		*s = DCIF_CRC_SRC_FRAME_ROI;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int dcif_crc_source_verify(struct drm_crtc *crtc, const char *source_name,
+			   size_t *values_cnt)
+{
+	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
+	enum dcif_crc_source source;
+	struct drm_rect roi;
+
+	if (!dcif->has_crc)
+		return -EINVAL;
+
+	if (dcif_crc_source_parse(source_name, &source, &roi) < 0) {
+		dev_dbg(dcif->drm.dev, "unknown source %s\n", source_name);
+		return -EINVAL;
+	}
+
+	*values_cnt = 1;
+
+	return 0;
+}
+
+int dcif_crc_source_set(struct drm_crtc *crtc, const char *source_name)
+{
+	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_rect roi = {0, 0, 0, 0};
+	enum dcif_crc_source source;
+	int ret;
+
+	if (dcif_crc_source_parse(source_name, &source, &roi) < 0) {
+		dev_dbg(dcif->drm.dev, "unknown source %s\n", source_name);
+		return -EINVAL;
+	}
+
+	/* Perform an atomic commit to set the CRC source. */
+	drm_modeset_acquire_init(&ctx, 0);
+
+	state = drm_atomic_commit_alloc(crtc->dev);
+	if (!state) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	state->acquire_ctx = &ctx;
+
+retry:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (!IS_ERR(crtc_state)) {
+		struct dcif_crtc_state *dcif_crtc_state;
+
+		dcif_crtc_state = to_dcif_crtc_state(crtc_state);
+
+		dcif_crtc_state->crc.source = source;
+		dcif_copy_roi(&roi, &dcif_crtc_state->crc.roi);
+
+		ret = drm_atomic_commit(state);
+	} else {
+		ret = PTR_ERR(crtc_state);
+	}
+
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		drm_modeset_backoff(&ctx);
+		goto retry;
+	}
+
+	drm_atomic_commit_put(state);
+
+unlock:
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/imx/dcif/dcif-crc.h b/drivers/gpu/drm/imx/dcif/dcif-crc.h
new file mode 100644
index 0000000000000..c013768708025
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/dcif-crc.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DCIF_CRC_H__
+#define __DCIF_CRC_H__
+
+#include <linux/types.h>
+
+#include <drm/drm_rect.h>
+
+#include "dcif-drv.h"
+
+static inline bool enable_dcif_crc_needed(struct dcif_crtc_state *new_dcstate,
+					  struct dcif_crtc_state *old_dcstate)
+{
+	return old_dcstate->crc.source == DCIF_CRC_SRC_NONE &&
+	       new_dcstate->crc.source != DCIF_CRC_SRC_NONE;
+}
+
+static inline bool disable_dcif_crc_needed(struct dcif_crtc_state *new_dcstate,
+					   struct dcif_crtc_state *old_dcstate)
+{
+	return old_dcstate->crc.source != DCIF_CRC_SRC_NONE &&
+	       new_dcstate->crc.source == DCIF_CRC_SRC_NONE;
+}
+
+static inline bool update_dcif_crc_needed(struct dcif_crtc_state *new_dcstate,
+					  struct dcif_crtc_state *old_dcstate)
+{
+	return old_dcstate->crc.source != DCIF_CRC_SRC_NONE &&
+	       new_dcstate->crc.source != DCIF_CRC_SRC_NONE &&
+	       (old_dcstate->crc.source != new_dcstate->crc.source ||
+		!drm_rect_equals(&old_dcstate->crc.roi, &new_dcstate->crc.roi));
+}
+
+static inline void dcif_copy_roi(struct drm_rect *from, struct drm_rect *to)
+{
+	to->x1 = from->x1;
+	to->y1 = from->y1;
+	to->x2 = from->x2;
+	to->y2 = from->y2;
+}
+
+int dcif_crc_source_verify(struct drm_crtc *crtc, const char *source_name,
+			   size_t *values_cnt);
+int dcif_crc_source_set(struct drm_crtc *crtc, const char *source_name);
+void dcif_crc_source_enable(struct dcif_dev *dcif, enum dcif_crc_source source,
+			    struct drm_rect *roi, int ncrc);
+void dcif_crc_source_disable(struct dcif_dev *dcif, int ncrc);
+
+#endif /* __DCIF_CRC_H__ */
diff --git a/drivers/gpu/drm/imx/dcif/dcif-crtc.c b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
new file mode 100644
index 0000000000000..d5285105fa4df
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
@@ -0,0 +1,708 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/irqreturn.h>
+#include <linux/media-bus-format.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_print.h>
+#include <drm/drm_vblank.h>
+
+#include "dcif-crc.h"
+#include "dcif-drv.h"
+#include "dcif-reg.h"
+
+#define DCIF_MAX_PIXEL_CLOCK_KHZ	148500
+/* Display size and DPI timing register fields are 12 bits wide */
+#define DCIF_MAX_TIMING_VAL		4095
+
+/* -----------------------------------------------------------------------------
+ * CRTC
+ */
+
+/*
+ * For conversion from YCbCr to RGB, the CSC operates as follows:
+ *
+ * |R|   |A1 A2 A3|   |Y  + D1|
+ * |G| = |B1 B2 B3| * |Cb + D2|
+ * |B|   |C1 C2 C3|   |Cr + D3|
+ *
+ * The A, B and C coefficients are expressed as signed Q3.8 fixed point values and
+ * the D coefficients as signed Q9.0.
+ */
+static const u32 dcif_yuv2rgb_coeffs[3][2][6] = {
+	[DRM_COLOR_YCBCR_BT601] = {
+		[DRM_COLOR_YCBCR_LIMITED_RANGE] = {
+			/*
+			 * BT.601 limited range:
+			 *
+			 * |R|   |1.1644  0.0000  1.5960|   |Y  - 16 |
+			 * |G| = |1.1644 -0.3917 -0.8129| * |Cb - 128|
+			 * |B|   |1.1644  2.0172  0.0000|   |Cr - 128|
+			 */
+			DCIF_CSC_COEF0_L0_A1(0x12a) | DCIF_CSC_COEF0_L0_A2(0x000),
+			DCIF_CSC_COEF1_L0_A3(0x199) | DCIF_CSC_COEF1_L0_B1(0x12a),
+			DCIF_CSC_COEF2_L0_B2(0x79c) | DCIF_CSC_COEF2_L0_B3(0x730),
+			DCIF_CSC_COEF3_L0_C1(0x12a) | DCIF_CSC_COEF3_L0_C2(0x204),
+			DCIF_CSC_COEF4_L0_C3(0x000) | DCIF_CSC_COEF4_L0_D1(0x1f0),
+			DCIF_CSC_COEF5_L0_D2(0x180) | DCIF_CSC_COEF5_L0_D3(0x180),
+		},
+		[DRM_COLOR_YCBCR_FULL_RANGE] = {
+			/*
+			 * BT.601 full range:
+			 *
+			 * |R|   |1.0000  0.0000  1.4020|   |Y  - 0  |
+			 * |G| = |1.0000 -0.3441 -0.7141| * |Cb - 128|
+			 * |B|   |1.0000  1.7720  0.0000|   |Cr - 128|
+			 */
+			DCIF_CSC_COEF0_L0_A1(0x100) | DCIF_CSC_COEF0_L0_A2(0x000),
+			DCIF_CSC_COEF1_L0_A3(0x167) | DCIF_CSC_COEF1_L0_B1(0x100),
+			DCIF_CSC_COEF2_L0_B2(0x7a8) | DCIF_CSC_COEF2_L0_B3(0x749),
+			DCIF_CSC_COEF3_L0_C1(0x100) | DCIF_CSC_COEF3_L0_C2(0x1c6),
+			DCIF_CSC_COEF4_L0_C3(0x000) | DCIF_CSC_COEF4_L0_D1(0x000),
+			DCIF_CSC_COEF5_L0_D2(0x180) | DCIF_CSC_COEF5_L0_D3(0x180),
+		},
+	},
+	[DRM_COLOR_YCBCR_BT709] = {
+		[DRM_COLOR_YCBCR_LIMITED_RANGE] = {
+			/*
+			 * Rec.709 limited range:
+			 *
+			 * |R|   |1.1644  0.0000  1.7927|   |Y  - 16 |
+			 * |G| = |1.1644 -0.2132 -0.5329| * |Cb - 128|
+			 * |B|   |1.1644  2.1124  0.0000|   |Cr - 128|
+			 */
+			DCIF_CSC_COEF0_L0_A1(0x12a) | DCIF_CSC_COEF0_L0_A2(0x000),
+			DCIF_CSC_COEF1_L0_A3(0x1cb) | DCIF_CSC_COEF1_L0_B1(0x12a),
+			DCIF_CSC_COEF2_L0_B2(0x7c9) | DCIF_CSC_COEF2_L0_B3(0x778),
+			DCIF_CSC_COEF3_L0_C1(0x12a) | DCIF_CSC_COEF3_L0_C2(0x21d),
+			DCIF_CSC_COEF4_L0_C3(0x000) | DCIF_CSC_COEF4_L0_D1(0x1f0),
+			DCIF_CSC_COEF5_L0_D2(0x180) | DCIF_CSC_COEF5_L0_D3(0x180),
+		},
+		[DRM_COLOR_YCBCR_FULL_RANGE] = {
+			/*
+			 * Rec.709 full range:
+			 *
+			 * |R|   |1.0000  0.0000  1.5748|   |Y  - 0  |
+			 * |G| = |1.0000 -0.1873 -0.4681| * |Cb - 128|
+			 * |B|   |1.0000  1.8556  0.0000|   |Cr - 128|
+			 */
+			DCIF_CSC_COEF0_L0_A1(0x100) | DCIF_CSC_COEF0_L0_A2(0x000),
+			DCIF_CSC_COEF1_L0_A3(0x193) | DCIF_CSC_COEF1_L0_B1(0x100),
+			DCIF_CSC_COEF2_L0_B2(0x7d0) | DCIF_CSC_COEF2_L0_B3(0x788),
+			DCIF_CSC_COEF3_L0_C1(0x100) | DCIF_CSC_COEF3_L0_C2(0x1db),
+			DCIF_CSC_COEF4_L0_C3(0x000) | DCIF_CSC_COEF4_L0_D1(0x000),
+			DCIF_CSC_COEF5_L0_D2(0x180) | DCIF_CSC_COEF5_L0_D3(0x180),
+		},
+	},
+	[DRM_COLOR_YCBCR_BT2020] = {
+		[DRM_COLOR_YCBCR_LIMITED_RANGE] = {
+			/*
+			 * BT.2020 limited range:
+			 *
+			 * |R|   |1.1644  0.0000  1.6787|   |Y  - 16 |
+			 * |G| = |1.1644 -0.1874 -0.6505| * |Cb - 128|
+			 * |B|   |1.1644  2.1418  0.0000|   |Cr - 128|
+			 */
+			DCIF_CSC_COEF0_L0_A1(0x12a) | DCIF_CSC_COEF0_L0_A2(0x000),
+			DCIF_CSC_COEF1_L0_A3(0x1ae) | DCIF_CSC_COEF1_L0_B1(0x12a),
+			DCIF_CSC_COEF2_L0_B2(0x7d0) | DCIF_CSC_COEF2_L0_B3(0x759),
+			DCIF_CSC_COEF3_L0_C1(0x12a) | DCIF_CSC_COEF3_L0_C2(0x224),
+			DCIF_CSC_COEF4_L0_C3(0x000) | DCIF_CSC_COEF4_L0_D1(0x1f0),
+			DCIF_CSC_COEF5_L0_D2(0x180) | DCIF_CSC_COEF5_L0_D3(0x180),
+		},
+		[DRM_COLOR_YCBCR_FULL_RANGE] = {
+			/*
+			 * BT.2020 full range:
+			 *
+			 * |R|   |1.0000  0.0000  1.4746|   |Y  - 0  |
+			 * |G| = |1.0000 -0.1646 -0.5714| * |Cb - 128|
+			 * |B|   |1.0000  1.8814  0.0000|   |Cr - 128|
+			 */
+			DCIF_CSC_COEF0_L0_A1(0x100) | DCIF_CSC_COEF0_L0_A2(0x000),
+			DCIF_CSC_COEF1_L0_A3(0x179) | DCIF_CSC_COEF1_L0_B1(0x100),
+			DCIF_CSC_COEF2_L0_B2(0x7d6) | DCIF_CSC_COEF2_L0_B3(0x76e),
+			DCIF_CSC_COEF3_L0_C1(0x100) | DCIF_CSC_COEF3_L0_C2(0x1e2),
+			DCIF_CSC_COEF4_L0_C3(0x000) | DCIF_CSC_COEF4_L0_D1(0x000),
+			DCIF_CSC_COEF5_L0_D2(0x180) | DCIF_CSC_COEF5_L0_D3(0x180),
+		},
+	},
+};
+
+static enum drm_mode_status dcif_crtc_mode_valid(struct drm_crtc *crtc,
+						 const struct drm_display_mode *mode)
+{
+	const struct drm_mode_config *config = &crtc->dev->mode_config;
+
+	if (mode->clock > DCIF_MAX_PIXEL_CLOCK_KHZ)
+		return MODE_CLOCK_HIGH;
+
+	if (mode->hsync_start - mode->hdisplay > DCIF_MAX_TIMING_VAL ||
+	    mode->hsync_end - mode->hsync_start > DCIF_MAX_TIMING_VAL ||
+	    mode->htotal - mode->hsync_end > DCIF_MAX_TIMING_VAL)
+		return MODE_H_ILLEGAL;
+
+	if (mode->vsync_start - mode->vdisplay > DCIF_MAX_TIMING_VAL ||
+	    mode->vsync_end - mode->vsync_start > DCIF_MAX_TIMING_VAL ||
+	    mode->vtotal - mode->vsync_end > DCIF_MAX_TIMING_VAL)
+		return MODE_V_ILLEGAL;
+
+	return drm_mode_validate_size(mode, config->max_width, config->max_height);
+}
+
+void dcif_set_csc(struct dcif_dev *dcif, const struct drm_plane_state *plane_state)
+{
+	const u32 *coeffs;
+
+	if (!plane_state->fb->format->is_yuv) {
+		regmap_write(dcif->regmap, DCIF_CSC_CTRL_L0, 0);
+		return;
+	}
+
+	/* Enable CSC YCbCr -> RGB */
+	coeffs = dcif_yuv2rgb_coeffs[plane_state->color_encoding][plane_state->color_range];
+	regmap_bulk_write(dcif->regmap, DCIF_CSC_COEF0_L0, coeffs, 6);
+	regmap_write(dcif->regmap, DCIF_CSC_CTRL_L0,
+		     DCIF_CSC_CTRL_L0_CSC_EN | DCIF_CSC_CTRL_L0_CSC_MODE_YCBCR2RGB);
+}
+
+static void dcif_set_bus_format(struct dcif_dev *dcif, const u32 bus_format)
+{
+	struct drm_device *drm = &dcif->drm;
+	u32 reg = 0;
+
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		reg |= DCIF_DPI_CTRL_DATA_PATTERN(PATTERN_RGB565);
+		break;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		reg |= DCIF_DPI_CTRL_DATA_PATTERN(PATTERN_RGB888);
+		break;
+	case MEDIA_BUS_FMT_RBG888_1X24:
+		reg |= DCIF_DPI_CTRL_DATA_PATTERN(PATTERN_RBG888);
+		break;
+	case MEDIA_BUS_FMT_BGR888_1X24:
+		reg |= DCIF_DPI_CTRL_DATA_PATTERN(PATTERN_BGR888);
+		break;
+	case MEDIA_BUS_FMT_GBR888_1X24:
+		reg |= DCIF_DPI_CTRL_DATA_PATTERN(PATTERN_GBR888);
+		break;
+	default:
+		dev_err(drm->dev, "Unknown media bus format 0x%x\n", bus_format);
+		break;
+	}
+
+	regmap_update_bits(dcif->regmap, DCIF_DPI_CTRL, DCIF_DPI_CTRL_DATA_PATTERN_MASK, reg);
+}
+
+static void dcif_set_mode(struct dcif_dev *dcif, const struct drm_display_mode *m,
+			  u32 bus_flags)
+{
+	u32 reg = 0;
+
+	if (m->flags & DRM_MODE_FLAG_NHSYNC)
+		reg |= DCIF_DPI_CTRL_HSYNC_POL_LOW;
+	if (m->flags & DRM_MODE_FLAG_NVSYNC)
+		reg |= DCIF_DPI_CTRL_VSYNC_POL_LOW;
+	if (bus_flags & DRM_BUS_FLAG_DE_LOW)
+		reg |= DCIF_DPI_CTRL_DE_POL_LOW;
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
+		reg |= DCIF_DPI_CTRL_PCLK_EDGE_FALLING;
+
+	regmap_update_bits(dcif->regmap, DCIF_DPI_CTRL, DCIF_DPI_CTRL_POL_MASK, reg);
+
+	/* config display timings */
+	reg = DCIF_DISP_SIZE_DISP_WIDTH(m->hdisplay) |
+	      DCIF_DISP_SIZE_DISP_HEIGHT(m->vdisplay);
+	regmap_write(dcif->regmap, DCIF_DISP_SIZE, reg);
+
+	reg = DCIF_DPI_HSYN_PAR_BP_H(m->htotal - m->hsync_end) |
+	      DCIF_DPI_HSYN_PAR_FP_H(m->hsync_start - m->hdisplay);
+	regmap_write(dcif->regmap, DCIF_DPI_HSYN_PAR, reg);
+
+	reg = DCIF_DPI_VSYN_PAR_BP_V(m->vtotal - m->vsync_end) |
+	      DCIF_DPI_VSYN_PAR_FP_V(m->vsync_start - m->vdisplay);
+	regmap_write(dcif->regmap, DCIF_DPI_VSYN_PAR, reg);
+
+	reg = DCIF_DPI_VSYN_HSYN_WIDTH_PW_V(m->vsync_end - m->vsync_start) |
+	      DCIF_DPI_VSYN_HSYN_WIDTH_PW_H(m->hsync_end - m->hsync_start);
+	regmap_write(dcif->regmap, DCIF_DPI_VSYN_HSYN_WIDTH, reg);
+}
+
+static void dcif_enable_plane_panic(struct dcif_dev *dcif)
+{
+	u32 reg;
+
+	/* Set FIFO Panic watermarks, low 1/3, high 2/3. */
+	reg = DCIF_PANIC_THRES_LOW(1 * PANIC0_THRES_MAX / 3) |
+	      DCIF_PANIC_THRES_HIGH(2 * PANIC0_THRES_MAX / 3) |
+	      DCIF_PANIC_THRES_REQ_EN;
+	regmap_write(dcif->regmap, DCIF_PANIC_THRES(0), reg);
+	regmap_write(dcif->regmap, DCIF_PANIC_THRES(1), reg);
+
+	regmap_set_bits(dcif->regmap, DCIF_IE1(dcif->cpu_domain),
+			DCIF_INT1_FIFO_PANIC0 | DCIF_INT1_FIFO_PANIC1);
+}
+
+static void dcif_disable_plane_panic(struct dcif_dev *dcif)
+{
+	regmap_clear_bits(dcif->regmap, DCIF_IE1(dcif->cpu_domain),
+			  DCIF_INT1_FIFO_PANIC0 | DCIF_INT1_FIFO_PANIC1);
+	regmap_clear_bits(dcif->regmap, DCIF_PANIC_THRES(0), DCIF_PANIC_THRES_REQ_EN);
+	regmap_clear_bits(dcif->regmap, DCIF_PANIC_THRES(1), DCIF_PANIC_THRES_REQ_EN);
+}
+
+static void dcif_enable_controller(struct dcif_dev *dcif)
+{
+	/* Enable Display; the layers are enabled by the plane update. */
+	regmap_set_bits(dcif->regmap, DCIF_DISP_CTRL, DCIF_DISP_CTRL_DISP_ON);
+}
+
+void dcif_disable_controller(struct dcif_dev *dcif)
+{
+	u32 reg;
+	int ret;
+	int i;
+
+	dcif_plane_disable_layer(dcif, 1);
+	dcif_plane_disable_layer(dcif, 0);
+
+	for (i = 0; i < 2; i++) {
+		ret = regmap_read_poll_timeout(dcif->regmap, DCIF_CTRLDESC0(i), reg,
+					       !(reg & DCIF_CTRLDESC0_SHADOW_LOAD_EN),
+					       1000, 42000); /* Wait ~2 frame times max */
+		if (ret)
+			drm_err(&dcif->drm, "Failed to disable layer %d!\n", i);
+	}
+
+	/* Disable Display */
+	regmap_clear_bits(dcif->regmap, DCIF_DISP_CTRL, DCIF_DISP_CTRL_DISP_ON);
+
+	ret = regmap_read_poll_timeout(dcif->regmap, DCIF_DISP_SR0, reg,
+				       !(reg & DCIF_DISP_SR0_DPI_BUSY),
+				       1000, 42000); /* Wait ~2 frame times max */
+	if (ret)
+		drm_err(&dcif->drm, "Timeout waiting for DPI to go idle!\n");
+}
+
+static void dcif_shadow_load_enable(struct dcif_dev *dcif)
+{
+	regmap_write_bits(dcif->regmap, DCIF_CTRLDESC0(0), DCIF_CTRLDESC0_SHADOW_LOAD_EN,
+			  DCIF_CTRLDESC0_SHADOW_LOAD_EN);
+}
+
+static void dcif_reset_block(struct dcif_dev *dcif)
+{
+	u32 reg;
+	int ret;
+
+	/* Hold pixel fetches and let pending AXI reads finish before resetting. */
+	regmap_set_bits(dcif->regmap, DCIF_DISP_CTRL, DCIF_DISP_CTRL_AXI_RD_HOLD);
+
+	ret = regmap_read_poll_timeout(dcif->regmap, DCIF_DISP_SR0, reg,
+				       !(reg & DCIF_DISP_SR0_AXI_RD_BUSY),
+				       10, 1000);
+	if (ret)
+		drm_err(&dcif->drm, "Timeout waiting for AXI reads to finish!\n");
+
+	regmap_set_bits(dcif->regmap, DCIF_DISP_CTRL, DCIF_DISP_CTRL_SW_RST);
+
+	regmap_clear_bits(dcif->regmap, DCIF_DISP_CTRL, DCIF_DISP_CTRL_SW_RST);
+
+	regmap_clear_bits(dcif->regmap, DCIF_DISP_CTRL, DCIF_DISP_CTRL_AXI_RD_HOLD);
+}
+
+static void dcif_crtc_atomic_destroy_state(struct drm_crtc *crtc,
+					   struct drm_crtc_state *state)
+{
+	__drm_atomic_helper_crtc_destroy_state(state);
+	kfree(to_dcif_crtc_state(state));
+}
+
+static struct drm_crtc_state *dcif_crtc_atomic_create_state(struct drm_crtc *crtc)
+{
+	struct dcif_crtc_state *state;
+
+	state = kzalloc_obj(*state, GFP_KERNEL);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
+
+	return &state->base;
+}
+
+static struct drm_crtc_state *dcif_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
+{
+	struct dcif_crtc_state *old = to_dcif_crtc_state(crtc->state);
+	struct dcif_crtc_state *new;
+
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
+	new = kzalloc_obj(*new, GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &new->base);
+
+	new->bus_format = old->bus_format;
+	new->bus_flags = old->bus_flags;
+	new->crc.source = old->crc.source;
+	dcif_copy_roi(&old->crc.roi, &new->crc.roi);
+
+	return &new->base;
+}
+
+static void dcif_crtc_mode_set_nofb(struct drm_crtc_state *crtc_state)
+{
+	struct dcif_crtc_state *dcif_crtc_state = to_dcif_crtc_state(crtc_state);
+	struct drm_device *drm = crtc_state->crtc->dev;
+	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc_state->crtc);
+	struct drm_display_mode *m = &crtc_state->adjusted_mode;
+
+	dev_dbg(drm->dev, "Pixel clock: %dkHz\n", m->crtc_clock);
+	dev_dbg(drm->dev, "Bridge bus_flags: 0x%08X\n", dcif_crtc_state->bus_flags);
+	dev_dbg(drm->dev, "Mode flags: 0x%08X\n", m->flags);
+
+	dcif_reset_block(dcif);
+
+	dcif_set_bus_format(dcif, dcif_crtc_state->bus_format);
+
+	dcif_set_mode(dcif, m, dcif_crtc_state->bus_flags);
+}
+
+static void dcif_crtc_queue_state_event(struct drm_crtc *crtc)
+{
+	struct drm_pending_vblank_event *event;
+
+	scoped_guard(spinlock_irq, &crtc->dev->event_lock) {
+		event = crtc->state->event;
+		if (!event)
+			return;
+
+		crtc->state->event = NULL;
+
+		if (drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+	}
+}
+
+static struct drm_bridge *dcif_crtc_get_bridge(struct drm_crtc *crtc,
+					       struct drm_crtc_state *crtc_state)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_encoder *encoder;
+	struct drm_connector *conn;
+	struct drm_bridge *bridge;
+	int i;
+
+	for_each_new_connector_in_state(crtc_state->state, conn, conn_state, i) {
+		if (crtc != conn_state->crtc)
+			continue;
+
+		encoder = conn_state->best_encoder;
+
+		bridge = drm_bridge_chain_get_first_bridge(encoder);
+		if (bridge)
+			return bridge;
+	}
+
+	return NULL;
+}
+
+static bool dcif_bus_format_supported(u32 bus_format)
+{
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_RGB565_1X16:
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RBG888_1X24:
+	case MEDIA_BUS_FMT_BGR888_1X24:
+	case MEDIA_BUS_FMT_GBR888_1X24:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int dcif_crtc_query_output_bus_format(struct drm_crtc *crtc,
+					     struct drm_crtc_state *crtc_state)
+{
+	struct dcif_crtc_state *dcif_state = to_dcif_crtc_state(crtc_state);
+	struct drm_bridge *bridge __free(drm_bridge_put) = NULL;
+	struct drm_bridge_state *bridge_state;
+	u32 bus_format;
+
+	dcif_state->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	dcif_state->bus_flags = 0;
+
+	bridge = dcif_crtc_get_bridge(crtc, crtc_state);
+	if (!bridge)
+		return 0;
+
+	bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state, bridge);
+	if (!bridge_state)
+		return 0;
+
+	/* Bridges not negotiating a bus format leave it unspecified: keep RGB888. */
+	bus_format = bridge_state->input_bus_cfg.format;
+	if (bus_format && bus_format != MEDIA_BUS_FMT_FIXED) {
+		if (!dcif_bus_format_supported(bus_format))
+			return -EINVAL;
+
+		dcif_state->bus_format = bus_format;
+	}
+	dcif_state->bus_flags = bridge_state->input_bus_cfg.flags;
+
+	return 0;
+}
+
+static void dcif_crtc_get_crc_roi(struct drm_crtc_state *crtc_state, struct drm_rect *roi)
+{
+	struct dcif_crtc_state *dcif_state = to_dcif_crtc_state(crtc_state);
+	struct drm_display_mode *m = &crtc_state->adjusted_mode;
+
+	if (dcif_state->crc.source == DCIF_CRC_SRC_FRAME)
+		drm_rect_init(roi, 0, 0, m->hdisplay, m->vdisplay);
+	else
+		dcif_copy_roi(&dcif_state->crc.roi, roi);
+}
+
+static int dcif_crtc_check_crc_roi(struct drm_crtc_state *crtc_state)
+{
+	struct dcif_crtc_state *dcif_state = to_dcif_crtc_state(crtc_state);
+	struct drm_display_mode *m = &crtc_state->adjusted_mode;
+	struct drm_rect *roi = &dcif_state->crc.roi;
+
+	if (!crtc_state->enable || dcif_state->crc.source != DCIF_CRC_SRC_FRAME_ROI)
+		return 0;
+
+	if (roi->x1 < 0 || roi->y1 < 0 || roi->x2 > m->hdisplay || roi->y2 > m->vdisplay)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dcif_crtc_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	bool enable_primary = crtc_state->plane_mask & drm_plane_mask(crtc->primary);
+	int ret;
+
+	if (crtc_state->active && !enable_primary)
+		return -EINVAL;
+
+	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
+		ret = dcif_crtc_query_output_bus_format(crtc, crtc_state);
+		if (ret)
+			return ret;
+	}
+
+	return dcif_crtc_check_crc_roi(crtc_state);
+}
+
+static void dcif_crtc_atomic_flush(struct drm_crtc *crtc,
+				   struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
+	struct dcif_crtc_state *old_dcif_crtc_state = to_dcif_crtc_state(old_crtc_state);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct dcif_crtc_state *dcif_crtc_state = to_dcif_crtc_state(crtc_state);
+	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
+
+	dcif_shadow_load_enable(dcif);
+
+	dcif_crtc_queue_state_event(crtc);
+
+	if (drm_atomic_crtc_needs_modeset(crtc_state))
+		return;
+
+	if (dcif->has_crc &&
+	    (disable_dcif_crc_needed(dcif_crtc_state, old_dcif_crtc_state) ||
+	     update_dcif_crc_needed(dcif_crtc_state, old_dcif_crtc_state)))
+		dcif_crc_source_disable(dcif, 0);
+
+	if (dcif->has_crc &&
+	    (enable_dcif_crc_needed(dcif_crtc_state, old_dcif_crtc_state) ||
+	     update_dcif_crc_needed(dcif_crtc_state, old_dcif_crtc_state))) {
+		struct drm_rect roi;
+
+		dcif_crtc_get_crc_roi(crtc_state, &roi);
+		dcif_crc_source_enable(dcif, dcif_crtc_state->crc.source, &roi, 0);
+	}
+}
+
+static void dcif_crtc_atomic_enable(struct drm_crtc *crtc,
+				    struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct dcif_crtc_state *dcif_crtc_state = to_dcif_crtc_state(crtc_state);
+	struct drm_display_mode *adj = &crtc_state->adjusted_mode;
+	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
+	struct drm_device *drm = crtc->dev;
+	int ret;
+
+	dev_dbg(drm->dev, "mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(adj));
+
+	/* enable power when we start to set mode for CRTC */
+	ret = pm_runtime_resume_and_get(drm->dev);
+	if (ret < 0) {
+		drm_err(drm, "failed to resume DCIF, ret = %d\n", ret);
+		return;
+	}
+	dcif->crtc_pm_enabled = true;
+
+	dcif_crtc_mode_set_nofb(crtc_state);
+
+	drm_crtc_vblank_on(crtc);
+
+	dcif_enable_plane_panic(dcif);
+	dcif_enable_controller(dcif);
+
+	if (dcif->has_crc && dcif_crtc_state->crc.source != DCIF_CRC_SRC_NONE) {
+		struct drm_rect roi;
+
+		dcif_crtc_get_crc_roi(crtc_state, &roi);
+		dcif_crc_source_enable(dcif, dcif_crtc_state->crc.source, &roi, 0);
+	}
+}
+
+static void dcif_crtc_atomic_disable(struct drm_crtc *crtc,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct dcif_crtc_state *dcif_crtc_state = to_dcif_crtc_state(crtc_state);
+	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
+	struct drm_device *drm = crtc->dev;
+
+	if (dcif->has_crc && dcif_crtc_state->crc.source != DCIF_CRC_SRC_NONE)
+		dcif_crc_source_disable(dcif, 0);
+
+	dcif_disable_controller(dcif);
+	dcif_disable_plane_panic(dcif);
+
+	drm_crtc_vblank_off(crtc);
+
+	if (dcif->crtc_pm_enabled) {
+		dcif->crtc_pm_enabled = false;
+		pm_runtime_put_sync(drm->dev);
+	}
+
+	scoped_guard(spinlock_irq, &crtc->dev->event_lock) {
+		if (crtc->state->event && !crtc->state->active) {
+			drm_crtc_send_vblank_event(crtc, crtc->state->event);
+			crtc->state->event = NULL;
+		}
+	}
+}
+
+static const struct drm_crtc_helper_funcs dcif_crtc_helper_funcs = {
+	.mode_valid	= dcif_crtc_mode_valid,
+	.atomic_check	= dcif_crtc_atomic_check,
+	.atomic_flush	= dcif_crtc_atomic_flush,
+	.atomic_enable	= dcif_crtc_atomic_enable,
+	.atomic_disable	= dcif_crtc_atomic_disable,
+};
+
+static int dcif_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
+	int domain = dcif->cpu_domain;
+
+	regmap_write(dcif->regmap, DCIF_IS0(domain), DCIF_INT0_VS_BLANK);
+	regmap_set_bits(dcif->regmap, DCIF_IE0(domain), DCIF_INT0_VS_BLANK);
+
+	return 0;
+}
+
+static void dcif_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
+	int domain = dcif->cpu_domain;
+
+	/* Disable and clear VS_BLANK IRQ */
+	regmap_clear_bits(dcif->regmap, DCIF_IE0(domain), DCIF_INT0_VS_BLANK);
+	regmap_write(dcif->regmap, DCIF_IS0(domain), DCIF_INT0_VS_BLANK);
+}
+
+static const struct drm_crtc_funcs dcif_crtc_funcs = {
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_create_state	= dcif_crtc_atomic_create_state,
+	.atomic_duplicate_state	= dcif_crtc_atomic_duplicate_state,
+	.atomic_destroy_state	= dcif_crtc_atomic_destroy_state,
+	.enable_vblank		= dcif_crtc_enable_vblank,
+	.disable_vblank		= dcif_crtc_disable_vblank,
+	.set_crc_source		= dcif_crc_source_set,
+	.verify_crc_source	= dcif_crc_source_verify,
+};
+
+irqreturn_t dcif_irq_handler(int irq, void *data)
+{
+	struct drm_device *drm = data;
+	struct dcif_dev *dcif = to_dcif_dev(drm);
+	int domain = dcif->cpu_domain;
+	u32 stat0, stat1, crc;
+
+	regmap_read(dcif->regmap, DCIF_IS0(domain), &stat0);
+	regmap_read(dcif->regmap, DCIF_IS1(domain), &stat1);
+	regmap_write(dcif->regmap, DCIF_IS0(domain), stat0);
+	regmap_write(dcif->regmap, DCIF_IS1(domain), stat1);
+
+	if (stat0 & DCIF_INT0_VS_BLANK) {
+		drm_crtc_handle_vblank(&dcif->crtc);
+
+		scoped_guard(spinlock_irqsave, &drm->event_lock) {
+			if (dcif->crc_is_enabled) {
+				regmap_read(dcif->regmap, DCIF_CRC_VAL_R(0), &crc);
+				drm_crtc_add_crc_entry(&dcif->crtc, false, 0, &crc);
+				dev_dbg(drm->dev, "crc=0x%x\n",  crc);
+			}
+		}
+	}
+
+	if (stat1 & (DCIF_INT1_FIFO_PANIC0 | DCIF_INT1_FIFO_PANIC1)) {
+		u32 panic = stat1 & (DCIF_INT1_FIFO_PANIC0 | DCIF_INT1_FIFO_PANIC1);
+
+		dev_dbg_ratelimited(drm->dev, "FIFO panic on %s\n",
+				    panic == (DCIF_INT1_FIFO_PANIC0 | DCIF_INT1_FIFO_PANIC1) ?
+				    "layers 0 & 1" : panic == DCIF_INT1_FIFO_PANIC0 ? "layer 0" :
+				    "layer 1");
+	}
+
+	return IRQ_HANDLED;
+}
+
+int dcif_crtc_init(struct dcif_dev *dcif)
+{
+	int ret;
+
+	ret = dcif_plane_init(dcif);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&dcif->crtc, &dcif_crtc_helper_funcs);
+	ret = drm_crtc_init_with_planes(&dcif->drm, &dcif->crtc, &dcif->planes.primary, NULL,
+					&dcif_crtc_funcs, NULL);
+	if (ret) {
+		drm_err(&dcif->drm, "failed to initialize CRTC: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/imx/dcif/dcif-drv.c b/drivers/gpu/drm/imx/dcif/dcif-drv.c
new file mode 100644
index 0000000000000..3b1b9dbf0c6b0
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/dcif-drv.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fbdev_dma.h>
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_print.h>
+
+#include "dcif-drv.h"
+#include "dcif-reg.h"
+
+#define DCIF_CPU_DOMAIN			0
+
+DEFINE_DRM_GEM_DMA_FOPS(dcif_driver_fops);
+
+static struct drm_driver dcif_driver = {
+	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+	DRM_GEM_DMA_DRIVER_OPS,
+	DRM_FBDEV_DMA_DRIVER_OPS,
+	.fops			= &dcif_driver_fops,
+	.name			= "imx-dcif",
+	.desc			= "i.MX DCIF DRM graphics",
+	.major			= 1,
+	.minor			= 0,
+	.patchlevel		= 0,
+};
+
+static void dcif_hw_probe_init(struct dcif_dev *dcif)
+{
+	struct drm_device *drm = &dcif->drm;
+	u32 val, vmin, vmaj;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(drm->dev);
+	if (ret < 0) {
+		drm_err(drm, "failed to resume DCIF: %d\n", ret);
+		return;
+	}
+
+	regmap_read(dcif->regmap, DCIF_VER, &val);
+
+	dcif->has_crc = val & DCIF_FEATURE_CRC;
+
+	vmin = DCIF_VER_GET_MINOR(val);
+	vmaj = DCIF_VER_GET_MAJOR(val);
+	DRM_DEV_DEBUG(drm->dev, "DCIF version is %d.%d\n", vmaj, vmin);
+
+	/* Mask and ack any interrupts left enabled by the bootloader */
+	regmap_write(dcif->regmap, DCIF_IE0(dcif->cpu_domain), 0);
+	regmap_write(dcif->regmap, DCIF_IE1(dcif->cpu_domain), 0);
+	regmap_write(dcif->regmap, DCIF_IS0(dcif->cpu_domain), 0xffffffff);
+	regmap_write(dcif->regmap, DCIF_IS1(dcif->cpu_domain), 0xffffffff);
+
+	/* Stop the controller if the bootloader left it running */
+	regmap_read(dcif->regmap, DCIF_DISP_CTRL, &val);
+	if (val & DCIF_DISP_CTRL_DISP_ON)
+		dcif_disable_controller(dcif);
+
+	pm_runtime_put_sync(drm->dev);
+}
+
+static const struct regmap_config dcif_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+	.max_register = 0x20250,
+	.cache_type = REGCACHE_NONE,
+	.disable_locking = true,
+};
+
+static int dcif_probe(struct platform_device *pdev)
+{
+	struct dcif_dev *dcif;
+	struct drm_device *drm;
+	int ret;
+	int i;
+
+	dcif = devm_drm_dev_alloc(&pdev->dev, &dcif_driver, struct dcif_dev, drm);
+	if (IS_ERR(dcif))
+		return PTR_ERR(dcif);
+
+	/* CPU 0 domain for interrupt control */
+	dcif->cpu_domain = DCIF_CPU_DOMAIN;
+
+	drm = &dcif->drm;
+	dev_set_drvdata(&pdev->dev, dcif);
+
+	dcif->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dcif->reg_base))
+		return dev_err_probe(drm->dev, PTR_ERR(dcif->reg_base),
+				     "failed to get reg base\n");
+
+	for (i = 0; i < 3; i++) {
+		dcif->irq[i] = platform_get_irq(pdev, i);
+		if (dcif->irq[i] < 0)
+			return dev_err_probe(drm->dev, dcif->irq[i],
+					     "failed to get domain%d irq\n", i);
+	}
+
+	dcif->regmap = devm_regmap_init_mmio(drm->dev, dcif->reg_base, &dcif_regmap_config);
+	if (IS_ERR(dcif->regmap))
+		return dev_err_probe(drm->dev, PTR_ERR(dcif->regmap),
+				     "failed to init DCIF regmap\n");
+
+	dcif->num_clks = devm_clk_bulk_get_all(drm->dev, &dcif->clks);
+	if (dcif->num_clks < 0)
+		return dev_err_probe(drm->dev, dcif->num_clks,
+				     "cannot get required clocks\n");
+	if (!dcif->num_clks)
+		return dev_err_probe(drm->dev, -ENODEV, "no clocks found\n");
+
+	ret = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(drm->dev, ret, "failed to set DMA mask\n");
+
+	ret = devm_pm_runtime_enable(drm->dev);
+	if (ret)
+		return dev_err_probe(drm->dev, ret, "failed to enable runtime PM\n");
+
+	dcif_hw_probe_init(dcif);
+
+	ret = dcif_kms_prepare(dcif);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(drm->dev, dcif->irq[dcif->cpu_domain],
+			       dcif_irq_handler, 0, drm->driver->name, drm);
+	if (ret < 0)
+		return dev_err_probe(drm->dev, ret, "failed to install IRQ handler\n");
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		return dev_err_probe(drm->dev, ret, "failed to register drm device\n");
+
+	drm_client_setup(drm, NULL);
+
+	return 0;
+}
+
+static void dcif_remove(struct platform_device *pdev)
+{
+	struct dcif_dev *dcif = dev_get_drvdata(&pdev->dev);
+	struct drm_device *drm = &dcif->drm;
+
+	drm_dev_unregister(drm);
+
+	drm_atomic_helper_shutdown(drm);
+}
+
+static void dcif_shutdown(struct platform_device *pdev)
+{
+	struct dcif_dev *dcif = dev_get_drvdata(&pdev->dev);
+	struct drm_device *drm = &dcif->drm;
+
+	drm_atomic_helper_shutdown(drm);
+}
+
+static int dcif_runtime_suspend(struct device *dev)
+{
+	struct dcif_dev *dcif = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(dcif->num_clks, dcif->clks);
+
+	return 0;
+}
+
+static int dcif_runtime_resume(struct device *dev)
+{
+	struct dcif_dev *dcif = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(dcif->num_clks, dcif->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dcif_suspend(struct device *dev)
+{
+	struct dcif_dev *dcif = dev_get_drvdata(dev);
+	int ret;
+
+	ret = drm_mode_config_helper_suspend(&dcif->drm);
+	if (ret < 0)
+		return ret;
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return dcif_runtime_suspend(dev);
+}
+
+static int dcif_resume(struct device *dev)
+{
+	struct dcif_dev *dcif = dev_get_drvdata(dev);
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		ret = dcif_runtime_resume(dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return drm_mode_config_helper_resume(&dcif->drm);
+}
+
+static const struct dev_pm_ops dcif_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(dcif_suspend, dcif_resume)
+	RUNTIME_PM_OPS(dcif_runtime_suspend, dcif_runtime_resume, NULL)
+};
+
+static const struct of_device_id dcif_dt_ids[] = {
+	{ .compatible = "nxp,imx94-dcif" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dcif_dt_ids);
+
+static struct platform_driver dcif_platform_driver = {
+	.probe = dcif_probe,
+	.remove = dcif_remove,
+	.shutdown = dcif_shutdown,
+	.driver = {
+		.name = "imx-dcif-drm",
+		.of_match_table = dcif_dt_ids,
+		.pm = pm_ptr(&dcif_pm_ops),
+	},
+};
+module_platform_driver(dcif_platform_driver);
+
+MODULE_AUTHOR("NXP Semiconductor");
+MODULE_DESCRIPTION("i.MX94 DCIF DRM driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/imx/dcif/dcif-drv.h b/drivers/gpu/drm/imx/dcif/dcif-drv.h
new file mode 100644
index 0000000000000..f3fa9564f4af7
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/dcif-drv.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DCIF_DRV_H__
+#define __DCIF_DRV_H__
+
+#include <linux/clk.h>
+#include <linux/irqreturn.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_vblank.h>
+
+#define DCIF_CPU_DOMAINS	3
+
+struct dcif_dev {
+	struct drm_device drm;
+	void __iomem *reg_base;
+
+	struct regmap *regmap;
+	int irq[DCIF_CPU_DOMAINS];
+
+	int num_clks;
+	struct clk_bulk_data *clks;
+
+	struct drm_crtc crtc;
+	struct {
+		struct drm_plane primary;
+		struct drm_plane overlay;
+	} planes;
+	struct drm_encoder encoder;
+
+	/* Implement crc */
+	bool has_crc;
+	bool crc_is_enabled;
+
+	/* Tracks whether atomic_enable obtained a PM runtime reference */
+	bool crtc_pm_enabled;
+
+	/* CPU domain for interrupt control */
+	int cpu_domain;
+};
+
+enum dcif_crc_source {
+	DCIF_CRC_SRC_NONE,
+	DCIF_CRC_SRC_FRAME,
+	DCIF_CRC_SRC_FRAME_ROI,
+};
+
+struct dcif_crc {
+	enum dcif_crc_source	source;
+	struct drm_rect		roi;
+};
+
+struct dcif_crtc_state {
+	struct drm_crtc_state	base;
+	struct dcif_crc		crc;
+	u32			bus_format;
+	u32			bus_flags;
+};
+
+static inline struct dcif_dev *to_dcif_dev(struct drm_device *drm_dev)
+{
+	return container_of(drm_dev, struct dcif_dev, drm);
+}
+
+static inline struct dcif_dev *crtc_to_dcif_dev(struct drm_crtc *crtc)
+{
+	return to_dcif_dev(crtc->dev);
+}
+
+static inline struct dcif_crtc_state *to_dcif_crtc_state(struct drm_crtc_state *s)
+{
+	return container_of(s, struct dcif_crtc_state, base);
+}
+
+irqreturn_t dcif_irq_handler(int irq, void *data);
+int dcif_crtc_init(struct dcif_dev *dcif);
+int dcif_plane_init(struct dcif_dev *dcif);
+void dcif_plane_disable_layer(struct dcif_dev *dcif, int layer_id);
+void dcif_disable_controller(struct dcif_dev *dcif);
+int dcif_kms_prepare(struct dcif_dev *dcif);
+void dcif_set_csc(struct dcif_dev *dcif, const struct drm_plane_state *plane_state);
+
+#endif
diff --git a/drivers/gpu/drm/imx/dcif/dcif-kms.c b/drivers/gpu/drm/imx/dcif/dcif-kms.c
new file mode 100644
index 0000000000000..a960c5711c1bc
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/dcif-kms.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+
+#include "dcif-drv.h"
+
+static const struct drm_encoder_funcs dcif_kms_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static int dcif_kms_link_supplier(struct dcif_dev *dcif, struct device_node *np)
+{
+	struct device *dev = dcif->drm.dev;
+	struct platform_device *pdev;
+	struct device_link *link;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return 0;
+
+	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	put_device(&pdev->dev);
+	if (!link)
+		return dev_err_probe(dev, -EINVAL, "failed to create device link to %pOF\n", np);
+
+	return 0;
+}
+
+/*
+ * Enforce suspend/resume ordering by making the display CSR (pixel clock mux)
+ * and the LDB (a child of the LVDS CSR) providers of the DCIF: they are
+ * suspended after and resumed before the DCIF.
+ */
+static int dcif_kms_link_suppliers(struct dcif_dev *dcif, struct drm_bridge *bridge)
+{
+	struct device_node *np = dcif->drm.dev->of_node;
+	struct of_phandle_args args;
+	int idx, ret;
+
+	idx = of_property_match_string(np, "clock-names", "pix");
+	if (idx >= 0) {
+		ret = of_parse_phandle_with_args(np, "clocks", "#clock-cells", idx, &args);
+		if (ret)
+			return ret;
+
+		ret = dcif_kms_link_supplier(dcif, args.np);
+		of_node_put(args.np);
+		if (ret)
+			return ret;
+	}
+
+	return dcif_kms_link_supplier(dcif, bridge->of_node);
+}
+
+static int dcif_kms_init(struct dcif_dev *dcif)
+{
+	struct drm_device *drm = &dcif->drm;
+	struct device_node *np = drm->dev->of_node;
+	struct drm_connector *connector;
+	struct drm_bridge *bridge;
+	int ret;
+
+	ret = dcif_crtc_init(dcif);
+	if (ret)
+		return ret;
+
+	bridge = devm_drm_of_get_bridge(drm->dev, np, 0, 0);
+	if (IS_ERR(bridge))
+		return dev_err_probe(drm->dev, PTR_ERR(bridge), "Failed to find bridge\n");
+
+	ret = dcif_kms_link_suppliers(dcif, bridge);
+	if (ret)
+		return ret;
+
+	dcif->encoder.possible_crtcs = drm_crtc_mask(&dcif->crtc);
+	ret = drm_encoder_init(drm, &dcif->encoder, &dcif_kms_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret) {
+		drm_err(drm, "failed to initialize encoder: %d\n", ret);
+		return ret;
+	}
+
+	ret = drm_bridge_attach(&dcif->encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		drm_err(drm, "failed to attach bridge to encoder: %d\n", ret);
+		return ret;
+	}
+
+	connector = drm_bridge_connector_init(drm, &dcif->encoder);
+	if (IS_ERR(connector)) {
+		drm_err(drm, "failed to initialize bridge connector: %ld\n", PTR_ERR(connector));
+		return PTR_ERR(connector);
+	}
+
+	return 0;
+}
+
+static int dcif_atomic_check(struct drm_device *drm, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i)
+		if (!old_crtc_state->active && new_crtc_state->active)
+			new_crtc_state->mode_changed = true;
+
+	return drm_atomic_helper_check(drm, state);
+}
+
+static const struct drm_mode_config_funcs dcif_mode_config_funcs = {
+	.fb_create     = drm_gem_fb_create,
+	.atomic_check  = dcif_atomic_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static const struct drm_mode_config_helper_funcs dcif_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
+int dcif_kms_prepare(struct dcif_dev *dcif)
+{
+	struct drm_device *drm = &dcif->drm;
+	int ret;
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	ret = dcif_kms_init(dcif);
+	if (ret)
+		return ret;
+
+	drm->mode_config.min_width	= 1;
+	drm->mode_config.min_height	= 1;
+	drm->mode_config.max_width	= 1920;
+	drm->mode_config.max_height	= 1920;
+	drm->mode_config.funcs		= &dcif_mode_config_funcs;
+	drm->mode_config.helper_private	= &dcif_mode_config_helpers;
+
+	ret = drm_vblank_init(drm, 1);
+	if (ret < 0) {
+		drm_err(drm, "failed to initialize vblank: %d\n", ret);
+		return ret;
+	}
+
+	drm_mode_config_reset(drm);
+
+	drmm_kms_helper_poll_init(drm);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/imx/dcif/dcif-plane.c b/drivers/gpu/drm/imx/dcif/dcif-plane.c
new file mode 100644
index 0000000000000..9f54f1b2d8d17
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/dcif-plane.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/regmap.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
+#include <drm/drm_fb_dma_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_print.h>
+#include <drm/drm_rect.h>
+
+#include "dcif-drv.h"
+#include "dcif-reg.h"
+
+static const u32 dcif_primary_plane_formats[] = {
+	/* RGB */
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_XRGB4444,
+	DRM_FORMAT_XRGB8888,
+
+	/* Packed YCbCr */
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
+};
+
+static const u32 dcif_overlay_plane_formats[] = {
+	/* RGB */
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_XRGB4444,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+};
+
+static inline struct dcif_dev *plane_to_dcif_dev(struct drm_plane *plane)
+{
+	return to_dcif_dev(plane->dev);
+}
+
+static inline dma_addr_t drm_plane_state_to_baseaddr(struct drm_plane_state *state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_gem_dma_object *dma_obj;
+	unsigned int x = state->src.x1 >> 16;
+	unsigned int y = state->src.y1 >> 16;
+
+	dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
+	if (!dma_obj)
+		return 0;
+
+	return dma_obj->dma_addr + fb->offsets[0] + fb->pitches[0] * y + fb->format->cpp[0] * x;
+}
+
+static int dcif_plane_get_layer_id(struct drm_plane *plane)
+{
+	return (plane->type == DRM_PLANE_TYPE_PRIMARY) ? 0 : 1;
+}
+
+void dcif_plane_disable_layer(struct dcif_dev *dcif, int layer_id)
+{
+	regmap_update_bits(dcif->regmap, DCIF_CTRLDESC0(layer_id),
+			   DCIF_CTRLDESC0_EN | DCIF_CTRLDESC0_SHADOW_LOAD_EN,
+			   DCIF_CTRLDESC0_SHADOW_LOAD_EN);
+}
+
+static int dcif_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct dcif_dev *dcif = plane_to_dcif_dev(plane);
+	struct drm_framebuffer *fb = new_plane_state->fb;
+	struct drm_crtc_state *crtc_state;
+	int ret;
+
+	if (!fb)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, &dcif->crtc);
+	if (WARN_ON(!crtc_state))
+		return -EINVAL;
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  true,
+						  true);
+	if (ret)
+		return ret;
+
+	if (new_plane_state->fb->format->has_alpha &&
+	    new_plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE &&
+	    new_plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void dcif_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
+	struct dcif_dev *dcif = plane_to_dcif_dev(plane);
+	int layer_id = dcif_plane_get_layer_id(plane);
+	struct drm_framebuffer *fb = new_state->fb;
+	u32 crtc_x, crtc_y, crtc_h, crtc_w;
+	u32 layer_fmt = 0, yuv_fmt = 0;
+	dma_addr_t baseaddr;
+	u32 reg;
+
+	if (!fb)
+		return;
+
+	if (!new_state->visible) {
+		dcif_plane_disable_layer(dcif, layer_id);
+		return;
+	}
+
+	crtc_x = new_state->dst.x1;
+	crtc_y = new_state->dst.y1;
+	crtc_w = drm_rect_width(&new_state->dst);
+	crtc_h = drm_rect_height(&new_state->dst);
+
+	/* visible portion of plane on crtc */
+	regmap_write(dcif->regmap, DCIF_CTRLDESC1(layer_id),
+		     DCIF_CTRLDESC1_POSX(crtc_x) | DCIF_CTRLDESC1_POSY(crtc_y));
+	regmap_write(dcif->regmap, DCIF_CTRLDESC2(layer_id),
+		     DCIF_CTRLDESC2_WIDTH(crtc_w) | DCIF_CTRLDESC2_HEIGHT(crtc_h));
+
+	/* pitch size */
+	reg = DCIF_CTRLDESC3_P_SIZE(2) | DCIF_CTRLDESC3_T_SIZE(2) |
+	      DCIF_CTRLDESC3_PITCH(fb->pitches[0]);
+	regmap_write(dcif->regmap, DCIF_CTRLDESC3(layer_id), reg);
+
+	/*  address */
+	baseaddr = drm_plane_state_to_baseaddr(new_state);
+
+	drm_dbg_kms(plane->dev, "[PLANE:%d:%s] fb address %pad, pitch 0x%08x\n",
+		    plane->base.id, plane->name, &baseaddr, fb->pitches[0]);
+
+	regmap_write(dcif->regmap, DCIF_CTRLDESC4(layer_id), baseaddr);
+
+	/* Only layer 0 has a CSC; it is shadowed and latched with CSC_CTRL_L0. */
+	if (layer_id == 0)
+		dcif_set_csc(dcif, new_state);
+
+	/* Format */
+	switch (fb->format->format) {
+	/* RGB Formats */
+	case DRM_FORMAT_RGB565:
+		layer_fmt = CTRLDESCL0_FORMAT_RGB565;
+		break;
+	case DRM_FORMAT_RGB888:
+		layer_fmt = CTRLDESCL0_FORMAT_RGB888;
+		break;
+	case DRM_FORMAT_XRGB1555:
+	case DRM_FORMAT_ARGB1555:
+		layer_fmt = CTRLDESCL0_FORMAT_ARGB1555;
+		break;
+	case DRM_FORMAT_XRGB4444:
+	case DRM_FORMAT_ARGB4444:
+		layer_fmt = CTRLDESCL0_FORMAT_ARGB4444;
+		break;
+	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_ABGR8888:
+		layer_fmt = CTRLDESCL0_FORMAT_ABGR8888;
+		break;
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_ARGB8888:
+		layer_fmt = CTRLDESCL0_FORMAT_ARGB8888;
+		break;
+
+	/* YUV Formats */
+	case DRM_FORMAT_YUYV:
+		layer_fmt = CTRLDESCL0_FORMAT_YCBCR422;
+		yuv_fmt = CTRLDESCL0_YUV_FORMAT_VY2UY1;
+		break;
+	case DRM_FORMAT_YVYU:
+		layer_fmt = CTRLDESCL0_FORMAT_YCBCR422;
+		yuv_fmt = CTRLDESCL0_YUV_FORMAT_UY2VY1;
+		break;
+	case DRM_FORMAT_UYVY:
+		layer_fmt = CTRLDESCL0_FORMAT_YCBCR422;
+		yuv_fmt = CTRLDESCL0_YUV_FORMAT_Y2VY1U;
+		break;
+	case DRM_FORMAT_VYUY:
+		layer_fmt = CTRLDESCL0_FORMAT_YCBCR422;
+		yuv_fmt = CTRLDESCL0_YUV_FORMAT_Y2UY1V;
+		break;
+
+	default:
+		dev_err(dcif->drm.dev, "Unknown pixel format 0x%x\n", fb->format->format);
+		break;
+	}
+
+	reg = DCIF_CTRLDESC0_EN | DCIF_CTRLDESC0_SHADOW_LOAD_EN |
+	      DCIF_CTRLDESC0_FORMAT(layer_fmt) | DCIF_CTRLDESC0_YUV_FORMAT(yuv_fmt);
+
+	/* Alpha */
+	if (new_state->pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
+	    !new_state->fb->format->has_alpha)
+		reg |= DCIF_CTRLDESC0_GLOBAL_ALPHA(new_state->alpha >> 8) | ALPHA_GLOBAL;
+	else
+		reg |= ALPHA_EMBEDDED;
+
+	regmap_write(dcif->regmap, DCIF_CTRLDESC0(layer_id), reg);
+}
+
+static void dcif_overlay_plane_atomic_disable(struct drm_plane *plane,
+					      struct drm_atomic_commit *state)
+{
+	dcif_plane_disable_layer(plane_to_dcif_dev(plane), 1);
+}
+
+static const struct drm_plane_helper_funcs dcif_primary_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= dcif_plane_atomic_check,
+	.atomic_update	= dcif_plane_atomic_update,
+};
+
+static const struct drm_plane_helper_funcs dcif_overlay_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= dcif_plane_atomic_check,
+	.atomic_update	= dcif_plane_atomic_update,
+	.atomic_disable = dcif_overlay_plane_atomic_disable,
+};
+
+static const struct drm_plane_funcs dcif_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.atomic_create_state	= drm_atomic_helper_plane_create_state,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+int dcif_plane_init(struct dcif_dev *dcif)
+{
+	const u32 supported_encodings = BIT(DRM_COLOR_YCBCR_BT601) |
+					BIT(DRM_COLOR_YCBCR_BT709) |
+					BIT(DRM_COLOR_YCBCR_BT2020);
+	const u32 supported_ranges = BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+				     BIT(DRM_COLOR_YCBCR_FULL_RANGE);
+	int ret;
+
+	/* primary plane */
+	drm_plane_helper_add(&dcif->planes.primary, &dcif_primary_plane_helper_funcs);
+	ret = drm_universal_plane_init(&dcif->drm, &dcif->planes.primary, 1, &dcif_plane_funcs,
+				       dcif_primary_plane_formats,
+				       ARRAY_SIZE(dcif_primary_plane_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret) {
+		drm_err(&dcif->drm, "failed to initialize primary plane: %d\n", ret);
+		return ret;
+	}
+
+	ret = drm_plane_create_color_properties(&dcif->planes.primary, supported_encodings,
+						supported_ranges, DRM_COLOR_YCBCR_BT601,
+						DRM_COLOR_YCBCR_LIMITED_RANGE);
+	if (ret)
+		return ret;
+
+	ret = drm_plane_create_alpha_property(&dcif->planes.primary);
+	if (ret)
+		return ret;
+
+	/* overlay plane */
+	drm_plane_helper_add(&dcif->planes.overlay, &dcif_overlay_plane_helper_funcs);
+	ret = drm_universal_plane_init(&dcif->drm, &dcif->planes.overlay, 1, &dcif_plane_funcs,
+				       dcif_overlay_plane_formats,
+				       ARRAY_SIZE(dcif_overlay_plane_formats), NULL,
+				       DRM_PLANE_TYPE_OVERLAY, NULL);
+	if (ret) {
+		drm_err(&dcif->drm, "failed to initialize overlay plane: %d\n", ret);
+		return ret;
+	}
+
+	ret = drm_plane_create_alpha_property(&dcif->planes.overlay);
+	if (ret)
+		return ret;
+
+	return drm_plane_create_blend_mode_property(&dcif->planes.overlay,
+						    BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+						    BIT(DRM_MODE_BLEND_COVERAGE));
+}
diff --git a/drivers/gpu/drm/imx/dcif/dcif-reg.h b/drivers/gpu/drm/imx/dcif/dcif-reg.h
new file mode 100644
index 0000000000000..d92c05446d84f
--- /dev/null
+++ b/drivers/gpu/drm/imx/dcif/dcif-reg.h
@@ -0,0 +1,268 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2025 NXP
+ */
+#ifndef __DCIF_REG_H__
+#define __DCIF_REG_H__
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+
+/* Version ID Register */
+#define DCIF_VER				0x0
+#define   DCIF_VER_GET_FEATURE(x)		FIELD_GET(GENMASK(15, 0), x)
+#define   DCIF_VER_GET_MINOR(x)			FIELD_GET(GENMASK(23, 16), x)
+#define   DCIF_VER_GET_MAJOR(x)			FIELD_GET(GENMASK(31, 24), x)
+#define   DCIF_FEATURE_CRC			BIT(1)
+
+/* Parameter Registers */
+#define DCIF_PAR_0				0x4
+#define   DCIF_PAR_0_LAYER_NUM(x)		FIELD_PREP(GENMASK(3, 0), x)
+#define   DCIF_PAR_0_DOMAIN_NUM(x)		FIELD_PREP(GENMASK(5, 4), x)
+#define   DCIF_PAR_0_AXI_DATA_WIDTH(x)		FIELD_PREP(GENMASK(7, 6), x)
+#define   DCIF_PAR_0_CLUT_RAM_NUM(x)		FIELD_PREP(GENMASK(11, 8), x)
+#define   DCIF_PAR_0_CSC_NUM(x)			FIELD_PREP(GENMASK(13, 12), x)
+#define   DCIF_PAR_0_CRC_REGION_NUM(x)		FIELD_PREP(GENMASK(18, 16), x)
+#define   DCIF_PAR_0_BACKUP(x)			FIELD_PREP(GENMASK(31, 28), x)
+
+#define DCIF_PAR_1				0x8
+#define   DCIF_PAR_1_LAYER0_FIFO_SIZE(x)	FIELD_PREP(GENMASK(3, 0), x)
+#define   DCIF_PAR_1_LAYER1_FIFO_SIZE(x)	FIELD_PREP(GENMASK(7, 4), x)
+
+/* Display Control and Parameter Registers */
+#define DCIF_DISP_CTRL				0x10
+#define   DCIF_DISP_CTRL_DISP_ON		BIT(0)
+#define   DCIF_DISP_CTRL_AXI_RD_HOLD		BIT(30)
+#define   DCIF_DISP_CTRL_SW_RST			BIT(31)
+#define DCIF_DISP_PAR				0x14
+#define   DCIF_DISP_PAR_BGND_B(x)		FIELD_PREP(GENMASK(7, 0), x)
+#define   DCIF_DISP_PAR_BGND_G(x)		FIELD_PREP(GENMASK(15, 8), x)
+#define   DCIF_DISP_PAR_BGND_R(x)		FIELD_PREP(GENMASK(23, 16), x)
+#define DCIF_DISP_SIZE				0x18
+#define   DCIF_DISP_SIZE_DISP_WIDTH(x)		FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_DISP_SIZE_DISP_HEIGHT(x)		FIELD_PREP(GENMASK(27, 16), x)
+
+/* Display Status Registers */
+#define DCIF_DISP_SR0				0x1C
+#define   DCIF_DISP_SR0_AXI_RD_PEND(x)		FIELD_PREP(GENMASK(4, 0), x)
+#define   DCIF_DISP_SR0_DPI_BUSY		BIT(14)
+#define   DCIF_DISP_SR0_AXI_RD_BUSY		BIT(15)
+#define DCIF_DISP_SR0_TXFIFO_CNT(x)		FIELD_PREP(GENMASK(23, 16), x)
+
+#define DCIF_DISP_SR1				0x20
+#define   DCIF_DISP_SR1_H_CNT(x)		FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_DISP_SR1_V_CNT(x)		FIELD_PREP(GENMASK(27, 16), x)
+
+/* Interrupt Enable and Status Registers, n=0-2*/
+#define DCIF_IE0(n)				(0x24 + (n) * 0x10000)
+#define DCIF_IS0(n)				(0x28 + (n) * 0x10000)
+#define   DCIF_INT0_VSYNC			BIT(0)
+#define   DCIF_INT0_UNDERRUN			BIT(1)
+#define   DCIF_INT0_VS_BLANK			BIT(2)
+#define   DCIF_INT0_HIST_DONE			BIT(5)
+#define   DCIF_INT0_CRC_ERR			BIT(6)
+#define   DCIF_INT0_CRC_ERR_SAT			BIT(7)
+
+#define DCIF_IE1(n)				(0x2C + (n) * 0x10000)
+#define DCIF_IS1(n)				(0x30 + (n) * 0x10000)
+#define   DCIF_INT1_FIFO_PANIC0			BIT(0)
+#define   DCIF_INT1_FIFO_PANIC1			BIT(1)
+#define   DCIF_INT1_DMA_ERR0			BIT(8)
+#define   DCIF_INT1_DMA_ERR1			BIT(9)
+#define   DCIF_INT1_DMA_DONE0			BIT(16)
+#define   DCIF_INT1_DMA_DONE1			BIT(17)
+#define   DCIF_INT1_FIFO_EMPTY0			BIT(24)
+#define   DCIF_INT1_FIFO_EMPTY1			BIT(25)
+
+/* DPI Control and Sync Parameter Registers */
+#define DCIF_DPI_CTRL				0x40
+#define   DCIF_DPI_CTRL_HSYNC_POL_LOW		BIT(0)
+#define   DCIF_DPI_CTRL_VSYNC_POL_LOW		BIT(1)
+#define   DCIF_DPI_CTRL_DE_POL_LOW		BIT(2)
+#define   DCIF_DPI_CTRL_PCLK_EDGE_FALLING	BIT(3)
+#define   DCIF_DPI_CTRL_POL_MASK		GENMASK(3, 0)
+#define   DCIF_DPI_CTRL_DATA_INV(x)		FIELD_PREP(GENMASK(4, 4), x)
+#define   DCIF_DPI_CTRL_DEF_BGND_EN(x)		FIELD_PREP(GENMASK(5, 5), x)
+#define   DCIF_DPI_CTRL_FETCH_OPT(x)		FIELD_PREP(GENMASK(9, 8), x)
+#define   DCIF_DPI_CTRL_DISP_MODE(x)		FIELD_PREP(GENMASK(13, 12), x)
+#define   DCIF_DPI_CTRL_DATA_PATTERN_MASK	GENMASK(18, 16)
+#define   DCIF_DPI_CTRL_DATA_PATTERN(x)		FIELD_PREP(GENMASK(18, 16), x)
+#define   PATTERN_RGB888			0
+#define   PATTERN_RBG888			1
+#define   PATTERN_GBR888			2
+#define   PATTERN_GRB888			3
+#define   PATTERN_BRG888			4
+#define   PATTERN_BGR888			5
+#define   PATTERN_RGB555			6
+#define   PATTERN_RGB565			7
+
+#define DCIF_DPI_HSYN_PAR			0x44
+#define   DCIF_DPI_HSYN_PAR_FP_H(x)		FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_DPI_HSYN_PAR_BP_H(x)		FIELD_PREP(GENMASK(27, 16), x)
+
+#define DCIF_DPI_VSYN_PAR			0x48
+#define   DCIF_DPI_VSYN_PAR_FP_V(x)		FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_DPI_VSYN_PAR_BP_V(x)		FIELD_PREP(GENMASK(27, 16), x)
+
+#define DCIF_DPI_VSYN_HSYN_WIDTH		0x4C
+#define   DCIF_DPI_VSYN_HSYN_WIDTH_PW_H(x)	FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_DPI_VSYN_HSYN_WIDTH_PW_V(x)	FIELD_PREP(GENMASK(27, 16), x)
+
+/* Control Descriptor Registers, n=0-1*/
+#define DCIF_CTRLDESC0(n)			(0x10000 + (n) * 0x10000)
+#define   DCIF_CTRLDESC0_AB_MODE(x)		FIELD_PREP(GENMASK(1, 0), x)
+#define   ALPHA_EMBEDDED			0
+#define   ALPHA_GLOBAL				1
+#define   DCIF_CTRLDESC0_YUV_FORMAT_MASK	GENMASK(15, 14)
+#define   DCIF_CTRLDESC0_YUV_FORMAT(x)		FIELD_PREP(GENMASK(15, 14), x)
+#define   CTRLDESCL0_YUV_FORMAT_Y2VY1U		0x0
+#define   CTRLDESCL0_YUV_FORMAT_Y2UY1V		0x1
+#define   CTRLDESCL0_YUV_FORMAT_VY2UY1		0x2
+#define   CTRLDESCL0_YUV_FORMAT_UY2VY1		0x3
+#define   DCIF_CTRLDESC0_GLOBAL_ALPHA(x)	FIELD_PREP(GENMASK(23, 16), x)
+#define   DCIF_CTRLDESC0_FORMAT_MASK		GENMASK(27, 24)
+#define   DCIF_CTRLDESC0_FORMAT(x)		FIELD_PREP(GENMASK(27, 24), x)
+#define   CTRLDESCL0_FORMAT_RGB565		0x4
+#define   CTRLDESCL0_FORMAT_ARGB1555		0x5
+#define   CTRLDESCL0_FORMAT_ARGB4444		0x6
+#define   CTRLDESCL0_FORMAT_YCBCR422		0x7
+#define   CTRLDESCL0_FORMAT_RGB888		0x8
+#define   CTRLDESCL0_FORMAT_ARGB8888		0x9
+#define   CTRLDESCL0_FORMAT_ABGR8888		0xa
+#define   DCIF_CTRLDESC0_SHADOW_LOAD_EN		BIT(30)
+#define   DCIF_CTRLDESC0_EN			BIT(31)
+
+#define DCIF_CTRLDESC1(n)			(0x10004 + (n) * 0x10000)
+#define   DCIF_CTRLDESC1_POSX(x)		FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_CTRLDESC1_POSY(x)		FIELD_PREP(GENMASK(27, 16), x)
+
+#define DCIF_CTRLDESC2(n)			(0x10008 + (n) * 0x10000)
+#define   DCIF_CTRLDESC2_WIDTH(x)		FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_CTRLDESC2_HEIGHT(x)		FIELD_PREP(GENMASK(27, 16), x)
+
+#define DCIF_CTRLDESC3(n)			(0x1000C + (n) * 0x10000)
+#define   DCIF_CTRLDESC3_PITCH(x)		FIELD_PREP(GENMASK(15, 0), x)
+#define   DCIF_CTRLDESC3_T_SIZE(x)		FIELD_PREP(GENMASK(17, 16), x)
+#define   DCIF_CTRLDESC3_P_SIZE(x)		FIELD_PREP(GENMASK(22, 20), x)
+
+#define DCIF_CTRLDESC4(n)			(0x10010 + (n) * 0x10000)
+#define   DCIF_CTRLDESC4_ADDR(x)		FIELD_PREP(GENMASK(31, 0), x)
+
+#define DCIF_CTRLDESC5(n)			(0x10014 + (n) * 0x10000)
+#define DCIF_CTRLDESC6(n)			(0x10018 + (n) * 0x10000)
+#define   DCIF_CTRLDESC6_BCLR_B(x)		FIELD_PREP(GENMASK(7, 0), x)
+#define   DCIF_CTRLDESC6_BCLR_G(x)		FIELD_PREP(GENMASK(15, 8), x)
+#define   DCIF_CTRLDESC6_BCLR_R(x)		FIELD_PREP(GENMASK(23, 16), x)
+#define   DCIF_CTRLDESC6_BCLR_A(x)		FIELD_PREP(GENMASK(31, 24), x)
+
+/* CLUT control Register */
+#define DCIF_CLUT_CTRL				0x1003C
+#define   DCIF_CLUT_CTRL_CLUT0_SEL(x)		FIELD_PREP(GENMASK(0, 0), x)
+#define   DCIF_CLUT_CTRL_CLUT1_SEL(x)		FIELD_PREP(GENMASK(3, 3), x)
+#define   DCIF_CLUT_CTRL_CLUT_MUX(x)		FIELD_PREP(GENMASK(29, 28), x)
+#define   DCIF_CLUT_CTRL_CLUT_SHADOW_LOAD_EN(x)	FIELD_PREP(GENMASK(31, 31), x)
+
+/* FIFO Panic Threshold Register, n=0-1 */
+#define DCIF_PANIC_THRES(n)			(0x10040 + (n) * 0x10000)
+#define   DCIF_PANIC_THRES_LOW_MASK		GENMASK(11, 0)
+#define   DCIF_PANIC_THRES_LOW(x)		FIELD_PREP(GENMASK(11, 00), x)
+#define   DCIF_PANIC_THRES_HIGH_MASK		GENMASK(27, 16)
+#define   DCIF_PANIC_THRES_HIGH(x)		FIELD_PREP(GENMASK(27, 16), x)
+#define   DCIF_PANIC_THRES_REQ_EN		BIT(31)
+#define   PANIC0_THRES_MAX			511
+
+/* Layer Status Register 0, n=0-1 */
+#define DCIF_LAYER_SR0(n)			(0x10044 + (n) * 0x10000)
+#define   DCIF_LAYER_SR0_L0_FIFO_CNT_MASK	GENMASK(9, 0)
+#define   DCIF_LAYER_SR0_L0_FIFO_CNT(x)		FIELD_PREP(GENMASK(9, 0), x)
+
+/* Color Space Conversion Control and Coefficient Registers for Layer 0 */
+#define DCIF_CSC_CTRL_L0			0x10050
+#define   DCIF_CSC_CTRL_L0_CSC_EN		BIT(0)
+#define   DCIF_CSC_CTRL_L0_CSC_MODE_YCBCR2RGB	BIT(1)
+
+#define DCIF_CSC_COEF0_L0			0x10054
+#define   DCIF_CSC_COEF0_L0_A1(x)		FIELD_PREP_CONST(GENMASK(10, 0), x)
+#define   DCIF_CSC_COEF0_L0_A2(x)		FIELD_PREP_CONST(GENMASK(26, 16), x)
+
+#define DCIF_CSC_COEF1_L0			0x10058
+#define   DCIF_CSC_COEF1_L0_A3(x)		FIELD_PREP_CONST(GENMASK(10, 0), x)
+#define   DCIF_CSC_COEF1_L0_B1(x)		FIELD_PREP_CONST(GENMASK(26, 16), x)
+
+#define DCIF_CSC_COEF2_L0			0x1005C
+#define   DCIF_CSC_COEF2_L0_B2(x)		FIELD_PREP_CONST(GENMASK(10, 0), x)
+#define   DCIF_CSC_COEF2_L0_B3(x)		FIELD_PREP_CONST(GENMASK(26, 16), x)
+
+#define DCIF_CSC_COEF3_L0			0x10060
+#define   DCIF_CSC_COEF3_L0_C1(x)		FIELD_PREP_CONST(GENMASK(10, 0), x)
+#define   DCIF_CSC_COEF3_L0_C2(x)		FIELD_PREP_CONST(GENMASK(26, 16), x)
+
+#define DCIF_CSC_COEF4_L0			0x10064
+#define   DCIF_CSC_COEF4_L0_C3(x)		FIELD_PREP_CONST(GENMASK(10, 0), x)
+#define   DCIF_CSC_COEF4_L0_D1(x)		FIELD_PREP_CONST(GENMASK(24, 16), x)
+
+#define DCIF_CSC_COEF5_L0			0x10068
+#define   DCIF_CSC_COEF5_L0_D2(x)		FIELD_PREP_CONST(GENMASK(8, 0), x)
+#define   DCIF_CSC_COEF5_L0_D3(x)		FIELD_PREP_CONST(GENMASK(24, 16), x)
+
+/* CRC Control, Threshold, and Histogram Coefficient Registers */
+#define DCIF_CRC_CTRL				0x20100
+#define   DCIF_CRC_CTRL_CRC_EN(x)		(1 << (x))
+#define   DCIF_CRC_CTRL_HIST_REGION_SEL(x)	FIELD_PREP(GENMASK(17, 16), x)
+#define   DCIF_CRC_CTRL_HIST_MODE		BIT(21)
+#define   DCIF_CRC_CTRL_HIST_TRIG		BIT(22)
+#define   DCIF_CRC_CTRL_HIST_EN			BIT(23)
+#define   DCIF_CRC_CTRL_CRC_MODE		BIT(28)
+#define   DCIF_CRC_CTRL_CRC_TRIG		BIT(29)
+#define   DCIF_CRC_CTRL_CRC_ERR_CNT_RST		BIT(30)
+#define   DCIF_CRC_CTRL_CRC_SHADOW_LOAD_EN	BIT(31)
+
+#define DCIF_CRC_THRES				0x20104
+#define   DCIF_CRC_THRES_CRC_THRESHOLD_MASK	GENMASK(31, 0)
+#define   DCIF_CRC_THRES_CRC_THRESHOLD(x)	FIELD_PREP(GENMASK(31, 0), x)
+
+#define DCIF_CRC_HIST_COEF			0x20108
+#define   DCIF_CRC_HIST_COEF_HIST_WB_MASK	GENMASK(7, 0)
+#define   DCIF_CRC_HIST_COEF_HIST_WB(x)		FIELD_PREP(GENMASK(7, 0), x)
+#define   DCIF_CRC_HIST_COEF_HIST_WG_MASK	GENMASK(15, 8)
+#define   DCIF_CRC_HIST_COEF_HIST_WG(x)		FIELD_PREP(GENMASK(15, 8), x)
+#define   DCIF_CRC_HIST_COEF_HIST_WR_MASK	GENMASK(23, 16)
+#define   DCIF_CRC_HIST_COEF_HIST_WR(x)		FIELD_PREP(GENMASK(23, 16), x)
+
+#define DCIF_CRC_ERR_CNT			0x2010C
+#define   DCIF_CRC_ERR_CNT_CRC_ERR_CNT_MASK	GENMASK(31, 0)
+#define   DCIF_CRC_ERR_CNT_CRC_ERR_CNT(x)	FIELD_PREP(GENMASK(31, 0), x)
+
+#define DCIF_CRC_SR				0x20110
+#define   DCIF_CRC_SR_HIST_CNT_SAT_MASK		BIT(13)
+#define   DCIF_CRC_SR_HIST_CNT_SAT(x)		FIELD_PREP(GENMASK(13, 13), x)
+#define   DCIF_CRC_SR_HIST_SAT_MASK		BIT(14)
+#define   DCIF_CRC_SR_HIST_SAT(x)		FIELD_PREP(GENMASK(14, 14), x)
+#define   DCIF_CRC_SR_HIST_BUSY_MASK		BIT(15)
+#define   DCIF_CRC_SR_HIST_BUSY(x)		FIELD_PREP(GENMASK(15, 15), x)
+#define   DCIF_CRC_SR_CRC_STATUS_MASK		BIT(31)
+#define   DCIF_CRC_SR_CRC_STATUS(x)		FIELD_PREP(GENMASK(31, 31), x)
+
+#define DCIF_CRC_HIST_CNT_B(n)			(0x20114 + (n) * 4)
+#define   DCIF_B_BIN_CNT_MASK			GENMASK(20, 0)
+#define   DCIF_B_BIN_CNT(x)			FIELD_PREP(GENMASK(20, 0), x)
+
+/* CRC Region Position, Size, Value, and Expected Value Registers, n=0-3 */
+#define DCIF_CRC_POS_R(n)			(0x20214 + (n) * 0x10)
+#define   DCIF_CRC_POS_CRC_HOR_POS(x)		FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_CRC_POS_CRC_VER_POS(x)		FIELD_PREP(GENMASK(27, 16), x)
+
+#define DCIF_CRC_SIZE_R(n)			(0x20218 + (n) * 0x10)
+#define   DCIF_CRC_SIZE_CRC_HOR_SIZE(x)		FIELD_PREP(GENMASK(11, 0), x)
+#define   DCIF_CRC_SIZE_CRC_VER_SIZE(x)		FIELD_PREP(GENMASK(27, 16), x)
+
+#define DCIF_CRC_VAL_R(n)			(0x2021C + (n) * 0x10)
+#define   DCIF_CRC_VAL_CRC_VAL_MASK		GENMASK(31, 0)
+#define   DCIF_CRC_VAL_CRC_VAL(x)		FIELD_PREP(GENMASK(31, 0), x)
+
+#define DCIF_CRC_EXP_VAL_R(n)			(0x20220 + (n) * 0x10)
+#define   DCIF_CRC_EXP_VAL_CRC_EXP_VAL_MASK	GENMASK(31, 0)
+#define   DCIF_CRC_EXP_VAL_CRC_EXP_VAL(x)	FIELD_PREP(GENMASK(31, 0), x)
+
+#endif /* __DCIF_REG_H__ */

-- 
2.53.0
