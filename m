Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF60606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hevO3G3k;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UMymLKMB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B14112DA4;
	Fri, 27 Nov 2026 20:44:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E470112DA9
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:44:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAnIS3346937
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZSkSS/hy39N3+R2zfTAM8tRP
 uUu4y2OH1GT6n9Dj9vM=; b=hevO3G3kN3FCw5jH2838MED4kg1hM4arX74YxsMS
 kKKSFuFyJ6dhqrRWiUT/Th3EMOqm8Lmk51R5Mn3LZhsLgT3AeiBJ2xEEGhtQn1qL
 n5EuHWTI1VAOudAw8BfsaUEdKmiYiHt8KCQujMonDG8G7w/6Yd0e1YJ7e+1NJdl4
 ed0PDLDzeJaDWj+gI+H4GUTtsUMaxjfNThGuzP2BIwxv0BB1VfusiwMO87+pLzGx
 xuRczkFsX30TEqt7y/onLhfa+FcF6qyhyQHR8lxXn/pzuX3y4XTMpSjjLN6vmtb7
 2/kClNi6pnZVBogoLEvoIt/CJG3+qF9JG3DNwyVG4gH+NA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhk35x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:44:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-949dc497896so744592485a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795812243; x=1796417043;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZSkSS/hy39N3+R2zfTAM8tRPuUu4y2OH1GT6n9Dj9vM=;
 b=UMymLKMB3JG1wnnqzg/he4RYpibHgCdN8FHLE+TN3L0VkLgEbfctStFxSgKkazkRot
 is1RnULHTK1rnPSMSV7N4HMsoY5cGmz+plC4TKOaR8IWcrsIiG1xHhxLaa/aVuxo++pp
 KZC7Ho4xQ9kie0BFHX/5J7B1cdiY6U3cNVYCxbarmwA6ihh1ek/wLhGTaui1Uvw8wPBX
 F8S/ZT7IBhzNqLjxvqzEjp4LnrwQzawKahvw2FSeFDdNanPSJZnjgad3Mh3p/pNVwr0g
 Z8xpBcGmZEfNfNh4WCG8ShO+jRiSPnWkpcvjI2JJYwL9MblHhMY6U1gXh1AKMQjoh61h
 J9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795812243; x=1796417043;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZSkSS/hy39N3+R2zfTAM8tRPuUu4y2OH1GT6n9Dj9vM=;
 b=LRnQtoCSOovrccW/u0BG6ZX8V3ct7Ech/i4qn8yJr57QT4iQeLSfgjmXTJlq7Axa4U
 j/npoK0f5sQ3ZlXENYuVHPAGLDRyUUOvMUKvgp7P/QD9CE/op47sZp0fFUd5w5VTzCZ/
 C6RalLamDeKvxf+J5mtvWwqqT3/dyx6+Mrho9vlgT7xdKOXaBzVenTOCnyWC91kxYevS
 05O0Y80zGarP4n90fEZO4sGm6g9IjYelI7gXWahwWKrNFwHRaRzP3a60w1kqkbieCtST
 ks3NhJ12L8UMjQgVlMmn+yyX2ViLe6UhtT+cNjNpyeXN6J7DBKk8jejyglrEGzmo95hK
 9GJg==
X-Forwarded-Encrypted: i=1;
 AL+hErEfTl73WNAyR247wG/9unhSgekZw6KumWmky/5AJZeUGx5gyyyMIzWOwcX1ucaJRHX3MTu9zGts3nQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9hIH0oYDDDhekfQg9hh5HHPP6nDBGFDMlFMWMpXAxu9nJkWCps
 FrZzAPxyCRz9RyTAHlWDf/ap+W9uKWrEeaI/+GsbPDmeKt2pu1meNvDTBqeDqMT03+qZ272j74n
 YobuwgIPh0DbWfVeswnhasqfnBM8XlhKgHkduR8uBqxmWaqLn58v5MlDODV0azMQZ7bOW6So=
X-Gm-Gg: AZFdTZfZ+oWbbY3E8J4lGrkKo2FUbVE0fSTBY1ySVrS5egrJl6nfIBEOMbk45siTFLi
 ZovCWDmf6YYLvERPQw2UxH5p1tOW3Qygh5GLOMEUMk8ELW9/9/gC0uzqz5L9YcUY3+gDvnV0SDT
 FpJln412FzEZzoz0QqK9ziZGbC1C9o9lK0ITzYrant4Hd3X6S0Ht718WsyQZ9MsE59scI/L/ZFs
 LWaj5fzn1+bHQxFsB/t4N0bp6cv24squ1IZcw5tTAFQJN5cChWHGFaUtfMgpzzhhq27GPqXVIpI
 Mjg+J/mqR5KYPhADDCylAFMcgDiYh560P8VeQziuyN+t/xExa9iHGsP/Y2PSaGbCERqQ6dJGggn
 Vv8wVDkR51Z6dTw/HgpnuUXdwS7Qlw+49/Dj675xVqnYrzCii0auuxpmEz4naOseIXcUS1wfU4O
 3Zg2h+1VApR8oP4rMeqDrhhvXoEDJVN2LNVTJqfOVKn51sU59mc+aCgz98Er3znw==
X-Received: by 2002:a05:620a:4012:b0:93f:228c:52fc with SMTP id
 af79cd13be357-949bab4d750mr4704918385a.58.1795812242668; 
 Fri, 27 Nov 2026 12:44:02 -0800 (PST)
X-Received: by 2002:a05:620a:4012:b0:93f:228c:52fc with SMTP id
 af79cd13be357-949bab4d750mr4704913085a.58.1795812242065; 
 Fri, 27 Nov 2026 12:44:02 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8056f133sm62291521fa.38.2026.11.27.12.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:43:59 -0800 (PST)
Date: Fri, 27 Nov 2026 22:43:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/msm: fbdev: Add the missing VMA reference of the
 framebuffer
Message-ID: <ueaka5zx7kt2j4o2mjbbfahqnx4sto2h2jc4q55willon4v6dx@i45gawmfpeic>
References: <20261126170535.361985-1-vz@kernel.org>
 <20261126170535.361985-3-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126170535.361985-3-vz@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MiBTYWx0ZWRfXxzZ0N4MZ17sI
 4XSPOBEV3HedQHfu6T1VXdX1+m4gaCCvCCV9cwG9fBuZJ6sOIC8Mk7pyNA/HvEwFnAGxcKs10PJ
 QdrRq9/2dvYmbngUoja8WMbzyUdwQgM=
X-Proofpoint-ORIG-GUID: btq-ZxC3DPXpqLiXdCUnRhaxQ9RvmWu8
X-Proofpoint-GUID: btq-ZxC3DPXpqLiXdCUnRhaxQ9RvmWu8
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09eb93 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-cx7zhLa7rps6zhCMHgA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MiBTYWx0ZWRfX/pKTLY+9qc2n
 oUkMtRogf8hbEIzT5zJtkmWjwO/GPG54hWcE4lKHwGGLZNx3W6Jzpjw485uD0hMOYzhCleqEmbS
 K5KAI4smDoZ4IEQ2cVOpulWu+kJ2UbOW395IMCwobJr/JW9hsDQD1RCPvHVQaASo10Wf3/shNYD
 p9hWFVDG3SnveZ3teK4YNlsoBD6EuXIxb4EASgfaZFUlC4DodxFek3CVk2d2qnMD+TlbOPe28gA
 OzCFIrJwlNvWW9XC8XWZ4Gdmrlpl2y/bdtgWGBaar2Te5vft2886+mKluvFOFrDgf47GXJp0gYG
 6LeGwbQZxCeRCKk+vRZNImXLaqq16kmbHFsn6WZuKPqsM5sPlzausf3ObaP1NU3Ylc40cvgicQ5
 PRdART8CADoop4J+RYpL0vNTsAL5N0uMMlCSUDJz1o+FaZgnS0k6TQM+1JmJW/FTeXfyMtPpPg1
 ms3+J9WoxLi6H8UEQiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270082
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 07:05:35PM +0200, Vladimir Zapolskiy wrote:
> A VMA reference of the framebuffer buffer object is dropped on the probe
> error path, like msm_framebuffer_cleanup() does, but the reference is
> never taken, and the VMA reference count underflows on the following
> deletion of the temporary GEM handle.
> 
> The missing reference also affects a successful probe: the KMS VMA is
> torn down, when the VMA reference count drops to zero, which happens on
> deletion of the temporary GEM handle at the end of the probe. Then
> fbi->fix.smem_start points to an unmapped address, and on fbdev
> destruction msm_gem_unpin_iova() finds no VMA and does not drop the pin,
> unless the framebuffer is prepared for scanout at that time.
> 
> Take a VMA reference before pinning the framebuffer on probe, like
> msm_framebuffer_prepare() does, and drop it after unpinning on fbdev
> destruction.
> 
> Fixes: eb714953c441 ("drm/msm: fbdev: Use a DRM client buffer")
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>  drivers/gpu/drm/msm/msm_fbdev.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
