Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D92BCC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F8410F585;
	Tue, 13 Oct 2026 07:53:05 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023103.outbound.protection.outlook.com [52.101.127.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CD510EE39
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZTq5csAcj7zgx+rR9DJZQFLxV8ZGF8O93HZdeUROKhRemD/5YE1PkiLjpIAV5UEcXwIm4WVJIzitHTb9ROGUyxmpvDCPp9p5qhKxLLEFgDzHrx3K1CTDuseKCeImAyiZrozmCyzVl75rexmrW26axuN8jTIq4LTv4tjyO7rXIzB8JcLHdvCgg832DTWZcbYAKAqS2+VFaHV2J3jL/6rjHVYlBlLf+19ruHm3BzY5r5k835YD2tkKqXRhmaCePfjpuqlATWGvVvBD6ZS4XKVw82exCD0Vtk2q87dOtSkt35vvFiyQpWX2/o1fdzcjfKzE19J9EE83e/Ap7p7XL2knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwziCtOtDpG5V7yL9lb3yh71KiZHOCFA4OQFcl/b0Ws=;
 b=tW+rLPaBNt2EjW7nDcDukxE/xiI9ABAaImlh73qhFIgsFz44mqsSPu+cCzHoXj5Vje281Uyo/xKPSNboKmuGQEdt7L0ox31sOxdJi3l6k9evVqXRFqIJdNVi7++b3X5pQZAPeqb+Z475aT10IO/nerjAr/fEriqiEtPD/pjWS9JWpGcuIb/Q19rWY+9YPRjEUuttNkYDjR3mP1FQW2DDrHI71AqCEVNR0md7nsnQOJM2GiDLWQToIexWJ4sXeAym5xxuIZFSEziQbxJ8z8Crt+7A/twt8XDWaIcMpw5ONtIINse3V6aojcK/0byFwH4UCjTAzp1bRIgWFjYDCBslCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwziCtOtDpG5V7yL9lb3yh71KiZHOCFA4OQFcl/b0Ws=;
 b=A5ST9Xm1ZHRcnwJw2LnBLasKjDw0yrQp6KdBQOG4NInPG3bRe4LUCzN7ZwhYqg8E+OZo34NOMViIhMsK7Bj56enAQQJ7vyj5TkVTWXsX6nYguRvq/QeaO/nd03dSkPo+T3MbE6jwnS7V0hZV+pqFWQpKuqlqumWxPjaKAmbJrCDUUNBtdLWE3XYKmR21NZLRgeP9TM2A0ytAq40oqpCMTdSWrqGnUkb6jQ/PGVCzKLa6f9hQu7TA4nEYS7QBlI16jM2pbxtoUZUXUiNbPeHjX/vn/5UvrxO8kur6rSp2yqOD1xS/oW+rmyTQEJ78kymwGJjAj/02GSzpJ0UiaVYGgQ==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by SEZPR01MB5629.apcprd01.prod.exchangelabs.com
 (2603:1096:101:136::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 12:17:20 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 12:17:20 +0000
From: Miotsuki Mizuno <founder@crepuse.com>
To: "heiko@sntech.de" <heiko@sntech.de>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>
CC: "airlied@gmail.com" <airlied@gmail.com>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "jesszhan0024@gmail.com"
 <jesszhan0024@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "noralf@tronnes.org" <noralf@tronnes.org>,
 "robh@kernel.org" <robh@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: [PATCH v2 1/2] dt-bindings: display: panel-mipi-dbi-spi: Add UNIHIKER
 M10 display
Thread-Topic: [PATCH v2 1/2] dt-bindings: display: panel-mipi-dbi-spi: Add
 UNIHIKER M10 display
Thread-Index: AQHdWkOh808JDWsGukO/3LIhI3oAig==
Date: Mon, 12 Oct 2026 12:17:20 +0000
Message-ID: <20261012121718.53481-2-founder@crepuse.com>
References: <20261012121718.53481-1-founder@crepuse.com>
In-Reply-To: <20261012121718.53481-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|SEZPR01MB5629:EE_
x-ms-office365-filtering-correlation-id: c951f8f0-62c5-45d9-4e96-08df285ac3dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: J1tjRRZf64QJF7V/pdvT1RsSErQCdUb76/mssb2Z+Qvbt0AQkSBsDw8w6hG/EcrcU7pNa+196vDyNUibWsvKJ+woRWvDQ5cvkM7ybG7Kk2eQgvk4Zx+M9KVzpnbvC6lW/cfx7sZEi1o6xQ0/czZI/ArLSD+loFcR6aRg+HfaN7DliertQDbKPKldRKA1BanxDFqD/mBqjeVZuV9isPcQyeXHseqPiUf0FXFYKYeU9xXEgo0D43bqPKwC5cHuMNG1XzAeau1DpyTVzEPYCvrzOWj61I8F1RADorV62dvF5z/andASwhuAMAXlMZ5f5LR7csnozDmpIdfd4NuOn5/MyxrQ4ba2B/ozjoebfaRi454ZZDJWwAj4NjW2L0F1bBthLODjqYepK9JXlu2GB4qpLUTnHyz2zFLTFKvchIijJ/6M+w0dXmDmgm++qXSmrteYxhHJSIqfiXHbu+zQrGQy8M9UQZB0+mhbJRNu6kQKYwtA9CfjFjpXZDFsfqrc5zVWc1GsrddQu0Chtvaz8xU55DOmarKCCwTnz6//k4CzsxqgFNMNX3LNVuV3rnBwgTx0ZfyyU+qvKYTMJrXwG0mhIQ5mpOhwR4VY15Ms4RK+k+7WEJfTZFS7xE7Y57ICtjFbN5oPFAd3hzzKkS1L0qgVNC+DyYAsL7wBXyBm0JMrTo5kQtlPEy9M8XTPn/Gy/nrCsHNay2z/CvtYmZFrVF5dsFnt7WWLxzr+sHhqDJ0IPIE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rhItXXfBgM+muXCYaF+xBw5OxFyfaZj+01gJz9Wn2f/ua0rhSEugNM/Gns?=
 =?iso-8859-1?Q?9g3KvjqY/mO8miQRoI07PC3C/PHihWWWgwLZXHALxVOH8i+Nnbe/VrDjTO?=
 =?iso-8859-1?Q?zsg6Le58vUssjUmqQ26A2B1ze6kEHBALuassbp8+BQ9InXpmgSntyG+BKt?=
 =?iso-8859-1?Q?Z6ceI/FWcKI+U0DYEOLkXSNWxAVuVxIEcndDRvuW22OrbnBfKZ1VV4jPYF?=
 =?iso-8859-1?Q?S0i9aW9mxyvXzbmCaTn2JhH/fvAUAMAonere/B03wDibcZ65Pj2WgrWJa2?=
 =?iso-8859-1?Q?FTLcQNOd/MMK9glRyZEAzYmuB5ioond1zhpXArlIJIBpyqE5bEljRD98sf?=
 =?iso-8859-1?Q?ZwWag8lprAQwjU/aGOdXHLWYSCePtnjESCGfC6o/MhoFdwzkiD3uKqHZXY?=
 =?iso-8859-1?Q?vV3mMSQ1GqXruvIwvG8GXCeagbmH+6FFbMOZl2WVdJIDGmpDL/LSE0TIXg?=
 =?iso-8859-1?Q?/i6EZuebNJRx14vE+LCMmkZfCLq1JdOoA1N1XocAaWuVOT952+NcK3K/Eq?=
 =?iso-8859-1?Q?eHLN9zMDnr/tXu8odOGK0YzrYvNPpRJt+kjPEVV2ReOWhF9lFIpCm41fL3?=
 =?iso-8859-1?Q?saoQ3xS0bQ2bZYVvGZMoiac0gjdr8hh+jl0IIbZvLgStuH/qbDdjoJ9tkq?=
 =?iso-8859-1?Q?yGmv+fy6o+DeBX4+ihqBETP5Ir1SmCkBKO2HG1rMPHFfnsaOcivlNutXOA?=
 =?iso-8859-1?Q?ByeB7l2+RBUOq2n9tUuhNmcowaggX2t9dYpLCEQTwS/IdLNOt+TrfrQ90C?=
 =?iso-8859-1?Q?ouPNShZLxs/xlB4pjGciVru6jskNvpv7GVXfNXdOxKCNxiN+XOwut1wOJQ?=
 =?iso-8859-1?Q?QGKOYBYcGxllnS2gOOpWxIF96cYiGw0d7BYwANl6UFiwAh3E4V4R5ZuAxo?=
 =?iso-8859-1?Q?D462ldIQfayCN0L+C8KhVI1SHAV09b1vJyNg+AvV6/0nGxkrHBmJjR42+W?=
 =?iso-8859-1?Q?NTnAWSoUfzNYyiLZNoS4WvYX8k3+E71Tfi7pbccMsZhILYO/xtqQPHMKMN?=
 =?iso-8859-1?Q?qW/+H6oc9BXxMotFL5hdaCJHx2S61ML39+biIdHCms5uBKkOnf8MYWuJoJ?=
 =?iso-8859-1?Q?hCLf0BoFAs3zJ0fCokYoyWbH8SRGEiHxb0IiZ/tGMwETyEpKKlmS7NZg8h?=
 =?iso-8859-1?Q?E9Foh1kk3Jau9Nr0aBbOF5RE8W9mASd4zmVscs+q8H0GF+RMQOiVygKPkE?=
 =?iso-8859-1?Q?PfUEEPX7qJ5zpnIU5JcDEDmNynXFnizlmKn9mxytURJSoANV+9yrkpzKrH?=
 =?iso-8859-1?Q?l5emJ8w0Flm7d/3uVjWHdR4lG8rimHwteDdPx9JBP6wtksrNDyMQWn4gzM?=
 =?iso-8859-1?Q?Q/orBvJgfoaoamaB6q36jxscb7yvxDwB4qRdOJrsUBpBVPiCeJBSlFsQPh?=
 =?iso-8859-1?Q?PcvdF+kJrBeU53rKlJKL0Y0b4hHPNNTw3WbWupDr294gqoMKjJYyspyxcB?=
 =?iso-8859-1?Q?+9RVYMUy54L0EcBXZiHrMbXkQ/QSAE1OET7aFTzyQc2d+BlqvTOdyxpGpE?=
 =?iso-8859-1?Q?rpNuZyMyBZFfygV7yWglHvu/R+GWqeuj9i+t53HYJMPnrJH9L6+zNAgvN9?=
 =?iso-8859-1?Q?yRjn0FO9+h1SU9Zi9UWZj6IQ4lxzBIFU9pcq6fVcqtQd6Q49Xn6LMBuM84?=
 =?iso-8859-1?Q?XHOJ8YxtdZw9OM8RCMBKZTYx6yal1o1afNvTOlcfujojiFonUX1ggED2Br?=
 =?iso-8859-1?Q?sWyu2iBuyvA6PSrTzTS1f6Rp+MbOSTw9yEZBgUHKBGLCfT2FeDwhLlTa5I?=
 =?iso-8859-1?Q?xF3uUQOgBdcrHpSSUcQ+uO4VnGu802cGNCCPMdHByHiGSh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: crepuse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR01MB8186.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c951f8f0-62c5-45d9-4e96-08df285ac3dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 12:17:20.7523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOojU9vb7kLsjGTb3uM3u2JIV4Fo64cLjZMLl3FL56I5cn8HoN7jb+XfxxEWlFVKFaAhgrGDTstdZpE8tM/aSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5629
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

From: Mizuno Miotsuki <founder@crepuse.com>=0A=
=0A=
The DFRobot UNIHIKER M10 V1.2 has a 240x320 SPI display with an=0A=
ILI9341-compatible command interface. Its initialization sequence can=0A=
be supplied to the existing panel-mipi-dbi driver as firmware.=0A=
=0A=
Add dfrobot,unihiker-m10-display as the panel-specific compatible,=0A=
with panel-mipi-dbi-spi as the fallback.=0A=
=0A=
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>=0A=
---=0A=
 .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml    | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi=
-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-=
spi.yaml=0A=
index 6f0290c4e291..adef35f91670 100644=0A=
--- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.ya=
ml=0A=
+++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.ya=
ml=0A=
@@ -72,6 +72,7 @@ properties:=0A=
   compatible:=0A=
     items:=0A=
       - enum:=0A=
+          - dfrobot,unihiker-m10-display=0A=
           - saef,sftc154b=0A=
           - sainsmart18=0A=
           - shineworld,lh133k=0A=
-- =0A=
2.56.0=0A=
=0A=
