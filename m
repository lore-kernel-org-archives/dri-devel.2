Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6D0C5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A6C10E416;
	Wed, 12 Aug 2026 14:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Vk+Efjvz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7tVU6ovb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wJwaCONb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e7bHqRWr";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248E110E41F;
 Wed, 12 Aug 2026 14:30:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B13F3DF3;
 Wed, 12 Aug 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786545053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4DT9tBNyLwA3sWYorDlzSqDnUt2SRFG6qIwU3+DA56M=;
 b=Vk+EfjvznafJpSvUaElBpfEe96XH6oqZvgLnmwvgqfXAQDUWJ9Wa6WyOV6ZCKicIDectoS
 AQTTJ1L13x2ItZ5uBqB5aZ56qokYoG87U/EBIQIkyFhW7h4Mwd6PX/OZf1BWn3fQgfdYVP
 e6ld6N8R8MZLtB9lPc5VmpuG8ac37sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786545053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4DT9tBNyLwA3sWYorDlzSqDnUt2SRFG6qIwU3+DA56M=;
 b=7tVU6ovbwczQBGga1c0KdYXGyH3nMsI8t9lOhlhN5jwDKR8cNd/taRkVj2B/l4qRKrv/66
 kpTeCdbuW54Se2Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786545049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4DT9tBNyLwA3sWYorDlzSqDnUt2SRFG6qIwU3+DA56M=;
 b=wJwaCONbUbIevo2lmTM6cdDi8WqoBaXTz62hlTf+zlAjqFpKlz3102HseuKwQP+UZ3Cs74
 5qLtEDlgSRMKAyCm5RnlClosUA8DeazukTRaXRhq7Rxq1pIyoHGnOFfas8QUqDylhkcPme
 TslYRAB2UMdIkKo/jHOaDqjJgPqN9rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786545049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4DT9tBNyLwA3sWYorDlzSqDnUt2SRFG6qIwU3+DA56M=;
 b=e7bHqRWrR6D/DtEX+WVZ8G4obDt527IgS8pYeLucUmf+PaPkd56vRRWWeuYjZd2QsPKe/N
 KaEkjEozhTCYqlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3E64779B1;
 Wed, 12 Aug 2026 14:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9EoSM5iDfGoZIQAAD6G6ig
 (envelope-from <tiwai@suse.de>); Wed, 12 Aug 2026 14:30:48 +0000
Date: Wed, 12 Aug 2026 16:30:44 +0200
Message-ID: <87bjb7za0b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andre Eikmeyer <dev@deq.rocks>
Cc: Takashi Iwai <tiwai@suse.de>,	platform-driver-x86@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,	linux-sound@vger.kernel.org,	Atharva Tiwari
 <atharvatiwarilinuxdev@gmail.com>,	Hans de Goede <hansg@kernel.org>,	Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,	Alex Deucher
 <alexander.deucher@amd.com>,	Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,	David Airlie <airlied@gmail.com>,	Simona Vetter
 <simona@ffwll.ch>,	Kenneth Feng <kenneth.feng@amd.com>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Harry Wentland
 <harry.wentland@amd.com>,	Leo Li <sunpeng.li@amd.com>,
 dri-devel@lists.freedesktop.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: allow direct complete with a
 powered-off GPU
In-Reply-To: <20260812142300.34472-1-dev@deq.rocks>
References: <20260812140347.33360-1-dev@deq.rocks>
 <20260812142300.34472-1-dev@deq.rocks>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,lists.freedesktop.org,gmail.com,kernel.org,linux.intel.com,amd.com,ffwll.ch,perex.cz,suse.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[deq.rocks:email, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

On Wed, 12 Aug 2026 16:23:00 +0200,
Andre Eikmeyer wrote:
> 
> The HDA controller normally needs different WAKEEN settings for runtime and
> system suspend, so azx_prepare() prevents direct complete. For a switcheroo
> audio client whose bound GPU is already runtime suspended and switched off,
> however, the controller is physically inaccessible and cannot signal wake
> events.
> 
> Resuming the HDA function during system suspend also acquires its runtime
> PM supplier. This powers the discrete GPU back on only to suspend it again
> and can expose failures while restoring an otherwise unused GPU.
> 
> Direct complete is now allowed when the bound VGA device is both runtime
> suspended and reported off by vga_switcheroo. Active GPUs and HDA
> controllers without a switcheroo binding retain the existing WAKEEN
> transition.
> 
> This was tested as part of the MacBookPro15,1 hybrid graphics series on
> both the 2018 and 2019 revisions. The discrete GPU remains powered off
> across system suspend when it is unused, and suspend and resume complete
> successfully.
> 
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
> Changes in v3:
> - Rework the conditional compilation as suggested in the follow-up review.
> - Keep the switcheroo implementation in the existing switcheroo section.
> 
> The follow-up review crossed with the v2 submission.
> 
> Changes in v2:
> - Explain the significance of the positive azx_prepare() return value.

Feel free to take my ack:

Reviewed-by: Takashi Iwai <tiwai@suse.de>

But I guess you'd need to refresh the patch descriptions in other two
patches in the series, so better to resubmit the whole series with
corrected patches :)


thanks,

Takashi
