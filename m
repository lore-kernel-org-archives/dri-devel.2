Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBA110F92EB
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3311C10E088;
	Tue, 31 Mar 2026 19:08:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aT60FZUu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MnmQ6rxA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579B710E28A
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 19:08:42 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VGdhQG3926859
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 19:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=RfD33WDA9eBXROKOLNv2BDIrHUF56VsZFatII1K9/FE=; b=aT
 60FZUuy8A4IbOSs+BO2hguvHvzM+G61XTY1pG1b5tA7MA24iNTc3H7zYCbMUNdVS
 EVJ26EBsOcKMriR+B8bkdOg2al7gdXuao0Z96Kh7FVHzpaTh1Q4KPUwFdPbnpm8K
 IMkbjmbwXsPlc3ZJ9QZuHgB/cYUkPq3acGF6L+Eso1urVJrmJTP4rNMnj/nv5AG1
 f1BDw8NsdIqMgeffyZdMX7AN/LdhbSpdHl47EiTnNDhArK8C1gzg/aByaG4GigZO
 L9p/RnyWEaT5rkWx/p8eYhjKOeE2hZYYKR0CVtsW5/PxovOEvCD5RWYg+U5wXKrX
 CAljSIRuTLtwhLqkXGRg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b932sww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 19:08:41 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-67e0df20fc1so23314589eaf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 12:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774984121; cv=none;
 d=google.com; s=arc-20240605;
 b=axAz69tcSs6Bi6Jdya64wXvkH42dLiL1A0on72hvUQ650m6kZhKoApT8aqP8lR9FHS
 LDAlXV1TyVn8uBJFur8m56A1ZH+xZCIJ3uuZuRxOT+aS29J7Y+1R5fW83UkGrpH8S5Fq
 ovMBBCiLjgKiI2jHOEBk1TiR4qpd/PLi2aX+Ue3LiB4dF26HQqME/guIBhA6uyq3XWOk
 qv9enmgRb25Y2WYX5XnTYov4jY9KKBKJqmP4D2LxI7ewNg6lF9rOAs3vcTmTKOv0uXbW
 CtbKnc8BLVxMFrJQ6wCu7ArLqhu14ERtrn1Fd3BSPM/nMBmdEp1nRKWbxw998d97d9SZ
 /iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=RfD33WDA9eBXROKOLNv2BDIrHUF56VsZFatII1K9/FE=;
 fh=vYlEbvu5f6t7pQk0OwKYQEGIdDSHtIxwB3bQEsscEm8=;
 b=TrK6i+7rtveTgm0HB0D7WsHfdJ93p/Mzp6TKckKVPIdtlcxYC7L0Tf1/bc4K4wovhz
 0AktqVy5QPsnivKP0joydC2jh6eSuPRTI3b9u4vbhWGX8ILdbFOS6yuIgdSL0N8DYaLR
 /O1T6lCH5iw+387AKoOFW99Q7lgCJvX0w5V3bu4vsZCYwxhEmOmwQ7w8e4JDHY498y3U
 6QDjwaspp17BP0dW9Kxa/QQlD0FRetnscB4DcD5o8bP4JfdalFPNMMrUWhWJN/6gHq1r
 UT64QhyQOLbOkPDbf8d1eX55WQBC+YS6dCobsp962vkvWG+0eNDbIG2RSx+/jUDpqeY1
 82KA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774984121; x=1775588921;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RfD33WDA9eBXROKOLNv2BDIrHUF56VsZFatII1K9/FE=;
 b=MnmQ6rxAhHD3kIVXIkq+9rbUwQ9taTyeHe+dY2Db4KX1XxWxvIl3w27zbBd66xhqWc
 tfzpLvHlDhplnzDwDIBb9+GCtgMdNwgn1SCvDJc+QD+F6rjYJ9eY7/YSHOXWe5BS7WKt
 s5NIoBjsQB7rApulaofUCLRYfH9dWxh/bK3QCKmsxkHbSMHVV1dFmmv7KoHGDOqr2Jzd
 nA+caFw0N+/b8Z+GfUo1zRzWIrj/XXXc//p1yeZH4rIZAGn77k48A9KxlcIFg8NL0MTs
 1X39OVKp30KMvVkPfbaQoUvdcEO3voC/e4G/Q5XS4wrSRaOOWaJozoOSz3hRlBW7B/Ei
 tegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774984121; x=1775588921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RfD33WDA9eBXROKOLNv2BDIrHUF56VsZFatII1K9/FE=;
 b=Taj1PFnCQBYv8JfgbsKbEx8qcDx7jBvUT8sN9TNoZYFKDgeuwfOkL7cVVpC7+ujTXh
 dykMoIf4FSanbCa3ndM8rfygYpNP5+qBOwqQfEIsnE/B9lg6CeJvOexfOYEtNA0wqN0f
 4pfLRJkYtSMEgZVAdRmbb/VeURRMjJ3jldPU3nZ7AzxHpe4dylG9a86tUo42pI9qalX4
 iyhCXBRcpTkFtsMIYPWIoBPoA8f9iZNumzKXGzm24xCRjJhVDTuA9Sp3PrgJAvk13bgw
 0l7GAl9KeCxr8VDdG5eLc25YkeEHN+GFWcUIt2adbMmqo3QIBg9mTKnS8BX8/LzkMkL0
 Yj/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbYldDL/UHb6Ah36OSqdnTanTtnUqNg96Nc4NudULzf0D4AQUnNnOEnzZQk5oX45KVquKtL5CZVI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz+d+bWqb5vNrZTijJO8bqEsTGdvJ6UO4iW0VMeTzKewkM1SLH
 jmS2rA7Z2iuOLDlMOJ7xycLv4E/VubV8rHg2VMrxdVWLwpbrBdZv5wOcPWqS+VLkFnthQjQwSj4
 F1KOpScRqRzu5c11wJ3GuMyAQembHJeWa67OF7NRMYrkU52/XGogx5GBmTxQhGmhLeI6vBRjWIu
 I05BwjbcJX7Az0/30D5JHiqow5fQewCzTATwJrdnE1rRTy1w==
