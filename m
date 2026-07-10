Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E91C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6F110F8F9;
	Fri, 10 Jul 2026 13:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EbwJFvLU";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE7A10F8F9
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:49:03 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ca158f02ccso2412695ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783691343; cv=none;
 d=google.com; s=arc-20260327;
 b=cdo4gBgWE6znm6rtANOEPHPMDwXMbaky33lUO5F4GHMGmKthIYGw968LO1+UxqgFZN
 2My6Fvi8odye7ZwK0p4rbcFOxFgqXRcDEee8EYSbydGWK3pyIeQGgKH+ELzCp0B6RAPR
 liR3s7qzQgZfGG+Z7r2GawZiJoS0j6lZ9mfgBabX+Qegbq0c3NmkNBy6p9GItLVDLCnC
 /sPOjeLXrBk355j4+wVBjZvo1jW/PcmLBDDImrpK1vs+J6EO6ICKvTWrXwz/bO7IVxkh
 3KT8SG5cAMG73Zg6eaq417AEQAaJh4vLlffmlOCqAwaHMTONRT7qATeM0SMkljECf5Ua
 yeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xS4990NQQ4qRZRVu84VT5A1DwjeEZrhbYGDVvijlegY=;
 fh=d3UsW1VDBjBpW63JyQZRSUEhkb+QPu+wAXYqY3h9Goc=;
 b=fwx6ap/fQjpaOuH5WtrrdjGJPa325KbH3EJpPqTCVBpo6DfDMxhuIw93Vh67E+/o02
 iWoLPaqGduQTqh0rAxHn89j/+1Dqq0MnzLJi5SyUTqFzrT3F7bI7Giq64guQ+ofzqoAt
 QwMHvOHf2FfF4LMcnmVwv2n4Wk+8bFtOcdaGAk2F9gKJoGckWiIwi+FdmVazGqXoJnf8
 94H/95fNhe/lESymv1/EMPCCUyLlEhIhLzgMlCY9or8FFvucOXhdPgL2ttNvEhkNdKEK
 0i1gR+1lJxEpjq8A4UEdrEJstNAzO2EH/WZ6lcbYGMxgmxXidcciSSw5xYAY4oOWuK7Y
 6szg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783691343; x=1784296143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xS4990NQQ4qRZRVu84VT5A1DwjeEZrhbYGDVvijlegY=;
 b=EbwJFvLUTY8eFuVOS5iB1QNhDZNl5HVRbHISTvPsE/Oio6yDKvB16aogg6RrpbDw2q
 q3Zqe/xVUExCWyJWTwIRdarwtJ8HTy7TpqrO6STYMEJPtxYmgHaK/1UDhF3teihLjown
 +mzJBWGLYra2lEYWBUVfvWQFYRDyQawL9rE5NYGJdZ+5x5AKN5MryUfnGavmF33jFY1+
 RhVbDMQ+DQTQwZA2uBmUqKXpp8QrvkteMv66kX/T/89VVd/AoYo1c8lqCRNfnix7oCC9
 nyF2KSlRVqnU0azmLZzsRDXnolGlTLyoo9qPXzWghzTMWcAGdCDEISdgMZplAHaOpX4W
 53dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691343; x=1784296143;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xS4990NQQ4qRZRVu84VT5A1DwjeEZrhbYGDVvijlegY=;
 b=ZJ5r/oAmIYYG6pBEIBw3gcjQeYGmuQxaJ4OBHTpili9uiDTkxCdqc+tXW9ZDrhaChB
 QAeMtBWjmVhF09nj5K4ZeUfA53XkBJ0L4U+wmeGfcBbN5WFTXY+ZJzy8dtriWaizDSMD
 EA30XXCenWk4cSyqei27F+WcjD+yF/mPkMnoKseYKVk/b+vJ0BghG/fb52DNRvJtnwdL
 RW3T7I49S3w0xLkpvhpW1kEWH0PVNudCbg8SQQo5Q+xmdPOq+Gpy/HCpYrGM8lTS6zj/
 FYnxn8GBX4tYbWPrZyjGWUiNxzAE/tkLnFJEGfgDvrSt8NV+JTPu+vEHpLHCjcjlRf7B
 AN7A==
X-Gm-Message-State: AOJu0YzeHGjAYDY5MkOIVIv52kKJYFBt2W2gBa4POSC520JyUEsl8n8z
 t7pHXCwynqSv8sRBNAAuaan+m/zli8C4JQaP6Ii6TWJowdeZ1OsycBaHYS+aVQlbTwUG9fY15Ql
 8oXzrtST2rZ7CJJNdnI+PW/ZzQeglnSM=
X-Gm-Gg: AfdE7cnFJCSNonALeJ0JPDnYo66RulZqZtIvL4ElpYXNAprfA7RUPajeI7gAdeA9JW1
 McVdisXs2Iig0z+tb8ojDYH/y+RDjHr9v5Ws3RJ8X1o0DqKp6UxOsKUdFw2q8KQ77pLgAip3yAz
 IVNqun2o3yIgFfeBQM/MUaHBs+ggFh6FMgznF3/YJDiyA4LCU6KpnYjPgw2x2YomBIFui2Cjbe2
 PBVw6uK0cVrIjBNibyf6zNiyyJ8uPS3ZNZv2zkg0N2jD6LH/i6RrKmpMDQgerua7cCYOZPtjce/
 bea6zaI+IahmJ/br5wYAkJlg+axbxdh3khwVNoQ3B8EE3f1XrxHDspigxYM=
X-Received: by 2002:a17:903:1a43:b0:2ca:dc3:5aa with SMTP id
 d9443c01a7336-2ccfebd2ccfmr67524865ad.2.1783691343343; Fri, 10 Jul 2026
 06:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260709060008.529870-1-rdunlap@infradead.org>
In-Reply-To: <20260709060008.529870-1-rdunlap@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:48:50 -0400
X-Gm-Features: AVVi8CcK_3QnyMscbnBUT-PodKZQsI5aL9GJwYpH03HEj1BoT3GRsWZihGnfauk
Message-ID: <CADnq5_MUfwrc+X8T3EsirA5en+104cHM_6LfmvwYbjMYenRT7w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop kernel-doc for deleted struct fields
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jul 9, 2026 at 3:27=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> 3 fields in struct amd_ip_funcs have been deleted, so also delete the
> kernel-doc comments for them to avoid warnings:
>
> WARNING: ../drivers/gpu/drm/amd/include/amd_shared.h:481 Excess struct me=
mber 'check_soft_reset' description in 'amd_ip_funcs'
> WARNING: ../drivers/gpu/drm/amd/include/amd_shared.h:481 Excess struct me=
mber 'pre_soft_reset' description in 'amd_ip_funcs'
> WARNING: ../drivers/gpu/drm/amd/include/amd_shared.h:481 Excess struct me=
mber 'post_soft_reset' description in 'amd_ip_funcs'
>
> Fixes: 947e46eb2fb9 ("drm/amdgpu: Delete check_soft_reset() from amd_ip_f=
uncs")
> Fixes: b7500532e12b ("drm/amdgpu: Delete pre/post_soft_reset() from amd_i=
p_funcs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
>
>  drivers/gpu/drm/amd/include/amd_shared.h |    3 ---
>  1 file changed, 3 deletions(-)
>
> --- linext-2026-0708.orig/drivers/gpu/drm/amd/include/amd_shared.h
> +++ linext-2026-0708/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -439,10 +439,7 @@ enum amd_dpm_forced_level;
>   * @complete: handles IP specific changes after resume
>   * @is_idle: returns current IP block idle status
>   * @wait_for_idle: poll for idle
> - * @check_soft_reset: check soft reset the IP block
> - * @pre_soft_reset: pre soft reset the IP block
>   * @soft_reset: soft reset the IP block
> - * @post_soft_reset: post soft reset the IP block
>   * @set_clockgating_state: enable/disable cg for the IP block
>   * @set_powergating_state: enable/disable pg for the IP block
>   * @get_clockgating_state: get current clockgating status
