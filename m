Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7C606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNO9/+S+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8180289A5D;
	Fri,  6 Nov 2026 04:17:04 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813AB10E009
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 04:16:58 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-93e4c00d71aso17611685a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793938617; cv=none;
 d=google.com; s=arc-20260327;
 b=YqhKtwp4Wvrz5uF1dBnROUIQzM58KefBTem1fkpEHaNi0Mcx7ukwUVlfIbKCGnaw5o
 rCDCkDSVIrZCmopoe1m4zR7kMNhMaDxhU6v5np33VKb6QyngtH6oxuLVhuUSPmHAlDTZ
 kxBXQwhge+1NEOapgBkhCZGf9qUWOJ4hYTUkY/J2YTjrDjcF6WqmVB8zNdQpZA+hTkWQ
 bo/gQDggMwkEK4BajdwOlc0M8sXdi4Oohoxxv7O7C4SW5VxLbAZQXNXar6IfXZL+85um
 pR1x9+njcf6knfTlZxhAQM1B4jgVt2vfRFwtyEDlMTJsGShNOrUsCI/TNpUcTV8JDa60
 LbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YAf7ONLuccQ4q1QaxEgb694d9s8wkHRNm7XCVYSS7qc=;
 fh=EkBHfCYGWYgioPXP+SXUL2PPnFQaoU9bpFUQKcrL0C4=;
 b=SP73Ga7x9Qd6rkYa/ZzV3rIyQKzHEyXuXDaoNEax1Amhq7hcifoZq/hIfLHCGs7Gnp
 Qir8lExSMAuJiENgokIqfN0whuHJ+PmYlTXIi5vtJWJxKqWp7jrtvBc7mhbR06IlYmIa
 /q4iVsxD2I19DELmuxflUdPWP4Q4xs7g3C/r3+6a2dAFqtd8Z3T6ePR9IQ2d+2vbB8V1
 6aOnwwuIQvUqYp1xVCraXsSXI5alK9aw/bY80I+sTPFVdZWZ2LyDDwxQfdS3063ilYr6
 oWE08UusEqYVsQKbr/6mRgCc18lkc+spqKppKS9mCtBB5PUWQ04WBUAKcH7Z/18Uf/ia
 R2Bw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793938617; x=1794543417; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YAf7ONLuccQ4q1QaxEgb694d9s8wkHRNm7XCVYSS7qc=;
 b=PNO9/+S+W5J8vjWjh/QYG7cDT1y4gzLc2hYUEtX3dml1r+p34MqzG1mLT14+UOUDH6
 RI/cyg+KUp4jMWSxOOlsPU9hap+o4YQX/wtsx1XeDljQ/W5ZNNNRpBx7EtP0T/d81IE2
 eU35PDzycPdGu3YG4VOwBhTguC+iPr/jfXQXo2Y207Co49Zhsne9cQVUt1lsQ52dS9w9
 k/mpmjFnoaEzkUkSxSIfFjs++ChQnO5yl3mwITGFk7XsFMwW/J1HyxOyFIe23u2+zPbu
 bSoEPKyswwpOSFWHVoymXkWXr65mEBfKqv7DjqyZkCB4ADBZGOeLM0h/ahs4gx3IK0fQ
 XqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793938617; x=1794543417;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YAf7ONLuccQ4q1QaxEgb694d9s8wkHRNm7XCVYSS7qc=;
 b=bKnvFK3XewWtTI4b3Ln5T/lW+BZyTbWKvB7UR7+Sa/bN7p0lxOntFv3p4LMLgz5mT+
 S2JZmU6KaYjHUS3n9HheJJ1ThBP1J8MIuKLI6GDBBFErOFyICDeyDXSvX+7nCQSz4zUz
 YfrFtj2Gi3SSACVRyhjaMI8c7ysA7qrxbM4SKiKiQ9qyw0pOso8ftYlx10Ft/1hCsaug
 OWNG8zABAZVM9NyyUGKAXNBYRbVVlstoqeyb8BuQnhZHM0gX+sXyp2vjSXYMlfHItYJH
 5wBUwEb2YZng6QP9dIf1X4aAvpE4pPskq5Un995RqXZvH+W0M7V6GAcswYq3MZLSM9Ox
 TiDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAMJekbKasZK8BH+n97ofKiGWll9DutA6R+s7hDDhkGOB07+2qIBXg+CW5I8bBS84xBXLMLtzwzXM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z916XxWYu/hMVqVdFD9UuHd65zf3Zm9f4AxdGxv2mvtWO7dJ4Sj
 4r1aTvWJBj9RsE9aLneE3+bAef6cEi1PUzoIyC1MLlcV+m1/69kVyXymGdWWtd4jMLuXZGD00e8
 EnXQriGuKhedT02bFbAZP9bx1W4KBp/Y=
X-Gm-Gg: AYBFou3A7gP6NzlmrHOWHQzIT3JCsZjbUxpduh9GbOeNBb0FThVSK/e1bT9F2XSqf+z
 bhUOOnnoeqlmmgcUH2NwpTGxtSpWyxtEH6NfwUXZnr462jHAY/OxEYCV4+89XMjb0a3B+Vn4PvG
 /rz79ZdsWSdVk0PcvMysBNhf9msFOC1zYgqCcSaNYNK96aY9RZRCTcsfliWjXI+ppn4YMU9NZtY
 FCCfHp3NEokQDrnm1iZBXoiNyEuGR0Q+59ISu72UeWm/rDmEXdv/2YGSdq14DMEwCGBHCglv//a
 WI0nJDLi4Zx5am5oaCMyyXKgqljPkM1ruPagEe2KMDOLIbMKaTAKQpTPL33VqziIo6eslwYz35i
 /S1JhXPhoSizif/+NDZ6Yqoieh1wYfeq5hsyNzIdd/xGhtRqDNjO+F7aiPEx6dr7hXnT24urQQq
 h9fL3hZ+37CS1AiE3ew8KOJrHCZI0KKWa9Ki+qxU+kccI=
X-Received: by 2002:a05:620a:29c2:b0:945:f099:8776 with SMTP id
 af79cd13be357-945f335489dmr188413185a.4.1793938617395; Thu, 05 Nov 2026
 20:16:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <5e79d3c0-5b2c-4e6c-ba38-3b723daf7109@intel.com>
 <atDXDlI-EhrA791a@intel.com> <d4d5302f-9768-4122-bbab-4384ef7aa9fe@intel.com>
 <atD66da36wMZ0gie@intel.com> <3dc05c1e-fe02-475b-a525-7c53081e816a@intel.com>
In-Reply-To: <3dc05c1e-fe02-475b-a525-7c53081e816a@intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 6 Nov 2026 14:16:45 +1000
X-Gm-Features: AclHuK_qVk_mk86S6JfIT1gnFSXBmrgpYGJ58tw6bXoxtZb1T0y3DgnX0AzFe1M
Message-ID: <CAPM=9tzc6QxVvz+QBYGGtkp=2Mo7W27Mm0togp_LfKspgtoL3w@mail.gmail.com>
Subject: Re: Nasty console and xe driver interactions
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Zack Rusin <zack.rusin@broadcom.com>,
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
 intel-gfx <intel-gfx@lists.freedesktop.org>, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 10:16, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/15/26 09:10, Rodrigo Vivi wrote:
> >> BTW, "xe.force_probe=!*" on the command-line also gets the output back
> >> to normal.
> > the force probe proves that we can still probe safely, but apparently
> > on my first attempt I missed the fact that pcim_enable_device will
> > touch the device and register a pci_disable_device that might
> > clear stuff and mess with the VGA fb...
> >
> > Perhaps if we move just one step over:
> >
> > https://github.com/rodrigovivi/linux/
> > commit/616cd8c1b4d4414cd1f7ad56fa5d8abd36d7968d
>
> So I gave this exact commit a go. It still seems to have the same basic
> problems. I put the missing "ptl_guc_70.bin" file in place, but it just
> moved over to needing the "huc" and went back to the no console
> behavior. I added the "huc" and the "gsc", which seems to make the
> driver happier, but the screen has garbage. Looks like I may be missing
> one of those MEI drivers.
>
> But, still, the driver seems to be rather aggressive about killing the
> console even before it is working itself:
>
> > [    0.672748] xe 0000:00:02.0: vgaarb: deactivate vga console
> > [    0.673227] xe 0000:00:02.0: [drm] Running in SR-IOV PF mode
> > [    0.676750] xe 0000:00:02.0: [drm] Tile0: GT0: Using GuC firmware from xe/ptl_guc_70.bin version 70.72.1
> > [    0.914206] xe 0000:00:02.0: [drm] Tile0: GT0: ccs1 fused off
> > [    0.914213] xe 0000:00:02.0: [drm] Tile0: GT0: ccs2 fused off
> > [    0.914214] xe 0000:00:02.0: [drm] Tile0: GT0: ccs3 fused off
> > [    0.935645] xe 0000:00:02.0: [drm] Tile0: GT1: Using GuC firmware from xe/ptl_guc_70.bin version 70.72.1
> > [    0.937939] xe 0000:00:02.0: [drm] Tile0: GT1: Using HuC firmware from xe/ptl_huc.bin version 10.3.3
> > [    0.938382] xe 0000:00:02.0: [drm] Tile0: GT1: Using GSC firmware from xe/ptl_gsc_1.bin version 105.0.2.1397
> > [    0.938855] xe 0000:00:02.0: [drm] Tile0: GT1: can't init GSC proxy due to missing mei component
> > [    0.959120] xe 0000:00:02.0: [drm] Tile0: GT1: vcs1 fused off
> > [    0.959139] xe 0000:00:02.0: [drm] Tile0: GT1: vcs2 fused off
> > [    0.959150] xe 0000:00:02.0: [drm] Tile0: GT1: vcs3 fused off
> > [    0.959159] xe 0000:00:02.0: [drm] Tile0: GT1: vcs4 fused off
> > [    0.959168] xe 0000:00:02.0: [drm] Tile0: GT1: vcs5 fused off
> > [    0.959177] xe 0000:00:02.0: [drm] Tile0: GT1: vcs6 fused off
> > [    0.959186] xe 0000:00:02.0: [drm] Tile0: GT1: vcs7 fused off
> > [    0.959195] xe 0000:00:02.0: [drm] Tile0: GT1: vecs1 fused off
> > [    0.959205] xe 0000:00:02.0: [drm] Tile0: GT1: vecs2 fused off
> > [    0.959214] xe 0000:00:02.0: [drm] Tile0: GT1: vecs3 fused off
> > [    1.024100] [drm] Initialized xe 1.1.0 for 0000:00:02.0 on minor 0
>
> BTW, I am building the "xe" driver in. It's causing all kinds of fun
> problems, like needing to manually add xe firmware to my initrd.
>
> Maybe the:
>
>         config DRM_XE_DISPLAY
>                 bool "Enable display support"
>                 depends on DRM_XE && DRM_XE=m && HAS_IOPORT
>
> DRM_XE=m dependency is biting me. Is it stealing the console before it
> knows it can actually display something?

It's chicken and egg, you can't init the GPU properly until you steal
the console, you can't unsteal the console once you fail to init the
GPU properly.

Restoring text or efifb is quite difficult depending on how far into
init you get before you have to. You unfortunately don't have a kick
off efifb now option.

Though we could probably do better, it's hard to validate.

Dave.
