Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0E8CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 14:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB8510E1A1;
	Mon, 11 May 2026 14:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hxgneHXX";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B3E10E1A1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 14:16:28 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6746d0b2b4aso6587779a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778508984; x=1779113784;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfsMbG4Eer7sZMCZCFbIEL3VNHRVu2j3STiQkCml3kI=;
 b=hxgneHXXCnGo7EUaLflCWGj67ceRfZcXAzfyVVzrLONaJ6Srxx8wHfVWUkjsfXKeep
 ObR5XhJu5mn/+/Ceko3T2GjoYBC+6TPAk8kGUNy7chzJ2KGQxTUDHlt/iuGcGqjXR3L0
 k2jvqnJc7zK6wZNHRpVdEi4O6nDBhOrOZacZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508984; x=1779113784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JfsMbG4Eer7sZMCZCFbIEL3VNHRVu2j3STiQkCml3kI=;
 b=ksFlvJ6nfL+8Pl8zrbfh/UnJdLMcOWOBm+VRs+bs7bCVhTiUcePcVSi6R7Xczch4oN
 dIoOdl5cxO14QuLXO80nZkmzDJx91l1iCtzLUJEElduPkcmzAFkI/leaS3roSIR0yfyq
 RfPxxaRz+TdbKLqxwq27IsUHhIwv4I/3Onx9GyXvexeXDg32k9AAAoSwRbKvyyIJbhst
 FqPPbX6xfzUTiplaSR0UUi6WcerpbNjfrPpXrtWQZaISgE8iU2sZ7eTLqee/0Z+7ncx1
 UQWrOINY4HLY6AMmAVjJMNuF6RuSGBJNLm2WDUM6htO8uB1OQPnitLKleSTHHZ8OfhsI
 h/mA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u/U3M2JzZYaVnqNXx8D1ZE8J6LKscVRC0t2G0EKt521LKQeWPWI8EPRbxnOjzNDkNpIUO85RSgyc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUaBI1+HdxQEoAdLUeYYLF/lMJ3bSJgFL6JQClaJ2C+WxXjkH3
 e3kuv/vlFB+Zxr2LfBr0FOGmUt/Hlyz8tF+BJX5BZ66BupKJ7Ypp0xDe3lpUbw57OXKDyJC6KaI
 TCowBHQ==
X-Gm-Gg: Acq92OGiAfMntLwaPLvFA/2BoLwQwR6YxEP4X9CavrOHAFh7zl2CdCleYRamVPqfOoT
 WbmDoqjzqqPLm+4n+LN4Nqe4RDWQFf9DnkXOszVK4AuaKbm2f5xrRd7XLpH4MM5IGLLUp/yx3IN
 mWPQadUCA9Vz8nn0jAqOBXXpEB0ZyjtGfeUsrkdiL6GrlAAemknsJxl0Hg3nmq6DR+oD9wdM2St
 CF07u+06uIbD+ckwBpEbnDOH2XfMNyRbxyfZEdngbi08qsibuI6yrO26T6G0rOu4D/bf/xWa891
 fpV017aqqZnDpwplBxrlSyGh70nRAx6oNA1d/oSKrhOA2qZ7d2VK3ZcEnzjqbw5TUexbaAm3GNh
 5/ABVU6gKos8EtMA3DQfXToj2TAuuSx+b8l1RODUjlBtfxrP0kB2/uYa8/q5YciowI59+TQ7Gzp
 tr2WLu99cnZp8ZAfvXQveTJACYi64FRWw11T1QHOidxNwCcopY6Z8fb/nrH6vVtA==
X-Received: by 2002:a50:fa8d:0:b0:676:988e:8eb6 with SMTP id
 4fb4d7f45d1cf-67d648a9ed2mr9220256a12.26.1778508984163; 
 Mon, 11 May 2026 07:16:24 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0b6a11asm3800715a12.8.2026.05.11.07.16.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 07:16:23 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso40160225e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:16:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/HofS4/rBpf+TjcRBnvNArXuGq96xILvyXW+LtO0BknMyQMT0x2dqolvAPnMyI4BZmkVSZu6riV3A=@lists.freedesktop.org
X-Received: by 2002:a05:6000:4210:b0:43c:f90b:5668 with SMTP id
 ffacd0b85a97d-4515ce1c6b0mr38986944f8f.23.1778508981410; Mon, 11 May 2026
 07:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260511095914.1200201-1-wenst@chromium.org>
In-Reply-To: <20260511095914.1200201-1-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 May 2026 07:16:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VGvJL_scfs18JgQs=fAX3yCnRMqCE71n3Kqa3QP8SywQ@mail.gmail.com>
X-Gm-Features: AVHnY4KQ__HGrnkqMabHjCRMKkeT6wyttBaAhBLmzxGWiGMn84Ov8anpLbkRJXk
Message-ID: <CAD=FV=VGvJL_scfs18JgQs=fAX3yCnRMqCE71n3Kqa3QP8SywQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add AUO B133HAN06.6 and BOE NV133FHM-N4F
 V8.0
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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

On Mon, May 11, 2026 at 2:59=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> These two panels are found in MT8195 Dojo, a.k.a. the HP Chromebook
> x360 13b-ca0xxx laptop.
>
> Only the BOE entry was tested on an actual device. The AUO entry is
> solely based on the provided datasheet.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

In recent patches, we've been including the EDID in the commit
message. That helps later if someone finds that they need different
settings for the same ID. We can figure out if two panels somehow
reused the same ID or if the original timings just need updating.

-Doug
