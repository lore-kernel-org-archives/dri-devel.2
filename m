Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A49FEA815
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDEF10E1C7;
	Wed, 25 Mar 2026 13:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QdvMrOHF";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010053.outbound.protection.outlook.com [52.101.228.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57CB10E1C7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 13:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBIvwYDY4PlGBcQNtewZzM9ViPpArE991Oa71Re8teBr648ZOalDZH5RaSY2i5xBbCwo2xnCcGazBoayJ2OCKztwR1K7q6WHjW+UdLYZPdvlo9g0J+x8cu6DHJOE+DZRSyGWkqOH8namy8KZCJbpxM4XGDuZKcZfiCrGKLkJps9FfwpO3KWZOee8onV78b7RvFptvf8sUG1Nj76iEzt2w1uwODnXpDnMDrGmub8SumfybvtKHVPyABuJn/84JieHIRDq/nKrS/HXjoqePkQVQUwNkdht6Y+zP9uAm8g+CBMlnesWZ2b4jRb0F0gPBbpyP2JKZ918/dTTO2Sjc85P2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLn0A4v4yl4/fue6WQoLai5KVju4TmwhgYXqRBLu04o=;
 b=o81XBfv5S/kCUKfR+bGLg1RZtMFJjEJKaUBTfHOUQmWK8ziyYi0MwhVCQjeaECc+DJczCiISLKPzHZBzkGDEdmkGJgnggNtzJBok6+C+dGrowwFWzOa9tuHM2D88k51HeQEKY78jycxPLlo+Yp7yuleMZ7FINRxkr4BScP6XoaT1j3463CmxL5YaEwI5liOCzk6SIINbejrQrI5UNKOd0j4wgY9f8agCMY9jpN4uO5NEEhHBGR0y972tx+72hnoSsvrxHXKl9CenpttFLh+EeXAfcCrmVn/meU6jr2N3+DW6yBMntdWTVv6jVUzkCHpElmmJ6tGXMwbRa0QhAfyJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLn0A4v4yl4/fue6WQoLai5KVju4TmwhgYXqRBLu04o=;
 b=QdvMrOHFNgzOU/rhqF9p8a3q6OuiV8JMOJRA7hE74O9WGfxjM+xqdTHpABEqHyDGTrehe6HQIt9jeek8nLjvCw6HUhjYpJYWtXJiAi+YwCErTs2/jZCSTV6jt8BddTeVrnxWf7Pf7oM9evSH06d2vip9mRmn0ABUFmliJcVS/4Y=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYTPR01MB11091.jpnprd01.prod.outlook.com (2603:1096:400:39a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:31:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 13:31:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: biju.das.au <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Brandt <Chris.Brandt@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sam Ravnborg
 <sam@ravnborg.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 4/4] drm: renesas: rzg2l_mipi_dsi: Increase reset
 deassertion delay to 1 msec
Thread-Topic: [PATCH v2 4/4] drm: renesas: rzg2l_mipi_dsi: Increase reset
 deassertion delay to 1 msec
Thread-Index: AQHct8A+aOtg03CPv0GtnFeZnAcwLbW8MNWAgAAPJRCAACj5AIAC12JA
Date: Wed, 25 Mar 2026 13:31:33 +0000
Message-ID: <TY3PR01MB11346B4C3476F86DA7A05F8608649A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
 <20260319164833.409126-5-biju.das.jz@bp.renesas.com>
 <20260323102015.957b2f855b7d54aa5d33869d@hugovil.com>
 <TY3PR01MB113460833AFD4BE4422E5E737864BA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260323134106.a439ffad5d1ff6927e0c549f@hugovil.com>
