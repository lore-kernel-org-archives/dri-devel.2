Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED89C61DD6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E516310E084;
	Thu,  3 Sep 2026 03:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrHOrTuj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHVexhMm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEE310E084
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 03:29:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6832xpJM2235672
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 03:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YHg3U6ODch+jJFZP2j5QNR5qAwxcN/LDmywtPANSK1w=; b=BrHOrTujRKHm0IfX
 s1Z6S6DGRO0kb8YCm+dmOL0z8HkpNTrGXrmhr8+begcSpJdRk0qlIRWwXzhEFIHK
 6tW2eXJZQqYKpVkmcbjs6fLsOBIJgklxK1N+5j0djJjVycigEUKlWzVZCq7y8U43
 k4EDE/L1TFtdY29SjCiHuePgY3lHp3b/b9S3KG3s4gfD6y8wP16YiLykSBFYUCCI
 gycy457DujuRifj3hIqbWM4T8GEDWo1X7npsL3zgBeMSevzwQybqMPFvOu3EeUi5
 5VXc/3Cd/Xh8jVsqqeKIyOS5iVLK1MuWq/CPdko/+NiPYgUkY25svShBopkC2r7z
 h/DyqA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemja3aef-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 03:28:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d6f73d0f89so23815445ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788406139; x=1789010939;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YHg3U6ODch+jJFZP2j5QNR5qAwxcN/LDmywtPANSK1w=;
 b=IHVexhMmws1HlhcYkUg4PnYQ3QvM1Roc99O22OlE1aBze/SGDT7r8KZVD5/J2NkgsP
 Wh6cIyxv1WmdsJvxaHETtW4fm85IGtmlALkkEsSP6tyIjqWmZ6goecaBZl+QqkPVIPjr
 VhxNTbBnajJf0r/sjGeEMNaEcrpz0Xr7p3aCqWmTdLqtGyaWdZ6R5j8YNI/1MJu9zNVg
 NHg+Y/yk44rErDJ1YaJm+wFEsnI78zH5nEqMK/ZoeqVlWjHlKwfDa7+iRPoXkr5LXd4M
 YAqO/lqayosRDhF+6lYQeQhpcOz8OfPlNS53NYo45MNMEUd05rjU2umKpV83c8SEHmi2
 Ipxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788406139; x=1789010939;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YHg3U6ODch+jJFZP2j5QNR5qAwxcN/LDmywtPANSK1w=;
 b=Te2VQzrSUEqVmeImpluYlcQT/djbRYjSArguBBaIoRc3qsW20QOrC6tzasQq/Uhm/c
 WMe2FfrQK+HUYSho3RbEJqvN342lUtF+CxClWtWo+kira8vDCEEv4orLlTZsu3v8vYJO
 e1rk0kasPbRIcfvuN4McpJXGbBssAbm7n3l3ZdwpcpXSINvgCxcBKoXBEuKK3z/BhbIM
 HXAkm6iXYPhUrtuFvsGLqLG8gPFTuN+KgvRLqkAQxYwRGfGy1nX+0U1Gamt8c9/E5kfP
 rX5Wr1vXswU4N3OEgIio32S0br5g+HMa+iaBykXWswbxKnmhulix3jP+dBeumhYqc8wb
 rnig==
X-Gm-Message-State: AFuF++mo2h4WSiGtzr7HYKmEpYdcj0obRHeChC2ZlPQXRQek6TEiz+aT
 XSBZTgwIazlSMQlO7Z/6T1PIx9UVKgkV00V01JhM39B9IiZLrmywGEcCJkNcRnPu4MoAQiAcRhN
 FaegWmSVb8TdiAkO1PV9e91n7+hbzGapQ5A6Q8Zba8FY6nR0Ugw0DLz/JEDXFETmFpM6HOOE=
X-Gm-Gg: AYBFou1HKO2zDYHNf5BTUKOEOl0Wy3fbEfkzg4Z6/Qde/cdZ2gJx0NyMyTcXE49Eaak
 eByoVEm/ZRjCm2Tk8EV2Fzv/uZTnm3uPrEjq9i0AWY1qY/pAVXcOjuMoxfZ+XXoATTbuk9msGD3
 YPiKRAqrkNXLnUGljrQmdJlv2MfDLoZ057qNt44ptYbXNw+hVOY1U7vK6gJhW+y3jp8VQ7sOEo8
 Jbh73xSbA872r3EqDoc3jLD61Tx7TywT/Gp29G+nyl/mbeiNCEdPBtONdR96QV+wOqSXPRxF9Qm
 sA/DXV+JhzWCTBn2pnbhvWipwnk+9Tj0E3sbw0Pvgc04tEeKKdHCtyAOoHZxyzrukCVFY8OtYj4
 tH1cUbxn+8zOXsclH1fUm4w1hOVk=
