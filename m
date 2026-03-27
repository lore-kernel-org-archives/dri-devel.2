Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84F010F284C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA1410EEE4;
	Fri, 27 Mar 2026 16:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rq+LjPrq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KDbP0iNJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB9F10EDE4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:08:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RDhDaX3084549
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=jT6N8avUUDlCXZ0/BPJN6GuGWXRGuNZJ0M5UO1nZZNo=; b=Rq
 +LjPrqgrf2iv2qyk5u9Rg0GPW21jIRAtDTHsAjMQ9aRgviBgE5av0EKpjAhozx67
 gT7kF2OJFc20rPSvhDIKDofwMOSBZg9Oi20jKoE2lFiyQPbV50SW1Vm0NFR1vJ6H
 JbzXpufKPwEP0HQq/ZbDFt6By9ZMasDlweoRs02GYRIf/acu3byyP3OI587MMFo9
 7GngHTtmEWeJsoftmAjEDfYTeJJ0xMyCu6GY1G87w4Z1i+1EzzGGkSIGgnRTzlia
 bdWGWF1oOsK3L/89RcrY9bgiZ8lOYqTyzMipsIqsAp5y0YlzkHQl2vilj4ncX94c
 cDZXMlR5KVD8JMfsDALA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5mn1226s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:08:31 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d9d3230cf8so5375230a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774627711; cv=none;
 d=google.com; s=arc-20240605;
 b=BYNMTmFkTkNZBKL82LL5rM+/0H+K3rOJV1xnFQWFGl8btq2zu4Ts8cQZoobXGycyH7
 200+YSRccCBVjAI7dGBFJRYkPX+dtkTZ+0xWd4yZboVEqf3H8uWzkKAwhn17Jl1D1KEO
 7HMjsGaV6dMVzyERWKJQ8XH1UYw3UBM8kWhUA6vnERxPnsxuQmNa0cZoiBH5yEULYiSs
 ZNkJ8aXZDrwgYdvOsXaHUlk8g3To4eehsiVHxhN025BMdW4Qv5/kii9UqT+JGvnqRluP
 d5FQQHvuOfrnQGYS4yAJBA1ibb8Aqy/og2z9eKjhUQInKgMcMooKk0TPgDFOHgfR6sCI
 Hphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jT6N8avUUDlCXZ0/BPJN6GuGWXRGuNZJ0M5UO1nZZNo=;
 fh=BtltpUBmVpCA2CILR0Hb06MpU7yE6LoHiAO9rljhN+E=;
 b=AMYXP8SBgwHIIaW8V/z6zKY/olB8plAYI9gPmjpMJSE3odQRoK8fvXt0oDGFXpFcq+
 EUWJuqolY34jI6jUNWuZ1FwWzPZRXAu/GV2zw98837tr/m6B9Yq1N3g9zVqzRCkCEwiL
 3kG3ixNO6fgkB7tAbHMGam/9Z4wIQsjcXePkzDO/GHxbdR8/jCSYIecAaePNq0EU+TBC
 kS52eC3L8wQkohY568/DZB01hIru0GEGFKEAz6wROzy0L86vhbrAeOaHzl5QSOrZK78d
 sN66S07hsepGb1Wv3E+cSg3GT3MUbtpIUJ6jxWuI2dafYL6rkZbpRBHsZqh2xA6MTKe7
 wQNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774627711; x=1775232511;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jT6N8avUUDlCXZ0/BPJN6GuGWXRGuNZJ0M5UO1nZZNo=;
 b=KDbP0iNJX8a4uPGFcbOy39aqLXTYsINgDTxt6eV47/daX96NpSfIb3RsRZDJMmC4Zu
 +PXwRZGP2QkObCslQ0jueAGZNfeDymnuJay8Po+BK633Tefwz5er26XroCJFiSfVFiom
 TmbxNTKJ1Xaa8m8w9OJ4PD4gjbuApwDaEgEXVXDj/TU+A3IJnQy8ti78pBXjO8vTSEKG
 FPwznuXHkjXGSVrSSRXZsJW7/lzMWz25ZFDID4mLN5Gy6j5ccXv5ijrQRzgCKmIsthmB
 ber+un4HtO5WaUiubArAer1+vW09UsO4e1RADSmmY1JKG8sT76/TMLQ4Zcl7C6cvHoXJ
 X5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627711; x=1775232511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jT6N8avUUDlCXZ0/BPJN6GuGWXRGuNZJ0M5UO1nZZNo=;
 b=UR/RMbdwG0eyJq2G+gR9+dzKtRbMcO3R6j6dnj/jSug5kiCnX4uDUGLzMAeOkp3/jk
 p5xiF0qobwpIcAgJ/1vKpJU77I5TvJRE2O/Q+WXWKb6437LBCYd2T24EmY1v0PCe90Gy
 Z0H7Vgfu0hezfo0j6f7khcwZulobb7FPnn1Bacbewr/FjeyP7uQkh46ERjmNhiw1NXUQ
 bod0FuJNlMK1jYFEW/IykbE8NumYKSZjDKLFP2LbDuiqOkGr9BDuSw02mtftsNfNrB1x
 R1T6KOBKFGX1vFgu5eKqw6sGw8wwCX6k8fgA/5dc8+gnO5yFp/umTLfD2sxmmSdtTkxQ
 XFqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmj7HJNuHZ0bYKJIrrKDwNwfLCqaYWddcIJHyukaB89PqBoG8rMSRqlptbyt9KSBhDabVAouUeNaY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwweKeSAKQtlok0e1sqZzO41R9YBvH1hbpHS5N96D4KEQOOQaVf
 +uvLXcDnoV8rqnSTeiZkdYa+ad6msdlcMFpyN7NkOuts5m4DTk3MdIej5LXLb+dJtLWY9VKVV4l
 mcoUWUdS7iVhUv5RPQ9hYqfbO7QhoMvCoTFYYysNJvjqjDAEnpvZu1i2yJ143xIYyRSAwS9BxMg
 wcUx/ANMH5Ergo3oODtvnWe2136lUM7oIeecu9dqXuBZp1Fg==
X-Gm-Gg: ATEYQzzrCXdadDQY0He92bBU4ELkDiMjETisD7KvkByOMOL+c5pXIEKMHbjIVW33cay
 nLsyV0DEdmio6nrlazXinECZ7uX/p5xnEkjwEvib/NIDyxWcA9R6WCuzo9cO3VZomFmrtjUyXj+
 UWwAqHB/LHBaqBOxBvlFo9lw/G4KBZJDX7nLtmXqh2oS9OGp008sChh2PkznxOxEZE1Nj6VLhyi
 Qr0LVaHuurh/NL8ROnDjogeyP0+trzh6iL3nw==
X-Received: by 2002:a05:6830:6b0b:b0:7d7:fd71:f2d4 with SMTP id
 46e09a7af769-7d9fae95c90mr1533792a34.3.1774627711103; 
 Fri, 27 Mar 2026 09:08:31 -0700 (PDT)
X-Received: by 2002:a05:6830:6b0b:b0:7d7:fd71:f2d4 with SMTP id
 46e09a7af769-7d9fae95c90mr1533762a34.3.1774627710605; Fri, 27 Mar 2026
 09:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260127073341.2862078-1-senozhatsky@chromium.org>
 <acSRDNA8fCP7qAFJ@google.com>
 <fe3177bd-a3d2-4c0a-ab6f-9752eaf32fc4@oss.qualcomm.com>
In-Reply-To: <fe3177bd-a3d2-4c0a-ab6f-9752eaf32fc4@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 09:08:19 -0700
X-Gm-Features: AQROBzANslr58qDkTo4BstZrTPuot25lDdq5XN9xXqpfQR6OmMZsIelXELfMcrI
Message-ID: <CACSVV00MFgsn8_XjXZxubJibLFE9ULrFqiEW9dQAyU404SLj1g@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: gpu: msm: forbid mem reclaim from reset
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNiBTYWx0ZWRfX0WigwqSjsP0D
 qD/P0BG1WdSICfZbkdth6xpF7hT80sqvrC6UT5+ahugdvMOtKvHNhDYSpaC1f6xYpGWMi52YXdS
 C7EfaYTkjbstT1pdV+aHlcPpYX/ydQ6sEV9k8rNTYgHMhZkhvk28CZBUpL+URP6CP686NpGbYlW
 owt61rBZma3uHn577kW3z7aX/BTBvzAkyLczFB/Y/f4LN70/6R4uOKBnYLBZJfmgJZetCxQkcjL
 L1rrb/6zxXT8ztBGrjBgPFQNnaVg5czXcaNyfrR7314xHINBXZ+ICsNgqjGmmhItm4iZLH79h+G
 QTVvEYi/zYfOwf8Ep3vUsh40z5/cBmhsNWud1QiAN437R9rD7+LmQZYHvpK+XqJMndIkVFZH2Q+
 q9OVISH2Y4mZ50pNe+Tk4zSqrViNObUikKQejgHSUtK5CgNaOe2a35TQp7JHjG2ZjLuX0fkFIqA
 cm14LO+pETMjmm467KA==
