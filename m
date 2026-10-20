Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB0606A323
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pHrDiamZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243DE10E068;
	Tue, 20 Oct 2026 15:52:57 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286A410E5A0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE374yIK3rAH5MsJLzSbb/W4hAw/raVom2mF7ZPhviCCsGe4sezVAoJhmhzcCZEkA5mNthIlONbQA7HsaAXql23mIJ9/dB8MKqoS9izCXQMBHxoOjUTPPhmfuEheZ6ngzGKXkB54XtAaAnCzfmvMbucmeHffCa2kOAbbsQ3Bf994MadAglj5B62xIZprV7pcvMUqyx8d4XhMhRLD3OowyHEOPFY1u1WkWKUaaJ+e3ttbMon9XoOLDAgwveDHMzeRG4QUM2pJOz/jDkcRxJVuPGrvp7EHXd3RVbp3OGPbvp5gbF58sluoNntzNTBj64GrYB0qmvdWL8rfW+bIJBHl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH4jLi8atPK96usn2LfTIYVk+m0TXGG78+/k4+u5ZQ8=;
 b=NyYXsf3UCSkVDCwtC7F688GDDkwtnP7wRQaiIZkMmLNpnT+May4CcOaB1Cbl2QummXh6MXeXJrWGlrI4T/ZUEHd2+uFStq7mvZ0cjkGO/fGZOTEiwWsBU8A1afJ2834zX7luPlOu30SYU41h2Ybu25lQKdAd3+k2VeFQYwv2Y4MdkX+gxlZiK1wwFF27m+JDbhhZpaJ1e0Ra8t1tGUCmq4IPQNNvxFCjV+3MiA3p/R6ekA4Ig5whAMSFKeT///vWhH/EnzCR5yKIeUkSu2BZIazzuiwiKqawgTGDpdJEWuoJ2p9kCGiTu5oeRQt6PPBgAWNFPizAlArOhKMraTMd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH4jLi8atPK96usn2LfTIYVk+m0TXGG78+/k4+u5ZQ8=;
 b=pHrDiamZ2fRKplu+HlPZkgsoa8UcuX3s2wY9SysU2lRUPJxz21GQPtuIgJ3GO+r92etgz12tXEXyDGzmIGt0xp4S4icvUrtyEDN83mtfz7TsA2UcMRGusKo5iJzZ4p0HOwOaEa1FDCJQjgXopjvLL3eDnMkL2Zo4rw9euWSeTbDhuARIXcb0p1umUP2VDAAvPsuYbvCXZp+3Zmqg0sQF7b7Ft9R9I2Cu5XoX5jjwpK+eKW0sR0+ykVvNr3ZwvFPCRC9Yi2eAfdCXgSq+xEcjlB7XyevNeDzQ+aO1c+l2guYKHVBGrRChwl9H5HYYL7/hNsToNKjIuxcEEDGb3CKiZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB11590.eurprd04.prod.outlook.com (2603:10a6:150:2c8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 15:52:45 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 15:52:45 +0000
Date: Tue, 20 Oct 2026 10:52:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH v2 2/3] drm/bridge: simple-bridge: Support
 data-enable-active endpoint property
Message-ID: <ateOQElYylBqmpdo@SMW015318>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-2-ef6a3a780472@toradex.com>
 <atZ0jECm5BDeROSI@SMW015318>
 <u3zistwpxmtjstw6lqh2qfvr3mrj5ozflxfnrln2qqitjnj6lw@5ea5j3zmonw7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u3zistwpxmtjstw6lqh2qfvr3mrj5ozflxfnrln2qqitjnj6lw@5ea5j3zmonw7>
X-ClientProxiedBy: PH8PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB11590:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bd3c6c-2acb-4f96-8e0e-08df2ec22edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|19092799006|1800799024|23010399003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Cx9vlTIoAO4/W+jhLyIOdkHBgipqu0ZBa7LPc7IXGG/uOe+qej5Qr/gHcZg6m7phWrZAyTi4jLt+ZDdL+CPDCoNmZN8JBI+JTcnNDFfuE0wnebGZ4VhnDeDrVc0Z4t50V1dENt9yETkQ7rxNnIjSPiCzepZrj3lHIMlwaXfIiLUKtpBlb8Xx6ETKhAoAVReVQuG/QrnSNEP0MxourrdBmnxsFyBXBzONbuxsCl7bfmq+uGlqbRwaOe7rqpytcFU3NcFM2Pe2AGSSbOuhksSYZukfJPkH2K1i9iNRLjzH39EdC3wkPOw3mp9wX6LA6MqQRCqAU7SLCZ1imNnqmeHsyee9RwS8OkEKkv7Sdg/KlQiyJwpFPk4/hPOj9I1/naDHcYCPE4+RY8uS5TTsesE8u4XKHFPhin8fTEzL0ptcL6C5Yee5dTJX2F0DKVyrMOCq5M2v7R8pcEXewHxIP5cDfQPZcUO/nDBByJzhZV3HT3kZ1aSsJYbiQans4ZF6GiKGrsZ34QrrTldh2ZyOfQyzJYUuDQMdWB4zIVzooPfjURihpthjHA6DSDe1Av75NZ3Pa1Bqq4DTCEuH5kCS8Yhdq8jNeMw27WSgV02Wk4Q8nFPBB6i23m2gkHT8SiAJqtwsjgHvs9hkzDXdDFk83vPuGqr+c0t+3UW+ZxnsLIKJyeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cXBsQiA+q8X47v7CcP/YzK9fffChXwDYAT8Pv0d7o1Vnjel6UEDYnOV37J6y?=
 =?us-ascii?Q?szUYS+BWBmhifsXSCYj06nxhXk0axLFmk5lVNJ9+Xf2oYx7XDHYYfwXQWbyR?=
 =?us-ascii?Q?DPjKpRTSi6rFjxpwde+D357QW3obHCmMXsPNOzl/k1OLaKcfz4vK65SgC93D?=
 =?us-ascii?Q?20BoXZXTQ8B6MwIHYw861ccqqehx8XUTaI/5OG9LiZ8oJNB5FMrJSTi0I+A1?=
 =?us-ascii?Q?ArFsv3RHtbQ8vrDc+fCa23k+WQjpOkXRrZe4vFmR2MI2yDvmxNvAoZxnbf/6?=
 =?us-ascii?Q?mrGVAWxcj1lBkOPuFfTWzPudiBKKzgCX4IkoeSYO7Om2zPcBlKCgqOyAYKV5?=
 =?us-ascii?Q?88HxXdfComn0JOv984e4kJDniz7T7wfSj0YPdUQVbvm2IY+hfKKZhnhkcqSE?=
 =?us-ascii?Q?yv9WHT+2NH5DaD/72kOQ1g8VoSJdQDrCL9BiBXpts9fhl0mBCNBVBx57Ost8?=
 =?us-ascii?Q?uvyRUDS/Ur4uzXOqoxyBaaFMvoimHzvfHSoyb/gDoiJvGzywYeYYdAdJVpV0?=
 =?us-ascii?Q?LhV5A8p0soJL/ioCkejkqN0vQRHSAzHOH5kfOKaramGQgrXMF4HH/oXvo3sU?=
 =?us-ascii?Q?jA/Cg3zUytjQBlkST3LB6FMYxh/X+EJVylCqiSe0ITMTEYZCdl+s7/y6AK0F?=
 =?us-ascii?Q?vueFKX0EKZATYxhDXuX4vla+heJGqWSfOd8oXniyCXfpGsrKIFNj+h73qCHO?=
 =?us-ascii?Q?UM2tcRkDs3i+JD4I3q6GYek5YFYHGjrLROo90by9eLSha+ifCklqshoSBRkg?=
 =?us-ascii?Q?0nruHw6jnc3wgRkLV4malsp2tEq2mAty1Ucyq9effHzqfQW3DGpMfNCzqGN+?=
 =?us-ascii?Q?98aE/PcmcPPdtbOQGI5kYdNuX6heK0voADsRAFE6MKH8y98KbinLLtYD3iXY?=
 =?us-ascii?Q?0eB5kbqLy8Q9omAiIn/tMqQyAw/kufwUAHNe52jv38E5WZKol/Z+d/CzmGtN?=
 =?us-ascii?Q?ll3Zfs3El3O2HqvHfGP717EZaNqowhsk1O8jlirVxdO82YazY1cO6+Ghal2b?=
 =?us-ascii?Q?gq6eQNHXmtnrdgHJVrJ2OjIyqhlvdkxtkxh7QP5QuaR1gsldb8W5OTDrh7cd?=
 =?us-ascii?Q?xVF6eXWma7byOwssoRLyCUEH4h0TB+GvusaQU7DAqJECMeUe+chz13QOp1sO?=
 =?us-ascii?Q?cbvFVDAajBi3oYDDp82hkTVECD5cWS7D77RxWP3Ey/jh+yDtghFUaFjGcqk+?=
 =?us-ascii?Q?aszJCHx3xRjL2245+Gg299e3MBTfB3Vsbv+4ClEPIJIGKinPtt0BeGgqef4O?=
 =?us-ascii?Q?YDlheZLEM0X5mUrrptZpBCqxfnTuz8ViMP6T7zNrMPFIHKZG8ezVoipQ/HTe?=
 =?us-ascii?Q?UYNQEsDzj12Hre1Ho7MkF4HZ+n2i6Ze14kp0FlLOBWBWJ0JCn6SogRWFVWvS?=
 =?us-ascii?Q?wh2REoC6wLY3DcePibbe2u/VUo0ind7P6XihBVyyCco7vL/YmAJgK+5UOm6S?=
 =?us-ascii?Q?jDMxm8nlhNy324s9xzur/PBuFnNHr1bgHyeyMslajTWHCn2ghI1qHMSyFG1Q?=
 =?us-ascii?Q?CDmCAoj4iCPy22G6C83cSDbdjGdSiv9vG4T12LBX/VFQOSaaBynfIhgUOmEC?=
 =?us-ascii?Q?vvCeT4nwW1cgsC6q0QBU/GT8yoK1aeOiRHng9XIzRZy6xhU1YldO1JvmSZzT?=
 =?us-ascii?Q?6ilVmm0BciIfy5kfSPedoFNLhOnHwk73WmK9KIxKemR9Q+qt/eiEkF1YCNmx?=
 =?us-ascii?Q?g9InUF/amXQ45YROx0i1ac/w6qK7R5wRPtvXS/j3d7Yd2/Fxgiuzmn8drMW5?=
 =?us-ascii?Q?EmIPx1VCmUCTrnOqqwFQpLMuAkVJaEjBFyQDVg9RDmqmIVQetVMp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bd3c6c-2acb-4f96-8e0e-08df2ec22edd
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:52:45.6756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcm+stFk5/VD/owdDxIuUie4MDMhlFCw37kvfpxyLqCzKWAW/yZv7rJ+KBxaT/xHzVtIuGB648qGaXppm6JGr+g49erGdOARPVpxmcLPhVGeZJTJopugW5MJMLnr/Mto
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11590
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 08:15:57AM -0300, Leonardo Costa wrote:
> On Mon, Oct 19, 2026 at 02:50:36PM -0500, Frank Li wrote:
> > On Mon, Oct 19, 2026 at 07:17:15AM -0300, Leonardo Costa wrote:
> > > From: Leonardo Costa <leonardo.costa@toradex.com>
> > >
> > > Some simple bridges, such as a resistor ladder DAC, may include a
> > > data-enable input that must be driven at a specific polarity.
> > >
> > > Read the data-enable-active property from the input endpoint and fill
> > > the bridge's input bus flags accordingly, so the upstream encoder drives
> > > DE with the required polarity. The property is applied only if the
> > > bridge doesn't provide its own timings struct.
> > >
> > > Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> > > ---
> >
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Hi Frank,
>
> Sashiko's comment regarding atomic_check was a false positive, but I
> wasn't too sure about the one regarding devm_kzalloc. It seemed to make
> sense to me, but I'm not too familiar with this subsystem yet. Do you
> think this was also a false positive?

I am also not familiar it, it looks make sense to me also.

Frank

>
> Best regards,
> Leonardo
