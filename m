Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F48BC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7B010F7B9;
	Thu, 24 Sep 2026 21:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YBaKl6/x";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CB810F7B9
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:52:46 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e4e75342aso19175eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286766; cv=none;
 d=google.com; s=arc-20260327;
 b=kzisMDnWHqxYaWFVBtq1A4qQE/3O4mJhYL9eazpcNcgymDd3cEM2i0H3LeSUz44jn4
 6L+rWuKrA3coCbTsduVin4NWRw8arkB8sD3EBe3sVyYz9IDNeo+zF96Hperpxo/TEhAv
 jigMJxRJnQbZWez+kuuEHG4IOwDdsYzyh6IGnYqdptIFdWeM9NK7gS+9BS1AFM40cnbW
 dMjSwO+z8xR7XlwVOp/TSjI0JeTumLEiJIMn1y8O18MC+xMPl0bMIy8xNwFI2rpgQQKW
 KFqS6tOdWq7HGJnT5NKmLD7ksQPUnUG6OqGb/Sa1kNxpZY0YBjfuVjxjyT4uVXqWYMzS
 BoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
 fh=cxxL923+74eL6F1bwXIiYRvPs/5DfK6r0ZjWLgbjXSM=;
 b=Rdq+tXVLxgQkvYzTi1mUEcLdaBFhGV4BIwHih5jYoz9REWnkelpnugdH6M1L2itAIJ
 H8J+ffhgaXk/CHD7h3hs0CAJm55X8jTvbWQpGDO/iR8h2QZ8ZWHq5miLIRJ5eDMh4EF4
 C590L30llki/Tmy6VLpYDshnGzQb6iBwktuUaNykVRNbCkfrMTtT+VX5TsrzRVTb9c6p
 f+Yc21sJUMmR7Zp9R90bLLXFDvHj4bsH1UZBcpowAYG52WUhiF4HX1DSTgpfG54yEdWn
 t6QdQdXoBHU5WWBpWBXVwfFNiOVZn1B10pM//BccEaBbZMc0uT5WrZubeJbqfxGSjAHz
 yjlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790286766; x=1790891566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
 b=YBaKl6/x+RRgl93mQn9yz8h1zO0A0wfTIMO0atBiKKxNQuLfEDg0RECrq5F0TySBJt
 t0FqI2dqslLFlTR9vnAxg4OFEkJj9Y20lpxoxQqIEys8pv/eJgXcmnizYNa4r1Nm7yV7
 XuW3TNW7zC/TJ/s0n52iBEXMRrWU+WXbMZABy2U6zR0dhrqvwyKqUX5sfkPB6z0TNOJ3
 yqOmYtKaxpXW+plXCCFZIpCAME0wndtom6IwPnKcbW7IXQwggsCpvSuxZ6ZSGR1nguqz
 AYe0eV+7jXdKkUAJIueW67f6MfYrErqS52gp2kjM1wpNuBwDFp74lgh6OhxFn+RmnMFq
 7wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790286766; x=1790891566;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8lhG9wb5QlfLqgt5UEaJmUthOlH8IOrrPdU2sMoER/4=;
 b=xCKO5u6dPYlkuQoY2BH1s5ge4w/uqzpj+CeC5CB7TnS5sRfYIIjjInuHw5EuybSkHf
 PoaAnJmWV61dxQ0EDBrJRfzV7UVwbE/unTAWHXPl35hInZAJ3Uv/TJ7ILvyGIN2rafSm
 FQlBVTX2XlOryAusQsqrLAf7HbRYzBJpRRL1nbbzHt7I1lVX8KWlqDbGKdE6OiUDXSjf
 r4voh7W4akll2h/wieIsCmD5ZdBBZFBt/pIQxXxqYCSyqcoAsFWsYsRBwsiIArjsgZfb
 9O6QdEgyT8/4uI76awohpheiruqzX+4WFIDuIaJaX+uHaub3/yd/x8lHC3DkU57JqVda
 8Gcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2f0AGlgPGAjNCH7i69fFTwE3RvePhlptcOIl2XeJ00DdQQZK53nho9SgrwRP5OnPmTEZ8mKlvnfU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++neXUpOkc7nJx97KHwOZzjwUT6oeyncwzOkVRIdRL7GEVNcwsvE
 xUaAec1f+q5F6gI4tF+1DNLVXrSeOydLqYpnM1lZXPSOBpaHDnpjxgDHdo0eKJY7znBBIiDsXAA
 pLzhFdyf8efq6JTmxvwmYLhvDkjfDvhY=
