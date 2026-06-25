Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D490CDE015
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F6E10F494;
	Fri, 26 Jun 2026 07:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KaT1iddS";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA4610F2E3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:26:38 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7f69b71f7b2so26576617b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782397597; cv=none;
 d=google.com; s=arc-20260327;
 b=Opdcl+cZu8XltH3ogJjfOPx21UWjTqu0mSpCyc4oWrLl/71A6HnnciXCqwLn2QYmMR
 Z1XMoJrlEbLfgMHQos8PlcA2yS4bJ9ClnVGYpmbzfkq0cOlwuEe4kpiZoaD4yU0O8HpA
 9f1P/JINNtSYvkX1ZNiut8RF8dZ1cnoTTM2gkG5+bi0xxMdy0Smk7I2D5caUFCxJxCPI
 CKsXBlSta3VX88/qHSzFR9251EsUbrpe6J534qBGmDcpc70fmGC5sIR1wvt4mMDfI03B
 e7olQ/jmHPN9xi/77draInGuXRABWEKgbmxxJn4pBCAwGwBJjtEkm8KP9BVQ2+9ynA90
 7WlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=zG0ziIrnl5+Uq7ZzfQ6z6EifKGZA4Cbm70aG+1ToxjY=;
 fh=iuK5IhqSiVdnBcNOF+xCdpznzkeJgK7GiBXRDQJ44Bs=;
 b=iQ1u6BvsjafedB11faZwB2ssLODYpSys9DBJYADl/KMvdUr/i8xvQHP7CaT7B9Ldq6
 J6P7q6zOHcsBZMvjDBmrswt96N7WILnBKZjvwNS8r9up7iaD+9WbcMI5NWdDjb6T+a+D
 SuWlSZfHFTYUFROaW9JHZqtxXEy9WRC/iqTEQCNcNDeueuz4mDtIbEy8X12wATJsfziP
 m/3CtXhFTpKT4an8v1fBaItTX4mmhzm9EBRcPCn9IIdh8Mw0EBZ8BGwdoHnBja/Wkl3C
 zzAkrJneSip8Qb/hixu+w2eOF6LsA1J5kdtJMVFYay8yU9DnfMUZAmFcb34g7oq0lgJM
 Ln2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782397597; x=1783002397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zG0ziIrnl5+Uq7ZzfQ6z6EifKGZA4Cbm70aG+1ToxjY=;
 b=KaT1iddSxn/bETwnP6DZu3AsNZ19jacJhqD8V7Ib26Ti0VIRUKtl1xCEZPvGoRvksN
 tvMy01A6CVEp80kwHurjVL+worT6UAWZxUjKxzLX0Tg42MrV96cvNnqgmV0Z6QIPbNTl
 k9JDlp4yUN18QY7BhGDHJOexwEk9CNXcrTvzU00M2CxbeMouOzGjxND2iJDjBct3bi5o
 cRUtwdOVJWZmoaqgbF/OhR/3cnn7ywNnzsPdXXzWdO+8mKHQpL+308yEE2KGdjwfENQ+
 hmwtXcdmTlHf9v9cfuJDlH32PAYOs3EWmCY/C64xssEYE2LS45HhbXLoKVncGkWshtfK
 gcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397597; x=1783002397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zG0ziIrnl5+Uq7ZzfQ6z6EifKGZA4Cbm70aG+1ToxjY=;
 b=rO7KkG1Vn4FuY3mtzRsmdXhs6kPixVUAKuTOvYHQ990KAn7aKMf0aeOvDzRJQaoxkE
 cP2nB3Q9CmoNnlde0unbwMJOmmyvKe2HFemo4iSWXZo6g2B1sYeBV/qPFmq20KMbjBzs
 kxrjGDQu099QMM/I4iydIDKvnKTQsb2G8KO6nDSLnxU68/XulqU9weXtCnLUBguX0RyR
 9bMZWagSY1mLhhYwdLA6gd0yjXAG1BGwZHiyKVSDx1EaGJiQy7i+VGveVoLw+NALi1Za
 OmImKy+jUjI2lLL+EZM5MK1Gt+0sK2YwC89i7/Ww/YOcF+pw/KMQa1rqTYJg6ZfoO4GS
 aZ1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHkNNL+xvk9usNxc2FcUW7JG/KeDBNoqtvWe0uQNR0PDahuZ6jlskcdQ7+xXSToHkwHyicU5kD6/Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcCyEnGjQmhwHwGJw6R3fvIVDui48EGYZqUtCtJwBzGoGhde3D
 lDPrjCpgdIGETLwircA+RG8CSIcissHSRjKOW9529Bx0ez0YKKtPT7XGtaQe9COPIJyoU2B9tkH
 Vlca4b99iSzMo8BPccLSu2UFPKKndx0o=
