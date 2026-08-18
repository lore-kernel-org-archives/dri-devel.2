Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17071C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526B910E4AD;
	Tue, 18 Aug 2026 03:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gEIfS9N+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dyy/YxXj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEA310E4AC
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:22:14 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLkV7e3370148
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=j73bG+tmYVwAb5KvFoWsfW2d
 3OEy+/PhR/daxy+LBa0=; b=gEIfS9N+MIBWmQuKtz1VxzQ2+YyWmcmHg3HmqF41
 bQj6qxawqRFoTLNd9Pd9yeyek2qdJZyW0QKTsk8CD8jS3Bi1EUqAXB5OP5yYPdyl
 OsowqZlj1kWOPVi26fWMmLqTDUUUu7FWu/ZziKXReKe1LmOlmKUMBNWGTbUwxCEl
 WDtYDlvvUlRnmLvH29k6UVnN0sdSo6p3LHQQFY3RIzjeBncjsfzbroXqP0nSQ8dg
 L7bBnA5upxEuD5z0l6zXP61s+OHc98FNNC2BM2NbRFi9aHPnC/k2hd0wdGACnpPl
 Wk+EAN/mdc5M1jsjZzgLhFMSpKafUYOaOlwUakC/8SBIWg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xykc8dq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:22:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936cadb0e8bso354608785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787023333; x=1787628133;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j73bG+tmYVwAb5KvFoWsfW2d3OEy+/PhR/daxy+LBa0=;
 b=Dyy/YxXjltL51ft58h9gWrUeNAbZxKqhwzhh2qPzS7YEf07CnoGOJxuDzmjj6ippnn
 Sfd4vEudPjqJqyc83GqKLKwNKbJNXDQjI7xCJeaGk0vrttjDMPiOg/jQG0Hw+wtY6SLO
 1kAIaHc7YyitfMuxg37rwQioAZ9qj3lcZFwvfYizJuYxcPdzSIswQ3iRf1xHUIsI0N7v
 +1yA88fzVS+dqQzfmZm+GK1ahqOw94v1m2NLvm+ndg8OaNdJ/i7f6Ok3TJ4NfYAnNWH+
 2jWpbc4Yc3jqzO340YPZl17cR0pjQ5rgmWVFJ2YCI5pZqI6WoUqUTtw7lsGRAkTZDOLV
 hLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787023333; x=1787628133;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j73bG+tmYVwAb5KvFoWsfW2d3OEy+/PhR/daxy+LBa0=;
 b=PiIzBbPsq0ceMmxiWFyR/kheOXQki6lvjxKckR02q6/GlabGfktSK5mN60/Wu8wYR2
 oPNzjeVZ0N6rPmWnqMTxvMJ/8O/LJci8yrNdNItsAtGwUmw0+vgoqJQJUZt1CbldRIX8
 DoBOUP+nywaWODqz0xbkqEIKArY2/i5QOrGHVhio1slhHPjYkY4PKFX8s+LL3tJpe+PR
 Z53ENy/SzJpGxx0CDUp2Q1lEmRKAtU+qJAlTx+TWEoQVpn32H6bgtoYIINItvNT8HynM
 B9CWDatTHHS9hRdXMSe1GJSTh64wsmf9NAvfyUWBJDfNEnyVjGM5J0AOk3tEK+73xJXL
 HdaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoscJMta2J6c635lhROXDH8KHiJ8luZziX8KoJ38vq4EAh4ApMbHtH6tbQQ/0/rMPaM2Sz0c7XChWA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvMEVOdE92NLudi7joKJ2DYwmFioKnXYmdgGpTyXXEfxKSHHWV
 Bq/Fn/jRdRk43y+H+tL9M0bvkYpvGmUmv4nYa5uIOLG4txhWw9PW2R9kVReudkTBW2NNCQfL6N2
 ii8CjEAAQidZMRreESRhhupDtJjOGAJ1gHPx7Qhl18xgU9CEKV+7VSFSdre6Mf/qd0dP+lRQ=
X-Gm-Gg: AR+sD13BlWfIHbOpYMSc/PNCqyGXn4HfX7YDAHTCExNxdF5YlY0A3vW/a1TkJxeh8hh
 07JUF8Z3GrhjsssTGyCYEZGlbyt6Xmu/IKVLQLy0SmJbjJrodXsKCwIW6wYsBg+XogGpQGP61g7
 DiXcFrwHGspltXkKAmDAp98Eg6a4NGUqZcXu+jPZ1VjUv1wkNdohKvSkKWu5L/e2F2nzb2HcXQy
 4WwcLU+eI5vUcvxnbBO5IAgaH2s7Kkoxf+XXiIA0KmXZJ37X/r4nd94fpNzK5o4fGsYFkCXzHpa
 Lwd6QhDjl4cVAQvjuWBVBULwN2BiB95MQxLUER2L2n9267lQW07CCmy1bSVxn4fvX56T+NPxME2
 8xB6KyyRTeE+ftfv25v95H7QC0AYEZeI8fJg703q7sS64KUmJZJLUyJAh9kjDwcetYAVmvR3TbK
 SLIGWX72TPrMd9
X-Received: by 2002:a05:620a:e1d:b0:936:bcf9:8539 with SMTP id
 af79cd13be357-936d232dab7mr1974700785a.35.1787023332832; 
 Mon, 17 Aug 2026 20:22:12 -0700 (PDT)
X-Received: by 2002:a05:620a:e1d:b0:936:bcf9:8539 with SMTP id
 af79cd13be357-936d232dab7mr1974694985a.35.1787023332068; 
 Mon, 17 Aug 2026 20:22:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cf95803sm836861e87.1.2026.08.17.20.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:22:10 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:22:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
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
Subject: Re: [PATCH 3/5] drm/msm/dp: suppress bridge hotplug events during
 MST operation
Message-ID: <r2xv3lsvku2wlccf44dlesqgrjqbvjrvike3jfx7casembecrd@3mw3olil5toz>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-3-646a10256233@oss.qualcomm.com>
 <fozk5fz6bgat55vmlgyvovnmfzabjprna46cmcaoh4jyrwmbtu@k2qtjgip5vg3>
 <d4e96255-814e-4fb5-8d97-50126a61c20b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e96255-814e-4fb5-8d97-50126a61c20b@oss.qualcomm.com>
X-Proofpoint-GUID: 0PRS5Pjsil-A9EPegsrDo2SGX9CiQMug
X-Proofpoint-ORIG-GUID: 0PRS5Pjsil-A9EPegsrDo2SGX9CiQMug
X-Authority-Analysis: v=2.4 cv=dLaWXuZb c=1 sm=1 tr=0 ts=6a83cfe5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pvfFc-ymSHibiSm0GcIA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyMyBTYWx0ZWRfXxHm0Wj0pThSQ
 RBOJcmJmi5pc5qBK1DSQPItgDl66UObquJfY703vl36na+1rg/oIxzWnlbZoluJw60kM9bNIsG1
 D55LnHAC7wamWsCzOdnPeEuyA/Hu4AoJ6hEsstU/+TudejzTgBi4e5E1qBk5/5uG1iAR5ZGo2j3
 BUJBMVFZxapnGVXIP9NL/rBbOm4EPVLHQDOXPWkhl0CHEZUlsm2mjzJ1NIZHdMUda2i5fcIwf1P
 EWD9RCzSCL6iXecOcpYdFdCJKzSI1JTbLtdEyTNu6D5lNsQPXjhss8RXEBiMT8ryPx3tDSOeFAY
 BCr2GIX3/lBj957s5Z++e8N58RJNDZPvpEWK4uRZ4/7F8a+hwC4I7ru0jePV1j5BfgmJ6D26CoV
 mCs5itguf/yrJ+9PtizwyT0s9wjPI3BsgZzzcs1prms0sv77WPflJlq6TwFvjzzLHH4hSdCGiRS
 8VqBg0h30FNTBcIioXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyMyBTYWx0ZWRfX75h7DjLV6B35
 eADukIIlPkvXYiiiD5L/TUBFxCcLjzaZQxbucWc6K/uozvYI5xKTg91ZGkvbhi30W+fpd6CGeUS
 b1i2QP+QzMQlixvi7V0CqTcmUhVXqF4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180023
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

