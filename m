Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD2606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLVwEfMa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q0Lc5a+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A7C10E76D;
	Thu, 29 Oct 2026 05:36:35 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FC810E76D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 05:36:25 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5GwMM3341120
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 05:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9rrk0DoqOXK6wTcBk254IiD4um5GCM7sPdSiLC3uULQ=; b=TLVwEfMakAs6PB4Q
 p9p3OujGCJ2pTjhJYLMjThVakBXfVBcBUHHCy1THoDddEqOJesE7CN69fBoFkeIa
 utLbGQEOhzG8uZ18aQ5WuHjbypBgkh7lXRrHJaaZmDLdn77jgBRLjgLerz2JLRlI
 BnzmvcYd3dqFJRetHukHfuFeI7HvFWnwxKJ51DquEo4e4/oQEX77A0JDHnMvCmyP
 67ax6qNdZ0JQ9tZDSJnabSUsWjMgFgudUjvr41SrhSb95Jhj5tKytWUAJTEgZRRR
 46RTKsEfwE8pRGfqUCJKkiKts9vtglLOHFc6ALYxOqNeXL9nFYNwlZtg3IuCxgOa
 6ulRog==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3guhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 05:36:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e93f67358eso17057545ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793252184; x=1793856984;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9rrk0DoqOXK6wTcBk254IiD4um5GCM7sPdSiLC3uULQ=;
 b=Q0Lc5a+G6jNE9cExFm1T3ocTXTgnBP9gXyebkyfjSv5AME73Ut+0lO2pYfxRBXQ7e8
 drHkEduJ68DojATuVNw4ra91p0oeQlrFoIw8t7meCc+4w0Bfvrj3fZXLuSVezPLhqjO2
 Z8x35vglNvdqQh6Xbe6xkVrEpm60/g8dVpb0n9VGJn5bfMEEaROjWdC8JcImaAy4WSUA
 6aeXdImLRJ/5noBHINerQRCvgsL7Td7PDOpSoFt0X5RfWguppjIkr9o6Hf3NfC3GSiKt
 4LtjKJ2Ntxd/LMx2izhJz/ezR+lEvU6Pme/4UCoFjekwlIm0oZEG0Rz7Qnonzvbym6am
 l4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793252184; x=1793856984;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9rrk0DoqOXK6wTcBk254IiD4um5GCM7sPdSiLC3uULQ=;
 b=P48xMvUvGphMjXYLiEckiTv7i4xEUTqbc1HwnLUp6JIGPA36yzfRrJO25tczY2jN1J
 9jjrq8H9MiM6+uqAYY3fVSAQVdYvJKJF38p5wqOq0iQSCSIY1zlZWwnYXlnsV+Rj+fF3
 xLq3fW1GI/8YZOlS3OI9DimaJPWmp/eeIVuox1Mk+SPJ55+BwIrVgN6Sc+99Xx5E0WOT
 7AgG4tCJJhX+2TBMA6yl0Le4wy5VGFPe9H73X4gA1FRlo4HKjygPp7bIEwYZZqi49yvG
 tuFTcw8qoHqcSg/4yaXOlH26fKHDdT28pyCdC9Q0GXOZrJYDS4NyWMU/62CVoU8Z7DkT
 bj2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWIyDPFPw9n2MLZqKZSTarqlse0RXKnj0WRDNTOitiUPCPclnVu7fwU1i2MovD/I42p3fFx/E6Afw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKGdRLiC+K5jT4oblSAhgiFPuVFjkVGe1BnI1Xznvapsh5pcaH6
 Ap43xJ0rfsYUi/bOvO2UM2Hfu1IccNzHAB3HUFwmQ1Fg/qq9FpUaK5JLF0CyfCOIivsXWj8K0eT
 yn8FjSrR78qXwyeDhQ+aLo4bjZ5t8cr3wz12W6rGaVcX3C1FuIG2YE2c58S1KZrdaeF3mQzA=
X-Gm-Gg: AYBFou170Dg57TOfO8bmS3uWG9Q9I6dgWVBRDt1fLUL/rYbHniwcHGSUNxdJ3bUF1DE
 0c6LyzdiG7Zz86AEvO4I+CSCsNrSj3Nr+8/9X6oShlKRTsuKbHBxZA9vvZv3ojxeOyk63tfxrkX
 NIWtrMsxsqK7s96EiOwo88JRBVfElMd2Eu3Jf1fZD6mcs4rIkEPM0bfAvfiSbmRId4PD/Om1iPi
 eTkjTw/YkkO1dlNINoC/PTAAHseEmomuS4kaUDCf7MiVgP5mUX/pxRKeWVRvEldViiDH30MPhTr
 sKcV9qiS1MMgbwunRCDrRzaBjg/Ho+mC7ebdolmMyJ3BUu4FHVFMFMlboNsBTNYzjmW+zU7ig4K
 WR0h1OJQX/5mTNES0KOaJmxiQbY+UgarRVA/RBk4l04YqLTZrSthXxbD3uwdlLO9RnCjx39yfSZ
 /hTlnfEQ==
