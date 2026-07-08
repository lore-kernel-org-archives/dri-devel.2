Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BC3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 23:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C53910E9C9;
	Wed,  8 Jul 2026 23:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ed2y06MF";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D920510E9C9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783553408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pvBgwYa7lCn2bz7uXEDmoBIfHlXGdkFiLetg9jZiKc=;
 b=Ed2y06MF+UZ10efArl4vqWuC937NxrVi3UTxJHg9V3aY1w7AOGNLST57ViUMyRDlD7RgS0
 vGkGpbrffL/kou2btTHJrXIIyi1xM5aow+haMJ8yHMRXYYFTwztesF7V11PrU+yUDAriIB
 6avHwppOVcYO4Mdwz1589lPduX+RkVA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-wrtHjzGEPTytF9niDohk2A-1; Wed, 08 Jul 2026 19:30:06 -0400
X-MC-Unique: wrtHjzGEPTytF9niDohk2A-1
X-Mimecast-MFC-AGG-ID: wrtHjzGEPTytF9niDohk2A_1783553406
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e538afe65so46834485a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 16:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783553406; x=1784158206;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1pvBgwYa7lCn2bz7uXEDmoBIfHlXGdkFiLetg9jZiKc=;
 b=Sj0rCzZrJRxROEcBjpO1cC237HaIMLWvK/6O/aWuGwvhX5OOCtX11NEazdSYWy+1mY
 89AxM+nGLs0KEX922koyw3kX9i1dGPlpTTUpC6mdZdmJAxuXkJWlm4Dkb4noDusIZDH6
 zBcpfNpYTO9gnEDXNed1vxgNUIEeotN/bX4e7pkWGPDysSANTP6YnU2ouQt0dd16SxoJ
 3/SL7SL4uS3qy1X7v1htg8s5fFIgewnDQ0n+JW3GQw3gpKbpDCWhIw5ZH028ioxmro0u
 wuR7IpK1Z8s0zT2svqD4HRMZP2rkKCjlRoHHMZyF3K6J/fyFIS5jfgV+BoqCRtLXxU1n
 jeJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrhut9dfAWRTcniGgZAGlnk234RAaxOB2+YIqdwi9VWliJolTDJH5cHpKDzywwwXNucm1mbG3jFxHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymFZGJ+wJl7EvelTkOijQRShw1aCfQUNt+Vf2qHiHkX1DNVafl
 sIo7n+n7GOh66Ku9derJmBM21H023hWA7tMXKzQxn3hM+H4XCCZhXEx7w0gBtvl1Wx8gv+auP5N
 voK7HWCGpyaIihggBglmdctndnkv7lnR6HcuemfXwxfw1cDCqc2WUFZ7dOEKxXN16cJQlkw==
X-Gm-Gg: AfdE7cm4GR3N5/yYdaRSDMCnxhL5/g6eTzOCTMysA3R26uuV9uX5JeuvXcPdYk/auv9
 YGhr3UDeXUuGEAIjwz10qgeJF1vbpaY3q/haDJqaYkmT0JsiyJrhAEvYKbKWpz0nSm9987gf03K
 KlMVR71As4etnRkkXgHN3dHHuk48TRsyHieXSwvTHTSMfu63ZZSeFM4AYPPrrXSR4ncf6pF9zd7
 /VvEePP+Gomj2lYXhN3nkzxZNtB2XK8Gt8hfVM2HCpl7kWH0QmJOg0Kg5vFJAHPtqpN22s6jR6r
 WKJY6vvbLPU+iPYI5AcNG/T0XGGAU8IOLS4bEFa8A7gxgos+hv9EdvSDEdyDtI17PZHBaFZZYvd
 torNOL08=
X-Received: by 2002:a05:6214:4517:b0:8e9:a4e2:e43b with SMTP id
 6a1803df08f44-8fec4bc9476mr52194336d6.1.1783553406290; 
 Wed, 08 Jul 2026 16:30:06 -0700 (PDT)
X-Received: by 2002:a05:6214:4517:b0:8e9:a4e2:e43b with SMTP id
 6a1803df08f44-8fec4bc9476mr52193736d6.1.1783553405866; 
 Wed, 08 Jul 2026 16:30:05 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd7c1e8aesm3791076d6.28.2026.07.08.16.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 16:30:05 -0700 (PDT)
Message-ID: <51b38994ed2032a83160881e53994fb4487a7b02.camel@redhat.com>
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
From: lyude@redhat.com
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timur Tabi
 <ttabi@nvidia.com>,  Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Kees Cook
 <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>, David Airlie
 <airlied@gmail.com>,  Thomas Zimmermann <tzimmermann@suse.de>, Maxime
 Ripard <mripard@kernel.org>, Mel Henning <mhenning@darkrefraction.com>, 
 Aaron Plattner <aplattner@nvidia.com>
Date: Wed, 08 Jul 2026 19:30:04 -0400
In-Reply-To: <58219e62-99aa-4bb3-9c6b-5f96dae12649@nvidia.com>
References: <20260701182857.190713-1-lyude@redhat.com>
 <20260701182857.190713-3-lyude@redhat.com>
 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
 <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
 <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
 <b5d08cfe-aead-45f2-937d-6e9ef4dfea50@nvidia.com>
 <971d09c47689981c1ea44c89555f71fcc0b5db41.camel@redhat.com>
 <58219e62-99aa-4bb3-9c6b-5f96dae12649@nvidia.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xR7G7QhBylIiOc_jZ99mLYtEkMfhh0VtbhKyeADLLxk_1783553406
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

On Wed, 2026-07-08 at 16:25 -0700, John Hubbard wrote:
> > > not
> > > derive those flags from srInitArguments.flags. That field is read
> > > in
> > > only one place on the resume path, an unrelated display
> > > workaround
> > > gated
> > > on the PM_SUSPEND bit. Neither 0 nor PRESERVING | PM_TRANSITION
> > > sets
>=20
> This "unrelated display workaround" might be related after all,
> perhaps.

Would be good to note too - while it's not impossible it is actually a
display workaround doing this (as this secondary laptop GPU does have
display connectors routed to it), I currently don't have any displays
hooked up to it.

