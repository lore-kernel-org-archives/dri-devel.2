Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE54108B8FF
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 06:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7491610E26B;
	Sat, 21 Mar 2026 06:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fr3v1XDr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE6510E26B
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 06:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD/T1QAghfHXZYVzM8pyLURUQPLCbl40/egL8pYcR7lFMrEJOB7xTfoVD20U9JJR+s4YDOM2JMO9LyjTpLyfYzJNIbWjaCHyngaBcT17wQoMietdp9T8pebRgQ6Jh/sgUy4bk1J2/ngQWl+3HCWaZRqZ/3m0VgZsxitXSJuTDz+fOwtU1ZX5DJKb19EZNX+ub0EgTmVxmKWBglD1zjdUPVNNkYHHZ0Z7NpxTVq+etG6NPRaexfnKYFNTMxjiXYhLADPvUBgqPAJ02RqVURrsLw9VJt4lbhONeK41SylJo2EkOkLk9Uvk5qYtcjMk162DcSpPvsUAvoT2R4oJ9cE/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biBpGwDKOW4ytyal6oCmp6AkfQTGbEvOH7NE13zb7Gw=;
 b=rgMzlW7MRiVnVod+HXMmqWW3HSebAyyWHT/lfaHb9xofNJcMImUs6NOEZjHuRYluscG46qr9NApk/GZl+bVy08zJ0om5+GdwY7JPpXobmzk+feSaQ0+CSSp84ovPiuaDzIZXVWz9Q+B2d3BrUDfAzjt0H4rDz8aHJpm1ZbudiUbgZNITre8UkaGVAhQcgSvhFRTzZWpVTokN5PZ2Vaj453RGTakCWZyhoRh5cl9eS7mOjc2SF8VhHFP81V8N/j0smtS0qw6zi+wlNd+lmC4mNIM7YopKZBn/A3YMeCDn36IoNgd+4d1bJwCjlNRUMGdEpqgpUgr1peenNnY1qFykAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biBpGwDKOW4ytyal6oCmp6AkfQTGbEvOH7NE13zb7Gw=;
 b=fr3v1XDrATOe40Bmla8iOD4YIMzNttuc1AhP9NlRiGDi1AdOwvkyJHw7hlRGDPpRhi6PmmkfhVNygQSIZtDqD9vs1nTzQvgIrBk1xvteaoiRyZsOfMd9XAG1uHGNi1GqPCXosD3xmZrVquB7FCGqcjIWHrvoafVo2xCnZq25pspXtnL7+J+1ZfyJfx0K7nrl7rduRaaVRcW/h5NBjXBJfxL5bmo7rL87CbricIxfr5jj+Ekg2taKmX5Zhqs8KwV3b30LOA10U8ltwZ2tSnWDauJHIhf6tFn4g6fzr5SKfmZnyyVtstd13W66EBXl8JlEtQtZLZ45dawEEynaBi2VTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Sat, 21 Mar
 2026 06:16:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Sat, 21 Mar 2026
 06:16:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 15:16:39 +0900
Message-Id: <DH88OC6WDBN1.3SDSH032GLXXP@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] gpu: nova-core: convert falcon registers to
 kernel register macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
 <20260320-b4-nova-register-v2-8-88fcf103e8d4@nvidia.com>
 <8f9da1e2-fb86-4653-b702-333fc920af58@nvidia.com>
 <ba3c5689-5e34-4097-8823-c37a48a4f358@nvidia.com>
