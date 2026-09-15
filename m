Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DD5C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1E610E128;
	Tue, 15 Sep 2026 19:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O61B1uIK";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB5C10E128
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 19:14:39 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f15b78so92893e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1789499678; x=1790104478;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
 b=O61B1uIKToWRdxvkNvrOYq+k9cbCQOFajAC3QbhhMTMZRTDUKJwkzOAMpG2/W5cxPp
 deQNB45Lz50UXy+LjxbKob9rECAGeBO8vvYuI7wVHIEnW95n630eMjp4xa9yzwT3klJ1
 BV7lN+IsEjsYWvRumb8XNNic0EC2lfksiP2rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789499678; x=1790104478;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
 b=FVR1mgiN2jAhOTyZwNgVgOkvDXBq+BWfrAALwGBaO4h0kkwpOksoibFj34yh+QBjW7
 2BiJxW2tk+pdB4URVCkFxW2FXYPXM96uniNM8dghSyebnVYM9Q0rZuxTuB9v3gyOwHJp
 cSNSmNRosBEVGiS0ZeqvPhQp1wfIt/1CMGDtj6a+O1VPiPOsrJ7UuiH2RWPeab7AQolY
 5iszUAwScDdqYI/HEHOizIcw0CSVk7UlMTY7Ov35BuUIcG3g2x2ScC6XqDppfw3WVlJH
 sST33eIxA83KtN8ot7e46MdKqphSQWAjOyOpj/B4HbPLDrrOf9hTR84gVjUKleoybtaQ
 v+0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwStD4tGzcgUoYCYhz1qs6j9PwlLydG3CRNf5bNVzcdb5co3QWKBiQvC3U5XoFzkINwiudZDczJKgY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ndrMyb8hzOKLHz6tBCzuUBL9F75t2Pn0TXEsQ6sAu9KCLmJXls
 QVBU4zDoU6Wn9b1yIdHKXOKSC8QtdpyIVDBy8Yvozb+kP0AwNfYlf4lcr+f8KX412UD0861tVET
 f4H4WPVw=
X-Gm-Gg: AYBFou0Q8FxYF/9CVAThhL8iPu6vSJHcT8CP9QotUOTqXtpfxcqQ7Ve5/T9b19wSiLI
 kt+UXc2yuyeT8J91RIBKDrQlAnYvzQOK8Mjbk71S7CYjsADJ91sl5celcIfnX64lM2fr4bNj4bG
 EnRXAtCflsVqQIu26+bh0YslNm1XualXWqSHIZVL3lfRKulIIvl4n1EBiy+Tih0nBkDCe1DEBV8
 IjsQg7eMpSYImhZgR9sIRNWfGaAoSn+Tgct/dByxS6GmABNDpKK1CZh5g5tzNdaPYbOC6uMtQx4
 Xt5cRVBeGYtmDR4HzILtTVaM/gMSR9tZq+3W1/0WtB2V1YBUU2PzDMs4Rmuxty1C+5G4EmCM7FN
 9gZTOBYHKW94CcHYxusZRmH35RWDT9R9Ay/1swlWtAs8vL0y6QCrlAt9ZjHlSdV6IDSTR+aqUlo
 ST7cRPX2Zw/t7I2ZACGMkorN2oDjTWQZXB4aYUSMxX8WtOVizJsIqspCd25qBRnfIPfsBKQ2gDB
 a7iS1CPAFvvFxKtxlw77tSFTkv3RFXKnoHw5DDsBNTLdkMpEUoPYRNHG+c=
X-Received: by 2002:a05:6512:a91:b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b8ae684070mr4852698e87.6.1789499677592; 
 Tue, 15 Sep 2026 12:14:37 -0700 (PDT)
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com.
 [74.125.230.76]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b57c3d7esm172022e87.13.2026.09.15.12.14.37
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 12:14:37 -0700 (PDT)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a2ff174422so1304671fa.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:14:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzT4ryCax+SI0PtNR9gHm/0cytv+Hn3zmet9JTu4OuaLXYw8Gn7hYRzX6qQ6CEKe55311/8jLEYTHo=@lists.freedesktop.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus
