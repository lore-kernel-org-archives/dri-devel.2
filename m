Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192F6C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B76510F34A;
	Fri, 14 Aug 2026 07:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D1ctloHi";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E952610E530
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:26:31 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-92e6391b114so15324385a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786645591; cv=none;
 d=google.com; s=arc-20260327;
 b=hilrIWQDwqkHRlJr9ms180dGMs+dNUDUmdwjobCJeH3HGuIJAXpVaKAL2swNZ/Jx0T
 2FnDj5RI+Uk39rCbczpOIErZ7DgshP2JvVLYVgGsIdyl+JMAdgQpNKXPKZPABIOEGEbJ
 JqDjg4T4Nslk93gj8qtyoFqaxnBLxqilZntsN6YqTMOrHoXKxIESg9Mbl3AHB8gcsSRL
 6aoG2fZrJnrmyzMvZa5iq6PVBHFLfZWJm88g1icFKOLhvuZpGDqcIBTMvhbiXMm0B1Zb
 ildoqsE8g2pq4sqREaxg3zlDTCSsf+jE0DBvu1l8vN1XX3Vbmk5hP0w385/aH70Xl/j9
 2Yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
 fh=Njo8nWS8hCuI+iarXkD7d2KRkeYrOAcRP9TAGwj4Z2c=;
 b=j29sb+ot9AlP3moYvtK29CpH67oS9SoNlK3J6UPe9277vQYNZcup39j2ZOrVIuUvNl
 FuyZx9jnoPYUs+BjUvlqSNAXFYSP74nyMQvKuRsLxtC4Dyp6ZfiOqZUq7UrNZQ1KEyxr
 TwoBfiSdhNbQBolFqkOhiB19RTbloQ1J+0V74LX2Y+LRlhQgMYhxnSPCxT1jBQtrXWaS
 y1gf0PEMpEMVVQZWQdKJyMAKN4BKAA8Hjvp6R6WiQ6jjOM3vXSW4ZgoRAuQ38oSu1DNh
 4Me0EI1L8+x16ghKEGibeRYiLQaB2FnJdlTrVJ2IJ7eGesFZeDuSQ3u+tKXOraHB6gan
 OqiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786645591; x=1787250391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
 b=D1ctloHiCqwgGMg8qNDWzN3yTksBmE9+/096annf7WKroDbBE2LTyuREJEw/pQ5fR2
 UScQ2pkT7q9Ai19JD29DP56vCGzCwOH2hnEYyLZxK+zQsAnSLm+xrhOLW+iNBE+hqm/q
 F7Q0H57hdkzpkK5RGyAbcSa/9Tt273ySVvk9Quyabqw5bRee1uhzP37E4c4tUcbU1AyN
 pgFL0yN7gdrK1WeLQ55mT9HYnixjkU8Q5Yp3FBZ+6UIOUpEWhSUDTSgXNz5BkG1QbrRa
 eYejouFPKdKi5q02uMWwsFPFQTYuEDjf7fgZCXt0rBvfDRlnZTVJvI8P/HBFFwmJ56PL
 Yv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645591; x=1787250391;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
 b=LY0PNB4PCcBsZ5mmF25ncLEJ4nD8nNIJLD43IR7JRUqxaON6qbW3dfzEtVuyqBp8zQ
 /4SuGH8CYy2QsX5edm6H1ckoYRTZ9cDiXt/Ls5R9LrKbW/IktJrm3M9z7+ykKj/dCYrc
 kHhsQ5Q7nlYCAuoZJlkHbS3SGLSD1WIqeeiaIxK22RwVLvTWV8x2eLmUi5Kvmn5KxtsH
 VgAwLT0skTbLisgrNwiC767hUZCh2eiuhXzH8llgQnEiyYX5fNSJibgqdMOABf9ntdqc
 kk0Ls/EBAfcBMOJvdl+lcgueWNMsLf9Q+sdhedEILW5ff385jiHgpdqxF1AQ10BsFD8W
 Zamw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2ZS7hOa33fEDy4GKcbKXl3nFaQg+iWdJmk/wVIHM8FoleEgBU0VXv8J/IQHBNwkWhzaD4bgrohek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfHtBMXo/ZKlj/kKky3Ud1da63i8OT1UCuTH6N0sa8mRwJfbHh
 ZJjL5HXHGeLuuu40BBLVrfUs8B1gWvs7e0XsKAFi72QDv7pMKB2kydIDK2/QE/12mjcOFUIaAZd
 FYwQUNAqKj72+v67VNaZejDOKAC34pYc=
