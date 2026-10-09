Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1956CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F45910E631;
	Fri,  9 Oct 2026 13:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gZ6qkEpN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A6XUAF1a";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C913A10E189
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:18:23 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KC0e2257077
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 13:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qYYBr2BmdY4zOcF4U3A9MMVD
 JkUDAoza8jdCzVd87J8=; b=gZ6qkEpN/3z0dp4iU/6TBh+4OpMelin21NOP/SRx
 MNxj7f9rZy6MhtORC7OPNIKpz0JZHg1I9i3mtUqbFcWTJLHI7Ojsva5tvjyY5YYe
 Lb673H5g63L1jckeq5bpK4hyA+XyP7tRAflWpb/Y71vJBHMrIc7SMehyyJEvBLZs
 Bpe6xluCmmAjxK7RFkfekuRVqoY1UDIk/2xSvobcp5PCmJ7jC8XP8VmxbWpeNcAX
 e3SSyS/PTEE49G1VR/8XR/5vL+X+sx7n8Uz6ekGflQa94kdQ005deNVvhvkg5/Jn
 ZOrVGikNdxHVoM4cJnL8E925DFF8Y9Fx5bbR+Jw66l+0QA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nuftfqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 13:18:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ea9ea9d13so336275785a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791551902; x=1792156702;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qYYBr2BmdY4zOcF4U3A9MMVDJkUDAoza8jdCzVd87J8=;
 b=A6XUAF1a6uAy8rlX5FWa5r3dHEFnyxJc0uuxFZ8NX/o2KXKmHvxGncCvWwH7V5pH8I
 SP/W9xuEGHIB+P/UOa9nmyHss7PEUSculGQghi8YpmejAcOCTNjwLLQUfzFEnULgYXRy
 jGVaumNfYKkLFnHSLD6q9N2bqAwTkVFbbfum0QKEaCwmVKjgmlMgJprefG8h3vuKNNQn
 CGGfTNa+b3sKh5XggutY4Tl3pQ3fy188/J5/pgFQBMbNrIVIy9XeVY0857DoqNuK3yFp
 brx9g62GHfb6VU0mXoJTPU6UBQIW1XwG/DdCVWqhE6NpIK1pgtKPhIDtuOJ4jDoo4e5A
 ICng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791551902; x=1792156702;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qYYBr2BmdY4zOcF4U3A9MMVDJkUDAoza8jdCzVd87J8=;
 b=klmUji7Sdc0of4SbKszBmHCgzTa5zJ4DEsc4xsLpJlu+AOtHv/9oJ+ruUDTgYaPqhk
 0UGYmdFzLjLfQ4mk7pNGyX8I/vNIdnICA00yOQaXU8NledlmB+ONEIZYU9tIC+np8UZh
 Wnsnwcgq12q1TPlvhb2bqJUm4PI4n7tSqcOv56RMbO9vQg7x0mBgwLuGujl3VeL0hN/6
 /Qf9HNfMXRetzlb2nzvev9DIVlXKqL4v7zYFlJ1WqO/VSM4+U26O1rVr4wOUrQ4FN8Mk
 GHpRumFh+q+RHCxnrZHFTE7/BM8l6rkzA+pmsa9estEW1IfCNS+4w3LGPDtOiL6hVTIL
 NH7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPheQoV8c9tZHrCNA8LlnkNNGAhdGJ/4LWdyAicm/Puahu64Sm6wNaP4VFopKgn48TYgo1oclJL6I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLOU4KIlkfRBK67k+wa9Fd0liuCbNxhd3kY8hz2V8PWFTNAQ6p9
 hVDLh+GBqO2KLcH6/5obAj2F+IEtpopSxvJHpzQ4gej+yTgl6YwrccgsfINvZiHKcGR/J74bQEH
 Pt06IxQ7oB0+EFISXp5yA5rb/xse8kD5Q9VgIJJx4pveb0Pskw45T/UabsBEPuBhJcF4P76k=
X-Gm-Gg: AYBFou3f/DALpY6+oSXpsALSWYddFSJftmnJqKlsJaUUcz8oOr0t/WczHYdDw9vnoiv
 OFTTZVREseBKG8RQe/QpkL43gYj9HhaPtoN9wr9NqSOmYSXBPQ+cUuBr6EWC9yhw8rKYEEwF9b2
 rZQBEFRm4TDVoroRVsoXy2LSAEi83BJWIyeHz/hmv4TMwUCjbliUS9lB928ej1TuR0PEQF/r6xJ
 QZOcb+vfW6AFHcoKMRQQdHZyXap6S+NlBWgr7vqckFmtZBxViUoyd/X2Xhkxr/bWeXGRVvvFxnZ
 ruC124/2s3ZjjmnChV3ZoHR3MeV9swzD/yUuOBEwWqYBMR+raqF8mdHNfnnzsEfrkq98ae9q+Va
 341NcG9341Gl45SmOtvA/Zwdcf5lZ1b+TUPtG19UDL4vYnnM+PhXa6vLAc7ihD+3OngLd0m9l0r
 DkEuIAhLbJVFWm
X-Received: by 2002:a05:620a:2951:b0:93e:6da8:6cde with SMTP id
 af79cd13be357-93ebd207afcmr247614685a.35.1791551902211; 
 Fri, 09 Oct 2026 06:18:22 -0700 (PDT)
X-Received: by 2002:a05:620a:2951:b0:93e:6da8:6cde with SMTP id
 af79cd13be357-93ebd207afcmr247608285a.35.1791551901630; 
 Fri, 09 Oct 2026 06:18:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cd5d8fsm5986561fa.30.2026.10.09.06.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 06:18:20 -0700 (PDT)
Date: Fri, 9 Oct 2026 16:18:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] drm/panel: Add driver for Novatek NT37705 panel
Message-ID: <xwaxsqtffljmv2tgobybq2f5v23hs26wy5zjdti3dziu62kq6z@qpzlpnmplnwp>
References: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
 <20261009-fp6-panel-v4-2-7c3819664778@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-fp6-panel-v4-2-7c3819664778@fairphone.com>
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac8e99f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=qNtwOHy-hT8K20Jd0IMA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MiBTYWx0ZWRfX7KfJ4AOLlklk
 3MbE8gUZyRlWcs9bykz7cEMLYyLRnSDd90FIfRQS8v8jyZOhTyyDFIJ+kdfSaB1Y4bZxKtwkAUg
 9ryfXB5Jc2arPTMOYfZeD5dGjLSRR+s=
X-Proofpoint-GUID: eJtKv8it3uDsOOh8oCa_wxDcuksE-a5k
X-Proofpoint-ORIG-GUID: eJtKv8it3uDsOOh8oCa_wxDcuksE-a5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MiBTYWx0ZWRfX48fOcyGBQfpB
 SgEg0GiqRmHmpwTAZYDQ0ldmhzNddBkG8vHhGoQsiM+tziHI5Dqo2zGZOqW79DgrBS73JAjFjsY
 hyz+ZyTvxaEE92jq/Vdpq2yfCMqhf23rp0DD4l8Apcy6vc0ks6b6qcWN57hqPlQdsS/iv9h00EE
 RJyer8tu/One2RTIMohBaxbDdfx2P4ZqofS5LMPHo3LkLRgCuTTS2wG46Lts9GBJ+k9YA1f8oIN
 7RoHqLil5ZioLPVk5WhPxXwuBBizk1Etb94hKVMMs6l3fwdL7NMNE16dEtpV+73NgAyRwrDpRzc
 SwyWnpo1aKQveKEiUU/bjFwVoUjjQqC7U1Uj6RLb0fD+fsf7rPGi3LL0nK/YTLClNzByIuvCOKi
 zEoxMsndGX8LPGuCVkS2rAE/Kw8pzDCFlJdNTf5BpwgI/YyWsoBuB36qdtpphwakO4+C0IvkaVK
 Y5R+Uz4B1MR8qC7Op+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090052
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

On Fri, Oct 09, 2026 at 01:25:01PM +0200, Luca Weiss wrote:
> Add support for the 2484x1116 AMOLED panel from BOE (BJ631JHM-T71-D900)
> bundled with a NT37705 driver IC, as found on the Fairphone (Gen. 6)
> smartphone.
> 
> The panel can also be configured in 10-bit (RGB101010) mode, however
> currently it's configured in 8-bit (RGB888) since there's some issues in
> the Qualcomm DPU driver when driving this panel in 10-bit.

I hoped that fixed all of them...

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  12 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-novatek-nt37705.c | 396 ++++++++++++++++++++++++++
>  3 files changed, 409 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I went through Sashiko comments, I don't think that this driver diverges
from any other panel driver.

-- 
With best wishes
Dmitry
