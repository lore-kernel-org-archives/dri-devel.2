Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F70C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76EE110E543;
	Mon,  6 Jul 2026 14:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lw7Z7xvm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="am4S9sCg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B9210E543
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:57:30 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666EEHRB803557
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 14:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hYCsnJxlsCoVEAci2Y2tWdW2
 BwZ2uRLCnXO1hko98pw=; b=lw7Z7xvmkSruIL2Cbny55zDYJFedy2/3xwd50Z5j
 L9GVNUAAUXgvKpTtHKCzGZ2z6mQbVIVdMycWmLXXoy4PX3/mPfdI4dOQcSrboFLu
 CSDXJdlrzr8N6R0OSwp64XRjG3TsvlhXIo9A9TnwE/xPhhLC/4NP+q7PB5713PL0
 4vlh+NlzOYN48uRJK6ogNfxfsKVIvQ4fHbxsWVfeaxlrJT5LQr0BT0nE/wldH8sl
 Ahc9qq3hv2RZLemwEYWfHqlA/MqimVnqJljhJUcmiXTMUSScyr5aWROWsY7I7aRm
 O+lo05VSAJ+nZjUlCWJC3kKv0srswoDukX8rmZpB3hXr0Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h51r4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:57:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92d1cae5939so312930985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783349848; x=1783954648;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hYCsnJxlsCoVEAci2Y2tWdW2BwZ2uRLCnXO1hko98pw=;
 b=am4S9sCggG0jkPN06cqfda3NBh319BITuxaAmV01GBXpR0XIgA+HZO2SgbWf2V+ZuU
 uuuSFgFfTUdmvgI1QO4A+oQmyC73/pBXD9vfKoh/eA4J7QGf3dnJBzKH1FUklUTqMCiy
 imPjVt2pKxHUd2JocfFLjEAOXPt9DaOazMxOiYDsIqAgRKA7xwoIsydNsba26q3lK6+q
 givBZNaFUm03Cf+x0mE+pmTdIaWtpjv29Xlw5NIdHR7BmJq9jSuKvWkn7m/W68ErX8p8
 Y+nGtLf62VmgBol5fl4eSSBHKwcHTfJvFO/8PLUX9LUymp3HYe7ZGBLl19r013eiONuq
 2ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783349848; x=1783954648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYCsnJxlsCoVEAci2Y2tWdW2BwZ2uRLCnXO1hko98pw=;
 b=d2IvPvlulNu0gNjcUc0+R2GBHoUQ1aXHET86gLpbXzpc+SaLKQB5QU8sJXIu5yJyuZ
 GtVUATcYoqWzS19RSdV2b4HpA4GN34NQlPs7VSYEL0TAJcJU5kCOR15F2biFdXGz63jH
 J6fSBZzLajIlFWxiUNWBMTBRvwlpjW663HiWcZvRvNP1Ek1jgSLR4uhWpr/Qus/b90ND
 R6f+UIYCiKeV1niqWVl4zS+V6E7nUAbhsiyTaw6Ms5ozXsyK5WgS3LKliVKWr0eFW4N8
 WR4mSPDIyyP3niHjaU3Z7va0CxbZnIRzUkEzolylF9GylYwRD5fJIpGN7zmWM2GfKmZK
 SEGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3APGngX9A2z9mKBiXDKoMm18Aew1eI9Uocu1V7UvXP9pQr1sI4XClZRyOsbDV5olqiWfFh4fyg4Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmqyHNnuwF4RqZI7I9G3PKtBWnMAdMw85Xx7shfLHLEeP9g/KZ
 mlpuQXcs7dTAgY0WTZfVOHqcRU4y1cyBCsSyzAWt18rjxzGqL93qkHP6JWOGqRpZ8Ge2Frw7LTU
 1UhP1RzgWGct/eSWNRYwInY2FLawMY3WregH8lbwJrDHkXnNYuI2QcKdzmTqqAyDN98CPZig=
X-Gm-Gg: AfdE7cmP4psAYiHfZpD1H2t9LIGE4u8z31zIjsotp0a9ph7RnUgUmlfY4hQsaQVf8Ca
 QmoMg8b20Zc9p5167VZg5Szi2tSElsLQZ6735hCwSMH36JWJYhpXfdV+AoNtkjdynRM62aJOFBr
 0EQWAXtOYq+m0JSpk+xUepMLaIy8e043sg5CZSK80x/LJ7ZxRiFYwcPN9igGLzQZd8WUyUFdThj
 MU7QDwmx5piOaYLJ4ERFqFHkjpdnQeQgCzdgEZ4jCh7of0CMZPDztMFGI7V8dDnfu1ueSUK8NJ4
 sM77NVEh561GDKRjoOiuJJoECss9ET3wFhaXXMyq5MS91aN+vZFGEGswQDLHu4Wm/bCfV2f9WXi
 ZNFd8aROaTmJ/dEyL4enRVhhViKM8OJU1vNQvbLmtEwRXGqIZe5SghFp6bCt8SrsTfeaVytnDXk
 Z1XHZcxGWnfQVsKxRiWqcB1coE
X-Received: by 2002:a05:620a:4101:b0:92e:8256:8226 with SMTP id
 af79cd13be357-92ebb56a788mr122718885a.44.1783349848310; 
 Mon, 06 Jul 2026 07:57:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4101:b0:92e:8256:8226 with SMTP id
 af79cd13be357-92ebb56a788mr122711185a.44.1783349847690; 
 Mon, 06 Jul 2026 07:57:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b4ad35edfsm23456681fa.13.2026.07.06.07.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 07:57:25 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:57:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 00/13] Enable LPAC on a7xx series GPUs
Message-ID: <mn7dmfbyt2hnvlb7u2vnxurqef3w45rrjanhkd5ei65sgasfnl@l73s4c6yqxbe>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
X-Proofpoint-GUID: IdmAO39V-7AhkMB3yvCSLC2P1NhPAJh5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1MiBTYWx0ZWRfXwGHXI7/C9Lbz
 /GAnFI9zq2NvQsptaxTqeEw60XzddC05nyR+iwRgPGJL3ThYne+b5e0PwxWkO6p69fTIjRsyO4b
 z7/NKDhFBie2P86p6RCwKPY205aU7o0=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4bc259 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=5ytNcvzt7bZj-gOGiacA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1MiBTYWx0ZWRfX3x18cc+2jWCU
 KTMmt7rNJMbabYrSwsD09xLTl0S3xIqdEAGLGUl7ZlIeCm/EPbqDIjfI4+AdKf8ZmWc8cdd3/8J
 j5FQPjD07JhQAysFvO1nZUjvLceN6J8ORRrf9NfaN6cQwFP87vUvNElaA5e1PTtYd7XdIDIj9Yv
 ubpwihoqKm60pAoyO+aOxrnd/ckvAa/7vRCEpjTycoq18JTCi3xMH08AmpO/wgpC1lbrYwAKQdp
 R3wLBZYRKuon2vFk0OWTWhD5oKr883aB28e0lf+Otb/tGteBItpvsVknib5vAmX6JBNkULD/+Yi
 T7N3LD1NhQTPBo9Yk+WIp6viQ7mMlC5PE1dbNp7cu33rphIxDIc1dopYc/xrne/ud2pLyUa5eL2
 d2m50XjI73F8i0aaBZClckqW5rdtVGnE8qVlb5MG+Wo6f8CSqBmzHHH8WnQfEgcMHpFNumkJT41
 5Dmbcxdt8HOZed1iBCw==
X-Proofpoint-ORIG-GUID: IdmAO39V-7AhkMB3yvCSLC2P1NhPAJh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060152
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

On Sun, Jul 05, 2026 at 09:13:34PM +0200, Anna Maniscalco wrote:
> This series enables LPAC on a7xx GPUs

What is LPAC? Please explain (or at least expand it once) it here and in
the first commit goes to each subsystem

> 
> Currently hangcheck and recovery are broken as the patches to make them
> work depend on https://lore.kernel.org/linux-arm-msm/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com/
> 
> The series also depends on https://lore.kernel.org/linux-arm-msm/177919116291.814652.1720687887970998122.b4-ty@kernel.org/
> to work correctly.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

-- 
With best wishes
Dmitry
