Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED742F31E21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F9010E076;
	Thu,  9 Apr 2026 14:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6V2X79U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kDIBfrv8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB8E10E076
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:50:09 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639CxokX1730291
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 14:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=utMWUCCTJuQzcuo1BSAJ7kzz
 +4RTmDTgmjtXR0Qd9ic=; b=R6V2X79URUzVf5/09aniazOTggpXadV7PkglAyM6
 iMohPPAffIGKNpg3njhkPEJg95daLX+kUPLT9xk08PAvyQfQTKFln3NeS3yxGGqQ
 bJ+bsiAX5Aq93r166GKANkR7m1ZXciIgoAOGtalo+SuUpSSpItGN7heGMOQi59MD
 22XCwCsmX6Wo/OubLbe/MnL7rsgR7FVSyfay3gxywvI4nq0Bosp4d/Stc4MeCqDj
 Glnq2HAeAwA2IroJlk/ZA65AVkh39woZZZgnWlimLXt5qal2ByA21Qo3EzLme4k1
 r/QwX4qHp0qk2lJl8da98qK5KmgfpEiJWQlvzCFbPeo22Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxge17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:50:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8ed08aa4so6102411cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775746207; x=1776351007;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=utMWUCCTJuQzcuo1BSAJ7kzz+4RTmDTgmjtXR0Qd9ic=;
 b=kDIBfrv87+YAU8cDjDsNQ6J3ulQCIl0vEcGpKHvUlbM0EO2S/Rw2AMsd+R/wi020nw
 PPHRaA+SxU5SHgqdRWGy4JJxFTK/ZkHJI9kBj9qfB1xzZNpcmb3eSozJF927BXcJf5wG
 TJ3zwEpfr0B0kuRH7pUpzgrcCqwbv8BS9/tPGr0g0LChd2V/FY09mvI21qa5KCBkDUZB
 o8M8/edpZyOmoR9YDaVu7mLIlpYx75GSmKlY+ZBPlQy6uK8/ZYPZqfpTizyyr3d29f1A
 Ukp9YZh8L2L2w5PFqueT5DmY6zaSFDK1dMTSSPYkvdVOG8br2CjGeTs0rjDhQ+idla/0
 +rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775746207; x=1776351007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utMWUCCTJuQzcuo1BSAJ7kzz+4RTmDTgmjtXR0Qd9ic=;
 b=AT3zlvtnpAVNMUqmJc3YtfUNDTzxl6tvLhRU2Ag3DIMO1YwHS7wf0GGzwpnQ97yyMC
 TJF3l5TfB6X6IAhfii02Df0WaNoUIV4AFkvpwiIy7IgvRzxU2Azbi7BKd9gegvgupaRD
 KZfDFlli77F6xc/u9PTIBb2++z2KCeAKRFccOGqYhFJUWtfdeLLob/uLyXGqUWzyWqhQ
 wz9mrEOihzbTjnyG1myOaW8sZvFrsLHx8S3KXONl4TmjP+fTd+yk6bTnac7mAXHBkfaO
 FZSHUBNIxHfks3mt7anJvL7qjhXfwVBvTBNEEWj+YGMntMhMPsSWrTJdqfB/uR06M82H
 nOVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTzywywYfCx9KZBLv5gXnZ3SzztCd/6r0kUiJthRqXA8RNkUj6NSBp/8SkIWA3RIoZVBmF/7hELFY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0nc+48QetC/uoU+hH8K5p1P2QQ7fuLL6nvSAmIyP6r3Z92brk
 ZmzPuRd7eJaKoBPDNe/beMAxU7ZG/UkhK/wsuFHdj/p5JpXa5iyu8trrlETu9hFIf8XvaAVMkZr
 h+c20zGbAYq/hPzi9pUZuIewAG317dCbuteXD6cD2urQ1HFfq18uJUCqX0VMlSWAPniiBxbM=
X-Gm-Gg: AeBDievEfFP4Z5TnGi9qcmYm4+0QPPhyv6pU5u0RtvD1Y9IREfFmnQtxQU0xL3Xi4Ub
 WiyFVB0lC244OhUSC25ruAQbJcLRmzHpORAx8crEyhP+A2D4OA2NBJAUA0sOt3TOhagH54YwHwU
 Y5Wa4ND/0DnaOzD5/Cwu6UAdvPlYTmugoIcri1Sewo9GI0n4/rGRL9SNG/sMhQkW6vfeeDFZMDN
 lQDTTH0XPCZMFXZN3aX1Q8Jz3vLPTDzQ+7n0etH0jQvr+pN3vEX1QIg0DiZCKrLu/RA+/ugTe67
 JgZXiNKqyLEkKCvv9XaKqVqg5LS7ONVdObBQBJdcjadEvouLO1CPbOqoSG1BAjvgvMk2a7Z0V7l
 ja8uTroEYeV+tEacsBZuGCju44wkBtkNNvChsgSznDteR7nW+fHXqqk9c/v7SucHQbDEbAAJizS
 8O28LveBJKGqebRbwN34XUrV8sFbZVtP8DDek=
