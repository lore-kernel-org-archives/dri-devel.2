Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FF606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j77L8QPK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KhaSxglP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7621B10E2B2;
	Thu,  5 Nov 2026 08:15:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB95710E2B2
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:14:58 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56UZES595354
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 08:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=; b=j77L8QPKWZBQ+jZ1
 K8Btva8ICOlPOodpHLv4RKpgwyePhZRn+zZizN9rDvlunq533kw5NK+baUNrpaTw
 XK2xXF/FJfDqIS/uHxgblKfJQyKenikPMofnghGau4ED6zfHd+w1vLAlbZPA+tpn
 KVQiLJAyrsnOZaqh5jfgjxAW8pRJ60UcAnuBnAaIeDiyynLO4/VT4aGSxQxZ2hRU
 8KGehbPJU8lnW6XuOKmsmknMr/eq2BdVUbsvCuEuFBCMy8pPw+J3TnnO5uEcIV8o
 pp+v5LicooMtD5U3luCR06m7sdbaur9psqVgs0Vdhd6OiTt45gaFSZbeqVPB3rcx
 PbkHvg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr8rv3dg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:14:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91e751af52bso3727846d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793866497; x=1794471297;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=;
 b=KhaSxglPhE5WMCngl23XddJJ6qs79+GDW1Z75OqKjdGR7cW61skqlo5fHBhzhuCwRQ
 fOH7Vo3uKFISe2p4aDjZWuBfyUkc57jq0kPpz2MOz+YoX08/2Q75X1wo5TmYpr2jlCxV
 dbptyroQEpANqdJbpsfFcZkftgYfI0vBTl8BiVkcGr6q2ao4RdPP9xHeJGigjtIG47nM
 anO7CNR4KS2jqfbJo92AGcxhZ5L1hYJM7ZUaJlEOGHNwLQZsuy3FWqoWyuuUjEScdsz2
 wJ2m4TCxhfQCCmBxGgsPgH9DfORqA6vNP6JYdqhnp8okfN8ypUMHG84R1WhkYi/nXLkl
 OqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793866497; x=1794471297;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=;
 b=MAN4ZurN46xWbsWOB0itFBiJo56LdgHwqCBQ2ZCoLXZ3KZ4v6ee8WpQGNZMRo36rGe
 WVdOKXHxF7d1Jj6GBj2bkJc2FVBjUxPU+SKwdHMBgE+pK3zJ1tprbB/WaAoNkFci9O2E
 OSiErSHYMGjOxy4OSQQbetfR4PTXYjnH/cHYJSKxDUdhIucmQycra7GqnDu/ayaQm9LV
 67pDCVgmABBM+wxHNpSDTGPjuzIvL3qvNF6GQXb6rABlLmIrM5n8DHyiX2RIZC/gCPyg
 ednHeQnz8F8akKhmGraYsWEXtIquqUMU3fZDo1wM4clo8ZwF9YuAmwuUPamUNE7QgmrD
 TMxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXC/FHlMuZqKk2Hpm1c0VQdFV7zbYqfuLiPQ7zae8e/jINFniGyAz9FosSIYSxLHnhure6Jitahfg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z88jlpegtXnzhoh6XOYSM7NcscAqmTDMeQrAxqXjlueZCrSlQbK
 cG5bJZysQl1rZk9wb7jp2rKTxMjuzbotn5KSvb6hxX/t4pXrY/Okl4P+59RLpGcTWlIggER/MrB
 heoT4nXVsVDBC3g892HvyUUrhWI4B4R1ZpoFUMEvnZdfLz/7sStA4CzwlUI6Ak/pwMCA8wUI=
