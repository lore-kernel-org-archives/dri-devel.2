Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE4E105F792
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8625710EB79;
	Fri, 13 Mar 2026 10:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KepYOX5B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K99SKqKY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464FE10EB7A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:26:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D9B8c33906329
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /2/OSAiGAUHW4XnsE0CTB6bJV6KzZftaOknR1VBiwHI=; b=KepYOX5BnxIYCRuJ
 94ssczBs/31VO4ERQfi0c76tisz98nntJRcyUwitreyg1lxlnTIr92vCeJJOubtk
 og/D0MqZ+slVoNGPItlGQ2Zb/FqHakaRG0JdhSby9EBghW8fH5Eid6Ih85PRM62e
 uQG0zVC6XmNQ5xZ5dlksUS8gv9F7ANRFV0nj26ONBWF4urDoL6yAVtQGvUthoEqB
 jtLa7t1gzecwUllQfxVaLMwLalm94hesGX74fa/UpVD7WdU7bDmRJfuyT+xz8MQm
 /HzRXTpsMG1y9ecs7WIyUYP2pF2YbKST30MK9rSCKDshfgHoP8lI16hB8vyeyuf+
 9mOjhg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfqs88y8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:26:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a086578c5so11636876d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773397605; x=1774002405;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/2/OSAiGAUHW4XnsE0CTB6bJV6KzZftaOknR1VBiwHI=;
 b=K99SKqKYxlUO9dtco3xuf+SItPDAEpAHMLoz1UqX3nOIGNYkQWbrPmgLU5rKyzE/CC
 eShmYX8sxg7EMopx0e3xeUls/ZxWvXnot8gEyWBzxEBzyuxi5T5WZ+FClaazpKdh0wlt
 6ChsDZD0eC8Zz7ln8G/oZiMlBBibdJM7zIzLTS4YIi8bql6TPyJW00Up8VzZsWGyEwgr
 0Jf4fjpTm+Qit8C3xg1KRt/to7dJDSU7WXKSPBVdYXJrtL2Zj4PcVz05eHwzAMN7EF0/
 NQpz+AvX+AUdv8LF7PAaU8E3I0gcxBR9XfDhd/OFBVavdCiWcZb2cpR9n+igguURBdsy
 ubPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773397605; x=1774002405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2/OSAiGAUHW4XnsE0CTB6bJV6KzZftaOknR1VBiwHI=;
 b=VlQ/cbzKO72YuExPEWx/Ka8NxkRIx5RIDOixaFuN/y0u/I9Pcg1pcbkS29nGDmTQQ6
 elXWa+bsVRpdwroxWGTz8/02tVLXGOH49rNeXDA29nSMNgG/9cAydMUKM2ambAlEWCs5
 TzolI+62ZnuDxATb103wb4tPUjhHy0ybw+Ji/VXeIrzcAXc3wVYcB++FOuiVM9ZQHdSj
 DTbs1Vhg4s9GprzuzQuv40CEUdYzJnYQj/fwloIYeD6D+0XgY+x2KLZ1Lq1GpVUB04kn
 6DZ4CMflUgvihxBRF4Y+MApIjxuHZhJA7rP0SpixYy4MBM6i8IiFTqALV13AukvAIY4a
 mbPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWZvCbMDM5xaE9mlnc1PjcCSDEuWdEh3vaT5kMbWrOMnJdtiv5FhJ9548mcpspE95OjzU63DwzeLg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdYC9DOAns8OYf0YVsTgOYgJLyDHfIRe+oQ8fT9tID4rj9D9Zt
 x1JQiy8LMonaomoxdt/X4iD3VRnm5gOFPaY8Jh8RlgYITYtJ+zl4nfW4IgRwdIm02j16iElAtfN
 Xlp99g6JEglvayqe8OgLFcQofi603/NbOR725xY00NIAruNQuCPpG1FN/QWv+YkFZTUSHaWo=
