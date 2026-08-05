Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B55BC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5631410EE8F;
	Wed,  5 Aug 2026 13:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oatMD7Wf";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E97710EE72
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 13:39:24 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38cfcb507a3so136566a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 06:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785937163; cv=none;
 d=google.com; s=arc-20260327;
 b=TOjGvtRoBd5G3g378U4bj5bsjIHK4AJB/zd3r+vp5jYIo+Z4TO5oocSrg+che07J9C
 IbDQZj7+jDH8RqmzMHMsTN376s7Cl4viue610FO4JElKpAnzzXULAd4lEHtVLMNKlQ8j
 XP73U785HKQU+drf+fygNukxMvxKepNyOGsTxMpaCqiW+qJ8R+HpQo1HChbv+E1WB4s0
 S4hNkAizTXwmG5ALmGJKrX28zqRP3kGUBLqI47JrDSgua6ZUbh/1GvCWo8YP7eNOCV/w
 lKujPcqOwalGGeFRvmuPkd1bviPNbskPvRMiRWpZYM6eRjqUdoGKsJhMIP1HnB469OcF
 riUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ECIWABTBcOqFonFT5Wh5Ai/7Qs3x8/w4E/9Ac+O/Ce8=;
 fh=6QlDSiDvnIGIco4F6qKGRv56b/9lDlT4W+BXtEf6JJg=;
 b=NNIcxluojyEj1ZGcoXxeHGrl4D4SSL6GobrRanx1LMrB6ZRuJlxEpnmZbQSm3+ege2
 23jAARcD4vOLQv4QgLdjF8OsgWEY8xgOKtKVHhh06gf7yYiFHxnRKJjwJYFUJnRivy4t
 sOYsi5XCbVQTdL88BRwAjILWG2a6D7JORuwnt3vScPdPYhI7UPuDgbtYkeJG8IhEzlwk
 FuSbe3fmhjF+DPUdLPLQN/xLEV2E25jBo8qoGmRvwmOBvltm06c3Y/UeSQbvFUKLaBBm
 IaRqHruG+s+Iztp7/EEbvcoEEQbyG8Zrn+cThQxNIpgoQJ8OF2q2pgdoTQKQv+Fd/OFz
 8hFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785937163; x=1786541963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ECIWABTBcOqFonFT5Wh5Ai/7Qs3x8/w4E/9Ac+O/Ce8=;
 b=oatMD7WfUsMfXlH12sW7Y/VSAI2iOEQk8CEXj38tMicQpHn3FQJwLEQsX0E5m3cbcb
 xxYpOh+JPjWG9wK3OpxjA9IZtqeNe3ObnNPueT3oPgRTzhUrOUUAD/SNeZ5PSdrXoER/
 fcRtsw9xxOFdOsXlsDYt+ZxUnTv6FB7ciLQ38NHOxlaGEa0NFvkd4RZv/XWV68AMY9Uf
 LAYCmLxHKqsukJ7qY3l/gpPSI5Q16xI5NnIRPIS2gnckem4/u2XbjkG9s7BWzR5Evu62
 hey9bFQRMXoVgLj5pZ/MGt2Wn+SYa9pCOAg93LgTTKnh8KVk7F8o6rDNcEdKWfb1nV+g
 RgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785937163; x=1786541963;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ECIWABTBcOqFonFT5Wh5Ai/7Qs3x8/w4E/9Ac+O/Ce8=;
 b=aumcCbzLmTyVVUCVsCU7LoIltaxnv9SMywFl64QYGXEmVzfgpAnRZkhn95N8OIy2rI
 dTySj2mWuaVOttBzAEnW4sCIdhyw/boOfbhLV0eJVscl5nFkCWiIlIwOvm3EaKjJC/AL
 2NgqrVdD4a9tE4ooFDTMG5JaH6Tk0+NokrUKId5EDXq/5xESljYlmXgsnlGkeNZ1MuJd
 xiSGWt8LzWDMzdDPcwDhby/y56vifJUqZpYPuUYsJjHPFs8bycDFAygbJc2dES5UXtir
 G+8gSVqztnfFQvAIJ+bXo5IUxZJLk+ibBnCu8CjkCSQyGj4sq8gBRv2ps1FTqZYi4LEe
 JEgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqu7FWywSSEruRayHXg0pmwAmHQleq9jrJteIhBdyIm7fLwHo1qPWs+zWdCis8drzIPoXbKImoHQJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuazThQ/qP9l7QamxRAiRDUs86BHRiXyrNLuS22uiySEP4itfu
 GYBRacwYsaPyI643+UwayACXz8RBnHu5VaXDHDC7/TXUpbvX2GjQRafHnw0nvyzJ3gMTMojHT5Z
 +UvZSuc+h3GuuVSQYsm+erp7AbeerhcU=
