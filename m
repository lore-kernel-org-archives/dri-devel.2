Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371ACCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE98A10E454;
	Mon, 12 Oct 2026 07:32:02 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023112.outbound.protection.outlook.com
 [40.107.44.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A2310E0D3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 23:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yT/bt8AUlVP58RNTAmxXTmK4GgF3hONP+53FPazkhw3x9kEt2ThPXdmnDjOTYtl1N5J4qbwLoOknYxJ6gNIQBJ5gCtR5gfRhlqxsuCovCerVLDV9MjAApXwWM9hAEG33CgnTlmBZ5ms3dPrfyqjg+gk1jMzYM7KIsVQWzjECGlMA2Wz8PaHDnPdpLw4jyBBKfm0K/jbE8NgGmsfUCjR2+Lxq78wqS8Yu7dgAAd0FjzNONcAaG4zhYib7wZHKIJ/xFzK7GHMEVjhtu9AbCyw4tw0Y4LUOhrZLXP66QqPrlmBoA/9eb6162JFniKBEbQ5U+R/HuuHtMsl9Lg+GYHKxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2+kSdi9lUHigCoayCZmtOnwYzTXA6My5EKrCUw2s6c=;
 b=GCD8LavIw7ESLzZ8R0y1bTWhlO0ynIRhc/MYcaEM/DiZM8pWk6bC7QiAr7kqckDT52MoQ9Nx8H9g6PPQFEdU/WAnKKAGulM6vAlUjJLkSBthbH/rGPB71mTzNjcwd6Tilwlyt2oad4/gtUSEfWLxM+d8vtksPZjxVLA73pJdIpx168+dR7yOf9WNM3K3aAOC7jt8GMZZFLWThiFRfOuNiLibWz7P7mgHEDkQBwfrMt60QzsauNyPu+XueIZiHYHpQ5I23Frf0qxk8Qq7CM603nWY7/ExCjQ4Ob+EG4Ek7k86CX5T/uKm1PuNxxCQAGd2xRJNbeyYtIIrk55oKDPyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2+kSdi9lUHigCoayCZmtOnwYzTXA6My5EKrCUw2s6c=;
 b=S8B/CcW1AsiQHUdQb42qFvdFL8978mlyRCNoy9JhPbvNrqwWayPGOZIj2NbXoKbAuX4cbDv8Xhy9sejnqg+Jgqp0peAmQtaPUk8JIteCWJkU75V5LxWFlhOpKetpoPsPJe+6Na8vSXenwj1a1rS7XTSy5/LardUzNqAqPBimKCrWe5zjrZlC5Tb7MwUVHNg90rEXN8S444AncvsZGk16YhDiqxRk9syEkiMk8m0ISMlhSfL2dc0c953frTDQMk2+qwVDkPGslT+LIpdDNgL583UDTMsmhE8k3ZJOLu/F9j6FV8G9bahy3udxsqJfmrjaYyjcEBNpIt2PNb68R6a6Kw==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TYZPR01MB4380.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 23:28:59 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 23:28:59 +0000
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
Subject: [PATCH 1/2] dt-bindings: display: panel-mipi-dbi-spi: Add UNIHIKER
 M10 display
Thread-Topic: [PATCH 1/2] dt-bindings: display: panel-mipi-dbi-spi: Add
 UNIHIKER M10 display
Thread-Index: AQHdWQ8g5QeBlRG6u0O4CV2+kMRJmw==
Date: Sat, 10 Oct 2026 23:28:59 +0000
Message-ID: <20261010232857.26950-2-founder@crepuse.com>
References: <20261010232857.26950-1-founder@crepuse.com>
In-Reply-To: <20261010232857.26950-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|TYZPR01MB4380:EE_
x-ms-office365-filtering-correlation-id: d271228a-ceee-4a3c-ffd7-08df2726430a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|261009223027099003|38070700021|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: dye9xHJeHZaz9ARSv9IkRtTE3TUey0/nkZ81Wve4MHy5IqWN4oE387y5HffbIaiq75Z6sOwfJ7K/nB/V1nv6zRrIWNKkRJrCzKwK4S3V9DL+SjrUYafWtN2v3+xUnzNJfNA4JO0c+OYEFN09ppit5bihGvpiLxVQoZqkkAXxsPyDD0LF2NWIDUaQIy/QbosmZNOvZXRbw0uF7IMUEqmGLl/anxcW0NkSOWAIPlBJTo3TtkGD2masuCasfTPeqAGmcAC4F02+jLGVi6eH7cJPnpcWnuyXPeZJITA/kfHXf9BvPxPpqbrkM11AUZ5VzSG+WO5x8N1OW0tXLcYMWYINmOKrZEQLszi7NXgUmNjZWekz/92BuUTILd0vV49O7T2q6MC3yiTMCMge2cQUNcJBWnM2RDuxY8maj8n/rus/8hMbJ8Wd4ZDncCqs8JZUT09t+0i4V+h0Hwnd4jJnnghM84oWeR6SmUp1UuC/ZM8gnR1BstQ8Ad4fKqIyeJksVtcjTZlo3OSE6mUI585Tyym/geklpmoFnB3AUYL2lwh364flA6KwOhKfuUmsScGrNp172qpOHA5S5iRtueKEiRbbsN5UEnGAKzVt1u0eNtuWcFUIWfd2PVOwguY+Kpdife7UovzA1rhDa/fljSyDEvXAfDgiOFvB4ZBWXjQ8omCeRBgmkCTeXVYQNS6+joRO7ZHFYaeeCtP0G+ozz501c+LZau8TSwn4g/U3ZQ+ZVEOB+XE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(261009223027099003)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZfcSTjOVpSllmr/KaMBVRpgEq/NXhS2HqjSnJuT6TKLd8DtHlmIJqCONN+?=
 =?iso-8859-1?Q?Ggu4o2mFjeKLthcrT4h4UatQFTYaxmpqg8f/yYe9urt56tH+KirRKGampv?=
 =?iso-8859-1?Q?ngL9CG4mz1M8UEpantR48/stU3Z8l7mRpBCOwxv3Wzp3wda91Yt5B2mt4U?=
 =?iso-8859-1?Q?7irw1riMm6721CT31bqYb8Nct5hgqqRGa7jwf57m0hd9gsLAgi240OmP10?=
 =?iso-8859-1?Q?LN64OfpF9naTR8osvptwwktTihAopyYXmo7NHMA/GrXZBUq/ir+RvD1wIR?=
 =?iso-8859-1?Q?Ocag8rNdK85yJi0JQxmQGKUNAjKp8CIi44AEUsgSRnT12Nbl7s/FQ4IPU2?=
 =?iso-8859-1?Q?AHOyXADMfi/oPDTirZFZfpQRFBlg6cszIfM1BNW9qHYAvdQt093dsVadza?=
 =?iso-8859-1?Q?LNJnRfZ0ND5KuTyfkkBRI+5FTonlg4PLW55NPfE7rLlaAF8w8JBLXPCmRI?=
 =?iso-8859-1?Q?qDJHd3LPuJ6J0WZm8tE2wNHoSgGmUTulmRYrxvSB+tLugAXMOAu6DiZfWR?=
 =?iso-8859-1?Q?jop4SiSlEN/xW6edrWTh4XJDwMs/Oxux/qWmRAs8sVqPHvYDmxA6D52sqT?=
 =?iso-8859-1?Q?Yj5kJ/CY6RnzpEy/m2B7MTmDW3HOyZxnT4sVJJnSjZO27+J7aEUTzPtQKL?=
 =?iso-8859-1?Q?QIA9TQ7eVuJJ0uXpFrY9S1YAwe0UeVFPpOsrx/Ix65iV7iyTEcROnMndl0?=
 =?iso-8859-1?Q?KvwtU1gk2872SNRo21XTKxFaAQBy/RmXfqcNvtAu7lxdnRtAkYxts/U/PS?=
 =?iso-8859-1?Q?+qUM4xBKt/WWFHtTaexy4Iy86442aw4nMRbDiWCwc8BxQp6AxztcXv0fGo?=
 =?iso-8859-1?Q?aD3GBJcMqufJLt+i5JZsGkbGquu1F5cFDrqVSX+qZzaG+HLFlbLv6D7vBI?=
 =?iso-8859-1?Q?QUoair/j73u9kJeO9DQD+z7HAZ400r4009/oVIlY+uZiB3U1c32LkLSw9c?=
 =?iso-8859-1?Q?wJ4HgteGIpYCitL4c9tY6dE4IJsG9rT9am3SFajmBSSbkzWfRCsgex/QHJ?=
 =?iso-8859-1?Q?DFuqU7H/zPL858dBku78KxEMQJX44+xwZmNGYUsT9agvrnuZmlceQ0lAvl?=
 =?iso-8859-1?Q?HbkuHmH73ATMR4hhkdEZEVesfr1yAUHjbGiTz8HGHFrulmhc1c/wNKLe8b?=
 =?iso-8859-1?Q?VNPKyofkv/jgrEN6iROgcrLsqKnBJX81sT8CJ+4lLRKkFnaCN3fdoTTi1J?=
 =?iso-8859-1?Q?Yf/YVdyKeyvJk52A/Ebj0sviJ3rRDEMTSep8kF20xSNgCGqZPiTwQ3cZGg?=
 =?iso-8859-1?Q?qttr89uhcqGfAVYhGMebx4YxTdHXd32l5LEzz5p6LP+7+HusfvxB27RQqp?=
 =?iso-8859-1?Q?oTM0hcpJY4OxwIUIyG1JmNq6bltYbUC7/AHRA2CSfIgnb8mxn0geTNW0KB?=
 =?iso-8859-1?Q?By40EHJgFx5acLy8KLjZsadU1vMOywHKpqET3GQTa4keyCmmPqWwktDOmT?=
 =?iso-8859-1?Q?l/wK99mTl5FAb4R2SgDXt6OPcUHRhzkS1u3GRZ1taOJIS6OwGgiaHc4yim?=
 =?iso-8859-1?Q?zGUez6aBWZqnqSHfhfrbwkON51zBLsdvaKcVm09cWXejqKiu99OInMwxXO?=
 =?iso-8859-1?Q?bTzpFS5y8At1Eb2fBXbXL5fxv8Ys8ISk8iVVoePOsyRW54wJobkdfC3IQe?=
 =?iso-8859-1?Q?HMJGYbAsQ8KHIEeJNsOCfh3d2FVvePnqk4zsk5DcGqj2vVu4ipceIQlGtx?=
 =?iso-8859-1?Q?oFYHqIeIMU4COKoOw6AC3YrQdTIkTJx6E6dTuC7Bdq2/htdOwocJ7NdDlF?=
 =?iso-8859-1?Q?Ix6XuqdrUW3U0izU267glIW0JH2zGMSkaTJNL0KLHurz/Y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: crepuse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR01MB8186.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d271228a-ceee-4a3c-ffd7-08df2726430a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 23:28:59.6720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/F16oJIGvt1m5H6QtRtpPJAHqsMCMfSWOeqAZtD8W/zIZcVQTpQxR67Ok3HX4ZHO8C5kiwhUc9GViwLxZJtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4380
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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
=0A=
base-commit: f4f7ecd2e0e8debcbab4789717cc79d570d665e3=0A=
-- =0A=
2.56.0=0A=
=0A=
