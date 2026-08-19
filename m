Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47ACC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEFA510E5F1;
	Wed, 19 Aug 2026 13:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2LMLWRM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d5g5eK5s";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A561310E5DA
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:05:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JD0QJr4114556
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LZ5DADcP5lyK3Hc2KgnGBzVe5cJ/nTw1zxLeW7QKY5o=; b=K2LMLWRMhSf9IfQR
 DpB6P5ILQueozCgCu5JXWzSpQPKmbFV9bRj4KnArcWAgE1E5S/gbqv0Vgd98elSy
 2Z7Qd9YrW2KiLmg3GAEsloT8Tny6ZBWrgy6GQZLMYy1EMqRXDc2c4syj+gfFTzQ1
 gjIbgeLR8+sYoUBMBOO/vUs+IBWDVDvT8m77dmmY6dwtHAdVK/5/N6mfB3Wd8rKS
 hkFKjswlekvfHUg/caahLolHW+47x2nNWMU9d3JilgNrSzCYD6KFkCTh69Hyi2bn
 7hlk3jq+7XnFCejQyDo8khR9H/FVbuJIXfSbKO2tEO8qqugq4AIrZYvPWbYY+VLJ
 jC5YWg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmba46-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:05:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso8955075ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787144733; x=1787749533;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LZ5DADcP5lyK3Hc2KgnGBzVe5cJ/nTw1zxLeW7QKY5o=;
 b=d5g5eK5sYS+W5GY9z8KGHwkW8j/1TvU9Ybg+04upYXc49XAmfsx5KdxOXW7MNFrBpK
 Z7J5DSwz1D2XizCE588Ow+qOXrZFSTAbYqXHN/9JukmZ3LZj1JM9CBiLdcWdyrZ/+lYM
 qCTO5pjuTIJ1VfYxmM8v9w33zQ/v/ZgZyVAyOCdDxqQ7suTlJCzV7c/Tx37ZduYj2qHH
 s8vV/2wWZ6+MkRhVnwx1ohwggU+3ls+KJD794tHhdRa6x28+IdbdhZdBjYn30sZHHalx
 FM9d8I5nA9FHNZvg+YjhUkbT727qKPEJZzWbfBOSHa8l3j9j+c0r6oalY1P0sKmSpI0+
 mnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144733; x=1787749533;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LZ5DADcP5lyK3Hc2KgnGBzVe5cJ/nTw1zxLeW7QKY5o=;
 b=O3/TU6T2h7o7z87doXCpVl3+Rc2SsIOZYjUQL209RyScRB6bjMCTUSnHXMvbpkVda6
 buUodq5/TaRt4FxMGMj/UI4G6THOk6Nz7PAAeDdEx/mHUQAMtZaBx2oPpmt9evg6GopK
 SG8YLf2xkybONyPjWAZA+o66ChhK5Q2qafSYS0oSqNid6OeEO/ZQOrD7AXcP9SmFA/Cy
 RAA1Jwum55YT1LEb0i8Wrt2ffM7LxMd7wqgfouSKWI2linqzQYeZSguIcY+dj6yDaqK6
 3cIuwbSpETrgBpoBbAbaJ4SvQuPV71E5pKKfLjhWQ7ez8lmBeu3z3TPNLJWrqVJm/MXd
 ONRg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqho5xTMzEHkgyDQCCPX486iEOpJ7q6gHF83S8JfFNrKJShxVCsK4hzfkLgGEPdf2keyKrMb/goUjs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kAjlR7hDAnOLIYb84N2ybrvs6N6sBC9sKFVs7iX8FIhmndeKsC
 M1uC8KCwlU3KcZdHKAkKyGVCV2ma3zqG3JK6i/550ZOAjAGfNGCJQpOG1u69vUEibtWBalO8fns
 dVNtqFVZFFBZkapXGYfnWV5fM+NX+FdY0NKRGtj4VimZh1ZyZsTA8APlmQ83nEHIVhHOKdXs=
