Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF921C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6E510F1C8;
	Thu, 20 Aug 2026 22:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=me.com header.i=@me.com header.b="TUdzRSyM";
	dkim-atps=neutral
X-Greylist: delayed 600 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 20:09:20 UTC
Received: from outbound.mr.icloud.com (mr-2004j-snip4-7.eps.apple.com
 [57.103.69.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1A710E3B5
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 20:09:20 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPS id
 837FB180014A; Thu, 20 Aug 2026 19:54:01 +0000 (UTC)
X-ICL-RepId: 01a020bc-d55f-72fa-8d52-624b1c13cf71
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwZfEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAAS1oVVRcOAkIfUB9MFldDWhkcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQglJClgEXgdeC08GWAZTH0EUHlYfRQpcXl0NUh9FAnIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1787255643; x=1789847643; bh=s4xjx+A70ZAgbYTT/9Wh8ZqkJbeVku/EHADg7mJhaI4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TUdzRSyM79JcDrb+QqXG4rMg3KU8Xt8jx6WLpwA3N56ol6HYpoPI27USXFEh3cS4h4TGaEOYYk8lDPVy9FMdB21xM4J+jkL8gMrAw9VCKxiDp/rZEIXdeKvFSRNqv94LtQUY/atuJUghh6Pgcpmgl8lEPypqErQrEz1hPrWVcb894E3+o4Ltx9JaI3ewrZMIMXZ0rCVCGEZamSKW39fXyS8i81qAhvX6jZc2X5KlsluZBKjP+nXzU7FRN+B3Wg3/+PdqjxQDe2u6DZfZHNTKpQb9ASAX0zUji2eKIT5YT01U/VZGgV3uvF2XMb/0ntQx0ut2qVhL3KU1iOHMnnNjSA==
Received: from ncore (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPSA id
 41E691800153; Thu, 20 Aug 2026 19:53:59 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Ferran Duarri <ferran.duarri@me.com>
Subject: Re: [RFC PATCH] dma-buf: add a generic reclaim-priority hint
Date: Thu, 20 Aug 2026 21:53:49 +0200
Message-ID: <20260820195355.275518-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820190838.221435-1-ferran.duarri@me.com>
References: <20260820190838.221435-1-ferran.duarri@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0OSBTYWx0ZWRfX9Fytfga6a2xE
 5byOKqmdnCBFXAtHZEwtzL+NsFkiPMBOK1s2eaHmuFnR/30o7Nx7+D/HDAKPnQJafZrSjjr66PS
 e6HcUt1WE3y2p1uRxIIVEaKBsvwLn15PV7tiqDmfMxzOPJzM1Djtp6srYYWwy6ry1HlcUAkanTR
 yv7fH2igeJermJiGdOLnTEyTy5/S9MLRUdsaDqt5xxpggIEHOmwpDG224URBUhsRgqmioAbgxDD
 1Sh07aDnyMOq4L9SN/mySzK+bgW5OzLBZG9Z7yKDzEK7l8QkOncbss/B0YB8xH494IrVyrFZg6n
 /byskiocRtgHTLPz7qB4UKwttYG8R6nBMqNl3Z8ks12Ep23LYKLhEH6xDumIWY=
X-Authority-Info-Out: v=2.4 cv=KsZAGGWN c=1 sm=1 tr=0 ts=6a875b5a
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=lr9Tj9Q4Saz2wyJ3neMA:9
X-Proofpoint-ORIG-GUID: OxMEavY5Ztf53e8VtRZ7bFhmOm6Ck8b3
X-Proofpoint-GUID: OxMEavY5Ztf53e8VtRZ7bFhmOm6Ck8b3
X-JNJ: AAAAAAABNSxfYXv8hLDMYsWP+XCeA4yR6c1AahZWsnME1zi60SsWMtIB0XroiS+IrBzUY4muWiLKNje/+CXbcE3eQi7EDdgkZIFey0TBtjoH7mYWdHi4my+WGw9iyaAjdKCUzrFjFaiF3nFEwLxv2uP2RhA1GHpmKXzM5nk3L3WQkfk777l0ymNsn2qewYVyTG3XzxqC8KATtcSvF796TiOMI2McoJu4Tcqu+umXSzfMAA3/f3ZSAry5wakEGkRwiXDS1qnocfUMjJsseAN2rjQVtkjcMAKCkTNGVUFwq29Y2cIJNI6itYebAsSROg2rCjwnqYY1HD5JiIOsawfxg4EYj+UbTTRRL+/L4QdlAGChH9m7fzI4ZucVtHR4gOloJ7fCcGLbchE2ErHHIkZKm9zImNvlJj0dWpauOyhhT5JrnqbPPDrcgPmteNkYecH4KnM6KjUVrRN4OA0oXvsjZ1QNhPVQs+jtyAxQfMgB0nup17oXjKdrRfA91XmjVPm+CFYv0ttKMPY+V3/Cppz2ijq18Lnj1msU6FbyLEvOr64wc8wtKHbeN9CB83kuVfrp+C/PVLAOpQnPbl2ry4gS11KrQCRWGldY3RRBbg8P+lcy3YxbOmeLvkAQx10uphCYjHBPf54XfuJGSaJSNOivoRMeUy7/q+96N8OfUAgf4rPi9lg5+WC/e/R0K8pYZ6DVyDQz4tJR1CV5oF3gk6zwbuFMuTAoksENoEwKBP3MsrW5v8goZfxsQw1E/OHJqQd/KmXL15eZghY9+SdDPETTKlTWQ48bsqSMaq13rrSkKUk6QJw+AS0yIIteNjMUxHdK1vPtRZ2iT5JMvqM9v7czMXNeE3kEVY25gPmKZCJTwx0+ubscXkO2B9pjVKRmdNn2NhPNjXyQoEGjAA3WCpmnlcVlGyvjIWiaWcfVs5ICw5AyR1ffoOt9c50oc16ttAY+pwQ5m7LniH6Oz9UUFSNV31Ht6WbSrW3
 BaYdy4UvaVFMnBWbxioscZ5ojEjPeCGNMlwLw7VAnNgRvTNSD/LMWENFu3RcQWlmt8hFWbgfLESAAkieafKUoP1BXWj0qXnKvjgtJjBwkMB4XJ3D1mRTtcOXiv+YQhpXCoF84Su6+DLCSfLlvzmsxj3920gOgpVITiK1a58CsEGXK2lxmnHiU0g8dbuiBQKaJmd7vdaLAjr7ulJ+m8r+cDFf+/zWKXznPSsW6r3HrZRYYItQ5soCpTY5j8s7U1VYdHx2Dd8qmRHFFCT9WqB2sFDqJxUHUo8Gb8E0vUUOG
X-Mailman-Approved-At: Thu, 20 Aug 2026 22:53:16 +0000
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

Following up on my own patch to put its weak parts up front rather than
have them found in review.

The only consumer is out-of-tree, and it is mine. The commit message says
"an out-of-tree memory tiering driver we've been using", which undersells
the conflict of interest: the driver is greenboost.ko, I wrote it, and it
is the only thing anywhere that reads dma_buf_get_priority(). Nothing
in-tree constrains these semantics. Adding UAPI -- two ioctls, an fdinfo
field, and a DMA_BUF_PRIORITY_* range -- with no in-tree user is normally
declined, and I think that is the right default.

One claim in the commit message is not supported and I withdraw it. "GPU
drivers juggling foreground and background clients want it" -- I have no
thread or maintainer statement to cite for that and should not have
asserted it. What I can support is narrower: a driver that pins pages via
FOLL_LONGTERM has nowhere generic to express relative reclaim preference,
so it invents a private side channel. Mine did exactly that, a private
ioctl plus a gaming_mode sysfs flag, before this patch existed.

How the hint is actually consumed, so the semantics are judgeable rather
than hypothetical: greenboost.ko tiers a model's working set across VRAM,
system RAM and NVMe. Its T2 eviction sweep reads dma_buf_get_priority()
as a skip-on-threshold check that re-orders which already-eligible
buffers are reclaimed first. It never makes a buffer eligible that was
not already, and it never overrides the invariant that KV-cache buffers
are not evicted. The hint changes ordering within a set, not membership
of it.

A review bot on this thread has already found one thing that needs fixing,
and it is right. DMA_BUF_IOCTL_GET_PRIORITY is _IOR and never copies the
struct in from userspace, so the pad field that the UAPI documents as
"must be zero, reserved for future use" is enforced on SET and not on GET.
That makes the promise empty: nothing stops existing userspace leaving pad
uninitialised, and a later kernel wanting to use it as an input flag would
have to break them. v2 will make GET _IOWR, copy the struct in, and reject
a non-zero pad exactly as SET does. This is worth settling now rather than
later, because changing the direction bits changes the ioctl number, and
that is only free while there are no users.

I would rather hear the shape question below answered before posting that
v2, so the two rounds do not collide.

What I am asking for is a read on the shape, not a merge. If the answer
is "come back with an in-tree user", that is a useful answer and I will
take it. If the shape itself is wrong -- priority belongs on the
attachment rather than the dma_buf, the range should be smaller, a hint
with no in-core policy is the wrong abstraction -- that is more useful
still, because it is cheaper to hear now than after something is built on
it.

Thanks,
Ferran
