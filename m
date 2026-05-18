Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08204CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2446D10EAC1;
	Tue, 19 May 2026 07:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FfzNdkJ1";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC2C310E7E9
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:05:10 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so1550268f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779131109; cv=none;
 d=google.com; s=arc-20240605;
 b=Ja94BaRCb8kwlZmvOVHPUdMabdJyuo27zZvLrrnOT2aChs1Fr4pfdqG0ZAaosUkvD/
 faKhsVxCGpDhnn7FKZSQ9k/AGtc0vEVheq8FtpmyV/R54ZONO/KfLA39FqvI7/e9Wl4d
 9CbxHge+7RJwpJFrncKUQXSDZAgxupOz7VmWXK23ca0/NekCevQMnzgzeuORynO10An2
 qlnyLl3zXjHwhKCfVrpwbnU0XKuouE1vR6OVywIPNSuwHOGhR2PB5cg3pLtSbqKZJLRf
 /28k7i8RUSWVInE/HahjDSzA1uwQWi5zOtl2MvIt+8VRtgLqUqIHJdJbytKzOu2nkpSL
 b7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=u31YXDFjxv7mXffscFNx6oOp8B/R90pltj1VyavSSyc=;
 fh=mgQBznAFuQD/hk4WlEcz+JsQkskgZeqy7agP24Es3r0=;
 b=cfwe/IzMNgkaRhXoF9Wa2XBbWd2/9hjnxi2ZtILmIBkPPU9AgGkV+aEFy7On+015qB
 XTqFNWFk1Z1feGAwxNxKb5kyl+9L93TiPWEa3BMt/SZ2ByTUlcxX6KgaQvUjP7tfZHvy
 buOm00RPvyJzmtMwlyaUDRSYSRFUYLb19LawUoLxCt2wnvxV6bjlSee4cMa0R7QfIH0R
 SkrBdB4Evts3eaovQB+iiU7H1MKVkt0GABdOMlgn3rdoHtZZDLKejazxfuvhar7D5f9w
 hUJWq8ccwj5bLJsHw3EWJkz9Un01TXYEiKGsVqMH4PCpJz+RKp1/TuopIwvXfW102Kbg
 Kg1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779131109; x=1779735909; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u31YXDFjxv7mXffscFNx6oOp8B/R90pltj1VyavSSyc=;
 b=FfzNdkJ1VEhpgh5h14ux2PcFmCjBrIwxQLzcaXqk3kx2qUcTUSZwxxrOjZzxzQ/AUs
 7yWOTzWoKjKyylh8mppIVhLTRrtO4YshTyug7FOKYkXL6q8EcLuLzEdTICXP30xWfVfD
 OvCRSZl2Prbf7SdzAvw1edr6rtce1naQptU9bTvDmq4Xj/cs2505YRKAxSQowRM681Wq
 Cu+8zsiX4xrhyTd/5YdwfMAjpFhk1iVviEBfrYi2GYeQUBZWbatQ4ADQoETabHoOjLM0
 gI4vhXHBi5nrhsHsSISNEtpl6/bDGrs8+hg2tZ/HZ2804RIA7AhVmNDBysSqWNmiFsGZ
 TSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131109; x=1779735909;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u31YXDFjxv7mXffscFNx6oOp8B/R90pltj1VyavSSyc=;
 b=YGEJz2A/7HdEUqNQ+iZevzt80wYU3w/Lto3o3x5NXkTU2Btk/X1QV4jcJHCMXFG2X6
 zPgJu78BN68V/r3+SAie1T05jz2yENcS5TbuhsN0YGNq3iob/EMObidrof3TIICpmu0b
 FVsW3YbWrNClToqwK+awkrtukajxfEE0R3cmKCHS7bcybVFPncsE6VKKonndCJNF4rP/
 gUePeOU5DGLvOJWk+uCHIPeu15Lp+qIJ+dbUgbO+Li4RT2MbrjM88aydur8fYiZb5lKK
 dLHQbNLV/ruI6sLtRDVAeFoSIBCz/MHHG1o7pPKFqJBOaeu+eW/Gpddy8vfa4CmqYDEN
 fkqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sEKeQ4fd9x2oqFZ1KvrfcOd9FpM5gCpI2SoON0pRrog7MnK4WFgjW0RJr8JOy7sv430fYpcZ6UGQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOnlLhCkveqhUorodT9wO+tnhP5rRIdRaomUeiwEI4bFbWWtvQ
 AUm7MK0a/pwIM6g9de5sAueejc3zi0MRF+lG3gPu/yg1qx0C1ZY/IbOrWEt0/y2NBN6HKnjOsMW
 v/ZEUvw/qjakyM9HN869NdN6FAjKmUxw=
X-Gm-Gg: Acq92OHEVv7ildLGmFvy99mnugZszPsrLSGFy2f+n8IP6oJIlrpU4039w0fGluuwcAs
 FTHYOUAYJQGXQeuFYiFxRlpSf/iAzkITUovw+oLhqBkCIDzbUjRPvDMb9yIOcGpF2DNzj+/PNnV
 1tbC3tKFX7+2bSKJFP0qeFKdhjkXVNn7QGUb169RuIWr3kPZg8LFKbGLdZ+ZQIK9FFFtJ/cCip5
 AL/AGME3hej0tOl9DdFSbcO/stgyxxWmttJgq56rpIGkPJmyZ48p1fEjkOVEjINK91bTsje3Yn1
 2LfVZ/li
X-Received: by 2002:a5d:6083:0:b0:45e:8526:7dd1 with SMTP id
 ffacd0b85a97d-45e85267eb9mr3505962f8f.22.1779131109069; Mon, 18 May 2026
 12:05:09 -0700 (PDT)
MIME-Version: 1.0
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 19 May 2026 03:04:56 +0800
X-Gm-Features: AVHnY4JqD7F6NFItY_ez5TsTDteXgtDuNdUeoz_k-jjq1wjdNPe4El-vSTxFOT0
Message-ID: <CAHPEe=G26qGCko0FxMa5SdKpOeZagY_mQKcn9ZGPW0qn+i3vUw@mail.gmail.com>
Subject: fbdev: iterator used after loop end in fb_deferred_io_pageref_get?
To: jayalk@intworks.biz, simona@ffwll.ch, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

Hi all,

While reading drivers/video/fbdev/core/fb_defio.c I noticed
something that looks like a past the end iterator pattern.
I would appreciate it if you could take a look and let me
know whether this is a real issue, and whether it is worth
fixing.

The site is fb_deferred_io_pageref_get() (linux-7.1-rc1,
around line 203):

    list_for_each_entry(cur, &fbdefio_state->pagereflist, list) {
            if (cur->offset > pageref->offset)
                    break;
    }
    pos = &cur->list;

When the loop walks all entries without break, cur has gone
one step past the last entry. &cur->list then aliases
&fbdefio_state->pagereflist (the list head) via container_of
offset cancellation, so pos equals the head and the
subsequent list_add_tail(&pageref->list, pos) lands at the
list tail. That is the intended behaviour, but the access
is undefined per C11.

Jakob Koschel cleaned up many such sites in 2022, for example
commits 99d8ae4ec8a (tracing: Remove usage of list iterator
variable after the loop), 2966a9918df (clockevents: Use dedicated
list iterator variable) and dc1acd5c946 (dlm: replace usage of
found with dedicated list iterator variable). This site in
fb_defio was not covered.

A candidate fix would move the pos = &cur->list assignment
inside the break arm, so pos is only overwritten when the
loop actually finds a position. The default value of pos
(set earlier in the function to &fbdefio_state->pagereflist)
already covers the loop fall through case. The observable
behaviour is unchanged.

If this is intentional or already known, please disregard.
Otherwise, I am happy to send a [PATCH] or to leave the fix
to you. Thank you for your time, and sorry for the noise if
this is not actually worth fixing or has already been spotted.

Thanks,
Maoyi Xie
https://maoyixie.com/
