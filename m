Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3DA106B504
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3AD10E19E;
	Wed, 25 Mar 2026 21:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="bzMRQD9b";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D3810E19E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:11:34 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43b40fb7f95so225286f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1774473093; x=1775077893; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dnIL4wZv97aEMtNlFlTWEL+mxDNk9MQIoyZ5TjA/L4g=;
 b=bzMRQD9bK94CZUWs6BtS5z7dqWJgLxtJAeJBelfNJm0CukIDiJOJENKh6Tz8wPd2l7
 z0SdRzvc3H9EvKCNUjvdDPfBRiV/JKNO9ulRjeBgictntNdlW2Xo43XekK9J+LU/8ULP
 Ta45Ofuz1ro1SUDlWFtz5fqcDDXn2f+CK5cpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473093; x=1775077893;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnIL4wZv97aEMtNlFlTWEL+mxDNk9MQIoyZ5TjA/L4g=;
 b=orbPlA9QrJD5S/IS2yf3Va8FQBGRXDuQHLQMQ/aN3Wr8Q/R94R0O7CGg/DH/wuTe9U
 n/BzbFwK7P/oJWr3RXRzbZChJb9TN7HewW1C3TtwkCHgXGcl+lKrLjQrPzPnntkdAwNS
 VKwS3Pbl6l8+Wgq33odZxn++qX3D9CaGehM2jcpMir93SeKH8Glfm5NCkDwXSL9mFwyv
 4qo5rdsyd92Sly7PjBwqtUW9+Py8infFQQ2fES8CNN3zTU+1H/PROetuUbvc79see8Ue
 fZ1FvENpb3laTet6jsro1CmkA9jyV3vu5nyOUkdb6dcewNAUa64gk9QSW95qoRxjjEmp
 HOdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAETkwujp7zUKSj5rGF+24gbpWjIZ6RmgwjhmEPV9BApDOzGn0rakGaCw1SzCwGz6TZleIXW9n63Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzH6C3aqBDuvgiMSuKnBYhhbRNYx7fez3BPia//nDa5tc2rQpPx
 GjX8h3S2vvKBnCNsAxRTb/Afhz0VP3x2kgWUtk43ulAC98LflDOVUowvd9a8uwE5zrM=
X-Gm-Gg: ATEYQzwTJhyg9gyUi9mfpjA0DBVKpsHJih7sazciyL+LvbK4/2KdJhrMRnshnnE6zmZ
 kUWvpgcLTwkep9OPzu3CNqZX6PZca+YRDJsj1vAR+tcRSRX+ZiY5DvpP1/UhYUm15a+HeGcKFgL
 Qs42BDE5RA6dtnc7oBnZgwG5I9Bs5X4t1hOsnkDwqrLx9IPdDfNXYoNxIeRZlt1aHKdAmZdkeBY
 qBHXBSboOeB/lbEriQM9tOaiaS8LsLaz9lp9fxT3TLFDH3qRKEafPhtrNo7iCwaLoNfIdUbp2NF
 G80Qp5pg924+tMfL6p4kMdDddzXMLrtEQx3K5+d8o/ru9k1Dm55H2WiN3ru999diUtUNCjXfD4O
 oTDOwlSpKVlwlwlbjxUGiyYWJaHjzJrqxYcG4Ege385S7cszM5By4CAR4eiE0GYy8aKOnOY2hUx
 EKR6U42VoX8KCfQTzwFl9/C93lZU9jCbWNY14=
X-Received: by 2002:a05:6000:26c1:b0:439:b623:a9e9 with SMTP id
 ffacd0b85a97d-43b889a83fcmr6920220f8f.19.1774473092683; 
 Wed, 25 Mar 2026 14:11:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919432f0sm2910367f8f.13.2026.03.25.14.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 14:11:31 -0700 (PDT)
Date: Wed, 25 Mar 2026 22:11:30 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Maarten Lankhorst <dev@lankhorst.se>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v2 1/1] drm: Fix use-after-free on framebuffers and
 property blobs when calling drm_dev_unplug
