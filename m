Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC49CD98D2
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7D410EB04;
	Fri, 12 Jun 2026 18:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyzaGnik";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R+cZTqxF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263F910E314
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:53:39 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGUZnY4152830
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=v3/Hm6Xq7WCrgTyuR+mYm99o
 byQyGcdOpmpb0F6ke1c=; b=QyzaGnikY7lvP+gYNtF5B5gsq2WmUJGU6b/iEyc8
 SM60hoYQ877RExS0N7DGLbXtTL5/6KRJJw7ZeGH5x87tjPexRkoTotluUY0BnFoF
 HkMji3P7vnUoJFsacAa7h3IxAfTGy3w+v0t6lhiq0m2CPW7jNKXBP9dy8oZQAYes
 /x7yvsuAm61BlmQgJFdUBuRG9rWEKgjMq6Ve3gPdCoUfGxiYeVrB/2byyKH95qPH
 2lgtErJZxVrg9WL1eI0Tx9nasXDLeiH+aWXhjUscB+gmB6mXz9YnPbeuLzbPtaHi
 OJTYOJiWMIh/LNLvFxLza8JV0OnU+OYW/dSj20tJKJptdQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcmcjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:53:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9156ceb551eso196623485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781290417; x=1781895217;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v3/Hm6Xq7WCrgTyuR+mYm99obyQyGcdOpmpb0F6ke1c=;
 b=R+cZTqxFXAND7TTnZ4gLWD4PPTVhpXdqetEi/BxK89/wW/mKLXbJBwuG/jFzf0pli/
 Bs8e2Ge4cEtW8xGKSo4eM0Z2OhRKivQb0QJcg7YYBKHIHpI0Jlbj/LPrKs7sNoXxQ+61
 //WgXvnBfsKbXNjsUPBHRAyW77TepfF1Gmttfdf40cdR8bIevL+i6sXSQTmD11jgjWhv
 OjG0AMpg46u36MI50V+RzGvbFNaJRwegljhNXzGtP5F3CopWSFe9IEoxm8RbnKIpOOZk
 O4VdyYL8M3W99IsoR2eP3vn/0XI8OAhEYutEiG7L0RGd9nWdn24AapoR7OyHMMMmKppf
 hoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781290417; x=1781895217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3/Hm6Xq7WCrgTyuR+mYm99obyQyGcdOpmpb0F6ke1c=;
 b=oIue+yfWH/av5WMVL+a5c9rSkJhhsqZ89MSquT5w/pcXtwEa+pymi9qx9LW+DiHG38
 zRtXCL3fPynSIWBiT5PUL8PJbAuF/2+lsQOHBzoWwufIXIG4ejkyuLY3zVmyRd0kZo7R
 oA9+nrUtavGI5H0g1Ns2MrxxFiLy9HidcmgmzAFokrScg/9rcD44iR9F+Hl2qWTV3QAW
 vsHjJxvyw0o/8EhZuBo32axKj6g2YALCFFh1uKV6D+IsfY9Gtl2USU0268CXga4hp9EO
 +Z0Ne90wqgkZgVkY0yIzkfKTbAVmhrwaaWt2ulYfnnBAdFzp0BIr9t4yIqzw/zPKhb6o
 Wf5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dWwjKK/k8iu1ZZlPtjos4BDOW+xvr7lwQH16zFiCADVGgeUMpv1fedjPMn2f/cebWD5xirEnBVDI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdaKn4gZNsAKFkX+JZ/xOGBXYKvNduwA9+SuQVnlL+Vdr5Ns04
 u120Pgud/2NTtUGDRhdZWCxroa8JAYyU14iPixaJIupLE2P3ax07po1/bCAxB68jhaIfQ1IX2HD
 /JCKl0k1XvwS3qehHTNko0Cw0s5FDHc0ui63VT/NrRUk8ZZ3Go9FQiaLuPzHfHmVrRqUewfY=
X-Gm-Gg: Acq92OFVYwIjSnNvavKakzQXeMAN2b3HAn8l6fLahzvgJp2ln56X2vmGO7mBNfcP9B7
 yENhFrZFwD8IvQWAUyBQ0IEMOaMKf1NCSx/UlVtxt9Zu3RxfQtcMsCcubXk8roDwokPSJq/5GzV
 Ll+591lT4h9wi+MVQEgmjUd+vZpnebgYmVFk8iTQVREnjRdKfLn95ZZRKj8bpjdQrSXcFuf6Ze5
 F0tzWHuU5k5Lx76aBlu4R72QRF9FgKOKpVp+Rqzgt6iRvMYXAWaakl6R8m1Z5M3sz6mFUCcP+Ei
 nsK6K7K/akVzyi5b1SpM9oL1NEhghgNWD8njVim2EvBEi9R/pVwtlelqj4OZkG1vUaVjdgpM+9T
 tOu4Te7p2T2D9FMCsYHSUKSmhqOP/uUa9jDlWRP4gfG/Xz78/CmzjChjWyMTtD0wEJVRHRks3aL
 mxkHYdRIjOhcRCcmDoDewvx54a94gwaShbZ/g=
X-Received: by 2002:a05:620a:17a8:b0:910:db3a:7bdb with SMTP id
 af79cd13be357-9161bc8d778mr559907185a.32.1781290417444; 
 Fri, 12 Jun 2026 11:53:37 -0700 (PDT)
