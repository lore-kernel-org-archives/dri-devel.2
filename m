Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7254BCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 03:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D801410EC8B;
	Mon,  8 Jun 2026 03:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5ayZwLX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyqQNeDU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9AE010EC8A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 03:38:22 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6580E5cp1572061
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 03:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Y3N1eeaQeo9fMWbhxSynj6yk
 bIUVQq+uNK8N5xv+6oc=; b=f5ayZwLXcBSr1MU195o8cK0WPtAPy4vtFBAZGu2x
 u1GbAbEL48odZ1HCxA3995hJ6RpJ0gjL/2jIyawcav+RsXxTTMwSGzoDawyFeFvA
 rWt2QvMDH4gZL2R/gDC+Z8//eIwSVwpgYanJ7SbNRMq26Af0OxNsDHk4OcbM/KMU
 d6t0eEBDPGatbl9LkoKilwcLbAPUK7XiT8u1q1mCMkRrcfmsE1iTblghL0ERbm2F
 t7JHrl4fXl6g/3WUCpkodtj2GvPQMuKJvBUeyW9c4DRD/nyU7cBxcfNpCLkrZcd5
 fUDTomTtQbI8qffFZVxUl7b0Sj+zB2UxI6Jjz3wkXVZn5w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8wdm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 03:38:22 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-963b11561bbso1574426241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 20:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780889901; x=1781494701;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3N1eeaQeo9fMWbhxSynj6ykbIUVQq+uNK8N5xv+6oc=;
 b=AyqQNeDUgqBQG5T3F/W4MLWhVGGfzFXOkEFX7nUqegToivMAjYiTs6y5YUzmJibdFq
 UFKmUY7wuaPw2zPAQlC+LRrHzBS3RKwY+60Vhc2BjnoZvaXn/2nBqBQGiOjtJq/cOpWA
 c4IIJzUNmwwenygooPPBHu0F8sJEmV1mGIyXR12M6OADiRwnAby78tOMhEH4LinRpkxU
 CKByfZLACis+KFHm4pJrkkuZv9DpS+dvRwrpBntRE2NWDfjq/sVd+ADx9zB5G+k6x4Im
 7E1JmJGLgTgdIQboPI6rDU0RxIS9y+RoVed/15Klp99TpVsDBTqrz1J6al9PY1JlY530
 y7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780889901; x=1781494701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3N1eeaQeo9fMWbhxSynj6ykbIUVQq+uNK8N5xv+6oc=;
 b=HLFzwrd2QXM6Go1/He18pXX5FNMHRzRp2bs8T7WS0ywEUjdH53QKbY/HWSD/PZtaAI
 5Dqp4crvIgEN5/pHVx/TbEm6vOPUa179SOrXOuQ9ImWPOA8hxgSP0mX/2bn4SKjJVGz/
 kYv3gNbGtJOZDdG3blkHNK+KcKWR39i9HiMK4Ib4S3iOev2rbFdgSKvMRdzP2sZeZRO4
 sMhYOWgUK0u9FYbOjk8ziVuMeDSwbArr+Xf+5w1PWKGW2eG8NPppz7P0+lHlpn9lTtLN
 K23osAa327TJAJHWy+O+8TGWYatV/IUCDH7E1w5FgG5HEhnKAG93j9VzSgYrMOZl0aOh
 6DMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gGvt3u4mzz/BYS+JS0pxhocKJ5HQBqv+5ZYTGG02/DUApuZzDG7VhRcDryiEkkkjhXRXvQnugKtA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzc+mEegm26E11hPvDr3rrzL4l/AX67kJkIlOS0vItPAmw1ucaF
 ohzffER9KbjKiFSNCnVNF4WjKSzKk4AlHSbktGK6sU5JsIzUp9i58PnkNcN1zDndEX2zm/tkGf8
 19nKJIfkzq85UcKy/TpZtwSaGCPqNaxAkyUj1umKoVtn1l4CnuiDRJaKz3PAb7gGzBw2Jg1M=
