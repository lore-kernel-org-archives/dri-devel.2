Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0703DFD5F87
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 676C110E56F;
	Wed,  8 Apr 2026 08:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e+go+3hH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E596E10E56F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:24:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 169506012B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6F4C2BCB7
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775636669;
 bh=p8snXDTvA83wx+z5qiKDkwfDO/dPo6ful3ps5EMzPP8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=e+go+3hHB/xrKR5ciAs/42wJnNe6RnqeQM6GogovQqEtjIrTxF13jYf0hD1yaxxHA
 y4bvv2jrh3wZHzBtHS3zNaT8snvyFlziqw+XP+/WYNDgCgMJ+jVZ6fMhicI/iPUpqK
 NTtGnrQhH2qgDF+tcjaMlW+KhTjUzBGAABPTKa669SZ629m1UA8pNAs2ocKtwrQ/Rv
 vKB+IbKKR/1WPRA+zzQ6Z7R/Ff/D449+Bo/1cUTmskZywHwiFjaO6BoJjr1Gm3uh3L
 EI3w+i5qytIVAWZulDA0lS1NaCpcHaGJFOxtHZstCbAXrVWkFCnVh3wFaYxL3V8P3N
 EeZwn6SRVTRZg==
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-7986e538decso62914017b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:24:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWgPATivw0Ty2J2oNXpvbUX3Elz2ofK8KhL2CBNuUqjTfqO6ykXgmFqunxm9rb6byHPYcLbpHe09pY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzn5TJAxaRFtJkyDmGc6EkeM49NPRn5gujXwpW6bd6LsRVcVnRX
 mFqHWgv4FUYar0q8Br+dDkYmE4vMVvJP6buTON3Ld32OQWhL97AJ1i0n4hS9LJJlN7QnI1dGv63
 iqm/5e88HYLalkyMn0Zvdj8tFHgO+/pU=
X-Received: by 2002:a05:690c:3481:b0:79b:f4e1:a5b2 with SMTP id
 00721157ae682-7a4d6c2907fmr212257147b3.22.1775636669037; Wed, 08 Apr 2026
 01:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-14-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-14-5e9119b5a014@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:24:17 +0200
X-Gmail-Original-Message-ID: <CAD++jL=jUd4sQ1bhwcBRYpFFApP6vdJw2BoQwxoWShUKdEb9oA@mail.gmail.com>
X-Gm-Features: AQROBzAMBfnRdAnK4bRwU75AOx83F-jAcWPeGS0EtIQgTCQ0qxVMP0p6zzWqMTM
Message-ID: <CAD++jL=jUd4sQ1bhwcBRYpFFApP6vdJw2BoQwxoWShUKdEb9oA@mail.gmail.com>
Subject: Re: [PATCH 14/19] drm/panel: jadard-jd9365da-h3: support Waveshare
 DSI panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, Jagan Teki <jagan@edgeble.ai>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org
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

Hi Dmitry,

thanks for your patch!

On Wed, Apr 1, 2026 at 9:27=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Add configuration for Waveshare DSI panels using JD9365 controller.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Some more words with details on all the panels added perhaps?

> -       desc =3D of_device_get_match_data(dev);
> +       jd9365da_switch_page(&dsi_ctx, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x41);

Predictably I'm not very happy with all the unexplained magic and nonestist=
ing
defines used here. Do you have some info/defines?

But there is also one more thing, this looks like a big "jam table"
with just register+value tuples, so construct something like:

struct jadard_jam_tbl_entry {
        u8 reg;
        u8 val;
};

static const struct jadard_jam_tbl_entry jd_3_4_c_init_jam[] =3D {
        {0x00, 0x00}, {0x01, 0x41}, ...};

(Ideas taken from drivers/net/dsa/realtek/rtl8366rb.c, take a look
for code and all, you get the picture.)

Yours,
Linus Walleij
