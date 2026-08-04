Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB45FC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19AB510EA28;
	Tue,  4 Aug 2026 13:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+pirc6w";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394E910EA28
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:37:17 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38dd1cc8dc8so406965a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 06:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850637; cv=none;
 d=google.com; s=arc-20260327;
 b=XhCvoM67qADgibZYebbtgqHn527FSGGrsloqLt1Q0Yj9xfm1bpnqScig6bw6DZ+hSL
 AVrXVlukgdyteFJmasFQdFTTcSr/LkY+ovNCKrkViwqbvyUWlSW0uemIqeBdZcgT4InO
 Dbohdz0kaOCsbf2Ctgs6At9iDBtoiLhOhMkr0V2IDu3O4CHXxDX/zJNRiLR/n72g0G/j
 841xffUGZ2efZE/7wGdH5G1y4kbChXuI+SfmEBX3oYfpXhdQX/yM0p2LdaBmpQT2ggbt
 8/AD1LgwNdfm1nW8i8pG2q6F7EN3sL4tDnRvH+Zj5Gw6BHcRrHFM8o0LANh8ntK9YizO
 QpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PloWZ4gr/TQvbRmf7OACWkyVx7fUyYF1WnjbXGJ3wNk=;
 fh=RHkpHUHy8bz3lDR9MvdBPM3px/qa0qSUVxDcYKHHRA0=;
 b=XiNzwFsmGSK8b4IrP09RhYQyVblQx7RePQoIbGL/ZVihza80uLCUUYCCSoKXh7GuzN
 44JBLqGSPBJgyYoP/yxqC9xs72zgVcCf/Wk5RwSd2B+L0x06TGaAdrlY/3q8UWbALG5j
 43Vh+Xhp9Ldwjmb0hnTlANZMSVJLix3sBNG3Zfgek/vkv0SdaV6sisq7f4qgbZ7mO3YW
 Ol8bj9JDagy1mGCyPPczklG6h6fchE5sOBW2KlLPcZaozztfJ4tswb1J0hZlItx1KZ1L
 Rcx/FIJ2SLho8KtGBBRwWaBC7Vmn9TuAlD0HBBdokjkvnRtUauPHQMqZd6qcwLjIX2vs
 bbOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785850637; x=1786455437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PloWZ4gr/TQvbRmf7OACWkyVx7fUyYF1WnjbXGJ3wNk=;
 b=R+pirc6w8Ti3wsCis/ChIWSpUkI4OcMHPukKKNbmnCl9CZtaXbdaZ42mUEdthmmBMm
 cqBDX3U8JMYJkmM7LLpdd+bYlVrM6hZlWwbydJjGZ8KK513mxnhrV3jlfB0rwY5HDAl6
 c2LP2Q0dmuw8QNHGqSxSE5QSbH1bGU/iHbvytTG12lt05jEPLME+bW9ALti4IIkCaQ/X
 Ifn7M2IDmiPyppN8vGJOgqj3+WpdXReWVKH/a3swQwZedR6Vg+H7yU3dbofHTuMoQpvj
 3ZsAJ6GdgkGVm0Nx4rMsn5juDXG8mFvxWLdGX8Muyk5jKqj9RfkXrY8p/IXfp94yw/Uf
 /zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785850637; x=1786455437;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PloWZ4gr/TQvbRmf7OACWkyVx7fUyYF1WnjbXGJ3wNk=;
 b=jE6bYReUsNQgaiT+/ATHD4gAYRkCWg7n+n0oW2vu6zhDDPBbiI5kG+QagUoXOeUaGP
 hf4ALk7R9xT31rPLLbsva54BKhB5osM9r+HHTCDPnjUTIxtZWoxmSO3TLwV1bHb5NN3X
 WO5Svdip0GC/cOQMuyMc8HJNevMspdOzYWDAis4fWC8GqqgWeKjQojlQ7336+s/4x4H/
 RlEIWnYl/duOp1S07SZTiw0jq51HddJWlEgDvo8CnNUxwKInHSaAo7oZ04qo4JZalfrn
 TAI7k1Exck3tEkZdv/eEepPaB0Tz+iD4J46E2l2du2m99tmTgieS6nRqs39PBveCHwT4
 fa+A==
