Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98557606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SQU2CaV4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YIdiz/3c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041AA10E092;
	Fri, 27 Nov 2026 20:07:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0821A10E092
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:07:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAoNa2127644
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oh/vzk19jdClXLP1dpmBN9YXjCpwvxMhmfZBVEqASFQ=; b=SQU2CaV42WfJHzIa
 TY/FASVsPYHtxLcb2w4hUwSrnUMTz6jVyF0haDNWqhPuQb+jXkGM6PoaRccjkMOH
 Hc9s/bcQeRTBTrFs4sEyCpjcAg9wdLixKIa4LZXj0rc0LN3+159SaJ8yq9UT+3wE
 axKiPrjPX6yvbKeE60bNuiSL/ud6LsrIFw6D++DYFFYvJ2ASvMciE5OUp0twPS8x
 FP/DuWdZgpCHQ9dcRt7V7RzauF/Apa1fXoJ/SrZwheVNjKPKMj22uFcVlhoYnV0U
 Xsp8D9k8Pb/1dHGFQMhfJchUz/qxMGll8WEaBs1LXDZeW74C0sLVJ4YLG25ArHUd
 CgkNpA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7e7d0crj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:07:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ecffb6a384so3688586e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795810053; x=1796414853;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oh/vzk19jdClXLP1dpmBN9YXjCpwvxMhmfZBVEqASFQ=;
 b=YIdiz/3ce1ZCSfysnhmtYfLDuuL7pd6oFqC7DfQyT4RvDipc6rUQ4UkTTfJACN4Xw2
 qYDyFAHErK5LZcy+AmHhXCbVB06+atjN6oSVajYAb8vFWGBSndWbgHEdw6IVxls/3b6d
 bsTZhdWpMU1tefLqO/tMsdvuQ0HkeLTwiJ8TUL/n5zs12vgmLuV03r1cQ+JoaMSeaa2x
 dyqNFJhDyb1Mpo57fTbDAzkcC08aCQXITn2OMZewZwJRTN+r88pWelMg/OXgtOVr26Jf
 2d22vMGM28WslvGfecMwvt3yOyoqGAeoveEPYVFBtTSF7k0t7YoilUHPOQ+DJz8X+xVo
 RgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810053; x=1796414853;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oh/vzk19jdClXLP1dpmBN9YXjCpwvxMhmfZBVEqASFQ=;
 b=e+UNhczBudhR428rLgrmDAE7TypjuwfJrcimxfMV0wh1LgHSCkCmxqQyGmCrjuvSD2
 6CClfeKw6+yIjcnyG/FwHG4+ikl4OYXG8Ly2ZtSU3mgW4mTjG7U4nbBg3YXoSHsom+UO
 ZeSZbEZKrFKl1HR3AKclLFOnBw4grrTixyJ/OqK1HofFwz0XIS9yMdgnE4CIG8oR6Do3
 We/M+kHgd8Wy3TuvWMyCggWyCRuYSJwUkOR4ipiri0xg0jvhc3uHJ6gV1ehD2MlWC0Sx
 gFGaqti64Y/Egy0205lhUz9Q9HDlnT5BqDDQmdANn3r6vdITPQDJUdiRoXUkeCQ6igV7
 giQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGoxhx3BBOYMAJuJ9QiqnfeqH8NjRiKN/L0it490tcFfBAjebR2DZtidAdSi6pNNSxt6E943kAgvw0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8JzGnsl5/ZHccgc1sMWJSzhBQHGfyq/oJ3lt98Y66LCCD0BgCx
 6QgJ65f4vYIj7pod0hQTIKl6JZ5d2FlFLdDC+huicGp9ENWeD3REYaooJ29yNFkXlFE1QUpySXM
 Vqu5wMPmraTBrrbC3wla4lz1IKKRG68qWYVQaY+zOclVSAxOyeaqmZ8h7zpiY6H4yvgHvYjw=
X-Gm-Gg: AZFdTZemqGVxFwRFRedBudpRspz/vaANJO3OPj3dAFt7CRE9Pb1pxoCpMW43+j964ch
 7hEeQVxcS0hLSXPQWgey2419YobHAMeWw11AyxSHtR2cwOqiavekFM1Nt6cSiWzXtbyGY666ZVk
 HeYRyqAvbgugguY1x7UISvMa/5oLuFmXcHVarlQCHEeOL+GyvEhHlcdPztNBGUgiG94BORlwsjB
 pc47Q7GqtcceCAZ1/gteEf/OVEYaRm0SH48BLL3j6qNAz+dnQwAJz4AZtJnIOHCwXlWwVNWhPsq
 Nf2M0dPvEFG61IRGFH6nRxQA11hZhaVDJIpy6qFAVivCoBsseakcA+QObI3K7NVTGvMhFPsk8c1
 WKtEpFCGC5SCBSMdG56eP3pYkmImyPzyJQ/OfzHhRc/01TQbU5jPBoim7G6Z2JEMsjGiqTR20+4
 LoZoq42Tq8j++9eBdSlcV38/i9ZsJEIetySmAOkkljl60/5VW9p6nn7XidTNEKrw==
X-Received: by 2002:a05:6122:3d10:b0:5ec:16d2:4537 with SMTP id
 71dfb90a1353d-5ee8aebfff6mr16711941e0c.7.1795810053398; 
 Fri, 27 Nov 2026 12:07:33 -0800 (PST)
X-Received: by 2002:a05:6122:3d10:b0:5ec:16d2:4537 with SMTP id
 71dfb90a1353d-5ee8aebfff6mr16711865e0c.7.1795810052932; 
 Fri, 27 Nov 2026 12:07:32 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8044e00dsm69559081fa.3.2026.11.27.12.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:07:31 -0800 (PST)
Date: Fri, 27 Nov 2026 22:07:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexandru =?utf-8?Q?Andrie=C8=99?= <alex.andries.aa@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: use single DSC encoder when slice_count is 1
Message-ID: <urgy4kbfvofgjznraum7gtjtrhikbthq4sfad35nc3jbzb7kaz@uswmsjw4ygav>
References: <20261119-upstream-drm-msm-dpu-dsc-single-slice-v1-v1-1-4744ad5b9747@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119-upstream-drm-msm-dpu-dsc-single-slice-v1-v1-1-4744ad5b9747@gmail.com>
X-Proofpoint-GUID: qODZcQpHRD31277WlPZWjyCTvgwQQrVl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX1Cp4TKemzmHM
 rDGDHPsIAtJe50Sn+GKotel3+9+MLj70NAfNkeVio+pwmCmccR+8aFdRkUk4jS3L/VxEBrcDaZ6
 MlaH747ex917Uks/kkqxFQZ6Qflosl903p4snOjBFW53/lxzYSH5mbFalaDgNfs/vWWrR5xSttt
 tkJcDoNGft7eRIy947sC3iKQvZR+5faunkwAhGPjJBRH0IYfgcrCnWPK4xAicNl1ad4ANv+zVCx
 5wGQXreP6KRVCK9o8ZMKcVSSkpbvpa4Qe3BMLEzF4zKi2xsJisC8I629z98BC/PSrP9bWst38Z5
 3ZFxorSrvWE4tmF3YGL8XMNh0JQIzFCxCZGyw7HYPmXNu55vobQVyYf6FA4E3kR8cEFqxtuNnEG
 sryzbG/0hRyOBmPC5Cg67C76bxbVOiCmOxaUYCcKgWF/mW+srxWovBoMYDh1neOU2ILiNL4h7jM
 vDdhc3zAZgE2j8XO8zA==
X-Proofpoint-ORIG-GUID: qODZcQpHRD31277WlPZWjyCTvgwQQrVl
X-Authority-Analysis: v=2.4 cv=cJh1IVeN c=1 sm=1 tr=0 ts=6b09e306 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4NFimAn6xQd1D8YDhw0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX41G6QQvr7bEj
 IdjoycEInmy5Cml+QQNcqOeHdfJI+D2hs2M9IBpjgK8Z7rcXwfOyYVnTk5LCPEudAOdu2o0zI8R
 vMYJia6P4Ta/AEZhGxeGzorTCy8DWec=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270080
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 01:47:58AM +0100, Alexandru Andrieș wrote:
> dpu_encoder_update_topology() currently selects 2 DSC encoders whenever
> catalog->dsc_count >= 2, even when the panel only uses a single DSC
> slice (dsc->slice_count == 1).
> 
> A single slice cannot be split across two DSC encoders: merge mode
> halves the per-encoder input width below slice_width and, on DPU 7.0+,
> computes num_active_slice_per_enc = dsc->slice_count / 2 = 0 in
> dpu_hw_dsc_config_1_2(), dividing by zero in
> _dsc_calc_output_buf_max_addr().
> 
> Require dsc->slice_count >= 2 before selecting 2 DSC encoders on a
> single interface so single-slice panels use 1 DSC encoder.
> 
> Fixes: b6090ffb30f3 ("drm/msm/dpu: Fall back to a single DSC encoder (1:1:1) on small SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Andrieș <alex.andries.aa@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
