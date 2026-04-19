Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6465F99C95
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 01:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD2B10E501;
	Sun, 19 Apr 2026 01:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMO5wgmt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H8+IGV6E";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD64C10E4FB
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 01:02:35 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63INwhoE164766
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 01:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qcjvIqFA5r1kXWwIbtP8maV0
 OLFDpV7gifSNmH3UW+w=; b=GMO5wgmtHQKucT0E88J7lWTS+2h0hlPyoKyruHWJ
 BQM8i/RhAKjehbRttdqLRIt7w/vgUHEJZD+wy1hYYfMGAuPeFRHXqdV6ROpncG3y
 zeD0574r7OLRrToVslHAmm7LJjfbYggjA78BPuiusPYOzOjLuphH0W1nn+jeoGVm
 luk/saEL6jPnrv30yvFH0N71mB6wDzhmXXzoZR1JRFTGP1NW7TM88BnLSdDWNSw5
 HF7u6Lc50AswYzoj/jZ822hESsOobFi5L6lBc6g0FKxX1N9L0XlRap0BSJGJbnO0
 Rp9WcQ3yaWJ/VRafz6z7J2Nr0dzfib0om72QYonsacY7xg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0y61uga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 01:02:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d58bed44aso7636111cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776560554; x=1777165354;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qcjvIqFA5r1kXWwIbtP8maV0OLFDpV7gifSNmH3UW+w=;
 b=H8+IGV6Eg02iLB8bJGHo99J9WzDx+I+Ts7dlK6U6nEXj/9ogILMSW6LL4Fk4Tir7D+
 MswJHwS28inIfd9iBiVZHTB2hB+tM9qVE8avAAqHbE89JOyCNYprnvE6k6rOEp5hRrLw
 IS7zFAVuO7SwLZEbhppDLOxut+XZ3CS8XQMuRMBd0r2fmLyb3pcyb0fq37oc96VB4bkL
 mHJMKmbJX7/FNCS7nIFy13tQGQrMp44R1JcrknB2kWSpjkrg9ZCT1kI4WRAvozjJI7mo
 SvAyUAHNovQnsqI4ziSZricwK+1+ob4DnuSk4CxftAz4Tj5gXYX5xmsY3+B+GWtWAjOP
 sVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776560554; x=1777165354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcjvIqFA5r1kXWwIbtP8maV0OLFDpV7gifSNmH3UW+w=;
 b=eGJHuTGElzL89fzIqX/8070OfWZgYRKMHQ4LKwxHKyrc/cQNbIO1+mFCN3AsPgHZ8g
 PnwZjj3BOpLcq63BUAL/c0OK6htbDih5VFgkzdy6gellzlvYBglE7zaFtKQXiIeAHPHt
 9wBo60068R5OmDhcVa74uL26vmc4MWM8lHk3uU+cWFhAp6B9hdeWUAIlIeNYuQRmZsLQ
 gMyHtUh5fYjWDmUTKlDqIPHKiLyKZNV7UFbYh8CY1cuXHayeqgbCF2Bv2emp5LOOnMGb
 Xfj754sUsNkDc78sEOs3ZIy5jhsHoUE42driHVnwGKq8jXHKUUtN23Zy/bx0sKH/qsG3
 3/3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KS65fh9DSK0OQfS45bbEUIcgJ5f5yBgagOVvr0tnwWI9NYXS2FDUj5w8xTvqGt8Ef6TzLbSFqjnA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGk/an5IPbsXu7wUlayIEr4j6kKb2cC6shmjB4lLCD4a/+TDmF
 w3H6q0c/ZCwHCAqiiawVwHOa+VB5HuDX4yUlpCoFLAcb5DtegsO+3Q7ehZRlG2mivSiZzufJjbf
 AGczqzgZS62WNrhSTqB24cT8o0KFfy48t42J1i4YAamM1o1UWR9hPYbDq0e3IUNYgjYyKFwo=
X-Gm-Gg: AeBDieuLCqG7LXpUTwIOsGAjdIhfKI5/7HZEzhcZXnXrAjGra7jNNlfc+gH66N99LAu
 T8Ul1CXr0e7pxlvDWggXbXGbkXUIc+ZRUDGSHDXsRj8PyrXFHApTNZFcpP3L/LhFRpLWfxx9Rh1
 7odA+lv72Xcij3d2t7/mX1C+6v5DiKNwh/8GRvXiBpEd8PIr3h99RbA8ru0MMpNuooxJciOvs71
 TBo+fay+azRBuMIaymc95Z3zTx7MGvTuF9pns5l88AdmEUqVKXAAOsaP8ybYD/PerADhPNVLrst
 W55klLi+cN2f8eNXve5GO7OkmMMH87y+MABupW9Y4qdpHZZnN6E5lNnkQKZpC+oQIKjFnOjkxmw
 D6PidBiGUfl8H3zV0rjXp7NmXEBmWHQc2oC6rDI/31c60kCZJq1EnDdQYkCt/Gjwrgp+8IYs6b+
 61DGTyWVGqtkH8zyBWAff//fVzAW/pnXqmbhajdjdrTv9wUg==
X-Received: by 2002:a05:622a:148e:b0:50b:409d:48b7 with SMTP id
 d75a77b69052e-50e36c592b6mr119802841cf.44.1776560553853; 
 Sat, 18 Apr 2026 18:02:33 -0700 (PDT)
X-Received: by 2002:a05:622a:148e:b0:50b:409d:48b7 with SMTP id
 d75a77b69052e-50e36c592b6mr119802361cf.44.1776560553308; 
 Sat, 18 Apr 2026 18:02:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc64bsm1819434e87.31.2026.04.18.18.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 18:02:32 -0700 (PDT)
Date: Sun, 19 Apr 2026 04:02:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 wayland-devel@lists.freedesktop.org,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH RESEND v7 2/2] drm: Send per-connector hotplug events
Message-ID: <lmrord5zegfnpuemhbrbyxxhjisetghs4aryt6mf7yd7ej72kw@znaubwsdz657>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <20260415-hot-plug-passup-v7-2-9a27ef5e2428@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-hot-plug-passup-v7-2-9a27ef5e2428@collabora.com>
X-Proofpoint-ORIG-GUID: d0be2c6N89GCBw7P4FUXpLyu2ZcmB-f3
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69e429aa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QX4gbG5DAAAA:8
 a=vUv-4GSAnZTYQljDG2gA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: d0be2c6N89GCBw7P4FUXpLyu2ZcmB-f3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwOCBTYWx0ZWRfX6HcAUiGyGXkH
 JpdIVoxgnm55SQLgT5p5Sf1Xiv382AuuteZxlwNmYouGLIh0TVBoYd/prioM8BCy5fHfInr4V1z
 KFPbVB/bF/uV0aRQG9P+JKiWmt5NfuwYI29VOtaptEHVcKmXD2Kf8p7FeoW6yPyQrgrenhQ1ICT
 QfO90PIp/7phfIRP47JPkGmz0GJyeY2Y3+H/6Ds12aJDtXrzrBC1uPPRElCCwpP42IStKyWXh+y
 JqRV87CmWL0acCpfBgQVEYSKdn1iC/GJaYO0oEzCNg9iZMg3x8ainIRnPENtUUBoor4rZrkU1wO
 cnMdHotHNzp0S7ujdbxQemZ9+BkKZ8ss+DW9owAa8z72SGDcgm98ycEw1vh3WMvjAn95rFz1Hfl
 pw307QQ+oeTgnxJQSwSjOywCyyZOPrzYlt8RUYsgTj0EUaPvJHZQXXFuHZBN5g2J5m2yvFeblGZ
 aLoNUNSbq7HFMl8eIgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190008
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

On Wed, Apr 15, 2026 at 07:59:40PM +0200, Nicolas Frattaroli wrote:
> From: Marius Vlad <marius.vlad@collabora.com>
> 
> Use the new pending_hp member of drm_connector to always send
> per-connector hotplug events for those connectors that need it, rather
> than sending a global event, or only an event for one connector.
> 
> On the HPD (Hot Plug Detect) path this change notifies all connectors,
> rather than just first changed connector.

I'd like to point out that there are enough places were the code calls
drm_kms_helper_hotplug_event() directly. Some of them are ridiculous and
can easily be sorted out (e.g. bridges or single connector drivers,
where we know exactly for which connector or bridge to report the HPD
event). Others might be not that obvious. So, if we are to promise to
userspace to always deliver connector-based events, there is more work
to be done (and it probably makes a nice TODO item).

> 
> The polling path is changed to no longer send a connector-less hotplug
> event, but similarly send a hotplug event for each changed connector.
> 
> Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index f8cbd6713960..5c39f27ada1d 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -860,8 +860,14 @@ static void output_poll_execute(struct work_struct *work)
>  	mutex_unlock(&dev->mode_config.mutex);
>  
>  out:
> -	if (changed)
> -		drm_kms_helper_hotplug_event(dev);
> +	if (changed) {
> +		drm_connector_list_iter_begin(dev, &conn_iter);
> +		drm_for_each_connector_iter(connector, &conn_iter) {
> +			if (connector->pending_hp)
> +				drm_kms_helper_connector_hotplug_event(connector);
> +		}
> +		drm_connector_list_iter_end(&conn_iter);
> +	}
>  
>  	if (repoll)
>  		schedule_delayed_work(delayed_work, DRM_OUTPUT_POLL_PERIOD);
> @@ -1124,10 +1130,16 @@ bool drm_helper_hpd_irq_event(struct drm_device *dev)
>  	drm_connector_list_iter_end(&conn_iter);
>  	mutex_unlock(&dev->mode_config.mutex);
>  
> -	if (changed == 1)
> +	if (changed == 1) {
>  		drm_kms_helper_connector_hotplug_event(first_changed_connector);
> -	else if (changed > 0)
> -		drm_kms_helper_hotplug_event(dev);
> +	} else if (changed > 0) {
> +		drm_connector_list_iter_begin(dev, &conn_iter);
> +		drm_for_each_connector_iter(connector, &conn_iter) {
> +			if (connector->pending_hp)
> +				drm_kms_helper_connector_hotplug_event(connector);

So, instead of sending one HPD event, we can now send a set of events in
a very short time, potentially triggering undesired events in the
userspace. At least this change of te behaviour must be documented in
the commit message and in the cover letter.

> +		}
> +		drm_connector_list_iter_end(&conn_iter);

Should this still be executed under the mode_config mutex?

> +	}
>  
>  	if (first_changed_connector)
>  		drm_connector_put(first_changed_connector);

With the code in place, is there a point in keeping a special case for a
single connector change?

> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
