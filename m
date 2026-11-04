Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA5606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rC6W7UrJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37581112C42;
	Fri,  6 Nov 2026 09:18:48 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5640210E291
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:41:57 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-53dbe9b8d6eso66615b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 14:41:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793832116; cv=none;
 d=google.com; s=arc-20260327;
 b=gsj1MgP+2VMiHy6m2FxqKTJkzRR/x5KxZXMblbIL05hn/f9Xd9rq13e+XJ1hzBHRYl
 LjIvDnpC/eX5r2xex5VcEceX2ugHSqDBsNWsRhMVKAsNB07w10puPZqGVUk+Med9ywUs
 An0ZmAzAil2QZAiEfjjw6H4/Uzk37WR+ogRE4NwDlxltgUcJpxcZDIm0PULg4yE0xJP3
 LuSHpk/yEJ2UTfIWgas2vUbP9QK1lp6ZsYxGH+GNtdzlfXntijastYRUWO9WLvBy0C1/
 fQnZtp+J+nhxaSCW438V8Ht8R4scqLi1XxS61D4rSxZOIsRTYft/WxO72BY3sp9b4ISZ
 DThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=BYpBQ353zIhpm175VcNMdcPp6xP6hMG0uG7gLNUoCYQ=;
 fh=B0p+gFy9C+0HEWOwhNiauj9LLZqQbmGd5k85H0yCt8o=;
 b=khLVOPPjEirHDoZU90rQVxofzfeGm0AyQH96oA7lY5xez9oA26SwENaBNPeuK7xuGg
 ogoc3KBuQ+GM2y9oaoRi0JqO4SriIXt/pfJfQComoVjR1cQ+wIApG+b8ZpvWMLC3JxST
 HX60lTYm32GNzTI7OIe6hqLWbcLQoxb2Q0Nn/jIDQ3ykhXH12BT1lLgXAX4e/tgET65d
 BeWPzXXrSVX3iBlzgq0UOQGf3VjrpYr4+WwEfsOLjFulJi06iV6XCSt3OhaR9S98ej81
 W4zcgLmRq3quLSziLMLhetidYj4duzHFqwRIZ06CVtFSb6P81U75zjOcp1u/lLaz2GUm
 ofvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793832116; x=1794436916; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BYpBQ353zIhpm175VcNMdcPp6xP6hMG0uG7gLNUoCYQ=;
 b=rC6W7UrJHBUc6STDrWBVc8GlfVM2kuqLRpbrdGKLlr8kGTGrbgsSuJnoC8HnwjoSW7
 ubbvpAo+v1JT8GkXgyqW+YMfXqEfjn44d0IBsPZW6jRqpUeScMrBgW5Vdr1/MBZsCXUo
 j83Qsuz0wokksnxwKfIgnRx/gghCpBo5NDpluhBDll/uK50Of63f3jLjwNzCcF6bSx9w
 M8WzBYFohBPTFvvLhkvoyNZ/2Lq/81Rn3eyU/gIOq7o+pX+gcvyFezJIlG4UO6zQlL4q
 lMC2ZkKdDQ9BBowoibkD4FojCjV0XJ+3cu8KKYg1eelpcMgjGScW7I93LZEt0RuzVn6d
 tajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832116; x=1794436916;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BYpBQ353zIhpm175VcNMdcPp6xP6hMG0uG7gLNUoCYQ=;
 b=OzFHOf9O4LQ+8v5Z8NyLZJIzSYKnhrkgB6xfKg8IrspFvxrvBdpIbpgdj4hmdPAiu9
 4vO90JQ4vqpdXL+8c1MFqx39zRP2c/XKgzcPJskrwXtKGoQ/rTGbSLovgjhepToc0omd
 EfTcEXTUk0ZT3gkYFjnXHSf9uhklCh5Rm5LO1DTYSDG+Kdm9rtKQsMJaIWkYgVO7hh7U
 UJoFn49tMGwQS1ETbuOX71uvQSQYkcKQoxG+uVAA1EDqBfpYjptWwu/zVevMV53cvRyP
 UCsD6lo0+hTg+Yqbll7kQxRE8EkfUm9SPXELJWrBCOXfscKIfF3tBBIqX3bn9h9pivlh
 uY+w==
X-Gm-Message-State: APuU4Z9L8FEYM9IvcLoQOyGJi7NoBNQYRmfAHa2+Pa3YZhBWWPi8IkMm
 tUA4ZPV7F7gvYSm9p56G8wrVBU5xwdo+7llfOvdMZMm68MkwnjKBlLYEnsF2aUADnvjUhxuM5Aq
 RE4yHDO8UMMq7tZiSsEKm8PhFA0zuDOI=
X-Gm-Gg: AYBFou2odU4TgOjeIxLFEl7oGSmJ0x8mTYaCxFpNZ34kGxax4eOFEX9MXRaR8c8HcVf
 1OUQqtOt3dhd2AnCbkHr9/8ie9xr4/8ZlxAuhuzD8kRI2492+FcvmxVslTMcoXVOJ5+bPibIFeD
 6JIDAEduBWlrTPvj4Pi9RKdKKtYAOOjA3uwQr5+15/0WTAAEzepcWoL3wBHULyMyNVbzspvp0je
 niQKywJBIHrE8oq62fleeIwi+KOYai8BxaTMPIKmbZBhrugsVtGehyUBt15BWe32wQDMgPz8R2u
 zHGZX4ZcAmg+mHbgSE2SRyp3MRCFObOjL5GmQ/cbSERGN8sVtjlVTPRKUJ6vpQbsMI3fdpfvlsV
 nyvzS2eg0k6VGAuccbvrHiQL1260a3RzF2A+uwdimN+cFbzMJWEBQ7DgB0qJ2Rz6EUZt6AYQ=
X-Received: by 2002:a05:6808:6615:b0:4b8:4703:db8b with SMTP id
 5614622812f47-567be491be3mr630414b6e.20.1793832116524; Wed, 04 Nov 2026
 14:41:56 -0800 (PST)
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 4 Nov 2026 14:41:54 -0800
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 4 Nov 2026 14:41:54 -0800
From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <CADZg-m3A_i_X0L-UBi=eMEx7RzhR_sqU5NVLrQ75JJdR=2ASKQ@mail.gmail.com>
References: <CADZg-m3A_i_X0L-UBi=eMEx7RzhR_sqU5NVLrQ75JJdR=2ASKQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Nov 2026 14:41:54 -0800
X-Gm-Features: AclHuK9q0DstbFq8CTWr-e_98cCwTuTXDKvqxHLH8rzqGH0pREtNGc9JRBFGoLg
Message-ID: <CADZg-m0hnuZ+KpqkUgwZvkhjUdN24syvc8qxuR+oZC5rkJHSNw@mail.gmail.com>
Subject: [PATCH v2] dma-buf/sw_sync: Avoid taking references to released fences
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The last dma_fence_put() can drop a sync point's reference count to
zero before timeline_fence_release() acquires the timeline lock to
remove it from pt_list. If sync_timeline_signal() acquires the lock in
that window, dma_fence_get() attempts to increment a zero reference
count and triggers a refcount warning.

Use dma_fence_get_rcu() to acquire the temporary signaling reference
only if the fence is still referenced, as sync_pt_create() already
does when looking up an existing point. Skip a point whose reference
count has reached zero: its release callback will remove it from the
list and tree once the timeline lock is released.

The timeline lock prevents the release callback from removing or
freeing a listed point during this check. For a live point, retain the
temporary reference until after dropping the lock, preserving the
protection against recursive locking from signaling callbacks.

Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during
fence signal")
Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076
Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
---
Changes in v2:
- Resend as plain text after the previous mail client reformatted the diff.

 drivers/dma-buf/sw_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 8df20b0218a9..7f1eadee4cdf 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -221,7 +221,8 @@
 		if (!timeline_fence_signaled(&pt->base))
 			break;

-		dma_fence_get(&pt->base);
+		if (!dma_fence_get_rcu(&pt->base))
+			continue;

 		list_move_tail(&pt->link, &signalled);
 		rb_erase(&pt->node, &obj->pt_tree);

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
