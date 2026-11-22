Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F208606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JhobIMlt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CAF10E50E;
	Sun, 22 Nov 2026 08:59:35 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8027E10E503
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:59:18 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a359b714f8so13301135e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795337957; x=1795942757;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G2sUKEpp9UCq//DjZnGDoTE+Lw96P7JUYjiRFoz38Vk=;
 b=JhobIMltosyX2fVpA5i1bD5EwEnqtCUHxeJ38zp8WMYvrVJnFByzQBiQTqMd4GxQGI
 VXIPRZuNQSbZhCWUshhPrEoOkY5uz95aV0HJP2wQnkMK/z6SmtZ408xEuR8EeKidXTaJ
 cdfx9fe/Yl7gA0jC07gMvG4uXyPZugkM5b13Tq5POlyo9z/r1oQgI/PIcj4PC99J9iRh
 gIgjF2shJjNjIMfbOs5unxwjK/uDh1ApX03vBlKEpeE/ecIvM70lEfD34ND1tH+aHiO4
 AnQjwy6elE8vjv/eBScqQAoWQ2jrfuQVTDEwz3tWSYmxJeJAvBwEDM2Slby1SSlBktQU
 lmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795337957; x=1795942757;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G2sUKEpp9UCq//DjZnGDoTE+Lw96P7JUYjiRFoz38Vk=;
 b=g3tUHjxg7nzIEMmxQMb+Irsywbak1UoBZgkdMagJhtKI6fbRMsDOtpi+Bx/BckZ0TU
 1btIe02W+ZwtAXefKi/Zz0YembourQ8PSoeHADGKY28izGiZHHp0MLliQp5yk3/3Wg2J
 s9V0dwbHGGXwcHguIG2vcoDeaDro+XsKojZO59A5dAOHjByJQbfNl8Lsi6Jl7XHk5J3X
 JJ4PdU53qSq703jGZSzkNyiDJbvVFgPgn5tz/Jryo9wYufxZhvz2djEhu0eXVkTC9Jb4
 90b30goJAHC8UEn9pkP5q5VgDERCOEJpJEWj19VCKhCW9WyXccKmag47fRYkWSn8PA8s
 NSnw==
X-Forwarded-Encrypted: i=1;
 AL+hErGBFHkKf526fUMNJWVtsrifn6hqutruNrdKnKinVTdoIZYnwm6jw5MMaUBQYycxI/mw4zjSwI6tpRw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8WnsyDrg5Z3fxwRgE7Bly0kJr2Dzx1MJeJ11tlKKLuviRKeGoT
 hxA8vOnQ3XIc274l7QMiPGohFZgxP8EinqU7ILldrx6OIoxdn3lZF71LMEkL2Ykz80qhZ96jaqw
 Z1z8VVrunFSGSd2dcFQ==
X-Received: from wrsv4.prod.google.com ([2002:a5d:4a44:0:b0:4a5:aaa3:3335])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb8881941bmr192603305e9.24.1795337956685; 
 Sun, 22 Nov 2026 00:59:16 -0800 (PST)
Date: Sun, 22 Nov 2026 08:59:15 +0000
In-Reply-To: <20261122-tyr-reset-impl-v9-2-ed42d8f513ec@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev>
 <20261122-tyr-reset-impl-v9-2-ed42d8f513ec@onurozkan.dev>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122085915.1094533-1-aliceryhl@google.com>
Subject: Re: [PATCH v9 2/2] drm/tyr: put iomem behind the hardware gate
From: Alice Ryhl <aliceryhl@google.com>
To: "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dakr@kernel.org, daniel.almeida@collabora.com, airlied@gmail.com, 
 simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, boris.brezillon@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Nov 22, 2026 at 08:40:33AM +0300, Onur =C3=96zkan wrote:
> Move iomem mapping into HwGate and pass Arc<HwGate> to components that
> access hardware. Callers obtain HwAccessGuard before accessing the iomem
> so the reset worker waits for ongoing accesses.
>
> Acquire the gate once per address-space operation and pass the guarded
> iomem reference to its helpers. This prevents nested gate acquisition
> from deadlocking with reset and keeps each operation protected throughout=
.
> Clone the gate Arc before acquiring the guard so mutating helpers can
> retain their mutable self receivers.
>
> Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
