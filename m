Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642D1F99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55E210F057;
	Thu, 23 Apr 2026 10:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yw6KaeUR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jB2/Kgjr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293B910F057
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:17:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8uMQh987864
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MrFUNh0Sh+14OqZmTVoafGPx
 XO0ORTKN4V0WTnuxCeY=; b=Yw6KaeURW8LP5PUGegvNSdD1f0U/NuQBfodB/PyB
 86a20sNYTUrywxKWWEfp7bTEUWC/xRu3fLa8zGCdJy2mT9dmYDef8u1yEyKVe3dx
 M8nExOc7PwednYRhxbp5iLQxMrGUqzuR1uzRwxDX+wZPagsA5dMvMWiCRiuIsiVk
 PeoDvHVZvj1ef0TtdoPLJ86nchO0Gc95Eip5Wy31tXQd7feZCUW69wDKnK6YuDWo
 Dkt6u1/RTGb7pGNh+aUzXswOvwcTcuxvUGBGkoba3fPxsT1mJcnTMWTlVmmWMff2
 yUfD4I32TWPgsSWbPKHMnKpgY1w84iPTfgbLeETN5+E2og==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16q3esk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:17:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50faf1ecd1dso85018661cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776939452; x=1777544252;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MrFUNh0Sh+14OqZmTVoafGPxXO0ORTKN4V0WTnuxCeY=;
 b=jB2/Kgjr6pRRNIhtKEWr3iHCM64BpIotj+wOP/IT8e9iBPWtTUIMGFjGor4qSB6FfJ
 aNeRaluoeGuMAJwYqFn1YZLtFUoXQB8E0ww4fzEi+LjOqNEJr5/p+g0MGGgBuQ4k7oz8
 SvLAusS8Lmu77BrVcid7R/rAlEMcp83hWXFve9QuVij2yHNx3B8K3fuB7K8b5tr8MYWb
 CVbld+TddwDNQF0Y0Ny6qpTSV/WuL9lWHuZZqM4sIbO6Ny2sBSct65EK15yztnqpTCY3
 SBPXmW29fc6a2iPbgokVek0sPD1FaC6/HA8QrjXcAoPMeOf+2O0lzbbGZ4J3PSV1xnSi
 OYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776939452; x=1777544252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrFUNh0Sh+14OqZmTVoafGPxXO0ORTKN4V0WTnuxCeY=;
 b=cf9fglqv+mvQ+w4WvdOG2cAxufKcE37KEVI20fF3BLmV/4d3jA4Qap7af62IX6kGXn
 191kvR3GuowK6kldv0U+Esvdq2HGxWf8ib0edxNsBUdPqWIu/3Dn7Uio9pYXfid3yk/v
 OA33G8597xnSXIInawznOg4t564Jlq8meCw/Fwdj8qJ40HekwJ6kge7pWg6/TIJBv1/c
 7/nptmhwUMQljiJSQxKW37PXdzATY+EcfYEl5T2OfFqiJbmIHIFoE16Q6S8wx0N4XWDs
 qjFIsDXzdQFRO5TLnGxapmGCR+kvLRuWYWwHrxWAKeDRs9/GQDDU9L9Wb3sKHMGzOT1g
 kpvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4MXB/0Bi7lbplVmzf5NfGpGSzmbGGpMtsdRzhAIxzLj3o0Rau3zr9PMSU/4gOF17Eeo4aNrckwek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZ0Gu9BkL5ZazGA8uUm/IFsQNoVxW43ba4x4EVuPyMZPz/qyCt
 nMgNDPKJL2xMwT8j/eayHdsFOW38drTvXfXE8aXhGNfN5u55EvZ19ZJiZ0e5lc82rxxn8IoCKtS
 UzU7OFtwUsJmjrS8XKC9cmXlzq2nVHDL/oX2IFjFh/VJcnYxXfCIaGMNiEfowuktqNOHVbrQ=
X-Gm-Gg: AeBDieuIazV0kZAECIevqIKpcNRYHF7Z+bIA0Bt1PkWe0PniItaxYJb23gaoRjKF5q6
 See/3ZJa+OPh+IYEdbedtkUck3F/KvsY4ZNa7K79FAqgHl1YUMs6dgp8MY+BZfzBrDJJDRw9zXz
 S/WV+mLTsDgqhFiGP2IQWLR43/nnFAvNev+vJ4qQjOdk29dziu5aNS8TMOL3Q8dlegOjW6DhFn3
 D2/wi5ywUHIRgsEJyuVLEdzN6alb0GABhI+C1/vgFrmwPb7hYJBdPI4oELV6Qw32HevzCPHDgE/
 knU0xb6TMmIsGRkYuF7/yBU9I5X0nUc2MHREF9qaPmjpGHEXaTkmkfgY5P+06LzOjb/7UeohSz0
 zrdOIzbvZgrc+LjJ/BJ6v+UO0rFa3RP879uACoFQuSv2Qd5ryYZsouG7ch4ho90RFgOYCbn1QUx
 b72OI/+2qdtSCarmuIh57g9bJD8FXdJz8QxLICX3adEcraJA==
X-Received: by 2002:a05:622a:506:b0:50d:86cb:db75 with SMTP id
 d75a77b69052e-50e36827766mr391728361cf.7.1776939451647; 
 Thu, 23 Apr 2026 03:17:31 -0700 (PDT)
