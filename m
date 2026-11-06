Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8E606A33B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=utoaj1zN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3F810E3B7;
	Fri,  6 Nov 2026 10:48:10 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4B210E3B7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 10:48:04 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b5669a5100so596097a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 02:48:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793962082; cv=none;
 d=google.com; s=arc-20260327;
 b=L1x7hW58qcmfjYpG+72GqzPUMUSR9EfecxQLe1F9iAAgXoWWWDEOdytnuBvdfTgLbN
 WUc4/Li1+2OObDPrYvsaj1ifOincDH+P3BgDZFKkO2x+pXwIaVOHwPjlz0/bGnX7X4cq
 795n24GYsi/Or/Vw3czyT8mHUXqJcnXl+d3fqyz3sWCobVzGdYE2hzDZLc/qZ+PA6vYa
 OM+xzlaFcMz5IK6uOVufHrVPanb311wlxeNG1klsXCFvRoiF8SpcAs6xqEi4T+JO6jH1
 2QNsW0JyfOx2nSbKBc8zR64SLFKR0HnClSOT7fkqsL4CIbXWkjO8ObBSMOFmOQ3Jk3iG
 neTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VpgWzd6V3pj0d+lX1xpLYiKEZn+iD7UorgL21Ew16ls=;
 fh=Zxvqd2FqT4mv14um2loPp2nXSWTNcECwNty1Vmod62U=;
 b=ovps5G6nr62sMD3QYdFwDdT0PPX+o2TNOuvuZ9SNRKCRi3co75OqXRI0W80bOoBu/C
 Pa7YBaGUA7r7Jz7MD4ny1Pv4YAgUvUlNiynSJxIKcyWeesn61bE2vvPI/AH7W+aTUntN
 5kPpryC3LtTj89wGLRBdnS4MCRIq+YpPhR+zOXKVXG7g2yeXh3QS190o2vFlxUAw5ZtJ
 GhQODbt+5Pj44xhWXw95tYb/Gysca296vOeHNdPiGFQQjwc8UZoUNrWCS91iogCaKtzh
 t3updtAap/H5X60hqWgLgIdAY3ZtF8xCg9kW3DXG/a+Rl9IxB4dVIZr+kF/HYogJqDDT
 M2yw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793962082; x=1794566882; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VpgWzd6V3pj0d+lX1xpLYiKEZn+iD7UorgL21Ew16ls=;
 b=utoaj1zNUNftBcJ4XDqN/aDs3+IuIlvQJqFdvW3BD45sf4C+1q4oUCFd4coAEo991K
 8vzI7KMF27SBnb91a7cDuKGojflbch3eV4t4aSWJwqcM6t485XOif4Q7Ud3Hj2e4qP4K
 jzojt36H2vueHJUXhuX/g1ycoc7ZE97uBlXWj5c7NOSpIjoACKlgdjqRfoBG6KSrbhxw
 Wv1PfZ7vc0zkh1/WDKFZCW6s8fJ1oqqTALCZy3IozsolxjPgSfcQ0LuX3wFlbNurYfAG
 RroVviPg9/wGr+/Er3sy+WTvzikoG0rXM0SJpMWIpXTxg9TodDLNiD+Di+17Op/w9bnK
 qC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793962082; x=1794566882;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VpgWzd6V3pj0d+lX1xpLYiKEZn+iD7UorgL21Ew16ls=;
 b=CPjKKWmHLIEVLrb2cnsMJ8/9KvUxO+coX4S737esAA+OqcZCtOq+4adfTik+m9hNI8
 wk7bcBZf3+6773leeFSaTTanHoXWBAqn7G+tGvkl19OZi/PXI1nWmml2nhgVjIr/ivS+
 Q8EGvVkC56DNiU0iW2akUj/BTiniDos058DE00QNBY1Vw1M4dyE9hHdBOdxd5xs+FZU0
 uZft7QAUaBBctJg3egCRSjmurdOdfr2LECgbdiDG8aBf/+vXRlhlvwek3bpQxodtkCUP
 GE3g9WE2KXm++7q8/2oH6ShC7MVsWj2cN8SBk8Q9m2m5mlzM4jhMvC1SHETr5QKKVMBk
 HXfA==
X-Gm-Message-State: APuU4Z/iW36QFKHSp0URJRNkmkc5iKpPKi0Xqz3n+nr6FsoDl4MfZY43
 yabPqwI6zSmqDT85VDSN6aPGuHNpIgn90uDJ9+fxSX6awau8IqIy53viMhly4OBJCigbMgG3Yp3
 1SRcDBzJ7bpR7CzBYI2G0iuYPljIlZtz371+FvvYIgg==
X-Gm-Gg: AYBFou2hrkWlVefIbZHv60UGThYaCNLelghP0OLsZTQosuh1VWT7zg929T7g1NZkqW9
 cv1GRBgK9Tznpq4TLoPedSQ0h0jqxtDuohQczVu3Ij4GBlrjZryU9+Cm4WxkTqh6aXtMNVErnZ1
 gouACyabY3Vew6z+tqk2fkcedDm3xqDiLn7UjoUz/S+5pHLoAVzbUGxyO3RjeowXUQz8PjVRpNF
 zeg//FST0Ax9+20tbnSYuQl+XutEsxYlhVcJeWTx1JXQk3zbtmoonYtqujmveV0OlaD3wcpThx4
 AT3Vwa7Nh4Crquk4gvJycZH8NToolxJOcLXvGGB2qY4ku9SURpQgzjLDSEodyGnOS8RUU14VXXd
 ANgFCjLiV11xGnNSF8iuCxHBWIYweTI1x+V7qD0oPGIdfcc0vyTvLGL7TV5SQiAE3HQw=
X-Received: by 2002:a05:6402:e8a:b0:6b5:7792:d82c with SMTP id
 4fb4d7f45d1cf-6b59781621fmr1391524a12.16.1793962082384; Fri, 06 Nov 2026
 02:48:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
In-Reply-To: <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
From: "Operating System's Depression" <operatingsystemsdepression@gmail.com>
Date: Fri, 6 Nov 2026 07:47:50 -0300
X-Gm-Features: AclHuK9eoIHOOl-jWVCYHYnEyTadpR0syeKsgRMUfNqU3K__zn-fC_qvkIRoMYM
Message-ID: <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000a93fbe065f995855"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000a93fbe065f995855
Content-Type: text/plain; charset="UTF-8"

Hi Patrik, Thanks for the reply, I'll keep the SGX535 code in gma500 and
prepare a small RFC patch next week (between this Sunday and Tuesday).

And yes, I used Google Translate and AI to make my English less bad since
it's not my native language, Google Translate seems to be getting worse
lately, sorry.

I'll keep the next emails and commit messages shorter

Thanks for the help with gma500 and KMS!

--000000000000a93fbe065f995855
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><p>Hi Patrik, Thanks for the reply, I&#=
39;ll keep the SGX535 code in gma500 and prepare a small RFC patch next wee=
k (between this Sunday and Tuesday).</p><p>And yes, I used Google Translate=
 and AI to make my English less bad since it&#39;s not my native language, =
Google Translate seems to be getting worse lately, sorry.</p><p>I&#39;ll ke=
ep the next emails and commit messages shorter</p><p>Thanks for the help wi=
th gma500 and KMS!</p></div></div>

--000000000000a93fbe065f995855--
