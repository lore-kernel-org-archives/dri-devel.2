Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04971606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HZ1FqFF5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794AD10F313;
	Tue, 27 Oct 2026 09:31:59 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEA310E1C2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:25:00 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-706113e92f9so1644722eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793006699; cv=none;
 d=google.com; s=arc-20260327;
 b=ffpSgMmZHg4HZ+bHp3BSF5kaYu8/Qk4FAwIUypD1HMXvQkpdD5ThVvA1JDC1X9VOfD
 4ZjBw9FUbuRGUPjAhhyE63UGv5o46QOG7FxqRRsIFEarXw5l5drxhvfyJxrJNCgfIhrc
 P4rxZDOxfmR3gPxh+MwSWxBHuNwNPZvIvRF6iOD+dYjFMEh0i9Fy+CYLASh8tEyOSCm9
 JakqA67roB9WGF0T/JDNTy77gwX5RPj9bQznSykDd1F/I8dcOo6B1tBEUln+Kc1knFC7
 zazWAXCc0Rcx3TmTRrHitolBPcphfCAY/PfjUMsDGFD9hStIxoPMclITdeDTWAwteyB/
 /j1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iH7cQ2YJ8diUnJspTVTMz6UMogpLRPO/6WHl7KC9WGw=;
 fh=bzIf7setWSL/8uSR5TPwqG+Oz9puht8CkxQfwNT6hcM=;
 b=nobW/46pBUGqluWJCKZ6X8PJC5qEUZfzG9xgK3L6A27Yb7whizJBRxLTKgyMPeaopr
 xvIjMIyDUiwI6zolKlWiewpLKXd4kogEMps1v0hRW5peXgLR++8Zt0jHnljDMbMXW5gv
 ZEcDgmXeBiup3N6CREhv/DwmRvPRCstR9aEgCStH+snFqc68KI3Tj/pvR6KTJhUK2bKf
 Ile6qrRY/rTG13bKCak9k3VNOVK5ANI3aZxDO4lTQuMf1en5/eoz4eGhE58p9TaRPMPD
 Ls30SABIGkPyx7IBVctATLlO1SrOEJdrjiqe1tLuw1Uv3vZeQhIq/+CtKRBIu8R/gdmU
 lTzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793006699; x=1793611499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iH7cQ2YJ8diUnJspTVTMz6UMogpLRPO/6WHl7KC9WGw=;
 b=HZ1FqFF5LYACgKW3OyrE62jDUHlZ5mzxKGNjv/JfTPpzqiSqUHGfTRQ5h1x2JELqEn
 JjIH/A2hdT8QxL73hp8anqQlQOXvi+E/X7pYxchn5blRjn/Cq+Ui473b2tHhLQAQzyI5
 UoHHkICqui4fd/48D9d2Al1YPftFjZGbZNT3caea7mBHhj3Wqauw288VTYECicaDQDFj
 RPpy6C8rxVgzEgzmtsqFkXv+vhMyrNCSqbjQykKGzza9GX9U2xgD2amQ6zlSJST3F7Au
 AfkdIw2s8MViSIUe3idpngNSEeTW+bhRD4vczxSRp7YV04hk5ohUKbDh+/OVBGoFuCFr
 hsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006699; x=1793611499;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iH7cQ2YJ8diUnJspTVTMz6UMogpLRPO/6WHl7KC9WGw=;
 b=mfwCeRUiGRatCE1n9sSboJp3F+9iZgjF8QUkKSn2A5hg7XcdYckeBXogwAYZE9qks1
 F5OB9IabbnmTCyGsFoHdfL/94KEIuju0BZb+H1/y038sN5/xdd9PLMIkZwT7+hrlO4sZ
 aPtFwIj6L+okpjT5FobUrDELdDi3YmWqqHLo3pqNfhJB6DbTfnCGAH6Pt3Ewy6nrQiIg
 Z8z3wCjQ+y9PK+JldU8mU25/cRILJuL2GVdfOiv9shGik3Xp47GYfdc5dkR5YDD8nP+T
 SdJKm10hNkXFMDLhLZNk6S4PdU7hEHO5gfiyb4Q9Zfka7QmtLdO8BI+A8q5b/PKKDQxp
 eQvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByZAbnjN3DRU/qaIOwR5YBkXzeQuxBAmJTPSgtMqeh8GRazD3p2Bh2wn/ZxuwVc2AQEBDkUMZLE8G4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL99fjBW5LB+r0dmyiuCv8OHkm786isoyaVvR9XWbsSXN9yHdXn
 8Dq/N1Rw+0fO+Jmp8e5X1SjPpkZ8l1TkrMLxnM1xtxHUC5f/zdo5jjezdYjLszgfTvGq6w2Be7N
 /Msi4ipj+49qB5B46Y/qqpTCNZpyOJeU=
X-Gm-Gg: AYBFou0XkoMBeSVteRqDeIijP6vY6M4hHYiZi6/oA+NeQrYEwtGI8qJRV/LU7bJ1Y0I
 Dny/jvo9lVCbCZtqpVgpx0lecJgJjBbwkwoOLAOR6gqJzb41QdPuW5pD/lUJ6JFHZx4jKPQwCd/
 zBzvKNpZ7+Ddco46hU8rMirw9sBm2I39noggTVIb24HD+EK7pBm+lHMGRaOJNt7GbQMFETWaX/B
 RCbs81Sgl/JqUCjVOhgb61+eXppMGc7ZQgSYNV62AGpi0rvHgxCicQzrc+vQTtz/8NB0yQicvrn
 oqtTxS3+zKDWvwi92RHOJ/UFg6QoRfW2lYJCPbOaVo29Ig4GRnpSvBW6vvtMKgONmFEqa/Pl8nD
 lcMHCgEGQCEuDfIBun2AxU2jMf+IZrmCxCtaZbNBVDVMap7LG7edNRv3a+eyx3hZUQOBcEqI=
X-Received: by 2002:a05:6820:6fc7:b0:704:d59f:2a2f with SMTP id
 006d021491bc7-70ba1004bfdmr2405887eaf.86.1793006699407; Mon, 26 Oct 2026
 02:24:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
 <at8UoLDzrO9ypMeR@stanley.mountain>
In-Reply-To: <at8UoLDzrO9ypMeR@stanley.mountain>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 14:54:47 +0530
X-Gm-Features: AclHuK9P_GrPtY5hmmGoqr94XfczFIROopEnJs5pAYehQGelpuKw7iWG8V9_J8c
Message-ID: <CAGLmz9JD3UQ+4cAV4nigm8U4Jtb47=oBGi06miQWuetenszoYw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com, 
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:59 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 2:21=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
> This commit message is sort of acceptable but a better commit message
> would be:
>
> "The fbtft_init_dbg() macro is not used, so delete it."
>
> 1. () after the macro name to show it works as a function.
> 2. We care about the whole kernel not just drivers/staging/fbtft.
> 3. No need to discuss dev_dbg().  That is unrelated.
> 4. No need to discuss compiling the driver since that is assumed.
>
> Otherwise it looks fine.
>
> Reviewed-by: Dan Carpenter <error27@gmail.com>
>
> regards,
> dan carpenter

Hi Dan,

Thank you so much for the review. I cannot find any call site for this
macro in the overall kernel anywhere and hence it is safe to remove
it.  I have sent over the PATCH v2 with all the changes that you
suggested and will be glad if you take a look at it.

Thanks and regards,
Himanshu Bakshi
