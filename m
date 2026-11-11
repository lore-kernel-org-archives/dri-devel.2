Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530A606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GdP9hRrD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kAmxxPPk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0CF10EA88;
	Wed, 11 Nov 2026 16:49:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF8810EA75
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:49:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF06eA1665625
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PWoksvMhgq8Q/i4IjWr81D37
 9zG5XlS6MeHSuWn+LKc=; b=GdP9hRrDhJwlt6pncn4yrH4QKsDam2bDCxdssInM
 dDYn6PIXVSZb2oZ6Ac39K/7CddAfDqk3qO04WLaL3f91HNoHCHKqL7UI1cNizWVl
 rSz3dPCQGRmIt/PlvtpiZ+yQj8VirA5dPtN5Cff3roh8aHkdlri/S7ySOtCqBcIP
 t6Dys2b2kdGEmxx7VtjaxUFsu423unNPtkpKs0dALtOUoJ2zKuTsfnB7WaIH7Vqu
 xNIuy8iYUJZgPSQOKgytYwfmo5LVWetPBdlv0c1ajhLRGuPBCGHfSTX1ogQDrNlV
 Z+mzEdHFNOSSZD2PkKNW/TsdFWtKeVGZP9eAu6gUrNYrHg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7pt99q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:49:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-946038e22f5so799529385a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794415774; x=1795020574;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PWoksvMhgq8Q/i4IjWr81D379zG5XlS6MeHSuWn+LKc=;
 b=kAmxxPPkgX/KA0O7khV260NRlASAWGIIlOjuiZxUFLwNuVb4Nb+hALS82wUUkbrqRg
 GC+0x5BSi7muupJEGk/NOXxt2bT6Jgjr8676orPgJYX2AiktsjST9Ens/FnbotS4uHxf
 JjgZe7jS5mfo8J4tEBd/3IsGDTCc1dUyBMTKG9cI4VRN5wfnU2z3HooxPaglog55oHCL
 VHRk4tZhisip55j8zr7Xrdg+3qg1q0nsMevl3trgJ2/zhrBKPuN2dxZ3X7Zu6taoz0FM
 SMI0+UU4Ki61uoEOjmep2CEAz95iEbrARWQTsH3oXa7Xz/1WNzwbvbR265d7unNV96Hx
 kB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415774; x=1795020574;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PWoksvMhgq8Q/i4IjWr81D379zG5XlS6MeHSuWn+LKc=;
 b=hdKJWW/FPh+b8wEdEAkvIRiFQ+s64aToRjlknO81Cb/CMowd4PH3V925n9R/wQw4Oz
 n3CDkgmgie0L4pTUlg9H+JP77ScZW+vy8ZH2AUptC7cGFDQ8f6gxBt4TqhOcIV60yrs6
 KdBYbhk1TML/zBj8Lf43K9hjC23jWDRvMmLYUzWkhWZE8RwEIWtkNL1koO0Nx43Iw5mG
 SZ1xgKmtcFv1sagF4i6P4DuZktiksEcU3YQxb1qnUmL1DgTWX2zQZY4kI2SQUiY+FD67
 UG428ZPl0+FQ5UqZrI8CQjpfU+w095NvunWq7aM0mWd4vRVJZRXCv2najeL7aDimiif/
 D+0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFMSN766LzWlfDHa0qZ2kqDKhOVwRbg2IUnMgFyxqECBgtMBHCwfb2LPQLWyH19lGKawtgjrMYjOFA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9wQP2UesTHzJeCC21FZHt9CzpaLTWLkppeoBamW/ymhkGMWebu
 t/AxwEhyaEHlYKaS+V3pAmDaljz0oGBBlt7VmcJyJ7OcM+Iplys5M0yNCB6lx18sFi8BCDcITWS
 ve8FYVwSlhwuaJfuzZkJUIv4DggA5TrA03XYiGvWaRw37GfTU4a24bVlVkLE6DF1Ro+2+Fvg=
X-Gm-Gg: AYBFou3frCQjyxUKfyaiTmS/rr0gRG4boqDMKOu0/xJequ1gprBX3EPVERW+9TA8jw/
 DuMp8oPXUTBMl5wmrwHO2NTVu4SCROmnKRLjH+KrynoF/ug/stMs6Hru+Q+yutE3Jz0gkCM76zu
 NiaV1XMdZSdVCIfTpBgjFthEWvtx/M+AWl89vm9jBuDq8LWPcdPPi/yKT4haHl4hClpt2oCA1Lj
 21DoT7R6PYAsoL4aQYtZd0pR9Zqr2gKNC8APcZWt/et9RNa85i9uTyT4U9AO1S8+vMTZlQtRJBG
 ttkPRypvlzX15croo5h9G+jxaE8StcRyJHPtd8EcSdXzYedRUVSLON6nkr0xpjmaAKTB5xS0db4
 SAZtHFHsomD+XiT8OCiVlVSN/2loUVzSK8bWUfHDO+bzW5iF0zw/TrW/BdIHediPlT9IntAqfPD
 AqW5lwCVvbLaHsfONWpW5/ds3euKccEHHuAoMqNlQmhban564nQnNgMG2+RW6mcQ==
