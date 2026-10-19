Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F67CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369E110EC81;
	Mon, 19 Oct 2026 11:47:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97DD510EC7F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OlTW2234089
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mSnBA2Qem/ruoTNLx5exIMDknp1eEWtUaIxZflIr15I=; b=fds1VCWq9ZZiUZoA
 34xGZhm7jCAyiKBN4O9xLOvroe9NE+XfBXSaQtlVn7+U+h7ZGkyDxPR0W4CwTlL0
 7BrYcJ5xwrb//skXLb+ynXhly30joO1fh8LdGd3TFO2hpX4ycpFsROyN6zrJeXd+
 fzpiusdg+iBzjJSk3sLr1IC5Rpcde21f31a5AOG5ahhHvqp529wlY/EdXgbGRAnw
 u4BOdKijcEEbpWBwXsy48L2JCPitLnBA5ZQmfT/jjEWy2yYN9n0e2z0R+SgQCvsR
 z4i8/3t73LZ3NCx9tBEwCD012L29DaHnbCZ1UkNOhkxAi38fIe/uJymYzdjiZKtD
 5FoL6w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x8wj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:47:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb1091fffso18217585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792410449; x=1793015249;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mSnBA2Qem/ruoTNLx5exIMDknp1eEWtUaIxZflIr15I=;
 b=gh7mjFT8QY1QjdHHd83jkspvuZlJjtzwq8I629dxPs7EnnE32AewEHwHkRgzaFhLH9
 cAOOohWcf/PG/qXWzJiiU+qmRFfDvHObQ7fmMIdBtNDw5Puga2wgocTNAduVvQWtECxM
 +Ye0QHEhxikYallcigdTHE3FB5czqK836yL7KhpR9/UkFDo7SKfBsTLhsCwbYjjK+9uh
 fdNuh6ACgB5TR9NVzsS81ZNl0XKQSU1jD2B0T/qNYy5w42jXIX/yzl2zpmiyhmq2EI1z
 NIqqsSae3U0u3pI1cyxmH8au4NcPn2HZk735FBrklinGTzcWWUp7a2WRyZVxp2bpMAem
 mxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792410449; x=1793015249;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mSnBA2Qem/ruoTNLx5exIMDknp1eEWtUaIxZflIr15I=;
 b=v28PCVTAQvJ6P34EzqLvp+tvE+TQ4aww2BcJIj+ginU/YXncT9+6PN8G/LYONshvNI
 1D7C0dElcJm2WQQlp+IB+CqMkZ0zDh1lMDkn3TWyJAHsTPGP8D9j3fJ7hktuhj7WMDU8
 iHzQDSoRkzTkdYhdgVCWscRDdAGAnttpRPAJpJ/reUaTkzZztMuMkH6bmTEHOdPpUIIB
 NlAJM3pHcfr0jgdJinnZ1myvUMreHm2FEPxtJyngV9nIfm3Qzgm5xkUAeunI431f+7Jb
 eYv1dTnQDOvbFQKWFB7RdOks84bvUks8eX2jBxaOwlSrudQsUbT2hIpHzTd77xzWsYkv
 usxg==
X-Forwarded-Encrypted: i=1;
 AKwUvByMmlK/BLGzy944HID7fKQLECuHx4ntR1OHTxTXO8yIyzNZpBxaAfDG4xrhzZCmNVfcolJ0Z86+zY0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI3clIMiGCRMQ0uhT5XitUcCAQPs8FRv1qpE1ExIMiXqNAVeObp
 nkP0bLYpN/bI+eo3hx4ccj7UP2EAfuAxafnlic9QHL+CVirCXAadSJtm7bLcZWDUb8AxBXdm5oX
 O0JidSFOXz/YHnXkt4n+BV36KT9BphVFI7P+fsE9pD4Zl65OrulXKq92ST1FrFBq9hDwGSik=
X-Gm-Gg: AYBFou0waSEXggfI/sTl2+zGdCmjOOyFo6Od+H/SRwUrOY4enpO+sRxJuZDwCfkaNQ7
 x5rrTYrNL9HoRoiCXrcRTsfZHeSG6QxTSXxbDC0llWJcoVsCDsXcMIB6eN6DbzwfijQf6v2w5Bq
 x5uKdO5+ilan/29lmmrRA6R1AZxIF89ciYR/RwbmKf95W/Y+H4w7K/h8lb78QiSt/wQMsPQbSWU
 4Q329tsL4S/XsUUHf0lPpriLHsoCM6hH41rYbJY439rOW1fXMKUK/gEzSHDqiZ8H9FBdF+aOQeV
 wWK0oKKkrxjoklEqNLChK9FJmPZpKzhjRioEot/vpvAAYbpGNSj8fslkMC/ckU35fbUGH+ohhdK
 m3jIZW5uGHafxIjgerpyxCQ==
X-Received: by 2002:a05:620a:701c:b0:939:8148:1e3d with SMTP id
 af79cd13be357-93f29bbec19mr1384648785a.2.1792410449152; 
 Mon, 19 Oct 2026 04:47:29 -0700 (PDT)
X-Received: by 2002:a05:620a:701c:b0:939:8148:1e3d with SMTP id
 af79cd13be357-93f29bbec19mr1384644385a.2.1792410448717; 
 Mon, 19 Oct 2026 04:47:28 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40919bde60sm338607366b.60.2026.10.19.04.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 04:47:27 -0700 (PDT)
Message-ID: <fda445f3-8d61-42e4-bc49-c4d5715254cf@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8150-hdk: add display card
 overlay
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
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R-aycPOhHms2X1Qxn1NAL3SbSxC9f8yf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX5u/4I7nMmAEC
 RCFwmAsPj0ig+X6S5vtHd4H1SX3pyVSOLFO09Ek9lrmCtBl8NlP0gbf3Oi3O38o20VMIs6hbIBq
 jf/yn5Pnc0C63xOB71yOfSPkjjF5lQM=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad60352 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=oyhz4BWCyAMKXFkMYugA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: R-aycPOhHms2X1Qxn1NAL3SbSxC9f8yf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfXw2tCuQ8PZBvV
 65ouEl/MK+PCh/83cqaaTwUqI0/nayrQpHcjzk00nxeET5q4KFUZtTiCVIXaeIQHTms0Uvn0v/I
 maPdcHMNg+uJWdTw2i2Zx6UEKlbKX9BrLpvpG+SMf4i19phrXVfOfyDy02og8ZYE6oi+AiVv6WB
 kySAZ4aGvDmzaQCeAP4wS81Gp7NenEPSewyTI+8a1YlK3ZnmS55EVb6bTMH92vPtqeEV00GVqgg
 pJ7lcX79GTqkbL2X9Xr2OfFq6ypLdkcinylwqZypRwv/hAw/V3EiSxa+nhIBuXVC92jLtkPK5lk
 Voavp8luWp4jLYgE1PTeKqT1UA2x6Bft1ZRWYU1RsMCJ8B/SRq87g2vkmbSY4fdGTToUVD+AhIu
 QmZl+3reyheBMV8g3PC5ykMOnE88tLV++dfLPPzuTBzxH02hspcl47nLlkX9+UJ6JEjMut76Cl9
 zzR15I9+KTmP7mxbFDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190046
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

On 10/19/26 1:25 PM, Dmitry Baryshkov wrote:
> The SM8150 HDK can be fitted with a display card carrying a Truly
> NT36850 WQHD dual-DSI panel. It uses the PM8150L WLED for the backlight
> and LCDB for the bias rails, and it is mutually exclusive with the
> on-board LT9611 HDMI bridge.
> 
> Only two of the three WLED strings are connected on the card: the
> backlight stays dark and the boost runs into the overvoltage limit if
> only the third string is driven.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
