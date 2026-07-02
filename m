Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26385C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC2C10E4F1;
	Thu,  2 Jul 2026 18:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H8cJh/sV";
	dkim-atps=neutral
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7017610E4F1
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 18:42:10 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-59ebde7d704so761624e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783017729; x=1783622529;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L3E5kcG8MECRQ9InLZ8jdmT4IN0BYDghhEZtFSV6UR0=;
 b=H8cJh/sV3DuGoZbSzzhWJhK+DUvDS0G9j/0oHpvK1L9+ABdgKHhsJjItCWsotymHy/
 ye2ojM5bFoI12ZcUnHkf6BZzeUf/8DI7ijpA3Hc0ZotsYqKXV3fG/reqvSo5nQmIx0tF
 lOa0thcHBhLInux2MhzXkIzm1HB6eoWj5cWbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017729; x=1783622529;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L3E5kcG8MECRQ9InLZ8jdmT4IN0BYDghhEZtFSV6UR0=;
 b=djTXcIkWea2JLBst1OSu8Fjdb3OZStyhOA8h8x8gsneEdkpHoJtq+wxT08p1LsMmaW
 Vv3RkEj96F5tUdGj6l+4eP313gNk7PWqupYWTNOI3OLB3126t5LuMysP4vmo4swUy8gI
 NeJdBrqyzabpJv0U3Ed5D3CprD++7qnV1Es8e8hxgVozigVHJX05HAfTqYqv+AnozqF8
 QzFzZ7Ak3aSOni3i0gDfMmBCg8tomcRT1cXfohQ+zdpF7mx07ldXcmHCNfi+oeb9YOma
 KDrgtOZ6cehS/rW3UhTtHWn90vjvcYE1KwnvaS+BiSBKHYULn5ETbqeUi4gKwjVAgCaW
 DJhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOn9gL4rI71+EGu6gVhOUG5pxmbDXrP1GrqiJSDnD7cQYrQKyhEou5FXFo3GXpaDVhoVjDBQ151SM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7q9HJdKFVK0l2USlYPDlWGWT7rGQl3/Oya2RzxNX6VvNy90Pt
 mfJWuRlnUT0k7kxOMT5GnHZrI9HgJUCjRDfRbKDiIBrDDM3icxP8wF2oaydCQN7EJM/vkp23Stv
 cHXU=
X-Gm-Gg: AfdE7clnQVQ/5Qf2rsdoap/6c3WzYvxDGg2C/5zi5Mk7N+bkt1gU0nevJbdVg5ssufW
 K9YlVlb6JURMFCOk58y5INvhBU4gL4GMJ2LOsj4PQzV0h5AvgqI5xljmjZTQTINibhWjJZkDU/U
 7s7OIB/1xk3eVgJXIOPWshwXS6WAKa8XZWsrgWFRkUusuWwKpOwgvJZygacOOG37VreaNoFRDlP
 98d7wa2IRTYZ7QdH8MDjvW6L0wiOuR2AcNIfhhFKy9VzKcjRzVBOPh68vhMH4GLHE4e603e/soD
 KmZDGlXaeFRZCepkSe+Q+SSYJGEnqrIoUgmdy/2poUS73eq+C9fu5M/xcHEVu1fIVwF+JTRZWdV
 aUVIFeQ1kp6I7R1u1Ez0HBvIrjvp/U4ktrSQP0wujjX06Bq5lRudYmDI1bk4zwwsby3HYFK0ACX
 s4jxzFysA8WaduZadKRqPe+6vBaDEecipgpr7WKOwLmoQPME6Otc0=
X-Received: by 2002:a05:6122:4683:b0:5bd:ddab:59a7 with SMTP id
 71dfb90a1353d-5bde3b0d5d6mr2324114e0c.10.1783017729208; 
 Thu, 02 Jul 2026 11:42:09 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bdec7790aesm1366882e0c.11.2026.07.02.11.42.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:42:09 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-73770fd1b65so640766137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 11:42:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpvG9jhXvo4tAeMOzRnTmn0/qogMMd8lHTqHCU3b9BFGL6oW1N2yrmZ1W41V/53QBuRJnZ2+xfPwBk=@lists.freedesktop.org
X-Received: by 2002:a05:6102:e0b:b0:737:ba2e:8a29 with SMTP id
 ada2fe7eead31-73dc05b5f94mr2611709137.27.1783017727894; Thu, 02 Jul 2026
 11:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-0-8570e692143e@linaro.org>
 <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-2-8570e692143e@linaro.org>
In-Reply-To: <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-2-8570e692143e@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 2 Jul 2026 11:41:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VauZ=yPjkza9U0QEu2L6tMJb6BSC532mTwa-sqjRhAdg@mail.gmail.com>
X-Gm-Features: AVVi8CdHOFq8qwj17FSviMXPODi_RZqregPjBSkwFRL55bEIPJ8qnk_xiGuXBg8
Message-ID: <CAD=FV=VauZ=yPjkza9U0QEu2L6tMJb6BSC532mTwa-sqjRhAdg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm: panel: add support for the Renesas R63419
 based dual-DSI video mode Display Panels
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 KancyJoe <kancy2333@outlook.com>
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

On Thu, Jun 25, 2026 at 2:29=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> From: KancyJoe <kancy2333@outlook.com>
>
> Implement support for the Renesas 63419 based dual-DSI video mode
> Display Panels found in the Ayaneo gaming handled devices.
>
> Signed-off-by: KancyJoe <kancy2333@outlook.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/panel/Kconfig                |  12 +
>  drivers/gpu/drm/panel/Makefile               |   1 +
>  drivers/gpu/drm/panel/panel-renesas-r63419.c | 350 +++++++++++++++++++++=
++++++
>  3 files changed, 363 insertions(+)

This looks pretty nice to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
