Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06ADC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2006D10E211;
	Wed, 26 Aug 2026 14:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uAsbP5R9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60CA10E211;
 Wed, 26 Aug 2026 14:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hayDoKlR8dZtYvyuhFu1KZtZ3g3GjtVSIL/DwdNe5UZiuofK9zn4LfBmmJBZLlBeqrqRcJUvxisSHElqTVI2WfJm+jeCpIL33qMq38r4oNZMgP6uIM3tcH3/R1AZdZjJs5IJnG1xdOi86O703KsNkt1vEjWWJ2LYxai5gs4E2z8w4ujlvyDmgEPYEPyPJ5h7HpuOfgIn3jgeAqhMmfYi1xu9UNGLBCTFxXbQoxnTfJ53pcDaBMdG9mU9AbhkSbdTpeexQf90HJa/ZiqFJFiQGNOtwV1sZEVzWcgLQZI4sFSeFO0Xn1TLbc8rCYcVJmh61po7cvvzi+tHB85BpBebcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BGHKeQaYhzC60YfeY2GH1PqRioZ0ezKfz3uzc5RFC4=;
 b=J2FyXmHeNGuvn1qG2fLOgHKgCk/W/CnD0cws15zR6IQQY6iGqxn/Lw4rC4sV5SLdqySMnNZoN0cmM3eB7oqCDSzCVor/RAODj3mwOSzXJ9HoElFPdyL8rc545g5tQ37cPhQmGWLBXaAmx6MFKzmqq+LPYmNSxgrdESu+ySAVemDhqI0VSzoP3Ezqhh+xwBdWot6tFHs9XaU5btv4OKmIGyV675EC817y2WJEPEe6B7mDQqnHgVbELHSyBvq75in1SWHnxKj1HPvaIReQs9XmjZ77hWlJfAkpehXqIokGZsx1AoprdMhSpxLNAQv/kxBA5IWjBR0V9GWnGjpx8LvrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BGHKeQaYhzC60YfeY2GH1PqRioZ0ezKfz3uzc5RFC4=;
 b=uAsbP5R9emUsj2OAMHBEni+xd1YNPJFQYlnnkFEwJmWGyYCdHdeoqYmV06+ugUsQgCOFSmMRaiisQGmbZ2f2TA2IhKz5y7CLYsouTr97moCJXqf83aca3LQO7Pm1nYjpiXTUJFAozfC7fK6zrALb8OFfFS6F3PK7bfofqlsWPl+Yt5IaQJRhuMQDmm8Di1RAPgWIUbstSYS++hMQLuN8DwQ5Se11mLnLJ7dO/4p4/kSB59DmOo0M4YHbISJ0OtgtFHDz2S3EiIuicFqgCoa6ShCxFm19yzBy3NotD3xhDsapVu8AQm+KPjPO7Bl/f/8putatCs81EwzfVUN5TxBs+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.7; Wed, 26 Aug 2026 14:15:33 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 14:15:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 23:15:29 +0900
Message-Id: <DKYXT1CZB5UU.3EUO3FE5TK9RW@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/6] rust: alloc: add Vec::push_init
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
 <DKSVRS7UAL9U.3RUTW74RVSEHQ@kernel.org>
 <DKXNDP39VOFP.1W7GDGA2TXSW2@nvidia.com>
