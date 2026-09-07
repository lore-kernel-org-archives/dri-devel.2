Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E453C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C21D10E741;
	Mon,  7 Sep 2026 09:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADqQI+Rc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RWQ7jMEG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F41510E741
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:44:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6879bT3t648880
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 09:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tsB9Vj+XTt64+OVf4kxojZVD84CZESJvrBN7JqUuMIA=; b=ADqQI+Rc9/PByyKr
 oqA3W2qgI8GFRt5Vm/sZ/IfoqfXK5NyZUeaVmbLWnYDF0LbkofGkAJAy2HFl5c4E
 a/YMUUQQpCbvrn30v6BfTEnBxlQxcMmy/tS2+Pz7KRLyDTjYES0nnr/4nlMDeEk/
 W/mhyL/12dR6dJX1LIfnVwfEoZ9P6+v2dlb7kSMzN/FIQp4mfIZy7X+ohGKGLK0r
 wJTfAeoeraGL/kO4nACcCgWG6yQynq7TcQCouNf7XZIeLwqNydxbEUEtfDhsJyuO
 lyPCDkc3ZL28acIZr8JvRrHqis61gtzNgOpe+bEjhZWks+AnL2EDPtLqiPgOqwWl
 ifdUnA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua8rb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 09:44:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1b8088203so3797189a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 02:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788774282; x=1789379082;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tsB9Vj+XTt64+OVf4kxojZVD84CZESJvrBN7JqUuMIA=;
 b=RWQ7jMEGLxKzRkYlqnP+C0efJ7nw5RBzVMC8aNf8koUaRElABuVui8/z0g1TARmjxW
 w91A+YJZNZ4Rvt3hwpA0wb2R2W1Oorv9WtiiY8974OVxFIel5cmYSAL9UtZ7m9a5/d/l
 3gnyU3ZjUpIQ4/DSzuOXC2b1xM9M06NsMVxC5MRQFP55vkSDiir2GMt6y70oVRu7Nkq2
 vG+bpqS/OGgW9hxSr8EYlL58VndRjpeAQiF+zDh9Mh/mKn0R9BNMBHZseaQf5v+4/d/W
 aUVx6bPE/BmfO8mWkQ44AIG/EmF8s/lk35fg3bRAeJmiukGc52607vPVbJcL/pt6Wy8/
 bF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774282; x=1789379082;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tsB9Vj+XTt64+OVf4kxojZVD84CZESJvrBN7JqUuMIA=;
 b=JCkKRFeLxzdZofTD6iQIZtc3tUIlY9bvX+KVmn7t6J7YYLwDWblaQyzk0Hrk868F8h
 KjXD3M4wHckUYge0lqXvGNdNNH8u167t+1CiXpt6kGtyu/YTJLP/vyRRo3IYWhaKfgxa
 /7kYQi7EfZ+j7Emo++nPJkoYaQPppv1PxyNaMqibBgZNLT3R7RzpsVvxLKPXEJdidWcQ
 YiZZjO/b6QBph1uN2SOVjtEPmXrzxsqIrU+Kp4jjmAuDqFXAs5UqRk0bbyGcGysrZ5Mc
 mBYZNJ0Ul/aGurXF62Gb65snsQjXNj/gnF8Hm5d2EzfC3+aTxIxlbRpuWOUhv8QUoNLR
 TlpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQBhQm1xveuYpzxBWAyS8eyXmQe8xhYJi1VEHWllFlaZtQ1/1oaSUJAoXH+UG1JKNlxXLrL5u5iyo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n9j2ZFO1V8kkO8+CD/9gAsCZajBEOzSY38erE3HoUDuSPLM1JS
 6eDvX2eQPSyjHyZ7WjzYOMsHHkXHWFwlC86t8SeSSzq+mzlM+ZB4iSdcrjjT3nJa8KJz3nT7KLa
 /v6GZiYxrutHg4QB1JUL/RWIzMEsNd1CghYSyukkI/yHrVV2lt+D99zMPreBwuFadxpovYKg=
