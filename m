Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BD606A327
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lhXnytXD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZUULzAcr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C97310F514;
	Tue,  3 Nov 2026 11:28:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493BD10F506
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:28:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAVjR2201894
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 11:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wCHWzHMBYLC5oIHSiuIaJzKU448vWHYxkzVR50GakCk=; b=lhXnytXDBomRVi5N
 B8uWtpFK3OLxc/i6rmBSnSEhijKn8z03PoY5wyF0BKReeyYxvEGxkeuONZuZ42Gp
 PmBu1FFrjCy0QDLW689g4c2roJJEmzSHU91xlXLMGDqSoUJjDszqtgbvaKk3qKyo
 JiNCFZR1Y3chQSTfN/T9+R701QiXxDfdrI/nK9q9wNFxvJ/RHb8BAGpov507Wacu
 nuY5oQSCdYeH7tmn5dd9LPLtizfwMW+FkkKl899Fm9y+OGMAhJBeOpT9v1xilf1K
 qEBrkzeBlguuznoYDWm5adKMYacQz4TQ+yXlV3Va+/y9susfj0pjKpk+3KBnkX4Z
 yRRhNQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r3g2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 11:28:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-943fffbc5dbso65958985a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793705294; x=1794310094;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wCHWzHMBYLC5oIHSiuIaJzKU448vWHYxkzVR50GakCk=;
 b=ZUULzAcrZ7rcGE8UZLpE0ZttOJDoguXo7i0UPEvjxJOj2wwqoLZzFs8GRm9qBwSTMX
 aFTu1vQjmKmFFBryvbrK+PNXnt5pQrJkEHZu+CPwfDyi+FzGmUHPkU6glx9DLcm2xtwB
 YUIrTJN71G0U+NdslzBbpKWPCcJ2w64FncSzByDZ6Gszyj6tRF8EKw8irG0kjG2EDsyH
 4MclyY/hcvUl7oYkfwrzo9ovR9eis5MyEcDn8EddLa6JYgNF5HvcaaO9XQBfhhnSh/F8
 t9C+cL3uVSEGNirGvRPYGXt9U9hBZxcsqELUgaOUVjSbuMdj5miDVeivQ9ppH8U/d/eh
 lalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705294; x=1794310094;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wCHWzHMBYLC5oIHSiuIaJzKU448vWHYxkzVR50GakCk=;
 b=HdelJV9LPr5SkO+A8qSrYPNtzhPP4VRjc6Qe73PJCk0Tsi7ylSLfeZDKJTFiLAhLRJ
 g6hGRiXOPlj07dhWYB2XXz6TWf8M4nZDLV525/uOn3M8j0sPYQfBiBVe9Oq+DSH2ptmI
 KCYpsAFVRV4MS+2EE2Bfiz7zgmShd81XlDX1DDq5EY3UPduQ/nPjKbzrr1aerxgS6pVX
 2ohojMyyrC14qmlhW5zMH+ZwaVk+1U50x/69ATNeWBm1797RmduT8lfX9QpTc7ADSv9W
 zdFwFNf00DbkCKHXfINtsDJj8KQmnezQaYhBLkDw7RTDcUZNsrc5fhKj64+Ck0USH/pw
 Ao2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBybaALE9Cuycd4XkyzT+jylInGO7jNOmo7Xjwe7olvfFh6+wCsgqRKwg4EK6HSOAseRiFdAMuMVm4Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+H1zU80pjnJrmJPjk9TiDD10ihqayUeSpdRL2yC3N6wExp4nIn
 LMBnWG3s3Kr7meJ/q9ipO/HUqbeT4iXrhe2Z1j67kkbt3JVZcESMbNPFiM7kHWODbnj+6YsKMg5
 WiFkTvuZA4s/1LR5Jsv+gB5F8b0Q6lpyWN8iZK4MRAMfgpSVUhipqaw7zCNCax+MzLiVFd0I=
X-Gm-Gg: AYBFou2GNxedmweoW1xGQ97QWoazBiXQ+dgkrQR26jPE7ycPPnikC/I8t8snFCTF/vP
 IcUq1ilf3IogVH66ieYBoASryQJzf7Yqm4AWOB0kXqcSheLDy7Hc9LVFyVjItlfuq2MaczHPVm9
 lLgEmq+gPLLU9XDQ4VvE1fCM7LwP4gC7HCbcM7Z3E4H23wbgqT5Ew6264/fBnDQSlPfn3NQXGdI
 A0IYBSFX+p0mzxumFzZovvLsBt6fbsrVFYcGY/+GuM1E44SKYMoxIe1kZ46/N8AcewPLZGve2HI
 rMyfJjaWyzUW+Y4tww7suarzxde747MLdb4pTP/eazsU5kPovsv0ejQu3D0guZ8JUDAAQIhC8OQ
 Id2mg9G3If52km5SAecfnVxx55of9lLgrylRUR85SyhYM4llQvuIZQPvM/rZNkndN9F903Q==
X-Received: by 2002:a05:620a:6f96:20b0:93e:54fc:2c79 with SMTP id
 af79cd13be357-94421878c51mr1995201885a.5.1793705294005; 
 Tue, 03 Nov 2026 03:28:14 -0800 (PST)
X-Received: by 2002:a05:620a:6f96:20b0:93e:54fc:2c79 with SMTP id
 af79cd13be357-94421878c51mr1995198185a.5.1793705293550; 
 Tue, 03 Nov 2026 03:28:13 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebf49d25sm76802366b.62.2026.11.03.03.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:28:12 -0800 (PST)
Message-ID: <a4151c32-bac2-40ec-86f3-59d4dbfaae62@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:28:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-4-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102190010.720443-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: L8iDKrCkLbMD3Y1Et_kioQkLEclvwJWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX4kP5l9EN9M9i
 6kV5XxfT5aMKkXGP1m2wi8uNDL8ZCFSTsa0agB1RIKe+E5eIxCkTzKw2rhtDDo9dI34gIKBZe26
 X5HnQ4V5v/epHp+tTLFpAFIxyQHY9i2Aqo0nNpEohvZvB/+kgHilY8U1AeNVaElUmPXkMisPnGQ
 H8AOg1sVPnHyeupo+CFEIIS1EwGpWxwgHDD1OQLt7dEwuBD0QzWoKh+mkLhAJEsCrcTJ891Bp7P
 hf4pBahHfkvqXNxQ44YOr9z5kU6ap70PuNydXUA9p6ATJxTIWagjpv4rPeMBujGOt568LlnT8PC
 vOi9v0+eIrxBd3Naw4kHDNmDGWGm92X8KWKeTBQ0/U6/6192cuLChhiKgFipV6qy1z2Q7PHwKzB
 hbIjh1ijvW7LCikTda03HgLCQUmV6ZO9j+9Vt52vDtH7xjUiMXLieR9jkFnvEzhMCjsXuDy7tk3
 jffndQISN2pES6vpEmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX74+AA5I0ivPt
 bs3NKsgxHpLDlcNYntLqvdtkbp/g0W9qv538yx91f0AJv49LT/YDvZwDVN9eOgAZMrUwuX0x1Of
 sa5eOFX2pz9zwDdAwre1EwMkLHYAhWY=
X-Proofpoint-GUID: L8iDKrCkLbMD3Y1Et_kioQkLEclvwJWb
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9c54e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=7AxDZKSYRuUxSVEY4VYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 8:00 PM, Rob Clark wrote:
> We need to move the gpu lock around a bit for the next patch.  Use
> scoped_guard/etc so we don't have to make the error path handling more
> complicated.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> index f12701e286ec..aa59b28a3392 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -70,43 +70,36 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
>  	struct drm_device *dev = inode->i_private;
>  	struct msm_drm_private *priv = dev->dev_private;
>  	struct msm_gpu *gpu = priv->gpu;
> -	struct msm_gpu_show_priv *show_priv;
>  	int ret;
>  
>  	if (!gpu || !gpu->funcs->gpu_state_get)
>  		return -ENODEV;
>  
> -	show_priv = kmalloc_obj(*show_priv);
> +	struct msm_gpu_show_priv *show_priv __free(kfree)
> +		= kmalloc_obj(*show_priv);
>  	if (!show_priv)
>  		return -ENOMEM;
>  
> -	ret = mutex_lock_interruptible(&gpu->lock);
> -	if (ret)
> -		goto free_priv;
> -
> -	pm_runtime_get_sync(&gpu->pdev->dev);
> -	msm_gpu_hw_init(gpu);
> -	show_priv->state = gpu->funcs->gpu_state_get(gpu);
> -	pm_runtime_put_sync(&gpu->pdev->dev);
> -
> -	mutex_unlock(&gpu->lock);
> +	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> +		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
> +			msm_gpu_hw_init(gpu);
> +			show_priv->state = gpu->funcs->gpu_state_get(gpu);
> +		}

My clanker tells me we can't grab the PM reference before a mutex,
as the recovery mechanism depends on the rpm count being appropriate
to let it drop it (and kill gx this way)

Konrad
