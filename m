Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3539C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C8110E658;
	Wed,  8 Jul 2026 19:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I+cxDI5m";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A63310E658
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 19:30:46 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-6647bc8f900so227611d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 12:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783539045; cv=none;
 d=google.com; s=arc-20260327;
 b=Et/JeR33frZIuU5Tb5DpKy7PobDJGbMcbgXufg1uR2E6LonoheDn0/xWtYwNI9xD0a
 BgU7Ky7TuFmKRXv92WSoqiHE7wBnYVaZV6sYviEan2/J/eZhpuuTXijIFB/KKH4fx3EA
 hiKMHAFXLUKXLlBen9Sogy20LYZoWi8SwW5Ur6M+Wsvy4eTDh51MeYT1BiZUIHDYkFQ6
 qHsXtZHvLPYYAfuChfPEEN58LRoqB1Ol8YVKcGxx7PfgFcDB0j73h8EKZT/8pP1X+obC
 7qV+JNJ5Hdrwth5JZbZxH8CRVHDs54hKyflj3kUEwrcsKvjZFOjJsID8oHxDpfIzK1fy
 iipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gK/BZ0CSIGck6yi9THWfQV8deFFMWvYWLYGtOVRdINE=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=NWcQUEOHiFjeVMnFMTxmqDUbtGh2lzhMraEXpmpnPWGaVt50qOgCF4N2vrrFgxd4tr
 ccxdumxDe+rquqsl9eEd+q71E1udPzyJii428SGsRj9/kYxKZ3RggZjlEgX2LYjsf0Pr
 kSS5A0XJqJoehHIIBSE3maYwjodb7y10l7AoRbzMfZy/Qfil9f2MGC1LJiTvyv+IuQdZ
 7ttn7N4vqoBc6SusgtksV3RB57mcFFz8EPq8I/WO6UFO+XRvI53i1bkhejrMBB/roYDf
 YlluA3Bgk5eb/cYs/YUG5D85gbWFbN4eOGZEM9JFYOTj5RMUMn+OF03isSRe2BWqY3ux
 ai+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783539045; x=1784143845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gK/BZ0CSIGck6yi9THWfQV8deFFMWvYWLYGtOVRdINE=;
 b=I+cxDI5mOVS8NjqqmHPgAbzrx2D58sEEZgCKcWUyplDJzdMD7ihWwbcPmx3hy9NfdV
 kyY+S52r5j7ltUiHkjCQUpIkbL5ArSaFY/yKcq1Dwvyy31U0RhzmFyrV9ea5Oy+kp/zA
 cr/rfXX61C36Eq0Fi036/l/BOwWIIvTqLyr4coqgH11IHcVwksrwTqxpWT+NUyHF2iKQ
 4zqndWb7wvsc+oBBGONq04Ni8Ipo+gajlO6SJGVWJ5+kuQuSzu0urv8rLEYJH2K9ZY6S
 Tk/W9N2/Qxoj6EnCiRv2hQkvpkxmaJbr2Dnnm9K6P7G25Kc4YsuchPDjieZ4wHLjGs+E
 QaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783539045; x=1784143845;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gK/BZ0CSIGck6yi9THWfQV8deFFMWvYWLYGtOVRdINE=;
 b=MPVDe2ANrvLEJc1b78BSOgv4W82BOhwG2CxpYVR5YKNEu9Swfdt1dy7TY7+7e8wyQH
 R+kbfJ2IZ0X6E0Jr685T5rGZRaLAdjZGe/O87Hzu78oJlY5N8/lQxXRaxWRpmq5QxYsg
 89I2ox/h9ZyGVTZs1McirK/Cjvn5lxt69AE6lsLsgdLGT7iATL4RrolETsYD7w/EK9+e
 IrkQwEiX0AmEbd4lyvLjQVnOUPAjTdPW4k/fi6bJATHu5cCQU+jz3xXB+yV/6J0NiT8s
 9P/QCXdgMHikMj6RmwFz03SizUlfg0dVMVoiVMGDHnH8yzYebeICby28pLVJXlfLuPU8
 dpug==
