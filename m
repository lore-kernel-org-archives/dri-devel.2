Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA59DC55177
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 17:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31CA10E431;
	Sun,  2 Aug 2026 17:07:03 +0000 (UTC)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16FDC10E435
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 17:07:03 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7ee50225cc7so3716795a34.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 10:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785690422; x=1786295222;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zxFXnSoB4KgiBC0T5VAyA9bBTcGnRnLoGoYzvYWvSBw=;
 b=dsZ3pDQ63rVEy55/1rxDF15gj0FO1tBdGl8eJ0qRL3gdXs+cDx/4xTNcTEDVDudpZn
 HUNeF7IGI861Q1eS7pOoz08DMmznEopcmoagQs/Z1uHJn9FoQAhPJMxJgJaPRV+PA0wY
 EchF9IpE2iMUcFw+lMhqN+jPSPupuXgRWJn7uHccfTf2yRht3G5IK/6aaamNRrdn9sL8
 ZqaJcPK3G7x+Yct10446Q92PB1uNazpsUkew6A7mobc5l+EyTyasx7OLISl6VxNBeRb+
 W/0Pu8k0M5orxVSUvXLThd1VhGTS6md2qMJHy+vnCW2ZCpA3RQt8wKA7Gs4iOg0ndeLL
 h4TA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK7F4FmI2qFnEfcvTOmMOqbBjjThO0lXUz78LNqE/xMIVZuTbsfdWnksI7xABHCsJvPqDKd3q5e1k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRHR66C3JZPEWqnogZY1atOj+6h/aQxj6JVKl1hHV2rH3R4VbP
 qypclBLLk6NffNQaWWJIwr8gY+kG31iOb9qy4Hl1EiCcADYMjUXwehuAR24H7DAKcJVK2ElMEUi
 6jA/OYqqa3Y17pIiqKPYlXVQVTpBRz9jpp6O65DypSn4X/+qoUt4SElAiD3I=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2228:b0:48b:5dcb:85ab with SMTP id
 5614622812f47-4af5e07d704mr12408667b6e.8.1785690422033; Sun, 02 Aug 2026
 10:07:02 -0700 (PDT)
Date: Sun, 02 Aug 2026 10:07:02 -0700
In-Reply-To: <68dc3ade.a70a0220.10c4b.015b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6f7936.13bfb6d0.1ecdd5.0272.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING in path_noexec (2)
From: syzbot <syzbot+a9391462075ffb9f77c6@syzkaller.appspotmail.com>
To: brauner@kernel.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, hch@infradead.org, jack@suse.cz, 
 jhubbard@nvidia.com, kees@kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-mm@kvack.org, 
 sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com, 
 viro@zeniv.linux.org.uk
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

syzbot suspects this issue was fixed by commit:

commit 6de2aeffabaafaeda819e60ec8d04f199711e11a
Author: John Hubbard <jhubbard@nvidia.com>
Date:   Thu Jun 4 02:53:14 2026 +0000

    libfs: set SB_I_NOEXEC and SB_I_NODEV by default in init_pseudo()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c53db9580000
start commit:   ba3e43a9e601 Merge tag 'soc-fixes-7.1-2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=65472e27d1590a04
dashboard link: https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a08f2e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1697af2e580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: libfs: set SB_I_NOEXEC and SB_I_NODEV by default in init_pseudo()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
