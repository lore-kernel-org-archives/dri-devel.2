Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D692FCD0AA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EBE10E736;
	Wed, 18 Mar 2026 04:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KdNNfE9X";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF79110E731
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:57:16 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-59dea72099eso7645582e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 21:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773809835; cv=none;
 d=google.com; s=arc-20240605;
 b=Qw+nthoGudrRXgylR4WYbDtKuXGAB1qyCfy6k7bU6AvRjD38dseFoIUhZ4tx1bhZWX
 UTXK7wtHBAJoG1EEp7DnrZzVfpjCCsflQmPrR+Lwk4pt8vAt0f1vJSVPDSiJO7LrsZgb
 fzKPBjUSDF3rY7OqyTwZnO8ISE4iXMlTXpZrExO8JbVp2prmXlWUdq0uH/sRJO0EZZGG
 oXA1z+V9wwKj9j0Tx4xHJZAJnHo4D8cnRMfqO+1qCkj+eAqv+MCt2eCx5dV8ebedYe5w
 R3ZWHrM1rCpKodzNIhg9C2VYMb+QV0C/z+Pi9n8dXQH8eB4OWjks0MRZdJ6gb78A9UGx
 4J0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=80+DeSHfpGw14VHMOKDxWgqpCc09RBagpWieMKMRPqo=;
 fh=eJvJxFzBlM8fHJqva9qN6OAevTyBgbuJ6MgNjURCd94=;
 b=eNZU13Z8iIMhmbTXwHNTSQH+ZGjedmrc8g/vkHx3dISLc7mKKlJ/P9P2ca0mkrtdz2
 aDEwvpmWo9Vc3YbBR1iDSFpREi7aCfqXhcDrADk4DrSEixmQ+FFdY3M6kin/+F6JzyUr
 YEFtbSrclByRVwowWXeph3KPdjcwqZayPxxQXu97NDsyLNsm/gc6TGW+8nNLuO/OWH31
 Z0Xvd+2GL6GB8Ri+YCi1AVX5YnLCUfS53m06YR8ga/pK/jVzzr0REGX1A9/HeR4alq09
 /rIGxpG4YSE3NaDNx0W/SXWKxjQfi5tq1zpI5tX1yQ8GIy0ScbzSjtR/0TQU3Z3rL+3b
 CPWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773809835; x=1774414635;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80+DeSHfpGw14VHMOKDxWgqpCc09RBagpWieMKMRPqo=;
 b=KdNNfE9XXyAyA/ClcR0hCVu0IEnJmlXAz+Dfx2jKJrqujjJMuZL6qmqImzi6JVh6O/
 NXO+k9D0Y2XctS3Ddpngvy/UuXR73CNbvl+aXIFgGWjz4v9F/JBTylsDr1U7mILwbxm3
 8yoAHyXFzHnPXNdSTnbRGLiq9SaGtXpIVJtek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773809835; x=1774414635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=80+DeSHfpGw14VHMOKDxWgqpCc09RBagpWieMKMRPqo=;
 b=lH34O2Kmf3jeKMnVaTKgzbDmmtb5jwKGM2uHy3iNbei3cQqdNiXXLpaXZPqLsjdtVI
 lm8B1deNeG8wpJFAURxRRSGZvZnOA66GWKM2z/Z4ZXkNfUdzbV8nuiiK/jlReXaBXHXk
 iHagQIcOu3TL7mfURNi2xSBUIjpPt7huW8r3Gb80rtKMRGBOJ8jOsrEMME4uKUeXJnH3
 Nq4iajwdsrgoFK9Y0f54ARBKjFE8+tD8PlLtjYXRKEpA6ByhBS7cZ/Ntivk0i5uTNT1j
 dwOGAvZ4rniOTCppDh49/j27yryb+Qcud+dFVaQ/uYjs/gCa+7FPI78BamRCXvhmkb9b
 GG1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRcFTIgWjvg7bIix39fa75j5HKQ8n8iNdM6fqD9YfI9P5sHnY1ZJoqjBWOHmd4cxBfydPviogFyls=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCn9w9s5cf74IAjTMB33mnid3dA+rV50UuZu3fY0HXEDkj3f8P
 GngTkTIVx/MZd/RYzaokmJlA2K3t/P8YsSvsD//C/6LYR6C+0S7jDREP9M5XZWwFBIC8Wuz//vV
 Nh3Ubvn5xitnFS3fiUoNqTBQI5aShLyvhs8ODm0hZ
