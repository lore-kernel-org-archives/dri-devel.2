Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC30FEEF25
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0902110E2D0;
	Tue,  7 Apr 2026 11:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DAzk4miI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qosw0x63";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F56B10E339
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:29:56 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376lJTX3536830
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 11:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RT/YMykjz7y8qLINEn2TgQMrKn6NhuK5gzEeRKqvkL0=; b=DAzk4miI6YyESJLv
 vG/jqUE0QvZ1K2bIW1DuxpNejt9SWRH3yM8LrqLrNeNRO3Hyl50mpjgO8DyNiCZe
 82Yt2cHDod3LyovwLPJbzVHGSDLXcoeAx3gHhiohUTBlZJaCNi6IlSfs+nNEHRS8
 a5ls4W1ydLCj6EB1gOF0jhW5GSASYaf78Hy27vH4QSlZOsAzOMxd37M/WszN695R
 X3Jof/L+lnZ3ZJhaBVbdPwizr/ihQWie8mRbFsreL/RCNf5jd8I6M1DTRPVC1/yx
 j4haDunQOf2HDANUEKkiAPixTHViR4nsvjsokkcN8IevdNo4VdiNqqEsZHy4cSeo
 DIvBvA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra2g6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 11:29:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89f548d0872so16625786d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775561395; x=1776166195;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RT/YMykjz7y8qLINEn2TgQMrKn6NhuK5gzEeRKqvkL0=;
 b=Qosw0x63Xp3VAI5apAOif8CZL1SwIp3lFf2gGAi8WbxrHMP9Uy8EHrAyq/pdBJNXRv
 AqbGTxXvFwGkq58iB8lbFew/N2wKUawIAa1f2swRZBN8JyjLzISgKVxxqClxNVvh4zbw
 lG4b2BQPgvqAmdAtUF1I55yx8mOvLchorVw69lErW3CIXxxF/xpZI/lfaqi1cJ+d/owt
 bsM6P3Fh4jhf/9tt/iVEbSeqRYuEWuo6ZKMcPzK3LTzRcwVldH7/mZtEyNNW3Ug9ZD2J
 EF8wAdcEK/BT3y2TtCSlcbaS/ZuoYS6d+LbI4EBrmATk+r2Qb+xkeNevwhd5oZojj5Tm
 hbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775561395; x=1776166195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RT/YMykjz7y8qLINEn2TgQMrKn6NhuK5gzEeRKqvkL0=;
 b=Qim2iAi4835bKxwB3g2rl5/FQm5TBR5Rg4Q3yEJbpSb5JRKizUV1sSRu5R20OOQnrI
 gWkhtW5RH+ZzqvaefKkV9gl01grwFmmfg5Dy+s7ajQ0IjEr4T659BFtKgH35JQscYmuC
 UjB63FEIGrdrz26TFYGBtOUXa8N8eytJwFwCVr2feq66YPbdzQUy+frg0p3hpLpxclzL
 JGW4HNR4lp7poeYIVj3blp+hHqPQ/yb0y6618xq7l1lZU+IE0wHU7L4VcK73qm+mNOTl
 k4XRoclOxq55wB7SMWzvqVrt0Zn2lY2BbFGPv9Ef4wDXoqI/Xr9+w25Mn2+Qt3mq2OlO
 91zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaAjFf3/C0MF1kxft21lXiPsHiawRO2kAF0LMA2YRnfuLv2nVq4JeoyBO68CI2mRHzQQt53U9XXvc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypinHgyxOcSAsV2UtWqZFXC/MCkeV208K03NdsDn43iKQ1bYBU
 hBXWUHSajlqGc0pNMtRJWY1BGEXi3PYkneIx2bBv4DvPlHkdmSvfDZQFRJp/QLKmQD1DsIvu3aP
 yxxf5QIpTH+9uXdo4mQ3snwuRF9Hv6kYK0R8zNpHpmy5FQwuO4IOxEq1VrWUdiE8Y1YALGa0=
X-Gm-Gg: AeBDievxFXtMeMir1gxao42dWZy8x7s2CHdjM/inoY2dMqSd9A829VD+ch6HVEztXfD
 6i/2zSfF+hLpRs/NlC2khYTCK2Ttqyle3flh2uGj3FgHR3g3/9P9j2S5/XOTkZemJQ1w0+rGJQW
 W25XgQyc1nTKOYU4ybNtTLhxxV5nAjo8kgHIbP17wQlVQKw2gDWgE9NsARinCjqTkfM6MgDHGf+
 yDhSgiviYoySCoVNNQ1OT9LCOqz4VcaPG9/u/Hu+1F0SEvhZhp3fhty/sSNzfKhmGhkOGawXTuf
 cbNfQb2Qx+4euCbKsnsnfdCBjkX+UDiOw6uJ6WQxgerKBms5PZt52KedDgqGxS6XXlJIQQP9EPD
 o/CEd0wPID4jGFNquXT2+NC2IVsM0GKFS8Y17TQiIF/2AVOOVlEe8TcVoRzS4MNVw3S9VthYU0H
 ouiXY=
X-Received: by 2002:a05:6214:4113:b0:89c:5285:200e with SMTP id
 6a1803df08f44-8a7046ddb0emr200475666d6.4.1775561394708; 
 Tue, 07 Apr 2026 04:29:54 -0700 (PDT)
X-Received: by 2002:a05:6214:4113:b0:89c:5285:200e with SMTP id
 6a1803df08f44-8a7046ddb0emr200475226d6.4.1775561394274; 
 Tue, 07 Apr 2026 04:29:54 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c99ec7csm541081366b.14.2026.04.07.04.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 04:29:53 -0700 (PDT)
Message-ID: <73196147-0133-4646-927d-dbe93c254286@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] clk: qcom: gxclkctl: Remove GX/GMxC rail votes to
 align with IFPC
To: Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-4-4bb5583a5054@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-4-4bb5583a5054@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xwJf20oyeG3sl8LiVwwrNbDri965x-Ax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwNyBTYWx0ZWRfX/gFSnhZPDq7B
 qzam19hHwr3B1pfRc/ADrBWZzUGtlwQeWS0h//Qid0yaYdD1/N4mYr58oYcYxyc9ASirPdxCiV7
 dzpY2Y2xY84j5e8xxVPhOtQXi+Q7LNmoDrRgGP7eoPP6DnWS/My7T80mom4J6mKrG5/oS+uvoiW
 jwHHkLnS8q6uA5ikzC8De3ThegmJz5gDQHKVYNsOrER4BjTDjnVXG6j1DTV466YwLYbbsMk5z61
 QUB+8e8KPXUO3BV9DGSBqdnDIOa1lfjo8OWrDMg0UaevKFtQoteGAt6vkwbRGmL4sfg4NF8ujhY
 ibwt8n8tvttoj/tFfv9YXVd9NihwY0xhk3BWE81wg8tMHApC2819M9QcuD4JyZCmN7yYDKlCba2
 tvGI8ay4xxaQSTtRSQcNvhZFLlMAjT3GRyLmdMdcUZvmony7Ls0D8Y6d+Vvw5peZN1Ak7EF+72m
 r00Hy44iHrgGEQ7oISQ==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4eab3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ObXhwGULgzmC2I4GqhAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: xwJf20oyeG3sl8LiVwwrNbDri965x-Ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070107
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

On 4/7/26 11:30 AM, Taniya Das wrote:
> The GX GDSC control is handled through a dedicated clock controller,
> and the enable/disable sequencing depends on correct rail voting.
> The driver votes for the GX/GMxC rails and CX GDSC before toggling
> the GX GDSC. Currently, during GMU runtime PM resume, rails remain
> enabled due to upstream votes propagated via RPM-enabled devlinks
> and explicit pm_runtime votes on GX GDSC.
> 
> This is not an expected behaviour of IFPC(Inter Frame Power Collapse)
> requirements of GPU as GMU firmware is expected to control these rails,
> except during the GPU/GMU recovery via the OS and that is where the GX
> GDSC should be voting for the rails (GX/GMxC and CX GDSC) before
> toggling the GX GDSC.
> 
> Thus, disable runtime PM after successfully registering the clock
> controller.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/gxclkctl-kaanapali.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gxclkctl-kaanapali.c b/drivers/clk/qcom/gxclkctl-kaanapali.c
> index d7cf6834dd77c2a5320ffb8548cdb515be237bdc..d470ade11b0d11eb40843fe84c809e71646dce27 100644
> --- a/drivers/clk/qcom/gxclkctl-kaanapali.c
> +++ b/drivers/clk/qcom/gxclkctl-kaanapali.c
> @@ -7,6 +7,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h>
> @@ -61,7 +62,15 @@ MODULE_DEVICE_TABLE(of, gx_clkctl_kaanapali_match_table);
>  
>  static int gx_clkctl_kaanapali_probe(struct platform_device *pdev)
>  {
> -	return qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc);
> +	int ret;
> +
> +	ret = qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_disable(&pdev->dev);

My understanding is that this works because we have more than one domain
associated with the nod (so the generic code that would otherwise enable a
single one so long as the device is resumed doesn't apply) and your previous
patch ensures that after probe, the clock controller is being put to sleep,
right before pm_runtime_disable() executes.

Is that right?

Konrad
