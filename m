Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D299C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9341010E493;
	Tue, 18 Aug 2026 02:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFR17imp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bAyBLFrZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CD410E487
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:24:50 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLkhhS3145147
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=98i4v+/vyXWcyWkknO4LIfjz
 mBEpAN6zh0hmZXHw7mA=; b=jFR17imp9arMOTkX5pj7VfXkKzsgtoVFpoHxfGXg
 6CsmJJPqOJU1SLea4VpYH5Z8GrCv3p6yzK0uxeqwPm1WYdkd/LnjRqMl/GtDc3qj
 kaxR7bWFf7zw7EtI8g6SaXII1TbteMshBb1j325Pp6Iaqdvv/PWE6CEJtgDECsD8
 ltDHhp+EQOaH6vDyPuqyNnhA74OsDAFRk0Xh9iIv+PsB1Y4KoJYHd6r8a4Wgp1Yb
 afR2l30njJpQB0SYyodAAR9Ma4QvOtgw9RJTZgRUaMCGi2lRVI3JX9gzbLG6Qa1p
 DCBKyLNFLrru06oW7uLRWR8TBtRUIS/TVD7DiH5m3cMf9w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xw8m0sy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:24:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso5273331cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 19:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787019888; x=1787624688;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=98i4v+/vyXWcyWkknO4LIfjzmBEpAN6zh0hmZXHw7mA=;
 b=bAyBLFrZlelL+qChzSECk7rIZh05PqgJxL1A6uAQbI5W9K9fH+2Oh+Yus2h0GwSZAM
 09AcX2RCMzV3sjZsViV6Zkxx7xzpBrIbalzbkWz507MparK+VUz0ae+sfpoHWj3dRMD3
 8jonwIQZPnSvr3bhxw1z4sf2/6EELUE5/NU1qiQNAGEYEFaHsPu5M2N15+yWrmrLMHZj
 wh6kmLPZchKbDyA2VTqLbrSqdc5nQpgwQylVYIlpKxm80SWy759WCxK0qHPtp51uv45L
 A+WQ5B31JaDVKcsqNHcD4dQ4Pn3mxhZqBZDhy9zvA4gXLfilnE+wt1bS+nZmLWrJDq17
 teuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019888; x=1787624688;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=98i4v+/vyXWcyWkknO4LIfjzmBEpAN6zh0hmZXHw7mA=;
 b=hnphAM1o7V75biuR2cW1R4N49+1gP6mrfbtezMCL4uopm/9RIet236pNFj876iqx3c
 qU70m564UnEU/T4KPd4Y0Cle60cVSNSxnmQIsxMxweYu7FyOOjgNJ+iF4+mrQaLZAEso
 sweH8MB6xx1AL+SEB8//7KrGOtuJmrjtyyjtjutOVIrzdjvQcMXd8cOHO1f+m1Sdh8LB
 ttpk3ub1LnyPHDdAQTDsUe9QfQRDeHytLc3e1V6H9DGUCoIZD0kwJ4m8XzX/pQeKD3gx
 kSDjb0KSalggAk0SspCOARP64yNABE7DMzGtaYapmsbgJj107iHDYoxATNrQqeXq3Ug2
 pwyA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9InfLpaGMHZLU4Whizhe2l2qnRnW83RT271gOLULY6XKuWhaln9crtbCMaIDzfz0ZOcI4CUkSuKI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysfUhkrsWHH7A0XCKsNPMnfxXeZFMohAkIBFn6l3UHIanFWMTD
 yBE6lpvHB55o0/ed006X9xVHmtLcJUCyGgQPcHqIu7kGQLserqPte9CoJdGNtM01BKMusGlsKAI
 q9BtNYGNRoJ+9+AJM9SkymZc/MO/S4X1uVA7WpdKw2B60wivv0xbH4MukBn9V7+LXfkw27w8=
X-Gm-Gg: AR+sD10y3QNU9W2Apc6KKLqBygOpGsypaN4R9nLCB9ELBjhNAVFTjzJR6f1fKLq3t0V
 A+QomuAe20mRCHZYYzy11qSG4XBXzE6McxplFkwiWCHa7sq1rqNZPpcy+2fg7YZcN3CR64DL9Dc
 +Rb9PrhR2EWZobFmgkuORchxGmvbOnGA0teU6FuZlx/3tKw+Wibtl5uZTZQyLY/L6v290KwFZU/
 XyO0QgtP49nq0fjV34iU9nN5xsunj6HKxy11u7tSmdKJdaD4CzAVe7ozgH/T4Un+TwcDg9HMEfC
 MK6Q6IWxRU02unQ53lcfXGrlplwF43elhYP/ToJTlt6287gqTi46jBOZdKznldqZ6DA3usTVo+s
 BM7he754+n5nS8Xgfr5OGVvhWJFIavgglYYgpLJIZQ4anGqmShkGl0yUujEmgUah3T3yQVw6rS9
 ekaNCy1BqZQgOx
X-Received: by 2002:ac8:7e8d:0:b0:52d:9cfa:663c with SMTP id
 d75a77b69052e-52dbeb697afmr39243231cf.0.1787019887899; 
 Mon, 17 Aug 2026 19:24:47 -0700 (PDT)
X-Received: by 2002:ac8:7e8d:0:b0:52d:9cfa:663c with SMTP id
 d75a77b69052e-52dbeb697afmr39242611cf.0.1787019887314; 
 Mon, 17 Aug 2026 19:24:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cfa0e5esm821205e87.25.2026.08.17.19.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 19:24:46 -0700 (PDT)
Date: Tue, 18 Aug 2026 05:24:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/5] drm/bridge: allow hpd_notify() to suppress connector
 hotplug events
Message-ID: <4qc3n3mwsonpzfxi3z2supslvlyat32xgsn7bnrstudtpitwri@enwxj4pkjexa>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-1-646a10256233@oss.qualcomm.com>
 <364f223e-15c6-44c4-a909-134754cfd0e1@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364f223e-15c6-44c4-a909-134754cfd0e1@rock-chips.com>
X-Proofpoint-GUID: Vi0aJJHztnjGjlBPL3TGU96jvqt6w__O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAxNSBTYWx0ZWRfX5ECEszjXnO0s
 ZpybW6BBn7bE+35K9n80Q2QRg9X77mwXFA4e1TzMVEttOMbKHSlqRuj5X9zw/KtI3sZ6kVXrqvs
 vMBmi6lNbDNkn5A+crGb9IbfJfjUWao=
X-Authority-Analysis: v=2.4 cv=SuCgLvO0 c=1 sm=1 tr=0 ts=6a83c270 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=QX4gbG5DAAAA:8 a=busZWuwHVHLsb9-ZDGQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: Vi0aJJHztnjGjlBPL3TGU96jvqt6w__O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAxNSBTYWx0ZWRfX+dhPVracU5vi
 m4eayzYPHJqraoNDYeJTnlY6khD52oOKRa9zzuuJqGAd6Rm9XGfsUnPigM1Dfi+XL+2t5YWM8yr
 uW+5jE3nYQxrEg4odxW+yixZhXN6SKYmmUKTKcEyIZlUDjcYmeoG9IwclTp4NMotd0o03q7pDWj
 DOSGvEE4z4AiftGMFpi2hgIDlkbbaAPO+uQBOhpNar6ZfcrRQQD+obws03eL4aArJ75R88kEkkn
 ofmj2lTNqJFlgSxtNnW2yhtsM9IAfx5Lab4xkVjy8pE1CTUT5fvdOD6J8oN58yZVM4Sc/7Y3537
 LcwoJhYniRMISVviovOCoN9uG65H2SIgesv6iRU4JNhX/lhlU++28OCtmmzKzNpYSbekpkTTZf+
 Z1DVq0FebVl/vr9THwM4uzYfj9t6/8i/ApjsqSuYDDycleMszx0QcuzPMb1UWZtnh6kf5K+uf9K
 Dnxd6O1Ne+WAs+WYhKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180015
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

On Tue, Aug 18, 2026 at 10:05:30AM +0800, Chaoyi Chen wrote:
> Hello Yongxing,
> 
> On 6/29/2026 10:48 PM, Yongxing Mou wrote:
> > The bridge connector framework currently invokes all bridge
> > hpd_notify() callbacks and unconditionally emits a connector hotplug
> > event afterwards.
> > 
> > However, not every HPD notification requires a userspace hotplug event.
> > 
> > In particular, DP MST bridges may use hpd_notify() to propagate HPD and
> > IRQ notifications through the bridge chain while the actual hotplug
> > handling is performed by the DRM DP MST core. Connector creation,
> > removal and userspace hotplug events are already managed by the MST
> > topology framework.
> > 
> > Allow hpd_notify() implementations to suppress the bridge connector
> > hotplug event by introducing a bool *send_hotplug parameter. Drivers
> > can clear this flag when HPD processing should not result in a
> > connector hotplug notification.
> > 
> > A NULL pointer indicates that hotplug suppression is not supported by
> > the caller, such as the connector detect polling path.
> >
> 
> Should we add an API to distinguish between regular HPD events and
> the IRQ-only notifications you mentioned?

It well might be so, rendering the first series listed as a dependency
as invalid (then it's good that we didn't land it up to now). I have
been torn between adding a new API and extending the HPD events. I
ended up choosing the latter one, but I might be wrong :-)

My idea was that both USB-C AltModes and native DP deliver both
mechanisms in the same way. If we add a separate API, we have to take
care of possible interactions between those two (i.e. how should we
react to IRQ_HPD, if we already have a HPD event being processed in
flight)?

> 
> I've recently seen similar approaches. For example, this patch[0] adds
> handling for internal events, which I think is somewhat similar to the
> IRQ-only notification here.
> 
> [0]: https://lore.kernel.org/all/20260806-synopsys-dw-dp-improvements-v11-11-0d508505f383@collabora.com/

Thanks for the reminder about this series. I need to review it.


-- 
With best wishes
Dmitry
