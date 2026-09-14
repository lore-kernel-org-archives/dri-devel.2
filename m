Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A02C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD25210EDE8;
	Mon, 14 Sep 2026 12:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnamtNDQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b+Nfol6C";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A5E10EDE8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:01:21 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EAmfos216052
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=; b=nnamtNDQQ9gHj/1u
 8u+wb1s8mTP6JWRKxKfdX3d8ABVXd5kMHmfW4wQ9nsSyRrjYa8WkAnjy0dXdtaEo
 h2enOSMboZOQCYy8H/CFLdd9f7u0SAjuYTs6HsjKsSMJyk6o6xUB+uwhBjPWBiyu
 sicjPLoGajNYaGVa0l8fMYcMn32TORMoX1I0eqFvp30N4DUbJntsg9O1Mb2f8SY4
 vyxc953Q5FSjtqXmzyZ3M9e1jVgMce4t+MrG76KRNx7HpcRB8WhzKnbYVSsGWoj7
 x1ZSWv1V0N9dsqSCWcPL2ykRO9F2MIYBz8r5t+u5rEJnunkGwCFUwiCOgKAy+DCQ
 w4ofBw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9degxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:01:20 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97ccaa613bcso31933241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789387279; x=1789992079;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=;
 b=b+Nfol6CzPACFLQPn4dypPWXiASWnplcM/yuTkLQWx1tsIZDd7he5Uyo/UVCforpIx
 e1sd2Bf9qgTWXD4vG5GzTiU9YEaIAGXnVWnLLJY/PF15pH+DrvCoTIBXB+EId8yvWGcG
 F/kNXN4SypTkDqIax7tW62ieIrHmwYB++5rSvbkNpDcrmNjjL+AX6WTs3f4joIP69zzl
 RHWTszMq8KvgMMg8k9ZsjtLdtLGhNLOaZPobmZpOXi0p0j5H1lbOn/Iqvxxh2+bfIXpK
 G5QVtqEw1bBXNcEPWf5m9p6/qRv/yOpFMY5MchGyeT14i/Cmhz1bGvY9Puhi5Gp9/X9n
 jDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789387279; x=1789992079;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=;
 b=b0cel196gWvQ0CxlCJffhIowIP9IsFrZm9QnVvtEMgL8yh/PjXXhs22DAcu4hTxqkb
 w0IJiWjew2dsyuGJwQdmpHwjAsmkwL3NnBh7iAJTnpop7ygeF2ndwtm7jHH67eHq7DJI
 BPpX2NEHQ54YIPAfy9mJEeCjcQnCYljnO06uLFXJYjceRcQ/MUokg3WdJB0IySGj+ly1
 U2W+A0pZJMIK9Ucjdvn39MlMmVQhCkjbZ7R7m89fGmymy8Q5TFkfaaTzpEkPmblNEJV2
 U7mXABJStV/a9zaIahlWaUeCzeMOtuGJycUrJnmE0tLbZ+G+WfQ3Ccg9t2I9h3OBldAY
 eUbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzDaOxDTwbcXJffGYfjDZYWGdpXMaMZSO/FpqCEUYXVFz5ApjdNkHB9FFcldwhw3PC7KKeor8Ndww=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kz1RovOnwtDM2m4dyB/taSgkmkuKwElz/CAkybCVqHdRj3v+bl
 8qcBTCZ5d0V8xQDRMhZqcHgkM1Lnrtlbrj+H0PeNj5YIVuER0fR0o2lhv+Hk/QaZJGExq0txqB/
 MYKQPrKmBTUgLJ0SVagMJ2SVDkJttAdxN5KcGo/RTtT/LkmaH08qZ1zPnS1HnM2Q4fStEzqk=
