Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53019C98308
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02EC110EF6E;
	Wed, 23 Sep 2026 07:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flapping.org header.i=@flapping.org header.b="hKIQ+b69";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ph5vUBWg";
	dkim-atps=neutral
X-Greylist: delayed 613 seconds by postgrey-1.36 at gabe;
 Tue, 22 Sep 2026 14:33:44 UTC
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C9310ECC8
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:33:44 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 32113EC0255;
 Tue, 22 Sep 2026 10:23:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 22 Sep 2026 10:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1790087011;
 x=1790173411; bh=vP9NCCO9GuK9qooVOCyuEm5uZhDmllxHIjo/78tO+Pw=; b=
 hKIQ+b69lR/QRXxYIMhN3io8jvGqegQYkf+3KfmtuXmHwvr1d4DjG9nQ8gwoPrLH
 t7tEf5xGSFklaJUZt4Gy0WN+sAxqAJDmWH9yF+w/97Py/EiSSU57WKYSwcG0nqWR
 g1Tu9GUexW8diP8C9ufusBxWHmXEFUeMQCQbFnwIHiDq/+zQNwXxD0+ue9rIUWfo
 29QiX6ZEFWwqTP1RZSCxG74pdwV4SHeP+Up2cflBJX6ebZ0sqUIiijdAfarTrAKP
 PdM5ePnLaIEcwDRWUu7x+vGjyBIBXe8XpeMP5o9lLMQic5uCkH+F4iyTVK587JxA
 NufaDHWtXpbOIsGhFlh7JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790087011; x=
 1790173411; bh=vP9NCCO9GuK9qooVOCyuEm5uZhDmllxHIjo/78tO+Pw=; b=P
 h5vUBWg/zqWLwJ3jfioGfIW5O93B51vdG0eAIMr0XgaVXQEBIshZ2iMG5trr36Vz
 Ydw3JO+R4LwRxj/TrNh+PNwI0M1WHXP7NxTfCGhq/c2v6ekJXvFlMsjyHXUPJPXr
 SamARGuooAvITbRf2lvkI3If7/gr0KEyTQzsu0UkCFEOLj6DEjpF+oLBEHwtej6o
 LD8JuFU9eNtyOJMiYPgJBZ8+ZU7rFnaO0EhuGaKXVY/xMnr1xFr4NTQvQkZ92oPu
 h5dpa6rSDEBffRKrKw6u3qeosHoZMPOTrlxyOIFNCfC6DdA57wHyMy4jUaZvf1K6
 0qAFkeIDvqJ61Hurzi4nA==
X-ME-Sender: <xms:Yo-yagft1iuBg0Moau-V9TpRXe7TF3Rl4fFe1jhIe1YwqTuCwx8cWQ>
 <xme:Yo-yar25NtRX4YACu6-EoQb66NSBZ8Mwt9c5ZvITC7PrQY-H7rcWichADrH9sb5g8
 xiGBN-EHZVSATX-S2sE-4XbUMP5M5XR2e2tSN0mnsvq5BXIYcLfTgM>
X-ME-Received: <xmr:Yo-yak9LztJJXV1dFMLrh-AgCwOvUOQ4ppAS10y9TMxikYYSB9-GQ2J-XUu0z-fYYhJLjDwgOhVI7n_PDQeGYAUo>
X-ME-Proxy-Cause: dmFkZTEcJYB+omvP8dKlV8xLth5GXJ9j9iW3ImwKvcGSnFTaE1WaHA/S6NdnJnJz5sVdcu
 udISQMbDm1Utl/4u9jvV53Ek+Dau9nZwvw7jCsTZ5BOJw68JI8i8AoXErQHGQdLuYaJqCO
 1DsMx0CsvfR/0TXTf/hlGG69sFRJAVk6DgoRC1nBkVoLNjBXp9CJijOD3wfGdD/XNcI0Nx
 F9rlHSziZe7faI9Sqt0fnkmUDT1n45sqCtDtErj5cgRBAthfHe61UohNgCrcB7pBu+Q1of
 jDx1BQt+VKrWYmXJ0CqRRiy61a54Iq4EH73BVzXMbbfpRoylz1TSYmiRd39FZ+VxQftXgX
 +/wwHCAOvtjuplHisUySsny9LTygpJT1hKU/p0pseGQwd7987T250xY6fNhXVs52gQr6DR
 PFfkm6+8viVF17bl+Uiz7k70PT5gkeFyYAYD5iT5fOHFgIjMweaMraarPvoTV6sdecxrNG
 pgNgVN1sY2Mh7JvuT+YAqwEOMiHPNJKsMYWcyAV4QCoEaPjv6qMoYn2tN9Eq7jdGLG8fcZ
 IZQ4mx8dJ/0vZwIu5e/KkKKtuhog2UC526w96lZUWDQymuDjAuEOerOJkQISTfdR80VuKW
 //M2bIJDIKUkCs16z/dN+8SVQo8oMvrg4bDqJEg2KvvnyoeQHDu+PxcKm2tQ
