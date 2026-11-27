Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800A606C2D8
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIi3g66+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DqhldR9V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152DD112B17;
	Fri, 27 Nov 2026 14:27:42 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091F1112B17
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:27:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARE1FCU2683822
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7a5Q8MPtSCCW+xwsPzibCdKb+02lsoWhVNp9a3EuJKg=; b=cIi3g66+bwoqhM3F
 3d2o0zwCGyXUmNTuYG44OuMAi4OppCOxYlvs7WgYEJ6xLR0NzuKf3xnL7sbjUUbi
 GXDcIiP+oarqZwB3pZuohtrlPrCuU8EyckNJqhfxMC9rbuipKjSBupceyb7Achdz
 7kkvpn7uirLfIksWSR7kizv6Meh2jNt99OdkYn/IJpDYwwA4pFiIuE23KGB/VqQr
 VF+bX6l4Mglp3nDwwp5ieFFBXDBJpoaG39hvbY4N6Rqp5lkSEZ8r2OjkPLRFzepA
 GGmqMi9ZJw1bYOnC+pAQkcyEnlfn4MJOl0j2BpWQUSMfWQZ+BtZW64kTjVHThVzW
 dS3+Lw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhj165-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:27:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f3960dca5so71891385a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795789649; x=1796394449;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7a5Q8MPtSCCW+xwsPzibCdKb+02lsoWhVNp9a3EuJKg=;
 b=DqhldR9V+piYQzJBBeaJvaDBPefAIaG4D3pqMn87UD3KefvciWd58r/slhrL04W6qO
 6nAgT4kXIZs6oWG+QPkBf4hHQW+QGHji6FdZGVlDlsfA8PqzJb0IZAysH1vdIW2LupTw
 esb/o5cGNCSeDsD/Yo2uDnGGUt8hGC03RYcdUUYZaNMeXtA9fXPmIZXO2iGbaMfabyPI
 EYVuUtYLEBRU45lEIT3q/vdqXXp1f+HlC4WgGbXUrosjthIyTMpmt67iclJxfj6eNEb4
 FwqWL1/A5eAjfphYTdJaCe/foOF5F7j7BdMd5VpkiB73dLrF0V1lhv2A52MbkwD1CLiy
 sZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795789649; x=1796394449;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7a5Q8MPtSCCW+xwsPzibCdKb+02lsoWhVNp9a3EuJKg=;
 b=fFAsG0lOT9rkT6d+1jCc9OoYxukx5dKHfNn7G1dfkSpR+B6Gmoh1/nHE04KDAki+et
 MYZwoTHP4fmXIITsu5qG0wEXnNc+RJeeqUI/UEHY1dUjJ7k3+XtfSt/x1C4D9OHATq9M
 h7H5SJkmgq/N1xfDlvlZiwvgxP3kh2EhE7ewWz13VuaBw10vPPWvNLnID8POjeBlKmzM
 925auUBT60W6pR51SwWfF35kq2Qmw8Mk83/F18awLsJlsziLlkFu8mB28WLl9I5VBLV0
 6JqOyU5vuBihS9HYiHPSCG9ox+ARfu2NR23SJX4vL1E8bzd1z5QZCuc5eLCcRSXYWDXd
 VFBg==
X-Forwarded-Encrypted: i=1;
 AL+hErFJ5NYyDPCDQ9Obf5e4DyGSyEskRBLrdjM0BoPWeCkKkSQX0L9hZ7zrRBeDP2GNxBqMvFUCvZM61Kg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ItwndaDWJ470z7mYg18fagpNnViA6RtI2acYV6DqpXLw0mNCY
 xdRMHKe4Sid2DtqGq1imzM0VIJuIPyTNTGrHnUlYexilysa/4Db5SO5QLKLQxCKLpHHYxl58hdN
 RKMl21iusr+v7BzMKBlD/mDkaWRytGR9MfeMr1A42qF/w33l4ccwk0KwqkA6jKhPIfON1f00=
