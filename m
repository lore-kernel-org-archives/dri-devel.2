Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE9ACA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0CB410E26A;
	Wed, 30 Sep 2026 16:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpmokK9M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kXIditLO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2B110E26D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:11:52 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxrwu3930115
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CE5fzGfnss3B8b8Hj0+v+nIZ
 el8CUQA7gROgRFIbLNA=; b=jpmokK9M6UYnEBW+0hyeywfzDVRkd1A9uF73yj87
 QBytSWW/5Hd3L9R8ZoNKImoC7umHy6JYiRdOk0hDfQ0+BD4KpuYQ7CH0O04yFhpS
 UqvQHnEFpqwct+GJxZy7YiEow+cOS+IMu9jzlCDUad0lCNXazMNbknFIQo0WfpuG
 8FHe0yXOpM+aDdNl2iYDIQkGU4f6HfyTPvh+AZSH/qnnLiPlFVBbl3G3XIweZB20
 eSr+7SbRWP4mFvKWWcpJjL6WauKZ6KBYNP6p6WviS59ZB1IRvdpkaWB2EriL285p
 WwQdF/bSDXBVRdn7do9O8aH8rjVNnRdlDXGQscONvIdF/A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w142j25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:11:51 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7bf1e774404so102376137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790784711; x=1791389511;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CE5fzGfnss3B8b8Hj0+v+nIZel8CUQA7gROgRFIbLNA=;
 b=kXIditLOGoA2gUWh6+E8XVJEkpaxVeQ/K80NhY8Qw+t6K/tZ0TX/V5l4kL+oz+lLf1
 wvzNSzyT00gqmhzTcORtYofrTnivc7nyH/CxdfWLc/JRCgzzzszKAt44/dA0A+/aOj8L
 0p9abUhkI6XXhj9mKQ48RbkubfzG84VKFeh5eptaW8gsHImYlMyqMUW7B7P9udlcopwi
 X/UXadcec1ZWhhrLprHh9i+/JHebPz4o3dzS2WYcRMtJlS3ehL2kD/ebbRvw3lZgqG92
 dSUiMwCvVJuBqXCQ8gnGVJJLhx1q6Pu+370MJ0Yr4sKyvpg/zPdDqG9ZKapS0uPiy297
 eZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784711; x=1791389511;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CE5fzGfnss3B8b8Hj0+v+nIZel8CUQA7gROgRFIbLNA=;
 b=DnwgiDp8SzeFJEX00LMw1W39Sy8VyigDZJA87enP5ATorsVmIEBL0X2/AGFiJviK+N
 9Zy3yDjPayOFTdB8KW2dv0fMaM9BTPJ5lPcEO7cWBNgw0Vy6qAGi+quO3B4VJC6dm+Kr
 Zw49tWMOSpq5dGlXi1XKsyAMs0zVCh+J7k8wD243v44iIEZJKO+cb1w1vrHQ4RPK8Htk
 +muzB2cvEwe5i3C9WC3bXOqU/KHo9CZzdsphr68SdaiYZyl5xlQ0dsLHIj7CVZdcLA3K
 61mnQD1UenYXJlGiJDmhUlS19RroD3TtenQbQiObwRNyzZpENAKs32HMTxJ3gZ9yMGIK
 opzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYqhljkJaJvO+URwivJ7B6M+EuZWzyb4xaGb/Vqi5rqCnUTxyh9I84gqwAC7i8WvctUEsS5UUAwJ4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYInlkmDN9A4PYOtTY1y9YRdOGQUhzrQL4WCQGy09yqEzRdI878G
 HKL7r4dSZ56RB2opRmm2UEuFDJGIfQMR22InM2Je4ezT/6JsTHaNICnBfCIIXBC66Gdi49WLoVa
 Jz0W31IZWXfJem76Z9LWFoPtQPEffSfhJU+fhZXfLm0GnLUUBUeAYVfm3XBWH7AbiOBxzwPQ=
