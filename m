Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24112CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD0F10F7D2;
	Mon,  8 Jun 2026 17:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S9yBGj+O";
	dkim-atps=neutral
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F048D10F7D0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:28:50 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-5a1490272bfso2995598e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780939730; x=1781544530;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hk++ENIyCkKc4FAdtYOAkCVOC2sKcyOmuoNX3OyqH8=;
 b=S9yBGj+OMiM3dfdyMJ2uDX1fYuAjieY2PYw9QThourOe+GS65uyc+ww/yTOqpep9Jw
 0iX09GcwbLJZq8gIn3he5Kuc2tkhOfhQfNlxC+5MnD91Pm4CuLXt99CDqmKzjyXlvK/o
 Pwuz44fksa2szRq+qA5HNgQ5/s2GLa1uvgrIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780939730; x=1781544530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2hk++ENIyCkKc4FAdtYOAkCVOC2sKcyOmuoNX3OyqH8=;
 b=TwTtoRIArcedI3IGJKmYf9YeLn61gXSkd9VTw9g/jPg9ekBtjovg2QdFNGHyJjxBJW
 Tk6IlCxpC39M8zkCJhpWCqc/N1VG035aXWn49ywJUXw3sWxSMibrETwv9T57uK0w6O+a
 3oEGiLjWnJNSXHIA8soL4uOfUs7JPFrLX3aMQWWxtqCfcDCAQKw8SJ2k5dXkk6zLA4ee
 40L0zY4vnu/jXMAyeHhdGBGKpcHo5exV1mz+/Q3U6eqFE7Pl5vwyA1eQOIBofsdWe2dV
 ulGTy5WiTysh3JW3oXrVGXK/ZwfljnXYTNoSjt4pNrePpDwVKIo+z+ndiCB3F75txFim
 6V9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QZKy5ryOawocKbYUh5dB01AAaxHi1IUAHKGepBeSo5irIeyiP5AlGPD2CHG3CkoY9KrFN+1x1dlA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJIQc96XQqm0cZ2ECqAR5Xg7F6qucXdJ6/vwXdwCJtbk0Z2mA9
 nKd/+LkhJd+7PBgf+Z8lb9KVJVGHX0ZyQ/ZYhbP7v3tkaA8N8QbUKgdFh7rdbZMxOSRypAJdbwf
 qxT8=
X-Gm-Gg: Acq92OEFPiWZ7NYl7hoQKomtMDMgEYw1NwplhANOgkMD9SnFH2aZ02rY3GbGhhtBPIC
 Dj+4hmieGJo1EQLV4CPSPpxSkFRTrjcT3N98Iv3s2VJsSaY4ImOcMWmazC1HCxuDw7Jg/M9fttS
 BmTyUk1HEBF6gRiW25QMpkRHYyV+7k/kD7s5EwS7DzuvQnQKCepw1L/g8dGETwGcYzoW59te3oG
 Hrl7vr5Ylax/MZRPotktMm+mAuGldZyXN2ZXcpaIGrO9sqbYX5LF6p5U5jdi5Wdt+iPrPttlZDI
 NB7oerA4OOG2/FjP5JYRVls4eDrVslHAVmW6KviCFMiXn+XpvT+QsDkGZJ1+oht5+0+V2t+bcVW
 nOPjuB/jBJePd42djjJuHHxfqYkY488jJmxRY4FbCiwpBGBaAiqApSq+EI2wuOEGdDJCo7B6sx6
 n4fsC6F0dwrOgLmX7dxAL9mpcPco0glPKu9jG/l+n1GfXyzxTG2ts98ejKUlx+lZ0fYWe6qsoQ
X-Received: by 2002:a05:6122:d27:b0:575:39bc:c6d9 with SMTP id
 71dfb90a1353d-5acd8174ad8mr6093059e0c.3.1780939729683; 
 Mon, 08 Jun 2026 10:28:49 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com.
 [209.85.222.53]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d6fb9ca0sm16688541e0c.6.2026.06.08.10.28.47
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:28:49 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-9638f7e9896so3652956241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 10:28:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+rxWklGx+1KTUJP6gjfKg3GyKDGx/10WFUDrH7oa09Uztn//4jERtKQLpoHt+KQT9GnJO/FseaGso=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5ef:b0:6d0:a5a0:ba23 with SMTP id
 ada2fe7eead31-7002b522935mr4351213137.3.1780939726669; Mon, 08 Jun 2026
 10:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260608080310.15126-1-terry_hsiao@compal.corp-partner.google.com>
 <20260608080310.15126-2-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260608080310.15126-2-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jun 2026 10:28:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WfH-OiNHQL0mLcQu1ts0_hx0-h0oZ48o_KpyioBR0YyA@mail.gmail.com>
X-Gm-Features: AVVi8CduR9XbAr_FLXnR9B9rHk0y54B8BodH9kX5xdR7hbEJ4x-rkZ9qQ7uq070
Message-ID: <CAD=FV=WfH-OiNHQL0mLcQu1ts0_hx0-h0oZ48o_KpyioBR0YyA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel-edp: Add AUO B116XAT04.3, CMN
 N116BCP-EA2, CSW MNB601LS1-8
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
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

On Mon, Jun 8, 2026 at 1:03=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDIDs for each panel:
>
> AUO B116XAT04.3
> 00 ff ff ff ff ff ff 00 06 af c0 29 01 ff 00 00
> 00 24 01 04 95 1a 0e 78 03 9e a5 96 59 58 96 28
> 1b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ce 1d 56 ea 50 00 1a 30 30 20
> 46 00 00 90 10 00 00 18 df 13 56 ea 50 00 1a 30
> 30 20 46 00 00 90 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 0d 0b 16 7d 00 00 20 01 d6
>
> 70 20 79 02 00 20 00 0c 10 d8 b1 c0 29 00 00 00
> 00 00 1a 00 21 01 1d 01 0a a0 05 56 05 00 03 88
> 68 59 59 8d 85 96 87 62 1b 02 35 54 00 80 00 80
> 00 80 11 78 22 00 14 0b 2a 01 84 55 05 e9 00 2f
> 80 1f 00 ff 02 19 00 03 00 05 00 2b 00 0c 27 00
> 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 80 00
> 80 00 80 81 00 15 74 1a 00 00 03 01 28 3c 00 00
> 80 2b 80 2b 3c 00 00 00 00 00 00 00 00 00 2e 90
>
> CMN N116BCP-EA2
> 00 ff ff ff ff ff ff 00 0d ae 6d 11 00 00 00 00
> 02 24 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
> a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
> 30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 47 ff 08 3c 7d 0d 0a 15 7d 00 00 00 00 04
>
> CSW MNB601LS1-8
> 00 ff ff ff ff ff ff 00 0e 77 0d 11 00 00 00 00
> 13 24 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
> 36 00 00 90 10 00 00 1a 06 14 56 dc 50 00 28 30
> 30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 3d ff 0c 3c 7d 0e 0b 17 7d 00 00 00 00 01
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/2] drm/panel-edp: Add AUO B116XAT04.3, CMN N116BCP-EA2, CSW MNB601LS1-8
      commit: 0de1a92e4e4d56998215c7b3c440882bb2c9190b
