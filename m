Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421A606A321
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M2SSwTqG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LBr+sYhF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B34910E388;
	Sat, 31 Oct 2026 21:48:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88CED10E078
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:47:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VJFeRB1359555
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UqYmn+dWGZ+bizn6nanBskc0
 M3ILH51untQXz8qg9Lw=; b=M2SSwTqGeuA0H/yPvVtef+Mp8xkHwwFekiHn0kBD
 IXkY8io9I7OOYrQNJc9veFLHQb/MO5gVqbJ5k0W/pdOnBUfT/j1tjPj2FdmaR+X6
 VvCxH97ZunhjVXdQFnvieF2sLRVVX/hTfOBcMkH3nuOVxn4QgzIJt1xrERdxXyOs
 03MMKpdvcPhhoWPCgvmJS4h8+xe0kGrSxOJ+Dix7JzCr/EMKLx78H0/zKj8ugeEb
 yCzE9/SlZ2sSogLTZlqalPlDO1WmzEuIcurm/8MOhU4MpCXTNVh6WJtR81AWSksU
 PBQuRM6eem+E2fV3GqzAYiYK4JgrlP9tWYQs3mYgU2zMVw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9gk1xex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:47:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbf2fd504so324719985a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793483272; x=1794088072;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UqYmn+dWGZ+bizn6nanBskc0M3ILH51untQXz8qg9Lw=;
 b=LBr+sYhFO1BmSnD6hOqDY75teIPwLPfw0RLMdVJHzK9kmoR7dPeGkg1xofoyjJb6LK
 ET1eguWJttQtm8qj9utKBMmJ58jWQLLrr0ArVEDnfEzWD48doeR+DnWEULZqq7beZRWi
 J0vlTTLfpefBuqyP53/uhio3ToR88hxkuZujNlAhGB+4k2OPR/otYywmpJFX03yj+tj+
 58tlv29rW1vwi+lOfIW1y6DcCyX3l6kpe2t6ze0NpvHXcOWcN9WJAWOnyxx+sJNv6BLL
 oefUKJ4bXttL9ZfTb5FZqT7Zi16a4JwSro0eIVyzu6S9tV6tVgdcgIsgKMWftc9USO67
 8lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793483272; x=1794088072;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UqYmn+dWGZ+bizn6nanBskc0M3ILH51untQXz8qg9Lw=;
 b=iVAkhlGN+4iyAAbRYH2HU63ESU+ED0uHYOohr1eA38lcTrzlb+DIqBKYT64AMcVtyJ
 IjhmfbiCB9X/scN0rRjcSoadVZbtDTCH3CV0iZ3BMvBiZEUBgZKUAMXy8f7n8uFXOGnh
 OAYqfDp4iC1Mb2zJcasdphGcOeW8Ma64q7xCY/soWpnO3Sy4mIWjVKVpXs57xSFmwCE3
 XT1iYhu6qW80bJmIe9CbMpphAa28waFrSIbmhRq7a9CbbC84W4bAj+S0C6s6VbapMXEC
 tbKKgpKxdwakvYP8HdJ9ocR4pdWs8g4FP07FXjjtm9j7eEj1D8+tJ3iN9K1wXuSCR9xj
 aj2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWe96M8FOwcc2KTwpGRgFJ/Ddr1fRFZ0HbZd2IYuShbMUv5sE9ENGPnL8thnomoYBxYxLfUKjMJX8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIhxbUAz4PRdB2E3gv2tZu5AF8iUGQvGoMq3DFHAy4qwSOlWC5y
 dCY/RNUnmNEi/Ew4QX2UDgkCRQQwnSktFmF7GBSoh0eQzFaQdDIQFN6zjA2G821iaWvR/KJrRUo
 DO2+XLKf2JYxj2rRC63lTmgz7TpM0gurPF7JQljsIuOOFLQ5MtvKejnxCmjwrL0QmRiaajZI=
X-Gm-Gg: AYBFou2ObveKW/8PP13kkSzE1bykZlF3+7Rf3GwMoagTTys6BWSQWIqZUPRw3ve4cY+
 bD8pWADTjdrBtviUn2Kba7n0xlc8awUrcgO8DxmTj+UX8wkc5rpUEFYyW3fCUuZUOIm7SfwBWyW
 6HcWGvpkaaJGz++1xGFSLK009srX/oqfB3dZ5v37IOFOtWHEZDeKSKzCI19VXp2yk7GB8tlAVFl
 YFh/AvL2HwD7+tGS03XUyahKUm8tYXbifb1FDuELVBGCHxs+ZwJsNI/SXChxGUpWdCRWCuCRBi0
 vbIFIcESONzXKQtCas9f5+o7Sd+Vy2dBfFIK7KgBCaS3lYmMl1aFzAAKAXVXWFo0SROglqW7ukh
 eKlOdTZFkqxKJLIcDFn5PxUwpw7JG0r5HOTT9xxTTpLI7v7dEGxcDcgkrJ0Rhv2CHHM0Vmc2a7L
 MQ7kCSN4Hko7E03A9L9n+ysStDU+negCKhi2EnOQgBfAwvqk8jRSfbUDl/vTevCA==
