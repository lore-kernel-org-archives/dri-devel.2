Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF5FC5AC67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 05:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6457410E36F;
	Thu, 13 Aug 2026 05:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cJ8sgMVR";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E04410E36F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 05:25:12 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-667923d86a7so988582d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 22:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786598711; cv=none;
 d=google.com; s=arc-20260327;
 b=c/GSQlK3XH74htzJO6DLagGYvZBKX0R8onXJ7S/BuuUMwRicewBAti0DGc/JJaTev9
 ufVc80cknt6dvOwjy5I2YLcnVAq4UTp3ne7bBOdbGtxZXoUjOY2Xr7dqlfBa9ZbsKX/7
 kO+/gYIF8gjxH556zASKkXyzBnLsnaCovdJbcNjuPbjC3fxxmv3ne6bh5rlevi7pQm1Z
 YePXHMoioldOS6acvl4/qah4n5BhQQ4J4+eReFbCkDR5HWhsMGAgZXRy5dy1toWHOhQZ
 E55fWLIAEhIU9GaGwP/kQlguXdXiq41mAPImQGq0eWtWD5VK5yQocFUfbOBVZsfr/8LS
 F3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EbgucoCWDUVj/GavWrJcmpVjVGNtwN+JIym6XRmJU7k=;
 fh=FtymGS9RhdkM2YciWryJpduDd5gGkKd8XfWqAuRbhwc=;
 b=BAZOzRwStKrrbPS0WcKkIy71zgFvnAmOLNAmjtcNnxICkFdAN5mJ5sJqwX1diPMEbt
 5Z8pqfVuGETv512VQLebPW0kkX9WbMYhNOijFfVspNWp/UcMl8r5YODjgo79FrHEtaab
 VGRM9a0/OlYe/u0wUfBSEKMbYaMfIJxhdYemEXng9IkYc6jytdDLb8MIkGuWIaeZB/7b
 7NFWyruUBBSRI2YjALQeVV7PYk4zGTIURR/fu8+5kBwuEIlVsg0Bc/hodGlV3Hpq3+FU
 kofXimJ2exGBxV+TN01tqhVo3oIVBjq4hEV4/m09R/jCJfmdCUSbn0tKTa4O/zFP6alX
 85SA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786598711; x=1787203511;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EbgucoCWDUVj/GavWrJcmpVjVGNtwN+JIym6XRmJU7k=;
 b=cJ8sgMVRjQHy5B5/5xVOKYC5ZsrEBcriwehu2dgVHTolG4YMLi5qhXnS1UYQfZLUpF
 O0YwZIan/xBaqrNSR9eoKhk7Jquww2JXGX5F64QhvvAq3r71y00lPp1j+U9NcR+MNFcr
 xNdyVkK3wpkWhVgo/Pu/HB6+hb08Kd2p2Aw+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786598711; x=1787203511;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EbgucoCWDUVj/GavWrJcmpVjVGNtwN+JIym6XRmJU7k=;
 b=Z2K6DPBpzLLFxeHXSx036foCCdyglTOARnX6j6PMJW9/KbLvQF8HvQ+de/ExS0bpaM
 2oGdg+LxZZwu0kum+ZvM9nL3G8Cr5gcNPWmFGnQGxu2vPB/sDulTnwtZxA461MwRvq69
 bLvw/CBGhAW/D0T+AiUn5+IaiBwgClUWKmblbSj1TNSxf0vPNub6C6T7Qiumfis0A7UR
 3pOGDc0sVSLMmaJcItVBRCm5irnstvgUWJ4bh8ZCnRpGb7f1OtGIdmf7LKdMzBAEQvQO
 c++W+xUlc62DhUuByxM/AtgzqOcORoXy+Hyw6p14MI5T7xmF420GtZX5Erug7tj/8ljq
 qVwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUq/+QufObmlMqHJQdxonRhvRx+Is+PDcw3VtkH27qhlxR/nY4DzZDTdQQa6c5QuJ3HgBjzqB5aI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1X1TBM4Xkb9aOpIJ6d6LORQgD/sYAouYP4rUuJcsxSsMC2OCR
 QTTMEGRwDYrcJT8+GwG+grC6HheQdqVnZbsGR90oa92QfB3G8TAiAYH4Ww/taziuFR95sZU2aLV
 HhQz09mwVo8woWVaeaD1NpAIh6jJFBqymW0l9UMK0
