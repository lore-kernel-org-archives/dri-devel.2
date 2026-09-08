Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A09AC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD89A10E163;
	Tue,  8 Sep 2026 18:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dxcOAFJd";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4275210ED10
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 18:24:32 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-783249c8d82so119891137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 11:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788891871; cv=none;
 d=google.com; s=arc-20260327;
 b=VdSnO8WDU5c5BahqIexCjnDQBXgYTGCmoatZs/EqOdphrkKQT+a25O2NbGm7qnJBXt
 4RdVKKFi01kqWkCTwi73sY6ED53gSKe9G21ZHn9DBmu26dkmu6KO95amE3eH3bwFY+wQ
 yiouNX8o2fPE1OUOMYwBjKEgv9D7sH9SFVSTUYDG5Jv9Fxkro3yU2itjvedxi9e2PjHn
 52Wc6bx9Mcq0zC/wVoiB0CdT9ovZuuZQyUb6q9EtQtvwXx/eLsZ40cCAQKh+vkZCw2Hq
 b6lZIZXPvE1nxPmtDwSCcq4juGdEa9Nr2kQFPc1NM2hONNbVow0/9R4cFUzEii1Jy/uw
 PQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7dDlt7A15+D8kvp+wdkvNLV3QYDahtH6TWhi9Cb0jpE=;
 fh=VTECgJltogyTqCtJW1VfVUNugirI+uXNoB611I77ulM=;
 b=qdrhoCD6eP21k378/9n9Gmp/Lx+IU57OJ+nLpqGZRrdTiXslmqLj/QGUdxbR7rtzsQ
 XQ0EFrTMtvqSFXPu0qhXHXn5YGQtMTJjLBZjTSyfu+N9gk3m7Y9RDNARvxHLagtE2Wr+
 qeW3ZNLKlAFdkozXdbyb00upmE17HrWnE3+Cq4XUQXThY4e6+h8oF15aa4KCs93dEpND
 IA2taKoSBZZ85GnyUjiYxhTOPC8bfJc7obj2OM+lrxf3h6fSyGU2fdkv8oidPe1lbXE/
 ocIJ+yubFk2mKRUec0wHnx9J2fmlQ85jtMvCx6yfmdexYIRkhiZhDsRs2tOS9Y6YFfjs
 DkRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891871; x=1789496671; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7dDlt7A15+D8kvp+wdkvNLV3QYDahtH6TWhi9Cb0jpE=;
 b=dxcOAFJdu6IXf9RREtN2jQwkM1q2PUnQACP6aM+27BNBCivFlvs1lzEHrhNU9sbfQ8
 nnSPlJeAmOeTDxZfSqzNN3HCE3cTvcTAhMCGTQ9P0WDSZHattcWpWg58uKZv5Ruxa1oD
 z768iqnFnyfuykQ7RftZ+fKACg6slUiDmTv0locQ5O6AKVfFcMhyy3wCWhdcTGne6b0L
 yo9m9YSpJilUvJPP8t8Vt9tHClyq6pfS4Yza499Y/2ZGbhRcqyL/fSyRLktB4rn2ja0G
 QNeVnuOPEMLwSk5bGU2G3H9UgUfls+qzAfFf6s5pc1viH4lS+wpK3AJIDmbjMy06sLts
 X6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891871; x=1789496671;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7dDlt7A15+D8kvp+wdkvNLV3QYDahtH6TWhi9Cb0jpE=;
 b=ct+hnm/LG5Fj1WCB/jTTIHT8E7woEIhBaBAQjph9aTUd5hsQ6cyaoZXKB3el3O+GoE
 GupmP0aur5nPr8fL7IBIkWFp4Qu07g+tnI44ZyHhsUJrKPPblWoNv5kGLoHwmy51Z8bR
 2Q13ThVMTDC+Vc3btF3+/LxohexHYKgkojk+ghCAWUsGP8ifqNNSlZ0MhjexgbPrfyuS
 1KaGg/qEPvB7aQhloqf5LxQcZMjtFIpeNzhHIkknAHlOaIup4QBxNG0lsecOxMtBnkFr
 aO59U8MpFhHJD/nIh8LLMa4KJRs0cWbRhNL8zgf3a5dsWp/RsnowMLX9+t1Mnqc2MSQ7
 i0Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBzX9CRD6r57Plyv3Hs1OV8Kr6oUVGBU6I8DyGc0v7FcQlQsvbX7cyJXMJO1PLTZigSjwH8FuFjfzHU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lyZJYwyxDpHZt1Z9X6Y575ASRh/z10ewkFtc5QsWwP+RRi9FGJ
 rWgS73V2jlQWq81auGLyyi180HMMhZca94WWxpYUkJ6svB5nzxyvt0MGyq7dJOI3tp7ISbh3wo7
 GwXIBoWqhie69uFj05Gh6tkg+2uapbLI=
