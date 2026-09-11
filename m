Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1B3C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD0410E3B8;
	Fri, 11 Sep 2026 13:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PZ0ZNrSf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE8710E3B8
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:24:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BAB160A62
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56EE1F0089F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789133072;
 bh=0j2qBcmWOc1p37RvohbHXc08nW5Fm0zVkkY1ZycDOx4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=PZ0ZNrSfVha0HM4y326o0bJ2eyrzMlMjCB1ztc5BjLmSe815W3rmTnwyLDT3AEkuP
 bxZ2TOrL9Odvf4zTpdcFoaKS/15xgpFyZct59mVSsibc0Oajjx7XCYOggFH/Z4+Sao
 z7hBR36xgJa+V3SDuiSWREfvzNnWmQtog/YdQywwQ8m0u7fqOUn2J8L9JmW5EiglY/
 0ZG7e76HIOnW8VcyXZLhsPBwcWYGMU32bcN1wcrJU8PiJ1AAHdYD22OTNRyrssCxjr
 M34RZIaj3r0nCsO1BHwRbbYLxLhyUlZMDC+ekRfrNvjgTz4i7xFKCXp7e8Jsydbvug
 ueAb50Wp5VDpQ==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f15b78so843868e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 06:24:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxbrvf87GoMF7WY91jhc40MBuCGhl67SY9FJNatO7sN2vY9aAsVLLQC/dbNLVSYM1gI7BQH2jZoMW0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nRiW2fsVBNGdpc/06D6bpxFsMSFfY9qJsuxG9bIgtz5e0Sl2Kh
 EIzftzIhPT9J45cFFIlhCVrmtohJJoBlMCpWBdF5chDhcxJKlJsnsOIHHKPMbf/88Znk1FsW1Oh
 EfGvYp1Ts9piGda6wjSRBUOxGd7vTqMY=
X-Received: by 2002:a05:6512:2204:b0:5b4:7d9d:16d7 with SMTP id
 2adb3069b0e04-5b8a02df777mr1760118e87.11.1789133071406; Fri, 11 Sep 2026
 06:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <d3a928e0-6faa-4cd4-9d2e-cb9be4cf84c0@suse.de>
In-Reply-To: <d3a928e0-6faa-4cd4-9d2e-cb9be4cf84c0@suse.de>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 15:24:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLnAoOaRwWpkVX0o1z0wF=Qs9PRTKbq9iq-GWSkJ2kyX8w@mail.gmail.com>
X-Gm-Features: AcwNN1XhqjMUxLBJRz2ogLHBz48a4ffLu-JtjNS9gwh4pdm6GiYqoN9oXiWuqlk
Message-ID: <CAD++jLnAoOaRwWpkVX0o1z0wF=Qs9PRTKbq9iq-GWSkJ2kyX8w@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Roshan Kumar <roshaen09@gmail.com>, dri-devel@lists.freedesktop.org, 
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, pimyn@google.com, 
 linux-kernel@vger.kernel.org
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

On Wed, Sep 9, 2026 at 10:16=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:

> > The PL110/PL111 controller scans out a single framebuffer and does not
> > blend its alpha channel with a background. Advertise
> > DRM_MODE_BLEND_PIXEL_NONE to match the existing hardware behavior.
>
> Why does the driver report ARGB formats in the first place. I'm looking
> at the code at [1] and I don't see any difference to XRGB. Unless I'm
> missing something, please remove ARGB formats from this driver instead.
> Drivers should not report formats they don't support.

This should be the TRM for PL111:
https://support.arm.com/documentation/ddi0293/c/?lang=3Den

I checked it and indeed the ARGB* should be search/replaced with
XRGB everywhere.

Shall I propose a patch?

I also have the actual hardware so I can test it properly.

Yours,
Linus Walleij
