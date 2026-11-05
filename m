Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17846606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiJc5Em3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A55710E237;
	Thu,  5 Nov 2026 15:49:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7082310E237;
 Thu,  5 Nov 2026 15:49:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D5FE60A4A;
 Thu,  5 Nov 2026 15:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB031F00A15;
 Thu,  5 Nov 2026 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793893783;
 bh=DLzWNfK9RKvnmW24+lVGI8EuYQIdR3Bgd8j0+yOwEcw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QiJc5Em3c7GCu5EyO9szDX2CVKVqlJ9saozEYWsd8nUds8wGG46BPTCzYrnIeINN+
 Lfo6Mjmk2IsmRbrBuokBB0XzeOizhUljd6D5b2CgmoHmtxFGfXe+mp4IkM5UEvXtA3
 5PpvhFaS8BDCVmsTwQHlT+akNBjctzi6mq2r+aEomCbo10COatn91eXtXYCBT9mfbB
 BzCE+VK8dVl1XjU2zcpO43xecPh3PkLLaEqooTBo5d5XK5XQsVpc4K3erbkIjr1jxu
 4MIoQWJhVqLDcDVDukJZe1+pEsUoRcKbTO1+0KBAZzVWLlMVWbKZm/QP0N0bGWAodK
 MqzLB5ESo7wFg==
Message-ID: <sashiko-outbox-199352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm/xe/pcode: Fix pcode_try_request polling delays
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102174608.1279278-2-alan.previn.teres.alexis@intel.com>
References: <20261102174608.1279278-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:49:42 +0000
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
- [High] drm/xe/pcode: syntax error in pcode_try_request() due to misplaced=
 parenthesis
--

commit 3c7a166635d4e14258beaf50fb0fab91cf40aa3f
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/pcode: Fix pcode_try_request polling delays

This commit caps the exponential backoff delay in pcode_try_request() to 10=
0ms
and clamps the wait duration to the maximum allowed udelay value when polli=
ng
in atomic context.

> diff --git a/drivers/gpu/drm/xe/xe_pcode.c b/drivers/gpu/drm/xe/xe_pcode.c
> index 266deecbb100a..d2ed5edf003e3 100644
> --- a/drivers/gpu/drm/xe/xe_pcode.c
> +++ b/drivers/gpu/drm/xe/xe_pcode.c
> @@ -146,6 +146,7 @@ int xe_pcode_read(struct xe_tile *tile, u32 mbox, u32=
 *val0, u32 *val1)
>  	return err;
>  }
> =20
> +#define __XE_PCODE_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
>  static int pcode_try_request(struct xe_tile *tile, u32 mbox,
>  			     u32 request, u32 reply_mask, u32 reply,
>  			     int *status, bool atomic, int timeout_us, bool locked)
> @@ -164,11 +165,14 @@ static int pcode_try_request(struct xe_tile *tile, =
u32 mbox,
>  		if ((*status =3D=3D 0) && ((request & reply_mask) =3D=3D reply))
>  			return 0;
> =20
> -		if (atomic)
> -			udelay(wait);
> -		else
> +		wait =3D min_t(int, wait << 1, __XE_PCODE_WAIT_MAX_BACKOFF_100MS);
> +		if (atomic) {
> +			/* don't overflow udelay */
> +			wait =3D min_t(int, wait, (MAX_UDELAY_MS * 1000);
> +			udelay(wait));

[Severity: High]
Does this break compilation of drivers/gpu/drm/xe/xe_pcode.c? In the atomic
branch of pcode_try_request(), the closing parenthesis for min_t() is missi=
ng
before the semicolon and appears after udelay(wait) instead:

			wait =3D min_t(int, wait, (MAX_UDELAY_MS * 1000));
			udelay(wait);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174608.1279=
278-2-alan.previn.teres.alexis@intel.com?part=3D1
