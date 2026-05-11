Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1DACD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0AF10E6FE;
	Mon, 11 May 2026 13:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QjxgDUpt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/4u9eAS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A19610E1AF
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:16:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BC4H13108022
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=jKC4fA5XoPXj0Nn3vhDjLseDL92E+p2MaLlggox48iM=; b=Qj
 xgDUptZiIZXuIpBuj6BboId3rmKT0N/QwyeVWcz/U1tJeKNdAXIwm4Yf0E6Nr7Pb
 YO1NjKwMl/VJrAByEyOzU2sbVkk1OFys/MwK67+q9KgpkR1G+m5zcTay6dDmz/cd
 amO4AcM1xo6eQgCgMIlrDlqkBtuNuBPWnYhqyhpUyFLamx9FT5J8OAGl+3k1nvOn
 WReUSndtdEQlgFsRBNiKXAitgbFVmJWNeOEhPNu9Xfq488dDDy3zSWz8H658ejBs
 wVXpDxkHmsgfh3G7JUOxUwe281NGxBe38m7gG+8z1XtXXnUWKFPxP7QHb3Co+ZBp
 HRJN3gxt1x/5klvnZ6cg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3esyr7yu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:16:45 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-48270ee051dso1125926b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505405; cv=none;
 d=google.com; s=arc-20240605;
 b=VFBOUApondGs+f+M2XQQT6aKoN0UzLB6cX7RM5ACmibbZAU7y9HMpJwklZihwtTSut
 XzpLD/xguSHsRPZxG/5FNeZ0b5sco8/+zLp3xCiNgpFFr5Dc0YEn5M/ifoh7B3cpg306
 iSdnQfAW8oedCI9hEd7xdEb3ub5FiTl+e9iuBH1aD9Ghqz1qhShq/1QE5/coGJW1JAb6
 W6OZJQOsBKsNOQzBWrdyRXZT8yJrlpIK9MnaPGu7d8fQ6wNq2GdTV0eQuEfHiMU7xl9Q
 qDR3MVdRJ61dbxQQSge3FW0x77n/G03f3xZknt6DSM7gPJEbTd+PuF04YFxFNpRsr/T5
 7Rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jKC4fA5XoPXj0Nn3vhDjLseDL92E+p2MaLlggox48iM=;
 fh=y0PgosS0NylZuIPOn5vcOudefimPH59TPOZdCiq0MD0=;
 b=LhLZHNHucRWg3NgM6XInBzRYU9CJY92PMHpUoBZOsv8Blq2TKFG1/sh9ImYrwckeVU
 zjYzolvGeiefXxwZ0ZlsOBS8qZTVrtgCEjqYa7Jva75b9xQxZIfAHFch3YmA9+jpN0Ds
 wSpiMOEa9ZJPBpADP9mJnaSfJPW/04Z2Eg+bXWWuKAGnnUefpiprcxLN4EGQ7EmheIeR
 mYwn114dLfxANlxMLMN9XE5ownQ8QK7fF8NPhty6o91wFktwgmdRofWfqxDfngKzgcmd
 m2PcfaITUoxDUeNQmM24Rbtrf11dSkA/Jwu5KuGZVozTKnpfvzBoeEJZ4euwQa3Z/njT
 LIYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778505405; x=1779110205;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jKC4fA5XoPXj0Nn3vhDjLseDL92E+p2MaLlggox48iM=;
 b=A/4u9eASHs7hhwy8y6uLgkWAthIcVnuylAT1LvXvAZfljfo3vP6+XteXyr/X+VRCqW
 QGev3vwBOTF58GGzinlkc/lkgndqKKZKEfs1VCcziCumeeFs8kWL+barCM6IQ1N1vb7q
 KQt1aLqgt0oQImbZM5WL0w6aTv2gHag3jUOYZhEZGvQFd8dyNqvPA2S+zD9Md9M2xLWM
 61jkFw4F8/llPpE4ZAtZ/yG6qEQGuFkZxKg3ERzoI+dBgewBimwwBaQO6Xms+I9P1zg0
 HWPVaCP22WhJIdzpRQehMIM0FogCj7Xn3hhcbRT3wrbW5RcX46iHCswZg7+hF9y7MY5m
 VHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505405; x=1779110205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jKC4fA5XoPXj0Nn3vhDjLseDL92E+p2MaLlggox48iM=;
 b=lv0h2xhMoPtmymTqqBuIf4RHtXw+Rvw5WYEvFUGeYKn24DMOP0Xp/vZizSsV4FHGwf
 VWpI0xR1uFbZgXwijQKuPdMB7nUIWj7IF9Omg/Zt4aH9L99l3DgcSA0ZrbldGBkeCuwT
 2O0Jq71R9pxtyDSADSSsMAqmj3Zps9mZflGg2j1KCzv22fWtGsasVXA/LpPaqajPI7WW
 5AbO3dG4EMqvtbLj7euMdD4L3tIHSJN0SsdAx9gKpVSYgSH8swtc6So/XnIqy5CTRDV2
 SK7mu1WkM/Rd3K6g3gpvqJmRTBMz+Rngbvb2wxtsH7af4Mseb6XwyJOqnH0gvgWkBGmh
 3bhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96UsjFF8ikE4BtH7yqrEvL40Nfq1mJmJ19aqhQwmT50OYbmSN0sjvY6cEU7Cdn9w/ibeQD21gkRDI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1XLC+B5CX7VT6ItRx8wNC/O12ybhVz26rHdoOS4wOKZHo8dzJ
 3H8Pso/eg2vHwJwhp6yUpf/i434nCmXXBEEgx1Vo4NN0lqjkQU298Cin9dhYWUiqAx+xtsF4N1n
 gX8NDED9Icpv/qyDoqFJYZ8pQKtKyg55/SubSOlQx/wGFm3lQHIa1wBdpZc0cMrxvw1cmEsF53n
 +THliV6oMGWQEbZhF/7dTjEIA51F+bihvmSOdxnuC8NLZVwA==
