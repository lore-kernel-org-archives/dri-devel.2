Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212EDC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782A110E2BE;
	Mon,  7 Sep 2026 13:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jh5M1pc4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AhpTB7K0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDA010E166
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:21:14 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687Amwde810024
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xudgVfXyg3OdcNE0RyNDSehp05AOljIo3nyACCtorEM=; b=Jh5M1pc4+HLHenES
 w+6+ZuFEQ3QKeFO927PD26azciMaTIo3shePfsaNN7OKFI7xRis2bqprMxvfqWga
 weRLB4EjBLeqBo8sXC71m0h/B3xk5eXzcaiXmAODd2ekwrppATljpbVHBS3YH0vZ
 0VkJ1WjShTx7y6tNICNpHxMeG1JWt32y2QJ+3G6I3wvqDGHj8DCH2yJVjqCAmFf0
 UkEZNEYgTJKTaYHbWaWnTZRVnZLC0MpCQeZgDwcalYsK7+F1AYFu8bTX9wtpmXZt
 9ZcDtaFWtUFAjM6V9f3D5zTzIFQtzXWRQP3SYTd3l7z4byCJp3TtJzKI7cDDv8iQ
 DAiRsA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua9j56-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:21:14 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97cb0a317c4so384848241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788787273; x=1789392073;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xudgVfXyg3OdcNE0RyNDSehp05AOljIo3nyACCtorEM=;
 b=AhpTB7K0Ds8v3FWGBKTdl6DhBzaugCjHdQOEC1TXuaBYsp4LpT9cyDeII05beYnewT
 NJeUU/YprJyEruJj/wg1B2/yDd8m8PgV2fAv31OeLM5TSi2Lp3gF0RBY69meoeZw0jyI
 yWNKFs8sO32sWwlRy47ltWcs2SBhvnDBmlyIJjYqJiKYCGviTDr8M+l+pyoCYfgv5SFr
 TUAx5xvcNHX7BQ+k4dtF7gBwwl8Fttp3H6fIacaxxIGQKdHxt1RfOhD+k818kKzwGfwv
 J7Z0a82zrCKkQ67e3gEw2vFF23auF6pALYyn/YmU4+LRmxHAEVRhL8bXvc0mCAhY9NpG
 byTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788787273; x=1789392073;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xudgVfXyg3OdcNE0RyNDSehp05AOljIo3nyACCtorEM=;
 b=kJ0Uppnc6eobiLxrDCs8Af7BsglQ/OOg4YThCYvMRmYXvwIKYry0Lg56AuHd5UB01J
 c20EEVAFcvcLtFajGv+nF+3rR+5jghqNcWm4ZZzUbRT8Zki5AH2IAA47pU+JO82umYEh
 l/okuJ3z5kqhrbVsrfLRGenWQxXPXvNtv2SlbG8nyIdCfpmIZlBhQNw6r5stmMTLBxnU
 jvY7cC52LkDIQkIylsYdI6V3xgHIqTwflcQInULtgiBuyH+wHRTMMGzO9DEmXoFiSfIA
 eh4bHW9DzTelebLsP/7h3jUcbOyH7C6d244MROPhRepJDWSNIamypHCC/77EF+rqNV0Q
 Ohmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLkPeFtkklrMo66D1NgJxfly3fzFW2F8bnRwMZw9X8/AHyajJytGEM8gyWenNoWXVxYwVNUxWIrBg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l8gpCAfia5bUk+wW6rrZyTa29yIfTAIGkz0VWLdX4Qwom5ZgIF
 jKAHzyArBTjAVvA4zis/fFvWUdDnSkYU1NiaXectfFbvmO84AuPwpbnPXaF7+3b1yO+ibY512q+
 wo7cMW5pA9xiDVI9iyzvFM/J5iC/jtRcU67a776jiQC7tcaZwKVXCZQjBsefXdPnLs6m8DG9jx1
 nU1IU=
X-Gm-Gg: AYBFou2TvjVVm6SI/7CjNC5RN5P4UoqFQh3MNuu7uteufByViwOnFEGgEKi+CRBHEzM
 Rq0lI0/40kcCtWojXpLuKrTL/SahYceUhWFqzJ6iCJK3tlbWOtXzzpC2lDGnAOj+tF9EA00oFYm
 ZbAXpmrKQ/9DBTWTWF7JNirfeIiOuMWsLunW4bjKNPifUEASwM+DtTknJqvWGexIh16/YxnoyfX
 nZU1/MX4gkzSEHunihrjQ6eUwSX6+KV/eP+o2BcVu9fXnRyf2z/C1QsFUha/dT/ZbnZVyLANSUB
 XI10ezMkdOxb66dpLMTALUFvknOz4C0Amlhhi7X02FPazDk1t6UZRRIaUmYDjZXoiAm/zF3YrYT
 csI/O44Bn2PR0B905xb/VJ/51zbdL
X-Received: by 2002:a05:6102:a19c:20b0:78d:31e7:e02 with SMTP id
 ada2fe7eead31-78d31e73347mr920598137.4.1788787273314; 
 Mon, 07 Sep 2026 06:21:13 -0700 (PDT)
X-Received: by 2002:a05:6102:a19c:20b0:78d:31e7:e02 with SMTP id
 ada2fe7eead31-78d31e73347mr920584137.4.1788787272846; 
 Mon, 07 Sep 2026 06:21:12 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858bcefd59sm23951535f8f.19.2026.09.07.06.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:21:12 -0700 (PDT)
Message-ID: <9d03c776-b05e-4037-b7c4-6ed817882edb@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio
 cleanup order in post_disable
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
 <20260907-drm-msm-hdmi-fixes-before-eliza-v2-3-b097cf1eac77@oss.qualcomm.com>
 <20260907131153.34AD21F00A3A@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907131153.34AD21F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZK-HrxuK-J_86IE11ztv9BNL9B7o8yTP
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9eba4a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=zC86WEiMApjGDmIPK9MA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: ZK-HrxuK-J_86IE11ztv9BNL9B7o8yTP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0OCBTYWx0ZWRfX+08FDaPGWoYW
 mA7U/nP+0630OklKMCxe1IVtWgNN4NaEi2xCBKhaUKydMKCKr9hCb0pkVxhEeVJb9Fp1W2yNCFF
 CDxE58pC4xWRrLu2DmflwNof5QO4WaM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0OCBTYWx0ZWRfX79yOMVlxK1hz
 Y9tCPFfiUgWe2U/JDxLeiMmKJxtreaiVgTuL+x7WHgL/KE9xPM/R/KFfgJgeF2vnrd9r9somfWd
 ovlIITHBQ/0Ap7+2rBXfsvHdIE6w/OgO//F2XRWWAM0NLwqMJHATJ+miyci7vf0zJLFD6X9tlCg
 5H3LciveaUs7Ct3jhVSleUaI9pskMEa4BLjROoZU9aCAv+2Q/SLIgaG25IUiGpdY+AFT7kUXBg6
 tRwgwoGWiDkknrWdHvNC6oMS1e1ZVnJ/mQaxyf725FfwBqtL09/H5Y3iJL6hqBO4g6JO/zdVUyz
 dF9dNxqh34meAnvmGuNIeR/HGdznI1v6WjcZI3NmxNKXMg+KLVO5nq0Pb7xyOHqm1zUR8xqrOjr
 3Zacoo0PHUz9y6fLQFRQoDcNFUGW/rSLvMIA7JNPxAl8sL/wTJR0qa5aKhc2zy5SbFANun1tG3H
 LWPWTihptDYfm6Y2vBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070148
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

On 07/09/2026 15:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Moving `hdmi->power_on = false` to after `msm_hdmi_audio_update()` breaks the audio hardware disablement logic, leaving the audio engine active before its power is cut.

Ack



Best regards,
Krzysztof
