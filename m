Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1C1C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF2610F467;
	Fri,  7 Aug 2026 11:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GPVEdjja";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3FE10F467
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 11:28:20 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-8201447e8cdso53321657b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 04:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786102099; cv=none;
 d=google.com; s=arc-20260327;
 b=oGtqI4/ygBZAVVWfY/u7xbhk/aY4qLCIP3NTTms4mjnB35R87R/dJqJmjl6HanKm7r
 IP/Qo7XOM7fyNbNeaa+eexCIv0vR/mF/E2jGyItA4xzQ1Nuw59TbaK61jZcFIS27YNdB
 DJ5Td407GdN6t65GxLfnzYR+3m0bmxtbGxwtnaXUA1Kjq1GIi7RM6KTzszWQrFA3s9DC
 ObkoDkJJd72EW/+ANnBd3IqwFdVM6U+UJbfmzij+weZFKRAmJ10XrZ5RuUiWeey5Cv2/
 n0wIEarXI/4RYIQReMhlGlEndeEMLeissmAgq35sQA6CqLsz95Pgel/U12+iJ71agk3O
 qWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=evPdeY9komARrc1QEEJ5AZQbADWzS8s0ROrrP+Yue/U=;
 fh=vK+isC5gg4qh5yeqdjx3jTcVDlin1RBhCJuv1J0ecIc=;
 b=jAnXVMaQnasD3wlYPXCjmnimUmU3edlKlNr41dXW2F254+m7sDgXig4ttIu8B8mLf4
 6Cmkc4oaUe5VwdWYkd4ANInfJB8fVKbfOPWPLxnJ+ASEx7+mhCFLvkZ0NsWRYtUjmfs3
 yfODpryPd1eVhiwv4uO72jjknLk9dZXs1reTmOIKaySEP2i2UdPFmVhG3ilLgnvWb3Pt
 txjVXj60JaiUuxXj0ofWWb+cHvChErKBwpqOTgGgKCRdg9J0ina8IleMjWiIR3I8KzFj
 diLAVYa19dng/F2ZhyM8BpfxSvZ8XZoo2k9Jv2iNFAgT+PtlFOT394Z6XKSayboBOId/
 NgaQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786102099; x=1786706899;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=evPdeY9komARrc1QEEJ5AZQbADWzS8s0ROrrP+Yue/U=;
 b=GPVEdjjat76OtgYYbkG4MHhyfILUmbRRkDEP4g0vH5c7KH9EsqCDC61huSZWITNRX+
 S2+C2L8VJWK+BwNXKopHAYuIdTz/VqDtPZnQ+32Q0iz0qzwkWnUxxLvB6Fyk5ZqSxkcZ
 KM7ZeKHNzYUegRLCSsCPOEGZ1O7g/QPqfdBBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102099; x=1786706899;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=evPdeY9komARrc1QEEJ5AZQbADWzS8s0ROrrP+Yue/U=;
 b=KGweuweD7H5ZwpfUab+Wb/i3v2VUUiyUWhGUCxacYc5pxEW4lTaR5FgDmXpiYqiqpg
 cZg0EKXCOLhbL/0u0P/F7TD9Iyuq8sd2f/rxryucc6tJ2vVc4hGZ/VTtIsvW2365hpjD
 ydaHoPi/U1KRqmqZtG0ZCHn9vS0clUszfqfjoMXPOZALmXm+cjU3nhqZ4VB+Y8mCskPU
 5ghm04YqOP69kGgBefrAuI+i1xra2EIgMnIcY/eTn3vFtko5o2hwPqfCb9qV10JPJ/D1
 gr0BtwLj21eGc50QrDo7KKDE4ekq6ei1zGyHdQZH9GxZL//iSkh2PkRNgB4av91GgP2f
 xa/g==
