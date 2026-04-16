Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3E4F8A14D
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 10:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F6D10E1A1;
	Thu, 16 Apr 2026 10:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FRmo4TI2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SFFciQrp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3E110E1A1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 10:55:45 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G6oehj218759
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 10:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qhaT6frBkv4Qr3L0ozWOVUx5
 2eDBgylITMC5mRQp/mE=; b=FRmo4TI2ZtmcWnTZjoLJrcD/hrw6adet6xXlhAui
 ndrA8l0YG7xWn/hyJWGLV1uCnCvIFcIbH2TwvWKTgFFSIcaNus+zHQPOmB2NtChZ
 aNZnOt4NL+mkSJMfdCpscTBApsXKtTXP51UOjBq9ZPWwB+YyzN/qJdcVxZwvnhXz
 hnw1sRbjKfliAc6KFqQDMyuLPtIJfJZlO1alP7/3IYGu58nIeJIXSrmurkL9wCgS
 Gt3dM3rIxbc/EHIGWQuxRIYrSbbcq2hr/OQd1C1MaWbeiiNzwbEHSq6NnyfFLRrU
 pUmYPo6GQX/YKVkZCRHyJ4p9lZ3buMZ9ilwSaHcon5xEzQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtuygwkg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 10:55:44 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5675cb317e3so8096375e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776336944; x=1776941744;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qhaT6frBkv4Qr3L0ozWOVUx52eDBgylITMC5mRQp/mE=;
 b=SFFciQrp0YBXke/3YDrPDogWlRMOMEBxIC1w+TixOL3OF1BtInegSZF8rA1CmfrJkt
 UzZiYeSeA7DYNVyaWTswmOe/gsNUWuZVvXHz3UqR9J9r+GTZs3rXrNmvygyS1FphhkV0
 yhehmdChPB6bN+d2+52W52XWdpp8jAAicd40K58MW0jlITJ9Lbq8EnwJAZEcSJ1Sxjml
 VRW4R4UUjXfn9vSvbTZxDVyBR3315ThbQbW4MwCx+GPXilG1kPwYhhNHz/RFs3056UP0
 K972TrrZEjon+0kg56pQqensoOW3Y8MN5RE82/tuwqGEEiuRzq86x18TRzVN6+H9j+Et
 RUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776336944; x=1776941744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhaT6frBkv4Qr3L0ozWOVUx52eDBgylITMC5mRQp/mE=;
 b=F5DJ25EjvaLCj6LKAgwRoQxVIqto2irL/JH9EUVx5waNxGrTngFTGqSPCdkIY7ViNm
 3XTJtFLTL2uxsgxFECTXQnZyg7DpJcBNSvslFffyodMDGUfXaZOZR4BArqUFaqCBXNqi
 gZIalFZSUYAAkYDHqDMm5W5+dm3OyOfS61dI0MjW2NbtzVeLSskbYii1fLY0TxYKxdqF
 fhQTbFtFSdo9F7q4I5U6xh1bwwVpat5EClgM+xsBduZCh2RhKt/VSM+qXm/JxCxv9gcb
 ki870Eq20z+FfsSOpjaKMZs6s48PTYZaGOUwNcJNDXQuUo9V7wROq9bSGULn5RXW1kJb
 LKXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BRtdrZ2FUrNMYSGFJzZ9n+yRZfV+MpE9rmaoTJFsqaUgtaOIdTnfP3SOztvhABd4C0jMpFCepQNI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4oT9VjShaXUVtJqgjX7P49HoByQah0DxBCibR0UPMjg7EjjMD
 rmsR9aiIJgGRr9Nv8FSy77UabxinNDQl2HRN9bD2VZwCmjbo+ijUanXGCCPwBgVgj392Bkgvc4+
 fqCnfGnlV/aOKAU3DAamZWDHgy5CBFel6tjeFERoMrwwJVN4wV96jkV4IvIUVko8Bkn75iDQ=
X-Gm-Gg: AeBDievRxBOeseLClV2gkN4zitl5RrKsTO3X411ZT98+rdpYf7QL1KR03FWowy2k0ym
 AaUj6F/tda+kC/pd4tfDmOSo92kN1BnFQVDWlmDawIVgGSAiJ/mupx2CcqedodcET4MkVVgSmi5
 VHqWpz4zFB/DwmMfAUyCyGll/0SpxoNlOZWFXvv87We+qWWzz1LOVSUnv5S3tKtrIsY7+VckayB
 YPaXe6kw46yhs8wmomQ7L9j6lYDXIfRzvNvvclz5BPo0rTuq5FcdW1bTOo7bCx6JTMx7PdMNZ+o
 xWE0xu6jkS6Lo4Se66y2TFk6HhapeWd9yxklOd+/VDuOGrZIJ/j8XP4dj44MssiEt9r6baAQtCB
 u0LCHwZ0YWH+eIx76zgx/8Hav/AmCVj41YNVuMZOHf456ZwcpQ/uH4cqFVDQfYhTZNUIgM8MNJQ
 C/eWw6FKKKhyffM96XRw022avd5yChJ+zy14/vNUcd1gwNHQ==
