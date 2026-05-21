Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867C6CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66A210F26A;
	Thu, 21 May 2026 08:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="NaJGIJ5R";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCNRQz/f";
	dkim-atps=neutral
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8B710F26A
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:14 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5CF0F7A00DD;
 Thu, 21 May 2026 04:37:13 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 04:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1779352633;
 x=1779439033; bh=KoXfksjtOuPpWflfbfNiTBgddSHnoYBcPCXTP9uDtV4=; b=
 NaJGIJ5R4ZFNjpy4Ysa0nIy/ayo6O4DLvlvpRmwNpwvW37LA3wn5LiTpRWdgSAYW
 mNOKRm90DrN8PXM+KlXeg5hOpie52Dxd8vGMYpPMd2zgH4oVPgNbcEPTjcLbtO6c
 sxhC2o3N+YtdQJunKLjEBK3SMh+NBNpi95fsLs9QGGfpkFMrwHO5EiW3US3QJNGw
 MAc89/0966xcttBv44GP80m3hczFj8Zg9l507/E7Kv9hWsPKyrIPTeX3j3Jv1lhR
 d5h7jM0mtacPFD8FBQeDExUZtwuElZ2TIzr6qtvG2OutgEEhUVHry1I92R/dvhEC
 mxsIVyJh+us9iuz6L2hqRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779352633; x=1779439033; bh=K
 oXfksjtOuPpWflfbfNiTBgddSHnoYBcPCXTP9uDtV4=; b=RCNRQz/fDmC5peiWe
 BSOv39qMRsz+8c3FjTVVuXfImD8LXPl3TRj51QQePETtZSxGZQNal2cQFDSnHOaj
 kQIl8QH038UyLPwij0FVdHG6iSSYJNSw5B98NwBaRWZ9ARzB39uvg4WmyXOI02+Y
 MEZdQbT0N230DCvLNS9LzvJsj42QmnlcQcfA60C+Wcu9Z/2r0aMvpUsoTff55Drk
 QDqbKT/sgL6agYpWHe3EWt4cxCdLRwcSGTtJ+tKyDUTeYJIcl0JydBFey9M3quNy
 IHi4BxVk4O4nkE+4iz/SQwtqUCNykHUO9dPvwvRbm4JZyY1Fd4lm58zxVUoktNX6
 biAbw==
X-ME-Sender: <xms:OcQOaiZ4ke0SUmMzOOwXWzuj3v5b2G4trNwKMKGlnHIJW4VduhrYbA>
 <xme:OcQOagMgeWtc3ORyNpQCNSlDXnEa64gfkr_yxszftITHLbbvhecaIzJy9fw1Qisr7
 TidICY-YHjfCvVuM7nBw4VLH4M1nIxizAwjnRW5bk2D-YXVHqgLBiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
 uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
 hnpefhkeeltdfffefhgffhteetheeuhffgteeghfdtueefudeuleetgfehtdejieffhfen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
 esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopegvrhhrohhrvdejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrrg
 hunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhi
 shhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnuhigqdhfsh
 guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OcQOatCb_KvCsp1JNvodEgD1S4SU5ccdMD2VcwIxoyt1_CetIS1JmA>
 <xmx:OcQOam-F4YDHluzfP2tPLDLbONCTKQ1nk7ayx2UvvmX3mIREAQSKZQ>
 <xmx:OcQOasGdJkoajx8bcBjdgdkRqEYLUjvVUNpLbgvdAFPMIYmH9ier5g>
 <xmx:OcQOasN3RSuARrxHN8jwmjcOG2LjVkhXqgJEuo2pI9vCVlvbOtSKcA>
 <xmx:OcQOalw21y-8nNCID-81TwSOgh5bnDYj1FHc5pdPOQT98i7P_bP14-z5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id EBB59182007A; Thu, 21 May 2026 04:37:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Aw18F5Y_n0hN
Date: Thu, 21 May 2026 10:36:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <error27@gmail.com>, linux-fsdevel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Christian Brauner" <brauner@kernel.org>
Message-Id: <d82abcde-91e8-4eba-83a3-1e86bd6d80b1@app.fastmail.com>
In-Reply-To: <ag6vwpcCBN_VC1dm@stanley.mountain>
References: <ag6vwpcCBN_VC1dm@stanley.mountain>
Subject: Re: FOP_UNSIGNED_OFFSET abuse
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

On Thu, May 21, 2026, at 09:09, Dan Carpenter wrote:
> Is there a point to FOP_UNSIGNED_OFFSET now that everyone is on 64bit?
> I thought the flag was for back in the day where we it was a huge deal
> to access 4GB instead of 2GB.
>
> It's mostly used in DRM.  drm_open_helper() forces you to set the flag
> but drm_read() ignores the offset so I don't understand the point of
> this.

As far as I understand it, this is needed specifically for
character devices with an mmap() file operation that encodes
information in the high offset bits, see be83bbf80682 ("mmap:
introduce sane default mmap limits").

For /dev/kmem, this is is needed to access the actual kernel
memory on architectures that map it to negative addresses,
and this one actually does llseek/read/write up to U64_MAX,
which would be useful on 32-bit compat tasks reading 64-bit
kernel memory, and we could probably just not do that.

For the mmap() interface, I see that things are a bit messy
in multiple ways:

- DRM drivers on 32-bit kernels need this to mmap() GEM
  buffer objects that have a file offset just above
  ULONG_MAX, which is the limit in file_mmap_size_max()
  for character devices. 
  As you pointed out, llseek/read/write does not have this
  limit.

- mmap2() can never map up to ULLONG_MAX even with the flag,
  but is in practice limited to 2^44 (ULONG_MAX << 12)
  when FOP_UNSIGNED_OFFSET is set.

- compat_mmap() checks against the 64-bit MAX_LFS_FILESIZE
  and ULONG_MAX in file_mmap_ok(), so it's actually able
  to map beyond these limits. I suppose this is not a
  bug itself, but is unexpected.

- MAX_LFS_FILESIZE itself is defined as
  "((loff_t)ULONG_MAX << PAGE_SHIFT)" on 32-bit systems,
  but mmap2() actually uses a fixed 12 bit shift
  rather than PAGE_SHIFT on most architectures with
  a compile-time page size choice.

       Arnd