In-Reply-To: <DKXNDP39VOFP.1W7GDGA2TXSW2@nvidia.com>
X-ClientProxiedBy: TYCP286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a36ab2-7c06-4a5f-ec87-08df037c7dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|7416014|376014|23010399003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IuWUdPe0TPfa3Bfy+OAOqJnNc8M+07UqEh0HoY/Mft/oyGvVP2UPzO/Cb+g5xfEtdN/UD540IPzxT7lkV6k6SV6/9CZ0HA7tYdEGPTagiqm47BbAIkxzQCWW4YNB12skvWZ+Rgu80d2QRPvcAXOcJoEAtReLR4CCycdggAK/qCEO8K0qFxuQclq8hOOn9mGg/uGK6r4KQbWiRP909WiHHPi/UHe4ioSWDSpGQ4jNEIIkG4nIih4JGSDj/TVxzJ0txFV+N8C/Qav5lbdgqK80V0nVuyWcn73u0Vh+eDGzPkagCKa01i+cFhTunRWj1fHS3iQrVL4FFOR5rDBbMUmxeP4N69C+hLPQgC18XajS6xrJaHLkMn0t1jJOaCfTTD5q6wlZvfNtFEohV84rrl3nySO5bvTHlArhNL9CcmBoYKk8b7iNnwDI+JRnAuG9DUZAB6aHRHAFo0bGbuA1KRP/dp945g4esEm4TqibOHIS9J5MvPU0D14uUWX2q1KeC6kqy/PyqFrf3viKLZUEQ/UrtI6zf/BDcZkvSVliXDGY7y2KjJlqs1wzw4UOTdX77P0HbD/KimcSnzwcllM1tSnk3M4RENu5Ey/JUFoGVj5Z9Z+1HBIFUeDptJveh450mpVk4POnLRNVhJBgpSup7DNopb/7P8Geg2t62Mjs7xpLJvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJlU2xUMEZVb05VOTM1S3NnZ3FmZWpPRHBoWjltMTRwNyttQUpVakh4dkJ2?=
 =?utf-8?B?VWZYNWNIbS9ONTNueGt1U3FjOGVVVWxnSnpPNG4vWCs5Q2RIeThhcVNVR0No?=
 =?utf-8?B?OVlMcGgrMTdRTDhuWVArVDZZMldzV0FlN2wvYUVXbTcrSVJySnNQWGhYWGNL?=
 =?utf-8?B?NytBVFZLVjRGRFJQTkJNWkIxQ2cxNUFXTk8wNFlIVzYxeCtDZnZJUFZQM2NO?=
 =?utf-8?B?VzBSY1ppVjR0ckdqbUJmcndJSys4RnhqeUt0RVFmRnZsVVZ1MEJkK3g2MnIz?=
 =?utf-8?B?Rno0MGkvUkFsOWFUUDZxNHJWZnBHTnBJYk4zZjlXTVlYU2doU2t1TmtqbHFX?=
 =?utf-8?B?K3AxVkRlKzJIWm5NWFV2NzhBSmszVHlTb0lrRy9TcjRFZ1FuaVRWVXo2Mklz?=
 =?utf-8?B?aVpmV0UrbTJMM25hdkI1dHU0SkoyT2tVa0hPdlMwTWU5MEpUUU9RZm5uLy9P?=
 =?utf-8?B?ZTBFSERTMHVRUzhwUmlMNGl6RHhrNlRkRUhOYS83WEIvYkcxdkt3OEtHdXBl?=
 =?utf-8?B?QUJ5RnhtNTdaZW9sQUZXY3BzdGpzOGQzREhMZURsdys2eXZPRVFzclBlMHp3?=
 =?utf-8?B?L1hjdUptcEpUWW1wUTJqSE1ISnBKY1VUN0F6YlptUHRTRUoyc2Q3NTFHS3gv?=
 =?utf-8?B?VWg4bTFTOWY5aHFGMHJMZkxHYVcvK0t5MGY1UDhkRjM3L1B2ajJ0TmlwY3Mz?=
 =?utf-8?B?aGh6bjk2R1E2VWR0NmkyaWZGMmxYNFpHOHFndEZlT1dHUDNQcFgzWFVpRjVz?=
 =?utf-8?B?VzJuQ1N3U3VZQ3k3R0p3YXhHeFMrUkt2dzVmWmNydGMzYXgxRjE4SUdoUE5t?=
 =?utf-8?B?SVppSzltVjJXMXpxZDFXcmFaOXljLzhUeFg2MldtbUpraEU4aFlPZEx1ODFu?=
 =?utf-8?B?QldXUlBSakRlOEZKTlZEZ3NXc3VUeFc3ekdpRVk0RlkxY0xYcnFnNkV1a3lx?=
 =?utf-8?B?ZVVUL0dQbUkzdzhNUmgybndRWk5TNzc5V1BkK2ZQLzVLMUtLR2d5ZW9HeFJz?=
 =?utf-8?B?Smk5SHVtbVZuMHJ5bjNEWnQ5SDZLckJzeG0wRkdrWFpqSmlmU3RBVHVZaUZa?=
 =?utf-8?B?ci95VEsxcE85aFRmYzJnSUpuZmszcGdMdFhBSTBFTnlrOUgyUGxVVkljVzBp?=
 =?utf-8?B?UWlEbHpNenBDRnlzaUVoMHdib2UwSWtaemVQNkpyUElsVTdmSEVXaENxKzZS?=
 =?utf-8?B?V0VmaE9LUUJia2VZVUM3MnNiUHRMa1EvSG5kTUVhTFZVTkhITzlUMGFVOGxa?=
 =?utf-8?B?ZHdtVzM0U0thZXVoUEtrbGRIZ3JFZGxGU2xpbUdqR1pyVjB6V2E0OGNTNDdK?=
 =?utf-8?B?WW4yQmorak5RSWQzWllsd0k3UlhUU08yWGp4akpRVFl6M3hXSHp4YUpocmNE?=
 =?utf-8?B?Vm9vTWRoRytJci8yZFpZYUpSa0NyNDZHa0lmeUtnR1E2dy9kSmdXdW1jczBS?=
 =?utf-8?B?TGpmRnkzUmdNOEMrYVZtYzZuYW5Cbk1hVGJ2UzFkSXdnTktUS2xuQk11ZnhJ?=
 =?utf-8?B?aG52eStwVWRTUmRlOUFzLzNPOXFxNG02c2VDcnpPVjU5ZS9vcW5IeDVTN1FK?=
 =?utf-8?B?L0RLa3RFQVhkcE9xSktxUUNqYjI4Z0ErZ1JlNjlZNXdLTytYTHU5NGh2R1Ir?=
 =?utf-8?B?cTJ2ZjYvdkp4ZDhjNWQyK2NXM053czljTWpxbjRnbW1EbE8zbTBONWhtSG1o?=
 =?utf-8?B?VC8zZXY1SnlaWHhyN3BmWWlhR2FGaVdJT0Q3a0JEKzdMQVc0N3J5S1dmUklZ?=
 =?utf-8?B?dHNZa2lhaWJiM2Frd2hKWVZGNUFKcHA3bFRFRDQ5eVdtbEtSSHVUYVlKbW5x?=
 =?utf-8?B?ak81cEVjcmhOeHBPdVBlVVJNbjdieWpsY1dVRXdsOGQxZU8wellCdXl4ZU1Z?=
 =?utf-8?B?TjFEajBrQzlLdkFsOUt2UGhkbTh1ZHpyMWUzUy9wbkM3R092VVlCalhrdnd6?=
 =?utf-8?B?MlVsY1VZd2pLeGwrbUJwWHhrcGgzWUQxQWtLNDh5REZiZ3ZPWWszMlV3Tysx?=
 =?utf-8?B?cVRPa1FtaDRSTnQxODhkR1Z3TitEVlQyRTlmWTBmNTMwbUgzeldIQS8zQ2Qy?=
 =?utf-8?B?TlNnUVZ5T05nZXhzeGNYblZYQTBFbC9lVGEybC9RaXpjQ2NDNERJckR4dkhh?=
 =?utf-8?B?UHBKS3FYWGRGTGU3VnpSWi9UNTRqY0t3ZWw5N05SNlJuenJUaGhpeXpIbU1Z?=
 =?utf-8?B?dStCK1p5eHJUN2tWMTNBTlh1di9Vbzh4b3hqRnk2UnFnT3Y0K3NJRWgvR3kr?=
 =?utf-8?B?cDVMN2pYaGIwbE01NjlBRCs1V09nVVUyOTh5QlQvNG15aU42YVRJZFhicHht?=
 =?utf-8?B?N3dyTk51U1Y2TWE4S0ZYQlBPSlZSMVZLL0pIRDlOZFdtTVZxZmZhd1Q1TW9W?=
 =?utf-8?Q?n0ydtn1hE1vd/bvLyacMtnRQ1lDICopKtaxA8894fABxw?=
X-MS-Exchange-AntiSpam-MessageData-1: yFC0+AZ/YCplhw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a36ab2-7c06-4a5f-ec87-08df037c7dd1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:15:33.3408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kR9DLr0ZKeW2jtL9OAGQIMyBDay+4EtguofHKlSjm0HOQ9GbAEwsGgulTjCR1u6xdcvbRxjmqoTbOUFcs/gLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991
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

> So concretely, what about just:
> - push(&mut self, init: impl Init<T>, flags: Flags) ->
>     Result<(), AllocError>
> - try_push<I: Init<T, E>, E>(&mut self, init: I, flags: Flags) ->
>     Result<(), PushInitError<I, E>>

I realised that changing push(v: T) to push(init: impl Init<T>) can
weaken the type inference, although there doesn't appear to be any uses
in tree that are affected currently. Anyone have any thoughts on this?
Otherwise I guess it's push, push_init, try_push_init (but with the
error types I suggested).
