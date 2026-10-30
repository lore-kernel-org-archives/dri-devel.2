Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C966606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Auc7HiTU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9348510E5B4;
	Fri, 30 Oct 2026 04:54:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CFB10E558;
 Fri, 30 Oct 2026 04:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7149040543;
 Fri, 30 Oct 2026 04:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA4C1F00A02;
 Fri, 30 Oct 2026 04:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336079;
 bh=HLX4JMGbdcq/aUwr4uUrex+io/pY0G+gzyhDb3ZhoxQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Auc7HiTUhCKBaAKQj9XoeZijzTVy0xvM+uyvmquvVEKdJ+wWx12QGX029qz7+2ZXt
 HSX3LrgY+7zIAB9y28VywZEVudzJPB9CH8AaX3UVpAa0dyS4RtMzrDhDoRmBtFw475
 U0F1qGM7keBpSOZoMAADwK8g0vm/nY5SvHvnaPTRn9uAlKiD7cj1yEkOnh0CsP1PVd
 N0pCazAA3tAxQV8KLrUw4hT+pW7NK1R0z8nQ/BCx88b5XSdyqnVAfE9BDpJrexg/P/
 IDmCgmTmYlXqv0QbjVV8N33CpPTi45Iv4Bfv7cN17555xkmaqPoQ/A7eSY7ZA/pRRw
 FIis9EcoaFSGA==
Message-ID: <sashiko-outbox-190525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
To: "Aravind Iddamsetty" <aravind.iddamsetty@linux.intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:38 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/ras: UAF in drm_ras_nl_get_retired_resources_dumpit() due to m=
issing node lifetime management
- [Medium] drm/xe: lockless sequential list traversal in xe_ttm_vram_get_re=
tired_page skips moving entries
- [Medium] xe: data race in xe_ttm_vram_get_retired_page due to lockless po=
s->blocks traversal
- [Low] netlink: use of u64 and pad attributes for new families instead of =
uint
--

commit fb04233297e64629b7560f39b814687dd56470e6
Author: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

drm/xe: Expose retired VRAM pages via drm-ras

Add a proper userspace interface using the drm-ras generic netlink family
for offlined VRAM pages.

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/net=
link/specs/drm_ras.yaml
> index 4c2ac9a1ba3f5..42ab1cceaea73 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
[ ... ]
> @@ -100,6 +123,45 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the error counter.
> +  -
> +    name: retired-resource-attrs
> +    attributes:
[ ... ]
> +      -
> +        name: address
> +        type: u64
> +        doc: Device address of the retired VRAM page (e.g. DPA).
> +      -
> +        name: size
> +        type: u64
> +        doc: Size of the retired VRAM page in bytes.
> +      -
> +        name: max-pages
> +        type: u32
> +        doc: >-
> +             Maximum VRAM pages that can be retired. Present only in the
> +             leading summary entry of the dump (no address/size/status).
> +      -
> +        name: status
> +        type: u32
> +        doc: Retirement status of the retired VRAM page.
> +        enum: retired-resource-status
> +      -
> +        name: pad
> +        type: pad

[Severity: Low]
Does this new family attribute set need manual padding and fixed-width u64
types?

