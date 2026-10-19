Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D6606A327
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=N2iD3960
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B0610E907;
	Mon, 19 Oct 2026 16:13:12 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CBF610E907
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9r+e9wI69I2waFmI1ddQ7gQFeJbzlBYkX31m09JBMXQMaidfD9Z8o3bKXPVNHCbnaKN3qTaMzbP0Gu6lb5+4nd1gtSo54tvcFaaGS0Pg0WPnx6Wc9P7nesovpQtq/FqPMC7rnj6ECJB4AUuSCTOvT4b8w7eb7kETxmeN9Ry1sN7w0Cl4tz1+MtrpNGtYL9pJ0sPg0dTgj/Lg8GCBwfd5cAys5EwEF9ziGJL+LcKnwRRDI2DF8Sa9fkFds6QgRsjezoKcC4koYiS0U9eygIk4KuWiY1q9jLBNRIGfZ+xQRR7aHh3dCkUXaSHa/kxXufWA+BKLgaqeAgbU7+SSml2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xHq6YTiiR3fqLM+iZfaW09pYscwJBUnSi7WkmQCZXI=;
 b=wxOD5/uwB19Aehvfrr7zxIB0JhmNYu08DtoTUZp/gijN78d9d1v0vXDMCyvbwULGNMsAzidUAon76KIBpCkH5gZuT8xoWCxE15xokzXJK0lcyXRWdeBvwYY2dUSvwk4jafjr+ZQNtFMbygZb5DUsRXcqnbJkK1oLPUsv7ODOP9XIL1ctZjaFvi4QO0lOUQAcxr/NbXZcLXGNVSWprhDewcn/Z6F8zqGcQyo3CYzdeRg9p1rOGery/v/NkEnNCffNebn6Rt1/yXEnP5NlbNWOFMTCbBmvqhnLlTRp5rd+8Ja27jGGSKHtUIizktoK8YYFgbBA2VECU4gFP/Xmq+DtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xHq6YTiiR3fqLM+iZfaW09pYscwJBUnSi7WkmQCZXI=;
 b=N2iD3960HViSVf82fD/CvlEXnHNUIAo5DUH4lnqumCLKbb9kkQ13gP6EyOYcE0NZXKjFrTBf514CYOKHC6vfZbyXmPZRaxL0uBYPGlhJl3mnZ56RgP8w7N52tk38PkBICOqufH2PM+vTPbWwP6iuODK4BZG1tQxFqmkKRGsa8/M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOEP265MB828591.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:501::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:13:02 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:13:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 17:13:01 +0100
Message-Id: <DM8Y4G5JMZ64.9PYKH079V51H@garyguo.net>
Cc: "M Henning" <mhenning@darkrefraction.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 01/13] rust: auxiliary: let registration_data_with()
 closures return covariant sub-fields
From: "Gary Guo" <gary@garyguo.net>
To: "Alistair Popple" <apopple@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, "nova-gpu" <nova-gpu@lists.linux.dev>
X-Mailer: aerc 0.22.0
References: <20260909064506.910162-1-apopple@nvidia.com>
 <20260909064506.910162-2-apopple@nvidia.com>
