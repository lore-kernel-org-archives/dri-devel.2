Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA709F3ED5B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36CA110E064;
	Sat, 11 Apr 2026 17:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="endvdPcA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h2phUo0E";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1546110E064
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:41:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B3xq8X516238
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VbrysGHXrOK0inQpm0qqZpit
 aC/Alanu0rIpTGm18oE=; b=endvdPcAJwHVmdw3GoPRMCcpfFSUZh96hcB20hFj
 RYplqFyJBBPY8E1bxdAMRGdfo5J+Hd4oQ/kSuyi9Ww9JoZPknaPkZnfl329kKcgh
 W0226fEBjfxzUwPxAGq3iGYJzIUZAweXSMlA6m6wpUHepqcvq8wwOt7K3AKK9nPL
 OQrZ6QSjlQh6j3+OSBBB3kh1rvGptrELEdTz/wdglO09dnhzT9pVnLgAt5vP5tCd
 eBWXNxw1BPNzoyKFtTbKFqXvXnSJVbFU59IRI1z6NYq7Ub2o/KNXZnOGZJpTHxPI
 xYcU0y449yGIW0aacVvUWkZFc/BG+MgSz2R5skOXa5ZBiw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevth5bk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:41:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4661881eso35135781cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775929311; x=1776534111;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VbrysGHXrOK0inQpm0qqZpitaC/Alanu0rIpTGm18oE=;
 b=h2phUo0E/6apsOm/Y/p6mOBjVJafxY4amVqccv08OeuxQ7aADEZ99FQx2J9tLq+JCt
 MwXqIgy9X1+iyTinNspHAmkFOgOI8rh+xLTtVdCzp5KuVngEJgkMI4yMA9ZHIttFekJw
 6jS3X/QOTitpb6KnLI9Umb8NwyEF1jM3Oar/ICFeu+pZNp0ZKmFumDdoXroGuC5OmHKL
 0ewecvc7wl+uduKM0pSFwcPEx0MS6mfXPro0uv2Xp9RXBv3ytqd1Q3bMPzmzafTQrDbg
 HILeNEOloS/XHnQnnzEEK+SSGbu1/CM1TaScshMa2vbm4VXZjpnIBMavltH6QhvQiKIb
 6yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775929311; x=1776534111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbrysGHXrOK0inQpm0qqZpitaC/Alanu0rIpTGm18oE=;
 b=ByepE/6Ec5ZP9g//dDsq+BdaBjJRRxZa4qk+w9kxdO0sHArAL6d2cpwxkcnz8EoJnP
 7EMmusKMXe1bb1YF+VxnlkhrBy2Hw1vGYU5iQmJUhqAFWFJ4qPEEUY1KoCriBfkI9mv+
 Wph26e8KUoS6IAvKhwyykooq8owT6C8VIaHIwikGSRIPPGQCQfq4+9HtHsHtcGI4a2R8
 hUHqLBFNJU5JVEGQjuvwgvso5x4OOL7EREgIULEuhE9n/+7ocatU+t/6kRrL6BdLhOdc
 hqcZiH1rBC4eRGUUdBqyKbGFyd1/V+KmUutgt/nX8fbZuHUm+0/2KIMGQXIAayfV5bax
 +4nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfu/lUeteYBod9gpN3p7JsXvwnQeuFx5EvtqfuojbmNSiQXUWNf872c3/gCBsPutwHI6ng6lAXZyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGNbJIxFM7l1EtcGBBYkQHfiltyUayQh7Qg2PH/8iLU0cQHTyW
 1f4Dmv99x7OzfvI2tKDpX8d8LBIF+AeriwCDifrF6mpXy7ISCgtbsVmXP+zX32RjvIBK6RTzgcS
 5c1m2paAWc40Ky9ITJg1t/k8VBcFinj2QKEl2+FjnHU7kuB9BwP+7C7DUC4spYTpNNhVGZjI=
X-Gm-Gg: AeBDietUCIYYl+bESNWqZdg3QlNezHehkoGzP2HPp8fLUmkl08kyu+0dgoX8ge8phCO
 kxHCO7B0QLR4h7ouXTQPVC8xx05bu5oshb2Zqs9iM0FbCLaoB/ej702g88VYJwbM4QgL1foT/Dd
 0+vuSFCW4p78iUQV4i4bZ3KpZrKwu7O69JTHPVa8fg2i1nPIgVkiF+5fUqAxabR4lGb4vHyGmXK
 9V2J1LT38u6TCbhcDAdRoyJsS5ARbKKB+bRp0j+ciVwbT5Wvc+jt46POmw3Ft5eqtpbeAQSSCLa
 D9OwkKIz1aYGApug2gadgbIz3icA7/rxSoMq91lQXgE7lD598izW4GAOGdhrHiVaVBKJ1MXa6Hp
 UPa6EWk9JPQQSQCW72SF/9sk/3VLoL8pLVvRg5w5Yat9oWTjtzmJukfMI1q1oYKQbv6XlEKUAjS
 K2hgMtoIsVVtsMZ0GJWp148SdvIDeTR3HfAb4=
X-Received: by 2002:a05:622a:13d3:b0:50d:edcd:4f36 with SMTP id
 d75a77b69052e-50dedcd86f4mr24564721cf.14.1775929311346; 
 Sat, 11 Apr 2026 10:41:51 -0700 (PDT)
X-Received: by 2002:a05:622a:13d3:b0:50d:edcd:4f36 with SMTP id
 d75a77b69052e-50dedcd86f4mr24564431cf.14.1775929310909; 
 Sat, 11 Apr 2026 10:41:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49a4a6f9sm12825521fa.31.2026.04.11.10.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:41:49 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:41:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 11/39] drm/msm/dp: make bridge helpers use dp_display
 to allow re-use
Message-ID: <pekd6eojgv2oayct2kwegrswnqs6aa77huyphhfjrsljueim7a@zaicpcuilruq>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-11-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-11-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69da87e0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ImuchgXjfNytqii5F_sA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: e3-GIg8I6x_dVeVjklfWu4xdXorUBv4C
X-Proofpoint-ORIG-GUID: e3-GIg8I6x_dVeVjklfWu4xdXorUBv4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NSBTYWx0ZWRfX74xCc+lYzfXa
 UcP4tCAkW/fgFEbnNQrO5iUXC/KWRVhW6toAqTVku6uqeP2+srBgHVNzoEVimzh7bsS1uAg9Dk5
 9CNkyV+b5s40Z8jE9wZOI9qHNEIhxg2ZoKMZXOUcvFk8AfhLVgZQBo3mLRPyPa77xzR2MXx2dGv
 RV1i3F/Vwrs2nLvpBFhHqCShEfvddsgWUbnLv7pOn6wHFvMFOemzs4Eeeyp7xEvNvjMXK+HdMZ1
 ASv1FcRW5lpIGolPgxDTYUS1kNrdor+3rPuDde2Des1mUxy56uXbaab7bZNMOXOXhKfIMvWU9yl
 Ih5tvuZDve4bmk8FB2avL79z47AWK6RRQtHcNErH6wOIDxM97aw7Wzg5FdYKYakul6s79VAKjie
 +Td4uaS4BCPtlNac4W98hN4m9wykHWPYez5y34Lldf+vX67VvbbleG7mbHIRGuaGRHazFXLhpji
 8pDBl8LTGZwqkecp5sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110155
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

On Fri, Apr 10, 2026 at 05:33:46PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> dp_bridge helpers take drm_bridge as an input and extract the
> dp_display object to be used in the dp_display module. Rather than
> doing it in a roundabout way, directly pass the dp_display object
> to these helpers so that the MST bridge can also re-use the same
> helpers.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 29 +++++++++------------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  7 +++++++
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 39 ++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_drm.h     |  9 ---------
>  4 files changed, 54 insertions(+), 30 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
