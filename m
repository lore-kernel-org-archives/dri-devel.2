Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D33CD8CA8
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 21:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120D210E10F;
	Sun, 14 Jun 2026 21:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s1nHAxCg";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AA810E10F
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:13:12 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-7e8b45dfb3dso30452797b3.3
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 14:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781471592; cv=none;
 d=google.com; s=arc-20240605;
 b=lBs5B+uhiIfBuhCsmsyeba0RRLBBDQTC+zHPM9xV7JZmAGa+3sP5Qqzc4uJUElJBEM
 uDV8/SiDrOIhy8aOF0IEZSXS26S3Qqteuylxcvk+NUIBgtuzc0/EX5vN+DJedrCNWjUb
 7slgLE/pOTfx/Y6kA1S6+yO8n2TmmcvZ8AP/BfPmWeft50MfWy0frNl9dNNzG0RPMc9y
 a28fRv1h/RW3m4h7mOYw1G+dTauez3CRAT6gTkJfp7V1LGAxj8GWpYLveQ021KWx9cG5
 ShmpyVDwnJQbpsmcVsZ0hEoJu22ZkAHZlnxmKUVzgUw+cTTER3TR+dyga/7M1MAAk9q8
 APpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SCpQq/gJMNMG0QpyLJnjcyvo+H8BBj8uZy/PQQOh1lo=;
 fh=M3V3rAIV5TcpNYNqutikXaYBI9Jluu7o5pb7smBDyxI=;
 b=ENXhl8gEwgvYSQMKmNle7B+U2qHp/4ePN5VH46YlIVZ33QocXuKxWd6/fAiRuNRfHR
 3jMLvC6eDzpzVWud318i6DFfsxvwNmgTriQ0Lr0jwQxjVB8u8gPGc/cqyuhaRPZ4QICP
 Kp6HtJy9j02gPujjYCljx34U27zZvntY07tRx+CXcTopUWoO0d04Y0Jy+1s2IQ0kQc9j
 YUvOd4+bpBH8R2nw3F0JpLyMgCMN8TQcCF0YHDtgsnB6LjRUPGTePaP1k0p0WvQsUukm
 MJVLzViXRSQWCugC+fk7LSlCdHR8qytVKYxAulW+X6fp1VRmJ/Rkxw3PPU31DPwcN+/K
 canQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781471592; x=1782076392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCpQq/gJMNMG0QpyLJnjcyvo+H8BBj8uZy/PQQOh1lo=;
 b=s1nHAxCg2iQT2Hd2E/gV934OuIqOU4AUu0jGY0U1dWW/LP5xZfl0KvuPFB6RcpfOu6
 OdIUg5342X+sy86MZ1y2M/BePjvdZRm6mLi+bYiI+jI/r3BUHvhFpHr3Umn95KSIhlJF
 PZnqvVk9sVeON/Yl/Ci5+LE/BJ5HeKY6dfj8N8VhwxWnrk1fWIWmaFuGardlzzDH+3Db
 Wy7Kf2ITTCYX0DlqzQLNNwQOiEMk6oZ6nhqNOwmGOaZe++W7VRcpZ7aw+cAxk41g5Znz
 qEzHR4vnLvoS+tUZhK5e9il3Mn9Ti6mHLn7wjNM4ZPWBZXvLPg054w0On2cChp2hQX8q
 xQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781471592; x=1782076392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCpQq/gJMNMG0QpyLJnjcyvo+H8BBj8uZy/PQQOh1lo=;
 b=jxHe6QoBZ3fR5vz+xv2eRrgLlYPqNtc3R85+14Jz8GJJdzYzsMkVac8C3s6LVfOW16
 Z57gCVE1749OwBE2EsWo90nGAh/QKQbWJ2wAwSaFhWqt/oHdl7MPcrXdI5Mq/TW6mjDC
 mLjkmWN3GAC2lBkGMrOKKgtKgzpwtIQlRFqQhjO6d03fh5ZhpGEfzvVSCLFLnWYpAQFO
 4Kk4fti9boAPGzZIyVaI8t8seX+bgJQ5bi/pflJsyxvXatz3DQTxcLRxIWFZscTytQB3
 MaBpSBSTl42X/c8XLZEMBbzoN+00coW6EGnuFz8Fyq6f1bMDKu8k30uphewiTHo0UtZ2
 EF/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BQHavhLuBL7cD3As1AJgUDt5gZUzDXvPkzaeTTFiRwpDwnOgMXZrWXBTKJHRPPn915ExilpuJAD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0nylOAKLenHaCW/7Zz2urGDxQp9vmzXtJR7Z5dBm6D0aDq8cg
 gte3ZkdKZuWCR4gEZOpiM/bVL9IyKQKaJF1pLfDbqaR6FMTefOfs/ei9HUoPNypYOQ61fmPvz9C
 m0ALejTu7mbsB9eeCfXh/y60YE/KwSqA=
