Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5106C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7A810EABE;
	Thu, 17 Sep 2026 07:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jo1+jnwD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WYhE4f1c";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417E610EABE
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:57:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60swO1031542
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=X2X4St3guWcAoOB7DILepBAA
 o65atjpLeBGdoNEmPWA=; b=jo1+jnwD253Y9s/9j/kyAUTfZXO0R/GQC+5l83iZ
 ivLxqb+qPrfHT/1GQ6KyQKQ+UK2Lk45I6c7plEkXTQ7AhVGeE66mVWqgolDz8G/X
 kdZZPgXHIoSDAX8mwl5OacZN6n27lm4egfUjtcI1TprQmntg3rOeJkS3VsxeS2v3
 4sZ+UepXMfd95DfP1ZfWkUDsxV/303zQn0GcTBDod6avF4an1JVRo8bng6IKgpYR
 JQ0jpS0v4yNhrXmaoEBJHQbJjJJwGawkY81bXAlCz0SJq1u8bsjF79sae4MUIsFM
 mNqbLu5F3iKyf8AriJS97De10q69KEvJwRknLoYzjaB3ow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hb5fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:57:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a3f673221so197395785a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631851; x=1790236651;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X2X4St3guWcAoOB7DILepBAAo65atjpLeBGdoNEmPWA=;
 b=WYhE4f1cbFe2Oa3ISzSfxAD90iFe4cvtHFRIKAxilNx0M+aeWEt8kws6cAbbT9m2n8
 NZvGJHahWizCSEDQhX992LI9ZjL/OyNxfMM3PMM2p8z4T9/HelW7xQzPuh3gTEm2zQN7
 2myPIc11y/2QRyF2N1Jz/3MMDxXDNsRQKrA6aV1OcpeuaNUoneJRDEsNOsS71OIb6+6s
 lTPMvhqprpMupSC9wcY1I4CWmgz3ItXnzePNb5adIDlG9Ls69xpv/Rxd0+fkuS5EwY18
 usFwH7eDivpfC/YueIeZbNiYeBJD+yDRhZ9BwAx5W/lWvySh5K/BBkPHIaau3RWwRhoN
 nIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631851; x=1790236651;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X2X4St3guWcAoOB7DILepBAAo65atjpLeBGdoNEmPWA=;
 b=NqebclUNOTL6FRnE8bAJSpgNmI8w6laBiS9DHT+kECGXPeCtXl0ysXVrYUhujkl5wk
 id+YH7D2yWsw7oHWXyGmPGP+EFiKBKMZCGrVmw1oODPXZ+oUgB4Lb0KnJvANmnsKEmq9
 oPWxU8TwXunnbNGn3EuHTAdoLVTUzTdgsr8V7X6uIBgVnfolZogL0WJyKVvRrwBFqWxA
 +kYWXzQgInRy9tceUEVd1Gj2LWClR1nefp7kvsi8ReOa8paHDAaZ05UHP4jxIMB7DF8V
 ydJZt4co/rY2gHs6tG0qG8++C3Deip4zxvQFwkkcfVL6Ste6NsxeOfxqjt4kHl/FyM7+
 jhbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsHVnX/F1C48mOYpJ5NyNWbgbed1WAnAX/Yn0NVj5Mp/RZesIK9sHYPcUbXTsXO32NATWWXLyOCMw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++leR1sTnkDNBcHFQqN2hkuMgBn7PEEwQEMx8luJHjQDp0KUxYeV
 dhywuAJrQFenycEUwdedj6sVgJkpoDcxilRX5JErrTYq/jFmbyh1EiISD6BhDo6WS9+ZaVAw69w
 RIgD3NhiyvNbRnBgxuXLD5xmzqk2Qdwlo1yFJPKp8pl0gWO12DECrbrmxNAojTw7tM6eD4Nc=
