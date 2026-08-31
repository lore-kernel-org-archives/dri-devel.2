Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BC9C624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F28D10E900;
	Mon, 31 Aug 2026 13:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C1gvb/DH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8AYkrVc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954C810E900
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:53:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBADsp4099258
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AUqh2X9awgVdQ5KkHdaoibkAOyLtmCtEGhzRBJfqysY=; b=C1gvb/DH6TlLc1AZ
 iAepWOve9Aa2BzSBpYQW9XFNuQbQIzzOgtB2ZiHWIyY/ZKKySSR0Eiz/u0pb4BM+
 638PgobIVBl4w+kud3x+1X4kg+BFSPzu0VVMRfDGQz4PPyHo13LLLbKFdEQcNgkK
 Pgz/rG4DswvK1euBuk+EDrYdrFCUB/HRZHz98q+cxUPKwAfEVuCCWnw0RppaMUJr
 o1ioTrh9XWqoize9uODLrJmPPNI+a/hwKPh1DG4ijNeczR8lgJE7y0jB7ZRqzNzM
 KZ0WmH7S1A49B3yGLPEXovTGoIq2pzUleAvV54CnC2E29N4KiiDYX3BxPy9X4KH7
 gnbe9w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4x09pe1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:53:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ef13b61bcso715122685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788184432; x=1788789232;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUqh2X9awgVdQ5KkHdaoibkAOyLtmCtEGhzRBJfqysY=;
 b=X8AYkrVcCFcdPReoZ5XMe8WWaXhTIRuvXPTwd4wgHjPm0wbdmSB6KPCYLCS2w7ae7m
 hUPawmjaHghm5w/CjjpbXjScVhOiyrnA+bgEzqQcrgXq66ZCTJd3yKmjByjwmafedH2G
 fm3qaUTqsF4tsdRF6zpZ65rgbfE6I3S+3GYOwTvNEig7WkyQlYYgefzA1jB9YXbNo9gs
 l2X8sWnUNudY2UKoR4u6evCryuZKCxHqKkLrnH72d8yyhVguGPGcP9hpNsL1M0iHBxJ3
 U/3p/GCjnErECKag+q5uI2vSGI3CLEzoE9I2qgqD/Qc6WkdWV+meAXpoHbCzNsQM5uH+
 UCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184432; x=1788789232;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AUqh2X9awgVdQ5KkHdaoibkAOyLtmCtEGhzRBJfqysY=;
 b=l6JhxeXGnK+n5WcbShPiVUyIYt54+j7xaUWc2dElVfTFu0CCHN06rSwvF/pOd+LarI
 DfI3Fzc4JK6bp1sVU9KT81DnVk7jh8pE0u/toQOt6wNoghL7QzWPWbzf0q9J0OBcEBlH
 MxuAg+mtDmvmhXQ9aXn83cFcUFOqUntbKNYw3qkxDWBI+UudqRQ5WwaEslvIi/YxeFCO
 +8eLqgnqfwW1M9xni+Oh/69YeQ/BGdNwOdFljbNve596Pzu+P9ZJaRE4KAsythXf34fO
 +d9UTUVGRs3BP8BUEHvG7WlcwR2Y8uNRn7y0ZOhBTMZFr4pS0dUirE7MavMJVJmYGrMn
 tH5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtW8O5psEB4JSkj985F4a9cCCNCKZWlBz1FK5vUXCSf5b1uUgp5xW/b3DkFfIN2/KL1viVi2tgnf4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nF2bDExsiTa4Bnb5dQTXleG1Ia8LMQUQchMLiZI/VrCwI5yDA0
 0XP78ExcI55lD+DolwBPGJkWLqtbrRvUXZ9cfBUWOTvlnY47ZxQcblKpEqB1pcOT93lKUKgY/E9
 QonSPD7Mto4qMW95JxTO8/ELgu3N3+GooXlMpUNp40GE0WVH+KVELif+panb8sdbOahFx3w4=
