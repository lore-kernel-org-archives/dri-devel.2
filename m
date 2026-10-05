Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85589CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 02:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B860410E236;
	Mon,  5 Oct 2026 02:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2/Iak2r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG+di/co";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1560D10E7C7
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 02:03:06 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69511Ts01467019
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 02:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +SgEIltGQkRfnBLbDG2XrKCaH5AEd8lzeFZSn/DYU0I=; b=b2/Iak2rzA16AFBz
 USndGqFKkXIMGYosQRob8pP0CWF9a11zSNM9emK/3l/j6TJvqyJ1c3cLocMTG/g6
 j+9uthC16d5RUwxtlv10XQYwVlXYbviB6a8Wdcn9A5bAQtSrekD4yVHBHxNoE7bj
 9wDWVf2yWrFg7lHj9RChbuf+OrZpZBJB8EbA4DvRcmbVk4sbAHfezXuzXkePQkOl
 3k9zlGo11K4h4wnJKGf0rHdu9pGKJVMmWa/JcflHRXNwGGsSdYqwFT30Tq296+0o
 Z0FJ1NqWKzlBL2pYR2algI9XLxKyAQjYuhp/NzSO8yBut6LD3yKTVSm9OLH3oFlA
 DnbOzw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssm4th-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 02:03:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917870a9be3so37034136d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791165784; x=1791770584;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+SgEIltGQkRfnBLbDG2XrKCaH5AEd8lzeFZSn/DYU0I=;
 b=LG+di/co9ZKebBPnkEKa9rq9wumR5Q3mCg+eTYgcbBtkjvE+t5VYJZuvlixamFx+2h
 uwG+xQ0WPmav07vfems1vutL6vEdOF3B2ru802LvosBhNl4/BJ5FUZkmke7oWvjjlYht
 QHusthNXMYjwinO4mtz+ljCSG9gs4oYoGe3KOy31eoeyf903x+rO62ST1xBscoDerz8R
 tGIMKsIWMGZ8TSd1KxE/F/gczZOFbEvXNNxrY66dSUUa19VuYougqV6J+Qbtc9YunoCD
 +cv8HDxTHMnNWOmVkgkmjiUfQD5B4xKyZVCd6OhRutz45s+MdV+YYmu9ZE8QwHjSext8
 FXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791165784; x=1791770584;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+SgEIltGQkRfnBLbDG2XrKCaH5AEd8lzeFZSn/DYU0I=;
 b=VqClpDmj5wJ+OVH9Niammb4acT5QngLXnZ07Hgy32HOcSg4ddp+Ai8ZwlMIOr9GGhg
 Pk3fTIz5sNiR66OxXwZ2IGBN5FEAYU8iXLwDYk/O6QJkecX3KNM3hU4sfMc1YrrYf8ri
 n+ziSyleRnqp5nrbR/ClXJHNNqQewnyF/AVwCGIqCZv5YKwSS4MPjir1V+lCcY11U1VF
 7YhtIfHfV0N/l80XLy3N/SZFHTISq3ic2xsjZmrgrNxJI32t0DEYQBJwRAQJpz3qIGwp
 trfRW+vFaXYcUvV6GcNJIQMYKRyLiNAQwGyvkU8zO1A2KTL6ah0M6KYpHftlh3FnD9Y8
 f0BQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqBwldsEvtBM2LluiCwwro2IuPX7FtU4LaYLZSPLZpZOCaRNpYL0WvRV/dedG4LxFyOA6GLT5edyA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWaP9SIk6YHegu9onls2UAUI2b9wrjLQd26lERmYMfcTk0rHvd
 IbdbQTg4Jl91iN7bSWB4EwwUdXgMJ6niRTnonMgfrMYvK3sMDiX7nGA/4/uMwTU165QIG8PUoY5
 fWu5V//4DB27dP1+GvN5hp6LpIAInk9KKxaXDaXnyt9zCtUogZsc00pu1jezwEAK937ROE3E=
