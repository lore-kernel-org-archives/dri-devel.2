Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9D0C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C43489151;
	Mon,  7 Sep 2026 08:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="fbvoa1HI";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="OIonDppS";
	dkim-atps=neutral
X-Greylist: delayed 798 seconds by postgrey-1.36 at gabe;
 Mon, 07 Sep 2026 08:41:14 UTC
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FED589151
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:41:14 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfout.phl.internal (Postfix) with ESMTP id 730CCEC008A;
 Mon,  7 Sep 2026 04:27:54 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Mon, 07 Sep 2026 04:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1788769673;
 x=1788856073; bh=xrztn4A6+QQSIphrkKKL6Tjrs10NSmgd8J3+pas7I2A=; b=
 fbvoa1HItVPtK0WyULmWocqKaMvnwB7fz8ML/UvC3xijz7J4UYiLxtK5ePzg+bte
 VtJMXX7EkUcZSxo92oma8OrmcM5v3XKBmVMUiTnegenpVxOK3gr/4FMybbS6gXZ3
 Baw05JyTYSkwy6s835ctMlcDz5/wkJFuSV401SZQBidHHBGqA1fAg1mrpHEk6/o/
 lNEr9QNfoq7WhdmUn2ObQ48eTEG9nW3gcQdpx3cvq2D+3Rm2auCqsP/2v0ELfqXi
 aIoASp6NyApcmm2xC/CZ3eNFYuQTd9v27w8Qx2I8s04mJdlcsyuCFILXYafIUujh
 B3NvQEI/K30PAa+0CjdyJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769673; x=
 1788856073; bh=xrztn4A6+QQSIphrkKKL6Tjrs10NSmgd8J3+pas7I2A=; b=O
 IonDppSB3hLCa5bb2MUP4nfUhzkr1ndlJjS/g6vheD8/WkDTDnm5/2p3hGm/3dOA
 houQs50pBLuxnC3c6tCY17fyHgbQz0V+A9D9lOMBD3jskbUmmWmZLaF7j35HG/Ny
 bnpR2WNQCEda0SQJctzFcf6dn8LEmWjyrkwKvrU6pSDusim/H0jBt0k23WzBMtW0
 soO+EmUIuhRL5uF3vUISDi0XTvpdDJNuWZTp2v9uF0xjdLFPVBsskS9FvaXBORNm
 4DMq6s4TZtVzFn7899e7G+b5ku41kBSSrZV8YDTuhCmRXND7doAaxTwfYF/NrPPT
 +mgtdDBJ+Moo+L1ABMe1A==
X-ME-Sender: <xms:hXWeagCqdXSJnqGWuM9OYvMxCVDSjWi8xatnc1ZsWXoliymK9Qr1YA>
 <xme:hXWeatU1ZOBOibLbPB2sJQ348aX-Sxx3pXi-PS8OpkInZCBeLkbgL4WME1Xkq-6Nu
 Sw2ICXSuEKtSEqLZYedbRcRmPQ2h5IzBRXq8voI-0Oy-JP2yX5RVGM>
X-ME-Proxy-Cause: dmFkZTFIQ2G4f+I64qTo4U8ArAMDaS7ey4lbFsqh4Mes3y/kShyCiw8w1AQZ1Pu0Guny8q
 gOoMmvJEf+4tOBjPr0YWAfMDlAAkA46QJ5Aery2Hq6yDD2Nh1Cf/VuK+tQkSFbVa2MHA3W
 BWa/NedDKHO3E7TLGQJ9dFb29rxq7BLZcBfRj2ryddKNEjGBfK/I5bX294rzu6JhkZX9M+
 MGw+nRM4HIP46FCH/k/uCxualmFFANG56mtm1vBhz051ykRIiUZdObZUWu3CGQ/0ZOVILs
 S694g/BJmdwNnvlqGHVRWvER3RReTqtAV5jlJFxil4C7mEKXDiPGPP1MoKCxJddMZqrfCt
 G+jT/rrOjMh6PHwMm+Uin1krUHfUXKRFPZ6OGo0pWR3WgGnAjZXluUrwpzDtVvUf7aIHeI
 dQ3ArD92ZAGx8Xy9+Nrw4YxzDp1L57iQ8UoPJuRC/fvO8Es0ZMD1lq3GKYIS+Q81ZbECmK
 A+TsmlIQl4fAnbW+qsmsmUfvo4+Yio56ggef43RJF0z1jZ4J++wTsbaf+P5kSAm2Y/oVm5
 JllVzPOov9zGm7JFJcGp56Dy3ubYTsi6bRJISbNVE7Xa3VTMH1bHev3vxJ1kGw/YiRYnoJ
 Z3PKG1rkbj0dOSQiMcbsnGAYEnnsNP6K4cHfsBTs+8OX7ksU90L0drhFZTpg
X-ME-Proxy: <xmx:h3WealrsFMJthewHDOszBuPmF2M4VbJWjNAzgg0C2PvSFwEcNwFIpw>
 <xmx:h3WeahvehrDoI0zpeKkOFgXWZM0sck4oW0zjx-FX71iVJ5Z3q02LNw>
 <xmx:h3WeaiEvt_NWq295YUDo0IhHHx1rl-vYyK6qcYRgcBEhzJOGkox0og>
 <xmx:h3WeaiayK_jQwEJGKpjuoa5da0DQCn36cc9BJDxCwWvIY0jCrUM1IA>
 <xmx:iXWeasUvpguWJYHbaIXUpkxUR2PUIwuJw99AoXZm98-U3jEQvDYJ-4mx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 6032F32A0078; Mon,  7 Sep 2026 04:27:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ABSAncyMfC9J
Date: Mon, 07 Sep 2026 10:27:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Dave Airlie" <airlied@gmail.com>,
 "Yogesh Mohan Marimuthu" <yogesh.mohanmarimuthu@amd.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Sima Vetter" <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <24509a57-4e83-4730-b0f7-aae21abd2ef9@app.fastmail.com>
In-Reply-To: <CAMuHMdVyFiywZJyaRCRjdkVptfiFOk=wy5+sQ4Mb_BgF10Q=7Q@mail.gmail.com>
References: <CAPM=9ty9kjb1bKFgjgBS1tgM3zP2tK+5qTFzT9-0t+1jykBDxw@mail.gmail.com>
 <CAMuHMdUG7_7GDPhs3H7kiarqSYR1_gMD1onYu9Hzem-_a-ookg@mail.gmail.com>
 <CAMuHMdVyFiywZJyaRCRjdkVptfiFOk=wy5+sQ4Mb_BgF10Q=7Q@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 7.3-rc2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

On Mon, Sep 7, 2026, at 09:38, Geert Uytterhoeven wrote:
> Sorry, forgot to CC Arnd for the uapi breakage

Thanks!

> On Mon, 7 Sept 2026 at 09:36, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Fri, 4 Sept 2026 at 21:52, Dave Airlie <airlied@gmail.com> wrote:
>> > amdgpu:
>> >  - Fix for drm_amdgpu_info_device with mixed 64 bit kernel and 32 bit userspace
>>
>> This commit contains a "cherry picked from"-reference to a
>> non-existing commit in upstream (it does exist in linux-next),
>> and mentions a discussion between three people.
>> It would have been better to include a link to that discusion:
>> https://lore.kernel.org/20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com

Agreed, and at least mention that this breaks native x86-32
binaries until a user space recompile. If we're breaking this now,
I would also suggest adding corresponding padding at the end of
drm_amdgpu_gem_metadata and drm_amdgpu_info_hw_ip to align
the x86-32 ABI with the other architectures.

As far as I can tell, drm_ioctl_desc is robust against padding
at the end of a structure, but having different
numeric values for DRM_IOCTL_AMDGPU_GEM_METADATA based on
-m32/-m64 compiler flags is an unnecessary source of confusion.

For references, see below for all structures in include/drm
contain implicit padding, from my patch series to add -Wpadded
and shut up known warnings. Most of these are already handled
correctly in drm compat handlers, but a few may need to be
addressed better:

- drm_i915_query_perf_config looks like it gets the wrong
  data pointer, and may need a fix in the compat handler
- drm_radeon appears to completely lack proper compat
  structure conversion and just passes everything to
  the native handler, which is broken on all compat
  architectures in addition to the x86-32 padding issue
- panfrost/v3d/vc4 can just make the implicit padding explicit
  to avoid the -Wpadded warnings, since these are never
  used on x86-32
- hexagon is a special beast and may need a better global
  fix to align with normal enum types.

     Arnd

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..0114289f8369 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -713,7 +713,8 @@ struct drm_amdgpu_gem_metadata {
 		__u64	tiling_info;
 		__u32	data_size_bytes;
 		__u32	data[64];
-	} data;
+		__uapi_arch_pad32;
+	} __uapi_arch_align data;
 };
 
 struct drm_amdgpu_gem_mmap_in {
@@ -1510,6 +1511,7 @@ struct drm_amdgpu_info_device {
 	__u64 high_va_max;
 	/* gfx10 pa_sc_tile_steering_override */
 	__u32 pa_sc_tile_steering_override;
+	__uapi_arch_pad32;
 	/* disabled TCCs */
 	__u64 tcc_disabled_mask;
 	__u64 min_engine_clock;
@@ -1535,7 +1537,8 @@ struct drm_amdgpu_info_device {
 	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
 	__u32 userq_ip_mask;
 	__u32 pad;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 struct drm_amdgpu_info_hw_ip {
 	/** Version of h/w IP */
@@ -1553,7 +1556,8 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  ip_discovery_version;
 	/* Userq available slots */
 	__u32  userq_num_slots;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 struct drm_amdgpu_info_num_handles {
 	/** Max handles as supported by firmware for UVD */
diff --git a/include/uapi/drm/armada_drm.h b/include/uapi/drm/armada_drm.h
index af1c14c837c5..4cbec706d4f2 100644
--- a/include/uapi/drm/armada_drm.h
+++ b/include/uapi/drm/armada_drm.h
@@ -45,7 +45,8 @@ struct drm_armada_gem_pwrite {
 	__u32 handle;
 	__u32 offset;
 	__u32 size;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 #define DRM_IOCTL_ARMADA_GEM_PWRITE \
 	ARMADA_IOCTL(IOW, GEM_PWRITE, gem_pwrite)
 
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index bc7ef7684099..2d18ccff8b62 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -87,8 +87,9 @@ struct drm_clip_rect {
  */
 struct drm_drawable_info {
 	unsigned int num_rects;
+	__uapi_arch_pad_long;
 	struct drm_clip_rect *rects;
-};
+} __uapi_arch_align;
 
 /*
  * Texture region,
@@ -122,13 +123,14 @@ struct drm_version {
 	int version_major;	  /**< Major version */
 	int version_minor;	  /**< Minor version */
 	int version_patchlevel;	  /**< Patch level */
+	__uapi_arch_pad_long;
 	__kernel_size_t name_len;	  /**< Length of name buffer */
 	char __user *name;	  /**< Name of driver */
 	__kernel_size_t date_len;	  /**< Length of date buffer */
 	char __user *date;	  /**< User-space buffer to hold date */
 	__kernel_size_t desc_len;	  /**< Length of desc buffer */
 	char __user *desc;	  /**< User-space buffer to hold desc */
-};
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_GET_UNIQUE ioctl argument type.
@@ -142,6 +144,7 @@ struct drm_unique {
 
 struct drm_list {
 	int count;		  /**< Length of user-space structures */
+	__uapi_arch_pad_long;
 	struct drm_version __user *version;
 };
 
@@ -192,8 +195,9 @@ enum drm_map_flags {
 
 struct drm_ctx_priv_map {
 	unsigned int ctx_id;	 /**< Context requesting private mapping */
+	__uapi_arch_pad_long;
 	void *handle;		 /**< Handle of map */
-};
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_GET_MAP, DRM_IOCTL_ADD_MAP and DRM_IOCTL_RM_MAP ioctls
@@ -209,8 +213,9 @@ struct drm_map {
 	void *handle;		 /**< User-space: "Handle" to pass to mmap() */
 				 /**< Kernel-space: kernel-virtual address */
 	int mtrr;		 /**< MTRR slot used */
+	__uapi_arch_pad_long;
 	/*   Private data */
-};
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_GET_CLIENT ioctl argument type.
@@ -252,7 +257,12 @@ struct drm_stats {
 	struct {
 		unsigned long value;
 		enum drm_stat_type type;
-	} data[15];
+		__uapi_arch_pad_long;
+#ifdef __hexagon__
+		/* hexagon uses short enums */
+		__u8 :8, :8, :8;
+#endif
+	} __uapi_arch_align data[15];
 };
 
 /*
@@ -326,6 +336,7 @@ struct drm_buf_desc {
 		_DRM_FB_BUFFER = 0x08,	/**< Buffer is in frame buffer */
 		_DRM_PCI_BUFFER_RO = 0x10 /**< Map PCI DMA buffer read-only */
 	} flags;
+	__uapi_arch_pad_long;
 	unsigned long agp_start; /**<
 				  * Start address of where the AGP buffers are
 				  * in the AGP aperture
@@ -337,16 +348,18 @@ struct drm_buf_desc {
  */
 struct drm_buf_info {
 	int count;		/**< Entries in list */
+	__uapi_arch_pad_long;
 	struct drm_buf_desc __user *list;
-};
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_FREE_BUFS ioctl argument type.
  */
 struct drm_buf_free {
 	int count;
+	__uapi_arch_pad_long;
 	int __user *list;
-};
+} __uapi_arch_align;
 
 /*
  * Buffer information
@@ -357,21 +370,23 @@ struct drm_buf_pub {
 	int idx;		       /**< Index into the master buffer list */
 	int total;		       /**< Buffer size */
 	int used;		       /**< Amount of buffer in use (for DMA) */
+	__uapi_arch_pad_long;
 	void __user *address;	       /**< Address of buffer */
-};
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_MAP_BUFS ioctl argument type.
  */
 struct drm_buf_map {
 	int count;		/**< Length of the buffer list */
+	__uapi_arch_pad_long;
 #ifdef __cplusplus
 	void __user *virt;
 #else
 	void __user *virtual;		/**< Mmap'd area in user-virtual */
 #endif
 	struct drm_buf_pub __user *list;	/**< Buffer information */
-};
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_DMA ioctl argument type.
@@ -388,10 +403,12 @@ struct drm_dma {
 	enum drm_dma_flags flags;	  /**< Flags */
 	int request_count;		  /**< Number of buffers requested */
 	int request_size;		  /**< Desired size for buffers */
+	__uapi_arch_pad_long;
 	int __user *request_indices;	  /**< Buffer information */
 	int __user *request_sizes;
 	int granted_count;		  /**< Number of buffers granted */
-};
+	__uapi_arch_pad_long;
+} __uapi_arch_align;
 
 enum drm_ctx_flags {
 	_DRM_CONTEXT_PRESERVED = 0x01,
@@ -413,8 +430,9 @@ struct drm_ctx {
  */
 struct drm_ctx_res {
 	int count;
+	__uapi_arch_pad_long;
 	struct drm_ctx __user *contexts;
-};
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_ADD_DRAW and DRM_IOCTL_RM_DRAW ioctl argument type.
@@ -434,8 +452,9 @@ struct drm_update_draw {
 	drm_drawable_t handle;
 	unsigned int type;
 	unsigned int num;
+	__uapi_arch_pad32;
 	unsigned long long data;
-};
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_GET_MAGIC and DRM_IOCTL_AUTH_MAGIC ioctl argument type.
@@ -559,7 +578,8 @@ struct drm_agp_info {
 	/* PCI information */
 	unsigned short id_vendor;
 	unsigned short id_device;
-};
+	__uapi_arch_pad_long;
+} __uapi_arch_align;
 
 /*
  * DRM_IOCTL_SG_ALLOC ioctl argument type.
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 381a3e857d4e..7da67277fb5f 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -350,7 +350,8 @@ struct drm_mode_get_plane {
 struct drm_mode_get_plane_res {
 	__u64 plane_id_ptr;
 	__u32 count_planes;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 #define DRM_MODE_ENCODER_NONE	0
 #define DRM_MODE_ENCODER_DAC	1
@@ -628,14 +629,16 @@ struct drm_mode_obj_get_properties {
 	__u32 count_props;
 	__u32 obj_id;
 	__u32 obj_type;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 struct drm_mode_obj_set_property {
 	__u64 value;
 	__u32 prop_id;
 	__u32 obj_id;
 	__u32 obj_type;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 struct drm_mode_get_blob {
 	__u32 blob_id;
@@ -723,8 +726,9 @@ struct drm_mode_fb_cmd2 {
 	 * constants in ``drm_fourcc.h``. All planes must use the same
 	 * modifier. Ignored unless &DRM_MODE_FB_MODIFIERS is set in @flags.
 	 */
+	__uapi_arch_pad32;
 	__u64 modifier[4];
-};
+} __uapi_arch_align;
 
 #define DRM_MODE_FB_DIRTY_ANNOTATE_COPY 0x01
 #define DRM_MODE_FB_DIRTY_ANNOTATE_FILL 0x02
@@ -1078,7 +1082,8 @@ struct hdr_output_metadata {
 	union {
 		struct hdr_metadata_infoframe hdmi_metadata_type1;
 	};
-};
+	__uapi_arch_pad16;
+} __uapi_arch_align;
 
 /**
  * DRM_MODE_PAGE_FLIP_EVENT
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index af024d90453d..abd0cafa231f 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -140,6 +140,7 @@ struct drm_etnaviv_gem_submit_reloc {
 	__u32 reloc_idx;      /* in, index of reloc_bo buffer */
 	__u64 reloc_offset;   /* in, offset from start of reloc_bo */
 	__u32 flags;          /* in, placeholder for now, no defined values */
