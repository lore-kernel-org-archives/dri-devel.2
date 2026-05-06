Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386D4CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 14:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8334210EDFB;
	Wed,  6 May 2026 14:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tVoQVac2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0047810EDDC
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 14:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkHJ5NfwFIF1FQ3CpF8dc1hqx5/MsQiDNl74lYITA+/Eomde3YdfI5OuJBPczSMiEWFz1rd1IPk7EejkIbEiZTb0SZzecdV9bFfljGkuLaUVipfhcjWfqH8heiP1ATzmLB+Y1g3dRxgWlDYiuKn+/h95B2NGvUuJeuvhUkm9EvBjc/9qB8eqRQalWgPeTY1eV5CGu8187y/DxUqc9cZFY8bUKTgtE1LC1T1ph0PMvj/ROeH6vLm2a092yoxND8k6hqacmD1AKlMkP9TJUJW9fqLy+XJjrfSlWm56QAghHen4NBsI+ajr0a8uC4g5EBzPKRZvpJZ0vMMzdURa5fF+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfwvUoNUri/d027RrZJbnBXkIiX/G4BeditON25RWsA=;
 b=cNbc4PbNPaDNsWAoqlxeju8Fgv/BgDVly/DctpJC4JdCJZCX0V5XpmVx/JNG+riQq0CqHN8lzWdtjv+J1WS9r4tuhZucQoNtx4Pkn7fz2WQC7ZPUGA4qeGyVRv6ATV/KLqhdJt+lHQz5bJZlnA25hPiIB2BO8eyp/f8OtXU3WXJG+V1+9Adsrd9dApChuKAJR60LwViIt99eVW4qbdl7pM4iuzqzBdtYHv6yDqsgLEifwIPXdYUNFbd9GiPCMR32VTzlz0V1Z2Eo/9CtTP1SkxWThEIBv2Cec6prPolXYQwjOmTsODoX8AGI1UX35eCHTf8KXeimv4v/UhVm/0apRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfwvUoNUri/d027RrZJbnBXkIiX/G4BeditON25RWsA=;
 b=tVoQVac2wgsQTPd2Rfz0cecDWxy21f1sA9sauCw+MhGenJqsxXfPS8n4iwF2avZ4AHYVyU0riD35FQRuVnbqruSceELo/YFU1+ZdD1LLpSU7E3thDFDc6oSVYUPaHb/gWB3QCPmMjsNKq7gnRLDqPi6ozLPPj4oWfiYTN+C/UNX1zG1+ogaRES17CXuh2EpTLu09OdLq4Oj4KvlXExhGiqkiOX/yXUOcZCm4h82e66yqLT+MCvBvRtULO1mDH67evTHtU77azBgbdxBUCj24ofAfKB5wtpHxW2ZmiURM8HBZVTrJY73o248EcrHIuvV1ELmZzC/Vnc4hru/1UpazHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:39:01 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:39:01 +0000
