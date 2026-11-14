Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B3606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fpYXnSkd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qg1kHKCM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6513210F026;
	Sat, 14 Nov 2026 16:40:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418D510F059
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:40:45 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEDkPTd3844990
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=; b=fp
 YXnSkdnG4BA4y8XDLRl8x2Co9x2NAPivGl8Owm4IYNiITvILAgSN3/MakeeFTb51
 oQ8ysc9yiMQMzZ6pOGm6khvyUOxdnIydruCt5uqV4NQvj3bpmKyr+kOnzdaUlXKB
 hevt+FA4bZxt2sFFHBKSpKAMO1WBHi30sU/FjKa0QRmwba52oYXcestA+zmoVJft
 Yym1C5/qt8+wUAa/sTnxPbYtcn4CE8g9YUD0UZo6STZrnIOTbUaR5h4Z7ev67KyG
 3CA7GXlrMqCtC3IE49B4siNKjkxkxF1tIYcUo3ePvlp92/FNIZAg6xKIAOZmIsjV
 NCZGFDSvrVLBR78lAFWA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx19dp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:40:43 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-862a8fcc3caso551549a34.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:40:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794674443; cv=none;
 d=google.com; s=arc-20260327;
 b=JR2d9U1yh1KoJ24FazNdCA3VcLcAcaT/BccAIoKXeacok7x4ME7cjWOYsR8cNOt7ms
 6bb8wotZS/2ZFl5cRJb00dTLlsViaFx62ta/RvtI24etUNjLGkcY/n7J2iG1eGRLkeX4
 Hrm1hOE3VcjqVhR7fX8Pk2nVFrPgI4RVoQTvjFvl+cOrKc6TDx9Ko45CCo006HnVDto9
 YI3GgqxAUrNtkgDbyW3K2cYpAL6DOWoeK7NcHke2pSdTNIKj38J/ouuTU1JkVPHRz2HA
 dZrQjpkHgFiD0nCQWBIrNlsB19ygrbbCmoY2TY1lTxaDf8RGYAkYhpF0jAzRTxuS00vV
 9UHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=;
 fh=ruY6/9RHtO+8Gnp5uZS47owuFr9x5hkX8VyNagkCbGM=;
 b=slMb7CjTmBBCImo3ah+XFpqV5g1tq3dsvrSxFJbKBOoejDdG8/BYW00ghOiEe7SCTI
 WpzMqIcCO8R0h1gIqW6tECFgcFyVqqLoT1CnQB7tbley1j1FX+zqvJqLEab+/Sxw+QHg
 jAynyMBiKCjQJrokAnmqnf3U2jOae8OcMh7px6tVvjaMAIRJWR0TBQLDQuDJoi+WiwCG
 +wHSxxlZBcr/6BHskrHUyaZEx/lJTee6DuesqadhBtQr4aSz5ncAO08mFi3v2RxHjeVa
 uxvmuE3IyPg44NKiflcxmwUDtX/pz6AeecUEsUG/u1DuNsybn0HI8dSurI5AvOOOxf+3
 Zx1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794674443; x=1795279243;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=;
 b=Qg1kHKCMIMErqdxdf2/tMZG/06SjbNSs5mn5FQ24BELhidunyE8WFh8jPl12ZI/Zm3
 ajKMSoTQhgigtFfYDDMy+MlF1eiG4LSprvlYw2MIzybzs9dHebwi+/Pffos6B3q12qkA
 wHWMT2mGHFEd8kbnOaQz48YeTH2rcMfs0D0FJE4HX72W0u9Lel5iO2G2uydh0wTzXdSc
 yagiWY/MO0cDuG7ikrpPE1AdYSjAZ68DCIHrimLng+KM0GW+X19BHqOeu0W48cL1IzZ8
 Smu727MoyO+CM5hGPGi7j+y9kKRwPn5YlytJQqVeVHDwNmR8o2D+LB4l/K1Ne+RdPBwo
 y0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794674443; x=1795279243;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=;
 b=qLcSZWpQ4S5yAY3zbuxl5EARGFiRngEodCKxgEqgA6gM6u8VYHQKuqOQcuOhXPvo9r
 BZTFW4YAVX2amXJ+xBNZFyEbT3Q0pP70Np0YY9dp3/K1b/cRyKA8XIbxhNGJCp09T0On
 J7TO1/o+59gHRObiye9ahUG9AXsCXB6B04UXpA07iSlVS0gyX67HrNm6xBX1jR2I/0js
 xJFGDz9AvY3WHxH3kw65MKUFogHUMkIl2uwvq5xdQkzQAUBzpwOMnPTlCJA4Ktjn0Mrb
 9sEsQ6/Wv/sXQAJMjngS+bj5ctSXMAvW2piuEXuBDqxRA1lXPEp8RL9dXPPUFlTKZqzh
 R0MA==
