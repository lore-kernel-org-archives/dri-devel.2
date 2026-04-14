Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D6DF9D0ED
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC0C10E645;
	Tue, 14 Apr 2026 18:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=darkrefraction-com.20251104.gappssmtp.com header.i=@darkrefraction-com.20251104.gappssmtp.com header.b="SnS0ywoE";
	dkim-atps=neutral
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB5810E652
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:49:05 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-61179fc2242so267473137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776192544; cv=none;
 d=google.com; s=arc-20240605;
 b=OlZ/H9T5WCkVtaT1ZvwKQdx9E3W2G6atVQPzDbc2zaIHYebmYDvz5mMkEX1PQhnxSO
 90SZkjPt/lGLQGbVDoKPWxUS93Pk7tyjZDzynjML9Hh/3KgHtR4lgDLtiQWT5PqgkY1n
 ffM1lMCM0y8DgiLUyTFqLSVyEcfUBPnq0TTQUjr2DeiFuxdNq2IogqFe9KOgge0f2ERX
 Nd3JnhBbBU7917/AtHFZLkwiPnMwJL/Q08T0pCjmKV+oUkzvbUNoyY9Fz36FuHyyHf9l
 eR7y8ZzQ46SeNO3Rjaai66PXof2+bfP1NtSPiYvg3thuxcpYnxI9X+k0uMPUhqRBdOER
 3U5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+Mt12iXkXz5fRqukwoiN5eH3WDU3oeAE0jkk5FyZ9Rw=;
 fh=aGffFHh3OnXoiFPe9iGE0PHfOxP+1kDxiCQbvfpRvkU=;
 b=JfH7Y8EfF0npR/L/c1ohpDdiuLRkzzl7RAan8Gdetg+pA5BPZ87AKA7sCUdZhOqxsa
 VZi8Eng0JHKpqdRT5tmZsqW6c4jgG4QCsQg/xkR7gn4nOkVJoQMFpwSK+RZu/5aq1k/Y
 LZfCx52X8bpI3tVcEQHwXD/xBhczKwHh5yRerjHKm/a/XdxNOeBzsmWbphL+HLlh/0kR
 n/OhkKSyPTllx1W7aRQ+bHZYowdt+90FSgTJKhRvYnnFW+NmLKTwAF+QCt7LJP7irrhp
 7TrC2AJNrYD+AFczXnu+TpfoB4avjwUHpW3gCCauQzyXbcJyrw1B9x3A3h1mcGZ+cDwz
 LNTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darkrefraction-com.20251104.gappssmtp.com; s=20251104; t=1776192544;
 x=1776797344; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Mt12iXkXz5fRqukwoiN5eH3WDU3oeAE0jkk5FyZ9Rw=;
 b=SnS0ywoELJtR9PJ31tCCxoZrpkJ7TJFJ7bEpUrHz/6MiGR29wbk71f5JKTgAJyWNGA
 P9fsTXyAW3QYNhflig2vsHWO6XDX0jwSsV3tbC7yApEQJS6mYTYWFCtsFHJgAzeLd+FB
 ndcUecuxlTJ2/ufiJoJFrKI8BFRmnFJShIBzt8IYe4oE1AzsKA4sk2hPFNFNDtKYef/z
 AOCHc9BuO8bfPoQGPKFUlqyEN1OjKKVZizja5H00mRnT67q8Fcms6yv53reQt/L2Pq2M
 JFPqpl2eR7b2QXCT0gMzHaLTpewPLeykR3QWBB11f3rUcHjigXPNtZbcsACWpKhl9je0
 wCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776192544; x=1776797344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Mt12iXkXz5fRqukwoiN5eH3WDU3oeAE0jkk5FyZ9Rw=;
 b=YSzzlBRnX7u73DALRiej4gM1lm4PhJOCNbEJaDRZ2tf8eCYdEDyBqTEBSLafNJ26Dy
 1bJKxMhGAr0qgORciv1cifdjqYDQ1TC0EFmcKhNQpmmgUEc3X8rDb0RF9m8IhjyIcOcB
 yrIZC9paKAdvhQVdWJl5hj+rkcHmWPmgifgvRT3Ndw43HuwGw8YOXWxcrh714od+Rls9
 //OZcSSCgHoPnWaG/n6+s5x5BSwONutiAe08D8AO1BKdr3Ns+20YNQDWTL7a1MtPiB5n
 9G2vyKq+GDbTYrIQYDxa9dtu/Y+MRzWkE1HakJN/MnTd8PH1AAZ6KnxbmizvVnHDFUAe
 GOeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ83TLGSLJyOh4tXKiSucqDyaaFp6d2gc/Q1HjX/HJhNtcw3mpAKl/IBbosFOETQ2CQD7xwgNhQE/rM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAEN6us4xV6VgvmhtP6QJV28eMPgkEoXwbSWwZFHrSGh6d5PCN
 5JgV9ih0Iif3IYHvx7LKhz03r1W6naM11MA3aiD2x5VdBd2U8zZye2ubhOXkmz7MqK/lnzmJEeb
 yEwuN92bJndLmgTub1t6yxxoEJj2f+btb2sdKc+adUA==
