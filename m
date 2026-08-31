Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0AAC624CF
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D040110E9F2;
	Mon, 31 Aug 2026 16:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aufi+QbF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DPJxVCzX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24CD10E9EF
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:28:10 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFqD174079245
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QQAALbq9tEkve6/a0cvzrhYbBBU23fzG+zbH/pMCIG4=; b=Aufi+QbFrcZ1EklI
 yP+e1axCE2oid1XNbvldEVA/YAZYMEPNqSMQCmiuBPHNo99GhWe4ZpJZyyGGJR/T
 6M51b+JIXS4f1sxyVMLiysgm8dbZDxY5LfUL1SqsKUvr9zKgXJTHWFIaGcP9v9C/
 VzdACCIxboE/CqkPlNeJ+INS57zyOwnInsnqxo+t31mGviuvf3gMAM2kf8T7MlNi
 Zd7gPd4g8FtFxoOFm5bFnpcJqQH5NQlSxQnvd29nEQl9ta5yRxB49eKWEofsT7j3
 LBHJ5PebDflFyXAEtIx2N/h3UMVlTkgLoi6cW+oKyPrmOs4koP7Cc7DOPisM158f
 lx21wQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb9vj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:28:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9390890ae83so97320485a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788193689; x=1788798489;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QQAALbq9tEkve6/a0cvzrhYbBBU23fzG+zbH/pMCIG4=;
 b=DPJxVCzXUGmkq6hAxGhiQcwcva7DCg25PzonjJVOIeT0JeupcRYztKqhY3FrBQDgL2
 uWDOXtG2uagCkfUNRSlrvYmV8XmK42192aC5BvASOcslXT5twyG7PKZPIxDJ4TWA+t96
 l6ZwODnVTTaQ291oAiZIhDoE/cIzXDC24GEjTctl7QXCVY5r6ve63+fgQHjiiXPf4FVq
 Tm9uwFFwdHSEXQqXfV4CorA72OZp/TI+lX+ER5uoXXj6kdjAfTYB2HWMCMLrbc4ZcLhm
 d7JGdzM9upaRiCe0mRexIHeWyP4DWbPysEArEDa9iaR5f9qL9j/xGJyQZss7ks5x5xit
 m6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788193689; x=1788798489;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QQAALbq9tEkve6/a0cvzrhYbBBU23fzG+zbH/pMCIG4=;
 b=gDYqvmZ1VF69mg/ABMEK3FfEwu/Diocdlq3sonXf8vH5Pp4WkxhtkcsnV0HHh3S0Vt
 +gluHMaP3gHOKvmNFuns2lmS5TXoo5CW/PQhtLzZoaFMDzm0Or24ZHlnvL1wuvG9Qrdi
 lKYmJ1m/FpiKIpeHVG8DyzaL30hsWm5nOt21/awFg8ukEo/EWcM3UO5K7u+WAbxMyP4D
 h2TjrTLaIK+CmqAqPenEzx46pP3myKACZOIgQ4R7JT9lFuYIBBtPo/xXpPrbu498lsWu
 rFqJpK+Tb/NFCHrWGABfAq9AFDXP+b7Q3Pt5qyzA/pkD3iQFxcY2b0FTcjtzvxglI+9i
 czcA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqs5/9a0xBx2qy8Nb8d4yw6iFRRh5cOYfPX9JWoylhWo8KB/+kGAI8qwhG8adyGw+UmZEKfvc58Y9w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvbbupsvDteotq1g6/yBAlGJjvc57JYnT3p7HibrY+NCfYc/lL
 RQAubJcnVqVioacIUn9JZ05c/vLgySig0LsZWHwX0mfmLTF9ajXlBQomp1saTAZBVrTEQlapVBW
 0sPUNdk+5CizOWH4D3DcSW1D5RQ4csKpfPI+6fP8eeJjXEw9mk+DsWWucBq0UaVzqQf9CfH0=
