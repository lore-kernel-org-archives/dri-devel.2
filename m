Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E23C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555A710EA58;
	Tue, 25 Aug 2026 13:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="vkJxHMQI";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021072.outbound.protection.outlook.com [52.101.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5431510EA56;
 Tue, 25 Aug 2026 13:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMki6qEFmQFeS1d5qOgzxD2h2e5+kX0OPc0a7jBvKHVanp7pcNrS6VQc8fJsByfOfotkl7bEDHILrXB3fKAqZ1DCkMOQrypwFnf8MXYDeUixT89eH+CHzAepY7kwmDcDXiBXBHwlSxvIEmOmjifnPOhO3nuhSXGNbQXwTW+lP7re8NIomNojOMXlJmYc5O0koj5tqlN/h2+ST0l07FG+IjuOM1ZwQBebZT+7Q+rPfoceAGWZRIDTuOKS59OEyKrq+otKKt4/euaERP5XNeCxrUP6Q09lXsXGxeHArU2CZwAKHwiDA8zPDqac2LM47fz5goD6BzwndeimyePpCtRIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kgpkc5Oz+g22kmTJySZZNUwePn8cRKmv7kgAdmJIXc=;
 b=X1UirjuQ7JRJ8vRqTKoV2bPAmsacq9KgvOIdsXST2c3Fs6x3/QYsYvZ7LN15R2VbyD+1AJG7KkPo97S8WCMqQrf++au4k17QBmpW8eZjvR0pfyA5QQm+BmrAvCUwfIATo7Lbj6dLjNc/FI7IF4FGe2IpPIYjotDfWHaFZkRvR9QdmNPDRTML4FET5Emw/hr1Kv0j8hol4pVU6XIimjTqig2O69VrzpAWxrbkFTOooADZKstelidCZ3iF2tq7H+d0l0EMd4nU/auUVM5Tl3SBfKxq6HerBGxJ+2Q1FaS/G/YxoiQZ6gqcy/w0KABAASDbPKtVgDe8KA19SbIVUpIpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kgpkc5Oz+g22kmTJySZZNUwePn8cRKmv7kgAdmJIXc=;
 b=vkJxHMQIXtnjUfY7fV5LyhFMSv1DZplvq90R/o0XImCtVlZflLk/KkEDzTLWmQsblynmLQps2g1HL6jR3bF9NCvnTIzA89hFBputDaD1U/iqn+oblppfMIsADlklCnkp3qOsHLXu8/xyX6j3PaoWHdRKxD1yD2s7Il0s3QmfgB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB4985.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:19a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:31:53 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:31:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 14:31:51 +0100
Message-Id: <DKY292V0LWJN.1L3HG02NBW6K5@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 5/6] rust: hrtimer: document deadlock when starting a
 timer in its handler
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Jani Nikula" <jani.nikula@linux.intel.com>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Lyude
 Paul" <lyude@redhat.com>, "John Stultz" <jstultz@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-5-90411c6217c7@kernel.org>
