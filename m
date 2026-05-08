Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4CFCD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 18:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B6510E5B4;
	Fri,  8 May 2026 18:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WR0Iykff";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UYL+V17h";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD69210E177
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 18:43:34 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648G31Tk724620
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 18:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=y+uqtVLmFUCNQVUxTe/oua21
 5OO0zK52yL+pzUl8BNA=; b=WR0Iykffq66Bzco9V06J0clPwQQqWiJ7T6GBC40i
 aaI/R+4yQqoVgDeivQlPSPR0t/zBQnr3BbV45qER6y7859VN3Cb1AziCTtdQxf5P
 dEnJmYrcEszkSPXwdO8rdIHs1c7Fw8feC1xmDXrvySkitQNV1/zJheDgy8O5/9rF
 vTmmkR/y9j6HgFbUMNCvjS1PxDnUi8mRVrKN/VLZgDhSflypaXKHUiBBZ/aJauc5
 Gp3hloRIbJbT7qsfDWFtfbUNBIGufbuy23H7qece9dWfkWVUDUEWCyLWKsQeeUF0
 rxQZzCywUbp5k6s0JuAK4spTAoNOYnwo34F7HynZGFsW3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k0ugk2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 18:43:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fba8d8c40so43504621cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778265813; x=1778870613;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y+uqtVLmFUCNQVUxTe/oua215OO0zK52yL+pzUl8BNA=;
 b=UYL+V17hRP+B4yMJY0IkrhP+PhgauAlgsphoeKtTGrtqd5ScGpPT7rFirob8bX0oAx
 zaFPOZqcWTNC8ks9IWBJ5Zg/yPfg78+vJSa5jp8wPh0Sz0hADmyRxsY7Fbl3dVUUG8bq
 QOYq5Qn4nUymH74yFf5ZziMtOf0IXu5coBW6MYb32wUWeeICvAcBbBQ/AombdTzY1Lig
 2/vsKNvCZ3Vpvy7Pya/0DDgSd6pwe9JBXBQAbjmHFslIP7qgr0Vo4O0y8/KVPVU+ssV9
 82kFFKWa9PHO2VK7m3QFqbhV69xlN7n+807qZhl3Wiaqq3p2xmAhUp8mZJYbGHCg10AV
 X7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778265813; x=1778870613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+uqtVLmFUCNQVUxTe/oua215OO0zK52yL+pzUl8BNA=;
 b=iYvU3u+pRdbakWWtNXor9jyJftH7UqOTeBOVlg5T3NY95c1CUOnlmW1bHXbdPcNa43
 xOXkORlIa1+Y3gdu1fUe9zQEukuxYxwlO+OlqeioAq7+TSDEkQTT2TDAm0jvU1cJi7qg
 s2NWwv1lauJhg948joAgy/2hiGv+gBLkhZG7tiCztO07weHqxufpG96XrKqhB9uJLti+
 ZI3ELE78JmLGaipRnt8lMVOOoh8Qce9pNpGmGaJ3acRGNyzcqqAyRWqauT0A8OCC92Vn
 MJdIEnKRfYw2M99vbrfuYdN/vMMNKXZWebyd9m6gMc4hqXxfW6jRAbqluOVOH/SxuwFz
 Snqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qFZFiREdWgP6ZgThN5U9KDavGgxz/cCpAlBLPzbhnRl0SRRTQukhhND+57LcCp6Cj43iVn1KlQQA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/n8xuLFmNUH1DKXRbHGfwvX/Gpcsvb/RxYv08vf3ZtlKfXV+T
 fOS4s8ry/ZA5S03d//VkfTs++enbAEPD3xXI/kEauJw464+pPUnEt59liPOJ2QFvY52BjYlz4yS
 808C6OvGbGexQPSK7C9YR26/PBeqYXCJ3bgHdxU3656M7F/fHaipU5pTaY5jueF3qrBi2o8Q=
X-Gm-Gg: AeBDieug/aloOs24A0DTuAGHj1mdmxNzO4+WBrKGmEXaSCHWbecqMBdjbC9QeBmB+N+
 JKUbQHOIC+v5D9nYSD/g/EM7VXTAF7EDk0R+DTP2NNkwI7X9Eo4jD49H+Z5VmCkTy32KdLD/e74
 /qmPYlbA8AF+Wbgh0Q+7G1w4dVvIF21dZdCCATCWBVniSXTpp/VQTFAKlHA2z+dZ0UwHKAJy0uL
 emg6HN/iGQaEL1VZw+XWhQ/MB2BwoDTpM26i/5B4FdNag4dXpqKutQGIBghUwIqLMStfvbgynSk
 vZe7NoSxN/DabvXQkslxgHRddsC06clCa3JEWsJmBb9UJGZzdb7/TPykg57F8DNmHt5C2yUpRK5
 AIDVdagw1JL0m0BbuXt6pg0vGlr/jxMRADM4KxMb3ftulKMNfWlvJrNYxPzblDbVKnM73i8CeTh
 kUe+KxRZq604usbGk998ngssIgrSmIRkGnQS0=
X-Received: by 2002:a05:622a:6096:b0:50d:7c44:e144 with SMTP id
 d75a77b69052e-51461be0b74mr190178661cf.11.1778265813087; 
 Fri, 08 May 2026 11:43:33 -0700 (PDT)
X-Received: by 2002:a05:622a:6096:b0:50d:7c44:e144 with SMTP id
 d75a77b69052e-51461be0b74mr190178231cf.11.1778265812631; 
 Fri, 08 May 2026 11:43:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f62693f8sm6884831fa.38.2026.05.08.11.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 11:43:29 -0700 (PDT)
Date: Fri, 8 May 2026 21:43:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 03/11] drm/msm/hdmi: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <qfjsg5r2doqoi5dwwpgccbrasnacwcshtshddwoiwyrndyrwyz@6xfmctnfem47>
References: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com>
 <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-3-472b913b5cb7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-3-472b913b5cb7@bootlin.com>
X-Authority-Analysis: v=2.4 cv=dIqWXuZb c=1 sm=1 tr=0 ts=69fe2ed5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=UZaUIiQ-CiS0E6Nlr5MA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 0WNrV4GKPJmN6qj-gJ6peRqFTqQ_OfKs
X-Proofpoint-GUID: 0WNrV4GKPJmN6qj-gJ6peRqFTqQ_OfKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4NyBTYWx0ZWRfX1X6Xdk1gyRD5
 z87DhJVDr+j3kahUxG82LYx2YEzq+cJ9CnpYoeE00MkqhWAmXQwiMR5iUh9j6xnoWzaje/X2N0L
 r0KnD8gTh+hfzz6OkHB2G/OvOWLZtsIlRkLSVO9eUo9cbUVaCoKXTgd/t+3Ew37HbDnBpA73i5G
 Mn6blSJkG9SViG6UX/2XmLkbAtUm1L5PBf+CcbO2gv7ZC7Vo3W41vcTq0v4BrHaxi5drOd0JHfm
 3GMsmranR6ufL6ucWyAtMq/ckWvzUzzAIJOLejV0Y069dacyPDFon2TpRJNzLKasw4uFcy+UJMa
 hicFz9H8JdCYvu+h8H/vLLCrbIbKyg0vm8yAkZ1ioSX1B7E7Y4ROII9MT3kx67grJs6s8uT7I1X
 ys9f3kCcAS1rY8WC9IHLJGz24efr0IRHeY1YMgj38eAXbNlxBdW+1bN70vR8foLszzhYXKOZgTc
 IJr9Qvd8AhMXEPzFk7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080187
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

On Thu, May 07, 2026 at 03:45:21PM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v5:
> - simplify error management code flow
> 
> Changes in v4:
> - ensure next_bridge is put on later probe failures
> 
> Changes in v3:
> - fix ERR_PTR deref when -ENODEV is returned
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index d9491aac1a89..3640be8c1bf9 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -285,9 +285,14 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
>  	spin_lock_init(&hdmi->reg_lock);
>  	mutex_init(&hdmi->state_mutex);
>  
> -	ret = drm_of_find_panel_or_bridge(dev_of_node(dev), 1, 0, NULL, &hdmi->next_bridge);
> -	if (ret && ret != -ENODEV)
> -		return ret;
> +	struct drm_bridge *next_bridge __free(drm_bridge_put) =
> +		of_drm_get_bridge_by_endpoint(dev_of_node(dev), 1, 0);
> +	if (IS_ERR(next_bridge)) {
> +		if (PTR_ERR(next_bridge) != -ENODEV)
> +			return PTR_ERR(next_bridge);
> +
> +		next_bridge = NULL;
> +	}
>  
>  	hdmi->mmio = msm_ioremap(pdev, "core_physical");
>  	if (IS_ERR(hdmi->mmio))
> @@ -367,6 +372,8 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_put_phy;
>  
> +	hdmi->next_bridge = no_free_ptr(next_bridge);

Following the question on IRC. Yes, this seems to be too late. So, I'd
suggest keeping the current assignment place (and call drm_bridge_put()
accordingly). I'll rework that to use bridge.next_bridge afterwards.

> +
>  	return 0;
>  
>  err_put_phy:
> @@ -381,6 +388,7 @@ static void msm_hdmi_dev_remove(struct platform_device *pdev)
>  	component_del(&pdev->dev, &msm_hdmi_ops);
>  
>  	msm_hdmi_put_phy(hdmi);
> +	drm_bridge_put(hdmi->next_bridge);
>  }
>  
>  static int msm_hdmi_runtime_suspend(struct device *dev)
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
