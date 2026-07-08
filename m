Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3D3C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B3710F3F0;
	Thu,  9 Jul 2026 07:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="hAIuIWT9";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011030.outbound.protection.outlook.com
 [40.107.130.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0DC10F0C8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 10:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzJQnuKutMvNfw3+ANjEeU+kKd1XXWVigJt2JcB4LSBwgy6fAzAQNPY3p/CgGWo1MQxD8IT3qcTSi9iuRDHj/KB8T78DEtS7c8rxEtp4pGForeO/mP5e4QhJYmHhujvhvHTFRuNvfUMaRi6mKXzjFdaJSKJGDCWcKi13cDzNPZtdUh1I0JG/EDbB3jPequ06tTRcERwUMwQjeHABB8RavHsvqm+3JqJusnBcvQTTpPx2E/AMXBqpTrQ6zL+lxOJ8R6kTt/flTDr0UNQ/u3oiQzL277pSvlrWF5MAkxTZ9e1tKbdH5cKZRTQH2P3z/oFgaa/cC9YgXYYJRwCDIL8kEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8chOk6hWGGKDra0zgAKlWr72IBn866d9gmr/jHsXvI=;
 b=QK48LRcCt94qk6Mpab+6zKcH6jxiy5Q2MV5ZQHQNoPqxnttNTxhq4jwYCRRgTUUuRWpEp9HdYzjWLSESYPTxAXpd8IQibvTgPMAS9niMZl1a/N4jKFgfuXkrcGdbFNtusB0EAu9h6R7IYfiqZRKnaD78TSSc9tgjyqlRa80wkV5w5SDLINYjeAFoxBuEmjghOTSc1bCaC9aHusK7MCpwc+0FUNyh2qLnFOlj+1Vi0MfcrjTUvlVNf55UlONEmdKH3143K2UyZgLabm0ZIXPgKBOKniIx7uCdhdS2M+9VTFReDNPePE40sexhLYXx+rEOITcYD0YUc20ENO+0IktfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8chOk6hWGGKDra0zgAKlWr72IBn866d9gmr/jHsXvI=;
 b=hAIuIWT9Zy4ise4HV8GagCOMznet8kizyKtgv5asKt6tEt7OsRPj7ESKu9aeRd33d9ohhS/g+Cjpv+hHZ8XmC6sdALU0/+c2EMC9rTdptBW05H3hMVZ0gRWMKt+baPFrRl8+TkU1srf2OVBqyGheErk/3aswYM+e7A/ClmKmUnwIu+sqe4lpbKLVjTm0eYv2cDJCvnQnvS5+K5KVZsUKgzwgLJx4YLJF1S1oL3SXu2AKBlYXPTnwlFLrxJBRtRcsaqOE7gkR6DnceHPeSWdGOM73pcrZG7a+0UxnBs9/LKYA52865bONHelw+mlK9V+uBdOEI4zeTfc/quMxtA2WXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM0PR03MB6131.eurprd03.prod.outlook.com (2603:10a6:20b:15b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 10:57:01 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 10:57:01 +0000
Date: Wed, 8 Jul 2026 12:56:51 +0200
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: Conor Dooley <conor@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: display: sn65dsi83: Add reverse lanes
 property
Message-ID: <ak4s828nftsdeKx2@mt.com>
References: <20260707070244.230546-1-wojciech.dubowik@mt.com>
 <20260707070244.230546-2-wojciech.dubowik@mt.com>
 <20260707074500.CAF1B1F000E9@smtp.kernel.org>
 <20260707-aching-clutch-a71a6492cde2@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-aching-clutch-a71a6492cde2@spud>
X-ClientProxiedBy: ZR2P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::6) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM0PR03MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dc3463-8908-47ae-d05d-08dedcdfa391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|23010399003|376014|366016|22082099003|18002099003|56012099006|4143699003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info: gnrOkLoj57yJCdRuS+K79YPs3GpT2ktlYT0bvdBI7SPPgVd+SL7HbXJHF565FltW6dzoPmlZQX66K3NhDrJNy8b4HFRQyafXipHqWrRUDLbqmGt1y5LtYXrdotgRyXYAROTUxFauijEIVQv7aF2PgyHBIykvWZA0fT9X9U89g69KCTQj5y2t2CNnRYXKTgMsZNpJdXAP0XOYPH9AXCOhrzbdslHZ1FFeAsBsaSJFUBs6GSu9sELUe61/lWZFZurHFPgcYPTUmkCWlrouI/CPqWevDUnEpilTYHdZuzDNbH9qMwBhk4zpXU27PwUd+5mnnUnFiCmgnU5R/LTxqCSz5nxiy+kYrUXwNGMHELsko8gCGe+Q5UPmqYQ66hNAG6UKBB6RT8HaXlXgJdQG0vh9SH45jhh3jV4Rml2Ck/cJSujv7vJaBnISBRF/i9YM6uUAlth7TFrW6mJu89nR5Du4Z6KdidcD73zAWpz06KMsBwlhiasGvLIu1SD+OoRvQY0uNFnCSxLrMybxRzE3e43lTEru8yww4wS740GDX4S/MPAEWeDsjvidFCp73PZjZxtxEgYjW2qjyH5KUQDqenOY2wtKLYW2oHuuMbtkv2um0LYOu1JIKcCq9jsjEJdeX7jg4PmmeS2eu5c/e4Lxvc7lQYTbMY6P8UeFYO6erYKVYippVq/zm7ovUNFgMSBRmwSge0jSi9q6W+zG7wPUWhpYxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sOivttG/nCLEgwhE6lnraPd5TDlOS4ifLd8AvnZ6aWpwrxQKhY5ex0Ufiwyr?=
 =?us-ascii?Q?2YG0wje/zaBw9rOeW5s5GCqiKsdQzZpty7XR2CYDT+RYHc1h7QIGIfaC3LYF?=
 =?us-ascii?Q?41DkTYiF6SzrOtnmVm0BbyJoEoarMJnwPzVoyTJmNHJwNl45koXmlS83WbNg?=
 =?us-ascii?Q?A3V9UgZTLqhdUpGrShPOJS+OMvT+rb+5jT1JWNnWZOe3t1iXSwKMs5ghYh/3?=
 =?us-ascii?Q?JABIpNQ1znBFmXMkKbxdlRmg1/sNbjdTbPdnFzrapuDV6hbdVfy9zz3MSEDN?=
 =?us-ascii?Q?qc8Pi+Sor0Nn2xyjY523ukZhf8CzkxbBPFjGCwb9WWZprCx9koKYuzaPn6sf?=
 =?us-ascii?Q?xu4sjh1nNgz1kRq3/basENDrng4FF+592TMZlBIno+bbqOl1vv+l6QnSTumB?=
 =?us-ascii?Q?ha+6PY0fExlcrxzFPZfsERko7felpZxxbT1AXyrTo04VgCbbrZW5T2o71j1o?=
 =?us-ascii?Q?yAqzKrKr/6ozwyzN8EaxYUyegf+IcyCcBORwUklmNQ1PAnabsJitE2qkeAhg?=
 =?us-ascii?Q?RdR7JG+c8oaaAZj0gNutAgKM4YfMe8pGdQq0x1SadDtJZF/kW00nqu55Yp/J?=
 =?us-ascii?Q?apVwNQjA8ppaCQtTnwMJXOtYX9KtnFdKMcuYRdw9IHAT5q24Ic93U4uZ1FRz?=
 =?us-ascii?Q?O6snb0dT43UygfDqbmuflzRS366dBRmm3Hn6hnc3hlyr2P23Up2cQcP2tZAa?=
 =?us-ascii?Q?blN0JOPyNkpG0D6ikrk07kypWzu7TP90sp0D+Gf2g58N2l2rZ0RmajWwkQ6o?=
 =?us-ascii?Q?5eonie6NK6U3VhBj0a8OK/DHxICNzlVrnzxggSRWN1Bf+gcE/R/ptbPxn2hD?=
 =?us-ascii?Q?sJyfJv7VnDOvG0TE3lEIBh/pJyel3ry5d3/9MsYHf6N4CD/xuxfbFzF1ltst?=
 =?us-ascii?Q?pA48Xqw66pFjnRw/ydrrR8w/TJu52banJQQgId8F28CvRPGUJKro/dcJGR0I?=
 =?us-ascii?Q?fzb44RdspKHybx0bpBsPasD15L1JC33GUa8Ymb3n3AG0wGcu62pwq3MtFxLO?=
 =?us-ascii?Q?tk/J0eeZSsILe6aEz3B3CIuotTGOtfdF2rZ28FpvypRfqMgT5tT+6RQ5aHip?=
 =?us-ascii?Q?iwNwZYm5IAhNztudZ+Q6bcFHQhu/Mgs7pbPjAVG6TU2en6vKpoC589N8EwU4?=
 =?us-ascii?Q?0dJV3xvflMXpGFRin8kuMKLRoBPG4w8d5ZfBch2TwGp6JwABaLD0D8TC3qa0?=
 =?us-ascii?Q?oOZ53go1BbCn7ZKnIeSryKq+MX0sp00FchXuKtFKSB8NKHM24i5f1bWwPhsT?=
 =?us-ascii?Q?ZIIfKBcqFsPtBf4WOe4+TtoF6njcDFg5BUCD7EsZoSR15evWjW+C7jNEFSgd?=
 =?us-ascii?Q?pdXbt+U5eLPJ0GOJVC8xzd7bU7bnsbzTKYSuT8lk1YKWoxRueFzr1iOKpMVq?=
 =?us-ascii?Q?WMBo/0nP0+o3jI7KlOIfHgIvvP463sngFReYTKtxVCtiD2ByiJgbZqy2ly1s?=
 =?us-ascii?Q?yXWpk1lG8Sx+3SYNSfx2UKayL6hxKSFTe7XvR7UMJySGIodK8P8sHvdU6jq0?=
 =?us-ascii?Q?w2Rz9dByeLKkOZaogWvBZlE4oHjTQSP/a0TuZkByn/VjyD0lFwbsZFyXo7fW?=
 =?us-ascii?Q?lhzGmu42YXSI+0BknYbROrooPBB04TbEsoWPUSVOonbleH4chjgi/0FHKWer?=
 =?us-ascii?Q?FFSPMkHnr3b2gq+i548wVwGUfRSZsuHJaD1oZFfLqCItRaYYXMqa7e15HxmF?=
 =?us-ascii?Q?p0ubmn06yqnMusBT9PYoEEvdZuH1pAANdrxvaQhZZFu1Vua2FG2gBK3sj09q?=
 =?us-ascii?Q?QmaeNsUhvg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc3463-8908-47ae-d05d-08dedcdfa391
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:57:01.5251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFfJpUZtQNcDYni/24lLUd83uCFbqnRlrFikaigoFCADa6Xl4ExwLGfYuaKDJVg6OHL14kttXENxnrr4anijrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6131
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

On Tue, Jul 07, 2026 at 05:21:19PM +0100, Conor Dooley wrote:
Hi Conor,

> On Tue, Jul 07, 2026 at 07:45:00AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] The patch introduces a custom vendor-specific boolean property `ti,lvds-reverse-lanes` to indicate LVDS lane reversal. This is a device tree anti-pattern because the referenced standard `video-interfaces.yaml` already provides the `data-lanes` property for this exact purpose (e.g., `data-lanes = <4 3 2 1>;`).
> > --
> > 
> > --- Patch [1]: [PATCH 1/2] dt-bindings: display: sn65dsi83: Add reverse lanes property ---
> > commit c30eea01a74188461b7e527f71d282d68b885ec2
> > Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > 
> > dt-bindings: display: sn65dsi83: Add reverse lanes property
> > 
> > This patch adds a boolean property to reverse the LVDS data lanes order for
> > endpoints.
> > 
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > [ ... ]
> > > @@ -115,6 +115,10 @@ $defs:
> > >              enum: [100, 200]
> > >              default: 200
> > >  
> > > +          ti,lvds-reverse-lanes:
> > > +            description: Reverse the order of LVDS lanes.
> > > +            type: boolean
> > 
> > [Severity: Low]
> > Is it necessary to introduce a custom vendor-specific boolean property
> > for this?
> > 
> > Since video-interfaces.yaml already provides the standard data-lanes property
> > which can be used to describe the exact lane routing, does this hardware
> > require a distinct property instead of using the standard data-lanes
> > approach with data-lanes = <4 3 2 1>?
> 
> I don't know much about display devices, but this seems like a
> reasonable thing to me. Why would it not work?

It makes perfectly sense. I am working on it already and will send soon V2.


