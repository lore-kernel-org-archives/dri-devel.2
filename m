Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED7606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Nk381qPW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C84D10F32C;
	Tue, 27 Oct 2026 09:32:02 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5506310F1DC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 23:55:38 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-917a707f37eso36144386d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793058937; cv=none;
 d=google.com; s=arc-20260327;
 b=JhbVzYGTphpNeccf4oDpz39jQry88hke6KKJuXLlpMcFlE/MAbHn2sz9bQwKehekc1
 zbm24WfKhIII4XTqTLG7DYEp8CJhYgO6KImfjL7Ss4dMIG6r4r3gQJdrqR/AU64ew1/7
 yuebVwGi826hbdXAXlpztbGEjhJAcWgQnFN0LBsdlSP48jjgUNC9RGlWH5/B6zmEojmJ
 u8B78q3Az82ukNz8z2EIjZ399zF7KPOur/BvnZYvpFD1SGpZQMY/4tLoNDIGixYTojLj
 eZXISx3Z3M+uJVji5UJneB/FzJKasae0vzJyTgvb9VAshXdSnPS1SAV7U+Pxqq/WhGR+
 9hCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZzMX7mFcIWh7Kuz+dntrLxcfYo0Pt/pLtJ3pm/q59a0=;
 fh=tebb6WgXc6eGFlXvVbLZ8dUlw3FGkdob6on3Vp1cVos=;
 b=j6JNU8xs0SL2Lvi9mcRtB1MUXPwORyV+u6dRRK96rXUdhqjey+r+ktVv2gm0J9FVj5
 NvnguSqlQGIezt0gEVoJu0DN1BggBt+M2pwAWl95qyBS+TQHQy9H6WrNPl2rktLtqWQ1
 ucNyRhopu6Jq4UKz8wQDHsXXJLoUAdWbuLmtc2XFua8PQfAIvQmrCCWa0SQg4jF06fyW
 r/6ht+mkMjIt4AlrdjoBzQ0LTBgzyqxOMCuSadqdC5y2vLbZR/2482AEcjtcyG/We+hi
 84w9SiJ73Z3J9phZWh45Eie7CbEfABW+xD0zbWiVWw8i/3FCIKWJZQxvw9QR1UI/Ai+A
 s3/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058937; x=1793663737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZzMX7mFcIWh7Kuz+dntrLxcfYo0Pt/pLtJ3pm/q59a0=;
 b=Nk381qPW7Qo//j8jf+nuWgcFRTyic4edQUkoIqw9bWgfi1CzYVdgkhf4JxtlBb/P5w
 e5hWNaOvgZTfMdR+B44ABCEMUpsleT1KnvCpzVE/e4btD8oh33OjfEaaft9pMuxz2ftg
 KHFJodsqdiqDgbSmvTESY0Zk8s0XJC4I32kBNH5r7yJ92W2kE38yj5SwF/0PHtQIkBn7
 SyPPOH4Q9npX6t0Ee+G5eOtgmL1AkA6FDb2ERQ10n/LB/Eor0aEm9c7Yh1F/ju72Pzli
 T1SUJrbrboG8mxxCbE45sU8dkUcURf6MUAGmp4dpKj2iSk2StJ9DO0U2E3UlRBLYpBBv
 ytiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058937; x=1793663737;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZzMX7mFcIWh7Kuz+dntrLxcfYo0Pt/pLtJ3pm/q59a0=;
 b=MH4dCJkcjdfuhmrYW2qi27jchMEwGYGSGvDy0Iyf5XhqSQJVykCiKEGwaSpVP6AUTE
 Vl6FpC9BIy8Mnw50uLUEXT9k1WGT6FrC8+BUONGFSiuW1ENCNvRbFw7DBh4BN65bs7/G
 /e3NuD43pn0wXUqsUzEWMlzmfQKeePxcdK+lR6jWWK52TVLAl/yO35uF5+326j4MGDaC
 4Q8RLURUDI+ycDzj3RiCErTPXYkWIWdNc0qQcHKCwYNi+DnwuyQuZEcbKMiQHwpRhCjQ
 XS4K/s5PO8r2YF1CP390exSkUIDtc3F2CpEmUBTSXVuB5T5sI3o5/DcvcGh58sW3fpVi
 z1rA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWJ28gpcMj/TARrIAVfAtfBGfw3befwnXI6hntai3PFkdUVRHdpEHohpU127rplbT1EhZ7MhoQ+Qw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJg9wrTKmxXYaRz0yXu1fe9Wl4PYpY/hA0uQX++nn8I+GyRb4CQ
 OgAIkQxLLftJF2H61v3pn1+kKYYKAt3JBp1SkH7ACnA485OtO07Cp/Q88rEtAP4oFTkrMOVLgKX
 A3FLP26toIqGm5yEeZPSqwpU49xsmEnc=
