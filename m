Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6738C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D940810EF0A;
	Mon, 14 Sep 2026 14:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAA0sVec";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BJmWjAg0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC2C010EF08
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:21:22 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0KMm4090474
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hsC/n5G/ysH1TDMPqrs15Xr5
 Fe1eAaS5X/4GfDOh5vA=; b=ZAA0sVecotuQbIutF2EPWz8avV8PBXwK/D22V4EB
 T7JIXLLQ1Pw29b6EVFSY0wTE0TlLHg8qvV6Ovch1DnuNa6WKDmsBAgDOqC5PTuHw
 CixdNiZOG/sxPSsQUkr2Jpm8dKWiAr/QMr+AD9bvsFRLx/2dX/P8Syg4vKCUUFV0
 L1N+4XVPHfeVUI6LLy/0yu5JJQapY83jolFHwcayTw30aMwBkLJUNgcQzrjDmiuy
 EtLVZFaInA13UVi4sYGXkQg5Tur2Nc3gNJ1GHg1TMmmKRltzL3ZNdMRdbhd0y4qk
 MjDsMNpT3yqlYInbKgzhkCs/Kot+rkHfPMWXQuX82Ttt7Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg1hw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:21:22 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-798c310ebb9so1089647137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789395681; x=1790000481;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hsC/n5G/ysH1TDMPqrs15Xr5Fe1eAaS5X/4GfDOh5vA=;
 b=BJmWjAg0RzDewpUncFJ6AmnScgh8Yny8yrcHanVb/ndT+PPMVDLors72sAq5EKUizn
 nLcHZ1TUHQMZPiAq2QFFojatmbLMpV+evwK+VHeWqXbv7g9rVGEL96UfLQhWandC2C/Y
 wP7Q7tv9vlezDQkiYhNqWZ+V8FWYT/8Vf5u6SyaQE32833Zp344cO3+YdtmMTLxTOIYw
 J0pmXOgF/gQVm61+cpu/OI+B+1Fe185HWtjqmwIphLyJh5BUmrEYLlW6R1zs1XW2W1RT
 v4IaJtrb2buHZXTnG0l/sAZKesAqGjysYPj8dX9Lk7ymra1DvIkTn0v+JSS09/8xlyv9
 Qx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395681; x=1790000481;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hsC/n5G/ysH1TDMPqrs15Xr5Fe1eAaS5X/4GfDOh5vA=;
 b=RJPHxzHD98vR8RoTfmVQZTXTeB0dWORoqi1NQJq6F7jBHjlYLULPW564YaXL9/4jBx
 kTeuJvDL8lrdH4D9hMWnM4cWdlC9X15yh6F5nXxUn0UzlEf6NyimG8gfMJWH0xZT+jOz
 MhVnXHx4w4RrWw9fRV7t6iMUpXqtjXHDj+kGno+UZ93sMqwbGCepwNlz84NnNnJBTrYU
 yIhCBJYwh8cyPn3FJW2E+V7fiqSAdzq3zIiZYiUhj+eu6ym+SbQsJ0SmXYeWMznQinNs
 yAEMUsgTaG9fJR/lvU8F56yXcQruRvKlBFgv/zpKkcKDQxBeXhjRuGN7H8MQ9x2KCpUI
 UfDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrFP6Ne213xtUyYSZe66twQg492eOLl9SktlRycf9NRLzebUaXn7V76fo7bSqpad+0vUtDBwJ1B3w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++knhFfHWHCeJR+MZQnr7aFgMzWynYNgU03ZA3MTcp286OqA2EGI
 BgZDdi3iwc/Frgeua1PpcmSYXO6/Mg7HpzpgWXRkdNK7JSWe7IhI65kJKOIu02LPk4qA6IiUbii
 MHz8lGi3xaZa/JAIJnFOmnSACfgVrq8scRKhUOiHbJXNOF0bcGwupZ+8rFocSn4RRWd4qvjY=
X-Gm-Gg: AYBFou17V3tm1V4i8VhgpDlnAWLNjrTE1mrjmfwinR+ULmpUPxTp3OJDSlZSjKbG65k
 0d0rhI0gR9waAgmmpxu/Uq8pDipUyh+iT7RAk6wbjN8fTuc/MNABl3r4hGf3QYY5C7WFDdWuzoW
 L8P9SBb/azv7I22JsICbbaL2nYNeWweBEAN58j7oALYDVlxbZCxn85K4FfxofpTnIipZQYtK6RT
 dQrffq7Q2ypzfDy9fOlpjofPCwR2mgarfKqsseINvDqazbTi+zLXXEH9EWSr7zd5lVYkRhcowlG
 mnG3z4ON3TVs7JxNrZAwmw+gQVbTZ+VZNTjlrn/jFVfDIRRzMU3OKSVDqaR+lNbpMj1HFkDZbSL
 1YYDH4MQBNoS+gbo=
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id
 ada2fe7eead31-79bdfbded2bmr1731005137.0.1789395679760; 
 Mon, 14 Sep 2026 07:21:19 -0700 (PDT)
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id
 ada2fe7eead31-79bdfbded2bmr1730677137.0.1789395677612; 
 Mon, 14 Sep 2026 07:21:17 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6499d57bsm477423505e9.3.2026.09.14.07.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:21:16 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:21:12 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
Message-ID: <z7rjt5237gdtytb35chtyjposyvqpgqfsxhov2all4g2527aix@dabjw24dluwa>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa802e2 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=CjuIK1q_8ugA:10
 a=TpgoBOgV9RAA:10 a=crWF4MFLhNY0qMRaF8an:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: IlvTyC7eO-SL2SveuoIPYW4ls3r7QhXV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwNSBTYWx0ZWRfX3a7j5ZElRPmX
 xiRaAhyFoCC66L/TtOitOsOLZheA77yQz23F4IP3vN24F7yj+VzdmeCIJ1puo1rNqEoO3FE/6hp
 AhCgTJltE2nMnQ3LxreO+1P5G042G0o=
X-Proofpoint-GUID: IlvTyC7eO-SL2SveuoIPYW4ls3r7QhXV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwNSBTYWx0ZWRfX/pBCASg/RIBU
 /vAovFpOKPTxyP5Sy2EA0G8KqblVVvS8NpxWXZS105WTfrujxqkE19xvq2pRo/Lvv7aJJAdA6Vl
 J/eN8PmqT+hvzkioxduDxPX7pko4wkd29EXdiQLpGarWtS81f22y6WaNnfArvHvdIo0MByipeY7
 gzaCH/dCCDXSYt6xnTW9ddeYwKQdeSKlnV/cmYgFHfDKtwgz8xP4+HEdCLBxsTDQdAUIjfIy/ah
 eJFy1r2oZs62FyeILPUPNnxsaWLJEDCmyAw0KvFO4lYYqkaOtgiwqVz1rQsNX1I8lUC1FX/lheH
 i1YrXAYzRxh8yQ6HMjleaiCa457hDlMNVPtvwxUrbyxqrO73ehWj3YZjqJbDkYwgRvaVzaFZo5w
 Oho8nRfDn4y6vdZa1vgosLrEKXE6ME35SabHptRrmutEvieiB3CtdlD1d/c9hmwyI/biA6TNX51
 CWKbyft4Yxyd8J8TJbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140205
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

On 26-09-12 11:39:24, Muzaffer Kadir wrote:
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
