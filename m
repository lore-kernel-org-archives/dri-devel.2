Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70149C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D7310F9BE;
	Fri, 25 Sep 2026 09:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pS7VbsZJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBkSqyUX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0905D10E9EB
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:49:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5IvvQ600642
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dShaYj6eGbKvY3hQV0EgAQMx
 UIovr5wyDKrGsMRLtVw=; b=pS7VbsZJR2wW5lF4ZO+y6XgrWEHrRT54ZM6BDE4h
 cX77vmKx9dDZ++zzszMDF1tA5m9a2ld1rJf9aKbPYWfUXllmZ6wmv+7UQNe7+Boh
 axoTH1B3Z55UNyOrcrXRVnFh1tCCYMA4UaEUnU0usIrGiNCkYXIlhAQcG1llt+iR
 XXGSOODUWM+C1svBBOU2En0jjijXaRmiw60+Qbuz83VDwnD4P7Ma6Qb3y2h1ghdQ
 Jlue2/cjw6d+IHPw5TWpvVQVqQ8iGxtDxSEYJzgPX4e70Vxc2hlHFG3h+e5TqzEu
 5MLSQ/YEgSeQSRZQkGlFqb6grxeLEyQcZDyGTSU+BCUgKw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvrt5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:49:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90c8da50f8dso15571516d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790329789; x=1790934589;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dShaYj6eGbKvY3hQV0EgAQMxUIovr5wyDKrGsMRLtVw=;
 b=eBkSqyUXaDj8uXuUdstu02C/1mZ+wbPFvhTsEINhfnu7L7GCOzkV71Nu3DwcUb9u3N
 YYJ6nZo2vgDEWGI/SPepUa5Jx0UX12mHwlatschYIDhIu6ZYgar02pmZ7Eso+5slab5A
 pufkRR3dM3VzHl2O1SbO3C7/rdmpVMSJMrJjZdZ3fH+1DfhVGD+cPKapf34cd8MOvr8U
 BOpOwTY605SXyehlu8W7wRsr6txeFBVK2BPcr8eb6XkUZZTCCd71A43+4/wM+PJPSwy2
 sziXTqnJ6V56L3hS5Y/xRNnCQT0f2C9Ueyvzu7iSRBSzmxZGRZnMdxhwXBq5io0bPRyE
 JicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790329789; x=1790934589;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dShaYj6eGbKvY3hQV0EgAQMxUIovr5wyDKrGsMRLtVw=;
 b=18KkDvX0ecyyV/1SIVa49mbLaKV3OMRWtCRb9RrsMWFGV7SnhfvLmUjs/LhqxeP4kg
 TegxzLvUV3f9YCULrWlRXt/gwAzT4HOv8JdrQsOhK0owFuMi2bbyoji92Yq+KLi0c1Rd
 ZmoxD4efpp2VzxWUrGnu6NGULEJtWB5rHh+PFAkm8TX0+3skeoF1sKVf9eOB4pIDXlLn
 ciHUuVY4xtZ2nAFYBymT+ScyFJzG0L4IuFK/ZqlprhKNV+btYjqYNQdBBpCngt1mRPWp
 EaHVeUQo01ui8AQNs6Lb4P/w4SRd27G6MuqMCqbpa4pUQemmumcx0hcm57eChVbxKeig
 zA+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwG/oPbMcaPVlGoL50Fi1z/7HdDrZD3MPvpMsW9T9KTr/3P7povCKiAX+RAJGG0py7rDa1MVrp6GEw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7Vo27vUcNu4rfCH38przeXCgZgFI/valEQaTc2uO9SlpR9bs5
 QVIrlvFinaIOUH5/qrEMZPalB5LQrpnQc0REny7qkOzt9MIrFUvFzDYRWopaFGC9TS1KgTAHCjV
 WE/ijh9mUB2tsxiusKSH+TKUNyf/QMX0l7H6RNndjwL35nwq/Odrl9C95kFfpAWH+iHJ+mYo=
X-Gm-Gg: AYBFou0U7eC07SeVa1xk6ezy2FQzdC6LQsm/8jidGA0EEe/USyjoqbShBDsFJ/nbR2j
 n5wTQfPTeP1lt/Olo3BeeIOdlkv+/3vbjpjQ/IwzrJ3LZ02E/mQMWk2Ux/pB9XFOzJfTImE2FLw
 dVEp7nxHmr8qFye0HRiYgmInZVWiKtEZ/tywdGQe1TL8aSzj1PcWX5i7oz0IABDoF9p44unFXSj
 ct88gruT9NxUmUW5VqnRE/spyRiEWVVidDhrQ+0LdoCEs75JFu2RI9XZ7x/rVz30vMtT8v2f+kn
 0SynEBPP+TM0vJyNtS95OrIF/qTBDlllwenpbNY17c4i/uJG2D56+WGawhjlIRpweEKaAh8qF35
 xpsJscd6KaTSuQsg=
X-Received: by 2002:a05:620a:4398:b0:93b:d7a1:ba0b with SMTP id
 af79cd13be357-93c4752c7ddmr242440485a.54.1790329788770; 
 Fri, 25 Sep 2026 02:49:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4398:b0:93b:d7a1:ba0b with SMTP id
 af79cd13be357-93c4752c7ddmr242434685a.54.1790329788186; 
 Fri, 25 Sep 2026 02:49:48 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0658747sm53094755e9.1.2026.09.25.02.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 02:49:45 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:49:43 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: mahua: Support GPU and GMU
Message-ID: <lptn542jabpanhquit4yyq3rylax7zxj67nmes752h7hvmxbjd@53d3tk33sslt>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
X-Proofpoint-GUID: 8X6FkdN3bulnjiuw1sBwUgRwY3az7a9s
X-Proofpoint-ORIG-GUID: 8X6FkdN3bulnjiuw1sBwUgRwY3az7a9s
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab643bd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=aW3lQomTbxCpPOFa2w8A:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX2wv+dcgGbheK
 k5sSwQPcwi5otjO/yrrpg7gbSeeft37rRKn4PxBbMb/ywvPyiO/3gUlJ3Oo1SFqwleN041eCOrb
 B5pQhUm12KXvTmn/cvd3i4Xdv/dkXuk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX3o8NH3cLPTjg
 iSuJjm4ccwdhIQqgP/KZEtMKsRTb6/MUs6YPJdhkmHwzKXZlnn9cvkV34sYKT30WZ0NVMCBXRnK
 468oPVkUEpsvI9bSwh/gG7/ytfTG4W6j9Pmvro6LqZPKZmHXq877posUkxHxbc0qnX6Kx7irCDv
 nu7gY3EWg0avSXrKvrACGvREoirXUkarKzjaV1ixDCnEC8hUOP/oRxQZ3uE9Ce9E7HHKBNbMp8q
 HCIT8YtbQfrDMM0GuHBpC7Rlk8puMvv9W2mw/15zZhYeINfST0BJCRm/NBXvCEWYu5SgnfoZzCc
 BE3KqjSyoUFPK+cuhOgI4CiXhWOlaCpIYNvRLEggMffOIwuNX0gD35okTFNQ1RWievfMI14271b
 lT661Davkk+QQssKDZo59Rl/sQWHqdttYMX8VIZ/gpG+fMSDN+ulCJjsDyqbry5jF1iy15w1Wjl
 Pd+tyXx8p09AaxRqsUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250039
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

On 26-09-25 02:44:36, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Mahua SoC has a new GPU called Adreno X2-85, a slightly smaller variant
> of the Adreno X2-90 found on glymur. Override the compatible strings to
> correctly support it's GPU and GMU.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
