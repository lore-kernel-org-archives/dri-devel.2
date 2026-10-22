Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC2606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B4AbYG7l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R7aD1N4Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1448510E35B;
	Thu, 22 Oct 2026 09:27:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB2D10E35B
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:27:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M70FSo2516174
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IyT7fwjUNFNu0NAAjlLz6JQgqyL2WtB5iiNKLluFvCs=; b=B4AbYG7lnrJgKWKL
 CUUYVPrPmNE4FBjdYSgr9aq+iBuZDvy0sDenENjOSKXWEHNqUOTtzs/L5Kn8y8O2
 WDkiTOtDdWKHHJD1s7FW6G06M9uKLGfYIrRk1nq+FlDKuyYbPhHz3Zkeg0gy0wRI
 0Um5szZwsNEGdxQuxJL+y4uCzkL7NC7NnyJ9TmOOPvXDwUK2ptMsWa/fa7D5Q5KN
 XYjiGFhjpemCyYc7Nzg9OVI5lWPHOmjzqcIAUqgisYdithFBlUZlc3MyrZKPV8D/
 LZTQjjpvqxQvCO6pYOHfZC5JNdYQ93scOC00E2rnDwa2EwF8Fnh8zBJ761i6c2PN
 AcaE6g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a9pw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:27:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd634ac49baso333392a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792661264; x=1793266064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IyT7fwjUNFNu0NAAjlLz6JQgqyL2WtB5iiNKLluFvCs=;
 b=R7aD1N4QoiD4DUD09dwTpBjpXfak9NIbLGjGmvNC3DS9oTlf3saANeKo0RbvXR4Eng
 /3nal8DTczPleq4/Uabyv7MUPCSnfQJ8qbN5/tBSR+xIB10RnzggwmBwtxDFD7TRcQ8Y
 xo0E0YkEkWJGx4PlAPT2fNbeH/eBXn6yYgXTSpOeGr9jDpWwfeeWM85dxCXJQyJMoPhI
 IXC+4ktl0at9PqDWWyu2EDvVt1EfW/jyPdaovoDCSSiY+l9CsMBmqx6yKdgBNAbJVd1R
 DzOAkPL3l8aKUEUOhzUt3IJZXaO5NG0miJW9GrpXrcJ9MdQANv+a1+X8WgsIKVIi5CbC
 1t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661265; x=1793266065;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IyT7fwjUNFNu0NAAjlLz6JQgqyL2WtB5iiNKLluFvCs=;
 b=2fqEdOJc7TOG65t7iSHtMcJe6yDzWQKSQlvJzBFo0PyS3LCired0yu7YWapKDW7UX+
 inFqb9R0hTWFKqO2kXPEeGX9bAwiCJtb68kVzBH83E1a/XYyPEoAYOaOBvoR9lbGgqSP
 0782wCvZin//dq8ADKa8oxgW3LPmNaWg0WX/iRLX7CKfiolUcOmfESNMpoFSHdnPLbX5
 qCoMfK8vMi/Tyu6uGnl3FzAt4NM0OoreYaKpqv+d7S1+KiN8+Oi2kcDdraUIKO8vZ1sa
 ze1ZmaJte504ITjdkY2f7kg1STukQ/5xMr3m/EQS1q0g91Uxb7IKVAZzO1pMRR2Bv4Mo
 R/0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3jzBGkO7AeM85qd8Rx54NF3pwms12WSMoqSz53WCm5lpooQGqXf4noXegd2rd4U+U20UowCH42nw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJBjWRXI6iuHjR3BOgTcGZe6psdYVntOel0aR7YW4k5wPYdPtMK
 Zm1Ix6lzdYdRI1lMygAMeqTNecnLZAd4JuKhj46L46dzYnzSyz5HDwfLTsQMmEq9GoSl+r1rZgR
 jHqD9ckEnUFpyIAzw02oifWZSrx4XEc/+lExOXLbqmCy6P0IH3DyRYHdZFZWvgdszgt1O/zM=
