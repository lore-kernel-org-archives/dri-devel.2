Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851F606A320
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=g6Sgm0ye
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC44D10E518;
	Tue, 20 Oct 2026 07:25:28 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A8F10E518
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:25:21 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c43fbcb4393so260381866b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1792481120; x=1793085920;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1ICODlrliKO72oBKprpY8FPw4rnE8nvSDKvjlXw6yOI=;
 b=g6Sgm0ye4trFB+I6YyKOwUqPo0i3am05hbaX2Mt36muaiMbq3uEXgAdxvr+xpTaGH0
 N0MhKNweRCWENuS4Pq3We/TMW/DrIomKbl+sPqkh0lwmoOcA3MIvbbLuypyULSecMTbd
 zAutY1twofbR6qEuJLEL1ReudSG4+qlh8minw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792481120; x=1793085920;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1ICODlrliKO72oBKprpY8FPw4rnE8nvSDKvjlXw6yOI=;
 b=JUtFaCoxOJFGpjyMoBibwPOWT/VKOPJa9ujTbrb+mbOU/RAmGzHqp7zC1BKC6cfkVX
 t6XmCg0zoD/EQwlMCVMNdilF5cWXYzjuL1XaDbDsxwzkHI9rmjDOg/qZ7hgwUSI/qRDb
 iIo8CbQmM/Kk4VlUiPL9bSYOJHRIWNF6ohic+0jCIncm7WZHsx0AIca8Bpl6g7ghmVNY
 iaENFV/ZnApP5si/shtmbxP1A8cULvPdb89Sp9rqAyOIkzuF52gwNO23zZafH1npPVDf
 7p4CzoC4pjk3bF/6ZTVaTR2SZUcEVa3XsKIjxZFPs/Yo080TTGwbKxlNhmgPab0IqpQ2
 oPfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3ffDV3xwpccxs3Zvnsd5gH+fzzqb0SRHe2YRsB60rBmVGHJlMcvPyeKr33V9AakRWMIPn0ouq4Fo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJHS+jMo/BnKb4c/m95+YxxCggr81btpPlGKR1dbCF49nm6LUIn
 72nTcNorA8C7mGBLRasz5tiL7z08WulPhDDqSVWwSudBYvqYxRd8ITAkM0+ut+0MQ30HhCVTn/Q
 TFog6OF8=
X-Gm-Gg: AYBFou0rrPyeNJ/hOWfjWGX0qV8abzdH2ppAT49LkE8kpHrNz8U1JqLRvhsefyFbkQZ
 Tc3ACDT1KZQfim95T/2IHHdTqaQETDKwWpfgbFAoDsvRFsmCZkQRN8uILwikyAtCtLXtgYOOtvA
 aNmXlUrMOwRfw4z6nJ0bJNbGobP+o6uGmSmDls3CJtZLYOdtMQLLdPqvIspWTIjU4cfjRpoEsY2
 2V6hUwawEd0OmTzDTq4BTBYMquv5Nn9XODqKM3EgpM0Ri609YTqABcHeHvlC0Np1IVSd3dNFszf
 AVxMxIyQK7sbeNmOwjAsdRvF48ucR2QOxKrDVHA6vHxYT4Kh9rndF3h2mCj9358ybIDv8iwHDvT
 pvYKdW+/zg0UJp6F+gGu8yfnqhh2kp9vlfVC0t/3NPFwnGx148w3fatsMJLhyLqS+xKSnlZCyBb
 HsghjyBgEMZcXpuYWVDJjiG1d0Knt/rqavYFGbZj2wF9BnQsGz8btI+KxJVJ4J9gYR+HIlESTEL
 3nhssT8HrSTyEM13QhW2EgAO8Lwoiiyd2oaUbBHW99HDAM=
X-Received: by 2002:a17:907:da1:b0:c35:babe:ab44 with SMTP id
 a640c23a62f3a-c4196ea755emr730828766b.0.1792481120150; 
 Tue, 20 Oct 2026 00:25:20 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com.
 [209.85.218.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4090dd125csm446955766b.26.2026.10.20.00.25.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 00:25:19 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c3f04e0e65fso398350466b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 00:25:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBw30N0GmfKWx274OCFBywZAowm94D6oPVMekBJshOJMTxbEFoep7IjmHnk+R+5jPOO6Gn/94LoYPo4=@lists.freedesktop.org
X-Received: by 2002:a17:907:7b85:b0:c21:1b58:fa96 with SMTP id
 a640c23a62f3a-c419a93bd77mr690281066b.3.1792481118954; Tue, 20 Oct 2026
 00:25:18 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
In-Reply-To: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 19 Oct 2026 21:25:02 -1000
X-Gmail-Original-Message-ID: <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
X-Gm-Features: AclHuK-DiS_yQskPQtrIxFePRnCPfAaQiG7PgS-hs7L4pApU1PxreYBmB2NoFO4
Message-ID: <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
Subject: Removing __get_user / __put_user for good
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Borislav Petkov <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>,
 "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Bah. I made this branch of mine public because I wanted Michael
Tsirkin to check the vhost part.

But honestly, the i915 side and the coco/SEV patches are the much more
interesting ones.

So this brings in some new victims^Hpeople for that git branch to comment on.

It's all in

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
uaccess-cleanup

I haven't dared actually boot it yet.

                    Linus

On Mon, 19 Oct 2026 at 20:51, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> I have a whole branch that removes __get_user() and __put_user() entirely.
>
> Somebody should check that I did it right. But I didn't want to do the
> pagefault_disable() around the vringh_notify() part, so it's not quite
> the same as yours.
>
> Let me just push it out. I was going to let it simmer, but your email
> made me go "I should just let more people look at it".
>
> Mind taking a look at the 'uaccess-cleanups' branch?
>
> It builds for me. That's all the testing it has gotten so far. Blush.
>
>                    Linus
