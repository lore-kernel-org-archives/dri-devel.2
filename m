Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76E2CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F64110E63E;
	Fri,  2 Oct 2026 16:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B865agWi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CddiynC4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D6B10E63E
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 16:15:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGciq1042848
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 16:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4taZxg5NwikgZ8WugpDCZYo+IsY0Yfdh2Zj5teOGtTI=; b=B865agWiG5xspc+w
 WgWYYTqo+iTDyWJshan7tS/0iYYuC8lGR+4kwt/DWsWZKIa795pZF27cbe5MihjV
 HKaFySRImpS6J/rh7LLasYujdDcU8h7L76xmVtGIV+LiEUsfI1vzif/j08NMiGiO
 ckIBOi/xvfPTajGZ9z4IsoXv/RugnUSLiX4rHydwuqwFU3iFLE7+SRQb4d1BYK9/
 gMcyCvakdcmjBUnO0S3tcfq9+xHDde4iH4Xn/R0Id6wfWLUwyBJWeieCyJoxEpSc
 K+VEX7rPjVS2tfVizRj0Qzek4I/lIo4liYJSRTIDAhxPWgAd1j2HLjtRfsodcsWy
 OZAQfg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2dxdgktu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:15:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so109672a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790957724; x=1791562524;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4taZxg5NwikgZ8WugpDCZYo+IsY0Yfdh2Zj5teOGtTI=;
 b=CddiynC47HFcI3Wem68/hd6ccbADk3CqNYrkdjwcM69NlabWnMixPHR9kaA+FsPpXD
 Nf6zUBs1Uj+0pOymmAPeptc3zdfFN7EqvGd7Co8ZFUSqsO6ua7k4eyXANexuHLL9kijF
 wG3wLVsJi1KCP612UIh4/06UBg7TTe6g+ZNSj85c/fmY26MEC2q8oTfrKrePiw7VBsV9
 jMrTLiHDX6POfC0DaInSwp3Vmx4FLLPEEyZIEnLiORi1nVMtztiqVGbzUiOs3Y4oSsp6
 i+pj97mIeLKD4X/5ZBLZUCINp1/KEJwNeRKDI3NDNRrws4CjxM6mKuKdK4lNsPTH8uN+
 CfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790957724; x=1791562524;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4taZxg5NwikgZ8WugpDCZYo+IsY0Yfdh2Zj5teOGtTI=;
 b=vAXbylmz61mAjhPCzk9JztV2xYs3xWLwVwOBU7l0QmjeDB8cJ9uCkRb3N3Scti3npV
 REhJO48r4i/iHUh88EZ78O1GAj/FCLcNtrB2EaxKeapxdB5JvayKcsSUNX+WMHWjv7wV
 ZqrbWipHVfjJLA0A+0IXKNq7NhZjBKZk1NXOc40BuROLolOUiLOesuULqYBBqRCN5fqW
 VJcXBYyqzyGP35fb0ja32TP/eSJ3Al6H9fK6jZI5JfBy1K+ky5aN1PMvvH0RnrqfyY9z
 EpCT6tWOxFX1QrPjApsAfvS0Owcg7mKZpTpVwLfVmEr3CGlgul7IawNAooAycike5PDu
 LENA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8Fd+phD/lUXGafba1dSI6fuVzh2qZcJA8gaFHG1zq87Ds2Xx3btuu/mzUFmhnnbdOwUBJ4P4pABQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ0Q/pUGr1SM5B0UdiO2TIXP/D8iLRci6eMe2rnI0mdtNkE6xUC
 PcZwQUgNRnHoUff2GC7UowFfHGioSE97aaATU5fueRfIHPpPEvev0BvpRRC7OHdGTvZN237nsuq
 5yGhiWInzaQzU7a3/mqbkqXW6Co2r4MmfxP8iUN4VDADpbN0oZdWbIzw00u1bpNqVDRcFfAA=
X-Gm-Gg: AYBFou14QQGjyU1kwZCS/rgGO3VYywbLx1Z/znagBao6Ew9mtTufp9QueqUK1nLnhQ3
 1VrYHUtdmK/hWhoOXt7jt2drpSUWhPH894uUvTv00UuPgN/QJnFfkEIXj2H6uBo2gR7uXZIcYgH
 tsxSh/QLeBDeTdFw769GNRjeLG2JdoaZmSxhYGEBGCwCV3bmFabbs+WwohCWPL7kzWczvrlTyUb
 gy1UqZjbAUKfInwGmXhx5a2YwU3fzxp12DdMkIrdW9RUVDPu2qbwz9RqxZXfsgw6Mzw8r6Pxe9K
 RBS/XvNMjEU9QczrnW05hUXSdAXZ1JqkLgAKbyZLelkAkMkS7yCAaSwQdRn4tInnzvBOn7thchp
 O223fxmSN0ATrtz6iao+lMn6Z3OShxugtlJSWU5l1I9ZUH+7hrg==
