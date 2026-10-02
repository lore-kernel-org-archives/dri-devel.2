Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6359CCA5FE3
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 23:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA1310E5FC;
	Fri,  2 Oct 2026 23:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ogc1zeQ+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g6I943Wl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D43C10E5EC
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 23:49:33 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NegxC3338163
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 23:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bLBRbVjauRRI7q7UjOKnZctg
 JtzUCDz3Cs9ztedyGrI=; b=Ogc1zeQ+P6nm8k5MEBUmW/F2abR13RDGbM0EOUxK
 HeulK984U9JoQw5A1anyORtqSgEJMVzgJlUYxtvN9jOd3nEWlf8+jVEiXxUX5IXT
 o1iBsGGcs4J9ebNutX4eXGqoozdognG4O0kY60g4/EqnGH5Z8rjlI7t+b3SSR5g0
 N/rxEDN0WYBeUvbQXqSepgsamIuc0ziBHndb5xL166qQTituUMs+bi01l7X7kLfn
 JW1nBptm9Cgyv8XBnjZGMfZGfwXQEcnCUxhKao77CldyD5VImyUG3TtFw9r8wy2l
 4PQghiOR11bL4xSYIhu8k+1k/LyeEhq7yXpg0RgzvBYGEA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj030ff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 23:49:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5350c2b31c8so1860121cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790984971; x=1791589771;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bLBRbVjauRRI7q7UjOKnZctgJtzUCDz3Cs9ztedyGrI=;
 b=g6I943WlHvut2Bd+3TFidEWNMmd7i0w3TYLFDKxb24pGSaCyRJi9hkYZ7gfd5XbgvQ
 MMgladnCrSz5triOpDvqa1jMW1BjTYBqZxKB2AAxM3q29RogMjKo2JwwFbBB/schTzBs
 T3O4bdV4zE4vPutJOMrImOF0Jt8OOIQGkccMXnzd0JGI4Y3u8+YgzfhRsm4I8ZOUesfp
 auqB7Ba3ZGqyM9gW0QBaeokRejYdWLDvIW/YH6f5HeDkHaMutKY1s8P9E7TL2bwnPwnp
 u7sB+9rZJth+30aqbv+iaFDPzEyNXfPVN7foLUiGkIkpiMheUPLoO0M+63053usiXWte
 Yd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790984971; x=1791589771;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLBRbVjauRRI7q7UjOKnZctgJtzUCDz3Cs9ztedyGrI=;
 b=miZuOvbROyrL4JMwllRG9V0gx1Rij3Cox+sO6vhE4h2W7O52ug4xdbpMBarGXH3xcT
 dodkT/XMiWeHjUOLyahNtVTFSD9B5sKL0+Ds+FS4or695Dk8xG3ucjeY5J1Qtnih7anF
 xEeR+MAQiSP1lq3hH0EwtEvp6V4y8nqHhUgcpMULIELtewOHUEhVstnQMjqje4eMLyOX
 OrXDbTmx9gX0CFzvBNSYe7n8NNPwS8Uq44HKwNIiIdkMeppwWqhhRU7/GRdBbtCaC9Xx
 rUr24dxx7H0gQI5JBSOn0Ws3kzrd382qjePfegLYpBMCJcFd5auLym1FnfZAku0NxQSg
 unww==
X-Forwarded-Encrypted: i=1;
 AKwUvBwg8NUFR2s7+M67jJAFqDB3uxUUOm71fTaZ8DQkvnXUX4aQcf8o1WlWXDx5rnMuwV1HljTf183+Id4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lDY3mto0vUcuBTGhnwNpPLDQquZuFI4+Wl5xE6sR2FNFhbnj54
 zVJpwTvkt6b5sPkOor1nLT+wv5K+N9cv2xDFwbW7XTmpNB2Ippm398HpSCF0UI0P21ELEtLTb6S
 DGUWzAkfso/buciPByJLERBxHpID/govRdAJ5/k7K3fDKevp5RJLFc7X0XhArFoSZmPMxnjI=
X-Gm-Gg: AYBFou1wKeoms+TXnePESiuxYRwYURHvjfija8Q/3W4RpfH0HsR6/3lLj+Dd/0NUa2M
 67jaBM3tW5vawVFwzl8ZMtr9z3jbGdkqbRMxnwGhKRSeexwdlhk5dhZW7bBZQHdjNyVHO3IUO7b
 OWJ+rClkCU4OQqGGxok30H9Dx+b0JRVBLhE/2Uo0lWwj4OLutBRP+ea5svpN8VYPFWCpf7qYuYN
 5lmkHXo19MumSCYaSJPnSdEg0f/Jam13BMtiEnWp2auOS9jDZ3h5QxW7QTuCKRBq4D98M7oXkBr
 xE/a/LgB7vnLDou95Zg/EMqqaw51oZc14T54DsCDe8DxHZXYwA7N8TCSls1s8L66xU7W/GxmLc3
 vpga9n7sZPrBb0Dma/KQb4y29RX38PcEyIi0gbqWfQZiltzudznUx2uNX3rJqcjwx6GqesfDOin
 Od5JcdJF28qgxj
