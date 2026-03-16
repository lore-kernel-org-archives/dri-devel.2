Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD48FFB5E85
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 23:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E1310E405;
	Mon, 16 Mar 2026 23:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="gab543sx";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNpdCKIw";
	dkim-atps=neutral
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD9E10E3FF;
 Mon, 16 Mar 2026 23:08:21 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F137A7A0249;
 Mon, 16 Mar 2026 19:08:19 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-04.internal (MEProxy); Mon, 16 Mar 2026 19:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1773702499;
 x=1773788899; bh=FS/ilBAqOlozs8Bd/bm+iyPoa3zvHZB0UfD3VtFZbsY=; b=
 gab543sxJIV+7F1hIIuHG51i2tzPFhjjUgXRUTGTJayF6DAIWabJjdTGmLIOuHAI
 q4dATT45GwtqouAn9HAKXcIMCU82wwM4dFSFthfVLkP4UQUFaIrg6eoQLUEjQG6d
 d2i9o8/VMhFj5ufsk83sN/PbHEunxgk4catLF2saN2ozFUBd1OueVYkP3rH8Etl7
 wO3n49QD2T72y9Hf+6VZhe7otBWg3AIOrmv6Y+OF6Ae9Bh/NQSCV49aLDSeH7pIc
 8Qc/vOEuF8zPfGNenSyiaYhkmkJD/BMFYN1lfEEWC0+Ya+hKZR4a5APa0K67vDAP
 KCqVuHaZnTcFMuhqoJFqzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773702499; x=
 1773788899; bh=FS/ilBAqOlozs8Bd/bm+iyPoa3zvHZB0UfD3VtFZbsY=; b=r
 NpdCKIwMrScTBCW8ECUP4pijqHupg4ZmnMOE+0PG5cB+xBgoaRCplyMVJUhSIxPf
 +/fh0gWAlb9OvllXZd3umhKwK8EVKPNUy/E3SXp6Rq4/Uyc7/iboAt4M7X7vKWO5
 XjKcQb1SiGU5WYkd7YVlC4l8PHvkAJE37Asm1TaLYhAMvsAzUg8dXxFT2FgA4syR
 9CKbRd1v2/C31V8gegU7qB9t7wyu4DPy8VDh0yE5AbZAnEfOHYP0BAo0NagYsxYm
 /YcdKdkiKCIy6AK+blZhpJ/Wy9Xqi3NxU9hhuZ5Q4nt1CL2TUOJb4eW6HS6SSuew
 gQ86N+nJOtNKzyq2smgmA==
X-ME-Sender: <xms:Yo24aYV8_uwV9JrQO5_gQhnNLXaaL_TOPVyvBHdhjPSCTiKhQhZAkQ>
 <xme:Yo24aXZWZYhz-GUo4O2TzXB1DgISrhOtlcSVcjpKL9VNbXVW5ltAjGss_gt45i1Da
 t0iupXOQVmv2N6-toyIJY-_4_ED7RwB6nDlQiCa67Btl1zQ0IyuHPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
 uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
 hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
 necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
 phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhgrse
 hffhiflhhlrdgthhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhr
 tghpthhtohepthhvrhhtkhhordhurhhsuhhlihhnsehighgrlhhirgdrtghomhdprhgtph
 htthhopegunhihrghnvghshhifrghrrdgshhgruggrnhgvsehinhhtvghlrdgtohhmpdhr
 tghpthhtohepmhgrthhthhgvfidrsghrohhsthesihhnthgvlhdrtghomhdprhgtphhtth
 hopehmrghtthhhvgifrdgurdhrohhpvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohep
 nhhirhgrnhhjrghnrgdrvhhishhhfigrnhgrthhhrghpuhhrrgesihhnthgvlhdrtghomh
 dprhgtphhtthhopehrrggrghdrjhgruggrvhesihhnthgvlhdrtghomhdprhgtphhtthho
 pehrohgurhhighhordhvihhvihesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:Yo24aezX2InkbblANVjUsBdb9gzDryNQ3ARhlSIM3FYcRHg4RzwkMQ>
 <xmx:Yo24aVc14QhhYQnDJLcQ2dJWme5lo2TSUJQ6fYVhLz12G90xTeGvBA>
 <xmx:Yo24aUJePPjbT5KYGLeTqUIRPyNmIEaz7c0DmpgJh9R19QQF30dRCw>
 <xmx:Yo24ae1z6O22mZP48TRUnLOeOhbdyZXz1GOpjbNQ8RI0No15GmEtXw>
 <xmx:Y424aQFOr0JrqoQIlMtLgXDZ50ZVN4JqLWdQlYjc4FXY3k66xf58ySOe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 256D770006A; Mon, 16 Mar 2026 19:08:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A2G_ZUb3Hlmw
Date: Tue, 17 Mar 2026 00:07:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Matt Roper" <matthew.d.roper@intel.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Matthew Brost" <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>,
 "Dnyaneshwar Bhadane" <dnyaneshwar.bhadane@intel.com>,
 "Lucas De Marchi" <demarchi@kernel.org>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Umesh Nerlige Ramappa" <umesh.nerlige.ramappa@intel.com>,
 "Raag Jadav" <raag.jadav@intel.com>,
 "Niranjana Vishwanathapura" <niranjana.vishwanathapura@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-Id: <e46c3681-6f5f-4a41-b5bf-72627b4ec87a@app.fastmail.com>
In-Reply-To: <20260316225118.GD2729713@mdroper-desk1.amr.corp.intel.com>
References: <20260316224357.658520-1-arnd@kernel.org>
 <20260316225118.GD2729713@mdroper-desk1.amr.corp.intel.com>
Subject: Re: [PATCH] drm/xe: use %z format string for ptrdiff_t
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

On Mon, Mar 16, 2026, at 23:51, Matt Roper wrote:
> On Mon, Mar 16, 2026 at 11:43:46PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> ptrdiff_t, size_t and long are the same size on all supported architectures,
>> but gcc requires the use of the %zx modifier instead of %lx. On 32-bit
>
> Nathan Chancellor just sent a fix here:
>
> https://lore.kernel.org/all/20260316-drm-xe-fix-32-bit-wformat-ptrdiff-v1-1-0108b10b2b6b@kernel.org/
>
> His solution uses %tx rather than %zx, which according to
> Documentation/core-api/printk-formats.rst sounds like it's probably the
> most accurate format string for this case?
>

Right, Nathan's version is correct. I wasn't aware that size_t
and ptrdiff_t have different modifiers.

      Arnd
