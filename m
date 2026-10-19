Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F22CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731AF10EC8A;
	Mon, 19 Oct 2026 11:47:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B4A10EC7D
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Or4o1665440
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DA19jX9AB0uHbCWwD9Zbkxsp
 a0JfxX+l+oTCDhGHnvg=; b=XW/3WAhtWkwvCLBXO/vlD0QZ6tpeQ3sN3MTurgTS
 OxtGoYo99+/xkRlscU80YeHr1FgogvIN4dd5HV/rt53OdWbEVSDqM3X4XbcG94fD
 gLYmZGjQu4xVzU4IEVSP9Sgss94Lre2m5cDmXuV4Vt3iz8/oq9leUu0DK/20x6tW
 Z9GvJfHnd43p27MVk/MD+s/hC7YyZyjyWLIMCHa2NKhW3y8jXGRmgE38X+vLPQim
 7/Y+9OqT4cprNevEwlJoMG2NXGmUbzC3DeditX1IbIvQVZ+vQysLMasPFFit1MOk
 ma0d6KgTKawpeQZyVjP7cVVFoIgtqWdZpkqE0gfRV0khtA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0w7p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so406870785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792410444; x=1793015244;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DA19jX9AB0uHbCWwD9Zbkxspa0JfxX+l+oTCDhGHnvg=;
 b=VxYNTARuDLuyOv4RTAldy6/UvwgiYWXgi2vQ67BI+7XylJRoG2xqIJreaUx4dyX9iV
 KN9Mo4s2c2a7otxRET4RnfP/RbFmCnbDTeFqyL6YPTNmobC2KpI9lCN6ZbqjPE9unpDn
 rw2tCpxt1HZL0ZQx7jckNXaLPG9RrJNsuhbEwJKYxO0Be1tR5NxCTF/IH7JYd3/V6PQi
 bzIEpgpUWIxqmZshxTg5xTAcBxU9qJ5rjDw2bae6BCu0W177zbbTZPSxiUK9CeZ6lfZN
 URio88J7LQtZsbqsK8RGIfgvHzvuaJXiFTajZAxpacOGcg4dcjySnGkR8IakUSHbB/WX
 lt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792410444; x=1793015244;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DA19jX9AB0uHbCWwD9Zbkxspa0JfxX+l+oTCDhGHnvg=;
 b=KRTMREfHTzbFuNfQKuyiJXg+R4Tjsb7YfZG8cvMftSK9yOFlP8nnk2larSHBaI/KHv
 6fBrMO/joD4crg71gwpflLSm36dfQlyuLOJ6X1Wce4ZP9qQBqgNJito81wIfVUkClTP6
 xwugf8g58tof/dgX8PrutZtuBOiaPd8djtijYXTrGbRmoH4T+GF/UaNaMJBgKF6kc2YA
 Ke6De+iS9Kof74qGOquGjBO4Uo5ysO2s5SjUa8oMBU5mkvVGsLQSKes+PKJay9QaoC7R
 mMlPc7pLtRqPsagSLxRv9+haY4IoDENl+v+p8wVd+5WD3BpYzngJIjcwDXdsrcy4Lp7Y
 owiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByrabllW32oa8zxbE2nnsvPu4PGOB7dwS71a1Kegp6Iv0+Eo65ZNnu9ye3DLXr7eVAX8WSwZY1dWTE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJxPFpwsxk2eIsaNZnHD3siPli+ClsYRDCMxuX5f7+0EOBn8wdD
 uhLkCPAatI9cebtE/t8p5v/iJAIJExrBVT88KGEAH/BuuCVEmATlV7lObX2Ufr4CbuirOPHZSAp
 yhOpNfpah2MyTdKcZufReJZErX/CeP421ARoPyGMpZQq5ktJz0ch1aRO6FascJkShuROiBes=
X-Gm-Gg: AYBFou0ABGLHfD4w7YrdEgoB9/kWokFqUiD0oxs5gVKFM5Ms5Bfsy+jjDZenKzFrfm2
 DdigSqSNyOD+YIVJitAxWUlF02eCG1ZKZ6NT+yO4/e3wDrWul89xXryRbaUFc2EnF4p9HBlb2AX
 iSnRsdOS8f/8De/O7Q9/ppx9J/G+txO5oNrqcB8aL14lFUBT1wZySbcYE3mIKC7VZr6Eml5ewfv
 +xMEeNuUKZ30b3Mq5GJmFEmhHeArxqx8d04jhFZGy30gJKKuYLgFeynYeHZ8BP1n9+C5PU8kwJ4
 qsa2xs+e2QmqE5Fhxi8NT1hvJw0qJBV9tBhHghL08iUelPSyc9UHWB6fvdLIROG8+lCwJthK2a5
 JL2WafqE7Hq4CsXPA
X-Received: by 2002:a05:620a:4042:b0:93f:735:6c83 with SMTP id
 af79cd13be357-93f29da63b5mr1143958685a.56.1792410443678; 
 Mon, 19 Oct 2026 04:47:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4042:b0:93f:735:6c83 with SMTP id
 af79cd13be357-93f29da63b5mr1143952685a.56.1792410442992; 
 Mon, 19 Oct 2026 04:47:22 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c575esm19986031f8f.10.2026.10.19.04.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:47:21 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:47:19 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: pm8150l: add LCDB regulators
Message-ID: <gcsjw73m5tj42ftvhyckexor62waf5eydntycyy5qm7ubkesn4@qgr4ratyntfw>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-5-86c05068efc5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-sm8150-display-card-v2-5-86c05068efc5@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfXyopG8NgEzmBx
 Ao21GjJCEVD207qMx5V25KDrccBm26Dd7OwmeIsCwdqL89yyfVPltMlRGydzrbwb68rLMXEZLDv
 zDrTXTOoXdr7hGeP1vBJlGL57bRkvU4=
X-Proofpoint-ORIG-GUID: d_buHh4ctb_SriIfuBjrZpPG1YFFvE0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX57hB8r1lr6Vr
 2R1anRHvqBa1Ru42BEDjCM3mFRS1T3AWuhSlbWcNN8GTmljfGp0Of4VdXdc8lM6vbttaCfx8/nb
 JKkqtOkNq7xMbeZJhCo9FwHeHUTPmEU43DgfSS4y74Zuo5I7cyxIYBiPOepLWOFMlOaqYgigTJo
 4OuPJIx75y87XKZtM0StNzgqsO5wXZTO0l8CQ0n21wko6MCFFgz/qoaMQoON7CJ6rc5O0HcS+WJ
 dFEIiksNnOTz/V1IOBiEuIUG+oE4UTGuhlCzu2J+iOLEVf93woR920IL4iqHDMIrxf5FQpTeA/m
 h6CsvTb5st5Dm+IikJz1JY1uF+Ul1q986yDoW2O2Y87qW0eBJjPFilt9EdnPksYjsAZHl2KvDtq
 nrH/3r2fbh+uLsJpLb+rxBxGxjapvgb+r6GVDa36LmZIbqZ53V/JNVm3oz5aNUOTsS4NU6wgZmQ
 Px4N5yZtfmKmdwO2gnw==
X-Proofpoint-GUID: d_buHh4ctb_SriIfuBjrZpPG1YFFvE0Y
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad6034f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_xPOIdEwXcuG9LIM0_EA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190046
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

On 26-10-19 14:25:41, Dmitry Baryshkov wrote:
> Describe the LCDB block providing the LCD bias rails. Leave empty
> regulator nodes, forcing board files to provide correct voltage.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
