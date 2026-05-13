Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF22CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB18A10F083;
	Wed, 13 May 2026 20:57:02 +0000 (UTC)
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.111.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E14310E31A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:31:42 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021087.outbound.protection.outlook.com
 [40.107.130.87]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-102-bBaCb5N7PViA5pElJXnhIQ-4; Wed, 13 May 2026 15:31:40 +0200
X-MC-Unique: bBaCb5N7PViA5pElJXnhIQ-4
X-Mimecast-MFC-AGG-ID: bBaCb5N7PViA5pElJXnhIQ_1778679099
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by AS8PR01MB8074.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:375::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:31:33 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 13:31:33 +0000
From: Boerge Struempfel <bstruempfel@data-modul.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Boerge Struempfel <bstruempfel@data-modul.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: display/bridge: lt9211: Add
 drive-strength-microamp property
Date: Wed, 13 May 2026 15:31:26 +0200
Message-ID: <20260513133127.376458-2-bstruempfel@data-modul.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513133127.376458-1-bstruempfel@data-modul.com>
References: <20260513133127.376458-1-bstruempfel@data-modul.com>
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|AS8PR01MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 67aa3300-261f-4d5b-782e-08deb0f3f300
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|921020|3023799003|56012099003
X-Microsoft-Antispam-Message-Info: GRUKfK3Wdmjux62IBJeShBlZDRpQz9M9cRa1Br4r1vqXEqDIpL6iyq8qnQ7wIiPOtfnsIxFOAewADiUQXE42c7ycpxaec4m1/W9LbWnWeA3GCm9ITJ0shnAsCEOaKceZQCrIB5kVyJ1qnka80X2T2f2jkNZL7DCFvNijVglO/1tAqsv1aSN5F3E3EHgxHY68osDAryCojc1p6eML5o+VsBDwrDpTO+FP/QPFf9MSPJYznoYHHnWkmorxdGktM4RKvkmgai71pvwQhF5dp/yk5wJBdyN+OeluCsFmpdyCKyE1PDfvgcEaoK+9HlxOc/yJeupix0Xc5lo2xL1ljJaw6Iz1KLnB0eZbmveHg9NXP6SKNIzyA7twswvOtIfP8y5PJIu0j4psrCB//FMjR2BdM2QdKtkQvsx6yu3gHlqoCcz38Dxtel++gUZkcfCwS9H02tpGruM1h3nVGLzl7QEhVSBy4iILoKHZcqoziZT+eysi5EtWTceQpW05xqpdHEQtZ93Jg/CGPKPTfrD6cfkpNXRpdn24pa1/d639n5R1BpfLsDLohgt0EBPQcrGWF02IaTe87N9EAGZeyulc1EGoFJ0TU9ww43c5qFeAu94O8kS26IEjsdGOd3rQdTs6m7h+oT0NKXEZehYI1DUxk4/Ht0A22PyXNfyBzBCcj0zJ44mYnPcfYl8zzl3vuY41pRZSls17U8Tu32cyp/sQcI/PB9KD76ulwx7/mOVEFgUmA00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(921020)(3023799003)(56012099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxI1kxpfSsNbbNIw7J4QDEVAkAidoPFWfx1EPieKIUn4QeK3wUYaECu6K99J?=
 =?us-ascii?Q?DKu9LhQ2fbrR1VblAcP77N4qdbozPNJtaQdPWeVx77wlzJlLYwzcs3WfsGiO?=
 =?us-ascii?Q?HShjXiuaxgsuo+gsny7RVxIxIOSzJG1sXoBuISWzEpg39X4QLerpOoi2gv70?=
 =?us-ascii?Q?404GD0Tv3PClPmA8P2EV5RGErH8Hzw+RTfXlyJt99JprvO+lmmix8zGTRXIc?=
 =?us-ascii?Q?hWmx48DqnrqoJLVsPdip2EVUtVcyRlc+Zy/nX+JDrNyF2oTHrjBCJCmzOjPq?=
 =?us-ascii?Q?cuuNtu6yu4lOxY3yQuagRF8kFQuaSomAeN+7Bhh3F2vNIRvv/g6LHgpIpzrh?=
 =?us-ascii?Q?/tgotk2/+KgTqkpVlVTYiBs7L8ydZLJjVaUplKc8BMt0bT5+3EFjoM6XSkSK?=
 =?us-ascii?Q?fbkdsv3xTLixYa0m3o54aoAke30QLVCB2RUoQd554SkZRPnHGqYUZV4sEfP2?=
 =?us-ascii?Q?GrD7aSitWe4GERGaXAKCHhMv/UtvYlw3JfFl43bB6ZVKeBiPstX6iDu9s+rg?=
 =?us-ascii?Q?gzxHH802a1ugInUoB+JJtlkVnOP3y8psAGZIXZhmrfQShCUhLsz7ARBSdxFj?=
 =?us-ascii?Q?Tcp+5JhFj20Kdju/e1hUbA1vU/YiMinlJJg0uHoiUKOjUOkmb2Fe/QzVIhU9?=
 =?us-ascii?Q?cVNcTEMZEvh/bclUSsOfVQMZDv5ew0LOMKF4tRqN4QFLRpAopk8bMjvD+zHn?=
 =?us-ascii?Q?PE/K5e9UDFJ+lobGXLhCxUqR22qHnOmoFGcxsgEY5LgrzpbcUbY2zV83ihCl?=
 =?us-ascii?Q?sNYJWOH2Pc/kWbt5OsmbgCOg98fVjIjWuR65n8+HvYNYC2KcN+l7RQQed1eX?=
 =?us-ascii?Q?fDpdvKO/+jvnsbk9vxxAMTMPHsYGUD4PIrylqufDmc33aMTtgEIKPENqs1T/?=
 =?us-ascii?Q?2m8CU+l9AZnMP3HK6B5vn5fbNBKBBumlkIPRVCtxAD1UKjGFqh0TR5cE7T2t?=
 =?us-ascii?Q?2LrCmrvhnqNpBx98m/peRisly6V4fRbSwPEPUkdOO0KCzmEx9Hxq7hvtlwWp?=
 =?us-ascii?Q?E2fqjInuyCNW/lmLbzaGIDfRWXEUP42VZiH999IRtNPi715+UmLRXJSqJnDz?=
 =?us-ascii?Q?Oes43IKJAqpwesmqkZa+ZWee6uLf1LdNHfhHxMwpoI9h1M+PSodeFI3YGCjD?=
 =?us-ascii?Q?+CocibSDhSZ8758CdNyNtkbEKmEQqESh1cHfFuEP5uHMgXE0hmTrsATnEM2e?=
 =?us-ascii?Q?TbFEX2KuuxCcBJLgX4HPw0RWAEqfUZQBSOWZFWN/CAMCiSqaVRgfrfB6LJbe?=
 =?us-ascii?Q?0A6JqR+cHuXsO1I2YtxEBGpaNU9m5V+vyMJ459nT/mB9W+mPyXjywFUKqFf2?=
 =?us-ascii?Q?aq9Ju0D4T3Svs8mMgyHijfA1qlEe1RN8Jp6OcS050w9ZNr+Wl5EYGvl30sKj?=
 =?us-ascii?Q?8otg2JiXWZqsXWx8j9DuRwKFlhWSDXYSTcJv+DE5V/9jXL84pIjIJ23quIhI?=
 =?us-ascii?Q?zWp72QENq3LsmCtvILTlx7vZLaZqzEVTZi05+Q8GPZQ1aeGCZSDDyR4fgXat?=
 =?us-ascii?Q?lE28FnFUOZrnysqcYS0dicjpnmKAb/Ym+2szZnlJNfVmOeao61McKMsnmBjh?=
 =?us-ascii?Q?auYpY1b1Y4hU/CCyyMU5xLgUedrMM84B6/R3b4uZj6YzgfHSGCxpGbiEwnCX?=
 =?us-ascii?Q?Kus3Ze387BvdVIwc5+9ZZSGp/ziUseQx5m8+laHzdv5iwneEmU6kbPLUgDVi?=
 =?us-ascii?Q?uxyquJh1XCWfLHQqCIkkfk1XVWTP4aqAdQd7E9VNcxxkdWKnmcTbQp/9deOv?=
 =?us-ascii?Q?xtlhyawEtwO1L2xcmyARUef57kU6s6k=3D?=
