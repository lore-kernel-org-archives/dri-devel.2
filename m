Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360D8FA1FE7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F3AC10EA8F;
	Wed, 22 Apr 2026 19:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWMMLiEC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5suYGzj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9B810EA8F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:13:35 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG9qlt3173021
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=i5YJWa8cXts1nxrE/5nl8QoS
 F93FWlPkps05wHHpJlg=; b=CWMMLiECv6jt2+JAxyP0chYDGq65LX7qc20Ma0Pc
 UdYWIwlYB1h21EQHeFmCExmLhGp42+WcBH7jRoFF05uQBQOlKdIsdi6ZuDc5I6FS
 KSrMLYlZh608J8thj1WHcILMg1DgLqU9e3uEXM0VXkLznOgYkQJt9WVNyAvkHOMh
 VP9dr/b1M+dPE8OxE9zhDd9E+2gnIiu/KX79CUswzdUM9c0BT/RS3nHj075UGCsx
 EcSgqBFjPJlsKzbmm2cmbEFR1jJwnu07kpEP8zeF9YC5EDFguamKX+JFHVU5h4Wp
 SyxTh72ulpsNljze22TerU+VL8b/BLAJYgIjhRiRNy859A==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1m30me8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:13:34 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-953cccadb32so7229541241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776885214; x=1777490014;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i5YJWa8cXts1nxrE/5nl8QoSF93FWlPkps05wHHpJlg=;
 b=N5suYGzjHAuSNrEuJNrDuiDxJGGZzW3kkLcEtmQMMHgkWxyxC0OWF64mEYHS55BnQ8
 pqcrsc74h+FR9djOLjjLOI8HsZfamaqt/282eSPFARvMVw87DBBnIR7EVgGylEQklMJj
 QLGY6ROJyYVuintr4RWVfa0SUUyu0b3HTISH/cKcdqdS55Wbs/dr5cLFIK4H5hk8UmM2
 Fb6Yg4n04xaVIYwWQCkjEVW/MXsRMDioaTqbsgD3HWx7MIO+P/ig+m/AoBtUCGajQngA
 bgchoaIFKAvjvdNkgGvH17K3vRegpMhhrwhR9ixImuBfFoZJEbeZqpB9RGZVRATUogZ9
 GmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776885214; x=1777490014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5YJWa8cXts1nxrE/5nl8QoSF93FWlPkps05wHHpJlg=;
 b=pO/XUAurZAlzVYi3du5xp5ouTzAx2jwR6jk5vXw3nXyhkEn6WlmhEEdf261BzhZfcB
 vs3+97ykH1EWyLVzV7DC1a4CXmmygi5ilbzR3QOjnfCxN67kSGyMtV3HwK908cM3fK2R
 buDCdtjlwkdkHRjjccYFfrqsLZwflEYCVLMee0kFobdIWYAbZEbdDxJopnGUzmgAHJcK
 vi0ahMZnYFiTXf+DsRRDZjiJkvRnxFfLQjMMMAKwkP14R7ES7W7GK5yqQ52+dduSrYYJ
 pK853jYhFedNnwa9D5aq9EO2BpkN1pd/OlH+ujP4CCIiaTVFVo9JY1Q/wCw3MH9RLU99
 OZhg==
X-Gm-Message-State: AOJu0YzR7HbVKSYEJhO6kbP3vmxYTqMNUYkdbn4jA592qrD/S7+UdCju
 KhztK1iRHxfGF1VpPUuRfE+8B8fe93qowy9eRYK8CgMB5YkD1vQzjOkFhnadpkJuTOa6evdoUz8
 Xto1ksNh2xJbMnRVRsBzNvB+qx/muJhTFlOHR3PnaK0w3GfgBqzMuHQcNuHUttWC1/USv4oA=
