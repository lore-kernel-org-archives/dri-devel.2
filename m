Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9877ECD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25F210E440;
	Mon, 25 May 2026 08:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UQryuBx/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HJiFwOv8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D363110E440
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:32:48 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P6rtNX1842262
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=a/GH9zMRwmohvMEFGCjJTJbo
 0KhAcstMUoj3XhiySAc=; b=UQryuBx/WHL7xDGPaMEq6obPSvhfHbRmxiEHk/vr
 w99jsVv3T0dptbC54TQCVkTP8GSfeyAqgJW6vRD7C/aqKyeOs1832wNfWQjzzUwm
 bngEh4UjBY60EwEnzkdvZUwCkahIn1N7wvtTOlvjR6tGXfeVjC8ncqWTBm+sFcYB
 5y9x/f7ehSr4lNisnzZCc+wpaufKE3TKNhtoyKthTtt5dWLaL6G0rvFftAb9mtmy
 DCMc4WpACnPWZ1qmSIe8GfjBOLTXzlff6VxyV1JfnjG3aYx/cLRQRhaoz2f5qmEQ
 e6WmIFq4ufF0Ok8FokmSHGWiM0wHfirSpOieB+430AoYcQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0w153-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:32:48 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-632ad092bc5so14978672137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779697967; x=1780302767;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a/GH9zMRwmohvMEFGCjJTJbo0KhAcstMUoj3XhiySAc=;
 b=HJiFwOv87edhyLuk7CR90v2WnGh+tTtlnpRSp/Q1mmW8Y79hXGGTJczAoJcNgrWnFI
 vI0UgBZHL9NBZ88LmpEFcurcwtZJWvtjK7OgzOTud3teR4iu950rIF1wu/b17sq0ziGL
 AtHXXT0ztfTwMl2xpj9kARp0j6Gvu0yPFXt3EjVPJs8rkGzVTWgBj2lc4gJOtXoRpCaY
 BBHbWe3pZmzLNTMbFuHduSKFGei2U+YiJuJOodz0hChp+eiWURyT4H5os70K0LBuA84s
 T/Tv0EzbAXEte0d9MYI4Qt0pTKnPyOfVThRtg2YAuUZt6nbgXZVJNiQRAkmZdEcNyIRx
 Yr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779697967; x=1780302767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/GH9zMRwmohvMEFGCjJTJbo0KhAcstMUoj3XhiySAc=;
 b=jyLaCb7D+N2p2s7RyseAxuVHpfnGO8j+JNLvdPvoBGwsZ1KkA1JObCqocSIRbPXqav
 mrwsf2HO8ZVj33Yo8GAXAKhK4vLSitU1LuAbmtC3LVp65nXTCHunY2HcnK3oDhYMUVcT
 bKWXxmvZjluWc0v5N6gaL7KnfHa7xlorZbP2/iT0pDDaR6+A3Bi5HTz5dPtR8Wp4CXqT
 zmu6nfhRSpC1sY3WSlXGCII/XvVzmouglEjEI832htD+WyX3OiNixfCmqKwdAFUFtqeq
 qoNtKk6ZUJynjlH4wdpdswNtzjd4pKzjzZ5pji0acplZBN5u4cqba7vS299hEBx18NGH
 g8Kg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/83sTGTS9xoGkVJ/nmytBVcl4TL3et8dsgHRT5tlvVfU4Yuec7GMOuiwh/qJCUL/i6t9Ltx/iUOTM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRAjTAEU3v/gelOGd+uvM8R5sjUL+POYBakvqdQUpC3GDVqLat
 IyntDctRywFNfkvbSEiBs1J9mSAzFE2gD2rdr/vKcIQXPdnwzQcZA95BTjSW0tP6Lmv/6CkOJiB
 1+IR8zYHMdvcgbfzSGqXBlzIFC+BLI+yhRsiW7swxUgNAHYCcg6XgLd2HBS9UyNlQDuW/98k=
X-Gm-Gg: Acq92OFon6UFLsIXu0EpeeFC1goBkkMDgmVgo4JUjRfKeqcgoJsXFcmRkYUDEd2xCze
 /eCao8LWDUltsG3Pc+t81cX3/w6D1lNzVoF9lj/kT7PZT9nEhANBudVOMHUyQZWPezrrfDGyVN5
 dNrm0KB8CNPSb2zN0MRX8CBn0FqRcQu8zpsnT3E0ABU+dzJ2BcNfFCH26b7PouRjr1lsXwO9syG
 YoeEJfYBEi02rXipTHkYoYaa5tlKtz8w0M1o9sLPA42Q/6JesR8fgR3sdJ9tYRR9J6pqVx6fC5M
 b/iM7mVIPQImvErYEbUdNtl/vpD9doA7IrqnDXYw2C8y+ezqCTCe09z6YWT05q+jyGILLmdWPGq
 9ZR0fTwC5a3HKTP7HR/QZ5KaEUaUGi4ZlPW6GT+BNr47zltOBJV69y+15vqzOvl+hplkVYckJyf
 F3C61L8Km3jahh/6T5SPIJ0oeUukrXyDosNXk=
