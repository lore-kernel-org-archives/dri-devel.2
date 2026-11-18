Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D0606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qF4RgSeg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F05210FBA7;
	Thu, 19 Nov 2026 07:48:41 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011027.outbound.protection.outlook.com
 [40.107.130.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408AD10E806
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUX/HTATZMRTlx4dhee5AMqnM+ARDrg9i8dqq3ZK9OqVKsGbFfb9bCORFZ10tj2Pdk+JlhimsJTHQXwrdSrR6qOYiV2o2R6uiY6opeJUb4YTqYWt6FkhkcDpAF1IqkKzPy8ZysJIXsB/0adY30zjyVfJq/NMY7OOnnNp0j/hfJF2lUUs+z5qFIMM/gbFyUWQmgpmok5IcNlLWMgN9gzeyjE1PR7VVA6x+HHjofLOIRAJaJ2CH2tsfiiMZzf16X13hbPt1Z2M5nf/h2cMrPBEJPxIC81HImTxDZBuivSgR7JhqF1c2lMQX+ZAqKxpyTXvcgywg7nEk7xjHZc/xr4VZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J3xe2t5kut9oDt9oHBCLvCsv0gbBmqmVWj0JVVNs6w=;
 b=FGMSE6fKshbXBE63Vf1YeJlYnNTHsgvyZq11ymq2vogwZjsMdI9NYshyY36uxF7JjnHc1E286b/4HQ7UyFdpkwbppeE9p/66Iwy9XkMdRLadG4+18nh5GTDcwgBauMIYPLmLzr9OOhi/M8FgxPg5iLloEtrWhRJBFYDnxroscuvzEAOPGDZMZ+OC5YGL24IsdAbFEZvexlga6byUGe76JQzToJiPpyopj1vpt4Ac++2r1s5OP4l4o2B8nsu3CG3ZMCjn6wPALWqzgB2jj/7DTlzOQ2/VkkKuumBK6/sYkdTbfnFFze8oxguR1HU/2zWnsV4Cxce4g2U11MbvNGmaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J3xe2t5kut9oDt9oHBCLvCsv0gbBmqmVWj0JVVNs6w=;
 b=qF4RgSegKcgrYG1AG07dZ6LillIwefIVSgXqJ4dXpf2hfEzl73zwAO7SeUDggUaqjzWEnul5bmJyuN3ZC9Id3mSYctgoh0UMreFdbMSu6ykICk0Q/KN4eJjCkI+K3XC2kmqPAo046i1KO5DloJt6KtBeFzgWqg9zGTEErbwdbSMyPrBOZma/u9rr7iLh6fjZaO6ewoAcPZ444w9oyCKqJUXm0thyVd75XmMy2W1saWRHaVSbiO2zXinia7gds+IxWqzpuXWB4Qu2fuF96PfuVi9dD0Fv8p2bHAZf+ewxxWY7yhVtywZPc1UXEoRTdZ82/vlh9lJjwowdVmY+wOVQag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM0PR04MB6977.eurprd04.prod.outlook.com
 (2603:10a6:208:189::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 15:22:06 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:22:06 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v12 0/5] Add support for i.MX94 DCIF
Date: Wed, 18 Nov 2026 15:21:51 +0000
Message-ID: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260602-dcif-upstreaming-fb177f3c9351
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0008.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::18) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM0PR04MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ba1cca-16e7-4ba3-e1e2-08df4587b494
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|18002099003|6133799003|261009223027099003|3023799007|921020|11063799006|261026140227099003|56012099006|261026121527099003|10067099003|261021121427099003|261022113327099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: xZsw3eyuu+qESDgkDJjc08srw/MfsIwkt+g/IZ/kf6GiMZfccPgHrWQh6zozyJj71AaIP1APn4Tda91Vywfl13ady7SP+X9MPKgCXgFcoUJC5Wvdzh+sTnZzEuSlnP8KVgTIAYsE625EWSUCD6ZUKDFSB6f63wJ7OVP7dhSFur5Rv1LQMXwXJXGYADq5LZBAy9WYlELnA/6OTgoInUX5jgmpl50kw7MmN3Ce5pU1SUX9BrUIdkyaFPDdOrSH1OYSDWi1MEYKUvdu4LKBQutzKcxV+zxAkQDq2hY3xYoUySUIeBNp/hzafzkFb/u0JzDfYv4v+8HpLr/1srm6BcqG68D//SatbYzv/0RdyLAZ2outjGObg4PlKuYdzFGBZs104Gnber7e3ZawJPpcbLqoOx+kzUGDQ4qqIRyRQc4+KcvLhUJHad8frSRnu+RgEFbZb3GMg2E1FfS/CRhgKSwjy7O/NRyxqmyq+Qexk4sfJPoVDbvg/opMJzqe0TNds/ctqmX/O/b1rk1XOmYfXU8kJ5hfbIM6mQACXE6NvLmTqNx4rUoOptSHWz/2trQAOqlGzFgNimAl1qWEfgCAFw5IvPDnlO6TSoEvTzoAJ8MnlcscMQ/0P4xjDy6Xcq+ytToJElrxBDpzC+edxqIrWi/7/EXUNKQsz2OHUIdZALOygpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(11063799006)(261026140227099003)(56012099006)(261026121527099003)(10067099003)(261021121427099003)(261022113327099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGx5eC9Xc3FPSkhFaCtkUXJiZzdXRUZ2dVg5NnhCemdEWHZhSXpZUjFodzg3?=
 =?utf-8?B?M1hiVW13cVM0aXpteG5BMHlSTGVZVVFrdEJIY0xYZkpMcHgvQi9XMTNTT1ZN?=
 =?utf-8?B?YTU0blpxM010cnJTRUU5aXpJMkdiV28rVGpFTUV2VUFZNlI3UjZyZEt1ODJB?=
 =?utf-8?B?TWN5Q1phZVNEL0hEaHhOTW9pNGk2MHcxQVpTMWVpVk1mSGdmSWFlV0kwT0Nw?=
 =?utf-8?B?RTBsa2t4Ykovb2R4S0xLYWV1UVlrbzByZmZGb05BVFpMN3hsMjJKY3lHYlV6?=
 =?utf-8?B?M2tqZldmUVg4cVh1dmN6N3RBOTk1b3NtOGgweWw1RmdKN0ZNNDQ3S0lRUU5r?=
 =?utf-8?B?Qkw0UmF3YldmeER3MExWempRNE16R0ZvcE5QUnU1QUx2UGpPMXMyU0FNWlNN?=
 =?utf-8?B?WTBSTnhYVW0wWFI4NlB2dGdJUTRILzIyYVBFOUd0bHRITDVWZ2lJbWkvNWs3?=
 =?utf-8?B?dGY0YzJ2RWFmczlhdXp0bkZQaUZkb1NDV1U5bFpiclhIQlhqZ3pCRXhYMi9V?=
 =?utf-8?B?akFNR2FRSjVXcEN1N1EzTkVpbzRIRm9KNzBCRUp4eDdJMTFHenFOTzBnOGhK?=
 =?utf-8?B?UTVBVlp6bTB1T3Z5SkM1Z3NPMkw2RzRONGFXY1pldDRRV2NmdWY2NkdZQnhv?=
 =?utf-8?B?K2RyY0xZOXo5cTEzdk1xcEFXWHJBMFZRbEl0bWJJa0hxa0h5TytUYitNWUJh?=
 =?utf-8?B?SmNHVXltU2hGRmc5OFg1ZnZLdzNWdU02RUFXaFBzN0xWV3hkd09Reng2NlpF?=
 =?utf-8?B?ZFhYYmI3dTRkU09MMkFhc2lGVXpyTVhaRURueXlDNjA2WjRaem83MUZIM2F3?=
 =?utf-8?B?aTVqVUNHT3JYdkxIREE1SWlSODRBVUNoMlRSUmhhMHMrZTBaeHo2NnA5aUkr?=
 =?utf-8?B?S2M0VUg1WC9URkYzeDZRYWpEYVVocE1FZVVLRlhPQktDeHRnZ2VIeTA0d0Vi?=
 =?utf-8?B?NnZoekVEUzd2ZTdZZ1BwemNJNVhvRnlhaFBjMjJORXdmajBFUWRTSjFmb0Iy?=
 =?utf-8?B?c29vOWllR2lZM1owWTJrQys4YmxVRGpFQTNMckkrYmdtSmtLclVWN1VZeGkx?=
 =?utf-8?B?dHpHS0F4R3AvK3pQeDF2bjhhYUo5U1JJaFZhVDNDMXhHNEM0TW1weFNnZ1R5?=
 =?utf-8?B?cTRKekRMcUFzR3Z1cWljTzE2b04xYWhKL0htWW02UzluODZIcmg0SzVEaWp1?=
 =?utf-8?B?M1hYVWRZVHB1WEF4UEFvdmZIQkt2WDhyS1pqcm00cDIvVUtVd1A2eVhsOHNC?=
 =?utf-8?B?WmM0UEdmODRkYWtmQzJHek9JaXhqTjNCQ2J4KzhLT1RMWTMzSTdwQlpJRytn?=
 =?utf-8?B?dE9nQzVQdGRoWnNObHdFYzVVRTYxZi9Wa3dKdHhGdXZseXNXZ2ZuSWs1NUVI?=
 =?utf-8?B?SldrWW9oV2ZvRkRKdFBlN2U3YjEyb3p4ZDE1bVF2c3N1eXlnclUxSVZacXZy?=
 =?utf-8?B?NlZVNWV4ZXlZLzdUb3hqNnlvU3luU2RwQjJmMUpjZWhtWnUvN1dScjMzbkFy?=
 =?utf-8?B?SUFkUFBjeW1lekgwNXB2NHZvd3hGTk5KV0pxU1djb3dxMHdVMnozem5jbjBE?=
 =?utf-8?B?SUlsaHgrVXpwc3VwVUJvNnpKQ3pYQ2Z6R0tVcVF0UlFmKytMTEovSm9oenNE?=
 =?utf-8?B?QkIrcVZlcUhUbkpkMkJIT1JhSTB0bGxuZ1UxZXdQdXNMVFV1YTF0Z3JpK3BF?=
 =?utf-8?B?YWpyUU4yTDBpRnZURVBZOWtuY3RQMThHc3BrekpET2l6eXdPVHA0SjRpUFlj?=
 =?utf-8?B?bkxmb2RKVmNaMC9lRWI4Z0hvV1V1WUV0SzhDMjV3cU1BaTdYR21OWFg4RFha?=
 =?utf-8?B?S1RrRTd4ck9PaE1YYXpMZlZQR2N4NXdoWVNRbjV5VUV3SzNEYkE5dGV2SXZa?=
 =?utf-8?B?c0VXclhNQ1lLelg5TERTZ3JHamxTTnRia3JwWW1Zc0J5Zm8rR0lPWTc0NnI0?=
 =?utf-8?B?cDJ5YlJuamRUenJNNk41L0tIS1lBQVdOZWQ1d0Y2ODZuVDl1bWVuVnY4em1z?=
 =?utf-8?B?TklSRzVwb3lob2t0Z0gxL0FsdENSZ09XRkFKQlRvc1lCdFlkakxTRjdXVmNy?=
 =?utf-8?B?bjF0d013cVlhdkZ6aEdyQTMwN0F3dHFLMEY0RS9rZlNSbEwzSmNLSUorb2VQ?=
 =?utf-8?B?Vnp4UDR3WE44YlBoM1g1OEFnMEJhNVp3d1piWnNaQnFDdkFLVko2Z1pCWlZm?=
 =?utf-8?B?QVNacWZKUFdORU5seHdXM2s3bXM2Nnh4ZnpUODZhWWp4eEdFZ0FXYzNUaGJh?=
 =?utf-8?B?Q0Zld2hOSU1DTG9TVWtiaWZGRlpJRTFVRVYxRjlXVU0yWEkyOGcxa0VGUkNx?=
 =?utf-8?B?MGlqZlYxRnRsTDNXVVFCZWtFZC9Fc1N5TWV0WDkrcDJmUGxlVFNpMWpwamcr?=
 =?utf-8?Q?vbs8HLnktP9HI/i0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ba1cca-16e7-4ba3-e1e2-08df4587b494
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:22:06.4972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3R7NYU3BRZEslZR9Nrp3w/gNnaoJf4ZT/mVwPrKxXjvcGqLBqAFvNY7Gk1nzAZ5sbKsnh4jj4Al9VsuE2NVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6977
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This patch-set adds support for the i.MX94 Display Control Interface.

