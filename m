Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23A1FAD3E1
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 00:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C25010E2D4;
	Thu, 23 Apr 2026 00:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="i4LrqrpO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2E610E2D4
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776902745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTLRxRmC1m3wnjMNJbEiJEsE/z9W8hq0zq/nSUjt/0o=;
 b=i4LrqrpOS2QaUUXB9IYPv407r0HQ/q0XGIV5CrOfs9EyAoEotX39KQTbuE6nZtXpJeARh9
 KqCYGH7ONtpi2SMd82wYiTKp9aSvq9RC1i43W6PXPLW6enbRyUPjHApyEeKnOZK+9bocj4
 ygmMvkXyCRArcCm9pztN3oUXGcDizds=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-gXV1OVzwN9-CFk_jAUWiUg-1; Wed, 22 Apr 2026 20:05:44 -0400
X-MC-Unique: gXV1OVzwN9-CFk_jAUWiUg-1
X-Mimecast-MFC-AGG-ID: gXV1OVzwN9-CFk_jAUWiUg_1776902743
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so9518258eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776902742; x=1777507542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTLRxRmC1m3wnjMNJbEiJEsE/z9W8hq0zq/nSUjt/0o=;
 b=CNrSwqF1I5iyD0VBpLjapvk2cLCj09h4ZhqhJK1YB2drWtV/Pfvd5tGPKfBfwVPODr
 C5EFVZDPzu6Bvp+6aeghpRoTO4JQoI+q4AJa21tEHZ+JwOgAYYKH54Et9G7+ur/cy+6V
 oh3pmwUBfqqnsYx0PdF8ZQ7uv0ggtGoGOmluSdHd47+q9CRrzZMhDGrfkJlN1Ybvw5ZE
 CNiMwMoN1HIjKFgl7eNKpeSlbxLDJcEs96M/h+CtEpEpGj5Tm6mUR4e/wM7UIvsSnBR0
 y4gwxFYZc7m6fOUJISBu6hhHU0IQeaDTMTVqVsrJ0xOblAR50xJphprt5G9ak2tpyKtz
 i+vQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PvGxkOdfJ0A8mZpKp8mySw5QO7gc5GI3OBxa8kNoKoH7kZF6+MrRjGLCfypRv9XE4zzidG8R4lDg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQs9kxBBu1Hqcd+LxT4KLVdeGv3dWqRBVLRj9x0TFH/uj2K7ga
 kg9S9T42lO2oT+zrU7vHUnwSIx1cj7CUWt8UrAEtGKrnw4hlmn6TqNvX8FeCkM5z5q51tQySjZM
 SV0m07vysfN8tbIpPtps1aSSwj/pRZNQ827neLGBRkENqb7XaBKChs72aE0g8UisgzLV1VxIX76
 en+cus/UFiWVboEhnss4xfJ36+hzpFWTE4mrAhyGlEqRhc
X-Gm-Gg: AeBDiesjnhf2/t20DQ8xhY1Qq4B7rqq0yYpwC4jD50A6m4L/ftpHMTNjoDkcsg0o6ME
 9V2Gx8NY0XjEKRCAbvQcCv09XXxOGn2vwSVPbbwAO5hxLKmiPoFJLf52eaGSA+awhZymA9DYU8s
 nhnbKlnQ07IGFmet3VV2rxw4YFQVv46uNpmNk1F3+JFrFuRPJrJPiSS5gmIrT08GNCCWpZ6FoNi
 0R52zFK/umAq7JaiS+2Dw/XTyp7SbvazI40+ElNrDXMX9s=
X-Received: by 2002:a05:7022:f016:b0:128:d23d:81aa with SMTP id
 a92af1059eb24-12c73faca14mr11655214c88.27.1776902742179; 
 Wed, 22 Apr 2026 17:05:42 -0700 (PDT)
X-Received: by 2002:a05:7022:f016:b0:128:d23d:81aa with SMTP id
 a92af1059eb24-12c73faca14mr11655193c88.27.1776902741520; Wed, 22 Apr 2026
 17:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
In-Reply-To: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
From: David Airlie <airlied@redhat.com>
Date: Thu, 23 Apr 2026 10:05:29 +1000
X-Gm-Features: AQROBzCQqw9OhXaXA5MO3lzzBjvGWkY9Mt9BT5XCGA5DPmHbMTTSU5rO5aZ6Kc8
Message-ID: <CAMwc25qszFpFGXC8A6DSDhpE8AEEbqh1B6sUJMT=t6t+CaBJ0g@mail.gmail.com>
Subject: Re: further issues with MGA G200 graphics chipset
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pasi Vaananen <pvaanane@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eiVjSOStdHfjBGqPFd0YqwqRGnfKs64BzMQpEmIzlfw_1776902743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

>
> These all appear to be workqueue warnings about functions that are
> hogging CPU. If I look carefully, it looks like they are all possibly
> related to the same mgag200 driver. At the very least
> output_poll_execute is certainly related to the mgag200 stall.
>
> I do noot understand exactly what is causing the driver to get stuck,
> its something in the i2c routine for reading the EDID block.
>
> I also see this being printed:
>
>  EDID block 0 (tag 0x00) checksum is invalid, remainder is 125
>
> It appears to print quite consistently every few seconds. I guess this
> might be possibly related to a bad EDID block on the mgag200 device?
> What does this even mean?
>

It sounds like the polling is having trouble with the i2c bus even if
there is no cable plugged in, probably cheaped out on some pull
up/down resistors on the VGA connector.

does adding drm_kms_helper.poll=0 help to the command line help?

Dave.

> I am not sure how I'd go about verifying this, or root causing what is
> going wrong.
>
> It looks like we print the message as part of _drm_do_get_edid(), and
> this definitely is called as part of the mgag200 routines:
>
> > -   33.33%    33.33%  kworker/64:1-ev  [kernel.kallsyms]  [k] _drm_do_get_edid
> >      ret_from_fork_asm
> >      ret_from_fork
> >      kthread
> >      worker_thread
> >      process_one_work
> >      output_poll_execute
> >      drm_client_dev_hotplug
> >      drm_fbdev_shmem_client_hotplug
> >      drm_fb_helper_hotplug_event
> >      drm_client_modeset_probe
> >      drm_helper_probe_single_connector_modes
> >      mgag200_vga_bmc_connector_helper_get_modes
> >      drm_connector_helper_get_modes
> >      drm_edid_read
> >      drm_edid_read_custom
> >      _drm_do_get_edid
>
> This makes me think that we're reading a bad EDID. I enabled drm.debug
> setting to get more data:
>
> > Apr 22 23:47:11 1762811 kernel: EDID block 0 (tag 0x00) checksum is invalid, remainder is 125
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:connector_bad_edid] [CONNECTOR:36:VGA-1] EDID is invalid:
> > Apr 22 23:47:11 1762811 kernel:         [00] BAD  00 ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff
> > Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x720": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x768": 60 68250 1280 1328 1360 1440 768 771 778 790 0x40 0x9 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x768": 60 79500 1280 1344 1472 1664 768 771 778 798 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x800": 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x800": 60 83500 1280 1352 1480 1680 800 803 809 831 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x960": 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x1024": 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1360x768": 60 85500 1360 1424 1536 1792 768 771 777 795 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1366x768": 60 85500 1366 1436 1579 1792 768 771 774 798 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1366x768": 60 72000 1366 1380 1436 1500 768 769 772 800 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1400x1050": 60 101000 1400 1448 1480 1560 1050 1053 1057 1080 0x40 0x9 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1400x1050": 60 121750 1400 1488 1632 1864 1050 1053 1057 1089 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1440x900": 60 88750 1440 1488 1520 1600 900 903 909 926 0x40 0x9 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1440x900": 60 106500 1440 1520 1672 1904 900 903 909 934 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1600x900": 60 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1600x1200": 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1680x1050": 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1680x1050": 60 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1792x1344": 60 204750 1792 1920 2120 2448 1344 1345 1348 1394 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1856x1392": 60 218250 1856 1952 2176 2528 1392 1393 1396 1439 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1200": 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x40 0x9 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1200": 60 193250 1920 2056 2256 2592 1200 1203 1209 1245 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1440": 60 234000 1920 2048 2256 2600 1440 1441 1444 1500 0x40 0x6 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "2048x1152": 60 162000 2048 2074 2154 2250 1152 1153 1156 1200 0x40 0x5 (VIRTUAL_X)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:VGA-1] probed modes:
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "1024x768": 60 65000 1024 1048 1184 1344 768 771 777 806 0x48 0xa
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "800x600": 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "800x600": 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "848x480": 60 33750 848 864 976 1088 480 486 494 517 0x40 0x5
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "640x480": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] enabled? yes
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] Not using firmware configuration
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] looking for cmdline mode
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] looking for preferred mode, tile 0
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] Found mode 1024x768
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] picking CRTCs for 1024x768 config
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CRTC:34:crtc-0] desired mode 1024x768 set (0,0)
> > Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_dev_hotplug] fbdev: ret=0
>
> Does anyone have any idea whats going wrong here? A google search seems
> to imply this is reading the EDID data from the VGA cable...
>
> I'm also curious if its possible to stop polling for so long with udelay
> in the i2c logic somehow? I am not very familiar with i2c, but it is
> frustrating that this driver is causing yet another stall that is
> impacting timing sensitive data. Even if in this case its due to a
> faulty cable.. it is frustrating that such result causes the PTP
> failures. Would switching to WQ_UNBOUND be helpful here at all?
>
> Thanks,
> Jake
>

