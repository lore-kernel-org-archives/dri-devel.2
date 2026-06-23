Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F18DCD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090D610E8DA;
	Tue, 23 Jun 2026 14:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="B1Q6F2wn";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DAF10E8DA
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782224090; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a0+L/eMSp1zs8RA/INnByO56PLBEDTYLaUti7fPpQK7RHoO7ulWY39pNke9NHW5c/XZCA+Vsa5Vy2mAMfu8f15llyb8kz7cOGpa0xVS9KOs2oU6gWx7z1y46TE6k0lcXOkdFTB6O7qAL0B6VQWOW5dl2Ohl3fDzJ/MxXflkPWEw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782224090;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EsE+YzWYsYqDA3kiWcXoMSa+8x5tcnmTz5zw/PFaWJU=; 
 b=Vn5BeShb9BwEb9eL7KTta2lCWpG9k7AYJ2pk+tdyjJo7xy/2blm/vPsQm8BHtrYuFu427KHMsYvtQu6T3U10T1eHK+1+u+e2GPik1FIObZVRkfK+zJMd+s9dSuI0R7yEaLwK31yOvocdKJs0YI0OrYCSx/o9RMgI4d0Cgs6WPQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782224090; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=EsE+YzWYsYqDA3kiWcXoMSa+8x5tcnmTz5zw/PFaWJU=;
 b=B1Q6F2wndl1tZ5gI/Yu1kxZZXMBhG8mmpw9iaBC9Tq4b9a+3i5p/Jg6TgeD/jqY5
 myoO8V6RkixB8Ch1F2Oc9WsYkiCJB4sjR45ehL3PqiOxZsh0mREqBOohLmcs6SXzRlr
 KskDLnNBBmeIeEKauoIy1lUqGTmTrPESLwAB1JIc=
Received: by mx.zohomail.com with SMTPS id 1782224088948548.8577201048784;
 Tue, 23 Jun 2026 07:14:48 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drm/panthor: Fix NPD issue on partial unmap of an
 evicted BO
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, liviu.dudau@arm.com, 
 steven.price@arm.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 nd@arm.com
In-Reply-To: <b85679e3-5ca2-4d36-8675-2b968d97cb5b@arm.com>
References: <20260623092413.2710066-1-akash.goel@arm.com>
 <20260623115332.7e89f56b@fedora-2.home>
 <9f9b372d-b465-4fd4-ab7a-9c399e35b4ed@arm.com>
 <20260623140942.5055457c@fedora-2.home>
 <b85679e3-5ca2-4d36-8675-2b968d97cb5b@arm.com>
Date: Tue, 23 Jun 2026 15:14:38 +0100
Message-Id: <178222407895.3538338.14153540187582641408.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=5mSeqZ1rznUzTPGbaC8XZbR81IjTNNR5YB6pUSm98HM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqOpTWktHrUQcnIuA4IIdfpAHZ7PUD3ckzN+6jB
 JMEmTQCI0GJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajqU1gAKCRAOJn5M7lND
 PdYYDACQ0YzsOGB449OvXlSf1furdBoGns+BkWpDzRUmgrG8jplKLgaDbcDT8i6iaOPn7GDda2x
 fZM9VSG0A0fKRd40ffQ7GayN0BWTko6tXo1hgoW5OU0LxVy5IAtm92AehJP6NN2o+IjKGMeid7M
 Acj1CRjrDwluayHH6BGIuwbii78Jaa1jAnFOdrCpHvHRDZVbXUT8KhWXHakucA5iuCrai/gP8kq
 uAB2bLnjc4maO1bT2CH4Uvq0KvClBvodo4YFc1UX8yQeYtYjSYHPwSiT4aInMmuBiKEGz9T8Cwi
 w6RIo1K75YNYGqjrd6MHZ15ZFkK3UK+DF7v8V0K6vECQsNF0QYfD4jSvIaxw33uQvriFcLE4nxl
 yUPGmFcsyoh+4k8m/T8JnuW/h5M4XWhi48xJTBePqM8Ns9Y56UH/onIKaDAcAM6vjoWXFURIMjJ
 FhGgCmANjBnSGWxoVz+uUbMelN1yQfwU4MqVX+OdTNEFVW5diMoyl7cIzt285uPLqawa4=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-06-23 13:41:12+01:00, Akash Goel wrote:
> On 6/23/26 13:09, Boris Brezillon wrote:
> 
> > On Tue, 23 Jun 2026 12:17:51 +0100
> > Akash Goel <akash.goel@arm.com> wrote:
> > 
> > 
> > Nah, you're correct, the patching of the drm_gpuva is independent of the
> > adjusted unmap range, so we should be good even if we don't adjust this
> > range for evicted sparse mappings. Sorry for the noise.
> 
> No worries. Thanks for confirming.
> 
> Since I had a closer look at the code, sorry I have another doubt.
> 
> Do we really need the call to 'panthor_fix_sparse_map_offset()' in the 
> following code block ?. The 'op->remap.next->gem.offset' would already 
> have been patched before.

You're right, it's completely unnecessary. Maybe replace it with a comment that says
the right offset had already been adjusted earlier in the function?

Other than that:

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

> 
> 	if (op->remap.next) {
> 		u64 addr = op->remap.next->va.addr;
> 		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
> 
> 		if (!unmap_vma->evicted && size > 0) {
> 			struct drm_gpuva_op_map map_op = {
> 				.va.addr = addr,
> 				.va.range = size,
> 				.gem.obj = op->remap.next->gem.obj,
> 				.gem.offset = op->remap.next->gem.offset,
> 			};
> 			panthor_fix_sparse_map_offset(&map_op, unmap_vma->flags);
> 
> 			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
> 
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Sorry I realized that indentation needs to be fixed in my patch.
> 
> Will send a v2 and ad your r-b tag.
> 
> Best regards
> Akash


