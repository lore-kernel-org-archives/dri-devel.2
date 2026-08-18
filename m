Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFD1C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB55F10EC4C;
	Tue, 18 Aug 2026 19:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pFf5caEE";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A861410EC5E
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 19:25:59 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so228936a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 12:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787081158; cv=none;
 d=google.com; s=arc-20260327;
 b=qaqiKIJcs3cr46zKkmsS8DWFgPxs/44H0kTcEbCMWTT70Y4/P1LLgo3rlY881HIeYP
 1jN0DTFVU2+cQSAnfG1dqbt7T2iIhLj7mF+q8c2exgWK/jwCMhTMkdD1qWw0oPfMbqY5
 eeHjUgzEdh4MAmJl+iu4065VzBcivfJQ/yKLkByOZNDXFt6N8wb9NyMrxmHBSB5aexw4
 bT2nTupeO6s6bJfx3VC1Yu+i353bYtW7u82K+nxMC0QAwwSeUgRmuE4p9uJ16h5dJDkJ
 4AhECD378wsiJt0u3957mX5U01cIaXR3J0rCjDTINmP89h9FjUvC0plax+oEx7imGrYt
 6iAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q4R+heqJ1jW1B9R5mRMe5BfQRFgnqTQc8TRqWj0es9U=;
 fh=MvDdi+tB429YX+QpXVYlpmaSP+ZU1x0D6iaOW6ChB1I=;
 b=EDMqwxDcMLmGLGVmYzsTWICFpOpb96w1AnsTfCmPwVjk0MnOqDJo2KkSvfEdDJJUPv
 uTeDcuEOiFGDza6cbpVs9ZWp4xmpSo8uHxWUmoMuferxQ8gFeXMkBJZQC1Wb2dO914dg
 T4ulyHfnwL5bGIIH1S7fC+FA48b6trjizfyFn1+dmXOE4n2/39oE6Z5oI5dil9/9j8Lp
 0I3SnH+va4gzP2cavuH2eU7LKmOofq6MQ8u+wqFITJAA7cX+dimKBFn0USjMYkIwDdEO
 lI9O5u10YABRZDPCfzUoIGAfO/KdUmKZoNF1nllz3dcC27VjhHE8wYHK9P6z/PFj3NA9
 4h+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787081158; x=1787685958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q4R+heqJ1jW1B9R5mRMe5BfQRFgnqTQc8TRqWj0es9U=;
 b=pFf5caEEZ+P1Vapsi0eG7o5NhKNUKJfvVUOopn8F593BW0c7GcKLWo7UxWaSVjjv/E
 UxT5lKlY+tVLMJ74zjN9dvIEQUnImcbmklkJ42kBGvWG8+mn5CvOQa2hWLjEHySCm0xW
 P0f9UjfqE0hh9C+I0ZEzXHTp6SjyC+9QVSRG2SQY5OKvdYYBlhJbKJYZl0chyUxAp0WS
 h8Q2HyH5M/E1jB7nI9uKdRwWB0IY4N8k9jw9qa9E183WouzDALStGSUVkzjbwu52kQ8L
 VWqXASJ0a0+rWSgxrvjIwr/XelKoHiS+BWXTKAC+LNGUSY7YXb8bWj2uMTeefJ449rbN
 NW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081158; x=1787685958;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q4R+heqJ1jW1B9R5mRMe5BfQRFgnqTQc8TRqWj0es9U=;
 b=tHtZNSYTsSjjnZER037xrSveTcPvjEy/eknlEvJC1whfzidf4z8YNWgzJej72mG5vc
 GLAVcIvvdf5rj/2+H8sVu9AqfZIGKw7fEErKv/TeGTIKzSExBmVRUGiSFQ2u7KAaMWXk
 PXjElzpZiAPGVYCk7bkH6sXs/LSdrcxkHYkWjBfFrppmhfxOdmg5OH1OQ3kggoYm/Tkf
 1+ERiAheZOD4jG8OkehNc9wqR7GZ9qRUjX9RnvoEdp7Rw1qxePzrACFKVJ9bdcn494lW
 pfQEkw4vEOmT2Tlgo5+rPMWYyg4DXAaArC5QlTK0fSixUZrHszwNo4F8z0PrMs0nZUGs
 uR+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3uZI8mBpgo8zDYPEPKGHnUwVG770QrJ9KelfzQ3hWEmL3l4/CfPmcGaajU6QMYUFoX2p8Fz8hx/w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweMDSC0Z6oxyLsvbkfJc6v54VmPRV8AVwV/3z4sUt9o/qtVC3i
 9FDhO+btrZKdNdmI0bzSezPHzDtRpHyL74vpZUg/CO4Dzonc0U3MP7U/3tXuaG4jAE9kBxg7lWw
 bC5JFypOAxVnWHUQxuW+pxFCYXWPiLyY=
X-Gm-Gg: AR+sD13Zjf357w4B4m8sFCuN3zOHZDzi12jOK7bSvEam2G6D/2KD8Ext7fJgLpAEiGC
 rN3TvkhiABt9lR/AV3u1sJg2rqMAGUmVjRsdSOHRhpT45N8E335QE03OrEpKpR/xYggsnKp0Fmy
 p4jj6xO7QeWvdail3viCNkF6BL7pMTK8O/MATyvPtwFyq822nLB74criIuyrMhZlvAKTeDf60Rf
 ftnp1M+QNyC0CJwVor1u5zrgUJBSV1fGKWpLJ+gWvMMqi9UEqX5+JKPbq/Xon4cW5zJmwOJmVw6
 5JB3qg+tguGgriNtFxJzjUVcn1RkA8df16V+fLBooQ19X4M8baKWfi37FG+G0A0gy0jyXuITK/c
 EnPPMWFDTTqaKqcY=
X-Received: by 2002:a05:6820:1787:b0:6ae:9e00:c8ef with SMTP id
 006d021491bc7-6b11dd6581emr9168780eaf.14.1787081158039; Tue, 18 Aug 2026
 12:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-5-amit.barzilai22@gmail.com>
 <aoQalR40NMFSg8zS@ashevche-desk.local>
In-Reply-To: <aoQalR40NMFSg8zS@ashevche-desk.local>
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Tue, 18 Aug 2026 22:25:47 +0300
X-Gm-Features: AUfX_mxSHb-78EKn8JdKVlMLMgR765ctFD8-Qvs1aN8nzyH7_8okoURw2uODcNk
Message-ID: <CAOEgbEoMOR+WS7TzY5+k6G464uUdp+rHJqvhY+6gRE8nCaT=gQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] drm/ssd130x: Replace positional ssd130x_spi_id[]
 initialization with C99
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 18, 2026 at 11:41=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> >  static const struct spi_device_id ssd130x_spi_id[] =3D {
> >       /* ssd130x family */
> > +     { .name =3D "sh1106", .driver_data =3D SH1106_ID },
>
> Hmm... Is the comment correct for sh1106?
>
> >       /* ssd132x family */
> >       /* ssd133x family */
>
> Overall, what do these comment bring us? Are those families have somethin=
g in
> common? Because the driver data is unique for each device, so I assume it=
's not
> that compatible inside even the same families.
>
> TL;DR: Perhaps simply drop those comments for once?

Agreed, I'll remove the comments in v5.

--=20
Thanks,
Amit
