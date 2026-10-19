Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C41CCF2E4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB70010EC7A;
	Mon, 19 Oct 2026 11:47:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9462810EC7A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:46:50 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Orpn3256604
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wq7xqxfmXPZkOoAo9wJ+7Vs0
 paly6CmBu1OanMzWHA4=; b=hqhkTMBrFAMM76BtlZZFoX7pQGmmWKCVYbNC292q
 kXd/P00LzcmReia+FM3AlkQkSqpziCdz6VuizoK1+MTk78YtpHYKDACngIl8/fGG
 s2UqnSSrORZIsqZVHYC1+Vm2JsWN1dUOGCSVVtk0quNBAO2KoK4rtzd+UFqEktGR
 etojQmaat1QHyhcGFFuI/0QAxdrHotkI5JWV0+NEcToq6QbypmxwvkQVdptSSZS/
 VQuvIKNJKqOw7J71PRoaOenonVRjMwZ5cFWMTDjIlQKjahXVPbR0GM+mzyzXdDdP
 NOgVWn/QjO3yi7Rm2Rrz67BiEuI6jo5SKjGFxAjF+/UqgA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8vx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:46:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f32050e72so571502485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792410409; x=1793015209;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wq7xqxfmXPZkOoAo9wJ+7Vs0paly6CmBu1OanMzWHA4=;
 b=RcdX9xIMd/uTYw5adePks84Tp8QwliOaqjQaTMlwrjWkA0qeiG+Lh+gp9heyOT74Jp
 EAFxkUWz7kcmeknm5Kv/9pxEUQ5g3HHoQQBbg7WB61K/hvmaq0BD3/NKrQSUHa2eeb0D
 GzsL0kMc2fQXA5DzTR4l9ZuWqHyCfyRDJ45xI6NGR7jWoiMvXVr0Q0SeCVAqIHIBCV3v
 ZJGp2DuI9cOdbarfjXqD1puZyoKCsmIv6NRyHTiepleR91C02MtBiIaU/vRBNJDvccdD
 ZmZ6mWR6e2MQfKzF8MY30VZ9ZuxXUzZDbz7PnU/XIkfA2ulYL3QRAetF9mvtwaBswavn
 WqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792410409; x=1793015209;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wq7xqxfmXPZkOoAo9wJ+7Vs0paly6CmBu1OanMzWHA4=;
 b=sFR8Tl2EiSkkzpBAvWNXXsaP3q+Gc/Jv1DgDaQtdoqduEYO1iBxxM6wkhJp/ek99Fn
 AAicls8Zd/q79tHZIAmlDyohuaOwsl8axyfW3gEKD84KVJDVFXSekdpFcI7+wNHcHN6p
 L124PJ95nEljRi8+nEK8V7phkp7CqkVwEL3ue1ELagnJfA1qDQSXwqEDhw5wPlg2b3Eg
 KBo1HbvxMoJk4MBn3pP0UU5FVaOLZu6dAQglDzie1qRc3rOJkwH2M0fGTSbBfccG9Z2P
 r69vGbx0KXgdO+g2Arb2kRsjoAooIOavGpzdYkd3luh7MXMZIwHTP9qXqjH37fFh676X
 zd7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSSil8TLAz1GgxpMLnw3GnMIsoOeFtYtQPjm2Od075dBAJ1sWX1eFTeNAtB9l0T6+GSZDtsirzYVM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLoi4LlRp1pGNGbRJAPyMwXJ4d3VWA6qtN8ey7wxPw39XS+gtdv
 UmsV0w6e/saBEBcwZRQXC0Z2B7TPnRUZdms4rg1rWSBTESlaUMIsqzbBWpkJrevOIFKhZsTdzYZ
 DDMVlFYQB3xmiVRqN7Wv1jKC4wd8tWhC2FWt92x1IiBPiTFYnRkkJQ1zi1FbwD+on6++GbwQ=
X-Gm-Gg: AYBFou18T2Vk8GHURPu7c6+vIoW7wPZR5MxC92e3uffALOwgffeuywfOndprFM0P2uL
 JOT8D0/5RMcPJRXXivCh1azPuy8bb5pN7J+zLhKX3Q5yhU/BbptCHMJipF4lHNrwCjSOLXWxcKS
 nXWTrwTSsldLddyKwS6f9W186wvYfntf+/RRhql5v7EyWQuB2KYGoM294WISQ4XD0gJSkZSr6lN
 hlHns05SQyEY2ce3PNdw+b4mUxVZix4EHDx2ImPb4usjwy+RPOVssUsRSPN+qFPJHH3KCdAUR2O
 ShFBRrlLBObrvqrHDMULaXlryeL97zmfyMBOHY6mP8Wf41LYJDhPJTIdXR1LkC1MTzjIHOoQUSZ
 RZ8ShE2f13/w7Jdfk
X-Received: by 2002:a05:620a:390d:b0:93e:4ede:8976 with SMTP id
 af79cd13be357-93f29ccf82dmr1357035685a.26.1792410409007; 
 Mon, 19 Oct 2026 04:46:49 -0700 (PDT)
X-Received: by 2002:a05:620a:390d:b0:93e:4ede:8976 with SMTP id
 af79cd13be357-93f29ccf82dmr1357031185a.26.1792410408368; 
 Mon, 19 Oct 2026 04:46:48 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e9423f20sm58333795e9.7.2026.10.19.04.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:46:47 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:46:45 +0300
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
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: sm8150: add MDSS reset
Message-ID: <m6vg6jper4d7npmcuk2xwraitcprdvuuxsznyxgft22ankdxcs@robz3qiz5ivj>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-6-86c05068efc5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-sm8150-display-card-v2-6-86c05068efc5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: BFCa9G5U8HeZxG2SpVRF1Yb5R5ucXJVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX0OLqzrlJT1Ni
 v/6F0EKvuMleG/5uYaLNCCZuCQ1AANZVB24qCG3ClfFcHoNbWWZQ/6FWgoGMPfQZ7Bsy/vB3XiT
 DKTcjZqj5mBH6siFRam0bGN3n4nZj3SOXNPE/n0kQ1EJm2M4PRO5fqqfN5bgWRUc/CoEcyI9NSL
 8mzhfFapx8iN0xX+N/aOB65saHuQwUiF7XMAlnENXxg7b0csztD5t8v+8aJ0Cva/Tfj4QDPHoyE
 zFNJXDx407n7DShnCjFTR0secFTlZp5MEUhat3fmLCJ2fIDbr9RVrl3SFCs/n/DhAHsi2YaZdZ5
 KPs+d6OcsFT2PPLDA9HXMmsSIEZ1m+1r1SQ+qSk5ey/bChlenSyqZhCOZd518emEYFeTRpaiQYt
 t3XQBX4GvKr6rU0/BfxcVlrBF6hPeBiyeJwBmETqQyeUqt5kDoV3XJYW6eu1TxDJk1K4+tkDy6h
 VyS723PPO2vQpdcFSMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfXybOHwIIPYbfn
 CLZqq1hJvVfggWlbRVTNpY+P2/nx/fInUpIwhE85gdQexmF02O0ENyPUOKBQe8fVGxfHJt++OB0
 7cSN6cDvXZbsNmzOqkNZn3epuZUCvSs=
X-Proofpoint-GUID: BFCa9G5U8HeZxG2SpVRF1Yb5R5ucXJVE
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad6032a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8OGljtfnZDXdbyEkLQkA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

On 26-10-19 14:25:42, Dmitry Baryshkov wrote:
> The bootloader can leave the display running, as it does on the SM8150
> HDK with the display card attached. Describe the MDSS reset so that the
> driver can bring the hardware into a known state before using it.
> 
> Assisted-by: LLM
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
