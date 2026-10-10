Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B0CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58E5510E526;
	Mon, 12 Oct 2026 07:32:19 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023112.outbound.protection.outlook.com
 [40.107.44.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E4A10E0D3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 23:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu4GKureOVhtTXxE7APEzZwzQMQlf/RKvyZO6wPqNQqSeyTWkvmOMy84D0O5VOxhavkJodFaGkRj8i0eRb8R3C27PFw/S+ZyKglJ5AcSn6gbU7QbmsLgnuLDiobnRlSBI687pPnc5lEEHSBS3BUtaKeC0+MxFi3UPW0nF+h5VL05nZwxByhEgmOFEbAE2yAJN4hPtuMfwTlCkVqOqQY7VaUCOGZCpmDSrvvArUGrjR98QFj5FZcYn+lRWl0AWnROcVuCvcWDBdVFaY6IKGRO7WJ7kBzNkrKyydL4r8LxtjeQKxL2bxEty8R5VW37g2YtprMAVvOwSKpfF+1uER34rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f23X0aW7LUPnneiMORuszsxpCfMjXVfIPDT2O6DLt/c=;
 b=Am7EPA1R0eJfxtbc6jgOjfzHDEEEvMJ9oBiyM7iEAM8B2Zs2NxvE6IrFy4qEC3C4C8IEu98NvBL4laBqqBkCJb4IpMcZtMU5hRFbSJuGnIcFWDFu1NXMC4FKfVOlBeiRYK8VLWBmmJiXqpwzy1Hu5msHQo3TRY91Vq3npEFHwboVwwhoMMcQlcahUJ926YfOfOR7DP/TxyOvi1+qOTyB6ITsWmh8SGuwKL/XKT9Ti5yv3wiFJV53AIogtQRDZ0lyIDAOj4dWSaR6ptXxqRj0JND3hI62m7q2R130BcGFZEqnsgmIp/Ba7ndAZLsS1HUalrqZA5bamAVl96GWxNaZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=crepuse.com; dmarc=pass action=none header.from=crepuse.com;
 dkim=pass header.d=crepuse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crepuse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f23X0aW7LUPnneiMORuszsxpCfMjXVfIPDT2O6DLt/c=;
 b=aNTjC8F5YEiVTa6RxOw6JpjSAsX9uoGRdRYlZ3eZ/4yJ6bX/xWcUFuLe793H5fZ6Gbd0RzmkYfcUaFxULJKGktt8FAwt9n7ffCYFdYacEuGZwhlIp2WajrSTsMLbzXLnjUBuKNn7LFg71F2ANNA4C3f5W+d1YyrO0lyAFS6GBz46BmwvNNZfR9qj+PtPc1QJocI0+zFWpqL0HP4PV7titBY5rxSfsfxgLTrNF+NbvavOTvEd2Xz2Cvwrb2nZK3DppaQpsjFwzCg1xJTo3ZGHwKh187rSwS7+Hc/4gyUWXl7aLa1UxyK5niW+139zdUcjErvjD+KqCD7VJk3eTchOeg==
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:8d::16) by TYZPR01MB4380.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 23:28:58 +0000
Received: from KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a]) by KUYPR01MB8186.apcprd01.prod.exchangelabs.com
 ([fe80::fe2d:77d4:b78a:358a%4]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 23:28:58 +0000
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
Subject: [PATCH 0/2] Add SPI display support for UNIHIKER M10 V1.2
Thread-Topic: [PATCH 0/2] Add SPI display support for UNIHIKER M10 V1.2
Thread-Index: AQHdWQ8flnD0ImVcfEqLbuD0B1AlXQ==
Date: Sat, 10 Oct 2026 23:28:58 +0000
Message-ID: <20261010232857.26950-1-founder@crepuse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=crepuse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR01MB8186:EE_|TYZPR01MB4380:EE_
x-ms-office365-filtering-correlation-id: 1321148f-a768-408a-ed07-08df27264241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|3023799007|261009223027099003|38070700021|6133799003|18002099003|56012099006;
x-microsoft-antispam-message-info: yzNcPGJjPvM/gwtzUgGJpji1/sTCdGUFY60JMA07PAFrC2faELFOzD/OVH7qSekYNr0OuXimEb/rXaFgrk2dj3kSgf+zi7S2N8IDTWgafi1xKUJ3N42YkEbg/p6kn4GchSIpMsZT5wip/bl6d5EgFqKBDp8UvtNcniuaG8OklBItwI6ld2gPZhTDRGhv59hW6kJM2LQrXy+nKUDZ30yxDLwk/CDLlhjDXpPdXyAb/WumwgIN8t6BXnTgQV0FPIHqW42Y/GV39Utn2piLE/YgTms+JZzHcIiTGHNChAXmCL2I97FHPtzod3Te9blfY/U8YW6SE6fDC2qLZef2Iuw69wEr01+zoe9c8aJRAI8Aac6B8aP/aLO67jwEV14TVfH249v6gKdVY1+UflT7NcoiuS+4JDlBQWiz8sL98vNwOYUaVRDE+StaaT/dWDlgninUWeRbTHlhtbyhzcytYU7Tcanmv/tTX7c668Sa3oWTiUC6lt+Zvy3iwGX0gDdGjsKevLZn4wcHt92uSJ0yaM+IM/Ek347YZSahjcEkBX40WTxRKc+EiK27JxgI9CCVOzsI9eoQYRjny+L6p7B5cGHup3JjsDoj6jCkbT3L8i4tKw2pIhwxhwsAUeYiC0IIdoPi8Pk/U5ovKzhss4t1Wgk8AyMgDAp0DcqwuKjchilKzLSLF6XOXM8qaPmmy7O99xLPlsOSYFkrU/y4riuuTWPwaYZj4DuVApPuM7/dJcJtFlk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR01MB8186.apcprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(3023799007)(261009223027099003)(38070700021)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jG8Isc2Ww+0WptCJlL2AVNa9yOv/NdiRjpI9xJ0UEea3uvUrrCRBBb4LY4?=
 =?iso-8859-1?Q?Kkt3O6MDZr4MQof4MI+Ya1GvJxK6RvG7rCBTuJPg/MeQ6BhiYInKZc0m2O?=
 =?iso-8859-1?Q?OdZi6jksiWHv4IUALhVOnFFDYbx4BWms2ZF1+5E036KwwlDLXEX3AC51OQ?=
 =?iso-8859-1?Q?6UEpIJ11kXy6WKzDjUw+CYG3umqytfjtJaM/zK8UJDH/UMHowCvKzXs7vq?=
 =?iso-8859-1?Q?nWJPUfs3rbrfskfQTB1H5K+luAC01zivgxX7wHKDO8xN9k/plsoSmE3x2T?=
 =?iso-8859-1?Q?k0FdiyJa9ECYmIUvV+TvY43gVflkFponkDDeZtm8Vmh47akFGKismqk/02?=
 =?iso-8859-1?Q?CLKVdqzCjue/NC/rFDtSBeYaz1pMpvqBa0AVHbsOb3pTEkHFP2GYMit3oN?=
 =?iso-8859-1?Q?FSCXZEjrWIWztNTh1DKFHdQwnTcx6FpUepe+b49x0oFOoxX5FT/vB//Yiv?=
 =?iso-8859-1?Q?Ru4HQxTBA2262+Jjdz9lUIvFzywWqn5+AhrTr6gVZy3kV61rBBJ6qTiMYw?=
 =?iso-8859-1?Q?S1YemCInZ2nUNot7hjP6yyD7MsJB1jFiJTu8AV5G3LKjkGfc548VJZEos1?=
 =?iso-8859-1?Q?ANkCafJtPZuEw31tZ3IfjbS1aM8tQVYjQEWPUS77i+R2BHCSYyNn/S5GmM?=
 =?iso-8859-1?Q?XplNS0ni8N3QJGw/Yh60ZyAb6KtZx/RDTfxuRjN8opG2Nw5q6w9EUzZt6X?=
 =?iso-8859-1?Q?X8PLVzZsEqU7VIYs5U/LSLOPXFM1t/qR+7MEJ2LC8FOFoC1B4BmtREqw/g?=
 =?iso-8859-1?Q?+sEX7XSE6YJbaiGNytM3Y+6YetTaiozTMUMhly9vPepAsU4z8Isx4LNygP?=
 =?iso-8859-1?Q?zveCUNBQJ0uHen9b4my1vC9uNVC9Ogkhc+a/aco3WFNmdkM1IvqHjaalV8?=
 =?iso-8859-1?Q?9wQ9uK3L0djHjZNPxoKnZdG6CA8HGd3rp5kaZMVqpocuzlnXqr9L1la8Y7?=
 =?iso-8859-1?Q?uBHYB2Atld/ujeaZmaHwTDdey+yDNuzVt2ksJAZVs7SSknwp0Sv65cPTnT?=
 =?iso-8859-1?Q?iUEUcp6il1aCkwZgMO5lTZYGIQLpn3xv297A2qb3OxxzB35ffM6aweWBIv?=
 =?iso-8859-1?Q?DCeVcmTujuqNJZYcEvl1sHCBhTnpzFL506wpjDzIWNhcJFw4zT4dcDhrrs?=
 =?iso-8859-1?Q?wKR5uu/daQc9b2lLb3/KbskJ8pnBv1u4N8EFVR0AsG39Ks8RtVoRV8VHMy?=
 =?iso-8859-1?Q?1k35TIgKmycvHRM6hpf/7PiCZsBEE5fBxMulllUL0eMI43/Kj7la/0Vq4/?=
 =?iso-8859-1?Q?vkx+QCULWkNzEVCcMeyiLBgKN/ngLAMt8Mfl0+E7WZzSLMPJvFjH0DEjV8?=
 =?iso-8859-1?Q?MOx5Pwed5ZJfnDGvja0U1txpbfd7WUrNfl/mfil5SSe2SQ341RcEfEv4rV?=
 =?iso-8859-1?Q?uLNDJJD2UqB9b/qBDDfQDG/T4DR58LGRZdpS2C8YBXa1P+jW0E3gsQyueu?=
 =?iso-8859-1?Q?dIryLpLI7JZUJMVoYT9Kf2qrCFqAlg3+X2na78I7laFgjelmfUpXEkNIcP?=
 =?iso-8859-1?Q?6ziqD9BCGTQ9CBkSPbFWkKXCbzoaddcd+g50Sue1JjgLzADx7aYnJ+hrkZ?=
 =?iso-8859-1?Q?u9F9fJCPuoIBN2SzAXuqAPPJ08EIN6CiecosDtMOhXvQirftsg16WMCQ+P?=
 =?iso-8859-1?Q?TRPak9i4IHMijQltQNuCXYWKRV4r2ymvfQRbT7KkNLICFjkg4nsgtPiU88?=
 =?iso-8859-1?Q?+q0UkLA0YgWg7QYgyxNR1fPtJa1Rt1vULji+tfsOCU+5BlRWCSHCMPbEQH?=
 =?iso-8859-1?Q?TqU2hXnRgwoIGBVA/2kvlIhf9844XACtMmma6nTF7f0w63?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: crepuse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR01MB8186.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1321148f-a768-408a-ed07-08df27264241
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 23:28:58.3565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e189589-0b8b-4283-80ca-b0157c0a04fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWNbFIBiw089ngrg/BtjMngUobiBWKMf3DpDBazrLLch3NNTakKa/+eEUIxhZ3JogNecPXHeKdz3Hb2oC3V8lQ==
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

Describe the onboard 240x320 RGB565 display with panel-mipi-dbi.=0A=
The series adds the panel compatible and enables SPI2, GPIO reset/D-C=0A=
and the PWM1 backlight. It uses the existing DRM and SPI drivers.=0A=
=0A=
This series is based on the separate board I2C2 preparation commit.=0A=
The prerequisite board patch was submitted separately:=0A=
https://lore.kernel.org/r/20261010232831.26908-1-founder@crepuse.com=0A=
It does not depend on the pending NS2009 driver or binding.=0A=
=0A=
The 132-byte initialization firmware is available from:=0A=
https://github.com/mio-tsuki/panel-mipi-dbi-firmware/releases/tag/v1.0.0=0A=
Required filename: dfrobot,unihiker-m10-display.bin=0A=
SHA256: 50412ae6d29c5bbfb7fac585528a761fb249d7944011a1b19c5e0f80a0418e5f=0A=
The test kernel embeds it with CONFIG_EXTRA_FIRMWARE. Public release=0A=
does not imply linux-firmware acceptance.=0A=
=0A=
The nominal active area is 43.2 x 57.6 mm, represented as 43 x 58 mm.=0A=
The published V1.3 schematic is not used as evidence for V1.2 supply=0A=
connections; optional power/io supply properties are omitted.=0A=
=0A=
SPI2 input is assigned 100 MHz. Active transfer register readback=0A=
showed BAUDR=3D2, corresponding to 50 MHz. No oscilloscope measurement=0A=
is claimed. GPIO_ACTIVE_HIGH reset matches the existing DRM helper=0A=
and leaves the physical reset pin HIGH after initialization.=0A=
=0A=
Built against Rockchip v7.4-armsoc/dts64, commit=0A=
ae965b9856f033145e292b0c29082a26bcc45efd. Target DTS/schema, binding=0A=
examples and strict checkpatch checks passed. =0A=
The exact display DTS booted through normal U-Boot three times in this=0A=
retest with the original test kernel, without pstore instrumentation,=0A=
clk_ignore_unused or regulator_ignore_unused. Physical corner patterns=0A=
were confirmed; full and partial updates and five DRM disable/enable=0A=
cycles completed. The exact display/touch combination also booted and=0A=
its physical output was confirmed.=0A=
=0A=
Earlier boots reset during early userspace; one partial USB log recorded=0A=
an instruction abort. This was not reproduced in the latest retest.=0A=
The resets may have resulted from accidental contact with a loose=0A=
jumper wire during reboot. The cause has not been established, and no=0A=
software fix is claimed.=0A=
Exact-DTS cold boot and deep suspend/resume have not been tested.=0A=
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
base-commit: f4f7ecd2e0e8debcbab4789717cc79d570d665e3=0A=
-- =0A=
2.56.0=0A=
=0A=
