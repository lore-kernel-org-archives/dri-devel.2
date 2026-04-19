Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C62F99C95
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 00:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E12710ED0C;
	Sun, 19 Apr 2026 00:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/zmXVey";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ejv4akPz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F7E10ED0C
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:45:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63INdUS1127828
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3k+5tz0DFNU/+kp+odiDu59U
 TydwvBHFzoHA6pu+ZBU=; b=N/zmXVey2SrQU2L9zVUZa/pOjDgmhg05Jh7SMoyh
 lhloTO8edJvOCvO3xTeAHRIZy0loJpEdTPV24gvUeuZJ1JQb1DMvl9Q1ye81DPKB
 yfQ9F0qPw+qiz/JpOQ6wDhbIRs47BKCsR5C0P/JOwWMGBvUgu/+8tcmH7kV0R1Fv
 hTBdvXfygP5iR0WZ6hJDBV9ujU/ZkrGchcUdZVGRfd8cUXzvd/dVjKHqOPK5wzMN
 9vykQmMbVUaD7wEYFk93sFIfn+LguD1k7h9ckh4fw2UAyRcH30HmBleeS3eWjgrv
 Q32690GYpyRfVJQab+WeqSZA3c/GYJfx0MC9E0lJ1l1ulA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0y61ty6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:45:53 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-94ad0ada31bso5085813241.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776559552; x=1777164352;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3k+5tz0DFNU/+kp+odiDu59UTydwvBHFzoHA6pu+ZBU=;
 b=ejv4akPzIC2FsSTeKlGC/gK4w2A7WO5QXDyU13H9W9i/k1EusSKz+7LaA3CYzYeCoy
 CexJ+tLGAlAVXiBkTN1QfbELa9AujWfww8FUhLIz9RHF/9myOlrpkmxj92fd/xmIG0fR
 Y99NVbwa/sELf2/RNPjqL+o5NRrN1+nxTJzcy+uoaDoiZ+anoVKbJcDfoVfQZv6ZR225
 0jyZPXcvxWiLh+ryfwXCkmjdPPufQLlssl27v7u9rQfrd0CT29ZW8Z+zsGtTKsIHzbTR
 nW/czxOw8v44I/a4gR7T+MvkOl7ocavmFZV9bMME6bOsy06CUs+zjupwDe2+klrJW/7n
 YuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776559552; x=1777164352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3k+5tz0DFNU/+kp+odiDu59UTydwvBHFzoHA6pu+ZBU=;
 b=cPpNdqdUGoFa7lBHNlml3Djn1sxPJ+lLjPvTSV+q8EqAxFmvInMad4aHqIM0HMRsOt
 lqo9hAX3E5d+VUoxovVHr/CWD/dhFzqmHS5Z2SXiScqAWHVRiCSAD5dOouDmATpmb9bW
 iAZcBNFMYiFgAi0AMCd+cJgJ9UCbX0JII0+ebbO+aXl13qw+sDduDU16gOR69jPbECnB
 rU+gAc92/7P4Lr9Xsscza8s5u/ySvY377f4VRnRiILkiILYouUwbHTvpZWowngyqBVhj
 l3pg5j6ZXRhuTAeh3Im5AR0S+SSNOk+XZF+F3FN01apRtHN/k/Fj8P/rUaAAijuciOkw
 cexg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GiW9+N10Ral9yw/QGTYzb465xhzfOgQ2iOdclQ/cbrgbLbtXc0rMY4B/it106ie8TbaDEGp8ChB8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3K6jdg9PrHkS8eusaxu7eY2h2kXX53H9+ciqr1cY2+hqr/z/1
 3cVicKOoDBF7nC73oip11NU3H4ZCq29jajmvQzJF6mZtOYFAGfdI3hoPb5TSktUW3tE3rt72duh
 Aw7a/ZGCazNRIKDMDETjlq1xhjsYbtl2LGLG/iGuE5+3OZ468Fz75ZiWYiEqbxRTvWPpOWak=
X-Gm-Gg: AeBDieuVPt6Z4hvvEIWruXNX4ky9Ixn7sJ5tFHMJRKKmM/XNVjk6/gHoCRj06KMC8PW
 vqW4H/WNTOVNRy/z4ZKxoXeYfs08WLp2UnppHa5Bz6La4JeslBgYXTZBpje+9MKPgp7V+KcK8R+
 3kV7crVJb8KCwtZawon7QoE6bUzRLx2+YgILnzStf0cHgFPX+1ypbrk/I4gYXISWNl2F4cdGMxb
 PCXUbmFGzvMCSfkvX/dBSZ2h6EqhEi1/Tjn4muZQGewXgQuJ5EkS9xbSxEXvjQkk7SXO1fdeLYv
 iQpExRdwlefGz25PDiNbLjJMRzdUnr/9ZjprmwG6Rj5C69ieeGIl8UOh5vb+fFAzg/h2UxG8zaJ
 ufcri5JTn2MNnxafTpgDNa80y63R2MITcE+N4A6Z5Jubcq2+AFWGnOU4DBm3gZeIGKXX31aTqZr
 t7jjRb2tju/v/5y2ajpT5EArvTQ7OQ4Rle61Q5TjuF7Dp1bg==
X-Received: by 2002:a05:6102:4b8b:b0:607:d68f:d0f6 with SMTP id
 ada2fe7eead31-616fea7892amr3063326137.20.1776559552587; 
 Sat, 18 Apr 2026 17:45:52 -0700 (PDT)
X-Received: by 2002:a05:6102:4b8b:b0:607:d68f:d0f6 with SMTP id
 ada2fe7eead31-616fea7892amr3063322137.20.1776559552158; 
 Sat, 18 Apr 2026 17:45:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb73de2esm14178991fa.36.2026.04.18.17.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 17:45:49 -0700 (PDT)
Date: Sun, 19 Apr 2026 03:45:46 +0300
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
Subject: Re: [PATCH RESEND v7 1/2] drm: Introduce pending_hp to drm_connector
Message-ID: <jfzeyqjnys47ywy7y4djxl4xmrrpycngfujyotsunat72elhgi@mgkr2see6h7l>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <20260415-hot-plug-passup-v7-1-9a27ef5e2428@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-hot-plug-passup-v7-1-9a27ef5e2428@collabora.com>
X-Proofpoint-ORIG-GUID: Kn9IRt7813I2VUfLN2k4-LlX4uf9C64E
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69e425c1 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QX4gbG5DAAAA:8
 a=a3aMWr3dZGaE2TxolK0A:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: Kn9IRt7813I2VUfLN2k4-LlX4uf9C64E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwNSBTYWx0ZWRfX5sU6LKnFXFRp
 hVZ1s7pvrx894HJ7HlH0DSXNzGLPOUQZuJ3JDRG8KJzjfF9uM8Xv5Y1YtqBjelc7MEwP+xy3IJ2
 kUuETZi7jKOR2yM7o9oqR6ctK0e0nPFsiBq7ej1ZlZQ+k3b9j7SQ3hwwsOTdIIK7qoDr5SW+JOd
 kowT/u3DbKqtbUvQWXkFmjEOTrHJaktUsL8Zsmn6gwCMxLoalbbtBnr1t9xXE7fcB21I3QUeBq4
 KcGGj0NRkkeiJxxNfTgfySpw7BvAV38lw9qV+TaT9E2siIIGx6SgoIFZKnkeHjteELoAsGRNz9Z
 4UIdbJV/ByTbfsSmAdye+A0gJuLHUbTWDOz1akkHjvSfy+PrnkIFaFGU0ibSsUmZnekVL45mQmm
 35Y7Y3TpQwnnL1vFJYv83YcRKCmRGXCHklqLVtqGeJHuP4h1fHvWUlVu4h1M0CuzQOPgbMFAHvJ
 cFGGJxHukgOcW9kf8yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190005
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

On Wed, Apr 15, 2026 at 07:59:39PM +0200, Nicolas Frattaroli wrote:
> From: Marius Vlad <marius.vlad@collabora.com>
> 
> Introduce a new boolean variable used to track whether a connector has
> changed its status since the last hotplug event for it was sent to
> userspace. It is used by both the polling and HPD path.
> 
> A subsequent change will make use of this new member to propagate
> per-connector udev hotplug events to userspace, rather than sending a
> global hotplug event.
> 
> Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c    |  1 +
>  drivers/gpu/drm/drm_probe_helper.c | 17 +++++++++++++++++
>  drivers/gpu/drm/drm_sysfs.c        |  2 ++
>  include/drm/drm_connector.h        |  3 +++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 3fa4d2082cd7..b1abdef6778a 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -274,6 +274,7 @@ static int drm_connector_init_only(struct drm_device *dev,
>  
>  	/* provide ddc symlink in sysfs */
>  	connector->ddc = ddc;
> +	connector->pending_hp = false;

Can we use epoch_counter directly instead of adding a new property?

>  
>  	INIT_LIST_HEAD(&connector->head);
>  	INIT_LIST_HEAD(&connector->global_connector_list_entry);
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index d4dc8cb45bce..f8cbd6713960 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -732,6 +732,17 @@ EXPORT_SYMBOL(drm_helper_probe_single_connector_modes);
>   */
>  void drm_kms_helper_hotplug_event(struct drm_device *dev)
>  {
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +
> +	mutex_lock(&dev->mode_config.mutex);
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		connector->pending_hp = false;
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +	mutex_unlock(&dev->mode_config.mutex);
> +
>  	drm_sysfs_hotplug_event(dev);
>  	drm_client_dev_hotplug(dev);
>  }
> @@ -748,6 +759,10 @@ void drm_kms_helper_connector_hotplug_event(struct drm_connector *connector)
>  {
>  	struct drm_device *dev = connector->dev;
>  
> +	mutex_lock(&dev->mode_config.mutex);
> +	connector->pending_hp = false;
> +	mutex_unlock(&dev->mode_config.mutex);
> +
>  	drm_sysfs_connector_hotplug_event(connector);
>  	drm_client_dev_hotplug(dev);
>  }
> @@ -837,6 +852,7 @@ static void output_poll_execute(struct work_struct *work)
>  				    old_epoch_counter, connector->epoch_counter);
>  
>  			changed = true;
> +			connector->pending_hp = true;
>  		}
>  	}
>  	drm_connector_list_iter_end(&conn_iter);
> @@ -1101,6 +1117,7 @@ bool drm_helper_hpd_irq_event(struct drm_device *dev)
>  				first_changed_connector = connector;
>  			}
>  
> +			connector->pending_hp = true;
>  			changed++;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index ef4e923a8728..47a6b322e873 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -216,6 +216,8 @@ static ssize_t status_store(struct device *device,
>  			    connector->base.id, connector->name,
>  			    old_force, connector->force);
>  
> +		connector->pending_hp = true;
> +
>  		connector->funcs->fill_modes(connector,
>  					     dev->mode_config.max_width,
>  					     dev->mode_config.max_height);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 3e422a4f2e72..70a740301089 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -2251,6 +2251,9 @@ struct drm_connector {
>  	/** @force: a DRM_FORCE_<foo> state for forced mode sets */
>  	enum drm_connector_force force;
>  
> +	/** @pending_hp: true if connector changed since last hotplug event */
> +	bool pending_hp;
> +
>  	/**
>  	 * @edid_override: Override EDID set via debugfs.
>  	 *
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
