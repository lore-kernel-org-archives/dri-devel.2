Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41808C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE7B10E805;
	Mon,  7 Sep 2026 13:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIZa9HO/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U77vwxfo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5513310E805
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:09:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687Amt5p2652267
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GNY16aTxImYRYoULW+frsYnukMaZAxoXQCFZMgYWNiw=; b=IIZa9HO/AslX4dPj
 QRCBxEXExnjgwe82EyKstxIA984E62m0JBfn/uZsSgohFyZBJJ05eY8w6GZc9iSD
 UIfBrIfqjWyMG+wQphMs6oWh+g4vYcYZzWxWXjsojdvLK9wQ9UsIPuHdPsZ1ESCk
 aOYcGPEuTP609d9hlUZ5J7P0MPyUoIXF+6EV1Oq76N3WA1OEZ/JO19u4CNyMGcZO
 uwg1LBe1P3ddelUu+sbXwCdSD4bvOw4KsdhBCAuMVczzCT64MQs4PSPOPVABMGyi
 B5pQPOOiBLt6w0q7BtzKNpbX1q3Tdbpla20sZxHqsjPw9Ub9eSSaIZHzlhHGH5Yq
 xqBjdg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty0rtd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:09:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90f8b463ea3so34878586d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786583; x=1789391383;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GNY16aTxImYRYoULW+frsYnukMaZAxoXQCFZMgYWNiw=;
 b=U77vwxfoFNshToL78kzAyLKLvo++WYTZnHdwOJK9ROBU6gProU1ty2sGe1qXzpQfgR
 gmV51Wc7NgWPBW2lIF2th8XaL7yYMp7dO9dnwRlxW3UsVjPZFa63mLHFINXQAwkH5Z3b
 kLXnCcudnZ6UEvY8Xz+xHaPVxtYHiztPrb9zhosPbnTAMnE4GnI6GtGjPQ5zm8KkvptB
 ovVAkFqE51dWWxUNV7kU0whh/4KGDEd88iLZCJnR51P13UY3rgZK/SYTxjLgxmaznT2c
 s9VuQVqcfZYTV9wJbuxcWg9y3c56ciWlyFmVHbJUxt1nZ0M786AkZs4I2BWn+8gURzQZ
 6Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786583; x=1789391383;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GNY16aTxImYRYoULW+frsYnukMaZAxoXQCFZMgYWNiw=;
 b=nZjSeL+mzqnboeBPcHf9fkWbAvFLZBjJv+v6QwhSsqGQtuKqzzpYmTBIc7oApVa5Fs
 2jUXNsJmcEtiWudiwMPvUmTOaSq1/evxYkde5Rrn6Y4iJq1pXedbgYG7AfHaAAj+93hQ
 ne6n+mQaM6XCsmMsidmuFnZTBUrqmUIB6iczFOuTcBAz2K2UTLwhLe9YRIU3XkZp88kg
 sBspb0yNv18uMj/2feq+KRoOP4qq1xS6bVwoxxm3+WFwdogtwFwyLcWHXDA0mRIZkCTR
 jizfJm3WKXi+MoIkgo0ItgBFMt7gMWK0PWjrgqhY7d3m+mEDddzgg8qrj0DzdpIQ0ggS
 a4/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMJ6ANIoOSm+9dSMSuBJXz1DhXZHIdGXqfRO5FTJhmRV7QMRklzw1wVSEb42lemDKG5j63fe3iIkE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ldqQuIkjWKM3S4cl0k5UZEFVVssPs+nFe8wS8P1wItaa+NNGV/
 kROY6Ar3/+VzRrWLsN70cuZ2xUotzwPHYwvzg2WXXA9lZrTg2CjZnUXbAvvKzgjfR8laDlhK+Xg
 VLaTbnER0RNE3Db849yc5TOFcUu07hqCzYTfeMGbq78jbLwuTIvubZAF4kVN0+nbN1iQL3po=
