Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D144F8E497
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B090210E274;
	Fri, 17 Apr 2026 02:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbLeyFqu";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C637E10E274
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:52:02 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-672bd7d00bdso242227a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 19:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776394318; x=1776999118;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTuvhIqq+xOjV+LaK0yDBZkMyTcwlBJ7T7JtwvUdAJA=;
 b=UbLeyFqu6oTS5kYbFXxAsBErsH5s+kcsd07qQ8sSTFbqbMQzhIxQIwoaKjNp7xkrZ2
 YJC4mA9ZESVEVLAZFg8y8tYuGk984xZ/mawc06BznaTK67HL58NgB2RPb764oLF60u48
 rMfz3T9ndI4MmXIp7hDFETJtVslkJ8CrgSFLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776394318; x=1776999118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QTuvhIqq+xOjV+LaK0yDBZkMyTcwlBJ7T7JtwvUdAJA=;
 b=ROujmmsR6vHlbtTqEjVKlmmgiZbSztxxJXFkH5/FhtJxTHM39ZO4HCLYy4YhpVPJ7m
 xv1bl8RLFt4VoUGIdGK7mxfZVc6dCGlGBCcPkzUU6fAfOlGO2oyF4GdQ2W6B83GCPq3T
 inwVYwH3WJ9LZMPyj8nWafBN1Lhjti+MDjg7vcMg8w64puj8XsdKbA6R3pcOST/DKuBn
 1vFo4XOB/mE9/jqme7ACEvTuD07GNt5U1BaOr6mJKa4A9Q/loS+qXhxuNRX3+fA+lOhc
 G8890GhA7EEOmIMbwyPuEX++ifyzB9CqOe0ckYQ/tmeln/5bPTTQXkfHfLb+aajGfSFA
 MiLQ==
X-Gm-Message-State: AOJu0Yxm13eEvIWdi+t39kYGHnjzppQvEtSiSw96VH0QsPdMbseRnNse
 dTiAHuwWZTTo7mH4tVksHlTbdbMcbm+w0bj+GiUqr439tH5nuhPJGY7K8o6gFnfsqHf7oAy/tuY
 eU6o9AQ==
X-Gm-Gg: AeBDiev7UN6fM+tA5OxLEOWHtxK8RsPDEz4wUTefOyvh+W1JY3PwqD6j/RJn9QqPfO7
 gXiM+p8LAvdZzIi6xf3MGREl3LqYTNDG0F1YytLw+QuNRLjifmR3tFjetdvyOhUlJ6g7ycIr21d
 26sMg4CJoKYU4shFXoD9vNgmIqu/yctLGA3vxXYYSF74vRk0iK6kyhueOBD2XFFpUMvM7mKCmwK
 R2AxcP9a9C3GLHwX5bFaQ6GPUI20RprHw0b0RftZCPyphnqNZvsWWSCWIfH3tnnLnmbKsd8s10K
 Ty6lKFlfVPWY3DpIwHaVpahB0YX+Ueqw6kNuYGZo+UTXGIokDN7SXrmREgn8v9HXyGIvHR0Qg02
 Vs7mjJnhsTv82acTsRSFuOQFUHRu+z5RIE8Q14+i8KadYnDbAmv4slK646yTigxQiU1Q069IPI2
 N2zeXnaA8hxi/l2dmqY1+ZbwRHAUr2uL+zmyfQVJZx2NO9BWurkN9QsL4toiC7RaCiwRvKTeu6
X-Received: by 2002:a17:907:3c8e:b0:ba0:d678:f273 with SMTP id
 a640c23a62f3a-ba41887acd7mr44299966b.12.1776394317945; 
 Thu, 16 Apr 2026 19:51:57 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com.
 [209.85.221.43]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c480e21fsm30161a12.8.2026.04.16.19.51.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 19:51:56 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43d73422431so104239f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 19:51:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2212:b0:43d:1bf6:30f7 with SMTP id
 ffacd0b85a97d-43fe3dd50edmr1257550f8f.18.1776394316099; Thu, 16 Apr 2026
 19:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260416073722.719036-1-avinal.xlvii@gmail.com>
 <20260416073722.719036-3-avinal.xlvii@gmail.com>
In-Reply-To: <20260416073722.719036-3-avinal.xlvii@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 Apr 2026 19:51:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xu0YY8Aof2XPp2eAe+hSd7P4UaPCqVZkkox4gYNW_pTQ@mail.gmail.com>
X-Gm-Features: AQROBzDxLtyO9kIdMgkJS9jKSPv4ly4ckAcTtdrsiWhorlTP3fNL6KSEcPAGb98
Message-ID: <CAD=FV=Xu0YY8Aof2XPp2eAe+hSd7P4UaPCqVZkkox4gYNW_pTQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panel: panasonic-vvx10f034n00: transition to
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

On Thu, Apr 16, 2026 at 12:39=E2=80=AFAM Avinal Kumar <avinal.xlvii@gmail.c=
om> wrote:
>
> Changes the panasonic-vvx10f034n00 panel to multi
> style functions for improved error handling and
> removes redundant error printout.

nit: Linux folks generally like the "imperative" statements. So the
above would be better as:

Change the panasonic-vvx10f034n00 panel to multi style functions for
improved error handling and remove redundant error printout.

In other words, use "change" not "changes" and "remove" not "removes".


> @@ -95,7 +104,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *pa=
nel)
>
>         ret =3D wuxga_nt_panel_on(wuxga_nt);
>         if (ret < 0) {
> -               dev_err(panel->dev, "failed to set panel on: %d\n", ret);
>                 goto poweroff;
>         }

Now that you've removed the error printout (and thus it's a one-liner
inside the "if" test), you need to remove the braces. Linux style
guidelines are pretty strict about this. Hopefully it's pretty easy to
spin a v5 with that? Otherwise, this looks fine to me.


-Doug
