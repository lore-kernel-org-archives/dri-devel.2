Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E4ECD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3FF710E5CD;
	Mon, 18 May 2026 12:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FFJD4NvJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A7B10E7F3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:47:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 94D5540A08;
 Mon, 18 May 2026 12:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0850FC2BCB8;
 Mon, 18 May 2026 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779108478;
 bh=oS1k4nCM6/Jl+d0AtTLVKl0QoqSThznHhnmLEPr7fcU=;
 h=Date:From:To:Cc:Subject:From;
 b=FFJD4NvJbhjht1SFV1Inyx/vZ77CvM6T9yGTyTHLx8Z2tBavHW3giASdFLMnvK6+S
 2E4dGM8eF2AKG7GMfln+9ifAaZyYGFlqp5nZa4anqlZUe9jiQU9QbCbxHsgjqoDPxJ
 iAkT2/b6reG/qUKMAbc5nfDm3Uzcx9OWP1C+CGKGY+AzHg1ifU5bZl92B3k1tOqWLQ
 4f75UWYBuvqUWswtmTqFa7TV/INgTAhC8ftIHT1Wmp8Z+0Un3tjYYyHhzB66KuuQl+
 dd0M9ikKXuvzspHieeyo31BHIUbtW4kVNw8pxTfYfidXqWxMq4FoFZyoO3sYB3K7QY
 L97jMAEH4Zucg==
Date: Mon, 18 May 2026 13:47:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matt Roper <matthew.d.roper@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <agsKemEUW7r-8Q6g@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pRcJvvGffeQd5RuQ"
Content-Disposition: inline
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


--pRcJvvGffeQd5RuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_migrate.c

