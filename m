Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64BCF9EDE8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0411410EA18;
	Wed, 22 Apr 2026 14:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZP7pFmCm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hccBd1lo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE4310EA18
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:41:33 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MAx3H7727932
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=ASK75C548NXlvmkhFEvuKgc20/D6DTZS2vwxyHG3ttk=; b=ZP
 7pFmCmx1bqK/a0r7k5pDbeLBR1y6+oMk2bEUDLe+pH6iOxR9RyGiBdSSoOQ3Th/D
 tZKvxs4Bhx5mxTss+dHGfIksdnsIqnR3KB+XR2xcgJkfj1eJPL1EqApMX1eNfLjr
 Z+vaZjI4Bo9R3KqdMGpQet9PqN1R34n3sK8d9sbN9zjMs9R5KvLhjyX+jehyNtYt
 2Icw0OQMjChwcgoETDGO8jjjRjJb+pUMMvud46p3JPU/+4fFaVL2KMlZmg6KgEQ5
 JdV3V+nsOTIMk5F9SNyiXR5UZRaUssUrVzBj98/baV28fQB1Npym7oeTg/LX4NQ5
 RtQ4QL2k2CG7RTYOTwNA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenhbsn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:41:32 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-479ef6653bbso1640421b6e.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776868892; cv=none;
 d=google.com; s=arc-20240605;
 b=jepJ/W2h0qwZJFLFbjCBFJ32vN5Xm/S85E6CFDRoUppQCFCJOwVpdGM4HGbzxmJkHx
 xs4p3X6ZRc9iOUplYhlTdbjUwE+9vJ6XrZmHz00k45OtwUSFC/abzzHRi7JbCDUOrPvm
 1NrJrwoKv2HkNxQyIcebFqewZMohIMqIev3iTf1b5IVYAP8RM+zO4ZRYM7hoG3u/yjy0
 +Vhzn1rc7B62Arvc693BviXpLwaEqbrug5uUs0ypv3JM5UIwj6/H6FRUQ4KQPjxOYAgP
 Ff88CA8zBptgHKHgUdNVCZ1cGrpJQb+2aq29I0ztN4zgqj+BJuK6ev2rPBi+4uZVjJId
 +DYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ASK75C548NXlvmkhFEvuKgc20/D6DTZS2vwxyHG3ttk=;
 fh=bu8whMtzU8LG2Z8xjIBuxSHfSX6N4PaRz0HerU4UGGE=;
 b=SexmrRurdkt1aURF3pOILOa80imbK17OO8DWECIZMeJD60Ktb9lMd/jhr0A0ZZWF5Q
 WCoEIcdjJcpYbyTA5QF4WwPS9WhM/Q4ZN0LygrFMR3mNUK6VkdleIeDFi80PRt0FPXT2
 vg2IOk8MQoadAVfEzgFNV5k2g9+T1nIik7z17f3MGGN9+Scjuvv0N3CFybS0iWhf0EGQ
 NTO5d+ofRxc2iw+sKzMWiyPU5JsKz064FyhA9YUyr5Wh+mxJsxvYTxKvNP/hMMBbUJGI
 e8S1UD657HG91PvPbKb/ZZaZ2qVy9cc+NWFP4UvPTllTyhnnL6NF7Ftt8NdUwsyrFxpq
 q8gQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776868892; x=1777473692;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ASK75C548NXlvmkhFEvuKgc20/D6DTZS2vwxyHG3ttk=;
 b=hccBd1lorrRXaP7BO/qUGHQ3cKRqJlA6v++XnEadjAouTSDcge8uwQ2qJT+Ocw1VWk
 /1mOsxzOV7a94bhX4SLV90WiHOo3rAxQFGlXEx2Md3PEU/CsjNJWtkELVrlRSqrV946e
 m7B0aOJ5xxVLHUf5f9jKbnfzAvyyaNO+mG/H0dljhxyebrD8h5Etr0mOcx3A0aGXhKLv
 xXsHJdpaviCR82tYDhOQDuCVVHY36cy9S3/qB8EiQgQEWV/Kbud5jAUrbdoquyPOJYkt
 +JoZKzZrHf7IUWB56tsoeiu/ba9gFfvzJyEzlBYL6X0oMyvs0dyd4ZBE1sopZE1YamPK
 hWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868892; x=1777473692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ASK75C548NXlvmkhFEvuKgc20/D6DTZS2vwxyHG3ttk=;
 b=ezYafBfeLB+V680Ag37o/4zvcwKeXpyF5PTcjVQfOO7rV4UJwyPrl+xOz5QTg0F5pO
 dKSJQAYbZrQRK1lPqvV8cstUUNMYSODSUPj7tWUa/AyzC6RAfPa947qW4nnBa9Yf6QAs
 U4uLTwXJLTJzItzHGIZoxbO0Eu8xhjSoUhlSQha4/UA/9Bg2JkdN3/O7JL+aDHqsRO8r
 LX6YVDlZoliMOQ2RfP6Mu+AZkIpSYuFmRp3Cvj7dSD2+GYpb77YIJsbtJ+IrGuBAf1jU
 J43wEcasFk+lkZdYuVEzXg70R0BPPPam8UG9uod5zFNHAQ3GHbkiaoYnm9XB6I3FzVjW
 GT1Q==
X-Gm-Message-State: AOJu0YwJieT3o8bnIkUSWg+8rLkJK23nHn09lb3x+WvcqVgHhSypJKaL
 HEehaEHW5gaP3g2qP4s790FyqdrB9y/US2YuaTuEDZBS99drKlohqQg8dWnhrscS4ZpcENOApWB
 aSmE0C+8KZvPgLjnMwg/uyZcNKHEpjMJ3+OW8Xlr6dIoiVTABAIofgEgiWBlQhJXPGUOI7MaQ5G
 eqD7X68XE0KCLqxj5gxIRhkshW2thTaTXIfkNL1hU4JfGzsg==
X-Gm-Gg: AeBDietYKH+b/AlGooWatVoqr5JZGpIdvIezqEvBgBsiIF5HwoAcVKbALgs2vvZMuIr
 JoDUxwseTMk1f+53NjbxWPVvxarKnZssgkQEMIl6cIg7ZtCZZs5X6C+MfdKQZ6go8LslLjZXyFv
 J6CDwz4mK6UQPBfrto3mTgVoh+btkzVOSfPox9kuHjyf7CaOLeW9/tbGDskEoM3j4rSRQ/EuevY
 LI9q9h/H77azifsFKacgegLaQLNHc7EwbYMVLlFKBh/oegw
X-Received: by 2002:a05:6808:bcf:b0:466:fcbb:1673 with SMTP id
 5614622812f47-4799c986c82mr12178718b6e.17.1776868891949; 
 Wed, 22 Apr 2026 07:41:31 -0700 (PDT)
X-Received: by 2002:a05:6808:bcf:b0:466:fcbb:1673 with SMTP id
 5614622812f47-4799c986c82mr12178700b6e.17.1776868891528; Wed, 22 Apr 2026
 07:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-2-robin.clark@oss.qualcomm.com>
 <sidcsgvqxddatwwflohsd6gjzm5ehbs4alwaejh3pnjnlhj7vm@nqxhdtxxxizs>
 <CACSVV01TK+iLiaCofFfPU2eeMGT5HX5iW0rf=m+gjojXsjrk8Q@mail.gmail.com>
 <puvvx2h2jnoxej42blcdx357uzx37ogwnqldcynklmm4acameg@4zvnrueodcon>
 <CACSVV01D388voqDxmfOm_qhV3=H+F3YW2oUjzZT7MfKYwjapDQ@mail.gmail.com>
 <cczwmaecg7h5lpuw7mi6n6k2zu3lqisrkqybavxe4h6wlrofkg@qcmf7eq3siaz>
In-Reply-To: <cczwmaecg7h5lpuw7mi6n6k2zu3lqisrkqybavxe4h6wlrofkg@qcmf7eq3siaz>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 07:41:20 -0700
X-Gm-Features: AQROBzDalJysxrZn27grdaXVt05e6kb3XI-2svp1NTZOzlE7UWANlWhDRO8Wc4I
Message-ID: <CACSVV01rHMY5NwaZ+e-3GRPNnuVCkYjJJRUzGYvXPi7JzrOgSw@mail.gmail.com>
Subject: Re: [PATCH 01/13] drm/msm: Remove obsolete perf infrastructure
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=HdUkiCE8 c=1 sm=1 tr=0 ts=69e8de1c cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=z5GDcAh91ePceZgdlIkA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE0MiBTYWx0ZWRfXxmNtVGag9l6S
 q//EQz0v5J4BovTFfQvHDmgqja2NxiUoUAyauBiOe0cACKxWuNhrepKtOP9+kKmN7UlkKd94wo5
 +CzmMkR9jcqW18cAzb+3aMLY7j+22nCAr9t8MrbyX6oXC3419xt/h7WbdE35L5ouusnFQIxvsmH
 qUQbruj/FaH6Lzpwg/fGu6c7XDpoj4wuO9K5XC7aVmgks1BkSwcxjbLprExUVcKXcVW6W+kihTB
 j0QQRwCB7Op3/ibhU4SDUZYjFPda9a88Gx+ZssTRqpD5Kl4IBfQVILoj99nr0ghH5X8x0b+7Htn
 erImzqHN3un5d4KAwyareQrgybMt41K486CYnUIo7SnlwhVzU1BKIAZrf0BMKW9019PbXZcg+3M
 amMVGeG9F1VyBfVcJOqm868eDBWlZK2v3O+wI48n6K0vjxP120Dflkj6/5s0DKTyVSsQ7+fH3Pj
 eQ9KTK8QKyUdu8vt8jQ==
X-Proofpoint-ORIG-GUID: 7C-EM82BCzYppM9l0UrsfFK0BY8DbnQ3
X-Proofpoint-GUID: 7C-EM82BCzYppM9l0UrsfFK0BY8DbnQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220142
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

On Tue, Apr 21, 2026 at 5:41=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Apr 21, 2026 at 01:48:40PM -0700, Rob Clark wrote:
> > On Tue, Apr 21, 2026 at 8:39=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Tue, Apr 21, 2026 at 06:07:20AM -0700, Rob Clark wrote:
> > > > On Mon, Apr 20, 2026 at 4:49=E2=80=AFPM Dmitry Baryshkov
> > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > >
> > > > > On Mon, Apr 20, 2026 at 03:25:23PM -0700, Rob Clark wrote:
> > > > > > Outside of a3xx, this was never really used.  And it low-key ge=
ts in the
> > > > > > way of the new perfcntr support (or at least it is confusing to=
 have two
> > > > > > things called "perf").  So lets remove it.
> > > > > >
> > > > > > This drops the "perf" debugfs file.  But these days, nvtop is a=
 better
> > > > > > option.  (Plus perfetto for newer gens.)
> > > > >
> > > > > Would it be possible to resurrect "perf" later? It was really use=
ful.
> > > >
> > > > Nothing is impossible.. but I was having trouble naming things with
> > > > both old and new perf stuff in parallel.
> > >
> > > That why I wrote about resurrecting it later, once the new stuff is i=
n.
> > >
> > > BTW: do you plan to get perf counters for a3xx-a5xx back? I remember
> > > that there was some issue with a2xx ABI.
> >
> > So current state on userspace side is that only a3xx/a4xx are missing
> > perfcntr support..  although it looks like we know the countable
> > enums, so probably not hard[*]
> >
> > In all cases, the existing userspace-only support will continue to
> > work.  The main reasons I omitted a2xx/a5xx on the kernel side are:
> >
> > a) Not really sure how to do the Makefile bits.. since they wouldn't
> > be using a6xx.xml.  In meson I can use a table (2d-array):
> >     https://gitlab.freedesktop.org/robclark/mesa/-/blob/fd/generate-per=
fcntrs/src/freedreno/registers/adreno/meson.build?ref_type=3Dheads#L20
>
> I saw the comment in the commit. I'll take a quick look.
>
> > b) No good setup to test
>
> We probably need to figure this out...

More devices in CI would help, but I'm not really even sure of a great
way to automate testing of perfcntrs outside of some simple sanity
tests (like is the ALWAYS_COUNT based freq measurement something less
than fmax).

The best option I see is to just leave what works, and not introduce
features on older gens that may actually not work.  If there were
infinite hours in the day, sure there is a lot we could do.  But we
are still trying to close feature/perf/enablement gap with current and
recent hw.  I don't see how to continue to close that gap while also
bringing every new feature support to older hw that upstream supports
but android/downstream blob/kgsl has long dropped support for.

I'll accept patches, ofc, if someone is sufficiently motivated to
enable and test on older gens.  But otherwise, to close the gap we
need to run to where the ball is going, not where it was 10yrs ago.

> > c) They don't have IFPC
> >
> > They could ofc be added later.  The main urgency is a8xx, since I
> > don't want to add mesa perfcntr support without PERFCNTR_CONFIG (so
> > that we don't have an older-userspace, new-kernel permutation on
> > a8xx+).
>
> Sure.
>
> >
> > I don't remember about a2xx ABI issue.. but a2xx perfcntr stuff was
> > added after I was already busy with later gens.
>
> I might be completely mistaken, but I think the issue was that the
> kernel didn't reserve one of the counters for its own usage.

hmm, ok.. json has a "reserved" property for reserving counter(s) for
kernel usage.  We do use this on later gens.  Although it looks like
on a2xx there is only a single CP counter (which I'm guessing is the
one the kernel needs)

> >
> > BR,
> > -R
> >
> > [*] there are some counter groups that had some slightly different
> > config programming, like separate clear/enable regs.. which I haven't
> > dealt with yet.  For a6xx+ this only matters for some counter groups
> > (VBIF/GBIF, maybe GMU?) that userspace doesn't care as much about.
> > Idk if that was true for the earlier gens.  Eventually I'll add a6xx+
> > support for these counters, but there are a few other things to deal
> > with first.
> >
> > > > Is it really adding value
> > > > over nvtop?
>
> And I skipped this question. Yes, there is a value, when developing /
> performing early testing. Running tail is much easier than having an
> extra tool in the initramfs (we don't have nvtop recipe in the OE, maybe
> that should be changed).

could you monitor freq from devfreq or some clk related debugfs?

And yeah, getting nvtop in OE sounds like a good idea.

BR,
-R

> --
> With best wishes
> Dmitry
