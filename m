Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BE3CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE29F10E178;
	Thu, 14 May 2026 12:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMJRUy2G";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9BF10E178
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:57:23 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so5006987f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 05:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778763442; cv=none;
 d=google.com; s=arc-20240605;
 b=B8X+H6dGawJUsTVYY8+nzs15A0QngYp8yivQWdN8GFfA+rCoSFCs+/c7FI1cv/+VRe
 FVvby3mBhIQ9GFIymZPVG+ga/LT3vzrwTp9pbq5X+OK5Kos2Kt4YR3xYIdbemBBJoQ83
 +X/NbD2sJoB3f8+efs9J4U5VUsk9J7Wd5yyYHok+ae4WRRDEwOF1eOloCJGl2pTulSXr
 UwQC5joEA+LF1QB1rq8Vb6yjfJYW/yQuBObkBDDBZAKIsPK0H44NwJsvNQhykHWIS2HS
 U4kxqPZ0PvkFzFsEiECZ5ZCO7jT8F1cpXakf1pao0vnK7dXXwtxXiYL5ZjXA7WhFi1jx
 9yjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QJj2MCOLAauZByFtae0gIhlDdGWCUi3MspOPavj+fQw=;
 fh=Q6xePRVFidvET+hD9gATI8iSUan2AcHlPZbEu4jaHe8=;
 b=SIzbVdDXaSD0/orq9bDANYuH0KLg/JvPYZ0fg3JcixgEN+agCs9gLboiuV3esMHFF/
 n6fI++bZ+a3b5fwxNQy9RLsqLV3imC/ilXatxYxT5VXj/NNHuKL3Sl72GuqHtGB6FB3e
 kbQHzBwT6hU3+xx560+0v8hkR8KdEe2tutqDcPSgDpdto21YseZaXpj87HQK7xEfdEDe
 xwM1MHLB/75SMqSgT5CLQTQAkwgh8r7F69Uru5MkHkJX2cfsEmYCCT1QJ0/M4W8EYI7+
 kJ+K9WvqyGPSmrTIMcK7NTdOerggEW/k7Jcik6i7MzpOauJm0G8UI7tfAxvDNWBlfvI3
 HUNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778763442; x=1779368242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJj2MCOLAauZByFtae0gIhlDdGWCUi3MspOPavj+fQw=;
 b=IMJRUy2GMCp4fMN5B9fI+Ia7btqnFa1pyYEc+vSODtWLNL4gAq7WkRvoXIN1LR2VWR
 c9PlFHh/VkUJIHTFe+SpFL2TdlTI4r2L57lQepdijbxSSVgo/YfNmslv0cYuWXqygbIx
 mOWVrFqG+7GMATBLAPpKe+Nu8N39Hq2LxhR7WgcY68JWws8myy76Rok5EBNR7ENhFTMz
 YUpTggoDaSkEzoWkr/0594VQSJLRq3k/us8tv9rMpjfbSrVRVbHB4K1zQaGpzF8Joxu0
 s3zBEEQgW+qdKfx6Z/ZhXAA6uPYsYCQ+a769fJiH2OkQwadAHOdVJvlnp0lLmkPGIXh6
 n/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778763442; x=1779368242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QJj2MCOLAauZByFtae0gIhlDdGWCUi3MspOPavj+fQw=;
 b=YrKw8Ty3Y3ko3IS3wB04aVPO1UlNGUW1qSxxS4XDJVFHPphn7i9vIEO0sopyJPjBla
 YABid/CUvADEoGURUNS+4PcSuL1HsBbzrohS1Da1TRiT4YfTccQuvHqnidN8ES7x0Stp
 +2mBF61aZpkErNnypv0UXlA+NOb6KiAuO53S6qlWUaIct3gPVt/uoT3JSntWbJggClUw
 O6u74bNtjUV461vv/m13OKjaqRw44v0uZCkrSQBZvS1pTwkI5oziFPhzksTg4sazsYM6
 6Uv+BDfJLBJIy43UPk9qVeM4EP/fFs2TGprCrbI+IOL8AikwX7AI7vz3HzPdPhfQNQWd
 aI8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Xvql8oKSu3ZtxiUv4HmTKDnYrg7Z8MS2c1frOKKx0Yap1SfqUF9typlQO8p+zIOpnwFCMG8WIoBg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1OvfnmwpIJzgmCyOJzXmoejW4vVZAl88NeTnYJHFBOapXFS27
 gKaL//w9igOi88pN7vO78Ria9x1aXph0QQiJtkgWeP4OWCT8+TVW0fY6y/6p5uJxfMnMpoBy/rR
 sfrfVld6DlZ30mfsshB/jQFxOpZ/Qj5o=
