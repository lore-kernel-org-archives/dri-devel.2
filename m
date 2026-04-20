Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC9DF55802
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4822A10E48F;
	Mon, 20 Apr 2026 09:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W57WOtCe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HKe+jwXq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F0610E157
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:50:10 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K8IhSn3301616
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kWuPigQBRvg2mmG1YEkZ2x38
 8ocHV9caZV1E1+5l688=; b=W57WOtCeOcicX3eqOdiyb3EDavkLG5irwHoXW55M
 wmRlpJepFltE0GBwDB/eEZBvMRLgtu+23T/xt1DZn4WHzXcrKRfoVPgQut1CClJX
 VOYHOXibM3WI5SZiwdhnS4DizoNnKO4tGaZ4JSDZcp8Th2Dask97hw6Z7ZhAr1cP
 aMwPD+EXq8OVfnwV4UiLLWKNWccIeCI0Dub5H2t9t3AcazG6saJukNtykdqRYJkj
 D4s0lFeY98n8l5NcyXmUp7ALuyhcmg4wVEJt2Z//32LLZZj1qsrLH43JCZX/QjPe
 A2yRQiUlXqP2y/JQ0XNndxovMBtB55L3BZJYG3/1Jqd95A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr5mrq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:50:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50eb8bad331so9897461cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 02:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776678609; x=1777283409;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kWuPigQBRvg2mmG1YEkZ2x388ocHV9caZV1E1+5l688=;
 b=HKe+jwXqAMTzTly5iC3qHJ7xfAzBlEF3qX5DLEKmIoOHyeOaiKdKWEWC8scqAc/27O
 n9cewflgYxHPBZKjQVcUzSekNPSK/3UpUul+HkVu8pdw3c7W+OMG+FdLnHdiWazgZOVQ
 RsBNFOXWuz1fgnKQwDUh9haKdfYvYuEjNkaUZxF+/OYEQDWV36k6r5HB4Vnv4MORIPdg
 yJk7F2S9qY/8weiY4pXEiUuhXh+u7M3NvaQk3Aft0mkRjlWYFPaWTlXyIjc3U9LeDBga
 4Lfc0X1mD5iSfiokhdaa0IwMFZhcOEx3LoLL+MZH0iq1RbBlKVn2dKcHYTRHuOgl0996
 lvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776678609; x=1777283409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWuPigQBRvg2mmG1YEkZ2x388ocHV9caZV1E1+5l688=;
 b=XVxnLgSv78wx+9xZFswi6I9gmzgWp2RYZT+rFs2D0rL2YBlot/ERlqyBspTIzRmiqq
 2JComJZkv01EBaYZ+t7GEtv96FwYLw07pBgZvoZ5wZ6vYfaui+2nMbJubq1ZJgojXy3s
 S4v8k0MqsmPElvZouN8bI0lKLkrjXmw6Qj3ZIt9pv0K9gbRgEsBGxX+6ppemZT/ne1dt
 6fqt4EOL8IBgzWeITqVEU424yFL7aQKRV+QAzOORlfCabdI4NS+NSltjJtJrPWm+qAck
 nsvI1c8irAjTbE9ChkU0ETtEiGFP6qwQDHq/SDQZr3UeAqcDxDEe5U5J+tcxAooRNs6+
 InlA==
X-Gm-Message-State: AOJu0Yz8TaZNq1+Ku1gDL97S5pu8hxDExzSzxQrvfC4AcHGNij1lNgUa
 p/IRla4CLnEJ4C8o8Y4TwDtibWA+JX6qh5hPgd/e9wiZvqE0+exitHwkZAt2A3TOgKH0MINSpFN
 IH3uTcjBk2WGBUARNqVP6N3oGtVsJAY41H6rydF8SYrYUKoc/8DEJuCL5hGQR4Pq7BcVjZa0=