Message-ID: <2765e680-5fe5-40b7-9c00-dfa1df5b5d73@nvidia.com>
Date: Wed, 6 May 2026 10:38:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/22] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 Nikola Djukic <ndjukic@nvidia.com>, David Airlie <airlied@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <ARitger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 Alexey Ivanov <alexeyi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-5-joelagnelf@nvidia.com>
 <DI8B0103X0HQ.7C99YLBMS2X5@nvidia.com>
 <DA4303E1-F49E-42BD-99B6-C7472C3BB12F@nvidia.com>
 <DIB6H6HHFW29.816CGQFBOGWC@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DIB6H6HHFW29.816CGQFBOGWC@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:930:8::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0370b993-c0be-4452-a91b-08deab7d36ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CFmUf2LoDilCe/2YKLapdY4wWHc1RAdG7UCUA1LmnXovyCzbR9sjijSO98vm9YeMu9vBAeCw1n2rLcNn+Ndv8pGJrZkCmNGvPy1aPR4iGUB6JUfKJofc7J9OHE8YFSFpgxxmXCirfkpmQeudLd7ZxnkvI6MeCeZ81bMAj+Ur0/RFOYB/RSZHNiFccoNGHdR8KX9URfGCngVzBz4738Hkpt0ksj4mbLHilcPI1oEXLF5UYkXKxVfJQKePiBobdK0rs9sv+cY9Y8fKUSJCjZolBYU4vl8ST+V9S3FMMjt02OjL/G9TSreLcUw0rhzOKnxIWTlT4jssiIuZ7HSYZDwQV1lajFDFMigHSK9X0otmGvovwwqYB9dNEByrZVPU87yLXCWSlbn5+EgzHdrBZgFPl62VPa/RfooFcmrAHqgHt8hzjvL4FVH/c9yVjismly5AfDBq7HoSj85CYCZu+/tPNyoYiex9w5dmsVFomYKTbu7JRqn3qVa1OQJQIYJ1J4DG5icI1n2ul+X5EewAvaNN/09ODLQ7h+t+Cj+IcdCqHZWTIT08Gq7aL5OX9/CmrDunMcN2+Kk69BLXktZINGrojvbMdwWjAxlUJdhtdPEP+hpWZLc83fSM5mOwf9PltMyo9KakXx1W095HV7AsrVnQpibTgRsRJpM6SzUyf4CProk+1m/mFRDCzBiLzoykTKtxaqgsQ6sbHv0Omb+/ReO1nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNYeUxRc24yTHAyN1ZnZ3E2SHp1OXBFN29CRW9ldnY2ODJOVHBvdlQyYmpT?=
 =?utf-8?B?S0Q1RW41STVBSDJzaUs4dmZ0ZmgyMHZPY0tKUkh6Z3o2V1RManZaVlcrY2xh?=
 =?utf-8?B?U0luQ1pRL1VFdVorcU83SlRMWGkvNWVCQWlhVFpPeHRNUGNHYUxQakg3Ym1F?=
 =?utf-8?B?dnVhSFo5NG1FVzVtZ0Q2WmpSMjdUQ0NyT0ZxT3pCMTBrNkd1RC8xY29IZVdL?=
 =?utf-8?B?amhIVkgybFlnV2dmaTZKbHhYOWtvUEt4MnR1TXhhaWNMeEJGY0xVR3dDVW5G?=
 =?utf-8?B?OTQ5Ui92bGwwdzQrbG5Kdm1LYlRNYThnSndWOGdNVllBUUJGTWphcVZ4Ym95?=
 =?utf-8?B?a3puSVJqNzNRY3ZrTXpUR1JITmI3NTZ3bThJQ2Q4RHRRRHBDWHBhQXpKMDJN?=
 =?utf-8?B?K2pBOWtrdkVEelN3NGp2d25xYWdPeGN5QXlpMWMvT1dtTmF2QjFLSHpxR0lB?=
 =?utf-8?B?QW0rQ3JNR1EzZ2IzRkZEd3o1cVNYQXQvQmFuMnlYWnoxcTJyRUdtWnNNeE00?=
 =?utf-8?B?K3RJZWl1UCtBSk4zWTBZWnJXblBuZnZNWThnSGJ0ME9lcmRRQzhpNWpad1dz?=
 =?utf-8?B?cDQvcjhpRFFaVFp6ZldxMlJCQTIvVzRRNVRlUDNvRUlxN0V5Um5Sd1BVR2ZC?=
 =?utf-8?B?YkVJWjd2d2xEVmtrelV0bmQ0VjlEY1UvNkJJSjJhQlltMUtOR1ZEcHd4Nm8x?=
 =?utf-8?B?NW92KzUvQzR1Y1phdzhDWDBOb3BBemNNam1zSXZWZEo1a1hkNlNzZTljTGRp?=
 =?utf-8?B?RjNGYXhkRTVUTVI2Z0NFbk81S1VVMXBtTjhoRXF3dTBBMHNySVpMRXR4RDdH?=
 =?utf-8?B?VnMyejdFQjVUMzRlRTJram44ZVo1OEdXUVlQVm1ac1BiY2tLN2kva21wSHFI?=
 =?utf-8?B?bm1nTEhpSlFVQXdwcVJPZUF3eFJOM2svdVlCOFhXYnRiMUdXV3ZnUVpLU0xl?=
 =?utf-8?B?SFJscmZtdnhYUEtySjZPZ042TlQvZEpVdzVoWisrbUJFVmx3czJOemlqSGlm?=
 =?utf-8?B?UHdVTUo4d3kxejdKU2hpa0o0Z1hITWRmOFdpZHM1aU1obTRwYTVmZE9ma00r?=
 =?utf-8?B?OHJCMlJXcHkrWlV0cVltbTN5cHN6eUJlUWNqTDF4cGRNNGd1UUFMUmlLcFND?=
 =?utf-8?B?Z2NJZkpmQURVc3A4clBrVXRkNlhXZ2RheGxoUXpaZlF2cG9JbXpUdFFnMXlS?=
 =?utf-8?B?czF2NDN1V2JuczRlQi9iY1dmVHdjblorTFFnTktRYjRVUkhFMkR4cmFXM0ZO?=
 =?utf-8?B?QmRIUk9jSGg5UzhWYngxYmhyemp5RVJIbGxTcXRHZ29Fc3ljZXMyM3d6UTNz?=
 =?utf-8?B?Vmsvd0p1V1NEU2t5NkNuVE5TYURMa3VYTWpRcmxnaEo1SWVjWVJrOEFoSVJk?=
 =?utf-8?B?N1FyY3hUVTl1UnJXbWhva0RuR09FbUk2Ym5odlR3Zk55NXBiYStJUmlTdGhq?=
 =?utf-8?B?T0V5MWZya3gxWk1handsSTcvbVNIQjA5ZEVHbWVwdzJXMTFGVjR5dUZnUS9i?=
 =?utf-8?B?bU93SFhORktYYjdMTEpPUTlTcTEvYU4yZ2JSOE42azRIc0VQcVRkTVBVSmxj?=
 =?utf-8?B?M1N2b2ZGZ1hwR1VHLzJCd1pWMFkwclRrV2VNdEUvM1dQK1hwdXhOTTNVN0wr?=
 =?utf-8?B?NmlPSnE3Mk9nYTVsaldVRjFKOExEVkR2UWU4UkVkWXNpM3FzTzRHTjNBQ1Vj?=
 =?utf-8?B?WDgzV2tqV01ZdWxvVXVvQUFjV2NhR0llRU9uM2NzeEZXMitCdENQbG9OeVVj?=
 =?utf-8?B?NjlaT1F1NzhPOFo2RytjY2tmdnVoY2pMQUU0azRabmhSNDV5TzJsVTJPalh6?=
 =?utf-8?B?V2dVVHRXb3grM2sxNUhCZFhRWGc4Wk44MUpZTFBCM2dGdTZ0bUg4TVJrb0hj?=
 =?utf-8?B?djJFMWZDWXV0NEk2ZjZGbDZvWXUxRGoxeW94ZCt3MHg0MTZrNmh4ZThnS2lJ?=
 =?utf-8?B?dm1pc3FkWWFaaFBCZTVXbzVrV2d0N3g4czBVY3BJd0ErenZ4ZUZkZkc2NXNS?=
 =?utf-8?B?RUFQeng5NjRMUVAyR0lrcDJyaXBUS0hwSVRkZ1J2alN3dXpNd2xyaUQ1YVpR?=
 =?utf-8?B?RWlZaWE4aTlINEVVTVJHZi9RNjlsY05BbG82eWF2aGN4ZitpQW1JREwxNU5x?=
 =?utf-8?B?NnptYzZ3Q1RlUXNaM0s2UzVramRJT2VpT3ZtcjN1TTYwN3lYejdPNGVURnlq?=
 =?utf-8?B?TUFsTkZ5NmZwTjZYcVozM29UczU4WGkvekxNczNnV0NBMzRNeUdISnNFN0JS?=
 =?utf-8?B?STZrelZmZkhWaWpUOXhCdmJvanFlVWliN2pnOWtYZGFoeXVXMWQ2Z0t0a01K?=
 =?utf-8?B?NndJSHdZbWtqRmJYNG4xU3lHYUo5NU1uQWV3VmRiOEdFVWRObEtVUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0370b993-c0be-4452-a91b-08deab7d36ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:39:01.2136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wNV7qWfGRlGTYvMqIfuta3Gb/JSHKzHNp/V+6zkmZOcz5b8ZYC3JtH/5lFzI5B5J9aUBR+uMpM7SQQewc2jHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
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



