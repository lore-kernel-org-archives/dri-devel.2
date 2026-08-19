Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24357C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F16A10E729;
	Wed, 19 Aug 2026 17:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DeC7/bw8";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC44210E177
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:25:36 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c214e625259so189495066b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1787160335; x=1787765135;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=brwuP3//9zJM0qC+/e2rlMQZs7hrreJP5tVopawxJ0Q=;
 b=DeC7/bw80AoecBdxkPUKMuVP9Q0Shj6idISl1OyP3sZ6CKC8qhYexFlTNQ/QBQ6zG4
 7O5758+GfPZOuLskPn+O5c7dD0EZpzT/dZVMrIhtOMIdBgHneWeMAUjG+EeSl8CY364g
 nyemFBs2Lv+n6OBpaH/Tdwu5jJOSWX3Kqo994=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787160335; x=1787765135;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=brwuP3//9zJM0qC+/e2rlMQZs7hrreJP5tVopawxJ0Q=;
 b=Z59+Ieq/C40ZZZEqhXRtVU982PRO9PDmSAdAuwJ9RGmlgaqEJ1EjRd2QsSwcYeWWQg
 oKztnzgRU2aFHBGDl7y1zQUE/G+XjJ1zhNmAXDpORdTnCvxLoTLhy/J5uREMrz9vjB1H
 Mv6X7HtgU7p9qxaFnzBgWTUKerwvi3SaTcI6PkLdZLoEEt3XBqqJeZiBjPXJbJXzoXVs
 TDiyGDznS/ZJvez67JcZPDFZwvZ9FJq7xrntsLdsvbDh8rn0jBgQk5x60fV/WNOJ1TsI
 MYxyCi/QLpo8Ehw/S173GfDXprPDZQsv9lBAy2kdVL8MDnGiM+TWbcYQ9uTSgPUI/xNS
 x2UA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXkCwgcJCGrKIx78eEQ5ENOyCHSJSPQZs0b8XNRVcdDDS8TCmN5UvMT3srdaLzCVqE0uFwdZN5EaE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyK0QwvVnD18FeCtpbxRVik7DykAlOoVvHFe+7q3DhnGkbgnOyK
 taN6dKLk74C5n13UBJcrDw5WOEm2bsCwEufuhBWtS+rLx1zolCa8Jj7yzsLn1A4xG+suAKcGmGn
 NMFpBzBQ=
X-Gm-Gg: AR+sD133IoVyZdKrWJXBd+i+pUvGbZ3NsY5mMcCSAX9TvWH/pM/0i58QBnoGOm7mN7y
 xa25s6bJaAusim4EjnysOx9AozZQJ0zhGG46B8411lnndwnHOBf/P3Ju4SE+mgVTLRE2NsF025W
 fQetNQgRKJ/34eYDN4fsjYoI6OtcbC8pFxzFIK+RBh0i9xH7IvUetT5iGudW+dDXXjl5HheoSaB
 L0+P2GnMri2TQQIuUlGzndlJqOoOY6Rx3j3kRIKpz5iuvguvOgV7cjAC9VjAV0BScdapqZgFckC
 APsVFGZA8meyDs/KivKaLCNgZLqHjYJSgDTLcEtoU007iQU/8LpAMU9lmISishCeaGkUjcndfSd
 bZHbjxIQbL51jG7DakoXsJTsuxwVoj0MI4IrxN3Ms04FLsCpOvzF6jnm+P1kr5YwaAU18OaH+AB
 iwSEcqI7eiF9MxHE54M/lanwq4ryoO8Yip/FDwVcVLhpp7rW4MhJqbrCdvf27ZVn6n0hB9tZrZS
 4PQgteVEodKmopztnGCkNnOhQ+r0rDAVl7D8A==
X-Received: by 2002:a17:907:3c8c:b0:c12:e178:9e68 with SMTP id
 a640c23a62f3a-c242e3d0ef5mr434667566b.19.1787160335049; 
 Wed, 19 Aug 2026 10:25:35 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com.
 [209.85.218.42]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c243c8e4542sm106365166b.0.2026.08.19.10.25.34
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 10:25:34 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so146775566b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:25:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqMnSfBVnNOtw7l3KB0xlwvIwJT4XFxBneOeqm//s38QuUVDgVdL8ZTKh1y7FLm/i0Q9G/VBXwDCnU=@lists.freedesktop.org
X-Received: by 2002:a17:907:7251:b0:c15:f26a:342f with SMTP id
 a640c23a62f3a-c242e6f411bmr456227366b.23.1787160333984; Wed, 19 Aug 2026
 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
 <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
 <aoWHKmz17HQo2uy5@gsse-cloud1.jf.intel.com>
 <CAHk-=wjv7SCjtg6JGDabGMXdqobx+WHogHfQeMPF2g_HmAU5qg@mail.gmail.com>
 <CAHk-=whskfzdWdUs3NwYm+e9py91xdiG5mLfYf=g_6QLpdaP4g@mail.gmail.com>
In-Reply-To: <CAHk-=whskfzdWdUs3NwYm+e9py91xdiG5mLfYf=g_6QLpdaP4g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Aug 2026 10:25:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjr-6qT89G6TLAPPYpzPbq-JYS0C5e4i_KAUXwNzeStzQ@mail.gmail.com>
X-Gm-Features: AcwNN1V27_argTDU-WRPdnuNp-fNznKgO8BRQ6CghDUjKQEHO79DJMiFwqlxOGs
Message-ID: <CAHk-=wjr-6qT89G6TLAPPYpzPbq-JYS0C5e4i_KAUXwNzeStzQ@mail.gmail.com>
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, 
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 19 Aug 2026 at 08:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I take that back. It hangs at the same point.

Update: with a single 6k monitor and no rotation, it works.

In fact, it seems to work ok with a single 6k monitor and rotation
(orientation: "Portrait left").

So the problem is triggered by my insane setup.

But I'd really like it back, because I'm a little spoiled princess.

               Linus
