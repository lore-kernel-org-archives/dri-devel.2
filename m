Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CC4C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729A110EA5C;
	Tue,  8 Sep 2026 07:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="bBHwBO5r";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azolkn19012037.outbound.protection.outlook.com [52.103.23.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291CC10E029;
 Mon,  7 Sep 2026 14:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rls0qNgwjS3hyu8BdfiSauW+20Q15znzGX3gOPnJyTP1d7qCflS/H3oFRPkuipaguNCpm0e9SF2Tm1w0qRiqrvave3KSJbVAOcCwc3SVAvBTr3gBw1W/O26e/HsQ4gbqeEL95JTLcgPubm2Qexu660YWtl0hg41+X1sajZvja5+u+a0vWgYrGpwj023qIfruxSozdKd8Ed6mIx6m7NdLVkT5BneTTYSoKUUIeZ7IDkS2hh3CgI/2TUuv7r6wW3V/HOLliNKYbkxmOfTHC+Z6Yzttjk0eop67C3dwjZN60sDjJZcvbK+WjPIUV61FAsdTqq/CTJm83khY00z23mvjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHFazzkIL2W9Du9PeeUSPfL6F+d1uPRXr7wW9+2hNGk=;
 b=Ndqalx2LiC7gaPPmBAgWee1YnBjlfZxaf4+shGfLCwFyQ06koNu+DKiJn7VIr2crsFQIoXzZRWVTk6bxj6RSlhSnOT5at9aILzR3XpsRozq1ZRfQRzw6McOuIKGn6h0pJhK4KAPuFogYM0Ej1Kea9cRREotQdCi59Dqiif3kgbB0o+IrJMHgaXIii1K1d0V+mqmTPBrgnr8G+kUfKINWZaPpdya+MbnMBSN+o2xJU8w6IR8YeNGBTL5ildRzPyu+eH5kuo9VG/KHUMie7/a3HiwnPbU8nMzMeJb3cgBSAmaAGBTS8+hk5gXO/QTsjLLoqUmzyyJYA52apo4ISzHJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHFazzkIL2W9Du9PeeUSPfL6F+d1uPRXr7wW9+2hNGk=;
 b=bBHwBO5rVe4uTbvdYhls/ow81vxrdwyUA38D4MNFK6BWz2M3bpiPRFG76ABfc969WSSjIXq/+0wgzkNCyjHMOd5JiMTk5eoexXYkM/SXvUNVDLuqOuv6Jiq1DEJnMjz5sV8Wn9IUCte5+xVYiO0C4aGYlEtf+vL3hlkYagQd+mr77EIxlT39FxGAA4B9v5OVOXNjgUSiH1moVhqhrzDVsN9xKfgBFQamaLrX+6/Ku1sYaGvplKvrw+vZfjWFMfxwxR6F8PGjlxSOw8ID3sWD1C7wcJVZylkOph5n3j3sWuCKA4pLf/BNDi6QGzPqDz8hehVebfHqvitGSnDIwIKTWw==
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com (2603:10d6:103:180::10)
 by SCYPR80MB7598.lamprd80.prod.outlook.com (2603:10d6:300:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:37:34 +0000
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d]) by CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:37:34 +0000
From: Danilo Machado <danilomachado2002@hotmail.com>
To: "regzbot@leemhuis.info" <regzbot@leemhuis.info>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>
Subject: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after suspend
 / regression tracking update
Thread-Topic: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
Thread-Index: AQHdPtYqJOmSkr3UH0WwsXZ041k7tA==
Date: Mon, 7 Sep 2026 14:37:33 +0000
Message-ID: <CPUPR80MB6583B3189E299B6E138BD9A0A3B22@CPUPR80MB6583.lamprd80.prod.outlook.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPUPR80MB6583:EE_|SCYPR80MB7598:EE_
x-ms-office365-filtering-correlation-id: 27e25b90-a90a-40f0-36f0-08df0ced8e09
x-microsoft-antispam: BCL:0;
 ARA:14566002|24021099003|55001999006|15080799012|21061999006|31061999003|5062599005|15030799006|41001999006|22091999003|25031999004|24121999003|4140399003|8062599012|8060799015|19110799012|25010399006|40105399003|52005399003|1602099012|10035399007|2607281247196008|102099032|4302099013|440099028|3412199025;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+HhsPQaVgQ+rCtHkhbg2cCGyqGL2/3qiEwvAZJ0Q4UdRm+sq29wmwR893J?=
 =?iso-8859-1?Q?tvLc6BYxulpHJYHmgD384nKJVmMC04e2wXEUJ0rT9Tl6hBaD1XVcRn/4qn?=
 =?iso-8859-1?Q?8aT9u44COnOzwQ/Cvy/hu7qbySC7jE4Zid6N4xAlmG00X6Gf25E2xes6CX?=
 =?iso-8859-1?Q?O5/bzzKBwtsQIAR7/KhRn4QSSS5jtae0dlQWWdyFtGjU/EBFnGC1Shj1Oe?=
 =?iso-8859-1?Q?kCyYC4JE7nKCJ3xhW0Zr4lncjHLcelr+PcF/7mIOwF6xXJbhJULZ+YWawO?=
 =?iso-8859-1?Q?mgZgxhbsNK24c8MVaPztDE/s3dkz/PdWWkckFJXWJxUwFEzK7gPRScDNr3?=
 =?iso-8859-1?Q?qQHDJFDuGSFifA+xpxoBpr7OZlAFFbCcalFV1OT2Cf3OJbDtKWXJmlhuT7?=
 =?iso-8859-1?Q?wVm1FlMXUGXViGQAfTWE82J5c+V3qbgJkz3/3WosZ74HVizdevHQg1IJaw?=
 =?iso-8859-1?Q?iHTYvxkWWwIcIOKDIVlxTBp4JHiZS39RukOZCzbXPBKqokpysLajL8g+UZ?=
 =?iso-8859-1?Q?GkhcFbzhEDbV+wTJ4AriiSOlcKXIFtPeMD6YJNxzU1E8Oe6HvhFyPB0g0u?=
 =?iso-8859-1?Q?12+me0xdxC+vsQR03zJtj8e0qJOyFDoI78Hzs8iYIpqD1iD1rQ2lZvCP0/?=
 =?iso-8859-1?Q?GJ8wIm9MH2IQoLswSro0+GwLXZtwe9GToTG7kZatj7/avoanE31vpfMQ01?=
 =?iso-8859-1?Q?5nvz+f9JQyg3p90jlFFv+VgP0uHg39LRU9EqCqqHgtNAQQFT4LYOiXKB35?=
 =?iso-8859-1?Q?T4vAeXU4ieS0RxKQN8/yWb3TEYMABfkx4GvjWQWGLPGyYQuqiccza5FwxS?=
 =?iso-8859-1?Q?4LJG58vop6GgnciTwhe/6t4TlhA7d3MV92/TJA3WwQ6VXPxyuW2xdxZJLc?=
 =?iso-8859-1?Q?nlIePxPZz2Gd8mWVbPGYKh2pX+s06gAhcVvaO1TIlC0A3kjcgruGp8MfJr?=
 =?iso-8859-1?Q?cXVSrBvQy/XzWGv7Jl8Z1qHg/UCd5qVfCMl7lTmnQa1JJmNO5OTd01bOkX?=
 =?iso-8859-1?Q?OLEwJi9Vwxzl2WkrRVHUcRTwvufS/Foyl0S/KG2X41r0CJPDZQgts6W0je?=
 =?iso-8859-1?Q?7x5+zPFZUfhIANbYgzxaBRNpG0+toMfPyjV10EJ7NlkKUVIB2ccgjQxf1v?=
 =?iso-8859-1?Q?5o/FFAYciLeqFx7GmQkP3xknHwt9IJ+JVzuU4unm2r29JPD4ctiEyBNt3G?=
 =?iso-8859-1?Q?fQmVx3trqZAuOHd9IqGZu9dLj3N3jNTa2rTbshsAitZUZ8Iy5Yt0ko+OPZ?=
 =?iso-8859-1?Q?r2d/2nHLJQ/oQ4RzWn+Fze9itQ/s52LFJaHgey55o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iXyCCQMGQfS/bibfuZNuNL5jaRup/kO0NSiTkE8a4l/Mvdq2jAv29aqoRc?=
 =?iso-8859-1?Q?WpqtS+O8Z/c0hF6ddCt2ETT9zpmcf0z4SLqhJO17tWLbgkQUP3A6aRkF5I?=
 =?iso-8859-1?Q?kMiuLx8BwKdYKuyONhuTkIlM73FGHDuEjvmzXJIk3JgsV7s5JhZ8Fqshb+?=
 =?iso-8859-1?Q?OfpFKmDszR83tfB+j0KVS4+mqMiims4PGxKOaRzjEmVQU9UjRUR1qwojYF?=
 =?iso-8859-1?Q?ij1Kzm88oLuXeh6dbh5GdA3uuHZTyPWoikZcCU6RDIFdJLVtBzqLeZRGSh?=
 =?iso-8859-1?Q?BMjCKaOSsaGh+5x2q9kZw+yyCwbHm/nTRvCyleWmYbpMXIFFJDbdqRyzTQ?=
 =?iso-8859-1?Q?+WAATh7i3v9BGhbQo29pZM7grImaX45rXLPRKR3Hx+hBmVnu90L4Gx3u9o?=
 =?iso-8859-1?Q?NA/EqaDaN3/TvLNbmrlgerfLKi/0mJL1gF+m4jdr17VZiZouMzAaXqW4Sb?=
 =?iso-8859-1?Q?NrP1ky0/GqfcWQATSDTEeT+CnI13E4O5M35rvUya0Q/SAnn7qbiSKXwIbr?=
 =?iso-8859-1?Q?QuiiC6DKMC1YNti9Na53kqF0cqgUCBHL04kSJuHeSqxIzcyHu2Y+w14cQl?=
 =?iso-8859-1?Q?vj6AwPrs7lhm1aN3L0ulrD/reroFsRW9+QYEsG6ArvOS52AtwtX3DRi/Ik?=
 =?iso-8859-1?Q?bLHq75nmJuJrsmpZGxGPREz2wfYreRT3g7Er5lqOwpN2TmMfqpRPUq75T4?=
 =?iso-8859-1?Q?6/9th6uGvP/Xm/BpIhaHLt+IX4bx2s9IzaVg+CRMNlSfxUocir2M+jo2Ia?=
 =?iso-8859-1?Q?CEgZ5CfSbSOyOTtFKJi/jbYPyOppfPCahz1Lbi5f6ZghzrikUiqieJfVDn?=
 =?iso-8859-1?Q?1slcIUdN7pA9nkec/e95lwUopyuRVFRVmPCMzOgzHk2G1T6c2iYQi+HcvG?=
 =?iso-8859-1?Q?nhkNb8mlzWFA+/lC8oTmto905Imzq9nYzBN51g0Ftdhv3HRTSwRJthJvGZ?=
 =?iso-8859-1?Q?fiaGrsLxekbAm12/lBc5YAnz/M97B+a9klnLUxMBNQHFbQpvgeeCiuwclQ?=
 =?iso-8859-1?Q?Oq2xfhyM3RtoNBleEo/3OzUgcbgu7aadpfOPF8JpKFKjkO2Hp4TrwBJnyZ?=
 =?iso-8859-1?Q?zWuG+mDIahulTtAyGCJuvvhf+2itbLf95CN3FVPx2V33ZRnl201uo7wsoh?=
 =?iso-8859-1?Q?F/fTdrXwFmVcOZbPJQ6Otrgl6bCECAXGwZrY6Q16jyK7vrqJzbA/pV0a7j?=
 =?iso-8859-1?Q?n/86TRxGc6xUH0IUdld3SlAVfMWT/OjXG9AM7lA8hbCXDRIQKCkx4DiUVa?=
 =?iso-8859-1?Q?6ixlaC8CPXGfAAfojFw3JZoV0XE3ywq3SwmYpLe8/fVM+a+z0enaEgMYEI?=
 =?iso-8859-1?Q?KLcEd+xl4frxzcCWdUM1PQACrVtHo0pBbRyu76t95uxYzvitNYnEsJ+jSk?=
 =?iso-8859-1?Q?TwaPycExHMvD2KtpuJkHBMHlTCT1FRIp6mzSR+36+hvfdv846ml+tz9fOM?=
 =?iso-8859-1?Q?vqBqjO/uvV+829j9s4oE6bn2HQerAqxd0cXdzonPAu5g6lC7ZObZJq/jgs?=
 =?iso-8859-1?Q?l6vIHCoRkz7uMgqMgsqaurywYXcL26t5oIu/Xnq/9BIQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CPUPR80MB6583B3189E299B6E138BD9A0A3B22CPUPR80MB6583lamp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-665fe.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPUPR80MB6583.lamprd80.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e25b90-a90a-40f0-36f0-08df0ced8e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 14:37:33.9518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SCYPR80MB7598
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

