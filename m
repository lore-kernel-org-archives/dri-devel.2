Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9895CCD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 07:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF09C10F4C6;
	Fri, 22 May 2026 07:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UTjxmf1w";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011019.outbound.protection.outlook.com [52.101.125.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE5010F4C6
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3FOHG2B5pHXxxESUJXQ2oudtpUK7X2UEvCtuJI/r1dRFSleVRD3qIKtfyhYMYXlN22AVI4gFZt8xTy/SxPZ2oA51BXDe/6Z+ogBwzOEoxozB7Dkp+Lb+xBzuZPuMme4vnMI0FTQtiL6ih0/mq28uE2b22L7sR63jZsL6lusBKSBp186TiDrBsKPUtWUrWJbH+lZ54ttdGzpxVPlrLQb3LIY/eiLuDJGdQOHS1SO6OtKMbeN3ptL9nWkhihyAucS2yDb+B6SIWi7x9JzYsrEe0R0+6XmHEmRcLHV21j4WZU+308a7J+BWDs8ZXl/EdXuVlbkDDzpLMwzEikmnabidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyBpuS29Aqypl83QzK5ImPwvqccD/sZa6+kdJ01138c=;
 b=I0UBvIm1SiigtNPjTFM9ruBVGioO/OaSqvxP20JNEfmVr97JM1D1E3XemdZg1sXRAhRUGsOmVbEXyIzwA0GXYyzh97NPoWgkIph38CYkSHie51VcWaBI3I+RKBEW0rb/fbp3CbSqSvuPW+GlrT3ZgT4qCe39ni6X+HamSSWUlU2gwyzhAkP3iJnb1kaTCrlUd33kGIaOGgDVP5OSAAkaA2ndDLQ2GyhYMxxLXPX+XPyQ8NYtMZIjb6Jdrf7neDh+LIxGersYEp41ntF6Y4j+qvZaqCm6oW7qrLtQZqpcD0aXtgPBuvUNKeqtbFjE7SkQHQ890nC85GfwxLNnKxzquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyBpuS29Aqypl83QzK5ImPwvqccD/sZa6+kdJ01138c=;
 b=UTjxmf1w/xcDbW9SO1dTTfxUjNgJilTwBlZ1AWB+6vu1zMLFmx3TeTbPQk00wocLj8IqxLGWvGVva4liHzkUzTtarWSd6f8DC94AdHmdui1+3klodtXl7wcmPk5bQ+9YNnfc9Lnf4yJUO3eBiHlP3lpZfdXrs2OB189d1GCBSBY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB17555.jpnprd01.prod.outlook.com (2603:1096:405:34d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 07:43:13 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 07:43:13 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 magnus.damm <magnus.damm@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 0/5] Add DU support for RZ/T2H and RZ/N2H SoCs
