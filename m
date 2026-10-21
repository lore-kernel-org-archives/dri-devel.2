Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB4606A327
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l8RcDq9l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iYkXFDKP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD4310FD95;
	Wed, 21 Oct 2026 11:32:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CE410FD89
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:32:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LA5jBm3449618
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4bn9+rLi7mMU4unxZrBwSU21TRh2XBO4KfFG2d5PF1A=; b=l8RcDq9l3hlmBKdH
 rHQYwc1NxJzwU37rKeIVvtCVpG8tsm7/8m+fWL+7YJUxZ6Vz3+cd8wWCQAS9o3c5
 UdJdmH9FKwP5kfwIwPl+6MWhFnTlVJPaPtLBL7lNfsIAWyL75d8BjyW6+oSjkyUJ
 ts9zKlfWRcQohLZIuyF4Kv2BswJmjxVnnHcFvKZONBDwYAAPXPzEQlklVjDT1vn6
 Pb+hBCG0A9MkIXgbz/Mn7vUDpELVFnNAi4axkd37MCHC/jFgEMY8ILSzysAg/KqK
 Fd+dyBGog6MJCbZC6DMF7dy2OC4ssqVHtW3J9pskxoTBWqBA/VRpeZn2rAqlwH9F
 yNqkLA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9bfy4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:32:20 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc254b8961so7552137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792582340; x=1793187140;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4bn9+rLi7mMU4unxZrBwSU21TRh2XBO4KfFG2d5PF1A=;
 b=iYkXFDKP45cn4I5Ia8gNEG4njmHC0fzf/JQrpGyC8HRuFWltWRRIvckLx20mPr4SQr
 YcfHNFzu7F+WIlL17r8aSVlUpHgutroys0gPp4/9K6pzRcKE6mcgauigym1WWiAR8Hrb
 lz2tPCrO58J3XY7swad7v1SNu08QixVMsfIMsH+aciT3xepf3kBl1ZawJf8o2w9JqPKf
 vWvdblHrz3oiAZBoNQddeYVe/K60BlrnO6iOjAG89ANhNUEehagk0MoiyBqxM7Cf20eR
 Az4h7AfbJyX/uOHA2lAbpcZjtlPTf0WnboGsiUkabb7L21bVC60hgp1K99Ag6EDItv7R
 ffQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582340; x=1793187140;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4bn9+rLi7mMU4unxZrBwSU21TRh2XBO4KfFG2d5PF1A=;
 b=PgBqsnL08XUjWtMBni4pIFtEnun9W1ImnRSg/tzQsEvx7YagT8XsDkJ6wvEOdXSHk1
 H1sfAUcJAepqbykUcF1RM9a2KvEMyo8k/g/us/wfKRNPYAos9h4KGbWYTSChe7sgwX4C
 Uu3wTAdqO33Y3Ny5Fpt7+qb2WWyiDhvUJLWpxsHkqLKP220A/SNzrr+hS/G4L3wpNN5U
 8KiDsHJTiahq88wPuwp7ehorlcrBethqbjvJ7f35PJ71a/9D6CxTx+UPjbVJUtQb4O5E
 yVXtrOTI3ga/2t4MJ2xGV46KmqfHQGvCeueBp3Tgzel8PibDeyxliWayFyNf7iUqBGYN
 vIQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz93f18c7I2/NbR7psniLYakhEm8vdP1enjgaY/DT+F/YYoSjGjgXR7eb1ti1+F0C1Lupv4ECHh2tE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIdhcga7X2pZN2p5UXptOnZPupcnUR422qg7nFxElntgfGZP4xc
 JwxbYtgD8JOQeAQHpFzyB526h8hZUf7jby54L3WfQrzLFDabQG0x9V4l2Uow2//K6PjYU/ruP9v
 MjdN7lET6EylKsk4vptGRYWCFZDQPJaSoMbLdwK3bsO1KtjgzEPglr2ACMedjZM2KCZry5mQ=
X-Gm-Gg: AYBFou0BPGqfOqBijylVtKAZMTX3zo2PQfVDV/j9ETIIC6mEJnCjLdovuLyr7+94bCC
 huerkLgfOPJmDHfXjGTnHX8qeG+ldgnHOFOaPjXxD3rG05nf6Vp1M+c7RaHqxPqIV/H15do/OeG
 /McTWVsqWEBBq7SiZd+HwZiPRi7iET7lXq3ryT/Xf9z1Pl2/AKkpIr2urfwlhSl/nhdQEs1yEtP
 A5JQjzzRHXKIh6cdgiRG2JwRvBq1+UkLOV7IrYR32EhK49T7ak3oZ+6FEHC3rAR795EXVbTj7rx
 Hqx+mWPT/bBoE8KYvgHfjg44bg2mMXtI8Tvd+B6+5huKOuCw+w8VS37UtmvmPD5UPynEMW90i60
 4gViG6EdEG8RuWro1oUjEsw==
