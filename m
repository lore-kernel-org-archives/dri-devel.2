Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813A606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CBINMe3c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DcnwrIgp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E677B10EF43;
	Mon,  2 Nov 2026 14:36:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2A110EF32
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 14:36:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpMl94070512
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 14:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=; b=CB
 INMe3c8uOlrNhX43LITRHcaOovKgxvtVbS7dRMICt5u23ota/C8ZxYfEkwYxDnYI
 2TgQ57dHXJC551g3ztgC4ef8fg3rd8+XToZTnEo6c/qkpB5TZZ9H2ads0AxsDOWY
 C5Ye0MkR5C0zLWq++rCBZtHtiVaHFjzFHzYtT2bFufGCmKA6r51vpdrti1fcZku/
 BT6WZYrTQhXLPF91UWkr4nUhozHyev9oLnwfzZhfwK92cbjaax/hWw2Ymd1kYObY
 +L9SnK46FX8ReHr10BpRlPukwh31cT8M9k122winWjUhaOo2E4QvO47ORblhlsr6
 5zMVEL9VF/2ZrM9KseGg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpss5gp5q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:36:12 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-8452af97d8aso3769789a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 06:36:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793630172; cv=none;
 d=google.com; s=arc-20260327;
 b=StNJosBvjdZStwGqe6kWOAeg0C2sYs90Wc7IBgoBj4rqCVjzSDWKj4R2lj4mlAofaP
 /Dh3M1Keazaf9nGeZK/pQsIxt0voFCu+4ZNz56yh3RMzHQi9zKMGgSrt/hJWR5Hds7O1
 PyKou/UsTSdsINVbLmgbNfKXEbyWJUsLptkn65pYxKU41L2mM3wwtDeE54mtm5eME3Hn
 bxsN9ENcUst280iX7JgTxYzK5W6e1/JXTB+W/gzQo49X3DO/CcDcECtKOl1hIxNfrOwt
 zBqE92ojX2djcNomtO2m6p5WvoyC3aJus2DwAgES456qm+CkESlQr9uCg9xKh2B8K/cB
 ngkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=;
 fh=okevp23xI9xuHjHY7gFLmIFux5lrZApfbBpZMbjQ4RY=;
 b=EKf2IIyzVmEAn1kpP9pJofNb3+7izNJHG2hyuE6JJvp7ezq0CYhiLzmc37Hd+ghr8h
 DK7dkqdqu7/2MJhtpqivoeW3Iom7of9wpAkbmQiXibl7i8eKUyrIGOePC43Zfc8z/fGu
 UcWo1RXR7STg14sA6cP9AN1UqrMzGj+VW63fehh/dv30NZLBIcJZu5hvwyXGAFGd6Ap8
 3KB6xcyVLBgWbor4d/RMxcfJcSLHegzZeyZwLGLmmjwbgy5JjOZtWuqENnNVEcyQBUil
 RTXis3Iq232UZEy2XkIEVhy38oira7dvDO+QhP+SYQ5HQNCvK+nTPC43A+53O1T5tokY
 90dA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793630172; x=1794234972;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=;
 b=DcnwrIgpCS/aQMQP9iVy5L7iiRBGJuZsAGP/1iWruab63rflv+3pej+Ka6tFzUPdHR
 jG1tTFKIdxbt7bGHYXntdTyAmMZSbripqhHCRvLksf6sxkD0M/jkbdAsRvJhkEZuDEhI
 iKQ6lo//1UUKsUqyU7fgrN5SLG1LNbEZVBrpneGLajg+PO+2SyOb/kcYtl9pmeYUCL7x
 yOIQ2RJuOF/cnMZHFouHFz4qkglPcXCIpOM7BNMty1D4ADlPdNec9//2tB5FVnDXJ0MT
 xzZ9s+GYM7gknHqoq5Eqot9yAEqjqlQ5wK7o3VfDbKgihyLjMmQIB71tNpcW2CW6AcA7
 Eh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630172; x=1794234972;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=;
 b=xvTQfJxgi/dVK3mvb+Umj1Q9sE0jUdEhtmNOmLam5Uq6HEr9iK3mpZ8X3G5BSku/fn
 WhMg5H+2nfzm0QdnecYhecnUX52odbpc4EHx8lRHlIAj4IsEY+aKdvfWUz7OEqK4Dwq5
 sb94AjmtCXswXVvbUQVcPJs6QeHpMd6pQkSTg3W+8gPk8b9llpNfRXz3tev99jh38kKI
 sJhUKfUtJp+HdV/wBxQ1Kq2Gt1rHch72dPtZ5uhQANo09jcgImmtqJVRQL7gWUUdcBJC
 meKiyy0hiHGwGuOYngk7Ai3JD8QsTFpFqJWhPgvhgDkTMVM8FpswgPFq9qYj1exrs/zF
 TBYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0Cuz9vnJhHPExfmCeZTmtxvTyz2xHYMA+8pG2pdhuVukTJXHyPZqmluj90waXezKfPn7D9gZ0Lvw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwQLWEbzOOmPONbxgzbb6UHRUFzhVfOjD/3Rkl4Qb0lmqjLI5j
 wAolqtFv2hqSf3/eqjjVOCJs5wtLsSGdia4j5sUFiE09CrMQ/uTVeWnG0eBwjUY3DweyYznBsqz
 HBYdVuPukd+JQFSaglJ8v22/Jp2qXmfmpUDsZmouwyCEgbEKe5BnPV9TxB1r6nuukI7yuDKQoo1
 bCeXVhFA7NLAaSU8LCIDLpaHoZEqerM2BwFVoxuPGQBWX3VA==