X-Gm-Gg: AYBFou1wXZ5eUiES5nLApcJCI0G1Kr4yqPeNNreKfyVrBen2mJLSqT1NK3gApm6oPjf
 eMF26w7Nk6XEqxDL3v0BDL4gwdXR2YdQxJVK2MGsUchcnT62zudSAoJ9RuDDPeI2JK2rrvJAmdL
 g97xuAvnT7wUZokKgoNLrqOzMvabCo1ZePWUc04S2huMX+n94qm2wUrm2YAdLgBp0KlT32cIdW7
 75uR1E6/hrWgJZkcEZmsOJqbQpzMinRvd537jxA/FQg45+HCmZOElscmPLSEQpfuFCfJbXvmLxM
 VpYNGxLaxaKrDXaMFjLCO6XpcevNtF0juBotxmcBXd/RJonPE9ND2k1BTZ7U6bInBMPWVe2yz2+
 brZwhF90b119XVKw/u4jgAIk0/CIeN+o=
X-Received: by 2002:a05:6a20:7290:b0:3cd:9f99:3381 with SMTP id
 adf61e73a8af0-3da39878551mr32148262637.0.1788774282503; 
 Mon, 07 Sep 2026 02:44:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:7290:b0:3cd:9f99:3381 with SMTP id
 adf61e73a8af0-3da39878551mr32148214637.0.1788774282034; 
 Mon, 07 Sep 2026 02:44:42 -0700 (PDT)
Received: from [10.206.103.40] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm41820620eec.15.2026.09.07.02.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 02:44:41 -0700 (PDT)
Message-ID: <fa897e53-2ebe-4322-bf73-98788854083d@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:14:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/msm/dp: skip LTTPR init when no LTTPRs are present
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-3-2825e5bf8a96@oss.qualcomm.com>
 <315db50d-6553-412d-8fca-a4b4441f881b@oss.qualcomm.com>
Content-Language: en-US
From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
In-Reply-To: <315db50d-6553-412d-8fca-a4b4441f881b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E5ZQne5KnhXSUILpfBrKtWfR-1p0T8mb
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9e878b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=RZhGKP1uXM2L-Qacb6AA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: E5ZQne5KnhXSUILpfBrKtWfR-1p0T8mb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwNiBTYWx0ZWRfXxahPQ/cTjiA9
 L69Cg9ORaeQmUtEv5jvkPE8ECpeMvSjgSiAKZSnbiXcchjY6l6QnLrAcjg+Gh1J7F/SF8m+X/wN
 UTaM6NOVVgGnU62Vk1gkmxmykRYgSgs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwNiBTYWx0ZWRfX/0HJ7X5xm+KT
 fk3yqq2bhKyDeTt8Rz9nC1rhXkH9RDV5QFHMbavgYesYMLZBVQ6HETZhJv+6/9P7raAZFja1O5z
 JUaJ5/OnwlImtca/cNMpLoeAhL4/Vy9bOUm7kPwAUYVapdnaYd9zxwWWb34MK8bGVR3k5yhxXfo
 tDN8wdTrpLtpcGmA+ylxMVE5wp74K5c/hPEp2bvi4iauR0Qs0Xyld/q+DIH4WK6hc1dKOoDxU/r
 UvC7ZvbZhutKjNbViP02buW6bITPBgppyZ6vikawULcuWVhC1c4YTcS+shoQQBz47UhTcB/Qjzm
 L+HE1gXpQPsKj624cyFZwcTpgEh8RfZLxTj14xSbB2zprHjLhMztS2IegGh2OndriNwuEk0H+eR
 JoXjQaGXHP6VBQ8z1l/DsZWjVhUwDpqyStGIVesAPOK8B5/wY97LIegJ4GyFBeZhSzBosX429Jn
 LpEWS2NJOAXSxc9QJew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070106
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


On 24-08-2026 18:45, Konrad Dybcio wrote:
> On 8/24/26 1:28 PM, Saurabh Anand wrote:
>> drm_dp_lttpr_count() returns 0 when no LTTPRs are detected and a
>> negative value on error. The previous code passed the result directly
>> to drm_dp_lttpr_init() without checking, which would call into the
>> LTTPR transparency-mode setup with a zero or negative repeater count.
>>
>> Add an early return for lttpr_count <= 0 to skip the init entirely
>> when there are no repeaters in the link, matching the expected usage
>> of drm_dp_lttpr_init().
> Reading the body of that function, I'm not sure your statement is true

drm_dp_lttpr_count() returns 0 when no LTTPRs are detected and a
negative error code when the LTTPR common capabilities report an invalid
or unsupported repeater count.

drm_dp_lttpr_init() already handles the zero-count case by returning
early. However, when passed a negative count, it still writes transparent
mode before returning -ENODEV.

I will update the commit message giving more details.

>
> Konrad
