Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C33606E026
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lejKQmqG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZCCWXieA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BD410EF2A;
	Mon,  2 Nov 2026 14:27:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEB510EF26
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 14:27:16 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpMql4062008
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 14:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=; b=le
 jKQmqGwQP6CJxqQJ/4fG9AAw3mSod/NgYwm7RK3UIEyXk+z/xXX6OXL4S19UhWco
 oV+EhLgcfkB0pZ4KMvF/6Kelt4BfdjwFZaJRP5v0oRb83w1iu0m5yHHmIQA+UWaR
 DhhgwpvVQV2qWsBlh1he2QjWfHaPduvsxfRK+sYUbB865yOswBeeaAeFYnya7eep
 kfGesPqEekAJal5fHnoDzCbPT9e9NdZelrVaonqvYk/z2tzKrTrfJPDYvbi+qn3R
 WHVuTIOR+xjuW/jZrTFDOv2IDQS91ZB8cKANe9mXk2jLZTtaT5v8A+iR9VHQxFjj
 LRmOwMp77484C9FWK9pg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmespxv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:27:14 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6f56f3638afso3269154eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 06:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793629634; cv=none;
 d=google.com; s=arc-20260327;
 b=KDhbiheXTDvdaZbHHScdP1U4qzkzIDeNFZiXL1e0iZQqLJ7+7bmssW2+j34YqRvxIz
 7QZAsWW8z5BcOITY5oOomgr+vo74Y2Oyy6hjouk8Xteoy3ISKxApVPUvdA9dlLdH7NtV
 /z9S2+7vHZ8qV5gHwZk5KexnR8jqDf1DkXXyJMAhvzUMun1nlEI/PohJUxgpOn/tYyoK
 RXqg7D7/42J4KpCYY9lmWCuY1UZZdRGuHX1icRugtjdN7nwZMh2YG14PLNej1+d6ZkHX
 wCLbhF1Rbu5pP7hRIliq3kLdcyz7bql2KIlYQxG2H3DT80Np3Sj15+JoCYR3GIcXhgT2
 22Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=;
 fh=q9t6eZA+68nELG1Kw2Q2RXC0kpBVMaTho7ogJ62DR38=;
 b=k+3/KcaQBHmTG4MRILOiRE8Cw1TzJB5HXhmyXSS9YKUGayNhoJdMlCXGyDb1E6dZvx
 FAX79R7dxHOG55HcGo2rBE0V2wl7aRTyQWnC+MeLDYU0Hgf6Ii3nN3OTWPV+gG2Ns9Le
 ywb2znzH6H4Husta9X2VGW+PXwpLGoZAFtnhNYmQLcYNqQPwvrOqo7wrmJFd5+etApkS
 7+Ea6XpVZR2XtmWGtVP21SBH0CdLngEUjKvx6EN8q5+0Pj2R9L2S/k3OzdybeS9ulQxg
 wY0vhCB7JoabCdVh6mQOCOWunjCL8ix5aDXnmzLLC/oB8J/LUX1ZixiYXkE0lfQsH4kP
 clCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793629634; x=1794234434;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=;
 b=ZCCWXieAsELAgpkUuw9Hu4ZHkr6zB9whDeSaK7H0Y5xdaKmL44yED6HaYXf/QJCfmN
 i+CyOStYYgbAjVdGdWn5mOaAQH+frWfaktLVHyVwSYSCnuwkkeYOJBCW8fY0+UsrUlCh
 sPcC7DwEy20re95cPAGYmgJPTxQ9iL1yiUb+U6eJA1XlbBE9+L86mkpa2QkbKnx80XDF
 ylTsQI0rVfBy+D/kRnJ9mq3ThHibu4gtNtVB5OzvMxuO0pus09IMSup3xPCMdRnQOMJX
 5QOdkCNCSOSv0JSlF4uY/UDjEFfwmhCY9GzXTcXAJp+jVB2uE5hYOnZnZfiOMpujHX6v
 PczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793629634; x=1794234434;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=;
 b=w4Qpdm3i3ADn/eXKRdtOp3s+XBkLMUgje494LG0NmsQujy4LiarvTLIu4CqX5Hl9Oa
 utsxZOyk0ez7Kq6rHqvsFmyRhEiB86z8y5LsjR/RYJuTZ/iBZl6td6KCAANM0nWnVn0d
 yFPhjiXvPYTCTU1vwICsgvHdeHiHy5HDxK7CT6UdT+gK002rlRCwPFh+deZa4otMhAge
 Xo1ir5SrbE8T8lpOOF5doh2AorATM9rwgVun26f8LNJsDQ/kzIOfdrsGsN1rOJ07r/kU
 vKpUxvb+xmmB8t6CjCPN+wXTZzonyQDZuXGRlVGwji42Qvnx2ZhE/43VP//fL5B1kx37
 SJKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByxO/5cNP3So0NU60CYlHkdoVR6ZHdWZugx0b2xpeLS+SdM8nnUtt5yWIuHQMthMS7fS8RDIVWVkHI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLYmc44P+rBPNXH6JeVIkxF/NPULIk/4EVIkER2It2ZQ8dV8juh
 30lswi/LoF/6TzPVq5oSO46lQ75UYMfPei6xIbnpbi9LNtfHFDzpvspQu3eGO4QO+xVNxfeuhoG
 2VDgDNcqIG1G4Ma0/iwc+G/6T7HExJ05KkKv5qSWIh0AkvKMjHg7nT/cdlY8i5+e+1tsaeZqBN1
 Uv2SU9ouC7bL0yGWJC8KNSuCgY5XvywzeY0ebrHIsbtNEWww==
