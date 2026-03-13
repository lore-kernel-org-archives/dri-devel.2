Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0692A105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6321610E06C;
	Fri, 13 Mar 2026 13:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxvOUzxq";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF3610E04B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:35:57 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12734af2cdcso101455c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773408957; cv=none;
 d=google.com; s=arc-20240605;
 b=O0bR0Tu4JO7SmG971ZVs5LcwpCohNgSa4Bj6MEm0x4KPfgCR1XupF9zLIsLT8gM/Wj
 CLwUTx6TnU7ZGB4YFnQIpGsppUuV13qZk5o/+NTXG31qE9khYT6S6ILptLqXV0b8Meol
 ateBs3jOWZ8mC+XdJpEU5WvuvMl7QTMUdVpOG7w/hE9+8RrJGBMVvr6u1+uu5Z4mkcBt
 JpMHdI+yflErWfacbe3vJOUOl57xYyQvBdEJDmrNKaU5EODh2QvqcL1zN5EjjHCHztjY
 4FXSRzjNJ971KwNdu7lVWKKGxtr/6yP1cbqmSGD5ZlH43jZ++UxSVCYh4dnOhZ+KwxIf
 xm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QhMxT5t81umetHP7OJdIfPfi7qUU4Lkh+7YuNP7wTXU=;
 fh=BKK6rCOYrsJzZ2lD8C8FkzFO7cq705axE8f6Mgj2Juw=;
 b=PBGCV5Bks5TmZLTNrZTESDzqDbGYu1odfY1MklsQKjzQoZ1SZg3RVnkVaKFcZnORd9
 MCM+UO1OuJW14SFfGYAG+rgnUaa+2iztQcFygFVl3CJY1NTo1pCLYuLYgyojFA99T8ca
 kLZWK2sjTtBqGDfP0zxR6KcURA+trjFh8XWYcymAoDeL6SFq1e5hlnvqxiawAt+j2ko9
 LL6svDar8snonREuJLUIvhlhT5UM2t4VeQafZURWiuK8MdkZI5Qju0/wJ8Y7zrcU+DTt
 b3AL4DU8p9sB+Ea5ScbUGTER6y/R1TmmzAoMME6WN1v12KWz7ciLAkmfYFehN2y3gdJN
 w0bQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408957; x=1774013757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhMxT5t81umetHP7OJdIfPfi7qUU4Lkh+7YuNP7wTXU=;
 b=DxvOUzxq9SjNx/dKEIARpYy7j4Wlzh8AKM6u6B7/bTgx9nGSXJlctPNmXSekYvy8UJ
 MW3Ssom5RuHaBV2a9wBHOShZ/ZCaiCCLfFnft57zvfFncoPwBGW83s/nlh7mMXKuOMMJ
 NHSf722XTY1vdMa3VKOUyfkNgVdGEAm9dE4CkRAKmBYNQ4Us1/+zTb2uEsFWEzVuZs7o
 KEUED0DfmoRNUdujrFSCdF8sBJHbNl6KoGWB75CfAFCIZLgHb4XYSLGquTJTdTdeXoCJ
 WIDeLjXiQf7x8efKe+Ngm+WGYQkvpucpvnFBI1d4JCYldgNkEsw2STyDVuNlEoRRgDY5
 eJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408957; x=1774013757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QhMxT5t81umetHP7OJdIfPfi7qUU4Lkh+7YuNP7wTXU=;
 b=XHqd6o6LpZDabUCemeeXn+J5o4BzhtQl6rcptKyvgDwujQUAeX9H8xHe5b8Lb6KnjX
 wRIQG3QfsAvnoR7sNh5gEJMlFfPvyEDYjhldB4T2zIoY42wohebYTjTg6yVNfsmTxUTN
 HHRxMxBqmOobBtwMQZqveFzA4IjOnWtKmh/VwGwgrRWdiy7qGh7QNJF+iKV7TwQ84UV1
 +Ls7LxNLep7jqsFMdaMpGd3fdFFS3fDKYaZBEluvAmA7KfU2ZpbmoaRfse/Pu+8KamBX
 MBU8Do7s9ATFaTuCa/ewHzr5lqb0QZ4zr4W81+hf/T0BGOm7BvqSTFwRVA2vpRY0RmRs
 h3jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUITwwc3Qgt86WQkC+kx9eIAeskuFE0n+BAGdgz9TRwoDpMT7lzYWaRh0iXqa3Fq4rJcWwoBCKbs7Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynXsWOmrToHKrNeQpqIPQC31WS4EvUeUnF4ngCM368ZYtj+mRG
 3pDLAN7WDxIo30hPnuVO6v+rW9u22xm5sIav68hSeYp2Nlu6fGmw1yIWTMcclI+Nk0M++a0nP3B
 P38KeWL1AImHBqjyZzOLpAk7V/WVKWWc=
