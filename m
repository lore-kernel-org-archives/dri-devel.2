Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9908AC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2BC10F00A;
	Wed, 12 Aug 2026 13:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Cc02pna2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lKJo1p7J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EI87GtyM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YsWhsfJY";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F276110F021;
 Wed, 12 Aug 2026 13:54:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34A8A822F3;
 Wed, 12 Aug 2026 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786542846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcTsi9mTEu/AweH+B/eF0oCGDKGYVPBNZGrykR66RMk=;
 b=Cc02pna2wy+wF3esksu7cnKMuQu1KzM27lJ3z/lCxdqz8Hi15jqn6USxoVVKGsa1pyZJGY
 6xxKJ9ZeHC8LH0A0q4Ut3rqdecziJdvI+kVPPJl7NMedlWkeC5I5eC7Deeqf5Lm4gCt0O1
 c/ZDzNHyPO3xob+bAU3jqRsRcO5WDUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786542846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcTsi9mTEu/AweH+B/eF0oCGDKGYVPBNZGrykR66RMk=;
 b=lKJo1p7JpRBx3HBJydkEemscHVYl3ohOMSBQ+KS4V4M6qCa7kgeQd3t/t5iREWy6dDaA/E
 NZtcOc41maCIJ2Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786542842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcTsi9mTEu/AweH+B/eF0oCGDKGYVPBNZGrykR66RMk=;
 b=EI87GtyMcEH1bvWHzroG+knQ+uc5lJYV3k8q2zU5cvkQo90qaLUrkcPB3SB/N665Cl1WHw
 HYpSX5GyuDK38q2T8RKqOsVXrGOziJuAP6eOzpiYq4mSuUzRksdPUEYLtxmbS5fLW2j9NX
 Th/iPSp6dcF2ZVngvaRpUatwRQCPbP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786542842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcTsi9mTEu/AweH+B/eF0oCGDKGYVPBNZGrykR66RMk=;
 b=YsWhsfJY5Ho2SMFvwS+uH5CkdOIvogrWUAsEeXGWULb99UDuTS+SvP/gnQvx83/iPz9mKj
 ijoqk92VeenLjVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2232779B1;
 Wed, 12 Aug 2026 13:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dnWrMvl6fGpUfAAAD6G6ig
 (envelope-from <tiwai@suse.de>); Wed, 12 Aug 2026 13:54:01 +0000
Date: Wed, 12 Aug 2026 15:53:57 +0200
Message-ID: <87ik5fzbpm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andre Eikmeyer <dev@deq.rocks>
Cc: platform-driver-x86@vger.kernel.org,	amd-gfx@lists.freedesktop.org,
 linux-sound@vger.kernel.org,	Atharva Tiwari
 <atharvatiwarilinuxdev@gmail.com>,	Hans de Goede <hansg@kernel.org>,	Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,	Alex Deucher
 <alexander.deucher@amd.com>,	Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,	David Airlie <airlied@gmail.com>,	Simona Vetter
 <simona@ffwll.ch>,	Kenneth Feng <kenneth.feng@amd.com>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,
 dri-devel@lists.freedesktop.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ALSA: hda: allow direct complete with a powered-off
 GPU
In-Reply-To: <87mrurzc3s.wl-tiwai@suse.de>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812122206.193680-4-dev@deq.rocks>
 <87mrurzc3s.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com,kernel.org,linux.intel.com,amd.com,ffwll.ch,perex.cz,suse.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

On Wed, 12 Aug 2026 15:45:27 +0200,
Takashi Iwai wrote:
> 
> On Wed, 12 Aug 2026 14:22:06 +0200,
> Andre Eikmeyer wrote:
> > 
> > +static bool azx_vga_is_powered_off(struct azx *chip)
> > +{
> > +#ifdef SUPPORT_VGA_SWITCHEROO
> > +	struct pci_dev *pci;
> > +	bool powered_off = false;
> > +
> > +	if (!use_vga_switcheroo(container_of(chip, struct hda_intel, chip)))
> > +		return false;
> > +
> > +	pci = get_bound_vga(chip->pci);
> > +	if (pci) {
> > +		powered_off = pm_runtime_suspended(&pci->dev) &&
> > +			vga_switcheroo_get_client_state(pci) == VGA_SWITCHEROO_OFF;
> > +		pci_dev_put(pci);
> > +	}
> > +
> > +	return powered_off;
> > +#else
> > +	return false;
> > +#endif
> > +}
> 
> This ifdef can be moved to the caller side below...
> 
> > +
> >  static int azx_prepare(struct device *dev)
> >  {
> >  	struct snd_card *card = dev_get_drvdata(dev);
> > @@ -1025,6 +1048,10 @@ static int azx_prepare(struct device *dev)
> >  		return 0;
> >  
> >  	chip = card->private_data;
> > +	/* A powered-off dGPU cannot signal HDA wake events. */
> > +	if (azx_vga_is_powered_off(chip))
> > +		return 1;
> > +
> 
> ... to wrap the call site, instead.  Since this is the only caller,
> having the conditional here would make the intention clearer.

Looking at the code again, this won't work well.

But, keeping vga_switcheroo-specific code in a single place would be
still meaningful.  So,

 #ifdef SUPPORT_VGA_SWITCHEROO
 #define use_vga_switcheroo(chip)	((chip)->use_vga_switcheroo)
 #define needs_eld_notify_link(chip)	((chip)->bus.keep_power)
+static bool azx_vga_is_powered_off(struct azx *chip);
 #else
 #define use_vga_switcheroo(chip)	0
 #define needs_eld_notify_link(chip)	false
+#define azx_vga_is_powered_off(chip)	false
 #endif

and then define azx_vga_is_powered_off() in the section for
vga_switcheroo code.

In anyway, it's a matter of taste, and if the resultant patch doesn't
look better, you can keep the original way, too.


thanks,

Takashi
