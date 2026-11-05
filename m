Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A02606D816
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dDKoht3Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27B0112C8D;
	Fri,  6 Nov 2026 09:20:38 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6ECD112486
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:26:07 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-84e513874f8so1431121a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:26:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793888767; cv=none;
 d=google.com; s=arc-20260327;
 b=GslJls1UGGhjg3ocWvLnXIVx3g/wBzOWzIBeQ1wrqwUJZrSdaLVLexLF/vFFeeRD19
 isABZG4N3ZFXBouR15QQ9RvjExoWz9XX7w8cwI3fMdBEYk5xj+rLoFEHKnW4MFUYji5N
 QaZBRGS+M4s0vvkWWRPqVZRuniOgM3wr7PACam1jLkI6K1KOZB5oAwDmsF6zBVhf5IKW
 GHRJgEh+rjZhGcJ33nso0NYICS3PcUlYQnBsGHRiZuAJt5IN/lTPAo9HU5eWaHkR45Hv
 UKzqp3Cucdy9slM2ro0M7L84MsY2vTfZRc/e9A0IzIm7CeNc91cCGOYBJoE8f2sUjJpV
 T5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=VL1FDtV7Y/ilxiUTM4V+mDRqqkZcTL/181qTv0CNS1U=;
 fh=tvXqeo79IYKVni/zBcIPMW2+Kcmbyj2OE0uIe0Z4aPY=;
 b=nhHEc0abEY0BETyGQ6hkN33If2beEjUkWxFsD8GnxlOcb+bZ7Qy4g3O48wEJtYZRdC
 ULLGarOkocG9tcm70oy+NMtoZV4lI6fU4jn2uedURJOcCVZZmxqv/+f1kSMSaGayuEOz
 4uasjhKhbJ6Y8WHKv4ngy3NfoKGoify2aE1qmAZ9wQLOgtHaewdpCvvyPrCKmGiU+Iwi
 hADds+tu8I28qV1ALzSmJutrDVmbcAgf9xTxKFQrYpqAItDZyZXtP9yEPtqzTITt0RP0
 bzsme5J7IXyd3NjW5hYf2xKTo5iq0kI7Mp2AYdjegg07KI3WUAHmYPgjl2KrDCHUjFZF
 Eq+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793888767; x=1794493567; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VL1FDtV7Y/ilxiUTM4V+mDRqqkZcTL/181qTv0CNS1U=;
 b=dDKoht3Z9FSfkRY2BSnbjXCxO5xljSy/EKQZl93N3luY22cQJxTyf0gw2G/o2tvmgR
 LJL19EmzeY9CghomepgyGFH4dxTIb3ENCNNHE5fCtY6WB3xN3NAkMCxFvQFDXMmHEpfy
 ukFnOwapG286Xh04BlYcO9KHNSEV8ZYc/383whMJ9/Vyekz8FHqpkrswq9feKVO01Qtj
 se5QlLrO9HvGYg0L6qNT86J70YQWUvVBJoQoqvstB+7upmYvdfw8TfhESQG+2ztj/y4V
 kuHj/JLmOTU55xlsoWTbzRpkRQ5+5aF6we48ALRrxHFEwsd5cps+lpjuBvQXhQxMlOL4
 Pvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793888767; x=1794493567;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VL1FDtV7Y/ilxiUTM4V+mDRqqkZcTL/181qTv0CNS1U=;
 b=HrkjmpL/WOcDu+EH+foLqOUBWvdmTOv5FGGuiDN+KfVy52i+gdTFZdcM6Sdlqxosax
 cTZF3yi4ihWuNexg1v2DBTkCixjIGccWH4UOvt268Zi9Gj508QgBwGA4QX4t+KTmKJfx
 YkTBcpL+tXfuzANLZMrxJTm3aKgX1KlRgHbILBTEs9cHRWR5zXLLrp+u/NJElHGbNkaK
 PylxXv5xe6xrL8sZgXhS+Sspqrhuh5OwWgZDmTC8J54h9Ds6M9Sg60iJRN5lUDnAIDJW
 ejUI9YGDR5L93O6sW73HRdMzB/MGezRtCDk3trbfeuerohq0kJoa6BjXk/oeNBklRRys
 uuXg==
