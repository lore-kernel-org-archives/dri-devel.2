Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B51BC982C7
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3B110E7B5;
	Wed, 16 Sep 2026 07:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="uBBYtunF";
	dkim-atps=neutral
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81EA10F34C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:19:50 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-86fa6b15ed3so2266955b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460390; x=1790065190;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cTJ+iDaVRz+oQczzBBEu9x7Pp5Lm2h3B0iGAZglcmy4=;
 b=uBBYtunF36eNPA7T+vEJGUBpte8YSOgOBhOFZHDVGG0IDYIypIZ6h97TYDNP+78GQ9
 yBeSyNuJoyo66vb7XPffdDO0ePG6d4KCJ0hBPpZ5zOmwYFITWhjm7X0338ZvomPcWiq+
 CvrwmZ3WHVX5nqAy/gOl+uTYoalDnbzCdE45e6I0X/iYzmlGPrrPsDazGd4e+9faCzcF
 cQWk9x6+23RXwIuN8bdI4smW+XEJbhe1FqSY7wV/5/sG6O61KSi6TF/b/GsepuSWnqRq
 sIpJes3lDRvQDvpCQf8IlSwlIun4E1oEWdbwDuajELzSbmNrs7bDpv+RZcLavN8rjfo9
 5VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460390; x=1790065190;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cTJ+iDaVRz+oQczzBBEu9x7Pp5Lm2h3B0iGAZglcmy4=;
 b=YUHzKSNuMTSOeFju3iNTQa+9w6RT2Kb93ROijNVOTrgjlKNAjOQRoMZVP4ReqiC5oh
 erjuziwe8nGoAG6aw7k0uuT0UPO2+RxhtfaONztx7aeCXr8+/HVt4spn8l47HM7Rl/gy
 eCOrxhZ5qOC41L1zPfAdHbyyCsU7NERfzeSsNTPIyzs74xK/ep7P8XL2h38ScROTZiw7
 x2aw5WwZBZ5/SfZAaPKfx3CwSfnf4vLkbUxoayZJXXaejfeAw4NOCwfN41hrodGr3ifX
 kuydNklblLS6FvxiVFJwx5T4EdtQCvolMqqrTQ+qh/T/E40axCIL2snqa0MxNdVgw8Vi
 K1kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx20NhKJTzy4y7snA1nipcdDYSsu/EDCEARNVPrlDwabTRD73/l+CkmHPRo0s+FDqxS5DIfW/7QokU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lSZCa9zRF/AHGqLwsppzp763rqF11sbpghsJj2jtbN7KNQRPgh
 tqP1pfCCBaS6QA+Lc+ElzoDIVjXRSUe6jCFBfV7Y8sIHocky4hwTyhPeE9IqAMhCbBbK9DoTe16
 M
X-Received: from pgbo14.prod.google.com ([2002:a63:5a0e:0:b0:cc4:337f:e10f])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7d9f:b0:3b4:61f:1fec
 with SMTP id adf61e73a8af0-3db4038ec7cmr15429477637.2.1789460388838; Tue, 15
 Sep 2026 01:19:48 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-1-morbo@google.com>
Subject: [PATCH 00/28] Replace remaining strlcat() call sites with
 snprintf()/seq_buf()
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Matthias Schwarzott <zzam@gentoo.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "Martin K. Petersen" <mkp@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Kees Cook <kees@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Chuck Lever <cel@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qiang Ma <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>,
 Breno Leitao <leitao@debian.org>, Thorsten Blum <blum@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Johan Hovold <johan@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>,
 Jiaming Zhang <r772577952@gmail.com>, 
 Will Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
 "=?UTF-8?q?C=C3=A1ssio=20Gabriel?=" <cassiogabrielcontato@gmail.com>,
 Rong Zhang <i@rong.moe>, 
 Arun Raghavan <arunr@valvesoftware.com>, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-edac@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-input@vger.kernel.org, linux-media@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, devicetree@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org, 
 devel@lists.orangefs.org, linux-hardening@vger.kernel.org, 
 linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

strlcat() is deprecated: like strcat(), it requires re-scanning the
destination string from the beginning on every call, which is O(n^2)
when used to build up a string incrementally, and its truncation
behavior is easy to get wrong. See:

  https://github.com/KSPP/linux/issues/370

This series removes the remaining strlcat() call sites in the tree
(plus the one inside fortify-string.h's strcat() implementation
itself), replacing each with snprintf(), scnprintf(), or the seq_buf()
API, whichever best fits the surrounding code.

One unrelated fix is included. While auditing drivers/edac/thunderx_edac.c
for its strlcat() conversion, "EDAC/thunderx: Fix stale error context in
thunderx_l2c_threaded_isr()" addresses a pre-existing bug, present since
the driver's original 2017 commit: thunderx_l2c_threaded_isr() computes
its ring "tail"/"ctx" once before its drain loop and never recomputes
them per iteration, unlike the analogous OCX handlers in the same file,
so it re-reports the same ring entry for every queued error instead of
draining the ring. It's split out as its own patch, ahead of the
strlcat() conversion for that file, so it can be reviewed and
backported independently of the rest of this series.

