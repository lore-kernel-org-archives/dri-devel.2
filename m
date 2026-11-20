Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E4606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Xc47zwRe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE4210E074;
	Fri, 20 Nov 2026 16:48:48 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC90112BDF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 16:48:41 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so9815695e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795193320; x=1795798120;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bfyjauXkdda14TZQkJmia5dShZ8rR0trlEvtPbJzkjU=;
 b=Xc47zwReP3xjkVlLLH38d+Ksi3c9BzfEs2n3B8DUPRmVelQ4V1lW34hFpi9/gvzNj7
 pM2pb7uBgf7Fk60DARz/p+Z4n6tyk3FOnVpMHN06PUmRZrKkotR79ImiCLgCKm0w9AdR
 1QBNla0etwrAZoGS07etHLn0DzgsamLkDz3BvsGhnloTL/znQwVaxQoTZ+6JHCvGIedh
 Ar5B8WqYSATQ/MieY18w8/I+jlpr7adbTTgulogSEhKG4d75QUmGluzGp4kVZF5tZwkP
 Nj0HpxCQADHSVhEvNYdowKvfUapKuvD1teHFi7VhDJJSL6Sn1/jK5bqku30m6zlew8No
 wFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795193320; x=1795798120;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bfyjauXkdda14TZQkJmia5dShZ8rR0trlEvtPbJzkjU=;
 b=Eivejt0bJL2VH4JKYm6xPMlKz4VOl9v+WcytoL5PyMhXD/YRJYqmUWrS1mj6wTsOF4
 qIwg4+nJwY379BSG0vralhITgiZ2K1eTBcwYN20pkE+kimX3cyqMh85Vo4z6SUh8wKjV
 f4qYdNtXch2aSTUlVtFW7Yp7bquBbjVIDA3Cd/w48L6G9ii2gNuTMMEdfdQ5b8QXCWl0
 GRAofTXwAovivNG046V5b8qxNTiS2yWE8XwifYs4g5D8PfPT3smCDPqrbsJmbuSBEzCx
 8znm4cii5C27ejpseUaagIcG4ZuKuDkF6l5TGuc7UJStSS5kbdQxNnKZv6Qu21s12ZvS
 y0cg==
X-Forwarded-Encrypted: i=1;
 AL+hErFIHsGxcBf7aMcmVDKBfAEwD7mX6wE7g2MDTfzrTJlUxLDjR/oCL8ebZg2CnPYqJYPP9FdDx4fTnog=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8TWFsFDiEH1aXadMOCMyOBvK8u/U4ZXWFol35xCRUNQNfD3rII
 FcxRQlGULVk1eLzi9P0ZM5y//PgwBfFCddwX088VJiyl8ik2vbEvYsvbDDfXHdyZ2Tg=
X-Gm-Gg: AYBFou36cSce7e9icdYkxksuLGsIu6eCOH7bgJyBRNqZLcrppEiqUNVWexxsertpo2f
 56fk3S2L9jSjrqcjo3TcTlZynX5/ZVNMqkqwiO9fPKDedu9P7oHUmSc7cjH5SYmoQ1Z1upAkbUW
 9SSQ9B27bQkuaym9ozs3xZtfunY4UgRtmdu3Qn8baA/W7I1XurzGq1B+YtFDTycjN7SYP9Vu130
 cVnFFoek92ctnuoEqB1AnYV5Yg7r45mvVnAmt0C8XFQXjNtcjYUUb/+mkmSxsD6Tbgot8Bzg4EL
 ruDxymZHZiYPKHjtEHkJ/3ImIFFNjMwQ+nmTWpUGOFZwq9iRfC07O++6AwG0qLOmUzSTRFh36QV
 WHu8A9xAk25Zhnxw3evYBbKdj3KAzy17pJ3LpdiApkeWVs9OvIFKLCIQ6Iey9P7kQC806h4I1Yr
 2XcYWljrRyfsJXGm4aWNbWusuviCGCX8N26oxA9BpbaSLwK2DaK7yFukEapC2vQZHMRzwcmsjHu
 j/b32U50bN7DLab9M0r+gg5gJq2SFqmatqg+XzjB/qjTVbmYxldYPtREsf/JPeoxhEntfeRnAws
 akwpUSIEBC8vqPzSSbLQ7IeDnuapijTTTRN4ZTFhKU1V+8Xh
