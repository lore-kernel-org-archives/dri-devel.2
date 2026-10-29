Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yMRLKxaH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9334112287;
	Thu, 29 Oct 2026 13:00:48 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B5B112287
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:00:42 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-36a10095f3aso279594eec.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278842; cv=none;
 d=google.com; s=arc-20260327;
 b=ZSdbaSxwZ8soOtYgDV8IZs/kJiIHVHaRpmusWg4mH2EtThD5fIhH1Q0l9+33KTOVJ/
 dsLjP2BawmAf+ifkk7Gr9Vv2922gWOyKWiuYhqXmux2guhXsYsfjmpyNJSiS8MLHg2TG
 Zt2JOdO8TX05D/wxz6N+csVuQsU3oqAKUtrRF215bbbEdk6h1sm3ZpiNm8oT7juPczJn
 trLYvnNvWQzXB9lmZJJkZ1DuMQCNNHB4ixvZ9m7hGS4D9i8nsaMZcbwULlU/1T3KApUX
 5UEq9VEZv1kkMgqLqE6at2JxyIQflGTBmerY4n9ZNkZ3L2V20B/e65nfJKhyzQ4JuAev
 YH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
 fh=L7YhPDVTonxPllsJFGIvOLhYzyos9QUKosWEUxaaMTs=;
 b=iiLeTIqrNwuyLN93SAF4IejlzHFI73SeYThPEZ6nSqSl4FOPg/MgUPopyrztAJZiF5
 EwsEAjYwqYYxOd1Lbo874cn50DdTe7JtyPXyQfw7zMbmGlW3cwWpxX+SMoie3kECZJGP
 YUkWU8Uy/PatvgH/b5RFn7cd/1JO3jDPy9iKtjfXAPGC5FmUyQ9vBhLMjasUmAYzUwoG
 GhV/ngbqnVyIgVxTt8s8CbjP2/5WpcjI+p0qMwDRHUCFFsMlEefByS5C0SedcWfvL02g
 4oRrYk/lx0fnIQ5UohYhM+7DTDHbLnHsWm/YX4wvDNeyzukSnz1+6/lXUTklYuEcX2kM
 +/Sg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793278842; x=1793883642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
 b=yMRLKxaHq4LdkjtwSPrZYeax04Cn0ZHUF3yyqKxs8ebgDKfRvb2RRJXwyqruYtsrmU
 qd15avt/VCjfO5v+xM+vZZuBRXiuUvY8WDk9zJQ/qvx0NG5qRa28gSOeXvo2F7PKLOy3
 CErOf7wboJ3ri755E5b9HDe2z5mHHOb6MsmWrtwZ+z7kVd0/wcsVmmMcGNJ1W3f3/0Ba
 1h3aBcK7eRK90WbnR1UGIOeMVTwK2D8X9UVa43ApT12UuKWK660V1PtVcB9W5LRtP7DK
 42J3A/TQD/5TvPZpdgHLwbBalkGZqx1V6pJP/+zmZ7Kz965mdtCMjLFusovA8yCb5U6D
 jDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793278842; x=1793883642;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
 b=xRraIIvPAJSOErWTctLmolDVSrK/DW3GucQgeKkvZ2GA0BCPMRI0m0JsFO1j+2VGRO
 y+jKxvYd4yLqbrcClWaNPOImxqG6a4bPIJ8J+FPwjiSXLvu4LdaThketQIqlgcCsBGOY
 Dal/07pS5n3b0wmNSdqrxun8PRbbRZb4e707TdIkiqgK1s3o1GlSxiLpfD6bb3xBAPmx
 Cc7zm3MqO0Z1zPU14FjVo8dU+k+XdRZccazwzFsOgl6TaQX9XUGGAWm6jSrtP0lsZdyE
 x/Br0wtNH1T5soyO+F3j/IcoJCkGGKadXIALzLyjtvdNAIfUu/BKh21YgrbXi7wijHOH
 AVJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpkOUg6EajQ8jEGh2gxe6slqGxl/Xr28mZsE1JFE1KHIFL/Yj5QTHF0l3YeTmrXst8BmlXyrdTBuc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6pv5/9tOpy6WIddZimHj0376QCmQVfyTl2encv4/S8yTlyBqw
 FHSTs/bY/weoq2Z5QYiMaGNrvL8lOT/sxIWGpQVkt3o1SLfDecCu809sAU3eDQiP8mii0sypMqx
 6p+E2NHS9lPRYUEAWLLOBdncuAc7vt90=
X-Gm-Gg: AYBFou27DPRdEub2/iuyyZhersqE/OYMwR3FApEUqaj4Xngq1RM0Dp1z1SJ0+QdIyzX
 HwEmBP7kBsMe/lGb4ciK6Lv335OPHB4+Vo+KMAxBH4T7dTqSunxknJQynQ5RS/IuNZxrEgrMR5P
 KHSyDCtw0THxO6a2OdmllFfOgUa7BqohCxEkqChlwN2qCH11VJHDNIs/b8vKcNak3ZU3OPVQ+yV
 KRphBTAL5+TanbSkjXHxeOmLjlagMWf8RptRQerRjiWlsFYPT7pWjpl5NEUdViI80bpXzCeZQCg
 0VzavG85RPaxNJpjMOy8doybdHEk2JQj4aHjg7Bn3vVCsV+4dZP7zoZQ/CwZnmJGC36SLA3DxCg
 UxB5jeXpsq2ARyeEjEcUus4o87Oe4/3Q+IqLU1BKW+RUYpaAwh621PKKSPZOgUuUl9X0Soj69T0
 kCt+5v1IVKDJFMYth3KAvD6b6ViUO51DIxtPpgICUAXzMXhAYnnH/hiqTubUjWpriuV3fW7fBqm
 rT0yM0LMjDQNHnCPXLuGEoeiO69neXAvXHi+w==
X-Received: by 2002:a05:693c:4196:20b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a202cb0e4mr12034617eec.2.1793278841146; Thu, 29 Oct 2026
 06:00:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
In-Reply-To: <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Oct 2026 14:00:28 +0100
X-Gm-Features: AclHuK_VOCF7u599iESvOsHhN0DoC1VeK-LagvEMwpUC6WNOUUTl411X-macJoc
Message-ID: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher <alexander.deucher@amd.com>,
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
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>, 
 Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 8:32=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Should gem.h now include <linux/compiler_attributes.h> ?

No, it should be included for you (unless you are doing something
custom with the compiler flags etc.).

I hope that helps!

Cheers,
Miguel
