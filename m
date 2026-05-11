Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFF2CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 15:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3ECE10E7BC;
	Mon, 11 May 2026 15:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GRWptX7Q";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73DA610E7BC
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:13:46 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so2162679a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778512424; x=1779117224;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9pYvX3asH6XTX0dQ1uMh3EDUuzB4crPP1Ft5gtsnFY=;
 b=GRWptX7Qn+YMlNqpJAcmskt2JIWizVibEFwtaOLLTR/D1WzLkkVY0ScC6yvb4OUDZV
 EjuNUjf4J5HMRZfB+16/7f3h6cRYKTrropwgydIDV64HfP16w/CQhFCvntWxwtPLsIlB
 qxaZhV9Rc49ucILxCqQR42CAAkVxssdTBoaLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512424; x=1779117224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l9pYvX3asH6XTX0dQ1uMh3EDUuzB4crPP1Ft5gtsnFY=;
 b=Lyr0Ka/xq2WR9LP3JlhBW022P8XVhoKj270LBBSU8oRec3qsQE4r55hcAiIW2AtMRU
 OJx0vWyuqa0Trt/GJ4SMUU0T5CPrtaxmKeGekxSwrFwrRjvx/RZws2CaperxB0OsPduG
 4E5fwxjtkN07K8XBobjEOFc34cHvUBWfoR/fBszY6MqOHwOhhoOCeopZEK7Z4gh/W7Xd
 UXeQO5pP/CffjQusnUwqWZBTgQWVSb9QtvhEKYWOhzQo4kzHUH0UJDf7pnUwXkDYEhh0
 mYG9rS9zupUmlz5Ayc2RM40EJWp2XlR/3sZKBjLSNXK9LNfFFGPC4moDOsFFH3F9SDho
 B5tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jOHEZRNkFHbGigrPcJgy8Jvw4QZd6KFDDaC+hTQTbsMNBgfG7CeIyYvQl3Drt09yzjn2UXtipXKs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC0oGj5CQLVnK6P32sRXyb6ZBYrIa+xheyewZo0SGfffVwRIeI
 6DGea1aO1VuNXgeLG5cup4TtpMFhwrdJzRpTMUQsMTB0iUbE9BeMl3xmoh+3cB8T0aTAdJcuebm
 CgVaHZA==
X-Gm-Gg: Acq92OGdff88pbzdO6mtuzxoftjTLCtEFA/QowyH7UAsK62urrfZsBfwyH3dFsWBk4I
 JqIxQHS8Libuf7aOCJsUJCNpHwFBD7GQE6q61mM1xWKX9YBXDf+wf9aJZcuMUyLAZqYpcxW2H3f
 fi7ZHIhQSe/I5k/m+yL4cHEaQin9fDNnMDB4pmyE1C33SBlGfRuvC2quQcDeaA7YfK++zP15zje
 an9sRg8TJgJ/k8My1KfJxg7QoZK1Q2ZzeW533V+w5T4AnK5GmVr2LKfndS6IPy4Z22Vmjvv+aiU
 +40SfPO4BQ6HnfouyKg5g1UTkE9PODTWbMzRzpAetkJ0lzEth/jekHdNrZPEyKkoZGVsa2yDmVp
 lf3plJl5QWYQmTIoVtAsI3jCVh7kLB6WovS9wZe4FZf86wLW3FTc3URhNgGtQCM0C4n/7oxvaNO
 MKEDZ/nFXOB5NoPHx3YV5SPE1FLvgp4OtvMh/r661GQQLalqW8nCXG1bxL2y/DNA==
X-Received: by 2002:a05:6402:889:b0:67c:64f5:27ab with SMTP id
 4fb4d7f45d1cf-67d63d9b72dmr8722465a12.11.1778512423341; 
 Mon, 11 May 2026 08:13:43 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0dfd34fsm3882535a12.14.2026.05.11.08.13.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 08:13:41 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso2557866f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:13:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/3Gspu5jfj48n4KdOyFOHFicB2d8g2M/he9toluQ8U1o6IVrMexY0sKgj0RldlyJ4+69c1k7+Hv2I=@lists.freedesktop.org
X-Received: by 2002:a05:6000:4312:b0:451:2157:6291 with SMTP id
 ffacd0b85a97d-4515dc80b1dmr39799947f8f.41.1778512420550; Mon, 11 May 2026
 08:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778498477.git.harrison.vanderbyl@gmail.com>
 <44d976999b592fb4993bd95238e56cc4d9e228f7.1778498477.git.harrison.vanderbyl@gmail.com>
In-Reply-To: <44d976999b592fb4993bd95238e56cc4d9e228f7.1778498477.git.harrison.vanderbyl@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 May 2026 08:13:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJ_-OhOAnACsmQ3RzQgQ_0ip4HZU6Fv8hUN77sveQT4Q@mail.gmail.com>
X-Gm-Features: AVHnY4KsV6EE8Of350PAcbRuc32IkH8Mw1KggIyzHzpCciYVn1nsxyj9zV3Q38U
Message-ID: <CAD=FV=VJ_-OhOAnACsmQ3RzQgQ_0ip4HZU6Fv8hUN77sveQT4Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] drm/panel-edp: Add panel for Surface Pro 12in
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, May 11, 2026 at 7:42=E2=80=AFAM Harrison Vanderbyl
<harrison.vanderbyl@gmail.com> wrote:
>
> Add an entry for the BOE NE120DRM-N28 panel,
> used in the Microsoft Surface Pro 12-inch.
>
> The values chosen were tested to be working fine
> for wake from sleep and hibernation.
>
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Please follow the convention for recent similar patches and include
the EDID in the commit message.

-Doug
