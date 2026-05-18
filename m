Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925DBCD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2CE10E6EE;
	Mon, 18 May 2026 07:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d9s9F95e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HvCxlctW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E543310E6EE
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:59:19 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I5en4m1255259
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zxa4aoJy+8GGKmRaYi1pSnhQkdsyiCfnvq+yyPcQAFI=; b=d9s9F95ePq5loa3q
 s7a+Qgrahhvnw7U4g31QyHl0l96kBUbykO0djD5c3qZx1lOZpotOF7EkzspCpYLL
 CJGiUfJPitFxRhxmet7mwTwVmim1IV8Qf2loJYL8YVw7Oam2h5x6eBaHmhb2pz3f
 JmkuLPKWf/4tLsb4LWmujUBH17S2ieu0YzD0V6f77YYte3Jw1Fgal6bIljyAzR2K
 +JnB7TLDBmVLHOovvHQ0bh/zdYjINpZRZJetNZ+rJ2JDta0tPyocuDy0IWfkNxB+
 CuZe81paVkyj3sX6S0DB5eafMUgWVHH0hmUreH5STkpWla1vNfIksZWDO34TYFkx
 FyXmMw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvcm6ra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:59:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb0b93e90so6733971cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779091158; x=1779695958;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zxa4aoJy+8GGKmRaYi1pSnhQkdsyiCfnvq+yyPcQAFI=;
 b=HvCxlctWqkDRug2V3KJpAM0QRaElKD1huFgXMNx39VUTOsYElJcyP10iCx2y9PBnHM
 QBfo+UMLE6k3q0AqPnrX+avRLoBp3mTkfq0Q62ZXqp3KR5C2rPMUI/yuWgs7J4t8cQ0S
 aItqZy8VF3cFd7CA+5shRUVo1Oh+W3qt6nFG2vaXLfPauB/pKMnnVy9GZTHMt2ZN5Ied
 U/VDBMxjMSRZ3Iw0ybVS522OAxUI/JhfaDp84QH0KVwlB4WmSmS5qFPnvYWW63F9YJBA
 k7HCPlo0MGsW5iUwHizjDKnT7QxafdmKMdOsl3M4ejdargdcY7xBoqC2XJWawpNw1j4d
 xoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091158; x=1779695958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zxa4aoJy+8GGKmRaYi1pSnhQkdsyiCfnvq+yyPcQAFI=;
 b=ByhLBzMffJChgxE4wLe2vZcKGxb6JSd985Z7INLkYjKF8jsIZLU7sJgGVy7Nj1PJGf
 jFUGVOuJ0mhWN+P5MXdFSLGkOScmz9g+Pls8hSz9gV1WBcojHXqhmT8/IqRkOSN95F4O
 77qDS5bXAkYoT/tww9JMbsHL3/D2JwCQjSAP3M7a1td/3nyXQkR84FvgZt0onKKE+pDr
 o05p24vsqzX6Tt0eVQXxG7Qu9kpVGNbRMNciOpKjT9Jq6qXfD1cYwQ4t2DuTF/fMcEjz
 l8bwszOxpsq1x8vlHV/2vf69cFwUbwu/SD1IsL8m5wnScBYLowIwxR4492OO4MvvHQC/
 MjnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2UZ5D8byZYHjXGCa7j/FpDVRRjzJhHqQkLfbFfc3sAdmtWT+nie9ebeh74NcGYM6di9ewsXqikFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdBVDFL71/15/rZ5iIDzZCb0vQDHO6SbjTtYZZe1RPyexht07h
 S3Ltax9aKqvY0Bf3rLFTUEXJu8cfmCNUlHYcR0xEFjGoNTMQ4bG22YcFSjOcCdh9h2lPCpfJHYx
 y0a3SRx/mcowEU4LJzGsHwFFMHeyoRcMvPuNLvxUisxAV6+x9IE0KVI0ByJRlS11RIahNKFk=
