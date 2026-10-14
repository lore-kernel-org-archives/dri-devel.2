Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D4CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507AF10EA85;
	Wed, 14 Oct 2026 16:44:38 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E90810EEB8
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:44:32 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-34c522572bfso548264eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
 d=google.com; s=arc-20260327;
 b=biNaOBMweor88Oidad6hnF5JpcOSDOIGJsHCEjCyUOz66y55qdu4D0XHbmNz6afW0n
 0HaYl38Bx0nhaZvzDSGGQlsVPqy+qFr9E1QEkjfOUAHtmmQ9jUT+/BvKED7Y6lIL+E4L
 vIxyp+OGD8UtqnhTTeZptWc71ndixXYPCzoZQEHWQ9bK95tH0TKSNJ3zkiuU+EkqvZ/Q
 iCJyyN8qsta6m+gObHlrTGpNu/MqWbYu4LYGCZB1M/CoZ+T62h6FN9pInlGNF3tpNpjE
 A0kvgFYruBRIPfhGi5bdBe215eg+dPoy2QIBFUZlmmQn+8oaYFWrVRfw14j6C0U48naV
 FHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
 fh=awdRoXa0RCB6aadH1sekwznD8jMsPNya7AAuljEpxPU=;
 b=dnOtKDtBmBuFvYTxcRcXm4b08eMDznKr3gT8oKIpRCFocudn6R2ku54Zav03t3skOJ
 jIgiS/a0h4Cy1hd3mBiyGNlMMrbXZFpbmJt5ZUSUEUQu/0k3rT6B9YAKrgWZ5neNwju/
 ZaqAfr13BnnqlDAkWgy8vlIj3O64uFXjg5gr1GFonMWcbW/QZNwzLzzoeew45yubqWF6
 Ym9TQRTvHxIzHbmpv+NL/JuD+n2ydt5qWcR/TOsqah71e40NjrZIkJE9/5B7RLgTK2f0
 PZelf3ZGZm0aAbMuKQHO14S3DQA8aTbY2NNGtT147FFx3D5zZsUhCqKKYgymvdHSs+bD
 iSvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
 b=oSJPMTn0eHIyIrptvv3zGySnaRIQReJ33OMq4nLDDuxe4c7bj8c1o9zqOUl2BGZTxw
 nvovpaEiKKpC3Oh4MI7srbTJj7Di2H1yIs9Yqq3TFWYqjBB56HjoCiC9LBwLNFFgvzOF
 IE2izTCBth3bLsGVoZi2I7FUKvdqrpB+BlMU2Pv0h0gzdp+wf1zSgY7Bs3lX3H3XBkX2
 CvkhuHR633s9jmcuByHT5gLinzah5OW4+tv8wYCbKkWxl/RXubvWBdwQYtN8rLWg1b5e
 IF1Dh261V4Wjbd3Fph5DtTpaoywfaWCovpmwwAzfJ532MRtrymb8WuTdBz3l5AnhI9oL
 4U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996272; x=1792601072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
 b=zngQpUbS/Cv8MwSnDgEeebGNZ4n9cMEKAuSFOjcIuo4LTxb54FJ6fKaffwWAdFDuKQ
 859cDnO3uCaxXgZjQglOfc61e2BNm09t5jW93rR/gH9d9bp+F1Jr+DbNnD5BBUDjGiqO
 xg0rgVXhwCKsklC9D0M+53gIVD5+JSdzzeFMmelP8mU+eCFB2BF4/PSdoW+eFe825zBf
 LXgdY1WxBvwrLEy/TanLEOV384qMj9/cXX/svbl+3n52o9ry8310PAOcs/MQXcea4zR/
 e56lloGLAY/ZxQVaydXRtIYi9Ryj329Dg5/1uK7HK64oXUim1LojmzktqZ+lEX4mx2v7
 w4+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1LRMMmPbsj48ynSw7Cgn0sm8xOIcbroIrGebIUVhQ708D9hKDRKbGJo26snRZuXm8bmZ05YTwJeA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIbOSfJCf8eFEc3Yfif2jexqJHWW6cWvJ/wGJ2Txcc7NJGeUrdO
 5uyOVBuOmD2dwaJxiBF8MyZX4PQgv98HYYXgov0wOjxqMXJXqXarWPhWpxvEJ1UysHyqxRk5BLd
 6422TqPpMZhQGYWCp2itofqG6JVGojYw=
X-Gm-Gg: AYBFou2L34FeAPK1aw1VF4Ek3HGzovFUO4MEXdQdZIWICKItfVpYT61upSROX2qlXKt
 5hFDmijQ+hyOh1UITx+gFmv91SLa8rxdBpU3fJHT37Zz3EJvjiCobKdilsOJwZkGTSVsZ8+8gLe
 8QlmF7dwn8WulwjFsigWlIEVdOUCLmak5uyz9qV7a3CnkU5Nyrb0Vz5kYht1r6mUj8FaPAJ9nv5
 q3Yg+Omk1LGcfmmWMVmZysU272ELjpTcMdeoJuoed/Yl6B57SN969m4Ljy/wYOKxLo4CKGSa+PT
 vNo1KMU40kOC5EjocTSk3a71j46ttlXmx+lpsTWS6l6NXSrOJH2FDrLDcX/QWT+5i0D+Ui8eJYj
 /F1ZMhCUQxVKbHYR1WLqrh0Dy5wpWAQVq4Vtg304HL4QzEebaWZ/F3GVPjkC8p+Y3OzuFs6AqbY
 JQ0Gx4tIydciGfkEXrc7lyHCRLaTdxsFa/SQnMr4klQnyNTPKdtlY=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
 <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 driver-core@lists.linux.dev, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel
