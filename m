Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35CCCD3440
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B1410E438;
	Tue,  5 May 2026 14:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/9FEifz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KcwHx5ng";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1A510E443
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:50:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645DjcVe3501554
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 14:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=; b=l/9FEifzdbjK9Knf
 VYMr3kcwzNNLhbAzkKvw0GYs2OJ7sGEeOZWHWKf0cK+obbOnyvKMJDrIQJ8lgoHV
 XU/JcwvsxKjYVEKjIGZuOVpxLX4NZmGktmosZokNx+YJqslTQBCiGGl9BCYdMXNE
 crE7L0LpAeXm5vmofh7Uggtr3DCHMeTSJtLFDz6DF2o4nJfDx6jsKCqBo1yrq0Jy
 rqamtvs6nhXmQIdnBDGtNhhFEDzHZ0fsjdc6/iAFVW2wmae8RcSCd8kJi5+jxz5F
 c8fmALkBNzOLw+891xaprdQssFDUYsd3Hx7I5HqJ9STd75ldyI54mKNtTm1wzK9E
 wtw6lQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhqf89ad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 14:50:08 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1306c2f7037so1384118c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777992607; x=1778597407;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=;
 b=KcwHx5ng3mFAEBgdCImIMzVFuq9SFpigVPzRtgwgOAl7zb4XcqGHMGX8an2ew8eeZq
 n6CTcQyRrZCLNYjKb/q+YMzNm0x7B+Pei/eLkdsHzp8iMp2bC6kOvyMvXDqxFtClGi5E
 lXYao2F/EJ7+xGtw76WiIFeklZtyfknq6d03ljoXHoWIzFJvlhcstOy8aOffeIyEi14b
 BiPS6aA8CuhXIzgX7mn3eqaO9n7TkQjWwvmuUqVklOCqbZbrW0Q+wOQ3dDeAHcsM6oNl
 Oe1dnqoRvcNjHA4OY+x+I5fxbY4DM00RpDbHRAjrpEIb6Hf03uwW+UOhRUWclxiztFx+
 ubng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777992607; x=1778597407;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=;
 b=g6v+XwWE7zERKzTGnkMm9ru8MlCgig20wlOZtIbA/c8v4gr7HnUu5ceqEYLPU1jA39
 wpNxgpwfO2uwdCv0Y3hQ7k+UeqtY7rEOVd89ETIYcviWUtR4O8PROE2r1C+zPAYzv4Fk
 e00dhz6nSbjm7KtVCUG3E8euHFbJoLTaFJojSMc55qKvlp8GQl5Im8BcHjUxTPBNpyvJ
 g1oa6bd/2ebChJbf84IOwjoGhEaqoVCQTW3aLHUUu0l7u3hUG+qv2x+vQPfesPewg1lf
 fltnDExDOt6IC+TGdgTrU3ul/vZSSoOgb5tvgMu7iHrK5+2p2r4OfEKa3P0Fn/9P2qCH
 3jjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DKnrFaBQ2aQl+/EyJuTwvUn/f9Wi+82zMQvOGDvhcOq8FaiUWs2CEhdIoYXOWAyb2gHbu3ER7Ouw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwauJ6+aeU6OopZOjiUav5T15ESo94HuHR1Yh5dCYNths2TsYP2
 pGr/UcUW9OZaEsR1C0VTE4IbzFCbndjmDdfUcUo3vsVYDaJggrngiD3YstRluStvAnmygtw+T+f
 KjT9Xd+vZvHBhJzHPCe9z6WWXxdmXkOwOVxjJx0bDZI2FQEc6Fjeb9xU1gSapc5W6s1jHKac=
X-Gm-Gg: AeBDievZ4yTlrdwloAioWRaVg7Smh8Ab7mqoGceDKMBHHbfqdRxWBCFANfFrPq1WN+5
 dsllWJ2YzHfm86Ny5IJ342y9p1Rj8ZSbxtqDExu3f87gxXsaldN9OpD2qIljf5FOdWarwzSaTbw
 +smnuphCk+KVcauq8WqWJVMxHzGNpUx8rtHvL7FD6R/PaSC4mF7M6RHKyxTE0Ge5Yz68QHCkw9j
 lWQwmJs2glGa9u3MyevB/+srgx9O3hovEhGFKt1KlZZYfqjAg2vOx1XfcWKt2dz2UK/8xqLkvj6
 hMljkbaFQnXmZhcLQgn0swr54JOX/7BVXTOq+ffjOtdNrFCBOaROLF6L0TZ+jxKPqJDmKMPj03b
 QyQsjMt/h5rnLbq4eKVLHw8O2FyGpnN24rj8tCnfdNmFQIfxOO1bBcMrN8j/l8fXUxFE9Ql5Yfy
 oGMz6Ygc76aHzJ3pFz
X-Received: by 2002:a05:7022:6628:b0:122:33e:6d41 with SMTP id
 a92af1059eb24-12dfd84327fmr6504965c88.23.1777992607375; 
 Tue, 05 May 2026 07:50:07 -0700 (PDT)
X-Received: by 2002:a05:7022:6628:b0:122:33e:6d41 with SMTP id
 a92af1059eb24-12dfd84327fmr6504928c88.23.1777992606769; 
 Tue, 05 May 2026 07:50:06 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12df8279e57sm19149584c88.3.2026.05.05.07.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 07:50:05 -0700 (PDT)
Message-ID: <ae68bdb3-d683-4e7a-a27f-739214656ce2@oss.qualcomm.com>
Date: Tue, 5 May 2026 07:50:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org,
 Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
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
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-15-sumit.garg@kernel.org>
 <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MSBTYWx0ZWRfX0idpAlg4rqvt
 LRFlbn+4BiZXJV1vMYQvdZmOrKSpgFyg8r4bnEQMN/r8LQ+a3z+W/0GMCdKDWWBDuvaa2pR92rr
 pQdIgV8mDTc+QhMz2PyE7hDyJSwAV2WYFxM2dr+F+J29B8hz2U502uz3AG6g1N3inEHjquLK87j
 4WcHyMYbPh1AVHUmOZXMEFap/uiBvJlun6A+j49Cghm5TBJwdQJP+atO/WKEp85V8N8wOQmlK2X
 hitDuNZSaQNZ6DaOPFpf4gtEeVQ/MTe9sgX0kQZ4reY2tzA0w2DiMQMUgBR8RfaQWQ/bQ8TZ8h2
 1HQAvSgZItBhBLT2Z34Q6U5rIdiAT/3+ZEzkgY1083hlSgImtUREIwGwjmJlL/q4a/frCcEFquM
 3vhwEZc5IA+XcTkdKYBcAHitLqm+WQ58xZ/AkGZ32lo209YpD62JaScUw0oVmhWXniyTw41m4Qp
 Op53mX90Nq8ojzr5j9Q==
X-Proofpoint-ORIG-GUID: EJTq3UsYaoILmeYt-RIAu8wVejgsI7X2
X-Proofpoint-GUID: EJTq3UsYaoILmeYt-RIAu8wVejgsI7X2
X-Authority-Analysis: v=2.4 cv=NPvlPU6g c=1 sm=1 tr=0 ts=69fa03a0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VMT16xk1LGalzlQIQqAA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050141
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

On 5/5/2026 7:27 AM, Jeff Johnson wrote:
> On 5/4/2026 6:06 AM, Sumit Garg wrote:
>> @@ -485,9 +485,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>>  			 ATH12K_AHB_UPD_SWID;
>>  		/* Release the firmware */
>> -		ret = qcom_scm_pas_shutdown(pasid);
>> +		ret = qcom_pas_shutdown(pasid);
>>  		if (ret)
>> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
>> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
>>  				   ab_ahb->userpd_id);
> 
> at some point the "ret" param was dropped, and this now generates build warnings
The 'ret' param was dropped by:
8fb66931fe31 ("wifi: ath12k: Enable IPQ5424 WiFi device support")

Not sure if that was on purpose or accidental. Sowmiya?

-       if (ret)
-               ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
-                          ab_ahb->userpd_id, ret);
...
+               if (ret)
+                       ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
+                                  ab_ahb->userpd_id);




