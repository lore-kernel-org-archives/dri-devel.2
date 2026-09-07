Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06B0C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0496E10E472;
	Mon,  7 Sep 2026 07:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eQKYpXh6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YsKBTGZM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB62710E472
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:30:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68777D3u2838543
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 07:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gLaUNshqrh7dT0Uzc85c+IqgRr+LZ636BwE3MsVsMks=; b=eQKYpXh6XYU9bkVA
 RAOzNKZz8Ln0WFhl/+MjM4HUzkcWpTKp7lvj3KSEB7UUOlp1s7udTNRxwqaK8PK+
 2wzSfMpQm4eXAZW0O/8q/UqR1vSLhCT0BVXZ4QKofQJApUp2O+V3g2Vx7eVfmlzE
 CIAcyj175gn9FvT+zGG83Hp5Dx3Hn2FOgaaxu2kithJrTxF1qVqZCbzNwZ+XSxVE
 12q2LMm2kJsF5T2KAcSj9wYoW+BBgmHzVBnfL+yEK4Pyc9Ow0hF9Wcw/igrIW0Ob
 YLPiPqPj3u88aoQSB0msvdqfWnT6Kirod1wr8CmPIVpFfzKI8BWyIxZ2ON6QWkvz
 FQeYIw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuenq9q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 07:30:55 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91045c83dbaso8181936d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788766254; x=1789371054;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gLaUNshqrh7dT0Uzc85c+IqgRr+LZ636BwE3MsVsMks=;
 b=YsKBTGZMhGhOhcBXLkKaO+Pnv7OFab5I6E6uh8OBk2UnbseIgKWvr8HSxLgd1hM7e0
 +qQltLNQkL5DEujSATdMHcMidBLMUepW8y6z9gx/2cmMfLMtvJEq8KIEoDAjw5uK5/Vj
 7cOSjS0HL9D2lyQdrqOk6NMAZXBSqfso0CTxPA308K29qutCCrZaqIo/oOuq5mHNA7Ue
 Nt9/6pLCKetgW2SWJSxEHV4Ya+evNfaCqRzpLDvFGuYfKSV8wD0dXTR1TBDKUUoCdShf
 bD2GfNeGAY4uYWlSH14JvSEAFeU8qgGSBi7gdlX+wiQKaMVdEklhyp+bc83jYd15X0RY
 cxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766254; x=1789371054;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gLaUNshqrh7dT0Uzc85c+IqgRr+LZ636BwE3MsVsMks=;
 b=f+QPGXr84646xnCs9hkdS5mCeZyLPO0Vpk3WW2d7HIw1U+5tZwRpmps33AfG/EhGdI
 b+a0C9BcZsSBWd8s2gWQa466Yw8/cZmsxUFwYYHJ3satWT7Yfv21d3FzqCaRZoPidbnT
 ulXFe+JZIjFJBONXEYGCwpGoFrHm7jlIz2CnWeEY+nYKK91dRWCoxZoAc6shAT/KLlh1
 SZ92h2kDFLyxsKzfcwpdZYon9wlXZjBcH47CLxxDtyQXpPqV3Awf/QgiJpYROMWDRsNs
 i2Bv2ovCaw1rvJD0WzU2lCUoTkz6V5VIbngDqztoQxFsl6ysI9NjmFK6lmsLEhrsQc2N
 pHIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByl2Tpca7ipAbSCQC+SOZpp0TIL3i09j3XMfwuBYOwwdgUqtfve+l/pGXFw9mS/uU/qJdZagUgj/VQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkjZ4BDCr2UN8iqO1WCLGDYDF4zBlOi8fx1Kk89JT04gcyFW7E
 8ByZOdzfzVS5nsAmhkv9uttlAxrmEWXEOY96eExYGeSc0zzl8WUfrTnlA2qwIWxqFu8wb3XV5Ff
 NWl99WWMiuPA4MggUckSDwZ9CasFC1UmKt1TBvbLrb9dBNGYxMChTZqZWNbnicwrk5S9VXzQ=