Message-ID: <acRPgts0pCLw8yLq@phenom.ffwll.local>
References: <20260313151728.14990-3-dev@lankhorst.se>
 <20260313151728.14990-4-dev@lankhorst.se>
 <a89da668-578f-4ae0-809b-f0e68e3550e1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a89da668-578f-4ae0-809b-f0e68e3550e1@roeck-us.net>
X-Operating-System: Linux phenom 6.18.5+deb14-amd64 
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

On Wed, Mar 25, 2026 at 10:26:40AM -0700, Guenter Roeck wrote:
> Hi,
>=20
> On Fri, Mar 13, 2026 at 04:17:27PM +0100, Maarten Lankhorst wrote:
> > When trying to do a rather aggressive test of igt's "xe_module_load
> > --r reload" with a full desktop environment and game running I noticed
> > a few OOPSes when dereferencing freed pointers, related to
> > framebuffers and property blobs after the compositor exits.
> >=20
> > Solve this by guarding the freeing in drm_file with drm_dev_enter/exit,
> > and immediately put the references from struct drm_file objects during
> > drm_dev_unplug().
> >=20
>=20
> With this patch in v6.18.20, I get the warning backtraces below.
> The backtraces are gone with the patch reverted.

Yeah, this needs to be reverted, reasoning below. Maarten, can you please
take care of that and feed the revert through the usual channels? I don't
think it's critical enough that we need to fast-track this into drm.git
directly.

Quoting the patch here again:

