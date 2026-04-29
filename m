Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5E3CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58D710F010;
	Wed, 29 Apr 2026 13:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4ShSk6m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OH7uEWub";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA4010F010
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:32:18 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T8qEh33066969
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zlXmXqOMWysl75wyJsPWf9ub
 9kxU1RPWgNiLMjMjO54=; b=b4ShSk6mKXAOrKXOdRb8rgeM9x0E3AOsUVpGffLX
 YHTR3NG/VHJbPyYcC95HQFsUhNe0VmjCUK0JBtUkd5xLFcFUvZngpyRLOUulQDSn
 nhS0ymk5Q/TAqTVAiCkTu/K2KoGMmZd4ITeT38pEf4r1FLCOVVHy8E6SudEJgvCz
 sI9DUmIPcJBOLQH36FG8SrtbCgHiNJttNS8RBr4nrKjz79AgT6VAzVj2EmgqUN5c
 AYY8mOcO8yx/QLoMEJWhB7hiq7WTX1D0YnsBoA1Ov1EpE1a3KvY9F8ZZNhTwA9ez
 4ag4G9vhGXxwOxTZimD4kr4NPA+7utKXEk+8SArbJOKdPQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxapr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:32:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso112355325ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777469537; x=1778074337;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zlXmXqOMWysl75wyJsPWf9ub9kxU1RPWgNiLMjMjO54=;
 b=OH7uEWubGw0bVqp7vvwenmf2pPrZMbrSXCSZgR7aFmlXVIn7zhgXCxiyHXggBj14Zm
 bAe8CKVLNvLcHNxy3JRdHhaPkuAxNcqZjkiELfwcqbDLWWp0XMRnwlmEDfapoSyqTgef
 0JclJlSRqLNC/fT74HagZWaGK6nxPPig19lI7fFy+ADiz/3kAKt9fNWEJ1jO14fI/AQR
 fZi3qXGcWEYZiqwvFfK9o0obC11vXH6n77Ml6klwV4p2iC4mfQpdoy7Ck4KvKraavKhP
 X5/IZgFoZq1L9TxJU7wUhJdoUYPD7kej/stQiWjAbqqSEk7jEzpsZ6fXogEomqR+0LCy
 9vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777469537; x=1778074337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlXmXqOMWysl75wyJsPWf9ub9kxU1RPWgNiLMjMjO54=;
 b=IYqH229BzxoGvfcZrwaROurypEd8rinEk1MmwBgxFpku4OzeFDMc+u8rs3zd0ttY9A
 kLpRboKx6gGIJ6r84Pp/OFRW4VvwCKeCTQ8wMLDYW1ToBzoxEPwNd+8SkRXwMxuKHQ66
 0WB6Rgb5Wr04QPyh+IhxCRv15HTADu+s+wMeMtmVrdAJM0OHqjJNLS6XniGZgfoU7cfY
 CemVrDqyLX4DpB2gTbgJlT0bhmKxvRjlS2Kz5QTxo5t6TNTKq6JioEqzwaUPM/8OIas5
 2w2x/q7EnXctTLymI2ua+N5Rh0+EyqmjtjUrr6UDLcmsag3KTDDeSeJGOExAQTlkv7M8
 nDZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZtQ3nLXawoaUkjQtX7+BiijxrtaVqFufhPOz6310Q/ZNTd86qNo1fBpNmV7T+VP9+G2YuSRKSvrk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7BTvm0SElzjnDZTmm6gKoa2pZHY2k23LEsDA1wz+2Xmsu0emG
 ib8watn3ejZURDzqthPIjhQ3llETO+5WQOJ083bcQWavak6sCdpY7mcT1QmICP4KEiKI40kWUJK
 sy8BBecY53UEjsbdVX0KatwWQXmbpya78MAS/NJUz0pEVzYXtu5W7TCVWnC8PB3neracwDfI=
