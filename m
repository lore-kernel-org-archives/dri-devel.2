Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54A9CD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 05:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FD510E0AD;
	Tue,  5 May 2026 05:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b0f5W0Ab";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA9010E0AD
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 05:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lannSPTRQGUwJaoalIGqfkzs9kboZ5Bz25zfvFbSHG3VlmHmvI4oq480/7nLwel5mZttn4cM6flE/USb2aSBmOZEinsMVYNoWctFgBAG0GVS0IfuJSq/HMpECcGX/0NeqzYb3GB+67frSFV+oGHa2sO+Et23RLQfL20b4/IBdOxzE6Wq4OIejCNcsuk5nydnXb2NWKfcDPHFELZJ+6co1KT9/rhcbUzGTBW5wKIaAg89ZDXugroJS81qHfpv4gMXcvtAVWiWXUGNdahx3yWpe4dyoZR0y7UTgnU7S1B71J7N05AXF38/KQPK8uhzrZFMEDPy2Bnsn/6FnY8bWsraGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOWNheae9EoQotamRZZ0HWQNK4LPkr45QcFc8xLOyuw=;
 b=FobPvK1mxUWfbsuwSFd9POJp/Pa0euW7InOJVw/Pz0zWYvU9T0gywuzgCp2Min6tzrkmsMuLe02FAL9zwAhbybgQ5H7WlYEA+ggkJkguqYCL9vWqxloG+/MXKv/MQmTFEh+a2WH6BhJcbeGy4jrsCSLK0LZtWnYymR86tDh/p4oPkPPosGaNH/cMEERB/5Oyx0kEZUOfNqAOMUNWTofrKMWLkvsU9FkeroN1ZEOKn28he3O+R2hSG/gqFftLtKHYGU8mEtybueGdaTb11RkI6C0etAG2LUAcRWJstsHW7p/Xs5tLp8gVDD7ouZhZvxO0zuXhaPIqggt6+RP0vWhvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOWNheae9EoQotamRZZ0HWQNK4LPkr45QcFc8xLOyuw=;
 b=b0f5W0Ab+CkX9NNbWPg8owRbFW0nEfgU16ohcs1XsvIoZtUUgQMVcosOqTt+wb/U/ncRea4vCmaYWWYjmz06qvdmr3peu8EZLdF89aV1LHcUn5jNAk/ySoSZ5U7JSt8zrEuHEMFNbTW1QLhGpHeB/QmXPzYwK9bAygsQSgIA+RPBy0Pg3Mgxg8nZGsmVjjiFG7uSWLn8IpOxww9exdKXV/6U6Z2MuGjftWa4dXXjYwUNFX+FTGDuvXKVQb/8FzS5suR2CQBYcUEUTVbgTMADpjn3BNEpth3CpiHQEehUiGjHIzKyu9jmU2Du6lzSw+3mLNzulSH/Rnbh2NXeGxlHFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 05:37:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 05:37:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 14:37:42 +0900
Message-Id: <DIAI11D10037.VHN3R751EYJS@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry
 operation traits
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-13-joelagnelf@nvidia.com>
 <DI8B0IOXNP2L.1NFX4OTABNHA0@nvidia.com>
 <53c88538-dca7-41f1-bb2b-856035728c69@nvidia.com>
 <DI9YR10HH6PE.AMLEZUV7701V@nvidia.com>
 <bd210abc-590f-4011-8337-21b54780fd4c@nvidia.com>
In-Reply-To: <bd210abc-590f-4011-8337-21b54780fd4c@nvidia.com>
X-ClientProxiedBy: TY4P286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f98b00-9c07-4198-20c2-08deaa68703d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8nfAPJwuXNLGaEQeiOHBLDKdun2lSPYAHD6xteLuIcNaSfvC4KMsIf+toZKzFVrAaY0Wa7I7VfjIWe7HqY5Qp/XAFLbmRTijjXQMzulzPT86+OUrY5PNvMzkPEZK31pV9Fi8rDCZBRQeyBhf4Womwd73W7MAjZt0vVF9BizwlVWuzJiO5QXf7lbXdW8784iXr9bKb8IM9ISFgh0DNyurewjr9N7acJZNoCOBGEezrZf3B6/jD9W5pvzDltcc382ug0DcJreTjFC6QILqn2PE4yA40uHGKSsNl1gR27NC2jqXc7QTtUjEq1/E81vbjYjxNmEA3aMWvmUBi4dE5kQShCHvHrMIyXPA6YISZtkh14wSImyOZzaOYQAv9IztS+926ihgxgjXe5tVfFvGSqkHVS+MN1nH/afdiEeYkTFv2WOyH4Ihy4i4aqEtfcwAxQZX+tz+YB3Od7b+qmZV09yIivazFncPU1wRsXSpPCWqfq/YKXDfnRAopsqTV3I0nf24J5t8WqDKLJ0RHF+fKAXS+DG8HmjxEp3ehocyxdjd8cx3z55zGFKZx7s6OsgROPqlQRQkaLdWlU2YswCT5KoT2kbMqI2zSq4vLn6wnB7l/G94vlKnckvjz0oNK+A+bMQT7eQUkTqZYtW8kt9b73WAFgoqqAvVP7pcSN5odpct7PA3fJzKvo8lTLRrmMgnlUJC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzF6WFJodzNnbmUxMjZ3M1YyeGgwMGtkVWxoRmkzMXBCbHhsUmo1UFlncUd0?=
 =?utf-8?B?ZTRiRlo4bVlIamlBV0NMUFNGVUV1Y3R3R2taMGttRUJrTGdyRE5VUHI1QVd5?=
 =?utf-8?B?ZFNHZjZJUGhXaCt3cXgvcUhpSlBDNFdUOWR2ZmlNbEdZY0ZNVWxoaUZhV3Vi?=
 =?utf-8?B?MDRyeTJwaHFPRkdHWmxpOExYY1E4SE5pMWNXaTh5U2tVMW05YUcva2JrVFBX?=
 =?utf-8?B?TTIwTG82dmU1OWRNSTkwRGJ1dGhkZU83UlEzSWlrUzZzQTRRa09GVGpQdWs1?=
 =?utf-8?B?WXp5M01kZmxEWHpTdHJRa0ora3RZNzhoOTFSSlA5SGs5c2xqNTRtaTZhbUM3?=
 =?utf-8?B?cG5YN25TTmIyWVgwWm9Oa01pTHVodzd1ek9BRDV2bmZNMG9jV3M3MHV3Y1BC?=
 =?utf-8?B?ZFhuYW50QWdDWERFckdWRG1sbEQrOFdKUUlsKzY2ZHlMUzRHMEdLK3hFaTRm?=
 =?utf-8?B?MG13N3hXSVRoL29xbjFMUm5Hai85ek9CY0RLcmtDaTQyVlU4bWZVdStGVHlT?=
 =?utf-8?B?dVhnd2x4ZmJqcytXK01ScXVqMWdweWhEVHN1QjhjKzJrUjRJMGovem9TS1Q1?=
 =?utf-8?B?b2V6d2ZYQmYxVEY2NldTdDBwOUFjcWJnZ1BDczNwdnh1M3pqQ3g3cDZ5QVlL?=
 =?utf-8?B?dFpDUSttRmFZSkY5Q2Mrb044Qks1aVFvQ01QVk04N29NNUR2dlZteWZDL2ZC?=
 =?utf-8?B?allwSzE5dkNaUUlVVitwOU9rTWJKZkl0NkowNmFYQUVPaW5pN1d4cGxpWFY5?=
 =?utf-8?B?elQxVXNqOEliYXBtYWtpNVIzNllDWDdxNENHaHhDU2Y0c3pPMkhBUG1ObkVz?=
 =?utf-8?B?dzhHbTlkbHV3UVVQb2dnZWY5d3ZpQjlCQ1hyNERkZXJnZEJsdnptL3VzMFhr?=
 =?utf-8?B?REJVZkZQVXlpRk1IWFNnS01mekVQUTE3b01zeUVRK0Nmb0d4VE1pWVJ2bXYy?=
 =?utf-8?B?STh0RVZBc2hqbXZkN2dRZTF2NTBVRnhuRFdwMlNJQ0RoVDlqV2pnVzVVd1NX?=
 =?utf-8?B?R2FsMXUycGsrVVRSa09zSjJyb2xMNFVQWW1pL3d1OUFHMk42K0MrUnJpWmlj?=
 =?utf-8?B?L2RUWDdUY3BlVlpXSzhqNXlxT2F2eUpuc2IrZ2NwaUNaeit2ZW5kYXJXalRR?=
 =?utf-8?B?NEZZWDhWcXJaZXNoSGVWNThOU3ZJU25iczF0NEdqeFpBZm9iK3lPWVp1QU02?=
 =?utf-8?B?bktlemhRMy9Hdk1XQ1ZBbFlzV1d5NllhcDF1WDhJYmNiZ0RHVGZuTnZJNEJr?=
 =?utf-8?B?NXRtNXNNNUZDdSt0VmRPWjJMa1NkZ3Z6bEd6elUzVzBTR0lHOXB5RWFHcjk4?=
 =?utf-8?B?bW0zM1NqOHAvdWtzblpJeWhoYTBGRWNCSXdNZ3Bqb25JaUVHUUJrSDRjWFBP?=
 =?utf-8?B?cWxYeFkydUdJMldkUHA1OFFrSi8rT2d6NlZMcW5aRkozc1YvRE1pREhvVk51?=
 =?utf-8?B?OWM3cjlaM0tzN3JQZUhMTHhiaktuQXNOa2FiaDZEcWZIcVUvYlZxblVFeXRR?=
 =?utf-8?B?bTlvQjVla0xuaHRjS2ZwTTMvUXhTWGJvRFZOTFVVK0wyeU1wR2JPRUk3aTlO?=
 =?utf-8?B?YkdhNTZHVlU0dEtKckhZZURNbE1nbXN5MkVRWWpyemtDd2N2TVBxYmNwM0NV?=
 =?utf-8?B?NVNaeXoydG8waTVXOUpsdHVyaytTWnRqeEd5TmdTSEZVVnBJcXZXaHlMdVhF?=
 =?utf-8?B?Nnk5dlV5RHNVQUxPS0E1RDY3OHlWaE43Z0ovYUk2Zi9SNzA2T3BUd0VrWW01?=
 =?utf-8?B?Q0laT2tDVUEvUSt1LzR0SGxKQ1J4RDRhVVNUejRkVWJtWXl0cmNKWk9zOXFG?=
 =?utf-8?B?L3Z5T1ZPRFY4S1RiVHNtM0ppT09qYk1ZU0creTBpT0xBM1FBUjREL0VVWHR4?=
 =?utf-8?B?UkxBM0FVM0M2em16UG94ZjFob2dnRjBaRUdmWWZSSHlZS1hwcnREek9kdDh3?=
 =?utf-8?B?aTB4VFhJZ3FHNVYzZVR4OU9pc05obWdjUEFTTlpoeGM0MUZBSEdiNEd3UWFn?=
 =?utf-8?B?NHpRY09MQU5EeVN1T05lVERVZmZKK0g3alVQY2ljNVcxc21RNUEwaFJlMjdj?=
 =?utf-8?B?QnZLTWhFZDl0Ylp5YVo4Q1NQaklQUjkvVms4YUtaU2JGVjJHTlJ4cHJmOWFO?=
 =?utf-8?B?cXZnY2dkOXlhM1UxNW41MmtOQ0xFL21JK005Z1cvZjlHLzdoTk8yZC9sQ0JZ?=
 =?utf-8?B?UGllUHB6WWgxZ0Z5T09XUjdHcmlhVEdvdVMxS1RhVXhGNGd4aHVlSHg1d3g5?=
 =?utf-8?B?NTFMOUxkcEQrVEJTRWozVFhQMjRSQTVyWmRHTHp4TnA2YnE2dlI5Vkp5OC9K?=
 =?utf-8?B?Um1nZmJyUDBhQU56ZUdXbUVDRlpuTXBaam12WDFvejZmR1B0Y2xBSWN0SlZH?=
 =?utf-8?Q?Ejt0y4EbjyN1z16FMBWTXwRHP6I2SQ644N8psA7+s480j?=