X-Gm-Gg: Acq92OEJ1ucRBlcMc3p+7RM07i6qTaXaJ7pAx3FEPvIKvYZ/Xxe4ntwEimnzVfN0fVN
 1wyHn4HqV0icZg5jxuYpMNpU0Reo2xINl73KpLNoS0Pb3JBfRo5rKsWKs0MC7z4Az/9BgcpurbU
 fz61yksqk+ogTWHg0L5Jnj6rfC58Y8V2t8zWDkEe4O4MisUfmUNkq+P3Hf2/DSvYbxTXLUYJWBr
 +3Ym6qvrx3wrG2v+G32HkhaQ0korSIrV94u4gVHY559AYJC6AOD5sE8b4eL2s40zMfRXe/viL/c
 vZhfMolpGyIALJm36MtOnVQBMQHkbRDsIre3i3M059NQrxgFPzbgl7T/xTelv7bF+QB6iA==
X-Received: by 2002:a5d:5d85:0:b0:43d:6787:9934 with SMTP id
 ffacd0b85a97d-45c580ce1fdmr12148663f8f.9.1778763441512; Thu, 14 May 2026
 05:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260512144104.761531-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260513230208.GB291825@killaraus.ideasonboard.com>
In-Reply-To: <20260513230208.GB291825@killaraus.ideasonboard.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 14 May 2026 13:56:54 +0100
X-Gm-Features: AVHnY4KbiOjn7p6OgTwUEPB8jMaJXzcFxbR1snrUWBRJrF42n-t6aSXedmu1OB0
Message-ID: <CA+V-a8sqeio7K1f4MYWVSP5rvq89fzcVhnZL_jFZRz__FhG4cQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic to
 per-output clock limits
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Laurent,

Thank you for the review.

On Thu, May 14, 2026 at 12:02=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Tue, May 12, 2026 at 03:41:03PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Move pixel clock validation from a fixed encoder check to per-output
> > constraints stored in rzg2l_du_output_routing.
> >
> > Previously, rzg2l_du_encoder_mode_valid() applied a hard-coded 83.5 MHz
> > upper limit specifically for DPAD0. This approach cannot scale across t=
he
> > RZ DU family because pixel clock limits vary per SoC and per output
> > interface.
> >
> > Add mode_clock_min and mode_clock_max fields to rzg2l_du_output_routing
> > so that clock constraints are expressed at the granularity of individua=
l
> > output interfaces rather than globally per SoC. Update
> > rzg2l_du_encoder_mode_valid() to look up the routing entry for the acti=
ve
> > output and return MODE_CLOCK_LOW or MODE_CLOCK_HIGH when the pixel cloc=
k
> > falls outside the declared range. A value of 0 for either field means n=
o
> > bound is enforced in that direction.
> >
> > Set the DPAD0 pixel clock limits for RZ/G2UL (R9A07G043U) to 20.875 MHz
> > minimum and 83.5 MHz maximum. RZ/G2L and RZ/G2LC (R9A07G044) share the
> > same DPAD0 pixel clock limits.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3:
> > - Moved clock limits from device_info to output_routing to allow
> >   per-output constraints.
>
> Given that the DU has a single output, connected to multiple encoders,
> is the clock frequency limitation really a *per-output* property of the
> DU ? Clock constraints coming from encoders can be expressed in the
> respective bridge drivers (and the DSI encoder driver does so already).
>
For SoCs supporting DSI + DPI, the clock ranges vary for these
interfaces. For the DSI this is handled by the DSI encoder drivers,
but for DPI we must perform this check in the DU driver. Therefore, I
chose an approach involving a per-output clock range check.

Cheers,
Prabhakar
