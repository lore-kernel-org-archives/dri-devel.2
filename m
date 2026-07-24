Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E1CC531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7060E10E618;
	Fri, 24 Jul 2026 00:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dGJ9B1HG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D256D10E618
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:10:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F1A5409AC
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8389D1F000E9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784851847;
 bh=LjacPsdtNV1p4l/sQfaVOtYLfOgONtMJVT+kTLVOtKI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=dGJ9B1HGGr9MTYXoXXfILTJqaNWoaeaD6lEYSc1YBjJvZ6yLjbxkSHOpxrnvf8OVZ
 aWWICcJ9JNVuXbLTVL1Xnkz05JKqxTFpWdIgociO3UZTOX3G6INvnh2CPaBDh7z2hY
 0BKOrbqqPlkLRqgU/ssukTWRdWc9wPFVW+7N69pblRtxf6u7ct7fLM9UmqMKl1QTPq
 pbAxq04PLyG454o0qSi7RPqT+LrcmxmTqYckUQ9M/J6OVxy1DoBHJImXz4PvsG72yR
 NXpQ4p1uhqnik1c5FV/Nn21nNDs+C00R7MGtPgNapsd9BodOAfrHNdWX6nGPCp4ldU
 sO1OLLEIKs8AA==
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso951040a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 17:10:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrEzGucXnIupQw+mF1kTDhW5KilX1MFkZWR+tlI9OzbxEJ3j9ZVp4aO9I42An2ZJYLzoTc0BqOWuN0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxYz4fVU0r7mOiw8xwfwLdkUd4byIU+2/czIlBWWfMMhtIpXl8
 WXlj/qbXQ2QYAu+sMYAxEgaT2NlMEvpDt2pwmujMfwavSEUtAtl2YZzTuJsrEJ9YAlsmYbd6U7y
 O642UzL5zknrPbHsM2lfEB6F0bCBtkg==
X-Received: by 2002:a17:90b:1642:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-38ec6a51c61mr4741746a91.20.1784851847244; Thu, 23 Jul 2026
 17:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260716132103.1564995-1-johan@kernel.org>
In-Reply-To: <20260716132103.1564995-1-johan@kernel.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 24 Jul 2026 00:10:34 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8+u-yswp+Gsj1ZnaJWh3fZ6Ndxd=JeUie7ZVG1pBYyeA@mail.gmail.com>
X-Gm-Features: AUfX_mwvrzL8b4TzBdDrdHDueSyF33BvYJFwjoUH9n9UYcfPUact2O614SD6X6A
Message-ID: <CAAOTY_8+u-yswp+Gsj1ZnaJWh3fZ6Ndxd=JeUie7ZVG1pBYyeA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi_common: take i2c adapter module
 reference
To: Johan Hovold <johan@kernel.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

Johan Hovold <johan@kernel.org> =E6=96=BC 2026=E5=B9=B47=E6=9C=8816=E6=97=
=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
>
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
