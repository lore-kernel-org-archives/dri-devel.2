Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAC2CA5FCE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F6810E1D1;
	Wed, 30 Sep 2026 23:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="aU88aykS";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021108.outbound.protection.outlook.com [52.101.95.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CCD10E0A3;
 Wed, 30 Sep 2026 23:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VL0zp6Tyn/9pDFBm8lCEfOcpfKA6BKibe/C05IfJ4198R2i91jljPVfY0zupcXXg6f4ssj9+d4HMA7VtEb/xS3RBPyCWXbpqTqqB7r30XvRdoVvskqB2cvPf54E+Ajfh3DWOc/IOeQL5k4o+yUbS/kxwNbvXCxKc8TXCO4bEJYSKAHUJPCApqKKYdTmilmQGxD5lQByfuWkXaP5E1hsQspemedIZIIBx0nXfk19kXi/bwpmZPLEmvnaP1zoR+SydxJOm0tz3okVFZLyO3voUu/ZNTK8rccZ0jrNUqdWBHhjgWQlPMe9NJhfHm1aV5oasRgDXt3W+NsLfD2edHdzMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqGcVEeAFwo+Ooq5Pr4jogEeuGA+lCatvKDSIZfQSx4=;
 b=dRHc2ikTJB3p6KY2xogVW7GkfvQ5H+MCtT6OEfNhhQY7H96t44uhuaqU3PmpEA1kjB2LYtCMRARvTclcC7GQZBjsEwaYgVk/ljsbebkrxurRTOkfcMztkij2rYH8Viv4bChzBpAZ2Ek3c63CODRpFmfhlKCgzo9SgRTirn6q/LfORK3wtGXiZZW/9vMsBdKGcZRWeaDpSc6eaWen7g41HzBqMIa0rLuSLQZooeRqUV/tAvcZeAtbK0dU9ClMXOqVoTKykThQlSse2CXE0+FBungx9WAJxz/vhDmYiqaGbTWdtQn9iA2+xJLryQZZYtpbWsyZ4NnGCosqGrsvo+Uiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqGcVEeAFwo+Ooq5Pr4jogEeuGA+lCatvKDSIZfQSx4=;
 b=aU88aykSk2Qbtnawl/mrUQRBP7vXYcl0GiUvES1G9xnqULQZBtyxa/TMteifGYTjwApvImMbWzS2RTraGe+if5+NHQqnFDf7zAu5gXYPqv4qqF+9vEeF1DS+smd/cJmGa4hiAjMcBTg/IUPBKNdLfNv8lnVpUbZJ/P/LegqiOCU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LODP265MB740586.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:29:20 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 23:29:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 00:29:19 +0100
Message-Id: <DLT1I5F55U3W.2N237BGZ1EDF1@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/6] hrtimer: add expiry injecting callback variant
From: "Gary Guo" <gary@garyguo.net>
To: "Thomas Gleixner" <tglx@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "Frederic Weisbecker" <frederic@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
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
 <20260825-expires-v2-v1-1-90411c6217c7@kernel.org> <877bk3ixp5.ffs@fw13>
 <DLSOFOGGZC92.12KYHEALX1271@garyguo.net> <87qziah0uo.ffs@fw13>