X-Gm-Gg: AfdE7cljnAR2plC1ufFveA3ij6z52hloXJu7izhcVqj5bPIPEGuTxPAdhpSOvM+V8IR
 1Ki10hKZfBGkDq9t2gmLCDjmk1vnOK0EHRbnAeyvHHsZ2SayX6ERdl0mftvpWuwur9C4Yun/XzF
 1E4grtRoC2HyZAq6a5UphJgxUtYL/olXzcPadBUuHYaofTiAgLOXn9MbwenHqKRWDPxMrhA7/wO
 qfQd9H+5fXuw7/RGzrHjfztejLEKlZFMTV5cvYIULwxcxZtPyQ6h+w6nWVrvXsOArU2HTRt8Q==
X-Received: by 2002:a05:690c:368d:b0:7be:fedd:726b with SMTP id
 00721157ae682-80a6d262368mr24686747b3.42.1782397597299; Thu, 25 Jun 2026
 07:26:37 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 07:26:36 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 07:26:36 -0700
In-Reply-To: <20260625135341.1159-1-alhouseenyousef@gmail.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
 <20260625135341.1159-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 07:26:36 -0700
X-Gm-Features: AVVi8CesCW6iLL67hakaynYG37WtYiPVPjL9y6jKGomdujasLZOfkHuY3iSrjGg
Message-ID: <CAMuQ4bWVb-vxCWMxF_JpJmBnKD=rVH2KZWf36jnzPbC35CdrmA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: reject mapping info when BO VA is gone
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

Hi Alex, Christian,

Please drop this v2 as well.

I rechecked the target tree and missed the existing !bo_va check in
AMDGPU_GEM_OP_GET_MAPPING_INFO. The close-race case is already handled
before the mapping list walks, so this patch only makes the later check
unreachable and changes the errno.

Sorry for the churn.

Thanks,
Yousef

On Thu, 25 Jun 2026 15:53:41 +0200, Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object from the file
> handle and then locks the object and VM before resolving the BO-VA. The
> GEM object reference keeps the BO alive, but it does not keep the
> per-file handle open.
>
> If a racing close drops the last handle reference in that window,
> amdgpu_gem_object_close() can remove the BO-VA before
> amdgpu_vm_bo_find() runs. The ioctl then walks the BO-VA mapping lists
> unconditionally.
>
> Return -EINVAL if the BO is no longer associated with this VM.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v2:
> - Describe the handle-close race instead of an initially unmapped BO.
> - Return -EINVAL instead of -ENOENT.
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 212c14d99..6f5b6f4c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
> struct drm_amdgpu_gem_vm_entry *vm_entries;
> struct amdgpu_bo_va_mapping *mapping;
> int num_mappings =3D 0;
> +
> + if (!bo_va) {
> + r =3D -EINVAL;
> + goto out_exec;
> + }
> +
> /*
> * num_entries is set as an input to the size of the user-allocated array =
of
> * drm_amdgpu_gem_vm_entry stored at args->value.
> --
> 2.54.0
