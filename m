Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828F8C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88BC10E78E;
	Mon, 17 Aug 2026 12:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MklBO1Xj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA5810E78E
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:23:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 239D2440A6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3E51F00AC4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786969424;
 bh=Bbzx0FzVFX3Xe372DKm7lgFtE/ShVnE8KPvINtEMpXI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=MklBO1XjT8D01gI6GyEwnsxj2IFN7BL0qsphNO78HxnNKdD4w6HfbztU7dey1KYpR
 794BLVE0s4/m+rdkyBqGA3dZKMauTalyVdjcUI0lhQVyt/2Mhyb676RhhzqdOeTm9l
 YFbRGwkfXrqDp2fhgDevNhtT/PDtQpWXbSYR+q1CoX1XgzLRgEOYhJqAXzilYD1pud
 Rjwb8aFGioz7AioMAwe3izwTfmmKpiCHpcxAriZbYUSTRbb3yYphlMf6n4PMgvd7JK
 wvnW6VgOTJGNjc+2suVjTsxgnlY2FQRO5eB5HN3zZKcEaQgUW8rIMad9wlkV/0ha3x
 SbocU60a4lGyA==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5b45f2e5f58so1854727e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:23:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqHb1bnA5FHaPtx16b759tnZztPxaTeM/EjRUe+IiJ6r13+xRDigvjZhM6R+WNOSSMY7bwtpQdKX3U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4DKHHYQQwdjuttM95yiac03PkuzKtTgY+muUewnINBN60OzWz
 ZDmmtNBvWl73v+AKKnvP/C/Nm+EMNridDiOidoAz3nVq+g2N0QPb2NXDyuoq9Aprywp+GPPGTNy
 QJ1/2hfF1/r0ADnBKnBWv6qXglMM+D8o=
X-Received: by 2002:a05:6512:8390:b0:5ae:b6b1:5fcd with SMTP id
 2adb3069b0e04-5b459156d4fmr2875340e87.10.1786969422711; Mon, 17 Aug 2026
 05:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-9-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-9-19cd5277cc8d@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:23:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLmRktSqXBS8_-diqMCzMHjrjYbF3e_Vc86KSexGRmfvag@mail.gmail.com>
X-Gm-Features: AcwNN1WNchpzee9oNu6myWD2zIGRbpHZhPHdAy75jmnzavlGP_JyHFeNvrQ0Yr4
Message-ID: <CAD++jLmRktSqXBS8_-diqMCzMHjrjYbF3e_Vc86KSexGRmfvag@mail.gmail.com>
Subject: Re: [PATCH 09/11] drm/mcde: dsi: don't create a panel_bridge
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
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

On Fri, Aug 14, 2026 at 4:07=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> Now a panel_bridge is automatically created for every drm_panel, so this
> code (similar to an open-coded variant of drm_of_find_panel_or_bridge())
> would lead to creating a second panel_bridge for the same panel.
>
> Fix and simplify the code by just getting a reference to the
> already-existing bridge.
>
> Also keep the "connected to non-panel bridge (unsupported)\n" error logic
> by using the drm_bridge_is_panel() function.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Looks good to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
