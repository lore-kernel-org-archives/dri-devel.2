Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E7E1061B1D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D052110E6C0;
	Mon, 30 Mar 2026 19:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qiqbxkk8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMav9TDj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F2E10E6B7
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:38:20 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UDchka2458393
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Cu0HvQ7vzc/dwwRQ08t4QFfK
 4UOUE6YCPsd1rfuvHH0=; b=Qiqbxkk8NW0Pe9voAXaPRbY4eIAo4oO8+oP35SRq
 KQoBfdNE0yrc7m91KzP4qKb9bDL+0NAGhGKWi99tEl3/ohFGbcb0jp0waVMBZ3XS
 Sac5cfqU1+rQL8/skPZscZg5Qzo7mnfCxZk55S2M7VYoVR6/uN+Zql9qdL0hU1av
 1AQehnZvnau0rz7KgCnLAXA9Xzy698JswsedaMMYufL+Xq/i4DOkMZgkpWn5hmjV
 s2VYZh4M6pBDLwp+SRGhjlMH9V39l6PdNHgmlTdUBzs6W6NX26Z9BrqafTaR1Rgt
 1SWYtKV52C/x4LAGK905oGAmvnZroNKxs52/F02XtcnI4w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7nnmtrkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:38:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-509070bda13so150966501cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774899499; x=1775504299;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cu0HvQ7vzc/dwwRQ08t4QFfK4UOUE6YCPsd1rfuvHH0=;
 b=kMav9TDjpgEZiU+OQbjBRz9YpBegV4AnEgSUe9mLDNtArHPp4Ra29qgv7sNC7y1Xwf
 xGUjpRKHC4rXu/QdWSAN7fnWPwH6zxcJmcIeWuqwn6r36ii4pSEw4JcBI5l+m2ZN3/8N
 6CaU0C400WCkeJiIv9Ejb/Uvjt0Vk3+zkAAjuTWunBEU+XGj0Yy3pcX9pfuEqOzj1hWb
 cQKRLQ7nbDE6XsXm0OK0J77KcvBYOicZCrjtji0aFxctCWSY7/pQWWjG5+oWgoUBK4yH
 xuEQniTYfI5uT7E5KdS9U3NxZOh4dGamFpsxmkvJZH0hVwY4UYQ4PnwD/hubBgeajhM/
 lWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774899499; x=1775504299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cu0HvQ7vzc/dwwRQ08t4QFfK4UOUE6YCPsd1rfuvHH0=;
 b=IR5l/rnavFL4oUVmIhAYgSzD6vi2tgeAZ3tLHFpOW3pqry33JU8tuQfNMRbWlaDa/R
 wbr5eb25Dnciezg9uh4yoocqWsUBMWThVSsQS0n5sJmU0zmx4/bMrrFMcOcts+Ip7/jx
 QA3FFfoe5gyihygAyc/FLSDL4mKiZ0BeeGB+hF0UPH3ps8XUZpzvS5gZsqs8F3ffGDWV
 RdgRfefcT52LqAxhuCc9nVbp+1qeUFjHhFlVZo9PBcXJrmg477pu2LZXPUHKtXb325dm
 DfIsfHe5n35y4IIt/c8Ha1gclkAeLQ9kmQC8fdARt1wqJguF8mdWTRC+ZDM35qj4SJG4
 vQ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSDpXEJmDY0Vd5/T6KIMX73FcZR4seNZHsDDatdfDZXTilwBUdR4UhJHv4nvdS2TkoTI+faGLMnoc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgeY6xjw7xg4NxsgMBUbQIl9xVJGCmC7IVbEE5wVWI7/bpTHya
 PfQjWCvkfFJTQWgQKR2yJOdi9bLPnQ+5AyADdXkQZmTtH+92IZgifRHO5RldlmJCURnT92LTmqt
 KBnvZGle3g23qU/3SGTivsrxlVXNaCDft3HlFAk64DAE+Zu/ryJqs/+fYgpKpyTA0va9StXE=
X-Gm-Gg: ATEYQzxbi5Dc6dPppT2E2xZZ5RaUnFD78SZx1/5wqa10w9DaMdDdVelF3c58J9GNi2l
 YUo7jn9WKbMVHCG5uqVhBkHbpVm7SuU/dEgXQAw+KLhqcifc6NbhBhyul2GFY1AA/uuicRQFW3X
 rZwL/PWPd+cJtTAqnNjzK1veCmqT4ZxDAkooMegxaofK3h/8yHHc3ZIVpVtDozFYgUScRU4shAJ
 2y9KNaqr63mfbgDIDzH5oq77i0is+e/1olzJWb28jrR3i4gv5OA5ENFDRY//jyL4D/tHc3kv/HQ
 NToAejsNtZanlGxvFWhQP8EC2BYLOob3+SU8uHu3uZytt7n0vWVfVNuIEkP+xuo0lTFHjv5dLGT
 GgA4ebNBFnn6nYi6aYt4Jb/MroSAr5MBhxwoitoxpP+5yzPbUR5Z11XcE4dDxPxUrAeoy/sngZe
 zv3vqZSY3Nf7czwd5J2elpc2CTUawPFPlOo84=
X-Received: by 2002:a05:622a:6183:b0:4ed:70d7:aa5a with SMTP id
 d75a77b69052e-50d2c8b041fmr11463621cf.25.1774899499141; 
 Mon, 30 Mar 2026 12:38:19 -0700 (PDT)
X-Received: by 2002:a05:622a:6183:b0:4ed:70d7:aa5a with SMTP id
 d75a77b69052e-50d2c8b041fmr11463261cf.25.1774899498649; 
 Mon, 30 Mar 2026 12:38:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1443f16sm1946495e87.44.2026.03.30.12.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 12:38:17 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:38:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
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
Message-ID: <sube4fl4iubrutg7wvdqcmdpuvia5bavmc5x5gajrngsrte6fj@nybmbjbcm6ma>
References: <20260328-msm-next-v1-1-12ac4e27c670@oss.qualcomm.com>
 <v37m6z5le4rk56b7pinr5wbi7l7s2bbgkggglx4eog6w7ja77f@lvyxc5tks2bs>
 <acrBL4fF4aiAw8m9@hu-vishsain-blr.qualcomm.com>
 <c7xvoopmujdmdar4lr5oghcc4olc72fpfrpe6yq7wrmtqaytjg@iweixftggvbg>
 <acrHj02HsaoK5N1b@hu-vishsain-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acrHj02HsaoK5N1b@hu-vishsain-blr.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE2NCBTYWx0ZWRfX9F2vTf9wWbCN
 6xH6Hi/nRpVYGauge+cJgwT7DzPzu31k6edzEJDHgr4F5MK6OKM93acbGwCZ8pEAokAzkdCP51X
 8PxYorUXVAC85tZ9Hx/85NVkbSV5qQsamaGo+IS0SARrgDE16MDzkxp6FG6YS8O2hE3rpYWmJwj
 EIzuHgbuIL477jG7lTq8Yz65OgssMv6RFyCSO4EhiEwSMoIervuVLdLzlVbvE33sYBgzin/4uPF
 nCyIUDAO2DmcPZfQ9uq9Imv+sAt0wM4W/kjoQtII0SGNFcFNoEsWJlfrCk86U5MwRcx4OuhP5cQ
 a+13EHjUVpacTYAKPYV5NWtlmDikVRumZXaMA2fO7O4vs4qyEmalN03u2YuT7lN45WVB1sqtYTv
 jwVPDf2rk0HGKTJfmGBaljte1qwVbfmA+/Lx830DIpqgYissZUePe4qNGz/d/O2T8pW+FKmILAR
 DOiHKvH6jdU4h+JoaRQ==
X-Authority-Analysis: v=2.4 cv=M4FA6iws c=1 sm=1 tr=0 ts=69cad12c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=G2SdLJHArYRvH_znJewA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: LhDBuQRN5u3oULm6qNzdqIkrN2iFZNmD
X-Proofpoint-ORIG-GUID: LhDBuQRN5u3oULm6qNzdqIkrN2iFZNmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300164
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

On Tue, Mar 31, 2026 at 12:27:19AM +0530, Vishnu Saini wrote:
> On Mon, Mar 30, 2026 at 09:39:31PM +0300, Dmitry Baryshkov wrote:
> > On Tue, Mar 31, 2026 at 12:00:07AM +0530, Vishnu Saini wrote:
> > > On Sun, Mar 29, 2026 at 02:24:53AM +0200, Dmitry Baryshkov wrote:
> > > > On Sat, Mar 28, 2026 at 10:45:35PM +0530, Vishnu Saini wrote:
> > > > > Few targets have lesser SSPP line width compared to mixer width,
> > > > > SSPP line width also needs to be considered during mode valid
> > > > > to avoid failures during atomic_check.
> > > > 
> > > > Technically this is not correct. There is no requirement for the
> > > > planes to cover the whole CRTC. Nor is there a requirement to use only 2
> > > > rectangles to cover the screen. As such, it is perfectly fine in
> > > > mode_valid, if CRTC is wider than 2x max_linewidth. It would be an error
> > > > if the user tries to stretch 2 rectangles in such a case.
> > > 
> > > This is to fix an issue with 5k monitor on rb3gen2, since SSPP maxlinewidth is 2400
> > > it can't cover the whole 5k buffer in left right split mode.
> > > Do we need to fix it from drm backend by dividing 5k buffer into 2 planes and 
> > > use 2 pipes in split mode.
> > 
> > Quad pipe is pending for 7.2, most likely. However, I think, instead you
> > should teach compositor that if the commit fails, it should retry with
> > the lower resolution (it might require somethi g like -E2BIG from te
> > commit).
> Yes, from driver we are returning "-E2BIG" during atomic_check.
> Thank you for the clarity, will try to fix it from compositor.

Just to point out: it's not different from the driver not being able to
perform the atomic commit for any other reason. For example, if card has
3 outputs but can support only 2 concurrent outputs, then each connector
will still have a list of valid modes, but trying to enable outputs on
all three of them would still fail (or trying to enable high-enough
resolution on all three, if that removes a possible question of limiting
number of outputs by other means).

>  
> > > 4 SSPP rects --> 2 LMs --> 3d_mux --> DP
> > >  
> > > > > 
> > > > > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 12 ++++++++----
> > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > > 
> > > > 
> > > > -- 
> > > > With best wishes
> > > > Dmitry
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
