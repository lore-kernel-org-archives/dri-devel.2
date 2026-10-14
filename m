Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFAECC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C54810E9B9;
	Wed, 14 Oct 2026 15:41:04 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA9910E9B9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:40:57 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-7c05859ec4dso105149137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791992456; cv=none;
 d=google.com; s=arc-20260327;
 b=W7nlOyY6FxPRfUdzr4Uxt3l3Cfq08RwiIP6DKYMuFaBtMQHW/4ipGR4GfBLY276yeW
 o/8oe3cf+HgxxHQEfqfDHoGpKUzXmQ28d4eGeNujmrdhGcWkftnpD3Y9OMDyL59ds/GJ
 7OTtqOH7lUBxR9P4GlTX+DByJX4bV9B5n1LpDf4zastsT9Ph5smkerXV4GriVnmk3GpW
 J0B0/WqNGQKvAahH3xVYN4oV6m6qxDrGk+XPUjHggp8dGFRScm0wiOmN+KJUpOIMCqdx
 jv44QcZkiM+qd5VTzpZYMYrMiVeqhpDA9rHhAk/3+RU07d5NMU1q2BA9Jzq68KMbtufp
 610w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DbKzH4i6zRAMVk8eEw5RFUvTFq2T+6ztKAjhHEjk4vM=;
 fh=qE27CrvvGjv4f/uCSsK2O/a/89V8oBpHUyJNhIdUaec=;
 b=B/CEMYlqKzy39u/AgmL+ntqgkgngRB/OoVpzK/97X+ftNNSd/CfrNV5/5a723o+i1H
 uLZWMNLZnyTEv6Qq/S0CDM6142dI7LDuAHGYARTsUTpPZvH89X/UzrfkgzPvXwnN38fT
 gA3Pg1lSrkid5aIqJJ5v0by6X5P7gLzMJqctfnSf1elFwCtPkTXVH0SZpmggKR3THodS
 357ah/DxIo39H1ga2//6O6+Z7Oif/Vz0SgYzAkY3EZ6aA0znnq5NKtunQFyMMlRWWXZZ
 JLzmzco/zfW81u0BDkWZUe0uMgrIsJp3h/ajv470br7GqSOiDlIs92yqQqcvyA7R5j3u
 q/BQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791992456; x=1792597256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DbKzH4i6zRAMVk8eEw5RFUvTFq2T+6ztKAjhHEjk4vM=;
 b=fNiBWGAWJ7MUtSuMFZF13AgBiuyxNxU4tJF5Y6gHKofoVJiEnXf9x8HK2BVKx43gjF
 zFOX2ChPQQ1S5+j3ivnkrp9hr5vbUQBGR8quEIenpenm36pQfht8d60pvYnHE5Bid7nh
 d31v67rkyXgcx+RX5L+D1whOvpMrXzNb1oQgLBFil4KV4vUnGRhpxuDNsoOe1DG9G+Ja
 ar4kBTj5T7myP9G+gNo0Xwa3Q5rvGi9DbiB/dfSQI+sPTWy+wEhsDJ00hMjMa19DKmIj
 Kaz0s3oyNyGdld+Jhieikk6MrEGVYcbDwQL87e32fCEUNdyoNsrVjaMsONx6mduw9Y3w
 yzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791992456; x=1792597256;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DbKzH4i6zRAMVk8eEw5RFUvTFq2T+6ztKAjhHEjk4vM=;
 b=zBhJZ+sCbHCWYATDhT0y6G232yrpq5iDhU2fZIdDjPAoUYdxdw9OPOCk1YxTUAuhxz
 9vy1B2SuA4r0B65tW+DqiV+xuOS87Yj/XFsvEl34hTeCBjLA/LULDP2SKOnawMRQO2jJ
 2FOyXUBOc5ppbgCFVZMOc/C4DvoywFHZ4gb3IAFtwD8poapH2dX5YKj48zom8iE/Harn
 YiQTfVwtZxPVfS9SrnM6ASAeXD5j116EoDJ8IOgpi3S7oj24TIZ3mEarJUDl/SmMSWU+
 LBgpdn39e+mN9tKwdmR5jnRQmTpjMS8llnJO51D78DW0c6hQPRjW660p3CnfyLQEpIO+
 tbtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLdQrMvKYORqmHlw4jIY1uxeBudzgBxg/VKZS59+unkSjoz4fsHlolmwzZQKJvvHq9PZzVPdR/aV0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJpt8VwhhaC2BAkFjIxG6mqYkTXqHTG3ePKPGfH0jrqF4lE3gU5
 pc+4Fi6LNHtSuLlqF0x7ZZsLrynyMJ2a08XxBQbXJtMYvUaiq+rq9cpwoKXiolqqUFJ5lOKgY89
 ERkEaM9FO9jNW0A35LEAHGkZKkZgERqs=
