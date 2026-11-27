Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F35606A6B1
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fO65uMAa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEF5112B97;
	Fri, 27 Nov 2026 15:29:24 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3ED410E259
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee0BaKGRkzMEoH4FVrXa+MFpSksLPjr/5FdKgKu0/J4YWVS+gXglySKUv+pO2p3RYkG+WLcceZ1Bq6iuJO7Yh43AlDXshOwf80Shr5ZRYla6UrKYih/oKGheElvwXAuGDrRrULEwCUeW8KazsnoI9LbwzEupM7SC76Y2vzpcqGE4F0i4jjCWTy8NP603KfsinAi0qwxQb4r0FxLuAz1sok5l6IjzNRl0I0g0eEpyAZ8IVD4zqzk378Ui/PHBQBQvyRF4nEMR5uXqSOvZF8CTcmmXUY5701xNhqEELEiWDffEEsmWSaQry2cXXHBLDor/PCJ6/reK4laiurJuKF7L9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7lJU2yXjKEMQUztoownYxmSUo5xLYjYP3p+fKIDals=;
 b=Rufz8q9JZZDB0MXhsn1DaGb4+hSIyEvq8hO63WZzOq39iecU4A5hQb4acnYMxIMC4804d0Q18rRrVaqrfK3D9mLieiiKV1NU5qLSYQSRgQ6sbp6aOVYTJzE79GEGRCfCF42QjRwRZEhjtebuERwpFXvkYQViBJql2x/EoVFrtVHmdeojXe+HCbz5JBhDUTppmLb6ZAE3szwFYBWeSrGZPusjUcxCLYu7iDyZNPP7mPkVAwe9Jx8oT33HVaJsetIM/JdU34V/+P1owf8S5klLDeA45VewkIdBefXE7oKvKENlfnfN7UaD5SmFtEiXOq3ZlTbD8OSPH+HHCJt7V1v8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7lJU2yXjKEMQUztoownYxmSUo5xLYjYP3p+fKIDals=;
 b=fO65uMAa/2y2ONOGcPEWjVG2+2zRxXzlVLmeq8RazSAPyXORFC/Fbd9FQKccLSqLxfXFcRDES5b/uXLz8KhRFLpGxQQ2vpUyzEagZPRHlHnhJ5YBBG4aF7lo0NwYb+EmXKSu3YJXbTZwQ7k3EZNvXqEC05KIVrdZyrMyhY5yPj308vhyuKmccwdKk/RKUQNC+nhAHD6pSXV5UDbTKgmBH6nv51LrVFTLaCwqXqQjxeqaXFzNgrXWeOKt068hU1SSTZTlKXU/fno7p0RiwcAcouhWCCWNa5WYORROc3F+krSttDiXswywBwEuuzDJuk7xaNBRCIA2whrVykOZiAR/3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 15:28:52 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 15:28:52 +0000
Date: Fri, 27 Nov 2026 09:28:36 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 0/5] Add support for i.MX94 DCIF
Message-ID: <awmhpFuAOF4BmmEO@SMW015318>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <awmGCp4e2pgtxsqr@vm> <DN63BMGBI07A.1IC73REGZ7NXZ@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DN63BMGBI07A.1IC73REGZ7NXZ@bootlin.com>
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6837c3-5db3-4af6-c9b9-08df4c9b242e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|23010399003|1800799024|366016|4143699003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 7JCBMu0Y6YgLM/qt5gLbKNCm094IrCFfVjyVVdAbgzlT1ZHl4IKyQrXc88LfsRv9MDGNnHdgoFDJOCkSPr+B02kkgZM9/U1Cjy5LZ992+B0vjPcGfwb6jOVcvIJoAvT4bwmUqjlkBk7gjCoXikTUt96+vybtWugzBpjSfnhe9AC5BNgjkataveXOghxXegDd51CQMX/xjx3rqhj4yM1MbwzImyz0JrJSYCjd/urX9cQoEs/i+NQ7dppIYduh0J8Ep2dpXFpQ9WRzcry7P7gw2fUAJbUXKz/bGzyRe5unNvrbc3KS9Gc6X1gI8bfeW9xJiiJbSEBybWSiTxL9M/UbQORn2oeCgS1s33aBwLoT8LBTgq9id5Q3yoQzCxTOmA5XGb1DxiR/yDwzw1Fy9cRm1+Wqzhu8TtROPhoqgeogjjkKYwrUfk8OFZ5eJSoVbl/K8iqRasD/abeRzmCeCRFLaw+gdDEY+h3ToPZceJljPBBfrzm69GBUZl90ZxYJJqvqfSzLVDLhl99DraT2eVJUHzlg2VjCWQTYUHiMFYx7rxwP13BaLXybfmqVv4wN8NaNBhjvfUUjpiML8ydsEugLjq04vYtYoDOPLuWuffo6dmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HlGUE4m7Q9D6WFfIL9Ad7+Z1JtyYYLa9XqGrm7Au2fta7FoeTsyPoYf2WMG?=
 =?us-ascii?Q?kykvCWnI+VHpFbrCuv8swvSkM2LUSBz5xBD8XuzjlKldllhzRaiQzfR6+vc4?=
 =?us-ascii?Q?LfnrwXSYagtYymcmRRVAEuUIeJnQxBDk90pa7Utv/Fm3Re7s2PSsgYxk6mAX?=
 =?us-ascii?Q?ehhLv0MCx4XGgjbL68Uy54WlgvzE2u28yHbfnjAa3FCP4xbX7YHms/8mihDy?=
 =?us-ascii?Q?4dntO7mT+R6wwpp2Rrfw2/BLsOb/8TpXaYz5xtyCSyxW5fmPI3XryNKLIttM?=
 =?us-ascii?Q?XMvleeGxTHfqr1Izk5npfKELQxVRvwoNNpP0b9wS8VlvKVMCMpBeqTes4F+j?=
 =?us-ascii?Q?QqSEslu5LCb4gsQpGyLbU6MAQzcqg6cBl0MyMJ8D2ulXQH7wU502wuq2+q48?=
 =?us-ascii?Q?RRB+dcdvJWe1/+Xfq37XrHUTcMaby62HO0S9XiP/x3eoFwAckrGiPBW9iWjr?=
 =?us-ascii?Q?ZCdXicz+u/VcTuqqVe1VhtxfAF0ZYgOpGAN3qq63wzGv1Q7vAo7xMYx/I/5u?=
 =?us-ascii?Q?ZQMhksRJh1ieUJnvo5rJoIz51eZVaD5RwpOMWrESTKne95fqSSI5eFZ4sYOd?=
 =?us-ascii?Q?hLK0NwaKViz88GaAAjfCterWhnHDQpAPd0Sr04J5w/dBUhv93t0BdGX0qhF2?=
 =?us-ascii?Q?cTxM69Ih87dK8omSDCJtToTeYCpZeRYrgNt0P4WCR9dhCAR3ZPM6iXP8t4Mf?=
 =?us-ascii?Q?YSlaIehO5T9CQLQJ+ZFssGedp9YkAcVd2o6C3uy+fhJrQCDNVlMxdVv+GZRp?=
 =?us-ascii?Q?gr+SFF5DKxSIZPVTO1bz0Mbo3y/IT5TFmH2QEehG3EoY+asrE9L+lNGbinjE?=
 =?us-ascii?Q?P/jrhFCNjmzc/PL72jlbQpFrU9OnjA5E6AqW5KBDssUj1c1fp0umfnlx7L+u?=
 =?us-ascii?Q?9Kd/JdnujQFhLQlaVf8syXy1k3Sa8bydzM+nrcrT4AULE7A4ZqO8k1wCVvb6?=
 =?us-ascii?Q?IsC2yxVbdcZCizL22aG2SzCusxeQB9C2PfwdH1nT8eJPYZmcuRdWWw7p1+st?=
 =?us-ascii?Q?eKsfybf63DbXUGRQt/8Nhep0ZZ4EmMnjAB9e+la9zI3IyVhBVLRpIMIEwUIM?=
 =?us-ascii?Q?3mAA9oY2Ou+TPzRkpltsRggeoa6cYrErXcQb3scAy8N4AE0bwDf6IWZPHA9i?=
 =?us-ascii?Q?MtQ68cPOet22csd+KRLReDe2OILkDgXdumtQOysdzCz3PnXZb3OpObdg/mJC?=
 =?us-ascii?Q?5VREsaSVYUxINYFXkjYHMVUSoNUh8aJ3YyTGHH0UTC424VJUxd7t+Vxw6tOs?=
 =?us-ascii?Q?vvpOZAt4NCnOu+07CG7OC0+DOnJSWu78iAd+erbSsRDgulFSfAMhMfNObM+4?=
 =?us-ascii?Q?LthTtmZZRKw9bICQe0qLhRzqwomMtNbiilMkm3wzXNM1hRUvUOlaBQHXIdy0?=
 =?us-ascii?Q?GSBu+4TjK1ezTgs/OQ7Wme2wLlauEL9cJ7yq7N0gvlwyitoMhChAABQq7p7M?=
 =?us-ascii?Q?nDj7hI3aoQl0AujAxfHoLGJ+C2lWcEpnhJQTDR5scACSJdsdftpolMPSySpO?=
 =?us-ascii?Q?MPkO6ScSMpp/ppxB+FX1qaTuu6niIFwJLetjv6w4LDkknVlWqAqD05JpGayO?=
 =?us-ascii?Q?cPoCwn7mx/7bLqiKnZq9BV6g6cegorRYZua5K2P/za5zlhgBcTZKOTgG612f?=
 =?us-ascii?Q?irha38MAUoYEASzwgZUvWvGY9ikwX3ygdgHMpp0ao1wzXKfPQMuvFiV6hSN+?=
 =?us-ascii?Q?zu0QERwamSJMpR0LetSNnaKPyicuakYwLJSj+1qI2yqljbmweLH3EgQyMw6x?=
 =?us-ascii?Q?3gSvcTab4HdnfsjNSo4oR860LR/+hCMATHzDSUIY0zNO+vSPWMMu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6837c3-5db3-4af6-c9b9-08df4c9b242e
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 15:28:52.2730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVLke28aOskgWTQk3ipnbLUPu0/yZRTvqPemsSs1JD4hn15jNiuqwcUq7N2ZCZKavA184irctWLmM6GBI+SiTzbUGg9QEoCnncuWMS0l+3k2gxcz4Px3w3oSEztO2jmQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 04:15:28PM +0100, Luca Ceresoli wrote:
> On Fri Nov 27, 2026 at 2:41 PM CET, Laurentiu Palcu wrote:
> > Hi Luca, Frank,
> >
> > All patches in v13 now have review tags. Since we are approaching -rc6,
> > would it be possible to pick this up for 7.5?
> >
> > Luca: could you apply 1/5 and 2/5 to drm-misc-next?
>
> I plan to apply these next week. I ususally leave at least 1w after a patch
> is reviewed before applying it, in case someone has objections.
>
> > Frank: could 3/5-5/5 go through i.MX tree?

I will pick 4 and 5 after you pick others to avoid conflict with other dts.

Abel Vesa:

patch 3, should be picked by Abel Vesa. If he agree, I can also pick it.

Frank

>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
