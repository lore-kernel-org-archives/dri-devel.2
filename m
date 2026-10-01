Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7551CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F73510E314;
	Thu,  1 Oct 2026 10:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GlEvhpvb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gHaT/QwC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00EB10E14A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:13:05 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xmGJ1661068
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bWmNAyB9T4vvPsM8pT9vVAZU
 F0SnZIMbHucMu/isPPM=; b=GlEvhpvbD9d6wnf4sJxOj+NvdvoGuEvrwsy6HTjQ
 yKdJRuJoO2eS4JeFVxNJCHtIn5igd54m98UfTe+9uu4K4fKDI+fDT8CcCn+Pau+C
 1ANtMa7YGZaEcgFBnG6gy1CVUmFnCbPMRnSMZwUllj1bT5/Un70FNzxSqSbOSasN
 UO6hAEzMmzQIJCb7JOLxCpfCIhNgjW5lUMFyaaTNKZRlRECvzdkOPWB9BudF+Vz/
 5jIXz0jbxyLExl7uYsg82SwBvCbLbkmOV4Y4S4rJ9QrjEnnoltoblTNKnJ7cFz1J
 I+IVu+l67g1/+sHgThxoCPnkgYb0xPZXwv28TpIto4jnKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pku9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:13:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbf2fd504so48531285a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790849584; x=1791454384;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bWmNAyB9T4vvPsM8pT9vVAZUF0SnZIMbHucMu/isPPM=;
 b=gHaT/QwCewvJ+P1i00UExqPq1iNQsNgrNPHN85/R6UApeigrRitj7/O5jyX7fO3iCK
 7DEQXNqZuUGyfTk3PrmIoUhd7Tjn1k+4ucgUXZovKmD1GvDKcPTcLpP5wAdK0M3wNa6U
 alluwTZNZrB/tpnoCEB/EsLPvqOYwB6pGuJNabFUR+jUslTFd9MkpVwYeK+062uXDuIm
 r5VDpRhkltK+O7U8OaIpoCxjnBx6hvL4osGGPUy4Hy14you760uVDwVN5CaOX21kpxy8
 H3tT0H3oUCPSHeYiCcoPrPHOZsXwInmslz5/4lWqBhK5klR6F49uxEAlyCa8NVE3pnj3
 ExJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790849584; x=1791454384;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bWmNAyB9T4vvPsM8pT9vVAZUF0SnZIMbHucMu/isPPM=;
 b=y6TeZcKP8Pde4r21/HQHKvWcd13BPVUKA7kXxEaSaD3FWJqwgL6C/2ZhW08Pwz8C3r
 YyDbNhDqhS8dSXQ1Vx/PLRMETCC8VT4eDnvTmp5lzP/1+Z0/c6GVO89dTheXFjGgRPD/
 YOmdrVSRszYCMNJzlV5rrwD0J/2l/METlkah46t4L/8tIZbyIW8WZRYH/6u+tmvs7vkG
 tSMjsC6jszDLHMXzY8NESL0h5dnVdgikXvPoCHI5sVW8AGScH2AEd8Qzdeq+JrWzbRiv
 PVLKCkswtyaWITBmp3n3Dqqzqhp613EcIcUH6nskwEUh1HfUhx71mz+R6+AG8i0vaRyB
 S39w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxK6nkDAAUvts2UWh8t6L3fwW1WxczkejjcugZ9FbGDp2xvUqqH8WXApZ5eq4ijXxRYLLPa2x1UWDs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kijfyF5qQgwb3iDK0cj3ytH/kMBRQc/66L0vQtaDRJk+QkE3mf
 wYKyCkCOU0Fyz8ajhOXt/VljUN50NctV841DRC5acGja2IgkiEQh5P/Etj71ctMdDBV59p0w3He
 fadOltDgdBgyv3zSJ4/hP7fMF4kZ1XqbntHOksLpU49IEratC6PW5xee7/NZaZksfufs1d9E=
