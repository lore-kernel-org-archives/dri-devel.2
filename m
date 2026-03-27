Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7545A10ED64A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE4510EDD9;
	Fri, 27 Mar 2026 12:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Up21IAxv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6qIofdg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370D410EDD9
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:10:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6w3GE1860230
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=; b=Up21IAxvjvhnBku5
 1WEMR0plcKU/8LVRwfLOzTqQcWm/3I+FpNYWTAfJE0dN62SjCAwOLiTXkpyOBmi1
 F03PkTNDHh3WcdrldG8ULdMLmcQ/Oc1kjap8+L8KgAcO8jdGI2IPNhmq6/HEfpLN
 Hx1h95vFsrzsa8PP4bVyXCHqy6IdyUtoYOcjZ9fVYdltJ9tbzr/xQ7sFTf2LHYD/
 4rqENwzKnPuPHAvJD0+JtODzjxU2VRtX1Vdi6PlvOy8X1W+bHnHXA+pCGN1JHGBI
 j58bnigDIr+KkVbhN90OmOsKB0BKxod3uqxB7+n9v3z69FMEDlvgerGGDdh7lqqG
 2Kv71w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv2xpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:10:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358f058973fso2910172a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774613431; x=1775218231;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=;
 b=N6qIofdgW4gte73jQLlARzXtAh2GSEOq1iLmPC5vTaAwjSV8c9M3eDuUGbdfcNXhlA
 BWWL+QEPonDjiDMzPdXSfUUYvWcRMpJX/T6cUHQccibQ+B0vlQhUvCQTv2exaX3F/pu1
 Z6woe0yEFnn5GTBEiWWHbun5NWCFbf/eBYeXjWA7dUTxA+77bBHA3FSY3j9ed5ysNMfn
 nzU5hrpwX+me2r3cPk4ymMhMh/3zc8fdFdOAfGbuE1DBXeHq2yj4/5eliLYKS7pO4/yT
 9sluqDPteFa9r7uOkG2+hZATrcKXecKT4RAl/5QjaxMlHWkfeg2Y2gi/LLWaYniSqTDY
 MxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774613431; x=1775218231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EE0yGsx0mvjT/GTmYnfC7r+2Fd45Q0DeobTk/gC7vvM=;
 b=EnaadtzwQYFHUPKh70L4ZmFOVJ7CKNHdWiitMEYo2+LvgcB7BVpUFUQ2zTGrqPq0ds
 vGfbO+O5Fly1e9KhpvGzzpkcOzqmL2S/pK9pNnVj2lRz7gZi3pxGVNGYrxkT1AnKIa9i
 bjLU5UKmlKFcGD3Ok1JaczvsRdJEmmp2W5Xsw6umODEv/iFvI4IQP90SpIMYNVk8kLW1
 YCqnQO6EriywbaZt6Kcb26Gb6yljOcC7gagxTT1aTpsEtH2Z80scl0jVM7R85xw2XWqi
 1u1rj7dd2fgKzkj9sJCkBkfpinWJa+pP2mX6/5ugV4SQGAeJEOJVXhQhYB0Pfp7YNPSO
 z+Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOC6Fh0uqwqyqiYtOEK9K6UEOIKSRfqB/FWiIjX08t1O4b72Cc4yK1k6OjnLyu8DP8Z6XVzc67du8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVJh3zYPKg5vdcRnehPrNg2PPnzwvX+MKmbBgZ8xnxzJbk4ItJ
 QAwZig7yApTH+2GTs4XLrNNuooM0lp0UpytHaAzGJenUbj4OsCoCia8wx3Zxf7zIjCJyZxB3rY0
 kk8aFgepzm8FpH6mj2AjuMgceb3xRT+cgnTIUuJQKFIB7x6uCTDnjLoHYD2edhu4LOZxgN+Q=
