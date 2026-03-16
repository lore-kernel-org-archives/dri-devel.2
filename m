Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD03F506DA
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CDE10E26F;
	Mon, 16 Mar 2026 14:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9IiSBZK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsR60TYo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E031810E4CF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:35:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GCX5Tv1621383
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zo9jN8o+ApUVYkkh7NcPiTaOjGo6lkPT4XgMvJP/4w8=; b=B9IiSBZKXxo1eq4o
 YDY7yiknkqQm1pygXIzsW7C4nGjlu4lbdBpzli0yxzvxy+QXv3ZHV1ZlBJss0ApK
 FOLYR5Ag+rp+euWUiQJHoFNc1eR3P0zJdBrshXgBO30de32GIRVsl/v/8S9pBjBM
 2TV7Xher5fOKBfnO0Zn0Bo3L0h+WDChBfUB6JMZhOhe03HN8NT/Kf3aDBqVOKYyq
 ZS5HhWq6MfTpb/C3rGpgbFnAZFUMTpgXS099OfBhQ+TPzIkugPEqz1ipr8gKjeXD
 3CZdPH18jM0eJQiMzGEA/ti6NWjY0CDzrAeGakYVRBThGAaGwrsk9LsCVVgKQwTV
 W+ssfQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxhyegf3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:35:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd90210336so252456185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773671745; x=1774276545;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zo9jN8o+ApUVYkkh7NcPiTaOjGo6lkPT4XgMvJP/4w8=;
 b=OsR60TYofCc/J9V9IzTGWI6SuW3du7GJZiEwJsEjl3pwmixdpErxKWxGZUYFZ1cEep
 nsxHKKpgJm1b1AkuPjjSWYbhD6+jrALq0CDdKi3Rm6rRMnJYsG/Rygu1mP9oP476XXJW
 B6I46aIiYGzBOYyxvWYFILAIpbqqoz9wQ1RyFQZWQDEama+j79FDCJ8IKofr0wmLhB5b
 CBt8RVCfHiH8HIH/4I4II5icdiSzR2rmDKxSm0RbqAlGcRGnLERJDXXNVTgE0DzYe1P8
 MxiJX176Tk+kjP9bfs2tlVa4DwqgWGs6RQPo0xLGrWWSsNPeYUnzSLs8Z/vKtSnd+RIE
 LIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773671745; x=1774276545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zo9jN8o+ApUVYkkh7NcPiTaOjGo6lkPT4XgMvJP/4w8=;
 b=C5g6VSzkC0u3Mc6RVNesXq+4pZ7hM3Qypq/CTe/vT5nHS1Cin830aTWcIRWqUWM81T
 mdePNJr/BaxRpqigy84sg/9qroMq09MDxXyVUut/jMMB5fy8zsLrxndrOO9WfFqSKKn6
 7QdrDo7si/nikcUgFPasoEGzySE7QbR3OVf6+Aq7f467Sha+F2gz/RaJDdDKQeQzl4cj
 Xtzi2Jo4pmnh9qn5KrUXndo1YPv/DxMnMhV7CJO/39WiYhCD/1Tcjs5yYoiAoJhAJogW
 3HzUuKzpQGzJiDb9OI/tOHJ9+F7bDOmsoMub5fGEBwJzRB9Q9A4y82oeRO7Lg1CCvTGk
 SciA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwhe/UUhzJp+ElaeoxYTt9/N/uTuNIT2qC506gZ6OpzgcO4YKqwG8WZN/ZkWAGRbXnOWcAeVWJE1I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzORmXIdb1svyateZ5CM/ceIH3qPdm34bXf63MnkBv4mJ0ZnfSH
 sGLP9woiSSmV9+vb+8EhNEJCIXdk9RxPZZFVbucrB6+Wr9Vs4he5sRCNA22YaYBK41I9t0v/4+g
 t5I9iZpF8gJVoZfBoeD0rwY9KKtz11BTXLma1gR6NSeB6Y3Mbsc1dKkxXhve4/COvz4aLbeg=
X-Gm-Gg: ATEYQzxkEH/VhFN46VTdz49Yz9jmgETmOe2Y3MOUps1nKHt2gzaqnT9TmfF/ZlvToU8
 TyrlDRlGwaAzj93Uqxy+Uvk74R3IRIjcX+uD1mtTalqLrWLoJJxQh0KMkmPU62zzOUSgH8qru/M
 b3JsI6rIuwzo9rpsiMsvgaN3OfI0bMTfiKGJQ60Rot0j7FESiX+OGEwO+sOc/OL7MsbeslghukX
 a1T8nIbtEvJ5LVpATe8LPemQha56RSnC4UOthEbfwt8Z00QWUdbtQWJ3OsLuuuGuyH/U1KAvjho
 IPjoAqIVcn4KhWIAhhHhLRYB4VXYmebwc4TVk+ilHB0G06FIBtGKbJVKsaJsQEn4Kmx+3Lxm/Lv
 GCZ2BxYBpGSRSBk2pFCAybAeCFgaTDRrcrxrb1kZf1nWVz8dwtPtRRU5QRzftKpbEAhy1MnBPJ6
 NZhdw=
X-Received: by 2002:a05:620a:4625:b0:8cd:b2ce:b746 with SMTP id
 af79cd13be357-8cdb5a1caa9mr1277043485a.1.1773671744725; 
 Mon, 16 Mar 2026 07:35:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4625:b0:8cd:b2ce:b746 with SMTP id
 af79cd13be357-8cdb5a1caa9mr1277040185a.1.1773671744347; 
 Mon, 16 Mar 2026 07:35:44 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a155f33c15sm3385319e87.17.2026.03.16.07.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 07:35:43 -0700 (PDT)
Message-ID: <aa5af5d5-4ca8-4391-9602-23e1667c2704@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 15:35:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
 <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
 <6gxzcgwzvqoaqgynwnturjybanjrk2jmmsa3qh3r7vafyyzj44@dfzkd3vigluu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6gxzcgwzvqoaqgynwnturjybanjrk2jmmsa3qh3r7vafyyzj44@dfzkd3vigluu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wJc6e18L-msP4Np5j27LZOb_tr5kGqXk
X-Proofpoint-ORIG-GUID: wJc6e18L-msP4Np5j27LZOb_tr5kGqXk
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b81543 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Dg97ds3F-sJKPeOKljEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExMCBTYWx0ZWRfX8gyk18HX7ydY
 +rG7Dllk8h3LBWSnhoQl3mA6KAJ4ct/BSXKLf23y7BIKH2XUMEnTznN4A1PipCA8E6gZpJGatOR
 nJVsNzNidZRxfsVh5qGGtPcDLhmppXUAkYPAQWwP7PoizZoW7XSMnL7QaM07JaxEm17FtmEML72
 i9CuyGAMDFG/J30eRwbtE2fQmWzFWg4U0QiAhlyH/AS2OidAuJchfkUm1PPkJr0jPRU4t3SPqdQ
 khR8IskOaTh5slut2jA/N7x0OGnUKFT5IzdffA0vONWauVGR7ojKakX6Crt8o0z2JIqHs3r4wop
 X1TEu0oBTZ85YvpDzZgyfkitpEi97QP0crpRqYCuukp0zNFwnf1NIt/V4nQIAYiLHsQ2O+ElQRk
 2WXakoDSi9O3TrMXeBxe13R4Rc1C5wp2qoMsM2CjnMPZVUlsLSx2l2/OY2NPGcDaV+hObxsMPMF
 ZUJupifmjXKy4I4+22g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160110
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

On 3/16/26 3:28 PM, Dmitry Baryshkov wrote:
> On Mon, Mar 16, 2026 at 10:22:44AM +0100, Konrad Dybcio wrote:
>> On 3/14/26 5:14 AM, Alexander Koskovich wrote:
>>> Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
>>> GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
>>> to family >= ADRENO_6XX_GEN4.
>>>
>>> This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to report
>>> an incorrect GMEM_BASE which results in severe rendering corruption.
>>>
>>> Update check to also include ADRENO_6XX_GEN3 to fix A650.
>>>
>>> Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
>>
>> Hm, that commit also changed the value for A730 - Akhil/Rob, should
>> that be changed back?
> 
> I'd say, I'm also surprised about something being broken for A650. Which
> path / stack uses this value?

mesa

Konrad