X-Gm-Gg: AYBFou33WzDTmXEXk1BZkSVqC02P8Arxb5DWu1viocjIXaZ70KyLR+63GDlBmGlgh/W
 tMCT0TY0N8nzdFi15PbWzaqIeF2F7kgwBREyg/7blyq0/UwHrJlTW5x9+ULKcNqZzYyzovRbHhz
 FHtyXxm7Qn7899bzKS9k1izrNsasTNooaxvQ2DQ6mMtdqCoydS0oLzwggkaard4FzapCYoFa9UR
 Xu9i9dv3h558M/jSUiq/SRtmpyQi/17qCQ5Lp3p457094XP2f0AxzNWbm3+nlZnS5/ADJSAjcEK
 FzLf8D3n0ntGn5sMgd81yZaLp/eL1ylhSfHaWkmtQmvYiu+6XtqoyaAO7ssRgAT2li7OT1+P0Zj
 K+R7ofxy9WmxITIieDzSqrfgLclpW47miSw6glLcgYA==
X-Received: by 2002:a05:6102:c07:b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7cb3668aa3fmr4015389137.1.1791992456409; Wed, 14 Oct 2026
 08:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261013140104.32179-1-omer.e.idrissi@gmail.com>
In-Reply-To: <20261013140104.32179-1-omer.e.idrissi@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 11:40:34 -0400
X-Gm-Features: AclHuK9I1qQZX4KcbB9N2WEIH08IUM_G0_q_Cb0vteRJPQ5eD7bXK10TL33mfvM
Message-ID: <CADnq5_N_c9OdhcTo_ByJM+w__hhu97=1m9zsR74crivKGiiauA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unused tracepoint
To: Omer El Idrissi <omer.e.idrissi@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 14, 2026 at 8:56=E2=80=AFAM Omer El Idrissi
<omer.e.idrissi@gmail.com> wrote:
>
> Remove unused tracepoint "amdgpu_reset_reg_dumps", flagged by UT=3D1,
> from amdgpu/amdgpu_trace.h
>
> Signed-off-by: Omer El Idrissi <omer.e.idrissi@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_trace.h
> index fcd4cf2f4cd8..6fecee5be1ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -564,22 +564,6 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>                       __get_str(ring), __entry->ctx, __entry->seqno)
>  );
>
> -TRACE_EVENT(amdgpu_reset_reg_dumps,
> -           TP_PROTO(uint32_t address, uint32_t value),
> -           TP_ARGS(address, value),
> -           TP_STRUCT__entry(
> -                            __field(uint32_t, address)
> -                            __field(uint32_t, value)
> -                            ),
> -           TP_fast_assign(
> -                          __entry->address =3D address;
> -                          __entry->value =3D value;
> -                          ),
> -           TP_printk("amdgpu register dump 0x%x: 0x%x",
> -                     __entry->address,
> -                     __entry->value)
> -);
> -
>  DECLARE_EVENT_CLASS(amdgpu_userq_queue,
>             TP_PROTO(struct amdgpu_usermode_queue *queue),
>             TP_ARGS(queue),
> --
> 2.53.0
>
