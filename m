Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD92C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408CD10F423;
	Thu, 10 Sep 2026 10:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=szeredi.hu header.i=@szeredi.hu header.b="h6d+Ybgb";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A343E10F0CC
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 11:44:39 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-52fb76543e1so7863771cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 04:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788954278; cv=none;
 d=google.com; s=arc-20260327;
 b=kmEWtw9WzmKmeU2aNnnV4XgIYr9T6W6Q4YNrMrnG/+5jZLnv5Yi8K0KluCfsWTxe/p
 vzm5UvUidlnJZ/+X753BAH/4axVtmE5dQSlx8R0NTUYKBJd5JlAr9ZWD5OzUElyPMxus
 ARgIbhhiKQ+ZetW5g/nte5eqe0KJujRUrelnberVYMeMA42EpQzciAT/AiWNhFLWcNUh
 1zLGc5isa4f+3p3wN26fjQ3bY3R3nbTGUsmYXUDIInm3oKmJI9/pTFkVpmglNC9P/mW4
 s7qqBF8KVyT7WPI8XQudXrga7lsHUDk+07Sk6KLzhN/P6a51CbmeBsNHCNKp7R7ki+1U
 5q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/N+0yVy13tQgS5+ScpnESpLk/uyTrS9jGVGpFKTxRCA=;
 fh=BWWu4UGusipFCtstkfn8H+QxEYt9jAwKuL3EaQR3mao=;
 b=KtmN16VMzV7M/Dn46rCW56i0MDRqVMkrzaWbaOoZfgFj52OxgS+BT64Qq3DLEMz4Qg
 8XzVcnMSyx8U6hKljEw7qiI5p9/5gicE+qUrM+pIYtQRYZXoAtD7tb2jhgGWXNuiZ5OU
 3sP8TLWAH3Q5pHLXPJl6nKfBReKIUuIcb7pytVTuSH68hqfTtaXYG2tJVY0IdhVqUpzp
 LQpRXh4VTq8eWQjbOAVFV/VBvZglXGUVvMAIslSiVBt6LaTu1JTr6I2EP3Bko+bShJiJ
 sgD8zaWURDC0DAneO5wFOhHZcHkvcr6VQ2BdSZxDup1kmF81gzjH4byAIr+PinJ20nN+
 dR8A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=szeredi.hu; s=google; t=1788954278; x=1789559078; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/N+0yVy13tQgS5+ScpnESpLk/uyTrS9jGVGpFKTxRCA=;
 b=h6d+YbgbyqEbfKK/b+tCcIWZGSFIHvml3Na7AppBgPBjexN1pjNACqIXHCGMJi8SW1
 kP7LR0ed8dF3PBDXsMCrQdZUINaq/0tIwrZ4+pE6HPhRhg2yvxRISv3p7yuxSJnlGGd0
 MYmPWOyjvKXebJxyE8suryiy0SSaQm+KW/QkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954278; x=1789559078;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/N+0yVy13tQgS5+ScpnESpLk/uyTrS9jGVGpFKTxRCA=;
 b=icCKFTlDeTJpkmg3oNZh3Jft3dgZABGiwujh0sPIbNf94r4l6pA3ilv2fpV+q9IKuc
 m1tPJOrHnsx1rUZdA7tkzedDMFRNXyhxiomHK9A5o/NPileNjIZr5kEKX8osE84xkSV6
 FOf/A7RN0H8gf3Imcm/gruZ2zVbK/RmqJH3GzKgENuzg9J0rMIHQDCG/43IvX2yuhiAF
 FLHpac9rN27luHMjzqoTq7qKsidjiUmboWIVpE3n0jarePESW+7HQcn+FLE9Dnmk+JNp
 wGNIK3mSKkY3fOztc8k2TpFaFe5CKL9hzIDlMAzGna9C5uO6ZYllhfwhQwJMFIzaR5b/
 n8ZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6Afcg+cJcjXIvs6+XaxvKHBpDj4mncOn3j4dTLOPx0Q9zuPD0gJksqsF+STnvRe70Xsm0DquFsk0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nt71MV2kHRiTB8SRb/d3Jaoxtj29BLkjp8YtYUsx5n/TALigJb
 uB+VK2QSw/0ndEG2zUNxnR46b4THK25zn6em74p0RxGJhW5gltWq1Z5HRcEwahSP43WQ+C/IZEd
 u4LtC5SMafhWn1mgBs8+0rIjJ8jRx8Ralzo/TwnCkHA==
X-Gm-Gg: AYBFou2sW/RJY887o7zREpWNxJ0r5o+7b2vBRsuGsrzt9E43gY8BcKAo7XNpkBZkbWs
 dozVUjeyxHpozQ7JEpOxYgmqExbzpki6uPjzF0azer6xOzck9NkE20pqHoS5Ko5yUHTt0gdpbvI
 QlFiG0DU4A2RkLxMlSHyPUo27EhOh/RlEA3Zb93LYIo+mlbT9odxXWJMGizyDJi/OOc6rGeM92p
 uriK3Utnr6qNPj5hIuG0E0RyBZBpm9J+vXz6HEz0YWxxGVXrVRur+IadvFHx17Z3fCD3ZFfeold
 qg5/NtjQVQB6Q38zFmluw+ee6q3UoioOuHd0wgWFZGjeCFm0rAVZQKJjCqSo24y3OEucDA1H/Cs
 fiKkW7FTF/Uv6
X-Received: by 2002:a05:622a:308:b0:530:42e5:f39d with SMTP id
 d75a77b69052e-530913734b9mr126064511cf.25.1788954278478; Wed, 09 Sep 2026
 04:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260903145952.848051-1-mika.kuoppala@linux.intel.com>
 <20260903145952.848051-5-mika.kuoppala@linux.intel.com>
 <20260903152224.AD48C1F00A3F@smtp.kernel.org>
 <178878748003.179185.16833574173741290547@jlahtine-mobl>
 <178894801687.37859.4186888279082797860@jlahtine-mobl>
 <aqEzHQMrI8p9XVcu@phenom.ffwll.local>
 <785085e8-c9db-4d84-ab55-3a8caf9f4a35@amd.com>
 <178895308548.62143.17472983986994555742@jlahtine-mobl>
In-Reply-To: <178895308548.62143.17472983986994555742@jlahtine-mobl>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 9 Sep 2026 13:44:26 +0200
X-Gm-Features: AcwNN1V9qQ9dKCqab0SB2yrcU61pfAYqyf8l3R94yNLcs1Mbssj6NoYvC5wSIfw
Message-ID: <CAJfpegv_qh6u+GSFuPp8-PDXLoAqVWwz+kkwXv_zsxyL1PnkPA@mail.gmail.com>
Subject: Re: FUSE deadlocks vs. copy_from_user() and locks (Was: Re: [PATCH
 v10 04/27] drm/xe/eudebug: Introduce discovery for resources)
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, Bernd Schubert <bernd@bsbernd.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 intel-xe@lists.freedesktop.org, fuse-devel@lists.linux.dev, 
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, 
 Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

On Wed, 9 Sept 2026 at 13:24, Joonas Lahtinen
<joonas.lahtinen@linux.intel.com> wrote:

> From my position, if userspace is injected to the dependency path for
> resolving page-faults, with potentially unbounded execution times, the
> timeouts would better be asserted at the FUSE/UFFD side and then simply
> failing the operations with a bang if not met.

It's possible to set request timeouts in fuse, but it's not going to
be made universal.   There's just no good general timeout value.
Whatever you choose it's going to be too short for one case and too
long for another.

Thanks,
Miklos
