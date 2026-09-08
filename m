Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270C8C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF9710E05B;
	Tue,  8 Sep 2026 08:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f3nz8CVq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YT1jVaDN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDB210E05B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 08:36:52 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886Lufu3299555
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 08:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ad0bKhP+N11QtS34YNu13QejnMaDsA1lHN5IGmY+Ajg=; b=f3nz8CVqx9DdA4Nx
 hSW8/csdCpEQoc+XuupdEMfT7bwFYtwuvwDCYGJVKT3FhUbpjSMGclKjVALGoTPy
 GnTWJKClAQ0270tzB+EDNYEHzJWb++l5+EbUpMM83CDxDhqYt5mF9eGQJ3WSfvoM
 nlgQEH4SCeI+WLCI+vt588WVu+yXX/4VI5Osv3tEWxjmETewBts8H4goPbg77GDF
 ObMpCG6/xGB7nM7PHAGtgc1evI93KFRi3WsMhEYqHwMjHG37dbmGHak1Kq74CA5d
 wKLly/Id4Mb1+FGJBq5DJzqgrl+sHcSo/GwjkmOlbLcTLGemvcrPm7dULenws3Np
 t4DOPw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0p909v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:36:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9390a2c895bso894968085a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788856611; x=1789461411;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ad0bKhP+N11QtS34YNu13QejnMaDsA1lHN5IGmY+Ajg=;
 b=YT1jVaDNJ9FSMrVpecHTu9OjPu3T1m99omFI2bNjV2giS7KTl4U3fNua/Iw0uMNPnA
 3ZdYXQjo3iLgtGVbz9Ug7i46C+qcDa/3CDi8eHrgQWVr9gocbvZoYO2e3dFA5h7ag697
 39gINlWKleYaTz55QQLGtTZYe6mSN1RCrUbsSogQcYV7MYSGVa+ibcmitMHqlbvtqzw3
 IHYISH3Twrp31sHBCYyfRIY7AIZytry8To6jTDuB7LDEUJHWR6qGMqNFYbDISgcQjMl1
 biOyjhjDGTtSXViBwT7aARSdsDwHNku7gyXeJ8N7f5apLKRhmjujsyUMfNYBgRCeGhpq
 aI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856611; x=1789461411;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ad0bKhP+N11QtS34YNu13QejnMaDsA1lHN5IGmY+Ajg=;
 b=iP5g8Om80qjCGeSx2WqiTjmclICGo8T7wBywSbMRQnf1/eAqQ+/7zmhLkJX1suW9sg
 y/UQRK4VSnFcwXt7t4SNhYysLPf42DD9BBqtgQSo4LX6+r1G5KrQvHPM/ANxMT4/V2ll
 Z9KUv1QSGQK3UN5Ir3EMsjYoc7+Zwdeol8prxcZWvQP9e9CJlH8orJ31kezcC5trhwSv
 bfD9DXWnPrj7OGNvEV1VCkb8/k0jte2XmR5Af/whh9QWvcZpOaRlsFn/w4J0AI6Ciy/t
 RmhcHJt9v2eD6arAN3DmmUzi67fc1vRA7WeVHUhfIHSRRVYfTPgM++JZF7AyxeMOVdsl
 3GgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2EzC5jxqLlRtHS1kZsN1777i9swdou8M9riF0Zm3j2Qgn2NESVCt9alaLUk5iATDFGlZzjTwIgzg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8EQkNqKkhO/pEG3sZRtSlfFZS4C/xotWyI91xEt4b2RGy5ifH
 oaxKWoTvc3dqgRov8XUResX+b9dXZdZbkwUUXa+nb6oanuESWEKKCs0jm5/QuXbhiBG6HwRli41
 ZsmDeZpkH8y9ZhfM1p1Kl2JBkLOLq8WFaV2odsETvP/1M+RMIgKntUDQIbHK7H5NsJmv06SEgQC
 OLdr8=