X-Gm-Gg: AeBDietgJabUM1EnSlLBNr80O/haqN0dHAw8P/7Iisz+SAfU7VmOhXyGWe+wAhKDBPE
 4u1Itz4IGuW+4IGib8QhLgzW/teav9RMs1e+vZ5CsVOBaR+isD9jYsWNefxcqb9BnNYOXk+q4cF
 rep/mB1FPzaeEpetnuThRIvau17wVYpbQtXs9JQbAUPPIS1H7MMSChOMYuVY7uu8DCQqefIiWtg
 C7mQPjkWs+7K7zBSt6BzMMjI96bDF5bN5G5bJkdhKxSF53G919h4ECDYnGc8iYTnIgOt2Os16Pq
 0Yo4c/xW1ftxa4HtHOp30nF0Y0hq/0TQRTnsUKnu+vMu7j//huf1aWlUfm252b5QAABRrIav/UF
 0y55cFN2arPlsfC6qHdV6uF0fYz16lDRg0ML8wdxB5ZJ+JqI6auTWwVlrFKwXnYHXK8pN+ZE/gX
 dScO9oUQKemUpS8BNhK0ySlLGg7xevoVRIlKxDaYIrVn1C/A==
X-Received: by 2002:a05:6102:91b:b0:605:315f:49f7 with SMTP id
 ada2fe7eead31-616f4538203mr13198704137.6.1776885213542; 
 Wed, 22 Apr 2026 12:13:33 -0700 (PDT)
X-Received: by 2002:a05:6102:91b:b0:605:315f:49f7 with SMTP id
 ada2fe7eead31-616f4538203mr13198668137.6.1776885213017; 
 Wed, 22 Apr 2026 12:13:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad0adsm4666283e87.11.2026.04.22.12.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:13:31 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:13:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org, saurabhg.gupta@intel.com,
 alex.zuo@intel.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmerman@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH] drm/auth: Only drm_drop_master if it exists
Message-ID: <v352ddbainho63kevtsaa5ijthgrlhwlawqpuoh4oob7m6644h@432qcnxumfbh>
References: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
X-Proofpoint-ORIG-GUID: lrN_Ock55P0BzizgODJ7QAWVIMAFAdue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4NiBTYWx0ZWRfX4wNvGmT45W0q
 EMCINXKnXPfkMT+a768kKmrg/ldtrvZKqQfqFvn/3dNxmNIxqygYcIrOzvAe22k9XZt+/+4xryl
 rs6SsFODM07pHaM36zATorF7n/3fnQPj0dW812xqSlmswBn/CMsbjG1vJfitYYntqGfBn328tXC
 qo7t95avgt765VybZHCR9Gh0+pVVYNsSHNB1YcRwSQ5z9l3Vd5Hsx365yPps/98A7MnPiafumMx
 WozVuAEouUhSQd/+UQq2S1rRb87gr9wk9nSW5MbWtRmu7jyK3vlWWNym9gZ4ZhW6dFV6Iqeo8rZ
 y7FhYXWooK1CcN25CONI7kDaXq0xRfpIp/y2TJ29CA5Dxbr+Zu1OjH/JHT4SMIfOlZN/cdjsC/G
 2zMG+sBHGahosHNz3YaXp97AAJFGcCPH3WJx9HCF0fMlo+YTno9FWaA44lloYl04VBUeC/337td
 4GE5XWgklAK6VoRMppQ==
X-Authority-Analysis: v=2.4 cv=PsOjqQM3 c=1 sm=1 tr=0 ts=69e91dde cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=5NlAK5Dl7Ha4t1l6zzEA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: lrN_Ock55P0BzizgODJ7QAWVIMAFAdue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220186
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

On Fri, Apr 17, 2026 at 05:00:47AM +0800, Jonathan Cavitt wrote:
> It is possible that both dev->master and file_priv->master are NULL when
> passed to drm_master_release, which would result in dev being passed to
> drm_drop_master (as NULL == NULL here).  This would result in a NULL
> pointer dereference when passing dev->master to drm_master_put in
> drm_drop_master.
> 
> Only call drm_drop_master if dev->master exists.  Also, make sure the
> original calling requirement is maintained (dev->master ==
> file_priv->master).
> 
> This fixes a static analysis issue.
> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index e17bb0f1f9e0..e5013b870ba0 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -347,7 +347,7 @@ void drm_master_release(struct drm_file *file_priv)
>  	if (!drm_is_current_master_locked(file_priv))
>  		goto out;
>  
> -	if (dev->master == file_priv->master)

The previous call checks that file_priv->master != NULL. So, at this
point the NULL == NULL check is not possible.

I'm sorry, but this looks like a false positive.

> +	if (dev->master && dev->master == file_priv->master)
>  		drm_drop_master(dev, file_priv);
>  out:
>  	if (drm_core_check_feature(dev, DRIVER_MODESET) && file_priv->is_master) {
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