X-Received: by 2002:a05:620a:17a8:b0:910:db3a:7bdb with SMTP id
 af79cd13be357-9161bc8d778mr559899485a.32.1781290416844; 
 Fri, 12 Jun 2026 11:53:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1ae1absm726479e87.59.2026.06.12.11.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:53:34 -0700 (PDT)
Date: Fri, 12 Jun 2026 21:53:32 +0300
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH v4 1/8] drm/connector: report out-of-band IRQ_HPD events
Message-ID: <hxto2g32oyfy2tlihdgpjy7bwkhxp2cdw7qnf2rvpl7g7jczen@5js56gor3z6t>
References: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
 <20260608-hpd-irq-events-v4-1-30b62b335487@oss.qualcomm.com>
 <20260609-bouncy-tomato-dalmatian-70ccee@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-bouncy-tomato-dalmatian-70ccee@houat>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3NiBTYWx0ZWRfXxroxC8lxPFdP
 DU8dfXRhyHyobUyHf+C1/eOHY4DKTjfWz1ZVmQClpoowmGytlZtGk0IFlNd3SMfbO4b6V4fIbYm
 OaXYib/1E9PqMmjGIOhUHAAbgfJ7e9EYL+vDTZcLEDFIj3BIPwL+8Y6dV6jCOUERsCtWmL0ofcQ
 KNdK7I44wiI6F+hg5SJ2jvgHbtYLnyJOIiPpGmxSC4DOzm52JNRdtSh1CCwDzPK64JiYCujAwGL
 qyS0zMM/LuIeUkjmjGcxhK5GQcmQOOBRo9F7NSShPTUZQLaMH1hOlqipbh4DZiGug3G6u6pjPi8
 5mTe3S4xd4NKaydu14XWOCf154HXxhLpxDwHsO4UyVwrRKFsewQm2PRRmGSTUbhaApsnuYEafH4
 2QSqdFanBsTbBnLD9HjPluKqggxaWhtD/eKAOlUll4vzoMPR+KgYcEUEj4udgZkb0a1U92KzdWR
 1fRAgGVpXuItvL6+Xcg==
X-Proofpoint-GUID: mU6rJiZXCi0wOVQCflCZYMSQgusswH6C
X-Proofpoint-ORIG-GUID: mU6rJiZXCi0wOVQCflCZYMSQgusswH6C
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2c55b2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=Qs5g3gW-Ea0FhcstOt0A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3NiBTYWx0ZWRfX9NaqR0tp/F9Z
 tshQGGgJv0lAamFwQQ1BesSzAJ4sqX4hwjXuBxQwJxlia0hiy65HhmjObQEq1wFQQ28uZkWIoTF
 VrPocdLz3ZN3ovVeFmwsSfiX8nzHo4c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120176
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

On Tue, Jun 09, 2026 at 03:20:01PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Jun 08, 2026 at 12:33:02AM +0300, Dmitry Baryshkov wrote:
> > The DisplayPort standard defines a special kind of events called IRQ.
> > These events are used to notify DP Source about the events on the Sink
> > side. It is extremely important for DP MST handling, where the MST
> > events are reported through this IRQ.
> > 
> > In case of the USB-C DP AltMode there is no actual HPD pulse, but the
> > events are reported through the bits in the AltMode VDOs.
> > 
> > Rename drm_connector_oob_hotplug_event() to drm_connector_dp_oob_status()
> > and extend its interface to report IRQ events to the DisplayPort Sink
> > drivers.
> > 
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/drm_connector.c          | 20 ++++++++++++--------
> >  drivers/usb/typec/altmodes/displayport.c | 23 +++++++++++++++--------
> >  include/drm/drm_connector.h              | 21 +++++++++++++++++++--
> >  3 files changed, 46 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index 3fa4d2082cd7..bb128dd0263a 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -3502,20 +3502,24 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> >  }
> >  
> >  /**
> > - * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
> > + * drm_connector_dp_oob_status - Report out-of-band hotplug event to DisplayPort connector
> >   * @connector_fwnode: fwnode_handle to report the event on
> >   * @status: hot plug detect logical state
> > + * @extra_status: additional information provided by the sink without changing
> > + * the HPD state (or in addition to such a change).
> >   *
> > - * On some hardware a hotplug event notification may come from outside the display
> > - * driver / device. An example of this is some USB Type-C setups where the hardware
> > - * muxes the DisplayPort data and aux-lines but does not pass the altmode HPD
> > - * status bit to the GPU's DP HPD pin.
> > + * In some cases when DisplayPort signals are being routed through the USB
> > + * Type-C port the hotplug event notifications come from outside of the display
> > + * driver / device. In this case hardware muxes the DisplayPort data and
> > + * AUX-lines but does not pass the altmode HPD status bit to the GPU's DP HPD
> > + * pin.
> >   *
> >   * This function can be used to report these out-of-band events after obtaining
> >   * a drm_connector reference through calling drm_connector_find_by_fwnode().
> >   */
> > -void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> > -				     enum drm_connector_status status)
> > +void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
> > +				 enum drm_connector_status status,
> > +				 enum drm_connector_status_extra extra_status)
> 
> Thanks for the renaming, but I think we can also rename
> drm_connector_status_extra to something a bit more descriptive now?
> drm_connector_dp_oob_event? status?

I did not want to introduce a DP-specific interface, keeping the HDMI
eARC HPD in mind. But... Let's get it nice for DP first and handle eARC
if the need arives.

-- 
With best wishes
Dmitry
