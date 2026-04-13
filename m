Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBF4F34C79
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC1010E4E9;
	Mon, 13 Apr 2026 17:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dw/nxBMd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBUc/qkh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B9A10E0DB
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 17:56:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDwZoE3568224
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 17:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZOK8xz+kAAT0sGnFLw4aNDwg
 w8+J3RcJlXQkxpqjpmM=; b=Dw/nxBMdq4uF/bpfRCFEEszlAGlfPaHv4z+nVmQj
 dUjFoQO4+KLUN18wfNGZpltZOoG6HkvF1YxLwe3lJPQJVno4vCXlSIBoM59HF/fQ
 44J7Pb4VYomEr3wcHHs9jEFQbpkxHbKhO4YgLQ9zYIscZ3/peMKUa70joNENP+gD
 HdAlZRL6LX6Xb02hIEQKDYQ1PZMp07eGZ5EQEXZGMTt3q3v3R8XnjZQLF/ZGCubW
 fVsH4kC/iOlShXfkHrS5a+uJj6uB7so8J7DPsTqK3wFsJ26kptiFkqnkrn6337Ju
 VUrueMdMLmIM7ESyw26imU04XaK7jw9QavztEH+mFZwa1g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh1uf0x1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 17:56:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d68dbb77bso49292141cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776102989; x=1776707789;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOK8xz+kAAT0sGnFLw4aNDwgw8+J3RcJlXQkxpqjpmM=;
 b=eBUc/qkhKn6iAsvtoNWx2CjinXXmqa8oc2jmTBJlvrF0k9n0Z2EMYiykO11p3u2YeV
 7dxnxESiQ8Y/5UpZXTyFmCEG8WNXo4bPCC4F3CLJzYiYnlwgi02jWYHSz9JQciRkXOw8
 4z6tUFIxeHdqwv6X1NaibmGuU63KYEVS2kzZcsMi1jagITYW6js64VOM8Q5gzg8TiUeL
 95HuneDJVbN4DX32QL2JFUFnJ1abT1Vu7ooXvkk/mdLbiVh0Pl1Hy8NcYuf2hVRqR4uA
 Gt7ZDKLCaNpn9hk1bwiR4/QqiKOf1kDHoJtG2Vh9/YjU0Tlt8oMG9qaynwsLJOsLzCke
 4I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776102989; x=1776707789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOK8xz+kAAT0sGnFLw4aNDwgw8+J3RcJlXQkxpqjpmM=;
 b=KrtlvR6bCg0rPDQDjRwlPL+PfWKDa6WjQCiVt4T7auPwne6Awrr38sMoIGG0jL7wQs
 nejG8GIERubjvThwuCYeKYmD1GPPHvcP405wJetTBsE6+Zcp9SyyLCg7oZ8hvSajtWaS
 FflyjTjbK8/0un1KgoK94Er8UI7QO1FD6GWyWmlPJ/TjCtTXTB1LKDzh0SOM5ts6kSSg
 E8/qncxA1upYavvqIT51VvLFvmcWIt6kzgMhPrRJYgUfC83HIhqN8cKa8aGMG91L21jO
 ckvspgoz85a/Him6Z8qlU4E3OPOOb95Bc/rGWuLCiKXDGbJibhTeeVnSzrhflFOHairc
 11BA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NUdrkt2lfOmg/efIa+y4tKv8v2dIt8xT6LvIqL9+pKpH38Fw8jkqISq8hbAZzUsN8raalaSC+pbg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRZ3c+r3xMYwYMq6AhtqNf/8fFYsqrYNK+dF1wc9T2R2+IHWbE
 S/cTf8593B464ej0SBqH9pFd+k3NINQGBiuarXqytI5lRsjlhpcwjDh9yPUVx5cAofW/N4JCUWv
 DRALvpS8/bg1pcZKdfglHqxgKnsNoq2rAyvaNo57+N5Q9azv27LVR6YJZPIE5ZmtXQAAEVV4=
X-Gm-Gg: AeBDieuO8XOamF2z7LPQ5M2vtaV8kR65MANkYKLHeqXVP+vDI7QVbWUQWSwC+X/2b5N
 Hy1BJgHBdu5Fw/3l+HBkKxREpe2To87csessaZs1JUEkFXzyTJHs0QW2zpvwCK4+dAai7oWcrgt
 da0iC21HEFT2czie2ekGDdfth3phRP9j9vLrUh+vNFxRishN68g3IVOyPUJNWo/vPhrtTPWRa5v
 8oTqT3whf6oOPI8paeDfAqnQpsgRKspPQHjC7f09mx/XnTSSEphdZOc6v6yhLIYOcbfhcYEGcUG
 od4kOELzPRpJp4xMRE9yMLKxghGzVujK2wxOTdTyHVHgjyI7OhuwS9kglOtimYJEdnVDiuIwvVr
 LgqVQ965gookg+HkjfAcxi4nBOP2hynIwxzBdXWvlesuoKapqhE1r0paCqGqg6D7aMpE0xUAQhS
 yD30oqGsSjfsEULLObJP0uVEGyRfeiunPzEB8m2gjtSiv1ZA==
X-Received: by 2002:ac8:590a:0:b0:50d:9073:f8e with SMTP id
 d75a77b69052e-50dd5b3f2f9mr228447371cf.26.1776102989387; 
 Mon, 13 Apr 2026 10:56:29 -0700 (PDT)
X-Received: by 2002:ac8:590a:0:b0:50d:9073:f8e with SMTP id
 d75a77b69052e-50dd5b3f2f9mr228446291cf.26.1776102988486; 
 Mon, 13 Apr 2026 10:56:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3fe7db18bsm670757e87.47.2026.04.13.10.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:56:27 -0700 (PDT)
Date: Mon, 13 Apr 2026 20:56:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/10] drm/bridge: add of_drm_get_bridge_by_endpoint()
Message-ID: <omlnswxukeqgnatzdvooaashgkfcacjevkvbkm6xt33itgua2k@jcmzll2w6kdq>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-1-acd01cd79a1f@bootlin.com>
 <u2awvqh2uoc2acuuvyavwwtuvtiaidhbkkj5a2d2wwph2s7j7g@b4j73kwzblgk>
 <DHS6WZRYGWZQ.1X6ABU4UWF730@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHS6WZRYGWZQ.1X6ABU4UWF730@bootlin.com>
X-Authority-Analysis: v=2.4 cv=Dc4nbPtW c=1 sm=1 tr=0 ts=69dd2e4e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=Ch5lwy9Ifhz3koOEWzcA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 3gHj7woGusg70MfKjarB3JZdB93Q2CdA
X-Proofpoint-GUID: 3gHj7woGusg70MfKjarB3JZdB93Q2CdA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE3NiBTYWx0ZWRfX0w4iXe0llHPv
 tQbRWBk4tPnoDPa+KSiXnTC9Jxbd/qextJbaF6KPMVZSsApGvkHL+eHg00lEkek6P0KkXaQcXPm
 4GN/lxdJAgc1iXSdxE/ZF1DwmKs/UsopVifsCpifrr1A+ONmhLvU00D7YDjlrcDd9Ob1fSBRIyw
 ogXgwsVysA9fuJ220cXvO3BPXRS2qBSZrAyR8S0qREtgQI2WkCDnDQ7n9CJ4uT0IFTclJP551a/
 eENd1EUx5rmcT3tMZMgD2OAxjzTEoIHvMhR07TQZsw12iaGqTwh0ZsATEApChqreU5IlD19nOo7
 tD8dIt2ZQXdU28CUsAKuambn6zWJndELjdzEjIPKuycLgUUD/6OJj+O9b5K2W7TpsfGM7swPS36
 7Vb7NoXg0MkM7AawKQpQgwPxRNEATL0p2JV+CvRkSOmaCD1CIiEJeMYiMqxGiyh5Jpl85pENEDf
 SvZJCfqMRgKXDw1pKAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130176
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

