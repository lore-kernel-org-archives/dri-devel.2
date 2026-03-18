Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195C6FED9E9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2D410E666;
	Wed, 18 Mar 2026 01:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/82vxHu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kQiwFHih";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D962410E69F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:03:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HIJqIT3165228
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yIlQdBj7BXbUgc4O6GDmZgOdn2kMfUU7P+k7WhdvKGM=; b=U/82vxHuYb/Vapj2
 U3pYze/W0oIaat5trCvzJLtSNNqpHT9gaQ7QbgbuiotLU6eUW4Hw9tinXPh6f4gi
 tSzCukz7x2r5KTNBVpM8Mf8wWJgBULSv9ZyzFS9ogA53y9Y/f0jF4ehsbWdt3chh
 f2BusMuCdDscD9d2XAXjLZgkmykEZoXEdZEj5WeWCtR0s0LB15tVtMmKx5MAY6eB
 tQMq//uBWDIca+FTzCz/s4bC1nPGE6SCPmhtr5fwfZdDQzORg508QDp9lF8RRbho
 zsRM220uG6TQ6RyyCyMoez1g5poJJNGnCAXOMmXsZ9uN1zcX3/op+eoBrN0y84GD
 QrhHig==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy4v6u30p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:03:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd773dd39bso4755528185a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 18:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773795815; x=1774400615;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yIlQdBj7BXbUgc4O6GDmZgOdn2kMfUU7P+k7WhdvKGM=;
 b=kQiwFHihYNcGwLOP5AAWIcrJYm1EQlx8vschCkYa5ODR6C8dzguqkvC93HiATcBmBp
 oEb5JV5p9shblbIP3K9k/Yyp0qjWasEyGA/Ve0CUQstwcXBdKHbQRvPojS5slXyaTSQv
 8umFI+OFFTaD9iytuYPAEQSAEvYc5q6VUhU/XG89UEQfe5CkjEtX20XBUxNdlYRrTfJV
 vE5JgngRqIw9lkuoEB8DK2yrWM6Iq/MNy7h4aCGkYTk0NH0OsK1xTwVqbhN4A8ojeNRV
 CgR2ixXh5rXEqW0utdcHBvnf8DdtSeOZKSr+qKIgrY0/pwF/J/deGTvgrn3OvTp+lPd6
 Ap5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773795815; x=1774400615;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yIlQdBj7BXbUgc4O6GDmZgOdn2kMfUU7P+k7WhdvKGM=;
 b=SbS6bjrFkQL+hfiBFCIRsm64Te4kuyJZTalEr4UZGrmDZkXox5+T8uWMgTpnlkU9I9
 USc88cUUYYv0mKHJYJ7pna6wM1yD0IUpbV8d0j8Alb3pnEmbSvOsP/HcTKqLca2OEkEk
 Wz34wW+xVKLt8kQ1zHMJ1SXlnHS53JK8M7KDBFgJVmInEtlfr6JhaISrcyWcn2YgFf3I
 ICXtZ4Ilds8ES2ZiE253nsxM0swpMtqd8N7QTCw4uoaJJk7iq++oeGj0c1oifwxQeAFh
 2isYOGPXGXTM8RTNg8WBIlQxMkvjgXJDOv2L2f0blT57nI2dWtRVmNuV222vxUoAcO0S
 NMwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFR77QSB3cLPZch6dCVS/NW5QgLbE9OgnZMA8Ht80dbvKH3RibUbBZzHF6puYFBeFwbvDu4oS1OmY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqFEs8YmKlUYr7gUkYHMlft0d1AAR+Pa32M7TwFFMCOOLxGqB4
 r8A3M/+meoBQdBFZQWv756U5LfCbA4Ak19f6a1VreL+vUPmCIK2GFCSt0ZXbuJYJobmgCio7YrX
 dkR2NGbh48DcDqH08Sgf57ZSNbX79SATT7OXZogRIzZeL2RgQ2P4W56FEbN1lQVFvQBvdXTc=
X-Gm-Gg: ATEYQzxTJZSzuW/EZXp0tevKZDwgk5u3KfrEYKcayM1+U3CIZDA6BdkFMYAWWMoy+ZF
 rsEKgMdFzHN8D3IbtQjIC5vcANUKAvvNigamlrFu0wtPYH036vxYZGj1EcuAcrJh+xkt1e8ok3q
 9+edfG4Yk4+WkwboLgCmVwUwji1BwLk1nhz+iIhjFX/3msUOBAn7/qm5WH0+9kGKMpGy4IHLBfW
 /uby1V3Lgkzyup66bpaFUL/DuYIeKZfttcaeEV3hqMQ9j34QVAHbOgBkOd2+sP+5FJkYH3fT+95
 eJFtu+rV8eGSqqvensYdBCOMhaVgz3hwsutaf6vhsMcur2l2v0a+NMpmxzCwpEb7CP7eovLmlxS
 nOtj5rvBCyDlGKl2R7sHhWb9Ibt2/s6pr2+Ds8NGnLgNoWnAj2O6OhYBdZ5h3n/bD4YmFDzfFVU
 ZbkwmVzTIwrF8wKY5drk4s7CTX/DBJWjWlL/0=
X-Received: by 2002:a05:620a:4444:b0:8cd:b52c:5989 with SMTP id
 af79cd13be357-8cfad3dfd60mr243211185a.74.1773795815163; 
 Tue, 17 Mar 2026 18:03:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4444:b0:8cd:b52c:5989 with SMTP id
 af79cd13be357-8cfad3dfd60mr243208885a.74.1773795814645; 
 Tue, 17 Mar 2026 18:03:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c6e1adsm194154e87.49.2026.03.17.18.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:03:32 -0700 (PDT)
Date: Wed, 18 Mar 2026 03:03:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
Message-ID: <qr4anmqwa5imhx2gsftggqitasqdhr4bpqimn3e74zj5csgtvy@ozbsty6o33vg>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <9c4dad2c-25bd-47d2-bc40-9b551d023615@packett.cool>
 <a6190a6c-60ae-4d24-b396-089f3b42973f@packett.cool>
 <itszs6eu7l2zix4stdiokftgxjpqlfukbqbdg4u3sestln6pgl@yq3wud26vi25>
 <38e87937-194f-43ca-ab27-a3a9cf7267d4@packett.cool>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38e87937-194f-43ca-ab27-a3a9cf7267d4@packett.cool>
X-Proofpoint-ORIG-GUID: EE1JdSgxOm4L2ncGKbl_uXcFqCiwuE56
X-Authority-Analysis: v=2.4 cv=Aa683nXG c=1 sm=1 tr=0 ts=69b9f9e8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IfXTajCwNyicoHrbclQA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: EE1JdSgxOm4L2ncGKbl_uXcFqCiwuE56
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAwNyBTYWx0ZWRfX1A9s8aOiiMmy
 jAIdFcm9ZWPbQJ+boOqKm2NlvL1dvwzzY5d5h56oBqmznW4K+Kxg4C8cRS0qMilmDyYa5E2ae+z
 evRlPlmbKV74t6ATIpYXXCwBwI0F/hcFItYU9D85UOGtXNdzStxmnigdrihaOXG7Ei2NIH/nV6T
 IiFwEApZkA6IkjGmVNiJZbpGFc7cTudYLEG7RTPUv5NShrGCESjvTi9pw39Zu0o6x/PFHtExSgG
 4SST1Fh329bln7e2Y6A1G+AcB6QvFBYXVBA43WnUCX/S6hJh2ByK5M50djUrl302lt+A/S95OYp
 W3+MtmXHbvzuP7Ft9rfckR0zBIXoMxFJsnvvBQALEm31rFROOQFYvTLFAh0CSOAKld5ulWl6cNK
 fl2ImT+l1l6EPDJRd5/VuRLBPOW36ce8cAB6a6K+gqQwvtnBoHBALBDeXoQWy+SVAaDc/jofmf/
 VniA8cd5sfuLAxJrihw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180007
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

On Tue, Mar 17, 2026 at 08:15:54PM -0300, Val Packett wrote:
> 
> On 3/16/26 12:23 AM, Dmitry Baryshkov wrote:
> > On Sat, Mar 14, 2026 at 10:10:26PM -0300, Val Packett wrote:
> > > On 3/14/26 9:51 PM, Val Packett wrote:
> > > > On 3/13/26 10:09 PM, Dmitry Baryshkov wrote:
> > > > > Currently, all HPD interrupt handling must go through the HPD state
> > > > > machine.
> > > > > 
> > > > > This has caused many issues where the DRM framework assumes that DP is
> > > > > in one state while the state machine is stuck in another state.
> > > > > 
> > > > > As discussed here [1], this series:
> > > > > 
> > > > > - Removes the state machine
> > > > > - Moves link training to atomic_enable()
> > > > > - Changes the detect() behavior to return true if a display is
> > > > > physically
> > > > >     plugged in (as opposed to if the DP link is ready).
> > > > > - Remove event queue and move internal HPD handling to hpd_notify()
> > > > > 
> > > > > To correctly detect the displays which are plugged on boot on the boards
> > > > > which use dp-connector devices, this series depends on [2]. USB-C and
> > > > > eDP panels are handled natively.
> > > > > 
> > > > > [1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
> > > > > [2] https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/
> > > > Unfortunately this currently seems to mostly break link training with
> > > > USB-C, on x1e80100-dell-latitude-7455:
> > > > 
> > > > [  102.190083] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link
> > > > training #2 on phy 1 failed. ret=-110
> > > > [  102.192846] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link
> > > > training of LTTPR(s) failed. ret=-110
> > > > [  102.211095] [drm:msm_dp_bridge_atomic_enable [msm]] *ERROR* Failed
> > > > link training (rc=-104)
> > > > [  102.211164] [drm:msm_dp_aux_isr [msm]] *ERROR* Unexpected DP AUX IRQ
> > > > 0x01000000 when not busy
> > > > [  102.247168] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link
> > > > training #2 on phy 1 failed. ret=-110
> > > > [  102.252859] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link
> > > > training of LTTPR(s) failed. ret=-110
> > > > 
> > > > [..]
> > > Actually looks like that might've been due to having applied the [2]
> > > dp-connector series from above.
> > Interesting. The series only affects dp-connector. It can't affect
> > pmic-glink usecase.
> > 
> > > Removed it and rebooted, now plugging and unplugging multiple times between
> > > the 2 ports works fine.
> > > 
> > > Except unplug is still not reliable, the "ghost" monitor often remains after
> > > unplugging.
> > Does the patch at [3] fix the issue?
> > 
> > [3] https://lore.kernel.org/linux-arm-msm/177362655076.7429.3868048981197120360.b4-ty@kernel.org/
> 
> Yes!
> 
> Overall works better than ever now, looks like I can unplug the cable with
> the laptop closed and then open it and it's all fine, and even play with
> dual-role / gadget mode USB and plug the alt-mode/dock cable back in and it
> doesn't crash.

Tested-by?

> 
> Still, rare link training failures can happen, e.g.:

Thanks!

The link training is one of the items that I want to check next.

> > > Almost nothing is logged to dmesg, literally I've only seen this line once:
> > > [drm:msm_dp_panel_read_sink_caps [msm]] *ERROR* panel edid read failed
> > You might want to use drm.debug=0x100 to get DP-related messages.

-- 
With best wishes
Dmitry