Thanks,
Laurentiu

---
Changes in v12:
- Rebased to latest linux-next (next-20261116);
- Dropped the fsl-ldb patches (v11 1/7 and 2/7) since they were applied
  to drm-misc-next by Luca and are now in linux-next;
- 1/5: No change;
- 2/5: Take a vblank reference while the CRC is enabled, otherwise the
  VS_BLANK interrupt gets masked on a static screen and reads from the
  debugfs crc/data file block forever; always stop the CRC when the CRTC
  is disabled (Sashiko); in the IRQ handler, only handle the status bits
  that are enabled in IE0/IE1 and return IRQ_NONE when none is pending
  (Sashiko); reject negative ROI coordinates in the CRC source parser
  (Sashiko); propagate runtime PM resume failures from
  dcif_hw_probe_init() and call it after KMS init, so the hardware is
  not touched before the bridge lookup can defer and before the
  supplier device links are created (Sashiko); reject framebuffers whose
  pitch does not fit in the 16-bit CTRLDESC3 pitch field (Sashiko); use
  of_drm_get_bridge_by_endpoint() instead of the deprecated
  devm_drm_of_get_bridge(), and drop the DRM_PANEL_BRIDGE select and the
  unused drm_panel.h include (Luca); declare and initialize the __free()
  bridge pointers in one statement (Luca, Sashiko); allow COMPILE_TEST
  and compiled DCIF with allmodconfig on i386, x86_64 and arm; update
  the copyright year to 2026 in all source code files(Luca);
