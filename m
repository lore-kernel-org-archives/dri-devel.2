Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF1606A32C
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C/WxEb6R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EEB10E4E0;
	Sat, 21 Nov 2026 14:12:57 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B3210E4E0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 14:12:50 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1fdde384cso12240545e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 06:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795270369; x=1795875169;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jy6Vcdhv2NcktCCVIrJ79GzBwKeJB8AKRYT9ZAytoZ0=;
 b=C/WxEb6R3mLzwto1wgBOv/sBtIs0kLpfNhQLO8MvbcGe81G3ZFZRb9MpBVFhO1/HjC
 4ZA53SAwch2gBtZBupgKcIRBkTmFGzugA90ZSj0xuq6oK3tIXyZqk/Rbz66mJk2CY0mr
 dworB1Lz8MhceXKK1ttF9xFs4tKE2MO6/yn0HCJU3nNsGjTb9qVfCRubjTBCx7h43COt
 KxQsR+yOkSDvL9EIXW8oKJElTJOn4U7/Om6riKB4kPpcOBYTEh5RHvrmjPjhtZ9TpTON
 Ivj3mcV+npZYFDgYnBCeyFk49HNfheKbjiphcuuycLArv7HyJLtgJEo5qavUepPyHt/E
 5amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795270369; x=1795875169;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jy6Vcdhv2NcktCCVIrJ79GzBwKeJB8AKRYT9ZAytoZ0=;
 b=vm+aWIM4flt/Dc/AlBf5FYHV9xbrDlnbH9AOgLCpQ0mXJUexD10vK7EY6Vns4MSNmF
 hxXHM09qfuniNrSlVLE+N12CwO3KCgymC3ak2kxFdJVIyTbrmfZbtjxgyUu0Lb+kZ4ut
 VtISKSKwhS/Ji7cLCP2I4onojutnJfKsWks6rWxk1tpa5jQbPLlyJFR2QlDnnYlty1QU
 9EcvXecEc/xPwm5WTp7mZ5tkECTB5x/n/w0W2JvK9/VL+az1lRIs8lC4Jkk4M7IP3eps
 1Qxrqsa9hYhRHRqAcdtRQn7yCTBC2akaPrffqZKcmJPGwcRedCjHEWOesjqHpMb4q1lu
 Ulaw==
X-Forwarded-Encrypted: i=1;
 AL+hErHgWFGD25MK6CIokLUgnw0FWCP/uG/FDEOddZSznQMPM7a6tNT/Yly/JFbB/BQWFhnFkmcleP35eFE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9d6yCOIeRzAeJh6K0Fti9oRcou9lvPM8mBsXgJ9bn6sGDIiH++
 X8DVF9QVj13xzdV/h3CSrQ6a6zgWVmFcpeTKZYXaZ9RigP6IMbv3ar5Nu4Y6jEHVH18ChQyUjOb
 tjSIauuXuzftCb/KXmg==
X-Received: from wmdn12.prod.google.com ([2002:a05:600c:294c:b0:4bb:5ea0:79c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:674b:b0:4bb:6847:791f with SMTP id
 5b1f17b1804b1-4bb8880f267mr135552605e9.7.1795270368808; 
 Sat, 21 Nov 2026 06:12:48 -0800 (PST)
Date: Sat, 21 Nov 2026 14:12:45 +0000
In-Reply-To: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121141247.142001-1-aliceryhl@google.com>
Subject: Re: [PATCH v5 0/2] drm/tyr: safely write GpuInfo to userspace
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 Jesung Yang <y.j3ms.n@gmail.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 04:47:47PM -0700, Deborah Brouwer wrote:
> This series makes zerocopy and zerocopy_derive available to both the UAPI
> and bindings crates.
> 
> It derives the zerocopy traits specifically for struct
> drm_panthor_gpu_info, allowing Tyr to safely copy this struct byte-for-
> byte into userspace memory.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Applied to drm-rust-next. Thanks!
