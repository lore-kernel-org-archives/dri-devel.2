Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51154CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 716A310EBB5;
	Thu, 15 Oct 2026 13:31:16 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378E110EBB5
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPsgi+OU1dKaVdDLfHe7gy2lVHpi7D/pFFZ2csmPKR11nghhVoAn/6eirR3pkRundAy40Y9VE6LOMC1pUjJ1kePyLWAnbDjugzeM+vfUt2/hfMBFmlH21llOT8Jt+uFZFPmn64SpUK5Dzx93JgjFhcmALlspszpWaFVvcUq1uqI19jcf5nsoLQYzoMF4odUx2cgAxgrEtqE2iMB/zvuTx+OwtDfts9F6+P9JD89L/kgxXJhO2YoqtOhi3c7ysJosLVMLEYDMRie2yRXlq1QXFUHpNop0zkRaMw+SRpeI0hG4vN6orlmEbV70xkYAIl8QrNNPKFwqqyxyvRUVeHQHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwrFxm2bVOQx8Pla9I8K1louVvYRUrC7pWAca7kXEJE=;
 b=PK3+35/ZG6HXR+bTkR/VjDOzOt1i2csu2kAenpNnrUGKbhTrjfU13bu9prkWBH/xNEYZaqqbiKszAjNYCUl9HSJGNG4gmHHOTfw8ymfpqdPYjiO8A7jxRM1mALU2EpS0b79cVk/KND2WhBv1xa6mQnnRFVlhY8nTe6V1unz0PmMN330syktX85Yxh+L08aMxITAKdu/o+jOwXG8aJvYDwDUxq8D0+vHSGeDMor8o5k7/q0rJu1E08kApvE9bNeV11nB7bL/hZ1UrJgjvc7kfiHylQEnVZpgFcTUnov77EZCM5V1I8YFPu/CPzYxM0UCc4jDGNsC0f5XJc8fo9Egdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwrFxm2bVOQx8Pla9I8K1louVvYRUrC7pWAca7kXEJE=;
 b=M2zfBuO+ZZZTQoxxTfKvgTAC8kGPaOjDCCG8Y72fP0G38glPJOukdaRNw8UVK651tEfa1fMASwNTcwqVraopjIEf85GyVAXi+mLHVKoqSbRf+t9Fy8xSX8FJMlUjwt8o9c+3kI9sOBera3VfAyNv8IPQKxHm/Uvo9B3wbIDHhBx1eYZ7S69Ci/kfuaHh/FW0gQyvJFevKITvaGmPm0QdAfWA7jMdw935MBZKimhhaFj8K0pDBe8M8zhO9Am9CByFjVAXigoZPlSXqxsBkKsIUD275ROfYCMZPcSZgpR1wrMs780Tw6Z+W6/uE2vlsW5G7KUXRdenNlWWKB5XT9QYxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 13:31:00 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 13:30:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 22:30:56 +0900
Message-Id: <DM5G660SFQ0S.QNZ3KFM5I1WF@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Burak Emir" <burak.emir@gmail.com>
Cc: "Yury Norov" <ynorov@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com> <aryYkkB9j14xnWo3@yury>
 <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com> <ase7IBtZjQsPVWSN@yury>
 <DM0D75ZTTQXJ.2XADVI38UGH7C@nvidia.com>
 <CABwQupMVzUOsqP_fTZQdwUU+xEO1k2Q4=RQQuq2qd5HCYY0ZUg@mail.gmail.com>
 <DM46Y905AJVV.1K0F8AK1ZP4IO@nvidia.com>
 <CABwQupOYBBev5WkQry3oOoX5tGCs-ggDE4L_nK8BBYvrO=81bA@mail.gmail.com>
In-Reply-To: <CABwQupOYBBev5WkQry3oOoX5tGCs-ggDE4L_nK8BBYvrO=81bA@mail.gmail.com>
X-ClientProxiedBy: OSTP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:225::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b3e96b-e064-4c49-0f7f-08df2ac08cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|10070799003|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aMhKSGAGdnxbw3J/OnBQWZwm3QI7YBjBtBsa05LwzCTh04Vl9yAvpFClnxgNyRdIkQJHlOireWgbgQNZH8VUKNpIgnBTQWYhMrx7mlS4FceURNicw+7X41Dv0g6vL44VbVWbY63ak1aQhSn3qzVpMzOurSCzkHzCtNh2VepUzdj2J8h7sia6cfLiXekoocuImfe04PL5XhIj82eNVKP71dygmQ+MUjeDClOR1LFH+3Qkrb93TM/W/KfGodnuhjPZ3zOBhQwFQeRMBkHxEy1h6yYN0eAchCvnIGq/i+fjJUrtp9ZhQw64ztwWbk/7RQecwkERH1Xz4xVFNSqVTt7DYh6vDGBp62aHFMPyOwtC6g5DTd+O5+OGc/sLwM1VMYAfveM1th4yMffgx71eG8xq1j7RPUaSpZsQeIGkC71dTGpfCMHOunpFVsHTiu4RwHwkId7HA0hZLg0pvTbXT8rg8gSIo5amtGqhRjtJe3oTevd6W+MnN326/xEjdZWVXCb10vm0cMMRPZ5qQKPm+KL8GvtBTPvNIhiVMcdj+l7+H/fPT1PHVgcLi4sQE6VFodBKEvuvfFEzxQrKU3p6dYLgt7WEGQiCADhS1lKbnpPkLNCbqoeorLimD8A9i0eN9l0TIhU+Pl+gjrWvHXJolMQjFu3Yf4UHCjasO6VCEFB7nrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(10070799003)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZNSDJ1QnBCRUpkUW9BUW91VlV1cWQzTDVFN3ppY09jUlJ5RVpBejAvbWw2?=
 =?utf-8?B?SW9ZYk5uNFFlSlNNZXZZL1FNMVY5VVRUWGxqSzIzZW4zMkR0OEE0cWxWS2pS?=
 =?utf-8?B?d3J0K0h6R2tsajV5YTdkZnB0WEMvSGdoeFJ1KzFlejJQSzJXUGRSU3htR0U5?=
 =?utf-8?B?UzU5ZnB4a21mSWJIdW0rQ3JwVHZWQ01XbDlZZ0djRUpwcmU5cE9tUFQ1YXIw?=
 =?utf-8?B?R2p2SFg4SVZlWFF4NitzbXBmbjVDWVRib0tubktCcit3OEt0b3k1WUI2WFNh?=
 =?utf-8?B?Rk8zbnBtOTJSUE9VUHVSdTdxaUptSTBzdkg0VFozZkk4aC83QldoeVVYUExO?=
 =?utf-8?B?Q0xFOGRHR0FHaWdBNEFRZXI3MTlXUm5rNmIzSi96NU9uYU9peVpIN2RXemY5?=
 =?utf-8?B?MitGdG4zWXhnZWZHWEpJNDFkU3I4OHMzUjRjNExJNnMranJDS1VoMVJZaHhJ?=
 =?utf-8?B?ZnFpQUZCME1LNjlxZ2F4VnBRN0Z0RDM4VUlkOHpkNnlrc3lUK0E1aUpMd0U1?=
 =?utf-8?B?S1VlN3FTMER6MmN1U2NIb1RzaGtzdWVrbmlWcVNwcjhyZUd2bkpac2NtcHIy?=
 =?utf-8?B?bkpMM1BKZG50M0FSOVAwbVFWWDFKMERBV0lUWXN3NWdzNHRWTXdaZnlITXpu?=
 =?utf-8?B?SXZ6WGc0ajVmWWIzLzhUMFBVRzdvdmhRUDBBU3d3S2JYRDVNclEvdlpSNTND?=
 =?utf-8?B?WGF6Y01OeHdkbDJZN0w4TzZoUWMxWU1XZW1INE9Ka3NIU2hKRVFKTVlXRXR5?=
 =?utf-8?B?WjQyd1RmZEdmcVBod3l1Z0NJN3pnMWFQRTBuTGxaTjRJWGRtQzJrYU1SVnBY?=
 =?utf-8?B?TC9mSTBIWHNKalc1MVhkRDFSdDN1b3pkNnJhKy8rS244UWxzMGZ5Z2Y2YW56?=
 =?utf-8?B?SGlUOXJyZkRpN1J1YSsvMnZBZnFWTUxDSWdvaTg2UGlqV1I4SDdaMUFkbVl2?=
 =?utf-8?B?MFpYNU41cnMrL2lsOU8wbW1DY3lHa0h3aHhrNzR6ZzVjTEFFM1RjWmdGWWhv?=
 =?utf-8?B?MXhVL3JqTHlPc2dsRmVXcWxNSE9senQ3Z1Z5RFhHNUxabFdlQWFtZWh2TzJN?=
 =?utf-8?B?RnNTV1Y4UENDaFNkRkg5dVhBakVUL2t6V1hGQmpsbTFOVHRsa3pxSWovY2N1?=
 =?utf-8?B?Mk05SjZTMzVDMVd5MFg3RkhLU2Z6cTlNaWFTSzF2MlAwdnZiZk9PQzRBdjdi?=
 =?utf-8?B?MEJYV21KRkJhUUFEcG03eHBqWFA1NmhZaWQ2SXNFUE0yUFZvWGJseVkrdU5v?=
 =?utf-8?B?bWJNTko0NlhxZlpGQ1JNOWxyeEJLWjZRZ1ZFK0hXQjBFM1U5WkdEWmpUeUd4?=
 =?utf-8?B?b1dib1Q2ZmVqU1ZwRFYxOUJMT3piUTloT1U0eW1FNTRZdXFlZ2c3NGx2VENw?=
 =?utf-8?B?L0VWbmpaVnIrandPdUlSUUh0aFZXN1A3eUE3bVo2VVo5bnlJK0ZScytvSkNj?=
 =?utf-8?B?WXkwM0FkaThFOXhaOEp2a2EzOU1WUldjR25EeGlkanplNXZNT0ZzaXY2cW44?=
 =?utf-8?B?T25GQXU1NXc0Tk5pTFRsMEt4ZzBXSk1VVXhJOUtuQnUxbGhiYkovdGQ3d2J3?=
 =?utf-8?B?em5yOG50aFNRRFBtRWVVRzRkN01LVmtwTEJ5YlAyZ3lJdGdqUERVNzMvMXlK?=
 =?utf-8?B?MTFERGdaM3lSeWtyTUNsTTBrd1hMbVVZMkhjNndQZkszdmVWQUJEUHdCcGIz?=
 =?utf-8?B?QUs3SmdPYzV5Qk9JUENUMjh0R1VPM3JGbnJ6UDIxRkJsTHpOVWloVUo1RmI0?=
 =?utf-8?B?T01JUTViUDNoODNwV3JtVG9jdisvNzBoQUUzWkRXNDJYODBtKy9FclczQ2ZO?=
 =?utf-8?B?a1RwNTBsYXhvTEgyVUVFVWttL2h2VlV6WnZwY3JpZzM1R3lVeWJKak9Lb1da?=
 =?utf-8?B?QTdMOG5aSXo4RVl5Z1VhM0VPZDQ5ZHp1SEdQSzVhWEVBUkdEZEsvSlhoU1lv?=
 =?utf-8?B?UmhwQlR6dXZTbURIRWVES1NKY3Q5cTFURTl0WCtjbUZSN3JYYXM5T3VqK2NE?=
 =?utf-8?B?V1IwOUlFb0dSdzJncjJ1TWI0SXZUdjN1Q3pzb1p1N1cyayt4UlBVa1VWSk95?=
 =?utf-8?B?SzdjSmtRWDNRSGJ5cStQV1ZKNFN5d2hCSE93dlExUW9DYlpCNEVwdWFhb09Q?=
 =?utf-8?B?SHRtNkVlUG5Ea0hNQ2tXbElRaVlzdzBHa211bTduczlldzcxV015eDNsREx4?=
 =?utf-8?B?bm9zUXoyWVhLY0tOb2srODR1ZUNrZ3JMRmhUYzlhQnU2My94MWFpY0xJWDF2?=
 =?utf-8?B?MmlSLzlVZWxUUnBnNVdDZHNwNVVFZjlYM2ZEb293dmdZYjFUbXpiTktQMmNa?=
 =?utf-8?B?SjRWa2lKRVF5ZUh0VzhkVWI3Qkx5aE50ODRNRVp2cloxaFIwd0pHMm4yeTlF?=
 =?utf-8?Q?svlBcxhsJBlgM2HcG7kvWiY7MnHMGeiRl0K/V0c7KMIUu?=
X-MS-Exchange-AntiSpam-MessageData-1: 0jWGaSa6b2AA5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b3e96b-e064-4c49-0f7f-08df2ac08cd6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:30:59.7997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlRGF3Jp5Q3DAoMXAQ6pjO9WkMobHmRz5+mXCprQByiyBOvHsEm6GSbYuRHUACQGFO6qdfxMu872kcgLfdwa6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
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

Hi Burak!

On Wed Oct 14, 2026 at 4:20 PM JST, Burak Emir wrote:
<...>
>> >
>> > Do the other patches in this series need this, or can we just drop thi=
s patch?
>> > If they do, maybe a demonstration of how significant the special-case
>> > handling is that can be avoided with the exact small capacity could be
>> > part of the commit message?
>>
>> The next patch in this series needs this to implement `ChannelIdPool`.
>> The alternative would be to track the actual length of the pool and
>> return an error if `IdPool` returns an ID after that value, which is
>> what v5 [1] was doing (see `num_chids` in the v5 code).
>>
>> That's the special-case handling that this patch is designed to avoid,
>> and I hope we can agree that it isn't a satisfying workaround,
>> especially when the backing `BitmapVec` *does* support exact sizes and
>> that artificial limitation is introduced by `IdPool` itself.
>>
>> [1] https://lore.kernel.org/all/20260812-chid-v5-5-6c767770b3f4@nvidia.c=
om/
>
> Thanks for the link.
> To me, having IdPool support exact size seems nice-to-have.
>
> We are changing the design in light of different requirements, it is a
> defensible but not critical generalization.
> I was worried that we may need to have proper separate length and
> capacity fields (which contradicts the binder use case), but that is
> not the case.
>
> I checked the grow_request and grow dance now, it seems that even with
> exact small sizes we avoid allocating a bitmap.
> So I am not opposed. Like Yury, I find the 0 case slightly odd, but
> unlike Yury, I find that tolerable.
>
> The phrasing as "dropping an artificial limitation" does not
> adequately reflect that IdPool was done for a specific use case where
> the design made sense and is not actually a limitation.
>
> I wanted to highlight this perspective, because notwithstanding the
> name, IdPool was not meant to join the set of kernel's dedicated
> supported ID allocation mechanisms.

Given its name and location, I guess it was inevitable. :) But thanks
for clarifying its history, that helps understand the current design.

This also means we have two different use styles for this now:

- The binder style, where the pool grows as needed and we don't care
  about its exact size,
- The Nova (and likely others in the future) style, where we manage a
  set of finite resources that is not supposed to grow.

Which is what this patch tried to prepare for. Does it look acceptable
to you? I think we still want to merge it or something close to it.
