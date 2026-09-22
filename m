Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617ECC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC72410EE48;
	Tue, 22 Sep 2026 19:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="UUSb6C5q";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021138.outbound.protection.outlook.com [52.101.95.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811E810EE48
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XogQcQ/Zy+WwnyyxAl+dKf/9BvPUl+IIUrSU5+MLM6SUKVkk/3rlwtKoI3rxU1Q+Op2TnJxKPQoHwTH6LuYzLTQv18sm5jedw+vhasnVsauUIQhobM5XhP577nHIPAmJmSPXzOJ+N5EkJ5KqCeoOH4TPvGf7ScVXXbxj+HrLw8VBHoETWNPIo76U9wPb01CU8qVALcQuoCNRTwsM0P6Q8niX51TivK7GRbV2XYJItuvYiKoTJEl1dyicKU2ir+uTD7cr0OlieSWB3YeTPmFPbm88WUrc33e9e2970iXEE7E9dbxQE2yXM6xtlQ+g/Mf684la+QGQKz26zf6zwtQq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osBfJJ4rJm5eY2erc4V674hCwuT+xpYPkOrWRt5Uuww=;
 b=BaPpSAVXpF2QYnu1D4hLL7Jgnu9cm1cfJCs9/qadl9cH8kAFLpkD06nEfh4acEZkkazmFIz4xqQ1deuO/C+5MMM8ISGwsZwI1L/x4AV+0uiuKlukkat5rbbnzm9NC5ygmxsUtN6bi4HwPvyE89NZehdQtx+f0yK7EDVBqvRPUhYuzx+9k4V7xYDnpuc+ubo0pWEASXbRD332ASM0BV2Xbs5NcgIV/26V98grLJUkSztzVZF+r/k/MHuti4qXFlUQwJPjNGlXKm95zjPhpUmlTirAVXOtb+ErfmTtyhxh/MasXemRp2d/e9t3EwT+5oMeko2mEQWrLfBN5C5bmAx+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osBfJJ4rJm5eY2erc4V674hCwuT+xpYPkOrWRt5Uuww=;
 b=UUSb6C5qYkaFnYAjbzrvWU4nA2aNPNVOl6k3S8cXzyiz4ql3NJ3z/m1eZjseaWr7k1UasmiPckS8/xLVNdvCtXicSqANoFBAyTE/9t7hdtGZw0YQzMXXXNlTIgLvfFJsiSpPmDwvsYY0wIIwxBIVXCALq5y0yJcRxLuslbpf1g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB8942.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 19:56:48 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 19:56:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 20:56:47 +0100
Message-Id: <DLM3Z2E1V1J2.4VUZLWQVEQTT@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Laura Nao" <laura.nao@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Lyude Paul"
 <lyude@redhat.com>, "Thomas Gleixner" <tglx@kernel.org>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>,
 "Stephen Boyd" <sboyd@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <kernel@collabora.com>, "Deborah Brouwer" <deborah.brouwer@collabora.com>
Subject: Re: [PATCH 7/9] rust: time: add arch_timer_get_rate wrapper
X-Mailer: aerc 0.22.0
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
 <20260915-tyr-interfaces-v1-7-5d28f1f75aca@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-7-5d28f1f75aca@collabora.com>
X-ClientProxiedBy: LO4P123CA0579.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 56787703-5741-4c16-3a91-08df18e3a358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|10067099003|56012099006|4143699003|3023799007|921020|6133799003;
X-Microsoft-Antispam-Message-Info: L0+B3S7ogzUehDkUhOlMVX1zLY58g1+HpleXNGPALcUMIHyhK2Ui0G2043ZrZlq27SUBuqDKTbHTJfw5g5KKr90iviobYgFT8HCNHPFaprAZEL1a1Nna0bYdL+7DZLytUfYjkMEIaYCs+fp8fY2jTGbtnZ8eAIlIXMiOb54s4yl+FX66b22+Ph8xkzhR6sHdO4JpwJIT40AEN7s2wAJWekxZTETjbKr9jOqcPpMua2gXjTNHMYRUvcgENX0DlfyjX2YrTyCtRj4wit4PGiQV6ndZVVSvtQkOQGo6edDDqItOwCjkTyYwsRlrQ+hsOtD86qRGwG+wP9L1czIP59BSpFBj/IGe9JYZliQTibc9r5uVam4o3ZpWnTmBrH+jhDhcHVSa4LPHtkzE5cjihq1V2VDYxqdYru/IY2GTVcMZwSCOze0cpjKoeh1MRW4n+7zOwyDpD+hKen4EqZmhJhwCR7zFPxAmZk0zmCNnqIJYJl/BFeYjubYbju7eWp4NA6Vc2wiBCxRrpN7wBH8PKKfWoViFkXFRY7HricHA/ZMvIWB9OZXilxg2oEnfK6dCGOtGAj+qDwhhfc4mX8D7I3hbXRkzpZAB5FRjdAAKewd1jdmuk3R+0qUfGIQ/m+g/3AZfRquOioujl+eEmicckvtkH0Rw8QwYudJ9iqoqVI9yev9rt01RTvmgzWe3VEGLibNIAbn82z82hqQj1Bk0oqS2cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(3023799007)(921020)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVh2RTFyRk1GTTJ3LzhpK0o3NDkwbG5WWWhRbjZvT3U2aXRLNmdqTlRkd0E0?=
 =?utf-8?B?U2hmdnptQmllMmdUajVndXBtZW93QXFwRmszSmNvYkRvb00wU096cDdBdldv?=
 =?utf-8?B?ZnhzV29qckdLUFU1eDdtbDZ3Y1NmZU5TUWN4QkdRZ0gyV0xUekdzUlJxb29m?=
 =?utf-8?B?eEFOSWF0UWN4YTJIcWdWTDVlQ081V0ptTjhaSFMwSjZrRDdaL2dKNjhrc1RR?=
 =?utf-8?B?SjRIRkNuSUVxTXpVbWVHMjJrNGYySW5GWEowaVl0cEdpVUQrbEFBZ2hlU0t2?=
 =?utf-8?B?NFV6L24zMlBNRlo4T3N2TGJGeU5zbGNXUXJoRGNBKzRlWHAzNGIweGFWanhZ?=
 =?utf-8?B?akNxNnpPQS9kaUU5aXdqZC9TdVhCQVBsa0w5WTdudFl5dnM3RHc5b05CU0RD?=
 =?utf-8?B?RVh6bVc0YTJuL2g2UmdDcW9UWHNqQms5YlRrU2NqZlBhdmYwYnNuRmZxYXE0?=
 =?utf-8?B?MVJkcit1MmdkWmlROS9wWmpJZ2dlTW1RRFJ5eGRGbHY3MTBOQWcrenJtaVNu?=
 =?utf-8?B?WkczWHVFOG5YVHB2WTdQdVNaUmg2ZDM0M1BoM3B5M2RHYURzOEZqcTkydnE5?=
 =?utf-8?B?VlBUWEk2L081OVdsa284NlVLMG5Oc3F0eGVTcy95UExnT2pTL2Q5TmdCU1V2?=
 =?utf-8?B?S3owazNieTRpTW53c3grSXpudVlFY0w5OHV3TW5MeVNFa2pTZkUwMDRRVC9y?=
 =?utf-8?B?TFRCek9BNXJNSzlyS0pEZmp6Qk5kNU5PbzlMTTIyR2laazVEemZDS0x6ZEVS?=
 =?utf-8?B?NGpyRFRJV0ZraUY5RG5oMkFJMm1iaGk0cVJ3MHUzSmUwRFJTamVLNTkzRExh?=
 =?utf-8?B?ODFXc3ZWOTFjRTgvOFZOa0lTRkJUZWw2Yy9lZ3Z5d3JKT1BLREEvWUVOVllh?=
 =?utf-8?B?ZWJnbGpKbDFCUFh6YmtNOVVLTUJWdzZ5V1lqN2FEOCt0aFZ0OGR3dHdhTVg1?=
 =?utf-8?B?a1RGQXBuOWV2NWtVaExrcitjUHRCcmJmcDhERjh4ZUtzRytERFpZN2pjUWk0?=
 =?utf-8?B?VkdwWUZlbll1MUY1RjN2WWoyMGpDeHgzVENRUUpBcU8ydURCdnFyK0lwU2My?=
 =?utf-8?B?RTdTeU4xZDdaMDB0Z0xkdzlwL1FNWHJ5bkNvZGlsTWNBWFJ0ckhnRENkMGU3?=
 =?utf-8?B?VWxTZGlzN2xVbmErVms0Q203Tkx0Q2JGdXVYY0Jwb1h3dExrUUZSMGpDcTY2?=
 =?utf-8?B?bmtBKzF0aVpLaHRWYTdpMGYyaEVwN0w0VkZqa3QzdiszL2FHNDZNYTVLVlI3?=
 =?utf-8?B?MnY3NTRJWlVtYzhCVTBzNTJOSFExSGR6YnJFc1pFcnQ2dGFldCtHUzNjLzlo?=
 =?utf-8?B?YjM4ekRPa0pkSUdNdmpFN0hoWUlDbFNBWUdDeEd4cE1BSGR3a3p3SlRTblBp?=
 =?utf-8?B?bUc5dUFZRnkyOVpQMzVKZGxxb2FJM2FjOFFWT05MOTVwY0VsQVMydEI0Q1RB?=
 =?utf-8?B?cWRDSzBwdUUwVkNCaURKNitQK1liaGc3MGFxbTd3Zm1xdTE5anpyMUV3bGFi?=
 =?utf-8?B?c1JnMGRZMmtjQm1VZCtpZnZLUFQ0QzJLTjVvaDUzdFFhaGNnU3d2K3Yxc1ov?=
 =?utf-8?B?dm5nV0tKMmQvbkplM3N2VXZlUjdLbkh1ZjVYV1YvM2NXeXJaQ244MjdJRHhl?=
 =?utf-8?B?K3hRMVZhMG5NZm1zbWlhTlVjVy94emJNR05VT2dqT2xwRjVqb0JLWlJ2VnFH?=
 =?utf-8?B?MUFtZWZDaTllVVpjM0pIcnlHcDBKZitFWFRKVWpHOStEbXEvclNYMFZLUHVs?=
 =?utf-8?B?S2h1b2o3ZTBRSGU3clA3VmR1V0wzdU5QUkFOdktNdmpZK3U4Z3owamZaSUNN?=
 =?utf-8?B?ZG1xSCsyTWhpWG9vR1lQazA0Vm9pZUlLeTdGYUZ1clo1MnJhdUdtM0xsckJr?=
 =?utf-8?B?bGZSa2plUGV6SGVNcDRtTks2N20xRVA5Z1NoMlROWnNjUE90SEs0NDhRRGR6?=
 =?utf-8?B?RzVZcW5nS21kWVhPZ0FIRngySHRaMmlTVzlrRTNGM0V3aitVTjJiZ2JpR3dD?=
 =?utf-8?B?WVdZTitpbDg1OHhmUWxycG1nbUM4bVdjTUdBMUZ6OUVlck5acG85R0ZxNk9R?=
 =?utf-8?B?VGRhcE1UMnF6NWVuWUF5VDI0VGpKOEU4M3JDM0xNUEVpaXVveTB6eW5DVU1E?=
 =?utf-8?B?SXdFL1ZpNEZVTmF6clpFTC8zelpLRU92NVpnVEx3dlVjUlZVQXVxWXdHQ3pX?=
 =?utf-8?B?cnVtN09GZUY5WnpLRUsxMFc5R1BPTWc3RjlkQmtCRWh0bW9MT1hxREkyTWVk?=
 =?utf-8?B?RlNUSndaZHBXNEQ1WnlxL2NCTVZBeVgwOEkrZk9KYUJLS3NKSXZDbFVGdFpK?=
 =?utf-8?Q?knpQ4LMMfRBZ1fZQBw?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 56787703-5741-4c16-3a91-08df18e3a358
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 19:56:48.7632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq9mW4WTKwOslkHpgeHxBPnXMMOIE8ZW4CWKd4joe91wpVAexjB6H5ceMLTeOq/vKrvgTVp4rIpzh+I/35+hjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8942
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

On Tue Sep 15, 2026 at 11:57 AM BST, Laura Nao wrote:
> From: Deborah Brouwer <deborah.brouwer@collabora.com>
>
> Provide a safe Rust wrapper for arch_timer_get_rate().
>
> The Rust binding calls a C helper that returns 0 when the ARM
> architectural timer is not available or not yet initialized. Map this to
> Option<u32> to make the absence of a valid rate explicit to Rust callers.
>
> This allows Rust drivers to query the system timer frequency and
> select appropriate time sources when programming hardware timeouts.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  rust/helpers/time.c |  6 ++++++
>  rust/kernel/time.rs | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> index 32f495970493..70fda31bd758 100644
> --- a/rust/helpers/time.c
> +++ b/rust/helpers/time.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> +#include <clocksource/arm_arch_timer.h>

The header is from arm_arch_timer. I wonder if we want this to be exported =
from
somewhere like kernel::arch::arm::time?

Best,
Gary

>  #include <linux/delay.h>
>  #include <linux/ktime.h>
>  #include <linux/timekeeping.h>
> @@ -38,3 +39,8 @@ __rust_helper void rust_helper_udelay(unsigned long use=
c)
>  {
>  	udelay(usec);
>  }
> +
> +__rust_helper u32 rust_helper_arch_timer_get_rate(void)
> +{
> +	return arch_timer_get_rate();
> +}
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 6c0a5e8090d0..6c48ce21984a 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -423,6 +423,36 @@ fn div(self, rhs: Self) -> Self::Output {
>      }
>  }
> =20
> +/// Returns the ARM architecture timer frequency in Hz, if available.
> +///
> +/// This function queries the system-wide ARM architecture timer frequen=
cy.
> +/// The architecture timer provides a consistent time source across all =
CPU cores.
> +///
> +/// Returns `None` if:
> +/// - The ARM architecture timer is not available (`CONFIG_ARM_ARCH_TIME=
R` not enabled)
> +/// - The timer rate is zero (not initialized)
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::time::arch_timer_get_rate;
> +///
> +/// if let Some(rate) =3D arch_timer_get_rate() {
> +///     // Use `rate`.
> +/// }
> +/// ```
> +pub fn arch_timer_get_rate() -> Option<u32> {
> +    // SAFETY: The C helper is available in all configs; it calls
> +    // `arch_timer_get_rate()`, which falls back to an inline stub retur=
ning 0
> +    // when CONFIG_ARM_ARCH_TIMER is disabled.
> +    let rate =3D unsafe { bindings::arch_timer_get_rate() };
> +    if rate =3D=3D 0 {
> +        None
> +    } else {
> +        Some(rate)
> +    }
> +}
> +
>  impl Delta {
>      /// A span of time equal to zero.
>      pub const ZERO: Self =3D Self { value: 0 };


