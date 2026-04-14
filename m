Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1394CF9D0CE
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746DC10E5FE;
	Tue, 14 Apr 2026 13:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hU1EdepU";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3DF10E5FE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:12:41 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2daaab98000so30315eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 06:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776172361; cv=none;
 d=google.com; s=arc-20240605;
 b=D+iNEgdtO1rzR9wJiMuCqELHcj4eeSPKcc240Eg1B0P+t3V7+da4YTdwEkpbTh5+v/
 JH8RZ+Yv/Q2w382vO1/y7ElZX1fVmk7gEUj8RkO8zZx5hM0yvk7rworkjbqp3JsLZQVW
 BtIYygvUJqUdsMT+5k8Gq//kl18UEv6JW/rG38DCBoUx9s5n4SF9nEHic/DbWJ3ECPzd
 JZJsYi2XtSY0oN484EYr72Ztmx5iJdBJ/UAKp4t5VTUunNb4HFutEl9W5v/trh+uLPZM
 tN59z/WP43/kw2aVG8+yMwtyWuZtaiouksKOgzizlYO/o55cUfDmTlY+C/twq6EuSerQ
 ZhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cJCyWhaQh+dfqiwdnSlBVQv4RVtGz2mIxk16V6nAUYk=;
 fh=bW2UtsgWkWDLRyqgNPCvMn9oeJESCT5PFLtExf7Xd4g=;
 b=WDoULHWGxdIto/jj4nAaXBqz+4tfxRwf4kZgzC9NzL8xrs6VBkqAwNUsE82GvaZ19L
 8y2fojNanMDl9sA/n2+SK7aUtk4ruL9Y9eUfI13suvjzu4CCk9otdDk8LTyRkFCkw6M8
 1EE9Ky7Gcr7iP/PP0c9us4YNOVqpoyc2eN/5+p0S02mKGAPeVDp/v40a0EkP5AQTh/gq
 JMrsjBI/APPsx4HVd2lWUh2gF2ohs2UvPKYz16KpvKi62KRWlK+D4540Aejbu3csyzcl
 cxgAfIv/ToPdvFrHdg3+WojNykw7i56ghTkpl3eMo6buagiSfCqSWTYlezbXSvN4Dtn8
 NdQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776172361; x=1776777161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJCyWhaQh+dfqiwdnSlBVQv4RVtGz2mIxk16V6nAUYk=;
 b=hU1EdepUFREW37j9WdiHWrQq89rHv4C8swXi/LFxD5aJVMbhQgasq1PbJ5Z/LkDjTd
 OPRX0VtYrKzOIoaGVHL4wSr8fvGyoB4OSI5uusO7wu6HG7JcuLBnaMLQjikBsZzVLOBM
 h86E6R8CjMbDCGgx3pF0ierasQjpfj3ZkCPKZAcqTUWZNFIPUi4x5ffjy0+AZpxAi9aB
 JJv5cFpmN0HCKHw0Q9yYUVG1p761rohnmjL+02QsjuIqtcfdT5oKhMtaJZlu1Do+nJvi
 lc/duZ3I2kQ0+NAF/xuS3H2Bb7k8ZTKmLJSdQzu7BPXmQ+/uHANocuEpF+ZTOKzYT/aG
 rq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172361; x=1776777161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJCyWhaQh+dfqiwdnSlBVQv4RVtGz2mIxk16V6nAUYk=;
 b=aNOJnwaZL3bVXNf41yUUoeQhBmJ4WU+EMpJmyE7VEQELnwp5OStHmqiZsc9+dTIt2d
 fKextgdsKDGSnwPFFxQtRwH+3ZEBmD0QD9YmTiX0d/pqAD6Csv8tTFB2sL6CMqoW4RjA
 0cX1JxwTQ7ZjvGHXwdK8mHR7FTNRSuRNYL6Ev0UGUkf4iWkyrXjEqR7H+8b0WaxKYhit
 cnCyPmu+0vGIGZvgBUvG36PerHrtDCda7wRn1nyBGtl53eDXTREMIg+1qVCSUo4+Yvqn
 O5CwClpD9h+PKG/uPZ4JV68osB/ZD17Axub3MXCRFtRbquTXPDYW+6JxbW3bPCBMof9p
 cNFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IFvFu9Z/VFWR/kCoVTcMFQhn8J5XAVAW+JVBufcKxnuS5vWAGzpzWdKABkQI5TrMpGYRef+auAH8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywxpw7X8GTVM91s2v2/dtpM0eNHl/beIllCvQHGGP+xoy6oRrl6
 j8PDycxmpcRgE+Sz+Drzgvyd1QobL+Va3glUQVZQxbZvIYHeCS5hcJcnIg/Up4mR3rfl4tYhd/v
 g7grqSI2RzDSbu0V3jba+C8UrpJe21T4=
X-Gm-Gg: AeBDievsDppymEGqu3r1Ja/K3DA9L9urpHD88+eAhv6w3sEZyBVaK1ik3rnucaB/g8G
 wuxdPjOvR2WuqsUOBdUjYEd+UuY4XzTNYErLzB6GIPQD00r4xMhqYqvywiUCHiPIzoK4pXNk1Ov
 v1w+JVcGVSsiJBjoucTtxaSs1Xs9W3ZM/RgnvInxF7GXr+zQCi1ZbWkjuHBaoPH6t6PoECIcEsO
 zPfBsoetb/wLnRxNEbdLsYIwZFboMBBCdSkJ37WVXdXnz4+RfeHs3CXVAr2dcPoy8vy7WPE8Lxt
 hN+QBxS7lNYpUSTZZHijLChS4BS6bV962b1o6WuGxT/Aozo6VByggvJdPyB+LxE3m6TRfNuQCWK
 ZE88QGxIuzx+C4oXy78t8fos=
X-Received: by 2002:a05:693c:2c11:b0:2c5:704f:7157 with SMTP id
 5a478bee46e88-2d5c1a338bamr3845752eec.2.1776172360757; Tue, 14 Apr 2026
 06:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <ad48Pf2DA23y3c4W@sirena.org.uk>
In-Reply-To: <ad48Pf2DA23y3c4W@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 14 Apr 2026 15:12:28 +0200
X-Gm-Features: AQROBzB964S541knBoTBpwId0xFwqsKuV9v54QthQj8L_G5grI3JHKNqIkVHJ3k
Message-ID: <CANiq72n3vcEnQFiDbobz2nXT6h4DTNecTqLuphwJG+EAt9zhhQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the origin tree
To: Mark Brown <broonie@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>, 
 Asahi Lina <lina+kernel@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
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

On Tue, Apr 14, 2026 at 3:08=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> I fixed it up (see below) and can carry the fix as necessary.

Looks fine, thanks!

Cheers,
Miguel