Bill Wendling (28):
  ALSA: ac97: Refactor snd_ac97_get_name() to use snprintf()
  sunrpc: Refactor rpc_sockaddr2uaddr() to use snprintf() instead of
    strlcat()
  ARM: atags: Replace strlcat() with snprintf() for cmdline extend
  scsi: bfa: Use snprintf() in bfa_fcs_fabric_nsymb_init()
  ALSA: usb-audio: Refactor usb_audio_make_longname() to use seq_buf
  comedi: comedi_bond: Refactor strlcat() to seq_buf in do_dev_config()
  scsi: bfa: Use snprintf() in bfa_fcs_fabric_psymb_init()
  devlink: Refactor strlcat() to seq_buf in
    __devlink_compat_running_version()
  drm/dp_mst: Refactor build_mst_prop_path() to use seq_buf
  of/fdt: Replace strlcat() with snprintf() in
    early_init_dt_scan_chosen()
  wifi: brcmfmac: Replace strlcat() with snprintf() in
    brcmf_fw_alloc_request()
  fortify: Convert strlcat() to snprintf() in strcat()
  i40e: Replace strlcat() with snprintf() in i40e_nvm_version_str()
  ALSA: usb-audio: Refactor append_ctl_name() to use snprintf()
  orangefs: Use seq_buf for debug help string generation
  pinctrl: samsung: Use snprintf() to construct pin bank names
  MIPS: cmdline: Refactor bootcmdline_append() to use snprintf()
  LoongArch: Refactor bootcmdline_init() to use seq_buf instead of
    strlcat()
  x86/setup: Use snprintf() to concatenate builtin and boot command
    lines
  parisc: Refactor strlcat() to seq_buf in setup_cmdline()
  NFS: nfsroot: Refactor root_nfs_cat() to use snprintf()
  media: si2165: Use snprintf() to format frontend name
  Input: synaptics_usb - use seq_buf and snprintf() for name and phys
  EDAC/thunderx: Fix stale error context in thunderx_l2c_threaded_isr()
  EDAC/thunderx: Replace strlcat() with seq_buf
  wifi: wil6210: Refactor resume_triggers2string() to use seq_buf
  drm/xe/pf: Convert strlcat() to seq_buf in control_read()
  drm/xe/pf: Refactor strlcat() to seq_buf in sched_group_engines_read()

 arch/arm/kernel/atags_parse.c                 |  7 +-
 arch/loongarch/kernel/setup.c                 | 22 +++--
 arch/mips/kernel/setup.c                      | 21 ++++-
 arch/parisc/kernel/setup.c                    | 16 ++--
 arch/x86/kernel/setup.c                       |  8 +-
 drivers/comedi/drivers/comedi_bond.c          | 16 ++--
 drivers/edac/thunderx_edac.c                  | 67 ++++++++++------
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 15 ++--
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c   | 24 +++---
 drivers/input/mouse/synaptics_usb.c           | 29 ++++---
 drivers/media/dvb-frontends/si2165.c          | 17 ++--
 drivers/net/ethernet/intel/i40e/i40e.h        | 15 +++-
 drivers/net/wireless/ath/wil6210/wmi.c        | 38 +++++----
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 21 ++---
 drivers/of/fdt.c                              | 11 ++-
 drivers/pinctrl/samsung/pinctrl-samsung.c     |  3 +-
 drivers/scsi/bfa/bfa_fcs.c                    | 80 +++++--------------
 fs/nfs/nfsroot.c                              | 11 ++-
 fs/orangefs/orangefs-debugfs.c                | 36 ++++-----
 include/linux/fortify-string.h                |  7 +-
 net/devlink/dev.c                             |  8 +-
 net/sunrpc/addr.c                             | 16 ++--
 sound/pci/ac97/ac97_codec.c                   |  9 ++-
 sound/usb/card.c                              | 58 +++++++++-----
 sound/usb/mixer.c                             |  8 +-
 25 files changed, 309 insertions(+), 254 deletions(-)
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthias Schwarzott <zzam@gentoo.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc: "Martin K. Petersen" <mkp@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Simon Horman <horms@kernel.org>
Cc: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Kanglong Wang <wangkanglong@loongson.cn>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Qiang Ma <maqianga@uniontech.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Thorsten Blum <blum@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Jiaming Zhang <r772577952@gmail.com>
Cc: Will Porter <mrwillporter@gmail.com>
Cc: Cen Zhang <zzzccc427@gmail.com>
Cc: "C=C3=A1ssio Gabriel" <cassiogabrielcontato@gmail.com>
Cc: Rong Zhang <i@rong.moe>
Cc: Arun Raghavan <arunr@valvesoftware.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-input@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: devicetree@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Cc: devel@lists.orangefs.org
Cc: linux-hardening@vger.kernel.org
Cc: linux-sound@vger.kernel.org

--=20
2.47.3

