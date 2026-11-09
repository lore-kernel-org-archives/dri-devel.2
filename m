Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C445606A339
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B5lOCSAL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CKZ7PCB0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49C410F26B;
	Mon,  9 Nov 2026 12:48:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE5210F26B
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:47:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9AJ8a14127076
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 12:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TeOdNADF8PbWanyh3zeJ8VVt
 qapoi4A83pKR8WNo47M=; b=B5lOCSAL9XED7EOwzb4VP/rR8c5y0c84FDAN1u0f
 qk5AdWusuRIEf33+PYlELJrIJuy7HCz1ZwxVIorihS2bNZ2pE7YX3L7GhhwNpKRL
 Qkb2o5C9JfDntueUG78WSDFtHPg3OEDe1CBlJ4ZLSgVYIJcOaDVRpFi8Y7H0h4kO
 jcxoCBsR8cHUZlTcQTHOtJufPVQ9wKTDfMG65dZ7V2gTZCW1Y9N2SRAMlQFUV4iL
 JiWTHAKpg620K7Eg38p8B7K45pZT2tt9WGR/1Qgl02CEUTR78EjhbtuP7/TpNYup
 Gz6h2rsMmi4JIO8q7QgH6kwYrfbPLhqVcDcyMrNA3Wqh4Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucap8f0g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 12:47:49 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2c415bb8fso99551137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794228468; x=1794833268;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TeOdNADF8PbWanyh3zeJ8VVtqapoi4A83pKR8WNo47M=;
 b=CKZ7PCB0yoUM8ZWovYLN7/ou7ZX/bs/Qj0iEMCxA5o4brjaTPIOnlwoMjzU1vdjjt7
 XK+H+r+jV1yA30LZMuMfOp57RWMWKDJUjHncb1GEImzxpk31XkQvt1pkuIw4ds4yMVIM
 bDqmk3sLckGCVCJ5sBM7L486eowUyAFPAs58eUdWmSTGLle0bNI6vpbDKWX3iyyNNqfX
 ymTGWHAis26ER5OAi3s6DXQLAFBu8r1heF3Q5bXSKxpeqk9vAw9syrT+dWUGeVfNTUdm
 Iu4Rfy2h+Dc35Axx3Tm930rFfy81DKdwuzTObJcj0M5txXqkh7IVMXuSuhMuODkj1uhJ
 DYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794228468; x=1794833268;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TeOdNADF8PbWanyh3zeJ8VVtqapoi4A83pKR8WNo47M=;
 b=p7xryURbXGxQCE8IR4HdK6H8oOP+u1drmqQtQ+ZYBjh6MT8DLxgMdnEtesU93qk7Ek
 mjtQxDIuWjTcf4PByeTNuxUa+NLmlPjhIi/JJEpwaxRoNLKqogiIHwzxxl56ZfzJ7Epf
 snKyf5KnxtCod6ZhIt7TPaTXomHrZ3RS5OeOxbkJjTjSbgTK5moiv5TAW75tnK2Z0zTb
 KZkzP+1jBOsrCUlgZMR/JAXGu8J7BbHj+GRT8Yxn1FbdzbEC8u/JqtkMVqZuNLTuDxzQ
 uR2KjyZTUWYwITUO/UCSrEdAKVuIPaH3Dt4xP86H7rbnYi5dYGO5YjN7IPMn/6C+FMEA
 gh/g==
X-Forwarded-Encrypted: i=1;
 AL+hErE8r/ctVxq/x8gKOkU4OTaONLvNiQOeLHMINRhuHoyMYBlR//QxESgtO4vb3EfUW7fnz5TA4aUsqzA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9qf0lpHqGyzm448arN6zLVrfLXofy4EdgsOJK3tr69jmUoePoq
 HyvaMAVmZJsm5LQJNa30dw+FzBepuV//1WYN7gq5/2v5PGTIjYeI5OdUhgdpxIrdc4/CSOtgd8h
 17cuO0onS1Zi9+zE5n0NuZMGTaTBtceL39Oz7y0dJNxD+NfmXhdonqqWDsBNRC5lHpsWVprc=