X-Received: by 2002:a17:902:cf01:b0:2d0:cc92:f7a9 with SMTP id
 d9443c01a7336-2daec5abae0mr144681375ad.4.1788406138325; 
 Wed, 02 Sep 2026 20:28:58 -0700 (PDT)
X-Received: by 2002:a17:902:cf01:b0:2d0:cc92:f7a9 with SMTP id
 d9443c01a7336-2daec5abae0mr144680665ad.4.1788406137800; 
 Wed, 02 Sep 2026 20:28:57 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dafed74401sm2876755ad.81.2026.09.02.20.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 20:28:57 -0700 (PDT)
Message-ID: <1c95f641-1c4d-497e-9ef2-dcfc77a9dd7b@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 11:28:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: aux-hpd-bridge: replay last HPD status on
 hpd_enable
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260803-drm-usbdp-preboot-v1-1-2539b362be00@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20260803-drm-usbdp-preboot-v1-1-2539b362be00@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dNywZllgIVyRJchMQDIkrUcntmCjkUTf
X-Authority-Analysis: v=2.4 cv=FeAHAp+6 c=1 sm=1 tr=0 ts=6a98e97b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=n7D3WFhhhIv10khZyqsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAyNyBTYWx0ZWRfX7ZtdWmXIuE8q
 3cIyaEHw/lut+UUn8yKZcFbOsSNOeQB5vj1v0xVCifbfcOVq8nA+5gpwiRzSusZYk9AZ2vQu69K
 zaxiLsB+ip4nM7eBz89t4rB2UZCaS1w=
X-Proofpoint-ORIG-GUID: dNywZllgIVyRJchMQDIkrUcntmCjkUTf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAyNyBTYWx0ZWRfXzyX37PVBTDlg
 SwFESToeoWkiRr6xWqavBKP2f3sEYeIxdv1pTblR9VQav2R+Kww0goi2OJHoe1oBkRLcGRuBu32
 xo+hbJ/ZiYSELGBbM2bxt2P5jZs2EzMxxAybmSz3Rzw+rOk5wuoPnajhQh1nfo2nmkj+80cWaEj
 S68ItG/VDHk0a+UhYZSD3wjS7337A9RYIjERCpv8Fyb9Zp1dBiHC0KIVS5fZFLWtf/831fYtgZU
 CWnqW0gRX0K5+/aV9Mh/gz/BC32cfZD5pc/AyUvyof27MJyVX3Am0Uq2RSM8EVnLW6mWEKOj6ln
 B4RmKOgCBGJ2x3F416vY3AxUD+heyPiZ72QnfB2BjHRaYXmniGF9BLlxQGpdon28z+WuP/Uy9m8
 5DHBpXfeJF1zZOU808XjnjpA4NdSw06uhWAkTEsa0zwzgxNXNnbS7jOTqMZJpouKd4YQDxyiX3h
 GSz+dWcj0ZWpL2wVPNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030027
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



