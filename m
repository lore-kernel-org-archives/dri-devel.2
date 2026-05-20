Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21070CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 19:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F84E10E15E;
	Wed, 20 May 2026 19:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MyKqtiok";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YL5HqWV5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C376810E15E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 19:38:21 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDXbLf1797936
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 19:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5LFMGD840PvGCPwkDPrhg8qGWW+uSOyb0Wppoq8dMT0=; b=MyKqtiok2N+ELTCL
 /G41MzOXI5sSKnKAYPPi9+YEzNMQC6FtVm2VIwSGycBLu4m7SjicOj1IuDOIrbyD
 QRbjYWeqOJtbIZGoaKlrKSqEIYQ+v2tN0Cg9rTRzHKz8ndTRxmQ6Rk0rI0uYIcdi
 H9zTeayd3WGe2hzxdv3fnxadwWvWCKjC1q7kJEX2sZwVQJCnIjA/gh5thdHWl2YM
 rLATqRcQtaRJlc9pUD+Pm3K+erSBRM2zoEjJBNJJW7tdOETVMMPrMIOO3mO/NFTy
 GYZm8rduLfpyO2P4yjWRjr9CWXHjJwdRMGg6mOJgCpgjxiTxJPs4i+YN+2bTH+CQ
 kY4DXA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu1ghn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 19:38:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so2760638a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779305900; x=1779910700;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5LFMGD840PvGCPwkDPrhg8qGWW+uSOyb0Wppoq8dMT0=;
 b=YL5HqWV5ZGIHOfN1dx9TIHe1Q2wDrmDVeOtn1gsP0wGZckUeKZT3aQGNWzzVhjIFjE
 2oXGlYPvyH/px503BqGmr52oZAX0esKd/1W2nN/PIQyryPpDBQ4REXSIsr3nQZ4zKUYZ
 /iS9JSLRPwCcumry+ujG2SzS1NbToMWYmztUcxisjMaqh5ahI8/d2x5TikV+rx4mX/l9
 yDSMyPz1/qsXmdoP0r049FUS1jacEkQaU1H1hE6jgFT5lX1+NPWFoWwPRWkCitK1Bz0S
 0SnrOMgL25BDfAOpb/Bk2ppJa26kNw6WQf/c7ZrLw/oQ+olZUS2QnLPbFWE1IYDgqG8z
 9PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305900; x=1779910700;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5LFMGD840PvGCPwkDPrhg8qGWW+uSOyb0Wppoq8dMT0=;
 b=h6GIHkPh7OSM7Nn8WvZR5omJNDkh06YW1yNIOJ11tmCzt/KP78ScfFSUU0fgJjAyDY
 CYQtncrS+SUdNxyHNc3Pko7w+mZiB3RIeztI5Xkh3lDnglLezJRAr1bSPs+xCiA+S9Be
 jmUP55Nfn6m2JApr/xTZ9i8SG99htzD55G1CQ5lQBRR97TLNYG9cRlKi0ly6/Y2rgCBg
 wNYbnmMWnrrl/Y6tL6BNIxP8EjYI5nnTyrilv0PS8+Zltd2a1SirPR8Flt+A8ZHTuLP+
 eZSKEAHY+srTWVu5zc5t7qBAwIWMG3AikP+MIMO6cL3yr+fP7eW86lm/OOQ1cnOggUSp
 V/jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aUZveS0AwsIXRVEO+OAwN4LV6ZI7v03f9+a4kzT0M52jTcgDesA0Osnf1vSbLB3JDFPFltfw7/KE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0Kx9NAZet1K5AkprqYqgNEyY8Ixab9Mt2NQd9dzbegFmKLC8A
 ZiZG9tk7/Rc2MyNBeCbG9xnyjg20d25Q8W/MT0x2DClZuyOvkpBwhEJZJEFaxTINB+BcA/4Ek0t
 vv6/0TlWFOoYrAm8nGn3Ps4GbyVUo5U7ezqjQoEPxgr1yc/4EcaNozoNC4+K7K5mAqhBsyN8=
X-Gm-Gg: Acq92OHe3aajKj/Twvinbm7vGVQIbxReFBS3RNoTPwZOb5KGOSHrOHd4IJZbWN7C+4q
 OkimwsFeJEe++txaGf+YBpiHZTd6f543yyLAGk0/xPxcypbUTTskcvylwa9aLLydfvBiEYFZDEH
 AIfg+QbxagIg54tLR3i+ihpbS8YREGyJT9iLc5r4cWm8GACeDoQzUlCALGgbzZ2umU+xK4LaqDq
 0HspEFmrWm/jwpz5lMwmFxKa7Xrwr//DtVn1utmfoGHCmn9ZjW57o5TZYtbDRTQnHfLktwejaW9
 kDPvd7tI7NM8/i2rqgV/wVQhzegw3Z2eoaICJowDUXDzqDM3W9gvb4Bji4PG8Pbt/lcbRfQywuH
 YOKB661n0pgtWxNFp8uSzALJIfz7yp2ezHq2ehYFkcWI7aZ9EGYu4R5IfKaC4ZIsd2UMF2lgTif
 6n360WJH51
