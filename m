Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48667CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA7710F093;
	Wed, 20 May 2026 14:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="l9CYH8PN";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBD110F093
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqT/H0+oh9fi7tbPUpiRtBBf+SYOBzsT/laWQjM+KIBLPDkBtPueeZaVca72yP4mAl9umkl6ehWzFhNWjWoukdY+2UgNMypD/VRfU/7/YYTH3THOcO59nDc+jcBA+p98XGubbbXLOLQXkYM5XDtnlaYtRPNxLhwXyGjQ6Yq0BtOuylUn/hlwNXSaJZw7RM63nPzZzGnB5FhhVYnQoDfs4m8vN36xK9sKoIhHoy0IBgN9bqT0LLWcDlp1CjlTRjxJYxKppRXnNCA3RtuNm7XmDNQ/5UuEyyZ3X3Z5QGP2VJAkN/dE+bUdfZtg14cyk4oAwuWkoroGDPNA897oxpxRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5N28J7Cnq1tJLT3fXxNOiwGQGlhT4yAogJHmjF3/Z8=;
 b=BVM/L8jIfXzbw9AmaTGK43tEyhfkxBgqVnaOYkGifWbpSDSOe2K9CX7RTWaWWMEQ0e/IDKskmRGMES2JiMX8qoyy8f9E8am1gFaO7ejHPn0GbQas65Zti8k6V0VD0kaThogodYJn3Kcz0o/dt0mdpKB40FAB117t4XO2RUGVgy0AbxM42ZNzlFtJWp8Y/sTLHd+I2tMifrNme28UwvGN6NFXgaHX3IU9wj11yMmsdth3pusaooB8HJoLTgJOWT914cT6xNW0hUc3oVFLqc2/zv7CDAOXgSdRzn0WXqzJYe6AegfQvhPSKS1DGCdYxz1FGX1Cqjb9EZO+NKNT8y86mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5N28J7Cnq1tJLT3fXxNOiwGQGlhT4yAogJHmjF3/Z8=;
 b=l9CYH8PNZyW+0ZuhtzJS8Q3k0wCRy1HXixO136xBD/rUkwUZtBvNz533X24sIcjpPtpIF5jwSyMWWSOqcrh4OhBQ1iNhG/yeqrp3W13aYL6Z1LceisCb1gEfvU18SxDMCphTqRwgd7a1b4ONM+g6p11NQbm6XPE9wi8Fg3HsA6lSOVOOFCbTJlNtVOxvECbdFOZQvi7UeWSbf7ZYh81klBKnCHP7NSjZHc0+xsCqSzdbBJ+P7CVLZKSZe31YnvWQ4FWNvCwUI7gPbkniWmsj/Zq3w70JYTh1jfQ+Y6jyRPz3lUNbBCH02Q4gkGhAP+FSp1zNEA1MGBMAb+chLLpzwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB5PR04MB12227.eurprd04.prod.outlook.com (2603:10a6:10:64a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 20 May
 2026 14:39:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:39:09 +0000
Date: Wed, 20 May 2026 10:38:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Maud Spierings <maudspierings@gocontroll.com>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v8 1/4] dt-bindings: backlight: Add max25014
 support
Message-ID: <ag3HgqxO0tpmyUCB@lizhi-Precision-Tower-5810>
References: <20260407-max25014-v8-1-14eac7ed673a@gocontroll.com>
 <177755722019.2606736.10749503716773482329.b4-ty@b4>
 <agyxLnTYstqRwGva@lizhi-Precision-Tower-5810>
 <20260520114745.GX305027@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520114745.GX305027@google.com>
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB5PR04MB12227:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ed04e1-6b50-4538-46fc-08deb67d8d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|11063799006|56012099003|38350700014|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: gmai5q9GCH31qcnc3dbV4eVLiLClctcafKw1G4NMdN/fJSI2mO6lC3DNyb7znJWwV0421YFxwXr51uQ32itCrH8eE1kbTXg3ckBeqlt1qR4Ll4uCszcR7o4RNYwxUFpdfKdOHoOem9XRLdyDqTRD7V/zQgtVA/v4hXtSl832a37PaCcSTH+gHEihZurK+ltcUk6S9ZhlR8csPDnC8Me+n91SN3K4fcn/LFCwtTSt4psB8nwVHXkPKivBGt1mzM24gQEW9A+79d8m6ujz7Z7oGFNOv5EcwmUeQpfl31+qMC/1xhKuqvuMoVgnZ2Ta6n+1mGXNc1zKAcPQCArnX5T/4Rk8lqYWl1XBuU6XsqxhX8cBdHaeiRpjS2BrgX2kmPCHiZdpfRtuHRXhGhocM2866TDWLh6hgXwBCG0skrZGbfxa/NG64gRTnMYCBZOvHuGxofdWiF2KQ6Obzj+nErhv2Ja+eTq040N42agcpzqkDg0mfputFE8tAinikZC77sdFIUz+z7fTI21GjxOvsiKdV/PKPiTQ/MNbgJ1xP+nJa81xjO4B0eZcuA4KU1idFZ6y9M4vs5NO2LzwClFHmL0vAexQe0KQl4rhSMd37uqxd3N2Ciun3pyj6IRQ3yS+U20fW42l1OpUGDtFpagBZJPCdPHBeEMkJGj+YeGZmE8ypsnAsokS5QvfB54pLrlCkoUNpV8ypsH026wzYta6Or3IUAKPUeYPn4GrPLVhe2cLR+VZJw2/o3c3e3kT1+hphgKn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9366.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(11063799006)(56012099003)(38350700014)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNdMUV8PKKk+aPM7jICX52OFey32Bys2x+WPgEduohv/N5erFAemP2Sr24BW?=
 =?us-ascii?Q?/3V1f0ph8CRKjF4M4wstVILpOV41pR/Sk9vt3tfjsIkdQtRntKBRIeMSlK/h?=
 =?us-ascii?Q?nUhkb4QZmBepVIWVb1wedDo6pzCRFw2EGoyyQI3tNz/6mti94lofgT96HZ35?=
 =?us-ascii?Q?1W/9SFvSU4f71ZmSGnYo0+zZzNhDjbFPcGn+d7UvBn6rK1t93pk1eMNdybsf?=
 =?us-ascii?Q?Zetaquhrkdg4ao5k74DFdxfqAgHbPCNsHvNRnzwgap/0zbZZxKGlFyN8e9E+?=
 =?us-ascii?Q?LJ699LTx/9ol9qF7BE5pFECOx9FzhL95rZdjCUNxld8ETHdGki+VWXee+6O/?=
 =?us-ascii?Q?jrcNlO2i7If32tPZiW8zwGliU63lcNnKZW//OaQ0oshxW+Tbq/Hc97G/VXgi?=
 =?us-ascii?Q?izoIEVyHILs40HJ0HQXy/H8Py6y2STZ4E+8I6bNpxNoMu1sbWMCNnQE4iSCq?=
 =?us-ascii?Q?qEZ3NpGTBUjMxQGdDlpAvMFoJuYEgDMd5kryUvvw7lhhmB/dDR3et8IPDGlt?=
 =?us-ascii?Q?249nDFVQHN1k8wMvJM4OH1SJBsfWnhYUMc3pvuXJH5c9ZlIpoEQDRS9iacAM?=
 =?us-ascii?Q?mGm7dd6ogzvtnqe2YqTa6dG46XWcjfM9VwQg3rEpsCyArHJBwGN97IQFqjS5?=
 =?us-ascii?Q?eSIDtUI1m0TIEvrbrroR2JWCtLs7H5aY/aiyTzNqKmiDWw3k8STO6FVrWoGe?=
 =?us-ascii?Q?Gz7srhDw2odxgWM7nMt1bwZ0ue5IIJSqsTV0mXZ6XqEHIcGEw+GnMALBQxRK?=
 =?us-ascii?Q?cuFjorfRerQuMfIjTCkYTMu8BBpBQI++GJaYc3hTKPSGn7Uwy2RDjt+LqZzd?=
 =?us-ascii?Q?64bhFuYbikhS/HYylc8YXboz4k+RhlMrqqwSzDx/BkgVN8/LTCQk8Qs9A2jZ?=
 =?us-ascii?Q?7vKWIJbpucbYG7d8RClNPV0dvRWpJDg3yA/DJ8EPd+G/E4PcYgB21msfwKAG?=
 =?us-ascii?Q?lv/axgpHkq1pSSKg9BFTnH3tpW/M+pihrcx+uy9qzFm0acFS3pI+Y2yYeFXR?=
 =?us-ascii?Q?eQsQ1ot/SxsTTeLsngVjh24lFD4WcL1YPJCFWWTfdumnM4+NkSfE22Oc0ROW?=
 =?us-ascii?Q?4IqAhw6eJf6LOeE6P1Z8Tn2ZLoNR0bY2v9e5YWLCBgDmzKQ63/zhKyiDEP2Y?=
 =?us-ascii?Q?nXtpK5Xb+1DItKcq7R2aauefvu+uisAJSFnOEiBmTr42GAxotX0JcwZN6dwT?=
 =?us-ascii?Q?SbuyDRzmrk6mE/3s1qObYGbCYV5DSRsFMnCOSBPtQe9Wn2A4v6jkk5iEQFY0?=
 =?us-ascii?Q?WsFNgcqbDWKOiylBzrSvyMEo/MbP3rbhWJYzoNNtIlNJZqvtut47WMUn+Ui9?=
 =?us-ascii?Q?S6cxC/9/Iu4CF4JyqW7N/H93gP5Ep1mWmw2k3nRPZLAiCL8JrbDwa63QnBWU?=
 =?us-ascii?Q?dnMTPE3GLpgiy7VObJO2Kdu/q0jlJY2nsVHq8yecdqRPBOZbtqcdpaBRTgCY?=
 =?us-ascii?Q?xd17c4BPw8GPgD3mbLgJwJ8hgmcX2R2f6v9xLa2ZFPtB5Aka4m7AH8pkVFuB?=
 =?us-ascii?Q?JAqHTsi94bdxrwh4aKx/b4IDkB53e4LasZ+PNLgUsd6sYKwzbYBBtVPbXUwk?=
 =?us-ascii?Q?IH1+gQK07+kAjI3WlCjbFpnjjvEYq9uqAc1c5CnSErgTaOQYoR5eSO0Sndo8?=
 =?us-ascii?Q?EO99wab3l32wu0RiZGeHoVas8+kHzIbHWqvqw4Yk9aJ94c1iPmRoF1o7nx2k?=
 =?us-ascii?Q?AwpGwEkKYNMKb5BNHZ4N9ZIWuiJzbO2Eh3JmjeCYkJLJVn4KNqTuoq8l8p/C?=
 =?us-ascii?Q?LQswx/omMw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ed04e1-6b50-4538-46fc-08deb67d8d81
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:39:09.6676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1gLMW0ZXkXPuNUzCpInwrs2VmwD5QMThPyYCfYutshNEXWMal56k+P/uodbYVBs0TSsr9TqIWkbEmw3Za1QsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12227
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

On Wed, May 20, 2026 at 12:47:45PM +0100, Lee Jones wrote:
> On Tue, 19 May 2026, Frank Li wrote:
>
> > On Thu, Apr 30, 2026 at 02:53:40PM +0100, Lee Jones wrote:
> > > On Tue, 07 Apr 2026 16:41:42 +0200, Maud Spierings wrote:
> > > > The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> > > > with integrated boost controller.
> > >
> > > Applied, thanks!
> > >
> > > [1/4] dt-bindings: backlight: Add max25014 support
> > >       commit: 5fcbbedec9dfce78044eee922bf2030e1bd03faa
> >
> > Lee Jones:
> >
> > 	I have not seen it in linux-next. Anything wrong?
>
> I don't know why Backlight hasn't been added to Linux Next.
>
> Rest assured, it's applied to the Backlight tree.

Thank, you'd better check with Mark brown to make sure it is merged into
linux-next because linux-next will do many checking and build works.

Frank

>
> --
> Lee Jones