X-Forwarded-Encrypted: i=1;
 AL+hErEaD5TsEkHgs4Lha6PeFXyQOJpwjRpqbJlmpibVHmODWEEF++Oxkym7Qxoe3vOyQN9Ak7oxBcJ1jWg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81DEV21rxcVq/8AsUvWY2mpA3kBDwaRCV72ZuvaFySOLSLVi6W
 3ahvYPktXSjoPpgXo84EPeSzPgq89Virmo37qcvpHLLjYdoGxnH1oHezZ7hNExX42Feb850bHpV
 prXdpLdT4KWWlL7/HNieSkdRN6ZBHngRvCMQOTEZXzAuYZIZKlB8lXeg2habRuV5dZ+FMyl/1H7
 TB3V2vtB5J7RV+7Xa7Z2NnCgHI3iBvmfgUVlAAqllaXIiiVA==
X-Gm-Gg: AYBFou3nFWUjRy/+ZK+wF0ZuBluW7XxX1ws2tkhKbOBeHwneDQ6zSgV0MLFceqE+zXh
 xrCPl4JtiqsM5iMnE955zegp5AcJEIcmuKkVj0qPlTydkRFo3fcqcPuoou5FKAqMJRfEH6vJfT4
 suAiWAnbOczOn0kKE08T/L2Sal33SqMspTcIMzJme7j15XjJ+ps7TWmy7Rujm5yWaJYd8vNj9I1
 3M2uLqDB/nSbbxjuwlWdA==
X-Received: by 2002:a05:6820:1394:b0:715:453:c6e2 with SMTP id
 006d021491bc7-71ab4fbfbebmr3860142eaf.33.1794674443090; 
 Sat, 14 Nov 2026 08:40:43 -0800 (PST)
X-Received: by 2002:a05:6820:1394:b0:715:453:c6e2 with SMTP id
 006d021491bc7-71ab4fbfbebmr3860118eaf.33.1794674442621; Sat, 14 Nov 2026
 08:40:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CACSVV02fCwbFXVjE+XHCo68xMxYUHovJ9ZHRYd98L74N1T14Hw@mail.gmail.com>
 <20261114153622.148125-1-arpe1618@gmail.com>
In-Reply-To: <20261114153622.148125-1-arpe1618@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 08:40:31 -0800
X-Gm-Features: AclHuK8v6yocAMov5_kcb3jEgrVHdGlRUdiYk4AGEpFJ8mzDlgn5asj4NprUyOQ
Message-ID: <CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/msm: Fix VM_BIND job,
 queue and entity lifetimes
To: Jiwoo Kim <arpe1618@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA2NiBTYWx0ZWRfX1JC/FEhg9gdp
 MGc3NxDQaj2dsiXqXs19yNUvR9UmDtQxL3vfKMlwcdUalnFrmKhgLeLZMGe2FOS13h9GYjyDhfS
 UKr+Ujs8zPeEHsPG9/SzZteolx9XK6OwzZwiMDt2uBsQRM2+lOJ4yfpUBWnQZP6K0H4uhNUpE8P
 2qm6gxdnJWiElxkvZTcY2oB4DEvboguZO+2uyfK9qfE1hnX43gX6pro/Cl+HfflG43hRs3mekdo
 wooPmfk/pDSKWTtogYWmV7QVCtIx64tJoozI621Rj+RZvH4jeyUUW0n0+t3qqEPM6fn5QzHQK5f
 qOZnl6W5/aOwbfHsRWUlh5WU9kjCUERHGfmiehY42V8dD8TNz4PoL/HTXWrDqqzzvDp2cinDuyT
 jzZWdbz+GwGGWOXtBtkYYubnMYoq5K0V+gJUGJVNeV7AN5YxyhnCWTNnABuzoa30SuBoWj8E6v9
 qQzK9qZJrFqwdmPDYUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA2NiBTYWx0ZWRfX0ISKxUClt4ea
 w3VkpwvsImElG5vsb5OOfpBSAB+82DI2FnMhhZye8/ubTtgZvL35oyRGPJxXLHz7FhjynQm1SBA
 RlYhdV/a0N0dZMt0wk0OvwEk5hYty1w=
