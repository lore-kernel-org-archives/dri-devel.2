Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F21BCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93E110E490;
	Thu, 21 May 2026 09:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AAgc30Xl";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6597A10E480
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:15:30 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7bd9f61458eso42672757b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 02:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779354929; cv=none;
 d=google.com; s=arc-20240605;
 b=XAwpHsrfndWcza2nLnlLRJU1XhCAMoztwIpP80XV+TMOAKu4cstZmfG0pnKij0+mwa
 QA11TYzsXg779baC7fCbGLUly+WtKjOc3WTj/p7GpeJtm1pn3xZ+5H88vrFEwqgbN+WP
 Jg8j0rBMxDKtVBM9BrJ6imbEG/Cloaas+cL+g0YHovLUSYVA5gEgg19NPMjiB1RKCnt6
 L5zdvHvLJ04Xa/J9JzAIRBcvluQQe8E1a3iOBHXOz7pBdnzLF9ye8HCwYKmE2Fb+SU8D
 IZQylXljdV16DadyrH0fRN5pXZHoYyvFvuMPvCcvHuaTn5j02M34ymTVyKdzxFC70s3n
 4W/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wul7PQ9dnCs3HEM15phq9RQbj4uDgc1epjsFdUT+0UI=;
 fh=wRjsEOICTpSMB1iYFceK7mbrdoNo3s+N66mLzzxKaOA=;
 b=ENxWlMESkD0hKQF3F08vUjyrwoYbQ2QAN3yL6uWW9U7sJMUfBM8M9bTB8zIs+OjvMj
 7ELNyAjnTWcsSXxqELe0PaOdqQwi91O4tJ/vnXFIGseLpmNzYWg212/sUP762Sr8RS4+
 GGhJmVtGrAFOXVZNRJpQTQ1skV5BOVkQPA77HNRRhwIfUP8aEP95j/Tq1uNiNWHLbJgY
 EZeZb+iVncDTkKb7L48L81Ql3gZfqBEhuX+ElP4EUMcnKijpkQbSWnqhGT5HG0CKOaqF
 WFrfx9mSw/UjBVPLbcteVy5uo/hnOi0uxMYP36usnGYANQA/fobe+0pdMmVzqs74D3wB
 N5/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779354929; x=1779959729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wul7PQ9dnCs3HEM15phq9RQbj4uDgc1epjsFdUT+0UI=;
 b=AAgc30Xlm2dVolpoz/OublFJO57aqOIs/+ylRiNy5ngS61hNTjl7CHwf2JDuCf6xQD
 FBtU/ZSXA0Vq4C8J9InilA/1jgwCDPJweH5qOvzrMB0zhL4fThdKTCndOx5Rqe1ovmVk
 6VI5mBuLsNLmJCMzSEbR6U2qr/NRk4SJ8lvEYVhs5p+YZaLwlbx9AlFN6VvRtSzMVwSK
 9b5Sc2bKpaShbr4bTL9O2m9bywQycXa+Empf5I4MzWM0zy0F4UV5tl88kdL5YjI4KWH5
 6CaUDuRMw8vymLHBSMwk29HDUWoKcNJFFEjdOCFGU5ff1AHV5BjatC2kDhDAC1iEy2yU
 BCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779354929; x=1779959729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wul7PQ9dnCs3HEM15phq9RQbj4uDgc1epjsFdUT+0UI=;
 b=C40t7SB5hyizSOObBtJ0fw/TtAP369xRZav8t409BdeCzu8CUyvc5KQn36J4cmAaFz
 50zRn2Fr7V2iouvSYfbbMcmZoD3Rv5uh0R3DAyaWk+gsiKR8MPYtCrmI2muWHpf8V73N
 zW80u9tLuerf7Di0v6x8Sh90O9OgviPEEdJQe0edahSVccsqi86RkfFuHmoDytCe9OmO
 7ovaCwmIFV328V6xYC7BmI2T/x/bApW656lnd5n9Ri7qb+Xg2PDZvg6K2+wli2On5b89
 ip5PBnp63RDJk4jJdDnI8NFfPnwTnDHLhe4QBVFEa2cg4tYEra8dbwTVehq5VNK3XI66
 s6xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oWc5Fy+NqHF2b/wX1Cht7NYoN5uPbhOOj93dNa5NpHYm0DwZAaLFXcibtpsMKMeWlos1MjAKYmeQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMLQl9clnwGpM955K3/qNuf1rA7mxfIq3Cqhrmr5nQ7jl1DwOs
 IsQTECkTGRa69BX7wbGUF+LKkpTEVYm4jxlQvV+sJMEdqg5VHGtpcVr+ITn4OBgHwC2unH+NNSV
 qIK9bnkhNO5+koiuc/xK/p+iB7V7tJIO6RADgQAsXlw==
