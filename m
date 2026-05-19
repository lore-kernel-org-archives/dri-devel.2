Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C883ECD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357FE10EF1C;
	Wed, 20 May 2026 07:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PgGtu6ud";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B6810EB1A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:24:28 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-79a535e7c00so26260657b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179067; cv=none;
 d=google.com; s=arc-20240605;
 b=AhaVMEhbj3ovLJ/TJiPoUzqe8C5TYj6bxnuNbHl13s3L8T04ohSysMIeuuyP14pqWH
 TNB93vSaQzEUH7DsT0BcS18Uoqqp3mhr9art43lCg+mkyIzyx8eTAV2xEzvCwGNuBFvu
 nEzD6haoDARr47mZobQPhdySvdTOe+I8I5+hk3/OgF4PXMsTiRzMkpwsow4LqGsQPwyw
 7xxqc7IlaRt0mqhzVKhBrtMeaW0CIIcUCpNpYjn/KSVmO5Cdhbu9sAbN09Pxlfbxr49z
 Wx/AcP26rZlGnxfnFWDQQEuYjrKaAQhJUQ8OOckvybE+uUDNSvJNv9GDOMy2DbNklT16
 GGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
 fh=VycCUI8xomjVYKp6NudLM73lsXRooihIIeJ2irL/jjs=;
 b=XS+1c3vJvz8ZthTAvzzCRs0jHGGUCmANtzvNH0YlGJtBE8NVbuabZ+wLqcYkquqF9E
 XanIUwUTbprMWSy9yKC5N38DHtOKkOWT36OdOhvzp723EftEPkW/17/EZ6Jrd09N4eWp
 vSuJDSTcLlKa1bK2TTRz/rMwlGNXtiuvodcOqFSk8DLa0O9Snht7LeGbNohWZNyq+35B
 RNAe7QNsXM/fU5yg8YFpjY65spS6ndCMg2R0xhQQGO6CYbVrMTz4KXn4jMqzvQECSmho
 LtsLpgz6pjMg4EjbtIQZYrK/LEoLNW8StStwrTeG/StVIinqbxNpdcPGfd8UbuxPJtEr
 mmTA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779179067; x=1779783867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
 b=PgGtu6udZY6sIt4M5qKkaIuWIgYDnwvV7siAZ6h+AegVCkrq+hCSBW88XSPcTJpOCE
 rVJv+d7nPI5limhzUYgGISzxivrQAlnlzRBz97UpaCocKBZVBnzCPTiIrackitQAIuUG
 iEoBg1AssOeGtxARqARRa0SqxKDdXrT7uOH2sCqvYz53y4KOF5Jq2F/vc03hvF6YfazZ
 Sd6Sb/aSZpjEX1IJbkNhttMbSvTLjUmD7XpCbjjCBW0vUuYh3CsA6+puVE8oHMqU7Vhi
 uWdZi/9KyQvqKXikUDHevV8Wt27tbqqLyPMHyDf6l7R2hGIi1UVfgu9+6uA00rc4FPZ9
 Xq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779179067; x=1779783867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
 b=E791mPHf1qjW31+zEFvo4wCjLMwCuC++/xaw087vs1dr85jkUNsu8r8qC5kRZpeWp8
 FjyhFh3HG6UcecnVbWEOZJ1HK8g/jn5zScpKoWo3pWlUcMg9cz4Nmonrnok7ZVd+wWnt
 fJ8OR2X9seb5ig+OLt8gUy69C0JMli5x9z3ExC3vlfSC57wQfestPjoGhRsdvu0eKO2t
 aY1freOfSl/aGxeFxZN5JP+kaCZuokN6RyFeUgXIdhfy83nT+ixRmx2dS1VIWdAnzrZZ
 jIE5ZlQqFS/V/j665p6IF+hO6YevbA9/9Q71VBmLyqnypYhGphwtzNw7bUprDK9kMIze
 26sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CN1m5j/0NAfRO4gPplDo39GOJ9KYo6l7NXLnA3pQV/8hnd1lapfE+DW+OcDuXAXBmJWLsKXv60KA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2pkuaVqpto4g67rnk6D2tAylr21M82PAk57XNlyTEiOca3sNV
 peFS8ttDMyuDr30FNUEHfQWZqk57JgQnptic8dd5nXp842uIsvCINjUUnuN90LTNbb+Npi5uM6i
 QaK0m/0onNBrmkG1GLuAHS9ccaHywEqQ=
X-Gm-Gg: Acq92OHhhBikIpNrkOytIGfgQLKqoNyWEVBw0hhTA6SC6p3kuRsCjNU0KVDegQkcvWR
 R0Jn1tWBgklfsLrEHvSfQgk+I3jINawrPY7lWzn2Q1DtWiuF/0wkjuQUq1VM4U47FA/aStI+eb5
 bbnqNNl8086+T2MtqDu1XPgCS/3cQo4bq8qQIpuJ2Me3rHPDq5HIw8PUHWX/Tshm1DVfbgzHHd5
 0sFYD+aA4gS427M6wodRfrQc704iiA+7gSuXvPsFDsnmlmlD8C22bTCDVPN6w+Ev0CeRKnsyvp2
 Ny1AncV+fjpiDlNIr/AUZCr0dKF4NZZOikpXaZcX/6zaKZgptSlWyAcnoP3QQhGsCFWd9w==
X-Received: by 2002:a05:690c:f02:b0:7cf:ab4d:a0e6 with SMTP id
 00721157ae682-7cfab4da692mr7412417b3.19.1779179067451; Tue, 19 May 2026
 01:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260515084030.21986-1-kartikey406@gmail.com>
 <afec1199-4889-4d35-964c-4432ec792fa3@collabora.com>
In-Reply-To: <afec1199-4889-4d35-964c-4432ec792fa3@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 19 May 2026 13:54:12 +0530
X-Gm-Features: AVHnY4It9V2jN-5fjRsBqTKrkzDjZ0cvyy8FQ1o37xh7kT1TdZijJ2KMlBZd7uk
Message-ID: <CADhLXY5Mp3QjKoYHpgdd+mehZnOt2fkhCWNNrjfH1rZsKPjycg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v3] drm/virtio: use uninterruptible
 resv lock for plane updates
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
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

On Sun, May 17, 2026 at 9:44=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 5/15/26 11:40, Deepanshu Kartikey wrote:
> > +int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_objec=
t_array *objs)
> > +{
> > +     unsigned int i;
> > +     int ret =3D 0;
> > +
> > +     if (objs->nents =3D=3D 1) {
> > +             dma_resv_lock(objs->objs[0]->resv, NULL);
> > +     } else {
> > +             ret =3D drm_gem_lock_reservations(objs->objs, objs->nents=
,
> > +                                             &objs->ticket);
>
> drm_gem_lock_reservations() is interruptible. Given that only one BO
> needs to be locked for the fix, make it
> virtio_gpu_lock_one_resv_uninterruptible() and fail with -EINVAL if
> objs->nents > 1
>
> --
> Best regards,
> Dmitry
>

I have sent patch v4.

Thanks

Deepanshu
