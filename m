Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3EF606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VojKspHo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 206A8112C1C;
	Fri,  6 Nov 2026 09:18:42 +0000 (UTC)
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com
 [74.125.227.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A54F10E887
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:47:05 +0000 (UTC)
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-3aec0d4cca3so43953a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 01:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793785625; cv=none;
 d=google.com; s=arc-20260327;
 b=blS+Lt8/0a+ow597obn84geqaS0FZr/KzyFNK6MpTIHcI4qKON3RP/t3j9ieTCymQb
 tFk0LxWg3xtMOlXMV+nXIdjQ2VkKgAKbZDnG+65sgkTSmIprS6j7Yac2iAKDq6lizgIK
 F2oC+ol1Dkz68Xqz5A5QgIrw+ezSZ2WO2XViSmvmqlnB960U09aFDrnzCUXqsOWeScGw
 7t72cxitJtclctuKzZwnT6xZZRR9mZ+5YigJ1aclwxJQZ5+L66DsMxjug9W6TdvXfkZf
 Jn/sJf36BHi+bg2rbEoZXuVUINtTHhHO5mt3v/Sdn8pgBYGCGT0lNEzHmwvdWpn/Y8Bq
 237g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vDG54N36XWJPLC9BtF29WdqvzNITISdymLls5vslhFw=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=qeP92J6VMTdk6wSedSJZXXynFiF2J3fvWwX+moG16mF7QDxwoXVu8PG18cJ3gx2GUx
 MH+l8LavoGan8j59j8dYTlSznWEVpLp9ftjKyHOYqXXEj7aP2/R2VLt87M6YDJLWk6QK
 y+ek+6Wc5/+AJ7SWInsSmQrKqq/V+mLqo4MZTZ9YELvQPY2zD7e3+KeuWMcnJIch8rYx
 d/XPA1U+FlGi1nx/z1OvV9EUPkMnjEJmojv9YAKKzzuWa9EoMnKq/5ASPnR/OjMBprBJ
 MyYJK5+6VbUzbRWF8OHC4oxU0mevZiorWSILNZTd4+G1z9VxhJzBYvdb5a9GXXKqDdeC
 angA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793785625; x=1794390425; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vDG54N36XWJPLC9BtF29WdqvzNITISdymLls5vslhFw=;
 b=VojKspHoJVO/Ht61pSQs8B5r0PbOI/+GdTEXCHHMZpO51OOUsr73REZY25Fni+rwrp
 o4yvEMnjWyQ1p0EAqMb4E9R9xVBKklcre0jWZaau7kc6c5DWPXVzcrT1EDVEmCcwzwoS
 F5UrgA58JHu+3+QMWAesLEi8/96bIYnqDPEzl6L8byh/GwtFHeCSwTkt8BcrD3fS+rFo
 VFPWy5FFZCOt9h3UXmC6ZZqLuGC1IZY+oAirscWyJ5r6PropWd4QtHw1uvUoWjjJHP0F
 muETZPeFb2DQ0lsJM2yz9N7eshFpxEaV8fc3lM8edcQGmGWlf8EBElpeIcYwZmtxN0fn
 FuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785625; x=1794390425;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vDG54N36XWJPLC9BtF29WdqvzNITISdymLls5vslhFw=;
 b=ct8UVHilAHLw182JdQ8ljM4SX/1xv9mXfrlNTKNxbb4qyaau+pcq6r0bgPqfcRertj
 RGgN388eG/4eIPVoTAKQXU9pI2DIdkBVDWddCPBpK1GbXXsK16J6cfEueZRAqqrbndQu
 aHEQGiea5DcIxK1QUxpepFKS+Kq3WgGpyylzkaDponA0Z5nqZfUZNfYAfYtKv6UoKMmY
 bsSGBZr2Wj0NjqxiX3nsvfkui2HePbfViItcGz644qXkBJWYclOWuev5vxbkTNpoA1lN
 sbrL1mYWYzpKL3QS1fpaprFb4a+2LcWPOG2V37kgVdLZAg+eKm9ABXS/ZOQK7Twcy13W
 CiaA==
X-Gm-Message-State: APuU4Z82AE6vdAtPeH0VEBI4gbl1IlCPAybAZL7pgzdGymc7jzmgi6sb
 Usr/8wNnABlxYoNlXkaeAQV3S5aTT6/F+poE0/xDe8ctgWJv5i32sfN5UYNFHxNzAtqe8ueCiyy
 2RZ00NlidDAHZSBMzW1/7dY2GAt3BnaA=
X-Gm-Gg: AYBFou0c3CIvAhtl7WOaz9pXWbbGOOrpdThwGCquRA7zqGuE2UaEdUwWZDjINMxky3e
 K7cVMaiv05/vnUxUGxR7sM/wz5Mr4QZAk62fhhohYt4JUVLTzkNUxSRpD//mVnYYj7OyOcEOgl0
 fByiTvxtgL6FYiZ6+3yaRunDCLngOC5eL72LEn9rggi/NzZgi6O8w8xzShnYQy5L3ACYaKOBuev
 7rn0xGlYtB3qICP81HB+D104Sm6pcsld+cp7yy7Bone/yHWxOF5Q2of45xWPcEm0Tx62Qcy/x9a
 VLzlsTBt6ffAcxlGz/nlaSTJ0w7qmLfDTh9TP8DPa9YudWW5xXRbOABBlie8X/iv34ExNz5KMjE
 Gcpi13/9ncyxZ6l2cknjbqDyzI7xxAu6I2PJ87A==
X-Received: by 2002:a17:90b:4487:b0:3ac:9c37:9422 with SMTP id
 98e67ed59e1d1-3ae89626108mr21996162a91.2.1793785624975; Wed, 04 Nov 2026
 01:47:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103163354.1599176-1-lui2012qwq@gmail.com>
 <sashiko-outbox-196924@kernel.org>
In-Reply-To: <sashiko-outbox-196924@kernel.org>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Wed, 4 Nov 2026 17:46:49 +0800
X-Gm-Features: AclHuK-_vtvq978zMu3PPwfacZUO0gUoRDIo_JkxJh6WSRWCG4KdPqfhdU7hFXQ
Message-ID: <CAE=Q7=6cC_vtSdpbkPaJYE6F1u5sYFQYb1VPMbFPL5RLqshkoQ@mail.gmail.com>
Subject: Re: [PATCH] accel/habanalabs: disable pending-reset work in
 hl_device_fini()
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the review - this scenario is real, and the patch as posted
has exactly that problem.

A reset retry waiting on its timer holds reset_info.in_reset, and only
the work itself clears it (via out_err, because device_fini_pending is
set).  Disabling the work without running it strands in_reset, and
hl_device_fini() would then spin until HL_HARD_RESET_MAX_TIMEOUT and
return without tearing the device down.

v2 keeps the flush_delayed_work(), so a pending retry still runs and
clears in_reset, and adds disable_delayed_work_sync() only after
in_reset has been claimed for fini.  At that point no new reset can be
queued (the in_reset gate) and the reset thread does not re-arm
(because device_fini_pending is set), so nothing can be left pending
or running when the teardown proceeds.

One note on the second scenario in the review - a running callback
that already passed the device_fini_pending check and then returns
-EBUSY, after which the wrapper refuses to re-queue: that race exists
identically with the original flush-based code (the flush waits for
the callback, but nothing clears in_reset on that path either).  It is
pre-existing and unchanged by this fix.

Chengyu

On Wed, Nov 4, 2026 at 5:07=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] accel/habanalabs: disabling reset_work in hl_device_fini() s=
trands in_reset
> --
>
> commit eb768a82770d27a90572b30cd01bc34db4fd01ba
> Author: Chengyu Liu <lui2012qwq@gmail.com>
>
> accel/habanalabs: disable pending-reset work in hl_device_fini()
>
> This commit replaces flush_delayed_work() with disable_delayed_work_sync(=
) in
> hl_device_fini() to prevent device_hard_reset_pending() from re-arming
> hdev->device_reset_work.reset_work during device teardown.
>
> > diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/h=
abanalabs/common/device.c
> > index 09b27bac3a31d..4635dc8572f03 100644
> > --- a/drivers/accel/habanalabs/common/device.c
> > +++ b/drivers/accel/habanalabs/common/device.c
> > @@ -2487,7 +2487,7 @@ void hl_device_fini(struct hl_device *hdev)
> >       dev_info(hdev->dev, "Removing device %s\n", dev_name(&(hdev)->pde=
v->dev));
> >
> >       hdev->device_fini_pending =3D 1;
> > -     flush_delayed_work(&hdev->device_reset_work.reset_work);
> > +     disable_delayed_work_sync(&hdev->device_reset_work.reset_work);
>
> [Severity: Critical]
> Does cancelling and disabling hdev->device_reset_work.reset_work here lea=
ve
> hdev->reset_info.in_reset stuck at 1 and cause hl_device_fini() to time o=
ut
> and skip teardown?
>
> When a hard reset is initiated outside the reset thread, hl_device_reset(=
)
> sets hdev->reset_info.in_reset =3D 1 and hands off clearing it to
> hdev->device_reset_work.reset_work:
>
> drivers/accel/habanalabs/common/device.c:hl_device_reset() {
>         ...
>                 hdev->reset_info.in_compute_reset =3D !hard_reset;
>
>                 hdev->reset_info.in_reset =3D 1;
>
>                 spin_unlock(&hdev->reset_info.lock);
>         ...
>         if ((hard_reset) && (!from_hard_reset_thread)) {
>                 hdev->reset_info.hard_reset_pending =3D true;
>                 ...
>                 queue_delayed_work(hdev->reset_wq, &hdev->device_reset_wo=
rk.reset_work, 0);
>
>                 return 0;
>         }
> }
>
> When device_hard_reset_pending() runs hl_device_reset() and
> device_kill_open_processes() returns -EBUSY while device_fini_pending is =
0,
> hl_device_reset() returns -EBUSY directly without jumping to out_err, kee=
ping
> hdev->reset_info.in_reset set to 1 across the retry delay:
>
> drivers/accel/habanalabs/common/device.c:hl_device_reset() {
>         ...
>                 rc =3D device_kill_open_processes(hdev, 0, false);
>
>                 if (rc =3D=3D -EBUSY) {
>                         if (hdev->device_fini_pending) {
>                                 dev_crit(hdev->dev,
>                                         "%s Failed to kill all open proce=
sses, stopping hard reset\n",
>                                         dev_name(&(hdev)->pdev->dev));
>                                 goto out_err;
>                         }
>
>                         /* signal reset thread to reschedule */
>                         return rc;
>                 }
>         ...
> out_err:
>         ...
>         hdev->reset_info.in_reset =3D 0;
>
>         spin_unlock(&hdev->reset_info.lock);
>
>         return rc;
> }
>
> Previously, setting hdev->device_fini_pending =3D 1 and calling
> flush_delayed_work() forced any pending reset_work to execute immediately
> with device_fini_pending =3D=3D 1, which entered the goto out_err path an=
d
> cleared hdev->reset_info.in_reset =3D 0.
>
> With disable_delayed_work_sync(), if reset_work is waiting on its retry t=
imer
> (or queued on reset_wq before starting), or if a running callback already=
 read
> hdev->device_fini_pending =3D=3D 0 in hl_device_reset() before returning =
-EBUSY,
> or if a concurrent hl_device_reset() sets in_reset =3D 1 and queues reset=
_work
> before hl_device_fini() takes hdev->reset_info.lock, the work item never =
runs
> again to clear hdev->reset_info.in_reset.
>
> Won't hl_device_fini() then spin in while (device_in_reset) for the full
> HL_HARD_RESET_MAX_TIMEOUT (or HL_PLDM_HARD_RESET_MAX_TIMEOUT) and return
> early without cleaning up the device before hl_pci_remove() calls
> destroy_hdev()?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103163354.15=
99176-1-lui2012qwq@gmail.com?part=3D1