X-Gm-Gg: ATEYQzwoZtwuaEvaZ4dVLs2gEaE+mF086dUTmu1Ui4PI0/l1cFsyzp8t7dBxVkoheCy
 4M5KbSsy+8OKJ18r4aM7bxx1rgxPViC5GqUL6oTTebtqugoCLl+1DQ12ScOPyaLF5fTZw1xbPas
 On6SobqNE9MAMF+kh0ZwwCJdSEEpbsFVCyKzAYitPST9fWOL3IM1kV5aeMwIdBQMKREpyy1YfBI
 lBGbP7XtnDPTD5mdmtPlzIavHZBA+u4NnWDhA==
X-Received: by 2002:a05:6820:1390:b0:67b:c5ef:abcb with SMTP id
 006d021491bc7-67fabc3ccb1mr275710eaf.23.1774984120998; 
 Tue, 31 Mar 2026 12:08:40 -0700 (PDT)
X-Received: by 2002:a05:6820:1390:b0:67b:c5ef:abcb with SMTP id
 006d021491bc7-67fabc3ccb1mr275686eaf.23.1774984120592; Tue, 31 Mar 2026
 12:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 12:08:26 -0700
X-Gm-Features: AQROBzBvAateYSIgol1xE404p0QVo18CvuQ9I4yG1ka6RfVGOoveibudl0Ox9Yw
Message-ID: <CACSVV03FFvi0c4XMEShmH5ou4OKKZcvvni2j=0DBoYnuT55ecQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/msm: Remove abuse of drm_exec internals
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE4NCBTYWx0ZWRfXyc/gBB5uyfRy
 XT7a53aYm20ZVlMzSo+SMF7MLAk7C/h/DTJRxnNiT9e+hI9zXScSBNjQHlJmh1yfu/mEYqFdfYD
 U8E6fC2D8sQAInrCrz5hV2r/tVsuhTJSK3EH8JJi4iXkACwuGEcY/rGCXe8dw7dg7T3xLve8rYf
 1U2mZi3/rcX+vn/Uxqp/i01YVhwNWOBhzwlsP7+plVe+/t6zIG5j1qPVK5NU+nOnYqBvGd8hwxJ
 Rh3xLFt5Ssgyu4kK1xwcNe7ZE2Yw/ZgkGsmtDjxq+kxvexD3+fVzbxkyZgwkZ0Pa/LnkdBEPaIZ
 rLkbD9Pqx4M3iT4/gZErkz4xHa0aN4404pKWl/xz1a0Yd1VtiHBkJ9kUO80nNy27YV6XkBxzKiu
 RJto5nWBDVtOkPPJcvLWD/RAJZoP1yVZyEK8f1CsBEvGa5ZF6vJkzsOoF/WWy8Uh5dB8ryNmhqo
 5qcNc52+MSl6vGygGDQ==
