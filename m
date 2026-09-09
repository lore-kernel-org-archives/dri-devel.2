Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B36C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A96F10F14A;
	Wed,  9 Sep 2026 15:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jysLnn1D";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010000.outbound.protection.outlook.com [52.101.229.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCF410F10D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 15:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqwxRGAohj9URv1EcbVGNQk1W64+2vvwolOmRBpmQJijYJMD3OVGH3g7hdZtSiCTj9jQYjADpv0WXdlcXRgKPGKqtu9XTaATspsz9Ie2kSZPhAyrgSYMholRECQ5Mo2MGWvVHMSnGNtpCURFJJY2jdQjfGbIUhdArvnNjZBlnISoPq/rSllML8Yjzw9JkYOoDeB3WwV7mXrm5KCU2/NVIePdJpO+kSTHWIX3IbPO2Rpfe5ciqTCTBLuPRuUkz7KOyoIEoqbnF1OazfSkC0pJr3gVYWbRSSs2Xwos1L6z3e5RViw1cOmTSH0eUb85RM6ZNPpdYUo57wuQgu6HTFIEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMYAXtSU2RlI5A0+xZHMpejb4PXuSyHn3Og+XtDgg+c=;
 b=PvU3ulDu42fxjJogWn6BeWjHQSeUrQGIbGQ2LQZCb7eCdVj9h4+5MzthJeFdPueANaoPGrk6mK6nEXW3Q0528g6UlqXVvYS4KA6r/PQ7GdYNyeoZ96k9pQyM/hWqmwl/3OV39W4F8rsb8fLKrE2CKcWUfyK3TItzFx371AX61ZObP22L/3Kl2Pk2nDaFujhwGv1C3zZUuHcTeZbui9RR/BT+2kg74Rcz32fN2H2ITdR0VG4WhKnu1kk3dPZZy3Qw9PP5M4lbFHDimqpxtN/+WqvNEGYs8YQ7CvbpeKauc4PfEpkSgLKXtnNSGPkxjGvz/JhmSrgpB3F9OLywvWxrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMYAXtSU2RlI5A0+xZHMpejb4PXuSyHn3Og+XtDgg+c=;
 b=jysLnn1DoamML6U+Aian8cwlEigS0QnXedJXNQRUO3pkHl0F+Be9JAB7YKY9TdYAY8uImONfBOaMd0/DgJbWdgP7p7IfSr7TfdA2HMTOWnRfsclws77GLO3C5tDB5epMybEzHWsb2ldLHVdq0fl6KeaPwldBARw/53pAjTrgIDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYCPR01MB10071.jpnprd01.prod.outlook.com (2603:1096:400:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 15:04:31 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 15:04:31 +0000
Date: Wed, 9 Sep 2026 17:04:12 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, tomm.merciai@gmail.com,
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
Message-ID: <aqF1FCVywlyt1eK4@tom-desktop>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
 <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
 <20260902-heavenly-ambrosial-trogon-b7ab03@quoll>
 <apgsOubuGuvw_0rf@tom-desktop>
 <CAMuHMdU0y5Dg9tW7fAM3QQHKpAw_+vmjj7v-XeZmrushQgQFAA@mail.gmail.com>
 <apg8luaJ3eobK8sm@tom-desktop>
 <d50816260b8be29948c4cc04172b5c88ea3313a4.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d50816260b8be29948c4cc04172b5c88ea3313a4.camel@pengutronix.de>
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYCPR01MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ee97e5-4d5b-4989-975e-08df0e83a6fb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|52116014|7416014|376014|366016|4143699003|6133799003|5023799004|11063799006|56012099006|3023799007|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 4veyd29VaZcLkCgWECTX7tL3H4ZA18vjMJ/MlJM0SafAlBjb7/rUPQvsyG6fB22SydNbwIIbx4DXLLBxkJPeRCEcG7U+l4Ut01jer71FLZmic8O3DHS/MNoK4e21zROPMlAymS9VajIEsBZV29W8sU7OOEWyoPpQljyvP2C7LdGE87456KtmvSlMHvgfbHZw0ngqORAMJmo8RDn7ssWZ3ywcU0zOp+JGTLeDKoUAQjUXtpDRFiUY1bzIKPwoirydqcWh8tcM9HDhQ92Gye2YuVPV6OiEmb31zCGk5765e1LymwCDveyKImj/Ywjd9ZE9RUKRF2GxwUCF5pi4imgs/K+QJTbGiZJWupJfo59dbgFis1GwaIljeh63ER/JtgJQzGlor6wxfDKj+r3f9V+y4WwV+LKe7f+fuaeow7wsXLylVv1E+PmbxTuXplFKZ5E1P9TdFJTc5FR2dCuVkd72gLfEFlOLOjQUZLn5KHRZFLCaviVvqu/bH5z6Oa7iIn64hIQ8hKXmeXRLigbn7SFN06Gh9yZUcwLwwuKykhPniT6FACrqGrB6ExMAzIYAUHk/K+AtrwSGU6n83lUCXTpzh1FXZ70kZSNFK3oFvqXbVSRrHeDO6WhQwlw7msSRqammvphC3Rafe6/Ed0c0Bu2PBQVyy7j9VjHLaPLW3ctcZF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(52116014)(7416014)(376014)(366016)(4143699003)(6133799003)(5023799004)(11063799006)(56012099006)(3023799007)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lmWZkP31mswkmZX+uvT1++eVs8e8HQpE4kpj5T5WEdWQ1erMPL90M0gLb8RY?=
 =?us-ascii?Q?C7Zs6izI1IXhKHIUz1p0n2xF+jxqeYy0HqUJwGXdSYNfpkvjdZuZEQEtF36L?=
 =?us-ascii?Q?Z+n+W0moP0Guk437KKZWJd+5GfYCBx9WoKu7k5uOocy8heUuPc9FKRTKjDWU?=
 =?us-ascii?Q?7Y02qdkPaFS58XWp+sgm0I9quq6QLWMHKaw2XBPth+PWNJjVux42eNsY1VIH?=
 =?us-ascii?Q?zvoYhQPU8Bh35nvOubZl3VRk6y/QI0d/u3CmubVio0yx45v0OEqBdHr9ExGd?=
 =?us-ascii?Q?Dae7cmDZIEcpC5+oxlMszfyntb22Tcst8GGtR9j0odHWm+TUd3503/xInzcJ?=
 =?us-ascii?Q?48uSwWYg2xd5wrvPT80BYjZcv0uCsVnopLmxZg10kDq/sKrX9Zo2yTMA0Bfw?=
 =?us-ascii?Q?EWVnDlv+jJJL88T5wdKDxDR0fTK3/HMPkKw9jiptsdWfEQrJT3ByX7cgKPsP?=
 =?us-ascii?Q?GccNBt+2gtsqDioTf3ZKvfcCI3zVOz+ioAJ42HBo6T7hrJauUc8+Xn78IS7y?=
 =?us-ascii?Q?LSwiub+8pgHf/ft6wrc1ax7O5uIdOyYzQYULgO2nF3DfUjcWJmNBoL6q/Dj1?=
 =?us-ascii?Q?YI/OzL0okeoQI7o9A7Nz1gTuY90GxVG9makDTZZpIbSjVz2FOhssqCQl+FEC?=
 =?us-ascii?Q?VTB7BfMx/7C9EUhBIPW3MTzvHYzlQKm1iOBH8Q+5Bouvyk8kA2JPQfcKDdmY?=
 =?us-ascii?Q?vZpKi1efiRVilLtYCzkRbq4lHRD6HeA4vdllZOdXWuiW6qOOt+Eh9bF2kL9R?=
 =?us-ascii?Q?bxGnWjLyf2xdQ1GbGfBP+zff8x3a/6xQS3Gb/VH0UAIWKAbfaNC8TkMK9xaG?=
 =?us-ascii?Q?gGqiHHvCymhT3i5WrwtvCz96WDn7c2/6eKWjhEBlNAGQuz2DyS8u68X+kirM?=
 =?us-ascii?Q?NDWdgMv1H9th+4n+rbQUv4bGaY9RhvHnyn7/zsC+a4/rGGYuZfqUgp9tIVaQ?=
 =?us-ascii?Q?LGxNL6uYCmcmJ6oAfm6ttw6/RAJNBDKxkRXuFn9/I7xU6lgHt5cAQhSGFBmI?=
 =?us-ascii?Q?qX2wC05qhCi0Uhd7KpqVLXLY6FQgQjXnWVqlj2YvqpdLAQYELMc0qqz/Ajwy?=
 =?us-ascii?Q?WN5K0g9qmhPwYAxmipsG4A4nxVS2/NCeTOSTNpPHv97v1LT19k0JlcceHYLL?=
 =?us-ascii?Q?BNfi10r8dVdiG5uRLEtQkMKwXhAWdtlY05fFuUFIhL1V7j9Zu+GdLqWIfuz/?=
 =?us-ascii?Q?6qNyAxKoARXBxZKmEdpmsRcy30yRY2I+KHcoWsqs9qCazolOumgWxQkqP95U?=
 =?us-ascii?Q?DoVZjWgExxZFQxIC7ck+M6TYmzkr7r0o2wvfS75qlVh3dMZemMATX0ZNCUOx?=
 =?us-ascii?Q?hgZfWe+Zm380T+7bg+qad+qhPgLuPXRX5ewsHbu13ucd5ror6EWQz4cmLqx/?=
 =?us-ascii?Q?vgxVUvy9Tt8W2KWUyrjdLkQmGeK38Mohri5sv+cHdXSPS2c5ObQiHqPRTikB?=
 =?us-ascii?Q?PkrZusbg0cIgJxGoosgE2qbaJk3hZpwStyvW+jvyknXWO/VtKAWn/k5uO1lb?=
 =?us-ascii?Q?JvwuKhB1dW6UAWnfBgUsbr83b2/q3eXrkjofHh9wjaGeb1A7ZIcN2FR1CI/z?=
 =?us-ascii?Q?5L6lVZgneXgMagy1ibo1eINiQYIjiN3yRwXT9lY9q6LIMc4Afj9fZUe2xZF0?=
 =?us-ascii?Q?3RZr0WL67AMzhzQ86LzhurskOqOrOW0/EJ4FQOo/vBCnQjwKdgepgeaSNUlp?=
 =?us-ascii?Q?xq7xA1Ew/8/RcxyXUWfUmB8D83SOGuwpByCFyi7dcrOcVTbT+m8iZeIG/U0I?=
 =?us-ascii?Q?VWL6Ht5lSCjKBCmwL8iVDjjjIowqWqheTmfxUKsNtqzov7Qir5gt?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ee97e5-4d5b-4989-975e-08df0e83a6fb
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 15:04:31.6983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5DmaTaVJzHAJboItsmc7fUyXBj1AsVw6EiBoRwnJMLh7JnoIkdEb4jQYMbfCeXMme+Og+qAUA8TvWmECEuII2Sc4HJcXmz5MCsZiyKcMAgohUFUDuMokAcByzOtfWW3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10071
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

Hi Philipp,
Thanks for your feedback.

On Thu, Sep 03, 2026 at 10:17:23AM +0200, Philipp Zabel wrote:
> On Mi, 2026-09-02 at 17:11 +0200, Tommaso Merciai wrote:
> > On Wed, Sep 02, 2026 at 04:20:51PM +0200, Geert Uytterhoeven wrote:
> > > Hi all,
> > > 
> > > On Wed, 2 Sept 2026 at 16:03, Tommaso Merciai
> > > <tommaso.merciai.xr@bp.renesas.com> wrote:
> > > > On Wed, Sep 02, 2026 at 08:37:06AM +0200, Krzysztof Kozlowski wrote:
> > > > > On Fri, Aug 28, 2026 at 02:21:04PM +0200, Tommaso Merciai wrote:
> > > > > > The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
> > > > > > Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
> > > > > > Processor (VSPD), and Display Unit (DU).
> > > > > > 
> > > > > >  - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> > > > > >  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> > > > > > 
> > > > > > Add new SoC-specific compatible string 'renesas,r9a09g047-du'.
> > > > > > 
> > > > > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > 
> > > > > > --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > > > > > @@ -21,6 +21,7 @@ properties:
> > > > > >            - renesas,r9a07g043u-du # RZ/G2UL
> > > > > >            - renesas,r9a07g044-du # RZ/G2{L,LC}
> > > > > >            - renesas,r9a08g046-du # RZ/G3L
> > > > > > +          - renesas,r9a09g047-du # RZ/G3E
> > > > > >            - renesas,r9a09g057-du # RZ/V2H(P)
> > > > > >            - renesas,r9a09g077-du # RZ/T2H
> > > > > >        - items:
> > > > > > @@ -35,25 +36,51 @@ properties:
> > > > > >            - const: renesas,r9a09g077-du # RZ/T2H fallback
> > > > > > 
> > > > > >    reg:
> > > > > > -    maxItems: 1
> > > > > > +    minItems: 1
> > > > > > +    maxItems: 2
> > > > > > +
> > > > > > +  reg-names:
> > > > > > +    items:
> > > > > > +      - const: du.0
> > > > > > +      - const: du.1
> > > > > 
> > > > > du is the name of the device, thus calling items "0" and "1" is pretty
> > > > > pointless - indices already define that. Please drop the reg-names.
> > > > 
> > > > Will drop this in v8.
> > > > 
> > > > > >    interrupts:
> > > > > > -    maxItems: 1
> > > > > > +    minItems: 1
> > > > > > +    maxItems: 2
> > > > > > +
> > > > > > +  interrupt-names:
> > > > > > +    items:
> > > > > > +      - const: du.0
> > > > > > +      - const: du.1
> > > > > 
> > > > > Same here
> > > > 
> > > > Same, thanks.
> > > > 
> > > > > 
> > > > > > 
> > > > > >    clocks:
> > > > > > +    minItems: 3
> > > > > >      items:
> > > > > >        - description: Main clock
> > > > > >        - description: Register access clock
> > > > > >        - description: Video clock
> > > > > > +      - description: Main clock for DU1
> > > > > > +      - description: Register access clock for DU1
> > > > > > +      - description: Video clock for DU1
> > > > > > 
> > > > > >    clock-names:
> > > > > > +    minItems: 3
> > > > > >      items:
> > > > > >        - const: aclk
> > > > > >        - const: pclk
> > > > > >        - const: vclk
> > > > > > +      - const: aclk1
> > > > > > +      - const: pclk1
> > > > > > +      - const: vclk1
> > > > > > 
> > > > > >    resets:
> > > > > > -    maxItems: 1
> > > > > > +    minItems: 1
> > > > > > +    maxItems: 2
> > > > > > +
> > > > > > +  reset-names:
> > > > > > +    items:
> > > > > > +      - const: resetn
> > > > > > +      - const: resetn1
> > > > > 
> > > > > Drop reset-names
> > > > 
> > > > For reset-names, I got the the following comment from Philipp in v7 [1].
> > > > 
> > > > Dropping reset-names would force the driver back to an index-based
> > > > lookup, which is what that comment explicitly asked me to avoid.
> > > > 
> > > > [1] https://lore.kernel.org/all/8382e2b9fd07fb1132c26e228b3899336fc1fdd4.camel@pengutronix.de/
> > > > 
> > > > Philipp, Krzysztof, could you agree on which way you'd prefer?
> > > > I'll follow whatever you decide.
> > > 
> > > Until we get a variant with a third interrupt (or reset or reg),
> > > which is not related to the number of channels...
> > 
> > Right, IMHO names keep the driver flexible enough for such a variant,
> > indices don't.
> 
> I would like to get rid of the reset_control_get_by_index() API
> altogether, if possible. Currently there are only users with index ==
> 0, so this would be the first and so far only valid user. I'd prefer if
> we could keep reset lookup aligned with clock lookup, with via clock-
> names as well.
> 
> That being said, why are the two DU units represented as a single
> device tree node at all? Aren't they two completely separate instances
> of the same IP core?

They are, and maybe describing them as one node was the wrong call.
Let me explain what pushed me there, because it also settles the
reset-names question above.

RZ/G3E instantiates the LCDC twice, and some outputs can be driven by
either instance. DSI is wired to both and the LVDS channel 1 same.

For userspace to pick the source at runtime, the two CRTCs and that
output's encoder have to live in the same drm_device.

With one drm_device per DU node, an output reachable from both instances
can only be exposed on one card, and the other instance is unreachable for it.

So I merged the two instances into a single DT node to obtain that
single drm_device.

That solves a driver issue but maybe distorting the hardware description.

The right shape maybe can be the virtual subsystem node already used by
other DRM drivers:

	- fsl,imx-display-subsystem [1]
	- rockchip,display-subsystem [2]
	- sprd,display-subsystem [3].

Maybe we can have:

    display-subsystem {
            compatible = "renesas,r9a09g047-display-subsystem";
            ports = <&du0_ports>, <&du1_ports>;
    };

with du0 and du1 nodes:

    du0: display@16460000 {
            compatible = "renesas,r9a09g047-du";
            reg = <0 0x16460000 0 0x10000>;
            interrupts = <GIC_SPI 882 IRQ_TYPE_LEVEL_HIGH>;
            clocks = <&cpg CPG_MOD 0xed>,
                     <&cpg CPG_MOD 0xee>,
                     <&cpg CPG_MOD 0xef>;
            clock-names = "aclk", "pclk", "vclk";
            power-domains = <&cpg>;
            resets = <&cpg 0xdc>;
            renesas,vsps = <&vspd0 0>;
            status = "disabled";

            du0_ports: ports {
                    #address-cells = <1>;
                    #size-cells = <0>;

                    port@0 {
                            reg = <0>;
                            du0_out_dsi: endpoint {
                            };
                    };

                    port@2 {
                            reg = <2>;
                            du0_out_lvds0: endpoint {
                            };
                    };

                    port@3 {
                            reg = <3>;
                            du0_out_lvds1: endpoint {
                            };
                    };
            };
    };

    du1: display@16490000 {
            compatible = "renesas,r9a09g047-du";
            reg = <0 0x16490000 0 0x10000>;
            interrupts = <GIC_SPI 922 IRQ_TYPE_LEVEL_HIGH>;
            clocks = <&cpg CPG_MOD 0x1a8>,
                     <&cpg CPG_MOD 0x1a9>,
                     <&cpg CPG_MOD 0x1aa>;
            clock-names = "aclk", "pclk", "vclk";
            power-domains = <&cpg>;
            resets = <&cpg 0x11e>;
            renesas,vsps = <&vspd1 0>;
            status = "disabled";

            du1_ports: ports {
                    #address-cells = <1>;
                    #size-cells = <0>;

                    port@0 {
                            reg = <0>;
                            du1_out_dsi: endpoint {
                            };
                    };

                    port@1 {
                            reg = <1>;
                            du1_out_rgb: endpoint {
                            };
                    };

                    port@3 {
                            reg = <3>;
                            du1_out_lvds1: endpoint {
                            };
                    };
            };
    };

Each node then carries a single reg, a single interrupt, three clocks
and a single reset.

With this solution reg-names, interrupt-names and reset-names all go away.

This will need one new binding:

    Documentation/devicetree/bindings/display/renesas,r9a09g047-drm.yaml

For describint the "renesas,r9a09g047-display-subsystem", a virtual device
that groups the Display Unit instances comprising the graphics subsystem.
The existing renesas,rzg2l-du.yaml keeps describing a single DU instance
unchanged, which is what the v5 approach [4] already did.

What this buys at runtime, with both DU nodes enabled: the SoC DTS wires
DSI to both instances, so the DSI encoder ends up with both CRTCs in its
possible_crtcs mask and userspace can move the output between them:

e.g.
    modetest -M rzg2l-du -s <dsi-connector-0>@<crtc0>:1920x1080-59.94@XR24
    modetest -M rzg2l-du -s <dsi-connector-0>@<crtc1>:1920x1080-59.94@XR24

LVDS channel 1 is the same situation in hardware.

What do you think?

[1] https://elixir.bootlin.com/linux/v7.3-rc1/source/Documentation/devicetree/bindings/display/imx/fsl,imx-display-subsystem.yaml
[2] https://elixir.bootlin.com/linux/v7.3-rc1/source/Documentation/devicetree/bindings/display/rockchip/rockchip-drm.yaml
[3] https://elixir.bootlin.com/linux/v7.3-rc1/source/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
[4] https://lore.kernel.org/all/ca022fdbba5236c36e0cb3095db4c31e8e0cb1b8.1770996493.git.tommaso.merciai.xr@bp.renesas.com/

Kind regards,
Tommaso

> 
> regards
> Philipp
