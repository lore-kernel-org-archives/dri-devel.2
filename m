Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AE8107BCE2
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 20:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8407D10E449;
	Fri, 13 Mar 2026 20:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Avivec3X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBL/b8ff";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6258D10E455
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 20:19:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DESYmf2262547
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 20:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bkYfD0VrJmDBLlotaNSnR19H
 2w75Eb+WcV9FiDvXvzM=; b=Avivec3XnPpieUxPoQesI3b7X9b4LCpMXXhzRlM1
 NIBQRkLWMLKx6zsnwPFPtSnUwwtlBbqpxxpiu0AHY7oqr4OpYojYCBJUC4xkqBDt
 DfKTPudAYJvG78R5hwfCho0b+IjYH9iZfVkO/pgf6eFEWGyw/kFN+/+Bx7r4SULd
 tfPnLVjWDnPMmrQf9OvHeIrB0oYidgaZzKKyCpJupmAa1ywd2f5EQC22U/YAjIsc
 5RFkJ6+raXSf2DNco3OVtTv9q9zsS3MuItjDMgKCZs0ndzILgKDm/5e2mr+ySkm0
 aHy0dQfaMi2fPTOcnZh38r8R0Aaey3uGvCNGK7SkijDiBA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvef4tk4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 20:19:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7d4cc049so2589484185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773433140; x=1774037940;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bkYfD0VrJmDBLlotaNSnR19H2w75Eb+WcV9FiDvXvzM=;
 b=QBL/b8ffRHC/1KI5JkCHyW3YkrlwJYzUnEaGI6ptvYdZf3NDLLLw0U+QHlMjw+hrNG
 fB86meOgJcR2rTwA0uepWYndwQzyoMXLtbDbe4duGPz8FIxQjBTquXIiiVSGkQgZTuJd
 U8ZjoDTgybBcYGJk/EaxnnUFkJ5MXxCT72Vtz8boxDEEpdY28r1LGZmhOhnL6xrwwV75
 507PX8CK2y1wRdIy2cYD1+Ieyr4PID6kwqo6ji8IwM5zvfHgGj+JruSBrtdQGRU5neX6
 //olQDOSBWiVMTikFTHOUKw/g9Xm+MJPTJt8Eq4GutBXVc1u14u4WNipM03Am2fbyUap
 XFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773433140; x=1774037940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkYfD0VrJmDBLlotaNSnR19H2w75Eb+WcV9FiDvXvzM=;
 b=gosTo6dInsdbYKu6fvpNmOr40X4Ec//0soHiHt/TYlXVT3zQXNxCA5+zCG0G8B9rFJ
 GR593G6vv5vewnNjjKXeZZOcXWlUWPie6wx4AtGnj1+QXm4AMemgDZzN2tnLu2wf/eG9
 ikzcG6Nb6oaJuENiDFyJbkcJjos3ams3x2Fwkr+4i2CmHz6esENwAlgW9GsiHhgodC+T
 iFlr3MtqD1s0GJT7oHXqot3OqclnFydTVThvQtChV3caowcUPxYbIlt7AhvIn3EsMdlP
 12x4LsRMayEK2E5K2e3R8KBquvZMAQAfFNf2SnOnIlHIWFp4mepIErVlBvnf7pmnak5/
 Y6wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Yz+N1KwbiV3eSGxVKP+wH08rj6o+JjYXSe0NP540eY425hr74L8PT0YazK3e5jXM551q+0ufL6g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5uZdgUvswoia21hjtDCKvFlUQlNM7bjRPe4YuRxvL0kWIVn4G
 5VfDg1DeDP7JkXpRLDITI0mlRUCBxHPLlSSLviPt8ivSFlVvJfOvpvU70/zY3av2pawNTdJdlKf
 x3+SVTTdoNrL+NrLGrRtO433Or3qOQbJvxqn2/7DWhRNesP35D0Rq+604KFnzhflZjLwIwg4=
