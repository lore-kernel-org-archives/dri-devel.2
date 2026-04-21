Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C051AF8FA90
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A80010E8F9;
	Tue, 21 Apr 2026 16:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mYzbPoPr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VHAIKibY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F5410E8F9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:22:21 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LCXcRI3257301
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jfXnen7U69qkupYkJDpGagy0
 EqslxjpwMG2ZX+ZP42k=; b=mYzbPoPrhwbqYd6J07BMSYvmfyBagtYAvrL4EM1n
 U7UumSHKuzVhEza0KbDNmdXq3Udw3FRIiejRCBrqQethC+3KQf8fEWgeF8XyeRio
 1Onl5/L9fz5l81YDMzlYpx7sBa9TNW2hwjRTbyQ6dEB18C+gfnb4oCXgd7uk942C
 0WvKgKf6iXPo7i8+IF/QuXqAv7fQRCBegyI3RFM2ect02m/9Pk/7P4BQhZDGwfnr
 S4C1a6ygSn9BFtoM8/LaWgmeDOzk0LUNOB4iMFp5x9T+th6PicDpVUJfe25kxlWG
 cnirAxFWym0c2FhDMADFyJsIXKdxn9K/CxAGvctitfvClQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp3naa6at-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:22:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so118767111cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776788540; x=1777393340;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jfXnen7U69qkupYkJDpGagy0EqslxjpwMG2ZX+ZP42k=;
 b=VHAIKibYfUsoIbvsdJsjVnZt1QJ90buOfwOyJUxbO6YVM49WaZF73edW0IzmyZseNv
 d5H9AKtz3563Yd3xBjaIfKk/A6wnl/dr6wmta46NRHCauNP+A4uJ4d980H1MQk4rrLuV
 5yl2GyrpIrU3SQx/vMdkmEqWNMZEJbT4no208tHHE6fxePSjKNw2EjwTSXM3HQ/9n8Sw
 yhx7e3z7UmK6VANwhE7HO/Ck7+AjwmO8evPvfEUbW6nirY4CG16IHoTx5QL5YLa6TpZF
 JFmCqhMLeJVpyPeGtLWR96IQVNu3XChLhyYAJP/jMomZuh72tcNzTU4QuTZFWye5IfJe
 CTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776788540; x=1777393340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfXnen7U69qkupYkJDpGagy0EqslxjpwMG2ZX+ZP42k=;
 b=rvW0uAaDBpZyFysdEJYyIJbLRRl+gGRtn7Ru36PpQbf/XdhMOwLG7Jpy6zhLVbCtlY
 r9yaJvp319di8a0QQeZ8q96I1PIv2KvW5hxIttC7ObSlr3zy3Jr2lKXzlurBUeIUGpmh
 agosnT69idnk3EeVlPusX6mQrRlODZ5iLOFVd0WgZ4MJnS8talQLdHk3ufO/fXom1Mzy
 a8bR9UEqluoQt2l3w8fpfYNQ2joWIGQXOo/KU6Rr3yXmNdoYFGM+V8rijNMeL2lq2GaS
 QWnTguVG3woUCUtCZRbJxYUjsWsS0gavXCUf9R2iD3iLsbSQ8BI05DgULyb8xawglW/o
 yyFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99wE1tqXvB93fyR7Kk67tuWFLKcyw0JFYywxBv4fVRl1RCcjIWWj9VNNjxsxsYbmWQ+pMVSG7Nxno=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXeCifjGnLNlOwKUEg1fEh5UM1qhEjyEZFAceVDAo5w6r5Rb03
 GegAFZMjvKNHmbgnNVBOsI0rRn9mTXKZEV9pOsh9JImAQqrF8S/d3FbCgcSoTP0kKz25E0wSnFw
 /B0YrmYiuOgmavJyNSuUqjEYFfBZ+Y5JoVpKbq3a1mH3PiMZXvF4wjTYxfy7Cdv47DsLLKBs=
