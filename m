Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACD606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtXS0vba
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A6710FB85;
	Thu, 19 Nov 2026 07:48:40 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CB410FEBF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:48:56 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-382f4710a17so1557541eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795024135; x=1795628935; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wr30cMHonchN/OcY5dnyS3PpKpMRWN/pwwCr/ZBhg8w=;
 b=FtXS0vbakocBfW2B4tAkTNiFsMglUkSY9TrZJ6A0Y2AKVEO+ky4Ckf48Gl9ZXyHeYz
 pbSnHhvs8nOVePJ14CFPMa8edO/8p1egH/GtnDLPGj/aNONj7/A4fznik8Y2D7/CQ/jt
 Xi6DDPkELixF4DtMIKDb8Y1afStQdc2uab0Kl1fv0WeY0YWwbcqhB4Zp1PciTcgG3OFg
 DzySNM5xRIQumLIIrCHqBiWf/TwbqhAQC+6jHulSGudRPQB5i0bFDCGJticXiwc1E2CW
 AVWlhSNi4+rj6j5KfcnLLoW0Xz6w0P0pELu0STZ1CbL8cIzT8Z/2t0nttvYJf6ailuOZ
 7m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024135; x=1795628935;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wr30cMHonchN/OcY5dnyS3PpKpMRWN/pwwCr/ZBhg8w=;
 b=Revf8X2G3bbaGrO0jfFDvLKuPruZNJsX5jyQnbFxXCJWVUL0fPMaA/qI6R7gTS/ffT
 bRYsdW6VswTyUxIcrspYhEfDcHzW7i/chU0GHnc5JbIzA1MOWo2iMNSLvbw7KjjrOogi
 0mFdzXB6k/osfe0rTjJVYkN1+Cefil1he0WveuPrdc8FxH3m58+F+mY8WkNGN6WkgQUH
 KkO5YL2l2eqIxyt5Mdg5jN5O+v953r82BCWu07QstJnjcfGJyXP6cJtl2+Qp4MWs7WOa
 NEdHjBAxXfxb6HjHtQlnli0NxPrJ1IRYlBE+h5upTWMfPInGx1OHxiECsldbpIxGe+51
 ED/g==
X-Forwarded-Encrypted: i=1;
 AL+hErFi9yLWQ88uq8X123tXMsqlz/Is69ribQpk/QQEme8ipdWgVi+5VXHcvedL3x6WNvgZ2un58Wcx1gI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/DOuS55p90zg9oEW9mj5fPvkvVlpLgkBR/eTxV0KPo0kHaPTr2
 sELECc59BupDYPi6uQCEA48hd8RqZtHPIjWYohxbRXDb35uLYWeYRLSe
X-Gm-Gg: AZFdTZdzIwQG4QX6LajFfRIHpGWsektKpaHHm+Ov5O/GBMN2aVRew9rcDWUhEAbVW3V
 Q6xGlJFdDCc4D54CK22qc5GQuKKEucGjOgsAClVpheOM+f4nYJA600VcNJUsNH20yPURs182naO
 7pdwrKkPtT02ifotTzaoQNNZH6RbDuceNpyd7l+X6EwxAWsuNYv1//secDWn+s75odO8ZbBIHAo
 IzlQVZpm/p0A6VqtpSJlG5uZf8NxLl9VzwDSt9ELh19W4/G108Gq99mI1Jg583n7zuExbw6d2e6
 W2aUXbZ5tJgmpWIfNDAOvI04+1T+dCJRUHkf1peNEg40JJVf97RZ25v9v5P+8CeOx9MIMLpJluQ
 bIhVHcKBWNG17xSc3QPEXyMmu/CXWzO2HvINHCUlB6i8jM1e2XYgs4prI5O94s9Ik35XMzj++WX
 jTteu/LJZtjsJKbD2GK+1UqX9Ero45oTX7LW6DD/KERJcSG7IOqhMFce1L8kDmitOE5uGHJrM21
 4gDg2KOBHpXV/SS5LqnM8HjCNfD79HE6cnBJcASTEJXoeJa/YrwjTAZagVTmqCcAmmuk6an/buR
 +fO3iGB5g8nt3xgjF4puzI2zv2+u6pIhvWr8RJtg0iSl8p1jpZkuJnGRmDUdqZmhNzzvjOs=
X-Received: by 2002:a05:7300:f793:b0:369:daea:812a with SMTP id
 5a478bee46e88-3828171b3a5mr2550884eec.30.1795024135142; 
 Wed, 18 Nov 2026 09:48:55 -0800 (PST)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a80bc19bsm9420878eec.29.2026.11.18.09.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:48:54 -0800 (PST)
From: Henry Zhang <henryzhang62@gmail.com>
To: mripard@kernel.org,
	mcanal@igalia.com
Cc: dave.stevenson@raspberrypi.com, kernel-list@raspberrypi.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, henryzhang62@gmail.com
Subject: Re: [PATCH] drm/vc4: dsi: Allocate the encoder per DRM device
Date: Wed, 18 Nov 2026 09:48:16 -0800
Message-ID: <20261118174816.1382711-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <av11cTfEuyFJW5h8@houat>
References: <20261117205902.1293962-1-henryzhang62@gmail.com>
 <av11cTfEuyFJW5h8@houat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026, Maxime Ripard wrote:
> On Tue, Nov 17, 2026 at 12:59:02PM -0800, Henry Zhang wrote:
> > The DSI encoder is embedded in struct vc4_dsi, which lives as long as
> > the DSI platform device
>
> That's not true.
>
> It's allocated with devm_drm_bridge_alloc() that will *not* free it in
> remove but give away its reference there.
>
> We have another reference taken in vc4_dsi_bind, that is only given up
> through a drm-managed action and thus will only be freed when the DRM
> device is destroyed.

You're right, thanks. struct vc4_dsi is refcounted through its bridge,
and the old DRM device keeps it alive. I'll fix that sentence. The
problem is not that struct vc4_dsi is freed too early, but that the
encoder embedded in it is used by two DRM devices at the same time.

> All vc4 components should be tied to the DRM device lifetime so that's
> not generally correct either. Something might have snuck back in though.

The encoder itself is DRM-managed: it is initialised with
drmm_encoder_init() and cleaned up when the DRM device is released.
But it is embedded in struct vc4_dsi, which outlives an unbind and is
shared by the next DRM device that binds the component. That part is
not tied to a single DRM device, since 6f0ca506c30e ("drm/vc4: dsi:
Switch to DRM-managed encoder initialization").

> Also, generally speaking, unloading panel drivers is unsupported at this
> point. It's a work in progress, but requires more changes to be safe.

Understood.

> This is surprising though. I'd like to see a detailed analysis of what's
> actually going on on mainline because it doesn't look right.

Maíra asked the same, so this answers both. It reproduces on
drm-misc-next (fb191ef62) on a Raspberry Pi 4, DSI1 in video mode, with
an out-of-tree DSI panel module and no downstream changes to vc4. The
compositor is stopped, a process holds /dev/dri/card1 open, the panel
module is unloaded and loaded again, then the held fd is closed:

1. Unloading the panel module detaches from the DSI host, which deletes
   the DSI component and unbinds vc4. The held fd keeps the old DRM
   device alive, with dsi->encoder still on its encoder list and the
   DSI bridge still attached to it.
2. Loading it again binds a new DRM device. vc4_dsi_bind() calls
   drmm_encoder_init() on the same dsi->encoder, which links it into
   the new device's encoder list.
3. drm_bridge_attach() returns -EBUSY, as the bridge still belongs to
   the old device, so the bind fails.
4. The failed bind releases the new DRM device. drm_encoder_cleanup()
   unlinks dsi->encoder and clears it, but the old device's encoder
   list still points to it.
5. Closing the held fd releases the old DRM device, which walks that
   list: list corruption, the WARN in drmm_encoder_alloc_release() and
   a NULL pointer dereference in drm_mode_config_cleanup().

Kprobes on drmm_encoder_init(), drm_bridge_attach() and
drm_encoder_cleanup() show it (condensed below). The old DRM device is
ffff000049249000, the new one ffff000041a79000, dsi->encoder is
ffff000044138000 and dsi->bridge ffff0000441380f0:

  223.656483 drmm_encoder_init    drm=ffff000041a79000 enc=ffff000044138000
  223.656520 drm_bridge_attach    enc=ffff000044138000 br=ffff0000441380f0
  223.656529 drm_bridge_attach    returned -16
  223.715147 drm_encoder_cleanup  enc=ffff000044138000 dev=ffff000041a79000
  (held fd closed)
  233.848952 drm_encoder_cleanup  enc=ffff0000409cca58 dev=ffff000049249000

and the first list_del report shows the cleared dsi->encoder.head
(ffff000044138008) still linked in the old device's list:

[  233.849039] list_del corruption. prev->next should be ffff0000409cca60, but was 0000000000000000. (prev=ffff000044138008)
[  233.849099] WARNING: lib/list_debug.c:62 at __list_del_entry_valid_or_report+0x128/0x160, CPU#0: python3/2080
[  233.849394] CPU: 0 UID: 0 PID: 2080 Comm: python3 Tainted: G         C O        7.4.0-rc2-dmn-test+ #1 PREEMPT(full) 
[  233.849424] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
[  233.849448] pc : __list_del_entry_valid_or_report+0x128/0x160
[  233.849465] lr : __list_del_entry_valid_or_report+0x128/0x160
[  233.849734] Call trace:
[  233.849744]  __list_del_entry_valid_or_report+0x128/0x160 (P)
[  233.849764]  drm_encoder_cleanup+0xcc/0x150 [drm]
[  233.849950]  drmm_encoder_alloc_release+0x24/0x40 [drm]
[  233.850090]  drm_managed_release+0xb0/0x178 [drm]
[  233.850231]  drm_dev_put.part.0+0x98/0xd0 [drm]
[  233.850371]  drm_minor_release+0x20/0x50 [drm]
[  233.850511]  drm_release+0x110/0x148 [drm]
[  233.850651]  __fput+0xd4/0x300
[  233.850672]  fput_close_sync+0x48/0x110
[  233.850690]  filp_close_sync+0x2c/0x48
[  233.850706]  put_files_struct+0xd4/0x148
[  233.850723]  exit_files+0x4c/0x70
[  233.850738]  do_exit+0x25c/0xa20
[  233.850756]  do_group_exit+0x3c/0xa0
[  233.850772]  get_signal+0x920/0xa18
[  233.850791]  arch_do_signal_or_restart+0xa0/0x3f8
[  233.850808]  exit_to_user_mode_loop+0x100/0x188
[  233.850825]  el0_svc+0x1cc/0x1d0
[  233.850845]  el0t_64_sync_handler+0xa0/0xe8
[  233.850864]  el0t_64_sync+0x198/0x1a0
[  233.850879] ---[ end trace 0000000000000000 ]---
[  233.869067] WARNING: drivers/gpu/drm/drm_encoder.c:228 at drmm_encoder_alloc_release+0x30/0x40 [drm], CPU#0: python3/2080
[  233.869478] CPU: 0 UID: 0 PID: 2080 Comm: python3 Tainted: G        WC O        7.4.0-rc2-dmn-test+ #1 PREEMPT(full) 
[  233.869506] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
[  233.869529] pc : drmm_encoder_alloc_release+0x30/0x40 [drm]
[  233.869668] lr : drm_managed_release+0xb0/0x178 [drm]
[  233.870051] Call trace:
[  233.870059]  drmm_encoder_alloc_release+0x30/0x40 [drm] (P)
[  233.870201]  drm_dev_put.part.0+0x98/0xd0 [drm]
[  233.870340]  drm_minor_release+0x20/0x50 [drm]
[  233.870479]  drm_release+0x110/0x148 [drm]
[  233.870619]  __fput+0xd4/0x300
[  233.870639]  fput_close_sync+0x48/0x110
[  233.870657]  filp_close_sync+0x2c/0x48
[  233.870672]  put_files_struct+0xd4/0x148
[  233.870688]  exit_files+0x4c/0x70
[  233.870703]  do_exit+0x25c/0xa20
[  233.870721]  do_group_exit+0x3c/0xa0
[  233.870737]  get_signal+0x920/0xa18
[  233.870755]  arch_do_signal_or_restart+0xa0/0x3f8
[  233.870772]  exit_to_user_mode_loop+0x100/0x188
[  233.870787]  el0_svc+0x1cc/0x1d0
[  233.870807]  el0t_64_sync_handler+0xa0/0xe8
[  233.870825]  el0t_64_sync+0x198/0x1a0
[  233.870839] ---[ end trace 0000000000000000 ]---
[two more list_del corruption reports with the same call trace cut]
[  233.875117] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[  233.875331] Internal error: Oops: 0000000096000004 [#1]  SMP
[  233.875631] CPU: 0 UID: 0 PID: 2080 Comm: python3 Tainted: G        WC O        7.4.0-rc2-dmn-test+ #1 PREEMPT(full) 
[  233.875679] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
[  233.875717] pc : drm_mode_config_cleanup+0x58/0x320 [drm]
[  233.875875] lr : drm_mode_config_init_release+0x18/0x30 [drm]
[  233.876371] Call trace:
[  233.876383]  drm_mode_config_cleanup+0x58/0x320 [drm] (P)
[  233.876539]  drm_mode_config_init_release+0x18/0x30 [drm]
[  233.876692]  drm_managed_release+0xb0/0x178 [drm]
[  233.876842]  drm_dev_put.part.0+0x98/0xd0 [drm]
[  233.876998]  drm_minor_release+0x20/0x50 [drm]
[  233.877149]  drm_release+0x110/0x148 [drm]
[  233.877299]  __fput+0xd4/0x300
[  233.877330]  fput_close_sync+0x48/0x110
[  233.877355]  filp_close_sync+0x2c/0x48
[  233.877377]  put_files_struct+0xd4/0x148
[  233.877400]  exit_files+0x4c/0x70
[  233.877422]  do_exit+0x25c/0xa20
[  233.877446]  do_group_exit+0x3c/0xa0
[  233.877469]  get_signal+0x920/0xa18
[  233.877494]  arch_do_signal_or_restart+0xa0/0x3f8
[  233.877519]  exit_to_user_mode_loop+0x100/0x188
[  233.877542]  el0_svc+0x1cc/0x1d0
[  233.877567]  el0t_64_sync_handler+0xa0/0xe8
[  233.877593]  el0t_64_sync+0x198/0x1a0
[  233.877620] Code: eb0102bf 54000160 d1002294 f9404001 (f9400421) 
[  233.877643] ---[ end trace 0000000000000000 ]---

Additional sanitized trace excerpts are available on request.

With the patch, the same test on the same kernel still fails the bind
with -EBUSY, but closing the held fd gives no warning or oops, and
loading the panel module again afterwards brings the display back. This
was one focused run per build, not a stress test, and the patch does
not make the rebind succeed while the old device holds the bridge.

Would you prefer a v2 with the corrected description and the mainline
trace, or should this go with the panel unloading work?

Thanks,
Henry