X-Received: by 2002:a17:903:380b:b0:2e9:9c65:1aff with SMTP id
 d9443c01a7336-2eb0041ee21mr40133625ad.45.1793252183689; 
 Wed, 28 Oct 2026 22:36:23 -0700 (PDT)
X-Received: by 2002:a17:903:380b:b0:2e9:9c65:1aff with SMTP id
 d9443c01a7336-2eb0041ee21mr40133445ad.45.1793252183141; 
 Wed, 28 Oct 2026 22:36:23 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c3d17csm29267465ad.53.2026.10.28.22.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 22:36:22 -0700 (PDT)
Message-ID: <84e53a4b-5ea1-430c-90ce-09d98948c8de@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:06:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: fix double free of the DMA bounce buffer
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Akash Asthana
 <akashast@codeaurora.org>, Roja Rani Yarubandi <rojay@codeaurora.org>,
 Wolfram Sang <wsa@kernel.org>,
 "open list:QUALCOMM I2C QCOM GENI DRIVER" <linux-i2c@vger.kernel.org>,
 "open list:QUALCOMM I2C QCOM GENI DRIVER" <linux-arm-msm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linux-media@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linaro-mm-sig@lists.linaro.org>
References: <20261028153353.69651-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261028153353.69651-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX7Qg5DBLbXMTi
 6qOkw41PMOZU4Z6cFrTL6gBMa1JXmWaT5DhAXgt8epKqBnZYxQbY1TOJPpAt9PBUzsdjEahtaFS
 DwWd1XmYOlSKwMIadPrY6NDf0NDTfCU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfXwFDTr91UOgBq
 cMEsCGOHuf4POFjrBMlbDWpSCyrx3Sd43IhTJAZ9ZWu0LjN6I8SVPykhPttT7T+eYy5vknHYYH8
 w7cPXQrOVmHd/u5yUc61nE8WZKSGIoRNZg33cNH+n6g9j6Bh+bBo3fFBSCAjfhxLSsOU6CmajVe
 E3sHmG1X/X4EPi0PXSusRndvXYRdFsywaPw+tBwkKagQy89hxJdyA2byjGLx08F4GbPZIOYnqY4
 H8m0ONe4P+F9Lb/VT6M/vVS54WQ3csbl9HjU0wcX43HOfefsb3MhVvws65rAf5wjCX3sMxY4kXR
 JrlwlKo15FWvrHxA6RROo1K6t4hT8qzIhSmGZOkDve5wwEp46QadzNsf97BMxuY5lakuJLZcTZE
 1mWwHls4lAzlfJ8JPvTXU/il0TbPlNr8I4RSjIIRy/SxuIvGY0k2g2SMWM59Ddc+Ai5XJCzSUu6
 7LApzn4Bnk5a1UJIYxA==
X-Proofpoint-ORIG-GUID: reWAGBwKpT3Qf6KzHyJTCGFGatl5UJng
X-Proofpoint-GUID: reWAGBwKpT3Qf6KzHyJTCGFGatl5UJng
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae2db58 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=5U0EVFohHyNS2EaXvY4A:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290021
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/2026 9:03 PM, Thomas Fourier wrote:
> geni_i2c_{rx,tx}_msg_cleanup() release gi2c->dma_buf through
> i2c_put_dma_safe_msg_buf(), which kfree()s the bounce buffer when the
> message buffer is not DMA safe, but leave the pointer set. gi2c->dma_buf
> is only updated when the DMA setup in geni_i2c_{rx,tx}_one_msg()
> succeeds. If the setup fails for a later message, the function clears
> only its local copy, so the cleanup helper sees the stale pointer from
> the previous transfer, unmaps it again and frees it a second time.
> 
> Clear gi2c->dma_buf once it has been released.
> 
> This bug was found statically and compile-tested only.
> 
> Fixes: 357ee8841d0b ("i2c: qcom-geni: Store DMA mapping data in geni_i2c_dev struct")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