X-Received: by 2002:a17:90b:2804:b0:3a0:50bf:d497 with SMTP id
 98e67ed59e1d1-3a6ce5fa39dmr2940510a91.3.1790957724411; 
 Fri, 02 Oct 2026 09:15:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2804:b0:3a0:50bf:d497 with SMTP id
 98e67ed59e1d1-3a6ce5fa39dmr2940474a91.3.1790957723876; 
 Fri, 02 Oct 2026 09:15:23 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f7384ca1sm1221797a12.21.2026.10.02.09.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 09:15:23 -0700 (PDT)
Message-ID: <439f1169-5fbf-4d68-97e3-c37f31b2116b@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 10:15:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Cancel Sahara read data work on removal
To: Myeonghun Pak <mhun512@gmail.com>, Oded Gabbay <ogabbay@kernel.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20260917192512.56205-1-mhun512@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260917192512.56205-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NCBTYWx0ZWRfX9ktjnEEi2VeQ
 xji3A7tcVDQQyG5k2xxL3IxXN/l6uQrI7hzBQHRo/QvJmT4QRDABX9k3UmtzSzVWYYji2ibV3Ua
 V2PBEBuwfNvZetktzOyYdeqnAfcIkks=
X-Authority-Analysis: v=2.4 cv=Ko/YSmWN c=1 sm=1 tr=0 ts=6abfd89d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oeivAFFXM94eOaBaf2QA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: MQeBY3KuXFRvqf9jV1LguE5s6caam6q1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NCBTYWx0ZWRfX7BCWro/c1SN1
 44NpJ1AiuJRLwG9TuJMbY2FPWp09SyXFofD6/Ll1XCfA2f35AX63YdpBXsIhWfadvX4Djaas5mV
 c+lYOoslZ8bw2x3DvZ5qByRRPPG7fTMiYkBBuklTlJCyJcCTV00WndZ5auM8ZQlgAqJmc0njet4
 Buxs3qTcl0II97kLgcrs35uESX7F2ehkNcZDEfIbgB/CQiHh+tRkDkXRyJV1L2uUZXb3uNHlaHk
 QlF2HIPaiwBWRxB0HXON4u4zUEXXz09/yDE3EPZGOeZgYw/Gy0qqdO5/H41GAJocmBIHFi+x+Sc
 ZaCl+N4+qEInRXZpf/jMZkwBPbJMwYd3X0quI424kWrMjADJCBLx55FgG9FleMxUXGza3riksyI
 fJ7sKqbNJLPkO1C7hbSKc4wx+E9dz7ONr3Nz6KMmoaJe4ROdDtkuex+lrUoRTAr3wK89bEchlvY
 vqvj2Tzg2sq5CT4YN7Q==
X-Proofpoint-GUID: MQeBY3KuXFRvqf9jV1LguE5s6caam6q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020064
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

On 9/17/2026 1:25 PM, Myeonghun Pak wrote:
> Sahara removal cancels fw_work and dump_work, but leaves read_data_work
> pending or running. The latter accesses the firmware and the device-managed
> context and transfer buffer, which are released during removal.
> 
> Cancel read_data_work after fw_work, which can schedule it, and before
> releasing the firmware. The MHI core suspends and resets the channels
> before invoking the driver's remove callback.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code. The same omission was also reported by the
> Sashiko bot while reviewing the Sahara relocation series.
> 
> Fixes: 7fb19ea1ec6a ("accel/qaic: Support the new READ_DATA implementation")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260701105055.8D4371F00A3A@smtp.kernel.org/
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Validated with static source review, apply checks and strict checkpatch.
> No build or runtime testing was performed.
> 
>   drivers/accel/qaic/sahara.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/accel/qaic/sahara.c b/drivers/accel/qaic/sahara.c
> index c7c0b3eb4b65fb7776a6c724cb3105046cf6f7eb..6487961bbf14a1c284caf91f500968b90a064ef4 100644
> --- a/drivers/accel/qaic/sahara.c
> +++ b/drivers/accel/qaic/sahara.c
> @@ -879,6 +879,7 @@ static void sahara_mhi_remove(struct mhi_device *mhi_dev)
>   	struct sahara_context *context = dev_get_drvdata(&mhi_dev->dev);
>   
>   	cancel_work_sync(&context->fw_work);
> +	cancel_work_sync(&context->read_data_work);

The typical convention is that ordering of operations in remove() is 
related to the order of operations in probe().  Adding this line here is 
arbitrary where it would fit the convention better if moved one line down.

I'll fix that up when applying this.

>   	cancel_work_sync(&context->dump_work);
>   	vfree(context->mem_dump);
>   	sahara_release_image(context);

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