X-Gm-Gg: AYBFou13zco7IvC7ftjaUR80EsTskvx/PWc053KKWRsUphvj/2WJ5uA0l/8UoHgAW7q
 Tyu4cxO4NlQR61tt+4mG3BI6WEj+5aEXiB5NHn49iTEbscVTgt1PxObkMnQjDDNzkGjdIjPWkCC
 OF48S2L4pEAYjtyfOFdtqk0qq1/lYEyANXrA7olvk0sNPfKcvCG68YiuXxqirh1k/7NZFvIPqKM
 DrewCx/1MZJY9at9mQZaFzbT0rzbUhmn3LYM0HobfD+ePNDnCYQl6V2Ol9zoJRtePSM2Wy38SRF
 JW5qlNwPHrULMKmr9Jhq/0SlIHam89Q7mT6+Pdb/KG8DM10+r9bnRcg3UtFDwqIZU5SIL1fBGZd
 Sf/bNWBOed8+ua3omiIvI/EXqeRtWJHiLuDrsEQEBUJLXKcDy3RTNj3YfDvX/g0jjZGj0409bRm
 lhGVme3idJcqXF
X-Received: by 2002:a05:6102:50a9:b0:7a5:7282:1994 with SMTP id
 ada2fe7eead31-7be72ca9a6bmr436065137.7.1790784710651; 
 Wed, 30 Sep 2026 09:11:50 -0700 (PDT)
X-Received: by 2002:a05:6102:50a9:b0:7a5:7282:1994 with SMTP id
 ada2fe7eead31-7be72ca9a6bmr436052137.7.1790784710056; 
 Wed, 30 Sep 2026 09:11:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fc4e9asm84041e87.79.2026.09.30.09.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:11:48 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:11:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 06/13] drm/msm/dp: Report stream enable failures through
 link status
Message-ID: <mhmfvshq3dy6pwyvtuplakqqiu3ybg44xd4aazuhex7fl7b4uk@33fky22t27r5>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-6-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-6-dbbf8b2b42bc@radxa.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX/XMYD2Iw1dgT
 oublDGn4AgSNcxxifpXBs1FWt+zHFKSMvCGM7UbvhXH/JsTr4XL2XcnO0CKAFmkWc9zonO0xLC/
 x2wcWgxN4+TBA9zsMiW+mrTq9kOpONc=
X-Proofpoint-GUID: WTXRUuUS_HedjxpAygZOmvmtSzu7H-oa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX0qz+9CbW8rJb
 VQlh0EDdFJzw/HfF9DDvWIUC27aHeJRwIGtJuvTer5n2SAHMCpaiRoM9fd6setZvbtU/FsD2ajc
 C1RUhC67DxH3aapJLOQEU9fk10fH4k3V5lNb6GoCzAROgAdOK4ERgZBWW2CVYu5HuNzHVcQtz/g
 DKIOo2GHNhuoyHWsPUx47bRqaPgVgYUwqvQVdFixN/y6+ktXYPl95nsq9Gj8PZ8J68kSDs1nLBB
 I1aOWIicSFjyhkfEL38fLN8227lq++2PdQaPZgy77MiE8xJ8VQbFXkel2GiBiNjT68okl+95REr
 3w8NFwFdyHMqXgAg3KifVTI4Lfl9b13b4QxM74WM28wui7Z45HRgj/lDc/hc2YzNR1bQrAcjSw1
 lmWPjFOCgk6w8/jcgg9hmCJseIp6nHTZj1mqjkmLwj9n7pS2Zp4/gCcGf1LJIk4Hsgub894N/Sk
 GGpsGNa89AwKXmvPWqw==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abd34c7 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=ksxQWNrZAAAA:8
 a=7z2oCe98pf8tU8XqQ0sA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: WTXRUuUS_HedjxpAygZOmvmtSzu7H-oa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300064
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

