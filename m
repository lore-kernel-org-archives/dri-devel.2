Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1C4108B904
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82C010E235;
	Fri, 20 Mar 2026 11:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZNPBILJF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B7F10E24B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 11:43:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D19143DE3;
 Fri, 20 Mar 2026 11:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D5AC4CEF7;
 Fri, 20 Mar 2026 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774007034;
 bh=Rp2R12YtoEPaPhn+6Glp5nodLFyhyQINVrjxcl6ZFPM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=ZNPBILJFImehQ5vsVgWdx2URfMRpRXVNIayv0g3/6SAM0zTgNAAe6pxgaEX9grMiL
 2W9VUKVIIif2i4OUt3JzNeYyrwSFPFRq4NUsRr7sZ9antdizaXdJXaJBWZ1Wk3aP1B
 CvBZKtuMe5frdSdP5I0pc0yki3j9HmuVv3C+hZW22HAbxnvNIzX7kRkshngxgoUUAg
 lTLbKbnSW9ndNbOl4rkf4E5BUB0AinI7Zbfw8pfdOhNv/cWQAX3pHjPJUCPVUYgxOE
 P/4BIWURqQIQi28UddOpanvvytutODRQc8tRXwrfryBrPigFGzic8r93bfakdjRSFa
 PqWJDwaOue7ww==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 12:43:47 +0100
Message-Id: <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Drew Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu
 Wei" <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>, "Boqun
 Feng" <boqun@kernel.org>
To: "Stephen Boyd" <sboyd@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
In-Reply-To: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
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

Hi Stephen,

On Mon Feb 23, 2026 at 11:08 AM CET, Alice Ryhl wrote:
> The Clk type is thread-safe, so let's mark it as thread-safe in the type
> system. This lets us get rid of hacks in drivers.
>
> For Stephen's clk tree.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v5:
> - Rebase on v7.0-rc1.
> - Pick up Reviewed-by tags.
> - Link to v4: https://lore.kernel.org/r/20260113-clk-send-sync-v4-0-712bc=
7d94a79@google.com
>
> Changes in v4:
> - Pick up Reviewed-by tags.
> - Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0-e48b2=
e2f1eac@google.com
>
> Changes in v3:
> - Rebase on v6.19-rc1.
> - Pick up tags.
> - Add fix for pwm driver as well.
> - Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0-44ab5=
33ae084@google.com
>
> Changes in v2:
> - Rebase on v6.18-rc1.
> - Add patch to tyr driver.
> - Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-48d02=
3320eb8@google.com

Alice has resent this over the past three cycles, but it hasn't been picked=
 up
yet. Please let me know if there are any concerns -- otherwise, I plan to t=
ake
it through the drm-rust tree in a few days.

Thanks,
Danilo
