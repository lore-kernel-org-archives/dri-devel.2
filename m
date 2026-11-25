Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514A606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=JC//ZJDq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E555C10FDC9;
	Wed, 25 Nov 2026 16:47:54 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020106.outbound.protection.outlook.com [52.101.196.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12D210E935
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAluPzXRA3VvcJK4IRK0Hgc1PHws3RLne/2j8mPyXkqiklmDRWqoG8UqR8zTOvWi2dyazim/lpEtK+GACEuP9Rbxl+bmnBkkbt/Oz+oemGzfjBca1GBQQNMJsBr3L5hszjwQrXLha8wAmJ/2SwtFbgyF2EMu7PjMU/YvVk8+ZjotcPcQr/JIkzuwOEWza0I/kEGqenHbKWdfG7wxBhTLbmtlS2xksOsDkru9DGQVZte/V74MHESbkCMFAGBkiLtZOycSzPRyM0HHUANXDLeMk2lqWLknrrH8DUPdNsIZVyScSY8+2U9HEvvMSdfO+p/36+OJXTLbWbYv3DtKI3Bitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/nYfbYndi1SHlwuJj3Ga5w+rAPhbUQ+mb8VoIVvPiI=;
 b=iY64Hv+PSq+HNy8suGwuDHkgNJQ0jZVmjnkrJfEPd1/1jhtwoodYfQqWJ6ea8LmXapsStef+e9HsWrW/g/P7IzVrpnuFu5qjFBIf1Xp/Q+7EjF3Q+znEO6aL/eLCP62nhbMIN1C4PH+PVwOcvACMOxPC012Z1zO43+yOkf5zb29gWtcmGr+S36dX16CWs3cHLcZMg6qaCMsLJTLrmmLLyyy9zDn6BSsYksO4Xe0qyQzBSQmj/AzfTp9yK7OXNsPdqFf61X6fwhID5jxyDIddmerZZrHYbXjY/ygjNIDoi3CSRYk432L4bzo/uwGmQy6b/6XBNvCAuWb5nx/YBEH5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/nYfbYndi1SHlwuJj3Ga5w+rAPhbUQ+mb8VoIVvPiI=;
 b=JC//ZJDqOIX7SWR60skOKt3VWOTNXvqMDADhdX4vkphqjRKKlDbgsIIY6walFtNdt06qmceulG7xlLMyUq/I3iC2gbiWHNWgMvua/KaMI9YGrBuiVEkXZzEl5HeTo3Vpm6Jn9ePA2QJB//j+KFPDPmOLitP3rfebWFz1E4Hebdg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LODP265MB042256.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:47:45 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:47:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 16:47:44 +0000
Message-Id: <DN4G16NA0JJF.QCQBZ2S4U1GZ@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Matthew Brost"
 <matthew.brost@intel.com>, "Danilo Krummrich" <dakr@kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] rust: rcu: Add get_state_synchronize_rcu()
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261124122951.878199-2-phasta@kernel.org>
 <20261124122951.878199-3-phasta@kernel.org>