X-Received: by 2002:a05:600c:848d:b0:4bb:6b6b:fbaa with SMTP id
 5b1f17b1804b1-4bb8880fd0amr81601005e9.16.1795193319985; 
 Fri, 20 Nov 2026 08:48:39 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm102415595e9.15.2026.11.20.08.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:48:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 0/7] Clk improvements
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
 Alexandre Courbot <acourbot@nvidia.com>, 
 linux-pm <linux-pm@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 linux-riscv <linux-riscv@lists.infradead.org>, 
 linux-pwm <linux-pwm@vger.kernel.org>, 
 linux-clk <linux-clk@vger.kernel.org>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com>
Date: Fri, 20 Nov 2026 17:48:38 +0100
Message-Id: <179519331840.3795820.8047048832159165355.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=jbrunet@baylibre.com; 
 h=from:subject:message-id;
 bh=4z3/sdMgR1NP7DfsDZx0tYiu2dW9UOhvaq59u1rg0JU=; 
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNkMlc+2Ksh+kZXIPh/3rDDW4Kn27hqR6Y15t/Vndc9nY
 JL6uuFhRykLgxgXg6yYIksNd7X4O0mtL7Om69yGmcPKBDKEgYtTACYSOYfhf77/s+M/3jXtP6oy
 5+cRhk+hnv9r4q4aztv7e7Xt8cINxx8zMkx3PJygYGn8ecrZdJeblhwduyRv7OkO5akz19EKybu
 wlhsA
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

On 2026-11-11 13:54:01-03:00, Daniel Almeida wrote:
> Hi all,
> 
>  > This series contains a few improvements that simplify clock handling for
>  > drivers.
>  > 
>  > Patch 1 converts clk.rs to the kernel-vertical style for imports.
>  > 
>  > Patch 2 replaces OptionalClk with Clk::get_optional(). There is no struct
>  > optional_clk in C, and Clk already allows a NULL pointer.
>  > 
>  > Patch 3 implements the same typestate pattern that has been used
>  > successfully for Regulators. This is needed because otherwise drivers
>  > will be responsible for unpreparing and disabling clocks themselves and
>  > ultimately handling the reference counts on their own. This is
>  > undesirable. The patch automatically encodes this information using the
>  > type system so that no misuse can occur.
>  > 
>  > Patch 4 adds guards that prepare and/or enable a clock for the lifetime
>  > of the guard without consuming the Clk, so that a driver can keep a
>  > long-lived Clk<Prepared> and enable it for scoped sections.
>  > 
>  > Patch 5 makes things more convenient by offering devres-managed APIs. This
>  > lets drivers set clock parameters once and forget about lifetime
>  > management.
>  > 
>  > Patch 6 adds ExclusiveClk<T>, which holds rate exclusivity over a Clk<T>
>  > in any state until it is dropped.
>  > 
>  > Patch 7 uses it in pwm-th1520 to lock the clock rate for the lifetime of
>  > the driver data.

Hi there,

I was wondering how the rust folks expect these changes to be handled since they
touch the rust/ dir. Should the clock changes go through the clock tree or the
rust one ? it is fine with me either way.

I've added small comments on patch 3, with my understanding of what of what you
are trying to do. Please take them with a grain of salt. While I'm eager to help
rust grow in the kernel, I'm definetely very new to it. It is very likely I got
things wrong.

If there are pain points regarding clocks with Rust, please feel free to
reach me or Brian. We are happy to help if we can.

Cheers

-- 
Jerome

