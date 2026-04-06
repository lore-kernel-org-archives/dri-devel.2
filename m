Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F94E9D82F
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF9110E172;
	Mon,  6 Apr 2026 00:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OpZ/RM01";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VI4K+Mc7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C299A10E16D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 00:59:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635Hi0uZ3543138
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 00:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jJ0vIYrlGNsQyBLBU+pIF1wA
 qhZv+f4tNLozhqTFUjs=; b=OpZ/RM01nVPcVKb6Q/b8G2bHN7kKUFZty5svTxeL
 UbU0QEGi5ry3/UEB2l/bkmpSQNiTLy62aawr5VmVtOeXAxfMPe6pu83cuouCzcRz
 iM/9fBCi8D7A2ihXDBfCiMMxSyAPGaWOPAoFUVDBUJeH6cwHugmOyGwnQBB/xkPP
 J/4kl8g/PGhHS8CGLJES7ccBcUKO1FeawHdjE/7O7+7z3ATNGLnzuMbbNXMGybPb
 qAR2M7T+kvRIo4MKu+W9f7WzX0GZLZRDsv1k/kXYs/OgaApZ6CMmSX/p1mYdKkWh
 K+N9Bv4MdHQ2hmwP6rWu4f18u+7x2QeVjWYpjqsYEAvD1A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datv1be1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 00:59:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d826ed6f9so25143461cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 17:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775437195; x=1776041995;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jJ0vIYrlGNsQyBLBU+pIF1wAqhZv+f4tNLozhqTFUjs=;
 b=VI4K+Mc7L/Mc0ueKKZPTsSuxot9F4ZQQj1AgaBrwuWlXs6HmsckmpD45IX17OGCaJv
 cplTgX/K0Vba0D5KXLcobMri0qsJwEA/mW6EfXPruoFI0PAA5ZQNs4Ia23F69xRSS2Cf
 c9XG43jouiY+3wvg/ddkmj9E+jZn6yisOYfSLKnENNRNq4Ktae8+ulxVTgnB05hbcSer
 OOv3SD8IMEAQFkPh8kYyyk83Wz77z4T6AO6ej2dkfSxzHDm51KoQ0hwqX/Hjxcmv0Cph
 uCHL4Oymgx/A8Nsl8bR/kwDo79DpRphVP0BRzzleg0DoHgdlpzUvGiHWsH1emMpdnc9Q
 STzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775437195; x=1776041995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJ0vIYrlGNsQyBLBU+pIF1wAqhZv+f4tNLozhqTFUjs=;
 b=l75a9ZGFhOXVNhkIqICOwppjfUSS5P/+1BToMPKWAbD6pH1KhWchMbz5edhmhobSOk
 U6ht4iuCZZRYvvU9v9tVJ3Z7xxkiubfBQi7+ZppAEqwOKMkwAg6RtvlYvMqsQsXshyHQ
 Gj4I2Jg+4myz6AMiKCuWDW68UQssq8LUOdKE+gmNjcv7r5JpkD8fp14dpTv4cirSaMxS
 T3tXK0PBOCveREdjCZBW5H4N47cAw9+Mh5fTXyJj2eUHDagF5PtBfnXW0DWdUQQ+yw6M
 UaSwAgfNKR+vkKXHXYMKZe1/9SIXhDQwzft9ktS+D2Ipyv84ixMDHHQyfD624dvzlgYe
 P0HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyeQvJu13E/IafDIfcrZgosF+9r33RgajFxNceiswSnyZez7wqDVx9u38qL6k5QNgVAMvsAUAWlN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygaeaVQPcSE1wK4cT8XOXpwjuvTyj+LGDpiPgXlObDVLl6cgHN
 tkPRcWtO5BjTXazg9vMerEECmtThgz0DHG3aA1eau53yTF1dX2rF26hreQC/wLcwBHioQLg7L0e
 buBMEbKHYafSvjQkspkk9i2A4XPg1kB6bGP/A4fn7Dk0ST0GwjhTUSdj4RJYV9Y4UWo/BjfY=
X-Gm-Gg: AeBDietK+LPVrtSxy6WXT7xX0v/GONgEzAAgkRR6h1iLVMa8zwQaB9ifM4Ys9VAJGFt
 wZr8zJ+jO0utssM/hv+5yg2AbOdBh2jr2sOxnKuSE2ixillh3hHvtnXF0LxLvBawXkdFz9/cGy+
 KulnevWW+eBekES3rf7BRfECeLeWCZRdVOKl9BXs83Jdy+P0lQUqsV1Q4tFAkU4TUGH/T0gQuNa
 DI9KNeTLczXMV2vuLjDAJTxYC7brDFhUB0SIJwYGYGZC7zXtSMaYOdgYAnAx5+1gRz/+7xgjuJM
 OcMTpSTaOzKLyOSxa53n/B8cjJVk4d/Wh4pXbF1nFnQEp4JepLw4ZwWqnRi+JwW1AF5YiZK1gEu
 Pt+ceZFMKDjwEF/AxPkBId91KA8Wgm7FBDL7nnWE9VanB3OP0H5nJBCgOLxcy8YivXKpgrgJx/u
 wbBD203nUva9NRxp7cj6DOMDZUpYNjmiPFmqg=
X-Received: by 2002:a05:622a:999:b0:509:4410:4487 with SMTP id
 d75a77b69052e-50d632a0bd5mr144642441cf.24.1775437195271; 
 Sun, 05 Apr 2026 17:59:55 -0700 (PDT)
X-Received: by 2002:a05:622a:999:b0:509:4410:4487 with SMTP id
 d75a77b69052e-50d632a0bd5mr144642071cf.24.1775437194806; 
 Sun, 05 Apr 2026 17:59:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cd3509sm3058813e87.75.2026.04.05.17.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 17:59:52 -0700 (PDT)
Date: Mon, 6 Apr 2026 03:59:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: display/msm: qcom,eliza-mdss:
 Correct DPU and DP ranges in example
Message-ID: <z4chv32egqvi5nf3kemron6qlibgjl726c2joauld5nt7smfo4@eqbpdl5glffc>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
 <20260405-dts-qcom-display-regs-v2-5-34f4024c65dc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-dts-qcom-display-regs-v2-5-34f4024c65dc@oss.qualcomm.com>
X-Proofpoint-GUID: tCudTXScBAUlbYS3lGajlOqTQCzWUGQV
X-Authority-Analysis: v=2.4 cv=GLEF0+NK c=1 sm=1 tr=0 ts=69d3058c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=bHnmLuETDjlIWUPFTNkA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: tCudTXScBAUlbYS3lGajlOqTQCzWUGQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDAwNyBTYWx0ZWRfX6CwldbGJ79ZE
 Pv1YMqkQgGCvjvRDN5kLjgIy7DoQn7HnMpmchlIprVskJpVzd1I1nXFi1Q3HlIgjMqeDQG73mwL
 tXMRkOq7Ds5HKUQVvSEWYKg8t4DUG2YfnZQ13qFTmKXFhSnTlyQrtXlgHcAMJSK0bLxsAl8i7sg
 Ii/VnxwiZYGpsj2efvYegEOX1pJYbp/mjUrLd8RTX4LDwSpsCcwBgcTMwdNMKygySxSNTXYLm+4
 z9IplwRUZ9OwiQtxKqERGy/jvCCawun7Nm9oxYoASSlmMJO6LZcw8WlrMya9iJyNITCbtlsZi+q
 yi7fUgX/y53K7fLPzYIbVSqZjNRuX6R4B9oSv8YnoYNgUdB77Y3+gCYRqXCV3MhCQ5sRGLthU6R
 smp6/K9WOCTygmrnqHzRvT5v/zjvxUddOWrXaBXNQ+BgssSytvSC0i0k6H9EdrUeLf8CN7DFd4z
 5ejn5ZPi3YzKL1TusMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060007
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

On Sun, Apr 05, 2026 at 04:34:01PM +0200, Krzysztof Kozlowski wrote:
> VBIF register range is 0x3000 long.  DisplayPort block has few too short
> ranges and misses four more address spaces.  Similarly first part of DSI
> space should be 0x300 long.
> 
> No practical impact, except when existing code is being re-used in new
> contributions.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/qcom,eliza-mdss.yaml        | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