X-Gm-Gg: AYBFou2wSarc0jttTMsvAhkR9ptcyM74g6VR0zc2S+aiLfQWJmCNcYoLNCJyrRQerCw
 nmsycEtaK37pohpSJzzEDLQsiHnFMLQJvcknidyXI+bwD7Dv0H0t/OKUGza/3cZA+w5PEE3FYnY
 zwT9gPqx+b7FEn9aoBOWPEVH6EZYdzWl7rQfvf2i71lwedhBK7qJkM+FNbl8JVUl1j6vQU4yN+y
 IuBZrO5o3ZAMbzN0i/2ZzOxv3hnxtfle4/M2bFdrx7pObjniankWPqEZePh7yMmNCRxeHOWmQGK
 VP6nuZ5QXNycJGG2/0yG2X75kKGjonEjn0fc9ZOZmS5KMgsTYmHetksU6B2h340CDuHlbH6dgMc
 W45zflcakrV3X2gOZ/+qH9YwmYQZ7SSwkGUoKCpORSN3a3DyL+A9XWxbqVPBHEMU=
X-Received: by 2002:a05:6102:915:b0:7cc:56a:58da with SMTP id
 ada2fe7eead31-7d2db0dd505mr782538137.23.1794228467812; 
 Mon, 09 Nov 2026 04:47:47 -0800 (PST)
X-Received: by 2002:a05:6102:915:b0:7cc:56a:58da with SMTP id
 ada2fe7eead31-7d2db0dd505mr782530137.23.1794228467118; 
 Mon, 09 Nov 2026 04:47:47 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb0b0c2sm207416945e9.8.2026.11.09.04.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:47:46 -0800 (PST)
Date: Mon, 9 Nov 2026 14:47:44 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: david@ixit.cz
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: sdm845-google-crosshatch: Add
 display panel
Message-ID: <nt2zeflxqbnxxb5v7p3ncaigrwlzatspcx72be3253bsq2t24w@q6s7wvdb3k7w>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
 <20261108-crosshatch-panel-v3-10-87dd4ec4f7cc@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-crosshatch-panel-v3-10-87dd4ec4f7cc@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MCBTYWx0ZWRfX3v5tD+Kxf8hJ
 PfrbWmu+0+QXx3xwU/4NHi3V2WopTvNNEm4tDsOWux8wsgC5TjTBiuS04iFGgJ/yHa+e9Bc2QmE
 mEQ45KqHXmVOqxW2xSHPrKFgNz6R1HNVT8pKZFDGhXQJix2E4EhAhNSPKdB6N+P1X57yslE6uKx
 jk7ZNLoXHmO8GBMJCvkjRMXNRDR7pyiM3dxCoQ0U8DWCqMXPPeq9Syq2ZV87HxL2OaOwRKI7Tny
 /WukKBrCtKSo2VYjqfDC8JRc5GqASRhocOl3XIWz4cfi0Pmhl0UWsrs4CnOL3esIjubl/YfiJzi
 6mp+rDUp5Ersjts2kJHJHAR5AYbfnX9yyQEInFjQXmflFmJDuLmCPh9gyxScfVmMoetxKCSWeQm
 feWCdDExR3rVsVArF3kieyAnmNs8OMZCxIBTTbRv4BVaW5R3/N+kXJ7rII53N7ZeWCvYLp8jp78
 rJUsZ+hRu74+MtSFJqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MCBTYWx0ZWRfX9QyRggITWxTN
 0JnD/AoxnidigYc4uoOAgac7gUhOTFcDedVkfCSKZBuuyW9iPFVmTDtMs848HyoOZigY9ffITcf
 HKMOlHsoRsOQxJobHnXVnmvlZ+g0BL0=
X-Proofpoint-ORIG-GUID: fj6KmYwZEQwDJfoZFU2TilIL0JW0lnaI
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af1c0f5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=v1rLgdUz5MECU32CcTsA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: fj6KmYwZEQwDJfoZFU2TilIL0JW0lnaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090050
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

On 26-11-08 12:32:31, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Wire up the Samsung AMB630QY01 AMOLED panel on the Pixel 3 XL and drop
> the MDSS/DISPCC disables that kept simple-framebuffer alive.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