The netlink guidelines recommend using the dynamically sized uint type inst=
ead
of u64 and manual padding for new attributes.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index b099eb67836e7..46ee897a13c94 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
[ ... ]
> @@ -564,6 +577,148 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_b=
uff *skb,
[ ... ]
> +int drm_ras_nl_get_retired_resources_dumpit(struct sk_buff *skb,
> +					    struct netlink_callback *cb)
> +{
> +	const struct genl_info *info =3D genl_info_dump(cb);
> +	struct drm_ras_ctx *ctx =3D (void *)cb->ctx;
> +	struct drm_ras_retired_resource res;
> +	struct drm_ras_node *node;
> +	struct nlattr *hdr;
> +	u32 node_id;
> +	u64 cursor;
> +	int ret =3D 0;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NODE_ID))
> +		return -EINVAL;
> +
> +	node_id =3D nla_get_u32(info->attrs[DRM_RAS_A_RETIRED_RESOURCE_ATTRS_NO=
DE_ID]);
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node || node->type !=3D DRM_RAS_NODE_TYPE_RETIRED_RESOURCES ||
> +	    !node->query_retired_resource)
> +		return -ENOENT;
> +
> +	/* Leading type-specific capacity summary (e.g. max pages), emitted onc=
e. */
> +	if (!ctx->summary_sent && node->query_retired_summary) {

[Severity: High]
Can the locklessly loaded node pointer be freed concurrently?

The generic netlink interface runs without genl_mutex. xa_load() drops the
RCU read lock before returning, and the node lacks any reference counting.

If a device teardown concurrently removes the node via cleanup_node() and
frees its memory, could accessing node->query_retired_summary() cause a
use-after-free?

> +		memset(&res, 0, sizeof(res));
> +		ret =3D node->query_retired_summary(node, &res);
> +		if (ret =3D=3D 0) {
[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe=
_ttm_vram_mgr.c
> index 9a514d983e90b..b56b543a56a24 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
[ ... ]
> @@ -624,6 +626,123 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manag=
er *man)
[ ... ]
> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 min_addr,
> +				 u64 *addr, u64 *size, u32 *status)
> +{
> +	struct xe_ttm_vram_offline_resource *pos;
> +	struct ttm_resource_manager *man;
> +	struct gpu_buddy_block *block;
> +	struct xe_ttm_vram_mgr *mgr;
> +	u64 best_addr =3D 0, best_size =3D 0;
> +	struct xe_tile *tile;
> +	u32 best_status =3D 0;
> +	bool found =3D false;
> +	u8 id;
> +
> +	for_each_tile(tile, xe, id) {
> +		struct xe_vram_region *vr =3D tile->mem.vram;
> +		u64 a, s;
> +
> +		man =3D ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
> +		if (!man || !vr)
> +			continue;
> +		mgr =3D to_xe_ttm_vram_mgr(man);
> +
> +		rcu_read_lock();
> +
> +		list_for_each_entry_rcu(pos, &mgr->offlined_pages, offlined_link) {

[Severity: Medium]
Will this lockless sequential traversal skip entries if they are moving
from queued_pages to offlined_pages?

If xe_ttm_vram_retry_queued_pages() concurrently moves an element from
queued_pages to offlined_pages after this loop has already scanned
offlined_pages, the element would also be missing when the second loop
scans queued_pages. This would cause the element to be permanently skipped
during the dump.

> +			block =3D list_first_entry_or_null(&pos->blocks,
> +							 struct gpu_buddy_block, link);
> +			if (block) {
> +				a =3D gpu_buddy_block_offset(block) + vr->dpa_base;
> +				s =3D gpu_buddy_block_size(&mgr->mm, block);

[Severity: Medium]
Is it safe to read pos->blocks and the block header locklessly here?

If a page reservation is concurrently retried via
xe_ttm_vram_retry_queued_pages(), xe_ttm_vram_buddy_alloc() dynamically
allocates and appends a new block to pos->blocks using a plain list append.

Because this traversal relies on RCU, could it observe an uninitialized
gpu_buddy_block header, resulting in garbage address and size values being
returned to userspace?

> +			} else {
> +				a =3D pos->addr + vr->dpa_base;
> +				s =3D SZ_4K;
> +			}
> +
> +			if (a >=3D min_addr && (!found || a < best_addr)) {
> +				best_addr =3D a;
> +				best_size =3D s;
> +				best_status =3D DRM_RAS_RETIRED_RESOURCE_STATUS_RETIRED;
> +				found =3D true;
> +			}
> +		}
> +
> +		list_for_each_entry_rcu(pos, &mgr->queued_pages, queued_link) {
> +			block =3D list_first_entry_or_null(&pos->blocks,
> +							 struct gpu_buddy_block, link);
> +			if (block) {
> +				a =3D gpu_buddy_block_offset(block) + vr->dpa_base;
> +				s =3D gpu_buddy_block_size(&mgr->mm, block);
> +			} else {
> +				a =3D pos->addr + vr->dpa_base;
> +				s =3D SZ_4K;
> +			}
> +
> +			if (a >=3D min_addr && (!found || a < best_addr)) {
> +				best_addr =3D a;
> +				best_size =3D s;
> +				best_status =3D pos->status =3D=3D XE_PAGE_RESERVE_FAIL ?
> +					      DRM_RAS_RETIRED_RESOURCE_STATUS_FAILED :
> +					      DRM_RAS_RETIRED_RESOURCE_STATUS_PENDING;
> +				found =3D true;
> +			}
> +		}
> +
> +		rcu_read_unlock();
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007080354.3072=
751-1-aravind.iddamsetty@linux.intel.com?part=3D1
