Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47414C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 21:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7DD10F92B;
	Fri,  3 Jul 2026 21:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ORQdp1Mn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD2410F927
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 21:00:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1727600C8
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A6C1F00A3D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783112416;
 bh=rDQ1Qb2+EcihQsKHR/ytfoNORSXQhMWVVWuRwP0kOuw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=ORQdp1MnA5BQ2tfcvXf2i0gTyKhQ5IRQQRSkBJ4KdgLiRl+9Or2VFPeLhFpW4k2aB
 oWu98cLLZNdRLgvG7sUKDNyy0aDUAawyUbxNXKKlqagTAgH/n5JvhN/NFRMn92L6OW
 E95sSkT4yEycAElF1sQ98dWHQSoeBhVQNP2tWpbJy2KanwaPI4Bo6JUsi8eswLBlFN
 CZKPhuvDiWwo/N1gXo/dqFi4wc4pboCTRarqLVD/F8dFGwFcmqIFnTo8AlVeDYnTew
 SUmD4CqTNvZwF/LsYH167BNK7R9Z7TeLRiDvbQyM2P+GRebkrsSWaVzadgDfl0RMse
 jlEAhDcRsRBIQ==
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5aeb17c2564so960387e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 14:00:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RocE6QyLk5RbG462pWybrPryJ+CzSAiw28IDn49TKMzoGfs2rNyQ9xNqn2CKM+2wnLMBfRigxbG+lA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKVcIGjpd8OnOtl4Lmbc5+Ivho1/aw93tO8yZjaAqrkQckm1Qu
 /MlaNqatQS55U1rodqRfDgCl3ljsIZLZVpLOuPvR0a/EpkSXY6JVg7h1FnTe6jcodYbpavUsfvb
 N5SSwZdB7d6AjSXJYhJM5LozvvTLePiA=
X-Received: by 2002:a05:6512:114d:b0:5ae:b2b7:a083 with SMTP id
 2adb3069b0e04-5aed5088081mr105132e87.22.1783112415174; Fri, 03 Jul 2026
 14:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAMyXUJmmcBvydpN5r6iuAGLjuftGkiVfRjT6KbdRRGLZ74NAoA@mail.gmail.com>
In-Reply-To: <CAMyXUJmmcBvydpN5r6iuAGLjuftGkiVfRjT6KbdRRGLZ74NAoA@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 23:00:01 +0200
X-Gmail-Original-Message-ID: <CAD++jLntYaL=r6TOukXygZVdxiVaNOCey0GfiQALpFyvvfrufg@mail.gmail.com>
X-Gm-Features: AVVi8CdYap7gYtY_-XcsuexkUKcZDsTp-sG6blPfwoD-gR095okBARqFdX3gzp4
Message-ID: <CAD++jLntYaL=r6TOukXygZVdxiVaNOCey0GfiQALpFyvvfrufg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: samsung-s6d16d0: Power off on prepare failure
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 "Cc: Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
 "Cc: Maxime Ripard" <mripard@kernel.org>,
 "Cc: Thomas Zimmermann" <tzimmermann@suse.de>, 
 "Cc: David Airlie" <airlied@gmail.com>, "Cc: Simona Vetter" <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Thu, Jul 2, 2026 at 7:06=E2=80=AFPM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:

> If enabling tearing mode or exiting sleep mode fails after the
> regulator is enabled, s6d16d0_prepare() returns without asserting
> reset or disabling the supply. Since the DRM panel core leaves the
> panel unprepared, a later unprepare call skips the driver callback
> and the supply remains enabled.
>
> Assert reset and disable the supply before returning the DSI command erro=
r.
>
> Fixes: ac1d6d74884e ("drm/panel: Add driver for Samsung S6D16D0 panel")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Laxman Acharya <acharyalaxman8848@gmail.com>
(...)
>   if (ret) {
>   dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
> - return ret;
> + goto err_power_off;
>   }
>   /* Exit sleep mode and power on */
>   ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
>   if (ret) {
>   dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
> - return ret;
> + goto err_power_off;
>   }
>
>   return 0;
> +
> +err_power_off:
> + gpiod_set_value_cansleep(s6->reset_gpio, 1);
> + regulator_disable(s6->supply);
> +
> + return ret;

What's with the indentation in this patch?

It seems whitespace-mangled.

Please fix up and resend, the patch as such looks good!

Yours,
Linus Walleij
