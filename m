Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D0ACD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 16:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F8210E367;
	Sun, 24 May 2026 16:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="evqtIquE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P0HFvXFw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4187310E367
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:34:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O7ljax693456
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wrvxcU9Tac+9ZjUKvUObJ9ge
 mc2+OvvMLP3GIcBqox4=; b=evqtIquEr/Hg/mYsDx529pGt2wI7r0m24QPkWfhI
 F8gUg/8dSATAr9EOVpQFz77jNgS6Zh5BI+oHArZw/ClXpXYVEcSl6Ho7N0F9gpG2
 +ox849XVXs3NxRHwHDxr6MEsaNtmdqy08tV/1ytED6kNCghFy0cLWBZC/tQx9ipa
 NeLYTxNYE+0YbRDPrAWiHBRTady5YBwj4RbLZw30E8VfNQrAMOcwWzD9SgalayQ9
 wDlBxmvlk5++EIJ7XOOoEzOPVDft609uNiSvxWuc6uNk10lVul5ub+bT29A5higc
 /IAArS1wOl/KGHpEDdMHIhMSNyGj1HmHtB2om5Muohic2w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgup4f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:33:59 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-956732444ffso15945521241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779640434; x=1780245234;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wrvxcU9Tac+9ZjUKvUObJ9gemc2+OvvMLP3GIcBqox4=;
 b=P0HFvXFw3aoDdT2f7PAYi4WIm+46h8dl2omwlMXwVGV28+Dy+LZS6tbXeN9p1E2VbR
 eZWDZPxyoEHaR+kuxshWUgLvC+4lpXTLY2kaJ0YxAltCelEJVOQn1sYFzNXT+xyz/GDR
 pWPm68weFdSCJKfuHNrxwqU4uRn5U2EQ2BefSSUCIlNxZzNZAsPsZOp1Dpz/glzICu+B
 a5f75WHIsqqOlxhxT4noYoYDmsoUEtBixE2hPXLPUX6Ea+ev+KLEXOekjjyV8aiFeY1h
 Fulel+i+ylXz6Qb4YJVE626BIHs3nTf+NQVV9Cprs+GneczDXD5Vr2kLobEV8dW9njuo
 JhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779640434; x=1780245234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrvxcU9Tac+9ZjUKvUObJ9gemc2+OvvMLP3GIcBqox4=;
 b=tTnitc6rOHqxKKqI6Z2yylbV75EvpIk7doi3KBB4/OTIMtenq0Dv22YqObrDePQsxL
 otdBJwlWlDiyTdQJRoib95sSUQUN45DYTSv0z4YZuNK8INQnMkyuItbuXX2N2kg8fQaY
 m+E9EKgOSwpc6bHdiQX4QQ8Oib17VQ0E7PMqbLfRLRSgMfYfsp6XiVRorXZOh4kQYZCR
 CRrd7G7c5z+0ETcXlKB7mM47ab3SgGIvYhXoxu3K0dup5fnzN1ggygVvzbvr/iTTEFra
 zQL0EqIDt8Vfyaiq+Uuc+Y64YAu4rCjon3djrlP/OzAI8Zh18lVAnlM4d838HMT8jSKl
 z2xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N5st0cScPjXb2klwWG4pms/aI9awOJilXkn0kqH+U61q7ONIOr20lNmmUFczy0rpKREiPBu2g+FU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGfNZy2amebzaleIG0ZBeZNMgr2gfX6Sf8LxewgQfJmFqEnzaj
 /G3lkuHxuRCsTWr/VPbcDkSAZdAcoEHcBTyUFFo9cKahkCDlxQYjqbw74ceH24pN/YV3ztkseMl
 y1nVlNvrcXxu6dn2A8bduIkVNFXhfr4vMy+UjYuaq9ZDrkz5gdLZ12taNuU86cf+w/pJ+cs4=