+	__uapi_arch_pad32;
 };
 
 /* Each buffer referenced elsewhere in the cmdstream submit (ie. the
@@ -263,7 +264,8 @@ struct drm_etnaviv_pm_signal {
 	__u16 iter;       /* in/out, select pm source at index iter */
 	__u16 id;         /* out, id of signal */
 	char  name[64];   /* out, name of domain */
-};
+	__uapi_arch_pad16;
+} __uapi_arch_align;
 
 #define DRM_ETNAVIV_GET_PARAM          0x00
 /* placeholder:
diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
index 535cb68fdb5c..13ff9be3db27 100644
--- a/include/uapi/drm/i915_drm.h
+++ b/include/uapi/drm/i915_drm.h
@@ -28,6 +28,7 @@
 #define _UAPI_I915_DRM_H_
 
 #include "drm.h"
+#include <linux/stddef.h>
 
 #if defined(__cplusplus)
 extern "C" {
@@ -559,6 +560,7 @@ typedef struct drm_i915_batchbuffer {
 	int DR1;		/* hw flags for GFX_OP_DRAWRECT_INFO */
 	int DR4;		/* window origin for GFX_OP_DRAWRECT_INFO */
 	int num_cliprects;	/* mulitpass with multiple cliprects? */
+	__uapi_arch_pad_long;
 	struct drm_clip_rect __user *cliprects;	/* pointer to userspace cliprects */
 } drm_i915_batchbuffer_t;
 
@@ -820,6 +822,7 @@ typedef struct drm_i915_irq_wait {
 struct drm_i915_getparam {
 	/** @param: Driver parameter to query. */
 	__s32 param;
+	__uapi_arch_pad_long;
 
 	/**
 	 * @value: Address of memory where queried value should be put.
@@ -828,7 +831,7 @@ struct drm_i915_getparam {
 	 * compat32 code. Don't repeat this mistake.
 	 */
 	int __user *value;
-};
+} __uapi_arch_align;
 
 /**
  * typedef drm_i915_getparam_t - Driver parameter query structure.
@@ -857,8 +860,9 @@ typedef struct drm_i915_mem_alloc {
 	int region;
 	int alignment;
 	int size;
+	__uapi_arch_pad_long;
 	int __user *region_offset;	/* offset from start of fb or agp */
-} drm_i915_mem_alloc_t;
+} __uapi_arch_align drm_i915_mem_alloc_t;
 
 typedef struct drm_i915_mem_free {
 	int region;
@@ -3422,7 +3426,19 @@ struct drm_i915_query_perf_config {
 		 * String formatted like "%08x-%04x-%04x-%04x-%012x"
 		 */
 		char uuid[36];
-	};
+
+		/*
+		 * uuid is the longest field in the union but is not a multiple
+		 * of alignof(__u64) in size, which leads to a -Wpadded warning.
+		 * add an explicit union member here with the correct size on
+		 * the architectures that need padding or zero length on those
+		 * that do not.
+		 */
+		struct {
+			char __pad[36];
+			__uapi_arch_pad32;
+		};
+	} __uapi_arch_align;
 
 	/**
 	 * @flags:
@@ -3447,8 +3463,11 @@ struct drm_i915_query_perf_config {
 	 *  - &drm_i915_perf_oa_config.n_boolean_regs
 	 *  - &drm_i915_perf_oa_config.n_flex_regs
 	 */
-	__u8 data[];
-};
+	union {
+		__uapi_arch_pad32; /* pad to alignof(__u64) */
+		__DECLARE_FLEX_ARRAY(__u8, data);
+	};
+} __uapi_arch_align;
 
 /**
  * enum drm_i915_gem_memory_class - Supported memory classes
@@ -3867,7 +3886,8 @@ struct drm_i915_gem_create_ext_protected_content {
 	struct i915_user_extension base;
 	/** @flags: reserved for future usage, currently MBZ */
 	__u32 flags;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 /**
  * struct drm_i915_gem_create_ext_set_pat - The
diff --git a/include/uapi/drm/ivpu_accel.h b/include/uapi/drm/ivpu_accel.h
index 264505d54f93..f80a580a21bc 100644
--- a/include/uapi/drm/ivpu_accel.h
+++ b/include/uapi/drm/ivpu_accel.h
@@ -389,7 +389,8 @@ struct drm_ivpu_submit {
 	 * %DRM_IVPU_JOB_PRIORITY_REALTIME
 	 */
 	__u32 priority;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 /**
  * struct drm_ivpu_cmdq_submit - Submit commands to the VPU using explicit command queue
@@ -488,7 +489,8 @@ struct drm_ivpu_metric_streamer_start {
 	__u32 sample_size;
 	/** @max_data_size: Returned max @data_size from %DRM_IOCTL_IVPU_METRIC_STREAMER_GET_DATA */
 	__u32 max_data_size;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 /**
  * struct drm_ivpu_metric_streamer_get_data - Copy collected metric data
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 7f2e594be4eb..d5c6c9d40bc4 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -430,7 +430,8 @@ struct drm_msm_wait_fence {
 	__u32 flags;          /* in, bitmask of MSM_WAIT_FENCE_x */
 	struct drm_msm_timespec timeout;   /* in */
 	__u32 queueid;         /* in, submitqueue id */
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 /* madvise provides a way to tell the kernel in case a buffers contents
  * can be discarded under memory pressure, which is useful for userspace
diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index 50d5337f35ef..f5b1e3b56897 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -402,14 +402,16 @@ struct panfrost_dump_object_header {
 			__u32 gpu_id;
 			__u32 major;
 			__u32 minor;
+			__uapi_arch_pad32;
 			__u64 nbos;
-		} reghdr;
+		} __uapi_arch_align reghdr;
 
 		struct {
 			__u32 valid;
+			__uapi_arch_pad32;
 			__u64 iova;
 			__u32 data[2];
-		} bomap;
+		} __uapi_arch_align bomap;
 
 		/*
 		 * Force same size in case we want to expand the header
diff --git a/include/uapi/drm/radeon_drm.h b/include/uapi/drm/radeon_drm.h
index 490a59cc4532..95db5d8eea49 100644
--- a/include/uapi/drm/radeon_drm.h
+++ b/include/uapi/drm/radeon_drm.h
@@ -569,6 +569,7 @@ typedef struct drm_radeon_init {
 		RADEON_INIT_R300_CP = 0x04,
 		RADEON_INIT_R600_CP = 0x05
 	} func;
+	__uapi_arch_pad_long;
 	unsigned long sarea_priv_offset;
 	int is_pci;
 	int cp_mode;
@@ -581,6 +582,7 @@ typedef struct drm_radeon_init {
 	unsigned int back_offset, back_pitch;
 	unsigned int depth_bpp;
 	unsigned int depth_offset, depth_pitch;
+	__uapi_arch_pad_long;
 
 	unsigned long fb_offset;
 	unsigned long mmio_offset;
@@ -588,7 +590,7 @@ typedef struct drm_radeon_init {
 	unsigned long ring_rptr_offset;
 	unsigned long buffers_offset;
 	unsigned long gart_textures_offset;
-} drm_radeon_init_t;
+} __uapi_arch_align drm_radeon_init_t;
 
 typedef struct drm_radeon_cp_stop {
 	int flush;
@@ -619,8 +621,9 @@ typedef struct drm_radeon_clear {
 	unsigned int clear_depth;
 	unsigned int color_mask;
 	unsigned int depth_mask;	/* misnamed field:  should be stencil */
