Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34157FDEE4E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB7610F28B;
	Thu, 23 Apr 2026 21:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hHRlZOeK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627F910F28B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:26:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 854AD60582
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3F0C2BCB2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776979574;
 bh=QoQhslnr2VDDv4dJKxyzU8pClbacRNGZ6y9c0nTvw58=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hHRlZOeKFAljiXXH6X7AXE1TD3AOWdINseVHnhCIz6ZsdBOPUuwYkdaJOtmY8IHd3
 pYOBhsNYdUuGVUr2mFrZCP/cYpGZfMBPkBpmN6wpp/8ontKUCQvhmpT3eHYSRfGuvi
 uBdf5qzzKaPpsXsV/VpBeFtEhzQPX3E0bAH/sktULPDuwDR3keHhX1uaQ/6J6h2tYp
 9QiiOy3eAUW3/y+cl5nJH/Fg9tzs4O/H2X/UZs3XaDZ8QHX6VsSq0hOACHuiCm0e0u
 2b8VGFvYISf03NYqQpVdFMfB7PKADurExOMoWaP962uCLDDLBV68MJyuVh0FTzmF+h
 DJbepJSK0sksQ==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a40b2bc96dso8479530e87.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:26:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/fXAAblWBNLujiAVuEG3xiuP4UuSCQ7vpPZP5yTIJj6iuSGZJmuczHe1ACv/RTeIDvAUOJrbRawi4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMihavtyAL7xxcPXt7D/4MWOBvcwuG6LH8ywnqflgCpYjPm68P
 t6RMvDue069nH/GMbhznqav+9UZYTJMHWVPQwA2F/OHphsMT6bx3tzTVXB49mh6rEySRwK6L1ky
 unO4IguG54Weou49mbmy4/wy0oBMqrP4=
X-Received: by 2002:a05:6512:1302:b0:5a3:fe60:471c with SMTP id
 2adb3069b0e04-5a4172cb33amr10098495e87.16.1776979572944; Thu, 23 Apr 2026
 14:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-7-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-7-3aeb53022c32@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Apr 2026 23:26:01 +0200
X-Gmail-Original-Message-ID: <CAD++jLkRf0ehBr0CpCALJHL58gUw4954XzjxHOu8c7n7=b-bUQ@mail.gmail.com>
X-Gm-Features: AQROBzBtnhd6trpGrfIHMX-D0f7VMPVcAX7SFq928axT4eaRMtmMnoYhsxJIvXU
Message-ID: <CAD++jLkRf0ehBr0CpCALJHL58gUw4954XzjxHOu8c7n7=b-bUQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/21] drm/panel: himax-hx83102: support Waveshare
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
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

On Mon, Apr 13, 2026 at 4:05=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Add support for the Waveshare 12.3" DSI TOUCH-A panel. According to the
> vendor driver, it uses different mode_flags, so let the panel
> descriptions override driver-wide defaults.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
