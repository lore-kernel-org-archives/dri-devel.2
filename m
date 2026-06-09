Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C333CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9863510E1B2;
	Tue,  9 Jun 2026 08:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.b="Vx/BEscr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="spO2gcbj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vx/BEscr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="spO2gcbj";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8EF310E1B4
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:46:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4801C6A8A5;
 Tue,  9 Jun 2026 08:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780994810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSQxH6p+aBDmmgKYN3VNQI6BF8H04zVBQYzVTpTNZQo=;
 b=Vx/BEscri+0r67xy3avOveRmQ30LzU24dPEtk4qjekhhW9jO6kGIOJyQmLwDG7x25ePCR2
 Xlaz8xVatdyRqM5Tfoywojl7q8hfbYvbK/V4xCBXi2oum35WHUs+sUA73IFM2FQGMlMDS9
 CBNOerN+mnmdoXzGGnP0+SurjemtxMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780994810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSQxH6p+aBDmmgKYN3VNQI6BF8H04zVBQYzVTpTNZQo=;
 b=spO2gcbj47UyJGxrqj93wVAFhcKrlTrh9cZYY+iwZ3P7HvrM5hIZjhXqrvAaHZxWZhA2vd
 J365xzS9oAiV3PAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Vx/BEscr";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=spO2gcbj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780994810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSQxH6p+aBDmmgKYN3VNQI6BF8H04zVBQYzVTpTNZQo=;
 b=Vx/BEscri+0r67xy3avOveRmQ30LzU24dPEtk4qjekhhW9jO6kGIOJyQmLwDG7x25ePCR2
 Xlaz8xVatdyRqM5Tfoywojl7q8hfbYvbK/V4xCBXi2oum35WHUs+sUA73IFM2FQGMlMDS9
 CBNOerN+mnmdoXzGGnP0+SurjemtxMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780994810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSQxH6p+aBDmmgKYN3VNQI6BF8H04zVBQYzVTpTNZQo=;
 b=spO2gcbj47UyJGxrqj93wVAFhcKrlTrh9cZYY+iwZ3P7HvrM5hIZjhXqrvAaHZxWZhA2vd
 J365xzS9oAiV3PAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 373B9779A7;
 Tue,  9 Jun 2026 08:46:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aXV3DfrSJ2oadgAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 09 Jun 2026 08:46:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id E0D69A0A90; Tue, 09 Jun 2026 10:46:49 +0200 (CEST)
Date: Tue, 9 Jun 2026 10:46:49 +0200
From: Jan Kara <jack@suse.cz>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, 
 Kees Cook <kees@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Chia-Lin Kao <acelan.kao@canonical.com>, Benjamin LaHaise <bcrl@kvack.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
 linux-aio@kvack.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] libfs: drop redundant SB_I_NOEXEC/SB_I_NODEV in
 init_pseudo() callers
Message-ID: <md6vxgeg4h2cs2p7jfgjy6ybgiysbl7fprulimdcxhhiwsv3le@5zgf6mbprh4w>
References: <20260604025315.245910-1-jhubbard@nvidia.com>
 <20260604025315.245910-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604025315.245910-3-jhubbard@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[nvidia.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[23];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_LAST(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[];
 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,gmail.com,canonical.com,kvack.org,linux-foundation.org,redhat.com,linaro.org,amd.com,kernel.dk,vger.kernel.org,lists.freedesktop.org,lists.linaro.org];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 R_RATELIMIT(0.00)[to_ip_from(RL694s4p1xnhfjnqpxspz5pnt4)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email, suse.cz:email, suse.cz:dkim,
 suse.com:email, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4801C6A8A5
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

On Wed 03-06-26 19:53:15, John Hubbard wrote:
> init_pseudo() now sets SB_I_NOEXEC and SB_I_NODEV by default, so the
> per-caller assignments are redundant. Drop them.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c               | 1 -
>  fs/anon_inodes.c       | 2 --
>  fs/nsfs.c              | 1 -
>  fs/pidfs.c             | 2 --
>  mm/secretmem.c         | 2 --
>  virt/kvm/guest_memfd.c | 2 --
>  6 files changed, 10 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 722476560848..f57fa21a2503 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -318,7 +318,6 @@ static int aio_init_fs_context(struct fs_context *fc)
>  	pfc = init_pseudo(fc, AIO_RING_MAGIC);
>  	if (!pfc)
>  		return -ENOMEM;
> -	fc->s_iflags |= SB_I_NOEXEC;
>  	pfc->ops = &aio_super_operations;
>  	return 0;
>  }
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index b8381c7fb636..a7b9b948e33d 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -86,8 +86,6 @@ static int anon_inodefs_init_fs_context(struct fs_context *fc)
>  	struct pseudo_fs_context *ctx = init_pseudo(fc, ANON_INODE_FS_MAGIC);
>  	if (!ctx)
>  		return -ENOMEM;
> -	fc->s_iflags |= SB_I_NOEXEC;
> -	fc->s_iflags |= SB_I_NODEV;
>  	ctx->dops = &anon_inodefs_dentry_operations;
>  	return 0;
>  }
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 160018c4fb36..c3b6ae76594a 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -664,7 +664,6 @@ static int nsfs_init_fs_context(struct fs_context *fc)
>  	struct pseudo_fs_context *ctx = init_pseudo(fc, NSFS_MAGIC);
>  	if (!ctx)
>  		return -ENOMEM;
> -	fc->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
>  	ctx->s_d_flags |= DCACHE_DONTCACHE;
>  	ctx->ops = &nsfs_ops;
>  	ctx->eops = &nsfs_export_operations;
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 1cce4f34a051..c363416766f1 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -1115,8 +1115,6 @@ static int pidfs_init_fs_context(struct fs_context *fc)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	fc->s_iflags |= SB_I_NOEXEC;
> -	fc->s_iflags |= SB_I_NODEV;
>  	ctx->s_d_flags |= DCACHE_DONTCACHE;
>  	ctx->ops = &pidfs_sops;
>  	ctx->eops = &pidfs_export_operations;
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 5f57ac4720d3..4877c262cb1f 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -245,8 +245,6 @@ static int secretmem_init_fs_context(struct fs_context *fc)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	fc->s_iflags |= SB_I_NOEXEC;
> -	fc->s_iflags |= SB_I_NODEV;
>  	return 0;
>  }
>  
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b2..80f201035d77 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -973,8 +973,6 @@ static int kvm_gmem_init_fs_context(struct fs_context *fc)
>  	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
>  		return -ENOMEM;
>  
> -	fc->s_iflags |= SB_I_NOEXEC;
> -	fc->s_iflags |= SB_I_NODEV;
>  	ctx = fc->fs_private;
>  	ctx->ops = &kvm_gmem_super_operations;
>  
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