X-MS-Exchange-AntiSpam-MessageData-1: v9AXk1Az+GyefQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f98b00-9c07-4198-20c2-08deaa68703d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 05:37:47.3904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RNyUhSn485GTYZJsM8WBjwsROf6imrDlv04tx7Gx4gDZLezZUzHOmoIgofmpUaivfHo26l9cuVfzx+FnmvdbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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

On Tue May 5, 2026 at 4:28 AM JST, Joel Fernandes wrote:
>
>
> On 5/4/2026 10:31 AM, Alexandre Courbot wrote:
>> On Sun May 3, 2026 at 4:19 AM JST, Joel Fernandes wrote:
>>>> Please reorder things so they land, as much as possible, in their fina=
l
>>>> form. In this case this probably means defining the trait *before* the=
 V2
>>>> and V3 page table definitions, so they can implement it from the get-g=
o.
>>>
>>> That is a reasonable approach too, I can try to do that, but it is
>>> misleading to say '270 lines of diff that reviewers will have processed=
 for
>>> nothing' which is nothing but fiction. Please look more carefully, the
>>> patch is iterative on the series.
>>=20
>> For context, here is where the 270 lines of diff come from:
>>=20
>>  drivers/gpu/nova-core/mm/pagetable/ver2.rs | 150 ++++++++------
>>  drivers/gpu/nova-core/mm/pagetable/ver3.rs | 120 +++++++----
>>=20
>> But the number is not important.
>
> It is important, numbers and accuracy are really important things
> especially on the Linux kernel mailing list. Sorry if you feel that is
> inconvenient. And even quoting the 270 is a falsehood, the 270 lines were
> not refactored, only 90 lines or so was.

I am not particularly attached to this 270 number. It represents the
diff that I believe shouldn't be in this commit. Counting the number of
changed lines is also perfectly valid.

But again, that's not the point. Let's set my metric aside: we still
have, by your own account, 90 lines of churn that could be avoided by
the following 3 steps, each of which takes one minute to perform:

- Move the trait definitions of `pagetable.rs` into their own commit.
- Move that new commit before the ones introducing `ver2.rs` and
  `ver3.rs`.
- Squash the relevant parts of the remainder into the commit introducing
  `ver2.rs` or `ver3.rs`.

By doing that, on top of removing 90 lines of immediate follow-up
changes, you have also moved the public interface of the page tables
before their implementation, making all 3 patches easier to process as
reviewers are now introduced to how that code will be used *before* the
implementation details.

That's my closing argument on this topic and I won't insist if you are
not convinced this is worth doing; please act on it, or not, as you see
fit.
