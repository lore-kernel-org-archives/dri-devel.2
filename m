Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5C5C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278D510EB15;
	Wed, 19 Aug 2026 17:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B4Sm1BPn";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849E110E81B
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:28:57 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so211056266b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1787160536; x=1787765336;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JsZDOLFQ5v+IFbwO/zd7yRV9FVC6FQBQ7GYql46OtHg=;
 b=B4Sm1BPnUsnls7Dj7ycD6tj2QwKptDBeZUAmpyMicAD8kj6qEQK6N4uCfIe5zi0kDS
 VG+GTsiVz86SDYDKsWr6nfBIzpBaeUr7dItM7tj+hZzt4PhxihFwdwwOijCC9A+u7d6m
 t8FPXMdDeitCoqGUOEjzM1o5PMm4WpzXd24UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787160536; x=1787765336;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JsZDOLFQ5v+IFbwO/zd7yRV9FVC6FQBQ7GYql46OtHg=;
 b=NvFOHq/4XdP2zTOMSvH0TtKPjl21D2pp2j4+0bNzXxIvk5AdWG6JLM9GPfU1lol1/b
 v7zpC02Mhmt3ZvSEZhwiRTu0PqtzVev0R09aLpTLG5V0t+RKdtZ0sKWv9gZDnoejBaOu
 1TLd1YcxaHrl0y4qu4ZiGXPBhgan6XhkagojtRmeDE/EGF6TMjmEc77DA94jbOQlpoSc
 /bS0bsSDuuxdF2RABEqQa/SM2ysHR9wtagBvgKrrz12HORJ5aWkp+YoFm6UtJZxSy0rS
 Ih1d8U8/3fikP7XSZwaewxwFTLS+LTbx9VabfSlold6LiG+W9j0PBIjwubeGv6szYw3d
 wxwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrT2hLkyBmrZrm7wxwHg6+eGST5ldKPZw+cifl05McAKg/UThv37EC7HZHpI+DSIGUlpDKLyv/LMW8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGTL6XzfZhbEur2RvFg27fdBDJKS3sSpSAN+c4GZNasmcfFdyO
 QSEMGXW3fxtC5TvkAJwqw3F3xbFLp0XubL2SWOwWeuteLsSeV+EvUDJSOQkgoepr6XgkPKhFQcW
 ATDIS1zY=
X-Gm-Gg: AR+sD12ycqfvYvC9ZaxO0sGP1UfIv2oCLmwU5IDngHq9IxVNFt0qxeCcc5IbF+QBhLG
 Dn23eRrLnj58T0pOeWgVIGWEuhms9+p966/5b+399HKXddiUAsR5HMzmP4MrKxFKoQTTgXomGdN
 qdLecBL+ivGOLa7yO8F9Ud5wNNc7mq+WJA0aOKJ3R2ad99qKEf8/blRRH2FOhrdRZ8zyWcGeN3g
 qnS+z3sE3hHMB/UE+VJecLhTnl0u668WiAC9bg1K5J+YOTQSqWha4e6v58goWWstzTB1ez7FPf8
 qZexRGOpOhn372EI+8owjS5/5YzsvoX3yPGoKCeJf6+cLoBAS/I3T6l0mPSfc1tAIs4iXJL0+AS
 +aisJ02GqgmtnFK9tKa2pFZ9z5w08P50nzpCr11Tk1ZWqhNk2esy5H0QLYqwMxBE1FonNDjWtkJ
 nuEsrcaj2pJq2CINPxrxe6qB8qyxsXc68/awd93kRovRg+vh+1on4SbzAf6dMBfq5gcBILAsg2V
 /C6y2zqvFIHtbWUSKIvw0bGCIGlyGm9BrfVbA==
X-Received: by 2002:a17:907:7241:b0:c21:85e2:7427 with SMTP id
 a640c23a62f3a-c23f9352b16mr360429666b.6.1787160535879; 
 Wed, 19 Aug 2026 10:28:55 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com.
 [209.85.218.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff16c2cbsm1178632a12.22.2026.08.19.10.28.55
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 10:28:55 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so211053266b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:28:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrXis0qdPOoVlbclEZViaC5cLGI/rddh8P6UOKe7geFAOqJBhi94xCNuCuASAtp3GWVab01qzUI1YI=@lists.freedesktop.org
X-Received: by 2002:a17:906:9fc1:b0:c21:1b58:fa96 with SMTP id
 a640c23a62f3a-c23f93177b0mr382367766b.3.1787160535026; Wed, 19 Aug 2026
 10:28:55 -0700 (PDT)
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
 <CAHk-=wjr-6qT89G6TLAPPYpzPbq-JYS0C5e4i_KAUXwNzeStzQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjr-6qT89G6TLAPPYpzPbq-JYS0C5e4i_KAUXwNzeStzQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Aug 2026 10:28:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiioVSTWh3Q2889p+6y8C3-SrANxSLaBn6W5MBM+ddMbg@mail.gmail.com>
X-Gm-Features: AcwNN1VnqZvZU7mUOFRPyt8O_mCs4mVbHHiaZyNefQ3LWySeSDyadeAkFCuEcag
Message-ID: <CAHk-=wiioVSTWh3Q2889p+6y8C3-SrANxSLaBn6W5MBM+ddMbg@mail.gmail.com>
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

On Wed, 19 Aug 2026 at 10:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the problem is triggered by my insane setup.
>
> But I'd really like it back, because I'm a little spoiled princess.

Oh - it might be triggered by fractional scaling too. The thing that
is now working for me is the 100% unscaled mode, because with just a
single monitor I end up wanting all those pixels to do all the work
they can, instead of giving me nicer looking and slightly bigger text.

I think my old config that caused problems was using 150% scaling.

Did I mention that I'm spoiled?

               Linus