X-Gm-Gg: Acq92OGFUlDkvz+4VT+V1bez6SmzFly5zXCd6Th7+7FYHkJ6lvREhRhGK6ILkPZMi/t
 kf7Q0c0DzHz5syb4+chRXsc79cVJUAclpAoeDmWH4QzqYGvPglHh4SBvDYZOdlu853aAfzmQcV5
 QAwIFu8obl5pqEY0AVxO4s40SILbtHVdq0axa0r4djhrS8QhDuUGwP3+FgIPnE7YGWLJR/QozZy
 zZ2RrlUHLUPPAII/TnJzRJk/cnaxKFi8IH+BqUYuscwdrNJ
X-Received: by 2002:a05:6808:e687:b0:47b:d07b:ec9b with SMTP id
 5614622812f47-4807fd390bamr6084788b6e.24.1778505404490; 
 Mon, 11 May 2026 06:16:44 -0700 (PDT)
X-Received: by 2002:a05:6808:e687:b0:47b:d07b:ec9b with SMTP id
 5614622812f47-4807fd390bamr6084762b6e.24.1778505404037; Mon, 11 May 2026
 06:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260508065722.18785-1-daniel@quora.org>
 <CACSVV02t99r2JpT9EUar_YRs+zgpzjNYgNvvB9BGLLnpssY4BA@mail.gmail.com>
 <20260511093325.74e2777f@fedora>
In-Reply-To: <20260511093325.74e2777f@fedora>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:16:32 -0700
X-Gm-Features: AVHnY4IbPRfjB1vCZdM9dUhiig08nkqLlXFw3g9vD9Ab24nv_S0ALmZZEdT1ptc
Message-ID: <CACSVV03ZMuVEK6OegD8YKg4RwHWTU_CbWcwdWKSeyiaU=yV1Fg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix shrinker deadlock
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Daniel J Blueman <daniel@quora.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NSBTYWx0ZWRfX16XIdQAX3CtM
 UoLrJucyPM5fdUAycXis1lu/jxTKWWtEGvxAnOcfNrgFWaPADJX7Kra5uf2FswpbvmtEGX67wHs
 ID+NEIxBaxO0hbxr84y9iH1jh+B/8hSbAxL7QR4Jzf2Cx4EbofzA371p+czmSDjvNEs942blQeR
 N35T583F4o78GvMvuBrwSfRZVQEUtEvBxvD+TwlJGzzyBzUGkeQYZAE+EZeLHFMfxoBlNbozRQS
 7iANft3D66RQawQQHl/Hn541RiLK4FlJ3GhQLedAxvgCd2ktg4g0cC9SgrlGXQn6yuXfNeXElSQ
 2yr0Ek4eVbCL6na3S1zYT0O6jT2NjfqRnY2lPlo0ILM0n1pixyT0Vohc4vEb+pLzWuA1Thfe6wF
 W54g6+0IM8zjRERvqPuMDbScSHdjd+OYE4CLbRxh6ym/AqX+cQ721y1oWSFdArQWwQXr3ndLQy2
 dXxDNHtusLHZC/kOSOA==