In-Reply-To: <20260909064506.910162-2-apopple@nvidia.com>
X-ClientProxiedBy: LO4P123CA0211.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOEP265MB828591:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd1a282-f98e-451f-0d02-08df2dfbd99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|10070799003|1800799024|261009223027099003|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 4o+Jvkuw9HawK+Nf7wZ2SyDfr71gg3TlnsFT0b1hblkgmCkp8bDXQeb5QgQNZrHscfZ+hR83oywuCOgsIQjol4cmN9etz3lDK04HxFXexw+7BL9Jn8xIBVJDYjYi7zMLNhCrAyto4QSw28DXWz47FsolWu7lBUjgedyvfSmKysqa3nLo6SDP0qE2xw6BZre2xEvMCLr5qECDobMW93WSSJc63HhxEiR40plziUts7GXGpqWzfcoQJ3TgiZ+APCdeOJ0eR1bgTn4wmRA/bWJUQKXjV2SvCGVY7x1l5EoFXOJrW8m2R7h02yolM19B2A4gohzkjdeI4/ZOUCmttvqC9IuHO1fhJRa3bdofrZvK+hVQRkHtys9yZlkiIFt4M05vnKx/9isjYgxM1UFhJs6VGxARH17vzSImHoJshkpDG9MjuQ5L9qFLkzaRG8E9pfNeZFiRW6AdtWxjBkxRLVYgNiQ7wiGOczRkVeLNlXfityes4Sx9zRzigqMtj6zBtFiAZsDvDuHdpKa0ygSjeq7vfDgdkzddEcGHZo0Sj2tvE5l2L1nBDs16c3jt3k71E5NavDhr5+qkftKNwpPj+cJwiKunUao0FXVwEJnZWgJxGQ7oFyOS2rFY19FlBUsu2h5p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(10070799003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1daWUJmaS9ndVhUUGkzaDdxanppZXFvNlMzMlFCTkRYRTRBT1BGRlRlL2ZJ?=
 =?utf-8?B?c2htbUtjNHNNcDFmK1M5M1NTR0lUMVpJd00vZXFHeUVHMHdYY3d3V2dBS2pj?=
 =?utf-8?B?d1p2L3hKT0k2bnVuaGxVdEY1eUt1VVpEWEFTS2R3Rk5NYWdSb0xValUvc3hE?=
 =?utf-8?B?cGp3V1NHSWJIeVY0UEdZejdEK29RUEJMNlF0dVNXYy9yRGU1cmdRY2FCNHQx?=
 =?utf-8?B?ZDZNb0R4S0hLV0tXT05ReVhYRHRQYm5SY3AyektFaDlDVVBobndGVnhGL0xY?=
 =?utf-8?B?aDJmWUpFR0U3N3ZTVWlKSUFZVFRCZnRRdmFUTzV4bGpZYXhVU1p5ZEhhOUZV?=
 =?utf-8?B?dHdSaFNmS0JLaXpFWDZ3MUpvYlB3aVhyc2ZRTlZSSkpUUlR3Y0xLYnlHcStO?=
 =?utf-8?B?UENQeEQxcEVJUmJGaDBEdFUyY1Q5YXpqM1VqT3E4VFlaMXR2TFEzOFdDa2xw?=
 =?utf-8?B?STJUcitZVkNJMjhhU0pnL29aeUJ6VDhDUDJOaWRlR3FkUzJGRyswUThWVGpy?=
 =?utf-8?B?SjhLT1BYK2daRjhLOEhLRGpROXdJSC9ZcXkwdWpnOHdDcUFaSW4ycUpHQzMr?=
 =?utf-8?B?bDU1SEVLYUVRd0FmcURjV2w2anZ1VTV4Y1pEN3J0eERSK3EwZGI0OU15cGZQ?=
 =?utf-8?B?a2lrSkY5YWZKU0d3bVF6R0N6T0o3V3o1T2lUV3gzaDE5MG9QeGFBMXdZbVh5?=
 =?utf-8?B?d2s5cm82Ym1xT0pxQml6UGhId1NCVUo1SkozbDNnem1nZFdKRzQvUXBRS0I3?=
 =?utf-8?B?UU93N0xFMHRkTkZKelVaVnhOaWViNko1ekdUUFBtSHdYNkQ3QlphaDBrdEI3?=
 =?utf-8?B?UHRDM1ZpcjZGa1dERVcvUS9NcG10SURkbmwwRER3UE1VelhmSnhGcGRwelBk?=
 =?utf-8?B?dnRFekErL0pKamJuZDJTcCtDWlN6YmpIK01sYjIyWmZTZlNPd0Z3QzFJV29k?=
 =?utf-8?B?blVpc1ZyRUozYWNzY2JuU0pZYUV2V0d3ektCaWV0Ykl6RGN2bHNpZ0plK0tq?=
 =?utf-8?B?NSt2Y2o4RGRMUlVUd2sySnc5NmVoK1Z2NDJIRE1vamVUcEs3ME5rM2I2Ukcv?=
 =?utf-8?B?bS9sd2w4NE1ndlBmNzJLck91TEwrS0J4WWM2WDEya3c4Y0drY0MrWnlTWXVm?=
 =?utf-8?B?Tkwrc2xjeDRMRXhIaEZMSTFJc3B1RnN5b2V4STFvVDhSaExGUXFMcGJXeUtO?=
 =?utf-8?B?YmhBeDJsazI3SXA2N3BidVpIRk9qTVlkMDFCU0lBYmplTEJTdzI5aVY4SFgy?=
 =?utf-8?B?RnlUY3JDcHV1cUpwTnhJRUFWZjFSQVRaekJ3ZkNBeDdtZWxvYTY5TnBhcEp6?=
 =?utf-8?B?MVF2UzVleCtxclpEOStGUlJSTjNXWURRb0hsL3owNUQrMjBYUis5QjR6LzlG?=
 =?utf-8?B?c0tqaDhWSHh4UTFWbzJ5TGNmTFBGNGNQNWN4SEVwZTJmcFpvUncvQStqUEVE?=
 =?utf-8?B?ZzE3WGljZ0kyY0FOK1I4RXpnYThVS2QrYlp5OXd0OWg1aGRibzE1WW45dXQx?=
 =?utf-8?B?UzVtUTFqSDUwWDJsNnAwTjZzVVlBRWVOZXNDTmJGTXppRTRzQnNyVmJVSFZC?=
 =?utf-8?B?SnFzQmNsL0YyUVJFQ2NQa093blhKTVdubVNDVkljTzUwT3lwclhrZUxqeUt6?=
 =?utf-8?B?eXBHYXhEUnkwcGVOY1hvQkF1TWp0RklyOFY3UFdMRXRBUGkwVGpzRzlaVG9w?=
 =?utf-8?B?MW5WbmtUK2lmb2tGaGVyQzFDQTg5a2w5VnphcytPUnhlT3JmazdGeE0zUEJZ?=
 =?utf-8?B?ZHBXN05ha3Fyd08ydkFCM2VscFZBTGJtaTVLYlNKRjRvcmhrNnpSTzBKM1lw?=
 =?utf-8?B?ZzB2ZUo3QW8zeTFHZ3M2a3EyY2pwcTFMY0IxdVJZME9WWm4rcDN5NllxQ0FG?=
 =?utf-8?B?SzR3NS9JOGVGdFRsWVdOYXVPa241V2ovZ3ppSEhQcDNoZEEzWnNIQkQydVBC?=
 =?utf-8?B?TDN3SHlMaW04V2tRcS85VmovSmNxci9hQWtVRWwwU2J0YUxTeFBJSXd0Sk1W?=
 =?utf-8?B?S293ck04YlVGWFZ4b0VoTXJYSi9yOTFTSlNQalpua0lVZmY5Zit4cHY0UFhS?=
 =?utf-8?B?V0tsRU9UdFdEVUE1SHJOWjM1MmdrUk52cFZxS3g2aWZmM2VZRnF6aW0yMU1q?=
 =?utf-8?B?bkxSOVFnbSs1UFBiUjVDVzArV1l3bUFQckRmZnRuNXZ1YTFnbDRSZlJiaDU5?=
 =?utf-8?B?VEVwYUZXL2VKNkJlM2s0WGRHTXZ2RzlLM05VVlY1Tm55MVhzbkpHTllhYndV?=
 =?utf-8?B?OWJ3ZmxoYTM3enpXNTFGNXArSkhwK0IyOVdGWWdJS0ZsNHA3aHVUWlltNmh3?=
 =?utf-8?B?TnZVZHZDYnlsekc0M0lWWUdhYUVpWWtwdWs0eFE4QXlOQW4zOXp4Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd1a282-f98e-451f-0d02-08df2dfbd99d
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:13:02.1994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2c++JvB991yrwA0hPbGiS301Y/8NnIrTopDih3lh5b2scGWBytdzceKUh62mzwEXBqyRkvW2EqmvIgTUYSf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOEP265MB828591
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Sep 9, 2026 at 7:44 AM BST, Alistair Popple wrote:
> The closure passed to registration_data_with() currently receives
> `Pin<&'a F::Of<'a>>` with `'a` universally quantified. This prevents the
> closure from returning references derived from the registration data,
> even for sub-fields that are covariant in their lifetime, because the
> compiler cannot relate `'a` to any lifetime the caller knows about.
>
> Tie the outer reference to the `&self` lifetime instead, i.e. pass
> `Pin<&'this F::Of<'a>>`. This gives the closure the implied bound
> `'a: 'this`, so covariant sub-fields such as `&'a T` can be coerced to
> `'this` and returned directly, while invariant fields still cannot be
> coerced and therefore cannot escape with an incorrect lifetime.
>
> This allows auxiliary child drivers to project covariant data out of
> invariant registration data without having to wrap every use in a
> closure.

Looking at this again I think the current API might be unsound where this p=
atch
becomes fix rather than just a feature update.

For an invariant `&'b F::Of<'a>`, it's actually a requirement that `'a` str=
ictly
outlive `'b`. With the current API surface, we can obtain a `&'a F::Of<'a>`=
,
then we can store it inside `F::Of<'a>` (because, well, F::Of<'a> being
invariant, it can internally have a `Mutex<Option<F::Of<'a>>`), and then we=
're
able to UAF within the destruction code of `F::Of<'a>`.

The fix, is, well, this patch.

Would you might pulling this patch out, rework the commit message a bit and=
 send
as a standalone fix?

Best,
Gary

>
> Link: https://lore.kernel.org/nova-gpu/DL3WPTVM033J.33RWYCZOC67Z1@kernel.=
org/
> Suggested-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>
> ---
>
> Changes since v5:
>
>  - New for v6
> ---
>  rust/kernel/auxiliary.rs | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 60dfbec8f330..06f816420790 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -305,6 +305,10 @@ unsafe fn registration_data_pinned<F: ForLt + 'stati=
c>(&self) -> Result<Pin<&F::
>      /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The=
 closure receives a pinned
>      /// reference to the registration data.
>      ///
> +    /// The outer reference carries the `&self` lifetime while the inner=
 type carries the HRTB
> +    /// lifetime `'a`, implying `'a` outlives `&self`. This allows the c=
losure to coerce covariant
> +    /// sub-fields (e.g. `&'a T` to the caller's lifetime) and return th=
em directly in `R`.
> +    ///
>      /// For covariant types that implement [`trait@CovariantForLt`], pre=
fer
>      /// [`registration_data`](Self::registration_data) which returns a d=
irect reference.
>      ///
> @@ -314,13 +318,14 @@ unsafe fn registration_data_pinned<F: ForLt + 'stat=
ic>(&self) -> Result<Pin<&F::
>      /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
>      /// registered by a C driver.
>      #[inline]
> -    pub fn registration_data_with<F: ForLt + 'static, R>(
> -        &self,
> -        f: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> R,
> +    pub fn registration_data_with<'this, F: ForLt + 'static, R>(
> +        &'this self,
> +        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
>      ) -> Result<R> {
> -        // SAFETY: The HRTB closure prevents the caller from smuggling i=
n references with a
> -        // concrete short lifetime, making the round-trip from `'static`=
 sound regardless of
> -        // variance.
> +        // SAFETY: The HRTB on the inner type prevents the caller from e=
xploiting a specific
> +        // choice of `'a`. Covariant sub-fields can be safely coerced to=
 `'this`, while
> +        // invariant fields cannot be coerced and thus cannot escape wit=
h an incorrect
> +        // lifetime.
>          let pinned =3D unsafe { self.registration_data_pinned::<F>()? };
> =20
>          Ok(f(pinned))


