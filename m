Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92072CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 17:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCABB10E0C9;
	Fri, 15 May 2026 17:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e489gtb8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EnVORkqT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7B910E0C9
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 17:00:19 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBAJg33795527
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 17:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=gEQuph5mrSxtOht+wEEil2qGcAWnLTsZ9WH58wSoVTg=; b=e4
 89gtb8Bp9RN0Sywu0uixaS6IdgOXP8h8d6sPvc4jRrKzPFdaFwgYrXBTx1yj8Y4s
 4Cmoa4HOTgPR7+tWglVUsYyFVeL6ZftnWCSxJx52hV9W3538tSf+YLMTxSbfZTbj
 0CjP2VlPXunOQIBQ6jc6QmKqHAVWuhNddjiLy+c9LvELmbnd2Zt+EqU6xDokXIuL
 jFwo5bfA+icL1AGLsK5Z5TiKjdz54dfdrJ2kLnQUYtCW/KVZ8CgK1zDyFTvuPkm/
 teia6Imb3EcKGnXh4rV7ZlOSXPyZRHXIQ50ol/Kwmw74LIvudWARw0Rem0aZBoHG
 uzURPaSKoH/WVdDdIpZQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sv2uu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 17:00:18 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e3a223b936so16013455a34.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 10:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778864418; cv=none;
 d=google.com; s=arc-20240605;
 b=I0J7h4O6iIfO8nUtXfPl1KuzYdJ+5VKP7HtgOhdbxvk0RMwU2teQbxINSjMm7PBmhP
 MyT1C43BneaN2ehH778mzV0BzjQTaDmQx2VL9WTvR69CJXvwCB4KmmclrylaWU20NG+7
 7RCwklzdzEzh4sNt9aamZTRY4Yh01OPmfknqj3spUQdGYJMODejb3ELElJBpwsO0Lcxz
 Lagc9m+tN9058P3TkjjPXMag0peRRCZbJYl7uRoUs1Xipbj4QYILyE6yKFuP9sQ7Da0p
 3xkOWnHLP1/IqatnMBKBj/MMHeUYURRUAA93q7NI7wE8SDuwXiQaLOpRQT+Y44HQUZpd
 5YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=gEQuph5mrSxtOht+wEEil2qGcAWnLTsZ9WH58wSoVTg=;
 fh=bk0FBlaOCAmN5Su/PgW5zVIiy7nj6/ad8pKjgpfNQdw=;
 b=ZYdzgtQYSRs5UNilhiU92EAkAfKWSnuKEjFnx1i6tOkOKDgUkKfYlNrmjXcaDyiFFq
 YbYjBxdpPEDnEC6Rcb/UqtNThXpJ6pPo3doRmYSt0KSUQs55sBfGJpnNwLTZ9qL/utet
 ByyTgklKQg5UNP/N4VL9tS7jRYD/zhFH/8X2NlYLrc0wmva7fW7fTkObcq7+Jvl840UZ
 eJITLKZzds39VBsODNSd16TVz1a/1XLexJskzMex5i5XgX1BqWzYhPNi0NZk4bhN/ci/
 K+m/9J3dZlXtWs/0+63sXCOF8yZXsyKNJj//QYwZesqNW3xGgySxsVxEdiNp0yemXywO
 B3/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864418; x=1779469218;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gEQuph5mrSxtOht+wEEil2qGcAWnLTsZ9WH58wSoVTg=;
 b=EnVORkqTwwkB1xHEHAVjj1XGlGPD9dHLVjwj2mcswCVUtca9Zic9lArv2YNz6W7xPx
 Atc1CHKbwcUzRd3kvyXbWhPVzR7DYUHXSaZ0Pwfh5FdnEF6RDGmp6Y7dezSvGeTSQTsE
 ccc8keWSQAePeWEeVy9zOKtzdsH9jvDOg3IS84ey5EQehRmfD1reOLuIZ8rVDZCNrmjW
 U80HUp9YSHFXATMU+scWQzBPegzf+BhkoEsTMz6yVtdtw+j8E/pYFLw9Pu/QWT51DLtF
 C+WT/aD3z77cH84BfUhKC4RQuMfL9aWFXiSSUogN8WbA2S0DxSqvXhQlqI+ZJZktS5Fn
 KQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864418; x=1779469218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gEQuph5mrSxtOht+wEEil2qGcAWnLTsZ9WH58wSoVTg=;
 b=C9/bI/9pRA2UD6PCNbHHCkzOQsmjXYqJyMOzR3rebDRgY2M84VZk9HO3EGosgRBbIE
 0VtNwNk10vo2VUG/+ijdppAf8lw7LTKgHMcDuGGhcKU5EsAAsmL704Ck4XGZBhklzYdq
 KLSPB9FzffwV7q0gJ7E4pyg1ko1LgIgrVTQOrv7K/AHzp9ItvlLjDC09kvD0blmaG6KF
 vqZcyWJqocL94qg1TVcW3Vx3pxbLKLmqZzhNJd6vysiYQabu2uriB0ZVMKhQlA5HeuuQ
 viZvbIvNAaXmDpqA3pzMho9g9henox2zILD0KS7Vr+rBmSnITu7sZWqhevhq46YQTojy
 FGXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SSqE4AI9lgmAYBIXU6yTv1bfn8vHbSdSUnoqlbeTEnS2jaNFzlOYI//i0jPTssaqxrGnm5r71wIs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywa1b3ffGQHc0Ewz/W0odtH4VWPzkIzYKm4Hu58tW8V8P5fXRmo
 IN1BVwOgEQ/X8PnNJpuymdoBhIu6Ez0dLrEH7spfXW2QafirkKZBRBRBOFkbXOrUV4fHZAiVXqo
 kwbxR+BaLf+FbJeBeioNkKVznClPfNypjQxONJGCY/95O+XytGD7eSo/lneIU7kWCAd5WdgfOg4
 rIPMRy5syPDlkSsozXQJGKGp9Su4IC5MVCG68HLLa+dF1emQ==