In-Reply-To: <87qziah0uo.ffs@fw13>
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LODP265MB740586:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfc0942-db3e-49c9-7fa8-08df1f4aa6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|376014|7416014|10067099003|5023799004|56012099006|4143699003|6133799003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RyhWbGK51sujMH6IfaRjAnNH8pykt7tjtiO4yMt8YQkqsmKmMG5djUJ567WYp98//m/kyqru8Wg6VRFEarqdTf4GdX+CfwFIiHl2WJo+CKs0XdxBjznekdL/rsepX62nbVKMrxOPakDrqtgQm5dadzUSgNSrUHs8fkK94kNrGRm6rKpEsMHzsiqBJlQv6ULDGsELcn/8CPBBqJg4l8arBCgsvkuiG8LDMIH8jafuXfSti/4RAXn6L6SrIVo0nIluoX53J6aQ+Ja7Oj2jBuyEGjd32T1CcuBLtdOLdYDidwyKFnb10nfgzpRMj4PcKlQvVls3/Yu/BnntDwE017YAvZ/r3E1d5Z65gqvdE+noyCpKo3jf/nfpgWKFSgvbVdOZ7MucwaJ6LGn1wF+g1LqN6YyJ2VMDk/KfpR5DEFJzuZuMbhJp/k9m1rrF42VBAaSnHm3QY6pN7cMAuklmqwkvAINvM2BQTI5cipee5zWmCaH3oeiugfS9gb/D8zVxLe6otXtBxtyeyAEVlZNBWnLjgwcVlRkgOr9QIk8t/GeU9UCdoYN8OZJ0O1XkMEsN2WblbRiUr+Um0lXwIQPsOuq6W8B06kL6xW0203FCy3eQldfgBSxcTC8DriTK1Imk/xFjUx38fuyPOuAg7QbCDD7H9C/AuKn64AGMnn5P/0jENKuh5ezIFYEJHxxK7rfHehoWJjEhxCnsBwU9gW/gHYCceg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(5023799004)(56012099006)(4143699003)(6133799003)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3hhWjUxeFE5b2lhWlpZNVNKNjdIRm5WdThqNWpGVlp5WlVNTHpsTEluc1V0?=
 =?utf-8?B?Ti9XdGpKT3FnemRrZmRLd0Q0SzBzLzY2TUFiNzdEYUhLK0EwZlVlTUk3cmlh?=
 =?utf-8?B?THI5NDRyZGtTQkVBKzFLWEE2RlZXSjhPZFFKVWRKZW9VdlorU3pGd2pUWHVt?=
 =?utf-8?B?QlpnYVVYSGNWeGhaN2FzaURRWWkxMHpOTmlnN0VYR3lzZ0VNQzNnTkptelky?=
 =?utf-8?B?TVdDWVcrTzFKYkt0WmJSaUJwb2RlRlAraUNTK1FocTNPdkd6Zk9LWXdKbEVi?=
 =?utf-8?B?eUovb0UwVEJDbUFKTlArOXhnNUcxcHVTYVQ5Zmc5c1E3MktHZkhDcDZKNGZ0?=
 =?utf-8?B?alQvRy84TGFYUTY0cEcxam5jdkJmME5lWENSL3RHbzFPNmZ6NTBwYjc3TE5H?=
 =?utf-8?B?L1FaS1AyK1J0dFUxTW5QSW50aEQ0czlBVTZzUE83am1lL0wzdHFCaVoyaDNa?=
 =?utf-8?B?VmhYTXlUUUtZRFdRL3FVMENTanJsRGhZaThpRDdzUGxZcEZBZjlreWJQdkhH?=
 =?utf-8?B?a3VleCs1Skh2aWJxYVJOVFQraVFwOVQyYThsRGRCM2g4aE5SeWtpU2tTNHAr?=
 =?utf-8?B?WGduU3VUU0Rpb2JDanlFcWJKbTdDWXdvM3A5N2NIWFdvdHZ0RHNOSEFZZHR5?=
 =?utf-8?B?aGt6WmkxaGMwMFRlL2l6UjBtS2p2bmxiRnkrRkRnMUJSR2JJaGc3NVR1Q25T?=
 =?utf-8?B?YmVJM202Qk9PTjJ2RUI3b01JZ3IxdjJSeVZZVFJjU2FqcGI2REZjK0x2ZFl5?=
 =?utf-8?B?WHNIaVRTL1NaTUplL1l0Q1R2SFpndEJCdWxDRzBrd014RFpEK3B6MGdqSmJR?=
 =?utf-8?B?aFZ4Zit2SThZTTZ2aWRvRjkrN28ydzJrUHJsMDlvR0tDNFlkZTRUV0hIcmZE?=
 =?utf-8?B?SEpqK09td2d6YU9TbFNodkhkenU1cUJoaHVtWU1ib05vZzBMK3Z5ZzZDWFVz?=
 =?utf-8?B?NU43d0RadjZSSkd5MzZMUHdZTmROV1hlNjNuQkFteVFTN09PNUFSNGl1R3Ju?=
 =?utf-8?B?Skd1cEl2WVlmTm5aVk11U3prRWJCZ205NFdXNkdKTXQwZVVFN2tZUFRaTVVE?=
 =?utf-8?B?Y3E2dmxtTTdybU9ScTRZQi85S1VhbU9DczFOKzlISjhCd3ZzcEpFN0NWaGNt?=
 =?utf-8?B?RjFheWxEL3czak5UYlJ6cjNQZ21KOXV6eWpZTS9IcHBsMnRCZ1RHS0Fhc05L?=
 =?utf-8?B?WGVsWDFGZFEvYzJKY0o5aFIrajBSVTkrWk0vb3NYb01zMkxIQ3JLdnJtZktG?=
 =?utf-8?B?czZlTDBOUS84WnRTand2djVtUGd5TE93K2dOYmo1UFdVSzM1dENKWVViYkl4?=
 =?utf-8?B?L2NWd0Y2VW1YSFpZWVlxY3FDU1A0aXB2Z21WMUpmSnNGWTVudVBRc1BSZTI0?=
 =?utf-8?B?aWc4RXZGYkpTWXgxMlY1RjIyelNYRWlZNXMwczQyYnY0cldGTWg3YUltTTJy?=
 =?utf-8?B?Mk82bWk0Q1ovbzlwT1BXNkM3enAwVHJWTnlycnVmQk1BK0YrYk1hVzhCbXlH?=
 =?utf-8?B?MnBzT2pyNEt4Rm9wQTRDWjVjTlE3ZGZBeGRkVXl6dWNmTmt0YzVkQnR3TnRk?=
 =?utf-8?B?NTJhODNNeEs1d1d3SDB1ckduMFVSdGdLMUcycUpFcDYrZUpRZVZXd0JYMjZm?=
 =?utf-8?B?WEZkTlY4OGxDT1d4YjlYNU9hZXdwejNEbWEyWm50bHZJTEZnaFJzbFpvcS9J?=
 =?utf-8?B?REpzV1EzQUJOTnRRZkpMak05UHhmOUhJVUpiOXZ2TWQrTmFuTndza1RTUjl4?=
 =?utf-8?B?czZ1elZYMmRUV0EwcU5OSHpXQnR2TlU1WDZaYzVPeWtITHg3aHFNWGNNZFJG?=
 =?utf-8?B?ekVPM3R6aFRFVTRFMmI5UGE5S3U2dHB5QWpGc0VGV0IwcjhQalhHNFJ5ckJX?=
 =?utf-8?B?NmdWZVpJMGpsVTNhSUI4WFltYWVvd1ZPdEMxMXBMcW9OL3hRVzdFVUo5TjVB?=
 =?utf-8?B?YWw1UnBaWElxcmtjL00vYkhKMUpNWnlxMTRIc1R4U0VET1BsN2VRY1hoRHNZ?=
 =?utf-8?B?RzFpQk1oblEwUUpkb0tGN3ZjazJmRnladUlWL0JpSDA5UHlnS3hWc1l2dmNo?=
 =?utf-8?B?RjhIMTNlOGpMaThFYnkyNXlhRkxnd3QvRk5KZnlpN3RmWXZOZ2haZVJKOTJt?=
 =?utf-8?B?ZTN5aEZmTzRZNytQN3VDMHl0Ly8yZlB1V3QrV3dHeHhrRW5OazRnYjNhVEgw?=
 =?utf-8?B?QnArRGlQbkRuQktPZXFub29YcUoyQ3RCQWVzeVQ3TjF2dkxROGhzTE9IOHk4?=
 =?utf-8?B?M2dZajcyZkVPL2JsL2w2b3pickEzMWpiNTNTMmRRK3d0b0FLNms1Z3JvSUhK?=
 =?utf-8?B?eUpJbmlVa21sTm90VFpQZ0NVeEJwUkkyOXhSZ2UyR2RWb0ZsRExYdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfc0942-db3e-49c9-7fa8-08df1f4aa6f7
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:29:20.0177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7iGqlKoOpfIc93DxvjfgGbyazUWAbWPk9Fwd0RXjgH2CUkbDIkA56YNxePU0Xl2+75FLXgXH9gi0MfwMSeE0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP265MB740586
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

