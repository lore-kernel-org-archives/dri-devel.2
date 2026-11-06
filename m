Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791D606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZtngVeIz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lLu+zf76;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZtngVeIz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lLu+zf76
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B81310E2B6;
	Fri,  6 Nov 2026 07:16:26 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2555410E212;
 Fri,  6 Nov 2026 07:16:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 953F71FB91;
 Fri,  6 Nov 2026 07:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793949372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEtBKDb0MJ/hesgLaUZ1AmZ8Y49zDVocm3g03+nRNeE=;
 b=ZtngVeIz/TscJr8b9y5RTN9n5X+bg/cNRN00Oz2g+hFPMmLSmqsADPx22wIU+tW5frtTXf
 IWsmAsZ4rOlHuhJBlnrm/4U0uvbiJZCYS1DlBvBc4iO3kgpSMb8MxJgF+27T7U4KqY2x7/
 YeIetPUkth5XD3Y94Co75NmVA/cfwbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793949372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEtBKDb0MJ/hesgLaUZ1AmZ8Y49zDVocm3g03+nRNeE=;
 b=lLu+zf76rfClxEuSsGW0Ae6rkgGtWxyCr+fsvMkHXRmrwdiVDnipU6nREaSTFb11PVlnOU
 LX3GWXoWdJd0BjDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793949372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEtBKDb0MJ/hesgLaUZ1AmZ8Y49zDVocm3g03+nRNeE=;
 b=ZtngVeIz/TscJr8b9y5RTN9n5X+bg/cNRN00Oz2g+hFPMmLSmqsADPx22wIU+tW5frtTXf
 IWsmAsZ4rOlHuhJBlnrm/4U0uvbiJZCYS1DlBvBc4iO3kgpSMb8MxJgF+27T7U4KqY2x7/
 YeIetPUkth5XD3Y94Co75NmVA/cfwbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793949372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEtBKDb0MJ/hesgLaUZ1AmZ8Y49zDVocm3g03+nRNeE=;
 b=lLu+zf76rfClxEuSsGW0Ae6rkgGtWxyCr+fsvMkHXRmrwdiVDnipU6nREaSTFb11PVlnOU
 LX3GWXoWdJd0BjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CABA6134E9;
 Fri,  6 Nov 2026 07:16:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eUSTJ7t+7WpeLQAAD6G6ig
 (envelope-from <tiwai@suse.de>); Fri, 06 Nov 2026 07:16:11 +0000
Date: Fri, 06 Nov 2026 08:16:11 +0100
Message-ID: <87ld76qvk4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org,	intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,	Jani Nikula <jani.nikula@linux.intel.com>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,	Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,	Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,	Maxime Ripard
 <mripard@kernel.org>,	Thomas Zimmermann <tzimmermann@suse.de>,	David Airlie
 <airlied@gmail.com>,	Simona Vetter <simona@ffwll.ch>,	Takashi Iwai
 <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org,	Harry Wentland <harry.wentland@amd.com>,	Leo
 Li <sunpeng.li@amd.com>,	Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,	Lyude Paul <lyude@redhat.com>,	Danilo
 Krummrich <dakr@kernel.org>,	=?ISO-8859-2?Q?Tom=E1=B9?= Hnyk
 <tomashnyk@gmail.com>,	Wim Taymans <wtaymans@redhat.com>,
 nouveau@lists.freedesktop.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm: Populate ELD Port_ID to identify audio endpoints
In-Reply-To: <20261105160240.2850042-1-kai.vehmanen@linux.intel.com>
References: <20261105160240.2850042-1-kai.vehmanen@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[27]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,intel.com,ursulin.net,kernel.org,suse.de,gmail.com,ffwll.ch,suse.com,perex.cz,vger.kernel.org,amd.com,redhat.com];
 R_RATELIMIT(0.00)[to_ip_from(RL9y5169nakf5i7mj5a3kbj5yk)];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
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

On Thu, 05 Nov 2026 17:02:38 +0100,
Kai Vehmanen wrote:
> 
> The ELD Port_ID field (bytes 8..15 of the baseline block) is typically
> zero on Linux today: drm_edid_to_eld() leaves it empty and no in-tree driver
> fills it in. amdgpu, radeon and nouveau pass the raw connector->eld to
> the audio component. On the amdgpu DC Azalia register path the value
> is a hardcoded constant, the same for every port.
> Only closed display drivers fill the value.
> 
> Pipewire added support for "Port_ID" in merge request:
> https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/3025
> 
> As a result, when two identical monitors are connected their ELDs are
> byte-identical, and userspace (e.g. PipeWire/WirePlumber) cannot
> passively tell which HDMI/DP PCM belongs to which DRM connector.
> 
> This series adds a DRM helper that fills Port_ID with a common layout,
> and uses it in i915:
> 
>   bits 63:48 - PCI domain of the DRM device
>   bits 47:32 - PCI bus/device/function of the DRM device
>   bits 31:0  - DRM connector object ID
> 
> The upper half follows the layout documented for the AMD Azalia sink
> info registers (dce_audio.c: "PORT_ID1 = 16bit BDF"). The aim is for
> this to become a convention other drivers can opt into. For drivers
> that copy connector->eld to the audio component (amdgpu DM, radeon,
> nouveau), adopting it would be a one-line change. Comments from the
> AMD and nouveau folks on whether the layout works for them are very
> welcome.
> 
> An alternative would be to fill Port_ID directly in drm_edid_to_eld(),
> so every driver gets it without changes. I went with an opt-in helper
> to avoid changing the ELD contents seen by all drivers and existing
> userspace at once.
> 
> The value is exposed to userspace via the ALSA ELD control and
> /proc/asound/cardX/eld#Y.
> 
> Kai Vehmanen (2):
>   drm/eld: Add drm_eld_set_port_id() helper
>   drm/i915/audio: Populate ELD Port_ID

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
