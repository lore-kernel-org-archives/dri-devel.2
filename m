Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C31CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A3010EF14;
	Wed, 29 Apr 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHmJxC02";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED6910E30D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:05:43 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso10059619a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777363542; cv=none;
 d=google.com; s=arc-20240605;
 b=Uua+H5YJ4cXCxfTbnwgk9LVP9ZzKfSvb0BqMJj7FK7zO4JED2RYx+dH7my+hk517mg
 X3Y2JDor7TFaLeZyVyGN7FcHPSXsPlrpFdwMf7Rs7Jv955POWZIgWKYggEOzNb4DOk9q
 sota6Js2QP9OZXAE9tgAkkaIrzZKb4xF09MhvKbheDzEWA6lYSsWVLVCVcF3JTI/iAKV
 YmxdMdX7cWtwXGMQQ2hGKltuEN95P4wt6E4odWFdZKlTSx1gcROkZMPPeNFvP1c+5fX/
 IwlvQdYZFwnNF4WrgOGdwvdcoD4d1hsv07Lbwj+Vx9QAVue0rvqiUZqPE6h1DjKzREGs
 4jPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cj0MIZTPFsNrU+t5+Fd0yuMDLqm4s74WOZo0xpZHxZU=;
 fh=bcSYhdY8ZO8QmvGrSBodUPLI/WUCzD9h6vqvNA3VQY0=;
 b=YHPVR9h1uIErZBV48dlxRGqQk2X6AUR0ZUvriC4m3KxaN99X1vej3IUXgqEj8gbi07
 zHsOYfEnI6V3TV7m/ZoDdN1sHp9PKJOXapHXqY5GKn/VaZ3RlJVpvAcQhh9Um9+jqcxa
 mEwMVCnrU9dPCGEHNMPJJdG61sG0qKvd3hdByf4HjYtZ1zZCIOc/XnhEIogTTewu3tIe
 JjvpohZvw2kbn06F5yM+FikixtlA/mgJCBHuJ+AfLCw2fA8bc6LUJwDvGMHElVPJ/8JF
 gYkZjhY30PfbbEAQgqjP82nFt6UoaJh7LUfOKiple+P9Fr0vfuB0pAzPyxEHCsKVuPkg
 DsCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777363542; x=1777968342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cj0MIZTPFsNrU+t5+Fd0yuMDLqm4s74WOZo0xpZHxZU=;
 b=PHmJxC02ox67z5jpE1MgFQm6T8ypffSWmjeP4op2kp9hteY9RVhseyNXJyCakMplbZ
 btHGn/X0SX/MNVelCb1Bdy6/Q/I4ZvunGDnAbAwPHFWuloqk9GaJa67EOnW2HmVG3RDY
 TmCmQYwuvC9f1foUE452+3VkOdbs1w4HyGpjFJ8F08JBcdk4mICJeuex4x4KJ7Q7oEJ3
 A7DydEcZ02hCCrfkiYeaBrY4wwhVLBHrJPnIrq5Fpo0oKwObVv2P/ja3p/SUA9pBGflk
 b2l4/Pa0Qs+t3cSukIHMeczMBZysaoMerKIFcFJ02sLZhMD9cZ2gsLMjHm2CHZNfKypu
 bAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777363542; x=1777968342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cj0MIZTPFsNrU+t5+Fd0yuMDLqm4s74WOZo0xpZHxZU=;
 b=fZYSdZ2w91exLHjLxBWTnXRa+ea79DW2XVe4cx0mruU/YOXICSezB+XkgqrOBAAmlw
 nbI/cziGDaJoEWPaPfnIo2+r/O5IcgdwLjDm+jOPJ1TdY0cO/rTITi9wFr4ZeAGRH8cz
 MRqy9/eVNwVJt4jQSGk5jJJvmBhxRppEW/G4yJrktfX3zkwruR/5pqpA2hWqqMiCAd9B
 7+/2yZK+g63NqDPhSmmvU9uCguDw/fGVYZrAqH/TYes82dJBhgFaSr8EEDyShDnmL44Y
 6Xd/AucdrsWEYY4yGQzvoc9vp0AVSHiCJHncgjxrHWibkmU4bQXfTIiSV2R+eKvaGIQE
 S6eA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XVz09D7l8yNGtthh9c9iSIT4f+/RcrtTMqemBZQHPabcWZsbf/RqQvQbppFCmi30HTSOVC4UolZs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ9vxv9B2JQ8fTDZcKS5ZEb7HvrkrIVXF97SKyQskg1HtNgNiI
 UonKvQS284qCzAAiSEky5wXRd+DUYFbYEVpmiYpVSUDw8eFsaIc9+aoflWbZ5OaKF9nt352bK2C
 8VsM0zs1N8cX4Nkf+lEn0F/ppVxz+vuc=
