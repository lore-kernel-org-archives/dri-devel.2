Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB26FEA819
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFAA10E78A;
	Wed, 25 Mar 2026 07:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0m3F5br";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TthjUNir";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B9B10E78A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:06:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P5TvDv1862315
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rQsKwSTJPFyNadQFvKFExVIv
 rmCLGMcz0vINVo0Po1s=; b=L0m3F5brvM58NyDoxlUV5OVWo1Jmej53m0CksRk2
 d7xYJYzAzCTsf6dALVssxvAmBjHQ58BM0efr51a4SfNSYzgt934DCxQN6bfSehkS
 zINpH9s22Q12DVReWnso1p0P4pm9QZ1mgPuHg+cTIRsQ2TqHEYMVU2expcqGhNR6
 YkQlfy6Wqy3rd7+uTLNpsW9CNqAKnq069HlEYoZSD8TTVvFpnwQfiToUSxk59VaM
 oHufhv/vnZjJJcoqFhcPqzdMHeAv7cS12NIa+4MUdEL9j2yCCpm97X4wQ7QdRHqn
 gwFqff4iulnucegoIQrymBFi4cTG8n4irD1sPINtVw/6KQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40rasvaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:06:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b31cff27fso25593991cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774422394; x=1775027194;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rQsKwSTJPFyNadQFvKFExVIvrmCLGMcz0vINVo0Po1s=;
 b=TthjUNir/uNphbW7wQhOJBjbNoxgPh/h2LHm90SWfQNLf+W7uc2kvs5485sC8QMLru
 UdrnsyarFhxwu60njfCeFfIC4v8Q/zdKt+nEuacFfLY7uyNLy/kuLVgqrw90/GKM/Ta4
 1xc05WamiJx2Ta3L85In5RTj+ebc5OS9nbE7dwfsg2EU6YQWSBOTksRCTdxAxWoKzCHB
 mVFG8mEUUgNYa2oqgE+Pp9f4YPjuvRyHkRGJaAeLk3Dn0LTHQ1InaxDBACYktL/GpyBr
 zAdZrTx398gNFJFo2WW+qMOt7d9+9aNtBMJcI714OiSvM/PSTxrfJni1+J7HzT+UhwQV
 GBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774422394; x=1775027194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQsKwSTJPFyNadQFvKFExVIvrmCLGMcz0vINVo0Po1s=;
 b=Upk9re92errJsypnOWcqK587yZXXAXDwLchArBoFky61vd0usKOtzF5Mlyn6pFr+0X
 BMAR/7bHJhUJ+ZC8W87WS01DFuzIdQr08dbWDfa5PGtg7Mqa8f3ex9aNGTWsKr6OFU1g
 MyyI8yc3YoJjvm5PI2IxVEpk5AiM8vJPLT504bMZ5T/W1TG38spbmj0RgCCKAjb1Vjw6
 073dpHdhYFn4CM3WgwZN4ISibULiC1IeLqLJjiX9n4Md67AQ9Of+e/r80uhtbgzCOJHy
 am91G1gHn5QHLHRla1OirVIhmkdEQmEg2nHHGBLsCALi7oMIWAerSeLYql8AFrk1+Zu2
 UmoQ==
X-Gm-Message-State: AOJu0Yx1fcSKj5t0nF9JNbLs3TuecI+AXyGWRKKMDDJasmEiUnRgWxWp
 eBJSe3BgWijgU8Wq1qTYPRVPqf++fBryTrcrhA9bEyax4iZn8XPcLFsDHWlMUaZwmmiOMhwhMHF
 aqV4ED15XFLiauGyEP6ed5c7x7ZqnpW9G80ubF23YFd1G67Ns4NgAfgycLPkRGU7pSM5GrCg=
X-Gm-Gg: ATEYQzyGhdOUx88BYdYwOy++H6RAsyJ943aNxq5qHswpkCjm2wNOIAZ9R95SXLG9FAh
 E/IiAI5y98bZZZqDayV7j/yBVQRYAKwpzX/Osj3hSLr+BXtxsGJcWrGpZxvu/rMIAeF0fRsSYfr
 vgkcIv/EeA7DPndBoRqW8OnyL/l/jdS4MLW85aO/VlIccMTix079hZl21pZR9Hbkb/FbxmTaB+D
 cmfddalUcSBmQyfrzSJne2axyB9en2lfyS+13gBy/qBbFNdemKMebVAO2iHthS1+zG6nMyL2iiI
 Z5cj8ELYbheNLu2O89lWQOsPY52eRx4+HZEJY59GhQup77023gFfZZiwSjktxjVft5Eqju1mZDJ
 fetiVQNIUGWosH2dJdK+HntqQ8wUkKoRWzytcZ763MpeUkQNPEhu2uvO8XOlfzyPaJC97pMHndf
 HOr39qqB+umj6iT1xwGX7xMtAH10kwevDTpu4=
