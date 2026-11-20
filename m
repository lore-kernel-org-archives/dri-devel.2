Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB524606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PXn6RJpb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26885112BDF;
	Fri, 20 Nov 2026 16:49:02 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2890112BDF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 16:48:55 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso970437f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795193334; x=1795798134;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h6ErIQcXg/IQfSzNOukoWYAaLWArDLpy/6tOg0mzvho=;
 b=PXn6RJpbXGOEJjsVvS9Qshx7Rq7Bk4Bred3KmnctN2rimpdFm/JiD1RUrB8DCp8ots
 0RwqtU8ZoqMxbm/0+RyIp5w+ZqwvtpQQD5WuGnu4wRsGVetWoN0x6frh/wQDiRUFmeei
 6wVPTiDJsQdEgXfovRlpz+b8W68E81FcCvkTI+3iszXKqW8R1aC0xVoeWaK5INwhAAeD
 0Lz6aMxjVLwuHeYhGdT5pfWT4LgcOX3rh9zCWMdKVzQFfPHTJdkuR+sQuTdf6V/v5nxW
 Br2dHvB+kKst8KVPifhtVeh/KdY9//82UNK7GVXT1z4ya2y20/MB4hDP4Xbm7rVXMV4Q
 GEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795193334; x=1795798134;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h6ErIQcXg/IQfSzNOukoWYAaLWArDLpy/6tOg0mzvho=;
 b=SEGyaL//tQlIWPJbkhwR6NjI5zc5TyJcKA4xsZGI3BxGNB8xAets8A8lvbOV11+86x
 kfwC01i5w5TpAluUMtIMuLhOYDefjVrIrFKhZe4xWPSWf+5CcSjEmdpZiM3Mne6ZqAg8
 yBg3qFMLY84xQ6Q+Fp4mMGvYjbAEl5pUFLF79ID83HjNRENAdOHEADDlqdoIBveMmf3C
 cYWkumCQQl2kdFJWHdBMd/JwWBR+C5EPqrr+mIa2VdNFGvX87xC6AmH7jNXairp3fWHG
 TAAHtk9pvZ+ex5hQ7GfS8AIC0RcfUsde+fx6CU0D6d0Bll7b6ftJmERVm8waigKqN7wx
 3xJg==
X-Forwarded-Encrypted: i=1;
 AL+hErHIa18YORUjtlxEMHcATf3v4NEE3yoiquPrIvvwqiy2y75Rnw0/dKJqxb5HWj7ZNrRQxJ+I2DfLapg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+g0uJ3gx7fJsrvXeh0Za/Tcqk7IHcSWqysW5jn7XwfYP/ysNlf
 lQ2OzqzbEaUbu42qhGkb1yv45Qh1/ZFuwl+nU1KhssTJQzv48afeSwSUND0HRT0wTHU=
X-Gm-Gg: AZFdTZekziIvkf9PQ0fYeaNLRcE9ZKvLjdMKzJyIvtHqYqqbKXquxUO7hj9jYakF2nE
 S7GEqRPlRr5VEPEG5/j+84J0C2L4USjCodmiQkXwEu/uwYW3Tf9WTWTnJbYJYt8+qvhtfX83kgA
 5K7hrB24lyjaoMG8gL6iaUVLIfuEsOr+MZ0iCE2JyScP3S8aV4mayKY4GY8NXfCACHMkK95tGD4
 AGY/4yLCMWoeljRQyHvbdjzr9sEGATWpnf3iNqppuAJJVc1/gAU+Fq9D3J8WmqcWVtnT7Qh02NW
 +6ePY7NWMl0bkI/DGELplphztWuef7hpszWCRGviSg3TH1jSIY1Y3fM4WhJvQat0m8HFSOqnHyx
 6CV43izxJKBtHR+YuhYSeKINzNjNUE7+ji6m3gL7QrjSELtsN5hgNqeNebQi8q5B7Q0eQPkpDB3
 vYM9FB02EKzyzHrtExeenKUv8pwQqVS2UGK25WY+EYWQDrnmyhxQoVSinJwtF2tOMtIDv0g5qTR
 ETWOsOk6HTvoHFWH1JARB7BlkdJ/UbNbN4QgVEB5q41gUsKwBVbmdBQE2eDTHtcSVBL6l0NrEBI
 Sunlt1IvKsqoEPm27i2UyjIwIkHorwlYS2W4N+Vws6iycwd3
X-Received: by 2002:a05:6000:2c0e:b0:48c:58d5:30fb with SMTP id
 ffacd0b85a97d-4abad5ac62emr8227901f8f.5.1795193333959; 
 Fri, 20 Nov 2026 08:48:53 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b5f6sm6034212f8f.34.2026.11.20.08.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:48:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 3/7] rust: clk: use the type-state pattern
From: Jerome Brunet <jbrunet@baylibre.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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
In-Reply-To: <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
Date: Fri, 20 Nov 2026 17:48:51 +0100
Message-Id: <179519333138.3795820.61438010297111723.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=jbrunet@baylibre.com; 
 h=from:subject:message-id;
 bh=vYLwHzMkZLjjbU0w6/Ec7PCJHgruiB342xDmGbUK7jQ=; 
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNkMlV+EGpr8GpuXL66eHBu5Y3mWWeFV4a/G+0oUxUrer
 RUIcefpKGVhEONikBVTZKnhrhZ/J6n1ZdZ0ndswc1iZQIYwcHEKwETm3mJk+BtiEpjsotk54bty
 cAsHW8fEZPaiNRy3p1XOeRy6T/PLD0aGzfPKGdIZvNz7xBo2Ljp/6Q+/laCNSwnzT95L3nMcLF+
 wAwA=
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The current Clk abstraction can still be improved on the following issues:
> 
> a) It only keeps track of a count to clk_get(), which means that users have
> to manually call disable() and unprepare(), or a variation of those, like
> disable_unprepare().
> 
> b) It allows repeated calls to prepare() or enable(), but it keeps no track
> of how often these were called, i.e., it's currently legal to write the
> following:
> 
> clk.prepare();
> clk.prepare();
> clk.enable();
> clk.enable();

This particular sequence is indeed allowed in C. I don't get why it should not
be ? (in general and/or in rust)

If you dis-allow this in rust, the 2 sides drift apart, don't they ?
I mean they start behaving differently. I suppose this is not something
desirable ?

> 
> And nothing gets undone on drop().
> 
> c) It does not let a user express the state of the clk through the
> type system. For example, there is currently no way to encode that a Clk is
> enabled via the type system alone.
> 
> Following the Regulator abstraction, switch this abstraction to use the
> type-state pattern instead. It solves both a) and b) by establishing a
> number of states and the valid ways to transition between them. It also
> automatically undoes any call to clk_get(), clk_prepare() and clk_enable()
> as applicable on drop(), so users do not have to do anything special
> before Clk goes out of scope.

So the point the is automatically clean-up (as in disable()) clock when they
go out of scope ? In C, the equivalent would be calling clk_put() with a non
NULL enable/prepare count. We do complain loudly when this happen. I don't
people should encouraged to not actively care for this.

-- 
Jerome

