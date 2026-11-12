Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6B606A337
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EfSEqkvm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00BD1120F5;
	Thu, 12 Nov 2026 12:55:59 +0000 (UTC)
Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8B511204E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:50:09 +0000 (UTC)
Received: by mail-oa2-f8.google.com with SMTP id
 586e51a60fabf-4adade2ee63so906793fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:50:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794484208; cv=none;
 d=google.com; s=arc-20260327;
 b=fpCeSKloh5iFvd3Ya7fZcNBtZDVBC+tWY5WpoJORvulihJ/yvpiB0LkLjAC2A3XLQK
 kFDzT5s36aEml+1+H6NdkalsoiCz7FMSLq/YRlusVs8xzDrg+NS5R07DbF/xtT6K56h0
 ITt13oXwUVO1G6CurwrgwQGQwEOaBTaSIWxg4X5XHdHtb2AFhxyDwRKDEqtyWID1e97R
 M+A33viA+c0WvktjwjWSUM2Mt79JZcUfvgO7jwO9wpX0G6tBncXk/kyS5Nab8ev3oP7g
 nQBHLLQgSiRXlPwtB/YUg8MEhxMYue4aEnkXU2iF+OFww0wB+ARPRaKHz4Z2kI6hIxD2
 E1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PW0k9eDKFqfRkgSsOSdWK+l0uZcCJyw9dSbPkXAxN3s=;
 fh=luCwvBZXBksZ+aRDJUhZ1vSvq+9PgMMW2oK0zKVELtk=;
 b=F00xM2LnxL3KTD74uOhL2Z9KBJWzoldkNKS9v51xlsfVbtFaiPRykOcQqM11VwL3fv
 OilCbDUPWc0UY3npaXvlb1cVl3951DTQ/+0lis00+wXi2O9owbvifkkcYg3MyE9y6n3W
 FRw0GG2KoIZ8Elxo4uhlqxadGf1eiFzMx5pHK7uLdhplO/rcOnUaIuYa50t8Y/J8T1h7
 cA2zjupMxhXb3v4QdHbJs9uSvejIrXA9TFRHdpeTEP+aPkveme6v7FW7nG5F7GfJa+W8
 MZxX8mJK4lVK9w8BRz9ov6bDK7gJsjUxuhIPqQQvtGVAymgAXJDh6TsJEzt0cWvB9KxH
 DVWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794484208; x=1795089008; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PW0k9eDKFqfRkgSsOSdWK+l0uZcCJyw9dSbPkXAxN3s=;
 b=EfSEqkvmFFVGPvQH2yD1xM1gTh0qI9umN5kIObNhAPLOsrQUHmsYcql2zsIpvZT4Ug
 gY2heIObXW4fn4wcPA1ygp/z4mj4TNdsKsD9/+6w+xNa9dsqt1Y0ILMjNo1Ed3uESPmA
 9CtXI7bh0iUi1Xw5IFCvYTMoZx48hXfmsFjNJnFLfs/S+jyFLiu5ImN71xF7zh6qFwc/
 TKrDfIqref3qlOb2W/G6cACTlBSJNsRYaxPl0oVsOyo/HwgPLFMuQc+fSW69SxfL76Yv
 592n0Luml8GF+HJ3H7IqAnnLhGdYyTaLyBS51eNsMx9kFm6oDWxmyJ0Dl824TIJcjLdH
 3aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794484208; x=1795089008;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PW0k9eDKFqfRkgSsOSdWK+l0uZcCJyw9dSbPkXAxN3s=;
 b=vEBVO4QKlX9Wc0rt9yEFjr4pdfY0xZ7hn1Sr36mh8QR4CKL6Sb8KgDgkPc1a+Svu1N
 L8Ay72xifU86aIrBKEvRXEer3qVE8mahXl8cLuX5ProdzX/fgn9YE9of2/UUh8gt/X9F
 RrAcZNzuv2XHTbWBfjOr2PUzTXJaHCE2cjvOpKFJOaCejXQc5r5Bfm6v1W9nIi+BQ4te
 Z+8saw2FmajvPOUaeJ4XB6WkqKH0c5i4btvHzm6rmD/Ks7VHrt7/ZSuE6Z5ynOErgky6
 cd+R0cPvtx9tPhjDEzve0tFf0+GVnsrkvSCAl5/IVtavGFMFzYA/P9Zj3hX8HC0Sc9Lt
 DU0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGgHBMp33pL35qQ1jaYAEbu/qCnRREofiPCHYlOLNa/Vw0t7GT7SLPA5wikllnHOgtiTnfxlGNUpNI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9JACQDHy/nmXLv0Vam1Ga+VTSmz+EQvFBOgUyGVPOnur+DkvDY
 osLHLj4HDLGfsyXal7+wDV8xZWQOGmfQEHucDnrRzOgiFcC5+l1Pf6zNqRGI8gPxQSdsUL6FlBy
 mNM6uMLcHjByN0xym4fjD7fB6OTwsC2E=
X-Gm-Gg: AYBFou1RzGQloufrq9YjAoqrxb9LhVLpq8SltJCWFAUgwejLsNxYit85adCyFqlBty7
 /FXtzDE3QG4uhj1Kgl6W5xpXG6jrPHaC3EX8bgtXULMHHNG3mKmytuzlSsRWuTh7NnheklVxKKJ
 6XtexPkU/B8+U2KHh5Qtbo14uKGR8ajv6Cvm5+Kv0DTjrX4+SR7MWcj9dN1X89SJr7YI0nTuUIJ
 5LRpctFQQtsIBluOlHd71bQLz9t3XaFoCKXEGbXAOwaoTqbPX2pzHso3I9uE9V2L7ttzqZsdi8Q
 wyuhXcQddn2ekMECavo/DEDlfCHRXA3yJYE0kwIhpyR7bikMTdf4JNu2JUwTvA0DVZQ0b9M7WtY
 IijXvIg7RCNXJfHASC09PJ3WVtt49gk9U5LAtZhXE+X6oFqwwd0ct1NJ4YhG78HlnMidWyLGE36
 v2VtuTMx55/2W7XMK3xcoz1YHrPUnLTBHzMUb/QmFABif+PbHS6BwNyOANcDjEkLFNKgaUSAKU5
 Jg=
X-Received: by 2002:a05:6808:250d:b0:539:dfe8:9960 with SMTP id
 5614622812f47-56b97d2052cmr4847599b6e.56.1794484208172; Thu, 12 Nov 2026
 03:50:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
In-Reply-To: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 12 Nov 2026 03:49:56 -0800
X-Gm-Features: AclHuK99jfCHnUnNfvAVzgTNdsDa1C0fS3B-XZ44SaSca81MyWnGtLd2YK_PCFw
Message-ID: <CAGEkeHdBri8mbX9zctroRZeoMb=u6mYSn4xAum1x_UkyUZKRdg@mail.gmail.com>
Subject: Re: [PATCH v4] staging: fbtft: remove unused fbtft_init_dbg()
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, error27@gmail.com, 
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 8:39 AM himanshu bakshi
<himanshu.bakshi478@gmail.com> wrote:
> - Verified that fbtft_init_dbg() has no call sites in the kernel tree.

Reviewed-by: Hungyu Lin <dennylin0707@gmail.com>
