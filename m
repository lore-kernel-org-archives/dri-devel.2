Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F87DCA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5E8112050;
	Fri,  9 Oct 2026 10:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGQkYIQQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jb6cW57v";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A6E112047
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:28:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KFca642352
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 10:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z8x0WcE/7xm7pXjVo4mK5xEsBQsqge6KlTXf75BL4CU=; b=OGQkYIQQ4RvfM+Ap
 IJlSx7rqsMpEPPnw5aSWZpJ5i8aY72mZpAN3V60qPKBdauN2p+oLnmUAFl7gzeaZ
 s5ppFAIMmqzBGtRLXUqWU3f4f6/ZdA8DZQxvwvNXPCmMAuZsWqy4T/QExt80chBI
 LYNQS05udZAEds7J+bAe/XtGPHB0LD5qbc+LNgdeWAepI5m3QsUfyqINmT/clUYQ
 UjZ2yzj56ZOjh5tNMiAU0lvvHw3qsNbOUPWGGeRtBzSYHZEG+NeAcwk/GU3a2nok
 2xC4E5pB5chtds/3RjP1ItTF6IaDzO/KUvNfNAyx89GOK3+eN8HT7n3eKyCDl0VA
 Z4Z2HQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxru4he-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 10:28:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso7592381eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791541715; x=1792146515;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z8x0WcE/7xm7pXjVo4mK5xEsBQsqge6KlTXf75BL4CU=;
 b=Jb6cW57vYEOXY7FRLYusFOTBqB1KmC3e44Y2NYOZ5L8/refaDwx5r5cQ/BGcBYSZgO
 T+bEBNAjQhb//jliJNR/qJ6H9fLAsGhhYIrD8j04d7Vy8iMi6DZVcPn0OTKDXnVYa2sp
 1nB9+VGBnRo6jQEt+PCtX1Jza+qXKwDx/keSx5fUNhVoQeoIPxB8QtrwR0mYfIDagOBH
 q4cuAcbTfyw56BBi/YNE5mpCX6cCPHQhz9FV/Z+f0z8RKNUbgqAoGy6jS5evh2Q9KTK5
 3rbRJ1kSYnH/z0XNxr90k2+uDZe0zoluabjFyIm2q5qvzO9qNaILPI1CDX/asZzajvsw
 Q/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791541715; x=1792146515;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z8x0WcE/7xm7pXjVo4mK5xEsBQsqge6KlTXf75BL4CU=;
 b=v08nlnMxb7czzKs8a8jerN3cs2OBW8oJq7VLWVDjqHqfdlJo0GPaN4xV53XkqCe5NY
 O8I0Xn/hZUV6WFjoaMXWhICR+L6sFLZeZ6U1cEcQoBnsJTZiamrSZLoi3XMuE3H1StHc
 r6i8lTX5CJVpeY4DL9qYel1FCsAKAw7HYTdk7h7Yy58uyxsFW6qcmLle8BAc0zjdSc7i
 fI5IWaHuvKIaMX6ulvOL+tqAzzF3V6h6evOmV5/HJ1ry1De0NRgFLuZF38HQvmg+qis6
 ahqAp4CI/MAjsYw3Vqq70uAiKz0u/BKdGq4JS/ttqguoV3jcX+bSuzonsFFVrPTFEUCP
 Ko8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUS5kCZyWjR1QW3IcltxyMeZmT81alrtnlRIpKSXKzej3L+nsV2XMlbxHAhlwgT0xDZA+UEzHYQ3M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mnwqq/wrPWr07Uqdlcd1B+0YDzCjLXRvzBltcmoyx0XWd4s7k7
 XwRtwgVPcy2KK32mo+/3wGhCsBwOSFK3DhWoAQ2mlO5T0JX2dUvJPMBmn4NUAvrdDViWg2RSDH2
 qlUnKjK+ImX5dicIOt6TygV2N9H9SfzvZO0gnfBZDwD5lGoyoD8QKc6a0jkiZliWvqoQlN6k=
