Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD76FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A87710F03D;
	Wed, 29 Apr 2026 14:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzklY3pE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fb2wXLnu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA3810F03D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:04:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T8pqli1641536
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5geFPuppNEw0Na2cpguNPJGL
 4nGh1NRsp1YB6ryaOE8=; b=UzklY3pEYefS+bOkeBxtQUZQD+IPj7gXWaOzbRS4
 WSH7uI1wuHaUtu4VHRYIMvEaC8Ce0Evo+1qCEfaXCuS5ZjOepwbErwHPT64k34un
 SbcLc4hz3Yyoroyb3gjlgim9TtWDtoikFNBW9OgPOx+e2y7su/Kq1/tXmPTWiAYZ
 LKsObFeI2pSfqRgSI6in7sI2towKK+tr48YfWNyZERAuT1Y+/k7VL9nPYI2Rm+MG
 rnEcZGfao2k8+8039tDSPeRRbTv/tEPjbLqp4NrDRL4nlwgeOh464GwL7tyN7NnV
 qY55lUizS1cK2Jl9wXKawsarLCHU2ioQmRBhk/Lcn91pGA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj81u1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:04:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-bce224720d8so7175150a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777471497; x=1778076297;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5geFPuppNEw0Na2cpguNPJGL4nGh1NRsp1YB6ryaOE8=;
 b=fb2wXLnuXSe6SS2gT0fiUiK1AKF5DxNNpfVDnz41NREGGAOcrwLyoHka2nZR2e4eMT
 5lmPCCu4+aywqv7c+234DFa+FCegclpksujAlcBJr3wUJtfe//l1OEopS1BSJ2jreP1Y
 74LfA7WBWWJmEO0V5sEitoa5Q+a7zXpRfP7Ej1jED21yZJzoWXRRSC8xLrDYcH+s+RNx
 4vOod4v6hXXYvFiWhGb4x0Y3iJE5zCF3/Q81F8V3ZkewCKzMgGgt+sm9bW+XnimWZ3p9
 hcAeeY+z1C7ue9OJNQmJrWBbl+LVEQqmva/QuY8+x/SWjosGcbT6SjVPge9PvadjejhK
 absQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471497; x=1778076297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5geFPuppNEw0Na2cpguNPJGL4nGh1NRsp1YB6ryaOE8=;
 b=oBRRXAau2vyBj0V256svfLmisH3oF2wrj34bafF3VKNLbmLSF8q5CHO8S6ZZdzkGm/
 vFK0gbzunEfE9o37YHxcEQgVWyo9atAFPokeCfLGCUnx/nB018Z76jaPmKWfOLnzvMW8
 gfNNDs693BzWKCJ2ZkrmEkJoksMmPf1F0y8guFncHdBoGMcwywMeLOLlZgZ+V7XkBGA0
 ca/yTsgOkHW40byzvp/ig063ItCef/qPapecf8dT5KEoG8tB0ZlBtOW0SkWWNEJgkYXV
 WknVdt8Z4JfnEM0N2I1L9/p6RLlHNuQa9RVhY8nEqBilE9ywrWxZZ+xIc09g9c1goQX/
 hwVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ca3jOXIBG5Y0YQEcgoAHMgb3obYcuflY+BSyqhlXnZkwGAMb3w6WQM9M0vEEWet3Q6YoW/6J54rM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywe0D5MfN9l7eWEdqq2yqzBeZRl5komrVcODdF9KrY+0ZoplyLB
 uz3nkiwrfPkTZkt33CCghmRT1bHzRWpuu2Je/ovv2Nxav1APThYiZEP+z8LxV4+pgvOmq3ZE2An
 Ff/vhsk7fIXeU3ZjtB+UAuae52dI+n9OLiWFmP3IuNNzFDC+Xsy22jpIiF1ou1K3IQclBV0I=
X-Gm-Gg: AeBDieteKdbDOumofbdXpT//oE6rbQmL7sZQdx04QLXXFw2T4Y/aBn2zJgTX31Xt2xQ
 bYKmKzCIrAkHsiKZeiKROVBJdNwyAacpPjaWAOQlV6yc/fWmYHHhE0mwuKUe5oaE+1PIcC+oxXf
 Vh5Zf0yoLc5l0xo/GyXPi+R7MwwQKlQp4XqQm33TLE1VJdVFHYrpr+b67b6v3g7vScLUzrfYoJt
 qi96yZCn/p2wjMJ48/Y8ypbZgADxW0Gn0n5WcgMIwSh7Av7M5ZyQKxtpuPykVXo07l08dzAWNxH
 D5lG2W3Lblfj/laHy+qHnXysFJgPL3o5T+BDejSHkCZQ9w5qn2EUm7iinONLIXaD1AgwcbxkoyS
 Ka+wwbMDBb/AjvUY1TxX+wxu2ruFgdzmFhY88vzvPD+TOpFHSvqJpi+2tnuU=
X-Received: by 2002:a05:6a21:33a1:b0:3a0:cc67:396 with SMTP id
 adf61e73a8af0-3a39c2722a6mr9041394637.28.1777471496928; 
 Wed, 29 Apr 2026 07:04:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a1:b0:3a0:cc67:396 with SMTP id
 adf61e73a8af0-3a39c2722a6mr9041274637.28.1777471496127; 
 Wed, 29 Apr 2026 07:04:56 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd6506af1sm2270618a12.25.2026.04.29.07.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:04:55 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:34:40 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 14/15] firmware: qcom_scm: Remove SCM PAS wrappers
Message-ID: <20260429140440.ov7x75bikyvs7w5y@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-15-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-15-sumit.garg@kernel.org>
X-Proofpoint-ORIG-GUID: 70IBFcDKTs4H66dnHmXDef3TzGcGiAPn
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f2100a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=n1VOVlC_Xzu4QXtT9DgA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 70IBFcDKTs4H66dnHmXDef3TzGcGiAPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfXz2uE7esAd70w
 0vXDhoxRtIgvLC8cPf//yU496qMalmC7eh0bR/xq0u0mz/NWaxAMJTrnsIM47DRSAIdDXXL8ns4
 1z1NN4VFVkvsmjb5YgGukT7xm0+Yc2RPeNZ6t4Ml1Ul5P9WXOO9CkUOklpUczHcFnUvb5jAnGs7
 2x/ytQWWq9htYvVgSvGnznaZHszw9y4SbXENfzG/mxBOAObPwmXOE3alKORrcBDPlmlQ0XOzeUU
 HY8DlY49E67nrWbVqO0siE39GxmkYsimiUbkCYPW4p93ETjloS8hZll2Xa2yhcWKBPAa/1xhNf+
 PZMjTC0UuIsZKuHjw6Fid9IMQUNtnfDGfy2FpYATxoGkTBQQi26ShsbRLxVfkVCdkC1zzqDoUR6
 +W3u7Mif2/l1/WI6hOwlC0+bj32lcaCsyQz2gehZqanL/fjb0HiZbIlMLwmDG7JVG5SXSuoIfuF
 /iGQx9vF6VSwcvzHU1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290142
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

On Mon, Apr 27, 2026 at 03:26:02PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Now since all the Qcom SCM client drivers have been migrated over to
> generic PAS TZ service, let's drop the exported SCM PAS wrappers.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>


-- 
-Mukesh Ojha
