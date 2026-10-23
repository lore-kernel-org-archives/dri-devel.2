Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F22D606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eKZn6itY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bKQnHJnp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DFC112B67;
	Fri, 23 Oct 2026 13:59:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3350C112B6B
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:58:27 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAB0cm1444125
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=j7Lokafbtj5YFNefAbCjS5Pj
 lLoXzpnAAjQItwYXw84=; b=eKZn6itYuZIK1NC+9xHZfchb8KTvAyZ4XOZFYKW3
 0+eTAk+I5XmKxB2IVs6XMk3Q4p/ByPrf1ZTnpvQHFTOeI1KGya6D0PwH2ZIYkgrC
 7/7GGI4RqWTsbZhM5FFlTpPlspHcsdoo0xAMW3mvg4cF340wjMk+EcguNR7RBcnB
 Zo5LqK4fOujLdPenSVOkz7Oj7zyEgjkhOSYGBWpROdPrzaVvRMXhrDPDG6O1uF0e
 bCJhqZmO7E20D9jboC3u2wZEW8oVDDYtHRQAW0FVHWH1+eE70DXGzC1uBMkSDGj9
 vH7u0yaK7343vdgcpUEcNsip5r2jE9+ZdhE4dhen2LK7YQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbm0r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:58:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso146191885a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792763905; x=1793368705;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j7Lokafbtj5YFNefAbCjS5PjlLoXzpnAAjQItwYXw84=;
 b=bKQnHJnp58FEzb8InMU0LhnZaV4AZYGosKCNUTk0JoGGCeuTSRZMC9WoJQa4tBPM4s
 X2er9jiQJfsXLv0l5FKd/kW9QY8MSgBPNym2IcFZ+EZLDhdUtrCCnP3SpyXzvVbi9u+g
 0VW77bL2Q+xFMNFWiRjWuJeTHqNn4teGrMEXO9RZRwWmjzNVn7K2TufxYj0pKa+1NNvR
 m6z54mftlT+vRAkr8vYweBDrf4v7qUOknFq2m/07XLX3rULz9nmxOGR2cs7KH9aEpo7o
 95fMvK0E8SA9fepoZxO/3abcN/0RF/Fs1pIVPjDk6pkwid0LrjSWQvrgMooMX7G6N7nG
 Y9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763905; x=1793368705;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j7Lokafbtj5YFNefAbCjS5PjlLoXzpnAAjQItwYXw84=;
 b=ZT/jP8RboKKj6Iu9hfz8rX5DxhF7Q+VvauPdtaFRmVVg+GMDGk/llCtWTOLIQ2n+7Q
 99Mng/nWwUqjcIsmlkzQuUP187Iiaa4uo0NTPu6PivTj6iR0bsAUcq8Isc7ifRUJSHBt
 dbyr6lF5mqGaWZ0kujtbc5/Y6e9IFWGqc/zUXz7Z9nM94REvR1gDVLAgSIvxIblYYYBk
 5V+jnXFG208l17EnRc6qOX3Wh1TWqxeRmQiOkZLSaz387hl8i7+AhhFR/VBDxjI014Ca
 j60zuFqFO7hoQMApmRvH8wyQsiY7t82oujzcbUFNZkDAeMoXVSnvyC0khVSs9jG408oF
 CYZA==
X-Gm-Message-State: AFq9FYJf+/K9klZ/+UMEARwSchE0eb/Z0GAZWCTRuTBWJJYmw3nd/g66
 rsoZD8UFZoZbT2c5HjtM6U868gFm0lawME9glFKs5Lh3s+FCHSQIHRXwb3OgbPdcLNWKZp6tBP7
 yxoxBeFlXuxbE+EGMWRZhTbfEDBtnjx2cBoU2h9iH0Gp2JqNKtXOGTpGgv2Xc82o57zwLHXg=
X-Gm-Gg: AYBFou3cQBK84xJXZbSPVv/n4I1QNgAH4tLTk7SDfQVFvAXMv98SkELiUkAv7HP543I
 fBvAK//2nX7eFoTX/9iZ/KBVpgBLknH7Oo5YrN14UR1MJm5s0WkTyF9ZT4qKQVLjrB58FxnxcPQ
 YgF8eJjqMqklE0xhNjI8001s+K8VMmniAeJvztYDmLxGUYGGqAMU75zXteFmJb0qFYkWBw/oKtV
 ZrRbin8HaZqoNpSdyZqSdNekNkcE/QD+C8WhP44VPSqLUHhKYX8CO/itR4wjWO7pmdLS4bOpKtP
 /2WYxUZ7j+4D0yDjZdUvTZge3/jUk1hRg6l1FnLJrdsJhNgUc2/+a/l3uFAwk5SZByZhf1hJDx6
 noclBEICItj29vYgtatoDGV4uOnexzEPpdcnfgkPmceGoIyxFAi6PsoZWwj5Ejbg3PEMoHTzQEC
 YkMXeKQyQoFXfR