In-Reply-To: <ba3c5689-5e34-4097-8823-c37a48a4f358@nvidia.com>
X-ClientProxiedBy: TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 028c2658-9e37-4144-cd43-08de87116c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RJTyzkO3x1WREFmjHMonLDokTZbtdrKZntOUxRdhoRtA01itBDAvecWK2TB97spPXyzL1nH0oJi96MvkRXopzMTdHns5f1IfAcaJOIFsVGBk2Q8FpM+vHWQRvWEFGIo85vESg3ZkW8d1OSjSVP8F9tJgeK9TvNLVTlrKWexBcHE3lniSwToDMJmZjtBX0IYEqxXw27xKhTaMwhVZxtybnEEuzClj1JQ41Bf6vLnlNHQjt9SG5rz4ADgaRaEu4Okh7/jyobmdByeiwBzW14yTvIMwOKIPoYw0Hdw2Ds6QDKlIUzI3K4e0fpxmAV6R9FsOVLqVFSz8Yg3+9FcYTJmNPft+OTyNj+saUCoX+okeWixhuUt7qoKKBRVdFcE0+Lr1rmw2rd0+rNkpYsc7cl8AIDyBy7sykqrUloJb/fBqM+/C7YxTqX9TFNzU/oqvp2urSY5T/ZdltXbWvXjIbZHml6Rca206JjQF/lL31McDlvMzyImcA9quAWzZSHdiDdm5ktBQ9sfFohgM2mYIIRYW35W2bezLoaepkHz08g89vdP0D2Wk0KC4ZZABodIdGDXNVUHhd0P3dZnPb+qFkPNqUoA789ADdbiTXxqhqV2LsmXYFk8tniy1xr5O4fs/EKC+4+df5620xRokbR6SdboaO/nTemG7aEeyLVxPbTAlnV53p2nIogp5rIWLdrWHBcL5qip6sx97h6XDb5ib3UgZ58B5+KLfWgj4SZdK5E+uUws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnArMDhnekN6alhmQmZ2VFVqc0FHcGYzSkd5Mm82U2ZSekxGUmJHem9qMUlM?=
 =?utf-8?B?OUxZYzRuLzBmd1czSU1xZVFBUmxwQXdaTHJCMnZTY1hSOVdKcHRQUkhOaHJE?=
 =?utf-8?B?Q290aE5oUFNIMlRRMlBabGxRd2c5WmJERDFKTjdJVWhVcjNST3Y2RVBCUE9Z?=
 =?utf-8?B?WFpEckx0b3RhWWtHWm55dHBQQnVNR1h3djVYMEQzRTdBT2MwY1N1K05zL0s0?=
 =?utf-8?B?NCtxSUNKRnJsWmxWSVpaLzVlSlB6Nk5nSUNwNUxaam15bTNzYXpPQzkyVlJI?=
 =?utf-8?B?ektjdmFsMjRvRHU1WHU4V1JVTmcrL3NrSUFCa1VoakpkYWRHL3BvTDhLZS9a?=
 =?utf-8?B?ZG5qZjcxTEUyalk4Q0hrdTkxSjFqQXlzM0NQamFZWHIxR1lBYm45VmhDei9T?=
 =?utf-8?B?cmFTTlp5aE9TUHQ0UmhZRElsZGdVZVozYmYrK0h5M0ZUOU9KWjBtcjdTKzB2?=
 =?utf-8?B?ZkJvY0xvWElMMTFQRmprSitZdzZ1aVE3bWhkSUVJdXRWUEU4djNWa25oT2ZL?=
 =?utf-8?B?VU15TVZWUlBBU0d4dVNQbnIvWU9XS0FTWlBmeU9yVXRuaTdoUWFneS9SeUVy?=
 =?utf-8?B?OExlZ1hOVkNrK3JvOTdKU015bVA0NjZFTm1hTll1WEwrWm5kelNUYVdqUzV2?=
 =?utf-8?B?OTUwUHhwck1YaDVJZS93ZHp2RlVGd0JBNXFwRW85YTVMck9XVXZKWkJteEgv?=
 =?utf-8?B?VmlXd3dWa1QzNWVKa25kTlNFeHdpTTBkVWplYlN5cEkxSCtJeTYxdEdHZ2Ri?=
 =?utf-8?B?b1NlaU42VTJLeTdjOUY4L1hxL1JzbXpqODhjMitNeENPb0hiSkZsL0IxRWpl?=
 =?utf-8?B?ZGE1QnpXLzVLNUc5aENyYmphSS9qZ2JUeDJDR0t6THFadXhPN0tQMldHaXhs?=
 =?utf-8?B?NWphbHVocHJtWG81NzJ3eCswY0ttUUxmS1hlMXpGK2hBUFRGczdTUkdvRHcx?=
 =?utf-8?B?OE5IVlMyRWVZc2cxNFpPZmxJaFpMRjNSaUNRU2tZeWZkckhQZ0tzTjh4b281?=
 =?utf-8?B?aHM3U01DQXpSZUdXNUt2TUtrNWo3d1BOcmIzSHByR2JZSW9ERmpBdmJkRnIy?=
 =?utf-8?B?Y1loYmp5VHpkbktFa2RMZDlWSVJGMGdzQkwrWStURFRPWEh3ZVlweUNoSUEr?=
 =?utf-8?B?QkcwUDZGRzAvZkVyS01YWk9XN0R5QjhaWGkyOUdXR1ZVdUdrUDF0eUJzelpD?=
 =?utf-8?B?dk5BQktnb0twdXNOY3kxUEd2RUZHUCtybm9TOFVKR0xhbWtxc1dyQm5xUDVP?=
 =?utf-8?B?dXZ6SDFZSXNUejJvaXpYMlFFUTFCWmNhVjF5VFhwNXdSMXZka3VuQ3pIT085?=
 =?utf-8?B?UjZnWE1MUSsxVElSRFFjWkViNVZUd0FCVWlYWjBiaVRncWNRMjdJRU1LcUxJ?=
 =?utf-8?B?ekxJejE5cUE0eWNveHo2Q2g1TTI2dXB1U1AzeThQTUlNUStvclpZdmZVL2Rt?=
 =?utf-8?B?bThsRzltakk1dXRlWUFkZHhlMWVSR3FSZ04ySFBmNVdzSnE3b1VrUFJ1OEJ4?=
 =?utf-8?B?ekovT1ZhZjlrZjBvMFdienowWEZwUmIveGxtR3Z0U3JySjhxUnFiOXhma0Jw?=
 =?utf-8?B?L1ROY3ZtSEhUS2lBVytvUjBHYWlxSW9pUFE3UnJkcThqdGdOSFpFV01WZk5W?=
 =?utf-8?B?cDdudnFnYU8rWEJQaGZUZFUxcnRZOGlSS0d0bVB6Zlkza2NXK1hrK2l1WlRL?=
 =?utf-8?B?eUFGVjB1cENGandaNDRrSVhid1NRc0Q2SHl6OFNaQjEyK3BTRDFaTUE1bW9Z?=
 =?utf-8?B?RjRHT1ZSTDNOb0o1ek1sbnJRZTMxRDNqTjNBSHZ1aXF2cXRQdnRJcHdwRFlU?=
 =?utf-8?B?czRhMkpVRHB5M2pLU2t3eGwyUWp6TnhqZXNEd2dId1ArRkRLblEyd3NweG9w?=
 =?utf-8?B?b3BzYnphQ1VpeHNYcEh3RGZqOEl1QzFBa1lIeEZienZjREI0aGZXaDQ5czFE?=
 =?utf-8?B?T3EzdHl2MzMyRU5HT1ZHaWQ2SGpYK2N5c1M0R2NwNnI4MlFjL2JycmFxTUNX?=
 =?utf-8?B?QkRFakJsd2daU0tmQkVQM0l0SGpUSlhpTkRZNTY3NmtUVzlkYzBsVDhvcXFU?=
 =?utf-8?B?dW1MbjFqdXlwRkcyQkFGbXVoMnpLSkpTOXhVSEdJYVBkY0hBWWo4cmhmTzVF?=
 =?utf-8?B?dEVyV1RZTnhCV3pOVDRlODdoeUxnVnhqNWdtTytLSUpWWURMYWltL0lLZFl6?=
 =?utf-8?B?c1VkM2svMFF4TDNIMUJvYjY2T2l5YzBDNDBTdTdZL2dvOTd2OThuWEdZWkEw?=
 =?utf-8?B?VDZsNTRkbW9ZYjA3U3pvcHc2ZE85dk5YbHN0MTF5dzdWNDNFYW5WOTZkdVdi?=
 =?utf-8?B?VGhVSDZVcHJyZzlEdEdDY1BBQjExa2lBUmpFTXkxOXRvb0NUdjN4M3E3SkNE?=
 =?utf-8?Q?1z7TMuXEk1jyyTKLLXkArq1dEj7Zmqj2t0DbVVJAnNhc/?=