In-Reply-To: <20260323134106.a439ffad5d1ff6927e0c549f@hugovil.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYTPR01MB11091:EE_
x-ms-office365-filtering-correlation-id: 2608d8c5-a497-46dd-6f13-08de8a72d501
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Vf1O7b9k3iaxUqKwWQdRkou75Qu1LFouVVaCIuJDSgQ07VnETxIlsIM5wZiAH9wzlNV45vlA/QZyNB0ZMSMAaXcJdqZw0kE4TdpUPB6KfEvMOG734VptteAfMZPvlyps9H6V3WQ51aSHYnS1pObiky+9ezc+qomBpk9OZInygPLsgGEpllpQe6ijL91kBnFphgQk2w47K/I00F9krrLsrBIuytqtQyLuEWH5JmM5aIW79Wy84vpWw6j84V/U9OiJ9yoKxZRxu+TjyvdGsTsoTV1P1uabFLH9jy9xiU6nOsANsrhWvILdRdkqqTEaL00G9jKoqQabgt8h4lRmrlc9WxtVPH5YTz59NBEorvepgz0OTqYRzXcfTVStndFu+pFkeVhT/bVcHRw2YrV1pv2pSkd1idVMQlRMqYTEj+SFVOcfDlgo6RcwNKekwlqmNLJ9yP4D7ZerEhTwNb4+GWoxDCKD7xU1aa42mcgxjtDQ5uJpprhH0Klqfs0OkxSueVqXlHKF+EpRcp25n9JVXJRMcuiPMBPlZFvlAVGSDb95HtGJmeoC8ExQRWFUdfYYJF2oYd7sWyu8E8D1wkrg4i8MVxL14FsHVmAGEX27Pj4DtXTe/c5q823kKiqzCRfKUa5ml8GPGCwftgFOQ2kBfH2akElQRGkGo5mNQpOhOKkwtlJlv2d317RM2R1meEtgOG8S8uk1uqb5e7JgqLPCoPtgwf/kLLZbau2v0iIeOjMhemw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2tNkio0MQQ/wAKMHxIed17xkM2BftcIyloTWEvJSYEvWWiwaUISH98tUane3?=
 =?us-ascii?Q?UY8yaV0cQJp/YRbWjs2vzoMgVGU8bpPa0kuQVKex9NG2gEGWmhMEY7+BuTGA?=
 =?us-ascii?Q?zZRct6/VNocPe7KCuUzb1s4ibT+xjbWdqmt3uDOM5JGMjangJFE2YeQL+YST?=
 =?us-ascii?Q?RyHOdq6LrGAgAIaKyUaYU8z6Rr/5z7DGjgS7i4w/0JdOZgNYFyrAgO5L7QcQ?=
 =?us-ascii?Q?oANr3MrdK5MtDUCyH2ogcJg2sC7kOcV8PMq6+W6TVl8+VmhB/uMqSusnlBS7?=
 =?us-ascii?Q?8ljhuUy0l4B80Qo52uYZwTM805ZSgHyFqBUCRHTN809/0C/T9wNuhhFmv4Ro?=
 =?us-ascii?Q?5oHGzMwR5GABy2uQrmXRaL4dGmjirSZ9WBqognJaW3v98pFyf9HKakvjSH6c?=
 =?us-ascii?Q?DIT5C5O++t57gNbs4G0q2wMsj05++PVv7/qOWfCUn92YvRxGOrhWcdhpnyIP?=
 =?us-ascii?Q?IOf+kZFlk7kn1LJqf4UK1+SdVZEHppVjSRyWBQjdp6vznBc6QMXTBjbmsPrP?=
 =?us-ascii?Q?/S1ZezeORnt3Tbuer0Ib5Bt3EK4j5eVgPludaf91rTkbtAIarlwzbPJwTvWw?=
 =?us-ascii?Q?KuMIS2e0gsGfsmK8NUAp6c5AHBTZEpYum918KzJzYfvdl1HkGjqQaltdiiyL?=
 =?us-ascii?Q?W5gZ2lfM283W8W6dv7EMAIR6qcd7Ti+M8PQOTGQPEwFevzrgsedfZ5TbCl9l?=
 =?us-ascii?Q?si0n/buSmhnXRI/USAa66s4yjIAtT1yQl2brIOrG5wDbFYOp39mf2K8ciD8w?=
 =?us-ascii?Q?XY+FnuuJ6jNhYPtRsI9KS71ij+pWhBtSuthpE9S/Keiz6ZyLg6/W4MoW1Lx3?=
 =?us-ascii?Q?7IfQNcpKiyVWFmKExB0KVMDhJlOI/lumJDF5JdvUhK8PC6gZAfOYW42cm0SC?=
 =?us-ascii?Q?eFpBFfilwr5mCmdyEDM+Mrnfi6ttY1lbfkby3q0tIHVcRPlgpiblj5ksaKRe?=
 =?us-ascii?Q?tjG67Q3EtpwUp/eZ2OoVvd/nqEUr19wU7/ArGmRppi7wFss2HiYUSRlLtC+k?=
 =?us-ascii?Q?LIsVbm2Nwn1l1ycHLvJFpST795aoAbgQK+sAUH6WCAis7Wyt7mmPWjNViF97?=
 =?us-ascii?Q?2Jdkk9esJsmtpBmxLHtsUiaIMrAbwNtCdDVj8qy91i/gdRktFjcZ+hvQUjt4?=
 =?us-ascii?Q?p6anQvf7S7xc1CXszFCI0RT7sa8HkcT9LZ3sWvvn9MvbbJDWlTDvyQXS88RE?=
 =?us-ascii?Q?nPJJI+bJ1ZSidceFTsnk5NWriDv0Gw/9VerVaXOer0Vc+ZE4SqCz1AhXHBMp?=
 =?us-ascii?Q?ifghtmnUTWQwzOCXv4W0ed5JpRNcF9kF5Y8r5PH7TKJCsAj3e60Hj5wEAt3j?=
 =?us-ascii?Q?V/mChhnegBVw7Eslyzp321g3Di2vjyKW+rFV6Q4U9Hr4Vk5VsC5pWanK/eEX?=
 =?us-ascii?Q?dHy1w/VISr10apAMeeFXMBWSXkmJpjZ6nBH9xDDqcyZx6rRNZBYNLM9ViHmw?=
 =?us-ascii?Q?R6nJfb/Z8nJkO3MA30NKR7GjmHgnCcoOcHyqU3fGGpplNygPWbhhwQLTcB5p?=
 =?us-ascii?Q?GqnS63+mSNK+K19+/8YHJxwbymiOL+Ebj71e8rwHYDqGJyzg0/QcAu2CT4Mz?=
 =?us-ascii?Q?DDbEMyCRYoBW6OUW7dmj3neP2rF6wg+rgwGUqJNYLM8xabr9ycFp1ISmJMY6?=
 =?us-ascii?Q?wXpHHa9V+98ZuGX0VDWLmGpYKoGYvzh5dpD85YaE5jBePXAXp/ERmb9McsDp?=
 =?us-ascii?Q?oSqCBYzaMlwOEfCHBnS6EKxZHwKJq62AB/lHqyXR4SKp1WBfuXSxuAMILU1s?=
 =?us-ascii?Q?4TGAG5yIVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2608d8c5-a497-46dd-6f13-08de8a72d501
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 13:31:33.7209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YywnvPwpWuJ1bjkOMToil6TbXUSu3p87lt10gWGrvV5oKAkCCtQacIjlLpre7736T/sujMWbE0Tc3IcRf5UXLxe0Xjrha/Pfh42puR9yKp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11091
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

