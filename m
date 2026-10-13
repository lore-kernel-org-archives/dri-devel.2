Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADFCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B282810E731;
	Tue, 13 Oct 2026 04:38:49 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AB610E737
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:38:38 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so1688449a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791866317; cv=none;
 d=google.com; s=arc-20260327;
 b=YQQ5DouKlllXwbEgx+otX2Lu0fJqX/imJWaB++8avqa5cppOpuD16JLQZsAkyQykhy
 VeLR4+Fm0y0Xd68AyCD8xSAgu64AunOqRvO0iTMArexFtc1G7H5hq5cmQZM3qraOEhB7
 IBu0f5sIOJWYytqV9nryDQBNFJEqbsDSNqPVI/yaiO0Vd213oQgzVBqGV+SxEnlknfNJ
 CtImo5+d1J244hshzhDdG6/D/oHzBSGv8HbAulHQTUOxHE8J/IujpKGZRt+24eYD5WD4
 DUbOpWrBlNrC5yQ2DJU6IywB0bRmd1qNHMmFFyrtZJG7aOvQkb0fsOHYzHepwnP4rDbi
 hx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pxgu3fx9TRD8oVfDId+xboYyQW4bMqWkiNr1MMvb6gs=;
 fh=usjD67MRtvsKAlvOHymb1XQ68gQ6vZoRGwOOoKGDJBY=;
 b=BhuWE0nod4HiXanVQOHBqiwzly1HbtPgVpCJQW9myt+ieC6o00oL8eW2wmS7y0Io++
 0dhrNsKz99uwBCjPjjerttGSb4yBpIBPBWGO4hbdFF3O3wq5Dzy7f1zvb+KlnnTbqMBN
 N4sk/vpq6C+rlFHEzXCj1qULBofT+ONlWVI8GbzhQ87wMdS7DzR12y+mt9PQxc0P2e29
 gn3uE0jsXg2BqboOhdbQBZCyX6HYMREz3oNKUviuM1Xqb8GDU4NmipdogDfcGkBRGvTr
 jJefSPgrAVrPMk9KQi42yeACx8Vo344ENZ/p8ZuOHHzXCc/N+ZBiLONGTsz+pWFE8Ojp
 yV2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791866317; x=1792471117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pxgu3fx9TRD8oVfDId+xboYyQW4bMqWkiNr1MMvb6gs=;
 b=AjvyP6jCaDZMGgkSQ3AqmOxTeUGD2jpu12E0CPgSl19l1yYMMnTSRbFjFBM+P3NGvl
 GR9pXbEZl5LzAKGRwyR/xJuR8AS3KnqyUF0lnSSXM22xq+WzHDBXP91CzUxniXg1aH0I
 6WG8WVqgAsvYahDM/a1yHKezHqtCaH5l1azchxcjdJPlFP8DU7nImYlqL4ucFPJ4u6oF
 6iYF/ATUdY2G27u42ZbUk4IQF9siv5zT8dJPeQihH13sGlJN2whl3rd8V5KPDPzFtg3Y
 DWP7D/HBpZjBVcG2XxlyqY7HQwIOOJwzX/S+TWo3cW53K0yx/StOnd1QARWHwzOS7Oml
 xrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791866317; x=1792471117;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pxgu3fx9TRD8oVfDId+xboYyQW4bMqWkiNr1MMvb6gs=;
 b=aXIwJhyDl0RQcQQX2jLara9M7VWSJNzahstrBnX0AFv9j75l1n7Pm4IXqk0tRruQw9
 qYZkfun0HKNwmKaxInRYa8pGp+yWjVW9gXRrTDNHPJMDdmoudtoX4dTIJrRiRSoy8yXP
 1L3usFT8smVDLlTDW8Z2iplcA8pe7bvBuVl09KArjWEsF/HWBSU8vqt7xZYLFFjdks+g
 MgAvxFt3Lyk7CjtUtAANv5jayKz3kBtR17dL/Tyaz2dYlfRYTfn8Wv0btji502dKQywf
 CvExsfu2yj0Gx4Sjd8fkYz7Kx2KdSCoQ060QFrRZlGxxSL04wA9LxruHjMNojUN4bAU8
 Rtcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4HHlLij4Ed6T/pdMIv1p33CekW95FRhkz036oHUw4s/d6pvGIt+qEdETUW4At9XzDn+AnuNOUt8Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbQRlTdG4X37QyTOckyyFczPCX5aUQf/uCz8a8Gd8pZEMXwDNk
 yVGTiCxaAfd3MRHB1lSENI0GI5Y5Y0It/14e4sIFOui4qhs9VXywu1HNyptLsNIz217U5eIeUCQ
 bmiKPtyXb9d+HvVWhMZW1FvszZUbTFGk=
X-Gm-Gg: AYBFou26LgXhIEmppK8hGSwJfMy1iWtyS2KySCOQwtS7HkpCdjUFk8RXhAy58kvHJE/
 pAy2a5fI4sSKU/Q+/CXeNv9DZAQTGEUEE4noxrARtv10C4qlE+Ovs2ahx0icVffAqulu1Wa//W3
 TY5CSPYOyz3DXuPpwMEygamNLMBgD0lAkjKGk9ZI4SRxzlJPfakmH8N8Jdv42BIi3fpkX39GggO
 NFTII7iXFfjhCm8xJzWUEg4SXyQGitPblXtjWZ0MUY0TV88IyPs7ztvchFSZXjhGLHHwCGSeKQC
 QeS5BuFazqe9CI9ZNtRH29C+UuOhlBAdbJweDg+i7gGv83KyoJXX6P/Z1qYWvJ8w//R9R0zoAlY
 kPjU+r53uyfKF
X-Received: by 2002:a05:6402:1f82:b0:6a9:bb40:6de7 with SMTP id
 4fb4d7f45d1cf-6b17c2a2d54mr9683306a12.23.1791866317127; Mon, 12 Oct 2026
 21:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <179184923104.248043.14168731037113716140@mail.ustc.edu.cn>
 <CAH2e8h6_pACX_j8YBDhhSZzbfs45waF-Y6KJo82_2c6BT0suEg@mail.gmail.com>
In-Reply-To: <CAH2e8h6_pACX_j8YBDhhSZzbfs45waF-Y6KJo82_2c6BT0suEg@mail.gmail.com>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Tue, 13 Oct 2026 12:38:20 +0800
X-Gm-Features: AclHuK8ikXCMqYZWUZ4AdnSHfDjzbRjbXCHV1nm3CLE0ArHVljTTZwrpDStF-5M
Message-ID: <CAH2e8h7H5-DzTj1zwejYQyNNtupurgzYq4t6gKPZoZw=7EQvrA@mail.gmail.com>
Subject: Re: [REPORT] SM8750 bonded dual-DSI + NT36536: first DCS command-DMA
 timeout on cold boot (DMA engine stays latched;
 DSI-side reset does not clear it)
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, dmitry.baryshkov@oss.qualcomm.com, 
 neil.armstrong@linaro.org, abelvesa@kernel.org
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

On Tue, Oct 13, 2026 at 12:34=E2=80=AFPM Pengyu Luo <mitltlatltl@gmail.com>=
 wrote:
>
> On Tue, Oct 13, 2026 at 7:53=E2=80=AFAM Qianhui Xu <xiaqinghuan@mail.ustc=
.edu.cn> wrote:
> >
> > Hi,
> >
> > We are bringing up a Lenovo Legion Y700 (2025) tablet, TB322FC / Qualco=
mm
> > SM8750P, with a Novatek NT36536 panel (1904x3040, DSC, video mode) driv=
en by
> > bonded dual DSI (ae94000.dsi master, ae96000.dsi peer).  Our tree is
> > GEEKiDOS/linux, a 7.2-based tree that carries the bonded command path
> > (dsi_mgr_bonded_cmd_xfer() plus the "bonded command DMA failed" / "peer=
 command
> > DMA timeout" messages).  We could not find that path in the vanilla 7.2=
 sources
> > we compared against, so question 1 is partly whether it is upstream-sup=
ported
> > at all.
> >
>
> In a word, the panel driver is supported, the DPU may not be.
>
> I think most drivers for dual dsi dual dsc panels in the upstream are
> alright, but they may still not work due to the DPU. Once I upstreamed
> partial patches, but it is not enough, we need more, like we need to
> hack the dsi clk source select for the 10-bit CPHY plane, etc.
> Integrating such kind of patch to upstream is time-consuming and
> troublesome for me. Even if it works in Ver, nobody would ensure that
> it still works in Ver + 0.1, as there would be many features and
> regressions for the DPU when promotion.
>
> I cannot help with this for now, sorry about that, I have not focused
> on this for a while due to things irl,  You can find some threads in
> LKML about 10bpc 10bpp support on DPU discussions that I was involved
> in, it may give you some insight. You can also find some records about
> bringup, for instance, please check the image in this thread if you

OOPS, the thread is

https://lore.kernel.org/all/CAH2e8h4Vp9fJYAUUbOmoHSKB25wakPBvmpwa62BTRqgRQb=
MWuw@mail.gmail.com

Best wishes,
Pengyu

> are confused about if it is __really__ supported(i.e.
> https://postimg.cc/xJr11DK5, and another snapshot for GPU bringup
> https://postimg.cc/0zz30h8P).
>
> Best wishes,
> Pengyu
