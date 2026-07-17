Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B25C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBC410E459;
	Fri, 17 Jul 2026 13:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V46wbLoF";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcQ09AZF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FA110F558
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:06:53 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCSqV21871742
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5J0R5BciuWwuPQ2vpVIP5RiP4poixrhGzqsURsuT/dw=; b=V46wbLoFAY100POg
 nr81xMKjLwGqYng5u2+d074rGih90bA7yo3K8eMyXP3SFn9oj5KfeV4xN8+L2n+M
 NqxiDdtld33y0aVSqZLeKyN/dtBtxSR0bjX0AyEwg8KIZdS2weiyRkgesSIHkAGV
 xorw06kJKeFm5P/wapfON3sEJLa81Yb0BKGmPMbh4HWq+cfbWHx430QZKKL0R+8W
 QzzXklWPei3vZcyTYWF1DAVKFn96TR6Azg2djAgqnER/+TOiSedTisppJu1auKE6
 1KRQqHxFGwEQT31X1E2XW16Rn24MwkUUnRDA4mSigPAfP0ycpCPnwRTSjvQgPYCp
 hQemjQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffbquj66j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:06:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-73997bfbbdcso140080137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784293612; x=1784898412;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5J0R5BciuWwuPQ2vpVIP5RiP4poixrhGzqsURsuT/dw=;
 b=dcQ09AZFpBnkreW3zm4sq+hLsrOzOjBTqEMldIueQRCnJZIgaN1CCn9jhcbmkR3zqZ
 +rG100sP/rbTdZySuaTUP7MOxTgYf7z5xhQXn7/7kdzLh2mbHJRIm/VSxfzWXdw//Gm0
 Y5x8ZOIfb37UqI5iBv6gLLFLqAUrfXsvRG5TTMvuKDwE7hCJjUhH0fuR1CzNP2kKxJhJ
 sq+usmrrP7fWB9ynGNxmf/IORzRPYQ4n69W4hkjGuhO33dUAVY1RXWqwrUFhvObeUedT
 2lOPwBYjuEIdHqZeYUtzD1/FqB40vc7bGYSSYPnE0c/kSaZSbhojSbj8Q+U08Swapo7c
 tBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784293612; x=1784898412;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5J0R5BciuWwuPQ2vpVIP5RiP4poixrhGzqsURsuT/dw=;
 b=A0zvAuFur0lzSQ+tbZumWonoC7hn3sOjvq8ZHGB87mbtAu+Im7pK3UQ1U8H5LPbQl6
 1jjxBADyfm9qljO21euU2fz/H1aCzxQite8KDG4U8m8Sx12ZrXuVNQaHiyMpuyXYddNX
 5hb7TyAHUasMN6udxdQdTjG8JAvOy6NUmZ6BuSjS4n7lnuWWSinAZ9B/RVS9kilI9Wsi
 ZUq9/4qPoYjy9Nf3ne/9D4dOeICA4HUfAkOtLZi7N5dmXe7YklVpjgZqgswsUCNubiEm
 ao3N6Ug7tbcSvNl1PHLzA+kBoZs3H5V5otrzTkFEsCsiPGpKrYsY8GxjwVJr9pM5Et97
 T9qg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxT6dtyUdWXf8D8NNoBbUV+AAu8H7+EqEpUh8jUDAN4aJBV6UHtww6CbmIKyXx1o68ZKrTEqQ8OvY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRy14L9taytXLgWQoFXiMzM9aGlsvyVE0WWAhuyhLLueMypi3L
 W4ugYB3hiwCk8rTzWPBOUZfxKKO5sjmcYYXUIBOXDW0t7ENXdkseKaJzBPweFzqrCtJdW37yWE/
 +74aOsvJYlVdDqT2Bo3wQfeKVTGYOyLGWG9Mcf/lO+yweO9aAVTccICCuTmhDgA3W1xF/yR8=
X-Gm-Gg: AfdE7cmK+qViwPOKVvXx7ZkieV4Whcm8uM6yLmohzUBCW+tIEJcQw5Rt0Zu2ig/zzhD
 Wdr+ALAy31g2uTo5SNhw52FKOYZ7svYerCcI2UTcTByJM3S3oJaxP4pgLgnCG8xz6K/tzRdiEbS
 Ph9RFYXEXzeOhpRNQuqbmkOrhYSu7enRQjBlqlMlEXD7eZKJTj74F36QqlJoCOLCtaq9M+TJD2Z
 Uv7x9XFuUM1eObWOchtFr+oG/NxoPkPOvhiv5LDAOMA1kBBuBblH1EtofFoWorV2lcv9ze2pJtk
 O0oFposoDBhZnGhWvu9RD9vWnn/EMMO9ZRQLBo+/gCOvE+j0jsoZdG96PtcnL4YBHppfKdomMB+
 iSkShV0p1q0NDZB0jwq2RPy+G
