Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9208DF9EDC9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0349F899A3;
	Wed, 22 Apr 2026 13:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OtHaKthA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W4onzQ3T";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13DE899A3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:14:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M994OR2064773
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dikduDjbgfHRGI8Bv6LMlFR6
 6ECdPNblFM4jH+7p4/s=; b=OtHaKthA85aZA1RSC0qyHB8L55KY9TR4VOjfxb1X
 Ktuuuq0oyl/a0XJB2NBR7by4YX//ebTJ8La+V8LY5DbJDcah0jUnxzQU8Z1w3pQs
 6F7L0hy414M+cniM6BL3Eq6KAwFtVLAbiRkJ7oy9g05nnAVN6zpUzMYahx4uuEsP
 zsjWAFc2fVSn6LiuRAGQ4zmx2pK8V3gstk6GaeCJ984kymju1JkAmBzB3iuj7moy
 izKRX6CL+EcFhAc+WkE9wcxCgfjQVD73cmHta7Ic2kS647ILMIbjvWHwBQe7BtP/
 p/MXG+S2JPffUGOhGuRzbGxSgX8CDBCWUGnXuo/cmcdkmA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenhkhs9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:14:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35da4795b3cso10391516a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776863672; x=1777468472;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dikduDjbgfHRGI8Bv6LMlFR66ECdPNblFM4jH+7p4/s=;
 b=W4onzQ3TNnMDUa0nRlvncsxMrFEYMc2pXJc6fjC0TEZmRhKXb4iUMTI+a27bbwt+Fz
 RzhfHxY5LoV42i4NOK/nosTMCgXUiRKbNEBTjcczJnh2nC8Asc2BKvP8LMIxBZGqcFtv
 cfyD6XP3OVGAnR66pVeSopAhAxwEJ8vG04FnxUVpLIG77K1BOImnVCslnj//aq2J3fwH
 cKGbnaLY60V8tINEAzrq13VzgHq8D58UlC0U+V91oadWrS4uADhw7DsjLXpfyDLekWjV
 c2Bgl6q3wjEMoAkSl3uEK3Vs4gtaCn/O4zjJisctGXCBgc9fCpJxIXBcp1CDKVDmeABW
 82mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776863672; x=1777468472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dikduDjbgfHRGI8Bv6LMlFR66ECdPNblFM4jH+7p4/s=;
 b=kuyRm0NWEuH8tDiHD5kWqSL4aZiXgN0NO2Y7G+zsNfIRSt8PlsXHGKV3/UCZQoZgfs
 fi7jM4cA/LiFRLEIELpXa2OtOptum/QiLMPAV+u8mSYsp9hyHfYAfiy9AHOsrho3JAQ+
 QfZMOl+ePgsrn2VpQ4k71uH3nG/3UZb8Nk3hReblmS6BBmK0wc5adr7lqTrXIHRzQFUR
 tpnrqwnaPAr0RkqicARj0pEIgK+tAnX6CxgFv7NM0rW80tEjJL9MrdXGrKdU0Wv4XHGG
 Cjsfgt+tox1tNkctz3oqFPBxJueuHU+7O7kCBbtgkC9kcO/M/dXX56ZKYe1QNa30UCEq
 G/VQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AuRXBtjn+Bfurs970AuAXbHe8wgNa1PIcBVB5gSNNMCzvAF/mAoRgrRE9Nbn1bFP1FY0cT6SRmX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwuE6XmWKUS3wDpITCsvRhCipIjJFY4hljke0FWD2jHyP9pQNs
 b90nEGTqayWHGyNwKlLEVl3pcLZw+9A4DapDEl9lw8uopzVFZjd8gvBMkfXLMaIbSoVqvVvC8fg
 LN4c+kRqTxztHmd823DK0PhNWnGgLEtqr7k+sZ/JYO+6PDr759kNB1HfQ+h2uIlLNyOQppOg=
X-Gm-Gg: AeBDieviFvumBYikNc08OmGXTtTEukA3BLZzZj7u7Itx8kdpeJBJdVfhlrfU8ftQLIB
 HYVpROujK/7aTrEBw0L97Ogci6V9rstREHdb7qYYZ8fcVO8J1WFtrW0mzdIS1GvDCP+97+7dOie
 jb16+eoOfjK8KPP1shlOGiqZdd+Rypw/I74dQL/3W8M8wrXC7PmpvA1qCVySRt0rgiNFWMzMNs5
 40vG6gU+SWJXSzZUamvUckZMM6Zraq9xIVA6uwG/tCKqhPveADCYzoxFkliQCyWxSyt9oyoB4UC
 nfn1ftlZ90pEO5wS3QsDK6BvPm3xqJQ4MXrulpwNuRJeG6ozWQz0sRWFC0CVBoewfhBg2UlaIUw
 3izmp+dR2q6Kj2MNdvEEcNPAgKwLdyzm1coBxj6zmOsKSkqCRSXBurHz5Frg=
X-Received: by 2002:a17:90b:5543:b0:35f:b227:db86 with SMTP id
 98e67ed59e1d1-361403af6a5mr22926191a91.2.1776863671865; 
 Wed, 22 Apr 2026 06:14:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5543:b0:35f:b227:db86 with SMTP id
 98e67ed59e1d1-361403af6a5mr22926152a91.2.1776863671148; 
 Wed, 22 Apr 2026 06:14:31 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141990bb6sm17540320a91.17.2026.04.22.06.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:14:30 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:44:24 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: Fix NULL pointer dereference in rpmsg
 callback
Message-ID: <20260422131424.svgaj627xyfz3wkd@hu-mojha-hyd.qualcomm.com>
References: <20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com>
 <lqu6wykpvqpbm3boqjsy3tqqle75g2utumhsh6gha24xzeveda@7rwcsbwpkvua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lqu6wykpvqpbm3boqjsy3tqqle75g2utumhsh6gha24xzeveda@7rwcsbwpkvua>
X-Proofpoint-ORIG-GUID: jUhx575EKK857JJ7YSuH2ITBZGiYqnvj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyNyBTYWx0ZWRfX7mxjI1+WQoSI
 deFxhWJW4IK6eif2ZGxS+K5p5CbCorASk7biEkM/xMCWZwMY4Qkc6ksPwMJK/9gsZDZ1dLsnB/t
 X5AzKo/CMu92Lf4mKM5r+58xz4eC10uZVJYB+9xAtjYuFxItMM/rG/tsBcEnwLIYbnJZCWTmsC7
 SWB8OGymqspBm+vYRQEkTdyFYtUKV4eznh5EO5CQs+aZuDDnUJcDq7AN4iCqMTQqY+uFGU7Lmj4
 zRvVwyka1Y1o1bTTobzot1j/BLjB5J0ZBLMpZOeq/NwVf7QY5oz5SxUVs6lb0Sp6hoB8HxRuYpC
 kgVwZ8Ov+xyGacqeJsflRXY6vzkEGIzuNZjT0OSsquoWfwovt/8uPohMR/V6DwBw7Tg5GlzruKM
 dARDaQ3zUGLL8I4OVQCIThn4eqTGTBkvxCLhul3MTyKU1KSjM/LzP/nJcLaBo0RYMsuv566itvM
 02gVoW3zGeRsKDAr6XA==
X-Authority-Analysis: v=2.4 cv=WKJPmHsR c=1 sm=1 tr=0 ts=69e8c9b8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pmo7ErGbKGZq2siEmvIA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: jUhx575EKK857JJ7YSuH2ITBZGiYqnvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220127
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

On Sat, Apr 18, 2026 at 01:35:00AM +0300, Dmitry Baryshkov wrote:
> On Sat, Apr 18, 2026 at 01:31:46AM +0530, Mukesh Ojha wrote:
> > A NULL pointer dereference was observed on Hawi at boot when the DSP
> > sends a glink message before fastrpc_rpmsg_probe() has completed
> > initialization:
> > 
> >   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
> >   pc : _raw_spin_lock_irqsave+0x34/0x8c
> >   lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
> >   ...
> >   Call trace:
> >    _raw_spin_lock_irqsave+0x34/0x8c (P)
> >    fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
> >    qcom_glink_native_rx+0x538/0x6a4
> >    qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]
> > 
> > The faulting address 0x178 corresponds to the lock variable inside
> > struct fastrpc_channel_ctx, confirming that cctx is NULL when
> > fastrpc_rpmsg_callback() attempts to take the spinlock.
> > 
> > There are two issues here. First, dev_set_drvdata() is called before
> > spin_lock_init() and idr_init(), leaving a window where the callback
> > can retrieve a valid cctx pointer but operate on an uninitialized
> > spinlock. Second, the rpmsg channel becomes live as soon as the driver
> > is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
> > is called at all, resulting in dev_get_drvdata() returning NULL.
> > 
> > Fix both issues by moving all cctx initialization ahead of
> > dev_set_drvdata() so the structure is fully initialized before it
> > becomes visible to the callback, and add a NULL check in
> > fastrpc_rpmsg_callback() as a guard against any remaining window.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Missing Fixes / cc:stable. Otherwise LGTM.

Will add in v2.

> 
> As a side note, we really should rewrite that part into loop over
> subnodes instead of the of_populate and depending on subdevices to
> probe.
> 

I get your point and worked on removing of_populate and removeing
probe/remove  while it can be simple init call from the parent probe.
Let me refactor it.

> -- 
> With best wishes
> Dmitry

-- 
-Mukesh Ojha
