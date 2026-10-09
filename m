Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D27CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF0A710E7D2;
	Fri,  9 Oct 2026 14:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="H4RnMgwr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F1510E7D2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luiFhoVgz6/8tvMXI6WPEYUxZmV1PxeZy8JlPmvYKKAbpmswViS8GcB8n/kqTMnJk9g9/Rr5hhO2mehNtKT7uD7WyHkqnUyJJvaobOCja0V6HW5YI1nbSwDV9uaRkPrC24RoZqskKu5oBgJREyCaKMrzPi3rQkEhhzEsJo0k82DtcgB29XlHFcgYbAnXFJzPc0cm7q6LBB14V/weOmehH+maFFIH3ljXnSSnkYfDqLjxtlkF1ScWqZMk4DY1+ibpg/Zo9IW8MY/QNXnesH2cq0jUFkNE2oTIa68m5mFXULxoqABsCj4dvmH0eS3dXGRF78jhM+K0E3LZBfPwVypvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+R7/BCkFBQLRMQT2xeYSj5M0IOJEqhocZQJjd5MT64=;
 b=t3B6ONrjN4bTBMNEm0RcpAKqoVrEGdH1Dlw3FQ0hJ+jmqFROu82D+WGpexr/o2uo4NoTts9a+k0bOjZvsk7dxNzCCHoPjgSxjBJx6TkOTzN8IOA/bI6bI1u25HrM5D+fPPs9oYkU4Bgu0aHn6s3OChXeIjm0uhD/K9Z9wax7Pi7hIQ0i6McoqPf+KlHjVI61siP1FOtfFLnLJC+D9PXhWKjpcvCL8MOGYmh9GnKaTAluyPmG8R09bIBwUTEO4eFV0S0MC6tQKK5hR9HPzEtxPdH3z3UJe8gCE54e1fLNOgKLDLVSf9qTma1+DPlCVW+TZXzJkOCn+GHLOfc8kDHswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+R7/BCkFBQLRMQT2xeYSj5M0IOJEqhocZQJjd5MT64=;
 b=H4RnMgwr3JYLbUTP0g8fTPs6QTozMuLGpBiYFnjTcNHbSd89qCNMAGA2BUUjIV1C4+ojXieZc1R617me3K+grFiM+KqIM6DuSuF9wHOIj6o9eUiUQo6PLx7GCyoqO8LGcRVmNvlmYyxg65aH4Vivmg9JAmPcuN3GsemgBJVnigA0wRdgTYuyShpibwWSgkhsiJfc/H8EF65mA58boyxMxVqenOhMxL1ptxjWXE2Abw6qj31DZhve9Q6QwGOqzs8lFNr3tKPGqFryb0mxg8hRfO72O6bKN34qTDpbaEghbKaJV9cqd54m1NgJsnt2beeySosWXfBbiKQsj2d6rokBHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA3PR12MB362669.namprd12.prod.outlook.com (2603:10b6:208:700::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:07:54 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 14:07:54 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 23:07:51 +0900
Message-Id: <DM0D75ZTTQXJ.2XADVI38UGH7C@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com> <aryYkkB9j14xnWo3@yury>
 <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com> <ase7IBtZjQsPVWSN@yury>
In-Reply-To: <ase7IBtZjQsPVWSN@yury>
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA3PR12MB362669:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c308cd-44ef-4e0a-ff98-08df260eb668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|56012099006|4143699003|11063799006|5023799004|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: rrmxczRkmfS5JBI7oHSpz/7ptWLMvCW6LLCAF3OmN8clvBkx/CihcjY3eIqkeZc+kF6ZpP3ItuwxydwEu53J5XRiXoqwv9OEvuJ6T+c2+zjZ8HBFYRbcmSG14RALribvaFumWfLl8F2ZrT+ZtePkY9WPKIbYQbaNfM6NBe8QUWJzoYs0nHW1Lb1Pzf53tJmbguNzQYEK0eWNF0xJZr4zkFP7hyouZw2Pa9d+ME+JmwF3lvTFCqudWQ9rZaQPlwRyZ/dfAunTKyPMB9xG1vI+Yp71ve3r2OgdFBWjm+HtGpIQtq1vtg8nh4T1McIlXivJ2RBykSvHkaHuHV+ZVreEReoI3HxW1KGJKa80ar/BDgLLX4kSMwpH6R6YYS29wGUbpfoMLa5+PUWlgz394ThRa0G2507YGn4+uOwojVJ6xZcfzBAVp6X1hdDEN2UrCOPqGfLzntXrI8yXsGLxhJ+PUIdvSPz9ghX9gXaDwfKREfKFGv7CY0vm10jsxSBrg2890tzhpuDF2/0COayLRK9Vd9gbypR2Q3S8Ys3TdEx88zxNsWgmpRqSpooBBSiPDHQl+qmwsFd7ox/iOknN153pkRujIbFSSLWehl8cYRTdhuSjAKoWan+7vj+8PUjDM2Lnlz3FsO5WlQcJUAFSlaCcyZthL2BNHCJJAygHVa3ghuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGZsQlBjSHdTSS9heVlBUFlNdXV5Z1NXa0JpdkZ5QlVCeVBwWnh1UEk2MjBY?=
 =?utf-8?B?cEI1VUpXUTdFQ2JvUlA2Q0xxMlpXSG5PWmROVTVjdUROS0tYTEUxTG5tUkVI?=
 =?utf-8?B?Tkt0SGFaTVgydEVRV2xxcmR3TEFEWmIyaG5Cd0FTY3JpcjVsa0FwTmc4YkhE?=
 =?utf-8?B?ZE1YWXU0bmI0bnJRcXJqaWRLcHo2Z3pIa2laK1RidnNkU0pidzlxU0RmMlFu?=
 =?utf-8?B?YUZGdWkvSlM5Z1BNcmw0Y1J2TTlMaDdUOVAya3RHaVJETHJuSHdsVnJEcHdS?=
 =?utf-8?B?VzV1bjM1a3FRdDBlUWxYNjIvTTNvbCtYeWZ1SGErdGs3cW5VTmJ4M2Foa0x0?=
 =?utf-8?B?dWxIWHU5cXZDcGJXSENnTlRNeTdVQWhLR3NVaWM3QmVHWlRTL2tQTzY1SVBV?=
 =?utf-8?B?RC91VzJLa1c0OE81T3VHelcreG1ybG02WlhhY2NQbEtjK0tEaUU4OUEzVUlu?=
 =?utf-8?B?a0grYkUvQlFRTndmVDBWd1MwWCtZWE1NWW5CRXZYaERIMUFZNE9pUDltNkg2?=
 =?utf-8?B?VjFqc01XdFdEbnoyK3ltbm1LVVdMZ3dEUU5SL3FKRE14V3ZSbzRvemdVdGdy?=
 =?utf-8?B?VDR6QUJiS1NLVkdLNFpleVQ0RFo1cU1lNE9sMWFRd2M1Y3pkUzRGcTZhZ1V6?=
 =?utf-8?B?VHpvRXdFMkJOZG9PNWxUMVN4NWlSYWI2UCtOaEFtL3dlVTJmTjUzUWphWUNK?=
 =?utf-8?B?cFJLV1ZDWktGaHpXUXlzSCtiTzJBbWg4Y1ptNXVPbWJsd1JnaFF6SDcvM3NQ?=
 =?utf-8?B?L25vNHhPbnpiYktaMlY3cDJhUnU0Z2lCMUdLUGJmTXBPNUxGaUVYUkRYd3ZJ?=
 =?utf-8?B?TTMyMnAvMndXMnd3UlZhZ2dkbDFVRTMxanhOYTZEaVg1SmxLckFTcSt4dU5u?=
 =?utf-8?B?ZHRWaWoraGRINDhSTFhGSllIaTlzR05IcFFsL1FLT1JaVTBuczJYUGo3WUZi?=
 =?utf-8?B?dEJ0Nzc0QXFnblJiKy9lV1VhTXdnN2ZhV2xVdVR2YTBKd1V6dVNFbFVQaWEx?=
 =?utf-8?B?eVhXbTVacWZxbUhaeHlpRkFlUVlGWEFiVVR3czkwR0MrU3dsZWY1M2pPVTcx?=
 =?utf-8?B?Q1o0Sk1NYjVpNzNta2lBSWtxbkNzS2JhS01heGRWS0t1TFBFaFpKNU5yWWJp?=
 =?utf-8?B?S1Bta3ZjV09VcGlGLzZqM1Fnd0gvVXdUVlFidzMxSjQvOWpIVVB4ZVV4R2xY?=
 =?utf-8?B?akkySkwvcWxjaDBZZWFmS2gyOE5LYUVZY1JDRElRV2l3S05XZmNmNlkvRnFa?=
 =?utf-8?B?Wjg3OE9PTHJKWDZ6SWZwUVQ3MHdtUktUR05IcHYyTEdxaklOUjJQS3QrS0J0?=
 =?utf-8?B?VjdZL3dHSVFmS2txZS9WK3BZT0E1MkhFVzhpcnhwclNCRkcwQjhHZ2pqaytm?=
 =?utf-8?B?WDNiRlIrMWVnOUgwK1dlMXI0a1F5N0VSdWswOTdBUGFwSDE3U2Z3bzcraUVC?=
 =?utf-8?B?UVdNZUVINk5MRnhRdSsyTWFRT2p6R01NdjNMNVo0aCtaZlpSLzFMNFBPS25G?=
 =?utf-8?B?ZEsvVTBDRjJIdVlFQlZFbExrOU5rOHJSSjZnTnpiU00vc3B0TjhDQS9qZGNh?=
 =?utf-8?B?UFFqMTBrR0dwK2gxYWgyN3JkVDhDTzJFZHlWbTN5SHJkM2dPM0ZxZlM2azJZ?=
 =?utf-8?B?RUNrYm5TelI4ZnBzaGFHZ3BwWW9oWW1UaFlqVEk0VkN5cjlPUEZxcnNLdUxP?=
 =?utf-8?B?aGJac2dJMk5OUk1ZMHRacndPRlNFaWRNNjdWUXJXTDlPeWovamZQbUsrNy8z?=
 =?utf-8?B?Y0EzTC9DRjhRODRzdXBCb1cwQitqUzJPUUxJZU91MHg4WjZRNTFqWm56OTVI?=
 =?utf-8?B?OVNkN1dmTU5Gd2xsSW90TXoxdmNBYzJzdmdxQm1ldUQxTnF6UVNsY3lKSWtR?=
 =?utf-8?B?K2R6TDNqQU5OYldnRVZrM1YrblhKK2RhUmxDdnJONDlXTmZMcS9wT2lFSSsr?=
 =?utf-8?B?dFdiRG53VVBKTk51Wlc0RENYY0FoSkd1Q3lzMFZ5VTQxTktrbzVrbkNRZ20v?=
 =?utf-8?B?NEFwdGdsbVZlUlgvQ0FOT0g2Vm5lWTBMbHdXdVBMdUh5RHN6TmFlbndtVVZx?=
 =?utf-8?B?U1JSR0tycWhRcUFUUnJjeU5yOHdIMDIremRtL2pnVlVkelVTSFJDelg3aVZv?=
 =?utf-8?B?K29XaUFjRjlvM0pIN2lFMkY0ck9rWVByMHFsOEllUUQ1bHJBcmtIV0NMQms0?=
 =?utf-8?B?UVlBWXoyZ3R0aVZwZFI1d3dlNGh0WXFKRVFHLzNIdVd2RFZOK1BFcmg5Y0pp?=
 =?utf-8?B?aDRmRXV0M2lWVFM1SFdqQ1llaHBpMGx2RHdMVlpncUZ6SlRiOGwwdXViUzRX?=
 =?utf-8?B?T1NtSXVNeUk4WlZ3UHFvVXdEWXIzZlNmbnp3MjRERXEwdTRGUnhuYVp4MWZY?=
 =?utf-8?Q?PPeihhiSJ54vDS4UhWHuwo1tdgfs33Px9oK9rSATu77/w?=
X-MS-Exchange-AntiSpam-MessageData-1: v3IsaoptcpfUrA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c308cd-44ef-4e0a-ff98-08df260eb668
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:07:54.3124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODepU7BN6ZOayFqNSQuiWf1zqu7+Xxzs8/Sx4lP6wYXZSkNHXQ4o65ie8YYgPSm1JpDzH7ggIBuQufZWmpeOCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB362669
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

On Fri Oct 9, 2026 at 12:47 AM JST, Yury Norov wrote:
> On Thu, Oct 01, 2026 at 03:20:40PM +0900, Alexandre Courbot wrote:
>> On Wed Sep 30, 2026 at 2:05 PM JST, Yury Norov wrote:
>
> ...
>
>> > Allocating a pool with 0-bit capacity is wrong. Please don't put it
>> > in the examples. I recall I pointed that this object would panic the
>> > kernel if, for example, you call pool.next_zero_bit(0) immediately
>> > after this. Sorry, but NAK.
>> >
>> > This .with_capacity() should take num_ids: NonZero, after all...
>>=20
>> This panic is not specific to the size zero, any size triggers the same
>> behavior when accessed out of bounds.
>
> In C, malloc(0) is implementation defined behavior, i.e. it can return
> a pointer valid for free(), or NULL (which is also valid for free).
>
> This is a very old legacy coming from K&R implementation, then rejected
> in C89, and later this all became an impl-def, mostly for compatibility
> reasons. See 7.20.3 in
>
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n937.pdf
>
> Rust adopted C bitmaps, thus creating 0-bit bitmap may go through, and
> hit that questionable behavior. You add this example without any
> discussion about all that possible complications, and with no
> protection for users.
>
> Interestingly, you're doing it for the reason that has been considered
> a bad practice for over 30 years ago - malloc(0) with the immediate
> realloc(). See the above link for details.
>
> To me it looks like pulling legacy with a potential of undefined behavior
> into Rust.
>
> Bitmaps is a way more simple case than the generic malloc(). There's the
> only user of bitmaps - the Linux kernel, so we know exactly all users and
> their user patterns. I'm not aware of any in-tree user allocating 0-lengt=
h
> bitmap for whatever reason, and such a coding style is highly unwelcome
> nowadays (30+ years).
>
> When it comes to rust, things are even simpler. Rust has much stricter
> memory policy - no undefined behavior, no implementation-defined behavior
> is allowed, no 50-years old legacy has to be considered.
>
> Rust community decided to take the existing in-kernel implementation of
> bitmaps written in C, for a reason. But with that it pulls all undefined
> and poorly defined behavior associate to C language. We did quite well
> spotting such places and fencing them with safety checks.
>
> The 0-length bitmaps is just another case that should be resolved.

As it turns out we would never perform a zero-sized malloc, even for a
zero-sized bitmap. `IdPool` is backed by a `BitmapVec`, which up to
`usize::BITS` uses an inline member as backing storage. So we would
never call `bitmap_zalloc` with a value of 0, making the safety concern
moot.

>
> If you still think that you need 0-length bitmaps in Rust, can you please
> give the clear and thorough explanation why rust needs those 0-length
> bitmaps. Are there any in-kernel examples? Any language concepts requirin=
g
> it? If not, it's still a NAK.

I don't know of an in-kernel example, but please look at the
`bitmap_vec_new` test which has been here since the API was initially
merged last year: the first thing it does is create a zero-sized bitmap.

It is also easy to imagine a user starting with an empty pool and
growing it on-demand. Having the ability to create a zero-sized pool is
convenient to avoid special-casing user code, and in this case I'd say
expected, just like you can create a zero-sized vector. Again a size of
zero does not trigger anything that a larger capacity cannot trigger, so
I don't see a reason to forbid it.

>
>> A size of zero has nothing special
>> in that respect, so why make an exception and forbid it? We had this
>> discussion some time ago [1][2], and I'd recommend instead making e.g.
>> `next_zero_bit` return `None` on out-of-bounds accesses, which is
>> semantically correct.
>
> No. out-of-bound access should panic because every caller of bitmap
> API knows the length of that bitmap.

Right now out-of-bound accesses are allowed if
`CONFIG_RUST_BITMAP_HARDENED` is not set. The Kconfig documentation for
that option even says "if unsure, say N", which suggests that not
panicking (and thus the behavior I described above for `next_zero_bit`)
is the default. If out-of-bound accesses should panic, then the Kconfig
does not reflect that.

>
> But if you make that 0-length bitmap a valid case, we need to revisit
> every function and make sure it returns ENOENT or something instead of
> panicking. That, again, must be very well explained and justified, and
> all this has to be done before adding 0-length bitmap support in code
> and examples.

With hardening off, every function already behaves in that way, and
existing user code is already written to not trigger that condition
anyway (because of the possibility of a panic), so that would be a
pretty innocuous change.