On 8/3/2026 4:43 PM, Yongxing Mou wrote:
> If a downstream consumer (e.g. drm_bridge_connector attached by the
> msm/dp driver) registers its HPD callback after an upstream driver
> has already reported a HPD event through drm_aux_hpd_bridge_notify(),
> the notification is dropped because bridge->hpd_cb is still NULL.
> This can affect any user of drm_aux_hpd_bridge_notify() whose
> downstream consumer arms HPD only after upstream events have started.
> 
> The race has been observed on Qualcomm X1E-based laptops during boot,
> when pmic_glink_altmode reports the initial USB-C DP connection state
> before the DP driver has finished probing and enabled HPD handling on
> the bridge. The consumer then never observes the initial connected
> state and the external display remains dark.
> 
> Cache the last HPD status reported through drm_aux_hpd_bridge_notify()
> and replay it when HPD is enabled by the downstream consumer.
> 
> The replay is deferred to a work item so that the replayed HPD
> notification is delivered outside drm_bridge_hpd_enable()'s call
> context.
> 
> This follows the same pattern as display-connector, which also defers
> an initial HPD notification from .hpd_enable(), but reuses the cached
> status since aux-hpd-bridge cannot re-detect sink presence on its own.
> 
> Fixes: e560518a6c2e ("drm/bridge: implement generic DP HPD bridge")
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/bridge/aux-hpd-bridge.c | 53 ++++++++++++++++++++++++++++++++-
>   1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> index a2e525aa5788..bb81aabf58d4 100644
> --- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> @@ -8,6 +8,7 @@
>   #include <linux/export.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/workqueue.h>
>   
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_bridge.h>
> @@ -18,6 +19,17 @@ static DEFINE_IDA(drm_aux_hpd_bridge_ida);
>   struct drm_aux_hpd_bridge_data {
>   	struct drm_bridge bridge;
>   	struct device *dev;
> +
> +	/*
> +	 * Last HPD status pushed through drm_aux_hpd_bridge_notify().
> +	 * Replayed from .hpd_enable so that consumers registering their
> +	 * callback after the initial notification are caught up.
> +	 *
> +	 * Accessed lockless from the notify path (writer) and hpd_work
> +	 * (reader) - use WRITE_ONCE()/READ_ONCE().
> +	 */
> +	enum drm_connector_status last_status;
> +	struct work_struct hpd_work;
>   };
>   
>   static void drm_aux_hpd_bridge_release(struct device *dev)
> @@ -154,6 +166,8 @@ void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status sta
>   	if (!data)
>   		return;
>   
> +	WRITE_ONCE(data->last_status, status);
> +
>   	drm_bridge_hpd_notify(&data->bridge, status);
>   }
>   EXPORT_SYMBOL_GPL(drm_aux_hpd_bridge_notify);
> @@ -165,11 +179,45 @@ static int drm_aux_hpd_bridge_attach(struct drm_bridge *bridge,
>   	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
>   }
>   
> +static void drm_aux_hpd_bridge_hpd_work(struct work_struct *work)
> +{
> +	struct drm_aux_hpd_bridge_data *data =
> +		container_of(work, struct drm_aux_hpd_bridge_data, hpd_work);
> +	enum drm_connector_status status = READ_ONCE(data->last_status);
> +
> +	if (status == connector_status_unknown)
> +		return;
> +
> +	drm_bridge_hpd_notify(&data->bridge, status);
> +}
> +
> +/*
> + * Deferred to a work item so that the replayed HPD notification is
> + * delivered outside drm_bridge_hpd_enable()'s call context.
> + */
> +static void drm_aux_hpd_bridge_hpd_enable(struct drm_bridge *bridge)
> +{
> +	struct drm_aux_hpd_bridge_data *data =
> +		container_of(bridge, struct drm_aux_hpd_bridge_data, bridge);
> +
> +	schedule_work(&data->hpd_work);
> +}
> +
> +static void drm_aux_hpd_bridge_hpd_disable(struct drm_bridge *bridge)
> +{
> +	struct drm_aux_hpd_bridge_data *data =
> +		container_of(bridge, struct drm_aux_hpd_bridge_data, bridge);
> +
> +	cancel_work_sync(&data->hpd_work);
> +}
> +
>   static const struct drm_bridge_funcs drm_aux_hpd_bridge_funcs = {
>   	.atomic_create_state = drm_atomic_helper_bridge_create_state,
>   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>   	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> -	.attach	= drm_aux_hpd_bridge_attach,
> +	.attach	     = drm_aux_hpd_bridge_attach,
> +	.hpd_enable  = drm_aux_hpd_bridge_hpd_enable,
> +	.hpd_disable = drm_aux_hpd_bridge_hpd_disable,
>   };
>   
>   static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
> @@ -192,6 +240,9 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
>   	data->bridge.interlace_allowed = true;
>   	data->bridge.ycbcr_420_allowed = true;
>   
> +	data->last_status = connector_status_unknown;
> +	INIT_WORK(&data->hpd_work, drm_aux_hpd_bridge_hpd_work);
> +
>   	auxiliary_set_drvdata(auxdev, data);
>   
>   	return devm_drm_bridge_add(data->dev, &data->bridge);
> 
> ---
> base-commit: 415606a7be939835db9b0d6b711887586646346d
> change-id: 20260803-drm-usbdp-preboot-ca19b593211c
> 
> Best regards,

Hi,
Just a friendly reminder on this patch.
Could anyone please take a look when time permits?

Thanks,
Yongxing