X-Gm-Gg: AYBFou2aHkYzciXa+vrMtoX8akinulzjQ0nuLPUI3v8Y9c4Ffm3T9HjSh4G3jtbYB2D
 KGWXluJdFSz0DDAdwXTRyKyqgEHmcQpzBpMn8tPm8/qwG/Tk5c4fI5/qfbPFppVLsRI53YvV1XT
 bc7xtxn/0uyqHgRhiYJMaTWalUFmFAa7Hsg22LDUZdxHq/GTJrIihJs7b57Q==
X-Received: by 2002:a05:6820:7081:10b0:6e0:1599:a4a with SMTP id
 006d021491bc7-714f290f51emr4033711eaf.35.1793629634200; 
 Mon, 02 Nov 2026 06:27:14 -0800 (PST)
X-Received: by 2002:a05:6820:7081:10b0:6e0:1599:a4a with SMTP id
 006d021491bc7-714f290f51emr4033681eaf.35.1793629633693; Mon, 02 Nov 2026
 06:27:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
 <20261101175553.53746-3-nicoangelodelacruz@gmail.com>
In-Reply-To: <20261101175553.53746-3-nicoangelodelacruz@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 06:27:01 -0800
X-Gm-Features: AclHuK9APyGtpZOJQcsejCVfEW4m73oY8nFEMTVCqR0OB1TvK7sTUjK0ek7HnrA
Message-ID: <CACSVV00ud7+mJ0YWM4a_jzRwDuZTFkHkLF3tXC9NBwMcmyMUfg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/msm: free the crash state asynchronously
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
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae89dc2 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=PDzu0jb1FHLFr2hdgv4A:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX9OHr8wqFKCMc
 k2ftlAJd5SK4MM0T2xBq8z7BSHrX1OOoLOboXQotUAkYkn9WPJCTQozMhdnzgfrSSbfrNSs/jD0
 eFJHiiE+yCcKOxvp4hDwPidJsWtVYdPKLxikoLK/2+ZKg+pjmnPnAI+V+y4ldOVmKjIIRxNKo9j
 T74lgDmz8Cb7VdiM0l4EwCHL5G0reBxm4PzeyZtmbUpJX8m+p5Xa9/Y6blV1qMG5Q/pdmfhBI5w
 LhU4P6srhn6LOkZFRzCtBCk2j+cqvWKDdBg8z57FY5euKeka7pascNd6ut6pKlLF8cn6wKSeTBq
 OYiwf29IJIm5jXqwYmE2dTEnvppiushaWQNzc318i0gp4ISsqiTqAe5Pp2Ul7h5J4k1zFVel3f+
 MtjNMNg7OejmSLFyfaVitDEwE8GLJC/NzVZgx8PEiNeV22dKuMDLpuxN65G8d8w0isHuZ6AQe8W
 1TQw44tU9jkHHnKSspA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX/6y9KyGWofof
 UfSu/DS3u4o0ERqBHQ7ld7Lg23r13IG1Tc9aK2HLY5IoQGGWK03TPH1+TUK2Uh049VGQd6hB23c
 +DiX29pFB+3NZ9WCJfKUsYp/Kmyfeuo=
X-Proofpoint-ORIG-GUID: GoMsFeoqQWpX9xta4fEviE-mZNlJKwNq
X-Proofpoint-GUID: GoMsFeoqQWpX9xta4fEviE-mZNlJKwNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020057
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