X-Proofpoint-ORIG-GUID: U-F1pm0_rMVCygbU8hE1KPrGdDdF91tZ
X-Proofpoint-GUID: U-F1pm0_rMVCygbU8hE1KPrGdDdF91tZ
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6af88f0b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=2g9MNY1Fx1-Z8oZBzW0A:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140066
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 7:36=E2=80=AFAM Jiwoo Kim <arpe1618@gmail.com> wrot=
e:
>
> On Sat, Nov 14, 2026 at 7:03 AM Rob Clark <rob.clark@oss.qualcomm.com> wr=
ote:
> > msm_gem_vm_close() waits on vm->last_fence which will be signaled
> > after msm_vma_job_run() returns.
>
> vm->last_fence only collects the fences of GEM_SUBMIT jobs, in
> submit_attach_object_fences(). VM_BIND jobs don't add theirs, so
> msm_gem_vm_close() waits for a VM_BIND job only if a submit depends
> on it.

Oh, right.  We should probably just update last_fence for VM_BIND in
the same way.  (Ie. using dma_fence_unwrap_merge() to deal with the
case that the current last_fence is on a different timeline.)  I
overlooked that.

> > My expectation is that if thread A is in midst of a VM_BIND ioctl,
> > perhaps not having created/updated last_fence yet, while thread B is
> > racing it closing the device fd, that file_operations::release will be
> > called after thread A's ioctl call returns.  Is this not the case?
>
> It is the case. (The vm_bind_closed check in patch 2 is only for
> MSM_SUBMITQUEUE_CLOSE, which can race with a VM_BIND ioctl on the same
> queue in another thread.)
>
> The problem is a job that the ioctl has already pushed and that is
> still waiting for its in-fence, e.g. one from another device or
> drm_file, when the file is released:
>
> - If the queue was closed with MSM_SUBMITQUEUE_CLOSE first,
>   msm_submitqueue_close() no longer sees it, and nothing waits for the
>   job. Otherwise drm_sched_entity_flush() waits at most
>   MAX_WAIT_SCHED_ENTITY_Q_EMPTY for an exiting task, and kills the
>   remaining jobs only on SIGKILL. Either way, the job's reference
>   keeps the queue, and so the entity in it, alive.
> - msm_gem_vm_close() then calls drm_sched_fini() on vm->sched, which
>   frees the run queue that the entity still points to.
> - When the in-fence signals, drm_sched_entity_wakeup(), which the
>   scheduler registered on it, uses entity->rq->sched;
>   drm_sched_entity_kill() leaves that callback in place. A killed job
>   is freed then too, and the final put of the queue calls
>   drm_sched_entity_destroy(), whose flush reads entity->rq->sched
>   again.

I think if last_fence is also accounting for VM_BIND jobs, this should
ensure that all VM_BIND jobs are also finished.

> Patch 2 destroys a VM_BIND queue's entity when the queue is closed,
> by MSM_SUBMITQUEUE_CLOSE or on file close, so always before
> msm_gem_vm_close() tears the scheduler down.
>
> This comes from code review (see the note in the patches), and I have
> not reproduced it.
>
> v3 is at
> https://lore.kernel.org/r/20261114141851.134290-1-arpe1618@gmail.com
> and its patch 2 is unchanged from v2.
>
> Separately, Sashiko's review of v3 found an ordering problem that
> predates this series: the VM_BIND queues of a VM update the VM's VMAs
> at ioctl time, but their pgtable updates are not ordered across
> queues, so an unmap can reach the pgtables before the map it undoes.
> That does not need a queue to be closed, but v3 patch 1 adds another
> way to get there: the unmaps it applies when freeing a killed job are
> not ordered against other queues either. (Its other point, that a
> killed job's fence signals before those unmaps are applied, I'll
> address in v4 as well.)

Yes, userspace must use fences/syncobjs to synchronize VM_BINDs if it
is using multiple VM_BIND queues with overlapping updates.  An error
would mark the vm unuseable, and the kernel will stop accepting
SUBMITs and VM_BINDs.  But maybe we should also handle errors in the
UNMAP path as well, as that also indicates that userspace is doing
something wrong?

Userspace shouldn't be allowed to cause the kernel to do something bad
(use-after-free, freeing pages that are still mapped, etc).  But it is
perfectly fine to let userspace shoot its own foot, for example
triggering an SMMU fault due to pages unmapped while the GPU is still
accessing them.

BR,
-R

> For v4 I would make a job that unmaps a VMA wait for the job that maps
> it. The other way round, a map that overtakes an unmap of the same
> range fails or gets undone, which breaks that VM but doesn't leave
> freed pages mapped. Ordering all VM_BIND jobs of a VM would be
> simpler, but turnip uses one VM_BIND queue per device plus one per
> Vulkan queue. Would that be the right direction?
>
> Thanks,
> Jiwoo Kim
