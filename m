Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A10606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A1TwN1nN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C12610E487;
	Thu, 22 Oct 2026 19:37:35 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013003.outbound.protection.outlook.com
 [52.101.83.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F399910E48D
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 19:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln5DumMNz4RlbZDgSIwMmWlLSe793L8i6luwmpTcOK37vuNhC6g6/+iMEKUwi2SKTwZJ9kFj9vAXxOJ6VUudYy3F4IcI2tMKUtua3B6AxbDtnzdwleCooHUcLl6kZQm3wLwioe2ggT6/DU7vQ9iskl7RyiVhLrmxGbeFcNyna+skserxTDl6eo7r8o5BdVuT9etBcWjV9lvwYbWCqiTkwYzB1IA5rh1REFmFnRwQrjwcr9RyM5t/lqQ07H2lnEJiLX72zNeRvr2/0VSp+mLPJafJim/BUK0gW/sRPK1h/oV7HzufZi+/rPifiJ9re2AnVPn+A+ddDkz+lY5sBHV1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2kkudxPGoYmRBQ5It6FM4JyXYS6HgS1O1wWOp+Ptc4=;
 b=bu1JZASMv/xIxyr+AHdxH/rQMTNqVAH6tVV0FTLhEUtSAEUpnD0l+EUlhWPbW6UZ6RF6Rgl1rhPyapjPCTShwQtXHml9Q0sWMmpPGElyu6TOO5TKd9XDN7c9o0x5XdQmIOMY+Ll+5+N41o4cyIiTqEt6rksGB9GKjhee4s/f4fPYkMoFVa47BxnG7nsuBhDcyk1rvwFXYoT+PJc+PzJlQkQBr2MFDM2ugEGpRQXSuI29Eu2gDhfGBh/EOGnuKIvlqd98iZMKppYBEA74J84JE4d5g1Mocqm3LQlD58R3Y/hu2McpqEMEbnZ6e2vI1dx56XNXU8hnm/XgwFqwzV050g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2kkudxPGoYmRBQ5It6FM4JyXYS6HgS1O1wWOp+Ptc4=;
 b=A1TwN1nNTIZYPsUZnXAdwjYZAQl9V+ZJwd7fQsgrKlE1Md2NVlC8Oe+W3b0bTXHYAx3kzdm9yW3075tda4ppa6MQozMYOBASSIvaD51h+LUpizcbqjprV75tFu/RIZYKScXEyqmK4WOi7r59Cf4VKLnTQAlv70JdjCvasvtR16ZOQoRFXNQ8xS2bxPgEMASBDQb1PZ1Q92tk0cnYmNGQUuH1+60Hrjz2iUTDuf2g2gk8jTX9NjT6GACC66L7QrIY3LMz4GAKVc8Gkz0nzga+EVrZbnqRmoCeorAOC2QZKYTv7Wz5PsSv62P7lr3IQKAEN/b7FRMIGo5th7YrsGdILQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8679.eurprd04.prod.outlook.com (2603:10a6:10:2de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 19:37:23 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 19:37:23 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 22 Oct 2026 15:37:05 -0400
Subject: [PATCH v2 2/8] dt-bindings: embedded-controller: remove
 #address-cells and #size-cells from required
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-cleanup_dtb_warning-v2-2-e9502fafec59@nxp.com>
References: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
In-Reply-To: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BAnther?= <agx@sigxcpu.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792697827; l=1109;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yniFdnN8J279alEW3RFkxZf7VYIrzWRSlsxTt5JqvuM=;
 b=aizJwjPcCalYnav2dEv4q/txbbw46g0MP/dru7yP9W7qrEpobqyfKnTFk0eIvAIPY10mQWy2C
 /HMdN3dFbN/DBIQDlzqiKrbzc0Ix89Q1pyvox6Xk+dlGArHvvEx4cJ2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: 744b327d-435f-4193-c364-08df3073e539
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|19092799006|366016|921020|261021121427099003|56012099006|261009223027099003|11063799006|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /sqiZKUjMYqx4BCoW09v/UztsA5C3cwe8QtI4MfCaALmDdlRtJGc6dxHU1Ans3378O5pgXOZEkx+M+w+3l8P7ErXW64Vn89CdbnuixdKnegwyWby5e9ivej0cpIYH0BJW4GKxEELajsaRtHM7c4G2BnvL5iDvEkQi72bqnbTOX0L6DwDt1hMdbT4yxiCqrOeRpm6O7Cfv09x0SKax19RyYCitOYYkE5XgCxVFpDk0sfECzXyfHo6iocsqrzqNY4SYh95aLDbx4XY68JjOYwGTwVvl49oIK5RECzWDvsBw7AOT1zTRNMHvKL0X1M/llnsHf/8ilHKh8uiVOXVKQrniDaW2Y34K+fjw6uECFBBgvCwfaW+PD1hKh3b86NfbO3S5TtfhbFkLGXhQC/HNWpFNm6htY5K9s4vlrnvfWMReMlfoY0zsHVxMED91i/tkAStTgwfsaLYT27nMdg7GrLjwCpXA+jAsPxF75ZCHMRUv4VIcw6XE01SMs4nA24Wzs7NPAY2tOqZYJYfwjqtjxuxw6yzpCUCb5628SypkeO8FKe7Qt2vFzik3/Up2gxe6xqVXRiww9gScVfDSUgFAMDS4JPbeIoLPP4tupJKzs864L90oRc9UaXudl+QcjB/gR5TkcFrO+k7pL8CMz6e4TnYz74SjZTV+2vVq8No4bVPa5QP2XOfYohWxVO/JlBorfNo/hufZs9UVcaf95gdvZfCtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(19092799006)(366016)(921020)(261021121427099003)(56012099006)(261009223027099003)(11063799006)(10067099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckc5ZDlmTktpa04wYUQ4SmE1eDF6c2RWYUlISHljQTQrL3kyZ1YxNzBhcEpl?=
 =?utf-8?B?QVhLRzhyQ2d5Q1NXVGJJb2s3S0NPUXAreGFueXVocWFGK1U3TGswdFh5SFdE?=
 =?utf-8?B?aVJWWVg3WStNb3VmZUVETmtMTlBlQVdqM1U5L1hHbzQ1bStQdk4xa2g3dXp5?=
 =?utf-8?B?bjU1ODFyREEyeUZ2aENNVlY2Z0R4VXZqa3ZlbS9qd2VSZ2IvbHp1Qy96cm9M?=
 =?utf-8?B?YSt3QnV3dE1RcGQ5SGxFSncxZmZGOEFSVm1Xays4d2loMUxYQk9lQ0FsM0hT?=
 =?utf-8?B?QXphQzVGRmx6czR1NCtJN0hxUWdnOFRvaldCSzMzMWw2MUtEbDZ5OUFjTUlC?=
 =?utf-8?B?YWJNWnc0ZklpR3FCN2xLY2RhdmZXTGQzek9EQTNidGUwdU5QRHp5TFJLb3Ni?=
 =?utf-8?B?QStscEd1RUk1WVBCOVNrcUUyTzFsS29CZG9pZ3VtU1hSdmUvYmZaWnVmS2E0?=
 =?utf-8?B?WjNwdWFpVy9TZGFvbFc1akZBUXQ5N2hmb2JDNTJTZ2g2VVRGWXZzaGdVWjBp?=
 =?utf-8?B?Z3IxN0RJVzUrSmQ2M0FPcDVzTU85dmZZYk1yYTVRSWxiZERocjFQWExrVHl3?=
 =?utf-8?B?eDlrVnVzL3RxdEFrM0pTZXdWMnkxZ1BaeTF3L3VuMFN6L2wxeEpzdzJFMFdB?=
 =?utf-8?B?VE9oUXdjeU5nejBwM3dOWEZQeENhVyt2ckw0VE5ucndBTVN2dHNHOW4xOHRj?=
 =?utf-8?B?VFNva2plYnpMWjdVMGRaVnNhUjFWbmJHczlMcldaMXYySW01allSc3lmSjk2?=
 =?utf-8?B?Sk41SG1KbFZXb3IvWFZ3Nk8zZ1h0N0xrOVlZNCtkTFYxMUdUZE1mQXJrNzJY?=
 =?utf-8?B?Ny9KbWpaUm9UckxGMkNWSE42SDFWRTBwWk9LOWRWQ3BuaHcyNGV2Y3VyWmUw?=
 =?utf-8?B?NU93QTVpNVUvL1VFbjF6dmdOYW1zQzdhV21MWTV6akVZcHNZSHdmbGlBdGl6?=
 =?utf-8?B?aG9aRzcwZnhjVTR5WkhPTHpkYUZaeldKcVRjb0xSOEpIcHNqSmI2Y0dSNjhU?=
 =?utf-8?B?NU5XNWNCSU9DbEFrRHhxckVFN1BmRnhmcnd4dU9GcGZrb0RaWnRvWmdiUE1t?=
 =?utf-8?B?dzJ2N1Qzc0RSVG5wZXJ6ZjBvcVZpaGlnV0RpTmVhTmpaS3FKWG0vbElEVHZV?=
 =?utf-8?B?Uy91WCtVWUpyWEhGcEE2UGthY1J0YU5La01lWXJRR3YwZ2tqY3hueDJQeHNW?=
 =?utf-8?B?ZVhYdEVFNVVkVVVTVVVUSVJsS1U3QWVXY2xvVEN4RzkwZWM0Ui94YzQ5bFZV?=
 =?utf-8?B?QXRrVDUxMU02RTBheHlrZWgrYWNLV3Bubm85Umk4QnVKT2hOYUEzaGVBVENo?=
 =?utf-8?B?T0hjTjZhQXVPV3IveWxmTGFBSXJhZDJFcUhrUGd5dmxYY0tTKzFuZnU5cTN2?=
 =?utf-8?B?Z1o1NXRBZlZ2VHBDSUw0T2tNTzZhUUdwZldiSC92aWFRd21BUVUvOFVVYU9G?=
 =?utf-8?B?UzFJWFpQSXFUNzdUbkF0UWprNzBVb1N0NFZxZVloSk9ZUVlBMmZubWZGWFAv?=
 =?utf-8?B?dDR1L3A2bFdETURWWThzNEpkc0xGWkhsZlF3d3ltYkdORW9zQituL3RWMklX?=
 =?utf-8?B?UjJSZGFnVkV3MkNIdXMxb1JCWTE1Z0dMTW1BUzdMQUxnU0lHV0R2cEZjemxa?=
 =?utf-8?B?djZZalorUlI0dDZFL2pWcTA0L0NQdWZLYW9Ld1FsUUpQcmFBV1dOUTRmbzdr?=
 =?utf-8?B?WTdnWkYvYWJuTTV4aGp4TURjakIvOE5VVHNGdU5wSWMwWWhQRk9Pc1RFS3l2?=
 =?utf-8?B?ZFJkSWVwSFU0VGRpM0JDYSsvakNYWTY0VHc4VlUzZTArVjRtSEJkZTR5WmFT?=
 =?utf-8?B?YXZtdWpSOWlUUEQ3YnIrQ0JWMUd6UkEyWlBORFREeTFqNy81VGlOOTBhZDU4?=
 =?utf-8?B?cmpVVU9ua0Q2QUhmaGxNRVNNaUd6UUFQb1FnbllycEYzSHRBK2VCaGlXbmlI?=
 =?utf-8?B?Mjd1TVE1R1JsUWJ1MXB0VnhFRHVOcm4zWDh2N0VJQjVqdXJVVEJMOXIzSm51?=
 =?utf-8?B?dTYrOVZoK0JKWVFMZDVBZDVtMHIwMUJvSU1FSWMwMXNFUkwvcFBLZXNrcmU2?=
 =?utf-8?B?Y1FxcHI3eHVNa1dEWnZXZnUwOVdrMWVvd3A2Q0tXQWNJdURtdVp3NHJmSlZ3?=
 =?utf-8?B?dEhTa1psQzNOMkVva3d2VG15ajhSRVlZa1g1eEs3N3doV1JCTXViMWlmNkRN?=
 =?utf-8?B?SG42Vmw4Q1IybGFHNytwQ1dQdkNwRE8wUEVoQUZEQ0NUWFJnSkRscG5rV1pL?=
 =?utf-8?B?OGJ3ZnV2K3dXS0t2T3ZHT0h2V0FJNlB5RDJtWmFwd2JDUnRtczRNRUtUZ2hJ?=
 =?utf-8?B?azljamlRZWJrbEpNZzFPRTdqUmRFWGh1OW1YTGwwUjU4NGc1V1BOamd5VjA0?=
 =?utf-8?Q?iF91DEgF212P1AN3AeJFylCJxicZnDRZa7WR0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744b327d-435f-4193-c364-08df3073e539
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:37:23.5767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zf8Kq3vGy2OPhyD/yQmhH7haX4QSJURlIoYn+YPDJ3gIzpQ9AtEKyPVV2RZq+YKQxkkIsH41UCQw0xCGzK/R10+BVzUG7nhF+BVbR4vrzOh2IVFmrm0n8z0Nw8gJxvEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8679
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

From: Frank Li <Frank.Li@nxp.com>

The "^fan-controller@[0-9a-f]+$" child node is optional, so it is not
necessary to always have address-based child nodes.

"refer to the board hardware user manuals to see what features are present"
Means fan-controller is optional, which may not present at boards.

Remove '#address-cells' and '#size-cells' from the required list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change at v2
- add descriptions about why fan-controller is optional.
---
 Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml b/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
index 82d4b2dadbae4..99f685938e20a 100644
--- a/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
@@ -136,8 +136,6 @@ required:
   - interrupts
   - interrupt-controller
   - "#interrupt-cells"
-  - "#address-cells"
-  - "#size-cells"
 
 additionalProperties: false
 

-- 
2.43.0

