Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1994606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJo1MP3c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TOa+SA8u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B6410E579;
	Sat, 14 Nov 2026 15:03:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2829E10E2F2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 15:03:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEDkQSm640559
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 15:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=; b=CJ
 o1MP3cF9U778Fl4UAjeW5R/pFXcIzfxcQ7rXLhxZjZpIMvPmteXIGV1bTl3Q/0uC
 hZwirgGUScYVlk+F5XMDWGUbg6flsUK6Dmk5Ef6/f2K+OeIq6i62seYRD4B42hrV
 VM3e1ZyYM9pkvjEFdZIZ5JMeAW5BA8O8tlVswm5rkbvag0+b+N/EzC4kIM4GOzsk
 zN2PJR6Qga4G0eFO7vLbdVSaIUv6qNSB5atb69gwAzQv9ANqEzxRDX9cz0yPeKsq
 B+opbSDTAGS4DpiAzqpKkD2zoFBA5R31CWGRCWO2jSjthas8be5uQQa2qSc69eUt
 fuUe4FvonoYrntg/UIjQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmah09x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 15:03:41 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-7152379f5bbso1043725eaf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 07:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794668621; cv=none;
 d=google.com; s=arc-20260327;
 b=k5Usmi/nm736OBsutz4wHroyJ006ZNRvAf4plr0RMUPYMujuj0izvOM9YL1itRO9nc
 ENaHwrihoc5FSgP1yjParsY7GFknmz6qtly4gcDb/Zju55Z2poLEm1KurxnPFNnS0NSV
 9TbGUaC72kZpEEzv3+Hvd9ygxaNiDtfiaGgKHdW80feU5VRF4dvNUjl78r2/26f6qMGT
 QFsgPwuFmgQ0hiMVTyvvICW6Kqx1X7SomjacAQmJPUf+0R3ZJJ/HyPbsEJdqnkQHTxuH
 Qp27m9HCQsIi1EcYAF5dbd1+5dDMwzhilvhm8hN4dzw1L4ccbCLFvXc+vm0dCHGzChP9
 fshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=;
 fh=RHcYp+TJpSwcBWQYXftQ1hSfDta2Np2LuUfGfq91oaA=;
 b=daJtNrpsWq1UOc8iMUENNwkIQrJRH+o3T6V2Nmw3hG8yw9DbHnpSkoP50LR9c+A/+E
 WfmUOSRZH75ttriJOq9CXaxYl4AWEUwaNB0ZIvGoW10wZn2Ogui9OsUOmuZJpms7W91w
 o4M1ZIj15sTWIFJbWk3eNIu09sZkNBRbxroI1SDMzDiq5iiLwEqbh64TBrhndrKcpJ+6
 eGCwBDFXDSBwxQe72dBOBVsYE6YobMKCL01EKfhvAMKDJ6REni6xOuwcgOxYIsFNuwSw
 UkKgNo+frutqV14nKJeF1qPCd2gXWumCzv/HFU404xaKP+IcSS26a2ZzXgorWwNR1aB5
 i4fQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794668621; x=1795273421;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=;
 b=TOa+SA8uqOyN2ieVlzVhzzGLaAgjVreyIxc3ix/gcSjWqoSKIVxXQknxqime1J+8on
 AyPev6sKs4Q6icaTpYn0XHItpeDqMrTk2lyV+nwhlV/PYCDC+Z5mXQ8oT/zCb/CMc+Ql
 BdoyB2rqW0c/r7Ow78621SUOtd1ht/9woAmX5hPn/rzaOO2bWKwt1Q80YFvGoMHv+Bqt
 rbUCinEs++eAodPHxwDlHYruQeGplSqKCRxJzK/1tDOL1NX7ip0wB0+H9hc+sCER8Gt0
 W+ONmbcGjKHT1h90pGt7tlQ4wpdQbXH9Pykggjey6HloGh4w92tJTY4V5I0WF4VvV4Em
 OsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668621; x=1795273421;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=;
 b=MJRShOFdJ6iO9ZdFuCLfjdHw+ZTcMqEAFHna5XLfUzIJdjhhXdKcwpk91/eUOzvcwZ
 XymY/UriGu0cT5I1OpNA4KhqRPlLDW37Gd4FnRHIpJgcuV0wIOI96U7BDdScFowD8Apj
 SJ64M0xcwF2RVF0W0Fg+62V5taw+7//TJjQW0nkImInAJUNLHr5zH7ErhgRm1RmmQqGP
 aNQxWQpwAm+NJgvjPGT3rHS2Lbn4U5DVy31HP6RP3Kcytw2qF42Zx7QfGd8QADZfAWTc
 AmkCAC5D5qsrJDDUFgBWtP9RV4bTRhbW0WR8XFXY289zxvGxOTlzLCjzGWvPV0kt2+gO
 Vyqg==
X-Forwarded-Encrypted: i=1;
 AL+hErGugFwG8QlWFXhlZzqu4ExIlJWFKEh9G4eyy7y/FTSln3FFcjrDRaOw8Bb1wof56ZoGaH6XldauvR0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8hO04URoZetH0jJgh9mNiKjmNBxZXMxnb+/Py+z4hAFMD8rT0
 7+pTj+LBo0Qp3AC8yWQMrPEQitaXLavpfaYTn2p2xikSdZ8Z6p5/F7/fpf9rMEKSNRruOHYOjTb
 NoBfDFebbcHtRDLCVY5DXRsrKM3iOM5PZTvcWYYELebJaA5lVyyNbR7WBvin7jL6Xw6F8e0h0km
 xkWdwB2yWbnlIOEsTpwxDRh1l65F6DbioSf52cHgtMWHUwog==