X-Received: by 2002:ac8:5cd0:0:b0:50b:3be7:b04 with SMTP id
 d75a77b69052e-50b80f01b6emr35059531cf.67.1774422394497; 
 Wed, 25 Mar 2026 00:06:34 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:50b:3be7:b04 with SMTP id
 d75a77b69052e-50b80f01b6emr35059231cf.67.1774422393873; 
 Wed, 25 Mar 2026 00:06:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2852071edsm3641505e87.49.2026.03.25.00.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:06:32 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:06:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] drm/ci: add new jobs, uprev IGT and mesa
Message-ID: <pqa5xua2shwqpkmwbu2jitz2ogpbmgcd4wizb4nt6qtxstubse@4ltbfdvfpqxj>
References: <20260210071138.2256773-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210071138.2256773-1-vignesh.raman@collabora.com>
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c3897b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8 a=LmRgrdqyE-cJMQzL5zkA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: rduksrEa4i13bSR8Fny0aQaLdcRq-CjF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA0OSBTYWx0ZWRfX9869sq30Yj2N
 JuMP/r2xp8sWqmOfasxIR/rXJcE4PI5Q5VRJv06wjGXAoV5xvx+yQ13tl3RxftEjKup1KNNTrmx
 kEYZCmsq8HFlsgHj9iRyaCD08nY6LI0jDzlTD39eA08EU5+QMDpEcYOgWqO/3/HIRUR3LADY42e
 q0vqoUWdvnqjSkLBSQFTDrrqqBaHvC728pxUQbAUk/wAhVotTyfMLtIdgQpXhexRYUUGgYnnXuH
 HQUNrLCEj3TwW8FEaqlyNRQ6G2v2uYvaoBGOZeA6FQwpdpMajSYXHo0fLKidSCHzoE6axApbNkY
 EcQi3IPbFPcIryahnIgP24EwFX3yxA7pE+Z5G2+1//4jgfHkOxiXTCAZp0ovJE0hCvFz89HBF3P
 +ta0v1CBm7XM04iLHzOkDdXyl+Te22VdsyDHEwil3ubkLZX2zM33cF3u6xmwERcdEddrkPBFk9x
 gdLCMQaYWvt1JgzbX4A==
X-Proofpoint-GUID: rduksrEa4i13bSR8Fny0aQaLdcRq-CjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250049
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

On Tue, Feb 10, 2026 at 12:41:29PM +0530, Vignesh Raman wrote:
> This series introduces new job to drm-ci for testing the following
> devices:
> - rk3588-rock-5b
> 
> Other updates include:
> - Adapting to recent changes in Mesa CI, such as:
>    - LAVA overlay-based firmware handling
>    - Container/job rule separation
>    - Removal of the python-artifacts job
>    - Use lava-job-submitter container to submit jobs
>    - Use of the Alpine container for LAVA jobs
>    - Remove bare-metal jobs and disable apq8016 and apq8096 jobs,
>      as these have been migrated to the Collabora LAVA farm
>    - Fix issues with rebase with external fixes branch
>    - Update expectation files  
>    - Various other CI improvements
> - Move bare-metal jobs for apq8016 and apq8096 to LAVA, as these devices
>   are migrated to Collabora LAVA farm.
> - Updating the runner tag for i915: cml (switching from hatch to puff)
>   to improve device availability.
> - Adjusting parallelism in jobs (sm8350-hdk, amly) to better utilize
>   test resources.
> 
> Pipeline: https://gitlab.freedesktop.org/vigneshraman/msm/-/pipelines/1601024
> MR: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/213
> 
> mediatek:mt8183 fails and it is reported upstream - https://lore.kernel.org/linux-mediatek/CAAq5pW9o3itC0G16LnJO7KMAQ_XoqXUpB=cuJ_7e3-H11zKd5Q@mail.gmail.com/#r
> Few intel jobs fails, this will be investigated and a seperate patch to update xfails will be sent.
> 
> Link to v1: https://lore.kernel.org/dri-devel/20260127104406.200505-1-vignesh.raman@collabora.com/T/#t

Picked it into msm-next, thank you!

-- 
With best wishes
Dmitry
