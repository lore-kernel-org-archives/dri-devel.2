Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA7FCD3445
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 15:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23D610E3BE;
	Sat,  9 May 2026 15:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ABpwWVjw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ixGBWLlE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83AA10E3BE
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 15:34:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6490KpUi1769949
 for <dri-devel@lists.freedesktop.org>; Sat, 9 May 2026 15:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=AQTiS5P2oiFWdLEgVOdRu7bU4r8wnKpKMw3wR2rV5pQ=; b=AB
 pwWVjwZQZtcSo607odhyhAjGd0VqF/8yXabsIaq+sFmSvGLAeGq5fvg6t4wEdmee
 GjwCV//lEhszZGpmEZz7kubXqcq/FU4EFiMoWvmGqGAUO8W3QoF4wJxuoK+L/cDg
 soZZUCVwNY1lJj3OF4kpjp2Ts2rcFu9CmGAhNXDZvQQlZtx/xwzu5ZKZv+LADwhG
 jgOYZDUfUkrhvWrB/7JefuVUs33eePVFU/1Cwj5AVQVfUF3fSfAjm1KT/IVcJYHR
 nOa7XYJ+BGyB0HkUUMxP2CZ/pnGETkmeaXmPba6Qm80RvzGwb6tLbTHantHCkR6L
 nBDdzi7DQwDmoAwumyCA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1t9q1hs0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 15:34:27 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-467dc3431cbso975656b6e.0
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 08:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778340867; cv=none;
 d=google.com; s=arc-20240605;
 b=eFYy/WckJUyKqO6SGQEvm4aat2HP5/gbmAGWmx3abXhyKiJRFSLMUTXeRjPcNr0BKV
 6T0LXWa46sI/lBS3B8YGtDFfHqkhYNA3/JarK9kKEiQ6z6/AYde6omzm8MYrlC/pi9iJ
 4PlWw/jiVti4xB6L9Rm8w8pZdQM1IoeQe9Qsvy44/NInAXQRXs3RtmTLubEl4gN+Qd93
 SEjQqc7Y+lv+NJNGqpJDi0iByGxDDG/oKN1gmg1i3iywxAmKG/vAEq9JvdaQJ2tObTZs
 uDpz74NMpgvl2PfNf4NLM0tOq3MUDwvIQ1OO5uo2JmnnL0V29c3uDDSA2zl/JuMptWpD
 /ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=AQTiS5P2oiFWdLEgVOdRu7bU4r8wnKpKMw3wR2rV5pQ=;
 fh=US5tX2JuVUNjxyNIyREY7ZB1yfupNicbrEdeAc1iewo=;
 b=N0TdTf46OMVgP4msJvAUXNZSIS2ujKM4HqLfrkzutzZF8E5zF153o9pK+R7NeKET1N
 MaysrsLdJbAeEtPMUzUPRKZcqaswu838M6unBj1uP4Ayf8maycASB7iou9/hmEjWcyx5
 U2hzjArzaRewSMiVk5rjyy+emIHDzsR04430Uj9jiAGhYb1MDB1lxJV8CC6rybBIS44K
 KhQN+fVmUEmyT3Kvlud6cM5LnmokInEzqfd384GgwO4Huqw7zwgIPfg9jPfj0hsVbWfi
 75YZRaUclvlXmDL1s/SWV60uDO28hiTNCimNo/jIsgr9J+vxGcSskjQxnb2MiE5eXEs6
 G+cg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778340867; x=1778945667;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AQTiS5P2oiFWdLEgVOdRu7bU4r8wnKpKMw3wR2rV5pQ=;
 b=ixGBWLlEVqnul6XvFk54iG4mhjWgkyDUUrV6IQGIv9k5CxcVLun0lmn3ftxWdGNPcm
 qunk+TSDu0cnxpxWRMqI6lAPT4PUPTXHYwjQPqwqwCY0KdAQgpG62zAeDn29O1N5FRTj
 i/MpuUczPlXHt9FJPe9suobMBLrgXfaoC10cEUqhpHgNDm3sh4v7nMp//9CPMOj/c/Ry
 tv429vVyyjuUzxyI1R4N00e6ip587PbrkFfd9ldIwl6IMWKDLC0Hjkm/trNMykiD1psp
 eM23jGfyeLbipOBhxm1Uepl1YDJrHnrYzwCD23a+jD6Lo7Z/Art3ZHJzWlYBx+yDY+dk
 QR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778340867; x=1778945667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQTiS5P2oiFWdLEgVOdRu7bU4r8wnKpKMw3wR2rV5pQ=;
 b=HUg2tpvfDR0AHG0iX2XmcDSkNxIU1LweFeYG7XKoOSvejGHW9Rr6ZI2mkysZk3Vmzc
 PvU474Lzsc9tNmiEveOTvFGGjj7OJhiXMy8QjzolALLafy4Vu/ALdPPhEF4cxeaKDUSV
 AwJ+q00Mcgb90EcnkjycHx4sccw5WdnNdaWwOkanZqlzcd0ZqYa+Aonl0MHFCdNWleyS
 ff8aRi+5+36ERuJ3Lm0nGPfIXVh0+3WWsXu8ItSsKpivo6jT8Zvx9mjXWN4wRjG6TKCQ
 Tz/YPkYgXWbsm6djI1ux8qTVqKdai+LCR5ETmgH51jzkTDj71+FEJy/z/ulD423LmXW0
 /akA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DI8V+eLe2mTxbbi0Ktkt+e2ph9yGdctkoAZV5jBeK8mhdSfrqUxCjvMPaBRrPbbdwJEceUyKSNd8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5ah3Bau9kmKNC1kmRjNeKuaMHPoknXoUtupS4Sxur2Fis1Lh9
 of7AY6jf6b5/566CGkPAsBb/19uU7bDl1dkfcI7aFRqWWuTgcjs+kbumyUDSYRRxALeSyLjDKCE
 HvjPybR2CU6bFV/y2pzp6HN8QREKtKRqAi7RG/i6BfDWK5ilvqza1G3KMmS76y8EYWR7xHxzbbc
 q/xWFDY1VAiCfBmU7cBNS4uVjwnH859YrHf6GILtBBrY8dRQ==
