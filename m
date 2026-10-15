Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157D0CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3701211222D;
	Thu, 15 Oct 2026 09:10:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF19F11222D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:10:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6SO761682636
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BdDwoOcc/IZIcemzbEOb6Rk++kVeyFBUpRdmHijaAIM=; b=lNXqNt3tkE/p961B
 wahr3Lmhg1umEwgGeBlbKzdQD6+6DynIJcumsyW6FdgTDooOm3yrmyvioHialzms
 4apGwbfbo6HiiyUDj1e5uBpp1Ee4wERSV7RwMiy596LX/OmTC4reOEvy51vIHXm2
 ynGUNLCBTYitPT1RcFUlTqM5l49FExlq1TFFBc04dxFmK9M3f+1IbifZII0Ndiux
 taB/MRxOO7o9Jw/b3Xc8Z9JLQLWfZlV/p4OPfYk2qSS7vS6T+Z1CmYIydDcZsuvi
 KZ+71i0ZmtUzqvedLDcuCYCk2u96iDIPO76GTZpBlu/Kjvgj3KgXi7xQ2ui3/X44
 QLkjrg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb03que-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:10:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179ef12a03so17125076d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792055442; x=1792660242;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BdDwoOcc/IZIcemzbEOb6Rk++kVeyFBUpRdmHijaAIM=;
 b=ULyeoqOxKCLhq8q+GwMHQOvWuSRajM88WNE3uBfIHQdrxStex/Et109MPjAydvn2U9
 CLDMFeELkwOnVCRKtGy/nwUI2FwfHWnsEnyXaXzkvV7V0Wzb7K58JKfzxV48tkc7p94k
 X8yK0YJpahU3W+xBQeUhEcMPAdgXOaucuqc15YAZztedi5AE2SoIrxJEB+duYoZuvt3U
 9QPrOyA0GF1NyxTU26PSIt2sr7cXF4M/KO1Z9oyTdOrAvmaWdrID61XB/irD0bHuwnUr
 awz7/+Z97kIsD3kRQBiyY2Tx9vGryI63pgzzIGJsX+lgp4pNzLQ6u1yTLZyGsQ5lqevx
 iGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055442; x=1792660242;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BdDwoOcc/IZIcemzbEOb6Rk++kVeyFBUpRdmHijaAIM=;
 b=kDDv2Hrqy4RHMREhaGP796yMylyKENW6xEMzH4O3VdK/qum/Bdu6LwlYgZijNtt80q
 r68eFbL0+0EgzfUCCMXvqNvEIDv28GqSlb0AppCDa5t7zS5era2E/r+LT13C7fbIey3b
 FkdwfMlB2hMoxVSNVyjCSFEY3JzZcjAkkd/TB394PGSmL2DWGydv8dZuI3POFtngqVCy
 ONo6gm4SdyG6NJuPAc32ORWVPhZSaqByb9Ntx2G/GixgSbz+Q9NInhdMv14CaZNY7RS6
 vwEATym7ne3OcB1xQ548RMX5d3LqrsqNHiMTrhPOrNcU/ao17wDUJmT2eNLNB9OX7v6E
 9njw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztjWumMqVdSKxVHNzfW6dXuT5hlJBG/Bj2mp7aEB225aeaNlaaOWfjSO9OWJhQqwu+3YDG+sA1iYg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLjYeryFoV000UScfBQgXMOOys8oK3o2lPy7zNhG4ZfqSGfKo0X
 r/DCa36SFEieScapT/KyupBbMxrxTZ0wan+/3xM0/VkChUEmMC0Ns3UVZKD7+mryeLA2RHLH6/N
 GMWPervtvfGsOaceLbYU88SCIHaNLL1E/gsbwJdjeqluJuqv494RX/OBK3DJo3RWmmdVWOY4=
X-Gm-Gg: AYBFou1Uj1rvuXK0AshiTv973AJzI+uoAJsVdo8M3zm2mFg09ge5UScxhDRlKG7O6f0
 SBeYLSfE7cvORbzJipHD5yeWLiiGHzAJpcuqpcfXcb70lln/lPDO3ZG29QVTZK06G4T+cISsTaC
 dwXIqXw5gUQhrQurUl5Bg9ndJo3xGl1NNzgRcXlh1A0gQOdNNtDshVIN5yCixfvkFzrtB7VenyE
 F7OsFu5XD2c1KGQg94bq8NQb/e6zsvxYGLWagFrumX2T+tXXwoTgsaGwmisiJ0XxcIaZWMEhh5p
 fu99gUJId/xWNKRSA+3DFA6kBbhCfoK2xhJnDuSlHZvHFY3SZ0GkemmQDpnjOeCltNgYmUFKOAS
 EwNuLWwXOXzEZczqRbzNQ5Q==
X-Received: by 2002:a05:620a:199b:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93ebd1de450mr3641736485a.3.1792055442386; 
 Thu, 15 Oct 2026 02:10:42 -0700 (PDT)
X-Received: by 2002:a05:620a:199b:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93ebd1de450mr3641732685a.3.1792055441898; 
 Thu, 15 Oct 2026 02:10:41 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b2038abf24sm2188025a12.37.2026.10.15.02.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 02:10:40 -0700 (PDT)
Message-ID: <ddbb547a-f59f-4ad2-8c99-4436bdae84c7@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6ad09893 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=7g7iOhDP9QsUep1Qju8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX1jUKnSneeUix
 8+HYc4hUbOgSBMs1nVjmeLZgeoGaKZfdaxBSAKcm/UmvqRkcqCa0TxkAapo79+XRWFy/CAtabx8
 LjilRe2PYw1HBv8dmwdhEngArQ5YkUo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX1lxSiV7fEbAO
 zQAUHTykoEYMvwmGbZnqprxgjZV0RsquuTJ5XD2Y2s00FhA8rga2HCuoNt73M9N1/LciPTiMgnp
 KFc0Kv34Bz9jHMigCW36MQu9y57+ahaexf6u2K65iFiKogBm7inL4e8h04wPc2zIAkzy2Y3OdTq
 FxObDSEljBvhRoYzDcgMbkJD3Ga6DMzUlja83/3n4CMglF585v6uYu7Nw6IdMO8qQb1TDCSbZTZ
 hpWawe6o02Ns5VH5wLZmKwhCVPXdzyqDa4pN+OQZZoxr4CUxNzT0Igk3RQvfEDiRCmYj4erGt2U
 E7ZSrLjCwogzyOlgUqfsodKnjbZsOcI3JjuhZRFtQg2VBQSg6/PwKfvv5MjZoD5CDvKUDx42/DL
 v41mOGb1ZGcQegN3Ik2zj3LEiheLmKoUlimlNO0TzVYfuLoBFA6YFTYdvSHRVOMubnKZ5hEBLBG
 HER9RkNj4O3TLTHU/jw==
X-Proofpoint-ORIG-GUID: H1-5LKSZ7VKSgPltSvrOphP1HIksqr-c
X-Proofpoint-GUID: H1-5LKSZ7VKSgPltSvrOphP1HIksqr-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150036
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

On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
> the wrong address the mux driver fails to probe, the Type-C controller
> and the DisplayPort controller keep waiting for it and the display
> subsystem never binds.
> 
> Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Hm, there's an ADDR pin on the FSA. I wonder if the previous guy had
an earlier revision of the board which routed that differently or
something.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

