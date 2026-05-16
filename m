Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3627CD343F
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 00:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080F710E463;
	Sat, 16 May 2026 00:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="Y23soZaw";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazolkn19010022.outbound.protection.outlook.com
 [52.103.7.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D58210E463
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 00:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObW40r9tDj5yJCN73HpSL6LRLKbpthSW+h0g79Wkz51yTZRNxGMy7KW/8oIgRx+TqLV08pzPlT1M3whrtMtDPvLqcbgGLb60xWv/ldrWhbOObeulSGJkMcKvGPXVaecZmTmxiwarKBvCkZ7j+UE/MXQg39FVRYIDTG0xBOUSuWOnXoouewfxFNJ1XoQpTGIQfa0y7GmcbfefPSpvoraNW+TXnX5XNemrU1eklhnBQMAd4WgHa1K/ddk3kzdNTkvc4NXL6171l+gi2G60JGb+2eNMeDAfWlveFCwTZx2kFJFMqPlQKAXYsJfPCdvzDq94YNLDy37x8WIvG+OLRZan/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhKyPBeea+J3BenyLxdKjgFmNJZAuewvqhbh3AgBO8o=;
 b=P0jA/N/+ufTjBWg5DOaC9zmpMuqx99TYJpA3HpOTodR2C8Iry4uh9TPffefcWRcvdYfGCxcaHe2q1tY5DG8D7HcO1ni0Qk/vFzKpG97NBmmkQZ3yC8IhZcNQm3KR8kbNvQ/QwlaiMhkTXi96L4O3u7w88q/rxRG3e6Y32mcl6nHn0fh1vyBVcc4+IWpZpJcS6eBnUT8Qe3vV7AzgcTciwoBxSgYITqYNvKewbtSlhyju17LHSJ7Ln7oVZzxPHur3PE6zFOce5SJ5XAYmDk/uRVNU2wBOfIE21fvhf8Cety5zhf2J7Sw6rOm1pT9wneIJK0o0N9tP0bA6INAGs3JmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhKyPBeea+J3BenyLxdKjgFmNJZAuewvqhbh3AgBO8o=;
 b=Y23soZawSINx5cx9ZIM+2yrlesHWkewKypExBB4qdVsiUM8wkmzn9z9uJaj6DkbV2OvFtmrM/KGkm1/jg+GhjYStneWjdSCHA/BhSUe5D+brayVH3PsAdcCXx4GwRT+Bh6C4RIW5NDsZnXp1ijF4kg9jkBkJYQrr64qOYW0/yI19d0OaYcu8lSQJD1vaC+1VsJazo+xb2qNJUMOUOvFiAb0xhmYLtee+3gXaJkzTK7FvKDf90C7sOgl+CdhRliMAmBTFidKxqDO/lfvYOcuqpvchcu0dQcEr38rpokA6rChVCqO4H0I26DPw+q8H8OQfbxFVtSl0LixmOE/ZpDMTQQ==
Received: from SA3PR22MB4082.namprd22.prod.outlook.com (2603:10b6:806:301::8)
 by PH7PR22MB4118.namprd22.prod.outlook.com (2603:10b6:510:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Sat, 16 May
 2026 00:17:38 +0000
Received: from SA3PR22MB4082.namprd22.prod.outlook.com
 ([fe80::f031:cd6d:ab03:93d8]) by SA3PR22MB4082.namprd22.prod.outlook.com
 ([fe80::f031:cd6d:ab03:93d8%5]) with mapi id 15.21.0025.012; Sat, 16 May 2026
 00:17:38 +0000
From: TR Reardon <thomas_reardon@hotmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v14 03/28] drm: Add "color format" connector property
Thread-Topic: [PATCH v14 03/28] drm: Add "color format" connector property
Thread-Index: AQHc5MMoAfrhfHxjHEOK68/4BiBfeQ==
Date: Sat, 16 May 2026 00:17:37 +0000
Message-ID: <SA3PR22MB4082A5AEA36B5FAD0CAC7125FD042@SA3PR22MB4082.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR22MB4082:EE_|PH7PR22MB4118:EE_
x-ms-office365-filtering-correlation-id: f4207992-cb3b-4cd9-2c95-08deb2e0895d
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599012|8060799015|19110799012|24071999003|15030799006|31061999003|15080799012|12121999013|37011999003|39105399006|20031999006|55001999006|24021099003|440099028|3412199025|102099032|4295299021|40105399003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HtJjxpJvN+hVoiChdurVvatyUkmDdvhhJMxA6VqpbE/WjLzq7/WJAsc19a?=
 =?iso-8859-1?Q?YggBdIwdPjiMjCrBRh2NNi28E8B9aDHmqXPG809IXCeD4mrlPARxf4t9yC?=
 =?iso-8859-1?Q?52S6VatYSSF/E3Q+NV/LgaZSiV6YvZ0ThxURmcks7P+addKKvaKgPqU2Bj?=
 =?iso-8859-1?Q?prxfdUDBzJAzMA04O+EbaoFpmLSlt5FqTDNcHKXowzgUcGxvNBccKV+rm8?=
 =?iso-8859-1?Q?nVb4rO/jReuDdxkV6psPPePLGtkRik0snRkHwa7EkadM6l0vxJnTD3oZS+?=
 =?iso-8859-1?Q?Sy++vLL8c6wNmw8EJevS54YHbKtFjv/fJekYaQe3eA7vUuK255TWh2pkxw?=
 =?iso-8859-1?Q?JRCJ/5P+tIQ3A2KzkNpxK0VtYoVo5LZ05UAzKdF8vbj8/PyVRa59eAXX9y?=
 =?iso-8859-1?Q?kag8SEfph7BU4/sU+FVijFndX6ORpWzu5QOBaokK3rkreQupgd6vc7I3yZ?=
 =?iso-8859-1?Q?IBz+Pogn1OAk28V2Vz39sC8wqQFeNhL75HtXsTnB2sxQVa8y0hMd6GCXrT?=
 =?iso-8859-1?Q?h+byH7WRako93dwnI69UL8IiFidDlnS+jq61IiTTKn3Qcnz8n3KBckaNFH?=
 =?iso-8859-1?Q?GZOe9meeL3xstMpqnkhJuPCwsQfl93OV+o8zPCqc1kv6XyLul8MgI8hED2?=
 =?iso-8859-1?Q?OkdhCl+dmFsp3ld27W+aF82CBXoN2QfTHEnpOPS8mIRwwYxL3V5d6grPMQ?=
 =?iso-8859-1?Q?dukLFQ1xEdjWHfLuuaEgCFuXtnLY1AvftaRNJ2HyVHDmxtnev11ql2uW9q?=
 =?iso-8859-1?Q?7ZbNWv+r0D7c0FjTwUg/maWt8K0wxuESRGGVgQFT0OkWxvRXgAP6MytdbU?=
 =?iso-8859-1?Q?E0Quet5RK/Bf05QQRyphZfQpVTlBTeERJGFfexQhZ9QV8346s5pLCeN10f?=
 =?iso-8859-1?Q?G5U79u3KDv97bDKfTiY0DrUvrKu5dYt2xGc6Ytfd7rMlcMadjHuEQCAHXR?=
 =?iso-8859-1?Q?R4WWYkW54KzHnEmsA9j0/bwwTSEY1Y2J3kLeJ2MVtS2EIvZOqkz8jRHfU/?=
 =?iso-8859-1?Q?StvQIVFL7PGe1wjLC5C4VK9KO+gWjPIVZcYVLWZWjRLIj5vK7NYqaAAGal?=
 =?iso-8859-1?Q?7gpMjPnt3gM6N496Fz9oWLk8E62srGkeeWGDHQkSzSmzZN840b2o+OXXz+?=
 =?iso-8859-1?Q?Ss79RSsdNv/FBuo4b7qjRaJCZlBnBl12ZBvlXER+xWcr+cBp5T?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N+SFuZdyxpHnndqpn/6hVsM0j0u0/x0jemoXC8eZmqnyO4N7FbWOUY90go?=
 =?iso-8859-1?Q?xdFfTrsDBrmsKbRUG8j+h+HD2vDllh8wJI1r6v1OOZCwfXiRIxdqVctbrL?=
 =?iso-8859-1?Q?pU8ji87jpkXZ0JJBOyaNy5kXlVZpfiDvlcl4iOWPtGcsI5jfL+NgmwRYrU?=
 =?iso-8859-1?Q?2QUx8RDEs6LBZ+uM8h+4NyN9iPjXx0LwcKwRWj28vCGBvtFc7vppZKJHG1?=
 =?iso-8859-1?Q?BuNQhTkvBx+0vdivxM53uY29hCgRaZRTXykfCEl975LYn7MvpM8IIlnFtc?=
 =?iso-8859-1?Q?PUQVetJnNKT/RUbv6k311GGMaW1d/cAbcPS6u++m8FWWWLmDFUD9o2luxf?=
 =?iso-8859-1?Q?jKjWWc+RjNTRWFgccdeoZl0uAh+75AbLu2ltdsFn6OY5DzqGazs5BEvBdp?=
 =?iso-8859-1?Q?2S1A+LcOgu1FnONoADKvgHGhTY+f2h+Mcbi+R9pCsB1m1upFsGdtPN4S5P?=
 =?iso-8859-1?Q?WaClDx+qvRhJcZ/ZxzJhjQSNHkkktdtx9sRCiWKcbpOUV70vxvXu7+vv3d?=
 =?iso-8859-1?Q?iGW62F6Ul3IoE6vaCLUscdosWMhBqu9oNJJCW3+QL4XLSSWdmgVxGTk9zM?=
 =?iso-8859-1?Q?novxwgDMpkTMfK9Mn8Rpsg5XQWfJNEUuG/AU+TzQFq/Di6LNOvFvBdCVtb?=
 =?iso-8859-1?Q?yD9Q/soeVovigBjfBK1k76BwD3PpcXMfBJGQoK3rs17XysUKxHgfozTfwp?=
 =?iso-8859-1?Q?BbrHT/8Ajo7ao8nqJWbdUWEOJeD42x87u6voPUbJ5MuDtADsq8cptH6Z9h?=
 =?iso-8859-1?Q?jn92miMb79014FiVEHFMaAdBOo/pT0ivJOGgt2VrBEUWk4GBDM7wYjFqKi?=
 =?iso-8859-1?Q?K4JYsyrCK+5Wo9Qss/zanVVX6Ea5xIo0Gz6yOI0ioYqscurAuRL+Pj+01/?=
 =?iso-8859-1?Q?MhSqKHTiS8M4uWzX/0I/uuXsWxA9C7N3OolZPh45YrnBHnBSDhodhtHXl4?=
 =?iso-8859-1?Q?aqIPD1xKH+rzeIXe/ppSeRfZFIDTqsqxrciG1iRrQLhVtAk11CQAYoaR29?=
 =?iso-8859-1?Q?Fwm4EVndWzmvuSxTUK1yHXq0RKCXTqjpxDmAguyjTkDbK+QEkxO01HVCgG?=
 =?iso-8859-1?Q?rg3acZ3Hhh98MHIreiWps/zecyk5DaBcSdLAOIt2Au4JZrBttv8JXcNQhs?=
 =?iso-8859-1?Q?Wf5onSyt/IdWYug81ZaC2frnoWNiWvfiHk3UbfY3GLGlNS1+WdwHw62ZR6?=
 =?iso-8859-1?Q?thYfa/OFIvetmAEUXmpccqDXHJLP3D5baDrklpp2FvbyaxUrlEQEaGjnC5?=
 =?iso-8859-1?Q?hSY25+Ou8Zv6KyB2TdDNacgs5cnhyFzvxn0SIVxW9+VNWFUukCZzSVJB5d?=
 =?iso-8859-1?Q?QrIa85Er6HPgpdaghGl60kN3aO1jBbK/rCJY4wexAOnEy6+v2BqdWL1at4?=
 =?iso-8859-1?Q?eiPy/R2OeYaYR1yQshEWUJeYhGe1CXZJp3tVB8ItbO2EdQJ0WRzgBfvecN?=
 =?iso-8859-1?Q?t3bGHbYoz455DKF7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c5c63.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR22MB4082.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f4207992-cb3b-4cd9-2c95-08deb2e0895d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2026 00:17:38.0061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB4118
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

Hi Nicolas,=0A=
=0A=
Apologies for surfacing this on v14 - the feedback is overdue and I should =
have raised it months ago.=0A=
I am writing from the perspective of a developer of media player software f=
or Linux.=0A=
=0A=
In the kerneldoc=A0the patch adds for DRM_CONNECTOR_COLOR_FORMAT_RGB444:=0A=
=0A=
=A0 =A0The quantization range=A0depends on the value of the "Broadcast RGB"=
=0A=
=A0 =A0property if it is present on the connector.=0A=
=0A=
I want to raise a related problem that I think is in scope to solve as part=
 of this series: limited-range RGB (e.g. 16-235 out of=0A=
0-255) is broken in the DRM pipeline.=0A=
=0A=
'Broadcast RGB' couples three semantically independent things into a single=
 enum:=0A=
=0A=
=A0 1. How the=A0framebuffer is encoded (full 0-255 or limited 16-235)=0A=
=A0 2. Whether the encoder-side pipe applies the 219/255 + 16/255 CSC compr=
ession=0A=
=A0 3. What the AVI Q bit (HDMI) or equivalent MSA signal (DP) declares to =
the sink=0A=
=0A=
The three supported values bake assumptions about all three:=0A=
=0A=
=A0 Full =A0 =A0 =A0 FB is 0-255, no pipe CSC, signals FULL=0A=
=A0 Limited =A0 =A0FB is 0-255, pipe compresses to 16-235, signals LIMITED=
=0A=
=A0 Automatic =A0Per CEA-861-E section=A05.1: CE-mode VICs behave as Limite=
d,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0IT modes as Full=0A=
=0A=
None expresses what userspace actually needs when it has produced limited-r=
ange content itself: "leave my pixels alone, signal=0A=
LIMITED on the wire." The CTM property is not an escape hatch either: the l=
imited-range CSC has a fixed +16/255 postoff that no=0A=
symmetric 3x3 CTM can cancel.=0A=
=0A=
I want to emphasize: this means Linux is incapable of sending SMPTE-standar=
d RGB over HDMI or DP. The content is either corrupted=0A=
by the kernel's compression stage or the wire signaling is wrong - do one o=
r the other, not both. This is a long-standing gap=0A=
that I am hoping can be addressed in scope of this series.=0A=
=0A=
Proposal: rather than touching 'Broadcast RGB' (which keeps its current beh=
avior unchanged), add a new value to the color format=0A=
enum that explicitly declares limited-range RGB content on the wire:=0A=
=0A=
=A0 DRM_CONNECTOR_COLOR_FORMAT_AUTO=0A=
=A0 DRM_CONNECTOR_COLOR_FORMAT_RGB444 =A0 =A0 =A0 =A0 =A0(existing - full 0=
-255, current semantics)=0A=
=A0 DRM_CONNECTOR_COLOR_FORMAT_RGB444_LIMITED =A0(new - declares 16-235 RGB=
 on the wire)=0A=
=A0 DRM_CONNECTOR_COLOR_FORMAT_YCBCR444=0A=
=A0 DRM_CONNECTOR_COLOR_FORMAT_YCBCR422=0A=
=A0 DRM_CONNECTOR_COLOR_FORMAT_YCBCR420=0A=
=0A=
Semantics of the new value:=0A=
=0A=
- It is purely a wire-side declaration: the AVI Q bit is signaled as LIMITE=
D, and the kernel makes no other change to the=0A=
pipeline.=0A=
- It does NOT alter what 'Broadcast RGB' does. The pipe-side CSC behavior r=
emains controlled by 'Broadcast RGB' exactly as today.=0A=
- Userspace that wants pass-through=A0limited-range RGB on the wire sets 'B=
roadcast RGB' =3D Full (so the kernel does no in-pipe range=0A=
conversion) AND color format =3D=A0RGB444_LIMITED (so the wire signals LIMI=
TED). The two properties are orthogonal.=0A=
- Userspace that wants the legacy "kernel compresses=A0and signals" path co=
ntinues to use 'Broadcast RGB' =3D Limited and leaves color=0A=
format at AUTO or RGB444.=0A=
- If both 'Broadcast RGB'=A0and 'color format'=A0would request LIMITED for =
the Q bit, that is just redundant agreement, not a conflict.=0A=
=0A=
This preserves the=A0existing design assumption that bare RGB means 0-255 f=
ull range and that 'Broadcast RGB' is the knob for=0A=
kernel-side range conversion. The new value adds an explicit way to declare=
 limited-range content on the wire without taking on=0A=
the in-pipe CSC as a side effect. Userspace=A0that produces limited-range R=
GB itself - either because that is what its content=0A=
already is, or because it wants=A0to take responsibility for its own pixel =
encoding - now has a lossless way to express that intent.=0A=
=0A=
Thanks,=0A=
=0A=
=0A=
+Reardon=0A=
=0A=
=0A=
