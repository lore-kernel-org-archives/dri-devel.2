Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B74606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O6EJL/Bk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C9C10F2E2;
	Tue, 20 Oct 2026 07:36:26 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B13E10EB93
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:26:33 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8ab395abf79so14070667b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792409192; cv=none;
 d=google.com; s=arc-20260327;
 b=Xs4xoe1i1UqMRd8eZRkikbpdswcTsjwmYgJg6Rqwq8tmfCpFwSZuA8QjoReU8/IPqC
 qqCNtG+Ifj1dIvKSFNVimdX0g9rZGY4OPVgcIAZwRFs68+4bne569ZDejFkvUwVpcAru
 DJS1aMwyqImcrgPfSZ8mmplGyLpW2GR6zCES8BgiIlMd8qgRCA126S0kEbV1z3SUYGHJ
 t3VofL2Recs1wjSF81EdUMyWMXRwMBmRb8tXZ8JdAdP6kxSHh80i0bLeBRO0upMmGheZ
 YGJNkAQXPQztJHE5hqggA5taUK2GeXvWdKRWactMfqIo+0v6xzsZwXxJvzuYpBv/+Gso
 0WrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GTD0jeXtR60aME/UdLAfLsdgVjEQHvE/dqZ2xHjZShQ=;
 fh=hY6atiVhwbefoDY+MOvHJH7858rwYNGhQaMfSc2Zo+4=;
 b=nzjJuQp8gahd8VapxOUXNL8MY4tbBy3B9IFM4Pf4WQJqg3H8HNoXN+O2wFwd+EKlLN
 yZWblpRNmAhecKbw95FIAB/YhJCFi5OZScMgGOMs3UN0A9Ia5MjH2aIAmWGV3uNpSM8M
 ZQ4BcYK7xSePRLAI1p7SvAecdIGdUbcykhlWVaOUZjEN7tJed1mJwMJI/iT6lDF7l4R9
 4LJzdxMRPhgRlMMnay+OBYvxLtG5iLkRuCKpCWHQ6pZuBXa+cBwPTcMTnySO4UCew6cg
 UmLBK68XqfbxvFT06XAnTSTB4htP+n3/dT+cafAfEFdpLVz3XfK9V/eKagQVhgtT3xiq
 S4Qg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792409192; x=1793013992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GTD0jeXtR60aME/UdLAfLsdgVjEQHvE/dqZ2xHjZShQ=;
 b=O6EJL/BktS3o8INpFGu8DQ/2E7WhggJuHxFefgvuhgIGgNzv4bw1ib/DxPlSb7iwC0
 b/h2uCd8Azz9BVsU4Wued3g52nSfVETH8VFXZM/IQhIr6EnAWINz6/NL4pkZglvz1uDo
 2qvFXRLF8ttkrG2f4A389ulJ/QW0f+Ga/DITLlK1T/cSzAlEElINW1nPh5daHMK4qdxj
 gARr7qm6DA9Vuzp8WFX+wRURLwTuZWrRBNwAYYy6faOEL+ps1F0VLhyUB0jawxVpQd3P
 5hAsXLJ2vDKzW8C0Iot3jjYYFWAqOkHW1yViZA4abjG9CSp8mpwKf/pQjJFmxJLWvXmM
 hPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409192; x=1793013992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GTD0jeXtR60aME/UdLAfLsdgVjEQHvE/dqZ2xHjZShQ=;
 b=F4xsoE/Ia4ERt2CEgG04ruANatX3zu3kGvOsIrbuDi8EHdj/GOAyWaNXABiBpHKMCL
 E2OkHFy9ZFdDTfhCPwfOK9NQtiOxfBxdYpao2fi/B9QG4jBXWsOiRS3Xz9ZdCdoNZxmm
 B5JqbodM9XKisY2oIyux0JzYQCuq90/99dwLA9u67bYMvb0xwPYr8zKkb4oQac4K1X+7
 EUF91yfsaSQMBulA6NQoyNnRIbjOMrvfI4XPsHiV0Yq+CT/IR9wuOqB4QYdwQtfJ4dw0
 STVSJVUmQnUatejTtE4aX9Od8amsQW6fGbJ0KqSRx6WWpBHwbhVux7F5haUgNeLWXjlE
 PuXw==
X-Gm-Message-State: AFq9FYK7dWqYaRrNZPfg+pXU3FBLiaCzV1RuP9gnp9sUoXpxnea2+chZ
 zi8FKYTpUD1oPpkcFRpgo/SeHRqjDv9ACY+Aj1/m/GmcMVZDJXv62/bO1cShXXVo8M7ZwkHGisE
 h3Fd+v3tOHk6T8BMJC9Zhx6svEORxAUI=
