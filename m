Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1EF109C057
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F1310E832;
	Wed, 25 Mar 2026 19:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="K+O08cmv";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hz9iGqLh";
	dkim-atps=neutral
X-Greylist: delayed 379 seconds by postgrey-1.36 at gabe;
 Wed, 25 Mar 2026 19:31:43 UTC
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C25E10E7D3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 19:31:43 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 375797A01CB;
 Wed, 25 Mar 2026 15:25:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 15:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1774466723;
 x=1774553123; bh=tAix8vqZs7Q/5efnYr8ZEGQJO365af1otqRsnEOdznI=; b=
 K+O08cmvqBzd7tFwDlQms6WegnzbT25PsRWceNv3N1P4jJ2FGgKq+cZ6kkqnleQU
 Gv0RX1/hDLYQssNMZf4q17yI1wD5P3HyU95M8fcI0OG2y1MAXNHkHR3GJ1Ip98s+
 RexnKuQ57Kgi2fjRsBOgGrWTlJW8aHuzMxStroWnmTQPewAF8YhjuB0nDGAQC0M5
 KqRuHL1HuGCT6H/KkLsStE3UswVKGEte+bPDYhc5crq4jYRLnUcwQR1/3dwfq2RS
 PH41mKG3QVcHMzv1t4GIrp8/Nj85XdpjsmBgoKFw6d1EZ45K3DkgtxVT8ckQrTaz
 k0uSuIH0GypEeITxgkXWkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774466723; x=
 1774553123; bh=tAix8vqZs7Q/5efnYr8ZEGQJO365af1otqRsnEOdznI=; b=H
 z9iGqLhftN92wq5Rd/1a/2RAze1/gu1/CIWNignOoEq0zepSSp8UtlgtrpT8vMtk
 29r54TPBp0qhROocrYR5pWZiI9kSxSqtCVt5ZvRLiFdaU68kr4CvcKR9P1vcxd3C
 hjTuX6BuRtJyNPjmfUCtWbCXYWDCsnZLZ5nrCfw/jOeu9DOEcN2NlWREXUchFvNw
 gyVOxn5mZIxGywmrAXsJbev7S15CRsHgcOCt3I0uUBTG0THjhc12Y5XAmmY/KRC/
 Pe2w5NTJafbGaBTsUhRHEmGYKag2FlTO+cPgAFC4waheRdn8p+j0uAZ1WPmBZrf0
 UE9gMnlX3wOCdKWBzkypQ==
X-ME-Sender: <xms:ojbEaQLb8XcCsG9XyShjQVkkCuYxHTAP_zUkDdtftuzGdFjjKfcWMQ>
 <xme:ojbEaT_gSkaf_7vQ_EIlP5-ykTHmps9UfSpE7VCxRITPJlsd4sAbQiCmXSbh9WWYD
 2Ix9pur7-vys1bC-dwAmN-Tz0wWVgE0FOcPCzBhumlG56CXEi2vnF0u>
X-ME-Received: <xmr:ojbEaZx0u-Hw1k7lJn_cQ5WknGQqUt5bbgRwfMqylafjO40VRQQ-u3S_5Uj4YjnZFvcSFZY7vPjD2BzbpwBjufUU-saW_fNdQUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehvdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeflrghnnhgv
 ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
 efkeeuudettddvffevhfevvdekhffgveehfefhffehfeetgfetffeugfevfefhnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
 hurdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
 thhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprggurhhirghnrd
 hlrghruhhmsggvsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheplhhinhhugidq
 khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdqug
 gvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehs
 thgvvhgvnhdrphhrihgtvgesrghrmhdrtghomhdprhgtphhtthhopegsohhrihhsrdgsrh
 gviihilhhlohhnsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepkhgvrhhnvghl
 segtohhllhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:ojbEaQ4qP8PBm89z4ivTnzfdgOLqlVPXIZhuxaY4JDvlMvpe2UQkag>
 <xmx:ojbEaQ93_ljPSsJ3pI0qv1wy_MPQzFM3cqiqYgWyhX_QHbSQdap1LQ>
 <xmx:ojbEaVrpsNowhI5bLul8FSlp5kd8ouhTGVjNppuuXgYcv04Eg63bXw>
 <xmx:ojbEaRpV264Q6RlhscQbPr395kbj6-yYvsyJisxEM3xtiCT0OXyHIA>
 <xmx:ozbEaWQ5hxpyBQE83J1bYq1nF1FR6MiRG0F_zZ1Jsifz4HrajFXborCX>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 15:25:21 -0400 (EDT)
Date: Wed, 25 Mar 2026 20:25:17 +0100
From: Janne Grunau <j@jannau.net>
To: Dave Airlie <airlied@gmail.com>
Cc: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH v5 00/11] Support repeated mappings in GPUVM and Panthor
Message-ID: <20260325192517.GB2137845@robin.jannau.net>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <CAPM=9ty41ehnPCuiwHJGtRsnrdoOL0w=hpxnA_Fi3YDo+=6dfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9ty41ehnPCuiwHJGtRsnrdoOL0w=hpxnA_Fi3YDo+=6dfA@mail.gmail.com>
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

On Wed, Mar 25, 2026 at 06:51:55AM +1000, Dave Airlie wrote:
> On Sat, 14 Mar 2026 at 01:19, Adrián Larumbe
> <adrian.larumbe@collabora.com> wrote:
> >
> > This patch series adds OP_MAP_REPEAT flag, which lets the user map a BO
> > region over an address range repeatedly with just one map operation.
> >
> > Sparse resources in the Vulkan API let the user leave regions of a
> > resource unmapped (from the API perspective.) Accesses to such regions
> > must not result in program termination, but loads produce undefined
> > values.
> >
> > To implement this feature on Mali hardware, Vulkan sparse unmap is
> > implemented by mapping the specified region to a "dummy bo" so that the
> > accesses do not fault. A newly created sparse resource starts off
> > unmapped, and therefore also has to be mapped to the "dummy bo".  This
> > "dummy bo" is small (a page size) in comparison to the sizes of va
> > ranges that we might want to map to it, and a large number of vm_bind
> > ops can be necessary. For example, if the user were to create a
> > 100e6-byte sparse resident resource, we'd have to poke VM_BIND with
> > ceil(100e6/0x1000)=24415 map operations.
> 
> So other drivers pass a NULL (xe) operation to their VM BIND which
> then goes into the kernel and is handled in the backend to write the
> special sparse PT entry.

Other drivers (asahi) have repeated repeated mapping of a single page
baked in their UAPI, see DRM_ASAHI_BIND_SINGLE_PAGE.
The out of tree downstream driver uses an earlier version of the DRM
gpuvm changes to support DRM_ASAHI_BIND_SINGLE_PAGE.
The upstream mesa driver uses this to implement Vulkan sparse resources.

> Can't you just do the same thing in the driver backend, have a dummy
> bo allocated in the kernel and map the pages to it when you see a NULL
> mapping,
> 
> or does this mess up some accounting or refcounts?

I suppose this might have worked as well. I don't know what led to the
asahi UAPI but I suspect leaving things up to user-space manage to
manage was one goal.

Janne
