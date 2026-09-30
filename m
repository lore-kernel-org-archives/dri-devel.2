Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2354CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA16A10E22A;
	Wed, 30 Sep 2026 06:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="lxNB2zGK";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="Pgv2S4p/";
	dkim-atps=neutral
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF1D10E22A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:32:26 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-bpvf.prod.antispam.mailspamprotection.com;
 s=arckey; t=1790749946; 
 b=Gu7QTo2Z8n8uQcSLbfES/R33uS4GbVCslD6FZIgc3DiUZau/z3KIGLqekmyLsQEkPzPnOu65KC
 Whsi2fU49mFD2Jy7hrz7d+ISzZ6AdCdEn5O7W0PJ0y+miucppXnrfgwm65n4FaDV8OaBGqp7fk
 nf9ZgZxaNCh1e6pGDLrmUJO0v4ZvDE7RZFq7u+LXBSexB/sykF8FEWKvJXbchHbXkRH+FeQAmY
 OjqqO4oMRsp7kzrGzxFdhKExjPhAB/0RORFO7JNuzh0eRVdwC9A/Gzph8Q3lDyTUh0VWwIrpmX
 kLDnFLcWp+r0h/N7MrzZBpI0gj/a41zmtEsvYDKLXiMGAA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-bpvf.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-bpvf.prod.antispam.mailspamprotection.com;
 s=arckey; t=1790749946; 
 bh=fraJiAsIooHaKwkP4MQRGKPRqp8rVGzl961dSNpIISc=;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
 b=cubmLKiJ6nDDq41wY9XOhlg4LEWJuUuPdsxPaVBIo84OXSPaVcHrNbcpuBpCmNvl0cjkkPQT66
 y7HGRohwijYJ6A/R2ldfqIAJcuTNqnOU/Rqbrlnbu1Li5Z1rkFQ2UmV8s+HXUr47WwvQhvB8yv
 9eS3aIPB7INauMpgII+lYCQT+2TuGV7wdjZuscRiwcnl8i0sTzRRukP1AQIe87S3Zd/Y0dmHm9
 KcOKUKqt1t3/io9k3C7hVLiwFcTnW5kXYn+1f8iRs6xMW0eRZjE5WtGITOoBr35U9Ibl6NE+vt
 ipjDnBw0ygWtAu/uQl+9rWbZ3fgyPDtvTMbG8hwn0iTdJw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
 :From:Date:Reply-To:List-Unsubscribe;
 bh=vfBHxdNa1POFeFP8vaAw0Rs93HzFAT2Fl4oprPlHcmU=; b=lxNB2zGKrq3m5475J5VVKw/zqy
 U5vwXKtey71z/VlM94SKz2umZJOGceHKpv+6oEwrA5i6kjToK8dP2C0WSWgU7Yj9u3qu+IKqmrNZ9
 VpAZ6f6uQSxYIgdrPmy97juIdHmLv44HZIUw5KIgVwrlipaNGzKrikFxhCYJfmIGc6Co=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-bpvf.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xBnrb-000000011mW-36xc
 for dri-devel@lists.freedesktop.org; Wed, 30 Sep 2026 06:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=vfBHxdNa1POFeFP8vaAw0Rs93HzFAT2Fl4oprPlHcmU=; b=Pgv2S4p/yJ6Z9oAD8eGWvUm+vf
 ZdkiWqv78PPj6IHYCFLP8ZPHdUyP2P2I1IXxDBasT2hdQoxVelScvSKS4NkwfwzGxMTMSbS52WKtR
 lpco7utODND+XeZXKvlSdU1tvANzL8K7ty/sg2n2TuP+MCq7BZr3r+YLKMyRf5qfWaJY=;
