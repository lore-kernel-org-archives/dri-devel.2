Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9817BC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0503710E105;
	Fri, 14 Aug 2026 09:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="T9ZgWJvr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9B810E105;
 Fri, 14 Aug 2026 09:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMEDxSywsCDCG7cQDKHy7tZmpCYZS1zNlkazjbDT8HmkffG7Sq5KABLaAKLWARQileBz222eaNayoCdb1/nGjecOJBiu+KeF+icK9+BgVr1MvgdjfJUTgOeNcJxx2HRfmeu2r99FuQUlaHdn5PRfcLbTGbWhiiaD5YTkDcZbNz5COZySFjaZzPHcnRddw6Q2S7CqYbTzqh/0rIfRPcC6nRYZzcA+hsLxLg6wr9oZe/qs6uT8ITbW9eugRK6PK7ZvNS5EFhqMhXjFNdhgm5OsHoMvXylOY/Lob1ouIMafJgeIY6n/0we2eT+ELNKlUwqEh4mKC08jeyWmFYwPYQXQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78rdivbBq/6J/v22GCEnWiiJwwnlqr9yTdviRzDgUdg=;
 b=sOFLZse8wcAR8RoB5k2zCePt3MIMwOdWI6wALmBB+ciISTJpZRBZSBKJxlHWtZO+gWyY6v8dMgU+81E5VJq9WBBTTbgY+AF0RPbyF4t8nOwseXvtOB6mpUJMIq9oRZeocTn9vOpTI9Igz+fIAeEblDZu9cZ5XioLiaWjlTWp7sVtCimD7mYWi/GdPHyUqpZNIngHFJ+ajL50vniWkWDgUln5qc5a2uks4WsEVXPN6CXBH5BBolKtJhvjiMJ5MeU95b5KUuvTLdYvK8iqHbuVOPeLSV3kM82r3ERZZEvSJtCLG1vx8ipa4gx8fkRDStxArCAoUESDfyVIzktDbqKqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78rdivbBq/6J/v22GCEnWiiJwwnlqr9yTdviRzDgUdg=;
 b=T9ZgWJvrR4YfDNKs6PrsvH79iBk3yao5/uAqrTFrHc5O0nO5iDLB2i4lBxeSeXEuCf49cCvq+4JvR/rzv9reFQAL2Alz6laUcMxwzvfUfdxVBV5bQp4iCFmr3RzH/g/Y6qE24QcRLeGvTeIkAoFZEkyfA6uCCKfzFkwlK50i2tjozu2Pgz2WRDv4nUz1CGQzEFvADGC4pCpba0EwSe6m9sIiV1dknQk0j7sXFVjhZxbcvR2yBgIT484Hcr9f6+3wDHuT/69OrlzDQ+IevtJkQKKvxllUm/s2P/oJU/u2UcA4ic2PZ90WNlz78yupMC9QhsYNzsMswnREyDE+b+UeYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 14 Aug
 2026 09:08:44 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 09:08:44 +0000
Date: Fri, 14 Aug 2026 05:08:43 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Message-ID: <an7bG2bEd28AbNRr@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
 <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
 <an4NvQBt3389jP6E@yury> <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
 <an4xDp29VX8Am0uR@yury> <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:408:f5::15) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cfb00e-9328-4876-08bf-08def9e3a457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j5mBUa2i0yK5/rqZWBTYUmOxbG5o4OV86nTXEre5r9KlrNBopAMyNr9CZugf0ZCLYtEpyLFFL9A4x8rHH9fuC07jgkp1UI4VmjV7XA7UaCV9iT10QD0cu+Gb54rDLr/fqsulooaf6kpZOKwIjnErXQs7TZwm1mzzPSlzSh8s0Rn27ZO0qLgM/PZttvHVSp19rAy/BGUxz3ndD9DS5+vhrQ3lRYdIhjFONbRr16S2wVgZ4Wnuid4ODu7gdu1cVR1N6fFatkJbs14upuckCl3nFrhnmzaEKptDwsq4SLGkB06DCDXSh18XBDM9OXaW6VIXyf/CDT2X/fcVywdoA4y1YC+ZYXykbB3DPA/EWNb6vM1P8cAk7LiqWA+HspZ66uhBGklRTeHnh52CPMvvTpn/5A+CMfIlo3aV61htP1GvfgW1AXlQ1Bc6YqxGD/SdBcaXHdZBcuNhox9vAjQjhX/0fERaFrRyAHg6QcuJCp6STlAdfHmzHLAhI3B8LhWRJgTY6/YY9SZW08M567rIJkeyFdgoopRyewv2O4KPKpj3lDuutidAvADhVXXUVsmSKbFkm1Ljhgfchkb6Gh2erjBygZFRo+dvBxJuiNii/EJ48/2coVbLD6qWdBhQHK5T/QKZOKDvGjEU0d/Zuow4JlWQ1R1GxQBNLoQ5CziQ2o5OVzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gZfaZ8ykAL16W6TEQACmJmz3QMo8JjaT+2U+yKwwHXfGh2zw5hCLHP+zRyC?=
 =?us-ascii?Q?i7PyuT++oOM3CUT0bVKJ/I3JFf337+f20x1lyG9nBnN01l5piW3hI6tlyCqY?=
 =?us-ascii?Q?/2OmwNMkmNja6kOz3eUS6+X80+Djh5z5UoS/CiaLGXtiCrbyPbuTAoHemH9p?=
 =?us-ascii?Q?sBGv1xI+qOcrsmoRH5r+D+n2vGXURG0ydmvGxJcG5LbNlQIJhAtN3qxTe4CW?=
 =?us-ascii?Q?fFFsoed6rJSJfXKsP0B8OuBn7q7v9omanWDb9Lv3bwCgyuIAbvSiobq+CaaK?=
 =?us-ascii?Q?Beqd2p10UeWU9WACDZun3LzJ0syh+m2of2pKDIG6h4VvZdbl8i11AHtzPgne?=
 =?us-ascii?Q?/G0BnsZmmFkzS8fOauI0E3SnY1SPTH55CEeJ1CeCyfK0ti2dkaoTPu6geg9q?=
 =?us-ascii?Q?dhYi4TFjNgTchol8W0oEosP0QbAjtpgq2Ht8DB0WIUK0MTsVAzzJdMabfdY+?=
 =?us-ascii?Q?7eeXQLP0ieiOh1cuR4dA+0JrHe36+IR9iKmBWXgnXKB06MIdP4RR/FQAms74?=
 =?us-ascii?Q?/7idj5JzRurS1Ao8gogJh9tRZvHv0qTH4hs+r5hB+B+txfLKDBMQfFjpj3GV?=
 =?us-ascii?Q?CWzeutHCaSxIMdJOu7dEzp4AiNGFImOoptQERxlYqCMVrdD8PM2E+KcP36OQ?=
 =?us-ascii?Q?9dDIfA3eRrgcWHTfvKTjtpcZ2f0lAR2iG7bB8teOhCQfiUS68snxT8E6sKrZ?=
 =?us-ascii?Q?LBGfbjRsip+mZ/xW3RMrm18oSopVjuWNmkBw4QzN6w3ILWZ69V8ISZy7fUZ0?=
 =?us-ascii?Q?CnWy6Z4IxSkYirlbudWQ/SFQhh169KDF6KLhDHioQXDki/CnWz+tqQcNPmWI?=
 =?us-ascii?Q?f8q19pEAyRFeDRqiLYeelu9h24QIiF/9x52h23CQahFABOTUQZQpsCbfFagt?=
 =?us-ascii?Q?O030Aoooj6hFX8ZiinNimgsOtT/Rb8+VN9luqwMknkfGydBmcqgvGxgIdsAv?=
 =?us-ascii?Q?feTuTRyVbjBQBSxKzg0imSo5AdHkfXi3J/LvlbWxttWcmENKOwf3vi1r6egg?=
 =?us-ascii?Q?aAgJCptjn47uR5NmOf3H4RyoM+AyG6UDqpTgboACAEqkhPjHOxBoI9V6mOhF?=
 =?us-ascii?Q?rQpycQFTu7SzGgYPwJToTIJ3DYhLG0+5QytJGx97U5vTzbN9X9JRDOTESyfP?=
 =?us-ascii?Q?/yj9+EmZZKBwsi/0L3WLs+wkhVc6AwKpK6jmJ30h7hpM4zWhiYpKRBKPZ1iK?=
 =?us-ascii?Q?6Od3NzWdxumNxyM6uzth0I5cDyyifQL/Bx5pGKXhnR1kxcFpchau1AOky7XR?=
 =?us-ascii?Q?pj8zPqq9kH69El5Fy3/vDO0Vl/JSqCRMRUm5+sn2t8UUvPw72RzrRH6FtX9f?=
 =?us-ascii?Q?x4dMeIvpQhSpyx56rZFM7EqztnlPlmjB4dBjH5eMGIkRev170scLKNos+V52?=
 =?us-ascii?Q?NPY9l8jIoeWN2tiV7+voNTaNI/GvpimDIrK9eMVb5JN6A8CCP+NPeFp+hzDl?=
 =?us-ascii?Q?5BpYlvPPZyV3lJccIe+rqmUuq9UJd2ks1hxDS7oz6v7KSxUl78/eIGEWVXG2?=
 =?us-ascii?Q?o4hEvoJbeyBwDmppXrloWhItgfriAoOb2qwlboLn0+AwtabcMV8TI+chMHp0?=
 =?us-ascii?Q?zSSfxjqRAXS8pxpbVkuOV62UNO76KsLirr0MvhPMMv0AP35vnu9gpvFO8d3u?=
 =?us-ascii?Q?YDm+U35nBHRal737RLHmK0QUazKrIfhUAB1Loysm0q4MdtPbq+oqaPH+mRbv?=
 =?us-ascii?Q?Gh8xpkB68qWYjq8lPQZ0oesV1rO25Nxy0qvLii1nM/jSpKHsUY9La93urauN?=
 =?us-ascii?Q?uoKVwNLVpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cfb00e-9328-4876-08bf-08def9e3a457
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:08:44.5119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN6y3n7Abt4kffpqRTO7Ha9uhex0OyNZYFc5rCAoSpzSRBkOCEwkM92TilAC7+pO4x4tuiaCCPb1BJln2ylyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

On Fri, Aug 14, 2026 at 01:54:24PM +0900, Eliot Courtney wrote:
> > 1. Provide a nz! macro to create constant non-zero things. Provide some
> >    constants for common alignments
> >
> > Potentially, we could use build_assert! for cases it is provably
> > non-zero but not a literal (although tbh not sure this is a good idea -
> > at least not do this initially). 
> >
> > So either: nz!: const { NonZero::new(value).unwrap() }, or, nz!: some
> > build assert gated construction of NonZero. A general nz! macro could
> > also help ergonomics for other use cases too.
> >
> > That looks like this:
> >
> > pool.alloc_area(nz!(8), Alignment::AL_8)?;
> 
> Actually found that if we implement SizeConstants for Alignment then we
> can get Alignment::SZ_4K etc almost for free.

Then maybe pass SZ_4K directly, and allow the alloc_area() to
calculate the alignment:

        pool.alloc_area(nz!(8), SZ_4K)?;
