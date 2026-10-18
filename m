Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A513606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IXknaNJ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E8A10F2E7;
	Tue, 20 Oct 2026 07:36:27 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DF710E12B
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 16:17:42 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so8714245e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792340260; x=1792945060; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZTfsVeABUBSFy3HVBXCMegGi7+UD9ADpc6dIspx0V50=;
 b=IXknaNJ/6kVFTEnZH38N2lRW1fr/iGzaETyMjuc9N2RYXgwEgyjxbV++F0TDFHtKGM
 gwz4KUQ8UeCpN5IFGlngK07xz7dBrm99MsN2v4Alf8LewVS5Ztib8cnFvbibAOLUJxA1
 vZLdWmc9R1RiQM8v/j6CEo+Msb88cYMHBcnRIpcyRYu6IFEQUwlH2bxzadPmP7+hSkuM
 +vWJKULnDE5QyBfR9yLH17xwx7TJHavq4TK82S3LsJ9Xs2Y60rJC6thRPtXT5mtpbIzW
 gH1dAPubDbm3noIu3TBJYBueixurTdiDTiO8e/yg2M4AJVjBiEb7/mlagrfF7E8kyvWK
 +06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792340260; x=1792945060;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZTfsVeABUBSFy3HVBXCMegGi7+UD9ADpc6dIspx0V50=;
 b=UoslPppfwYcmkLvnTVa9GxjDXoW4anKneUh9798omgDMQ4JijmpTc3FoYzdWoQcYBh
 dVUig75DtBGWUZ8FcJExpjz7DUm0Zm+YTyWfLzwXrN/YzfERnERITMvWsIKHZqWhiBTc
 9AEiypwSVGGLoQwRbgf/W/V6pwmCVvgYM0VStQQN4mh4xi+SKC+WGDiD80irrD0AmEGM
 xpgUw9OJqJCgZ0x1nRm5kvbLGGC/ZBlyxSPwuOsDR7u6JQi6/dOeOTWKwS8EXz1sTUN1
 JuWTRwqcUibb2vfLerFz3mSYQEPda81lWLiUXEmKEiRSorlYCwJvLKmFm703fOxWWRMw
 +2iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx01BVW4YvLZlyvzr3ftdK1d8z9ZbUEL4djFwTVve9GzEujObvFyLAPL8yYFiIVOnZ3oB44bJoWgck=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJKICApyhx/p5jirNLpkwA8m3iCF9i49QvRKLKStC0Mwrmxrt50
 8XHf4Ph2/WLW6iB+dC7mva1hzCAjGfoPzDVD4uEVkuiCmQVZss1lFdbs
X-Gm-Gg: AYBFou2o2CEQA4twpsnV2IO414tcfmd2tlk80B16YVx2U9fiJWMs3tTbpc05CxGarYz
 vrxXem5+yZL0x8VaVag8JEZGpXuOLmkQa+ZEWc4G8bCN1KxNboeKCPsJ52zXLdhHc4uBMKoS0Ww
 x48S5H/1AnKL72QdUt8VNPFkWGihT3jJ7GM0SVa9Mmj0PoSvFot+u2w8PcVwYl3Y7EYiSQiOuPF
 TfxBf+sWue4pvNzgr3Lk7tPWS1/mqmT9amuTOSN0A1NeEydxoO5cW4iokvfmDMd9Z7S0iGI8Gmn
 I4sf/CWAYgrehPamV4slI3hMMfEMIpGOSzuf0C/Y4IQ0pjN/sMr09EKTaWdVHoH0UoMXLXEvwnK
 iModyMp0wgXDHGRdgUGAh4desbCv9s3Gdz/jHRSwtC8+GGrh5dxaoUxcU65vdnvmVe4670S2cTZ
 WHFixL89B32VM1ixzW1WJ+VChaI8Kc1E7rj4hmYwRzHAC7AMWPiFQFEFE6zdRkgEPQDirCQ1v/F
 qE2MUJrnRIjuuGxzo8S1XTCUuRZikrPrMU5r2hvySzYNvYPIzSThy2chxN6NRY=
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id
 5b1f17b1804b1-4a1d75ab363mr119735965e9.4.1792340260358; 
 Sun, 18 Oct 2026 09:17:40 -0700 (PDT)
