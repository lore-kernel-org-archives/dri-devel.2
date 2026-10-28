Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DDB606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TwLlIdaq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05ADE10E59D;
	Wed, 28 Oct 2026 09:49:01 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA89F10FAD7
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:48:54 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b1a86c0316so1288671a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180933; cv=none;
 d=google.com; s=arc-20260327;
 b=FUrIt39XWTcZXxZ/92rAukYSerY2iOjJUUumtxJxqH5jYaWOVHVEXbl+iPg7KBsXMe
 qEeTr9oYYpXmd3so3n18SD20z3T5RDyp79Gb5Q0PFuG4/sXTc3N/K1LjDQVoLdW2r3pq
 IGg+SzIe13vQtFgh5HnjRLF9Ux2PpcJkI3DXz9EatI+n06MxVS2so5hITa8E1dEhigdq
 2GtzI+XWaZpS353LdJVDyRGzAfEl0LKkpmQ6L5iO7nRmWUj50uvIux+nzzhqwcuD3lxQ
 ngxuVw8Z7bxpkYNJ0IZqv0ICkgznPFRU1E65a5nlUz+61tQhfN56wZuTf0NJpWf+3vUG
 Wdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
 fh=Pi1DewhafZtb5PR75r8zAJ+yiPTw3hL5d7JnJTxNPsg=;
 b=FSxR+kmxWIdKaSwCsakpktw+C/l228ao+zWY9mrGdfTvi8NTW+3j9Op+Jk71uKE7Oi
 d4OUnfjA++R5ZamSxiFAYr3NsKJfE0Xo0e4mswCNEk81OdhjN7X9RRBJHmnUGeTRSUrE
 OA75w/ZVP13eDlOe4+ODD14/S9Rpxj+gQUUedSawGHUirxK7o/PLyArfvWV8SLB4GGad
 jhL+G8gl/PpwBe/IC31rCj4Ei905inigI4JvbnTU68OOMETLXeX3Ous3qA6NXHm7URGe
 tlVgPsKNfNE0cGK8XTFK+XKWCqcRMhA7x/0tPzsH2oqKBvol2DtQ8IyK/13y0Qb4xFuK
 d9Fg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793180933; x=1793785733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
 b=TwLlIdaqR2De+/frgxJauvxcud7Nw7bMfWzjPWwN7zpYItK6byIN3C6v0N7kkY/3Ox
 iQSKLaSbUhxy5UvLmw2lwMJBCSE+708ktUpJAg1+ctefJtujtLKnvUGYNdGhxoZxO62B
 irFNhk9yVBjq8rdqUOSiDIkOH6L+ZCX9phI0H4Xoa0ifr1jUwZ+QaCYqTGZ9V4v/8BNy
 MEo3BKm21keztiOilWg6UlQELwMIk21KD5xqPWqIAxe1sROoXE4I937Yze2aysVrAxqJ
 MtifkNbQFSIX/cH03pYvqhZrrl/5VN5C+quumaDa+lPeyP+Xk+dO3Sizf26reCc1QIsp
 O8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793180933; x=1793785733;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
 b=sesmHVmiRhx1qrqMacQQPdbX9LAubwy3/2bLduvThBOK7jEcVrTsI5ThYa2JaeaxjG
 mX+H0s6yL8UMqG9kB3mi+UNwTJtN89dj52FIffMJLBcw0iGa5iacOMaOY18Pf+WH+ZQi
 JxkKFVjmHB1NrvZtNx166j+M3Cs93s2YyjrvP1ZWYbUWYDyA8KBdEJpVpdxVIk/zVx3Y
 /mWIAZgGOr2e7cp/6YuBwhFLgbuCrlTCUCaEGY0A6Mx6UfOH4VQiytlopGmB/xJl1coW
 Zndt2KOtlQ4+kRnf2p1ncducL5KzH/ETXrYuYPIQl3bw58SLhYch0NXvQuN7AFau6k7w
 cGog==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4y8ueQsu6thxocIL7ZbH8HsSvpFfQBDq8G0QrJJ4vNt98cGYkQ/AIj/vylD+ukju/aTdYLu/rUog=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKaToYgaJ5n5MjG1TLsi60+ZzNNmppc9NuY8rCZlBz7m2KtiSA2
 8DO5ioLDRb85NaHmBst3XUsTS+H5VTze/bygpGfOfakyAsolrZjCvNqINB9T4iNP2Y5xS7jLlLt
 /rD6BEGNhAczRBMvEcldIyknWV3CoAiM=
X-Gm-Gg: AYBFou3rqcMMF7Fgqkxkd674aQ8xMg784Tg5lq4O/LMeTRdPoJootkg5OguybBaEM1e
 I6mqD1pd0l4CUYjkiyT69xSAVAtOvgap9QRiZTGKgOBlDMP2DK9OVQj9OJa7AvSRcw0dWkOoAoa
 MCSnyJGEd/Lf1837mAOJdEBJskNNdPdOrHHJcn9KdKz6h3gqwHeNMm2VSGQnK+rX7BckYeUMBA+
 wJTPFr1chJCmKbvX6i/hdIOHIHhyKn1+lieM+7Ow13DWM+z/G7kYBAM8LGWcOqm9MjlWtIzZQ1H
 5CbmQd/7LL/jZN1tw6lIM1mVL1sIv3x5REuXl7Xw4PNJoUzkqu1345AZf1lMBSfR2ssnYeichBA
 KT4hCEIGdQIAmQMkYRxwFwExHvjbsP3UZ+zIXmfTNUQNAwTyii+A9/9giDQ3DqtYo+8kxBVZIY+
 tMS2GV08kqex7B/bk3Bjc8xKAns//76IZ5YAy0Bmp6ylmQN2y5PKS1Bd1ayFKxUWHbTFwQKxw8/
 6VJTO/am6WaCRUKW7FC6Y6nIA==
X-Received: by 2002:a17:907:a893:b0:c46:8b51:c17c with SMTP id
 a640c23a62f3a-c49bdf394e6mr156034066b.17.1793180933042; Wed, 28 Oct 2026
 02:48:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
In-Reply-To: <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:48:16 +0200
X-Gm-Features: AclHuK9bqVSr5ebQZT2ja4gGk1wmv0GUJ0T7y7aJfJNVsg1OI_1bv2lVUKDS3Hk
Message-ID: <CAHp75VfJ-L5ELAttN+Fz_Co2E1KHumwLZAEMXFMhRubzgVLqug@mail.gmail.com>
Subject: Re: [PATCH 02/10] string: Switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to
> standardize nonnull attribute usage across the tree and keep the
> attribute's quirks in one place rather than open-coded at every call
> site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
