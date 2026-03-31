Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD8CFF60FF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1280410EA47;
	Tue, 31 Mar 2026 10:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="LJsZFI77";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639AA10EA47
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:39:35 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so750299966b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774953574; cv=none;
 d=google.com; s=arc-20240605;
 b=bYC2d32oF1adFwx2p8+ESpa8muxAYsFsHrgGQzwnP4Mwe9Cge0GX9PyMzMbUNa3jw+
 d5kcof/ngJ2yYwR0QaRViwds/CuZjrl3RH3vmXrl7GNTNzKmZfnPYUDg2MgnrHQ7vSpA
 /EqEMjFgEhlFyp28ySWBKaqRhkM8HtUcvOHx0IFctQodRsd+90gZnmyh+HvKPz2ZjZl0
 ScoX8uCWD0Es1IJj68Gtt0UGWSaqArL3NKWOhgvt6lxPvPKlaIW9s+f29df/k5cDCxFl
 u2ZOTJcestvNojy7GDb1DY54YqiQ/NUzOMMACgUjEToXjRsUeUNUroOTyYAHbdzRH1We
 Ba4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kusDY7YZ+tFfW4Qh+6x4N1GmgE5KProC/ppWG6hzDqs=;
 fh=B4IE7H3whSaocuPmMfewawM7C0xLMHy/ZU/hBGlFdgo=;
 b=KOdXDxtYEAfYKR3u88EO/qf0miRam+O35R2XuWNfBBNCZDESjz6c4FoLHkEKobzHrq
 eZNBW9w4tD26/8pcVACJkKVO6kdI+6NUZqO12EwFvVykr5eDWLYnajJ9HUAmwTwIxyGm
 YcoSadmxRz0VWVmRERR5Efqxz4Q7ORTQZwE5HtEfyyjr2sdCp8RGXMGHASiXqdccp/6c
 Dou8LAq/C+PJ2nwH22U8hcXIF/yw6oiaGHrEMUxrojbfoZGhaIR+9meAgHSWiFkABITG
 +6Q1kIss9OVPOG43KCSynJUsJjwU57U87WCJACfqyt1SCeB1IZi5rb9ossu/E84//STS
 jp6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774953574; x=1775558374; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kusDY7YZ+tFfW4Qh+6x4N1GmgE5KProC/ppWG6hzDqs=;
 b=LJsZFI77gwROhZ5OQwxKwSZpZZmdSRQADWm5lFUvrfyFcIiYzkm9e+cK2ghVpxUeHW
 TA2FKAC8hVdxAO3X5HzfkxQyuZ428x9kOAGX5T9SnRFKjQ5OZl/8y1a80ckRYuQ5ViMz
 nZXkUuKd+tfHnnR9butMCfhIluNXEg9Blhx7pybKbVvAXfgYwioyJbABwdizF/YC0fvu
 TkbO5ZfXmkFzFiej8X156UgnNNTSb2N3pKztPHrG+wSYKqkeJsiBJPomU7SLgFlfIka/
 kT5zuBZBiSSH5jXRRI4S/By6C2Ve22JfLQOk2iZlqWHldENJE9H7FNYhB/PZ6A5/9FuN
 5/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774953574; x=1775558374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kusDY7YZ+tFfW4Qh+6x4N1GmgE5KProC/ppWG6hzDqs=;
 b=hJf57uEaEno6RQjlMVKqpu+S1BiT13eZDHsLo7A1oruGVYKQtRINpkfTvT+AFLbJ/0
 ffWr4z7SgS+iUVGYNLhii86L7DfP8V49gNmQJOp2aquvrD7V3BNPc4oMATa8avO0dKkk
 a149uQOGzDY5EOYa1WWVG5k5IPkzXKX8zKl5c9FXr3e6aCbjFGlhXPsYFiSSFpBnzIn9
 O4vxm+VWUudAvfkZCKUKcoQMdaeWX+meSln1V4aqvH4z4IWEWkpuG3hdBUA6Yia90O8J
 JtpS1bn+w93bT4xn2am+w6ki5oLeK0LhOtWjx7PhvgpU6tO/bxSp/Gi6L0hacZup/xj/
 oxPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkrZViiSY7h60d1wn1o8t4y46E3i/pyyMwicF9JRytNluRK6w01ilK1XP7wd/1fXC0Rnv28QNRgIQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytU9zCIlhJsTmbVazNJ6aGVEqgjAKWLymS9gRdYtBb1N3esiiA
 b8ca1WYrmZZ1xISO4c0pbjv2FkOO5YWxMCv4hwuYrPA7Bbp3V3aCUuXX2lPCKswj9GxLOdxY+Zf
 0I20Sb9vqDHy32/RQoKfDhxf7fpEbovtE1/k8zLHm9A==
X-Gm-Gg: ATEYQzxX6y0RAO3gyWM9HQ5qPIX+8zc2elKP5wkuI4RSTJW6lDr4l70/CvbhGmHryyV
 DApQBmh7nrsqJEpLvqzLre/WxHx1USVbKYKRfC74TJXdGDQ7GpwUS4Axo3PYqlnA6agzilBAbsh
 OLgkHfbZQHjz4xRebjcCGBl+B1X0I+CgYiikaD36N7LPxSPECV9nbSwT7zEBNL4oVBXe+mWC1u/
 EsqMOZxy9s/U7dMYm6O5X3l/+eyj++c2eqNhFh7Rbv4ge+qSson/qEUTZoSb9bbCSZysTHYdsN3
 3mMq2MAQtn5qiR8FAnbfYYVHtA+dn4O/W+y/DVMv
X-Received: by 2002:a17:907:1c1e:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-b9b5039c50bmr973724166b.21.1774953573829; Tue, 31 Mar 2026
 03:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
In-Reply-To: <20251224144708.61167-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 12:39:21 +0200
X-Gm-Features: AQROBzA1GCR73klIonCvm9thhdPK3tuRsxSEGKNlMoptMNB4fEkPwsTY0svwnfo
Message-ID: <CAAofZF4YKvKvBf6t1aeztkvkTWji1VbrW75dL7NgS7jkLhgNgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Replace old wq name and add WQ_PERCPU and
 WQ_UNBOUND to alloc_workqueue users
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Philip Yang <yangp@amd.com>
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

On Wed, Dec 24, 2025 at 3:47=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>
> Marco Crivellari (4):
>   drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
>   drm/amdgpu: replace use of system_wq with system_dfl_wq
>   amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
>   drm/radeon: add WQ_PERCPU to alloc_workqueue users
>
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 3 ++-
>  drivers/gpu/drm/radeon/radeon_display.c    | 3 ++-
>  5 files changed, 9 insertions(+), 7 deletions(-)

Hi,

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer
