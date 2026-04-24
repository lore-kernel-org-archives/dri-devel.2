Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23156FB44CA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F9710F41D;
	Fri, 24 Apr 2026 08:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KdGQ+rOk";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D4210F41D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777018687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shpYQ9KZLbr6N3HVlTPITJ076laxtxRBnaiK8rmbhhQ=;
 b=KdGQ+rOksMmtNSNpYp7CmknQkKu04JQoI2Szr5eK0qd/KR5uV3VyK9iHh8JC3BKLQll1FE
 0Zn8cyypmqzphga1c/ivjXe9nqDjDKH1VGOHQeSOrWlhGcEDfipOcJZlLkgPWiaCL3iAFf
 m06ieyw1d36sZ/X4AoO7R/a6JtHp1ME=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-zBH7nmPmNmiWvvolPdYM5Q-1; Fri, 24 Apr 2026 04:18:05 -0400
X-MC-Unique: zBH7nmPmNmiWvvolPdYM5Q-1
X-Mimecast-MFC-AGG-ID: zBH7nmPmNmiWvvolPdYM5Q_1777018685
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7aa1e8734d4so156680437b3.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 01:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777018685; x=1777623485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=shpYQ9KZLbr6N3HVlTPITJ076laxtxRBnaiK8rmbhhQ=;
 b=LBvWXtmyBO5MgPKHYf2C2wuQlQ5UBKx3Ytm7kMCMf8CB5Db71p9VYhmLVPqHtAV5jF
 wC/vX/2k3ef9sbRisESxwirwDGvIazo5qQfsKqgq9xODXJ+zSF8xDksCY5xMMKDBLnYK
 PLSoSnVDBKfhT5JLd9TJec3m0dyEPncgDXNzaGzjle03PYJ5r0WsH9WiCic+1aaZQwTv
 kCet4Aow+DJgw272q63gCkUGpxR6RXV+gdmo1CcUIkd8JaCAH0fvNucnafsLnrT9i05z
 GlblJQJ0wJPV0Ax3G9Fbk3WgDqnPrFgA9+RxC8WtbB4NrX6HCrUg4saOWMhAIonCrkOr
 n0UA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cElGTJP/i2LqwOVHubXlMkKPDM0pBfDYot2i3dYiiM1Nzv2OZmitnpjk8O5Puziz3hHlGAtipNYA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxlOsmZMyllNt8NwLZCY6q58YaT+gBdMCDU36e1xx5p2f6vJuV
 JqTwE8ovmjnw3ZTV8o4PHcJOLaGFM0wUfxgPsIcdH8fDo3Nxa4Lw1ZKJ7qvn+07e/S0xW26cSOz
 L3qG/o1kZB5nkbq0Y1TCe/IZgDEXtoDPoqWWGrT7RyaxDOKzeeeHTmNkWe86dukFMAue7/8kCXS
 s4R5iiINoazfalO/UXfJciZkOB7PbGEcfp3f1VmOO2rUVj
X-Gm-Gg: AeBDieuFpNNiftGUWJcgOkEWUvjHwgdrI24mpWZt7NSBdUndSXHDcc+SNBAAPSKvxTf
 IiTMg/xFnzzbhNa10y5neWVxCBwhi90Xpy7KSvOYiDUBrhS8O9/u+JR4+YumzfiOQe9NhEYXAwM
 Z0HXkXhwaqoDg5VmxUTf1kZbUsGjUcD4DRGaF6jpaWjojmW/DJAviMySBXRU1EgSeh/3dJ/9ITm
 z2fODkfYhdkLDb/
X-Received: by 2002:a05:690c:d95:b0:79e:8299:751d with SMTP id
 00721157ae682-7b9ecebaa2dmr304557177b3.11.1777018684954; 
 Fri, 24 Apr 2026 01:18:04 -0700 (PDT)
X-Received: by 2002:a05:690c:d95:b0:79e:8299:751d with SMTP id
 00721157ae682-7b9ecebaa2dmr304556787b3.11.1777018684469; Fri, 24 Apr 2026
 01:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-2-e8bc6e0f70de@redhat.com>
 <a1ddabac-8e50-4730-b936-4ddef949487e@davidgow.net>
In-Reply-To: <a1ddabac-8e50-4730-b936-4ddef949487e@davidgow.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 24 Apr 2026 10:17:53 +0200
X-Gm-Features: AQROBzCPgKA61g5jTjlSE5A3sG-gDo7X0r4wi6SlVdjlUQQBr3gtOcBVPcG2A_U
Message-ID: <CADSE00La5sN18OqEmSE7NHwHnS02k5C1Gn2+o9hy4S4zLgC7dg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] bug/kunit: Reduce runtime impact of warning
 backtrace suppression
To: David Gow <david@davidgow.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, peterz@infradead.org, 
 Alessandro Carminati <acarmina@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QFaRqunM4Ykbd61BQ7ZwgvMc0SZ440ZX_BchPPbrWzM_1777018685
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 22, 2026 at 2:21=E2=80=AFPM David Gow <david@davidgow.net> wrot=
e:
>
> Le 20/04/2026 =C3=A0 8:28 PM, Albert Esteve a =C3=A9crit :
> > From: Alessandro Carminati <acarmina@redhat.com>
> >
> > KUnit support is not consistently present across distributions, some
> > include it in their stock kernels, while others do not.
> > While both KUNIT and KUNIT_SUPPRESS_BACKTRACE can be considered debug
> > features, the fact that some distros ship with KUnit enabled means it's
> > important to minimize the runtime impact of this patch.
> >
> > To that end, this patch adds an atomic counter that tracks the number
> > of active suppressions. __kunit_is_suppressed_warning() checks this
> > counter first and returns immediately when no suppressions are active,
> > avoiding RCU-protected list traversal in the common case.
> >
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
>
> I'm not sure how much of an improvement this is.
>
> It might be worth putting things behind the kunit_running static branch.
>
> You could even add a new kunit_has_suppressed_warnings static branch,
> though I doubt anyone's too worried about the runtime performance of
> WARN() during testing, but with no suppressions, so it's likely not
> worth it.
>
> Have a look at, e.g., kunit_fail_current_test() in
> include/kunit/test-bug.h, which uses the existing hooks implementation
> and static branch to reduce the overhead as much as I'd expect we need.
> That'd also potentially let you move the backtrace suppression code into
> the kunit.ko module, so you're not even paying more than ~a pointer's
> worth of memory if no tests are even loaded.

Agreed. This patch can be removed entirely once I integrate it into
the hooks infrastructure as discussed. The kunit_running static branch
is indeed a better fast-path than the counter, and leverages existing
architecture.

>
> Cheers,
> -- David
>

