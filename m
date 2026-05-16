Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E89CD4F3C
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 12:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D916210E49E;
	Sat, 16 May 2026 12:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="srz7iAfx";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C27010E4A4
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 12:08:56 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-6587cee8b57so1170381d50.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 05:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778933335; cv=none;
 d=google.com; s=arc-20240605;
 b=KkMtCMq0RqsjiNBmI1P2BBdRnlSBpMY5zXhwim5Kco1VTiu9xnQc8x3cW6U9oExXBx
 8Y3eCUr8t+r7GkaAXQFud/Z4YVRtwJKaG3LtRK5ujqC/Z9Cp5ToISNRaAP5YucVAyZQF
 d6bRXLvR6kuwSXAdPEn7W5naQ7U3v1JVWsW7svwz0iD/pFZl64e/u3AdOMUZgEV9Y9jp
 UQOhM9IP5UMrNvuGZAwfG6AxptUUc54pVfRpAYiaNVupCA5H8TRp/r1DUh9LB0Ni9HVA
 xGtctiLQXFGZ9CcSB4Z7Qy8Xn0iPkkLwsYwE93QcyQimnN8t4r0tnthjJVlITtI3i0M8
 Oslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pXKN0MkYU+n3rTPZHnEN2kaQtyY3hF+mGwCAYWY3s6g=;
 fh=lZlhriPfQunrNmnBzS0iXhLNva5lFd6VFr2T1CU8Cgs=;
 b=T06sWXzX0OG+rbHEs7O3jrr2MDwSGvsgJROWDrQrS6qGyZr8JyJ84fYt5ph3uSYwmz
 Ry8fRj1+Xnm2AJkMcXA3F1bTX4I2lKahKnHHMxHxsf9Az+TwAU9R1HkySK54LZFvNoCX
 ilNlns7Kln+2O7sxRpJPngUZhPWCZyKSAPuDCn8xcJRYBcLAWzvEuxtBJD0tluZv1hNo
 9Tywmi1Pui+U74KZuS5VX5JfT/RTtBa20nPIJ1KI6hhs2eJesZ/tOrGY6CUwNQst7zpP
 UxoxfBip4zGXL1HJAju4s7jpzBEV5gXZyy0XQrUIWH24uv/+yIJ0GD3wW9dOoR5G6BDL
 ggiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778933335; x=1779538135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXKN0MkYU+n3rTPZHnEN2kaQtyY3hF+mGwCAYWY3s6g=;
 b=srz7iAfxVeGKKmd57ApW8Qi9pbDs2AuaYun5+D+YymHhMi2gWaBW0WiRGop0gKqrOG
 p/Axw5wRJzy8yMreDwJa83iVxdM+/jOCGwuvw1sg7IfIK3cQERSmYBJq9r5DEtB0akj0
 ohlhySDGW8pDnjoK5pIOIajWH556r0540iwh3HkTIPaEIHzLktXln4yAWXtCHKt+1/HL
 0uAPmm1R45+H+rPdqHHWPTHSrhUnSLOHIAgArmHR62Eufk9uqDfUZvdr+6EGpulDanvC
 AFgXM+UwMikht11RYSqj720lGdmIg64VJ+tr8dJkFbtFPI8jaBUHlYWq8LhPedooILIc
 UfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778933335; x=1779538135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pXKN0MkYU+n3rTPZHnEN2kaQtyY3hF+mGwCAYWY3s6g=;
 b=p+orWwoLGDl7R9PnBvdpTalQEEsUXjWypjGjJet9DUwN/pBapbeBn+S6y6uV7ZVwN6
 5CM0ue7qF0rt9N6hv2rd327GpEglX/AgTpd3Xt2Wpwgvhhk8wF7h6Tpz5il58c/ET7vo
 j/4eNNCXZCreGbJuYlqW1z1dPuDN1GwYrLXvR0ym3KpoklzRIl+XPJAyZi13VA/wSl6p
 u+pWha5MdHo5CSY5wyZWFwTCEcsWu5bJlpNpnVPto0usjQf+ye99FI+bleyazr7E2ZjH
 F5ZWauULei1ncIOLU8iXH++wAorw1gdkvdeJMMqbiT+aHSj3DZ37/MuYnI9UvVqogOG3
 BAHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iJgmAufAcrjS17TwyleZu2iDS9e2NzbCgTr/Gl8lgkwNIRRE42M3Jbp1+IIwpNh2pPzUOkwUL9OE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyj253L2JeLWgT1tQ7QmEHVMXJgLn9yhS0tn7VHcJP2gcBsP5F0
 7O52FhdsI2ZmAQLgRwsaH7u+90RyuGUF0eH+2+lIBUp4oGh4ySj0QMjzFuaDyYxxwXfN2nEbTbq
 ralR8fPdKBaomeFvIPb307+B9qMBu7I4=
