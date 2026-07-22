Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F0EC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B2510EE00;
	Wed, 22 Jul 2026 14:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aP/+iRwi";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321A110EE00
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:28:16 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so8604770f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784730494; x=1785335294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lyxwzSpvGQN879gUQIzhLBDWPp/ka/KsPTZu5mIF37Q=;
 b=aP/+iRwiN9T100yliSY+K0N9v+b7xr+lXHCoGmvk2yX1DbEJElXeon1isghMXByYck
 GYSziuc2LnIimA9Fk9GTDgs0NU5ederOwM+ZB8wdqC8rkG8UFRXs2Ks/miMEn/0X/8mO
 7dj2iNbd9dlWUBZPu5OBvau35cHb8DbZWAa5H9BRQXpTE+aDuiGStM6KHFKp7WA3shLE
 MaJNggaTg8HUuqPhQ+y1eJlfBrD+jB2nGPP8oXHRha8lo70s1bNng9CrSO0rItNzj8De
 GIeQbRjR6sKbPeUadHWjqEKZtl2ty+kbGe2z0CV2uPwvYP5noVKP7lubThQh1FLzLaBd
 Z7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730494; x=1785335294;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lyxwzSpvGQN879gUQIzhLBDWPp/ka/KsPTZu5mIF37Q=;
 b=aMVUB1ff04Ubq+r+3Kq9EFHlf5mqjhkdPtqSRXoY/DyR4jBTtbBMz4SFm32ID81TV2
 tk7LY+aIYJaT1eGYcjQ0gSmJGVN2PHt5mGzG7NBBNPB+kOyH3Gu6q+qolu2N0Q1rRMdC
 H6GnyhBXqpwIBGT9Aap22+APKYA1FYfa0CHMkcs1RYLBcoBSd8YT5ZXeobaoMg6ONeso
 Zndow3i0Sfuhhz+etMv+35HFMUj5CeLUK4GbVPifgINy+vu51QPfvMJrwablm8L6U5yO
 FEybz8KdCR59KBvvGYIngmT4rAZFx3mRt6u++L75fbbDNhkkkrsGVedpIgJ9pq8bsrv5
 v4AA==
X-Gm-Message-State: AOJu0YyYScJXBpfeRw2uym5stl/a+BzbsyRyGr9oeEJrJGwlzJIXXpqB
 JGTuQAZvBWoGXpmE6sDifWx9uJY/G48azbdqBrBL5PJfyvDlQAhbs4otngozU1Dr13c=
X-Gm-Gg: AR+sD11I/avyDDUHLoGrgzazamnAKO79MoMYEtbeosiIwxvAz+mmx42d3qwdWdD7Pkr
 E22wyhczk731i8KuYtNOaUdvnfpRPDguInPRiRdB5q7mD66QDhRR9sA0F6jua4Q6t4oda8411tW
 RVkxKpCjgsulotFFY83lVKK9U8fdb9BWsO5Yby6kek7G6gjRtxiP/EBxf2rDAoyVefmWQ5GTCmY
 uY/sjkmQUTOJpRO4Z+xMNbtxy+cCsWL3WJmgIyUalM1Z5suGy4l3PPvo59tzbc6BRNQB/dBnjD8
 ca10R9TXqzGshAupIU2RDpYaeBnffaYo+Kkr6QKMswCFuhnHZcLCi0uf3DZ9+OoJoTVdoDqWoxN
 d6YFBNK1Dg46BYH7SeMfwIf8cNs1WWwwXGledAf/4xEfpUgnWDUKilh39NazTG/HQLpORvwlETK
 QJ7Ci8/RbANTkj9ExB+Et/9Ac=
X-Received: by 2002:a05:6000:22c4:b0:47f:81a9:3f36 with SMTP id
 ffacd0b85a97d-47f81a93fb8mr8233483f8f.18.1784730494276; 
 Wed, 22 Jul 2026 07:28:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm7095263f8f.7.2026.07.22.07.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:28:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A9dric_Bellegarde?= <cedric.bellegarde@adishatz.org>
Cc: dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org
In-Reply-To: <20260706051825.78752-1-cedric.bellegarde@adishatz.org>
References: <20260706051825.78752-1-cedric.bellegarde@adishatz.org>
Subject: Re: [PATCH] drm/panel: sofef00: Fix DSI transfer errors on
 backlight update
Message-Id: <178473049362.1948896.1910557231918245349.b4-ty@b4>
Date: Wed, 22 Jul 2026 16:28:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.1
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

On Mon, 06 Jul 2026 07:18:22 +0200, Cédric Bellegarde wrote:
> Backlight updates via bl_update_status() could be triggered before the
> panel was fully initialized, resulting in failed DCS commands during
> the atomic commit sequence.
> 
> Guard bl_update_status() with a prepared flag to skip backlight updates
> when the panel is not yet ready.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: sofef00: Fix DSI transfer errors on backlight update
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3367c5a129f74812806034fa0a106a1c3e4a3890

-- 
Neil