X-Gm-Gg: AR+sD12aCsdvyWJ5VE1UBl8NTxYOAytWzt14hNZ2/gU36ZQQkCXnC1S5aoHa1K5dhFK
 hh6POfYpYxixPCUV5bVxJh2WLwRhR4HMHko344QHXRu/6lRljYlU9d+VNXlnGovM/xRCdnqFG7k
 TXHSjorgz8Pfym91MBzklQNxyoGJ+KTZX/9SUYoX6yYheQ/pILS6sc00sX3bceT44F6ixWr4Kfl
 CGdSpAPGdtwKypaVHLRa8mA780ZEIkvnj2MGy/H756v84x/NLXONZHq9ua0joj3K62EeRExA649
 W5UDzdf3BhOEb2oWxljuRpnscntQtJO0wOMqz99K4Rwp7TRf6M+Bs1WJemtsf9NoxtVikFvs4E5
 LTKk36TOVC3QrFPsOjXEEOA==
X-Received: by 2002:a05:620a:f10:b0:939:216c:59dd with SMTP id
 af79cd13be357-939287b1e3bmr1054411585a.4.1788193689332; 
 Mon, 31 Aug 2026 09:28:09 -0700 (PDT)
X-Received: by 2002:a05:620a:f10:b0:939:216c:59dd with SMTP id
 af79cd13be357-939287b1e3bmr1054405585a.4.1788193688823; 
 Mon, 31 Aug 2026 09:28:08 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1b5a4esm464039466b.32.2026.08.31.09.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 09:28:08 -0700 (PDT)
Message-ID: <563e9749-5558-4ccb-9b1d-0d3ec6a80ed6@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 18:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 03/12] drm/msm/dsi: Fix indentation of if
 block in dsi_mgr_bridge_mode_valid()
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
 <20260828-drm-msm-hdmi-eliza-v1-3-67843277de17@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-3-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xweZkjJdj0cUKgCrsL-o3zS_L7YuZEgU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MiBTYWx0ZWRfXwodtzHms7uGl
 R2uvwc4f4V9xZ8ERP/1z0hVo4bjpLSKsEVEcyNK4yqP+kqk2ttfBuCIwZp3fltb7+2+EUIU+uPA
 kQMpiShTaQDaWjN6ICrGWtukWzVLRoQdEpkv16mDTcWQG3vcxt0rJoPcU2S5EnXTRZgyeeaAVjL
 znXkny4wsbpWrGjdUKiR/Sq3mRqdhxC/2hrpACv6q7rzvezBKB6CGVuIJAUTyWjCv6bb2XX4gQP
 XKtyABqpsu1Vr/GNzNBmfFqI11pmEAuelLmMUBNS/4wGcaHetH6Qm1yeyl8rv/+LV7ND50ogStw
 mcInIxFgQhdDQNOSPaZLIZoEuiquuLlvrAKtwivUXOn2QuQRjmWcH1BKYWV916+yKzyDvktT6Tc
 ORv5j/tYMM1daq2KMD6kaD9OqFWcPH7CG6NVzoi1ylTVq47QsQqwfAbYbzE1LcyKXOjX9UOCHsX
 psjycBaqPEoZOLeHLmQ==
X-Proofpoint-GUID: xweZkjJdj0cUKgCrsL-o3zS_L7YuZEgU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MiBTYWx0ZWRfX+rGFXtzuLBGp
 QXGutfzSnSX9aw/ni8wgAlPd6fTuz1mVWHHTLz1XzWM+U7t+XwOoysamd8rIAT2yw3P+1UyYnPE
 UFVv/j/dcoFE4Fidg3ntgO1zb17RMEk=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a95ab9a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=oMov3bMtrqd5QQYwA5wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
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

On 8/28/26 4:05 PM, Krzysztof Kozlowski wrote:
> Correct confusing indentation within else {} block in
> dsi_mgr_bridge_mode_valid().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