In-Reply-To: <20260825-expires-v2-v1-5-90411c6217c7@kernel.org>
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a5e661-8b32-495e-21e0-08df02ad38fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|921020|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KvA3HAVOtE0xVxQr/ToZdkNE+K5R4323TUaSOCIJ4B4aKKHbZCyGRafoge0YdIJGr6vOhEzp7NlHn51/pyFBszUGiYopKPoD940dOlPwjLm7pa/lXPhN9xUmGxlaNrPQMR/as+XDhTnJhUPz6MeAVdtolJ+p+51XZOyvstvrRkdmoxorEKjADq8pBvQ7RT5tYGOs/7VVDb+oe8UlEzs+LaxE0Hsz7g+VkkQ+1vFsQHWMCMMn3SIxcmYk1sfmOotqlLUbP6qWFm2DCIxx9UteCiAkdggAdYjdDU8h4dtWOWcPxX1faVd0PPZsljRXeDWXUJAhge/006I8B76dZZP2Xw3y1/+YWbuYFSluwqJd6X0+RmYg+mHpxl6j/ZVK0WBJK3/UxJefeU8577UVt9t8+f9p+SBTqc4h/ReCItm9Hd8Rapwv8PkZ7HxJ/yUVfQCrUA4Ng0hj9poRV1JX37X+SfNA3kUPsHdchCxvsTQkLaB9v/B5L+NRIRCWocclSk2+5re10F32tEtbxdk5e1URdRa0y/oouaNEWcVT1ELYWAx+JJjn1QkwXvngETu2MQLiJocnvrMUuoCWr5XPq5IUqDdM+K/OBhS97gF1I2W6uxsDJmzMn8iqjeFVQUPSxX5XYvy+FlfqU+paCEqgl2wRb7Xre+vCK6dzMWbRCNGGbqCxq1HWkm7ohZnAmWULAxK+KN6/7B9V889owcDh76YO8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXY4WWEyYlR1NEZhbXBua3Y0TWl5eVNwSm82OW5NS0JxaHJUbE94Z1JtdXJ2?=
 =?utf-8?B?S25KZUxqT0Y4Ynl1M1FTcklGVFRyMDJXdTQvK2hITU5GMXZLdWllZ0hQS0xj?=
 =?utf-8?B?NnNWc1FXenhYUDR6YlBKL21WK1NYY2RLbmxSZkhKZ1NibUtOSHNMY0s5SUpw?=
 =?utf-8?B?MVlGZXo1cUtzVmtsNFl4OEc4UWN4cGkyN1c3OWR1L2hrMkhxK1had3cyQXVB?=
 =?utf-8?B?am1yOStaQkp6bHM0aUcrRDRFK0xlelJpRlkzWUhjc05XNGZZYVpsVjBqdm54?=
 =?utf-8?B?aXJNbEdJOGVlWEM0aEhldHdYV0praml4OS9oMzVqK1hJUk9kbDdVanVyTEZ3?=
 =?utf-8?B?NU1JOHFvbXhWbWxIOWIxaUQ0WHR2WDFucDFPa1YrM1dRWWpSMnU1L0lwekd0?=
 =?utf-8?B?NGNoN3o5TWJBcTF4eGJNMGxSU0N2UE0zV2tadHNLNUlRZXZMOFZsQ3AzKzFm?=
 =?utf-8?B?K01jdFM2WjRITTE1UUNvcFphMTFBSWlZQ2ZBQ2RTdVRHRUdncjlRdzcyNWpY?=
 =?utf-8?B?d1RHbXRRMTFKQzZBWjB4aEhKOHNiSmtqWDdwd010WEpWZWMwUDY5S2FUY3Rs?=
 =?utf-8?B?OVRtQ2c3aHZ3VFZPTkNUc0Z5WlNqaGFWNFJ3QThjZGRqMysxcWhubDUzcXhD?=
 =?utf-8?B?bkRRTGZYd001YW5MZ3liZ2hnTEdlSXltRi91V05INmo3ZnE3WDY3bE1rc0ZM?=
 =?utf-8?B?RTdpUFJXbFMyQTVmVTR4eHNiYTRnM1RIMjNsdjhCc0Jqd2ZnY1RHaTh2MDVE?=
 =?utf-8?B?d1NKWWdLVTNCZjVpdUtJRXF1SWZvTThUaGI1RkFqRTRHNmQ5VTFkSW43cnZ2?=
 =?utf-8?B?YkRIYUNOK1FiYUg1MVRYQmU0dFJJU3NSOXhxeFlFSnp1UUFwdWlVM2RaRG53?=
 =?utf-8?B?TENpc0ZWckxHaUszS2RqMXJDajlFRWRRdW5NaWlNeWNQR3M2cjYvbjB5NDdj?=
 =?utf-8?B?RFZnWG5rdnZmTU5mTTQwOThieTBDR3VxTm53bWQvMXVONHFoQzRjTHFhS0ZP?=
 =?utf-8?B?VTNmNkR4ekdYWVI4eXlnOWxjMXpUQzdTQmVwUUxheHRFTXNMTkxCQmp6V2JH?=
 =?utf-8?B?UWE0aVlLc0NUZ1dsaUJLa3lYN2NuTGNwN1hGcXVZNjQ4aTV1R0J0bFFrWVFS?=
 =?utf-8?B?MmpVRndrRVpkajFrRjdCSkxnK00vaDRiK2tSSXlCR2VjTElnZWQxNDZ3TVgx?=
 =?utf-8?B?ak5IMHFPVFF1ZzJGeVI1UzRMbERnTGxxQ0RHSHAyM2h3emNua3JRY3crQjRG?=
 =?utf-8?B?NkdaT0tNOWtNdkU2cFdPdXZ1VVdHUVhJRTFwcXA4ekt3OWVhWHV5dXJnZG5k?=
 =?utf-8?B?SWpmM2FLNjlMQXVwN015RFlmeDdzWkVSMHIrLzhGMEV0S3ZsMitibkJSemFo?=
 =?utf-8?B?MmRVWHhGTm56YUFLUGxUV1ZaMnpyVWt4RStQOFJYOFRZWjd1Z1RYaXlQWHVU?=
 =?utf-8?B?dCtYbmR2UjFrZ29EUHpjZmpWcUFydktWbE1jRytZV25VVXV6NTRyTXRvMHdh?=
 =?utf-8?B?b0JESXhFRGY3QnNjMWl0Q0pveHJpeHNLQmFad254RlE5VVcvMjhqSGNaVVYz?=
 =?utf-8?B?Q3NvM0REM1FOdGxyL1dXaGRuQTNCaTRJS3RhK2diZ0RadG82WVlFbHZnQ1Nz?=
 =?utf-8?B?anVOQmNtWDVNTFNhKzB3VG9zS0lVKy9IRmRoUVpNd1JKeHNJNy9jM0RzTlNI?=
 =?utf-8?B?T1k4dHF2Q1NsaHpjSmJNRmVqUWZZZ1IrN3lTLzlDc0ZvT1N0QTNHa1NSbmR4?=
 =?utf-8?B?Wm1zYkdtNnhzU3ZJbU1hNEtaOHlFeGhxaGtyUFRCbEoxQ1FXNDVnK1FkcUow?=
 =?utf-8?B?V2t1RHdWYzZPRzg3OUtrdmlWLzJQMDlWbnA0aGxnbFVUM1pmaEdJcEhRcXJv?=
 =?utf-8?B?MU9JS2F4UVlkK1kxRnIrc3ZoM01xQVl1ZlJJOTVOSE8xVU5GL3RmT0hZMEM1?=
 =?utf-8?B?Zmh4dEVtRXFpYmt0ZmphZ1ZZOExySDdtMDFWbEtRNmxMSm5SVlJydlo5V1Vu?=
 =?utf-8?B?L09veWlnaUNpOUhqaEVXYXpkTERHRjJscGxvQmtEVUV5c1d2VTNaMzhQaVM1?=
 =?utf-8?B?Mkp4U1E2b3JlZmczYlZuWTBpWmh6alp0Z1AvYXFqcXVaUWdQMFd6cWxwTlBw?=
 =?utf-8?B?TVdIdFRyYzRkM0VyWjU4NzhNSU9UUE9wSURqVEFDVStJdzBjb0poT3Q1SGhm?=
 =?utf-8?B?bUk4d1VweU1hNjNpK2txaHNCMmQzaGhSM2dXVmN0dGpXSkJ2alJkRnVWZDVv?=
 =?utf-8?B?K2tGS1hTRUI2RkRERU1yNENGek9NZ1h3RVlveDN2azNFN2pyYVZaNDUwNXEx?=
 =?utf-8?B?Q2xjcklFT003d1JWeHhwb2NqcEYwWnIzY0NWRGVGQW1GUnNkbnVsUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a5e661-8b32-495e-21e0-08df02ad38fb
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:31:51.9593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDyy3hmsKDSI5jGobnRZ/BwBNpxRaUrTmNndcww+9LWkA5Vld7gM9EYl0I4Y6M+R8OzZlSN6w/K5ZGcJ4hOwGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB4985
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

