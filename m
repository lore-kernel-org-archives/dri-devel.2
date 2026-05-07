Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93F9CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E642C10EFD1;
	Thu,  7 May 2026 09:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXqRstjJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cATXr6Cs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A742510EFD1
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:03:10 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6472LAbZ3463977
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YrpuQ2HaYJKwDOP37Hw7zBeW
 /Ufbpln0zt9mK/SKQFY=; b=OXqRstjJjGvFsW5N3pX6hg0UzIvYeVD80k5yPZGN
 sIbl1ZyuKmkd9T17G8yX5KsHOSqCII5trZ9qdlexm5kPcaYAE6vZgQon04n7XUpa
 CjwvUkRYYZTe3VAO/DshO9t1YBiZVsJPOVm5qqLe/7+87mwnaYTSVhadjCD6SIW4
 IDR7NVxwYf57LhoGYV+sj8yugNXZFn7u2ZhLYWh81wcvAzuARVUi8B6+9iW+FuD9
 mIQEmjTpoCyxtJuoYDO+jz7rxnaxw6ObzLcL9VgNGYkGoELe12wNxc4eXYWU9lL2
 ieTV2z6RaTCjLbKUKs3LTLhZGwngvu4USnPE0GMkGVap1A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hvn1b1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:03:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb3c7b989so9488341cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778144589; x=1778749389;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YrpuQ2HaYJKwDOP37Hw7zBeW/Ufbpln0zt9mK/SKQFY=;
 b=cATXr6CsODT3e6hi7isr75F7Q9wOdZ7BmIc0KsjuYROsEvKj7g72VXiXwvSDUwkZDw
 gglFG5Vcmn0ToAuhrpRiR66CbA9bRUYsmWsJZqKHzNeLzkm6OPMaGZfja9+mb2TXXUW9
 m0OnSMf9SgL873y+LpKfMm9GtTn8nrs9iLgWpEgN8taSjEximGgHd6fUPySzUPUF49Ta
 WfZ+23LceCDhdiEk9dl+MdDtCt52ADgroAspmM7v2Sy3Q61y435+ptVibOYzQpVavYRx
 E58X9fnQVyKTBZawabfJtpRCwd11o782Vrq9YwHxiW7QuZM0fOcIZFjq3pU6HG8XhJ0k
 6NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778144589; x=1778749389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrpuQ2HaYJKwDOP37Hw7zBeW/Ufbpln0zt9mK/SKQFY=;
 b=eXPyHI2ZsvLxdV3bm5ESLO9AkR7/ul9YlRXg1sPLyy/6O8o3UiIWSQxYYRb0Dfh88s
 4B8U9ut3ICoP9Jq6osMEHFwy2h0ZsVc+6GJbv8cXI7/bDnkM03Q37a2/1oaL9mep0sOP
 oqRC5JOAavmII/3BkAhUfX4leYctcx9M3s7eN/8vYgACR7BsESp8lio0WRyx/C1EtzF5
 lJDlo4pj7zTeETI69Bg/aUK3dFscs9PDI+lHciA2zrLR6PBfneeupHTFq/Kytpw5sZsU
 X4dnyVsc9EIiR0cIzhhxHS6/IlwMW9jCNWLF+BcC0mhz6pW/Z4n/dg9ATsNzGP3tw88w
 k23Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ToNpZZvGG4dlxdtZ7xx+jgXF+5O9E502cXajFBfoMahr+WSQB0rZQYX0A7C2JurqMk+bxqfncaXE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxh5Fb/0pPECkIuNrNCMwsSydCGd5ibyg0bNi84xBq5eCphRVYd
 tk1+VsoWrbmx5m1sEaCxXECiZXIKBwwMmYTNEjsETS3qGlZ/8JqU7slcnyi1PTsUSLlT1coXcS9
 ZyzoxyZX6j8q5IqW3sBqndlN3+AlTshOGx3lOF8wBIBq5ZHcrERqeAh966efPDXLpnIfpqB0=
X-Gm-Gg: AeBDieucBVsjsnTCk3eNTOtYIckbCngBm1/wZwXTSoGQ0VvE0a9O2Mr+hQXlXo84Fk2
 nMEUqYv4t02ycRkQKuN6inAz3i3NDF0wwAs82GKYZJkvoGbqcQRk0IpawFKxpKZWdzfdprUHeTS
 Xz9K5ZIfxxuMVe8iIoFu6/FMVopPQTtGd0IJfHMS7HqdR5z5HFJQ1xzmr2kqp+xK1LP4QgJDpao
 zpK8+JtcBwHRVc9fTSQ/qw8tSm9V3wqlCgF8hd/XwGGiozufSdbhJJlAz5V+8AIAWFpPTus54GU
 T0UD4uhhPiLzoYSJNTjSBwYmKUFfCBRJkVZfy/L01a8+MfhtWGwEHVyb1GxiF563lue3oKUmM5c
 25EU3PlZ2aAQXQSTqFwKXkntqX0ZkV+rmN0UAwz1aMvuF7fWdv/uRgqUjcdEDx3i8JsawUdIUkt
 t0pfD+WJUEySRT6nXK+o+xkY+IF88OKu+vQ2X67cPMnNSkfA==
