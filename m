Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FFAFCD0DC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EECC10E05C;
	Wed, 18 Mar 2026 08:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="UlbXah+O";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E0210E05C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:45:26 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-665634cb208so5573883a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773823525; x=1774428325; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2NVg5azhBgjIMGuyOtSlU5XnHGYpWJdykiqlxTKsf8=;
 b=UlbXah+OYRDWett8UrYjATT1DR9mvuror3wihD/u6XIRqWZfgpfgxtwz5G5PLDZK1M
 zZ9O+CoIZMHrRvKLihRhrpQ1oO+0gAzuMB0a87Pn7Z4UwwbUhAUHCsd2iGWBKRYCV2g6
 nmA7Ae+aQqIC9Cv0sqvvNvpvTHhTmmaxuEWn0BL1tDYp9L2bgcBWayppnoB7ecnZ+aE1
 R0Jv8IKD51LFK4OGdiLDWhQPi2RorPKeUlpqsyu1F/i5/lPjyQHFao+K27AF3DnTIzSH
 k2EORc3NGYIxUDEYO/GrSSYeSshgrYAT4vMUR2jzxglFkBiGQRldyOKmOxw7Ih3oMSNL
 Pt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773823525; x=1774428325;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M2NVg5azhBgjIMGuyOtSlU5XnHGYpWJdykiqlxTKsf8=;
 b=Bk1AIz8zjxX230JHyVVsLFMGrnW6BwDl5BN252LaL1wKPnON0iCgN9IynteQYWC5WM
 /ex7I4/yMiQS7WyZiNcTrw1vhG7IvZ5zONSwFxGTH5v2wF4nf1FjfKzkffJUNUbA3d8v
 /XXUmE8k1TGO1m8M93O1T1+lxTfu36REqDi/BCRiXiXv7gApljM4pbOvtRn3EN+D1EdL
 IY9Tl7BLVyXdg+9nnvM0zlFK1a0lFzHVEDNQsBsznS6Dbf7Y1Rby6YIXhUAErlOjo/nd
 4ZPom6EZ1P3UoQ8p/c2lQoS5kgsJHGkWgJsdXypIsGg3aPZf/w8+OQzNWHwW6xPygx7m
 ApJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5UaW7rxco6s5e4RyasnGV35FEXUTQU+MFhZO5mGJhTo1v0V5OA3bofjpZ3awotYNvYpH3Ku7vt2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzc4stwsur5B2fBswWuDj4WtgMnEfPQoOooNWtkdsO03M9HQDCt
 XiFxRH13Y8mMY5S2FgFgStAcg7GnBn3cGXR+TN/dZ/fvPF7Ptt97FF7y6Gz5jseFDLY=
X-Gm-Gg: ATEYQzzBYd40bYkZVbNrlsOvk0F8k0JhyqKV5vvlBi8ARJCwUNtFwzdUYqHKiXtVZFP
 +txq7Ht9CUs1Y3HAW5BMnV2JqAQ1CnKuM/zHZRHZeZ2lVTjgy08ks9z0DzGFilOuYj4K11dU1Ct
 GCE6Z/UAbQIMBkRkJBiQwSvRLhMt41CjRIwZuz6Yw+9OvoX0LtOgcZROE+XzzTotyVdxds3oM86
 AX+XuprJaMyqHQJUa2Y5p2p+Z2lrYbkXfRHooBp6wej8Ow6ZltJKZ9Oh7wWHPThuWK/k7hMnknQ
 SdEp0k9X2QaAA5kLef+jaEKhWHc/CrqPYDY2e7J4qWwDFl0bGWfNoLLd1MCDq0XdKaLGoToQAV4
 c36PpdAcbbwNIIkvARVATMJDG+Ypo7FRUAL/fbEVMDLdmI1PZHrXGXGYdFFeVz+JuC+jZYv/yIt
 xuImtKSTpdmTl90Vym/Ad0nNHJ5VfgmbzC51rKr/lVr1UOzHDkyn7tGDv/JViM9zwUZxUx
X-Received: by 2002:a05:6402:144b:b0:666:d8bb:85ea with SMTP id
 4fb4d7f45d1cf-667b06e45e7mr1800366a12.0.1773823524789; 
 Wed, 18 Mar 2026 01:45:24 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-667b0eb986esm1186045a12.17.2026.03.18.01.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 01:45:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 09:45:23 +0100
Message-Id: <DH5RYL9A77TQ.QE2CS4OFZ1LT@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "Mahadevan P" <mahadevan.p@oss.qualcomm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Krishna Manikandan"
 <quic_mkrishn@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] drm/msm/disp/dpu: add merge3d support for sc7280
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260101-4k-v2-1-712ae3c1f816@oss.qualcomm.com>
 <DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com>
 <tbi5mwg4jt5scvr76lpzpvi5zj3kn3entoorsd4dior4g23czd@xtobadslhfrz>
 <DH437ESQRIAF.2336WF7XZBTI@fairphone.com>
 <7tcmh65lhy7t452mwkiv37pxqwh6dbuh6voelaag6kph7tfr65@cskiwvoafbdy>
In-Reply-To: <7tcmh65lhy7t452mwkiv37pxqwh6dbuh6voelaag6kph7tfr65@cskiwvoafbdy>
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

On Tue Mar 17, 2026 at 6:45 PM CET, Dmitry Baryshkov wrote:
> On Mon, Mar 16, 2026 at 10:08:47AM +0100, Luca Weiss wrote:
>> Hi Dmitry,
>>=20
>> On Fri Mar 13, 2026 at 6:14 PM CET, Dmitry Baryshkov wrote:
>> > On Fri, Mar 13, 2026 at 09:33:18AM +0100, Luca Weiss wrote:
>> >> Hi Mahadevan,
>> >>=20
>> >> On Thu Jan 1, 2026 at 6:04 AM CET, Mahadevan P wrote:
>> >> > On SC7280 targets, display modes with a width greater than the
>> >> > max_mixer_width (2400) are rejected during mode validation when
>> >> > merge3d is disabled. This limitation exists because, without a
>> >> > 3D merge block, two layer mixers cannot be combined(non-DSC interfa=
ce),
>> >> > preventing large layers from being split across mixers. As a result=
,
>> >> > higher resolution modes cannot be supported.
>> >> >
>> >> > Enable merge3d support on SC7280 to allow combining streams from
>> >> > two layer mixers into a single non-DSC interface. This capability
>> >> > removes the width restriction and enables buffer sizes beyond the
>> >> > 2400-pixel limit.
>> >> >
>> >> > Fixes: 591e34a091d1 ("drm/msm/disp/dpu1: add support for display fo=
r SC7280 target")
>> >> > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> >>=20
>> >> This patch is causing display regression on QCM6490 fairphone-fp5.
>> >>=20
>> >> With this patch in 7.0-rc3 (or 6.18.16) there's just pink noise on th=
e
>> >> screen. When reverting this patch everything becomes working again.
>> >>=20
>> >> See also https://salsa.debian.org/Mobian-team/devices/kernels/qcom-li=
nux/-/issues/41
>> >>=20
>> >> @Dmitry: Can we revert this for later 7.0-rc, in case it's not fixed
>> >> quickly?
>> >
>> > Could you please provide the resource allocation parts of
>> > debugfs/dri/0/state for both working and non-working cases?
>>=20
>> Working (patch reverted)
>>=20
>> resource mapping:
>>         pingpong=3D# # 68 # - - - - - - - - -=20
>>         mixer=3D# - 68 # - - - -=20
>>         ctl=3D68 # # # - - - -=20
>>         dspp=3D# - - - - - - -=20
>>         dsc=3D68 - - - - - - -=20
>>         cdm=3D#=20
>>         sspp=3D# - - - - - - - # # # - - - - -=20
>>         cwb=3D- - - -=20
>>=20
>>=20
>> Broken (with the patch)
>>=20
>> resource mapping:
>>         pingpong=3D# # 68 68 - - - - - - - - -=20
>>         mixer=3D# - 68 68 - - - -=20
>>         ctl=3D68 # # # - - - -=20
>>         dspp=3D# - - - - - - -=20
>>         dsc=3D68 - - - - - - -=20
>>         cdm=3D#=20
>>         sspp=3D# - - - - - - - # # # - - - - -=20
>>         cwb=3D- - - -=20
>
> As we have identified that the issue is what downstream calls
> DUALPIPE_3DMERGE_DSC topology, could you please also check several
> things (with the broken kernel):
>
> - What is being returned by dpu_encoder_helper_get_3d_blend_mode() (in
>   the broken config)?
>
> - If there is any difference in working and broken configs between
>   values being passed to (and programmed to the DSC) in
>   dpu_encoder_prep_dsc() ?
>
> - The same question for pclk calculation in dsi_host.c

Is this helpful?

Broken:
[    1.247165] dsi_calc_pclk:649 DBG pclk=3D111546490, bclk=3D83659867
[    1.490559] dpu_encoder_helper_get_3d_blend_mode:309 DBG BLEND_3D_H_ROW_=
INT
[    1.491008] dpu_encoder_prep_dsc:2061 DBG dsc_common_mode=3D0 initial_li=
nes=3D1

Working:
[    0.998043] dsi_calc_pclk:649 DBG pclk=3D111546490, bclk=3D83659867
[    1.233836] dpu_encoder_helper_get_3d_blend_mode:313 DBG BLEND_3D_NONE
[    1.234277] dpu_encoder_prep_dsc:2061 DBG dsc_common_mode=3D0 initial_li=
nes=3D1

Or do you need some more things? There's a lot of data being passed into
dpu_encoder_dsc_pipe_cfg() for example so I'm not sure which values are
relevant for this.

Regards
Luca
