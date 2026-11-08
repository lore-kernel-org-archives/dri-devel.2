Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309976083622
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GCojNfz9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DCF10E111;
	Sun,  8 Nov 2026 22:39:52 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1ED910E15C
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 22:39:46 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36cec75d8caso401608eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794177586; x=1794782386;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
 b=GCojNfz9hW/94pt4pOCvqXASs0Wb5wbP+N9NIUihplJKFdb/6UHcbF2M/0mDiGYi/f
 jC8uRChq1So/dxMyWQrwEgkI19P336hOOwArts0xGaiN09YrCM/QpUIlp28axp+H0frz
 x/YiiOej7HpGpMNa8BZSZeEazFtPzo/GP3Nd1dP7JSPI2ydrLt9W6bQVnJYzXPOW3Aw4
 0nueGpdvY/KB77iT7Rn7wEkx2T7mKcREBisISfhmIlP5Cb9t6m/2CQeitwJRk1Xh2LXW
 JO4wgPbH+J8pWdsmCI1oSfqCAMFJBLu0jO29JuQZbgsqw7jaVIlxsrcXMoHDWeeQkfHB
 lJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794177586; x=1794782386;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
 b=gNs0M/pLpKDQ2fI85+oqx5kYI3xX9Ds1G5gDne+G12L0uKzolbYQIZjsfjJOdZJ/l8
 D2LiWNhgSMqPbYEbJmmq3kXrV2hTzlLHjHev/lXpzcHRtecZBggJiahzPUhc6nHpWR3H
 Ka+fqsF3X/54cn48UKaQ+W/0fWzeI3gRAuD9byAY8ovBpOQP1JUEn2uq1buOrvI6VQ97
 PN1Rg2AbpVtRnDxW3a8iDLTaYiMp+seBr/lKAHnHZNbaZynrAMOSpKxWKIiL4ymgp8q4
 gbdCLzLJqGu/cpA8qe8HAlH9se9qdsS9RXXez5bJKTKLOzs1E+mfmERsO1NWmLdogKLS
 Xd6A==
X-Forwarded-Encrypted: i=1;
 AL+hErGxNaDR4wVMJr/KWBtWm0Ob500SHvFCvvHcI3GK+s/FPFzqD+fwDsGa313fr716XFtq2J4xrkkF1Nk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9xdOgJ01f/AJedKOQGRWUE2cNfW7jo4cvSRuJ/D6y9+cgynYtE
 irVwDWEicP7UqBAlvFtL30VPByYN3pugEmFLIKY8lTL6grHv56+AodncqYAq/rIBpE+KX6n7KGj
 gpZVCgJuo+w==
X-Received: from dyx10.prod.google.com ([2002:a05:693c:820a:b0:36a:eec:f68c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:c00c:10b0:36d:dcdb:70c5
 with SMTP id 5a478bee46e88-370f7b8f918mr9710009eec.20.1794177585797; Sun, 08
 Nov 2026 14:39:45 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:07 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-4-irogers@google.com>
Subject: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Alexander Aring <aahringo@redhat.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog

