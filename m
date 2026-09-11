Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F96C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CAC10E0BD;
	Fri, 11 Sep 2026 18:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="erOXO1fI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3304D10F6A7
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:00:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A0486020C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B4D1F00893
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789149644;
 bh=Ln4tV/9ltZBeYzidwNmaTydpreMcBH5u6aBCjr2S9kQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=erOXO1fI8BTv33vuqCDeLVZR1/xGGhk/9jvSxvg23iX7Bzjz3FblmZIU113LvIASc
 uo8/UAa3HeYZnYbC8lAqh0UbNAig3LwFPXwHjTtj9OdLOzipxe3i9Uu/Mw68iMb+Y5
 TpGFYQPL7TklzG6U8KA1DopN+B6srF49kzxoH7kNJoN4Byxksc9ZU7gymkNYoS4grk
 VDt1ONBvAkeobY30145XsYFcE+WZkOS2UZLfN/wsJQr+efeg8icOV5ZZcVFanqqJQd
 o78xXtjOtFREOCLxi31rrOG9APwq+ZsryCvm3Ytl31w3Wm7Jy775hJOxOWGxKS7nyb
 +oFu/wWkBLyEw==
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5b6031cbc6bso1271017e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:00:44 -0700 (PDT)
X-Gm-Message-State: AFuF++nUNWT9tFOD2n55jcC7snUy+rtZPxvu6HyVZigGph1u8wvJOU39
 Dt7hW9jfq1lT1hoXitG2kGk96XSsvpXvmkH5ukfz/KMuRBGcFfIMlzlIwhNcybb+oV+5B0Ad7VB
 GgP+lsVsAQGMgAibbJW8Px3IIgiF6X9A=
X-Received: by 2002:a05:6512:10c4:b0:5b8:993e:6dcb with SMTP id
 2adb3069b0e04-5b8a029ddb7mr1100799e87.20.1789149643414; Fri, 11 Sep 2026
 11:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <20260910192526.137057-1-roshaen09@gmail.com>
In-Reply-To: <20260910192526.137057-1-roshaen09@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 20:00:30 +0200
X-Gmail-Original-Message-ID: <CAD++jL=fnA9qV9XpAScM5knc+aY4eHG3r9a5RrGnhvVqORwMhA@mail.gmail.com>
X-Gm-Features: AcwNN1VNyS5JesON5oceppyiBvf6Kxyrr06Pf03uMf0r2u2yehdu3ym0fg0KUnw
Message-ID: <CAD++jL=fnA9qV9XpAScM5knc+aY4eHG3r9a5RrGnhvVqORwMhA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/pl111: drop alpha formats the hardware cannot scan
 out
To: Roshan Kumar <roshaen09@gmail.com>
Cc: dri-devel@lists.freedesktop.org, leandro.ribeiro@collabora.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, pimyn@google.com, 
 linux-kernel@vger.kernel.org
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

On Thu, Sep 10, 2026 at 9:25=E2=80=AFPM Roshan Kumar <roshaen09@gmail.com> =
wrote:

> The PL110/PL111 controller scans out a single framebuffer and never
> blends its alpha channel with anything. In every pixel-format table
> each alpha-carrying entry (ARGB/ABGR in 8888, 1555 and 4444) maps to
> exactly the same register configuration as its XRGB/XBGR counterpart,
> so the alpha byte was never used by the hardware.
>
> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
> with alpha exposed") added validation that warns when a plane exposes
> alpha formats without a pixel blend mode property, and PL111 does exactly
> that. With panic_on_warn enabled the warning prevents the syzkaller
> vexpress-a15 manager from booting.
>
> Drivers should not report formats they do not support, so remove the
> alpha formats from all variant tables: the generic PL110, PL111 and
> Nomadik tables in pl111_drv.c and the board-specific Integrator, IM-PD1,
> Versatile and RealView/Versatile-Express tables in pl111_versatile.c,
> plus the now dead case labels in the display setup and the Versatile
> syscon connector switch, instead of advertising a blend mode property.
> Behavior is unchanged for userspace that picks an XRGB/XBGR/RGB format;
> alpha-picking clients fall back to the identical X variant.
>
> Link: https://github.com/google/syzkaller/issues/7805
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format wi=
th alpha exposed")
> Signed-off-by: Roshan Kumar <roshaen09@gmail.com>

Patch applied to drm-misc-next with Thomas' review tag.

Yours,
Linus Walleij