X-Gm-Gg: Acq92OH68ZY9o3unqFXufaYYjw6NtB5s/48VIaGx35RX42cDf5Fe+trRyWGNUJqZZVW
 rwrV8+UVSiLJD2hhfcxgsXjLrEf6kAc4pGrBsOsMEXqbG5qsZe32oFZEN+qiQejIZTYVRn7vUI/
 zZ2lmYrI72zOb+61chmqIA/E0R0bYSpZdlcNzAGF30tJPO5mPeQEK8hA0dk7GA1nnaWJcCMQHI7
 qPeY07ZTx7gICA58Bob1/MqqO1iNW5M/FWbMg==
X-Received: by 2002:a05:6830:34a2:b0:7dc:e53a:638 with SMTP id
 46e09a7af769-7e4f2a36b52mr3247343a34.8.1778864417697; 
 Fri, 15 May 2026 10:00:17 -0700 (PDT)
X-Received: by 2002:a05:6830:34a2:b0:7dc:e53a:638 with SMTP id
 46e09a7af769-7e4f2a36b52mr3247315a34.8.1778864417079; Fri, 15 May 2026
 10:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260508065722.18785-1-daniel@quora.org>
 <CACSVV02t99r2JpT9EUar_YRs+zgpzjNYgNvvB9BGLLnpssY4BA@mail.gmail.com>
 <20260511093325.74e2777f@fedora>
 <CACSVV03ZMuVEK6OegD8YKg4RwHWTU_CbWcwdWKSeyiaU=yV1Fg@mail.gmail.com>
In-Reply-To: <CACSVV03ZMuVEK6OegD8YKg4RwHWTU_CbWcwdWKSeyiaU=yV1Fg@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:00:05 -0700
X-Gm-Features: AVHnY4Jj1ZoXxcHVpYJNicpNIWF6MookH-kkJjYTzQBGu41KOZjcqQvgcCazWp8
Message-ID: <CACSVV03eU737as7PTL6mCJm7PetY6wd6v0Up5H7P08oOQiDQZQ@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3MyBTYWx0ZWRfXyVF2cdVYClCN
 Nt6F45b+0WjUqJ+stqf2+TzVG6udvIYzwnUGBK9PP/2/UW2W1m09pB38ZEISl3G1P3iSv0z9ZO1
 zPWpofiQQ5mUgjsERHgoM3M5DMrojMF5RP/GyLv0XhvXxHnN4gIhRuXD2T5h8rcL9UUZMNdIyAn
 9Q4ZxVQMYV0i9kMyCGlnFChsrkvrwsETtzEGRub6VoZRfvd5Cgwlhqht5YvLM43eFYKO47oIFP+
 OdNRzF/IzypFlK5jq4CDsg/W+mnPhnnATSeQLkBMEZlhytO1epEd2atOo+VpnmIgCxQ56pmiSNb
 GOc53sn/HfqKdXewEtjEl3tuwS6JXB4ixjh8xRWmdVQH9lTiwE6WDTH/tKHtR3/n6c2QKRbO9fF
 ePwh2zPk+oEZt2fomPklfpV/tpU7rRsvBzmKw1lH0+FqHD3m+jZKJURZeZ9WE4JhgiBUlmspjEV
 9h1wBe+xlIoPPRVXpsg==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a075122 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8
 a=t9ty7G3lAAAA:8 a=Dq4ky0DoUOac6QxOf6oA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: Fby6MPgo-jbmFQ4FFH38DeMJsm4Z84Xn
X-Proofpoint-ORIG-GUID: Fby6MPgo-jbmFQ4FFH38DeMJsm4Z84Xn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150173
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

On Mon, May 11, 2026 at 6:16=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Mon, May 11, 2026 at 12:37=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > Hi,
> >
> > On Sat, 9 May 2026 08:34:15 -0700
> > Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> >
> > > On Thu, May 7, 2026 at 11:57=E2=80=AFPM Daniel J Blueman <daniel@quor=
a.org> wrote:
> > > >
> > > > With PROVE_LOCKING on an Snapdragon X1 and VM reclaim pressure, we =
see:
> > > >
> > > > """
> > > > kswapd0/121 is trying to acquire lock:
> > > > ffff800080ed3800 (reservation_ww_class_acquire){+.+.}-{0:0}, at:
> > > >   msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189=
)
> > > >
> > > > but task is already holding lock:
> > > > ffffbf4ddb44ca40 (fs_reclaim){+.+.}-{0:0}, at:
> > > >   balance_pgdat (mm/vmscan.c:7236 (discriminator 2))
> > > >
> > > > which lock already depends on the new lock.
> > > >
> > > > the existing dependency chain (in reverse order) is:
> > > >
> > > > -> #2 (fs_reclaim){+.+.}-{0:0}:
> > > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.=
c:5825)
> > > > fs_reclaim_acquire (mm/page_alloc.c:4325 mm/page_alloc.c:4339)
> > > > dma_resv_lockdep (drivers/dma-buf/dma-resv.c:798)
> > > > do_one_initcall (init/main.c:1392)
> > > > kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.=
c:1470
> > > >   (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:=
1703
> > > >   (discriminator 1))
> > > > kernel_init (init/main.c:1593)
> > > > ret_from_fork (arch/arm64/kernel/entry.S:858)
> > > >
> > > > -> #1 (reservation_ww_class_mutex){+.+.}-{4:4}:
> > > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.=
c:5825)
> > > > dma_resv_lockdep (./include/linux/ww_mutex.h:164 (discriminator 1)
> > > >   drivers/dma-buf/dma-resv.c:791 (discriminator 1))
> > > > do_one_initcall (init/main.c:1392)
> > > > kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.=
c:1470
> > > >   (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:=
1703
> > > >   (discriminator 1))
> > > > kernel_init (init/main.c:1593)
> > > > ret_from_fork (arch/arm64/kernel/entry.S:858)
> > > >
> > > > -> #0 (reservation_ww_class_acquire){+.+.}-{0:0}:
> > > > check_prev_add (kernel/locking/lockdep.c:3165)
> > > > __lock_acquire (kernel/locking/lockdep.c:3284
> > > >   kernel/locking/lockdep.c:3908 kernel/locking/lockdep.c:5237)
> > > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.=
c:5825)
> > > > drm_gem_lru_scan (./include/linux/ww_mutex.h:163 (discriminator 1)
> > > >   drivers/gpu/drm/drm_gem.c:1681 (discriminator 1))
> > >
> > > Your line #s don't quite match mine, but AFAICT this is from the
> > > ww_acquire_init()
> > >
> > > What I'm unsure about is if this could cause live-lock against anothe=
r
> > > operation which requires obtaining both obj and vm locks in a
> > > potentially different order (which would also be using a
> > > ww_acquire_ctx ticket to backoff in case of conflicting locking
> > > order).  It wouldn't deadlock because we don't sleep forever if we do
> > > sleep, but...
> > >
> > > Possibly we should also be using trylock to also acquire the vm lock,
> > > but lockdep would still complain as it doesn't know the ticket will b=
e
> > > only used w/ trylock (unless we did something hacky by using a
> > > different ww_class?)
> >
> > FWIW, we started using a ticket in the initial version of the Panthor
> > shrinker, and ditched it at some point because of these unsolvable lock
> > ordering issues. It also seems to me that trylock-all-the-way is the
> > right solution, and if we trylock and back off + immediately move to
> > the next BO if any lock is already held, the ticket approach is not as
> > useful, because we're not going to use the retry mechanism provided by
> > ww_mutex anyway.
> >
> > It's true that it does the bookkeeping, which simplifies the rollback
> > procedure, but if you look at the other locks taken in the shrinker
> > path, they are static (one per-component involved in reclaim) for most
> > of them, meaning the rollback is pretty straightforward. The only
> > exception is the VM lock (one per vm_bo in case of shared BOs). In
> > panthor, we just decided to open-code this rollback logic (see
> > panthor_gem_try_evict_no_resv_wait() [1]) instead of teaching ww_mutex
> > about non-blocking locks when a ticket is provided. Not saying this is
> > the best option, but it works...
>
> hmm, ok.. and if we block waiting for BO that is before grabbing the
> vm locks so no live-lock concern (sry, been a while since I've looked
> at this)..  So I guess trylock is maybe the better approach.  In this
> case we should drop the ticket arg (basically revert commit
> 02070f049875 ("drm/gem: Add ww_acquire_ctx support to
> drm_gem_lru_scan()"))

I'll pull this into msm-fixes.  I've fixed a compile error with the
original patch (and replaced the lockdep splat with something
legible... somehow whitespace was swallowed with the original).

For next cycle I'll send a cleanup to drop the now unused ticket arg
for drm_gem_lru_scan()

BR,
-R

> BR,
> -R
>
> > Regards,
> >
> > Boris
> >
> > [1]https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/=
drivers/gpu/drm/panthor/panthor_gem.c?ref_type=3Dheads#L1425
