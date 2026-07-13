Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FA3C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CE810E64E;
	Mon, 13 Jul 2026 18:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WdU4k/7w";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gk2US6Sf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B44E10E642
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 18:58:42 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DH6a352107867
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 18:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EGm08z2QRTZQR1FZakby7UHoEn+vMY549zyGYn80n3k=; b=WdU4k/7wJY4565Q3
 OBIv/l/9/g9bOCtXtJdW5RUd40bhhXJJtBGCi5XyLAHtadKYz5hVdLU8knWINlps
 bNUIkviKqHLWLxv9gNI9iqXdGJ2UVEa6jsENcnQVNwq4EoYLEz470KHRNeHUHT8o
 sa+g5Qw8UDN99M8RL+ra2kDJC1ovboKK5zPW4s1STq08y2RwX3+UBJFecEuQ8H0O
 9XnFwJm6nPXYLi65NhRQ+zIzTRuprHoYo7OT+5G6P0c+/w8vIfA0qbM/PnP+tnvS
 HmjjtQxXp4vx87eHAWKG9gGELlUiYgWMLYLOoSeiuwkqWt+92FJ1lGBo9st/xAKt
 nCGidg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j0e4k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 18:58:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so5308700a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783969120; x=1784573920;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EGm08z2QRTZQR1FZakby7UHoEn+vMY549zyGYn80n3k=;
 b=gk2US6SfD2QljcUBawX7B+urO0+4CUvFG5g/uSfYZwYe4/oD0+Wdz0i+H7X26eqiu6
 J/wVrcEY1XnyJSAClyNzLcMBvtnzG63aas2AzmhtFQJsEuliodEJoCzU5GVXFSvjWu3e
 LQkWyRdQJiyu/x/L8ctr1NRu7eYmn4NDSi2JwFm5CYVygoVe0GugTBgxfCsOQwSyTUF5
 v4ayhISrq8aM5GiwucZhHZHaJpdvAOiYUEXechuskoos49qU2Zos9zpiYrn6uF39r6Hc
 kcFbN57cN1FRodsVGFP0su51+PKcFXAxFRO3XR7y17FPpGK9mgjJDdvSbEgDh4v2+p0o
 zEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783969120; x=1784573920;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EGm08z2QRTZQR1FZakby7UHoEn+vMY549zyGYn80n3k=;
 b=cuD+N9f3rUHpSfghYEscnpLzUPBXVj0yZjbShMO5miqColUHF0O7NvHzZNDIle2MiW
 4WoK++ZVH+ztVBDJVGqYZ7btyt7prGLROuie/uz3OT41obaq0TSAwQldMAOgrHVabSs9
 Wgvo2i5F3+vx/OV/XocDpZnGGnO5Ld12Ppxh4Q04Q7Liy2L/zl/jMuC/GUg3SGkJRSfy
 jcYVkJNh4NoiOiCCyVLEFcsDkzjisdDdjDvCaAprE3v4OiptLeuPQuaWei2RjrF1/25i
 Cu2pv9NjGP6FpMlrPK9IDMTz3pXRlEqs6JXPMoGqNu2f2iyZQa4P+HgM8E/5q690wWPj
 tb+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwM4OtNZ4toYu2FN5gzAKBD1HI+pKIpn8EOSVEdUxjHdw+UG9705NMASLOvTqQWe++2IhXItM+dDc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1+qxqw12fqpH8Zwhi4RHl9qArClTRwey+ZbsbN/bmi1ua0aUP
 Ganvvj17nFrJWifCBXB88h9FTteINb7FMqV9QMVGnAhaqS4VymvPx2QhMwbCfBbx85T2Mfwmr7Q
 wZsG6N5E81fg5y38zCD8FPlh4AMIhxQuH2HogIITxkAuTpb8I7OwJUuVxoCTNZRhdgHQ0x1k=
X-Gm-Gg: AfdE7cn6Ur4G9jmnAJfziFzCanm8I0ZdJfE9RRfmOHJJmYVCNFGC1wVec+i2Px488xP
 Tuf9HO23x+tN0HaW8t/Qcanyryi4uqznYfHLC91tvx2yO78Ax/pnXp88jMl/hmQZza39vzGGHIm
 MVeDfCHiIHqOcGWpCWofh2ZWqI/K4AgRmTM4b+gvRh2wnYTIW2Huqjy1QibVLU/VMetddKNd7SO
 BfOtCN9GDcu30M1WhXJTLDaiEOZOqKBUq1qG1eHpD9qrahNCnmjwKLow1bn1/9YkCs8tXr9i/3Y
 iMFhOnUDMMv5KyrpOxxDGuimkhWGcQKOlcDCJ13MJZWsuFQtHHZ+NjZAuzCErZFFzNdLTzb9o5F
 fqJff+P2NIhLQjUQOjLop1LOrGR4bFxmIXgsf5yQ/GGbfZNAwhtdW6G58BXmmTSkCt2Tf
