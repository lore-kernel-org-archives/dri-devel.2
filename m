Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7C3FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F007F10E067;
	Wed, 29 Apr 2026 21:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="nDVSbpn8";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DD210E067
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 21:22:48 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-8aca2726f61so4022796d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1777497767; x=1778102567;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HnTRD1psxsr2kJWrBqd7XSPKcVycpkeD0BRqxFjM5IU=;
 b=nDVSbpn8L6D0Ua8a7qit/bJvA4JfmYEHtJj+NruBV0APnpgAbeEiDAvg72VVlk0n1d
 JXG3sZxviZOpziFMl+FZ3UK1zWYt9627VhwayeHR9vKSRiqlYkmCOTD9W7M3uQjhNqBC
 WPxHCNPTrNsHMI3nMZ9t1h2fF8ciD9shHuU+RQho4/U8tXRQg6BtZ2CkfS2/lVL42lO6
 HfpQA+xsdT0H0m8lx4JSLkdE5Ojo4ZPjh8/w0ae3kYr4v53nRbXwymtXcygED7P/Ycx5
 +CnEt3QOH4UnS2PtTI36TVU2fPSteFMFxKzMBeXgnl5SCTNbVUTpPsH9rshrybjK3hAf
 dNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777497767; x=1778102567;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnTRD1psxsr2kJWrBqd7XSPKcVycpkeD0BRqxFjM5IU=;
 b=gyPnLVNACRLF56Jpr8midIWlDIDU0wJniguOyqcdopjXGzPWpbsXv9FL1weqhPBnWt
 wqOB8srYl53ZsmNCo6HlIqnbXiQBgNyyQbWCu3l5K9q8F3OrS5QtNgUxgcWMTCjQ5aj+
 uJWkIYCrOLkDnixTItRL7Y+OdpAGbQXJqcBfDKDtCRoG3MlYo/tn1YJli7LeEbIGt4Wr
 xeSz813Oo7klOnQHfRta1Gvysttxg8NzJ26xrtqBRp7Wik9njkoEQ7G9gRwTnnfb/a3F
 gxmS3i2rRjr8FVXL8iTxtKwQUC4FCkIRjWFehtc4YUI18VPh01nVRUDhUZ0UXmtmDY5p
 3lag==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QKqG/iPDipWCqNLxgwpgHqokvtmIXz3OMVHMivnFH3KGu5do/IpyBQWskFCuNcwj9JkreMaaAgeQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCWJ1s2ILM+M89fnx1EzuXVoF5A7ZqLtp737ODpU1YQ1ot5kUJ
 jcdXJ5yuT7SCcyEc60Hs49Ro8QFMckcqwP3WzuS2SXUlbf17OZ7FiwuXktspOT5udf8=
X-Gm-Gg: AeBDiev2n/Jkq+XyIsExw/E9oxIuSHeinAn2UkTjDH7dxZGvTWq9UdYbmB+5+6R37hC
 JF62F5C7cw2KgRFLNA+d+g0rmgKLKs1L3PkS+i0gah0pn7i9Xj6nrcyM46ZAsuHgtgii5su7tGz
 D8jAkK0dXUklRg1xexNnrFeS6mIyHdzGRO/Y5mY8/LC8yibzDPOUx1CFrpsLTzOH+Z+Arm4uojX
 UPVyxxUFjG+AQYB4jJqLwkzwUoPiaJ9KhuAYBELjnq2stMbQbIVvuRJ9OiPa1envK49PZXLndqs
 XA5IqdyMl/6ZHSh+L+NvkgVP+FluAr3dE0dXg64qoYUJxAKoXSqgcDQ8ppOfASkZJmJYhyffszv
 4TYCu+++t2kiZtXNq347nJPUQRxpbWnL8HQvK4Clk7yFv3731hpSeWeX4UIK3ijKTHgJRVsh+Ph
 +X/vD9px0olwhngtvnaQSl7eBQxaGrHXzrrf0tWG0=