On 5/5/2026 8:47 PM, Alexandre Courbot wrote:
> On Wed May 6, 2026 at 7:59 AM JST, Joel Fernandes wrote:
>>
>>
>>> On May 2, 2026, at 11:42 AM, Alexandre Courbot <acourbot@nvidia.com>
>>
>>>> +
>>>> +/// PRAMIN aperture manager.
>>>> +///
>>>> +/// Call [`Pramin::get_window()`] to acquire exclusive PRAMIN access.
>>>> +#[pin_data]
>>>> +pub(crate) struct Pramin {
>>>> +    bar: Arc<Devres<Bar0>>,
>>>
>>> The HRT series [1] will allow you to greatly simplify all this by
>>> storing a `&'a Bar0` directly in this structure. It will most likely
>>> land this cycle, so I think it's a good idea to proactively depend on
>>> them. It should apply cleanly (modulo the Tyr patches IIRC, but you can
>>> skip them if you don't build the driver) on top of `drm-rust-next` - on
>>> top of which this should also be rebased anyway.
>>>
>>> [1] https://lore.kernel.org/all/20260427221155.2144848-1-dakr@kernel.org/
>>>
>>
>> I tried to apply it but had a lot of conflict.
>>
>> Danilo, do you have a tree of these patches somewhere that applies on drm-rust-next?
> 
> I have a tree here, it should build fine as long as Tyr is not enabled:
> 
> https://github.com/Gnurou/linux/tree/drm-rust-next-hrt

Thank you Alex, I will give this a try.

