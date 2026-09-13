Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E266C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3137410E538;
	Sun, 13 Sep 2026 22:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9ecl/3r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6gNit+S";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8C110E538
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:01:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DLCFbm2995830
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Xgq9nxYg1s4/w+cKJgzA5F91
 zhXCkDXvYVANjzYyq0E=; b=L9ecl/3raYaN7trux13QAE77+TplzkUFbUFZxit/
 14iMkaJ3UaKfZVqg4SkYu9s8Ip4X5MzEYMog18kLTYsPiaqWyb7+L/+swzCwrUp1
 FQPu26+AmdFH9IhOBiNm7NjFhdriEJJLrKI+Si3OKcWLk4scv5lq3kBfA2kVL59G
 l6Gs4xrIZ+1HJAg/SytB8nrrY+8qAmxluEJ67ALppiO+tUMkXc8eU+QgCR53xn5A
 qgPrgmhq4UnCHhthfA189EEmDL6KCZad+LxlAEeP/KYFsO4IgBlqtvZng4H28EQg
 ZQrR8Qy8b3xyYz8ZxWrPYxZ3mCwCwNzDqDHxaBRvfbfKsw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsr2ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:01:21 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-78a5a291af3so2274423137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789336880; x=1789941680;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xgq9nxYg1s4/w+cKJgzA5F91zhXCkDXvYVANjzYyq0E=;
 b=U6gNit+Sar4/eu0q8vTyv/i9lX9mmY/QUX+s/M5YGtRksWQxavm69LhpyjU1MRWq8V
 ClpCdkgqKNoNGgnPt4EqEoCjra0NlD49esjcwki+b+E99kPce6uOjp6JOKOX806CWu77
 1eC7i9yFzU1x/1SwVlF5Go4I95dqrnlt2oUURZeWQ4RX2pyCd7xsM20v+mEdAi/WrRC2
 1c5G41EtW5s1R2k3+6TdyspDKyylEdTdgC45+yQe7RadlCIJg9WmoKA8548ePJWPB1kK
 1xzVL88DGPY1VYnVXmCNvIntz5SeJKK5+RPRlhJV3bhMnae6wmBSYQuM2LcubnUPevDJ
 EdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789336880; x=1789941680;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xgq9nxYg1s4/w+cKJgzA5F91zhXCkDXvYVANjzYyq0E=;
 b=pMKArDHru4AWvwOJ4Bl9Ibz2cNRYgl00eAKZVk4X3T6bX2tzdhEXY4t+cAd4wei7aP
 6ID9vvYrXPaMBS8Z1L+uQ5exGpkSsdZ1pQcUolfDTL5mJxfl3dX0CBVzvFJiDWg9tH9W
 11RWLePAGFBCwIiw7HgMr2WPf68kFGjz/kTUORjxMvQ+vugFGALLINqBhUyLaxJUeUZO
 RzUXPRJGtREjxAwcDktHXFg3y/vBIPyfq67wzZj5jf084QxCO4U4BeOxcnXGaL8Ec9BG
 BHr2MrTYdrEm0yEBIhcGuhudGchdcXqunKour6FGSFAB36BdxMppfpEt8tONIh7IUYb0
 FvoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSIV4GUAnILbeWccUb2aFwxc6Ww7yqXKe5GAMGuI5z+BPOwtA03I0vPtDU84/YR7b6LWN8LFm/cbw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqh8UorN3h/Q352GtR/6TiqDEdHCbnopNqmIrevV77h43Ny0Z2
 Sba6gMu7mVa0ImGRNKQ3wzB1JFfimnfVfb9SH3o+z3UZPad7OgLWRqi5kBdqmY7WYEj5sbttaO3
 pZlqaJkzL8A9PnTQbg5bhevm6e1NFCH9yyqTInoUhUNOiyLhhZjDmxT4vvpkcfz9m9wajYxU=
