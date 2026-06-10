Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E60CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4B010E862;
	Wed, 10 Jun 2026 10:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="k14eWiYX";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C108289D63
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 10:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD7ks2undwCKTMO+Jmc+5xrHV1+yx35jw7/pQ8K1EsMOTw4nRxgSLNpKAo9PDAqKPm6akFHBwRPl5Ny6zA79cFfaxxGxAOxBhCHrxnkpsLiscwd3EITHiCcWn2hN4e9zTcTOeAvKkTaGgJN+v5fVcuyt2nnGCXmf6pTEjaFpd1B303W/X8Js4QQrqsSP85PEusqAXwWLdDVFGQOfWAZ42BKQ4IuwnC3E/CWf2yd+QNOl7XL6dtKc5qFz6g93AwGJbKhZ+G1ixlmBGFqonn0ZR4Hlp24HUoQpsfh/5I3Q2NoOSC25Mz8t0Ya6QyFYEVhbh9uwijTcZEQuV50ZmRL0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7VPn3e1LMCAnPeIttcpoY2S4N1ZvqyOHN/xaZKD3hA=;
 b=flkeJ7eLQrqcWAkMavJbM6P9LTxz0Imw9YrmT2IvKaaPW8FnJ9llvjDIxMFS1h6eILM4o0SLvYzYr8exI9FcEH0UUmODZ/br27ZIcwVqla//HCWtVB6dasyQS+jOSDdvvn7EWJoOoqgXGhY6Yzz1J9zXFMK7NwZOBXmagBUhWUqEgojFI+jeILjSiye2X5MCwooJ93oBOz1flHXYoj4ByfO9dy3vckHLiB9HvJbFP2UFbNiFQSULBOBOxFo8PTwnAR7CsXRHVoBY12lkkekmY4R3C9JlT7nlk0T7s6skCdmQRP6li8uBhD01GU6VioZS+/yfMZE8sNkMP70oJF745A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7VPn3e1LMCAnPeIttcpoY2S4N1ZvqyOHN/xaZKD3hA=;
 b=k14eWiYXPucatsqzLliL8SyxPeU+9iXRR98DihOopNRMMDH0gSuXXHqzl0PYowiEwoVxKZmWuXL5MdXmqLqu0q1tiMQqqZyhmMf/k2ndjCjJqo6An5pm+UuOKTyT1dkHJGGTtjdxHPES6hCJBlTXener/s8/uruyRXHnw4zE9Iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWXP265MB5624.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:158::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 10:01:06 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:01:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 11:01:04 +0100
Message-Id: <DJ5A6AM2FDGQ.19T1Y9N1T6JST@garyguo.net>
Cc: <a.hindborg@kernel.org>, <acourbot@nvidia.com>, <airlied@gmail.com>,
 <aliceryhl@google.com>, <bjorn3_gh@protonmail.com>, <boqun@kernel.org>,
 <dakr@kernel.org>, <daniel.almeida@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <fujita.tomonori@gmail.com>, <linux-kernel@vger.kernel.org>,
 <longman@redhat.com>, <lossin@kernel.org>, <mark.rutland@arm.com>,
 <miguel.ojeda.sandonis@gmail.com>, <mingo@redhat.com>,
 <netdev@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <peterz@infradead.org>, <rust-for-linux@vger.kernel.org>,
 <simona@ffwll.ch>, <tamird@kernel.org>, <tmgross@umich.edu>,
 <will@kernel.org>, <yury.norov@gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
 <20260610072947.338278-1-ojeda@kernel.org>
