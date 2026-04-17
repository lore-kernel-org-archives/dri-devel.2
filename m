Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6479FF436A8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C2488CBF;
	Fri, 17 Apr 2026 14:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TKdUM3Z7";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E551488CBF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:05:49 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2e59d6b11e5so31915eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776434749; cv=none;
 d=google.com; s=arc-20240605;
 b=fjk24T909WlfSpSC8vMwzCnA/kkRauc6X5NdDRhWaJP92Q/uekyZu+8dpgZPvRstVU
 OivZia7I1ysoalr6/GYxNyr62PE368mbp0cG2+4wUn7Sbh8IIkdy20qd0bnQAknWz9hL
 rG4DV9aC2kZxVeEpRBSmLd22IJ1chmblEzUSBnB4N4KAGDi8eSmVbvU8LZeqBSphKXOy
 qQXsdWfrfmcOrJ2tYqkYeLq1QZUPAdQewXXxaazk2kFc2yBv+ihSZsTDHn4j3uFbvv/1
 PSzRzJyP/mAOcdUv/Nh6NFmBSFCvxd2pTzBBoXlMMFGOy5NvCLJmPhwZ1voKxNauamdL
 M99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H7S+DeEeooS5wykJOGH/mnHWINMYQqyyV2qSC32frrU=;
 fh=4lPEMVM56OftQj1L6zotPpgEV77wIA6IiNqtw6YncrM=;
 b=Nr/WdL6amv5+KiOVOoi+kVmo8TNn7eV7gB9twWc6S8vQ/Gzxqutpqty6CCRqb3Sbrl
 BVI4TcajrM9QxqNR5ZHPowa3bjjk8TJsD3axXQQq/oHvKK9jZryxtNE+qZ7FN1Q10+dE
 uFw6pklAoF/Z6LlpVj/M5QlxyLH/n35jKBTpMhyfGJ0NcarlzCWxXAV2xyW3VeFeJl+8
 lmR57Vm78l0xarPfharm2OlhT08/3EBAoyoBWlbRLPY4OdfPASgAnVog0v7yMnr6BetA
 A5gH9FSilqkfnTPWPdNI9qixG6mDMjyP8Q+6QZUfi2wMonMBHGHtq2adb66u4SmKjtlw
 zOng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776434749; x=1777039549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7S+DeEeooS5wykJOGH/mnHWINMYQqyyV2qSC32frrU=;
 b=TKdUM3Z7KGZxoUsLcUIrC3E2HCPC8Kn+RD50wVWWBJVFeYE5K0zxmWlNR0Sf3f+nBc
 phMRhMU1+Mhojct9RfhrpKZQ+U/ICPw8qbM/z6YPuHOCtkypvx4gWQqqc8DwrsOqKUCo
 frhjxQ+sbIYMHJdhu9Vp5VtHKj49zRFcU/P0gSJ7hP/0HaqDVaxY5hH4im3BB72eiWzP
 /BuFpRX6ewozCJoHduIJboxDCoJtC7ei+LxLLp/EODBpRLXBZUQJ37AVq3KjU3yjNTgc
 LC9wjet8s8hgsfdZ8ps3DvNMTTHYlcl3cAf1XUoO06/Gnd3piQOnEZJO9fvPuGgocy2W
 /5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776434749; x=1777039549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H7S+DeEeooS5wykJOGH/mnHWINMYQqyyV2qSC32frrU=;
 b=bQ1q1oQY/kz/yqLrLqU+Ex993TRQoWRW0Lm7WpXBKKFAZD9pb4FSiRGxgFEWsCyTX3
 nZcNKK5+tR1hCDvjC+b9vPspA8Q4ExXfJOmzoHXQaovAQGv89pCTroUvxN4dclgTjWw3
 MjniWGFid5KfaP8ogze10b8dTrZgTjcn5EXKc7zydH6w3HsN/+0sVVfjBFiPhdxeASuO
 nui7aVcSig6cOmCXbftiJY/2tcb/yhY3s45H1duGagKUyPnt+VJKTwTRK4SoxQcyTLfW
 7uFP8c2aQVOPoCXpjKjdFF59GIocjJpS43J5FxOimrikvMhD1faABmeQOlEai/SYELKn
 xNjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/M9RH3ySzFdIp7PTCAQvt8u1sZ2nKe9coUGD1Apq6wdp7dga7RzuXmCuvQeTwb11bvVAIQgsKfDUs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPcalbYOOUA2oV4sQ/WJkfxN2l62evwjDuMPIlETy51Jc1Nwnc
 64zgZTcXQEYdlzYVv6daVcYgDrPZuSSuSiPt/PNa+kb00+nLiI/GvWMN8VMSU0jeZrucKty5y75
 9ETpVz7a2HbI4Zj9CC5Nfc0DSlje9jiI=