X-Gm-Gg: AYBFou3q+FHeVxODae2drPZRSX/U+eWryVm0+BwL9qAVIOAPE5NEKtlxICyAOyFjUGu
 Upa+F/hy5RcgnbM5hjGYgioZtYW2RnMxpivZ+0YtGhFvxcO172MiqmmYQTJAhDDqKAkSV39Wr7N
 Ybo/kBVR9+2lLi/7lsJCYzLZ2kUksgDuL1lGx1x+Nql/bbo8lMK9kyMyINeORCGaJmIk9dvs95v
 mBOHxjloXVXDx61/k2p5IutH6TxiHkfeHZ9N7+cNZWF12qyDsYgY6jtY0kh2Jefz4FlI6lJX3Nn
 kfflWozK0Er6FxstKaNX4R0pTB5L2+Qn0sVCPfsa7QQczugXA8H0iR7d7NPxe5NEvNkig5myLEn
 uSTTq7wjY+76/09P/uC06UOCnWMPW/KFbQknFNW1cX+U=
X-Received: by 2002:a05:6102:390b:b0:784:a169:1925 with SMTP id
 ada2fe7eead31-78a60f2f87fmr3978548137.2.1788891870816; Tue, 08 Sep 2026
 11:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260905133405.3733-1-williandossantosdeoliveira287@gmail.com>
In-Reply-To: <20260905133405.3733-1-williandossantosdeoliveira287@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 14:24:16 -0400
X-Gm-Features: AcwNN1Uk0e4DpddE6Fug7WAF4PUZv3cWBapnLxAt0DlxdiPlRpH65L6MJkBojVM
Message-ID: <CADnq5_MKbn9CArL+JNT1NLkK0b80CMF4B+yThgbZTHbKS4FByg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx8: fix register_list_format leak in
 gfx_v8_0_init_microcode
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Sat, Sep 5, 2026 at 12:00=E2=80=AFPM Willian Oliveira
<williandossantosdeoliveira287@gmail.com> wrote:
>
> gfx_v8_0_init_microcode() allocates rlc.register_list_format before
> loading the MEC firmware.
>
> If loading one of the subsequent firmware files fails, the function
> returns through the error path without freeing register_list_format.
>
> Use gfx_v8_0_free_microcode() in the error path so all previously
> allocated firmware resources, including register_list_format, are
> released.
>
> Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 7f91186ef1d1..b213870ecb96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1211,12 +1211,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_d=
evice *adev)
>  out:
>         if (err) {
>                 dev_err(adev->dev, "gfx8: Failed to load firmware %s gfx =
firmware\n", chip_name);
> -               amdgpu_ucode_release(&adev->gfx.pfp_fw);
> -               amdgpu_ucode_release(&adev->gfx.me_fw);
> -               amdgpu_ucode_release(&adev->gfx.ce_fw);
> -               amdgpu_ucode_release(&adev->gfx.rlc_fw);
> -               amdgpu_ucode_release(&adev->gfx.mec_fw);
> -               amdgpu_ucode_release(&adev->gfx.mec2_fw);
> +               gfx_v8_0_free_microcode(adev);
>         }
>         return err;
>  }
> --
> 2.47.3
>
