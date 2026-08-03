Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C7DC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0822310E5F4;
	Mon,  3 Aug 2026 17:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eOr794kI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1099D10E5F4
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:10:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DB2760A5D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90C31F000E9
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785777036;
 bh=doqYgb+n1+MzYaFBkm0Z2OZtZJMR4/CPw3oK9XHvRn8=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=eOr794kIfY7W46iYnnLxRi118Vzcbg5sdZLUGw8OGSnDbs1p7MZ2Ldhbj3haxzko/
 yzTY9dPWS0RMMlQV4lxj2OoVbIcTJvN/othQoHnVe801TzUUo0JFOtu+/iHTGpWMi/
 Rzx2A08ukI8cx1n5taUtGS9EEtHLSA5yuq7o7fJhmtPAWersXusVQeoVbb4BWl0HIg
 juRcwHPOdd5zwWfjrlnnqfGmr+B6M9jn+J5H0SNOyaSF4VgFoaspl5QchpzZNumLMU
 LU+jaoyNSEpdss+sJdFx50CC8qA/8+w7mQN2HkcxXGrDoiVfJ5B96XGq1yddYAYVhZ
 4qmYRo5wtKnzA==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39c7ce122c7so32046231fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 10:10:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrtrZeuCy0nkV3u1evyUmF/2/LT8iosb/KesWQSTMz5Hb3a+IpXJ0iDGQKH9k7Nb1Qif8OocYQlR7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRXrCiAd0Hlt1YxAoAS5BHXLTe0ffjwCU0Bx4pTnkHTK7GLneg
 cgvONoem5IfeYwvMkzIC5JFRlM7CqKJhnJO7hPxv5kU97ALcqaxRMAzMxyWKF5xr76yKpyA4m8O
 A5f+5vhWHV6c58mfwZWBxkLFS2ZNxlVk=
X-Received: by 2002:a05:651c:a331:b0:39c:7294:edd5 with SMTP id
 38308e7fff4ca-39f86149fbcmr20474521fa.16.1785777035316; Mon, 03 Aug 2026
 10:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <759c74e3a22b97ca066ef7910ca4b91b852011e6.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <759c74e3a22b97ca066ef7910ca4b91b852011e6.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 01:10:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65TCJTNNJCNHOrD5crXDHaB5xHk38OoU8cJYneLoK6WzQ@mail.gmail.com>
X-Gm-Features: AUfX_mwpcFy3zfeI7QO6fCWDy-K5pNTC3w93qmXynM_39UegKq3dSKNgaBP3zYY
Message-ID: <CAGb2v65TCJTNNJCNHOrD5crXDHaB5xHk38OoU8cJYneLoK6WzQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] drm/sun4i: Drop node references while building
 component list
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Two references are leaked every time the display pipeline is walked:
> the output port node in sun4i_drv_traverse_endpoints(), which was never
> released since the driver was introduced, and each node taken out of
> the endpoint fifo in sun4i_drv_probe(), which stopped being released
> when the fifo was introduced. The latter is still safe to drop right
> after processing, since drm_of_component_match_add() takes its own
> reference.
>
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
> Fixes: 8b11aaface2b ("drm/sun4i: Implement endpoint parsing using kfifo")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/su=
n4i_drv.c
> index 8a409eee1dca..e9baca360160 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -289,6 +289,8 @@ static void sun4i_drv_traverse_endpoints(struct endpo=
int_list *list,
>
>                 kfifo_put(&list->fifo, remote);
>         }
> +
> +       of_node_put(port);
>  }
>
>  static int sun4i_drv_add_endpoints(struct device *dev,
> @@ -394,6 +396,7 @@ static int sun4i_drv_probe(struct platform_device *pd=
ev)
>                 /* process this endpoint */
>                 ret =3D sun4i_drv_add_endpoints(&pdev->dev, &list, &match=
,
>                                               endpoint);
> +               of_node_put(endpoint);
>
>                 /* sun4i_drv_add_endpoints can fail to allocate memory */
>                 if (ret < 0)
> --
> 2.43.0
>
