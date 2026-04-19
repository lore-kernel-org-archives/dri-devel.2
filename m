Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F003DEA719D
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 20:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 500CE10E3FE;
	Sun, 19 Apr 2026 20:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bdqXyam4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB7710E403
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:18:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 83C496013B
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E20C2BCB6
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776629924;
 bh=OLw+eRHqgrO4zkt7f8sg4S1N4ShOJ80xQG0TYWK7Fzk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bdqXyam4T54s0JFglAzKfobk/dK1aCbxutS+oHayTXXfHKcPGoDxQSMfQ2+tnWYos
 yR7nqQ7s0ulRQyYnm5pURSgZqYKFsE560VmQSLNFXuaeT1M7TfmsgMVgf8/0GYmyZp
 k5DDFFuiH5lFoR4vtuFe34Dt/vEmLsGyGsibDClZH3AFBmbZaEAkZbn2Hfym2NPHTZ
 N6FZPe025h7lf8IKuJwgm+DkE1X1JiCaVvGnC4OWPVanXkrBfraJtBbGQ0PamLUhfO
 SmzgbIcDxVRq86SrH/U9LSiiAboftYMCNUC2B/neKQxfAvX1GiOX35ElYtpxWSVOQ3
 +ayrGo2jnsu1A==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5a3af1b7549so2948435e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:18:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/BUfDjQ2eFGqbRv0qgHLI+40SJJJQql3CVJXLiUcY0jnhwbXO5jSm8o29mukKwG96Fgr3AuXvJhfM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFH/vUBjCh16rKi33fq0jQGdTb4S872UW0Ob3EDZnr/bUTfRdf
 fY7akKZBCHNJgDGJ9911f2tVh3Q/XAhFCp5jCfc36d3NyVSQp//PNRTW7M0iKuRMpHDTJIcuxx1
 p2AkYxQRcdr7pudYCk0dhrBobLb4Cys8=
X-Received: by 2002:a05:6512:6d0:b0:5a4:1b8:1a92 with SMTP id
 2adb3069b0e04-5a4172e7c28mr3289204e87.21.1776629922903; Sun, 19 Apr 2026
 13:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-7-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-7-75cdbeac5156@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 22:18:31 +0200
X-Gmail-Original-Message-ID: <CAD++jLkfBhdhhYoPwGEt4XghNGuLFaMEHsKPbjEoFGZv_JJiKg@mail.gmail.com>
X-Gm-Features: AQROBzB3V9CUelEnoDXtHgFP9-TRM15zDUUV4XVkXbwM8iX4PWyJW-UeLgVME0U
Message-ID: <CAD++jLkfBhdhhYoPwGEt4XghNGuLFaMEHsKPbjEoFGZv_JJiKg@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] drm/panel: himax-hx83102: support Waveshare
 12.3" DSI panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, Jagan Teki <jagan@edgeble.ai>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org
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

On Sat, Apr 11, 2026 at 2:11=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Add support for the Waveshare 12.3" DSI TOUCH-A panel. According to the
> vendor driver, it uses different mode_flags, so let the panel
> descriptions override driver-wide defaults.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
