Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7926C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DDC10E5F6;
	Wed,  8 Jul 2026 13:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBi8AVUo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eFNy4et0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABEB10E5F6
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 13:31:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3EM92792281
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 13:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ef2H++Akvc3hms2OdUr0P9OSH1mzQR4iDT2y/4vbjtg=; b=IBi8AVUoYI1UJ4NX
 Xwazn1Ht6CnHOA8FVZ4a9oDHrLU7UdsNrEkAMJXkGst23mHBI/hMSRe1ycfAKS2D
 P7inGgzUz3jKrTekjP24xFtPK/ufRZBW2osW2Hl07vjJMsJcHGyqwK1z5BpflgOs
 I/G8RPQbehR1IVNF0Ak6dQVW/sKdU0NE+e0/ARq+C6OkjJUr5pHDmaSdalfOBjTE
 FBrzwO4815CEZXVwt9bjSYL+RcoGWaRWaYhp6QW5o4XQbBB3W9WaV4F0XZ6bZ7R5
 hnQDeRzKyuMmAggUz55MMfffU54PcqlpQZYZZBySu6bpsZSDPeMeQfy1SW8UMJgh
 CMjd3Q==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswak76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 13:31:43 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9692595fe97so207122241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783517503; x=1784122303;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ef2H++Akvc3hms2OdUr0P9OSH1mzQR4iDT2y/4vbjtg=;
 b=eFNy4et0sn+d9XqV82sXfFXvQzRs/M97QhMy2x+wnmDrMEuIMfzFyCAu099hRmsrQN
 S51Sld4DtdZa73JDjDOy33j6VyfazB6g22puvCBEgBOsBymRs6N3iAVw+9KBK1KDqMOz
 Ni6t8VZP19+Ksm0RNKYSCp2WnQ40HRLY1JhEIw0i5131w83/bhrNnUmR4fDnJN3X6SoI
 9yatG7W1t6+2/lUD4cFQfrqCkUJ0UCiPeXOaboTzr+QcIUPre+dSLIdi9sT8M0VfME0+
 U2ah14+VVrCgsrVdsCgdkgzVV1QcBgyOIAhDyceDV+kN4OT95rebyfBqDfEDQKdJkjHQ
 HlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783517503; x=1784122303;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ef2H++Akvc3hms2OdUr0P9OSH1mzQR4iDT2y/4vbjtg=;
 b=jfv4dyK8y/CvX2nwaOsVsqBPZpjWYk/4hIWAD+kRAYkOUtxUdDg1C3y2c3d9rMljkb
 3Ir1juleDNORX+qCvTb5rVVx13HkhUXyPdH2YaBYyIbMZdskHKq+zSTZjZVgfOOgiXmA
 vtgwN9vpno93gKZGSIS0Or7Ud9dXeMUUiTT+RpboxNfyMFk45EXtsqgaIwHP0gzgBr4m
 Xf5NYKl5VrEp3WPisHrsihefqdCczPGBsdxEFecX09VTJC4ksMm9F5kHHJQkgDjjP9el
 AQIUXymc8czZVz/UIiewHv1nAzA/wIO3X0/bwIFgTINB5RcKyjJ/aBYRciVWWVrr4oiI
 njZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4NBWE8Ub6t/2XOj5DJZgIS/lbRyU5CsJAYNS6yws3+qirp5WE6ApVA/mOnaTCkRKa5ogYMgH3SS0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoMgnYBM6srnb79MWlwBimC60OZcPVDw0I5F5XI5GCueUNTofu
 jB36ZOrfG+SCnNwJ05/SCjJbL/AfMvXNdiVLlW6BMNRSiubU454+T5zjFxchiKyvAFNj8Nc69u5
 3jGirI4jhQ098JshpOe354KZve9QRDdSyf8xdIfvItSHVgdi/fsC4rUWzC8Tnrg3YpPO9anw=
X-Gm-Gg: AfdE7ckv33/54nbUNdYz/1jgJy07oRsohvF38vUhb3bBcRwQbp8L5BeTXl7LV9FeIYl
 fM0Ay30q5S1EnyFOwZ6mK09NYj+HcnhPqGinKjfG85x2m8mP+7sjM8MmG3/Gq/oMg87GoDIrM34
 2LvBvUo1gEzBXX3FLRu+Yx5Ur0n/3NPpeohRwwQcLUERqmg1OWdp4xWHF96uEXtqSUx6+6TFhl9
 gLwX0UjjukgnSIeulXGsqq0EZ/oQpw7D16gogXse6WnYePigDclbGmDDucQvzOePYxlpPVFLdFC
 z1rlJ/ESFidL7jhtmuTWguZVAjQOjVFf0rJ5KuOX1kFYkU4wAbCuaERw5OCdds9t9n/Abf0aY5r
 GHwfL4mraLlj9T3Mx0ri0OMQOIgspcD7fpn8TYiS/7SHwAANMmrLumL6+F1CmtGoOs/+JK6JK0z
 6r5/xFFmSTJnkw+rKXrP+RDJT2
X-Received: by 2002:a05:6122:4d02:b0:5be:2177:70b3 with SMTP id
 71dfb90a1353d-5bf75e7266dmr991026e0c.10.1783517502619; 
 Wed, 08 Jul 2026 06:31:42 -0700 (PDT)
