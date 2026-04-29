Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D14CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC97710F035;
	Wed, 29 Apr 2026 13:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="opyL4EBS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IiC+YjRA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F8610F035
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:53:14 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T8q7cO1721232
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=N9U0SUgWF2lcmbEYf0NBfn0l
 dEy8tcMY+YE7XgOzUV8=; b=opyL4EBS6uDORxigC+UcE9nHJcnx30GM4XkEiaKJ
 +EKqtzXUpLkVEyXvFEr+OwuSno+GiOYRHQD21jvxb2FquWGStamzVGChieH0Vz/Z
 tkD9WFYveNCeJLXqD89niR3bF1KWvJJqWDGIHTsM5zL2vgXim8F1CXJNrPLdIyE5
 jF+wZ40Obr0A7V0abVcLlwzHgr2W3AGwMYaPBKyX6wVizsjyIZA+knAKDfv8Pf9C
 Q+NWs/qQ2X+nP+ibrFzo9BzC8zWR2BbWcKjjxOek36vixHMAuF/9v8oCmSvRxohY
 wK0l9GILTkz0aGEXhyH5u9yBWIC+BbMaklBh3ow7gNashQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dua7329qc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:53:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70dd30025fso16005558a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777470794; x=1778075594;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N9U0SUgWF2lcmbEYf0NBfn0ldEy8tcMY+YE7XgOzUV8=;
 b=IiC+YjRArF4ElpnacnkM7ZQkJ4sWeamQbDHfs42SypP0Vs6qJEWqH0Xohq/WwlUyTn
 yCYcwXsprTfZRfAfHQlrG26oNfHEqy5xtnOmzpvmcG2gpGNGk0uAknaaF76YirfP47Pr
 hTJPo/KzBigbZQMiGEIPIRbPdEiD68zcMqHUlo7VHul5MwBYOoAQ0vUGevhPCAzGvLlk
 pfBn2Bfm9CKn/ij6bVJIu4nxOJrC6EtoGT5aSOmQEzKM/TZpm538liN7uo0m5aBlCqBE
 aorTn9YWqn6+FIvBmS9jceKQEeZMmLDCXgNAzaU+yG2LnSuh+1bnkTQr+AvFM6oWFl93
 9YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777470794; x=1778075594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9U0SUgWF2lcmbEYf0NBfn0ldEy8tcMY+YE7XgOzUV8=;
 b=OlSfMw7kvsE0Xh/+Usgnf8CTlrYkIffleeVUCV8Hi9qrlgs66PurUjwGiSjMHKAxkx
 Nx/e0xwZNm6JohpgmsEf+GhNTp8tmBJbH1ohN3KHOYaYoJoLCJ/tEArrGJfDGcw9BThN
 n4gdsOF/MEDSGnJrH25djX06C6iXFRtRNx3NOTacBwS+ziCkhzLQgIGRzeRu+QaCyN2H
 R1y6QO51ZGS7HFCNokW0hKTCC1a0IYfuOfpQyDsPGooPsLHhtp4BdSYU4Y3aR3ZbFtbu
 jRV7w2fw6ohvCWQdodD1+EJa/FCYqYpG8NgVW/oTp0CJlyc/JtU63Jg9xiWG21RvAxj0
 2fZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zW1TwpTxVhWJR8Qys0XxQFHbMzy0F92m5lFcMmUT83moSRuXNmkkICWQlPlPLUoYK6pZ8REzUnvc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0kOTewBocfih/b0AHH6eV9RZVOLKFHOLHfIzhx6zNXrOpHbLB
 LbVvq8KKz5nUXEEFQgR1ib6V6vHH7fOlYe37eGqGV4E0qFAOict0BJgow2WcdvneQ2NP0dJJgq1
 tdarkAbWfcqZ5eA3Tboa4eblwJRmD94ZVNufkFf1G32gNERGuZRtNYBhqxvW1Gyq/iFak3+I=
