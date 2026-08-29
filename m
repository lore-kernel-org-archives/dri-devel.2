Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F75FC61DD9
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 15:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCF510E07A;
	Sat, 29 Aug 2026 15:56:04 +0000 (UTC)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E75610E07A
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 15:56:03 +0000 (UTC)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4b28db3a47aso3588166b6e.2
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 08:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018962; x=1788623762;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WXXv4xpnt1/RIHcZ+q2gQWeRw9AsLgQNjGhPdDBrae8=;
 b=aeVwDAEqglGok/UC9OLchmRR2uCgh6qqRqxEP5vktOdB3mds31iHmC3hcgmgX+EDBI
 8BIe+VCb5zO5oXeC0cpcuIgF0i6qmETuIwfSdAgIMcEuyyIQ1+fSu2ofa2fRXZ5QLR2y
 vR3B9DPsCftujFqd8s2sqB0pHGYJr/QT40FQTSOEvtdQMPFK4Aw7PVhlFczDJ+JOVBZH
 RtYWyaQYNnAO4U6tPm+TXCRDvPXUNwJtbFFPXTxXyUHoXRz14wdkw7B8PZfV/jKw/1v3
 BK9aDDB4SqDd8X5EPh/6u89csjlLERNOKyzmnRx8M6TjF9qkYpa1dtAfNVs4VXkfKJgd
 NJ8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQPeUJoB2HwVAfgwRpYBj36BpUg4QgPPXEZYCTvHhffbqyXvz/PYYwOFJ6e/rHv6fKk8VnY5pKDQw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kj5JE9GMJtOzilJPSgbM2xGabmF9p4nt57t92LsJxIEJmQz9CQ
 sQB1c3jk51VQCFIAwuo44fWY04PTSICEEvMPANjJ5ltE4Ki3RJf65jpCSfC1ifxVsbS21bNWJNJ
 THhPzzmtyMBm/cnwD8BNQrCENHa2CRFJ0AW2gCv1/h7htRYCs/W329tcY0fo=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6783:b0:496:11f1:f2ad with SMTP id
 5614622812f47-4b3980587b6mr16630161b6e.6.1788018962740; Sat, 29 Aug 2026
 08:56:02 -0700 (PDT)
Date: Sat, 29 Aug 2026 08:56:02 -0700
In-Reply-To: <6a78d191.b50370da.49fe0.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a930112.1d9ded08.62e62.010c.GAE@google.com>
Subject: Re: [syzbot] [media?] [dri?] WARNING in udmabuf_create
From: syzbot <syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com>
To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 kraxel@redhat.com, linaro-mm-sig-bounces@lists.linaro.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, robert.mader@collabora.com, 
 sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com, 
 vivek.kasireddy@intel.com
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

syzbot has bisected this issue to:

commit 44e9eb5a762142a4aa46c0b5da7c39bfeb78910e
Author: Robert Mader <robert.mader@collabora.com>
Date:   Wed Jul 22 11:01:45 2026 +0000

    dma-buf/udmabuf: Disable the size limit by default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d14379580000
start commit:   0a0d1d55dad5 Merge tag 'scftorture.2026.08.18a' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14314379580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10314379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335632b21d0ce540
dashboard link: https://syzkaller.appspot.com/bug?extid=bfeed181d1ce9ec87a8f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c2719e580000

Reported-by: syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com
Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