On Wed Sep 30, 2026 at 10:43 PM BST, Thomas Gleixner wrote:
> Gary!
>
> On Wed, Sep 30 2026 at 14:14, Gary Guo wrote:
>> On Tue Sep 29, 2026 at 9:56 PM BST, Thomas Gleixner wrote:
>>> hrtimer_forward_safe_from_callback(timer)
>>> {
>>>         base =3D lock_running_timer_base(timer);
>>>         if (!hrtimer_is_queued(timer))
>>>         	hrtimer_forward(timer);
>>>         unlock_timer_base(base);
>>> }
>>
>> FWIW we did discuss about this option. Here's the list of all options th=
at we
>> come up with:
>>
>> 1. Take base lock before calling forward and release it afterward (the o=
ne you
>>    mentioned above). This one requires exposing the base lock (at least =
to Rust
>>    abstraction).
>
> Why?
>
> With the above C core function Rust does not even know that the
> base lock exists. Rust invokes the function and relies on the guarantees
> it provides.

Sure, if all expiry read/update functions have their _safe_from_callback
variant.

>
> And the function is not Rust specific at all. You can use it to paper
> over the i915 bugs too, no?
>
>> 2. Prevent timer operation from within the callback and have hrtimer cor=
e doing
>>    it (Andreas's patch).
>
> Which adds overhead into the hotpath and creates yet another weird
> "scratch my itch" API.
>
>> 3. Force users to stop the timer before re-arming. This was dismissed be=
cause
>>    stopping the timer will require waiting for the callback, and this is=
 prone to
>>    deadlock condition.
>
> Obviously and that's one of the reasons that the code is implemented the
> way it is, which puts some reasonable responsibility to the users for
> the sake of simplicity and performance.
>
> Now you want to reverse that and add overhead and complexity to the core
> to cater for the potential stupidity of users without even solving _all_
> related problems:

It's not our initiative to reverse that design. That was changed long time =
ago:
https://lore.kernel.org/all/tip-5de2755c8c8b3a6b8414870e2c284914a2b42e4d@gi=
t.kernel.org/

Enforcing this would be more favourable to Rust API's design. FUJITA propos=
ed an
API which would require user to cancel the timer first before re-arming.

The issue is that for users that do want a concurrent restart, like in perf
core's use case, special care would need to be taken to avoid deadlock, as
cancellation code path must not have any lock held that is shared with the
callback.

>
>    You again forgot that simply setting the new expiry time from the
>    callback without invoking forward() has exactly the same issue.
>
> Maybe you can prevent that on the Rust side, but the C side still allows
> that so your magic new callback is just providing a false sense of safety=
.

That is indeed something we didn't consider, as Rust abstraction currently =
does
not provide a way to do it. We could change the forward return value to jus=
t be
the new expire time.

    typedef enum hrtimer_restart (*hrtimer_ext_func_t)(struct hrtimer *time=
r, ktime_t *expires);

I've kept Andreas's name to not have to bikeshed on it.

With such callbacks, users would be abel to use a helper like:

    u64 hrtimer_compute_forward(ktime_t *expires, ktime_t now, ktime_t inte=
rval)

to forward the timer.

Alternatively, instead of putting this into the callback signature, struct
hrtimer could stores an additional expires_for_callback field which gets up=
dated
from callbacks. I do think existing C callbacks can be converted to use suc=
h API
without too much churn.

>
>> 4. Add a lock to Rust side that all users must take to forward / start. =
We don't
>>    want to add a new lock just for this, and taking base lock would be m=
ore
>>    favourable.
>
> There is a reason why it is documented that this needs external
> serialization.
>
> Neither this magic inject callback variant nor what I proposed solve the
> underlying problem of two competing contexts which try to rearm the
> timer to a context dependent expiry time.
>
> All they can do is prevent inconsistent state, but the price to pay in
> terms of overhead and complexity are very different. And as I said above
> neither one of them solves the 'set expiry directly from the callback'
> problem.
>
>> We consider (2) the best option because it avoids several pitfalls with =
(1):
>>
>> - It is impossible to forget to forward and return restart, or forward b=
ut
>>   return norestart.
>
> Forward and forget to return RESTART is harmless. All what happens is tha=
t the
> timer won't fire so some device won't work as expected. There are a
> gazillion of other ways to achieve the same result.
>
> Forget forward and return RESTART will result in a hrtimer interrupt
> overrun warning and if you fail to figure that out when implementing
> your callback then you (and the AI you are relying on) should go and
> resort to HTML coding.
>
>> - The base lock is not unlocked before relocked, so the forward and rest=
arting
>
> What means unlocked before relocked?

It's the example that you've given. If one calls
hrtimer_forward_safe_from_callback and then immediately return RESTART, it =
would
unlock the base lock within hrtimer_forward_safe_from_callback, and upon
returning hrtimer core relocks the base lock.

>
>>   is atomic. So it's impossible to have the condition where the forward =
occurs,
>>   but before returning RESTART, the hrtimer is concurrently queued.
>
> What's the problem with that?
>
> [snip]
>
> To prevent that you'd need a start_if_not_queued() function:
>
> [snip]
>
> Even that would not solve all possible problems either. That's an
> application problem. The core can only provide tools to avoid damage but
> it cannot prevent application logic bugs at all.

Ack. FWIW we're not trying to prevent all application logic bug. It's not
possible. But what's important that we try to achieve is for a user bug to =
be
contained and not cause hrtimer core to complete breakdown.

A buggy hrtimer user that never refires? If we can somehow prevent that, gr=
eat,
but that's not required.

A buggy hrtimer user that breaks the timer wheel completely by making its d=
ata
structure internally inconsistent? That's what we're trying to prevent, at
least for Rust users. As it currently stands, an badly timed hrtimer_forwar=
d (or
hrtimer_set_expires) within callback can cause hrtimer core rbtree to viola=
te
its invariant. And that's what we want to avoid.

> Adding complexity to prevent that has been pointed out to be the wrong
> solution by Dijkstra long ago:
>
>   "Complexity breeds bugs. Simplicity is the prerequisite for
>    reliability."

It's a trade-off, really. You can have simple code and complex rules, that'=
s one
way of complexity. More complex code and simpler rule is a different way of
complexity.

The way I see this is that hrtimer code will be less complex to reason abou=
t if
expires modification is not possible without the base lock held.

- "timer->expires may only be touched with base lock held" is very simple r=
ule,
  and yes the code would need some slight additional complexity.

- "timer->expires" may be touched without the base lock held, if the hrtime=
r is
  not queued, and no code can possibly queue it while it is touched." resul=
ts in
  simpler code, but the rule is more complex, and it's _non-local_ meaning =
that
  the callback code may look innocent, and all it takes is a hrtimer_start =
from
  outside the callback to mess things up.

> Don't get me wrong. I'm a great fan of Rust, but I have a background in
> ADA programming (admittedly from decades ago) and I studied the
> limitations of provided safety measures in practice enough to know that
> Dijkstra is absolutely right. There is a reason why ADA grew a massive
> static analysis toolset around it which is sadly not easily exploitable
> due to the design decisions of Rust which borrowed a lot of the
> incomplete ADA concepts... But that's a different discussion to have.
>
>> - Unlock/relock have an overhead (we didn't quantify how much impact thi=
s will
>>   be, though).
>
> The extra lock operations won't be measurable except for situations
> which have high lock contention on the base lock independent of the
> problematic scenario. If that's the case then the extra lock/unlock pair
> will just add to the noise.

Ack.

I shall add that this is more than a single lock/unlock. hrtimer_get_expire=
s
would need to take that lock as well.

>
>> I supposed another alternative is to add a mode in hrtimer core where th=
e base
>> lock is not unlocked before calling the callback, and expose base lock A=
PIs
>> (like option 1) so that the Rust hrtimer abstraction can unlock it befor=
e
>> calling the callbacks.
>
> That's even worse and Option 1, i.e. the core function I proposed is
> _NOT_ exposing base lock at all.
>
> So what's your actual argument that you can't build a "safe" Rust API
> around this?

Sure, if all expiry read/update functions have their _safe_from_callback
variant.

Best,
Gary

>
> Thanks,
>
>         tglx


