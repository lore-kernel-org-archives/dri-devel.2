Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C7F53D78
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2D410E3CF;
	Mon, 16 Mar 2026 17:13:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/cKhH7r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcPjDTe3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B356410E3E7
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:13:25 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GECTmD1639402
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oN5ilBs54NMY7s7tXbD+WAaAkVxOjXggBdGOFWu0Q+I=; b=W/cKhH7rnwikR4GV
 IWIJF6BrIYRQ66UxaWJFzHxCpC1QmNg2fiUMPpHPwa7hQBEl6+DBpz08qoif+ayl
 G8N2u3yftkvb367mYu3tMHliCr8sukkphyeGKsTG8FRxUEdVmSu8jXqXvTamZSr2
 ipAOci3VLCqYv9gl3ICTwB+Cf7DEA1VvvDZRA+dcu5ZP8hhCf85Xn1a5fg4HFvh7
 FpUXCSMZMfw+UyaIET9tWyxGwE/X1yeyKuVbHsEapfWehEMT958hcxpMwhJUMGlM
 XmLQXVNZG+iksENobEijIA6du8gr0uo7ZRxZ2+sBwge150xjHInCQPJLwPD94yiU
 ymT5Jw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxke08pq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:13:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a17ec1eecso36782516d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773681204; x=1774286004;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oN5ilBs54NMY7s7tXbD+WAaAkVxOjXggBdGOFWu0Q+I=;
 b=hcPjDTe3xyC3t7YRrIYyQzGWYKcNMjbH8AZEobiVu4bBKgMi5b5Q9Ftf/5vcNoQmzk
 mrrzHtYpVWCdiHt7d6JrhdakQsZX5aRzBI/ULnBy2Om1M55fUu9nYbAGRIluu6ArseLo
 hDG5YAp+vvpSTyGjPceKs+Im/elCpJPWqAT3XSfajMe7x0E54KK2tfOBFfg5rZ4+KeKd
 VS3Ly/UuVkxaNyA/vbQsnpgBAxM+DTCFvfnPJ2ryjgc2fMgYVuX9M5BiS0YkwxF7R3GB
 57uDAfhFwVSd/Ks7DZyH5qH4CDunp5/ROx15riCRxTy1965yqUI09Zo4DM6o3vHhhk5z
 TIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773681204; x=1774286004;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oN5ilBs54NMY7s7tXbD+WAaAkVxOjXggBdGOFWu0Q+I=;
 b=dD+XDuwJWaSg5qKzU/pw2+/qjn4LirA4kXwFP5r09Tr3YN8rpAc4S3Dd5qTkRjnAKh
 A3A7S4DTypmxhnCtZUTGKcinRLlor3PMkcTnyAdZJJKE9b+ra+TK7oeDgsCKUbO57hO7
 Yiz9KWZXh1mAw/k1uMuy6YgJtv5a5B23JQ5n1EZKPam6cW2SXhacszyHFdx3ZaOsBugh
 TjqCNsyVtanZTXBAr7yXhlKJcB4UBCqzVJLpiQMxJ0w8XML0RI97ZBq/eGyv/Uga+v1Q
 pK1Cz/P3IuwO9TDJXjO9hJ8Wakt4BBzusbwHhbQTAN1LE6pplavVaaSxGJ7vvxQOqgHM
 wKSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhIdOwt1kc1v5+UrzR85EatTOgNJwW13Ioubsct0Sfioo4denB+R4sFFcJ2nyk0RFzist3KV6obkE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHQ/R+/TziAYdMDjVyLNoSzJn45cwnmNAt1MXA2eMcbyqcjyPY
 7Q3f9w2fO5ub/yCegbN02Z68FzaAab0eVDJu7laNgGXiwkYb5chBFHvjjWdZ9YKePlc3XD0Vwwq
 PUGdsUTIZGT1nTgPOKjZwWtB+kEOuoQlLOCgq5n7yPF4YOQUChIrV5xCvFW6eqxIo4hj7Fug=