X-Gm-Gg: AR+sD108LsOFHUG8Os7C0OVfhnAPnQ0lBAX2AanNrP9uXMqD2xsemQsIId7cgW+1lBJ
 QdLAtkA724+QzMmNlpvoTSBA799AQ75KMJu28Q8d6c1gSND9Ac5hAKog8EWvt6ZAL/qq1Np9DBo
 H4Hxl6SYD0KUU98y2h25XHgHlVbIF/YRRZ36Bb/bj6oCjGjp4mQHnKmJl97Vfd+lvIXoxOH1ZJB
 HB6GpXhEfhA0MTNY8foUHDR4NslS34JxJFrKKsFMxLskaEV91Fpuvz/m4OF0a59rffaW4pgPmdR
 0+reewlVwYVAwbrskn7d3RCAVU61kFeDCwkWJBu1F46CXQsewLDSZgdOa0xK4oMJ8gRQHyhHsXE
 LUtODkENtx8ZxOeQDraRLtxsn99RC
X-Received: by 2002:a05:620a:19a8:b0:939:f89:3688 with SMTP id
 af79cd13be357-9391397dc88mr2712198885a.42.1788184432056; 
 Mon, 31 Aug 2026 06:53:52 -0700 (PDT)
X-Received: by 2002:a05:620a:19a8:b0:939:f89:3688 with SMTP id
 af79cd13be357-9391397dc88mr2712194585a.42.1788184431596; 
 Mon, 31 Aug 2026 06:53:51 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49c5a903eebsm181458645e9.4.2026.08.31.06.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 06:53:50 -0700 (PDT)
Message-ID: <4c9c442c-b1d5-45d4-9a0e-5ae7c10945e1@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 15:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 05/12] dt-bindings: display/msm: hdmi:
 Add Eliza HDMI TX
To: sashiko-reviews@lists.linux.dev
Cc: olteanv@gmail.com, robh@kernel.org, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, vkoul@kernel.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-5-67843277de17@oss.qualcomm.com>
 <20260828141223.1BF821F000E9@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828141223.1BF821F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMCBTYWx0ZWRfX85yubYXwNZAe
 5ZeBCMyvWgxmik3yRLi+TsbC0+69wulK1g824/FQy94hsRAw/YFgLYoQAC3te7d8sw/g92KqhID
 KEkRmCcPTh/wHodZQdy3Q2WwHeZ7P6w=
X-Proofpoint-ORIG-GUID: X9SAgXWusSLtUZmce96AM0SVIvyZPFTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMCBTYWx0ZWRfX6UTUMCykpriu
 eUe5EByWvqfCFSNybHikNbHeiDVEabORKeh76huCX88g66ih80C7OL2J7+9+JSCNnVmA0clsxS1
 LjIQl9HFCbpm5HZSwZs1snFqG+o2YFwv4tHz7ChbAIbEZtMU2IEKCpMOJwYx5k/+6f6BYIdcPDV
 uo/7mEiqBjH8Cbl/1AQ3Nxwl0uQPZB7yMbk0zCFmKGEZ+0mxtkHWuSnSNzACNazy62iHnZC1lR7
 lym90IIPyZFd46qSx95ZBS1i52rVGGqM7VzL06rNbhOJySUkr6HlSynqhlBu7Vgnx9JFAx3Ctig
 3yf+ewvovkZNm9FcexWXsTj442zkZycxPfJsTJqk7afWzF6myRG8h4AeXYNpwo6C04gST8Z+IC0
 +/fFQ2fVXfXrLBkDSaj16hOF5lNTzwRvpUuFUhiIdAaIHMqjcyXfPD1BCEn6CIwjXOB3YCRMUje
 jh2CvG+UhveN/J+c37A==
X-Authority-Analysis: v=2.4 cv=Iqsutr/g c=1 sm=1 tr=0 ts=6a958771 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=ryD-1BP75uk3LzTGFywA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: X9SAgXWusSLtUZmce96AM0SVIvyZPFTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310120
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

On 28/08/2026 16:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The conditional `if` block for the new Eliza HDMI TX device uses an incorrect compatible string with a duplicated vendor prefix ('qcom,qcom,eliza-hdmi-tx'), preventing the schema constraints from being applied.

Ack

Best regards,
Krzysztof
