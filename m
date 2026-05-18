Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D937CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CFD10E72C;
	Mon, 18 May 2026 14:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="F36ZVhw6";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21FC10E72C
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:34:14 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5aa1b2327c8so2285699e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114853; cv=none;
 d=google.com; s=arc-20240605;
 b=QI0wqBTWVTeXKAk1F4lCAx3qVzcCHy1C/aIz5M6dCrRQ1n+rU2i72Zo2BDbEf0oeC5
 gNuo4hgIT4YAvZFIWty2zOLIlLLLAD1y7DkyHZXIGrR+8bMlBq/aKEz3KZIlTmJZEHSY
 7jWtFzr3J6ekhGl5jzGfP8bw/K0rbC9vMihSbIDw2lbuJOWtuL4B0dDkt4rbuwWcAE2W
 t1DjCdfXzJviq9QAYnISFnCyuqRcj3O0/uSHDQuuU5Gtk3v12YWMxoiG142fO98pwgwr
 3KCe9tB8uJFI+/DV0yRYaXWu5PgqqM/oL4h3kSGPhDP9yAWz1hKCmk0xRjZrYk6wPI0p
 oVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oqRnCaOYWjwDT5cGUR3SD10/guhtfL7tCTBSlh/U3DQ=;
 fh=a/SxMhDx98RkBXTWYrYGwvOqGpPsq1ztbmRVgglyf1o=;
 b=HmORT4VyISjemlXGYA7Km+lfOD4Q7uX6zsTCauAr5dJ2HPGkOzKfqBnwP+42GJ2Eiw
 69+DsKFBHTTkipghpQjPdB37TafgJ2sl6WHnpl7i+NLqkIXZXSm218xtzD0GX+kFbn5/
 7BlD3Ab1ZC4Zgvg4SKoqlb4IEcJO72Ow9XVfa4OVXpHk1Kov6m7cE6SH6i1seAfdZRfu
 bKo6mfyI0zjw+pug4pUT9kBE4tWpIQygxeqvhhAXaPPbGW4mCnb63/0VcbujuGu2iqgn
 HMz5CNSxw+O3EZBd7zsNGwwATK/IbWhX6wRNC5ln+X6tiPvfCHaYXil1aJTVMYoSbyWL
 8New==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779114853; x=1779719653; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqRnCaOYWjwDT5cGUR3SD10/guhtfL7tCTBSlh/U3DQ=;
 b=F36ZVhw6xg24CIwXeGT2xj88RxabskxttZtAPCClxOVgEME3w7F7MsoA++ifwYBAAZ
 9Kl2Dl/toBbChL3luov7kk62Qycd9FS90O2vFYC6OpiBdU7RVSFe53eD+gMVOyYX5OcF
 g5J62gNmNA2nHTd9v0/Pc7oYHlqP7b0PQ6bGYXLDEYA0k9MVvxqTOdYWFThwJF3XRnvw
 O/kx/WvNdTohRU4fYP1Qqst7WwoeG9UjCWjkzplTbc5Ar8BXolM+MDd1BPovL2lVtikV
 mnnF5nmZDodlHQpR6SPbLUo0mslJPXE4p9aN83JTKh3a6B3D6EJaS/AdGHFi3n5tEWvS
 AnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114853; x=1779719653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oqRnCaOYWjwDT5cGUR3SD10/guhtfL7tCTBSlh/U3DQ=;
 b=sWMoZLipiDLQj0qkFv0bmSY0pytCc456DIOiZbxXEaj6c7QEZ6UA2RjBccmsig7vpI
 VGIgqwXc6f7kC5LxZtwq/91vwn9lTjwYae1tvNc8w9x3uKoR8Gtpn3tF8ub6WrsOJgte
 UF4Q4lAGw28MUaHc4j8KRP/PQBNz6oYWiimT4zlgjdQvgXyucqWoE3Y+Y/Z5FlhIyUKL
 U+1y1nrEzhC2taoRPwjdtp/M/SRsS0SJaD7Po5VKCphA88z2pd8ETcKOc2rWQUF9WIES
 oSjNZYEygsKFD0iMP8GJge0BzWIxEYOVtxCCh0iWwpBjphT6V82RZZ7SLdkv6hMsvN3X
 dcyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rxKd5P95QeV+yVW1C5VdA4St6vI23iNgYAJR2gubNKn4zn11jwbdx0CXvJymPhTHx8loKkhfTnqE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyavmdto0e5AIY3oXCDprtIvnGlO9DX0rw0iyIwAbySqwrhZbPJ
 DTFh4fz5t8tWLWGiCYK13hTLC820jHnzG3KjKsDboBLYzrsxkr9BhmPvIUoJ5HJc2ZmN63XD38x
 Dh70AojDh+f2UipmyjxSS5+5M7TIElLO6MeRYPCdlsg==
X-Gm-Gg: Acq92OE8DQgZF2A3rfsxs3isi4jYDIzNqONBaKrML6mE7Z100IVY+vHZbe1eijhnlCK
 +3abYf0Rh6g2C43Ay+nqf9GTaXmGeG1EI0CBIE+KmYWvcPiPqYOmTl1jAHBSw6ft2cUxkva+K/j
 dRRhXFEz+XmoN9gMTtG19mG/PxPn93zYM8F5qaCUvS5j8fVKzuyyCqNa96+jgo9vn0u6wg+qigq
 J/PT9BicdHCCYv1+AxD9/1m24fXGQXQ50s70XU85486kZO7nPmDB/T5ohQCBMdMJuP0wsqV7XaY
 E0dXAW96
X-Received: by 2002:a05:6512:1188:b0:5a1:38c4:4247 with SMTP id
 2adb3069b0e04-5aa0e600127mr4228575e87.1.1779114852958; Mon, 18 May 2026
 07:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260514103815.190628-1-marco.crivellari@suse.com>
 <20260514103815.190628-3-marco.crivellari@suse.com>
 <CADnq5_OZG_vsEuUWgTPJtz-4zf4s=bA9Q_r9-w+KMQVa4RkMzQ@mail.gmail.com>
In-Reply-To: <CADnq5_OZG_vsEuUWgTPJtz-4zf4s=bA9Q_r9-w+KMQVa4RkMzQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 18 May 2026 16:34:01 +0200
X-Gm-Features: AVHnY4K214WNU2hBJ6vCTO-QsPeLak87wQZy7EGptiTlpMvsh_X5QK980jqHruw
Message-ID: <CAAofZF62w01GpNOQoSunLFboC=FXihb05rKNtZ1S9hQL4zEuGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Replace use of system_unbound_wq with
 system_dfl_wq
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
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

On Mon, May 18, 2026 at 4:26=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
> [...]
> Applied the series.  Thanks!

Many thanks!

--=20

Marco Crivellari

SUSE Labs
