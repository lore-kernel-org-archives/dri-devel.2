Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C78F436A9
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8043910EA47;
	Fri, 17 Apr 2026 14:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PxI97oA7";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0480C10EA4C
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:18:46 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-671ff4b716cso1213638a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776435524; x=1777040324;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBLkOis/Y7wc9LIqTxf9OXJ2CK9Ur406B2g2hN+Oxg8=;
 b=PxI97oA759d0pY40cGFjB63GorRFrrCRDVQAsm9bbTdDMAUxL0aRNZjncaEHbhQ3Q+
 Bp9KueMaONhVGScREefgOPTXjCaM5DgMoOXKz7UZvcWLGETlTsOG+nf7FS9QEt05SG6d
 gS/UMCeMjrj7qf6pKhHGY8QUHaz1n1+iytsik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776435524; x=1777040324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TBLkOis/Y7wc9LIqTxf9OXJ2CK9Ur406B2g2hN+Oxg8=;
 b=XtCZJzK/Zy9VVOU062fctqE2trCoO4LUdZiy41pIseSOQSSW682njhIUAgZdsY3LqP
 4HYabowTpLejrATGt9YMHOSoYwm48fSZca4QcWLsqQYTZ7zzmH+2z9Op3kRylk4/CFoC
 FzA2Y7tulID98qBWJdSKlR2a0+VQbIo6dMK0I6lEa+zv++NYd03zIl/ZSA3cw4aEoni6
 thiY4/uUzy0odz/ch4BAPbvsT1XDzUNKp+G8fLP+Sx0A2Qke4mgbclmI/VSDlAvhWUhu
 2iM9mL4GVbnxcJ6rde1IRepJIzJ9Tp7Hxg4SwFcyx2j4akxJx/Ses6OPU6rhip7i9MSa
 SW4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8pPFIyFu0xILmSaS11ylc12V8Mcf4tTBwh8YA/lg9u4xpLfBctDdAuEKsyvix5SpsWBFoEJA8jXg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsxrocppHs+7aePO6mtPtVYU7YMR03iXXoY4W6hrv16N5GOlZx
 tdcp0i5qeNbId8j8SfeHPJt+HnrURRL+Ux3koiJb82uFkzVgC+iHjkiATEieuJktwmh1B1iJwQl
 dwB6ZBhPg
X-Gm-Gg: AeBDietGSNhD+QppXP7YFeip1OvaTXG7F3I2x96XjjJVzz05nBUWGUWWLiwiS0WAFjW
 4DtVK1FWwBvO2dlrllzny4HgF3xKf6HRHtn8+y7RZxcOhPeqVtRlGoCHiT/A4Ee1EWRkQyuEo5W
 jIiIBe+pYu5wBognBTIeCtCAjH7dDKzOnLvcHSRKWkShIajT7q7+QDp8RDomLXJAZhEaAbOeOBp
 Q3DtZx66Zpecprs6+imZjBS0I8EhV5Rhc+DrjHOkzE+YfQxIDT4EgsHcH5/lYHRlhzphvicAK+0
 FpG/hce38IQORvRxBVE/jKURKDCKIh4L7t6DonjClO7hfsR65DCytng4BIiVG0pYPhdoGyNfvKN
 8yVbXh/mCKSoyvf3g9PnEkgfozi1Q8MvJo2wkrUdQpanzQf1F4fAF/exYOwZUjvNNmH509iZKBz
 /tzcyCzryjEYMXnX6nhXK3BfS8yO44hnKzMXL1oEub9PFel+e2oqaKYM8+DiDzj5J9d7UsOZFD
X-Received: by 2002:a05:6402:46c5:b0:674:1f5e:1b3f with SMTP id
 4fb4d7f45d1cf-6741f5e1cc2mr369820a12.0.1776435523987; 
 Fri, 17 Apr 2026 07:18:43 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c47fe836sm416369a12.3.2026.04.17.07.18.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 07:18:43 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-671fe205535so1407098a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:18:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ty1k527wFtgS7+1dmZfSZJ84Q+LQb4LmSL0LLDceHHOFhSv+syJMyVp7d0IuJ0kYKYxngpRPSBtg=@lists.freedesktop.org
X-Received: by 2002:a05:6000:610:b0:43d:7a97:78c0 with SMTP id
 ffacd0b85a97d-43fe3e0c65dmr4484672f8f.36.1776435057986; Fri, 17 Apr 2026
 07:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260417-axolotl-display-v2-1-8ce5341e46c2@ixit.cz>
In-Reply-To: <20260417-axolotl-display-v2-1-8ce5341e46c2@ixit.cz>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Apr 2026 07:10:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XdBFYuy353bcZdSFe=Jqdo8KEMpX7hnHFSvEDku=3ODQ@mail.gmail.com>
X-Gm-Features: AQROBzBL3aZ9sXCrwGMOK6DC1jFNqVtfqGIpTdfYDI67LSvB3V2OJLIsqYzGWsI
Message-ID: <CAD=FV=XdBFYuy353bcZdSFe=Jqdo8KEMpX7hnHFSvEDku=3ODQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: visionox-rm69299: Make use of
 prepare_prev_first
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
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

Hi,

On Thu, Apr 16, 2026 at 11:55=E2=80=AFPM David Heidelberg via B4 Relay
<devnull+david.ixit.cz@kernel.org> wrote:
>
> From: Guido G=C3=BCnther <agx@sigxcpu.org>
>
> The DSI link must be powered up to let panel driver to talk to the panel
> during prepare() callback execution. Set the prepare_prev_first flag to
> guarantee this.
>
> Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI h=
osts at modeset")
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Changes in v2:
> - Move the prepare_prev_first before drm_panel_add(). (Douglas)
> - Link to v1: https://lore.kernel.org/r/20260415-axolotl-display-v1-1-7ab=
b2d248355@ixit.cz
> ---
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-fixes:

[1/1] drm/panel: visionox-rm69299: Make use of prepare_prev_first
      commit: 4a92ef0c57df610ba0b2eb7f308c5472020ce8ea
