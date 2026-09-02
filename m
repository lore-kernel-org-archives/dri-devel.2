Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF0DC624D6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54DB10F1FE;
	Wed,  2 Sep 2026 14:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Dv1wp7vf";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011017.outbound.protection.outlook.com [52.101.125.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7417510F1EA
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 14:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSBHhjtVN+sWReh3SencmvmFCsibC0p1w52g/8JrTAWOtJV2aLarab3vvhpRc69wW++8E/5dklykm8X7BQWM8aI90wAsO8l5iA0CoSL/oZVLADH6A6PApyL9NQ1cTNRmYWV8lossTffKb5S9VHCp7mNRI8DIV3SuJBOBcfgaN8X4XHUUTWtFBKo7PNcjCx15536iVojXNjCnw4ZImg29BCJXWhAp+Y7Ygyse1lEpzGEUmGSDvYPRU2eap0RZUqM8mg2I3068RNb1CtDjkPb8OLLK9hkvRWoL5VyGKk0bc6OxlPcpNFs/k56MPkvC+fwH4fFg69ARaC639syOzF2+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJtAoxap+/kvja3AV5siHNgGrgOnsByAqEaFD7Axmyk=;
 b=PwljdoM0d4a6We3PgNg/gEvjLK8jTucmzb1kT6Ztfq7yo4TEOH0ZiNkunwsMDGRgdLwpCPUKE7OPSWkEqMgXFgXhe2c0jrCVca0x6uYkDCY58w4WLLSMlxNDW5VyLbe9zHQ4M3QvZeD1vC6ClsFABzkM3MueCQWcsDqNCRnOAkAAe+g4xSUyqaxIaWnPFH6tdLFk5lHMK0FG4zi+Crx/Ou7hMoJBrUhowD9V7RA5/2+TMQqxPE8sHn2IGhuJyI6tIB+ILWF2Tmo9oUmGykwHa4JGa/DwlEDaLUEgjAxcNPXZ8zMwVDrftrNR+oHmnMLh7+IQF7dmrheHtAd8uQyRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJtAoxap+/kvja3AV5siHNgGrgOnsByAqEaFD7Axmyk=;
 b=Dv1wp7vfeK/k+z8sQEp1hiztT6Iu/Y5dT6AxfC1fG8TOy3Ui+1jN8Q9KS6SBY6MHP2FnT96uGV9UO4A/nYaoeZG2AVzAiLNDwMSfA1KF9T20oJP1a+ruTuxC79LJdKffZyNAkQE7rmUIMVPSR93DhtWh1HC3StD8tKYXvZYIWFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYRPR01MB15959.jpnprd01.prod.outlook.com (2603:1096:405:2e5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:03:19 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:03:19 +0000
Date: Wed, 2 Sep 2026 16:01:30 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
 biju.das.jz@bp.renesas.com, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/9] dt-bindings: display: renesas,rzg2l-du: Document
 RZ/G3E SoC
