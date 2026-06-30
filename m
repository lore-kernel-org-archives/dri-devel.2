Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D9EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1EB10EC7C;
	Tue, 30 Jun 2026 12:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b6o5P/f4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ku3trZ25";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C001210EC7A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:44:19 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mrkH1542077
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=; b=b6o5P/f4dub0N+sh
 VloUIC5/nznDnJpdi25/JuyuvwG2UEzSJKKvywHK0tZrtZT9KUZ/5rxDpzkAbK35
 dsnM/t9aZuxSxU2dRGIZe6jSc+AjUnNQpE9yweYJ2AHh3rx+0/GCQrqKHV9iLFJd
 l0GX/TT5eBf9LEmr4iI2JoKQon7GYA3eQBuKb73gMscfC3mX6KuyV7kA0Qrm0VgR
 Sx/9IGVhVELkU+ss5iFzAVhFhfcrFPin/yM2k3woV5wD5lCojLKYMgWCTLttw8p6
 JC+Z5uAr7lpj3dOpru9IIxbKchWQWwxRHb/JJjqzOKMn80zS9LHcEIdrMlIPnKRX
 7BmsvQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4jfvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:44:19 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-738a934c5daso68182137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782823458; x=1783428258;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=;
 b=ku3trZ25ddc7XUcJPLt/ddK6kjvZPOwEl6B8tyw/KV9hrwvIEY+FC8ihopn0u8n1cF
 pIOgSxfU8Bhyh0d+Pynl449Vfq4FimkEXXypkq9AOxoVH1Ma0Wov66fvhMAioQtwUsoA
 hzNilznPtlSvX1GkoQ5P1YSFQtLewBQRPRCprSKZFlZa8kP6dw/M8wMsxJmkeJvT4uc+
 tYNV0LaHvGLFLSiNU5361j99yRoSXl5Cm4XQAplnO+LdS6Wrlod6LsvYQcKnsZ3FZ9E+
 ipEnIEKvGXLNW2fGhmXb9LFWNzQybxJP5cXm+wchWFhP/iCI3ZT+9zqgKY6N/xnorxF1
 HPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823458; x=1783428258;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=;
 b=hyR87Dz4yk8QQ+2MozqJ3H2IQIqpX+ppkLbJT/lEPozsAP+I9oXQzm5HYDQFXD+k/O
 x4L6HXqR7i6jp7gH8iVsROtxrdBFbsKLBebyAKVFxPV539gO59m0RC7aGCA/lkZEu+7O
 dy5Gt6jXwZadzOpUJ/mCR1Cs627HN1oL6fOZ9o0wkC/+eQeF+wYqYSgJGpjmU/GycP5u
 BvLSvaLuwwRHFcmIz5RrpFai5wRydx7L+B6yqjdxFH3u7fPILVPhW6UWCxFrTmHhZIHh
 yTk1oqMD480PJ0wV26BKGGMPpdxqweno6yJUvow8n2bHZcsR/eCd51LxdxBuM+qUf8D+
 GdmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RochlyXje+JNzuJjOEF/Imn9Re/VSRm1ZEw6kNlaJVDRw98iAosV56iMMLS3zxPJMsPnADUvj49d/o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxM1UCFbJLL3+341IAqTMQSl7fXvDJQymsSoH/H2jzaO0Xy9gU9
 PrkMttNZj5NZWQp0/t+glW/Xjv8TC8d0Wr6VEESWpoUQvE2IL99J1YFcunizeVaILdM5zvBbBEq
 RKO+kKbigOiF+EaXPo2BEo6D//nbwfkDPoQiOsQ1iJYhkMcXSdYhS3dEQ8G80q3Gy7su0f9s=
X-Gm-Gg: AfdE7cncjY0cBTv1NRgx2aqphzrpHzwngTdIej91zfGFUdxVKuCiUxAgC4PzwOw0WQ1
 1QeTZHyQYiFkMdlC6Xz9Ew4l3BMp3n5+Dpzy1xB4Uv0WcCSRdwFKILslAEg0BUPTSZrZwis5rXX
 Z+z/VzQUF2JN+hoHYOOMiPpy/Ge8HAdRU7tQXBdgSuN+33sq9NNjs9ZxTyrdf5mGPC+YM/+a0+I
 LFoc38k77meN4abh00ZCM3FLOY5ZxgBrV5eulnLRS9sZFrpR6mPkdZ9v82zSEKU/p3fZFjsVrWE
 Fqm+sIu5UAnMGeLQwCHrqJXUfKF0rgvoaH1H08tAomuGYucM6vduCx/tDN6oM9maqD9kVYpMfd5
 7WVhHDOAmHouqv3yPlZqwL4A2i7csMG5Uq1I=
X-Received: by 2002:a05:6102:8082:b0:631:25ab:8bbe with SMTP id
 ada2fe7eead31-73a38a37b21mr524367137.5.1782823458311; 
 Tue, 30 Jun 2026 05:44:18 -0700 (PDT)
X-Received: by 2002:a05:6102:8082:b0:631:25ab:8bbe with SMTP id
 ada2fe7eead31-73a38a37b21mr524326137.5.1782823457846; 
 Tue, 30 Jun 2026 05:44:17 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c950732sm1117239a12.22.2026.06.30.05.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:44:17 -0700 (PDT)
Message-ID: <ae6518f8-bba9-41fe-a97f-de6001319c0d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
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
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-13-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SyrXaQhUsD1gxF5NbwUa6aKkEqGNNe7k
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX1WzZ4rE4ISa6
 g1jHup+rO8B5ODNWuoxjCjM+GOMM9/A8S4bGXYfYvfl9OillYZ64p/l9do575UJ8agyGAgCl54r
 EDUU3ln/SszF7pDdE/zDWx/oKs/xSsw=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43ba23 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=AoAzlOJtnLSqI_VYGEMA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: SyrXaQhUsD1gxF5NbwUa6aKkEqGNNe7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX9QjcyhIzS7D0
 zjAePeZpJf0nGZaGisXt8p6UFT8rHoo8OB5OIFKzCjURiRBe/ogSWFurCz61JA+gbzlLzqrEJKx
 JEQRSHTtfecvg5LEHeNdzWgED/rEI3dgmRaGPfyXFPhKaV617ZLrtwyTmTr4CcTg4NdtSwt9Hr6
 B9PEDdV+OxsegEBUiLGTMVhMH4xWyUCgI61wTg8mpyhVbAmLngf9eQA5HiooaXGQ8370n30pN4s
 wzLBrWUCkGMTmfbrg0SoFBiSMkdNiHHQQk3N2v/6XOvS0FzxwYY7p7+pMO7F4pZzeVdxYM4bJ8s
 EIGKmZlgD7BGxIUlJdo1uxr0+vIVO/pZoyCDPPKVVUx2M9OMrlMciT2OrgChUDiY9UX4FehVCzb
 attcXerK0INHZ8pv/DrcAo/24fo9tuH6YOpRQAyueElz+LShcHhXAB2aP1jecG0El0llmpXnqKn
 q8tHjrOH17N0YF6nBrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300118
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

On 6/26/26 3:34 PM, Sumit Garg wrote:
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

"eeh"

[...]

> -		ret = qcom_scm_pas_shutdown(pasid);
> +		ret = qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> -				   ab_ahb->userpd_id);
> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",

"PAS" - it's an acronym

Konrad
