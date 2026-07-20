Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C74EC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895A510E823;
	Mon, 20 Jul 2026 08:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnyNU6K9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DQWrlMWG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2204D10E81B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:49:16 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K8n7Db1858441
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U4TRP4xvSNyVfdB0JhE+MCDVlr664d7Kp8RiMueRA6M=; b=FnyNU6K9wMRETmm3
 ffdq5+3smol+CsUirmq1E5PsavHznKprjhjpPiFM47faouIdRRKLdcpcTNeiVljd
 YafrqNokQBsGQkgCYQRJGTKcbriUr7EFjtI/jK6M1CWbZ+WtF/EY+dRLwOJPyKVD
 RAuHg9zZ/CbFi1w0wa1TTW7t1bAnxf38OaUtLrPLTAwpt+/mX/bsDX9fWgMrOUpW
 d4jNDqU0VAGWyvLpXcr9TPi1eKnjcFkdxAlQP1wPpCVu/JlnkyJ1gNHhkVooVdHe
 lJCsZkDHBzEAfEray95brZs44Mj1ThNUXgxLy7mF0IpTFnPor0Ao3IZllhA6hWNP
 GBlyCQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhggg800x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:49:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e566bae1bso191063885a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537354; x=1785142154;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U4TRP4xvSNyVfdB0JhE+MCDVlr664d7Kp8RiMueRA6M=;
 b=DQWrlMWGPsbl2GJLeytJjEi24iGnJORkFRyTx4+jbZgCbKj8MCuhNwnloVuF7qq5Ob
 8zsheNUy4idUuXFR6mPjJ0hhe/nG+ws31+TNEXtqa8OIYzE0ZuXlIGqxYrlH79Dm5F2k
 dQIYXQxuGgAdszk9o/pGHhOSxrEuPoDPyWXfCpeAt0tSylePCAob2Yu394+jlr4n+X4A
 dZCrfiMpajcXD/F86dFvuEjYMdOq54zt3EFjAvzLnftIvhsJ5ke4N6752czc423aGq0X
 JHfqhyCR/6zF8MPZ7pX4dvgo6PAGrzf1iSFywkqLzl4y16uDlNpSOYR9GLJgRymdWoi2
 cI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537354; x=1785142154;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U4TRP4xvSNyVfdB0JhE+MCDVlr664d7Kp8RiMueRA6M=;
 b=WnYKaiOoq24X75CiBZTAG0Jbk/4OuI7RemUWc+W/fFMNwIpWJLqkxDqgzKqXBjgs1R
 2LVGEu8OdP4we3lodgvyzf4uzxHs7NUgfe+JC1userYOeIUvB5NQ3ng53AdlmmNLZP3F
 JmYiq4JYdLkQSXZRVLN6k+vvKPCMWFEG7JuDFLmqMdSItF4r1aVMEZ09hHP2HvXMgnNb
 x+Gl8rZIBVH8Mmxl9+0j1BhyfY+hckEpEsmpkxvUaUiUmAw4I0V5qguZgix6nkRoPfda
 bWd/tRJmzGmk6HhaTsWW8OhzWVNdeIQD0ElIc/FjqbsvS/nOXvpbiM2rJVYWaUnFrh/J
 3zVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYT3/GOaT6/WKestZTuJJsO8/R/Uq+TYi/LgpTKjCSDYPR05pzNWC5+gDAaK1Zqdwo2lPGOuIB50I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfSyng83T8g2Ulmpcma+v2+BXScCWE84ABBweo2ADAeIksVIHB
 rjm1Vk/Mz5wrJ39Y0B4oYNvkN6nZ0/lvg+xJkwz0ug7226j/fsWeY0vuX0dxsLSLhkL0FmOkQP4
 U3iPI3B1PAV3fBFJ1AysvyTEWn9xyoa0JLEzAzhNrFBEoeWlsVXR4EZ8q3zoqdgqAsqEBnSg=
X-Gm-Gg: AfdE7clbTIuiClzCuyiyO5P922vcq+zN5zzDgsQgMCg3w9NQBgRbNjF5rmqyuE7Zd5r
 Sf81rcy/4+GRhPysZTGD5LZIqvimwmtrPIQo4cYNugSzaXFyJn6eY+CdnniSrIMeDolaaxQOjl4
 xf4koDqkBwZlobYO/R+VRhSiQQrHpcwq2y3XmxWGEsNaa1Z7fwH7CbJkhRM0VpjGRQqIdgNL1/k
 M78BDe8A6yAPYewuMf8bhgkFdPeN1K/TSh1JhBO0gOVLOusqr2f0PWr9Ht7GcA2v1e4RCcdvJxN
 8WOB3BW93wgeurB6FkIkCxXhWiT9JFVzKgU27QQmNfwsbflrqKH37+9a2mhCwZaO3YDvHRjeQ3W
 JxT3Uz3EpjUCjaP0+u9BDLa1/
X-Received: by 2002:a05:620a:a104:b0:930:a08c:cf9c with SMTP id
 af79cd13be357-930b3ec7093mr873167785a.2.1784537354354; 
 Mon, 20 Jul 2026 01:49:14 -0700 (PDT)
X-Received: by 2002:a05:620a:a104:b0:930:a08c:cf9c with SMTP id
 af79cd13be357-930b3ec7093mr873165185a.2.1784537353970; 
 Mon, 20 Jul 2026 01:49:13 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6ffbba1csm4327253a12.19.2026.07.20.01.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:49:12 -0700 (PDT)
Message-ID: <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TSxDoSTUclNaV8PZNCBRzFFSHxalkVjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NyBTYWx0ZWRfX+ylziEcBzLN/
 RIjegPEIuwY/BvtU/rwsn7pLYZAqNEWRkXvpTpUcopRMdGQwNzXRzhylDmetSSkyrZ1WsQP2/hr
 59nY6xpw7XQv6JLDzleJg8IKonAEreV18B5jsaivYGIgi9R7cWEUqv+i2Vha8MEE8xB/kBzVeLU
 LbsgEVX19RSHerU2tuGs2ixJMBKcbxPw10Ext7rlIN+/3H9ZBmMeey55myfvD7ARUikjRxJoh8A
 3JrgntYya6IgIhnblchaxb37TQFyv1oFymL2UDMeEg4p2w3FhDhrqYtUWmKmKW0lhz++LZ/Pjwf
 zJkgY8qHdYKoxqcMUlBekph0n3kYuk+EauKm/V8dyXBNsltEG/qob+wAY4ikuJOSwxP46x4P7k+
 9DfdtdOJak98Z+xwR0rv7Vnqv+BLNWaINZkpFdD/PtxeSfhjb/6KJEpW/D6ytS4Kje5uG1Akgdu
 l13Q1ckMfjKEOw7Q3aw==
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a5de10a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pV0AlQ-m57JRmlyrAwkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: TSxDoSTUclNaV8PZNCBRzFFSHxalkVjM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NyBTYWx0ZWRfX6fBpwqIRQVxl
 Rv1jQxl6Rkzv8U09eZwTDQWTy++sR0j+/eKORK997tknzJ10qPoel6fe8+nFrxwUIlXm+LOARic
 OkzaXp5kPuu95Ga19RrelsdeCpO8F08=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200097
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

On 7/20/26 10:43 AM, Yongxing Mou wrote:
> Kaanapali (SM8750) and Glymur use two display power domains.
> CORE_GDSC powers the main display hardware while INT2_GDSC
> powers a subset of SSPP blocks.

Can they operate independently? Does INT2_GDSC need to be
powered on after CORE_GDSC?

If so, perhaps changing the clock driver to make CORE a parent
of INT2 could be the simpler solution

Konrad