Thread-Topic: [PATCH v4 0/5] Add DU support for RZ/T2H and RZ/N2H SoCs
Thread-Index: AQHc56nGzYGBPcWMNkCDgPKka/DP5LYZrYxQ
Date: Fri, 22 May 2026 07:43:13 +0000
Message-ID: <TY3PR01MB11346BB32B2CD7697B7001780860F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB17555:EE_
x-ms-office365-filtering-correlation-id: 0b080bf0-064e-4379-78cb-08deb7d5c76c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020|3023799007|18002099003|22082099003|56012099003|11063799006;
x-microsoft-antispam-message-info: hwO3tnrlkbEEhVT+OTDD5yyfOJiAXfYIAVrtxJbesttgHhDRI+ZLuQ8d1eJ/dSfTi6Ht6oY2o7CwbF1BRpzbzRSL7birLwV0vI+QslorAjufLwFaUHFKHuXVxxxcrjqoJIGkL/MEnTD4/II5LNg3JzyBExTdlu88Kjuofq5oYbEEads4XJhVDZdfaJKjNJg0yi4UECIhNCWNhcJlhJ1zUxusU6KUAXrvJSHJd1kyOpt91+y+VSSO5mD3KEjuOZxngVSC/miCBkTJHcXNbPbzdhrSymPPBAoigIW71JXAGtWZUamrtBEbBBASQTTTVDcPcD17asTFIUCSvv4ObZAywyAxhS9NDjFOaa3zk7+T3rYXtRtU+j3G9hsH/ec0N3/xUcdL2BpQvX/hjmCkT97aHkvHptfQp0WXyYQCsO4VHEvWC8Rt0cpZ0patD0iYRhY1jbhKj+QTTxPOrhG70afLS2QGzdC7LqgG6lJMDJGKtCLj6udygrLB/2V55sOknXostpFkKTkMvbYWQ2OBfdqd4R6SwruVXwtseTJRNHSvjrcM8KZmHXkkD7KyuNHCYnf0ul7rSzPJEOx2ygenkp+RTWDcTmLMExSIGq+eE92FDH23e1EP3PZLDrhAvDwhyr7/FOciayXrW2hLzcTfET+4ldX5nEuDtMQFs7zBchfjFYhUUsRQPot89pyJatz3eMqWCyVnwlZvsN/8T/qGBgyrNHTydWAprfkkxrL+gktS1t8FQo8IMsbVVW5C+AJUYZvhZAtE/FcuqMxJ17disQEuqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020)(3023799007)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tbgle7snqVOfTW1iJ/j5iZsR0A8YF7ZCzl5aOT7PSutX2DL4B13nJP3ff+uy?=
 =?us-ascii?Q?HGYLLrIR1XDSX+vdnRJKDpATS2oAPFQJ5JuzrCWKXq4onnLkdKOsoJmUyGwG?=
 =?us-ascii?Q?sXtgoanlb1dR1UhAJjZ93/19edeXgfTEeGjU38Fg72zoLHh216Rkh25HhaNi?=
 =?us-ascii?Q?8T8eh1fecJl4pgVVLBTwip+x6o+xC/m/2+nL3NSxNi3cYm+EjOoRCnPgWpC+?=
 =?us-ascii?Q?ktHkXTEjSWPoCPYCSxpvKsF4UBWHYNx5c4SN+4tYcnEF8RRebzoNUGKLjuAE?=
 =?us-ascii?Q?a4lJGwcVdNn+9aIMZpQRTRLm24pNPRRZ78C5Axmz7/8n5WF+qC8SplAop4S4?=
 =?us-ascii?Q?Nqsc8c8oi4GpZ3i0zO96TUJsVK1BFxvJ+v8M3yau/I/pS779DdRQtdCPHY8q?=
 =?us-ascii?Q?6pTFOo9CzMDM0iT6r0fAXbGHQsk5wAg/LqTc1cUoUiEa9SAyHrWEJPu1gIIU?=
 =?us-ascii?Q?Ma14X8JOMdkwgSdlDNOrRye9AdEgB8/dbiujl7oU4VBoUQJzFaGcy2VBiKgc?=
 =?us-ascii?Q?v3n21b8bMDWO1FCy66OHoYejF3jvTcKRJ38dtz0nyXTSV5CWsLJ1J1WSeKTL?=
 =?us-ascii?Q?aA/H+lIkuZLh7ZiHQIYDutjPT7ZeSXlDFK738n34BT6u44HhAQGZWOj2od68?=
 =?us-ascii?Q?X5BVZOs1tbFAomdOz1lCu+adkN1Fa+QVv/q45xROyKVuyE1vMIyPXLeK6Ilm?=
 =?us-ascii?Q?1rK16MgnHsloAKUWB81aZo1uc7ocj3HB/uBHZ66Q4o71vMCrDuDluWAxmUz3?=
 =?us-ascii?Q?IhkRFwYcSIyj2VrFLHfjFGoty/sEBWFb1CGriOd44sNyfh9P8wEbnRWjNxLX?=
 =?us-ascii?Q?EEry0SNiR1fPyvSx73/BvJA2YksY/rotWhjpZO1HuG9FY78cOu3NFlYFm2gE?=
 =?us-ascii?Q?J5vuunVGmNousRgGu0pP8Kw8bHBqDNSBV8vBZLI/lpkIjnZvJ87B6aujNQ0E?=
 =?us-ascii?Q?8EyI4V2rKMFSNqFlm3PWmYnn1VugpyfFAOUMiEuCVGl8YTTNUolMFWgjhBzw?=
 =?us-ascii?Q?nnxCCgTW2duH12Ih1PRJUvOqeOmJUcIat3fyGWsxnD+AHb4flfiOujXe8Fj+?=
 =?us-ascii?Q?EDLkM29yYSZgj19nmcA4yD2Z9cKXJenzEOqfPyf2ZrFT1A7smM8uJulAFj6g?=
 =?us-ascii?Q?9G9MhEP+qiB9nhJjU+pZJ04kRDxLVqgkAX+w+J1VA40KLts7jK31tUduDdeS?=
 =?us-ascii?Q?kwZ0qVz10G4bMbS5ZBwFHQOcaHeqViZCZpzShYfPcQktlUHrcaQPkWBjg2N+?=
 =?us-ascii?Q?znXwKw3rp9pH1cuk4yiSfuiFINTp1wSqcJYcw3maQ1TrJuJoEtAjrUK41t2v?=
 =?us-ascii?Q?WEUOUAT15YRBjq07htiR2NUXd+nALjqVMRZI8NfyjFt2POl/YZD6/gdMMdHi?=
 =?us-ascii?Q?cS0ixn6AE4pxipRQ491qkEVAUSI1cnPyOcnNyy8B2nmYOKRBa33zHYuiWPNK?=
 =?us-ascii?Q?u6a9HnbMUyOitxwjQqUBtnEZnqMa9sMRZo1WB2aRbRWIvFkCBe6YNOnPiVGo?=
 =?us-ascii?Q?1ZkXnWk6J+QHmNQGHnuTOrzOOGccBukWwikiCV8zNfSom0TYdVE8AdE2e2Fh?=
 =?us-ascii?Q?uFRAR5U5B9jiH8GYBp48cYTlsQAy1CUYTGFSkh1XTGr2wJzZaOq5ZUTV/q1C?=
 =?us-ascii?Q?7bBi+UOqwqSOf3nHRljjTsgO2j/leb3pCza7bRX22nL5iz4Gtdw5deHucAHJ?=
 =?us-ascii?Q?oW9emhA1QwU6VSwg52wZzlRq69aLJlfMPCKDUQHBSQJa3nG0p4eLno8MNtW7?=
 =?us-ascii?Q?E+KlT8zaqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b080bf0-064e-4379-78cb-08deb7d5c76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 07:43:13.4324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2thQnMy+BPwyuWHdVmOjBPy/DJ9rAT6/b6a83m7iJbwBvgnejJuwFCQWMDR9guHfZFOyWphtz9gcc9hiemE2xN4+TLw12n5rTKnlz00v2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17555
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

Hi,

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: 19 May 2026 17:08
> Subject: [PATCH v4 0/5] Add DU support for RZ/T2H and RZ/N2H SoCs
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Hi All,
>=20
> This series adds support for the Display Unit (DU) on the RZ/T2H and RZ/N=
2H (R9A09G087) SoCs. The DU on
> these platforms is functionally similar to the RZ/G2UL DU but includes so=
me SoC specific differences
> such as a single output port and explicit DPI output enable control. The =
series includes the following
> changes:
> 1. Add device tree bindings for the RZ/T2H and RZ/N2H DU variants,
>    including a new compatible string.
> 2. Make the DU reset control optional to allow probing on RZ/T2H
>    where the DU does not have a reset line.
> 3. Move pixel clock validation logic to per-SoC constraints in
>    rzg2l_du_device_info to accommodate different clock limits
>    across SoCs.
> 4. Implement support for the RZ/T2H DU variant in the driver,
>    including handling of the DPI output enable signal.
>=20
> Patches are rebased on next-20260519 and apply on drm-next.
>=20
> v3->v4:
> - Added Acked-by tag from Rob for patch #1
> - Added Reviewed-by tag from Rob for patches #2
> - Dropped per pad limits in patch #4 and added
>   a check to return early if the output is not DPAD0,
>   as the clock limits only apply to that output.
> - Updated commit message in patch #4
>=20
> v2->v3:
> - Rebased on latest next-20260508.
> - Included Tommaso's patch to refuse port@1 for RZ/G2UL, which was
>   previously in a separate series.
> - Moved clock limits from device_info to output_routing to allow
>   per-output constraints.
> - Updated commit message for patch#4
>=20
> v1->v2:
> - Dropped the "port" property in favor of "ports" with a single port@0
>   child, to align with the existing RZ/G2L bindings and simplify the
>   device tree structure.
> - Updated the commit message to reflect the change from "port" to "ports"=
.
> - Dropped storing info pointer in struct rzg2l_du_encoder as it's not
>   needed.
> - Add Reviewed-by tags from Laurent for patches 2-4.
> - Rebase on latest next-20260507.
>=20
> Cheers,
> Prabhakar
>=20
> Lad Prabhakar (4):
>   dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H and RZ/N2H support
>   drm: renesas: rz-du: Make DU reset control optional for RZ/T2H support
>   drm: renesas: rz-du: Move mode_valid logic to per-SoC clock limits
>   drm: renesas: rz-du: Add support for RZ/T2H SoC
>=20
> Tommaso Merciai (1):
>   dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL
>=20
>  .../bindings/display/renesas,rzg2l-du.yaml    | 21 +++++++++++++++++--
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  9 ++++++--  drivers/gpu=
/drm/renesas/rz-
> du/rzg2l_du_drv.c  | 20 +++++++++++++++++-  drivers/gpu/drm/renesas/rz-du=
/rzg2l_du_drv.h  | 14
> +++++++++++++  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  9 +++++++=
-
>  5 files changed, 67 insertions(+), 6 deletions(-)
>=20
> --
> 2.54.0

Applied to drm-misc-next.

Cheers,
Biju