X-Gm-Gg: AYBFou3mEq3gSdOYWXzv3pHhKcBeuuS+f3uJXfBeFQagrJHXseO6M4mOqmpFcW85JZs
 HETFOXbe0vdBljBwXn12lLPOZb3j52IJIQDl5Wv5EOBUrJTugcA313tt2c8X8812ceUzZUez6kO
 NhXOD8rXCg3no7XXkgKsJC1wIlAYIusBvcuYkQtI64jezB7YaYqOhhGU1kZoz6o8zES/5j8yvcK
 gwEW5LKgxCutHJ2wVEeEUUoovtqx+JFsUx7eMKTA3iIeHlfdc3HnCFPVGnLE9Yolg5+drmMRyQV
 rS1OkaxAEZFMASZR7p/F0YsdxXUVMEr39u7OhCsXeFEg68/zHlentImhpBWEQxbO2b2oIAcqLCr
 Hm77cAiJRTKkdy2tyXZfZzXfIzoSHt05ngahYDfYGEOVMGLRHoPgrD0H+N9pAY0mUdHxihSUrvC
 OZY5sZcg==
X-Received: by 2002:a05:690e:1347:b0:675:66f1:5ed9 with SMTP id
 956f58d0204a3-679ca90ed21mr2347287d50.101.1792409192148; Mon, 19 Oct 2026
 04:26:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016162912.64581-1-lukapanio@gmail.com>
In-Reply-To: <20261016162912.64581-1-lukapanio@gmail.com>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 13:26:21 +0200
X-Gm-Features: AclHuK8NAOp_nRQSq-Iz-AG3DYdUQ7KXnVtQSaGV8OFLCu20HF33SdrAf0b1-9c
Message-ID: <CACi=Ov6Jg5eUxskBbmtWOS03jta90RK0nByhWf4EQs1PNhvuKQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] backlight: Add Awinic AW99703 driver
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de, 
 daniel@riscstar.com, krzk@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, junjie.cao@linux.dev, mitltlatltl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel, Krzysztof,

Thanks for the reviews. Before reworking this for v2 I'd like to agree
on the approach.

Following Daniel's suggestion I'll add AW99703 support to the aw99706
driver using per-chip data instead of adding a new driver. The register
maps differ almost entirely, so most of the DT properties stay
per-chip (dim-mode/UVLO/ramp-ctl on AW99706, OVP/OCP/inductor on
AW99703).

Following Krzysztof's review, the AW99703 binding will drop the
ramp/transition timing and mapping properties and use the standard
led-sources and led-max-microamp properties.

That leaves the one common property, the maximum LED current,
spelled differently in a single driver: awinic,iled-max-microamp for
AW99706 and led-max-microamp for AW99703. To avoid that I'd like to:

  - add led-max-microamp to awinic,aw99706.yaml and mark
    awinic,iled-max-microamp as deprecated
  - have the driver read led-max-microamp for both chips, falling back
    to awinic,iled-max-microamp on AW99706 so existing DTs keep working

Does that sound acceptable?

Thanks,
Luka

On Fri, Oct 16, 2026 at 6:29=E2=80=AFPM Luka Panio <lukapanio@gmail.com> wr=
ote:
>
> The Awinic AW99703 is a high-efficiency 3-channel WLED driver with an
> integrated boost converter and 11-bit brightness control over I2C,
> optionally combined with a PWM input. It is used as an LCD backlight
> driver in some mobile devices.
>
> This series adds the devicetree binding and a driver for it.
>
> Tested on the Nexphone by Nex Computers.
>
> A board DTS using it will follow separately.
>
> Luka Panio (2):
>   dt-bindings: leds: backlight: Add Awinic AW99703 backlight
>   backlight: Add Awinic AW99703 backlight driver
>
>  .../leds/backlight/awinic,aw99703.yaml        | 131 ++++
>  MAINTAINERS                                   |   6 +
>  drivers/video/backlight/Kconfig               |  11 +
>  drivers/video/backlight/Makefile              |   1 +
>  drivers/video/backlight/aw99703.c             | 583 ++++++++++++++++++
>  5 files changed, 732 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/awin=
ic,aw99703.yaml
>  create mode 100644 drivers/video/backlight/aw99703.c
>
>
> base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
> --
> 2.55.0
>
