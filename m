Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364EFC88E65
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935D110E7C7;
	Mon, 14 Sep 2026 11:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p74lKPfG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WuIPTE8+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43ABC10E43E
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:18:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EAm6k83291488
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lu8CNw9bVINJIb/MTRXcrF6ffg/r+0oykIW5TY8O4Y4=; b=p74lKPfGoxBk3sgk
 Nv7jbyh+PyzNnEZXmPSeygceSiRc+hzxKGqPe8gSasJEoh9jI28KkTBcCvBuJBBC
 WzTOXA5JvbzXDVBVkTe8WhQNutMRPF9it0XS3DkwhDoWGJi87AXJ0+RlvEDct+CO
 FpWCASMm55uop92Bmk6T/9dn+zzxgMzrOQIb0RYNCmSme9cM+opFd9GTGy6LqdXv
 WLobHlPt1oeF94En8pYt/HsObrlB/40wMNOpvIJbiUxfXCT87bg3586GtWX2lorZ
 K+KSP/tphg2ZnwVCfvi3/hoL58VYSv1yosERpux0u3wiqzMpl+SntE0EUvlmh42G
 6L58/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperg8ban-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:18:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93495488976so55599685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 04:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789384688; x=1789989488;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lu8CNw9bVINJIb/MTRXcrF6ffg/r+0oykIW5TY8O4Y4=;
 b=WuIPTE8+jRVyYFrRmu2+cSZZANw6dX7ZKWbcstR81TJDeqj3CjOb7vM4yWE/pjGTD9
 xj/wzjlKt/IW+mki6lAGDlnUjnzxB9Ar2+7O8y7fjfwMYRzR8BZDqJAhLU5xRKOvXV7H
 hiykyR0ZtgMp89GryLmdfi/xcJnwUUAm27nOhVfMEgwYEMLMN5JHqPIIUgKoEIBMbYCR
 tvydj+cFV4PVm8HJmsos+Vlb55CNaAZ5CDhq1QCpQqnc67q7RXvwZXhSnZRZaFS7mtxM
 6npiFLuEd1qqwgKM16F+sLtWSHMh7+QCz/Y/XW2C70iKZn9ncoORoXRBM0/U6wDrgBFo
 f0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789384688; x=1789989488;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lu8CNw9bVINJIb/MTRXcrF6ffg/r+0oykIW5TY8O4Y4=;
 b=hNKN4srHuwLXAUYS7Z2ivoVfrP/pwIEoxK7VnKneXGbKjvA0nHMcfwSRT7n3GKFbvM
 Xo9Lkqci9UfAqqMYusBM+qmn6a+x9ie0ZI6Ixe+1ERt5FrVM/7cyoVI9Roxoyvx5RMG5
 oD69mYBjG74HDBrFdsepu7Ft1SSV6paL/YpREsStBQLq+gtIk82EiHHlJhr6heHdtlzM
 ipewvI6zauc3mbNk7d1IvPCur4trwNby96N6v+hmwpkOIVeGwUCfE2i6QasWFkEh/Zue
 zxLQ6HqiJy+i3IZXqbKSp5RiIOq42cRKtciQIOsCgqR6bzL9aAVJT4ll/BBulfQ8EFB0
 pF9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUZ2zxruqPhF+VNJhDB/OpmZkQdROiOnmVCCGi6Zo/hNjW0fhlQW8bxoLYhF1YCBp8P0atyWcsnPc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ky3rcn1/0OpXu+VxkY11/GX2ywRQMfCPWYz4CeVNJXVoFCyMkB
 F2HCXTR+64ERJCqSC3RHKU3AH7ji6eMAQIKYPAsXGt2ku0jVMhDtu/NDgR3pk8AyxQnvmAD3hof
 mJaVUtdP7Fh3mqm4Nw9REVNfpmEJKCsbAaLlAYnrAedL3SMj9khjuL8perUzyOkHbr+9o9NU=