On Mon, Apr 13, 2026 at 07:07:14PM +0200, Luca Ceresoli wrote:
> Hi Dmitry, Maxime,
> 
> thanks Dmitry for the quick feedback!
> 
> On Mon Apr 13, 2026 at 4:58 PM CEST, Dmitry Baryshkov wrote:
> 
> >> --- a/drivers/gpu/drm/drm_bridge.c
> >> +++ b/drivers/gpu/drm/drm_bridge.c
> >> @@ -1581,6 +1581,52 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
> >>  	return bridge;
> >>  }
> >>  EXPORT_SYMBOL(of_drm_find_bridge);
> >> +
> >> +/**
> >> + * of_drm_get_bridge_by_endpoint - return DRM bridge connected to a port/endpoint
> >> + * @np: device tree node containing output ports
> >> + * @port: port in the device tree node, or -1 for the first port found
> >> + * @endpoint: endpoint in the device tree node, or -1 for the first endpoint found
> >> + * @bridge: pointer to hold returned drm_bridge, must not be NULL
> >> + *
> >> + * Given a DT node's port and endpoint number, find the connected node and
> >> + * return the associated drm_bridge device.
> >> + *
> >> + * The refcount of the returned bridge is incremented. Use drm_bridge_put()
> >> + * when done with it.
> >> + *
> >> + * Returns zero (and sets *bridge to a valid bridge pointer) if successful,
> >> + * or one of the standard error codes (and the value in *bridge is
> >> + * unspecified) if it fails.
> >
> > Can we return drm_bridge or error cookie instead?
> 
> (while replying I realized there is a design flaw in my implementation, but
> see below)
> 
> I initially thought I'd do it, but I don't like returning an error cookie
> for functions getting a bridge pointer. The main reason is that with bridge
> refcounting the __free() cleanup actions are handy in a lot of places, so we
> are introdugin a lot of code like:
> 
>   struct drm_bridge *foo __free(drm_bridge_put) = some_func(...);
> 
> Where some_func can be one of of_drm_find_bridge(),
> drm_bridge_get_next_bridge(), drm_bridge_chain_get_{first,last}_bridge()
> etc.

This is fine even with the functions returning a cookie: the free
function can explicitly check and return early if IS_ERR() pointer is
passed to it.

> 
> Such code is very handy exactly because these functions return either a
> valid pointer or NULL, and thus the cleanup actions always does the right
> thing. If an error cookie were returned, the caller would have to be very
> careful in inhibiting the cleanup action by clearing the pointer before
> returning. This originate for example this discussion: [0]
> 
> [0] https://lore.kernel.org/lkml/4cd29943-a8d0-4706-b0c5-01d6b33863e4@bootlin.com/
> 
> So I think never having a negative error value in the bridge pointer is
> useful to prevent bugs slipping in drivers. For this we should take one of
> these two opposite approaches:
> 
>  1. don't return a bridge pointer which can be an ERR_PTR; return an int
>     with the error code and take a **drm_bridge and:
>       - on success, set the valid pointer in *bridge
>       - on failure, set *bridge = NULL (*)
>  2. like the above-mentioned functions (of_drm_find_bridge(),
>     drm_bridge_get_next_bridge() etc) return a drm_bridge pointer which is
>     either a valid pointer or NULL

3. Return pointer or cookie, ignore cookie in the release function.

> 
> (*) I didn't do it in this patch, that's a design flaw, I'll fix in case
>     approach 1 is taken
> 
> Clearly option 2 is the simplest to use, but it loses information about
> which error happened.
> 
> What do you think about these options?
> 
> >> + */
> >> +int of_drm_get_bridge_by_endpoint(const struct device_node *np,
> >> +				  int port, int endpoint,
> >> +				  struct drm_bridge **bridge)
> >
> > Nit: can it be drm_of_get_bridge_by_endpoint?
> 
> Argh, this convention is changing periodically it seems! :-)
> 
> I previous discussions I was asked to do either drm_of_ [1] of of_drm_ [2],
> but since the latter was the last one requested I sticked on it.
> 
> @Maxime, Dmitry, I'm OK with either, just let me know if I need to change.

I missed Maxime's response, sorry. I'm fine with the suggested
convention of using the first argument.

> 
> [1] https://lore.kernel.org/dri-devel/20250319-stylish-lime-mongoose-0a18ad@houat/
>     -> search "called drm_of_find_bridge"
> [2] https://lore.kernel.org/all/DEH1VJUEJ8HQ.MIS45UOLCPXL@bootlin.com/
>     -> search "What about"
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
With best wishes
Dmitry
