Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B46082BFE
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MVW024mu;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1Lr3dwzb;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MVW024mu;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1Lr3dwzb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A022210EA6E;
	Fri,  6 Nov 2026 15:02:28 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49F410EA6E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:02:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42E9522189;
 Fri,  6 Nov 2026 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793977336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
 b=MVW024mu3KUwb1eDIw9bJ7PUOylrtjz83alILp27tKzUsdCksGRqb2eNBKhuCftDFHtDtf
 KABuC9It6O4tyCiPhUZjyZ0u1CeiNtO1HN59BmgR16E4h4eTs/ZpBWkV5LTiB8N+XVmgMb
 7B6PnDrfL/H4DtYHAIw1gx2QjGhRbKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793977336;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
 b=1Lr3dwzbGO42cHRrGquEh+E16qepkp47m3zjRAPxn7qf0CmFHNw6zxA6wxNnbXYCoqd78j
 473SBMFwRpWhQHDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793977336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
 b=MVW024mu3KUwb1eDIw9bJ7PUOylrtjz83alILp27tKzUsdCksGRqb2eNBKhuCftDFHtDtf
 KABuC9It6O4tyCiPhUZjyZ0u1CeiNtO1HN59BmgR16E4h4eTs/ZpBWkV5LTiB8N+XVmgMb
 7B6PnDrfL/H4DtYHAIw1gx2QjGhRbKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793977336;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
 b=1Lr3dwzbGO42cHRrGquEh+E16qepkp47m3zjRAPxn7qf0CmFHNw6zxA6wxNnbXYCoqd78j
 473SBMFwRpWhQHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C6F132C9;
 Fri,  6 Nov 2026 15:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id guvJOffr7WpFFwAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 06 Nov 2026 15:02:16 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
 id A02AA21BA3; Fri, 06 Nov 2026 16:02:00 +0100 (CET)
Date: Fri, 6 Nov 2026 16:02:00 +0100
From: Jan Kara <jack@suse.cz>
To: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
Message-ID: <boyk6gdk2qmgj4fxhbluqbtcbhqkgnyiq36hurhomfib6vrogw@tjgi2oxtbvmd>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
 <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
 <bba04255-5dee-4dd2-a877-5e169edceadc@arm.com>
 <sp6gvawt6petvrlky7g6pqaqsp3jwouu6ixarevis5m5vd7fwe@xjxeakzi3nn3>
 <803191ed-6597-4b8d-af7d-812b1b494fee@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <803191ed-6597-4b8d-af7d-812b1b494fee@arm.com>
X-Spamd-Result: default: False [-12.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_TLS_LAST(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,kernel.org,zeniv.linux.org.uk,linux.intel.com,suse.de,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, arm.com:email,
 suse.com:email]
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

On Fri 06-11-26 15:30:07, Bence Csókás wrote:
> On 2026. 11. 06. 15:13, Jan Kara wrote:
> > Hi!
> > 
> > On Fri 06-11-26 10:31:58, Bence Csókás wrote:
> > > On 2026. 11. 06. 10:05, Christian Brauner wrote:
> > > > On Tue, Oct 27, 2026 at 05:22:00PM +0100, Bence Csokas wrote:
> > > > > Add __free() support to eventfd and update drm_syncobj to use it as an
> > > > > example consumer.
> > > > > 
> > > > > A minor discrepancy I encountered is whether to put a semicolon after
> > > > > DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
> > > > > I followed the example set in core-api/cleanup.rst, and omitted it.
> > > > > 
> > > > > Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> > > > > ---
> > > > 
> > > > I'm really having trouble seeing how this improves anything
> > > > significantly. Probably others have the same impression which is why
> > > > this doesn't get a lot of review.
> > > 
> > > The goal of the __free() API is to reduce the number of goto-based error
> > > paths. Normally, you'd have to keep the state of every local in your head
> > > for every early return. (Has it been initialized? Has it been consumed? Or
> > > does it need to be freed?) Then you need to arrange your "goto tree" (error
> > > labels) in a way that frees everything, and then for every early exit, jump
> > > to the correct one. This can be quite complex for some functions. Look at
> > > KVM or HyperV eventfd code, for example.
> > > 
> > > By contrast, you just mark the local var with _free() and an appropriate
> > > destructor snippet, and the consumption point (the point after which we
> > > don't need to free it on a return) with no_free_ptr(), and the compiler
> > > instruments every early return accordingly.
> > 
> > Sure, but there's also the other side about which you don't speak: unless
> > the destructor is trivial (like kfree()), there are implications about
> > locking, when resources (such as references held by the object) get
> > released etc. So it can also be more complex to wrap your head around
> > __free usage than around standard cleanup code.
> 
> Sure. Thankfully eventfd_ctx_put() is one of the pretty trivial ones,
> basically just calling kfree() on itself when the kref drops to 0.

Ok, fair.

> > So unless __free is providing a noticeable simplification of some goto
> > hell, cleanup in many functions or similar, I generally don't find it worth
> > it...
> 
> Look into for instance mshv_irqfd_assign() and weep... And then imagine how
> much simpler it'd be if it were using __free() instead.

Well, over the years I've seen much worse things :) But I agree for that
function using __free would be a simplification.

> For the example in 2/2, I deliberately chose one callsite where it's trivial
> to deduce that behaviour is unchanged.

Well, the change is kind of "meh, I don't care much" for me. So I guess if
you include some conversion that actually makes code simpler, I guess
Christian might be open to merging this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
