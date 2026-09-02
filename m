Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430F8C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4D710E021;
	Wed,  2 Sep 2026 15:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iZii7XVY";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011018.outbound.protection.outlook.com [52.101.125.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87A710E021
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:11:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cmwb8EUmz+MXNvm43YiuVFXs+Et4ayCfX0n/k1cAKekomoet2gpjQkfFAaJJwg9xmeacqkctVCpl0Gtawbc8tzdm+Fb4PILCTEaCI0CIotc7qbsfA6bTs6mxlIe6FB4WLMDaoMOp8kQxpgS4rzyAQkpb6qFOUBjqdDy/kdtkKVactG6RsZN0SBUXRIVEJ4tuoKpL/mW/EgW5tJeqNtwz0PFfnMe1VbkSSuU7pvt3yJ8NUyw3ewEpcq1iQIUeB4jhjnQ5vSxIidro+o16MNRUoyJLxnLquviCr/4P83CmpAYlqd7HDhTE/eBibxClQOIbI3XVmACZ8NAnBCH09t5bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGuNFcyiAi0Q866OXbMYE1cLUmMrDRYH5bTs+DMw6Ps=;
 b=ystMkRVoGMg5NAzzSsN1sK8sYAV8F2wZRJI58H/KNs1m88UJJyO9A+UD6d/CjFge2rLFIhvLcRqgHLqQ63TUn2NNQCv/2L1nNLOBNgYzlz8UyKH2sP/cw7SafrwbRnkJ3iWMJe6sHnII7v6sq6RSy5wfmag0gvKpkanl8lZEwIOBu/x3mTBqpHL4d4M17rFKVKY70NT6YmfprGmsG1nPx2tYnAhugIfr8OJWcc3lLyrRDfUBoy11PimYQUPoB6nHIA48Ztf67GQV8wuUwHf2/NaovDqg9fBwy+Pv6ySE2lQt9BXpM66XxU/JF0k66N/dL0qIsH6k+2vjxtfbTjpLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGuNFcyiAi0Q866OXbMYE1cLUmMrDRYH5bTs+DMw6Ps=;
 b=iZii7XVYsrOqS6UYrdL0zXq5Ccx+sS8AQWfP3caSOiSToTVqkkY03Cxp0+QYbgSyJf6gtWJ7wCcjjB3jdZdcvRWUdB8OMGTqtB7HfOQfjKLQBqTmE3vERWhkrxpcD2NvyRfXUIJ6EnYelRUYamKMRxgEhS2OWL955RilwcSnEHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB16836.jpnprd01.prod.outlook.com (2603:1096:405:32d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:11:39 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 15:11:39 +0000
Date: Wed, 2 Sep 2026 17:11:18 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, tomm.merciai@gmail.com,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
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
Subject: Re: [PATCH v8 1/9] dt-bindings: display: renesas,rzg2l-du: Document
 RZ/G3E SoC
Message-ID: <apg8luaJ3eobK8sm@tom-desktop>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
 <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
 <20260902-heavenly-ambrosial-trogon-b7ab03@quoll>
 <apgsOubuGuvw_0rf@tom-desktop>
 <CAMuHMdU0y5Dg9tW7fAM3QQHKpAw_+vmjj7v-XeZmrushQgQFAA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU0y5Dg9tW7fAM3QQHKpAw_+vmjj7v-XeZmrushQgQFAA@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB16836:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adebf9b-c91f-4d66-7b97-08df09047c96
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|38350700014|4143699003|5023799004|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kmaS9ezE6AQusR88GeNuH+lRkaK8Cnk+1oNMENzdPvV+BobtETALe8DwIZy9Roly+f/oX6wJe7x0VxlRXqUnsRvT3dcNljFsNWhlZNpU29S7v9COfv212Jptq8gnC8F9/j8wP0Bx2dvHvF7YtDLzVmBYIwqoALYNU71L6IWp3mDOL+d6vgcpODKSgHztsxxue5wDDAaaAclBAMW0fn+Ff9rF4+1Y/XMeTdpqpPgZa63hEmyfY6wnRAuH8JtvY3jDPlSC97J9gPqcjgxYlNMUhOCVUHwmQIq/BhDxKNm/3SA6omIn/KL+EtdbSVvWTkS+W7jtDaNX+wP1dAN1c3ymcf1i0zGMc+PVT1h84iwd6MiJCH+p9+yh3tegM2i3HwUnP+94ZDDfTFygGX9/cdqS7VuYwOv4u6reAuzhUxXe56tBn/Yqg6bprIrab+vzwMqaIw2MVUsYVq7iudbtv5o3+gLef6dIqzXlDoSh+PnT7y5BoTqjyLCBsvH0KOP+e8LKJiMy1lOx+xfjh4ruAC+kfK7dDuvTEKD1Dv4ZdibfyuIw4epUcAbTOhz/mjuWCgBloI/AG6ELyibyNrSHdb1UFx+Uv4DgjpWhoVdF4hVtYT9SSgfIbmoZT58eyWMb5YHpVev9aGGZg2wyVgNu06NkM3kX7yqROJzhmbfayW7Pps/dIpNfo6G7TjCS9NSxmPscVT36TQeG0PSioxLHKO7lj5ypF8fMm/QllY5WP8aFbnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(38350700014)(4143699003)(5023799004)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iR7hl3UcVJBAPSm6pWDU2mKzDBjpZN7EZqbGWB9J84noNwZTQH7ONjZGyaz9?=
 =?us-ascii?Q?BHqFApQGj03pF9SrdqKWJQtwqJG9v3vpfXdjipb4/Yp4IdundripQebFO+mC?=
 =?us-ascii?Q?r1YVkCmOK/VzxIlz/PJurPLh2vag7LAgJOH7fGJaf/9QHOTccxIh6a7NkczM?=
 =?us-ascii?Q?5gT/IuklF8/A9/ovQmifl5vjcq7c1YgOBbklAqP1MTqkTm7tOl705xGQ+6Hc?=
 =?us-ascii?Q?EPBcRFKyTMfjEys/SDDa8QvPLw/liSBuHG42UPgnpOqZiqWh4F7D0nRG36Bq?=
 =?us-ascii?Q?jyDTiDzdoPzw6TadEUgu3jiKLxcuD7tUem2KOhlk9B5gD4Smn/ntfKw9GKq2?=
 =?us-ascii?Q?I3RBXZoQL7EmOLP7RswoFpxO9GT4vTeHEA+Ct0SATg6RtP9IZ2/5DVSvRvkc?=
 =?us-ascii?Q?EGSYseuNwwr9j9tBMWq68cMCt8EXWQbUUzi6HINrxWNPJebckAA+tZbhfscr?=
 =?us-ascii?Q?I1y8R1R1jPE9tCqZX1JeLC59l35tvsXQ/lxCKRofMOrW7k0by/HUAjZpoRNo?=
 =?us-ascii?Q?IyPxvWA4nf35iRjhP26GeHEn+KlvYB90/j3qM0tJzrAgB/ogdgaoef1ZvaUO?=
 =?us-ascii?Q?fpbA+0KPqFGZkm91fX6wdo4CsKB7UUD6tR0JwJmKg0LbE3BvD6JlUsL8ECN4?=
 =?us-ascii?Q?xd1IQUEvEyTXds5RavtZbuGcWmhITAeaYwZay8JxfBK3N0Nx3b+uAOLdRtxS?=
 =?us-ascii?Q?zQ5ajGRuz6vn82ndhgd+NWG8PpLXDgPq+/LCm/30pacfcMw6citnWvJTY7uL?=
 =?us-ascii?Q?lJk3rhT7MJRekbY6NwtWm2XL0xdOnnl3xYVHl4JblUA6u02Pl+y8aFB/YLpl?=
 =?us-ascii?Q?3xSTf3E5fYLRy6M8Gj4lBfOlG7QTSPaMHdV3HcHmGfR05TCVjYshGjYxgNcn?=
 =?us-ascii?Q?2b2wciKxtpUEKzuZMsQCERRo1BZhvWVS0XL2wRfOK7CYgmXoZVT7K9/xc710?=
 =?us-ascii?Q?B4RPjprMZoL5dOM5UcwRWhdXpNd8Xan74dA/IpyNpy+c/HQn89vCLyxwODM7?=
 =?us-ascii?Q?1P3rZvxw9yzFGU+CYuJXyf1ovQdz6kmWErnckKDDCGZC6ikHCI+zHvEtlTmD?=
 =?us-ascii?Q?AIGDVsg6hNmmkiRY1wohn0lvCRiEfwC4A/Zc55EsGgNlIBkJtizFWieQpmMR?=
 =?us-ascii?Q?pWwwsiba37ElXIBWaunvONUJuXTs5s1nxZgLIO17j33n/+T1fSjmVL7eM+Me?=
 =?us-ascii?Q?2/h4Px7G4QTS3SHBkHiEjxLNNZXoRTfpx/hyYexd+pGNuPXQHS2bsHO3s+3A?=
 =?us-ascii?Q?Qm4e2ntRf/unaUXCfpm3do8hCBQgVTVnSN+cgGZHsgLf1+3vhJl/R6RpykIh?=
 =?us-ascii?Q?h/cMTBr9x/ZZoGJ+mUsSHTfhAsyF+MSd9NFTrkdCj5Ckeflbg+j4w1BlIlC8?=
 =?us-ascii?Q?3BdxCGTsNuiqy44sB6Q2DnDL+lDbcvKHx9f9mQ+8801fgrsjWDkjLU41NSX8?=
 =?us-ascii?Q?PliKYbw8HD6cbmzOuCHqSsFyuwgSuqyPmgz6W7UwOfaRu7G5qnNzBQM4aOia?=
 =?us-ascii?Q?+E3DbcuYuc76vekfjyz7OCD1I4uxVETLNHCS8rXC+dA7TLqqhM7X3bgStb+y?=
 =?us-ascii?Q?pk1FnsY3aoWra/xeSUqRSd0kcCJsJP7/cRtbFbTdkg0IFiS8hBqgcw2EIZPN?=
 =?us-ascii?Q?u1AO1sSrZnjojYl0FeOCL0G3m3df6nA8gjwnozDj9WbRrcfR4uBRGBa03LVz?=
 =?us-ascii?Q?JG/Npj3j/l0SAQ1yPNsyO9eT13F6+ezYs81PZY/ZEDDSCMLVHVLMpe4rEXy0?=
 =?us-ascii?Q?kUlxGdcGIULcfDVRn10zB8U/q7p0YAV1OuLbVjK2lMzPtBXZIzJi?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adebf9b-c91f-4d66-7b97-08df09047c96
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:11:38.8952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUDoOya0Fs3XQoRISLxz77Uy8rqtP1Vg/Qed/krUc/ql3gq7fd2VVQWR5cx209czehDX3TTCFf+RTIbHQG9SF5Y1FXc+L7W7zPLUvcfITFsfWptOdw5XLqfeR55OkRj3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16836
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

On Wed, Sep 02, 2026 at 04:20:51PM +0200, Geert Uytterhoeven wrote:
> Hi all,
> 
> On Wed, 2 Sept 2026 at 16:03, Tommaso Merciai
> <tommaso.merciai.xr@bp.renesas.com> wrote:
> > On Wed, Sep 02, 2026 at 08:37:06AM +0200, Krzysztof Kozlowski wrote:
> > > On Fri, Aug 28, 2026 at 02:21:04PM +0200, Tommaso Merciai wrote:
> > > > The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
> > > > Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
> > > > Processor (VSPD), and Display Unit (DU).
> > > >
> > > >  - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> > > >  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> > > >
> > > > Add new SoC-specific compatible string 'renesas,r9a09g047-du'.
> > > >
> > > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> 
> > > > --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > > > @@ -21,6 +21,7 @@ properties:
> > > >            - renesas,r9a07g043u-du # RZ/G2UL
> > > >            - renesas,r9a07g044-du # RZ/G2{L,LC}
> > > >            - renesas,r9a08g046-du # RZ/G3L
> > > > +          - renesas,r9a09g047-du # RZ/G3E
> > > >            - renesas,r9a09g057-du # RZ/V2H(P)
> > > >            - renesas,r9a09g077-du # RZ/T2H
> > > >        - items:
> > > > @@ -35,25 +36,51 @@ properties:
> > > >            - const: renesas,r9a09g077-du # RZ/T2H fallback
> > > >
> > > >    reg:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > > +
> > > > +  reg-names:
> > > > +    items:
> > > > +      - const: du.0
> > > > +      - const: du.1
> > >
> > > du is the name of the device, thus calling items "0" and "1" is pretty
> > > pointless - indices already define that. Please drop the reg-names.
> >
> > Will drop this in v8.
> >
> > > >    interrupts:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > > +
> > > > +  interrupt-names:
> > > > +    items:
> > > > +      - const: du.0
> > > > +      - const: du.1
> > >
> > > Same here
> >
> > Same, thanks.
> >
> > >
> > > >
> > > >    clocks:
> > > > +    minItems: 3
> > > >      items:
> > > >        - description: Main clock
> > > >        - description: Register access clock
> > > >        - description: Video clock
> > > > +      - description: Main clock for DU1
> > > > +      - description: Register access clock for DU1
> > > > +      - description: Video clock for DU1
> > > >
> > > >    clock-names:
> > > > +    minItems: 3
> > > >      items:
> > > >        - const: aclk
> > > >        - const: pclk
> > > >        - const: vclk
> > > > +      - const: aclk1
> > > > +      - const: pclk1
> > > > +      - const: vclk1
> > > >
> > > >    resets:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > > +
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: resetn
> > > > +      - const: resetn1
> > >
> > > Drop reset-names
> >
> > For reset-names, I got the the following comment from Philipp in v7 [1].
> >
> > Dropping reset-names would force the driver back to an index-based
> > lookup, which is what that comment explicitly asked me to avoid.
> >
> > [1] https://lore.kernel.org/all/8382e2b9fd07fb1132c26e228b3899336fc1fdd4.camel@pengutronix.de/
> >
> > Philipp, Krzysztof, could you agree on which way you'd prefer?
> > I'll follow whatever you decide.
> 
> Until we get a variant with a third interrupt (or reset or reg),
> which is not related to the number of channels...

Right, IMHO names keep the driver flexible enough for such a variant,
indices don't.

Kind regards,
Tommaso

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
