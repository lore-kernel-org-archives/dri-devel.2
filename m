Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9D4C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC53B10E26A;
	Fri, 21 Aug 2026 07:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QvrVdRkz";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FD010E23A
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 01:45:15 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-66c70d73210so582742d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787276714; cv=none;
 d=google.com; s=arc-20260327;
 b=BR27N/fGZOMyozLmZHGW+DDLaxsuaXxiHsbpld34BBcRjWvwvUmjj4ktrJqNcgUf8L
 NlJQAzz5qk4cfuJsF8gYteRnCDm3ScJiAWX3Nb/p6GLznyeV7oahHo59Jdd3hLIAdvGh
 UJ66elZDlIylfxz+qeut7MHfi4FDOSsQPaJCjqQYh1HzfHAt9kMU9ddrNzyzC75Z7RSU
 9QIPcfmjOAAW8/xeT8p7v1Y1M1bL8VTKi/BkM5w5og6CWEIL2arAVcOylfwPiJTtA4WZ
 6t1o9oiY08Hghi1o4wqTaSLzYdYRWNrHJ3o9fXu2seKHh3f1Q+n/zvU9wxKqQJWRXFhM
 Fq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
 fh=VG/Ixi9V08q1LH3EO2jxAfX/t/W7KqxMC0yf92YvUeM=;
 b=qmuAPpM/RJR7zeb0x/qQZ/EZTBFoPIm3FX9QNWLanQWyEy+f5EJO2hDDBqarjA2KcM
 qnv7A6Z7iiVFhNFX69wQW5aFRngOCzOURMTx13r2SgNAm6mzimQG3owz/dhCpkAmxun6
 5pN8Z1O4DOSQt+Yq8taFEcSQ2wKqJLWRDaay2zHUmF2KTVM0Funp91I6eS/ayXiNAyMt
 8cBSSxeFUw1WpE7nbnjwffI9OPOkzfkchZ2ySNiJP9zEH3sHJWhKzGDUP6ZfYD02JOgJ
 7A6oGnNAWfS4Xw6sWja+Iu3l6Wi9EWRl3Z8U69EkxLBOX0hcWa9BiUc1rBIrCLzggG5H
 IAdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787276714; x=1787881514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
 b=QvrVdRkz5IcIeNlhXpt0PytbkjgOiJZSHNLj7uzuPn1qJiP0OQuISuTF0k2ZNcUDhl
 Z4Ty5DA9wmtpXARTJsI17y6p3qQEPvfFfyzRg1vqUZTVJ0nHt8AvGJDi42x1BLCIUF3/
 PavnF7qaTq4BI5N2/PDMAtB/3A+N8EzGgQyn88UUNEJ84uNP8inP+8Q9NvxsHfch1Vbd
 4CrKCCrreUVZmCtmh2whYPiX6LxthrEzowRFOq/McdZk4JYtuKqviDiX0DWagxK8VSF/
 T4hurJptyj33iuB9pNZVK+MTQgYBj8CTsL9YZ07Gi1bxlrqiowtDIkUJiLP2KW4M27Jp
 +m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787276714; x=1787881514;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
 b=qRPME8qHoH0Dmd+1W7QpvYfrkfx3/cz8OGOpccmK0Fy1tQEEFstMd0ll0kQHtJp9f9
 zQXAWd6xuok4q1/VgoAZh8c3bZlsdyaVbrvUB5DzA6lt0OTACX6nt8jcDTWoUg4QaXVu
 Xsb9PCloqo5hsjdpezSGXBlGuyGc/6x0V9jKahj3VxPPXcXmUXCZn1kbnbOnfCYT5Vr9
 7tT/2jHZMrYVM9ToijQ1cTkKGcOk+tNGuX/ucdfdFZWAkjbt3d7YlSaOXw5WCw/Q8xZ9
 isuILHotp8r3/SNqo5bABGXJfFooseclYxFr3TjFIbJNaBcfC3oLmeuo2jL6JeOIUxuA
 k7/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMjKiXIKD93YBA/GoKrXcT2RgXdM64TtjrwRYVfpWOeI9Dm4cZfkM/riJKkfbVEpFXX+DSMVYGDGI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lLIPkIaKpwyYfXd9gi12bwfpkxThsXTtNmwNRN3LvzV+uVOt9n
 jPcwAqOqHhFvFPnPnV4Ep00gkXJRvLb3Eh85jxXN1om1znDRDSJ1XKsvdIxJv1WVk7IDRHm+oNx
 weQhNQq8mo/FQkNKMGg3eHkY6yNlkkLQ=