X-Gm-Message-State: AOJu0YzZV+LT6g23heaJul++idx/qQyn6kJlqoGsHcZbZSwZwsenv9a5
 B6tyg3s0Hsm7Zn1Hkc61ZLBTwKYftObf4aUEpq8CmZ2Bvhoh1JJsS6WJ0pIeoWA9Ls4bo3OeBEC
 CbKVkQ/TMnTXsh/N8Jj98Hw+tL6/aQPA=
X-Gm-Gg: AR+sD13M38vs17m7f+PFjfvH6PwhpmHgKNEDrv6aZDjuV4Oht9GH5I0pSHGYG5Ac1AA
 rirCR1b2FDagm25wOCmMrTAehKFgBzHFZZ9WgmFEhxgEoeLrzexQ2g/7OSp4DqK0XSgmFEE/SuP
 l40b3Xtf9y9uelgAEPoKRkElnJuxVa1sOi0IZm9EEtSiYHzOYeHhTqTol5L9Qy1mvaqcq1X67zm
 daau6f15qM81hr5oMlqrThkbdVoaxO4kO5Tjw6BusZB0SLlbQUkfJmUDdW2vYB3lyQBQY5r+xml
 tPL/mSGYoz3NJNuhBg9hy3LCZWWwJCIKH2PeFp7PrN6axB6dLU+GQz23paGoC2Doyro+A0HN92W
 W/Yxg5aQEbJfstMItNAXWvHdWr7ZLMp4=
X-Received: by 2002:a17:90b:4b81:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-38fbc3dad68mr16720556a91.1.1785850636530; Tue, 04 Aug 2026
 06:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260730194748.3622066-1-rdunlap@infradead.org>
In-Reply-To: <20260730194748.3622066-1-rdunlap@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 09:37:05 -0400
X-Gm-Features: AUfX_mx5KNk6mj5miN4_j6rc9ADrCpiXnB5x3gCgP5O-AlSwn2wbbwEbznM8H2w
Message-ID: <CADnq5_Ocj1HJ2N50FKqJ8CnLGdv89kANnCFmV9tUVJ_REFtsDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: kfd_ioctl.h: fix most kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jul 30, 2026 at 3:47=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Make corrections to kernel-doc comments:
> - use the struct keyword when describing structs
> - use the enum keyword when describing enums
> - insert colons (':') as needed in struct member descriptions
> - add missing short descriptions
> - convert some comments to kernel-doc format
>
> to prevent these warnings:
>
> Warning: include/uapi/linux/kfd_ioctl.h:708 cannot understand function pr=
ototype: 'struct kfd_ioctl_criu_args'
> Warning: include/uapi/linux/kfd_ioctl.h:771 cannot understand function pr=
ototype: 'enum kfd_ioctl_svm_op'
> Warning: include/uapi/linux/kfd_ioctl.h:805 cannot understand function pr=
ototype: 'enum kfd_ioctl_svm_attr_type'
> Warning: include/uapi/linux/kfd_ioctl.h:824 cannot understand function pr=
ototype: 'struct kfd_ioctl_svm_attribute'
> Warning: include/uapi/linux/kfd_ioctl.h:867 cannot understand function pr=
ototype: 'struct kfd_ioctl_svm_args'
> Warning: include/uapi/linux/kfd_ioctl.h:910 cannot understand function pr=
ototype: 'struct kfd_ioctl_set_xnack_mode_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1075 cannot understand function p=
rototype: 'struct kfd_ioctl_runtime_enable_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1160 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_enable_args
> Warning: include/uapi/linux/kfd_ioctl.h:1182 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_enable_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1190 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_send_runtime_event_args
> Warning: include/uapi/linux/kfd_ioctl.h:1208 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_send_runtime_event_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1215 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_set_exceptions_enabled_args
> Warning: include/uapi/linux/kfd_ioctl.h:1225 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_set_exceptions_enabled_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1230 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_set_wave_launch_override_args
> Warning: include/uapi/linux/kfd_ioctl.h:1252 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_set_wave_launch_override_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1260 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_set_wave_launch_mode_args
> Warning: include/uapi/linux/kfd_ioctl.h:1270 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1276 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_suspend_queues_ags
> Warning: include/uapi/linux/kfd_ioctl.h:1305 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_suspend_queues_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1313 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_resume_queues_args
> Warning: include/uapi/linux/kfd_ioctl.h:1330 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_resume_queues_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1337 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_set_node_address_watch_args
> Warning: include/uapi/linux/kfd_ioctl.h:1354 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_set_node_address_watch_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1363 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_clear_node_address_watch_args
> Warning: include/uapi/linux/kfd_ioctl.h:1376 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_clear_node_address_watch_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1382 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_set_flags_args
> Warning: include/uapi/linux/kfd_ioctl.h:1393 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_set_flags_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1399 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_query_debug_event_args
> Warning: include/uapi/linux/kfd_ioctl.h:1421 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_query_debug_event_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1428 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_query_exception_info_args
> Warning: include/uapi/linux/kfd_ioctl.h:1448 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_query_exception_info_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1457 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_get_queue_snapshot_args
> Warning: include/uapi/linux/kfd_ioctl.h:1485 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_queue_snapshot_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1493 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_get_device_snapshot_args
> Warning: include/uapi/linux/kfd_ioctl.h:1521 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_device_snapshot_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1529 missing initial short descri=
ption on line:
>  * kfd_ioctl_dbg_trap_args
> Warning: include/uapi/linux/kfd_ioctl.h:1539 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1569 This comment starts with '/*=
*', but isn't a kernel-doc comment.
>  * Enables/Disables GPU Specific profiler settings
>
> Warning: include/uapi/linux/kfd_ioctl.h:718 struct member 'num_bos' not d=
escribed in 'kfd_ioctl_criu_args'
> Warning: include/uapi/linux/kfd_ioctl.h:718 struct member 'op' not descri=
bed in 'kfd_ioctl_criu_args'
> Warning: include/uapi/linux/kfd_ioctl.h:874 struct member 'start_addr' no=
t described in 'kfd_ioctl_svm_args'
> Warning: include/uapi/linux/kfd_ioctl.h:874 struct member 'size' not desc=
ribed in 'kfd_ioctl_svm_args'
> Warning: include/uapi/linux/kfd_ioctl.h:874 struct member 'op' not descri=
bed in 'kfd_ioctl_svm_args'
> Warning: include/uapi/linux/kfd_ioctl.h:874 struct member 'nattr' not des=
cribed in 'kfd_ioctl_svm_args'
> Warning: include/uapi/linux/kfd_ioctl.h:874 struct member 'attrs' not des=
cribed in 'kfd_ioctl_svm_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1079 struct member 'r_debug' not =
described in 'kfd_ioctl_runtime_enable_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1079 struct member 'mode_mask' no=
t described in 'kfd_ioctl_runtime_enable_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1079 struct member 'capabilities_=
mask' not described in 'kfd_ioctl_runtime_enable_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1254 struct member 'pad' not desc=
ribed in 'kfd_ioctl_dbg_trap_set_wave_launch_override_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1267 cannot understand function p=
rototype: 'struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1308 expecting prototype for stru=
ct kfd_ioctl_dbg_trap_suspend_queues_ags. Prototype was for struct kfd_ioct=
l_dbg_trap_suspend_queues_args instead
> Warning: include/uapi/linux/kfd_ioctl.h:1332 struct member 'pad' not desc=
ribed in 'kfd_ioctl_dbg_trap_resume_queues_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1488 expecting prototype for stru=
ct kfd_ioctl_dbg_trap_get_queue_snapshot_args. Prototype was for struct kfd=
_ioctl_dbg_trap_queue_snapshot_args instead
> Warning: include/uapi/linux/kfd_ioctl.h:1524 expecting prototype for stru=
ct kfd_ioctl_dbg_trap_get_device_snapshot_args. Prototype was for struct kf=
d_ioctl_dbg_trap_device_snapshot_args instead
>
> * This leaves the following struct members undescribed in kernel-doc
> comments:
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'enable' not d=
escribed in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'send_runtime_=
event' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'set_exception=
s_enabled' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'launch_overri=
de' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'launch_mode' =
not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'suspend_queue=
s' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'resume_queues=
' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'set_node_addr=
ess_watch' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'clear_node_ad=
dress_watch' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'set_flags' no=
t described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'query_debug_e=
vent' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'query_excepti=
on_info' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'queue_snapsho=
t' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1555 struct member 'device_snapsh=
ot' not described in 'kfd_ioctl_dbg_trap_args'
> Warning: include/uapi/linux/kfd_ioctl.h:1571 struct member 'gpu_id' not d=
escribed in 'kfd_ioctl_pmc_settings'
> Warning: include/uapi/linux/kfd_ioctl.h:1571 struct member 'lock' not des=
cribed in 'kfd_ioctl_pmc_settings'
> Warning: include/uapi/linux/kfd_ioctl.h:1571 struct member 'perfcount_ena=
ble' not described in 'kfd_ioctl_pmc_settings'
>
> All amdgpu object files before/after compare equal after this change.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied.  Thanks!