X-Received: by 2002:a05:620a:28c7:b0:93b:d7a3:45cc with SMTP id
 af79cd13be357-9442178def2mr985862485a.53.1793483271662; 
 Sat, 31 Oct 2026 14:47:51 -0700 (PDT)
X-Received: by 2002:a05:620a:28c7:b0:93b:d7a3:45cc with SMTP id
 af79cd13be357-9442178def2mr985860485a.53.1793483271221; 
 Sat, 31 Oct 2026 14:47:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe04edd72sm758554e87.1.2026.10.31.14.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 14:47:48 -0700 (PDT)
Date: Sat, 31 Oct 2026 23:47:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Taniya Das <taniya.das@oss.qualcomm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/msm/mdss: reset all block resets described in
 DT
Message-ID: <odog4t5j3y7j4tatqsiywfj27iufeazkzp3vtfvzce2knct25n@ephs3ngmt2i6>
References: <20261029123238.29877-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261029123238.29877-3-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029123238.29877-3-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-GUID: 7zBct1RW3n1Y2hnqQJRkMXihcza2JUuX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfX6UJZrehZFcLB
 ULnq3o1AcJEkLq5wkkkrYAYw+nhSjSkQRckK0e7zcrLNC8Isz2MM2m8PPGk1ZG/AbgHg0Db2lvY
 2y4fot3run19+ExlfFW4OQlANelIU9WBNmG/Dtk+c5Lfb2grW7Bie6DKY3qgXn3r73lupOPEVHq
 ZL7wXzkqQvwd0cmf9IGFRs0bq9W5n9D4T8045Fq5rwyf5+xrxMw7tZVwW0kpLNukj8ziK1Orxe4
 uPkKcQ+OPsFe4TLgPKmlS9aVT7mOffWb04RKx6ESdxitMvrVzMCIciN1pQJeVSlgY1Pj7LPAE0D
 HNu+cw8yqgyezXsRzzBCa9b45+Yq1LsxkLTGlStBQMKbZNxEj1k1RxZ0DLdB8wNORfouiReo4Nw
 D+DC70UUwb2JgmPTAwk24Juqux/1bjyA0xF+sO7KjJvwCZlk1z642hjf16D7kMxXCY6LqP6CsJW
 03lliazFwU6hOD4dW2w==
X-Authority-Analysis: v=2.4 cv=HNBWhYtv c=1 sm=1 tr=0 ts=6ae66208 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=XGdKMLjMlLx_IEht72YA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfXz5XdV+yxy8aq
 nyhvdDTuJCM/K5erJw6veAvwkVcoBHDWJB+AzDf4Da9RO/bagOyqwRPSW/A7jKL96vuqWvhfstd
 GeSs++uxlo83/A9AUx7IYy+8JgKMi3w=
X-Proofpoint-ORIG-GUID: 7zBct1RW3n1Y2hnqQJRkMXihcza2JUuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310086
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:32:37PM +0800, Qianhui Xu wrote:
> msm_mdss_reset() acquires only the first reset listed in the MDSS
> device node.  Platforms can describe additional MDSS block resets: the
> SM8750 display clock controller provides resets for the MDSS core INT2
> interrupt controller and for the MDSS RSC, which can be left out of
> reset together with the MDSS core when the bootloader hands over with
> the display block still running.
> 
> Switch to the reset control array API so that every reset listed in the
> device node is asserted and released as one group.  Devices without a
> reset in DT are unaffected, and for devices describing a single reset
> the assert/deassert sequence is unchanged.
> 
> The resets are driven from the display driver rather than from the
> display clock controller: the clock controller supplies the MDSS clocks
> and power domain, so it probes first and has already programmed its
> PLLs when MDSS probes.  The block resets do not touch the PLL registers
> and no display pipeline is running yet, so the PLL configuration
> survives the reset.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 9087c4b290..59343987bc 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -306,11 +306,22 @@ static void msm_mdss_destroy(struct msm_mdss *msm_mdss)
>  	irq_set_chained_handler_and_data(irq, NULL, NULL);
>  }
>  
> +/*
> + * The MDSS block resets are driven from the display driver, not from the
> + * display clock controller: the clock controller supplies the MDSS clocks
> + * and power domain, so it probes first and has already programmed its PLLs
> + * when MDSS probes.  The block resets do not touch the PLL registers and no
> + * display pipeline is running yet, so the PLL configuration survives the
> + * reset and nothing visible can glitch.  Bootloaders that hand over with
> + * the display block still running (PLLs locked, blocks out of reset) are
> + * returned to a known-zero state before any display hardware is programmed.
> + */

The comment should go away. AI agents like to insert lengthy comments.
they are useless.

>  static int msm_mdss_reset(struct device *dev)
>  {
>  	struct reset_control *reset;
>  
> -	reset = reset_control_get_optional_exclusive(dev, NULL);
> +	reset = devm_reset_control_array_get(dev,
> +					     RESET_CONTROL_OPTIONAL_EXCLUSIVE);
>  	if (!reset) {
>  		/* Optional reset not specified */
>  		return 0;
> @@ -327,8 +338,6 @@ static int msm_mdss_reset(struct device *dev)
>  	msleep(20);
>  	reset_control_deassert(reset);
>  
> -	reset_control_put(reset);
> -
>  	return 0;
>  }
>  
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