X-Received: by 2002:a05:620a:4409:b0:93f:3391:d5a1 with SMTP id
 af79cd13be357-947b00cbd05mr507382985a.75.1794415773579; 
 Wed, 11 Nov 2026 08:49:33 -0800 (PST)
X-Received: by 2002:a05:620a:4409:b0:93f:3391:d5a1 with SMTP id
 af79cd13be357-947b00cbd05mr507377285a.75.1794415773092; 
 Wed, 11 Nov 2026 08:49:33 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157baf5aasm1038678e87.48.2026.11.11.08.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:49:30 -0800 (PST)
Date: Wed, 11 Nov 2026 18:49:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mahadevan.p@oss.qualcomm.com, rajeevny@qti.qualcomm.com
Subject: Re: [PATCH] drm/msm/dsi: fix AHB clock staying enabled across suspend
Message-ID: <kncxteaifi4atoodx2wqkbxkwwaw2wttmxtxeh5plbl77idwva@fbknoze4ywbd>
References: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NiBTYWx0ZWRfX64Bj3ovmPZfT
 Ft1Rl0HezKAQyyHZuqXHhVtRJI1eWOoByIPETtHlyf05nT/H3PovlqOqoo3AIf/5JiDIB/iUH4t
 u9hctteBWUQfKbpdeugKHUP9mwyHosY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NiBTYWx0ZWRfX/6rm0AeEndke
 PBFWBaMhyUB9HoKL2Oy89HigyAdy9Sng3TGNyFcf4FGsuTtg11ONH8dXLtBKpWeAYLWmLFF/+9N
 w7fUVGeYkSDZwwVJ/i7NxXaYdHODPBZ9hi4eoTId8FN9PNn8EDQRkl5YGTuhrPuFjRO9VYIvJAD
 oKyHPy7PGNsTHz/NGVI3I5OuszTzQd01ciBByGbTqD3USKDXslB5MUgpFhs0r0f8eDBXzSESwKr
 btEs68O9Orb+e0CvUOPW9IuuXi6F4/VDMouhhic7EdYQJ5qzsbefOHQmJVshNFvbOyPnWdoSTcN
 4utROh11YdJWl1SflUpMg32Ucl7VqxKTGYMT4ECH82XuPQPl+WB5VG2QTQh5mZgI4hgh4P2Rlti
 i2nHiAAddnsDDJrzFFrONQ1gkTZz5iLzE0AwcT6mVjHSzqbbtEb2vBFUlqyRnxlRQ0spzn7otbS
 QcJ5J9gsTHrKyDMOGxw==
X-Proofpoint-GUID: jz_aWn3KONQpozc2h--9gYcYpf-ZVtBx
X-Proofpoint-ORIG-GUID: jz_aWn3KONQpozc2h--9gYcYpf-ZVtBx
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af49c9e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=nLvmRgGJZeXqCf0b28oA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110066
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

On Tue, Oct 06, 2026 at 06:43:53PM +0530, Arpit Saini wrote:
> pm_clk_suspend()/resume() only call clk_disable()/clk_enable() for the
> AHB ("iface") clock, never clk_unprepare(), so prepare_count never
> reaches 0. The clock (and its source) stays reported as enabled
> through s2idle suspend even though the display stack is fully
> suspended:
> 
>   disp_cc_mdss_ahb_clk [19200000] ->
>     disp_cc_mdss_ahb_clk_src [19200000] ->
>     bi_tcxo [19200000] -> xo-board [76800000]
>   disp_cc_mdss_ahb_clk_src [19200000] ->
>     bi_tcxo [19200000] -> xo-board [76800000]
> 
> Calling clk_prepare_enable()/clk_disable_unprepare() directly from the
> PHY's runtime_suspend/runtime_resume is not safe either, since it can
> deadlock against the PHY's own PLL clocks taking the global CCF
> prepare_lock during clk_prepare()/clk_unprepare().
> 
> Fix this by moving clk_prepare()/clk_unprepare() out of the runtime PM
> path. clk_enable()/clk_disable() (spinlock only) stay in
> runtime_suspend/runtime_resume. clk_prepare()/clk_unprepare() move to
> suspend_late/resume_early, avoiding the prepare_lock collision and
> actually dropping prepare_count to 0. DPM_FLAG_NO_DIRECT_COMPLETE
> ensures these hooks always run on sleep.
> 
> Fixes: 0b3ccb76b95b ("drm/msm/dsi: Fix 14nm DSI PHY PLL Lock issue")
> Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 132 +++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h |   4 ++
>  2 files changed, 127 insertions(+), 9 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