X-Gm-Gg: Acq92OGlL32UJR6d0v6EkTKQlrPw6psGNLPmYwuuy3VVHk3XOfm+PKKVi5WKcb01Esz
 W/K26DOk85JNsIm7cobvKhljXAVPMaqR/U6YR9pcOXvXkaEPQLI0rKp7sGeOD+oxfNYP8cZwFYv
 L7XKkklplCc8MoJJVD5PIaJKv2IVVMFhocidbuyS6n5x+2v4XeN/lbyp/YXUX4L+GcNLdbkv0ms
 h9m44r5XNeEXZK1rVSVDe+DUJMT0/LDXKgZlqp5+lRhc8FQEMR5/ZlxEpyVzW1VLtWdMzUVb+BM
 LRuzCGpYkixQeSbg5JMFfxoebSha/1sg9oWKpoeLdW9NCiHIaE/hI31dAuQ=
X-Received: by 2002:a53:d015:0:b0:651:c29e:f0b0 with SMTP id
 956f58d0204a3-65e22701655mr7274124d50.4.1778933335045; Sat, 16 May 2026
 05:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <20260516-jorth-syncobj-v1-12-88ede9d98a81@gmail.com>
 <2026051652-pork-omission-b762@gregkh>
In-Reply-To: <2026051652-pork-omission-b762@gregkh>
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 14:08:44 +0200
X-Gm-Features: AVHnY4LliAXwIRGSinLMXXpk0k3pE4bCMnvt3uyz5Wz7sqrJHyVxIP5cb_UqBE8
Message-ID: <CAHijbEU3+3ZoxTuUCkJx=a75_yNxt2Nn3UKU7gbS-Xf1bPqBUg@mail.gmail.com>
Subject: Re: [PATCH 12/12] misc/syncobj: add new device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org
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

On Sat, May 16, 2026 at 1:38=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 16, 2026 at 01:06:15PM +0200, Julian Orth wrote:
> > This device makes the DRM_IOCTL_SYNCOBJ_* ioctls available via a
> > dedicated device. This allows applications to use syncobjs without
> > having to open device nodes in /dev/dri, on systems that don't have any
> > such nodes, or on systems whose devices don't support the
> > DRIVER_SYNCOBJ_TIMELINE feature.
> >
> > Wayland uses syncobjs as its buffer synchronization mechanism. Most
> > compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to perform a pure
> > CPU wait for syncobj point. DRM devices are not involved in this proces=
s
> > except insofar that a DRM device needs to be used to access the ioctl.
> >
> > Similarly, a software-rendered client might perform rendering on a
> > dedicated thread and use the wayland syncobj protocol to submit frames
> > before they finish rendering. Again, this does not involve DRM devices
> > except insofar ... as above.
> >
> > As an added benefit, this device removes the need to translate between
> > file descriptors and handles.
> >
> > Signed-off-by: Julian Orth <ju.orth@gmail.com>
> > ---
> >  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
> >  drivers/misc/Kconfig                               |  10 +
> >  drivers/misc/Makefile                              |   1 +
> >  drivers/misc/syncobj.c                             | 404 +++++++++++++=
++++++++
> >  include/uapi/linux/syncobj.h                       |  75 ++++
> >  5 files changed, 491 insertions(+)
>
> As this is a bunch of user-facing code, why not do this in rust to at
> least get some semblance of proper parsing of user data sanity?  Or is
> the api to the drm layer just to complex for that at the moment?

I didn't consider using rust because I'm not familiar with rust in the kern=
el.

But even if I had considered it, I probably would not have done it
because drm_syncobj currently has no rust bindings. The driver as-is
is just a thin layer around drm_syncobj.c so if drm_syncobj gains rust
bindings it should be easy to convert the driver.

>
> Just curious, not a criticism of this in C at all.
>
> thanks,
>
> greg k-h
