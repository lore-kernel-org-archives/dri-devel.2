Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0EDC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A528910E526;
	Mon, 21 Sep 2026 08:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kHtH7cie";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sw9D/vYm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5357B10E39E
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:46:19 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L79uFF467171
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=; b=kHtH7cieHkVvlPt4
 amzlnKDl37IMwUn9NHB4e7xhpEeyJ293VQGD5i6HA24E12l+KpTEDyY8I/EFs0Dv
 xYAvDI+A6eJMp0UEmRmYdW9WxPXs98Fcg8neSwBNeD2YYVqRRbqE7RQDzo8oW8ks
 uUF0fK7SiLd0zv42+y9VlJgffgggRTzXWA8FBd2mndCIVNWbWMtNmRi1KQyEKZ8G
 cuEv/0n3gWYUnzzbxXKxIworWDeYJOsuP28Sc+HQ+X1rPCdOseKB01QlXpTNOccW
 n9o0/rjFtjf4xavMGQbrtO40u6HnMCgegUm3rde71VoOD5AsMMtLFBg+mdjFynV3
 aKMkVg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8b9r2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:46:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9392788b3f8so82577285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789980377; x=1790585177;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=;
 b=Sw9D/vYmr4YTeIO6g5S8QHGFxyFJo6zoRkppQ0A8HH1j4t5VjqZFbrpkNch18/RHqL
 X6Jekb/wjqmRx6QphZuT7jqdYx9T6M8rO5v+jWE/QoWqoUIGRsOThlyvID+l4O4Ljc3W
 arUL2mAXssa4SiO3kg4TW5zyK5IjQA0U862qp4atLZJc0GuLT0NI/AiGRhIU86SKq1z8
 0jS5GGKX01RTd934kQ/WmFGrjOH79rxUcKjz7Jc9IZeYxB+erq/5s2P2Qj/xzJ9UZMyg
 bvNQDPTLBjvrC07bg4y9IMivSWcTUXnKT2f28umYKLR1kLwzmhcPWKTlkMKu0KUW08Oj
 ht7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789980377; x=1790585177;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=;
 b=0SHrQIfL6uIYNxlyER5/8iOyroFiedtkdDmkbAt1jqDBiXBT/U0N8g/oVmqLlB+o5p
 NPM8S/c+xnBha2dBfD8Dz5t0TbS5uyzP+kQJykqPTCtYqNQhBzAsusUq7vCoSzGI4MEP
 kidZ7DCPF6jmK8gvCnmzhg0C2VunS0edVvtedrbJ+cNZ/6KNe70bhEsWYLtqUZIT0fEq
 lwKjEyyhGOuB++DdFLYMEuYvpr7zQqukStds5Yx01EJCYrrUNl+Stu01Kg9UqVVyk9b9
 MN05iS2REeQBdk//Qcs4GsP5sjN0i0yXqE9wjNTzL2o1TdGNhfh/TdbemMXYYhmWkfEo
 Ey9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxguQ9CRKtVr3jkCeq3HY0d449XP6WAY2gFHsY0kpz6HZDwW5GW35uEFzvVdE7YNEC1+4GWuypblIY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m2dQ0e4Bkuv/6qdoueY4s/M+VTUJab6LUxL7az7WBLE4E0wIph
 6KbwjUqMyu7aoYJPFWVVsmfQLp7sh6sDPriCUs3UaUozYgpWZ+ZejQot7xKA40TlwR41FtA+8Iv
 b9w2QAAXGmx/hhrQjbrO0Hp0RFpYyOIe2+JLyed7IYYdVMBEynGb/so0F/h8A4zjeJ61zkFQ=
X-Gm-Gg: AYBFou2TcwJrqm//m2/BtN1zI3G3GhvlOERCqZWlyDQgmT+O9ExeOslvo8/QBXzLpdP
 3rHGgUkMonZZKsypBo51XaX2E1ohz2cjChJgnLWURDfqs8EqPoz338OlRSZpCZFpPj2fse1lY7U
 O8d1GgQTnX9W9LEVfj0DFN0tFBquq/o8asziR5adwQaE9Mi3xayXa5aR/iyNYnmmvxcCz3TnH/X
 ACzt5zFwiFxB/ttqJEFdAmnn3Hu9gVNu1ziH4/ZB61RLnAkFzEnzZu2KC+oK5Leer9kd0KlKbCg
 o5TdlChtluV6DwIjN1ROHvAxw1fRnsg+Fk/Kmz+Lw5DIp02LaGIfQ4P8zDvPNP9aur81AViwo8U
 haG7JLQxQUp4rFUaKzEi+Sw==