On Wed, Sep 30, 2026 at 08:41:50PM +0800, Xilin Wu wrote:
> Atomic bridge enable callbacks cannot return an error to userspace.
> After a failed enable, leaving link-status unchanged gives userspace
> no indication that it needs to retry the configuration.
> 
> Mark the connector link status bad from a work item after unwinding
> the failed enable. Send one connector hotplug notification per failure
> episode: fbdev can synchronously retry the modeset from the
> notification, so notifying on every failure would create an unbounded
> retry loop. Subsequent failures still restore BAD after a retry has
> set the property to GOOD.
> 
> Allow notifications again after a successful enable or an external
> sink connection change. Do not reset the notification latch during
> eDP's internal plug and unplug handling, which runs on every retry.
> Ignore queued work superseded by recovery or an external unplug.
> Serialize the failure state with plugged_lock and update link-status
> under the connection mutex before notifying clients with both locks
> released.
> 
> Initialize the work at probe and cancel it before unbinding the
> display.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 63 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index ae967ca652c9..1bfa6696d904 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -12,9 +12,12 @@
>  #include <linux/phy/phy.h>
>  #include <linux/delay.h>
>  #include <linux/string_choices.h>
> +#include <linux/workqueue.h>
>  #include <drm/display/drm_dp_aux_bus.h>
>  #include <drm/display/drm_hdmi_audio_helper.h>
>  #include <drm/drm_edid.h>
> +#include <drm/drm_modeset_lock.h>
> +#include <drm/drm_probe_helper.h>
>  
>  #include "msm_drv.h"
>  #include "msm_kms.h"
> @@ -54,9 +57,13 @@ struct msm_dp_display_private {
>  	bool audio_supported;
>  	bool stream_pm_active;
>  	bool stream_link_attempted;
> +	struct work_struct link_status_work;
>  
>  	struct mutex plugged_lock;
>  	bool plugged;
> +	/* Protected by plugged_lock, including accesses from link_status_work. */
> +	bool link_failed;
> +	bool link_status_notified;

Do we need it? I think, it's easier to send several notifications.

>  
>  	struct drm_device *drm_dev;
>  
> @@ -204,6 +211,39 @@ void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display)
>  	complete_all(&dp->audio_comp);
>  }
>  
> +static void msm_dp_display_reset_link_status(struct msm_dp_display_private *dp)
> +{
> +	lockdep_assert_held(&dp->plugged_lock);
> +
> +	dp->link_failed = false;
> +	dp->link_status_notified = false;
> +}
> +
> +static void msm_dp_display_link_status_work(struct work_struct *work)
> +{
> +	struct msm_dp_display_private *dp = container_of(work,
> +			struct msm_dp_display_private, link_status_work);
> +	struct drm_connector *connector = dp->msm_dp_display.connector;
> +	struct drm_device *dev = connector->dev;
> +	bool notify = false;
> +
> +	/* Match atomic check's connection_mutex -> plugged_lock ordering. */
> +	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> +	scoped_guard(mutex, &dp->plugged_lock) {

Please use drm_connector_set_link_status_property() here. See
intel_connector_modeset_retry_work_fn(). I think, there is a TODO in the
driver code, you can drop it too with this patch.

> +		/* A successful enable or unplug may have superseded this work. */
> +		if (dp->link_failed) {
> +			connector->state->link_status = DRM_MODE_LINK_STATUS_BAD;
> +			notify = !dp->link_status_notified;
> +			dp->link_status_notified = true;
> +		}
> +	}
> +	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +
> +	/* fbdev can retry the modeset synchronously from this notification. */
> +	if (notify)
> +		drm_kms_helper_connector_hotplug_event(connector);
> +}
> +
>  static int msm_dp_display_bind(struct device *dev, struct device *master,
>  			   void *data)
>  {

-- 
With best wishes
Dmitry