Received: from [87.14.44.235] (port=64939 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xBnrT-000000007V4-2h2L; Wed, 30 Sep 2026 06:32:15 +0000
Date: Wed, 30 Sep 2026 08:32:13 +0200
From: Francesco Valla <francesco@valla.it>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Boot logo supplied by the device tree
Message-ID: <aryqYhHqFk3cXh9d@bywater>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
 <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
 <arbLHvCBqxG7zcf_@bywater>
 <CAEUXW=ELS1OCyDdy5Gx41g8twU5B8112gMct9uFqhdGVveRKMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUXW=ELS1OCyDdy5Gx41g8twU5B8112gMct9uFqhdGVveRKMw@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: aec91b2def9084de9b8b91b653803708
X-AntiAbuse: ID - aec91b2def9084de9b8b91b653803708
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBnrb-000000011mW-36xc-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-bpvf.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hi Màxim,

On Tue, Sep 29, 2026 at 01:46:36PM +0200, Màxim Pedraza Padilla wrote:
> Hi Francesco,
> 
> > v4 is planned but has been preempted by other activities - I am not able
> > to give you an ETA at the moment. If you have capacity, feel free to
> > take over.
> 
> Thanks, I appreciate it. Since it is your series, I would like to run
> past you what I would change before taking it on.
> 
> The v4 would still be an RFC, based on drm-misc-next. Your patches keep
> your authorship, with any fix to them folded in and noted in the commit
> message.
> 
> Fixes to what is in v3:
> 
>   - the BGRT symbols exported, as in your patch for Mario, but with
>     EXPORT_SYMBOL_GPL;
>   - drm_splash_init_client() indexes modeset_mask by the number of
>     modesets added in the first loop and by the number walked in the
>     second, so an output without a mode ahead of a connected one gets
>     the buffer instead;
>   - for a tiled group, the first loop dereferences tiled->buffer before
>     any buffer exists, and the width and height look swapped;
>   - if the BMP firmware never arrives, the callback returns without
>     waking the render thread, which is left in TASK_UNINTERRUPTIBLE for
>     good;
>   - the 24 bit blitters read each pixel as an unaligned u32, one byte
>     past the image when the rows have no padding;
>   - the image cleanup always calls memunmap(), which will need to know
>     where the image came from once there is a third source;
>   - the spaces in DRM_CLIENT_DEFAULT, in a patch of its own.
>

I suggest you also take at look at the review sashiko did for the V3
[1], as it contains some good suggestions (some of them are already
present in your list).

> The modeset, tiling and render thread ones come from reading the code,
> so I will reproduce them in qemu first. Tiling I cannot test at all.
>

I did not test tiling as well - I think it's a mode limited to some
Intel cards?

> Additions:
> 
>   - a device tree image source: a node under /chosen with the BMP either
>     in the node itself (dtc's /incbin/) or in a reserved memory region,
>     mapped with the same memremap() as the BGRT;

A reserved memory region is (probably) a better idea, to allow change
the splash without recompiling the devicetree.

A possible usecase would be:

 - bootloader reads the BMP image from a dedicated partition and loads
   it to the reserved memory (very much like the BGRT path);
 - splash client parses the devicetree, finds the memory region and
   loads the image from there;
 - userspace updates the dedicated partition with a different image.

>   - placement from that node, a position with -1 centring an axis plus
>     an offset, instead of always centring;
>   - rotation, for the DT image and for BGRT images with the orientation
>     bits set, which are skipped today;
>   - the background colour coming from the same place as the image: the
>     DT node can carry its own, splash_color goes with splash_bmp, and
>     the Kconfig colour stays the default for everything else, BGRT
>     included.
> 
> The sources would be tried in the order DT, BGRT, BMP firmware, and
> then just the colour. A DT node is only there if someone put it there
> for that board, so it seemed right to let it win.
> 
> Does that match what you had in mind? And how would you like to appear
> in MAINTAINERS, as a maintainer next to me or as a reviewer?
> 

Yes, please, either as a co-maintainer or as a reviewer, as you see fit.

> If you are happy with it, I'll take you up on your offer.
>

Thank you for continuing the effort on this - I still believe it's
useful, but currently is not fitting inside my schedule.

> Màxim
> 

Regards,
Francesco


[1] https://sashiko.dev/#/patchset/20260510-drm_client_splash-v3-0-a9aee9f0b2fc%40valla.it

> El vie, 25 sept 2026 a las 21:32, Francesco Valla
> (<francesco@valla.it>) escribió:
> >
> > Hi Màxim,
> >
> > On Fri, Sep 25, 2026 at 10:48:31AM +0200, Màxim Pedraza Padilla wrote:
> > > Hi Thomas,
> > >
> > > > the whole Linux logo on the console is somewhat gimmicky and IMHO should
> > > > not be further extended. Also fbdev as a whole has realistically run its
> > > > course. We fix bugs and occasionally clean up the code, but it is
> > > > questionable whether new feature make much sense. Even more so as the
> > > > drivers your system uses appear to be DRM ones.
> > >
> > > They are, it is tilcdc. Understood, I will drop the fbdev side, which
> > > also settles your comment on patch 1.
> > >
> > > > There is a proposal for a DRM splash screen at [1]. It retrieves the
> > > > device vendor's logo from the firmware and displays it at the given
> > > > coordinates. IMHO you should start with this series and add DT support
> > > > there.
> > >
> > > Agreed. I have been following Francesco's series since Sam pointed me
> > > at it, and it is where the DRM follow-up I mentioned in the cover letter
> > > belongs, rather than in a client of my own.
> > >
> > > A device tree source fits next to the BGRT one. The BGRT is the firmware
> > > handing the kernel an image and where to put it, and a DT system has no
> > > such table. The BMP loaded as firmware only helps if the file is built
> > > into the kernel, or if a filesystem is already there when the display
> > > comes up. With U-Boot's Falcon mode, the device tree is the only thing
> > > that reaches the kernel.
> > >
> > > So the plan would be a node under /chosen carrying a BMP, either in the
> > > node itself or in a reserved memory region the bootloader loaded it
> > > into, with the placement properties from this series. The region is the
> > > same memremap() the BGRT source already does, only with the address
> > > coming from the device tree.
> > >
> > > Rotation too: the client skips a BGRT image with the orientation bits
> > > set today, and it could turn it instead. I will ask Rob separately how
> > > he wants the image described, since that is what the binding hinges on.
> > >
> > > Francesco, is a v4 on the way? Would you take a DT source as patches on
> > > top of your series, or would you rather I wait until it lands?
> > >
> >
> > v4 is planned but has been preempted by other activities - I am not able
> > to give you an ETA at the moment. If you have capacity, feel free to
> > take over.
> >
> > > Max
> > >
> >
> > Regards,
> > Francesco
> >