- 3/5: Collected Rob's r-b tag;
- 4/5: No change;
- 5/5: No change;
- Link to v11: https://patch.msgid.link/20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com

Changes in v11:
- Rebased to latest linux-next (next-20261109);
- Dropped "drm/bridge: fsl-ldb: Get the next non-panel bridge" since the
  driver already gets the next bridge after upstream commit 802372cf316a
  ("drm/bridge: fsl-ldb: don't create a panel_bridge") (Luca). The
  remaining cleanups suggested by Luca were sent as a separate patch,
  not needed by this series:
  https://lore.kernel.org/r/20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com
- Dropped the standalone MAINTAINERS patch. The entry is now added
  together with the DCIF binding (3/7) and the driver (4/7) to make
  checkpatch happy;
- 1/7: No change;
- 2/7: Collected Luca's r-b tag;
- 3/7: Add the MAINTAINERS entry;
- 4/7: Program the plane registers (format, size, pitch, base address,
  layer enable) only from the plane update path, no longer from CRTC
  enable; arm the vblank event with drm_crtc_arm_vblank_event() in
  atomic_flush and drop the driver-private event caching, which fixes
  the vblank refcount and early-event issues; on probe, mask and ack the
  interrupts left enabled by the bootloader, and request the IRQ only
  after KMS init to avoid a NULL CRTC dereference; dropped the unneeded
  mod_devicetable.h and drm_fb_dma_helper.h includes; style fixes in
  the of_device_id table and platform_driver initializer (Uwe); follow
  the reference manual software reset sequence: wait for the DPI to go
  idle after clearing DISP_ON and hold the AXI fetches (AXI_RD_HOLD)
  until the pending reads are done before pulsing SW_RST; stop the
  controller at probe if the bootloader left it running; add device
  links to the display CSR and the LDB to enforce the suspend/resume
  ordering, which fixes a vblank timeout after system resume; include
  <linux/bitfield.h> in dcif-reg.h; in mode_valid, reject modes larger
  than the mode_config max_width/max_height and modes whose porches or
  sync widths overflow the 12-bit DPI timing fields;
