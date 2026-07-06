Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEA1C44502
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D9B10E83D;
	Mon,  6 Jul 2026 09:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WaFTSykR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ez5qEQz9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFC810E83D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:35:16 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66693wxA4108102
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 09:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QTo6r7Q0G+3mUeTWof/QQHuOa8Dto24iGRfkDVleja4=; b=WaFTSykRMZ8moz5w
 cJT86o/XfgpM2XMCIH2HCskKeqkKUFiSrDoSQv8gl5Oblg3e0tgetbxsRxRf+tIQ
 aRSJYuXP8tXITqmGenuR3EsdSIOpMNoopfaUcHqmXgz+eggZvg3GF/tDsrDf1j97
 xW6uvKwGtO2168cb2js9VGiYbGR+hAxkoIZvD7XQnFoJMoUjkUhY8X+j7S7zak9s
 Tpdn6GoZx3OETA6Fur8WGB0Xzec5u1s3bO+V27hizCcfui4XV7f75lEn5EFyKooe
 c2awz5EHD/7scCyteBHvYA2MGoU7YjHb56uBbsi+KnyCUWUZAx3U07ZFcoJmCMl4
 qe8bDw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxrjjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 09:35:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e59d97df1so11167685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783330514; x=1783935314;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QTo6r7Q0G+3mUeTWof/QQHuOa8Dto24iGRfkDVleja4=;
 b=Ez5qEQz9WUIa44GygJHIZr+89GiJTfWfnlA2+W/PLfnLpIxmZstyVqydPeeVA/VjFc
 RSiyYH23HP9lt1ptdNN6NUWbL8PuXAsqpt5qRZ69ZNByUIohatL3+iIXYmeF2hINLs0/
 7OKbglWYHEv1sDycxGdzCPA5IJ4y/Wc0aq2cQYq8XuVmNWFp8rxX7BmPxMTEI6x9M0yu
 KMiqH35wzD8loMiZFLjkmdV2Gya1hZHpQn2BZx/Zr7uEkS4SSNzu9dV368txnRpEaEM/
 76Jp6EK3XTfUl1EqgAMYZ4H3mSH+DeFczM3JVewyWqWCcFLeO/l887p5oQBNkcmzPwJ0
 RNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783330514; x=1783935314;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QTo6r7Q0G+3mUeTWof/QQHuOa8Dto24iGRfkDVleja4=;
 b=eqNbHVYhCTQDa/6nj58z7hi05LHMpb6VzmdnRdpc66EDsY5cFXah0pafcPDSJqTT58
 vO7QSB+Mu/QbUOJXLqCJuxi2+Sy8iWFBp9N/BXvwnz1WQgNJKKLoHktyxOH2TadAuw7G
 3khW9fMdPhIivM0vm+HpDz7z7LESnbjod3sWQkWebrC5FHsHP+t9sEsZ3yWRI9MBdBQ5
 BUuROV/U+uz6HzIwfwshK++FGS2OWpakRpiDNoNGjFHcWhkcUTQOBH4MoQYYgHgQe7Ud
 jhJQD/1mWTuDST4JZzXQUZlUtcdR4koRD3gDTQ7BAx8G617rAU1SggGlKmv5xDyekdwz
 IvZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqO5KcNf15pmckyScgOgNA2sHHaaSOtol4VfV8MgH96HinYdmmn2gm/817xicKgyDtJ7hR93b5VwAk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAZ10oIqAVufSd0so9oaqcZ/T1b7edjLE5juzG8k0LnXkfdrfb
 ZMrJ5TzPBVs+ddhx72/hg2lyj1pB5nt7DCdPJkFesW0AdnZkOvGWgj+aa3QEC6+c/75QAkeSNwH
 kd3lZKf/O5uzB5S6O+dJcpZuXr0e7G7uKEnRx++it9+Jf/xFNB2ejLuzS1C++QGkXeFPp9zI=
X-Gm-Gg: AfdE7clpNADq+a+SudMVVBETHZlKDghQhIXxEFnWD7kTu8TTzgdwGcmRsRMzDmrtskw
 pE2630hy9zIiXFFcjAuhSXOzzJYIUu8MnBUw/vqRQraIapRyax2bideRRDxSZxQRWvhCj0cEFSD
 NjAu7Y6eUDA8pXGEi8DEJaznBG83p+xmfsoD0zx14+w6oZXxjSb3rEvCmiX45PBm9gSdDlYZfSe
 r3xZj1DbwKdO3LIzhge8l32+InQzziN+nWy8H1H6zSMHbz95kVY8JMmYUxybYxsQ2tLU+xp2y1r
 f/J0pOes5GCQxeiqQ2nePiV3yRA568aCLEqfKsRhSRa3Qexy2HJBvvxARrhuBDMS6gQSc42v1zs
 K7g2DQupx/ewFoMEBJe2/iU+GMGJBmxy86xA=
X-Received: by 2002:a05:620a:468d:b0:915:fad5:9096 with SMTP id
 af79cd13be357-92e9a0c23dcmr868740785a.7.1783330512677; 
 Mon, 06 Jul 2026 02:35:12 -0700 (PDT)
X-Received: by 2002:a05:620a:468d:b0:915:fad5:9096 with SMTP id
 af79cd13be357-92e9a0c23dcmr868734085a.7.1783330510946; 
 Mon, 06 Jul 2026 02:35:10 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62c6f5fsm717445766b.51.2026.07.06.02.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 02:35:10 -0700 (PDT)
Message-ID: <706ff852-1b61-412b-8e25-9ecab968361b@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] arm64: dts: qcom: kaanapali: Add QFPROM node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YWgBUU7LBcX9QADAchLc2wna73p3KMzB
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4b76d3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Z4vjmEANuloM4Dk0XroA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX2m7GmkT42jvA
 yCyF6nU4PQCVu6y0E+qiid7zorb+Qqgvh6RscI/YK99bMSq6gNiN6hxGtXS3OdirEZDJSG7WZzl
 toyAjEPsWQ+Hf7+6CZpPo/AhT0aX5Zs=
X-Proofpoint-GUID: YWgBUU7LBcX9QADAchLc2wna73p3KMzB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfXws5fdqF2OQli
 t5GQAXbS4f2axfbkXsZPb4bCmVDpHUZq4DCiEoXSG5pR92yZdVq9h3anigAu8Tm2R7AJj7t1acZ
 FZyXeZVoeoA6FkBzU8L2Mr3THf4HqXwGUmGrQ02BNne4j7efiwbP1De1Z9wHuRBAj4zLevdnLAD
 B7uCI/Vwpa9xTKGkeJF4Yle0YDR6w1B7PMIyzZD3MGpoo/xyjihuXBXwH67ZudxLFP3NqznuwZ9
 EaGFDscX5bCLzatN0MYFdYupvwYOvQbYnZxGKGLcPsAzRz+xLCdABM8BcqLucgCf+gWUlA9+vxg
 +e9itb3Ft/wJasxBpX9P9H3YFsPLICoqkb8nAAZIgpPb2clJMKjXgHHmIxMT4R7/8caSU9Q6gF2
 q/zz80zdLNOWJ9rxvtB8DZANZPWDHnmxLqxhaGQwz216eJGBrS1QQJSkEOByBzkBWWSQpOhwpX4
 D7euKmm7MMS/piv97sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060096
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

On 7/5/26 10:00 AM, Akhil P Oommen wrote:
> From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Add the QFPROM node and GPU related subnodes on Kaanapali SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
