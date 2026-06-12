Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CEDCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA0E10E9EA;
	Fri, 12 Jun 2026 12:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mkgUzi+h";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4CF10E9EA
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgxSt19v7hABTBiLXlW6QZ4lxtKQF65mHFy1R8b3HFeGkzwNMdZMXf5xYjIbG0Rxvhj/FgoBhUm9rOVheB0sFOQTv3/K8KXDb49uNKCUUZMT426MYtPMX0CEbexSeoR246QqbuOmPqSyiWrPJ6hskC8EPAjUrcEHExW6jg9ytBNcPOv71CfqN0ODsXesRd2FFy2OiNT8oeBCYbvPhT+dE6bn2sxDGVSt1dJHam8X0BkS4p2VmV8iainXWADInsok/4tV64OioD1BxssAYeejytRGA/Uy80cbUyOxxYFjTsz74YXh6ldWq80y/MViFvZiyZ7oYVQ0/R4seMAMyReniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYSm7T0MpOCdG75PhBhiIgFNCNrvtpS8R0u/tqJ+e0E=;
 b=vg0FCT/nry+c5JPjpqO8bHg9SnMLHpN5ES8VTFSOPA3Dwm2g8vTWTjH1IOFs4xhzGOy7xAdmyONGCW8yWYOcRZlaHUC4biD+tE6QZMagGLD9Tc7urCYyPspB9TdKs5oFoSssnIJM172Pe1mZitpi6QdFcsnWtIiBqDjLnuwKttxxYQ5OkjFiLTL/vR6fY5+YmmnpLENnnGyx5qD1L0ZzS+radLpjInbM8jgb8Kjmf38Ihitt0fq65qp/FsIX6wDc06sG6sW5LjkMJGXAOQ04L/rHJgOpvyJ8hpUMa9lLrM1G1V/+WHCo5hUzuuZZdpXak8343fqLEUF9o72cHb9Avg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYSm7T0MpOCdG75PhBhiIgFNCNrvtpS8R0u/tqJ+e0E=;
 b=mkgUzi+h7hEbM1OuECw8rB5wV0ajiyBK9CDwWbXcRD2CPQdHZLqKKNieXoczMqut94wXoglTym0+0WKRRArgBbdSf9Zk/8g6u01sVGWXfZu1TiCg8zFoOhAXKyJbEffqRAcIheTvXztxe8YSXfYGnuFIMMjC5fxB6lEXIfHjy7ScIPCoiZOl/ub82A4Niaq0nAreUP6Ix6/oy+TqQEYQTQHG6If0eiggK3YXXi9nAHrHlVZlLCARSfyEiJVLE4O2h3j0dEjW3wgp0pjEUflfi63sQlFJ8lfhCS9WSKizE63Z3FNRqHK69NV9sqg5aj3NjDpEOPjvKH+d0Dq3T7p+Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB12583.eurprd04.prod.outlook.com
 (2603:10a6:150:36e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:06:09 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 12:06:09 +0000
Date: Fri, 12 Jun 2026 15:06:04 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: imx@lists.linux.dev, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 8/9] arm64: dts: imx943-evk: Add display support using
 IT6263
Message-ID: <j5vepskpvtth6s23zv6p56wjxjwjqgmvi54ot2lntkifyagda3@35jsrhyvoktp>
References: <20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com>
 <20260304-dcif-upstreaming-v8-8-bec5c047edd4@oss.nxp.com>
 <1a3d466c-c1b5-49f1-a9ab-1c827e906e91@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3d466c-c1b5-49f1-a9ab-1c827e906e91@nxp.com>
X-ClientProxiedBy: AS4P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::11) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB12583:EE_
X-MS-Office365-Filtering-Correlation-Id: 79806e62-ba6a-434d-b64f-08dec87afd26
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oH+2xIZMPCWSWRq+5YJ6IrnOZROPJeq6QtYyMWfKtrNgQ4tmumRWg/8AzLXffPP0Br+/fgMATArcXPXyrSPf5FdLKz+CHjp/m0U1awgJ+cxogankZOAlYW+LPqNCgpyFaXJzJNawPY81cEMIxyw2ZIT0OCCSjPCy13HNNa8ioSCwxuNT/fM1CB9fcvPiOXPEnHkEhuz7rwH2EEjUp5TNIi4rgjLgBzKSAwTbVBueCC4r1j3ei6Ju5j1Oka1s8WtA50nrdTLpTOWuWe6hWDTzRT4bpc8T1GnbIReXMWDZ/vovpc5bSflXOYARnJ/bBI22wQCuANKrsHDFNyNygmMz7Zwaw+jZbbKsNciawde4rjcQB+Mvm1dAgbs42riM+nXjJWnx6kCoVf2TWtwkuE+fIhe3pBf6QXbgywk9R9R+HU07cf04a1s6IH0oxLXP5p8j0qqllPuMTzXBP3Drwb5dlPDGTusYHjwuRH4uxf9uqZYT7Jam08jkCSNXcPs5CklTfcrdJFd9l8s3oWxLONMlbjHr4Q9J732XMve//pSBfya7MVMbviF+A7WR0dekd5KkvjHQ6SqnFn4kd6ttXO6+h4/r/iQaUJgn1+kGjtoqUMJu/OB10JokdSHGiKV3yRMDjd4CQuS2236VEVHPfMqTaqLsIAt+43Y9ppAMxydV510dqzwN/JxNIRKBk4yV+jcu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vWrvRMbKzfToJAAw2xHLpcBclBfG8t4g1yI2ifjK0AeuJ4vg6dh/FmvqCUO?=
 =?us-ascii?Q?YpF8d8xRJAoi9Ujvpmp53dVYAhcibvOO/7GqhqMsfVopA8UWP16P61iBD3G5?=
 =?us-ascii?Q?9x5YHQHzk3UKyphvi8EXY3XwaLZfBTzIQ0R0aUxTqh7M4kK1sHYxZX2x+6Va?=
 =?us-ascii?Q?WersVY6KNqBuFdNRQw8061DVLVZXMym5FZi+x/SGm2/Hda3ApA55lkDSceTz?=
 =?us-ascii?Q?glLihju7wHkjACBdw9fyAxqY+aiazwCB152Ht9sQWPuYPrVcHsNCPJ+1eQvu?=
 =?us-ascii?Q?qOCK7n5B++rgMxfx8XAROjTUrb79nlEcxtv7l97Cry+23to/Cun0o4JZTh1A?=
 =?us-ascii?Q?gItKe+Mdj7Z9Ie+L+47rQ8H2aByAITtdSkXHM36SLOSEn0JiKr/PHYgVGg8R?=
 =?us-ascii?Q?RePXN7anv3BtnCNKOtyk+/JjhrHXIB15KGk3NqpFw4QeB99yuecAQW9Xt7wZ?=
 =?us-ascii?Q?E+JwVGEi7kWB4CLkeblXdU5o1QmRYXqgkFYx7A5cyAnQxgX1cBC7ud+FeDdB?=
 =?us-ascii?Q?ly9dNV546rj1l194GKab1TjDo0pQxIDAGmHxd5qeobeoS6vMBHOzZ4qvmyKb?=
 =?us-ascii?Q?BYbgW4fyXJyrjIZFKs7Udj+kd7fGXIkSnjvk/F5YCjQPBWAqtjTVaotOs8Wv?=
 =?us-ascii?Q?4qPT7XZG/ExcVzmhwvkJpBe3c5MnpTidKNYftw+h5OhMCMK1KHvbqOCbAdRb?=
 =?us-ascii?Q?/fWDTEWezlLFLOcDkZmQxe0TC1LKo9JfeUZi9xRmPI9zyk1pnxhvl2XfSy88?=
 =?us-ascii?Q?pAi8H2cHnqiNKidW6lp329MQ5H0iowx3YHdj/XoQkr4NUNIlcV9kukvUQL70?=
 =?us-ascii?Q?LVdmQV/2oBFbBLEWqsuhdxLwEmbjj88KeRNkdB6b8Jk6AN1lCHh27npv4KNV?=
 =?us-ascii?Q?RzN2QVS35ZoCfZjEWYrZMr0aAVhOkYLhJVTXiZno/HovQWkxTOb/2Lik9TW6?=
 =?us-ascii?Q?y55P98cv13GMUomZBIghDQ5rV0ZbOfnI01e4bYrD2z7o2aGv8Dc3cnRprU1v?=
 =?us-ascii?Q?3zAx1y9nkalaPq2MLsaU/GFxTTDeg5JpCthhRC3iScM0PS1UNNz0FRsVldXi?=
 =?us-ascii?Q?HG6AW1zfPw3swn6QkGu9lf+dlu5yGVkvteRjF/0KKl2qrfUc5/J/KTXVtwqD?=
 =?us-ascii?Q?434Rc9h4r/h9FTI5FKuW7bsqGDkddK3tdETHrjHRgPyg+C1sYRYqvblBXobu?=
 =?us-ascii?Q?62T0uS6CrY7gEMzwRIV+1/UvOQMTChK17HtDa13el0e98+a4GEegdkaNQvdp?=
 =?us-ascii?Q?yEDskZ79Eddqty6W7gtB65iE/zL/xOLYaBZddy1Pgqz1vV64c3VH951lgjbV?=
 =?us-ascii?Q?eH5HQl0/IVfG6FqkEl02AwZd/eR/1wLETWvXf5dMUP1rDjO7z3hB9XuqrVmy?=
 =?us-ascii?Q?8Uo10eiKUXsW7erdK/tqMRmTQTcLJxlFo+7Kw2P6otL2Eb6WgfIQSfZjxoYs?=
 =?us-ascii?Q?nPWgwwzMNftP2v5holRAE7TMye9zW751abJJOlLOjtXqBi+1wXgZiwAKfl0y?=
 =?us-ascii?Q?KXSeqOrF0orIfJ/SYR+n8JhoL4MiRWpFr8dtFxM/wtJbdJ4ELZT6dO8Sj92O?=
 =?us-ascii?Q?Low8W75ysQCXpV9qkSCfGYKvr/Dfgds2tqOqX695HY4wGvpLJfyPKZYMunkH?=
 =?us-ascii?Q?z7OMUtRRgbKdTZSSWiBHOnb0MNq4oPr2n+P537BlNUyZkHffFyCJvQHrKdUd?=
 =?us-ascii?Q?xKAor/gTmfUNd87hsJZh4cMXUZMFPY5DlROiwsUitrMOnCbcxAgEo2cJlqPn?=
 =?us-ascii?Q?hfUUoM2/hUubcOqcM4jPrBXHN5U0I9E=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79806e62-ba6a-434d-b64f-08dec87afd26
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:06:09.3193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFPP9P8QWnJVma5DHNwllYUYP7NGp/+la5OacBR4FyLHOSAe0jG3+KcZg+CzpQncYeIJXNhT/lO4G1HHjuWQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12583
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

Hi Ying,

On Fri, Mar 06, 2026 at 04:45:25PM +0800, Liu Ying wrote:
> On Wed, Mar 04, 2026 at 11:34:17AM +0000, Laurentiu Palcu wrote:
> > The ITE IT6263 based NXP LVDS to HDMI converter can be attached to the
> > i.MX943 EVK board LVDS port using the mini-SAS connector. Since this is
> 
> Since the LVDS to HDMI converter can be attached or detached to the EVK
> board, it would be appropriate to use a DT overlay instead?

AFAIK, imx943 EVK ships with the IT6263 LVDS to HDMI adapter. So, I
believe it's preferable to have support for the adapter in the default
DTB instead of a DT overlay. 

-- 
Thanks,
Laurentiu
