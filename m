Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC2606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mzG4dk89
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B5E10E245;
	Wed,  4 Nov 2026 13:43:02 +0000 (UTC)
Received: from mta0.migadu.com (out-76.mta0.migadu.com [91.218.175.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976D210E245
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 13:42:55 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=vOaEg1OkdnnF9i8K4RnupmBm7ey0XeraGG5GGOfTx+A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793799773; v=1; x=1794404573;
 b=mzG4dk89F8/jw1ZoBH17ZWNRnedUEp4JE/xJ/wrcCnM0C1WIXgqvFZ6PRBxjyZDY5DoX1LUG
 zNItyihovWekytQ74f2nQ/jIKy8dlizpEtwFiDjftgtkAJi1GnuC3fuyOPu4Mc52V7svg0Hu2ts
 VlT0bxyqCEDGcDs0lG4G+CGU=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta12.migadu.com with ESMTPS id 4163c625dbcaf8ec;
 Wed, 04 Nov 2026 13:42:53 +0000
X-Mizu-Trace-ID: 4163c625dbcaf8ec
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: drm/appletbdrm: kvzalloc'd request buffer can be rejected by USB
 DMA mapping
Date: Wed, 4 Nov 2026 19:12:39 +0530
Message-Id: <60EDF3E4-FBB7-47A8-AF91-986049AC6FFD@linux.dev>
References: <CAM0DsqVFH-wt+q8yZdq67unXAzXRAq90KDDLoRY5d-X87DNxeQ@mail.gmail.com>
Cc: admin@kodeit.net, dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
 k@chaosmail.tech
In-Reply-To: <CAM0DsqVFH-wt+q8yZdq67unXAzXRAq90KDDLoRY5d-X87DNxeQ@mail.gmail.com>
To: Giulio Malitesta <atsetilam@gmail.com>
X-Mailer: iPad Mail (24B119)
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

I am unable to reproduce this on my Ubuntu 26.04 Linux kernel 7.3.1 with lat=
est t2bce stack. Could you test with the latest kernel and t2bce stack pls?

> On 4 Nov 2026, at 7:39=E2=80=AFAM, Giulio Malitesta <atsetilam@gmail.com> w=
rote:
>=20
> =EF=BB=BFHello,
>=20
> I'm not a developer, so please take this as a user report. The problem
> was found and analysed by Claude (an AI assistant) on my machine: it
> read my kernel log and the driver source, and I'm passing on what it
> found in case it's useful. I can't judge the code myself, and no fix
> has been tested.
>=20
> Hardware: MacBookPro16,1 (2019, T2).
> Kernel: 7.2.11 from t2linux (linux-t2 on Arch). It is tainted: it uses
> the out-of-tree t2bce USB stack, and my own modified amdgpu and
> apple-gmux modules. The trace below goes through t2bce, so I can't
> rule out that it plays a part.
>=20
> On each of the last four boots that lasted more than a few minutes,
> the log shows this warning once:
>=20
>  t2bce_core 0000:04:00.1: rejecting DMA map of vmalloc memory
>  WARNING: ./include/linux/dma-mapping.h:523 at
>    usb_hcd_map_urb_for_dma+0x524/0x580, CPU#0: listello-core/1983
>  Call Trace:
>   usb_hcd_submit_urb+0x321/0xad0
>   usb_start_wait_urb+0x9f/0x230
>   appletbdrm_send_request+0x67/0xb0 [appletbdrm]
>   appletbdrm_primary_plane_helper_atomic_update+0x2d8/0x350 [appletbdrm]
>   drm_atomic_helper_commit_planes+0x114/0x330
>   ...
>   drm_atomic_helper_dirtyfb+0x221/0x320
>   drm_mode_dirtyfb_ioctl+0x1ef/0x240
>=20
> and then, repeatedly:
>=20
>  appletbdrm 7-6:2.1: [drm] *ERROR* Failed to send message (-11)
>=20
> That error appeared 5274 times during one session of about 11 days, in
> short bursts of up to about 20 per minute. Only the first occurrence
> produces the warning, since it is a WARN_ONCE, so it's an assumption
> that the later errors have the same cause.
>=20
> The likely cause: commit aaaa684bab1f ("drm/appletbdrm: Use kvzalloc
> for big allocations") allocates the request buffer with kvzalloc().
> When memory is fragmented, this can fall back to vmalloc, and that
> buffer then goes to usb_bulk_msg(), whose DMA mapping refuses vmalloc
> addresses. The same concern was raised by an automated review of that
> patch in April, and I couldn't find a reply to it:
> https://lore.gitlab.freedesktop.org/drm-ai-reviews/302f22e3-5390-4c0a-aa06=
-bfd02a3175c0@suse.de/t/
>=20
> The kvzalloc() call is still present in current mainline (7.4-rc1), in
> appletbdrm_primary_plane_helper_begin_fb_access(). I haven't run
> mainline on this machine.
>=20
> The impact seems small: I haven't noticed anything on the Touch Bar,
> and the machine stays stable. Presumably a frame is lost when this
> happens, so the bar could show stale content until its next redraw.
>=20
> That automated review suggested kzalloc() with __GFP_RETRY_MAYFAIL, or
> usb_alloc_coherent(), as alternatives. I can't say whether either is
> right, but I can test a patch on this machine if that helps. I may
> need some guidance, and I'd also be using Claude for that.
>=20
> Thanks for your work on this driver,
> Giulio Malitesta
