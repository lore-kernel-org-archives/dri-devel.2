Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F06FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375C610E0FB;
	Tue,  5 May 2026 10:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hk7VH0Xi";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 034B710E0FB
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:22:27 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a86c1fe573so3550989e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 03:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777976545; cv=none;
 d=google.com; s=arc-20240605;
 b=BuUpF+a1NWLwGZVgIV2blHlqAjNz/UVDkEvfxch9rnQBS5BMcG+g9skLf9hRhMvVQ8
 ST+urglE0U43YhCHkgXKCkVwchkPG/OCnfe36gNJn3l7zBsX+W6w1nNF74O2RMCaO/I6
 GRfsxn4fCwblBMZDo2Y4OjY9kIY5H1PDHL2LMHq7sXDwPGrRqrexkYlvVkvdOhSEiLmq
 EQCl23ltO6DYklRFFSP7Gh1oA0ceyfwJVc7OVV8H8yguWvUvAkw3jbKun3HjOYgu564I
 spd8AzvEuUAMlbVFmXvP8/D4AawSghBt8Vebg8hNmjewj1x6QZ6HySFP5ZrLIm+gHab6
 WXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IJ1GrriH4iJzXevh7IviFBK+3Czd0q7+uwXEVkfnGYQ=;
 fh=TWRvLTPmUvNCg5FgIp7pUQLWQBfYgWUY8UNbjxSaKMg=;
 b=QxPuv9s1sk0ymv/5LjiSYPw94UoMrg1ixE4ogK3/rt8+xwd1s2unALdMH1XnCv3CJQ
 THyMmf3UjlxLKVfz/LwCTzSsHuiYxoPNouU3ZMNrQ42y3QF+ka6Yz5CAExQu4/fCakd2
 BSNEUm7nsqooFbpbpvZBaHq8rZ6+kW1TFIzEVLaZZ8lntRQu7Jp5oVFw8V52bm56I8x0
 XH7ndytfdNee7TwnVmSdGut51DTJK5gu1G3nRaePPl8OvWglHSdFeHUTgLtxO5yO6Rjo
 lJqvyA/cPWJGyssRkotopub0pW2Y0IjyOjttwFM75VpLPl3gtQlc5WzDj0zL8BMTfSrd
 ynYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777976545; x=1778581345;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJ1GrriH4iJzXevh7IviFBK+3Czd0q7+uwXEVkfnGYQ=;
 b=hk7VH0XiZ6ebqQYU/vtEYKaBNwK/8F+lfZTYVZjwTCRmxniccQwb58sDByTfjKvObJ
 8Zjfify28O0ZvLpfaMZgZEQ+WsXNPINLfhUtF4/MGs0OsSBxd2yqF2tHrEU33zlBEdGI
 5Vqc4CNf8ltpodwemRItx7dH3uq2C/7A0PnTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777976545; x=1778581345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJ1GrriH4iJzXevh7IviFBK+3Czd0q7+uwXEVkfnGYQ=;
 b=H0n9WBEihTYP2qZ5+fQDJckU7XwDwLC3ZtSLoUidKK5wrjRv14Ruzw23F6Mtv1z0uY
 EhkKfWt5gK+PWXwPKEmhU4dy8syWz2kWmx9ez4ZPyhMuTqxb99XN2t63hWahSjPjO4k0
 DWVg+Z3GpaQWQbHukxpdz+wTUIuieS/Y59z8Oxb6rVtdR1v9/tTnGUzTKrN65l7KgKzb
 ixNAI0pwmpIS5h6hpAT6BZVehVfCiJwTif1gV0Esug+turRrT92uvfhobWeAoXxDxq4g
 qZuxvRVIfHHxp69EoQdXHem8a5VM1Ck870b5I7hY96a9UR9hAXRAflo30q94XF/hZ4uE
 zbYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ88GDHVjuvTVn+zOaPD/khH+adxEy5J8rQnAI1KVr1DWDYBouV6KBFHOpF0hAFCZFytYMPceTVbYqs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzxslcs56uMfq5B/RUsSLBPIhH5ql8NeoJDnbpS9K1+Bz1nWxJR
 KZJuf90ZMwnCVLwUvrTHL4++0cXAqHKf1X10Wrcndxxjpl8KgQjFUkjBLQU0SFh2xqdT2beBZPr
 pgzoQ6bJpOZZUR7oexKKlEKXq28zZj1lalYJGJE1Y
X-Gm-Gg: AeBDiesQiNFaptd3gA3EcwA4KFDM+urOutZZfIFJhIEJSI12QnGq/evS58pV3VFMqYm
 M8QUhWy/tF7rfHST01IpHvlWaDnx9PaGcT+SGTnO8JXPL4w7AZJQ5gYPwCbR15uuzKCLRYfjiC+
 GAHvrBiLg/j/WbZ63pqgBhiz2wkGAxY1yyC+WJQC6Xw6OnfJJOK+pF6TBXs5fqyMRnZfCp5FxbH
 IzVDhUCSGW5HwELXtqz+AhAnqy/VHlpqGCsCVqAP+BcX/slT81amV/nkN2iOqbCrzQyEQLmO+fl
 TkJscK7yRxZ4Xm2vR/kIMo07uzdEOec7xdlLSQBJWiMRmczShlgMFwbTuOA=
X-Received: by 2002:a05:6512:6c3:b0:5a8:6f4a:6a62 with SMTP id
 2adb3069b0e04-5a86f4a6b86mr3881772e87.41.1777976545279; Tue, 05 May 2026
 03:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260505042631.1916555-1-domibel@debian.org>
 <9f7eaea02c2cb52afac4f59fb78224e9acc1f160.camel@iscas.ac.cn>
In-Reply-To: <9f7eaea02c2cb52afac4f59fb78224e9acc1f160.camel@iscas.ac.cn>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 5 May 2026 18:22:13 +0800
X-Gm-Features: AVHnY4LM1XiI1kENCPUH3zPqcVoO9RekZSOgZTyou8mdJ-h-pXHxvwlbu3Z3piE
Message-ID: <CAGXv+5EFscWfBHmu==PqBLGxN+wR3pBbdQU4bDX6QaLDBNFueQ@mail.gmail.com>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Dominique Belhachemi <domibel@debian.org>,
 Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paul Cercueil <paul@crapouillou.net>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
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

On Tue, May 5, 2026 at 5:03=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.ac.=
cn> wrote:
>
> =E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 04:26 +0000=EF=BC=8CDominique Belh=
achemi=E5=86=99=E9=81=93=EF=BC=9A
> > Wire up the standard non-coherent path matching the ingenic DRM
> > driver.
> >
> > Tested on StarFive JH7110 (VisionFive 2 v1.3B).
>
> Interesting, I am curious about other patches added to test this.
>
> And this patch looks quite generic, should this code be added to the
> corresponding helpers instead.

This is pretty generic already. The helper functions are used where
they are needed.


ChenYu
