Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DDE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JRLZIvFx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5467610E7FF;
	Mon, 23 Nov 2026 15:56:53 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1F810E7FF
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:56:47 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-6f42722a10cso152139eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:56:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795449406; cv=none;
 d=google.com; s=arc-20260327;
 b=BVdA+i6vzmmH6loli24FPsvG/2BVoadgpRI0opg9SX6+/H+X9vkpclKbhgLPLSdsk7
 rlYxAHDyo8jpPN7GlK1bkCvDnxnMfZn/QUeEmmJ09U9RT5WYR5c+rjmYwdBOFdj47G45
 gWQe1+8ZFwV94tKYYAAemYl9c6Ndw0Y21oC+gOIgHBiJpnZbHHTZ7/+GY8bavEbSk0Fs
 I25cD6NVg8wB55wV/SBBvO4chdcALfvFEEn3zSMwU2vvx1UtzCbQULfH6EIeXDPDCwhu
 y0qgvvse4A3fBuO6wrloyIwFwKG21HfVOpnpuSvL8JLq7QyhGFLPvNfS22OFoQANvkqo
 1QtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pjc8deyObBxLCPa5L0oFhozqeUe19BHaOQG0r1a261I=;
 fh=6wo3khmwDd6RGnhHjM3a4LTzoFKJ+gImFqEYYVMmZe4=;
 b=cSmSqwQXHB5wUCKsS0LKS7qxMQI/45nYtyOxfr+xU0j1X+n2Iy0sSjMA5ZUFK7y9wk
 OExuKXhl5wS+a8zUlpBwgYMU2fyfsStfo86sRAUc/3L49LXu4c9m+K5HX1SVWuBJo/2r
 p6ZHLGZg4PCFdQE7ftFJdBJEWLSYEUhPfixzPguSK0GkTLeqqKal4Rz4Nrbrsf1aMCct
 Sx0BHcO2HhouicV8fjaOEnM/BlPpqKMomnf1tW97I6QVy3If7uKXk9zvihHjYVf6F4MP
 1jc0kG5gxDTTpZ6KU4fNXhy9uKbgecUvks4VN1dfFNuvEqovUi57RNYDJqVONenBtu3T
 +Iug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795449406; x=1796054206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pjc8deyObBxLCPa5L0oFhozqeUe19BHaOQG0r1a261I=;
 b=JRLZIvFx5ZDDNMa8T4y0nTBravZvJS777lJkUdWiS+mMvVgNxTfRWb+4nuJQUR6wcd
 D7WZ7H3ZU90QCv/+nCsaGx+uVt6voR/OIDPAJKZxZPiEA8IV3iSqo1Mz1MXr4o0I4b7i
 vkXCjL71Ku8YVUmpH6IT3nXRpFQM9Ei7kVb7REQbQ0tgqx3Flq2fZum/N57+JPJVlPW4
 exfByiABnj5kk+8wLLxxTVjmoZNS8w/UppJGzRopAMkzJAVNOJM9u4r//TEDar9upT6T
 a6eTFlsIcbNzU1c2QAXj+ePB9JWNP5um7G7I3KKR+jLvPfS5xq08YdIamSVmTpnZIOAd
 UCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795449406; x=1796054206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjc8deyObBxLCPa5L0oFhozqeUe19BHaOQG0r1a261I=;
 b=CRxQ3yzhDb2ZggBPS32QnpG2SX1HGEPR3Zl3HiHkjOCt0NM277FrfJHzNdW6LGIx75
 p/ifo+IXqfemGA/e4w+cUOHVm0E0Gl0izBe5Mw0bvymGIsx23VbfWMNpRYwn4mZVwNoy
 4ab7W74ZaRMyNbjXRs2R1s9RO3AXswffrnTVeGMipapVYpsQZKXxD52hRY78kFXLgyeL
 G1+goGUia5WIBVFEI3eOu7W00j7uOg8DxuNJQBFMn9tL/y4Zm8XvSvYr0R0oeV95QMd9
 AiKbsjMUrkNdFwBjfFwT+5pmxeChV9UJq+VYe/ugQQlAMUvdxV8iyGpWRk8Rznh2rbTM
 wLfw==
