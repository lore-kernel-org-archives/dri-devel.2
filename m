Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FE0C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE9210EDCD;
	Mon, 14 Sep 2026 12:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MhleVIJH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2753010EE17
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:24:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 111D440877
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5161F008BD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789388643;
 bh=9Kcpzbv4sy+y+lMrRNRsGoPP7pYgrKWSQtK1/OqMCU0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=MhleVIJHAcw2NCXPM0XoeqBl+JBMthKD4iYxCREkA8Wcs5jFsAXAj7a2ZIxdU5d9L
 wLcTbGwTxep2enKMsvgIcAP/lZQX5Z5Eror/SEujMcvh0o60WCs/NaCPKruJ32yuyU
 fzKcmqfI7XOhuP1tXg+MjGLCWg9JrZtl+1gP8BCZPS0s5M9BioLLIGfSUHQ8sDXvlX
 YtKPkSLSKZRLLX6VGME52Vyz/aZe2JHqtyd0+y0PEMYO2mSZiPlyO1cr+CssAyy1ur
 A43CGTixRrB4xC97gZW9lmM3rrD/aLH1N0R8gzg5LkjlEwb3kEg/c9kPFTm6Dg9ZYb
 XLepmjnMBHcJg==
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5b4ae0b3308so2295849e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 05:24:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByM6eGzT4X6ZUE4fDbH7b2NkCH3RskLXi7xa137Bn8XJdxrAVc+wFotjOC9TBuFhMrcohwcdkbdVXI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l1mY6x4sabn5CvZYzxSdhwlDac0VCcIVpB2pGB4t+dP05ipmwe
 QoTSzemH6ML2oigDdgvQxvUI14FWevve+Fc9O17LALEeGneQkdUXgiM6g52qGX9qh21fryq2h5D
 XCQDquBTeRfDWTRhEDMt/xIYivmEO0Xk=
X-Received: by 2002:a05:6512:3049:b0:5b6:1a7c:aa24 with SMTP id
 2adb3069b0e04-5b8ae6bcb2cmr617315e87.60.1789388640984; Mon, 14 Sep 2026
 05:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-18-2ab8ee24538e@bootlin.com>
In-Reply-To: <20260903-drm-bridge-every-panel-v2-18-2ab8ee24538e@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 14:23:48 +0200
X-Gmail-Original-Message-ID: <CAD++jL=4RkvV32h_h0LEnrxVGMJVDnhcfZGr1fFEfmtpeKZ1ag@mail.gmail.com>
X-Gm-Features: AcwNN1UcodghRtt57PT2sAfDkq57FKogQIfybizYVujvwIEMI2XIW2BAiCJLK1I
Message-ID: <CAD++jL=4RkvV32h_h0LEnrxVGMJVDnhcfZGr1fFEfmtpeKZ1ag@mail.gmail.com>
Subject: Re: [PATCH RFC v2 18/19] drm/tve200: don't create a panel_bridge
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
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
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

On Thu, Sep 3, 2026 at 10:14=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> Now a panel_bridge is automatically created for every drm_panel, so this
> code (similar to an open-coded variant of drm_of_find_panel_or_bridge())
> would lead to creating a second bridge for the same panel.
>
> Update and simplify the code by just getting a reference to the
> already-existing bridge.
>
> And since of_drm_find_and_get_bridge() returns a refcounted bridge, take
> care of putting the bridge reference.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
