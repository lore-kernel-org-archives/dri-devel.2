Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5682DF436A8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26B210EA49;
	Fri, 17 Apr 2026 14:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ObEhZfDS";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3FA10EA49
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:20:32 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b9c11eba219so93310966b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776435628; x=1777040428;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WF2KIGB42Xjc3YOzPj5ZaZPEsgyqRdMzwPa2pnSHixE=;
 b=ObEhZfDSDOeQslyLCloHmddlJGfaRyQbhQkiXGigNx0l+aqZF46YqsDcpvFSchCTyt
 n8WLtbfqbXH4ssJqDTfnNWTNzJoxAqgDWqsJbpolq977YFB7PWsIVXYWUYZ0AhUaajYK
 oHks0CByloUFTD1lNGHhpvdXJUpYbB0CURdl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776435628; x=1777040428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WF2KIGB42Xjc3YOzPj5ZaZPEsgyqRdMzwPa2pnSHixE=;
 b=h6zOWqIvfn1i+DomNIvyHn1KqA3oRYWr4J8cVVbj35zp2ta12InQiI7+XvXsKAdSXx
 7WiFCeOyTa+/K7CtEUG8yhBfVy1aZHcO9vyVe+HdQT/+BAUnG9Q44MbEG2SNSv8Z9vzW
 CAi9vAsNAuDlohrDu0YKz7pmeP4e1q+4bNhI3HGZrZULF+C8u7+cogGHJfkX37Xh6tKb
 Z5D2UBMCXmjqawcNvt0n7OkkGLGTqPHp4aKUAN4BBDk13qhyv06LkDomC4CDQ+cJMfJ3
 mxPOuW0dbeph5FqLRPAe7V1ogRHHUkY22yMF3U14J9/lK0RJ4VUezfk2qavAxpiLqIJf
 TTcw==
X-Gm-Message-State: AOJu0YzpoX7r5JPMI9EoUypFjA0qUzxOcHZPNxRVMuaJVB2zS9X3nR8z
 MsafKMRdyIMp+EE0l6SPpPJU5dYdABpdPCqMjHJanf5ky5R4xAKnLT0BZJ5qHWMVKa9CmGLHim7
 dRfWKqyvY
X-Gm-Gg: AeBDieugLb4LBGkO1LyLnDowN0KnPgW2r2fDZ0TVD+YGEaZYlVqXCyxsRebeevc+EuP
 NsijDm+WWq3Ndwf42GrY+R27XnlecQgwmhd1YxJYVjRg9hpUWNB+jdas7Bb26kCM3+FJyAoEFKa
 +OY4kG5KZ7FmhHslmeSmPZaqhxKC6szrblOxsZZDZfMhi5rvg9wp6JcjcNnEpLhlEkB5SCLPHeH
 uJyroEQPlJksGQKdEXwubzYPfMKK+RBPizsdlvI4bUaLRrlJ4LOOlXSs856zA9TjLdjcNCUa/Of
 WQJ8aNJ3hzSfsryr+qT79c5mqYTjrnA5xqMpuHQy16ud1dB2OMTAc7iKOtzTJz1DZHzF3qem0YA
 LFW3lablWt7ICDsIcDmULtHdsLGXlYSOxCcSUYFN2gf56ixSuq0Pvk5tTILBy0K6cLbfHlzSVvr
 fOvUOUOb8CXXQyDOlmPLRjy7txec/XUS156ptDzf7lKClySP70DHNl7Tlg90jcyglfZVYhQmuT
X-Received: by 2002:a17:907:3e10:b0:b9d:9608:a4b4 with SMTP id
 a640c23a62f3a-ba418e8a6c3mr165482766b.12.1776435627689; 
 Fri, 17 Apr 2026 07:20:27 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba4519ee4adsm59483966b.19.2026.04.17.07.20.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 07:20:27 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43d7650202fso660654f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:20:26 -0700 (PDT)
X-Received: by 2002:a5d:4d06:0:b0:43f:e934:50ac with SMTP id
 ffacd0b85a97d-43fe93450b2mr254260f8f.7.1776435625113; Fri, 17 Apr 2026
 07:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260417061842.66631-1-avinal.xlvii@gmail.com>
 <20260417061842.66631-2-avinal.xlvii@gmail.com>
In-Reply-To: <20260417061842.66631-2-avinal.xlvii@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Apr 2026 07:20:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZcwd0esnbcav-udLDWmwaPFnnKw89B9kWqOJYtSKPQg@mail.gmail.com>
X-Gm-Features: AQROBzBBeuWhk8cb0GKV0Ter_n1VJcCiLr7LzsiZDyqWfVZ-HGm3GwuKC5hNE0A
Message-ID: <CAD=FV=UZcwd0esnbcav-udLDWmwaPFnnKw89B9kWqOJYtSKPQg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] drm/mipi-dsi: add
 mipi_dsi_shutdown_peripheral_multi
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
> Add mipi_dsi_shutdown_peripheral_multi function and mark
> mipi_dsi_shutdown_peripheral function as deprecated.
>
> Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 28 ++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  1 +
>  2 files changed, 29 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If no other comments, I'll plan to apply to drm-misc-next in about a week.