- 5/7: Renamed the 'ldb' child node to the generic 'bridge' node name
  (Conor);
- 6/7: Renamed the ldb@4 node to bridge@4 accordingly;
- 7/7: No change;
- Link to v10: https://patch.msgid.link/20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com

Changes in v10:
- Rebased to latest linux-next (next-20261005);
- 1/9: No functional change;
- 2/9: Switch to using of_drm_get_bridge_by_endpoint() helper for
  fetching the next bridge;
- 3/9: No functional change;
- 4/9: No functional change;
- 5/9: Fixed a pixel-clock unit mismatch bug, ROI now derived from mode
  at program time, CRC reprogrammed on ROI/source change, bus-format
  validated with a whitelist, forced modeset on CRTC activation
  (dcif_atomic_check), vblank event flushed on disable to avoid hangs,
  dropped PREMULTI blend support since PREMULTI is not mandatory anymore
  and the display controller does not support it, probe error paths
  checked, shared dcif_set_csc()/dcif_plane_disable_layer() helpers
  introduced;
- 6/9: restructured to reuse the existing conditional schema pattern for
  the new nxp,imx94-lvds-csr compatible, instead of unconditional
  properties. Dropped Krzysztof r-b tag as it needs reviewed;
- 7/9: No functional change (context shift);
- 8/9: regulator nodes relocated/renamed (reg_1v8_ext/reg_3v3_ext ->
  reg_1p8v_ext/reg_3p3v_ext) to match existing naming convention;
