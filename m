Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11300606A323
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cfscsYbp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d0FMDomb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AF310E1CF;
	Sat, 31 Oct 2026 21:44:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540B110E049
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:44:42 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VJF2Ri1890040
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=G3WyDIFGwvzASNJI/Vjyj4Qh
 fCstvrtuJBWM5WfABQc=; b=cfscsYbpsec9HVAUghcqDLk1GkfjoPRWcgsNbSdA
 B9hcnyI2MIKFlurfd9j0Xr4QDHssmu20XO0LiLSYWGpC7sHjGDiw1Yk8WvcQBysK
 6/EnIvKoZg3hLhhqCv8NRfdRVD2yGWHN4K+qLjENYbNY/gYmJi1kAysZ/KJzQsg4
 4D8DZ61LSUc1PDv+psXFJdfvsxplaIb7b7M9/6oUvl34It1OyXIq9rFukGiOzU0y
 EBkEhSsYmY3Z6ZxYkorIL7WMyqdNqj6Pw/PAKvt3xkL+RdgR15PDMAurujmFBskx
 qVd9Zp3OlmW1h5DQwz+aeaJOPItSCpvAcGK902Cw3k9OPg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7t2km-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:44:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-944138ed63fso299600785a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793483080; x=1794087880;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G3WyDIFGwvzASNJI/Vjyj4QhfCstvrtuJBWM5WfABQc=;
 b=d0FMDomb4yGy3pBwnmnfjDmp4HTa0bLfin5cQ4prkjmXv75hEkA4TESIk5q0lTvH9e
 Fat2TzX49neDMIiRRbbVYpptROWZtQEMJT8bITQXhFwrvwEUeEm7lyuXoSUDQ/+fW9dZ
 1Jt7X8Tx2x/U5ksLVmE0jmFhEz3N2XhWUISUT8k9qpLUgOJvvuD6Cy94n6MkZy3k6p4f
 gAHmLzO5vzP0qc5CvjepPhuKhGVnRwuYf8Pf1X/OwU+E/RZz0vUI2bHh2ZStEtYBSQtN
 2V/JjvkikqFVZ9XFMkhINpn6aIvPmQan4H0h8GrD61GhEHhukbMpdRy0LilTmJKUlYTZ
 VEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793483080; x=1794087880;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G3WyDIFGwvzASNJI/Vjyj4QhfCstvrtuJBWM5WfABQc=;
 b=2JjaRqeEzZDaI5EYh7ocLcvdny/DA/y+jPHMkSwNtMJy1WyrPCou5+rhFyFns/nwMx
 otPKArD4XHNMuaWB+MEomqlQ7sTGK8dQu1VlRlgYHo6jwBTjiFncz/6902wBfcAKWuTQ
 s5b0l0cxqnIpDgpDoO8+1y9JvSSEZUT9KGvudt743z/8Z//viZ5EMTUzfRqAT+6clCwu
 cA7qklI5ZLoAbPDWx6Ky/+fUq50s3/lmGjiCJaZ05wPtsIKR8/UpM1vX8VkVhJRbmRBC
 DbAYyCtxMPU6SRCCXFv85r8irFNjGvxyDgpcF1BzG5bZghEeMDPtVpsvJA5Y4Unc6f9V
 MzxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvJT3HTRG78Mb61XRE78/zF3kPV0d5mQWJmiRg/JHNYxytzWRKmBPT8SeXbMTE+yVOirifaUJ/t9k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbeIFVMLqsqcbI4Uc1Rs8DgEmAE2j/t5S3YXnAeIxd4gWapsyd
 TXCq3pce2o4+phTpHLzhNJJtilis6LApCp/jxt1Wt3221Ml2WltemUIKhN6ThoRK83GCyn9Ct+G
 t9XRk9lb1EyNpy1hrtodl3/Fs/EE02otxIXXM0FxWLAS6mLTRmjuSXVffYHlSlqm5RjYKPRE=
X-Gm-Gg: AYBFou0QG4easPFAAXyYzvVmPHHQP4KAQgWCAwFRrOfa0fHahL8MMQvq5vQpEkOBmUI
 kz8My13+sDkG+147kelgHOIlPQGpGYk/S7UVOFRbfQEPJUr+BkQoUWobMgBc7WxXWGSSM+pt2ZT
 1yL3fbq85ObLyVfmnBkZ4DX30Qyk3IrH1AKYRhaoQJGT2YK2zmyk/coTTmZXtg7m3q5Tqjt9DvE
 G3TKyNYTjmJdt/k3WMK7QMKmmclu+q32IJgma6Dl3WrT6fbLBZFS6SsWcoucJdLEhe9aVW7eASR
 dh++fHjEawB4D31Klu5CGwdkWrg7wyfmL3MLlLP1OwWydWryXYyE3hl1CIVe9UbapfpG2cvCx91
 ZgbFBVS3/cbpYLftJf5ShIrMeJJh531CXKFkvUBiKqTUpFDVFAYlgOMiB4Ld5zsOT7pM96Bwpjj
 7cjdzHffXKHVeGiE7hY7YsFGnlnMXzWDiTNtVLsrEsx8L7gZSUyRN2CEaUKxBBLg==
X-Received: by 2002:a05:620a:4720:b0:93c:2c15:e510 with SMTP id
 af79cd13be357-9442174eff2mr1120357585a.37.1793483080518; 
 Sat, 31 Oct 2026 14:44:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4720:b0:93c:2c15:e510 with SMTP id
 af79cd13be357-9442174eff2mr1120355585a.37.1793483080047; 
 Sat, 31 Oct 2026 14:44:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe074666csm760682e87.67.2026.10.31.14.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 14:44:38 -0700 (PDT)
Date: Sat, 31 Oct 2026 23:44:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ishu Brar <patches@brar.si>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/msm/dpu: Add SM7250 support
Message-ID: <zmzl7btnsgzb7ywrescyvtuksu6edrch6i6i5euhy2ven7qmzx@xhgfspbq4q5t>
References: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
 <20261031-dpu-sm7250-v1-4-159f403ec405@brar.si>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031-dpu-sm7250-v1-4-159f403ec405@brar.si>
X-Proofpoint-ORIG-GUID: _rWAtQQq7NcHbGGFuZc1N_URrYwVIQ5K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfX5iLyXUEa9Vao
 MXCHiVFDf1AlIAtnSFSp9wLbUWuDDjiQ5WdEr35S1xFw7fnOZ1pYoSrJ9DgUVBI8bVGCMBMddBu
 lbsc3aK992cDRRZBWRaa0z+wvLzmnks=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfX8xE5w9EekoUp
 SKTzlZnrAeQz/X4lTEhzoQU8XHRsfieHTqb5dUtQKu2A0K3yaivQ5Ta1l3vAjmfX0xz+HfwayYe
 PHF/fNnEm0mLJEeljYttCohE5yDLg4eZcN1LROjCyyq9GbkGGxTWkemlgJhKWJ5XcxgGgbdMADr
 AYlLGsswnhXOD2CqrvJ0b2LDrJ2tGdrDIv7Dm1C1Z9i9u0C4hWvxKhYHGM9FBjwuEzFutCCyd9L
 kVpWJJpkkjklIHaK8s4u6aG9sq5EnMVIUrJda7vnVQHUDGCmuEkdv209KpbYkd27Y/KVrlI9RFZ
 zhHNHNZPlt6VjLP2Qb3WMSZrfCMTStY8/sOu727dqlydz7XWsbXj1oe3GbDbTETiXc/Vgr0YOAk
 Qulff03jx/CAFNy1Dx1Ik3RCgjzsP14KUcoJ986JXM2gdX5kLepAExjscaL+WS41FASmIZQxp0y
 9kj9NDKtKzoSst6Jlog==
X-Proofpoint-GUID: _rWAtQQq7NcHbGGFuZc1N_URrYwVIQ5K
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae66149 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=Jal6vLO4qNuLzgKlUnIA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310086
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

On Sat, Oct 31, 2026 at 01:23:40PM +0530, Ishu Brar wrote:
> Add definitions for the display hardware (DPU 6.1) used on the Qualcomm
> SM7250 platform. The values come from the downstream lito devicetree.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_1_sm7250.h | 311 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  4 files changed, 314 insertions(+)
> 
> +
> +static const struct dpu_sspp_cfg sm7250_sspp[] = {
> +	{
> +		.name = "sspp_0", .id = SSPP_VIG0,
> +		.base = 0x4000, .len = 0x1f8,
> +		.features = VIG_SDM845_MASK_SDMA,
> +		.sblk = &dpu_vig_sblk_qseed3_2_4,

qseed3_3_0

> +		.xin_id = 0,
> +		.type = SSPP_TYPE_VIG,
> +		.clk_ctrl = DPU_CLK_CTRL_VIG0,
> +	}, {

-- 
With best wishes
Dmitry