X-Gm-Gg: AYBFou1auQDaW7rz31P0BoC3qHlyb7jFdVvdLTrKYcD2wiQM9q0+YhjUbgAB19Cg8ZY
 KerkOwY0+N+rfKZn1AbQqrJlLXZizd0eiSjpTNa38Z9dL56ldLurOuerW/3nde3vvpbWuyCIt7c
 G5TI8nv3v6sdb87ULoDDNWG9lMk01vd4CvMVuBUgNqi/xLSzSz5YtLZftsPTaRZKg4BjE6U1g0x
 6A9z3k7c2stpVd0BvHl09xtgQGcz8o96kmTBlO8cFL4TCx2i2y8C/FFfJOqoFhJK69LYw5555lO
 6YuP7xKb75S8bJOi7dtpTsFlFTPysTpNRyN8B8NNNO8d1fgprVIVBFGVUXjIWL6EJCFRF7w1WFX
 0FrMuzQLkiBChFQnMDMAcHfrlhDxtIZjx5Q==
X-Received: by 2002:a05:6a21:7317:b0:3e2:3de2:5947 with SMTP id
 adf61e73a8af0-3e2a09dde1fmr1349110637.16.1792661264462; 
 Thu, 22 Oct 2026 02:27:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:7317:b0:3e2:3de2:5947 with SMTP id
 adf61e73a8af0-3e2a09dde1fmr1349092637.16.1792661263974; 
 Thu, 22 Oct 2026 02:27:43 -0700 (PDT)
Received: from [10.219.56.252] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6b84831d3sm976688a12.10.2026.10.22.02.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 02:27:43 -0700 (PDT)
Message-ID: <28a4a452-340c-4ac6-afba-5cd39b370ceb@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:57:38 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: Remove FastRPC compute CB9 entries
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20261016052042.3755352-1-abhinav.parihar@oss.qualcomm.com>
 <b0763841-cfe9-4355-b900-ae43d93dedf6@oss.qualcomm.com>
Content-Language: en-US
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
In-Reply-To: <b0763841-cfe9-4355-b900-ae43d93dedf6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JudkP84C c=1 sm=1 tr=0 ts=6ad9d711 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OuD0wRZ8gfjUqNd7lbQA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: w4aa5nh0UU6sDWrbiI8kY-u5ESpYieS_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX5CjlG0ct8BTa
 c9pMshOXiFz4NYM4AQSrenoTuoMfmn7UoZ2+y3mMpcLeB0HumxJat61V3Hy5H4GcYEGNqz3CyzS
 +/Kdzl3rcOJ6jwhLszpmmEfqUWv0T/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX2a12LREyPccm
 hpq08+jt0TowoRublTHYjypEBliMdrayoOdcreOKbN11+1GsXBwMGeFCwjaw91p8ACwxFFqzKKP
 kaIi+971qSrUaaTvDI9mWfNcEM5zpB5o5mbq/IkI6OdX4SUBIDXlGJx/IMOyAByEZLfYQAwVF1i
 harZ1nc4iiNFvoVwilQw3gDw7lO9mCBxaj/9QQPYFikM5Q9iXoOJd6cnrjk3Bh5AioOR+Btx/8B
 vdDaqoOfQ83D1KnzP1qOtCfOGfb8T3vJV6FEFhD5+UVp9Ug3W2vtiIbDoQhkfOPmYpzCTY6GbMp
 qKhIeHJgYnkNQKOctp82UKfy9GX4AQLyRdxdPF2cC4Sy8zcqvmQS7lszOdBQMi4kRBIzrzEx7IE
 aj7p6/fadz6dmF6sZNWKjnJqnbRHh1ZLRpMOLeuB9BCcet4h/6B3Bxgt+xKE6hgz4kMzAGXzEhO
 IgaDJGARh4V22nK/q5w==
X-Proofpoint-GUID: w4aa5nh0UU6sDWrbiI8kY-u5ESpYieS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220037
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


On 10/16/2026 2:15 PM, Konrad Dybcio wrote:
> On 10/16/26 7:20 AM, Abhinav Parihar wrote:
>> Context bank 9 is reserved for secure use cases and must not be exposed
>> as a FastRPC compute context bank for non-secure offloading.
> The lack of a platform name in the commit message and a split over that
> suggests this is a universal truth for all Qualcomm platforms, yet the
> patch only limits this to some of those who currently define a cb@9.
>
> Please make it more clear which one is intended.
Ack, patch v2 will have patch series including removal from all 
platforms having cb@9
>> Remove the compute-cb@9 nodes from the Lemans and Monaco device trees to
>> prevent clients from selecting a secure context bank for normal FastRPC
>> workloads.
>>
>> Secure use case support is not currently implemented upstream.
> Ordering this sentence before the previous paragraph would make the
> commit message read more naturally
>
> Konrad
Ack