Received: from home-desktop (dynamic-002-214-000-206.2.214.pool.telefonica.de.
 [2.214.0.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1df164777sm119463445e9.5.2026.10.18.09.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 09:17:39 -0700 (PDT)
Date: Sun, 18 Oct 2026 18:17:37 +0200
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
Subject: Re: [PATCH] drm/virtio: Destroy obj_restore_lock on the final
 drm_dev_put()
Message-ID: <atTxIeLq1VspA70F@home-desktop>
References: <20260929070714.169412-1-abhinjoses@gmail.com>
 <asxz0Xvv5jO9gAol@home-desktop>
 <537679fc-8aea-472f-a7af-b15bd3cf27fd@collabora.com>
 <as_drl4kYXmgOfRn@home-desktop>
 <8e193dd9-4ceb-4bd0-a28f-f4af084b73e8@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e193dd9-4ceb-4bd0-a28f-f4af084b73e8@collabora.com>
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 15, 2026 at 12:03:32AM +0300, Dmitry Osipenko wrote:
> On 10/14/26 22:53, Abhin Parekadan Jose wrote:
> > On Wed, Oct 14, 2026 at 01:16:57AM +0300, Dmitry Osipenko wrote:
> >> On 10/12/26 08:44, Abhin Parekadan Jose wrote:
> >>> Gentle ping on this fix for the syzbot report.
> >>>
> >>> Dmitry, Gerd, do you have a preference between moving mutex_destroy()
> >>> to virtio_gpu_release() (this patch) and using drmm_mutex_init()? I can
> >>> send a v2 with the other option if you prefer it.
> >>>
> >>> Thanks,
> >>> Abhin
> >>>
> >>> On Tue, Sep 29, 2026 at 07:07:14AM +0000, Abhin Parekadan Jose wrote:
> >> Calling virtio_gpu_deinit() from virtio_gpu_release() might be a better
> >> option
> > 
> > Wouldn't that end up freeing the virtqueues twice, or using them after
> > they are freed? virtio_gpu_deinit() would then run from both the
> > virtio_gpu_remove() path and the virtio_gpu_release() path.
> > or do you mean removing it from virtio_gpu_remove() and calling it only
> > from virtio_gpu_release()?
> > This is only from a high-level look so far. I'll look into it more
> > closely and get back to you.
> 
> Remove from virtio_gpu_remove() and call only from virtio_gpu_release().

I tried this out and here are my findings.

That would undo b1df3a2b24a9 ("drm/virtio: add drm_driver.release
callback."), which split virtio_gpu_deinit() on purpose: "move the drm
shutdown and release to virtio_gpu_release() ... use
drm_dev_{enter,exit,unplug} to avoid touching hardware after device
removal". That matches what the documentation asks for. drm_dev_unplug()
exists so the device can be unplugged "while there are still open users
of @dev", and Documentation/gpu/drm-uapi.rst (Device Hot-Unplug) says
the DRM instance is torn down only after userspace has closed all
descriptors and mmaps. Meanwhile the virtio side has to be gone when
->remove() returns: the example in
Documentation/driver-api/virtio/writing_virtio_drivers.rst resets the
device and deletes the vqs in remove(), and virtio_dev_remove() warns
("Driver should have reset device") if the driver did not.

So the virtio teardown (reset, flushing the vq workers, del_vqs) has to
stay in remove(), and everything that open files and GEM objects can
still reach has to wait for release(). I tried moving the deinit call
into release() to be sure: the virtio core warns that the device was
not reset and that the vq MSI vectors are still allocated at PCI
removal, and the deferred reset then runs on a virtio_device that
virtio_pci_remove() already freed (KASAN use-after-free in
virtio_reset_device()). It only makes things more complicated.

obj_restore_lock is on the wrong side of that split. It is only used
from GEM paths (the ->free callbacks via
virtio_gpu_remove_from_restore_list(), object creation, and the PM
freeze/restore ops), and the free callbacks can run after unplug, like
the vbuf cache and host_visible_mm that release() already handles. So
the mutex belongs in virtio_gpu_release(), which is what this patch
does.

It only looks like the mutex_destroy(...) landed in the wrong function
virtio_gpu_deinit() instead of virtio_gpu_release() in 54a970048296.

Is there something I am missing in the framework, or have I understood
it wrong?

Regards,
Abhin
