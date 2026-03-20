Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D046B1093181
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD5C10EA16;
	Fri, 20 Mar 2026 07:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pmdwroOB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GCP8hIgr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB7C10EA16
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:39:44 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K2Xg4N3614562
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1JvBC9OODow9TYPa7jEqKZFt
 uz/xNa7SSOiJgEze6lY=; b=pmdwroOBvURECLSvdzRVuRYwGVCdCkHMUPG1Yd1b
 Nv56Q4c6ydDJ6g7ZUC+ihzFYtI9fxVTMjPT2RdC+tY6QqdDoca9lIxTd63wN476R
 5kigQ/mT6jpgjWCChzmxpwse3Dwyh4MI4a1gPJ11kR5UALTjlW29h60EElpQB5Lv
 WeS2nEDyHJT0XzGeANILFaRDySsR41S+bObGha0hzPTffvqGJNBzdo2HNwAiUr76
 kX1kaSsDgrU3JB4Ig90Nnv2+DQn1ijftvZWGM/1cEM5+0qjdnEnnz7n0Y4LoMGwR
 WYDVttBwPrLTgQxOfxtvAw2U96cAa4nfGevrURQ4ssRfYg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0qg79ht0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:39:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b274f94f8so111269511cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773992383; x=1774597183;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1JvBC9OODow9TYPa7jEqKZFtuz/xNa7SSOiJgEze6lY=;
 b=GCP8hIgrjUH0mokeeZebUdQp/fMRzC7dkF0AlitS8zt0YRslqYbJC5CIhwN7TeFEmo
 pxjz+1aSuvKOHHXPYPCytobIPE5xlSu3xheM/88TbdiVSHXMVq44zzETuxNspaXovQLY
 2Kfbipwo9+Bv3Cf8uA5COMn9f8gkbsbcPFDcsSj2qBfBL26B+cs88HAV8GiwANipKZaZ
 nSDwXijINe4HwVAMI14cbs09YLxiMoK8RneoqlKgo/4OdbkUKvOKI8Y3ppU02W0y5L1N
 4JjfpuIeX32/xs0SUm67uSeD2vDF6D2k/FWVBJPvQ5mSaL6TPq3JZ0kC6Oc0ycGbM48E
 mnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773992383; x=1774597183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1JvBC9OODow9TYPa7jEqKZFtuz/xNa7SSOiJgEze6lY=;
 b=QmTlCiwiyoCxRutaPWLQuCSjx6WMrr5YOAoUmNfQIT7KWl6l+DRZD2nshVvp2p8xDJ
 gt08pmNowsRT9lCz6einP2wEGAH7JGp+OJU5a4JZOqDT8QQL/cDjFAE7ZAl3JwAEnewb
 WEJYYv/PhOYRuhUdBKUX2sFpN+GFhRVLyWt3hoyMaIUw/t3IqSforf2D7/ZzgXa7OuAU
 DPuXSfsV2bhfin912gQ0CJjz2MU97IV+ylwC2GCm9JXPrudm1eQ+HDmhtPKBc8iHrw6H
 Rj+R29fgLonuFNAanhkAtvsaxahKTup+8aonWigANnmPE347ruezBR7UvazOj+qqGK6q
 /8lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVHK7RuTiCpSksy8t/NTFs13Q2Nq9Z4HnqHSCwwqLGMX9NavUdJk51NYMRlBR+FeNb/1ntQDWgdBw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywy/70GC/Xi26lFfQpYaUNtvpeilLWm6v0W5N4I8uHJfbJlTK8S
 CK+JBZlMPaPFSYC7OfA8T3ZogvkBYCBlPRYZJE43aWzt9tZgiYtElmavyJEZzRQVxjIviG9LsR4
 bTZjXJojVhyljWIVfP2XS5DbOE3ClbYwyhboQS4RXoQyADpUxd3U8wDyAvvKzxkKIhvu/TZY=
X-Gm-Gg: ATEYQzy1F+fM7F3/QBBrizcJr0J8jBaSKOOt1wqvxvZnIB0y3Fp84CWkmrlM4DSlIZU
 ZLt5D7dFsYJZOF5FTcH8Q9Uj3hjv3/YFozOX4tHbZL11/3PhuKFel+YKsfKKhPitnWqRngRf2nz
 2YkSp13mQMxuSYp33ZbwBEGADR+yq9Pdg/6kxM2O9SQAwwWbFkb/i9livbJ/Q2iZDw1OkD0KDnd
 ez73jpaZofCNmeWXkADkD51OJyldI782K2R7ThKEiX3UBIvZ6w2cjcyyBAVAL0cR2Up0Fsxx0y2
 UZhSDCdPV5O0VPO6ZlUQSZTiCdzMMUaGVMo0G0GGKb61lJWG+s2ahc2yEckfnCI6vtvMMMcai7J
 XiX+R0RLJMgy49q+lRCgazfN8iNma+zF+wjSItnsditpgklNrHAbn6SBpDNicY+3xQBgGW/aQm2
 e5U6h1k19mVYIvOZn5QyZ5wsJA7TanO71Kvqg=
