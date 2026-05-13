Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178EACD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 19:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722DC10F027;
	Wed, 13 May 2026 19:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fiG8rgXh";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0058710F027
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 19:31:44 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-651bc83e74aso8075249d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 12:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778700704; cv=none;
 d=google.com; s=arc-20240605;
 b=O5tA3TRsJK0wzBpGtwEPrp/G9c5+1kd6lP13lG6/s0rISL1LX5e1uekVQXiVot1Kod
 pFfYrCbQqU6U490K7BaFlQ2DgPdRmwgrUiXih1mGMHWz8BSgs63K42q3wRAm6TwaoKtw
 0FphbSEY2ljbpK/24RVL+UVs3xeU6xWsetLzzinXpl3IYnWsn70hqR0obWx8AVysCcCt
 vbGNj8uP5CIqfLUjfvylvziKHg4/jUn3vXwIwXpGy2hE2VHnc+zIS+w+DDuyxZd9/JjM
 ZzIZO+OS1A+ZdYUnYvIgsdXtPXAxNaG7+XGJMTxwV1t/7GJ25pnITPZ5CrliepGkYOKI
 P75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g4Y3i2VzEUpUrHnVXfd2puXKp9894xeLrJot7HkksF4=;
 fh=l7GAbvihEG92WnXlL+cpE+zdE50gQe2NZMT9MDxaohI=;
 b=Pf29SPABCDT2+WM69IQbiJPeqwvdHv3NVJLKd+XOjtkNnxRp3qA1A5Wfd+q+ScsoPg
 YTF1gxNy+tYR+IMxCAuDi3BnjflElcbiab86xP99hLafmRCbW/Mv2jINlgxFRFX0zhZ7
 mJktD7kQVIeKZ/+arhH3vp2LwJ+HpapbWnuLpRC/9V5NElrEjzvAHQal+27oFy7g9Rez
 50CINqkXrT8sZvnBLjRWMi2dcI1d7D/fNl4Ma8x10KzlskpWgnT9OqyBfSdH/e6HHNo1
 dRSJSGqh3WCccFGDWScSw7+x5HId9q0dmlhCkHDPim/+AJlS+kCONdJ6C0z31WLuYIb/
 GIBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778700704; x=1779305504; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4Y3i2VzEUpUrHnVXfd2puXKp9894xeLrJot7HkksF4=;
 b=fiG8rgXhRfjKRxslioLMOzQ0LmUpPY2wZnhBITQpdM7Ir4/DNeFV0TF3EgbgkvktfZ
 NmE00KuJyE7XT3loAdYaktEgawz+VJNsdhGKX187LvYMeIC+AU9rfdPCafDwJLN4QnxV
 6eh86pk0DxiZ33I/S2FFyHh4GTUdsVMvCX/H++ZVX/tB0QOrQ/SoE+8l4rashoVLr0wk
 HUnICWP14AI6GvwtV8WTlLyAeUblbxQUAzry5b2kXHrpnaOpOEqKhJ3gXx+9Osk4oq5h
 alzF2Pfrw4/7KPO1Qlr44VMDSyRLii2f1KCnLCMq3KfnAHqu5UO4fknf6NUeeegaGKVd
 v09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778700704; x=1779305504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g4Y3i2VzEUpUrHnVXfd2puXKp9894xeLrJot7HkksF4=;
 b=RtTtqWC6rbOQKUaLnbd3PgIGJfFrn9HoqobemJ6jgTqRB5xEFBnDfOCQWDVZ42u6IT
 Zr0/hrMjzlLUbu/2pOXNkhD/x1C6EG4gtWrUBrCd23JHcLLXH5Kq8t0QCaU0Etvw6OWp
 zq0+/Q/F9VaO4Fr1gzJgARxiR5KRSe389HfLiAkFksaUFV3m3bZrcL21L1hyiMCV25uj
 RvaZ/eQMq9Kmf+JzuPibfLY4qBGfFKF1FwROY+8IYPRXDDMyVVW8d5w2kFJWkUfsvE8K
 Jsdu0UniWn6/EWLdlA+C/ypg8pb8d/ug74OdToYZOszom+FHREc1C40Guv0E2QVu16ss
 JkBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WxK1eTkAMz0ZTZrw3EvFaFSwTS/yqHso/pAnhwhdebYXV8+75PhXtr9YspzAmrqbIrXoqdH7UDjE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPVuletfqpw4xOzEmqmYUswqU9xhBFURLVtDStFbqq0kUCvLHQ
 InhucK1Cra4fltKpTcmEPOfsVc0fJX6qkxYGqEHfmhM9/RxMVHmBtG2w3MAIeKWRGhy6j1OetcG
 GHVCcZjad8L/a32N5I+fLHvC2sMWJfMg=
