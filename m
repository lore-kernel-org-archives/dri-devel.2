Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A73105D986
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 22:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA3D10E4DA;
	Tue,  7 Apr 2026 22:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OweH0Y2k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ck8FpipG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9A410E4DA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 22:14:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637JlsSN1314650
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 22:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=; b=OweH0Y2kARoYn1W1
 qq3nLdCQrnMusgkFKVH97SH/YIOnMEsAfAZK2KoiG9Gxh/8/n7cU1UsGD3/JY+O+
 TnCC6+QeX8Z0IUKHaUmjTIypZ2H0UfYbyJVOT7JUEat6dMR7LzZBxjoLQJyQmwOz
 hXC6WmTAPgKiCEnt8sayLvxEaf1aQEZ3KVbNm3zDkVgkpsYAgEMpiGSFzicXC+GT
 zLbUcVWQXj925Bce1NoFoyGvgQBlVpoEnadvPpUlxJC/tmR4UarU4h86gc0j8iqn
 9zGvFPUfebfRPl8K/kWd8XSw9wadeBrURZDqQNVSPOk9jaO1/Rspujy1bXSio4MO
 UaKy3Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8d6gd44-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 22:14:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c16233ee11so7871785eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775600066; x=1776204866;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=;
 b=ck8FpipGtPvfoIcf+0TfGNCfzalVOgNr10amS11tgTxqgFSBBPh6LIESonmSSuLBWv
 QfGf8RmB4tV6EMrTeCC6n9kd0AJlOSSQKasoDbMQSpaewpixL24Y0dpVrW4NP5klYK/A
 ut40ZVD4P5J46bnJWkIhxlmdSoyG1JDpv3M3PAIJpoRWJWtSKdrFInahso5SMWhNIY+P
 pmrpCWJwg4jhMC8z32JyH3NbUUJoKr53tqeiJTeksTTRYrttE5XWgE3I64dM30Vl6qCV
 FGJBAORXlRtakaRjvkpStlNTrYvZyf7dVLim9JtXSpMunvKlQyXBQfnZ59KCqUQ26d/S
 mDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600066; x=1776204866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=;
 b=ae+zW38x41MzRb7cy802jn6JRvlkVSRKdFrcFU6lbMOCfD+1owhyQdZNIHkiVvRioX
 RqQlSeHHJturJ6/OYVgEdZzCFiju5yrncRNgjlDpIj+WKsXaNgmSX4v7/2sAyoCnCY01
 77MbzPf1ToUzPGuieq35Hs+AzUstjJplgz9NPD8w1Ss+1tNQF8OTM9yWg/+/1UDVjmCq
 pyRGEfpSZD4X2m12mA9uUCxh3HePcbuUCp76EknPynrVI7sWvxOdvM6MzSwTVP9Nz+Hl
 fvR847StRtVYfIomZr+YRImFt75a9UCGq5cC7H26iGCizXx0VZezvCe+r13Wv919zDZP
 MpGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8UFwCGE/gUhrUYVLV4uepH3zC8SsTiQ32WTSvKt6N756/5SgYcAZ0LKJM08KrlP4sxJltpZ1SJWU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/yJIeTrF871LqAMseACHGVL32s2psBTZYYa9I22DA90YCnkms
 PgIjWcW2YM5qNk79Y8myuFETwZFrDcwHpslRPRoJ/x6d0djxlKmAdWISIkHsRDX3KiwTvl40b+1
 qmKiePpPMVcN3GrIsluu/dB+yT7dSXd+/69Bcggsd9cHaXb7xQiJI0lXvTV2S/QXKQ35Oc7o=
X-Gm-Gg: AeBDietJnyxP52UX/Va97fQVZayKB7FrglKl8VhYmVHAt3lwKsw4Rb73ocw1OyXXjfb
 DvbTVsbzh5HwmV9GRgxXzNfxgBGFKh71+SXXzucCGgcrtPihuRIsn7uiC9JapGI/75Mb4DE6qxy
 0kXEwR1gwieqJxmNQP3ccf3BQ7712f87erE8rEnEpH6b/FO9QrPK5jjSlRv0fQbIa5zmogHrevO
 P+tG1e8zJFq8VeoKp3Eme4760Mq6seqiXfv9dfLAYKk04WY68wk07mTXKa3UO1ZRNgsPs3+piIY
 K76zHQDAFUndPlvQRaZ3XPbf2x7Sch7OzfIjPgP6RGnHb0cTnb7VVh6QHPERHtwKtZHLZ3SYADZ
 pWRiNVEvvi8GhEtBgF8RfxVJ/0Cgf+xH3yn91Yyd7/8t2zzsrbKIKV1t3k1zG9R79iky+Fuly0o
 FMq4wQ
