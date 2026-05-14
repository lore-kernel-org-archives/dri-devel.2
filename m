Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BD2CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4E410F302;
	Thu, 14 May 2026 18:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJROZNBK";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9ECE10F302
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:35:04 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-65db820588aso5736261d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778783704; cv=none;
 d=google.com; s=arc-20240605;
 b=CUZAm2tO+abRPoNK+raKkygq15HYv0wf4icxI7Wp52o/+EGcugNfCnYs/EbPrhFP+L
 bbcC7nA8AdNw4FQ4D49nnq6JHTdHKnkeY+m1QMcDB8qBQF14HkZwcUD8eW0RLHV8wEwj
 lrYCl/bZjIw6QX7CgHUiW6cpVoLccvDd0mBu7ydah/G2yzny905FJ/5wmcS0W4jNuJbQ
 qWbbXzkPIN1/OICSq/ZBmiVL1cqp6ibi1NNYTe5JjymEQ06mo6mDpfqfxOlVhJpnYq4K
 0t+eSLB5BryyjsRkSZMUMb0U8i10QMEXx25Y7TTplUT5LjCP9nwX+FmkNubL28g5BZW3
 6GLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J//dZe/CVmScZjUaogVteeXVlNwNW3S4gHbIIPdEbvU=;
 fh=y3GUJUZUbVlDMl+aYtPTEnsSp6wrSwtdCl4L9SRu3vw=;
 b=gT5W7C50dct1zOvZ/s+gYAOrmofva5xKN8h37X3+G2kcw9vYZuNDVQfTIWCHO5HFp8
 rE/TPI5FbEWH7TxF6Bd110fSYGlTPOxNli13jvteiUyVuBcpit3oNjheXTHkMGTEa3RF
 PedjqJTy/EcheP6+I39zDDbZT2JoSnbmKT2TatpF4ukScp0jhXP0tbMEXC2tGiaiBgcR
 LG3KjeeGAo24Zos7UtlIfcZd7mIVUgo89YiWaJXfh9ftWLqyi6fMawSXG2GWDxBnl9Dg
 vdWMAeJxVt80rmVVsImHFI+0d/m2XL7i5C4DVpYI1CAi9VIpIMB3j044paZk37Gjnhmp
 65yA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778783704; x=1779388504; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J//dZe/CVmScZjUaogVteeXVlNwNW3S4gHbIIPdEbvU=;
 b=mJROZNBKZUpoM2ZkqwFQnFdkQSkAW41P/Wqqs8/AU/zIMDt26RsBorDMf8Yv0mkdcj
 mvh2k3l8pd9xipsYJXca2dHBe8Qburn9HHmNt07bJLGib8l0NunyGBT0WtA1Iar+3tCd
 tutOCx6+n4GtYibWEhUQ7krG9PZsN8iobadkwp49rmQxSYhedMXa9dRA891ePPKYVEIo
 Koq5Worj4+Hf+U3Tq67PbnUlRBqaQ+nMuDY8PJAE+rJXRmR+19x2+T2fEKLiyC4jUSix
 s3hr8hBetLmuogHcaDvBQ7gHdqn+JqgntiAfXm071N31n51XhDIuWUm1oWhSjly9svmj
 fXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778783704; x=1779388504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J//dZe/CVmScZjUaogVteeXVlNwNW3S4gHbIIPdEbvU=;
 b=fimqAmgf1JXZOYC3cVERE0Q+m56e/NXErIMIKAEs5SJSFU2JFju94ViyK1dSMPQOZB
 A9h766fA1cIFk1J9k2J0KzN2arDaINyNAYCCl/tLaUi2pYPxN2t9s628lzfuY305vb6a
 z/vR9O13R/Dx33VFvQfb21zg2QFRamQIzG1pM/rXM7oFMT5KJSDzlL/HVEKuy1zttOuF
 iqq6dTtbxHB+vugS9jeSAM0O/hZu/Gy9t7/1vO+6GAmXUe6l8e30fbRNht3HZ+65MOjZ
 3vC4lEHLNQcwyEhXTbpqxma1EgeCFwDZtOZhhpDg1j60fHiXqogw09lcT5I/+fbCKRxx
 8U8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M986Fu9KXDhGRMDu1YjD/7lSYN6yCrx4AxBaP4MnasutgqqcR1O/sO7CK31pt/iaLpikt/QDEfdE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKzvPzfBhbJKyeavTSrcU53on6KweEzzZZ4RL+eGfY8E/X9wMw
 xIa0j2J2OIgBV/FTKmnXHGpTCKwqLi+v6mOyFaFJTLyzs59ZRFXHvKXN9vGGbzXqaDnWK30NZZG
 TuY4xfKf++cuXljhub7uxlpEOGbFbgSA=
X-Gm-Gg: Acq92OE6A6ruvR8Cuibq6Hi3+4VX4yTylqlv/308/NaDS0G3/Oy8lfyCm5YZ/oLwzrk
 MF968YMq92ZxqsW/B5lNDHsWBYA0TfK0CDOLzXdbf8yGyRcOPq5UPQ+9XjyIqX/S8SyvlwZEIUg
 iZxLPVI6isCWid0YOkwE0Cd3F8dUvQ1Fkv5z3/aH6+OyYXgiAjJ6opznwXjlK8fZkaIeqNeNDPa
 nmmmwyzt20sO9UslgiHkyQys51UMVAcdnXZAFrtIsCCVkFoKEOqoY4+MtxUCCqB6cDEvSaRzG5g
 Dvfy7bi2+IYQ6HWslkR3xfkqQu7CHaA9tYYjwnaDwUnECX3Et8RNxTJLBM5iYimesZVlwnsOKw=
 =
X-Received: by 2002:a05:690c:60c5:b0:7b4:b591:e79a with SMTP id
 00721157ae682-7c95a5700dfmr5776747b3.14.1778783703586; Thu, 14 May 2026
 11:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-3-f2d8c15a97ce@collabora.com>
In-Reply-To: <20260513-panthor-guard-refactor-v1-3-f2d8c15a97ce@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 14 May 2026 11:34:52 -0700
X-Gm-Features: AVHnY4J0ZfS6wqY8kezEbJgIA7LKzsoOFo2DBZGmkU6Uvlx4juh1BMI8h0we3pE
Message-ID: <CAPaKu7TULU6_-8eoygq0svBTbnX-vFvF3sH5hDzyi9kDP-9enQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm: Define a conditional guard for drm_dev_{enter,
 exit}()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
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

On Wed, May 13, 2026 at 10:24=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Define a conditional drm_dev_access guard to automate the
> drm_dev_{enter,exit}() sequence.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  include/drm/drm_drv.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 42fc085f986d..79d1958f93e4 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -490,6 +490,15 @@ void drm_dev_unplug(struct drm_device *dev);
>  int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>                          struct drm_wedge_task_info *info);
>
> +/*
> + * Only the conditional drm_dev_access guard is valid. The drm_dev one i=
s
> + * here so we can extend it with a conditional variant.
> + */
> +DEFINE_LOCK_GUARD_1(drm_dev, struct drm_device,
> +                   { WARN_ON("Use cond guards"); _T->idx =3D -1; },
> +                   drm_dev_exit(_T->idx), int idx);
If this is ever mis-used, drm_dev_exit(-1) seems to cause OOB access.
Is BUG more appropriate than WARN_ON?

> +DEFINE_LOCK_GUARD_1_COND(drm_dev, _access, drm_dev_enter(_T->lock, &_T->=
idx));
> +
>  /**
>   * drm_dev_is_unplugged - is a DRM device unplugged
>   * @dev: DRM device
>
> --
> 2.54.0
>