X-Gm-Gg: AeBDietJEbhD1ONAWqBaC411R30DtOoUJlc11MWUn1iTNXwIKvYFAh4G9W4HyT5wW/B
 9lN6Ul3TADnMoAakGXk/enBWGjmvI+7dfNS3nB4VYY8eA6SY1BY8aWeaNZOqYz3UP9kaIE3CMJd
 N4NPqWGNXe4IIMmA6gPAQHrEmZ3a6Iy5HemFEACG6rjth5EzKv8TL/7qnOg7OTFtpvaYkweUn+T
 SOyWOBPseY7BiXyNAKY/xMTMagqMXeMUK33M0KBeKYcEXYJcALVgxNJu7EzKaeXvDv9c8AbSWiE
 +yflwWtoVnOAs+stjUzRtf9Xrd+AjNWQCqCRntq72pRvJzfkAUFm3ap5UThs4N6Em8fS4zoIhy5
 CnKPwE9izL8cmnxACcbvgeRghu8iRYwAQ2DlHHuj8aVKkSmppCXC8D4nQhH0=
X-Received: by 2002:a05:6a00:bd0d:b0:82f:4628:4198 with SMTP id
 d2e1a72fcca58-834ddc2db4fmr7647881b3a.31.1777470793695; 
 Wed, 29 Apr 2026 06:53:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd0d:b0:82f:4628:4198 with SMTP id
 d2e1a72fcca58-834ddc2db4fmr7647813b3a.31.1777470793036; 
 Wed, 29 Apr 2026 06:53:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cccc4sm2190396b3a.14.2026.04.29.06.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:53:12 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:22:57 +0530
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
Subject: Re: [PATCH v4 09/15] remoteproc: qcom: Select QCOM_PAS generic service
Message-ID: <20260429135257.utgighzczrbnl6cp@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-10-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-10-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=XtvK/1F9 c=1 sm=1 tr=0 ts=69f20d4a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=L7XPiZuQ2t1DW7kJCHQA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MSBTYWx0ZWRfXyks9ohd9DhKe
 b3Qmxx36mJw/DhB9bGYPDnTxAzUYD9HoktBBuH7obJvK6Zoa+eR/dweIhIW2HTSVyfZmbOfQmiH
 9wsdttr98ICtmYMllWxdrItc5G0StwDb91mdA6rOFj/c+zN+Mp3DLvLFZUc3Sqq+uHI/5EkQoFL
 IhV/1PUG+jwLhB6mdqLT97FLqT6hJaMNoTcWnC+QJcL+IginKAP9CzayAcAdpuDGtXw2jmRAQB/
 JBzASLvrR/LjFSm7nVFY3kquvFNDk3IAbRiDKEWKOUfwAi6vTy8ptFkOnPeuAcOtClvLbl0rEWx
 8WDKmM563jxy1nLypW/mkL2ygssobe59xPtV/1SCda1RUJYlxc0+3d1v5eTgVv8KF7OvvAhFXfE
 J3cTW4G4IeG6uSkQ1Ci9R7+XbfH69ELD2CapUyRr/+5PmN2pAGIV7hOboC9BfUx/hs/J3cM74Pr
 bsQL3it38YzIoP6db2w==
X-Proofpoint-GUID: DSqYT-6X1vRqS_ojtzbbhQLGfd_Mzsj-
X-Proofpoint-ORIG-GUID: DSqYT-6X1vRqS_ojtzbbhQLGfd_Mzsj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290141
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

On Mon, Apr 27, 2026 at 03:25:57PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Select PAS generic service driver to enable support for multiple PAS
> backends like OP-TEE in addition to SCM.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index ee54436fea5a..da3c5d9562ea 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -230,6 +230,7 @@ config QCOM_Q6V5_PAS
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM

Check do we really need SCM now ?
Why not the change for WCNSS, MSS ?

> +	select QCOM_PAS
>  	help
>  	  Say y here to support the TrustZone based Peripheral Image Loader for
>  	  the Qualcomm remote processors. This is commonly used to control


> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha
