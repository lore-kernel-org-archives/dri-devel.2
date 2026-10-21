Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BB60A6F77
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm2 header.b=RrD+Fnjt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qBgqKCYl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7309810FC66;
	Wed, 21 Oct 2026 08:40:17 +0000 (UTC)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE5910F997
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:40:04 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 10012EC0231
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:40:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 21 Oct 2026 04:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1792572004; x=1792658404; bh=R3wC1JPd18
 KvPMWWOaNn6dj8NYQPZH/iR9+7PTFAozg=; b=RrD+Fnjt702H5uTiBWvupeXSZj
 qTdyIvI4zz1GeM7WzQiSIky0Aul9mzU2HviWFZCDPZBXxDUyrSdi0HCwDahPxuBb
 RmZbxwvvEbRrgPaosKThAfBpG0CeyC6lj8B0q+Ph6uu1VBYqdaIEben64OUIORE1
 nN5hjlggnMKOtJMkbV5njmgV/wkBnoLpHDUwvJXu722i3k3mGoP8S5IQ3JRPtskL
 TBxFOmz/2Fdw+s5bT1jx6YzUA5XhsZVqQKO79ROZ115rHMg/eRfsUf49EKa/hi6r
 379E8lTEKiUK6v7I3jmXco64Kr/TXSr0htl8DwjW+dimmWYxBKbHq/gy7ZrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792572004; x=
 1792658404; bh=R3wC1JPd18KvPMWWOaNn6dj8NYQPZH/iR9+7PTFAozg=; b=q
 BgqKCYlP/QpRKUTOJcxDIDbuHLKa+TDNXnyuunR1PZMe68qbGJCFjeubrc+AeFRo
 Wreyw0eR17heWm8+dvvK7PP8qfAkhG630ere3WI2u095nub9bx27AGJudMZe51AE
 FpX4SdCo/92YhG/YtrgXeNRDF8gqGtE6SW8HQnenDUcNAHzePaCskDYzMzU/OQL7
 JKgWZ8WDBZfSjRoTVb78qEjwgrm/f/Uf6+3nTliUH7F3KnBdZ9P+4poxoN9gXt1a
 r6hRshnWSnCrDWcA9GKit3x2dViCKolnzzVqmQYa40uyVqujKcddYpt2DIKjuQIx
 2G1/foMEGUU4G1dhB1ezA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792572004; d=invisiblethingslab.com;
 mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:c7TpU5Vk+ibw5TjV7Katob4IH/mfOv7tIPNjx2fRcGLtetq
 ylWbgy3ZHQTn+hJdW+kxGn3U4vNij0NLeDC/ZH2DjBQ7uaca+I/QU0J6eZnvIdO9
 nx09aUnc5cIZP4fa1wKDzTmlftyCBXDbqiCgbweRM5MZYdEBVOkin7NoGPq/ekI4
 BGk5N7zCYM8R2CGkeCyhhQ2ftO6GsrdE+fAY7+diAcUHlzuNWhbPmZxw9uAFmnaY
 BaBm9wMs4ZS9clDqnbok6I4rlcv/skT/J+Zz2BF7xnS6lcR5neiGFKX5gomeRx6u
 6xTOqNwTau4VD2XtjEPqSLcsLd5qRqbyf2I8q5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:y26MGpA102mWR2TadjRDKL1Mv+2OFyq71aY+/6228Qc=:a4kf+vVraiqrr1PQbOh4rjyht/6Hl0n1XbpxcyRmQbY=;
X-ME-Sender: <xms:Y3rYasNt3gWyGEymAOeCJcEkrOLFirTPmtmIIiRa3HWSakAsUijgOA>
 <xme:Y3rYatD4_zibLhLwnpvdKiG-bnwB_D4QHvB3sL_taE_aY9sRdiMEBKstgWOrDtDKx
 Pdj-CMSsXz_D0p0xuFnxWjAdMGJSvR-PDMMZAssgt8Xf0A_Tx7a>
