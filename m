Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA74AC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2229410F5A0;
	Thu,  9 Jul 2026 12:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o2fAAmFv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UYrOM5CP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E98610F5A0
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:46:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669BNgGH1628795
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 12:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DHtR4jzhJvIrAtVRAzbVcsYU
 lhY97Xzupz9H7IBcdD4=; b=o2fAAmFvAYYLy+eK1faE4nbwATt4Hr2wyfGaQp2P
 BxC9irIQQdNpfSN9mIBieZ0Z7MPw40X63wTeEZYPvCXgKJ4mHgaGS+HQEdF0w7aJ
 L1QrsqVaiy+Qv3SdIbAzvWp5v28Y6AxL0SSWit0IX6kwbvbDY/g8IxaJgluUYUxP
 5k2tXJ0VIB2VTHSbw91c0G7pgMKLB0xKPF6QGqBnjmOrUXK5YjND6GajATqUxLIC
 MAt+A+0ob2Q1kByw0w65tfp4qQt9NXD5nUo5oQqH/oEKTVKEy8uE7s+hZtPWs5G5
 J20lmSC7o8E6Hh5+ly32mFCgHRqs7GN1C3K5VhFLIi0c9Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvupet-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 12:46:42 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-738e5b5ef68so282021137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783601201; x=1784206001;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DHtR4jzhJvIrAtVRAzbVcsYUlhY97Xzupz9H7IBcdD4=;
 b=UYrOM5CPvalsMjW0x5vC721iQuWo4wqhvhmlttPP3qYBRKW7d1RWtw0rd56Tuakdav
 437BanaD2jk6aksryXppbyifuSV89OAdSpE7k7BJ2QmxGbBgPAODiE9feWXSCZMOwqaw
 4v4ILfmQDbaUh69Tx82RVxHdqN5oNC05yQLaaqcVNV9Alq8jOzNsyTwtCJmURhtguiew
 0BM8Tp+LHwV3pxkLNMNgArEiZrrqSUTHi4PXjSrmV1EQ6H6qjTzuWdFXdjcvqVrK/FZk
 XZG6TLJD+zo0F6lwH00FBJYj20apHiN6NCpCHQkAZ1vdOHfoeRpIpG1AUofTPrJ/stLD
 L8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601201; x=1784206001;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DHtR4jzhJvIrAtVRAzbVcsYUlhY97Xzupz9H7IBcdD4=;
 b=boqvVLqdabv9qmWFhuejyJwJ6ZcFBVJfotVRBJ6vfc8bWHmFsbPUcwNk4Y+itufGd1
 ltX1HFy9eVRaIeSqC1HmLJW/iJY0LfsSrOT1TbJRBFptAL5G/Lhdplai4wy9Dn0bPAT2
 8y7kwy6PhVTsmT4LDZyRY0REkcrwXQVp5IXUYWKyM3QhiYD4M3kpnQd2BWoScF7Cl2WJ
 oDhrTY6ezqvPcoSwp6vjMDqVtBdWjPRNCOX+ajEw4T+7AHXCh2ANcH3D/yvB556xzx1j
 L5N/iRaHXydyViRG7oLt3XzCKJvssB/wCDSF1TC+d2gISp9+uHcREKhT+S19/w17a1hg
 SalQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoB7e7o1jvc1wy9J7OYZq6yegMq9mpy3MToq3ysdeouqTtrgSMNsy/jfSlcFlLmxrfXBRJSVQl4etA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzb9wktCbgCpdGwSTL+ew2kaQufyVzxdme4GJpEgFfF8oxG7si4
 SE9XnfP+UwKDTyppFJwzZwxiObfmROxD58BZH73ezkyOomp+xSLAYMIe6TiSSsprRz71DMgUOR1
 S91Sgf5/yS9TBgL0E6B5fxCtPYAOcU3H9PvAIAupW1qTtT39/B3UFtTayYm1+Oz0Wa4kyiA4=