X-Gm-Message-State: APuU4Z8Ve6FcR6kkVQLNXmOS1IWkrljRWJN+WE78XywqZ42j7oT8BIub
 p73pE7sUfYHxgOmY25GiIoIT/KqloDEx1FlU8mWLkvgf7iHnwO/lsWKQbdcTYY7sglyHHb8tr/w
 eAMqhrqv3reznFFrbSxRsmVfUZVZZ7Ug=
X-Gm-Gg: AYBFou2X4NAfcOrSu13UDnmHLOtomQO3bjIZTLPcGid6/Tm17RHveSzaaCnFWpVatLB
 FoBvGAWWHGwLQh1Jzmxdwe5phOctEe3qyesRpT3BFCjl9zwr/Jg/sTfJiH69WpyjJUMdQn66Jbx
 AeUoKZ6zpWD4HG+zMxtzPERz/BcyKcGb1YFiv34zP+p0Y5HrEWYsh5fLaSK0UhfKivOlT/h4TaV
 Vjaf4OBJmehXtrGL2RsZ9cQASe1TVqC1S/zoou8n8Ci8vNO52SHWQz1/blQ9iuByoMnQj9WTCRB
 LFDqwdEe16G15rRzo7YMGQM2H99o/NVtrvOQz72W3gGedeobVlju81nx3ynx+x01CPe8b7jeo5L
 TtUZXkDWlTDYEBMjlNyMENR+bNWY10TzUVhLhi3q4WANwtGZwO8P4gC5/qNpq4XIOTib6jh1T7V
 FIum7ZE0aRJpHSiMWP
X-Received: by 2002:a05:6808:e552:b0:4df:5cd0:89c1 with SMTP id
 5614622812f47-567ad730dd7mr3269297b6e.23.1793888766835; Thu, 05 Nov 2026
 06:26:06 -0800 (PST)
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 5 Nov 2026 06:26:05 -0800
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 5 Nov 2026 06:26:05 -0800
From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
In-Reply-To: <CADZg-m3HZ8qpXdRSQ5RhjTYQ+3Lf6dbu=radMm_m8zDRMB8GbQ@mail.gmail.com>
References: <CADZg-m0hnuZ+KpqkUgwZvkhjUdN24syvc8qxuR+oZC5rkJHSNw@mail.gmail.com>
 <CADZg-m3HZ8qpXdRSQ5RhjTYQ+3Lf6dbu=radMm_m8zDRMB8GbQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Nov 2026 06:26:05 -0800
X-Gm-Features: AclHuK-epezXRH_mIvBZpgTJ0vJzN6LMMC6JgC10AOGRuvl6mSY4OPCNVkh8YdQ
Message-ID: <CADZg-m2pL2rY7ptSSD8OXWGPrAJx9Yn7N25HNYGonWNzMKysDw@mail.gmail.com>
Subject: [PATCH v4] dma-buf/sw_sync: Avoid taking references to released fences
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?B?Q2hyaXN0aWFuIEvDg8aSw4LCtm5pZw==?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>
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

Use dma_fence_get_rcu() for the temporary signaling reference and skip a
point whose reference count has reached zero. The timeline lock serializes
with timeline_fence_release(), keeping the point allocated while its
reference count is examined. The release callback removes the point from
the list and tree after acquiring the lock.

For a live point, retain the temporary reference until after dropping the
lock, avoiding recursive locking through signaling callbacks.

Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076
Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
---
Changes in v4:
- Document why the timeline lock makes the conditional reference
  acquisition safe without an RCU read-side critical section.
- Leave list and rb-tree removal to timeline_fence_release().
- Drop the Fixes tag because SW_SYNC fixes are not intended for stable.

Changes in v3:
- Unlink zero-reference points from both indexes while holding the
  timeline lock.

 drivers/dma-buf/sw_sync.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 8df20b021..8aa3ed777 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -221,7 +221,12 @@ static void sync_timeline_signal(struct
sync_timeline *obj, unsigned int inc)
 		if (!timeline_fence_signaled(&pt->base))
 			break;

-		dma_fence_get(&pt->base);
+		/*
+		 * The timeline lock prevents timeline_fence_release() from
+		 * removing and freeing pt while its reference count is examined.
+		 */
+		if (!dma_fence_get_rcu(&pt->base))
+			continue;

 		list_move_tail(&pt->link, &signalled);
 		rb_erase(&pt->node, &obj->pt_tree);

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
