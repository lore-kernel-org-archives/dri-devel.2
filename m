Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495F606A890
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RgGAo6g7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TeOEq9zW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD6A10F997;
	Wed, 11 Nov 2026 18:13:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB0410F997
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:13:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtbI91400016
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vqwMgBBAIrIccsbaUs5qyWO3
 n3mmYzB8oRH1B9/XhhQ=; b=RgGAo6g7+T2CoN3qbu6ujPRQjGYF1EHQpIdnGAon
 UEDJ2xDBUmAp3zWPanKfxrYudMNGirThmjc8tUs6PVEiW/esgH1KUaeECz3CN4wh
 1oBhS5WHbfBLAle0TBgUTh8tV2RvDhAyqY7wskTOvEPOTq2Zh/RoyIO/haPNoB09
 Kl9B2obGL8k9BKH4uchwjUWdQ3lt54SHzQx3V8WtGXevYremtxO/C6fGKb9mLSS0
 pIdqwlkUT5uA1zLOSKl+jeRqkkhIGAjHNa8f19t4qaFQ3n5ReLTYppKIIZ+js6AP
 o4zxel37UKz2lFLWye+Mk2JcL4aZnnNN06u61ICaDc3WCQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b34vss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:13:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so722411985a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420802; x=1795025602;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vqwMgBBAIrIccsbaUs5qyWO3n3mmYzB8oRH1B9/XhhQ=;
 b=TeOEq9zWX/IBTo+NT2wEoOESN83Ulfda2+G3cjUMUDJxBRRUNju987NIKcHu3JiewR
 MsDYmc3YiiLG8Fs1GT/Zj3w0jRs9unEhJd/oYLecTR7uHXZbSbCW/ujFjPsy70DOUDhg
 dEVNCfqe3SvAZMjhqtwKsK4D64RKkFaBIxulDEaPpXWdYMdpgWR/z+KhHqVnpeSRqGCC
 FNKjrioYQGF8xQcxTxcantoaSQZfVyuDaSHWqiEOw50wD83IuMt3uwj6c5RpOOfecNHx
 GHUY34HmIwSIocLPun10oyJDIF/f5uqUKQl1GthvubWvhVfQQCUe6/gdsM5RvD3OfyhA
 sSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420802; x=1795025602;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vqwMgBBAIrIccsbaUs5qyWO3n3mmYzB8oRH1B9/XhhQ=;
 b=vgkxLSG718z+OeNHAnwJ3Yuzn0v2DYeDLBgDyVH7vE9s5bBq8BYE/tpCEDJQCljIsk
 iHEyP4zmhXHb6WBVbirFZD/9B5dm2jFKEVCRUJbG/3aZyjn2cfC94h9HKI2rN7BC2OZS
 5McZGxqt3xl/8fe3X2MzQAjlT9WMHFzpHpUiuUnMbCLstAf3LtIhWuh+csuFm9SO2L32
 yLend2iv1oC3oT430H8YGAa6zqCLznqVQLbJAZdX4VcRogNyv36P0OGargqRG9r77Giz
 F6QomluJ4qhxQAVP4MyHvo1CKizSNCW73hr4iswLpgJkn40WcZenB2qdlKP7fv7a9X/C
 EpHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGHz+MCGk36dEjC7IvhRNXa4bBmT3597klaUBSIaUizpeRU0aujez+m9Py9c7Lpi59Tfg7nYFR7n5A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9kEM/CpGlNVtR2jfVcgbJuoKhVHZyJBOS2TGcUT7Df/5uhA0CV
 HD5IXVusopRhd/ykxyCB2JMhVfrhaSUrvhUyg/zdBkOf5fhV1xFSyh97J071/uUTDMdRmqCgN8h
 +094OfLUTH6IGbiKojDyKlyUsU+ueyDZ/9WKzTTfVQ+eroBiHuMpHCHCOF+xTCyQ70hRWNvU=
X-Gm-Gg: AYBFou3CtUqYWoFcbzlqsGv2/BIPymCcDWSGdGgsGVCermulg6cO6QhfZEmccQut5og
 CwV/diMtA66k3LeV8FU0vsivpCUfCzNIikUvymkj/tfLmuwdJD9AP7pIDANu+rPB67PQ6wsvP1L
 NGlGZtPKtdvThLBLJ9JTYhr1ApDLX1hYZpKkw76kwPyshNEdpkwCKiT2rFJsh8X2frKQ8JduhNm
 jf60jYINXw8cS5/hQJaUKl0FVYxBoKzWxuO2nS3WWqaugyhcRWyuqI/Cm885xkUu3Vbl+vgwFND
 09IgApR8n99xofSYph46YU5h6rq806rvZXVtT1w7bpaIIV8GvMgfHQMr7uFRi/RVQvZLB9PXkcG
 uJk3HEYDlSABDNlPMTFCaxQWZTdZ9xa9qwvjl2FmzCADHPWb6rkOopHlFQ9wS8M0gu3srOhK0qn
 DCSRvWN5269pA7hPw+vdPsRIg4HZKDuUC8bM0KYXjKlPWP3c7A1qQsi4oJNuDaSw==
X-Received: by 2002:a05:620a:4544:b0:93c:9d56:a860 with SMTP id
 af79cd13be357-947affe689amr564277285a.19.1794420802134; 
 Wed, 11 Nov 2026 10:13:22 -0800 (PST)
X-Received: by 2002:a05:620a:4544:b0:93c:9d56:a860 with SMTP id
 af79cd13be357-947affe689amr564271585a.19.1794420801627; 
 Wed, 11 Nov 2026 10:13:21 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae0924f262sm13151041fa.22.2026.11.11.10.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:13:20 -0800 (PST)
Date: Wed, 11 Nov 2026 20:13:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
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
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
Message-ID: <ft3rayikzieiuttoaqz7lcgv2sgn73cslgh6urur3pud57sqqg@aouonlfb2klw>
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
 <20261111-display-msm-of-graph-v2-1-fdf8fd97f49d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-display-msm-of-graph-v2-1-fdf8fd97f49d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af4b043 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=udFPpGrmtiWedX3Zxo8A:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX9DLksatq2bPc
 S2S/dxwQUxqWf7yWAF05ABytddf2vQEdsmsW8LkczTcny0/PAPXfLMP1phMkwZU9W+OMZJgJsx7
 X5NHRhGUuu9HIYGoBiqjslAlOTha3RhBzXCV9GzKKA66Sde9yEKu40aWbOpZZvQLj9Wdmf8Edrk
 465NrgJZG4qJFf6MFY3cVe7rQNS/893VPJ4wmWq7RBBp0doJiNRCZQJNiXeBovXIPzll0K6xugf
 Ak+6j3Ul0IUWfqmd3RQk3fFw+K+9X3LxRIU0il/oayOKHIHVLS7JWQxn0btYgCkOplDAiHgtu6b
 zt69XOcJGWhpgeUvVnChrULIIZKu0R7xkexPsbYsjg8HQXbJY+ywOVaxfUHQ+9Udnw18pT6P2Mx
 DIUM+7GvSeW9MezlXui4lhxfH/Ts/g3zb0CZ9z4j28y3aZoDQHTEBWFWYqbZ2j3z4PBUIdqnmW6
 oJ/QK6n6S6uHRKV/D8g==
X-Proofpoint-GUID: Pk6ZgtfctByl1vEbgT0oPuCpF4QDLigN
X-Proofpoint-ORIG-GUID: Pk6ZgtfctByl1vEbgT0oPuCpF4QDLigN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX6qV8Z40gZqrk
 q57MFkwVQubFn/yWAgnZv+sxpmrkRqslR8gkmNIHsEPL56AvBDZ9C8mBFevPZZlJAK0GVGNyFPr
 fehnmi53LTwgTTeK1v+DPrZ4hPC7CWI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110072
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

On Wed, Nov 11, 2026 at 06:45:00PM +0100, Krzysztof Kozlowski wrote:
> MDSS DSI and DSI PHY is useless, when nothing is attached (no panel
> description in DTS), thus should be disabled in DTS.  Linux MSM DRM
> drivers will also fail the probe.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts               | 4 ++++
>  arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts  | 4 ++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts   | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts     | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts      | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi                  | 4 ++++
>  7 files changed, 36 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
