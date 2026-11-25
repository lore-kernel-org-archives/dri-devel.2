Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE4606A333
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AeyEbC8C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3133910FCA0;
	Wed, 25 Nov 2026 14:09:11 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBF710FCAB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:09:05 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-8b335eeb340so50905717b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:09:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795615744; cv=none;
 d=google.com; s=arc-20260327;
 b=UvHUw+GJTs8KZiHFkVN9iJHVajzOk33t5mEYn16p8sBhYgYUDhU/SQ/WuqNOaqMNbc
 DK2ui1KMpaith600pJbvBornWhLgRifMz2mcIhB/h4lVyd6zmfop71PBMPXfSM1RMWVp
 212hrS3QUEVNp28y80cvlVgjwPoo9lkwAsEWNRKy/JFhR5pqwZqiVsHhWoX1dXijvDch
 wRjFIbGBrWZ0VPfM7C4qqxR1i+lLyfY6EEWgdRcEuqCTYS03U7Akt0Y7cOq9eraWsmez
 dvTY/P0WMPstAnGqu7bO2rylL/8EU/8hGgrsXX/e8tR7tj4F+kVy++k8Q1GMMQqKJTtU
 1EjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iLkwGEgoZKDBRJGRawfRikHKQChVaEK1bu7vklD9lCY=;
 fh=RkpeMSyduy68F/4m0zAcZRpBAEQ3XePY/BJCAe8BnFg=;
 b=hhA71cJ6iw4Rm3sogBnP6lJrpVXQkQyBuekdPFfxDwnwHY8LmlRvKhRF2XaaGxcFc7
 Oyh6qkCxC3LciWSB2JBclZOQINmmpwDq/i5A9Qxn3mgpZqGsLZ9CCSkfWPPRkA9POTOa
 6yYb8i52gYLOXcj0BvlFohnIqZUUqjG+RR7/tZbyHoA6/wvRG/YMzJyd8Rd3Gpmo0ZWj
 PJQ/VVDT12iBegkT7JwBp9i6o1VyAtZR10EhVKxrOkGY+PWzHSoq+tAqBqTpwYbH/CI8
 DNKhwR4Essum/Yo9hNLHJNPh8BEhCMjUH21Auy5EFpJ62r6uX01sxiP6YYMeGwgTwhqz
 KFjg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795615744; x=1796220544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iLkwGEgoZKDBRJGRawfRikHKQChVaEK1bu7vklD9lCY=;
 b=AeyEbC8CX9d/P0aEK6TkqDJ8v4j6a7F569InA36E/jpsv3QY5N1jZ0sr2xd9IOhNQk
 v8IrQk+8uqqBcj5+IDBiVz0vTKXJm3kzzorG6Qa/P7uZYoQqtxrIfp+pI3GYEqPQeP44
 9oKXtQ9zt0o9yuVVM3mu9gN0dNBkeFclin6+nhq3Y5Yg3txzD5wwoOayU7DVeKf3Fz0X
 DHchzfvaF3igMMuSATYt13zKxoyox0EEHtM/+du9ACqJPjHR2GzWd0C9Mnl9AvO2srmE
 w5mRoU0sqoqqSUQhIqLbn40ferHGDwUJlVS29d40EsQ9ciwtxHl82cyegqaete5dnFl0
 BpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795615744; x=1796220544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iLkwGEgoZKDBRJGRawfRikHKQChVaEK1bu7vklD9lCY=;
 b=fxu3kbWGeOuj1Zn71cCWpgrYo8iUpCVFuXgr5Rt590TP4i1Q5i9K/DLeHhscK78Ppx
 ONOA2dOvLydUjD2l+GXJnPORA1wtu+oCw6LJJGhv04vlBWbR0Pt7NuQ50loTsaAg7V6k
 89EZDIRxz8cTq0PMkSAcDk6GHWd+X9a8phR+Duo6U1k7NJ/sYsmNoYfSgqn7dOgdHrQg
 2EHa4hxDKemHSYN5cIFL+gSBB0xdxzwPWe71BAY5FumlJaMmPfSMjZ2qd0Cah6rjR2T9
 vv91YlXvfV7t5rrAAJ9XSGcrM9KSDaj6EVZuXLj/AfvxWVVAO8IMr11pr5s7QofK3wbT
 BdcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEXbNcMRVPrS0WE7il9rnJA+t5CULBjAPUmorPBgDpujSnrupS8Baa0lEYEScQP/LOunsJi7vna8p8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ROw5d80sDyjmOiO41QcRvr5faEwymG9rYvkN46tYVN0QQ83CW
 TFP6NYv+SHGQQwLPxToq6G534jMUAL/YiWSZeQ8P7sZ3fEOeZ7/ObL+jvGreJjLphXksThMnd61
 egKotFgcGwYOsVH5rCn6H1307Vpg0iMo=
