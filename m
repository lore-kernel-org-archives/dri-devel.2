Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAA606A325
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n0q11sRm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA70410F338;
	Tue, 27 Oct 2026 09:32:06 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C6310E362
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 20:08:32 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5bcb1f1358aso2390749e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793045310; cv=none;
 d=google.com; s=arc-20260327;
 b=KDvRbNJ154F/NUPVvVqUgqn2J6/v6L7xhTaFaVyyk/1Sd4TrI3NgUt3U+iHJZeChA9
 W0t3mWlyEc9S02lqqeYRtDJdz7z/5zh7t7r1RMuGc/J4DXipWSLSJ95+aKcQTzO0nsBK
 omo4IR7jZmdB5Mgr2fFiGSLDB6lgTrZM/oFyEg3e3khxBHBsr/K/emjPlIrpRtMXG/8C
 oyY2evKWH5fq1o8Cs2Z/70TYZcNBUtCS77Jb/AoTU/JDNF4iZ3IyNXkXgCuNJPyE6qDD
 ZVSCQAWf+P5xwTwtrdTSrvbcuXMy8cXF/w+0hAE5UpQhPhp9TuASksaJow3LYp7gB0or
 YRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nWqnHnWKSGu2qfmiQO4KE2+ceVuEjS/9bDtJVMivCcg=;
 fh=64ODTTe9AfIPKT/Bsiye3V1Pdu5r1Yk+BuC9NaGj/mE=;
 b=G2AUNisik8g26Mm2ntlYJVEYvBV1BJRivgmbVvWTvKd+R+rLbzmRJkP1HAdKjpEz8O
 Y+i+iQltgap7Yk1j0ZjER8qeTCYLIMnRbhzpXZf8cBiNqRXZfenpkstFfegSkcYQodop
 ldO+qVU1QpaIe4czqMEc8qNMH7CPyPtAhdEBLJSVYYdcuhsQP/J6Y0Kw6f1rmmls9Jck
 PTc4CZUBQItRlWECZtzd4tI07LfgfVcZKsoFYe4EFfv1Knv6XnhlddiRE7t6TD4vp1OC
 pQAw9QyMyDeadeA16Lv89EYagQOZ32mkLst+nt0sleRGFNvt0AvJlAovIAQlPj4CWxlH
 oA0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793045310; x=1793650110; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nWqnHnWKSGu2qfmiQO4KE2+ceVuEjS/9bDtJVMivCcg=;
 b=n0q11sRmADN0KCt1DY7IA3hYj8TajNBIxi9JyAF0WbyKGScgjP5UWO5mMMjICWSCdE
 ZZVaZXAYIKhFoHvD8SDRQhrmH8zS1vCDdmX5VVSOG4XDvFbJTIVZFccAf8E4kDW5du4k
 NoMVCDkKR6wh4fSiLF3iwKQZfW6Te2Ae+3qN11rXKImD0+/P0622IChbpaCD9JeSrWmb
 mBLZMqE1t1lS28ZrU1z0Y/zGwBcun1s7atfn/SW/VtV3kovmLzQfsjg4UtCPzEgkZW0j
 yslyI914vvq6MU0SRdnS8FhmdH1+pftrV7fc6JY0e0VuHPaCXMNioEAs+zw/67T8V+or
 Klcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793045310; x=1793650110;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nWqnHnWKSGu2qfmiQO4KE2+ceVuEjS/9bDtJVMivCcg=;
 b=V0xocFwlrS7oiBYX2APs9FTsS0TylaKxuCjf4m8Lc65b9xV7NWxzOlnQQp//jKvBwr
 P8J2BYS4t0R2wbfWmcn9NGvsrMDfgrnu6uHAUQ6UoNAXG611zxgkGNOfqSuHd41JX0T+
 rgZYwcf8M8E42wBb4AzDRzWZaapS61pVtMN2Tk+xcAPWJH5HvljJ+p9VGxKhzSZGy1pC
 h1asd0TZDeTYL5SMUYq5Cr1C6lgBnM7E15gCpuvrUnoYvXY2ZwoP7OEndISvIU7U3eUy
 DukSFU49IimbPuHQF7i9lePwzpCILEenDi/hnC18w7gBxOVZaP5TGKmplPnWMR/HNHCQ
 N6hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDuOnwpy1Z9tt/P8rfV+4SZGFurXUCjNh7qu7lNkDsRdvfVL0ZWjZj/XWcsS+Bp6HwP0upEq199cM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJgF6cVEBqrk8gSRl/ZiYGiq319ukZofV7cQwklAjPoA63Mye2t
 StL9tSwQtHLQMvGPfS/V62XRz94UupJOga+rz7xZ8RbffiGg8cGwarN9dghXPYzQjaqrN1aLA7q
 R+3s0pG/A0IEHc/H4Qn3WrH4y0e5cKUE=
