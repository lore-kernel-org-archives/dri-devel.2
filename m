Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92FD606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fhsA4Yuf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IpuEwH7d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3855810F856;
	Wed, 11 Nov 2026 15:43:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0033A10EA5C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:42:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0Dif3289571
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Ka81IfeeRWUOIRXxY/Mzm37r
 R2+cA3vNQJzHgs09LJg=; b=fhsA4YufaIN+kkNmUeaJjEhXD+Ay2S74Gbn9zVTK
 CL+52LVeQ/1bp/2LFslDYc+04X2tLRxzv07I4P+zXc+39zxf57p5lzyev2ZIhlix
 +/6Mn/DfKG+mBN+cyE5YrV47TWwkbC/xXIOTESGtKSFElRM/Xv7Dbh+MjqQYMjX8
 ND2dQtH85W0vrQlyMkLCLnI9cTpeeoX3TCN2Mi+LfMHL9L3soCWXGC+W9gxjWgID
 PSP7heUFaGzTm/0qUlmXBt4iVwnj3ecINoeUwWKPNGJUvI2QzqaJypFL9a2SQ02i
 lbsDrcA80QUgYI6tkocFBjX5InTBX5JFLkN2bVX5YMhRPA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt150emc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:42:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f32050e72so805012085a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794411773; x=1795016573;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ka81IfeeRWUOIRXxY/Mzm37rR2+cA3vNQJzHgs09LJg=;
 b=IpuEwH7dSnBCCJxUlu0L2sJ/fc8yh6x6Nh522xriJhoAjVzwLQv/CIoi/VnBUKaTGm
 /rSJsyrF4WKjdGuBjnA1Z60V35JPaU39/Rh0NYILCTLSdLVSpdQglLytn0Him+Xht3EN
 h2HlMQIS1JdKuj+QbiaIdS/raIMWAwGWQ1wt1euSktu/SS+QIJpTdM7EvrdgYaJfNZZs
 QgNlap6LEKui06GBoIH3DAMpLKrcjYZuqmLgccFGKT2QG1KjyjoMEQGpUO7YxiJuiHdD
 lWiR9zeWGumaOQO1MpYizMp9ND/pP6BfQCd6IL4jEiF1mviJn5dQRJsV13XrI4UJkd0O
 wapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794411773; x=1795016573;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ka81IfeeRWUOIRXxY/Mzm37rR2+cA3vNQJzHgs09LJg=;
 b=hCYYNJrp9FN2UO1dn6U5OYeNGLcTVpybqjBJaZ+rubO7iuNpMgAR7SuWRy8mdwlGTN
 UVtztEkvob9lD7BHgkBsk/QRqn/hub0N5lecJgMNP2gzwPcyTDx5u8ocdzFP39huk7DV
 Ojygm0cPOWbCx5Tti1CM6cj3kbpBOsbmk0yl2AIBESJc//KMnKM1rV/TJx+xCqbvZl3V
 zE0BeaG+O/MjFqUl5WkWa/8RAsQPb95OiAB2aXwCQIRtu5u2x0U/OggHxYcA8vN/iFIH
 S6/Xl3GhKquh36KbWLLZhukFC9tC/YnDNWKRnihdGsQmUxcA6YKchSD8O/Kmd2995JIF
 hkQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH0oO4TA6DxL+7TqJU29N3+Hj6fBcwE5VbIEsoJPPc7L+bmFlHzJJ0Oj+jz1i+pGKUmeD2vIHLGLK0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Lj/MbKC+4scL+yCcBX/8cGLV3q2flDNbyMJz1qhDv+Ubtnfy9
 Zxhf0piwz3a/BatqEhkAdjp3cd05B/U9RNTqqZqHpd9ZmwsjzSIZVCgBc126rfTvpwejiTqvZQ9
 aZeCZ7TQoleuTF+hG5LmtDI8ukCPM4IZ/3nf0t0qE7nVKe41KWXoqnpdfdQah+oknKmLuIuQ=