- 9/9: No functional change (context shift);
- Link to v9: https://patch.msgid.link/20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com

Changes in v9:
- Rebased to latest linux-next (next-20260611);
- 2/9: Reworked to store the next bridge in fsl_ldb->bridge.next_bridge
  (taking a reference with drm_bridge_get()) instead of adding a new
  dedicated field. Removed the r-b tags for this patch since it needs a
  fresh review;
- 3/9: Fixed the i.MX94 LDB max_clk_khz limit (165 MHz -> 148.5 MHz) to
  match the actual hardware limit. Removed the r-b tags for this patch
  since it needs a fresh review;
- 4/9: Added a 'required:' properties list to the binding. Removed
  Krzysztof's r-b tag for this patch since it needs a fresh review;
- 5/9: Renamed the CRC source helpers (dcif_crc_source_*) and made them
  unconditionally available, dropping the CONFIG_DEBUG_FS stubs;
  improved CRC source parsing (auto ROI for the full-frame source,
  unsigned params, safer string handling); rebased onto the
  drm_atomic_state -> drm_atomic_commit rename in linux-next; reworked
  CRC/modeset gating with new has_crc and crtc_pm_enabled flags and
  proper PM error handling; switched event_lock to spinlock_irq; removed
  a redundant connector-attach call and fixed an error format string;
  added new pixel formats and full alpha/blend-mode support;
- 6/9: YAML quoting style fix only, no functional change;
- 7/9: Combined the former "arm64: dts: imx943: Add LVDS/DISPLAY CSR
  nodes" prerequisite and the "arm64: dts: imx943: Add display pipeline
  nodes" patch into a single new patch targeting the shared imx94.dtsi
  instead of imx943.dtsi, removing the dependency on Peng Fan's
  not-yet-merged patch;
- 8/9: Renamed the IT6263 bridge node to 'hdmi@4c' and fixed its
  reset-gpios polarity to GPIO_ACTIVE_LOW;
- Link to v8: https://lore.kernel.org/r/20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com

Changes in v8:
- Rebased to latest linux-next (next-20260303). Patch 2/9 had a minor
  conflict bacause of a patch introduced recently;
- 8/9: Fixed CHECK_DTBS errors reported by Rob's bot due to missing
  regulators. Removed the r-b tag for this patch because it needs a
  fresh review;
- Link to v7: https://lore.kernel.org/r/20260122-dcif-upstreaming-v7-0-19ea17eb046f@oss.nxp.com

Changes in v7:
- Rebased to latest linux-next;
- Addressed some new checkpatch warnings: kzalloc -> kzalloc_obj;
- Fixed a couple of static check warnings in probe();
- Added Luca's r-b tag for bridge refcounting;
- Link to v6: https://lore.kernel.org/r/20251103-dcif-upstreaming-v6-0-76fcecfda919@oss.nxp.com

