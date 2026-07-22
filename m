Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15C7C44532
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A98F10E427;
	Wed, 22 Jul 2026 11:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYntDN3J";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IA3Yp89A";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2245B10E427
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:07:37 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x3ux524023
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QBd0JTPVR+0Tps0UvyFMFdA4
 n4QCSTyrgKj4/Bolkmw=; b=fYntDN3JARlIuVWURs+a/+iGZjuqxlF4p1b95d3R
 LMvXGhbOfJYcF+YaVjI1VpWI2mbKsttflkex+VbYlKXvtoBSqW7E7mgVkzBOtINo
 kFwj+QEZ1Akug31K6E/3gbNa7nieyYBZmlBV+fZzgMXU2mSCgoy5UkiJH2K1bcVd
 +/2KZuR6ocOYnYA6m595rOhMjUgvH6PNMc3X/0qquerU366G0T65txqauOYH0b/b
 tKvx0HAQ+mjOa6cJG3SFKbI/9PDxwNYpyuRX81r9PZmrJJ4A9VN82suyRL0So0XR
 hcFPZx20Ao40hZQ77dTptDLExUYBrR7W62lcVDstPAU5mw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt12ej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:07:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so339643391cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 04:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784718455; x=1785323255;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QBd0JTPVR+0Tps0UvyFMFdA4n4QCSTyrgKj4/Bolkmw=;
 b=IA3Yp89AX14jW50chBWOHxaaVf+r3pc4VzMOz8GyuUsrzSZCvhq+AtkYxtxjq6s0R3
 4ldIsE0G/3RlGRjmTGwqf9D9zcwNIFw6biQ5LcMluolaYzx9SUw32w9hshTuL88653O0
 yNm28gZY+BbMjq1KkpCjQL5wfs/rVhTlhiz3G8Cn7jW7fc6jSOLagH/yn5vKNMBOCcnv
 wT7SymugOB4jkifDlWrYHIrYo/0bqVG2iU/Qa9iwPqj51Razr9/PP19tH4SG5b/3yiwE
 nfzjKNVk155t9RseNaURqwcEjXcUbHhlc4ua+hcUBPttD2wxq1vXq74aPnIPB0Y4s8kO
 LHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784718455; x=1785323255;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QBd0JTPVR+0Tps0UvyFMFdA4n4QCSTyrgKj4/Bolkmw=;
 b=aK4D8hrQr+iVuRtNPTdr5Y5Z6EdVTDIxrdpdbJpdKM0uKisA7f/GyGgScuofbIsYC1
 oxPmr8bSx50ZTyzbiTecNrkdcJ6d7csJDV25fdne8TLgKofhJ5+gTvuJv6cvBkJw32i1
 I8UhDCSjKpbePSYv89Jjyhb7kpP/GZdEGBMuRsHs1VrJlq0Bd3miSYZHY0yNM4BvEeoj
 pruRUNrhPfJkbd84VgoJEnRbiLmBj07G/a25cXNtNKXvPxFPvBcUNfr4WZ6t0FwzbKbi
 8TuDMvSxgeePMX4vNRw8kxbPyiZRI/qIPdM9wpldApQaUkngSEcDS3AU+S8mfDRMNW2n
 lH6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI1/L7NVai5Qu7FgFPUlcG8ypdWIGtngrM/KlH2X9UZWagwR9Hky10s7+IP9MVPHssQTFxp2TFBQA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBxf7Cff/kaZ6uorvDzaQ6x5KnXnbrcjP2osFD+b/Jdphy37tU
 lodFCDSB42Ur86I3di07q7WBkqtnU2yfruY+DPz2ALVgaGF90RMSvAm9ZYw5DbjUEaom7LiQ6wF
 Pes3sdl1aaPm1D0A+Xkop7brv6Wc8uZHKI4VcG6kJVyCSsB/2223qsqkhdrzZynPhAHw7BA0=
X-Gm-Gg: AR+sD11VSLnl1aIG068mv2Y+Pm1hqlom4gtfXoENAb9qA2AHKmnyRGJEEqr2d+vDaje
 jINmgJcksENTPOp9jISuosWraXw4Kx54oVeX2qKMJ7iuNUciQaoAg/EIEylWgGM390O0yEdN851
 7zGW9ZW2jOBv+QnhdCRO65ZPYd74UnKMSh4XByDWAf/6+VERWmhd2CiaWVZmxjkCWlmzDXa1mfC
 q+KdW/EKiIZeTVUZlqZ2opUfFo/pCZGcfkU5u+U3Ox4/M+SbaHvm2nR3Hiek1KWiOTybernQBWL
 OT0X+9vviadNE2UJe6uBQz+fn044NQjQGxVfjTZCKfbQ9chp22E8J258ZwIexjO3FKGz8DrYeRW
 Ff5hqgZhWvYiS2+sXN701FqVwmSLxk0tjCzeYf5W6w82f+gdJ6te6FO3WmTy3gnSA3PIxUQaDkB
 iHZ0E4CCAEnlflIA==
X-Received: by 2002:a05:622a:1344:b0:51c:1132:c7f7 with SMTP id
 d75a77b69052e-5213ced0617mr219980471cf.29.1784718455427; 
 Wed, 22 Jul 2026 04:07:35 -0700 (PDT)
