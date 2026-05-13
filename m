Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F93CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E2C10E31A;
	Wed, 13 May 2026 13:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKTdyeLJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xouo/WlF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F3110E31A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:43:47 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DASJsW2321285
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=93ck9j7UNs5qr5E3FjJPwBNZ
 /eteNwvkCjcQtHOmT5Q=; b=GKTdyeLJMGh723ckJK6vMuBtBcPoCN8ZP+cz7YIB
 KhgAR6DLAen9msftylz0koy81NDcgaM+9t1TUWDFANfMlHogAvottqN1dNBiTwX1
 HiGe0tv2KkvTKWdoD8iEOpTI2ydjybUpNUZ5+RzLe1Zgaat0javeNzqm0lrN6jqm
 D86Kzw94NNirnYqxNYl3vNhG+z1KmmoH/JOudZF2/n93VyPg8Il9flr9t9uNzxzF
 7Vszsez/Y/iocYGv0fYzZrhosxSKXeabojatqrMw6XEx8w52/OD4xXuYS1Sk6qY+
 r28oZPY4Vwm9xXaGrZlpuSlStvlhBZ26VbDT6q10XzYwNw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgua6fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:43:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5163ade1583so6024781cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778679825; x=1779284625;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=93ck9j7UNs5qr5E3FjJPwBNZ/eteNwvkCjcQtHOmT5Q=;
 b=Xouo/WlFilOZWdBneZ65zkDrmeotJqPgqbEf4yhq2DHgqGDI/BZbw8/zpOSDS24hiR
 DMbzBHHPd16mNpAgKOVvynSt6cdB+LfqP1C43EzoqW9wWjlhfI/4u0Q1rHvDZFXkuElb
 rELfsjlG2BNEIoR2akr0/vxGCn+Wc2QXlTmkSsWsSQ5IOXPGVkiOX0zUOiyuJcqZqh+3
 ieANFhDXz/1XZVekV3n4n85+YXu9Xke+WejWYYr+1hB7P8zSUIZZtLzUkeDeW046DAQD
 d96yzrTjqwVpJPbQwkEk1gA2Bo3Pa6LIdpObkjLixpq1Hspa0rQtEf+A8nO1gCKixTOF
 5Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778679825; x=1779284625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93ck9j7UNs5qr5E3FjJPwBNZ/eteNwvkCjcQtHOmT5Q=;
 b=hZdNcAdOmh82OBNiZQSVSojUke1Y1F0RxGkcW4NtnU7K9VeKAb6yBAFfcb/GeZ9fSQ
 R1ymazojrDQlYY1+5k9lauyhiK8RPNIIk/v+U96NVRH07yoau6XoKEovnCMNojEwp+H3
 eJjhN1LPoJzS05t1Yr41GnZ0rpIejXYhBKN9YsRTvxqriiKHVL1DHm/09Uj4N9EnPJqK
 PXx87MfII4wOx8qtvBywgSdcwOxn33iNHM7iSpP/W5SZTDwHOyEtPO5LjtQcmi7FLpYI
 fzKbiHmZjRE8bsXhXGZ/aFNOcBskXn9NhB93x35QDUwFrRGYX4dWpYPOLfSN9v25WXHJ
 weZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ93YIS1q/jrLrD1O6fkcqwvHDNacx4g2YAepnWqoU+6t9VplwFp8TnX016LecSI5zUl0N2J6M3ppws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzvtIUvUbUeKqik/AZdlxPx2OkEhP6xLw+DmofSrwpF3FSQlhM
 T3JrpoA4f1pRY5CVPWjqd1FJSw7POHWhZzgt9vacUfzSAtfHGHGMoOP+3oATqpI7ipm2lLoWB7B
 ArYtkJYpsHrYIYABe0wy/ZoBRx6P9gbT3ZhBx4iAThd35OjyrTYDLlROiEdkBc+lwVYMNrFw=