+	__uapi_arch_pad_long;
 	drm_radeon_clear_rect_t __user *depth_boxes;
-} drm_radeon_clear_t;
+} __uapi_arch_align drm_radeon_clear_t;
 
 typedef struct drm_radeon_vertex {
 	int prim;
@@ -645,10 +648,12 @@ typedef struct drm_radeon_vertex2 {
 	int idx;		/* Index of vertex buffer */
 	int discard;		/* Client finished with buffer? */
 	int nr_states;
+	__uapi_arch_pad_long;
 	drm_radeon_state_t __user *state;
 	int nr_prims;
+	__uapi_arch_pad_long;
 	drm_radeon_prim_t __user *prim;
-} drm_radeon_vertex2_t;
+} __uapi_arch_align drm_radeon_vertex2_t;
 
 /* v1.3 - obsoletes drm_radeon_vertex2
  *      - allows arbitrarily large cliprect list
@@ -662,10 +667,12 @@ typedef struct drm_radeon_vertex2 {
  */
 typedef struct drm_radeon_cmd_buffer {
 	int bufsz;
+	__uapi_arch_pad_long;
 	char __user *buf;
 	int nbox;
+	__uapi_arch_pad_long;
 	struct drm_clip_rect __user *boxes;
-} drm_radeon_cmd_buffer_t;
+} __uapi_arch_align drm_radeon_cmd_buffer_t;
 
 typedef struct drm_radeon_tex_image {
 	unsigned int x, y;	/* Blit coordinates */
@@ -679,6 +686,7 @@ typedef struct drm_radeon_texture {
 	int format;
 	int width;		/* Texture image coordinates */
 	int height;
+	__uapi_arch_pad_long;
 	drm_radeon_tex_image_t __user *image;
 } drm_radeon_texture_t;
 
@@ -723,8 +731,9 @@ typedef struct drm_radeon_indirect {
 
 typedef struct drm_radeon_getparam {
 	int param;
+	__uapi_arch_pad_long;
 	void __user *value;
-} drm_radeon_getparam_t;
+} __uapi_arch_align drm_radeon_getparam_t;
 
 /* 1.6: Set up a memory manager for regions of shared memory:
  */
@@ -735,8 +744,9 @@ typedef struct drm_radeon_mem_alloc {
 	int region;
 	int alignment;
 	int size;
+	__uapi_arch_pad_long;
 	int __user *region_offset;	/* offset from start of fb or GART */
-} drm_radeon_mem_alloc_t;
+} __uapi_arch_align drm_radeon_mem_alloc_t;
 
 typedef struct drm_radeon_mem_free {
 	int region;
@@ -765,8 +775,9 @@ typedef struct drm_radeon_irq_wait {
 
 typedef struct drm_radeon_setparam {
 	unsigned int param;
+	__uapi_arch_pad32;
 	__s64 value;
-} drm_radeon_setparam_t;
+} __uapi_arch_align drm_radeon_setparam_t;
 
 #define RADEON_SETPARAM_FB_LOCATION    1	/* determined framebuffer location */
 #define RADEON_SETPARAM_SWITCH_TILING  2	/* enable/disable color tiling */
@@ -816,7 +827,8 @@ struct drm_radeon_gem_create {
 	__u32	handle;
 	__u32	initial_domain;
 	__u32	flags;
-};
+	__uapi_arch_pad32;
+} __uapi_arch_align;
 
 /*
  * This is not a reliable API and you should expect it to fail for any
diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index d9b01f4c3a04..626e0619770d 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -354,6 +354,8 @@ struct drm_v3d_submit_csd {
 	__u32 cfg[7];
 	__u32 coef[4];
 
+	__uapi_arch_pad32;
+
 	/* Pointer to a u32 array of the BOs that are referenced by the job.
 	 */
 	__u64 bo_handles;
