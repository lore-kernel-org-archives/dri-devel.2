Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF9CC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F4810EA61;
	Sun, 13 Sep 2026 23:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DIuwo+91";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF7210EA61
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:34:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1373B61028
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F431F0089F
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789342438;
 bh=zng3/lheQcHYHRf6apSQbhsdybFIgxHykd4cCeRSALs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=DIuwo+91E9j6P8gcffxeTWibtVYK84E/K0zWh6s/Yed5HdTiBGh4yJD4g8Yy7YMzp
 Zmb9UrM8SFiukhfEjKlqn74cChv71bxCDBhiCj/l/UQfge2Dm3qkgzsFbSGyqVSqpp
 Udm+lm2P+eabpV3YMbxtjsRr06pb7oVPf73ngoGqP6jy/KVGDLhpFrdPO/yuSXNhqF
 P/mNOKNoJ2KD2X8EoD31TZAHK6RsTWpDJuSUh375d6tPe7PrV/jmdpTbTzJGdzxjb1
 iEp1c93xdl5nZIFDK9qu4pTXYFgqdfiS/ApZ0qsmVcVZZzCDaVwmiBwLQzxdIQXZR+
 f0lsIW/5EvTVw==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b7be8dbabfso1018361e87.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:33:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzFHNmQ9rQnkD5/3pyAirPd4kKq3LicUSJzYshrbgdj3vfko1BrlfYw6dtdbbde9fG0O0ybAS0s9/4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kuDULOTAg9b/vvcXMZeRjoMCfVfwfJfG3ITNv6rc2+grecxwI8
 xtXtwmbCiolb+tZSRnd4iAeyhy74tIs/cn4bNsWOHIwOsP0tNmoKLUhaotgCJBSQPhRJPwabsw5
 ysMu50puXygX+ij+AsvSNMObvnVJrqIc=
X-Received: by 2002:a05:6512:2204:b0:5b8:9a2d:38d with SMTP id
 2adb3069b0e04-5b8ae8a73aemr7507e87.56.1789342437102; Sun, 13 Sep 2026
 16:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-drm-simple-kms-removal-v3-0-cd5dc89858c6@oss.qualcomm.com>
 <20260727-drm-simple-kms-removal-v3-4-cd5dc89858c6@oss.qualcomm.com>
In-Reply-To: <20260727-drm-simple-kms-removal-v3-4-cd5dc89858c6@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 01:33:45 +0200
X-Gmail-Original-Message-ID: <CAD++jLnN-dhwxWwgmWYVD7COhvVsTxbiexHwoFkzgv8ucGhxqw@mail.gmail.com>
X-Gm-Features: AcwNN1XTt4ClabPMabRSeCfNHr3d8Y53WJSzGM-8HBGT1SAK6TVjQKD-jMPJbKA
Message-ID: <CAD++jLnN-dhwxWwgmWYVD7COhvVsTxbiexHwoFkzgv8ucGhxqw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] drm/pl111: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: Ze Huang <ze.huang@oss.qualcomm.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 xen-devel@lists.xenproject.org
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

On Sun, Jul 26, 2026 at 9:46=E2=80=AFPM Ze Huang <ze.huang@oss.qualcomm.com=
> wrote:

> Replace the PL111 simple display pipe with explicit plane, CRTC and
> encoder objects.
>
> Move the existing timing, format and pitch validation into explicit
> atomic check paths. Use commit-local plane state in the CRTC enable path
> when reading framebuffer format state.
>
> Move page-flip event handling to the CRTC commit path.
>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>

This patch 4/8 applied for next.

Yours,
Linus Walleij
