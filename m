Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C48AC5CFEE
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A43210EFE2;
	Wed, 12 Aug 2026 13:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="W2WRMx3n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E6m7KlUK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IQDkptee";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gRw1lh2V";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10A510EFDF;
 Wed, 12 Aug 2026 13:45:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F4733E61;
 Wed, 12 Aug 2026 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786542336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Okam1Xv7qZj9TOT1CoF8I6lo9QA/fBV4+wzsnLl20Wk=;
 b=W2WRMx3nLeuMDxrPfK1KoqLGRq3i+XP9a3++BYm4wpzl5HycPHeTOvIWOVe4/C2LX6wo7B
 TMx80GbjRuq8/LYGi8IujUs0i1VbMehpX2O6wyUnQLkpc9omh2ua+yhyTkTH9CMjsRp/ZZ
 EQPSu0EzBKJ4N26fFsa/DfRJT7JT0iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786542336;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Okam1Xv7qZj9TOT1CoF8I6lo9QA/fBV4+wzsnLl20Wk=;
 b=E6m7KlUKWHnzkp6RioNdyePMYAyIOGc08MQ/oSAyLkbO9n1YmD1GlsKjVOJvVz+7YbAFqu
 IyLY9sOsgyeeTxDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IQDkptee;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gRw1lh2V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786542332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Okam1Xv7qZj9TOT1CoF8I6lo9QA/fBV4+wzsnLl20Wk=;
 b=IQDkpteeBHxkJg2gToumMklkvJOMyasX3Hn8hz6ofS8I18w4xokD7gpj+5D893D78DagmQ
 UbcBlQhSzi/jbjazXZj27yC7N8idXgNDeuqkIvenfoTaiaQ6C+g3w0lARJpJGALSHvFamD
 SbnrWU2bmrSqm/ekmx6nG6cNtFv3EOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786542332;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Okam1Xv7qZj9TOT1CoF8I6lo9QA/fBV4+wzsnLl20Wk=;
 b=gRw1lh2VyIMoAtS27ouVSd6+ObbnxeiMEQ9DCsb1OTDlAOwNbXJNz7+iEGFor37+AN6C5/
 0RyP/V6oNC2pnlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6709779B1;
 Wed, 12 Aug 2026 13:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2XOUN/t4fGq8cwAAD6G6ig
 (envelope-from <tiwai@suse.de>); Wed, 12 Aug 2026 13:45:31 +0000
Date: Wed, 12 Aug 2026 15:45:27 +0200
Message-ID: <87mrurzc3s.wl-tiwai@suse.de>
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
In-Reply-To: <20260812122206.193680-4-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812122206.193680-4-dev@deq.rocks>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2F4733E61
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com,kernel.org,linux.intel.com,amd.com,ffwll.ch,perex.cz,suse.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

On Wed, 12 Aug 2026 14:22:06 +0200,
Andre Eikmeyer wrote:
> 
> Hello everyone,
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
> Thank you for your time and consideration.
> 
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

Please drop greeting and thank-you texts.  They can be put in the
cover letter, but not in each patch description.

About the code changes:

> +static bool azx_vga_is_powered_off(struct azx *chip)
> +{
> +#ifdef SUPPORT_VGA_SWITCHEROO
> +	struct pci_dev *pci;
> +	bool powered_off = false;
> +
> +	if (!use_vga_switcheroo(container_of(chip, struct hda_intel, chip)))
> +		return false;
> +
> +	pci = get_bound_vga(chip->pci);
> +	if (pci) {
> +		powered_off = pm_runtime_suspended(&pci->dev) &&
> +			vga_switcheroo_get_client_state(pci) == VGA_SWITCHEROO_OFF;
> +		pci_dev_put(pci);
> +	}
> +
> +	return powered_off;
> +#else
> +	return false;
> +#endif
> +}

This ifdef can be moved to the caller side below...

> +
>  static int azx_prepare(struct device *dev)
>  {
>  	struct snd_card *card = dev_get_drvdata(dev);
> @@ -1025,6 +1048,10 @@ static int azx_prepare(struct device *dev)
>  		return 0;
>  
>  	chip = card->private_data;
> +	/* A powered-off dGPU cannot signal HDA wake events. */
> +	if (azx_vga_is_powered_off(chip))
> +		return 1;
> +

... to wrap the call site, instead.  Since this is the only caller,
having the conditional here would make the intention clearer.

Also, a comment about what "return 1" plays here would be helpful for
readers.  It's a small piece but has a significant meaning.


thanks,

Takashi