In-Reply-To: <20261124122951.878199-3-phasta@kernel.org>
X-ClientProxiedBy: LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::11) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LODP265MB042256:EE_
X-MS-Office365-Filtering-Correlation-Id: eb090fcd-0ccc-4164-16ae-08df4b13d47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|10070799003|6133799003|4143699003|261009223027099003|22082099003|18002099003|921020|56012099006|10067099003|261102123227099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: rZb2EANGXA1HPI0vnyvzQ/Ytv+5bEtE3XmVP3qtlbkmsVcVpw3EGGei0O/4s+EIj/UW8/z3RvjExmjEBn1DlRmO8Vtbq8x3BjhyrCWw1e5Vjz6irWrZbbzOssdkgxBlbuUJ0cQ7PUQipwsklXPwOAK9PWBIgCiHzwxz0ex+BSM1Bv3Ln/1dghG87kK4RlPlLwRuh2Kz+gSl4FVE07HVxcyZUPbg0ucQeWm9hG4/iRDGhlZtcBeygsx0Mk70SPbHUjPZ1vYeK5HmVo4IRK++5OY+AwluWVP9m02RQHnDx+M3oOzSIKDi3Sb7odJgYOI3USBN6hf7jyx2Wd6ORg+hDcUubPygtRtKZkHEB0GZuQ1vy14DcyWfEOn7DVjDl92tu4GVG7emoBS2HQiaMNdGpTYL6SqR94eThetx+sG1F6FrJO2Q4A064PZvfCMYFEmWJdJb1E3r4GblemYxPIC36JMkVHkfUWNk+98DluyyVZXH2oeOAaGelg7AjbRM+pgkA13D8K2AN5v9v4KX7/OfOP8/O+QDZIPtjo8mEKDNKzacYdtwauSry0H4hKNrOYUg3vzRd2ypOw4hIGcKBz9d2lLw8+3StnzaM8Lztho/TE8T2KxqaihZm6yXNE43TyeCNpBYcFUh+eTPACAkN88jTnPLybcdJPY3Erisk4qrW9xLFhFlc/e3OPXesD4FhfhNICnU+hf0rrhYf6Wo1hSn2rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10070799003)(6133799003)(4143699003)(261009223027099003)(22082099003)(18002099003)(921020)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmVsUnlwYzROb0hLUUw3SjRmTWdzSFMwSWxTb1FCMzRCaXJaL2VodGtsaG9R?=
 =?utf-8?B?YVBQNjg4cnU4cVFwUzdGeTY5S3RDS0FIeUFRUmUzQUpXWmhXUktUbXVLQkRl?=
 =?utf-8?B?emc4VlRsZ2NhSXRPMlQ1YW5RZVJ2RnowelYxZWhmLzZEelBSeWlvQkpyTFN0?=
 =?utf-8?B?cTRVVkVZQ2lrTXRNZ243cTAyYjdqbmgyMU9tQWZ3dzZoZE9OUDJLQ1kwRWhW?=
 =?utf-8?B?MVlWYisvVEc3cUlONXlQQU9laTZhLzR1Y0Y5ZEpTUEhidURHaVAyZUJPbGp1?=
 =?utf-8?B?dlF0ODZCcWl2aVo3Y29uZW9QYTlmYWRzY091NEpERmhVNFpDcHlTMHQ2N3g3?=
 =?utf-8?B?TUt2YTNySEl1c2N4U255RmtIZjQweWp1OFl4Z1FmSVhIOFFLZU5lNnU4RURw?=
 =?utf-8?B?YzF2NGN1L3FJVVVtRHN5TU5lZkpiMlhXV0dVOWRsT3ZyMnYrSmtUZllGMVRK?=
 =?utf-8?B?TmRQRjgvNThVYThPSlFoZmN5V3lsWTFBeUtGOHpTY1BaYnJ1MzU0Ym12K0tH?=
 =?utf-8?B?UEpWK05nQWVITkZ0RXFrczN2d2hlRmRjVVNzazRtMVBzRzhZdmR3ZlordXo3?=
 =?utf-8?B?dW5iT2FnOFFIbmMvYWVBRTNJRkVjR011RXVkQUFwMTdoWmlhYTdRWGk0ZTBS?=
 =?utf-8?B?azd5bXRqU0JXcHNnM2h4bHh3QWliVi80YjFHM3MvMzlha3hyeEJzMFpWVGtL?=
 =?utf-8?B?YU9FU05Ca3pWSmdwK0J2dmo3bDlNNGQ0T3Z5S09IdWxNSk1qQlF6a3hVYWVy?=
 =?utf-8?B?Mk51TnBidHNvTUMveC9RREJQd2hYc0w3S2U2RG9UUWpKL1QxeXJHSUpSMWwv?=
 =?utf-8?B?Qm41ZHFqc2FqcHQ5dXFia1JCTTkrZmZlZkJkZERweEFKMWJ4KzRIbUxSUGhr?=
 =?utf-8?B?eUlzeWpOdXhWQ3Jna1kwSWtBVFY5VGhiRkRGUW5pcnRuRGU3VEdRa1FsYnQ3?=
 =?utf-8?B?Mi9lSGxJSHBqK1ZQRVhLYVkwMkt5S2pWdDYzcWtqSVNFanRpeGx4MDROeWNL?=
 =?utf-8?B?RFBPVkFQcWc1c0xPZ3lzQ0crUkVVeTEwQktFQTN3Rm5kT3hzakpJUzhLSVJr?=
 =?utf-8?B?RFhlUFdrMjlmTS9DTHYzWFc0dU5DeHR3QnVOUWdBZ29RRHZiaER4ZUZVOVVv?=
 =?utf-8?B?d2ZZaUErNEZuQUtrNVlnT015MGVidEk5RUdlWWhPam13cWpSdjRnaVlCYmc2?=
 =?utf-8?B?N25Pc1pLMFJZb0xSTTErWWFMaXUxY2NLZHJ6RWFuY2xQOGY0T0dMVFJMNUVK?=
 =?utf-8?B?ZWtRcUZEYXhLVnJjcVVhd2N5RHQrUUdrT3pxN1NTZ2xoRTdoeldubnBnaVNF?=
 =?utf-8?B?QzFJVUhzcXJqSXNGWS9xR1VLMS96bGhJbTQrNitlUmUzK0gzWXBnMVlTc2Vu?=
 =?utf-8?B?eE1saUl5WW1uUWZUYldObWN6cWJ3RHdlRmU2aU9lS0dXWnNEYUpPSEU0TVVk?=
 =?utf-8?B?dmpiOVJreHVWUlh3aGxLNE82TFc4b016N2w1RHJ5SnU0Y0pISzB0MlNOUlpl?=
 =?utf-8?B?QkhLQWJCSHVVN1orVzhFaDUyM0QyZ1ZKVVh6ekorcGJ5eUdCaE1TQjFqdEhv?=
 =?utf-8?B?WStpek1mK2dvMVdRUmdzQm9oUG5mTUVPR2UwLzNTWE5JQ2NTbnNPT1AwN1hi?=
 =?utf-8?B?eThvSGNyQU4xT3hwaVppbW9mbSt2UzgyQU1DUVY0Rlh1K25JOHpHcnA1SXpj?=
 =?utf-8?B?WTlvWmtTMlpnQW0xNlIzTFQ1dElmN2ZhdjIzYUV1czlNWmkxbEFjRW9EWDM4?=
 =?utf-8?B?bkFIWUw0NVdXZHp3UjBpNkdvdjZ1RUg5VHMyVVFCSk1acFZBei9MYXduRXpM?=
 =?utf-8?B?cTdtamZpS2UxV2pZTFU0U3daYm9FMkVPWUZkOFo2QjNweHRRTTFmRnN6Z3lI?=
 =?utf-8?B?eCtKMzdheXI4ZDE3dEY2ZzBCWkg5ZTAvWjhsRTExYks5ajV1bThBK2V0SUMv?=
 =?utf-8?B?akJtSTI5enhoTStnQS90WEZETDN0R1RXanZQL2U0Rnk0bnJTbkpNN1Ftdm82?=
 =?utf-8?B?aWxFSC9HWnJGSUdGM0FodXRGMUdTUjlIVFBMR2RvWW1jdkpsUm5lL2sxdDFj?=
 =?utf-8?B?ZHFJNi85ZkdoMEs0RnlBaEkyMTlMSzZNZkdqeTFLYnEyZlpIQ1Q5RDBtb1RZ?=
 =?utf-8?B?czlLWncxbHlqT0xZd2xUdlBZQjI2cXZnUXRsODV3bmUwMCtKUHNXWVJWZHlh?=
 =?utf-8?B?S3lEM1JBODhHdGFxUUU4dnZqWVUrTVg4KzBMWXVpcFdZZSttUi9icWZaQWhY?=
 =?utf-8?B?ZTVEWUFacHJxNFZVYXVNS2NqdEpjajRzQjdxWWw4UDQ3cVJTaXZ5Q3Z5UDBs?=
 =?utf-8?B?NUxiYnZ4QXVYVi9wK3JEcmdlUUtnL2dnSWd0MWhjNWh0TDRUSDE5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eb090fcd-0ccc-4164-16ae-08df4b13d47d
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:47:45.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4wLDgs/CDZmWz0IwmUl+tOK2F9CKlupGYxxSrw3l6rQafAMGsOY87b+6vCvTGbGvpeNHnllhymX40uaJHChbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP265MB042256
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 24, 2026 at 12:29 PM GMT, Philipp Stanner wrote:
> Some users don't want to perform a full call to synchronize_rcu() if it
> is avoidable.
>
> Add abstractions for get_state_synchronize_rcu() to obtain a grace
> period identifier.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  rust/kernel/sync/rcu.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index 0daa1ac87d81..7afc78b34759 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -86,3 +86,13 @@ pub fn synchronize_rcu() {
>      // SAFETY: `synchronize_rcu()` is always safe to be called from proc=
ess context.
>      unsafe { bindings::synchronize_rcu() };
>  }
> +
> +/// Obtain a cookie identifying a grace period.
> +///
> +/// Returns an identifier that can be used by other functions to check w=
hether
> +/// a specific grace period has passed already.
> +#[inline]
> +pub fn get_state_synchronize_rcu() -> usize {
> +    // SAFETY: `get_state_synchronize_rcu()` is always safe to be called=
.
> +    unsafe { bindings::get_state_synchronize_rcu() }
> +}

Please create a new type for this since people are not supposed to poke int=
o
this. It also saves you from having to make cond_synchronize_rcu unsafe.

pub struct RcuState(usize);

impl RcuState {
    /// Snapshot current RCU state.
    fn get() -> Self { ... }

    /// Check if RCU grace period has been completed since the `RcuState::g=
et`.
    fn poll() -> bool { ... }

    /// Ensure that a RCU grace period has been completed since `RcuState::=
get`.
    fn synchronize_rcu() { ... }
}

Best,
Gary
