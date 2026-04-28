Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B999DFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AABD10E9DA;
	Tue, 28 Apr 2026 13:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jubIAkVl";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AF910E9DA
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXDc3PKXkoRnf3ddJ/Qn1NUtjz4M7yGIHeauf/mkDF3ZKDbBdjN/PayExIUHLKLO7c4Zzqv9aOPRdIIMGtC0FdYqPWgrAdn7XdkIE0iyfDgQPJU7Wdu01S8ZFYvsCa581j3UFaTc+i7iDq7CjvMGs8/zvheYM0tiLqFtaOcv3eqwkcoRm2XvITL7uIzslJEbFenY9Dj0r/Hd/8IDb9EFUYqCoAe0Y8zGQK48Pym4NHV/FLMQhXIonQUxXbddqsP7t6BOcxVSi2tscexVy+JCMzzs4Mi5BqhmoEb86SjfW1t4efxVld8Tu16E6+9nD6PDfQUsLKFU1YHgQl3WJ+PCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ3KtHxtbZEXknnVwqX/faBsQ5Qk1cE8SQT6xbFEOnQ=;
 b=JJWCEKzdKd1nvdLpm2E7Kpw9k3PckT3ytz13HzMhxBJ1cXnJMR9VSbghF2RrnRY8pyiDKPzHZBU+zkCICwvbIQB6PD9DKzSVJsmCQczg/EQhYqPFK83QHAFIujsrhS3h6qh+HAMmHwv0wrGl/9vPyj6DUNjJDDkIw4AcY6SXD79BozougqnTGGyZ4ihS50WUsWy54Wq5c2eEi4M6IloYWo7nUD5mX2HmfQaoBZPJF0LLZW3HcQK3QIlXbWBIdU2iCmxB/o2iuUlZr1EY11qCXIu0xwf4YrS39fbNK0nnz7yFW4BbaJa9Ee8bAVoGkwhYe6VhjtP+z1RQJyzIcZKZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ3KtHxtbZEXknnVwqX/faBsQ5Qk1cE8SQT6xbFEOnQ=;
 b=jubIAkVlbMpx/6onMuz4amGJ67HHerCK03mSuRPessJoV94DUsviyQ/agYwzfPN7o9Y7g26Yvd59p+T2v1aSzWG7Y22l1B7ZqlswvGftuUOTJ7AA4AclmEtkONCGV1Jdy4OZJjV3SKjfBO3n8clxOxb+Qchk8/DW3xBnKPJLxib+iSe32UZRhRsz8GQSHgdDSNowMnctksxsYvoIXGpXneFGzHBiaJ/O18j6ShLa6ik/qSNw30OmdZiUpD5Fy4nNB3WYsPkIizGTgYQk9IPmUcWKErC6T6nGdZBUwb/G1SuJGV3iRXEzw1aY09AfHVz5aPnG2rCgBvbx8rsbhMMSxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 13:13:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 13:13:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 22:13:31 +0900
Message-Id: <DI4TC7VUL93B.3D7KWP3ZACBZY@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Lyude Paul" <lyude@redhat.com>
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: fix unsound initialization in drm::Device::new
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260428-fix-drm-1-v1-1-755057178066@nvidia.com>
 <DI4SOY5IQR77.1D97MMFEQEOCW@kernel.org>
 <DI4SUYYUVHU4.29HTA4KRQYCG6@garyguo.net>
