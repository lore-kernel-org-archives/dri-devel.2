Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99A606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KqqrS4KF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DC31126DF;
	Thu, 19 Nov 2026 19:25:48 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E532A1126DF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:25:41 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2f022026e60so597225ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795116341; x=1795721141;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
 b=KqqrS4KFlbbGAylVjCsQnj52BXpwldR9nxu1XEXF1lTMgylnSVHg39Kxxabksxs009
 i+CO8u9+jivpHATu3NSEU7/yiRaBZlx9lfJx5MDAIBRwNtqi6C9QPLpv00aK0HKy8T/J
 gy8rmiumoWxBOH4zGyPlyhVPt/R6RZK6P56FlK+lcWaB+3brYTzJIznZeN0xVOb97wwk
 ZLQR1oh9IkdpRYLTm7Eb2Z+fJyL86GQ1+jDLQQSx39worGR/88NHiyshde/8V5guW19q
 okTJ+rheHr05RmYNwiHvvhcLFoz1jlAQW4sse6fQEOgEwfJKbZvQ4C7FhPdka3QVipWw
 SOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795116341; x=1795721141;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ALLBk8MdTkFwcPZqYQO+ZVSicu8jJEanZFGqZFoBPVY=;
 b=2XqiFdT0Ovi+rke+2p+cR6CXtjibhjYvSFPak4Qv/DVGraP/zIu8lGyG0+u6gxsC1f
 /Z1KInht5UMZDeVtcCSviMkTgdH1+rTqP6v5ZIoUi8XGpxZU/tMVCmS3NEJpT9VC86yV
 Zu/biYZVcrgUNhoezkPc7FPJL8aGe8HqOS9VSpfKIqCK3pd86JfcdfLCndZZrjhLnYlJ
 RxNvUI58ZJOo9YlV+bvkWbi6JjSoYaDXR8fA7SPv0Q2uS3UIMzofxCcfqMoy2bscXn0d
 vt8iODiyulS/9KRWV7LAjupYin7aooo8DcNHiGYFx6Qsi6xmOdgXnAqEvGusfxCIAPk8
 SqLw==
X-Forwarded-Encrypted: i=1;
 AL+hErEO2DpstS/rzhxe9oAq/OOZGMqz0qePOGTxUERBuKl6DeVpno61iKpU3tTmStHd5T7Z/F+t3uVYcY8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ffQSGNi1n2MPW+H8y9frzCrJaf7sWdaPjWUCITtZRlCF7Xxxp
 4jtbqLhSor0xQmGQTBmHo9d30AjA3QYMYCozdS7kN1IlIGFVLdIv4V/5lxG3fOalc8Ek/yi7jaO
 AJPuxfmtlfQ==
X-Received: from pleu15.prod.google.com ([2002:a17:903:41cf:b0:2ef:d860:1c85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fda5:b0:2ed:fb0:bfd6
 with SMTP id d9443c01a7336-2f031e08699mr15736045ad.11.1795116341051; Thu, 19
 Nov 2026 11:25:41 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:14 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-4-irogers@google.com>
Subject: [PATCH v4 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Srish Srinivasan <ssrish@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
 Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
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
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
2.56.1.708.g77570a6a1d-goog

