Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01060A2600
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Hi/tFTxO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092D310E891;
	Fri, 30 Oct 2026 09:53:12 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0519710E865
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nxhp5wa13duuibm1sPcxd55hVcB8kK+ux1JRSYAIsAfxs/aKmkphdjlygbCXdl4oTQeb1SAl9nTQKpwSTE32h18c6YkwWdLb6+Lkk+30nsJFVL+THKWLRWdbu3tSX9feeerSrdMjqBf2/thPD0CnJEtPqWcJsG1me/r3pPul+RUo5cNeTEMvhcWlvuWh7e04euOcXIrReLKITYZP9XJJcEs7HxhbEizi9RbXfxCfTW07EE9jtsZB8RWsgt2RLyOCcawFS9UZO6wPaaGz5iwXjDig4W2ZJzPYbY6i9mLhjqjgodeqhp6uFyZWIG1eWF45khqLImcPZATrlHCcal9sEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIrbh3ffXq/7M6Ur9WnvhmIrqy2uxyth1D/4ud0L2BU=;
 b=EJx3XDvHLVSu8HvsteTc+gaFCuqGSM+WvyLebDfH90mNduSRPIcG1lAWRMr24McOdORMJezKmgcRuH0ctzhEsIAsfO95aYJJMI6dEKP/xpwHzmoDBKk1FMM5g43qvX4+hXGEF5r5dXSNbo+ddrt9GmWliLJKzB4hZfJz7IBBh0FffXAhABjgp/1kXesf0bUk3OohSSBucTINImr9df8eiIYy5aYE0FpXFRdDmOlZsdczfWRhwhtbEWznPrSMl4N50f9ggRHFaxdJjQeYgkqeGkxfcXYy6INzNqqNzJJCMMa6eoOFAqpRpHOiEgINY58mF6+4Rp/o4mAFtXAcR8hDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIrbh3ffXq/7M6Ur9WnvhmIrqy2uxyth1D/4ud0L2BU=;
 b=Hi/tFTxOfwva3jkSKBsAnHULQVsHp6Lwyyeyi/mzxHpJfszOXAl5qwkRL+J1Y0Rr6DusmDGcjqHOTLxoScx+LxsoSOnWvkTzdzebIHlIq4hD/0EcYre/6ooBSPe1Kz05eAjhvHBdBdjV9a2jymQuCCdt7C4sdrOXpY6AhZU3r7FZsZtE8DrNyeFjy25bvSWLMzseMMvzr5f+lsK2QnpvREV1WZ7m2Z3SOANZ7a66BHnPmDD0zQeNAwTDYz+zg6dKKFLdEJulC6D2pHjOetPH9OkpMY1DQIKXN7+RLPFjgiANPExOJIrsMjbXEPrjQ18Jo6oUB0WvokfhhjtWnXzUsw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:01 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:00 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:25 +0800
Subject: [PATCH v8 01/15] dt-bindings: display: imx: Add i.MX8qxp/qm PRG
 binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-1-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