> ---
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
>
>  include/uapi/linux/kfd_ioctl.h |  180 +++++++++++++++----------------
>  1 file changed, 89 insertions(+), 91 deletions(-)
>
> --- linux-next-20260729.orig/include/uapi/linux/kfd_ioctl.h
> +++ linux-next-20260729/include/uapi/linux/kfd_ioctl.h
> @@ -690,7 +690,7 @@ enum kfd_criu_op {
>  };
>
>  /**
> - * kfd_ioctl_criu_args - Arguments perform CRIU operation
> + * struct kfd_ioctl_criu_args - Arguments perform CRIU operation
>   * @devices:           [in/out] User pointer to memory location for devi=
ces information.
>   *                     This is an array of type kfd_criu_device_bucket.
>   * @bos:               [in/out] User pointer to memory location for BOs =
information
> @@ -698,11 +698,11 @@ enum kfd_criu_op {
>   * @priv_data:         [in/out] User pointer to memory location for priv=
ate data
>   * @priv_data_size:    [in/out] Size of priv_data in bytes
>   * @num_devices:       [in/out] Number of GPUs used by process. Size of =
@devices array.
> - * @num_bos            [in/out] Number of BOs used by process. Size of @=
bos array.
> + * @num_bos:           [in/out] Number of BOs used by process. Size of @=
bos array.
>   * @num_objects:       [in/out] Number of objects used by process. Objec=
ts are opaque to
>   *                              user application.
>   * @pid:               [in/out] PID of the process being checkpointed
> - * @op                 [in] Type of operation (kfd_criu_op)
> + * @op:                        [in] Type of operation (kfd_criu_op)
>   *
>   * Return: 0 on success, -errno on failure
>   */
> @@ -764,7 +764,7 @@ enum kfd_mmio_remap {
>  #define KFD_IOCTL_SVM_FLAG_EXT_COHERENT        0x00000080
>
>  /**
> - * kfd_ioctl_svm_op - SVM ioctl operations
> + * enum kfd_ioctl_svm_op - SVM ioctl operations
>   *
>   * @KFD_IOCTL_SVM_OP_SET_ATTR: Modify one or more attributes
>   * @KFD_IOCTL_SVM_OP_GET_ATTR: Query one or more attributes
> @@ -786,7 +786,7 @@ enum kfd_ioctl_svm_location {
>  };
>
>  /**
> - * kfd_ioctl_svm_attr_type - SVM attribute types
> + * enum kfd_ioctl_svm_attr_type - SVM attribute types
>   *
>   * @KFD_IOCTL_SVM_ATTR_PREFERRED_LOC: gpuid of the preferred location, 0=
 for
>   *                                    system memory
> @@ -815,7 +815,7 @@ enum kfd_ioctl_svm_attr_type {
>  };
>
>  /**
> - * kfd_ioctl_svm_attribute - Attributes as pairs of type and value
> + * struct kfd_ioctl_svm_attribute - Attributes as pairs of type and valu=
e
>   *
>   * The meaning of the @value depends on the attribute type.
>   *
> @@ -828,7 +828,7 @@ struct kfd_ioctl_svm_attribute {
>  };
>
>  /**
> - * kfd_ioctl_svm_args - Arguments for SVM ioctl
> + * struct kfd_ioctl_svm_args - Arguments for SVM ioctl
>   *
>   * @op specifies the operation to perform (see enum
>   * @kfd_ioctl_svm_op).  @start_addr and @size are common for all
> @@ -875,7 +875,7 @@ struct kfd_ioctl_svm_args {
>  };
>
>  /**
> - * kfd_ioctl_set_xnack_mode_args - Arguments for set_xnack_mode
> + * struct kfd_ioctl_set_xnack_mode_args - Arguments for set_xnack_mode
>   *
>   * @xnack_enabled:       [in/out] Whether to enable XNACK mode for this =
process
>   *
> @@ -1055,15 +1055,15 @@ struct kfd_runtime_info {
>  #define KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK 2
>
>  /**
> - * kfd_ioctl_runtime_enable_args - Arguments for runtime enable
> + * struct kfd_ioctl_runtime_enable_args - Arguments for runtime enable
>   *
>   * Coordinates debug exception signalling and debug device enablement wi=
th runtime.
>   *
> - * @r_debug - pointer to user struct for sharing information between ROC=
r and the debuggger
> - * @mode_mask - mask to set mode
> + * @r_debug: pointer to user struct for sharing information between ROCr=
 and the debuggger
> + * @mode_mask: mask to set mode
>   *     KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK - enable runtime for debuggin=
g, otherwise disable
>   *     KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK - enable trap temporary se=
tup (ignore on disable)
> - * @capabilities_mask - mask to notify runtime on what KFD supports
> + * @capabilities_mask: mask to notify runtime on what KFD supports
>   *
>   * Return - 0 on SUCCESS.
>   *       - EBUSY if runtime enable call already pending.
> @@ -1158,17 +1158,15 @@ enum kfd_dbg_trap_operations {
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_enable_args
> - *
> - *     Arguments for KFD_IOC_DBG_TRAP_ENABLE.
> + * struct kfd_ioctl_dbg_trap_enable_args - Arguments for KFD_IOC_DBG_TRA=
P_ENABLE.
>   *
>   *     Enables debug session for target process. Call @op KFD_IOC_DBG_TR=
AP_DISABLE in
>   *     kfd_ioctl_dbg_trap_args to disable debug session.
>   *
> - *     @exception_mask (IN)    - exceptions to raise to the debugger
> - *     @rinfo_ptr      (IN)    - pointer to runtime info buffer (see kfd=
_runtime_info)
> - *     @rinfo_size     (IN/OUT)        - size of runtime info buffer in =
bytes
> - *     @dbg_fd        (IN)     - fd the KFD will nofify the debugger wit=
h of raised
> + *     @exception_mask: (IN) - exceptions to raise to the debugger
> + *     @rinfo_ptr:      (IN) - pointer to runtime info buffer (see kfd_r=
untime_info)
> + *     @rinfo_size:     (IN/OUT) - size of runtime info buffer in bytes
> + *     @dbg_fd:                (IN) - fd the KFD will nofify the debugge=
r with of raised
>   *                               exceptions set in exception_mask.
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
> @@ -1188,15 +1186,14 @@ struct kfd_ioctl_dbg_trap_enable_args {
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_send_runtime_event_args
> - *
> + * struct kfd_ioctl_dbg_trap_send_runtime_event_args - Arguments for
> + * KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT.
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT.
>   *     Raises exceptions to runtime.
>   *
> - *     @exception_mask (IN) - exceptions to raise to runtime
> - *     @gpu_id        (IN) - target device id
> - *     @queue_id       (IN) - target queue id
> + *     @exception_mask: (IN) - exceptions to raise to runtime
> + *     @gpu_id:                (IN) - target device id
> + *     @queue_id:       (IN) - target queue id
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - 0 on SUCCESS.
> @@ -1213,12 +1210,12 @@ struct kfd_ioctl_dbg_trap_send_runtime_e
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_set_exceptions_enabled_args
> + * struct kfd_ioctl_dbg_trap_set_exceptions_enabled_args - Arguments for
> + * KFD_IOC_SET_EXCEPTIONS_ENABLED
>   *
> - *     Arguments for KFD_IOC_SET_EXCEPTIONS_ENABLED
>   *     Set new exceptions to be raised to the debugger.
>   *
> - *     @exception_mask (IN) - new exceptions to raise the debugger
> + *     @exception_mask: (IN) - new exceptions to raise the debugger
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - 0 on SUCCESS.
> @@ -1228,16 +1225,16 @@ struct kfd_ioctl_dbg_trap_set_exceptions
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_set_wave_launch_override_args
> + * struct kfd_ioctl_dbg_trap_set_wave_launch_override_args - Arguments f=
or
> + * KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE
>   *     Enable HW exceptions to raise trap.
>   *
> - *     @override_mode       (IN)     - see kfd_dbg_trap_override_mode
> - *     @enable_mask         (IN/OUT) - reference kfd_dbg_trap_mask.
> + *     @override_mode:      (IN)     - see kfd_dbg_trap_override_mode
> + *     @enable_mask:        (IN/OUT) - reference kfd_dbg_trap_mask.
>   *                                     IN is the override modes requeste=
d to be enabled.
>   *                                     OUT is referenced in Return below=
.
> - *     @support_request_mask (IN/OUT) - reference kfd_dbg_trap_mask.
> + *     @support_request_mask: (IN/OUT) - reference kfd_dbg_trap_mask.
>   *                                     IN is the override modes requeste=
d for support check.
>   *                                     OUT is referenced in Return below=
.
>   *
> @@ -1254,36 +1251,38 @@ struct kfd_ioctl_dbg_trap_set_wave_launc
>         __u32 override_mode;
>         __u32 enable_mask;
>         __u32 support_request_mask;
> +       /* private: */
>         __u32 pad;
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_set_wave_launch_mode_args
> + * struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args - Arguments for
> + * KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE
>   *     Set wave launch mode.
>   *
> - *     @mode (IN) - see kfd_dbg_trap_wave_launch_mode
> + *     @launch_mode: (IN) - see kfd_dbg_trap_wave_launch_mode
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - 0 on SUCCESS.
>   */
>  struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args {
>         __u32 launch_mode;
> +       /* private: */
>         __u32 pad;
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_suspend_queues_ags
> + * struct kfd_ioctl_dbg_trap_suspend_queues_args - Arguments for
> + * KFD_IOC_DBG_TRAP_SUSPEND_QUEUES
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_SUSPEND_QUEUES
>   *     Suspend queues.
>   *
> - *     @exception_mask (IN) - raised exceptions to clear
> - *     @queue_array_ptr (IN) - pointer to array of queue ids (u32 per qu=
eue id)
> + *     @exception_mask:        (IN) - raised exceptions to clear
> + *     @queue_array_ptr: (IN) - pointer to array of queue ids (u32 per q=
ueue id)
>   *                            to suspend
> - *     @num_queues     (IN) - number of queues to suspend in @queue_arra=
y_ptr
> - *     @grace_period   (IN) - wave time allowance before preemption
> + *     @num_queues:    (IN) - number of queues to suspend in @queue_arra=
y_ptr
> + *     @grace_period:  (IN) - wave time allowance before preemption
>   *                            per 1K GPU clock cycle unit
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
> @@ -1311,14 +1310,14 @@ struct kfd_ioctl_dbg_trap_suspend_queues
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_resume_queues_args
> + * struct kfd_ioctl_dbg_trap_resume_queues_args - Arguments for
> + * KFD_IOC_DBG_TRAP_RESUME_QUEUES
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_RESUME_QUEUES
>   *     Resume queues.
>   *
> - *     @queue_array_ptr (IN) - pointer to array of queue ids (u32 per qu=
eue id)
> + *     @queue_array_ptr: (IN) - pointer to array of queue ids (u32 per q=
ueue id)
>   *                            to resume
> - *     @num_queues     (IN) - number of queues to resume in @queue_array=
_ptr
> + *     @num_queues:    (IN) - number of queues to resume in @queue_array=
_ptr
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - Number of queues resumed on SUCCESS.
> @@ -1331,20 +1330,21 @@ struct kfd_ioctl_dbg_trap_suspend_queues
>  struct kfd_ioctl_dbg_trap_resume_queues_args {
>         __u64 queue_array_ptr;
>         __u32 num_queues;
> +       /* private: */
>         __u32 pad;
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_set_node_address_watch_args
> + * struct kfd_ioctl_dbg_trap_set_node_address_watch_args - Arguments for
> + * KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH
>   *     Sets address watch for device.
>   *
> - *     @address        (IN)  - watch address to set
> - *     @mode    (IN)  - see kfd_dbg_trap_address_watch_mode
> - *     @mask    (IN)  - watch address mask
> - *     @gpu_id  (IN)  - target gpu to set watch point
> - *     @id      (OUT) - watch id allocated
> + *     @address: (IN)  - watch address to set
> + *     @mode:    (IN)  - see kfd_dbg_trap_address_watch_mode
> + *     @mask:    (IN)  - watch address mask
> + *     @gpu_id:  (IN)  - target gpu to set watch point
> + *     @id:      (OUT) - watch id allocated
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - 0 on SUCCESS.
> @@ -1361,13 +1361,13 @@ struct kfd_ioctl_dbg_trap_set_node_addre
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_clear_node_address_watch_args
> + * struct kfd_ioctl_dbg_trap_clear_node_address_watch_args - Arguments f=
or
> + * KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH
>   *     Clear address watch for device.
>   *
> - *     @gpu_id  (IN)  - target device to clear watch point
> - *     @id      (IN) - allocated watch id to clear
> + *     @gpu_id:  (IN)  - target device to clear watch point
> + *     @id:      (IN) - allocated watch id to clear
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - 0 on SUCCESS.
> @@ -1380,12 +1380,12 @@ struct kfd_ioctl_dbg_trap_clear_node_add
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_set_flags_args
> + * struct kfd_ioctl_dbg_trap_set_flags_args - Arguments for
> + * KFD_IOC_DBG_TRAP_SET_FLAGS
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_SET_FLAGS
>   *     Sets flags for wave behaviour.
>   *
> - *     @flags (IN/OUT) - IN =3D flags to enable, OUT =3D flags previousl=
y enabled
> + *     @flags: (IN/OUT) - IN =3D flags to enable, OUT =3D flags previous=
ly enabled
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - 0 on SUCCESS.
> @@ -1393,13 +1393,13 @@ struct kfd_ioctl_dbg_trap_clear_node_add
>   */
>  struct kfd_ioctl_dbg_trap_set_flags_args {
>         __u32 flags;
> +       /* private: */
>         __u32 pad;
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_query_debug_event_args
> - *
> - *     Arguments for KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT
> + * struct kfd_ioctl_dbg_trap_query_debug_event_args - Arguments for
> + * KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT
>   *
>   *     Find one or more raised exceptions. This function can return mult=
iple
>   *     exceptions from a single queue or a single device with one call. =
To find
> @@ -1409,9 +1409,9 @@ struct kfd_ioctl_dbg_trap_set_flags_args
>   *     However, clearing an exception prevents retrieving further inform=
ation
>   *     about it with KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO.
>   *
> - *     @exception_mask (IN/OUT) - exception to clear (IN) and raised (OU=
T)
> - *     @gpu_id        (OUT)    - gpu id of exceptions raised
> - *     @queue_id       (OUT)    - queue id of exceptions raised
> + *     @exception_mask: (IN/OUT) - exception to clear (IN) and raised (O=
UT)
> + *     @gpu_id:                (OUT)    - gpu id of exceptions raised
> + *     @queue_id:       (OUT)    - queue id of exceptions raised
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
>   *     Return - 0 on raised exception found
> @@ -1426,16 +1426,16 @@ struct kfd_ioctl_dbg_trap_query_debug_ev
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_query_exception_info_args
> + * struct kfd_ioctl_dbg_trap_query_exception_info_args - Arguments for
> + * KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO
>   *
> - *     Arguments KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO
>   *     Get additional info on raised exception.
>   *
> - *     @info_ptr       (IN)     - pointer to exception info buffer to co=
py to
> - *     @info_size      (IN/OUT) - exception info buffer size (bytes)
> - *     @source_id      (IN)     - target gpu or queue id
> - *     @exception_code (IN)     - target exception
> - *     @clear_exception        (IN)     - clear raised @exception_code e=
xception
> + *     @info_ptr:      (IN)     - pointer to exception info buffer to co=
py to
> + *     @info_size:     (IN/OUT) - exception info buffer size (bytes)
> + *     @source_id:     (IN)     - target gpu or queue id
> + *     @exception_code:        (IN)     - target exception
> + *     @clear_exception: (IN)     - clear raised @exception_code excepti=
on
>   *                                (0 =3D false, 1 =3D true)
>   *
>   *     Generic errors apply (see kfd_dbg_trap_operations).
> @@ -1455,20 +1455,20 @@ struct kfd_ioctl_dbg_trap_query_exceptio
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_get_queue_snapshot_args
> + * struct kfd_ioctl_dbg_trap_queue_snapshot_args - Arguments for
> + * KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT
>   *
> - *     Arguments KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT
>   *     Get queue information.
>   *
> - *     @exception_mask  (IN)     - exceptions raised to clear
> - *     @snapshot_buf_ptr (IN)    - queue snapshot entry buffer (see kfd_=
queue_snapshot_entry)
> - *     @num_queues      (IN/OUT) - number of queue snapshot entries
> + *     @exception_mask:         (IN)     - exceptions raised to clear
> + *     @snapshot_buf_ptr: (IN)   - queue snapshot entry buffer (see kfd_=
queue_snapshot_entry)
> + *     @num_queues:     (IN/OUT) - number of queue snapshot entries
>   *         The debugger specifies the size of the array allocated in @nu=
m_queues.
>   *         KFD returns the number of queues that actually existed. If th=
is is
>   *         larger than the size specified by the debugger, KFD will not =
overflow
>   *         the array allocated by the debugger.
>   *
> - *     @entry_size      (IN/OUT) - size per entry in bytes
> + *     @entry_size:     (IN/OUT) - size per entry in bytes
>   *         The debugger specifies sizeof(struct kfd_queue_snapshot_entry=
) in
>   *         @entry_size. KFD returns the number of bytes actually populat=
ed per
>   *         entry. The debugger should use the KFD_IOCTL_MINOR_VERSION to=
 determine,
> @@ -1491,20 +1491,20 @@ struct kfd_ioctl_dbg_trap_queue_snapshot
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_get_device_snapshot_args
> + * struct kfd_ioctl_dbg_trap_device_snapshot_args - Arguments for
> + * KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT
>   *
> - *     Arguments for KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT
>   *     Get device information.
>   *
> - *     @exception_mask  (IN)     - exceptions raised to clear
> - *     @snapshot_buf_ptr (IN)    - pointer to snapshot buffer (see kfd_d=
bg_device_info_entry)
> - *     @num_devices     (IN/OUT) - number of debug devices to snapshot
> + *     @exception_mask:          (IN)    - exceptions raised to clear
> + *     @snapshot_buf_ptr: (IN)   - pointer to snapshot buffer (see kfd_d=
bg_device_info_entry)
> + *     @num_devices:     (IN/OUT) - number of debug devices to snapshot
>   *         The debugger specifies the size of the array allocated in @nu=
m_devices.
>   *         KFD returns the number of devices that actually existed. If t=
his is
>   *         larger than the size specified by the debugger, KFD will not =
overflow
>   *         the array allocated by the debugger.
>   *
> - *     @entry_size      (IN/OUT) - size per entry in bytes
> + *     @entry_size:      (IN/OUT) - size per entry in bytes
>   *         The debugger specifies sizeof(struct kfd_dbg_device_info_entr=
y) in
>   *         @entry_size. KFD returns the number of bytes actually populat=
ed. The
>   *         debugger should use KFD_IOCTL_MINOR_VERSION to determine, whi=
ch fields
> @@ -1527,12 +1527,10 @@ struct kfd_ioctl_dbg_trap_device_snapsho
>  };
>
>  /**
> - * kfd_ioctl_dbg_trap_args
> - *
> - * Arguments to debug target process.
> + * struct kfd_ioctl_dbg_trap_args - Arguments to debug target process.
>   *
> - *     @pid - target process to debug
> - *     @op  - debug operation (see kfd_dbg_trap_operations)
> + *     @pid: target process to debug
> + *     @op:  debug operation (see kfd_dbg_trap_operations)
>   *
>   *     @op determines which union struct args to use.
>   *     Refer to kern docs for each kfd_ioctl_dbg_trap_*_args struct.
> @@ -1567,7 +1565,7 @@ enum kfd_profiler_ops {
>  };
>
>  /**
> - * Enables/Disables GPU Specific profiler settings
> + * struct kfd_ioctl_pmc_settings - Enables/Disables GPU Specific profile=
r settings
>   */
>  struct kfd_ioctl_pmc_settings {
>         __u32 gpu_id;             /* This is the user_gpu_id */