X-Gm-Gg: AeBDieuJRK+uvIbdZrRrT/Oeh9TOep2tyEbTMZWqR6FzM3rUaCkiQjksTgDPdCawWSN
 OArjjCifSMPsHrCyGwLWasXtyzuhuBe9bFfxkr74R+FlC+sODtb9c1onxk02nOn2YLCcv/h+5XI
 q8KSdjx+n5ixjRG4D4ys1gMIPVo7PoyG0Vo058HX1tzHU8vVRRwWzXJcE+bO4rFZQSqqUpzxwDe
 Rd5rfPxXPKHlTPHossX3ltKTYxNYX+XmLbIXwN/43sfSEtnl8bmclXf0GiD1Y8Rb5gw8wOlvTto
 Q4YAZl9BloVXbM8bDzPH96ozzvC3
X-Received: by 2002:a05:6820:2d03:b0:694:91ab:ec94 with SMTP id
 006d021491bc7-6965cb40d96mr1002680eaf.38.1777363542202; Tue, 28 Apr 2026
 01:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260428063224.3316655-1-syyang@lontium.com>
 <ilkpth74qyjxmd7fol76kztjvsdmktjmj74qu4f35gevfjgy4v@nscmwgworotm>
In-Reply-To: <ilkpth74qyjxmd7fol76kztjvsdmktjmj74qu4f35gevfjgy4v@nscmwgworotm>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 28 Apr 2026 16:05:28 +0800
X-Gm-Features: AVHnY4Iy_Kzp1ivcV7THV9OiGUP79El0KrZmr80yMhvSjvHPsG8reQdff8SQE4c
Message-ID: <CAFQXuNY_j8fULY+OCrMJL7Nv570x_HxsXvL7R-+aShPKmVqZXQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Lontiun LT7911EXC eDP to MIPI DSI bridge
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com, 
 xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
4=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 15:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 28, 2026 at 02:32:22PM +0800, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> > and output signal/dual port mipi. This series introduces:
> >
> > - A device tree binding YAML file describing the hardware
> > - A new DRM bridge driver implementing the basic functionality
> >
> > Signed-off-by: Sunyun Yang<syyang@lontium.com>
> > ---
> > Change in v1:
>
> How can this be v1, if you already have sent the first iteration?
>
Sorry, it is my mistake.
Next time, I will correct and carefully review.

> > - dt-binding:
> >  1. reset pins use active low.                        [Dmitry]
> > - drm/bridge:
> >  1. use atomic_* callbacks.                           [Quentin]
> >  2. fix the incorrect formatting and spaces.
> >  3. add the required header files.                    [Dmitry]
> >  4. remove "enabled" flag.
> >  5. remove *fw from the lt7911exc struct.
> >  6. .max_register and .range_max use actual range.
> >  7. regulator use bulk interface.
> >  8. use dev_err_probe, devm_mutex_init and devm_drm_bridge_add.
> >  9. Replace GPL with GPL v2.
> > ---
> > Sunyun Yang (2):
> >   dt-bindings:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI bridge
> >   drm:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI bridge
> >
> >  .../display/bridge/lontium,lt7911exc.yaml     |  89 ++++
> >  drivers/gpu/drm/bridge/Kconfig                |  13 +
> >  drivers/gpu/drm/bridge/Makefile               |   1 +
> >  drivers/gpu/drm/bridge/lontium-lt7911exc.c    | 497 ++++++++++++++++++
> >  4 files changed, 600 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/lo=
ntium,lt7911exc.yaml
> >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry
