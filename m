Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C51C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76CB10E2B2;
	Mon, 21 Sep 2026 11:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EttIX+wK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZNLeZSKv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACFB10E2B2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:08:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAe9tt419329
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +mt+jOa2RriQv+B+Wbv0m4jlSkeIIIrbl/YtagK9qk0=; b=EttIX+wKKp5EGn3p
 LtPmFUpyLInUxUc1Xw4Bq1V84fkHazBwgBh0h1WAZfY4jBHhzjG539FVbvvd+lZS
 FVZAZgA/316LeCbLJkaIvC9i7Od9EjBTp3/dL4ULavRQCxDs12SzPOA/uTQ8iGB+
 Xnr8jtfAzoe54OwdyLbnNmhjMscT5wMnIxRwoCyXCHCMrVaa8lNw0Z/1zmmZ7Jay
 cVZ1U4Us+i+8IrNhAbn/byrG88756CDM9wKiSpqeNATtmHaJp/uJHOC0X1mYxK0c
 cpv2vYCqEciAl1mPWRUQxI8/yOOlZfoVVGJtbc1kV1uaODpAZ2Hej888xHrX1lsO
 1YchcQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq8xfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:08:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-530d522a20dso5380311cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 04:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789988926; x=1790593726;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+mt+jOa2RriQv+B+Wbv0m4jlSkeIIIrbl/YtagK9qk0=;
 b=ZNLeZSKvYUja8G+S4avGt/C9d8cczd0xLdv84A4zzH0cqAbMJBg0RiBzDlkA6zlfkR
 pJeyLsN6+kyM2DGwtJVs+vSs9q3TvqsNhfGhB/RgKvM0I4g7mmWkAamApjBi0UC9c5mL
 ORvO5Jfoa95TlJFMrDH41dyePx5VkWRN8crxGe5j9hSwWIwyENN2k9cA2GveSsjByoD7
 evDRI83EIWi9yS6M9qSfi/1hpB6yIROJuXf3IXlEjDz/Hg2BJGkoqqQXdpmTctVhCdzM
 61oQ8Ysbb4pVPMII4/vQ3AQ0+hvtn9v2+D3qCsezOL5kurcXaA/qoXvRtw25X5T0TfHI
 ytqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789988926; x=1790593726;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+mt+jOa2RriQv+B+Wbv0m4jlSkeIIIrbl/YtagK9qk0=;
 b=bxHRJ8wD1kPoWqeSmki77P05pEHM/7zdxptXss6nBsdigg2CfVUqcpfCNv9POqIf6c
 BRiWQEPTYnmmpNbjUjO5wa8Ls+kbbnILCNGJJt3SgGF5vdC+VTuOCKFVNHgBbw8nV7Nh
 4fJqTJ2BLeTqFIFHlJ5hKaXTiNt7A+2irqD46C9ak68OET/D7tJgkthOCwmgcUf6WKBE
 x2ueIo4yX62zAYYPYgzDp9OHrNY1RNJIzN8Lx56VhLA4ZNnGF//vBudL5X7Fm+dnnxrN
 W3AmZazUlX+12CHuT+IneXSBiA4fN/onj96tDyaI75sWbLju1eV83Y5LS6sP3DfZKN53
 OTWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5m5xN2h5Li2uyxcSHAs2AiupdefTiVsdKcynOimH+BOL92Glonvo2dHzhzO2xD9JY5w8aoYJ0ACI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kuz7xlx1cvHYeFmmduMx+yZZVqvF1vbO5SuGllYf3URaxar7Nl
 2hwlhqLRXiMda46EWTeYdhtXLB99cnqOu7am+EDF9lYMKyx/fiM4fA0B0EykpfvY/99XE20i8h4
 bqk78s8oy1Tp8rXZ6kv8sq47mO5unmkct4biZ9g/Mkau5mKOqDzq9MGB8+7PTK6npNwJPfBI=
X-Gm-Gg: AYBFou2G7KlMGHpgte+N+H3kABDRLqSxD7DLn7ztZ7gbUYTVyMf1jhRQ2cH4SVixJnj
 og5Mm8qDZLv8/ZERuEVTKPOVSKhT5veJW7vnaaOeYyrWteP+3PyB5oQmLC1+lQK2/r4JNpLD9jE
 irYahrjC/LW3XZg3vHSNNW7a6uA+53j3RZPS8Hxu35Hh3Ll+rr1RBOTSEsyuusyfWQvBMuXpQ8Y
 r9UIMqqsU5nOy2Sh38bSeNTvIJO6yIk0W6IDW/ItM9CXj0qCWcb22XRjZzoN+MMqL47EJktrfKJ
 0exlvPuuJQ5jphyWoBcK1hDDKoMfa07b88XV6+y3HlcrG2dO6e3aKaBN16mx+lk6144YqdNgvOL
 1QMkxTxiBUxNUqDOCMP5ZTw==
X-Received: by 2002:a05:622a:1911:b0:52d:8270:8e36 with SMTP id
 d75a77b69052e-532b743d863mr99486001cf.5.1789988925765; 
 Mon, 21 Sep 2026 04:08:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1911:b0:52d:8270:8e36 with SMTP id
 d75a77b69052e-532b743d863mr99485651cf.5.1789988925398; 
 Mon, 21 Sep 2026 04:08:45 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a607468ee9sm22436471fa.3.2026.09.21.04.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 04:08:44 -0700 (PDT)
Message-ID: <22355625-a2ea-4b6e-99b3-65cf93ac8034@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] backlight: qcom-wled: Fix WLED3 brightness
 register stride
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
 stable@vger.kernel.org
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-2-bab8c7ef73cb@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260921-qcom-wled-backlight-v4-2-bab8c7ef73cb@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ul__J6bT8xcPK7PfkmEsq-Sotdze49PP
X-Proofpoint-ORIG-GUID: ul__J6bT8xcPK7PfkmEsq-Sotdze49PP
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab11040 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q3U7ue9uqBl2Npjrlm8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX+RNDa4Bo+ZNR
 vGLgqWFLT5tPUrX0TglS3sWZPCqdj378unL+CZOTFzGdBqfUEdho7GuI6hxYRNsV1N07MHCFmcx
 WlT2Jf8v/3p/yzqysmSdmE4j0UztrEr4GwVHndcfM4N0M8yzEOhnddUqNeVs+H0cL3FXMK4M0fJ
 k1dy7mBHCHBePpmU1cUU41gtRySO6zybDFf9lr9JEuONkEZtg0v2idLdZvRfY1DrJQD0vw1ktVr
 4iwd8+kVu72Jm6RBGbAB6H6bKoEw/tLZgxbb8onFfzNanuvS17baWAGHpYXQNJrvQKA186UQVPh
 t9Wy9i7CCvia47igVejlxBnAy+sA5PwJ6xjgqLbIOUQ7vXKzjtHkh8pW1QM/2qLGNJB5G5o3ViO
 4xbbXoaIUfEJ0yXuCNdYaDG88CSzMF3wqemvy6vdltzXKiIKQQB7PCudIdal9jy3ScW3A/BIYkQ
 +dPBgUD/Crpl8fMdfKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX7NJgJW4vgBUL
 qQglP+YjTnzp7wSbIee6UaubIaXZefRFgYStC837mIJlHfPhVENSuCtbBmhOndVre1IYSxOZzS+
 0t/EeQBBy466yOyUDSucCUY8uxc6gzw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210160
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

On 9/21/26 12:46 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> WLED3 has a 16-bit brightness register pair per string, at 0x40 + 2*n,
> which is what the pm8941-wled driver wrote to:
> 
> 	rc = regmap_bulk_write(wled->regmap,
> 			wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
> 			v, 2);
> 
> The restructuring for WLED3 turned that into WLED3_SINK_REG_BRIGHT(n),
> defined as 0x40 + n, so the two byte writes for consecutive strings
> overlap: string 1 overwrites the MSB of string 0 with its own LSB, and
> with the default three strings only string 1 ends up with the requested
> value.
> 
> Use the 2 byte stride.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/video/backlight/qcom-wled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 2281007bdd459..f452d328997ad 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -54,17 +54,17 @@
>  #define WLED3_SINK_REG_SYNC				0x47
>  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>  
>  #define WLED3_SINK_REG_CURR_SINK			0x4f
>  #define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
>  #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
>  
>  /* WLED3 specific per-'string' registers below */
> -#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x2))

Ideally n would be wrapped in its own parentheses (doesn't
checkpatch warn against that?)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
