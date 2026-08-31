Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17E8C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA00B10E32F;
	Mon, 31 Aug 2026 18:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.b="EgqhIPcq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nC7rEa1U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YBeAtZKL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="juclcREm";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E754E10E32F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:46:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 191091FB39;
 Mon, 31 Aug 2026 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788202005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adPvtYMwlgxXQ7Oro16VusI6wUrO/bduGmk63+FTmQ4=;
 b=EgqhIPcqIK8FOzqYEOSSv9p+T1HfHj5DIjT4niyvTAAnTF8nQlWNP2iGHHzjAW5UobtSUv
 QizLi6KssgDUVVr7DdgSeUkY347Sn7153mdnh10gj34iRa19Q7iE1QA/km9861Ap9DT/qa
 tmo3Juclu3TtmOwiAOBLx4Nl1Y228PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788202005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adPvtYMwlgxXQ7Oro16VusI6wUrO/bduGmk63+FTmQ4=;
 b=nC7rEa1UZn0b9zKsR6rgGO2TYjJqzecwwlroyp6adoTDGLc+dlcGmG2zz0iEzfce7I+X42
 SzDZc8CkkL+CF1Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788202001;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adPvtYMwlgxXQ7Oro16VusI6wUrO/bduGmk63+FTmQ4=;
 b=YBeAtZKLYr8NtYYPfHWJQUldf93VyDOEumoXoW+ykPuYyMRlTNdEO5OAd7fXBCeo3l0tON
 JJgOmRZk1kNYLcTzsSCRpqSy1sqtOhgLMOOG0pCMJXWQkao0iQIQBbfY2kt1ZTRAk+Z68T
 e5dyDE4gTMRnq49DY18WARNKfUtgO3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788202001;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adPvtYMwlgxXQ7Oro16VusI6wUrO/bduGmk63+FTmQ4=;
 b=juclcREmfFICsNOJD/esOOaytQBVFtbNrNCbkyV6xizRTEyDrKjjM3op70xyF/5n3qpasZ
 Rhv6ZjYDoYaEMlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4E9913515;
 Mon, 31 Aug 2026 18:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RfE2KxDMlWridQAAD6G6ig
 (envelope-from <dsterba@suse.cz>); Mon, 31 Aug 2026 18:46:40 +0000
Date: Mon, 31 Aug 2026 20:46:31 +0200
From: David Sterba <dsterba@suse.cz>
To: David Gow <david@davidgow.net>
Cc: Jim Cromie <jim.cromie@gmail.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chris Mason <mason@kernel.org>, David Sterba <dsterba@suse.com>,
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fs:btrfs: Use the new global is_power_of_2_u64()
 helper
Message-ID: <20260831184631.GI9053@twin.jikos.cz>
References: <20260830103321.2042968-1-david@davidgow.net>
 <20260830103321.2042968-3-david@davidgow.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830103321.2042968-3-david@davidgow.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 HAS_REPLYTO(0.30)[dsterba@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 TAGGED_RCPT(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[14];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,orcam.me.uk,linux-foundation.org,intel.com,amd.com,nvidia.com,ffwll.ch,kernel.org,suse.com,lists.freedesktop.org,vger.kernel.org];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; REPLYTO_ADDR_EQ_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,davidgow.net:email,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
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
Reply-To: dsterba@suse.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sun, Aug 30, 2026 at 06:33:17PM +0800, David Gow wrote:
> btrfs currently provides its own 64-bit safe version of
> is_power_of_2(), in order to handle 64-bit values on 32-bit systems.
> 
> Since other subsystems also have similar helpers, a new implementation
> has been added to linux/log2.h. Use this instead of the btrfs-specific
> one.
> 
> Signed-off-by: David Gow <david@davidgow.net>
> ---
> 
> This basically just replaces a btrfs helper with the version in patch 1.
> It probably doesn't make sense for this series to go in via the btrfs
> tree, so it's probably worth either accepting the posssibility for a
> conflict, or sending this patch in separately after the first one lands.

Acked-by: David Sterba <dsterba@suse.com>

As this is library API cleanup, feel free to take it with the rest of
the series.
