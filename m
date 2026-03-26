Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAC410A88DF
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D0810EAFD;
	Thu, 26 Mar 2026 15:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="f5HVvjH7";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021105.outbound.protection.outlook.com [52.101.100.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC4310E244
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmPxgnvWi4b8Krsvois/FM6+oNFYyqjdXPucDbBs7L5oE7+lF7av2lYDrW3h4lBp+UYtlswWEqw7HdntPogYGNOrjFc9ovr2mw31j1N6x9ZS/W4qII8YsqNk9lQtuVmi171Es5wRsZsy6HYTPra4KnG6O4+xvuIC5Fd/jGZ769UDzqKbAPBn3kKl79Xvr3XDlUJsEleijWX4lJTgB9TDu+G8uTa3CZxCojx7sb91/sh/SIfqEAg50YfEPcok2AOHP1r2+iLCK96OLgpwwqs857Vo+VxpXYy45dXZOQB7mN6T4PQ6lbdwXwuXIFtywt0yIvPezLpqZZesrGpT2nWZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEEsazkvQqsSzpo5gkAsRf1m4QXFWRS/xebS8PAWomo=;
 b=J9PXTNcQ9xVQdFphRN/hfmHLuWQYnqFLab+ucVVmDuMbiC3N5rqUHkluE0K+tcpHqKvVtwyzJGVorWD8PFFet6CJ55tiOWuTSzZl9EJXBLxeplZ5ZDMMFv2QkNXM2JNsznUzJXBLAf0AGOfiZrkARdWMwo/Up8s+yEAXlMyYXFkxfzP4JzR1xTWP8rNlJ39iZ56eOEmJDkOOt15aTYC9nq6yxFMmFO7e/QpxeJQ6Qnh5uRSXCnLe51v9TyLfX47CrPybLzkGDTx1hbZrB3whoNEUJ/K4Skb4E7z4rgrWZ7TwKkRHVZQZsuEVEHK1Olnt1WhwaaRhQgJ75apP/eyEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEEsazkvQqsSzpo5gkAsRf1m4QXFWRS/xebS8PAWomo=;
 b=f5HVvjH7KT7ZJDAudSt/fS2sAD5x6TdOZ0yodaFXdA/48dMtuF8ZL7j0jnX9Xq6cJrq8Ni9ts8vaXstBcvTsQi5w3Oz7R6xWzb/lu5Y1gUPdNIzIAsgkXRlVqU5N1IHDxFEtTL6MP7l8rfcX3Pwqummp3Vfd+v+RT0aS1mSHwHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2926.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:179::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 15:43:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 15:43:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 15:43:05 +0000
Message-Id: <DHCTUR680RWK.PFYB70EBQL2H@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [drm-rust-next PATCH 0/2] Fix sync::aref imports
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
In-Reply-To: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2926:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dc018b-bb06-44f9-0174-08de8b4e5f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: l3WIVVTtILPvVMUB4Yo1Cjc/1YhTTbN43tkEHWbJ2KQ9MN814PKkougsWpP++MRA5xRgi/2ZPFEe57f0lPWqCyziWlzh+uCFD/SCRz84KKcYbL7Pitb2woTEaQr+ilz2BghvOzLmidTiaw8D4WZAV9FL8o6SKMhcqb2x0DapGL1/ysnznOOXb8Uu5RfYktnf094pAVFVr9OfCOfLtkus0bQDLRJWcoueaYG1Pc9QVp14FBfMR/kddhONC637EPTz4PHHXukTdNufyeLFlXQ5uRLX4d/yz525E3DYKeXwINeg3xMULcqZCPqWLXIRI7I42Xm04ET1yMnc2j/cfLxEA4n4Lh3l7OPWGr4Q+zK0GYNP5LL7+ZcyjOlTLt9dUbLAgazDpDfaihs5/POyKPrCOrE/nZacL0v+VOV3+/7XrDK8gMTlzlOFeGoK6RVoha1jLMQAXnPr3lwdoKURYqsmT8sdN+AxYN44VgQavHVAkjIm9izU/0Hqh+gUPxyGFDoH00Epgx7JBSayG02p+2wnAJxMzZNZHHDFFOe1P3iTBx2ZeroA0KWBibwMDWl5HuAcojEMfvcdZa52P1yLlS2uew3+EPBTZbFmDpW/IxGQVI3OzjK95gxEJAPF3MoxoLP+J+cX1eAalUD+BlYLxqMuaZP7N97SUnJTTnT/EKzu5Ssa3/3VhFGlhwn9B+coPwXwf3g91f7yA8kM6z6KSekLXFAbXvLrKs2rlZtO86G/z1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2VDT3hJazVacy9GTU5qRkZaV3dleXd5c0pYZ1FvV0RCS0l3YzZBQVZBTVhB?=
 =?utf-8?B?RTdFWTM5SmVGNnV1S0JrWHE4b2dwMnhpNXdIQUVyVStoaDQwbGQ2L091cUkz?=
 =?utf-8?B?RzhvQ1VIcW5KT3R2SllBUXIwR1pqclhFeUtGblEzMWVlUmVFb0NoQTZIMEhq?=
 =?utf-8?B?SkVrNlZqNDNVS25wZnNscVRkTVZIMDFoODFyZWZpWDdVMVdXRk1hLzlhcFVU?=
 =?utf-8?B?dU44eU8xM09OdUNkR3pHQnF1d25DVUxzTW12SW04cDl3TjlTQmdRcjVhdnd6?=
 =?utf-8?B?dmp0UnI3NGJlNnpidG5RVURRQWtlRGpRcTdDbGJNVFlmR0JWd2wxOEo5d1l4?=
 =?utf-8?B?REY1VXMvRUZMYTg4V1d2K0lhQ2laRTQ4bE5UbVEvbGkrQmxnOGNEUjNIM1dk?=
 =?utf-8?B?TklJNnJ3ajBYNHhjb2JTNGRCeHZDUkNRVXYvOGJLcXNaUDd4c2NTd1JadTc5?=
 =?utf-8?B?SklKVkdOVlZqRVlzdFRWRm45UjlNbUZwYW1jZGMzdGFxRVdVRHBhdmFoYm9n?=
 =?utf-8?B?MjVzdTZmeFJyMUxFSFl2K09VbW4wRkFXc1ZQS3o0L0ZlS256NWJxV0dpb2xt?=
 =?utf-8?B?Rmx2UTJ3dGtoN0N1UHlaQS9FRVJXa0tHWE1IbDFwUDdXQkpCZythcXNKQnkv?=
 =?utf-8?B?aGQ2a0FSUENBTXRvais2ZkZPVS9ZOWgrQkdIWmhiMGpzSU81NEh0TTZTT3dr?=
 =?utf-8?B?RXFNc21GWW5zdXVqMVZIaEo5U3AvQ0pPR000OVdGVElUQ294Z21MUG52UEts?=
 =?utf-8?B?anA1Nzk3VUttYWU3U0xDc0JlbXNZbktmY05WQnBIenRKYi90dzVlSzRyYTlj?=
 =?utf-8?B?eTdWUEkzb0xBem11dG96REh3UkF5c25mb1IwRGtzWHhudHBaTlhCZDB4Tndv?=
 =?utf-8?B?Y1AzY0lIenZnSFNpOWNHSXBwSXNjeTU2RTVicFlua29MU2lJaXcyd2ZPT3ZN?=
 =?utf-8?B?Y0c4WDJTUE5NZHVCeEVDNEtLbGxydWl6N3pFWnJLbUdOTzQ1NE9teU9nZVpl?=
 =?utf-8?B?MFk1R2J5UVBqVkZPTm9WWW8zRklWbXVWUTEzdHJFbEhGSVh5UkpsbURkc05E?=
 =?utf-8?B?Z2YreUVzRFdnWjR1MDFpVGVLWjI4dDgvSVNaREhrT3l3MlpnOVJlck8yaC9o?=
 =?utf-8?B?c2dpSkluUE0vM1owdkZORHNYKzJxRkIvNVJtVDA1Y0Y5czJCQmRSdEw2eVA1?=
 =?utf-8?B?YTZ2L20yS1dZTlBrcXd4R242VDd3aW42elpiVzJjNHoyWXdTQWRKSE9KNkJj?=
 =?utf-8?B?dDRhU1MrSjRteU9lQVpxcnh0WkpEWEp4L3dBTGl2YkRKbHZudzNiSnVoQU1L?=
 =?utf-8?B?M0FYb25yM0d5UmxHYVJwZVVMU1JBR1RLMmI5WTZSZzg1RlRSWk45ZXdkRCtL?=
 =?utf-8?B?Y3hwTU83eEhSNXQrVHoxTkk4dC9UUXl1aG11ZXh6TzRiRUZEb0M0b0YvWFZG?=
 =?utf-8?B?ejgyOEs1MkNvT3dPZmEzMFdRWTlFa1VnSW5NckZrZTJwR3ZBUXV1bmc0UDJ2?=
 =?utf-8?B?TTFzY2lQRVYycFFvT3h6clNjOU5ibGtReTVDWEZ3ZnV3b3k5WXJJNHpCdEdu?=
 =?utf-8?B?WDMyYW1tQUUyN0pxdEFQWUFBRDVpelNuWmtSZE9kYzVKZzlxK3Fsb2M4aE1j?=
 =?utf-8?B?WnF5OCs4RU9Eay82dXpnTnBGcThUMW8rbjdVZDBNZEp3LzJVNW1iWURQZHNk?=
 =?utf-8?B?dlFvdlJLMkNUWjJML0NpRnFBaGpSeUlBbll5b055Q1BRUUxmbCt6aUhsTnlw?=
 =?utf-8?B?OVFwK0xkWDZSVFZLNHNKVlJPZWU3dFgyOEFzUnhXZVdqVGpKUWxRQ3VrS1pW?=
 =?utf-8?B?Wi8zYkhCM0xzOXVGa3lhK3hTNFhJUUNhTjZXZVRLNU1Cam8yTm0wcEpBQTRW?=
 =?utf-8?B?UVFmeXRmU2tIdFhQMUMrMFhNQkUvSXo4NkZrTlJRZFlZVXl3MTZHNDNvTkRD?=
 =?utf-8?B?ZzRPZ2ordjBwRWZDZjd6M1VTS0VxZis2djRUdk1LS2tQbXpSOHh5Uzh2M0pH?=
 =?utf-8?B?RTl0SHZuUHBjSW8wSHh4VC9yOWpiVmgrMVJueDdpeE9ORmdMODI1UHBndXcr?=
 =?utf-8?B?TWpJT2tOZFljT0tLckVYdFozcitJdEtPb2lUV3N5VEVHdHNUcnhXekkxYndw?=
 =?utf-8?B?TmtPamxVbUMwYkZDV1paL2lWUURSeTlrbkNuVGI5a3p1TlNRTnZtVnA4UUh1?=
 =?utf-8?B?Yy8zYkQ0UHJvUWIzQURza0lhbllCeEtSb2FiWEdjUHFvdjM4aEtweFlQRi9m?=
 =?utf-8?B?L0VBWTVUOUc1RFBETnJMSXBNSUllSmI2cnBrbTYyUXhua3BOTUZUclRqeHJj?=
 =?utf-8?B?QzNWUVA5SHZqN2RYUEFyWDRDbi8zbHRiWWVRZXR4akI2bzR5STVwdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dc018b-bb06-44f9-0174-08de8b4e5f51
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 15:43:05.6886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05Yv7WfiGggFAYmwIqp2nRzDkYeX0FDMuCumIr9s7AA5RdEbtZWGoooIMnpQUADNGfd9iFfVs0WkiWnu6xezzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2926
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

On Thu Mar 26, 2026 at 3:25 PM GMT, Alice Ryhl wrote:
> A few imports of types::ARef were merged into drm-rust-next, but this
> old path is being removed in rust-next this cycle. Thus update them.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (2):
>       rust: workqueue: use new sync::aref path for imports
>       rust: drm: use new sync::aref path for imports
>
>  rust/kernel/drm/gem/mod.rs | 2 +-
>  rust/kernel/workqueue.rs   | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> ---
> base-commit: 206bada308d0d715d62ac841784af34a2ca22ff6
> change-id: 20260326-drm-rust-next-fix-aref-595e7bd5e70c
>
> Best regards,

Reviewed-by: Gary Guo <gary@garyguo.net>

(with import style fixed up)
