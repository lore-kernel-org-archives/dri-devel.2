Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D424BCD342C
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A2910E403;
	Tue,  5 May 2026 00:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UMZDiz0I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NLqe/1Uv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE4010E403
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:35:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644J16NP636014
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NpX6cchQLSsH6LH2boJjUcfU
 CfkpNdpGQlSuk6n0mLw=; b=UMZDiz0I7lVUfm/VJb7KhVcl4ksimUeZ2YvWZemi
 gvyC9lm8YCaf93HJKZcXMKiH3bVfs2cC8kfLbOlgn12p0YG7rN5gbBkXSdkmHNsR
 k3BajHitAQWal8EG095jqVV4TQb9Uh0x7z35nkIxmk3ETMZqMYN9/Usl6HFCPqFu
 Dc4vQvTIYV3ERffkVHo3FZlik1dDnFmQ4g0O0vPkd1ZNm8nA3c2+4tS5Wunu89e1
 I9pFoVRPjsEm/6Ap4FSE8hYF1In9YYdhOwRnPwe5qpc5EC7mJI+RP1WgnUjzJ56q
 tb3EKQ8VElC15C6UTyOCY+g6FB8XTrmSyXZtLodOBmlxuQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsx4aq13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:35:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8ed08aa4so163712491cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777941351; x=1778546151;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NpX6cchQLSsH6LH2boJjUcfUCfkpNdpGQlSuk6n0mLw=;
 b=NLqe/1UvwCvJG57z26zqiPGAzPLDEVLk0R3EalQxUWxdVY1KZujqZEA54pgz+Ya2Z8
 ctEbkqx9c//NsFIldhPt9AJ/EyzSTxDDRWv6zqIkjtW8c2bisWJeYncW3xyBeZ0MAaKO
 HLuZJIxS/gnBHUQ3qPu7J2Z4+25iQYUmJhhSuRA7tQWJzhHjIF827bdGugq83084wWRs
 rfMxXw9dD9/kY9GBmrLK4J1v5Z2t3ZzmvsWiSQGxFweWltpXujCYAca5iuU3zZ3Rg3lC
 bGvvC5RN4YUQ9blDqME0tzOfXqT+gB5CJJQiMKwwjX1BO3VrZkjMUvAvbtaLljYro0iw
 Gg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777941351; x=1778546151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpX6cchQLSsH6LH2boJjUcfUCfkpNdpGQlSuk6n0mLw=;
 b=ReJs0r/+kv4PrsDYiMKCispCfnnhcKSdNywpiPM14TmOv7A9tGckn2mgHYDjNRbyc/
 kfII2bVecl9sjTfPc6+P7rv6rrgWHMkrlH0i6PHgqXBgFaweArLMAcDqBY+NQ1Lnb1+q
 oVnysAw0ZpCSWR1+eUaiH7ebtsoQUUQGyAGmjc6slLy4tMvJaX+StYPiwXKJItRWkmlb
 LkkQR5cka1jxD+b/kLJQs45xwNx0HfkIXlv+5PydV7SWgEGRaiC8Jpf6wx64W+I/KoKw
 96y1dyfkOa3XQ/UtXXYSYxQcwTHHqGpZLeZqOSbC5wGybcyPhmPtpJGZiioDIJ+evuqH
 uwtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OWz05iWB2H2Fnenm9zS4xtc2nGT+spEOv9xJRpTjwPjTJouEe18bQUYsX8Ikpiofe6NQNRdmqKjk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMWTAWWWubPcgavOCQEBOR0gJ7GsAzUQYEdFNjGDqFP1sehOxK
 NuC7Rt8epkAdwlYYjhW/e3WOBq8RHoJUgvxuwN9kPsaSgse0HCSCcd8zI07+eVwSizazf2OEs+Y
 eKrBAeMWMOjR9wu3aLeqjZyofHG9Di+EaEHbYapLDa9H0T7j/aw7PNd0FuHWMn2i3VVo0gnY=
