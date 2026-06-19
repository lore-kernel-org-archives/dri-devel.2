Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0970CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EAF10E089;
	Fri, 19 Jun 2026 13:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MxiYJK4E";
	dkim-atps=neutral
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0759310E089
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:30:17 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5ab02fb66easo69738e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 06:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781875816; cv=none;
 d=google.com; s=arc-20240605;
 b=EC/O9DKKxFLdEsMbQkE9MJtYAI/M/7FxrTiNZJ3Z976OLeLuZsRqwF4X7ymYUcRbI9
 1TMgZZ/iBfE+wl6/IppbMmd3ZlyJf+mtkI/Ki1io5Iw4SS+NrrZK+XyPO9fJNkev5G7d
 xufPtqY+q77O3yimGOCZF/TEY4ksK33Xmld9ltlHswQ1bArqQ1ATkyt3+Jcd4Qb3N6mQ
 7Vn3LnTq6hfXOgSZBpFXKA05yvqFrhPBv/bpmqawAKU7idSR6brEqRORxovDcOOm88oV
 kmgf14l3lg/XeokuSqvNS80j5krOBU4dnxj/J3leI0DogSe6vh/MSvu7wFfhnm3r3vhf
 k1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+BAkjpfWQowdjBsNdaaNxgIzUMsqo46Arsowlr/gjUc=;
 fh=SjeO/ljsx08g4upEyIludirStYiRbEM/GhPx+a1tMl8=;
 b=VuKBssIe9YRx/I5mQa5hQCLckm8sLxrDlPr++zpbmI6D26OWJL8GNEwP/L8/CL86xL
 HY3kBZHRqNdDopIMrU3QoHA7cpto7mYy801Fp2dLErvjNbZkAhpaxEh5lGcQT3pxcLsN
 Zp4+TRG84d+FGHx9NvwKQPrU8aCLiotOfOnu3dcyXM5jAcp8p38Ge8yJSMlbdM/aeMzf
 pgtu949EtuhBcnEQgE7V1EFeYHP18Kzqhs+ptZ84Fu6h8IerUGiLEXEfOmW23VBP2ly/
 HyWrqmAjhQYLPoDPWApCIaTvaCDxFkAPseqRgGal+cxRLr7jZrtQjdTmWVL17PpPd/D7
 L3NQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781875816; x=1782480616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BAkjpfWQowdjBsNdaaNxgIzUMsqo46Arsowlr/gjUc=;
 b=MxiYJK4E7LO7WpPp+VcNsM/B3/oOCBcjOnezmaYE51fH+k/lCSGQRQhFZE4BrnijNI
 Op6j3PKx0ISp1E53ASi8r82/CGPVWnIi+sVwgqBUfJVmdR58M7/ijfZg+xvyTpXMq5dr
 6rOJUo599cnlx+4a0XY6ExI7lC4YyQY2lPKVJRFCIIf8e84Qh5JyBvY408JqOV0gdp3b
 mrKvXX0X5O65kH08pGVXF3cEt1rW5ucNoRpoc1hTt+Y4dR9moL9ajd2r4XMIwTVDVhhc
 SBPTKuz91J05VaIah9LJCSWbc7CtL7qaRBpS0oHVfUZN59gH2H8DnL7SDYpJx6zvPOBw
 UhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781875816; x=1782480616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+BAkjpfWQowdjBsNdaaNxgIzUMsqo46Arsowlr/gjUc=;
 b=qEopoO82obhRrsGWVKgW+TQB3CTuTs9IQw3Gn9jBSLu6cRsVp8HJFh+tRib7dCY2/H
 uyqZUbdbMS++8A44XxTuTDAOepS/0d4YMYlEuACiDhIcx0nFeNr2P6acAZoyzaYy5n41
 H7Bsabpoq3m6eDBJvfGgtSHeTHP4jXiMMjIuiMM1bY2c/yMAeD42SxcUVF0bRuQC2GbV
 7Pph66BEWSrYuKSTOsCtX0BVpi0G0iRm6rESF1fWdxqrH2agvpATAZxGjZNKACQHKk2+
 KrhtFSjbI8nzNycu37fts/kBUmGmMu/sfI172jyti6/yaHpeXachZnMCugS/vWKlzIyf
 cg2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rgzrbV5toPKXwnC6eS9lvuFmZb3HI5MCyka8De22BbWjlTf56swC7T9KPJZuqWiIlRPcdN09Axa4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK1/WHaAuKmGNroJQoM55k1RjVjK91hwz/8KdpghP3m3/MjdGC
 X+BFCQJyrjcWHPJHo7yZkRbU76Q5QCR2QuMyI/3t0k6dohDFVbVHOUgHz0ipikXep9zUeyDH9ek
 5uzv3I8jKmZZtmukofluIiDDpKZlxNEs=
X-Gm-Gg: AfdE7clntPtMAd1+dh/vLHQrHbpTr3kLXa8Vzz6WEzXq1qLiIVFakHsLaPgavWJ/U9Z
 D8R0VTopI9kMDIXA4U++bR17lFWOheoqZa1Fodg1DBkj1ZMrjV+0Smd9iCghOgMWuIxnnXXe59y
 8LuwDFSlMWeGVy5ulodZmEwgFiHGWk7EW/gHe5f/HzEion1paqCQGvJMe59mNRkmMy11l2ybp4k
 co2yGd5zSIsgUMovaGxGMq7DiwbTfDc86l/+kGyG+mwzwh14+zKajqk7hDkRCeJcoSQXSiZXp5Q
 A3mXSk/bBHb9Tl5K0fSEdYtUKaOIjCz/yPZDyVs6hW2eL5DpVuKC2JkvCaY=
X-Received: by 2002:a05:6102:1620:b0:674:84bf:8e0a with SMTP id
 ada2fe7eead31-72b16d7a278mr196403137.7.1781875815754; Fri, 19 Jun 2026
 06:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260519030624.51613-1-leorize+oss@disroot.org>
 <20260519030624.51613-2-leorize+oss@disroot.org>
 <CADnq5_MrUaLRP70hwb5YGawjfft9qUaH4h_t4TQ17AEgAwj3ww@mail.gmail.com>
 <1f24aee4-8588-4d54-ba5a-cc5e9c002a54@disroot.org>
In-Reply-To: <1f24aee4-8588-4d54-ba5a-cc5e9c002a54@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jun 2026 09:30:02 -0400
X-Gm-Features: AVVi8CeVOSc_6Z1h6askeKyU8KcBbZJ7fycBobyYUlTtvuSIqWN8dX11pHGRATM
Message-ID: <CADnq5_NHskZySwM3pt9yPkAGRmS6JHGnh=TyKv4==dkL+9wR=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/display: set MSA MISC1 bit 6 when using VSC
 SDP for DCE 11.x
To: Leorize <leorize+oss@disroot.org>
Cc: "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 linux-kernel@vger.kernel.org, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Thu, Jun 18, 2026 at 10:03=E2=80=AFPM Leorize <leorize+oss@disroot.org> =
wrote:
>
> Friendly ping. Should I resend this patch?
>
> On 5/26/26 7:52 AM, Alex Deucher wrote:
> > @Leo (Sunpeng) Li
> > , @Wentland, Harry
> >
> > Can you take a look at this?
> >
> > On Tue, May 19, 2026 at 3:19=E2=80=AFAM Leorize <leorize+oss@disroot.or=
g> wrote:
> >> When BT.2020 colorimetry is selected, the driver sends information usi=
ng
> >> VSC SDP but does not set "ignore MSA colorimetry" bit on older GPUs wi=
th
> >> DCE-based IPs. This causes certain sinks to prefer colorimetry
> >> information in DP MSA, resulting in terrible color rendering ("dull"
> >> colors) when HDR is enabled.
> >>
> >> This commit wires up the MISC1 bit 6 for GPUs with DCE 11.x based IPs =
to
> >> correctly configure sinks to ignore colorimetry information in MSA,
> >> resolving the color rendering issue.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4849
> >> Assisted-by: oh-my-pi:GPT-5.5
> >> Signed-off-by: Leorize <leorize+oss@disroot.org>
> >> ---
> >>  .../drm/amd/display/dc/dce/dce_stream_encoder.c   | 15 ++++++++++++++=
-
> >>  .../drm/amd/display/dc/dce/dce_stream_encoder.h   |  3 ++-
> >>  2 files changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b=
/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> index ed407e779c12..2c3a20d35fe9 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> >> @@ -271,7 +271,6 @@ static void dce110_stream_encoder_dp_set_stream_at=
tribute(
> >>         bool use_vsc_sdp_for_colorimetry,
> >>         uint32_t enable_sdp_splitting)
> >>  {
> >> -       (void)use_vsc_sdp_for_colorimetry;
> >>         (void)enable_sdp_splitting;
> >>         uint32_t h_active_start;
> >>         uint32_t v_active_start;
> >> @@ -334,6 +333,16 @@ static void dce110_stream_encoder_dp_set_stream_a=
ttribute(
> >>         if (REG(DP_MSA_MISC))
> >>                 misc1 =3D REG_READ(DP_MSA_MISC);
> >>
> >> +       /* For YCbCr420 and BT2020 Colorimetry Formats, VSC SDP shall =
be used.
> >> +        * When MISC1, bit 6, is Set to 1, a Source device uses a VSC =
SDP to indicate the
> >> +        * Pixel Encoding/Colorimetry Format and that a Sink device sh=
all ignore MISC1, bit 7,
> >> +        * and MISC0, bits 7:1 (MISC1, bit 7, and MISC0, bits 7:1, bec=
ome "don't care").
> >> +        */
> >> +       if (use_vsc_sdp_for_colorimetry)
> >> +               misc1 =3D misc1 | 0x40;
> >> +       else
> >> +               misc1 =3D misc1 & ~0x40;
> >> +
> >>         /* set color depth */
> >>
> >>         switch (hw_crtc_timing.display_color_depth) {
> >> @@ -499,6 +508,10 @@ static void dce110_stream_encoder_dp_set_stream_a=
ttribute(
> >>                                 hw_crtc_timing.h_addressable + hw_crtc=
_timing.h_border_right,
> >>                                 DP_MSA_VHEIGHT, hw_crtc_timing.v_borde=
r_top +
> >>                                 hw_crtc_timing.v_addressable + hw_crtc=
_timing.v_border_bottom);
> >> +       } else {
> >> +               /* DCE-only path */
> >> +               if (REG(DP_MSA_MISC))
> >> +                       REG_WRITE(DP_MSA_MISC, misc1);   /* MSA_MISC1 =
*/
> >>         }
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b=
/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> >> index 342c0afe6a94..88d6044904d1 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> >> @@ -96,7 +96,8 @@
> >>
> >>  #define SE_COMMON_REG_LIST(id)\
> >>         SE_COMMON_REG_LIST_DCE_BASE(id), \
> >> -       SRI(AFMT_CNTL, DIG, id)
> >> +       SRI(AFMT_CNTL, DIG, id), \
> >> +       SRI(DP_MSA_MISC, DP, id)
> >>
> >>  #define SE_DCN_REG_LIST(id)\
> >>         SE_COMMON_REG_LIST_BASE(id),\
> >> --
> >> 2.54.0
> >>
