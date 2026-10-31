Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C3606A31D
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=p5HdaAwh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD98410E028;
	Sat, 31 Oct 2026 13:32:40 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D295110E120
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=content-transfer-encoding:from:mime-version:subject:date:
 message-id:references:cc:in-reply-to:to;
 bh=D7LvaphkkZhIV8sWBjj5XfC38F7LHAzLjBycln5nMTQ=;
 b=p5HdaAwhI5g3hTzWI43jKfRzRQZLNw+Bu1TShoYLkXBKR6ktAymmpBBx
 fVXldhYgKWBQT4XU0y9EvHEQxK8FnDwS5ujelMz1fpD+mBTdk+lwxj9QP
 sjVG660D6P6mrQqgu/7gm8js0Qm2DbM+nqhLd9j+2iMC+QeUbwM5sH/FH E=;
X-CSE-ConnectionGUID: 0JLDJ17zQY60Wwg+oM/8bQ==
X-CSE-MsgGUID: DKW+yWdNSEOI4tCpgy1QHQ==
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,188,1787004000"; d="scan'208";a="303148185"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO smtpclient.apple)
 ([76.123.3.53]) by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 14:32:29 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: align argument with open
 parenthesis
Date: Sat, 31 Oct 2026 09:32:19 -0400
Message-Id: <9445966A-996E-4F2F-9E8F-E71E9C90A6C5@inria.fr>
References: <20261031064705.9513-1-mariasheikh812@gmail.com>
Cc: outreachy@lists.linux.dev, andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Maria Sheikh <mariasheikh812@gmail.com>
In-Reply-To: <20261031064705.9513-1-mariasheikh812@gmail.com>
To: Maria Sheikh <mariasheikh812@gmail.com>
X-Mailer: iPhone Mail (23E261)
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
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_DEVICE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 31 Oct 2026, at 02:47, Maria Sheikh <mariasheikh812@gmail.com> wrote:
>=20
> =EF=BB=BFAlign the continuation line of the write_reg() call with the open=

> parenthesis to fix the checkpatch.pl check "Alignment should match open
> parenthesis".

I believe that this patch had already been proposed by another applicant and=
 rejected. Please check the mailing list archives before sending a patch.

Julia

>=20
> Signed-off-by: Maria Sheikh <mariasheikh812@gmail.com>
> ---
> drivers/staging/fbtft/fb_tinylcd.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb=
_tinylcd.c
> index afa8f1c740c5..d58b1247262b 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>    write_reg(par, 0xE5, 0x00);
>    write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>    write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -               0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +          0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
>    write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>    write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
>    fsleep(250);
> --
> 2.53.0
>=20
>=20