X-Gm-Gg: Acq92OGDhfu0trQmganrjfHG+9aXT+5foCof739JB8+OzgKFkka0ThN4HOyyZlcjQfM
 T3XR0RD/mlILKHgpuzheAZtAowcAVVEEynx78h33FR1XoI2JVqGvRSoQEjxaMiInuBC32UKlEbI
 GMgEO5K+O3/+r0meWD20fBadWF0PuenMkCMTrJFuTu50GfLpCaXMpmeplBZlj4rRQHcD97z20bw
 PsdoOMWN3qCOZgzx8WCZhk/3Lyw8F+3Mrq/woooVjHtmJfW+1JdG/d99CWjLCeto5R3zDt32wTx
 yM6Fb5XrgVMpGk0Mhw3cFRjmzCWAxP8zXdhM778xraV1FNvY1gUKM+aTkJ5KP9FdjhZkRfhoYJS
 iR2kVooBRQ2AlNTtPFuRbo/6n8YJI2oeMeaP9TDlw2cdDVMHPFzZ43MyndiqzKPPQpPnMoVVGY/
 BUOpIbRMkuLGre2CJCyhmdpEMq7NFheGJM1L4=
X-Received: by 2002:a05:622a:2618:b0:50f:b3d2:6edd with SMTP id
 d75a77b69052e-5162ff42a2amr35469611cf.43.1778679825222; 
 Wed, 13 May 2026 06:43:45 -0700 (PDT)
X-Received: by 2002:a05:622a:2618:b0:50f:b3d2:6edd with SMTP id
 d75a77b69052e-5162ff42a2amr35469001cf.43.1778679824731; 
 Wed, 13 May 2026 06:43:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f61078cesm44278211fa.28.2026.05.13.06.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 06:43:43 -0700 (PDT)
Date: Wed, 13 May 2026 16:43:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 8/9] drm/msm/dpu: Add Milos support
Message-ID: <2xj4p5f64gh56nqzrpskgmlgap42j4hy2yffegextu7kqscfxc@cxido7bjjrrc>
References: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
 <20260501-milos-mdss-v3-8-58bfc58c0e13@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-milos-mdss-v3-8-58bfc58c0e13@fairphone.com>
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a048012 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=v0oG3mRxo3Z05cs3-vkA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: Dcctvsd_4DLMoOGjFCJfyK5Te3_vgacj
X-Proofpoint-ORIG-GUID: Dcctvsd_4DLMoOGjFCJfyK5Te3_vgacj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MSBTYWx0ZWRfX8iLfdb/WgDzE
 P5YFn6ec5OQAXE8QIuuF+y3yvp5nsYM690lLDHZYUBTWzR/YP5kCIOgU2NYedpZBkwt3Eid1uww
 BtDAx6I6k+NGsOPeeTZrFH4NakJAoeqfoKkvu2sSlIDIMBmA3vzz5Q1Ej5WhCnRBRuI9aGXblMW
 CjlNtZKY5LwzDQVsnLDgzQxjPUjFEyQgrA6MITmrO1Pp4LO9jd6KvPU5137d88LdQJQaP/nztEF
 SOLdMMQCjcdkGiKvUQSI/HysalKgL/Rv3ZqqTKFziFCiuPdjcHlxpW6Ngijy9SpCNL8RMEwby0r
 WLGvFczgWfSsMnT2f3LaiwoLYlJ2mH88njO4N9A4RtIFFfbOkSqn/XTij9r1hnml1nzkBv+guFs
 ZfqrpFJK2TeUeL43Hu8LvnGpT2irNo1rFwMFkJGcPq/3r1uvhvroFs9lM4dV/IWLNjJNh8N8w/q
 LcC4+QRMD+8PIpWnPXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130141
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

On Fri, May 01, 2026 at 09:14:50AM +0200, Luca Weiss wrote:
> Add definitions for the display hardware used on the Qualcomm Milos
> platform.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_10_2_milos.h | 279 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  29 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  4 files changed, 310 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
