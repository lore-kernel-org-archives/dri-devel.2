Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBADCA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0616110E20E;
	Thu,  8 Oct 2026 16:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="UNMADgbI";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020084.outbound.protection.outlook.com [52.101.195.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6624710E20E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 16:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqgVyGJHkF5sE6dcoKFSVsG8Gsal8fr0twr9UNXeP4RruDxo2KD9MXsxCcU83OvbjE5nArevD1or2qUU+p1LGOIj5K624xNl9dDE2cGKImkCPUCaoUL2lNxycXlJbMe4zol2JYDgznX8cdHouzaNDzAcPybEpjO+n7iGiH4YPqPy8iTRjWJWLE/w79dBnHgd4govfhYrOOYtTVdCbqp4WOsGRIpggxHAKneez8dZmEWatK1TxwaP/Y+rAyNqH6RBpduHo7i6Pchlyj5ewXT0+eFm5qE7NDUwP2QVItoda8gAPlp9SwUXWWQywBdPs5Ckxz8wACaGY0EgS/vDwuC2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl+ftd+DQgtFcPKUQWGX5mSfF3hB9DwyfKf7YAkN0kQ=;
 b=doqOSRPfdQIDgLBkTeoB0/Jg5dm/15BylK/C7tCGHIsqp1JAD+2KzFXSAjBZ49F26s0vQNBmLt7PguWvHdDqODq8ut1B09p9Mb3ChYZo/kebv+0S5MVmZqqdiKKWNxLMHCwB9IQIy+WAB/I0PTDKkB9Df95FXAUuG36gvopF10MB/ymxr9PAWTK9unp8w6vRPCFKpzQ632qKnQoJUgKZwR3SzjIbIPXmMxkFR0nbR0pe6z2sX39CqDONQDWqrA8cz10y9XWUE8ok2g4n7DdZAkcadk3mWJuMzET4cl1n2/KJDxwVLEo8eaGigZ+u3hb4RGDn+2dQieHjeDVWQZ8zTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl+ftd+DQgtFcPKUQWGX5mSfF3hB9DwyfKf7YAkN0kQ=;
 b=UNMADgbIiluxhhJL+xqNLgENzMh6rycPq9IZ5Kc/ETojXXMI7OQWPlTjPGo3/6qHz9Uw9rls7I8DOQvfN/K7Jhy2KBCw6Yt1S/I2QTzNMo1lvP74uuy6zhGagd+CIz9JuRFo8tQQGMfFR8Ycg5IQTFHfcs+F11Uv68mPugo4QnM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB7940.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:410::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 16:04:09 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 16:04:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 17:04:06 +0100
Message-Id: <DLZL1MN4U8O0.2T00KH5YBSGWN@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Yury Norov" <ynorov@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>
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
X-Mailer: aerc 0.22.0
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com> <aryYkkB9j14xnWo3@yury>
 <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com> <ase7IBtZjQsPVWSN@yury>
In-Reply-To: <ase7IBtZjQsPVWSN@yury>
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: e67b0a85-f22f-4016-2fd4-08df2555c943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|4143699003|5023799004|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 1mL5ZWWxKdRd9I1fbHlid9744xEZNgnfghgjP8qfucGuLMGPSi5ZJ3nRIqKumQNkVIbhniJ8NopmhKRfhXhzeO9pvxO7XlW5GjVFp+yNeiwEeU5MK1x8MJv/PPgNXYUwivMflsQvEYLgKYSJpzkgR7WqScoGkn2RI8Ni0uWPT/f1Vc/U7sokHR0WD7btOfOc8dBZe1iqWyv1Vs4Rsi4bkPeRvvQ4pVlxtYqF4bBJUPoNsBcpxxkMNuozA9F+X0rJLEaWYpvMe2bH1ZevxcleO+iF2nfwCRaaTO2AwmASd49wyNftgnSZNNlGVCTVaRhgMZdWIGEH+wwMYdxl8hLHSD6LrEUmc1SKKgVVfBPklrGC+PoWze8ZZgmy9H0VLb3V1itlki22e6eUx2RBNBPlsYYtNxMzJLj0Dg8tvOg70JwgAqWz08fJRgVeR3EoyU+nadqEdLex2T3DDKnYM0UkmmC+KNGf6Kk6yC8lsPSDbqC+suW7yRJCGWMQfrniz0AatXS3c64/gUMsqsM7U8CYp5MkPzj/oHA2pMR/RoC0Geppx2sH25P8fWSUf4I7Cfrb3TcHUGKgbdBpF6IeGju+yx4u8NcWNNitVuGNr00JPngBRUCR0wHOXpkChthhV7oj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGthUDhyZS8yOWN4QlQ3eHNhZ1VxYkxmU2F6RjRoMWpEa0NUVzlmckI3bDY2?=
 =?utf-8?B?emlPbDUzc2hicXIvK1hscFV4blhtQVQ3d3FUN0duMnZCTC9EYmhFYmNTczBJ?=
 =?utf-8?B?QjVkSnY5UldLS3VMeGtrUHFySHcrNmluNTE1L25SNXpMTWc3NjRBcklJaEYv?=
 =?utf-8?B?OFllRFdwVE1nZDI3U3NEcEh4R2c0SER2TlVlWkQxY1JmNjFkbktZMmlydFBT?=
 =?utf-8?B?MEdJcnV4OFJrY3I0RFJVbkNtOUpqbkF6b3FjZ08vWDlqRHM1Y0svVUY1czkx?=
 =?utf-8?B?RHBJWjBCZjRHU1lQUVZNdEw2ZitOQWZIUHpuRUs3MWIwMk9USkcwaWZzSTRw?=
 =?utf-8?B?OEk5V3A0SmdyWDZvNzV1N24xTWhLV2ZkdkZzWW1rai9oMlZpaUs4dzNhTldL?=
 =?utf-8?B?NSsvL0tuVzZqTUNacEZ2cDVTRG9sSExaVHczaGh6MkV0b0s2K3lLZUNCWDkv?=
 =?utf-8?B?MnB2UzdCTFNyTVdZeURWbkxVenV1OHlDV3VHNGdRYys5dHlJZjBMYVdITVdQ?=
 =?utf-8?B?d0txMDZxaHNlaFBKZzF5SnFXdnFXNkkzRDRMc3VhQ013ZUw2dm1RZEJ4VlJU?=
 =?utf-8?B?MUsrN0tkekJ5S2EyS2crSnlMUmFOTy9hSGpqaW9HWU03L3QwclRHeE9Qc2h2?=
 =?utf-8?B?QTMrblhoTGVhaUNBR0dKV0dCRzVwU0ZqYjNFQzZaYkpMVUxtWmtjVTlVa2xs?=
 =?utf-8?B?SnMycHJ3bDNnc3RURU0rQXhuaWpHRFJ2bjlxeTR5SFhLczROTG1Sd2JkaFBC?=
 =?utf-8?B?MjdFSWt0T0xjY0hUWndXSktrdFM4SklLSWRtQnZPVi9vVHM4SEZPVUJnb2Fz?=
 =?utf-8?B?YkNOdW5GMStzTTlIb1l0S0lYSTZZMjJXWm9pczF1ZHpNNXZzT2lPU1g5RTh3?=
 =?utf-8?B?V2o2SE82WHY3ZTFid25ndTUwTy9iWHh3QzlZMFFEei9YTGpncERqV20vcUdM?=
 =?utf-8?B?ZkRpRkxKNSs2dm44SkpHY21EQ3pjNXE4SDZ3TlNUbVpPOUZVdjNOeDNMaXlV?=
 =?utf-8?B?WDVWS3VlY3g4cE1UVGlIWXNoZEtXdE9XUzY3d3Y2NitnU3BEelFvVWh6Zjgz?=
 =?utf-8?B?VXEvYmtLRFBNQnpPY0FZVEVESXlDU1lIVy8yTE9SSGxmektWSG1Qb3dTRWZi?=
 =?utf-8?B?dGhuN3ZSbVc5R0x0MUw0ZFUvekhUSFJLamUySkVBQnBUdzh2NldYeWxsTDJT?=
 =?utf-8?B?aEcrSFVDa0FGc0orQTh0a0VLQTlpRS92QXdPMWN4dGJwTFNBWE9BWVdJalpL?=
 =?utf-8?B?YjF5NXI0WXdMaFU2Y0VVYS8rc0lKWE5xd0dSb1Ftb0k0VE9aa0xTc2kxaVBp?=
 =?utf-8?B?d0d6OE14dEtqVFI1UDU4SCtwMGhHSHA4QWhGVjRBc0VtSTlYVVlHV2xkU0dj?=
 =?utf-8?B?NkRLUkJITjJTMWYrQWZnZWwrUnZoUEJBL3ZWQUpOeDdjK0NoWFAwSDJNWDVn?=
 =?utf-8?B?Tjc1V3BWb3NoTUlRQ2VyNEZZczljVHBOcFJYTDR5YmNVV0dXbUUvUzdWUDFv?=
 =?utf-8?B?QnZIUnZ6TVVqeU5JRGxCczFyTEo5aDN6SnlCTDVNWmRydFBpOXhvMlM0ZUtM?=
 =?utf-8?B?VUkyQzJOYjg4bzIvUmFyQTVzbmJHNmpIZnRtb01xUTFIQlY3MEN3bmNaaTBG?=
 =?utf-8?B?VXIvQ25RZzVPRXZHRlBoMXFaUDFnK0xTVTI0dlU0RUxNazhSc3R3WmpYRDlX?=
 =?utf-8?B?NU5GenkyNGEwODNKVnB0RXZJYnd0dVZLOVZ2RFhod3JNU2lWUlRFdk9Iclhp?=
 =?utf-8?B?VUR5ZFJGSjdJcWNRc3pGczNHR1dycUlUNHRCc1lLL2NGeGM4WHJhMnJuVXlv?=
 =?utf-8?B?cG9CUU9xNVROZW5EWGhTWnJlSVh1eVcwQ3dlUjFUTkFpQVg0Z29TVGpSc05y?=
 =?utf-8?B?MEZCQ0dYTGZTMUNnNWUzRGhuRGNqNng0d2R6MWhnZW9adTBDS1JnZ09RSWJJ?=
 =?utf-8?B?Tm9sUFFySTFWOTc0Q1hiMEhLbVZ3eU5XZ2ozOVVPNmo2YjkxT3VTdmRVcHY4?=
 =?utf-8?B?b2dyWWhrUHJadzU3QS90R0V5YWNlZXZaUUd3TUx4TjlESytVZTlIUEJGdUpv?=
 =?utf-8?B?MWRwSytzMldRa01FWnlUdloxVUExT1IzZjdpajJrTEZCUnJtRU1peTBPT2Fh?=
 =?utf-8?B?cG1Fako3QndZMUhFbjBDSDBscVdobUZYNUhPbU1oSXBpZ0JLR1h6N1BzMHF4?=
 =?utf-8?B?Q2c3WUNIY0dvREdNSzloTEp1aGFsLzZiMTJGRVJra2d3YzZDNkVlUGhyUFI5?=
 =?utf-8?B?RUxDWW1wUmI3d3BIWmQyS1E2bGhUMmxGVWp2WVRYOTZhazNCdFBIV3ZselVP?=
 =?utf-8?B?LzFDWVRCTkpWL255M1hXMDlaQWFjb0hnbWxIMkd0eDFwS0JTNGltQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e67b0a85-f22f-4016-2fd4-08df2555c943
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 16:04:08.9905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJZBYckERhUYTaY2db1xR3Nawbj4cM3gwkW84/1axVnXSRMzhVySvGkKzRsyyHf9kEOxoC4oelqEqWsN4wr84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7940
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

On Thu Oct 8, 2026 at 4:47 PM BST, Yury Norov wrote:
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

A bad historical design in C standard shouldn't be affecting a modern API
design.

Special casing 0 as a size is bad, because all code would then need to care=
 if
something is 0 or not. Imagine that I have a code that want unconditionally=
 put
a generic piece of data to heap via `KBox`, I should be able to write
`KBox::new(data)` directly without having to do `if size_of::<T>() =3D=3D 0=
`.
Special casing 0 break the nice code composition properties.

Rust standard library does not repeat the mistake in its allocation
implementations (and same for our in-kernel allocator abstraction). All
zero-sized allocation are well-defined to return a pointer that is valid fo=
r,
well, 0 bytes.

In fact, in kernel we also did the sensible thing -- make 0 byte allocation
defined. `kmalloc(0)` is not a bug and it'll return you `ZERO_SIZE_PTR` whi=
ch
you can then give to `kfree`. For `krealloc`, both reallocating from 0 to
non-zero or the other way is defined.

Best,
Gary