X-ME-Received: <xmr:Y3rYaoMc8gvQTyH1MyfsvjQ9W_wv-MVMAEvgv3r-cdQfmcFoLIuWTJuJGL0u-WqWlmDUE1_gfYRfydGyRbPJ6Sj5uEVhiMUZqUjNL9bRWAmMPTrnNXWo2k2NiQYfkA>
X-ME-Proxy-Cause: dmFkZTEPpr9PTmsu9mAqZaSuT5MxI2aubm3CsxGChrzKRK91OcndI/l7tJu+NMEFJuF0DZ
 GIiG+h5CR2GBKlA0T/mp1bK1eBlDsJyhFQghHgjGPJfWYZdhrTajibc3jm8S6Oux7G0ma1
 rqzQ2K5cDJrtFRlHSZ6HqUynScBfpM0jZYeQjV2P472PAQel6yNLh5LOSuLqRkCVXa+OcW
 6BEdzTV6wF3MCTJQ7+niRd+bRSEMLL21FPX1EAjFDCQqxTUOlBoYC3NrdTEhVBgQ1sGASo
 YJvaNNZQyZowva7JsrV36YyECAepm1VSeuwjTLpifU9a7/8IIN9f6oPhmhrkB4GkQTMXc+
 9fxZv+qBLXsS10fDy+9tbFT/wSmfwiQ3K0IkB6M4VK+q6uK0Wo0J9O7U0CprHzp5+majco
 4mhA+LxWbAL03Il8PU0dIYFegZjLGdsjFmTwbxX3BCRN0fiDOoQSDOkORtv3Hg3pv2VC04
 +uxHK7PcSg4r+glfexNPOsI512jurmnTBWWaETwx8eACwmps269eZZinLYXAYiI40PCMyr
 ocVFchvE8Q6lopsx4a2oENuCVve/R3oJnbwyTcJvkPV3oHxoXCqaFo0j0gMl/X+7pzLrso
 qFhKZc4TVnFDXNd/GG11Oto6XTWfiF3+mPa+tO612T1TpV9nJUJqrhGOGFjg
X-ME-Proxy: <xmx:Y3rYase4Zfh2QIGcdVn19qr9dIhRkpVcLiAPXd428GieotQAemiZvA>
 <xmx:Y3rYah5qjK6Y-oFesMZE1iP-zL8ZIIylEbR26RabU5T1VBISgSvS1w>
 <xmx:Y3rYamJwPxhICz5VeN_UEhmz6neeaPUhNDXNlleA0tU2k0wd71_1yg>
 <xmx:Y3rYajUt0xjIJciussFxJTb42_lt_9-5iWyQFT2ObNfzifgHyxaSUA>
 <xmx:ZHrYaoVs9OfgGCQzYodvXhDgaOmW_YDXKoWffSp6hb4lqHR6zRA7_Gxo>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:40:01 -0400 (EDT)
From: Val Packett <val@invisiblethingslab.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Dongwon Kim <dongwon.kim@intel.com>
Cc: Val Packett <val@invisiblethingslab.com>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/2] udmabuf: Fix list length overflow check
Date: Wed, 21 Oct 2026 05:39:11 -0300
Message-ID: <20261021083933.1983894-2-val@invisiblethingslab.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021083933.1983894-1-val@invisiblethingslab.com>
References: <20261021083933.1983894-1-val@invisiblethingslab.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The udmabuf list length limit was made configurable, creating the
possibility for integer overflow that was not properly detected.
If the system administrator set the udmabuf.list_limit tunable to
a large value like INT_MAX, that would allow udmabuf users to submit
a list whose length would overflow the u32 length variable.

Use memdup_array_user() instead of raw memdup_user() to make the length
calculation an overflow-checked multiplication.

Cc: stable@vger.kernel.org
Fixes: 2e717a55982a ("udmabuf: configurable list_limit and size_limit_mb")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Val Packett <val@invisiblethingslab.com>
---
 drivers/dma-buf/udmabuf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd0046242..654ebe7f6b3f 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -470,14 +470,13 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	struct udmabuf_create_list head;
 	struct udmabuf_create_item *list;
 	int ret = -EINVAL;
-	u32 lsize;
 
 	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
 		return -EFAULT;
 	if (head.count > list_limit)
 		return -EINVAL;
-	lsize = sizeof(struct udmabuf_create_item) * head.count;
-	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
+	list = memdup_array_user((void __user *)(arg + sizeof(head)),
+				head.count, sizeof(struct udmabuf_create_item));
 	if (IS_ERR(list))
 		return PTR_ERR(list);
 
-- 
2.55.0

