Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DB8F99C6E
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 22:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7354310E22D;
	Fri, 17 Apr 2026 22:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXzhYDK1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PMSiye4t";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C9B10EAC3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 22:33:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4BPv3929310
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 22:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TSEGKQzB1WAe4mG6RsOQMGtv
 hysGI/AKv3U5JbVIAVQ=; b=oXzhYDK1rSLLAp2XIHAVvLo4AVqqKnlswar189HN
 e+rnzd4BME96QgsFztG5BU63Zk4j9KXEQIVcmjKW62Fgday+sRMm+JAzN6ghiRE3
 qGy7XqnmhAb+dW6JF6f8mBCHJhY6uOzwvjvwHmQ2fvZThDOhhdt5pHzfFGvSFGk0
 S2+qFTh9QuNk9UzDeBYPyuGuCTkFUKp+RFM7tLZIN4r1X7e8M318vOz97z/C4u1h
 aUSUQedy+DVpgc6grFsf6oIw83sKg8qamfYAzbPTY3uivt3TAVkJvqtDjR0q0oQn
 DVCMtAKCPXWR2gl8TLA/hrybVLumaootglztDdTC2Vp1OA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkqujh1tm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 22:33:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso29194841cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776465183; x=1777069983;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TSEGKQzB1WAe4mG6RsOQMGtvhysGI/AKv3U5JbVIAVQ=;
 b=PMSiye4tlU6mvMk5aCEZd750YzSaRlxYOtt/mheS0acsXm/cnPVx8OgF6aqdtWCWhb
 mfng0oQsbyycilkDxM3ULyeqG4CCK6xh3b2t1xyHdSVyunKThnlmGc2SCdbZdHs6zT0s
 KCzoB3WMxrDEYk3VqGcRDvPK8lIuEE9tPxrLG9gwBCADYufmQEgemM8vSYrN/SgZ/462
 wKRfpMFd399nkY8JiCl1+vl4RMLvTIM95rvASXC5X76eIn5gx9oPcu37pFBZFx2jp+8W
 rwpf8IDDm9BWd9ReikPHgk9Ubb7uWC2A2wnnRgFgkmfKxvU9Q/+mgQ9sz3rry7fzoJam
 5hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776465183; x=1777069983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSEGKQzB1WAe4mG6RsOQMGtvhysGI/AKv3U5JbVIAVQ=;
 b=UfAiNy8twxpSXmRMzX+EEh3EeS5oD3HCc75n/ydHB3IfbTqf+3Gnoit2ls/nJMW//3
 w7Ptp88J+m+RWTu0poXmubdeCwwXtO5/qtra9vkJRMKEanvdSwSvfiVfLewnbKBI4w8x
 ItC2nmCIOEbSF80GtM02O8NZpxGjQqQUb/Q16+flddF+kbXa5onlfucGrLhsy/K1J4ya
 o+xXRZoZMUeeE/YFX9MkaKYBvJv2Y/AMYRvXQrtKATcQVrZ4TnpGhsaulOrITTF1mofA
 0dUb2RIMVMPebjzc6Mq54BGGRhsneGVcRb7dSUXqD0Pyo++kTZG2ObW7c6OtaqxFo6aA
 v3Ww==
X-Gm-Message-State: AOJu0YwrTv8PSKftQleBFV+x3n1bczOCgha3p5gmi0mGSFPRRRkJg9qQ
 +Hvs+4kmDYYxbFCr5KiJONWsFLNsSP/5ijsjhk72SLzW83SWRI7d/d/ZSfBNiIkA9V+chvTGeHf
 3yc+rVnB0rYeDEAFphL1MCEbw+q8fVRegh8ym/pmJI4alufvNAuvJBYcn8+3NrAfyoespoMU=
X-Gm-Gg: AeBDieufrteNts2FgO1ovPu7MR5E9dXmSbTFkO19206uGqqtop8jVpfD3JdQfE1/+XE
 A+4F2TySmN7Sb4/qoJLZhrjQOBEgRfUdXY/qvpZKvu7iX9BaP4KXi2QPZBVcTsyRD+pi5wl+Bn1
 CtWciayJYaMIZrrh6gWlQEzUt0aVc/NkiDYHjUxOhO1rVysY5OG6sEPpILxNC9xO2+kWB9jRRMq
 pjpJL7u4ddJwq6ORHPJPLM2yUibmLk/F3x4Ow8lTH/0m46PyCckXBaMu8PQ8YN2j1gTigDgdJIB
 7CFxm0FpJFxWqCXCtIncSyy3AhEHK3raZDM5KuSYgFo0xc4ZAbJ1PfUK1G03ksljs7bYMvZMFeA
 +jf5QbW5UjPad+656RfJEJhMd4tJcu1wCPrUZ3KcnOrm8+BA2X7mJQhvrYhs1oEtzwhUI7odOO7
 8xJ9P2BUZhJWRH0hSEI/Lkket+NeWEPLvNpMlRNFZuO9TyJw==
X-Received: by 2002:a05:622a:345:b0:50d:82ca:7c9c with SMTP id
 d75a77b69052e-50e3693d29amr70718121cf.14.1776465182725; 
 Fri, 17 Apr 2026 15:33:02 -0700 (PDT)
