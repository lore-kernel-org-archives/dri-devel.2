Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0547CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D1D112680;
	Fri, 16 Oct 2026 08:45:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48FB1126B7
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:45:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G6Vrod2678387
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y9vrQgGb1X1jrtBDG6LZTbTc3+/VZk6Tblt7k4JIVVk=; b=YHzfYrhLuNStdkHm
 oXVLxSnUYhzx3LNP6TRsqpQ5uMkZi1Ej/U4oFYYj7gkPb/qA+G+FGH1YQLKw1WPk
 ou1+AJti/26ga1oxOmJMILbpoqHWSAwhBRmmV3GoKA7U0OkaUkOTKSwFGOdjO3xS
 36G67YcL+mJJYLuXXX48d7e7sy6ZU3z/5U1AsblGRP1bede99jYu6DNeREoUleot
 sdLmf3TZaHnt2a0MH2xQO8uIOlR3lG8rkW6d9sLC4Oa15C+4gaC4RyBDl+Tbv3VE
 P5+kGLjdqjXXfP4jfd1Vn/Wn3MD27hC4andPbhHExmTjz+iE+3lpgoYaFGHyG/GM
 9VhgoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19tbma8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:45:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5338a4075d3so19601891cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792140330; x=1792745130;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y9vrQgGb1X1jrtBDG6LZTbTc3+/VZk6Tblt7k4JIVVk=;
 b=HrCsaXSKrN6Lb9QYEvnEs/TZ2oMuhwrgc/Xr8rTbrXbSqlVX+eo6/q+tZvt6X4qD6k
 oyCJTbE5FVUeVYwDjfWttOZM01O49fHzzunx0Ym8S1xocsLytKZccsAvvWKAC5V2lIts
 kLrM8KjeWhszaw7g0QiLcYqqhWTwFqB5Ipy2k+nD62d4bdctsCr7vCfr067oUTvtHmPV
 L9kzS/G3g5p5PP6eQPR4u3fXZnJ0VqlcMSgw3BuHlKUDlq+EXF7BmaKTaNTAZHZU0uws
 3O9g3SpYUmKG4H1rke08H73OxTgTDU5t67xyVzGr+KyOVofCsg0yQiYD4fOakiEXhMof
 MWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792140330; x=1792745130;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y9vrQgGb1X1jrtBDG6LZTbTc3+/VZk6Tblt7k4JIVVk=;
 b=2ztPMG8TEzomj1lusvkJMH/QdwKfmh8LRbLtUNRluCVAFbnVrUhZYz8Oyc9tEX71/m
 CshvW905ux2CV/42AiJJ8mRfQ/FVxSlw/tPuNMwzGPMtxCzw/ua1pjWAv0XcSLN915R2
 yoCuT61ZvwSqJui9r10JN7blzGZeeGoYST1OhDGIxX+AP5X3mB3gJOnbQCJdU+KHunkD
 FioxemGOETG3lxQ0Y9THsXP4m7yAza3KAv59gWhRkKHSPamiViLoSCW5UtywhkmSpdfI
 h7cMJj06ZAvlGrNlxaId01R5kO+Xfqfuw/j/Vgc43rWuXFF4n3Sv2G9QsLzylUngpEOW
 VEVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXmt0O3PMoHEasp+FczHH4xrGJ/OQn/ohqI1qzXsiFe9svsbFxCbRhuvjZOTC0Z5pncneB75Dw6Vg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK0vwT79YD66ORQUmiQVrShFXeXY7kPzASSIZXfIvF2cfZ099M/
 rPNio/6xkbiHBOEopcv8ROxTSTkUYpmwo3jGyCdbjuyLE9n6x2HWbNZEYQktuPLW31BhxLByiDS
 emtWWAXVJej82IsBfyl9osH7fVCrB38oQ5nguqi881JKI5JUyNuF6TnLyxVTKnFmvQ2Bvw4g=
X-Gm-Gg: AYBFou3jTdHbcZA8P5rwnZuIKhZrudRqFsuHROMEAXcHtK+pOjjYIMH2o8QS102cafz
 Jz6om7fDgRYS4gesNGvP9+/+9eaKwO/wo9anUe6wOFrEwiH1bCxnrtNEEdWe9vswODpQBcrppyv
 2TZ39JdA7zC+4a+APxRQ1eTo3tRjBpip7TN7i4hYtjbo7oDoCRy35F+D7gRkN6Nn/1e+UOLHmv7
 B4viXEYBW0UiAlGbQYrNA60HYxPA1ZQ67Ql2DlUg36gzgit4Ql2BqIU68GaXS3zJukemc5a1k4U
 Qsu0o8L5DD7YOJwnIqtGp6vEaWj32Z0tLb4Txl0liPHFgZz0WO8jglB7OAHy9n85r29aOLsZyQl
 BNXbN6NchRl38NWMzrfuMZQ==
X-Received: by 2002:ac8:7f50:0:b0:534:7732:a141 with SMTP id
 d75a77b69052e-5359f4f6af2mr413655491cf.2.1792140329960; 
 Fri, 16 Oct 2026 01:45:29 -0700 (PDT)
X-Received: by 2002:ac8:7f50:0:b0:534:7732:a141 with SMTP id
 d75a77b69052e-5359f4f6af2mr413655291cf.2.1792140329567; 
 Fri, 16 Oct 2026 01:45:29 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40912ce05csm52215966b.33.2026.10.16.01.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 01:45:28 -0700 (PDT)
Message-ID: <b0763841-cfe9-4355-b900-ae43d93dedf6@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: Remove FastRPC compute CB9 entries
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20261016052042.3755352-1-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016052042.3755352-1-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -7Y306FZT20hJCEGf0kcbT7cAa37sV53
X-Proofpoint-ORIG-GUID: -7Y306FZT20hJCEGf0kcbT7cAa37sV53
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1e42a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=t1DTHQtY1fS78f0Aag0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX0CdwBdXH4WB5
 +WrVC1YDl48cLgfH0SDeN2yY0twruNgOtfjU8Z/dnglGth1QTzl/Q8yUS6NmcVLorcGzhIdI8FM
 A9TG38CkVC/kK3quPnMy/9FNvV1N4ngJC0DQ6d4MMhwOh4+XuCIw+aojPE9zibhwdpCSzXDz/3L
 6Dd7MpPWNFePSLdwcqp2KtEu6b0yUjc1i6FqIQW1o3Mo8jNM5niZx/RjX4ysWe6ZHYiF6O3c7Hz
 QuIAiPRhCvfmnCb2HobVlR/EKjfKO2E+WLVg6BQhTKRnm5LOlmc/ceBXe74tpB5ds7LLdyEtxe8
 oOtKxUTMpogaMxIIlKBWSMd69eew8dtut6pnOnDNpb7tkLzG3Vdy0SpoaJVlAABe5oGOHDZ3VPM
 QMFMSOKJTdCTV/bDFdq/oIL+L+NqKwNcjSS1DJJBli/WFbDHOt82D5Oh6jrY/7FwsFP4HMRDBhH
 26w4bfiJzR2clFKg/vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX+lhmBP+CkKqi
 1eCoE1Ul1kIzc7ruFt1NBZZIegYZLV73vqC08IeHMaYmyxy6Hz1f3wJQ2SE0oUhAwqEPcmr5N5C
 r4UEhRPEPeEwy1q5kJHSfLY+Bm3Lv8Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160034
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

On 10/16/26 7:20 AM, Abhinav Parihar wrote:
> Context bank 9 is reserved for secure use cases and must not be exposed
> as a FastRPC compute context bank for non-secure offloading.

The lack of a platform name in the commit message and a split over that
suggests this is a universal truth for all Qualcomm platforms, yet the
patch only limits this to some of those who currently define a cb@9.

Please make it more clear which one is intended.

> Remove the compute-cb@9 nodes from the Lemans and Monaco device trees to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.

Ordering this sentence before the previous paragraph would make the
commit message read more naturally

Konrad