X-Received: by 2002:a05:622a:506:b0:50d:86cb:db75 with SMTP id
 d75a77b69052e-50e36827766mr391727931cf.7.1776939451013; 
 Thu, 23 Apr 2026 03:17:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc672sm5205340e87.34.2026.04.23.03.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:17:30 -0700 (PDT)
Date: Thu, 23 Apr 2026 13:17:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: Re: [PATCH v9 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
Message-ID: <ys6ujryc2bntxd66n2ft7rl73g7abtfwvhn66clqc52on2jwi4@7ladycubgrre>
References: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
 <20260422092409.4107093-5-ekansh.gupta@oss.qualcomm.com>
 <jqehwyeoda5t5kabxjouc4kgpnebndotkr2a4tuuiypzqcck42@dv3vu7wbq6nh>
 <52aa6442-7e0e-423d-beef-0ef2a6c06884@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52aa6442-7e0e-423d-beef-0ef2a6c06884@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KPNqylFo c=1 sm=1 tr=0 ts=69e9f1bc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Ms8xwbpsCofS3cE9mJAA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: D9QXbr8A0MgPKxyQ4mvcvqj_pUQz-TsA
X-Proofpoint-ORIG-GUID: D9QXbr8A0MgPKxyQ4mvcvqj_pUQz-TsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwMSBTYWx0ZWRfXx/5uOxrCw+mQ
 IGNvAZCvkgiQrMPixl+FG5KyfBcnre31ZKuQ/Jlg9VIPKEumI3vM8f/AeMs/dpGVGfPSndsGmyo
 /qtz6ZeS1MLcRKSzs+2LPAvCOz3mWFHhK1IMWOTfUIEfFXymDootNSG/1c0rvPF6fqE2svgo5Fr
 3YhwOG90mCoazvnIWITaiGDb9hchzCmEwdByDcqb8MdqYs03hn2JiUODGu9xnGhmiESbttpbabO
 bbIPOA4l3U91Kdr9znKmdA/OK35L7ZS4gopemLH1BvIjjKJePpjw/kCOWDb0ZPcegNfNrSs4xEN
 dBSTAcVZTJSkA8gV61eTvOhY0HXF+687Rut/5R5eoUpe3uvbxdHCqZI889l8zaVf5xR/vdmajNF
 2dtnRwQgr7klPqvm9/FmUcdkiBGX8d2Fxyy7CyzS+rvR2+aF0/fsnw+2TCnvMr642SFPmlsQKxS
 sN3zXPjnUrVu2lQrwNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230101
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

On Thu, Apr 23, 2026 at 02:07:23PM +0530, Ekansh Gupta wrote:
> On 22-04-2026 21:17, Dmitry Baryshkov wrote:
> > On Wed, Apr 22, 2026 at 02:54:09PM +0530, Ekansh Gupta wrote:
> >> For any remote call to DSP, after sending an invocation message,
> >> fastRPC driver waits for glink response and during this time the
> >> CPU can go into low power modes. This adds latency to overall fastrpc
> >> call as CPU wakeup and scheduling latencies are included. Add polling
> >> mode support with which fastRPC driver will poll continuously on a
> >> memory after sending a message to remote subsystem which will eliminate
> >> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
> >> poll timeout happens, the call will fallback to normal RPC mode.  Poll
> >> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
> >> request with FASTRPC_POLL_MODE request id.
> >>
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/misc/fastrpc.c      | 148 ++++++++++++++++++++++++++++++++++--
> >>  include/uapi/misc/fastrpc.h |  25 ++++++
> >>  2 files changed, 166 insertions(+), 7 deletions(-)
> >>
> >> @@ -2331,6 +2446,22 @@ static const struct fastrpc_soc_data default_soc_data = {
> >>  	.dma_addr_bits_default = 32,
> >>  };
> >>  
> >> +/*
> >> + * Older platforms that use default_soc_data but whose DSP firmware
> >> + * supports the FastRPC polling mode.
> > 
> > There should be a comment, "don't add more platforms to this list".
> What if in future any platform is enabled that is based on older archs,
> i.e. doesn't use kaanapali compatible but supports polling mode. In that
> case this list might require an addition.

No. New platforms can get a platform-specific compat.

> > 
> >> + */
> >> +static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unused = {
> >> +	{ .compatible = "qcom,qcs8300" },
> >> +	{ .compatible = "qcom,qcs9100" },
> > 
> > Use qcom,sa8775p instead. See sa8775p-ride boards.
> > What about qcom,sar2130p?
> > qcom,sc8280xp?
> > qcom,milos?
> I'm checking for these platforms also. Will add if these are supporting
> polling mode.

Thanks.

> 
> //Ekansh
> > 
> >> +	{ .compatible = "qcom,sm8450" },
> >> +	{ .compatible = "qcom,sm8550" },
> >> +	{ .compatible = "qcom,sm8650" },
> >> +	{ .compatible = "qcom,sm8750" },
> >> +	{ .compatible = "qcom,x1e80100" },
> >> +	{ .compatible = "qcom,x1p42100" },
> >> +	{},
> >> +};
> >> +
> >>  static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
> >>  {
> >>  	struct device *rdev = &rpdev->dev;
> > 
> 

-- 
With best wishes
Dmitry
