Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6949ACA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F0210FE95;
	Fri,  9 Oct 2026 06:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rxe0ZcDE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U13PnWrk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C549810FE95
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:12:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6993HumY251723
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 06:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LIPd0Djbu8CBc4zLDdiv751Zy4DXleUy72RpLYJZ1zk=; b=Rxe0ZcDEYe0hX30i
 Mht6EdKU59lRhEleUm3WrCPHGk+ibhZsIC2cssPY2tP0QAcQTIZNyiZNUeV6V6Oj
 IjBgXEy2PBiV+sT9bgmpo1NnA4FbbaqnAsSzg/27XGiUx+HTibWFz1lQXr+S16rV
 1XiDYYk6d/7DtSWKCIaBoykEJFWCoPLDTfCjVyy7GB467ED7bZzdVGgn/JhgI9Hc
 ZKHZ17CWJ2orPi0OGgEfuQMfKTCQ0pkrxb6qisBh6dcntGv/hN4B/UFjA8ZcR7QD
 V+YU/OzQfSkxdoFbZFPx2dDA7w6k0oTgofHTW2t8+qs/n4263cr+U3RvH5hUgJId
 iexd5A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqt9v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 06:12:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso11516411eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791526360; x=1792131160;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LIPd0Djbu8CBc4zLDdiv751Zy4DXleUy72RpLYJZ1zk=;
 b=U13PnWrkDycqUgWZtShPCrTK6rDeOYUXuqrYqU1qzSZJcQmsjRMpgq5nOsv4qZerRV
 6LqhoDpb4UjnQIT9OkiTBz0dVtI64mnCnw/UwdvHDfo/33wDkrTeWuVHSaWFfXgZKmWX
 DOjZeZq2ZAd0lCzgDq9AaNZUx4ads3ZSLeoya+3mbU5trFKjMguDEEz4H8hExgVjzB/8
 MwUkdP6K3w5bBju2kMNN9noutbVLeur4UrqK70cIumbILjKdjtu9wie1QzZcaJUodMMG
 QAELkQAwMmk3fsCvCTFxWGxbeXLkQU3CEGSEOXi0DUcNhGQor4lxlFxe6rR9VOz7GDDf
 7DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791526360; x=1792131160;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LIPd0Djbu8CBc4zLDdiv751Zy4DXleUy72RpLYJZ1zk=;
 b=lUQlOGIO/4wVgv9NUmrMHoUg5jk5CwK3EgM++s6vQoi5Xfa+HrcyTYzQZyeemFRSMY
 vZsFq2mrm5RFzFCEJl1yyf9/UhOo06NyOQPZuLatr3F8fnyGy96YKqwZMz1aJPfTHz/Z
 BKwbpdFnpkJmtwU4qh7acP+FxsgoVGbE2506MDgvPnl1hFgLdFiRX7UsoLrF/+XODJgb
 ScTHTKSTsxwbsDrArrJALU7Kwhnr4Vnm2g2+2FWv6t7ArVqZjM9ZTAI65V366wMwtRFN
 PR6mWZfY7B9PZV2iF1HTTSvlZpuZLyNddYFtci6SbXHaGKWanMCuTIu+XIeC8S4L3wkB
 Ty4g==
X-Forwarded-Encrypted: i=1;
 AKwUvByTCCewhqRJJ+tx5xVMWte6YdvoZ3yXHZmWgQzLF8Nt02WObQfvpSaJ8ovjCvmrNLP9vJ8orbWXjCA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbdGP9I9cSYUUzKp6EUCKwyyVr79/QuVqB2190jB4kZR6q4RA+
 f4nxS2kYCt9oecrD4wRdTr7anc3en9y1nWzEQZUm8IlI27GKEtTboIB4IrnySnFWnp2HoK4fLrV
 s/sRBi5B7mIUE+Kbb7JqCkmEKarXB51+adbhGQJlrtrcwYly0LT2m+dfvTbmzOtAAS1AfBf4=
