Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6AAC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7841A10E401;
	Tue,  1 Sep 2026 17:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfAp2OdX";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704AC10EDFE
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:48:16 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so11572a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 10:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788284896; cv=none;
 d=google.com; s=arc-20260327;
 b=ktz1/OPM2rg6YpWHSC5ml1gy0iWAMQiwAY7U7ily0gQXTmD6d+uUKFHr/RH54Fb2fl
 KnKQNAN0Dw78nUAkzwuyc65XZFgUOis4miztWuUjSY/jtl/VqKgjUcXx8UMUoXo5sVli
 H2Ff3v1Va0UokqkD8Fb4df5U0dBjHIRCELcHkhWyUx6VTA2pSKK3gxDfCCgOId8SdfMR
 Xo1fToa6EkImTuW2PhygRJAkDjGHXmuMH92p98n8HA6NascsEAosRo4wThwFUIR3W02h
 ypSPhNoEUOJdGiQ79LJIDK4U0Iah1i9TspDVcFERziDcx1IOq+iiszDqzJIePTlKViiX
 HxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dcj2MbPf+/703LfWlGvVkcF5hM4WvaFgdE71pfXNPtQ=;
 fh=yZQax2N2xImqgti809CJAqkASVjDe02t/0cGBneeK6U=;
 b=qJS3M6pma7ztp6SPurNt1/g73dUiLicr5hDLq6G3hyJbvn7hwNU1U+WIxB6F5YkrOg
 mLGpTjHRh6ghEYYUjRNNfWn1wK92Ut8pmCL+r11P5yrjCCBPQaudygCaGtkzYoR37BIQ
 BnxU3Qsllbo8FI6svkZlaD9C20ntSl/6RsPSuXOTJhwOGGeax6RAdJoSTRK+2DpROFOT
 5HlRGhqTYqWeeVpEj0HHGNPcmTGzcgwLpfH8j4eHLgIrX2nW+AIZ9ifROqfB5/1pdDhM
 O7UC9lq1xrO3iHrmQV88mrAe8SIOctaJM30IJQ1xpO5XD3d6iC0GAgekjh+YAHFj3Z51
 bD6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788284896; x=1788889696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dcj2MbPf+/703LfWlGvVkcF5hM4WvaFgdE71pfXNPtQ=;
 b=VfAp2OdXOox8O51ZqlxCMlqiQWsD3q8xJHlU823ulQuviCQ3Z2BuuVsgcnIs1ULfOw
 bLhjCRMFT8MrwFUiQgQO1l57SRhzOdrhkNYOnAWmYJVSo18cf075BxGI6SLpfIwf/1fw
 ErBX/wS1Yw7Y4NgcEEyh3m0YM9D1CgeSUIYSBLpxMXXDNnWyGfIFEYumlPcWk616leCx
 TUkDKprYgAM4ORHhBS43DqCCqHCnnCregHEsa0GOppCwa4e79s9eZpFr6h+ekmdrM6d9
 O7PLnX8XWJom2IRGJPnIq0YxIgUy0RCzDKxhemihL7o8GTvG58tf9H1xXj04TIrpUuoW
 HN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284896; x=1788889696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dcj2MbPf+/703LfWlGvVkcF5hM4WvaFgdE71pfXNPtQ=;
 b=a5W3Ik2DSF+uOoInT8/WoKjGSsZ0dlCKcM9KTKLJfcc7t+ctpHiZp89wZjBXJVLqrP
 JdkRsWeDkU9Wz9S6VeNgjjJGzftRjozNk8jetVv6Wq5tgY0rpl7frQ+h6Sd3JcFRspmN
 QQpGihob5wvViHj34lxSWTZKCz6Qg/6nzv+daze4hIyrlHh3IvL335QfiCNB8M684bpt
 Px7/H8H8bU+Gkw59BVrr0o+SLxoTFnG63QXWnnkg5+tufpzNR5Yx5hX+4ZeS0kOWvG5z
 xoruCM2K0TXXtqFkes0Hc3XXQH0P8aXeJB9wlrDWLarTE6U7n5raTpbyNtlOIBjGrugJ
 iwZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGXXDdIrOd99o8yBiBryITOFpwGDk8Q+gCz3Hwm9ka2GWHc5LMHCueScMqdj7W4c5QRIhQWLD+giw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mTG05SCZEeh+RkXfUl7+sP+mjpZsnLVJaoZSZyhnfVpEK43vHL
 zQhZHPO84UxGDPlS4Gh9BdCo3hDSavxh1InwbsfccUbgRTdGXr99zCRdbO/IY+0jwkpZcSYhjJp
 WV0+WgFpOZSzLkawAowqrajGMdLCRhgk=