X-Gm-Gg: AeBDietDGGY48/RswOhk1XCR4/1Zx+h9hx/5PDjXPh/henh6sek6V/6Nh1vaPWodO+u
 QVdKYLltM6NaLrsAhfYp8DpWRy+VJuDy/aTyme2om0xsSPpWyfTRNSW/8cHunpW4w1lJCsVUyGR
 4LXf8LP5X0KJMRijbFMPRE5s0DkyiUIgiZq5M9QJHZxSweL8wX/D29WEwMX3rlBX9EFEgysAlv1
 RY5E+avPec/T1u4e6Z6Yse9DmEj7Xa77AnQtuJgnY+J/7O8OPyzabVny/IVo1meEsuzITwWg2PY
 dTN+yazno9QUei9iTBQFSfJEx/gg0VT2+66C7hW4vCtTn7DF1zpOe9SPh6+feOfnHhsmRGeirO8
 UTRONcnv3kiuT1NX0ThFvz6XH4LzTfb406/tBqxUe4hRkOXyncy+mrEqzslGIWqmsyCn51x9wpO
 AoFEp70coFRK47qTXPnzmbIGXm7ti5PfZVuMpWwIv8aNP+fg==
X-Received: by 2002:a05:622a:4d8a:b0:509:238f:ad8f with SMTP id
 d75a77b69052e-5130698bfc5mr17753561cf.5.1777941351516; 
 Mon, 04 May 2026 17:35:51 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8a:b0:509:238f:ad8f with SMTP id
 d75a77b69052e-5130698bfc5mr17753151cf.5.1777941351115; 
 Mon, 04 May 2026 17:35:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c3418b8sm3432152e87.64.2026.05.04.17.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:35:48 -0700 (PDT)
Date: Tue, 5 May 2026 03:35:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
 uma.shankar@intel.com, arun.r.murthy@intel.com, jani.nikula@intel.com,
 harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robin.clark@oss.qualcomm.com,
 abhinav.kumar@linux.dev, tzimmermann@suse.de, sean@poorly.ru,
 marijn.suijten@somainline.org, laurent.pinchart+renesas@ideasonboard.com,
 dave.stevenson@raspberrypi.com, tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH v3 7/7] drm/connector: Modify cleanup_writeback_job helper
Message-ID: <nfxifrthux5hej4foawtavpiaegtnorai5j5l5hljmrvxwi34s@nryizbirf3lv>
References: <20260316083008.87466-1-suraj.kandpal@intel.com>
 <20260316083008.87466-8-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316083008.87466-8-suraj.kandpal@intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX4Y0XQbCQMUdk
 4b0/gQc4e2fa6x3CI/G9rOl05kxdxvZHP5VTd2U4w1I8fcRA6j4JbBQaB9y54qQErcXNcfzfBgN
 D8+5hac/pKuzMLUeC2tolpLk+gA0rU/fZILMc36BmctHK5Oku7TIs9oCpq+lgqzwFeb1FGTkOgd
 hSCeSZdgY7QmrdvxD37Xd/r6Rwabjt0rI94i6pukJOTMtSfHoD9IHC1mk1/k9kU1kaHryB1yabQ
 rjS3w5VXMi125ee7ScfNvwuWpz7u0YoreFmNU1xaABE+Q8YtznkThP4HYiUesbdQac8vXFug+YB
 +WVr5Io7++D4EPd1myGVKg0XQGNkzHjBfa0jlgDXrBFTB+h6mLm0O4dzrIUZs1Ob8yXaN3Ip15W
 2q2WfBltp8hYN/0j6q2Xa02JgbZXZJGKuoGB1kvLDP6Uv9+vmUIhASBsIY7G76qnZDsUxhUZR0i
 PaqovnW7ADobH2GIYQg==
X-Proofpoint-ORIG-GUID: NJUB0UzA78es6MVN2BsRO9H4eYmIWLke
X-Proofpoint-GUID: NJUB0UzA78es6MVN2BsRO9H4eYmIWLke
X-Authority-Analysis: v=2.4 cv=LdIMLDfi c=1 sm=1 tr=0 ts=69f93b68 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=tQ94oCB4lqOImTN_oEMA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050002
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

On Mon, Mar 16, 2026 at 02:00:09PM +0530, Suraj Kandpal wrote:
> Pass drm_connector to prepare_writeback_job since

Typo: ... to cleanup_writeback_job callback ...

> drm_writeback_connector now resides within drm_connector.
> It also makes it uniform with params passed to other
> drm_connector_helper_funcs.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 4 ++--
>  drivers/gpu/drm/drm_writeback.c                      | 2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c        | 4 +---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c  | 6 ++----
>  drivers/gpu/drm/vkms/vkms_writeback.c                | 5 +----
>  include/drm/drm_modeset_helper_vtables.h             | 2 +-
>  6 files changed, 8 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
