Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C015EC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2255D10E9B9;
	Sun, 13 Sep 2026 20:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXVlswPN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C/nS7E93";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B54610E9B9
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:50:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DJxQWS2685710
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=skUogQ4fUjIsvv3csVnuR/5F
 uFXLBFbMZ5tGqMKNf54=; b=LXVlswPNG3jLMqeT4ZptclfnJ8PL0tXfdhjetTVj
 QSLYuneRDJtQvETUR+aVxDedzYL8f8Iv6mArLNaIhYFNHzdkKw2XubBYT27PCIr7
 qf86bfpoKd+VRnLwoUSvfm1lOUFu9+rRah1RKgNwTlAfEh5qDEZZrpyt4CUAl+Ys
 5LGvKhu+5p91gZcUgeVihewMiYzLXWaEYKykcIZIrs2S1JfV0MWrz4PuszE2ghFb
 Y3R6ZeAYIyhboQBzZ/Kg1xa9Hneb5gFbDeuHPC1y2pj2NqoMoJFk0nQqnVNpRtEV
 pVa6367SPcxiuCyoJ5kmq3qle/L8ndNo3M3RUuZRdqUR4w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d43q3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:50:39 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-78f2fe53829so2343092137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789332638; x=1789937438;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=skUogQ4fUjIsvv3csVnuR/5FuFXLBFbMZ5tGqMKNf54=;
 b=C/nS7E93tJmGm/GyoSZroUH3n5LYqSZ+G25FAXAKc88X7lB0etFVM6SEEQsLmSQXyP
 QdALJIbu4CMRM0HXamnKQemJdfoRiTC58f9OVYi0VA74+RVhfcVPgPJPYuu5CcdXRsX/
 Hon9rK4FsoC6bN6ytMRn9QL5H9MyZZNgAcDFGYu+q/shEi4wm7rvOsQcVEf9d0WRe/u7
 pXMKYmUELEig1VDTOvfI5rjVbHE/p13AQZhBa9D6qqnEqhA6IezDVQRGfWliy5fxYRt0
 B5IWBJ6kWDtRj/IbB1Yek7ojQgcnjwc854dxDPm4PTe04zXK914E1e9IE/ryJhN/AyXs
 uCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789332638; x=1789937438;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=skUogQ4fUjIsvv3csVnuR/5FuFXLBFbMZ5tGqMKNf54=;
 b=LBMQwCBa8PGJeF0Y0vknk7Qih5HotNBbhWLckrE8tXGo2Vf1LASWHUCPxTN6PsYMpF
 4H2CxS9GPkyDu+oWXnizam2CmFyepBDfIiCkjqQF3Omq+LsEzfvkPj7eHWyY2ytosjZS
 KvV9Hc0RP3iB8C9yVV35OjD7SJrr65R806QTpoErziliq27Gce1SX1X/nCWhYETpR5rt
 uI1ar9IGVsbpl6Lm/DYH1xNvVyN0KlbCNa1Ehb1X3sWtr9apVqO9xB7cLsP2A+bLqCpa
 K77I1dL0Oz9udAe00Fq84gqc8ZGxSmb25eKuSBpIXkvM0X23eFK9dUzZZBfgPa+cNdiX
 MicQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJkn03jwaHc/de7/t0OGQh2McBud4DkSF3AlFUIx6dxcE5wuCDKrS8zAum6Nqk4hLZGdMaeo7v/q0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n4Tckud3FljSZd8GiCrEsRQuPLci1qV/ut0YNXS6m6GwLwbIQy
 lprn2BfW4+4933mMX5FTcn2PrjSjzknLaA67VaH9QKfVjyGaot1tXB7bmlHCvyaTQEKeIIRqLNf
 WM/o5RQF41eJ/Ozhgfb3NN2kQEnWsYPQsVVnPWrV20NwmCYSvk0Rf9gaPUwFfE+G0p8MLwJg=
X-Gm-Gg: AYBFou1uAS7O6ZC5gXaEBPHfJDVudvC3CD0H7Kau9WPoKBsKmQRBfALXG5s16hncDWO
 s9LeEZR6pw7qfBheBujphN0O59jRmZQN4la7K/X+eTVBsmlAj0jusy+XV84IR/lLRQjEH+2TURZ
 8kseLG5ItizyNRKZ1zi23VmZGGWjQQBr0iasiZkGK0Av9w3Dr8pm6qOqyMYp6lwzI4+lmd5sJk5
 pJK76HBnCtS+NLTZp4TAsbT2Wc2iL3tPk9EhEFbzq123kDIf2zvj+ZpGszCGdE7b6ScENJ2OHTE
 g+r6uMV8UrF/r9DJzxnGEB26dSNidHAiGBQe6FHjt48+lGfxybJMuJuiEDu4/7ALsSzdTC49MFU
 CydLt05wOkEtC5t4SmwYVtZtH6MWwYpNwX8WGZxN6snd6j/uZI8Wc3P/xQTVUkyvR7n0N7xBKIo
 bngvigSRa2JJO9
X-Received: by 2002:a05:6102:512c:b0:79a:90ac:d18b with SMTP id
 ada2fe7eead31-79a9f5dc028mr481912137.11.1789332638490; 
 Sun, 13 Sep 2026 13:50:38 -0700 (PDT)
X-Received: by 2002:a05:6102:512c:b0:79a:90ac:d18b with SMTP id
 ada2fe7eead31-79a9f5dc028mr481902137.11.1789332638076; 
 Sun, 13 Sep 2026 13:50:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a336c175sm22802731fa.36.2026.09.13.13.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:50:36 -0700 (PDT)
Date: Sun, 13 Sep 2026 23:50:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev, freedreno@lists.freedesktop.org
Cc: Mahadevan P <mahadevan.p@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/atomic-helper: tear down HPD/polling in
 drm_atomic_helper_shutdown()
Message-ID: <5n357w6ytzwbksbh2lnv47gbkioo3epbr55ddrw4ipn6vikexp@kbwvjmjuzntw>
References: <20260730-dpshutdown-v2-1-441fc5543bed@oss.qualcomm.com>
 <20260730130104.3B4661F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730130104.3B4661F00A3A@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI5NyBTYWx0ZWRfXx3s8omJ8puXS
 tI7YuQELwlj7ZKNqe74VgZ23R0tfwAmdRdJUD5BwoQMEIIkpigxCFtNtTa6SJlKKyotCvaSSnFX
 wcw8QzxoM5PK15oHyc01ZeGU3iwFVrc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI5NyBTYWx0ZWRfX8akbuAeudsUL
 nY1tK+qXGAR2rKIhnXM/fFgW6sYa30tw3y/XAL8692JRdcnFeTTt9pFl8A8nNpDqDqOKQqeaGN2
 7TBfMxqzWnJh8B4tR6PHzrt/004V6NdTPozup0FAgGdmKbqMob3/t5WG7Mu28KnvmPxQblYMFhN
 Tz0uDUXZB0ubzZGWmQDm5RHZfmbeINQXl747D3la1EYp/VcrLDtqqxoCnBpgM7oXvhPefZGoL9C
 zNqZy0bKK0F4AL+LQKsBwp+szRjifMGY7NhCs0ancNMelUVgPL5Z4O0KkpoUJ5jZv6coeiUOJgf
 AcnPhUP5U6RY7jQ5OekuIyzpLm98xaCmYWjky13KCZ5XCSMC6BGwu6gewJz03nJd6WtmGspTbAr
 KnOzdBLPIEbqkIuRGmYF/UyDZ/JvQ/vU4oDXLN23gHyCMtMg4amaLpplHUQTVZ7dRUGyhzbwO/f
 /AjJ7EoYBIzvuS88oYQ==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa70c9f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=N4DhEor3m7J97lUnjsMA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: bAEqjWkiDmRdrrF4X7I2aaTP419rFzp-
X-Proofpoint-GUID: bAEqjWkiDmRdrrF4X7I2aaTP419rFzp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130297
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

On Thu, Jul 30, 2026 at 01:01:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] drm_kms_helper_poll_fini() fails to synchronize with in-flight driver HPD threads and introduces a TOCTOU race with userspace probing, leaving the original late-modeset bug unfixed.
> - [Medium] Calling drm_kms_helper_poll_fini() inside drm_atomic_helper_shutdown() introduces a regression causing a kernel warning stack trace (drm_WARN_ON) during driver unload.
> --

No response from Mahadevan.

-- 
With best wishes
Dmitry