Message-ID: <apgsOubuGuvw_0rf@tom-desktop>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
 <20260828122113.1426778-2-tommaso.merciai.xr@bp.renesas.com>
 <20260902-heavenly-ambrosial-trogon-b7ab03@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-heavenly-ambrosial-trogon-b7ab03@quoll>
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYRPR01MB15959:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e590e1a-2af8-442f-2fa1-08df08faf10c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|52116014|7416014|1800799024|366016|376014|22082099003|18002099003|56012099006|3023799007|5023799004|4143699003|11063799006|10067099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info: 8RKO6xxC1PyxgdPnzQfbF8AC2LSVYMylm+norJeOmCPUVHN6Z87Sh0EJf0zXop+2HEeye5Fhq1xtZC0/wOklwUNAJg3dBuq89fJakmkE8X8h0Widfvs0J1qo3nYbnNhsGucVYFzcZDgu7nURsQ1XJOtgFP96Ufvx7+Fwt0R2vycKQu9/rStnpjHQj85+B7AmC9UbeAx2hskl2mqT8gAc+RuMVrlTvxZ1MNGuNVGi/bxhlTlKIBA1xR6+1nMa1ELlG43yvzKGmRt+lUeDOu8L9p6P5epnbxq8i7szmNuQyBLhQhK+GxhcuhtTwFczaYjfllUH3CXd2Q7WIIBr7WwFvdA3CvOZmoTqHnvkfdUvWeFcsyYghqthyX8K3ctxC06WBI2uysyGsEUx8xmqX4+f3rI2mZg+lb93U9mK78AMlbkRt6ymHyz7v5HCveuACTyDOoBIXSbkUixF7Z4M/SwCr583er6ySK4HMTGeHI4SYiMcszOJRSu9beGQbUbRFe4JS7d5sl400uTd4BJrFb/Fr94SwOYfP+xJ6QOiBh/k7PzAE9nQXPFGOFIyhcvJWWdP6psfY3JJ8BXninnKImmdWSHKDxJKJfxKC8rwcpFuKhy+wDQBaGXRcW7YotBfGXsPbbr7Aod/Fz5fd6ddxfUqJ4+nQEbMIVPlpq5wf4nlsCdyQ2jxHmMhejmeDBcDvXdXiSSXR3EOC5tHHiUtHUybJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(52116014)(7416014)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(5023799004)(4143699003)(11063799006)(10067099003)(6133799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WlgWXdiH5N4qdBzRExAg6yFCQSzuv4AMHEiyM7nwMiBt9lSI115gsEFp4+iN?=
 =?us-ascii?Q?bF3QdyeNO3xlgkjq3+nje4Yv+s21Q7GgDAmRVsmj+JVfaE5fZqWxvz48H2oQ?=
 =?us-ascii?Q?Ha83AhJNYHAABOf+edpJqLxUlrglM6hh0A+jllrI4e2gs5CyVlOZo90AOvqI?=
 =?us-ascii?Q?9waXrr9rAm1idxEs/HpQJfmGGBiZTVJA1xZKK4mk1fiun36vmkn3eigHg3WN?=
 =?us-ascii?Q?mMECcdCCUFgEfdZqGMHu+fQDmNOGgsSt+edVV5khp4pRnPYzKdDwXuRfrPMk?=
 =?us-ascii?Q?5Qm9hhwLRkqTp2D2uiywGOB+LlK3UsFA88zKhfwlf6GB6yHPznTHGEP9VZnG?=
 =?us-ascii?Q?AV5wjBAc6m0HEC9+9jdRXCJuQRfmQbipKDF0bCbHI4Bj2EpM5GpvUhrwEEJr?=
 =?us-ascii?Q?GgXJVGY/VE7j5NkQfNksxhrYINIxwAZ/Cqgkx1BkfFnql3xa3rNUDOU8HDAx?=
 =?us-ascii?Q?pq9DjX/HE0Y6CncsZgTZ2E2POO7XO7br2wIVkIKMBCqAHAbJd4mCpkCqB8Us?=
 =?us-ascii?Q?kuo2Eno5vraDLzRtS+LWoJwepTY5OJuECkuN9gWIemXWj8pkwnRx3F3yWE11?=
 =?us-ascii?Q?g5GtjOknV0k3kyidQQGxfq5enfJZDHm9oKdYBXDJTRhG0sU5fVStYmcRy4Co?=
 =?us-ascii?Q?1zjGKdmHY0CQK/M5a9Iuwe2gxWL+YcgS2H/cr4AWGt554wMLng3iSYG66F8A?=
 =?us-ascii?Q?h+G7wYpe7TuMz3gBBA4DB3sybKqkC7YDdbkjoRXZ4W30jXKY1AB5kPgIwS09?=
 =?us-ascii?Q?uVI4Q7acL4dEOkEE9X3DMeFUffIhwg0Dm01upW98ZF5CiHPXJvFUv7iPnvSA?=
 =?us-ascii?Q?Nt3H8K6xz7dNWyZRxjIhgiKvarJTUucbFZZ83G5unZQrOFlsp9KCd+pSlE+A?=
 =?us-ascii?Q?mVXahU3sAQUhm25h1PJ2C3bQlqGJl2Sr4WIJlL6J5dmetZAb4XxPIp3D4OZ6?=
 =?us-ascii?Q?oSWivcXGJ5ylQieOEbfxYBPYON5FMdNgJQXBq0EY2DIaJtdO4IwC0h7LJt+z?=
 =?us-ascii?Q?A1BSk18GKWgqgvdjFQcSvwrnt8wngwnemVDHZf+iQgFsB/9LzWzdH0E8e8QB?=
 =?us-ascii?Q?rwC6HQASamidITVAIjXFIn4D0UxbOOyH41KRX2JqN8JJYR+hQyCjgGXx4LtV?=
 =?us-ascii?Q?Rwzmsmi1wO3kkGn273ZLQC5EHPVeWbjJi/qTN/ESgIJ25V7rW8UyIbMoZQE9?=
 =?us-ascii?Q?qcNwxfw7qgB6j5ZX8wn4cMCEAxnVdfpZfQe7d3Ys7iXOfBwuJoXUO4tQ1MOx?=
 =?us-ascii?Q?9KGpEqwnjqmKcLKvbilCrAWyFvGQO7G15+uEkvqykdEZEfXv6oeMh8EG3G+j?=
 =?us-ascii?Q?5hYBrxVCPWNirGwrm2oed1BZAUaXdr8wGjeptpwYU0xNTCSpHR0MDj5gtpyy?=
 =?us-ascii?Q?+7JZuyyHnhWE/27uRluBc2mi/0ks2VSdtBnAqyCrlcqZwTwqIRhLM0XgIMQ3?=
 =?us-ascii?Q?jJzAYVXhSKFPopYaAP5l2M3FmQR4ea73EEOeBhBcO+IOYfti6K5RQ+qwKUOr?=
 =?us-ascii?Q?7LpI+cC8ZS4tXvsP6daRpmzD6153q8Kb0TCZ3fVjPgb47atWnDAwEDHizBh0?=
 =?us-ascii?Q?Z3X7Hzt4iccqXNVBzDSAiwkhLdGmSRCemFxeAYwIt/UoP68NaeAnnxQQJaUs?=
 =?us-ascii?Q?Ca91aUD3ACn2xx9/BJtlsshn1vRPHf5zTFWvde1T3iMppvXQbMQBZo1LA9S/?=
 =?us-ascii?Q?xWU8MQVOsqvCep+8EveAVKeYINdy0pVGi0KG/dFuHbY86albR8a/qp9SyE+B?=
 =?us-ascii?Q?aBPxwHkfO3IMOBrkz6qvWhxwgyqXA3aFGrw0mvewh2CpiK2ot9dJ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e590e1a-2af8-442f-2fa1-08df08faf10c
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:03:19.3784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYyQ+LCqnIug7azPy5vVgqt1Y1VCkUpxirnrBXAKhL7rMRhspoH1q1XRSbM/GUUflAr4d+vNrWo6vTNJe5By/Xm5uU1QST8qs4bYd/FAezGP1shzAls/m8RvaHJXx0SC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15959
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

Hi Krzysztof,
Thanks for your review.

On Wed, Sep 02, 2026 at 08:37:06AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Aug 28, 2026 at 02:21:04PM +0200, Tommaso Merciai wrote:
> > The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression
> > Processor (FCPVD), a Video Signal Processor (VSPD), Video Signal
> > Processor (VSPD), and Display Unit (DU).
> > 
> >  - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
> >  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> > 
> > Add new SoC-specific compatible string 'renesas,r9a09g047-du'.
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > v7->v8:
> >  - Rebased on top of RZ/G3L du support [1]
> >  - Modelled using ports/port instead of port/ep.
> >    [1] https://lore.kernel.org/all/20260826174854.199139-1-biju.das.jz@bp.renesas.com/
> >  - Improved commit msg and commit body.
> > 
> > v6->v7:
> >  - Rebased on top of [1]
> >    [1] https://lore.kernel.org/all/20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >  - Use single DRM device aggregating both DU instances (1 DU dt node),
> >    modelling single port for each DU0, DU1 and multiple endpoints for
> >    outputs.
> > 
> > v5->v6:
> >  - Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" and
> >    explicitly disable port@2 and port@3 for existing SoCs that do not expose
> >    them.
> >  - Reworked ports numbering + improved/fixed ports descriptions in the
> >    bindings documentation.
> >  - Improved commit body.
> > 
> > v4->v5:
> >  - Dropped renesas,id property and updated bindings
> >    accordingly.
> > 
> > v2->v3:
> >  - No changes.
> > 
> > v2->v3:
> >  - No changes.
> > 
> > v1->v2:
> >  - Use single compatible string instead of multiple compatible strings
> >    for the two DU instances, leveraging a 'renesas,id' property to
> >    differentiate between DU0 and DU1.
> >  - Updated commit message accordingly.
> > 
> >  .../bindings/display/renesas,rzg2l-du.yaml    | 95 ++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > index 5c9b15a09dee..d44c7c0add8d 100644
> > --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
> > @@ -21,6 +21,7 @@ properties:
> >            - renesas,r9a07g043u-du # RZ/G2UL
> >            - renesas,r9a07g044-du # RZ/G2{L,LC}
> >            - renesas,r9a08g046-du # RZ/G3L
> > +          - renesas,r9a09g047-du # RZ/G3E
> >            - renesas,r9a09g057-du # RZ/V2H(P)
> >            - renesas,r9a09g077-du # RZ/T2H
> >        - items:
> > @@ -35,25 +36,51 @@ properties:
> >            - const: renesas,r9a09g077-du # RZ/T2H fallback
> >  
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: du.0
> > +      - const: du.1
> 
> du is the name of the device, thus calling items "0" and "1" is pretty
> pointless - indices already define that. Please drop the reg-names.

Will drop this in v8.

> 
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: du.0
> > +      - const: du.1
> 
> Same here

Same, thanks.

> 
> >  
> >    clocks:
> > +    minItems: 3
> >      items:
> >        - description: Main clock
> >        - description: Register access clock
> >        - description: Video clock
> > +      - description: Main clock for DU1
> > +      - description: Register access clock for DU1
> > +      - description: Video clock for DU1
> >  
> >    clock-names:
> > +    minItems: 3
> >      items:
> >        - const: aclk
> >        - const: pclk
> >        - const: vclk
> > +      - const: aclk1
> > +      - const: pclk1
> > +      - const: vclk1
> >  
> >    resets:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  reset-names:
> > +    items:
> > +      - const: resetn
> > +      - const: resetn1
> 
> Drop reset-names

For reset-names, I got the the following comment from Philipp in v7 [1].

Dropping reset-names would force the driver back to an index-based
lookup, which is what that comment explicitly asked me to avoid.

[1] https://lore.kernel.org/all/8382e2b9fd07fb1132c26e228b3899336fc1fdd4.camel@pengutronix.de/

Philipp, Krzysztof, could you agree on which way you'd prefer?
I'll follow whatever you decide.

Kind regards,
Tommaso

> 
> >  
> >    power-domains:
> >      maxItems: 1
> > @@ -66,7 +93,7 @@ properties:
> >        model-dependent. Each port shall have a single endpoint.
> >  
> >      patternProperties:
> > -      "^port@[0-2]$":
> > +      "^port@[0-3]$":
> >          $ref: /schemas/graph.yaml#/properties/port
> >          unevaluatedProperties: false
> >  
> > @@ -110,6 +137,7 @@ allOf:
> >                description: DPI
> >              port@1: false
> >              port@2: false
> > +            port@3: false
> 
> Best regards,
> Krzysztof
> 
