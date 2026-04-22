Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB2FA1FC7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D19B10EA5C;
	Wed, 22 Apr 2026 15:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZafF5I3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gj7tj9Su";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6430510EA5C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:47:47 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFfQar2956335
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WzmZNY/QWu7q9lAMq0biJox4
 17hyAsUwXK8QgETcJzw=; b=QZafF5I3B5usDcoJQBU3RtajUWN9T71xAi7lghju
 2Gu70D0qKkev97Ck16cp6q+8J/cvpX5O8qQaZTtVTZoBqvtTguqcRzsCwUJQ9SwO
 va2g27/HkWo1+5A+u/Tpe1TAGRxr+zyhYvVZ0JyF3y5eCeoSrqT21Z9X5mGbW07M
 3sEDuGSY0KtkZX0tEnbVi6TEobtKfMYLginipMCRGMROA275V7j1YjeKx5xAz0oy
 6VyMIUHJ92ydYJ/QdUUX7xxe6LPZfu4utRZ7uNIQI/rMVJDXS8WGaTA2iJPEgpMJ
 Rd6WNd8XzbXzWmzh+jkUdWNVSa5UEabqg7Lv7PaKuuC4Vg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16q00nj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:47:46 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6102a8e6eb0so2942542137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776872866; x=1777477666;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WzmZNY/QWu7q9lAMq0biJox417hyAsUwXK8QgETcJzw=;
 b=gj7tj9Su045R21SI2/D2ATT/wVqClxdaDa9heDrAVDmJVGrc0pkQx7/p/wiacPBW3d
 iHICLnrp68dv+MmNmRw520PjqNy0vZ90UMFHu3ZXnG1KUv7/r/c/oy+7/P0EdbdsQLrx
 n73I29xL6Di1lddncOHZGatErIsJsv1NOBe9xN/XJWJ0WSw16ftr8Oq3+IMHZrRPFC38
 VXqrUeLFqjinXK96IBoZG1+d3BarC8efcZoPyEa+yp0l862WvW1Ti+SNN8wpHg5Z9hna
 haPUkp5z4z64UThmUStm8tMzey+nYIZ0yZPcAEfg8W3X9uWueC8tq8zgoJATXYr90HVC
 HKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776872866; x=1777477666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzmZNY/QWu7q9lAMq0biJox417hyAsUwXK8QgETcJzw=;
 b=AIIUMpTAyR2ejon1amUSFSp94bZNjkzBTmDEahKos6LNNdCwL8ZGKTTWcxyxRolrft
 pylOlsFoU6aT8P9JaNU78z+fNxYM70FoAa17KieA6f5LnZsxk7QHy1+AQ0LD615Ma1Sm
 VQt1URADPpNIH0aYrbe1lSrdWkd7VHn85uI4zZRACBzklyJsHz18oPWqHc65IMkH0rNL
 Uhc7sXc/T33esDGEy0eFQ/rDIGE8TmWtoNSOFzEinA1VludpiaD9HVe6rcHALIlpKR1B
 /RjVa5GJxKfhOQfXZ7IL0tdTR2+LMiQREAWzF7UPQ7Jf1f+sLigDKugmuEAKqc8WkZ9O
 n8HQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9q4DqBQUvQ0lEmz81K3cXHWIGEqfSjYpil+SZgKFs98faopuqQhI9yw25K0peki3rZpo1Xfn6rfNk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzuxw8WQXtE2drYx5UA7FX58lGkufZSkwwiyTpmJXg19y6KEMcg
 Lm2hwG0uoirXrFq5+4+kgN38jBCz31KVxcXSr5yH6HwCfp+GiGA16tPUHrVJOZJ/S47NFWHk+ea
 w7fLc9fRCiwWaT59/VrGnBNaM/STJ87a9X/9Nl/C9Lur3iY5/apemnwvN/NbcP6XTsXj22gs=
X-Gm-Gg: AeBDiet8YoTIUupILydxuSD/X7zezn2L8pkfq1+c3s+NNHZYn3O7toI/9MtftRwgTKr
 tp98xFQNBFnReau/VPMQdY8jsgry3o9n/JgJl+1j7sMjJjgBTYZci3shFfMNX7MCqCY/mPcZlum
 6xSoRdVi/y+ivtFGQoefv0EK1vhaQA4Gzr8T47OXWCR0oljeM31mLuR9Cl4NhgveC0T/BNYnx0C
 CPWDmAEk3/F9OTjgXBa1DmWs3KnGfJsUwIJRNrQMd4Efehs/v2L66NXbJIJPXwnbDIH+Y5eYi7Q
 tnt1Fo6iuvWX1NePgJ4GV7vcXQ5dPywQwLgHkp1O9yFzR8xwu/QGJcufTZuNgHs5pAOHqGvghji
 0OGRb3xGtABFIMRbtTE8ODAgnqID70lBRoW6M5ClwlR4kf5w7yxlztVrdssavz+5/gHb/VdoVoG
 t9/YFuj3K8+enFEJTkuw8tUyw4PzxBboIHk5ODTWZ1unrEpg==
X-Received: by 2002:a05:6102:160d:b0:605:8143:cb67 with SMTP id
 ada2fe7eead31-616f7c513dfmr10283143137.20.1776872865798; 
 Wed, 22 Apr 2026 08:47:45 -0700 (PDT)
X-Received: by 2002:a05:6102:160d:b0:605:8143:cb67 with SMTP id
 ada2fe7eead31-616f7c513dfmr10283124137.20.1776872865367; 
 Wed, 22 Apr 2026 08:47:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0b7bsm38581791fa.23.2026.04.22.08.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 08:47:44 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:47:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: Re: [PATCH v9 2/4] misc: fastrpc: Replace hardcoded ctxid mask with
 GENMASK
Message-ID: <uzbbch3uwvqszhsp23faj4war7ksxfs46ubmzhirnar7qofokp@bni76hd3j6hj>
References: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
 <20260422092409.4107093-3-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422092409.4107093-3-ekansh.gupta@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KPNqylFo c=1 sm=1 tr=0 ts=69e8eda2 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=P4vd9y4SQzVKkZbYo54A:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: Uz7AUyWhlptFJsji2h1A-dQWp_gABtgY
X-Proofpoint-ORIG-GUID: Uz7AUyWhlptFJsji2h1A-dQWp_gABtgY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1MyBTYWx0ZWRfX0GnFnOPt+Kxt
 MdkB7FhdyQ3nloYFNOV+/X0C1bvncXNXNAfqKW7nqBEQjaSCo9aexnlNF+VxJuJ52RvQMxh5d3W
 1KpQvf0hbfYnvTTafNAXgby+5eLQG6w4XfiDZ6/P0KTPeOPNzP2TPDHmaonf1J1T4EI+POxQJyx
 3y+h9hRaGmcbMCjxLNaCXiVYLKhseGHRh/W+C16LQdL+FOy2emE6Z/fOdUnSF7q7gclnQnxfbnj
 36lq/+kV5WjlLSroP/m/s4//Hjpaj9ubAvgCr4+6wYbVwxfzC+dyxzcWL6ojNodX9l6zFxirEZI
 Yi5Th2L5QERxlbJGsq6OJLBtjwSlQwWTMyYQCBaBqA1X3xibzRB2ejtXFQqgPs76x6j0Hd1MHWO
 WuRIkCt4mEBdy3CmVDwCryJQ2ZH7hl1NmyxBzqgdnCe4ZGUh8pKZdzLLXOItYik+ZKdkZjwF5CG
 Sx8O9kyNrqlIXIrYvPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220153
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

On Wed, Apr 22, 2026 at 02:54:07PM +0530, Ekansh Gupta wrote:
> Replace the hardcoded context ID mask (0xFF0) with GENMASK(11, 4) to
> improve readability and follow kernel bitfield conventions. Use
> FIELD_PREP and FIELD_GET instead of manual shifts for setting and
> extracting ctxid values.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