X-Gm-Gg: AYBFou3BPMwy7IuMaIwgN+jCWMWG8l0P6Rf01CF6lup6ACAfv5KRVwEsDdaOOKooNDF
 j6Q8wD943hlhk6clk3RBh6QNyTh6jwG4ps3VutnnnwXJGfsxv5wf1RIeLViYjDsUTEz0DKhYqMt
 RBeZOtkpDMAlOKeinIpJtieidL+Orw3UbDtQeODJu03/KLZu+FEs5YC8HDU9ucJkN/FZKmi6ZXu
 RO7vX9mNQ2S6fxkNSmQBenTwdZgvskCC2/DaZHLCTJcNTFnEh808UFfNDYA26AcBOyKYAq34AhM
 rm3kWaa3npOO7sQt5PTOi3jT+uFTWZFmS4XGm1wrQTk85ya88Ws3l5RSO59d+Gg8UUW5YB9XbyW
 6FIOG3OeYpqhfnDJ7/DuOnfcgTNUt+uzjWwn2+Boh8l+3XKS4a6uMEJKwnbXboM5nnF6LP2Ba5V
 iqGwIlmn4E0BUA
X-Received: by 2002:a05:620a:400a:b0:93c:c162:125b with SMTP id
 af79cd13be357-93cc16213c8mr80110885a.39.1790849583962; 
 Thu, 01 Oct 2026 03:13:03 -0700 (PDT)
X-Received: by 2002:a05:620a:400a:b0:93c:c162:125b with SMTP id
 af79cd13be357-93cc16213c8mr80106085a.39.1790849583434; 
 Thu, 01 Oct 2026 03:13:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a8793a25b1sm895251fa.25.2026.10.01.03.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:13:01 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:13:00 +0300
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
Subject: Re: [PATCH v7 02/35] drm/msm/dp: Pass panel to
 msm_dp_ctrl_config_msa()
Message-ID: <fczwdw4dwd6tkzaznbvnt3yw52ldeuacvye5v76rom64xhh5hj@pg6civv5gtvk>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-2-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-2-4b81473185e7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: WHDEP4LEvdQxEa7cBWAlU2up97uFqFfi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXw2VCsCcuyv+F
 xs5xnLWjOaDlGguxKdQafZJHbN5h3wGmifk5aXdhhFVSwChSFkXincjVOWxMNFGJiaOiFyLfsjh
 RgrRrAA6H6h1B/QBGrcE/rzhWWOZpro=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX5JTCouLU20iA
 JXnmC01VIX4iDNJ7TSYFBpMtNLNgbfkVLXG5nb8je2Kdyk715+Q5JlnQ+H0+CKISRj8LNYQXFgL
 SdMBCniMSQayZGyt5UnAMvrJYjo9M9BkamNahtaM8jzYDe6kb+8KIH7bDENb5AoYwcCMd/6ajEC
 Rd5Y9BukwccJoRz3YLyqUQl6UR9bMYltdBFIt7GgHxb/sBILVY6zm9q11jo+/Fv5v9mj9IYG1O+
 2Xpy9swJzLwbeXzMXmymie6o7jJaGM40ktOJbUc4wNLgWGOrQWmZoRgzNdyL5UJFMvfTrEfo5jL
 aoFOqTUI6VSPLzmcc86n0bXT0K7RfsrCg2PpQIPOAhbwj+qh/Q9fM9eSVX+XK6N/+VbCIxuk76v
 lx4hbtiyTtPy1hDfegEshY0sTrPvS/lOi6xNN4ockHHBx8RGczfclfwyfqzB6vG7zO2+o/uxkNb
 72WwA/tgJHq4QFj+JxA==
X-Proofpoint-GUID: WHDEP4LEvdQxEa7cBWAlU2up97uFqFfi
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe3230 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=tDZS55ivhwD-za0uAH0A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040
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

On Tue, Sep 29, 2026 at 12:25:26PM +0800, Yongxing Mou wrote:
> MST requires the stream ID to select the SOFTWARE_MVID/NVID registers,
> but msm_dp_ctrl_config_msa() currently has no access to it.
> 
> Pass panel to the function and derive the pixel clock and pixel format
> from panel->msm_dp_mode, preparing for MST register programming.
> 
> No functional change.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