X-Gm-Gg: Acq92OFOpRaE1mfeVgdcTfqm/YOLfJfD5AAYbHaJbifaJza6DS2JKqWldtK+zNmsDaW
 2UZd44Rq6wPi755TGEW43S6bLo2LPwDSJvKNAeQhNn2rOm7BsadgtfQKeh2YRSOorYdDFN2/YmP
 n7NwGmxxFc/vSH9q9m1yCZg1sFR+diah29/IrMfEGRI0LQ7Vei274h+KRShYjWPr9EPtRIXXXdx
 TmQPn4BrO/KWOHAcFOgE+69jWXNIpOjNEJlFybb/yhZ1jQZj80kiVLr5RRtSEs7DrmFB0Fbx/Dy
 p/i90iwpXQYpqr/UveXu1YyPkH6J+14g2TZB+oHk2VDxCqICQlXzVd5RjlVUYUghY9qvLkj8nD8
 fSv/x8Yfk1lnlFt+wr9L/eessNHBKGoJ2Otbh/6U/AE/x3Yf6KDfKItabRmi/23CkPxAYKGZ8D7
 HAB5s=
X-Received: by 2002:a05:622a:1104:b0:50e:487a:bfef with SMTP id
 d75a77b69052e-51659fd3213mr148249791cf.2.1779091158288; 
 Mon, 18 May 2026 00:59:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1104:b0:50e:487a:bfef with SMTP id
 d75a77b69052e-51659fd3213mr148249591cf.2.1779091157767; 
 Mon, 18 May 2026 00:59:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4e68fa6sm543154966b.54.2026.05.18.00.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 00:59:16 -0700 (PDT)
Message-ID: <4f8697b8-d602-4718-bc8f-4bd0dba50040@oss.qualcomm.com>
Date: Mon, 18 May 2026 09:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
To: Jianping Li <jianping.li@oss.qualcomm.com>, srini@kernel.org,
 amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 abelvesa@kernel.org, jorge.ramirez-ortiz@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, stable@kernel.org
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-4-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515124217.20723-4-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XYbSpPnV7eAhzHIT8B6dKucP7bKcNiLD
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a0ac6d7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hhTr-yxhb_4ls8DXav4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: XYbSpPnV7eAhzHIT8B6dKucP7bKcNiLD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3NSBTYWx0ZWRfXxm4J+avZN+9A
 ot3pQWjFBS7w19OMG5jeLE4jmYOSa5d23XLBTEWTuGkorh8yPwYFsm02FX6AyFHgBr8J3yQH5Yc
 tHmAtO7WD5ZYVM2WBHqBKJCQf5JPe6IAEh6XI/aU3QlpzS5KPsNKVRqCwPV/QYlgmyI2oJ+tt7o
 r/+HudKqv3oYZbRNIKJ/L7wkPtCqiceYU3dFj0j2BKTSqtuooxxuZFxTrFilQF4vBH9yS5qhbel
 BLHuz1pd0zrH01p+XUZUGnY/tzmzKV5zDQXQJ67GtG1/0gKbmJyprJzd8u/0SSOHKnGVYH0HT1E
 EWwy/Ep1u2eBlNnNnJ+QfDQkbKyJCG4uw4f5iH0sL3nVJpDLoGgryqqqvk3Ch7XRvpa2GML20dS
 1yWGpdl2PxlYi+qq3idnCEgpKLy/kC2RfYv919UZyrOXamkk5o9i5ldqjVUmiyAjFtRhrv+aZ9d
 P28EypBXutkdO/QaPbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180075
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

On 5/15/26 2:42 PM, Jianping Li wrote:
> Audio PD static process creation assumes that a reserved-memory
> region is defined in DT and exposed via cctx->remote_heap.
> 
> If reserved-memory is missing or incomplete, the driver may pass
> invalid address/size information to the DSP, leading to undefined
> behavior or crashes.
> 
> Add explicit validation for remote_heap presence and size before
> sending the memory to DSP, and fail early if the configuration is
> invalid.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 3c7c3b410d7d..a0337cce77f3 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1363,6 +1363,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	args[1].length = inbuf.namelen;
>  	args[1].fd = -1;
>  
> +	if (!fl->cctx->remote_heap ||
> +	    !fl->cctx->remote_heap->dma_addr ||
> +	    !fl->cctx->remote_heap->size) {
> +		err = -ENOMEM;
> +		goto err;

Let's maybe add an UERR() with some context

Konrad
