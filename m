Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0568606A334
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=MwCZbmGw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAF110E923;
	Tue, 10 Nov 2026 08:10:17 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ABF10E923
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794298210;
 bh=QE5cxIA9CwF4j34df/4llAzd8zZ5Mdoqj1BYGxkyIiA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MwCZbmGwx9mgNcAcoKsY6xr1qWYXZPZEWho/NKagqy/EeClXn/+tl/Fy+dCoTqJr+
 I8Sebi+LvB0JUOFd5WwoefE+QK2nOxNc385LLoBBGIvQ2Z4KmcYGM0GTEY+jhhY0Ka
 Bk9D2dp1if8MHQ7eas9O9YmVbvyU74m/UV2hSAxFxp4xzwx9GgYj0HggHBs0MSx0xw
 PhrJkm1sLmwQMVK9DXbOEJFwu2LNLq9yHRL+31MRmCCL11M0wjxzG2wdu9gt1tc5sc
 WWWkLAXIHOHTm4P1LGwbHK19kf4ftFgVxX+NDE2d09TWfkkmYPXnEroAMgaFSUsPo0
 dLSGIi0RLPyZQ==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4836017E0863;
 Tue, 10 Nov 2026 09:10:10 +0100 (CET)
Date: Tue, 10 Nov 2026 09:10:06 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Igor Torrente <igor.torrente@collabora.com>, steven.price@arm.com,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM
Message-ID: <20261110091006.60c88c61@fedora1.home>
In-Reply-To: <CAPj87rM3_MCFMGSAL1P6hBzLsLNP0hNL58whe1AeegtxMvgBhA@mail.gmail.com>
References: <20261109105652.7114-1-igor.torrente@collabora.com>
 <CAPj87rM3_MCFMGSAL1P6hBzLsLNP0hNL58whe1AeegtxMvgBhA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 17:38:57 +0000
Daniel Stone <daniel@fooishbar.org> wrote:

> Hi Igor,
> 
> On Mon, 9 Nov 2026 at 10:57, Igor Torrente <igor.torrente@collabora.com> wrote:
> > Panthor currently does not allow exporting BOs with an exclusive VM.
> > However, VDRM (native context) drivers export BOs for import by the guest
> > VM, which does not attempt to bind them to any GPU VM.
> >
> > Allow these BOs to be exported and rely on
> > panthor_vm_prepare_map_op_ctx() to reject attempts to bind them to a
> > different GPU VM.  
> 
> I'm having a little trouble parsing this.
> 
> Is the problem that:
> - the guest requests allocation of a BO with exclusive_vm_root_gem = guest_vm
> - the host passes that allocation through
> - the host exports a dmabuf from the allocation (which fails)
> - the host imports a dmabuf from the allocation (?)
> - the guest requests the BO be attached to guest_vm
> 
> i.e. is the problem that some host implementations (virglrenderer)
> handle BO allocation exclusively via an export/import interface?
> 
> If that is the problem, it seems like it would be cleaner to have the
> host implementation strip the exclusive VM ID from the request, until
> they can be fixed to not require the export/import dance.

Dropping the exclusive_vm assignment is indeed an option. The big issue
comes from the overhead incurred by BO access tracking when the BO is
shared:

- bo_wait() has to do a HANDLE_TO_FD + EXPORT_SYNC dance
- attach_sync_point() has to do an EXPORT_SYNC_FILE + HANDLE_TO_FD +
  IMPORT_SYNC_FILE dance
- the locking of shared BOs in the GROUP_SUBMIT path is more costly
  (one lock per shared BO instead of one lock for all private BOs)

I don't have numbers, but I suspect lowering all private BOs to
shared ones will have a noticeable impact on perfs.
