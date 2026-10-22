Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78073606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jmp1SGKl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b58Jl7Hh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3EB10E3BE;
	Thu, 22 Oct 2026 10:13:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB6A10E386
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:13:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M9xwSi1962204
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lc4RpHjBbggsGE6BQ9ENCcFM
 CUrX4E7aPdKaqKzrj3A=; b=Jmp1SGKlOyA6TeaW1G7X84+B4fb+5UsDjsPVJZVT
 lJJD6oPavf8hKUrCcJoZHe0oQm++IhutkQKSiCtOhNsGfvvGVpIrtVdDdNJO0OlR
 V8CQPhumSfEZZpB8br0wViembKYiLk4ChVZQJuv6lSCP4rej79AuYy1dfBfU/Qla
 T+6W/ZBEgNFTDlQ+CwK+DcalLqKEVbGCZtK9kC2zGrarqeCN52QR3gOMzoLPOTkh
 ihPg/9hDf0O25Z5wqj5RbvkCehd+gtRIZGnC3iNs1DZiL3fYbwpWOEkN1KE9jSc3
 tl2C7LJeUUxjjxIfIvVYz7PKPhLtShQTG6Qr+PsF35NgnQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahx6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:13:06 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c0f73807eso26287736d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792663986; x=1793268786;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lc4RpHjBbggsGE6BQ9ENCcFMCUrX4E7aPdKaqKzrj3A=;
 b=b58Jl7HhkR2LiYpeBWV15YSBLlXyr6lwbtqeSuAynyD/j0zemHAyez3EFN1v+Bwu3X
 P5Q+ojNaNthgrK+yWzOUq324vp3Zfwy4gL0vjCC+VlH/zvmjlNH+ZwV8TrK7gQoT6XBc
 74QXlBPw/MPx4EqSnUn7O651P2w0k5QsxuXk4VoDjll9FpclQ0weGihc9HFLnDGRwoEs
 3labgKy0hGgaUwIl7Nf4s7eCRg53Ks8I45GXUGg/kgTlBxC7T3V3tQ6kZXp46FAYkBqU
 asv+mkgg0yQJX+a+grJKLbyTM/XxDl29+2gGdo2wPiPySBptNxaJS+QucrMVQqVniwuN
 SlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792663986; x=1793268786;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lc4RpHjBbggsGE6BQ9ENCcFMCUrX4E7aPdKaqKzrj3A=;
 b=oeQost+E3c5T7N534BIr2inNE5DKd8HFnGpdlJSj0TCFseGTkK8QtzCEDj2Df7ekXq
 BMOwjrV11PtuzwNvnWAuDmYy/wYonde69vlBMBwcsPzqfHA4/HQXo11YLVnfBDcOt0y/
 ToglAZd1yBPqx7lWEW1XFeL/ufuWq8tuZMjjbT0w5JSS2GC2WqElym0K5nnss63kr+5v
 1zzFJYb/bSMJOoVMv/1c61HKj6npKCscebIwhN/Fcj379riX9XXAGuXVthFwTA1f1G6q
 t8nloCAXSMOoMcghhXU26RNnPbQVbFp2UDkEk61okBoYNIOGhl45v9mzqH9w9C0JDC9n
 BS1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4SKSW0fzcmZQSmRPHSuAc3CYpovB88ZQY+OdQ3hSNunmVE/fmHG3cAnRaCbZVGwzMNKdoeDmBEEI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlwbyV3gLNh+Pf2Y716D2SKR/ARvEuMsRzVC4UAyEQSwoDo6cw
 Qv0AQOpuGjFHsLs1m7oHQzQPPOUwLXkGuJnGLTlWXUpC5d0K00NaG7uG6jyNnh5xmt/GsOmC8GT
 vUQxJqlSkk9RMSxHE/8GRb0TjJqp+zhANGs0KnPbixiYau/puuh2zvcEJrfz2ekoLjImAxt0=
X-Gm-Gg: AYBFou0d+P07XHkomSmT0OprAbdP4RljSYpEp4d00Z+yVlPRzvgKBxnYJliBaVNf7Rr
 08evTvSm5bIAmfZhgydokldeMoeL0VXbnmGL1a6hkjzlOZ9UEZKnFfynn4hJEulr9XRgcW75B6L
 m6No7PMYbPWtvEEryhnZyMrrfoGuHaKMz9bk1myGuzz0csze05fPaMCQXLqPxc+6luEelk6gAIy
 AF7ko5gcdocObZY4Lma4qN5DpYz3lC3/GLrvJ3CjnnrFceNtp8D8K76wS+EBPipJyRdBb/Xf0HT
 jBPG1y9CnmqtJdJ1Vx5+G6C55sB4dXvB+uJHKZd8HzuUOUMR3bx7u7uAAx+LNschbQRiJmnFz8/
 oE6flRBjmEph5EHLU9D+5lxTA24AGWLQdsDakEI3iqD+VFNYuhPJK94OnV8bAR0DB1x/AajatSc
 RqUmJgfnyQUspZ
X-Received: by 2002:a05:620a:6087:b0:93c:c08f:ecf with SMTP id
 af79cd13be357-93f57f93b69mr825263185a.53.1792663985778; 
 Thu, 22 Oct 2026 03:13:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6087:b0:93c:c08f:ecf with SMTP id
 af79cd13be357-93f57f93b69mr825259185a.53.1792663985280; 
 Thu, 22 Oct 2026 03:13:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa4b90999sm562304e87.68.2026.10.22.03.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:13:04 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:13:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort
 controller
Message-ID: <d5whwqc45gtqwmb26mh3wi4xdls7fm3wxdszo43qb3z6rhnj4o@22ghfqzuryur>
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
 <20261022-kaanapali_dp-v3-3-b5ae8e6083c3@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-kaanapali_dp-v3-3-b5ae8e6083c3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfX881DJ45/IiTZ
 GaayySYnXsscKd2Nbv7qeyxBlRVvZEYUHcXCGbFaTPHzGn7GUXS1qkDxQKqG5WxG239JV/J24NQ
 YrXeN++Op5p4XAn9kSoB1Rg0SvhwiWTTrF04lBlGe9/B1lE+5zWuTGA+TaJPScet57/jsykQiOQ
 GEPR4B/xPSIDvVNKuuxtRC/P0sA8XZzGQuF9NqIpkBa1HscEdRU6fLpTQDtQCaxesP0b/hDel8M
 TtYn0kiCgIHbGWRFSAIezTMPSInj0jMJEQcpNgy/shp7GLgoJ29qvgCX0brKKQvM4NtK7qF1tM1
 Up+lckJQu8829ElZm6yX2cWKlFl2O4sD6FkroOzAS2N9XCssyzhiAU/mckXFjUHSdmaKdje0ryi
 YnwUYHmbtoP68uyJmbN5/vOk3XxcxOXEmI4wO1fbG4V5vz5rx6Fm8LWTsbvHxuLWYcBOHHzcuha
 PhQ8rvNHZ0VXJP2o/Rg==
X-Proofpoint-GUID: G5CJJl9DjNJglcpMquV8RrtdgGpojugA
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ad9e1b2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=S65zN7q3fX_PurGuIfIA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: G5CJJl9DjNJglcpMquV8RrtdgGpojugA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfX95dorY20abH1
 39fGW2YSThzoIoenOK5PHfXBS3e616WTX86+0Y5rpKYtVfzhoVhSOFvY2UPy/2BJLc5OPMRSaOq
 BXJYosVFnL74zyFuTYE1zBhavwyf6A4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220040
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

On Thu, Oct 22, 2026 at 03:19:44PM +0530, Balaji Kalkonda wrote:
> Add the DisplayPort controller node, including its OPP table,
> controller clocks and power domain.
> 
> Connect the controller to the DPU and USB/DP QMP PHY, and enable
> mode switching on the PHY for DisplayPort altmode.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 90 ++++++++++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
