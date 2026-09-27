Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF00C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 21:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FD010E2E9;
	Sun, 27 Sep 2026 21:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pq7iMiNm";
	dkim-atps=neutral
Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com
 [74.125.230.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E8C10E6C0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 21:17:33 +0000 (UTC)
Received: by mail-qk2-f40.google.com with SMTP id
 af79cd13be357-93c5a837375so64892485a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 14:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790543852; cv=none;
 d=google.com; s=arc-20260327;
 b=ImF0HJ4ffWIxr6E4R9CKdpXzlSOChw6PxVIPuVzxdKTkOWDTCXiZaJfj+DW3p1PcGN
 HKhzJmFbpj5sumpxGlO6MGdDb+CxxwdXJ+oCHlmKQDiAEZtBqiFDaVb393P/EQNThzbG
 TMXyQZPLrW6VLCb2VDwjalAOVzpsoeWlnbmpW1kC7jI7dIahY+Ttz4msjrzfinQ6+NwI
 3Mg5Q7PPMJ4JnnZFxGYNjDGLiz0mYzuFZStbSLpCzwKgpZhPv1k6z6YWAtykaTJilGoX
 8BZO2O85F4doOhhjRkNxT8PqXvbf7Ky3CjHyE3GiAL2mX8CIIwin/vFpaVdI+tTk6tm3
 /tIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aMhTNMHCy/W9QF11i6so/5746wOL4VdliI9v6lvtqLo=;
 fh=TolZhRkc3/KkDmGd/Hsyr0FPfH+sjOhV9Eq3XusccEE=;
 b=s+JuE+jFzwxrA6WNsQXeIA/iDFdybmgsmdBHx1BF2VciAnxTOcTtFTs9+war1/bnGB
 zvhqmGtCYrh0KotGCurDbnm8if3fjIHZs/y/rWefvDSXGAcAl0la/nUm7WlI+l0Iz3td
 PmJVpP4sxOvTy3iPYBDss2zl1muBF+yg0y9Y7LcS7eA/gGF17k24fO4CslzTqkqDdecO
 LGpgz5PQnQgmUvB4BtgYbH1z87LYxh5iVXP0TcGw0yANGtkHrIuOteYEPdteJnCkdUHS
 Bc6wpkn7PT/iUqCF5zfU3qFdvA/aBd6B7YuObWV2nHEXRpvtioadm7zO6U0ER4WNtQRW
 QzFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790543852; x=1791148652; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aMhTNMHCy/W9QF11i6so/5746wOL4VdliI9v6lvtqLo=;
 b=pq7iMiNmmqDgvqQUw5qWWTF3P2G7YZfD6nuP5qmRvC+Mf+JLseJSFEaobitpspsPsk
 VkZsjlEh9u0a2yrgB4Hpqe/+NG1WRL6Ritj8Z9Ed9vYVn5MXt5661VlHnFF578U9DERA
 R8hcTFImfTgCExYfJTZO8I/pgDjEgkd86fjGN2nMYjoen3S6p38qu9f30k+Qt7Wkbu2r
 uSyJYEOXpt1vy+WH2JeCtva4Nczbm/U1K+pwVWYGvU/LAYLRSNl2wGTYm1BzuKnyR2z4
 3mA3SHWuiAyuPq2mSFgYXiDRjAzKwDqsPxzku5Uy5gQmWLIwfhYfeohdjevtTJWLRrBf
 mWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790543852; x=1791148652;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aMhTNMHCy/W9QF11i6so/5746wOL4VdliI9v6lvtqLo=;
 b=czAOA+J1bwaBEOcZLDdKxZb8pPoN0yriIgorpQNI7uyYusBIpjWnEHuwUpZcq7/tik
 djTWlAFnSEGaeUxJ0Q9+umeTXUjUplG9CLwzFIDM3wqiivvj1VyzdPh0l8jrUW0OWIfW
 9Hj+Y3QZ7blR3WJYVTqtUt0NTClgcpTm7fOj9S3YM6DbFOYcfiRzjpHQf10VDoga+/N7
 4wdTJKvTM7dKQokXGY+ZnGO1ioJE8qvhHByctX6hwgY4zHYExNuohA7NHtRyTU+8TMQa
 B+PlKZEztnZQORpkbcrbXeDehOS5jrzDGU2m0PPbNHBijWv4BSHca7Ag/jhdIs6SNn3z
 C2nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR5M0vyUXR3SM4MS2EhdchUl0zWxoqj2llG4m27dnT0vwhmplbjxGf258//xnbVEdncyBs1AINHXA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWsCfYISRoBJsbMdip5hiEFKM6836fZRmEJX/OqcA3ZPg1SaY5
 n7kvXPL1b5u+jpFlYUTl8pW98wQ1jEpIYDofC0TYgkJhHaFlinaktReNJz1q/U8raUHI9BUpiyB
 +txOGVQXSzUlHeaP/I/2MFvjQ7EGgLuU=
X-Gm-Gg: AYBFou1wvqgWgQvBIpyC0MvuICsiB6ytDUEZsKyh1ekg+OQvZJKf8Yr4fPV8JPxE9Pf
 D4sWrDUjY67vf9JjaBR24tKaEnj4tDihLOblL0JDq1iakQg2pWU9rkeiGetogpMvbwofSa/diY8
 uwR6BtI+LWy1hbIq9wBoSC3pt6hlnRHm5uuIEbxTqd1u7lBp3fkbtYJglZZ8iQZsT2bGg4w+tXR
 HQczjMsdMu3nrwXg8uzL5VSi/fMKV6LcKM54nw1lbupm+7RussQkwQsPLXH6mOCSdUSMbQ0pPgg
 QaPwLn+22OSPm/VZ3AXKDKFiZpTF5au5mz1pEJOWe4BK00LzE/2+qsCwSuRN5tssi6KJQ0M+NPP
 itZo48KDFSBzuTd08fbxECjiqGwUKYvXGqxaKPjGy
X-Received: by 2002:a05:620a:26a8:b0:93c:2670:2c28 with SMTP id
 af79cd13be357-93c43c3b302mr1594003485a.10.1790543851808; Sun, 27 Sep 2026
 14:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260821195224.809173-1-alexander.deucher@amd.com>
In-Reply-To: <20260821195224.809173-1-alexander.deucher@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 28 Sep 2026 07:17:20 +1000
X-Gm-Features: AclHuK9j_ZBnHU5bftvT0-bNJR4EDTfTOCkhRiQMtodvJ4ebzPkWhQxMxMAITPU
Message-ID: <CAPM=9tzfOiFBHKRVPjmde0gcFY+C=AQh-+-VvNTb5ZuAhvqG7A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add UALink infrastructure series 2
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Felix.Kuehling@amd.com
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

> https://github.com/ROCm/rocm-systems/blob/35959f8e1260c7cee3e51a740e320be3856ee4ff/projects/rocr-runtime/libhsakmt/src/memory.c#L1036
>
> Alex Deucher (1):
>   Documentation: add initial UALink Documentation
>
> Mukul Joshi (2):
>   drm/gem: Add callback for when handle count goes to 0
>   drm/amdgpu: Add ioctl infra for exporting/importing UALink handles
>
>  Documentation/gpu/amdgpu/index.rst         |  1 +
>  Documentation/gpu/amdgpu/ualink.rst        | 74 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  9 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 44 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  2 +
>  drivers/gpu/drm/drm_gem.c                  |  5 +-
>  include/drm/drm_gem.h                      | 11 ++++

This gem patch is kinda sneaking in here, I'd have preferred to have
more discussion on the list around this sort of addition to the gem
code.

Dave.
