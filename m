Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BADCCD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 13:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6487A10F52D;
	Fri, 15 May 2026 13:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SP5Bk6Z8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LlTGLRIo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539CF10F52D
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:38:59 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBUBQV3219668
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CAkKFuSRE55Cl5r7tDqtTtvB
 Pf0yPjzoWF8jVKJRgeQ=; b=SP5Bk6Z8bALAkEQiEZFToYWkRxNmpw1nLeYGS5fD
 cZSdYYeoxW2C9g7vOQuN5apw30OjAQL/KjNHr6wipA3bG+6v8XqDokDF2AF15rXb
 VXlekJgVdZovcpm9iyKSEJEYikMwRR7kG3jeG++29O/oEnCCDdc3IQ/ctUmTB+9Q
 is9FpnjbXas8iU9vZ/y5mfCVCKWWpv5b1v4jk8+gO4LaXOJClZesBqWOfIKCEqPP
 uS0g/z0zHUiOmbzDPnlhgwyZ49OHO2VfXmoBJI2NjBRLPCTS8ZkhgfZnTJy6AvjD
 NBlILZWIKj9OI9w78O3/wIWu2oz2h8iz6v4f6QO/I/P0pQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s3e98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:38:58 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6326fc1256aso9503628137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778852338; x=1779457138;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CAkKFuSRE55Cl5r7tDqtTtvBPf0yPjzoWF8jVKJRgeQ=;
 b=LlTGLRIoia0tUZckuwu6Gi79DQ6pZCqLdKJ6sA/Ve/sX5JiLHQ4UwePDnjyW6I2l+e
 i/JNgrgLEXjc/7WLvCiPMwm2ituPGKbZp1dpBOim6Qwo83V0dkZYqUDSMdmuf42r4fln
 rmDgXPNGF8PZ9Rw0BUuJ50C4h24oPpkqSajAGW+1jHVYJbLxHUeacAarLOcMTsyT3Q4u
 pAfmHxbbobDYlzbVxXswy8loeNu3NcG7TnQgSZ5x8lyjDjYWRQK5MXwnEkH30T6ZyEVc
 FFF81tHbVju7OxBk1Nhw6NTSDfb6f9ksKFxdKqVxNCFApOtCu4Bu5i89PlfSDae7niNG
 3zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852338; x=1779457138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAkKFuSRE55Cl5r7tDqtTtvBPf0yPjzoWF8jVKJRgeQ=;
 b=tOjnVUmuEhCOmsgEbwH+U87lxDu0bSY4cAKTO5YTEnWnAaNl3PdFEfMFSfakDj5rrN
 sPAfySFI2+kEVRwook5Awfs93q0uMKejTPhNXFGEm2yW7JA4qAyAq80eqXU8CXBb8g7e
 5giAxEJdQ32ASJNXT5pcwpfv2HKVT/YaA6RMV90CAMNk2gwe+t6GyEJ4tPKedy1TMsWG
 3IJprtzgFPWD6F0gC+yEfbYpl0M2fbjfX6omITcnPbtWetclZ3UL6Mk1BwE74fSnMlxx
 houbsgyopdCa0DEjv6msOOvm5VvZ4ruPBmdr+j4vkrlVC6iZYd/ihs0YsA4Rki0uQUIw
 n6Zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SoQoxUp5/r0BuB3XY8AVIYwgoqRwqwEEH7hahwAAwsZtCJ5s/HS0Q6LcxcMj74iKs6EJESOmpmeA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9LmHG2tP55W2pvix1sXHHJfaeI2Qpxa7hSHa0dy4GPRlV7lIv
 BTKtgdRM1ywKwR/Y0+MpWtrPsdeiyuS6SXKjuyb62n51X3THI51d70uHnbYpHis5Pv1f2r64Ngc
 CN6e+ShOJfNrxM/KKwDYTFZoCcUZue8wHQXBGg82DsIL2xbM4YqvduU2+Xkz237DFWFOesW0=