X-Received: by 2002:a05:622a:345:b0:50d:82ca:7c9c with SMTP id
 d75a77b69052e-50e3693d29amr70717191cf.14.1776465182179; 
 Fri, 17 Apr 2026 15:33:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc297sm770798e87.18.2026.04.17.15.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 15:33:01 -0700 (PDT)
Date: Sat, 18 Apr 2026 01:32:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: Re: [PATCH 1/6] drm/connector: report IRQ_HPD events to
 drm_connector_oob_hotplug_event()
Message-ID: <6z572fdjkvjqvedifwvotgdy4lcrifiqvkjpnutousjqc6764r@zepfzkqy2kbu>
References: <20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com>
 <20260416-hpd-irq-events-v1-1-1ab1f1cfb2b2@oss.qualcomm.com>
 <51b7c44e-36c9-461f-983a-eaa86eeb8cfd@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b7c44e-36c9-461f-983a-eaa86eeb8cfd@ideasonboard.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIyNiBTYWx0ZWRfX1iDnySTeIqZ9
 06hrYNTlc6m2agKM/3VKIVvBCAfBDS+KSYSGeZCkEt6BvlioXLU7j9CG6TnOvseHKlpZzvf6Rp9
 oSLOagIwEKJeQxPrmL+zcn6zZyiU6IP8fLXWk206CGfQBk+Uf0lPNdcGMuuSKKLzFmPGWLgARfP
 rNB59EjvqC/humeM01WnittbwKMExJYHkPJgzodsyf7FpKCuHkevj7uL2Yo1BW/fsltlIBZvS0/
 NnjfFtbh4c++sYlXGQxb2YxV+IuAhGzUgP4vSe6DkUjhy8qYOYqSyh+Rwq+MpBzf6MnYCF0EDmt
 AhtM6KvPxUzEcg2NV81r5/Weq0lHkpRy36TF85SgQWML3deLCuq10Dum8XL1LlFIG8gwwuPfBvM
 z5Tw8SdC4zRxUxcm9WdliI3HRUsBW8joXq2w6Wv8E1J0s1FlTe73t/xAMMQbI0gtugXJjYoZeJE
 NKoxIRIAzvOdhYGsjCA==
X-Proofpoint-ORIG-GUID: 8gFMTxJpbgH1TL-zB-z8daOO455R0vEe
X-Authority-Analysis: v=2.4 cv=FP0rAeos c=1 sm=1 tr=0 ts=69e2b51f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VTJl8P6_mujMtk0GPeUA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 8gFMTxJpbgH1TL-zB-z8daOO455R0vEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170226
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

On Thu, Apr 16, 2026 at 11:10:03AM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 16/04/2026 02:22, Dmitry Baryshkov wrote:
> > The DisplayPort standard defines a special kind of events called IRQ.
> > These events are used to notify DP Source about the events on the Sink
> > side. It is extremely important for DP MST handling, where the MST
> > events are reported through this IRQ.
> > 
> > In case of the USB-C DP AltMode there is no actual HPD pulse, but the
> > events are ported through the bits in the AltMode VDOs.
> > 
> > Extend the drm_connector_oob_hotplug_event() interface and report IRQ
> > events to the DisplayPort Sink drivers.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   drivers/gpu/drm/drm_connector.c          |  4 +++-
> >   drivers/usb/typec/altmodes/displayport.c | 12 ++++++++----
> >   include/drm/drm_connector.h              |  3 ++-
> >   3 files changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index 47dc53c4a738..5fdacbd84bd7 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -3510,6 +3510,7 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> >    * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
> >    * @connector_fwnode: fwnode_handle to report the event on
> >    * @status: hot plug detect logical state
> > + * @irq_hpd: HPD pulse detected
> >    *
> >    * On some hardware a hotplug event notification may come from outside the display
> >    * driver / device. An example of this is some USB Type-C setups where the hardware
> > @@ -3520,7 +3521,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> >    * a drm_connector reference through calling drm_connector_find_by_fwnode().
> >    */
> >   void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> > -				     enum drm_connector_status status)
> > +				     enum drm_connector_status status,
> > +				     bool irq_hpd)
> I find the "IRQ HPD" naming always confusing, even if I'm somewhat familiar
> with DP, but if someone has mainly worked on HDMI, I'm sure it's even worse.
> 
> Can we define this a bit more precisely? Is 'irq_hpd' only for displayport?
> If so, perhaps 'dp_irq_hpd' or 'displayport_irq_hpd'. I might even call it
> 'dp_hpd_pulse', but maybe that's not good as the spec talks about HPD pulse
> for both short and long ones (although in the kernel doc you just write "HPD
> pulse")... The kernel doc could be expanded a bit to make it clear what this
> flag indicates.

I attempted to stay away from defining a DP-specific flag, keeping it
generic enough. HDMI is pretty close (IMO) to requiring separate flag in
Linux. Likewise I'd rather not use "pulse". The DP AltMode defines a bit
in the VDO rather than a pulse.

Anyway, if irq_hpd doesn't sound precise enough, what about "bool
extra_irq"? This would convey that this is the extra hpd-related IRQ,
but it would also be obvious that it's not related to the HPD pin
itself.


-- 
With best wishes
Dmitry