X-Gm-Gg: ATEYQzwTIrAviMKrNyPvy3gL2DlhwJu19X/POc57LgLHO1vzFdn4mO/mKYUvZmsExxA
 uUnT7MW1ida+qEG12Oi++hzmDexgUmrIoytilf8Szkg225AjkAu/UG7doypcdi7YTkRdUGokxYG
 /CxD+zbQwTKzeIWQGgMxoNGEvNy3kLgJ6+885X+6C/+dd5gNoVsHYczfWbzq0HWfwaFJsS+4FMr
 nSaDQ3PHw7/nRV/RQpUvD2YWeXvLG1S/1ovP8SnURtrMQn5OXmfeSLzoaRtnhVUGCQj9kl1qxAj
 a+hLa7ZnVhnjVUJ5o0eGEYvH9zEXKTebPYObWsAAuy3IdqVcxsU1penC8se3uJ+eX8TdIQoYqb+
 qOe49ohWn6Z9Yx06ZSQfK2eIEl9tPdLGnHWR5E/7rkMeyTtOWMpBnUCSvXE5BPrJl2rs5bH6xDV
 HWoUolZ/dNOA8qFx8pw2WbR5COrIB1dH4CJOY=
X-Received: by 2002:a05:620a:1a03:b0:8cd:8889:227 with SMTP id
 af79cd13be357-8cdb5bdf07cmr661545685a.73.1773433139803; 
 Fri, 13 Mar 2026 13:18:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1a03:b0:8cd:8889:227 with SMTP id
 af79cd13be357-8cdb5bdf07cmr661541185a.73.1773433139184; 
 Fri, 13 Mar 2026 13:18:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15603407csm1735734e87.38.2026.03.13.13.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:18:58 -0700 (PDT)
Date: Fri, 13 Mar 2026 22:18:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 2/4] drm/msm/dpu: Defer SSPP allocation until CRTC
 check
Message-ID: <aim7ktys4pv2pyankykfrm4o7lyh6suqzvahoqsi2u5hrn77pv@zk7zyg6w4hlm>
References: <20260312-msm-next-quad-pipe-split-v19-0-4ffa2b06c996@linaro.org>
 <20260312-msm-next-quad-pipe-split-v19-2-4ffa2b06c996@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-msm-next-quad-pipe-split-v19-2-4ffa2b06c996@linaro.org>
X-Proofpoint-ORIG-GUID: 4jggOjzg0R2nK8oBFmchuQwWB1ud_hfa
X-Proofpoint-GUID: 4jggOjzg0R2nK8oBFmchuQwWB1ud_hfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE2MSBTYWx0ZWRfX56FVniyTXfWu
 +TUVKcChSkLC+64/iTcpomj1v1QvRHT3PPToWD2HcjpLjWvayp/LaGRsiQ18gSZeA1dNzGy/L1n
 6eL931n4i5fpcNm5r5zZexPAipCSeo3SFEkYMcGF7QfBwBu/IfgWY89LYCM3lDX/xL4HIbpemHJ
 K4+mwj0GOOvmjX7iYIIfLN5CFsjv6NstvI/2FX0fMmILtoenndI6xZGGeWb09d8+yevr1yQtzR7
 FgztLIQVv1TsbEdkseV/Iv//kT8jOh3nnlU4sYz1RNS3eRc4taDuUNTEVh/xkHlB4WvCHogNzt/
 SxDCzdDFaKWb6Iyq3BHaZG1iuhhCQPCW3kkDhlO0eh8xiPHUjNRQ/DU+Mwfx2nI4ee10sHFHrPz
 BjDOlQzrfgIbjTgfOuOjYxHA8R+lA5DEJ+hB3IOfX3LLD8Yo6PSbUCTBqjnzxSeLWCHI8sqPyNb
 Z7gxpZq0hGzKkqKWaGA==
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b47134 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=TsSR7jEQqzbN-jIPavUA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130161
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

On Thu, Mar 12, 2026 at 04:28:11PM +0800, Jun Nie wrote:
> Currently, mapping plane to SSPP occurs during the plane check phase for
> non-virtual plane case. The SSPP allocation and plane mapping occurs during
> CRTC check phase for virtual plane case. Defer these SSPP operations until
> CRTC check stage to unify the 2 cases, and ease later revisement for
> quad-pipe change.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  25 ++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 136 ++++++++++++++----------------
>  2 files changed, 80 insertions(+), 81 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
