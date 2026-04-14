Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0295F9D0EC
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AF310E041;
	Tue, 14 Apr 2026 18:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HcQ8DkL5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h0JcxybM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0836910E041
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:11:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EGgdNH030706
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J3D1WvWzIUqXKZeMB5J0CZaS
 azdSgxka7Wv0a/uVx78=; b=HcQ8DkL5wR+z0LAnelrcY9G7YQ7HrPBbUP4vQzXf
 oDTa04nhEXZuPH8Rh8F0MojcGa6ncsuXiYwir0McDuz7oIY2Tx6BaxLiyUwHmSAa
 DMT37De5jqu8PcE3kKMZsGEyrt5dOzirj/GU2z6gD3QVRCvRv1kFgiSMf2VPoggs
 sYJXG7KwaJwb56/WuUcf9at2g4Eb1LyVgpTBynSCzmA7FGmpxJ/u5+xw9cZGNSc+
 L7QotibucPaXSOA1ZiX8+SQWZX08RmLf4Lh+WSsh798Bahy9Qt9ZGSfrqf5YaWyr
 e0QwG4M8JPaIWADRbQmbTRSC++rCkHlqmfXt7FbnmCcmVA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhkgmhrpt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:11:21 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6056898a01dso4568024137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776190280; x=1776795080;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J3D1WvWzIUqXKZeMB5J0CZaSazdSgxka7Wv0a/uVx78=;
 b=h0JcxybM/U+h6wHl7qGX+JzSo7K7V2pCzrj1J0EMCnhY7njxZ0pCMved113ubGeSYg
 91LgfZF+dqF9DLC2ZKSRh6OZTMP8KuTpdoQ4Qo1W+tzZ8R+rEV9N91M+dUrvuDIuSmnr
 HsDYO39gxEbuJwM3Rdr6Toxq+MUdF58tX5BwlRXKzJowo1cK4Z9AjUdO7qF4tAJoJcgB
 pzNA9QqJnz6IN/xLJYiGnXVH654iFxFRxki0TX+1eDObh1Bmk9n8sMUKhvSbt+Obxc6y
 FcMucxy02d0zRxsHNPQ8c2TNqRJN415st8ruSrnwkIMzZJe/OSkSNDIsHDCOHIFC+Phy
 W8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776190280; x=1776795080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3D1WvWzIUqXKZeMB5J0CZaSazdSgxka7Wv0a/uVx78=;
 b=T78z/wNQywV8XsnjsQPR9FirlqCqw9EyKtujyOML9Q/dTqXUoEF481V0HXZRaY5Ymo
 EIONUnEP6tKxBsQvKgZynliD0xNzA952AVNymeu0qk/MfPGzZLHuicjppeccSlvjRfZx
 C5fwgORS6K2lcn99uff3h59iQwsYSL+i4HHSUKanSvk+vbuYTsmDwYXhdpVb76h6Gcng
 +Dip6wfr+Qh3QxInFncZIIn3epSrYO3CDAsy1/3yfceOPRUyhCmITQZyvvqInwte6/L3
 1pWELclUHB6qPjTZKdmhbOxR84+pzU14/mj26ddSPqDtIwIm3/CHOomabAi4VFYUSUyI
 yfJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ88kn5fJ77dGKMWykc4cfrIOxeG5Vq8eQp40gU/Bv5yeRiz7GHmg9IWiIUVS+mrs+YkZFv4SG04ohM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdBb8vYmyl0O1sKw+GoHjzbQhPziIx//NLb8X/IHGbjkzf0fm4
 TM6VeWu5nTRV799dQXSRXHzygaC2pxL2fbAK85G4802n5FaDeJMGDpnxvPXuSnMob/+9gP7LciN
 9wWeNS1zd2lFc3BjHsZEPzBSb0SCCb2+onG9XlYTuwvc5lgoyFA8cjpErdLYaY4I7f4RDcfY=
X-Gm-Gg: AeBDievaxXKJa2UO6bCweQdOiQuQUz5l4V+r/AebQZW5w2Ewj7Jrwjn23xz9mzi8c1y
 Yn9CFpo6EciPZitx0aizhmbwu1kCrEnQGKO4wTwCIrvAGqN7HnadUCRr6skVA6PPfBFkbXoH/+K
 GBZIuUdz1at6tKK2EMdOWGhxQPLKu2LBiYM6WWTK0kMy885BC4SxjplVjysdiYqEsRHFq/IC7z+
 lHeGdWnN9P3dVTuQaZX6CTjjXEcwKPSqNBx5juxJuvn1PgUA60OYIraxuxh4yZg9ZZaBUkVIFaz
 +TJ+gqcO0XuZNsXz8vULNIQ7nGC48ErIbmQiIBrW3NgyiuMZiB8jTWZcSg8ZSR73baa98TcfNAM
 etyWuBs34g8hYdSVkBG9PS8GvdoPt8xAEBlHacQQGF2DbQ95ug9JLkAnwEZAe+0tcm8ztMcLskQ
 pbAMTed9pmuCpUsYsElH3SA6KV4dicFa/iSXWvc6N77ksN9A==
X-Received: by 2002:a05:6102:3ec4:b0:608:7b2e:4160 with SMTP id
 ada2fe7eead31-609fe7a6d0cmr8943961137.5.1776190280348; 
 Tue, 14 Apr 2026 11:11:20 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec4:b0:608:7b2e:4160 with SMTP id
 ada2fe7eead31-609fe7a6d0cmr8943935137.5.1776190279941; 
 Tue, 14 Apr 2026 11:11:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495455acsm30849991fa.23.2026.04.14.11.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 11:11:18 -0700 (PDT)
Date: Tue, 14 Apr 2026 21:11:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pengyu Luo <mitltlatltl@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/msm/dsi: fix bits_per_pclk
Message-ID: <7rzdzfon3mytcwsagddr5c57aypkr5rxco3ubtwe3osc7zkonz@sfskmvme4m5x>
References: <20260307111250.105772-1-mitltlatltl@gmail.com>
 <177463970785.3488980.6066718261448635938.b4-ty@b4>
 <DHSSQYIFSY92.1J57RLTLCH8B@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHSSQYIFSY92.1J57RLTLCH8B@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MCBTYWx0ZWRfX1o1D9ok3ALRy
 XHzuVKdPNjkUILwBs4H3ldh/BIS6+ZAVCioaovQcf0ZnTws7epXR0gFrKOT1xgh5eLNVev9TGQG
 /liLqpRF1BLAP02Of+1fM6JGVEAUpnIGgkdGYsGI40X3Xtu+1ufz1ahsZGfA7uZSP1oJDzpiZG+
 3dTwcduVzf/EQTCOERk77N/fAbiexZv0JzgSbkKjdnhDT0JZmScIneLi9d5gC9kkrGA7zrbpz4F
 MxIxXNqOYHp+CWcitylLozQUKZiFd2RQNcGsvsabbxTqzhv4gmCZocP8bBduFACPWH33krqH5Nd
 VJHR6mUM1C0gRVpzgCMnwUSmH/fU5yCgqoU4Y5P/TMQf9pC/tWPgcUjAzA9kgui+h5fZDkcLazs
 5dj12GF0OLJ1SAEvDD3BXKLHYDJBGXcXyB7eD+FZyR4OfyruOvkDk58IYaUgfIJr/tyejYxD/QN
 99DZF6Bxi86fZzDO6Nw==
X-Proofpoint-ORIG-GUID: Nolj-biasZWk6TzeKHFTTn3swqEGH7vp
X-Proofpoint-GUID: Nolj-biasZWk6TzeKHFTTn3swqEGH7vp
X-Authority-Analysis: v=2.4 cv=HJLz0Itv c=1 sm=1 tr=0 ts=69de8349 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=587haw6TKzS2yHxLNCAA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140170
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

On Tue, Apr 14, 2026 at 12:13:45PM +0200, Luca Weiss wrote:
> Hi all,
> 
> On Fri Mar 27, 2026 at 8:47 PM CET, Dmitry Baryshkov wrote:
> > On Sat, 07 Mar 2026 19:12:48 +0800, Pengyu Luo wrote:
> >> mipi_dsi_pixel_format_to_bpp return dst bpp not src bpp, dst bpp may
> >> not be the uncompressed data size. use src bpc * 3 to get src bpp,
> >> this aligns with pclk rate calculation.
> >
> > Applied to msm-next, thanks!
> >
> > [1/2] drm/msm/dsi: fix bits_per_pclk
> >       https://gitlab.freedesktop.org/lumag/msm/-/commit/2d51cfb77daa
> > [2/2] drm/msm/dsi: fix hdisplay calculation for CMD mode panel
> >       https://gitlab.freedesktop.org/lumag/msm/-/commit/82159db4371f
> 
> Just wanna document this somewhere, 7.0 is quite broken on QCM6490
> Fairphone 5 (8-bit cmd mode panel).
> 
> Picking these two patches plus "drm/msm/dpu: don't try using 2 LMs if
> only one DSC is available" on top of 7.0 makes display work again.

Yep. It was a bit too late for 7.0, so the plan (and hope) is for them
to be picked up into 7.0-stable.

-- 
With best wishes
Dmitry
