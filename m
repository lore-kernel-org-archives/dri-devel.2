Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF59CCF2DF
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B8DA10E901;
	Mon, 19 Oct 2026 09:16:17 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDC510E8EA;
 Mon, 19 Oct 2026 09:16:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36E7721C13;
 Mon, 19 Oct 2026 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792401364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yu3tr/XKjY08A8K99OkNRH8Z7mvGFgqqz1CA7bGCoQ=;
 b=ghGHOwZ6JxMIYAZ26rWhTpweaoCboTRlTL999bMVvyF0E2aZvlajC6BK/JwQUb+GP8T6vZ
 QpYJUF6W+y1mzomrimeyLNCvmnyrxjwp7Seri96i1piyel8vRzZVgO5dZWa2mhLkRaC+hO
 33rSbF30BBO4HAdoMOLbGOQBAaetndA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792401364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yu3tr/XKjY08A8K99OkNRH8Z7mvGFgqqz1CA7bGCoQ=;
 b=NiyW3NokfsPA3E7a9inhFGaT20Sl0YlKV0Mjp7kg8WBDh3ren76IclmzfKPO6t+0UBeewT
 Aln5ixT4mweAfjAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yC77sQaB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OXbTTu5b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792401363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yu3tr/XKjY08A8K99OkNRH8Z7mvGFgqqz1CA7bGCoQ=;
 b=yC77sQaBlmmo4b7SixoP8v0ykVb8nEozZqjSpHaFK0Q0fFqDF87llv3DaPBzNzh5CWKXxE
 8gosP/5itJsjOS62NqMDVHZ6RE8KHwU6Z6TD/DQLBDRiRDdTI6GbVTal3EcB41/okvGfzs
 XYhpDE6XhOp3uEX3iDXLm00HlOVNL9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792401363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yu3tr/XKjY08A8K99OkNRH8Z7mvGFgqqz1CA7bGCoQ=;
 b=OXbTTu5bfXVm5PferY6twjbDiPg/4EpFJsGB4+Iw+QGZxYgpoXGqIFOBisjJhNvUhGnAuO
 Hh+gTeNTZwQ1Z6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECE25134B3;
 Mon, 19 Oct 2026 09:16:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1ML/MNLf1WrwFAAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 19 Oct 2026 09:16:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 772FAA1413; Mon, 19 Oct 2026 11:16:02 +0200 (CEST)
Date: Mon, 19 Oct 2026 11:16:02 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, 
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 wine-devel@list.winehq.org, 
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org, 
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] file: simplify and harden cleanup handling
Message-ID: <p4eitjefwpwhfouwhmvxmelxl3yncv3vjdi7wsgu7rna2zorqd@rlvbcpzcpbid>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 36E7721C13
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[17];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
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

On Thu 17-09-26 11:09:41, Christian Brauner wrote:
> The cleanup guards rely on unnecessary infrastructure and make the code
> more complicated to follow than it needs to be. Clean it up. Also shrink
> the struct a bit and get rid of the unnecessary error variable. We can
> just make this more ergonomic by using fdf->fd directly. Also expose the
> struct itself as const and hide the actual underlying local variable
> behind a UNIQUE_ID() named variable so we avoid risking shadow variables
> and polluting callsites. Code generation wise the outcome is exactly the
> same but simpler.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

I know I'm really late but FWIW this looks really great! I know this is in
PR to Linus so feel free to ignore:

Reviewed-by: Jan Kara <jack@suse.cz>

;)
								Honza

> ---
> Christian Brauner (4):
>       file: simplify FD_PREPARE()
>       file: declare the FD_PREPARE() variable with __cleanup() directly
>       cleanup: remove CLASS_INIT()
>       file: make struct fd_prepare const and kill its err field
> 
>  arch/powerpc/platforms/cell/spufs/inode.c |  12 +--
>  drivers/gpio/gpiolib-cdev.c               |  18 ++---
>  drivers/gpu/drm/msm/msm_perfcntr.c        |   4 +-
>  drivers/media/mc/mc-request.c             |   8 +-
>  drivers/misc/ntsync.c                     |   6 +-
>  fs/eventfd.c                              |   4 +-
>  fs/eventpoll.c                            |   6 +-
>  fs/file.c                                 |   8 +-
>  fs/namespace.c                            |  12 +--
>  fs/nsfs.c                                 |   4 +-
>  fs/xfs/xfs_handle.c                       |   6 +-
>  include/linux/cleanup.h                   |   7 --
>  include/linux/file.h                      | 130 +++++++++++-------------------
>  io_uring/mock_file.c                      |   8 +-
>  kernel/bpf/bpf_iter.c                     |   6 +-
>  kernel/bpf/token.c                        |   6 +-
>  mm/userfaultfd.c                          |   6 +-
>  net/core/scm.c                            |   8 +-
>  net/handshake/netlink.c                   |   8 +-
>  net/kcm/kcmsock.c                         |   6 +-
>  20 files changed, 117 insertions(+), 156 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260917-work-file-fd_prepare-ea5966d68a95
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