X-Gm-Gg: Acq92OF90lfMJJ2n90NTxLpV2FB1KWM53P1wghR5Pd5YELYOFc++FRpE5OLwnLNGUs7
 K/kDV24Dr4hlZLrWPVtQDRDIb6rOuEJmhT/LGoRvThkomzmxpcabw//sY6xryt6ZIoeAGduofpT
 23SVRKhFILqDPmIsB8aH1I8EwJBzF0qxYwSbrKjNq7qBPk14iIXKuTYS9WUYBYO97KPD8ylkOo7
 6jlg9dPwHJ5rDrc4OYjBhrPo47RFoAg64pPhQ==
X-Received: by 2002:a05:6808:f8c:b0:467:255a:7453 with SMTP id
 5614622812f47-4824a6c5a04mr1570581b6e.14.1778340866794; 
 Sat, 09 May 2026 08:34:26 -0700 (PDT)
X-Received: by 2002:a05:6808:f8c:b0:467:255a:7453 with SMTP id
 5614622812f47-4824a6c5a04mr1570561b6e.14.1778340866232; Sat, 09 May 2026
 08:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260508065722.18785-1-daniel@quora.org>
In-Reply-To: <20260508065722.18785-1-daniel@quora.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 9 May 2026 08:34:15 -0700
X-Gm-Features: AVHnY4LYyvwLr8XG8e2YiuOn8i1bG5G0Km9pemR5eMsqy_jRO5574zgwrGB50VQ
Message-ID: <CACSVV02t99r2JpT9EUar_YRs+zgpzjNYgNvvB9BGLLnpssY4BA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix shrinker deadlock
To: Daniel J Blueman <daniel@quora.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: BmiVWd9rQOU58tTqd_XwUjTXvCHN8-k1
X-Proofpoint-ORIG-GUID: BmiVWd9rQOU58tTqd_XwUjTXvCHN8-k1
X-Authority-Analysis: v=2.4 cv=J7yaKgnS c=1 sm=1 tr=0 ts=69ff5405 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=t9ty7G3lAAAA:8 a=VwQbUJbxAAAA:8
 a=T09HirTOTrSZx1JCU_UA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE2OSBTYWx0ZWRfXyUPArflcDyf+
 cHmq1pW9Ky2AeuVFBNFN9QcHncqflsIS/MAwQ/cb6cMqTRVqUtPy5s4FW+fhPLaUlVeiesXiYOF
 oORnQRdI1iYsDAe73ApvbWHxcIH0atBPz419WnWTBKrCrqUJ2wUVjkMiPHui7wvmBzlcFRvgvIb
 yoZa/M7W9Hx73VGNye7mLnSBNSTn0UH5VzYdI4WSIYenAxlCzeXVsyU0eadweZUOc5A8Yac9kQK
 KrAC/ey6v8cuTj3yMtjNhw+X1HffdjCuPihzN8/ooeap7ZO0AwUv3v62IUZC8Ch62lq3vf8eSW5
 QhSBNdyaOlqS+m4VY6ohiNV4tF+MDNjhrxPhUGNdQxAa1V7uM41Xxl76Z6YYUhc92pmjWOQ+TV6
 ckr/t7y+7KGgfcE0Mg1/0OZ1Byjswc7AucBuSiEdryMGhu/A9ibBsG/ZOS8TvyC9kS8i5MYaKqo
 CnwChx2c+VJ/3w0fbyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090169
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

On Thu, May 7, 2026 at 11:57=E2=80=AFPM Daniel J Blueman <daniel@quora.org>=
 wrote:
>
> With PROVE_LOCKING on an Snapdragon X1 and VM reclaim pressure, we see:
>
> """
> kswapd0/121 is trying to acquire lock:
> ffff800080ed3800 (reservation_ww_class_acquire){+.+.}-{0:0}, at:
>   msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189)
>
> but task is already holding lock:
> ffffbf4ddb44ca40 (fs_reclaim){+.+.}-{0:0}, at:
>   balance_pgdat (mm/vmscan.c:7236 (discriminator 2))
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (fs_reclaim){+.+.}-{0:0}:
> lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825=
)
> fs_reclaim_acquire (mm/page_alloc.c:4325 mm/page_alloc.c:4339)
> dma_resv_lockdep (drivers/dma-buf/dma-resv.c:798)
> do_one_initcall (init/main.c:1392)
> kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.c:1470
>   (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:1703
>   (discriminator 1))
> kernel_init (init/main.c:1593)
> ret_from_fork (arch/arm64/kernel/entry.S:858)
>
> -> #1 (reservation_ww_class_mutex){+.+.}-{4:4}:
> lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825=
)
> dma_resv_lockdep (./include/linux/ww_mutex.h:164 (discriminator 1)
>   drivers/dma-buf/dma-resv.c:791 (discriminator 1))
> do_one_initcall (init/main.c:1392)
> kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.c:1470
>   (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:1703
>   (discriminator 1))
> kernel_init (init/main.c:1593)
> ret_from_fork (arch/arm64/kernel/entry.S:858)
>
> -> #0 (reservation_ww_class_acquire){+.+.}-{0:0}:
> check_prev_add (kernel/locking/lockdep.c:3165)
> __lock_acquire (kernel/locking/lockdep.c:3284
>   kernel/locking/lockdep.c:3908 kernel/locking/lockdep.c:5237)
> lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825=
)
> drm_gem_lru_scan (./include/linux/ww_mutex.h:163 (discriminator 1)
>   drivers/gpu/drm/drm_gem.c:1681 (discriminator 1))

Your line #s don't quite match mine, but AFAICT this is from the
ww_acquire_init()

What I'm unsure about is if this could cause live-lock against another
operation which requires obtaining both obj and vm locks in a
potentially different order (which would also be using a
ww_acquire_ctx ticket to backoff in case of conflicting locking
order).  It wouldn't deadlock because we don't sleep forever if we do
sleep, but...

Possibly we should also be using trylock to also acquire the vm lock,
but lockdep would still complain as it doesn't know the ticket will be
only used w/ trylock (unless we did something hacky by using a
different ww_class?)

BR,
-R

> msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189)
> do_shrink_slab (mm/shrinker.c:436)
> shrink_slab (mm/shrinker.c:667)
> shrink_one (mm/vmscan.c:5071)
> shrink_node (mm/vmscan.c:5132 mm/vmscan.c:5210 mm/vmscan.c:6198)
> balance_pgdat (mm/vmscan.c:7052 mm/vmscan.c:7228)
> kswapd (mm/vmscan.c:7501)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/arm64/kernel/entry.S:858)
>
> other info that might help us debug this:
>
> Chain exists of:
> reservation_ww_class_acquire --> reservation_ww_class_mutex --> fs_reclai=
m
> """
>
> kswapd0 holding fs_reclaim calls the MSM shrinker, which calls
> dma_resv_lock. This in turn acquires fs_reclaim.
>
> Fix this deadlock by using dma_resv_trylock() instead, dropping the
> subsequently unused passed wait-wound lock 'ticket'.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Fixes: fe4952b5f27c ("drm/msm: Convert vm locking")
> ---
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 34 ++++++++++----------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm=
/msm_gem_shrinker.c
> index 31fa51a44f86..5320ef57dd90 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -43,8 +43,7 @@ msm_gem_shrinker_count(struct shrinker *shrinker, struc=
t shrink_control *sc)
>  }
>
>  static bool
> -with_vm_locks(struct ww_acquire_ctx *ticket,
> -             void (*fn)(struct drm_gem_object *obj),
> +with_vm_locks(void (*fn)(struct drm_gem_object *obj),
>               struct drm_gem_object *obj)
>  {
>         /*
> @@ -52,7 +51,7 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
>          * success paths
>          */
>         struct drm_gpuvm_bo *vm_bo, *last_locked =3D NULL;
> -       int ret =3D 0;
> +       bool locked =3D true;
>
>         drm_gem_for_each_gpuvm_bo (vm_bo, obj) {
>                 struct dma_resv *resv =3D drm_gpuvm_resv(vm_bo->vm);
> @@ -60,23 +59,14 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
>                 if (resv =3D=3D obj->resv)
>                         continue;
>
> -               ret =3D dma_resv_lock(resv, ticket);
> -
>                 /*
> -                * Since we already skip the case when the VM and obj
> -                * share a resv (ie. _NO_SHARE objs), we don't expect
> -                * to hit a double-locking scenario... which the lock
> -                * unwinding cannot really cope with.
> +                * dma_resv_lock can't be used due to acquiring 'ticket' =
before the
> +                * fs_reclaim lock, which is held in shrinker context
>                  */
> -               WARN_ON(ret =3D=3D -EALREADY);
> -
> -               /*
> -                * Don't bother with slow-lock / backoff / retry sequence=
,
> -                * if we can't get the lock just give up and move on to
> -                * the next object.
> -                */
> -               if (ret)
> +               if (!dma_resv_trylock(resv)) {
> +                       locked =3D false;
>                         goto out_unlock;
> +               }
>
>                 /*
>                  * Hold a ref to prevent the vm_bo from being freed
> @@ -108,7 +98,7 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
>                 }
>         }
>
> -       return ret =3D=3D 0;
> +       return locked;
>  }
>
>  static bool
> @@ -120,7 +110,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_c=
tx *ticket)
>         if (msm_gem_active(obj))
>                 return false;
>
> -       return with_vm_locks(ticket, msm_gem_purge, obj);
> +       return with_vm_locks(msm_gem_purge, obj);
>  }
>
>  static bool
> @@ -164,7 +154,6 @@ static unsigned long
>  msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *=
sc)
>  {
>         struct msm_drm_private *priv =3D shrinker->private_data;
> -       struct ww_acquire_ctx ticket;
>         struct {
>                 struct drm_gem_lru *lru;
>                 bool (*shrink)(struct drm_gem_object *obj, struct ww_acqu=
ire_ctx *ticket);
> @@ -185,11 +174,14 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, st=
ruct shrink_control *sc)
>         for (unsigned i =3D 0; (nr > 0) && (i < ARRAY_SIZE(stages)); i++)=
 {
>                 if (!stages[i].cond)
>                         continue;
> +               /*
> +                * 'ticket' not needed on trylock paths
> +                */
>                 stages[i].freed =3D
>                         drm_gem_lru_scan(stages[i].lru, nr,
>                                          &stages[i].remaining,
>                                          stages[i].shrink,
> -                                        &ticket);
> +                                        NULL);
>                 nr -=3D stages[i].freed;
>                 freed +=3D stages[i].freed;
>                 remaining +=3D stages[i].remaining;
> --
> 2.53.0
>