X-Gm-Gg: AZFdTZe+0kW3h7gBDdiVz+KJZX1vP2BFR0+BnyLVXg1EXUSlFK2MipxGdtYILDQwRJE
 bXzLSo8xLCxDHn2kT7CqF1dr934iHde2uguBb4SXjep5lXe5XKwcp5y02zQ0X2CZ+smzHy6+PcG
 sxtjBy2VVxfOOl029AzguAmGYS56Ld8d5deOjb3mAJLnzqEN9WQDrm61i5RMEArFjR1Lz0hDEKm
 kjHithr3Aq55xbMkYLbJKCVGHp8+1tCILhsBqSvvd/KT5qbof6xUFfGTWSHUZntVZasBr6wyuA+
 YKuB4stQtIm5IRqI080++fuU+4oG7km/t7fNK+UL0XylX5N8lMi7xPR7AtWEPJfO70jpTSPsPDH
 yjc/mpXyVUtL11V1AnG43ErnXL1qfwbYcsv37tP/xJG/mzK036NJ851wFo0+AIMtGxKKXcfc=
X-Received: by 2002:a05:620a:219b:b0:949:aa1b:1243 with SMTP id
 af79cd13be357-949bab2c992mr4628948585a.5.1795789649472; 
 Fri, 27 Nov 2026 06:27:29 -0800 (PST)
X-Received: by 2002:a05:620a:219b:b0:949:aa1b:1243 with SMTP id
 af79cd13be357-949bab2c992mr4628942185a.5.1795789648977; 
 Fri, 27 Nov 2026 06:27:28 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba7b9570e9sm9285824a12.36.2026.11.27.06.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 06:27:28 -0800 (PST)
Message-ID: <0a37b7e2-2489-4d9e-9ba0-f5545f962ab1@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:27:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>, Richard Acayan
 <mailingradian@gmail.com>, Danila Tikhonov <danila@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
 <20261111-display-msm-of-graph-v2-1-fdf8fd97f49d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261111-display-msm-of-graph-v2-1-fdf8fd97f49d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfXw/FVY+X3SQVz
 vh3O1sFUNycMyI/7k4V0ufkOrdN/o9luuP9MPUFX/vogR5R8SK0aee2+pphfJj1MfcHUZnQjSIs
 ZpHEqopJl6S58aN02MrtoKbjga4rDYI=
X-Proofpoint-ORIG-GUID: 8t1P11c0vccwn42Lkcd88IrHY6oKWX6a
X-Proofpoint-GUID: 8t1P11c0vccwn42Lkcd88IrHY6oKWX6a
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b099352 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=BO6MpYfuLILTTXtsdh8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX4mhQhunj8lDX
 jjsuZvuefOFaXbtOK4U+L2t2nXawMO6jyJt+SgaUp4tUd6RZpi+4aF2Bxqlh6ud/2GhU48+9GTz
 TwHIkORngzfCgPCETA/i4Eb+wMD74IKnVmnshHDpWG5Qm7pmACDgdyavBjqEYfO3SwOHoPfygPu
 tOwtptX4ioDw8c5KaDoIrq/RKjhyKQUgD3t/iazO730/+LXe3K8ZSZOFlb3/Edxy/BUKQerAwfu
 iqP6FNvd2mUNZVPRCx7dFp3x21s/7tkQBpSFF06Yfq8Te8Pro02K60w8FTZl27yOC2fAgfZ7deJ
 KAdfRMstrSiTRoo/4uPgsnyHF8nePauerEls20zSfde5+VKBK7rl/UyLo6ncHEyd41KG2Ia5zRm
 Tv4YG1jCTBpEC1us0BV5kcsY5h9oipFG9oo4HT0Zgmu+eV7Az/tm24tHJ+aoqJkgLuJUKKw+CJh
 aUfnxYPDOMF/RK4l3kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057
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

On 11/11/26 6:45 PM, Krzysztof Kozlowski wrote:
> MDSS DSI and DSI PHY is useless, when nothing is attached (no panel
> description in DTS), thus should be disabled in DTS.  Linux MSM DRM
> drivers will also fail the probe.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

It's not useless in the way that the hardware could still be cleanly
shut down (which the driver could be made to do), since even a device
without a display may have the bootloader initializing parts of mdss

Konrad
