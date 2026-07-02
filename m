Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEABC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB92B10F358;
	Thu,  2 Jul 2026 12:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PfvBRkZj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fVIi7dxx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F2210F35D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:35:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6628sOan4172652
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 12:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=; b=PfvBRkZjmzECsBBG
 l/C6ulvrOWW4bO5T1i668/9LoIoIo2Ot+p7CPfZm512Yi2E36QZsz7lY8yGaehna
 LRfeXadKYb+gb6eYOF8BiIUQJ0KAdwl9pBVviZn8WLgczw+4oNwnpFa8J34gtGqi
 3vGn3Vf9jKgZ1GgmG9fyB7AeynvUjvAslZT8Nc1Jdd435VXma6rl3XHXShg4aGn5
 WkgGtwXY9nJRza2Pd6UHqASdWQ9JU6zt0cJqiccbZm6zVd8EjPuoGOfivPfBUfvM
 K+TSJEBYu+SKlIEfYHEpZUKipLVSiQXbKLND9kl0mBASZneU1Ai4Ivq4SxZVPhVu
 wV16OQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwrue3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:35:01 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8eb5b9d2cf6so3437656d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782995701; x=1783600501;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=;
 b=fVIi7dxxhYje3SCcvE1W/e4LW3N2qalkGmCx+a17N4p6cjZHUMpYtu/SJZt/sDX3pD
 QL2enkZ1rWvm3Jfqa5NuF7iVneEJf+RmafbddU285Lo5Zv7rPlUEKdhk3CPXKMQa87t0
 dGOkqzasYy4f/4juL3IYPU8bG9XbMAdD1nFv2+EIK6hWIU4Ha5ZsdJNFHXlPEJb/U7B1
 GkK8Lfr3bAsbZvEsZGtg2jtBwp/DEBzIxyqgC+Tu5SAi+RufSwXzN9KkosqaNBxDdi8D
 +5Gk6oJaF+Vx+cWVM6fEYHX7WAG/Jb9lGoxG2AD9WwY3y8WoxcBw1WxwQ/gJsvWUax6y
 +VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995701; x=1783600501;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=;
 b=cU3gZr+3coczD7eUCagxuZvy98fT24NMZjSmLQsAntyxDdQ2nQAMj0gNay21tdj8f7
 2RxXCDe6FDVxRhYr3YgDgWWFmegjRxkd8w8VFU58yIrKmcTEhMTxI4ieogCT74k+Cxv1
 4NqEf1nAzZC1ey3Dhj3EmQkoku6bAURorI1C5yeSJhyBGnVGU9ofevOaLUEOnSHZHOVu
 wl/u05r1ikNxn2yxnr0f8BmZwDjkDOiyiu9oNEyWCauPg/diPPFFqH06bVjxpt4zgk+6
 3Sk7Jtow0IEKu0CuP6Io9RpGDiQwfpT4GKSejaj0uhkjpBZpgNpbeAkawgndhve7fGwN
 YdyA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+WNiYxJzZ1eU0q8HF2zjTHfA2p4hOkoul/Dkz+6QiUttLUj8rLWL7/8YgybE8qsRsfm+oUGiCLNM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy02VVitcQyRJeo8ChuMdFzE3pbHeqCy2/k/+l+jKLD/Fgt94BP
 cG698eQhyOIr/qVEXZGHqq3NIZ6SrwV+rfWZKVbVetsN1r34vLT77K8U4vMl0qv/xaObjAD0yEX
 sXPTFjCkPpdl1+buF4NBKCR/gXt4mQI/oBUkRhmEpVz9DykaZTyEpQDeBguo1kDyvdiyNuE8=
X-Gm-Gg: AfdE7ckytKOrWUv2GGJZoSVAFXj3/QvFmf5XV9QQ6Oje3Cbbs4GVrD+qynlof7bXERd
 6AHPTpe5oVkqomZQlZMHNr9ngmbr9/kpadif6wzfeb9WTNh9bKhTkY97texdyDTglWcm84pYX5L
 NFeLRXtJnYOjezuDcVBdgVdI6CJSf5CBTNWUkgg3zw2aCBHYEj7h2FXD4kN6vjAjsEO9Uz36xlA
 0r71RJgs8HK6CRjsZV95zKw/W8rIWPe6mr/7b/AzC4H7rfnpilSDqVKsCzYBdyd+I1PCGraLEih
 14ufIPjOMKLEAZH7nRgfzKgoYz3qjBdG2aZ5SEjivTaqrdANTH8lSa2tsiFs6VvTMe9iXOCtZLt
 5+p9g06cLFxIYuuPAjBUIGgClJbqF2LdCy7Y=
X-Received: by 2002:a05:6214:428e:b0:8e9:f5de:d5fd with SMTP id
 6a1803df08f44-8f3c8ff79abmr50486556d6.10.1782995700701; 
 Thu, 02 Jul 2026 05:35:00 -0700 (PDT)
X-Received: by 2002:a05:6214:428e:b0:8e9:f5de:d5fd with SMTP id
 6a1803df08f44-8f3c8ff79abmr50486116d6.10.1782995700253; 
 Thu, 02 Jul 2026 05:35:00 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-698ad13426fsm895805a12.26.2026.07.02.05.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 05:34:58 -0700 (PDT)
Message-ID: <46ab1a2f-45b2-4580-afea-a55073fd29b6@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:34:52 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702115835.167602-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HPDsSOHl9dyktInn7DctargibViOYOcH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX2EGc3g++8/VS
 n4U43YzGmJeJi2z0KzFi7aiWfWK0VokMP8z88mxS2sHGPoqeItgDzURgYUh/4wvrEVTqBf86K1u
 NWdNn9rIgXy2KvW6HZCUQhdG6M+zolQXJOKZ7T36WCZUsPnZ2aXA4DcvHmyGBztQpm9IRZuLZEt
 iwtBcUbFItIk0kTQORBJHaXAhAduUwLNSwCxY0T94Api4l0dGpUSD63+6KnLnmWs3cXaWaUHMCW
 g4QUQ5nBElGi3rmktttB8yfwH6gHVNam3HDbcmB1PPPyGijbxmXk5PZon7npbL49uo6M2eERgqR
 nqBK4zITb8wmYZnj3xxlkKzfaWuJZbY6XE4dTWOAUuOvOqwAxgi2bJNaJNFbEXjWqEbwEvUH7GW
 NvxPe3AX2fcSiaHUZr2/arVUZPpyKYx708wy6y5vTkItvDQKWt2rjpdkQE2JVVQrHXON6xJvUQ4
 9c1JMb9em/I59epSPfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfXx+/gjHXelYLf
 T5AhLy3h+fsWE6UqGdQ8j8k2hkfJhygsWDPpJwnzLvbMB3yvsHxEPvrgsJCipOzE2brXTTLRaag
 zYyajsA8cCkofBWgWKoRKUjKmtGByps=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a465af5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=5GrnyDZj1TGYcITIosYA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: HPDsSOHl9dyktInn7DctargibViOYOcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020132
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

On 7/2/26 1:58 PM, Sumit Garg wrote:
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