X-Gm-Gg: AeBDieuhGC+AZSP9k1L8/Ze9bNqrGQWvKC9bJuvqIHur4EQqzzcosTzMlBoqWwubfND
 wRnj2IX8TsYfaaq82mnNW2k5wG50W989vhk4Kda6IHk5Qi60Q5MiwYSjMIKDtjcNm2w1CDf8ZYg
 Zuie/PK3X1L9BO4lY/cMQ4JwoWaJ4eveBVc6Yp/a1oR9GAHo+GsbVGFwq548zMPDEEJaBhD6pZB
 qgrSecv6lvRX+i6yL7BQfdvv59cTO0CvXzHALeF/Yda/wwp6h22tK+NYC7xhSRAjsPxQKzS4OiM
 YWF3gl56NlgGKmvrbA==
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id
 ada2fe7eead31-609fe9b0d22mr8588437137.3.1776192544312; Tue, 14 Apr 2026
 11:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260414133734.130115-2-phasta@kernel.org>
 <20260414133734.130115-3-phasta@kernel.org>
In-Reply-To: <20260414133734.130115-3-phasta@kernel.org>
From: M Henning <mhenning@darkrefraction.com>
Date: Tue, 14 Apr 2026 14:48:38 -0400
X-Gm-Features: AQROBzDdgq9-sVUtchx7CDAIP18djW6OsmpTOp9warpredWNoQkjcNtGiRDY_DQ
Message-ID: <CAAgWFh13vpZbLeMMGbvJGRiq0Tb+thP3o_4Osv=621NoCht11A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/nouveau: Fix double call to
 drm_sched_entity_fini()
To: Philipp Stanner <phasta@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Dave Airlie <airlied@redhat.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@kernel.vger.org
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

On Tue, Apr 14, 2026 at 9:38=E2=80=AFAM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> nouveau_abi16_chan_fini() does invoke drm_sched_entity_fini() twice:
> Once directly, and a second time through nouveau_sched_destroy().
>
> That's likely undesired behavior and might be a bug since
> drm_sched_entity_fini() decrements reference counts.
>
> Fix the issue by using the appropriate function,
> drm_sched_entity_flush(), to ensure that the entity becomes idle.

Your commit message says drm_sched_entity_flush but the commit uses
drm_sched_entity_kill.

> Cc: stable@kernel.vger.org
> Fixes: 9a0c32d698c1 ("drm/nouveau: don't fini scheduler if not initialize=
d")
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/no=
uveau/nouveau_abi16.c
> index 7860877d909b..291203121f0c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -176,7 +176,7 @@ nouveau_abi16_chan_fini(struct nouveau_abi16 *abi16,
>
>         /* Cancel all jobs from the entity's queue. */
>         if (chan->sched)
> -               drm_sched_entity_fini(&chan->sched->entity);
> +               drm_sched_entity_kill(&chan->sched->entity);
>
>         if (chan->chan)
>                 nouveau_channel_idle(chan->chan);
> --
> 2.49.0
>
