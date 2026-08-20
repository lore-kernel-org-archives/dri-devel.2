Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA63C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B9A10E07C;
	Thu, 20 Aug 2026 04:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQgR9plk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DUTqsY6t";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9242010E07C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:12:54 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL7qkh1006390
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /So9S1KEAt5OvNBUFCqjrX+Y7R9w32tufku2nOhCX44=; b=cQgR9plkA7XTyz/x
 f5xmgIfOnuBZAITDNXw+tp/xBCL7i5h3742aucSTz67ITEQ5pVQ4x7GlZpopD2ue
 rY6S3YtJIkGI9E/vThBosMqht2uFYyF837f3tVULItgVkoDUAR4R/YQldZsRAjg3
 fNaOBmcvmBuf6ZuxwMGJ/QzhHI4ZGfz/CFL3VoPXESuTblDWtaU8xQZqY+MwjT7N
 gkKkqZjnUPBQTz4IzGUHtUIou0iJ/Ri9cQnXU4Zfprgw0zQTIeKiQd2Wh7MtWuPy
 jL9pNN24O70HUA93grBVhLfx8C/OrP2WvJllP7HItMIgTiQsRHL70lboMin87WeN
 V8s10A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esc31p2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:12:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so2157116a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 21:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787199173; x=1787803973;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/So9S1KEAt5OvNBUFCqjrX+Y7R9w32tufku2nOhCX44=;
 b=DUTqsY6t8iMUKs53+PjjDO5tGl2DVzH+JmDfda91ikCBJadN6VYi3khFipGRviu3N7
 yjEGS9JqBoPrGUssSLv+y7BbLca2EJn7JGIah/BLwvpYZbCKkEGLpC1IU0YgGYC9XFn+
 n4k9A7BG4AFuPxixKwHO266Yhx/acg+p6JPUJYauHBSprpgS++B4QzAWrChHtbmbjrcE
 3NgBANVS22DlhDvS5JnLGz6Ry8skFEOQcTuUaYTpnTtI5ARw9FLM1VnQ/pdDSLx58VPE
 T3kDiQmD1eqfGp/rKDjBMf6Ujaw5E2MrHxgo17m07QGA3kcxWKZuER7TrnVVtZYGzzA8
 6wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787199173; x=1787803973;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/So9S1KEAt5OvNBUFCqjrX+Y7R9w32tufku2nOhCX44=;
 b=Eo8B8i3TWg+6yBlyx/WBpadknDcB/UnT1SSSjN0KVaoKahG/tk7lhxCsPJHniXlFQ5
 mLWv3H2z6S1yT/ImdNEDJ57x0jT4PdbrjqR8jYnyjfBaNDB8LDMlxzoPPmsSDR1kjeHL
 aYUalRTABWg7IpfsnqSzygWlsKpfhOf5LnyNOy2xKPV4on4HmY2tMn4j56LF3A0CJBOh
 KBehPv+fuUQuMHDzS7pMgwm8KKi0acXoglHEzXd1OhnxIqIrhtDRe2TFcK930iQAeUfp
 nHF2bS9DqTTXFxou1yRIGigLkrGDcEtp/ipVeTmKYHat33968XhbJ+Mjv4ZMAA25gwqL
 4ibQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RonGrl+GLfFX2yo9O0cpPw2xx5nggMwToCv/DJ5/2ITAL7wGeJF40iaDFeurcetMbnDbBWD/BDfXdU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkpPnPLLoUgK8lgs4ZOHftLvsBLzBWQG1IraM5S/l958jhQah2
 cp1oj8cprjTyuqL5JjsT1GMWnB+m1FlMR+34kTwJg/p0TrhCxwkkuRCYoxQInwvUuG2m7MqlirT
 lEA6dMV8JWrIGmaj2c9Ae7ZMQ/tgeAhtJvzxcw2fKsWmfB96EtN0n1XbdAH14CRGOZTH0s4g=
X-Gm-Gg: AR+sD12GCSi0F+Ym/blcZV/IB92oqVnQ60SNNBkvrRLblisqU1DWOjWsYPcxrOOjjmp
 G4JRtu2pxMkC6O4FvP/OdjmmyHRxdEIuOFkdW5Vu/g9eCcBTklibzSPSAJ5KuG6Sv7DHURuQWbJ
 p5I7AsJ0Zaq48ob3IePVDbE8o1JjS8dwoqKrDVNahidtAtIuMfS3RfQiKjs64mWhzu5LUU3Lq4V
 rN5QsHeWDcP8yWG7+QNR2PYxwJ0M+q/MMdMEnMbwqtNi93JxIWSqLEm5qqyuDmAWdvh1Sx1bOYU
 gPXXljXHkoiw4Rmk4TEleIWXRN+5uN37Mn7AJfMCExXamrfe0o88AVpnbp9TY/z3yrzjFDtyIjS
 ETM+Qxc10J5OvmezCs3pAzSqYjfUVyA==