X-Received: by 2002:a05:620a:400b:b0:93f:57a3:71ab with SMTP id
 af79cd13be357-93f6f94e2a4mr398214185a.32.1792763905197; 
 Fri, 23 Oct 2026 06:58:25 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:93f:57a3:71ab with SMTP id
 af79cd13be357-93f6f94e2a4mr398207285a.32.1792763904719; 
 Fri, 23 Oct 2026 06:58:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb02a2033sm389578e87.77.2026.10.23.06.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:58:23 -0700 (PDT)
Date: Fri, 23 Oct 2026 16:58:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Francesco Dolcini <francesco@dolcini.it>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v7 4/9] drm/bridge: pass extra events to the HPD callback
Message-ID: <g5jbcwga22grufhguvkmq7scyd7ur6kxqeii24bedzli7nihfi@4hg5tcvlftnv>
References: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
 <20261023-hpd-irq-events-v7-4-57a3aea3f09e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-hpd-irq-events-v7-4-57a3aea3f09e@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NCBTYWx0ZWRfX8U6Ygr31kD4b
 jvznDkJIkdwpNLbURnCtfxiAWXS1fwSPtK3oqM20Qyr1Jw+vqF3aecW3+3z2OftrJCnVM9OyNh/
 EWce+Gz0+LViQOD0x8rye9SrszN7xbo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NCBTYWx0ZWRfX6P+pMy0mOBay
 MsRFm7tM4ErLU92kuMMrvQ0OwDQqaSC+u/AOYYNPHVZJ1JxW4WnQrqIHpAw/gPPZyrYR5uOz5bU
 mn2vogfSgeIA5tOyKd+Oct/ojNEW4iLttW+3DpbKEgoTM6be5S27BJrghLusiDvk19q9ZwpPH7j
 +QZ7gMpZUB8Z7VgqVBEemLpNLn93ysRrjkYOv1gtizQxe79wJkfWxuUb5d77YB2DihU4FYc3qED
 ak+5bjO3g//qcHW8KTZekjLUqU+3IyWS8A+XPo1r6GcFZiE7FsBO/d69DXgg6iSPa3B9TbwowdW
 EIGxVqbtjZQ6Njyh/rBOeQSNCQB81dWdgWWMfv+XppiSEGnpMZXymSbjAjBhB6JP+pni2DaVqci
 vrsbet89tv2a00Sj6rfANdmj15plLgkJLT1EP3lOYThfz+9UbwcUhVU/OM7t2k3VctpWnG1d4SR
 DWe+lvQ4K5b/pO+wxww==
X-Proofpoint-ORIG-GUID: KjlHWta14eoCvZhrelRnhPriB711S00R
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb6801 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=m8ToADvmAAAA:8
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=FczUWju-UfBOor4io5QA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-GUID: KjlHWta14eoCvZhrelRnhPriB711S00R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230054
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 04:39:44PM +0300, Dmitry Baryshkov wrote:
> The DisplayPort standard defines a special kind of HPD events called
> IRQ_HPD. These events are used to notify DP Source about the events on
> the Sink side.
> 
> Bridge drivers report these events through the
> drm_bridge_hpd_notify_extra(). Pass down the extra status to the HPD
> callback, specified during the drm_bridge_hpd_enable(), letting
> underlying drivers (e.g. drm_bridge_connector) to receive these events.
> 
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # lt8912b
> Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/chrontel-ch7033.c       |  3 ++-
>  drivers/gpu/drm/bridge/lontium-lt8912b.c       |  3 ++-
>  drivers/gpu/drm/bridge/ti-tfp410.c             |  3 ++-
>  drivers/gpu/drm/display/drm_bridge_connector.c |  5 +++--
>  drivers/gpu/drm/drm_bridge.c                   | 20 ++++++++++--------
>  drivers/gpu/drm/omapdrm/dss/hdmi5.c            |  3 ++-
>  include/drm/drm_bridge.h                       | 28 ++++++++++++++++++++++----
>  7 files changed, 47 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> index c542ba6ce7d3..a21f9355594c 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> @@ -427,7 +427,8 @@ static void hdmi5_bridge_disable(struct drm_bridge *bridge,
>  
>  static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
>  				    struct drm_connector *connector,
> -				    enum drm_connector_status status)
> +				    enum drm_connector_status status,
> +				    enum drm_connector_dp_event event)
>  {
>  	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
>  

This chunk needs to go into the previous patch. I will update it
tomorrow.

-- 
With best wishes
Dmitry
