Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF69AE7E35C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4552410F48E;
	Fri,  3 Apr 2026 09:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="isxJvM2K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3LHBa7W";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4D210F48E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 09:37:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6337UmgT2707214
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Apr 2026 09:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=H0MsR4PHC7LRNEDJ02SXHtGh
 86o8LwWKhT/z44z5dSo=; b=isxJvM2K/Cv3Pm0NShfaaEwkY51/yH2P37+roCBv
 lYrCcgbdhQHUYJxt9ZaYRXWC20+urqqeQP2i3fq42SxtBdpAbOyHaIPnzRWp93qp
 QhAms5skdcgdocGbuW8EEkhEUxZ3sTcKnETvEuiyk1+Pm3OocQu1n8HzYcRw66t4
 536ts+kxzBAJIVeVFBFgH3T8x2hYC18mMhBZriiWcTHzQDNU9C8b+kQqmV4xadiD
 mTBOHSS2dOrTwiGXGNamY2DF5T1mQ/6TJ4GlxtarDcpWup0gReaWKh75SsJBMArq
 yJ0mRgfT8xA5wWGvPp4wQ33YQwu38eZi/2RiBGwkpqwHTg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9yfjhyeq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 09:37:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4987c698so30604521cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775209036; x=1775813836;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H0MsR4PHC7LRNEDJ02SXHtGh86o8LwWKhT/z44z5dSo=;
 b=R3LHBa7WMcAnQgYXEyrW/1xLB6rQS4jtiT/2yz7kJv5GOdAqHY76iuiL1SuiYeXdup
 PlX5Ymd+sQKYWrmLyjD99X3bhO1YBTqVdfi2gNY8Icgp+XjOYWxszb1nXd53HYck4s4l
 /BiS0Idr++ThJMVYI7Jyh1zDDT/LDxLYTRbYTRyt462Zinvh81dcMBM3zJmsyQas+b0O
 oxr7Afcd0Efa045NN4Snh4mWLvQgbUTg3cMoAVklJY+OPwu5i+geLwLfF7IVqOqmMSKE
 m3B0Hp8JWEbK3xRkrwLHOlNFzgPNp0EgIIhQtthHhu1bXqzu6l5mPTf6MVu0dmKZi+cv
 QPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775209036; x=1775813836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0MsR4PHC7LRNEDJ02SXHtGh86o8LwWKhT/z44z5dSo=;
 b=V6au7ExWb8BhOHjTjD+UwZ9qmMUpnMsNftivgUscI4Axd4cg6s/DHx8TV8T2/4lpo0
 jd/E48IeMat9vvcJ4nJQWipRzEV1E93Yfi2egU2UOd6tfUm3SpN6osllO8au7D/GpW1k
 JPdrycuz/Xn5MrQ42SAyo1z2oDmIFkc+W0C+r19BUGwGUlkLImEm/m9fvSicFtZyYT6f
 NSlq5euO9v8+n3/gbE27uehcc7kICdrt2mcYJNcMfaPtGs5YYgeurpq0tzCl5zUZq5SC
 fs85GvwU8DE9q/vAmceiX19dkV3Qrhxt3PO/sFvIgTDDiVZgVHtmnker47ihmhk86BHz
 CcaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrNSfaZe8NdmHBRfB8k1Up00df4FGCTIFafvtOFo+SdZsGia0FrafyLoaPdrhWVSwyESpbgsRkSPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDGbcaCvQG72DF1Uo1xtVjaC3xAlEXUzSBSqBZGWphbUNxzegS
 9zy812UwmDv+Kk0//9+DtrsDdzEejbv9reOSCnq8IzaOf2DZe6+GKuqfAeOuKBNUMCNzmhx0Nso
 b4TXHyI8pCnT6lJxrLkZoyKFoj9hhNvoG4v9Lc92phubcFaYstPEvj5frrWpn0gRxy9g5Wkc=
X-Gm-Gg: ATEYQzw3v9QYnLqEh09fnzHAAR1o1wMvuqXsqwc3HPVUPc9oujczyRPy34i5ebnTCeg
 GRC19xHuYtvCJcaWdSoSdzf2glFixfeNiAFpKrrH8VJHoNkLPCF0v0BkblJpvzHEL29SubWof4H
 YjCbQAID29VSHzd7b+qzGMP5rOpOFeN+sO6jfNbV1Gvx5CXlmefjC3hC0tJlTaaoLO1wWWQYmXk
 tjfcL0mnu6sDOnSM9mkgjoY2ZvdbgBDtQn68iMi0AqRoywIIxN4ArqqfxHlnQVAx61VHf8BbpuE
 rDKsudv+hjUeF7dHxhfk05UTEWut9E7UOCiHedpY23RM3JfAjtLQypQhH/jgL7TDQbyoS88UmpV
 fdV3cJxYY10Z36uzw1+oZBg+r4w9pGKhrREzw9nMT8wWxjAQiXTqkhRdU
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id
 d75a77b69052e-50d4fd24b4dmr66236541cf.38.1775209036469; 
 Fri, 03 Apr 2026 02:37:16 -0700 (PDT)
X-Received: by 2002:ac8:7dc5:0:b0:509:202f:f03 with SMTP id
 d75a77b69052e-50d4fd24b4dmr66234201cf.38.1775209031263; 
 Fri, 03 Apr 2026 02:37:11 -0700 (PDT)
Received: from trex (187.red-79-144-197.dynamicip.rima-tde.net.
 [79.144.197.187]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a6f13sm15010561f8f.3.2026.04.03.02.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 02:37:10 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Fri, 3 Apr 2026 11:37:07 +0200
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <ac-KQ7e8-syph1Zl@trex>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327131043.627120-12-sumit.garg@kernel.org>
X-Proofpoint-GUID: qQZ52Uf1klA01jgqPtZt_C9JlJoj3Pqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA4NSBTYWx0ZWRfX9VbmazmFPnOA
 rfcdpEn+VS/cK4O+M/Ubm6c+TK8p45OPTdOmNZyYMfMtKkAzppl2ecvKcAcsU5sc7Vf2QH1HeFF
 wBxOnDnalequt+yBiuZ4tW2Eii4ZxZezqaRSvHX9jhQQ3g6Ht8lPbLFeyEiPyLg5nLQNS29v8Ht
 3OwL/8QnWLn5RanEOeIjh082xX/NL1baUxx97aeRaAlqTqNt90dRI9ePRoEI2AvKv2lcX8oCEz4
 tFpM5Q5xiBbg/uKBkNIqxhY0DXDrZ05zzRl15gINPRdO3JTx/igvBeV9HcZzWPOGw790EMT4LYI
 QEiccFtXc49XUfBT2cp8ubRfV6rUPP0nYgQL3J4s0hnas+ajPEp7oJwUh2okQ/7f+OQtSYJMEP+
 lFZJ+m/yGnmqNs+GEwiMT1l4Sm+5YSAiNzwTQAiTO+Nnr9lEEb9nJfqlyeFN8TQHvkChvCgsCEI
 SslDFWtj/eJLhkvZlkA==
X-Authority-Analysis: v=2.4 cv=OrpCCi/t c=1 sm=1 tr=0 ts=69cf8a4d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=VPdg2FrOqWfiVCzsz0q0YA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=vWT0tKtjkO2eN-vK3vkA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: qQZ52Uf1klA01jgqPtZt_C9JlJoj3Pqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030085
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

On 27/03/26 18:40:39, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.

OP-TEE based PAS service relies on the linux driver to configure the
iommu (just as it is done on the no_tz case). This generic patch does
not cover that requirement.

Because of that, it is probably better if the commit message doesnt
mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
implement the same restrictions that QTEE (ie, iommu configuration).

I can send an RFC for OP-TEE support based on the integration work being
carried out here [1]

[1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507

> 
> Along with that pass proper PAS ID to set_remote_state API. As per testing
> the SCM backend just ignores it while OP-TEE makes use of it to for proper
> book keeping purpose.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
>  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
>  drivers/media/platform/qcom/venus/Kconfig     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
>  4 files changed, 25 insertions(+), 21 deletions(-)
> 
