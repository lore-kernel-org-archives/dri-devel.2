Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1B60A6F65
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+/tZrXM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B9A112670;
	Fri, 13 Nov 2026 15:55:55 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01B2112680
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:55:49 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8b77e464208so212360b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:55:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794585349; cv=none;
 d=google.com; s=arc-20260327;
 b=d8pHEl3P+VoWUeY69AnwDC2kQn6GqLmxT49vAj+fuJgX1hDm0SG+UcSB31qB60d9w7
 /WlpcmX2uibQzO07N22DAhvuhJVZthGusbEt9MCunb7JCDy8a4kNFizdXvHWoQKgd9d2
 v8OIGLUGNcmraCK5hZVB+bzJHV5wPDN26yZUDxynQFe4kQXWwvH4VZLOWJUw9mrQLEyU
 9Ry9Hfqlsym2eKgnrB5Fn5SQbF5qaI5kagvGztt0zBheoTLSejvytdrxusZ8k2N6msIE
 COMDWrnq4VpBMpoAPnShMgk7oWqGjERYM7jiNzzMlLC1+jOnuum519yB7p2W4yxDLZvu
 U6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tseegjSp6X0Lc7/iO0iE1xKwVimLPp7AhAKLSYvYRTI=;
 fh=0jlWPnDbrisBN/BXAp7WeKjyrdXRzsAv2yUP2B4PdVY=;
 b=V29dapNvyTs76vtopiCfeYa9dGGi9JxwX7mE/Y/oc3ZMwZGl9hFn6TZQyjXtXhr2db
 oMzU6DGJiY/12V0AjCrrcUHiobnKDx+TvHdAOXpsy+ioGqvV1zg5ptlnnyboTHGgBGjU
 VwKKD07Lr/1qyC6/E+pTiGTE0mmAHin//6TrVhqNhInahkPpRH8f0QoPzpl/aAfrQ3r8
 jCMzapMRY925aepGmWZWLVU2hhbrzlWIObnq0ETAnh0a0phRr6B6W9rnzOtHI9maeocd
 ISVejiTAIIzUo1rrkGBnMQKDh9m7Sqt2eSDZ17yS55wmHFEu6d6G2cyoSgRWhGzzz/Ge
 jn5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794585349; x=1795190149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tseegjSp6X0Lc7/iO0iE1xKwVimLPp7AhAKLSYvYRTI=;
 b=x+/tZrXMOj+zMbdmy3QXDTwoEQ8VebawUdHtO1gD8xFXVzEwKtx30scawrPn8+lggv
 djJcpJ7imERIKD8WUjnRoKogBP0hgro2tbeRj93rlemk6QNqGlQGRZAEjet5SafpyyAq
 7ij90QRT8L1+RscRFGNjLIT/qKkeBGOylKMNOZcbLlKp89hhX+RMO+9AYBWxJVVU3MIA
 +sVzdLRMsktd4V1JMgyClcd62NOPTGy9VstrxyDU/JRdXWRTU86DyfrzwdjZivxv58xO
 VS4LWGRGNHiA0HNY/5cycHORAMni2iBQ0xubqUTgGLlo0leSfWFRi3XntSLZ3+Y0Sq8D
 NqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794585349; x=1795190149;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tseegjSp6X0Lc7/iO0iE1xKwVimLPp7AhAKLSYvYRTI=;
 b=Z5r/VxXYCvrhZ6POdXmH9SmafDEpuzLvJ12rkf8nfU6gVJrRPoroN7ccP+tyVooyo7
 w7BKbdaMdj+0BcqexYIqKnoH9Mm5erTe/9We0pndAaogmFrzse+N1vnvg8sTUkGIPRcB
 rg5LlbNZxaLtEH/tHsdOMTMlXDQEbzShdgOBdHF/e+qn7/DG0e9ykZ0Da5ghHQTRoJ3/
 bs4wX0PrLmGYcyMn/aZzLobhL596xzYJFbKSHEeytubwOYZYeXWFFx1TM0o5PysIzKXb
 cWeEu/9Mea4JaKhsmF19S42/L0+BLEzG0wL5g+95+2Cuf4r6rKlQxj3imzYOKz9u3iJc
 hN+g==
X-Gm-Message-State: APuU4Z8OYwfw1loh8jiUTUAyFYjBbh4Txzr7ZxDMnHYayXMJFi5wch7Q
 mJTyHYlvl2/mX3UEO8N3MrNyqOFjG2OO1T+fuZYssrp8IgKoYabeMQyWlrxmUQ9og3D/RgFpJbw
 yq+PVFVdGjUcPReEKUHfi9Ctk9W3/a5w=
X-Gm-Gg: AYBFou21/+/eltRu8X/unkv6UU0l027ZohNDGS8EFXbp9YyvsXF4fLBQ8AwMCtYmF7u
 NJiwXA6JVOXlPzYJCxiqq6zNP9UiF4jcahW2Yw+35pL+XDmLu4i2a8uOswnxKbBlwPYxRj+Xiz1
 NAXCi12N3GvCsDx49pgotu/O2g3N2V1B7jZnEu1sFVIlyzg3oUntcT4i14TE+tJz/p9dlzbEcTv
 TEsx+tPAlKqfofyXDPpkb5vIruiJYWq2A0ToEqoWAHEzqG8X5AbGBrfaDkh9MX/zf7Q9+bMbRRZ
 6iRSd+TNCKOV55Wcab8c6FgaIYxQsAJyuLcneAD4bXXjsusWsbxEIjDfB9LAQpOGX0oGq2FwPz6
 uRtrMaqSdmVJ7goPpszwF01CQHLr89eZA6Rmkig==
X-Received: by 2002:a05:6a00:1a89:b0:8a0:9308:9b7a with SMTP id
 d2e1a72fcca58-8beb015b1efmr4987095b3a.0.1794585349007; Fri, 13 Nov 2026
 07:55:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107165303.13508-1-lui2012qwq@gmail.com>
 <avcY0oQ-LKWzQuyk@intel.com>
In-Reply-To: <avcY0oQ-LKWzQuyk@intel.com>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Fri, 13 Nov 2026 23:55:35 +0800
X-Gm-Features: AclHuK-MonvIIZ5c88_st52mM74euH03XBrSWCToQF5AGPKZU6jOjVJMS95qZEM
Message-ID: <CAE=Q7=69UEfHMtY+oUtKJJQeb706AwK3w_qwURNNh4zbGOfGhw@mail.gmail.com>
Subject: Re: [PATCH] drm/gem-atomic-helper: fix fence leak on
 dma_fence_chain_alloc() failure
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 10:04=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
> > diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/=
drm_gem_atomic_helper.c
> > index abef865c5f2c..1e484f26ab31 100644
> > --- a/drivers/gpu/drm/drm_gem_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
> > @@ -153,6 +153,7 @@
>                       ^
>
> Why are we missing the context here? Is this some git misconfiguration
> or bug?

My mistake, not a Git problem.

I assembled the patch outside the kernel Git tree instead of
generating it from a commit with git format-patch, so the hunk headers
were missing the function context. Since v2 was based on v1, it
inherited the same issue.

git apply and checkpatch.pl accept the patch without this context,
which is how I missed it.

v3 contains the same fix, regenerated from a commit in the kernel tree
using git format-patch. The hunk headers now include the proper
function context.

Sorry for the noise.