X-Gm-Gg: AYBFou13mEjJFriGzRkoVQ5j5pqa9SLmoE/BQnPA+jSkjBbP0P5xUEUkEf7k2yfcpB+
 UUvzJgFImmxtmIlkGuX2hSPCVRN28mBPjf1/C9jsuP0d8O6MolRWLoAcgzRWkpqHgc/YgqJGUa+
 1TPU0LrwKzmonXq4AGj7qw0DjMRIEWa0kmnrXT/iptQR2pLpczNbayaw+XG7GLlL1Or13AjKRjK
 4CMg1v/C2SVXadTPOFRh/HqFO63ibtWOHUnSflmzvtQ6zv9QT0lwcYeho5YgJ3kIOpAktP+94RY
 lNPE+IVjcISPEDF/XVEGvp3NzdVDG+BhXDKCUoeLnqdZ1DYmxJIAsdFSlGI7uC1ObruMfS6yy3a
 qFCHBOUuykYJTW1wCyG5PVQ==
X-Received: by 2002:a05:620a:170b:b0:939:8148:1e3d with SMTP id
 af79cd13be357-93a2987c21fmr216472685a.2.1789384688319; 
 Mon, 14 Sep 2026 04:18:08 -0700 (PDT)
X-Received: by 2002:a05:620a:170b:b0:939:8148:1e3d with SMTP id
 af79cd13be357-93a2987c21fmr216464885a.2.1789384687844; 
 Mon, 14 Sep 2026 04:18:07 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b593d7dbsm4143990a12.22.2026.09.14.04.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 04:18:07 -0700 (PDT)
Message-ID: <21722931-0a6c-444a-b23c-59b47dd82430@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/20] clk: qcom: smd-rpm: Add clocks for MSM8952
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
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
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa7d7f1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OuZLqq7tAAAA:8 a=lCfP1g0v9f8vL_Xsk8YA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: JLk-EB6mqGZRfh4ZBvxYNSikIMXSdROo
X-Proofpoint-ORIG-GUID: JLk-EB6mqGZRfh4ZBvxYNSikIMXSdROo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MCBTYWx0ZWRfX3eF6blqacQWM
 gi/UzAWlClHw3Rxy8apsBpXy1vwqvBRDRBuIzvxmF86cGYPjQ1BmIItNICdYxXMa7T2w5IjOnMX
 q6yGU+r3tEgOeT8Fd04hx3BU/7MIAfCWwtTjIfKvCfKc8N3h/76DoWhIZxudwWoRK+beyS5lqwj
 QKDg0jlcgA/JEmXKaViNGgGQNEB7ag7PuagNk3+9DNiSPPrv12aIVFeYEWE+5BrZTidyw+4ZCSt
 TA9Gc4mdhvZtL9RtH67dFOO8V4ky/nwBYGykSU5qbwa26BaptUP34mjbG5j0tmiiKTdCRvkNWli
 TCx/Cg/q3lQA/zLRmLmEmb3yrsmzRihWTlPljllQwwAx9WUmnek3pnE3zO0j9EYe+bRIKpNs0ln
 EWmKH/Cwwtw2V/dIIgF3bMHAototqaNfX/TBxJG//ffm/sj/B/5SgJojCqRE8qRVjXeWhC7mGos
 fGSsB+tp0TBWfrLrmYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MCBTYWx0ZWRfX+UHk3+28YQ8F
 kJyppHogvBVMsUIzh12jC6ChVoh1bV7ljcGTRQnfT5zTjABmJYuhS5HsYppl/qYO7Yo7rbnmCrO
 Oo+XcW/Lm/1wB7KdDOHcqT0wY5LwTx0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140160
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

On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 has same clocks with MSM8976 and MSM8940.

Let's reuse the compatible then - add an entry to dt-bindings
where we have a 8952-specific compatible in case we ever need to
act on it specifically and a fallback to 8976, so that we don't need
to modify the driver needlessly.

Your DT then would look like:

compatible = "qcom,rpmcc-msm8952",
	     "qcom,rpmcc-msm8976";

Konrad
