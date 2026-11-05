Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FF0606A336
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zsj4yhUx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BeQaFh7h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9328010E298;
	Thu,  5 Nov 2026 08:14:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C2C10E298
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:13:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56U2ot4169549
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 08:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=; b=Zsj4yhUx3fB/7g43
 z5tJ9j1Dzf287bjQpuykmLSzBhhTUd+JO/SkwgbnukQ0jnwK39P5Cal5up5XDRDN
 VDyGL/IW+17MiJvu5RzUND4cEPuMDaXcPjYBhFFz/dx0bpWY3p8rkPFpb7u6WvyE
 Yf0DrV5WcabBL2O783wpDsKfdY1JFhxbjc+4KhHbCg91ihfQlHP6heqbekB9Sewm
 bdWTk6yUAkKDqV2MuX7rbYZPTSFrZH7qBOn3IVjRtu/12/wCzDP05E1rehyogCGt
 7D6N/6Li8wzFjbEcNOnBjQ6+VSgvntwg+UJC5UEy2FTO2H+pmbvBbR3Utv9lCo7E
 d/+qlw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd8e40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:13:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9178ba8eb30so2576196d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793866434; x=1794471234;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=;
 b=BeQaFh7hV5XjMhzB4JfhlB2wn7piO27O5IqBDQy2hBYy94iJwxm2Bmc9kapHKDVL+5
 bZPd3HnMLVhFovIouU79tSNAAfhkJgs8KXD4V8QDHqakeyKFXdi9zr57Ol18ZltyZ5vQ
 m6IUhUbzSJDgU50XZg40c7WtPqtu/Xqn1w0cZDDrkjs7LpioNpXnNqEkC6Ppj1fq4Hqi
 XQ7WCQ0XOWWtmIdRCxno/zd8q1/k4eWoA8NHMcN5uqsc4wRolrHZwheufeO23zv2XUrA
 tjrL2befaqvpmAD+CF+Ss+Bvj7s0hDERN0X7IA2rt3bYW8BGHDimMkltvaPW/uFlYDIk
 1jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793866434; x=1794471234;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=;
 b=WwQrcghAol+GPqPjmgb5LvhVSoZ98/fX017TrtTRMrXXx2sP2K3K03Ggf2ebiKI+P/
 vfWAJGndsbc1ypDzihgpqMWeSLuNU0faJjlS6zXkwbq2ekBrA5OsgkbSp+zNQYf/2ne1
 1IZ4jyo9MBY8adOsMO/+r2OJx/ntgxbVeXZFI+lIcBiguheOEjfoPpDtdKiNnOjvA1ty
 4NBJi1seWhakwxhQxMuTqqgHOFc90wFjky4dgI7aj9cHFAJUCZEOMoJCnyf/IuxFwYUt
 lLDWGHIfdUZigYAP0ODCqHelduydEBwDuK7bh4tCAlX0xLHT99HwXZejZnZkplQsrdQ9
 dAgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEaGu9Do3YKOWk9J0r7lMGyKFAY3vmCNe5m5zM0S31hDL3Fy3ZT80r4OYQjUjLUnFEMoM02zZWjcc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+EfkcCnxKY4o7tzVHWnTwK8pDTxLVXsxzPKKN2l+lF3NSOGkkb
 RFewZg4xa10WRf8jtCO14k+crJ4DoYRlv2ya4vo+AADcz/Bm+bqxOf51brf61u0AH9eRdSpW5GS
 gB9Gg0SDYEdwUvYzm+ghMWp6l/bMtvZYZn4RLSnpESYrR/QPqYLZkwc7H2UbMVhUQf/JbIgE=
X-Gm-Gg: AYBFou3D9s55PiJNYu1zUJq3RSEDV+I5G1zf6TEMWd/JFcyOMmJ1U+5zCWehNJRTjvH
 36IlLlgHLTWoi+aNJ0uPEM9QDIK4H+WFP6fRcoE9lJr7JDPBcyMGsnHMwi2yqRDhZ+ATC6ACN+8
 DucvvUqyJzJGM4Ih59ulx3xAiYYLAsYE0Pin2L221CyQrSy+7kGyClMHx65wnu36Q5821lhMYth
 YSWkZ7vF3Sp44uUMm6Ru8bh6iqchJUOczBMPlxUvBUH/qhf532XcjEDc9phqhIx69dVRMnm0cJr
 l1h7c7AUrlVSTfLAzU+KzLLGybGtDeCJ+u61CfEdBkVloLso1dx3zGAfKo2+wsiyJyhf6Ipd2Tr
 pfY2GuxzjhLUCsE6i32xbkCvUtGpNaI0AON/oaoTBVxTcNXBkEOhw44VPC44fHnTONUdJ
