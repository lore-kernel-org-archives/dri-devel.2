Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A94606B363
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iCyQ6SUF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A97310E075;
	Wed, 11 Nov 2026 22:03:28 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C4410E075;
 Wed, 11 Nov 2026 22:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqTSvOSTTtkem9SNsjcXM7We+KAf031Z/dGhFgIwk0nC/T2tbTIFpLspyUe+IdbmIIqsqoTbItjodIgJnaDmsbvbc+adN7d6nmxq7EkcxAPwGt+X3mNWLtMuH8CXfDx9MoyZYgryfGJY/VLhrL3kkCYXhJRyiKjPFvozffhHzyYFsbZTPTRk6CFbzp6Gju7dU0VaSxVLtsXwgV6s5VqXh2f2h0zejpUkVnClbbutBfKNkmXp7ngSplVLlb5XIgZLy6D89cDpwxpIjhgvPPBhyIqMXSnqx0yWUqUoU4HKphqPMyRw8MFHUDif6o9qXLLbGUlsC//E8ZTwaVpWljJVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f82bqmrwKxJTDgsKXkIzFQpRfJMCIEScQPtvg5WZxpg=;
 b=WURsWQ2hTpYZuv3h75cnB3ZqvpWtxm+xrGKqZm12qJXMcCAYCt+cRSSb/jypx8uWqs0W/CfrPBhK6bRA27K757lQDZZ0SkFTN6byYe4vxjaIyTTp4Nu5YKuBvNIOVuACkI4JgOANRjUFG8qriDSnekFdjOlUkLuXjzD3UPjz/MNfrgRYZscDURBLeiTEDhOt4zI65+CBMO0Q2aRkDMlchy8nEG1nCQUaawRmqt0IAczPB3sTagH4OZUbbGVs2k2idseD2+hHyEjv054HtVQ1K9OMu0QrbayvkjXr2Eu+XgvoT1MFku0ijPYHhCcD6XHC/OX5I/4Zt0EXd62cB3BInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f82bqmrwKxJTDgsKXkIzFQpRfJMCIEScQPtvg5WZxpg=;
 b=iCyQ6SUFIzfnnHW/WH3R7+bZQyTvxPzSG3k47P2yP0ZP/oRiyJmX6R6fOemwu68cKwvJQBX43hssXyYcV5rGpRb4ohCaRaU96UsGJtupjDQhqbvoZozbw/SHvn+VLwdJJNcA8VqO5v8tEBygFSfU+MwoiHW8tETN8/6bSkq9Cd0=
Received: from PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 22:03:18 +0000
Received: from PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069]) by PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069%4]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 22:03:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus
 Schneider-Pargmann <msp@baylibre.com>
Subject: RE: [PATCH] drm/radeon: Consistently define pci_device_ids using
 named initializers
Thread-Topic: [PATCH] drm/radeon: Consistently define pci_device_ids using
 named initializers
Thread-Index: AQHc2IxWpVxx0R+kRUWqwOTZy2NRjbY4QxQAgPGDNgCAANk2QA==
Date: Wed, 11 Nov 2026 22:03:15 +0000
Message-ID: <PH7PR12MB6812BDEF5AC6C182D0559C8AF7712@PH7PR12MB6812.namprd12.prod.outlook.com>
References: <20260430102958.136859-2-u.kleine-koenig@baylibre.com>
 <aimXCmtgcejwInNg@monoceros> <avQvaiaEyWDUQsZz@monoceros>
In-Reply-To: <avQvaiaEyWDUQsZz@monoceros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-11T22:02:20.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6812:EE_|MN0PR12MB5905:EE_
x-ms-office365-filtering-correlation-id: 3b2b129a-bd15-40b2-2e31-08df403f963b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|261028144727099003|261026121527099003|261026140227099003|261021135927099003|261102123227099003|261021121427099003|261022075727099003|261022105027099003|38070700021|260925022911599003|56012099006|4143699003|5023799004|11063799006|260925021311599003|22082099003|260925021911599003|18002099003;
x-microsoft-antispam-message-info: Pi8bfylI+RH5Oxu8sOlZ48kus50OfsTbuWijjkNbfSiQol06KdOaODIIK8ZZ+ATg9SeuyTg7zXCdb84SJ6/1TYD7mPU4lTujDyzYcg3jWe5sYbNPBrpCptEAhbdrJ0YGepUhhgdwQLjuKX31WNZ2LaJ6N9ITqABXW99tuEvRf/4M7uGQ/glXN0ZEwkjmgKSPJeES+73YvMmNsFIjuMaFkSrZo/t/P5iA4iVYHYNVj4/8yt9daPJmCNa8wfm9bU96fcBZtUc301SvU6NNs7+YoItGM41w6KrL4SB8I+76QTaGPp/k1Ole0q9m03+66uJfeHYKMkB6s5j0N51Ag4lOJJl82YFHnva4YtAQkw1vXQqQjBliUMeNSFidfzN9FsVNi2pgVmyhhpcJjbBHcshjSZ5v2dV7iyHliuaCX2q0h1uOLVPEZYFYn3QAVVpNTBkHU2bbMXxtmnUB3dYMEd+zVXt4blV4srd0xYX3/wlG0lNuQ004eqA9sk+R1sfwxiMlgbz4qa0qH3lYuFVhDJtPJlmxMTQGI9PO4qtanTUOReLg452sGKSfki/WpdqvTecAEnGoy1KDG/1wvBEXXYO4kpklOJpkHVrQEj41E58doAFhBYMGVfvG7KAYjCWJwdv5Xm2Egsxk+3wsXwAnCFmgeWf5TOjx/roNSoTwk1nvvTKmyn3YaNabXhbmbC+yatMG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021135927099003)(261102123227099003)(261021121427099003)(261022075727099003)(261022105027099003)(38070700021)(260925022911599003)(56012099006)(4143699003)(5023799004)(11063799006)(260925021311599003)(22082099003)(260925021911599003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z8Hyr5d3INrf4Ok3vHsDkmlESpGLCSnMy0yV70bJiTHMw6+i7mtEBacH84?=
 =?iso-8859-1?Q?jMv3AqIwrR4N9eWTtmfU8acOvvBLwmNKbzzbmbg1SMrjiESecEFQPs+b+g?=
 =?iso-8859-1?Q?Bc9GuJwAacH/dblm62PpH7xmxlVCbFW+RA4iwSwoZn8hI76sMRybbumJ/e?=
 =?iso-8859-1?Q?v2Cuy0BczPkZx8sMrhCOn3VB7vtW8XzV1VFDN+O1VqJvyKGJbaCJSwoAdx?=
 =?iso-8859-1?Q?dmDLuzWm9CtJ+RDUyugTnjDCd6ZKB/MK7i0hqPk2+nF4kqMGcwCLwCTRrn?=
 =?iso-8859-1?Q?REP7FFLhrQ+Je9yBD7zHVrDnLYzAMUvsrkZWdINOovwc3D92ffUcYJjdTE?=
 =?iso-8859-1?Q?MiaBPnmKbq+yNfTXoFdJRpyEn5UkMcUzsH/hRhVTKomo0NbIKXUne+p5vF?=
 =?iso-8859-1?Q?DilaUvqAYzCqMDPIeqc2u9V1CML8n2S5B5gVnTJ2KUP4n3xgsV8GzrQDvo?=
 =?iso-8859-1?Q?F8TDL410jZ9VZQ/0W7bu9pItX6aRtQjvnrkdDrC/4oGUOz35X0zQNbhsiN?=
 =?iso-8859-1?Q?4MNIMytWvHMDG7HeAB9b4nbK3W/2uI2W2gkoC+4pwkHt3v3O1taZ0s+MPf?=
 =?iso-8859-1?Q?74WGvKVKhU1jDWU0m4xw/zaVRlWxQ+oCCnHSsT65dx7NHTfisqrIl1dH6v?=
 =?iso-8859-1?Q?P5GFAXqguQnwpMFufQ1r3K4vkMnmuRFnfiE1KWw9eGvS78kVDn9U3425Qb?=
 =?iso-8859-1?Q?dnKHb9E8OITzAzpCwv+M+Zn3theOOZlEaoHx1LdDF2nzKbXj2TUf2OhT2R?=
 =?iso-8859-1?Q?kKwDrOke9Mj70un2GParyiruVbaREwn6iyx3tlmaNJmHDjW3s36VFIr17w?=
 =?iso-8859-1?Q?zMTWlIZF2wzmq5blYoq6l+W/nUWGnXPwkh4dIqIOf6Yii+H2dDrbLM1DvE?=
 =?iso-8859-1?Q?X9zEu79aTfpyGyB8M7IYPqD3vIvXsGl3uihWOaZ2x5Qn24wiDuo0N5e0Xr?=
 =?iso-8859-1?Q?UznFcV15qylEi699pjn/vgwbKeAXZ9/TnX/EskhO1BF0+4fXMqFyvvcM2T?=
 =?iso-8859-1?Q?XcCI3NeLLSgGdp7gsaK74+oMBGUkrDTBi7pUygsl03Gup9ylu5F5ZJQm1m?=
 =?iso-8859-1?Q?AHrP9ppZhIjwGSqOuZMOCCut7ZPFpCR9JSBDh+CM1iTN05DnuwxzconfxC?=
 =?iso-8859-1?Q?afsiPLWiFruZGjKAU5usudLFAzL5IXz5ZPXwFkzPJDwy2+o9a2DoqrmFyU?=
 =?iso-8859-1?Q?PjO1lhY7WLO92eqjOAAx03axOrbFm97o1P5UYhrnohSUpJ8TO0TKpUXRc3?=
 =?iso-8859-1?Q?7UPt5GMo3hIH1H/hjNpzdypIq+PMkbczjFkvDz1TEc0bqtXtxEORmWMvJK?=
 =?iso-8859-1?Q?7Obr1G6ZwYG4WGXiwm+mplBs1NNl0cVd1yPTHt66E5kWKkxB56IIajLPE/?=
 =?iso-8859-1?Q?LqUaQssktir3s0h4ZbMWkyaGv+D6Cynd40D/+ojXKurouRoXUkfW87FCbw?=
 =?iso-8859-1?Q?TRm5Xy0TTrIHnSlnsUy1EGo2lTvvQ7M0y7KOx/Sicnq5MHVBDdJG2yOR1h?=
 =?iso-8859-1?Q?I3M6/7n9EHUD3apZQUUPiRs8R5eZr3JPV0cpF6RmBQcMRP1j4Bgmd/KRnz?=
 =?iso-8859-1?Q?xPRVu3PPfelTICB+8lAQ1w3sDk+gk6KM5gPR1P2AQ2A/9x8ZwKTWIDi/wJ?=
 =?iso-8859-1?Q?lR1UbF6irEIu6ELS0DqS6yUvMaJBMuYJQdxQYBP9r69uRqZLzDZkYCNCuw?=
 =?iso-8859-1?Q?ReN8T+BfNN2d2irC6hR+SrDUceJnRLiilAGK5zx7WYp5m71xBl4IK2Z+TN?=
 =?iso-8859-1?Q?aaMP0w7GSwKRM46pzgjqu4SOT+37DN75kqHsDrxgEbTM8N?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2b129a-bd15-40b2-2e31-08df403f963b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 22:03:15.7209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWiYN6c7HkAg3Qihd28i5iz3XGZpLK/zDXRqQERUvkQkgAnjVsCDmjs3ahhaLgJqtop46UVXHez2u2ynYbxlgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

> -----Original Message-----
> From: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com>
> Sent: Wednesday, November 11, 2026 4:05 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux=
-
> kernel@vger.kernel.org; Markus Schneider-Pargmann <msp@baylibre.com>
> Subject: Re: [PATCH] drm/radeon: Consistently define pci_device_ids using
> named initializers
>
> On Wed, Jun 10, 2026 at 06:56:35PM +0200, Uwe Kleine-K=F6nig (The Capable
> Hub) wrote:
> > Hello,
> >
> > On Thu, Apr 30, 2026 at 12:29:57PM +0200, Uwe Kleine-K=F6nig (The Capab=
le
> Hub) wrote:
> > > ... and PCI device helpers.
> > >
> > > The struct pci_device_id array of supported device was initialized
> > > by list expressions. This isn't easily readable if you're not into PC=
I.
> > >
> > > Use PCI_DEVICE* helper macros and named initializers which is more
> > > explicit and thus easier to parse. Also skip explicit assignments of
> > > 0 (which the compiler then takes care of).
> > >
> > > The secret plan is to make struct pci_device_id::driver_data an
> > > anonymous union (similar to
> > > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@bay
> > > libre.com/) and that requires named initializers. But it's also a
> > > nice cleanup on its own.
> > >
> > > This change doesn't introduce changes to the compiled pci_device_id
> > > array. Tested on x86 and arm64.
> > >
> > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub)
> > > <u.kleine-koenig@baylibre.com>
> >
> > Similar to the amdgpu driver patch I just pinged, this patch would
> > also be great if it made it in for 7.2-rc1. Please?
>
> That didn't work and it failed to go into 7.4-rc1 either :-\ It still app=
lies to next-
> 20261110, is it still on your radar?

Can you resend the patches?  They fell off my radar.  Sorry about that.

Alex

