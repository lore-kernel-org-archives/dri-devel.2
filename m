Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E12BC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FDC10E5D7;
	Thu, 23 Jul 2026 19:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hzn7J8RJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sqq0xnSD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F3E10E5D7
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:06:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NIm7Fl840267
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=7H8RTaDppwMMut1xQuRrh5WiHZ8qkbLlNqzSomjJbd0=; b=hz
 n7J8RJLcLfBEIXkgm9XQ36qVYpiutidxvsXGDdsMi/CrWWlWAURd4dTy1OsbUfMx
 20QgtdE02gO5Loadsiz8P1+J4WjmjIvQJy8lsQwkSg4aJkK1xu/yiGKQjWJ9b+K3
 FYG42ivP1c48pVMsD1XB3ACqoItP5nYRw3KvIoq02A2dIRjiyIbwcw4fvbIZMxOS
 vlTHrDEsR8LgL67kwYRlmm2JlEeTmdJQ+mF3qGDDOWGT/Ditwlv7Gz5DyOy5huDf
 pASlWbNq6c/9So+VRVK8pWIjObXnBbGjmxB/dWoMy5HfpixQ77gNcNI1mwzVd/XR
 dvqM+Ifw3eRXyUuR0+Ug==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa18ed0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:06:35 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-451d80641efso628384fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 12:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784833595; cv=none;
 d=google.com; s=arc-20260327;
 b=jyKh2EpOWDhwE8+DiiyB+6FFBO0Ztl9m632VSVQ1dHuW+TSWSoSrv+Wnp6GlsxE2qY
 5Jf7uMFk6fauwIjHeG7DY/MvtUV/q+jaLCw9ki5jh3iJ3xppTnIMPlsSvl8s/4j3DozQ
 P5ePBQxI1uEarG98u/a6rnjlLkNfpm+rzNvLMoKANBVYH4G7f/iWzUa1M406JtrDsM7T
 2Qtb93uOISG8a/8hSXMVa7Cat3qDTm40rqh11mgQZ9gHITc7D3xeYfBqvEvzZQ03XD+6
 cpU67ODwbhwWpMI9JJrMyUJpD87rIS+AHZD+t9fOCwr7g42QrWJNVXxrjS8UwIBuinVv
 rbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=7H8RTaDppwMMut1xQuRrh5WiHZ8qkbLlNqzSomjJbd0=;
 fh=Gh90cStYM8D2alwdTxkf1/Nu4yop8k46cH9EnsqSVgA=;
 b=bJH7gfXu7ubqV0vUzsedwn0ti2xinQiYy1Y3gv/7fZBJT6kPhEmeQCya6fc6DXYQVi
 8ur4zfD5+9VukXI87AIENhKLvSe7ax13PUDbRhX5Ckzgd696iSEwJL1zRTlexfdUeAwF
 4B3XAZynyPAEgKSa2Ib1U1dE+wmXhvmvDdIzAHA2B4ojlwIdKMSw1EZY+pLXbHsK4T6F
 cLJCiKBQNNAyxaQ+K7Xn28MDC6ugRiRSlODKfyqZ/BTvbWXLPPG0lbDDlRSdyLU+tIQs
 cqXWxOZBWo+KL6cKgAtYjfw2SVz7mAKct3J5GLqEK8OrBhjxLlQRMuSBID2z06c88RB+
 gbwg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784833595; x=1785438395;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7H8RTaDppwMMut1xQuRrh5WiHZ8qkbLlNqzSomjJbd0=;
 b=Sqq0xnSDucdb9zKhZhlCTMoDnFeUcZ1X86l5DDkGjdPoQhEaznNqQ5Pjl95w2Elo/C
 GOmgSoLTmX7Ac2jt33aQQSQEZAjvc5BwQnhL8FzFI/ZtbOyNbwri2yMmCVwPsl+sVsWP
 8FeV1blpomYqmCfbpVo2UXJUGPSJT+4axjdokb+ReypEf7NUWKln+1p/pEqIMuwnxnXK
 I39goIaFxd8jQvcUzvKqvQJf4y+VDloAEeruE7gItJdGiNdUhryL/40zjsuGsEm7HjEW
 SaWxkRijC9hEYbRh7i/wJjIWXxgDYQbe9W3OXE4M/GghgFLPDDM8UuSjUX04hZGgosJ8
 74Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784833595; x=1785438395;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7H8RTaDppwMMut1xQuRrh5WiHZ8qkbLlNqzSomjJbd0=;
 b=bAhAUI9j3A2WV7atyyGmDTgy8sUusJRpREAkwGvGrJBlcF8fRPsK4UBTj96UpsLSzR
 tKsZe8y0oys04iQIbEraBrNR8icF2gkobmb5d+0XoJoOdhIDz/68RZxlJbwkckfqza1g
 At5lhJI6qYPpHzm/JHci6whI40UuowkFbRUTSt3yVdU24UXIXdGJ6GjVoI8jpt7dM2Kr
 M6xLlOtry7usc7ZH8opu5+zhLFTjwd1N10GIrlISYeK01IbEYg8/ahmFlXI8csuqKCWm
 NsxQQpCjpVaZCw1tMODzSupW5onnE6r6sLmumpE7QocvyJhnYJIizxYJlIUhCFajh0u/
 4ymw==
X-Forwarded-Encrypted: i=1;
 AHgh+RorO9l07aOMLArlXqvB1KivOcLsheaPBj5j+fICbXU4nZ0lnbSUem2qgjgKhMoW4yPV2jw6mjDkScc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxc/waREHNVX3VMfPTVEAbhdaaZgneDhC17f68XYA1Nm751pL4A
 fPCEnOt3/XnweM/n2KoSgZiHHWmnRkaFbLosZtytcU5AsWkKn+ENNGh6Cvr/4TGMYGOuZyvJLDs
 GI8DXX5FcChNcW9IDJLVu7skOp9HTTzAvw1pqxTiur+0S+ZlwybRGZsXh2y2LiqaykzYxQrpl7O
 AGJ8ej058OkrBVviK/45p8GN+S8vWo7mz4d9sJhazDqj7t+Q==
X-Gm-Gg: AR+sD10NkUxzFUekFMZY0oYcqdQ1Z1TiZIsxGMVf5tQ3xqfF26AvOWQ5IbnVT1EXi45
 6syeQel8iNSYyKOqLavtEHXdCJn0MK2PU4CqyNezZ2bkFgNxpvrhyPHkEZ3Hyxp8iYg7iLNs9ov
 kJsZmvkpGJi9+iDatk6Qo2piDFxEzTThAAerEsKPEV0l4qg4NiDwaNO78j
X-Received: by 2002:a05:6870:e129:b0:452:213:bd4d with SMTP id
 586e51a60fabf-457a0cae0d4mr2152609fac.17.1784833594663; 
 Thu, 23 Jul 2026 12:06:34 -0700 (PDT)
X-Received: by 2002:a05:6870:e129:b0:452:213:bd4d with SMTP id
 586e51a60fabf-457a0cae0d4mr2152594fac.17.1784833594209; Thu, 23 Jul 2026
 12:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-evict_list_fix-v1-1-1a1d80bf61cf@gmail.com>
In-Reply-To: <20260723-evict_list_fix-v1-1-1a1d80bf61cf@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:06:23 -0700
X-Gm-Features: AUfX_mwAHIQsars58_ywT15A83BfX3jiyvn7AcK-11XfI0xkZsPkvTcS4M5MF0k
Message-ID: <CACSVV006P+eNKzMbr1+YrqJ39PqFzqQ9L7gj93NdqCyD_UJZDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: remove objects from evit list after pinning them
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: fgDlnqucXrBxUQzHMcI9qzXnY1INjgHK
X-Authority-Analysis: v=2.4 cv=L4wtheT8 c=1 sm=1 tr=0 ts=6a62663b cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=r545bymZPMySM2Oib8AA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4NiBTYWx0ZWRfX8yVj3+SGXcCE
 b9g69su1S6BQNqKr3nTUvCRchwXTfqAxzOp64K5qCRy3uLmITlY1rOU5ir4eAltieJB4wEWX0Em
 SH9oTjbmRtjwjA/oPvCbFwWEFTF1feRFgphAWSio11x8O92r1IlogKbKwKNHaRKcV5Yw7sFDk+7
 bVPgVcr9opkQVc4u8RCR3qmb7CyN5JGmtWLv2XHRchIN5/kZ3ds/rTrKwT2ZVOdoiHzU43nJtbn
 s+3ryhb9eOtqz2wUBLp8/9zwXXUL9ZZBhppQtjh22lbXkyToq//OWJBB41XulZg5LrWsdzyZUA3
 avA0B3Px1xhW0WGZ8s/pb8bcr4ZeLUfEBd852irvluqoGeAabK+AuSNsYeIXjt2DFhM2puajMY4
 5Tsv4Y70gzYI/JWnY8BE1WcVEFmucczcnPENuiwxd/gTiVmKv2hPaytJ544HD69MgCLCrSkKsp0
 F1KLN+Nsyr5ay88It4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE4NiBTYWx0ZWRfX5a2XEZTqiVU9
 PUmmhdAyujAN433nm9tnLArIz2DsEbnupXho8ZBkU1w6hilxg7vgTltZik9KFEn5EPGCB/SagDA
 5XwSfaCM+B30iYdNkyikfoii2w5+lCA=
X-Proofpoint-GUID: fgDlnqucXrBxUQzHMcI9qzXnY1INjgHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230186
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

On Thu, Jul 23, 2026 at 12:00=E2=80=AFPM Anna Maniscalco
<anna.maniscalco2000@gmail.com> wrote:
>
> Once objects are pinned they should not be kept in the evict list as
> that will cause drm_gpuvm_validate to keep ieterating a growing list of
> objects needlessly.
>
> Once an object is pinned remove it from the list.
>

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")

> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_vma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 1a952b171ed7..4422677f095c 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -458,6 +458,8 @@ msm_gem_vm_bo_validate(struct drm_gpuvm_bo *vm_bo, st=
ruct drm_exec *exec)
>                         return ret;
>         }
>
> +       drm_gpuvm_bo_evict(vm_bo, false);
> +
>         return 0;
>  }
>
>
> ---
> base-commit: 9a967125427e03c7ebc24d7ad26e9307e8403d4e
> change-id: 20260723-evict_list_fix-1da92b2627aa
>
> Best regards,
> --
> Anna Maniscalco <anna.maniscalco2000@gmail.com>
>