X-Gm-Gg: AYBFou0FLc3P4PdedNK9QDw+4SXisPinw9IM/qASjH5ll9uXfNysiQtdT2DGwj0ijvc
 wsEBVwxRbo3Ek7mCx8bKYcSts7EcNeuu6tgKxPZJ/U/8YBkqdpi9GbcBMfY52vjSsDKFVzYtisq
 xB4ilWijKS3JwFDzgCa0e49NU1ke9NBBIsWWJJ0JOEeDByz/5aNJQWsN+LiqgqWTBHQeITsEk0b
 oMrx4xjxZrtslDNW1ckJh0GkwxbIMY0GACZDh/26HQvFc4oC3JOuoNk3Eto8Zx371MkNxXO1bKk
 iBZgeUKp0d97b1rOkPDOMvgqs6mOnz2rZCVBzJLXPHHxw3+C5BeoVmgLYXJsRPrQDG0TNYlw3mK
 emUl0UaIATmmFBywNnh4uwMEC0EjF
X-Received: by 2002:a05:620a:2903:b0:939:7c8:78a9 with SMTP id
 af79cd13be357-939802f31c7mr2492764685a.3.1788786582832; 
 Mon, 07 Sep 2026 06:09:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2903:b0:939:7c8:78a9 with SMTP id
 af79cd13be357-939802f31c7mr2492750785a.3.1788786582247; 
 Mon, 07 Sep 2026 06:09:42 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d0656e7bbsm208565105e9.10.2026.09.07.06.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:09:41 -0700 (PDT)
Message-ID: <97cc74e7-724b-45a0-a839-758c6fb383e8@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 09/12] drm/msm/hdmi: Add HDMI for Eliza
 SoC
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org, olteanv@gmail.com, robh@kernel.org,
 conor+dt@kernel.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-9-67843277de17@oss.qualcomm.com>
 <20260828142220.AB61C1F000E9@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828142220.AB61C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9eb797 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=9ZkQsALANqwWZhioCQMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: TlR7PNwWtB74vwVhVjrY9JZkvO48EXaC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NSBTYWx0ZWRfXx/zS1LZMj1y1
 7B3aXRG4y888tOjSFg7eZ9i8ygUxV+x3GQM5OdwI+eAC77DYkEQ+QaPh76lIyeVkOo39UDyvky/
 jX80kNGY5Bao4EmNeu0elqQj3a0ww+c=
X-Proofpoint-GUID: TlR7PNwWtB74vwVhVjrY9JZkvO48EXaC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NSBTYWx0ZWRfX3LDeujTr7bM5
 5AlNfDmqzCQhO/5fDT+oYzBM/4UOuHmwuTSZXlIQu/eIK0Krt+ICcC4QflNfwODbcxy+fWPQIRd
 vqvvhHSVqXY1TSORLmrvgA4owXdxo0bXwSwe91LiOlcC0s5b99Q/MT2tchKCq8ubT3rGdC0OZyF
 HdiBKheqpeimK1n1pSmbBxZucawxmCxMQVBNA6dZugV7BocG0Nt9NAn29+j3hxLuPaQQOm7Bcuw
 9OACIBRQdDZLROJczFOHVjrNdKaHNNOKmMmjfLHlUBHnf1UHqPgCU9wzcprxtHTBPr6n2VOX1tm
 ODwCqKQzJs2NSziMV+Q/2QezyVzKE8yIISl342xc1w2YqLlkwXx3qlMgAIsvvYsvW/87oRunTOl
 IlEYpFlhs4tZw8hpMKz382S4W9/vIXpUOysU+uJcVp/UXNWKLjhi6IIAIiCoa2bxuLmJwZ67Pp+
 R76aJrIYmJleZYnwxFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070145
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

On 28/08/2026 16:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The TMDS rate validation for platforms with OPP tables accepts inexact pixel clocks by skipping clock synthesizability checks.
> --

ack

Best regards,
Krzysztof
