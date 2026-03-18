Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876FBFCD0C3
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A4C10E02F;
	Wed, 18 Mar 2026 06:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A/q8Eeqi";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963F410E0AE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 06:51:41 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-59e4989dacdso7415425e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 23:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773816700; cv=none;
 d=google.com; s=arc-20240605;
 b=KQoFE0expx6mshCRwF6pO5nGfpg/uJtlnipR/4oheJjXEwtu05X34ojGHlDf05fVzG
 YZnP7+1FQcBhKqH0XPFMxksrg6xdAKKjPVpVkaHw6uoz6X0ISgYU9GfM8lb2nYh2ARAA
 su4TSc3ZWwnTIKUSM5srUge8QCvVvQoPo/J57sADtWUPu2+RrSKWEymOcxy38nRbqW15
 GfQOxFoDUhFP3dMP7wePA2MaD5C+WJz3PTuJck0Rn0pt+6mUJ6v/BNw4CcgAPlLrtnfU
 D7+66dMmGJECVzlnsHBunAWaJrGXOBpOSrLUg9iwbbkr4rQjj+4QgS3fHZZRAA4pok7v
 +3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3AIpEMFSc1w1UU+CwQpv+mXG0dXIbG8YyU6JKJWt2Ig=;
 fh=nRTcX4OF47nqDVgbaZWJf4mocEy/t8/E4atNkdkq+/I=;
 b=D7+sYS8ok7QBqFbwW3Zb64m5c7ga/Nc/pClr6tysTJYbXfzFPp6ow7JE4OPQjezVdw
 eMCVowVoVLaiZyPT7DXoh8Fai0S3wp/5LXuqgZG7TIKZ92ervW76vr7DjzjdH/l/wRVF
 1+OPStmOzmxJN26cEosavB7jCx+9N2vUiiHEGPHolrFOJomU0FX9lclovY9290vzgVj1
 mhzBKw3vrPRukGC0U+gRrZPrmdGJ7ukhGHqYgi6z1T/McgZ+C406kdU0VFL+wIZlpnTh
 SPLtRxgNoM6yB6/b7ugNl2Hb4IRVYoi37v9eBCTNWKEpoBRG1Znf7noHzthubTUeyjQO
 apxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773816700; x=1774421500;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AIpEMFSc1w1UU+CwQpv+mXG0dXIbG8YyU6JKJWt2Ig=;
 b=A/q8Eeqiett2clyEnn6IkXSd/yIU43RNHZ2cukBDlI+LT/N5lFZWDLfAA1DCh+ODdI
 N6xC8Wqn39fbn9m9QvYqL+sehxQR7U10SQ5Rlfs06lBEqnn6GuqnzZlz2mQHVhuZ4S87
 MKmJldLQ2q0OkAaq7baF94H0DgtUcPNY1ID14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773816700; x=1774421500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3AIpEMFSc1w1UU+CwQpv+mXG0dXIbG8YyU6JKJWt2Ig=;
 b=S/B3XqjD8cYBre3SPgCv4zZY/jIgfjAYViXRZpAOfhEMJGZWkvChbxFdavjlw8j7jS
 dIg2I2a45czOpCat49g8P3EZVRTjiR6HtDDdB+YTBELsUsJX0ZQlUb8bD9brGlcFhUha
 y9khZO2eiiRTccBi/KO+vmdY1nLH5xnc4grbftzXZQr+6rAOO/vGsl1u4zkbq4FQwNUO
 AdfNvDRSxDOPjj6l+NbIE1mXe7VBBIsfyNbDop0b4VAJaoRlwuxQbxVWYJgkZWBrSjbW
 L7LeKeWPSLxcwg+Sy5Tpri0ZcilLhCS0Hf/dLhrS4rHCegLb3eH5K/r7Ln/zuNNqStmH
 V8TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj6jvpJQwWk17aSA09Wo40D3MPX7Fi/S4uts5BkUeJi2+KkQUt+zrdrknAt4Zwpl05DH7wYhd7pVY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTFNDolvWfzuuxf3VEIh767tcBZKPrhpujRRiKejyfoyA59qiK
 j0Jesg5QnRmafsWTTU+2i/EMOjLIqdb94TX3gOSh//TARMPrrxW70a5pqJNqA+TdoZovkJx0Jpk
 F007Il7bC/GbvXu2zuMnHWj9mkOnKGsbOzS6oRdKb
X-Gm-Gg: ATEYQzw3Ugeh/9a5nNJ7ezCDS8Tm2sJh+PFnsVHM6s4g8qL67nPN5j5MX5OiUCG/ObA
 l8/E+Sn6koDYtIItRTbpfw4SzrkV+Bn0eG1PCzy/eFOZ6eDZf0F84XBCnvxs/5GNJUCp4ce1TV8
 ClRVYou+fW6+cWg6BbyKdSSyXH42yELELDox05DX1FSscScZCtpbQBFmaF2bBUly/lBP5j8zgcO
 tyWcVuCv1RQg7+14xj0Lcup/6wXzojmGM+F2nl35snnk9y0mCjCAmvd2ot3ncEyBoeYldZQOifw
 2MlFhC2ojWDk/wHfUDwlhOeJ5fM72f967Pckpg==
X-Received: by 2002:a05:6512:39cc:b0:5a2:7b43:62da with SMTP id
 2adb3069b0e04-5a27b4363damr337188e87.30.1773816699777; Tue, 17 Mar 2026
 23:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260317064049.696795-1-wenst@chromium.org>
 <20260317064049.696795-3-wenst@chromium.org>
 <607daaca-79ed-45b2-941e-1680a17618e8@suse.de>
 <CAGb2v66D3=s9c8oJyYEAK90A4SekW6FjLUpWBGRHnJwtfMvUeg@mail.gmail.com>
 <ada8ca6f-a2f2-4f8c-b916-f6dc24db6db5@suse.de>
 <CAGXv+5GUmCEDM9XcOgHL5EKNhZMNc5RTdeheqLAT0CFp=qJavQ@mail.gmail.com>
In-Reply-To: <CAGXv+5GUmCEDM9XcOgHL5EKNhZMNc5RTdeheqLAT0CFp=qJavQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 18 Mar 2026 14:51:28 +0800
X-Gm-Features: AaiRm53nz_HSaQkfIL5l8CVEXOdYGY4r-GTPWU2czp-tZ8-rpvpmtLxKehanc8I
Message-ID: <CAGXv+5GF8zPjgzSy68x7wxFLc=zEMac1VVE8OUcBH1+=GgqMGQ@mail.gmail.com>
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

On Wed, Mar 18, 2026 at 12:57=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Tue, Mar 17, 2026 at 8:24=E2=80=AFPM Thomas Zimmermann <tzimmermann@su=
se.de> wrote:
> >
> > Hi
> >
> > Am 17.03.26 um 11:58 schrieb Chen-Yu Tsai:
> > > On Tue, Mar 17, 2026 at 4:12=E2=80=AFPM Thomas Zimmermann <tzimmerman=
n@suse.de> wrote:
> > >> Hi
> > >>
> > >> Am 17.03.26 um 07:40 schrieb Chen-Yu Tsai:
> > >>> From: Rob Herring <robh@kernel.org>
> > >>>
> > >>> Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
> > >>> drm_mode_create_dumb. This flag is for internal kernel use to indic=
ate
> > >>> if dumb buffer allocation needs a kernel mapping. This is needed on=
ly for
> > >>> CMA where creating a kernel mapping or not has to be decided at all=
ocation
> > >>> time because creating a mapping on demand (with vmap()) is not guar=
anteed
> > >>> to work. Several drivers are using CMA, but not the CMA helpers bec=
ause
> > >>> they distinguish between kernel and userspace allocations to create=
 a
> > >>> kernel mapping or not.
> > >> Any dumb allocation might require vmap. This is not limited to inter=
nal
> > >> buffers.  Because if the dumb buffer is shared with another driver, =
that
> > >> driver might require the vmap for displaying the buffer content. The=
re
> > >> are enough of such drivers.
> > > By sharing, do you mean exported via PRIME then imported by another d=
evice?
> > > Or just passing around GEM objects within the kernel?
> >
> > I mean PRIME/dma-buf sharing.
> >
> > >
> > > And could you provide an example?
> >
> > Create a dumb GEM buffer on one of those CMA devices and mirror it to a
> > display or udl device.  These devices have no means of scanning out the
> > provided buffer directly, so their drivers vmap the buffer and copy the
> > pixel data into their internal memory (via a peripheral bus). The vmap
> > call happens via the kernel's internal dma-buf interfaces. Hence any
> > driver needs support for vmap if it wants to support this use case.
>
> I see.
>
> In that case would it make sense to limit not setting this new flag to
> drivers that already specify DMA_ATTR_NO_KERNEL_MAPPING? Or rather
> inverting it so the default without the flag is to have the kernel
> mapping. It would be opt-in rather than opt-out.

I guess this won't work since drm_client_buffer_create_dumb() calls
drm_mode_create_dumb(), and we need a way from the upper layer to
say we need the mapping.

> This includes just exynos, rockchip, and previously mediatek. Having
> this would allow moving them closer to fully utilizing the GEM DMA
> helpers without changing their existing behavior.
>
> The flag was removed from the mediatek driver during a previous
> refactoring to move it to the GEM DMA helpers, but I think it was
> a limitation of the helpers, not an intended change. Angelo might
> be able to provide some context around that.
>
> Or maybe I just keep the dma_*_attr() conversion patch to satisfy
> the needs of the aforementioned drivers? What do you think?
>
>
> Thanks
> ChenYu