X-Gm-Gg: AYBFou1eFAyEFWmqiwC0C5JcaKn4ZUBTaggZf5oLW9W4T/zlUX0ACaGoF6fXAaD672y
 OryPVRlqogrPDkspWMm+DXNqSfSXPbeWHuShAsrdFb6W/KUEXlETBgfPw0mvk/oLo4kwxbsUexD
 kJXYs+HlYFf4lGw6DnUVnHMq1JF5kufL2AfdMW5i+/6DhBXT1xO8x12qgeEGhpMvWUx7MdPB8Vd
 iyMR5Tkp5A9szvAl3lyo4UAij4AyUOZ2AtkmopP7v3VwGNrUcOx+sHQG1AOSO+EdkNiiVhd87B0
 WcM/ge1zsmp3fJYVdMwYFmto4sj/TPgFfMeiLqYG1vZakeSVA+z5plbajT2a5ZPt7QUmCz0Z6nx
 zXW2dggkaU5VfKphf2Yb77DuguwG/idHWONiwXTyG7P4K1yBJipM9SnaeBbwo6Vfmb0EYQ/n5dC
 B/ILlrbGy5EJ+f
X-Received: by 2002:a05:620a:272a:b0:939:6de8:43dc with SMTP id
 af79cd13be357-93bb794e072mr928714085a.48.1789631851564; 
 Thu, 17 Sep 2026 00:57:31 -0700 (PDT)
X-Received: by 2002:a05:620a:272a:b0:939:6de8:43dc with SMTP id
 af79cd13be357-93bb794e072mr928711985a.48.1789631851062; 
 Thu, 17 Sep 2026 00:57:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b57c35f4sm1572038e87.15.2026.09.17.00.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:57:29 -0700 (PDT)
Date: Thu, 17 Sep 2026 10:57:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/29] drm/msm/dp: drop redundant config_ctrl_link()
 from msm_dp_ctrl_on_stream()
Message-ID: <3iyvnipj7cxlhvcz7mo4i32qswhxcntqg6qmm2fpchb2i7tdaq@ykiwgyp7ezzc>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-3-c91d35d6fb9e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-msm-dp-mst-v6-3-c91d35d6fb9e@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNiBTYWx0ZWRfXwVxymRP1IMW9
 APxllkwdc6CsVFszarxZKGuZDM8/6LUugBFKjYMW6RDEn4rH6CcXIq0evQXNa/MZgcY3gl+Qct5
 crtDZY1rEOxqtMSehNdZs7Ak+gsx86vXekzS3j6Om3ql3IVUH4G+BuwlHAYGf9EYtdOgObHZol3
 UK5mMGHOkAGOtCc99Vv7CgX3/F56WGJyu1LqXp/Y5bw0QEPQYA7FZR00JR1MNIGJwS9sP/M6iRb
 selKRWRMx8nqvxEJiuK8qvlWTi/RMCtzdvppdlHSJlcYRA8v8/HV66m/x80ekfs3tvLHG3niekT
 nxDwd4n7TKsCa0//y+J5VwuZQN7JS0/mHRAbM2ib6JYDLWi5FsNzlw4YX/AiuyemwSsA7uFhn/I
 F0570ojUw+GJE1OJG/+tAo1SSm2lJt990AuJ+XIzFCsrtBhdpHw0CXDmRPMWpBYKUy/0nQQ/Fa1
 OwSvVvz4sSmtGXyD7SQ==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aab9d6c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=xvosr8ehAfmB6sJLDpoA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: AM_ikrsETWLxMDqsJLpAFj3sBw0PXgPh
X-Proofpoint-ORIG-GUID: AM_ikrsETWLxMDqsJLpAFj3sBw0PXgPh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNiBTYWx0ZWRfXzRhOZ0m/SM1A
 C7cC9gwr848c/TyvNm8ZH05Q38haaUpAkqxlVjtzHQQCJiuSHHeYgfBzcbGjO+PdpvKN/mgv3B3
 W1kHRz6S3GvfFprd/MsqQZyOQpuYFzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170106
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

On Mon, Aug 31, 2026 at 04:17:20PM +0800, Yongxing Mou wrote:
> REG_DP_CONFIGURATION_CTRL contains link-wide state and is already
> programmed during link training.
> 
> Calling config_ctrl_link() from msm_dp_ctrl_on_stream() rewrites the
> same configuration and is unnecessary. Remove the redundant call.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