X-Received: by 2002:a05:6214:1943:b0:914:4464:41c4 with SMTP id
 6a1803df08f44-91ca4b23661mr390679806d6.4.1793866434394; 
 Thu, 05 Nov 2026 00:13:54 -0800 (PST)
X-Received: by 2002:a05:6214:1943:b0:914:4464:41c4 with SMTP id
 6a1803df08f44-91ca4b23661mr390679386d6.4.1793866433953; 
 Thu, 05 Nov 2026 00:13:53 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e42479dsm150842066b.17.2026.11.05.00.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 00:13:52 -0800 (PST)
Message-ID: <50bb3200-3110-4739-8a15-173bdfb8c220@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:13:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] backlight: qcom-wled: Manage teardown via devres and
 remove wled_remove()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Bjorn Andersson <andersson@kernel.org>, Kiran Gunda
 <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-5-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-5-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec3ac3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qHjM3Cc90Y4xjM8bFJQA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 8iUfnFiPpcUJwuEuhMFtLVQogusJqvOa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfXw6o1G0GwvzxO
 7Hn/Zn8ogh5ZWNLQ+RWEY+/wPyEhi5KJCzL7PfM57LfNb/dBn8OuEVbmMhY14FlppnE3iRqpPEQ
 ACwXryiLMgKuU+OGBjwkznF5bHhFOQQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX1jJuVW2JWMFi
 /+KGgd9vH1014TiVBWiSWst8pYg7ZyNnDthiJOaxl45QAK2gx4+O8bIW4gJ+6/7KmiQeWe0QyDf
 UoomqKPrvkiI/NGxxIsQcmA1Dm2gcI8dKRXPwfrlyHZCAQg87uZtjKhnxALh3YKPlHckWltRoOT
 n5NFeNmRuD8Gr6Fk1WEk0eD2SvSGA/a7qcRou83zEPbBL1uZnxUB0t1mSAeonbVqLxSryhSakpt
 NlxkU1xF22fFEdDB2/iqzq4kl6Eshf8c0a5IpBBlE2/7Cxz0wHdqyHSgluQZT/yzTJd3oFaByph
 qU44EuhLc1jfSm4lsug0ESY3Q1n2RCvCMBnnLhU2hV0nI12zUOBnmHy0W2DMXdvh2uVh6aNlbZb
 sApgWzWL39Zw8btYnfF/KPB2QQErzkXxMLXry30ZjXvsV8zkseEBjx5CYR1DbDIhI573QnyXkGU
 WCvE/pNTZbWjQFs1b+A==
X-Proofpoint-ORIG-GUID: 8iUfnFiPpcUJwuEuhMFtLVQogusJqvOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050032
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 7:39 PM, Lee Jones wrote:
> wled_remove() currently runs before devres tears down the backlight
> device and threaded interrupts, resulting in two teardown bugs:
> 
> 1. mutex_destroy(&wled->lock) and cancel_delayed_work_sync(&wled->ovp_work)
>    execute while the backlight device registered via
>    devm_backlight_device_register() and the short interrupt requested
>    via devm_request_threaded_irq() are still active.  A concurrent sysfs
>    brightness update or short interrupt during unbind can acquire the
>    destroyed mutex and re-schedule wled->ovp_work before devres frees
>    the wled structure.
> 
> 2. disable_irq(wled->short_irq) and disable_irq(wled->ovp_irq) are
>    called unconditionally even when the optional "short" or "ovp"
>    interrupts are absent from the Device Tree (-ENXIO) or unused (0 on
>    WLED3), passing invalid IRQ numbers to disable_irq(), despite both
>    interrupts already being managed by devm_request_threaded_irq().
> 
> Initialise wled->lock with devm_mutex_init() and remove wled_remove()
> so that devres tears down the backlight device, short interrupt,
> delayed work, OVP interrupt, mutex, and driver data in reverse
> registration order.
> 
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-51cd5e35-3cae-4e4c-986b-7261263507cd
> Closes: https://sashiko.dev/#/bug/linux-44e5ed80-c35c-4786-8bf8-9ee955967d0b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