X-Gm-Gg: AYBFou23ZMJrO8c9CKa/LdiJjs+6aNVZ2H2bFTCG6rhe6hg6M9ViNtEHxcuLT7iuT64
 fYXKpW5EcPP4dvs2e86g/lk+AJb4w1GXva0UBeGjwLkDyxjFPSMol9gq0yQIyvOwBUGC5T9zFXL
 L/4LqwuSReD5wkBNquSnSPxumwcmRBx8ijvuuYhEc32WUH04EN/wZjaFuZRg==
X-Received: by 2002:a05:6871:2b26:b0:4a6:f484:e880 with SMTP id
 586e51a60fabf-4a906c77708mr6209085fac.0.1793630171568; 
 Mon, 02 Nov 2026 06:36:11 -0800 (PST)
X-Received: by 2002:a05:6871:2b26:b0:4a6:f484:e880 with SMTP id
 586e51a60fabf-4a906c77708mr6209058fac.0.1793630171045; Mon, 02 Nov 2026
 06:36:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
 <20261101180508.66598-2-nicoangelodelacruz@gmail.com>
In-Reply-To: <20261101180508.66598-2-nicoangelodelacruz@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 06:35:59 -0800
X-Gm-Features: AclHuK9gfrDGQ5PLQCt-XA9GyuDskdynBG1Pwp73OvlDTnKYRXDLZaDVIm7EHOk
Message-ID: <CACSVV03TBrktnuhphsTPxJPKrvtiAtngYGx4yGo7hL-Q6TCybQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/msm: serialize devcoredump reads of the crash
 state
To: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=VORIDNPX c=1 sm=1 tr=0 ts=6ae89fdc cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=gB-Dnt9bVocfTiBQhWAA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: ix9cVLsAJoFHW9hoYvnMLZ_Ex6HhckrQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX1sDttcTcEYot
 pLiOm9F8lkUg4g7Hk72LkqrS9IdXQqXni/J9RX6oxSx3MR5+ik/Ia63/BPR89LZOZoJ7U/t82xv
 gULVh43DcjjGAPOze9vzmMRaNbeHXbXfbDn89Mp1PiHTLUbCgXcp1Y+7zg+wUACxS3Yg34ILhHE
 fc99qOi3fcXyEY+5800OehNjOtFL9IsPv7HLm7i9Uiro1ErIgxtWRn/UTXJ7KRFwRzzpa5HOxYN
 ac6P5/0+Xi9Co+aU+gwn1edfdHiUrUljwBSiVwZT8GmjGt3PCEAxWOzl3MKV390hvBZr/xwaPbn
 NvePv8pKfdSKhhSjD80CcGx8cwHgp/y3sbDyMl2nqzUS1fiVFPkbc/eDNmiuFfW2u4lIuf/MtFO
 9I+H+U0isRadVS/tYLTynYBtHmLrJfPlNR6hWvtoXfvFt4GO7SduOKhH34542UJHfXkdYsXfh6a
 WpvY9rsFpH5SSEk/olg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX9x2/sfntsTKn
 wHylHLQ8fw2NGENv86qnCZXgDLewFI3SiSbZ0VOGraOfyUeFtSqtIeCuwuzk810BKYn6GpL0Clr
 hQDn/Qlk4plDi1yC6XM6AUqo2srt6LI=