X-Gm-Message-State: AOJu0YxQvv2lqj2IAKsNKk2HhmnhoIbPmjTfgDQFY+8XRA099Ryo1n8i
 zUMxUlbnevRTLz+X7uKwjbn/zagnJj5/XdSqVUaVKaKXCZ08q+ekDoXKcchrKAZBSerPdAnzNS6
 89/y8PxyBtYb2sH2vfwPHdDgbBtPkHAo=
X-Gm-Gg: AfdE7cnj1IVIB7oKWV+GhN0BtPu8m8LFJMEd3MbLlHUZgtCSk8PR6hSPXAL19/GnvYJ
 ynobTfjpkedb0j4/ZDAiRwkXQcx6tF+U+IKa6Sc1YpW4FHXwBN4vT/licZ6MS5N7JOYHWp81clG
 e9IenSKA6GIFJRYtetlCTXRfAwaa1SK38Omh9D69f+9j6SdQm5sm1sbM0pyw1J24/Dq8saXA38c
 HoeGFm7WwjxNNQISNcpqOkmDzeMr/Iw60Tz8EMZ8sJwUyI7ZmCWbIakvTSekpnPjfhETg==
X-Received: by 2002:a53:ac8b:0:b0:660:54e4:5db5 with SMTP id
 956f58d0204a3-6679f1d5e06mr2904765d50.56.1783539045228; Wed, 08 Jul 2026
 12:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-10-381f3edb0045@gmail.com>
 <20260708022424.AC02F1F000E9@smtp.kernel.org>
In-Reply-To: <20260708022424.AC02F1F000E9@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 8 Jul 2026 13:30:18 -0600
X-Gm-Features: AVVi8Cds7DLaQyUd_VIEnr4Erq4jsgRR4iB7pa01JTKxLMrPiWW5nBrfdkHRCNo
Message-ID: <CAJfuBxxi8k25iU-6VKTTMQmMrFCmjhUq8oV5upkvj=yXdJi-zQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
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

On Tue, Jul 7, 2026 at 8:24=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The newly defined macro __DDEBUG_ARRAY_SIZE is unused because the=
 array size calculation is manually open-coded.
> --
>
> --- Patch [10]: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS ---
> commit 0ca0f4a344ab62c4d4df9c27a60daf65fecad136
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: drop NUM_TYPE_ARGS
>
> This commit removes the NUM_TYPE_ARGS macro and replaces it with an array
> size calculation. The commit message mentions adding a new local macro na=
med
> __DDEBUG_ARRAY_SIZE to handle this without causing include conflicts.
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 9607121c3072e..9ae1accb9bf63 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -8,6 +8,8 @@
> >
> >  #include <linux/build_bug.h>
> >
> > +#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > +
>
> [ ... ]
>
> > @@ -122,11 +124,9 @@ struct ddebug_class_param {
> >               .mod_name =3D KBUILD_MODNAME,                            =
 \
> >               .base =3D _base,                                         =
 \
> >               .map_type =3D _maptype,                                  =
 \
> > -             .length =3D NUM_TYPE_ARGS(char*, __VA_ARGS__),           =
 \
> > +             .length =3D (sizeof(_var##_classnames) / sizeof(_var##_cl=
assnames[0])), \
>
> [Severity: Low]
> This isn't a bug, but should this line use the new __DDEBUG_ARRAY_SIZE ma=
cro
> introduced above? The calculation appears to be manually open-coded here,
> leaving the newly defined macro unused.
>

Ack. Fixed locally. Will resend shortly.


> >               .class_names =3D _var##_classnames,                      =
 \
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint=
-2-v6-0-381f3edb0045@gmail.com?part=3D10