X-Gm-Gg: AeBDietl1cydyqjRcuLAuSyeNyCy38Gh3+kHnm9DXzWZrOw87cZ+s+EmEqxpPOB0/SA
 q20nNoyEt0HtpK0bZHtVurK6Qxwo+eABH3UMfHKoWVvRvMK+tptXgXBof5g47XsLrMuzQvdGzZM
 NGu4h1w3FdTpPZ1ySx8eEb6gGJDdxHuKXeVKNBFAxz0lvK4Qx+giXk2bahgWy5XKFBMVifhR7MO
 5O/hNXXtPlu2VZF5fTakTcPjNpNCzA/fJFSjLXgAtv4rDKo5pPqE2SX9tpyGmAkkC5JAeIvL+FE
 Yp9eCM+dL0voXJrR+nxfKvlaHTi3JvmhLCoK+UAEOd6HrmcWafkrLJKkM5IM0+AqLBmrC3vJkup
 MQIvf0s094iu9lVnLrP43UaFyYzYEoBKVGVKfKaHxK5BMaSfr1PNBzgQo+5gU8O03ifHlEW+hV7
 oppEllwm+ga/VvFOZJ1cKoyldCCEHlKfVVtLo1Qyb5YzvmpA==
X-Received: by 2002:a05:622a:2612:b0:50f:bd79:2643 with SMTP id
 d75a77b69052e-50fbd7935aemr12704741cf.34.1776788539787; 
 Tue, 21 Apr 2026 09:22:19 -0700 (PDT)
X-Received: by 2002:a05:622a:2612:b0:50f:bd79:2643 with SMTP id
 d75a77b69052e-50fbd7935aemr12704261cf.34.1776788539358; 
 Tue, 21 Apr 2026 09:22:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e7a57sm3724808e87.57.2026.04.21.09.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:22:18 -0700 (PDT)
Date: Tue, 21 Apr 2026 19:22:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/6] drm/msm: fbdev: Inline msm_alloc_stolen_fb()
Message-ID: <uraxpqrs4fsvtemystbrl3bqbifudd3zdfxzycrc2e52jcefjo@m3yxmehmkt6t>
References: <20260421125733.209568-1-tzimmermann@suse.de>
 <20260421125733.209568-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125733.209568-3-tzimmermann@suse.de>
X-Proofpoint-GUID: negAbZkmoVLZNCqPwp7xinqMZH7Q0ip6
X-Proofpoint-ORIG-GUID: negAbZkmoVLZNCqPwp7xinqMZH7Q0ip6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MiBTYWx0ZWRfX8I7IahPrLKOf
 9JCoTi4hpjJ+sxKReCgm9+eSMTxI4JY9i8wC4jnAw4bPAidcBdZYrXgouCFa6wuzSunOVlhTbxe
 lowqdZhPbtnMxuWKvWXsX1cN2VKNTDStLkLiXE+FtEfQ4OI1UPLnxgRyQ/2xRk000bRbY6FhlII
 oUIeGzXMi+KAEjutn+pTAmaJmBVYTIGMFt3iwXIhXn56crXbaE2dn6dxMalQ/kK4cMbLSn29raC
 JuuLYmlAKRe6h3ae01Wf9DqwZ8qoPACjlN/ioGIBFYLrJv9pLfiq4ZztutA/XNE3WZLe2Fqxtdy
 d+ElQajjYuyxQ/n5w1UYOF9eEYAGqAxhzh2NiDv6xD1WwgX6uxFNbTO3KB4c3C7M19eUpDg2ame
 vyc2MSjjAwK7dj/MJuK0dj9s+z+PSCzxpsVccFksRo3d06BtIg23W3jK/DuP2zvQzMhgB7AM2lw
 xQXsQbc5VvICPErI7Ag==
X-Authority-Analysis: v=2.4 cv=O9cJeh9W c=1 sm=1 tr=0 ts=69e7a43c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=po8OidZPQ8zUZRZG6y0A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210162
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

On Tue, Apr 21, 2026 at 02:51:15PM +0200, Thomas Zimmermann wrote:
> Inline msm_alloc_stolen_fb() into its only caller. This is necessary
> for converting fbdev emulation to use client buffers.
> 
> There are some minor changes:
> 
> - Handle errors for the non-stolen BO in the respective branch.
> 
> - Fill mode_cmd right before using it with msm_framebuffer_init(). Both
> will later be replaced with client-buffer interfaces.
> 
> - Set the modifier[0] to DRM_FORMAT_MOD_LINEAR. No functional change.
> 
> - Integrate the error handling with the existing clean-up.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/msm/msm_drv.h   |  2 --
>  drivers/gpu/drm/msm/msm_fb.c    | 46 ---------------------------------
>  drivers/gpu/drm/msm/msm_fbdev.c | 44 +++++++++++++++++++++++++------
>  3 files changed, 36 insertions(+), 56 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