X-Gm-Gg: AYBFou3/9YX5xY8Q2wp3Pbz1P21+m6rfcjUuhfVz9QUEtHZQ1myFbLRq5Y0rWyg2snv
 WC2/9eHsmvJbUF4dBmgI3vHwlhg1FNbs7Q0KsrOBxl2BhZ2mQDd+EfxaaKZoHalQ8xHyLgXR8hF
 VFKmOcNo8iOWl2Rc5D9tCm+DPWJrPytn+nF1FxapeuJaE6GewI0fm4QRhEnbadjFTwl19YmqVrQ
 ACFgM2qpD5MBKuVM9SbcR/BoYi8JdsOG+ZAGRVch6WVtgIPV3E9Y3A1qRBa0jRmDDvbfEmHwa/x
 3mAIVTlVUcEx6OCVmNNeZEGHuOl3zrJVCij7fAHQ7zXbJ+gRz3TXLDZKwGV8QbNT5v/mCNo/W6Q
 qJOY2s0U5J42YaDvrr0clqoEBuMaNr+FAtucebG0JjmZPgt6/+2nN0vzO7O7EfRzzBLwmp9utSI
 4bPpcxRot9gP93
X-Received: by 2002:a05:620a:271c:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-93cb54376f0mr2312053785a.0.1791165783997; 
 Sun, 04 Oct 2026 19:03:03 -0700 (PDT)
X-Received: by 2002:a05:620a:271c:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-93cb54376f0mr2312050785a.0.1791165783480; 
 Sun, 04 Oct 2026 19:03:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7bb70fsm2877427e87.76.2026.10.04.19.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 19:03:02 -0700 (PDT)
Date: Mon, 5 Oct 2026 05:03:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] drm/mipi-dsi: Add flag to support dual-panel
 configurations
Message-ID: <m46353a3ikqtkv3ycevnpzg77z32jickl7hophmehlot4sjj56@bbh7kjb4td7z>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-3-c042266b9eeb@linaro.org>
 <gu22hz3dnttzyu2eewpalgzxtocmlbfvnpwore36ufmyr3xtag@r5bbhafsn562>
 <CABymUCNtcgbcRNXdMUjVdnH_ybOxjFB31gd6AW-0HCFDSn9w4g@mail.gmail.com>
 <kgnrsnko7u4g6bpxudfo6yqubhd5gcyrdyovjfkohlgo63yrwn@xbgp7jgv6ns3>
 <CABymUCMGT32A5gE+a3u7=-3scH_Nu7Amb22-FRfWiNrcEOnAgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCMGT32A5gE+a3u7=-3scH_Nu7Amb22-FRfWiNrcEOnAgw@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAwNyBTYWx0ZWRfX2YBvRYx3lTZN
 DbMmVWvkucxS2QS0EOHPcCuhM+HXoo1o7Nhkym0gz4i0RrjJKyaixrSgjB2hhFdwDcQ3achKERw
 vzya4lhc0pIPkY+AnpTqefJqkKPOsU8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAwNyBTYWx0ZWRfXzIIxkwGUmjcJ
 VwF71sLXGWd5AqNd0bAA6s/EXO9u2xG/wd0CPHcZgOa7iXBoTTBeDmePBjk4cO2+Ky3Dau9grx8
 T0+oBkd9Q5Th7g2FC3wbsJ0G1yqi+Mkpz/xbpBlGj6CaffloeJcVgZptvQeDwRtc7wVaMDw0P3E
 JBEqQRdXYCnLISDMGonCbfOr03c8RGJqqTpBCsuSoD/Y2nkdYpMUtOvGpjJHtwFUfJfbeVUmp2a
 7EwjRgSNITIP77UAMNAdO60PYJHygcUDLSq8iSaHGSy0ALO14GbPS9IFhpBK5DpH+ptFrdOhOaA
 UUHs6mxf+oH2X79vl2NX9R2YWyZ9fpdMrW7RcxDfgEdkO2V1SJ5naz9CUGi3FQvLuy1k1uMHLXP
 m60PaQyvhEVkxxSNCnvo4ARMYtHntvUmXc7tlgrKyCOX0sp0YQvDRBthaDmB6SycKEZXi9wMF1g
 HWX6O8GaXqyOAAQn+/Q==