X-Gm-Gg: AeBDiesM8pQp60fZqcM4veYVESA3gfWyPg5rHX39xA3QCY+veQExXMBa3jQtriQTXtF
 JZSe96UkbDtCNHWf7gGLsu35PDN3UM5r7ZfkLaZ4FEGvBXPg8FOiSQU+OoKKgTaz5u0LjmsUNYd
 fHB7py4P/40691vTWkpJeNrAE31NKwTfaMbqZXvjY2PSoAe0AtUkemgZl/oaO3oDHu6n7SI5Hd8
 2NUGwSatoLBz/xC9Xpz1GKCzOiqjlVMVhXyuE1uPjl3t9ckkAlPzsbHO0+pWwAiVggn/ryCrXvC
 tla9LctWdfUTHaGz1E3c/XPfra8Ep/a6rV/6lY9feez4z0fBBxSLLG6SrESIS4vjTqkj831j+lr
 n+1Ix8whdirEUw5Xd1YnAM/Nrhnb0AmGP9sZ7iPtU/iv2xA2bgN3GRT30qb/MobaIOM+YW0tJP8
 dcHvG1gBnjsZWs1exMJxHpqiYQPlvgytS6JujvfBfVb4ulgw==
X-Received: by 2002:ac8:7f15:0:b0:50e:5f37:a821 with SMTP id
 d75a77b69052e-50e5f37af22mr37012941cf.36.1776678608850; 
 Mon, 20 Apr 2026 02:50:08 -0700 (PDT)
X-Received: by 2002:ac8:7f15:0:b0:50e:5f37:a821 with SMTP id
 d75a77b69052e-50e5f37af22mr37012641cf.36.1776678608356; 
 Mon, 20 Apr 2026 02:50:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad138sm2859553e87.9.2026.04.20.02.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 02:50:07 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:50:05 +0300
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
Message-ID: <3vrqk67oivkgo26xdc3r774rvj3jn3t6sfydhlytyrfiftubhg@cipain7xxcjz>
References: <20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com>
 <20260416-hpd-irq-events-v1-1-1ab1f1cfb2b2@oss.qualcomm.com>
 <51b7c44e-36c9-461f-983a-eaa86eeb8cfd@ideasonboard.com>
 <6z572fdjkvjqvedifwvotgdy4lcrifiqvkjpnutousjqc6764r@zepfzkqy2kbu>
 <a2e60e74-a1be-469d-8f4d-ecce1f30b517@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e60e74-a1be-469d-8f4d-ecce1f30b517@ideasonboard.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5MyBTYWx0ZWRfXz9pqvjNxC1i6
 rylkxoFPlGe5qypmKmNFHP/JcZgJTvvFpmugclZegkaRIkmhz23zdxE+O7rK5nGPbAxTZFWeMxW
 fI4cbdlw4E36NEmFGbLMAYjNKQQJihqAmLZw4dOIkK2NvsguVRZtlMlxrmSUl13xFaHn1rxX+oH
 0GhGbjtwBcvobZyj7f6oi3qV8xHogGGl8ulDS8LhT1OCqLaHnQco+5R0PzI/obsxc26+vMhomhS
 gg6q25jiEjsZBmXWxxWP6W+PGoSnqlgIQf4EruaF8q+9aH+KG62F6YcxKnZpSr8OGiIeMYkz8PV
 843CaWIg5Iz8n46ARDQy+yuI7VE14rm//Ps9ZM2WmX8hbDmk8+NPKuRHgL+jdOWaj7T5n+CQ5uv
 Fg0ZILYafWvNuthTD3S6nS+FZxiZr/vJHltURJzVBTm3zlFsdWttMwKaLI1V2Sw1O56uRsqACWa
 tZsr4Nz7vytLrQPXhAg==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e5f6d1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=VVbN_I7Xu8gywQYyaxkA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 2VErkB397np_zzBSkv9fONqxkW7ho1er
X-Proofpoint-GUID: 2VErkB397np_zzBSkv9fONqxkW7ho1er
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200093
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

