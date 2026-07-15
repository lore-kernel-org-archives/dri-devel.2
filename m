Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7135C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 01:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C1710E6ED;
	Wed, 15 Jul 2026 01:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pfomCif5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sgd7kXKM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1DA10E6ED
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 01:56:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F0IXg32049685
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 01:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j1NEzi3ll4gdZ52BqXNdruNPx4sABY2QC7pNcTut8oo=; b=pfomCif5gd+3Hlkb
 cZi2zrSktGeSpgnOcDMatkNWKIO9zn0xlT/6s40IuHSxZDsquL6GVkpaMT0yF0Cn
 KaUM4iMKDnNmQ7q7ei6l+HZfLpjvHJXzExx8Uy3fu80gcSU+PgSqp2q0n7W5R6DZ
 33EQdIkgGz/8KH2Nwwwfr0tparSSRrFLQuog26OGg1VEbIVdlA//rsnbDQN8FY91
 sQZjUKCLivPX/lXJ3uPq2dJb7V7NOJDKztJa8b5Y7TmBoHpoiXR5EY+gRIXgbrZb
 0DNIR12GF/PmpHMG+GGJ3SqCpcJXVfWKda5nRj49qzzcbeyxOic5biBonrSUws2r
 21m7sQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdwk30m4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 01:56:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38de0739ab6so3131808a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 18:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784080611; x=1784685411;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j1NEzi3ll4gdZ52BqXNdruNPx4sABY2QC7pNcTut8oo=;
 b=Sgd7kXKMoY4yVw9kGw2WkA85bCMWVDEGWx3kyrBbf84VUyZg8o0xkMpmzko0SxheVQ
 mAm3i2awbinwZOWiJtQntSi/4jz2B/isMB6t2HaoSWruUB+KY9j996Km29iKsxcskqKf
 K4mdbw4uwGjHc7Z1FsdRGJV96T1zVmhj9iSptOIGa+Py2zHngI39IBFqAQCVDZgd1Wod
 VfGgvym3FGJEwIGH++yEcyNCXXF8lsBEkXntbgzqqEfGY2W6ODOzcQByA4KEuEBrDMD9
 9jbPWyoG3gmlMuqj7PZZq8UNqWCxNiebCldeoyNne0J9Di/F2Y53t2SruTd8WaYbA2Ki
 su0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784080611; x=1784685411;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j1NEzi3ll4gdZ52BqXNdruNPx4sABY2QC7pNcTut8oo=;
 b=TLep4ImvCgC9kOMfGfr+axrAeGIk0ViDUwRoMzuohJF+2eDd/Y8KZNxb2So4sTUJ/O
 mNsXUVnyRHXkPRRYFHBdFAX1BFoYiHDqZlYYIWq+R3pEWo46M1IdPbgjKHV9aus75WOW
 aCJ4VRNmGcdn4IYZkIq9fJ6N7v7WApijezAO7estpxdRDdQaAf7vnylBdFPEHusYyNNi
 70Va3x3k+q05m4XkoEqlctsf4cUbo+sDxITx+Qkl+p92bRVXQ+gq2nvq3GU+6qF4YK06
 6arR1BK3V20Ag9w4XmNdkvXss2Y4s61kKFfp4tzjgqUsTlQmIjGRvBZLPQPZ/t05ot2D
 VtPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNQxLJ8vYbSCmeCzaQ8kzfEuTScrTsgHR7GckKqNRO/f8g9Gl5d+sudMHgFAX31bCB9ThDVVD9oJo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyq3ty28ZkdP/8uWQcdmjiXKhpzyH6xTgwv2WIZVILeDpgYuURh
 QxOrNsrLI3Lhy9J4cE34itzo67LdbrQtC9m/b39U5Yqg39w8YlBj9nzTvfsZ1ox1cxzrtIj5nNq
 g/0a5B9LDkxhNhnhcxabB4p6yx/CzmTmuGaAnNihK/mB5REHIGHZRmq0fyIYxf5DMsK+f+RZHP8
 WaHt41RA==
