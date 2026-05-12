Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB43CCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 22:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D9D10E2C2;
	Tue, 12 May 2026 22:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qjqFrmeh";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD0610E2CC
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 22:05:55 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-65c7492a2ceso5632366d50.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 15:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778623555; cv=none;
 d=google.com; s=arc-20240605;
 b=bLSWpF8ZIGfmqcK/SaXZDd+9fhM7fjFDTVelgm+objuS3r8H1iHDEgg09TPMkCYuT3
 Q3HdfC2Mog/KPl7j6jDK83n9zusqvqKGajHaB8O8BIgzylFZhXUsZzOfFW2Qf/QD8vpJ
 BcXR6suqHB6KPCkTsMpbld9PqV/iDHuSmC/DIZDQAH+LeaJq6KaKnt8nFHMNK8Cs+xZp
 nehR+WfZK0Y1SJ95/8IKx00h9H35SntgNSW09oJ8w5HIZcEDF94V7uX7YPL8JmcFkxSt
 y8MRLUrUrRaIY9BHWacA65RDKmgNWv4qkdpJs812rWZe2l8LuBenEu8CoS3E3gbEGdbP
 7YCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LYumDMVjxXYwqfISVgMJHCWZJqlEq6GvOPj4+VEZ0mQ=;
 fh=mJLVWVWov6eROdjgQtL1Xw90r4LaNq+4ymHjlWejI4E=;
 b=H5jjRu5npPD9sOe+7uD38KxyCvgcQhrkRspH65+ZPyOD2MKctivrBcXkhGWJUVuU14
 s/fj3CqhUxQILvd2ySjQSS1h+z+kc5+Ao9gajGx0KX3asC940Vqs+iM7hcrAugFkSShE
 Lod3h4P/ANPkDhfPk2Mp94lTlERfo8xdR8Zcf4aq1yLm56/kah9IvPIx2Bu63Ma+6i4j
 g8/0SJ6xzfvBR8CMCefmkmV5RmdeS4hn+FtVRUvc7cfJJEXqyRlt/y0dMnOZWSHNw155
 cKUZZ0WnG7XwH3SOolfgJXNdIEXp2+vl/yhMifMbJfDTlSaAWxLQIJTnAJkfMfPe8Rrg
 DbKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778623555; x=1779228355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYumDMVjxXYwqfISVgMJHCWZJqlEq6GvOPj4+VEZ0mQ=;
 b=qjqFrmehHdFDbiZovaud5v/MsV6I0N360OfEL/Vb6SVsxpNr6DvSwFLKdYZbBJRFhU
 Ur3VYmlkFKcfhDVR8sr82aBfUGCP+Scn09JsNTVuchTfirRlcbVMQNtmhB/cpin9APuV
 n2zBTpSopjnYtd+P8zSUsL48WuLkEqtSlHXpfCxjXEJCXaEYjM9TrtcFYC52xmKXclCe
 uk9cmpKQvRJhX9KD1xaaUpHmn1xr90CiE5tAXLfphfa0pmzmiWedhbtVhd+NIiEDGAc/
 /41xOHsNc+BVuGI9XpjPk3N9/MVgotTx29ZAq4GbzQrlXd2pHO0uFvjTPh7gL5LvskJr
 2u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778623555; x=1779228355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LYumDMVjxXYwqfISVgMJHCWZJqlEq6GvOPj4+VEZ0mQ=;
 b=c/DV5RlNr64M1mE3J4l77QZQHSBkG+77PK9j8rf9YZmTVtTt684RYW/Y2rb8HOSBTW
 gi4jkOMfuk3QGV8Ka7ZxThG0uBDK0bwga6owAgCyP1RvcVtmBiURLAOE7KNdjMOGaHB0
 AzC5DYaLZeSf/2Sj32CtorFHAngS/cs+t1wIDeOHlK6qnLLFW3Z9C3dfWJDIGX9jhmbr
 Sm4M6Jz2C42lG+hlEDLZ6/1mv3d6gjT2jiJ0debjSFCPeyfo3dH2BhxIyz/v4s8cXNQB
 ObJA6L79XZcb5IYpOonb5a2j8/DYvq2QQyixBASyK6s0BydQ8GYaVXSiI8p2wvmd7NG6
 kAFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1Nqt7pjkwsOnS+rYo0+IA3+9asrfftxHJM85TMPKgrt6idMa3n38HIiJnY90K4unkcM+mSHNL4f8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxI0ROO0WRCgyBdzsPwAgQ22wXPVb0VZjmotrgETvy874peS0WV
 m59SgYX0NWIQfWX+5k4+qqQy6rZkvyqLCH564ZKsLjnpFFBk/3F4RLLzuZXcBaO1I9dXZjBUzc6
 gL2G8SDH/YgqCr3Y8wCOTFPcZooo/8us=
X-Gm-Gg: Acq92OH2b/lQXjq/LVC+2OMGlAdGtpClnvalLZMf+4AvT47VM92fjaw98vy4sByAlLI
 Uv2NlZdBFEltARiAcZB8D2c78U2L3ZSxQy9bGvjCTfb0AjxdFilanMq2wAsnyHgdE6kbYUYWHsk
 sMCjiYUqrNj2xUOGUa1JBrPW+czb7xI6/kGgA2cpB9GtczB0sYPIYT0Ls7H+/ipWUHMdRjIRFff
 H/aHs/yYk7oUb7z44vRsaaqzhNIKmf4h75+WmMAoq6JPHTx+Ulqu7bbyTx5DORjAIpexXeRvyhZ
 p+Wc1b60Db/QsnDdFyvfDebB/QX/wgKKNFHjEHEj/P23EKH7R308sFTNb7C4IguQrCnx1V8uSg=
 =
X-Received: by 2002:a05:690c:e1db:10b0:7be:fedd:726b with SMTP id
 00721157ae682-7c6dc6b1e2dmr368977b3.42.1778623554868; Tue, 12 May 2026
 15:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-9-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-9-95c614a739cb@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 15:05:44 -0700
X-Gm-Features: AVHnY4ICNMPe0lrhbOSzL4gNX3rcLc6fndQ0OnE2Drip2-k6Mm3WL0MXjHs3XF0
Message-ID: <CAPaKu7SHcS=KaeLvSrxcopgL_aKQm2vVeRmGHGWW+E2YgGOM0Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] drm/panthor: Process FW events in IRQ context
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Now that everything is set to allow processing FW events in IRQ context,
> go for it. This should reduce the dma_fence signaling latency.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index f5e0ceca4130..8cfebf180de7 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1087,9 +1087,29 @@ static void panthor_job_irq_handler(struct panthor=
_irq *pirq, u32 status)
>         }
>  }
>
> -static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
> +static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
>  {
> -       return panthor_irq_default_threaded_handler(data, panthor_job_irq=
_handler);
> +       struct panthor_irq *pirq =3D data;
> +
> +       if (!gpu_read(pirq->iomem, INT_STAT))
> +               return IRQ_NONE;
> +
> +       scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +               if (pirq->state !=3D PANTHOR_IRQ_STATE_ACTIVE)
> +                       return IRQ_NONE;
> +
> +               pirq->state =3D PANTHOR_IRQ_STATE_PROCESSING;
> +       }
> +
> +       /* We can use INT_STAT here, because we didn't mask the IRQs. */
> +       panthor_job_irq_handler(pirq, gpu_read(pirq->iomem, INT_STAT));
We should loop here until INT_STAT is cleared.
> +
> +       scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +               if (pirq->state =3D=3D PANTHOR_IRQ_STATE_PROCESSING)
> +                       pirq->state =3D PANTHOR_IRQ_STATE_ACTIVE;
> +       }
> +
> +       return IRQ_HANDLED;
>  }
>
>  static int panthor_fw_start(struct panthor_device *ptdev)
> @@ -1489,8 +1509,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>
>         ret =3D panthor_irq_request(ptdev, &fw->irq, irq, 0,
>                                   ptdev->iomem + JOB_INT_BASE, "job",
> -                                 panthor_irq_default_raw_handler,
> -                                 panthor_job_irq_threaded_handler);
> +                                 panthor_job_irq_raw_handler, NULL);
>         if (ret) {
>                 drm_err(&ptdev->base, "failed to request job irq");
>                 return ret;
>
> --
> 2.54.0
>
