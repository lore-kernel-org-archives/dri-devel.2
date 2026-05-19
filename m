Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC457CD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F334B10E5E7;
	Tue, 19 May 2026 13:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HnvybJ6q";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E423A10E21D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:05:14 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7dbd23bc684so1857816a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779195914; cv=none;
 d=google.com; s=arc-20240605;
 b=PFbkPinNQv+Ioxmo17HwJRBKJvXJFexr8yDeeFDz2QSfskhFGxp/xOvug0vHdGfMUo
 VHMehGhBUSp3KTBQ01WEk4e1kXuXw2w+UodMFP556UFxoMIiICY6ajGQ/TKYwj8w/Dyw
 0ozGxnWHC7dY2LtxYA0N2t6pxn9kxYFIsrs2AAwir3xJTuB7qDDNQuVQdbi+GBM9tG/s
 q6vQOn/5veMdqKileocvuwZhAkX8JCY8PzhOxf7wgpWhUDWfnmVBJZLk1k9HxeJQSAhs
 J+cKHOeRnuLgxI3QhCLUApT0iccoTqSR1ptgWMC2XqPrI1WiWTJ6d4Iv27NdhuqFHT0/
 pRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
 fh=DVSWUlXo/RKrWLvZ/jINHpxjQ/xGC4/HAXnEdi24WK0=;
 b=dQpQI+3qdxPrKUtLCmm5RHhJ49KS9qwMOA24otlLSSTzH+rBTqA/PSyQbthGUoEyli
 wXH4fqD3ZYRJ4+BXb21FnAwZdYgrlQykIULAZGc1UB1XamItYXJ73CwWaHD3+NmCI0y1
 rGUbpcBpq2slMLHOlR4rJm3Mdg9GZsKXh+A+9EWWaaiaN+dG6bZwOSHaEiPAJcZDv5M1
 Npk/Ngq03IUZRtIfgWuSuEDAwHfvRI/n6cKOb+7ZtfCPn8ciEs84rc0OhF1IRssSixum
 SS2IpvkPacmcImen0VB8TeizqePmlyejMEjPc1BdZIFs5ugiRPe8Pv5bwEmMDfHIbycL
 ZOCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779195914; x=1779800714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
 b=HnvybJ6qKrrhhmXNYX+M1taD53YhNmhfZsnQ4ewkG7ZqnD8FDKQDFkGbY5PJcfNHQH
 YpEs0SD5d67MYVUaIiYjoCGrPKDzJ8mfTYQej51Cpey6rZ1MbqvHoCNUBRewJgpdXT6o
 MdHpJT092eQ8qIBXoiSixmp56uHGHVPmkWEfuNh485rSWpXuaM1bRYhK35vYKOj6HgrA
 gIDCcP2Imp1gtIOGCUHw77uLyxaOOTUP1qqqyDZa7XJE1vduQfm5wYqAfKPrJb+bX1rS
 Le5ovpMDfn19/qBrx8AnW3jl05C9LBxTeCWozM3cBIM0uCxLPg1pVWtF2qCoZBujtql0
 u9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779195914; x=1779800714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TjyeZ+mSATOr/oLHbZdmIDYIxgcfoHII5fmcydeHYjc=;
 b=soRcEeUeG5CrhD8n+ShdwISg7jdngq2sPV96EhLP+YKi4zdoeY9kjIir+eSeFwvx1W
 wV50T57lIYnfSflOCLeBtsWqz2E+zqtNHe8KdyLP9w3rySEz7Nq1+NJ+BLasF2kkRg9K
 oCmGtLBV0az/MCAMZraIfPTvH0Yn84kFvY/J6W0LNMxTNKhvmUWwvMKRQRlbqq8YmsL0
 gyXxxpM2iXIZ10aYLGX2Xd4CqizC1y5dX7w7ks8yhyb05gvFeW2qWmp1+k+aYxXhaFYQ
 RJzgpg799ua9P4PzRZbBVEoLvQSe+7+tOfmq4t8gZoGAg9KPWKO488ZFrfKtG3bp0J5N
 uyDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/KjtH/HroHBS2YpF6vNZmfiN7KHh0UP/vG6CQn3ZQk++kDhF4+lqnYYFePctkbkNfJ/vfhfCUN3o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyOLOB4VmpxV86i19O9ucFirJeOjmaezYPownu/uguZ5DOYx31
 W6ww5omFOrolaX9Qw2+FGujnS8QHBHpNUPpmETIKMAnTYg5NUizxDcPzufxxyCGeOKMbOL3I8gd
 j1Jt/8RaYrr41IdeRP5D8YjCSHWDZ3zw=
