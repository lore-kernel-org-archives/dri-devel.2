Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2314CA9EBD
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18DF910E402;
	Wed, 14 Oct 2026 04:02:51 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4674410E402
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E40xkP2222087
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JpuOO2Gm66RQ1GIkn10c9yAx2q28La2yHABZDw7XjIw=; b=b2F6jXpt1yoBCAgX
 uA730UdaMVV19gd99S4W5+2Umi43QcBbszWoNZLXgi8CrfRw6GlQnKSiAfGiIxhS
 yHwNvqae6TijEYTnk8SDZZUCPZrsY/GHr5cXK/I87nBHZhbn/JnZNL/jWDYvToh9
 I3gYerH0mhDqlnAyx0aCRioOIzcvDPY2Y6GzNvAPljP3oa5P98mRwCYi0UPl/tDM
 8eCwGDXUYa8t3k9xelTmURDeW2ULegq8W0mujCbSy1GCqZDHVN2SJ/P3NWyCLsSm
 0/GYVvpdFKPhGEBNgvWz+dIgsH2MIitOzXC/qXLq++XzwMAycXeXXaoQd6zMS2DU
 STkWyQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9txs9m3e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so891675eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791950559; x=1792555359;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JpuOO2Gm66RQ1GIkn10c9yAx2q28La2yHABZDw7XjIw=;
 b=CL3by0xyuecumvWpwgManUA/ona2Qvrqj27M5O7kDrNCor+9vtBJ4sNspNpkRJSr66
 3fXD1XPVdXsy7O6PgcMWvPze/O0Ly2CcaFapxlP4a8nhxAEmgI8CJMR6fdoV6XUxCDAy
 bVLqIf9bVMSRD4BjZeQs9TLg8LNvyCQyOtlVt9LQDMyJo4yTbP5TNicrOe15Ou8qfAtv
 JKXwEyTEHEwmKBnzp5vad06fgZ47ndSa5jsgQSpPrA3AzcIL4s3+M9XvX6mToKtFa6E+
 9mrkP4E2NqWFZziISAK5GndrS9uY9+rATK0Ddb0qvs7X0DIeCqKy1BmTcONRfS1CQiPn
 wC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791950559; x=1792555359;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JpuOO2Gm66RQ1GIkn10c9yAx2q28La2yHABZDw7XjIw=;
 b=VNoAzRChN6S+B/rOEaWP8Z4CuipXjFSg7avxOYLzND3tt2+TYt2DhSe7/0rEKlpSUl
 xIQx1bq82Caavxy7wNVVkyeoIHwqey50O7FrxHV0Ip2qiYojgC3u2g5R2QvZx1U6ZB9L
 fn3fNTeKtkJqBdXQ0rM0xs3frWWcFoa744L01YnFsY3SJeF9nBcBXCYR2OT5FgVyc4zq
 9+8F4bXFVTabDNVjAk+Q/oz5NQjLD9DskPN69sDw6+IHlwxqlyWsqby9lD9B17vh6S7j
 JBHUnkMbZRdtDit0jOEbEcCsqKIrS2FTP6nc4SguWWa0W+c1nVKLTfPhFCDGK+z8HawB
 +Hjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2snTddASnlcUz1d7fjGgrk5J+mJ3CudeHrtxU7WRVNI6cyhMR8aIkd0egwIcI8OtDrkYFEERWJk8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKt9yHKsbPuEcGO+hrRiMkeu+2GJ+MQhE/ONaWJD0mrmbAOzorp
 dg3/H+SyqOv+oT+xQyfMG0tW1nMUZwQPQ/3FX2FChEPxyNKPkI3KjUX6eKgHeNel2Bmxn+bDv+Q
 nuP0AdL5k8ZNTDOMv8H/aOZzdkPacLobRccQ0Hb5Hz2RdU8JsVnkmJpHNaP0oofnov29a1c4=
X-Gm-Gg: AYBFou3/703Lp7qplQXVNAIo1gf/TnjI9WtOCeBcUvV7f3pYjUuAPxCqP56Q3MbbtXI
 F3l/M/RxV1Z54gC6zE+AhOncfXvNYjF80Z8EGB42Q6ajykDcYuZRSfr/D0Un2d6X3n6oa8AbWI0
 1E0qGIHIa4ZVUqZvWKa6vbkttty5hWgqCYmfVhNHRjgeRKyFBH8JwRxb8gOLpJFBIsWIaFUyrcO
 dVkvkiQ+/5rLHV/FjkYopXjvnP1D6e24dn5rUAZ59dMgw0hwEOddh226dJx8v4W/Rm0nDEchdnD
 nFnEWyYFLALWrF1VH0LBFvZwDsyMyxGYgN8nnGN71mGaJB0onN7qkwc+sHy8wbwLLSo2nhXUPJo
 SrHCXxYi12jS+dbHVh0yd5cnuFf8B
X-Received: by 2002:a05:693c:8110:b0:33c:16f1:2e11 with SMTP id
 5a478bee46e88-3537df596f9mr20245659eec.7.1791950558574; 
 Tue, 13 Oct 2026 21:02:38 -0700 (PDT)
X-Received: by 2002:a05:693c:8110:b0:33c:16f1:2e11 with SMTP id
 5a478bee46e88-3537df596f9mr20245598eec.7.1791950557704; 
 Tue, 13 Oct 2026 21:02:37 -0700 (PDT)
Received: from [10.219.56.188] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm49774934eec.26.2026.10.13.21.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:02:37 -0700 (PDT)
Message-ID: <b773e022-922d-41b4-ba1a-17d570551a1d@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 09:32:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] misc: fastrpc: fix NULL rpdev dereference when
 session alloc fails
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com>
 <20261001-fastrpc-probe-fixes-v1-1-1376d93b8b3e@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261001-fastrpc-probe-fixes-v1-1-1376d93b8b3e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNSBTYWx0ZWRfXwQ4R+w3DBLuR
 bn7c/jKgCiBWRNE0Q1YUKBYIw/q/HQJLwzjQcvIolnerkTBZgPELazfgsUGouR1H1nHjwA3H1lu
 cFOMXWFOf99aV+80T/IgVWjwBelmmiUnSKz68pX3cbWKmjtxjeHyG5cDpoBlWcbJq/5ze72iGzB
 1x94CCHTHCGvOJUV4JtU0BjmUjfeSxeJxFLDq5jJrzCUl4covA6jbLz9PlhaXSmTAmAwjdE3QET
 FzaLq0v01XnARbNXr1Lg0lNEfMpvQRUSh4YasiUzXktZW98LaVwaXiqj+aB2tWngjiD5C2YzWMF
 HQxobg/cM8cGJ2BaOdi2eh5rEN+Klyq4m+SnzOiYtnyN+YsR2kcQsRip24RO6YGTYRthoqeNiMK
 iPDD3/hGk4GWVVkqraM5bYmllNvgZUL4Nog12+owamz2FNJUGE3J6S3DSSg9ponu/6GCVqfXjps
 Z0pg28Yy1y4l3hrANEA==
X-Authority-Analysis: v=2.4 cv=LPPz05W9 c=1 sm=1 tr=0 ts=6acefedf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Hi5JtN4IBsk8tPmk4jsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNSBTYWx0ZWRfX8PDKUWfR/iLI
 pUpLIi1oVmWkGhNqu4Ph3Y4vvh90fY5mlDJyZgaS8hmLStA1ioKFaL7RP+f58lk+IPmBvdqYVMO
 KsBaatxLfQ56chzFlUmuJnutd+MvZJM=
X-Proofpoint-ORIG-GUID: cTZrwLdi4-weZkOp6qfF4eaO5IOydcuc
X-Proofpoint-GUID: cTZrwLdi4-weZkOp6qfF4eaO5IOydcuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140015
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

On 01-10-2026 16:31, Vinayak Katoch wrote:
> When a fastrpc client process dies abnormally without closing its file
> descriptor, fastrpc_device_release() is never called and the compute-cb
> session slot is never freed. The abnormal client death on the DSP side
> triggers a glink channel teardown which propagates up through the rpmsg
> bus and calls fastrpc_rpmsg_remove().
> 
> fastrpc_rpmsg_remove() nulls cctx->rpdev before calling
> misc_deregister(). If a concurrent open() enters fastrpc_device_open()
> in this window and fastrpc_session_alloc() returns NULL (sessions
> exhausted by the leaked slot), the error path dereferences
> cctx->rpdev->dev causing a NULL pointer dereference:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   pc : fastrpc_device_open+0x1b8/0x258 [fastrpc]
>   Call trace:
>    fastrpc_device_open+0x1b8/0x258 [fastrpc] (P)
>    misc_open+0xd8/0x1a0
> 
> Fix by moving misc_deregister() before rpdev = NULL. misc_open() and
> misc_deregister() both take misc_mtx, so misc_deregister() will either
> block until fastrpc_device_open() completes or prevent new opens from
> entering it entirely.
> 
> Fixes: 7c11df42d0c7 ("misc: fastrpc: Fix device_open when no session is available")
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
