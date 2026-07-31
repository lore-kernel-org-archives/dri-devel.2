Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F51C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A1810F263;
	Fri, 31 Jul 2026 13:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5zOcnbN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7tbT6XC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDEB910F263
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:37:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VC9x5F4154457
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Jy4i2L4f+/YnSFmQn+Vd4jxC
 NtjOS9zp1+meyasx1VY=; b=p5zOcnbNNF3nC7qyM2KndRVBW976ornY3ITfux9N
 a/5/Hi+THGrukjb0GjXmZVTNhpoz2I96bvRoftZbLMTu6qP6jNrhwqVGO1zg7Vmq
 U84WLgzzpSPUwF/7f5IpZSi62GdjUMcdpJtDNwPw8+ziSEln6VPOqPmQxrCCcn1K
 AjbbQ43RhGavWnvrXDk6SwOHJrPZXDql123QtY4UYRwGd1TN/ufkr5muozZeME45
 q01Ha0pWbdEf91dOkQmSAIomcQY2cky3n7/MU4rkebin7Pt8Qi83TIJM4QkF4Wbt
 E/RZp79l+lU+WFBc4+mTxjf7QiKOYr/3Ir3m+J2Ey4Z3YQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frufkgc10-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:37:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso16443841cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785505074; x=1786109874;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jy4i2L4f+/YnSFmQn+Vd4jxCNtjOS9zp1+meyasx1VY=;
 b=D7tbT6XCEpnvoPsUWojz0Qb/zW2k6AomMvKmMaU+kDJp3JUE01yKYS4IoTkw69WviJ
 mcMAfonygLq6MY9eAERi4uW5KDgMsV/mCJgWf4lr2NcWwcPJZTiwAM66IzVWMwx9YtKX
 HrdpvcgYzOB3L+WA3hV4ri3TbDmUkYj4QdppSs7A1MokyPTNgSPuJfJ1aQ3C5UZLxayY
 J7BcstKQ9aSJG6NJl4FbgeGI2bWp4/Acrhhc5gbNx41UeWTqs6jpcheRcqi9e762DujC
 EfIYRuEy97BZIP2SVCJDOSJWoBX9yEsHx2t8RdqPoPqBEGPuXJWWAAgb60jNW3PC8XPD
 kcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785505074; x=1786109874;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jy4i2L4f+/YnSFmQn+Vd4jxCNtjOS9zp1+meyasx1VY=;
 b=OEJg14upJvJyDe0U9jf6YtKL5DlGhyFVNPNnyVWpRb6U0fc8Kq5Qtp7sRSiYdi2AWU
 N08W+sW5YLIoVBDjI5k9fqPnU1nMCbaHn95lzuqIjbV9hPtMLI2doNpJQMYAVhkNDE47
 hzeZPSvaMRHZ2R+hXC+xglDWbma2YjlBJWv0c3x+BaEP6UveL9U/DSauPNZtZkPobL2o
 p4D+FqHN+SoMowAtWbzAA3VOtt5yi/nu51kYGocKudycjfVYOZ69AopQr5z9zPZK8Axq
 EMhC9104LVzkVSa8STpKmCULh77TBsQwCsU4VmZWwbwFpkSajlcTd8YRlOZ2G1OBtDpT
 iZBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrkhk0Fs/lgVPk/XaHsN5DzVkvhp2OMolpiSQvAoKdh2nm/2g1UZsZrtRJb4/8li0iYMFGDgOr32Hc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzj8YXagkiUjqS+QxKZenTvhFyF8npSBR1rtQN4EfSBDgA/ufm+
 rj2YAFkhKdZxa9XiJedG7Qe2IcqYe7ZjCjclS0lytE6ldgxc5+ocjulTvVmZ+d8/aeqaKES6UIZ
 mge9tLhZKskQpNuZR8oaMXcNbpf5n46TxcoiVsZ/Vb9xsL9CA+aPYFR8BVCwGbQaGw6XAB3B0iJ
 ZzUUk=
