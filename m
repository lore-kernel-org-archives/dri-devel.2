Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C18C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B142D10F05D;
	Wed,  9 Sep 2026 09:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jSd6TU9i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eU5qV+tE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B37310F056
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:33:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6898OTtX639125
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 09:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G3ioQZMKHwe0XM4c4x4bDZIuIz125l7nRfQhXfiQNYQ=; b=jSd6TU9ikeRQPs3y
 FeEwVvdiWJ1SfErQCQQiALnOJ0hXnDx0R6jmtUmWrtbvMlDXaMiLwB4GFCgl1Guh
 lCm+eOMTpPIjeu+JFw6a16zZRtaO4Z9eYJu3BMOfYjVFoetNySyIYSPunU94X5a+
 UsruwzKZT8hVNpeC61WX/V1UQjWb6cwgYewmIQPMnZpdFSV4Hg+7hkZbc0y0HHog
 /nAWya5FprPJiKaO+fu0Q/wnD+LnWYe8xaefRVyy6b5+5clRNqKdMofwq6e7RQim
 JgNdjESDhTlmWd5C0lLvmxSxjPAJ9R47vOIaS7D/gDpjkdzbI6O/LQyt2dMF1pLO
 h/ZiVw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxqj9jf9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 09:33:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-395543dc382so1180417a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788946421; x=1789551221;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G3ioQZMKHwe0XM4c4x4bDZIuIz125l7nRfQhXfiQNYQ=;
 b=eU5qV+tEEk/wfvU63t41YOfNBdYVX73ZUd+PguvMuyyB/RVMWrY4faYOoDEg3NHgQn
 RtZ6Ig1gn7garoeySBHhnV7WlcPn1T9xwG/+8NyupBXHow0A+bG88Colj6/0Xibuewp7
 2EPy2LnQ2VRgkk8PGkg5EJg7hldDnIats2RmIg72gw/EA6h83O7q+dgaFE9zNBBcw0Hh
 NRy+hS40NYF/M9AoMvfaBekdK/Kq3HrtE6f0KwwmHLNch6KjM1Zh6Jc0CWkvtGTUnxJ0
 5YeZddbfxXxq1wp+0N1Cv+MTnZMO2LfTtdXZJBj06CHbf159b+vU3zuSmUMQR2ixJdGw
 ir4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788946421; x=1789551221;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G3ioQZMKHwe0XM4c4x4bDZIuIz125l7nRfQhXfiQNYQ=;
 b=LGzjmz2mAWKW0JCTVZUpyxVPByesScQVaWWBOYk10aRXmQsORtaNabaCrGhlWNDWJy
 x7HOt4Y52yx5vAcyls6Jif15j79c0O/Ys8soYIhd29lo8gz3J6FCQsUGq63VpeRhtOCN
 z6CQOKKzxlXy7lqjWIyMk4tpuXgpfs+eLnuLEqpLG1yMhxwmxXiuHIKVztaMXybeQVAp
 qVVYaEgz9q//2+tDOp6v9vxMO7K99eNVZYqSDfMy5RY5xrI75WrllPelyRNY2EWyKFOA
 5gv6c06HcYQUWUeODx7qQCdXe+j9O43h87gnxtRHhonByJtbqDXdihpip8/Cb6qDXhsO
 MliQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiiUZDtmR540kQIkr2ObA9w/Cr1BQgscVn+GqVG+XXV+eCh0azttmRAuY319bkvgW+/6AEn5pZr1w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5qr/L1UywUf4Q/1+OgqW/ve1OLMt7RrMooKbE/Xnkqd5s4Vfn
 HDnWt6zUHenmAf0OLJTKKXaNlpfKKZgLLq/p6+O1xInRhmEXaGp7Dw6512o5JLbdBZvxKn4Eij6
 0TP4OX6YuHzcpZrTZP747M8vRgoNnGP5K4jx8UxFxm/UD1q5ZVH/uEbWt4hZrn/PYeZ3ZfoU=
X-Gm-Gg: AYBFou3KitJpwVy7/UnzdwkhJSoIKMQrFFKFtqdIKW5vSr9K11On8gnb7AWLzgMsVWv
 1fp6UN3FAeNyoaMtRH38YUDQDAGk0ZamyoHw/3V8Jj5g6EBn6itwWzfSW+BMtJg6wnKfqackNSd
 DNSF2rmWwZPLWYtd9K9tg6eGPnMl19bqPJlJJD3yTdfxZKma9J+k35+EwWPf6ZEzzSPvVsOholm
 d2ESkluLerEDHAhEQ/JI9JxyrLJAvG5dmUIZiacGEXWLQZIdff6zbmYmULCtmsf6IUEgTmv+QRr
 VHD9PFIhMX0sQd9WiaEfXQSeCPnEB6MVLXt1kWBykKfV6OxWCFN1Cwg9tXlQyCDprQ6r4Ejpc/L
 D15JZ7WCJbvxtFI5eza5qfOlV5dyd8A==
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id
 98e67ed59e1d1-39b262e28c2mr56016272a91.25.1788946420999; 
 Wed, 09 Sep 2026 02:33:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id
 98e67ed59e1d1-39b262e28c2mr56016151a91.25.1788946420231; 
 Wed, 09 Sep 2026 02:33:40 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm49524306eec.7.2026.09.09.02.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 02:33:39 -0700 (PDT)
Message-ID: <33042b5b-28c9-4df6-9c97-8b389a3f1112@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 15:03:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
References: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
 <aqCKgM1yCbWjFdgO@baldur>
 <09f62d84-18ad-4d7a-ad18-9abccfd5e508@oss.qualcomm.com>
 <c447c7ef-828c-4fda-8e82-6983a3d0eddc@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <c447c7ef-828c-4fda-8e82-6983a3d0eddc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0ZE4l_AU9Y9GsK8ZrcTm4JYKL6eNtxWW
X-Proofpoint-GUID: 0ZE4l_AU9Y9GsK8ZrcTm4JYKL6eNtxWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNiBTYWx0ZWRfX7utdYFTQkMng
 Usz5zNt8cNaz8Sl28rz1Z02J6pEsgA0J0tU0HIhfk7mPSY5Z0ih2WP9GKuoan+ygEWolEUsPfh+
 6BFWqxLJ9LPg3NyocAzP/2uV+tvX00Jt37U62clxLzP8KLhLeEcdIRWF2a5111Sw0mL43dX/+rB
 xOuxuy9X2rFkClOi0EnvxUObYlTFH68Fr2NewxjEw4gckZyU8YTeZkn6N5HDZtKDyENGFENlLUN
 U+LX0WcfLloxRNLWU1Qs+en2z9UzTuWeixKX2CfrsrYQ9m6ZWaWdlLVdVwQ+3Ru+dnHx9jeUN/B
 0qUp+8vPp/RnqK90tWUAcCF/JQ/GVvYlzdmxsc5Ahbcxy1qku/pFmUoZUi+2FP0ygicu0XCCMsD
 WI9uHW91Hehh1khgkC85d/iwdC/I6Ih18nA7uRglkzC6iKHDgRk8NsD4Jo+z1lF6yuF4Y2Bj75A
 1NScmMT7Fdy4yaisQzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNiBTYWx0ZWRfXwuA7cEKqQZss
 EGKDXzaAYIIfBazrFoQB58/iNUh+JVaapUQ5W0bWD/0b1Bqm+z+5XP5HGDQP9vuPRqxj5lZIxhY
 GvoeImEXvaIZzQQcfNvefYXJTGl+sWg=
X-Authority-Analysis: v=2.4 cv=f/p4wuyM c=1 sm=1 tr=0 ts=6aa127f5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=aHQZQ_1TodyndcZw4m4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090106
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

On 09-09-2026 13:32, Srinivas Kandagatla wrote:
> On 9/9/26 8:53 AM, Ekansh Gupta wrote:
>>> This is the actual problem!
>>>
>>> We have existing user space that depends on the ioctl interface exposed
>>> by the current misc driver. You must not break these.
>>>
>>> Hardware cutoff is not a viable solution, because that's just a
>>> declaration that we'll let the old platforms rotten - or alternatively
>>> you commit to maintain two drivers to the very same feature and quality
>>> level.
>>>
>>> So the only reasonable solution is #2; from there it's a valid question
>>> if you reach that point my stepwise migrating the current misc driver
>>> that solution, or if you present a new driver with the fully backwards
>>> compatible interface, alongside the new ABI.
>>>
>>>
>>> But this does bring to a question which the cover letter should explain
>>> - but doesn't: what problem does this patch series actually solve?
>>>
>>> Regards,
>>> Bjorn
>> Agreed. I'll target #2: QDA implementing the existing fastrpc UABI
>> alongside the new one, rather than a driver split by platform.
>>
>> On how to get there: the blocker we hit in v1 was that legacy fastrpc
>> buffer semantics appeared to need a drm_file, and there's no exported
>> way to construct one outside the DRM core. I want to re-examine that
>> constraint rather than treat it as final, since the legacy interface's
>> own buffer model (a dma_buf fd as the buffer identity, no GEM
>> involved) is not inherently tied to drm_file, that's how the existing
>> misc driver implements it today. I don't have a concrete design yet
>> and would rather work through it here than commit to one prematurely.
>> If anyone has thoughts on how the legacy UABI could be served without
>> requiring a drm_file per session or if I can somehow bind drm_file with
>> chardev by exposing some APIs from DRM core, I'd welcome them.
>>
>> On the cover letter: fair point, and I'll fix it. The problem this
>> series solves is that a miscdevice interface requires us to hand-roll
>> what the accel/DRM subsystem already provides as common
>> infrastructure: GEM for buffer lifecycle and reference counting,
>> PRIME for cross-driver import/export, per-file (per-open) context and
>> handle-namespace isolation, and the existing debug and lifecycle
>> tooling the DRM core already ships. Every accelerator driver added to
>> drivers/accel (habanalabs, ivpu, qaic, rocket) has taken this path for
>> the same reason, rather than each maintaining its own equivalent
>> inside drivers/misc. Building QDA directly on this shared
>> infrastructure, instead of extending fastrpc's own ad hoc buffer and
>> session tracking to cover the same ground, avoids that duplication
> Am sure you must have already tried this, but Can you not migrate
> existing fastrpc driver to this shared infrastructure under the hood?
> 
> Can you elaborate on what are the blockers you hit in doing so?
> 
> This will ensure that UAPI is retained and still get benefit of QDA.
> 

QDA's session model is built around drm_file, and fastrpc's chardev has
no drm_file associated with it. I'm still checking whether that
dependency is unavoidable for fastrpc's case, or whether there's a way
to use the underlying buffer-management infrastructure without it.

Please correct me if you are asking/suggesting a different approach?

> --srini
>> going forward.
> 

