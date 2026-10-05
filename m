Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9AECA5FE2
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D7A10E222;
	Mon,  5 Oct 2026 03:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OlVcNXEE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fJ/lz8Uq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6076B10E222
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 03:43:02 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510JV3931004
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 03:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EbPg2aQdB3WJiIm4v4Ostya5
 4S6FCqAcPPGhfO25FV4=; b=OlVcNXEEDPZC2iM3iL/LN1OWZVcT2ngczKHLkmPp
 CoxkL7w8EmQZMS92I0lg5SE8VBbnX9j9g5/OB0VkHGZC2qaGtdcNqYPOOP2YmguW
 LwN+ReFfCutdNl2LzNHtsPudZDOyDFNxKmqL+Lt9QN7dSd62sk/W9cCS0Ihj3wRS
 Lpa7W5hcuyzOWSI4I5bO5DEBMamjNPt4UNV3bvtmfsjK2ZmDqL8P0LGhHftk3TKl
 r+Vc8a7sSdN3+F4dF2l8nancbYyCvzVZov8Bil6HyJOocqNKY8b9iMdh1J51DvoK
 ymqNTsGppFQruLihreDpQRMPOejwRRdkdl3EIeJrZAht+Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sq8vbhh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 03:43:01 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c039041433so1411951137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 20:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791171780; x=1791776580;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EbPg2aQdB3WJiIm4v4Ostya54S6FCqAcPPGhfO25FV4=;
 b=fJ/lz8Uq+iCkES1sPhuYDg85/DjLWxVMkhaPhR2kKzjjnZIBh7D+G8kM+dsQa1/S+x
 gi++W6Bc2zRWPIGxSxcuJFekNGQmbQ213W4/0mD9VNClGXBrOyFTsn8Xtmj80YYrevKb
 BHuRSFUZfAFoL/mTZ8UH4m4DXOpmp4iYOWUj/kXWeKpV9bydFHQ/UFnlFsO/xvRJF9Ug
 hT2N5fAyJMCSh0oNvOoAt3kBnhidckb2cZBNYvmvmTlP9hrNwOYT3W57YF9NlYENkpnV
 Fl47oL1ILAByucDdjbtyazEVpijwoz7Kv5yLT4N/iyod5sMqQjaS8mehl5uXIYd6tNyY
 fbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791171780; x=1791776580;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EbPg2aQdB3WJiIm4v4Ostya54S6FCqAcPPGhfO25FV4=;
 b=Qva4oGd3TCwhjx8koLqhEnEOQpQR5Jg1ygR+jdlhMTJVWnWHsd0Im1SfzWY61bHXWI
 zbQ/PJ8VQy6bHDIjiorNyHMITc+C1FtcjW7K201Ejl6ZdnrppmWOovZRrykMFqL4HCKI
 1jmNteYqb1npzLFXjfJNa/bWkzZDuURHXWK0Zrfsu111f+4/KxSrqXJl/hYPuncW0s/U
 G4m6PgzwX/OtbIgJM4LsIClRdTol8mAAVy+nBKHvYVqwQLx4UyjuEMH6qBjw3BcoX13M
 il5poeJAtEp2qtbSzOX1e81G5AC5JwxyRmTIC7NoMtAI/kjh0xd8eoAnNgTRgBc+b6KB
 BSnw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuHfUN06cY7i1SAtnegotTjx+2vnTDztazy+5VlpO3zYDKmRqYjyWpR5dEpmOyS33ItL4jS6VvU5U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKBJtcZX7Dm2aYTLBRiMrUW0WaWmjYNfI8MB+ywhbMG+xiZo6ob
 g8DITWfS2DnuHnGr5/Ok/DinsDRdmj5tFCaKf7Ukk5kHJhJkOYsX0if3jt9atwD4cWmYZgnZaQd
 eV+kNq71BLttQ5XNdTyhmpKjtZclkMLqVTq1Ou9jfnMvRzaG3oZxPhDMGF4p5CStTaExnPTQ=
X-Gm-Gg: AYBFou2gvlbayjJgObS+HFoKnf+obZcejwj7x+FOz72X+ChNMWO+pTr1xzT/nq+tiyy
 rHfKLS3UKHcYSxnE1OEFCvGmlV7vk+0zjQtXDrX+N/QZeXuAeRwu4Nl2PQCyMqXb6Rnl6aG6LN3
 bIGjaszlFI+Sr+l72bB/o1W0hqL97heLBqepx2oFfMoYnja/CmgTYZD3em1X1szH5AeQB+jiigd
 02uyTbFgF+q8+9/iGtjfziN56j5iB/O1vV+oX9F8JOpCjrWoMiONzloUg4TXMVu0z+j5jF8GSZv
 VcKFrUdvuyskKfqdPecms1rfROpUehkyHZxXQD20DRIG+ArC0yvOLxlDf8sQwuYu5AZTsri5wst
 MCbTeAEJV4qNvIVbGSJnLHkXfunugJyLduRS7Nww8SsclVycn8ztSo0eMA6xhJf5LAzvP4UapAp
 FfIGz0h2rl5JOp