X-Gm-Gg: ATEYQzyR9W0gUPqvV3hzjE7IEvbcQa4U6r30vQtO6b3tmSDfIXQFqcLmQRJGWRCTwPr
 f1DF8ma96K/oDekHymXVEPLDB3iRYy5H0cMrNgAyLrYLJTjvFQEO0gV0RMcrleq7BFk7m/dadBh
 odBL6bT1G08Rhpqfk9yKpPLZF1Uj67ApnELa8uVPDlzPD+EmZx3SWBaojKnc+JV9w89BBJhO6pT
 fX65x9zZDbqFFs42byolRJCU9y34PYXHtElQPJSEojXEG6fMPu4rW8JBYrCXZSSfMDhSQJuZddd
 +gr2DdPrjn+mTW+iRnipUgsryiILrJhM2Xw1G0myxYWN+iSJAFuF3LEIHrNS1/ZzgX3DtQ==
X-Received: by 2002:a05:7022:2391:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-128f3ddb7e9mr736853c88.7.1773408956533; Fri, 13 Mar 2026
 06:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260312-amdgpu-fix-clang-c23-extensions-v1-1-59883120a451@kernel.org>
In-Reply-To: <20260312-amdgpu-fix-clang-c23-extensions-v1-1-59883120a451@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2026 09:35:45 -0400
X-Gm-Features: AaiRm52K3lFtnPCDTCHQ46AGp4JF3gz3oOt-LlB3C1NBMH_-HZtICTmqKkOb1PM
Message-ID: <CADnq5_MbW=jfGJE=jJi4EXacQs37P1d9KV4a8HjNDLwicwZV7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: Add braces to case statements in
 amdgpu_discovery_table_check()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev
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

On Thu, Mar 12, 2026 at 5:54=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> When building with a version of clang that supports the narrower
> '-fms-anonymous-structs' (as opposed to the wider '-fms-extensions')
> along with the associated kernel support (such as in next-20260312 [1]),
> there are warnings (or errors with CONFIG_WERROR=3Dy / W=3De) from the
> switch statement added by commit 47ab777c16c7 ("drm/amdgpu/discovery:
> use common function to check discovery table").
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:560:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     560 |                 struct ip_discovery_header *ihdr =3D
>         |                 ^
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:568:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     568 |                 struct gpu_info_header *ghdr =3D
>         |                 ^
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:576:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     576 |                 struct harvest_info_header *hhdr =3D
>         |                 ^
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:584:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     584 |                 struct vcn_info_header *vhdr =3D
>         |                 ^
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:592:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     592 |                 struct mall_info_header *mhdr =3D
>         |                 ^
>
> If '-fms-extensions' were not present, this would be a hard error in
> older clang versions.
>
> Add braces to the case statements that declare variables to clear up the
> warnings.
>
> Fixes: 47ab777c16c7 ("drm/amdgpu/discovery: use common function to check =
discovery table")
> Link: https://git.kernel.org/next/linux-next/c/0d3fccf68d9873a3c824fb70be=
0dbb2c4642aa90 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index f9f785c5d8ac..4209945af66f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -556,7 +556,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>         checksum =3D le16_to_cpu(info->checksum);
>
>         switch (table_id) {
> -       case IP_DISCOVERY:
> +       case IP_DISCOVERY: {
>                 struct ip_discovery_header *ihdr =3D
>                         (struct ip_discovery_header *)(discovery_bin + of=
fset);
>                 act_val =3D le32_to_cpu(ihdr->signature);
> @@ -564,7 +564,8 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_size =3D le16_to_cpu(ihdr->size);
>                 table_name =3D "data table";
>                 break;
> -       case GC:
> +       }
> +       case GC: {
>                 struct gpu_info_header *ghdr =3D
>                         (struct gpu_info_header *)(discovery_bin + offset=
);
>                 act_val =3D le32_to_cpu(ghdr->table_id);
> @@ -572,7 +573,8 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_size =3D le16_to_cpu(ghdr->size);
>                 table_name =3D "gc table";
>                 break;
> -       case HARVEST_INFO:
> +       }
> +       case HARVEST_INFO: {
>                 struct harvest_info_header *hhdr =3D
>                         (struct harvest_info_header *)(discovery_bin + of=
fset);
>                 act_val =3D le32_to_cpu(hhdr->signature);
> @@ -580,7 +582,8 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_size =3D sizeof(struct harvest_table);
>                 table_name =3D "harvest table";
>                 break;
> -       case VCN_INFO:
> +       }
> +       case VCN_INFO: {
>                 struct vcn_info_header *vhdr =3D
>                         (struct vcn_info_header *)(discovery_bin + offset=
);
>                 act_val =3D le32_to_cpu(vhdr->table_id);
> @@ -588,7 +591,8 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_size =3D le32_to_cpu(vhdr->size_bytes);
>                 table_name =3D "vcn table";
>                 break;
> -       case MALL_INFO:
> +       }
> +       case MALL_INFO: {
>                 struct mall_info_header *mhdr =3D
>                         (struct mall_info_header *)(discovery_bin + offse=
t);
>                 act_val =3D le32_to_cpu(mhdr->table_id);
> @@ -597,6 +601,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_name =3D "mall table";
>                 check_table =3D false;
>                 break;
> +       }
>         default:
>                 dev_err(adev->dev, "invalid ip discovery table id %d spec=
ified\n", table_id);
>                 check_table =3D false;
>
> ---
> base-commit: 7a9419ab42699fd3d4c857ef81ae097d8d8d5899
> change-id: 20260312-amdgpu-fix-clang-c23-extensions-1fb28eee64c2
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
