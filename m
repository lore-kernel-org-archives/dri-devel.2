Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6686C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DD310F553;
	Thu, 13 Aug 2026 21:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzgNi8l7";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5E210F553;
 Thu, 13 Aug 2026 21:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxhtAsT2H2BNXMfGGD9nI7VNitt3ZFKmC+avTKq/lKSlfXnTddU9J7JTbwu3b+AsLpIbwj+2MyUnCn00n1uTuBLJ5fdX2D7aqO2EDL/khyOJl1T5p6HokrEuiTk46Qsp4761nitCQfr8Hfh4+6lu4L0uMCie874jOVf7/a7YNjfRiLVD2AlQRF1cAETzX+oBE5piBzwIjkOOsVsa3vmDG8uwJCGOrnogjpBPDofNJjrO6ldwIXB2MliM1yucE5yp7t50L+eG3ldiTRY+RpKrUfYghxxs3WLUxZ7+eC5on0kOtiaYZs3TVE7I3O0Ey7TAg0UKbeK+N5g51mWF1fvBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGcG2EDpO1azw5SST5Wy2/SHuYq/tRqSYjeoODFmVII=;
 b=atzy9mGJ8JSQHM3o95TO1w2XXsecx43nFMpXpGpMgYoAYMtUuneICNftBB+YthnWtdqJ2GFYtvfJs28ODVVGkPmoE7yhENDdrky7uF8VeJDliWEJti3UxoDi05BFQtYJhzFrYqkjdPGmZHoHXldsPJLbMI6axeye+ZBb2oLUFnJFb5tgATUYEKNXAyZDwLarcLwSN6hMlpnRsAGwpAg5OuudHniNtOms9FR6+7hmy6FiBH2Vi3Uqn3D1BclBM/CSfNvdrL6nJzaS9XL8ze37etomAbKqz+5B2m7LC7E17wNboDeZcLbnbX4fOWbwhZpFST2iZsSJ9Sjgimv/Y71mOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGcG2EDpO1azw5SST5Wy2/SHuYq/tRqSYjeoODFmVII=;
 b=nzgNi8l7SJQHB0jWRKsMt7SyJwBp3xSES9MmTTN2i8/Ud7d7aP0SO0MV7SmyvGX8iO9941S1A7wf+fPV0btjZ+nBtdCQKXYtezsFJ1zP055N/7P5eeRjHSUbRyoMrU0RtDECWF0h4lGKUr2T3dwYY8kYR3IWvbk8aKsotYtLyCmrXuQWi6n+p6rbAqcqiAQUr5l2ZunwPDVAV/j/c4P8D7oXdmWYfS3lyOYmj4ItvcO7ncNNE4cMIzfcdCtyZjijwKyL14rV3mDYdZWMPVV8ZnWA0p/tbXw4BJiD7Jg38MoRYPLXVRO/lmMhqCA4k1EdQrfYsr6MDcrlduACCj8Ylg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 21:44:33 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 21:44:33 +0000
