Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7611C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17EE910E4CC;
	Tue, 18 Aug 2026 03:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2jxQ239";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDzqeLxA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CC910E4AC
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:32:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I28TvQ2884756
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6jrYo2RZtbsIDb/KF9qa9avTbzl1dNVpFeA9zuf0xzo=; b=b2jxQ239rA/pNoAP
 5M3cv5Txn600212XZtTGjjas3/wySQJZ5YxWlf0bVRzTO5C9uSYPw7Th/gf77jQv
 KRMGuvoMUv5ECRYtyFJ8kKsiwnT/69Y+NTtZ+vvmQmtU5+mMDqKuisK+vbTjM37h
 kA85xUdcvjLbKm6D4YCRoGSkpk+evbpnOqPETnL/bOqO5997GFZPUIcfHMHYon6N
 PiyEkgdhTW9tUdcE/bIGeByH31YC7nM63E3pLtPLN2dD0MALwYOkFYfDNmHZM4FG
 nbeUa5BgQRUdicwZEwPgt2tEvv88aoxG7ipnMCQAiBkUcFX10Ygf3qAXe44n1AxX
 qA9XHg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ebprasw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:32:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936cadb0e8bso355166685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787023969; x=1787628769;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6jrYo2RZtbsIDb/KF9qa9avTbzl1dNVpFeA9zuf0xzo=;
 b=XDzqeLxANbXDYDeNz7rHiO0Y1A3AC2GoYc1KgPR1MO02NGQGReMlyoQiMo3bm4Sjjs
 CLaCZI4Fs1oW+zKRjxqvIQuRoayTuvf+YAiJzWLaxeqfdISChiSkdQOX33qumpePxwvU
 6aaX3cAKEswGcI2YDGNdPo2cmcju229m1cI0EIQ9qas7W5CuyrB6uYeeCf/7bv8inDwJ
 G2qwjRNOKAxBa9tVvXW3pdUJ8j7jVs5oDtjPrbjmwfSCnIutFfOFA1r680lxnXzS+Fk6
 XHyUhgqaA63KeWKHPJhKhLC1pJJBb/MPXZpTvxeAXQeeXy3Sv6nJRg6CfnwZ5m1adEb7
 Iivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787023969; x=1787628769;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6jrYo2RZtbsIDb/KF9qa9avTbzl1dNVpFeA9zuf0xzo=;
 b=WAIWjfJaFAiroGNNtBxXEC1x0S+5owfrvo+6Gq1OIv0vGzYOY1jFzZv1MBXFSarHMd
 fvZ/P7iNcUq73IvGbhBs4L3bSSv+qeDAThkMBWOIZ1c2efbMjBRukA5ZaTQvCK87rTRF
 23gPMeUISBg6XifHykDe0bzkvF1uCCLK4tcChMivEGBY4pcZlSyjmj8Jl9t4ypYIIYUj
 hyeNRBqjhDyjbk1XtgQKs89Up9w7ArDE+WYD1x0vjDAQMhJ4gg8FxKvWQjWFdN1nTN3m
 /l+QvlMLYm91W4OJYSnnw/MMrYEmv32UgLZjY6V+ypHq0XNl9orW5qaUuffavMF76CQd
 aHzA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVJ3ox2R/tMKWQeJ3t960tRINiFRmxRJNzM/kg8RvrIFNqexJsd5sTOW4eoUe3kGteBn+FKAZotTM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhZoNFZ9sGBpJDWRCqCa8b2wbd2+Mroimkw6aggt9c51U8OpMb
 xWXhK0+/Icxa8y3Y9x+Z1ZCUedAmatlSZL5S/QvZigAHDc19176gU0ow+F9IQilfZspZaGJU4T7
 6OfroErmHZIGl6FFDvsSCv1X0wKKd1XPcqn2RcdMVIvb/R+upz94FzhzYduYC8TqALTaYZHE=
X-Gm-Gg: AR+sD12O9Ozyu7KQRA1G69OSStYdf3qfzOj674AgaKQVkolwfRIC+wXS39A/6tUjLRR
 ofLTKGCBWJTBXtCxYdQ1+eTBZHqmzebmSL1WLHqEjDFMaao6qw8ZFC+LBUXXDPIqa1poBssAqaF
 EX8rHy7dblqEK4hVWQoXfduwAILe4n5ZtKb0TxC3yejewKhxVaN/ONrrVGAdAUEGw3p5AiZyLCZ
 ErDRZhuQshO/Iw29AtfxqpmfzSncvugZg43T6UElg5MIj074hqeBr4b8IHLaXZPHBpp0ia91PQL
 Pkx4E9zOH4EvcRoYV3VJ9/S7yB94+eCSH7xd8j9Foro4PBauOaRDM8YuZXEdugv/dspuDKGMyAr
 tu4zyXM7ZSXhTdhcTLjF/XTjL6qmdDjLGsYRbQJesIZIAf9oI60J98Ih6BvCKsV874+fGwMG0vr
 ENuxnIjb503PPt
X-Received: by 2002:a05:620a:720a:b0:936:695a:185a with SMTP id
 af79cd13be357-936d2356e91mr2661691185a.44.1787023968545; 
 Mon, 17 Aug 2026 20:32:48 -0700 (PDT)
X-Received: by 2002:a05:620a:720a:b0:936:695a:185a with SMTP id
 af79cd13be357-936d2356e91mr2661688185a.44.1787023968128; 
 Mon, 17 Aug 2026 20:32:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cffea7bsm846691e87.50.2026.08.17.20.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:32:45 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:32:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
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
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
Message-ID: <6jwrfg2vffra5dlqrp46l2ehtmwhfguu3s4acfixiue2p2ei3w@g6k5wxdmchh2>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
 <53a32af5-daa8-4a11-86c9-10b1fbf01566@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53a32af5-daa8-4a11-86c9-10b1fbf01566@oss.qualcomm.com>
X-Proofpoint-GUID: _PmRdb1OuI2mjcZvlioETbT2O0H_WSvM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX7/c9k7gaXwIJ
 d+xK1dEqo7UptFw1c3qJCo8CcEaREIa9FDXW26kZRFtGzZ/YrFmWete2mKb8be43DgFTAL5hyuf
 OxrUen58IQSd0EzcNzYfmg8uJQJJugLXkkgX+oqA36yMfvA2o3aD9TJ2tXfHB2M2Vsx+fH6cf5W
 J8gzUT0Z9gv+pCW21lYX0obnBtZIBhAAeDcFCW9E48Cp6r+5o5wN/Tf5Hr1mqW0yLJ7GgZa2MvS
 T6xSp2f3liWEdkd9YrHce+jLWhJFYcGfJ3DCVTdue2CQ4varUaTN3aKdwKWoNqfaNxqWekW2O8u
 8NAELn3xK4SmoZ4cpHmQWw4MFUARIkNn2MQZz558w6NF0s0sDdmi5zg5qlRVMPl3OllwZiQj+SP
 bKsEIRVbHsxN3F25C2BHlgH72NMIIkNgwZtLwG8p5ocieNrTINL3ZPg59g+G+J6phS56a5TUSzf
 aRRL7Dbn5pG71BDO3XA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfXwDRalc91LYwu
 H4SxOM//Ps5Ly6mwsX5qHiEtA7iK8Sy9MQgXXnSLgHmFrbthmbcc6WaepGZvegj0/dSiWKNeEip
 h0duQ07/NTVSYkpoLTHmTffGwVeE7PM=
X-Authority-Analysis: v=2.4 cv=FsU1OWrq c=1 sm=1 tr=0 ts=6a83d261 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=F_vBso_8M4dMwCL1aLIA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: _PmRdb1OuI2mjcZvlioETbT2O0H_WSvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180024
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

On Mon, Aug 17, 2026 at 04:12:51PM +0200, Konrad Dybcio wrote:
> On 8/13/26 9:44 AM, Yongxing Mou wrote:
> > 
> > 
> > On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
> >> On 7/20/26 10:43 AM, Yongxing Mou wrote:
> >>> Kaanapali (SM8750) and Glymur use two display power domains.
> >>> CORE_GDSC powers the main display hardware while INT2_GDSC
> >>> powers a subset of SSPP blocks.
> >>
> >> Can they operate independently? Does INT2_GDSC need to be
> >> powered on after CORE_GDSC?
> >>
> > On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.
> >    - CORE off, INT2 off
> >     - CORE on,  INT2 off
> >     - CORE on,  INT2 on
> >> If so, perhaps changing the clock driver to make CORE a parent
> >> of INT2 could be the simpler solution
> >>
> >> Konrad
> > That would still need DT and binding changes -- DPU has to reference INT2_GDSC directly to gate it independently, so it can't be hidden in the clock driver. The two GDSCs have independent GDSCR registers with no HW-enforced sequencing, so they appear to be peers rather than parent/child.
> 
> No, if that was a reasonable change (which I don't know if it is), the
> genpd core would take care of enabling the parent before the child, since
> the genpds are intrinsically hierarchical

That sounds like an interesting quirk, but then I wonder if we end up
spending extra power in cases when only CORE_GDSC is required for the
device

-- 
With best wishes
Dmitry