X-Gm-Gg: ATEYQzzbtcAzFLcH5lj+ObLooDW/UAs/GNGvw6MguSRsqFAe6LVblycSMoT4W64HL78
 Olc4PKl8FvKA0lrNWuMgQYPnLIdLa+GZn0BLW6Ih43pQmNUnJW0RAJ4fNeN4A+WAQ5tu4nNQJ04
 8iLorHwQVuwykU/kUS/BAaMQEZlbvlhrJZHMClU6/npy0hGAPup9VcaXS9m2bTojjIA+mz3ym75
 EHrqkF0SJ4k+9YbikXHFncc+DylUvxsCfVKp1d+mIk/JrYY7vpMtUybPdDxbeiKfBGEECreHYB3
 k3AR1s5Vf3sZgcKvguZvhOuvejACmUX+THMrtdB0V8Xu7i8t6861Y7LWn9smhQ7KooWzRK1UGO1
 xEcT8bj2wUuUxc3QUDahyzn4S8g/JI2oxXOqG6mmdZnxYQsObnSw=
X-Received: by 2002:a17:90b:1e51:b0:35b:e51a:85af with SMTP id
 98e67ed59e1d1-35c2fff2c76mr2299342a91.10.1774613430865; 
 Fri, 27 Mar 2026 05:10:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1e51:b0:35b:e51a:85af with SMTP id
 98e67ed59e1d1-35c2fff2c76mr2299260a91.10.1774613430257; 
 Fri, 27 Mar 2026 05:10:30 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22a81757sm6204402a91.6.2026.03.27.05.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 05:10:29 -0700 (PDT)
Message-ID: <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 17:40:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-4-sumit.garg@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260312062756.694390-4-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c673b7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=j567PbXuXaTzagYqJJIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: b9l-TfRlMoANy2l4E3fI71z9Q554lZnW
X-Proofpoint-GUID: b9l-TfRlMoANy2l4E3fI71z9Q554lZnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4MyBTYWx0ZWRfXxrXyixg4v+QK
 14XdjMhi38h1z4GD60qDpxCiUrKcb9kwAx7EKyE6g0algG0dGtMT6VA542yBI18ZW3AHG21qxFo
 WqZdvezRfN0yyo+JbWXlwNVbhar3Z3Q4yPHb+uwZVaP1t4t5Ax6MuhebcWs7164iGnNdoSaBbQZ
 hMPDd4pX1udPSPaMO+AwcavPbEJkt1RKxpqvjF1hs8JKSflbcnizwycq/EwZQKNUFwpk0kgHd6t
 I1Omg/3UqGER21zUzEXc4r5k16l/k8qrqb6NAJaFPqOji2/f0LxWIDLVuy/9IP/gMoeT//sWi/a
 U1710APDVCfRdLJrKvse+cx9uuVhYUDpQERopvtqdqcydtKoafCtq4bn2XIne+DFaEfTXMy10vo
 lwoA0Lfe2WcbdRTxHPKhOOst1Wsxd5a4NnDYmt5Uy80fxv4EDtIx/ZorII7/wxRFm+imdOv+NaR
 kLuSL4XKSL9+60kXeqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270083
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



On 3/12/2026 11:57 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig    |   1 +
>  drivers/firmware/qcom/qcom_scm.c | 336 ++++++++++++++-----------------
>  2 files changed, 156 insertions(+), 181 deletions(-)
>

[..]

> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 8fbc96693a55..2d7937ae7c8f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma-mapping.h>

[..]

>  
> -/**
> - * devm_qcom_scm_pas_context_alloc() - Allocate peripheral authentication service
> - *				       context for a given peripheral
> - *
> - * PAS context is device-resource managed, so the caller does not need
> - * to worry about freeing the context memory.
> - *
> - * @dev:	  PAS firmware device
> - * @pas_id:	  peripheral authentication service id
> - * @mem_phys:	  Subsystem reserve memory start address
> - * @mem_size:	  Subsystem reserve memory size
> - *
> - * Returns: The new PAS context, or ERR_PTR() on failure.
> - */

Shouldn't we drop the documentation for the exported functions in this file as part of
patch 14/15? After this patch is applied, the devm_qcom_scm_pas_context_alloc() function
still remains exported and available.

Regards,
Harshal
