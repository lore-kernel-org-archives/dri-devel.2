Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE0606A334
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MdqF6m8E;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0FEKAcG7;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cgcr/uF6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EkMEKg6R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1A4112E0E;
	Fri,  6 Nov 2026 14:14:10 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326B4112E0E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:13:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3062B22130;
 Fri,  6 Nov 2026 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793974437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6K30hVHhqXoPEaw21V0OV260X+ND3ARDmqWUfKNcc4g=;
 b=MdqF6m8E2qCtZh8P7amkkKG3Ce/2rxwsLs45P/KN26lJYHVec/x+r8QZ0bDTaQ1Q2ciLz3
 genos76NXyeeY27gEBoAJiYLNHXpp878ok26i/jKIOWtjdHCon86hkG3lwvt/7+gRqOjT+
 D2YlTMUxv71sUiAoFd+BgFn/qNxhqS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793974437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6K30hVHhqXoPEaw21V0OV260X+ND3ARDmqWUfKNcc4g=;
 b=0FEKAcG7j5y2RE5+msUbcCwmOQmH9FD8Z0YCUr5v+JQr6cfEiJwUQwLFpnGl9f31cU6n3d
 Fmo/560AICUlZFAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793974436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6K30hVHhqXoPEaw21V0OV260X+ND3ARDmqWUfKNcc4g=;
 b=cgcr/uF6oMgxvfsar8cZ5Jm8xurU+djim4hT3s/6PNpNSQiKatXoCAhli9efi/MkfxC+lg
 KHOvpCNrITX288ebnO9YEy+ngRw8ikjC8TyWBYCXuNyOdDGPS/VsJwNvqy7LtO8Un5m9QN
 vmlLw96VbbOtiyTgWSLpMdRk98zzWCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793974436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6K30hVHhqXoPEaw21V0OV260X+ND3ARDmqWUfKNcc4g=;
 b=EkMEKg6Rq7p6T2dAdlddo3Ddu/SzdnzzrfxfyG6Ijczc+5rZ3K5bTuHeAykb2gOAV+NQOh
 nwP2LvPTuOqyGtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 098D5134E9;
 Fri,  6 Nov 2026 14:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ELg4NqPg7WofZAAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 06 Nov 2026 14:13:56 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
 id 9003021B7D; Fri, 06 Nov 2026 15:13:40 +0100 (CET)
Date: Fri, 6 Nov 2026 15:13:40 +0100
From: Jan Kara <jack@suse.cz>
To: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
Message-ID: <sp6gvawt6petvrlky7g6pqaqsp3jwouu6ixarevis5m5vd7fwe@xjxeakzi3nn3>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
 <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
 <bba04255-5dee-4dd2-a877-5e169edceadc@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bba04255-5dee-4dd2-a877-5e169edceadc@arm.com>
X-Spamd-Result: default: False [-12.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; RCVD_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,linux.intel.com,suse.de,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

On Fri 06-11-26 10:31:58, Bence Csókás wrote:
> On 2026. 11. 06. 10:05, Christian Brauner wrote:
> > On Tue, Oct 27, 2026 at 05:22:00PM +0100, Bence Csokas wrote:
> > > Add __free() support to eventfd and update drm_syncobj to use it as an
> > > example consumer.
> > > 
> > > A minor discrepancy I encountered is whether to put a semicolon after
> > > DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
> > > I followed the example set in core-api/cleanup.rst, and omitted it.
> > > 
> > > Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> > > ---
> > 
> > I'm really having trouble seeing how this improves anything
> > significantly. Probably others have the same impression which is why
> > this doesn't get a lot of review.
> 
> The goal of the __free() API is to reduce the number of goto-based error
> paths. Normally, you'd have to keep the state of every local in your head
> for every early return. (Has it been initialized? Has it been consumed? Or
> does it need to be freed?) Then you need to arrange your "goto tree" (error
> labels) in a way that frees everything, and then for every early exit, jump
> to the correct one. This can be quite complex for some functions. Look at
> KVM or HyperV eventfd code, for example.
> 
> By contrast, you just mark the local var with _free() and an appropriate
> destructor snippet, and the consumption point (the point after which we
> don't need to free it on a return) with no_free_ptr(), and the compiler
> instruments every early return accordingly.

Sure, but there's also the other side about which you don't speak: unless
the destructor is trivial (like kfree()), there are implications about
locking, when resources (such as references held by the object) get
released etc. So it can also be more complex to wrap your head around
__free usage than around standard cleanup code.

So unless __free is providing a noticeable simplification of some goto
hell, cleanup in many functions or similar, I generally don't find it worth
it...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