X-Gm-Gg: ATEYQzzuA+AMWWx7ONjMQuVWSV0Fl9wM+QXW4rqIMpImmzt+3iXayFsfevEh2GhDLhA
 pFLQohCiofsj2fxAUO0hocGVEhUzkVh7k5TPxNl6ILL2WJQeZyEqRdZMvESLsgsFW9g7NlNduBo
 GFbMwh6cbDm2/EWZdoTfxyTopixiC9SBEGQXZglx4tyVt4NVawX0xBBQyL9Vbu8V7YT1mCrt26y
 bziOk9Qwo+H30W6GIKdQMbVDrXg0t0YWygqwwhGCg7v5JMn9ztz8lT/mvv1s6AL2Vy7isTKVkpu
 S+b71aTx5zHR16zAJxP7MdmcUhmIaMUhpccwFCVk3OBCAvOmsgVvOo5toUxLB6YTXmlNipm+C+k
 azLZ2UnyewUF85e18D8IbaYvQMjWVg5a9ogPWyI/RK/KsS8O69aR2X/yCUaWVsBryHA/dsEkmlI
 Zka7M=
X-Received: by 2002:a05:6214:470f:b0:89a:5323:8602 with SMTP id
 6a1803df08f44-89a8203e6efmr27306306d6.5.1773397604637; 
 Fri, 13 Mar 2026 03:26:44 -0700 (PDT)
X-Received: by 2002:a05:6214:470f:b0:89a:5323:8602 with SMTP id
 6a1803df08f44-89a8203e6efmr27306086d6.5.1773397604203; 
 Fri, 13 Mar 2026 03:26:44 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cf3db5asm35694666b.56.2026.03.13.03.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 03:26:42 -0700 (PDT)
Message-ID: <b914470d-5ab7-48aa-858c-58d8863ebdb5@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 11:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/27] soc: qcom: ubwc: drop macrotile_mode from the
 database
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-24-b7e8f800176a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-ubwc-rework-v3-24-b7e8f800176a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cPDeUcCuqq7Z9GLwgIMc0g0pl5YSGe_X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MSBTYWx0ZWRfX6l/kkcd/mnpb
 TXk4X2uRpn1U7KrYizomFgAInchu/EmO9nWPJcAt2GdL+POVcp2g24gGhtXnL5QIE9viQpv8vnS
 91wOWp37znejzoBBU6WJQJFgV8leEdvtRQCf6uH9RahqsNabGts1n981F37/X0Gqaqe6mMxJJm6
 rVqezXjPhAx+sfKHDmCJ1whOGAJrsis28g0PLGH2/WIf7nPVq3Y52gxbvJa/wD1N1ZuAmdNbuLX
 qpxGnQenOsCovTipsDD5FPeQlGn3BmiBjz/Zd18XbgXMLVAb/4pSoBl0j21ZrQghN5hE2c3/KLr
 euTi8NxJMwNPVAcmLrC/H201xYj4frJ8fQXh1wgYcB96U6nqSxAVjZniVhc0YwsVqmcGXe2NdNh
 pyc5PBe5ySE8Oi8wvbYzsWotK2IoOGsT0D9YJ4qPcRHPsQbE4oH+OXWH49YramnrQIob5wDQHw1
 cZN7Pc6TW6jKN3By+SQ==
X-Proofpoint-GUID: cPDeUcCuqq7Z9GLwgIMc0g0pl5YSGe_X
X-Authority-Analysis: v=2.4 cv=GoNPO01C c=1 sm=1 tr=0 ts=69b3e665 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=I54dV6YZZfg9ki0ab94A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130081
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

On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> All the users have been migrated to using qcom_ubwc_macrotile_mode()
> instead of reading the raw value from the config structure. Drop the
> field from struct qcom_ubwc_cfg_data and replace it with the calculated
> value. Split single UBWC_3_0 into UBWC_3_0 (no macrotile mode) and
> UBWC_3_1 (with macrotile mode).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