X-Gm-Gg: AR+sD12w0OieQ6UFhudz2J8R1B5zRRnidv/QtkOc1jyAStECph2J6XuVeAWEreT8iZ3
 Sg+dxytSYTjRR+aRUkSR9qDvU560/b41anoZywStKz2HeMVstcnFg1o1ITF9iI/xKbXd+M9Unnb
 eeYbblYZoT7J3epjQN2bshBzLai2WYkHKfnGyNTQd3bHP88qU3/6J6CAXpZEonklSxbYmvB7984
 1YQ0kcdqnjIICGXUE7imHSr9oaecLjHoMm3dhN0q/sYYi3Q5ntucgQ5JXhHxB2ohjw5fR7M6qQC
 Q/OnsnbnN/AOJovn+Zvs9erNpitkpwbq1it4z5FFopUrL+A99UncsMGWbECegfFTJTZcwOT3D+J
 BTtk=
X-Received: by 2002:a05:690e:4507:20b0:664:bf1c:2922 with SMTP id
 956f58d0204a3-66c54d0ec36mr918730d50.27.1786598710424; Wed, 12 Aug 2026
 22:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260812154829.671777-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260812154829.671777-1-zhengxingda@iscas.ac.cn>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 13 Aug 2026 13:24:59 +0800
X-Gm-Features: AUfX_mzZzQmRZILknlJIv6ejE-5eDTI0rjiUkJOz-kNEw92ys28j5UtyPvJ_j58
Message-ID: <CAGXv+5GBS205Ww1C74+Jxu1Wop5Sh2ZS0Hdub9y7uOSM4L1r_w@mail.gmail.com>
Subject: Re: [PATCH] drm: verisilicon: fix cursor offset field update
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Icenowy Zheng <uwu@icenowy.me>
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

On Wed, Aug 12, 2026 at 11:48=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.a=
c.cn> wrote:
>
> The 4th argument of regmap_update_bits() expects a pre-shifted register
> value instead of the field value when it's used to set a single field,
> however I forgot this when writing the code setting the cursor X/Y
> offset fields, thus the write operation doesn't happen at all (because
> of the non-shifted values being masked by regmap_update_bits()).
>
> Fix this problem so the cursor is correctly clipped.
>
> The framebuffer address is also clipped so the cursor offset problem was
> previously not discovered, and the framebuffer address deserves another
> fix for proper cursor behavior when it's clipped.
>
> Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Make sense.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/=
drm/verisilicon/vs_cursor_plane.c
> index fa4f601dd0c87..4ce311ae48823 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> @@ -199,7 +199,7 @@ static void vs_cursor_plane_atomic_update(struct drm_=
plane *plane,
>         } else {
>                 regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>                                    VSDC_CURSOR_CONFIG_X_OFF_MASK,
> -                                  -state->crtc_x);
> +                                  VSDC_CURSOR_CONFIG_X_OFF(-state->crtc_=
x));
>                 regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output)=
,
>                                    VSDC_CURSOR_LOCATION_X_MASK, 0);
>         }
> @@ -213,7 +213,7 @@ static void vs_cursor_plane_atomic_update(struct drm_=
plane *plane,
>         } else {
>                 regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>                                    VSDC_CURSOR_CONFIG_Y_OFF_MASK,
> -                                  -state->crtc_y);
> +                                  VSDC_CURSOR_CONFIG_Y_OFF(-state->crtc_=
y));
>                 regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output)=
,
>                                    VSDC_CURSOR_LOCATION_Y_MASK, 0);
>         }
> --
> 2.52.0
>
