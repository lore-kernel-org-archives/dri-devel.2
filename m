Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EBBC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B4210F510;
	Thu,  3 Sep 2026 11:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Sn8caC5t";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011054.outbound.protection.outlook.com [40.107.74.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2448610F510
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg3Lwttk3+9AttolzRGQWn5o9CSDNns4khnTuBnlKLfWNYOSwd+hBU1ytlo7lgJ0keUZ1gAztxm//K/EPtZGxf8KwmlRF/EzUDVodZaZqaOR1Rlw3MTy7i2TQns39SEDlBlscEOThWUHiZjS59n4y15MeNrpV2/+kmVzn2knSHBEhPz13o8zny19DzqpMXZI+dP7xAHbfpFfwLCNi7xYOlnC3MBD8ru122rhcQiStPUicBdNa0G53FNQXWEv1WSRnuxOZ4lIUjuDaKTYxXdloxXL9sW097/f4qy0ZgKc+ylUi6ZiP8eWUtDbAf6te0pnonWw5Bxl0uz+OkEJZdgAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDIeaBX7/gVaygDG5qNq9IJJYO8cKLgH4ij6u19VTNw=;
 b=yl1hq0IzhiKR3YUzjHxrbNlUxpgFUzm02lAPha6XUsvF97bS1vA8DL1ARJM9KS6rsRtQRFl+EdZi/l2ftCtc6Gh9N+k2bMQNF5ac4GigEJ/7JN2ZRZxXIEXWX4Aaf93JYaOdZY2hecyHxf/5CyvIxe9IjrX6aU6qt4Ebnwk3u3t+GhT3YyqsKiXzFi92zlYc6rRg0tkMdStljmdOAwKtrkj9Ebnmno0GLdtzTZyPdIf2EtnicYXNGc2uj6snqYHLRjowPD14FHidBa6gBLhooeJesiUuZR51rX800dZY57n8F+UY6k+wx/moXm2oRwiighRIzWFmsrM++cwFFm1MgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDIeaBX7/gVaygDG5qNq9IJJYO8cKLgH4ij6u19VTNw=;
 b=Sn8caC5taSS+ZI6pjeXVruXGiOFTwzxuRckYy4lUfM8K5Ju74jiiuF/NGJ302DzROz7x8mjxVXKojMfZ3H42YX8cloDCPW6R/bqFRfQUbwZJJ51OL4l2jsN00bQcsD5AvVAtoBxG8zoGjYLUFdaVYSt3TnIUP6nBeGUxT6IBJpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:01:39 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 11:01:38 +0000
Date: Thu, 3 Sep 2026 13:01:20 +0200
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
Message-ID: <aplTgBjpPX9d6XEh@tom-desktop>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
 <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
 <20260902-heavenly-ambrosial-trogon-b7ab03@quoll>
 <apgsOubuGuvw_0rf@tom-desktop>
 <CAMuHMdU0y5Dg9tW7fAM3QQHKpAw_+vmjj7v-XeZmrushQgQFAA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU0y5Dg9tW7fAM3QQHKpAw_+vmjj7v-XeZmrushQgQFAA@mail.gmail.com>
X-ClientProxiedBy: FR5P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::18) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 17362145-10d6-457f-1210-08df09aaba5d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|23010399003|7416014|366016|38350700014|4143699003|5023799004|10067099003|11063799006|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 5KeX3iuM9cRiK4HW1vhtVOL34fC4FCNCeQuuioPdgBRtCrNDsvZInHBjUv7Rc9azhIjILnaLptPbLENLdnpnj40p5knifLpyuy5TwEcaGdbgu8Oo8S1U/if2kLnv2jQDiXp9d/XScxVpq9IZ72A7ExlhfZMA4Gw6P3H2O7gnVzzj5+nzLNOWMIgBlPPggaBizZ+pMsuWBqBpafBPFoeyMnLmFGnPEH/Gn6OTrZGles1TsFvHZR/N9juuqnp4vTyHjG+DZXlfNC4UYjRh0/amSPlkhaEIAdNmOu3g+mj3sJSIpsvKNxLbWB0wDunvbMUgw2O+nrwr08BbyHrjugGkN70KIAf96z5/aFT49WiMlI5kmof+gtsuM1/q6lNTPBkNprVQ62RoxNUq+ZUO1S0YlOpL7R0+P8sqK2zTHJQmcCQH9BKVU6cMre4kzqOPie9RekqkmiDEri6muAZD/l9RVrAgY9rLVqBy4wVkxvR378I7/XoQRXdkSP09sTCsgCrtCIzeaSmNsWSv6tTdk16v9/2y6M5g4EY6SQSfiY023qo6u92AxpUtTP4UCmNRX33TvqPWDcAK1n57+31J2Qprc1Ta8oiGr2z/lS0YdG4qR97JA6pvYnrYzmTm/nnCxJd9nKEIXAI1VIdEEHahtnCsulR3AA8TLr58S6RSEQ/XTDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(23010399003)(7416014)(366016)(38350700014)(4143699003)(5023799004)(10067099003)(11063799006)(18002099003)(22082099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+SOQQmPo9JgFd+3faetcSNNVfVOuD6bw7kVFUTR8I15Lb88lBTu6TjlQPBw?=
 =?us-ascii?Q?1mgkYhjOVYQlKQwaeei6Hc4x1DXogBcmzl+MiqsioNDd2+l5Yz28lxhgd7Bg?=
 =?us-ascii?Q?Bf/czjUyZjAP0KAqYc5ukc1oHrm9NkGgxVjlLDl5vQAi1R48oIHyQ7P2cYXQ?=
 =?us-ascii?Q?Qzr35WftT1FvbX+NATtrSBCOw/CLlzWWRUXQLvIw0m+X5Bk++InmzTbmNfU8?=
 =?us-ascii?Q?2+4h4VnmKyJWHow7D866vKby01C/UyjXEh5l+sLPv9fms/ZMLDedXmux5pA1?=
 =?us-ascii?Q?SPQHbELRTVXlunSZ6v1ououErDR8MjrcmLMFKR22rwi6CaonJL0dvn+CQBfM?=
 =?us-ascii?Q?EWGtIa88ADjN2mqmzW/+9wA+jFbfOD6VwjHPnkR5mM6gjW74y+klMZuiYPI2?=
 =?us-ascii?Q?I18LDRL9xi5h+0n7peV7RcIM0LFtkD4wow/1m3B3NZWagpNH7k0nja9QQ9BV?=
 =?us-ascii?Q?cJAocpSI0asj12uhDZRO06YUaU4oWa+19EnOUuu4h53o5ayD4NW1BSiA+8Of?=
 =?us-ascii?Q?bsfI7PVwxEEnz3EgC3pLWdEyaVirWu7ykFKGW8jq/mZLWo4HryWVBhNiEvRE?=
 =?us-ascii?Q?9yiCSmADAtGFxwfAD2Bc8rwJhrmkv4uZUf9vuCmFZXJy3UcuP9eomadXItyG?=
 =?us-ascii?Q?eFIVSaq7ynJCQROpeb4A2TQ2aY+0TundOmKD/EbUmuQ650N3bTnypr3LOGhV?=
 =?us-ascii?Q?Xd/CIAeANkeiKwx9fQBqjratBBfWZ+1MjQR/ZoFOVWWvErWDA+sfPr1TpZpm?=
 =?us-ascii?Q?cAA9/Gh6Eo25jBMmKa6wvowSxPSajNz0LwyGsKReT6Jwr5JFoF1KMUkgaI3s?=
 =?us-ascii?Q?R1+/K6AKmRCr1FKHwcVHSyTZC9VA8f8N4/L0eR6I2AEZMzZG1sG0bRRxOMu6?=
 =?us-ascii?Q?1mm7OYD37XDnLVjkvIEoPFK+kLo3s13VUWPOYPDi1EZbSUkyptF2q2Ld4E0l?=
 =?us-ascii?Q?/2Aw59les8NtIZ5qmDHuZcVtE0SkyKBUrcdefYAXhodeR+qQVUdWnlIBSpNP?=
 =?us-ascii?Q?8rXW2y3NwVG+sjPCixo/Btab6+wSBHibh1h9tFpMr0lLyVUBAEThsOn5IPhf?=
 =?us-ascii?Q?9cJfug0WoiMjmIRPs41cCLOLX+8hMM/Nn7cnnr7V9ac22lH1iaTqf+ABds26?=
 =?us-ascii?Q?mRrJsueSHv5coxG6h78u29uZqaA3ft0Vv3nmANL5P2m+S/yUgoaMNEoauHJV?=
 =?us-ascii?Q?Ze35Pqt4RmdPYamYipWYp0RFA3XAY3s17/ZpAqDnlKUz/wXclWUY5C8/NVRJ?=
 =?us-ascii?Q?1dnrDUBwYiGjQp5dQQ1yvmd6ICb7DXppAXf+SFEtzlbaFDNg7EePApIammC9?=
 =?us-ascii?Q?J/apijyuGfSITyJ7MOeMdHY6VUqw3gl4hKEwXHmk8J5iCXkraegc9cyk3ikw?=
 =?us-ascii?Q?jmkhLSgwr/Tl9v6yjgUO1TQ604hFPgob+WvrHVK70IytT8GiH19JpQoVkdF1?=
 =?us-ascii?Q?usjc3x9tF3P5YolP3jkgncaFV9CU+zLqW6VMZFZcWIjWL0D4MrwnebH8ONqF?=
 =?us-ascii?Q?9H+QkM+LUtNNk0jmTue50RINGQS14IVZWg7Ig2juLtTyG+e5lvdQEvIU0pfj?=
 =?us-ascii?Q?oJEXKlqe4M+ISJvUzmH6me26YZQYAM0FaYpqQsHe4JIm6PLrk7zGErjr5lze?=
 =?us-ascii?Q?JkVHswz3azWEFHKBadEadjYwxbRiU4iLQ0wgSWde+hsGwkTj24o8CCfXMEZ8?=
 =?us-ascii?Q?q09IlJ3i9dbGKZ9NpCt7ATvUErzZjpCN+DLMLkGm1o2ofe6zDvmRGTpR4Gnc?=
 =?us-ascii?Q?yaTtSYr8hiocC882DTBBUM+rDPiBSBPMAQgIB9ZaafINTPrCtRUk?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17362145-10d6-457f-1210-08df09aaba5d
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:01:38.9304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKzdQMh/VakmYTQoXXiJtGQ60D6bmv7040fVNP/P4MndvfPXZGsGkSoLXlbAs6FWFb1LEPAHmAgOr4FUzhmeZ7Vgf+fs6c/HaV6ChvUUQUPh39VGFn/s8cMmdCvf6/OC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
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

Hi Geert,

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

Just to make sure I follow: are you referring to variants like R-Car H3
and M3-N, where the position in the array no longer matches the channel
index? From renesas,du.yaml:

[renesas,du-r8a7795: 4 channels, two resets] [1]
  reset-names:
    items:
      - const: du.0
      - const: du.2

[renesas,du-r8a77965: 3 channels, du.2 (channel 2) does not exist] [2]
  clock-names:
    items:
      - const: du.0
      - const: du.1
      - const: du.3
  reset-names:
    items:
      - const: du.0
      - const: du.3

If so, I agree: the names are what makes these unambiguous, and an
index-based lookup could not express them.

Then on RZ/G3E we can keep:

reg-names:
    items:
      - const: du.0
      - const: du.1

interrupt-names:
    items:
      - const: du.0
      - const: du.1

Maybe make sense also for reset-names having:

reset-names:
    items:
      - const: du.0
      - const: du.1

?

Then we can add struct rzg2l_du_channel_res:

struct rzg2l_du_channel_res {
	const char *reg;
	const char *aclk;
	const char *pclk;
	const char *vclk;
	const char *rst;
};

Into struct rzg2l_du_device_info in this way we can cover future cases
du-r8a77965, du-r8a7795 -like using:

static const struct rzg2l_du_channel_res rzg2l_du_r8a7795_channels_res[] = {
	[0] = { "du.0", "aclk",  "pclk",  "vclk",  "du.0" },
	[1] = { "du.1", "aclk1", "pclk1", "vclk1", "du.0" },
	[2] = { "du.2", "aclk2", "pclk2", "vclk2", "du.2" },
	[3] = { "du.3", "aclk3", "pclk3", "vclk3", "du.2" },
};

static const struct rzg2l_du_device_info rzg2l_du_r8a7795_info = {
	.channels_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
	.channels_res = rzg2l_du_r8a7795_channels_res,
	.num_channels_res = ARRAY_SIZE(rzg2l_du_r8a7795_channels_res),
	.routes = {
		[RZG2L_DU_OUTPUT_DPAD0] = {
			.possible_crtcs = BIT(0),
			.port = 0,
		},
		[RZG2L_DU_OUTPUT_DSI0] = {
			.possible_crtcs = BIT(1) | BIT(2),
			.port = 1,
		},
		[RZG2L_DU_OUTPUT_LVDS0] = {
			.possible_crtcs = BIT(3),
			.port = 3,
		},
	},
	.mode_clock_min = 5440,
	.mode_clock_max = 87000,
};

/* Channels 0, 1 and 3: channel 2 does not exist, so [2] is a hole. */
static const struct rzg2l_du_channel_res rzg2l_du_r8a77965_channels_res[] = {
	[0] = { "du.0", "aclk",  "pclk",  "vclk",  "du.0" },
	[1] = { "du.1", "aclk1", "pclk1", "vclk1", "du.0" },
	[3] = { "du.3", "aclk3", "pclk3", "vclk3", "du.3" },
};

static const struct rzg2l_du_device_info rzg2l_du_r8a77965_info = {
	.channels_mask = BIT(0) | BIT(1) | BIT(3),
	.channels_res = rzg2l_du_r8a77965_channels_res,
	.num_channels_res = ARRAY_SIZE(rzg2l_du_r8a77965_channels_res),
	.routes = {
		/*
		 * possible_crtcs is a software channel index: hardware channel
		 * 3 is the third populated one, hence BIT(2) and not BIT(3).
		 */
		[RZG2L_DU_OUTPUT_DPAD0] = {
			.possible_crtcs = BIT(0),
			.port = 0,
		},
		[RZG2L_DU_OUTPUT_DSI0] = {
			.possible_crtcs = BIT(1),
			.port = 1,
		},
		[RZG2L_DU_OUTPUT_LVDS0] = {
			.possible_crtcs = BIT(2),
			.port = 2,
		},
	},
	.mode_clock_min = 5440,
	.mode_clock_max = 87000,
};

And for RZ/G3E we will have:

static const struct rzg2l_du_channel_res rzg2l_du_r9a09g047_channels_res[] = {
	[0] = { "du.0", "aclk",  "pclk",  "vclk",  "du.0" },
	[1] = { "du.1", "aclk1", "pclk1", "vclk1", "du.1" },
};

static const struct rzg2l_du_device_info rzg2l_du_r9a09g047_info = {
	.channels_mask = BIT(0) | BIT(1),
	.channels_res = rzg2l_du_r9a09g047_channels_res,
	.num_channels_res = ARRAY_SIZE(rzg2l_du_r9a09g047_channels_res),
	.routes = {
		[RZG2L_DU_OUTPUT_DSI0] = {
			.possible_crtcs = BIT(0) | BIT(1),
			.port = 0,
		},
		[RZG2L_DU_OUTPUT_DPAD0] = {
			.possible_crtcs = BIT(1),
			.port = 1,
		},
		[RZG2L_DU_OUTPUT_LVDS0] = {
			.possible_crtcs = BIT(0),
			.port = 2,
		},
		[RZG2L_DU_OUTPUT_LVDS1] = {
			.possible_crtcs = BIT(0) | BIT(1),
			.port = 3,
		},
	},
	.mode_clock_min = 5400,
	.mode_clock_max = 87000,
};

What do you think?

[1] https://elixir.bootlin.com/linux/v7.2/source/arch/arm64/boot/dts/renesas/r8a77951.dtsi#L3363
[2] https://elixir.bootlin.com/linux/v7.2/source/arch/arm64/boot/dts/renesas/r8a77965.dtsi#L2819

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
