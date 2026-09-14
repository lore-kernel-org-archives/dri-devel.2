Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7304C88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7311410ED9A;
	Mon, 14 Sep 2026 11:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/WVOCmY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ksLuUUVu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E280210ED94
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:23:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EAmBsA377959
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=; b=E/WVOCmY/+5Enkgw
 YEeOQ9dPHJUB8CWxTR20yFYOlY8UkoMJaYfEbZw5mtWvnO47B9tf1wMQPeafNwuh
 wcPa+7jFxuwllxPm+71b/159YFvZtg/2RACZvfhGXsdX3lRflqfucbjNfAT60rpW
 nT2W6tgRlLZN6L+MSJ/TNerjJkANtic5DzviOrYF00TQxSgNoyEqEGVr9kcRPO/3
 gIuOu7yV0ud+xAE5Z0o7WnQCbf35GMdm9FpQLiSsBTvoxEBODy0Mr28DtrxMTC/P
 1BajQAshRn13edHqPJho+jbGH0cD+CYPJc+8jjhbFR5E60BgJZv+Py3P6XJNpBgD
 ZRcYpg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpecs8e8s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:23:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-938fd633df7so48950485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789385012; x=1789989812;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
 b=ksLuUUVu3qbOeeSzPkBMVzYSIlDz2b35BS9TyjjHbvzqU03QugMc3XmHaq4sehbYJ5
 QGVAMRS1+qVxQAga4KCdsNAJEjyIwk0A6i8bCP5trykaFsb9lFzm6M6Vb+G5a8KX8LV5
 L+3N+qvwrg2zJcUdeEThEXku3WdPFp4jhUe63nJcA6uNYssyCWNa48F7Gn6Fsk7KgJZC
 iCPgVJQ2agYYmuXKW3vcSxHjFX5fJ6jHQp/SEAX6j9ChoN1/sqOXZwZ5P1SGmyy8rB6o
 SJ/jC7/IUSv1wreo/42a8WkGoTNIRoRFkYqp0ks0HFPQUe4bw9RnW1+jtDOzmDeqwMgS
 fbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789385012; x=1789989812;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
 b=eP2Yv+/T30MF9fdmVupgO9dc8uiQGO+afVQC6tti0zURhAJREl/MG6kQcWtTi6MtLv
 QT6QPKwKZpxL1iVSVtKsYY6SBeHoNg6WydOsJ0MGwYg6X3BR3izzASMf6MSXljFU6nNm
 Ju8aCs1dk1onm3jI8nRRSWHFpvyjKer6x4nfBvnp66oHsZrg1BmWreEaOfCCiOdFeyRX
 uUAU5DEBDjsqsCTnc5fZ3mCINhx1ygHUex0s97IuCRM49qVVV8JYcZKMorNsDE3G0d/E
 zpH0tofuM91qBfoyCHYnPeaM1y0vPvHtUk+yLdffdOGp6ugykzZfLFmUwxqENBCyiZw+
 w9Aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW4ixb32JuY6WFeh3Z11XupwkMYZwW+GrJE6nOrKCLhwsziVoTKLy4+PW38dUykiARhwrFWy0TSms=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mEsuc8KHw3ECJvb2dgNpoclc5FixuCcEGurXjcMJBx5efqIFLV
 Ev2JvT3uR1zR99FMhQVVmkcpktknNGcOdxUjEk3U9zlStKKQhikNHtp+W7EZ5vX4cGjIQiQUqNr
 GxtnVE0O2lUAcz9+p6dxg3xfY2yaPqOrdJ4grGbve6o8vHJkgOuDuyz4GPZ45Ge5Z9gGOTO0=
X-Gm-Gg: AYBFou31sGnI4gy+yQv6gKbDP9Gx8nslo6UxdV3XOM2JSN98qX2678EoggcHU7YrIK5
 Qm2jo81Cp95/oSEtjoMuXT/iZfbQZGdWn0qsK9WIZCLpWL5zwrh9fDj8TpX8l+y/cEfh/TRmxw0
 5gmgwM0KauFxLksKd5ZhQ701/t5ZDunON0FBsnWGDpsvH9UK1hps0Nnr9+4FDDoClmmtu58gEsB
 k20Jcvt2YG+QJ6gwWsBhuFAEQnsNk1Ot7tAOMtPzSgY4loLRfKkxxcgVq8zn3JfWNmhRIJpppd5
 fXKz8G0i04qTMGAHsQVVyLWWQ29dvDPoGMpWISWh+eRS6g4QHTp5YzDObXwzGM+8Ep5PuM5s3CP
 OWq0SLufXNsV9k31UEstizw==
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id
 af79cd13be357-93a29a8d250mr214286685a.3.1789385007362; 
 Mon, 14 Sep 2026 04:23:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id
 af79cd13be357-93a29a8d250mr214244085a.3.1789385002074; 
 Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c296601f4ccsm406660866b.20.2026.09.14.04.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 04:23:21 -0700 (PDT)
Message-ID: <757e124a-4c7b-4d3b-b73f-19e7e39f2677@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
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
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfXx2L5oZAWUOY7
 jYWPP0gNI+DIBOOoMM0cdr4gV8BuGs60BHx4VXRTLTfgmShv97k/RHI+sonxQLxgh0j5wjGCv9K
 Xn+gpDIVXwmdPkyjNx8p7cz0H3dWh3I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfXxUwj+XfYF5Fi
 AaIsDdi+1z4Q4YUek0foiQZ33QccD9OCm8n+SY09713U1OgqWXT4kQbIPQ404V2KXChu8mFcLBZ
 Epxaf4hHE6b4Nr5Lid3sJK/acZ+CcJSg+piNbVAhEBLSfrxX1Rwdn4xONqvN6NT/mQ2UTpnHIEA
 i31T67QfFwJ7DDZgXfaAs9zLDscarK5HJ2EEsbnrYdlQAYJzNyW5WgIfhUE7J/WAfZs0CDXqv1i
 pwDmk9mY+nf1/thTUpPTX+yxH31kPT3N6y3riKUlfg5S6pm7tqkQbo4dKF91BHxJpejQuUlQlWd
 7thWOnVEM2Dk+6WAMbcs/clPm9qn7LvGBpTI9C4jc0duCPlD6Ji2cHE2ocmwSh1GWQ18SVURQ56
 cODiLAIrxYwY/h50V6SyznbjOxuASOfS2lsFUgQ2+TqVu1bFICYvS6iqpdoGwHpGVxfvOBYz9dp
 PhThVWOgZ34QmrCC6bw==
X-Proofpoint-GUID: 9DXkbDZGDHJRLkPZ2AsO_S0NZBuNMcav
X-Authority-Analysis: v=2.4 cv=b/cncdGx c=1 sm=1 tr=0 ts=6aa7d935 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: 9DXkbDZGDHJRLkPZ2AsO_S0NZBuNMcav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140161
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
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
