Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D218CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD8B10EB57;
	Tue, 23 Jun 2026 13:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aXm3DvzI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E276A10EB57
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgfU/rDsy0uRqUPxuqc2ykqYJu3t4LkX5/cfJE9X0oGnZCAuAgsfIrxVlpeO6QLulMynm3Auh64B38yBv/ePl++Zl3jkw0FSEHE9Y310mFsQ7GDjfMtya6jM9e96eXboJJqTSCXNng5aUGsqOkLjqbQZI2qXej/POty/pDWuc5usW5JNF6aBHhAAbao82Jb6+Gvba+6wjEYUNk/eRxreS9flya0R459FWm4csju4BIZvNQHGc5/H4HSEeJVyaxk8q9HyVjXiGHHLyviIGh9saZYton//YX+YBkqpCg7oS1E3vJ5N/H8UUxeIumNh91jWiI+/pBU+HrElTxvMtcRd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AemZ3CJ2nt/gY6NgQauj3Q8sgOT6omAA12niy+3H6w8=;
 b=jrVvZjdGH0FCkjF7ZF2hmR+UTdSJdcLsF4kt5dpNoTqV18p040Z/psIGHPiXL/KTaBiA90JTAnYK+lwZRkJoHUlRCaRbDNmRJUhv9Vo+cqrYxr8j/p8js+FhPfi8bB29CECP5qZLXxXXBTqFw5VB1t15PWKgiqnv/RbFpqUJ4G8RNOKp0l3Kpq+OJMWpctNJq53OBFYRds7BstT76B9VLzCGLHXuQ0nilzMg4vpt6eZBFT1e6y2EpIgQ+n5hB5w+z6Yng1Kw/njE5XFlHdIotQfmB1R6HRT2PlFNZFdrXo932ruGxQnGtvWnDQaqmksg0uSXB2LiD2eFmJjAhDmd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AemZ3CJ2nt/gY6NgQauj3Q8sgOT6omAA12niy+3H6w8=;
 b=aXm3DvzIzKcuFQsbFPO7Sv1VcLiuZXL6izHNH8o3ZtmAxPoYIEukPfwDH2qf7YmqwbBi/Um0bboCLEzdrNwMvr9j1Cul3NHPc6i5Izx9RMti0MM2LedeXVjFAL3Q7GSJ8Bd/HExaGlklKrHNl2tZ/fMQs/311RqIJmE4HxSC5OVl8Qe1C+E+/xte0iH6vpokroJRn2KPI1yWPVfcyu3BgPgU/z3hwhb44dL1YDYsR8qpMgBoRcGHaOe+uyG2HLpFDg/ShJHsI57+KmEs+IB71MTdQmF2JaMVFj9+RokHUDtnGhOWaEARG6PjP7Ccx+/BqBLzg0bHSCj2v3CWJq8B+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 13:40:47 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 13:40:45 +0000
Date: Tue, 23 Jun 2026 15:40:40 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, 
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 5/6] drm/sysfb: simpledrm: Validate mmap size against
 framebuffer size
Message-ID: <ajqMoKhDehM7ejGy@orome>
X-NVConfidentiality: public
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-6-tzimmermann@suse.de>
 <ajleu0THc75Ex7uN@orome>
 <d162a14b-7432-4d64-9f21-78a1150f9e0c@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lgywciro6k7wia4r"
Content-Disposition: inline
In-Reply-To: <d162a14b-7432-4d64-9f21-78a1150f9e0c@suse.de>
X-ClientProxiedBy: BE1P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::14) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b84c8ac-cdf4-44aa-da10-08ded12d0729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|7416014|1800799024|376014|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: d7EMq42JMkrFqutuCLjKwSK74YbU7h3SbcOrFgXLb6aNlceUZ2gFC15fZpfPkCP9cQ1l3Bc7DR5x//hRXL8dK1MfErNf/iWQM6G0gvvgPDd7phsVJTZsQd3VCsb7hK030QPqLO3mqzbRzoL3R9m40NBxCyDhcoXIvGyGqm4ei5wdl9h8AlJrC1gh/kbGjlPb1GoC8tfFNnPjcXp19EdKW2iEVw3o7bV5X7FQKkYS0e22iaEOE00o7WxQusanl+pg3D5k6usDiNJpC64YPoYSgP6tC78b9Jo4NdrJl+bL10EYwgvO0boVBjGm7w8HYvySnDQGcU70BgDBstnYPaTS/2i6KeRx8/NmWgaMyfA26erVXYHP9afZJHim9uwW//hG8VoDiiu+A2dzPtg1ZMdQxEadA3TsVfauDLZa/z5QEFOaMtG/uhmCw+NCFJxCjFhgni6hDqiB55TnBnx25mfOwtGSRrD7JWMv9V1eJZevydCCCg774GNLt2GJfut4cyN5uL/IrJILpNfFVc3sYzqv4Ry9vzYCFOp4qbGjrUMdYj5kbyQSsoFoedQVbM7KAzu6ESrh4lSt+iGu/i4xl4qTOUAfnAKibNASG2XuZL/4fv7EJcikUrhtz8w9wd0zYYwv/5Z0un2TkBoaz4P20lqrGkWqwyyLj/NMpGrHJk4O4SM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(7416014)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dvRwZ54LX2Rxtn5a9XMQ5kg5BvlwarS+Abw0FVeCaxmaqYk2Hf9/bq6vPD+G?=
 =?us-ascii?Q?viPljrxTlC6JMYxJL39HtBwldKY4HZkWwSuLoLLQOtK5sGPhkAzxSA74fi+E?=
 =?us-ascii?Q?gfprfHdOqI9RyfbrJJS7SFxdFlPGPGQvDwUwuYnIjNRCc7mIzSdLjcItAhfP?=
 =?us-ascii?Q?nzfgUyr46oH22rwSDGFvcTt37a7Pecc+eC5Z8z/UZsPIRN8kZA8ryU7JcPHN?=
 =?us-ascii?Q?ZhoAqwzdBx3S2RETMKQfs4pXYK/0l1hzBg3XcktAZA8IwbNSt4V0zjyD1nQo?=
 =?us-ascii?Q?EHXL6SdQedaoKlCEqXu7AHGqbOVb/m7HdelT1BlryqPqi7rYr7G7mOMT8leI?=
 =?us-ascii?Q?xwD2DgD5tFIpBhLDTp6MCabM4m0ghJKwNxJnJCIJj9QvvtT5uBrtmvmhzkhw?=
 =?us-ascii?Q?USUdDTPrWL3LxlUzKIGfcizYIuEyoTcYvfaw1HTX6n4UiP7+r0DmSyRRAsOQ?=
 =?us-ascii?Q?ZnK2WZWaOfbKI3C2tV9GYGs4EvknzowWGTX2kfsCXXsWy8cAHTx9Smb1MWKk?=
 =?us-ascii?Q?qkYyp/GTF/gmElQD3Zt+IvZSq7AS94Lj6IH7dshCL1ldfQ4BUC+MbCCW0/53?=
 =?us-ascii?Q?xwZXa8aRSJK01rj8l70ORjjGj/m85QfZj5vVX6oF9smrDFRCRciNEAjSCgRe?=
 =?us-ascii?Q?Lz2uRxiHoT3EYbvtvG70OVGF11/CNcWyugl9Iv23n31cQsp0UDOKcbYMTsRm?=
 =?us-ascii?Q?xV6R8O7AXIe5bZMSwrrkFzs9IDWDBN32oVR1Gwk/eZV7Ba4Lj07KXbyL3Mzg?=
 =?us-ascii?Q?Vy2RdJE6HeGNMpka6nW3IVSF7ktirHggxdn03KjQAWZwIKO1w5EdJ9USCb8t?=
 =?us-ascii?Q?TjHoFZlfFuxJ/oH0Zvy1gMHHbcZFz76bIP/Pte9zxNrMKn331zQsESR2KXjc?=
 =?us-ascii?Q?aM4hPDFWCmuOfN4NfnmsBW4vDvBqqtk6wkqfI9bddeUQfJpQ9YrmrD5cSL9S?=
 =?us-ascii?Q?cn7UPuq5c3EQMqYrnG58eAuufyg9b5al36Hpxqr3yec5ZUVRQK4774bcpgAt?=
 =?us-ascii?Q?j0e9D9mmCb0PjFLKHZbOtrFy/tiAYbSofcE02md2zbrcXI0TfmAao895WFZN?=
 =?us-ascii?Q?tCQlUeGfQqjZ7/7huVl00/ceIgEGboemRMY/CZHFt2h/fP0W75DS6xUDfCIy?=
 =?us-ascii?Q?XXeULDBCcl/Yt6K2E3WUF/81LmEC+6dhursMUDYGC0M7sORqCAnoy9qDCQi8?=
 =?us-ascii?Q?X6raONJ/AjEgD355x/wAUwIsBjW/OBdXggEDtOfszZN6iXBIbL+9yrdVB3rU?=
 =?us-ascii?Q?i5p9AD14M20TcaeZ1ttLsezphH2UjjK4750z5ccWfMhRx45/wY9f0JTvdMGG?=
 =?us-ascii?Q?Nfbc1yj/f/czuMfe/krmrAvKpqlm/D6/1ou7sXbNJ8QTHMQIFsM7PTKMCaPe?=
 =?us-ascii?Q?1BzcFn1dvSLBq23j7OWNpUltZKygzS8L5ernlnJQG55wxZMFlWRaQFKuitMb?=
 =?us-ascii?Q?VthI7sgd7ItWyE3ZnxcfNxVfxB9QnB/iK/QUtlgQ+IJVEs4DHYmlYcvjkSSA?=
 =?us-ascii?Q?T0vjbE+kRXxJdvz1AwF9t8WlaGtwnVSA/APMUbYssI75YDmdAXP8Q/RYxUMJ?=
 =?us-ascii?Q?LFyRbarGPQyN0a7hnLt6AetrFkaHYURt5TcoulCgDQy8Och71lYnxO0F1KgL?=
 =?us-ascii?Q?8JHmFU6eUHTWTnh1HhWJR5/3fq3kLSmL2625ZF31y2tfPwGj728hg1kV/TvL?=
 =?us-ascii?Q?xp1vKe1NW+Jtm+MK18kDMgfwNjivlzgAbrIFvm60oCBjisHfMsbUi0WpvyYC?=
 =?us-ascii?Q?68APVhM9VBvWt/E33h7lPf4LVtPM4gpHNoJ+XNuanZTvjZMyeSElLhYvIhP2?=
X-MS-Exchange-AntiSpam-MessageData-1: AZKRx05hbO5SRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b84c8ac-cdf4-44aa-da10-08ded12d0729
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:40:45.8978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Vti8ox35ryWfkVcvFfX/XO47QpyPXVJj6I8e0qQ0oYWT5ijqyE++OKReVoYic8fZd8DKy6QqpbGJ2YaumE6XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
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

--lgywciro6k7wia4r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/6] drm/sysfb: simpledrm: Validate mmap size against
 framebuffer size
MIME-Version: 1.0

On Tue, Jun 23, 2026 at 11:02:39AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 22.06.26 um 18:13 schrieb Thierry Reding:
> > On Mon, Jun 22, 2026 at 03:19:39PM +0200, Thomas Zimmermann wrote:
> > > The size of the mmap'ed framebuffer could be smaller than the minimum
> > > required framebuffer size. Validate the resource size against the
> > > framebuffer size.
> > >=20
> > > Buggy firmware that triggers this check should be fixed up with a qui=
rk
> > > on a case-by-case base.
> > >=20
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Suggested-by: Sashiko <sashiko-bot@kernel.org>
> > > ---
> > >   drivers/gpu/drm/sysfb/simpledrm.c | 25 +++++++++++++++++++++++++
> > >   1 file changed, 25 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysf=
b/simpledrm.c
> > > index 76b9a3f5c4ef..a04f0c852ea4 100644
> > > --- a/drivers/gpu/drm/sysfb/simpledrm.c
> > > +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> > > @@ -6,6 +6,7 @@
> > >   #include <linux/of_address.h>
> > >   #include <linux/of_clk.h>
> > >   #include <linux/of_reserved_mem.h>
> > > +#include <linux/overflow.h>
> > >   #include <linux/platform_data/simplefb.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/pm.h>
> > > @@ -624,6 +625,7 @@ static struct simpledrm_device *simpledrm_device_=
create(struct drm_driver *drv,
> > >   	u16 width_mm =3D 0, height_mm =3D 0;
> > >   	struct device_node *panel_node;
> > >   	const struct drm_format_info *format;
> > > +	u64 size;
> > >   	struct resource *res, *mem =3D NULL;
> > >   	struct drm_plane *primary_plane;
> > >   	struct drm_crtc *crtc;
> > > @@ -704,6 +706,15 @@ static struct simpledrm_device *simpledrm_device=
_create(struct drm_driver *drv,
> > >   		}
> > >   		stride =3D pitch;
> > >   	}
> > > +	if (check_mul_overflow(height, stride, &size)) {
> > > +		drm_err(dev, "framebuffer size exceeds maximum\n");
> > > +		return ERR_PTR(-EINVAL);
> > > +	}
> > > +	size =3D ALIGN(size, PAGE_SIZE);
> > > +	if (size < PAGE_SIZE) {
> > > +		drm_err(dev, "framebuffer alignment exceeds maximum\n");
> > That error message doesn't make sense to me. Maybe "framebuffer
> > alignment below minimum", or something along those lines?
>=20
> This tests that the align operation did not overflow size. The result wou=
ld
> then be 0. With the earlier patches limiting the height and stride and si=
ze
> being of u64, it's not possible any longer, I think. But testing it doesn=
't
> really cost us much.
>=20
> What do you think of "aligned framebuffer size exceeds maximum"?

Ah, I misunderstood what the code was doing. Yes, I think that message
makes it a bit clearer what the error is.

Thierry

--lgywciro6k7wia4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo6jNgACgkQ3SOs138+
s6H/3Q/+J+TRLyHm8l96R4hqKn2KI8CJs642d4VrLqpzUPFg1EZJYQ3+smlC+Fh0
bJjg6tV5TD3aq3dqwqKEe9EZ9e4U6jNpYFtdMMhlcMYHdSAOjwWSjC/xoL67XTnw
AOWHYNStmT88nLfhRxyUBuBZ1qleSx2/76LQajmkavkG8KhymjzjJHE7vAHyzRsJ
7LqNrDm+y/0PfaQn7ZxVYZtB3vfb3WiN0u+KumxeFhhBmKxEK5eySxKL8ehcmR8g
wPNvuAzRRY6+VxCDh1p6Mnu8fNXsvKbzyA/1dtwGxQTJzjo0yO1S7mCm4/hY5W0i
bWR7OEGa7lOUHoB6mLEx62XytQaQRz0dgFja5JtUwm9TCDZBoIjfxyFRjsAEDak8
1azm4jdzvRxFTXmTlLiOhD1UsHNKZ3emfQeCW27VjBW9hQzowC4cw+N9HINI5pr3
hw9hiZ+KpEra/CNUtjd+mJfaOl2mzjzb0M2W3G5HRApFgcymeqNvT8n6aPOJj7qi
/5GCG+Av+bKsmCx4E6Jgq91OdTLLZziv9wLO0E/xa9AupBg1UidapxQ7LkNAUkAm
0ncQUZ5VnQp8U3qDLsNC87aesQdKh4Ef0pJIzd57tf4lW7j+xyRomwoZaDOfGU8F
1L1sLEfvAHZ9oB7kZzAN9UTH45p8bQuRk8yKNhMztHh0hq7RwlA=
=v9Tb
-----END PGP SIGNATURE-----

--lgywciro6k7wia4r--
