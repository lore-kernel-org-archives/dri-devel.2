Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4F7F436A9
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEFE10E0F9;
	Fri, 17 Apr 2026 14:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R6BBqo9Y";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE58410E0F9
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:20:10 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b9c1da7ac63so155227766b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776435607; x=1777040407;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9WNva8+fPMs4ZhPA6hxnvQx8YInKuT95k21YIw24Tc=;
 b=R6BBqo9Yzs6M1mmxJxpBd95NIucua3uqX8L1hokvrzT99cG1CN/8wlJTdUrGNZZEu6
 m20Qo8rzJLw+mx4LwUpBuW/IqUPvSSp2p3cmkO4ePq2STKF2LHbawRAYfijiC+vB/S4Q
 GuLhSGnzj1q0m3luMlqICJyE88kqSF58869vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776435607; x=1777040407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9WNva8+fPMs4ZhPA6hxnvQx8YInKuT95k21YIw24Tc=;
 b=XXJgmkBmMNLydrquOHUpFxSiDsYPfaQXvHDymKgDJRHFdVgcS8F2JRzrCJCyDSS9Np
 b37XZCp3QfqnVWwlTO8XwmsDWPsnTP+i86Ki+SvkgK5oUMkWbuNqqspsAGzLSNOVIN3+
 QtIDcP3C3fE5a6v7ZHGIyxljqQ61S59d4VU8lDrMpX4ddWdTUkL/OQKTH59zKtac9Wp3
 XqNjGpVgBkssp7YKacGPOLUzFNJcwybsq18BRFzf2CPpj7DOnONvpiG2yyeCYr1H5uQJ
 yF5qXLc0JWBp3EFuGW3pa3h5YtizvCECY9Iyi9N5ypl2YIRcJOaXeIFMHtwBR0a0KFTn
 Hltg==
X-Gm-Message-State: AOJu0Yz3wzUnVhP1bZ+VxCco9ixDFtZ/dzdzdD6hZfcnXq3d4tke24ok
 l5KnPMkfUT4wDDvsx+IKzwwcqvaJQz0mP9HWwGdCbslMftU3tPjvRDx1+O4Wv9FrdmnsLYG0kZf
 2uwJJGTCu
X-Gm-Gg: AeBDiev/0/CLGsmLSUUdWCJJOPPtOhG6mNex8wemxWiyxhwKAikUE9VIU/n+D60By8s
 MlidSsTyBiJ6aNNbDxrMnixtHPJw7Fgf9cyFMU39MRi8zUy8iG72USr7w/4KpzZOpFQqmJOz1Pt
 dIzn+CWHqsVCP0sBzCDovcDfJiYS5sDOBWaO4goCjvYK/RalHK+8RXueZBsfEz+QwsKz4kL0yu5
 p8kuxMihJ7k89mCECAs9z9ke4LoD3O3wayz0u6HONzvpzr/313EYOSEm/zkttx/yV5xDjKQ4cUq
 3bSjbHR7e0fR/IXCBvbDQyVuY+mp668dNzqo7CASal6a3QueR5znPI4JJ547qNEkj2SQjhjrb6a
 60iTmUjP+T/FqGPZn/if8RrENKBHGpQob16siYCHRcWX8evQ/BK65T79FWXGhrbHJJPwaGVp/Kd
 fwUplYXkh+99xwKDVVg+4L/mL7IjYE0oEqLytWm4ohlynhtLK2GNUHkemMGyv93I4CLDMvGap2e
 hdRuIeThFk=
X-Received: by 2002:a17:906:6a19:b0:b97:6147:def1 with SMTP id
 a640c23a62f3a-ba41a53df70mr161217866b.33.1776435607044; 
 Fri, 17 Apr 2026 07:20:07 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba454d1bab1sm57814766b.35.2026.04.17.07.20.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 07:20:06 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so123092f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:20:05 -0700 (PDT)
X-Received: by 2002:a05:6000:2289:b0:43c:f793:f1c5 with SMTP id
 ffacd0b85a97d-43fe3e0c63cmr4793740f8f.34.1776435604948; Fri, 17 Apr 2026
 07:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260417061842.66631-1-avinal.xlvii@gmail.com>
 <20260417061842.66631-3-avinal.xlvii@gmail.com>
In-Reply-To: <20260417061842.66631-3-avinal.xlvii@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Apr 2026 07:19:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WdBa-Bmq_9xGPQASc8-kjmF6xcQ1zm_NVdqH9nRaMoqA@mail.gmail.com>
X-Gm-Features: AQROBzAuFFMYaiHmJ67GwTB84vqkf5vAP3n0WYG7YG13RUK3Sf7VD2Er5DS8zEE
Message-ID: <CAD=FV=WdBa-Bmq_9xGPQASc8-kjmF6xcQ1zm_NVdqH9nRaMoqA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
To: Avinal Kumar <avinal.xlvii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org, lumag@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
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

On Thu, Apr 16, 2026 at 11:19=E2=80=AFPM Avinal Kumar <avinal.xlvii@gmail.c=
om> wrote:
>
> Change the panasonic-vvx10f034n00 panel to multi
> style functions for improved error handling and
> remove redundant error printout.
>
> Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> ---
>  .../drm/panel/panel-panasonic-vvx10f034n00.c  | 24 ++++++++++---------
>  1 file changed, 13 insertions(+), 11 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If no other comments, I'll plan to apply to drm-misc-next in about a week.