X-Gm-Gg: AR+sD10bTbEKsn+sqcO5VJfFVjxiSKQbPYLsSTo95eYLutaKOvcTQW+tE346gO1eqAX
 aMgb5olycIQsSjeX1kHJaaQZVIGQ0daJgy9kZhQaAam0MvyLKoBGYVSzkVmclTd1TDJFDw8kbDA
 l1H4uDoYfEWXzFTQdR8uh+cIo+5aalCEGr/yOnKldw3jhgDFLVE3gtmKYfZh6qpJvjPpVLrT6qj
 wRdTPGBmyem7GjCExE/MR2Ugn35Adno0JiMZGd0hA6Ip/LovOpWqUhJW6Yyu4gxWzvbG7cGIhGY
 dwE2l+koI3TRwUDphTOPYDcNswaxX4MKr9fNMUs47J4RbEvtvMKkoddPS9WjsWWLuHcRRsKuA+Z
 5AUxKEPmasXP9Qw01lOG7M7zP8yn2Jxii3YL4dADWrj9hVGZu1mBDS4LXqDIRFuRDJMYHLHHcc/
 P/WBu2NcDnwX54UQ==
X-Received: by 2002:ac8:6907:0:b0:527:edca:8761 with SMTP id
 d75a77b69052e-52b566dc6c3mr2534611cf.19.1785505074359; 
 Fri, 31 Jul 2026 06:37:54 -0700 (PDT)
X-Received: by 2002:ac8:6907:0:b0:527:edca:8761 with SMTP id
 d75a77b69052e-52b566dc6c3mr2534191cf.19.1785505074000; 
 Fri, 31 Jul 2026 06:37:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f813017ebsm1203061fa.35.2026.07.31.06.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 06:37:51 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:37:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 5/6] drm/msm: fbdev: Use a DRM client buffer
Message-ID: <vuyo4upjjtyt33dztk5hl5votggs4mkm5qt4pwvmjt3ofdeufp@bncbhob3krax>
References: <20260618141249.151338-1-tzimmermann@suse.de>
 <20260618141249.151338-6-tzimmermann@suse.de>
 <20260618142656.7CBAC1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618142656.7CBAC1F000E9@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwMyBTYWx0ZWRfX3Xl+t0evhJnd
 JcMGXbr7LuqhUb24m+gYR0xgNhAKSA3Nkziapt3kylA3YV/8Hi99pETJWSU+aCrRXTh4N7QK6Qq
 FyMUODrGHuRUY5V6krNYyFy1J36tImE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwMyBTYWx0ZWRfX6wRNCw81V4Ln
 toIKeBLt6qqIGixpawdotJ1QEiUe4NC4vlDi2NwXjTk7PhzD4gYPvDhwhKAl6V7nkZkZVNwQzn9
 W9Xr8knrwjW40Nh3jtS75cjPPYwow7O8/dvq6lW5lPo8GIyMboR35Lmcz2erKwoGGmUeNSEnrGy
 PRhKuAoyHAjsISLQifdwdHiSBcL8MfDG6vHoK+pMeQuuzlse6+2M/5773EVGDESUtsbJBA/HR1C
 1kcsyMTT/G+xam5j3KcOVkaaHE/JPZ5O0l1ub5h0c0KrQkB9p0KdCUE5hdn5yIuY4LxClBBfEMM
 /kbZYKB6X3mpophWX10p31JBOl3ShkKqqQA/z+4jqLS8sGx/oqKtvTVo7G+cLYgkWpiuLjd5EyP
 nf/qd888c7iRwH4zMJJzX7G56K+WD10JpR6jJLTmDYMmIHEKqOptmBwzYx8S5aBMh/IFhsU1FI3
 tYHweF+QDd+B2bDOa1A==
X-Proofpoint-GUID: NwK9dGeKuBjFTOZG0B-LLTBIWjXUwomG
X-Authority-Analysis: v=2.4 cv=BpOtB4X5 c=1 sm=1 tr=0 ts=6a6ca533 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=5vUDMa2vHLDEXdyCDEQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: NwK9dGeKuBjFTOZG0B-LLTBIWjXUwomG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310103
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

On Thu, Jun 18, 2026 at 02:26:56PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unbalanced `vmap_count` decrement and kernel warning on probe error path.
> --
> 
> commit a68322c2e5e8736f3b039ddfe130065a05ddf719
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> drm/msm: fbdev: Use a DRM client buffer
> 
> This commit replaces the internal DRM framebuffer with a DRM client buffer
> in msm_fbdev. It unifies framebuffer allocation for DRM clients in user
> space and the internal fbdev emulation, and simplifies the clean-up side.


I'll fix this while applying
-- 
With best wishes
Dmitry
