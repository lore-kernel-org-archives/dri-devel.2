Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795C606A8AF
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=VwoE3Gb+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D7B10E78F;
	Fri, 13 Nov 2026 12:21:18 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB46112490
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAa6BDL0wbQlQ/z7fCQpNDpHsTQSAVONBvJTTUM6Kt3G/V+Zk1Os0vcXoMg5gxeP7jBu5ycffOfXrmgRn2qTUBD/lNT0hXEFa/C5DS4zkhFkmv94U5d0yGzjP+m/9auWSr4Klq5lGFY0fVQuSZcMPWk3JscpLoAYgs9vcVZFb485dWgupb7LXRPm3TXXl1MzZ/ptun+iw4dXRBhJGcB+kdlkhCVBXBH8Y5Z3VKJ3VnpiRwm0vd58TCklgrJsIiyHuGg+LDysNicc3RVhRzbNNnOQ2Tl6+iwm/k3OuFGnfwtViGZOTL6HQcfJEOvRGG4ymanLOeJvNIrMwPDDqnkG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lalOe9cEyHtckS05rmUeZvtspIRKQJil6M7mUfCLcCo=;
 b=SxAECbLqg1oP3dqsWC4dfPhhlPHOfDmPqlRt990QX2N+EDrKdz6xt7IDfduO000b0Xw+DnbqnjvvAeo+sWbudDCaGHDT1Qu37X+8F3z1thbyB+rEcfUmSBhVSyiFi7IAYRDBKbH3rhMpZzTvW6UmBShiSqa0LoUkhKHUdUYm7xmFDCJbJEi8Wp974saXTJW/dBbtPW/DuiYXabZlRclfsvejVq/Z4yR46mUv/ZiEKiKvpVLCsun3uh0sNqaOLA3v5JUep5xqWjRncLdjMCFKfH0mmbvaKfTMAn0lXsTnO2sv7z1qLzmaXpIxvJRPej3JWiccpZBmbGLeQymYZ7qZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lalOe9cEyHtckS05rmUeZvtspIRKQJil6M7mUfCLcCo=;
 b=VwoE3Gb+mj9/NPQcIvFW5x8SNI4/B9QDG2hvUt2nCPFbLfg+rsiKIdlPiLP/hQTmzsK5V9tCFnZ6Q87sNkcWLScA7FQKfqEnFFf7J9duXvnvj3BEizvIn+UqT6CMgE11fV+g7GMEKI8m8kgVt37tiTa91CiD/SRxliY19CCcpxs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:07 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:07 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v10 04/12] drm: renesas: rz-du: Count all registered encoders
 for the possible clones