X-Gm-Gg: Acq92OEkxkGt67kKlwq+5MfudREFpfHdIgHMl16XdLOn//VkloJlHp41INKL6BPWDyR
 rlZmooPbmuYHS0xbQTpRokKFvqWKIQboneJDoowpNY0IJiBRhayXplPLcPMDNr0Q1Tu5ZAwdSor
 Tm4hEdOZbFy9Rzu8+btdNBE4duQddd/yeda0SlTQ484n8tPByxDe1gihtM+daCNkSshRXm8IYOI
 S1y31iUI2ei5F8AziqPYawupAVcb6B2v8Ffo02NoqiZTrzBfZEcEk4xb7KVCW6GdsSCL8JsC3w9
 8VWmKtY+Fg==
X-Received: by 2002:a9d:454c:0:b0:7e5:b3f6:c6ad with SMTP id
 46e09a7af769-7e5b3f6dde6mr1978777a34.4.1779195914046; Tue, 19 May 2026
 06:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 May 2026 18:05:00 +0500
X-Gm-Features: AVHnY4KCjg5xnLKDTpF_UzV8orViAi1sRvhjRQeLBblOdok117UByI2OEfFaxHs
Message-ID: <CABXGCsM_YJ+UY86yFJF-jBcbQXRoc0qnSw0saaGWnaSYWG0mmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
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

On Wed, Apr 29, 2026 at 7:37=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> When dumping IB contents from a hung job, amdgpu_devcoredump_format()
> acquires the VM root PD's reservation lock via amdgpu_vm_lock_by_pasid()
> and then, for each IB referenced by the job, calls amdgpu_bo_reserve()
> on the BO that backs the IB.  Both reservations are taken on
> reservation_ww_class_mutex objects but neither uses a ww_acquire_ctx,
> which trips lockdep:
>
>   WARNING: possible recursive locking detected
>   --------------------------------------------
>   kworker/u128:0 is trying to acquire lock:
>   ffff88838b16e1f0 (reservation_ww_class_mutex){+.+.}-{4:4},
>     at: amdgpu_devcoredump_format+0x1594/0x23f0 [amdgpu]
>
>   but task is already holding lock:
>   ffff8882f82681f0 (reservation_ww_class_mutex){+.+.}-{4:4},
>     at: amdgpu_devcoredump_format+0x1594/0x23f0 [amdgpu]
>
>    Possible unsafe locking scenario:
>          CPU0
>          ----
>     lock(reservation_ww_class_mutex);
>     lock(reservation_ww_class_mutex);
>
>    *** DEADLOCK ***
>    May be due to missing lock nesting notation
>
>   Workqueue: events_unbound amdgpu_devcoredump_deferred_work [amdgpu]
>   Call Trace:
>    __ww_mutex_lock.constprop.0
>    ww_mutex_lock
>    amdgpu_bo_reserve
>    amdgpu_devcoredump_format+0x1594 [amdgpu]
>    amdgpu_devcoredump_deferred_work+0xea [amdgpu]
>    process_one_work
>    worker_thread
>    kthread
>

Friendly ping. Pierre-Eric, Christian, Alex =E2=80=94 any thoughts on this =
fix?

Happy to spin a v2 with any review feedback. One thing I'm aware of:
the `Cc: stable@vger.kernel.org # 7.1` tag is probably unnecessary
since the regression only landed in 7.1-rc1 and the fix will reach 7.1
final naturally via drm-fixes; I can drop it in v2 if preferred.

--=20
Best Regards,
Mike Gavrilov.
