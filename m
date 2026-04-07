Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486B7FD5F82
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B30B10E53C;
	Wed,  8 Apr 2026 07:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arduino.cc header.i=@arduino.cc header.b="UmfQXno3";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3611F10E0F9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:53:24 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488b0046078so20913715e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arduino.cc; s=google; t=1775566403; x=1776171203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8Ky7jN1vb219gvtLaR6stiV3r09kOF9IWgMsLPbH74=;
 b=UmfQXno3c9lgEiVXEHLC1LnKY7esQgUdN1fxhF5NqSQmK710gm8FwHkGnFoL9gILut
 fhnIq5Q56rYpJMdiwmk7o140+X/Lxwi7spN1pL4Xh7JGYRjqqjZ7QeNQETWp9+mTtF2l
 kKMLHzYzPtTWJ4FSZHT2SRAdzhixng6wpnwlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775566403; x=1776171203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i8Ky7jN1vb219gvtLaR6stiV3r09kOF9IWgMsLPbH74=;
 b=iBPJBimhwM4NJQZWsCHNpMf8UWws1tuXSY1yWd1oH69gWCLLY3FlxmyNPYaxnTAMPZ
 lNXIwF1HeaAZD5mcwrAyFNBCOdDDOp9ADlKXA9jaEXpnqReouQmPO1FIV5AGA6htdJIM
 qomHIq+qSaqQIjZT40C6acPF3rHZfZFWXAIrHCUa8m9oyy9LrcqhjErOfBPkXR0ydieJ
 6JGWA+aIqj/G6oXqOwItBmkwYUbdeCZT4krLOPJVBf4pZRgSI5BCWSoGpJfGpwb3+qrD
 xVKNm0Pm771pXZTP/OXNBWL7z0VGiUEDEAoMOOMRGQDQTzRRJt9Zt2j2zxha8H6wInib
 5fqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK3xSI7lRa7mfmvx0DFS8W0nlBJKTHAHbi2HeogRqW9bHz1AxX/Z8M1V6j9jxLwaeP9l7e/DYA7Fw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBQiFJk8/ha92LcpbgfDNzum1OUfS9yyEd2ATEPYHxEFMo/CIb
 dcaXeh+R2UgCHNo2GXPplEoXowOSZ1LUY4tU9McAWUvY8R16os18n24e0+w2Aygk0yM=
X-Gm-Gg: AeBDiev9YT884X9lmPEvr3Kx3NLaRFyq512ezCdUq+1D3dfw1Pd4+MdplTHkbMkrDQE
 +DslnPqFm1o8L/w6jhxW8x7uMGfl0+acbtaZI0tU0AvoVVV643a5XZgpeoDS0qmTC+cQB8ebkFw
 s0C6eOLcdqOJiNpJywfWxHA1WA6/CaFOjbAiXB7k3FpwXD+y1VNhUxIBS3YplTnsrj9XBRy08qH
 M+QmwxB4Ag3jiOaN2pdj/rqTsrgLlUpcWNZLB368oh3KCcQfIWalz/sFl5hlmJX+SE9Opkb1Qn0
 5xz0hx3kYykBgrRchq4L5mzGmKq7UWAe9ojm18P047mSmI4fX0KGGa/BCVoSNv/b9a/IyGGu7tr
 kubVv/bRg9NTP0NmQi3OpfHMJgT6GjR9KTZulH9HX1muWQ+1f/YS07DR0kppiKFp3PCvhnvfLF+
 4IXHJ1PWv/b+6gG/EWjy5Yn2HlYLJ6yaL5hhIZ59WAfnK0E0aPnEdhyzVY
X-Received: by 2002:a05:600c:4ed3:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-4889970ee1fmr245541745e9.13.1775566402659; 
 Tue, 07 Apr 2026 05:53:22 -0700 (PDT)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a221aa9fsm127567945e9.3.2026.04.07.05.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 05:53:22 -0700 (PDT)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: airlied@gmail.com, brgl@kernel.org, broonie@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jagan@edgeble.ai, javierm@redhat.com,
 jesszhan0024@gmail.com, krzk+dt@kernel.org, lgirdwood@gmail.com,
 linusw@kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 megi@xff.cz, mripard@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 yangcong5@huaqin.corp-partner.google.com,
 Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 18/19] dt-bindings: gpio: describe Waveshare GPIO
 controller
Date: Tue,  7 Apr 2026 14:53:18 +0200
Message-ID: <20260407125318.282288-1-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401-waveshare-dsi-touch-v1-18-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-18-5e9119b5a014@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 07:09:52 +0000
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

On Wed, 01 Apr 2026 10:26:37 +0300 Dmitry Baryshkov wrote:
>From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>The Waveshare DSI TOUCH family of panels has separate on-board GPIO
>controller, which controls power supplies to the panel and the touch
>screen and provides reset pins for both the panel and the touchscreen.
>Also it provides a simple PWM controller for panel backlight.
>
>Add bindings for these GPIO controllers. As overall integration might be
>not very obvious (and it differs significantly from the bindings used by
>the original drivers), provide complete example with the on-board
>regulators and the DSI panel.
>
>Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