X-Received: by 2002:a05:6a20:b7a7:b0:3bf:63af:859 with SMTP id
 adf61e73a8af0-3c110ad2e6amr11568623637.45.1783969119589; 
 Mon, 13 Jul 2026 11:58:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:b7a7:b0:3bf:63af:859 with SMTP id
 adf61e73a8af0-3c110ad2e6amr11568594637.45.1783969119131; 
 Mon, 13 Jul 2026 11:58:39 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm83117734eec.14.2026.07.13.11.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 11:58:38 -0700 (PDT)
Message-ID: <09e17504-d1b3-4e3a-b547-3c3c1040015c@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-13-sumit.garg@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260702115835.167602-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE5NyBTYWx0ZWRfX11ig9UQ6oCY/
 68SJHz95FcIrW62nl7dEexy9xGEVP2M8HLnT1mAipoPMFal8ChKe4w/OhKY75lgrDmoblV+oQBX
 g/jIh3wjrSf6EjORASrjnCbPzy1unbU=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a553560 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=CBpSC656wZACrugyqBAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 6Gq48CoiVqzcRaKi0JQ_JMXBzgatLLq6
X-Proofpoint-ORIG-GUID: 6Gq48CoiVqzcRaKi0JQ_JMXBzgatLLq6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE5NyBTYWx0ZWRfX6pHm7n0B/yGK
 XXHyYdS9p1DDvfAEABcXig6Apt9soOlg2nylBAmCaYE+AwJXZki5IlG//tFEnDVL7uTMA0YeBc5
 SNY2hdEzQZZSaC8Qgwh/FtvRhKSbioD1UQkK3x6CtFHc3yDRRV2GzCzLG2xz6/+Hz6/elfI32e6
 WHw5QqZnO1P+ECphkXpPaQbYrO3BaG/WwmGNJHSysax/Pvb2TW8/OZucx08lyKmccE3NyAloMB2
 DSldF/o91STWjNI8A0AH8ffvSSifE8tH/YaGZkn1vviwqYIwdOk1kHtyEG2CO6enVydO6EqMVfG
 iDfs0bCw9wTn8uGAg1aEd7zbB6u4MwPoSzh1Q8NZpfd6znlYm8YGX/LVh+f8jTaD3l4NWs8PXm3
 d3MMas+RevCC7QlhOD0cuPsZhG5gmHIU8GlFl1gPii6CI/4czcd7TCumkkl/Ei3Y8XQvHuabl98
 P4iLC0GQxHUVMb5m+rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130197
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

On 7/2/2026 4:58 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Jeff Johnson <jjohnson@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/ahb.c   | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
> index 4a2b240f967a..0d5d1c55bfc1 100644
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -18,7 +18,7 @@ config ATH12K_AHB
>  	bool "Qualcomm ath12k AHB support"
>  	depends on ATH12K && REMOTEPROC
>  	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS
>  	help
>  	  Enable support for Ath12k AHB bus chipsets, example IPQ5332.
>  
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> index 30733a244454..69e21214e629 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <linux/dma-mapping.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -420,7 +420,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
>  
>  	if (ab_ahb->scm_auth_enabled) {
>  		/* Authenticate FW image using peripheral ID */
> -		ret = qcom_scm_pas_auth_and_reset(pasid);
> +		ret = qcom_pas_auth_and_reset(pasid);
>  		if (ret) {
>  			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
>  			goto err_fw2;
> @@ -485,10 +485,10 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>  			 ATH12K_AHB_UPD_SWID;
>  		/* Release the firmware */
> -		ret = qcom_scm_pas_shutdown(pasid);
> +		ret = qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> -				   ab_ahb->userpd_id);
> +			ath12k_err(ab, "PAS shutdown failed for userPD%d: %d\n",
> +				   ab_ahb->userpd_id, ret);
>  	}
>  }
>  

My code review agent is flagging:

**Missing probe-defer guard** (`ahb.c:422`) — `qcom_pas_is_available()` is
explicitly documented as mandatory before any PAS call. The OP-TEE backend
registers its ops asynchronously; without an `if (!qcom_pas_is_available())
return -EPROBE_DEFER` in the probe path, firmware auth silently returns
`-ENODEV` with no retry.

Is it an existing deficiency in ath12k that there is no probe deferral?
Or did the qcom_scm_*() calls somehow guarantee something that is no longer
true with the qcom_pas_*() calls?

And also for future cleanup:
**Misleading field name** (`ahb.c:384`) — `scm_auth_enabled` should be
`pas_auth_enabled` to match the backend-agnostic API it now guards.

I plan on taking this patch as-is through the ath tree since it is currently
just simple API changes. Any additional changes can come separately.

/jeff