X-Received: by 2002:a05:6214:260c:b0:8ac:c651:bae5 with SMTP id
 6a1803df08f44-8b3fe7baaa2mr2420116d6.20.1777497767040; 
 Wed, 29 Apr 2026 14:22:47 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::c41? ([2606:6d00:15:e06b::c41])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3fe7c6b6esm689316d6.49.2026.04.29.14.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:22:46 -0700 (PDT)
Message-ID: <3d8deeb15581b754e4c061d4c4a13657aa08bc3c.camel@ndufresne.ca>
Subject: Re: [PATCH RFC 0/3] media: videobuf2: opt-in dma_resv producer
 fences for V4L2 dmabuf exports
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Markus Fritsche <mfritsche@reauktion.de>, Tomasz Figa
 <tfiga@chromium.org>,  Marek Szyprowski <m.szyprowski@samsung.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>,  Philipp Zabel <p.zabel@pengutronix.de>,
 Jacob Chen <jacob-chen@iotwrt.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 29 Apr 2026 17:22:44 -0400
In-Reply-To: <20260429195306.239666-1-mfritsche@reauktion.de>
References: <20260429195306.239666-1-mfritsche@reauktion.de>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-PaCe1+dCgtCU4jZHEK+H"
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
MIME-Version: 1.0
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


--=-PaCe1+dCgtCU4jZHEK+H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

Le mercredi 29 avril 2026 =C3=A0 19:53 +0000, Markus Fritsche a =C3=A9crit=
=C2=A0:
> Hi,
>=20
> This series proposes a small opt-in API in videobuf2-core that lets V4L2
> drivers populate a dma_resv exclusive write fence on the dmabufs they
> export to userspace, signalled when the buffer transitions to
> VB2_BUF_STATE_DONE. Two example drivers (hantro, rockchip-rga) opt in
> to demonstrate the call shape; the change is no-op for every other
> driver.

Thanks for attempting again this feat. I see you went for implicit fencing,=
 but
in the past we've been recommend to stay away from these and adopt an expli=
cit
fencing model. Is this something you have started to think about, have you
reviewed past proposal in regard to fences ?

>=20
> Why
> ---
> Modern Wayland compositors and any other userspace consumers that
> import V4L2-produced dmabufs and want to do implicit synchronization
> the spec-clean way (poll(POLLIN) on the dmabuf fd, or
> DMA_BUF_IOCTL_EXPORT_SYNC_FILE for a sync_file) currently get either:
>=20
> 1. A stub fence from dma_buf_export_sync_file(), because the dmabuf's
> =C2=A0=C2=A0 dma_resv has no fences populated. The kernel substitutes
> =C2=A0=C2=A0 dma_fence_get_stub() which is permanently signalled. The com=
positor
> =C2=A0=C2=A0 "successfully" waits on a fence that represents nothing real=
 about
> =C2=A0=C2=A0 the producer's state.
> 2. A poll(POLLIN) on the dmabuf fd that returns immediately for the
> =C2=A0=C2=A0 same reason =E2=80=94 dma_buf_poll_add_cb finds zero fences =
in the resv,
> =C2=A0=C2=A0 triggers the wake callback inline, and reports POLLIN ready =
before
> =C2=A0=C2=A0 the producer has actually said anything.
>=20
> Today this works as a happy accident on most paths because clients
> attach buffers after VIDIOC_DQBUF, which the userspace V4L2 contract
> guarantees only returns a buffer after the producer is done. So the
> implicit "the kernel's stub fence is fine because the buffer is
> already complete by the time anyone polls it" assumption has held.

There is no accident, just saying. Have you studied also the other side of
fences, the one that actually cause problem with Freedreno and Etnaviv ? To=
 me
these would be higher priority since they are known to cause "back flash" k=
ind
of bugs, specially for compositor that are not expecting GL driver to place
implicit fences on imported (v4l2 allocated) buffers.

>=20
> But:
>=20
> - It's a contract gap. The kernel claims to expose implicit sync; it
> =C2=A0 does not, for V4L2 producers.
> - It paid latency for nothing. Every Wayland frame from a V4L2
> =C2=A0 producer pays a DMA_BUF_IOCTL_EXPORT_SYNC_FILE round-trip for a
> =C2=A0 fence that's stub-signalled. On Mali-class hardware (RK3566 Waylan=
d
> =C2=A0 chrome video playback), this contributed to compositor stalls.
> =C2=A0 Removing the wait at the compositor level is a workaround, not a
> =C2=A0 fix.
> - It blocks downstream consumers from doing the right thing. A
> =C2=A0 Wayland compositor that defensively waits on a sync_file gets a
> =C2=A0 stub-fence pass-through with no actual gating; if the V4L2 driver
> =C2=A0 ever has an out-of-band path that releases the buffer before
> =C2=A0 finishing the write, there is no fence to gate on.

Some things don't add up here. I think I want to remind that there is a con=
tract
in regard to delivering a fence to userspace. One of the most important asp=
ect
of fences is that they must in finit time be signaled, regardless what user=
space
decided to do next. And for that reason, you shouldn't deliver a fence to
userspace if its not armed. In my reading, you are delivering that fence at
QBUF(capture) time, just like what Gustavo was trying to do previously. Its=
 even
worse if you deliver it to your compositor allowing that compositor to hang
forever by not feeding any bitstream.

Let's take Hantro driver as an example. The right moment to deliver the fen=
ce is
either right before we set the DEC bit on the control register, or somewher=
e
before that when you have bitstream, parameters and request queued. At that
moment, you are guarantied that the decode will either finish or fail (yes,=
 it
can fail, and its extremely common with live stream, or when application ca=
lls
streamoff, since in v4l2, we cancel work). Prior to that, user may starve t=
he
OUTPUT queue (the bitstream) and cause the fence to hold forever. This woul=
d
break the contract I mention earlier.

Though, if you attach the fence at that moment, you will need to design how=
 to
signal the fence readiness (rather then the data readiness). One idea would=
 be
(with userspace opting-in) to signal the queue at that moment. But then you
can't do the memory management operation you would normally do in DQBUF. Th=
is of
course don't apply to hantro, which has no device cache, but we can't desig=
n
something in vb2 for the old HW. So we'd need to move memory management som=
where
else, maybe buffer_done, though you have to carefully make sure in which co=
ntext
you do that, you can't sleep in an IRQ.

There is an obvious benefit of basing your solution on
DMA_BUF_IOCTL_EXPORT_SYNC_FILE, once you get there, you'll discover that th=
ere
is very little room in v4l2_buffer, and that was causing a lot of headache =
to
previous people attempting this. Though, if we look forward, we could also
consider this a feature of the media_request. Queuing a request could maybe
deliver a fence, assuming few pre-condition that guarantee execution (or
failure) are met. We've seen with DW100 recently that its rather easy to co=
nvert
an existing m2m driver to request. The media API is a much more open canvas=
 to
design new mechanism. We could have a really simple ioctl that attach out f=
ences
to request, and in a future hook it to our own depedency manager.

I'm simply throwing ideas, I could have missed few things in your PoC, let =
me
know.

Nicolas