On Mon, Apr 20, 2026 at 07:50:46AM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 18/04/2026 01:32, Dmitry Baryshkov wrote:
> > On Thu, Apr 16, 2026 at 11:10:03AM +0300, Tomi Valkeinen wrote:
> > > Hi,
> > > 
> > > On 16/04/2026 02:22, Dmitry Baryshkov wrote:
> > > > The DisplayPort standard defines a special kind of events called IRQ.
> > > > These events are used to notify DP Source about the events on the Sink
> > > > side. It is extremely important for DP MST handling, where the MST
> > > > events are reported through this IRQ.
> > > > 
> > > > In case of the USB-C DP AltMode there is no actual HPD pulse, but the
> > > > events are ported through the bits in the AltMode VDOs.
> > > > 
> > > > Extend the drm_connector_oob_hotplug_event() interface and report IRQ
> > > > events to the DisplayPort Sink drivers.
> > > > 
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > ---
> > > >    drivers/gpu/drm/drm_connector.c          |  4 +++-
> > > >    drivers/usb/typec/altmodes/displayport.c | 12 ++++++++----
> > > >    include/drm/drm_connector.h              |  3 ++-
> > > >    3 files changed, 13 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > > > index 47dc53c4a738..5fdacbd84bd7 100644
> > > > --- a/drivers/gpu/drm/drm_connector.c
> > > > +++ b/drivers/gpu/drm/drm_connector.c
> > > > @@ -3510,6 +3510,7 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> > > >     * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
> > > >     * @connector_fwnode: fwnode_handle to report the event on
> > > >     * @status: hot plug detect logical state
> > > > + * @irq_hpd: HPD pulse detected
> > > >     *
> > > >     * On some hardware a hotplug event notification may come from outside the display
> > > >     * driver / device. An example of this is some USB Type-C setups where the hardware
> > > > @@ -3520,7 +3521,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> > > >     * a drm_connector reference through calling drm_connector_find_by_fwnode().
> > > >     */
> > > >    void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> > > > -				     enum drm_connector_status status)
> > > > +				     enum drm_connector_status status,
> > > > +				     bool irq_hpd)
> > > I find the "IRQ HPD" naming always confusing, even if I'm somewhat familiar
> > > with DP, but if someone has mainly worked on HDMI, I'm sure it's even worse.
> > > 
> > > Can we define this a bit more precisely? Is 'irq_hpd' only for displayport?
> > > If so, perhaps 'dp_irq_hpd' or 'displayport_irq_hpd'. I might even call it
> > > 'dp_hpd_pulse', but maybe that's not good as the spec talks about HPD pulse
> > > for both short and long ones (although in the kernel doc you just write "HPD
> > > pulse")... The kernel doc could be expanded a bit to make it clear what this
> > > flag indicates.
> > 
> > I attempted to stay away from defining a DP-specific flag, keeping it
> > generic enough. HDMI is pretty close (IMO) to requiring separate flag in
> 
> If it's not specifically the DP IRQ HPD, then we need to define what it
> means. I tried to think what it would mean with HDMI, but I didn't come up
> with anything.

I might be mistaken, but I had someting like HEAC HPD / EDID status
changes in mind (or HDCP-triggered HPD status changes). But here I
admit, I hadn't checked if it is actually applicable or not.

Anyway, for e.g. DVI or VGA that means nothing. But, my point really is
to abstain from defining someting as DP-only in the top-level API.

> 
> > Linux. Likewise I'd rather not use "pulse". The DP AltMode defines a bit
> > in the VDO rather than a pulse.
> > 
> > Anyway, if irq_hpd doesn't sound precise enough, what about "bool
> > extra_irq"? This would convey that this is the extra hpd-related IRQ,
> > but it would also be obvious that it's not related to the HPD pin
> > itself.
> We'd still need to define what exactly it means. I think it might be better
> to just define it as the DP IRQ HPD, as then the meaning is clear.
> 
> Also, would an enum flags parameter be better than a bool parameter?

Maybe not enum, but u32 param. Then it can become:

@extra_status: additional type-specific information provided by the sink
without changing the HPD state

void drm_connector_oob_hotplug_event(..., u32 extra_status);

/* DP short HPD pulse or corresponding AltMode flag */
#define DRM_CONNECTOR_OOB_DP_IRQ_HPD BIT(0)
/* DP long HPD pulse, debounced XXX: do we need this? */
#define DRM_CONNECTOR_OOB_DP_REPLUG BIT(1)

For HDMI we might want to define:

/* HDMI 1.4b 8.5, HPD pulse */
#define DRM_CONNECTOR_OOB_HDMI_REPLUG BIT(0)

Or might not, 100ms is long enough for all debouncers.

For HDMI we potentially have another source of OOB events, CDC-messages
from CEC controller. I have not looked in the details of the HEAC 3.

-- 
With best wishes
Dmitry