X-Gm-Gg: Acq92OHhpbiShYrH8OnEXZ8SekOoEVmKwcNsnm8I1x7czZiBX2eAK8zqIVfuhYwVAR3
 OqlypLDuNJ7MORa08vz5jevcXUf6o9pSOFfxFWNlZlURGQxZ+aVI0lJErqUXYyIaX75H0MSjb/+
 FE8FIDgaKQNLNivVF+I4emdSYwOVlocQf859XQZm1ABM+WSujmlVm4hKSFNIeNuA/kv30TJMcv3
 uqKhVKH8vb3lRxVtANZoLmGJk4XLWsSLxtwsUW+b2vDleiaff3Zq0rlXcxf4ntG268PfDoOfWDo
 vE2Z3N6ZGvKk8z4VdlEq4ODeAoJJDlim11cOZeiYS0PIKVOSIXRvCg06godVvD/NCZKhCMu2Fw=
 =
X-Received: by 2002:a05:690c:38b:b0:7bd:a50c:454c with SMTP id
 00721157ae682-7c6da2152a8mr42579647b3.19.1778700703738; Wed, 13 May 2026
 12:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260505181523.49a3d85c@fedora>
 <afxVIuVVPisBQ9p_@e129842.arm.com> <20260507135356.5428d50d@fedora>
 <agMvb_jeRsO7tSS-@e142607> <20260512161111.0cb7000e@fedora>
 <agNJasayW8VCHTiU@e142607>
In-Reply-To: <agNJasayW8VCHTiU@e142607>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 13 May 2026 12:31:32 -0700
X-Gm-Features: AVHnY4JH8Ip_tVhSu6utyw5cZH7Mreif1YmCt2t2xjBKPcGuoTWdGxm_i0T-RLg
Message-ID: <CAPaKu7QC7FdjL6m_OSb+E5aYKs6bmT-9DAHc5PC=XctCmRph2Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@arm.com>, 
 Ketil Johnsen <ketil.johnsen@arm.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Florent Tomasin <florent.tomasin@arm.com>, nd@arm.com
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

On Tue, May 12, 2026 at 8:39=E2=80=AFAM Liviu Dudau <liviu.dudau@arm.com> w=
rote:
>
> On Tue, May 12, 2026 at 04:11:11PM +0200, Boris Brezillon wrote:
> > On Tue, 12 May 2026 14:47:27 +0100
> > Liviu Dudau <liviu.dudau@arm.com> wrote:
> >
> > > On Thu, May 07, 2026 at 01:53:56PM +0200, Boris Brezillon wrote:
> > > > On Thu, 7 May 2026 11:02:26 +0200
> > > > Marcin =C5=9Alusarz <marcin.slusarz@arm.com> wrote:
> > > >
> > > > > On Tue, May 05, 2026 at 06:15:23PM +0200, Boris Brezillon wrote:
> > > > > > > @@ -277,9 +286,21 @@ int panthor_device_init(struct panthor_d=
evice *ptdev)
> > > > > > >                     return ret;
> > > > > > >     }
> > > > > > >
> > > > > > > +   /* If a protected heap name is specified but not found, d=
efer the probe until created */
> > > > > > > +   if (protected_heap_name && strlen(protected_heap_name)) {
> > > > > >
> > > > > > Do we really need this strlen() > 0? Won't dma_heap_find() fail=
 is the
> > > > > > name is "" already?
> > > > >
> > > > > If dma_heap_find() will fail, then the whole probe with fail too.
> > > > > This check prevents that.
> > > >
> > > > Yeah, that's also a questionable design choice. I mean, we can
> > > > currently probe and boot the FW even though we never setup the
> > > > protected FW sections, so why should we defer the probe here? Can't=
 we
> > > > just retry the next time a group with the protected bit is created =
and
> > > > fail if we can find a protected heap?
> > >
> > > The problem we have with the current firmware is that it does a numbe=
r of setup steps at "boot"
> > > time only. One of the steps is preparing its internal structures for =
when it enters protected
> > > mode and it stores them in the buffer passed in at firmware loading. =
We cannot later run the
> > > process when we have a group with protected mode set.
> >
> > No, but we can force a full/slow reset and have that thing
> > re-initialized, can't we? I mean, that's basically what we do when a
> > fast reset fails: we re-initialize all the sections and reset again, at
> > which point the FW should start from a fresh state, and be able to
> > properly initialize the protected-related stuff if protected sections
> > are populated. Am I missing something?
>
> Right, we can do that. For some reason I keep associating the reset with =
the
> error handling and not with "normal" operations.
I kind of hope we end up with either

 - panthor knows the exact heap to use and fails with EPROBE_DEFER if
the heap is missing, or
 - panthor gets a dma-buf from userspace and does the full reset
   - userspace also needs to provide a dma-buf for each protected
group for the suspend buffer

than something in-between. The latter is more ad-hoc and basically
kicks the issue to the userspace.

For the former, expressing the relation in DT seems to be the best,
but only if possible :-). Otherwise, a kconfig option (instead of
module param) should be easier to work with.

Looking at the userspace implementation, can we also have an panthor
ioctl to return the heap to userspace? A dma-heap ioctl to query the
heap size is also lacking.


>
> Best regards,
> Liviu
>
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF
>