X-Received: by 2002:a05:6102:3e04:b0:5ff:ea33:2be with SMTP id
 ada2fe7eead31-60a00427d2amr11297884137.19.1776336943940; 
 Thu, 16 Apr 2026 03:55:43 -0700 (PDT)
X-Received: by 2002:a05:6102:3e04:b0:5ff:ea33:2be with SMTP id
 ada2fe7eead31-60a00427d2amr11297876137.19.1776336943460; 
 Thu, 16 Apr 2026 03:55:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e9ebe67e2sm9936291fa.26.2026.04.16.03.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 03:55:42 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:55:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: Re: [PATCH v8 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
Message-ID: <ymieeagodsfbygq7fsejsqriajmncoubzvor7t3ll6ntomtbeg@l65yihnixwbu>
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
 <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEwMyBTYWx0ZWRfX+uYvCD93+wzc
 mQRAfBksximoLlUoTLJ64iSCDfF64FkhhV/+MrysZ+wYve+Hd6V67mLyppiC9YHloYRjnxFzvZ4
 hhAzgDnpCq3RDRtiSORRVOsvTWBh0LPKAvA412hi7MunEnuh6An/s2L55jFByxF8DQnRjOQaVQk
 stTgA0yNwOoY8lSbMoN5YRgBN/vBNO886B2WbOo5kNgF9Kz1jBFelXPLLJRmWhKwB6ZFf5VAyOh
 R41Z8c2QRsLk4LO4yf4wV6f4Nf/34r060+8KzqSShfB9m2JPSU2NfE+MjCm2k7wDeROyxNyxWDw
 8EusTVPE0/3Ufauncb2/CQOYsnJznOyYqtId9CUwy9MRW4l5L+AIaMmju0o2j2o2SLdPYrEIqjB
 56rwZViuQS1H+0baCJYAv9KhqyPmQLL7BP7foEFTWRnIMHDTJXLTb3ZS0hYgTh5JuvrVZ2Y5WT9
 PY2nhSHKvH19r8oEFqQ==
X-Proofpoint-ORIG-GUID: MaN1bh0erqCouamiUEEX7vQModLx3CgO
X-Authority-Analysis: v=2.4 cv=Ipgutr/g c=1 sm=1 tr=0 ts=69e0c030 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=EekQdeYcPna9Ds66k2oA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: MaN1bh0erqCouamiUEEX7vQModLx3CgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160103
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

On Wed, Apr 15, 2026 at 04:55:30PM +0530, Ekansh Gupta wrote:
> For any remote call to DSP, after sending an invocation message,
> fastRPC driver waits for glink response and during this time the
> CPU can go into low power modes. This adds latency to overall fastrpc
> call as CPU wakeup and scheduling latencies are included. Add polling
> mode support with which fastRPC driver will poll continuously on a
> memory after sending a message to remote subsystem which will eliminate
> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
> poll timeout happens, the call will fallback to normal RPC mode.  Poll
> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
> request with FASTRPC_POLL_MODE request id.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c      | 137 ++++++++++++++++++++++++++++++++++--
>  include/uapi/misc/fastrpc.h |  25 +++++++
>  2 files changed, 155 insertions(+), 7 deletions(-)
> 
> @@ -1813,6 +1908,30 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>  	return 0;
>  }
>  
> +static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
> +{
> +	struct fastrpc_ioctl_set_option opt = {0};
> +	int i;
> +
> +	if (copy_from_user(&opt, argp, sizeof(opt)))
> +		return -EFAULT;
> +
> +	for (i = 0; i < ARRAY_SIZE(opt.reserved); i++) {
> +		if (opt.reserved[i] != 0)
> +			return -EINVAL;
> +	}
> +
> +	if (opt.request_id != FASTRPC_POLL_MODE)
> +		return -EINVAL;
> +
> +	if (opt.value)
> +		fl->poll_mode = true;

This will enable poll mode on the platforms where it is not supported,
later silinently changing back to the normal mode. Please don't surprise
users and make this call fail if polling mode is not supported.

> +	else
> +		fl->poll_mode = false;
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry
