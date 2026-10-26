Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF15606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jjHQO5TT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I1M1xYN+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF05A10E0BF;
	Mon, 26 Oct 2026 05:31:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8D810E0BF
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:22 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b0wI2806302
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PlujsyuCUi1kWfCtrDGOhLB75OvATIPXE/Gw9ApCurw=; b=jjHQO5TT4qCEYWvu
 9a05YClP+echbMyLofIH2MSnKayOoznBn/j4JWNHM5j1s/kH78OSoItHe+Y1Uimb
 Ct9F5kNV66vWR72XMOy5HMtMpk4UeKMYJKeLUKGZ/xU/hEuAfve+JbIIpMWqTah1
 bGBJnvNGYrla2YG4j9mzsaHh6ICJPHOGf8yoemQZc0xD/RMFGhR/Tt2NTgnePEaB
 TeGCb1daDNE4C28WcAQsUNJ7kqADovrynsvvl3zGQIHHluHk2+3DzVYelHVaP6Uk
 OsOkRK+INBDJh6rG+cBvWDW/yZ4vDUfi93zBs1rm+p0GCykW/2vGbdqzakCHNR49
 dihZ8w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xmy95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:21 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-151ba226e1bso5240380c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792992680; x=1793597480;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PlujsyuCUi1kWfCtrDGOhLB75OvATIPXE/Gw9ApCurw=;
 b=I1M1xYN+Df2fULU3wyfr5UgNgMN5r/iFzXVLtjBW9uD1TqnisyAe2R6YTZRHP2G5UE
 bKIIcih60RiL3IYb+pYBguFQPeqcLLn00D1T4VZ94X9yb1AMoSv2mBXsBUyJoDtwhxpr
 2BZCwcSjeVotHB064FyY/5SVexo2e7uXyGC+VstSWsvxvmg65ZYwwo33VobaWtDLgFuj
 D3WGAYBpo4FxBGsdamTH0MGHB+/Gy7dp8M/FBb+vFTWX7qZEIGzWbW7eMuIgN1vDSPvQ
 iZ4COL50OHkU9mPRKf6N3lqlFUp3RgOILInesDfBf/eCyAEEcCsLCJ72u2Ck0KO73OTW
 891w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792992680; x=1793597480;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PlujsyuCUi1kWfCtrDGOhLB75OvATIPXE/Gw9ApCurw=;
 b=vLPCaXJ+FYaou05vcCQHDG8nsAnD0Nen84EyTDh1g3ccXZ4sJ7YbAdpciwjhVdS7QN
 VikE8+EGzIivrbxZ5Zy8twAZa72Y5/ACJAKtVrgwuHU44kquz2PiHd8Qw8IHkgjDN42s
 rTXeWE5yWTgLSmmtQ2WFUCvjePlQBPini82wFxC2v942JNZGl+j8X2kAboQHkSfgyWmd
 FRvNExcX2fhlltFuoaB3Gz2D+eehotZcw9HCJy3sITWAC0CtQtcKIbCzY8oBC10DSKPl
 koS5z1fhT4kwF4HOelDw8rQyXntcVwX67JYeQ6VVRtOwiWOLvM4xwZOX/nNGoledWBTS
 FJcw==
X-Forwarded-Encrypted: i=1;
 AKwUvByMHix0rfIkqOps1cd7OGv8EADk/blsVH1XXXUgLaMXwB7nY9R5Ep9adfzPXe+/InXE/SQtXLVJWk0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLy+p4fqv8gdMDVSxug9T15FIlI+Dgy7Z7pDy+GdxCifXlx3b/O
 D7/3omDdPm5Orzf0E1TcmMbqHjSqLILP1/Josxu83cSvBlLqX5w8T5b3esK6WciZ9GQgkqtUb72
 +RSBj0fXxrmcYSq5ikW/U4We7icKOO9+vEj5fubSicEiCvxD4FNJKHxzGAkyKYxE5jMUnQZU=
X-Gm-Gg: AYBFou275OasZSoiXLnPMh7cUXrHKib7zknrP02s9E4EIT2voqidqmJC/q6xTFvf0Wi
 l2WeDIxSjBi7QLfqrYrqwr5RsgIwp/t4783xZLE09taYgmK+dI/K0KtPvRrveR9OeJhShhwv3or
 01k4bTOIA8/dZa7Cn4UVIlySvebLkFxJu0q3mkmDnswpV5eNg7q7XxUQx5p5fsCUMUqCXpw3Cy1
 J+cN9vWRMEGX5vmQBhIqYXcSFvjXSZwIEBcz1v+egVIEoTlA12qZSUahbhSz8YANQ+6GBuqMrEg
 CaPWr03nLL1CtgZUvJ34M1hqdZxsRw32Ti0M6werBERDyAnLUKdnctEfuZEVIimICyanXleVUHq
 uHJs7vuEnn1XDybkCVCfRBZaE0q10sA==
X-Received: by 2002:a05:7023:885:b0:149:d501:b990 with SMTP id
 a92af1059eb24-1993677a1b1mr11019296c88.25.1792992680054; 
 Sun, 25 Oct 2026 22:31:20 -0700 (PDT)
X-Received: by 2002:a05:7023:885:b0:149:d501:b990 with SMTP id
 a92af1059eb24-1993677a1b1mr11019264c88.25.1792992679477; 
 Sun, 25 Oct 2026 22:31:19 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1989ff2ee69sm29231493c88.4.2026.10.25.22.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 22:31:19 -0700 (PDT)
Message-ID: <d0b68329-a784-40a2-919d-971923a599fd@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:01:14 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: monaco: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Rrz5FupABbnaZWZO7ziA8DHecA5Uux3Z
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adee5a9 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rdexUmAEWTTLP2vLS_oA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX/4KHUSg1GE+r
 MOfXmsoBjyeFmB/EVy0vXYzEGjRdgaat6eq8hr3n748ZcPL5om44umxwknEnjSD1W4QEnJVh5NB
 rPGr2ZlsBYSFJTOB/jydNt2X5C7ehzg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfXwPOep8H3kz3w
 jIJPQotuv+dy8fEgb0vaJACK2CISDCn4s4wq7kFSqTxr4/wpBvxrx3zKFZuHYZj8DRUxPMNfj+f
 onzevPqm1c7nD+gYlmeSHmtITT8xBhQabSea7mk3KM+hBmf9H4n5H4q1WKWsiMRiQmcI1ftHKDv
 EeQZArq6V+GL14kdegRiRHXkoBqCfeUyOKUB27vHKJKI9J+wF0GcGbkn3ZxZbqppNcRtOgtSnte
 SsRAVr9BGqcEbAWQRBlSt1B8IZncZ8/lo+3scSON/IlfacssSrIbklQIA/G+xq+yOi+ZuQkS+hr
 b0rEROzkwtGXgxM1PcYSPlWjOu1c9NQ+pvRICD5SGeo7/wz24xRdNRW7y6tFOC2CTQfnhIghYJ0
 D1jsY1nKPZOE0vmh/j1tpW/G1BvAQgJy8G3XNz+dfkl4pomsL/XNtmV1+raqqLUuxqG/gCYkKH5
 qq6LVs/zOnAlaoVyetA==
X-Proofpoint-ORIG-GUID: Rrz5FupABbnaZWZO7ziA8DHecA5Uux3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260021
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from Monaco device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: af0d19ea5a31 ("arm64: dts: monaco: extend fastrpc compute cb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
