Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C3C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA37710E72C;
	Mon,  6 Jul 2026 05:25:00 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C227F10E03D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:24:58 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-BEICEeGOPuSncBVo-QhgQA-1; Mon,
 06 Jul 2026 01:24:53 -0400
X-MC-Unique: BEICEeGOPuSncBVo-QhgQA-1
X-Mimecast-MFC-AGG-ID: BEICEeGOPuSncBVo-QhgQA_1783315492
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1B30180065D; Mon,  6 Jul 2026 05:24:51 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FC411956096; Mon,  6 Jul 2026 05:24:44 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Waiman Long <longman@redhat.com>, simona@ffwll.ch,
 intel-xe@lists.freedesktop.org
Subject: [PATCH 08/10] amdgpu: add support for memory cgroups
Date: Mon,  6 Jul 2026 15:22:37 +1000
Message-ID: <20260706052330.1110909-9-airlied@gmail.com>
In-Reply-To: <20260706052330.1110909-1-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wqe4ixJYyvmTG50Kn_graJkECi1S09A-GcFpKMdBiHc_1783315492
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

This adds support for adding a obj cgroup to a buffer object,
and passing in the placement flags to make sure it's accounted
properly.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  3 +++
 mm/memcontrol.c                            |  1 +
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c
index 6a0699746fbc..38f8b3300989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -188,6 +188,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev=
, unsigned long size,
 =09bp.domain =3D initial_domain;
 =09bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
 =09bp.xcp_id_plus1 =3D xcp_id_plus1;
+=09bp.objcg =3D get_obj_cgroup_from_current();
=20
 =09r =3D amdgpu_bo_create_user(adev, &bp, &ubo);
 =09if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index f98bfba59a2c..e4fb1a1d699b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -159,7 +159,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *=
abo, u32 domain)
 =09=09places[c].mem_type =3D
 =09=09=09abo->flags & AMDGPU_GEM_CREATE_PREEMPTIBLE ?
 =09=09=09AMDGPU_PL_PREEMPT : TTM_PL_TT;
-=09=09places[c].flags =3D 0;
+=09=09places[c].flags =3D TTM_PL_FLAG_MEMCG;
 =09=09/*
 =09=09 * When GTT is just an alternative to VRAM make sure that we
 =09=09 * only use it as fallback and still try to fill up VRAM first.
@@ -174,7 +174,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *=
abo, u32 domain)
 =09=09places[c].fpfn =3D 0;
 =09=09places[c].lpfn =3D 0;
 =09=09places[c].mem_type =3D TTM_PL_SYSTEM;
-=09=09places[c].flags =3D 0;
+=09=09places[c].flags =3D TTM_PL_FLAG_MEMCG;
 =09=09c++;
 =09}
=20
@@ -654,16 +654,21 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 =09=09size =3D ALIGN(size, PAGE_SIZE);
 =09}
=20
-=09if (!amdgpu_bo_validate_size(adev, size, bp->domain))
+=09if (!amdgpu_bo_validate_size(adev, size, bp->domain)) {
+=09=09obj_cgroup_put(bp->objcg);
 =09=09return -ENOMEM;
+=09}
=20
 =09BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo));
=20
 =09*bo_ptr =3D NULL;
 =09bo =3D kvzalloc(bp->bo_ptr_size, GFP_KERNEL);
-=09if (bo =3D=3D NULL)
+=09if (bo =3D=3D NULL) {
+=09=09obj_cgroup_put(bp->objcg);
 =09=09return -ENOMEM;
+=09}
 =09drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
+=09ttm_bo_set_cgroup(&bo->tbo, bp->objcg); /* hand the reference to the tt=
m bo */
 =09bo->tbo.base.funcs =3D &amdgpu_gem_object_funcs;
 =09bo->vm_bo =3D NULL;
 =09bo->preferred_domains =3D bp->preferred_domain ? bp->preferred_domain :
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index 4d68732d6223..1bc757e14292 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -55,6 +55,7 @@ struct amdgpu_bo_param {
 =09enum ttm_bo_type=09=09type;
 =09bool=09=09=09=09no_wait_gpu;
 =09struct dma_resv=09=09=09*resv;
+=09struct obj_cgroup               *objcg;
 =09void=09=09=09=09(*destroy)(struct ttm_buffer_object *bo);
 =09/* xcp partition number plus 1, 0 means any partition */
 =09int8_t=09=09=09=09xcp_id_plus1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 8062b3d61157..1c8123c564ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -155,11 +155,14 @@ static void amdgpu_evict_flags(struct ttm_buffer_obje=
ct *bo,
 =09=09=09amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_GTT |
 =09=09=09=09=09=09=09AMDGPU_GEM_DOMAIN_CPU);
 =09=09}
+=09=09for (int i =3D 0; i < abo->placement.num_placement; i++)
+=09=09=09abo->placements[i].flags &=3D ~TTM_PL_FLAG_MEMCG;
 =09=09break;
 =09case TTM_PL_TT:
 =09case AMDGPU_PL_PREEMPT:
 =09default:
 =09=09amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
+=09=09abo->placements[0].flags &=3D ~TTM_PL_FLAG_MEMCG;
 =09=09break;
 =09}
 =09*placement =3D abo->placement;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4c682b91cbbe..625de4a287eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3032,6 +3032,7 @@ __always_inline struct obj_cgroup *current_obj_cgroup=
(void)
=20
 =09return rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
 }
+EXPORT_SYMBOL_GPL(current_obj_cgroup);
=20
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
--=20
2.54.0