In-Reply-To: <DI4SUYYUVHU4.29HTA4KRQYCG6@garyguo.net>
X-ClientProxiedBy: TY4P301CA0051.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: f49d2e4a-882c-46d2-fa99-08dea527f3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: wMEDhUoCd21HcwZKo54Uulij8pvO7ddrkTxA3qA8KF8PfTKLyidfZAff+mvSNwvrUfCIEKzsdg6MPGfX4wF4vvWHz8xTItJahDCqq5f/3Pioq7/3nA9jVizwxhu+I2q/xNv/PMvYCU5zvSOTBNMUSxC/I5mcMnOLAHnsyE6T9bWaKtn6uRk1GNAtQTzUAveH7Z2epczZlQ0N2IlSWM/ZDssTeXQlLLjFBqKb31wYkpyo79um3u+UtZyhfUkgPd70HEiTck5/Mc6SX9VUuZPpvFN/jLPoDpXfpiol1B+uzqsFgWD8hTbsMEUsBmD8Dpz2BTtCC06fXIzjfZHPEh//E+XqBThiZd9W4gWaq1wjRUgzQdcD2hOk/TpdHo+hXlRfjBbuCXvmWwK8OlRWXYwykUquoewZ0WfGzwH7N/EWPZwHMRUK5UkuKtr9EzToElVTVTTLopDYRsfxYpQJdOntKsKHjFSJx6gBkgeaiyJRW9KoYHaJvcrZww/ESPfp9kv5erOsVUC6PPMOfI3S9M98b7jZsceJCmgoh3k11hlmUcKLzpbZMrb8jCaVNqL17Z4qP+7LTj8DjLdJQZDDs3VUMdhGR2uNUwucEtWuxD9H+1+UcaMfRHCXJnWb/YJSELvVYdomPfqy1XmgQDkhWNKjMq4LBOB1Cacxq9KnHA1iVWfU3bmq4/ngq7T7gmT9njgY3E8SpIbsGAqsufWfWVCpFyED5CGPONAFcLYg0Ci8vwUIinediQlav3LoJx+Rq2/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTQxVHVFZy9ra2VTaWVWQ3Yxc0FhUlVVZXRTTWJKWDJKUndnNnpiOHVyV0g3?=
 =?utf-8?B?QXdLSWwxL1VNbnBLNjFnb2dlSjI2U2phMlU0MDNzYnRDYWw4YldWTHAxVmp2?=
 =?utf-8?B?RXZxV3p3VVZSVWdXelR3UEtrT0VWL3BLSXdKb3pNb0YxMDZqNlduc3RkNGxk?=
 =?utf-8?B?ak5VcFRtYmZWOTR1Sml5RTBDSWJjUEtBbldibGlXNmVKbVF5Rnl1NGd1UTF5?=
 =?utf-8?B?VGs1S0o0aTBWWVhFeGl6aUlBRHZIYVE4Y1MzaGoyS1hMc21SaTJUOXUzblU2?=
 =?utf-8?B?VWdZM3JGV3ovbnBnbEVrSWJPcHRRcC9KRElyWjVnN3lZZ0IvenBIZzBrYnk4?=
 =?utf-8?B?bTl5SWEvYXBKa1YwWmNKcy9mL3psSVNOaGlCU0N1cmpETCtNUXJudnJYc004?=
 =?utf-8?B?RkszaERzZnY0MFkvUXhINDZHTzNlT3lVcFlVRkxQc0hSNy9NWjYyM0lWajVM?=
 =?utf-8?B?c1NXMHhtdCs1Y1N3OEQ5M3N6QXpHbzdIVXE1aStGU3Q2K1FyN2Z2VWdlbHNG?=
 =?utf-8?B?REhIdVFlVkVMOEZ5YlJmakpsNXI2bHdrMXhPWHB3MjV3VWk2ejFNRjNpT0Fp?=
 =?utf-8?B?WVNYNHNwT1Z1VDRrTUFyRlAyOGF0SDBrdWdDMDExS0dMa0pJT1o1dm5KZ3Vm?=
 =?utf-8?B?TTNRVU5FSWg4NDR4MHlIZlh0OFF0bTY1QXV0bjFUTmU4WVlFY0paUzR3Q1lh?=
 =?utf-8?B?MDAyWDczR0R5SlpoYU14YmNGdGpUckZheWh1akdLOTA4TDgydXJnajRUY0pH?=
 =?utf-8?B?WFlyY2NaQ255TUpQYys0dkhsOFNDQnJ3eU43V1NRaUs0YllBM3dVMkhEZFBk?=
 =?utf-8?B?SWwwRFFVQjczR2tURnQ1bEV3UkJxNEZRUlY4aHh0cEVyNGZEc0NGa0twQ1BU?=
 =?utf-8?B?UWVYVTN0eG1MWW5sUnhMSk9raXB6N3hVQVNicXE1NGVOeWN1cm9DZXFiK2Q3?=
 =?utf-8?B?dUhJUC9OOE42aFRyTU51amd3WjAwYjFqVWNTUmV3cnIzS05IcjdacFdRdnRZ?=
 =?utf-8?B?TjNMYVF1RGNoYXhlT3NrT2xXS0ttWTdnTDAxQlN1Q1hENEdCNE9PbDVFbHFP?=
 =?utf-8?B?UTNidFlPaFRheVNyNnE0cVFQNEdWZm1uK21ES3VBbmxJdFhYR2h3UkRJN2Ro?=
 =?utf-8?B?TmdudVFBSGYrN2g4V3hXWGpReWx4ZFRBQ0hmeCtXM1J0SWE1a0Mza3IxcTNT?=
 =?utf-8?B?OWkwWHVsWHZqTExiNnJCVmY5disvY0IzVFRtTEliMGNPd2FPc0o0c3dtQjlL?=
 =?utf-8?B?SEtRQ0kzQlAyVlFMeFlMTFVUOG84R1U4WDgrVnk3TnhCcHU4T0N4R1lYTmRV?=
 =?utf-8?B?WW5DR2dIdlYrZGhMM0dORHVZdDN6VkdUWFBKSzluT08yeUN4Y0R0ZExZc2g4?=
 =?utf-8?B?TUlia1NuRXhybGRUUENTOWdUaDNZQkNsYVRoQXhFZm8rWkVKWjZPZUFGZG1l?=
 =?utf-8?B?Q201SkRMb2dUWDNlVE5OQllSaENYbEVCUTVTNmw4dGlIckJOY290TWwzQjZO?=
 =?utf-8?B?RjBDZmNHMGpPMlJESEhKUWRUOVJBY3FlWVhxQ1cvcEg1b0hjbHkweHZ2MStG?=
 =?utf-8?B?ZkRuSlhHa29zSnpWNHBlVEdwb2cxTlRZd2RJODZnUkFEdDRiV1UwTUpROTA4?=
 =?utf-8?B?NUtTSnIzTExRcWowaUFZdHpaYW9pbG1hNndVMVQ4Njh6TXQ2Rk1TVjErbUYx?=
 =?utf-8?B?WWx2KzBIZUZTZWhmUTBGNFhGMDllK2hBQTJXS1JkYXh5MVJ6RGFLQ3kxbDQz?=
 =?utf-8?B?WkxwanZFWlRJZk5OYUVzQnFCTGx6QzJ0TXpyV20zWEJDVmRXcFFvZDdhb2p3?=
 =?utf-8?B?R2lpNHB3ZXJKSm9ITm03Ly9UazZ5STBockVaU3pGSnlZUXJsVEM2dVdwODdk?=
 =?utf-8?B?aGJBUW9lVUNTdmcrOWxHcE13NVBJUytjZ0RjU1Q0T0lrUGVPVFFvRGJ1Qk5G?=
 =?utf-8?B?TEtoRTNvTGdSQUw1UHl0ODdzYVVNVHc1cWdLUWgySjBWRkx4QUMwQUxneVhH?=
 =?utf-8?B?c2h5bUZPeXo1TEdMOVJEZkJvUkphak1CMi8vQTV5ekZYMlZuTnNHTVNkRmsw?=
 =?utf-8?B?VGVycnppdVZ5R0E2RGJBcDJ3SXpnUEZGWXpVUmFMTXV2bllmWTBteC9MM0Ew?=
 =?utf-8?B?OHRRUGRVWXVTYnNuUmJtSVBzT0ljUFk1SjN1cTE0UzNsbVV4Q0srRUhKRGl3?=
 =?utf-8?B?cmM2dVc5ZkR4V1J3ZWFPcWpSbmJUSEEzVUg4cXhxVWlWdVZIOWVnUEFxeUdL?=
 =?utf-8?B?SnZidkh5L3YrcE1kajhWMUpkWi9ocUNrK1lmY1RlcTg4bGUzZXIzMmpMUnBn?=
 =?utf-8?B?ZmJCQUFTQjdZUWpLVGxwMlZHSm0zazZXRWtiVGxXZHJ1T1htMVk3TWREQ3ZW?=
 =?utf-8?Q?YcZkzMQ5Ci4ctYaHk5tCHbt1ECVfxcTRsrcmav+vd+Uw0?=
X-MS-Exchange-AntiSpam-MessageData-1: VdKTFeUz1zPL9Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49d2e4a-882c-46d2-fa99-08dea527f3f0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 13:13:35.3069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJwIYJXW/srsrmcne+upw9TC9VSjCAYkg1IM0/zmP0YdmUZfCZLfynmuURX1rOAueVw8ob7OXS1nFMIhCfemzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
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

On Tue Apr 28, 2026 at 9:50 PM JST, Gary Guo wrote:
> On Tue Apr 28, 2026 at 1:43 PM BST, Danilo Krummrich wrote:
>> On Tue Apr 28, 2026 at 2:20 PM CEST, Eliot Courtney wrote:
>>> If pinned initialization of drm::Device::Data fails, it calls
>>> drm::Device::release via drm_dev_put. This materializes a reference to
>>> &drm::Device, but it's not fully constructed yet, because initializing
>>> `data` failed. It should not be dropped either. Instead, if pinned
>>> initialization fails, make sure drm::Device::release isn't called.
>>>
>>> Fixes: 2e9fdbe5ec7a ("rust: drm: device: drop_in_place() the drm::Devic=
e in release()")
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>
>> There's already a patch from Lyude for this [1].
>>
>> That said, I like the approach with the ALLOC_VTABLE.
>>
>> @Lyude: Do you mind if we pick Eliot's patch?

Sorry, I should have checked before sending this!

>>
>> Thanks,
>> Danilo
>>
>> [1] https://lore.kernel.org/lkml/20260320233645.950190-2-lyude@redhat.co=
m/
>
> I have to second this and I think this solution is very clean. It does me=
an
> that we're always duplicating vtable though, for just one pointer of diff=
erence.
>
> Is it possible to have a shared vtable for drm devices that's in the
> allocated-but-not-initialized state?

It looks like __drm_dev_alloc reads `driver_features` from `drm_driver`
so we'd have to have multiple shared ones if we ever have anything other
than FEAT_GEM for that. And I guess it relies on nothing ever changing
to read more from `drm_driver` during alloc. So I feel it's a bit
fragile, personally.

>
> Best,
> Gary