X-Gm-Gg: AYBFou25KpLay3y7vvrx/5bMugmRCNNvivb1dnRSwCB3nek/g/CwZ8aFIAnV4x9cnD2
 mDGJ/QeroH/H/xBfURnPEXdDlqS2dmdcbkVX+GKzy1JTt7iILpJodMdHxJo/ZB8XEZd+wIIYsTr
 VZ9h4JH5KxznTrYbaw3PTofZjJXZX/XyDUurznsp5FsJzEIpxs8NzrzRvgHnHz00h2HGj1ISyGx
 ps0wSXDBhltaN+vCLCtiKcQIYplB6/95Szh0vwqQygPF7FrJSclhXBRKyA9rEvhjyq+p4BWVCl7
 JT1X0zY8y1shuVmMoxZ8m8JksGc8t7jtuPp7N0sbqenT8UXsNZ8VThkwqjaTgOyBwqy7J64izUF
 MHsDOTSd2q5dfxLR1VgH87xdhlhZKV0Gj7g==
X-Received: by 2002:a05:701b:230c:b0:151:7f08:5961 with SMTP id
 a92af1059eb24-16a54ada8e0mr2160630c88.4.1791541714533; 
 Fri, 09 Oct 2026 03:28:34 -0700 (PDT)
X-Received: by 2002:a05:701b:230c:b0:151:7f08:5961 with SMTP id
 a92af1059eb24-16a54ada8e0mr2160580c88.4.1791541713961; 
 Fri, 09 Oct 2026 03:28:33 -0700 (PDT)
Received: from [10.204.78.217] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a2f17feasm7713134c88.9.2026.10.09.03.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 03:28:33 -0700 (PDT)
Message-ID: <1db319c6-eb4e-4821-85ae-f8ea5e41d28f@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 15:58:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: display/msm: dp-controller: Add Kaanapali
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-1-6faeac3a6d59@oss.qualcomm.com>
 <20261009-subtle-tricky-locust-b09108@quoll>
Content-Language: en-US
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
In-Reply-To: <20261009-subtle-tricky-locust-b09108@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8c1d3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=n8cVz6FT7eV6zO6OkoAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: lUCstXItPAnk6wLe-HiXiRPHcoZ6ahhv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX0ndbSdjZl6ND
 ngSLXKdcDFx9QditNAz6fdMyyFsPoZz7CuM7iw5VKW8ht/Qj8R0QGUoJNGpyvpFGjZr+o9xwhYM
 bCyadEg6oOJElysP+zjzUeHLX3MFQXi860ZVZyPsw+3kRjC8mX/i+IInh2qn0cYgzcLF5QH7OFG
 8rA/SKxF60sZLk6cAvbP97HFuduVvN7DFVZXt76AFbudE7es2d78QZG+hGLSO8W2p4z1hsJG6SM
 f5vt+ANTBZ4qHchEg3c4ICBRuKNAMmfB1Naw3s7IVHIifmk051ryRS0WD7SbGIb7ToIiEBdJVZt
 Srs/MDSPUI1x8pTCap3Dbn+XF9TTBFWt4+ap7I4gd04EsUalLekI16xe2FbX4qPmbbiJ7NHFIPz
 oAdMch0QDRHugsH91xw8ichaNVvXFOnp/dhN/C/vWHzlbBbyKS0t4z8Y/ImFKUl0m2jOzH4SV0w
 5qZHpRLLobcbqyBQ/Zw==
X-Proofpoint-ORIG-GUID: lUCstXItPAnk6wLe-HiXiRPHcoZ6ahhv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX/WDvBzcXd4EO
 eRy5Cgjo0pGyEff+l02nPqu+bXGNNVmImEIhClAuPTyGVoFDFsZoIJV+M8NJblmHXt7EIPfGuyQ
 7MBsEodGj9cajtLiPnVMfeBQTELJSuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090041
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


On 09-10-2026 01:01 pm, Krzysztof Kozlowski wrote:
> On Mon, Oct 05, 2026 at 12:54:26PM +0530, Balaji Kalkonda wrote:
>> Add DisplayPort controller for Qualcomm Kaanapali SoC which so far looks
>> fully compatible with earlier SM8650 variant.
>>
>> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
>> ---
> Dropping, unanswered comments.

Hi krzysztof,

I will address the sashiko bot comments, and it will be part of v2 patchset.

Thanks and regards,

Balaji.

>
> Best regards,
> Krzysztof
