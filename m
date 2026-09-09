Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FFEC79FBD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E7210F1F0;
	Wed,  9 Sep 2026 16:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZPlinXQO";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B0610E1E0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 16:07:36 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666bed441so1047605a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 09:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788970056; cv=none;
 d=google.com; s=arc-20260327;
 b=mOi23AFiFwxh8mb/qOSoYJi9YbI1l82R/4SvwzE5YfLxtDGU3kO6puWMeUc6rU2LtE
 HQTl650RCtBjf/TRP/iOXU0BLxa5E3mBNIbqTWaYXFB16oT9Rs98FvpESKQYWDTThF1b
 hpAywR8n1Vec3Xy69DSeoMu4YAf2oJMn5XwfZs1ltFBg17uqJWJ4g04q7R7x859WfcsF
 3keT5MqwZTZc/AbfbpvyE1a6B+BfQdBf6dt/1/oSlsW+PlPcif/gAw2cd1LCG2HfoYGG
 SsihdVoCIVD5xQgcXdqvVOw5j+A2uzXu5jcr3gD8PMvk4num1GGxJg9JKkHwIcXqoEFH
 vxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jdoulqW/dybJZI4GeBlXySvh7R4n/US2mSH2P60zwMg=;
 fh=ina3u+J7RvRUZlEjKkZcKfYkLG+agNbEasjDWH63+4c=;
 b=qb6iEmohLPbE8ma6N5n0iIBfmZ17UbqfwpV5Cod8/4sCTZ2GUPQw/oPU8Mn1pQ5dMz
 2dBGTM9Y9ZhrE4g7tD8b70q6aIonBmAIsC7mxaab8WUVlih9cW+zTrLX7J2MNG5fWF2n
 A9nkKsYO+6eGIlFYo5xHs+egeq2lW+ZJ4Kwy5EIY5iHF7jM0m1jQHpUeJsNMbV9kkUdj
 /ZBF9NdPlgzkNUwfrAUKpVgPD0IpavS7Yblo6Dq3LnBU2d9woqKWNmHWaAzGySzYRh4g
 724fkptrSitdUzREief0FtSiYhOXWgBrmbVuS/PpoDgzFIk5o8/fIas3L2b4CKzn9tzy
 q8lA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788970056; x=1789574856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jdoulqW/dybJZI4GeBlXySvh7R4n/US2mSH2P60zwMg=;
 b=ZPlinXQOq8nS1V+DDzOC0Ro2mZkgtpWrJw7PZUdpplrq59+Z9JCfkr2CWPQP9lgloj
 +7on2d7VRxs2vEUC/fF8YdPONog4QN4JBIm+5rQlPKJaQmKRda+g52EuwL7OsSmzw3bl
 CBvB/OYaDEGy2bOO4TDUk7W6FLCokAIdZbzZUkYCKL2/qCGupLXE1oY92NKjzaaVcrSk
 /VwZnpOBcbFfmkQ0wOXuRZvQnW01/WXjtCK76WV9lboF1k//MLwhUwc8mSLfgJw0qmOC
 gCqoUL2GVixz4fqD0KSkAj/x0S6XsIAy5AiI8gJi9avjROLA0gKLeYbBrwguiGca43Pt
 g2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788970056; x=1789574856;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jdoulqW/dybJZI4GeBlXySvh7R4n/US2mSH2P60zwMg=;
 b=dzTMfdhwvh1QUIEG6iBmku12PZmEWcp2SI7yv2lJyd6tXmrvK4N2Jyidd5rvjEerop
 Pg4e3tnhms9ALAAGNuYdBBOBPTJ7mEqFGXOuJMoMcWlmFo+1Q+wRbK8XZwB5B7+RPNFh
 YTSz4zAT6NM0/Fewh8Srplx97zQSOqwcDbpdHHcN1i9GQuQUBs72ANtD71jfU1GejEqs
 +O1fvlmUnI9KaIICBhZMnOAU6pg/hZIDlc/8VanZq4XR+BWQ+oN0qvf1Ey+/SxeA86zt
 T9cBG37QXQyQXs4YHbHp+DbelKGozLniICeeoGhmAmolxgtjSP26YztfP4XKxvewffES
 yy7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPu/MJYtNOJpVOxRVwQMXKD35xliWqwqRUWHSdY+VB3gCyy5xeuJ+MUoXVZh9ymZBNMUoTWTo5Arg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lBtW4rZjJFqidvypPQ41R25ngX6YsZcNtwaNGwx2OEDIB+NdEY
 j2hSIDpmZRR5OndudIwJgocsnvTRLtrIhBKHHQqLsP/Hpy6HlocOZWgq/J2RynAa7hQqtpAELCG
 YYkTsRaa+bXem6Lv478lcldkU/vc0qHg=
X-Gm-Gg: AYBFou1NMZ/vcC03aEByUeAmm6Zv5U4nCm2RMIIKnX/VqENAVbBfhd9DAsnB6eXWRvm
 mU3F+A/9nF4jUetagZywDKkISPY/5Qmwx9O/IcuzDiMDrkN/FctDtPqjO093l2ChrkKIlJP3uAk
 4LAkSztI/pX4TQLyXygwzcdU5+YQwcdZBQ6HdR+PY+y7ejmnSqaFmbSPP15yEPFW8zcNifo9lmT
 v8PScwNPe7jB52DmZbCOobr/+A6mdZm9EVjUUeYXfZItbOzNpKVFkRU8g67laut+6/FyVBjMJMx
 E5wtj22zKJl4DBbmaVsGfErpKeE87YJ1RV/Hh3t8BSlb31424PKKC4O9iNwhn2uT//qEW5aeJ22
 utKzXl2ydREcg6KoUOrtxz5yCYZisJpYIhJHbiYQ/aw==
X-Received: by 2002:a17:90b:3bcf:b0:396:d27c:8696 with SMTP id
 98e67ed59e1d1-39b2693597emr36809891a91.4.1788970055249; Wed, 09 Sep 2026
 09:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260909093728.642473-1-yijiangshan@kylinos.cn>
In-Reply-To: <20260909093728.642473-1-yijiangshan@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 12:07:23 -0400
X-Gm-Features: AcwNN1Wg-EmmRELnPbnQlQ9xJ4UlYGkSyIL0bUzk_gGw4JWn23xrtxMYlOmL-yk
Message-ID: <CADnq5_PPJHOpgVo-+r-g6X1Z3r2wRJPkE-Dkp2gpt12Q5EGUvg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove redundant NULL check in
 amdgpu_cs_vm_handling
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, tvrtko.ursulin@igalia.com, sunil.khatri@amd.com, 
 vitaly.prosyak@amd.com, pierre-eric.pelloux-prayer@amd.com, 
 moonafterrain@outlook.com, candice.li@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 13667453960@163.com
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

On Wed, Sep 9, 2026 at 9:05=E2=80=AFAM Jiangshan Yi <yijiangshan@kylinos.cn=
> wrote:
>
> bo_va is assigned from fpriv->csa_va, which is already verified to be
> non-NULL by the surrounding if statement. The inner NULL check can
> therefore never trigger and is dead code, so remove it.
>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 03b41f803520..c978f042ae1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1146,8 +1146,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
>
>         if (fpriv->csa_va) {
>                 bo_va =3D fpriv->csa_va;
> -               if (!bo_va)
> -                       return -ENOMEM;
>                 r =3D amdgpu_vm_bo_update(adev, bo_va, false);
>                 if (r)
>                         return r;
> --
> 2.25.1
>
