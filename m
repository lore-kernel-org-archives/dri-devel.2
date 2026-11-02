Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CED60A2607
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fdAlc8IC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T263wQct
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C0E10E403;
	Mon,  2 Nov 2026 10:52:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E403E10E403
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:52:25 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29A77e214017
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 10:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xppyrRxkA2Uo3mrTIkoi7ocXriSCH5ZyUXb5WmyTlKU=; b=fdAlc8ICM5cJKU24
 MEyeQiZ+Ko0T6Euviv1nufX/eAZJCEpNNXX6/iPFBHQp2YeaBdyo0wDL9nxcdqEb
 KiAPVbKSxlXjOTIYMqA7M8ipYH6KsN+mAFINrBJ5DnUJYM3fJNgBd1iIaY1AsIvh
 w8X3mSVK0wI93WCwx2SSIBV5TyFioLSzce6Mm630ql6KoplC0ugiZSHPOVe0LL/e
 gFuEss3KDTEMziSmQELQ8ngrTDPlpjGz38N8FDCCSgepsjdGmqlUGP62KW2DxKVh
 5KJLw2DbOwc8P5JU4iqpKCfkhIB67ttFbvE/XQr2ijYTF3KINVmn/ogcIarmmFpg
 aLcq4g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1s7pb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 10:52:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ae72da2f57so3998095a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793616744; x=1794221544;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xppyrRxkA2Uo3mrTIkoi7ocXriSCH5ZyUXb5WmyTlKU=;
 b=T263wQcth/44zmNm+Glyf8ASYBor1/7v5RNYj3LrgTbmUlXhyhvmcZMTUW2/bs9DrR
 SfyehN9jRCEbAL0PGZw1Ge4EF08DBmmDjI3BQ5HPfE8YftD/KYt65BlPRZKgJhq5OyeL
 UkV+LkbRZ4ja1R24td47s7rHObHP9J3gw1OzvNYnMRE5pl3hUIQG3pzfFf1dUvvYK3cL
 xN4x7zax+E3GxsTOgOtAFYa8ZjzNI9jVNtnea99guDp/DvR/Y2QFNB+hvW3IFRXwvUlj
 h+gjlv0QxHhIK1Ry9/iDl6llfQ0s6dBfj4U2dImLcSZuNrSk9C+P++qEXNbxak7X3o2t
 SVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616744; x=1794221544;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xppyrRxkA2Uo3mrTIkoi7ocXriSCH5ZyUXb5WmyTlKU=;
 b=Wn5NAbOfSEauIa2Ti3Sx9xiKH5Iq0au6mYKL+PEe9i+W6uMeRbSQGrGS9vagMWccvH
 tBEgO0YxS6JYQn6ww8na7iGBta5tMRXeg16M3BpLJWp2MsRIlBrHd75YYVkTKWec6EKZ
 1F41Djj2E2ToySO5Amc12r0lz2XAtTgK+mOlP3N1NrHRW3wSuZnELF1W/pOwKBsgdbz2
 XJIFTu+FoqLshV1s2A1AV9YDsSoGPw2MlvRFK4tI2xd+l0g0kI8q+xcsKxJIJcm7UROf
 tJSTM4uGci00cwRgcfMRTurJtqryuFJOl9VGRKJSu6qGFXL5UGkNScwsW7r50lDIai1J
 5l+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwio5CTLkm4jxeKG+ZB7xzY+C+3p4sOIk6PwDuNcmt0A/fbgJ25rP4OP19Dhxrn9SlfR5dZPGRSbUo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+rjGrpimfqTl3BfqKGAKUqUHNwDUva+egMDz+xmE2hMr+JTyUj
 nI9x8ZKimbdxK7ILNhurXI/G++T6ZTXk6zPwsSYz2t459DGJT+sKxIW7HwWm/ZprNUV2vUOwc1n
 T4sLeiCQJvZTe2R2QgBeT+NBlqAXxgkE1SKITksQwGTer06hgyXTA8Wk6F/NQqqIL7TVCcWY=
X-Gm-Gg: AYBFou2J79t/WCM6DGC/SPmst2zCwoxk0G71hPv8qk2eLmQPAzYzmqlmGM8vjGznToF
 s6SmjnoeUhWD/abMyioo4XDXcL3Y9rY4MFzxddjwnlM+PteOBHzVONrfQMMhn6L6VDjkfyDz975
 Qp/qR98WIDAldj+S5gksXSFlgO+vnYj3VSclDdJDRa7oHI415kafZQPf4E5Oxbb+KrLcNRtoTed
 /T8wkv90Z7ZJ3nvJOeHb10l1b2FWhNw4UOQfZ7D3ndAeEUrVHPvXo8e9cL3mEjrTMPFBoc6HNjh
 nEskE8PWIAVYouZaGdleD6zCD+6cbJ39RcqsIJcCUrUMhn4CdAmP0LKhF+5to2byp5jtMhbhryy
 IvNSz4YKXwco+aiIVHoNqD4FFqe9lppUqZhxSS+BNEdE8ID9vUEC0kAGbIjxdnMfEiQ781Q4QmT
 VguA==
X-Received: by 2002:a17:90b:5623:b0:3aa:6b5d:a018 with SMTP id
 98e67ed59e1d1-3ae89866277mr8172364a91.67.1793616743899; 
 Mon, 02 Nov 2026 02:52:23 -0800 (PST)
X-Received: by 2002:a17:90b:5623:b0:3aa:6b5d:a018 with SMTP id
 98e67ed59e1d1-3ae89866277mr8172345a91.67.1793616743488; 
 Mon, 02 Nov 2026 02:52:23 -0800 (PST)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3aebc8942e0sm4951335a91.7.2026.11.02.02.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 02:52:22 -0800 (PST)
Message-ID: <c8375e63-e358-469f-9e9e-8a174137f914@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 16:22:11 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] accel/qda: Qualcomm DSP Accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Srinivas Kandagatla
 <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, rob.clark@oss.qualcomm.com, jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <a97fb0b0-e4e1-4b25-a5ac-60777941c574@kernel.org>
 <26ca5c66-a2ff-4aaf-9c9d-724ac66480eb@oss.qualcomm.com>
 <da2b5192-a081-4469-92f4-2ecfcf502e4a@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <da2b5192-a081-4469-92f4-2ecfcf502e4a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: r3PNYo6iUgSsF5gGzWuv1ARCpl8ZouvE
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae86b69 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=oPeKDEZYKiJIZNr3YAsA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MyBTYWx0ZWRfX+ZLBqf8ZG+vL
 TmLuhuuLlddZ/ZaBvEHVKJ2BkF99xDchM9LE+hnxbzXsmTJDYahL1beU94l8x6Lc8WNqYLYCcR4
 EwBVJsg5Gbykf9gNRp6DN3IX7mtkw+KkPgpuFTVuMlrtwnwKLXHtWIOtiD6OACkjZ/7EcuprKRQ
 iyUAeXaYf92GZD1Wfmvp8WZEZnpEtz59igOmWxmguhbodWQ64dDJuEaRi1Gj7ZRcQm9lqVgMCDC
 La11pgYSYtd5BY2DIXzp8TACrLJ5jW/kVBttbcQ0NChTIBBIJb0z4iEcD6i02JBH6bb440eE1C4
 j+qs38d94dJFXaP+CC3CC/fcAC7P7PjGLXaqwYcnb3z/U68hgN/5GqAIYjhUZWa+k4StsJ3oOwp
 i4QGCjZ3qzhdy8LLOADEnGacs67oRvqf4BYn3gkf84xzpKV3T4Wo9/EOHJWjRNUkmlPcauVbOuu
 4OuIRJg9oz/Ld38hvug==
X-Proofpoint-GUID: r3PNYo6iUgSsF5gGzWuv1ARCpl8ZouvE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MyBTYWx0ZWRfXz1uaAnnWKwWA
 0PbDuIqxXjlSV9DRaLsXtPyh9PxbeWsMtDtW2fIGJjZx+noXR+5NEr86kfb3Cc+0pKV5sSTQTBP
 kqzI/H5oNhTd8A53EN7Ez0okjAIyvks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020043
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02-11-2026 15:42, Krzysztof Kozlowski wrote:
> On 02/11/2026 11:08, Ekansh Gupta wrote:
>> On 02-11-2026 14:23, Krzysztof Kozlowski wrote:
>>> On 01/11/2026 23:21, Ekansh Gupta wrote:
>>>>  drivers/accel/qda/qda_soc.c            |   66 ++
>>>>  drivers/accel/qda/qda_soc.h            |   61 ++
>>>>  drivers/misc/Kconfig                   |    1 +
>>>>  include/uapi/drm/qda_accel.h           |  282 +++++++
>>>>  33 files changed, 5877 insertions(+), 1 deletion(-)
>>>> ---
>>>> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
>>>> change-id: 20261102-v4-e8feb321263f
>>>
>>> What is happening here? How are we supposed to work with this?
>>>
>>> v1: 20260223-qda-firstpost-4ab05249e2cc
>>> v2: 20260519-qda-series-78c2bf0ed78b
>>> v2 again: 20260817-qda-v2-78e2d1f10529
>>>
>>> And now completely different one?
>>>
>>> This makes the change id completely unusable. b4 diff obviously does not
>>> work. Any tracking of this does not work.
>>>
>>> NAK, really, I already complained internally months ago about such
>>> practice, so apparently not enough.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Sorry about this. I lost the original b4 branch and re-enrolled the
> 
> You lost original branch four times. It's not a coincidence, it's not
> random data loss because then after first loss you would solve the
> problem. It's a broken workflow.
> 
> 
> Best regards,
> Krzysztof

You are right, and I'm not going to call it data loss again. I started
each posting from a new tree and re-enrolled the series every time,
which is what produced a new change-id for every revision. I've changed
how I work so this cannot happen again:
- one long-lived tree and one b4 branch for this series, used for all
future revisions;
- before every b4 send, a check that the change-id is still
20260817-qda-v2-78e2d1f10529.

v5 will continue from that change-id, with the v3 and v4 postings
recorded in its history.
