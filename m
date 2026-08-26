Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41836C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728FF10ED39;
	Wed, 26 Aug 2026 13:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlNd3RgX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h1XScW/5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9073A10ED39
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:45:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCC4GB356880
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4jnYIpJgtFEZlWrcRFiUwalcwxZjoeOSevlSYM3+k2M=; b=hlNd3RgXSWmiQxeY
 bbtdV+I8fqLURJiyTIgClpz0Tr8jUPb/86Dv5BytCuvpCkSiYE7mnx38abo6bJMq
 GjE9WG8+JKCJkKlYb0RJS8sWBugJ4FbAMqRouy5blxcv1fQmCGIbm1oml9W6uyTH
 ef8Pna7IoNIgndJZ1ObAEwbaU9/pb0zYQD3t3Y2UWWqkWOu4IwJFSUPGu1aLnhYm
 214P6eaLNfyjtRKPHkvmniCr8A9BwTWFvK0eJ42ay9hv8UG22ttXfiGKG53RNmSF
 MQhJEe/Hv4GgzNS9dwjZUsGE8AREGlMrUpU85qt8eCx75ccDuh9q7j208avufXzG
 pstV8A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9ga389-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:45:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso1619390a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787751919; x=1788356719;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4jnYIpJgtFEZlWrcRFiUwalcwxZjoeOSevlSYM3+k2M=;
 b=h1XScW/5Q2bE0GYl7rj0m0blv7GuPC7y0tNj5etwK29NlVrlgdlo2pGTR0YuH2saAR
 RP0fy6PrXjjdQqf5taZM+Aw39wMub8OKUGhQ2OiT9vB3yS1hKxOUxcqzqjPKTZZCLRaj
 uLRJ7wAOJQmhniBCO8shxVIqt0QqQOURVw9CvEmNxlalnXEeiQ3sgH737PH8II1THYfS
 SnfCGZ4UyHrxO7OjYqNAl0suxQyaPf38lw9WfP6bIMOc7qvZRgLnIASQj7one6+Y1K3I
 1veNNDp5tE2i1qW+eRtkXoGktHZx1nAw+XOLtyd/Mc/h+L36szv3ktDibgx4+9baObBc
 n2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751919; x=1788356719;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4jnYIpJgtFEZlWrcRFiUwalcwxZjoeOSevlSYM3+k2M=;
 b=NkpBpSwFu6IOc9G2+kTDvUgQfaSHbZm6hMV6A2+NblO9yAnD+iedkd8H0V7X+dISwV
 Q4fsDCqWTJ90VAU9xT5dGwxEQfZuu7PZTxmknYjAy1EcwpaZ8EUzmYKkzOD7xGgqAHYo
 G6qwW5btXOANWnjqzIvoWsSxGKcxieDjJdjYboKxSrDSqfUw2P9kBTG1RGR5EfWQ2dr5
 fsydXYiEkohB0wTa8L2Qlcmu/8aOHGuKoOc7RLgGnxsS1DSUZcernHSOU3JWTAFQ8Dnt
 2gM1OP9SDUYpt7tksaQqgGwUbQQGOMPBWxUTh8ORhCTPEe719d8h8WnBQ0nQgHW2z1vS
 02dA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGsmDfcXXl5SEHuPmTjOEMc5hz1BGx84ip1xPyQMFA3K52AbG0UsTQ9oGFHGv99R5fbUtOaGkI9TI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mxg79RYkcmVht9DkYWCusXfTMPujS3wd45VuSB5EXh9Ae+nzya
 4I4AMcTTucu0GFq9fIsNnQO4KWhztrq9t7m9hN1Uqh/6VCzWIPKdfESbFKxZ5dwhzjAYH+EtTJh
 mrE3KonwDy+6Q0SE6LAac/aEtdDuASSh8RBihtqCFFAOo/roPzo+IWCIZhU7tSa38PbryysU=
X-Gm-Gg: AR+sD12wGypM2k+qa+NtvpVw/W4BDyyovTf302enmM7izIvkuzCA+cGjVvZUQvC8kSA
 fivIJG1OuUb59xL6iF2WmSyYZ01PISMW67kkokiYGeVLs5sok9BgzObrLcvbkB1aHBEB+rISV/H
 dQvLrefd6b9mbyFX19jG0nSNr6QGAqvk+czWlyeVYSW8PUimnndCSk8wgOBuVFNgbHLy1t81p+f
 GNNzlD/IaBB3SOlpAlYVLwC/uXV2KtHBCiVgt3MzXjrHBwxvXorxFL1U4CMHPDWpA/lH1ViW12S
 CCKE62dLaDFMgtig2JxiDl9fzLj2c/IRmX7+rRfyJECQ//hstkIG05PCEeLCc7ET2rK/+GjrJfL
 h+HzU6IClpIUNgkgyGvMTfAamn0xWLQ==
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-3966d3dafb9mr15826003a91.11.1787751918845; 
 Wed, 26 Aug 2026 06:45:18 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-3966d3dafb9mr15825822a91.11.1787751918186; 
 Wed, 26 Aug 2026 06:45:18 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8f20036sm13571333c88.5.2026.08.26.06.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 06:45:17 -0700 (PDT)