X-Received: by 2002:a05:620a:1729:b0:93b:c6ec:780d with SMTP id
 af79cd13be357-93bf57df974mr940252785a.5.1789980377375; 
 Mon, 21 Sep 2026 01:46:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1729:b0:93b:c6ec:780d with SMTP id
 af79cd13be357-93bf57df974mr940246585a.5.1789980376913; 
 Mon, 21 Sep 2026 01:46:16 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a358ade5asm270916366b.51.2026.09.21.01.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 01:46:15 -0700 (PDT)
Message-ID: <733a3b6c-4278-405a-be52-0bd22ad1584d@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
To: Muzaffer Kadir <muzafferkadir@mainlining.org>,
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
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
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-2-798c2602dde1@mainlining.org>
 <af3f7261-e4b0-42fc-818d-80e760cddc2c@oss.qualcomm.com>
 <a47a1a0e-559b-410c-aa99-9230908c2fe6@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a47a1a0e-559b-410c-aa99-9230908c2fe6@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyNSBTYWx0ZWRfX5d/GIyXW9Rnp
 0lyjVNaSf8q4vfk+eWfzpuoWqeEWww7mZaRDdbZP3TM6+zchj7QulGmApnhs3RW/ZXQdh6HfBRZ
 2wkOwNmm5Vdg+AszBDP74XoIb6SYXSMpLVfPwCslCoA4acTP2qLajPrEay1qQYJuZTqw2A1d/u3
 XRxBzXCsjHImYcnycqC04TRqmRez9ZSWg53f4XwG+l+r8nBhqexvO4AvT5UPfWoeTWeOpO9xw8Y
 GLeFK9Q62D6AKySMZ7IUUBGtWJDhfpnDxUgsMi4fx7TU4SKVBmE0Xez9+ANfiX+DCBsaEgBWDX/
 hvZTE76wpX0AMPdlRoATMJ6SbV9CDXGWoElUUIUOJP9yQY5BHC8C5t3AqyBAziwpIOoguOKbBCl
 PEQE+2pFtKAmycM539QdJ391lI0vlym0HZjPqrCQu/PeImyJ36JiRMEMKz0l4LpRwanVEpcpJ/Z
 q5f7lAmUEVich3J2ZHA==
X-Proofpoint-GUID: A3_h-jIIIQXD1E8ZffpE5iUVuy5SxP_g
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab0eeda cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=IpRBMZr9S9mwpYgRR9UA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: A3_h-jIIIQXD1E8ZffpE5iUVuy5SxP_g
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyNSBTYWx0ZWRfX6WMOFuW459Nv
 M8LjQD0CCoU+FKXb54y0Z9DVtgHjnB9s6UZYbaX2EoVJnG/aqrSOhDvoy/8dXsTTLj++tAQpS5b
 oKuAv7zcGyg036bPr40I6SlSd8VO18U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210125
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

On 9/17/26 2:25 PM, Muzaffer Kadir wrote:
> Hi Taniya,
> 
> On Thu, 17 Sep 2026 09:49:07 +0530, Taniya Das wrote:
>>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>>> index a6c676f68b79..3c3f27dcc68d 100644

[...]

>>> +#include "common.h"
>>> +#include "clk-regmap.h"
>>> +#include "clk-pll.h"
>>> +#include "clk-alpha-pll.h"
>>> +#include "clk-rcg.h"
>>> +#include "clk-branch.h"
>>> +#include "reset.h"
>>> +#include "gdsc.h"
>>> +
>>
>> Add DT_BI_TCXO enum.
> 
> Should I rename the clock name to bi_tcxo?
> Or should I use DT_XO for enum?

BI_TCXO is the Qualcomm-conventional name for the clock sourced
from the crystal oscillator. I'm not sure about the BI_ prefix,
but TCXO stands for "Temperature-Controlled Crystal Oscillator"

Konrad