X-Gm-Gg: AYBFou0/kvjBlD6UWD3bmBvCqz+7gRef+8ijrDC5cKj9TUOGFOa3vaNfeeSTg2KANjc
 xZnBcwW73zaQIxGQs3wq+rd07OWYHXvtP6H63ZEURjrBGUUfvmi8qRhLguG1Rc+QPlZQfTpiUVE
 aerhqBVI1q301g3YCe8K+iQvT9CmCDMgCXmIeqg0EjZS11qeCPFsqLF4oUJx8Tv3upA9xQHKYA7
 uzTP3Spx1cdu4+FITqC5d8Ma5/HdZ1Kxe2UiEY/jihNkkG6h75vE130QslolO8ImwXAsmIG/r0d
 vF8XHs2G5axlqVP/MjXUxz2apZ5j8K6XL9lp0c8P2FETnzBVdnA7ZZxKV055TaK/3+zHYtGnHyg
 uTG1HFA4aT6ryHPaadHmCyA==
X-Received: by 2002:a05:6102:149a:b0:797:576b:a9f with SMTP id
 ada2fe7eead31-79b5be3a274mr321833137.2.1789387278959; 
 Mon, 14 Sep 2026 05:01:18 -0700 (PDT)
X-Received: by 2002:a05:6102:149a:b0:797:576b:a9f with SMTP id
 ada2fe7eead31-79b5be3a274mr321754137.2.1789387278364; 
 Mon, 14 Sep 2026 05:01:18 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2965c4dfc7sm417817966b.4.2026.09.14.05.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 05:01:17 -0700 (PDT)
Message-ID: <7f3aed88-fd53-4cd4-a316-630208e7c08a@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/20] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
 <d0d7e3d0-15bf-4850-99ec-44d429c6bae1@oss.qualcomm.com>
 <42ef03e8-112a-4689-aedd-eeb7ec9b4f58@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <42ef03e8-112a-4689-aedd-eeb7ec9b4f58@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfXzU0gFUYbdIm9
 aiCZGUtaMLMiveoEkpCDczG9Dm7p4dtpX8vYEwS2uAlYmiJ/USxWUUywkcnL5NV1Z1nyFVEk4xn
 e1UMfutvib8ApFW25KVl1e3tPQkn1QSGdg/mi6NUOmGjA9CtpWMJoTpd2N9/t3v+pHpI1o9KsTZ
 H/C36uHpmyX8wJBvfoIDa7nE69sByy6NTcc+LWBXXJz/xa4b6Uw58vXmRAnSO2plTv+A6vw7cEm
 EgdODv1lIMW1BaiqEjwYNqkxsmTKrbtGfmd0HRHJOQ1s0N3aIP1UhjbXNHQuljCp1zfee4rz7/Q
 GF/5PL+iiOE79SoVOTKYWzIjvVfoDiKIYhHgJ2UI1jLheLLGslCwORy+d3OaVr0JvATcLPapC/v
 j6RJ9PVRwl2Tb6odQLUKzvuksQXGTRJB6Ojv5Cqj0KoPkmo3eCg7KzcZ1+slzeZFO8d+bBtUYvF
 xleh8nlW9RR1Dxh4NEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfXyz0yC6GAmdHE
 7hEQwpLPKJhlc7UirBeWEscYpPAxR+5zLWIG4QhXtg2eMvRzD8qMiuFTBCjdmYDZy4ELEuVuWRI
 O6G3zKayBCosKCbucYXOXmiqUHc6L8U=
X-Proofpoint-GUID: NQvdtw4XulHNgJctLvGTeI0m0D0M7Wh2
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa7e210 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=OuZLqq7tAAAA:8 a=NPzieGulNsBdfkreKLwA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: NQvdtw4XulHNgJctLvGTeI0m0D0M7Wh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140171
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

On 9/14/26 1:58 PM, Muzaffer Kadir wrote:
> Hi Konrad,
> 
> On Mon, 14 Sep 2026 13:22:52 +0200, Konrad Dybcio wrote:
>> On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
>>> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>>>
>>> Add General Mobile Shamrock (GM 5 Plus).
>>> Shamrock is designed similar to L9300.
>>> Downstream reference is [1].
>>
>> Please feel free to
>> wrap your messages at 72
>> characters, otherwise they are
>> a bit hard to read! :D
> 
> I am sorry to hear that. vim shows
> it less than 72 and I can't see which
> line is bigger than 72.
> Only one I can see is url itself.
> Should I move url to Link trailer?

What I'm saying is that you wrap your messages at something
closer to 40-50 characters, resulting in excessive newlines. My
previous reply was an exaggeration, pointing to that

Konrad
