Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040B606A338
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ZlMnbLpb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E175110E6C9;
	Fri, 23 Oct 2026 16:49:56 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010025.outbound.protection.outlook.com [52.101.228.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7022D10E0D7
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcodehTvh7WNdmLsAXN13R2IE6Os+Jc7vr0D9wcEDrx7lLyHvPMFHjvTiIuoMeF6usAn7wB6c5RtpflVHxppErMEKJjtCfjfgsdArFavlHZuWCj7FlFgr6tePFEI3zJS8lNPsrLIzL50min4O0jucGcEkPDQeiTAYUhJNXWN/56p+jCmfxJIYMwtBZyNaJxe0zOkik8Wd7pCENzmhfMZpUNo186r2nE9M6DHFVzNyBGH08tnIe9YyPvwqfBz6QxPXCbyoMC6PuDsYkubqUfBGu/Q3+NUhu3ZRUvdYGcuMZlesq7ZHAuBv7JfVkIfFQE2+FoX0fylLNi3fa82XXUywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQGuIfbxxHL1HerqgsQBATby42hXLTAHBZDOjc28p90=;
 b=noVjRFeqsDuQIchZjpibrToZkMpmJaCpjQ5//GPGW1F7cSuqdGyZGADZTe9KgaU4HeN0Nn7A5Y/9A1+G95lEzlqXquZ1lxWXshz/AuFWAlWdwAjx+gJ4nlvujpzcarOm8muPsotQpnW5D6JCkhmi+6g9ReNodpLIqJGaLYaO8qjSikxhinRWPCw22dGi9zayfDTshaNydDsW9f9N9AhSDcg03E/WMnE5OZNpImlrGKowARwgsRy7tMRfIQ3hDJyJKeD5IeR59znzIaKnvrh2Bi2QL+xQ1JS2hJBH9YoRmkBEIERp+ZElgcUWbR8NVV7mOoGjo1XMzkNH6cFlSEBRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQGuIfbxxHL1HerqgsQBATby42hXLTAHBZDOjc28p90=;
 b=ZlMnbLpbIMcoSF23qOpAMnv39YNwkBApfcgdBZRO8j5KR2xIZe7FUDRSUa0QGO+5s7ncVqHt5iWXW4FDBM8LMQ7k/dSIHVtkRJgh9h0G3MaKD2xsLv7C618yLMf3kvFLDLfcqa0PrNpASOV/3EsScjO1/x+wmDnMG2YgAdirmLo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:48:47 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:48:47 +0000
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
Subject: [PATCH v9 02/10] dt-bindings: display: Document Renesas RZ/G3E
 display subsystem
Date: Fri, 23 Oct 2026 18:47:35 +0200
Message-ID: <71044c23cbd6698d495db101527725bd7607197f.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS3PR01MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 30872735-e25d-4e37-6ca5-08df31258204
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|18002099003|22082099003|5023799004|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: SblAvkdnE1r4MjJlV9ksG2cQKq0sHm00no4GOYu1NrLgn00chsshdyR80lXZoJ/jVg4N/8cXQ7Ux1ASWOZFQE8x7+wACJFR1Ba9G9u2scM0QjlDICJ1cCIDlyUYIDuld0pQlu4HnethakingtDPB9YQ9MNxSo/j6EvbQ3Ze6zUfbAaqPFdueB4ehvqlKtsiFdRAHrpGoD8VrDL+57GW7UupvWiS72n8q/CdX7hIQRpUco1rLctZ+oTSabcigp/YCILiPWOx/jHSJ4g3Lz5nFpyOhb0c0j4yTmWKfDtEDKddlyT32AVK/qkeNGtvPJmTif4fii4CWx/rqoyB+T0YIeHzBCMN+eicXq+6GB+0OLP4QpnSYcmt/rFOQmrFSAmZMTnJW2bmNhoukCLWCza32LDRVgNUqvsla5rQdGLJ+CxM8SMhZejuw6rWEsDha7yFYXsIZoinoYBd4yCyhYg6ZbhNGQ+eFlw3j/IlyEPoBNmqC+Q4zxWNOI2R3W2l13WzcmzP9orCdusv3FOzmSA2iFs7qmtrO6eu6Id3supoiJcAf6Ws13Ilw31GADWpZ1+Yedd4yhID23FdSatrGLJaDroLr3tT20PaxborbSJBXZrazejHVM6u9/BcQxTi+67ytySec739PG6fA8NV4fcF+SoBPlu2Rm9S4RzXw/+vU1B4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?syw8BIRreFVyQDk7nwzBskkAPO22elNNMlyeLy0uhrz/19NLDjHTlr3qZtKv?=
 =?us-ascii?Q?gwg0PNueTGm62d/je8BiKUHkPDrqeyJWuFM4eM5dBpFYWYG/pUbURGUC2az4?=
 =?us-ascii?Q?yAB7qnQ0IIJrZO224oBuWOv5ifRfGeKz927YrvA0AK/fCzeJW2ie4smKZcg1?=
 =?us-ascii?Q?j4HSJK4q4Y7ATH80beAFv4urc8wK5AkwCb6jxakNblN43DhrHLIIIQgLhgsd?=
 =?us-ascii?Q?I4y0VUBr9vkVB9EfD9HN/3kEVvNnOXYSwYk/J/5k2FgtHJAbSKB8roGS+Kxi?=
 =?us-ascii?Q?4i3YAIQ/QsR3SC+AwHrBJy+L9OA4KRiLIX9w1Qlik8QhTi343wxNHvtMS1k6?=
 =?us-ascii?Q?lyvUMcNVZftclpZeTvrrH014vAHOFczJI5dtZaC6jG1Vn+jyOTIf8VABpCDo?=
 =?us-ascii?Q?O+QUga6B0e2F/KlKscIBh67g58hJ5Eh+XPsVnP1Wu1rI5ZOO5gjjIYdvFoqI?=
 =?us-ascii?Q?pRwLc8Qg9WY2OdWBlgwLF+FZQDAOpWY/mSitdDP5Ro642aI154jhQhvgYAgI?=
 =?us-ascii?Q?8LAtDS1L5Byrk352p5g5OeSz62ak8mJFNxk+f8yDbfIwaNfLhxT66FpH56G9?=
 =?us-ascii?Q?F6uvq8+4IAVqydPWgUQzz0hLepRJuvvzz8euSpcd0s4FfQiIJpZXDweuhawu?=
 =?us-ascii?Q?hYlaWGA4mycREFUreuMkjGLz+6csEGqtR4Pm1eqLJKGycU82gbarubKV6khv?=
 =?us-ascii?Q?8cM+Wz5Kj+gsrT3Gqr2dC/Y9vzq0YM3QMkfDx3PmMqAwi406FQ5Si7s5/KXF?=
 =?us-ascii?Q?dUm3JJ/W+KeOoC0Dc5G33MGefsbXW/Vjb4hE+WXjCHq0zvHccs9SVTRlX2Lr?=
 =?us-ascii?Q?HAKf5VVk4bz/Db8T79v3Ih/q/3dcttEAVD7uTZvfaniNLbqhC5LFgivLOxzj?=
 =?us-ascii?Q?tmaXnKgHEqW6UDS8ZEOaaxe5RTohHml2fyk9QOb7reo5AFq2eh/o5YZ7eNKv?=
 =?us-ascii?Q?ydZtrRcLmZKVU7mOAbjPPyP563tvbcKk8f64ut0TI83Jz+LAsJEyxk9z7kMQ?=
 =?us-ascii?Q?xR+eK6pZ79JEhY9JUZEXRMtFWDoMi6ySEWUGaVz2JJ1/7vQRoLnmMqY6NbWY?=
 =?us-ascii?Q?I4mlPFcSow4ezM0ikKzre1GKOSXOpt/yp+12qhojxY/s+r1gp/nwc243feU1?=
 =?us-ascii?Q?UuKINaVoLWiqqiAu3HPRxe4pecxWBBINZvzKR6TjBfasyhSn6wlpLSTU6/uH?=
 =?us-ascii?Q?LaYgxxMVibxWxAaat5YlcrfoUsLOeZDlSkLMb/bEGMWYN8ASE9TPV1/JEMyn?=
 =?us-ascii?Q?gtYy1Edkpcnj6WWeVr8TjhV5+aywVqv90Uzr8qg8qSlFoX8sPvMMFsXPjRBH?=
 =?us-ascii?Q?L644RLoeNXQB7ivrzNF3cvb9sNlkRdwJwpmxzy4q3N+wWkhif/xjxfdrnAG3?=
 =?us-ascii?Q?TJNBfVRufl/7dEMznAZ9o6NqXRbWPOHzMZnBpX6mPMNL3VYQt2NCicWdHiWj?=
 =?us-ascii?Q?L/YQUSEATwS0QjYS3EZliKNu9XQoK6HUjs6U7sq2j/WdhmhBeeYGlcQrAJVc?=
 =?us-ascii?Q?3dOfIkVcQjtRJMFhfhgSS79wrfSkfoWyKmoDueLClRIg+b7myI9tdwxyR7EH?=
 =?us-ascii?Q?H7jH3nHMAAlYzE0vqNGyBtQ5YWIDQhOV747XF55YyiCGjg1+m6n5GSOcytyQ?=
 =?us-ascii?Q?E3IU+Pk6DBGJXvH7mmhhd/rajbzmMKFZL8teULwzuXc3DoCQDjcuccoJ7v8n?=
 =?us-ascii?Q?6gBZd0jhM0AssRD9CzeeCDt4ZvXzkkAUa8og5hdp3Dr9DcgRToBUREnkSdrR?=
 =?us-ascii?Q?GDFcj3/oR7WjkNl0Tiay6c6FqVplGz+Klfx4dmD38sDhbI/Hd83s?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30872735-e25d-4e37-6ca5-08df31258204
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:48:47.7993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2dWfboJ1CoJltgDOytPIqvZ5SwhjJMNlZAvbPIrG998goVd/0ny5jKjJPg9dtkswADKx818gr33bKOcIJRkkCwH5eNeX/a4N+CjtVoGi1W0o7Q9No0UT/RNnaGZL9NP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9415
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

The Renesas RZ/G3E (R9A09G047) SoC has two LCD Controllers, LCDC0 and
LCDC1, each containing a Display Unit (DU). The two DUs are separate
instances of the same IP, with their own registers, interrupt, clocks,
reset and VSP, and are therefore described by two device tree nodes.

The DSI encoder and channel 1 of the LVDS encoder can be fed by either
DU, the source being selected at runtime. Driving those outputs from
either DU requires handling both DUs as a single display subsystem.

Document the renesas,r9a09g047-display-subsystem node that groups the
two Display Unit instances.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - New patch.

 .../renesas,r9a09g047-display-subsystem.yaml  | 44 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml

diff --git a/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml b/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
new file mode 100644
index 000000000000..e23cc53a1fea
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/renesas,r9a09g047-display-subsystem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E Display Subsystem
+
+maintainers:
+  - Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
+
+description:
+  The Renesas RZ/G3E display subsystem is a virtual device needed to list the
+  Display Unit instances that comprise the graphics subsystem.
+
+properties:
+  compatible:
+    const: renesas,r9a09g047-display-subsystem
+
+  ports:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 2
+    maxItems: 2
+    items:
+      maxItems: 1
+    description:
+      Should contain a list of phandles pointing to the ports node of the
+      Display Unit devices that comprise the display subsystem. Display Unit
+      definitions as defined in
+      Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    display-subsystem {
+        compatible = "renesas,r9a09g047-display-subsystem";
+        ports = <&du0_ports>, <&du1_ports>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 04f465490612..2f4abeb594e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9110,6 +9110,7 @@ L:	dri-devel@lists.freedesktop.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
 F:	Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
 F:	drivers/gpu/drm/renesas/rz-du/
 
-- 
2.54.0