X-Gm-Gg: AYBFou39rm+SkVf5N6qyN9nccBnIAegohaparNY4rdJfA8iitAwDEEeLL+a7Tfd+85/
 wn07JEbsEmarpnR1zLnjcsiBIWmTdg3zF4KxNxOF/kSOq+Gzp2p8aL1C0TO9up2m3Z4UxX7Qm2p
 X0HW/fWCD36JH7TH5CFhxHAZB+shgAyFkTiVXJ5IkJY2CCUFIv0r/kLPE8PSvQz5jNol+hRoISh
 8Zqp+qB9kfYBohX/C8j9e0BVBw6FUdsocXb9hM2UY1hJ10gIfCzgZqh8CYiYUv8S4D4VwojLJOI
 mn6bYuXXOkQ4lFk/d6ffpZvMQDm+hJh3geTis3g/YlcHVqnLfkO+VLUHbVOHap/2JNLuxM4B430
 3k22MPTyryZN97aaZbf7Tt1FX8gAjnzpjQFvQd4TD+Rb9sqoeZE+R6ujgRTa3Aq8zJjpL
X-Received: by 2002:a05:6214:5913:b0:91e:94a2:f994 with SMTP id
 6a1803df08f44-91e94a312bemr42645126d6.1.1793866496643; 
 Thu, 05 Nov 2026 00:14:56 -0800 (PST)
X-Received: by 2002:a05:6214:5913:b0:91e:94a2:f994 with SMTP id
 6a1803df08f44-91e94a312bemr42644466d6.1.1793866495886; 
 Thu, 05 Nov 2026 00:14:55 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e44650bsm149681966b.43.2026.11.05.00.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 00:14:54 -0800 (PST)
Message-ID: <54b22ec7-f763-4f89-a711-c6c6796550cf@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:14:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] backlight: qcom-wled: Check for auto-detection
 callback in wled_ovp_irq_handler()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-6-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-6-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vtm2kO2n c=1 sm=1 tr=0 ts=6aec3b01 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EwSOXpY8fmkhG1aJMgAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfXzWT6wu153eqk
 hsx5lLFy0GCVmMKvey5CZUNmo4RviVnTeixnP25TImJpB5xxLpOYE9o5dLdOHBcZXVXnW/xhRPy
 hA1ZIQcoUap/vaW0R8ZX4a+EWJm7o/s=
X-Proofpoint-ORIG-GUID: u3rQEZ48xupA-7vEhqE6VL0ei7KUFNCQ
X-Proofpoint-GUID: u3rQEZ48xupA-7vEhqE6VL0ei7KUFNCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfXzla/G7OZLLhs
 vwc1zWBa955cuEn7urQXpXe/lnTnJe/YDWklOvCC7zRctifDRGpl8Rwn/tRj+WDJ3y7VvjVdxwz
 RtqAV+BKXkoFY4i8azoKo2S+juxzWEmFVmMT0Wpxiynyo9xl7SEx1rbPchbGSrYUj3rG2kQHBlk
 fsuvL3wzgtXNPj1E+MvxWkig1+m5gFEpg+MZfjMGY1/pT0hmDQnar4BbFJpcq6dlWqBwRSV5ZnB
 u8OcTtEdA6rA3GoFpCD8zglngOuoo7wSOlmhUJsgacu7tQC4671qKFHT0S+ZE8/DoPgBCUeLYan
 nixiwKnPrcf38fSfAFpf7t4c8nuSVxirD/WzPAOLWi804ymCwg2qJqR9XhiXNpXoOy6cOu4yaqr
 wa4dogTbIQSxzKxT9xHl4Zy463oBHunqgrdX//kjEPMhl14z938eyJob/0zp+/YaJmqR+ud18qa
 8yE2Jn+zff0KLanmxrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050032
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
> The wled_auto_detection_required callback is only populated for WLED4
> and WLED5 hardware, remaining NULL on WLED3 (where automatic string
> detection is not supported).
> 
> However, wled_configure_ovp_irq() still registers wled_ovp_irq_handler()
> on WLED3 when an "ovp" interrupt is present in the Device Tree.  If an
> OVP fault interrupt fires on WLED3, wled_ovp_irq_handler()
> unconditionally invokes wled->wled_auto_detection_required(), causing a
> NULL pointer dereference.
> 
> Verify that wled->wled_auto_detection_required is non-NULL before
> invoking it in wled_ovp_irq_handler().
> 
> Fixes: f16899a6a7d4 ("backlight: qcom-wled: Add callback functions")
> Closes: https://sashiko.dev/#/bug/linux-d3eba287-2af9-43fb-851f-78ab3df0f35b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
