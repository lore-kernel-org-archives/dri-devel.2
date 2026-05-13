Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20DDCD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C07F10ED12;
	Wed, 13 May 2026 07:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLEr7WiN";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA7510E285
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 01:55:49 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-7bde9d73678so66996137b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 18:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778637349; cv=none;
 d=google.com; s=arc-20240605;
 b=MclQ0bIPmGKnOV3LDsanTr1iRCptg+vwNOKXgPkbnC2Dk2+qjP1RjnL9cC6sD00vtd
 xDA3eA6IHjZi4CrcyXRAq+rUCZfXuNW6F+rq1PqMANHti2hR1KN3z96SEItb7ebDuFZi
 lrDLvn9aImtejcaL9BR8WI3xmcwa3RseAhwsQp/bFAQH5uS58UOGDrRHS5henkq4urpG
 bIC8QOLH4xZMBCXLAzFU8vgnhAxX+aePhCyMCiqepoKY7Dt3p1rdAgfuox7OB4TRux0P
 6es3RnbPLjUwy3ajE7t4LaJD/xuSGxCwI4lSXKmluzKMEP20hLT04tTXFLg+/7uM6omA
 Z5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
 fh=jztHchaODzDkWELMH3+KjbqjP1HmhzGonid4v2P4QJw=;
 b=haOrxUhX9kujX1E4gd2a9UvawONIduEv0o+BJfm83e7VOFHiSpFauviKO65VEOa/eX
 E2kFqxPWUoNFKsrjOZ6NkUzvqbWo5Iby2YiyxhOp+xdAiLHC4y13Go3f+ALWVrEI/X+/
 nQZMCUrnAJcwCmqMWjxTmLXhiNigH7uD55tQ4+Og+EHQEFkQK9XzN8ZulHWe2LJ8x86Q
 aFWbdO0mB49d4+6yE0yBjfC82Mx41j2cwlkrX+XP67luclqj+hEi4BpdqnDXnCR3PRar
 wDbNgTMQMc2w3EG60WzqYpYdwnt3mE4WHbavmfkjuOAYv9h+7A5ni3nDOSa+Hga2ykyu
 DzlQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778637349; x=1779242149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
 b=NLEr7WiNRd0B9T5f4imq21l654Sl02gKMw62aXyLCLKEokajupb+4tM5RyB1nsb12i
 tw5lVyaWpcDk2VWDrYWAplgF4y3xCJomIpLF4766+qrLJ4LZFx4YYUGdIJVzeWd1lQX0
 1yc1PkTNY465lupV8bpNjkDloL3vMeDncI42Yf012rZD0AlTTb9qz+kOndTiSPGcg2eW
 5Wqgi072jsE1RjZYRwhJDpYK9dGL5xt3J+1OuQkCuDvVfy2xlATZFEXMag99+v9tyE1k
 2e1/8ent1I1fxVt/cR/1cX18y1t76VmXF6KUQrMGwwtlfvSlLn121mVeysmXVCGL87Bc
 NAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778637349; x=1779242149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
 b=qBeWDJO9DKQ1sMsnVHZqvFiyPiAzs2Qkyx2SqgT/BgLdWuC4VOMiuQF5PG7OFJWa9N
 mkCDyA78aHgJUe1WmdqSoBSHHVv2ek2O1beV7D3OWMH0WYS+4nDy/mutGvHkKU1WX3+5
 rMBQ8DxnC+sUxRpMEf/eICOzHjJ7S6yiywKLyf4Q7onI4TMq7zmscXSEUIPcr6Nk+Zrp
 qhh9LHC2JT6PQNfyyxTQcbSJkxstSOU8KXRXunw5vdCeiv9GRfzz0VB0ea+SmAQHZZnR
 5PgV55FdBtPOPtlm2tucBKJMr3KSDLonPNS+Vl4EzPcjgBKUxawgJo/vrQXkuIYvuGLS
 4Pgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TNupI2vAOvlI3rWaQkL9xvLYAGplkk+39Q/i9GWG3i+0fiy/0Z9bZhlJFIVwluS8g+8D11pUItVA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmei/B7x5IssnQr7wqHqJdOp3JF18Yep2Lgu3pizQNyS/ENNmc
 g1Wy/HWg6LDMQ1iZEYxPBMH8d6OjIptdK5v4/oOjikBfj8Ezoxb4GOrSV9mHJZ646vUq8nlTZ8Y
 zphgFxe4+zRTEvbVW3CLwTGCSWWa/hEc=
X-Gm-Gg: Acq92OF4bT4newH4vTKi2gP5/WxsoRHhbDx+azuoEx6LwkTHlkisO2+0bpJnvWeI6rR
 Jjfk898AEtpITmIbvQ/8LkkeX3y/YDg6q98xM6jP8yPHbuxavaw+nkopHOfvhuE6+d6YHU37nQb
 24TxIA/GFLDotEeuthU3lsacftgEyrDYyWMm0EAe0NXw2RHFv97WHeVUnYWRYNsF2BX38+QWQkl
 zVGUiFqwsm8MZtK3XjGli+aQFdxsTUp9n4CAfrQFjdifbijZvaXNCOsq0fhgl3BRRxXV98YtIg+
 Cd+1JDlDNJ1ckN0Ul1ZH66pFaVR1FRJKidqkOI4pY50z6KZ3Tj1RR7lcfPWlJzD//Ce0hf2G
X-Received: by 2002:a05:690c:e28d:20b0:7ba:ded4:df69 with SMTP id
 00721157ae682-7c6985e165dmr12151727b3.1.1778637348672; Tue, 12 May 2026
 18:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260512020718.108044-1-kartikey406@gmail.com>
 <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
In-Reply-To: <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 13 May 2026 07:25:36 +0530
X-Gm-Features: AVHnY4LCDlccPve3ZLzzDvN9woFw3uS561jxG504DrY4p0Whnei59B3Wu16XydA
Message-ID: <CADhLXY7N0eLpA30eV4Rb=F4vzCf9XYtDjMpxBSJtGeMWNi6Cwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: move cursor resv lock acquisition to
 prepare_fb
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

On Tue, May 12, 2026 at 12:04=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> I'm getting lockup with this patch applied and now see that
> virtio_gpu_resource_flush() also locks BO.
>
> Easiest option might be to add uninterruptible variant of
> virtio_gpu_array_lock_resv(). Could you please try it for v3?
>
> --
> Best regards,
> Dmitry

Hi Dmitry,

Thanks for testing and catching the lockup. Before I send v3, want
to confirm the approach:

  1. Revert v2's prepare_fb / cleanup_fb / plane_state changes;
     keep the lock acquisition inside cursor_plane_update like
     the original code.

  2. Add virtio_gpu_array_lock_resv_uninterruptible() in
     virtgpu_gem.c, mirroring the existing helper but using
     dma_resv_lock() instead of dma_resv_lock_interruptible() on
     the nents=3D=3D1 path. Declare it in virtgpu_drv.h.

  3. In cursor_plane_update, call the new helper and check its
     return. The signal path is closed; -ENOMEM from
     dma_resv_reserve_fences() remains and is handled by freeing
     objs and skipping the cursor update for that frame.

A skipped cursor frame on ENOMEM is the remaining failure mode in
.atomic_update; this avoids the lockup with virtio_gpu_resource_flush()
that v2's broader lock scope caused.

Does that match what you had in mind?

Thanks,
Deepanshu
