Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FB5C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 569AB10E371;
	Tue, 21 Jul 2026 14:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Q/o7e8CS";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021119.outbound.protection.outlook.com [52.101.100.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD83210E371
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 14:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCRcyNbpwsXTLEyiLEUOSEkaPZyKGcHGQBHK0VmyO3/T6RJStoDfLk68KzdZIEWGoi7+akhQDT44BMNdV7NP0WSBYd+TwU33PYlf6JCaG5AAAHLs6hCCPOcbYn71xrqXzCxEytEPgVfaeIPezV9C7CqXA436N7k4kbdHZHOpd5mNC4yyM0oFxb9QJ0ZuyL0/BvaPGxG7RxWCAtTmI8QdtgdDMyMlk9ykeEX6If5/YEIa5tT9nIca1NgIiej+6UbejdnwSel8eRBtc8fOCE6t+hV1FwNVJRPvf2zyJ+2BenkbeZLeANp3vJcOWjSj00ce/ZJ7CK+nMb20h55tOJpUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEbD8ApSEtmO/zUJAWSBLSzxgP+dqJKLNrfsOE1KxZI=;
 b=JG/hzCFdaklhkwherlBgsl4jURbEtBvsRnk00wizXjhyzEHvjp87ExWFXaIvlxMs0OeWlQ8JetHOkuHArhR0IkstVpw8ijJWkB58ZDLL6Uhv+K3BxuMqRUAmeIJ1yPLUV306eehAutrf2Erq9qRhcjdp0sKChPMlCHKN6+NZx7/03XA0CzWf1tEmxO3XeImJH1tml3yq0m4GdAemloEsu8SmFB1Iqx9OBdBZyO5s3s+i/EpBTa5JdVu4dtcXQ8OyqQ4NT313jDntlrqnTE0RAQG5YZofOF4emnpHLSLTYVCH1R0Vci9+x8m2Ti1Zf1VCEIbmViOs6frHOk/jHItZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEbD8ApSEtmO/zUJAWSBLSzxgP+dqJKLNrfsOE1KxZI=;
 b=Q/o7e8CSAbzCE5tCU9qgoeNGTTXCGqVD3EUbm5CdFjZzzj72AVvDdbJik46zqOh1JWEtC8/96PgtlH+x+MPtsDtpB5M/5GNg7h5YZs/YOgsXuy8FI9LuBC5WVtLdHmNBLZFgU6PEl7jOWDQ2ewDL822jS8GajnRsS/MUOGCs6VI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2568.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 14:24:22 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 14:24:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 15:24:21 +0100
Message-Id: <DK4BG7QQJHSK.2Y29AZBE9N2PQ@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/8] rust: io: register: dispatch fixed array shortcut
 internally
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.21.0
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
 <20260721-registers_fix-v1-1-3711b2317e1f@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-1-3711b2317e1f@nvidia.com>
X-ClientProxiedBy: LO4P123CA0341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2568:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c95f005-ea73-4f65-7e41-08dee733c223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|7416014|376014|1800799024|56012099006|5023799004|4143699003|10067099003|921020|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NFVXwsp6CxXM3NBNVmhzmRbcrMAABzJ/5Z6kTzwnnv3eILmiu9yHrk2MTl7N8k7bQjBaNKeH15NTMcnj9w8Yw/S9p78eC53GWqbX0XgC9QkO4znQAswqZF34vKielEXS1nfUag/e5+rbAOuRfwmmM8Xz4DJ6FVauMLlsAtDXdBO3v5XXu3iEAWWIYRmenKx8X8PCVwUEOIzXoZbuTZjuv1jp0Ep5leBQe6RW659R9IYJ8AaSdPle6HIQQAS4/SPnhq6RfMFmoI3BacHC01YZ9G868QHQGCm/Ha126pit+lQRC/kI+46y+DGK+FdKFw2tY6XFVfGQexxSMCrFqI3yki0LoJH9xUShqtpqcsf1UKTVLwF+h5uGrQjTfD3VwN2ogW+VG7gfa776VcurCIXT8vueyFn9AbBwNLOnE/it33k6I6Ly1QY8FwgHVb7Jngvv5H6O0UABIOnq2MYfprC/fQWPYjY79RjN+G8YvuaddipZDbJiPdM56V7XrkcBoB7pYNqGhy5Abo9bI9+1IIBg/O4PZ1tmKOkB2+MgRG8Hqgsw3qYGhFhaADpCnEvcAg3Q2dPHZ+4B+RelF648Q69zVek5ufCxGoloICV0FMhauXza1RcjRPyPqDaCzSG3GiaT/TUZisby0xo0BUgbStQKWOB4NtN0WryjehuQvazXj0+KVAowuCH6k26LakV+1a4DOOlp59Y29hY58dVKVt+3AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(7416014)(376014)(1800799024)(56012099006)(5023799004)(4143699003)(10067099003)(921020)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpUR0hDY3ErQW00U0Zta3p4Yk5jWWVYOGtCSmtFWDRtWjlxajhMMDlzRHVz?=
 =?utf-8?B?M3VLT0tRMGs2QWhnWHlQZGNCNjBYbFV3UEUzWnNQVHp2cjBSMkt3RUNoNHRw?=
 =?utf-8?B?TkFERElkeVpDV05nQnNERUwyQi8wTStCS0ZQL2xWZmg5ZVJLV2Z6Rm1TcEVX?=
 =?utf-8?B?YkwyUGQybjZHa1ZkWDN2Q2laU2NVYjdLZGg5TnZGMytxVW5YdmlTcjBZcW9i?=
 =?utf-8?B?SHZ5T3VhMU5lR0VveFd1YU0xdlQ1SE9KcFZ0L0lpdm9YbE42T0VlWGNOZUZU?=
 =?utf-8?B?QjVsREtLTXpIdU5yR096QVpyWlRnYVFoOVVCdGU1SHFnWjFZZzZ1STcwRjlr?=
 =?utf-8?B?Z1AvNm9ZNGo4SXBYTHBaOGM5WjJFREgrb0Q2cDhqdTZMSkQ0QjgrVlJ1Ykl3?=
 =?utf-8?B?SVlwWUJJSW9YYWZjYkEwU1F4dkQ3UFY0MnF1TEFsaklwY0dDeEZXNDQ4b3FE?=
 =?utf-8?B?S09QUVBsRlhKbFZtbk53TWZTMkNpN2FNVUdjQTZSWWxYeUVGbVNPMjlCTTBB?=
 =?utf-8?B?NDVRcmE4ZURlNHFkdTZCN0JhOVNmYVhkQmV6VHNPZ3dLVDNPbUZia3V1Sy9K?=
 =?utf-8?B?VFpWM01za3dJYVBLUW8vR0xEMko1M2dZS1ZUR084MGlzRmR4WVpjTllpSnVs?=
 =?utf-8?B?cnA0WmgvNFBjRnNETmo2UHQ1OTRZN3dlQmYyKzBtWmVNU3VYS1k4OHQ3ekFX?=
 =?utf-8?B?bDVmbUEvQTNEMUhNU3BuR3oyRUhNcGRMWElGOFI3MjBqSEFPNExyU0VUZWpO?=
 =?utf-8?B?VXB6dy9qdVpKRmI0OG00UzB1N1p0bjZ4cTJHbW1SRno2MXRnMHYrZWxWMUZ4?=
 =?utf-8?B?TnlvK0wwOE8rb052MkY1UkRBNkFkSUZMY0VBTFY3Ti9oaTBGUEp1RUkrT0xx?=
 =?utf-8?B?ZjcxTUllQmZZL1ZsbmdySkRQREdPQVpNQWtaeXVEOFk2emcyRFJlZzd4eVgr?=
 =?utf-8?B?aWIvUXp6L2hzT1c3T0lhMFlOYkNKNm83WHRvdzQ2REgxQWhNcDU0SkpCVnZQ?=
 =?utf-8?B?ZjVpU0xnQllZcjVoZTVFYXJ0TWpneFV0WThzWjJqVS80RlRscFNwZ2NXRXJM?=
 =?utf-8?B?L2xRcUpoVW8zOW1yemxMRWQ2N25vODRUMS90TGd6dFlVY0k0cE5sWkx2cHJM?=
 =?utf-8?B?dFgrZGlQTFk3UjFOT09UL1djU04yb1c0OXc5MkVidWMvOGk5aitPU2xZWkQx?=
 =?utf-8?B?K0h4alU3bGNZZjNrUmcxWWZteEFMcjV2dFY0ZkRGQjh2bDRXd2pIVXk4ZDRL?=
 =?utf-8?B?WFZDanArckt4Z0cvdFJtQjBZUW9kdXZ5bFB1MjdiYVp2SlljY1Y3Wm1VWHFs?=
 =?utf-8?B?OUFjM1d2TlptQnphaHRNRXV3bEVMZm5WSGJrUk8waXNJWElUYy82K0luTkg0?=
 =?utf-8?B?c2hlbGU3ZnliK1JvMWVLK1piMktsbjdrU0I0Tm11dHdxRXJrK1pBUkFuZWdp?=
 =?utf-8?B?bzlwL3NRUUhHMnBoUmYwZGpXbUxNWEdRejJIYXVFdGpMcHFid1JlK1ZoRXhj?=
 =?utf-8?B?T3J6WTNvM2RuY1J2QlZlc0kxWXRjalhyOXlyWlp0VU5zbVc1YnBvNjBZbmVm?=
 =?utf-8?B?WUxKNnRWeFp6UElrU0NrekV2MExPUGxsQldERmRXbm1mMm95aW5pNFF0NUtp?=
 =?utf-8?B?T0k3K1pvaHpCS1dBYlJxYnVzMTArZkpOVG0vNmxVbHlnUy9CMzJ5RThKaXJX?=
 =?utf-8?B?NU0rQWtBVnR4RnR1aG5SZ2liR1JRc2FMNHZCWUM4YjNkelV4UTZBci9melhh?=
 =?utf-8?B?RSszMCtCOHJEQkxnYzEvRUZJTnExT2ZjTjhjN2E0M3JWa2REcTU3aVFpK3NI?=
 =?utf-8?B?cjRtUlRhTXRkQmlXNU9vZ0tIejkrRDd5YnUxV1dlZHQvYmJIc3MvNWorTHFm?=
 =?utf-8?B?N2ZPYUtuU3lTaTE0UGp2cHJmcGJMYzNqejc5RU1Udkt3T0JSb1BxQWdORUlO?=
 =?utf-8?B?N3kzcDdzY1g3aS91ZnU0cmxSd0hkVDh1Unk2eWd1VW84am1kZlJQbDJqektL?=
 =?utf-8?B?MElKNTBoVG9ySkdkK1VMbGlxQ1VmMkdBbGFqUnJLbWZtT2QzWU0zQ0V3TGVw?=
 =?utf-8?B?cDdtdUgwWnpNYWRaZXBWVVpEbkhkaENiOTIwT2lVT05pejdpYWlEaG4wNlRP?=
 =?utf-8?B?WU55cklDcEFIcmpNZ1hQZ1I3MUdqZTBTWU5WeGNDclZ0dytQbTJWOHpReDVs?=
 =?utf-8?B?b09RTVlCdE0ybWt3RnFTV3pSMmhJSDAvWWk0Tk91aDVIYWRlL3k2cXhIN0pz?=
 =?utf-8?B?NWwwYzJYV1ZwVWxWYmwzMTU5OTltcmhGQ1dqWXYyWlpTMG9CVytsVzlLVWwx?=
 =?utf-8?B?OG9pUTBOakVFVzRhMkoxbDNUaXA0WFNndnNuSmE5cTZRNnlTZzJuZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c95f005-ea73-4f65-7e41-08dee733c223
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:24:22.0667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfqWW3O3yJwhZXan+I7yxNMCipv+DgVZsRb/A6SkC93W6/TOqEUOu9WM5wD8++z1G7wqENNljMpdSrVktfZrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2568
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

On Tue Jul 21, 2026 at 12:00 PM BST, Alexandre Courbot wrote:
> The contiguous fixed-register-array shortcut redispatches an already
> normalized declaration through the public register! entry point. This is
> unneeded - the public rule should only be invoked by users.
>
> Dispatch directly to the appropriate internal @reg rule instead.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/io/register.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index 80e638a892d7..27a9fe45b06d 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -888,7 +888,8 @@ macro_rules! register {
>              { $($fields:tt)* }
>      ) =3D> {
>          $crate::register!(
> -            $(#[$attr])* $vis $name($storage) [ $size, stride =3D ::core=
::mem::size_of::<$storage>() ]
> +            @reg $(#[$attr])* $vis $name($storage)
> +                [ $size, stride =3D ::core::mem::size_of::<$storage>() ]
>                  @ $offset { $($fields)* }

Actually there are two rules that misses the @reg.

>          );
>      };