X-Gm-Gg: AYBFou28j2SX0wUtFgaLoB7P12Cv+FtKB67c4TIsvMNP+NNbvZvQ4eXXY8HeGvCD24H
 aOCfG0EU0vDQjVwzbMi0Vj48vgB8B1LwdhT0xwLBuYD+SoQc4psnXotdEcamv8Hi8a64FOwTOR9
 SNpFLUS+ZDTIhw4Qs5F/nTB1eAmUhH6cpjBvg3l+eu5Y/0k015RWTukpbaeSrAClZHhJqFCXWRI
 u8653HPjeIt1H3KCtDaENu846hHJZ+f35gZS41C0oPVXYD4EvgxknrSMg3SYzxgPifPosdHj+ko
 SMIgpkQwd/gcnzJynZbGA4l/KdMr9Y6X3plNbI/KK4z/yfA3kLAO2+d2m2zNH4q43LM5OXLSzGg
 P/p96jsFanlbpL0/TVxM/GH57i2ny8JE4K69Epng7PQ+LfEz+/DoCiaz9Ed5qAgs7woelkeowAL
 0WBRwoGNxFQgNA
X-Received: by 2002:a05:6102:a203:10b0:785:d308:cc2e with SMTP id
 ada2fe7eead31-792a89d2f10mr5496653137.9.1789336880509; 
 Sun, 13 Sep 2026 15:01:20 -0700 (PDT)
X-Received: by 2002:a05:6102:a203:10b0:785:d308:cc2e with SMTP id
 ada2fe7eead31-792a89d2f10mr5496642137.9.1789336880100; 
 Sun, 13 Sep 2026 15:01:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a334bac9sm21074531fa.28.2026.09.13.15.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:01:18 -0700 (PDT)
Date: Mon, 14 Sep 2026 01:01:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/dsi: Fix setting completely bogus rate for byte
 clock
Message-ID: <ca3it6wi432z6dp2vrmo2tof4zuxdstj7wutoudzcjfmdacbrn@x7rwkvve454d>
References: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
 <20260903105241.41C2A1F000E9@smtp.kernel.org>
 <de3e9d23-c55f-497c-9d82-caca692d2f66@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3e9d23-c55f-497c-9d82-caca692d2f66@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMxNCBTYWx0ZWRfX3D6l+9jPO94z
 /QLgCn6AHdYef+oEjhPiW208Z2fItqA9NKl4i55Qdf8hOYvmqOT/THmlvcbCiiMJkBVB5xIzG16
 X1QW5Biy1mjGBteSdDFuqHdIbYQgZBgkDn+gscO+mJc4QwrjEBXAWN7soHrmzrVOWVZkyDeKQ00
 4NdW2F06l3Meu5A97mi+3TCtldzqcr5SJYHrsGSfXi8yPQajpWRpEV+OMkttYvRMspILAKpHmMQ
 zxBxBSxAhq8kPKVnHZN1IHZr+MTtm/ccOyA7NlX7biuprMG8yzW/s2A+R5IazLvRcs9bnk6Orl8
 ANOH6+LH9Z+s+ndjw3iMSTmPCDJOHVZrLCJMdVdFstkAAxo6SPKEQB02dawVf4CrzL9yMyFx8Jp
 0wIkP/EDoEpZKv0/FpPuygENvWANJOdeePazhC7POEmdHBhQtkOrxJAq22qHQ5FhWHrRydpvEJ4
 m7mCdk2CteLvodqBX4Q==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa71d31 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9kEsh1pE3Zk3MPBAzk0A:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: _39I3v0AEp1eVbRxzf2hJ3I7_Rue6sG_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMxNCBTYWx0ZWRfX0IqnsKx+zevo
 OrsU3ENkvqIE+6QAGeWw2DfOyoK60YhVmTOM/av2Lin+YWTDv6Z5FeYoiXlblScmhH+czolIIcG
 WQjWSxudRB0N6ygHoIAot6tZIW5//Dg=
X-Proofpoint-ORIG-GUID: _39I3v0AEp1eVbRxzf2hJ3I7_Rue6sG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130314
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

On Thu, Sep 03, 2026 at 01:02:57PM +0200, Krzysztof Kozlowski wrote:
> On 03/09/2026 12:52, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Reverting commit 6cd33b6f4155 directly reintroduces a panel scanout glitch on MSM8916 and similar older platforms during runtime DCS commands.
> 
> Obviously. The problem should be fixed other way, not by introducing
> incorrect clock rate rounding breaking other platforms.
> 
> That commit introduced regression so it gets reverted till authors come
> with proper solution, for example.

Fixed by
http://lore.kernel.org/dri-devel/20260903-fix-eliza-dsi-v1-1-3474a6c9f2e0@oss.qualcomm.com

-- 
With best wishes
Dmitry