X-Received: by 2002:a05:622a:4cce:b0:50b:2eee:4b3c with SMTP id
 d75a77b69052e-50dc218e999mr49883731cf.15.1775746207522; 
 Thu, 09 Apr 2026 07:50:07 -0700 (PDT)
X-Received: by 2002:a05:622a:4cce:b0:50b:2eee:4b3c with SMTP id
 d75a77b69052e-50dc218e999mr49882981cf.15.1775746206893; 
 Thu, 09 Apr 2026 07:50:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cc8417sm5475214e87.41.2026.04.09.07.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:50:05 -0700 (PDT)
Date: Thu, 9 Apr 2026 17:50:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 30/38] drm/msm/dp: add connector abstraction for DP MST
Message-ID: <zblb332ibxgafh54rdsb2k3r4b5xx6iy6wnodyzdjey35v2l7d@tjgii2fbiwet>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-30-01faacfcdedd@oss.qualcomm.com>
 <x72v67fsgmekfeebasggtiaofwlxw6ikqch4lxkrryior3yxxk@xiiw75bnj37p>
 <399e29a0-1c52-4e81-9393-3642d50e1e69@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399e29a0-1c52-4e81-9393-3642d50e1e69@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: n9o9GVrIRSV4GXzCuTtciRLQN2QwRX5N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNiBTYWx0ZWRfX2GbZwS/0E66C
 g2WEVMFphV9Xd2WwYyWDdp6ZO9m8SWO/pJANf2VQSQDhP2f0MZg02s3kDVP4O+OI7wziQt+i0i9
 IDiL3a8BnllTi0J9pivgT6xzETYZngvHRf7PqcWrH/kELeQPbCNE9FxZksMGV1WqsoNM7V3ExaQ
 3JAqWEvJW7goxcD9kvMs6zbAVHD8KMia1ZRTzfs6K56RcY/gQ7f7TbhO+ksGjoClBjhn02FHgg0
 dN62VjvNP+QmlTaeelx8GoGS55BQqBhlCC0CvczTOgQdzVeRG0Bl/jMdzWXdBmhRhU+8t5sY3LX
 ZCv9seaFI2uqwd6/M4+LA76lwHRh1t+CV98CRoneXEeetItfhCWHsq1RG751qhZb4QFJ0EKmVch
 1gQ4r6wPdE2p2KMX+NxpiGpymVnIOVbfu4l/fC3h8O142LFruy+CuCUIgJp30Uvkzi9E1LA1zLF
 xh6EiTvov1okG5fQ+DA==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d7bca0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=P-IC7800AAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2cZzWrYX-iRROb9EKxcA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: n9o9GVrIRSV4GXzCuTtciRLQN2QwRX5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090136
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

On Thu, Apr 09, 2026 at 12:01:58PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/27/2025 2:31 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:16PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Add connector abstraction for the DP MST. Each MST encoder
> > > is connected through a DRM bridge to a MST connector and each
> > > MST connector has a DP panel abstraction attached to it.
> > 
> > What's the functionality split between the connector and bridge? Please
> > explain it here. Do we really need a bridge if we have a non-trivial
> > connector implementation?
> > 
> MST connector only for MST API calls/detect/get_modes/get encoder, and the
> bridge handles display enable/disable, hotplug, mode set....
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 391 +++++++++++++++++++++++++++++++++++-
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.h |   3 +
> > >   2 files changed, 393 insertions(+), 1 deletion(-)
> > > +
> > > +	return status;
> > > +}
> > > +
> > > +static int msm_dp_mst_connector_get_modes(struct drm_connector *connector)
> > > +{
> > > +	struct msm_dp_mst_connector *mst_conn = to_msm_dp_mst_connector(connector);
> > > +	struct msm_dp *dp_display = mst_conn->msm_dp;
> > > +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> > > +	const struct drm_edid *drm_edid;
> > > +
> > > +	if (drm_connector_is_unregistered(&mst_conn->connector))
> > > +		return drm_edid_connector_update(connector, NULL);
> > 
> > Is there a need for this? I don't see a check in nouveau code.
> > 
> Okay.. i see in intel's code..
> https://elixir.bootlin.com/linux/v6.19.11/source/drivers/gpu/drm/i915/display/intel_dp_mst.c#L1390
> do we need to remove this ?

Again. Why do you need to update EDID of the unregistered connector?
Please find a better response than "i915" does this. Git log might have
some story.

> > > +	drm_object_attach_property(&connector->base,
> > > +				   dev->mode_config.tile_property, 0);
> > > +
> > > +	drm_modeset_unlock_all(dev);
> > > +
> > > +	drm_dbg_dp(dp_display->drm_dev, "add MST connector id:%d\n", connector->base.id);
> > > +
> > > +	return connector;
> > > +}
> > > +
> > > +static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
> > > +	.add_connector = msm_dp_mst_add_connector,
> > 
> > No .poll_hpd_irq ?
> > 
> I checked that poll_hpd_irq is only used for certain specific scenarios, so
> it can be added later when it is actually needed.

Which scenarios? Will this impact USB-C or any other usecase?


-- 
With best wishes
Dmitry