X-Gm-Gg: AYBFou1iB6bMHSSDnZHx/xpPiWViLUZ3RUPv9ANN0Rolvn+Oque0ZGy486tqCoECaZ8
 cC+NZTwWOVbXjn9w9HUf46SfQyzyHxo0hJAb0NoaG8VHcGBfkbMNtWPmi6ysxd1SjxamqenqH70
 MQCfkkyc3G46tza7gWBh7MjQbXU0/MNiQs4u3RbnSLshUZmGz1F15fF2HF1fMjxwTAJaqB+/1+h
 XB8XjwqLs2THz76RVuGUW9FzsMMiQ/CQV0y7qlEWGJ3P6D+YOpZW5g/sNislYZR3lPyz5E0TWTi
 S9TYdhrIDgC7kCX5Ar7uV7ceA9fHvbjNS/M42Mt3Ug66b1ja5xgv2Yk1rLjToqPczmA1cREXhot
 pMIVY6uRLa5baDIFznEzp+9vOtWEmauG9
X-Received: by 2002:a17:90a:ec85:b0:398:bad2:c0f with SMTP id
 98e67ed59e1d1-398bad20e7bmr20530963a91.5.1788284895589; Tue, 01 Sep 2026
 10:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260901072615.522925-1-hrushirajg23@gmail.com>
In-Reply-To: <20260901072615.522925-1-hrushirajg23@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Sep 2026 13:48:04 -0400
X-Gm-Features: AcwNN1WcS_X7Oe_rNMCrlpJl5NTeoyfqRDXOQdKoSI1aY_8E3V62TAx7S1S3eZM
Message-ID: <CADnq5_MM-_7FAWo9PLyZzJOHfck_Ya2_vWEGFm4uGTQp446SUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: use kzalloc_objs() instead of kzalloc() with
 multiply
To: Hrushiraj Gandhi <hrushirajg23@gmail.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
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

On Tue, Sep 1, 2026 at 3:59=E2=80=AFAM Hrushiraj Gandhi <hrushirajg23@gmail=
.com> wrote:
>
> dqm->detect_hang_info, dqm->hung_db_array and dqm->hqd_info are all
> allocated with a hand-computed count * sizeof(TYPE) size. If count
> were ever attacker- or firmware-influenced and large enough, the
> multiply could wrap size_t and produce a too-small allocation that
> the code then writes count-many elements into.
>
> kzalloc_objs() computes the same size via size_mul(), which saturates
> to SIZE_MAX on overflow instead of wrapping, so the allocation itself
> fails cleanly (already handled here via the existing NULL checks)
> rather than silently succeeding undersized.
>
> dqm->detect_hang_info_size is left as-is since it is also used later
> for a memset() call; only the allocation itself is converted.
>
> No functional change in the non-overflowing case.
>
> Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 67137679a901..5aa42fd5bb49 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2013,17 +2013,15 @@ static int start_cpsch(struct device_queue_manage=
r *dqm)
>                               NUM_XCC(dqm->dev->xcc_mask);
>
>         dqm->detect_hang_info_size =3D num_hw_queue_slots * sizeof(struct=
 dqm_detect_hang_info);

Can you fix this calculation to check for an overflow while you are at it?

Alex

> -       dqm->detect_hang_info =3D kzalloc(dqm->detect_hang_info_size, GFP=
_KERNEL);
> +       dqm->detect_hang_info =3D kzalloc_objs(*dqm->detect_hang_info, nu=
m_hw_queue_slots);
>
>         if (!dqm->detect_hang_info) {
>                 retval =3D -ENOMEM;
>                 goto fail_detect_hang_buffer;
>         }
>
> -       dqm->hung_db_array =3D kzalloc(hung_array_size * sizeof(u32), GFP=
_KERNEL);
> -       dqm->hqd_info =3D kzalloc(
> -               hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_i=
nfo),
> -               GFP_KERNEL);
> +       dqm->hung_db_array =3D kzalloc_objs(*dqm->hung_db_array, hung_arr=
ay_size);
> +       dqm->hqd_info =3D kzalloc_objs(*dqm->hqd_info, hqd_info_size);
>
>         dqm_unlock(dqm);
>