X-Received: by 2002:a05:6102:15a6:b0:738:9abd:9ebc with SMTP id
 ada2fe7eead31-7475315edb3mr200121137.0.1784293612426; 
 Fri, 17 Jul 2026 06:06:52 -0700 (PDT)
X-Received: by 2002:a05:6102:15a6:b0:738:9abd:9ebc with SMTP id
 ada2fe7eead31-7475315edb3mr200105137.0.1784293611950; 
 Fri, 17 Jul 2026 06:06:51 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6ffbba0fsm631671a12.17.2026.07.17.06.06.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:06:50 -0700 (PDT)
Message-ID: <6e7ae036-e63b-4f83-947c-992f3199dbab@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 15:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: samsung, atna33xc20: Add
 ATNA40HQ08-0
To: Doug Anderson <dianders@chromium.org>, Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-1-57c70c23d0d6@oss.qualcomm.com>
 <CAD=FV=UaPKiGSL6mhVdywp67skSr2B7977f3kZ23FFHaD=95RQ@mail.gmail.com>
 <20260605152825.GA3740391-robh@kernel.org>
 <CAD=FV=U7jz-xwA+-Fic2thZaK6eCDhc-PZ1fqpCMAUmy3V3Y+Q@mail.gmail.com>
 <CAL_JsqK6u=x=ScTnW1jJCPZpCUb3mT0NZpsKqe6PqZmrNEKZiQ@mail.gmail.com>
 <CAD=FV=XBn78eOC_zG0S2U-W3whrVYEpghKF_WgX+3zpUJ82-5g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAD=FV=XBn78eOC_zG0S2U-W3whrVYEpghKF_WgX+3zpUJ82-5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WljkKwEFfz-gFHGvyBHdvRRQnDnW2mQu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzMyBTYWx0ZWRfXw28FI1RLjvla
 zQELPTe36UtXOxVSYPUaYIHUsdHeZyvSHh5ZjnurmyGd1Ati69CnQhvi1gFA9mjEJKWpYQ9MJ5d
 r+cDKLOKb0DCGWHen5sPsotk74LGy3aZC0sydBcZbj+kGnpztrO65osm96+A1pZgXBRvWLL6DQB
 g4KpYY6BnC0YEduAigio+swJPSb5oreRse5IJ2tpSck1/aZswFK80F8OqfUko7dd0x3wFurkGUT
 +VrUULLzGl9KGPvX2ieGZchgIOFNvNmUW5Hds+c5tP8G9LhTQr9v3dt22QRBeAvxEfrII2G+/Ga
 BvNoQSpbghjT5Rh24KeZoDpNywx8mHIV+6hkenWs1Yr6hg1RjmUwj/LLX0RhjmuqLKy7QUR74Qb
 8kRvKSUx0M7a+gsmh3HEcYnPut+x01+x7YkGZ83iJw9uw06aAqrMry9USucIZvEStJh2BW2ir/a
 TA0TQCGhEb1hGpQPb3g==
X-Authority-Analysis: v=2.4 cv=NZ3WEWD4 c=1 sm=1 tr=0 ts=6a5a28ed cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=wKqDAqYL2PsMjTWq7uAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: WljkKwEFfz-gFHGvyBHdvRRQnDnW2mQu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzMyBTYWx0ZWRfXzlWjYmGtij1M
 170Z+dQJjqXNiOeKYRtMmXUgfyJEmqAUafVjPnOS1dJOJLFR9PGL+MWki3yK7dT26HWOGoGebsj
 TdsaSdD+IzEg5XpUKSSAIl3yPn7h7Po=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170133
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

On 6/6/26 12:41 AM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 5, 2026 at 10:14 AM Rob Herring <robh@kernel.org> wrote:

[...]

>> Well yes, people have a hard time using compatible strings that don't
>> sound generic. That's too bad for them.
> 
> OK, so sounds like going forward I should NAK changes to this file and
> tell people to just use:
> 
> compatible = "samsung,atna33xc20";
> 
> ...to mean "Generic Samsung AMOLED panel with power sequencing that
> matches atna33xc20"
> 
> Yes, it means that if we find quirks with a specific panel later, it
> could possibly be harder to work around them. However, since we have
> several ways to identify the panel (via EDID and via DDC) this seems
> fairly low risk. You can't perfectly predict the future anyway.

Are we going forward with this guidance? I have another laptop with
another ATNAxxx panel (ATNA60HR07-0) that I intend to submit a DT for
soon

Konrad