> -----Original Message-----
> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Hu=
go Villeneuve
> Sent: 23 March 2026 17:41
> Subject: Re: [PATCH v2 4/4] drm: renesas: rzg2l_mipi_dsi: Increase reset =
deassertion delay to 1 msec
>=20
> Hi Biju,
>=20
> On Mon, 23 Mar 2026 15:19:27 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Hi Hugo,
> >
> > > -----Original Message-----
> > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > Sent: 23 March 2026 14:20
> > > Subject: Re: [PATCH v2 4/4] drm: renesas: rzg2l_mipi_dsi: Increase
> > > reset deassertion delay to 1 msec
> > >
> > > Hi Biju,
> > >
> > > On Thu, 19 Mar 2026 16:48:28 +0000
> > > Biju <biju.das.au@gmail.com> wrote:
> > >
> > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > >
> > > > The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section
> > > > 34.4.2.1, requires waiting more than 1 msec after deasserting the
> > > > CMN_RSTB signal before the DSI-Tx module is ready. Increase the
> > > > delay from 1 usec to
> > > > 1 msec by replacing udelay(1) with fsleep(1000).
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > In your first submission, I commented that "...this should be
> > > backported to stable branches (missing Fixes / Cc: stable tags)?" and=
 you answered with "Agreed,
> will add fixes/stable tags".
> > >
> > > If you still agree, this patch should be #3 in your list, so that it
> > > is easier/straightforward to backport to stable branches.
> >
> > The patch order is changed. that is the reason I have not added any fix=
es/stable tags.
>=20
> This is not a logical nor valid justification if the change merits to be =
backported to stable branches
> as you indicated in series 1. Why have you changed your mind?
>=20
> > The if check in patch#3 makes it is not backportable to stable branches=
.
>=20
> If you put the delay patch before that "if check", then it is irrelevant,=
 no?
>=20
> > If I reorder this to patch#3 it is fixing just the delay mentioned in t=
he hardware manual.
>=20
> Yes, and that is also exactly what this current version does, no?
>=20
> For me, it is simply changing a delay from 1us to 1ms. Whether you change=
 it before or after another
> patch isn't supposed to matter in the end, unless I am missing something?

OK, I will move this to patch#2 with fixes tag and based on [1],
will merge patch#2 and #3 to avoid breakage.


[1] https://sashiko.dev/#/patchset/20260319164833.409126-1-biju.das.jz%40bp=
.renesas.com

Cheers,
Biju