Date: Thu, 13 Aug 2026 17:44:30 -0400
From: Yury Norov <ynorov@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>,
 Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Message-ID: <an46vhEkOb35-oXE@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
 <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
 <an4NvQBt3389jP6E@yury> <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
 <DKO48OG9DU2S.16YBDI113DR4@garyguo.net>
 <c2cf35f6-7dfa-4186-acef-deab9a6f1b3c@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2cf35f6-7dfa-4186-acef-deab9a6f1b3c@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4b6607-59d5-4e07-039d-08def9840f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xsiH1Ektt4B8iQ6S61jqflzClmYON3efQCZqiyCgZj81tR78zGZpkAu9s73A1dh5hjpsXjrAPDMMTI112sPZm2tIUMW0hZgPUIIlP/ywx2sD2Ykd4nsrg45S9IZtM+c6pAGe1+slnNZxOt0tb15S8ijuYw4IFcH4NhzbvZsT8PckmXqtUiMu/M3l2tk+izZ5fQLUmWEeVMaddgDKZl6dmprpH1N/S9WfDXGWnqH38YSBl4mQlSLG+aBEcRQAMPYlokOb9rKogFyTXJ/bNAHES9nfUaxaQ+oBOii6KXCfJsdENi05t0yvcOngfDMiAHv2JeQLRgd/1xTH59DIdE1A9hMdetqTKNyvo8IQFNK+D9EePts2D0Q1J7XzhUQY/NXkuJL4ugd+A7PAfSSvCsCloAP98NYyLQyLvRZhfTDNRlGRdEPqZ8I7feUl/9k1NS9QUSumtQ7M4asFcG0Ec5v60ZqsLq5LS73pPwsC7E+xkuz1EaLvbU6rIoKgSIgA2644jfsXuX8msUegDouonXUclTEu6fXJzWCcYimiraeCiRMMcXGc+JHieJQA0YN4kUaFkyKnWz0W/hfqqf8UN20marKgROY+BVBeNydrLKbCeg3BrN7DX97eDUlCogK+iMe2nMNXaIspRau233CdtJAxiGFLmj3h+e1KG0d0zhtcFNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UeYk0iS//EMoUL6KNXHzzYM0EfZ74ZNdUZ6CrVfr+9R78MGDG+inmXaQ/yHM?=
 =?us-ascii?Q?WRljP4svKsUmmZcsQ62BPfOu4CvidPeT97MyFf+VVoEKqWHvGd6APPM4dFS8?=
 =?us-ascii?Q?ircRsSbv9pjd3rf9p9JMOUmWFLUNUuKYLsM9qmfHDXvmaAOIQANn6zgMYXyp?=
 =?us-ascii?Q?Z6uXPcEYbB813wgjXWlRifnIjcIlxg2mgIWwqT58lp44MOv6CEAAJe4Y3A5L?=
 =?us-ascii?Q?V/vg+sdSX5ddXGC7Go916SpICRxW9GuEc2ytgYqSlIum+buSr7RDL/l4BOTo?=
 =?us-ascii?Q?QcDe81EN3L40XSjjDcRDT3nEfPez5wz0rBdlZpHLptGGPVXEhTT69M3FVEgH?=
 =?us-ascii?Q?QZUQuswm1d9ugAhzu137fN/x4ROYNHDW+5gwSGRH8OkjD1g2/Mielze9ZagE?=
 =?us-ascii?Q?w8ShJzgoTHV/kbXNeZG2PzHG8QFYMURkoCzRVv3n10+MsxSiinEbMS7TVMkv?=
 =?us-ascii?Q?/C74KS6q7k1cBOBD6rEtbZmGZP5DnyjcDZCOYO93MzdlDr+NMj5KmbC2FVCp?=
 =?us-ascii?Q?TpQ8BA6ui1NEDGDGnaXOEGj6Ze1SUgMLjH9SpkOrxLiZJTrN8VGw7WrP0k9C?=
 =?us-ascii?Q?c3Co6DEzfywCxa9A7+LkBDl3r30T8rRLZxlg65kdfjQHODH3ruDJ4/ibLxgC?=
 =?us-ascii?Q?xWAV4RYWm4MGf/sgPDUeluBge3xYrKsSh5XaUvTYyW6cibw2iFl6lNdPoHvn?=
 =?us-ascii?Q?xnShUQucqdyX+yP0T4lPAorrxLoFLyjYvc1rC378bCP0+iYr7aM8YlzocOe2?=
 =?us-ascii?Q?xCZuXQMLZDUPtz4I7W5Sm6yVn1LLhtWkcznp3sqX3LtmsgRX+S+oWT09BjiV?=
 =?us-ascii?Q?kmX8gqP0+nIhtB1AznoOev98yXdJw9nc4RzWdcfvbA3r5xajbGKQSjdLCAZ0?=
 =?us-ascii?Q?qRz7B0/+D/Q1KGwmJa8Rr/SYBcotHmUwtNcZf241wlZ3nMKCUlxT0W5uRp20?=
 =?us-ascii?Q?tjMyZHpILUxuRfF+ZvBZl0LjBH38AsZ5CU5soKP85iNOcTZJ1FJGheIGXqsY?=
 =?us-ascii?Q?nxdk9+IMeRTavPVVnIbEetVxCGWgx2oXyXDd9VUsyY630/0R6x8cMEisb8wv?=
 =?us-ascii?Q?QRFvi3RdJ7CGsWtUfxgH6VPoFvJAf+hM3Jgu0hvzHZ9lued7Wmwmi35Zoy7c?=
 =?us-ascii?Q?X2iwomjNLNGbZv41h9ZZwIHZ+OOhV1EHY1AYJ6zVWLdfDp9kqUkyk/jR1zkD?=
 =?us-ascii?Q?cDJf5axa6S9uQ88ndP6fCqQ+DgEEKnDu7/3Ez+nW3DzWAOA3X/7G1if4DzOQ?=
 =?us-ascii?Q?RLfF0oEKhnjR1p54/1rAAp7OltZw8AMIPRqt7hpgAQg0/skXmKFSmAcssVsz?=
 =?us-ascii?Q?NiXZoWpUZ7un4wGnVLznhRglvm9GkS0VO1AVnkRjaZ5k43u2x4hA063/opz4?=
 =?us-ascii?Q?OsUYpAf8xmzzuhYqVgNZ6Xip8lJwqS6vPdIyqbxQMNnyMqQKeg/Rea2xu4+3?=
 =?us-ascii?Q?k9oPVHmvSlzqbRbJ7/XjYgmESOLR2ua6flSsM5Fz7DzkxcILDvhvrUGKTSMp?=
 =?us-ascii?Q?E3K7kht+klqY86rmpvwlGhbWIy/ZL9tNf0W+/Dm9sZ6EDkYQ6qSyK3rpgpeg?=
 =?us-ascii?Q?1j0DNum/bDEe+djVSSz77q6cXaWJaIQFcJYnWcwOSjLfLKZ293aYqVdiITNy?=
 =?us-ascii?Q?PonS03gewuwuDvVvHNJ9mGOKs3OG+BiGesMS7wdq7lw0L1uyAa3FaEbxZKfz?=
 =?us-ascii?Q?iQ/zzNmfVAl9Efcrp7Yxnfv6SkFqkeLN4B/9NByByd1YHNY6qtT6XqC/rgAt?=
 =?us-ascii?Q?aL8ZpfVv3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4b6607-59d5-4e07-039d-08def9840f8c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 21:44:32.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbMcY+Xl3BM3lDIduizicIU38MnfCc8Z+VQfkrcU4r5YODrpa0prbBEgo0gLzbdSsvc0ucMhSO/Oi5fNFJH0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
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

On Thu, Aug 13, 2026 at 02:38:34PM -0700, John Hubbard wrote:
> On 8/13/26 1:58 PM, Gary Guo wrote:
> > On Thu Aug 13, 2026 at 9:48 PM BST, Danilo Krummrich wrote:
> >> On Thu Aug 13, 2026 at 8:32 PM CEST, Yury Norov wrote:
> ...
> >> The code from Eliot does actually already takes advantage of this. In
> >>
> >> 	pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
> > 
> > I have to say this looks quite ugly, compared to just `.alloc_area(8, 8)`. In
> > this case I'd go with something aesthetically better...
> 
> In addition to aesthetics, a practical concern is that there is a
> higher cognitive load to both reading and writing the longer form,
> above. Perhaps that is just the price one must pay.
> 
> However, for primitive types, I am hearing (even from Miguel) that
> there might be a way to get the static checking *and* an easier
> interface.
> 
> Here's hoping you all can find a way to do that. :)

There's a nice postfix macro proposal:

computation().macro!().method().another_macro!()

https://github.com/rust-lang/rfcs/pull/2442

That would solve the problem. But it doesn't move since 2024. I
recall it was mentioned in the bitfields discussion, but maybe
it's a false memory...