X-Gm-Gg: AeBDies2JN0zLbPdJcwZ/lqBOh+blUVY8Wsog1Zs2TnLxgVkz+RcqoRGUShdU7bgS8I
 Ew50jqn4GCszXCpsXgDeDjMtayEUhJ3mx9GC6A5r95Mdy9ljYOv4u5m6V1CdWLKSNigGXeLDzu6
 QiRJIhpjcSeGb09gqyX30u8M3kMoQGVBXzLX7CNQD+zlLi82tGUcnw5UHxlZ9YrJReSQwmv5oSa
 ou1M+w5SuJAo/v4pailKcRkit/yca4oak+29nGqrJIQi97ZxHssu2HmqR55P3OCta38imyGH72i
 Aib5YfnvTTWv/zrIzBM5PEt879sAyaqqof0dzrEE3Q3LVhVcGO2SuH3ArgI+p7C3w7AGmP3+cKZ
 Bz+zb
X-Received: by 2002:a05:693c:3011:b0:2c7:2cac:8149 with SMTP id
 5a478bee46e88-2e4871fe6bamr672967eec.7.1776434749018; Fri, 17 Apr 2026
 07:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260416195537.3632-1-dbgh9129@gmail.com>
In-Reply-To: <20260416195537.3632-1-dbgh9129@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 10:05:36 -0400
X-Gm-Features: AQROBzDAAqMZZoPqgJldN_PKeIHlbSL12FRIFysUQMxrUkIadk_kNeR4nycyTco
Message-ID: <CADnq5_NrVgGwAYbBGgGc9t-ke5xt_0iJNExXARb7LxdnHSwDQA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/radeon: fix memory leak in radeon_ring_restore()
 on lock failure
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 17, 2026 at 3:06=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wrot=
e:
>
> radeon_ring_restore() takes ownership of the data buffer allocated by
> radeon_ring_backup(). The caller (radeon_gpu_reset()) only frees it in
> the non-restore branch; in the restore branch it relies on
> radeon_ring_restore() to free it.
>
> If radeon_ring_lock() fails, the function returned early without calling
> kvfree(data), leaking the ring backup buffer on every GPU reset that
> fails at the lock stage. During repeated GPU resets this causes
> cumulative kernel memory exhaustion.
>
> Free data before returning the error.
>
> Fixes: 55d7c22192be ("drm/radeon: implement ring saving on reset v4")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_ring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeo=
n/radeon_ring.c
> index 581ae20c46e4b..a5dff072c1ac0 100644
> --- a/drivers/gpu/drm/radeon/radeon_ring.c
> +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> @@ -356,8 +356,10 @@ int radeon_ring_restore(struct radeon_device *rdev, =
struct radeon_ring *ring,
>
>         /* restore the saved ring content */
>         r =3D radeon_ring_lock(rdev, ring, size);
> -       if (r)
> +       if (r) {
> +               kvfree(data);
>                 return r;
> +       }
>
>         for (i =3D 0; i < size; ++i) {
>                 radeon_ring_write(ring, data[i]);
> --
> 2.50.1 (Apple Git-155)
>