X-ME-Proxy: <xmx:Yo-yas3qWnYcWEfBHh30sGl2NQQAkL5MU6c0HdL_mMZZdz6Y5uh42g>
 <xmx:Yo-yan2FfEkMXR4iiVVYfnFqEuYwJzC48_PFZGOMWn7dCBuoXdmWsA>
 <xmx:Yo-yaotjJDOhw7I-Z_CLJ72MQ0hlmcWxIg123uu-MJZLbXJF8gd3fA>
 <xmx:Yo-yanbyKiAd26Fu22DY9iVo7t2HmDOxjeE9GD9cZ9E9yhZbKL1U_A>
 <xmx:Y4-yarhE8reLxNjsAl-phNcKt3YIsIOF6P8gEfXf63iPNF9uFq2qcAdY>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 10:23:24 -0400 (EDT)
Date: Tue, 22 Sep 2026 23:23:19 +0900 (JST)
Message-Id: <20260922.232319.1364383574405174986.tomo@flapping.org>
To: laura.nao@collabora.com
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, fujita.tomonori@gmail.com,
 frederic@kernel.org, lyude@redhat.com, tglx@kernel.org,
 anna-maria@linutronix.de, jstultz@google.com, sboyd@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 kernel@collabora.com, deborah.brouwer@collabora.com
Subject: Re: [PATCH 7/9] rust: time: add arch_timer_get_rate wrapper
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20260915-tyr-interfaces-v1-7-5d28f1f75aca@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
 <20260915-tyr-interfaces-v1-7-5d28f1f75aca@collabora.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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

On Tue, 15 Sep 2026 12:57:40 +0200
Laura Nao <laura.nao@collabora.com> wrote:

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

(snip)

> +/// Returns the ARM architecture timer frequency in Hz, if available.
> +///
> +/// This function queries the system-wide ARM architecture timer frequency.
> +/// The architecture timer provides a consistent time source across all CPU cores.
> +///
> +/// Returns `None` if:
> +/// - The ARM architecture timer is not available (`CONFIG_ARM_ARCH_TIMER` not enabled)
> +/// - The timer rate is zero (not initialized)
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::time::arch_timer_get_rate;
> +///
> +/// if let Some(rate) = arch_timer_get_rate() {
> +///     // Use `rate`.
> +/// }
> +/// ```
> +pub fn arch_timer_get_rate() -> Option<u32> {
> +    // SAFETY: The C helper is available in all configs; it calls
> +    // `arch_timer_get_rate()`, which falls back to an inline stub returning 0
> +    // when CONFIG_ARM_ARCH_TIMER is disabled.

A SAFETY comment states why the unsafe call is sound. This one
explains why the helper is available in all configs.

How about:

// SAFETY: It is always safe to call `arch_timer_get_rate()`.

It just returns a variable without any lock. rust/kernel/time.rs
already does this for `ktime_get()` and `ktime_to_us()`.


> +    let rate = unsafe { bindings::arch_timer_get_rate() };
> +    if rate == 0 {
> +        None
> +    } else {
> +        Some(rate)
> +    }
> +}
> +
>  impl Delta {
>      /// A span of time equal to zero.
>      pub const ZERO: Self = Self { value: 0 };
> 

This puts the new function between `impl ops::Div for Delta` and
`impl Delta`, so it splits the `Delta` blocks.

`msecs_to_jiffies()` is the only other free function in this file and it
is at the top, next to the type aliases. Please put
`arch_timer_get_rate()` there,
