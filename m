Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C773C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA69E10E0F0;
	Tue, 15 Sep 2026 17:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MTZSGHAl";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD2710E0F0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2dd4b917769so6855ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
 d=google.com; s=arc-20260327;
 b=S3t890MXP9RKAXalx2cSCP4Zsj5IV4kVMaWFSxA7CbI7FdAgfgRsoS26hKqyTNYrpJ
 DBas6HXLZaDAOaGLbZxL8JWF+KFo1RgOSN07fqIGuGQ/uvrikPtb0VsqoXMF1IRZKu3x
 byK3KHJcutHmx3mf6hkc5sp4tB6KjVKGWtYRr1hQGQb1tSEgqh8hrr/Chig2BkEQN88V
 CoQmfCCH0H31/IraSUu5igqzTjKBG0p6KU16SgPlLkqtoI8eBmRZtwFn17LKmKhDTeOm
 gmd1E9N13oTG6+rlAp8FhcC17z69HNXCszRhdk1q9ZdKwmsGs4hDDRmLIowF0zs/UEdE
 X5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
 fh=Rissmrd76tUccijHrAXG0uZ3p5qO+cHzpiyWTa/vsWE=;
 b=RqxAKXr15Pmoeo3Ul8zaPoI1x5eJlZzihYXCmETrUS1UevBVd8Dhw7zL/TnSxarPrc
 baXCqCgBYttYCff/bJyjQK+XIFw/SH/AaUjv/hbqoNU2xzaXZUn4krlbcsFRnbkn93Vv
 y4dYU2iE6slzDiGh9gT4H1b7HVMHxiVpu23lOsLwarOqbEtFVOcbcMIr1Y48wlrTFkWc
 1NZ4Q9yh1529jT8bu7o/QEakQtMOfcNM33OJAKCVXVbhBgNNfBAbZNF6LEoyJU5gbfRh
 EYSjPsweKup97ThzIPA/qOgonqYc3Hj3dEobRF99qq4lb9ehNLsb9MZ5IzyFwWB52o7z
 WxQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789494727; x=1790099527;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
 b=MTZSGHAlghpQs+MZrBMT3mJ3XbdaNTUvJJgnamzeSb+2rVmg1e4++biiNgN8Sptj6N
 02VKT45WEsGdkwJ5IGAjOF6YbU0YbGRhU5ROsfmPPiAYxt4h9DGr3xYbdfvIaoTGYxt8
 EsyADmFbw/4NrEQIaDR/rdxeC/io5kHpGI2W2ta3my/fmkPKArnW+S9NRt/jt8+nWBXw
 KJRzbO7tfVPwxAVIcnXgYebXXOACUe8lncd++hj94HKpmzC2flhwSjEgivb7hjB7G+oU
 DQ0IAcXxgtVmZf9aNeHxH34vwpiwD6VPpp5z8VEhenkd14OIaiWapnnyTY5fp3+NvLv+
 N6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789494727; x=1790099527;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
 b=IZNLo60kb6Je5vnL1+rLx3lzLF90vRNtKJBBom6ssQnQUvjR2OqTVrsfCVeElCXals
 yWnjG/koPPIf7ghZj0anFBuoLUKmeEXTmUYbc1ENplQE4yiGbjPxoVgid6iB2xtYAi0r
 Thv6v6m59/1HIabg4bpWwPrxvRmzOlOg92JhJkLnUc5aHDySdT/qI8We3olksENapTtb
 S/yet3eAeDP37gv6Q4KxRosbcz2XMHZcAOS/pWJJT6+Ohg48124WWdxee7aR1jJu/Zi4
 jnK2X6Jfvo3AZMC2F+XMiEzpHhat1BY3oyRqra4JtOpS21I6DNkBp3nA8Pltuoz7pytM
 CzyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgnhpwnKft4GtwIp7UKtSBmoor6FdOKcSBbSldYrBdvb71QprBaVKQ/JUtowT/9P3+I1pgXKYw5ng=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lfI8uLoY9nagMszNSB0T8g+NkL1GwFhy4o7z/W9pc/O/9X9u+l
 2MGSWCrnKzSgwwc4aEh7uv6cxePy/nhVKXPhp4kA3fPcWHJwYeMN8EjdXitlCYv1YZyZLRTWxKE
 8pZeJjtR6IqQR+YZNalaUlziOFgawJJuO4i7qFfqx
X-Gm-Gg: AYBFou2FdjPssYPSze15R6fMpu9/vHEfApTqVd27AOZMLv5KurpzaKs5PGNd4XZbVYY
 OUV/OyR7apM1P1EPMbRWNNl8oehIBkx3BKsc0J4oW51f+CowipbLSaCFvlbfP66kyZG5YmXJzYP
 fzjoJdFrNAj8rj7AjwgMNVkJS1JlywkK6fr2f+A/TpIC/iz/Tr2iOHJynHIKJLJ9PkKOk31VamX
 NSBiHjho2AUkOKb030pee/N0tnWo1zhnpIKtMvrWgsrem825B8hkodRXkN5D1onTBuO4Ly9eaJW
 GQ+rQP8o94DGyGzkZda53rwHcYGkKPj152RQP10kXGC1TU1Qtf/MYlElIIbsN0y4xE4nKz67F8I
 Lqlzt1gwrlalEFCq1JB1oDiUkNcjMmjBv7nAfHhg9u2r0RrDMGY4=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
 David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
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

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
