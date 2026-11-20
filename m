Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658BA606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bRT9DmCy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z2cx0E3W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B132810FD52;
	Fri, 20 Nov 2026 09:49:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E3B10E2E6
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:49:44 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7f2Vv606057
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3Qobe5Koi0hqdQPSNyvly2xZ
 Nog+FVkjUKeG4gVX+Ls=; b=bRT9DmCytUwXRpDtGoTds3HLK6B3uF11frldUEDT
 LfO6Nfek7yDpJ9nZxe/L5HJPsj8m09jNv6Y4HIxu+Ozsf1dnApWEIe6WFjDFCsqu
 iznZD9bZJCUUQmZfGQlgJHwfiLv1ghJr/Ou6ifG/5Js2yn2Y7feiBZ4WQIAVdIQD
 jr4f8Ca8jRRzxAtwfsbNJhMQWfJac+PeMheXMrjKj701ls+iGB8wUmAc7kPPV06p
 994KH9lBe6Mnqu5P2UzlrtyKKrz5OXCE/4v9Kf2JPaMkrNUcLrDgjQShbbsXTnjK
 alho0bsO4FaPR/D/Rb+/5XIpFQnOAsdugptkgOp2VJmxZQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqrwv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:49:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-949b0d322fcso131494685a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795168183; x=1795772983;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Qobe5Koi0hqdQPSNyvly2xZNog+FVkjUKeG4gVX+Ls=;
 b=Z2cx0E3W7bb1T9nRCvUn8g0yCaF7BLQ9JUHoJu/ZIXW6TJghvawIHPjL0JgI51UCQZ
 elGnDen/zWrkUWzlFN2ARxBri9t4XYnV/BhLcKuU7IhVtyFxf18Nl1Raxs8MwBDlbbNT
 pqYbzPWDo3ROLc13h4EAihNk69wuSmV9/cgiZpTz4LUj+844XVN8uUVCEjKgMq1rXVz4
 0yY/gZW0yCIFpCgxZtuCyWUU6WwF3yWo8fLyCUP6LWWtLCVqHHEZqQI999IGOUlLnJ3m
 c9fhLD1gRB6sSPD8lVOEWVi3Mr5G2o91NAtB0oZaaj95p9Wmwrx2gFeHLtCleFjsIvVe
 jdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795168183; x=1795772983;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Qobe5Koi0hqdQPSNyvly2xZNog+FVkjUKeG4gVX+Ls=;
 b=n13Wj14CCu8CJeQdt5+cyUyb/sbm2ZBNJaFOeilKkOuD0rvDGCWU86IRszDv8Vmr84
 makwi5rlKOkk4ilaIiw9EWj66D8NpouDZjlHjvwj/Hm+zsfm3UkNQS08fOr5OQwvUsWj
 DS0wV2vbINb7ZKZTrTmp/jo614RByG7XOFkjiN+u1ivgzjr9gJFsqOyzKwsR1vUEsaX0
 6etv4DMRxoWP2yj6eVetjcKvkQ/Q6knmpZfkof/YRLtJqBzlKFrgSOo6DPAuBmJ46xhf
 BDm/WJmBQxFrWqk83jfLiUPaVkSwvy9YP6KqjtnxBu6q4KkiCmr0FBPy79N58cLdZaVA
 jAoA==
X-Forwarded-Encrypted: i=1;
 AL+hErE2tjhyvAJP0X4WSIALelMnhDkSS/uvDv1d8EnBhsEiPCuqiBJy5Ro893Teie5/eWePkYBQDFSLb78=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+H2aPH9HnhqZoT8MtXb8zVWnUdX/z3DCv3QPJ7dYRl6lfg1fbS
 TlAacuhzrshVh3YE4jt8phM7o1XZBETmORz8/nNRrP+FOhIsnG6JcWDYW1J7iO3Y178+21l9P83
 2wKJGQvpH++T2i//9CNsUwSof62/VLBV2Uxlt866dnMWHZwsv8FW5lYV/iTU+opGS4Y1EiSY=
X-Gm-Gg: AYBFou3GkrQe0KmSOZlJMTMeQgMzorb1yQQJc/b02hHU3pVe/eAkG5MpbtKcOy2JanV
 DpAY8h2q1Maekxambbbwxb3xV+KI/FGhBgiQrmUpYLkHfxtTOFpLL8KatmtUs9hTKhua4mg7+9P
 TWlVcZ9OS99/XuG9I6/H2ANtqDwZMvIMIn1JzIlncD8DgAjEA/jZqoI4XLwJBUJ2CdpWI/yT6f0
 vzwaGkq8uMGcaXx4w7b0GrosCzD9muBt8vK72YlqgB6VNKEG4J6QApUzf0D6tTH7qgosSlZNKOP
 O1ymqYGCq2oV3+Il+zXfKOtjQuYtAvfjnUy4yF0ZWywjLAVGdBrM4jANTdNNox/Bz/kD+WNFu2G
 FbZHbqCi7tre+VO4r8+3oYKbkB5QLNtPFncpQfij5nC3fwUr59ps9UsPSPwaOGPF+
X-Received: by 2002:a05:620a:4388:b0:946:6:129d with SMTP id
 af79cd13be357-949ba9e8dfbmr404461785a.54.1795168182677; 
 Fri, 20 Nov 2026 01:49:42 -0800 (PST)
X-Received: by 2002:a05:620a:4388:b0:946:6:129d with SMTP id
 af79cd13be357-949ba9e8dfbmr404457485a.54.1795168181963; 
 Fri, 20 Nov 2026 01:49:41 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989eesm4443810f8f.50.2026.11.20.01.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 01:49:41 -0800 (PST)
Date: Fri, 20 Nov 2026 11:49:39 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: nord: Describe the GPU CX SMMU
 aperture
Message-ID: <zdolt2jlnv4gg36pjbtcaxseqbcui7f7pemmoo3ixlyk3ivcvi@qxkutu3vxbnv>
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
 <20261118-adreno-scm-fallback-v1-5-e99cdbf3121d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-adreno-scm-fallback-v1-5-e99cdbf3121d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOCBTYWx0ZWRfX7XFmd9O3s6WV
 Aa6hEKPYnp/tAeQu6G2Hw68nb7chGPwVyWD0TwbliW/TvE8Nrf6IIZW7KPvoJSCJudZcaczV+2a
 HxguiVuSNGxRqv1I1m761Xkt2EuONoDe9IqGLbnTBLnDaQ1QriWrjmJycVULEt01BrSJC45BFxZ
 UsLQ7IveiiVcmfhUv+yjQPnNbtvCdvCCP5T3G6CiTWvsM5NL3ULz05UEKoqZswCTlWLCnYqbPO8
 Exe2CFsExIjPJqr2mM2dXuynwWOuxe41JkOQWHMITq6F8R3snMdTaijW4I1hi+eeKckGeHdKo2X
 1q5eDsiw1++whGwWE9LSzcuwR32BuRVsaIVP8mMkzvZmjvDfmDfLkufSi7hcKyf0FNOfjzlbg1d
 6WrkzEJNXmAFy+pzQNLoPcxMPEjcholpn0mHgyKAbHG+BtEE8K3nqSTmIt2KPRRmvgp5un5/R6Q
 D0nqwt0lUDEgdXhRFNA==
X-Proofpoint-GUID: zNNxzpcSJoNDOort7e-unabMiAW_etvc
X-Proofpoint-ORIG-GUID: zNNxzpcSJoNDOort7e-unabMiAW_etvc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOCBTYWx0ZWRfX5/P9dD+rbDL2
 yzXFKYjazZsnbRjRgF34mbDm+a0Ji43YzJB1K2qW39Avvwv4K1vs7BZ9manFgBnbGMby/hSjtHh
 8E9jwsd5e7b6AYcUVqBgNwHt2SxsnCE=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b0017b7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=G6VyOm33As555aFvO9IA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200038
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-18 18:38:29, Puranam V G Tejaswi wrote:
> Add the CX SMMU aperture register region to the A753 GPU node.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
