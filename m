Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16B606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qz1Ad6Fi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J5yKz8wx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8350710F268;
	Mon,  9 Nov 2026 12:47:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922DC10F268
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:46:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9AJCKb4127182
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 12:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mEue+rSQb3nzOUHKOMWWZHCV
 p8uvI1D8kOmCoL2tqFA=; b=Qz1Ad6FidVrJ8nbK9hpcuyv9fQlFmF3jlggJ2kOM
 AOms8H7tNY313Zy9y4qWstid0cyX7p31yTGEIpZ6PIhiKe0cu0flg3Me5XqHOx7I
 B3odHkHaDOMOnOnoq66TcOnzMUGHwmcp7ABZvBiRy15iU/+agzdsAK/DNMzGXks9
 UYFqRcpQPXkfpxpghInvlSCLWbi0D/xKbB54fk0+cs+7HAJPQew0SzhHYdK6YCO0
 JRF+vk/Vg3hphgYcEEM0nmbw6uwY07GON3WE9jKzrVlCqOCR49tdkqffbWjFAkzF
 cdbXhGgENAk6uYDIMnH3NkQxcFH2VVFHQHuCD/D6M93EBw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucap8evy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 12:46:59 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d2ecff433dso449312137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794228418; x=1794833218;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mEue+rSQb3nzOUHKOMWWZHCVp8uvI1D8kOmCoL2tqFA=;
 b=J5yKz8wx08STwGcVI/c7EpWUr733TAQfpKhoxWfCFQJ0mlL78uIsnBmjQlMeDC9PjC
 mDR4ecMG6+U+YOu+T77Cyu5MFFZEyHh8UoIwCMcHZy83Gih3ucCGQLFl9IY8Qy1kEM7T
 YqiX56ap4xmT0b6LnspR/Fd2OcBHa1jKk/B8bSdKtIzEGp2hnY3XY0j9ZsS9DI5K9VHm
 HzIOEggjfFeAoAKHpWEy3zcToFsqk7PFZ5amCLw8Sif1KdoUFEHMGIkeumVUynzED+ch
 fuxjEowM2oa7MjWAX3uwe+wo3RroziPZx2w5gKnNFEisIFeEs0bgHfEa4lHopefBCOY/
 NO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794228418; x=1794833218;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mEue+rSQb3nzOUHKOMWWZHCVp8uvI1D8kOmCoL2tqFA=;
 b=KtoNlhJBnScH4LBYjIFsE9wU0Gd/yeRCveH7PKjH3LaBnCS7QdIOi2p3xgmso02CLx
 qKvLC+ZsisS/a93A+lMMeWmUb8RQy4/lfF7J0jnGKsUBxmaIF2AuyEKJeXBupbnuNSET
 s4Ak5Z0rfjnKPqh9Vo5MGmoRJ9bz+puKnI4OecXUwIJusWAZmkEjj/ydgkB54Rm78pl5
 HBhcNxv9VwtGuuSjddfZtzAFFJMOIb7W1wvGvHofGC/zdYSBfhAeZ8MRJp9K4YEfMhYH
 sHwAQCSwtaM6t6x9qnCHeJ7McGJLb2pAKdTlIwJq1vumrZa2rw+4I5hRL9WXRD92HdIU
 BIEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGogB61IoYM4GuTAs47Zi6b4zOKZfZ8lZ9BI7twYbyvrYtSe4ZirD/dDU8+0yIjZ/bZSBfTv97tREs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9mdlnWRXeYr8orkNo+PsTMr+GnbNQ4i7aSI76oUoDx3xtcGv03
 RG2Fpj74ECCpi7fOgttH6qmLCXBRHmyjMfoImNfkPKQ3KuEUhpTE+bxFrIBvb+l0O0U0U9mC6rB
 jDs32sfaQJoCgvx8BeOv8Icm3nI7ehAnk/xx3sDeEbYjEZHqwO03fBWwt4o8xQNbnEFYYIpc=
X-Gm-Gg: AYBFou01GB+OGrbDAilGQNH5KwH8Xczcy2NzWDcGkfF70tGARlnRBuQr/48Xjz3l1X7
 /u0N4IRhH0RJn3b0rR4n4cU7hg/yWkoQn8sIlkprJcr0nHS7Z8yq+352TJ35Si19Rv5DTPXPXM0
 oyKJLQAr11kGEl0ud07BgjqErDWKgw2Eu3asMT94/m3myFs6jalyXT8x5+W/dJwh51IhxGI9iqM
 lZzCZYd73fbCdADFKz8afXyMT2oyojNdLxqqOKfuitEZ1iqWSI2XpJvKBqdv5vT89PTlB2mWaae
 LK6dyZE4SB073Wv/T5za7Xod8deYxwQJk97g5RZ7SO10prdauI/X3URCQH+bd/HKqPDbr1qqJcb
 923g5BU1c/2BLiJrupqEO41jOJG0/j2shvkNYmmah8Yp/v8SVO3ijqP50lrmWeWM=
X-Received: by 2002:a05:6102:6449:b0:7d0:6cf3:d8f6 with SMTP id
 ada2fe7eead31-7d2db2b0ab4mr1094385137.28.1794228418015; 
 Mon, 09 Nov 2026 04:46:58 -0800 (PST)
X-Received: by 2002:a05:6102:6449:b0:7d0:6cf3:d8f6 with SMTP id
 ada2fe7eead31-7d2db2b0ab4mr1094372137.28.1794228417406; 
 Mon, 09 Nov 2026 04:46:57 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e32ad610sm539537045e9.3.2026.11.09.04.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:46:56 -0800 (PST)
Date: Mon, 9 Nov 2026 14:46:54 +0200
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
Subject: Re: [PATCH v3 09/10] arm64: dts: qcom: sdm845-google: Move panel
 pins into common
Message-ID: <6hk3vbvxybzrsb3nli6ysdabeb3npcu3ejozhz4aerxaytjjqu@dfqjpnufsa3t>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
 <20261108-crosshatch-panel-v3-9-87dd4ec4f7cc@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-crosshatch-panel-v3-9-87dd4ec4f7cc@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MCBTYWx0ZWRfX9OLsrfaTeqf2
 B62odcm3AI0bENtKfw+9NttimSugJwGeRrAWxJ3aFo7zyXl05SbbGwgdcfodSQ3mhQAy/kzkfdV
 3slBLDur5YdD0jfHpIr9wGgvJc1gmvAbiukMxk0/QuaT22LgpgbpHwa8lQ0aae8pOxFsjvd9bQ4
 p3HwkdlGekSu4uiiAjCAXnzZMRId3MAmLEsnMWJJszKYTaDObfe3K0pIut7+T9I+ghzxRGRLMO3
 yJ+O8oUPEAiQozcCXtik2rDTVNcP2uMfYTZ5VNVYAcjwYSRxOiBC/E38T0RtYMYL0JrOsrf6KnW
 LYnA8gZHLTuIUl8WnowLZ+34o//Go/WYM5+R2B70Xj+x6nQXyqloNqfwdnHSFKbeLRHgQe/uMRN
 m48i1+Z9n/rwCApAQ5Fj4UbI5c+9WutQMGtgy3iQoGQ2Cxz639E+1fkPp4K9rV89LgOd1mSk9Yf
 YH+4FUJHra/c54qSCjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MCBTYWx0ZWRfX7E0nQBnaViWV
 EYNapP3i8DnB4d5p+CeFfSIsKMStLpbAmmw4svrTFV16q3e9qv8/81R8ubQw18ABeH98eHmTFpO
 FXsLbHX/HnlpZsA7ua9jlnvzGASAgJg=
X-Proofpoint-ORIG-GUID: 9JrjCzsLxuSkydilBGNg0gLJ1r2Mrh_2
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af1c0c3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jgMgYrHaTVL-YdunLg4A:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: 9JrjCzsLxuSkydilBGNg0gLJ1r2Mrh_2
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

On 26-11-08 12:32:30, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Both devices share the pinctrl configuration.
> 
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