X-Gm-Gg: Acq92OGQX8dFdQHNV0B8XPLUHhvgBMWsDyoteuEQLZ7aYYEiP/upjvSuEH96VJX06N4
 nfSO0irwjzAnZM4oDhAp5hAVhHAkUeNn2s4jR+n9TU/VARvaI/4uqmP5lt7ruJwxXsOWqlFcviP
 UDETa0QZfYwF+2cy1CguNYEPAFixwJIDqtx3sp/jqpOGJUSxxbWW4kKZ3yXy++82PO/xi+tKaGs
 Hbq3Vsw7hmvVgAUiDCj4JeUuniTrxzwMVljhIvFb7kCdLtSXmuaHVOjAW3bcSn+xdsVQSaiK769
 fi98UzeLS/goOY60j5AL4/rJcq0OgSZKy2jaikSsVRTbeTp8Wl2RkOJ/24jvewQ67NGRp32fZ7p
 9s5Q8y3qS182KxeqU2PpeSMkNoySsr6D3cwWCiXuxmotlvbY0ACNkkkC59OIERpglhvmfiDf2Uj
 SoVuF8sVSqAlVcHRbGKQ++HyL7vbsVD9X4oj4=
X-Received: by 2002:a05:6102:8029:b0:610:db51:6f3d with SMTP id
 ada2fe7eead31-63a3d42f341mr2353963137.12.1778852337674; 
 Fri, 15 May 2026 06:38:57 -0700 (PDT)
X-Received: by 2002:a05:6102:8029:b0:610:db51:6f3d with SMTP id
 ada2fe7eead31-63a3d42f341mr2353924137.12.1778852337273; 
 Fri, 15 May 2026 06:38:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f11a630sm1337598e87.22.2026.05.15.06.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:38:56 -0700 (PDT)
Date: Fri, 15 May 2026 16:38:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com
Subject: Re: [PATCH v5 4/5] misc: fastrpc: Allocate entire reserved memory
 for Audio PD in probe
Message-ID: <v3qkvvqlggrk7thn57ff4tlbilz26nt3nlma6deixlalq74i2k@nbxbqyppzwte>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-5-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515124217.20723-5-jianping.li@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzNyBTYWx0ZWRfX67rEd9yIFrQj
 tEgRc5nDRhlGGBSPtvBCGVAmGBQtFRsikhNBUPdkjudWhJGEpkH4laiBZ5fGY0jYG/THIA74ZAo
 ODQQqniSfauRs3mwwEAgipvD43vOyfpWbtvJ2FmQhxJxgNt6QOeo7R3ZmgS4fh/DMi7gKdUa/6z
 WPSgmzntMNFT7+jD53UGAxxlaWXF0bgou4skyrWJq+K2Hd/QgUF4jHe1egc/Bk6WAcHafPuXITK
 0eRa3Z+k/K11YJb0NJgZafUdXaV9mr6iZon9KAK2Jg/ZOppvu8WJZ/k2eC/8TXiVRJpq2Dmcq2b
 pLTclVcEwMbNAsXG1ztaA+O0vKuqn79nhn0+abqyamhkZJpFe8wVAOI6aDOmltQQKHS29BBzHP6
 FHVeBu4YHz4cXGT++lWV3q956PC0KciqqJwf80y1b1qqP2vOdBZYqcik1o34/djTgQJpuTqFHhV
 OxTO0nM12atknqek90w==
X-Proofpoint-GUID: aRYg9zdzXqurIvg6jlXtfg6ruqzUGmrC
X-Proofpoint-ORIG-GUID: aRYg9zdzXqurIvg6jlXtfg6ruqzUGmrC
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a0721f2 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=qAkFtAADdWEuSrs4xykA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150137
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

On Fri, May 15, 2026 at 08:42:16PM +0800, Jianping Li wrote:
> Allocating and freeing Audio PD memory from userspace is unsafe because
> the kernel cannot reliably determine when the DSP has finished using the
> memory. Userspace may free buffers while they are still in use by the DSP,
> and remote free requests cannot be safely trusted.
> 
> Allocate the entire Audio PD reserved-memory region upfront during rpmsg
> probe and tie its lifetime to the rpmsg channel. This avoids userspace-
> controlled alloc/free and ensures memory is reclaimed only when the DSP
> shuts down.

So, is this a bugfix or not? Is it possible to make the kernel misbehave
without this patch being applied?

> 
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 107 +++++++++++++++++++----------------------
>  1 file changed, 49 insertions(+), 58 deletions(-)
> 

-- 
With best wishes
Dmitry