>  drivers/gpu/drm/drm_file.c        | 5 ++++-
>  drivers/gpu/drm/drm_mode_config.c | 9 ++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index ec820686b3021..f52141f842a1f 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -233,6 +233,7 @@ static void drm_events_release(struct drm_file *file_=
priv)
>  void drm_file_free(struct drm_file *file)
>  {
>  	struct drm_device *dev;
> +	int idx;
> =20
>  	if (!file)
>  		return;
> @@ -249,9 +250,11 @@ void drm_file_free(struct drm_file *file)
> =20
>  	drm_events_release(file);
> =20
> -	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
> +	if (drm_core_check_feature(dev, DRIVER_MODESET) &&
> +	    drm_dev_enter(dev, &idx)) {

This is misplaced for two reasons:

- Even if we'd want to guarantee that we hold a drm_dev_enter/exit
  reference during framebuffer teardown, we'd need to do this
  _consistently over all callsites. Not ad-hoc in just one place that a
  testcase hits. This also means kerneldoc updates of the relevant hooks
  and at least a bunch of acks from other driver people to document the
  consensus.

- More importantly, this is driver responsibilities in general unless we
  have extremely good reasons to the contrary. Which means this must be
  placed in xe.

>  		drm_fb_release(file);
>  		drm_property_destroy_user_blobs(dev, file);
> +		drm_dev_exit(idx);
>  	}
> =20
>  	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index 84ae8a23a3678..e349418978f79 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -583,10 +583,13 @@ void drm_mode_config_cleanup(struct drm_device *dev)
>  	 */
>  	WARN_ON(!list_empty(&dev->mode_config.fb_list));
>  	list_for_each_entry_safe(fb, fbt, &dev->mode_config.fb_list, head) {
> -		struct drm_printer p =3D drm_dbg_printer(dev, DRM_UT_KMS, "[leaked fb]=
");
> +		if (list_empty(&fb->filp_head) || drm_framebuffer_read_refcount(fb) > =
1) {
> +			struct drm_printer p =3D drm_dbg_printer(dev, DRM_UT_KMS, "[leaked fb=
]");

This is also wrong:

- Firstly, it's a completely independent bug, we do not smash two bugfixes
  into one patch.

- Secondly, it's again a driver bug: drm_mode_cleanup must be called when
  the last drm_device reference disappears (hence the existence of
  drmm_mode_config_init), not when the driver gets unbound. The fact that
  this shows up in a callchain from a devres cleanup means the intel
  driver gets this wrong (like almost everyone else because historically
  we didn't know better).

  If we don't follow this rule, then we get races with this code here
  running concurrently with drm_file fb cleanups, which just does not
  work. Review pointed that out, but then shrugged it off with a confused
  explanation:

  https://lore.kernel.org/all/e61e64c796ccfb17ae673331a3df4b877bf42d82.came=
l@linux.intel.com/

  Yes this also means a lot of the other drm_device teardown that drivers
  do happens way too early. There is a massive can of worms here of a
  magnitude that most likely is much, much bigger than what you can
  backport to stable kernels. Hotunplug is _hard_.

Anyway, with the above as justification, on the revert:

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

And I Reported-by credits to Guenter.

Cheers, Sima

> =20
> -		drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
> -		drm_framebuffer_print_info(&p, 1, fb);
> +			drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
> +			drm_framebuffer_print_info(&p, 1, fb);
> +		}
> +		list_del_init(&fb->filp_head);
>  		drm_framebuffer_free(&fb->base.refcount);
>  	}

>=20
> Guenter
>=20
> ---
> [    0.000000] Linux version 6.18.20-spi+ (groeck@server.roeck-us.net) (g=
cc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0, GNU ld (GNU Binutils for Ubuntu=
) 2.42) #1 SMP PREEMPT_DYNAMIC Wed Mar 25 08:22:19 PDT 2026
> [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.18.20-spi+ root=
=3DUUID=3Dce436484-f920-47a8-a8c4-c17ff3a877e8 ro quiet splash amdgpu.gpu_r=
ecovery=3D1 amdgpu.ppfeaturemask=3D0xfff73fff vt.handoff=3D7
> ...
> [    4.254064] nouveau 0000:2b:00.0: NVIDIA GK208B (b060b0b1)
> ...
> [    5.440862] ------------[ cut here ]------------
> [    5.440864] WARNING: CPU: 5 PID: 502 at drivers/gpu/drm/drm_mode_confi=
g.c:537 drm_mode_config_cleanup+0x313/0x360
> [    5.440868] Modules linked in: qrtr cmac algif_hash algif_skcipher af_=
alg bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl=
_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generi=
c snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec btusb=
 btmtk snd_hda_core btrtl btbcm snd_intel_dspcfg btintel snd_intel_sdw_acpi=
 snd_hwdep edac_mce_amd nouveau bluetooth snd_pcm kvm_amd snd_seq_midi mxm_=
wmi snd_seq_midi_event drm_gpuvm joydev input_leds snd_rawmidi ee1004 gpu_s=
ched kvm snd_seq snd_seq_device irqbypass polyval_clmulni snd_timer ghash_c=
lmulni_intel aesni_intel drm_ttm_helper snd rapl ttm drm_exec drm_display_h=
elper cec rc_core video i2c_piix4 ccp soundcore i2c_smbus wmi_bmof k10temp =
bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport=
 nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid=
_generic nvme usbhid hid nvme_core igb r8169 nvme_keyring i2c_algo_bit nvme=
_auth ahci realtek dca hkdf libahci wmi
> [    5.440902] CPU: 5 UID: 0 PID: 502 Comm: plymouthd Not tainted 6.18.20=
-spi+ #1 PREEMPT(full)=20
> [    5.440903] Hardware name: Micro-Star International Co., Ltd. MS-7C94/=
MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
> [    5.440904] RIP: 0010:drm_mode_config_cleanup+0x313/0x360
> [    5.440906] Code: 8b 45 d0 65 48 2b 05 84 22 0b 02 75 64 48 83 c4 58 5=
b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc <=
0f> 0b 48 8d 75 88 4c 89 e7 e8 1f 12 fe ff eb 10 48 8b 70 60 48 c7
> [    5.440907] RSP: 0018:ffffcf1442017bb0 EFLAGS: 00010202
> [    5.440908] RAX: ffff89bcc2268258 RBX: ffff89bcc2268290 RCX: 000000000=
0000000
> [    5.440909] RDX: ffff89bcc2269308 RSI: 0000000000000000 RDI: 000000000=
0000000
> [    5.440909] RBP: ffffcf1442017c30 R08: 0000000000000000 R09: 000000000=
0000000
> [    5.440910] R10: 0000000000000000 R11: 0000000000000000 R12: ffff89bcc=
2268000
> [    5.440910] R13: ffff89bcc2268298 R14: ffff89bcc5c3f480 R15: dead00000=
0000100
> [    5.440911] FS:  0000713c25451000(0000) GS:ffff89cbe2cf3000(0000) knlG=
S:0000000000000000
> [    5.440912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.440912] CR2: 0000713c1bfff000 CR3: 00000001179c3000 CR4: 000000000=
0f50ef0
> [    5.440913] PKRU: 55555554
> [    5.440914] Call Trace:
> [    5.440914]  <TASK>
> [    5.440916]  ? drm_managed_release+0xc2/0x160
> [    5.440918]  drm_mode_config_init_release+0xe/0x20
> [    5.440919]  drm_managed_release+0x8f/0x160
> [    5.440920]  drm_minor_release+0x5f/0x90
> [    5.440921]  drm_release+0xda/0x140
> [    5.440923]  __fput+0xed/0x2d0
> [    5.440925]  fput_close_sync+0x3d/0xa0
> [    5.440927]  __x64_sys_close+0x3e/0x90
> [    5.440928]  x64_sys_call+0x1b5e/0x26a0
> [    5.440930]  do_syscall_64+0x80/0x570
> [    5.440934]  ? x64_sys_call+0x1144/0x26a0
> [    5.440935]  ? do_syscall_64+0xb8/0x570
> [    5.440937]  ? __vm_munmap+0xdb/0x190
> [    5.440939]  ? __x64_sys_munmap+0x1b/0x30
> [    5.440941]  ? x64_sys_call+0x1be5/0x26a0
> [    5.440942]  ? do_syscall_64+0xb8/0x570
> [    5.440943]  ? irqentry_exit+0x43/0x50
> [    5.440944]  ? exc_page_fault+0x90/0x1b0
> [    5.440946]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    5.440947] RIP: 0033:0x713c256fa74c
> [    5.440948] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e=
5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
> [    5.440949] RSP: 002b:00007ffc9c194100 EFLAGS: 00000293 ORIG_RAX: 0000=
000000000003
> [    5.440950] RAX: ffffffffffffffda RBX: 000055df73527870 RCX: 0000713c2=
56fa74c
> [    5.440951] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
000000b
> [    5.440951] RBP: 00007ffc9c194110 R08: 000000055df73528 R09: 000000000=
0000007
> [    5.440952] R10: 000055df73528bc0 R11: 0000000000000293 R12: 0000713c2=
5450f88
> [    5.440952] R13: 0000000000000013 R14: 000055df7356f6b0 R15: 000055df7=
3526130
> [    5.440953]  </TASK>
> [    5.440954] ---[ end trace 0000000000000000 ]---
> [    5.440955] [drm:drm_mode_config_cleanup] *ERROR* connector Unknown-1 =
leaked!
> [    5.440971] ------------[ cut here ]------------
> [    5.440971] WARNING: CPU: 5 PID: 502 at drivers/gpu/drm/drm_mode_confi=
g.c:571 drm_mode_config_cleanup+0x34f/0x360
> [    5.440973] Modules linked in: qrtr cmac algif_hash algif_skcipher af_=
alg bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl=
_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generi=
c snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec btusb=
 btmtk snd_hda_core btrtl btbcm snd_intel_dspcfg btintel snd_intel_sdw_acpi=
 snd_hwdep edac_mce_amd nouveau bluetooth snd_pcm kvm_amd snd_seq_midi mxm_=
wmi snd_seq_midi_event drm_gpuvm joydev input_leds snd_rawmidi ee1004 gpu_s=
ched kvm snd_seq snd_seq_device irqbypass polyval_clmulni snd_timer ghash_c=
lmulni_intel aesni_intel drm_ttm_helper snd rapl ttm drm_exec drm_display_h=
elper cec rc_core video i2c_piix4 ccp soundcore i2c_smbus wmi_bmof k10temp =
bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport=
 nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid=
_generic nvme usbhid hid nvme_core igb r8169 nvme_keyring i2c_algo_bit nvme=
_auth ahci realtek dca hkdf libahci wmi
> [    5.440995] CPU: 5 UID: 0 PID: 502 Comm: plymouthd Tainted: G        W=
           6.18.20-spi+ #1 PREEMPT(full)=20
> [    5.440997] Tainted: [W]=3DWARN
> [    5.440997] Hardware name: Micro-Star International Co., Ltd. MS-7C94/=
MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
> [    5.440998] RIP: 0010:drm_mode_config_cleanup+0x34f/0x360
> [    5.440999] Code: 70 60 48 c7 c7 a7 90 93 ba e8 3d bb 00 00 48 8d 7d 8=
8 e8 c4 32 fe ff 48 85 c0 75 e2 48 8d 7d 88 e8 d6 31 fe ff e9 7b fd ff ff <=
0f> 0b e9 79 fe ff ff 0f 0b eb 8e e8 01 a4 65 00 90 90 90 90 90 90
> [    5.441000] RSP: 0018:ffffcf1442017bb0 EFLAGS: 00010293
> [    5.441001] RAX: ffff89bcd7c61bc8 RBX: ffff89bcc2268368 RCX: 000000000=
0000000
> [    5.441001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff89bcc=
2268368
> [    5.441002] RBP: ffffcf1442017c30 R08: 0000000000000000 R09: 000000000=
0000000
> [    5.441002] R10: 0000000000000000 R11: 0000000000000000 R12: ffff89bcc=
2268000
> [    5.441002] R13: ffff89bcc2268390 R14: ffff89bcc2268230 R15: dead00000=
0000100
> [    5.441003] FS:  0000713c25451000(0000) GS:ffff89cbe2cf3000(0000) knlG=
S:0000000000000000
> [    5.441004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.441004] CR2: 0000713c1bfff000 CR3: 00000001179c3000 CR4: 000000000=
0f50ef0
> [    5.441005] PKRU: 55555554
> [    5.441005] Call Trace:
> [    5.441006]  <TASK>
> [    5.441006]  ? drm_managed_release+0xc2/0x160
> [    5.441008]  drm_mode_config_init_release+0xe/0x20
> [    5.441009]  drm_managed_release+0x8f/0x160
> [    5.441010]  drm_minor_release+0x5f/0x90
> [    5.441011]  drm_release+0xda/0x140
> [    5.441012]  __fput+0xed/0x2d0
> [    5.441013]  fput_close_sync+0x3d/0xa0
> [    5.441014]  __x64_sys_close+0x3e/0x90
> [    5.441015]  x64_sys_call+0x1b5e/0x26a0
> [    5.441017]  do_syscall_64+0x80/0x570
> [    5.441018]  ? x64_sys_call+0x1144/0x26a0
> [    5.441019]  ? do_syscall_64+0xb8/0x570
> [    5.441021]  ? __vm_munmap+0xdb/0x190
> [    5.441023]  ? __x64_sys_munmap+0x1b/0x30
> [    5.441024]  ? x64_sys_call+0x1be5/0x26a0
> [    5.441025]  ? do_syscall_64+0xb8/0x570
> [    5.441026]  ? irqentry_exit+0x43/0x50
> [    5.441027]  ? exc_page_fault+0x90/0x1b0
> [    5.441029]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    5.441029] RIP: 0033:0x713c256fa74c
> [    5.441030] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e=
5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
> [    5.441031] RSP: 002b:00007ffc9c194100 EFLAGS: 00000293 ORIG_RAX: 0000=
000000000003
> [    5.441031] RAX: ffffffffffffffda RBX: 000055df73527870 RCX: 0000713c2=
56fa74c
> [    5.441032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
000000b
> [    5.441032] RBP: 00007ffc9c194110 R08: 000000055df73528 R09: 000000000=
0000007
> [    5.441033] R10: 000055df73528bc0 R11: 0000000000000293 R12: 0000713c2=
5450f88
> [    5.441033] R13: 0000000000000013 R14: 000055df7356f6b0 R15: 000055df7=
3526130
> [    5.441035]  </TASK>
> [    5.441035] ---[ end trace 0000000000000000 ]---
> [    5.441036] ------------[ cut here ]------------
> [    5.441036] platform simple-framebuffer.0: [drm] drm_WARN_ON(refcount_=
read(&shmem->vmap_use_count))
> [    5.441041] WARNING: CPU: 5 PID: 502 at drivers/gpu/drm/drm_gem_shmem_=
helper.c:170 drm_gem_shmem_free+0x111/0x1a0
> [    5.441043] Modules linked in: qrtr cmac algif_hash algif_skcipher af_=
alg bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl=
_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generi=
c snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec btusb=
 btmtk snd_hda_core btrtl btbcm snd_intel_dspcfg btintel snd_intel_sdw_acpi=
 snd_hwdep edac_mce_amd nouveau bluetooth snd_pcm kvm_amd snd_seq_midi mxm_=
wmi snd_seq_midi_event drm_gpuvm joydev input_leds snd_rawmidi ee1004 gpu_s=
ched kvm snd_seq snd_seq_device irqbypass polyval_clmulni snd_timer ghash_c=
lmulni_intel aesni_intel drm_ttm_helper snd rapl ttm drm_exec drm_display_h=
elper cec rc_core video i2c_piix4 ccp soundcore i2c_smbus wmi_bmof k10temp =
bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport=
 nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid=
_generic nvme usbhid hid nvme_core igb r8169 nvme_keyring i2c_algo_bit nvme=
_auth ahci realtek dca hkdf libahci wmi
> [    5.441066] CPU: 5 UID: 0 PID: 502 Comm: plymouthd Tainted: G        W=
           6.18.20-spi+ #1 PREEMPT(full)=20
> [    5.441067] Tainted: [W]=3DWARN
> [    5.441067] Hardware name: Micro-Star International Co., Ltd. MS-7C94/=
MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
> [    5.441068] RIP: 0010:drm_gem_shmem_free+0x111/0x1a0
> [    5.441069] Code: 4c 8b 67 50 4d 85 e4 75 03 4c 8b 27 e8 68 4f 02 00 4=
8 c7 c1 e8 03 8a ba 4c 89 e2 48 c7 c7 66 7b 93 ba 48 89 c6 e8 8f 09 46 ff <=
0f> 0b e9 4b ff ff ff 48 8b 7b 08 48 85 ff 74 04 48 8b 7f 08 4c 8b
> [    5.441070] RSP: 0018:ffffcf1442017ad0 EFLAGS: 00010246
> [    5.441070] RAX: 0000000000000000 RBX: ffff89bcc8704400 RCX: 000000000=
0000000
> [    5.441071] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [    5.441071] RBP: ffffcf1442017ae0 R08: 0000000000000000 R09: 000000000=
0000000
> [    5.441072] R10: 0000000000000000 R11: 0000000000000000 R12: ffff89bcc=
2bec900
> [    5.441072] R13: ffff89bcc2268000 R14: 0000000000000000 R15: ffff89bcc=
2268228
> [    5.441073] FS:  0000713c25451000(0000) GS:ffff89cbe2cf3000(0000) knlG=
S:0000000000000000
> [    5.441073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.441074] CR2: 0000713c1bfff000 CR3: 00000001179c3000 CR4: 000000000=
0f50ef0
> [    5.441075] PKRU: 55555554
> [    5.441075] Call Trace:
> [    5.441075]  <TASK>
> [    5.441076]  drm_gem_shmem_object_free+0x9/0x20
> [    5.441077]  drm_gem_object_handle_put_unlocked+0x12c/0x140
> [    5.441079]  drm_framebuffer_cleanup+0x60/0xe0
> [    5.441080]  drm_gem_fb_destroy+0x79/0xc0
> [    5.441081]  drm_framebuffer_free+0x43/0xa0
> [    5.441083]  drm_mode_config_cleanup+0x29c/0x360
> [    5.441084]  ? drm_mode_config_cleanup+0x1f2/0x360
> [    5.441085]  ? drm_managed_release+0xc2/0x160
> [    5.441086]  drm_mode_config_init_release+0xe/0x20
> [    5.441087]  drm_managed_release+0x8f/0x160
> [    5.441088]  drm_minor_release+0x5f/0x90
> [    5.441089]  drm_release+0xda/0x140
> [    5.441090]  __fput+0xed/0x2d0
> [    5.441091]  fput_close_sync+0x3d/0xa0
> [    5.441092]  __x64_sys_close+0x3e/0x90
> [    5.441094]  x64_sys_call+0x1b5e/0x26a0
> [    5.441095]  do_syscall_64+0x80/0x570
> [    5.441096]  ? x64_sys_call+0x1144/0x26a0
> [    5.441097]  ? do_syscall_64+0xb8/0x570
> [    5.441099]  ? __vm_munmap+0xdb/0x190
> [    5.441101]  ? __x64_sys_munmap+0x1b/0x30
> [    5.441102]  ? x64_sys_call+0x1be5/0x26a0
> [    5.441103]  ? do_syscall_64+0xb8/0x570
> [    5.441104]  ? irqentry_exit+0x43/0x50
> [    5.441105]  ? exc_page_fault+0x90/0x1b0
> [    5.441106]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    5.441107] RIP: 0033:0x713c256fa74c
> [    5.441108] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e=
5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
> [    5.441109] RSP: 002b:00007ffc9c194100 EFLAGS: 00000293 ORIG_RAX: 0000=
000000000003
> [    5.441109] RAX: ffffffffffffffda RBX: 000055df73527870 RCX: 0000713c2=
56fa74c
> [    5.441110] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
000000b
> [    5.441110] RBP: 00007ffc9c194110 R08: 000000055df73528 R09: 000000000=
0000007
> [    5.441111] R10: 000055df73528bc0 R11: 0000000000000293 R12: 0000713c2=
5450f88
> [    5.441111] R13: 0000000000000013 R14: 000055df7356f6b0 R15: 000055df7=
3526130
> [    5.441112]  </TASK>
> [    5.441113] ---[ end trace 0000000000000000 ]---
> [    5.441151] ------------[ cut here ]------------
> [    5.441152] platform simple-framebuffer.0: [drm] drm_WARN_ON(refcount_=
read(&shmem->pages_pin_count))
> [    5.441155] WARNING: CPU: 5 PID: 502 at drivers/gpu/drm/drm_gem_shmem_=
helper.c:182 drm_gem_shmem_free+0x18d/0x1a0
> [    5.441157] Modules linked in: qrtr cmac algif_hash algif_skcipher af_=
alg bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl=
_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generi=
c snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec btusb=
 btmtk snd_hda_core btrtl btbcm snd_intel_dspcfg btintel snd_intel_sdw_acpi=
 snd_hwdep edac_mce_amd nouveau bluetooth snd_pcm kvm_amd snd_seq_midi mxm_=
wmi snd_seq_midi_event drm_gpuvm joydev input_leds snd_rawmidi ee1004 gpu_s=
ched kvm snd_seq snd_seq_device irqbypass polyval_clmulni snd_timer ghash_c=
lmulni_intel aesni_intel drm_ttm_helper snd rapl ttm drm_exec drm_display_h=
elper cec rc_core video i2c_piix4 ccp soundcore i2c_smbus wmi_bmof k10temp =
bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport=
 nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid=
_generic nvme usbhid hid nvme_core igb r8169 nvme_keyring i2c_algo_bit nvme=
_auth ahci realtek dca hkdf libahci wmi
> [    5.441179] CPU: 5 UID: 0 PID: 502 Comm: plymouthd Tainted: G        W=
           6.18.20-spi+ #1 PREEMPT(full)=20
> [    5.441180] Tainted: [W]=3DWARN
> [    5.441180] Hardware name: Micro-Star International Co., Ltd. MS-7C94/=
MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
> [    5.441181] RIP: 0010:drm_gem_shmem_free+0x18d/0x1a0
> [    5.441182] Code: 4c 8b 67 50 4d 85 e4 75 03 4c 8b 27 e8 ec 4e 02 00 4=
8 c7 c1 58 04 8a ba 4c 89 e2 48 c7 c7 66 7b 93 ba 48 89 c6 e8 13 09 46 ff <=
0f> 0b e9 35 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90
> [    5.441182] RSP: 0018:ffffcf1442017ad0 EFLAGS: 00010246
> [    5.441183] RAX: 0000000000000000 RBX: ffff89bcc8704400 RCX: 000000000=
0000000
> [    5.441184] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [    5.441184] RBP: ffffcf1442017ae0 R08: 0000000000000000 R09: 000000000=
0000000
> [    5.441184] R10: 0000000000000000 R11: 0000000000000000 R12: ffff89bcc=
2bec900
> [    5.441185] R13: ffff89bcc2268000 R14: 0000000000000000 R15: ffff89bcc=
2268228
> [    5.441186] FS:  0000713c25451000(0000) GS:ffff89cbe2cf3000(0000) knlG=
S:0000000000000000
> [    5.441186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.441187] CR2: 0000713c1bfff000 CR3: 00000001179c3000 CR4: 000000000=
0f50ef0
> [    5.441187] PKRU: 55555554
> [    5.441188] Call Trace:
> [    5.441188]  <TASK>
> [    5.441188]  drm_gem_shmem_object_free+0x9/0x20
> [    5.441189]  drm_gem_object_handle_put_unlocked+0x12c/0x140
> [    5.441191]  drm_framebuffer_cleanup+0x60/0xe0
> [    5.441192]  drm_gem_fb_destroy+0x79/0xc0
> [    5.441193]  drm_framebuffer_free+0x43/0xa0
> [    5.441194]  drm_mode_config_cleanup+0x29c/0x360
> [    5.441195]  ? drm_mode_config_cleanup+0x1f2/0x360
> [    5.441196]  ? drm_managed_release+0xc2/0x160
> [    5.441197]  drm_mode_config_init_release+0xe/0x20
> [    5.441198]  drm_managed_release+0x8f/0x160
> [    5.441199]  drm_minor_release+0x5f/0x90
> [    5.441200]  drm_release+0xda/0x140
> [    5.441201]  __fput+0xed/0x2d0
> [    5.441202]  fput_close_sync+0x3d/0xa0
> [    5.441204]  __x64_sys_close+0x3e/0x90
> [    5.441205]  x64_sys_call+0x1b5e/0x26a0
> [    5.441206]  do_syscall_64+0x80/0x570
> [    5.441208]  ? x64_sys_call+0x1144/0x26a0
> [    5.441209]  ? do_syscall_64+0xb8/0x570
> [    5.441210]  ? __vm_munmap+0xdb/0x190
> [    5.441212]  ? __x64_sys_munmap+0x1b/0x30
> [    5.441213]  ? x64_sys_call+0x1be5/0x26a0
> [    5.441214]  ? do_syscall_64+0xb8/0x570
> [    5.441216]  ? irqentry_exit+0x43/0x50
> [    5.441216]  ? exc_page_fault+0x90/0x1b0
> [    5.441218]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    5.441219] RIP: 0033:0x713c256fa74c
> [    5.441219] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e=
5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
> [    5.441234] RSP: 002b:00007ffc9c194100 EFLAGS: 00000293 ORIG_RAX: 0000=
000000000003
> [    5.441236] RAX: ffffffffffffffda RBX: 000055df73527870 RCX: 0000713c2=
56fa74c
> [    5.441237] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
000000b
> [    5.441238] RBP: 00007ffc9c194110 R08: 000000055df73528 R09: 000000000=
0000007
> [    5.441238] R10: 000055df73528bc0 R11: 0000000000000293 R12: 0000713c2=
5450f88
> [    5.441239] R13: 0000000000000013 R14: 000055df7356f6b0 R15: 000055df7=
3526130
> [    5.441241]  </TASK>
> [    5.441241] ---[ end trace 0000000000000000 ]---

--=20
Simona Vetter
Software Engineer
http://blog.ffwll.ch