X-Received: by 2002:a05:622a:647:b0:50e:5de8:6458 with SMTP id
 d75a77b69052e-514621eadccmr90870401cf.57.1778144588830; 
 Thu, 07 May 2026 02:03:08 -0700 (PDT)
X-Received: by 2002:a05:622a:647:b0:50e:5de8:6458 with SMTP id
 d75a77b69052e-514621eadccmr90869991cf.57.1778144588300; 
 Thu, 07 May 2026 02:03:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8670a37absm4678403e87.55.2026.05.07.02.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:03:07 -0700 (PDT)
Date: Thu, 7 May 2026 12:03:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/panel: lg-sw43408: use devm_drm_panel_add()
Message-ID: <okjjjez3vp3tqkfmkbadtph7kssa6gfaremax6ocg63tn7whbd@2sg7kjat3dr5>
References: <20260423125922.57428-1-mhun512@gmail.com>
 <20260423125922.57428-4-mhun512@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423125922.57428-4-mhun512@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA4OSBTYWx0ZWRfX8XtneXkrx15q
 dOvnDRmbLxgVNilh64HvLhwSKHX9x+nfXqgJxFPnZaX3isgPuq99UuhmrNHiPBYR7OyBmLG+lNg
 BSPxs2LEpAdhyUPB9wmAiNiMJe+BpBav1iYPsYu1eSGui+W8b3z/kCRCsgSHyqFK2vvhmXhCLZC
 L1ONXc2YZrCjD9Uu8rh/cVUthxy3dJqj01s2RGuIwDMa4cPvcVv6/kmdlJp5VINWAlDRDvdS6dv
 XVsovJt5iW8JI+PlydJuMfOOYq3fWlS4I+09S0cjiM6+1A7t+RFPm1yNQfsLjfqwYP162Hprr2J
 oVJu2a4FMBU+IsnaS26dlI4/l8QhSH7Q7/dEvklemgE7GJ5lxCos1JfDQwb3aWOtI39Ju/5+GZ8
 Wzp4zEmnY1lZ+3s7a46zVIA2ZaQt72TvVXaHnXsWuD1g+iAtfyGL2fIkPuCUrcakQlVLMMPTLzH
 QUvCplN1jyU5VMkL3/A==
X-Proofpoint-ORIG-GUID: iM7VwxxWWTe2m1k5_dhurSWWUIEeBBdz
X-Proofpoint-GUID: iM7VwxxWWTe2m1k5_dhurSWWUIEeBBdz
X-Authority-Analysis: v=2.4 cv=ZZ4t8MVA c=1 sm=1 tr=0 ts=69fc554e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=HECvZMaGUAMxNc25RbcA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070089
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

On Thu, Apr 23, 2026 at 09:59:22PM +0900, Myeonghun Pak wrote:
> Replace drm_panel_add()/drm_panel_remove() with devm_drm_panel_add()
> now that drm-misc-next provides it. This keeps panel deregistration tied
> to the device lifetime and removes the manual cleanup from the remove
> callback.
> 
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-lg-sw43408.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 293826c500..8969f57b89 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -254,8 +254,11 @@ static int sw43408_add(struct sw43408_panel *ctx)
>  
>  	ctx->base.prepare_prev_first = true;
>  
> -	drm_panel_add(&ctx->base);
> -	return ret;
> +	ret = devm_drm_panel_add(dev, &ctx->base);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add panel\n");
> +
> +	return 0;
>  }
>  
>  static int sw43408_probe(struct mipi_dsi_device *dsi)
> @@ -299,14 +302,11 @@ static int sw43408_probe(struct mipi_dsi_device *dsi)
>  
>  static void sw43408_remove(struct mipi_dsi_device *dsi)
>  {
> -	struct sw43408_panel *ctx = mipi_dsi_get_drvdata(dsi);
>  	int ret;
>  
>  	ret = mipi_dsi_detach(dsi);

This begs to use devm_mipi_dsi_attach() in the probe function. The whole
remove callback can be removed then.

>  	if (ret < 0)
>  		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> -
> -	drm_panel_remove(&ctx->base);
>  }
>  
>  static struct mipi_dsi_driver sw43408_driver = {
> -- 
> 2.47.1
> 

-- 
With best wishes
Dmitry