X-Gm-Gg: AZFdTZeDfKYJbEajeBqtSd9kF8AJO+IzcUpdhwAQpnfS1nUZDIc8QhL5tQGFinI7ufN
 8b5s7FJGA2j3aFb5bcm1GYwLBRHxzI7PV6UoHPFMzRD5lS+0QUIBIwWnyMux/1c9eZWM29e6wUa
 /RckFUm+EWwEujwpGIDK/LwoH/S5ZpZ9iBEZi0eF+hzXVeiV2Hs7QmjKjK5nkIIsgX7ejD7mr/t
 F/ZG0JeVbrvAFpSPYJ8g+i47q9EkW0Jv0PDF/leqU6doRm5EW88tUEmL0QzrOOiZ6+MxSo2aLM8
 yUDudG/oSZi1L699UOSx5qH4VFrVuiZxHHxOj559KweBHC1yZHsvJt58hsHci+IbgC1ouvI6wPh
 FQDXgXb/lom1FBVmvLV1u4eZ/9tjloToKFkBXziQ=
X-Received: by 2002:a05:690c:29b:b0:8b4:d882:4a1c with SMTP id
 00721157ae682-8b5204619cfmr60963077b3.40.1795615743848; Wed, 25 Nov 2026
 06:09:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-pvr-gem-drop-zeroing-v1-1-2dc725857053@baylibre.com>
 <CAKbEznssOrO84z_msOZ0tYjVYkaQ8P+f8uma3PhOF6+zp32Hvw@mail.gmail.com>
 <5278036d-c939-4726-a591-91c7dbedd431@baylibre.com>
In-Reply-To: <5278036d-c939-4726-a591-91c7dbedd431@baylibre.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Wed, 25 Nov 2026 23:08:52 +0900
X-Gm-Features: Aa3M54qOr79PeiutPSDb1eipCMvAo_wgF6iTGw-vGiWO2UW3uE7iANiunQsQyms
Message-ID: <CAKbEznuzRy_sUeqyVoe54QGcvQbcs2cSFXkXE5F6Bb_=3fLeBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/imagination: drop redundant zeroing of new GEM objects
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Guillaume,

On Mon, Nov 23, 2026 at 10:55=E2=80=AFPM Guillaume La Roque
<glaroque@baylibre.com> wrote:

> > I'm not very familiar with shmem, so I'd like to ask: is this zeroing
> > something shmem guarantees, or just a current implementation detail?
>  From what I see in the code, it is guaranteed by shmem, not just an
> implementation detail. The zeroing is done in shmem_get_folio_gfp():
>
>            if (sgp !=3D SGP_WRITE && !folio_test_uptodate(folio)) {
>                    long i, n =3D folio_nr_pages(folio);
>
>                    for (i =3D 0; i < n; i++)
>                            clear_highpage(folio_page(folio, i));
>                    flush_dcache_folio(folio);
>                    folio_mark_uptodate(folio);
>            }
>
> pvr objects get their pages through drm_gem_shmem_get_pages_sgt() ->
> drm_gem_get_pages() -> shmem_read_folio_gfp(), which uses SGP_CACHE.
> Each object is a new shmem file, so all its folios are newly allocated
> and not uptodate, and they are always cleared here.
>
> panfrost and panthor already rely on this too, they never clear new
> objects. There is even a comment about it in should_map_wc() in both
> drivers:
>
>      /* We can't do uncached mappings if the device is coherent,
>      * because the zeroing done by the shmem layer at page allocation
>      * time happens on a cached mapping which isn't CPU-flushed ...
>
> For pvr there is no problem with that: coherent devices always get
> PVR_BO_CPU_CACHED, and on non-coherent ones the zeroes are flushed by
> dma_map_sgtable() and by the dma_sync_sgtable_for_device() already done
> in pvr_gem_object_create().

Thanks, that makes sense. Following the path through shmem was useful
for me as well.

> > Since the driver would now rely on it, could you spell out in the
> > commit message where the zeroing happens and why it can be relied on?
> >
> i will add these detail in commit message in v2 if it look ok for you.

Yes, please add it to the commit message in v2. Otherwise LGTM.

I also tested it on a BeagleY-AI (J722S, BXS-4-64): vkcube runs without iss=
ues.

Tested-by: Gyeyoung Baek <gye976@gmail.com>
Reviewed-by: Gyeyoung Baek <gye976@gmail.com>

--=20
Thanks,
Gyeyoung
