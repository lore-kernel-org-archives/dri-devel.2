Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B0606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xD+8lqOH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED25910E050;
	Fri,  6 Nov 2026 09:18:41 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF7110E8AE
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:17:00 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-563a0462094so682841b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 15:17:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793834219; cv=none;
 d=google.com; s=arc-20260327;
 b=OkiSzQl1G4hnZSMmSucmMlpCrf5C9Zo0sgI0MePHRtLdWGlnqeuMsQpG5L+6weP3jW
 KRAtplFGUFw8v5s1p+cWpp+slF4hzMAvqqxMycJna7zJO5JkOBbjuRy9o3M5BJXyjVxk
 /ETGsFku4RVR0zTHPj2dNwKNCCTOg/g3rWOEns1K+MLEa2ahXfqmyn7D6Ol+D0wwhDBe
 uh7ggIViWPJ3zmcfKrFkxjFRwoIS0vWI8m3XqECps0qPClhuamgfJ8tRVqXrFIlE+dy5
 yf2MZmoStZbtgl3e0Xn5i6+IunpTxV2M0xwzWsZmzAJPrUmDgyfz9UUEL3D9vrJemE5a
 E7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=Eu2VU7+z+HKfMP6vJYsfzm0I9qWr/gxSKl0LlmZhiXI=;
 fh=B0p+gFy9C+0HEWOwhNiauj9LLZqQbmGd5k85H0yCt8o=;
 b=epWZ6LJZdjINd+ZChxRzgJzfQpfXS3d240PtK+3c8F10wA5qctkNN7D7o8FLA/pPn8
 ec7nnsWlMd284qJys/IQm3iqnIAuSs0x0E783r78g2SA1fs2kgrTwWNTJ1mgjbp6PQYa
 tBIONTlJT8v3m1X+yRVhgEfuRXP0OQ7j4RxWfaVvCyi62J2Eo4Aa8Nat5JXFRt35TMNb
 TXlicAj6UJhIBnRmkaLqt3xQxVm3WtDT0RrgRycEFOTMfYlRix1TdH2ivmRWIqhjd6PP
 4o6aH1DxiLvS9Dghule/7SlAV8LJWP4PP7fsWTYOLbYlYptj/cXCbFm6Cp1D3/0OVmbC
 Yc0g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793834219; x=1794439019; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Eu2VU7+z+HKfMP6vJYsfzm0I9qWr/gxSKl0LlmZhiXI=;
 b=xD+8lqOHbFZ9itVnGx3/grjBVhk8DTWa9qRCElBUeK8ytUp/xkFn6THNZ5Q4rchlZC
 U3k+JeFltpy7E42ga2ZXf5posNfzWuhHu7ZWSE8Razbr0/l0UZjvcdSMuLZaZUTGm21H
 7uxAkyf59L08geq6zIU4mXny9uammbmyZ6XHwVM0HylX4jUNxyHP26hV/ohm9yaJ2CCw
 JXfb0JjX66nn3V0fIbxwrU1HqvbXi/a7icFo3xKRJ+SxObZe12gEW5QYGJf3s7THeyll
 s6ZSM3QABbSvt/C5bfu7ZvROEmbH5S9bPTE5sYXZrOE+9cHvWrQViiWiE+K7jI+F0qyj
 ylHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793834219; x=1794439019;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eu2VU7+z+HKfMP6vJYsfzm0I9qWr/gxSKl0LlmZhiXI=;
 b=OENnKtAvxjqX2bKgszyqNBon++6EAnH3V6VzfJeyAZm9NhUXNEtvWpcgdFvHoH1rVM
 dZEdMynvlqFM93eLnyWu/BXSa+AT+uAFya1pgAX22POnVyDih/Rso/URMhm/P5ozOo5g
 3iyu1slfI28cngV1qHo65zNmjTWaCupllVo0d1afgdkO7tmMlxu6k10jzcet5jLyvJor
 E12mFeLfqSOXncm8gYDipEa1CQuq45Q2HD1QBX6xq+JpPlpo+A1QAOJ3/EvX9I4Vec01
 9hVs7xQKeOx3tlIE4xmtBid3KvF4WarG7NXPnwt8GhUU36WIkF/121GiszDqeVlLd+bQ
 RQRQ==
