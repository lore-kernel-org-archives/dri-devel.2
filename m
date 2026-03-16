Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A07F013F0
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC58010E384;
	Mon, 16 Mar 2026 09:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="3T8sV3C3";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD5B10E380
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:08:49 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b976536806cso503083766b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773652128; x=1774256928; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkQ3ltXCFznTU4ceGv0LPxbwLcaDE8cpGKaOEA1BzBs=;
 b=3T8sV3C3Sj1N8WkQHwd7DVADJnbQ/W+R0DDD+eAMdKyr3slwBX6vHwHb9j+STrux71
 SB8NQEw3xC+RAmeGmL8flPxVbjhC+boZBnNGSGLOyiHlQ2uXtWpoOssBEmvgal8u4we1
 iIAClIibE0EnBZJi3cc8lCNYd1HPX8WObq17rwIsA6F/8n+R4JDuAyCx59VdsqXLIMZX
 IL5krfcupaDqdTtHbABBl8nE16wt2UjH491vRbHgCRaazQAcjqcj0n0awTN9qqHPb8oE
 JZTsWOsB/ecSDJCdNLF2AHkpK/dytHVBQRHJLPKiWJaZ5uu/2vSxvs6a/rALs3OMgH/d
 RHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773652128; x=1774256928;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MkQ3ltXCFznTU4ceGv0LPxbwLcaDE8cpGKaOEA1BzBs=;
 b=m+qN2WFeoR4+9C5xgc0xOsHkpCz/j4RHvv3qKfLD+JYI65tD/yklSXd8Al+fp86o32
 uG9jXoJSMfzwWOSOGQlYdA48ieFpfi88MhxDCjkkfz4MeQz3qOMWBKHRmU87uunqFBWH
 qhtHHZa/pTY9IHDde3dAtFGr8/eTW9DHiOyXujAztwd4h6P2SpopXEAs6Mrp3a/Ddxua
 C+aNqfvu5nm8U29gCBACRBqaNeSIu0Z84nlMWNRhPP9CEcxcvnYf2f+gufUKtFteOS/y
 0BhrEnfaiHEq6qBmduVb3jKp1DO17rJh+RG+pkZ7ZUUBCjHUQYDSGVxM2yXGmqnLEO2L
 Fiqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAeCONgXPigLGEFUX7Kv59hfkTSymIBXa1U2DlEvLJiEGv0TnVrzGP3EYXAOW+oC6eOwypeS6gMKA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBslF0KKlwGLSxWVEYYvMMnZ39P9IRKjoMbrY8HfwjLqTXlnR4
 eLoXlYFE5ci2EeYc1SzSFiEWit+tKU8wSWQOFdaH51UMG2BdFGhwlouIso4TD/EbnSk=
X-Gm-Gg: ATEYQzxqB/rA3I153lO+gg2Lv9zeVWKEQ/PkQxzbdp+j+a2W7UZNX8fc1UBARcwi+Io
 yait9FiEDHFxO6NOnjwFG2MBipMA46mRxzhEy7Ghp0neFPaWFjHF5R3EC/6eQmi2jEk37HmFwzv
 BFdW0x4hmLNLwep7TFEKbFavD7XfnLweZlXgEgrH8FgPuQl8ejAa/4jpXSTQcN40+Svusy5TWk3
 cTr2bpHR2KppIwB6c20KNwwgDUhRoj17ZRdRICByUK/64S/KzqiXpEQsNS+7FKWAsbY97BeIOcG
 nHm+i63z6dkODCbPDDA/wvtI41sSBpKT0uDcwQEWm1g6NfGJHekR2Wloe50x0sj6/bdMb91yUQl
 RukwY/NSlWpN6VmGxXeEHHo0Bkk1Up5L0xmyd5p6mBaxlHAZer6t2j4t/qQJxuage+QjTjpBLdY
 voWnQMf6qvRHGECFmEJLbBRr0SuifTzunfqlS9DfpV5Tp11/78SA0uKnhK05/R4nZMw1Kw
X-Received: by 2002:a17:907:3d4c:b0:b87:b0ba:5d2d with SMTP id
 a640c23a62f3a-b9765410045mr711976966b.57.1773652128251; 
 Mon, 16 Mar 2026 02:08:48 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97afca45c3sm229016866b.13.2026.03.16.02.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 02:08:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 10:08:47 +0100
Message-Id: <DH437ESQRIAF.2336WF7XZBTI@fairphone.com>
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
In-Reply-To: <tbi5mwg4jt5scvr76lpzpvi5zj3kn3entoorsd4dior4g23czd@xtobadslhfrz>
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

On Fri Mar 13, 2026 at 6:14 PM CET, Dmitry Baryshkov wrote:
> On Fri, Mar 13, 2026 at 09:33:18AM +0100, Luca Weiss wrote:
>> Hi Mahadevan,
>>=20
>> On Thu Jan 1, 2026 at 6:04 AM CET, Mahadevan P wrote:
>> > On SC7280 targets, display modes with a width greater than the
>> > max_mixer_width (2400) are rejected during mode validation when
>> > merge3d is disabled. This limitation exists because, without a
>> > 3D merge block, two layer mixers cannot be combined(non-DSC interface)=
,
>> > preventing large layers from being split across mixers. As a result,
>> > higher resolution modes cannot be supported.
>> >
>> > Enable merge3d support on SC7280 to allow combining streams from
>> > two layer mixers into a single non-DSC interface. This capability
>> > removes the width restriction and enables buffer sizes beyond the
>> > 2400-pixel limit.
>> >
>> > Fixes: 591e34a091d1 ("drm/msm/disp/dpu1: add support for display for S=
C7280 target")
>> > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>>=20
>> This patch is causing display regression on QCM6490 fairphone-fp5.
>>=20
>> With this patch in 7.0-rc3 (or 6.18.16) there's just pink noise on the
>> screen. When reverting this patch everything becomes working again.
>>=20
>> See also https://salsa.debian.org/Mobian-team/devices/kernels/qcom-linux=
/-/issues/41
>>=20
>> @Dmitry: Can we revert this for later 7.0-rc, in case it's not fixed
>> quickly?
>
> Could you please provide the resource allocation parts of
> debugfs/dri/0/state for both working and non-working cases?

Working (patch reverted)

# cat /sys/kernel/debug/dri/1/state
plane[44]: plane-0
        crtc=3Dcrtc-0
        fb=3D71
                allocated by =3D phoc
                refcount=3D2
                format=3DXR24 little-endian (0x34325258)
                modifier=3D0x500000000000001
                size=3D1224x2700
                layers:
                        size[0]=3D1224x2700
                        pitch[0]=3D5120
                        offset[0]=3D0
                        obj[0]:
                                name=3D0
                                refcount=3D6
                                start=3D00103729
                                size=3D14680064
                                imported=3Dno
        crtc-pos=3D1224x2700+0+0
        src-pos=3D1224.000000x2700.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
        color-pipeline=3D0
        stage=3D1
        sspp[0]=3Dsspp_0
        multirect_mode[0]=3Dnone
        multirect_index[0]=3Dsolo
        src[0]=3D1224x2700+0+0
        dst[0]=3D1224x2700+0+0
plane[50]: plane-1
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
        color-pipeline=3D0
        stage=3D0
        sspp[0]=3Dsspp_8
        multirect_mode[0]=3Dnone
        multirect_index[0]=3Dsolo
        src[0]=3D0x0+0+0
        dst[0]=3D0x0+0+0
plane[56]: plane-2
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
        color-pipeline=3D0
        stage=3D0
        sspp[0]=3Dsspp_9
        multirect_mode[0]=3Dnone
        multirect_index[0]=3Dsolo
        src[0]=3D0x0+0+0
        dst[0]=3D0x0+0+0
plane[62]: plane-3
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
        color-pipeline=3D0
        stage=3D0
        sspp[0]=3Dsspp_10
        multirect_mode[0]=3Dnone
        multirect_index[0]=3Dsolo
        src[0]=3D0x0+0+0
        dst[0]=3D0x0+0+0
crtc[68]: crtc-0
        enable=3D1
        active=3D1
        self_refresh_active=3D0
        planes_changed=3D1
        mode_changed=3D0
        active_changed=3D0
        connectors_changed=3D0
        color_mgmt_changed=3D0
        plane_mask=3D1
        connector_mask=3D1
        encoder_mask=3D1
        mode: "1224x2700": 90 311156 1224 1256 1264 1272 2700 2708 2710 271=
8 0x48 0x0
        lm[0]=3D2
        ctl[0]=3D0
crtc[69]: crtc-1
        enable=3D0
        active=3D0
        self_refresh_active=3D0
        planes_changed=3D0
        mode_changed=3D0
        active_changed=3D0
        connectors_changed=3D0
        color_mgmt_changed=3D0
        plane_mask=3D0
        connector_mask=3D0
        encoder_mask=3D0
        mode: "": 0 0 0 0 0 0 0 0 0 0 0x0 0x0
connector[34]: DSI-1
        crtc=3Dcrtc-0
        self_refresh_aware=3D0
        interlace_allowed=3D0
        ycbcr_420_allowed=3D0
        max_requested_bpc=3D0
        colorspace=3DDefault
connector[36]: DP-1
        crtc=3D(null)
        self_refresh_aware=3D0
        interlace_allowed=3D0
        ycbcr_420_allowed=3D1
        max_requested_bpc=3D0
        colorspace=3DDefault
connector[39]: Writeback-1
        crtc=3D(null)
        self_refresh_aware=3D0
        interlace_allowed=3D0
        ycbcr_420_allowed=3D0
        max_requested_bpc=3D0
        colorspace=3DDefault
resource mapping:
        pingpong=3D# # 68 # - - - - - - - - -=20
        mixer=3D# - 68 # - - - -=20
        ctl=3D68 # # # - - - -=20
        dspp=3D# - - - - - - -=20
        dsc=3D68 - - - - - - -=20
        cdm=3D#=20
        sspp=3D# - - - - - - - # # # - - - - -=20
        cwb=3D- - - -=20


Broken (with the patch)

# cat /sys/kernel/debug/dri/1/state
plane[44]: plane-0
        crtc=3Dcrtc-0
        fb=3D72
                allocated by =3D phoc
                refcount=3D2
                format=3DXR24 little-endian (0x34325258)
                modifier=3D0x500000000000001
                size=3D1224x2700
                layers:
                        size[0]=3D1224x2700
                        pitch[0]=3D5120
                        offset[0]=3D0
                        obj[0]:
                                name=3D0
                                refcount=3D6
                                start=3D00103729
                                size=3D14680064
                                imported=3Dno
        crtc-pos=3D1224x2700+0+0
        src-pos=3D1224.000000x2700.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
        color-pipeline=3D0
        stage=3D1
        sspp[0]=3Dsspp_0
        multirect_mode[0]=3Dnone
        multirect_index[0]=3Dsolo
        src[0]=3D1224x2700+0+0
        dst[0]=3D1224x2700+0+0
plane[50]: plane-1
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
        color-pipeline=3D0
        stage=3D0
        sspp[0]=3Dsspp_8
        multirect_mode[0]=3Dnone
        multirect_index[0]=3Dsolo
        src[0]=3D0x0+0+0
        dst[0]=3D0x0+0+0
plane[56]: plane-2
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
        color-pipeline=3D0
        stage=3D0
        sspp[0]=3Dsspp_9
        multirect_mode[0]=3Dnone
        multirect_index[0]=3Dsolo
        src[0]=3D0x0+0+0
        dst[0]=3D0x0+0+0
plane[62]: plane-3
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
        color-pipeline=3D0
        stage=3D0
        sspp[0]=3Dsspp_10
        multirect_mode[0]=3Dnone
        multirect_index[0]=3Dsolo
        src[0]=3D0x0+0+0
        dst[0]=3D0x0+0+0
crtc[68]: crtc-0
        enable=3D1
        active=3D1
        self_refresh_active=3D0
        planes_changed=3D1
        mode_changed=3D0
        active_changed=3D0
        connectors_changed=3D0
        color_mgmt_changed=3D0
        plane_mask=3D1
        connector_mask=3D1
        encoder_mask=3D1
        mode: "1224x2700": 90 311156 1224 1256 1264 1272 2700 2708 2710 271=
8 0x48 0x0
        lm[0]=3D2
        ctl[0]=3D0
        lm[1]=3D3
        ctl[1]=3D0
crtc[69]: crtc-1
        enable=3D0
        active=3D0
        self_refresh_active=3D0
        planes_changed=3D0
        mode_changed=3D0
        active_changed=3D0
        connectors_changed=3D0
        color_mgmt_changed=3D0
        plane_mask=3D0
        connector_mask=3D0
        encoder_mask=3D0
        mode: "": 0 0 0 0 0 0 0 0 0 0 0x0 0x0
connector[34]: DSI-1
        crtc=3Dcrtc-0
        self_refresh_aware=3D0
        interlace_allowed=3D0
        ycbcr_420_allowed=3D0
        max_requested_bpc=3D0
        colorspace=3DDefault
connector[36]: DP-1
        crtc=3D(null)
        self_refresh_aware=3D0
        interlace_allowed=3D0
        ycbcr_420_allowed=3D1
        max_requested_bpc=3D0
        colorspace=3DDefault
connector[39]: Writeback-1
        crtc=3D(null)
        self_refresh_aware=3D0
        interlace_allowed=3D0
        ycbcr_420_allowed=3D0
        max_requested_bpc=3D0
        colorspace=3DDefault
resource mapping:
        pingpong=3D# # 68 68 - - - - - - - - -=20
        mixer=3D# - 68 68 - - - -=20
        ctl=3D68 # # # - - - -=20
        dspp=3D# - - - - - - -=20
        dsc=3D68 - - - - - - -=20
        cdm=3D#=20
        sspp=3D# - - - - - - - # # # - - - - -=20
        cwb=3D- - - -=20

