Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43127C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B2910E9F1;
	Mon, 31 Aug 2026 16:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VO4zeFzR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JRwI/Qnl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9E410E9EF
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:27:50 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFqvZ33524312
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3WNpN+Vr63EvamqdAdbzpzLee0raToScEoKCwQyIt1U=; b=VO4zeFzRcZaWm1Mn
 R9NqSGNXDFXRw8Bd6dGNjLdzXb11WYFfawFWyWgRiuwsNM+Bfs7FqOI/SGYZgsaY
 jU2610ckV46mPKQNVi1TDFHLc4Ev27KiFDCXso1+Efp2ZJpAAlzZQAcoOTQ8Kse/
 znAkAcoIX6Q7q2XIc6duVKeF11XZH2NbNT9Fug13TGRP2Wr2LvvawWnfLynyeebE
 5cFOvO/eVqhniN5Nq00gJTjtYoXAS7ttBz4LGz+JDxX0fEDQEiMd7XhkWDhCIgtH
 r9vSHveg74VQFbOvYn6m5Ow89K6CizzgMimrctm8yh/9+f+wf5quFH1tx/KrNYH0
 ijqGsQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd556tbek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:27:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5e21552dso37485185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788193669; x=1788798469;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3WNpN+Vr63EvamqdAdbzpzLee0raToScEoKCwQyIt1U=;
 b=JRwI/Qnl3wyJADZ+Q4t5kAGqb+qCk6a+jOMkSCRVPxYApgUH/er6PIzSylnQp7euL4
 ZSNNCV8boPjvF00XZ2Av3H2wLWMmUeINPLbUwc0Vg7qRehls8OxgbOU2bK09Ofi9fU3W
 g9raLQ1yhQZqid79uGam9u2j5gxAZC90vMXVrYRoO5R9qkshIOrCnMJd5w/z3N3akFb4
 m8Ks+rmcWpTIOH03Jv7+2uEWgwGZnaZBzABrOPiIsLrmCW/YLxK5S6+3jykY67GCuOEX
 wRP+261GCgdSPKKFz0vDHbpU2xG+5mwbW65RJj3jhJ+w2UZ+0Iui7oQz6/34VpPbCHA3
 8lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788193669; x=1788798469;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3WNpN+Vr63EvamqdAdbzpzLee0raToScEoKCwQyIt1U=;
 b=Gjw7pza1A/nFbW5gbeEkPY+BlM4FnYHgF7eHh45vA7grrcBQfkwNksP1/lXTlpzZBY
 9t808tGY7Z61kDn+fMg7CsZcdlSWHaxoWFDc+9cVsGJuX5ZoCaJKWwpI0oGN/HBUvBK8
 oOsrZlh2MSwmUSD772kpu9pRaxKPeNiF/ksDZ1XSt8jJv6OhdbaCuL5QinpFfy8Dlzlu
 8rmMBXMhuT5oQalqxOmamlNLAKust5bjqPCQ+O9RX6K5lewGzuY/NBATd0nU5YgHbi6T
 UTZmEG9E6ekd3RXL2NDB0EhmtQD9UK8wEU77PACwVGgTK3z2K9J+8+YQUVLvYCtOHwGv
 Ispg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoebtJuzhOte2INozt7Qpu2/9MpVK66qCk6KHtQs4IacHjqSr9+rZCrE5EN+GMAX3DTOi96EbNOPHo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nxPbtif+QFVa3flg68kcCyKqVtea3khO7daaKg+o+gJzfwbLud
 LjpBaTisY3dzOagB+M3ZmJnfMbJOsbt5EZ/p2i6K5I9o/jhIgaSyFr3NU/LcIEC+HCpCFbt1DzL
 6te2jDNuCy1yW4xhf8CW6S8oNdvmRA36s3tVqoLyIUnAm6t3YHy9USeRJ2S1WEe/WCXMbZK8=