X-Gm-Message-State: APuU4Z/x7fpf8c6uYx6ExiACZK/Jb3aomJhyfRlW/hiWCqY6xezd3Nux
 3EuQJUmmbEWQVCovPWIpAxp73Cylf30FGn3mU7JXTvq/IgxIv95qHVza3MrHwdzoSz3GK4fvT/X
 hNDqw/RLD+EHtJU1WlOBBEVlV2sQZja/F8YDzDTg=
X-Gm-Gg: AYBFou3ZdCelzjUzulmk3OIpz28p30nVG/2a7SfHQQ1S13HI9H5dPeh2XYnOoirWJsu
 ggMsrDNNiBcS3FRT3DH00nvt3vWqzzIDAeZAeDTy0ZjI/7UNjWWMxoGWjrKUFVcavxQ/G6QC/ja
 DaUmM3qxboXPYXlOhxNYzQQlJzf2g9JkwFCEsv31xBnsNNJAKayaTt/mH5fFMqvRGHhe1rkHLOS
 BMFi/38XqP0lMRkLGqjSpwGgwXzadhMkjrtpu3FeNnuLQ2/6amoRqGaPdkoZ2ropGxAm0JxZSWA
 Rs11nYJNTRpLUPzPMYbV4pfhNNOsBkxs+9dMpP/RHWHZs1xS95hWbbCzqDlDckXerkLi3Itd76y
 b4433EMAKvYAYQR7mwyYwuCVutrVUGY4ziZlvx+0BiggVPx5LP3o7Sy1x3zPVaP85pf2r3+4=
X-Received: by 2002:a05:6808:2218:b0:55c:95a:f10f with SMTP id
 5614622812f47-5640de58220mr13092358b6e.52.1793834219392; Wed, 04 Nov 2026
 15:16:59 -0800 (PST)
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 4 Nov 2026 15:16:58 -0800
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 4 Nov 2026 15:16:58 -0800
From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
In-Reply-To: <CADZg-m0hnuZ+KpqkUgwZvkhjUdN24syvc8qxuR+oZC5rkJHSNw@mail.gmail.com>
References: <CADZg-m0hnuZ+KpqkUgwZvkhjUdN24syvc8qxuR+oZC5rkJHSNw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Nov 2026 15:16:58 -0800
X-Gm-Features: AclHuK-H-X-4RHKJJTl8yiRj9yZvh6aBYUGlyyiyik-3gLApeo0lzV-MBKHf-DE
Message-ID: <CADZg-m3HZ8qpXdRSQ5RhjTYQ+3Lf6dbu=radMm_m8zDRMB8GbQ@mail.gmail.com>
Subject: [PATCH v3] dma-buf/sw_sync: Avoid taking references to released fences
To: sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, syzkaller-bugs@googlegroups.com, 
 syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The last dma_fence_put() can drop a sync point's reference count to zero
before timeline_fence_release() acquires the timeline lock. If
sync_timeline_signal() takes the lock in that window, dma_fence_get()
attempts to increment a zero reference count.

Use dma_fence_get_rcu() for the temporary signaling reference. When the
reference count is already zero, remove the point from both the ordered
list and the rb-tree under the timeline lock. The release callback will
see the empty list link and leave the indexes alone. Removing the point
here also prevents a retired entry from blocking or misordering later
timeline operations while its release callback waits for the lock.

The timeline lock prevents the release callback from freeing a listed
point during this check. For a live point, keep the temporary reference
until after dropping the lock, avoiding recursive locking through
signaling callbacks.

Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during
fence signal")
Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076
Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
---
Changes in v3:
- Unlink zero-reference points from both indexes while holding the
  timeline lock, addressing the ordering and debugfs concerns raised
  during review of v2.

 drivers/dma-buf/sw_sync.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 8df20b021..261bc98b1 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -221,7 +221,11 @@ static void sync_timeline_signal(struct
sync_timeline *obj, unsigned int inc)
 		if (!timeline_fence_signaled(&pt->base))
 			break;

-		dma_fence_get(&pt->base);
+		if (!dma_fence_get_rcu(&pt->base)) {
+			list_del_init(&pt->link);
+			rb_erase(&pt->node, &obj->pt_tree);
+			continue;
+		}

 		list_move_tail(&pt->link, &signalled);
 		rb_erase(&pt->node, &obj->pt_tree);