Date: Fri, 13 Nov 2026 13:20:00 +0100
Message-ID: <a1d01f35c0e15947936e69ff0a642a2458ca2e67.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::21) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB14799:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9c991f-75c9-4604-06ad-08df41809810
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|5023799004|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: liz4Pvn6SjNl2wIchf50dhXaUnWpgzznIBqJUW0Hcxo8SlxkSQmIy10s4g0Wofd+9N7ZPNLYecpRtmYcx5GPSI5PRTISahgvFr6mMecHHBYg+556wlfNY+zavVzAc5x8CARW0TzstznZ11da51RwsdApF7YY5l2zwiNhT3sHPRdOUl9KLsCWQvp5pT35eJMtLi3XKR8YeaDxYfRp8YrS96c3op+ctmfAT6W95QH4MrjhdFbEAEproo9CJradbSc8+MpVPnhGJ2MAlkoREjTA5E5GAg2F0hU00KsZs7pIKg45/Y2254tFFu7P/LGpZjkDTL3v97gmyrMom59rauDrs82olFG6eyM6+at13Bfktz896HM6YAy/RkeyDJRmzs6nWst5JONOVqAtkiAWZeAWaCfE4CqZ+ZNuZc+m6qFa4WEY9HkW6B5UY9QUsSD92nARCg7A3y/wV1KXjzKy6zSt69tUOhTU2cU0zpX/+4QRkAMlqoxu4ZVJ07sN7xLeZPaDr/TJCOaOBXQlgaZf2hhC5SI0fDEexuqRprhkDPb++YBBoxTJRVV5WF4NxwO869cfjsEyJMeVmPx+lInE53pIxSs+BFhx+gUKWlPm9U+DuHo9sKmtsiHseMIIsk5Lrd7M2jyNOsJuiTNaDotiiTfsmBjNittx+udEa7Na7j/qoDSU6ruMGT+n2MRDFg9UVHX9zTQZtP9oaXgGFpDtPiJNKYFMeM7X/VKV9kDZrRyIMto=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(5023799004)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CWJwavE385uDJ854c3ytF2Qmx0CraAgZx/oH2WBVaWHUNvlp21/GgbPoihpO?=
 =?us-ascii?Q?1NwVRoYVRQnYOkDrLtIdnrE/nZM6KNk0xqp24PuZMuKc188G1J/2ISLZyNiF?=
 =?us-ascii?Q?zY3UGZFimpj1AGmMWpW/Hj03LHfw/aExqAkRD/9MV+2sO/kAEN0j0bppQLpN?=
 =?us-ascii?Q?2zHt3qtz5kg4ZbKo8GwNeLY6XB/2DewEvDGCN9TLzk+gLmf8bUYgx9gKoOVV?=
 =?us-ascii?Q?rpuFRwD1RvgUh6VGMWC11hDZhQb33nwrAibBfEjDL6RK569fcwsTmYVQsV9e?=
 =?us-ascii?Q?rwe8572A3Z8IbFnp/LzYav+lLf32h+L1GbBHnJhkg0eOBBh0cotinPPJYMe5?=
 =?us-ascii?Q?yhKLp7YiO/LC5CQvWQbQytkYtT7vqckXtkYp2PV71SLHcpKYjhf/JeukuDJT?=
 =?us-ascii?Q?9ShGN/uFLAkAbnkY3NAlEyA3Hkc8PGfnvigWbU9Bskef5qSxO4phiFSv4Nrl?=
 =?us-ascii?Q?EMMk9g1uGda9Vqv+AsIXMBvRk3p1yqoVF9+HC2x06grThAsGhNfvvnrTb8AO?=
 =?us-ascii?Q?nNsVe+/jJqocCI0j/iXjD2ugRjB+OM5Q6zNglfmykuAkXxDbdOwJWjIg9HYj?=
 =?us-ascii?Q?iAFta9B+v+0IPGbd3GX2EqNSQ2eO7i7kj2mDgFhCvg5N42Fs3NRu+sV+BJxr?=
 =?us-ascii?Q?jJSm/QTPzKV5p39Ml3P6UrDYBoNUM5h2KGDQZKgV1jqCepc+jzTidNnttylg?=
 =?us-ascii?Q?yvygdCAcy+HQcH3xdNJrcAqyBTVeVx0TfOT0TNSuAakzj6F1SGdDCp450t7O?=
 =?us-ascii?Q?s68GCh/crn7+GCvP+ADOrlvOtlFOh0OIdRScPThm4q8pZW3tfDGkRiwCMD1V?=
 =?us-ascii?Q?D3XNOC+As/4tFbadLQoM3VAIT4guYPjvQ0xqlIuYvuF3p/jadljMbm87YByC?=
 =?us-ascii?Q?mHgTioEm0WFyXncFCZwJ4pV1hO9jWyipLxN7gQ+Eg8bB0jBWv+GrjXeFoIKv?=
 =?us-ascii?Q?NvR21SA6y2iTbs8vwfSrrleHvpuVPlQEFcaePjvPIPIxsZeWMBPILz7fcg8f?=
 =?us-ascii?Q?WwLffZYV5+DrGauSysZo2FMyeir8lAvV7V7c9jeNOb+z1uQYOV2DlU0HYbEN?=
 =?us-ascii?Q?yKIIrPeLF0iEB3z8FCnt23OrycH0fWCBUVh8c4PyIxtPfKuMljSj3dgX86/g?=
 =?us-ascii?Q?GgopTdyKDIePlbHqf7JKyLfofTfmz1elifLf7uZz7fQ3IcUB1lfz8oQGtu+w?=
 =?us-ascii?Q?dk8yVXIwahlqzb1ng59bTAAvHD2DcnJEBxSYUp9SraKqKTMBKyXUf48dMQIk?=
 =?us-ascii?Q?sWGYqkm+OQyejGHKv+HfwRBsFYzhNC0w46STda24Q7z0SZ57TeaXHEXKc0Nw?=
 =?us-ascii?Q?+KdlWftVU1igGaBX5pvUY0TSimrw127Dhi8DFI01G9PnNxonvFzwer1Y0qIl?=
 =?us-ascii?Q?FOMyHkwfBqnVts8eEmBnm+KmA63izao7Qg+4TA9LjngJ3/E1AQA2NrTFH9ej?=
 =?us-ascii?Q?2051oLstXZZuF1MhgOZL7yWxh9CiLXZ2adeH6lSYQ+FIDctK3x8eYSl4uMG+?=
 =?us-ascii?Q?BiaiHoXch39PL6opnnQZW21SamZ14D0qgLg+NHyvrayiEpZ4udGYA46a79ck?=
 =?us-ascii?Q?mgIwdS7Ecege+32cfDvk7aQ+3iJujJ+lQNaaR6UW140QW9Kh5DyE2KTsoDOP?=
 =?us-ascii?Q?5xLrLE016DP3RS+0Lyd4rZz9S+kKjHYqiizz6txykir87UQsFskOUI+kLpog?=
 =?us-ascii?Q?AeH+GAR0QtUD+pGRpTQs1yPDM80uuYCHFM+pE0odvD1qGpjBthsKVrQvGqnH?=
 =?us-ascii?Q?jCbJ28VSLd6NhO+geTKanvcIbsEGM3N/pO2D2qWlfi8Qci8eA488?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9c991f-75c9-4604-06ad-08df41809810
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:07.6215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBX02s7olu2/VlHsOYYLbxsP0HicRRq9xZ9g0tbIxmo54xOJ0N/sfjiQWekvPOilY62egjYL43EkO9afgeTSTggiG6TCekycPaT7b8XDlLptPxF083PGv4m4cYbMSmHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14799
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

rzg2l_du_modeset_init() sets the possible clones of every encoder
registered with the DRM device, but builds the mask from the number of
outputs that rzg2l_du_encoders_init() initialized successfully. An
output whose bridge fails to attach after its encoder has been allocated
is skipped and not counted, while its encoder stays registered. The
mask then misses the bit of the last encoders, and
drm_mode_config_validate() warns about bogus possible clones.

Build the mask from the number of registered encoders instead.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - No changes.

v8->v9:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 13d14ecacba9..6eb1865f43b4 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -455,7 +455,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 		return -EINVAL;
 	}
 
-	num_encoders = ret;
+	num_encoders = dev->mode_config.num_encoder;
 
 	/*
 	 * Set the possible CRTCs and possible clones. There's always at least
-- 
2.54.0