X-Gm-Gg: Acq92OFPc9Qay/o4kpwBuO/sBBodGJ6+Q49uz05YpxuKJA6XtuNlMIxzhMjSInXXrit
 9eiU/RoyAmlhr5L66PZea7IIeHvqkMtAmBylRpsfmSMnO9tU+cxVmGsM+JFchs6g/2/48eSC9U8
 ejB2s2gg+Z37+UzL82myvtoAmi8HQDo+JHLY6jPqaOFTVkqTIoQVrcgSe0JisfKMQ6RJFOwvrt1
 IHJ7fON0HYoD4VhKkD+qoS8Meezib2D4Hb5Xq6XhvKjcIQlphbM+yx9R6ZdeG4SepcqHtN2TVAO
 909g/XMGv48=
X-Received: by 2002:a05:690c:660d:b0:79f:4e02:50cc with SMTP id
 00721157ae682-7d20d9f3d3bmr20146567b3.42.1779354929128; Thu, 21 May 2026
 02:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-msm-next-quad-pipe-split-v20-1-bc1fdf140b81@linaro.org>
 <177928444226.2567181.13284983255649878415.b4-ty@b4>
 <a2gwkgdnbwp2wfunhmdhm5mwqolzm6fgb4ex6khkzy2jh356tp@dcauzez4445x>
In-Reply-To: <a2gwkgdnbwp2wfunhmdhm5mwqolzm6fgb4ex6khkzy2jh356tp@dcauzez4445x>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 21 May 2026 17:15:18 +0800
X-Gm-Features: AVHnY4L0d_ItiLs4Y4z4W88ffXwh8R1wfpZ0M3uA1qn4tDTMEcskSsbWmMbTgng
Message-ID: <CABymUCMqto2namFoSfqgLyoAUwva8xHw93yUUJBqLrZg6+Avhg@mail.gmail.com>
Subject: Re: [PATCH v20] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
5=E6=9C=8821=E6=97=A5=E5=91=A8=E5=9B=9B 01:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 20, 2026 at 04:41:29PM +0300, Dmitry Baryshkov wrote:
> > On Wed, 15 Apr 2026 11:15:11 +0800, Jun Nie wrote:
> > > To support high-resolution cases that exceed the width constrain
> > > or scenarios that surpass the maximum MDP clock rate, additional
> > > pipes are necessary to enable parallel data processing within
> > > the width constraints and MDP clock rate.
> > >
> > > Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
> > > high-resolution cases where dual interfaces are enabled for virtual
> > > plane case. More use cases can be incorporated later if quad-pipe
> > > capabilities are required.
> > >
> > > [...]
> >
> > Applied to msm-next, thanks!
> >
> > [1/1] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI case
> >       https://gitlab.freedesktop.org/lumag/msm/-/commit/218eb06a72bf
>
> And I'm going to drop it again.
>
> I tested on the SDM845, it tried enabling QUAD_PIPE for the follwing
> mode, which then broke the display.
>
>         mode: "3840x2160": 30 297000 3840 4016 4104 4400 2160 2168 2178 2=
250 0x40 0x5
>
What's the platform? To enable QUAD_PIPE, both virtual plane feature and 2
real time RT interfaces are needed besides width exceeding the constrain.
If all conditions in the dpu_crtc_get_topology() are met, why QUAD_PIPE
cannot be enabled on this platform, any other condition shall be added?

Regards,
Jun
