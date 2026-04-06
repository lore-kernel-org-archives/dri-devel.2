Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022F4FB5173
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 23:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C54710E2FF;
	Mon,  6 Apr 2026 23:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eac2oUM+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YcaPTbgf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D2B10E302
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 23:42:26 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQPJl493369
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 23:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QBNE/lG5K0Ju1pitUfzLaBUYmxhHI5uWe5vz/3zRmFA=; b=eac2oUM+YcUi3qaJ
 xAKTj6SwR631NEjwCDf3w7rDOZTUi4UWjQtuFG5wddp7UfrY+GizSmADeSGDDD5l
 Nr8/Qd5G8eQlIS+mioVet+mX8/5I2QlOOMYdgabOlH9Y5xolViGB5LobPBAOmYMo
 hOx+7KtGJomvO2/cFjWVmiinomKWjvm5Vjz4qbqkSs/zzPmQrFMO7U/Os4l/Pgf7
 fvwQaklgVZcbWbTpEXw5WuKYDa9OWPtLrkatlqOYSkOPSX6IxMCW/NR29/w/VIeB
 km0S0Wba9KqwOpMLsmWOvAHB2xZbDwh7NL6npKJ996gC7la9H2/U5OGvfDM3GZuS
 MRYwHA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8r8sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 23:42:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b34223670so207057851cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775518944; x=1776123744;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBNE/lG5K0Ju1pitUfzLaBUYmxhHI5uWe5vz/3zRmFA=;
 b=YcaPTbgf8zyK9PUmQfEtOPMUI5uQcCe0ZjRyLpRd/Y3d7S26Df2Eavkjlap+Ulcgz0
 uysH5VATO7bnJ8ZMke8tT6e1266sB5K1HN6mXbjsjhKrGufjuHm+lmGDn6MN/StRlXkp
 W8+w0kVvOWYnDfHeVOGSNNVqetYHMV8J0U67PHcPW55SZOotLy/syyQLZ3bhS6YEij4p
 jSk9qKsx1JY06mYUoDr0wcAwEL4ttryBeO/gaoX6ZH1lCd8omtiqA61ZCl7X8JWR6qfj
 39Km7mG07JqR54NmHSLoJpYDD2PlxImU9kaxaO13NsEkOx3tIIaT75GlBtIWBW7QrtWZ
 uS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775518944; x=1776123744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QBNE/lG5K0Ju1pitUfzLaBUYmxhHI5uWe5vz/3zRmFA=;
 b=eHim/ll17jtICa568wk85yJJ9ZuIm3CUZjdS0KjXP61DeTo5fLZgNRetzbayS/xclj
 vvqPdZHyaL/MLMw38d1wNyJgldjPODd7CiGtgRhoigJ8JdJae3Eb8FMZPPOI6zXLuKYr
 NefFjnREnJ17ZUQTUidSzPE4IIsmXEzyrJEdDLa0QQKrJsiHy+PA3ITpnHI88NnGNVN7
 XFYZDxJAq/w1hyfVYHsWY42cqjwtHw3bpwzZGMcOzynI12WelkNdE0zDlRJ1GR7SLp4x
 OwlIzN5Gh4mXGux9k9ixN4qsg5uOnP/TFlz7eqlwfxbRoZegcqG2hZXKynwMw/C2zQ8R
 9Ztw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxnSp2lzaRZtnJF0yT03jiczTt5vX/x/y3TAbND0OPR2PSwG8oQJeEhtqUrwfLBHaB5cpHlAW8aGU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKVY3TtpE1p2gty48SVLvou3YwCG2limXQclJ1LMh3rrIiNMR1
 NnsKEZ/2i5+T35v1sEWxlbqtlR0HZEpwHoC1XCSjv2u+CD8wfC+FvtIsrF6DyAAdxxP5Cx3sR/M
 rkrJgUbMCfY9e+3C61FsQMw+dLJGZp6G1EuhBPSSEf0nL1zrIdowoeF01V2yRDJ4I4cJ9vm4=
X-Gm-Gg: AeBDievSFuAuisTh6BY8a6O0CMFeD8x2KbJsI8W8uVlVwDFO7V+/jLj5xrI/7wlnkm8
 hf6BqUd3o+e1OA/fKQ6bZq3lAjgFmUm0L1POTafm1KIlP3c5ZreEwXdzC0i/I+nqLn+tiupbx8G
 ZwjsXuV8u9k28n1ttx8BPs8eIvgKMYlkAkYbAgpvtvGkI9EoXZwOdsoCGEFcTy+L3Jb1oh4lTcY
 HbNI7INaHp6yi0YW9ixiiNRimehh1/6lpmKUOFWComXGuCyPkbn0AmXmpaZh80IZOp/S9O+jdYr
 UZ7AI8nne0qyoRyagIA7/iSIt3gBIwQgqWNXkN+c7b/75i5QJXj9oLIQ91aLvtdB/uhLq4hbPXl
 UEvsapz4kjNLpqPrzzclhzMiDx9ltlWQIZVaK0xqMXsjJaZ7lUZnrVJTB/WMNYUhNrOA7dJvd16
 0lfP7yxWEgMXf5WYcY7YwYLt5itNdpyc48xDA=
X-Received: by 2002:a05:622a:2614:b0:50d:86cb:db75 with SMTP id
 d75a77b69052e-50d86cbdfd4mr114591521cf.7.1775518944410; 
 Mon, 06 Apr 2026 16:42:24 -0700 (PDT)
X-Received: by 2002:a05:622a:2614:b0:50d:86cb:db75 with SMTP id
 d75a77b69052e-50d86cbdfd4mr114591101cf.7.1775518943948; 
 Mon, 06 Apr 2026 16:42:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd217c708sm33512011fa.39.2026.04.06.16.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 16:42:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: display/msm: move DSI PHY bindings to phy/
 subdir
Date: Tue,  7 Apr 2026 02:42:12 +0300
Message-ID: <177551403338.616257.13801012061085104397.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305-msm-dsi-phy-v1-1-0a99ac665995@oss.qualcomm.com>
References: <20260305-msm-dsi-phy-v1-1-0a99ac665995@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dYnM0AiLIJsgGowKQN_T78z-qkNGpxyd
X-Proofpoint-ORIG-GUID: dYnM0AiLIJsgGowKQN_T78z-qkNGpxyd
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d444e1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8
 a=jUgDIxc-ftyl2Azd1b4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIzMSBTYWx0ZWRfXzioUbGJLxJyQ
 xWSrD0bRDXEsACkv7W/YHSU5jADHWMswJZFMopFcLr9qX4Tk+2P+1NpZDtUafz1R9whlm0IF/0J
 5nF6peLORI/2SRL/vk3wQqBglhO4dW0q4EDh9IzuYhqgLIkp/Yi2Eb0uf7Sm/4JN3v/YfXUlx0c
 h1SbYrVJhRRvLOlB79XbuAVJwPH1k5d0Jb8Krwox//t5Qtfti4fGKe5I5tU6+0avQpR9ObM4652
 gqY0kgJSjYzRszlLYcjEq5eoBHsyPk6rRpyrird7yXYrNjniPgwMun+z7VGPBrEphTMRg/wD3ZJ
 3UvxhhV9BYXqCbOElmqDg5HAOX0j76Dx58jyAataN/suTOGFNlqB/JAA7IAkUXzK1xsK5ro5uq6
 Wo7DyXRMBcs/gTy3chtCgPZ6CPgNv9IHyFBt/JDc0W0Xe0pjJMi8HEDLHahUO2LK0y+4WGJvmcH
 CVjg7bZXHK8ajt0yPyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604060231
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

On Thu, 05 Mar 2026 01:47:12 +0200, Dmitry Baryshkov wrote:
> Historically DSI PHY bindings landed to the display/msm subdir, however
> they describe PHYs and as such they should be in the phy/ subdir.
> Follow the example of other Qualcomm display-related PHYs (HDMI, eDP)
> and move bindings for the Qualcomm DSI PHYs to the correct subdir.

Applied to msm-next, thanks!

[1/1] dt-bindings: display/msm: move DSI PHY bindings to phy/ subdir
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f94aa7e9cf68

Best regards,
-- 
With best wishes
Dmitry


