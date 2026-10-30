Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8306606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnRnOzVW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D0A10E9F6;
	Sun,  1 Nov 2026 11:58:14 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4BF10E257
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:34:51 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-8a83d2706fdso7967987b3.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793374490; cv=none;
 d=google.com; s=arc-20260327;
 b=VD962QuGyIYXx5UpDiZ+5+dB2oYKkr/DgUTEcDJ1uTSnu0WRneWCSWKY/4fcEzy58r
 lDumvn+A88SlU8KShB+Z4DsqfmzxZBOu0lpnX/71DCd5ieXjQ67BrzsfUZJCTry62vnT
 LxzMQbylL9wiBzTa/zj+DbJHqX3GG6P07k+V6l8zyBVVcVPZdNDZQ+EZKSf1TMTBbMW1
 T8ddEOjwRh1p8Y7V5zbungSRpzF7wXAlHj49wBOj2qux3o1+d7sSjx4fZ+MGF4opHmEU
 r+yaKV8Fm2bGJzsVVlkj2Q4YCp538viOQsaGUcp2TwwMS1lUDwg6djVBkXj3jLe2yoF7
 4RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1n4IbgOB2b8S36PL+kNnVl1q4UWZNmtFY8RRf5EucFE=;
 fh=nWyG5McBEEESeO0PNelGxVq0/JGsAhIMcopkDY8O92c=;
 b=qYgkeNAnaD2KhSxvfiJa0hhrK34ErwTAmXNgWvyeM/JO3FotWpOewW2rKGIcLc1P8r
 N3gkutXN9ymr5gcGKBVvHMDOqxJTv9KSKfTojiwdDyPf+QPA2sMOCZe80jX5sYPRxAhH
 GqnB9ZymqDJWAGk1wR/AWNAW/dcl8k2FKreAn8r8Z7HFaP4wP4mtjUrWbfdXhIewpeDS
 IXWtkL3h6D3c0BqSQjTUaXl1TjuRU4Im6WjuNgyd30hQ8C4gHctQR439IoD9CwJ2PMtX
 WfR+JIvPq3rspi0X8H+k12TGR3vFW5kxQMwCZJiYiLWF5Ovj1t+brBIDx7K5mniOc0Bl
 1LmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793374490; x=1793979290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1n4IbgOB2b8S36PL+kNnVl1q4UWZNmtFY8RRf5EucFE=;
 b=NnRnOzVWu32f6Kjk9RZMa7s+pwXNC2M8/+EqPmkEolHTsEsh/nzAS/8V23Xv4xq5EQ
 iqrX3nx2BCSoC74pS+hzId9+E/n/Iyf6u9OoheystXycT9nsBLmyswn9MBZBmkfAw30y
 fOOfww08aP58CvoWkSC3I974U4ZPyZs/BMQFf+8LytsnpV2H4+d4J9HzNEBFgndJNI0G
 ObLJ9Q/a3WrNgEg4bMMDj5JL8ljHZKK3WxZBiC0/2MuUM5vqMhu7J/vFlGo+vzUhDNq/
 RWC0tMNQJXX9VSLBSP+dXfmdy35bAJGVFTbPNWKMbmdMwUMeZRsSbd5l3HCmxWkvsT6X
 yHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793374490; x=1793979290;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1n4IbgOB2b8S36PL+kNnVl1q4UWZNmtFY8RRf5EucFE=;
 b=Tck7F680BcK1CMRAKXnLroGjU87QE2/k73wz+W0otZkJxxjI0U1YHEA4lF8umf77sU
 Uh8RwMziJh9S0LLpjlAiCV1DNzi/zsCW3wtl+7y21FAs0Lb3nZUHNTDmksGfZCwgxNlP
 izXJ4+X3XqvjYiIWCAX5E4Pu6HxDDFmNcjXOL3nagH8GQpykG0KQ6vMjrZcX7xFXuxVP
 AGKKVvjVMzgZ94GNmU02S6eCbGuj0x3SeYzDZSK2Lzdvuw/Z81i2zpwPuP5d6eheeyyK
 Fs1/JKMJYxGdCoO2Q7UFECxidoEDY1xRSf1vw4Nw53rRHN1qt8RqMOPMl+FleC/3kbbr
 YxjA==