In-Reply-To: <20260610072947.338278-1-ojeda@kernel.org>
X-ClientProxiedBy: LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::9) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWXP265MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e6a9c8-1468-468e-e623-08dec6d72fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|376014|7416014|366016|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Uua37jS35e8PdUyYzdJUh/YLh1FAERgE5cznRffvFvzI3dwfK/wDXHSkk1GgGLByTS1bAlnDCLAu3J7zfTKR7ulVIk6SUkR9x+2LdrgcuAqPYPYXMWwHL1F6srDLmkbXQpW5G49YqvAh4wrP/BPtxd18mN1uKF3TNDaBV+s5+RW1SwwCG+NovWHE+J8hdF5GtNDEVJSc90o7XylCr3TKIeTmoDDwYck3KFkmOgiXFCCqwbWYrpUWjCbQPsUikI8cYC6oAR2F4rOIjcbmh7PC2gX9tNuPzimjfq0xXsn4GEqE7VbirPtlRQjeGBt35Av44P8Fxot4iApWr0v6g7YkiCPhqe0yJhND4gAcF5qT2l4ywcIEkOwnj4yiNVAno4bbpqteonnV9NJfYoFtZichmr0yhO/hivaz0YeQO2VYxZE58Ve36+MPbl9TsHcYkKQPjYWHaet6Dr8DlZ7bUelCb9Tzn7Y8kxOCjYo5x+zKrIQkkXB7TGVzrVAXp6CbrhABsAZzMLi9cX75P74MZvSyb3Ri1MM3N5mPNQUzOnA+BH3IjCeeTbF9ORtQKNr5opL7Y0C4gnyBRoxnwKwwV0ILneMmgvHogMrjZyLp1LHedih3QGxbz8pYfX2Fo1xw1viSJjrSZPL4HefohBhq2g1BawXtSyo5smsdvgLPsmvY0EDxuGAylbRJ49gbc4CEKAh8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmp2bHo0S1FBelY5K1N2YnVJUzlKUENNVGRVSUFEeWRCZGpsdmhTZFV6OU04?=
 =?utf-8?B?Wm5xRVF3Q2FDcTFJNkdEUnVkV01jNUFrS0k1OHFWMTkrTUdNTDYwemF4bmgv?=
 =?utf-8?B?QytaMjB2OFoyY253TTNkanlwaVBhY3V4NjZBYVM3T1I1alFnY1I3ZDMyajVO?=
 =?utf-8?B?dnZjckk0Wkc3dDFQRkNlUXNjRmhXV0NRY0MvUHJpTlQ2bXh5TitwS3BOWHlB?=
 =?utf-8?B?VTFwSkhYUlYwejJoUDkySHB2N29zMnNCUkx6V003cjRPNEpZRm9KSHhmbFNm?=
 =?utf-8?B?bDc3Q1lWZzdLNlhxSUN2Wk5zRnZqWVQwWVhzcndXb3h1TDdvMTBtUmhqQkh6?=
 =?utf-8?B?QUdZZXVwVUVYNERnYXU5SE52Z1N3TVlQRWVaVUpkcElqSWNEYTl2VUlvZmdq?=
 =?utf-8?B?b2REQWNWN2R5UU5qZ0hqMkZaSktIdUhqMkpqdTV0OUswWU5ZVU04K29RWjFp?=
 =?utf-8?B?Z0p4T3BzR25hVE1semczQnNhTGNkU3JJRi9FTzN0YUhSampVaWhsazZ6cG1W?=
 =?utf-8?B?RUZtdUNIL0tSUFhKQjkzTFc0Zm5FM1VoaTRtcE1yMjVZWjBnaGRzWk9SVnZi?=
 =?utf-8?B?T05taW9ScjRWN1RDc1ZJUCtkMUdMMGJxVENMOVVHZ1Y4RDFCVXQ4S3NFMVNE?=
 =?utf-8?B?N2I1bHlyaWxja1Nya21mYVhWQjlaK1hqcWNETWJoWE5HS29pQnV2aU1PN2RT?=
 =?utf-8?B?UCtIUG9uVzU5UitLdlc1R3pkZE5DVlBWQ213Sk1ONE1LTmpnOFJtbjlJcEdW?=
 =?utf-8?B?NnhpVDhYM0taWE1NdnZCZWF0aFF2TFZHUUJxTGgvMjN6ay9LVmxvb05MMFRW?=
 =?utf-8?B?ckpMSUsvUXFWalYrNHl5ZTRyQUJ5VTVpWUdHQnhwVFdlMnk0OFp6cFNyd0dQ?=
 =?utf-8?B?VHJPUXJJeHR0d2dlRTcxZXhLck5hUU1scjNqQnoxYmNZYnRycmVDWnNseUd0?=
 =?utf-8?B?MkM3WFFGYlBtVWFXczZBeUVWU2ZZeUhNSi94V3FwcnF1WEJwZXZGVm9PUkhu?=
 =?utf-8?B?VFVVTGVxbHJDcHBVc3FrNXVmcWE3amxsV2VYQ0N3Qk1RdFlYb0JicysvN2ts?=
 =?utf-8?B?eDNiT21LQmhHM1VNVFc2VndJQUM0MWtOOHJDTXU5ajcwTjZoaDBmT0JUZndO?=
 =?utf-8?B?U3JHVHNkUS8rcmVXL1Bwd0x0WUsva1lCU3N6SStwaTZxRmFGYnR5S3N2UDNo?=
 =?utf-8?B?ZkJNNU1tMWhFZDlHSHk5cUkzdHBsdFVTbDg4bGpaU2Z4QXdTSVlzWmJlbVJN?=
 =?utf-8?B?TXRRTkFmcURCQzNCY3JncUZPcWRmWTVJTysyemVldzhFekZPMytqYVhMZ0ZH?=
 =?utf-8?B?NzBYbCtZR1U5K0dlWEgvcWJ4RVpRUEdqRTVWREt2TmUyV2lzcmxpQytBL3Vv?=
 =?utf-8?B?eXQvUEpHOXJLaEh4RlJ0eWlTaE9DZTY5UEVvSlFnbmZqK0RLU0hKb3ZUN01s?=
 =?utf-8?B?dVdvQ3BRQk12K2xybk5VZlVrUzBWNTNVdHlqdUFKZDRSZU5EaG1sWVVydWNn?=
 =?utf-8?B?VTNPaE55YnZuZUZPdU9OV2JwUkpmVlpXMHZBakowWXdJSG9qekRFZkdvNGhG?=
 =?utf-8?B?V0tOMU1XY1M5dTBMeitscE9xelB3YXJ2eTBZTVJTOW02cHhDUWhkelRqUmtu?=
 =?utf-8?B?bE5maHJWcUEzbitSSElqd1JoY0VVZ09iclQ2Mk8wa3U1OS9QelRFNjhocDNL?=
 =?utf-8?B?ek9HNFRxekV1NEZjOXdTZThpb0U5Z0RSbGY5YkpWYTFraWV5bnB0bTB1UEJa?=
 =?utf-8?B?MSsxMVpmWW9VVGMrTU1SUnZTZ0pKSHdLRkloY1lpY0I3Ym9tT1J3R0NJZzAz?=
 =?utf-8?B?NGNPYkIwZUxzQzJ2RG9vUXErSitOQW9Dc1A0MVRyZWh3bEI1Q09iWjNmOFFQ?=
 =?utf-8?B?b1lNR0VGRlQ1dTFocURLVmhQcEpKOXVBNWVqMTB2aHJhbnh0MGxmR3lxTUJk?=
 =?utf-8?B?ZmtySnZqWEVlNUpKOUFDT29ZY0RCSkNEZVNldHc0akpJWU9SN0tjRE9LdkZS?=
 =?utf-8?B?QUNNaWJUbFFWWXJNek05VmdGN3RWc041SEo4RzR2ckE0K1UrTGp3K2JObzdp?=
 =?utf-8?B?eEYzMlFRS1lTZ08xazhGNU4vM1hkRjlsMWdMY21aUjZPNEZ2cDU3dHk2MFhQ?=
 =?utf-8?B?TVlKSWJWaHlaWUZYY0tLRWE3TEhib2VGcTI2Rzg2WUVTNSsweHlraFhQeVlZ?=
 =?utf-8?B?Qkg1b29rc3Y0RVJZT2ZFQ1BxbkNORVl4NVJmQkg0NTJuVHNTMGJYaUFaMDlK?=
 =?utf-8?B?NnE3NmIyV1MwN3pEUlhSWXEzUW9SK2JEQ3ZNUDdGZHBIZ0d2UnlBaTJQbW5l?=
 =?utf-8?B?OGZnbkQ2VDY5b0dFZGRyVXZCV0MvRHgwSjdHd2hsd0hQWkZqWVFFZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e6a9c8-1468-468e-e623-08dec6d72fc4
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:01:05.6528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IF7DdAUVr+kFS3xm6xBUi0beBG99bffE87RVUYTNc2ypOvT+tMI7W4V6YjUx0QVGLQnF/ngdp+DgCePXuUN3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5624
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

On Wed Jun 10, 2026 at 8:29 AM BST, Miguel Ojeda wrote:
> On Tue, 09 Jun 2026 19:19:42 +0100 Gary Guo <gary@garyguo.net> wrote:
>>
>> I think I just kept it as is when rebasing. It's file to have them group=
ed in
>> the crate to.
>
> Thanks for confirming!
>
>> This one is using size_of, align_of, c_void which are all in prelude. Ho=
wever it
>> looks like I forgot to actually remove these imports in the last version=
, and I
>> didn't change it during rebase.
>
> Ah, I see, makes sense.
>
>> Are you okay with fixing during applying, or do you want me to send a ne=
w version?
>
> I did it on my side. I also tweaked a couple more bits: they were already
> `no_inline`, and I noted that they sadly do not appear in the prelude any=
more,
> but the change looks fine and that may be more of a `rustdoc`-side issue =
or
> design choice.

I think if the re-export is of form "use crate::build_assert::*" then it wi=
ll
still be the same semantics but would be appearing now?

Best,
Gary
