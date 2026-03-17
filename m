Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC141FED9E3
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAD410E4E8;
	Tue, 17 Mar 2026 15:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TlQHH5lV";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010026.outbound.protection.outlook.com [52.101.228.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FD510E576
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEKk+QvdOsLar/xHNQ9KpNfbmRLyc6C8CvGkec2qIOYx8OX6s7mECAPtJDgI5WdRuJEp8XqLGxiqCLulOVLixLLh2yR2UX/HnqwBV9ekQiokV6b86CnoCmvVuAF6kY89jMPZ3y5EIrl57ZXaw14WKMtZhImt6iKKm7f04L3ZrGuCW3IUcRJMU4ReFeFTWf5XBPZB84574ng0RuAYGvMS91n2lZIrp/+Vyhm3ZFB6EfGSLUzLFA3LuloeRDosM0N0nqQQWM/xgK6z7ZvjNTBJW5yDQEgO9P5zqI+yd9Lnky8rj1A6H2+7CYbVKTyndAqgSCWUhjTnEHZk5bPuoIT0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySCxFwQCw9j7ZlK8Xt1MJiy3pERl4k171AoiftAPkWM=;
 b=c2G9OQz4jPJA+b9WiwB8Dzusluf0rXUcG3VDnhLdTVM69gKWfZ2wnFtXQIrDKuCK19gStWAqWgNVsdGBIWqOUv0DEytJGAYY+JHLjddTUY0N0pA8Z6EJqG/UkDcSyxD51np0YRhRarDG4tWIrVCoZwtNqVrg8LVzb1KNpd+JMfg8Vzu4p3kF+2DAqwl2Pj0Ufko3pSgPbUpn/PjGsRlcDzQdBUful/LEa4nHCxhDVH5R75JccGiwvzQoeUPt77GkwZn/ZJdYHGBNUjz0Fqr9+NeLZ8toqr3HIw9OYbhWdqD4N3sa29DUuIMSxU8RV58SQu/G1OJM24twSRqCzueyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySCxFwQCw9j7ZlK8Xt1MJiy3pERl4k171AoiftAPkWM=;
 b=TlQHH5lVHGoXVllUrY/ZN+phICpngvBotMifp248ZIkkG39h5d6WkhGmapStmZkHisRBwgm2GbjawDMwdtiXpOsENQMsc7hFvG/aXiQpPPp1FObWzOtkZFLjt7ELDcExvdqW0NwLqgL+VERWFqL7ccvaCIHAo52PhrTR9ncBuF8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11915.jpnprd01.prod.outlook.com (2603:1096:400:387::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 15:01:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 15:01:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Hugo Villeneuve <hugo@hugovil.com>, biju.das.au <biju.das.au@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Chris Brandt
 <Chris.Brandt@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/2] drm: renesas: rzg2l_mipi_dsi: Use fsleep() for 1ms
 delay in D-PHY init
Thread-Topic: [PATCH 1/2] drm: renesas: rzg2l_mipi_dsi: Use fsleep() for 1ms
 delay in D-PHY init
Thread-Index: AQHctgqoRUPN3p2KdE6QwNezekwI17WyzdOAgAAC/XA=
Date: Tue, 17 Mar 2026 15:01:00 +0000
Message-ID: <TY3PR01MB113462938CC04F72C5970ABB88641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
 <20260317123610.329630-2-biju.das.jz@bp.renesas.com>
 <20260317104719.e251fb0feb2e99b7569c2dc4@hugovil.com>