X-Gm-Gg: AR+sD12XRR8qT7pO2t0iaG5pwy2P6li+xVuzZTeqBYbJqEvT6nwrw5JejaUcA55ws/P
 qDA+sVZs/aJmAEnBi8bi2/lbA4PRtPnDqcewGnmJCqb18V7Nh1a1GrH+x1Gg5GJRUKIAR+QMdQ2
 eDOaSlVLG+x10oGod8vgcOfReDPGOz5KGh8pGr40/aligIlsasAItg/sY71WLcBm3ndGqfXKmCS
 6Hhbc91zDlgUbeuZjyan7x+zErzXD5zsNOG/WE06Y+to6iTqu7LMi4xxpKt0voq8ssPBWI2CHeD
 5M9H7N8VoCSUJGTkFzShlfSqCW+hs8OM9go0l6JyBBuM9Xf1RwoUr2IB1eE7KZ9vGSTqkpX89OA
 u3tXw6rba1HyDg72+3V+JA3DQhXRapak=
X-Received: by 2002:a17:90b:3803:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-3903b9c95aamr5354563a91.0.1785937163422; Wed, 05 Aug 2026
 06:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_BB2A7CAE632BA0AC08D9296E78A15786200A@qq.com>
 <baa434d9-e0a9-482d-a071-42d204b82126@amd.com>
In-Reply-To: <baa434d9-e0a9-482d-a071-42d204b82126@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Aug 2026 09:39:11 -0400
X-Gm-Features: AUfX_mwCMrINTWDajJUvcp2l7VES5zI87cc7gtPBOxTJCBpr0mmv9h6RdFUpFMw
Message-ID: <CADnq5_Ny144v_gZZWOpr+YngTEJnyc80q=NVgy=53k1g6rk-Lw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: restore hardware polling in fence_is_signaled
 to fix performance regression
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: 2564278112@qq.com, alexander.deucher@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Wang Jiang <jiangwang@kylinos.cn>, Philipp Stanner <phasta@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
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

Applied.  Thanks!

On Wed, Aug 5, 2026 at 4:53=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 7/29/26 12:26, 2564278112@qq.com wrote:
> > From: Wang Jiang <jiangwang@kylinos.cn>
> >
> > Commit 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in
> > is_signaled, no deadlock") removed the hardware polling from
> > radeon_fence_is_signaled() to fix a self-deadlock caused by
> > wake_up_all(&rdev->fence_queue) being called with the fence queue
> > lock held.
> >
> > However, removing the polling entirely causes significant performance
> > regression (e.g. glxgears FPS drop) because the fence signaled check
> > becomes purely passive =E2=80=94 it only reads the cached last_seq with=
out
> > probing the GPU, so completed GPU work is not detected in time,
> > causing unnecessary CPU stalls in sync-heavy workloads.
> >
> > Fix this by calling radeon_fence_activity() directly instead of
> > radeon_fence_process(). radeon_fence_activity() reads the hardware
> > fence counter and updates last_seq via atomic ops without calling
> > wake_up_all(), thus avoiding the deadlock while restoring timely
> > fence detection.
>
> Yeah I already feared that removing this in commit 9eb00b5f5697b could ca=
use issues.
>
> Adding Philip and Danilo since we recently had a discussion about the nec=
essity of this.
> > Fixes: 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in is_si=
gnaled, no deadlock")
> > Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
>
> As far as I remember the radeon code the solution should work, but I don'=
t have time to double check.
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks,
> Christian.
>
> > ---
> >  drivers/gpu/drm/radeon/radeon_fence.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/ra=
deon/radeon_fence.c
> > index 02a40e4750c7..299865569252 100644
> > --- a/drivers/gpu/drm/radeon/radeon_fence.c
> > +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> > @@ -360,6 +360,13 @@ static bool radeon_fence_is_signaled(struct dma_fe=
nce *f)
> >         if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D seq)
> >                 return true;
> >
> > +       if (down_read_trylock(&rdev->exclusive_lock)) {
> > +               radeon_fence_activity(rdev, ring);
> > +               up_read(&rdev->exclusive_lock);
> > +
> > +               if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D=
 seq)
> > +                       return true;
> > +       }
> >         return false;
> >  }
> >
> > --
> > 2.25.1
> >
>