X-Gm-Gg: ATEYQzwnDejHXcJiH281oc78m8l9fpLqGsbQ/GF34YJOd2GrCelL+qpdUZHxbF4maRd
 jabn21+4ZOinVmml/rxnXfNBGzzOFJOozNaICr19nyJLD5Iusa/MIOKZv3WpvFAlV5YN/bKGa6+
 XPScROmXIvULktsNIgzwF4tHRklWAMl/+n+nSdBzB+3l6+mhS/k9pwwk7TRhzscai0fPOzQIHvb
 drgi515opZ8QU74jwgTV+bo7HPZ0Lcbk1qY8OrsHCy8m4Mymco4q4H+jDD1k1QOevoKaG6sLC4K
 lfuaNUsutzBTJ3x+tw777q7L/YRpBfhfVLIetmbFhUXALaEyNJRetlhY9ZSYzWM+QBX5jAXfURu
 qp07gI/2rMhlxY3EnbXdFK6IoHJOiV3JITTarLH0WyjGoWdEYwBtPsuJDNkezTtirBjvwx/JAXK
 cJCAObRXkdiiQtAMu9Z/JEA6Izy0Fk4YIni3A=
X-Received: by 2002:a05:620a:4506:b0:8ca:41af:32d6 with SMTP id
 af79cd13be357-8cdb5b7cc90mr1834014085a.70.1773681204110; 
 Mon, 16 Mar 2026 10:13:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4506:b0:8ca:41af:32d6 with SMTP id
 af79cd13be357-8cdb5b7cc90mr1834007685a.70.1773681203525; 
 Mon, 16 Mar 2026 10:13:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15603407csm3596564e87.38.2026.03.16.10.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 10:13:22 -0700 (PDT)
Date: Mon, 16 Mar 2026 19:13:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Alexander Koskovich <akoskovich@pm.me>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
Message-ID: <f7k5azkvsxom4gspszulgmp2qpldrvzko3bfcxo3h6bzqwzkw4@iakx7hqqahio>
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
 <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
 <6gxzcgwzvqoaqgynwnturjybanjrk2jmmsa3qh3r7vafyyzj44@dfzkd3vigluu>
 <CACSVV03tAeLuwuHRqnaSkSgtGj=nJ5Gt3bzLJZT9SXXRY7jvfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV03tAeLuwuHRqnaSkSgtGj=nJ5Gt3bzLJZT9SXXRY7jvfw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: up30JFPZA-2pBQlvTxl-YWQFy_ad5QsS
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=69b83a35 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=jTlme-6co1faQppK_noA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzMyBTYWx0ZWRfX1hCkrzdhabnl
 hRz6FSMvFrbJbaPFLejwlmnEEVFnpDSa2HO/irRbE5s/t9dPeEjYNgeuLhaHFQS7MocehuzlSba
 xvxuJC54tV+wrqmSt1ce240+ZX/7b5lq+04PHNQDsF8gmwtDBgusdvJOwEPM33nOAkx97inED/w
 le3tfMwp/F8bGtLo09YszJV/4gOvxf+nAmlxwHD9c4oIeB5cBE0qMW7yXVRnR9ObTlASkyANp7q
 R/N+Dzv2/vOzV8+0tlAI7MAVhtw8xSosiWGDP/b05n8vhmex9uReBxBh5kz8d3Eznetq3yc3ST+
 Mzso5RxoW/mtaffgD9s6PwEx1V8juuIa5wtBLfMLcZki4GtN83HZ7pTJFgbfJPGD5WN5rQIVzZK
 2fUsCBNx1/0g8UqOb83dIRw+gUEMAj827Z8zICZ44R1iEu/ZEdS2lf8m+CfZVQgMeYWzLx9Fika
 ft+vAB9XmQHX5ZPWlQA==
X-Proofpoint-GUID: up30JFPZA-2pBQlvTxl-YWQFy_ad5QsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160133
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

On Mon, Mar 16, 2026 at 07:34:42AM -0700, Rob Clark wrote:
> On Mon, Mar 16, 2026 at 7:28 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Mon, Mar 16, 2026 at 10:22:44AM +0100, Konrad Dybcio wrote:
> > > On 3/14/26 5:14 AM, Alexander Koskovich wrote:
> > > > Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
> > > > GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
> > > > to family >= ADRENO_6XX_GEN4.
> > > >
> > > > This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to report
> > > > an incorrect GMEM_BASE which results in severe rendering corruption.
> > > >
> > > > Update check to also include ADRENO_6XX_GEN3 to fix A650.
> > > >
> > > > Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
> > >
> > > Hm, that commit also changed the value for A730 - Akhil/Rob, should
> > > that be changed back?
> >
> > I'd say, I'm also surprised about something being broken for A650. Which
> > path / stack uses this value?
> 
> Anything that samples from GMEM (gl or vk).. which could include
> blend_equation_advanced, custom resolve, etc.
> 
> It's maybe not common enough to immediately notice something wrong, it
> depends on your DE.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