Message-ID: <2febead3-0f0c-4e0d-b11a-8c61ec027f44@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
To: rob.clark@oss.qualcomm.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <7030a8f8-f320-4b09-b2de-2c8e897409f8@amd.com>
 <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lUPh-InYSPxbrjf4uyZETFrAWUGZbARg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX2NzM+Uy2v8iU
 yjzF1so4EYXvTXD51GQIDjaD5fICaNWU5FdClR8vxFJCNKZAqk65/fvtwB6eJILqp7DZnaGipd8
 V6BjzXioaUw77uUXeKVhKIDaqsINPu9PRpTauleepuh/uGAvfR8kaiqO19pBlOxWUfxX/7tzZL+
 XDTX5j0pAcmXiEpqFSEHqj5DmTAN3TBhi3z/cDN1eWQPELuxIhl3fIXKzXxw5NBoyEYWUKFJcDm
 T40y3WIQVaARqge2fMlNpjT+ljIUsQwUhF/kBblmRUKOlzKPeFx3GI9+bKQQfa6KsMzaFQ3lD9V
 23CMbiLo7oBGsB549Zr9XqYmCXl66zGa8EGmpx+ESrE+j0rwofCMnwK7fettP51mF1IW2ub8MhF
 QvWtUUHKAFMrR11tSvvIPsALN2W9jzRDfU8sg3SAbgCrgUwTWqb3+QOCc24WmI6G6uE0d+cG3wz
 Q4L3AwuzDPCiLZhPJpA==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8eedef cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=sLzL-2GVjjNmCx-rav0A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX2hTBjoynO5v6
 7328JKf68wfmQCxrXGXClpwLZq/DzeEt7G0SQbWUet+M07XO/oU9+HV/iWSFCSvuqR9BQRQjf0M
 lZnGvnzf7l3rjIBc2QKz2G9RWkSenx8=
X-Proofpoint-ORIG-GUID: lUPh-InYSPxbrjf4uyZETFrAWUGZbARg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260113
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

On 24-08-2026 20:37, Rob Clark wrote:
>>> qda_memory_dma.c / qda_memory_dma.h
>>>   DMA coherent allocation backend. qda_dma_alloc() calls
>>>   dma_alloc_coherent() on the CB device and encodes the stream ID
>>>   (SID) in the upper 32 bits of the returned DMA address, following
>>>   the Qualcomm FastRPC convention for IOMMU address space tagging.
>>>   qda_dma_free() strips the SID prefix before calling
>>>   dma_free_coherent().
>>>
>>> qda_memory_manager.c
>>>   Adds process-to-device assignment: each DRM file (process) is
>>>   assigned one IOMMU context bank device for the lifetime of the
>>>   session. qda_memory_manager_assign_device() first checks whether
>>>   the process already has a device (reusing it with a refcount
>>>   increment), then falls back to claiming an unassigned device.
>>>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
>>>   to the DMA backend after resolving the correct CB device for the
>>>   calling process.
>> Oh, stuff like that is usually a pretty big NO-GO now.
>>
>> AMD has made the same mistake with KFD and it resulted in a massive chaos.
>>
>> The DRM file is the driver context your process uses and even if there are multiple DRM files for the same PID you should absolute *NOT* share anything between them.
>>
>> The general rule of thumb is to not attach anything to the process using the DRM file descriptor.
> A couple other things to keep in mind:
> 
> 1. drm device fd can be passed across processes
> 2. virtgpu/virglrenderer drm native ctx is a single process that opens
> the drm device file N times on behalf of N guest userspace processes.
> 
> All that to say, Christian is right here.. drm_file is your context,
> pgtables should be attached to the drm_file (potentially via
> drm_gpuvm.. which you perhaps want to use).
> 
> BR,
> -R
> 
>> Regards,
>> Christian.
>>

Hi Christian, Rob,

Thank you for highlighting this.

I'll rework the CB assignment to be per-drm_file. Each open() will get a
CB assigned from the available pool (find-first-available, not
find-by-PID). The assigned_pid field and PID-matching logic will be
removed entirely.

The hardware has a limited number of context banks that serve many
sessions (on fastrpc, via the DT "qcom,nsessions" property), so multiple
drm_files may end up sharing the same underlying CB due to hardware
constraints, but while implementing that also, I'll ensure that the
association goes through drm_file->driver_priv, never through a PID scan.

I'll also look into drm_gpuvm for the longer-term address space
management as Rob suggested.

Thanks,
Ekansh