X-MS-Exchange-AntiSpam-MessageData-1: KcshnkiCse+3rg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028c2658-9e37-4144-cd43-08de87116c24
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 06:16:43.4477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwDxveRTebFUdcKn4f2PQvAKzHUlOSodioOOh22s2xz71D6YFaWQeID2bDX3byknNdU6qJAbPtA9rZTFIklKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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

On Sat Mar 21, 2026 at 4:52 AM JST, John Hubbard wrote:
> On 3/20/26 10:38 AM, Joel Fernandes wrote:
>> Hi Alex,
>>=20
>> On 3/20/2026 8:19 AM, Alexandre Courbot wrote:
>>>      /// Reset the controller, select the falcon core, and wait for mem=
ory scrubbing to complete.
>>> @@ -616,9 +462,10 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
>>>          self.hal.select_core(self, bar)?;
>>>          self.hal.reset_wait_mem_scrubbing(bar)?;
>>> =20
>>> -        regs::NV_PFALCON_FALCON_RM::default()
>>> -            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
>>> -            .write(bar, &E::ID);
>>> +        bar.write(
>>> +            WithBase::of::<E>(),
>>> +            regs::NV_PFALCON_FALCON_RM::from(bar.read(regs::NV_PMC_BOO=
T_0).into_raw()),
>>> +        );
>>> =20
>>=20
>> Overall, I think the series is good improvement but I still feel this pa=
rt is a
>> step back in readability, and we should come up with something better. I=
 don't
>> think there's any chance anyone can memorize this syntax.
>
> I must reluctantly (because I know this conversation has gone very
> long, across so many versions) agree. That .write() statement is just
> brutal, and we will be relying on AI in order to even figure it out,
> I fear.
>
> I'd hoped that there were other, simpler forms to express this,
> is that not the case here?

Is the problem only about this particular `write()` statement? If so
there are other ways to write it, which we definitely should do if we
consider the nasty thing it is doing: read PMC_BOOT_0, extract its raw
value, forcibly store it into PFALCON_FALCON_RM, and write that value
back into the instance belonging to engine `E`.

It's quite a mouthful. Using a temporary value would help. Maybe we can
also implement a `From<NV_PMC_BOOT_0> on  `PFALCON_FALCON_RM`, as it is
clearly used with that intent here.

Future features like projections the macro to initialize bitfields (once
they are extracted) should also improve readability. Meanwhile, it is of
course fine to use variables to smoothen complex statements a bit,
although I'd say this is beyond the scope of this series which tries to
translate the code 1:1.