On Sun, Nov 1, 2026 at 10:00=E2=80=AFAM Nico Angelo Dela Cruz
<nicoangelodelacruz@gmail.com> wrote:
>
> msm_gpu_crashstate_capture() sets gpu->crashstate and calls
> dev_coredumpm() while the caller (recover_worker() or
> msm_gpu_fault_crashstate_capture()) holds gpu->lock. When devcoredump
> is disabled (/sys/class/devcoredump/disabled, a write-once knob) or
> its allocation fails, dev_coredumpm_timeout() calls the free callback
> synchronously.
>
> msm_gpu_devcoredump_free() then calls msm_gpu_crashstate_put(), which
> does mutex_lock(&gpu->lock) and so recursively takes a mutex the
> caller already holds. On systems with devcoredump disabled, every GPU
> recovery that captures a crash state deadlocks.
>
> Defer the put to a work item on system_dfl_wq instead. This is safe
> because msm_gpu_devcoredump_read() takes and drops its own crash
> state reference, and the work takes gpu->lock normally once the
> holder has released it. gpu->crashstate stays set until the work
> runs, which only means a capture in that window is skipped.
> msm_gpu_cleanup() flushes an already queued free before teardown.
>
> Tested on an Adreno 830 with /sys/class/devcoredump/disabled set to 1:
> IGT msm_recovery gpu-fault recovers and the GPU resumes.

It seems like this is missing test coverage in msm_recovery test.. it
wasn't a case that had occurred to me.

Care to also send an igt patch to add this case?

BR,
-R

> Fixes: c0fec7f562ec ("drm/msm/gpu: Capture the GPU state on a GPU hang")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_gpu.h |  6 ++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index caa86279f..fded78fdb 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -175,6 +175,14 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
>         return ret;
>  }
>
> +static void msm_gpu_crashstate_free_worker(struct work_struct *work)
> +{
> +       struct msm_gpu *gpu =3D container_of(work, struct msm_gpu,
> +                                          crashstate_free_work);
> +
> +       msm_gpu_crashstate_put(gpu);
> +}
> +
>  #ifdef CONFIG_DEV_COREDUMP
>  static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
>                 size_t count, void *data, size_t datalen)
> @@ -215,7 +223,13 @@ static void msm_gpu_devcoredump_free(void *data)
>  {
>         struct msm_gpu *gpu =3D data;
>
> -       msm_gpu_crashstate_put(gpu);
> +       /*
> +        * dev_coredumpm() calls this synchronously when it can't keep th=
e
> +        * dump (devcoredump disabled, or out of memory), while
> +        * msm_gpu_crashstate_capture() holds gpu->lock, which
> +        * msm_gpu_crashstate_put() also takes.  Defer the put to a worke=
r.
> +        */
> +       queue_work(system_dfl_wq, &gpu->crashstate_free_work);
>  }
>
>  static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
> @@ -899,6 +913,7 @@ int msm_gpu_init(struct drm_device *drm, struct platf=
orm_device *pdev,
>         gpu->dev =3D drm;
>         gpu->funcs =3D funcs;
>         gpu->name =3D name;
> +       INIT_WORK(&gpu->crashstate_free_work, msm_gpu_crashstate_free_wor=
ker);
>
>         gpu->worker =3D kthread_run_worker(0, "gpu-worker");
>         if (IS_ERR(gpu->worker)) {
> @@ -1047,6 +1062,10 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
>
>         DBG("%s", gpu->name);
>
> +       /* May be unset if probe failed before msm_gpu_init() */
> +       if (gpu->crashstate_free_work.func)
> +               flush_work(&gpu->crashstate_free_work);
> +
>         for (i =3D 0; i < ARRAY_SIZE(gpu->rb); i++) {
>                 msm_ringbuffer_destroy(gpu->rb[i]);
>                 gpu->rb[i] =3D NULL;
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.=
h
> index 5cf220f75..db9e11e7f 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -258,6 +258,12 @@ struct msm_gpu {
>
>         struct msm_gpu_state *crashstate;
>
> +       /**
> +        * @crashstate_free_work: drops the devcoredump's crashstate refe=
rence
> +        * outside of @lock, see msm_gpu_devcoredump_free().
> +        */
> +       struct work_struct crashstate_free_work;
> +
>         /**
>          * @recovery_in_progress: true while recover_worker() holds @lock=
, so
>          * that fault capture and GMU waits don't wait on a fault devcore=
dump
> --
> 2.53.0
>
