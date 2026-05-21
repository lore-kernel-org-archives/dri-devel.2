Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43361CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 12:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6B710E48B;
	Thu, 21 May 2026 12:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESUcJTqf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cHLBGZ0T";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D622B10E47E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:05:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L99u7o3772784
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pGY+j87eohBlWubIX+vUu3zL
 xCM+uB8O9JAB1ecXkdM=; b=ESUcJTqfqAtQySEKLKp7KIRCaL9t+erTOvTDfYVG
 fOBbLyDU9ErXoWLj4r4aG9s0cSsb8zoRyM1JEXHKMO58+5AlNlIqYhVm4fJDnyg1
 cl2sJsIct0JQnB6xtZiA/nkLgshpE2ZJ2d8TMb2iE+jiPVc88/YLy+/uMALyWJcO
 EFiCMzn/yB2f4Oj7+vhyZdRM7OScqDwli9yLV5lCf6V/2L0HFXQP/129g+4Vwob2
 zmgClDrJK6DrYqqGGbrsnUTeIGoXHc4aGqrFVjT2e248jtLQepcXVGsiUmf9Vdb9
 yl1pamahY+nuPtJOIFtAZJqeEnapAvzxGfzSceLlDVUI8g==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma433d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:05:17 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-69b76062cffso7600552eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779365116; x=1779969916;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pGY+j87eohBlWubIX+vUu3zLxCM+uB8O9JAB1ecXkdM=;
 b=cHLBGZ0TBXqGLuKQN0VK8+SXZI92ulH1Um+jAXseARZ6JAo5pCmcaEi7IpsM1akjGU
 XIQgI3eRBMziFwM45i7fenOeCZF6vdO7l4VHYLlJpyO40zu0aX6Qr1wtSMaXskbYKfdD
 YWlpki8Ez1MdJf9RY+xUVmjShq/KxgviMeIOHPShw7IuRe3tgowHTGXmT5XLP/9OnZMA
 FMVNLR58MVnWgFKLP+prhvXQFsVlemiPHe2sIVY++lUPvW3TeZ0N/3QYJYE4vRWHZHJB
 SnW0Sz+mGgLfXLeugwZyCtlry6MrrnpL1B7mKzujH6ZFtzd/uxWw8lAMTh0WRlhrSe6l
 aOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779365116; x=1779969916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGY+j87eohBlWubIX+vUu3zLxCM+uB8O9JAB1ecXkdM=;
 b=OveqKYy9RGEZz8s/oll8EVYVaAASuE4+BtRSvO4rsPeeWSXAlNn5q1EpVhUa0fliWW
 NbsSjPwHMtN6dlr4TyRX+afFumpbWuS1CTfzqi2VUE/kYEZ1W/VVMzWmcVEIOW9JXMdF
 z1G+/P+OOx2B83vLSE7FOVqaj+NI7Skqxci2F+Kko3MJFt9T8gL6mRjyLI66qV3ydBpz
 8j6RfdQ+7l1Rjxr8xHKLMcLJ2fQ7OZu7Cb95NK0wFz/spiSFwL14agLbT5NuEZCwoFF5
 ggvr/IoV8xLcV5OaqGEi4uDTS0rHrJYc/IKq0Hc5/sIE4BQDR03mRZ9rADFh7kPHHcB+
 qCTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kNFaotESJfzEOnIutIVsvCC+ufiY0ViJ2ApOraZ5teab4eAeyNfoCK7yLvDQZFD5erVY7iLbkNAM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzqe64/Rp3htl9/S/X+esAFZmao9RKJBzTcSZ7rIDjWev4R/WDE
 mX/UxLZW7TZRMCHbNtUDA2FF2LuVXkg5Ghq5f+Wba5HDT9+cIrfb8HHQeRwNToOMcbX31YbNkYM
 onT13EHV2iprQjqZIQ+MurhWe82NuLFeROlgaHS9/yaPhBPXqr7Ox9Pj8qWUs4QYOKMRNza4=
X-Gm-Gg: Acq92OF/WV058luAciCSfDbkkToNJGRBZyM+YzzLzdPAOhlV+NI4MedsJFNyrQKmMMx
 xHNrd6M5DIwk+fgMW2xXJAYfgbeiuzt43remAcOPESyPNm39KQqmKU7WF18ftJg8Fj36EnLw27v
 1JmN7QZhM6Lqskh5mM6nhAYE7kZ8AKdQ1QVs4pZsVbSdyEZMfx3y8KsCnDbtRQo37IWWnrKOuuu
 Bbzo68gQo+rlJkaGBfFhbNsm43Ce6RkKBXr7gcXs67humjph9Afs5k1srJstFPPfxVFd3Na+I9k
 O/SbaCF/TK1Ga0uRsE/b2bKW5WC5Dt2vPrzDR+vCCkFheZdbt++79qSGIUlG+ybvVDF6xws/piZ
 9xIgpGt9fwQ3a+XdXKAidUfd97sTlECZL9lbfcnQh40SKUfzolHGKzyrtyWw3D2Bvm7PMXB6H7q
 yU3KAB/MEnsx9Y/ARokrytnQ62cNjEcwyYfug=
