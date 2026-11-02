Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC3606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rc74JD1t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K/BzsCil
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A570A10ECAF;
	Mon,  2 Nov 2026 10:27:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C834F10E606
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:27:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29ASdb3440489
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 10:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Ib+6Qj7A9ckU60iJXh6OYZ60
 6g713kfL86TlY+QIpKE=; b=Rc74JD1t5B2olBnDuJ5opJY6/MqRjdN48Vx1qN1P
 R70XIQjX9PmM6YzZklHy9o4Uue3mEVrjnDdMPAG6q1poitExPHeG6OeDhnMlQjEd
 HnyANHPJLaU4M76+gqWJEzuAyZeCwsiHD8Wz173LnqeyjMco2CgIztVdfxv3TYbT
 9/073vcVjhx1iFFaKRKqn5YLZzUmxbDt5h10v+95dN2zLKoKM1YSzu/aRYVYslE3
 W8kAeKAxccFyphpbkXN93cqof0i9IWlEEwv9zAetqpZlTl0aYVL3AyjTb/wvVZDJ
 WLuyhXSspFdewmB2+PhzBrDlwRIh3ZYGzbxpgypmP/AIEQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg201vtx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 10:27:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf7856ffso591119485a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 02:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793615234; x=1794220034;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ib+6Qj7A9ckU60iJXh6OYZ606g713kfL86TlY+QIpKE=;
 b=K/BzsCilhT0TpTtFiDE7r8ooeuBxhClqdxOorZ/NrnFaDCsEVcMXq1Kzkcvic3qhE+
 CcbOIGHVWh9pgCjobk5jn2dlxlPrB+cytDcYv+IcitmT1LqS6P+jVOrpr+KwZZTPSVX0
 9Z4oKKXaEcwMwjdEQreoa1tzdEGTyKlT7nXFc8MipMdtshOWxCrgPXWfNO6C70rs9mGc
 huELDHlHZQ4Iaio5JVQrysT9xU7kvPL2RfbX7RlZUuAHVkAnwgdMCnAFvCLLsdGKaWqy
 wszRdPj1NQhFeK2+nBrt5C/5ssywEdWKu2Nhyx/cKldCI+JkM6bWj++JphQoHTAKQKso
 apaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615234; x=1794220034;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ib+6Qj7A9ckU60iJXh6OYZ606g713kfL86TlY+QIpKE=;
 b=IPrNlGMxrOTbyx+rzYl18IXL/aHNtZeJx4tI77a/ZSrgaj8E7PT8lgDvTT5cg5vH2J
 1ah8KfVBPT/sRvRXqabX1KcrIGhdu25VabC4NzFaG2G3oRVt4baDypJvmOBWpt9KnNzQ
 JTKZfXD/awRixIdJ8CX0lQnpcwdKBX75A9qA5IBTRY3FRGlxYQBEbsl4/jUrWeteTEou
 Jkcb9dDgVQKIg0SZcmNo5m472tCIGfjR64OU+LxlanVo/+6JE9lLihS9SBsex0TvwZte
 2tXDiiyu35IZhfJRNKRwgtNfQzYDSU9pphABxHQZlneCmO3Uv+PBYhbogi7wwyN5ruK3
 BpZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlT4tpkJlyEKC/MZg0bNQrvArA3AGdabi+dR5B3uwe4xWk8xSpkEjFkw4qoH6cY1pXUodYt3tstnE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+5xDs/D3hRseRrPyXg/MLwS84ekDbnJJlZBigoaL/MrMiTBwzs
 0XxC3CNnKhZV+pR+YtO4sdrP2MphplHOxlcc44axrla8xUEMIOijDPzbsUHpXhegOjODRR0ELSY
 TnhiK6uGqj6sD3D/GIoM+BqrVgPzhzfuVps8wuLEVjbRgC73EWGP0aclX85FD2NDKho2xhoY=
X-Gm-Gg: AYBFou2L9RjIacnAu3Cg9Y/y1bTpqdVJ6tT7RcjpkZuFV66/B15eDEdgOYSV+iaLEmk
 g04yAH3knRWfKVFXjkPedspmc7V+ZDE9PrW8onsHrU+2zO5eW0sUTOC2rnxWzqm4wdgKDRf2iSE
 7XJdQ2VoZ5ssTTv859qfgNP/Z02u57OEngP2VlQvQvYIzLuPN6sW6aR4gDkYptLaA3E0jzFra01
 6pGXIfY6WpVaB9MMd9u3KISc3c2tcYPvQ546RoocqwJIKduvL02pP9gAWMppgCSi9C6CtggD8+H
 m8LF2/HlOxKwQxuwOfie2a2jsW4KpaUWlSx/uKSuZeAH3t2b+kIbMJSyqS4eehzqvYB1R4Tn8ZQ
 xTUHAmCinxvR1IXOaabY57JpO1sXoVfClaBFO8UbXF3fEmbb/TprozKApKxtYSuadUn44fpwY0P
 sb8PpEx6D2W743LviXtsZMgIh/Kfr6qJEFaCzJCj/GjVn1xKQjmJoWJICb2DuP
X-Received: by 2002:a05:620a:a295:b0:945:afc1:a73e with SMTP id
 af79cd13be357-945afc1ac08mr460190185a.8.1793615234448; 
 Mon, 02 Nov 2026 02:27:14 -0800 (PST)
X-Received: by 2002:a05:620a:a295:b0:945:afc1:a73e with SMTP id
 af79cd13be357-945afc1ac08mr460186885a.8.1793615233931; 
 Mon, 02 Nov 2026 02:27:13 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe04edfd3sm1554653e87.8.2026.11.02.02.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:27:12 -0800 (PST)
Date: Mon, 2 Nov 2026 12:27:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/msm/gem: Fix VM_BIND range check
Message-ID: <4wnqvr4dugximyavejigdvddessngvhgh5xpkvlpi4bvbsqijz@nvmxmmbmnwee>
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
 <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
 <90ae1b4e-d83e-4209-9df1-7ebf778a881a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ae1b4e-d83e-4209-9df1-7ebf778a881a@oss.qualcomm.com>
X-Proofpoint-GUID: u5_ftX5XDLmK_yUtEaTsi2wGaiEm3Io5
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae86583 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=NaZcOW_h6FOph8AvsZMA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: u5_ftX5XDLmK_yUtEaTsi2wGaiEm3Io5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX4Y/6+H02WpmU
 b02XA5UEap2xj8fT/r+NoRLbHqqJELYbcaXuTaI9oJa56Bw7NB/t7UcYF3QB1Tkd0j7j1AvQDuA
 c4gPN82xkEKQcEA5/ooQSqqi+0MwNKZuaOPykMuniap/LwkRTfnvUbPgPYc4AVvEqJKALQjTNjp
 6ZHtbWvQJbwyxY1nlfCAtIAuLCwzXZZwyJHwKP3VKGAZy88aw8cVcJ6aaOLIwGEYb9vThFcclRw
 /LjPq+4Sb5cPoEgGaDhWARqPw3ky/kp/VfooEcyfSrRVtiYxHnFz1q/PrS5zzk6eyQKcCFg8nQ3
 GbZr0Lo+gzviYgsX3bmVjD0crUGg/VWV5OJZq8jUt6GSjmiN5GSuIriVTuWVCcNemo+9CdlF7Vt
 UQ3XJrJKP/OGG529WxatGPOq45TPxeGoonshXVIerF3L4MwgZT5GqNH1yycwrHYH+E956Y+e8l+
 g3AuC3h4I4Mi/0EO56A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX+zXoc0Wc1GO2
 UZ6GcLoavGPX4d0zqZkG+fNxUq8uDlvJp8QOP/LtuG7bepG6F8rZCFsisaLZRlgec/4Lz0rOrQ7
 Mg1o9R2ZATVd5BMaU/G3wDpSpamZV1U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020041
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

On Mon, Nov 02, 2026 at 10:40:06AM +0100, Konrad Dybcio wrote:
> On 11/1/26 6:49 PM, Rob Clark wrote:
> > Use size_add() to guard against overflow.
> > 
> > Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validation")
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> > index f687a629629d..16b3870d5e90 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> > @@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
> >  		op->obj = obj;
> >  		cnt++;
> >  
> > -		if ((op->range + op->obj_offset) > obj->size) {
> > +		if (size_add(op->range, op->obj_offset) > obj->size) {
> 
> GPT and Sashiko are unhappy about what this does on 32b

I'd somewhat doubt that we would ever need VM_BIND on arm32 platforms.
a2xx isn't Vulkan-compatible, a3xx is questionable.

-- 
With best wishes
Dmitry