X-Gm-Gg: Acq92OGsq0nlYm0+a6F63mphajF61vI0Knm1OOdeNK36Bu1+9W6LrA15HRJ0rmQG9vI
 qw+k1P4BsDRwYTH2DZV6alR94vo0kJTSpccMyMlxQn93uyEm08mKDp/M8mCiqY3RpJt0a7FRlzU
 Cnj28nEhW9gA/cxxOB/rxdpgrPK5HEmGYLaRCS7qLPLpySq7H16xCJCXX+oIsboL3sQu8QabIzP
 xu8Rszi+VUGDGBrVGNoBbFt3J3WXCcJx6te/kbIq4+AZs8jKwu4xR9BTAh3UGGhZUGa+k8LhtzM
 5qpFEp3wj2FsG1oMDeFJCVDq3w00/9hiV5bQ13kRAwMtpzLPpf0HOsGhOwDy0c8Be4tNqZpbS1D
 jd9I84t8e+dg89DbgwMpgVHXZFJbS6Uc1oI+NbV8jnIs45lsFzU56vIKZsxSPR6MBmiKHMw7/ZD
 P3/xN7rzoSlLtZiKYjKBN4i6r5kXM62628i6/V2epMEXYERQ==
X-Received: by 2002:a05:6102:f9a:b0:634:420a:ab1b with SMTP id
 ada2fe7eead31-6fefb09fd9dmr5197906137.18.1780889901377; 
 Sun, 07 Jun 2026 20:38:21 -0700 (PDT)
X-Received: by 2002:a05:6102:f9a:b0:634:420a:ab1b with SMTP id
 ada2fe7eead31-6fefb09fd9dmr5197895137.18.1780889900912; 
 Sun, 07 Jun 2026 20:38:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b8ed2adsm3474262e87.1.2026.06.07.20.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 20:38:17 -0700 (PDT)
Date: Mon, 8 Jun 2026 06:38:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Douglas Anderson <dianders@chromium.org>,
 Jani Nikula <jani.nikula@intel.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: add missing drm_edid_connector_update()
 before add_modes on cached EDID
Message-ID: <pdb62ojwx7l6lvyo7ywilm56muv4vkqpou5tvpi6ac6yjo2nwa@dgsdk6i4sm5d>
References: <20260602-drm_plug_flaky_edid-v2-1-1269fb942299@oldschoolsolutions.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-drm_plug_flaky_edid-v2-1-1269fb942299@oldschoolsolutions.biz>
X-Proofpoint-ORIG-GUID: sp5L7g5nrv7Hpcr6e5oiNBYd_fZPQpS-
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a26392e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=gxl3bz0cAAAA:8
 a=EUspDBNiAAAA:8 a=sa5PkiOI6JPz9RB1ZpgA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAyOCBTYWx0ZWRfX46o7U1lJdMam
 ++FOSOW8DEh/26/vsInBM45SNMVe6/qZwUrABnL3wHz/oPLwGozfdBXmQjG+kl/jJfhmkXEvEak
 XvuXJDFpVXPNzI6dswFj9Bv3TqGqaOC3sng0zCJQEjutP1SVlycr+iWV2uk5Avir6V35dP2H/Ak
 keaJD7LXXfMFCr0HWgkr/gpLFW+Wdcz0u7fKqCzGZxal6oXb50B99nbhpqy3310dJT4I4UEUeIH
 0fdjxt0LJsP34/xo7AY5JY3YBGDbTJdOZ5oAErBp8pWGxMFbVl9dPN3QwqKp6T4WSwC59d22u0L
 dEvZvqxJOncMhsvW28plvHAc3Be9Sng2XpAnbNmM9rq3zFWw0fU/41JtmQZBsgoO8qgUDselG5z
 erRdnc8aRMJSrlAL/MomNDJEM3pAI5/5KZ2AQo/pCEo03lu0tIFVGYaYhH1pohOEC6/mLhWrK7h
 Wu2mbDRTYX+ztH2Tpwg==
X-Proofpoint-GUID: sp5L7g5nrv7Hpcr6e5oiNBYd_fZPQpS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080028
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

On Tue, Jun 02, 2026 at 08:18:48PM +0200, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> After the refactor to struct drm_edid, the fast path in
> msm_dp_panel_get_modes() that already held a cached EDID called
> drm_edid_connector_add_modes() directly without first calling
> drm_edid_connector_update().
> 
> The new API requires the update step to associate the EDID with the
> connector. Add the missing call. This restores correct behaviour for
> the cached-EDID path.
> 
> Fixes: 5bea90ad9743 ("drm/msm/dp: switch to struct drm_edid")
> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

No empty lines between tags, please. Otherwise they might get ignored.

With that fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