X-Gm-Gg: AR+sD125MYph+Y2LjHkOvqPUGmuJt2KlXDDCITekVaEjXPY+ma7biSp3zC7/p0UXNoR
 Z1IFD5W28fa4+CgJNlDHQaIW2Fh9TaewUL5/BxSx5eLdDjU5xa5VnKqj0MiMcM+YkwaKAqnOFdk
 T34uZpmtfBxBMRbhe6KP5eId3Gt+GEV8PFa6Kqe+mg0Md30FXAxTHwgrkQZxmrXPfyT8GEWr+rS
 6EelnE8NTO8YQgSFl60XGPbLuLVYJ37vizpiLGgMxqjSvNcdt9JuBRi9G+z6PgpGbcjunanAa+k
 9ezmQRINgNA9q9TBqzXei9CUbYlPQ9+nn4k+tKF5EMoUIW0AuPtdGeGYSLWQq5AWI+tfiTt7y95
 u/Q==
X-Received: by 2002:a05:620a:a40a:10b0:936:b8ea:3366 with SMTP id
 af79cd13be357-936bf853467mr676498585a.4.1786645590872; Thu, 13 Aug 2026
 11:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260813170959.22073-1-zhitaevakh@gmail.com>
 <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
In-Reply-To: <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
From: =?UTF-8?B?0JDRhdC80LXQtCDQltC40YLQsNC10LI=?= <zhitaevakh@gmail.com>
Date: Thu, 13 Aug 2026 23:26:19 +0500
X-Gm-Features: AUfX_mw-38zlBHu8TWWHByMsk7m551ieF-G2AoUNDG7_Z167QTQz5WAyx6YmL4E
Message-ID: <CAGJKGUzjqofpXFQqv=hwg4schv3NaZth9974NLfmwYJLG04C-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from full
 range
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

Yes, this is still needed.

f1b5d8f9cc54 fixes the advertised max_brightness mismatch by restoring
the full userspace range [0..max].

The issue fixed by this patch is different: the custom brightness curve
input is still normalized by (max - min). On panels with a non-zero PWM
minimum, valid userspace requests near the top of the [0..max] range can
therefore produce a curve input above 255.

On my panel, min=3D3084 and max=3D65535. Without this patch, requests above
the upper boundary caused the backlight to drop dark; with this patch,
the full range maps into [0..255] and the issue no longer reproduces.

I also tested with the f1b5d8f9cc54 semantics present, so the regression
is still present without this change.


=D1=87=D1=82, 13 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 22:45, Mar=
io Limonciello <mario.limonciello@amd.com>:
>
>
>
> On 8/13/26 12:09, Akhmed Zhitaev wrote:
> > Custom brightness curves use an 8-bit input signal.  After exporting th=
e
> > full PWM range to userspace, the curve normalizer still divides request=
s
> > by the physical PWM span.  On panels with a nonzero minimum PWM level,
> > this can produce a curve input greater than 255 and send an invalid
> > backlight level to DC.
> >
> > Scale the userspace [0..max] range to the curve's [0..255] range
> > instead.  This retains the full advertised range and keeps the reverse
> > readback conversion unchanged.
> >
> > Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to =
userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 40d82a3ee..533c69f0b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct am=
dgpu_dm_backlight_caps *caps,
> >       return 1;
> >   }
> >
> > -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> > -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> > +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> > +static inline u32 scale_input_to_fw(int max, u64 input)
> >   {
> > -     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - m=
in);
> > +     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
> >   }
> >
> >   /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> > @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struc=
t amdgpu_dm_backlight_caps *cap
> >                                     unsigned int min, unsigned int max,
> >                                     uint32_t *user_brightness)
> >   {
> > -     u32 brightness =3D scale_input_to_fw(min, max, *user_brightness);
> > +     u32 brightness =3D scale_input_to_fw(max, *user_brightness);
> >       u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
> >       int left, right;
> >
>
> Is this still needed with
>
> "drm/amd/display: Fix backlight max_brightness to match exported range"
>
> https://github.com/torvalds/linux/commit/f1b5d8f9cc54ae8a2567ac126867ae48=
8e1bf625
