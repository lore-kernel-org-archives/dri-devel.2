Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA2EC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8075F10E39D;
	Tue, 18 Aug 2026 06:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="EjUSkCVD";
	dkim-atps=neutral
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022124.outbound.protection.outlook.com [40.107.75.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB4C10E39D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 06:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPeWl+dko0Kuu2mNwbJnxfTZL7lrqwry7zvQaidkmSbDdF0l9+CAE24I/A6tuaCEqv/SjD4yAlLLJ4+PaWQyOai/sdMgmpyetxhRbcn0XAHDnQMRcipLAdGPhdQl/zjUn/Yw8hX1CleXIpjV8YUznSaieOw7fzXY2wJYQ/mmr1mHdjtM429DQCtOGJkpp8ayqwDBrp0NHiEDV009ocXqjhXDlr4S/zS+pzGMeAB+1v391Ebb2S+bPJksF0x+lPJuIwhMhwfXvYNpHYFc7qmlFBkT+YO3IwFIakRcNWt4UJqFpmbrUuW194B8tll92FJzCZRS/TzI9U4omXWyl47WSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMUqAPoBmTW6C3xYm4jtX/Rpm5+aVDfMkdXW6iOCQco=;
 b=SF4ExWUrNRNe4mYp00b2tGp8dSXPcq0HY8nHgXYzZ6N5XHME/8KPR7EVVf333sxNwq8t41kNAHhFL+umEtpvxrGR/ZjOWoaX26+9ATp9AFVhzDw+G6z3+ESibp0RzuncM98qoAdYaFVt8ltQysS0SuV+xrhRMTrkMx65a06BaT7M2W4J1J+oguA3AAqoZZH0Hyat3TcQbTBOF7rmqTM4lM7qZ2C+rTqyIRcr9fBrKWH2miEkhhyRdM3osQG7ul/U7U6/uA2iA44DZJirkFtPBM9ijd6fXjTpof6VLcTzXGYTDCjegIaoIqPoCX2CRKgCvEK4GHAnENvudxEPbmZ3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMUqAPoBmTW6C3xYm4jtX/Rpm5+aVDfMkdXW6iOCQco=;
 b=EjUSkCVDf4IFQrA/cFOce8lDALehkhJ3Eh5I/jDuKo4GLtuTv71nw23f/woSYWd2SaaQvSD9dNEtSksBVpOhmHbBY5Yuk958tpi6bNg+Wb5u1CDpX0+WV6iQCnF3Dt+o/kMp13UsAc+XneWHDrX2DyIgn+It1276euKkSeu9GObX+WrlPhGbY6EMHEr8hsenfpjwmh/os9d6xE4Xco8qS7fFCRfPpFjQRoUWN2/nTyGkEJ7PTBdKXKIlVa89QASCaZomD0MilJl5+QmAMNtQub2PYJ2MjZqPSwc9T05GaZQknYy9coMCv6aMgJjvXswMSB6GFBlYvPxRqJgpo5jfpA==
Received: from SI6PR06MB7590.apcprd06.prod.outlook.com (2603:1096:4:21e::5) by
 SE3PR06MB8740.apcprd06.prod.outlook.com (2603:1096:101:330::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Tue, 18 Aug 2026 06:43:50 +0000
Received: from SI6PR06MB7590.apcprd06.prod.outlook.com
 ([fe80::2327:95aa:3d30:2cd5]) by SI6PR06MB7590.apcprd06.prod.outlook.com
 ([fe80::2327:95aa:3d30:2cd5%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:43:50 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Jammy Huang <jammy_huang@aspeedtech.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, Dave
 Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, =?iso-8859-1?Q?Ville_Syrj=E4l=E4?=
 <ville.syrjala@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
Thread-Topic: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
Thread-Index: AQHctghLcM60vWSjB0q2hmYy6od4zrWz5cqAgB8T2UCAruV5AIAEv6LwgB2uTnA=
Date: Tue, 18 Aug 2026 06:43:50 +0000
Message-ID: <SI6PR06MB7590EB0C73CC9229B3A867D9F1A62@SI6PR06MB7590.apcprd06.prod.outlook.com>
References: <20260317-upstream_ast_dp_edid-v2-1-31166703c491@aspeedtech.com>
 <2efefedd-a36a-4b3c-a2cd-89db3499ebdb@suse.de>
 <TYZPR06MB6568D830FCFB93A9776333ECF1C22@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <b601f8842b959f6d8a2bd22bf6743dabad6d980c@intel.com>
 <TYZPR06MB65681FB22E654846896F81A4F1C92@TYZPR06MB6568.apcprd06.prod.outlook.com>
In-Reply-To: <TYZPR06MB65681FB22E654846896F81A4F1C92@TYZPR06MB6568.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7590:EE_|SE3PR06MB8740:EE_
x-ms-office365-filtering-correlation-id: bee4b7fa-7d55-460e-5948-08defcf41016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|921020|38070700021|6133799003|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 81kqJ5yScScQie79UTvYSiObT/R2c4skcGBYOgM6WlspEYFN9grncAP640r+XoPdVIMqom8qQkQQ2s2IzTjSLr7N0nnePaqR+mOVwWinXT9sHnyKd7Xxjvs0mF2dUcwTf/SUlYabsmEmwXkVNvS0KhXCKy32r/wJSJ3dUGV5MVRc84EjpHesQxgmus/asAFfp5fe6Aw1YvvBBAjd8Vx4lzlHbPb9tB7nQLo48gmfgJtIj5T2xTlbBAscfr8XU1htsIMmeKxrvxazBa5SyWuqK2vwVQmpI8XFsxDEkIUxIfIzZSa0hSXm54JcV5aBlWAWZRqBnwycFV0GW0gAT409Nqmneb9X357yRYoBvu+92f6SXrczprP/9vAB1yjQLXKL7y2TmdYW1vhINyv0m6yu3N63cNxNPsgEL7k3J31dTL6q3+73+N+CG8vvV4je7nNeAC0uYFb1Re41rDm/CMp/ggfaDfkLnav7RXo3m2FLU1FlMAYi3ZPmMM95GMPu7zPlnWAlM3Vn2MK2yW2r0oC9ez2vbASKcduIG23oX/c+JMyBo9SEYyZgtvfmrnrrq0pfx102nXunHM36YklZKHew2TrQRCMGJZUcLKSfX7gEG2WZb8agN1Dy5CnVdNpXDdw1C7bwmOLMVJTKk7QkOM+uJplX891+RozWecb0aGteyM+I0b0rs/OVxur0q1HA894QK1xm2r3lFeu9kPDUMNneOfWkFpfe901bS+OCIBXoI1j9v6FNisyMmVeu2UAPrMTf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7590.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(921020)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wiM5JWprDl5ugNDuuq7wr9qivLKKopmKvaEHBpac2pfTGyJsETkF0m3wRx?=
 =?iso-8859-1?Q?3YUJ0MRVLFaYU6HyodAwUoYdYrJw2N0VS1Y5bTpRUwD+SVvMMdGCruhnI5?=
 =?iso-8859-1?Q?7x47kN7y8Bb3s0DMjggxOyo3tbNLsc/HnaOBREzFcQvjkm35Uu0AgE/c5E?=
 =?iso-8859-1?Q?0v6v2kNsomoT8ZH1azDvsCTukyLF4d2v6xiFdtdU/JQMPzdsIEfxN6KAC5?=
 =?iso-8859-1?Q?zxmr7lOHLtGv4zF269PdFq8iC4CH4CrZAxVf5Hs185Uym3mo+rP9PvBBc2?=
 =?iso-8859-1?Q?zfMYDx1+WWEJudulJ/i3pWoDq3BeVEj8W/VSqRIIDF1DVS4nJFX7niUiqV?=
 =?iso-8859-1?Q?SN0i7GaKMmGSx0SN2E3NewJsRkV43+vA+NEpXoewq3KZBDMykcJhRNlDCj?=
 =?iso-8859-1?Q?0xQ5yBx8//ljpHlKSwEt1TfvUAm17cLHsLvAluWM5D8Y86WzEYGUcgIs/T?=
 =?iso-8859-1?Q?fxNGOazVFyqkhvnWRLDAI4scTP2A5CfLonIwaV/1YFcQyGNnRdQ+B0A+b4?=
 =?iso-8859-1?Q?P9sqaZ6a3o90pkBO5qru6H9TZQ/72LDVtW8tLTxqpNsqtTRwMdvil7lISF?=
 =?iso-8859-1?Q?0kALd7HCLRF5jaky5WuvCVdd+7cd4gRwTFTa3TIcFpFo5lRECma+i8xx5z?=
 =?iso-8859-1?Q?lMBvqCq0kX3PL7pWvs/1cUurLS51PrugVY+92vEV+pKW9/PG2AcSlA+s+0?=
 =?iso-8859-1?Q?9Md2QWVtaehs+rKsMEnpykeyBnwKxytlsccHaVstYGTEBnyVRQfBZmPH7Y?=
 =?iso-8859-1?Q?CSH+oFpQPLYA+xKiCLL6wT+qOBIQBHXLMSWtNp81oWLkcqug55D3PYZqGh?=
 =?iso-8859-1?Q?1JxoPT8RLTFDgz3MG2agpy8fEYZcqy4eq7hrxMz+lD+GdTRea6iE95TpPg?=
 =?iso-8859-1?Q?VGSjUu3my642ahMWJN0izIQwdAe0t8IKjQhCDXGyng/t6qxMEXj4wIbZpH?=
 =?iso-8859-1?Q?2sjpzpoQDOijDRSQzj5ScDD+DdQNqHgwZnsWaP28jFkALyyB/CQRVzuo98?=
 =?iso-8859-1?Q?SNPGsvZSv7PTVx6VewX7LtD/Jv1rZj4S/GJN7txrnfjE92xHoMqSMXTsTr?=
 =?iso-8859-1?Q?R+9NBGeaMAcSTYmQFbgC1MG++Jo1Vd7Zyu75ycGHAhw6j/+ZDWODbb/Jty?=
 =?iso-8859-1?Q?lx8jsTAdQ3lG9LZzGPc6Nu4loSgqdVkEIZZlo3FNZXWVx2Glg3ALIeBObv?=
 =?iso-8859-1?Q?Mx7tgrTe25WtampO3xulyR8xPeY9YR2qOj+zTY8ITgYrrzx4kWiiMMYFST?=
 =?iso-8859-1?Q?eVxYy3llu4+9BRAmZsjUmLxb41DfHjq+TIa0kc4HJi/5xdrJhpFWa2AvmL?=
 =?iso-8859-1?Q?e8KfquErYQn9gyqu8oWrdxFdk6znk6z/DsIvJTupCbgwYK3+hFzuNnClfB?=
 =?iso-8859-1?Q?DOhuq8Oc8q8gwSgmDO2Jyxmyc/fKdIKho6X1DTaFZ3VhAUrMFa2O4LA9oZ?=
 =?iso-8859-1?Q?6Fk6Bo+AdWnkaZ1xWUoginn1JmKv7Lyy7esEx3rCylVkOXtUF2tE5t0vNn?=
 =?iso-8859-1?Q?xZx4Beu6SRL8rf4l8AHREQpaFrmolMZIEJP9Qj2+0e/p/h+N30iSt062Rg?=
 =?iso-8859-1?Q?2bzBtG14Sjgs5xDmSv70Zs8nIelcFcPGGSyugWj9kmz1TcLGqvEQ6/jFPX?=
 =?iso-8859-1?Q?fFZM4EyomBGS+IFcko5Hm6xjly/oLH732R0VRl7p7bDMdLpXnKVZFi0TNs?=
 =?iso-8859-1?Q?nGXkWyrWKE7NirvOAkcu7KiaBhdsPP9uwe3/KEbh6GjtFzIdAE8Ij/OwVP?=
 =?iso-8859-1?Q?R0YFFVGUIMNCFyPkhJkxboUSEHy80oZFs2cCQ276vdfl4h3kWjP8W3q8nn?=
 =?iso-8859-1?Q?gUaQ1uxeLw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AOfdJx8BUWmwzAAJess6RY00IwE+Jyuu1ZM1J52KQ+tyJSe/t465vrZVj0Nz9dExJcZIndONlCUGZqokLC2gZbVghByZ4bqRdS00reowPP5t9R5E4C41oiDDaq7i6ICbNfqpiJnVwZRmUn4dpf+tTz8e4nwvXbomrduCZCKXcySQeCQ0c76FJ5fB+zwRNwIwes3N7nbUZ8QNQ1JFt1JbR1IiQGhq2qOw4VnxWBGNGF+hW/fi64cE/udvOfObEAZFWJ/jV3JiDFdueQnEiW0q8arK/Mmg4lqVVdJyrbKyFjtTdtA6bH9DKWyY1d2BUmhQ7A9H4LmoJzbMMrMZ0JqvBg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7590.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee4b7fa-7d55-460e-5948-08defcf41016
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 06:43:50.4713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTd+7UxT9iXDnYybpkAJBRqyrwC1zXF6aPAipfa+qa29IfXh6rtJmgDLWsgSvKv4CiFWCv5gqNiLUkZWyPnjfGbwEOqHxUq5zY81psB3Wn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8740
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

Hi Thomas,

I'd like to get your thoughts on Jani's point that the kernel should avoid =
modifying EDID and instead expose the data as-is to userspace.

In practice, most monitors I have encountered only contain two EDID blocks,=
 so simply returning block 0 and block 1 already works for the majority of =
cases.

Given that, would you agree that it may be acceptable to stop modifying the=
 EDID in the driver and only support the blocks the hardware can actually r=
ead now?

Best regards,
Jammy

>=20
> Hi Jani,
>=20
> Thanks for your input. So, your suggestion is go back to return -EIO for =
block >
> 1, and stop trying to modify the EDID.
> In this way, we can handle EDID whose blocks is less than 2.
>=20
> BR,
> Jammy
>=20
> > > Hi Thomas,
> > >
> > > Good catch - returning 0 without writing to buf wasn't safe. But I
> > > also found that returning -EIO isn't right either:
> > > _drm_do_get_edid() treats EDID_BLOCK_READ_FAIL as fatal for any
> > > block index, not just block 0, so that would have discarded the
> > > whole EDID for any monitor reporting more than one extension.
> > >
> > > In v3, for block > 1 I now zero the buffer explicitly and return 0.
> > > That makes drm_edid's block checker classify it as EDID_BLOCK_ZERO
> > > instead, which is non-fatal - it gets trimmed via
> > > edid_filter_invalid_blocks() (extensions count reduced, checksum
> > > recomputed), and blocks 0 and 1 still come through fine. This also
> > > directly addresses your point about the buffer not being guaranteed
> > > zeroed, since we zero it ourselves now.
> >
> > There's a long-term goal to *not* modify the EDID in kernel, but
> > rather return even the broken EDID extensions to userspace, if that's w=
hat
> the display has.
> >
> > There are probably a bunch of hurdles in making that happen, but
> > intentionally returning zeroed out EDID blocks is just adding another
> unnecessary hurdle.
> >
> >
> > BR,
> > Jani.
> >
> >
> > --
> > Jani Nikula, Intel