X-Gm-Gg: AYBFou23M63cxngnYTBJnlYsjbO+IQKTuglU5Ei0nMTs5HzVxkaJi3ZPfoTlYPuiTfv
 Rswxvc6fLWvaUU9HwQqba2hxHa5ke3PpU74M3BPU6TjFT7LQXYtboUPTUpeWr/JKjYRSD1DVHI0
 3MrUKJru1e9nIDoUutja7LqfgzVUU/WEHxtM8lhd3SssKNBdLw2bWWSUYw8WfBUnhc7wC7zD1Pq
 2XwcuSutE5VGQgVt2OiTNdMxpcU25Pl2dYKRknmM7IOIfYT+VUiiYGxa//49j4S526q1tKOnXWj
 xpM0ZzCTzEJGutw25KDoSPMlTalIg1wF90W0S4VL69MfPc3cf5eQ1yh3ktahPXV6RFWEcMDTeeg
 ZCcYX4QRV0U43K9+xSjZ4pSJo8Xli
X-Received: by 2002:a05:620a:43a4:b0:939:6de9:4cf9 with SMTP id
 af79cd13be357-9398072e3ecmr763283785a.44.1788856611392; 
 Tue, 08 Sep 2026 01:36:51 -0700 (PDT)
X-Received: by 2002:a05:620a:43a4:b0:939:6de9:4cf9 with SMTP id
 af79cd13be357-9398072e3ecmr763280285a.44.1788856610853; 
 Tue, 08 Sep 2026 01:36:50 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm325117055e9.3.2026.09.08.01.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 01:36:49 -0700 (PDT)
Message-ID: <f16a09b6-9ae9-4a3a-ac31-48182bf8a179@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio
 cleanup order in post_disable
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
 <20260908072335.611331F00A3A@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260908072335.611331F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OIgrfazk3oJGL9y1H_QD-dl4LS9nFoli
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5MCBTYWx0ZWRfXyX0+5ABjtGfD
 TKrAboCihlTPXzzrwuEuvrP/zqpOhSDJO72FN/zSne9uZR4bugksqKe90XL5jdZUi8ECCUtLGjN
 65+2+NvOe9t8a3yLxezyqI8gfyXM/F0=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6a9fc924 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=N0GlATqSIOfpj-D0eqQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: OIgrfazk3oJGL9y1H_QD-dl4LS9nFoli
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5MCBTYWx0ZWRfX1WiwK7+8xW0f
 be3xrIANldhFGrX5mRBbdG87NFHSlHRhOaWiYYsxbuj89MbLdXLv2ZtHeufXBQD1GVmtwYr5tG/
 LLWLQMQyr2S9lxnIooxfpHwO7l4mxqgewmM+7bGAjLjrAJo6mirfy3ZtUanFChHgdT9p9G7fzC2
 YaBrQblUOtlwNOS9FB9eINIQbGnIwAAHJB6InyM+fTfKE50jSakIKWHqVnKpYw0F9ps0333xp2x
 Gk9SyA//IRM/0Pqkokttg2g0UQmWK4LCpUZCsGHE2aatBLe/5ieqAAO1eOo1aUT9k4ef1kCFJva
 5ViQaQ8vj3JnID3+MEfPovve/3FqVRRbB4wZxdDJ4Ukbgqe8RE+jtx4YlC5pEYocjb+6uZjTMnY
 x8x3N/AqLHFDurhE/T9BV80m1JrtABmu6BCxq23a4R1EBv1kWxaw9AFxnLyL7trefCJIYetu2+F
 2LA36IxLwL0biZQWIBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080090
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

On 08/09/2026 09:23, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] ALSA audio callbacks execute locklessly and can run concurrently with the DRM modeset disable sequence or when the display is fully powered off, leading to unclocked MMIO access exceptions (kernel panics) and register corruption.
> --
> 

Not fixing this.

Best regards,
Krzysztof
