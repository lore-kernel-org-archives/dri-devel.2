Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2F606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Maw9n+Tc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4CF10FAEE;
	Wed, 28 Oct 2026 09:49:49 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEE010FAF2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:49:42 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c414e5d282eso95504466b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180981; cv=none;
 d=google.com; s=arc-20260327;
 b=OZZDJlp9lEC2N/qVrLBzlIn6ej7CZRFPI2EXGv1hbxbc3ve+HoP+fWI7m+jtPepEXw
 ateslaSb0pCMlS/M7y59bogOPSGLqY6ru/qibtPv1nZCxTz2Y3S/x6aGTYMdqFotGVrE
 ceb5ug2teDiUVI2nD7Uy9jXK4b1aGK3ID5QeUgV0ztZzfMeKTV+1zxuhNtV3zw+9ggxl
 sZoioO5pNvL6m3rdmI5W9d5B2moeVk3MESmw0Iu2lmud0avQKrB4FxHNLMQXU46LBPoG
 Bw7tFejkILWu+Ncjm2bNkK6XrK5oLcrUkfL0oREc3eiRPhAgkFzviSWGD0kYzvZMo/Cf
 WrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 fh=1gogBWbEV4EJChnAbBHhnMbc70nwDJjxIH4IZEhwW9E=;
 b=OkxVLfXi0F6ngSdFu5Htqk32iOJivVlC+7pE7vBowe1kiA4vW3Al1QivKATxc7ciaq
 fWKEgSXm4+232Vl88P1rizL4pTiOgIsqLVgmPteDHKixASE5BGz4W6CwPcr5Dw9jKp1I
 LhTiIe9cS+ciPSD8Ql8T9SgL9PhS9wsGSL9qeCO/liH5Cd5JsL/ZmhBq3XHvoUyJHxFC
 bzV981rEEFZPa0hBknR7nEgLE2c2keBR8SFKmhpzWfrprDyZkKKPvzVUN5vGPygDjXfI
 VukDjmiX6zm+lE0B+PgVgyCjBQ6GXgpzOcucfO9QBTAbO8Z2nBiBiC0kGiAMwvKBU/pK
 mnpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793180981; x=1793785781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 b=Maw9n+TcH4EeZ+50zm4sza3sDbL9oGQlrvaSKk/UYKKaYdF+sdqqOo5Ba+SSTfh5+H
 yNsGSwQbLT9ze28aZp+DHmxrgvpcl5/6jG2/Kon28EiHgK+KK5YJV1FjRWgxlNdw4THc
 jXn2kh5Wqt2i4LmUXSsV/qV9F2GWFE8ivCeZZrkVK+8VOfPOSc+ZsYbDAVb5hPSgXzWk
 tTlGejzVX/A8SGO57xOR3nX7nUB1R+2Kt1568PjhjJ2VBa8uaunZs7M+7VwiMZuQz2mN
 akLfn29QZjysCK3NHRdE/mDKq4dlH53hquuZKQO2Dq8h29NWodRciIfT70BylAdMqX3P
 buIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793180981; x=1793785781;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 b=Dm7X2Fgl2D+4Qha0+m28A1HGskYHmGgCpVlgyUlg/IuDMG+qXIvUoWbgAI+M+KAq33
 4X4Z6VokUf1qCYdHD1gidSDgjCWOmnKwRfiY4QpNR7l9JqWAZyJWC63uPty7g199sjYV
 +euXTAPJ6vX3VRsYZaXWkFydoxmuVaMvx6ccqHpKkeszS7dPFJ0VRLiODfL3Fq5OJW38
 ElErTapTNdDvp+smoiCFrFKIAqY86D7L6VspACw+0uBUMr3dp7UXbHKaf1sesyUNi0wz
 nqpyVfZPKAOWFnd9xnR5shC2jksRDhiUSmbIlq9n8vA+aIwEQI4DHDITXKoeLmrKY1g1
 ETYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0hQ8h80iZSqadNE7QyQWJubYWJMzUPstZ5QoftmCjti29k43FxCv5DcRtb1LwHAZ8M11VDUxy+s0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI0XamlugNWo44jnfpSnAyZj0JIy/2WXHX3LPg5WFDQ/32f9CS3
 0NdGCRHJw/S9O3aDmpAIA4B5q9kDy1yf92cj+XY/wKuPj7nNzxyfb+gByDzIJdLSEq6F3CXXMnQ
 gAmCOJnMjo+r61q3kGoZMfRhsl0LvabY=
X-Gm-Gg: AYBFou3zEHjhe33/lYf3b+Umr7rrrO8UTh/lBbx/ozTBHG0rPyTF1uRfxRoP81Pf64D
 0hL8u8LCMcahCpsO6S7yTl+Mru/KuM17OjcNWQnImjjqrqn5UsoFqJbkKDUa5CZxYd9pLXg2+NH
 T5ysyQUKJLcIaoJtir65LCx1H7TXb3gdJ7ptu6OJUHdBO53w+amSqs8NiB6jkmAwNpu1Vqv6R5G
 ZxYy0YdO5enD2Y1R6ZIau8JOc8W5AlyGOjWBDh4E/m/KLqKOV84Iz4fdqK2qAaiqBpoY6qc8lCc
 SgKBPdguqUgip0AOQYnrYnW3fstah+HIPHUXWJxEQC2s7n3nmk931idz+2JVQ4aN7jFp47knYOM
 ZWsLgIWx39wf/jj/my7XU5qOPfjI20dU4HyGRFo4Z1brTpxpDe+wUDOSo3dEOvjQU6O6d4HwvZF
 YWZMpE9Ga7UYIZ0xx2ZiSnpirzkZpeOlNovr0Tu4fneWYBIZuaSTyrTnyFM4i6CSk7Hq7/8a8yZ
 5JpstbwxhM6Ny2FkRAZ+Rl2aT4=
X-Received: by 2002:a17:907:d48d:b0:c42:82ac:b6a9 with SMTP id
 a640c23a62f3a-c49bdf7de97mr167322666b.29.1793180980909; Wed, 28 Oct 2026
 02:49:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:04 +0200
X-Gm-Features: AclHuK-kwXGKz5n7QFXQ4iO49tQbUX582-rj9xJLuSYR3NDY9XFvg2hsu7UGHjc
Message-ID: <CAHp75Ve71BfcWr++PfQPiOc=OURNn1-cdJey=M1xBVCb0HhHQw@mail.gmail.com>
Subject: Re: [PATCH 08/10] leds: pwm: Switch to __nonnull_args() macro
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
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