X-Authority-Analysis: v=2.4 cv=AI/DAN7A c=1 sm=1 tr=0 ts=6a01d6bd cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=t9ty7G3lAAAA:8 a=5lCBbuLfmW-9pqWJmD8A:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: PExMXejQy15N8kDw7N87RPN2H1q3rFsz
X-Proofpoint-ORIG-GUID: PExMXejQy15N8kDw7N87RPN2H1q3rFsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110145
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, May 11, 2026 at 12:37=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Hi,
>
> On Sat, 9 May 2026 08:34:15 -0700
> Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> > On Thu, May 7, 2026 at 11:57=E2=80=AFPM Daniel J Blueman <daniel@quora.=
org> wrote:
> > >
> > > With PROVE_LOCKING on an Snapdragon X1 and VM reclaim pressure, we se=
e:
> > >
> > > """
> > > kswapd0/121 is trying to acquire lock:
> > > ffff800080ed3800 (reservation_ww_class_acquire){+.+.}-{0:0}, at:
> > >   msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189)
> > >
> > > but task is already holding lock:
> > > ffffbf4ddb44ca40 (fs_reclaim){+.+.}-{0:0}, at:
> > >   balance_pgdat (mm/vmscan.c:7236 (discriminator 2))
> > >
> > > which lock already depends on the new lock.
> > >
> > > the existing dependency chain (in reverse order) is:
> > >
> > > -> #2 (fs_reclaim){+.+.}-{0:0}:
> > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:=
5825)
> > > fs_reclaim_acquire (mm/page_alloc.c:4325 mm/page_alloc.c:4339)
> > > dma_resv_lockdep (drivers/dma-buf/dma-resv.c:798)
> > > do_one_initcall (init/main.c:1392)
> > > kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.c:=
1470
> > >   (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:17=
03
> > >   (discriminator 1))
> > > kernel_init (init/main.c:1593)
> > > ret_from_fork (arch/arm64/kernel/entry.S:858)
> > >
> > > -> #1 (reservation_ww_class_mutex){+.+.}-{4:4}:
> > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:=
5825)
> > > dma_resv_lockdep (./include/linux/ww_mutex.h:164 (discriminator 1)
> > >   drivers/dma-buf/dma-resv.c:791 (discriminator 1))
> > > do_one_initcall (init/main.c:1392)
> > > kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.c:=
1470
> > >   (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:17=
03
> > >   (discriminator 1))
> > > kernel_init (init/main.c:1593)
> > > ret_from_fork (arch/arm64/kernel/entry.S:858)
> > >
> > > -> #0 (reservation_ww_class_acquire){+.+.}-{0:0}:
> > > check_prev_add (kernel/locking/lockdep.c:3165)
> > > __lock_acquire (kernel/locking/lockdep.c:3284
> > >   kernel/locking/lockdep.c:3908 kernel/locking/lockdep.c:5237)
> > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:=
5825)
> > > drm_gem_lru_scan (./include/linux/ww_mutex.h:163 (discriminator 1)
> > >   drivers/gpu/drm/drm_gem.c:1681 (discriminator 1))
> >
> > Your line #s don't quite match mine, but AFAICT this is from the
> > ww_acquire_init()
> >
> > What I'm unsure about is if this could cause live-lock against another
> > operation which requires obtaining both obj and vm locks in a
> > potentially different order (which would also be using a
> > ww_acquire_ctx ticket to backoff in case of conflicting locking
> > order).  It wouldn't deadlock because we don't sleep forever if we do
> > sleep, but...
> >
> > Possibly we should also be using trylock to also acquire the vm lock,
> > but lockdep would still complain as it doesn't know the ticket will be
> > only used w/ trylock (unless we did something hacky by using a
> > different ww_class?)
>
> FWIW, we started using a ticket in the initial version of the Panthor
> shrinker, and ditched it at some point because of these unsolvable lock
> ordering issues. It also seems to me that trylock-all-the-way is the
> right solution, and if we trylock and back off + immediately move to
> the next BO if any lock is already held, the ticket approach is not as
> useful, because we're not going to use the retry mechanism provided by
> ww_mutex anyway.
>
> It's true that it does the bookkeeping, which simplifies the rollback
> procedure, but if you look at the other locks taken in the shrinker
> path, they are static (one per-component involved in reclaim) for most
> of them, meaning the rollback is pretty straightforward. The only
> exception is the VM lock (one per vm_bo in case of shared BOs). In
> panthor, we just decided to open-code this rollback logic (see
> panthor_gem_try_evict_no_resv_wait() [1]) instead of teaching ww_mutex
> about non-blocking locks when a ticket is provided. Not saying this is
> the best option, but it works...

hmm, ok.. and if we block waiting for BO that is before grabbing the
vm locks so no live-lock concern (sry, been a while since I've looked
at this)..  So I guess trylock is maybe the better approach.  In this
case we should drop the ticket arg (basically revert commit
02070f049875 ("drm/gem: Add ww_acquire_ctx support to
drm_gem_lru_scan()"))

BR,
-R

> Regards,
>
> Boris
>
> [1]https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/dr=
ivers/gpu/drm/panthor/panthor_gem.c?ref_type=3Dheads#L1425
