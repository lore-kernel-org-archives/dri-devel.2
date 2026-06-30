Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1676BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6598710EC68;
	Tue, 30 Jun 2026 12:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1Rrhq5y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bpMjn8CE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458C110E20A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:14:39 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9n4kp1508580
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=; b=Y1Rrhq5yt8TfNDWs
 EgLGPzpahCcr/ZfG0Sl64RZ5vc1iAyxEEkLH1gVw6YQ3d+itWHbU9H9bJAzAcXKR
 2/A+vh1LtOvqK7yf5qXmxGPN5wP6RNqQTW6KCTswuEgDz0nX8TYHu5pfcZpPeHup
 CbHdMu7jpW3GsAnLW8YjKvbzZDJ1rn867EzrtM4f7+vPrirw/3bfTvvPIzPMLQz8
 xSE6O3iF/rkQQq8UazZS2apXhMw9Q8sqNUmdOBUiGf3kKrUUD9ga2qbaEJb86ud1
 c/nDhl2v+J03zcyY/JVJF3+Hl7IPjvXeS0+icmcN1p/XJTSwqj/BuM4vw0fbh1fd
 W+wZiw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j3egk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:14:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e68cbeb53so8957885a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782821678; x=1783426478;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=;
 b=bpMjn8CET7YMOygfD7OUX6FaSl7UWqXdafIQJ/atwJkin2i3x37vzV7JkLYnnGG9Eu
 D2gaD0fZGWMS6xRw/xIXa/LZgxLARCi0snYcwR9jzWP+KpJB3Rge/DQbdgQnMYv75aaF
 qBy2WRnHcurESw0NXBalQLEcjldXvlmEqdQT8F5DKUHAr3oevS7fIT9ey66wqwhmZJcG
 t5Ls5XbA9URMnDbT9Bu6KB1+FUc74Mk8Bfga/sMSyK54yWjffRfImptIa1uF1M5CmOMW
 qwGW9qZrb3T6e5pp6a04RvyGjaqJU500JzC0ysCK4vPZsroK3e+bGzX/S/E1dhgUC9PC
 pX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782821678; x=1783426478;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oBbce1WRUs3G2E0RY0k9esyoB3WwxEZLpDwnuzZhw+E=;
 b=lpt/rql4dB4SPJ4Yq1CcX1dsEolFuk5lFJp4UyMLBumCXeha4vQnoizDgqmxM7vgk/
 BIrLSOkdqOkt7o+tThAKVg6+WNlS3v7bLa1Q3vyf/ZksTVaW28Yb5mHcP2MZm6hY3M5w
 gu7OsLRiPiW9o2jstZCRekr2J/DKctkD9GQ5HyaysEwZYz2PbTpsXG5LERCt5PXkaNU3
 uuTFYgka9X5EwJVInh8ihPDK0OQZdBhskGzPGEZj1lUAQw8jTpYvL309AgJvNMP8gZht
 tMAtKynXAHxEOHvZdNA5cT/4ERohPbrOmdixw7HVbTptSVxTRv+RIyEEq0olL0Povv6e
 pAgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Z0b/l2Z2PrwKSrV8QhuHIELUgg1lmiHTqxiL7aOP376Z1qf8qWLq96GUkf2tI4SKiypesLS1a8ic=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYjfxF+9/dpDSD51qNBsqER0v9xydVJGGhyA2lnTHX7VzRQME6
 53uWu0sM/NbySTdgTf860L+v9BgmZK4DnFfG5aO5APaq4XH7jhnLmKAhnQBPkHL5mtmi+Hjr/iw
 KvDKFLeclf2/VFDDld6U31fUd1VCk8ofqcqZQhywR0Lr6lqFdkcZpJ4KHC8Lp8a+hT71wrPc=
X-Gm-Gg: AfdE7cmCopRd9+V5+GAS5ZG7wFm4+GJO++IE1bcUlq2qDpV7J79Nug0Wph8rJfeQ8xI
 DDgsEmUwvTJPFhFzXkbLRaNdQIa51paa2qrCON2N3qKtPkinwENycd4ri17wvdM4LIbzYPmyK0a
 2mvYFZ/tCQkqzHQEtFoYU5YPEpp/a0qQiOJlXTd8Tg/J5II9TRqbZTBCOl6UKPsDQ5XVULreKxC
 7K09j6St9QXakgN0YP9pwJ/HtJ5H85jaPr5Wgg/KfXX05H4xiK84BN6Uxr37h1ioGw5WTGdHJks
 YmZpP4iir/Unm0aDpfHULmBJG/+NVw0+i/zwm1E5RtCe0odr2GhkFNtprN5WYbjJuzbrvYJ/xo4
 ocOGs4gyV153g/jGAa0oU1nr1BRT1ixWHNCU=
X-Received: by 2002:a05:620a:2589:b0:915:7c1a:1388 with SMTP id
 af79cd13be357-92e627e197cmr355400085a.5.1782821677732; 
 Tue, 30 Jun 2026 05:14:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2589:b0:915:7c1a:1388 with SMTP id
 af79cd13be357-92e627e197cmr355395085a.5.1782821677127; 
 Tue, 30 Jun 2026 05:14:37 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1296b1f9cesm21325366b.16.2026.06.30.05.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:14:36 -0700 (PDT)
Message-ID: <dc7e58d3-4383-4d93-a38e-699888bff903@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bpsJ5TOURMtmTMSoSNLYCdmmOrhPr2b1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExMyBTYWx0ZWRfX9d4O1afI4MMm
 mspmZ8jtY8GlPO73Rociz8tkk6QYTI+3EsSWxoUGw87SdM0W+UT523eboETTDptOpnXVbsmCCXR
 Boa8BlJ1roF4370bn82Ui9VT8jFLGDEOgpb0d06dP8GhT2hw6xjI7pSaq5+fyfojj9YL1Rc/Vct
 UpbMdA1XHh1L01e0IDpOnEq+VQASjvvHcz5BnPCE+a69bZphaK6OBmOS5RlpIGU2ONWptA4HiGX
 PNhg1T2aPUleWCWaqUmEgmb6JxAdKNgB7McEXqpnIziZzL0YZfZ0WafAFh1VhVM5XmvZL3Ayc3K
 UwgZq8MOmKOaeuU77CXwca5DsQQQXdSHNiKR3kCqvCDGw1FuqCH1fQTeW/LEv1vv8PBU/lDdRWE
 vJyEBJ+ZMi3mlQFncKw2xTfO6Wj8qIO4W/7oMjodsMTVoMv2i8l4FS5Mh2gmzXzzb5PgnLzFKk+
 fyzmJvjZwGJD97l+zpw==
X-Proofpoint-GUID: bpsJ5TOURMtmTMSoSNLYCdmmOrhPr2b1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExMyBTYWx0ZWRfX2+178IWojzao
 wJlQhP90Xc0f5HF+SVKLBrfQlMj38jQzBgs+fMZ9uYCB9UTdeHpqUvB5WLzxVL1El8mmpGK1mma
 /EU7ASwBI+D967lhW6Kzim9iDxTn4cQ=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a43b32e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Ltt3hjjT39zhUWiMmRAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300113
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

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.

[...]

> +bool qcom_pas_is_available(void)

This is the most important function, for which I would expect
kerneldoc be present. I think it also wouldn't hurt to add a
footnote in every other function's kerneldoc saying that this must
be called first

Konrad
