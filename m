Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9C4C5DF67
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC3E10E60A;
	Sat, 15 Aug 2026 20:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rdUI/dIA";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F2010E60F
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 20:42:54 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f502ff678so249771f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786826573; x=1787431373; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g3g0AYahBP3aN4rc9/ufJfxyt9G+mfOpDwe9Ft7yd84=;
 b=rdUI/dIAnv2Xvq6rGHzm6m3NBm0wd2xwWB1whqXTJh7P9n95WYwkFNz0h4C97HbGAu
 OdixsszI65tYlTgsKELPesdg+fYEYmRFR6zTtK0eG8ZmWwGBAjegwxmV6OymLIA/b3BS
 awEGaK9eC7c6HmZGQKxcdZpS+CUXTx3c3oDE+MA9Z9KSHCNfd72tGStc8hkFu6vImg1J
 /PcPuwXrOiOMjjTEEFdbNHYtSynpiISYV53L0awVTMdeYfFXz9NxXvX1elynS83MJ163
 SrmuQ4rl9dkwOGHVmDIu+NQueDYWyA6W5rkm3wSJXqr6qeHt1o5pvWFQZQVih2bD6LU/
 g/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826573; x=1787431373;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g3g0AYahBP3aN4rc9/ufJfxyt9G+mfOpDwe9Ft7yd84=;
 b=qzSxEJRRZV9865jFJBtbjysBXD6InX4ORZFCM52adWPA7n+NFbBc8O9uHct6sOZL6N
 r7rY/OTBOdRhXA4CV36P6VH58CY170Og5Fj2LjHOC+u0lPpx/2XygxGqWjsTeAQ1hCmz
 EBlncQE/tJlIOXHicdfpFuikddpfUzmnPMUi6QPWvaWzsJnUbSnxRlxKpbnTuwQ0K18q
 lET0qFgOXy23L41fP2MYSwDtTEyHYlk83tV3+UvriSRTgTSoWqGuDmFw+Uar2CDEW61P
 ioBDY3Er51eY4SUVjAuCE3qkIi8wOsPAbrcr3IWGDdQueAgM9uJE9iaYdb3yz3gthh7a
 Ym3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp725wIZJFcZvLpWqT9ufRBbaJJkVgBo3KwWLP4JbOz7/usAkCveEzE9rT0ih9lbycwOmbBkUKYA0Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySgZCkgxrZv/6IQKobhJzcWZ3xef7hux+c782r0ZTM12XFn/st
 2kYEvjx1c0e9Oct7a94HB+qZSCmuG8hNutukQLDpCtfR2x1HXkT8C3Ge
X-Gm-Gg: AR+sD12GnuJcvExVPL+cREwThIe5yBOEYTWtjsAtcQBwobq7ixsJE9y4DPZfUxZ2lgH
 rUUC0pwg/RP/2ExS0RAVr+JP5Bf1ld90a/8V4ajuhOsVVFKeeDvjXq0RwrFvbL/1D+tkcpw7Tyx
 Bwsr0UI9gjjaeKcBslLCCLqHtPyljuDuJg/l99SRbLsb4VmODNRwoc/6yCjoahndGE63wx1QD3O
 TDnnujspRTxSGwb/nSwKP85CtkhyUNuqXQWIrbMlKuWmXv+tVutY9zb98FhIJ5oKhJKZ7lmsS4k
 U+V6gRJw7sKGG5WXJlccOivqzeQAEwy+RHt3gboY24VK6/d+c1aoX+yfMT4pEptQuMdJW3qOoag
 MJA1MMsT4Z3sAVnrSM0bg1YNBNouEf6dB5z5/Q85uB9JwPSRFEQrRADRlrC3ZcMMSPW/2Pob9/p
 WHE5s2fg2mwRsj680Gv4OrDUXj95+0W9w96bw4Ji/X7f1B/b37XTo6Emq2OBjNsE4dLRQWGOEfE
 +QdSAVQ1riO1opCOcS9tCNsTpAasmh8a7q1jnsTcw==
X-Received: by 2002:a05:600c:354f:b0:495:650b:4c61 with SMTP id
 5b1f17b1804b1-499879690acmr105425405e9.3.1786826572997; 
 Sat, 15 Aug 2026 13:42:52 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899afa39sm164118155e9.2.2026.08.15.13.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:42:52 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: sashiko-bot@kernel.org, linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 2/3] drm/nouveau: cancel the DP IRQ work before freeing
 the connector
Date: Sat, 15 Aug 2026 22:42:51 +0200
Message-ID: <178682657122.3795552.6920623796751043528@gmail.com>
In-Reply-To: <20260815201130.7BDDF1F000E9@smtp.kernel.org>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.4096452389040554615@gmail.com>
 <20260815201130.7BDDF1F000E9@smtp.kernel.org>
X-Mailer: python-smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Three findings, three different answers, so let me take them in turn.

The NULL dereference in nouveau_dp_irq() is 3/3 of this series.  Same
thread, sent alongside this patch.  Nothing further needed there, and
the two are related on purpose: 2/3 drains the work, 3/3 fixes the
handler that work runs.

The LVDS error path in nouveau_connector_create() is real as far as I
can see, and independent of anything here.  drm_connector_init() has
already put the connector on dev->mode_config.connector_list when the
nouveau_bios_parse_lvds_table() failure path kfree()s it without
drm_connector_cleanup().  I am not touching it in this series; it wants
its own patch and I have no way to reach that path on my hardware.

The hpd_work point is the interesting one, and I owe a correction on it.

2/3 does not create that path.  Without this patch the same already
queued irq_work still runs to completion and still ends in
nouveau_connector_hpd(), which schedules drm->hpd_work under
drm->hpd_lock; the only thing this patch adds is that the destroy now
waits for it.  If anything that narrows the exposure, because without
the wait the work can run later still, potentially after the connector
is gone.  That is the bug 2/3 is about.

But the wider question the bot is asking is fair, and my cover letter
answered it too confidently.  It says "there is no fourth patch here"
on the strength of drm->hpd_work being drained in
nouveau_display_fini().  Having looked again after the bot's mail: that
drain runs at nouveau_display.c:600 under "if (!runtime &&
!drm->headless)", and disp->fini() drains it a second time under the
same condition (dispnv50/disp.c:2686, dispnv04/disp.c:72, which I had
not spotted when I wrote the cover).  Both of those are before
drm_mode_config_cleanup() reaches nouveau_connector_destroy().  So a
late irq_work really can re-arm hpd_work after every drain, and nothing
drains it again.  Whether that is reachable in practice I do not know:
nvif_event_block() on conn->irq has already run by then, so it needs
work that was queued before the block and has not run yet.

I cannot rule it out, so I should not have written that sentence as a
finding.  It should have said that I looked and did not find a fourth
patch, not that there is none.  If the maintainers want, the shape of a
fix is probably a drain of hpd_work after the connectors are gone, or
making nouveau_connector_hpd() a no-op once teardown has started, but
that is a separate change from this series and I would rather someone
who knows the hotplug path weighs in before I write it.

For the avoidance of doubt: 2/3 and 3/3 still stand as posted.  1/3 is
withdrawn, for an unrelated reason, in the sibling thread.