X-Proofpoint-ORIG-GUID: JjSjaxsZbQmaGzk5E9G8_OoZ6Lf_q2OR
X-Proofpoint-GUID: JjSjaxsZbQmaGzk5E9G8_OoZ6Lf_q2OR
X-Authority-Analysis: v=2.4 cv=NLjYOk6g c=1 sm=1 tr=0 ts=69cc1bb9 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=uC2hiXKo-rcvbCjx3PIA:9 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310184
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

On Tue, Mar 31, 2026 at 2:21=E2=80=AFAM Thomas Hellstr=C3=B6m
<thomas.hellstrom@linux.intel.com> wrote:
>
> The code was reading drm_exec internal state to determine whether
> the drm_exec structure had been initialized or not, and therefore
> needed cleaning up, relying on undocumented behaviour.
>
> Instead add a bool to struct msm_gem_submit to indicate whether
> drm_exec cleaning up is needed.
>
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

This is pretty stand-alone, so I can pick it up for v7.1.  Or ack for
landing it via drm-misc with the rest of the series if that is easier
for you.  It shouldn't conflict with anything in flight.

BR,
-R

> ---
>  drivers/gpu/drm/msm/msm_gem.h        | 1 +
>  drivers/gpu/drm/msm/msm_gem_submit.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.=
h
> index cb32093fda47..762e546d25ef 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -452,6 +452,7 @@ struct msm_gem_submit {
>         bool bos_pinned : 1;
>         bool fault_dumped:1;/* Limit devcoredump dumping to one per submi=
t */
>         bool in_rb : 1;     /* "sudo" mode, copy cmds into RB */
> +       bool has_exec : 1;  /* @exec is initialized. */
>         struct msm_ringbuffer *ring;
>         unsigned int nr_cmds;
>         unsigned int nr_bos;
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 75d9f3574370..26ea8a28be47 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -278,6 +278,7 @@ static int submit_lock_objects_vmbind(struct msm_gem_=
submit *submit)
>         int ret =3D 0;
>
>         drm_exec_init(&submit->exec, flags, submit->nr_bos);
> +       submit->has_exec =3D true;
>
>         drm_exec_until_all_locked (&submit->exec) {
>                 ret =3D drm_gpuvm_prepare_vm(submit->vm, exec, 1);
> @@ -304,6 +305,7 @@ static int submit_lock_objects(struct msm_gem_submit =
*submit)
>                 return submit_lock_objects_vmbind(submit);
>
>         drm_exec_init(&submit->exec, flags, submit->nr_bos);
> +       submit->has_exec =3D true;
>
>         drm_exec_until_all_locked (&submit->exec) {
>                 ret =3D drm_exec_lock_obj(&submit->exec,
> @@ -523,7 +525,7 @@ static void submit_cleanup(struct msm_gem_submit *sub=
mit, bool error)
>         if (error)
>                 submit_unpin_objects(submit);
>
> -       if (submit->exec.objects)
> +       if (submit->has_exec)
>                 drm_exec_fini(&submit->exec);
>
>         /* if job wasn't enqueued to scheduler, early retirement: */
> --
> 2.53.0
>
