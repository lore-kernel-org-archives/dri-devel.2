Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DE7D58CCE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FE810E3BE;
	Mon, 23 Mar 2026 04:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mmp2Iv7U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwcKduBS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E86B10E3B4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MLtP4x2183706
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=oLpTgVGxCw1Fj4mzUbzinm41
 xv8ZtpXmsVNDwDSI2gs=; b=mmp2Iv7U/Lsn8vXrVk4G5/PqevSRVF/GQ2a682mW
 dsh8vBoTGCGHVz0180xz7QZ0lurm+hXLpwOnvgqKISfAeuakv33zx1/3ceqLh1hi
 G99OrHGzLduRuCWT7K6XEKdRpkXIAg50dMueywxC5lWJ6UqU5h+1FiLi1BYOLofB
 S3TPaxrLsqRpdIDXaDKFQwi8kJh7OEv2aG4VBQEypCFf9Zk9KKsEv/CLtbjViA3/
 SnJAZ+Z0rl9geb92WEsYOYVigUb8qA1Tovq3jOt2b8bMS28n7nv6aHKbvR6DxsYD
 FvG1PHdC5ZqJO0Al4684//nTxsN3ojxtYwenxmEFrxcPWw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1m3cuh8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50925fed647so324646051cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238906; x=1774843706;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oLpTgVGxCw1Fj4mzUbzinm41xv8ZtpXmsVNDwDSI2gs=;
 b=ZwcKduBS54d1TT0FVb50a8e+mIHg8LwtxsKkpa2rPRCpVIOU7XWG2zDUXT/+TCtfYi
 KDQVLJ01EyCLgalPTqe2hKNKglBT6tLASDj+zLnQvVuzv3lt32CglNXsXTNinuPzO/8O
 3hQ8wvKoR7dpBmKvlRdnE10UrdM3iMcUWGQJouc+/fGYs0Y/667U5xLYk6I1zr8oHMFR
 2EKjX2WwXSawmtvNSoBiUJ8u64Pz1R+OiziFvcj/roGCWdHYWGffMRntt8H0Daq24OKi
 /97f6I2Y0asx+4SDjqyUv+dJOLB9x9lkHp5KQXv+/zZxjklsFCtneSCOfTx5jlPiS23+
 mdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238906; x=1774843706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLpTgVGxCw1Fj4mzUbzinm41xv8ZtpXmsVNDwDSI2gs=;
 b=m80HcUockUc79H6UokVRqkub2z8r2ye7UeYNmOu2+uIPrhkxnQ1neo3bGRsnbgmvor
 dpHm8fV4Vz4O6WBGQuQ16TFlu2zpPKN6fDR+sYTHkBGyHSoF7BIeO3By9q4sRsGuy+Zm
 trgqRiAoe17gIAetKDV3LQp+l69JIp864hmmM4xDMI9Fe+ra+TtnI/77AtB7wHbUMt3n
 w73nfoANfTAA++7SUw5Y8g9kx9/H1s+jhD/gWy53afG7kfdYTP6FlatGRfxild9us92i
 sndkTWUQn0U1oAUm2uqHsBtVPkPoUNi++YH6soG3NnTNT5yktvWQ9UrPAMGjH+VIJo91
 kN7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW2bNj0LPMudYZx31473eFo0IFHT6AnN4G6ffldOVinHjFc3cRXFB8hmevJrMZd1F9yovAjrzt2k8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxm3/CVWnywt39AtQuhmes6Xeab/YYqeH22JnDTMokn70+KG9Ql
 iAZlttO2ygI+lVfLshPKAAIrSMAoTKfKwebNI1ATf44/t3qkVbUWyj9i3i1xCd92VzuZEwURHj8
 tBle3qFjVEEHeMUrZAZxiTRyLNrA3YTDtxWLrHT8X9UroLuV+Tz6bJ7KFw+ewG6EHlefxTQo=