Changes in v6:
- 2/9: Collected r-b tag from Francesco;
- 3/9: Removed ch_max_clk_khz variable as suggested by Luca and added
  his r-b tag;
- 4/9: Collected r-b tag;
- 5/9: Call drm_bridge_put() automatically in
  dcif_crtc_query_output_bus_format() by using a cleanup action (Luca);
- 6/9: Moved allOf: block after required: block (Krzysztof). Collected
  r-b tag;
- Link to v5: https://lore.kernel.org/r/20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com

Changes in v5:
- 4/9: Removed "bindings for" from the title, changed the port
  definition and simplified the example;
- 6/9: Fixed the way 'ldb' child node is declared: declare the
  'ldb' child node out of if:then: block and set the property
  to false for compatibles other than nxp,imx94-lvds-csr;
- Link to v4: https://lore.kernel.org/r/20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com

Changes in v4:
- Addressed remaining DCIF driver comments from Frank;
- Limit the 'ldb' child node only to CSRs compatible with 'nxp,imx94-lvds-csr'
  in the binding file. Since LVDS CSRs are a minority, I chose to
  use the if:then: construct instead of if:not:then:;
- Remove the '#address-cells' and '#size-cells' from the ldb node, in
  imx94.dtsi, as they're not needed;
- Link to v3: https://lore.kernel.org/r/20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com

Changes in v3:
- Removed the BLK CTL patches and created a separate patch set [2] for them;
- Collected r-b tags for 1/9, 2/9, 3/9 and 9/9;
- Removed the DCIF QoS functionality until I find a better way to
  implement it through syscon. QoS functionality will be added in
  subsequent patches. Also, used devm_clk_bulk_get_all() and used
  dev_err_probe() as suggested;
- Addressed Frank's and Krzysztof's comments on the DCIF bindings;
- Addressed Frank's comments on dtsi and dts files;
- Added a new binding patch, 6/9, for adding 'ldb' optional property to
  nxp,imx95-blk-ctl.yaml;
- Link to v2: https://lore.kernel.org/r/20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com

Changes in v2:
- reworked the BLK_CTL patch and split in 2 to make it easier for
  review;
- split the dts and dtsi patch in 2 separate ones;
- addressed Frank's comments in DCIF driver;
- addressed Rob's comments for the bindings files;
- addressed a couple of checkpatch issues;
- Link to v1: https://lore.kernel.org/r/20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com

---
Laurentiu Palcu (4):
      dt-bindings: display: imx: Add i.MX94 DCIF
      dt-bindings: clock: nxp,imx95-blk-ctl: Add LDB bridge child node
      arm64: dts: imx94: Add display pipeline nodes
      arm64: dts: imx943-evk: Add display support using IT6263

Sandor Yu (1):
      drm/imx: Add support for i.MX94 DCIF

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  24 +-
 .../bindings/display/imx/nxp,imx94-dcif.yaml       |  90 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/freescale/imx94.dtsi           |  82 +++
 arch/arm64/boot/dts/freescale/imx943-evk.dts       |  86 +++
 drivers/gpu/drm/imx/Kconfig                        |   1 +
 drivers/gpu/drm/imx/Makefile                       |   1 +
 drivers/gpu/drm/imx/dcif/Kconfig                   |  15 +
 drivers/gpu/drm/imx/dcif/Makefile                  |   5 +
 drivers/gpu/drm/imx/dcif/dcif-crc.c                | 235 +++++++
 drivers/gpu/drm/imx/dcif/dcif-crc.h                |  54 ++
 drivers/gpu/drm/imx/dcif/dcif-crtc.c               | 710 +++++++++++++++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.c                | 250 ++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.h                |  90 +++
 drivers/gpu/drm/imx/dcif/dcif-kms.c                | 181 ++++++
 drivers/gpu/drm/imx/dcif/dcif-plane.c              | 300 +++++++++
 drivers/gpu/drm/imx/dcif/dcif-reg.h                | 270 ++++++++
 17 files changed, 2402 insertions(+), 1 deletion(-)
---
base-commit: 38c8be16846f10f3a710351357e4f4ace7254c8e
change-id: 20260602-dcif-upstreaming-fb177f3c9351

Best regards,
--  
Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
