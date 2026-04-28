Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369F5FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A2710EAAF;
	Tue, 28 Apr 2026 09:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1rHlRNe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P71DBcI9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDA810EAAF
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:21:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S7vnJN1744889
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uVa5aELi8oMy5IN5qMbJc9fv
 wjHh1VOUvgLucaocG9g=; b=J1rHlRNedvYMBPu+kQJFq8obDoBh6bHtsfLGahz2
 hlQdCu+A6u3y7mjNloWouF+t4ISvCbX70e/l5X26Ljg2HnbVteXVnmUdaj70LAwr
 Se5keSzn6OCCgB6kTKCD9qIvIHkO03HYe3XZFCyixRkDWuJsXVxeHgm9aT3NtzNN
 F9k59gi5dAEG//R2LTnCsJS+rxYudLoQgLQRrtgEkNzmE0fUyzlJ5d87WPw51qs8
 LHONOWUKvpSi3Cz+8TPT5HHrXEt22Nh/a6Bdr4yu4IjaazJ6ONe5swPbm4d13sx+
 RvQnHLtGk9d4RZtOgaZOHHVy6uWmbgG2RvD9ITkBdunESQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtryd8as3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:21:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8aca154e2b5so196659006d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777368081; x=1777972881;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uVa5aELi8oMy5IN5qMbJc9fvwjHh1VOUvgLucaocG9g=;
 b=P71DBcI9em6NKDoali7E5XPYb+2xQHAAgvcV35+T9eWVH6zMZIUiP8R9U4r8f0+A8N
 y5X1wcgCWj/ldzSEf0O5xFKAd1QLLsL0qZGSL+NqBwknYiRhPZiW4G8Basm6gL7ZFqQl
 tNwO3nV+nciwtCZV5mwx9WLoIdV+jEhANT1zx5QtjuqYSi4+y9AmfFas0P83farMVKmN
 rlOFPJ7wCRWcSNbs+Spxw5cLHCT0uFHVBeoAnw399MqfMDZwWshU5v9NgSfgsikeHG60
 7f4KbDFCbg4KzxN1n22RlP4G8vjr8hJX4An1PBSkysicMb5DXV2S9doaGF5oATsg7Z6x
 AjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368081; x=1777972881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVa5aELi8oMy5IN5qMbJc9fvwjHh1VOUvgLucaocG9g=;
 b=Hrnw4kE1xjO7zJfO0+EYbfZhpilr9y3s3OwionxfkVcGDuyFy8zHKimSEW/IMLq75+
 8LZSUZxo9RKhMbq1SS6ZrPkh68ib4WF4yDil+GHNTZtv70mixKyu2YZukhIRgoU2VZv0
 9bh8RwtZ+IGc3vnWU4NfsyxDXAD7ysiCuN2FuWjnSteMLjTFNR5/RTY1fweg3hchCbLE
 bTFDXFXQxLpww6ZXBrTbUiKeY38lT2Rdtu3e2hHcH7nUJp+3P73UlRWnitIHWAikzBLW
 4skiExP0TbmmhYPwUHugWrW5aAkOOW5aNda4JrOx2a8lxZ4rJ/zFzt8sa/2BXVt39sfl
 wFmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9loebiYeII9r+IBW1cLxtleX+/uHCLXyoGiu+B2yoeX6yNiIRJrjQ8jNTYXEF0qZW26uC58nEEDho=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzh7AmUUwtDAE6diPMWglupiLY8cdEfm+9FEwN0GOgxQsiJvVtW
 E6Zm/82qVpmqWZU6BA93pbAWHsUCFABSAe5k4FdyKjkA/23d4yfzUqGw0tpBi1Tp/ywGDYKrbUG
 rU3vnWbWi4dGvQOQOeMjMF1TTQaExgdSn5X91L2igTVPMPLCWb/oGeMFaG4Qtuxg89bKm+xg=
X-Gm-Gg: AeBDietrxI9s0uaY5gdB0+t7/AZivovYr11zYb68zeIhiAQsr6ui2WZ+Z48O8zLBtvm
 wg9PpQVZNnuoffbNByECZYVoS2cvqY4xAyqj5t7bzsrxsIpcX3JLqYxZViK6scw63Uf5YQZ9jko
 t9aJ5W8hot3ZY9+y2yDZg0sr5jX/M7B6vQ9Htno1tvM5+3TZjx6HqoUwbRMcNrBW85GYRTiflMC
 LqgLP/KlnaivUOQOfl4l1q6qigx+bsehb0KNbZKyonCgXFKaDF7tulM57E7lbbfSyAleeQ7dqWW
 s3eosL6cd65jQQaUFkFUzSDsKyc3pMnK/jySKEGRkAffhCOiMLAJRU5ruIIT9YTi41Ky+jlrJHw
 +rDMUiapOgaScWDAkwau63dyKY+0xnkmzz2kTrAkCFm5T8PQ285bg/yQ2MqgKbxUOWgXB4QgCbW
 fkY1SE0a4IYOM21ipfRj5Rb77soXzfIpuGsWjZXk5ibwLYFA==
X-Received: by 2002:ac8:57cd:0:b0:50f:c117:1c52 with SMTP id
 d75a77b69052e-5100e0f6951mr26863481cf.4.1777368081340; 
 Tue, 28 Apr 2026 02:21:21 -0700 (PDT)