@@ -379,7 +381,7 @@ struct drm_v3d_submit_csd {
 	__u32 flags;
 
 	__u32 pad;
-};
+} __uapi_arch_align;
 
 /**
  * struct drm_v3d_indirect_csd - ioctl extension for the CPU job to create an
diff --git a/include/uapi/drm/vc4_drm.h b/include/uapi/drm/vc4_drm.h
index 2cac6277a1d7..bdfaabe35474 100644
--- a/include/uapi/drm/vc4_drm.h
+++ b/include/uapi/drm/vc4_drm.h
@@ -432,8 +432,9 @@ struct drm_vc4_perfmon_destroy {
  */
 struct drm_vc4_perfmon_get_values {
 	__u32 id;
+	__uapi_arch_pad32;
 	__u64 values_ptr;
-};
+} __uapi_arch_align;
 
 #if defined(__cplusplus)
 }
diff --git a/include/uapi/drm/vmwgfx_drm.h b/include/uapi/drm/vmwgfx_drm.h
index 7d786a0cc835..11553d87e1b7 100644
--- a/include/uapi/drm/vmwgfx_drm.h
+++ b/include/uapi/drm/vmwgfx_drm.h
@@ -227,6 +227,9 @@ struct drm_vmw_surface_create_req {
 struct drm_vmw_surface_arg {
 	__s32 sid;
 	enum drm_vmw_handle_type handle_type;
+#ifdef __hexagon__
+	__u8 :8, :8, :8;
+#endif
 };
 
 /**
@@ -865,6 +868,9 @@ enum drm_vmw_shader_type {
  */
 struct drm_vmw_shader_create_arg {
 	enum drm_vmw_shader_type shader_type;
+#ifdef __hexagon__
+	__u8 :8, :8, :8;
+#endif
 	__u32 size;
 	__u32 buffer_handle;
 	__u32 shader_handle;
@@ -941,6 +947,9 @@ struct drm_vmw_gb_surface_create_req {
 	__u32 format;
 	__u32 mip_levels;
 	enum drm_vmw_surface_flags drm_surface_flags;
+#ifdef __hexagon__
+	__u8 :8, :8, :8;
+#endif
 	__u32 multisample_count;
 	__u32 autogen_filter;
 	__u32 buffer_handle;
@@ -1170,6 +1179,10 @@ enum drm_vmw_surface_version {
 struct drm_vmw_gb_surface_create_ext_req {
 	struct drm_vmw_gb_surface_create_req base;
 	enum drm_vmw_surface_version version;
+#ifdef __hexagon__
+	/* hexagon uses short enums */
+	__u8 :8, :8, :8;
+#endif
 	__u32 svga3d_flags_upper_32_bits;
 	__u32 multisample_pattern;
 	__u32 quality_level;