On Tue Aug 25, 2026 at 1:16 PM BST, Andreas Hindborg wrote:
> The state machine documentation states that for pointer types that
> implement `Clone`, the `start` operation may be issued while the timer
> is in the **running** state, and that it is then equivalent to the
> `restart` operation. That only holds when the operation is issued from
> outside the timer handler.
>
> The `start` operation returns a `HrTimerHandle`, and dropping the
> handle cancels the timer with `hrtimer_cancel()`, which blocks until a
> running handler has returned. When `start` is issued from within the
> handler, the handle is also dropped within the handler, so the cancel
> waits for the very handler that issues it, and the handler deadlocks.

That's not always true, you can start timer and store its handle elsewhere.

I think the proper wording is that "cancelling a timer from within the time=
r
handler will lead to deadlock".

Best,
Gary

>
> Note this in the state machine documentation.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index bdb6aaa22839..2a9abc9f5d8c 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -78,6 +78,8 @@
>  //! handler returns, and a restart requested by the return value of the =
handler is discarded in
>  //! favor of the `restart` operation.
>  //!
> +//! =E2=9A=A0=EF=B8=8F Issuing the `start` operation from within the tim=
er handler will lead to deadlock.
> +//!
>  //! # Examples
>  //!
>  //! ## Using an intrusive timer living in a [`Box`]