X-Received: by 2002:a05:6102:b0c:b0:631:9366:da8a with SMTP id
 ada2fe7eead31-67c7d973c28mr6988602137.16.1779697967273; 
 Mon, 25 May 2026 01:32:47 -0700 (PDT)
X-Received: by 2002:a05:6102:b0c:b0:631:9366:da8a with SMTP id
 ada2fe7eead31-67c7d973c28mr6988590137.16.1779697966887; 
 Mon, 25 May 2026 01:32:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf92c0sm2479515e87.74.2026.05.25.01.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:32:45 -0700 (PDT)
Date: Mon, 25 May 2026 11:32:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com
Subject: Re: [PATCH v5 4/5] misc: fastrpc: Allocate entire reserved memory
 for Audio PD in probe
Message-ID: <lpsvrgw7spxt34rdvfakxm3trdjybv5lyq2pitnso5k2bfkrmy@7a62dvbmf4r5>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-5-jianping.li@oss.qualcomm.com>
 <v3qkvvqlggrk7thn57ff4tlbilz26nt3nlma6deixlalq74i2k@nbxbqyppzwte>
 <fb00c836-95bc-451b-9430-2ebdf0be2630@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb00c836-95bc-451b-9430-2ebdf0be2630@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: oJcyqKD_eVuSVpx3fEj055XfYjZsIxNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NiBTYWx0ZWRfX2W11y2V2eHWJ
 cFSzOIOl0TxtD6yfyHnEauHd1F7Iq9quF539LvrG1VJJ+YAeI78bLhrYJc+RwkUfr+vY9fOdtpx
 y4FcJKLI0RV9wxbSZdBJT11xtskX5qmTf5Di8zRT7msD0E7nKtyhpJnkoeXHMqnbI+ljAdvNGSF
 KpRdJ+vaf8OsQfbUwVdbI6puul7E4Hyjp+hHGscMHSbO9Gqwu0T5awId4oYxdPg/1XQ4PbMnfYC
 +Iq271GcQK1BgXzMivCCMW/e9XtDp2L8GZNkKr+b7x5Ea6pS+hglol2g9dZxyxYfwGabOhsU3Wr
 u8msAbGm00jT0t+wukOBYrvWRu00qoZHghOozwdSFewQBypa2QWrjg9azP2pPJoB0lt++bx8esJ
 h6KHni1ja9Y/JOOpsGTPnw4iT+Eg9Y9bNVF6zWiorkr8dgo4ebxCtjfGXgdSCbPU3XAtRL6Wqoy
 xw1rcQ8erPtww6pfAyA==
X-Proofpoint-GUID: oJcyqKD_eVuSVpx3fEj055XfYjZsIxNe
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a140930 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=gttq3t2AYlGpivilpbwA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250086
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

On Fri, May 22, 2026 at 03:47:31PM +0800, Jianping Li wrote:
> 
> On 5/15/2026 9:38 PM, Dmitry Baryshkov wrote:
> > On Fri, May 15, 2026 at 08:42:16PM +0800, Jianping Li wrote:
> > > Allocating and freeing Audio PD memory from userspace is unsafe because
> > > the kernel cannot reliably determine when the DSP has finished using the
> > > memory. Userspace may free buffers while they are still in use by the DSP,
> > > and remote free requests cannot be safely trusted.
> > > 
> > > Allocate the entire Audio PD reserved-memory region upfront during rpmsg
> > > probe and tie its lifetime to the rpmsg channel. This avoids userspace-
> > > controlled alloc/free and ensures memory is reclaimed only when the DSP
> > > shuts down.
> > So, is this a bugfix or not? Is it possible to make the kernel misbehave
> > without this patch being applied?
> 
> Yes, this is a bug fix.

The tag, cc:stable, clear description as the bugfix? How would anybody
guess if the patch is to be backported to earlier kernels or not?

> Because currently after the audio PD requests to grow the heap,
> the current kernel does not support shrinking the heap, which will all cause memory leaks.
> 
> The current modification is to allocate in advance and release uniformly, which will avoid this error.
> 
> Thanks,
> Jianping.
> 
> > 
> > > Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> > > ---
> > >   drivers/misc/fastrpc.c | 107 +++++++++++++++++++----------------------
> > >   1 file changed, 49 insertions(+), 58 deletions(-)
> > > 

-- 
With best wishes
Dmitry
