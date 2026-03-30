Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189A21061B1B
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792B010E306;
	Mon, 30 Mar 2026 18:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NmNCrzsc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UdrZEbDc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2906F10E306
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:30:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UG4AYL3668609
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/JUDR6QZr7b2hhsNxsLxzkUb
 bwsQX8cwdP4kkkbqovc=; b=NmNCrzscWTRinJNrXeTWmKI16c1PJQDxAwIy9bjp
 nlgYn/4XQFKc+kyydR4k0VJQltd9F4Atrp4EH6jBCImB92+7fufyPnVOo+pFuwVG
 8ytNFeuz1I/+lCrYR/0Fz5ztiI9Nvg/1XbSW0fgowIPREPAjlZs/5W3nTkcFCtlm
 oJaqRj5PKPuza0azVxfUbAIeHcnJnrpLbiWjdAvofVe/SScFhJXptlpYjHZezhxg
 UxfSbzyTjqYAu6CxT4jOcrBMxR2ItdpQE5X5rGPgspQcZXrcx8zBaYbICcjr4aJb
 7SHnsBAItH8CmCbBjDLgPg+G3UWV6uml0Wo9a2T7AgmVtg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7vcc0k04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:30:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aae3e185a3so15247015ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774895415; x=1775500215;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/JUDR6QZr7b2hhsNxsLxzkUbbwsQX8cwdP4kkkbqovc=;
 b=UdrZEbDcosNJOgs+T2rA0XE6bEZe9+RYOh6N0USN36iev56uotRHIqQJoxFEhVi0de
 koNQn4pUYJTy8JIHhMZF9KwOAO3udAVHwQJ39UFzS+Xdj9rNpwJjgBSkypk441wYU+Cr
 QW5EDnqqsVkXdPdCsUvjETyt4rEQDLQ5lgwx/Aj4d+x8i046BeiEgNs1icxcdP8yA+2r
 kyVtRzm124sr9l+BVGwfsfGKJx1CnFsBxsTuOLD6sZirGai4tJY53Vt/veaUs3+iEiY8
 9TZYWp7h2pmL4VNjqBnWbf+D9osp5xOBB1wnshNplfkL9mpujcE3UYWlVeX5WnNxgmuA
 BGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774895415; x=1775500215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JUDR6QZr7b2hhsNxsLxzkUbbwsQX8cwdP4kkkbqovc=;
 b=QK1CokPBSQPC7GPqrJDKmPepKRhbD48FzLcUYkazBTdw4zZbv2+GtpwiNUEPFZxTmw
 +nOZQSxXfDwYqDOD+w5r0pUjwqfFngF6rsv+V5ZzEvFYu4YHAGgguSyqyVs9VDxk2dOm
 8szd7brPzFHcEYCh3Zspd9ntNnljy9xRJqmCBedUhS4OXAXWYABBAJrDzccH7f0h6Zl1
 Si4lKfc/XGnCCoRPTI/dy+z+eaCI421JuaEhiIN+Lwuee5Jh/uxn4aEQNPFXS/u6uF5n
 cLNczAOC9+e42rH+C3afPk/PesHZ0XU6lnVfGFE800a96pmo46tTSE9QKDPW/YQkiShy
 gCpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiwIS0T5vIPGaGTkrYJ78/mCbZNrC5ep3zc1BwkbuLuS1P3cSZ55Ebd53oR54fAyDlRMTgHZq/kXY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3hkSFuQHVcz/1hd2kekucN5dn/39q1ghOUMps7OxattLGw+2X
 SPY8c3HxcjuuQAGgD9LyqZgBOeW+8qHqHwGjz5o4z0TtSfFrtsYA/FDhq8WY6F3i0WZWsabjbh/
 VZ8ihdXL4+Rik58nr9Ch1ZLsAEjpJnN24B8COidIEFipua0dSzjNADaCEJWlIEBnmty8HewE=
X-Gm-Gg: ATEYQzz3gUFg5Z07cdzFNWEOZmtmBDTimeOAQa/YKV0VFEHQp1gsvuXHGPLYL5AW2mj
 NSZY6FYqcgvCB44Harmy31pA+7pOUDjkI5hTurfgvuICRHG7KzfJibT9gClYJw13Bk3RnUtpXkN
 07fOK5Q3S8Fz4WsfUKKYRyUzyibOIhlynYsvo+N+G4n6i85z1wWsrz0OMhd0/dNknL06ypZJTI8
 gftBDw0CTKz8h/fhiUEuUGLBZtUdYu90DKLHUzZeBKAC3Yco4KZiLz9EQXGgfjmdSwzfk87Io/r
 CVGj6QP2cvIhAS51JQsqQQXNvr1Tp8ODln+Ym5JLwP6YTLsYcElQTb2PxK9ooXNFn7bvURhS3x3
 ckEiJ7y5Ngeakvu5DiZWlufGvSKubOZKGM+TCSS2ouMd8jVVMOqss7dZseM2yXMoIoeN+//wgzb
 sotkrpBgjnCaMeB9H7uuqkNV/VGc1VYUJAmg8Mxz1N7g==
X-Received: by 2002:a17:902:d550:b0:2b2:48a5:45c3 with SMTP id
 d9443c01a7336-2b248a54b7fmr51101225ad.1.1774895414828; 
 Mon, 30 Mar 2026 11:30:14 -0700 (PDT)
X-Received: by 2002:a17:902:d550:b0:2b2:48a5:45c3 with SMTP id
 d9443c01a7336-2b248a54b7fmr51100755ad.1.1774895413958; 
 Mon, 30 Mar 2026 11:30:13 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427c176fsm88336935ad.77.2026.03.30.11.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:30:13 -0700 (PDT)
Date: Tue, 31 Mar 2026 00:00:07 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com
Subject: Re: [PATCH] drm/msm/disp/dpu: consider SSPP line width during mode
 valid
Message-ID: <acrBL4fF4aiAw8m9@hu-vishsain-blr.qualcomm.com>
References: <20260328-msm-next-v1-1-12ac4e27c670@oss.qualcomm.com>
 <v37m6z5le4rk56b7pinr5wbi7l7s2bbgkggglx4eog6w7ja77f@lvyxc5tks2bs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v37m6z5le4rk56b7pinr5wbi7l7s2bbgkggglx4eog6w7ja77f@lvyxc5tks2bs>
X-Proofpoint-ORIG-GUID: 25sWNbHi-DLW42JIV693gfZQpC2QBgFl
X-Authority-Analysis: v=2.4 cv=GbMaXAXL c=1 sm=1 tr=0 ts=69cac137 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=a2uuQ3A_lCUmVk2uvUAA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 25sWNbHi-DLW42JIV693gfZQpC2QBgFl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1MyBTYWx0ZWRfX/7IdWNruivdB
 49XPoa/4QQWS/7PAJQTMiXuhqAqelh+ML+6f5gzX0XP7cXCfylupgM06B2oyHumm+8Xy/0+kxQ3
 +WQxUYh1MN0zFXMffHulImjkxuDvpKxKCoJMxFln4Mq+T8rie916ZZHEG9AHtaCjXUYPInM9e0k
 srV2pzNxnZI4fLheNL9FtyFmOCMCcw4ZCrB+MO/NbpKzAKZIsth0pHeK0JZzk/Zygk0zI/nWMz2
 WbTicrRdLRo7do1+bP3P0XM/L7B4Ggh/f70EYW4YpvfUaLFXrIZXBq0AWA7tDzQn848w1VU4WFH
 sVrp7CtY1CIJ8ChmFcx/qYQ734Feqs8lJyB8KSYgLYUfuxVk8nqkpDAR9QpahmuIxHbIbT+pYPt
 c8hgdraMCEhR5rlRTzZE/GH22Lv3xeezvwYOHj50PV0m8LylNyQTIVUsi0PXu46hrvAOCS3zQft
 5aUXh4k5Ds3hoxaRsHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300153
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

On Sun, Mar 29, 2026 at 02:24:53AM +0200, Dmitry Baryshkov wrote:
> On Sat, Mar 28, 2026 at 10:45:35PM +0530, Vishnu Saini wrote:
> > Few targets have lesser SSPP line width compared to mixer width,
> > SSPP line width also needs to be considered during mode valid
> > to avoid failures during atomic_check.
> 
> Technically this is not correct. There is no requirement for the
> planes to cover the whole CRTC. Nor is there a requirement to use only 2
> rectangles to cover the screen. As such, it is perfectly fine in
> mode_valid, if CRTC is wider than 2x max_linewidth. It would be an error
> if the user tries to stretch 2 rectangles in such a case.

This is to fix an issue with 5k monitor on rb3gen2, since SSPP maxlinewidth is 2400
it can't cover the whole 5k buffer in left right split mode.
Do we need to fix it from drm backend by dividing 5k buffer into 2 planes and 
use 2 pipes in split mode.
4 SSPP rects --> 2 LMs --> 3d_mux --> DP
 
> > 
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> 
> -- 
> With best wishes
> Dmitry
