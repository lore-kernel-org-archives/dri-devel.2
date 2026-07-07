Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAFBC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 02:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9184310EB21;
	Tue,  7 Jul 2026 02:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DTnjSMVr";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCFD10EB21
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 02:32:10 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5bdc96b0714so3157646e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783391528; x=1783996328;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hpzU4IzOiJcEhtdFeo7xYB0H/JZhSu55bWlqsKkTgM=;
 b=DTnjSMVr2/qKWAj3w2s6TYUUuXUQRwFp9uMYTpykMZJLevGRHE4mnL4FNUdZKmlQS3
 KWeKQlFqHwdUvAgweiKsUCYj1Syl4bJONfGxowUPpN1Jhc5EYT748Zue2Ef+SmAf3641
 niBahQAthlJUA4Qo+DW2v4Fh7QsTeZRo/NZWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783391528; x=1783996328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8hpzU4IzOiJcEhtdFeo7xYB0H/JZhSu55bWlqsKkTgM=;
 b=jkWukbaO5YgLUjEdEtyLeftpr4ZaWo/eI5hO64e7Fa1swH8Mpbr7R69yf7WghywqYk
 7To8QovlPHWsfI0dyvIButnvq+r3OEGXqzOBOjBjXaOUJnnTrh0T/m4oABXtSxA3CXzh
 1MvUjTCQ0tI7AtI56kTHgXx7QTTHrwHItXo+Nj/S04e5REC/Z+FDHxVxkPzsH/35k9nj
 EOvB7IOUkUcp34oyC2R1n+jI31nFZs0Eidkqdnoj3yV/rQDHhudBq9Ex+bH7HZli1xyD
 DNMUeW1WJO03Z03Lmzf1wlZaL1It3oHijf2O6oAdMN9a3ofEBWTgbRh8vE7MIC1GfLQ/
 eECQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsE9pqmuomUtvSMxmhC1bVjga/wvKQZ2M0KROwxu4JzwGjL+UeMLf1YXK11ppNIIBHUL39h1YQe3A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqRhIWQqXfRb0iWaydfNjEPuDikFEDK+w4va83xtDalt71hi9y
 le0oSDCuMNel1BYxggv1xZCgmQcsQq49t9tZZZpQ3qJxh0ItC7TozyubNuqokcS1jxhP/LfYfwm
 JDEs=
X-Gm-Gg: AfdE7cnNVPjT26bif66lYbRQZ8wXTb7buleWMCSo3fU0pzU1FC3fd0JPgdKeDaERGXN
 n6EMRcuJUKDz7o/7LQd0yoXQjjui4ov8j7qECNBmmC9aJKJk+Gbm7SMpqHcr4yj1zx8sfKigAtr
 3u2rKUFFXzgybIybhyrszzWU2OPBouYy5+2Ic3v6peDbCLbxCHqRXM7hkeVNf45XJAK6kv/nYjJ
 FZnwosOAVXsTN3h6s8h4VyVJbctvv+yAnZtEWScTzEPzS1aRF7UdLplfiqT7hB4HHiSsQSlv5Hi
 erkz3R7cCQNS8XEMcA0WrKYCBfDRtvY+qbUSfKbFtav1r22JzTtyCpV1eDQXqUZxLkrcNQ1Elw7
 OGh7ZJjIhQ/rHDOWdyBA2di26RmqHe4Whz+8NCR4YR1sc9f61nJcmG8YHqy3K5gFDDOBOXENg+b
 YSjuTnJiUU3t60A5D18dJ5emDaEbPrCeEvpQhNGIselNir7tP9xJXOk91CaYZv6EqKMQ==
X-Received: by 2002:a05:6122:8b0a:b0:5bd:c9f1:4f91 with SMTP id
 71dfb90a1353d-5be895396cfmr1963839e0c.0.1783391527901; 
 Mon, 06 Jul 2026 19:32:07 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com.
 [209.85.221.175]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5be0299616fsm6279389e0c.6.2026.07.06.19.32.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 19:32:06 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5bd742e0c20so2649641e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 19:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrhItdCJwxmAbA7PhomELlNQDjO5X7tHKS0zYYYj6cPJLX7A3Ash0blwHjbis+I8Cj2f0GPnrZwHkw=@lists.freedesktop.org
X-Received: by 2002:a05:6122:218e:b0:5a0:2018:4dfa with SMTP id
 71dfb90a1353d-5be89749afbmr1949268e0c.3.1783391524570; Mon, 06 Jul 2026
 19:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260706224414.1015766-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260706224414.1015766-1-nico.antinori.7@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Jul 2026 19:31:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UTtNdi_cUaqDXXWWFzZADh_HB=sJuZqKV=VB8tgFTwEg@mail.gmail.com>
X-Gm-Features: AVVi8CeklK9TVcONBAUOBdeOyJD3ulzKuDFRIZUSZ2dDsrDnn4NDm00o4a5te_Y
Message-ID: <CAD=FV=UTtNdi_cUaqDXXWWFzZADh_HB=sJuZqKV=VB8tgFTwEg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: novatek-nt37801: Use mipi_dsi_*_multi()
 functions
To: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Brigham Campbell <me@brighamcampbell.com>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Mon, Jul 6, 2026 at 3:44=E2=80=AFPM Nicol=C3=A1s Antinori
<nico.antinori.7@gmail.com> wrote:
>
> Replace mipi_dsi_* functions with their non-deprecated mipi_dsi_*_multi
> counterparts. This change reduces error-checking boilerplate and improves
> readability.
>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
> ---
> Changelog:
> v2:
> Implement feedback from the previous thread to simplify code in the
> novatek_nt37801_prepare() function. This converts novatek_nt37801_on() to
> return void and passes the mipi_dsi_multi_context struct directly as an
> argument.
>
> v1:
> https://lore.kernel.org/dri-devel/20260701125624.199786-1-nico.antinori.7=
@gmail.com/T/#u
>
>  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 110 ++++++++----------
>  1 file changed, 48 insertions(+), 62 deletions(-)

Yah, looks great. Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...barring anything else coming  up, I'll plan to apply in ~1 week.

-Doug
