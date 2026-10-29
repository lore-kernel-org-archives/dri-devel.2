Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCA606A329
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LY3DeJlJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F4AE10E085;
	Thu, 29 Oct 2026 11:00:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8518A10E085
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 11:00:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9ECC66025A;
 Thu, 29 Oct 2026 11:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E75B1F01829;
 Thu, 29 Oct 2026 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793271605;
 bh=2sWnbEOpGW5EkEfIlQl12AudwxLX2N1PAwGgGSIBR1U=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=LY3DeJlJaCUnbjmaFP55JTbodyYj3eWFIuOZIew5j/IIRjrwR7yi/k6e886nenk4x
 +cIXNswcQMl1ifxYxskNaC5RTQukO2cxuv8Lx7/6wcZeQF2bQGrbT4EXPbGRRgJbTV
 +zsoagqXeqjWX0Lhl3X4iyCfdUd00VSCSlvSOL9l+7VyzEcVcnkw7JkdE1+F7i4mam
 XEEU+uS/GaYkTYbIFH7BWjBB/craBibejpilOWFicUf1Yv7x4w0H4rVhcTHHuEC8tE
 e0B0QIMNzQApXc2aBYn6MHem+FxTOjPTz4yayJiPjTYn4agRanclRJroJJjC85MVy6
 Z10pSzlppLTiA==
Message-ID: <sashiko-outbox-189160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gud: avoid divide error in gud_stats_debugfs
To: "YuanZhe Liu" <25031212351@stu.xidian.edu.cn>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261029080816.16800-1-25031212351@stu.xidian.edu.cn>
References: <20261029080816.16800-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 11:00:04 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/gud: missing READ_ONCE() on stats_actual_length in gud_stats_d=
ebugfs()
--

commit c9d9a9652db7619eedb8feff2da3862c3012fe31
Author: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

drm/gud: avoid divide error in gud_stats_debugfs

This commit copies gdrm->stats_actual_length into a local variable in
gud_stats_debugfs() and skips the compression ratio division when it is zero
to avoid a divide-by-zero error before the first framebuffer flush or during
a concurrent counter wrap-around reset in gud_flush_rect().

> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
> index 680447f426f37..cec5d64e152bb 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -329,10 +329,17 @@ static int gud_stats_debugfs(struct seq_file *m, vo=
id *data)
>  	seq_puts(m, "\n");
> =20
>  	if (gdrm->compression) {
> +		u64 actual_length =3D gdrm->stats_actual_length;
>  		u64 remainder;
> -		u64 ratio =3D div64_u64_rem(gdrm->stats_length, gdrm->stats_actual_len=
gth,
> -					  &remainder);
> -		u64 ratio_frac =3D div64_u64(remainder * 10, gdrm->stats_actual_length=
);
> +		u64 ratio, ratio_frac;
> +
> +		if (!actual_length) {
> +			seq_puts(m, "Compression ratio: n/a\n");
> +			return 0;
> +		}
> +
> +		ratio =3D div64_u64_rem(gdrm->stats_length, actual_length, &remainder);
> +		ratio_frac =3D div64_u64(remainder * 10, actual_length);

[Severity: High]
Can the compiler reload gdrm->stats_actual_length from memory after the zero
check?

Neither gud_stats_debugfs() nor gud_flush_damage() -> gud_flush_rect() hold=
s a
shared lock when accessing gdrm->stats_actual_length:

drivers/gpu/drm/gud/gud_pipe.c:gud_flush_rect() {
	...
	gdrm->stats_length +=3D len;
	/* Did it wrap around? */
	if (gdrm->stats_length <=3D len && gdrm->stats_actual_length) {
		gdrm->stats_length =3D len;
		gdrm->stats_actual_length =3D 0;
	}
	gdrm->stats_actual_length +=3D trlen;
	...
}

Because actual_length is loaded in gud_stats_debugfs() via a plain C
assignment without READ_ONCE(), the compiler is permitted to reload
gdrm->stats_actual_length from memory when passing actual_length to
div64_u64_rem() or div64_u64(). If gud_flush_rect() concurrently resets
gdrm->stats_actual_length to 0, could the zero check observe a non-zero val=
ue
while the subsequent division reloads 0 and still triggers a divide error?

Should gud_stats_debugfs() use READ_ONCE(gdrm->stats_actual_length) (or
synchronize the stats counters between gud_flush_rect() and
gud_stats_debugfs())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029080816.1680=
0-1-25031212351@stu.xidian.edu.cn?part=3D1