X-Received: by 2002:a05:6122:4d02:b0:5be:2177:70b3 with SMTP id
 71dfb90a1353d-5bf75e7266dmr990975e0c.10.1783517502168; 
 Wed, 08 Jul 2026 06:31:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c3a2dsm4485853e87.70.2026.07.08.06.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:31:40 -0700 (PDT)
Date: Wed, 8 Jul 2026 16:31:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, neil.armstrong@linaro.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 vishnu.saini@qualcomm.oss.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL
 init in bonded mode"
Message-ID: <d7v4kwmc42k5ymgdt4mn2qc7dkrf5jj2l5afgyjqrm3pxterl4@guulk22xwlzs>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
 <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
 <wrhuksrzlxw2pjlvjm37dwjuztcv7qs5t6mqiav4ujecwqdkwj@ozbfxpbgaimt>
 <CAJfMnmEVwUwt=wMJ-8HKH1yz9+erWLrRGB+6wVYCdSGDK+_T_Q@mail.gmail.com>
 <114b9be8-1fca-4762-822e-1d53838d5de5@leemhuis.info>
 <o64cxeq5f4ffqpdmbai5cvsmxei2cnw3p6acvu55xl3cj5w3z3@6o6kokszvng7>
 <akt6z1irWlXA5UIy@hu-mdsor-hyd.qualcomm.com>
 <493b8d4c-164e-43c9-93c8-40cc251b1c3b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <493b8d4c-164e-43c9-93c8-40cc251b1c3b@leemhuis.info>
X-Proofpoint-ORIG-GUID: Gn7_qaNgoIaDcPJy0Eex5I_5s7-Zomrh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzMiBTYWx0ZWRfX4Mnhmg5+i2Ap
 Jb1eFv+30ykHR57Z28SmpjKLAxbVjgqsrWz7szF4PzUXI4Am8r2den4mCwx+v7S0yArI3x+A4ua
 1l9iVYsX61OcQ9L2wAkMpE7qNuYAtfo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzMiBTYWx0ZWRfX7ebjLITHAxGE
 xByLjTRfa3TZPkrvUUm+PrbW68eEc/up5aT87ez6Sw5FminKvMkGd+uz/8ROoA/jVYdH1Zxh89V
 J6gXchYpn/Y7OV4oJFdYyT/0gDVrtvIXZONT0uZxtIV94HmhkaL+s06GHJq7xVzQe4MXBLWkWCq
 pEeVMlUXzMEeD5+IYLdi9DMJ+DKuh0GDr7EexZcg9OQvqRj6zbXVtGtrCpAkHkO54lhlckr3M+U
 Emt86cUYNj3nW4ftCT6jXRKEI1SGNGlb/J9grsEKQYTmuVi7Ehss7/w1Zk66qC2uAC6hFJKP8xL
 7GPwOAqFskbqGeNpMu7xBlpQWL8NqUCv/JiJmqvTi870HEgmONs/QKW3fdKcNsiJ3y4hXXYwB2h
 L6UncPa78zgSdehp7y0AiwekEJGHkZttdRShaWkZxhlUa/Dx+DWt7f+5WjHN09vJ/pd/E3iFK6V
 OrlMCwjMbWreW9lQdQg==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e513f cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=omIcalozpB-dROxQmn4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: Gn7_qaNgoIaDcPJy0Eex5I_5s7-Zomrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080132
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

On Wed, Jul 08, 2026 at 09:26:04AM +0200, Thorsten Leemhuis wrote:
> On 7/6/26 11:52, Mohit Dsor wrote:
> > On Wed, Jun 03, 2026 at 03:11:34PM +0300, Dmitry Baryshkov wrote:
> >> On Wed, Jun 03, 2026 at 11:56:15AM +0200, Thorsten Leemhuis wrote:
> >>> On 5/4/26 22:09, Mohit Dsor wrote:
> >>>> Sorry for the late reply. I am attaching clk_summary and reg_dump in
> >>>> working and non working case. Lilliput is just a normal display working
> >>>> with hdmi and has 720p as preferred mode. Yes, I was talking about RB3
> >>>> Gen2 only.
> >>>
> >>> Neil, Dmitry, and Mohit: what's the status here? From the outside it
> >>> looks like this regression is still unfixed with nothing happening for
> >>> weeks now. Or has progress been made and I just missed it?
> >>
> >> Thanks as a reminder. Unfortunately, it takes some more time (and I've
> >> been a bit overloaded lately). Worst case I will send a revert soon.
> >>
> > Just wanted to check if you had a chance to look into this issue and whether there's any update on the investigation from your side.
> Hmm, no reply. Given that we are entering holiday season and are way
> past what Linus expects in a situation like this[1] I'd say we should go
> for a revert, unless some fix shows up really soon now.
> 
> Ciao, Thorsten

Please send a revert.

> 
> [1] To quote Linus statements from
> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed
> 
> """
> From 2026-01-22:
> 
>  But a user complaining should basically result in an immediate fix -
>  possibly a "revert and rethink".
> 
> With a later clarification on 2026-01-28:
> 
>  It's also worth noting that "immediate" obviously doesn't mean "right
>  this *second* when the problem has been reported".
> 
>  But if it's a regression with a known commit that caused it, I think
>  the rule of thumb should generally be "within a week", preferably
>  before the next rc.
> """

-- 
With best wishes
Dmitry
