Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E41FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 23:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E23810E2D9;
	Mon, 27 Apr 2026 23:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Ab1rwY+6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C0C10E2D9
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 23:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777332847; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TIvZDav/emZ9t5hu2vdGYc1tZ57x0K6eynOlRJWLgZz7CQjjs+TCu9oXodPZ+8yFdDPF5uH9JdMk/W/TpmTTTuR5IkumNkGyXj94tsCKS+XxwI++uwx4iD2n8de6egGWmueequrIzIZt8aeRxFG+oPeBOx86Pg1nHKiU4H7bCh4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777332847;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ce0vIe+47DP4mD9eCdC1YbJkykW70zc0cW8iUQuXKIg=; 
 b=ggyzL70cWIpvA/vY/eHXUI07n6SCogbQfR9uuMcDNtnw8F4AQ7mYlevHTgvQfwzI36xzA1ZjGI20ZK02apDZRz6oHKuTrq4FTRFro/Sl8LltVkLPXOSuqSIzCdRUN1ALOX+iqA76ENzVEP4kME6nodcXiUzWuxEPw86LPvMgcoE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777332847; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=Ce0vIe+47DP4mD9eCdC1YbJkykW70zc0cW8iUQuXKIg=;
 b=Ab1rwY+6qtP/XA1OECDXe2ByqNgKTj9sNWdHJXnv67FbwhRh7LKWPidbJDYG8rhH
 wuft1oE7mFO10+hkTYtycuWYk/5xavftZGltnM8r3ePQm8xcLWN8BpQgn3qHmo6nUk9
 yRi4sxLxiYLdnum1LN+SvwfeE612GzgrAjr9rGZY=
Received: by mx.zohomail.com with SMTPS id 1777332845471162.98488952114496;
 Mon, 27 Apr 2026 16:34:05 -0700 (PDT)
Date: Mon, 27 Apr 2026 16:34:04 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Trevor Gross <tmgross@umich.edu>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com,
 work@onurozkan.dev, alvin.sun@linux.dev
Subject: Re: [PATCH v4 19/20] rust: time: add arch_timer_get_rate wrapper
Message-ID: <ae_ybAEBptCsSYdG@um790>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <ZpKRFb-Ves9nQ6lMstVDx-dk-vA9CSQMUQDTgSz4zBssvYj06calaHWnfeBCR6Zv92SVSX3QohKqUcY1KpTzHA==@protonmail.internalid>
 <20260424-b4-fw-boot-v4-v4-19-a5d91050789d@collabora.com>
 <87wlxsrgqr.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlxsrgqr.fsf@t14s.mail-host-address-is-not-set>
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

On Mon, Apr 27, 2026 at 09:42:52AM +0200, Andreas Hindborg wrote:
> "Deborah Brouwer" <deborah.brouwer@collabora.com> writes:
> 
> > Provide a safe Rust wrapper for arch_timer_get_rate().
> >
> > The underlying C helper returns 0 when the ARM architectural timer
> > is not available or not yet initialized. Map this to Option<u32> to
> > make the absence of a valid rate explicit to Rust callers.
> >
> > This allows Rust drivers to query the system timer frequency and
> > select appropriate time sources when programming hardware timeouts.
> >
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> 
> Looks good to me, but it is weird that this is defined for non-arm targets.
> 
> Even if this is available for all architectures in C code, would it make
> sense to gate it on the target being Arm in Rust?

In Tyr, I’m calling time::arch_timer_get_rate() unconditionally and using
it as an optional source (falling back to the GPU timer when it is not available).
If we gated the Rust API on ARM targets, that would require adding
target-specific cfgs at each call site or break non-ARM builds.

Since the API already models absence as None, my thinking was to keep it available
on all targets and let callers fall back, as Tyr does with the GPU clock.

> 
> 
> Best regards,
> Andreas Hindborg
> 