X-Gm-Gg: ATEYQzzCcfWn4au5nYKCAcEkDJc1wkHeOK+d81EcIU39YQHSNtOewvdzKA5VzJPWbZB
 5owxTDDOpEWXHRaHIVNHDeO5JRObtasnggxQr2EtpKQYB3LN3Qxof0Olh02UdzxIcwLL/npThI7
 0MtjORYbhvarJJ4D3HBgJzI3oAkurh1eZdtUATC3vLFwqrylSKQWe+XQuKdwBcg7l/BfccccNNU
 LjrOP04QGYHKE1BYK1PW9G4zbRxDiVBNhj/uvA82MVqi6wNhOS9PTPYYu2tePk9kU/TWtPalSx4
 kK27ovVvCKB6k5q1VNwtTS4tqOr8lBURdOKnhA==
X-Received: by 2002:a05:6512:a8b:b0:5a2:7b89:4c74 with SMTP id
 2adb3069b0e04-5a27b894d35mr123751e87.44.1773809834836; Tue, 17 Mar 2026
 21:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260317064049.696795-1-wenst@chromium.org>
 <20260317064049.696795-3-wenst@chromium.org>
 <607daaca-79ed-45b2-941e-1680a17618e8@suse.de>
 <CAGb2v66D3=s9c8oJyYEAK90A4SekW6FjLUpWBGRHnJwtfMvUeg@mail.gmail.com>
 <ada8ca6f-a2f2-4f8c-b916-f6dc24db6db5@suse.de>
In-Reply-To: <ada8ca6f-a2f2-4f8c-b916-f6dc24db6db5@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 18 Mar 2026 12:57:03 +0800
X-Gm-Features: AaiRm51ndr8wIN1dFRJ0R2AdD-JeDrk9Q9pyem8o1kiOTDGC041zyMgTjZn4ekE
Message-ID: <CAGXv+5GUmCEDM9XcOgHL5EKNhZMNc5RTdeheqLAT0CFp=qJavQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: wens@kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Tue, Mar 17, 2026 at 8:24=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 17.03.26 um 11:58 schrieb Chen-Yu Tsai:
> > On Tue, Mar 17, 2026 at 4:12=E2=80=AFPM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
> >> Hi
> >>
> >> Am 17.03.26 um 07:40 schrieb Chen-Yu Tsai:
> >>> From: Rob Herring <robh@kernel.org>
> >>>
> >>> Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
> >>> drm_mode_create_dumb. This flag is for internal kernel use to indicat=
e
> >>> if dumb buffer allocation needs a kernel mapping. This is needed only=
 for
> >>> CMA where creating a kernel mapping or not has to be decided at alloc=
ation
> >>> time because creating a mapping on demand (with vmap()) is not guaran=
teed
> >>> to work. Several drivers are using CMA, but not the CMA helpers becau=
se
> >>> they distinguish between kernel and userspace allocations to create a
> >>> kernel mapping or not.
> >> Any dumb allocation might require vmap. This is not limited to interna=
l
> >> buffers.  Because if the dumb buffer is shared with another driver, th=
at
> >> driver might require the vmap for displaying the buffer content. There
> >> are enough of such drivers.
> > By sharing, do you mean exported via PRIME then imported by another dev=
ice?
> > Or just passing around GEM objects within the kernel?
>
> I mean PRIME/dma-buf sharing.
>
> >
> > And could you provide an example?
>
> Create a dumb GEM buffer on one of those CMA devices and mirror it to a
> display or udl device.  These devices have no means of scanning out the
> provided buffer directly, so their drivers vmap the buffer and copy the
> pixel data into their internal memory (via a peripheral bus). The vmap
> call happens via the kernel's internal dma-buf interfaces. Hence any
> driver needs support for vmap if it wants to support this use case.

I see.

In that case would it make sense to limit not setting this new flag to
drivers that already specify DMA_ATTR_NO_KERNEL_MAPPING? Or rather
inverting it so the default without the flag is to have the kernel
mapping. It would be opt-in rather than opt-out.

This includes just exynos, rockchip, and previously mediatek. Having
this would allow moving them closer to fully utilizing the GEM DMA
helpers without changing their existing behavior.

The flag was removed from the mediatek driver during a previous
refactoring to move it to the GEM DMA helpers, but I think it was
a limitation of the helpers, not an intended change. Angelo might
be able to provide some context around that.

Or maybe I just keep the dma_*_attr() conversion patch to satisfy
the needs of the aforementioned drivers? What do you think?


Thanks
ChenYu