X-Gm-Gg: AYBFou1dLKX6FwaU9E3tnl31ZiIYIFdgZ8x8GwJivU4mgB/BS71fRWao5kzTlITEy2U
 9RKeVfYIj8YWpJsDl1Rgofrri5Fvc1e9g1RspDMQw1D8tYsFzF6A2vFvK8MZ1DGMVYVXn/1t4Ye
 Gy5N+lgdIdD9ceVvtr8L+XxpVbhKEd1hMpeNWnsoe6wwnMeUb5QdD3cxsFZPlB0eFlZDQjEpJ4X
 GRDul3fDib04C+o7S42W4/q8Tj2G5Zgwn+9F2tTBfG/3nwAvr9g27k3kLPaFwUKTXV/3zscZx1Q
 rHxK4dqGhyHE95L9pffzh16U1bBikfaimA2ZYqIPlIcpNnO6/43pq10qMAQqyLBV5k/awB+8UFp
 +DYCaD39CZ16tDRv3szzGJUfcPu3mo6f4l9dnEpM=
X-Received: by 2002:a05:6512:3e04:b0:5bf:a27e:e455 with SMTP id
 2adb3069b0e04-5bfb71fe5dbmr2606420e87.65.1793045310018; Mon, 26 Oct 2026
 13:08:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-2-457aafbb28da@gmail.com>
 <54itft4rw53zcxoyx5vhxz3zfenxgooorp6lo44vbsdayrq4yi@3f4btdyicop6>
In-Reply-To: <54itft4rw53zcxoyx5vhxz3zfenxgooorp6lo44vbsdayrq4yi@3f4btdyicop6>
From: Fabricio Akio <fabricioakio@gmail.com>
Date: Mon, 26 Oct 2026 17:07:51 -0300
X-Gm-Features: AclHuK-BkS5vWEjGMTsyKGjUVJ_nbifNDhF0-JuYBYIWpzcnB0joyMLQ1fgk8e0
Message-ID: <CANxzQdFsbu0mTP6WgwjH=9tHT0SyT+yw1LWbAtHYv2unr1ym3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/msm/a5xx: Hold a CPU latency request while the
 GPU is powered
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Paul Sajna <sajattack@postmarketos.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 08:42:26PM +0300, Dmitry Baryshkov wrote:
> Do you have any extra patches that you are running with? I don't think
> that currently Linux can hit system power collapse with the GPU still
> running.

Yes, a series not yet sent that adds SDM630's system-level idle state
(cluster and system power domains in PSCI OSI mode, and the MPM). The
stall needs that state, so on mainline this patch prevents nothing. I
briefly mentioned it in the cover letter.

> On SDM630 the GPU is running from the CX, but we don't vote on it (yet).
> With the CPUs awake we keep a vote on CX. With the cores going to the
> deep sleep, the CX might drop below the required leven, causing GPU to
> die.
[...]
> Could you please check what actually stops in your setup (CX corner, the
> BIMC vote, XO)? I think the proper fix is for the GPU to vote its real
> rail, scaled per OPP, in both RPM sets, rather than keeping the CPUs out
> of their idle states.

The GPU doesn't die: it pauses for as long as the SoC is in the system
state, and the job completes once the SoC leaves it. The votes don't
change that. I tested them with the latency request off and on:

- XO: the GPU clock controller using RPM_SMD_XO_CLK_SRC
- CX: the GPU clock controller voting RPMPD_VDDCX at TURBO
- MX: every GPU OPP at TURBO
- BIMC: every GPU OPP at the maximum peak bandwidth

Each was read back from debugfs during the run, in both sets. Hang
detections in jobs, two runs with the request off:

                        request off        request on
  as is                 207/483  216/483   0/500
  CX                    192/488  194/485   0/499
  XO                    188/487  188/483   0/499
  CX + XO + BIMC        180/487  185/488   0/499
  CX + XO + BIMC + MX   199/494  208/487   0/498

I don't know why it pauses, but downstream keeps the SoC out of that
state while the GPU is active, with qcom,pm-qos-active-latency.

You're right about the CPUs' idle states, though: with sdm630.dtsi's
values, 424 us keeps every CPU out of power collapse while the GPU is
powered. Only the system state needs blocking: at 2336 us, which leaves
every CPU and cluster state available, the same test gives no hang
detections.