X-Received: by 2002:a05:6102:1626:b0:7cb:fef7:3763 with SMTP id
 ada2fe7eead31-7cc92623e94mr467053137.3.1792582339562; 
 Wed, 21 Oct 2026 04:32:19 -0700 (PDT)
X-Received: by 2002:a05:6102:1626:b0:7cb:fef7:3763 with SMTP id
 ada2fe7eead31-7cc92623e94mr467038137.3.1792582339070; 
 Wed, 21 Oct 2026 04:32:19 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4678fafd25sm67887866b.47.2026.10.21.04.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 04:32:18 -0700 (PDT)
Message-ID: <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 13:32:13 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NSBTYWx0ZWRfX/WK6RKXEWAUZ
 WOlbkaBLu1K+w6cFpW5Bt92nxwM3CXttwJGob4xSZkMR/Fg5mBMi+h1ay3O743KP3DQ6TsnvApK
 uS4pBXVIJTFpyw4BliAly9I4jGqpon4=
X-Proofpoint-GUID: uI92IIUxdvY0LxW3PBQ3w9YicKDaFpRG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NSBTYWx0ZWRfXyHzzZ8jLekK3
 RTMooPy8JeU5uHqiH8LLkwQCvima4X/M9G+uUuz0RPa2VJfNkxQufgcsFljd41bE6YKWvlYAHQW
 /jXxvQG2gjX/v903mJoopFhcSvZa3l6l1GWvKh/2ZlnzM1PYXPXcfWdkHOEVETsAFKx1dsKB0Ip
 z6e9QWgaXJBWE8v2/NHvYAE3q12Zgu/Yo1CS308zvx5s0cE8+6W4iSLIfd5PBiIJI7A7pokkHLC
 JrXfU8n0t1tzBYtIX2iC56pX+xDb0+cIePt25xgTRA3MgWv81X7F/ZIWBp/eDf5e46pkEQPBr3U
 wJvFlmgRyb5dXedqqnlOVdoOhOt8Hvtzu8/ZwBpYEB+9DM1R9QZuT+Boxtm8hvg7BvxlvzPvBXM
 iFopRkwq8unTWblTfiwirZtXni+mgNn4SPIv5bEUwswyJXRgbdhuWi0LgsyCS7Wnz285g/aUDe3
 sblpylSOAAVOOY1XKxQ==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad8a2c4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=25W5T12MUkcB5wj6RmwA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: uI92IIUxdvY0LxW3PBQ3w9YicKDaFpRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210045
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/25/26 5:57 PM, Mukesh Ojha wrote:
> In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
> public function, migrate every user to the new PAS context-aware API
> qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> 
> This series migrates every remaining caller of the deprecated APIs
> (qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
> removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.
> 
> This series is based on top of although no dependency as such.
>   firmware: qcom: pas: Make MDT buffer retention explicit

LLM has the following comments:

 1. Metadata buffer (ctx->ptr) is leaked, and overwritten on
reload, because qcom_pas_metadata_release() is never called
(patches 1-6)
 2. devm_qcom_pas_context_alloc() is called from repeatable runtime
paths, so contexts accumulate until unbind (patches 2, 3, 4, 6)
 3. use_tzmem is never set, so the shmbridge prepare step never
runs on SCM and the commit messages are inaccurate; TEE gets
a real mem_phys/mem_size change
 4. Not bisectable: patch 4 relies on the NULL mem_region
handling that only arrives in patch 7
 5. Patches 3 and 4 don't apply to this tree; iris
iris_detect_firmware() still needs mem_virt after the load;
the base of the series is not stated
 6. Patch 7: NULL mem_region now means "map internally", which
weakens the -EINVAL sanity check
 7. Patch 6: redundant second ioremap_wc() on top of ath12k's
persistent memremap()
 8. Patch 6: ctx is set under one scm_auth_enabled check and
used under another, which is fragile
 9. Patch 2: the context now carries the full region size instead of
the MDT size, which matters if use_tzmem gets enabled
10. Patch 3: stale qcom_mdt_load() comments remain in
iris_firmware.c
11. Patch 8: no issues found

Konrad
