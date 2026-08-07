Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169CFC5AC9F
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 18:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED33210E118;
	Fri,  7 Aug 2026 18:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QCXQwZq+";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0143910E461
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 18:44:29 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a156627e22so3524450a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1786128268; x=1786733068;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JvGVlcH7x6TGfUTjYN3iZdn+SL6UTSdew5rMIN/ak0Q=;
 b=QCXQwZq+ClDerU+JlSphAFV78uS4+bXJpD6s3XKKqfArRsYrHCi3fRu17Abx4e/6+5
 /e/dWO4rJjvPFLM7+NnmFlHRHPdFYgLZMa0KKO0XeN8CIzj1hiwn0rZoNudPMkOnNpER
 AV9v+r6skjWmAlDWx7qsz0xSGU5efmASMXKwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786128268; x=1786733068;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JvGVlcH7x6TGfUTjYN3iZdn+SL6UTSdew5rMIN/ak0Q=;
 b=ptFEKdPV4SFK6yDvSPQUyc4Lno3gr6eVmVzhfk949aNTEI5m3Twstzd6jZb1kdbv6i
 XyJT1YNx56axaClON8cRMDbo0RWYt6pFdzns+6AFMAf7V7e1gxJiNmrXmLQOHuVpYY+n
 AuF38YFXhz1tJEuOzJxfGsGEJB3RrTqzJ3Z+ODYPugCkbptR8L4jDw+tWYVTUdB80tFx
 1Bkc9Jo9MYfKJyF8Lk+DXSPgVLePop2vnzjkkYFPPVw4THEHHCXcyUJtdOt9eaWpUqqX
 OxK63+gpF9rOavHp2V94H7nQXYQ9ilVN8SbMloRxPg2inWH/XlrAnG8n5ZH3NxnfAADK
 F5AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrovyMtt8X/wA/hopx8dw6VwC2Z8mMhohZUelruoFvCF+tNUPT8UNznvw3e1k7yU3rQJFU6r0VrxGQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZLjKxnw1fAdwBLdCxaXD1fHy5d1VjAxKqER/IbadzgGXyZEsL
 gtAsKCmTxwxco0dTLxw3VI442h+eKNweFqGbTFducT6tagMqB2kcCIDptJ8XQPEUAfUg9FrwTeB
 NsYzKbkY=
X-Gm-Gg: AR+sD12WhTKvaz41d3WpxiirhPCf3ewKkHf+w79NaHfReob9dgUwaFQ0fQ2r1ZPhZ9B
 tTTYB5mGI/BlgDijGXt/boncxJBlWSMrH8iqXOXarN1ZfT81On4TOUmhciQACEyGu8QCjY2wcjS
 /xXT0jg31F7U3fQV1NmkxqiCGKQqo0+FPR6ixD8mOcx+ewYBY2QyXCa4RgUko62hmv+BKAjULSL
 +qTsj1MA7grN7cL1oAO39g3aa9edoH8ZIC8mx3Xrj4Fj2it3moSrGhjwVehCaxCr6FVA39NBDBA
 TiBnxmUNdtgDbBha2o3UxFMgMlctrzIJa8XDdzGp2g4k1J32CiuwTGaKTpue7hJeB3MZVgYA7Xq
 1OueBDN0jA+pTFFJzMA2pTg+QSQv119vn34pvXyGsXMYup/cVMCu7K29poMZuzj3aQwAgxlh9+Z
 28pxcPjc+XrqZCXA20K2O773RaJJfclWIqAd9x4JCVXYvZKZgebwLE6waD8Z3uTH18yIw1ytFm4
 7LiMSqNhFtSrHWcgtBztbX77Z+K9nqTmw/Cuw==
X-Received: by 2002:a05:6402:238a:b0:6a1:79de:f836 with SMTP id
 4fb4d7f45d1cf-6a1f4e4d875mr286929a12.5.1786128268273; 
 Fri, 07 Aug 2026 11:44:28 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com.
 [209.85.218.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a1e7d7812esm875519a12.31.2026.08.07.11.44.27
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 11:44:27 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so433035366b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 11:44:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqMVSJrIQK+N/r8GF3iZ3pfMwLh/KnmYW0Q18+qTtYXFiY3g2SA5S01HYO52F9rgAttqOUqGX4ZCOA=@lists.freedesktop.org
X-Received: by 2002:a17:906:c153:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c208d2df2d5mr36200466b.2.1786128266959; Fri, 07 Aug 2026
 11:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
In-Reply-To: <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Aug 2026 11:44:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjNj9WNGgGKRC-nqh9_yHxHTEtV2Hpa_+4gJ=e+Exdxw@mail.gmail.com>
X-Gm-Features: AUfX_mylGnts_HhKz5OUdr1TkChd8YF5gFEyzSFicxqa-mKJ_sbIgq9Z5CWxI_0
Message-ID: <CAHk-=whjNj9WNGgGKRC-nqh9_yHxHTEtV2Hpa_+4gJ=e+Exdxw@mail.gmail.com>
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

On Fri, 7 Aug 2026 at 10:46, Matthew Brost <matthew.brost@intel.com> wrote:
>
> I think we may have found one. I haven't been able to reproduce any
> kernel job timeouts on drm-tip with this patch applied [1].
>
> If you're still seeing the issue on your end, it's probably worth
> pulling it in.

Just checked: I haven't seen any "job timeout" cases since May 26, so
it really seems to be a very rare occurrence for me.

It might have been that something else changed too, of course - some
user program behavior change could have simply made the trigger go
away. Not that I know what such a trigger might have been.

Looking at the logs around the last two cases, one was just after a
dnf update - maybe triggered by some restart swarm issue. The other
was fairly soon after kicad had a core dump. The kicad core dump may
have been a symptom of something going wrong, or the cause.

I dunno. Nothing looks obvious, but clearly this is not biting me very
often. Months in between events.

               Linus