X-Received: by 2002:a17:90b:5385:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-395812a872dmr18290507a91.5.1787199172832; 
 Wed, 19 Aug 2026 21:12:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5385:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-395812a872dmr18290423a91.5.1787199172352; 
 Wed, 19 Aug 2026 21:12:52 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf15ff5dsm11842356eec.25.2026.08.19.21.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 21:12:51 -0700 (PDT)
Message-ID: <4f11dfb3-9d92-450f-97e7-f04404c63250@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:42:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] MAINTAINERS: Add entry for Qualcomm DSP
 Accelerator (QDA) driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-1-69a02e9090d4@oss.qualcomm.com>
 <cc43a545-20a1-4f15-a7b9-ca48842bffca@kernel.org>
 <e0a25f11-5c7c-406f-a223-da29bf6e1401@oss.qualcomm.com>
 <f725955b-27aa-4b20-8a4b-84906782b921@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <f725955b-27aa-4b20-8a4b-84906782b921@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zoOregGnr_nXE70OucH4lyAYXMsYQ-IG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAyNyBTYWx0ZWRfX9YGvvxnXwDc3
 FAVTvgM6O98AymStBEYgrbydgtv8S+wSyTkICp1MrQNsGn4Uf2CxvkNXPlqvgAAzS8YVZjz1aIZ
 hD35fqNTJ/qfKbBSdbr24yVTzUXmCok=
X-Proofpoint-ORIG-GUID: zoOregGnr_nXE70OucH4lyAYXMsYQ-IG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAyNyBTYWx0ZWRfX36jeX8D0/0hI
 D8gT27g5j8MmFxCvmeco7DchJSv3wkBg7wEOXd43WHY4O/oljbJpUJDwpYMxfktgbO0Wt7vst3s
 ldMMCsMsIP29wQzaWPEUTXXH4HRfOUqHNLMfzf9eeWeGWXwrRVTlI6eBwJLyfSmrEksRw1yP+TM
 GkB5KO8EjmoqRF1Yx8cuL0xUTifnZ9KTVCk1g0k4felJi/qZDXobAmxowqf0z1CIK8i9qOjobmh
 hxQG26fYZ2Q3q28JXGdul/0q4AehSD1Gj6BpqxI+hj8snMsIG+nFrNbndRBTzaZaLW41Oxy9VDy
 yW2yOpCduNKtpE2qIKXEdpm6c3V4C6qbV//aQDuMQpDzHmi2U+pws69dpCp+eP1gEZ44UgrNIIZ
 ia6uiy4sYKERxZ4RA4b7KMhXqTWLC0XCd7Y8S3NJQOD+Z1BuIaiisnNzwQTxDzcZnHuuaqc00ET
 5N6aC1jyG+YjRkQIDcQ==
X-Authority-Analysis: v=2.4 cv=b6uCJNGx c=1 sm=1 tr=0 ts=6a867ec5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=4Unm9NrEEcootba8-QIA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200027
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

On 19-08-2026 19:46, Krzysztof Kozlowski wrote:
> On 19/08/2026 15:05, Ekansh Gupta wrote:
>> On 19-08-2026 00:52, Krzysztof Kozlowski wrote:
>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
>>>> Add a MAINTAINERS entry for the Qualcomm DSP Accelerator (QDA) driver,
>>>> covering the driver source under drivers/accel/qda, documentation under
>>>> Documentation/accel/qda, and the UAPI header
>>>> include/uapi/drm/qda_accel.h. The linux-arm-msm and dri-devel mailing
>>>> lists are listed as the relevant review lists.
>>>>
>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>> ---
>>>>  MAINTAINERS | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 912837dd4640..75fa90c137c7 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -22388,6 +22388,17 @@ S:	Supported
>>>>  F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>>>>  F:	drivers/crypto/qce/
>>>>  
>>>> +QUALCOMM DSP ACCELERATOR (QDA) DRIVER
>>>> +M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>> +L:	linux-arm-msm@vger.kernel.org
>>>> +L:	dri-devel@lists.freedesktop.org
>>>> +S:	Supported
>>>> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>>> +F:	Documentation/accel/qda/
>>>
>>> There is no such directory.
>> the directory got added in a later patch, added this patch at the start
>> following the comment here[1].
>>
> 
> This comment did not tell you to make it non-bisectable. This comment
> asked you to add that parts in your first patch. Why did you move
> patches instead of adding this into the first one?
ah I misunderstood the comment, my bad. I'll fix this in next spin.>
> Best regards,
> Krzysztof