X-Gm-Gg: AR+sD12YpE0SJkCiZLACx6TDIpx0GRIHLJ5oov+QI3f1MH865An6uNuK+HbP39aFWC6
 RrIybsQrQdgRsF0WHFgNhMWeYZZkXqeZEqgv7Ln3AZeLVC5QpoJQkYcOWhP+HWDdWjwRXfIJtLA
 L0fg1fNwzWUu8vEwJ8AwQXOxNyCw+ltTQji3fH2ir2fzLrzDy9mErUOm0SC95y+qinbvkWWMg0F
 NjX1VLn8tohFePRIwgmuNtWb8HN2k6+ixMYEjiKmyWZVqdVDrRtKsTAkgJEbMwgBKxXfrZS2tmX
 Dd3236cZKX3VqOAUHNRu8letQFoj4mVaiHvnN2CRxpWW4x8wHu7/JuNsC3MWig9LRcWTjxWAiFw
 Xi1iwdTVRfNx6n9Y+4zCW9QpxHsio3Q==
X-Received: by 2002:a17:902:fda6:b0:2cf:a108:7605 with SMTP id
 d9443c01a7336-2d60186263bmr89344995ad.11.1787144733049; 
 Wed, 19 Aug 2026 06:05:33 -0700 (PDT)
X-Received: by 2002:a17:902:fda6:b0:2cf:a108:7605 with SMTP id
 d9443c01a7336-2d60186263bmr89343405ad.11.1787144732529; 
 Wed, 19 Aug 2026 06:05:32 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1e54330sm24796285ad.44.2026.08.19.06.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 06:05:31 -0700 (PDT)
Message-ID: <e0a25f11-5c7c-406f-a223-da29bf6e1401@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 18:35:22 +0530
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
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <cc43a545-20a1-4f15-a7b9-ca48842bffca@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfXwKJ1YCX8AFWq
 auoXIileT8O35+8mnxlApFOuYZj+v7A00+gosLlW5+LbhsWs5U88w/CWsl1APTP6z/4B65E15ua
 VsGumgQKZSetz3THQGqlzgL998gOdmjEZxwrwTLBrwPvivXm8zeWYnPf/dgbGndlM3Cbq+OyMLo
 stlId89OAg/78uvhGYyLVNJIo1QHgYlz+qKOVULP+3O65ryCqiCg9f/ysmvaQ5fVsrrgk+yCtGc
 aN+1I7j+ZK0js23Im6sA17pKg6N3hBm39qqc0VNCY+ncbCqsxr8ihzkWArM0Up1UdX/naXjtpyS
 DA4o6XNyL1OCSf9fY2mSQfLB+yzPvZmRAtSYCiXEBzStdJV68Z9MzMhM8NqO/w4E3wecbODOcxj
 bFn1XnzPlo17jxH8zoLuD08G7YlrANyYnHsWBri4zwFF+b/AZ2AfofyrLlDAOTltsaxLfUqUY8f
 DQGHQRqQ6O7VI1Y9WNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfXwBM6qNY0Fwxp
 LEWJZ/1q2CBlXtayXohBerkxc+wa/SJgNYx/rM4Om9v5tpWwsxBDT13FZFbvlfCmRQMR1dar5ZW
 tNYOrzyINX2Uh8BZXhkcQ8XjvkNm/Dg=
X-Proofpoint-GUID: _wYdCdBifCHlVpXWN7IJ_WpUKwkQB0AB
X-Proofpoint-ORIG-GUID: _wYdCdBifCHlVpXWN7IJ_WpUKwkQB0AB
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a85aa1d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XbA7GbUpZyLIT2ThUnsA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190100
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

On 19-08-2026 00:52, Krzysztof Kozlowski wrote:
> On 17/08/2026 06:47, Ekansh Gupta wrote:
>> Add a MAINTAINERS entry for the Qualcomm DSP Accelerator (QDA) driver,
>> covering the driver source under drivers/accel/qda, documentation under
>> Documentation/accel/qda, and the UAPI header
>> include/uapi/drm/qda_accel.h. The linux-arm-msm and dri-devel mailing
>> lists are listed as the relevant review lists.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  MAINTAINERS | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 912837dd4640..75fa90c137c7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22388,6 +22388,17 @@ S:	Supported
>>  F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>>  F:	drivers/crypto/qce/
>>  
>> +QUALCOMM DSP ACCELERATOR (QDA) DRIVER
>> +M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> +L:	linux-arm-msm@vger.kernel.org
>> +L:	dri-devel@lists.freedesktop.org
>> +S:	Supported
>> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> +F:	Documentation/accel/qda/
> 
> There is no such directory.
the directory got added in a later patch, added this patch at the start
following the comment here[1].

[1]
https://lore.kernel.org/all/zideovhb7djvsbydqmdyxbgh6cte7xc5ouhm6gsreww6klqqae@o6w6wd4tic4r/>

> Best regards,
> Krzysztof