X-Gm-Gg: AR+sD1254QAPydOyWQiImjXIPqMnuMsC6MZKmUcfpPGThH3KrquLmKTjHPRJV0uAhOL
 sxb3pGT/71W6YyZcZx0tieBFR0unqUxnTqgNxfB4xq0h/3shaz//FRhTDaV+L/rxdERdPSsIxbO
 EYvie6fXdOYXVhAVDp1aNxGVHQfm3NFj7NaUoX8nk1x/lZrp1dapgVdpAYd6YFatDw8jYlgDIz8
 99pho4j7yjKNmkbx4WQ5gIzdiXfqZUikc5cn7xW2lMTSPB7Din0AgdU90j9aKzqkJFOaHqUqVlb
 pRPp8/e27YyfYXP9rUlr2GGqZnOLfUWLWfusBLNWcbGw87G656cDJKtc0FlHFRg21P3z8kPPBW+
 +jvZh4BHJY8T4wF4NZG34YZwNT2yYZoRI2w==
X-Received: by 2002:a53:c052:0:20b0:66c:c998:f9d3 with SMTP id
 956f58d0204a3-66ce49a273cmr1032714d50.5.1787276714075; Thu, 20 Aug 2026
 18:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260813064902.367504-1-kartikey406@gmail.com>
In-Reply-To: <20260813064902.367504-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 07:15:01 +0530
X-Gm-Features: AcwNN1V4dmKKGjPji2yVJLBTkyyZSgMh7TnOyiEqwl6nQbzA8cc22mdo1kQ-CyA
Message-ID: <CADhLXY6zACn7j=hSfj2jemjV7eFnVeAd4Dk_CVK4OKGu-KPX3g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, 
 simona@ffwll.ch, krzysztof.karas@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 21 Aug 2026 07:23:07 +0000
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

On Thu, Aug 13, 2026 at 12:19=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> pci_match_device() can return the dummy pci_device_id_any entry
> when a device is force-bound via sysfs driver_override, in which
> case ->driver_data is unset (NULL). i915_pci_probe() casts it to
> struct intel_device_info * unconditionally and dereferences
> intel_info->require_force_probe, causing a NULL-ptr-deref.
>
> Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ddb96c5ff032f4292a8dc
> Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2: Drop Fixes tag, this isn't a regression from a single commit -
>     the unconditional dereference of ->driver_data has always assumed
>     it points into a MODULE_DEVICE_TABLE()-backed entry, an assumption
>     broken by the generic driver_override fallback path, not by any
>     i915-specific change. Add Cc: stable instead. (Krzysztof, Jani)
> ---
>  drivers/gpu/drm/i915/i915_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_=
pci.c
> index 82415af47d54..2f03f95945f1 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>                 (struct intel_device_info *) ent->driver_data;
>         int err;
>
> +       if (!intel_info)
> +               return -ENODEV;
> +
>         if (intel_info->require_force_probe && !id_forced(pdev->device)) =
{
>                 dev_info(&pdev->dev,
>                          "Your graphics device %04x is not properly suppo=
rted by i915 in this\n"
> --
> 2.43.0
>

Gente Reminder. Let me know the status of this patch .

Thanks

Deepanshu