X-Exchange-RoutingPolicyChecked: MGzm1BkhxA89+qxG+ItncuqF6MR+Gma0BzvV0lhRX19pHirN3s4B+DI9UKk8JvXERAJpR5N3qVf9BSfsgBzgt8mWhkuICWYnzLLPgg5HNenCTcqKfGjqLAE+7KGzio875YOC86krdWdQ8OzYOV3WuQK9sMrr3N3cGQmdMIamXcMOmcZfYn5lbQpKk9VFKDGoKKKLVGKM1313MtWXaFWADwYBKL7hw/gZwI7dvcG104P2en01Wl+nL+Qm3XV7lTVbW6UFvcDcLCyr8Cz+fdnJjA11ADaow1wu7GmNqUGES5l+uzy3+x36RuypRQtN1VmH00MfVbUSpQl9WUsDA+syNw==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67aa3300-261f-4d5b-782e-08deb0f3f300
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:31:33.4612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dee0C7UHfrTe6wKETJJf0NHcu41mEsDtnIee8ULAB+396W/ordyOFV18hAPSGSgRSgG+c5dLCyi2jGoQDcsVlxZKDTTP4vPpwdOBpQnJrDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB8074
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bQYdq9zgkHms8hUlNBCk98u4WnU3_dyqcBQuim6fQNk_1778679099
X-Mimecast-Originator: data-modul.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252
X-Mailman-Approved-At: Wed, 13 May 2026 20:57:01 +0000
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

Add the 'drive-strength-microamp' property to allow board DTs to
configure the LT9211 LVDS TX output driver current. Sixteen discrete
levels are supported, ranging from 12 uA to 36 uA. Defaults to 25 uA.

Signed-off-by: Boerge Struempfel <bstruempfel@data-modul.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
 .../devicetree/bindings/display/bridge/lontium,lt9211.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt921=
1.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.ya=
ml
index 9a6e9b25d14a..381b69c761b8 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
@@ -31,6 +31,13 @@ properties:
   vccio-supply:
     description: Regulator for 1.8V IO power.
=20
+  drive-strength-microamp:
+    description:
+      LVDS TX output driver current. Sixteen discrete levels are supported=
,
+      corresponding to the following nominal values in microamps.
+    enum: [12, 14, 16, 17, 19, 20, 22, 23, 25, 27, 28, 30, 31, 33, 34, 36]
+    default: 25
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
=20
--=20
2.54.0