X-Received: by 2002:a05:7300:880a:b0:2ce:f3d7:20c with SMTP id
 5a478bee46e88-2cef3d70bd3mr4324846eec.29.1775600065595; 
 Tue, 07 Apr 2026 15:14:25 -0700 (PDT)
X-Received: by 2002:a05:7300:880a:b0:2ce:f3d7:20c with SMTP id
 5a478bee46e88-2cef3d70bd3mr4324829eec.29.1775600065017; 
 Tue, 07 Apr 2026 15:14:25 -0700 (PDT)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cf2be19f85sm12178552eec.30.2026.04.07.15.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 15:14:24 -0700 (PDT)
Message-ID: <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:14:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>,
 Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 vikash.garodia@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org> <ac-KQ7e8-syph1Zl@trex>
 <adOcMsk8a_Clb4WZ@sumit-xelite>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <adOcMsk8a_Clb4WZ@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ivlVJmzL1fXOe65hE93ayqi2i1d_SFKY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwMyBTYWx0ZWRfXyJk86uhqb4dO
 23yKkV0nvQTvVHaACuAZ5aah/jiZD52wu57Wy+RKnRO42BiV5okTNmWswUbf93JITzzLsu4ssMG
 73PX6g3EkkM6n1mG0QFBCwkNRQwnw6MdXslRhdr0/INvJRvUUHCmM5oXtbHgwhT5D+Az+0/8ZEb
 34z6c0FVA+Qu5O3ut8jOJ6ZqHxnqzgwExpVnDuJ0xulhv8COzVKHmvZSHExyVpv9u76c/VIq0ry
 2l1vg752I/Lnfghnif9t+fe5vAYvwYuCnNaxctyoK+zjzAmzfIFN0PWBEk7KY/aCXHGOf+1uKze
 +Q0pRwSbwSJDIUs/uxpJsWh1GIgzVvAHddAK/LlMcYHfXyXy2PFwz45KAl1nJZjhnSLiIII8CX9
 +qHjFWtPUIKJOU4mXIQ2WFBP7OCzFxkvRbFqaKZ5+d0Pa0XY3G0f5cgRlFi8OUHuoutNw74mjIv
 vZDrT/oVV7Om9DVYF4g==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69d581c5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=nRfXl0x10UYwF-qtBXkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: ivlVJmzL1fXOe65hE93ayqi2i1d_SFKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070203
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

On 4/6/2026 4:42 AM, Sumit Garg wrote:
> Hi Jorge,
> 
> On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
>> On 27/03/26 18:40:39, Sumit Garg wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
>>> TZ service allows to support multiple TZ implementation backends like QTEE
>>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
>>> backend service.
>>
>> OP-TEE based PAS service relies on the linux driver to configure the
>> iommu (just as it is done on the no_tz case). This generic patch does
>> not cover that requirement.
> 
> That's exactly the reason why the kodiak EL2 dtso disables venus by
> default in patch #1 due to missing IOMMU configuration.
> 
>>
>> Because of that, it is probably better if the commit message doesnt
>> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
>> implement the same restrictions that QTEE (ie, iommu configuration).
> 
> The scope for this patch is to just adopt the generic PAS layer without
> affecting the client functionality.
> 
>>
>> I can send an RFC for OP-TEE support based on the integration work being
>> carried out here [1]
> 
> @Vikash may know better details about support for IOMMU configuration
> for venus since it's a generic functionality missing when Linux runs in
> EL2 whether it's with QTEE or OP-TEE.
> 
> However, feel free to propose your work to initiate discussions again.

Vikas and team depends on some of the IOMMU patches to get accepted 
before they enable the EL2 venus support. Please reach out to him
and Prakash Gupta at Qualcomm. 

> 
>>
>> [1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507
> 
> -Sumit

