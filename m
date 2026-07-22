Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F91C44533
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBE810ECA9;
	Wed, 22 Jul 2026 07:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SOQpXtqw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FuYDjj6a";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2346410EC9B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:41:21 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53gtJ3473671
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uLFbiiOA9hEJI7vkwFsRphph
 L8SnhgkIS0i8wm35ID4=; b=SOQpXtqwFMu5V9C3aTPrHdER1uzedC5+uDvQYAh4
 FxKZOkchklDcFHMhVpoi8FOwHXJGWIpxAwAHCPuTFU8QlGGaAyHZsjpJ+keJVK3T
 hU8FKCFRs7tGPeU4JzrSay36wf7VEfzCXZLXMCf9sWKZF/3h6wR7DWMVW/oY/Q6i
 DOQVOxVmTLvmncTVkrPao0YlX3InJJlzw0UJ3XJlas8YCCi5/E2uiWZnbPwymnnk
 xMJMKNpUviWzB2lVsWcNHI0Ygua2jbNK1B9KpDiD79jc3T1lwe6+x0QILYDmxU7Q
 JaYAc2cp7KdmQljaVy7uWqk6tbP+gVHlGtCqE4/430G9Zg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftw3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:41:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a87ef9713so85027601cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706079; x=1785310879;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uLFbiiOA9hEJI7vkwFsRphphL8SnhgkIS0i8wm35ID4=;
 b=FuYDjj6aS5a0sxZeiJ+pCtZI40X13PlBIaZz474rmcGMZRvDiZ9yl15CGXd/WmGImi
 se0Z7qcxMq/hgV/IpBtH2912OcQqHbU7ze3Em3HJftbNH497zmUctXjh2ylQLqHW/WfV
 g7WF4pOgVodgqKU7AMl9KOarv6KK56Iz7ik2cYg3YezorTe0qpuaBYlhh397LlVrfeD+
 dR5lIQSQVU08yE6i59EuJGVzOxURT/5aiU7XBKRwyhQ9XB7BcShaGCcopAUf8ade5P9i
 yQjBmThuE8XWFjswc+p8YpbRH4ocPf1kubrOewaW5yGpuAc1K1Qt/V+w0k6/t2NhqBEm
 IXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706079; x=1785310879;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uLFbiiOA9hEJI7vkwFsRphphL8SnhgkIS0i8wm35ID4=;
 b=smk8K915Gb7C6Rp+K/dY9J5jQ3ZLnw437uJvY1os91K+0k2KWJxEblC+k5ujKJSLbV
 bHJy5a6h0E2qpocvZ34Gy9tiz6Ckm8cuTsdjm68QTkrE3e7hTNtLJ1RXd3+pRhr94Btw
 hiLsk3Lf75KTpe/mpqKrHIQ7Q56XP2zUg1W0KxyxbvEalXNgctDKd4Ev05YRaDk7A4To
 M1DsvnxMQJzP7bC1tHdqjllf9fbaWpk/tjRGgq41+h4497YXjUX+5+9s4Lh8TecwfhSM
 qoAHec7i2zc6v7dZQ+32zLhnJfShQ/9dloXY2hpFxzV8PffhQKA8VX+q8+/NrRwz1Ki4
 //7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3LlmHI8N4Btz9Ru3gH16RTiqI10+mazrxq9NbqkB6eGB4SUFsuGCmsm0STKltOhEZReXu8cjLpx8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5pFTtleDBHVbuoIkGqUARN+AzI9SlU80okeL8luNlmPf6Isk/
 DyQ+gzwS76L4dq7GVuvz6cgbKd7KfrHZTzHxci5K2hKT9V7ci4D8+Fo3BWMf7xzW8ncjm2VEv7v
 KZcXhhmeObAJomF1lNNWBJmxhl2pyhulKqZjhYet8T4/xa/ob2o7OUhBXA1qjRYy+u9UPeXY=
X-Gm-Gg: AR+sD13K0MkFvSD2pEfH54E1aJUbWUy3uCM991MnFLPYLri5uIZS6x1HT89nhIfDWSL
 U+AW4yT0jbB88Ui8CsFbpjFwZABoH7W/lHow99JhXzqc+xxKyzTL1d1h4CvqNKBN0nJfplYFvlj
 uURJthFnOwgi6aZapSpzeXwXd9+ryqBAfddtoF2mbMnd/p2El7ay9NYOGHR9pk+n7knBdw9Btcr
 omuewoNJSc5TG7a+t+vF9mXxiY+aGtmrYu3anTv7+YLQC8Pi2lZJrqlWT0LwPZpQygRoRtpspVZ
 VhdXyFidZnS5L8E1ISCmpBC/iZ/mIw35fvVegdXegt8PY4rMs3B/utFmsWxmnPkpGnXdURvoWR4
 f9C/tgYViG/3T1G2pQTFlOFBH70AFzuM55KqBLpYd7LRRFi0Lq9Ktl3XBxfLMS2isI06derD8+w
 PLZEdRKpIl/uyBUQ==
X-Received: by 2002:a05:622a:1c05:b0:51c:d1c:10e2 with SMTP id
 d75a77b69052e-527a660bb36mr30505941cf.12.1784706079329; 
 Wed, 22 Jul 2026 00:41:19 -0700 (PDT)
X-Received: by 2002:a05:622a:1c05:b0:51c:d1c:10e2 with SMTP id
 d75a77b69052e-527a660bb36mr30505661cf.12.1784706078842; 
 Wed, 22 Jul 2026 00:41:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c0a9sm339473e87.17.2026.07.22.00.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:41:17 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:41:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 11/30] drm/display: bridge_connector: Wire up HDMI 2.0
 scrambler callbacks
Message-ID: <qi6aoyz262qog65qq6vj4jgnidp7bbx3x3w5f6v2ibq4a4i7xp@n3cepguql4k6>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-11-445eb54ee1ed@collabora.com>
 <20260612-attractive-dashing-mule-309598@houat>
 <b14af457-0799-43cc-80b5-7ffff5901f24@collabora.com>
 <20260619-rough-jolly-poodle-bb7aed@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-rough-jolly-poodle-bb7aed@houat>
X-Proofpoint-GUID: TMuFqFTOMw_uGoUbvFEjKXJLdTkSctbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX1LgYIt75OO+h
 gA4ca04nXMsJf4edePmonsuVwfvovPSuaDYLi4fnEO1AkLVIuAN445USgl4qgGmSZzMd28xFlOa
 vbMKoRfHLovTIyV2FiWiEyfB8RtdNHGmacsG8KiaWrohbqf6jBxrvmKDZGf/t1b+tMX3YV7hTuS
 5ZA5GqOcxJ39r9lOXajo9WurcbCY0WD3DMrftz3A+D4eoCANW/XZ7VmakqU54GTmO7mbmYZZMYm
 IJ1wwYJCDRZCmWClygiNXjvUzK2eUuN/CYxScjvcXWpq2Rg/SSB+VgxeA08b1KI9xiwybU54n6v
 i/IW7YnJit0XJ/8GcNhz887wlUXvtRO4PmkGPCmnMuo8GzbkTbSqjxpxWfoXkbCD99MMWUhgILh
 rfDzJ7KJIvnFFxg/MeMAvxT8wOlFaN2IM9ZQsAwJzkfAyasEujvN9lCjKjZXNU5RqKdgc9/USMv
 Lwea80ufAjIS7eYUP+g==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a607420 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QX4gbG5DAAAA:8
 a=hD-RnQd9uO-P1XsdC_MA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: TMuFqFTOMw_uGoUbvFEjKXJLdTkSctbU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX7K0qigRN58K1
 TUcjOGHa+0mobJm/73wtEnF3ibEbBl2xcs2PYRGHq6EtHCvuzku/yYlzVOGb4Xc7RrREI6Pklro
 68yFSknzaoXRkeoSWd3znwF1Io9dWRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
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

On Fri, Jun 19, 2026 at 03:58:43PM +0200, Maxime Ripard wrote:
> On Fri, Jun 12, 2026 at 11:42:06PM +0300, Cristian Ciocaltea wrote:
> > On 6/12/26 11:52 AM, Maxime Ripard wrote:
> > > On Tue, Jun 02, 2026 at 01:44:11AM +0300, Cristian Ciocaltea wrote:
> > >> Connect the bridge connector's .scrambler_{enable|disable} callbacks to
> > >> the underlying bridge's .hdmi_scrambler_{enable|disable} funcs when
> > >> DRM_BRIDGE_OP_HDMI_SCRAMBLER is advertised.
> > >>
> > >> This completes the bridge connector plumbing so that the SCDC
> > >> scrambling helpers can control source-side scrambling through the
> > >> bridge chain.
> > >>
> > >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > >> ---
> > >>  drivers/gpu/drm/display/drm_bridge_connector.c | 41 +++++++++++++++++++++++++-
> > >>  1 file changed, 40 insertions(+), 1 deletion(-)
> > >>
> > > 
> > > I think we're taking this backwards. The scrambler support isn't
> > > optional: either the controller supports HDMI < 2.0, and then it doesn't
> > > exist, or it supports >= 2.0 and then it's mandatory.
> > > 
> > > You're considering it optional here, when it's never actually optional
> > > (unlike YUV420 for example)
> > > 
> > > I still think we should list, somehow, the capabilities of the
> > > controller to the helpers, like max tmds rate supported, formats, etc.
> > > We've so far put everything as an argument to drmm_connector_hdmi_init
> > > but it becomes a bit overloaded, and I wonder if introducing a callback
> > > wouldn't solve this, kind of like what we have for planes and formats.
> > 
> > 
> > What about introducing something like:
> > 
> > struct drm_connector_hdmi_caps {
> >     ...
> >     unsigned int supported_formats;
> >     enum hdmi_version supported_hdmi_ver;
> > };
> > 
> > struct drm_connector_hdmi_funcs {
> >     ...
> >     int (*get_caps)(struct drm_connector *connector,
> >                     struct drm_connector_hdmi_caps *caps);
> >     ...
> > };
> > 
> > int drmm_connector_hdmi_init(struct drm_device *dev, ...)
> > {
> >     ...
> >     if (hdmi_funcs->get_caps) {
> >         struct drm_connector_hdmi_caps caps = { };
> > 
> >         ret = hdmi_funcs->get_caps(connector, &caps);
> >         if (ret)
> >             return ret;
> > 
> >         connector->hdmi.supported_formats  = caps.supported_formats;
> >         ...
> >         if (caps.supported_hdmi_ver > HDMI_2_0)
> >             connector->hdmi.frl_supported = true;
> >         else if (caps.supported_hdmi_ver == HDMI_2_0)
> >             connector->hdmi.scrambler_supported = true;
> >     }
> >     ...
> > }
> 
> That's what I initially had in mind, but it feels a bit over-the-top
> when looking at it. I think I'd really like something that drivers
> cannot forget about, screw up and/or mess with, so for example report
> HDMI 2.1 but force disable FRL support, or report HDMI 1.4 but support
> YUV420.
> 
> Adding more arguments to drm_connector_hdmi_init could work I guess, but
> it won't scale to everything we need. Expecting the callers to fill
> drm_connector_hdmi won't work either. So I somewhat think a get_caps
> like we discussed is the less bad solution, but I'm definitely open to
> suggestions.

Works for me. Then we can migrate some of the drm_connector_hdmi_init
args to the caps too.

> 
> > Not sure if max_tmds_char_rate should be listed as a capability, as we already
> > have the .tmds_char_rate_valid() callback.
> 
> I guess it would make sense to move it there and consolidate
> atomic_check / mode_valid checks, but I don't think it should be a
> prerequisite for this patch either.
> 
> Maxime



-- 
With best wishes
Dmitry