X-Gm-Gg: AR+sD13GjpJTC8+Z/Hl8z+GHmHyKoR+SwwV/9n0HuHDXjBYKhDAdi0NDtu4WVlO9rc6
 1egFpHN/lLQ2wiQ/GPqiquAwxRljhIZSmWFoijBGxCo15Gyaxp3Xh9Vzrz5zqTVV/YYUwezo11U
 VE88ytwpseEQpfBmLZcywJTDonZDIvJjLe3ENa1QTmxB++fb7FMgkXab6W33fYdU1qsHxhxE0ee
 ANhR0EhOsAfakxk+/tkVYC5/o7r8y4j8dFcMQwEUjedxKqinV2uPoJ+dBkWInJ9kiozyoEBqPDL
 h8SohEGsguU/7fuxrQPLVbVXCIrSsvK8UKJwDS558LGxx6ZVamsI7LU/KGyRERLPvJvvqhEoIoq
 tMz4ycKaeVe6YN4ECFkprBA==
X-Received: by 2002:a05:620a:450c:b0:939:8bc:8826 with SMTP id
 af79cd13be357-9393fcf48f6mr349885585a.2.1788193668990; 
 Mon, 31 Aug 2026 09:27:48 -0700 (PDT)
X-Received: by 2002:a05:620a:450c:b0:939:8bc:8826 with SMTP id
 af79cd13be357-9393fcf48f6mr349878085a.2.1788193668312; 
 Mon, 31 Aug 2026 09:27:48 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255eacf6bbsm450982866b.0.2026.08.31.09.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 09:27:47 -0700 (PDT)
Message-ID: <d4c8a4ee-2a6e-4644-84b3-bb5600836d8b@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 18:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 01/12] drm/msm/hdmi_bridge: Drop
 redundant initialization in msm_hdmi_bridge_init()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-phy@lists.infradead.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-1-67843277de17@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-1-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MiBTYWx0ZWRfX4XsHwnVvghTU
 IvjOqAdf2s4Rm2Fmx3qfcJpOQHP6cEBkzoiKVymNgNVyEvCSsV0gKjge+zqzh0/H+TXqMl6tFTo
 zTC1+szW3Xh3wEjSujJLNHnWQA+UevM=
X-Authority-Analysis: v=2.4 cv=O7sJeh9W c=1 sm=1 tr=0 ts=6a95ab86 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=P84uMFOcKlMy4IiKK0cA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: HbenMQqNxcHCCavEQXnlCki_VwNGrAGV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MiBTYWx0ZWRfX5Lj1K9fv++0P
 ZQ4pPGnfgrxfGnvS/kQOSwmbwjytCfTagRjgan0pxYFtKGkn67nVKYfdvDRZFebzEyF8UaEjHDk
 DFi3LFdFmkAh6Bk3IRVhHImIDtalv8RkdbAz4cDOBtD2vrPylHoPoEMBa6apCET5MCw0SNvZYms
 ruDS4uvN/p/7SYyBSEDvMTYVStEAAB3bJw8HhOdAMHpni0loKmTlQcY3Zg1v39aYdkplV7mAxMZ
 TeONJ8JsszjkbdnyL/Y3zSD3BYoJuKN9Hv61YcV06+mZqMYg8q6JdHzQYP02br9XTJMHJXnc5ow
 xTkNrU5aHem8gOan8huekLZ0GUswlgy3XDDCOBLM/724+F6iUlJJueySZri2L3naKAcpixXKpve
 /5XR6qbcu5dnehGFlNG3iMztPhOojNL2qlToKR3MR3pjIGfmJhX2+3WW9Ybkrv7rDJqVHXmBnrC
 v20jN9QpJprnJNy8fhg==
X-Proofpoint-GUID: HbenMQqNxcHCCavEQXnlCki_VwNGrAGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310142
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

On 8/28/26 4:04 PM, Krzysztof Kozlowski wrote:
> Local 'struct drm_bridge *bridge' variable is assigned in ~13th line of
> the function, before any first use, thus explicit NULL initialization is
> not necessary.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
