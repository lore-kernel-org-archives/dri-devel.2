Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A741088E65
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB7B10E09B;
	Thu, 19 Mar 2026 02:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ik6rhIdt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B16VeBgs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21EF10E09B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:27:42 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J0tt874024184
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8O84MM7Ovnlu/0HHNNMnw5tm
 T7h2j1DRydnOIymi1eY=; b=ik6rhIdtW3S0mmxlnkCXTE2Z/iGoZUIH5akFpEFm
 cZ2IKtDAvWMdBNaPjUYQL3qtaBgCuuMED1NZxOCyDR0gHgd/Cvgj9GI6LuHUn7T6
 6eHzQnmntDvNWonmKiLZ73cbPYuaauU1ZeP1hPl+pnneoOSFPlHspBUFeuatxsA+
 pGXvF9YcK5AwymsnNhA1BNookp4zexMEdJ2e/jwhlm0+ViETWgI+v70TXFkQFAs+
 lwsJUD5VwOyBlVs0NoGJ74LXESRPVg+KN77QlXZ3tQLglnSnUg6hzz7MRTQ+R/ho
 oaeZaFRVdEMQLu6ydHLQ1V9ANPKOCyHp/DfZ7JSVdfVDAA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyy75ss3e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:27:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5091ee9f1d8so39529081cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 19:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773887261; x=1774492061;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8O84MM7Ovnlu/0HHNNMnw5tmT7h2j1DRydnOIymi1eY=;
 b=B16VeBgsepVv6bXQ2OO8Hy2uDIfeI0ZylC9t0duQXu87L/Iy6peZHEcDp9Kdy9mTc+
 Kra7zET1wbsy4iXuvik/8AxSkiDeLxoTAzp6E+oIbJUR3dK/BCEjNCPWMh5KnRBuUoIT
 D5WiKcYniuvovwJDlHeywMuLAEC6kG0rDyTj9F3FjHoG7Xgfu1CubXlff36env/jm2Q/
 XcozjbaI/5FoVGa5eeamaJ9ZVRzldH3uBjb6OjjsmrLN9hnWeBYl3YcJ6mKSOH8cyVaV
 lxqBx7dR4dwSTIiqUfclWshfIMeSKDVNYM/u9dagM+ggf2JARziNZy3bnD7IFuW1MPgw
 jYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887261; x=1774492061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8O84MM7Ovnlu/0HHNNMnw5tmT7h2j1DRydnOIymi1eY=;
 b=PrgMVE8mcoUzAgki+SK990EwLe6LlEXg/2sDewsi3wOIm1q6ha+1yP4pkjtvzAbxLA
 DyWL0hxMK0GrhyFD81xTGsHCstOulHM5nB36iH/0C2hvVMqPy4tCz+jpOvkMzq6mrNl1
 qZf4iFxGoQ4eGSJI2L/OPZJPAPP5RR//Btg1Kcy/b5U56+I6H+hXQDoTSZZvUMw6uffQ
 SSrPm5myh4bht4EM+oCcI9233f4sOeDoHHgwLy6GmOvNml6uh89WEDXzQJp+bQVQztM0
 EaDFXGqTGdygwZFd7x6JM3Tl+j47rXZvVOKRZocinqpXqhA0tsEv8mfTk3VD/8BK/NbR
 eZ5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnMniHy+2KsDzVuxEJLVmTmN2KWZ5Wdkt5waDWIRmwosVz+2A34pV8efB3cG3nl5qN4xvzWGec5dU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztJC8biiaZKOxv9b308J92IVvjD3Q4wdeUTwn8rGEe386JboSb
 mSbKQ17+iEw6BA6GwY8zuufgwOY3H60RdaNbp0xtDfprIUJ3i5RGb01dh8SpsJDwGm5zSVFaXGR
 MlvfWuVc8bz9PjcfgrLW3Ese6Gu2hBdM1G/HBtpFGJjJn0lA7x7pl/lWKb082GV5n1yDc5Qk=
X-Gm-Gg: ATEYQzwdz4FtMpT+8+XJ9jvW69E3BcXXCM2L/VSg1KFNRUXQ6ZmUl+/61S4wWMt1po0
 IovTAfWiohvB001gwICGv/rvyw9V0p9WLC5YV8VBhNuHOkXjl0FnDKjeeF7JLw4DHdqTOJN8ziR
 vN1HglSX1rdXOPWbcDmYkbQAm1ejSTmStVFAfuK776uynd6J2uROMafMd31cUPWD3NStSJWwHDy
 O5SGHtL4IHW/+nF/6bfDPJJH/uI1nMrd5AZD7S/Itshqi/A9bBNg7Re6b+uwkjuN2PSVUzSF5BI
 BAZcylDHc6ZRqh6TvNUVLA9SFy8sFjDTK8Sxo1GiWtN3O3u1hzMXtvgjQstsslmPcOJP11SSL7c
 r1z9QEt7GizZ2v30ME4OTBrLJgln+k1CEFzP2BmvWiC1IUzLTcWXbwqVtbX23W/MH6EanJVvA5m
 8gIYr8BcVnacKjBewnmcVxK7CKEFSQlBNcpJ0=
X-Received: by 2002:a05:622a:10:b0:4ee:1bdb:a547 with SMTP id
 d75a77b69052e-50b2461a932mr27523621cf.14.1773887261240; 
 Wed, 18 Mar 2026 19:27:41 -0700 (PDT)
X-Received: by 2002:a05:622a:10:b0:4ee:1bdb:a547 with SMTP id
 d75a77b69052e-50b2461a932mr27523291cf.14.1773887260769; 
 Wed, 18 Mar 2026 19:27:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c2d266sm873523e87.29.2026.03.18.19.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:27:38 -0700 (PDT)
Date: Thu, 19 Mar 2026 04:27:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci@protonmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/panel: Add driver for Novatek NT35532
Message-ID: <byxrw5g4t23vivbt4xxpyfcsbrmlaju4lqqwsc75iqizoqmt4n@ltuwlggbitye>
References: <20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com>
 <20260318-rimob-new-features-v2-2-c1bf8917449e@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-rimob-new-features-v2-2-c1bf8917449e@protonmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAxNyBTYWx0ZWRfXzDugAyx4rjH2
 /3f4+UwjBJt7mplUGTVnIO3+IcZRX3fKpRKbgdjDV9+AJLALPPO38NUoaJf5FlQbjoH9ZhbjSTJ
 BbLdhIW/kWm0SSRfXZdShBnFIRLcreMrcREU6Gpf18Zygfi9w0Nzxxsp8PbCe8qYckpMYMEhDOP
 yZn2XGkrG8WnlStVZmdIYkhKkJsmxD4iMk43Pt2k/dDyIQByxWQHZJwTsNWVQwqHBCuoyI+Azh2
 Nu539YzrT3wREc7fldbu4tuDKB6vn5cnsWJoelA1dSyNFjLkwKm/3YnC8eOZsxI75WRtojZJ2r9
 PimslBzRt8ZGRT/Tq77yjXMZ2rKorAL+w78MtsVBwoGS98dP8XmmXQ5D4k7cmnDK1KpacB3rYbo
 m9q46S7bkMtjWm7wKz3TWBwkwpIVicfWa778yHKFjhcm1/MnqcAoWVinWLXRtFG+XkeFrtIUgHc
 9jqwzla5BGrLkOAMRgw==
X-Proofpoint-ORIG-GUID: 4Z7VMrKqFLbP6sbm5p-5Rh0Mgn_D8EUe
X-Authority-Analysis: v=2.4 cv=A7hh/qWG c=1 sm=1 tr=0 ts=69bb5f1e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=sfOm8-O8AAAA:8
 a=EUspDBNiAAAA:8 a=f_kZLxWr8KFBRA8n9fgA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: 4Z7VMrKqFLbP6sbm5p-5Rh0Mgn_D8EUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190017
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

On Wed, Mar 18, 2026 at 11:28:10PM +0100, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Add support for Novatek NT35532-based 1080p video mode DSI panel.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/gpu/drm/panel/Kconfig                 |  11 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-novatek-nt35532.c | 779 ++++++++++++++++++++++++++
>  4 files changed, 792 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