X-Gm-Gg: AYBFou3thCaZLFfd9BDkgU/CWfK3klLlDzja31JNkEHb4wCAZacFAGsp9UV33AXu3Rl
 SvcMVjsOOqJfivL8s2pIlM52rvYQGn5rC/xWId9nbopw3My5YcOQJ9GU8sFNQ5hJ3Uli8gbuNOB
 bCwFvdua+PUo6b+IVnwNcPlGUlBhmZCwgk9N9eWeIUvWngASasOk74novpy66RtJ9cVkgIZnUPr
 cRTFSiy8D5h2Ak82U/1VyCINF1C8RNlUU2K+Y/DBfJyc0gI2pmQ49lEZZ+kA1N9l64NYD3Y36TN
 GJCgZvgcnMvP7VV5eVZqxjye7g16EoJsbiJvvlHdfgwIIzUjjBlRztHhW6oMhaRmzq8tba3daCw
 8PhWJZEJqpPF4WUyR28b38o0ZWt3MCe7CKUMitO+i2iLkpnxBpeA+cL5f5dsRlqZilQY/XIsXPL
 kDB9CL5NAPll8EuhiIMF69jCWVIISMzxno+kRtq9RfJWk60FYyGuLwFCLLUKD8cw==
X-Received: by 2002:a05:620a:1b85:b0:937:6c0a:9b65 with SMTP id
 af79cd13be357-947afcd6309mr364200085a.7.1794411773281; 
 Wed, 11 Nov 2026 07:42:53 -0800 (PST)
X-Received: by 2002:a05:620a:1b85:b0:937:6c0a:9b65 with SMTP id
 af79cd13be357-947afcd6309mr364193585a.7.1794411772617; 
 Wed, 11 Nov 2026 07:42:52 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157ba565esm984546e87.19.2026.11.11.07.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:42:51 -0800 (PST)
Date: Wed, 11 Nov 2026 17:42:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
Message-ID: <xih7e6366voj2awmlhdkmhtyn7qrcwsv4ejp7kz6vvszcxdrlt@fyn6e2wnwlkv>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-msm_gdsc2-v5-3-4a3159b5e4b8@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-msm_gdsc2-v5-3-4a3159b5e4b8@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfX9XFtI4toDoSg
 bL5om/Mnc6co4ZKejNQsz1F+gosSKXKYkRRKXUSGA+NtCBtYrhIKS88npgUIorgmlqMvJ2u4CEB
 whKfk0TwbhanPsssiDfk8xufAS6P/co=
X-Authority-Analysis: v=2.4 cv=Yrya1IYX c=1 sm=1 tr=0 ts=6af48cfd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=lIS-3JFwHiDYKImdvy0A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: hTXc7OIKibH88Jjb7bGZS3wVfLSz6Snr
X-Proofpoint-ORIG-GUID: hTXc7OIKibH88Jjb7bGZS3wVfLSz6Snr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfXwmSGXDNoTDzI
 Crqd9aaiK2E92Gf8Y/uzA6IERhboVFDqyVQahgEIEKcsjrSsHALJX3ahloPSIx2cKCwzdVseXu2
 2fyOxF648RcOP/FrEnqbpRwKDPHfkCZD/N4T51ipj3IFQd/Jh0ASa5IcmtaJETCyQj3JRTKvFWl
 nf1inACO0+vcYoOy3vGzkIO+7PupMAER3BC1zhvVK4q0VCpbjW1j0/ZSXNtH1z8WKzGMrhsknaR
 fMrVRWx+rnnykIrNVKjbUMZ70hPO4qRhnam6v+BCPY1Uqxkj79NUbxMV1wPt2NCNh59INhQQNKJ
 IBA/Rz2J8T6KmUHECVZRIENABGQg+mQROL2XEFxS0lW74PyloVWVwc44lFP3p7Dlu1vgnDuMA5M
 NXJ+mndfRfIGlvPd9Q3bgeAdteXgZXF0kYsM0bjW8+oARO0amR8d1lSYL+Y3XDcmpsXMyZWLJKr
 Pyo102/mw19B7uNWLIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110062
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 04:36:37PM +0800, Yongxing Mou wrote:
> The INT2 GDSC on Kaanapali (SM8850) powers the VIG2, VIG3 and DMA5
> source pipes. Without enabling it, these pipes remain inaccessible.
> 
> The DPU is supplied by both CORE and INT2, so describe both GDSCs as
> its power domains rather than attaching the DPU directly to their
> parent MMCX domain.
> 
> Keep CORE attached to the parent MDSS device because it also supplies
> shared MDSS hardware outside the DPU.
> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Tested-by: Joonhoe Kim <26rote@gmail.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