X-Proofpoint-GUID: ix9cVLsAJoFHW9hoYvnMLZ_Ex6HhckrQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020058
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 10:05=E2=80=AFAM Nico Angelo Dela Cruz
<nicoangelodelacruz@gmail.com> wrote:
>
> adreno_show_object() converts each captured buffer to ascii85 the
> first time the crash state is shown, in place: it checks *encoded,
> replaces *ptr with the encoded copy and kvfree()s the raw buffer.
> msm_gpu_devcoredump_read() only takes gpu->lock around the reference
> get, and every read() of the devcoredump renders the whole state
> again, so two processes reading the same devcoredump at once can both
> see *encoded =3D=3D false and both free the same buffer, or print a
> buffer the other one just freed:
>
>   WARNING: mm/slub.c:6733 at free_large_kmalloc+0xb0/0xf8
>    kvfree+0x44/0x60
>    adreno_show_object+0x190/0x240
>    adreno_show+0x1d0/0x438
>    a6xx_show+0x68/0xbd0
>    msm_gpu_devcoredump_read+0x144/0x1f8
>    devcd_data_read+0x34/0x48
>   page dumped because: Not a kmalloc allocation
>
> The dump also changes length between reads, so a reader can get a
> short copy that ends at a page boundary.
>
> Seen on an Adreno 830 with IGT's msm_recovery reading the devcoredump
> while a udev helper copied it out: 16 such warnings in one boot, none
> with this patch.

Probably also something that igt should cover..

> Add a mutex to struct msm_gpu and hold it while the state is
> rendered. Only one crash state exists at a time, so a per-GPU lock is
> enough. gpu->lock isn't used because a devcoredump reader would then
> hold up recovery and fault capture for as long as it takes to render
> the dump. The new lock is taken after msm_gpu_crashstate_get() and
> dropped before msm_gpu_crashstate_put(), so it never nests with
> gpu->lock, and it is taken interruptibly so a reader waiting behind
> a slow render can be killed.

You could have a 2nd state snapshot live with the debugfs path, fwiw.
Note that I'm working on some IFPC fixes in that area[1], originally
part of the a8xx state snapshot support.

BR,
-R

[1] https://patchwork.freedesktop.org/series/177370/

> Fixes: 1df4289d5b23 ("drm/msm: Optimize adreno_show_object()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 10 ++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h |  8 ++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index fded78fdb..428dc9666 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -191,11 +191,18 @@ static ssize_t msm_gpu_devcoredump_read(char *buffe=
r, loff_t offset,
>         struct drm_print_iterator iter;
>         struct drm_printer p;
>         struct msm_gpu_state *state;
> +       int ret;
>
>         state =3D msm_gpu_crashstate_get(gpu);
>         if (!state)
>                 return 0;
>
> +       ret =3D mutex_lock_interruptible(&gpu->crashstate_show_lock);
> +       if (ret) {
> +               msm_gpu_crashstate_put(gpu);
> +               return ret;
> +       }
> +
>         iter.data =3D buffer;
>         iter.offset =3D 0;
>         iter.start =3D offset;
> @@ -214,6 +221,8 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer,=
 loff_t offset,
>
>         gpu->funcs->show(gpu, state, &p);
>
> +       mutex_unlock(&gpu->crashstate_show_lock);
> +
>         msm_gpu_crashstate_put(gpu);
>
>         return count - iter.remain;
> @@ -914,6 +923,7 @@ int msm_gpu_init(struct drm_device *drm, struct platf=
orm_device *pdev,
>         gpu->funcs =3D funcs;
>         gpu->name =3D name;
>         INIT_WORK(&gpu->crashstate_free_work, msm_gpu_crashstate_free_wor=
ker);
> +       mutex_init(&gpu->crashstate_show_lock);
>
>         gpu->worker =3D kthread_run_worker(0, "gpu-worker");
>         if (IS_ERR(gpu->worker)) {
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.=
h
> index db9e11e7f..9b683973b 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -264,6 +264,14 @@ struct msm_gpu {
>          */
>         struct work_struct crashstate_free_work;
>
> +       /**
> +        * @crashstate_show_lock: serializes rendering of @crashstate for=
 the
> +        * devcoredump.  The show functions convert captured buffers to a=
scii85
> +        * in place on first use (see adreno_show_object()), so concurren=
t
> +        * readers of the same dump must not render it at the same time.
> +        */
> +       struct mutex crashstate_show_lock;
> +
>         /**
>          * @recovery_in_progress: true while recover_worker() holds @lock=
, so
>          * that fault capture and GMU waits don't wait on a fault devcore=
dump
> --
> 2.53.0
>
