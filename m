Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C57F3380B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A5610E4B7;
	Tue, 17 Mar 2026 07:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="nVzIsZ8u";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1FE10E510
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:47:14 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6615c766e60so8624106a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773733633; x=1774338433; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URtMf0QMNmyDbkNY3uQV2w4aEQAMl03HuCtwS6fp77Y=;
 b=nVzIsZ8u20CfwbRMgDEOfplT7vosIKpOw8YA72qixRPJDDNnhPMIi8tmfn0USZjuJF
 Bu0atyZupaX+D3J4PpN4Bj1VzFXU+iJPrvFG91RbzNVKLdFuz8VnaqMAFK3AELJN9Nkc
 eyfG3D7i6sctaF7C6RzSmpT+RvOOR4nFL2gwQygUHeCf6b4Bfw6HGQUvzcY8AmVVGxy6
 KNfgDLJ/e2ta1BMkUhVGyp5EGFaGgMTdywY8LTRffENIGJujqZIIiw6ii76m95zoRQP5
 v8x4sq+/pzGHPCgUUofrjq1uUCt5KP4xR33R4MagBCFSou6j85ciAfaI4hfpDMiPQCKB
 //jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773733633; x=1774338433;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=URtMf0QMNmyDbkNY3uQV2w4aEQAMl03HuCtwS6fp77Y=;
 b=I71QY4o3hZkxUbTfFA3wdJbORsKDhEpoD/3N+wZUlQ3yBFzM9lX/C1cmcItPBSvlLd
 C3D4OSYV/apybWfccPBt+ARKpXh4VoVQNPTjtgbC+41JNA1PxzkGK5Ftcu6MqxL2L0Yc
 UJmiTEPMtJXq3XGEnnVq2ZdvFkUkNwo/6+snLNGs2p1jhQCq03TNPfn0Y6F1OYtPoquI
 5yL1ZRxfhYpBfmIYFfXMHY+RDKDJk+TsfCRjzCOpvWxFmL6ZLuyCPfV78JjXDaoE4KFn
 CLfjvP7pAeJBwVlwossYAgh2FRG5lUjevY5ANcd2YeLBEU31pS+9OC8n2+TT0wWiicT0
 SrNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXATJEg9b9ORolxyVrVPcWl4Xnuv5Q3RltM5XscMnpYgDrFVVtOTw0WNKu+Lunprf1YqI96rSYxv+g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLWM2d8LlFoXWwIf1Q8ZHKu1GIjZu5lFsTQgaJbMnRO5bp8xdH
 8rXmmjUSFvAuXxyA08gVo9JmZDYnFcB5FevW8lu1MINjcng9cy+uIGoRKdvO/rCbbwU=
X-Gm-Gg: ATEYQzzaJFFgROYRK0kZnjSLRBfI/gZ4JXAi5mnd7N8pH/jymPipRA0K45I919dGQZy
 8ed0OTKjXOht816MnfxgVUF+JVQgM8hbqbXlJP6JMT8SsAmqchcZ7DUNgJWpOTl65sx5Uie8SDR
 j2tQsZ6A1WqmM87xrL8+P+qdPARDbByHQ0cxZuhdrkL251AXA1/YaGvOZLngy1hP+0gQ6rrZKIz
 qvToAvP569vTIaKoiPKHYjKSocAizQTUgOErm14jKaip+EjQhdwAXCgCerMy1hYrWoaPoRHkNSi
 71tW8XCMoIyiG57Zsat173eAk0EzWh9RJJfX3eja3KRDybFCwO1NZB5dKK4FNEK+uCtx2bWFis0
 FsWFzZc6YlGgSLr5AAcp1Ga5/eQshiAj8dazIvlTBEXetVEp5yVi/gfGmQedUxkyKgQDvlVVcbR
 g2zy62aqnUSiIBmYJLz+IZHOKhZ6Jjivc1G4n5XtDD6eWzayHyIX7baXv1dPjmEbIpRm/9
X-Received: by 2002:a05:6402:27c7:b0:665:20dc:cb44 with SMTP id
 4fb4d7f45d1cf-66520dceb70mr4727389a12.29.1773733632583; 
 Tue, 17 Mar 2026 00:47:12 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6670b92e7e0sm985353a12.11.2026.03.17.00.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 00:47:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 08:47:11 +0100
Message-Id: <DH4W3H5N4HQG.GAHFYE9XGEI5@fairphone.com>
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
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260101-4k-v2-1-712ae3c1f816@oss.qualcomm.com>
 <DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com>
 <tbi5mwg4jt5scvr76lpzpvi5zj3kn3entoorsd4dior4g23czd@xtobadslhfrz>
 <DH437ESQRIAF.2336WF7XZBTI@fairphone.com>
 <twm2kcouzbwew4md27f3o36q5odpctlfugmkakxom7b2ittftg@qb7golmack6c>
In-Reply-To: <twm2kcouzbwew4md27f3o36q5odpctlfugmkakxom7b2ittftg@qb7golmack6c>
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

On Mon Mar 16, 2026 at 8:54 PM CET, Dmitry Baryshkov wrote:
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
>> Broken (with the patch)
>
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
> I see. It tries to use two mixers with a single DSC. What about someting
> as simple as:
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 0f4921b1a892..cbb7caa194c1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1410,7 +1410,8 @@ static struct msm_display_topology dpu_crtc_get_top=
ology(
>  		topology.num_lm =3D 2;
>  	else if (topology.num_dsc =3D=3D 2)
>  		topology.num_lm =3D 2;
> -	else if (dpu_kms->catalog->caps->has_3d_merge)
> +	else if (dpu_kms->catalog->caps->has_3d_merge &&
> +		 topology.num_dsc =3D=3D 0)
>  		topology.num_lm =3D (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
>  	else
>  		topology.num_lm =3D 1;

Thanks Dmitry, this also resolves the issue!

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcm6490-fairphone-fp5

Regards
Luca
