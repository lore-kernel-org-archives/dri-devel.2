Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E4606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Znf432fT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399DE1129DD;
	Fri, 27 Nov 2026 10:42:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FF01129DF;
 Fri, 27 Nov 2026 10:42:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B35A60E37;
 Fri, 27 Nov 2026 10:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E6F1F00897;
 Fri, 27 Nov 2026 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795776169;
 bh=Y46f3sYwR4Ngu8CaMapA8yyuVt7Iea9tXG5cfMLV8t4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Znf432fTaJMf4trrfKnv7RXa/DIP3+af9BgEtTc7SABjNYh9L4RZG2uEQ2Uc4N87V
 EjT6qkMoQrZFhOYM9ooV6dxNXoF4mXX1a7p9S8TKcWyWOdTg6R5ZdnKQVWzSygZ2dH
 YzmHak+UXdbAG/kwi2kYA9uKv+zT7o8BXs4dmxGWQKQZ8V4DlYdryHyowwEyJd9v2U
 cCvsyumx0IcpDNdtzTv2UnFnbLpjH9fdqW1U3gGqV1pyJy62vDatUpr0CFv0YfguIu
 N0JrQpgq9ELdqkNIsasKyOJR4FaWjQT1X0i02AtHZUFHpv5LUrrDh4XHIfGbIXdxtx
 Oz2TAug1yKr+w==
Message-ID: <sashiko-outbox-237161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/8] dma-buf: dma-fence: Improve dma_fence_timestamp()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261127101812.2706432-6-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
 <20261127101812.2706432-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:42:49 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dma-buf: redundant ktime_get() on signaled fences in
  __dma_fence_unwrap_merge()
--

commit e022bd65ff0c3c874a861f648d1911f74f6646f1
Author: Philipp Stanner <phasta@kernel.org>

dma-buf: dma-fence: Improve dma_fence_timestamp()

This commit changes dma_fence_timestamp() to write the completion
timestamp through an output pointer and return an integer status code,
updating callers across dma-buf and drm/sched.

> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fen=
ce-unwrap.c
> index 120fe0c2a75af..a1e9b1ee2c325 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -136,10 +136,14 @@ struct dma_fence *__dma_fence_unwrap_merge(size_t n=
um_fences,
>  				unsignaled =3D dma_fence_get(tmp);
>  				++count;
>  			} else {
> -				ktime_t t =3D dma_fence_timestamp(tmp);
> -
> -				if (ktime_after(t, timestamp))
> -					timestamp =3D t;
> +				ktime_t fence_ts =3D ktime_get();
> +				/* Leaves fence_ts unchanged if fence is not yet
> +				 * signaled.
> +				 */
> +				dma_fence_timestamp(tmp, &fence_ts);
> +
> +				if (ktime_after(fence_ts, timestamp))
> +					timestamp =3D fence_ts;
>  			}
>  		}
>  	}
> @@ -168,10 +172,14 @@ struct dma_fence *__dma_fence_unwrap_merge(size_t n=
um_fences,
>  			if (!dma_fence_is_signaled(tmp)) {
>  				array[count++] =3D dma_fence_get(tmp);
>  			} else {
> -				ktime_t t =3D dma_fence_timestamp(tmp);
> -
> -				if (ktime_after(t, timestamp))
> -					timestamp =3D t;
> +				ktime_t fence_ts =3D ktime_get();
> +				/* Leaves fence_ts unchanged if fence is not yet
> +				 * signaled.
> +				 */
> +				dma_fence_timestamp(tmp, &fence_ts);
> +
> +				if (ktime_after(fence_ts, timestamp))
> +					timestamp =3D fence_ts;
>  			}
>  		}
>  	}

[Severity: Medium]
Does initializing fence_ts with ktime_get() in both else branches perform
an unnecessary clocksource read for every signaled fence?

Both branches only run after dma_fence_is_signaled(tmp) returns true, so
DMA_FENCE_FLAG_SIGNALED_BIT is already set on tmp->flags and
dma_fence_timestamp(tmp, &fence_ts) will always overwrite fence_ts with
tmp->timestamp.  Before this change, ktime_get() was only called on the
unsignaled fallback path inside dma_fence_timestamp().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101812.2706=
432-2-phasta@kernel.org?part=3D4
