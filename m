Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680F1CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BC410E10C;
	Thu,  1 Oct 2026 01:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S50noS3a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXNsVgM2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5ED10E02A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:57:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910k5ls495774
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 01:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uoVV9AMom/z0Z5MeMxOVZrJn
 fnZMhEF3YGoQPtJPVgc=; b=S50noS3aCk+5o+zo395zaz85DH4dKB/5pNEcwflo
 sOOZu7Jf9Zf4L6f2HIIt2NIOJgaC39THUFZ5YJQLhQ4ZIA/9usI4JfGvnfqc0Asx
 0xG7xi6Lyw8j7eoN2QXXDGurmww8SjMNhIrwf1pzzU6/MY9DDL0mYa/WUwzLZHFG
 g4UtuhHxGQaXLZgYMOuLaVke4M013uQinV4XXShCcGSj49b9X216TkJlJfrLcDEf
 RYCTetkmOpdbhFL5iw41bl7O5SOFH9aLRSRNyUAwQctTN9BoBgAK6UMluDs70FK+
 CdnQXuFv/CLkLPfdszF6bWnckNNhN3iGN6k+73VZ+TnnsQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17pj9hsh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 01:57:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso77819185a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790819843; x=1791424643;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uoVV9AMom/z0Z5MeMxOVZrJnfnZMhEF3YGoQPtJPVgc=;
 b=MXNsVgM2wf7SGV9wJHQ385WRp+dXP3n//10weD+nTAB/clPKNl6iaLAIAOk85wtNdL
 evqkrFfdAU+0G2pmBAP6RXVujplO9Fkh1XzjRnwhgkZ+dntOS76kIcopHhv6nu/cOr3U
 LxvleAXRINkdd8JBJRiJOyLFYC7g+OQmcjQGyQyCafsJ6Peol7T9IrPdJJxEtiPJ+t2m
 GsXsZk2Xmc9ham5T8ylwwm/UUBGXR+rjdn5L6GfdisprG9JZvYNmq7zryY7LeLIYZMZo
 d7atIYGVvEzYwY+KOmimjKdje4J4LdXV7bWr9rZB3DOQniq1DcMo2o2JVOYzXw/1gsPi
 fFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790819843; x=1791424643;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uoVV9AMom/z0Z5MeMxOVZrJnfnZMhEF3YGoQPtJPVgc=;
 b=A4CZSeHivNl0yr6M27MDotALcMhZuIcfatYsh/03XxDIzaZ8aguM0hAyxbmEFXbJP4
 GrQ0cBdpEobaA6UcT8esGb231i/OHZWvOFk4GKOBkWdZQU5TCBlXA4Z1oSWIiR4bpnG7
 Ffa9JcPBrbJ8SObrIvlKW9ZK25Y+G2hMbylBvQ9fAzhIH/jMwR5oMIb5De3co8jJgPPS
 a7aneF470wZDGGl8x6mw+wNPXAo0VEd9ZeaOZBUjgTYcmaTYgVuIOnN68NtJj/2PaNWE
 PzwowZq7TSPquMLmt+Ljq4N2SyIhVs5ltAzfCC1QTdVoFIK8Vp88M0UdzAutNQQzhkGj
 A0Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8N2xDijjUXPN0Lay04M3FFbS2nWxWI9jIFA3FC+PicI1UcMXVXIJYFkZTaw5M1vpQGl0azIKNa4U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++niXZZKMTFPY5szxt45r5ab5ijbg2NiLUEN2+0TJtJxVV00INMM
 sjniMcab4NAKAjpFWhplcRQea5uf3JaonUvdE+9/Wh0BIlnU4UpOYPnfFFRbtBQb3WNGA95axZt
 e8qm4vRYBgTjoR009YHPpjSsjz2LCVmwaEnIQKOYp61JO1NWqX/Nrw9TOtUkuA6HEy5seibI=