X-Proofpoint-GUID: GY8lUmDCgJyog0X6GTyGBXmLgZZz5fXQ
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac30559 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=kAmi71hXjrz3IqBiEUQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GY8lUmDCgJyog0X6GTyGBXmLgZZz5fXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050007
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

On Sun, Oct 04, 2026 at 09:58:04PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年10月1日周四 03:43写道：
> >
> > On Wed, Sep 30, 2026 at 09:52:48PM +0800, Jun Nie wrote:
> > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年9月30日周三 00:05写道：
> > > >
> > > > On Mon, Jul 27, 2026 at 04:08:42PM +0800, Jun Nie wrote:
> > > > > Some devices treat two independent physical DSI panels as a single
> > > > > logical panel from the CRTC's perspective. However, two separate DSI
> > > > > hosts are still required to drive the panels individually.
> > > > >
> > > > > Introduce a `dual_panel` flag to the `mipi_dsi_device` struct. This
> > > > > allows a panel driver to inform the DSI host that it is part of a
> > > > > dual-panel setup, enabling the host to coordinate both physical
> > > > > displays as one.
> > > > >
> > > > > This change does not force individual panel driver to manage
> > > > > system-level display topology if the driver does not intended to
> > > > > support dual panel topology. Only the driver that set the flag to
> > > > > true need to take care of panel topology.
> > > > >
> > > > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > > > ---
> > > > >  include/drm/drm_mipi_dsi.h | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > >
> > > > Do you have a single MIPI DSI device, or are there two independent MIPI
> > > > DSI devices? In the latter case, the flag is wrongly placed.
> > >
> > > Yes, there are 2 mipi devices, and 2 mipi hosts. This flag is used for
> > > mipi device
> > > to notify host they are one of dual panels, so that horizontal
> > > configuration(width)
> > > in mipi host can be handled correctly. Where do you suggest to put this flag?
> > > Thanks!
> >
> > Into the msm DSI structures. We already have several Qualcomm-specific
> > flags. I'm thinking from the 'generic device' point of view. The
> > 'dual_panel' doesn't mean anything if the device has more than two DSI
> > hosts. You need to specify which hosts are mapped to L or R channels, etc.
> 
> How about to add below 3 members regarding multiple physical panels in
> single logic panel. We have h*v panels in a panel wall. The index start from
> 0 when we iterate panel from left to right of the top array of panel wall. In
> XR case, we have num_panel_h = 2;  num_panel_v = 1; and
> panel_index = 0 for left channel, panel_index = 1 for right channel. The
> original framebuffer is divided into width/num_panel_h and
> height/num_panel_v for each panel's DSI link.
> 
> u32 num_panel_h;
> u32 num_panel_v;
> u32 panel_index;

You have seen drm_connector's tile-related fields used by
drm_connector_set_tile_property(), haven't you? If we are to use num_h
and num_v, I'd also use h_loc an v_loc instead of a single panel_index.

The driver needs to distinguish (for the DSC params) if it's a single
panel spanning two DSI links or if there are several DSI panels, bundled
together, so you also have to add h_size / v_size style of params.

But then the real question becomes, do we really need this complexity?
Will there be any use for it other than representing the XR vs non-XR
cases? This all doesn't concern userspace or uAPI, so, if anybody needs
actual DSI panel walls (maybe also using DSI subchannels to driver more
than two pannels), we can extend the solution on the kernel side.

If we take the dual-LVDS panels in mind, I can propose the following
API:

struct drm_panel {
	/**
	  * @dual_channel: set for the DSI or LVDS panels which use two
	  * host interfaces to be driven
	  */
	bool dual_channel;
};

struct drm_bridge {
	/**
	  * @dual_channel: set for the bridges which use two host
	  * interfaces to be driven, e.g. dual LVDS panel or bonded DSI
	  * bridge.
	  */
	bool dual_channel;
};

Devices like LT9611/LT9611UXC or panels like hx8279 will set that flag.
The DSI host driver can use it to determine whether to use width or
2*width in the DSI calculation.

At the same time, in your case, you won't set this flag. The DSI host
driver, fidning bonded DSI link and non-dual-channel bridge will
determine that it's a panel bifurcation case and handle it
appropriately.

What do you think?

-- 
With best wishes
Dmitry
