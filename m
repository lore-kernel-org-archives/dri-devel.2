Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D70CA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2874D10F547;
	Thu,  1 Oct 2026 02:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ElhKTu5w";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b//YZI1q";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02F810E2D7
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 02:09:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910kQg91144078
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 02:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=drdQJSVNiJggGHjwRXuZScgG
 pNHIrvBxG/h8lfRLgls=; b=ElhKTu5wAGzVyNoOMxsOnb0v4HyhDDgfaTmsZ0QM
 SHQblSGrjm0e56ZcyFeIU6VBH9P3sgpU4T0uiv2WnTEoMJM+l9bRs1SKx7sSwrzI
 Tbj0RXjAZFDaD0+UfS2YBNq0OIQE5EBBwiWxd2S19V6SmnqcNUSZHsx9QBt+5EOO
 wnki1f/InzmriZik0KuQ7moxI5Jy2qkyJPQIoBNNzEsa8olz9zqCWh3Dr5VdkiQG
 1Hxg+Y4biFVl0D1/C4TTEalds9kzm1t0lHptfEJWXVl4VT4j6QEEKJDKWjazQ98v
 ErWtyFbPt/GfDEU2KcJKQmURDRXIx3OGUCRGb7dZu4zy6g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh58ky1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:09:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so1555245085a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790820539; x=1791425339;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=drdQJSVNiJggGHjwRXuZScgGpNHIrvBxG/h8lfRLgls=;
 b=b//YZI1qgujykBth5k9bMENXgmMtsFOPqLYNMO9Jvci6U+Fd6Jo11h10E2U6iN7mHi
 BLdy3iw7ZFKqerjLkFcGKphfpUplm2Tze4HvKnFt/Utr8TNOtsAqPUNiUHXNPLgzzdQN
 k58pIS2vg5/uaBYi3RFHiX2drRCXE1MbE5I8r43T+q1vN/jQ/09Dy67OVppJK3JUxlGF
 5OWhjpKyhAMasSoh9+ah+Ku8mlRF/2XO7BevSKkz0TvoYTsiKUmIYtDJyBm+ff6YxX+0
 8a7z9nZ+xEJhxjcQul3BLzyvnHA+waB9y7N2zYMxnXTQbRCzon+DGudwNdL20R58iToM
 rKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790820539; x=1791425339;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=drdQJSVNiJggGHjwRXuZScgGpNHIrvBxG/h8lfRLgls=;
 b=Yb6Na7PWnoCiN9KjEW92YVrYQDPd8a6V1fo7NXjyt9o9xou0xNnPD2GdqJROHu6g0P
 f/vUQ6qrebVkptnGFr3PrHyITNc72+sesqwL1RR9S5agPGkreSIe+jVtIpz1YVoVi72i
 9uJ7gFID4RNchmu9Pp2aNoUVMsQxKVzfgaw/2fOkN7uY7sem+H/IDEGPIvAv0um/ZllH
 iHUBuXlFDYH5/ZfIuRnbC9aYHsHYjCAlL5B1wTV0yBOgVDc2yJW4IGCeFaBE14Wk4H5l
 IGzh2pi7gpqXaeVfQ3is4Q36PekIxHtMGL0Mrl7TiOenFg9ltveJSUmMBjwY86cFfSx5
 tAmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3ZleSP+CrNDr9kcW1ZJsXFxfQcrbPW1K1RVXnvcOMaaLBr8Ge5RrHynvtWMV5gZnKWnc988W2G1k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mMjZ4OWfRD1A8edmgl5t8j3ekUKtzNpwYIcQWaJs15P8EcXanH
 /J0FgqyMhkSfxcVKmmSuIbv33f17s0KRa8Uf7wpZ4hF7KCsDFTCPXewPYplmjdE6gFGolTqewbl
 5rd8wqoBaURQcPMuJ1xSz6XxzZdOGaRFBnIXb5qzJo88ugFNMzHPS+93Vsn5KbDIvukLonHc=
