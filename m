Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014FDC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E48210E73C;
	Mon,  6 Jul 2026 05:24:50 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5064910E2F7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:24:49 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-0n8T6XdSOZepQ-G3iAro5A-1; Mon,
 06 Jul 2026 01:24:45 -0400
X-MC-Unique: 0n8T6XdSOZepQ-G3iAro5A-1
X-Mimecast-MFC-AGG-ID: 0n8T6XdSOZepQ-G3iAro5A_1783315483
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D8EB1955F04; Mon,  6 Jul 2026 05:24:43 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E19B1956096; Mon,  6 Jul 2026 05:24:35 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Waiman Long <longman@redhat.com>, simona@ffwll.ch,
 intel-xe@lists.freedesktop.org
Subject: [PATCH 07/10] memcontrol: allow objcg api when memcg is config off.
Date: Mon,  6 Jul 2026 15:22:36 +1000
Message-ID: <20260706052330.1110909-8-airlied@gmail.com>
In-Reply-To: <20260706052330.1110909-1-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gYZTymVmqezLfPDaOnnApk76om57n9VQBsNU7NFoL8Q_1783315483
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
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

From: Dave Airlie <airlied@redhat.com>

amdgpu wants to use the objcg api and not have to enable ifdef
around it, so just add a dummy function for the config off path.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 include/linux/memcontrol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9d057f58c9d0..100b87d9652f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1827,6 +1827,11 @@ static inline void __memcg_kmem_uncharge_page(struct=
 page *page, int order)
 {
 }
=20
+static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
+{
+=09return NULL;
+}
+
 static inline struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *f=
olio)
 {
 =09return NULL;
--=20
2.54.0