--_000_CPUPR80MB6583B3189E299B6E138BD9A0A3B22CPUPR80MB6583lamp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#regzbot back in-progress
#regzbot monitor https://bugs.launchpad.net/ubuntu/+source/linux/+bug/21423=
89
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

Hi Thorsten, Alex, and Linux Kernel Maintainers,

I am writing to update the status of this regression after checking the Reg=
zbot tracking dashboard:
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=
=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/

The dashboard currently lists this issue as "fizzled out / resolved: inconc=
lusive", but I want to clarify that this bug is ACTIVE, UNRESOLVED, and act=
ively tracked. The lack of recent email activity on LKML was due to ongoing=
 technical data collection on Launchpad and GitLab while awaiting upstream =
feedback.

Current Status & Verification:

1. Launchpad Report (#2142389):
   - Status: Confirmed (assigned to maintainer Timo Aaltonen).
   - Heat/Users: 220 Bug Heat points with 44+ explicitly confirmed affected=
 users across various AMD architectures (Tonga R9 380, Polaris RX 400/500, =
and recent Vega APUs).
   - Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389

2. Freedesktop GitLab Issue (#5123):
   - Status: Open.
   - Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

3. Technical Summary:
   - I have executed 3 full git bisect routines on hardware testbenches, is=
olating the regression behavior between kernel transitions.
   - Recent user reports confirm the same black screen / no EDID handshake =
failure upon resume and DPMS display wake-up across multiple Linux distribu=
tions (Ubuntu, Fedora, Void Linux) and kernel versions (up to kernel 7.0).

Please re-open and maintain active tracking for this regression on Regzbot.=
 I remain available to test candidate patches, kernel builds, or debug flag=
s on physical hardware.

Best regards,
Danilo Machado

--_000_CPUPR80MB6583B3189E299B6E138BD9A0A3B22CPUPR80MB6583lamp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#regzbot back in-progress</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#regzbot monitor https://bugs.launchpad.net/ubuntu/+source/linux/+bug/21423=
89</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123</=
div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Thorsten, Alex, and Linux Kernel Maintainers,</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I am writing to update the status of this regression after checking the Reg=
zbot tracking dashboard:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=
=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The dashboard currently lists this issue as &quot;fizzled out / resolved: i=
nconclusive&quot;, but I want to clarify that this bug is ACTIVE, UNRESOLVE=
D, and actively tracked. The lack of recent email activity on LKML was due =
to ongoing technical data collection on Launchpad
 and GitLab while awaiting upstream feedback.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Current Status &amp; Verification:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
1. Launchpad Report (#2142389):</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Status: Confirmed (assigned to maintainer Timo Aaltonen).</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Heat/Users: 220 Bug Heat points with 44+ explicitly confirme=
d affected users across various AMD architectures (Tonga R9 380, Polaris RX=
 400/500, and recent Vega APUs).</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2=
142389</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
2. Freedesktop GitLab Issue (#5123):</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Status: Open.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/51=
23</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
3. Technical Summary:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- I have executed 3 full git bisect routines on hardware testb=
enches, isolating the regression behavior between kernel transitions.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Recent user reports confirm the same black screen / no EDID =
handshake failure upon resume and DPMS display wake-up across multiple Linu=
x distributions (Ubuntu, Fedora, Void Linux) and kernel versions (up to ker=
nel 7.0).</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Please re-open and maintain active tracking for this regression on Regzbot.=
 I remain available to test candidate patches, kernel builds, or debug flag=
s on physical hardware.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Best regards,</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Danilo Machado</div>
</body>
</html>

--_000_CPUPR80MB6583B3189E299B6E138BD9A0A3B22CPUPR80MB6583lamp_--
