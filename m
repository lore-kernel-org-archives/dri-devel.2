Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA48606A324
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=H0lgxcBb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A24A112CD5;
	Fri, 27 Nov 2026 18:05:05 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E17112CD5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:04:58 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b7ddb99db4so10858707a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795802697; x=1796407497;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RqlkJ/I+EH0yMfrfHVvBSdwYQQPjzHS4s9eY4ppBylg=;
 b=H0lgxcBbY2XgfCKAfJNqeVZLBZOB4tFN53EJgjKC0qj7SVsSvA4h3ek1l+OJh6Vh/j
 YalZ7Kz1Nl9b2LZd9o/BpIpRVcH8hkR0vPhGuwlFCOdSW4acw+hkjnvaS43DnXWw/x/q
 buWQjIN+JojyRtWeFDlgwsk7qUPt6Fr8u3H75LuJ1/MI5UtKG0ciFxAJ59QnqxEw9MTm
 mgMYahfFvA0/jF0dxclLF/z6LiyzaZaViNCSW1l0LVcVe+K+CdSjft/r6g0Guhtef8qv
 ap/OypQ1acee+s23pVr/xxHOHvjan8LuP+ZG8jgRcneunHF8lER7GmVmfC27KXcWNQPq
 /jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802697; x=1796407497;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RqlkJ/I+EH0yMfrfHVvBSdwYQQPjzHS4s9eY4ppBylg=;
 b=GYG9O8ZfyLtupzJVhYhu9igl0ONRfel6SkeTv/ndPeUaQz/RQ5+JFC6HgxJQGhikpd
 On3jKRBqfOkNY7xN10N2c1yScO5vSXBUm64T3fBbYHJHKI6TXY4ddW7CoOKHiusW5di3
 /FMpCkYv5N6LoOaZJjOE7803Lwiuypm7fEOvBeYTN/Suir1ZSZPetLI7b3ysBjepTZzg
 T7iYs6qydvogdwCxSxjNJ3/4B68Fo0vcy+A9HJwpj9ZBbq6wRSY19M5NYZi1iM/sLVn0
 LM8tkI0TuiAEUnZo9vWi7/J3/ShHXkJZLMKWGzYOwUSCfFK94aTM0youDw1PCn43oTF2
 DTMw==
X-Forwarded-Encrypted: i=1;
 AL+hErE9yehHN/UwkDZrUuqE5VvnDs5hTMwW25UDELPK1jHpwbiazv9gvutH7e8URuZqFzH831OQjTg4BtM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+lJqnWPCiGnOTVHu3SCtCFTsZpXSPTfTfy3TGCV8FSBKUFP1U7
 sjpYYcRbO5LhFPwV1Rx+h9xRZdj37LdhLqbmxflZxudMZ44yooHa5fCZrdYQt7W28ts=
X-Gm-Gg: AZFdTZd1fP0TbDXjIsnvpihsDUxBFEONglawNrUDsuqJRpHMAIPonEkcNLwWVDNCKH7
 h2Joy5izzctykmFmEpPuLIn16jO8pJf8uCi8hcifiepVg4G5JaEycK+CDIQtItTm9lPpS5hE5Xj
 hXw2HxDHiivjqVbTfI5+h+S2NgYiMu3b1y8C1P8IWhrHEqX0jL/08O9Yh3//wyhMxvXfTmpAeHg
 z89sE+looLi1yM85nHWv9cMYZ51P510F4Ibjjz2c9iOhS+VciK7sggYPFKPmXDZo8b0CvK+F7tV
 AMEmmBJGDCUelrV47LTkLWxrJgi68TNiUqzyDyhXh2lpOrhqzkNzicdFgDfEp4pKMpS1ojPCTR6
 2T6dMZYJbPcQWkVBzdyz0M8tEbEAcxC4SpP/SnvqugTNW5BaAAcAi5ovWhPRMVApg4KHXuJpmNX
 umRLfHVwWiCoBSccaPZzn0Dc5d6CQDYzpx1RD2oiInAs1/SeCVL+VhHydxx/8w+YJTniPrBSWdf
 X6fgesL9nWENsclelL3tPGHE4M++j1vQnJALoFdKCPkQpPf3jtet5SIfIlFiRZMLl6O6B4kPhQV
 VrVMQmlP+rMMDAWw1cFju3p1IpjxDCo9Ep2G+mZJzndHO4HT
X-Received: by 2002:aa7:d94b:0:b0:6b7:df0c:18bc with SMTP id
 4fb4d7f45d1cf-6ba37d3b56bmr13992034a12.17.1795802696609; 
 Fri, 27 Nov 2026 10:04:56 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba9b131d3bsm8376099a12.34.2026.11.27.10.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:04:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 5/7] rust: clk: add devres-managed clks
From: Jerome Brunet <jbrunet@baylibre.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Gary Guo <gary@garyguo.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <189F36A9-D1C1-478A-A195-F94D037E4376@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-5-a5e9977b3509@collabora.com>
 <DMYELN5M09W3.1SYPKW7DZ70E1@garyguo.net>
 <189F36A9-D1C1-478A-A195-F94D037E4376@collabora.com>
Date: Fri, 27 Nov 2026 19:04:53 +0100
Message-Id: <179580269373.2809466.3866997464599192193.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=jbrunet@baylibre.com; 
 h=from:subject:message-id;
 bh=EVdcrIGg5JsCx0X3upJdG2WoVOOBbQm+FMplR+16eVc=; 
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcx1wf2nxO/vlS7391p4r88j3CD8rvTtqo+zJHx/l4O
 F/jc7mfHaUsDGJcDLJiiiw13NXi7yS1vsyarnMbZg4rE8gQBi5OAZiImTYjwzur9Ptm8U6ip4rk
 vVaFZW/7m3dS40HhpwtLzNJM1yWbmDP8s+KdsNvXYe+JLxfuuvhc1WqSbtuQczJ5c3eeFEuIet0
 GNgA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-18 11:47 -0300, Daniel Almeida wrote:
> 
> 
> > On 18 Nov 2026, at 11:24, Gary Guo <gary@garyguo.net> wrote:
> > 
> > On Tue Oct 13, 2026 at 6:07 PM BST, Daniel Almeida wrote:
> >> Many drivers only need a clock running for as long as the device is
> >> bound and never touch it afterwards. In C, devm_clk_get_enabled() and
> >> devm_clk_get_optional_enabled() cover this case.
> >> 
> >> Add devm_enable(), devm_enable_optional() and
> >> devm_enable_optional_with_rate(), which wrap the C helpers. They return
> >> no handle, so the driver keeps nothing in its data and cannot change the
> >> state of the clock. The clock is disabled, unprepared and put when the
> >> device is unbound.
> >> 
> >> This mirrors regulator::devm_enable() and devm_enable_optional().
> >> 
> >> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > 
> > Given all the device resource lifetime changes, do we still need this now, or
> > would putting a guard in driver private data to be dropped automatically upon
> > unbind be sufficient?
> 
> I think we should still provide this. Many drivers only care that the clock be
> enabled at a given rate, and do not care about the handle. I think this has
> little to do with C or Rust and should be supported in Rust too.
> 
> — Daniel

Gary, is this OK with you ? if it is, I can take as it is.

-- 
Jerome

