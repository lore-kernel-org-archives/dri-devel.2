Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67803606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJJ/10li
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA5B610FAD6;
	Wed, 28 Oct 2026 09:48:14 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CB910E600
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:48:03 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so286655366b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180881; cv=none;
 d=google.com; s=arc-20260327;
 b=WzGf4fx7zAE9OfZxeHjjVEE14cW7UWGp8gS5zKVVm6pBU5clLZLOWJvznVSTPoIlp0
 5hawH7TwjMQYZZr3lOM50bc3oUyjFQd1e6Pq3osr4xRNeSdUamrrSnl4IMVzfHMBRyRn
 UBRpCpC5yv7KBp/NyzSe4vElV9/pyoG80LgIslvZ0XSHOr9QNjXsm9jA0cy2R8iBzw6Z
 MtPCa90LTxXWZ00z/+o+VwsRV7A51H/BG/89i6mzxzEA/mh80/C/Qn/U36pJKdoyA1UC
 mQe5ZbcnredOwcg3+RpNcXCYM+Op1J3jtsj9t7PINXKBnqMPra7jL2neKpikveup5QPf
 MQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
 fh=M5bc5BR9RysNrMTUSjjqdppW7rhmqWnsEmaFxp96WeY=;
 b=FCwBSmuUEHFFFGvicMN/a86SLZxtsiRapWr3+VErHS4GgBnG7YlhZbmteZBuX6aLil
 cKqrtXoh9EOYL33rWq7pLbg3PsZqhICUf29CYXFyoUH+puAqShu/xwZsPLBVRDXrG4BL
 8/q3IbwvZF8R3uTd/pUdZ4DbOTGqn983ZTQFrmeKA3sWOa3ErWfzfQ5CL79nuKXidvSE
 JP5tPcsCS1AjMq+pCp6y/kejVZyFg4cXehO0WtlGQxvWwdeEru6hEjuMX7KMFawWT8C3
 M0gUWdB5xF+ssf1DHQt/f+uZ1PivRLdFXi+o42J6WDzbSVhJ/QP9h6ujMS9dThl6hcVx
 dT/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793180881; x=1793785681; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
 b=TJJ/10liITcaeE8H9+Yv1GLk575lJThMYiulDUHGJlXnyhb2D1SNbVi5EnDB2Kt0tO
 EfHCFnMg4CWPv/CSpnMP61xnFPNYLiKYFGSgiI6p5o5M498TLPHwk/J8PQ0kULTql5ku
 Dz4+2zQxO9KguHfrYnNyBRIkIKGbi6poqqpNQEO7Y853JHiJ+ZV01P55yz5cHuJaw2BA
 Q5zMiS1b3MqgRzMQRTENFLE6+qhvBwzYRH09oArAKSo+4DiFXr445pIjRep3ZgCDS2tA
 2gGjkl3iIaKlbfa3ue4yJKiwvAnglqe0SKvcGejaTMQJZSQDyu2x+cPIOzRhzPfKeZBt
 pfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793180881; x=1793785681;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
 b=WNfyK8P6suJXVZkQCLVB3boxQhzXdj9ieIX2e1Sa6/8qqNEQNfbJ9gnv65kNjp7Yhv
 M4/XykNZMfhutPKfkABAR1bhpcSrwWkBPvXMXu9XFcYLQSAtE05bk0Giy+mxqq608YEz
 YRJpQ5XgwT5SklgBsKzjYc6BSrIVeBKOuldR+ZrovJIyQ+darXJ8oEC/jQSNi12FS3Rr
 r+9w0RKABzxg7sjvgh7MTFDfQrnl/DaK+F79jf3OlUzjZ/HZoXYb/LJfIuNBinPHkhcH
 DjlI5nDnayhUanZxgxK0EmhctefuE+zxue+uZRiUNkWAeB4ZH4HQfzIE5eVUE2cD3QgL
 rOsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9FN6FNkivEwiPTh3Mv7XLhz2dxy6DFh3SYK/meVzdzmtYFDVzvO9z3x67ZCQpZMYp8x0+PrcLukU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJm56RGIseItih/PSek/K0DP3Q1iEH1f5T0EhmCIZb1mIbKxCrH
 2Hvdx86XXmB9Gk9kXPCr/laWsBufzRcRM7mGMd6R1yOivQN/qIRdN7rrZLuXX0lNsQp0eMHp2L5
 jlAiBDkyi1nUueQeXWX4dFYU2u9ykdqU=
X-Gm-Gg: AYBFou0fEmhJfvU9DShqudWJDRe6vUl9cCeEwVuaRsrR+8+OxR//gyUI126wSKOB9L4
 YDcitNm/2kMSv5b8FLsdSSevOo+6BLoMemHX0Kb3fRjjs5phr66ujTTppecGrCv0Eocoq4qGtwp
 KeZbaP/46WG4jptLmoZ37U5RNLoc+LKJXLtnijQzwfMb0EGwVeXSA9g18G+ReqozyC9YpBF8Io7
 9paaPJULd6MLsYo+QUyUtpY3b1k5irqdxtXYdBt3pmg9Hvf1SW/FQn0H0EW4zZF52yM3nbcz/Mc
 eDJNdOyx2uw5vUn9MOt8k9AcL2apB/gnbIKCsdjKffUK56iZSnVc/QCcSFpPtYsArn2uh90SCqp
 57oxy8CkGwWbVmW8PscFAtNZ63tZX9tMKVHLJMUXoCJiB75kDhWDGTnSNt3sylOkqRVsM8QE9Wc
 wh3L7BYFLQqmL7kUJ9cq4qbteZH/DqjdRYqD7hjnt3CE6EIZvZKYUDH32Omtk8iG4BMTZO7TzWw
 aJ0tx2m8TY+/m4/BROgSBOMvQ==
X-Received: by 2002:a17:907:86a5:b0:c25:f7db:4bec with SMTP id
 a640c23a62f3a-c49c6357d34mr69949566b.18.1793180881026; Wed, 28 Oct 2026
 02:48:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:47:24 +0200
X-Gm-Features: AclHuK-8N84O0Y9k-BLOPVpeywTja7886uZe3ugxN4eM-96m__IvC7bzZgS0MkU
Message-ID: <CAHp75Vedr5J1WJMrAkBjRSLKA_zf1kt3GD6UhjzLcy9vowxnaA@mail.gmail.com>
Subject: Re: [PATCH 03/10] lib/list_sort: Switch to __nonnull_args() macro
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
>
> Add spaces after the commas in the __nonnull_args() argument list to
> follow the usual coding style (according to checkpatch).

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