X-Received: by 2002:ac8:57cd:0:b0:50f:c117:1c52 with SMTP id
 d75a77b69052e-5100e0f6951mr26863341cf.4.1777368080872; 
 Tue, 28 Apr 2026 02:21:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7462d5821sm470542e87.33.2026.04.28.02.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 02:21:19 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:21:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
 op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v11 08/11] tee: add Qualcomm TEE driver
Message-ID: <ljfhoo5o45m3t5fsqypg75c46qohvszd5azcqxyjdcr5unx7ob@vcgip4yzkmmn>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
 <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-8-520e867b3d74@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-8-520e867b3d74@oss.qualcomm.com>
X-Proofpoint-GUID: XTYL1JG3xjyvuI1TtZIvcMKgpAK34YRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MiBTYWx0ZWRfXwciyzRutMdER
 2j4dfe1hLs2rrZzRuF3HejHmte1yvkHwi4hMTrO8eH5+GH329RNDXe2GT0YpvSqQXKgF8+n2dl2
 iQMkWDzr9tRLplwuq40Fijh9mPbDqUZ8+7wkMMe+ksiTHCxZFfQmvE7j0kPHDIwjVtbGrJj2ZnU
 l95oYbkFCVSUIwFbsviz1lWFKfamlNiWpWV995hWJzZdbt/mjI+sZp9/kJIFsTDzyKJgklE0Gir
 a0ThTNcrjLjgihJpFoBS9dVihjUcSuq46YUat2XDbqXV6wKbXCUdH3jDyV0m3fillm5X8tanxuU
 YK7cgpWv0JnPWvsyBmfO92bKKMvOvGrv06GrbuENMsHLrVSRNid4aaka+SWcDvQ2DCOgXVhSL34
 Nrboutp2iQvSVl7Ob4oFDPHCj8tsVplqu1tsizm3xmCtlQHrpUVr7cafHvTepZr/CAHtTOICQCy
 s+VFD06Ynl9/qFH7adg==
X-Proofpoint-ORIG-GUID: XTYL1JG3xjyvuI1TtZIvcMKgpAK34YRm
X-Authority-Analysis: v=2.4 cv=cMnQdFeN c=1 sm=1 tr=0 ts=69f07c12 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yhmqyPtzb8d5NndqWuMA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280082
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

On Wed, Sep 10, 2025 at 08:41:21PM -0700, Amirreza Zarrabi wrote:
> Introduce qcomtee_object, which represents an object in both QTEE and
> the kernel. QTEE clients can invoke an instance of qcomtee_object to
> access QTEE services. If this invocation produces a new object in QTEE,
> an instance of qcomtee_object will be returned.
> 
> Similarly, QTEE can request services from by issuing a callback
> request, which invokes an instance of qcomtee_object.
> 
> Implement initial support for exporting qcomtee_object to userspace
> and QTEE, enabling the invocation of objects hosted in QTEE and userspace
> through the TEE subsystem.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  MAINTAINERS                          |   6 +
>  drivers/tee/Kconfig                  |   1 +
>  drivers/tee/Makefile                 |   1 +
>  drivers/tee/qcomtee/Kconfig          |  12 +
>  drivers/tee/qcomtee/Makefile         |   7 +
>  drivers/tee/qcomtee/async.c          | 182 +++++++
>  drivers/tee/qcomtee/call.c           | 813 +++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/core.c           | 906 +++++++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/qcomtee.h        | 143 ++++++
>  drivers/tee/qcomtee/qcomtee_msg.h    | 304 ++++++++++++
>  drivers/tee/qcomtee/qcomtee_object.h | 316 ++++++++++++
>  drivers/tee/qcomtee/shm.c            | 153 ++++++
>  drivers/tee/qcomtee/user_obj.c       | 692 ++++++++++++++++++++++++++
>  include/uapi/linux/tee.h             |   1 +
>  14 files changed, 3537 insertions(+)
> 
> +
> +static int
> +qcomtee_object_invoke_ctx_invoke(struct qcomtee_object_invoke_ctx *oic,
> +				 int *result, u64 *res_type)
> +{
> +	phys_addr_t out_msg_paddr;
> +	phys_addr_t in_msg_paddr;
> +	int ret;
> +	u64 res;
> +
> +	tee_shm_get_pa(oic->out_shm, 0, &out_msg_paddr);
> +	tee_shm_get_pa(oic->in_shm, 0, &in_msg_paddr);
> +	if (!(oic->flags & QCOMTEE_OIC_FLAG_BUSY))
> +		ret = qcom_scm_qtee_invoke_smc(in_msg_paddr, oic->in_msg.size,
> +					       out_msg_paddr, oic->out_msg.size,
> +					       &res, res_type);
> +	else
> +		ret = qcom_scm_qtee_callback_response(out_msg_paddr,
> +						      oic->out_msg.size,
> +						      &res, res_type);
> +
> +	if (ret)
> +		pr_err("QTEE returned with %d.\n", ret);
> +	else
> +		*result = (int)res;

After enablign QCOMTEE driver, I observe the following error during the
bootup on RB3 Gen2:

[    4.720777] qcomtee: QTEE returned with -22.
[    4.725251] qcomtee: QTEE version 0.0.0


> +
> +	return ret;
> +}
> +

-- 
With best wishes
Dmitry