In-Reply-To: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b911e85-07dd-4b42-3846-08df366b9592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|3023799007|921020|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: QC5jU/07xO5D8IXrGi0t8ckjFkGl6hGqWRRT4DWi99O7G6ajBaGtyeKriJct+KUqEYnF3tZjTRtcVkhW9GKRSIHT+Jy2vAeHnzSg9Pp2N0MsdkvJO8YXh5Yf7AUeJidGjrQ21nU0VuitUnXsmc5eBOmB57eYkg7RWa4drWQNKGjkHVbTc6FAokOnZ+YdQ4cpbyDXFuwMdZvuH73QATwmUOJ/J0RyBCiDJmoENVlNhoNIqQOdbslXC3c+a8/xhrUXJhVEbCJ2b/yUXMt0zbKPgxnUiY/TVBuuLvEBYVrtZFZDPYv0t12KFmEYb3b45vrqImNXVcyjplU3653CPB6/R6tlCzpb6YbZdaOKS+/TWp5Jg4MWFCTQmwOSEWleS8Mu2FwMzmpHIqoftHDy4zM3GZEOGzJr/zPcFRj9U1mh34ZuidIf2k13bTueJmTY+E9cu5vn4wuIRZZjmY3DgRLbHWivjNC2SlZBPEHVX+3ViYFUPgnZGBJ2HRdCFenBtUr6VWH4nAP1BNfCNOLnvjcJJ9xiCxW86J63g4h+7nRP6erh/xW6uvNnf0/5CODhY3rFIrKc9nLeNqpCJUTjEZup2UWlZfplfxtymsvnVz2C9KBsn4CXojXG7rn7BRjJqd0/CBmDchbbUJBrfilgd5THHsWX/T6JOJps2KNhpd3vQUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q014bmFZWXBqK0MzbEdUVWNkOGdoTFNpVTJwN1hvOW5PL3hkMEU4RVlMc1hr?=
 =?utf-8?B?dm0rbDBrSStWaWp0QVY2cmJtcmhrbm5IMFF1cDZ2R3J5N0VTajVMZ242ODdn?=
 =?utf-8?B?V002Rm5lR2J4eVFUaFJNSEorQ09KOFIzQWYzbkpteEpjSDF5YkRlOW11T2ts?=
 =?utf-8?B?YjF3OGZtN1lOS0s1bEdTOFRpc3RWWkp1c0RlZTREalc1Zkhta2dmS1FnVzhR?=
 =?utf-8?B?VjdDajFFWC9KSVN1S3l5U0dDNW8yL0VvOE1iSXNybDJhRmJMV2F4WExiRm1n?=
 =?utf-8?B?Z0ZHbTk5QXNwSjZHNFo3UERFOVQwV1hWVStWN1JJTURZR0E3VjZQK1loWTEv?=
 =?utf-8?B?MkRmZDVxKzI5Qzl3MFNFb0MxNVhmWUZIdThxQ2FidGczUXVnUG9oUHMyaFFh?=
 =?utf-8?B?ekt6WGJ0OW1DdFNMMk5iNjVsdFkrL0lpdHJ2ekZ2MlNNY3ZqaVE4SzFtZXJk?=
 =?utf-8?B?WUZhSitybXd6M0RVN1BQMHB2UlJ3SlBQZjc2ZmduV1NTS0dGbSt1ajRpakpS?=
 =?utf-8?B?dzQ1YkxEMkJYNTBBTjBFanpHcllwaEdpTm0xeFFqU3c1bm11T2R6ZGMxSDNC?=
 =?utf-8?B?Umc3aGowb3JoSHRveUJuWGsySCtUaUlVS0hSR3YyVm9hQ0dEc0JkOGNTMlVU?=
 =?utf-8?B?ZG8vL2tiZmowRHQ4RUxRRVFaR3RBOGZBYzdWeFdkRG9mL0V0T205R2daQmtP?=
 =?utf-8?B?dlRzWm1jdFVzS2VVdEc2YS9ITnlEZDNFSUVSSDJJV1k2ckIrbHR6a3J1bXVl?=
 =?utf-8?B?S2hWK2hqRE4zU2JKVkRIWElvSlVEdCtsU0Z2aGQvdFFRY1FqL1RqckJJVmht?=
 =?utf-8?B?UWgrcCtHVC9XMTJwWktUL1l4elcvZGxPTzVnelNYdXZHbGVRSmpUTzFwdkhy?=
 =?utf-8?B?Qkl4S2hudENaWG9rcklPdmRWYVVBQVE5ejBZTkRQL0ZmcnUxYkx4WHlDVGFu?=
 =?utf-8?B?cU93emVkc1p1ei9xVFZpWmVuZFgrRmFGVVl4Vlk2V3dobUNiM01IdHB4aHhm?=
 =?utf-8?B?RE5Yb3JaUm9JZS8vcHVCTXVWQUcvOUVmUXpNUFgyQ0VNM0hyY0REOGFkbWtC?=
 =?utf-8?B?N1ZjVkR6UHVXMXhXTHlRWllMQ1FNRzcyUGxRSm5sVVlDRG1UT1NpNEJvRWhY?=
 =?utf-8?B?b3lHTVdnbmFmTWNPMHNqZk9yZWh5NGN1YXpMVXVoZ0xieTdoTUdMa0JkUkJQ?=
 =?utf-8?B?T3lrUkxhcUhrSHFuTzhNVHZGVE5JcjVPTEdQRE5kUWorQTJVOUFWYnBSaDE3?=
 =?utf-8?B?bXBsZGE3TGd0U2toT0Frc2tQTUVjOW4vOUhQNE44YXZ6TkFZWnpJaW1lcGN0?=
 =?utf-8?B?aHVVamxsei84MFdzcWd0S2RjRDNYMEh4MDQ3RU92N2luYzJocHBNeUYxdDNY?=
 =?utf-8?B?aENXcHRHaDN2V0tSK3lqTHp1T3pUcHY5R2kreERGUitxM25XQStZWkNiR3Uz?=
 =?utf-8?B?WG1GdzA2YXgyNXVhMVBJSXE1TFFqYUp3UmdzUytTOCsxRkV2d1Bmb2FHc2Yv?=
 =?utf-8?B?MlpZOHVWd3FzTXEyZzJoOW5Lc25COGp1Mzh3U3Q1NWJtbnZrY09YWEJIaTRi?=
 =?utf-8?B?MnpzMlhtTzdKUkRTam5xZytRcDRJWVRQbEZHTWpZazFqcCtSVFpUbkRCZW1s?=
 =?utf-8?B?QnBhSy96b0RvdzRIRGtuK1d6SjRqV1psR05ONytWdllwcUdsM0RMZGVzNnVh?=
 =?utf-8?B?OFpmYjE4M0RQR3JPSDRjWHR1aWtvSVBmYlpCR3Y0bHovUXhTaTBvQUgrcHdM?=
 =?utf-8?B?Z21ZRlhSK3pYVkxxblVnNDBidms1WjdSemNVZXJHUS9IY1gyRVFPcXBWZ2k0?=
 =?utf-8?B?RDBtdEJEYitBVjl3amg4SVhNaVp1a2hRVjZ5ZWRNbG5BcjRnWVJtN1oveDR2?=
 =?utf-8?B?UGhGV3F6MWhZZGtvY1ZIS3NyeGNPSUh3d1ZsNTF2ZmtVc2xleDVvMVl6eFZ1?=
 =?utf-8?B?dDFtcUxpaUdLUDFGVXBURERyVzFNNXk3djAyNnFOb3kvVUFzRXM5bUtzaGRE?=
 =?utf-8?B?dWUvUUgrMFFZQXZtcGZxYXZhbFhnb2RKKytaN2kySVZFR1pZQUhzKzZXK0oy?=
 =?utf-8?B?eGRoUjlMc2hxdW1IYzRLdGFUcG5Ba21wMEt3YS9YNVFpRS80dHpIZFRUVGEr?=
 =?utf-8?B?UDJNNG1XMG1zSGxuQzRLUHgzcnFhQ2tuZ3NwNjZSUDkrNTV1NmtHSTUyQmFH?=
 =?utf-8?B?RUxOMDE0TUpXcnZCMDJYL1k1Q2RUV2E3dEplVzBNaTJGOUNVUERFa0tKU1k4?=
 =?utf-8?B?dEFxQjgvQjhyanVaZzMyYWtvcXljQzcwTFJVNzFCOTRqSjdwQzJpemxtRC9o?=
 =?utf-8?B?TVJKeHV1bEVqU0gySmtLanEzczBsVk5jaUhNanRHRWM0dEJUVjdadz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b911e85-07dd-4b42-3846-08df366b9592
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:00.9389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tan6Rnend89CmEUq7MhVqZRwCA9MOfKsmLqG81YsAcz9WtyaY1G2tRFEECJ8Tji087CqLPckcEpxmkw+0FYYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB839208
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

Add bindings for i.MX8qxp/qm Display Prefetch Resolve Gasket.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changed commit message to use imperative mood.

v5:
- Add the DT binding file in MAINTAINERS.  (Krzysztof)
---
 .../bindings/display/imx/fsl,imx8qxp-prg.yaml      | 60 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
new file mode 100644
index 000000000000..3ff46e0d4e73
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-prg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qm/qxp Display Prefetch Resolve Gasket
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  The i.MX8qm/qxp Prefetch Resolve Gasket (PRG) is a gasket interface between
+  RTRAM controller and Display Controller.  The main function is to convert
+  the AXI interface to the RTRAM interface, which includes re-mapping the
+  ARADDR to a RTRAM address.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-prg
+      - fsl,imx8qm-prg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: rtram clock
+      - description: apb clock
+
+  clock-names:
+    items:
+      - const: rtram
+      - const: apb
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    prg@56040000 {
+        compatible = "fsl,imx8qxp-prg";
+        reg = <0x56040000 0x10000>;
+        clocks = <&dc0_prg0_lpcg IMX_LPCG_CLK_0>,
+                 <&dc0_prg0_lpcg IMX_LPCG_CLK_4>;
+        clock-names = "rtram", "apb";
+        power-domains = <&pd IMX_SC_R_DC_0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a08087fb6e67..d9a6bdc65826 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8806,6 +8806,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
 F:	drivers/gpu/drm/imx/dc/
 
 DRM DRIVERS FOR FREESCALE IMX BRIDGE

-- 
2.43.0

