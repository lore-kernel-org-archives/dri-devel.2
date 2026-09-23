Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D0AC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E764610F12E;
	Wed, 23 Sep 2026 20:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NRPJ/LYX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZDGLXgtz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6311010E355
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:58:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NJlE8a2900313
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ov2H0d6cnBTnjw7zlHO6OeG9tF0HJ7AcJiwrP6JidQk=; b=NRPJ/LYX0U54OgoJ
 g+VLOhVg3+gUpxMhVOirA+IR+q22MtJdnylA9VJX2oDP07y5UqGO3L9PxrnaRy6U
 3JAUVFOt/t44h3aFWJzE2MbhDLY47uv7A1URB2720RIRUXx2YYP5nJKRNNyoqhI9
 xapuPAdFspqTsJZ3VsEDk9pwu1wQ/vSG5bxQY72GihUD4pznEJFoQemg16NgQv6k
 17+piWr3c+n9ovlf3lEg8nSZkK9V6GjDm8zhHnyzennnBuGoPqml8jy+941vxpWt
 4GuTWZj06Ggot9Pp5RJ0dtZQHpXKPEu4/Iqr8tr4PVoyb+JwJLYGRNw4G9z4Rzd+
 Psc0nw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv1ygn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:58:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9393ac4961fso174646685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790197136; x=1790801936;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ov2H0d6cnBTnjw7zlHO6OeG9tF0HJ7AcJiwrP6JidQk=;
 b=ZDGLXgtz+ZDn1wnVwsfKSlNCawpkzfn+Mz8YxwNzq54uebw14PtUrBmzvoucWnZzyY
 v8Polm9YD+TJmw8WYm672ZGxvAdIw8waIERkkQeZRtnpv/2hyBouggGwwewg1aDH47RT
 1acEcNt072IZH5ztyj4vmxzldRF2mJi6Jigy48S5NyBY7b7OMIM04Q06Tp7Xs/TtlEmb
 eiKGFMPadS+oCbGHOycqdiiwwz4ms4uHm0Mharzms9ey0uRpqsyH3gjsZYk5nxEdTGWm
 As3a5Xox5w2l3qYeK9z7VszW4cfXewp0ZUCNa3faEcLiOoqpzlSXlctBaaaXRd2KblyV
 Yz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197136; x=1790801936;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ov2H0d6cnBTnjw7zlHO6OeG9tF0HJ7AcJiwrP6JidQk=;
 b=kpXjWaTMSga/7nn2OzqZaHIPPTUgeECB746Z+W+voPrfXRWhslPw32Qp97Apjc6X0h
 Y7TtCd6XEW4/d9d4CsnFhiDH/RZVQt77K3n0YmWmaQmbnGCfxsvVkI1xtofhJNM5ichV
 NJdDztNcnTUJDzSdPorimfVvqjpWLAm+RpJj3uB03VAbI5ZAjyHFukgxQCI4LoKsfQvY
 0A5lHWwfBle/IrkUmGIwucCmMvbuq5QFItftAI5FwXvsvevkfRfzAdAK8MtQrmPdFT+z
 nZT1fBzH0Ds2zahNuG9kq0MqfeQP9zdnQRWbR0Z1wF65x74ReQUYz6Dnps6BlAo+DzeY
 JntQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgxLAXwd4FaSB+tjyxaehTR/x4QerP1v2SWtea0+CKOYAu90RTx8mcgcqmsrJQR8ArzXk788kZQU4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mNKpJLqppS26/V8bDnlm17Bt4qYXnwSsCwTAb6SuiNQ9fZXTwP
 l5qD3Pcz6NSlfLiVotGjbEF6jvCAxP5Z6WRRus6qqnpJi/e/fGqIZFr+oWkDgpXGE2WyH2S2g0T
 Vj9RalBY5soDWQXs88hGsochMLI1+W9amQ7PV6vTAji4J6gAMMvtoa7Fs4E1tPcQsJJFZgL8=
X-Gm-Gg: AYBFou3tXubQwspKcR6aOvDXqFsVesCn/exigpNRwNvEYKFHyhb9hBPN+X1XOY/94FZ
 aDBjmZROoBiuTXqgYRUWEt3K6ieEAGwYtDbzLYVMBoEAgtDtQTqHMmE4tE0/Rat96ujbDO3OGsz
 FysVQivURlGMAFcHkHnZOGQfZK25tK3bJgfaeAdPofSJZ9MXMxh0E4Lza9PFpB1qRCua+7YQe67
 5//JdTjYpofcX37OBP++T5RvXedy2JouucyUK4des7Kpt84i2/5onKz/CH9AisVVq88RNmeYlVI
 2Y44tImV8e+gRXEDLnz2MV4cSzsX5yWKppNNU7Fv1wx4aXfdbYF5H48oI0SUIqqW0REWra9h6CH
 BD7Vg4UEouDYIrCbCrJ2u0D249pQwe8SLr6Pmy28Z0kzgmDhewQKBed35alfa5Zsa2qL7mtDoWc
 Gnt+nqw/AGYLwm
X-Received: by 2002:a05:620a:4415:b0:93b:d7a2:dd32 with SMTP id
 af79cd13be357-93c348282c5mr60118785a.66.1790197135649; 
 Wed, 23 Sep 2026 13:58:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4415:b0:93b:d7a2:dd32 with SMTP id
 af79cd13be357-93c348282c5mr60113685a.66.1790197134958; 
 Wed, 23 Sep 2026 13:58:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d9b9972asm705666e87.18.2026.09.23.13.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:58:53 -0700 (PDT)
Date: Wed, 23 Sep 2026 23:58:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 vishnu.saini@qualcomm.oss.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL
 init in bonded mode"
Message-ID: <y64m2frbbg67zfukyuuds5cx65fx3rjxfujbckoerv7sswhk2u@i6p4k3ul4aec>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
 <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
 <wrhuksrzlxw2pjlvjm37dwjuztcv7qs5t6mqiav4ujecwqdkwj@ozbfxpbgaimt>
 <CAJfMnmEVwUwt=wMJ-8HKH1yz9+erWLrRGB+6wVYCdSGDK+_T_Q@mail.gmail.com>
 <114b9be8-1fca-4762-822e-1d53838d5de5@leemhuis.info>
 <o64cxeq5f4ffqpdmbai5cvsmxei2cnw3p6acvu55xl3cj5w3z3@6o6kokszvng7>
 <akt6z1irWlXA5UIy@hu-mdsor-hyd.qualcomm.com>
 <493b8d4c-164e-43c9-93c8-40cc251b1c3b@leemhuis.info>
 <d7v4kwmc42k5ymgdt4mn2qc7dkrf5jj2l5afgyjqrm3pxterl4@guulk22xwlzs>
 <f77e53d3-fb80-4832-aff7-4ab1244ee4a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f77e53d3-fb80-4832-aff7-4ab1244ee4a4@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA4MyBTYWx0ZWRfXxCI79DuAQRFK
 6N7Pisf6e/HiFJ/vc3WkKGC2bENWQyii2gjBAWyXVhxq6KSGdIU/PozZQHBiJVTR0+SHPxPnPH3
 dBP7xI4GpumWN/lYLav6p2uqZ6vPfJruBi9hd2kAc9Xh7jsSJyZ0iQb8OXTJOZB9bEgeqlkh5yT
 fo/DOc8/VI82H/cTNcAIZOAFWgcNFrH1fb9QooCgShdi8CCa6tYuu0FXS9+FaJpA8FBMyH4JHsr
 V8XgXShWK6p1MsIaGgUwDGGqkeVtfvEnjPy3RDLISjELJ1qqmnGd5NTduH8gl6ggeiurekjO+W5
 llNBqZqUmFMhStQZuQdibntQLCx14tBTEEbpfrWgzd7K+wUhw0JFWrPuKluhm0DqWDLyqQ5k1NO
 S1II7hxWOwrhyDPz4vB4QRDMUWtfiOFuoHNYKenWF4JBuRfYfKcTgwhgX0G3T2RUsDslZxkByhu
 E2P4SKNuQOnXyBudrpA==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab43d90 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Gbw9aFdXAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=f6ktmeKAyBHkVzSEkbUA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=9vIz8raoGPyDa4jBFAYH:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NwXgi6cNPY5XzfS110D--irEHJRsOLPq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA4MyBTYWx0ZWRfX48WxwjAv3LFk
 6okxbrOptibGWk9W7Suedbp0UDKdE0HePvT+56ceTp1azqtaWiVeT68Gk/vjPKrS3P3HR+uUE3a
 HigLnL++eIUsOcxLWB5lOl6JKRd0ws0=
X-Proofpoint-ORIG-GUID: NwXgi6cNPY5XzfS110D--irEHJRsOLPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230083
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

On Wed, Sep 23, 2026 at 12:48:21PM +0200, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 7/8/26 15:31, Dmitry Baryshkov wrote:
> > On Wed, Jul 08, 2026 at 09:26:04AM +0200, Thorsten Leemhuis wrote:
> > > On 7/6/26 11:52, Mohit Dsor wrote:
> > > > On Wed, Jun 03, 2026 at 03:11:34PM +0300, Dmitry Baryshkov wrote:
> > > > > On Wed, Jun 03, 2026 at 11:56:15AM +0200, Thorsten Leemhuis wrote:
> > > > > > On 5/4/26 22:09, Mohit Dsor wrote:
> > > > > > > Sorry for the late reply. I am attaching clk_summary and reg_dump in
> > > > > > > working and non working case. Lilliput is just a normal display working
> > > > > > > with hdmi and has 720p as preferred mode. Yes, I was talking about RB3
> > > > > > > Gen2 only.
> > > > > > 
> > > > > > Neil, Dmitry, and Mohit: what's the status here? From the outside it
> > > > > > looks like this regression is still unfixed with nothing happening for
> > > > > > weeks now. Or has progress been made and I just missed it?
> > > > > 
> > > > > Thanks as a reminder. Unfortunately, it takes some more time (and I've
> > > > > been a bit overloaded lately). Worst case I will send a revert soon.
> > > > > 
> > > > Just wanted to check if you had a chance to look into this issue and whether there's any update on the investigation from your side.
> > > Hmm, no reply. Given that we are entering holiday season and are way
> > > past what Linus expects in a situation like this[1] I'd say we should go
> > > for a revert, unless some fix shows up really soon now.
> 
> Sorry I'm very late to the party, and checked again, reverting this breaks all dual-DSI setup
> on SM8650, and probably other similar SoCs.
> 
> Here's a complete log of the breakage which appears on the Ayaneo PS2 running v7.3-rc3 with mainline panel driver: https://gitlab.postmarketos.org/-/snippets/65
> 
> I don't see why my fix did break this use case since it reverted the way the dual DSI PHYs
> were initialized to actually allow the dual-DSI setup.

See commit cb55f39bf7b1. Without PLL_SHUTDOWNB and DIGTOP_PWRDN_B most
of the PLL registers read as zero. Currently the regs are handled
correctly (almost). With your patch in place the SHUTDOWNB gets dropped,
making PLL loose reg contents (and return 0 to CCF as the selected divisor).
Current code depends on those two bits being set across host_power_on.

> 
> Thanks,
> Neil
> 
> > > 
> > > Ciao, Thorsten
> > 
> > Please send a revert.
> > 
> > > 
> > > [1] To quote Linus statements from
> > > https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed
> > > 
> > > """
> > >  From 2026-01-22:
> > > 
> > >   But a user complaining should basically result in an immediate fix -
> > >   possibly a "revert and rethink".
> > > 
> > > With a later clarification on 2026-01-28:
> > > 
> > >   It's also worth noting that "immediate" obviously doesn't mean "right
> > >   this *second* when the problem has been reported".
> > > 
> > >   But if it's a regression with a known commit that caused it, I think
> > >   the rule of thumb should generally be "within a week", preferably
> > >   before the next rc.
> > > """
> > 
> 

-- 
With best wishes
Dmitry