X-Gm-Gg: AYBFou002oC21AuoLKOWmcvQqe/c2Kv+LomCh+vgFRjg399exZ9ZUONzBN+ZrVJ3WMf
 ejFxODfHQp0cwuO38PhmBcofcmS4CKx+8tQFLUk1fd6RH8pjAopPYrvrxZjTAYw5fTPSMTdb+tO
 GrD9ieMHSmB0w1ETsMNgySFtt8Kd4n/dhCVg/LeSbg7tmHT5IsHeyxSm8CwcL/ZAjyiSh8bmv2h
 O/zEWK8c4Ty9PHaQctc2QmTUmBthP0MVBwF96h3YiYGxmDVMYQoMnsWpplMBVCWk6szOpd4F5PC
 eqn/o6U4mBItUQrdNuHS932offSiqddoMZVb1aVp3U7YffEuruUFsLlSjhbCh4Cu3UZ9L/GgeGj
 gcs09iQVmK3U7BTTDIDmmeA==
X-Received: by 2002:a05:620a:448b:b0:939:8148:1e3d with SMTP id
 af79cd13be357-939916fe312mr1067521285a.2.1788766254399; 
 Mon, 07 Sep 2026 00:30:54 -0700 (PDT)
X-Received: by 2002:a05:620a:448b:b0:939:8148:1e3d with SMTP id
 af79cd13be357-939916fe312mr1067518485a.2.1788766253945; 
 Mon, 07 Sep 2026 00:30:53 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d503f96sm420254766b.26.2026.09.07.00.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 00:30:53 -0700 (PDT)
Message-ID: <66064071-c83b-4e6b-930f-9ade224e036f@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix the separate_gpu_kms parameter description
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260906170347.2427-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260906170347.2427-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3OSBTYWx0ZWRfX52G7OZVF9onW
 Q6Ddsprx7NbofmzWg16MhaC7qaYrnbtszRKoVh6m8zEgiIdp+7tnkNowU2kA2Uofu3gj83G0DsI
 +SWIm04Nrr/0K/Hg5nNnzMjY70C76CHLY80QqWSw0bjMRVkIV/nnU12Hj29lWzvH7J/d4k+oxus
 nwFckmLK4vYG6XRBeokz/z2XZ8aRSdu9yHOSmpasb7S6krDCDVWcT9aZthbk79ze02Jdrk6thnP
 B9tEQqcqtJovPE7QBy94Wt8eAtmM6i/gfNZTIWbLW4uwqohsQkCTazlSMucq6G0Z9gg/i/T5ipy
 1qQPCHi9yj77EA+bsQCNkremt/Hx1NqjtGKmwNT71TIzAKJp3odXyyGooRFJwSTbh7iHss/ruHr
 8cbqukBGXvnAvMpKx3EFaEdpK2A++JmXwv/BbZWbTF5IkotzW8qzyFIC6fIAS8dQRc0KVgmgPrX
 pen5eXctOYZEhcymOaA==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9e682f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ebZoJKtv0rFVGLU1xKgA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: jnu2UtBjPL1Q43johXUYhEdJsdaLVnzj
X-Proofpoint-ORIG-GUID: jnu2UtBjPL1Q43johXUYhEdJsdaLVnzj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3OSBTYWx0ZWRfX0E0J9xZ5oCgE
 BOvRRrxxwVIsEWgWWT0uIBR8LXZkKmdYxZ0WpQ02iZ3MbLBYdenFGHLadr61+nPei4w/hOByJOd
 p74DRVWn4N2yetI13wblow9GgssyHJk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070079
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

On 9/6/26 7:03 PM, Karl Mehltretter wrote:
> The module parameter is separate_gpu_kms, but its MODULE_PARM_DESC()
> names separate_gpu_drm, so modinfo describes a parameter that does not
> exist and shows no description for the real one.
> 
> Use the parameter name in the description.
> 
> Fixes: 217ed15bd399 ("drm/msm: enable separate binding of GPU and display devices")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
