Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC6606A68C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d+5owdFH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86A410E4BA;
	Mon, 23 Nov 2026 21:49:56 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011044.outbound.protection.outlook.com
 [40.107.130.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6CC10E4BA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghdKPEO4nxtc5Uzhp8HOGxAlvs8YHAQjXLOftEul/1UmrgjlSOZsvrJN4oNbiWljtqCmtS7CLJOAtbedqixeL35a9DtsMt/6ZPZwVhcHolp0S22gPB73uoKahuwbknJAYVmiJtkxbDHoSRQ8ZPke2aJnHTcjNf39oSTkbnjDco0JkVUEnL9JkhteUFu5U3evBuLTPNhSbaXKBqK5f6w94sp9rJBvuEvb6KoMZvMUmG52T5Op39U5wGNgTzPR1pFtZGHTc+pYgxNOqBKGEmOQhhOZT+Gky2oJeeWmZiG+gN9s9oUfFY4A8du7Fa9/ElAmzChayw/oeQcyHqwsYRwLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RA1MHgbf9fuw041F/4ZXMg7o0VJdKknmIh3Wp4NPZY=;
 b=FZKxuqwQGflsXs7Irb7TyeK7pK3P9GBh9LHa/GsbZGigbBD2dCcmpkrZn0DfigASJ3toJzaNCWLpP2gFqlkk4wx5oNhaPtS6jjdNkO1hvAN2HTJyHJmFDS0itK5xur8hPVIRvG+LSOQUuFpF1qN8NJRue4LrjaLEfbWjgsmGAaH4c7PsKenwYZiPLWIRrN1WheMGXYqqlS5m7b8wBjQhgxwH77XUXM9FgRSunrfFMgepYyYDFUkjauwZEOp39r7sD3eWELhZOiBn0briXVyE4MdqMFLBy34Uw54USyOs1t5ytsv9oEjWeRC+vZETOGztLZJW2Ms8H0/367ZCj1kOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RA1MHgbf9fuw041F/4ZXMg7o0VJdKknmIh3Wp4NPZY=;
 b=d+5owdFHzg33SUK+J3Az1gUf0B7NhqN5RcX/NG76YZ47GCRGZaDJgt4DTqhxqeRvKAdyEoiUrbz9Iys6+0Ae2zKpGx4Pt4urWa/W/8u2VrDs7jGBvZuVGppCWA6t8FjJ/S2rAPml2yGuxUjBoqBd9AWFNAIMjXGhH8iTFEey3wU3ViNJIANVQWee/b5uuRryr3ecPfWola7PlrtT/286r0DLJSnwaDEAG8yfalvfwa/O4MjF3Lo5B9fDta+/3BXxmmyyc7TJLsNdQkOb27x5DogA88ggM1YYGonboLpLe5vdKMOvh91AkM3Z1fve8YNM5An1QGtX9Iroic3dJBRizQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by WA4PR04MB080239.eurprd04.prod.outlook.com (2603:10a6:1d0:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 21:49:45 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 21:49:45 +0000
From: Frank.Li@oss.nxp.com
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?q?Guido=20G=C3=BAnther?= <agx@sigxcpu.org>,
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 0/8] arm64: dts: imx: cleanup some warning with W=1
Date: Mon, 23 Nov 2026 16:49:37 -0500
Message-ID: <179547048504.2992787.6427013140216184376.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
References: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:510:323::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|WA4PR04MB080239:EE_
X-MS-Office365-Filtering-Correlation-Id: 8424d8a5-003a-443a-c942-08df49abb049
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|19092799006|921020|10067099003|11063799006|56012099006|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Lp3jnYgYdy6fGVtlOoyT0Wbvmt+FT33mzr4NYs2TW2/Jane7EuS/ZVecoheRXmovCwAhk4bWqVNehLWDLygweCNoJ/YQ6fihkO9os8E4S2YL3J2T2r7vrPSNgGrtsY2tvD2QgVbzO/wnmQLFCyXP+UjlAzzPNS5eI0rEDuvW+s12c6gFf38Vu2eqPV9nkaE7bif6fKFoQ+zAwjbpvZaakxqhQ0YtxMye1CaPwn/QKbNAPYwgaq7p8SVTj8Nrenq2Y1S66j1ivAQP+uc27Y09aNKNLEzK3ajDXTvtVDoFbcCxcU/aca6vezP6gLzDJ6/blrsdgzw01Cxu4i8JtqVfn4RwNHpmY6trvcVmD96yr+HIAN8w98EfQKhEcrXJ2RQ3dmoTeCWxji6LW5zA8iCwCk8kB9pqQgynwYoe9HX65VeGTNIhWkJQiXNsUmsRh48kKccYRzAegX8CBVa/ki5TtU2ofLD36hX5F/XbrHgOVwT2jR76PfWMmWZFkaGqpvEyoPC+gsEXYcf3edeLkGg1jIVls3x12L88CMlz9AIF3ijdUTT+S/grM13DwSgDWkwyqt6FQNnf1ybIj2XHRl9l6uKIpemCYLu1116JFhCAiCRSZbYsBJTzLWBwsF40xLUwrtLIBMJg1xTQPlKvK41gRehfkbls915KBUz43AbKSihAx4oEVwv6On/c0psVA2rCtMc/ZSGYeR5WzOJ60/Eczw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVQ0UlFTSWtsOXlYWXc3Y2FzeWhpSTFWbkQ3L2xNQlBneHA1S2dCMHpMT3lk?=
 =?utf-8?B?Z0hWVDJ2YksvYzFVdmhBRE1COW8xWVdEMUtINWk4dGVsS3hmdTVkZEZLcjNG?=
 =?utf-8?B?cGxyY3ZZOExaTEJ3TzVRSDJpRVZSVUk2YTIveSs0dEJXc3NTTkY1MVNhY0dF?=
 =?utf-8?B?aUNqdERaTWUrd3Z1QktCZlBhUHlRYzkzNmxUVWRadmhTZFVGb0h3Z2JWUk9a?=
 =?utf-8?B?L2VxYlRiRVl2ZWwxMzZCMHI0b3dGR0ZGVll1NW16NmdwdEE0bjFndWdjNGpm?=
 =?utf-8?B?cjdFaXJEWDg1RHhrQTdWL1VCUW15bGZERHYrZVFnb3VQMk5NTFRsMm9SenNM?=
 =?utf-8?B?Q1hESVptVlhYeVBxRzRYcjNkaC92VHFwL1JtVjg4VFRpRndNNDd0WUVNZ0pM?=
 =?utf-8?B?bUVEd2s5ay9ZOE82RnZ1TmV3VzUvMHRJc3pGUk4rTnkvcHNWVDIxMjE3M3Fz?=
 =?utf-8?B?QkM0UGhEUWpoMStJWUZqcXgyTjlhb3RSbHZWQmR5V05ieWdSNml3OG5weW9l?=
 =?utf-8?B?NnI3dFFZTDgzTm5TcEVnSDc0VW43ajRFcGZxUUoyTGRIMWJ3V2tsVGNHdDg0?=
 =?utf-8?B?Wk1NeEpUMytXR1BoMUtJcXhlS2tQQUdUU3ZMS1Rjd3I4anlRNStvWEhrdXZG?=
 =?utf-8?B?Vnhtb0RBNDdBaE9HdXBHZE1rQXRyNlZvNStpcEkzN3FDbWs4L3RncFBaNzdo?=
 =?utf-8?B?WVQ3U1ZVTENXdXlpREFJTFdwc0svTXlNRWVBTVdISjdFUWl4NGMvQ3NDTzQ5?=
 =?utf-8?B?UXhuVVdOc0NqbFVxLzczdWQyVURVNVgwZG1tZ2t0TjJuWmgzTkltd0MxK0Jr?=
 =?utf-8?B?WmFRZ2ZhcUttTzFsK1FTU0Q5RjY5bHFRaXlZcVd1aVljeUNZYk1WOEpzMTRP?=
 =?utf-8?B?cVBaMVBibnM5SkI5d21MSVdCYXRuMmxjMkxyQ0tMYTBkQ3lBWi9FS0JYTWVo?=
 =?utf-8?B?S2x0cDNQanFkZVMzNVpEeXBmUnRGQUhERi91cEpTcnQrS3RJY3hsSTlwWjlO?=
 =?utf-8?B?SlJrTXZBNUk1Ni9YeXpkVDNkYnd5NWNQdlBXMzBLWGZ0WmZta0FuT1l0dEFY?=
 =?utf-8?B?SEdEWjlVU29UMTdoK0l1ZHYwRCsxZTErcWRWQ2R0UTZlU21pR0lsck8yZXNH?=
 =?utf-8?B?eXpodjlDTGtqcE80OS9OaGs4NSsxOUlJZU5iL0dhTHYzRmlxdjhSSjNNU2pT?=
 =?utf-8?B?aFpERGpkOWF0Njl3bXNEQ2pXSkl0ZE1PUUpIWDM5eWplYTlFVlcwMkU5TSsw?=
 =?utf-8?B?cXcyQlF3Z0FpZTUrUGdya2xhRWpoakM1UUNtbGlrMG9IQmZoNmIwbnNRVEJU?=
 =?utf-8?B?N2pUcW03ajdzVGtBT0w5THlSNUdzS1dZNVVxWG9wcGV2RGg3Q05kamdvUnVQ?=
 =?utf-8?B?L1JTc2ViUmtNbG5rQlJDeUhiTXNEamlRdjJDc0I2K0tlNy93QTFkMEU1c21x?=
 =?utf-8?B?WUtzeUpwK1dIblpRd1JMSjI3azVKSWY4dVJYS0lnMW9Lc08xRWQxMWF2Sk4y?=
 =?utf-8?B?Q0ttVHZNNEdoNjM5VzZVVmpPbXBkOTNKdkV5bGxhVSs0Rm9wT1VaSDROeVV3?=
 =?utf-8?B?US9ybTB6S1owQjJPajVlQUFmWk5NeFZMVWZhRFNnRGlicnp3OHE0Y3YzTzEv?=
 =?utf-8?B?MVpmUmZ6WGVqSFdCeW1qT0FERllZTTlrdjFjY1VBS0ZKZmJWdENyNitKTlhJ?=
 =?utf-8?B?dGdvbzh5bzV3MHdabnlzdDM1YkJzT2E1VE9oem5PT0pZS3lLK25YaWZyL0tk?=
 =?utf-8?B?QS9kR0ZCWS95Y3E3TnNGRHpkaFd0bGdya2o2eWFQN1hINWdPckFmdzRkbGxx?=
 =?utf-8?B?Qkh6dmdCWDFUUm5iVllGN0xHcDdQMFNVVVE2d2djZ2tETDVsQVBDLzhVdUdT?=
 =?utf-8?B?QUFzMXNuYzg1MHJyM2xoSm1aL0o3WW9vSExpOXJueG5BZnlVV1p0TjByc1FV?=
 =?utf-8?B?cVgxSUpvMmhlVTJHT3piVDFmL1k5TnovTXZSemZuVGorcmMrQStZcnhLbHRZ?=
 =?utf-8?B?WEY1NjFuaWZ0blg4RU9KMEVmS0tTSmEyVzdVaXNXUXRlakgzSnlrbjlHelhT?=
 =?utf-8?B?T0c4UVBhemlQbjlPZjh4S0hNZEFvSHRnakNhdjM3UkM0RVlyK0daeHM1SjRK?=
 =?utf-8?B?MUpBcTUyUThzSmhrdU9wUU1keE41U0svSjAwazJiMThFNWdMVFVmR3FidlhW?=
 =?utf-8?B?MFRwVWVxczZGZUlMR1c4c2d1Mk91WlBjdlBhc1cxRHJ2TnNIc3BpMmlmUGdD?=
 =?utf-8?B?empoVExLZ2FVQWV3aVdDelpPdXNUMTBvTnQ3djdSTlQxMFNQRFV6WnNUS0hW?=
 =?utf-8?B?TlpCRkZPVUw2bkNLaDZzckVCU09JZVlDRkZIWVlvTTkrdWMrMTdoK3BLeE1j?=
 =?utf-8?Q?3yLpuTSHz6TBJ+2Bk729cXTRGwY2WXGvnud6e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8424d8a5-003a-443a-c942-08df49abb049
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 21:49:45.6553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBR58TiPy5GQ71XHvWuZ0YJUa6/xc9Wd8DQHWmmCkZ/bx6FzWJrXaI1uphYppmjAr78sH95d7hEPQ+NuLC5UX3X6vDMJguWJyntr9xM4Z0RW8XekGYiuHM2Kny/1KQvn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB080239
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>


On Thu, 22 Oct 2026 15:37:03 -0400, Frank.Li@oss.nxp.com wrote:
> Cleanup some warning when W=1

Applied, thanks!

[1/8] dt-bindings: display: remove #address-cells and #size-cells off requires
      commit: 65525397fec4dfa809049dbb49058c33a5da8da8
[2/8] dt-bindings: embedded-controller: remove #address-cells and #size-cells from required
      commit: 3b254a764601fcdace42ce8fe439d036c019daac

I picked above two binding patches. If have any concern, let me know.

[3/8] arm64: dts: s32n79: add @addr for *-bus node
      commit: 47a83e13f5b3695fb061e6e5d37e7d4a0bfe0e11
[4/8] arm64: dts: imx8mq: remove #address-cells and #size-cells in dsi@30a00000
      commit: 4c2b1a3ad182c38d68bcfb0c466c1e71d9107d48
[5/8] arm64: dts: fsl-lx216x: remove #address-cells and #size-cells from pinctrl node
      commit: dcd62a4f6a2d928b2ddaa107f00276f1f3d772d3
[6/8] arm64: dts: imx: remove unnecessary #address-cells and #size-cells
      commit: 1c896b0b996a8a9728a61d0d2e187d988254d8db
[7/8] arm64: dts: imx95: rename bus@4c100000 to hsio-bus
      commit: 13d10e419e55d25e4a7d0397b16ba00860f509fd
[8/8] arm64: dts: imx952: rename soc to soc@0
      commit: 8df26227cc39f7a9102f3823cfe9f65d6e19d89b

Best regards,
--
Frank Li <Frank.Li@nxp.com>