X-Gm-Gg: Acq92OF1WBS20CkmoEhGt0SIlKuz5Xs1DOwITilPghJATF/RXJSvspxfxAGRzpDAbOa
 qzFg275tD28claSL9YASTMiR5IiW96sCMy8Y/FaNU8gpU9OYtQ70BI9KJy3uD1parwFAWoUAlJm
 EhGFIkW6qAfDKao9wKdxE0677EYYqeOMk24CndSbrdeYnOT6Hhi1MSO4rSC8bfM8JlqnlB4IVau
 ZKzqO7uI3suinPdFRj4sLYIinfJ1C5lEBRJtoG8oF885WnvP/Z5bQaD+CU2e9KLeNxTKNUvVN0i
 b+Bm3OJ9A5IqeV/VKSad5zodqLCcbubAcW7zyPBlbEntHI+2CpssYZgeNC7eNAkjT4oMt1rQHU9
 Jy+nVbgKLYT4t4YHl1hwEVbRBnCWp4BmS9X+XjLQiX5Gp7uiDsCmvOTxi44a6MmItw7PKm5swOW
 LY+wQi06xCYeSiQXFCQdcp+JwTKDSOUL+0NNc=
X-Received: by 2002:a05:6102:3e22:b0:631:ab8b:c348 with SMTP id
 ada2fe7eead31-67c803c8b93mr5581656137.8.1779640434550; 
 Sun, 24 May 2026 09:33:54 -0700 (PDT)
X-Received: by 2002:a05:6102:3e22:b0:631:ab8b:c348 with SMTP id
 ada2fe7eead31-67c803c8b93mr5581642137.8.1779640434160; 
 Sun, 24 May 2026 09:33:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32ceb258sm2040482e87.48.2026.05.24.09.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 09:33:52 -0700 (PDT)
Date: Sun, 24 May 2026 19:33:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Graham O'Connor <graham.oconnor@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] firmware: qcom: scm: Allow EFI variable access on
 Radxa Dragon Q6A
Message-ID: <65pjothj3tjvfmpjemktdinmeouxnuodkhjx3s53it2spmldwz@l2jhbuxeutyk>
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-3-graham.oconnor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522060645.4399-3-graham.oconnor@gmail.com>
X-Proofpoint-GUID: BjW8o9zLYQqrjE393pEN_CjP6QrlnE9W
X-Proofpoint-ORIG-GUID: BjW8o9zLYQqrjE393pEN_CjP6QrlnE9W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE2NyBTYWx0ZWRfXx/NEjzQLSZoq
 TRO3TvG/co/VWfWcUhYJYnOl4ntVTE3J/sEc23y1Cl7C2Re9UT0kOnJxY30Qf7XNIJnE2DZrO1+
 iKwx02Fh3h2LFrnI1F6L6SLzxk1p5KeD8OPZZc4g4LRASZo8idDjm5za1CoSBFbLqLFjuibhLjq
 /PxtHhiOcs0djuGOvish1MfbBb/jS2Y5+6wD4T7UZObdTaQ+n3Tygc6J3Mu5L0esocoj9KEMt9Z
 OSzH3eIl2aYMKZ35jNN3h/RGAmpmsy1bROtorpa/Z5/UquYa/Y7V7dgjd0Sirg4f7IJosFjg1BG
 uQR+eZ4heFm/Ve8XtPVoVV2Vpts1wbGXe0m0lDFRTYBx5zSyHT75QBKgOQXm0EflWOtiwiK+e0o
 nbLDq7IWR3XOuCexuSFb1y5E0tlK7FWP5PqVsUtVfVq1wWJGfL4cOASAg7wFZF2zH5tr3rerBx5
 1J8HY5Mywm2JCxL3nOA==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a132877 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=tsHZmUjQ-Mj4z8azS1oA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240167
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

On Fri, May 22, 2026 at 06:06:41PM +1200, Graham O'Connor wrote:
> Add the Radxa Dragon Q6A compatible string to the SCM allowlist to
> enable EFI variable access on this platform. Without this entry,
> the SCM driver refuses to service EFI variable requests, preventing
> the system from reading and writing UEFI variables.

Which medium is used by Q6A to store UEFI vars?

> 
> Tested on Radxa Dragon Q6A (QCS6490)
> 
> Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 6b601a4b8..4702ad898 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -2320,6 +2320,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
>  	{ .compatible = "qcom,x1e80100-crd" },
>  	{ .compatible = "qcom,x1e80100-qcp" },
>  	{ .compatible = "qcom,x1p42100-crd" },
> +	{ .compatible = "radxa,dragon-q6a" },
>  	{ }
>  };
>  
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