X-Gm-Gg: AYBFou1JVOTRuvgZR+TkfLw1VX6kutTMvfmQDCqRWrKCdc7kDzv5eybkaOmk/x8yx2X
 lupryvfSU+rpqBlDIUgroieU1agIwIn/VacoDlE7D8HrvCJbDYBLjTUjmkWK80qhvN8aK+aXGkA
 OaszTOLv/Z1lSIAiAmnNT2OEjijg+dhgxnX35x49cYFOXl5ncjsZnYnLFn58CfwRadg1b7bWNQE
 NyczcUZpvdawzZhgl+n9Q2U8mdOW9+g3BMhyS0b4C23oInH05vv591RB798pQs8W7EeKPleQrrT
 XyYdPs9rSwgdv6ZJk2xUVyqs71dR3FKFVUlRdtEVefMoHpPwYvXozMbrrlTWo5VeV7XJ8PhPdsM
 meaxwFk5xdwAEdmGbW8s3yAfbvQjLJ3gYVQDi1A==
X-Received: by 2002:a05:6214:3c9d:b0:91b:a702:cc5b with SMTP id
 6a1803df08f44-91c48d21df9mr142161736d6.7.1793058937159; Mon, 26 Oct 2026
 16:55:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
 <20261026-msm-dpu-res-clean-v2-1-3d864435186e@gmail.com>
 <498e2fa8-b707-4a06-9fe7-9e62253786c5@packett.cool>
In-Reply-To: <498e2fa8-b707-4a06-9fe7-9e62253786c5@packett.cool>
From: Xi Zhang <xz.ca.cn@gmail.com>
Date: Mon, 26 Oct 2026 20:55:20 -0300
X-Gm-Features: AclHuK8LbWKXuTefwbNDto9JuTcVHDIAbeMY8N4dmB0dUoKxhMwBSYQlkgp2Y_c
Message-ID: <CABxuLgMHx+ZvkL=Rs7R2N=cO8Vtyc8FktZ4nUzmCRD=WdorWMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/msm/dpu: reset unassigned resource slots to
 NULL on topology update
To: Val Packett <val@packett.cool>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 8:04=E2=80=AFPM Val Packett <val@packett.cool> wrot=
e:
>
>
> On 10/26/26 5:25 PM, Xi Zhang wrote:
> > While this is not currently the case, it may be possible that topology
> > for cwb and dsc resource requirements change between mode set in the
> > future.
> >
> > e.g. when dsc support is added to DisplayPort, dsc may be optionally
> > enabled and disabled between different modes due to
> > bandwidth requirements.
> >
> > Set unassigned resource slots to NULL on topology update to avoid
> > issues in the future. It's good practice to do so anyway.
> >
> > Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 22 +++++++++++++++-----=
--
> >   1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_encoder.c
> > index 0a6be69a3e83..8d2b4d2726f2 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -1205,9 +1205,13 @@ static void dpu_encoder_virt_atomic_mode_set(str=
uct drm_encoder *drm_enc,
> >                                                      ARRAY_SIZE(hw_pp))=
;
> >       }
> >
> > -     for (i =3D 0; i < num_cwb; i++) {
> > -             dpu_enc->hw_cwb[i] =3D to_dpu_hw_cwb(hw_cwb[i]);
> > -             cwb_mask |=3D BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
> > +     for (i =3D 0; i < ARRAY_SIZE(dpu_enc->hw_cwb); i++) {
> > +             if (i < num_cwb) {
> > +                     dpu_enc->hw_cwb[i] =3D to_dpu_hw_cwb(hw_cwb[i]);
> > +                     cwb_mask |=3D BIT(dpu_enc->hw_cwb[i]->idx - CWB_0=
);
> > +             } else {
> > +                     dpu_enc->hw_cwb[i] =3D NULL;
> > +             }
> > [..]
>
> I've mentioned in a reply to v1 that this was indeed affected by the DSC
> changes in radxa's WIP, but missed the more relevant one:
>
> This is already handled by the "drm/msm: fix SMMU fault dumps" series:
>
> https://lore.kernel.org/all/20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@os=
s.qualcomm.com/
>
> Namely patches 5-8 ("drm/msm/dpu: clear the ... blocks ...")
>
> Thanks,
> ~val
>

Thank you for the reference link!

Also thanks for the radxa mention. I have some msm/dp dsc work
for the older v7.2 kernel and could use those code reference.

Awaiting comments before removing the overlapping patches
(1 and 5 of this series) which have more complete fixes in the
series you linked. There may be other issues with my series that
sashiko bot didn't find.

(I'm using the gmail web interface reply-all, hope it's doing the right thi=
ng.)
