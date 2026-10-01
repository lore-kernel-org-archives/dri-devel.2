Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64CDCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FBC10E1CC;
	Thu,  1 Oct 2026 06:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cAgppL2M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB0C10F588
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:57:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0B4443E2D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC4A1F008A7
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790837851;
 bh=+vEDDkcFwBHCvKCzpx6c5APxZ16rpEBRvEPSZ/ZRrQc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=cAgppL2MTf0dT8UdP/8BSRxZkKtLz3ainVz+6sGytzZJybPbPpKqnMWYPAqNIttgh
 R6XWoEkuOOLBcmhF/TFbfeQ+wCaZq8Cr6M7jATMCZxXOJ3egSUOQgnuNI+MeIRTWm9
 B9XXohTvkaRCrHlKnVktpnIOz2I54mpq992J9308jdQZM/xSkWmlt43lbnLGY5X0rL
 Iw5GZwZ6e10CPf0NIytcmld5Dsosgk114rQItDxVgnuCIHEMk81bRxfS1cR/GuasjJ
 ZC13CpY/8shizbuSo9HFGAgn9jj3f8PTsVj+QHEnXkKb6J3h54U7eK1NPM9EBg26hk
 bKTpVYYjUH3VA==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5bb54bd5076so128363e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 23:57:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwalwIvc83EShCrJKoZwwiPP8OWa3CyjEojCYIsO4dzFlPDkh/Z052pZbz/H+O3mzWFsKvAsVYRp7g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ5JsRYmZK/hGIVezrAdawtKxe+VqibntvuM/UH4qoXPDWNrtDm
 QGqqnMzjMe6fczgyZ/4cqrh99VwOyWEwbSuMl6vBdHojiuU7bpO3zukwdeUjI03bkvNPC4aVPfw
 pjhH259iL5UJI2/+QsjwP2ehqd+tMrG8=
X-Received: by 2002:a05:6512:669a:20b0:5bb:783a:72ac with SMTP id
 2adb3069b0e04-5bb783a73bdmr66950e87.16.1790837850121; Wed, 30 Sep 2026
 23:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789994813.git.osama.abdelkader@gmail.com>
 <66eccc200bb4f5e26a3464a46448b1a4c03b53a6.1789994813.git.osama.abdelkader@gmail.com>
In-Reply-To: <66eccc200bb4f5e26a3464a46448b1a4c03b53a6.1789994813.git.osama.abdelkader@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 08:57:16 +0200
X-Gmail-Original-Message-ID: <CAD++jLn0sVWy4E5aksRXrVqpHA5ayK_EhD2MgSi1SZsZascpgA@mail.gmail.com>
X-Gm-Features: AclHuK8o8MoLB-ogaYd0O7Ruv7BqFzDty6wVukicfWiBSFsjsYqIvJXIMV7AZQY
Message-ID: <CAD++jLn0sVWy4E5aksRXrVqpHA5ayK_EhD2MgSi1SZsZascpgA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] drm/panel: Use managed helpers in Novatek and
 Raydium panels
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Robert Chiras <robert.chiras@nxp.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>
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

On Mon, Sep 21, 2026 at 3:19=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:

> Use the managed MIPI DSI attach and panel add helpers in Novatek and
> Raydium panel drivers and drop the corresponding manual detach and panel
> remove calls from remove paths.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