X-Gm-Gg: AYBFou1CMifzI8pDSoH/rLrc4kc1R/XG5viNkcBnfGYTfzBXTk5XBKb1+ZWt9rN3VEU
 4AsFZ8P599fu0runPc6l/vPmCMlEPYD8q7JXR0Cs8w9Gga4/HPm0IXJzhvQVKnpwjI7IS/7QQs8
 QLyLT4vYBJfSo//x4z/3Lf4+gTaOhkyqnBbhCgmiYB/ap6TGqmfi6WqZFmmtIhuUi+ZE5OwWrWY
 pnZyC366JcefxRt2MIEHw==
X-Received: by 2002:a05:6820:c0d4:10b0:712:c3fb:b4dd with SMTP id
 006d021491bc7-71ab5101a6emr2292826eaf.58.1794668621108; 
 Sat, 14 Nov 2026 07:03:41 -0800 (PST)
X-Received: by 2002:a05:6820:c0d4:10b0:712:c3fb:b4dd with SMTP id
 006d021491bc7-71ab5101a6emr2292808eaf.58.1794668620683; Sat, 14 Nov 2026
 07:03:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114081902.1669-1-arpe1618@gmail.com>
In-Reply-To: <20261114081902.1669-1-arpe1618@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:03:29 -0800
X-Gm-Features: AclHuK8KPquTQTMdHPjuGHN_Vjcpb4fNt0tQaGS8PVmX6JLmxM8xgl-PL0FADhg
Message-ID: <CACSVV02fCwbFXVjE+XHCo68xMxYUHovJ9ZHRYd98L74N1T14Hw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/msm: Fix VM_BIND job,
 queue and entity lifetimes
To: Jiwoo Kim <arpe1618@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -6V78EC8hPdw67f9S9D4fWyYc6KHpaSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX+dharsdO9nLY
 y4Yt9kXPoxtmWCaQi4E6gSDDeHvMc08rsYDCSJmMWso1ZxlTCne+2vdmTZ00sFDC8Nm+xV25C0S
 7q3DyKLGEQhWSYbkExvTQEMcdGsLzYYU9vI0BbMo0Iff/sdLvoJSU/q8ZvOyNhqyIGdC5EV/16g
 8ciAdIlj9p0YvPXc6jFujY1viz8qhuKeoVvfSaN+YYyAGvuWUgj416KXkh51IYASwGrcvClu7ZB
 1zvrm3krmxlV8WeRrWZoh27mMBx6a9sfb1xDO+LxDo0silV8dAfZx4fVfjK1P2LfywZQw4IOjY/
 yD9hS3KEmtCtZvwe7I6TB/0C3BZPgOj8pTXdi9OE+uZseVwGQ/fyC7OsDnAKatw0o8K9EwtGD3/
 S1EoWyiSNW+sAF/7f1INHjN1ZJyvuWcmsZP0m1Fs9SnMkuoEn+/y6yoDF/t5ihPqbageXndFdTY
 qi7A2cE4AFDKh5jFF/Q==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6af8784d cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EtCpCjh61Ki2hOajGtoA:9 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: -6V78EC8hPdw67f9S9D4fWyYc6KHpaSR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX5wzGAlFODaPM
 LTLQX+HBZzxP8pGG9vbW1wilD/a9rPSvS9cASwgNQGJqYu9JNg7WH/jIzL58Jv+PwNkDQ6L4iIo
 2Ylu34ACVK3SqAQIu9tWMr0DBrik7fA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140059
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 12:19=E2=80=AFAM Jiwoo Kim <arpe1618@gmail.com> wro=
te:
>
> These fix what happens to VM_BIND jobs, queues and entities when the
> file or a VM_BIND queue is closed while jobs are still pending.
>
> Patch 1 makes a VM_BIND job that is freed without having run apply its
> queued unmaps before it drops the references that keep the unmapped
> pages alive, release its BO pins, and mark the VM unusable, as the VM
> no longer matches its pgtables. Patch 2 destroys the VM_BIND entity
> when its queue is closed, instead of on the final put, which can come
> after the VM's scheduler has been torn down. Patch 3 puts the queue
> last in msm_vma_job_free(), as the queue may hold the last reference to
> the VM.

msm_gem_vm_close() waits on vm->last_fence which will be signaled
after msm_vma_job_run() returns.

My expectation is that if thread A is in midst of a VM_BIND ioctl,
perhaps not having created/updated last_fence yet, while thread B is
racing it closing the device fd, that file_operations::release will be
called after thread A's ioctl call returns.  Is this not the case?

BR,
-R

> Changes in v2:
> - New patch 1, for an issue that Sashiko reported on v1 patch 1, which
>   that patch makes easier to hit.
> - Patch 2: changelog refers to patch 1.
>
> v1: https://lore.kernel.org/r/20261114062541.2001-1-arpe1618@gmail.com
>
> Jiwoo Kim (3):
>   drm/msm: Release the pins and ops of a VM_BIND job that never ran
>   drm/msm: Destroy the VM_BIND entity when its queue is closed
>   drm/msm: Put the VM_BIND queue last in msm_vma_job_free()
>
>  drivers/gpu/drm/msm/msm_gem_vma.c     | 77 +++++++++++++++++++++------
>  drivers/gpu/drm/msm/msm_gpu.h         |  6 +++
>  drivers/gpu/drm/msm/msm_submitqueue.c | 50 ++++++++++++-----
>  3 files changed, 102 insertions(+), 31 deletions(-)
>
>
> base-commit: 1e59855738454b14021b64115f0090eafc7526ae
> --
> 2.43.0
>
