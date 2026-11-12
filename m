Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E6606A898
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=sTAjBgzh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8781A10E58B;
	Thu, 12 Nov 2026 10:32:57 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011003.outbound.protection.outlook.com [52.101.125.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB0B10E58B
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltlMuFiTpGDqh7gHi3V6ctzQlEddYJZMRLvwAqhwRELJpX7vVQnV1NO+ywwutRzkD7OMXshNuW83GN/MQJReW9WVhkip/3STLX+4GN/PdJEtkFcNPvMOthnDZ3VjAfvj6WdSYSh4u3cveBKdATYF3IVrjWeOOLOJ+ktHc4teffuM5RJPFeV8S5eL3zJjEEkJkGXT0N3+ilrQ0e5/VP4W3eQxLwOolkahh9/WP+qKRARCsTKighRgc1y35lf23uM2WjTk1VDmQxu5iizn0TgsG/MT34+vvZrSxG74pbdgsB7nXNyomdcxdI8DMq6597CXx7/fkFvD1h0cacoS5AQ8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH+39H/zKk54sTrjhSoBk1Fl6mLIeFvgf8yLmERk//8=;
 b=kw8LtRa+CR7LDHe+gq7WrGAQ5rQIgaJiWrjpDAYGcHzqRYAdaUlYneTeUfWIG94nR/ht1tgjMTI+hRnVOeu31YH8+yCTVAQ9xPq5JCgK97f+/Ac1LOaw4mMf2HVj0mZGtUsM5EJ8Vwr5paDECoulZ44iO6P/zEaqy3XhUF1lVkkqk0Jt29FgIlnJ2mKJ+4KLCENz11Pxy6GsZr2BLBcC6FgGwnG67J5QHjfLE2bbWGoK3uoXj3RMjGLxYHDJtWwfvnZyHL16YrnDaHJ3kfWS4NKwrqNXsy/mivC74TppVYsQdTLUtz7b9vogWzmzQhX9qeWun+8Lw2D1wlt9YXM0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH+39H/zKk54sTrjhSoBk1Fl6mLIeFvgf8yLmERk//8=;
 b=sTAjBgzhHwTtcP4PtZ31No29sJ1NWH+QnENFzPRsNTn1Fm25240FGqX06YXnIGK9F0Lca/q5F4c60AmZZwo79aHFxBOrkcYpl0HXtDD3qWMVbCs3biKzA2TgV+SiN7uiiCgrsvD0QIh3sr4nA68RCDhvjr2R837g5XGfA9robhg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TYRPR01MB12667.jpnprd01.prod.outlook.com
 (2603:1096:405:1b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 10:32:36 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 10:32:36 +0000
Date: Thu, 12 Nov 2026 11:32:16 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tomm.merciai@gmail.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
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
Subject: Re: [PATCH v9 02/10] dt-bindings: display: Document Renesas RZ/G3E
 display subsystem
Message-ID: <avWVsEFmoDWgesqZ@tom-desktop>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
 <71044c23cbd6698d495db101527725bd7607197f.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
 <20261104-lurking-griffin-of-tornado-ca7ac8@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-lurking-griffin-of-tornado-ca7ac8@quoll>
X-ClientProxiedBy: VIVP296CA0099.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::16) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TYRPR01MB12667:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1088a6-8a2e-4d61-02c6-08df40a84475
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|38350700014|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: J3lrSkczU1QR1hVsuizQqa/CwSlAsBsrgWN/EL6X6xfvHOWpYXSAsJdJp3MlsoCT0MMDMXerjtdPHn4ehYPHRi4d2vDsLjbCEBt9QtovjEN8osmUWLNSbQvaJucXCfan83sfoTxLCXPYxmQ4RZo7EjnB0/YqYJGXcKEWh+/8YyJ2b3CshAzfh53EHG3k6YOxpnf8qIXAVRFH/IvcShK4HbUBc3gw+UNui1+0jJ3BwRMVjflJiy/cQsAdu2TZ+GxEuYG6IB3ih1uaN+MHxMe/2F3ZMoT1XjUwFGcXV9l06+iG14x2KnFpSZ2N2YxZIZaOPFgNY8F9hniN5UehOVh6evVQPAnRtZUY/78O7ftLDuUz4gYpdJtmpCiehP5DUClMxd0T9Xs3IXWYLP7jRlnam44LnAIg7OIdyhMDfR7g3nPqQvF904VgUh78V23KB2BwIbZsE51KI6yadJzygEXozjjvzr98dC92dnHiwIaQHF6rKiWyqk0P8ihK9FG7hbQNneA3ywdWzEXqN6VqCYUIlPVfhOJzsjFA4deCHxmUgqmZY08wAUBrlWwlMRvh2nqr8Ffttc7fbM0r53Z5SsdO1W/9n5GHpXH6zJkG0/gXxyJUxM2Yn5fzvJqNyB+43kxfGvy1yoY72/84PyWBOqsNpEskGXD6aXXrAb+Z15t/weo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5q/kkxgziyab2jeB4Eh8fuUiDyxImnE/YVS0fIFeJhE4Guf924StmSgf/Mx0?=
 =?us-ascii?Q?gdhcuAusJwmn5EkmKTx4cexvKppslfHSpl+rlQ8j3U6l6Hdza+/MeVL7ly6v?=
 =?us-ascii?Q?4dNT/PIRe4dXa3fqDSU77HXYu14ioOWjN27tljbUIAQX/RHHFyFcCbodg8nD?=
 =?us-ascii?Q?BchaOxq28YhKAQPOWRv8aPHjOYI0vx7L7Ur85Dm6M7IEBpchKJ9lCJPDzAHg?=
 =?us-ascii?Q?IBIhM+WOAEyIpS1CUxR+3r1JPhXzRCiGRaH/hMvVd3Xuas8j0ZUFnRDiP0ZI?=
 =?us-ascii?Q?ZevZCpZjCHFuryQhvNwjoIyd6hLZIhZxbDNSzy6g3FbXLv5ukce/LhhdY+tM?=
 =?us-ascii?Q?XPCK04wK5IQcjOMFSfrPcajSReDgyAUOUrkX/NZweyI20iAqqCLxqamUKBjO?=
 =?us-ascii?Q?20PskL5OCvGy+q6JIUmkwMHekv7zd+no4azlqE83btijl6mT3NAbD9Dv6L3l?=
 =?us-ascii?Q?71S2runXc5qDMYJjqXLwwRH1OwdVwWL09cO9LIyLZL7MNrs5s1Gv4+VKb+P1?=
 =?us-ascii?Q?HWChukAcGFP6mg/7vy4M7X6hcskUmlp0YP1XLLETjcJn39vy3H6u2KWYwuHU?=
 =?us-ascii?Q?/Q07Ehz6YvyzcswmWpNi4Ln1U1n7zR5XLv805mRL2DusUJbOl9YXp6rZje30?=
 =?us-ascii?Q?BXFiNLISjOhwGVbn2SFCPhfB3Bw4b3O8JX6P64IN+CLsSyw6b6McGeN2JK82?=
 =?us-ascii?Q?6zw0rGZd04LF/slzXlOz39hvYFVT2PEfGcGL6X2LKIix7YqUgWtjBKgtLEDk?=
 =?us-ascii?Q?w/ASWB9Op7iEAbXV1SAiZbv85rPXXfyWUDcCObbXkxGz5ILU+WiyzQlsFwzq?=
 =?us-ascii?Q?8xIqPKTUrQ7wxT0zdLJUij1FQoVBDZr2l4ga+8JhXy7VRtQtz2B/FMmMwDfy?=
 =?us-ascii?Q?ESuHizuB+wmcsg337OnTuh/fZbvCA6pj+736nIi1b+LMY4KCMYX+DEzzvxGq?=
 =?us-ascii?Q?dky6QGTDawAv1neLt5whAaCrHyR3RxhJ88l8CICROOepqGWedWNQmCak7HZY?=
 =?us-ascii?Q?onunUWh5GPSY8deysGtRPyltOwpJJomdxYI1pIvYMuLbvF25ZjLoWfYunLhb?=
 =?us-ascii?Q?iyVQZNEXZIzm8/1Y8GqOLedys4Sn1KGDevkf6fkj078JDepGyPnGJaDGFIEN?=
 =?us-ascii?Q?Y4dIeh8/Xye9gtW6FMGwq8n2PcT2qIgWNo4asi9pmx1DvDpNMW/suk9H85iz?=
 =?us-ascii?Q?emChiEHbCS2BqT7Z0ivqRQvZtxJ5HYGS7op2q15hhfluN4aZSKw5AVDsBYMj?=
 =?us-ascii?Q?/VIaDa2Yif3n8T3/D5hFmLrguzLIKVj8+NONrhUbY/Ypj53J5sCe4ygPd6bf?=
 =?us-ascii?Q?Smxz+XufPCQ9orus+dY7GBBw+HbNz8kqejAlO6XaWfbLmpYx7134qLgQOX+n?=
 =?us-ascii?Q?afUIUEVejWYm+zWKMJFXcRBZQVD5nM8bloaUxOrlPoPKuiJCuqb0VEUawgbU?=
 =?us-ascii?Q?4xaDaOP8qNCweZ5+H8VCJAMyOeWEr5irfuUx0GjE+/TUDPtSECwAldaP8S8I?=
 =?us-ascii?Q?57ZNL1wmv/GBF3IQk4unLPrLdL+9XCuVBSsviHHMKtYI3pQWvrEqeifYG0Ww?=
 =?us-ascii?Q?PJXiUu9rQRW3zA1WRGGRjRzaBszSatPBWyvm1RcbGLhiPeAPrc2uRNJ7EbQo?=
 =?us-ascii?Q?PrKyh9oVVsllcz4NgYX7CNje8Wv3wjL3RoYlQ6NLGPLnUb69kwEQFiVRnCdf?=
 =?us-ascii?Q?pgHK3Q1VjJPfPsZIq+X5M6svnWUWNe0a+PSFh/tnm02tfsFhE8eA6FOJJ4VP?=
 =?us-ascii?Q?eRf1XOOwYdswMRLdu18n7K93wfMPo3XwQvRdbkynew53FtOI+zqS?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1088a6-8a2e-4d61-02c6-08df40a84475
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:32:36.0484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rvPyI7uTGQSw7YTBPtONhq3DogixX3vcc/w7TUmut40azOUJ6RYfz29WpEtgEDmVwUm5p26d8W3+1U+WZacDEIlLpAIqy+rKPHcr8L1Jat29VA5glRK6zgLhEKkmm56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12667
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,
Thanks for your review.

On Wed, Nov 04, 2026 at 11:19:47AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Oct 23, 2026 at 06:47:35PM +0200, Tommaso Merciai wrote:
> > The Renesas RZ/G3E (R9A09G047) SoC has two LCD Controllers, LCDC0 and
> > LCDC1, each containing a Display Unit (DU). The two DUs are separate
> > instances of the same IP, with their own registers, interrupt, clocks,
> > reset and VSP, and are therefore described by two device tree nodes.
> > 
> > The DSI encoder and channel 1 of the LVDS encoder can be fed by either
> > DU, the source being selected at runtime. Driving those outputs from
> > either DU requires handling both DUs as a single display subsystem.
> > 
> > Document the renesas,r9a09g047-display-subsystem node that groups the
> > two Display Unit instances.
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > v8->v9:
> >  - New patch.
> > 
> >  .../renesas,r9a09g047-display-subsystem.yaml  | 44 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml b/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
> > new file mode 100644
> > index 000000000000..e23cc53a1fea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/renesas,r9a09g047-display-subsystem.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G3E Display Subsystem
> > +
> > +maintainers:
> > +  - Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > +
> > +description:
> > +  The Renesas RZ/G3E display subsystem is a virtual device needed to list the
> 
> We do not take bindings for virtual devices, because you do not need
> them. Instantiate your driver from existing bindings, instead of
> creating fake device just for Linux drivers.

Thanks for sharing.

I will drop this patch into the next version, also I will
instantiate the driver from existing bindings like you suggested.

Kind regards,
Tommaso

> 
> > +  Display Unit instances that comprise the graphics subsystem.
> > +
> > +properties:
> > +  compatible:
> > +    const: renesas,r9a09g047-display-subsystem
> > +
> > +  ports:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Properties have only one type and ports is already defined as object for
> graph.
> 
> Why isn't this a graph?
> 
> Best regards,
> Krzysztof
> 