> What
> ----
> Patch 1 adds:
>=20
> - struct dma_fence *release_fence to struct vb2_buffer
> - u64 dma_resv_fence_context + atomic64_t dma_resv_fence_seqno +
> =C2=A0 spinlock_t dma_resv_fence_lock to struct vb2_queue
> - vb2_buffer_attach_release_fence(vb) =E2=80=94 drivers call this from th=
eir
> =C2=A0 buf_queue callback. Allocates a dma_fence on the queue's fence
> =C2=A0 context, attaches it as DMA_RESV_USAGE_WRITE on each plane's
> =C2=A0 dmabuf->resv. No-op for buffers without exported dmabufs.
> - vb2_buffer_done() extended to signal+put the fence if attached,
> =C2=A0 so the producer's completion signal lands in the resv synchronousl=
y
> =C2=A0 with the userspace DQBUF wakeup.
>=20
> Patches 2 and 3 add a single call to the helper from hantro_buf_queue
> and rga_buf_queue respectively. Both are demonstration drivers; other
> vb2 drivers can opt in incrementally with the same one-line change.
>=20
> Tested on
> ---------
> PineTab2 (RK3566 / Mali-G52 panfrost / mainline 6.19.10, this series
> backported), playing 1080p30 H.264 in chromium under KDE Plasma 6.6.4
> Wayland. The test harness is the chromium-fourier patch series at
> https://github.com/marfrit/fourier=C2=A0=E2=80=94 chromium plus a KWin pa=
tch
> that *previously bypassed* Transaction::watchDmaBuf because the
> kernel-side fence was stub-signalled. With this series applied, the
> bypass becomes unnecessary; KWin's fence wait completes correctly
> because the fence now signals when hantro completes the capture
> buffer write.
>=20
> End-to-end result before the kernel patch (chromium + Qt 6 patches +
> KWin watchDmaBuf bypass): 1080p30 H.264 plays through, ~81% combined
> chrome CPU, but the watchDmaBuf bypass weakens KWin's defenses against
> misbehaving clients.
>=20
> End-to-end result after the kernel patch (chromium + Qt 6 patches +
> plain unmodified KWin): 1080p30 H.264 plays through with the same CPU
> profile, KWin's watchDmaBuf wait completes within microseconds against
> the now-real producer fence, no defenses weakened.
>=20
> What's missing in this RFC
> --------------------------
> - Other vb2-using drivers don't opt in. Each maintainer should look
> =C2=A0 at their driver and decide. The hantro + rga patches show the
> =C2=A0 shape; copying it to other drivers should be straightforward.
> - For drivers that have intermediate image-processor stages (e.g.
> =C2=A0 CSI -> ISP -> user), the fence semantics across stage boundaries
> =C2=A0 are out of scope here. This series only addresses the producer-to-
> =C2=A0 userspace edge.
> - No selftest. videobuf2 doesn't have a great in-tree selftest harness
> =C2=A0 for dmabuf flows; the validation is end-to-end at the userspace
> =C2=A0 consumer level (KWin, in our case).
>=20
> Reviews especially welcome on:
>=20
> - The decision to make this opt-in per driver vs. automatic for all
> =C2=A0 vb2-CAPTURE queues. Auto-on would force every driver to be audited=
;
> =C2=A0 opt-in is incremental and safer but leaves the contract gap for
> =C2=A0 drivers nobody touches.
> - Whether vb2_buffer_done is the right place to signal vs. an earlier
> =C2=A0 hook (e.g. immediately after DMA-from-device finishes). For hantro
> =C2=A0 the two are effectively the same; for drivers with asynchronous
> =C2=A0 post-processing they may differ.
> - The choice of DMA_RESV_USAGE_WRITE =E2=80=94 we are emitting the produc=
er's
> =C2=A0 write completion, so WRITE matches dma-buf documentation, but a
> =C2=A0 sanity check is welcome.
>=20
> Cheers,
> Markus
>=20
>=20
> Markus Fritsche (3):
> =C2=A0 media: videobuf2: add dma_resv release-fence helper
> =C2=A0 media: hantro: attach dma_resv release fence at buf_queue
> =C2=A0 media: rockchip-rga: attach dma_resv release fence at buf_queue
>=20
> =C2=A0.../media/common/videobuf2/videobuf2-core.c=C2=A0=C2=A0 | 95 ++++++=
+++++++++++++
> =C2=A0drivers/media/platform/rockchip/rga/rga-buf.c | 10 ++
> =C2=A0.../media/platform/verisilicon/hantro_v4l2.c=C2=A0 | 12 +++
> =C2=A0include/media/videobuf2-core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 29 ++++++
> =C2=A04 files changed, 146 insertions(+)

--=-PaCe1+dCgtCU4jZHEK+H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCafJ2pAAKCRDZQZRRKWBy
9IKpAQDOGlHwRMUodCUPGlw1vHZKfzDyvZiT6/qTdFt/7kAmowD/XdGnmCEaVRLi
esHiriLWnm/LS++ywFz1KHLPb4N4KgM=
=VRYe
-----END PGP SIGNATURE-----

--=-PaCe1+dCgtCU4jZHEK+H--