X-Gm-Message-State: AFq9FYKOekx2fuZXJeUPcpybrNS2RAGiZ41ylgjBFZBDiquxNnGyVHFq
 k+klmVybLeFl6JMYEYnrEZ1+X/VFr8tvem38/CqR2f7Jytdm/asvMcHmZV2EnnFdM5d0GVJLyWl
 pS2q36242A6+JzWCk5Vs5fdCXexkU3rcxkamW+1I=
X-Gm-Gg: AYBFou1mX1XDFmP90c06cK6jfpfOKIPdIIyIV6jYgn9cjnHEfFiOiLWh/1mz5UVfxnY
 Ka8BowWSVCZIpgzGgPmeei7j0ZcpceChyvphS/dYpzJJ79Rx7XQh6G77sYvPR8aXwYTRf2Jg3yn
 32OGaW1EMD/EI4pc52sMGDGjCa9FCwM96HppCiu4XjH8LXKlupOeU6qSoa4zaMWXUWqWEILavbA
 W0WaG/TEqEAC4Z5AtgfWaDYi+S2qxUhUQ0/ruQHrZvd5CAWJpjYhl4nzyTO7OX8q2nU6Zi8nVkZ
 QPreMLWPWKBmJN5con/10idDlmggBVCiBruj6TzlgcgqmHOIr6qWtsHZos7UffPKQlxr/mVkhjO
 eVfR5VjJGJen8JL1DxLdIjF7kZNYVralgORII+kby349Yz49L5Amz6wWTwBE9+ymwYjFh2XqThX
 U6cKoJuGSsUV9ACkGPA/OhPwu6YQ==
X-Received: by 2002:a05:690c:c4e3:b0:8b1:6d51:38f9 with SMTP id
 00721157ae682-8b2b65addc0mr15658687b3.14.1793374489794; Fri, 30 Oct 2026
 08:34:49 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923205835.3505-1-frazinjonathan@gmail.com>
In-Reply-To: <20260923205835.3505-1-frazinjonathan@gmail.com>
From: Jonathan Frazin <frazinjonathan@gmail.com>
Date: Fri, 30 Oct 2026 10:34:38 -0500
X-Gm-Features: AclHuK9bhck79G74ZDFH4BZGdvCd9oliF_YBrQadZWXnT6IpMnFcqiWG_2DnYsU
Message-ID: <CANW_FuOTfGS-z0yO4K3h3ueLUqiN82NRtQqT34q6-A3Mm=YZYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] drm/mipi-dbi: display a cropped region of an
 oversized framebuffer
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kamlesh.gurudasani@gmail.com, 
 lanzano.alex@gmail.com, phil@raspberrypi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Friendly ping on this series - v3 addressed the review feedback from
v1/v2 (added the missing st7735r driver). Happy to rebase and resend
if anything's changed on drm-misc-next since September, or if there's
any other feedback.

On Wed, Sep 23, 2026 at 3:58=E2=80=AFPM Jonathan Frazin
<frazinjonathan@gmail.com> wrote:
>
> A drm/tiny MIPI DBI panel can currently only scan out a framebuffer that =
is exactly panel-sized, always from the origin. This series lets a client a=
llocate a larger framebuffer and choose the displayed region via the plane =
source rectangle - a crop / pan with no scaling.
>
> Motivation: feeding hardware-decoded video to a small SPI panel. The vide=
o decoder emits a fixed frame size; being able to point the panel at a pane=
l-sized window of that buffer avoids a full-frame CPU copy on every flush a=
nd lets userspace pan/centre the image.
>
> Patch 1 is the actual fix - mipi_dbi_fb_dirty() addressed the controller =
in framebuffer coordinates, which is only correct while src_x/src_y are zer=
o. It now subtracts the plane source origin.
>
> Patch 2 raises mode_config.max_width/height (pinned to the panel size) on=
 the six drm/tiny drivers that flush through the shared drm_mipi_dbi_plane_=