X-Received: by 2002:a05:6102:32cd:b0:7a3:4e75:d1f0 with SMTP id
 ada2fe7eead31-7c2457ce32amr1571279137.23.1791171780354; 
 Sun, 04 Oct 2026 20:43:00 -0700 (PDT)
X-Received: by 2002:a05:6102:32cd:b0:7a3:4e75:d1f0 with SMTP id
 ada2fe7eead31-7c2457ce32amr1571268137.23.1791171779894; 
 Sun, 04 Oct 2026 20:42:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e3235d5sm36801331fa.34.2026.10.04.20.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:42:58 -0700 (PDT)
Date: Mon, 5 Oct 2026 06:42:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Piyush Raj Chouhan <pc1598@mainlining.org>
Cc: srini@kernel.org, gregkh@linuxfoundation.org, robin@snyders.xyz,
 ekansh.gupta@oss.qualcomm.com, andersson@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/1] misc: fastrpc: Allocate message buffer from
 remote heap for sensors PD
Message-ID: <rz6rhmd46qcuaxrajxxaqudkoqj6ere5gdlb7frnvd6hjwapuq@kj3ldploadu6>
References: <20261003150559.6926-1-pc1598@mainlining.org>
 <20261003150559.6926-2-pc1598@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003150559.6926-2-pc1598@mainlining.org>
X-Proofpoint-GUID: V2hI75KZ_T0JqmQehSAAt_5mmkbZvC44
X-Proofpoint-ORIG-GUID: V2hI75KZ_T0JqmQehSAAt_5mmkbZvC44
X-Authority-Analysis: v=2.4 cv=TKzQ2Fla c=1 sm=1 tr=0 ts=6ac31cc5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=OsHF4jKAAAAA:8
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=4qQ1mRuE16t6AV9Sk90A:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=aAwnOj5LE8VeXseigifb:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxNCBTYWx0ZWRfXwg6R2hflxxLv
 x3njJzGKw3IM11nWwrIX64tGf1eajxXAdw3qJHmvGhy/cVlvyfG/RauR7QFT08JuVRN5VmVcgIq
 RtxBdwwk8lHTquS/lfHVKMml9W+9CcxRwS95Wp7fBcAF2G1jDaSq4TPsbLMpyWiugAprAeUEvT2
 OYgGrsh+J3BLRIubz5f2fP7+EQLmdt3Z83T9CKtTV0VpkpbjYoB2IYN08NKI3xBijawgLSbxUVR
 nQujv8Tn+L5b63r2EZSlWxuHcpvXgUussanaKQdXpuuHm70cHGxNczm01Qp3qCAa3gPBnpiws+v
 cvNKyN53FG6XAvFY35bSGWKho0IQ9JRZCV2qHYqbOg7hpMHJ8/V9OedoQjVyiv04z2/PP/Xlx0b
 jjhOK7dqi18G0b+g+hA4cbQjocNZLk+iD5LRXYpj4iWVSUazkheKKQBSKyINlooYjIO5CwrZxEw
 nBuIb/tzoZYhYi9lSVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxNCBTYWx0ZWRfX/dO1rYtpawNB
 bnt3bpjd7ZG5OMLcjZkqZRgOGeQSJ5tULe5EtNnVvHQAmGVG6QGYOE+/Sp5EZQlzr+m828x1/sO
 AydTpSa1MgVw/36bIFLdwm0uyPbZuy0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050014
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

On Sat, Oct 03, 2026 at 08:35:59PM +0530, Piyush Raj Chouhan wrote:
> From: Robin Snyders <robin@snyders.xyz>
> 
> The sensors protection domain reaches the message buffer directly rather
> than through its context bank, so it requires an allocation from the
> reserved remote heap memory pool. Using a context-bank buffer allocation
> leaves the DSP addressing memory that is not mapped in its address space,
> triggering an SMMU context fault (e.g. 0x1fffff000) or bus stall.
> 
> Ensure the remote heap is used for SENSORS_PD invocations even when
> a stream ID (sid) is present.
> 
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> Signed-off-by: Piyush Raj Chouhan <pc1598@mainlining.org>
> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