X-Gm-Gg: AfdE7ck4475ZTfNTuaecPucGtm2bUTqMMawXxm4SBFTOPXv8O+H4ishkL9eH2p6yjyC
 2ucVtBS3pgyMvgbMWJ4CK/PaFydr6b9OX6wMs6hS343xHraWqgWnD2kcDG1HZ0RCneH1elUjfma
 gXR/HAw2Xc2MGzcxEsC3PSfkOfygpnMBdOKrA/zaQXyeGWHgyFLycSXcQpTA6sjiCgGVrbrRR7g
 MkgWZBOTxG76DWZTzdvwK24qhrbUmZYeLLjPo12gJ2VHV/3llA2mULXq8S60Wcz7G+pTldnjKFQ
 Wym9iOcBKuDVuuIIDccQblgHfNttZ2XzCWZGnTGHAwUoV80TQTIx3uunTpcpUj3FOybV/dOGaw3
 CkftMjJSInH2g7TdMTh39KL4jCPybpZWQchNX6ECig1eb346I+Jkz79CaRT+3ncXB1fP99DiAH6
 f+KjAU
X-Received: by 2002:a17:90b:4a04:b0:387:e0bb:5802 with SMTP id
 98e67ed59e1d1-38e2a12332amr946857a91.41.1784080610902; 
 Tue, 14 Jul 2026 18:56:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4a04:b0:387:e0bb:5802 with SMTP id
 98e67ed59e1d1-38e2a12332amr946835a91.41.1784080610432; 
 Tue, 14 Jul 2026 18:56:50 -0700 (PDT)
Received: from [10.133.33.197] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e1745a5acsm2245808a91.14.2026.07.14.18.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 18:56:50 -0700 (PDT)
Message-ID: <e3cd4067-8c30-487d-a68b-b4cf625059e5@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:56:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Add Maili FastRPC
 compatible
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602-fastrpc-v2-1-67a55e22427b@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20260602-fastrpc-v2-1-67a55e22427b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yc6NIQRf c=1 sm=1 tr=0 ts=6a56e8e4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=XtIZyzpYV7b62ySdhoYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: sFliAz6Ep8YUTa6rxa6wwIclntbsFmuk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAxNiBTYWx0ZWRfXyelfbf18NjaO
 4SGzp/STeiQrwTKOfEEKJyEZ+56rjjbobuwIkLj7gLq1loyCS9jTZFBkreVc1QfgMzwZo6ZUYsM
 QxWT3lg/YfDJgq/LtZ0hfI9RLFdeQyQTonoHqQWKO9JLbeUy5ZDQva7KLBYFm09aCBYGMKsQ354
 qWLm1nuHe39nNWFdDyFoH0grDgneJwVm1N2dPO6q6yP7E7ZQDNBGQmkS8v65Gkopj589a4B70O8
 6UPH20RjTWJGwdWeo+inGtEqX0y8OjAyhneGIm2xnnTCWLjOWOWmMLAYh8Xc3HVJebnxJFSPwPG
 ZrrtnnwoLa4M55kXFBZqJsMxiCjXMrgrUc5IFgCHHKaIqhy74spj34yuSjfsQdtEz8Ye2yPcoIL
 n6m9eRtalcP/Lg7raNhQPjSj/7wW55kUG2TwZTsFQVmT267TtosRLBXMZJc53cexnS2sclXbCfu
 7t0/aTp9a9e1i59UtLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAxNiBTYWx0ZWRfX+7BA67bdWcRz
 0WVERUvOBngoMoSaCDL4x2dD1OLSf/uK8uqF4IVBQKp7c2AmjGh2bIRUlF8RjYDsLelXImmaOUH
 F6FEjvu9cxj3nyLchwG5eWkLTu0GJCo=
X-Proofpoint-GUID: sFliAz6Ep8YUTa6rxa6wwIclntbsFmuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150016
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



On 6/2/2026 2:51 PM, Yijie Yang wrote:
> Document compatible string for the FastRPC interface on the Qualcomm Maili
> SoC, which is compatible with the Qualcomm Kaanapali FastRPC and can
> fallback to Kaanapali.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop Assisted-by tag; no functional change.
> - Link to v1: https://patch.msgid.link/20260525-fastrpc-v1-1-ae9add881952@oss.qualcomm.com
> ---
>   Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index 2876fdd7c6e6..afe52296bf1d 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -26,6 +26,7 @@ properties:
>             - enum:
>                 - qcom,glymur-fastrpc
>                 - qcom,hawi-fastrpc
> +              - qcom,maili-fastrpc
>             - const: qcom,kaanapali-fastrpc
>   
>     label:
> 
> ---
> base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
> change-id: 20260512-fastrpc-9f3b691f8e2d
> 
> Best regards,
> --
> Yijie Yang <yijie.yang@oss.qualcomm.com>
> 
Gentle ping: could you please applying this patch?

-- 
Best Regards,
Yijie