In-Reply-To: <20260317104719.e251fb0feb2e99b7569c2dc4@hugovil.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11915:EE_
x-ms-office365-filtering-correlation-id: e35991a2-d53a-4d97-2ff4-08de843600d4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: pELL50HaKPwHGIb6ZGNrRknGxXquJkht5iBmIqrSx7Mh4kyHEErh4bHr0B4WA9oJsgQzNfvBCO34ZsRgUsxfiB8DE1jSzf6w1TzLZxb2KSiynpfHpVOdZDhZIKXR0YWW/o++8zrb7vlsrMgqEj9RniCy4xjGEl5y9VAS23kFHJHMGwUoo8sQL8S5lJJUR6zuQNtct1hWaJRPjUHCJlsZ+eyBRpgOUeblgCyTLq+sD5ex2PUsbza+hOjRm/TUGm+yENDRUOE59PfjP2f0MueAZX9fvu8CzuAld12CuM1bJ9MG09DH8yE2Ml3sm/c+LVV2uyiCVhHIKBePDV38UPfRirHwX1mkba69WXXf1l6wyDSXC0ne6HWyB9UK9zeJjW74FVCAgfSCaILEjHmBhrvuYpB0PKq99tvsGSgL7qVT/ge+hAep1hLcqFj5HL019/Nvq82U8lGVBAMdLw99gLhqA8ut09pVMNq7nYlUy6/B82fNVHTINk1q8JHGOjajzjYWrGhgci/mLmUuHkmRuUfc4Xz0Y+USHmLDq4VnFfJ6/PePw0ACmsHPWSqB3jeHL5xAEruxpj/t1mdpkdQbAol4pmS4IoCX8vaM50mJgimLcqR5TaEf6N7CF1lQoClZwWCWDuAd9zJLfZD37z9lwtgooc2xHFN3XgkNd4+xlY85O3/fJBf/yo9fsshQ9FkvKFE/FLnx1SzyWHI2PzN9nzcnPzN9tH/ntXbLpSUL8Mr/O3vMrAwHdArrCVpqXPK1ZrZ5Y8jgNHFlzxFB5w+T/2E4v1OxlB2kMFc3xpYFkpGx5W8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WG0Ua5EMo72nWt2FhsSOqomOLlfiDAlOMaa5gIbD1mhdlg9rfHu0dQLlj4qH?=
 =?us-ascii?Q?klbBnph/ZJ2cjzF3nr/r39UskMFKRGs08J46qi6XAm9Z/z33Wkptq490rLET?=
 =?us-ascii?Q?bHB0RmmGUPHp2kaF+8QrnizhwAcXqko97McHe/bupL6m1lXrNSfvklNIMhUZ?=
 =?us-ascii?Q?gHKgwSe1BtpJx1d97/88KFGeUkWxYdMh0rPM7MmLuAXcW0DII71ItFGH1KB2?=
 =?us-ascii?Q?6PkiGdIuUj/EBstqd7YyS3nbf6Jewt8X5Q99WQRuyvE6/vKEKRrOf0neoVU2?=
 =?us-ascii?Q?+gwjLiIF7wo40yWUhOKvh9bGJbtmi2pQ/p1fczeMXCvXeLrvhgaN9cthOf+w?=
 =?us-ascii?Q?NrQdhZ4ZFSocIoCscwPK/9kSwIHhiGx9oPR8mPcI3ukzRHxAdb+Uqr5YPrVb?=
 =?us-ascii?Q?TgzNEJSDC1jnyJKzcjmoCQaCdFZy38lotsUnaWdgmP0AA3l/26xZ1nMjCZXV?=
 =?us-ascii?Q?n9/EZIkAEvE44VVHnk6t2t9u9EI/L/UaTVVwMCMOhWASnGkjDU6w9Das8JmF?=
 =?us-ascii?Q?rV/NLEE7CUugKEuhcD/wsOubj3gPC9Mm5bZG5+I3PXEzoSI5HN51gG0OAbge?=
 =?us-ascii?Q?StjCdsjCK/ATGJm8OioChfZRmQVbAf6f9I64s7H6h+2T6onaYSu6R3jJzpVP?=
 =?us-ascii?Q?5n3rWsh8NKjt+zBzfGlK2XDAq6CqT27KS5an7WL1wBt6osaYylvxj6kPADZK?=
 =?us-ascii?Q?kQ0mx1uv29hDZFj2bhc9qD+z6t5PJ+bOuu7vGL58eklPVhtjqyv4w5/9izfw?=
 =?us-ascii?Q?YNmGGzzhqxYHTltpByNXUW4hmg7NGSxKHotg6t913KheM92lsbZiHwjSYL9n?=
 =?us-ascii?Q?/ciP3MIt0WXJKJ2kvVwARmPYzTr8upmSqEXZIeUfxneqwyR7EBbDepXp6Gug?=
 =?us-ascii?Q?G47JZM3NUn4yIVf3TZbrJq5R9KebIjt8vrXOo5IpX5yAqB6cwxtkYGOiFY9h?=
 =?us-ascii?Q?YJIZkciDnKNP40vNTK4VRnxeaSVbZGJkFFWu/oIkhtxdfrZY3Ee+1GoOxUfi?=
 =?us-ascii?Q?f5ioXOFBfFmBBuSl5ctZcMWdxgegOvq0Urn3Z5Gxz27CBEAIYkSLCc50cu1S?=
 =?us-ascii?Q?QwZaNEHQbBg5oUwtCB1MEha3gAkv/VmFHRWJ51Se4ZtLtjNjpaVm0L3yL900?=
 =?us-ascii?Q?2QXG3W5fVmQKUl/FjZpJqhmMH76EtEVdM0uvFmbDmHhuL8tV+tvazpQZdCZ0?=
 =?us-ascii?Q?8X/eRC7CLEvFP5veqzP2YU8Q4dx7oFNpCrS5bL6+Slf4l0OjykUfRK5jDWRt?=
 =?us-ascii?Q?U/fGwKbMhocl7mw8BChi8xiZpwE9X4LBLZQ0v07AyCRdM+xyS7zF1b0Odq50?=
 =?us-ascii?Q?GY3iZ19Wqhj3XBVElp5KJL16TfT0UQEGaymr+1RXJYM0Q488uM93O52xdZ7Z?=
 =?us-ascii?Q?qqw4at2bT4SZpn0Rbmh7YvOGovKJ6PVMer+FyWhF9Yau0yuPut+vfsJ6yok9?=
 =?us-ascii?Q?hqkXRDyroVOV+BjGKPLPHl9EMb357clb2MRPiEjUZBuULnCmGNUcgNf2FK8G?=
 =?us-ascii?Q?dMK/UxU3xB6YtDeAE0Rh45SoavaVbDQHVxr7D2cuVcEkxCTqjbys8mJgSL5D?=
 =?us-ascii?Q?UkfC+cU1WpDO5yLfG7bZSDXOYAI0fA5K2kr9m66UD5+W749Trgg+NJePhXcw?=
 =?us-ascii?Q?MFFXot7Z9wA40Ce1mPk5DhJnGM+xTAc7MTVjS9HN/mMR12qu07cMztWk6+sh?=
 =?us-ascii?Q?QPE/L3rP6IbulfMqldwiy9Fh7zRGroM1YMkk2ICbA/6G3IOhLE1ESMLR3vag?=
 =?us-ascii?Q?Dve2DzB33w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35991a2-d53a-4d97-2ff4-08de843600d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 15:01:00.9923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ls9x5zkGJfZHnXVCrBhNiJXZvhHXSBW5F/1JnKBnfsO+7UVYz2S/OImA/GjZNxOWcK9HwXu0chcULITtfv94RlGD2pGF94Tpksm/6t2toXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11915
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

Hi Hugo,

Thanks for the feedback.

> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: 17 March 2026 14:47
> Subject: Re: [PATCH 1/2] drm: renesas: rzg2l_mipi_dsi: Use fsleep() for 1=
ms delay in D-PHY init
>=20
> Hi Biju,
>=20
> On Tue, 17 Mar 2026 12:36:00 +0000
> Biju <biju.das.au@gmail.com> wrote:
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The commit message seems confusing to me, indicating that you only change=
d fsleep, but did not change
> the delay? Maybe change it to indicate that you increase the delay from 1=
us to 1ms, which is the real
> reason of the change (why).
>=20
> >
> > Replace udelay(1) with fsleep(1000) in rzg2l_mipi_dsi_dphy_init() to
>=20
> Same here, the real reason of the change is to increase the delay, and th=
is is not obviously stated.

Agreed. I will update the commit message for increasing the delay from 1us =
to 1 ms to
match with the hardware manual.

Cheers,
Biju
