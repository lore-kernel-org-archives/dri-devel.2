Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEF8CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DA110F584;
	Tue, 13 Oct 2026 07:53:05 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023103.outbound.protection.outlook.com [52.101.127.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224F210EE39
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM0KjCMuJnQGEczPSFoUVBY1T2p4pgUQIVSHC0HCebu7nxrhnVz0b3RUgNIDNTzbQwoqHC1nJ6kQFPSs5bDBBycNy1OMrl8If8noA4E50YLahNyejjGBNG73zZ1GqEHy4wA1y7xjmeVwi9Kd5vLx78JArtUk9vdd204nC09HF+G1wNE3qxPT/PVLttcZ8HAspgBickmi2aFU1l99SoRycVQhFGIEZ/ZgoyD2I0qRVIVaUxm6y1eiZ07RX//lL7hyPvBxnKQOEgMbGsCqTIRmIpkad5xVOWEI8SufVx40WC0qXfiCQJnQLRJFFeV2lwaJ0G05R1Mbs1vpZh4p78iipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyxY7PZntcWg92US2ZzbzkyKn1KsPyOoQ1OBZrEzXGQ=;
 b=bv78ZAenjYlieyq0jH6oCewSj+pxf7SwXzE59sFvBrd4972ZOtZK4pHw5s9m0Vtrj86YSwTmUTPD71eeMtKitIWmHczSNepKdgcZ2+wA7SbAfp/Wf6oM2lR7yECTEaqmwygwtIaIOFmDH8UKanvuGV96mqMdtsiz9o1lCH0PZKd8XayUlCZYaESNtQD84twdtNiviWhEDbU7Cc07LCRrCFYZAXHjawh2GQ3XyI/oC8QAZCJ5zoXtEkjHftyZETytrkjhz/6i7+57ceg+RkMK0yJbbmbaKFAa/D+2vSeJoWKSnFbBt+UrXNTXMXQv7c7Q4nycrunlgDY5gnc1zb5pVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyxY7PZntcWg92US2ZzbzkyKn1KsPyOoQ1OBZrEzXGQ=;
 b=c2mKsvsfFABNA0j6N2RqiCVytbS/9cILz8F+kjsgfHK0jx+hTtkneLbydgCc2ew5kT+F5kR+cd1E7DtEOZ/3UF+JlyqB2cDQEUAt7sqRRqMqEOZ+gZI5q/Uzs1MA7r0/l7ne1yL78Y6PO96e6mvsl4jzYhnZEOqNgE0JBqWWrPfHBI38DeTONBfR4v15q678e7e2y7YDArwQlOGducT5J0Xg6yWjSEEMUIYwrksL2XT09swZnyYzU/7GDy4YS0Lzvb851H+BsIO1PUcN4aaR7R2p/GypPuQj1oVFCJ13h0rvmXCvNyUeXn0D/+qRd8oi/TCG1LEAZ8PcwjtPjLUoXA==
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
Subject: [PATCH v2 0/2] Add SPI display support for UNIHIKER M10 V1.2
Thread-Topic: [PATCH v2 0/2] Add SPI display support for UNIHIKER M10 V1.2
Thread-Index: AQHdWkOglTDdoP/ERkeT694Ie1kfpA==
Date: Mon, 12 Oct 2026 12:17:19 +0000
Message-ID: <20261012121718.53481-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|SEZPR01MB5629:EE_
x-ms-office365-filtering-correlation-id: 176b3b55-6718-4d65-69a5-08df285ac369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|56012099006|261009223027099003|10067099003|18002099003|6133799003;
x-microsoft-antispam-message-info: hJmJ1unZ2d3JwLFxj8H6FvM56JuTs68xoMbucz8weEsFldSUNTsDe6fuRZ/x0nJOBf+ijOAGx8a25OqgUwi15lSmKNffs6iMzhReKaG/s3aXwszKfBe6vwwMNAtYuLLIFtqpG0A7uKn6cMxieQywUWxAtfaNtL9zAGc62rO+YglzcVSAPF3rsNB+jv2dkR6qii2Vc9ID95eIhjgQiqJ6NEuPQk/lzHVx5/Ud0R9xkRs0d7+6AZlm3euYAGRd/UcLJ215YpzKcZIwt9HP0UkLJRByVDIG9ni++wneNENMoHtlSA6tQcaOy8pNxqcCcsqXxUJ8dw0FvN1LmLhJbJ7Eb8TiBi4aN8Hgyx3YVPY5rYD/youdPht7HKJcQmGmFQiiZX/mYEdlGXaqCgLHWkVVTlMK4fYXIAfkzLwF+5LtAAo8KpvV2Wv5Eqo1L5H/5LK2Rpy7I43MSb2qE+CDD/WbWQmLVSdu11brS+BAl0gYppEIlIYsKAsmrl62pPI8eCFZ9Of+Xf/I5shqsgmtDwD+y+R9J2FONcbJ2C4qF7B9oShhSFXQG/3Jb6+ZQCt2Fk2O/hpplks9ltQpJbV6fPh8TnzYvF5pJO845sb9OKIFz0Qoxm/v6X0vCSBAeolqm/keoAb/o54wjYOoDbPCk7ALkRnkfynjc4OaOqQERjqPs/nlk1i0ZKc+s6Ah/6owE4/sPg2StuFYgLUhEBik9ZdNRGz8v7douq/esy3mNpWrt0o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mtq5EawgRXNQHcYjGedYVkjslP9W65ygfmuDRRXBsgQmcS0zJowQS/2DbX?=
 =?iso-8859-1?Q?dg+8VMOLfUz7d5WyGTvmXT9EK6TYq9NtrF+y5PpDRcIi57l+T0y+Tkoi96?=
 =?iso-8859-1?Q?Vsk1IncVLZXDx+YyZzw9sJCbE6kdCE9lGgW/g8tCcZgfngHTdsSc5wsPVN?=
 =?iso-8859-1?Q?E78MSrggw4IrsC4/pig46sCNrKl1CmPDdZSF5kbptNSvRcp+9nvnU6hfLF?=
 =?iso-8859-1?Q?/vaJmklluJKrpn9lDwj4hkwRSLoPIFibmdQcxbxyeT3HZBHQV5wnYp6szW?=
 =?iso-8859-1?Q?461ge77JkWU9kT5nYVN5lSyj+gwX3QDTqN6hkddmxWpihJNjNr6KD2PJCU?=
 =?iso-8859-1?Q?ujoTGovxR/9ZIJQLCNSfEPk/WdT05SkNvv0khyWVoA/OjUoc7PHyVJltUH?=
 =?iso-8859-1?Q?30GhMggsc16ls/7G5Wq3GVKxT4/3OeZtibeOu82FASLgfibRC2ti7JAwtT?=
 =?iso-8859-1?Q?Gvp6PFMpu2u0i97y9TgvXDiT0w5G2aZZvvdUO8fkwivmN2Jids3fwuHEj+?=
 =?iso-8859-1?Q?y7eDVHYEiFWE3ykUXcm2DAI9nVRcGDZ7UF33mH1OxaKTjbGx2Ka6SmeOQo?=
 =?iso-8859-1?Q?mdPfMl5zcHN4fantyjkKOoPK89OeMSd8SkokoB7Acx31SiVJXBR6l7DWjd?=
 =?iso-8859-1?Q?rjCToK6Y1Ey5LTau3H8PgknuTCEl+H3pqxY0CLN7jHWvB2vN9Nezoczab7?=
 =?iso-8859-1?Q?PWZKhGn5PvyO3NYJaElDmXF8fAhk3xGLOY/RYoTT19lyBbN2YWDOzHU/hA?=
 =?iso-8859-1?Q?4ow+CDCIefO1SfjJ36xHxaipxK5T5GI+2U+Zan7GynzPcoHdb0Ine01cJu?=
 =?iso-8859-1?Q?5IVQY/I+Wqdxk+v0yRtSr3n818C+Jvk809FlPspOAECSXKUyid4sCi4Sxn?=
 =?iso-8859-1?Q?Mhs8KrIv0B+LVO00AieCB5WUernuPiNr+CNIIG8yFLYmTBlFu9P1dLtM2X?=
 =?iso-8859-1?Q?wm6cM+Npdbncdab/0G1vp4ZPK62/bKgsz1qelbudDhLpeYL2HCTh9xtpIy?=
 =?iso-8859-1?Q?NU7W75UoH/1+k1VuBnk4Dt8UjxEyrU2mgc5/oxi+s4mjbpQsq01e3uKZsX?=
 =?iso-8859-1?Q?I+qbz3zvzpqcdBkVt7yWMfG1w1pJs4z1YtNygCTIVWd399AhEvMobKzbgU?=
 =?iso-8859-1?Q?+AB1/jmXu+3eqX3Z8KeXtQBKvEn/RydeaMvUgvqEMhU0gTz5pTdRlOkOf5?=
 =?iso-8859-1?Q?Ic6aGVqwFsUoxVQxWJYU6kMpR1+NRx4C7Itt/RfXwWNB+bE66/rYkhq+Iy?=
 =?iso-8859-1?Q?LbJVfehhIuA1zCGkA5fh4Sn74IqE61os9jDGtSaq1jFt3a31LREFzd5gNp?=
 =?iso-8859-1?Q?Fx/ZRNQvUySF4SVhbyxw1ITjckSGy5F2LwEVA9Ybq5avPFDhvde60iZES2?=
 =?iso-8859-1?Q?Chxkzbm7r5pscSLcjN+fW1yVlfoxAwxVuZNxOiTuDxShsK/3VnV3yrk7m6?=
 =?iso-8859-1?Q?/XaA8dMrVmCfbKxmQahi/juXdbyA+nN/aSnk329Hx9N9W5Vrulc6N7QhUx?=
 =?iso-8859-1?Q?sde3ie2Nm+0pE4NAnL4OyjP162lyHK9PdzWc/mFIamENsKGyls42VR03Tt?=
 =?iso-8859-1?Q?t6VMKq+1qN0njCGMom0nSfL3kUtIHd4/DJGKQfSigOi7u0crcMvgbbfkaU?=
 =?iso-8859-1?Q?p3C7/BbQx25sumlvtwmGVkLTW5rzKsRr8342ZzWYM7XMtqlu1LRo7UVrAc?=
 =?iso-8859-1?Q?PNMKjBnGOJt+kHkAwGglRZkBCunkSK6apcvE9yHLwBb5y6bzrxNTBcyCRY?=
 =?iso-8859-1?Q?PwcLqu2SQ3eUqG+dLS1SgLqmKTMl3lmLX8KfQXutbr9Lxv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: crepuse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR01MB8186.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b3b55-6718-4d65-69a5-08df285ac369
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 12:17:19.4117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7sdPe98Fj3lVtwoRGgj03h3NTq5d8U4ePkPa+fW1rRoIT2IOOnrAzoIyf5v39n6AaryQL3tFgDiJtDoixlLDA==
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

Add the panel compatible and enable the SPI2 display using the existing=0A=
panel-mipi-dbi driver. This series depends on the separate common I2C2=0A=
board preparation patch in this review package, but not on NS2009.=0A=
=0A=
The external initialization firmware is available at:=0A=
https://github.com/mio-tsuki/panel-mipi-dbi-firmware/releases/tag/v1.0.0=0A=
Required filename: dfrobot,unihiker-m10-display.bin=0A=
SHA256: 50412ae6d29c5bbfb7fac585528a761fb249d7944011a1b19c5e0f80a0418e5f=0A=
=0A=
Changes since v1:=0A=
- Normalize author/sender identity and preserve it in each patch body.=0A=
- Check every patch in both ordinary and strict modes with the binding=0A=
  present when checking the DTS compatible.=0A=
=0A=
The binding and DTS diffs are unchanged. Prior physical display tests=0A=
passed RGB565 patterns, direction and partial/full updates. Register=0A=
readback showed a 100 MHz input with BAUDR=3D2 for 50 MHz transfers; no=0A=
oscilloscope measurement is claimed. Reset ACTIVE_HIGH was physically=0A=
verified. The nominal active area is represented as 43 x 58 mm.=0A=
=0A=
Mizuno Miotsuki (2):=0A=
  dt-bindings: display: panel-mipi-dbi-spi: Add UNIHIKER M10 display=0A=
  arm64: dts: rockchip: Enable display on UNIHIKER M10 V1.2=0A=
=0A=
 .../display/panel/panel-mipi-dbi-spi.yaml     |  1 +=0A=
 .../dts/rockchip/rk3308-unihiker-m10-v1.2.dts | 53 +++++++++++++++++++=0A=
 2 files changed, 54 insertions(+)=0A=
=0A=
=0A=
base-commit: d6c0b613da7796745d9ae71d0d0b87cb48ca25c6=0A=
-- =0A=
2.56.0=0A=
=0A=