X-Authority-Analysis: v=2.4 cv=CcwFJbrl c=1 sm=1 tr=0 ts=69c6ab7f cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8
 a=6zafeYv-5ULS2h4Lh1kA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: NNWzhCR_3Z8mAtpqPG2vL9RFIFsRHwh_
X-Proofpoint-GUID: NNWzhCR_3Z8mAtpqPG2vL9RFIFsRHwh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270106
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

On Thu, Mar 26, 2026 at 5:18=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> On 3/26/2026 7:24 AM, Sergey Senozhatsky wrote:
> > On (26/01/27 16:33), Sergey Senozhatsky wrote:
> >> We sometimes get into a situtation where GPU hangcheck fails to
> >> recover GPU:
> >>
> >> [..]
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (I=
Pv4: 1): hangcheck detected gpu lockup rb 0!
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (I=
Pv4: 1): completed fence: 7840161
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (I=
Pv4: 1): submitted fence: 7840162
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (I=
Pv4: 1): hangcheck detected gpu lockup rb 0!
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (I=
Pv4: 1): completed fence: 7840162
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (I=
Pv4: 1): submitted fence: 7840163
> >> [..]
> >>
> >> The problem is that msm_job worker is blocked on gpu->lock
> >>
> >> INFO: task ring0:155 blocked for more than 122 seconds.
> >> Not tainted 6.6.99-08727-gaac38b365d2c #1
> >> task:ring0 state:D stack:0 pid:155 ppid:2 flags:0x00000008
> >> Call trace:
> >> __switch_to+0x108/0x208
> >> schedule+0x544/0x11f0
> >> schedule_preempt_disabled+0x30/0x50
> >> __mutex_lock_common+0x410/0x850
> >> __mutex_lock_slowpath+0x28/0x40
> >> mutex_lock+0x5c/0x90
> >> msm_job_run+0x9c/0x140
> >> drm_sched_main+0x514/0x938
> >> kthread+0x114/0x138
> >> ret_from_fork+0x10/0x20
> >>
> >> which is owned by recover worker, which is waiting for DMA fences
> >> from a memory reclaim path, under the very same gpu->lock
>
> I am still thinking if there is a better way to handle this. Btw, Rob
> had a few fixes related to this area recently. Do you think those would
> help in this scenario?

For some reason I was thinking we used GFP_ATOMIC or similar in the
gpu snapshot path.. but we don't :-(

It does look like we handle allocation failures.  So this is probably
a better option than fixing up GFP flags everywhere.

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

(and apologies for overlooking this patch earlier)

> -Akhil
>
> >>
> >> INFO: task ring0:155 is blocked on a mutex likely owned by task gpu-wo=
rker:154.
> >> task:gpu-worker state:D stack:0 pid:154 ppid:2 flags:0x00000008
> >> Call trace:
> >> __switch_to+0x108/0x208
> >> schedule+0x544/0x11f0
> >> schedule_timeout+0x1f8/0x770
> >> dma_fence_default_wait+0x108/0x218
> >> dma_fence_wait_timeout+0x6c/0x1c0
> >> dma_resv_wait_timeout+0xe4/0x118
> >> active_purge+0x34/0x98
> >> drm_gem_lru_scan+0x1d0/0x388
> >> msm_gem_shrinker_scan+0x1cc/0x2e8
> >> shrink_slab+0x228/0x478
> >> shrink_node+0x380/0x730
> >> try_to_free_pages+0x204/0x510
> >> __alloc_pages_direct_reclaim+0x90/0x158
> >> __alloc_pages_slowpath+0x1d4/0x4a0
> >> __alloc_pages+0x9f0/0xc88
> >> vm_area_alloc_pages+0x17c/0x260
> >> __vmalloc_node_range+0x1c0/0x420
> >> kvmalloc_node+0xe8/0x108
> >> msm_gpu_crashstate_capture+0x1e4/0x280
> >> recover_worker+0x1c0/0x638
> >> kthread_worker_fn+0x150/0x2d8
> >> kthread+0x114/0x138
> >>
> >> So no one can make any further progress.
> >>
> >> Forbid recover/fault worker to enter memory reclaim (under
> >> gpu->lock) to address this deadlock scenario.
> >>
> >> Cc: Tomasz Figa <tfiga@chromium.org>
> >> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >
> >
> > Folks, can somebody please review/pickup this patch?  It solves a real
> > (deadlock) problem that we observe in the field.
> >
> > // keeping the patch body just in case
> >
> >> ---
> >>  drivers/gpu/drm/msm/msm_gpu.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_g=
pu.c
> >> index 995549d0bbbc..ddcd9e1c217a 100644
> >> --- a/drivers/gpu/drm/msm/msm_gpu.c
> >> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> >> @@ -17,6 +17,7 @@
> >>  #include <linux/string_helpers.h>
> >>  #include <linux/devcoredump.h>
> >>  #include <linux/sched/task.h>
> >> +#include <linux/sched/mm.h>
> >>
> >>  /*
> >>   * Power Management:
> >> @@ -469,6 +470,7 @@ static void recover_worker(struct kthread_work *wo=
rk)
> >>      struct msm_gem_submit *submit;
> >>      struct msm_ringbuffer *cur_ring =3D gpu->funcs->active_ring(gpu);
> >>      char *comm =3D NULL, *cmd =3D NULL;
> >> +    unsigned int noreclaim_flag;
> >>      struct task_struct *task;
> >>      int i;
> >>
> >> @@ -506,6 +508,8 @@ static void recover_worker(struct kthread_work *wo=
rk)
> >>                      msm_gem_vm_unusable(submit->vm);
> >>      }
> >>
> >> +    noreclaim_flag =3D memalloc_noreclaim_save();
> >> +
> >>      get_comm_cmdline(submit, &comm, &cmd);
> >>
> >>      if (comm && cmd) {
> >> @@ -524,6 +528,8 @@ static void recover_worker(struct kthread_work *wo=
rk)
> >>      pm_runtime_get_sync(&gpu->pdev->dev);
> >>      msm_gpu_crashstate_capture(gpu, submit, NULL, comm, cmd);
> >>
> >> +    memalloc_noreclaim_restore(noreclaim_flag);
> >> +
> >>      kfree(cmd);
> >>      kfree(comm);
> >>
> >> @@ -588,6 +594,7 @@ void msm_gpu_fault_crashstate_capture(struct msm_g=
pu *gpu, struct msm_gpu_fault_
> >>      struct msm_gem_submit *submit;
> >>      struct msm_ringbuffer *cur_ring =3D gpu->funcs->active_ring(gpu);
> >>      char *comm =3D NULL, *cmd =3D NULL;
> >> +    unsigned int noreclaim_flag;
> >>
> >>      mutex_lock(&gpu->lock);
> >>
> >> @@ -595,6 +602,8 @@ void msm_gpu_fault_crashstate_capture(struct msm_g=
pu *gpu, struct msm_gpu_fault_
> >>      if (submit && submit->fault_dumped)
> >>              goto resume_smmu;
> >>
> >> +    noreclaim_flag =3D memalloc_noreclaim_save();
> >> +
> >>      if (submit) {
> >>              get_comm_cmdline(submit, &comm, &cmd);
> >>
> >> @@ -610,6 +619,8 @@ void msm_gpu_fault_crashstate_capture(struct msm_g=
pu *gpu, struct msm_gpu_fault_
> >>      msm_gpu_crashstate_capture(gpu, submit, fault_info, comm, cmd);
> >>      pm_runtime_put_sync(&gpu->pdev->dev);
> >>
> >> +    memalloc_noreclaim_restore(noreclaim_flag);
> >> +
> >>      kfree(cmd);
> >>      kfree(comm);
> >>
> >> --
> >> 2.53.0.rc1.217.geba53bf80e-goog
> >>
>
