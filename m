Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB1606EE95
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T3hWL9ys
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54B110E15C;
	Sun,  8 Nov 2026 22:39:52 +0000 (UTC)
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A7110E46D
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 22:39:45 +0000 (UTC)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso923192c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794177584; x=1794782384;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
 b=T3hWL9ysFOENiWIZEVLAMNQfE5Wt+Uo0eFJ9EuFrRfKZuC07pgTwYKkLGhJzWVKzuJ
 X0xHyno8iwe0ehSWWoekrclx5y1AtnmBEb2SDRzSIwLGB5yzWLhZUeD/kocbM9EmjdgY
 VSpGCur6BpDPa0DOI/TH4sievgSlMCVY2Y/8s2hjgn8rB6rj/eJ0LGe+w3CnRz553uUh
 mQ4oVesavOy/aEWY8JOYgg5lcIDlbwmBOXjNUZgYn3irIGIHRSVBPd8hFPgSvA3WXsWB
 49OsBZzUPHnXukJax3q+Z4jjJL5p66aEBL9+uYuxm+OiMGPd6rCDQ5Jh0fMFsbcesI80
 W8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794177584; x=1794782384;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
 b=zjOIFzo4aMR3Ko3bHxqf+7YZtk4O0bTnRyHhAKvv4p9UX2nxUb+5e98rVEZtydKPbK
 4GDuKBw8n+kLp4wfTfHMG5hv9Bni5neVnphz41tw9kM5+R3nvF7brWloQ26E/z2viniq
 OmqTFCHkPrqtfeJODLyB8qESj/d+o8FMoasstTJjco4/1LyvYeW7y4aHH4qKa83wjEum
 FhMCi95XL92D7yRY2Mv+lJRH1OdzdZIZJQMXgMA5gLPutfJx0lqyDQriodIVdd+TevBs
 YRUOFt56Xm4m9/4R2WxY3nQW4Mduw7/x4CvZQIHhYZTakpID+gCGm6aUb6FnMdfzi5U5
 CE0g==
X-Forwarded-Encrypted: i=1;
 AL+hErFLj+p/KYQbTyl+3AanTIy3jl9ygxkekOXuDvLJ+7ThecooPCsAObuOEzeG6jcG3ObGAQlpgT0aods=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/S1gamk0lm0BRdBJagcRiehERs4oC2Bxa4D0no5/sLc5kwSkf5
 LayZfG3ToTGvbcNSLyYX9xU4a3V18G23exYjlR7rzVFLtzDZcE3aBoD43Gg9BzsecsPnZcycjVF
 mmKn7qY7j2w==
X-Received: from dlad1.prod.google.com ([2002:a05:701b:2201:b0:1b2:6421:f4fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ea8a:b0:163:bee9:b250
 with SMTP id a92af1059eb24-1b39fedbec2mr3348910c88.22.1794177583902; Sun, 08
 Nov 2026 14:39:43 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:06 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-3-irogers@google.com>
Subject: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog

