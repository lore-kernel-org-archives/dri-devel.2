Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C881CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8810810FB21;
	Wed, 14 Oct 2026 06:49:28 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737BD10FB21
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:49:22 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa36fc0eso34503a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791960561; cv=none;
 d=google.com; s=arc-20260327;
 b=n9jw+bSR1asO93qKaRxTe0b0pkqVsA1AfDIfvmOtmKqc1inbai1TSu7avRNv9Kr8E2
 EhEsrlE6GyaH74X3+FdiZPwbKPL/xwy9cE14pVmNlq3VuygDhhQlJ9wVHmIbE9rYVcpm
 BG/gypGAQKaMeYPkwjIvrWMzKQXg5oL5RfKck7jZhwhR+FYcE3Wjp8NNbfZYxA5his9V
 uXOJ+x8XlL5x5xg71kyqm39sqMsWdSztXHdpK6Zfn/cTcDCAnVb5L+5XHAz0EOWQNjFc
 WPaz9IZbdRYpauBqz8v5xK75IDC0dNRWhSgWghrZbEzVnjDElSab6sYjSSL9sgOsaFXZ
 9iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hzNLroY1rGs3lSGbTgXAw9YTjwc3chJEBfBH/eKMZdc=;
 fh=B/9i44JEYbTYwjvS/vulRTP1+6ov6Vwaf5nYg2ngxVc=;
 b=KuGAC0LiQQ+l1bQrjStsdviTY30nUxFHkhFqfodLF/U1O3yYqUpVEI7FfUCf3Dynj2
 qAwLxfidL+obmTYakgf5O6pPyYKFveJDzC2pEd0OLOYfn5Zu61T8g7cwELqu+PgdqNqp
 CRQe+k/DKLYcWAN3hOcvdJcHWeQy2lnEVXfPHLryrUnQlQcPBFVOQIauQJK3iW2qLKsO
 DnlfnyeWwyOUWx+yqYoeZods3m7CUcbY4TZm04hwZ+wcaDbHnA6JEUAahdDsF4Frixvx
 kbEWsapgnrH/1elbq2fG//VOhUFsCzHFUKnIq1uhlAuRw5XScKRff7nTxdRi9sIKL3ZC
 n4ng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791960561; x=1792565361;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzNLroY1rGs3lSGbTgXAw9YTjwc3chJEBfBH/eKMZdc=;
 b=FqQ0A8r2BWeQia/KkLYXysVgWgFSkWthDYcDGOB3sWNowK6Pv2ExqC7JqRXBwhF3Bs
 rmcnqQWc6yQUY5h9ZbfmSUcqwbVtOVrORMLrnF3vhjsYlA7z9CaC3kf/mUmt41RxcmNA
 OHFbdPGipPKpjaRfJy6oQKFdQpQzYSqCAtNqsQCSj197IPCkadN9ijKyKUDxm0sz+2sX
 tzCEvZr3A++5L8J3EhDa3o+CQD10etBzDqjLf8XcgjyFvitCGr04nWCy6UQY8M+g7Rbp
 6S3NuZiG4w8Cmx/XKV5fBrDf75phfV67HTjuQWi/R54GPuMxmRSCCYxydAhzCvPv3gWn
 L+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960561; x=1792565361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzNLroY1rGs3lSGbTgXAw9YTjwc3chJEBfBH/eKMZdc=;
 b=RcRUusk3Byp2vUsHPyZFcHxIaXP+3cKtwGfxZ8IzXmt/SjgW8oEjT7ZkL7FIKyKfwr
 EPHgfWbncl6bE458bwel2JvFZGMy1XVzWAgoCYbto9eJlpEzY7I0tAYtHNHMyx2Z9Vpp
 IAgNhZpmCGawdxmgROgxh79x9AVfnHPq/s35oc/zCfd5pTo2GL4gTanQPShlB68crIU1
 P4ySo1bPv6GYgZ5YpBYh980JzkiaiC5YxG23MyCmDOsyvE87XCkKf3UBVyfwUIqWTLun
 Urb7P+xTPZOULHke1ZMAkFhaL8JhaZpNrh8TxLHyPY4+3U+re/0mjMZbwu2ZlhH0f3r9
 EEDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/QwZS8qZ7jHgGtVwPrWjzsPDLNDXcx6EhsVPWwtryoXIGj4G+jHHa7eW9eysQo6ctw9qzGdG7HAU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKS7sF7iYQPswhR+eCKZci3Hu2S1CnGjYTjL1tIAwk/R2w1gaH2
 VRr9U0W9qTNA07D0eVNhe7oCUGgAKUqAMn6XWK8XrOkuJcaApzZnryAjYRpvP8J50l7uhLJdfE6
 9UcSlZqN8lCzbGN+QPx3G6vwY67lt0tnvSkDOf53d
X-Gm-Gg: AYBFou2eLjgCEYMcWShYd2G8PeFS05OYV/F3sLocNBjtxJswbV30rM+CrhVbGC8xkeS
 nODRaW8lEjoxd6vhGJsFXiRCinymeTLgSEpV1qiqWtnNCbuh0CRojmmnSuIWahtxj3sJ0p97NUg
 fLpYkwCy27mCtyGmkNRKRHcn9/PJB9x4qwPdHwXi6z4OjcC7ICgWdLN7zx+5j5Ma8IRXFgh/gp+
 3aoQIhrJpq9n7VSyWfTb0DQn4jHzMU0X4QViak59skbFgZZmLUhzc6GcCz7FbVxB4yy4NYzRRL5
 3q04taQXDOa8Y5sCtgoiuxalbbYUagbQb3KGYOsIzBBOLjHp26BuYtWRFFXOqoyE
X-Received: by 2002:a05:6402:683:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b20ab049f4mr17118a12.14.1791960560065; Tue, 13 Oct 2026
 23:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261012174300.2338784-2-almasrymina@google.com>
 <179191526299.434549.7888465945343049764@kernel.org>
In-Reply-To: <179191526299.434549.7888465945343049764@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Oct 2026 23:49:07 -0700
X-Gm-Features: AclHuK_pUGXFUw5Tdds7zQVYPdcRbxQWbgDPdlpfKDTpq7eymZUOA6XtUrz1B90
Message-ID: <CAHS8izOppdgVxeHrUpR6zVxfdTHw1Bv4JEoYGYGodAjyijB+ZA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, dw@davidwei.uk, asml.silence@gmail.com, 
 ap420073@gmail.com, sdf@fomichev.me, pabeni@redhat.com, kaiyuanz@google.com, 
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, razor@blackwall.org, 
 daniel@iogearbox.net, tariqt@nvidia.com, kaifengw@google.com
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

On Tue, Oct 13, 2026 at 11:14=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The same dma_unmap_sg_attrs() slab-use-after-free the patch
>   claims to fix can still happen for RX bindings made on a virtual=E2=80=
=A6
> - [High] net_devmem_dev_unregister_rx() adds a new writer of binding->dev
>   (and a new unmap).
>

For both of these, they're issues with leased devices AFAIU. My LLM
found just too many issues with the leased devices. I'm hoping to have
this series merged to fix the lifetime/revoke issues with the physical
devices binding->dev =3D=3D binding->vdev, and rework how the leasted
devices work properly in another series. It was just too much to fix
all the bugs in one go.

--=20
Thanks,
Mina
