Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21CFC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169DF10EE71;
	Thu, 17 Sep 2026 12:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Q8/fUxOv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614CA10EE71
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789647329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZFYhEhHWIHNXKUGiHbv+ydyuO6lOjysOTH2X16TZjw=;
 b=Q8/fUxOvYaTv7G14tVmAYuQ+fW2PNp3pRxOAjMn5f4e3yLxkxoftIhJLeaTlx1TSEhB4Yc
 GjiaE8cwpjwp9AK2sTUW74s1OoZUCpi2k0x4lIj46ECK7UUNTU2x9ck2fNuySlFvNvvvVb
 fOAB4+JFQDgka+hQR1VTgxArvnRIJVE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-rQvvUQX8N3aPnWrzssjhhg-1; Thu, 17 Sep 2026 08:15:28 -0400
X-MC-Unique: rQvvUQX8N3aPnWrzssjhhg-1
X-Mimecast-MFC-AGG-ID: rQvvUQX8N3aPnWrzssjhhg_1789647327
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4e496e5c3so657146a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 05:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789647327; x=1790252127;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZFYhEhHWIHNXKUGiHbv+ydyuO6lOjysOTH2X16TZjw=;
 b=qGT0eCgxqW/0t3AiwwhwYMAc9f5i4OrzvUc7VKJCSEpYYwdK58kemTO2daVDzNaVgX
 LEvsrgIY2OAHRCOVXpsPbzxQ8z7A9DY5nqqpRo7o6A0uAvv2rzG6muBp0jF2PuK4W3uD
 9ObXnFXyDfKTlKlaPveqdicWPCmEDgI6GdgogwkBpzGqgiDqExdmyxe+M6TlzJOcNuUJ
 70zaDcFZobimYU9sT1nMyI1VP0JFlUnLvt8EJ4ipjVjXIfefsZRJrTkZGVolvSmHxCsy
 aJWFcIn6gm1DTR7sqewXNN8p9QSwKi7JSaI5aqTsNi4yIti11KfOxayodHjMNJC6A6Xf
 eX9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBycYrkX3yz5EZTd4i2V8GOD/+xpVYEnEMC/yfIwvNBnQpQeplTUJO7wII7/3kyTEMztTWakNwVZFoY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nyu7b+xpuo3Fgm1rysp8w8235Fi7aMJXuOkOUgk45jFnDrH2Cz
 CWo/dTF6KgWecfXPWGPSINrdwpJeGGNQIjdn1UIIZ59wl8jQe+Y1xKqdiJH8TRWiN675QfWfA8t
 jVSmloWyiiVknqYCbsokmsRV+WC2unw7AzO7IPtas5AReshCgRX3UetnAND/z9fhJBEhgyFU5qy
 qShx53ysMQTZM4K2SmKh8T/73O/HpxZI4Z5IAaS3iITRr8
X-Gm-Gg: AYBFou1ib0i1d9YmCFwSEIebJWEMYnzlv8dbiIlOAEnjWtMy/PKbltmR1+Jg+GZx5xB
 sSJdZ3yE/WJ7GnxQOjZeFXLJzoKTv3dvo6G8ZGb8J/GZ1xMAJGXLfzN6byc7vrpQGfK9Z7AumQb
 Bber3PDnJQ/HOdMezZBGQHSykiR8ANc0PYVyYvYTymnZ2r8mOVMl7GQDZK
X-Received: by 2002:a05:6a20:7faa:b0:3da:7140:da35 with SMTP id
 adf61e73a8af0-3dd5f5b29c1mr15338781637.15.1789647326705; 
 Thu, 17 Sep 2026 05:15:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:7faa:b0:3da:7140:da35 with SMTP id
 adf61e73a8af0-3dd5f5b29c1mr15338675637.15.1789647325964; Thu, 17 Sep 2026
 05:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
 <20260916082924.956116-1-zaq14760@gmail.com>
 <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
 <20260916094453.1062125-1-zaq14760@gmail.com>
 <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
 <20260917025644.1262504-1-zaq14760@gmail.com>
 <CAFOAJEfnDrGTg40h=R0mfZasroPkrSsmbVmmMA91O9uOzu_gYQ@mail.gmail.com>
 <0259fb51-acb8-4b07-a6d5-2fe25fb0de9c@suse.de>
In-Reply-To: <0259fb51-acb8-4b07-a6d5-2fe25fb0de9c@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 17 Sep 2026 14:15:14 +0200
X-Gm-Features: AcwNN1UH5rUGs68RRraAabQu2d2krHmsXTgl_y76k48XKzO4lUNKUp0VaqGzlHk
Message-ID: <CAFOAJEe_7Cqo_=NWPGyYBTu3mD3CjPMC92ZZR6qHPjAhQws7pw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: LiangCheng Wang <zaq14760@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Wig Cheng <onlywig@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UUGdJupDQBS5KKWjlk7xuJnj80EyjcA7kvvOyf628iM_1789647327
X-Mimecast-Originator: redhat.com
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

Hello Thomas,

On Thu, Sep 17, 2026 at 1:34=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 17.09.26 um 12:49 schrieb Javier Martinez Canillas:

[...]

> > There are a few bits that I think are similar though and could be
> > reused, for example the pixpaper_spi_write() helper logic is basically
> > the same than ssd130x_spi_write() AFAICT.
> >
> > Same for pixpaper_send_cmd() and pixpaper_send_data(), I believe that
> > is the same logic that we now have in ssd130x_write_cmds(). Specially
> > after the recent commit 3e391b0b516b ("drm/ssd130x: Add SSD135X_FAMILY
> > and SSD1351 support") that introduced a cmd_params_are_data flag that
> > allows to send the operation as command and the parameters as data.
> >
> > So the MCU interface seems to be the same, in particular for the
> > 4-wire SPI interface which AFAIU is what this new SSD1677 driver
> > supports.
>
> I cannot advice anything here, but at least I'd like to get ssd16xx out
> of tiny/. It would be great to have it all under solomon/. It looks like
> sitronix/ does a similar thing.
>

Yes, I agree. Especially since there is even some (albeit small) code
that could be reused.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

