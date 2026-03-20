Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383491098781
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F36B10EAC7;
	Fri, 20 Mar 2026 13:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UerhYKOg";
	dkim-atps=neutral
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A9910EAF7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 13:15:36 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-94dd01deb53so116101241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 06:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774012535; cv=none;
 d=google.com; s=arc-20240605;
 b=JbYWqTqvgkzyOv9dM7y3mo9HyfiB15oNSPGTRq7jOfV/OiSUaeGzjFHCGRWFKwy2nj
 xTc7iYHK7Cz/CODhk09M/klzIpU7D62JKIbku7dv0Ue7sHjKP6totckXXdx4Oa9T6Ekh
 Zpi/ZYM3JAjCZOslzhxkkM8TU/GVv1iSQXzck7WCEpTSpuwCgfvGFmoDsZ0Sqhr77Bw2
 BLwdodsM1/soJLFOZmohJXguLq8y50iMOm6oEgXwyFrL4vGoW3PBTK3dKu6LvbyYGuIC
 cF+Eih+1FwpMTY8yKQVCsomUtnVeEZnmRQ5j5wnWIkbWPopQ90u/7dGozem0/wOG0FJb
 M7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=odrQtLUC1LiaxHstWMqEvhv3vLw/22xn8F6ptFJZ6CY=;
 fh=7zfpbIEWQGqp9H4AYnx1FzM8f5+SjkuRiLGP7xHZsco=;
 b=XRZAxEPnP9ING6p2IIsYeTOtKCpFzVb2MGhYLd5cSmtQ+VyHtwjIqRYt78Tb6g0OII
 3orDEjNR/hk0CjaQo9icID3j1NN4ZO5qhb2NwY/9Tara/XgUgIEhXYtrKW0hwqABkQZ6
 MbW5OR0GOhIBsxXVB1xGmHylzvgdIK7RcxJ3ORMO4ZtMvy+B1WJ5XU9fOScYGACS5o/7
 66sO/+57T+4Yce3IhHVQKiuuMecw/SnaM3ySr8J1Cw+lcijyazAMemNrJvfa4MVyNoUo
 NH6Jzqh8qUoJX9I4kYHSQGGyFGol58pYnQRsFUOlXth0FxeYmXLmQl7KOsNqTAYkdvGo
 Sx+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774012535; x=1774617335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odrQtLUC1LiaxHstWMqEvhv3vLw/22xn8F6ptFJZ6CY=;
 b=UerhYKOg+bqXbDVXmoI/8Cqck+k6G2RuBnzTE8b/2UOWucLOVMEjGzImWV6/DnuKXS
 ShubCTxbFoKoMdWxS5+hncxg2l27j53iLq3S+WytPt11jVmrdlQmGdnQT0JcQi4vGwwU
 xei9W2KjNS1guEswu7vInXz6qhbE74tVdgyaKIadTbfBw7ibpCX9E9g2BVFdeOoWZ5Zd
 7bzx7VWeup8Q0bCmYv7TIuP4D/dShWEv64XoaN+q3tpNBI+dx2pq3cLAnEe+oVwzf1Zl
 KxyteugDB5yy9+jK2eHixHzSTZSiHiK0DQHIxXcRiPd+e8bkmkpMmTUnb5ssvM1gM0Ek
 ha+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012535; x=1774617335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=odrQtLUC1LiaxHstWMqEvhv3vLw/22xn8F6ptFJZ6CY=;
 b=WLi+rXPsNHb1U/mpjGQtkEoFhrRQR7rtmnBNzHo21Gt6/7kOM39B4STmzKTuBFim6V
 LeuyPsNsiUu0GgpDl87VZ59TvgGd4bUm4j3tJQn0wQ/uTPN7SDBI5ZOVGU4abv0bDAFo
 sb28qBAUwz8JblVNTMUJUZwlGJrT7JK6ZZuxJsXszBV+Q+TTH0QEewR2AyFAkZJ/mFCA
 hIuonlQH1rjMg3G+CrsOnl7awWIswyzMouAO2DQhGXBe0a6+qHuxrhadYh6znbxZq3uY
 6HG+Xcs7KZvE1wxKXNTeyeAktQ5bBbnV75RTkPx3h/375bGM16DBKG5AzO2c9jO/WUji
 D+gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxlQ/LZKG3mVvDbsQ507Ya4yYEXa/mvRxLZvPo8mCBmeYVZhWcAe7sTBVBq93bn6H77hpLLwyfnZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6Rul4xWjjHyof+ko1K8u3v6GMto1J4O6Guya4uOgFPOzgHdE1
 Q5FXcZ7gEGzk4PowPwQg6yObkLcpe+fLIvVKlk77dBCyZfIiRm2hyYrXRpCG8yFGCvm/3U4xG0B
 2qaE7jyc0jGPE7ZqXJJ3fKJIJMsVkxdY=