X-Gm-Gg: AYBFou06rbrFtqDeIbeMiafYoDRm74bCZ0jUYkKxTbfgGE3jIjh6+/RgmtDbNA/ZtRQ
 iy3ayYt+ESNqZz2p3oJ1OLafty8A8kEt14xKTj2sMxBxnUSyCDPFZimz1dm7BaMXNIiUekzJbiQ
 eTlXTeNqZESEtTDnk36SYQgy+y2HSSKpLgHUZwY/1co3ztmNYPiYx3IZgTCM7mitV797rKk7tyR
 E53Z45Jtnk5S/NnU5rZ8fGo/xqWe6RS694G4WAC7NsRDo2WXHoUwvWcfAs+CtfpoiaPcCrRyFmM
 iEJqYnY1qCf3h6G5JJROgAJNOoLwvyK53BUSNU9VC1h0Z2eLDMDjgJ4EikuTqZa4azyzJCMClAq
 tvR4vQDC2lJLqYd44/s+iVJO/WZGzSkgy/78ZjP+DEw==
X-Received: by 2002:a05:701b:450c:20b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-14503f1814fmr4390022c88.2.1790286766083; Thu, 24 Sep 2026
 14:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260923152912.1296884-1-qwe.aldo@gmail.com>
 <20260923154357.1319689-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923154357.1319689-1-qwe.aldo@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 17:52:34 -0400
X-Gm-Features: AclHuK8_S3kMABiU0QTNjcDgoAqPTQebAhSNKvPGJWpzU2O6hEoWY7qZTP4di-8
Message-ID: <CADnq5_PuveD6MFtdLFkkHk24jVCQqgyC1R6pUy7ri_RyWVSZXw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: prevent parameter-space underflow in
 nested ATOM table calls
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
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

On Wed, Sep 23, 2026 at 11:44=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmai=
l.com> wrote:
>
> atom_op_calltable() invokes a child ATOM table, forwarding the
> parent's parameter space with an offset:
>
>     amdgpu_atom_execute_table_locked(ctx->ctx, idx,
>         ctx->ps + ctx->ps_shift,
>         ctx->ps_size - ctx->ps_shift);
>
> ctx->ps_shift is in dwords (set to ps / 4 in
> amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
> remaining capacity in bytes. The subtraction therefore mixes units:
> a child table requesting 60 bytes (ps_shift =3D 15 dwords) with only
> 16 bytes remaining would compute 16 - 15 =3D 1 instead of the correct
> 16 - 60 =3D underflow.
>
> Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
> subtraction so the units are consistent. Abort the interpreter when
> the request exceeds the available space so the parent table does not
> continue with stale or uninitialized data.
>
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v3: abort the interpreter (ctx->abort =3D true + return) when the
>     child table's parameter space exceeds the parent's remaining
>     capacity, instead of silently skipping execution (found by
>     Sashiko AI review on v2).
> v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
>     ps_size, fixing the unit mismatch (found by Sashiko AI review).
>
>  drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index e0e585f..af283cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context *ctx=
, int *ptr, int arg)
>                 SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx])=
;
>         else
>                 SDEBUG("   table: %d\n", idx);
> -       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> -               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx=
->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
> +       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
> +               if (ctx->ps_shift * 4 > ctx->ps_size) {
> +                       ctx->abort =3D true;
> +                       return;
> +               }
> +               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx=
->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
> +       }
>         if (r) {
>                 ctx->abort =3D true;
>         }
> --
> 2.43.0