X-Received: by 2002:a05:622a:1344:b0:51c:1132:c7f7 with SMTP id
 d75a77b69052e-5213ced0617mr219980161cf.29.1784718454887; 
 Wed, 22 Jul 2026 04:07:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8cd3fsm422120e87.1.2026.07.22.04.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:07:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:07:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM
Message-ID: <xla2pmliksqzv3hww6rln2aool4js776uzmgkt5dsvggcuanbq@6k4vdkmmjlju>
References: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
 <20260721-topic-smem_dramc-v4-2-748f992278a3@oss.qualcomm.com>
 <20260721124005.E00041F00A3A@smtp.kernel.org>
 <6rmntcmouwenb3t5xk5rh2rijd3sc3re5m4aeuqive3wifn6ux@hauua7ltycvj>
 <b8f316f7-0036-4d10-987f-c43d60dae854@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f316f7-0036-4d10-987f-c43d60dae854@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: z9vA3gEWFen5DzdxBOwKgiHsBMQBJwe_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwOCBTYWx0ZWRfXxK8J3NVV9iN7
 f6cAmrfclSwaH6PICfc2p2icvl+gZKBqNdzEtUMgpbDnCOZgP+M3Nx0zdBBvWt30di6pSa7svXA
 89pexDuDA8frsdnKKmLAqOiVo3MmFD+iylQCv85Tr8JEUJtpw/pM5Hx9xb2sHGnVTkPOyhXE/xb
 2syDKMC2Lqh8jwaRezrEk+cM338XWch0tFS+ELswwElqNxqQWyqCD6rMW4NV19gMNIuDx1HZZXV
 Frmtf/sddkP1Y89r3xPNGTsgbMpn8thy3IK+PiUKpHqPffKIPx6GDENf6R24w6OHDH/POSB+X/+
 lhf3lmAGP2WE3lT9L5KwGLQGRxgAhXllV8fOjA0oXrpH3AV+ECfTt3ZQwsy451zu3fawUQ+qx1w
 dvJyW9MCD7dgpsY0BlK84g8E3RfqkWHshxOD7uywUfVpDhPze/Aa9LCTX9ycKtOY0gOSbusG91m
 mW/8Si4doCZ4kmepcFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwOCBTYWx0ZWRfX4A7eHokcdWSI
 ijRDg2JIprJRcBODnHADYBIeOHMDdvRbe/lfuLDQ50xtzcm73jyIvqFgXHYewzKvL7izz0p5ILT
 /SRr6vXVDUwZR6OgBhafLvWv0FfVAxI=
X-Proofpoint-GUID: z9vA3gEWFen5DzdxBOwKgiHsBMQBJwe_
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60a478 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=odn8cRm89JfC27xefy8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220108
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

On Wed, Jul 22, 2026 at 11:26:59AM +0200, Konrad Dybcio wrote:
> On 7/21/26 3:40 PM, Dmitry Baryshkov wrote:
> > On Tue, Jul 21, 2026 at 12:40:05PM +0000, sashiko-bot@kernel.org wrote:
> >> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> >> - [High] A race condition between SMEM probing and `qcom_ubwc_config_get_data()` can cause the driver to bypass probe deferral, incorrectly fall back to default UBWC data, and return mismatched configurations to concurrent callers.
> >> - [Low] Missing Kconfig dependency on QCOM_SMEM causes linker errors when QCOM_UBWC_CONFIG is selected but QCOM_SMEM is disabled or built as a module.
> >> --
> >>
> >>> @@ -178,9 +195,30 @@ const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> >>>  		return ERR_PTR(-EINVAL);
> >>>  	}
> >>>  
> >>> -	return data;
> >>> +	hbb = qcom_smem_dram_get_hbb();
> >>
> >> [Severity: High]
> >> Can a race condition occur between SMEM probing and this function, causing
> >> it to bypass probe deferral and use incorrect default data?
> >>
> >> In drivers/soc/qcom/smem.c:qcom_smem_probe(), the global __smem pointer is
> >> published before the DRAM data is populated:
> >>
> >> drivers/soc/qcom/smem.c:qcom_smem_probe() {
> >>     ...
> >>     __smem = smem;
> >>     ...
> >>     smem->debugfs_dir = smem_dram_parse(smem->dev);
> >>     ...
> >> }
> >>
> >> If a driver calls qcom_ubwc_config_get_data() concurrently during this
> >> window, qcom_smem_is_available() would return true, but
> >> qcom_smem_dram_get_hbb() would return -ENODATA because __dram is not
> >> populated yet.
> > 
> > I think this must be addressed, the DRAM data should be parsed before
> > setting __semem pointer.
> 
> The DRAM parser uses qcom_smem_get(), which relies upon that global being
> set. I suppose one way to fix it would be to initialize __dram to
> PTR_ERR(-EPROBE_DEFER) and returning that if we need to, but then we
> go further down the hole of needing to assure all these getters are only
> called from defer-safe functions

I think DRAM parser should not use outer API to get smem.
With this issue being present we can later face hard to debug occasional
issues.

> 
> Konrad

-- 
With best wishes
Dmitry