X-Received: by 2002:a05:620a:29c8:b0:939:78ab:3c5f with SMTP id
 af79cd13be357-93ce7ab3b10mr873956985a.9.1790984971125; 
 Fri, 02 Oct 2026 16:49:31 -0700 (PDT)
X-Received: by 2002:a05:620a:29c8:b0:939:78ab:3c5f with SMTP id
 af79cd13be357-93ce7ab3b10mr873953285a.9.1790984970627; 
 Fri, 02 Oct 2026 16:49:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e310343sm14146231fa.29.2026.10.02.16.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 16:49:29 -0700 (PDT)
Date: Sat, 3 Oct 2026 02:49:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/atomic-helper: tear down HPD/polling in
 drm_atomic_helper_shutdown()
Message-ID: <apoihcgomlbupimnlvh7b43jt4yhvcyrsdrfjkvqy43onjtbbn@gf37mvuz3keo>
References: <20260921-dpshutdown-v3-1-e456ff7fbe4c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-dpshutdown-v3-1-e456ff7fbe4c@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX5t+65DGlrqrG
 RjCmjs8U0JY0sopKydpcgv+6H1ifYWw7nB2XjcfuQOQm2FXwIm/fBqdvxVGNikeFpQgDW59M884
 KDtl8uWYzI1Pev03NkV8f7Dr7xYgug0=
X-Proofpoint-GUID: CIeuSvM4YHop7zo7JmB8OX50B0tPW5fx
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6ac0430b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Xji6uK7NKlMfkFQx07UA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX28IGB7Twu+mi
 4buDQmgkLjE+17ExE/o3Hf3zWW29X6cONu6KUrigKPwvM2ahiZTjBDZF8ICxublZAjD5mFEkN8f
 IrEqLvDEHs+XIHUwzYb6i7FNTJYr3xY5RL0pVJksHdIjitjqwbC82doz6AmBSgFojEnJuCzHuaP
 zGn/2hkpsWy0FknKHr82ErYkZvDqc++CNB0kivxVeSOwpSejTSnrMQtl35sw0w99Tu1UCYCSNf2
 cuVsk05XAKR+OSogdEo3qMhrBSN3LEXFRDytMD44H/neLtt3p7hSR9oaTv8KPt/uceDIlwNF+Ll
 ih64EwXnwPyW0HZQRZNSb0EkVUOgOHdZFaB7Usrk0n6mDz34F6yVwr4pXV7b6tTeb+d64sMPFV3
 4Rk1epIxaVl9oJxCOoBVQAaIDko3BgLL2J/UvBCN+WT6bJRwGbFaHupKF6I0+6nU54ZG5NEULdH
 k5AKRsGu2PK6VYkMZuA==
X-Proofpoint-ORIG-GUID: CIeuSvM4YHop7zo7JmB8OX50B0tPW5fx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020095
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

On Mon, Sep 21, 2026 at 04:49:52PM +0530, Mahadevan P wrote:
> drm_atomic_helper_shutdown() disables all CRTCs but leaves output
> polling and IRQ-driven hot-plug detection running. On reboot, a late
> DP hot-plug-detect (HPD) IRQ can fire after apps_smmu has already
> disabled translation for the display subsystem, causing the HPD
> thread to kick off a new modeset that drives DPU/DP hardware and DMA
> through a stale IOMMU mapping.
> 
> drm_atomic_helper_shutdown() disables all CRTCs first, but a pending
> HPD IRQ thread wakes up afterwards, reads the DPCD, and fires an
> unsolicited hotplug event that triggers a second atomic commit
> turning the display back on -- right as the IOMMU is disabling
> translation:
> 
>   systemd-shutdown[1]: Rebooting.
>   msm_dpu: drm_atomic_commit: committing (shutdown disabling CRTCs)
>   arm-smmu 3da0000.iommu: disabling translation
>   msm_dpu: drm_dp_read_dpcd_caps (late HPD IRQ thread wakes up)
>   msm_dpu: drm_sysfs_connector_hotplug_event: DP-1 hotplug event
>   msm_dpu: drm_client_modeset_probe: DP-1 found preferred mode
>   msm_dpu: drm_atomic_commit: committing (unsolicited, re-enables display)
>   dpu_crtc_commit_kickoff: crtc94 first commit
>   arm-smmu 15200000.iommu: disabling translation
> 
> Call drm_kms_helper_poll_disable() to tear this down: it stops the
> output poll worker and calls each connector's
> &drm_connector_helper_funcs.disable_hpd, which for HPD-capable bridges
> masks the interrupt in hardware and then waits for an in-flight HPD
> handler under bridge->hpd_mutex. Suspend the in-kernel clients as
> well, so that a hotplug event which still gets through is recorded in
> client->hotplug_pending instead of being probed and committed.
> 
> Reported on Qualcomm platforms such as lemans-evk and monaco-evk
> during reboot stress testing.
> 
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>


Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Though I'd really wait for somebody with deeper understanding of this
part to review it.



-- 
With best wishes
Dmitry