X-Forwarded-Encrypted: i=1;
 AL+hErEPTw0ZXcnJyAxH3zMRGK2tjGkC4MM5m//23yZjzthV7jfSXrHzw4MaTGBxEdhoRDiTX1j9ODlP8Sc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90fWSOX141s+Ze9TsEa6Pg+qeSYlIjjWH0yDmsVJzfdXC6uTSp
 OdkBudy81IqA/rU/ii+UNZT2fpbAE0Vi8tv00pM3GU0twjG7EkS1CTdhXwzqYpv6W9PZJRHxa4Z
 JnAUi5OWrL0szIaDYkBWyUXjTWt1S3zI=
X-Gm-Gg: AZFdTZfp5V1bFgm0HFinmTkM6VxswdPKIvKgpwsXssuDPmbomt/XwlspVcJ0Lig0KgX
 okFSDL5NI1CjQTPC8f/GzdRfHVYa9ID0FrKky/EQC0aHEhPMbN03Z9WHuDBweY1SxW4NGAEaT53
 dlXDtSYmDBJZs31vJNrF3ZE1MghvdpxfFkqzgtl9RtruXcxcid0MRm2Q6jrrCRWsZsTcnMrkF8f
 uXOvyDwS90frfqJ7uhVRIA9Mtpz4pOhEux+pXKBrEIwMTLAidTC2ynorgEUpASPTIEfIjerWXFA
 9mklUkxx6BhJzjqO4zHJjnx6DVrnGeOq3ldeyvRKRjpVrlyVyMKU27e75JPChOK1djZgoq+nnv9
 6VNBTJjqhfqmaCM2RLwI1orLQtasuoGFgzoKAUJsFAgfS8QbIE0lKr5SOxd2/Z+Nfl/KrGk26Xq
 HOsMKaGgyydodBz7EJ38+xAawW2NpcVp9X3/hAKg9PVZp7m/4EaafQGeKlu9Y=
X-Received: by 2002:a05:6820:a781:20b0:71a:ed80:f0 with SMTP id
 006d021491bc7-71b393836f1mr10039115eaf.2.1795449406296; Mon, 23 Nov 2026
 07:56:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121030250.1674303-1-takano32@gmail.com>
In-Reply-To: <20261121030250.1674303-1-takano32@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Nov 2026 10:56:34 -0500
X-Gm-Features: Aa3M54oXP51OS3sSNkcVOZ1PcWIzjST9HtGcC70qmiIvedZGUxdnp7X_Hgql6bI
Message-ID: <CADnq5_Mhgk-bMxU9dB1gf5zfn56szS0eLC17dj5gWzY1yWdrnw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Document parse_psp_v1_bin_descriptor
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Candice Li <candice.li@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

reviewed and applied.

Thanks!

On Sun, Nov 22, 2026 at 12:31=E2=80=AFPM TAKANO Mitsuhiro <takano32@gmail.c=
om> wrote:
>
> The kernel-doc comment of parse_psp_v1_bin_descriptor says what the
> function does but names neither of its two parameters and does not
> describe its return value, so kernel-doc reports:
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:4440 function parameter 'desc' =
not described in 'parse_psp_v1_bin_descriptor'
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:4440 function parameter 'hdr' n=
ot described in 'parse_psp_v1_bin_descriptor'
>
> Describe both parameters and the return value.  kernel-doc prints each of
> these warnings twice, so the file goes from four warning lines to none, a=
nd
> from six to none with -Wall.
>
> Written with Hermes Agent, an LLM assistant; the author reviewed it and r=
an
> kernel-doc on the file with and without the change.
>
> Fixes: 581ada8f9bf3 ("drm/amdgpu: factor PSP v1.0 firmware bin descriptor=
 parsing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608210800.S15sl61g-lkp@i=
ntel.com/
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 82a2684dbd2e..3fd93cb1e634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4435,6 +4435,9 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>  /**
>   * parse_psp_v1_bin_descriptor - Populate struct psp_bin_desc from a
>   * v1.0 PSP firmware header (standalone images such as ASD or TOC).
> + * @desc: the descriptor to populate
> + * @hdr: the firmware header to read
> + * Return: 0 on success, -EINVAL if either argument is NULL.
>   */
>  static int parse_psp_v1_bin_descriptor(struct psp_bin_desc *desc,
>                                         const struct psp_firmware_header_=
v1_0 *hdr)
>
> base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
> --
> 2.53.0
>
