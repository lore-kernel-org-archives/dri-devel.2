Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AC606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m52ELv8+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F6B10E65A;
	Thu, 12 Nov 2026 20:05:00 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416C310E65A
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 20:04:54 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ea138a3497so1394575ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794513894; x=1795118694; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:references:in-reply-to:to
 :from:subject:cc:message-id:date:content-type:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WcAHgOOesRnpg5Fo7kmgrPBf3yTrJRhLe8HkoymNW8o=;
 b=m52ELv8+l3iKJMY1vN+k06UgcGGn3F3qQdXv5kbBTH9pfulDSBpqfN7AeM9ly7eaXs
 SabgiEHz4gg1nfubNVGymGbTvUEO6kQEIntgy6AZ3Bg81wAsEoMqEO7sPJ1PpGI9SKX2
 EshdTD2o0fd5ldEUMdhO7OEQNlK2ekobCGDEn6MDyuwblPQOHiXRgXx6/hamzc1yENt7
 XNEShgkvNn3nmKiPfipqLl7g9u6lERFZEckp278JY2tOn6GMXClG43K1gJGPfiSip/hO
 uJcrPQzy/sZ0bQQg/Xw1HD8ay4PSEaMRIRJvdjCf+Z5kjAv7CUZDt+gAJlMOGlGHype9
 +w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794513894; x=1795118694;
 h=mime-version:content-transfer-encoding:references:in-reply-to:to
 :from:subject:cc:message-id:date:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WcAHgOOesRnpg5Fo7kmgrPBf3yTrJRhLe8HkoymNW8o=;
 b=m+YuumZnw4WRq2VbrQDwz7/TYEsJ6Zur8VCgBURgclLM1BDPvSs+ZC4f/14ZCcJK2w
 LcSoDnz5tWJ/GzFozv/3yraouKFJz+lolfjgoO8sU31mBM25LqLrWVKhw8OJ3Fe81UE1
 02h+l7o6oc+lQ3zi6lhLj5NGpnna8uhRQ1pSnIPplQusTm/45r6aVjALpDyKw346FcPa
 EHeXESY42Ar5qwNncBDNMBmkxxnFfkFk4XXEI+rRPZbIBn3wws9yVs5L+Pl964Z0iE6j
 be6bMr31QHXqAQgyeEpRKWZBNHx9UjsxtXcVvPfu8YuK27t3m2WM6CADW3h2aw3+mBF/
 gVzg==
X-Forwarded-Encrypted: i=1;
 AL+hErHpTjtv/tIBIEh+o/dzhxbcXhpMwjFs33bfz+G0yvr9FqgdWFDuVQgS+yNmtv+8MIYZqs3wJxBLDws=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/O2qEd0itHd4Eh30kzJSqN7TADZZZ5OO0kUjdvSKxm/R0FdQyV
 rFc+fOtcUiQGvfM0b55W1Dq54WEUT4SeoRerBQz+dPe68IDeKM9Kp+5V
X-Gm-Gg: AYBFou2pwphRLdQM5I0jSvvmlPbfvIUhx0VYrbt0wKU7jXQ/h/7Wr03hZTm0ldTp2qf
 EezB+WeElyHdOwFl1YfnKYey6xxpUplv1SSimrsQ+QxHd01tp3PvGFjj8Hdt2ECpw5HUs/plcBF
 elFDJ4PiFcnIcyZhQDntogFFneef5BsC++7yBZZeS5OPI3JApvo3OsAxM6YHleO9DaTX+P7xEcM
 Dl+f0RhGaPENulLEs1+WpLQCOiSgAag4q0rdQHfNp8aC3HQ3VoqzQ5hz99Q3fntsldZwt2vgtJh
 Rcb2RT1QI/Smzpd+b4tDW7vQ0thbEhBt8j0r+VLs65b9ZQ7oc8hseSP3UsYJ1kKJcyPkLuYTYnh
 FtU7LosXDOUCEH1bjNWoeDNaG65wh3Um4n20TOPlsKnR0MgVRbjlBRZRBDDNT0tkMeB9dcyRtw0
 Zu5RB8KAiV6cmTE0fAfG/7X9H8YV3hhcyMaBl4T2lSY2PZaZtQT7w5cU5IZBFltreZCVs4CcwoA
 gKEkDiGDAdRV9IyrEGCxZSA3Gaz047uxJFBQGFayD98tcHpbD67kDeY6FrcInL2AdWWEpTsVjuk
 jLXEcWwRbI6klvv476avqy8dVBZhjfiT7ujKZ/2IuwmWUDpEW+zBf267IFZ5A9OxI224zo+3Ksg
 idhTKsIUvUNP6FH18z+OAsMpbSAsOXo4aUQ==
X-Received: by 2002:a17:902:fc8d:b0:2e8:79d:15ec with SMTP id
 d9443c01a7336-2ee0d664b70mr4529905ad.6.1794513893558; 
 Thu, 12 Nov 2026 12:04:53 -0800 (PST)
Received: from localhost ([153.61.198.249]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f75c980sm536275ad.25.2026.11.12.12.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 12:04:53 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 20:04:52 +0000
Message-Id: <DMTI31CK7EAZ.TT2P5ZN7BIVR@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Philipp Stanner" <phasta@kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kang Chen" <k.chen@smail.nju.edu.cn>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 04:51 AM Kang Chen <k.chen@smail.nju.edu.cn> wrote:
> +/*
> + * The iterator state is one pointer wide because struct bpf_iter_dmabuf is
> + * part of the generated vmlinux.h ABI.  Use an invalid pointer value as the
> + * "drained" sentinel instead of growing the state.
> + */
> +#define DMABUF_ITER_DONE	((struct dma_buf *)1L)

+1 to T.J.'s point re: DMABUF_ITER_START.
bpf_iter_kmem_cache_next() does it that way.
dma_buf_iter_next() leaves NULL at the end of the list. Let NULL mean
drained. Then no need for the 2nd store in next() and for the long
comments.


diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index cd50024..1bef87b 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -156,6 +156,8 @@ struct bpf_iter_dmabuf_kern {
 	struct dma_buf *dmabuf;
 } __aligned(8);

+#define DMABUF_ITER_START	((struct dma_buf *)1L)
+
 __bpf_kfunc_start_defs();

 __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
@@ -165,7 +167,7 @@ __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
 	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
 	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));

-	kit->dmabuf = NULL;
+	kit->dmabuf = DMABUF_ITER_START;
 	return 0;
 }

@@ -173,10 +175,14 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;

-	if (kit->dmabuf)
-		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
-	else
+	/* Once NULL is returned, next() has to keep returning NULL */
+	if (!kit->dmabuf)
+		return NULL;
+
+	if (kit->dmabuf == DMABUF_ITER_START)
 		kit->dmabuf = dma_buf_iter_begin();
+	else
+		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);

 	return kit->dmabuf;
 }
@@ -185,7 +191,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;

-	if (kit->dmabuf)
+	if (kit->dmabuf && kit->dmabuf != DMABUF_ITER_START)
 		dma_buf_put(kit->dmabuf);
 }


Pls take T.J.'s selftest as patch 2 and tag the respin as
[PATCH bpf v2].

Also you sent fixes for css and scx_dsq.
bpf_iter_task_vma_next() has the same problem.
It doesn't hold mmap_lock between the calls since
commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to per-VMA locks"):

Pls fix it too.

pw-bot: cr
