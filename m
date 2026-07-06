Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9999C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F40410EA49;
	Mon,  6 Jul 2026 18:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="VvEyh5bp";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021093.outbound.protection.outlook.com [52.101.95.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD5710EA49
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCakoiwTH33yRX+1KJiBfRiNQJctZflayO9Dt42agHWJ6nVwj8nyTs2IXeKXFAsWBBM8MLp4JLqNte1Zr+HSseqYYWdPXuZSgmHN/ZGtiPlMJK3oFkjzvsXo/5Rw+0nhYwcEKdt1EPgtMRlApFOH5r867j7Ca49mdc/8sUCe5jAXwLqRqybtjO8kuvSZonuYRDyXC9bX4XKOpWmlC5Pq9VGU1KMzfLZ5dVRUPY5fTRqPEhD8f1s0eYrWN5SjL4LFGT3NEapJBYqZJLYbywFPKxxKC6K0hIUjKHVZeYMOP7WHR8p6VF4fICGK+e/uNcn6tOCzHgjj5KEC5v7HLgo2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmiXcDPCtGUxXlb7b+bESjPqykNUCTr4/wfrpTx93kc=;
 b=JOmPg0Ba0RBuql6RvSeTTLcOjycXcBlOFbi4+QDl7xJra6jONfOMvNuZYnvfT1YmKasyAGuIIbZFrQ+unCsQ3oRhVEh+yANj/Grw7idr2E05X70gDzbX04k0ONbhRrZOUBJDsToHVvdJGEK7y9GLr+tevCrIbSeI8JJ05wwrbkNm5nBSHMe1Sh0fTHXBXeCYNAT6oBTJ72aXcx2e4S3cJuZVLQ/iya8mtrP9FxLnLKPN3nr6gyKDy1oPSABqL2/mDkok10Q+POBkoNLtLHhtpx6dAMdh15PGsTHSQPakwnaXnULPVVnON7ecSHNT10zyTU87HnOprYg7Snc1YIiKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmiXcDPCtGUxXlb7b+bESjPqykNUCTr4/wfrpTx93kc=;
 b=VvEyh5bpvPXIJoDqDv1oBEm21s488BnVSm6VHotszmIFUbaDjBZ7WkifzeNwyZ4fZK/dlecu/LzY4qbswHWZBsHzjvnwuaU7x47gd4KdTDm19M3SLJw56o7GI9sGYe3aaswiVPi9QroWorgnbMlIkrxWwVuiTZrbM4EdPdUgkyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6418.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:22:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 18:22:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 19:22:27 +0100
Message-Id: <DJRP4CD15MC5.J47HDEUJS7V1@garyguo.net>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Burak Emir" <bqe@google.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/4] rust: bitmap: add contiguous area operations
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Yury Norov" <ynorov@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-2-84fe8259e46e@nvidia.com> <akvXzPd169ahMuCi@yury>
 <akvkNuh2bHhFwmQM@google.com>
In-Reply-To: <akvkNuh2bHhFwmQM@google.com>
X-ClientProxiedBy: LO4P123CA0201.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a4d432-8177-4dfd-bcf8-08dedb8b8914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|376014|7416014|5023799004|4143699003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: wk5JY5xgMkaC6hHp8a1co5JUdOTTZ3ueJMXtV5Ut4UpdHEQBYA2bcNaWsJg3uWExvdtUac6cxKjny4cCNvQsoGQm/N2g6xlvaKls8lSaJeMVJRvS5z3WKYBNgXWorzkwJbQd3CETNu44JcaLWxo1uMqKZX6lqPaw7jeeohUGKiUf6ixDeohURovT71YUkr2KwFFrWOeJms/7NMUHhtAQoO7ZWVPdFClimFDIgPZwFR3SuzJ80UBLeyqJBhrbzKJpjTW60ahsQEVhAI+RAf5qrx46kpb3aWJu4VAKvC6jlSYDwkKJdjXBdAWNF0cw7FsHHUYFi/g6PH0AgCBmfYZfuByX7J/0Mu5WBNwrEEzVVXtSYbcGW3Q1c0coJs1nhqkfPThQ3A4YiGXBtufr3wMBvgv9w5sZxb1u9pkcjRvTbDmi8VidoiLrs+1FBcwLVCWNkdFGssscoEbaYV4//8vcnoHyzXeUXX0w0DXeY5e6jIZjZAtId65JQHaCpf6rxJcrFzOHrV0UsyaoamqLeucwgAmWZD5hzvnAejjSj3eFKsKRTjjc627YeZfQEQdNI0mFJT9fGDBD0Z98yPMPjmbD+Efd1VY1dBZHAXkj8LdxW6uuA9n/m/p4yp2vLpuhctN/gzhCO/gIJtE+l0j9gg3c4pfv44cJkUGSW1lhiosfSRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(7416014)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVUrUGpVMG94TUt4Z0JoeExIbVZRT0dxMG9KZTZjdmxwWDdINURiODZnNFJ2?=
 =?utf-8?B?SEdtcVE0QXROZGRIckFzRllBRDVsVk9VSkZwYlZKZk4zaVBWZytBbTNTcW05?=
 =?utf-8?B?c25NNUZDYnFmU012aTRHRHpKbjNMZy9yclIxSlc0d2xSWFlBMVZvdnRRNFE3?=
 =?utf-8?B?M1BwYm95T2JaNFlkbDhMUVUxZzdlZFpRcE5MWS9XclIvdEVZWDBRNytzTVB2?=
 =?utf-8?B?L3lBc21JL1ZsTUlnVG9jNXkxQlE4c3p4QjVvckhMNFQxS295YWltOXlrck8z?=
 =?utf-8?B?Ujd3T0lNcmMwSmRBVmYrdHlyOWMvYzRObnhmQ1kxVmdic0RVZzIxNUFjTXl6?=
 =?utf-8?B?ZVJkR0FIamsrU2E2SUlPak9GNXpjSnVVWjdwOUJ6eFBpeWFFS01MWnBoOUN2?=
 =?utf-8?B?RE95VmFsWjB2bkNyakpUMmNIRGE2VjRGeTRLdldOYWVIOXUyZzhaa1k2WVE4?=
 =?utf-8?B?UFh3VFI2dnYvL3ZhN2xaUUFIbGZnMXR2QTViaUJpRDdQQ2MvOHUwSVUyeldW?=
 =?utf-8?B?Vms0T0xtQnRzWmI4Z0loNEUzZzdaKzZuTGEwZUhvUGRWZHN2NHZkb1E1dzZI?=
 =?utf-8?B?eVJpOHN1V0hSNENkQU9FSGlBdnN2MEdscjQzWDM1ZXN2c3B5RWl4clFwdGxk?=
 =?utf-8?B?Slc2TE5PelJXMXMzcXgzbXkyaDh5M053VmR3eWNMMVdieDdxVEFpVVA0aS9L?=
 =?utf-8?B?VUZESUJBclBPZ2xabjhoZjRUeGFPemEvS1I1ZXZkU3hTZVp4NU56c2Q3bXpp?=
 =?utf-8?B?eEJQUEFCQS90Q3VxM1dvUjlnYmRWZDJEN21naWova0tFa2tUZlBMVXlkUURw?=
 =?utf-8?B?dTcySjV0VVZlMnY3dDNIcVZEMjlrczJWdk4vYUFEaXZEd1JmdlJqRXRDODFt?=
 =?utf-8?B?SklrYjN0ODVPb2hCeDZxMmtPVDd4a2xGWnc4YWVKTzZsTEhKV1cveW5KVjh6?=
 =?utf-8?B?RmI0K29ycTdIOWdLeFZIMzI3Wm1vcXgwR21NNWh6TjhJSnB1Uk96OGpnTXh6?=
 =?utf-8?B?QUZPd2tISGJST3kyWnptMC9rd0xiQjNvLzFjSkF6bDNtMHVnSGpIdFRvMENH?=
 =?utf-8?B?eVVrS1hSWlV0azRNdklRWkpwTGtCUVl4d1NsL0dKUTRIU2g5RXlWaENtQVNq?=
 =?utf-8?B?NkcrSjF5dlYyZHlkdCtyREE5UFRWU0tzN2t4d3BENkZ5blRzbkNQY0l3TzI4?=
 =?utf-8?B?VElKWStCMjRHbTJHWFBRcjJXS3lVbFhOWXhqVW15RkxWV09pbWFjTzF2cTl2?=
 =?utf-8?B?TzQyTHg3UzJ4SG9QRXhjeUNnODhYQkNqMHU5RldXdWtJcmE0cFBSY3RRKy95?=
 =?utf-8?B?NjVobUVRaElsR2RiUzNneCtkdWg0UVl6dnRGZFRLTmYwUk1lVVpZcVZ5RjUx?=
 =?utf-8?B?ZFY3cmdHWjE5MWJhZkE4R3Z3QXUvalM4VEdNT2hnbjB4VFpTZVVXdG9Vd0Q1?=
 =?utf-8?B?L1RWY0xaWWJKL1lzTHMvQU16WDJyUmYxbWE3WTRHc0JaMU5mc3BVaEFkckZw?=
 =?utf-8?B?ZUxOakRpZm8wVU9GWG0wNHBTZUtOTDBiUVMxRFN3MG50Qk5aUTExMHJLYjlZ?=
 =?utf-8?B?QXFtdmQ0Ym44MjFFSHdHMHZTUndVekc3aHNRVnUzWFhTK2VxWXVqT2k2Y1FO?=
 =?utf-8?B?U21oWkNzUTRCWm82ZnEvYlFLUWJSd1BwRzVTSjIwTGpNekhqTCtMaXpyOW9W?=
 =?utf-8?B?dEtHb1NzMjM0WUthc1dQYWtJa0graTh1UFZBckhyTnpoTlRzUFVsV3M5K3du?=
 =?utf-8?B?bHpuaVVHdWZlRmlJaURsN3M3bVU2YTg1WUdZMDJ4TWhaTHFrRXBGblFsQWVC?=
 =?utf-8?B?OENpR1dxU1IxK3RmR3JiSzc5UUhFQ1VIWDRZbUxEdGY5TldxQXBCenlRUCtp?=
 =?utf-8?B?ZHZQUWhCNGg5bFJFWFcwVS9Zd3U3OGp2QmpTRis3Y0dqMEJ3YkdGODVKQ0hk?=
 =?utf-8?B?RTJ6aGNXMnNmRnlxbjcvYWttYWlZUzVVVHRMNm5uMmRrY01HRjB5MDR6K2VN?=
 =?utf-8?B?ZEdpdDZzRVFRM09ZK2dmUWU1TXpybFNhK0JiNWNUT2EvRDVZS1pjSTNlSUd1?=
 =?utf-8?B?ZFc2d2lqVUwxb0Nuc2UrbXVBM0c5YjlzSlBuWmhaQWg5K0xzQTNmYmRtZVdk?=
 =?utf-8?B?N1UvUnFEWlQwNENRQkd3YVVvazVhM0UrN29nK0FtbzAxeVVtOG1BRHZ5OHlm?=
 =?utf-8?B?d2tBQlNpUERqdkw2VUpiYWNweGlRRUFodkdRSEtvdDVhR1QrQlBSeEh1V3hB?=
 =?utf-8?B?czBLdVMzazk4dWkrbHAwWElDblVmYW5GRjVmaWRSOTFuYThUaFdaTG5aRlZi?=
 =?utf-8?B?NkFhWEU3VWVTWHVkUWdMVlZNdnl2ajVMZDhFZ2l1UFJ1RFB5Yy9uZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a4d432-8177-4dfd-bcf8-08dedb8b8914
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:22:28.0808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ap93SNwGlweT5mEC83bMgCr5jpj9wWWC8OkxBLmWlDnySCDlXNls7Xkeg/pLLgJYQ9ZjOPDADsc0yaQoqCVWJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6418
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

On Mon Jul 6, 2026 at 6:21 PM BST, Alice Ryhl wrote:
> On Mon, Jul 06, 2026 at 12:29:00PM -0400, Yury Norov wrote:
>> All three are the wrappers around the regular outline functions:
>> bitmap_find_next_zero_area_off(), __bitmap_set() and __bitmap_clear().
>>=20
>> The inlined version in headers is optimized for small bitmaps. But the
>> optimization is all based on inlining in the C code. It doesn't work
>> if you wrap it with a rust helper.
>>=20
>> There was a discussion about the similar find_next_bit(). The function
>> itself is an inliner, but it's a wrapper around the true outlined
>> _find_next_bit(). So we decided to minimize the binder size for that
>> type of functions.
>>=20
>> Please, keep the binder minimal unless necessary.
>
> If we can just call __bitmap_clear() without any downsides, then I agree
> we should do that, but we actually do support inlining the helpers now.
> See CONFIG_RUST_INLINE_HELPERS.

bitmap uses __builtin_constant_p which will only work with pure C inlining =
and
not LLVM IR based inlining.

Best,
Gary