X-Gm-Gg: Acq92OFc4EdGbNgU19B7AiivT1HoOR87/iDhMcDtEED5oHrhaxppf8Z/GPET3GifPqX
 R6y8wK7VmOjTrbJiTKf1dU/WV+kiMuRUY1JYGX2Gq4oB3GqJiGdxlsd7djsQeYxgX4dQ3ucSFMl
 U3w6nJuRfV6zQKDH1uq2vR8FdEjfX3qxCoOzWYRp/uMygISxHRX0ojVFJklzINFNj2+/P/3V53K
 l7UYsbWRXNMVYzWWnZrtHiITCoRp0wrxwkrsNduWszGUbJ+bbdS8cJ1pzd/8yOf/JaNWzL4KHh0
 XayDlqwYOHJx+txLlvdriVDuPq9mLCVwxG4N
X-Received: by 2002:a05:690c:64c2:b0:7f6:bed8:5420 with SMTP id
 00721157ae682-7f8c2cf66f2mr86891767b3.16.1781471591811; Sun, 14 Jun 2026
 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131100.2525157-1-michael.bommarito@gmail.com>
 <20260614131100.2525157-2-michael.bommarito@gmail.com>
 <6f1d1888-8176-48eb-ae4d-bda06bd07ef5@igalia.com>
In-Reply-To: <6f1d1888-8176-48eb-ae4d-bda06bd07ef5@igalia.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sun, 14 Jun 2026 17:12:59 -0400
X-Gm-Features: AVVi8Cf6j2q0cSi7cZV8qvEYZ5dodaLRoYk3p4jxhX2Xqv0uTSnib-4wUdgqH8E
Message-ID: <CAJJ9bXxhZUfaamWRK7jWsdJMui66dtULYjf6=R_igT1RBpuURA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/v3d: validate copy-query buffer bounds against
 destination BO size
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Sun, Jun 14, 2026 at 4:12=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:

> If you are doing it for V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY and
> V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY, you should also do it for
> V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY and
> V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY.

OK, will do!

> How could this ever overflow? slots is 1 or 2; elem is 4 or 8. The
> maximum product is 2 * 8 =3D 16. That cannot overflow any integer type.
> ...
>      if (tquery->queries[i].offset + sizeof(u64) > src->base.base.size)

You were definitely right about the first check being overkill, but I
think we do need to think about 32-bit for this spot.  Let me  know in
v2 if I missed something

> About your second patch (the KUnit reproducer), it's a nice test to
> reproduce this issue, but for me, it's a no-go in terms of upstreaming.
> This is a very simple issue, not related to any v3d functional
> regression. So, I'd prefer not to take the KUnit test to the branch.
> Regarding this fix, a v2 addressing the issues pointed out is welcome.

Sounds good.  I am trying to send them by default after getting yelled
at by Greg for not including unit tests in every patch he sees :)

V2 coming up soon

Thanks,
Mike
