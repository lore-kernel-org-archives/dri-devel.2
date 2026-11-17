Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E7606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XUC30gOj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA5C10F737;
	Tue, 17 Nov 2026 13:28:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511A910F710
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bq6R3BqIosLVAUzNBGUDBPt6z67HPJp6MUmEltWOs20=;
 b=XUC30gOj5UCbvXsfoXG0tmxDaOeLTlQE0zfMs2GOyf7+HnzCMS9fyvgxG5wWBpkh3ekmAg
 sL331ZYZUWhJryXFSBSLrVYZDaMJFnTYuIGMBLC8pMnYxvO6U8e5Ivtl9PqSYcVDHi0Hth
 VVOtonWVKLqXkOTtm8nnQwuP01lQw5s=
X-MC-Rep: binary re single
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-xzZPgCPEP-Kgpmv5Om80EA-1; Tue,
 17 Nov 2026 08:28:08 -0500
X-MC-Unique: xzZPgCPEP-Kgpmv5Om80EA-1
X-Mimecast-MFC-AGG-ID: xzZPgCPEP-Kgpmv5Om80EA_1794922086
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E45801955F54; Tue, 17 Nov 2026 13:28:05 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B05E8195B3C2; Tue, 17 Nov 2026 13:28:02 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 17 Nov 2026 14:27:47 +0100
Subject: [PATCH v7 2/3] selftests: cgroup: Add KB() helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261117-kunit_cgroups-v7-2-5bcbfe17f323@redhat.com>
References: <20261117-kunit_cgroups-v7-0-5bcbfe17f323@redhat.com>
In-Reply-To: <20261117-kunit_cgroups-v7-0-5bcbfe17f323@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Maarten Lankhorst <dev@lankhorst.se>, 
 Natalie Vock <nat@pixelcluster.dev>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org, 
 R Nageswara Sastry <rnsastry@linux.ibm.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794922072; l=832;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=io48fDca3BBUAIFe/tlBE5JydAIJrbrMjKfgVtDHM0s=;
 b=VpmN8iP/Oogl0zCSUe2jFV/1Us2cmshcuya+GdRv0gTE8YNzsl5KjKhe/m+aK6WgGsnKZAz4b
 mnVfx3pUDC3ASamv564nd7NlaILXHMk8Rn8NbTUfJuAyEsUwyduAp6v
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: DeGFsJRmDE6KEkWcchbbDPE9bGcDSjYFnAYc0QdL5J0_1794922086
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cgroup_util.h already has MB() and GB() for size
literals. Add KB() in the same style so tests can
spell kilobyte values without in-code shifts.

Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/lib/include/cgroup_util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 5307f3bf32a0..455e52a516da 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -6,6 +6,7 @@
 #define BUF_SIZE 4096
 #endif
 
+#define KB(x) (x << 10)
 #define MB(x) (x << 20)
 #define GB(x) ((unsigned long long)(x) << 30)
 

-- 
2.55.0

