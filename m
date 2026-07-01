Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569E4C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD49D10EEE5;
	Wed,  1 Jul 2026 11:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EiVY6z7c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e0KiE+Hy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257BD10EEE5
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:10:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8uAZ755504
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 11:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=; b=EiVY6z7c4AclhJxv
 IjydyH+Cf8APmGkuVaT66N2cKfurEuN4IifGkWx74mHARak9ukggNmPfdqugDsc/
 jbMa3p+k64vQkZ76ffbcdebzndLfIVYO0bnFRSykzIvsd8t+mQmKLWuAowNrWiIu
 o2kSM8Vs8TO+emdmY3tkXQEku/1WkpkUYKJCyoE+FVfZlzIur/hxrub8JBCNXlPj
 L3caq2QjgybbdwaC1QRAGosiePnSltCTrmJozbzWw3+EUbdZWH2ljPtchgjGssHm
 muLzoeFipStVoy+j7zPbClKblFd6XHlaLLivvkoVXLUWnGFBhw4wURAD0a7wHw0d
 a1wavg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqr9t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:10:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfe75b7dbso1172071cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782904256; x=1783509056;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=;
 b=e0KiE+HyJ1Xq5ZTWH14X32GHUcbd0Z5UoOV7YYMCTAbxxOEvO3CahBAhc79lbertTL
 eXIKP9yHXSP5ymBlHawuFAjUqqzWV4CFQh6JazJac/AAxsmWN6W+igVNZeQlc601JpW6
 ufWPzfwR//0sLHFBySIzbCwh/lNa9irzRFkkuBCCtTbBH9Yh1qMo/MCeiYp/looqWZWe
 tP6hOsQyBpzh6loomPTXvxBtf2tyL3vxSrxJsQfR//iebNkPplW10Nt1b2JwpWXEa8nb
 FUlwZSzNk1dcu/9vUVpOHVPIpctqHGgN1Ao6HguXMM4ZmqBX8/sXgE1qp6snwxbtkDE+
 Btew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782904256; x=1783509056;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=;
 b=M3o3MlA2KDVr9Xk+AGMlEYIiIdQ09+Yzx3zc6+2jF8VIF/sNiAcibophdpNUbTSi4g
 uYIGwO0lRpUkfQ++MlPouwFyoEjW/BWmDgOqhEoyF0qK0zC3AjszFZ8u3WQNFE6qo0JN
 FSZ0WLFU5XZWej3+Lj/HtIFKYRpYPwtKZqO5fPn4XoGy0+HYrdxDdFrwGf+GSLmpnbT+
 sirX1OV5htTlt/RFupPaRs4glj/2eToUskqkQk1e/VsjOaQAPiThY40a7aRnXSuJF1P1
 Vl9Ev7oLTkMftfBQNv3X1Hx3JXiA/3deJ34WI+jJEGMUVhcoAY5dKkGN+5HQjtcxuXe1
 n83g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9y5kz+JxAy0M0wpAiKKR6IEshcb+cj0XLWNUO06Oar5U8JWO1PVNhwd3PSUZGPvq9eMii5gI7OBu8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtEHqVcnzzt5cRs2GxYiD+YGT/l9ElC+D9Dhtq9NimqSGAf1/F
 98eI2SiA7HpFEXE+5Meg+DU62NJJDGjMNaMC5j1ZwGsS6dwDUX0blSl0dgLTDtgT5RCcxbtmI/C
 S+BWtkEuS3UfBGNyBjanAjctHMFHCC0aFIlVOXKhNWxUd/XvAYCxa1RH/oYlRRei/Tw8wLIk=
X-Gm-Gg: AfdE7cmnwS8bs/dkimXK1OwoUcImvjUFUJYzrFIXLrpilJ2RmyT9DzWRTQqd4rTS2BW
 lhmuPm4R4CkGOMOHJ+c3rWKS3Ox5lcTpr3N/e2lZgSiiCYeWFprdpDrnNbjx4yj/JBZfHDheqeU
 0sG4lA+c9zMAZF7QgQRD9Gwg0wt+12i5akj1dDhfrXuIvgUxEySfQjSvkFIo9NvLI2G8IGutKRL
 RiSF1NPAQYfUnKxf89tWv8sEg97MWyh4dv40w7TTq0qVUtKZ/ChVGs4ZHG0Q9hK72AsYVID4flF
 OVAmywQyBiH+2y2Yibdg4wt3w9qmO4JRbgXbQeOCu54GhqbmKBypyZsJRm8f372XafssoyGX2gu
 +hDTTcoretUDuIgkrZZfK860RTU4vrTpgWws=
X-Received: by 2002:a05:622a:164f:b0:51c:d16:b498 with SMTP id
 d75a77b69052e-51c26b4ff5cmr8481671cf.10.1782904256284; 
 Wed, 01 Jul 2026 04:10:56 -0700 (PDT)
X-Received: by 2002:a05:622a:164f:b0:51c:d16:b498 with SMTP id
 d75a77b69052e-51c26b4ff5cmr8481381cf.10.1782904255890; 
 Wed, 01 Jul 2026 04:10:55 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c3b5ba9sm2553522a12.7.2026.07.01.04.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 04:10:55 -0700 (PDT)
Message-ID: <392d38bd-8bc8-4567-a79c-dca7a1bb8e34@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: scm: add missing IRQ_DOMAIN select to
 QCOM_SCM
To: Julian Braha <julianbraha@gmail.com>, andersson@kernel.org
Cc: sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run,
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
 sumit.garg@oss.qualcomm.com, harshal.dev@oss.qualcomm.com
References: <20260701110344.1999068-1-julianbraha@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260701110344.1999068-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yRzuaeBTbfasPoG4ThL0QMlPeiW0Lcca
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExNyBTYWx0ZWRfXzwviZgZDyj1f
 u0Y88luCv8Z5OscVPMN33vMWb6gFLHZS/neHQqGWaAcg2X8fvyxOxbCBV6M1a9Oj1en9nZ1FQFN
 EY/bQg/hi2manjj8Cw4vl41juCMfvUs=
X-Proofpoint-ORIG-GUID: yRzuaeBTbfasPoG4ThL0QMlPeiW0Lcca
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a44f5c1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=46PZNAZc7cL1ucK_2EcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExNyBTYWx0ZWRfX8VRyO7jKag1O
 shgtLr/dVBE6URGWoub2o+LQ8gR2IUZfloZl00j+bF/7BMrqN0rQdQdJTgCkE4sZgSG6qxkLrgY
 lQ6LnGA18iQPFu/o6yLhwHkNWtjLPE8Dk3KZOswcr+J9xitO9rM0VFJAREcagtbdkpCyUDCfxLW
 6VaZg120e8VkUlbVPkb6xOFDG9iGeolf8h7RUivBoLl9XcC+K07me61M8dHmR5VMfye81rnhc7C
 wUIHo1tXSdnLTCSthII84a4CC33dfscMnrc/3wCaOenfNJ5mibawqQhWyF9XZJzLkFGrcUGUnIS
 BzRg8o5jKR6ZUpX82R3xNfD7YUgoam8HKviNT6Og7omzsZhN/9RK6cbkfiPc7DxNMhkxszGIcDO
 9Pt9BYwbMhwMnV1HVSDz/bvR9tUcQdxGcQRnLY9EQuRPwCTEgZxtGf41RhXee83+edwuBgFq13s
 +UGNf/cT8lGfYKxMdXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010117
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

On 7/1/26 1:03 PM, Julian Braha wrote:
> 'drivers/firmware/qcom/qcom_scm.c' calls 'irq_create_fwspec_mapping'
> so it will fail to compile if IRQ_DOMAIN is disabled:
> 
> drivers/firmware/qcom/qcom_scm.c: In function ‘qcom_scm_get_waitq_irq’:
>   drivers/firmware/qcom/qcom_scm.c:2512:16: error: implicit declaration
> of function ‘irq_create_fwspec_mapping’; did you mean
> ‘irq_create_of_mapping’? [-Wimplicit-function-declaration]
>    2512 |         return irq_create_fwspec_mapping(&fwspec);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
>         |                irq_create_of_mapping
> 
> A patch-set in review proposes making QCOM_SCM visible in the kconfig
> frontend, so let's ensure that it's safe for users to enable:
> https://lore.kernel.org/lkml/akS_6izxrhgK-I22@sumit-xelite/
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