X-Gm-Gg: ATEYQzwQQzl9VN2HTU9KJLUpepfM8HrNtdkbZ9xewlznNBkj+b8CrGOK0XTnJ9bK60b
 a1p9Cou8uwt9IIsF53/FHfctM2SMGiCDCKVtpGRZlRoARCzp1aTrDRD/xlMudA0n20UxGNx70Z1
 1abipWfeUQNiGL6IVLM+TTBI1Iqnwo+OSMHZ/h0oZXscRN/SBCKN+QKbRGU05kKjCCVK5+Xzdwm
 PE5Xw0x40eMJhK+Jyox/jlSrr/l+9JGAwG0yP2PYLvsf5Or5OC8yZ1V5kxWzNh1cDvhHoCiFh18
 rCpBErbi0fPkp8DVgzM=
X-Received: by 2002:a05:6102:94b:b0:5ff:ed38:187a with SMTP id
 ada2fe7eead31-602aeabdd86mr1418984137.5.1774012535018; Fri, 20 Mar 2026
 06:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-dsi-dsc-regresses-again-v1-1-6a422141eeea@somainline.org>
 <CAH2e8h4qnF3UxWFrU59BrStWMDc-=Vz9ZNmuq8Q3smhHeUzxyw@mail.gmail.com>
 <a2xtesu626vmfetdoykojm33at44h7zxgvo6ytf2txlg6gn7ls@34jctkwswjnk>
 <CAH2e8h4p4fyoPXTcjbhSXVgWEm54PH_=yCWiCGWOsDaMZu1bvw@mail.gmail.com>
 <5vqqcoggq3mrwc567jhrondk6m7vfpth57wu3gyvyjjkezfmnl@mqzlarjlsgcx>
In-Reply-To: <5vqqcoggq3mrwc567jhrondk6m7vfpth57wu3gyvyjjkezfmnl@mqzlarjlsgcx>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 20 Mar 2026 21:15:08 +0800
X-Gm-Features: AaiRm53VnGIV9WWkU3ahSecjRfkUcxmeN_g-2CCLzAJ0oe1y1iaTq0NNNOCxNiE
Message-ID: <CAH2e8h5aM2WacbHqwLDCoNrmWOk835ork7hLVHXo+fUFuDN41Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Restore widebus calculation for CMDMode
 panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Fri, Mar 20, 2026 at 9:06=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Fri, Mar 20, 2026 at 07:26:22PM +0800, Pengyu Luo wrote:
> > On Fri, Mar 20, 2026 at 9:59=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 01:10:07PM +0800, Pengyu Luo wrote:
> > > > On Thu, Mar 12, 2026 at 6:31=E2=80=AFAM Marijn Suijten
> > > > <marijn.suijten@somainline.org> wrote:
> > > > >
> > > > > Commit ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when
> > > > > programming dsi registers") makes a false and ungrounded statemen=
t that
> > > > > "Since CMD mode does not use this, we can remove !(msm_host->mode=
_flags
> > > > > & MIPI_DSI_MODE_VIDEO) safely." which isn't the case at all.
> > > > > dsi_timing_setup() affects both command mode and video mode panel=
s, and
> > > > > by no longer having any path that sets bits_per_pclk =3D 48 (cont=
rary to
> > > > > the updated code-comment) all DSI DSC panels on SM8350 and above =
(i.e.
> > > > > with widebus support) regress thanks to this patch.
> > > > >
> > > > > The entire reason that video mode was originally omitted from thi=
s code
> > > > > path is because it was never tested before; any change that enabl=
es
> > > > > widebus for video mode panels should not regress the command mode=
 path.
> > > > >
> > > > > Thus add back the path allows 6 bytes or 48 bits to be sent per p=
clk
> > > > > on command mode DSI panels with widebus, restoring the panel on d=
evices
> > > > > like the Sony Xperia 1 III and upwards.
> > > > >
> > > > > Fixes: ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when =
programming dsi registers")
> > > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > > > ---
> > > >
> > > > Apologies, I messed up, I had sent the same fixes days ago.
> > > > https://lore.kernel.org/linux-arm-msm/20260307111250.105772-2-mitlt=
latltl@gmail.com/
> > > >
> > > > > In addition I can't say I understand the original commit message
> > > > > at all; it mentions a BPC=3D10 mode however the highest format th=
at
> > > > > mipi_dsi_pixel_format_to_bpp supports is RGB888 thus it won't
> > > > > ever return anything above 24, which is the original amount the
> > > > > non-command-mode path defaulted to (regardless of widebus)...  Wa=
s that
> > > > > patch doing anything for video mode at all?
> > > > >
> > > >
> > > > RGB888 is the dst bpc, which is tied to qcom,mdss-dsi-bpp in the do=
wnstream.
> > > >
> > > > Actually, we should use src bpc here, another fixe
> > > > https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitlt=
latltl@gmail.com/
> > >
> > > I'm really torn between your two patchsets here.
> > >
> > > Marijn, Pengyu, what are your testing platforms and are you testing
> > > video or command mode panels?
> > >
> >
> > SM8750, I am testing on a native 10-bit video mode panel.
>
> Is the framerate correct for you?
>

30, 60, 90, 120, 144, 165 work for me, in 24 dst bpp, 30 src bpp.

It failed to set pclk clk rate when I set 30 dst bpp, 30 src bpp, but
172992000 is right and works for 24 dst bpp, 30 src bpp.

Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_mode_set: set mode:
"1904x3040": 120 915552 1904 2180 2212 2244 3040 3066 3070 3400 0x48
 0x0
Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_pre_enable: id=3D0
Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_power_on: id=3D0
Mar 20 20:46:00 qcom kernel: msm_dsi_host_reset_phy:
Mar 20 20:46:00 qcom kernel: msm_dsi_host_reset_phy:
Mar 20 20:46:00 qcom kernel: dsi_calc_pclk: pclk=3D172992000, bclk=3D108120=
000
Mar 20 20:46:00 qcom kernel: dsi_calc_pclk: pclk=3D172992000, bclk=3D108120=
000
Mar 20 20:46:00 qcom kernel: dsi_link_clk_set_rate_6g: Set clk rates:
pclk=3D172992000, byteclk=3D108120000
Mar 20 20:46:00 qcom kernel: dsi_link_clk_set_rate_6g: Failed to set
rate pixel clk, -22
Mar 20 20:46:00 qcom kernel: msm_dsi_host_power_on: failed to enable
link clocks. ret=3D-22
Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_power_on: power on host 0
failed, -22
Mar 20 20:46:00 qcom kernel: msm_dsi ae94000.dsi: Power on failed: -22

Best wishes,
Pengyu
> >
> > My thoughts are we should restore 6 for the cmd panel, and we should
> > fix video mode too.
> > As I mentioned, I overlooked something, I thought the cmd panel didn't
> > use the value, which
> > made the value for the cmd panel wrong. So we can restore it for the
> > cmd panel (though I can't say why 6).
>
> 2 (wide) x 24 (normal bus) / 8 (byte)
>
> --
> With best wishes
> Dmitry