X-Gm-Gg: AYBFou2bW39AftiJE/5ke0VPdIRQWUeAGpe1BOpXc/bVk2e8W5Ho62rXvFVLEmgvVsI
 q/6zamDMqWz9VuGCzJxZKVASin5Nk29f64Be4vyBX8LSh8xgk94i3uPhfflJGR++2QlZV3+MPJo
 0UYNrLFupW78V2EwWnAzLF4xH7zVA6KynKIwgjiN3sGaY4SbCRNGx/BgMtccif/VXKahylEMMZJ
 JGypvoOVIgkoW9e118pVqETR9e0imrSE8C62vkYin5CMsBZAdqD3B6SpDZs14AVydRrxpsFtdkz
 fnY81uLBS6E6pib3YxsghM7xT2oR1gqUQqCGxbsT2/YZQ/H6N6y7sIIsFXgNODOCYZgo0iTrZf9
 o8s9DZLj6jnlIh7Utac3QuT+KYJk8GevHNqC1dI18fDgcXXzC3AuCvb3iQbMRzHlO45FcX6BALX
 lIaGlmOzHDdyet
X-Received: by 2002:a05:620a:269a:b0:93b:d7a4:9d49 with SMTP id
 af79cd13be357-93cb5a1468amr287215085a.28.1790819843571; 
 Wed, 30 Sep 2026 18:57:23 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:93b:d7a4:9d49 with SMTP id
 af79cd13be357-93cb5a1468amr287207785a.28.1790819842965; 
 Wed, 30 Sep 2026 18:57:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a77192ee13sm12526111fa.30.2026.09.30.18.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:57:21 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:57:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v3 13/19] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
Message-ID: <diibislcaubtwwazmkjsv4y732har2eskayle5mxpdkr5npana@uckh2yzblzxp>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-13-b96fd3fe298b@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-13-b96fd3fe298b@mainlining.org>
X-Authority-Analysis: v=2.4 cv=eqpKXYpX c=1 sm=1 tr=0 ts=6abdbe04 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=OuZLqq7tAAAA:8
 a=EUspDBNiAAAA:8 a=YvXxkWmvim7rQlE-Do8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: nBCyA7cy30-EZXvF5Q17_vQ4MiCUXWhz
X-Proofpoint-ORIG-GUID: nBCyA7cy30-EZXvF5Q17_vQ4MiCUXWhz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX0FIqlGVvXsgW
 b/Nj1isJGCvPtU1Eb6+maAOMC31hK9z+dkz0OULEWW724lZey4m119QmNerJAWyBsrsgHCZPw7h
 Z4bxEgdhOzMcdErRQ48MLcVdvN7NHY4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX6Mzz7R51U3fj
 +1cuPQ9/Pa4rFZB0Goaei5AeIMvaVH1iKrj603K6iFC2sNNYXgj1VPUdoi1ep+X1+3+vqiX6MEl
 ohAhQdlNUzJF9MibdoiPx51sAExYsf5Megows8DNLlKUVlN1W699++YFLklG43TR8ywzlqHKr9R
 dudf0DUQF6jTjZwGhL7lDdJmOnkEvpJ48dgOaYARodKtUaI5rtb4105rT3CDePXqMvHXzIHMToB
 d2GfhVTPLBfDIeM8aTgs+VCQ6FAYZ6q7iNxpXlgbsurMHquBDxR3h/fjuwSAcNnAV26jTvz7URd
 NM78vkD+wt+mjHwDeyAI0aW1vHSAyjbSTORB4wMBBIfDwitak9xpi/X4sdIlE3CBco9AEGiJ2r2
 ePJL8G1ckDqFlzlrLumcQXlg/Xd2S8f1JLjrNhgJJhAsgUzvcc4FdSih3zNLLvqnz75B6mJJi/D
 keLTsms1qZs4ZDYomEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010007
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

On Mon, Sep 21, 2026 at 09:19:04PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add the mdp5_cfg_hw entry for MDP5 version v1.12 found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 81 ++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> +	.pipe_cursor = {
> +		.count = 1,
> +		.base = { 0x440DC },
> +		.caps = MDP_PIPE_CAP_HFLIP	|
> +			MDP_PIPE_CAP_VFLIP	|
> +			MDP_PIPE_CAP_SW_PIX_EXT	|
> +			MDP_PIPE_CAP_CURSOR	|
> +			0,
> +	},

PIPE_CURSOR is invalid and should be dropped. I'll do it while applying.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