X-Gm-Gg: AYBFou36Dt4cqnB2PIMgUugTzMtiShT4OaCCfE3LB+6BTWaD+FJiXUX10JWabnMwakT
 NV9+B50mKP2OyCiRRVkwBoZpCgnX9x17YcKkE1IINfSLvbPAMGtbZYoa8O5DorBE0fHfTU73HwK
 Y2xRsMijHiOW9dZMEat5k3ruTkokqA//VGGUZpeIHhTWUGsW7N0IeVQnl2YYzxcXXh+MWDvXMZ8
 EXn2OHowU2A+mnt74gaX7faFBDxQ7eTqQI9/IqjJxiIjYFHJS2MkyHuIle37Rxy6n7b402wSGzA
 P3e8MhGyvh8zVmSbzjpMRL/AlyQ7N4Ztc9lxXKB1RAF37HxwOwcDLrCLXuiDtls0MUnYxg+TEBD
 4L56djzB+eBQVThKRJQfDzqpwu0QH
X-Received: by 2002:a05:7022:f50c:b0:151:2e62:fe54 with SMTP id
 a92af1059eb24-16a5ef287a7mr1102566c88.20.1791526359547; 
 Thu, 08 Oct 2026 23:12:39 -0700 (PDT)
X-Received: by 2002:a05:7022:f50c:b0:151:2e62:fe54 with SMTP id
 a92af1059eb24-16a5ef287a7mr1102534c88.20.1791526358938; 
 Thu, 08 Oct 2026 23:12:38 -0700 (PDT)
Received: from [10.219.57.162] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a3f6186fsm3562167c88.14.2026.10.08.23.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 23:12:38 -0700 (PDT)
Message-ID: <5022011a-c239-43f3-b8b5-73d6b5fa8e0f@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 11:42:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
 <20260923-dup-sessions-v5-3-e953133a1827@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260923-dup-sessions-v5-3-e953133a1827@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfXz2VEmOLRXSRF
 rLF3gU6o+OGboliXyIwgEsCv4A/CEt+a7Q7g1Aqh5Ebrq180macV6meudE6c+7FAAG4e0BdtyZX
 avygpjmGilF8rVejDcOha1SmAL5Qpa8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX+divB6QkHZzT
 xFnmlDbwAunpagFuKHWbyWWsWEWRvRwL6rTyXob19WDpD/VaPJD7dbP94svjcwWYz/yZgNWXkoD
 8PenufnKacsttvL7T0o4CmBh8w2u/2lcz/+IxP91J77b8hMir5BOzrDAfVe+rC4UTGRy+pSkkqQ
 LOWo4qHUN46lLnzRJo5ouDwVuqPF32f43vsZAGkPtMsCD4pI6Sm8x28hbrmLGiMdTEQlSjJ6cPT
 qwanJ5IIGSLV03Ymudnt/hjmMq7TSal1+LMHWVMCDb8Gx37uxjbfgic7dpMkOs532RXEpe0BO7S
 Lz/GUNtS2xzDtdBKnGWBmIJl3KtXf6jUVI4Kz9trEk8OVmIhJZe3XcQ7KpN4qaEQA3D2llNRT7L
 O9egLPoFHxDKgZUfPHsKApVcEDLDXmB4ZJehc09sj0GgMlletN2stqz7s/KYDHKNoaIK10dGJgB
 5ff6Vi1nZ5wYuOZ+MnA==
X-Proofpoint-GUID: b_dOnj2w9Vc2xDKZrMuC3bYzdMI9_5wR
X-Proofpoint-ORIG-GUID: b_dOnj2w9Vc2xDKZrMuC3bYzdMI9_5wR
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac885d8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KkVOY3T2wTLdEB6rIlQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090024
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

On 23-09-2026 14:09, Vinayak Katoch wrote:
> The qcom,nsessions property was used to duplicate FastRPC sessions
> inline during context bank initialisation. Session duplication is now
> handled at the driver level, making this DT property redundant. Mark
> it deprecated.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