X-Received: by 2002:ac8:5d4b:0:b0:508:fac4:76ed with SMTP id
 d75a77b69052e-50b24796847mr86992171cf.36.1773992382918; 
 Fri, 20 Mar 2026 00:39:42 -0700 (PDT)
X-Received: by 2002:ac8:5d4b:0:b0:508:fac4:76ed with SMTP id
 d75a77b69052e-50b24796847mr86991921cf.36.1773992382466; 
 Fri, 20 Mar 2026 00:39:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf972ba78sm3909261fa.5.2026.03.20.00.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 00:39:41 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:39:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/panel: Add driver for Novatek NT35532
Message-ID: <wqbpvsy542sij2tb7uxksvaokca3yseednhu3omiczytt7hytx@r2jxzi4tzt6j>
References: <20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com>
 <20260318-rimob-new-features-v2-2-c1bf8917449e@protonmail.com>
 <byxrw5g4t23vivbt4xxpyfcsbrmlaju4lqqwsc75iqizoqmt4n@ltuwlggbitye>
 <4f3qSm2N-iqHmdKAzp6YslvLGtZbaeYJhV9pae3gtww5xiIUDM3Xov9wdCCumhINDMaHeFaJPMf23RqvZZkDQlE8D6hObDFaCd1vZjUHUoA=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3qSm2N-iqHmdKAzp6YslvLGtZbaeYJhV9pae3gtww5xiIUDM3Xov9wdCCumhINDMaHeFaJPMf23RqvZZkDQlE8D6hObDFaCd1vZjUHUoA=@protonmail.com>
X-Proofpoint-ORIG-GUID: gMUprCQv-RgJulm7I4kTt8Q3K0SJRNmF
X-Proofpoint-GUID: gMUprCQv-RgJulm7I4kTt8Q3K0SJRNmF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA1NiBTYWx0ZWRfX7spnWBABQluF
 JmI9bmwiJL1URp1G5gvVZSSwI6QzChmAulcOhyQKSF0qhXR4zL8okHTtxCoKjKx6PooynLBuFP3
 UC218a11W8y/FmYCo/9sRbXLo6iinXSPbY59c7xL6tjDD8UFXEBfOpBB0DiyfYUlyi55so0kcJv
 p973Yx43okIbwQ2iBWUJvWJU9R5XOUFCd9+d1rob2D0BBiLoDp679dHruk6EfsFYa45YrhmSCuB
 XCjb49hGGiaUtGSw0T03Ngb9xsJZSrED4kDIfho67HUzCKKylXXk7C1O7/tvV6doMJ2oa2Xf5dG
 eSI8Y7+pov79KbpR6t04qNqSBu2UECor5I3UxEdqngakAFouoSd6vnMrLsjl1NCi1r1/2InDo68
 PGAAiqN0tsnVvbVGK9vmSiDeEQLdgm4LiJR/LOm+mrDjeRXHpItz7yfSNU+88BWQEwVJOI6Oti6
 F27do8LAce5qG9jn+oQ==
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69bcf9c0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=sfOm8-O8AAAA:8 a=iTJjJGd3XSQqdiMV66UA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200056
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

On Fri, Mar 20, 2026 at 07:19:06AM +0000, cristian_ci wrote:
> On Thursday, March 19th, 2026 at 03:27, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > On Wed, Mar 18, 2026 at 11:28:10PM +0100, Cristian Cozzolino via B4 Relay wrote:
> > > From: Cristian Cozzolino <cristian_ci@protonmail.com>
> > >
> > > Add support for Novatek NT35532-based 1080p video mode DSI panel.
> > >
> > > Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > ---
> > >  MAINTAINERS                                   |   1 +
> > >  drivers/gpu/drm/panel/Kconfig                 |  11 +
> > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > >  drivers/gpu/drm/panel/panel-novatek-nt35532.c | 779 ++++++++++++++++++++++++++
> > >  4 files changed, 792 insertions(+)
> > >
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> I'm doing a test: since I'm not sure if:
> 
> 	select VIDEOMODE_HELPERS
> 
> is actually needed in Kconfig nt35532 entry, I've temporarily 
> removed that select line and regenerated .config file. Though, 
> I've noticed CONFIG_VIDEOMODE_HELPERS was still set to 'y' 
> nevetheless, so I decided to not going forward since that 
> code would have been built anyway so that there was no 
> point for doing that. I wonder: is that select line really 
> necessary, at this point?

No, it is not used (you don't use corresponding API functions). You can
drop it.

-- 
With best wishes
Dmitry