X-Gm-Gg: AYBFou3rj3XzNlqWZ/+EM1a+nQMXxxDO+U7Aaqd2NyoObv5bvk1CKAJHXpglxP4xONH
 r5KLV0DL1Hp5Pr81WFNuIpdLR0UlwfnCxZErT997gWiFCHmZhMgUysPa/TMJDm0EuxlDWiwKN8e
 HrnCal9Bz3cmPH7a9GKgBiHEvA9gTmBBEntvvbZTkbvUCgIeMTQ1d/doEVYik6jtXCXkIc6SRGN
 UIP7mrfKRlxouQtY3GyZ2T43i6HAhUF/RN8st61pwvsgGwC0KJCPXGWgDflxAiCnk5hjAdCsv2V
 jHLDScGHy384go0FvtGP053HdoOjFg2QMdLv/hiVzyUl8ymqNbPoSspS1kI5wnkINA9guAWWRwM
 gRvWd8nkMlTlDQwFlgyG6Sf/dcqIBcVT0F/3Z7k888wbmR9KBcmb3/e8yGwZKVBZEzOCUrIF+ML
 udSZo3GLgTM2Op
X-Received: by 2002:a05:620a:1a21:b0:939:2c5c:7977 with SMTP id
 af79cd13be357-93cac0bcacdmr602119985a.20.1790820539124; 
 Wed, 30 Sep 2026 19:08:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1a21:b0:939:2c5c:7977 with SMTP id
 af79cd13be357-93cac0bcacdmr602115185a.20.1790820538481; 
 Wed, 30 Sep 2026 19:08:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fb1e05sm351568e87.30.2026.09.30.19.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:08:57 -0700 (PDT)
Date: Thu, 1 Oct 2026 05:08:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Roman Demidov <roman.demidov.nn@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 1/2] drm/msm/a6xx: fix use-after-free of OPP in
 a6xx_pm_resume
Message-ID: <dnf7zmshpgt23eaom6pxcatxusouw3e2yt2kix7xkl2f2tkl36@f4n7yulqgctk>
References: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
X-Proofpoint-GUID: uyx3DuIzTDZ25iIiqhFeil1OThlhVrvs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwOCBTYWx0ZWRfX8/mUf2sgcj/n
 MHnZsOclFxg2vypp39N0jSZSbVf8EUf9GwWy1CYMSsLog42AyjVohAdXwyFKX/UZ+xUSOq85TtT
 gQqTh3tVFw18RAWO6AzGvzntVyCyAy0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwOCBTYWx0ZWRfX19rUaOW0iCOq
 Gvat1boAGFbVtwZuM7oZwQoP95BZit7b9QJVK348o2fvyq9bJkdHs2d9kK4sSTUEp0R/tScQ1Z+
 Lv5ze9pb0JODsNQJUbAju+ylwcQeOj9j75OF5wij4ZTLFvIeeC0H7okgQp2+8nftFRtx2K7uQfB
 cTHTTV6KCbafghGD0CcjmH9whIUAvlS/giF6o9qhsOVdWyKS/NBuG3ldyNGgoBs+u9u7Rg3Q1QE
 FSONpLKk+PFQjf3bnmoQJQqdA4kAPyGH3JKa6RjNr1DWcYlnzFHYT8Q+psAJG5+Zs9C4n3cMP89
 r+VCSwYUeUQWYHfbDymXUcvdt5UXHXZnqrZL6BzIqpou97YEAqML2CuLa7T3rwx7box+yinNeIC
 7qXlXEwhuWWXOyVvy0kUGXMoToEKm7PMCXJqaFUdooI1GmIKvm5WnwXSgXeEUw/Ba/+JKS5t0Ba
 P4z63fVAyfgzVO0KekA==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abdc0bc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B-1eJkrdMcac_h5ztLYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: uyx3DuIzTDZ25iIiqhFeil1OThlhVrvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010008
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

On Tue, Sep 29, 2026 at 05:20:58PM +0300, Roman Demidov wrote:
> The OPP reference obtained via dev_pm_opp_find_freq_ceil() is dropped
> with dev_pm_opp_put() before being passed to dev_pm_opp_set_opp(). If
> the reference count reaches zero, the OPP object may be freed, leading
> to a use-after-free when dev_pm_opp_set_opp() dereferences it.
> 
> Fix the order of calls: first use the OPP to set the required
> performance state, then release the reference.
> 
> Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
> Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
> ---
> v2: The dev_pm_opp_find_freq_ceil() function returns an OPP object with an
> incremented reference count. Dropping this reference via dev_pm_opp_put()
> could cause the object to be freed if it is concurrently removed from the
> OPP table. Fix this as Sashiko AI <sashiko-bot@kernel.org> suggested.
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