X-Gm-Message-State: AOJu0Yz51Qt4zWy40aO5/56NodmBs40XJUdtl5yv9bn03iJtgbJSs/5I
 uGiu7Y5EQ7fGNx+5cgjkaxKF0vhXchuNef3E+W0snmWlzYkEgFPp+hxiW8oSEyk17a/GQ1eDw3a
 ye3yIi86avx0BlBT/PqtU7A5IRh+KTlnmjhdkiR0p
X-Gm-Gg: AR+sD10Me2xhm4pAjLHNZ95Tkc+4JzvbOWzu5/1PCO4vjK0KmPPcS7z5SjaWHfu3dqR
 RGWUSzbe12L3XBP3y/nrowotOenQ+Gnd5trRMo9LXkaX/N4NwdiwdRrHWgVHVhxz+TMUcXMS9ok
 BHz+i0rISyUruKOmisJvWq+LyCbk8qs5hXdgjJPkskgrCijGLvK8xrxWvQZbDyXhBZf3m6GEOOw
 RZ05vLHhrf/AK0t8qRi/IkbyzQ3AXGuz3Xo9LnYHh6HonDDgDivzshfUj4760ZxI6S+VrX06Wn4
 gK00ES6rz89r0v0iXo+f0oCRepROFu0A4KdXjr7nt2w+h9rf3f2cY5k6W7dCZPeky4cj7IqMbHA
 =
X-Received: by 2002:a05:690c:c18:b0:820:b89:52c6 with SMTP id
 00721157ae682-8202272eba1mr135462977b3.33.1786102099345; Fri, 07 Aug 2026
 04:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260807104819.1295812-1-wenst@chromium.org>
In-Reply-To: <20260807104819.1295812-1-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 7 Aug 2026 19:28:08 +0800
X-Gm-Features: AUfX_myPv-Zme9R39kLJ60coe-O7qq9OKUPB76y6Y9KxB5qC-BE6uWf9Zi-eh9c
Message-ID: <CAGXv+5HEzgudvL+VdNniLjYaMDr_Rck2PP=qfe96jv0MphF5Eg@mail.gmail.com>
Subject: Re: [PATCH RFC] drm/verisilicon: Switch to drm_fb_dma_get_addr() for
 framebuffer addresses
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 7, 2026 at 6:48=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> The verisilicon driver has a custom framebuffer address calculating
> helper that the common drm_fb_dma_get_addr() can substitute.
>
> Differences from drm_fb_dma_get_addr():
>
> - Uses drm_format_info_min_pitch() to calculate the horizontal offset;
>   however the driver does not support any of the blocked formats, so
>   this just ends up being the same as in drm_fb_dma_get_addr():
>   "cpp[plane] * y"
>
> - Uses clipped source coordinates instead of non-clipped coordinates
>   as in drm_fb_dma_get_addr();
>
>   For the primary plane this doesn't matter, since the primary plane
>   must match the output, i.e. it cannot be clipped. Also this driver
>   doesn't support scaling.
>
>   For the cursor plane this seems wrong, as the clipping seems to be
>   done by the hardware, and thus the buffer address should be unclipped.
>
> As such, it should be fine to use the common helper and drop the custom
> code.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>
> This is only compile tested. I do not have the hardware.
> ---
>  drivers/gpu/drm/verisilicon/vs_cursor_plane.c |  3 ++-
>  drivers/gpu/drm/verisilicon/vs_plane.c        | 20 -------------------
>  .../gpu/drm/verisilicon/vs_primary_plane.c    |  6 +++++-
>  3 files changed, 7 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/=
drm/verisilicon/vs_cursor_plane.c
> index fa4f601dd0c8..ae03d415d66b 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> @@ -176,7 +176,8 @@ static void vs_cursor_plane_atomic_update(struct drm_=
plane *plane,
>                 break;
>         }
>
> -       dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);
> +       /* hardware handles clipping as seen below */
> +       dma_addr =3D drm_fb_dma_get_gem_addr(fb, 0);

Blah, I don't know what happened, but this doesn't compile.

I'll send a new version.
