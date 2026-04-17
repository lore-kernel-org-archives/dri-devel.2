Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C734F99C69
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 22:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0293110EAC2;
	Fri, 17 Apr 2026 22:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UhrxBHvF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TfWVYC4t";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EE310EAC2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 22:35:05 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4XP9454890
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 22:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lV91OmQ0DpFrl6eQP6Fk2nhC
 QuvgBovKBq0SbXWQTWk=; b=UhrxBHvFci7gKxOXqkZHhWy6PS+7KcQpJ6UjXAyC
 bVrNJ1r4p4CP7r1ktkugFS8ICyHXEbuEv/ryB4sP4LauuHQ00yjL0bkN/fnVQsGC
 QNuQJpfeU5rLXUS/2G0v9x/xJkvXnIB+lw3AkECw7BI80YYqnAkyQOx8am0V08KA
 i8RPdLKPL5te/bPc1gIss7hh2BRzLWqK7JoPoUVRaWk0L2W9VOk8TPk/9xg9o/Me
 T0HqkgPzOCA52s5mz3psDOFH4iwqtu3ETTSEh10HITw2EpxpossGGNOBw2KD/GRM
 Z6Hf7xOzo2Thht2UVjwS6ewpxQ22EqwxJdy4K+xLOU7BlQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkg88tyty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 22:35:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50da31af14cso34258751cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776465304; x=1777070104;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lV91OmQ0DpFrl6eQP6Fk2nhCQuvgBovKBq0SbXWQTWk=;
 b=TfWVYC4tLJnRXFDJRffSjMSE4I5Ph23nnqhVD25XXVFk2JpKXoj4gVtDdI1DpeLBFL
 WQ0fFo07kR5JeTcjbfy1HkDf3bJ3yIDYZmKBZDGmvZgIm7iOSZG4Nyfz5SxQYdb3CGL/
 RhuJcJ9cXqURn2xTmzFAtHKZwQHC9ZsCydXEOzWnNC98sX9JFKRw5iPAoaH8uAIopkcC
 tWOa9ZvI/McP/S+g6Pz8jkAFGYpdbhf7Cfz1oB9ZNr3m7gMxdcDkixFY0lOb87ym5pLX
 UZUTymqD+z0ZUJHwQXkn6jbYoKrbuIdjYgdTeJ41ruiWEe9Lucz6I9kPXFLG9mLZWrKs
 +YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776465304; x=1777070104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lV91OmQ0DpFrl6eQP6Fk2nhCQuvgBovKBq0SbXWQTWk=;
 b=kGTvIC6q8Q0HSSPvw66+OwQOr8lHNDLHgIKAOy7XmmfTxVHKlFn1Sb2adAlF5C71TM
 kut7SDzmUT0mVFPiuGSYlJZIjkd/WiOFvZcezFKHgyyXmYOTqcvPXQlO7fxnCUUDRa+6
 JgL+1hdqXejSWV64Dv4x4aHagqtGI9QtAx92Ep8gP6GiP+4tiH9yJMv6PIIFUApSmeFI
 U8qMQsqrNLWrGvk6BT1YygD7eGnxtc2Qg/8nSiB0f+5Kf1j1OeiC5Iaxv5ZBQ4YqMEax
 lwAhWYpmyRkIjaNaGStK1cUUpjjLFpZ8RhE2WkkJjM0hgeMvFyuebZZ9P7tTQaFFg77w
 NtjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ng0bIh8G8/35fyhiOTAIM0+LB4Cb8bJjPA9EcYtjAFSuWIlGonc1yAgyrQHL//q5sN7Y5sPsreWQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoFxIF40qXf4vWCg1usek0pgPAPkr1DbykIKBHMCfzYzLytaCn
 XgYKfiogkWK7XyoZ4CWGSreMauZ3LhB2AsHfvJLSpQ1S/7Fg41DZd6H3fC+kCtVn+O9zGgky/fE
 rxhLWUHW7y6ZAUtNy4KgNscp32LWSGDbMT4DJLgkIEIR/8+G6HYgQbHybB17ULO3LPYK0LU0=
X-Gm-Gg: AeBDietT9kiE8by4kpAmr26Y8KDlIhYPNu7TgRjKnlbku6OhWWWMjV+YYgBXhgYqrnh
 FZYGMU0ypUqBmSWLqOeb/AJT2lO0HGP9BK9qu3poOTwJlALfIgSuzLarmwe/UDzjuh3Y2wltQCi
 u7tlCGKApIpIyo/7X3vPHeL/y8qj2jBDCbneN/wMAWZgDTlRrMIXcWvtwKrUq4pcIE3wr7AOe5n
 ri9TfFsuy435c41p0VmdJo+z9+KvxYGrpkH186DeLWmJuSTak7kc9ypPE32vWhLs83t3exdQBQk
 TwXU+xKdgySk9yyDrw7G8yJqV2b89n4YKbfPjjLVk3qA0N4HfipdH/86V7og39iN8ulMnlivWdH
 fSfm06lGSN6APU+eTsBEMSTd/4KnYNspBh61a3yfLSVnBjgWBodhUipz2eLpv0/7k1t9rC6Hq+Z
 E4dPFNo66YjshyN/kuQRP7VoX7CNF/us3BKmp+JWFsQXbbYQ==
X-Received: by 2002:ac8:7fd2:0:b0:50b:36af:56a6 with SMTP id
 d75a77b69052e-50e36b3f5c5mr73676691cf.15.1776465303581; 
 Fri, 17 Apr 2026 15:35:03 -0700 (PDT)
X-Received: by 2002:ac8:7fd2:0:b0:50b:36af:56a6 with SMTP id
 d75a77b69052e-50e36b3f5c5mr73676261cf.15.1776465303129; 
 Fri, 17 Apr 2026 15:35:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a41cc7f832sm7682e87.28.2026.04.17.15.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 15:35:02 -0700 (PDT)
Date: Sat, 18 Apr 2026 01:35:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: Fix NULL pointer dereference in rpmsg
 callback
Message-ID: <lqu6wykpvqpbm3boqjsy3tqqle75g2utumhsh6gha24xzeveda@7rwcsbwpkvua>
References: <20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: -SfNfZKMPxz5yrNCIqIEcXRgdHGvAYED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIyNiBTYWx0ZWRfX13IpmNuEhYib
 QB63jIf9v0wLoB0rr5EZRzpct+imbQ9vlhgrPkPI5xUtF9L1S36r+tE+3YUmTRctFkJj/t5UAtS
 1rVY6PLJf1JpTUdS66PN/PChubKXqncj8OrIWNnVQs8zLYB8m7Hvn1VQoXcf6TAr/xDSESS2OAF
 3j355F5CIjbmzEfUtvC+uyxDcYSz/3EzFjdIaH57mdG4ywrP09bY8xSCrZszuE5uAmPPXNLB3mx
 uFYaG00w7jKOHakTpnQ0Xi5DOOezVMoQKDFRpNCxbTWNDfqkttgrHTB/MVXp2s5kvGAGG1Tp8Xv
 mPtCYl0eYshS5NIBMFKXUSgq0r82nxIJeMCm2Sgq91m6dg/wkaB2vRD1C/q7+7Zx0HRbYixrmsT
 i1VhRkD2k1gDF1UFSqaV75yE/7RFXkET3u4cloS8Jup4eUzr2pupiDNSyJ+hZUFUWQTy1nw2V2X
 2wwqgpxFURhi20N0uLQ==
X-Authority-Analysis: v=2.4 cv=X+Fi7mTe c=1 sm=1 tr=0 ts=69e2b598 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=zAZcFUoMMnNVK3tmhPQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: -SfNfZKMPxz5yrNCIqIEcXRgdHGvAYED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170226
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

On Sat, Apr 18, 2026 at 01:31:46AM +0530, Mukesh Ojha wrote:
> A NULL pointer dereference was observed on Hawi at boot when the DSP
> sends a glink message before fastrpc_rpmsg_probe() has completed
> initialization:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
>   pc : _raw_spin_lock_irqsave+0x34/0x8c
>   lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
>   ...
>   Call trace:
>    _raw_spin_lock_irqsave+0x34/0x8c (P)
>    fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
>    qcom_glink_native_rx+0x538/0x6a4
>    qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]
> 
> The faulting address 0x178 corresponds to the lock variable inside
> struct fastrpc_channel_ctx, confirming that cctx is NULL when
> fastrpc_rpmsg_callback() attempts to take the spinlock.
> 
> There are two issues here. First, dev_set_drvdata() is called before
> spin_lock_init() and idr_init(), leaving a window where the callback
> can retrieve a valid cctx pointer but operate on an uninitialized
> spinlock. Second, the rpmsg channel becomes live as soon as the driver
> is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
> is called at all, resulting in dev_get_drvdata() returning NULL.
> 
> Fix both issues by moving all cctx initialization ahead of
> dev_set_drvdata() so the structure is fully initialized before it
> becomes visible to the callback, and add a NULL check in
> fastrpc_rpmsg_callback() as a guard against any remaining window.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Missing Fixes / cc:stable. Otherwise LGTM.

As a side note, we really should rewrite that part into loop over
subnodes instead of the of_populate and depending on subdevices to
probe.

-- 
With best wishes
Dmitry