X-Gm-Gg: ATEYQzzrJ41VXjCDWpprlpP1tI3elfCQgkV3ALPhqanE53xhSISqdWZaVgEXNma/lJk
 b7O7zKsQLimPySHyP3gr7Kmc3iK0vRiuqfRS8uiWXSXgvWxfGR6/y9t9ZqSnxk4xldNGw/LsNfm
 pGD9+N1IPARo32ulEqTNQQWPR+HL1+CRXPmGw9wqRGGToWwjwed7rbbrxr9IvVr0Oft0e64nKe3
 L9TnDqSI5sgAhqiQguafbYMwk+UFCV24ZuhwxjsJTd1mPabGReGbCIofsXp5WS8eRFXTDOJdzeD
 hFhjYGUpEzX9c8M5w6V69WNTp18MVlNu5k+ZYPVbg60DMHYfoC9uA/ehNa25KXslpX/2IhJHyf7
 yp7Z7c6gLHgz4aysso3EDrQdvCSa+MgK0OZQNaOtF2ahTCHs9psmac7B31CpwznkFOVEs9c3v3o
 3ONmJdU1QTgzJwo4RDx+y+8widC9DOaTb5+r4=
X-Received: by 2002:a05:622a:8a:b0:50b:5491:ddd8 with SMTP id
 d75a77b69052e-50b5491efd2mr63479661cf.58.1774238906018; 
 Sun, 22 Mar 2026 21:08:26 -0700 (PDT)
X-Received: by 2002:a05:622a:8a:b0:50b:5491:ddd8 with SMTP id
 d75a77b69052e-50b5491efd2mr63479501cf.58.1774238905598; 
 Sun, 22 Mar 2026 21:08:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285305e07sm2236969e87.66.2026.03.22.21.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:08:22 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:08:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 08/14] drm/bridge: synopsys: dw-dp: Convert to
 drm_output_color_format
Message-ID: <a4k7m57gx6gevmip3pkhpoxklzhki2r4ipjwftpiwefmoleomq@2ycnpl55t7ne>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-8-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-8-f3935f6db579@kernel.org>
X-Proofpoint-GUID: oqcln0SLs2-qHpQDfxGs-Yvuvr_Qm7w0
X-Authority-Analysis: v=2.4 cv=Z5rh3XRA c=1 sm=1 tr=0 ts=69c0bcba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CKux1-rmGPvPLlrhUF0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX8xqOUJKio9sM
 y6tG8fSBBhIkuO1lK54R32Ub54Wu8I8Lj1VRsxByXaI+kRSXnHave+89/NHJuN9MTqOQXiP8goB
 mVjxdm6D9x0Q0nn1kDXNOLy1XXalG05l5vslX7fqFjJ6a1BLvFYwEaMFbmZ9F9h9m2AMPGYaepn
 AhY3hnClAA/HZY32YL1wUl79/xcnulmpIu/1UZWO/iBCxlWodgxFvj4GDK/CFgTyUacfUuvd9YU
 qIzSLpi0JrlAXIJaMfouYcGIVoDI+Ur5ls1XdZglDp09Z22kFtECSUxVDCQ7QeouWixveARkjB7
 Sym78ixZxEIbhRZo+0KD06dvBZbwgwU2oDSCXYiM/y+OnuPUGoRikA5Z9Tz0zXbiaOJa6ErRIcq
 AbaRNLrnCojrPr7KTi1DG82sLNozEsGp9erJ6PXwKCFZPCkQGVkarafsODDlFfpz8UjSf6cJq4m
 rzMvYKq3fzBlV4b7ViQ==
X-Proofpoint-ORIG-GUID: oqcln0SLs2-qHpQDfxGs-Yvuvr_Qm7w0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:05:00AM +0100, Maxime Ripard wrote:
> Now that we introduced a new drm_output_color_format enum to represent
> what DRM_COLOR_FORMAT_* bits were representing, we can switch to the new
> enum.
> 
> The main difference is that while DRM_COLOR_FORMAT_ was a bitmask,
> drm_output_color_format is a proper enum. However, the enum was done is
> such a way than DRM_COLOR_FORMAT_X = BIT(DRM_OUTPUT_COLOR_FORMAT_X) so
> the transitition is easier.
> 
> The only thing we need to consider is if the original code meant to use
> that value as a bitmask, in which case we do need to keep the bit shift,
> or as a discriminant in which case we don't.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c | 71 +++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 35 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
