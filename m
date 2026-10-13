Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA48CA9EDE
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 03:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BF210E4B9;
	Tue, 13 Oct 2026 03:43:41 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F24D10E4B9
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:43:36 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-677af43eed4so2045568d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791863015; cv=none;
 d=google.com; s=arc-20260327;
 b=Oja/Tp+8L2ELf5M577NTQf08QK+27a2R5ZiI8VpsMJ0QQVlZo0z1AaJGDOX2RG94A6
 pnZV5NOcP7AVWxhHN08zyIm9iv15goKdv5dgH2x9X39OWe1siSUNk6Z+xiienRDUDmjo
 uHf88eDQ83ROTJsVjOau754je7jIourtZ8lnDRJ7WBl33zjA93iIW03CYlzfmrDTzcir
 jG7ZdyCTvas5shR45qLnvvgIEj+/WsbZjYIqC6IP6byeHwcJ8MNzpsoggzJTVCdkbRHV
 6YXGWHrcbq6pNgw386q0gt4rG5vJdA+w6g1s/oO6iGmCtpVFKj2MQZxcwnKklPtyTYcR
 +0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g1Xe8/t57+Y9BLtJJ1DCvjjCumMN4aWsrAavgy8Razw=;
 fh=V6PAiM/KZ7fr+geqjl4xe4OdTp6ZnMbcXcrtjElj2j4=;
 b=dEiQYRsF//S8JKJC0dsp3aQXIwZGOnUdGoVI1KDML6ACpkmqQz8gfydf+SAYsX94NU
 x+8fLczK0w+e3AucamzFzOyqsli24xbGlofqMjDTEYhzooyW1IiicHotm8+FQ0V7XV5r
 fE5ZnXRFiwmrtL48KfzRSWlN6c5p6jS9vBY9YZHp4hAWrB11wz2x8cwL/9XMGBWxvcLr
 NiRZ3ZSwUn0yIx77Jpt4LiaDpaNdCYlkBZHQVasxPm7AjUni25Z4ead6brnu2rG2ittr
 Un19yV2LVtSPUyV51G7/1ITiXRJjOvTvBCgp7DNLbjljvfEl+KHgPXp08OoqqFD6ro1F
 /sOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791863015; x=1792467815; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g1Xe8/t57+Y9BLtJJ1DCvjjCumMN4aWsrAavgy8Razw=;
 b=O30z5p04pklVK8HPslWb6AtGU0yPTxGwx/ss7c73B9bEMBzSoB/2v68EaJz6NQ5r+L
 6oK0TtLtH6wOZ6n/EUM1+GNH1CrL6sd5f0oW/GAvugmLWI+6IZoqu6KEQQyNReDZJcDL
 hCObLtLRnEQIwMAxrwJcCKWQVd3MN+T/YES7PPxVMVkcMdZDzVon14ON17IQpfUP14CS
 vcHv8DnvgZp1I+tjlD3fmh3W1BYPucGXU/fC1m/1N5qkNq6PWkKCAauYw+NyUHJ8kbwu
 cZvNlSxYg24YFu42HYX6/QEyYdwIkTb3FsEX4IobfTxF6MU5nG41/8wHg9I2Bg8K3wE5
 j92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791863015; x=1792467815;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g1Xe8/t57+Y9BLtJJ1DCvjjCumMN4aWsrAavgy8Razw=;
 b=dB+VFNLhaMYSJ1hSQhmledHWUJEGx3W9XdTognu4+j75rH0gJShGfTLdhlaI3cEqw+
 6MUQsARLGaErBZ02G2bMJ3Aa5m7BnlG8wkTI74siaUgqL9GxvKpSg+Gy/DyptdL7UA7w
 Lr13bbpIoA9q2fhBIEisYtFc+GF2X/uzgftYRhBJGkIqx3XmWsnmRzetT+xcPTxCiG2i
 fPwou/jsSQDZRKOT3ez07vptw57NUVhyxLYA5IJngCMM5Okwy/gMATU8K8WNZLUQZhDj
 nlVjoMMKCRUHVvDVSzj77ofb4m1IkDbfNh+aL5De04hV2svjHg4bhtuH2aAw/3osQkv2
 Q1HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxw9LAQnj06G+w7U69NV+cMYbzN7mVI8RZGWJcZ2lO3roFn6F9uT010jyfeYxKLq+YpW9QsOzLZD8A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtA6Deu+mMttDtisZHpOuQD3cKmop7KUUS0ptmMylowWGI68Ut
 eqqBdgtgPUb3l2zHBYBUPMekNH4XK6uigzH9TWVXsekdVF+OxnRC4OhlmXbe7WJa0hm05pI5jDZ
 DkNY3Nc5eHRMVsn3n29Cd9QIJYe2yIqo=
X-Gm-Gg: AYBFou0urh51goF2BFmXirgMRrl5AbKqnK0jnf9uZWe8Xu4fNfHe/ymwLygl7jiC0/0
 08NlVS0sH7B9T2u6EtA3JkCfRxEdx+JdQ50JBBC5ShLpoN+9D96iDrKztVE2G5HqJUefgxs7Epi
 SKjgO22TvVaQ1WUo1/sMuMQzlJ+lGIu3/5auRYrhaXptD3cxe0cGkG5PNN9/qUaebjmSTyDOGf8
 uw+hbeRCIXoTL6Hc6UCgWQghKzmd3SDTW2LZ32MaFQ5f0RQWJogdVFRqpgEdT9/bj3GxaFXq80q
 ciVIjr3GQjlg1zRDRiNZr5r+EP4o+im0pNrOZ4DkBI/vgCjVEP5BnQ4aJA==
X-Received: by 2002:a05:690e:4102:b0:677:c605:b736 with SMTP id
 956f58d0204a3-679369ec2dfmr4046021d50.43.1791863014837; Mon, 12 Oct 2026
 20:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
 <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 13 Oct 2026 12:43:22 +0900
X-Gm-Features: AclHuK9taASNrgAMmV3Z1NS8TfpfNKzvhhsyrCVDqQveBDVwje9B5oj9wzDDHuo
Message-ID: <CAKbEznugM-HxPxHwZ7RxC2iLC0TDH0qi9649hWATiPYXF+urfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/imagination: don't gate the runtime PM
 callbacks on drm_dev_enter()
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Ryan,

>  int
> @@ -398,33 +397,24 @@ pvr_power_device_resume(struct device *dev)
>         struct platform_device *plat_dev = to_platform_device(dev);
>         struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
>         struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
> -       int idx;
>         int err;
>
> -       if (!drm_dev_enter(drm_dev, &idx))
> -               return -EIO;
> +       if (pvr_dev->lost)
> +               return 0;
>

'lost' looks protected by reset_sem, but it's read here without the
lock. Shouldn't this at least be READ_ONCE()?

>         err = pvr_dev->device_data->pwr_ops->power_on(pvr_dev);
>         if (err)
> -               goto err_drm_dev_exit;
> +               return err;
>
>         if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
>                 err = pvr_power_fw_enable(pvr_dev, true);
> -               if (err)
> -                       goto err_power_off;
> +               if (err) {
> +                       pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
> +                       return err;
> +               }
>         }
>
> -       drm_dev_exit(idx);
> -
>         return 0;
> -
> -err_power_off:
> -       pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
> -
> -err_drm_dev_exit:
> -       drm_dev_exit(idx);
> -
> -       return err;
>  }
>
>  int
>
> --
> 2.55.0
>

-- 
Thanks,
Gyeyoung
