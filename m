Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B8EF531C1
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256B910E4FB;
	Mon, 13 Apr 2026 18:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JTEXXUJA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iu7D3KeC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C5E10E4FC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:17:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DEJJpt3539275
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CKO27PWzOXPgZeFys90Xta2A
 cRn+O+syI4x+EowrjHE=; b=JTEXXUJA6IL0hyec6XzDL2EEL8O26sMo5Pa8/mAL
 RvJdS/YjDSS8+rCzn9T8yvmIZj7LRVNWdyveGZJSW4hZQZfsa9uWcysN9Mfpl80O
 eu4jUxSDx6VZSUVyGG2ateyEqk7DNLP9gO6v30J5BChvWXobgP/Q64gR4sLZl4V2
 jxmmLdZeGzfBTeTWPTngqe34KKa5ta46EKAn7jvLmZmnk2lW8ByAklizA4Q6l4Qd
 RWBe2xubr7RBh9zPldXzoGVlAsTw3YzvxfOeauKyayStBO5LFMgpfHU5KGi7T3na
 iWkSxRy2Df9TD8uwkIo4lXuNPOswwGWBHQ4rdPW57RXv9w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh258ru9u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:17:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d68dbb77bso49833061cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776104262; x=1776709062;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CKO27PWzOXPgZeFys90Xta2AcRn+O+syI4x+EowrjHE=;
 b=iu7D3KeCE2tzVWn7QTMup9GXg18eIhwsCDIB42V4NPZzf7qiSYYX2Zj3Mb8Fv2Nb6E
 X60axt6qh4sBG+NXSkNXJqArRSg9rnVsPtNG000Hto8px2yH6IoB05PgFHpwGACmcaPG
 tfJZAqXt3ecvcDyVXwL2F4A0/wfxHJYF8r8e8ngT/IHzbPODY/5p+9oQslkIYvvIABb9
 83vF6QJL3WgbNg5cMpj6moPf+Z943iUq6OskWa+f//5S2ZWKdX/iwCCX8aukcwATVwnB
 A0nxtC3WKhBTh/OgF04GvI/63Yi3sV7/Zgt5gHwTTlIL9LYYCEDZmodER1bzXGqj495I
 JZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776104262; x=1776709062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKO27PWzOXPgZeFys90Xta2AcRn+O+syI4x+EowrjHE=;
 b=AlUYH7aE7t6Y/nwnO5WzKAkbUws/0RDY+jIoYkqicnKMsAOqVv71ohMW7cCYJ9vl5b
 XZY/f55+SOKUejq3N09JfVnzmIbEk3hyZk8g7gpycyeQUegHlG4bEakOdEIkuEaAlDiI
 dPyabiVXdzmVt68jXk4R7Q/9+WxFxoEpJeMWPBtoONzqDQ7Qz+huc5AyLOj/t3r0Utxs
 5ZZnBynyMGm5XidEU4oRnZBwZxt/pJIe2UX4QBrUrbDAPyCDOvt/g/eJBiCXV1+XebxE
 LqnkDn48S8pZyn+uFQcDqeqVSPupwHw0ZX2bYKvyF1oFtMR7uyX8UayyF0jyQkam680Q
 BE1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lFUEDxVKce/3ivTlt72y0ySROAO7tiTUZNMI8YRBnntSUTFj1cRkZ7mPqA9/KBHAjaRQ4KrGmt7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrISsCCc6B+5IjslYqvon+M+Vx2eXar4hB44HKi8Aq1UGRJO7C
 k53J9ZXB2+kwxSy8e9xMnBqZgJdkM0of9Om8bCDo9a6IYbQYKXjCi94oPBL1GY/AU7XNGJcD/cE
 wEzLShubKDNINCwr3d4QecO+d11l+0+7xancmiGs5CKoHE0yAnaX7zYRO+CuAEXPedYS05UI=
X-Gm-Gg: AeBDiesBaxzN9XWV/e8D1QVvFNzwTOEOH24ioSb6IzywaaYcfjMpRIYgahYXJZje3AP
 CSnQLGzZjqGtPNzTP2CGmfZ54Hd1IBl/L0OuWgfcYS8zrqJ8WF4JeMRr2ZIGozzddOk++NktIK3
 NvZIQKjKh3oJoLun3bUxc/kSCcFPBY7fLndGNVjvaCjYxgvDDWhKu4N2yXn5ttyMvee2D9gTt/t
 ojRnf07UWETsCisO7LzsI2QE4GnkFdsOf3d7GWDk2QVceGms+j6MGkex8O93RlkAo8OS7PaE+8Z
 e4HKKIP+bdxyu/YGjlm/5V1dEJJtjmf8EkTcb2ZpH7VmPE+Wo+1P5xSs5qdc+Ed4wa1CBWdXN0X
 G79FajjK+IX1ow/HcWor56kL7GXkfNzn+Vm05fTS02G2uDCRhDZoPtSWOfhxZSy+mvYcNmLFQ54
 uo9u1eRyddqf+b2Fz57ijWwj705KvTf/gP6nfHk5VTiVB3dQ==
X-Received: by 2002:a05:622a:d1b:b0:50b:4d3d:496e with SMTP id
 d75a77b69052e-50dd5c1383amr209571451cf.46.1776104262117; 
 Mon, 13 Apr 2026 11:17:42 -0700 (PDT)
X-Received: by 2002:a05:622a:d1b:b0:50b:4d3d:496e with SMTP id
 d75a77b69052e-50dd5c1383amr209571031cf.46.1776104261646; 
 Mon, 13 Apr 2026 11:17:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee86778sm2672353e87.16.2026.04.13.11.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:17:40 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:17:38 +0300
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
Subject: Re: [PATCH 07/10] drm/bridge: adv7511: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <kcvbx7glrazf6mr7bcb2agj6pdqxdqnrcsujg3y4x5drmhqlbd@pfdb6zcnlwju>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-7-acd01cd79a1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-7-acd01cd79a1f@bootlin.com>
X-Proofpoint-GUID: JOcIrq3cfLcMOgR_v7Np54ysc6sGdcgd
X-Authority-Analysis: v=2.4 cv=Vo4Txe2n c=1 sm=1 tr=0 ts=69dd3346 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=sqxsbOWVCbAVHG9YZwUA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: JOcIrq3cfLcMOgR_v7Np54ysc6sGdcgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE4MCBTYWx0ZWRfX1MMqEqn1H1D/
 NTBoMxK0KMYyE82JJRswxjbZIHo98ZviLgWjo5I32FObB5xhS3LQIrR2NRcDFBc6rQQ9MBFPVzL
 hIqbAZ+PF+o8aLRWqrbgw5IkYSE4SKo4uh5UvAZvBUDJBjEHt4H4ruwK38mCP+8eA1UPEezCIqQ
 lm9FLdJpPJyIdxlCRAhfZW+YEVFmP/nAMNXdqENlBGdnfwHf6pzqGpLt+UKBO0mKuDty/C4Gis9
 RM/zf1Ci9IVCz1sMA4Z+AakWaRUkUl06peuS2G9oyISW8PD6AOHfUbZllqLzxEsWBv/O5WxL8KY
 D4/7WNvTvQcJTweLHdUCuy9yK73nSu0N7RCcx3cpwVPpzzn/6lCE3A3yhuVonFdjWTT9TmSHbmu
 mUzuASUZVSEo0eCG+kUxAiBvdpgZoovVntUwT1oBApzexpos6ouqs/VKuY3vViz7PcQdK8cJyse
 j3SIXhZQPJW0YeRG9Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130180
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

On Mon, Apr 13, 2026 at 03:58:39PM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal. To achieve this, instead of
> adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
> pointer which is automatically put when the bridge is eventually freed.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     | 1 -
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 8 ++++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