X-Gm-Gg: AfdE7cmZNE/dhaCSGa4nJ4Id011dtLLdc5hwASlxrXOUzar1ZdEvsRigSLLZgSNcsVM
 70NvXIxAFJNrXoHkA6zGl7ScDX267849+VzGmpqHv4Bqpx3Xg/qGXbiYrUza/g6w191nHl+JF0H
 Eqq6+LHDq0Q5Yf99Q0XsGXVFpv0HB2a/pyEhpWkvB0zFONq1iRXr8MKefivb+yr6g6pxL+88irE
 kg9KMuybISfIdIfTew2BCf8ca8CiMhb4UL4G6EZ4Wp+6t/Z3w7UGkcnVI6MgszodZ30JmAsBBh+
 VEpGOAhHzeu+/DfM9Yz1lCTrRagDgcv8aZ5Cmj7x2cmvSG2UNINAEB6Wg8fZT20/pdm5RdEEY5z
 WXzKWpUy7EJ16esaJIpcx3sQz7xEWry6+NiWMl1XwHcNjRanO/HOZpzq9iYqgs3zX1M5Ace8H5N
 Et7PppQdDECEa+a0RxS4tl/EPx
X-Received: by 2002:a05:6102:292b:b0:738:3525:4403 with SMTP id
 ada2fe7eead31-744dfe5c18bmr4104951137.16.1783601201533; 
 Thu, 09 Jul 2026 05:46:41 -0700 (PDT)
X-Received: by 2002:a05:6102:292b:b0:738:3525:4403 with SMTP id
 ada2fe7eead31-744dfe5c18bmr4104921137.16.1783601201109; 
 Thu, 09 Jul 2026 05:46:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed1377075sm5142317e87.28.2026.07.09.05.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:46:40 -0700 (PDT)
Date: Thu, 9 Jul 2026 15:46:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, abhinav.kumar@linux.dev,
 freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
 linux-arm-msm@vger.kernel.org, lumag@kernel.org,
 marijn.suijten@somainline.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run
Subject: Re: [PATCH 48/60] drm/msm/mdp5: Convert to atomic_create_state
Message-ID: <kcexmzb5sukst5366m5k6docyldh4nrw43p5gigqiznwbjalxd@5ncarrjxdbai>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-48-302d986fe5f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-48-302d986fe5f0@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyMyBTYWx0ZWRfX5aU8gfFVqhHo
 dL+vmJemDoUMTZJS4fotXuEW2fJzJwPIc2i03Z2Be73u1kbuIecGJebD5dCnjvjGwY427DKXfTb
 AaeTFt98bOCDDNvb8CvnsK3RuI7ilng=
X-Proofpoint-GUID: ba2e2dBUEdRfJCqPXDDfaM_zn_nwfGOR
X-Proofpoint-ORIG-GUID: ba2e2dBUEdRfJCqPXDDfaM_zn_nwfGOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyMyBTYWx0ZWRfX5Lfn96mii+M2
 UO5qdhJgscZsBsdUxpHn1OZcoyY3pq5H7aUPBg3mGw0ek/qW182uQVVrFkPsrSErhXEoAP+GqM4
 Ab1uYQ+Sd7r2lDN+fmOxXelH/Lsv9+B/lm7fj47uF3bF8x0ir8kxLXUXinngPW/r5uYCPWLlWse
 3XGOS5uPYmQGE0MtrftAA9O359DBiumxO82xkWdgZJ3t3pfjFtztHG4BxIZFeTA3d8WSt9GrR14
 zH4UzGfUidQ9D+G2J4dD1bCFRPJmbLZcU/BIQURMqeAM/i++pu0aYV2HoHvVNFktWde/niFbj9d
 4d9s05cAerZJQci95hvhe4x26CYsgoSPbfOjrBZz7tGlnuDgD+M6kxnjatBuInfmCFXtLN6daH0
 UFykmQlfVRKd6G+qOnrgza9vRsFRhEibZUOKABW8bwF29MLB4pOMl/KpwTAPG2ktqcw2qKi8hnI
 vHGoe+XbhWEzVQ2/wmQ==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f9832 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=mVv-3nkEeNymqhpJ9RMA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090123
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

On Thu, Jul 09, 2026 at 01:51:14PM +0200, Maxime Ripard wrote:
> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
> 
> The conversion was done using the following Coccinelle semantic patch:
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Ack to merge it through drm-misc

-- 
With best wishes
Dmitry