X-Received: by 2002:a05:6820:1348:b0:69b:bf80:2db5 with SMTP id
 006d021491bc7-69d6ef409f7mr999610eaf.52.1779365116353; 
 Thu, 21 May 2026 05:05:16 -0700 (PDT)
X-Received: by 2002:a05:6820:1348:b0:69b:bf80:2db5 with SMTP id
 006d021491bc7-69d6ef409f7mr999560eaf.52.1779365115873; 
 Thu, 21 May 2026 05:05:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d0a107afsm2201901fa.16.2026.05.21.05.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:05:14 -0700 (PDT)
Date: Thu, 21 May 2026 15:05:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH RESEND v3 1/6] drm/connector: report IRQ_HPD events to
 drm_connector_oob_hotplug_event()
Message-ID: <vpd5hyote5wspmlpad64kf5peoy5g7wv6c7xjn6ammcmjtai7r@q2tarmr5aoqn>
References: <20260513-hpd-irq-events-v3-0-086857017f16@oss.qualcomm.com>
 <20260513-hpd-irq-events-v3-1-086857017f16@oss.qualcomm.com>
 <20260521-funny-astonishing-mackerel-cc5a01@penduick>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-funny-astonishing-mackerel-cc5a01@penduick>
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ef4fd cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=mRF-X4ptvIx_UuOgb7IA:9 a=CjuIK1q_8ugA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: 0xScawmclQK2yfcFDpCEbwAooFkUVR9k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyMCBTYWx0ZWRfX5gi4fjkF5Rx9
 z7yWn5YUR/UNj95k6iCVZLqtjUrvuNDyUTpDx23ZGVoa7tWaT/qwDUy1zU11XL+4CtlVb6NgnA6
 WBtkSEte2+BhNyC9JSCoanYPFzvksEC5UDU2zfRb99xYCRqlgWD4GfCEZxZnEfLvOC4iTbZd0DX
 vE8Zz3ZoOylIA+YTSq0tOcietKWVgZrv45lZn9fFioQNu6c8Fvbuxfu6KL567DfnImT7RDfVKK4
 +9ZPkvWW/TZIyN5UUZXZtOTH+k7fczz1q35XM9KtxxUIXa9JB+SeWq8vqiQGxQFgwWgf4BJ3M3z
 7I8q3RBmnVq2V5wIG+50WA4F4/Aqtys6GbvYZFpX+wyKdyJ9BK/mQuj2QE2BBt1WsZ/EhtkV4Lt
 hnrDF2y5VzXxS7dbYEwu3DgE7Lzt7tsbs1kjkacuCIjhrZDJiT3G2Hm5FhXT2JK19zi7AyvB9uD
 kocYdC4GjF8szLEk70A==
X-Proofpoint-ORIG-GUID: 0xScawmclQK2yfcFDpCEbwAooFkUVR9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210120
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

On Thu, May 21, 2026 at 09:47:29AM +0200, Maxime Ripard wrote:
> On Wed, May 13, 2026 at 09:23:21PM +0300, Dmitry Baryshkov wrote:
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
> >  drivers/gpu/drm/drm_connector.c          |  5 ++++-
> >  drivers/usb/typec/altmodes/displayport.c | 15 +++++++++++----
> >  include/drm/drm_connector.h              | 19 ++++++++++++++++++-
> >  3 files changed, 33 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index 47dc53c4a738..edee9daccd51 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -3510,6 +3510,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> >   * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
> >   * @connector_fwnode: fwnode_handle to report the event on
> >   * @status: hot plug detect logical state
> > + * @extra_status: additional information provided by the sink without changing
> > + * the HPD state (or in addition to such a change).
> >   *
> >   * On some hardware a hotplug event notification may come from outside the display
> >   * driver / device. An example of this is some USB Type-C setups where the hardware
> > @@ -3520,7 +3522,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> >   * a drm_connector reference through calling drm_connector_find_by_fwnode().
> >   */
> >  void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> > -				     enum drm_connector_status status)
> > +				     enum drm_connector_status status,
> > +				     enum drm_connector_status_extra extra_status)
> >  {
> >  	struct drm_connector *connector;
> >  
> > diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> > index 35d9c3086990..7182a8e2e710 100644
> > --- a/drivers/usb/typec/altmodes/displayport.c
> > +++ b/drivers/usb/typec/altmodes/displayport.c
> > @@ -189,7 +189,9 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
> >  	} else {
> >  		drm_connector_oob_hotplug_event(dp->connector_fwnode,
> >  						hpd ? connector_status_connected :
> > -						      connector_status_disconnected);
> > +						      connector_status_disconnected,
> > +						(hpd && irq_hpd) ? DRM_CONNECTOR_DP_IRQ_HPD :
> > +								   DRM_CONNECTOR_NO_EXTRA_STATUS);
> 
> Since the extra status itself, and what the options mean, are DP specific, do we really want to
> extend drm_connector_oob_hotplug_event()? I think I'd prefer to have a DP specific variant, with its
> own set of parameters.

I can try arguing that drm_connector_oob_hotplug_event() is DP-specific,
there are no other users for it, only the DP AltMode driver.

Anyway, do you just mean new API here or new API and a new connector
callback?

-- 
With best wishes
Dmitry