helper_atomic_update(). ili9225 is excluded - it has its own flush path tha=
t does not carry the source offset.
>
> Open question for patch 2: the six drivers each set the limits identicall=
y in their probe. This could instead be a shared helper (or folded into drm=
_mipi_dbi_dev_init / the DRM_MIPI_DBI_MODE_CONFIG_* macros) so future drive=
rs get it for free. Happy to respin that way if preferred - the per-driver =
form is what is shown here because it is the smaller diff and easier to rev=
iew a first pass.
>
> The min_width/min_height, the fixed mode, the connector and the mode-size=
d transfer buffer are all unchanged, and drm_mipi_dbi_plane_helper_atomic_c=
heck() still enforces DRM_PLANE_NO_SCALING and no repositioning, so the flu=
shed rectangle stays bounded by the panel regardless of the framebuffer dim=
ensions.
>
> Tested on hardware: ILI9341 and ST7789V (through panel-mipi-dbi), both 24=
0x320 - an oversized framebuffer is accepted and a non-zero-offset panel-si=
zed window scans out correctly; a panel-sized framebuffer is unchanged. HX8=
357D was tested during the downstream review by Dave Stevenson (Cc'd). ili9=
486, mi0283qt, ili9163 and st7735r are build-tested only.
>
> Both patches have been carried in the Raspberry Pi kernel (rpi-7.2.y) and=
 in use there: https://github.com/raspberrypi/linux/pull/7589. The v1/v2 he=
ap-overflow fix (see below) has also been folded back into that downstream =
kernel: https://github.com/raspberrypi/linux/pull/7643.
>
> Applies to current mainline / drm-misc-next; the touched files are identi=
cal there.
>
> Changes since v2:
> - Patch 1: a damage clip that lies entirely within the one-pixel sliver
>   the v2 clamp cuts off collapses the clamped rectangle to zero width or
>   height. That was still being passed to mipi_dbi_set_window_address(),
>   producing an inverted (start past end) address window ahead of a
>   zero-length write - undefined behaviour per the MIPI DCS spec. Skip
>   the flush when the clamped rectangle is empty.
> - Patch 2: st7735r also flushes through the shared
>   drm_mipi_dbi_plane_helper_atomic_update() but was missed from the
>   original list - it lives under drivers/gpu/drm/sitronix/ rather than
>   drivers/gpu/drm/tiny/. Added it, and confirmed by grepping the whole
>   tree for DRM_MIPI_DBI_PLANE_HELPER_FUNCS that no other driver shares
>   this path. Thanks again to the automated review for catching both of
>   these on v2.
>
> Changes since v1:
> - Patch 1: clamp the damage rectangle to the panel's fixed mode before
>   using it, instead of trusting it to already be panel-sized. src_x/src_y
>   are the plane source origin truncated to whole pixels, but the
>   rectangle from drm_atomic_helper_damage_merged() is clipped against
>   that origin's exact 16.16 fixed-point value - when the origin has a
>   fractional part, the rectangle's far edge could land up to a pixel past
>   where the truncated origin would place the panel's own width/height,
>   overflowing the panel-sized tx_buf. Thanks to the automated review for
>   catching this.
> - Patch 2: unchanged.
>
> Jonathan Frazin (2):
>   drm/mipi-dbi: honour the plane source offset when flushing
>   drm/tiny: allow a framebuffer larger than the panel on MIPI DBI
>     drivers
>
>  drivers/gpu/drm/drm_mipi_dbi.c        | 43 +++++++++++++++++++++++----
>  drivers/gpu/drm/sitronix/st7735r.c    |  8 +++--
>  drivers/gpu/drm/tiny/hx8357d.c        |  8 +++--
>  drivers/gpu/drm/tiny/ili9163.c        |  8 +++--
>  drivers/gpu/drm/tiny/ili9341.c        |  8 +++--
>  drivers/gpu/drm/tiny/ili9486.c        |  8 +++--
>  drivers/gpu/drm/tiny/mi0283qt.c       |  8 +++--
>  drivers/gpu/drm/tiny/panel-mipi-dbi.c |  8 +++--
>  8 files changed, 80 insertions(+), 19 deletions(-)
>
> --
> 2.53.0