On Mon, Aug 17, 2026 at 04:01:36PM +0800, Yongxing Mou wrote:
> 
> 
> On 7/12/2026 6:44 PM, Dmitry Baryshkov wrote:
> > On Mon, Jun 29, 2026 at 10:48:05PM +0800, Yongxing Mou wrote:
> > > The DP MST framework already generates the required hotplug events for
> > > MST topology changes.
> > > 
> > > Suppress connector hotplug event generation from the bridge connector
> > > path while MST is active, and continue propagating HPD notifications to
> > > the DP driver.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/display/drm_bridge_connector.c | 6 ++++--
> > >   drivers/gpu/drm/msm/dp/dp_display.c            | 9 ++++++++-
> > 
> > No, it can't go as this. The drm_bridge_connector part should have been
> > a part of the first patch.
> > 
> Got it.
> > >   2 files changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> > > index 7334d6677604..82ed0dc450ab 100644
> > > --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> > > +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> > > @@ -162,6 +162,7 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
> > >   {
> > >   	struct drm_connector *connector = &drm_bridge_connector->base;
> > >   	struct drm_device *dev = connector->dev;
> > > +	bool send_hotplug = true;
> > >   	/*
> > >   	 * IRQ-only notification: extra_status carries the event but
> > > @@ -179,9 +180,10 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
> > >   	connector->status = status;
> > >   	mutex_unlock(&dev->mode_config.mutex);
> > > -	drm_bridge_connector_hpd_notify(connector, status, extra_status, NULL);
> > > +	drm_bridge_connector_hpd_notify(connector, status, extra_status, &send_hotplug);
> > > -	drm_kms_helper_connector_hotplug_event(connector);
> > > +	if (send_hotplug)
> > > +		drm_kms_helper_connector_hotplug_event(connector);
> > 
> > But now I can also see that the idea seems to be incorrect. You are
> > preventing the kernel from sending the events, but it doesn't really
> > matter. If connection status oscillates, then other components might
> > notice it even without the event being sent.
> > 
> Here our original intent behind suppressing the hotplug was
> that, under MST, hotplugs should be sent independently by the MST
> framework, rather than being emitted along the IRQ handling path.
> 
> Following the extra_status approach you introduced, would it make sense
> to let the bridge_connector layer distinguish between long pulses (HPD)
> and short pulses (IRQ_HPD) -- a short pulse would not update
> connector->status and would not emit a hotplug, only forwarding the
> event to the bridge driver. Does this direction sound reasonable to
> you?

IRQ_HPD is not limited to the MST usecase.

> > 
> > >   }
> > >   static void drm_bridge_connector_hpd_cb(void *cb_data,
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 6835c68fe510..bc93b566fbca 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -1790,10 +1790,17 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
> > >   			msm_dp_hpd_plug_handle(dp);
> > >   		} else {
> > >   			msm_dp_hpd_plug_handle(dp);
> > > +			/* mst_active is set in plug_handle; suppress SST hotplug */
> > > +			if (send_hotplug && msm_dp_display->mst_active)
> > > +				*send_hotplug = false;
> > >   		}
> > >   	} else {
> > > -		if (hpd_link_status == ISR_DISCONNECTED)
> > > +		if (!msm_dp_display->mst_active) {
> > >   			msm_dp_hpd_unplug_handle(dp);
> > > +		} else if (send_hotplug) {
> > > +			msm_dp_hpd_unplug_handle(dp);
> > > +			*send_hotplug = false;
> > 
> > Why? Disconnected events definitely should be reported further.
> > 
> In MST case, MST DRM framework will send the discconnected hotplug by
> msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);.

msm_dp_mst_display_set_mgr_state() is not a part of MST DRM framework.
But, while we are at it. The MST framwork needs to be updated to send
connector-specific HPD events.

> > > +		}
> > >   	}
> > >   	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > 
> 

-- 
With best wishes
Dmitry