between commit:

  4568dfbb8363a ("drm/xe: Make decision to use Xe2-style blitter instructio=
ns a feature flag")

=66rom the origin tree and commits:

  09b3998429075 ("drm/xe: Make decision to use Xe2-style blitter instructio=
ns a feature flag")
  388768fe17386 ("drm/xe: Refactor emit_clear_main_copy")
  65be72013baf9 ("drm/xe: Refactor emit_clear_link_copy")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/xe/xe_migrate.c
index a22413f892a09,9428dd5e7760c..0000000000000
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@@ -31,6 -31,7 +31,7 @@@
  #include "xe_map.h"
  #include "xe_mem_pool.h"
  #include "xe_mocs.h"
+ #include "xe_pat.h"
  #include "xe_printk.h"
  #include "xe_pt.h"
  #include "xe_res_cursor.h"
@@@ -217,7 -218,7 +218,7 @@@ static void xe_migrate_prepare_vm(struc
  				  struct xe_vm *vm, u32 *ofs)
  {
  	struct xe_device *xe =3D tile_to_xe(tile);
- 	u16 pat_index =3D xe->pat.idx[XE_CACHE_WB];
+ 	u16 pat_index =3D xe_cache_pat_idx(xe, XE_CACHE_WB);
  	u8 id =3D tile->id;
  	u32 num_entries =3D NUM_PT_SLOTS, num_level =3D vm->pt_root[id]->level;
  #define VRAM_IDENTITY_MAP_COUNT	2
@@@ -337,7 -338,7 +338,7 @@@
  		 * if flat ccs is enabled.
  		 */
  		if (GRAPHICS_VER(xe) >=3D 20 && xe_device_has_flat_ccs(xe)) {
- 			u16 comp_pat_index =3D xe->pat.idx[XE_CACHE_NONE_COMPRESSION];
+ 			u16 comp_pat_index =3D xe_cache_pat_idx(xe, XE_CACHE_NONE_COMPRESSION);
  			u64 vram_offset =3D IDENTITY_OFFSET +
  				DIV_ROUND_UP_ULL(actual_phy_size, SZ_1G);
  			u64 pt31_ofs =3D xe_bo_size(bo) - XE_PAGE_SIZE;
@@@ -637,10 -638,10 +638,10 @@@ static void emit_pte(struct xe_migrate=20
 =20
  	/* Indirect access needs compression enabled uncached PAT index */
  	if (GRAPHICS_VERx100(xe) >=3D 2000)
- 		pat_index =3D is_comp_pte ? xe->pat.idx[XE_CACHE_NONE_COMPRESSION] :
- 					  xe->pat.idx[XE_CACHE_WB];
+ 		pat_index =3D is_comp_pte ? xe_cache_pat_idx(xe, XE_CACHE_NONE_COMPRESS=
ION) :
+ 					  xe_cache_pat_idx(xe, XE_CACHE_WB);
  	else
- 		pat_index =3D xe->pat.idx[XE_CACHE_WB];
+ 		pat_index =3D xe_cache_pat_idx(xe, XE_CACHE_WB);
 =20
  	ptes =3D DIV_ROUND_UP(size, XE_PAGE_SIZE);
 =20
@@@ -727,7 -728,22 +728,22 @@@ static void emit_copy_ccs(struct xe_gt=20
  	bb->len =3D cs - bb->cs;
  }
 =20
- #define EMIT_COPY_DW 10
+ static u32 blt_fast_copy_cmd_len(struct xe_device *xe)
+ {
+ 	return 10;
+ }
+=20
+ static u32 blt_mem_copy_cmd_len(struct xe_device *xe)
+ {
+ 	return 10;
+ }
+=20
+ static u32 emit_copy_cmd_len(struct xe_device *xe)
+ {
+ 	return (xe->info.has_mem_copy_instr) ? blt_mem_copy_cmd_len(xe) :
+ 		  blt_fast_copy_cmd_len(xe);
+ }
+=20
  static void emit_xy_fast_copy(struct xe_gt *gt, struct xe_bb *bb, u64 src=
_ofs,
  			      u64 dst_ofs, unsigned int size,
  			      unsigned int pitch)
@@@ -735,6 -751,7 +751,7 @@@
  	struct xe_device *xe =3D gt_to_xe(gt);
  	u32 mocs =3D 0;
  	u32 tile_y =3D 0;
+ 	u32 len;
 =20
  	xe_gt_assert(gt, !(pitch & 3));
  	xe_gt_assert(gt, size / pitch <=3D S16_MAX);
@@@ -747,7 -764,8 +764,8 @@@
  	if (GRAPHICS_VERx100(xe) >=3D 1250)
  		tile_y =3D XY_FAST_COPY_BLT_D1_SRC_TILE4 | XY_FAST_COPY_BLT_D1_DST_TILE=
4;
 =20
- 	bb->cs[bb->len++] =3D XY_FAST_COPY_BLT_CMD | (10 - 2);
+ 	len =3D blt_fast_copy_cmd_len(xe);
+ 	bb->cs[bb->len++] =3D XY_FAST_COPY_BLT_CMD | (len - 2);
  	bb->cs[bb->len++] =3D XY_FAST_COPY_BLT_DEPTH_32 | pitch | tile_y | mocs;
  	bb->cs[bb->len++] =3D 0;
  	bb->cs[bb->len++] =3D (size / pitch) << 16 | pitch / 4;
@@@ -764,6 -782,7 +782,7 @@@ static void emit_mem_copy(struct xe_gt=20
  			  u64 dst_ofs, unsigned int size, unsigned int pitch)
  {
  	u32 mode, copy_type, width;
+ 	u32 len;
 =20
  	xe_gt_assert(gt, IS_ALIGNED(size, pitch));
  	xe_gt_assert(gt, pitch <=3D U16_MAX);
@@@ -789,7 -808,9 +808,9 @@@
 =20
  	xe_gt_assert(gt, width <=3D U16_MAX);
 =20
- 	bb->cs[bb->len++] =3D MEM_COPY_CMD | mode | copy_type;
+ 	len =3D blt_mem_copy_cmd_len(gt_to_xe(gt));
+=20
+ 	bb->cs[bb->len++] =3D MEM_COPY_CMD | mode | copy_type | (len - 2);
  	bb->cs[bb->len++] =3D width - 1;
  	bb->cs[bb->len++] =3D size / pitch - 1; /* ignored by hw for page-copy/l=
inear above */
  	bb->cs[bb->len++] =3D pitch - 1;
@@@ -966,7 -987,7 +987,7 @@@ static struct dma_fence *__xe_migrate_c
  		}
 =20
  		/* Add copy commands size here */
- 		batch_size +=3D ((copy_only_ccs) ? 0 : EMIT_COPY_DW) +
+ 		batch_size +=3D ((copy_only_ccs) ? 0 : emit_copy_cmd_len(xe)) +
  			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
 =20
  		bb =3D xe_bb_new(gt, batch_size, usm);
@@@ -1405,7 -1426,7 +1426,7 @@@ struct dma_fence *xe_migrate_vram_copy_
 =20
  		batch_size +=3D pte_update_size(m, 0, sysmem, &sysmem_it, &vram_L0, &sy=
smem_L0_ofs,
  					      &sysmem_L0_pt, 0, avail_pts, avail_pts);
- 		batch_size +=3D EMIT_COPY_DW;
+ 		batch_size +=3D emit_copy_cmd_len(xe);
 =20
  		bb =3D xe_bb_new(gt, batch_size, usm);
  		if (IS_ERR(bb)) {
@@@ -1460,12 -1481,17 +1481,17 @@@
  	return fence;
  }
 =20
+ static u32 blt_mem_set_cmd_len(struct xe_device *xe)
+ {
+ 	return 7;
+ }
+=20
  static void emit_clear_link_copy(struct xe_gt *gt, struct xe_bb *bb, u64 =
src_ofs,
  				 u32 size, u32 pitch)
  {
  	struct xe_device *xe =3D gt_to_xe(gt);
  	u32 *cs =3D bb->cs + bb->len;
- 	u32 len =3D PVC_MEM_SET_CMD_LEN_DW;
+ 	u32 len =3D blt_mem_set_cmd_len(xe);
 =20
  	*cs++ =3D PVC_MEM_SET_CMD | PVC_MEM_SET_MATRIX | (len - 2);
  	*cs++ =3D pitch - 1;
@@@ -1483,15 -1509,21 +1509,21 @@@
  	bb->len +=3D len;
  }
 =20
+ static u32 blt_fast_color_cmd_len(struct xe_device *xe)
+ {
+ 	if (GRAPHICS_VERx100(xe) >=3D 1250)
+ 		return 16;
+ 	else
+ 		return 11;
+ }
+=20
  static void emit_clear_main_copy(struct xe_gt *gt, struct xe_bb *bb,
  				 u64 src_ofs, u32 size, u32 pitch, bool is_vram)
  {
  	struct xe_device *xe =3D gt_to_xe(gt);
  	u32 *cs =3D bb->cs + bb->len;
- 	u32 len =3D XY_FAST_COLOR_BLT_DW;
+ 	u32 len =3D blt_fast_color_cmd_len(xe);
 =20
- 	if (GRAPHICS_VERx100(xe) < 1250)
- 		len =3D 11;
 =20
  	*cs++ =3D XY_FAST_COLOR_BLT_CMD | XY_FAST_COLOR_BLT_DEPTH_32 |
  		(len - 2);
@@@ -1526,10 -1558,12 +1558,12 @@@
 =20
  static u32 emit_clear_cmd_len(struct xe_gt *gt)
  {
+ 	struct xe_device *xe =3D gt_to_xe(gt);
+=20
  	if (gt->info.has_xe2_blt_instructions)
- 		return PVC_MEM_SET_CMD_LEN_DW;
+ 		return blt_mem_set_cmd_len(xe);
  	else
- 		return XY_FAST_COLOR_BLT_DW;
+ 		return blt_fast_color_cmd_len(xe);
  }
 =20
  static void emit_clear(struct xe_gt *gt, struct xe_bb *bb, u64 src_ofs,
@@@ -1862,7 -1896,7 +1896,7 @@@ __xe_migrate_update_pgtables(struct xe_
 =20
  	/* For sysmem PTE's, need to map them in our hole.. */
  	if (!IS_DGFX(xe)) {
- 		u16 pat_index =3D xe->pat.idx[XE_CACHE_WB];
+ 		u16 pat_index =3D xe_cache_pat_idx(xe, XE_CACHE_WB);
  		u32 ptes, ofs;
 =20
  		ppgtt_ofs =3D NUM_KERNEL_PDE - 1;
@@@ -2084,7 -2118,7 +2118,7 @@@ static void build_pt_update_batch_sram(
  				       struct drm_pagemap_addr *sram_addr,
  				       u32 size, int level)
  {
- 	u16 pat_index =3D tile_to_xe(m->tile)->pat.idx[XE_CACHE_WB];
+ 	u16 pat_index =3D xe_cache_pat_idx(tile_to_xe(m->tile), XE_CACHE_WB);
  	u64 gpu_page_size =3D 0x1ull << xe_pt_shift(level);
  	u32 ptes;
  	int i =3D 0;
@@@ -2202,7 -2236,7 +2236,7 @@@ static struct dma_fence *xe_migrate_vra
  	xe_assert(xe, npages * PAGE_SIZE <=3D MAX_PREEMPTDISABLE_TRANSFER);
 =20
  	batch_size +=3D pte_update_cmd_size(npages << PAGE_SHIFT);
- 	batch_size +=3D EMIT_COPY_DW;
+ 	batch_size +=3D emit_copy_cmd_len(xe);
 =20
  	bb =3D xe_bb_new(gt, batch_size, use_usm_batch);
  	if (IS_ERR(bb)) {

--pRcJvvGffeQd5RuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoLCnkACgkQJNaLcl1U
h9AJ+wf8DmVdit04jm4d9XEdTC6OBxhQg0o6lmV3yBYyaOrHAcVhKqaZSWYl49w9
Q5I77EE/gtYPtZn8d7E4tlHK8nU/Z4CdzwENKEpBu9WsRdaKGNfpyiT+oFD3b4DU
1zN5C7mDEYF0dnLfGAASi6XQCvbVzCAiysXiGOArN5rK9oMoU9MauIoI72+/8nmL
FZhxABPWH8HfphKUEbbeObjJiOeZamS1Rn/oMxx6M62EoBeU+p+fVINN3uP+rdI/
Q5Jgc4baR/yNzXNIjc9DCFXvm8VHfalMrMhPFly4I9sAQhNLqnJt3RZqgcixO5bE
ZT9DKUlRamkt6advPQJ0QX52NGmQwA==
=OBFN
-----END PGP SIGNATURE-----

--pRcJvvGffeQd5RuQ--
