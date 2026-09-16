Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA01C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A92A10E66B;
	Wed, 16 Sep 2026 09:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="neGVeln5";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A5A10E66B
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:50:20 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso3137625e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789552219; x=1790157019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
 b=neGVeln5gk361JyXq/hcHq2x/xVVxLEFBy5Oj0pKf4CIxEGgq4QpW3I4Zo+CJq506I
 PlUXdk7wkTz+H/C1KAat6vWtdMgsXxBRbLNIFhx4OvdaFNSHlTxk2q5GJq6UY5XvLDGw
 +CDFJEpBDfUKx6DfFJWzSUIrov6yK5mLGixs/t7K6rAtC9VXaBbG8gwEiCQnZp9Ydjm+
 1//7w0NE/vdGaVMvAB+kxYEcLkw1POdOTQy5lM9lAjb1rjinykUBd/ELdkB/vw7laLhu
 VkGtWC1v84m0csvszpBIPb+ZjRkUBtKEVDZ971RwmQWVgWGcQYWeZiBMi+Cq7OrYYIWO
 iXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789552219; x=1790157019;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
 b=IPATXIsxqSTno40jHHlBmyYFG+gs12urgBGWlD5TK+MJk2BDl7avnOlh0VbxaPFbvZ
 187KgtWQsaMWzyuRsxd7qFHalR/FUe/SXif7Xl7rV47jcQlazaoTGyrwPjUnMbzWWxCR
 x1ZA5yxGFLT73wCTpuC65xJpmy4o/+MmdTjLIsrblBM2CXAkAnBeQKQHYI+StdoLJi4P
 4qKNBaxrr9aXzNHVUoTjMnQTGp0F8AEp1fmPwLiMVIakxLOAGG6zwcGyPft0wCeTj5mk
 BLBG12a3LiMWjO6dHNMdtuCQYtS+kvR+StBTVpHyRFbzYZC2P3CPpGd9a8Z2Jr5eo4Qf
 xiKA==
X-Forwarded-Encrypted: i=1;
 AKwUvByyUIRTTTUSeH30xdETD3rdQt3OnaPaqjNrNoPA1yXjB1OOhZgq0WQ5tPGqS70VNlLRnK2i0ZJBt4U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lt0KPkvMukTd3o4D57PHbHI8XaL0SEXRS78AkgvfOeV2K7lVBx
 lzZGX3xF+gR2iFd1SauupMRNHcAFTP9YSbdITSWNhw6mvm7SD5+6Ay0K
X-Gm-Gg: AYBFou3kbMwS+LMnai6LzeTONioOnrIQSXB4K3OrC2o7nCBCL5dzSehxfPQ5QuZIl+m
 W37l0jZ+5gBoWIeUq90aZ21S/ZezmfHxjRnDf2/lmOw4Vlz+U6sM73taz278AZt8Iu8JzuOOPDz
 NrhmbJRJ4H+tpKOtudr5Kivd8rfYl2LKd6ph2RL3JmaYnNFfcTLXmdLymRJrQChgDgFVyPwQBX4
 GQYkmMTNzsQF6YF/dGi3pxgmPQDOdSFW1aA81mg8VuNSf7FiL3Jy7jpgDRVjZiMWQevzF4Ti4NI
 JaDJCZQLC5j9rxvvSwADErlchWpMfhUMwg1mdjccF5tiRhmMsFgM+Gve57r5R+dEkQL0pQXw0HY
 1aiz+nzFUVPWtupUnc0VHIDqOtHB54mENBBVADxZtRChwrTzldnV2Szh4qJj93/XQMhIdsgpvfr
 skLnS6KWsEI6KdhXyUBWSoIR8G/dZpaLBe4SowW6zlQe2EMg4OHutjDBoHjTK1B/rWjEfVnsxzJ
 YU5IRB4DFZyLFESBf8VtHjQVYec34tp0BWrJhLIpmdvqGM=
X-Received: by 2002:a05:600c:4ec6:b0:49c:fea3:8633 with SMTP id
 5b1f17b1804b1-49eb732aec0mr19444455e9.24.1789552219000; 
 Wed, 16 Sep 2026 02:50:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83b02245sm84055225e9.10.2026.09.16.02.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 02:50:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:50:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe
 <axboe@kernel.dk>, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916105017.13ea5e36@pumpkin>
In-Reply-To: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
 <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 15 Sep 2026 12:08:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
> >
> > Is this mainly about stuff like "we installed a file descriptor and
> > then the following put_user() failed"? Because if so, I think a nicer
> > fix would be to have a policy of "if userspace provides unwritable
> > memory to a syscall, just keep going and pretend the access worked",
> > and maybe have a sysctl that kills the process when this happens to
> > emphasize that userspace should not be doing this.  
> 
> We've done that before, where we just ignore put_user() errors and the
> user gets whatever the user gets.
> 
> It is maybe not optimal, but it's fine. You can find quite a lot of
> unchecked put_user() calls with a pattern like
> 
>         git grep '^[[:space:]]*put_user(.*);'
> 
> and some of them are in core code - see the two in kernel/fork.c, for example.
> 
> One of them says "if userspace has not set up a proper pointer then
> tough luck". The other one doesn't even bother with a comment.

I think the code should try to return EFAULT (IIRC that is too hard
in one of the exec cases).
Otherwise very unexpected things might happen if the memory is just
readonly.
If you ignore the error and the pointer is invalid the application will
get a SIGSEGV and (usually) die.
But winding back kernel data because a user copy failed is likely to
be problematic/difficult and at best have error path code that isn't
really tested.

As well as writing fd numbers to userspace, some sockopt code tries to
wind back if the write to optlen fails (which has been read earlier).

I've forgotten which Unix converted EFAULT to SIGSEGV in the system
call exit code - I'm sure one of the ones I've used did.

David

> 
> The scheduler has two cases too, although one of them is admittedly
> for another error case.
> 
> So yes, saying "if you pass bogus arguments, you get what you get" is
> a valid model. It's perhaps not the *preferred* model, but it's not
> wrong.
> 
> It *would* be wrong to take code that already has error handling and
> remove the error handling, though.
> 
>                   Linus
> 

