Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725FAC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C270510EAD2;
	Tue, 22 Sep 2026 08:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQrUuR4y";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA1710E088
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:28:40 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso38795a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790008120; x=1790612920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h/keQYonBcmZ/ZuTxv1Ljqv5iISMw6Gg/s3/qwKvkbw=;
 b=UQrUuR4ydCDK44vrYhddFKjBIIkOVJN0tz3KdN753SWtEdaLIGkwL5jPSMw8XtKoNH
 mB8poOffXg2ZZwkkLXCeUjIECZKdwTGh9wmUgjCHj3QzCCOqel+EE4zjQ6KRA7KkJFuC
 tO8YN71Q1jIUNb2KLdiDaeBe+xGkIWtEi3CmA+D/BwMpu2Z1RJe9DNdjSU6Tfdxz+krl
 D0qgPD0b2Ubc/xAGOp+j8YnwBt+IFM3BzuN2dwqHAR1ltGVde+5hzvnScpoJNJRXUAjk
 TcfS0cPv7lXCehkWweP71LtXlOqXtlXBLyRQdLgWgZqmLH/TexAWzSzWV8SfD3dyr8mI
 qztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790008120; x=1790612920;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h/keQYonBcmZ/ZuTxv1Ljqv5iISMw6Gg/s3/qwKvkbw=;
 b=sFmit3yFWTBifL1IzLfx+sQVvqLdxl9Csic0/BaD0aiGIZDKBC0FQ2E3nsq7HQmh13
 din3NzxXheTpZgaJclJ2BRv2FnaCrWnuroe5TprwqRRdszDCePp2yAJctFYkUgiokV/+
 2dkNCtkSe9K0dDp8c3+X+qw+YD583G6Xo7ZkYlpR3bKewE/qSJ+XJOAQfaI8Px6AVa8l
 UVYLvET8E/f8Bjb8rWwUC6lSfISUVsndUfMxNJmRYzbBWE0rGRfPXfG07KnMKlpcTxC8
 L8OzgcqSXavjQWmkzSzSouvlxVoeNwFGiJAYVvtT6PLm7jBKbAcao9Mr0rrtJLJPjP6w
 Vsrg==
X-Forwarded-Encrypted: i=1;
 AKwUvByxpQa+MKMthYk38x7UWyQ0mChYrY3xxpHTzQYsRqSQsfYVUkDM1Z5NGTjfrlE58iLgDzGU08xBAlg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lnBoTBHSs0zJSUgrdSRJ04/YIHNKjdXDBnIG4Wopi5MsiYzTyr
 fCZ5n0K/jgdA3Vn1+UzK8Wc8zR8/6mr15XWpKQ63fwe9Z8RPsV2nxE7e
X-Gm-Gg: AYBFou2r3cwuW2udKiZsrD8oFznKhIKNGv5gmffkGPSsKm3b/S7M4bdAhVQhereBuG5
 BK6e8Gqz7FO3s2XjcTNeixCZdA84UyiCjVxLmuTaelfbOnt/5dzsFy6gjMq1PVKHhQGzAEyPdpI
 ylc8JZCFsgCZCse27DOLprr5Xd7kKyu/YHXZt12dVynWed7+JtCV4jI5+/ytOPsx0La9MOdWCMe
 JOO7xTiskxY+FBO5AGhkOf/c8UHOQH2qt5Nf75Cvqjdsvitu1ErjVbKGT0IWroekJB0VwDFhysg
 wQt81VZVafsMNpdp4pQ41+Cg2dEowsdvOldwfV0PExAsBKT6ZtbzjGlZDxxu7C7Pfg7iv0LYllF
 UG5b4UcjX1Z1eV7vkcHh6bt6Zaxyea19o+6ObSu5fjGJ3vYAniV9zWGnf/D1ldi9MP8d2HnRtS3
 kiLo8gDv4NceapwcSeu6z+pHscKZCJ7WSQZzpZ+93rwmBIcMVzBvPAOf+gPwOcDa7wusg39iDDA
 7xtdFxI1gmmD1FId/17N8H5tmAYEsML6A==
X-Received: by 2002:a05:6a20:72a9:b0:3da:eff0:c162 with SMTP id
 adf61e73a8af0-3dde0112089mr154097637.6.1790008119918; 
 Mon, 21 Sep 2026 09:28:39 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc72aee0fbasm3746033a12.25.2026.09.21.09.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:28:39 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Qiang Yu <yuq825@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [RFC] drm/lima: context initialization after handle publication
Date: Tue, 22 Sep 2026 01:28:34 +0900
Message-ID: <179000811427.1227592.4716389146886977098.idr-bug-58@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

Hi,

I would like to report a possible context lifetime race between
DRM_IOCTL_LIMA_CTX_CREATE and DRM_IOCTL_LIMA_CTX_FREE on a shared file.

The source reviewed is mainline commit
5dd1818b15d98d4a20806cd00b1b40320b06004f.

lima_ctx_create() publishes ctx with xa_alloc() before setting ctx->pid
and ctx->pname. It does not hold mgr->lock. lima_ctx_free() takes that
mutex, erases the handle, and drops the context reference.

An empty context manager allocates handle 0 first. A second thread
sharing the file can therefore try that handle without waiting for the
create ioctl to return. If free runs after publication and no other
reference has been acquired, the following order appears possible:

    lima_ctx_create()               lima_ctx_free(id = 0)
    -----------------               ---------------------
    xa_alloc(..., ctx, ...)
                                    xa_erase(..., 0)
                                    kref_put(...)
                                    kfree(ctx)
    ctx->pid = ...
    get_task_comm(ctx->pname, ...)

The two Lima ioctl handlers do not add serialization around these calls,
and drm_ioctl_kernel() invokes the handler without a common ioctl mutex.
Both ioctls permit render-node access. This describes a source-level
use-after-free candidate; it has not been demonstrated on hardware.

A draft holds mgr->lock across xa_alloc() and the remaining initialization.
It was compile-checked as lima_ctx.o with W=1 in an x86 allmodconfig build
at the commit above and passed checkpatch. Moving pid/pname initialization
before xa_alloc() would also remove the post-publication accesses and may
be a simpler fix. That alternative has not been compile-tested here.

There is no Mali4xx runtime reproducer or KASAN trace. Would initializing
these fields before publication be the preferred fix, or is there a
lifetime guarantee elsewhere that rules out this interleaving?

Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM

Thanks,
Sang-Hoon Choi