X-Received: by 2002:a05:6a00:a10:b0:835:36f5:17c9 with SMTP id
 d2e1a72fcca58-8414864d999mr613731b3a.2.1779305900543; 
 Wed, 20 May 2026 12:38:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:a10:b0:835:36f5:17c9 with SMTP id
 d2e1a72fcca58-8414864d999mr613692b3a.2.1779305900001; 
 Wed, 20 May 2026 12:38:20 -0700 (PDT)
Received: from ?IPV6:2401:4900:9074:ce4a:59fb:b330:7e10:e1ac?
 ([2401:4900:9074:ce4a:59fb:b330:7e10:e1ac])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19f7ccc7sm26114065b3a.58.2026.05.20.12.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 12:38:19 -0700 (PDT)
Message-ID: <01b424f6-6617-442a-a77f-9b7a8472c447@oss.qualcomm.com>
Date: Thu, 21 May 2026 01:08:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 0/7] Add support for Adreno 810 GPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
 <3dc009dc-8f36-4735-b849-d952fb626cf4@oss.qualcomm.com>
 <3vzdlxnee4w6mur5qiyk2rhewlugswxarhevv7l4zo47qnnqah@45oxl7rjqawv>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3vzdlxnee4w6mur5qiyk2rhewlugswxarhevv7l4zo47qnnqah@45oxl7rjqawv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE5MiBTYWx0ZWRfX7yYQ6/ReXnKw
 gb1peBjpLn+wuFNXTqrryBe71cdEmoy3nk2O+HinDr124qP8hO9N1BYQ5pGTgvzzoeZr5NjtTQU
 2dNMu3doQ6RGre7/YMP1VhSmxa17zZ6STlCjxmcVG2c4HZv4DvRjAE4nvUMZSusXkdm373qNjBp
 GZUHkV+BcIUN5RldckY91IcrgMawsHzWCJAKVXXgYXresI4W9m61q0t3HrN++P7yfXZ+2X6MS4W
 HwJb8lMeRsDVVtsdIsNdKiaJ1QMRhxkAFWIn3sNCztI070sQJ5kAgF6n27nU5wG5jkTESfJTGDC
 /Di4+i/oQ0+XXzgtym6LC9DA1iapR+LbqeqYJZl2GfJF0YptXWH6Os9k8jySeORN+giEW+EQTmu
 1tNyfEKsEj2qS8Q/bHbJI0vXhSSc2Rqf1409XTXSk2vyk2VmWWLjPTR/UutTs8ZwHOqjjoohVPW
 Md33XtdgEow8mwW26vw==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0e0dad cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=vrFTKMbr3VGxMADgOxUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: Fm06-_eMDr3QEABmymiADpMfnFQ3sRjU
X-Proofpoint-ORIG-GUID: Fm06-_eMDr3QEABmymiADpMfnFQ3sRjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200192
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

On 5/17/2026 11:54 PM, Dmitry Baryshkov wrote:
> On Sat, May 16, 2026 at 03:52:08AM +0530, Akhil P Oommen wrote:
>> On 5/15/2026 10:38 AM, Alexander Koskovich wrote:
>>> Adreno 810 is present in the Milos SoC and is the first GPU to be released in
>>> the A8x family.
>>>
>>> This series is marked as RFC because it depends on a few other in review
>>> series, GPU GX GDSC handling [1], QFPROM efuse for Milos [2], and devicetree
>>> support for Glymur [3] (for a8xx RSCC offset fix and X2-185 bindings change).
>>>
>>> Also depends on the GXCLKCTL block for Milos [4], but this is no longer in
>>> review and has been applied.
>>>
>>> [1]: https://lore.kernel.org/linux-arm-msm/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com
>>> [2]: https://lore.kernel.org/linux-arm-msm/20260331-milos-qfprom-v1-0-36017cc642db@pm.me
>>> [3]: https://lore.kernel.org/linux-arm-msm/20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com
>>> [4]: https://lore.kernel.org/linux-arm-msm/20260417-milos-gxclkctl-v3-0-08f5988c43a2@fairphone.com
>>>
>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>
>> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>
>> For the rest of the patches that doesn't have my R-b tag in this series.
> 
> Unfortunately patchwork doesn't capture tags from the responses to the
> cover letter. I'd kindly ask to spam the list with individual r-b's.
> 
> 

There will be another rev to remove the RFC tag which will hopefully
have my R-b tag. ;)

-Akhil