X-Gm-Gg: AeBDies4346nsqDekmcAhsnJ8Jq1mkwZ2wNs8ACHSaiRf1H5T31hbZPWftPaBTivD5l
 NME6K3JcFn58J7RCsxhe8F+1l1cn0vPdLzR9L66fhQbsDZ01+vgi8+iFD8leJ6rRSQ+Cqs7EScS
 fN+AfsBE9NXZEiONcum2EkcWYmAtkb+0jdQvGx3PLUfTQJmjtvI2+LM0IkBHySiyln6WNOmaP5S
 Nfvp5LO9M5bJ2aF9HRAjpF7SSlT2xFsr/122B2sC9W30ZWOTOsLZN5QSS7B3rPTeamSLgHhQ+uF
 wEVvQP09anRxXkU9IJ4M6l5D1/6kYbTWvJijwI1lylfZgtAzJ55oRWd9Kp7cR6eofIL1M9ww/Jd
 c0fytvdt64JmgYK+/lsxO24+FJIL61XUqj3xd2VA/HW8hJk7Rtx45twCP2SI=
X-Received: by 2002:a17:903:2283:b0:2b9:86ca:5bf2 with SMTP id
 d9443c01a7336-2b986ca5cd1mr44795355ad.30.1777469536335; 
 Wed, 29 Apr 2026 06:32:16 -0700 (PDT)
X-Received: by 2002:a17:903:2283:b0:2b9:86ca:5bf2 with SMTP id
 d9443c01a7336-2b986ca5cd1mr44794745ad.30.1777469535665; 
 Wed, 29 Apr 2026 06:32:15 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98893f0b7sm25818105ad.40.2026.04.29.06.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:32:13 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:01:57 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/15] remoteproc: qcom_q6v5_mss: Switch to generic
 PAS TZ APIs
Message-ID: <20260429133157.lopr6n5vaik36466@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-7-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-7-sumit.garg@kernel.org>
X-Proofpoint-GUID: NIELohJqaspIeGsMNFkDjFP8mEeWhHlG
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f20861 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=UXi9AHVq_sPz40Hf2JYA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNyBTYWx0ZWRfX4P4BtvityhMg
 Ak7lZxcX9vg9riamwdp7htA7rJLp6dUnNzD50ymEOyPRhX9aAtsR2pZJbmiXwA8zOqWpG3IG8SF
 5Pxo7JOfGcA7IMvtDFkwCKq9k+gTn9O0Xic962HEugyY6v6AolJ5k638YRBc77uhGZi9ZJ09fxu
 iIMhhrJ5GnLLC97x9qIBS3ZvVR1a2gmIk50PH1eqDrvQRJAKeBBWeDStBL1VcRVo4DmzrnKBG+9
 CLmQFYecmrPKQG8h3K4xH1uU4ad3x65qB4/aT0KgynbNmF47VaCf/aiaiWqbNwTmOnc6oGsYd3s
 hC2zM5GnBq+iSwy0fLh9vS4xo9fZu3E7kIqmQvhq96V/NaRh7f5cyiORC//EU4qg7occtPz+UV0
 jvupOow+/T5AF+N2zXgB2FEnXuuJ7JbxSuOq8VoPTvFZ8FLNJH+58YahJKKCYpVhZlFB9uEBmdn
 vXyZ20QQmaPOkjpKQqg==
X-Proofpoint-ORIG-GUID: NIELohJqaspIeGsMNFkDjFP8mEeWhHlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290137
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

On Mon, Apr 27, 2026 at 03:25:54PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index ae78f5c7c1b6..96888007faa8 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -34,6 +34,7 @@
>  #include "qcom_pil_info.h"
>  #include "qcom_q6v5.h"
>  
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

same here., whether it is needed now ?

>  
>  #define MPSS_CRASH_REASON_SMEM		421
> @@ -1480,7 +1481,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	}
>  
>  	if (qproc->need_pas_mem_setup) {
> -		ret = qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
> +		ret = qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
>  		if (ret) {
>  			dev_err(qproc->dev,
>  				"setting up mpss memory failed: %d\n", ret);
> @@ -2077,7 +2078,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	if (desc->need_mem_protection && !qcom_scm_is_available())
> +	if (desc->need_mem_protection && !qcom_pas_is_available())
>  		return -EPROBE_DEFER;
>  
>  	mba_image = desc->hexagon_mba_image;

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha
